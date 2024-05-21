Return-Path: <linux-kernel+bounces-184475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2A68CA733
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 06:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BE5281DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6631EA85;
	Tue, 21 May 2024 04:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tJx6ToEV"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB43D556
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716264178; cv=none; b=l7my8olzSLwGPdhbQ8a5B+YWNh1gRlnxP8Zl5SwwXxtBQicMxirrFUYCe2RJIMxdZSuUartsGO8X6l4VNmyad8ek3+BVqhIFxX+o0Dp+nqGPEzW381ILogujKmdK/DnOjWPua1YEFLMUTr8JbPKAQgT2G5DyCKbqSgSGbdrvPbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716264178; c=relaxed/simple;
	bh=CWj/6bR4BbPGl9J0wGJExs/1VriTTxHSODfpnk/QI6U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=iazox/CH2CqW9omBdQ0nA1C9O+EVGWzXAc8NRgL55dGC0rUyIL1z+2pxSKmZ8iYfEt5mkWv2qVETNyv2LHpzOJSsm2ou0RtNOX0mdR7pk3hOcqDRxQBjANDqXJXq7PBwwzBzxCJXgTYixz45annL+aG/EiLydLbmLx3zZ/s/6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tJx6ToEV; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716264165; bh=2ZvdINK6wvHC0lJ0GdyeahipLn/enAa0n7oiObPGLFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tJx6ToEViqNVOV4cliPihXGLpGUnqBr5DSOJSltRnOE6fvz3t0s9veZg/7p6nhtu+
	 A4VZ2VHz90F+CZe1RZhZlQLRS4tW4wcDDpz1zUH9SoqA7a/ALXSA1XmHYsGa7DJzXT
	 lzpn1MeuNiVtn/ynnUvFKl+5qNZYJsh22xqwdD50=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id B582643F; Tue, 21 May 2024 11:45:24 +0800
X-QQ-mid: xmsmtpt1716263124tdzm6zjxp
Message-ID: <tencent_FFE5365E9608362A4B7474FF76E567C03C09@qq.com>
X-QQ-XMAILINFO: MQspGcEBiT+RrGdw47aRNAbM3eFZnTpwqqLHvwcTgCpr6Lqu5VVixyWa9MaRii
	 +iqOMyb0qfaL4Smaj3FZ0cU0icvwEVvmEDWQ98s6R1VYEe0QLxPOwCQvsg3EHY6NYcQv1YPlGMTV
	 RcmjUnrbRCCpaIT/6Gv6Yo2F6ZHMvcX257y6qzP0ioLpMWz4X5XSNyxMkU0C00FUjuRwt63kwV4s
	 CCSPLHPNKa7e8kGBtyqnPxOmd7+ly0oN6ft1NFCaMFiPZuLSZhR+6Jr7aeDYxEpFSz/GQMiuJlvN
	 ut937rxnz+OquIVBAAf1gy1Fy+OdQqm+F0PgFeSH3K7wv1/VNYV2sMIuljErEL3ftwN/gW2IQcXq
	 jqAfzQ5ASqSVgUAjWbj/mTAJefd6pndqVvzVjdCxFcc+O529YCSFk+Mtaly7IX8FhPzYS7nMgBtI
	 wxrirGe97DruIaILHGny3BuDJqOc5eAEnqJkoX1qtkuDB2j5k8mp8Z1zlQdHt07+P8nm96xRDb4U
	 hLuDmZVZbNJHo7tVystM3jxYDsW1vas6DOJRMk+a95t/kKgYvoW99SibUZTK7MX5CvfWW3L5HIca
	 VtXCVQx2rYDJyYLNL/hh/UHOJUDoGg22sRMMnX29He4STkCDJ1wNg4yGWCjT3eb+5rzL97tk+LB/
	 TQ/047dmrIr5oBqAtuw6Jjy1cUpX/YqjhhnNjV+AhXWb/eP2yZse7R4DZUONlgpSDb+4gycmdxBb
	 FIyCvlvmSc6q0oqrfvZ/5rlWoUVUf2ATVlFYYjX1Y4lXG3WkvLqe1ZXW9s0IueglVjihkhzTe4SS
	 5L8B9nBxHOIp7MjDNdLU2j12yEsLAetcYf949DyMzr9AFfhdsKnt7CmqvMUgJAl20uanacYfxeso
	 QpSIlBmXE5QgWfOfiqTdo/Og/tKr1uHMKM2dAwQR2oQ+ygsKrMouUwS060iIEc9ovByLp1mqoHZR
	 DU6D2tZTo=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in copy_name
Date: Tue, 21 May 2024 11:45:24 +0800
X-OQ-MSGID: <20240521034524.416086-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000037162f0618b6fefb@google.com>
References: <00000000000037162f0618b6fefb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uiv in copy_name

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git a5131c3fdf26

diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 73342c925a4b..8e97df12375d 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -234,6 +234,7 @@ int hfsplus_uni2asc(struct super_block *sb,
 		}
 done:
 		res = nls->uni2char(cc, op, len);
+		printk("res: %d, cc: %d, op:%p, len: %d, ustrlen: %d, %s\n", res, cc, op, len, ustrlen, __func__);
 		if (res < 0) {
 			if (res == -ENAMETOOLONG)
 				goto out;
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 9c9ff6b8c6f7..cac1cca468d8 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -698,7 +698,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 		return err;
 	}
 
-	strbuf = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
+	strbuf = kzalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
 			XATTR_MAC_OSX_PREFIX_LEN + 1, GFP_KERNEL);
 	if (!strbuf) {
 		res = -ENOMEM;
@@ -733,6 +733,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 			goto end_listxattr;
 
 		xattr_name_len = NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN;
+		printk("sb: %p, xnl: %d, %s\n", strbuf, xattr_name_len, __func__);
 		if (hfsplus_uni2asc(inode->i_sb,
 			(const struct hfsplus_unistr *)&fd.key->attr.key_name,
 					strbuf, &xattr_name_len)) {
@@ -741,6 +742,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 			goto end_listxattr;
 		}
 
+		printk("s:%d, buf:%p, res:%d, sb: %s, xnl: %d, %s\n", size, buffer, res, strbuf, xattr_name_len, __func__);
 		if (!buffer || !size) {
 			if (can_list(strbuf))
 				res += name_len(strbuf, xattr_name_len);


