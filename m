Return-Path: <linux-kernel+bounces-215837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2629097B4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 12:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A03191C20DA2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A15381C2;
	Sat, 15 Jun 2024 10:41:27 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C23C2C184
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718448086; cv=none; b=KMJVDpmcGMMXhQIVKIrn0AyLZJRbrJxzj4uKHhr7MdGUJQekRF9RGmRsiqi/7gpj8TkPu553DgZp2jfa3exBEe+VeqFCeFPRq9C8p1bKttttmOCOqK6umbWf6KsETbxvjpGmY2hNjv58q/HcMQrvgUgsc74WlaU4eq3baHEYKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718448086; c=relaxed/simple;
	bh=2L/UxNs+JPfdY3+lBiqtpmTCmTPryH5e6T5YlMjPlrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OnYlzqdE/ji6mIKgLcDQjexcW99RcdZN3Uc+CtsKVpJUR+CSzw/aA2y0bqDwn6y++xJ3w3e+BXy/koLHp7csx02zYuWbIGBHSYnpMk3qSkk4awYWxdNM18JjT28StAOliKJzhcXriQ/LvENMCTBRId6sHaam9Ct6XH6dAHSNGoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.228])
	by sina.com (172.16.235.24) with ESMTP
	id 666D6FA40000727C; Sat, 15 Jun 2024 18:40:39 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 31296845089150
X-SMAIL-UIID: 86AA73506A32429EADD5C27462498E18-20240615-184039-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
Date: Sat, 15 Jun 2024 16:33:50 +0800
Message-Id: <20240615083350.977-1-hdanton@sina.com>
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
@@ -952,7 +952,11 @@ static int do_dentry_open(struct file *f
 	if (!open)
 		open = f->f_op->open;
 	if (open) {
+		error = -ENODEV;
+		if (!atomic_inc_not_zero(&inode->i_count))
+			goto cleanup_all;
 		error = open(inode, f);
+		iput(inode);
 		if (error)
 			goto cleanup_all;
 	}
--

