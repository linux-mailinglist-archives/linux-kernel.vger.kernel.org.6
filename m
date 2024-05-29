Return-Path: <linux-kernel+bounces-193264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940B18D2967
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 02:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56F91C237D7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B40223AD;
	Wed, 29 May 2024 00:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="uk3Btyg1"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507248F4A
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 00:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716941960; cv=none; b=gXF2IC8L89Aj7D8mtQEPynGhkGwG05sX6t8Ldtk4Nxzl/GCusOlDoRtvYD2p7VE2f7ID7mDS5WgAqMNk3cfWhxuROYXINJIR0y9IcAM2J4tkDkdmhQx+Md5XDt4QgQe1PmyQzbBEg/JacaQmEQFtEHOb8/v80P6OOIbcB9Hcwt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716941960; c=relaxed/simple;
	bh=/Tqsr3Gc+FfdW0jp09mx1ExYDAGM9Ops8PibRaOwA5g=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=naD7buhqDBUf4CoT52sAR8LyIkvPd1RRlLVYdXSgwRQQ2KfkTPEyb+14RIJnHdgOzqeFcc0XNo1BO2yytBEDp+3iArwhtsutxvXT5PxhJvcXSQRpx/l0a6uzMcJwUHqSj91Zadm91fVYbj0vX9wfm14yPf1TlQq5P06qlDwSaB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=uk3Btyg1; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716941651; bh=nZCXPT0/ehA5JhmGy/pvgDBw0kwQi2ODWqgsPyWBQRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uk3Btyg1VwTj91Z5zLfsHIMgK+bF3G1mJtrqSFPp4junyk9z5XuldLqhfGZt5alIN
	 Y1Fuh4vbrJXGYWq9Hy2erdKerDr8WpBl6+Ne9pDIsasLP+s5SlJ/E3p9wzP9zmrIOD
	 PocUa3NJB302wHGWdIHqMjhh1NgmpGW+P6u2HkBU=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 389A0EB2; Wed, 29 May 2024 08:14:09 +0800
X-QQ-mid: xmsmtpt1716941649tunmp3ak7
Message-ID: <tencent_A00DB025D08D8E12005DA45DED1965CF9C07@qq.com>
X-QQ-XMAILINFO: MFdGPHhuqhNojI959x8ksgEKiQBcEVpfQ8apINpWkgnb0amz14+ScScxmPww6a
	 4kLNPfr1VSzzvwQ1/07fPEAUys8DN/XO6nFbdvPInkoIvOt6B8eD655FbiUpu2DkxczEUKcos43c
	 r8bUBWestXULFwAXK6HVq97YgefvZydTVeHs91myN2boNmdFd8+zriNJoGI3OGKB5US7XCkvaNxI
	 cVgG3ESN5dMl8gcYviR+maj7CaBWeNdmI1s998ZHplWLObI5Nmnn87yCj440/TCe3emoGJV0mgY+
	 ShNfW3zuYe7wTi3Md7jW2Gkuaw0EbkDnAmXfMy7yPpz+Cmt/N+8NkOedhc4uXit00D1y3Yp+Rzbr
	 RhceOkE7qvm7zj65gQpuzapkmabUNtExftrI0ufyMdBinCDKmq23B3raY3AaQAm444xrO/8xPAtX
	 vzR/vw06iWtK54716KZPrDS1xzcTJLYxngiOWAaI5CgZPsHxrDH/uvJQEYVxcKSzLNbbpSm5O+ku
	 m8L6OnaRuLsQB7jkU3ur6Ft0Xd26p9gZOJ9yOCSdGEKNJwm7rAcNiItAMRrBhaoi5wB0WhCX8bAe
	 b+fL3lfoXYW47+kxr/AoZh6ZcJxPyufNGLgZqkx4xMh7uR2eX4RUCLYGfMCVVSEN8y3yZ9Xd9dDb
	 /v6ouuUsqud2Suc3ZOzCQIeTzXm8I1xHlhDblzTakFDU998GuDjjR5C0IDq8rOIz2RG6o/9h5Dsw
	 BsuMg2sO9f24l8wkM16KxtP2BxWJBcbXAM/U+NJ8rZ90KgGrCqfkp8Q1AVG8q9Zx8f++D9Z1DVNK
	 o8iUsD8ySEfBeJOx9vPl7sAdjo5uW+hGXLeB7rxhrGHChsG1rfMxF6mu+6Quc0R2fkU7FIkcoPox
	 9A+QSMZlylPXnJfHw5wYC+ghc2q9+lKgstUwiwKJ2g2KxoWWLES45eO7G6HJ4roA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+fe42a669c87e4a980051@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] WARNING in ext4_xattr_inode_lookup_create
Date: Wed, 29 May 2024 08:14:09 +0800
X-OQ-MSGID: <20240529001408.2083655-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000002b03350619853096@google.com>
References: <0000000000002b03350619853096@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test wr in ext4_xattr_inode_lookup_create

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 8f6a15f095a6

diff --git a/fs/dcache.c b/fs/dcache.c
index 407095188f83..e2f1a3f92ce9 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1551,8 +1551,8 @@ void shrink_dcache_for_umount(struct super_block *sb)
 	WARN(down_read_trylock(&sb->s_umount), "s_umount should've been locked");
 
 	dentry = sb->s_root;
-	sb->s_root = NULL;
 	do_one_tree(dentry);
+	sb->s_root = NULL;
 
 	while (!hlist_bl_empty(&sb->s_roots)) {
 		dentry = dget(hlist_bl_entry(hlist_bl_first(&sb->s_roots), struct dentry, d_hash));


