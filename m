Return-Path: <linux-kernel+bounces-186335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79548CC2D9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88E51C2224A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C449D1411EA;
	Wed, 22 May 2024 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tT/4bmVd"
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C8B1422A5
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387091; cv=none; b=MnJr1rZX60AeYaJHwvlxp0/9Qc/YSvHrzapHXuiw9u4ScgBycH8VFdmTWCxtMvJ4t6yXIqlMtGy+BZ7QmVVL6kEqxOW3jm1GJWEj+uP1oSJSziUqgvpbAUNET6uG4zaGcN3yYZFnqzWsM1MUqe0XMx+k0F7JmWRTozQU6p7Ma9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387091; c=relaxed/simple;
	bh=NN3bGfD5HUdZVm9jelXlObF+mJFT5hj3fmxuh8giNFs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qyqHIstvJJBBHBcUJ1CItlh5fKcuyyDZxKGJMjJlInW8xgFLPDKU772RF3AUG90qZCEOaEMNwgEPMf81KApW6HN99CTkU+f7bHuz2CKxlP6eVC5vyBldibZi2C45yyKFvY3YxkBYQWf6vt9qobuysZIBcD1G1CTyOV+xTrLT/hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tT/4bmVd; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716387081; bh=uRU8T4+XNtOKOsNn+AMyx5lkYAGIGFMDmfGPdOTBEns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tT/4bmVdTEtPObKfC9BeaFOa2xucNsH1aI374QM0NmnL/vty9skU1hHYPt4ifpp2/
	 4t25I0Rw+dKC3aNsYBvjpUEZOFEcdztaezZkvbZ5rD41oamd2gBDCAvPEtAP5yplRI
	 c/NB9Ll9ChLYFWWuYGv9NUt7jUb9xyfCKppIDjjA=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 149A4881; Wed, 22 May 2024 22:05:09 +0800
X-QQ-mid: xmsmtpt1716386709ti7wb44jx
Message-ID: <tencent_DD0A3C9B37F697D637C04A3A7509762F6609@qq.com>
X-QQ-XMAILINFO: M3L8BpKHwdnKWUUxNVKzJZ2FMNBk/gajo5UZHciuJPHqIFhWjgpNFcpj4mmTk+
	 q83bn8QcqcyKllvRgBZj+yRdED9XCiw2I65F/bzErf0svFg54l3Kyrsn6EQBDAuIDe3QR4f53L7H
	 Xmz6tqM5onJDqANXLaT7SyO0lKiX9PPs9f7/lR1PoK7/niXadJxCMBGYKISrrPtRp/41Lg7nri9F
	 B5l53d9+bBvlVp80sKmJ+DdeOKihbncRC/nLoKOUcNzJqQCfPK8+K8razRvMSRkfDKbmPTDQxBfL
	 EQqgx3xa5xSzrAova6mnB0+gKM4YMeIlgnHT/q4dUGt9NWzRURYgp7K2L2cbIJL8taOU6oyU41kk
	 l8Hx7A9gJLYpKLrBKtHXjLWGFNBV4DvB8T4+Hq5YEoWGXbJ1zziHcSHtlR0eiDgaCM9ds9y+86oU
	 kuNbg4Zsd1ie5fKMUhUTg7pKgeiSRS1unTkFeuCzMbiFkCswiELPqATdMdZNBoCO5Vd4E61Bhm1l
	 vBempRXkXzIOV7Xw+ZKBFN6yDrvrTNWXFVW/jY061ggkPI8CS86ZbpcRoDdjoKwO43Rh8J3UjSir
	 YUP2wi3gCOBjrspT6DpPRepb6RUDAsTLbWeUpWoQbd1yfmErqnXEcEx3sBa9BvW3kafEAkFmK8nS
	 geOLO1wqWuewVfp0jI6vJyjPwdJe64kHLFqTJxC1pXjVpJJFsNQvI5CHIReAll6Excw4seg6T6HT
	 GhsMEh5Ib4sF3Qga4bKVihYGofXyMFmCpFomwTUfGd/4ZCcnm+Qti08Ap31F9SHAR2lkWZJZ8gk6
	 6sxSvIqvDdHfcGioA5SxG+qvX2jgB2WxpXCRmgYT255tFY5Zi2Y1ysJrLp6voiScxl5Gyv+HumIP
	 OvCIrhPuRhuNBj7HIyBO1JNfyqAsG71bqKsM7Ia6ashKk6iIm7u2DJlC4gd66Fx/DgMxIIODUt8n
	 CXWWlqwlhAHAa+WpzHvS0My/4T1Fnu
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
Date: Wed, 22 May 2024 22:05:10 +0800
X-OQ-MSGID: <20240522140509.2406912-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000002fd2de0618de2e65@google.com>
References: <0000000000002fd2de0618de2e65@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test null ptr in iter_file_splice_write

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 33e02dc69afb

diff --git a/fs/splice.c b/fs/splice.c
index 60aed8de21f8..a6b44c10b08c 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -751,16 +751,25 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 		/* dismiss the fully eaten buffers, adjust the partial one */
 		tail = pipe->tail;
-		while (ret) {
+		n = 0;
+		while (ret > 0 && n < nbufs) {
 			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
-			if (ret >= buf->len) {
+			printk("ret: %d, nbufs: %d,  buf len: %lu, n: %d, %s\n", ret, nbufs, buf->len, n,  __func__);
+			n++;
+			if (!buf->len) {
+				tail++;
+				continue;
+			}
+			if (ret >= (ssize_t)buf->len) {
 				ret -= buf->len;
+				printk("ret: %d, nbufs: %d,  buf len: %lu, n: %d, %s\n", ret, nbufs, buf->len, n,  __func__);
 				buf->len = 0;
 				pipe_buf_release(pipe, buf);
 				tail++;
 				pipe->tail = tail;
 				if (pipe->files)
 					sd.need_wakeup = true;
+				BUG_ON(1);
 			} else {
 				buf->offset += ret;
 				buf->len -= ret;


