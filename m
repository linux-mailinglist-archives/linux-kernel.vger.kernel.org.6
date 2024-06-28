Return-Path: <linux-kernel+bounces-233653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E573C91BB16
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02B8284BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF6D157481;
	Fri, 28 Jun 2024 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imTUli1q"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60BA157478
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565608; cv=none; b=CzsyZ9EJhNRFUden+77oIOl/Yi6djLcNw5U2cKiTd0GYNMlyaFvXaNTkNqHm7j2Mhw0+/YxPc47mGBdcmsiOE/GQJh9PM4fsMBpSEob/z/PeNeQXeonYtdnBT35ceJ7MwoFGlU2EXi3f2Giy6Cvp4NnXBdh1pmTKpB3FXemv1l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565608; c=relaxed/simple;
	bh=4Dsj9ayn2Oa78jorOX6zSODmYZsKhMC24a4bT2nQZFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PbX2pcSt43H0rQgfb+2qaHG/IBX4mVswfRkuxlH3kr8c2cw+edc9D/FQrwnwCoxvlLriufNZqnGmdie/8EBxhjuokMc+ICsTLo9Gp+yIk7ouGD9tPHiusBYxbl6BP/XFJqA2SCPMv9Wg14myN73v0N6X170J1ZHgRFJFrDtSjDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imTUli1q; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7065a2f4573so302253b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719565606; x=1720170406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KE+GAHekiqQQ+6g1wyBk2AinFm8Z+Wz7HeNtPOPPiPc=;
        b=imTUli1qDpU+B/VfgGHrP3hb7zRAQU9cT7U27dyWCrzW6TUz5ufo1CKPsf5wJBiIHa
         +8mRh6hY4BTL6Gq5rXdewkTOXipjpvfuG9c4d2HNdhPTbh3kTBPBg/4x+W/nZBeJvctE
         EE1QrH4W2IKRWqRn0tRUN3g1VYDx/AjcWjke9C+urVciS6BfOVppHVYO7dy9XZNSmj6x
         uuB3E9rkuDn9d10uQJlGyeCq0mJHvIdHgyXS/3rcgnYUwLk5pNuav+dOmp8twIORKOg1
         frAg6Cke0wcm58t6f1GzGmUzu2PNWaDS4gHFOl47773rRnoPpk3ppZU/EVfelT91d/Ec
         5vSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565606; x=1720170406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KE+GAHekiqQQ+6g1wyBk2AinFm8Z+Wz7HeNtPOPPiPc=;
        b=Eb9vFup/H2Dct6zoJzv2mwz3WswRwQoaGDajjqc4LSHxgLmioVXGnfuEo54lGhXFEI
         lq2Sit9HXn8gRnlxiPOTeCpkIh/OgGpCrjCARjguB9eqPPJnel6A1aLgzrqwz67JbHtQ
         TFc7aEsuLsQcf7Dlu+0mk5fDPzLv/R7RKtbIjsbsDmdyfOvH1iRId/F1X7749RWl/495
         f7hzg+/+UIAjkrT613/GTdEm+pT1AznPRBV9cVOjyofH6x3o1579PP/s4B8hz+37hPnX
         zhuUnncOiSnPSHnoEwjB/RiIyVDz41DdExsB3muA9Q7gs2I+3cmi3BcIzzSoLjaGAKMX
         N5QA==
X-Forwarded-Encrypted: i=1; AJvYcCVYt6BSrfeFFM160iLz96WQTccoKWB9rHGZD0LecTzK+ODUwRDmwEoRIjC9Y+8DvI0DBzLCVVP1bs5/82FLN1FqcSj/6rZgehebO3wI
X-Gm-Message-State: AOJu0Yyotbg8Tt9nq9Wk1iqe6EQgrIVsey/U9XFsOCNlXU96gDxY5AIo
	wbUVwJdXBSDZB4XDWzyWD12Q0xdLjL8aekcj7kVjwx7pCfq3Tu7P
X-Google-Smtp-Source: AGHT+IH7O3ceew/tSG3NDVJpYlbtMuwR5IFLdkA8b8eK+PcdH6NneHqE1C+XNacGpenvZxl/Ayl5vA==
X-Received: by 2002:a05:6a00:2d93:b0:706:8066:5cd6 with SMTP id d2e1a72fcca58-70680665df3mr17761645b3a.32.1719565605922;
        Fri, 28 Jun 2024 02:06:45 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e63250sm1086981b3a.29.2024.06.28.02.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:06:45 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 3A8A180570;
	Fri, 28 Jun 2024 17:09:00 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com
Cc: richard@nod.at,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 2/2] mtd: spinand: macronix: Add support for serial NAND flash
Date: Fri, 28 Jun 2024 16:54:44 +0800
Message-Id: <20240628085444.132714-3-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628085444.132714-1-linchengming884@gmail.com>
References: <20240628085444.132714-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

MX35{U,L}F{2,4}G24AD-Z4I8 are Macronix serial NAND flashes.

Their main difference from MX35{U,L}F{2,4}G24AD lies in
the plane number. The plane number for those with the
postfix Z4I8 is 1.

These flashes have been validated on Xilinx zynq-picozed
board which include Macronix SPI Host.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/macronix.c | 38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index ffcaf1a6947e..ae33bdca94e0 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -158,6 +158,15 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+	SPINAND_INFO("MX35LF2G24AD-Z4I8",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x64, 0x03),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 	SPINAND_INFO("MX35LF4G24AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 2, 1, 1),
@@ -167,6 +176,15 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+	SPINAND_INFO("MX35LF4G24AD-Z4I8",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x75, 0x03),
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 	SPINAND_INFO("MX31LF1GE4BC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x1e),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
@@ -207,6 +225,16 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF4G24AD-Z4I8",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xf5, 0x03),
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
 	SPINAND_INFO("MX35UF4GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb7, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -237,6 +265,16 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF2G24AD-Z4I8",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xe4, 0x03),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
 	SPINAND_INFO("MX35UF2GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa6, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
-- 
2.25.1


