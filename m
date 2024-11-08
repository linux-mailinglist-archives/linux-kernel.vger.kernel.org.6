Return-Path: <linux-kernel+bounces-400879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6E49C1393
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA812837DD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D6EBA27;
	Fri,  8 Nov 2024 01:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQ4yV3kD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FEF1BD9FB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 01:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029164; cv=none; b=RU8csRAI6i74K8kz29SCHwrqdAleBEHo4AwE5L9YPKt0Mt4tX9ZAwrL0t8SmoE0cQg6unuTadhipNgtHy11XBUqIRtDTu05bytZsQ8eefmumKdsxtUX2HjcKyKnUDv3xfFciOk2gjHE9ezFEOjDHpDnV/jmnaATqA2FNhBcMJ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029164; c=relaxed/simple;
	bh=V97j2w44oH4Bt64bhHsn481jd5vtLuRAKMSr57gdZ+c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CuhuA+eYUGV3D00VxDFPEWm0pwEpb8U0ewqm2ZLM3p79YN1y4lZIwXHua6wk38DMu2goyr1NLZc0uuLuZN5t9c3RsexbFTbvOy45ApP/KhWejuLZwdTeFvFmVe51b4bhUz5K7Rvi4gY/bKnB4jDI4tSfByFYOdd52NA7FRINYPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQ4yV3kD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F40C4CECD;
	Fri,  8 Nov 2024 01:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731029164;
	bh=V97j2w44oH4Bt64bhHsn481jd5vtLuRAKMSr57gdZ+c=;
	h=From:To:Cc:Subject:Date:From;
	b=XQ4yV3kD9VFPJHEyN/pRHQpBTtlIhQoCHnK69H8E+314TNESx78zuyjzTVYSHM1jS
	 JsOCR+EOEMCRL8uh9gtOVLQbeAwyrXLG6Q0Jq/LgUwTYnypqWd7R64ElcfLVptutEH
	 +OxG5hws8wID07BT9mZQDPwndJBDpml2a+Xx5nSWJx0KNn+S2129wt5f2Map9NJrh5
	 AsWAbYyYiLmqzQUfBdvUem1J1Cbpeg7n7HOxbvigUg91YWuEPOZBm8SFH15LCpfcfy
	 JJFzO7LS3mNnqj6XDOzwXhlguuLmU3Pzqoao181U3Oz3fLGvQxgFyTXvwESf0hdo+B
	 HhGFvKssIEuXg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/4] f2fs: fix to do cast in F2FS_{BLK_TO_BYTES, BTYES_TO_BLK} to avoid overflow
Date: Fri,  8 Nov 2024 09:25:54 +0800
Message-Id: <20241108012557.572782-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It missed to cast variable to unsigned long long type before
bit shift, which will cause overflow, fix it.

Fixes: f7ef9b83b583 ("f2fs: introduce macros to convert bytes and blocks in f2fs")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 include/linux/f2fs_fs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index b0b821edfd97..3b2ad444c002 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -24,10 +24,10 @@
 #define NEW_ADDR		((block_t)-1)	/* used as block_t addresses */
 #define COMPRESS_ADDR		((block_t)-2)	/* used as compressed data flag */
 
-#define F2FS_BYTES_TO_BLK(bytes)	((bytes) >> F2FS_BLKSIZE_BITS)
-#define F2FS_BLK_TO_BYTES(blk)		((blk) << F2FS_BLKSIZE_BITS)
+#define F2FS_BYTES_TO_BLK(bytes)	((unsigned long long)(bytes) >> F2FS_BLKSIZE_BITS)
+#define F2FS_BLK_TO_BYTES(blk)		((unsigned long long)(blk) << F2FS_BLKSIZE_BITS)
 #define F2FS_BLK_END_BYTES(blk)		(F2FS_BLK_TO_BYTES(blk + 1) - 1)
-#define F2FS_BLK_ALIGN(x)			(F2FS_BYTES_TO_BLK((x) + F2FS_BLKSIZE - 1))
+#define F2FS_BLK_ALIGN(x)		(F2FS_BYTES_TO_BLK((x) + F2FS_BLKSIZE - 1))
 
 /* 0, 1(node nid), 2(meta nid) are reserved node id */
 #define F2FS_RESERVED_NODE_NUM		3
-- 
2.40.1


