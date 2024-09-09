Return-Path: <linux-kernel+bounces-321039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A659713A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DD36B2223D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AC31B3B0D;
	Mon,  9 Sep 2024 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtDPjYqK"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD2C1B29D8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874146; cv=none; b=IHDE34tSkocOeOr9bFOEktXsla4aHjaJRo/z/0vVYurScbWG7Nobb3UpTTvdeTM1tvKwdtJbMRitYdDyg0YVWovHlsq9CXy8SpuJIMzvAnb/4lA+bvlJyzetHri5SA7pf7ozjrkG+jqg5YQqkL0KEiEtrUW9qsjpX3xnMdMD97o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874146; c=relaxed/simple;
	bh=cglX6z7/MyogYeBjqzw7gAzVUFiiLaeeWeBltZuIlOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G/KgSJqmJl2lkv05n5LifEZ5lm+SkHcV3CsjQUS8LbhKI6XgmZGoWASOwCI6CHTpfOCqpJgcqaNX1e/OhwtCm7qSlsxisLpdIMF9OEQPWCaI1XkjZsiaFlHByij96g6bZt4gvGUyQfAI26qZ8vFCJ1R0IxyVrXGda3rDsLA5G24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtDPjYqK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-205722ba00cso34349435ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 02:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725874144; x=1726478944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCfu1gkMkZEEvD27FE8IHnEv5HMGsSiqFHDKtjH/N7I=;
        b=LtDPjYqKFvHVs5qNUAnoS/ynZRmOSOwrQ5zb0LOlpMo77LwZ+rZlditd7/TcnzU5Nx
         LG3IWziX0XRMd5GM87608IWZPDFIDn0lKFeBgaQsCNZqE6cEoaDnj3cVo4uQnUx9HTS4
         hgvT89bL3ALYFn15egi+LEvWvIri+wuv9LonTrtG7KiskS3lFK9AIGvVgvrJnPTzbE3q
         0NIrnG4wDUJFFdEtL7YJGiEWUIVNe/7Vvp17hkTkyuHjqKoNXKfit8ql2JqcNKxl/oFX
         rvpys/dUEBvvJgOAdmK1kna4OqtPYmMI/m09ggL0LIf+CSqgxBkPSpMTuhgMcNX1p0U5
         p9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725874144; x=1726478944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCfu1gkMkZEEvD27FE8IHnEv5HMGsSiqFHDKtjH/N7I=;
        b=SZ4JccvyJGji1EDfq//LACFzrKkkoEoyqY2/xNNCQKMPzLpE03SkbgCVFdYE+9owVb
         brU57QJD9eWoRzOWu91ctC2fvLEMIpmiFsrL1Sv958zlEo8F3ekNSLqy/1ga/QRwyMnX
         8zLIfHuh77fTihLkcEgi4TvUUp+xosZY4pUa+R0d43fQ9M96tOjVaWLd9kEBCsDTOKg2
         RbakYN9yK7qjxD0ZgmdTaxvC+38otrXTDB0KiiV30jyXl9YXilbJwHMev2hvRY2qdKCJ
         peV7fA7hm+7r5Z4sSvZf0tMja8fnWBu6G3DoC4ug4982cE62WO9mQop4pvkSFmYb1uwX
         grUA==
X-Forwarded-Encrypted: i=1; AJvYcCWvp4BCXtS6pHIqi62se3UCMeyhNjILFDmAzzzpzcSl+hi8v5zpOER2QtUzMV/MhZbUgm/LG0NkhfiuY88=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwx+6nDo2uAPUjqQiyb9Fv9eGn4cEL/Q5b8K+vwHqmgRrSKiAb
	Oru0DZ9roEBT3G/NIb07E4lXUAwYbn0ir9BKcoE25D3Mi5DW35lw
X-Google-Smtp-Source: AGHT+IFk8/HueAs518u/SbDnhUiKpdPaHH8sqnL0f6H4XMT9vBVrmGmp2A2fi8EXz5O0/ILeF3DvuQ==
X-Received: by 2002:a17:903:230d:b0:202:2e81:27a3 with SMTP id d9443c01a7336-206f0531120mr98881235ad.29.1725874143701;
        Mon, 09 Sep 2024 02:29:03 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f1e99bsm30183995ad.207.2024.09.09.02.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:29:03 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id B28AD80422;
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
Subject: [PATCH v7 1/2] mtd: spinand: Add support for setting plane select bits
Date: Mon,  9 Sep 2024 17:26:42 +0800
Message-Id: <20240909092643.2434479-2-linchengming884@gmail.com>
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
index b7518f0f7d71..5e40d6fd258f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -408,6 +408,9 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 	else
 		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
 
+	if (spinand->flags & SPINAND_HAS_READ_PLANE_SELECT_BIT)
+		column |= req->pos.plane << fls(nanddev_page_size(nand));
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
 		if (ret < 0)
@@ -489,6 +492,9 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	else
 		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
 
+	if (spinand->flags & SPINAND_HAS_PROG_PLANE_SELECT_BIT)
+		column |= req->pos.plane << fls(nanddev_page_size(nand));
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
 		if (ret < 0)
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 228ffda8b50d..978c399b1784 100644
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


