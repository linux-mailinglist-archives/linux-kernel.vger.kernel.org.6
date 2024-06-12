Return-Path: <linux-kernel+bounces-211366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4F39050A8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213DC1F243F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC045168C3A;
	Wed, 12 Jun 2024 10:45:45 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4E2155329
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718189145; cv=none; b=BQTLHqNZlbGJn6sqzDD8Kd1I1NpxMZUoYe4Ih7NaTjHj/4m3w8uH4lzlAt9H75Lcqz5Jpf6Wx/ZtUy9jWko09HjvBzgJl2WFAFeErQbYt3LZu0YXuAIO6LXhrYKf+fAv/aifPv2/+9dN8+1iDMWw65IpMIqWl4N1n3ipSmyvCos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718189145; c=relaxed/simple;
	bh=+mQ7+8F7eCub5AETH4YlnwofaJeIjl8cgIbHv9ox1Ns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bE1HSt5KZAKY7tG+aZIypMmO8hyL0GOW8qVuhMCexAlz3Imq3HrM0oM8O03HF6ovKWufgyPmFoX+Nk4FXJbd/rA9AtokepYM/CP++3Y+JoFEGAe4ZTz79rJg7hvpLcMhgx6K503f95OpkG5byGel9AQMY8zY58iiO4rU5VWWpFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.94])
	by sina.com (172.16.235.24) with ESMTP
	id 66697C49000079FB; Wed, 12 Jun 2024 18:45:31 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 52827045088841
X-SMAIL-UIID: 793C01AB8E1F4AAF9D241D47517A0182-20240612-184531-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] [mm?] KASAN: slab-use-after-free Read in lru_add_fn
Date: Wed, 12 Jun 2024 18:45:20 +0800
Message-Id: <20240612104520.2217-1-hdanton@sina.com>
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
+++ y/fs/read_write.c	2024-06-12 18:38:40.826180800 +0800
@@ -583,6 +583,7 @@ ssize_t vfs_write(struct file *file, con
 		return ret;
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
+	ihold(file_inode(file));
 	file_start_write(file);
 	if (file->f_op->write)
 		ret = file->f_op->write(file, buf, count, pos);
@@ -596,6 +597,7 @@ ssize_t vfs_write(struct file *file, con
 	}
 	inc_syscw(current);
 	file_end_write(file);
+	iput(file_inode(file));
 	return ret;
 }
 
--

