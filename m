Return-Path: <linux-kernel+bounces-447304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110829F3048
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F651633CF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E12C204592;
	Mon, 16 Dec 2024 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+anelpa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E170C34CC4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351346; cv=none; b=GX8srq9yavpo1l+aLsKDGPrDHjlz07xOcgWjZs6H7i1WHY6rXsEmRdyA7j2c91h/5L3z7ftRLKmKD4xO457JamQretYW3iFU4UyH89TVqa3BjWaV3+zHGT/ZDgZ2uhGPEzc8SSkegBhyfbN7ax+HuUDkIcIdyCpBdHowZT8XGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351346; c=relaxed/simple;
	bh=6LtgPO/DFAIJLqM7AGygH206s98mwXlC7QCJH2Bn+sM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WEGMhx03786vV+Ox6vbwRO/NC0bqbuWR8ivjsmFSdJVMyxhkNDWxEKhXwS3Mjh66jMh21FPlg5RV1YIq95bRzta0DMsoxy4nMnVT1gbjS++y8W0u19cJgpdY8KMjLVVrNXqxWsEuUY4DGTWeSpD6kUuEWhqvLj6uqlBM78sGlt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+anelpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C802FC4CED3;
	Mon, 16 Dec 2024 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734351345;
	bh=6LtgPO/DFAIJLqM7AGygH206s98mwXlC7QCJH2Bn+sM=;
	h=From:To:Cc:Subject:Date:From;
	b=F+anelpaBKzsb7vsOAkla1WPa0/LMAfm+RHKoROj9UzBnkz5ZigU14O2TIdv4vS0h
	 hdb+IyNYvHK3u9WmC2vkeOZmcB/ILMndEjDCTSt65iWM+MUbcBHeTQZDuQ6ZdR+nH9
	 /oxT78qw8qRvJZMKqHov1uHl8iN5S1Q5kqhqSeekZWmBBQIF8fPW7/l1qoaG2JsQDG
	 CvXuLgszwzzzQj4+iohsME6cKaaiO+Q7Etfs+/aXLy43PfXGSeSnaCzR3S7SEbGq1S
	 IEwuXyuDy2xBHh28RqDrx+NX75QZzjDhKTnqtt1AhWLKJ5haoI6f/aH0gnOyBNJdXn
	 BZtYf5Z4CUDnQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] firmware: cs_dsp: avoid large local variables
Date: Mon, 16 Dec 2024 13:15:35 +0100
Message-Id: <20241216121541.3455880-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Having 1280 bytes of local variables on the stack exceeds the limit
on 32-bit architectures:

drivers/firmware/cirrus/test/cs_dsp_test_bin.c: In function 'bin_patch_mixed_packed_unpacked_random':
drivers/firmware/cirrus/test/cs_dsp_test_bin.c:2097:1: error: the frame size of 1784 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

Use dynamic allocation for the largest two here.

Fixes: dd0b6b1f29b9 ("firmware: cs_dsp: Add KUnit testing of bin file download")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2 changes:
 - use kunit_kmalloc() as suggested by Richard Fitzgerald
 - use KUNIT_ASSERT_NOT_NULL
---
 .../firmware/cirrus/test/cs_dsp_test_bin.c    | 33 +++++++++++--------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/cirrus/test/cs_dsp_test_bin.c b/drivers/firmware/cirrus/test/cs_dsp_test_bin.c
index 689190453307..bbff6caee285 100644
--- a/drivers/firmware/cirrus/test/cs_dsp_test_bin.c
+++ b/drivers/firmware/cirrus/test/cs_dsp_test_bin.c
@@ -1978,8 +1978,10 @@ static void bin_patch_mixed_packed_unpacked_random(struct kunit *test)
 		 4, 51, 76, 72, 16,  6, 39, 62, 15, 41, 28, 73, 53, 40, 45, 54,
 		14, 55, 46, 66, 64, 59, 23,  9, 67, 47, 19, 71, 35, 18, 42,  1,
 	};
-	u32 packed_payload[80][3];
-	u32 unpacked_payload[80];
+	struct {
+		u32 packed[80][3];
+		u32 unpacked[80];
+	} *payload;
 	u32 readback[3];
 	unsigned int alg_base_words, patch_pos_words;
 	unsigned int alg_base_in_packed_regs, patch_pos_in_packed_regs;
@@ -1988,8 +1990,11 @@ static void bin_patch_mixed_packed_unpacked_random(struct kunit *test)
 	struct firmware *fw;
 	int i;
 
-	get_random_bytes(packed_payload, sizeof(packed_payload));
-	get_random_bytes(unpacked_payload, sizeof(unpacked_payload));
+	payload = kunit_kmalloc(test, sizeof(*payload), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, payload);
+
+	get_random_bytes(payload->packed, sizeof(payload->packed));
+	get_random_bytes(payload->unpacked, sizeof(payload->unpacked));
 
 	/* Create a patch entry for every offset in offset_words[] */
 	for (i = 0; i < ARRAY_SIZE(offset_words); ++i) {
@@ -2010,8 +2015,8 @@ static void bin_patch_mixed_packed_unpacked_random(struct kunit *test)
 						  bin_test_mock_algs[0].ver,
 						  param->mem_type,
 						  payload_offset,
-						  packed_payload[i],
-						  sizeof(packed_payload[i]));
+						  payload->packed[i],
+						  sizeof(payload->packed[i]));
 		} else {
 			payload_offset = offset_words[i] * 4;
 			cs_dsp_mock_bin_add_patch(priv->local->bin_builder,
@@ -2019,8 +2024,8 @@ static void bin_patch_mixed_packed_unpacked_random(struct kunit *test)
 						  bin_test_mock_algs[0].ver,
 						  unpacked_mem_type,
 						  payload_offset,
-						  &unpacked_payload[i],
-						  sizeof(unpacked_payload[i]));
+						  &payload->unpacked[i],
+						  sizeof(payload->unpacked[i]));
 		}
 	}
 
@@ -2033,7 +2038,7 @@ static void bin_patch_mixed_packed_unpacked_random(struct kunit *test)
 	/*
 	 * Readback the packed registers that should have been written.
 	 * Place the values into the expected location in readback[] so
-	 * that the content of readback[] should match packed_payload[]
+	 * that the content of readback[] should match payload->packed[]
 	 */
 	for (i = 0; i < ARRAY_SIZE(offset_words); ++i) {
 		alg_base_words = cs_dsp_mock_xm_header_get_alg_base_in_words(priv,
@@ -2055,16 +2060,16 @@ static void bin_patch_mixed_packed_unpacked_random(struct kunit *test)
 				regmap_raw_read(priv->dsp->regmap, reg_addr, readback,
 						sizeof(readback)),
 				0);
-		KUNIT_EXPECT_MEMEQ(test, readback, packed_payload[i], sizeof(packed_payload[i]));
+		KUNIT_EXPECT_MEMEQ(test, readback, payload->packed[i], sizeof(payload->packed[i]));
 
 		/* Drop expected writes from the cache */
-		cs_dsp_mock_regmap_drop_bytes(priv, reg_addr, sizeof(packed_payload[i]));
+		cs_dsp_mock_regmap_drop_bytes(priv, reg_addr, sizeof(payload->packed[i]));
 	}
 
 	/*
 	 * Readback the unpacked registers that should have been written.
 	 * Place the values into the expected location in readback[] so
-	 * that the content of readback[] should match unpacked_payload[]
+	 * that the content of readback[] should match payload->unpacked[]
 	 */
 	for (i = 0; i < ARRAY_SIZE(offset_words); ++i) {
 		alg_base_words = cs_dsp_mock_xm_header_get_alg_base_in_words(priv,
@@ -2085,10 +2090,10 @@ static void bin_patch_mixed_packed_unpacked_random(struct kunit *test)
 				regmap_raw_read(priv->dsp->regmap, reg_addr,
 						&readback[0], sizeof(readback[0])),
 				0);
-		KUNIT_EXPECT_EQ(test, readback[0], unpacked_payload[i]);
+		KUNIT_EXPECT_EQ(test, readback[0], payload->unpacked[i]);
 
 		/* Drop expected writes from the cache */
-		cs_dsp_mock_regmap_drop_bytes(priv, reg_addr, sizeof(unpacked_payload[i]));
+		cs_dsp_mock_regmap_drop_bytes(priv, reg_addr, sizeof(payload->unpacked[i]));
 	}
 
 	/* Drop expected writes and the cache should then be clean */
-- 
2.39.5


