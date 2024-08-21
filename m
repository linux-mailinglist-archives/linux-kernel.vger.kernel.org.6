Return-Path: <linux-kernel+bounces-295242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AA99598FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EB52B230DF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF871CDA0B;
	Wed, 21 Aug 2024 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nkNKGtVl"
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3506C1CDA02
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233194; cv=none; b=szY3YqFCtXHkczjccwdSuPAoQkD9H56+6ZtU5CB9mExqtazrkOrIGViR5bSFIQBQS/oH9ZKP8Es5JSKdE0Mkfrf7znqMsQC3tWRSRsGw6AkhckaCkJHqpdQLf6cCVwnnRMaefrLeOIzG7Bn1KF7JKtEK3+PSvWaPM0vLCEsVgvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233194; c=relaxed/simple;
	bh=7RDSkDbUSVHdHCZdLw354ujHYNzBuxxUvkcR+pBjra8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=BnZjaktL0D86P3miPNECmA4oNJO0PkWFsxfrlYhLsSGSLQdcBgUvsi83ZNIHMK9jCO8yPazWVe9zT9t4n2hatrUkhAJeQLsyVCpIM+SRMoevrqXCQSttXS3EoiTqDDcExaeqt77N3nEz7YtaYGi1fe56BWjeSy7OsW7/FqUMC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=nkNKGtVl; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724232889; bh=Ak9IAycxnMLA1Yj1w/1DeyGyqp+Li9m+LQH270AVS44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nkNKGtVl/0VIALmCNAbG2nagAP4ZJSngk+VrsLtZSwfoE2gwhC66UP0pSofqad0UT
	 2R7txpYVDuWMYUWr72CdbYq5yQ+XeDNqBaIzzYcbAFK2bZE6kCGmcyBqtoHzQx++NA
	 hnyK3IPu0XE1mKSJIDDXeNLEu3b1l1yXRSiUHMFw=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 8AF016F6; Wed, 21 Aug 2024 17:34:47 +0800
X-QQ-mid: xmsmtpt1724232887thxdgf2z9
Message-ID: <tencent_51A2970236A44ACA743376A9662E3C833609@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieHkho6IlFVeaP+/7rnjA43oKEtF0JY26BcBWqIQN5hY0i6lh7B5
	 +8R3CT3gkSDjvOyi6Yu9IOqsfuLRPOzAHfIQP2hwaOVIc7nxLStiv25Jj2uRd1qDdSOouODYSLSE
	 NzDKmQUgZbtzoLgpZd9m9tBEwX3E4R92t7mjcpqhTWecbp9YTbLyT0AplxNOHtvsCGTMS2YJsEFf
	 rlsgsUyf8cX08tv6HlIWyocAMpSCQ8fu8SKPbDD6ZwwPPsTntVSFi7LKYHKNkYGceIb/9f4S0NkU
	 V50+tfHzm+aCL8QkGozL0AzZazXYOyle5gyUZPFLi16rp5gBTo+vCKz4QhXpwpMb9tKuhNLMukuR
	 iiErhHvkQV2uOxRDql/KrQQF8BVTWe5fu1tM8z+PyErr16ENK4SKKXuOJG1lAg3FdZ6yP1DkrGxc
	 Z3+v5zUhUIx7nqj0jc/2pOzLalgqjLm9ONPqAbHQAk/qn2LvD9vRPxO+yy4QQkWu0sO/16ShvfGX
	 hyp7ENjSY18qEILwyKpPZCXz3vSJnGvW/bTIb9+M02eQCGh5/1OrclRIQJ4p/JBjWOsr9skBneNo
	 h0nqUAPgnYTSWFOGG2ByKd6QZRCGrd3ZI/3I12vDs0BbMGy0BSeySS12w3kc6FrS+hacZ+Q9tfuR
	 3N5zK2c4E/z7rk8ckNtM3tXkBVhpkWaiOSV8ofUaZq2uVB+s7JpT6nYV/5E1mbxd7YMm71nZ2pjh
	 CNEoxijrRsZy0DRHroPrpH35oR9nlCt1ikq2WXrW2Abjtu1UVp9Hi9raxBaiWJeM0ACLZsQpKlm/
	 +VyzMFfsCVc9TE8HUzjt+B/J/zf25ra5qGTSUOM/z4VVOYggih0DJUWxnpplr0aJpj1s7ekbd9bQ
	 +eI/wMxlt6K2wNb81O0YNDSXqLIRERdFLUBP4PhynU3QvB1SkGofEnsMZLg+9jbb/1s43+sk5SXF
	 wN0SuDsS4dV3i95ag0RsswzbKW13Il
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d78497256d53041ee229@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_setattr
Date: Wed, 21 Aug 2024 17:34:47 +0800
X-OQ-MSGID: <20240821093446.465338-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <000000000000ae358c06202ca726@google.com>
References: <000000000000ae358c06202ca726@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

use trylock to replace

#syz test: upstream 521b1e7f4cf0

diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
index 62464d194da3..f60e3178fe74 100644
--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -363,7 +363,8 @@ int ocfs2_init_acl(handle_t *handle,
 
 	if (!S_ISLNK(inode->i_mode)) {
 		if (osb->s_mount_opt & OCFS2_MOUNT_POSIX_ACL) {
-			down_read(&OCFS2_I(dir)->ip_xattr_sem);
+			if (!down_read_trylock(&OCFS2_I(dir)->ip_xattr_sem))
+				return -EBUSY;
 			acl = ocfs2_get_acl_nolock(dir, ACL_TYPE_DEFAULT,
 						   dir_bh);
 			up_read(&OCFS2_I(dir)->ip_xattr_sem);


