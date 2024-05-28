Return-Path: <linux-kernel+bounces-193215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAFD8D2874
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E1728A043
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A1713E8AF;
	Tue, 28 May 2024 22:59:30 +0000 (UTC)
Received: from smtp134-24.sina.com.cn (smtp134-24.sina.com.cn [180.149.134.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532B013E883
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716937170; cv=none; b=Az0hLuTxIA6TvMoktwnpTmgQLkTuQk3hQ4VPHCxgAiLfo/RnvAEbLShOoQbpfCNxITTd0aa6UQyzKyc9kEQz8bm3/6cNeHOpWnpcGqSvuPvOiMZFtkqxrPoLd5wJzDQcEtY9wslhJZ5wbWK2Mw1GRGW+ws2kVAedRrXL+XajUrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716937170; c=relaxed/simple;
	bh=NqJ/UMQkZGlKTIONR9WfxT2XuYsnYeOIUcFIMUXRbvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dsdOBE4zHzGfA6MFC3EA3jLPuVPVjy5fAvJfzgAdgB2aBM2VjbvtJKtnJztrrEhd1+/Xz9WeAJwj2J0QapkJnfi2ProXIuH0G6L75ZCnim2u4hdRTZhxD92igzEpPenvJ21rEIYt31h9+dZDrUpZmRYez44l1qjsFRR7HZtF/h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.5])
	by sina.com (10.185.250.21) with ESMTP
	id 6656619F00004699; Tue, 29 May 2024 06:58:42 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1510693408344
X-SMAIL-UIID: 7A527889F08F47F487945A12D61DA18F-20240529-065842-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
Date: Wed, 29 May 2024 06:58:29 +0800
Message-Id: <20240528225829.2818-1-hdanton@sina.com>
In-Reply-To: <000000000000f386f90616fea5ef@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/fs/open.c
+++ y/fs/open.c
@@ -952,7 +952,13 @@ static int do_dentry_open(struct file *f
 	if (!open)
 		open = f->f_op->open;
 	if (open) {
+		struct super_block *sb = inode->i_sb;
+
+		error = -ENODEV;
+		if (!super_trylock_shared(sb))
+			goto cleanup_all;
 		error = open(inode, f);
+		up_read(&sb->s_umount);
 		if (error)
 			goto cleanup_all;
 	}
--- x/fs/super.c
+++ y/fs/super.c
@@ -503,6 +503,7 @@ void deactivate_super(struct super_block
 {
 	if (!atomic_add_unless(&s->s_active, -1, 1)) {
 		__super_lock_excl(s);
+		s->s_flags |= SB_DYING;
 		deactivate_locked_super(s);
 	}
 }
--

