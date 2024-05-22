Return-Path: <linux-kernel+bounces-186283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1BF8CC22C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E2D1F2279E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69BC13F44F;
	Wed, 22 May 2024 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="haytO6ek"
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1502613D638
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716384807; cv=none; b=D5dQaUI/amAuL+4OAJC2ygg/dGf/6f9isXBHlnZkyAn6NNzXR37zpOK/E1NAPfb1PGzpY4RQvCNLWfwnQS8Z10mYl0oTkbEoDVPc8u//Pf9acHO13aAHASedQg1fjbhU/a/KDCYWKHhj9TjNp7HHhMGhA+xpyK7zndeE4JWdZtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716384807; c=relaxed/simple;
	bh=Xv/FYulD0QFc/ya9QhUeR7ir3gmkdTpmuxRrZBy7UOs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=imRVylIqWQNVoUJwrsprsP2iGMT/ef3YnzzjNYzfNcnnNF8El5A6+d7LcFC/422wcRWIWYjuOUs9v14gi4aX6LDr2WirSZ9ATSWJCbLs4IGp/DAg0QhmNQ37ckI4qvnua8Q/8gFCXl/Wmpkm0olmA1GfKhIYUMPr8JOdn3DKJW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=haytO6ek; arc=none smtp.client-ip=203.205.251.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716384796; bh=vrxsPS2YuyWByL3UYPD0p+vm/aRuyKP1SfM0Wi4gs4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=haytO6ek9atzfr7G/B9jlyn/lZ9Xg3sYPZe5Si1ivhTXtaq4OmboOsQnCgP3n8b++
	 wCgi8V0Ir81UMCZu+W7mqS7dGulNZeRCk7FeP1eGf0LXKBPCEUQzerid/0DoE+1rhJ
	 pczcfhVJx8soep4/DcoOcykB9Gd7RrKM0krt3yH0=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 77935403; Wed, 22 May 2024 21:29:57 +0800
X-QQ-mid: xmsmtpt1716384597t6uh19a26
Message-ID: <tencent_E4796C489550EB0EEEEACD6C797A6F1C2E0A@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0aO645nJ9CGVHc4DLC0e0AxKa2y8H6B7oi2kntCeWKetV27pOkRS
	 ApVHBnCmmAXrcBPDrn6Zpdf9iPWG/NZ+0LYLLqpJ2CWmiJlCuaaVyfmsh9GgACBZeeeJtlY/fi0w
	 8NvmRdvATFoPKtuAEXap5lmiPp/9FLXEk8fsawakzqo9btqzvwYLJVKiG3nMm3dxY3Hi6N8R+MJZ
	 6jFGIyoOTmOnRBN/qJJDJ1nBd8dQBbILHRXNe+Z0laacVJWoTtJd9XOshF3KkM468q/w8StMeew0
	 bJVUuv508R+FwXkJtCIH2oi3GSWPSzvlE4+2yl86BIdtPObcW6fBqYmH8rwLggTc/kJp2vgV3js4
	 vMhdo0xxoXrc9BDwk7F990gRaStsmpJ4Fg9nRffvxuX8CJy7ELdRYejJmcEDjacclhy2yh08Z+01
	 bPiUpZMAfAQC9mkePJwwOTb9/bR9TBpF75U74fV9ipZy6Fg6iBs/tvHpiu1UXwgOdTNhxV1YT0yE
	 4yd82hMNIZUy5oQ9zi4yZY1CzGU3Eh93UdgMq7+ONtKCzhxszdTqkRH6rnKWRIT0umaghCYOnmWF
	 FOkImSIPb0xmbHdjwpkSCbWQn58IlkSQKgVyq7d/n/kD23fC2dAJHDjMpw9hMC1PDrFnMU0M7uAs
	 rSW5IJ/40PUlm9+YJ0ABJJGci02hmODbVWe5JFp2cywgS8tBOugwuHrw1aZyp4JyQZls5k16kTiU
	 wWL+Q6GIgXy/mepZaAp+kq10wx40RWTZnT9cxckH0j+5CUJ2PXeHHXb9YwQWyLku614UJTZI6O5a
	 Ig80KDdfqQNxrrcljeRwYXcfpRhC39GpKTfSGjfkZfhChEhwL/g3b725IA7WhT1S2Z6Ys5Qz+bYV
	 YG44Lk6PrwtRPbHwQkS6RaZjgoKil4K7ONj3laRII/1xO+T2lkigrK7Ci4KsjUjrd5f3pkbPGOA3
	 DtbOR+cYKettWp3OcFBA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
Date: Wed, 22 May 2024 21:29:57 +0800
X-OQ-MSGID: <20240522132956.2352659-2-eadavis@qq.com>
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
index 60aed8de21f8..cf5d417b5f66 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -751,9 +751,15 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 		/* dismiss the fully eaten buffers, adjust the partial one */
 		tail = pipe->tail;
-		while (ret) {
+		n = 0;
+		while (ret > 0 && n < nbufs) {
 			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
-			if (ret >= buf->len) {
+			printk("ret: %ld, nbufs: %d,  buf len: %lu, n: %d, %s\n", ret, nbufs, buf->len, n,  __func__);
+			if (!buf->len) {
+				tail++;
+				continue;
+			}
+			if (ret >= (ssize_t)buf->len) {
 				ret -= buf->len;
 				buf->len = 0;
 				pipe_buf_release(pipe, buf);
@@ -766,6 +772,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 				buf->len -= ret;
 				ret = 0;
 			}
+			n++;
 		}
 	}
 done:


