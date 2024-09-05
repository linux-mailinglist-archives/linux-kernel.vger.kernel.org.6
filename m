Return-Path: <linux-kernel+bounces-316385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E44C96CECB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E951F27510
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06BA189BA8;
	Thu,  5 Sep 2024 05:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAV2kTCe"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B79189509
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 05:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725515749; cv=none; b=rp1VVeDqWslqUjWgMQughfckJeZsX4zWohMb2GKczAGmjDP7HVjW7XFhyVXLOdqFm7vAxTrPaJ22j/4EsBUuKsdyi2jaU5kBO+G8XlNcjAm/iKAyqvJ4xJ6MguVss9zzro0DlX6WzEMpSK/Rgsp7ph1aIaCO3A8E4+vvdcrgwmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725515749; c=relaxed/simple;
	bh=wWTjTLPEL4BgFPkdwzZdwggX9pDeRQfeFXmDx24RiYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QX3vqbkJJrfeqT8T7XRxmA7LTezbYj6H+RyTyJe3SSL2bTp+ayX8DdRou60QPz14xGnQj0WVUYs7ikxy1bIJZrkVVoBb09OvZy06yPXYk7nNpnOiOKUGY5/NTeYXKuPEOefOIJoV06qrMd2QTVtOBMgtH/4nlJAAszBer+rpw/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAV2kTCe; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5dfa315ccf1so244672eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 22:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725515747; x=1726120547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcvMsJDZUgTK4x9w25QQdXqSLspvJqtCWujPzWg7AMk=;
        b=dAV2kTCeBRxWrhjumLOsDX0yHwTHoh9FBrQeRU8iAYv19FqGqB7miE1HveBjckyaQs
         8IyqIN/mbsC4GcDS2IiitM4Qw7mTcwvjdxUQQPs7gZUUAqsTPmd4+T2GMNgGge+Cosom
         4s8uS8/bYSDjkm9d7Xj8PV5/4A5+9HutIHihlxWxBid9+uB9oyxNOmvQHPJpKG8H9Dg7
         7c5G2qlbMz7GO4CAfNKiKWFFED8x33MSBeOaw3clmcMoXfE8Dfc2QEKVemipzFowXxNI
         5rU9OnAiU6wTniuhBQO5VQadpjTyiyJyP0VvTXrLEbgYxTBpZdTxghoICPr8HIGvk92L
         hHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725515747; x=1726120547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcvMsJDZUgTK4x9w25QQdXqSLspvJqtCWujPzWg7AMk=;
        b=wzcsF3W6lby7w59vjCFymzPh9blFsGr2x4L0Jl+g/RJXsJMIflAHehqgoTQY35KGDi
         nbIGHsqG1KrGecgkXD9lzVYS++wJJLMOZc3jmsIHHJA8plQhdzrHm9wKZ3pG55z4mBra
         Itf56YZDsM6c/TPkSiq9CuKxj5gPWwEHtSAYyO4skikSU81We0IzJxrfm/c5UN3vDts3
         M2qzYOl/REl6knQm8mO78HiczcmKCfWuk2WNCLoPF9e3hS72h7gh/4y6FpsIrk7N6aVn
         3dpShc+Wiu+TJ7Od9QmujCszBwJ0YWNeChMXnr6S3iomEz4I8cMkBoI2SEOe+ZjoxKwk
         yFFw==
X-Forwarded-Encrypted: i=1; AJvYcCX0u9P0b7BAIOEOSHAu4Kw3gUj/md8Dv5fQzqlYz/94dblsxWYkfhlpoNgvNkgngdBc3h+h3VPo1wKDvSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNkWRB1vIrHlObM8oN2YyxTS1aNrd1hcPFaghDfm9/UiWYH0Ub
	W3oDM4iN8F0Ir18Y6/o2+CY/aCkM0/zDQiYkZQfmb9bCDM/dDP/d
X-Google-Smtp-Source: AGHT+IEWrt51EUydiFhkdZrDSiCTxnG91yXpRuuCiGvbr+IzvMludHnM29bDlBOR3lD8IGLA7E+Ecw==
X-Received: by 2002:a05:6870:f613:b0:25e:1ca6:6d09 with SMTP id 586e51a60fabf-277900932a6mr24398037fac.8.1725515746776;
        Wed, 04 Sep 2024 22:55:46 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778542276sm2583299b3a.91.2024.09.04.22.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 22:55:45 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 6570E802EC;
	Thu,  5 Sep 2024 14:04:09 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 2/2] mtd: spi-nand: Add read retry support
Date: Thu,  5 Sep 2024 13:53:33 +0800
Message-Id: <20240905055333.2363358-3-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240905055333.2363358-1-linchengming884@gmail.com>
References: <20240905055333.2363358-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

When the host ECC fails to correct the data error of NAND device,
there's a special read for data recovery method which host setups
for the next read retry mode and may recover the lost data by host
ECC again.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/core.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index e0b6715e5dfe..2f21ea926132 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -640,6 +640,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	struct nand_io_iter iter;
 	bool disable_ecc = false;
 	bool ecc_failed = false;
+	u8 retry_mode = 0;
 	int ret = 0;
 
 	if (ops->mode == MTD_OPS_RAW || !spinand->eccinfo.ooblayout)
@@ -657,20 +658,45 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 		if (ret)
 			break;
 
+read_retry:
 		ret = spinand_read_page(spinand, &iter.req);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
-		if (ret == -EBADMSG)
+		if (ret == -EBADMSG && spinand->info->fixups) {
+			if (spinand->read_retries && ((retry_mode + 1) < spinand->read_retries)) {
+				retry_mode++;
+				ret = spinand->info->fixups->setup_read_retry(spinand, retry_mode);
+				if (ret < 0)
+					break;
+
+				/* Reset ecc_stats; retry */
+				mtd->ecc_stats = old_stats;
+				goto read_retry;
+			} else {
+				/* No more retry modes; real failure */
+				ecc_failed = true;
+			}
+		} else if (ret == -EBADMSG) {
 			ecc_failed = true;
-		else
+		} else {
 			max_bitflips = max_t(unsigned int, max_bitflips, ret);
+		}
 
 		ret = 0;
 		ops->retlen += iter.req.datalen;
 		ops->oobretlen += iter.req.ooblen;
+
+		/* Reset to retry mode 0*/
+		if (retry_mode) {
+			ret = spinand->info->fixups->setup_read_retry(spinand, 0);
+			if (ret < 0)
+				break;
+			retry_mode = 0;
+		}
 	}
 
+
 	if (ops->stats) {
 		ops->stats->uncorrectable_errors +=
 			mtd->ecc_stats.failed - old_stats.failed;
@@ -1095,6 +1121,9 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->flags = table[i].flags;
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
+		spinand->info = info;
+		if (spinand->info->fixups && spinand->info->fixups->init_read_retry)
+			spinand->read_retries = spinand->info->fixups->init_read_retry(spinand);
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
-- 
2.25.1


