Return-Path: <linux-kernel+bounces-186147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 049F08CC055
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B181C223C5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D3282871;
	Wed, 22 May 2024 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rtBGiEx5"
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395947F7FD
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377746; cv=none; b=hhLHNbquuv2/mkgs7+CCgG2ACA4j1/L4TNAEWo4JeKC/nqQzrzL0FcbedZPqMAUifMLl2eUq+Hg3dDuSE70sISKe6d0J6l3ZiD27lx3F9JhgMgi27c7flIalhUWCqpG4diGyG0Shrgp6keC6A7VsHCBlj95TlXUPwkMwkPqc5rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377746; c=relaxed/simple;
	bh=6E1Vo14DL/WXabCdGMv+/2IzKovRUvGkCtlDlixUeCE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Lq28O+Hhrd7pkuGErh7SOoh/Lit0tSnbbxlF0xAn/0FWOV7lcZDSJCWgPpc6rHjcFlsykCEvUHLB4NNB+AfelIOWWvTKoX6czk+eKNTvsxvuYL0HSJ0Xfy7/rXAAnH8BYpSs4eXX/nfhh3kRZeMzAA8JuFS7vzLDVesxCceeNEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rtBGiEx5; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716377439; bh=myaU8osdTJYm8F/QtH9Tcbp5c5H+ZrqmTXVy/yDgt34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rtBGiEx5Fv0RNZ3HT1KiC4EDY5OdWdGAU+4TyyQdVGu7g6+IBnKM//F/drCq7T7QH
	 69C+Y33si2Uj4YQTIS007S5/T3/h3uo9t5FHgxBii5OSBpK38bfsHcJZiGGc37qL5s
	 CKA0F6e89cUZUVDayoQ+6AnQFgbN8RRckiPXfN5s=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 7A52684C; Wed, 22 May 2024 19:30:37 +0800
X-QQ-mid: xmsmtpt1716377437t42779cgm
Message-ID: <tencent_7BA1330A9E431B2B4B071B6B2518BA37BB08@qq.com>
X-QQ-XMAILINFO: NioaTWkRhWwamOJ5gr9in613XOSg2x2ZTZ6AkkDXODq4RxIv188IOk4tfUNZKn
	 ifsI4CkDqMz1P3XciuNQbU9wy6MfDdxn97NDvsXFF/kkyRo9wpyID3tjdpJ+z5ioGGLdKRwAvSN0
	 u1HtUPMo6Rufjh1r36BC6bWnkw8+sXeYNaOzsqOuACoodCmtjQCVq178wQHS/6fVXDRNm2gP/tIf
	 8wvyMRhW8r6EttYWDbrCdDoQ9vvxHF9y99mt5+Iagi9UsoVrZ820+R0T9pzx+mHiJIhZOclVst3H
	 G56+2th8ez7CuU7HP/7R2JwIhQNETmkBIWChiGYzRfyGKXFFYK947b3YLpl4N2OjccX3TNHnHufY
	 drDmenrdZ5sgwtDSV6Od3KxypwdWhycC/+a1YXX90RVfU5jklJg5KpUYnYP0CXs1BY4k0X+qezBi
	 T8KLFiGr382VCcm64AxFVWiIncRlHkWJm3kjxTEDCIIQom0NXVrfBVgPsXsntW+hyqGnhYhkK1Na
	 6LLtDHBJ3emkCKvk+pJmJG39OwCUPInXLS4gkbTyX2JBOr5pIUyy4CeqWe3AhCiY1K8rnKZMjMul
	 8+Z2wYVfnMLum6PDKgihA3YfTewmpnqCF7rfKm3lr9q+whAUMao2qQ0ldRDgIgCe8OUtDagL552f
	 HGHrgtOWESEDm0QCKG+DO8w4nK+y2GYvkSMb3WbbNdPwZ4sl77/phOrFlR27oaI7IoByFj/IkFRT
	 6zYt5nCPAw7mWlxxUVO0QoStkZXXskhBCdpA8TorjODgIus9JawooCr1im3tgpQCV70ED6CZdaH4
	 8M6M9jMG3VcNycNSsGWlT9pv5EzQv9UVv2kOfutOHk5cqNxJdKG1mFAtb1qEI2k4G9ZUKKeRCkqV
	 MNY66QxSgHESj80EJUiCIPzeQIV93r2AFrXAhfrsuHkFB5Kf4CxcnmSG69ihU2eg2M+BFPlFOsPH
	 +ic+CKzXg=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
Date: Wed, 22 May 2024 19:30:37 +0800
X-OQ-MSGID: <20240522113036.2205322-2-eadavis@qq.com>
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
index 60aed8de21f8..db66b8c5fe0d 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -751,21 +751,25 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 		/* dismiss the fully eaten buffers, adjust the partial one */
 		tail = pipe->tail;
-		while (ret) {
+		printk("ret: %ld, %s\n", ret, __func__);
+		while (ret > 0) {
 			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
-			if (ret >= buf->len) {
-				ret -= buf->len;
-				buf->len = 0;
-				pipe_buf_release(pipe, buf);
-				tail++;
-				pipe->tail = tail;
-				if (pipe->files)
-					sd.need_wakeup = true;
-			} else {
-				buf->offset += ret;
-				buf->len -= ret;
+			if (buf->len > 0) {
+				if (ret >= (ssize_t)buf->len) {
+					ret -= buf->len;
+					buf->len = 0;
+					pipe_buf_release(pipe, buf);
+					tail++;
+					pipe->tail = tail;
+					if (pipe->files)
+						sd.need_wakeup = true;
+				} else {
+					buf->offset += ret;
+					buf->len -= ret;
+					ret = 0;
+				}
+			} else
 				ret = 0;
-			}
 		}
 	}
 done:


