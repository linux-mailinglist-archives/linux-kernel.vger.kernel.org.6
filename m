Return-Path: <linux-kernel+bounces-246837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB95792C7D1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE351F237E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F679475;
	Wed, 10 Jul 2024 01:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVQGpIzY"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C0B1C32
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720574226; cv=none; b=pltklh+4NWdDGAt+Eu/gUn8KllOUkrdnmHdxF7TqPkrNSgd8aaqvfs8dQN7/dVcWwPeUh4lskWcV/HqczLZjpWOUjUaruTucGFcaHWf4YbrQ+gLncqP01PKAyo4v0hpWtaOalMbCh/twau0qmoQcEGCslzCwD6H1ksQpZZ87akk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720574226; c=relaxed/simple;
	bh=4cZSetaS9hoUEfGLBiLSgIMKQxOmG/FQsVPFin+9B7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SUegWZUcDFZNX76+EN8pkiKbVnt+3vTRiKTbMrG4RR7CZzNhkG/ZaIFH+CDPvyrlOqk0BVi/LjQbukhUW7wI6XRcYmyAA6RIkRteK/Sbsr5CQ6JWQlgff9IeYAF2plPvLAxSOR4Jz5vJLLGm9eG9zaf1PC3OHdJhITzNy91YND8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVQGpIzY; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-70df213542bso3115296a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 18:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720574224; x=1721179024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEYUgRgAX3U4wZonxbVp1RvGhxBw1XYv1pj8Gg2uytQ=;
        b=nVQGpIzY2EaCUHaxZkoiHHzJAczXC4dtrb6tKFaSBzT0BrL0WPqTaOog50yEIOan6n
         emjDLSBwpjgL7CU9z5z34UTpCpLkhEMgIxV8ZE6prhaiCjetK8YZVQuKVKzK3G2t+diD
         tVHfuaCVegPImfwBWOicAfLwoj6dMhHxNf7FSEvbwIcyp/aNT7WrRRn5dZNtCkReLe3I
         t09oAHnMjG3xHw86sB6XQiOAqnTCK3y/0g/nGw8ejeT+VNJiwyD9XWWwG7xkf5GM7tef
         +VwHNl+VBRdmOceV4InILFSXPI0ogr4/3FHd98JkXCprTbUXRo6di3XaZLVnOk19sYMA
         wDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720574224; x=1721179024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEYUgRgAX3U4wZonxbVp1RvGhxBw1XYv1pj8Gg2uytQ=;
        b=CeAgjgMOp3FH4IYls9Y/3pLjKdxZu8pRR8pMDKmouu4nBIf8SZWdaJnMBB4Ak6vIsX
         kimm03KbmOal/3DYGHsFAVE8BJnZrsf8uMVkg0/06Rffpmv/5kcwJqKNKr8dtWxc/FjP
         +btizi7Km/jVD1D1Zwi+4GtPpVtSR5Y6Qasxp88FWq28D5cgAn+V+eKirKF2SzGk2do+
         W4As46r8A7eeoKKQjIOlsdrYxVwWRKXaSYrBw9ab5qftaQXNcHSFMQFg31s51/Hqx/2z
         kNg5l9KuSJFUfJq4T92c8rvD/PDlbsQfa71+9ns9qMIoSIwFl1z8JBIVBHsJMZhDctZl
         jIBA==
X-Forwarded-Encrypted: i=1; AJvYcCXCkW5EJF0WA9O2M7g5NiXjHjJ6zEWmXjG2mImre3QdQf5d1DW442VJLH0a+2EX9xEGYG4KYVH1Idg0uoz3gvRUgMJilu9ic62WT/8y
X-Gm-Message-State: AOJu0Yw81Ww/el8idACOiuynji/n04QjrK8on6tPxft2bGv+ps36KtlT
	NKEN14rA3VLoD4/7Kh3fGcN7vLp3HQZUyLH+3BiriyudD4YzXcANkjGsTQ==
X-Google-Smtp-Source: AGHT+IHmS97jexThoPIwIyD6WHVucBTTOKtk03NW9U9PP/pL/Peaar9imzg5L17ydYUIhYovDsgw0A==
X-Received: by 2002:a05:6a20:da8a:b0:1c2:8d3f:793 with SMTP id adf61e73a8af0-1c2984cda76mr4332546637.46.1720574224311;
        Tue, 09 Jul 2024 18:17:04 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a95624dsm10689540a91.20.2024.07.09.18.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 18:17:03 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 5526B80D2B;
	Wed, 10 Jul 2024 09:26:28 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 2/3] mtd: spinand: macronix: Fixups for PLANE_SELECT_BIT
Date: Wed, 10 Jul 2024 09:15:40 +0800
Message-Id: <20240710011541.342682-3-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240710011541.342682-1-linchengming884@gmail.com>
References: <20240710011541.342682-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Macronix serial NAND flash with a two-plane structure
requires insertion of Plane Select bit into the column
address during the write_to_cache operation.

Additionally, for MX35{U,F}2G14AC, insertion of Plane
Select bit into the column address is required during
the read_from_cache operation.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/macronix.c | 51 +++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 3f9e9c572854..c61f1ba31f0c 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -100,6 +100,39 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
 	return -EINVAL;
 }
 
+/**
+ * Macronix serial NAND flash with a two-plane structure
+ * should insert Plane Select bit into the column address
+ * during the write_to_cache operation.
+ * Additionally, MX35{U,F}2G14AC also need to insert Plane
+ * Select bit into the column address during the read_from_cache
+ * operation.
+ */
+static unsigned int write_Plane_Select_bit_in_cadd(struct spinand_device *spinand,
+			const struct nand_page_io_req *req, unsigned int column)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	return column | (req->pos.plane << fls(nanddev_page_size(nand)));
+}
+
+static u16 read_Plane_Select_bit_in_cadd(struct spinand_device *spinand,
+			const struct nand_page_io_req *req, u16 column)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	return column | (req->pos.plane << fls(nanddev_page_size(nand)));
+}
+
+static const struct spi_nand_fixups write_fixups = {
+	.write_to_cache = write_Plane_Select_bit_in_cadd,
+};
+
+static const struct spi_nand_fixups read_and_write_fixups = {
+	.write_to_cache = write_Plane_Select_bit_in_cadd,
+	.read_from_cache = read_Plane_Select_bit_in_cadd,
+};
+
 static const struct spinand_info macronix_spinand_table[] = {
 	SPINAND_INFO("MX35LF1GE4AB",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x12),
@@ -157,7 +190,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
-		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
+			 SPINAND_PLANE_SELECT_BIT(&write_fixups)),
 	SPINAND_INFO("MX35LF2G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x64, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -175,7 +209,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
-		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
+			 SPINAND_PLANE_SELECT_BIT(&write_fixups)),
 	SPINAND_INFO("MX35LF4G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x75, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -215,7 +250,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     mx35lf1ge4ab_ecc_get_status),
+			 SPINAND_PLANE_SELECT_BIT(&read_and_write_fixups)),
 	SPINAND_INFO("MX35UF4G24AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb5, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 2, 1, 1),
@@ -225,7 +261,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     mx35lf1ge4ab_ecc_get_status),
+			 SPINAND_PLANE_SELECT_BIT(&write_fixups)),
 	SPINAND_INFO("MX35UF4G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xf5, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -255,7 +292,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     mx35lf1ge4ab_ecc_get_status),
+			 SPINAND_PLANE_SELECT_BIT(&read_and_write_fixups)),
 	SPINAND_INFO("MX35UF2G24AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa4, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
@@ -265,7 +303,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     mx35lf1ge4ab_ecc_get_status),
+			 SPINAND_PLANE_SELECT_BIT(&write_fixups)),
 	SPINAND_INFO("MX35UF2G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xe4, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
-- 
2.25.1


