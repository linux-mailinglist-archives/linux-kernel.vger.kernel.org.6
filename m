Return-Path: <linux-kernel+bounces-373198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B85829A53AC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9E91F225DF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 11:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD75158218;
	Sun, 20 Oct 2024 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kFvZmpFE"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB7A187FE4
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729423284; cv=none; b=FPNd5viio8qJgfyZQZ5E6HWl/Kwt2uyzJubS4ZWVcmnqfDamY+Bu8dTWowZCTHknHbgQwfAaiYXKTq5oYeOVusicZc9/U8xc04gdhEBSOrDfpg03+SffeNanDvCKHzdYZtOhtwaC6SoLUjy9BKFlol03nASUKD3p3GcveoGoIxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729423284; c=relaxed/simple;
	bh=uyuBjAjZ0sxvvzxhUBFI4y6tyi92YEmGG0VriZlQLPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mYIXLqvRi5KU+JC8APqLDJMLsRrlMKzVA/bmgqfuA9oP90mvfuZoaJkRLY6xf0KfmEfvQDJccOpAH5t2zUoDlPlyb2AvgNpGFsa1MXH+8qJC2DkafCEyJg2VUdMxJa/cfNsmPO7ypXjanqam+XFo52fKDk1btLu8NmgSsOhFIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kFvZmpFE; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729423273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rpC4QRPnAGJa+dqvOlD/KYtzd/kQ+bx31mYC0wNOAso=;
	b=kFvZmpFEY4NjhmLT6xEx2yRWmgMNmfJZ9bFy+Td9HETx/17c0pojTibsMcEejXTyzgiqpi
	5kG27XWQuP1Bq4+Y4UFxo3iT9IzotKjn4OVqXDoOp+oy5rtLNahSSSByZYrSthYB2ecR0j
	Sa2sWbV2Fkdz7RKLUqg6OZaAs1rwW/U=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bcachefs: Use str_write_read() helper in ec_block_endio()
Date: Sun, 20 Oct 2024 13:20:46 +0200
Message-ID: <20241020112046.52890-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the helper function str_write_read().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/bcachefs/ec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/bcachefs/ec.c b/fs/bcachefs/ec.c
index e410cfe37b1a..26b1664adb4d 100644
--- a/fs/bcachefs/ec.c
+++ b/fs/bcachefs/ec.c
@@ -26,6 +26,7 @@
 #include "util.h"
 
 #include <linux/sort.h>
+#include <linux/string_choices.h>
 
 #ifdef __KERNEL__
 
@@ -732,7 +733,7 @@ static void ec_block_endio(struct bio *bio)
 			       ? BCH_MEMBER_ERROR_write
 			       : BCH_MEMBER_ERROR_read,
 			       "erasure coding %s error: %s",
-			       bio_data_dir(bio) ? "write" : "read",
+			       str_write_read(bio_data_dir(bio)),
 			       bch2_blk_status_to_str(bio->bi_status)))
 		clear_bit(ec_bio->idx, ec_bio->buf->valid);
 
-- 
2.47.0


