Return-Path: <linux-kernel+bounces-213066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F656906A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C8D1C24353
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855891428EE;
	Thu, 13 Jun 2024 10:58:08 +0000 (UTC)
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4AE13D534
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276288; cv=none; b=K3+HygPMhJ+zc0iZm+4WZwV2up+A/M2sc6k0WFAVpopKIr7yAFfa5DFbahtFXiI7XoXJyLmltYP8NoH1GeKHKKB1+iR2BcPS1V/vaihx8lmgC+xSN8oCsO4/hixoNkOKN7cPnAv5rvsL0/7HUWmhCUCktQyfIEpVD5uryebwOjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276288; c=relaxed/simple;
	bh=8/8N98dtnuGnocrm29FSFaydJECYzafJ/9Ktn7njb+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AsZj9vD08UMIPYWdOcdrZcccNd8U9QozouSaHOsjFXvqYCGBcbohCm7R9GnrKLmUWKXf0/7pX9ZeANm5UAbLZCpwKpshy2TNnLK1WCaK7xACG/Mer6PQvRILU+tY9gDisovvEPdLjV/bdY8D3VUicnygHvy7Ri7g/Ii9E+TVqFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.164])
	by sina.com (172.16.235.25) with ESMTP
	id 666AD0AE00007EA1; Thu, 13 Jun 2024 18:57:53 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4686634210564
X-SMAIL-UIID: 56118CC1132A43D5AEE54EB72863AB41-20240613-185753-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] [mm?] KASAN: slab-use-after-free Read in lru_add_fn
Date: Thu, 13 Jun 2024 18:57:41 +0800
Message-Id: <20240613105741.2380-1-hdanton@sina.com>
In-Reply-To: <000000000000cae276061aa12d5e@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Jun 2024 11:10:20 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    83a7eefedc9b Linux 6.10-rc3
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c645e2980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/fs/read_write.c
+++ y/fs/read_write.c
@@ -570,6 +570,7 @@ EXPORT_SYMBOL(kernel_write);
 ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_t *pos)
 {
 	ssize_t ret;
+	struct super_block *sb;
 
 	if (!(file->f_mode & FMODE_WRITE))
 		return -EBADF;
@@ -583,6 +584,9 @@ ssize_t vfs_write(struct file *file, con
 		return ret;
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
+	sb = file_inode(file)->i_sb;
+	if (!down_read_trylock(&sb->s_umount))
+		return -EINVAL;
 	file_start_write(file);
 	if (file->f_op->write)
 		ret = file->f_op->write(file, buf, count, pos);
@@ -596,6 +600,7 @@ ssize_t vfs_write(struct file *file, con
 	}
 	inc_syscw(current);
 	file_end_write(file);
+	up_read(&sb->s_umount);
 	return ret;
 }
 
--

