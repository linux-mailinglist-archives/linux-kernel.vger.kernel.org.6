Return-Path: <linux-kernel+bounces-312026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA848969101
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2422CB21139
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12631CDA02;
	Tue,  3 Sep 2024 01:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnyAE3Mm"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872FC1CCEF0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 01:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725327526; cv=none; b=rbo0rcB9IB5XYSPtcwTNXCOECCNIE36IG/nC5hlyXrdtCWGY6+o27K6ZO5HhpeaqMu/jZZ9PM6KUNP2fyCeBokYY6Jk774Rx1J/w0y34cQiuNf+H9doM5zoAiC/i0R62fhAt9NsJxnZhrLJxSADqud++U/nAkCPPDndzq7KabmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725327526; c=relaxed/simple;
	bh=3oW9a+fDXt43lNjqIB3EgW0dF5iWgx8lb4hR3cTcPFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bwe2lXQR4q3/Ng0DME0ESv44eKUXc089c0k9seDI/USyfLbQXsah6zTZXwgoXY3y7LbSN9smPl+lR/RjP5bWpd1VWpysOAub8FXQsAOL0prRsa17I/BcBTWHoGX/tyDUDj6mjMOiNAS8g8rFTZVBOVC3y8Og0pv67XVOOBJFoA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnyAE3Mm; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2781cb281abso67286fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 18:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725327524; x=1725932324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6E7ALM61L5GXDCpe2fwl5R6dNU8EMojsouVXbwTg9g=;
        b=QnyAE3Mm2iFZYYHaHjbfllQmXnmok12Uek0zIBq00mEDAQgIN4gBkRWnJ/9lkwQ/xU
         2HA0bkJimLvFFkIZDelUTgk+FwZUzA+pAOK6eeRps98bFajbVwMvzpQwypoHP/6lS86Y
         pkpzldQgukmDL/feT+1HYXkgdX1czdpqa8g02NkfhE+FElD4FVJ4IrmvWT55oY6hiCab
         EC1dAsQW408fob6rX0AJgNsoxwjtYJ+bCECKqldLuCsU5bmIubgyJhrAmC8+ExQ0j2Ld
         XhqujGBYJ3ez8/3Qlo3nJHSX+8URSgz96ariDrpzGCI6AZVq8Ig71rSB51ocbItVT6gs
         FQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725327524; x=1725932324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6E7ALM61L5GXDCpe2fwl5R6dNU8EMojsouVXbwTg9g=;
        b=Wb9l2LwofuCHSgasLsEeOGKl6AoQ/ct0BCLdxqmjenSq2PNtwT472aHjwKxvl26I05
         ybNtQ5UwmRsJNFinJ3zzsUvLcU+qXVgFeZhXbymzExFqNrLcq0ndXlGcAWq5e5pBvm/Y
         IACzlstzMOJ91a1nHQrlF9/FEeFFArlcBIx+MC5tBBYJDPEk4wABwtx+GbdOD6wu+4aR
         K/l4q6P5qpQdcBDCh4Ir6Hxg4FPPSn+jYX/UCQWHQpux2k8a7eVg3kwtshDtwUMvUhhL
         kxtrfE5/VbSTMWfuEpy37vQ6YIqjEGe/uQH4hgcEBeuIJA2jNhj3QR29/q4J+8hgUZs6
         IB5g==
X-Forwarded-Encrypted: i=1; AJvYcCVRIMqI+td/jfNSSuRnRBu2FgxlxQP8HkzMTiSN/lcQlrqjW5lK+5aWALTpSIlzRNPGLppMK46+5kQ0jVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuDFGjJoMhAO0ZRgo1+x73ThtzQ4AVBCwoWY71Z4iaNXYn1192
	Uw0CC1bS4WS7VkBh61XaElzAAf7fKd6OGIfyie2Unw0QKG/99m5G
X-Google-Smtp-Source: AGHT+IFH7BOn7Ydiv3r3QpGrT8jgHuvBDLr4r/TxUf+m57OlNIDZlwFnzLVzLLof2Py7nhd2QdxFSg==
X-Received: by 2002:a05:6870:a7aa:b0:277:e6fc:4a69 with SMTP id 586e51a60fabf-277e6fc4eb8mr6024916fac.2.1725327523444;
        Mon, 02 Sep 2024 18:38:43 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d7804sm7405114b3a.154.2024.09.02.18.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 18:38:41 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id DE1E080526;
	Tue,  3 Sep 2024 09:47:09 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v6 1/2] mtd: spinand: Add support for setting plane select bits
Date: Tue,  3 Sep 2024 09:36:24 +0800
Message-Id: <20240903013625.1658825-2-linchengming884@gmail.com>
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

Add two flags for inserting the Plane Select bit into the column
address during the write_to_cache and the read_from_cache operation.

Add the SPINAND_HAS_PROG_PLANE_SELECT_BIT flag for serial NAND flash
that require inserting the Plane Select bit into the column address
during the write_to_cache operation.

Add the SPINAND_HAS_READ_PLANE_SELECT_BIT flag for serial NAND flash
that require inserting the Plane Select bit into the column address
during the read_from_cache operation.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/core.c | 6 ++++++
 include/linux/mtd/spinand.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index e0b6715e5dfe..e7b592cdbb4c 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -386,6 +386,9 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 	else
 		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
 
+	if (spinand->flags & SPINAND_HAS_READ_PLANE_SELECT_BIT)
+		column |= req->pos.plane << fls(nanddev_page_size(nand));
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
 		if (ret < 0)
@@ -460,6 +463,9 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	else
 		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
 
+	if (spinand->flags & SPINAND_HAS_PROG_PLANE_SELECT_BIT)
+		column |= req->pos.plane << fls(nanddev_page_size(nand));
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
 		if (ret < 0)
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5c19ead60499..0e0df620da53 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -312,6 +312,8 @@ struct spinand_ecc_info {
 
 #define SPINAND_HAS_QE_BIT		BIT(0)
 #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
+#define SPINAND_HAS_PROG_PLANE_SELECT_BIT		BIT(2)
+#define SPINAND_HAS_READ_PLANE_SELECT_BIT		BIT(3)
 
 /**
  * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine structure
-- 
2.25.1


