Return-Path: <linux-kernel+bounces-447011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E009F2C04
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384751888588
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC391FFC46;
	Mon, 16 Dec 2024 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lp6KmAKk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AC61FF7DE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338035; cv=none; b=q9Y7Y9HpfPGpez2dogtMXKG7Pasrx8P+wGVguxRRa2zdhSRrDB1/U78RRt0UV1ylCfakqt2pUae5LmCot+Ft2Vh41BVHHfhzVGzqjykmN43iErtCEmJbHqcpzapetmc0R0mtmCVipd7ybffVNJ98Q1cXru4fF/N1WoE81suGJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338035; c=relaxed/simple;
	bh=aLTYmsnUmsIueETV4sdDTSQWEq9v92VLiOsIPurkcV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m/P/5Rv0ukYHhEbKr66GskB/pJ6+IsEPUOjZ4PwnJeyRHF60hap7shE/HluDFhIqFUmWpZWPUTn7EuI3gqaDflMNxW/FAC8BTzTjEOUjQfz0AbC+rF1TuuIXfR9csRQdVM2AhX6kY7BF1XBr0UR7T7SQaxjkF6n9FuAPl7an9CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lp6KmAKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A075AC4CED0;
	Mon, 16 Dec 2024 08:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734338035;
	bh=aLTYmsnUmsIueETV4sdDTSQWEq9v92VLiOsIPurkcV4=;
	h=From:To:Cc:Subject:Date:From;
	b=Lp6KmAKk4Vms4WX3yfdhe6GWYN7iWZBEc+9PzFahhgZr1WME4JZDwItUcSBkoBnpa
	 THRKMC/BQdxzJ9tSwrXZtdXC1QJSEt1sKNpy+tTVjCGpEodTIuDQ2v89bOiaOOEn3v
	 QuG/kAv1tL8m95hTCeZSTK1AUtYib/nPnxazRcsPpmWAkEf0j49FsYWdaPp2jKXoEQ
	 Ivj3b5FX0npDMCM8wRwZAuJ8fobHyyWrz1NFLgfWhGGWfiCbasX70GiSxdhudZ/QXN
	 AT9tzGnWYB5sd6kvWbQUZltM/9Vo2vJN5eFFfkylVMb0eo6iuXnb0xuVMNZqEXej9F
	 PL50sh7bOrq3g==
From: Arnd Bergmann <arnd@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: cs_dsp: avoid large local variables
Date: Mon, 16 Dec 2024 09:33:43 +0100
Message-Id: <20241216083350.1866908-1-arnd@kernel.org>
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
 .../firmware/cirrus/test/cs_dsp_test_bin.c    | 36 +++++++++++--------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/cirrus/test/cs_dsp_test_bin.c b/drivers/firmware/cirrus/test/cs_dsp_test_bin.c
index 689190453307..f1955813919c 100644
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
@@ -1988,8 +1990,12 @@ static void bin_patch_mixed_packed_unpacked_random(struct kunit *test)
 	struct firmware *fw;
 	int i;
 
-	get_random_bytes(packed_payload, sizeof(packed_payload));
-	get_random_bytes(unpacked_payload, sizeof(unpacked_payload));
+	payload = kmalloc(sizeof(*payload), GFP_KERNEL);
+	if (!payload)
+		return;
+
+	get_random_bytes(payload->packed, sizeof(payload->packed));
+	get_random_bytes(payload->unpacked, sizeof(payload->unpacked));
 
 	/* Create a patch entry for every offset in offset_words[] */
 	for (i = 0; i < ARRAY_SIZE(offset_words); ++i) {
@@ -2010,8 +2016,8 @@ static void bin_patch_mixed_packed_unpacked_random(struct kunit *test)
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
@@ -2019,8 +2025,8 @@ static void bin_patch_mixed_packed_unpacked_random(struct kunit *test)
 						  bin_test_mock_algs[0].ver,
 						  unpacked_mem_type,
 						  payload_offset,
-						  &unpacked_payload[i],
-						  sizeof(unpacked_payload[i]));
+						  &payload->unpacked[i],
+						  sizeof(payload->unpacked[i]));
 		}
 	}
 
@@ -2033,7 +2039,7 @@ static void bin_patch_mixed_packed_unpacked_random(struct kunit *test)
 	/*
 	 * Readback the packed registers that should have been written.
 	 * Place the values into the expected location in readback[] so
-	 * that the content of readback[] should match packed_payload[]
+	 * that the content of readback[] should match payload->packed[]
 	 */
 	for (i = 0; i < ARRAY_SIZE(offset_words); ++i) {
 		alg_base_words = cs_dsp_mock_xm_header_get_alg_base_in_words(priv,
@@ -2055,16 +2061,16 @@ static void bin_patch_mixed_packed_unpacked_random(struct kunit *test)
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
@@ -2085,15 +2091,17 @@ static void bin_patch_mixed_packed_unpacked_random(struct kunit *test)
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
 	cs_dsp_mock_xm_header_drop_from_regmap_cache(priv);
 	KUNIT_EXPECT_FALSE(test, cs_dsp_mock_regmap_is_dirty(priv, true));
+
+	kfree(payload);
 }
 
 /* Bin file with name and multiple info blocks */
-- 
2.39.5


