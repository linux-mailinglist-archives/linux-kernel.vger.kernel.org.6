Return-Path: <linux-kernel+bounces-256123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57F9934967
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5352834BB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9217678C92;
	Thu, 18 Jul 2024 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk94FB+I"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6C342078
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721289314; cv=none; b=dUUnQg9Y/S/HRJ50FVBScQVZ7d5ui2r5/Td6JzpRFMbetQdqVHRB+Zw5nZiu2VcRZQzTSf/6SOno9T3tE5+2ju2qUzXtJ1SvTXAAF5NlaTw3EFLM9YVmo2NZn1eqfuhT7SImpvjXvWJXkMktlBLWAZjorHLPjfN+d2gUGtxdC2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721289314; c=relaxed/simple;
	bh=umVayuupYarZH+PmjcPDSoNYzVBtZ9x36lIaRGhWVas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uwFQIwufEWuvuMAPP52uiFOs6GuYmt9JeOsDZjMdRctENnEX4aPkhj+2t5anA8FfDpUi3b7RfZL8S84O1hXpHo1noY1aqMHS5I1W6V/bC2pPl/0p03cnieFyWt1+D90qRcS+oxy380rbmerAL1thhhbKzildkrN942CQLyeH4wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uk94FB+I; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70b04cb28acso357042b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721289312; x=1721894112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=304XxPdIY97QOPQp6+4IYR7ZGs5YizzMEdMpSztbtjU=;
        b=Uk94FB+Iq/MmkNr8DDB1xFyT9seBpcTzFfX0lyWvyXbTZmVVPJ/uS5LJTCfrUNluHv
         HQwWoFmbIL/XivFVR79log2GTFEITGmcxSfuPVyp3F6Jy7G5udNUpBZn7XB8PKcpd+XU
         2h+tXUptzCFy5Lr/RICrGBs8i64ePmBnTV7FIs6pXUKsTZys2ZtOZWZTjYz2BfiCvwxW
         4K5eITK9VItsbeQs4tgMQh3STgY6B9N4kfW+ENHcZTlmoRXP+Ds1QbCsbE+QRzBPYIDN
         pX7C7FjsUhBvR5zRQKxyM8jqVLz+aTipj/65xdwgLhHBLN5cDpt+HmBqNQFQyiDILn5C
         Yv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721289312; x=1721894112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=304XxPdIY97QOPQp6+4IYR7ZGs5YizzMEdMpSztbtjU=;
        b=cop9A0N8JHAXDhDSd8JeCf6YxRrB0EQtS49lnrNzK7T+A1/1QGvSHN0I3rbbHSK8s/
         xvnStlj/YqOuhCZl5lRdzULMBAQpJsPCRENGjgLFmkYecUAzXbwyARIwDGP3GGfUwc7T
         X6nDF3SjtRj+bBotkcUqcYaE6lkjD+1HK5ZQpok3EPzJXaWVPdBDQ7ooq9RRe70X7pky
         5yQa88Pb7+jShoBQHbvSONPBrQYdZszESEr0KypBF+vqSh4mG3xI40zTqNug8coNkQ+z
         CDKSFe6+reSno5Iu29wqAMO8TGbpU5fXhQZZx0/KAxRSAlI2GZ/Nh1C0t0Ysd/Kwt3mg
         TkNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeugJ23xu1nrwV8Hv7YIlTYQZacix4SGuwgXIMxw29i06VJzxgwWt5QXzcWgf4VpzTwq3Cbaobiqj6GnlRgHSLV2Lpnvit3WbEhzk2
X-Gm-Message-State: AOJu0YwaTh4QAcjK9n7AOHp37HdLrs4HbBquul+FlSZGg/tANavlY0zP
	qzmaZk5AjwScy19xiQ9FX+yZ8s94MwcCVV98tlLiLV9D1S0G75SP9fYRsg==
X-Google-Smtp-Source: AGHT+IEWxyPiFAAxxPlAPxq+aPk2bH8COQh+m7VS8/MYAxBvVhN9mvGG7OF8ruvsGlqyh01ysR3BMg==
X-Received: by 2002:a05:6a00:78f:b0:70a:ee81:2fa2 with SMTP id d2e1a72fcca58-70ceeaaa6b8mr3052670b3a.2.1721289312447;
        Thu, 18 Jul 2024 00:55:12 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eca69f0sm9443573b3a.150.2024.07.18.00.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 00:55:12 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 7D21580483;
	Thu, 18 Jul 2024 16:04:22 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v2 1/2] mtd: spinand: Add fixups for spinand
Date: Thu, 18 Jul 2024 15:53:55 +0800
Message-Id: <20240718075356.488253-2-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240718075356.488253-1-linchengming884@gmail.com>
References: <20240718075356.488253-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Add struct spi_nand_fixups as SPI NAND fixup hooks.

To determine whether the Plane Select bit should be
inserted into the column address, add the member
struct spinand_info to struct spinand_device to
ascertain whether the device has fixups.

In the function spinand_read_from_cache_op and
spinand_write_to_cache_op, add an if statement
to determine whether the device has fixups and
their corresponding functions. If so, give the
Plane Select bit to the column address.

In the function spinand_match_and_init, add
spinand_info in spinand_device for determing
whether Plane Select bitg should be inserted.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/core.c |  7 +++++++
 include/linux/mtd/spinand.h | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index e0b6715e5dfe..d6d6f3832f9d 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -386,6 +386,9 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 	else
 		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
 
+	if (spinand->info->fixups && spinand->info->fixups->read_from_cache)
+		column = spinand->info->fixups->read_from_cache(spinand, req, column);
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
 		if (ret < 0)
@@ -460,6 +463,9 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	else
 		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
 
+	if (spinand->info->fixups && spinand->info->fixups->write_to_cache)
+		column = spinand->info->fixups->write_to_cache(spinand, req, column);
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
 		if (ret < 0)
@@ -1095,6 +1101,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->flags = table[i].flags;
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
+		spinand->info = info;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5c19ead60499..c079c6ac1541 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -354,6 +354,7 @@ struct spinand_info {
 	} op_variants;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
+	const struct spi_nand_fixups *fixups;
 };
 
 #define SPINAND_ID(__method, ...)					\
@@ -379,6 +380,9 @@ struct spinand_info {
 #define SPINAND_SELECT_TARGET(__func)					\
 	.select_target = __func,
 
+#define SPINAND_PLANE_SELECT_BIT(__func)					\
+	.fixups = __func,
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
@@ -398,6 +402,18 @@ struct spinand_dirmap {
 	struct spi_mem_dirmap_desc *rdesc_ecc;
 };
 
+/**
+ * struct spi_nand_fixups - SPI NAND fixup hooks
+ * @write_to_cache: program load requires Plane Select bit in CADD.
+ * @read_from_cache: read from cache requires Plane Select bit in CADD.
+ */
+struct spi_nand_fixups {
+	unsigned int (*write_to_cache)(struct spinand_device *spinand,
+				const struct nand_page_io_req *req, unsigned int column);
+	u16 (*read_from_cache)(struct spinand_device *spinand,
+				const struct nand_page_io_req *req, u16 column);
+};
+
 /**
  * struct spinand_device - SPI NAND device instance
  * @base: NAND device instance
@@ -449,6 +465,7 @@ struct spinand_device {
 	u8 *databuf;
 	u8 *oobbuf;
 	u8 *scratchbuf;
+	const struct spinand_info *info;
 	const struct spinand_manufacturer *manufacturer;
 	void *priv;
 };
-- 
2.25.1


