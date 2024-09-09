Return-Path: <linux-kernel+bounces-321040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2999713A7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FAC284227
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD721B373D;
	Mon,  9 Sep 2024 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5Q9g2JE"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BCF1B372B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874146; cv=none; b=VDKPWdk/o2k/yfosx5t8/hNWXtQLuc0/rVhqBUF4zLPvDM08AKgMtv7YVwcWgHtDnbC12GeM9onENgtjWXY8v8y4L4FYa7wIVl/QF6ZyzW1I+EIHNyx+9rRcyIKcR16Hm2WAVvKLxxF65oCrK+BdSPbq4GfXCJQ4xELvKOb94ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874146; c=relaxed/simple;
	bh=jv9dSur2ClPaz7FOm12BirmFerwxxTOQf7ekCdauK4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rIvnr1YJ4SU4sjrxmK/g1U1YphH+slF89ReeyeUwDK370JRKXrclAPfjDGkTWJrTNj0rZ6kL9jbjDr37gcFioZ2UYnVx+wnsALFjXV92eNqM2lNuvUEueOMip4VGN71wt2DRAe0SG3POmK+LOrQvx1UloHh8xdCuHgpQhiVPr/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5Q9g2JE; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-710da168ea0so1215645a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 02:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725874144; x=1726478944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOc8UFAAtqggyuAUfUV2vLnHyNxYHiQmTTJ3sFWJppA=;
        b=N5Q9g2JEm7y71vpVBBHXs9albtMhf17Aspz9D360E/LjIURiG4C9BLOLYyHC9c4x15
         huCwpXN2RNanTNwd+LNXeERsjvm/8satF1JmOvuPSb3hqLQfzVDts2NqH71vp8UaZxQj
         lz1YE6A8sGiGk0A8PsUbvf0kFvrOb1XGMp+A6LwTU6+H+h3pJhTLHnhJ0sKumuj4X/dK
         LhklsZYaQ8s014YLUJ2Opsn6BOR91hAeNMW3WZwSyUrUZVhmfMFSUQu1+7jzsVVJzZW7
         IU7MZZRehbAOfa35Jcu8cubL8MAfo7rjpGOaMWsJz4JORodspHxgtCgkl/rctzWLjkN3
         siLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725874144; x=1726478944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOc8UFAAtqggyuAUfUV2vLnHyNxYHiQmTTJ3sFWJppA=;
        b=kT1x+CtjfjWPYDSIRNr1KbKYr8jrkgKzVFVmnYxw5EMvk1kqfgW+X6aX2Aqaf6ZZda
         vlFbLuEqYk8/8XKsxSvDPHL4UzwefO1N0JWid6z4YQNltPyZhR+NkcG3cUMPCGX7kCIN
         bxHsHgfG9/KmQHf22/hjnV8UHXkrcUW+6puUgYBzxrx1U7NcufRuh3js7AOXueCU7dKk
         izW8Z+qGWmhBppZxENX/ReW6NdclKFfnIp+vSbQjhcrEknSZ8R6cyQH8+GfxKKMJLrZd
         74GrdHD8NORtQi+Jw6loYlJklXIER9vYPGBfwBU4TDTCGfMA3UaxE0ASVkmSfCzN+sNO
         6bnQ==
X-Forwarded-Encrypted: i=1; AJvYcCULvlyEHzGP8aK58/3X3+++PHCBwI2zjlY+j5KMO75iHDsKARN0Xor8gGFrQDn+FZSU2LNx53OU13GpXJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrxCG5KAg/Z3odx3j+qf4k5+M9+6ffZpUnB8m39Udxm79EQU7f
	dMVoQzPUQBgk8/ExnpktUoN1DJyqZnFKApSXcRlQXAIXBmM0/JkT
X-Google-Smtp-Source: AGHT+IHDKeNhq0uVsmiNCfODSAiBroEAtra1i+qw7maXrJyaPreWE/YkO6JCHXpvdj/Fb6E3wTK3lA==
X-Received: by 2002:a05:6830:4489:b0:703:68e5:725b with SMTP id 46e09a7af769-710cc25e877mr12601623a34.24.1725874144031;
        Mon, 09 Sep 2024 02:29:04 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8255dc167sm3050794a12.71.2024.09.09.02.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:29:03 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id B4F128058E;
	Mon,  9 Sep 2024 17:37:20 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v7 2/2] mtd: spinand: macronix: Flag parts needing explicit plane select
Date: Mon,  9 Sep 2024 17:26:43 +0800
Message-Id: <20240909092643.2434479-3-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240909092643.2434479-1-linchengming884@gmail.com>
References: <20240909092643.2434479-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Macronix serial NAND flash with a two-plane structure requires
insertion of the Plane Select bit into the column address during
the write_to_cache operation.

Additionally, for MX35{U,F}2G14AC and MX35LF2GE4AB, insertion of
the Plane Select bit into the column address is required during
the read_from_cache operation.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/macronix.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 9c0c72b913ed..d277c3220fdc 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -154,7 +154,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT |
+		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 	SPINAND_INFO("MX35LF2GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x26, 0x03),
@@ -194,7 +196,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 	SPINAND_INFO("MX35LF2G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x64, 0x03),
@@ -212,7 +215,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 	SPINAND_INFO("MX35LF4G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x75, 0x03),
@@ -251,7 +255,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT |
+		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX35UF4G24AD",
@@ -261,7 +267,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX35UF4G24AD-Z4I8",
@@ -292,7 +299,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT |
+		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX35UF2G24AD",
@@ -302,7 +311,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX35UF2G24AD-Z4I8",
-- 
2.25.1


