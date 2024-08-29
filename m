Return-Path: <linux-kernel+bounces-306072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8020C9638CB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3221C21C60
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BF362171;
	Thu, 29 Aug 2024 03:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxTtmi4q"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45A84F20C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724902059; cv=none; b=hKC1fJO3dcdaDJS2l8u4PAzSVOXrD38iUg2Z7vXz3ekgU1m4k8sbKIMmeiZb9DPBah/4UGdG1lLae/5ZQNFMXGOhfAI3oaQJMmZYTOItfEoqIDtrGvSghIGeSXQOz8VOVXQYyFsT6z2sMo3hQN7G4PhRZIdKo5r2feVpbSMz/38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724902059; c=relaxed/simple;
	bh=sl+WUjX93oDz16xXdE4g23AatPaU3O7WYHJs7XBhCkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lCpYm45Yl7XEtli97AP2GaCDmCNqwr2fXIc2eR8xQvqQcen5k8OW1LV+CDlKcMu9JTqoQZMwzK3LMVIJxCaqsCSejSq3rOggxSzfEPsznvqJCv+TXw91Ja05SpoHCJDUsQTQEGnUNaP18P2fxk4Mj/no/jBcyDqar4bgJ+SaOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxTtmi4q; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5df9dec9c0eso121378eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724902057; x=1725506857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhmAom+LVcmv0Mivl3IQDZRfWyPiO2Vvp66v1pNhYJY=;
        b=lxTtmi4qP7PPhvlwSZaNg5qFwy9uhmua7n36SIQepjOe1bbJHTWHh5IP4tOokefmdw
         gkS88GcDvnfZA6mFTgQFRinuleT7rruQSc7vFvnpE0DUYLR68W1OjRTwV+M+aTkBVdR1
         F/ny32QMYVsOiMpCHj8X83RY/6VDLZpwjQvKK21bZJAHgwhHViARyOjRoxGZsMZiJRFX
         t9nh4MRf2w7ymy00Q5M5tbc7RjJ55SEfnda0FZKPqmg9HDxsKk6n6ddMf7sicHqTK7fZ
         sgMhmewxd3O346eBAfKHL5T+rqAyOmiOChoujQGwwLjq99U0SHX+KsT0rJLDxTbNKN2v
         5B9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724902057; x=1725506857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhmAom+LVcmv0Mivl3IQDZRfWyPiO2Vvp66v1pNhYJY=;
        b=pgw5m3ljsMvGBVPnTzXOke/Lle6rop0HnkdQJTFLA2xJprQLD6HYjwSSAIp3FmyTQq
         0qAtvdPTSUGule2LBpaZEbaHoWhaah3Y9MZSpgUQ2ILG2j8Oysg8d5wQ+aWqbG6Snpzn
         XXMz1GQHgTFVKn8buaCOHmCpP8on9KDcbDWjeq0a2m315i/1dT/oqRozyBcQnGeWiAkd
         x1E8KiaSHeFv7xKf7Qh48ijeooCuDjYMNB+SlcUUzGXX6i/eegGdo/dq23e82yzwSOwL
         bRKW4+tBZO6lHsaqYka3fox+RM+XrN2gmweTMpeGPgdG9sC5NUVwbxf2Vbj/OrO1gdCv
         DY9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCW0ujP8mpgwSrJdQ3xLd+iPWZxlyvYUOb4FfTZr8oUd4QFN0IQnv3aSg/UWyvn4Og6rSsU+WMWOEvKms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/0gMJphWDphhOEMppVSKtJhsn1S/7rcvfY2MUQ1c3lmwk4X6p
	tu4RYxxHrfixrNMKSpRvi4OZr6s0sPjWrHiMZ1ulYCfVBfhVA1GD
X-Google-Smtp-Source: AGHT+IHIaBPww4NUweWCTqWg13olD2CoFRyn8srMULQxL28/S7iOsYX8yyzacHcoPFbRY9F8s4phJw==
X-Received: by 2002:a05:6870:f153:b0:229:f022:ef83 with SMTP id 586e51a60fabf-2779035fabdmr1840332fac.43.1724902056599;
        Wed, 28 Aug 2024 20:27:36 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e569e34asm198107b3a.111.2024.08.28.20.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 20:27:36 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 4B9E78070F;
	Thu, 29 Aug 2024 11:36:12 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v4 2/2] mtd: spinand: macronix: Use the flag in Macronix driver
Date: Thu, 29 Aug 2024 11:25:17 +0800
Message-Id: <20240829032517.1517198-3-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240829032517.1517198-1-linchengming884@gmail.com>
References: <20240829032517.1517198-1-linchengming884@gmail.com>
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
 drivers/mtd/nand/spi/macronix.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 3f9e9c572854..f17cd4a6f4d0 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -118,7 +118,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT | SPINAND_HAS_PP_PLANE_SELECT_BIT |
+		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 	SPINAND_INFO("MX35LF2GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x26, 0x03),
@@ -156,7 +157,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT | SPINAND_HAS_PP_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 	SPINAND_INFO("MX35LF2G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x64, 0x03),
@@ -174,7 +175,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT | SPINAND_HAS_PP_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 	SPINAND_INFO("MX35LF4G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x75, 0x03),
@@ -213,7 +214,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT | SPINAND_HAS_PP_PLANE_SELECT_BIT |
+		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
 	SPINAND_INFO("MX35UF4G24AD",
@@ -223,7 +225,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT | SPINAND_HAS_PP_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
 	SPINAND_INFO("MX35UF4G24AD-Z4I8",
@@ -253,7 +255,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT | SPINAND_HAS_PP_PLANE_SELECT_BIT |
+		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
 	SPINAND_INFO("MX35UF2G24AD",
@@ -263,7 +266,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT | SPINAND_HAS_PP_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
 	SPINAND_INFO("MX35UF2G24AD-Z4I8",
-- 
2.25.1


