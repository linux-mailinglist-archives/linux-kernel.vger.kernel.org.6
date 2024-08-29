Return-Path: <linux-kernel+bounces-306071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9639638CA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93383B22DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7121761FD7;
	Thu, 29 Aug 2024 03:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHeID1yK"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5073D4D8C8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724902058; cv=none; b=Lt7zcnTjAyGUI9LRgYH1Vn1nHBgrPRrSOfDboK9r/J7MA+lzuu2viNY0WQKaQs00yMoNzES/fP43EJoxcWBr+UIHP2YhiqNPNO5uzIw8tHlLawusHAy9vTRxmj0C9dK4Ut9ZAXreTU64rWuKhGQ3cnkiJBCsZTstd3lmrr+o8Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724902058; c=relaxed/simple;
	bh=J3x15FROvIGfErrr95eUsP3T0r5kfYqV9KPmq4IaenA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ITShf+aZfoEUVOxdbW3GCJELQyAwm/pmiN9fBXl/3l23p01AofSLpVEEaRatIX4nAlxXaim9CYXD+SB8F1UJ0rbfplinpLCt0tM6clqnS+yArF2Lwq16Olp71bTApD9jjBd6V99VPqh2fVRA9Nu2JAih1wxNRFBELAfTAAeCgns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHeID1yK; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3d7a1e45fso128087a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724902056; x=1725506856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yd0jWR3VXJxuNlLXtqGwbme+uoTJ0s2xTOcRj568YVg=;
        b=dHeID1yK84xNRghhYAvKzvs17IX+yY35AzHDfdyi5T6PdqhsFgn52DRfZp3G2VKg8C
         7bMVNhNFkOT37S6pmYfUg2AMsQKK8BzOW1y0SUYKPCpngxo75mtJZ6wQzyfFE8mPBgJD
         yyxuPz/5eBcbwHzNgp00F2BXIJ89vxhuNWiEUkuF6w3+UH/hj36UOcHkz3nVNX0vUKP3
         SMd4MAgjdAC6KE/11vw7Q5jlpMNYOvdSxXEfrkn/r6nznQwSu5f5Ym3SVbo7Zo2VJMfZ
         jdWprcPk/+yEsZQaGMJjFs7FdkIA75qHD5e21dbbb88MySgn/GqCYqHz19wcibaIa1QK
         IeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724902056; x=1725506856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yd0jWR3VXJxuNlLXtqGwbme+uoTJ0s2xTOcRj568YVg=;
        b=CecUS9E8FjXQsWQUYc7bRRcttQGBw3Vp7x5JTh1jOJfAmfNi93+fh3id+kXDeUGdLt
         0RdrersSzmLli8oMeDGRIkzj7EBq9/8cWDuGauX/RdOD8Y7Dc/ruoVnqzr4npzEkB2RF
         mAauRDIEOI+TRcVnE+jIpQxPsX2k9PCQ12Alw79HvN7azEwyxMOMIC7AXTinuglXpnwF
         oruxzc5gtMe4qNjZ/dx/4ypjkUMHll/tfwPdF48uWrbk5kePS9SKurLDe6TgvxW2kznx
         3f42pNIm+P+Vi7eb2gQO1nBlvbo493trc8koCm28MZGn1jsxPrFCT9tG42lt1n1KDIIa
         P6pA==
X-Forwarded-Encrypted: i=1; AJvYcCXelMhSkOqqUohGA7XRH+kTPXopnh2zcyjwj0AvExFWX4UkfAJSu1MGEPeN9vSmXrq2DBIRT81IzUejFjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOParYDc6pWsoKL4J1vjkuRTm8KnFcopRGN11TjC4VkWYUKRFS
	ALAti/5IIrJehItI1UlUYnBLwNYUZwJb9cqz4npErDjw3H96JcaM
X-Google-Smtp-Source: AGHT+IG9vzMS34n3yQrqIZe1bl+5NJqDWVg/BsUpiS9mu0yGMFa3eQDSdfkFbu1or+R3IOgWVhw3KA==
X-Received: by 2002:a17:90b:2652:b0:2ca:2c4b:476 with SMTP id 98e67ed59e1d1-2d85619d40bmr1665311a91.10.1724902056294;
        Wed, 28 Aug 2024 20:27:36 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445d8afdsm2810877a91.2.2024.08.28.20.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 20:27:35 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id B3207806A6;
	Thu, 29 Aug 2024 11:36:11 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v4 1/2] mtd: spinand: Add support for the flag
Date: Thu, 29 Aug 2024 11:25:16 +0800
Message-Id: <20240829032517.1517198-2-linchengming884@gmail.com>
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

Add two flags for inserting the Plane Select bit into the column
address during the write_to_cache and the read_from_cache operation.

Add the SPINAND_HAS_PP_PLANE_SELECT_BIT flag for serial NAND flash
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
index e0b6715e5dfe..49f2d66c3a9c 100644
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
 
+	if (spinand->flags & SPINAND_HAS_PP_PLANE_SELECT_BIT)
+		column |= req->pos.plane << fls(nanddev_page_size(nand));
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
 		if (ret < 0)
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5c19ead60499..cec451e7c71c 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -312,6 +312,8 @@ struct spinand_ecc_info {
 
 #define SPINAND_HAS_QE_BIT		BIT(0)
 #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
+#define SPINAND_HAS_PP_PLANE_SELECT_BIT		BIT(2)
+#define SPINAND_HAS_READ_PLANE_SELECT_BIT		BIT(3)
 
 /**
  * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine structure
-- 
2.25.1


