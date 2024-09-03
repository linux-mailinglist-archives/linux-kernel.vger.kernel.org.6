Return-Path: <linux-kernel+bounces-312027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9840969100
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752531F23B7F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9541CCECB;
	Tue,  3 Sep 2024 01:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hou5u4yQ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9A31CCEF5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 01:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725327526; cv=none; b=mFersDu1jRNbTr9bUC61HS1pjYh2qe1mIDMT+cLfAbF8bmbXztA3Ytf1tQa7OBn7uwkReQTyDFKgtNL0uo8JvnULZ9Jr97WNcptGuNJZ/WGdXzD3rF3o9pzQ5yjLD27ftaT2yapXQGm8qDRSOw4MSi5CN33fHmSfBmFDhVmRbdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725327526; c=relaxed/simple;
	bh=tolGfl03yLfaWqeEhCeWkliWUwPxOzr1OwxM/FadN28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kqbv7u4sdRY6hbJJgRjsDGv5CUjQV8CBdlVr0Uz7hCTIbjfA2ng+K2pNFN/4eCqeFJCssZZoqe6aVW7plabiw+lsNpACkXs0hoI7NYg4U+dt5yrkcb6sIjqIanrBewRfEh19bYNrC4e4+vGngaYoELQb1aot3PEI0tO2aB+2T3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hou5u4yQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20551e2f1f8so19142945ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 18:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725327524; x=1725932324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujFttD3pwqoLnOaK61kxmmuY79VSw05G+mBIn6vQcDE=;
        b=hou5u4yQa7hlhGnebxtdVKbQffKa3WVppbfOZAugy/Vrn6wDSPYpXBhdWDcE9ttNHx
         mIdvlxEqyflQC89EqDZaGiCR1ewol0VYHDD8M0nwuCvJrdJuI/D06Jt+h39hnnoKxqbl
         MuGVWqt+Bo6jAMBywd+tmyH8phiY0BktB/pe1abGqNbmNj1vAsDaKqtoqNRE0nSW7qlU
         BWS/+5WDP9jzYlf6v45tdnF/UTAuwj14BtcI86jZCpYMxH7gURqj5+DDHPhXecEx4isf
         F5zjWb+s0iU2XCA3Spadtd+2UHcwTpLgabx1zh8IR/QGKmKCg8GP3KZbqGB/OhX3Gxu8
         2ODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725327524; x=1725932324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujFttD3pwqoLnOaK61kxmmuY79VSw05G+mBIn6vQcDE=;
        b=J+GC8zJ8xLF8hrPTc7NEo6p5dhu5Iy/z0uDWxR0FFpFaffj0e3EOjdIQ+g2+VeLhqh
         8iZuRyYq2tXFmaIlIwon7qV63Z45K5z43Ib3YhQSDksvOc2MRUIsQnNlxvabkRKkkypp
         Wb8qlCxH8S2N/FchaVz+vwW7R63EFyOqnVT4iQMx/beiZkCpm2q1nU+oLP0kL5wgSwVz
         V1TBYRBuLygqDBvliIKAEThPNVukdjt7AcYJnNwt1KEytgi2pU+ItIFVRAszkv7DoV23
         hQ9qU3hSJjDMWSdClLYR4xofWuzc0cizXubvOnbEV49VMT9hm7XcdrHzEf8rXPyweQXR
         NG/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsNBQtn2jQmAinFh1Di+RjKk1cn7kSzKb1KgapL81CWtTEbTg2//Jcq/8GCq1dPvjv7IStXAOtVYLMeQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyOIP4vC+4NSOzh4fL20rXSTRCM6Ylg3Q14mJEJtawcBdaBenw
	QeukgyNb4DkTbKI2VzTksKQRXJMh1D2fDbtPJX7+t9/B36fbdztM
X-Google-Smtp-Source: AGHT+IFtuSBup7LMg7m4f9UYikvtoExFDkt9GoIGABbjoibnui0xTXGl2XYwYOv7QjgeaRROpNVjnQ==
X-Received: by 2002:a17:902:dacb:b0:205:5136:b2fb with SMTP id d9443c01a7336-205841a4376mr46479795ad.23.1725327523827;
        Mon, 02 Sep 2024 18:38:43 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20555dd1520sm35107915ad.230.2024.09.02.18.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 18:38:43 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 9B1EC80484;
	Tue,  3 Sep 2024 09:47:11 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v6 2/2] mtd: spinand: macronix: Flag parts needing explicit plane select
Date: Tue,  3 Sep 2024 09:36:25 +0800
Message-Id: <20240903013625.1658825-3-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240903013625.1658825-1-linchengming884@gmail.com>
References: <20240903013625.1658825-1-linchengming884@gmail.com>
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
index 3f9e9c572854..9c93dfcb955d 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -118,7 +118,9 @@ static const struct spinand_info macronix_spinand_table[] = {
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
@@ -156,7 +158,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 	SPINAND_INFO("MX35LF2G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x64, 0x03),
@@ -174,7 +177,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 	SPINAND_INFO("MX35LF4G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x75, 0x03),
@@ -213,7 +217,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT |
+		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
 	SPINAND_INFO("MX35UF4G24AD",
@@ -223,7 +229,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
 	SPINAND_INFO("MX35UF4G24AD-Z4I8",
@@ -253,7 +260,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT |
+		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
 	SPINAND_INFO("MX35UF2G24AD",
@@ -263,7 +272,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
 	SPINAND_INFO("MX35UF2G24AD-Z4I8",
-- 
2.25.1


