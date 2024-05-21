Return-Path: <linux-kernel+bounces-184326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA97A8CA573
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A596B22265
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0F9441F;
	Tue, 21 May 2024 00:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="YDou9ENg"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4769CC138
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 00:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716252535; cv=none; b=ILN5ZMbhu/RUmntQ4E7bRd6Edo59tDB774Ngx4sCPo0YfDLtznnmseFbDlZVyl6E++i/x8uIAAmWOHNYveDC2Z/qUS62VXB/mGzCN2m5+4fu5omlL/9KfzjIeGED8p9qYJRc1jO7BeRy2c8K1ChPhgenjfypg3GM5/1S1BaGGLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716252535; c=relaxed/simple;
	bh=efcj3Hyip1NAu2tx6CuN//FuoGz2GZMpOzo/Sa+VBaQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=cZlQotq2NYh/QGY0euJdXsRpM85G+dB4VFbFO7WqG5QYGjYZA+s2qV0D7ev8yBmZ8mEx4/WnhfNbyJykN+Im/86sng6gWbm8TF6aM7X9LdrBC7uKjFXWjEicUnTt7/F6hBTLiWARY8UxlbGGHfSkQGmkDxoORPTJnqdaAEgoppM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=YDou9ENg; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716252523; bh=q9m6cwSLC+E4maX3euugWbdlWqPF3A94KJl/1IXfWZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YDou9ENgT895rVb7ykvL3COupFu2f5eiH0X62EBxEV7mZDInZ8+PyqlclHd3GF65y
	 NKj8k9dkNDAFGrkd/R1mE2/DDvmrzEAhM1EGjOgNRhXSEG6qBJncTP/8SW7RQ5VX4h
	 laKRQvoFYrJxCAK6Jkv6d0dnlXTWIg16Bg/dHX4w=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id A1F276EA; Tue, 21 May 2024 08:40:31 +0800
X-QQ-mid: xmsmtpt1716252031tra5r5q97
Message-ID: <tencent_CAB0DDA2192E4FE30DA8A5990DFD923A5D07@qq.com>
X-QQ-XMAILINFO: NakEBl84zUNhZRiuk2BriCLgF8QeNs8f/dKaYTEkyGrwEqjAOIEfVxwN8aFHYK
	 6suIAFjeh/YKw/1JxfD5CLBlbhep9UDnBaHAUJfzNBWdt+lAvq4VhOCawrOv/kuoTh2/EvxdfFNP
	 02UdIaqGaEFJnjqero9Hbec0FNlxcMu1BjJHNllv87QDJKm/VVTBaAj2anFQadq1k9wdg5xcwLSp
	 6PyhsI35gC/JjwJm6H5LyuSy+rk+/nrLYI4Llb1Tbzsu0VWx0VhAZeDIVMPLnSN2mebDTJTeR+Qg
	 gcCxQdd65FLdtMda8tpd2VTunW2nCbLb5CMIan28q3lzAIa955lBF/Vp5liAfaZgt9Fz8iWAledy
	 nGB/T8YErvztZsDcMaxqUPNVeeFTOP2USZ6kMvvU5r+yNJ/B5v14NzV0SIC74hYNuGg2v9EF50mv
	 vzimFdeqxuSzSw5Bnywvay2O59PodhNoYgnuBLZGQJI3mP5D0hNimYFSf+Q/6Yf42tntlrFyy4IY
	 VE8oeoTewICCVPBKNU4Q6FgJdc2OH5gziXFbp2H1Nv85FMyn53MFJPBdFQFlQ+e+T51XICMZIMKX
	 dCMI+x0dJyDhEw9rqC2KxFBy2hhCIwPG/PPpFks7lPkh3dV5IBTiY7G5Z8VXjMRdN8nDLSArRzsM
	 mJ2WECrTFq4WSfXkCg7Jp0eQD6EWnE0ilqFDyxabBaAytb7AsgTvFq8TImcdOnj5+8tdsI4B85Zp
	 txwUwBGG4IKE2jDBVGf79dUMRWSk5e7/20/B7ozGnBUtUWuhoEaT/4PW6geaNTTytj3NdZ4kXjn1
	 NcfrjC3mlbdB+gHef2HNPB9uKyjdYjiQE90aDr4k7IwScg0IkAcEf7APZlXMgvJ2jRawCAdAbja4
	 LQwn+FxWbOoHY6l0L4HEGcl9r+X/kwULIuD1cvizBNXBNhgqps5dA=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in copy_name
Date: Tue, 21 May 2024 08:40:32 +0800
X-OQ-MSGID: <20240521004031.162277-2-eadavis@qq.com>
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
index 9c9ff6b8c6f7..a02903a929a6 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -733,14 +733,16 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 			goto end_listxattr;
 
 		xattr_name_len = NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN;
+		printk("1sb: %p, xnl: %d, %s\n", strbuf, xattr_name_len, __func__);
 		if (hfsplus_uni2asc(inode->i_sb,
 			(const struct hfsplus_unistr *)&fd.key->attr.key_name,
-					strbuf, &xattr_name_len)) {
+					strbuf, &xattr_name_len) || !xattr_name_len) {
 			pr_err("unicode conversion failed\n");
 			res = -EIO;
 			goto end_listxattr;
 		}
 
+		printk("3s:%d, buf:%p, res:%d, sb: %s, xnl: %d, %s\n", size, buffer, res, strbuf, xattr_name_len, __func__);
 		if (!buffer || !size) {
 			if (can_list(strbuf))
 				res += name_len(strbuf, xattr_name_len);


