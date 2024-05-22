Return-Path: <linux-kernel+bounces-185772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 888248CBAA8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 07:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378C5282F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 05:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A4B6026A;
	Wed, 22 May 2024 05:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rRX6120w"
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4BD25776
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 05:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716355699; cv=none; b=m41Duwr1l0QA7MxY1BNkJ5nnCS45TRpuk7dEgGpbcsxYJIieETeDMhaTScuKEj8XnPr1KNRRgRAvu8dzNbjvvHa5ozkufFRyqFSzcK6N59ctHApKJssmUwO408YXEJLAxmxzt1vmS/FzlcNXrbrB6yseVLl38Tawn1MJ5S5nvUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716355699; c=relaxed/simple;
	bh=qwfgh9phep4n4X30rWoekAefHr6uXytVlp0pi5KZasQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=J1l+/VC+9v7Aoe5SYK0pMfxFFEtj7TdDWOYo8vmz3JVpbFYlTfFkfVAw0ykzH/zzUuNJ69TnVGnryXJhV6vNB+AdK2tGAHsEfDufvD4O9KqnU7T0+lZE86+J5Auh+c2eH9p+SLKRIyShdVCOq1NZlDIr8x2TxeQBgy9+c7tDXb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rRX6120w; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716355688; bh=OS+QacVvQy5zgabI1JUkUghG/xC5hTU7JqpQQE7dNtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rRX6120wADxokBgBMcREFZtXkvXZNb/Xy3M1tM/ySn9ItahH5sDPgAbqFFke+ZCaa
	 6VEir6rE/fHaBkajZfP/zzy8/eN7HRyYciaV3JIKLdZVC63HT/t5zF7LC51qd19QQt
	 7I59l9IX5Y7ZvQHtw/rCds5ycZO65hWrkQB2H3BM=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 56F95AC4; Wed, 22 May 2024 13:21:47 +0800
X-QQ-mid: xmsmtpt1716355307trknuni0o
Message-ID: <tencent_11C652F8465D499BEEC06EC00CAFE7D30606@qq.com>
X-QQ-XMAILINFO: NafziRg7Bx69PCQKykwKoNASymMoYW4EfoDp8LPwophwEW8qJXDJgHHtsIHE6F
	 vxBjznpQAqs+PTr//v64jER9X+Q7AgwrP8wREyxGx23Pepz0hSEMF3BfoeJSnEzyZTPILtUutv52
	 5GLzanYjTMcqna6Jw1fo8PKhTNixx8jHkaWrt475ZRYzexl/NmqP+e2pffooTMbiNcYplvyndqxR
	 PoCrqAF8453LaqRzTVKfVjOkwhVMbZUASNtsbNCpAc8LOtKAIvBVq3x1sfqjjQuCF7Tlcbp92w2D
	 JLYq5VesUP3X7GjItdrw6ijdDVBoC2zGmWXv+rG0uOJrWVgqtQq2+Qg33iHGGFCImnmWG/MAyYry
	 V1OTFUNWczNlTHeISRnQKJhTL1Un2bj//owzVR7DczPYrqhA1U0b08qRXDOwEueU1d7cyTxGsJ5J
	 vYYgSKkBidUK6mbd6jLFQv+Z9roNESAq+JKbtmRBdBkFcOSv4YAQ6L+LO/7NgArZ2BwfyagNQpZO
	 jwciluxRYawwhqxQCaq+ejC85PVf7HLgyITXPfHC8L3kywxaxJ1sZl7Ssm1BM6Fjew+sfsXIO8sy
	 MtaiskuFoxER7wogszIP9MR6FeqKuHULAbnjUEk22GHorK0ebfpXPXZC4EsU0ojSEM79sZsjz0rp
	 GkjAkxEkmi6YAngSDkDEY0zEp9PwJ7O8jNIDppTNWgvZlFude/DcIpf/Nyettr7Enlq0Pawri8I7
	 5EK9l5VNMkXSwz/quJ4poGyLBQ79PoOmuKiukEY8ACFD5gvTAI52nFZm0NoZx69d9M4S3zrqD1H9
	 E1Wi4705K0GbQr/Yh1ceFhn9B4YG98PsM44XDmngI+K83i8zSGA7RFdxTY+4v5g6+oIzlHGPq2sE
	 gcbAMiaqggsQAQ4djqmOlvH6u013k5NqsCjlvIbiUjh1V3cLVL2gZLPrrQvI0E6XoQJuOkyXOm
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
Date: Wed, 22 May 2024 13:21:48 +0800
X-OQ-MSGID: <20240522052147.1645448-2-eadavis@qq.com>
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
index 218e24b1ac40..1a3c31f3e63a 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -392,6 +392,7 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 			.offset	= 0,
 			.len	= chunk,
 		};
+		printk("buf: %p, ops: %p, %s\n", buf, buf->ops, __func__);
 		pipe->head++;
 		remain -= chunk;
 	}
@@ -498,6 +499,7 @@ static inline bool eat_empty_buffer(struct pipe_inode_info *pipe)
 	unsigned int mask = pipe->ring_size - 1;
 	struct pipe_buffer *buf = &pipe->bufs[tail & mask];
 
+	printk("buf: %p, ops: %p, tail: %d %s\n", buf, buf->ops, tail, __func__);
 	if (unlikely(!buf->len)) {
 		pipe_buf_release(pipe, buf);
 		pipe->tail = tail+1;
@@ -755,8 +757,11 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
 			if (ret >= buf->len) {
 				ret -= buf->len;
-				buf->len = 0;
-				pipe_buf_release(pipe, buf);
+				printk("buf: %p, ops: %p, buf len: %d, tail: %d, ret: %d, tl: %llu, %s\n", buf, buf->ops, buf->len, tail, ret, sd.total_len, __func__);
+				if (buf->len) {
+					buf->len = 0;
+					pipe_buf_release(pipe, buf);
+				}
 				tail++;
 				pipe->tail = tail;
 				if (pipe->files)
@@ -1483,6 +1488,7 @@ static ssize_t iter_to_pipe(struct iov_iter *from,
 					put_page(pages[i]);
 				goto out;
 			}
+			printk("buf: %p, size: %lu, left: %lu, total: %lu, ret: %lu, %s\n", buf, buf.len, left, total, ret, __func__);
 			total += ret;
 			left -= size;
 			start = 0;


