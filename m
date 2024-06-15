Return-Path: <linux-kernel+bounces-215732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5271A909665
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4721C218BB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 06:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8470C168BE;
	Sat, 15 Jun 2024 06:48:47 +0000 (UTC)
Received: from smtp134-33.sina.com.cn (smtp134-33.sina.com.cn [180.149.134.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F8EDDBE
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 06:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718434127; cv=none; b=e1Te5i+DCcTlVK1T7BClxzbPzThFChhjYbrlwQXzDzAaTTriW9I5vCE9cQi3Kmce4YlyWMVT1nD2hAjhrGCMIQHtXaxwSHaCRxAC4NkIfMLr0FqvbAOK5L5M3pVrdOLdOLxXVL4n0WmiBo6nBW1xFi0jkiBPaS57EHm2cvIe9Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718434127; c=relaxed/simple;
	bh=VCqHrKLRo7upK5Vo2G01ygKx2d1eckndZ0nekF0lCoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=by7Oirl89065tJZgTTgaucaVq/tpg3UduRpX6gHFD0fUv3t6uKXTKubkhawwNURFzklCHW9C15rt5lwgJF563zUdwn6fPXFTqD7ohywP7VsxfG7h22QiCA6ZYHpxtxewm3mF55C5KEs4FOuRua5g3qsKpdJX12A/bIvBx46rW5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.228])
	by sina.com (10.185.250.21) with ESMTP
	id 666D3919000012C2; Sat, 15 Jun 2024 14:47:56 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2166303408544
X-SMAIL-UIID: DB5260639031462D90B6A8AA36523E06-20240615-144756-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
Date: Sat, 15 Jun 2024 14:47:46 +0800
Message-Id: <20240615064746.915-1-hdanton@sina.com>
In-Reply-To: <000000000000f386f90616fea5ef@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  83a7eefedc9b

--- x/fs/open.c
+++ y/fs/open.c
@@ -952,7 +952,18 @@ static int do_dentry_open(struct file *f
 	if (!open)
 		open = f->f_op->open;
 	if (open) {
+		struct super_block *sb = inode->i_sb;
+
+		error = -EINVAL;
+		for (;;) {
+			int a = atomic_read(&sb->s_active);
+			if (a < 1)
+				goto cleanup_all;
+			if (a == atomic_cmpxchg(&sb->s_active, a, a+1))
+				break;
+		}
 		error = open(inode, f);
+		deactivate_super(sb);
 		if (error)
 			goto cleanup_all;
 	}
--

