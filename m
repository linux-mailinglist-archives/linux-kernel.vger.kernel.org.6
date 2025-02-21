Return-Path: <linux-kernel+bounces-525483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71484A3F088
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE87420220
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B602045B2;
	Fri, 21 Feb 2025 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyOYC/nN"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2E6201017
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130663; cv=none; b=pW+OQlo+SkUOMYFEdGTI+lRiLp7LiPJ6Q+5i9k7PsfhsysD90q5Vm368zOeIgFg8zmaZHgtddNNId4B4NMZe3wf6B9mdqEI/QU+wADuXRhjWGer/RJKO5lfoAZhALnJD765+6lNhnxjlE9xFjEx/EULCzp9t3JjmMBn4BKTdCV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130663; c=relaxed/simple;
	bh=WZAORZnSKINKjodaXKGwI7hqf9qMH5x5iz3zgcL8GPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ck52+FhB3uQaJNHyjcRdXvYYiv/Mtufx+qCqBLBA4F89rIY/9n+gdR18BfSu7LsmlKgvbRGTiESWjhugZOZnIZJBw5gCzBo0L8JHcoRFGkPwqvXCPDBgImxJRWJrfegyUIO7iqXrHiJKmHQ7iqLLICMPQY8MghskdzKb1sFnRHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyOYC/nN; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fc0d44a876so3043463a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740130661; x=1740735461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uTXc5mDGcxofMRZcNXDa/UBr6/on046eyKp8zh2sgQ=;
        b=GyOYC/nN6FGjZUCNUpJPrn4zrOFDj5+y4qryJDHevSJidFLOKDYbskRto+lMzaeXln
         YP5NMIgYBPMMHPaKMZKUuB9EEt7SY0t/NGDy707A8C+hTmQ7w/ngnnCjdqR3OGeFn7kf
         6i0Lu2cEhnnRJ51J8XcvkjPc4UrGkgDBoxo8YYWKVy+8Bkifr19Ok5QVZ9sDl3krfv+p
         iWlORvIvQD/dqxJuz1pXqVKd9kjPFPhcFs1An1pOauR2e8kPgGhnfXW+8NH418pdVPF3
         d7qsIrejKnF+TWCV0R8jlkdBIqdrwr5Gc79Z7h6Rh9xAAg2hUVmdfr2JKHBI9HIvfqNW
         h6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130661; x=1740735461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uTXc5mDGcxofMRZcNXDa/UBr6/on046eyKp8zh2sgQ=;
        b=ocKIuQgfA6ggryxkpfCom61fZuG3SqEPyqs1mnK9WB1tj/Tu+LeaB9C8e8fvCQjxsZ
         wdtU4lpD3FiQOcz7FJ2VY+hdTtwVT2BgxWcspd4bTg1RrYJ/+i6I8LCgoOqsvzqs2RCv
         5zCs3JPWn30XQtsKTs1b7wRiELPdMAi94zrvoYSIkyzIRo5f5SLCbwq2hsdv2iT8JFGW
         twVELG5HGdxj91XaX5boTEXg2xmwss734Z+Iy/dZqW09spokwumDbzu+d6J09A62dxn+
         ggGpqNp0f28ar8IjJEpUO2q+/3NifG25j/jwMWR9bJsmf4OIiRulhf+Zse/e3ZEsVsWn
         dvRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQjMaDWKV+Kax/cjO4q3Rm3ULBtQiCsJG92/rJW3RaoAU5ayyXAABX6rKSbG0acKnIOLWvZ26rVyn+dao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhV9W54XH/cucIbr/9hnwKdSp0NE9Z+kaJNYz6Xnt2fbHO5J3z
	VKxDbqNXh2IMnOGB0LIv+n6Z9w0PdtWSFshDhHxduu/lSpxwDJhT
X-Gm-Gg: ASbGnct4/moiyTtnxKMGt8kovLfSaffe6aE/gtn2Ktzz29GsmXe5WOGJKahhigPFaP2
	4JuTsyVbFeD7Xg2ZdTO41rrOb497/orikelmYseZb3d/JQuXK/iO6pGbmmvbyDpZ+1Bk19TNnkr
	DLKAsuSfuSlnjTK9lLkDFTsH7dfE/rt/DcLmM5BHjSkTGGH0h28W3yvgCslWky9JRyTbMhMo/Rk
	ba0/0sDMKePXhJYt6ea7kxgEURs62URZqemDZOQ3f0ktsfyjkZnbmvPYcSVYf5Mm+F6zBGZfpfH
	GN3qRRja1x40pEvRFlxj/hASBWjrScyjG/V9Mv6D9+cOUIxERA==
X-Google-Smtp-Source: AGHT+IHUPjYb2qe97dUurXhu/69IHL6noHJOVmh7CNoaPDeusUsv3n9W6aIlNXrzZoAP/1F2rTNX6g==
X-Received: by 2002:a17:90b:2b8e:b0:2ef:19d0:2261 with SMTP id 98e67ed59e1d1-2fce78cbe94mr4724202a91.16.1740130661359;
        Fri, 21 Feb 2025 01:37:41 -0800 (PST)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb088c7dsm976492a91.39.2025.02.21.01.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:37:41 -0800 (PST)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 4FFAA8058E;
	Fri, 21 Feb 2025 17:47:53 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v4 1/2] mtd: spi-nand: Add read retry support
Date: Fri, 21 Feb 2025 17:32:59 +0800
Message-Id: <20250221093300.430994-2-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221093300.430994-1-linchengming884@gmail.com>
References: <20250221093300.430994-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

When the host ECC fails to correct the data error of NAND device,
there's a special read for data recovery method which can be setup
by the host for the next read. There are several retry levels that
can be attempted until the lost data is recovered or definitely
assumed lost.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/core.c | 35 +++++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h | 14 ++++++++++++++
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 4d76f9f71a0e..beb40f3619ca 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -671,11 +671,15 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct mtd_ecc_stats old_stats;
 	struct nand_io_iter iter;
 	bool disable_ecc = false;
 	bool ecc_failed = false;
+	unsigned int retry_mode = 0;
 	int ret;
 
+	old_stats = mtd->ecc_stats;
+
 	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
 		disable_ecc = true;
 
@@ -687,18 +691,43 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
 		if (ret)
 			break;
 
+read_retry:
 		ret = spinand_read_page(spinand, &iter.req);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
-		if (ret == -EBADMSG)
+		if (ret == -EBADMSG && spinand->set_read_retry) {
+			if (spinand->read_retries && (++retry_mode <= spinand->read_retries)) {
+				ret = spinand->set_read_retry(spinand, retry_mode);
+				if (ret < 0) {
+					spinand->set_read_retry(spinand, 0);
+					return ret;
+				}
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
 			*max_bitflips = max_t(unsigned int, *max_bitflips, ret);
+		}
 
 		ret = 0;
 		ops->retlen += iter.req.datalen;
 		ops->oobretlen += iter.req.ooblen;
+
+		/* Reset to retry mode 0 */
+		if (retry_mode) {
+			retry_mode = 0;
+			ret = spinand->set_read_retry(spinand, retry_mode);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	if (ecc_failed && !ret)
@@ -1268,6 +1297,8 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
 		spinand->set_cont_read = table[i].set_cont_read;
+		spinand->read_retries = table[i].read_retries;
+		spinand->set_read_retry = table[i].set_read_retry;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 702e5fb13dae..bbfef90135f5 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -339,6 +339,8 @@ struct spinand_ondie_ecc_conf {
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
  * @set_cont_read: enable/disable continuous cached reads
+ * @read_retries: the number of read retry modes supported
+ * @set_read_retry: enable/disable read retry for data recovery
  *
  * Each SPI NAND manufacturer driver should have a spinand_info table
  * describing all the chips supported by the driver.
@@ -359,6 +361,9 @@ struct spinand_info {
 			     unsigned int target);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+	unsigned int read_retries;
+	int (*set_read_retry)(struct spinand_device *spinand,
+			     unsigned int read_retry);
 };
 
 #define SPINAND_ID(__method, ...)					\
@@ -387,6 +392,10 @@ struct spinand_info {
 #define SPINAND_CONT_READ(__set_cont_read)				\
 	.set_cont_read = __set_cont_read,
 
+#define SPINAND_READ_RETRY(__read_retries, __set_read_retry)		\
+	.read_retries = __read_retries,				\
+	.set_read_retry = __set_read_retry,
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
@@ -436,6 +445,8 @@ struct spinand_dirmap {
  *		A per-transfer check must of course be done to ensure it is
  *		actually relevant to enable this feature.
  * @set_cont_read: Enable/disable the continuous read feature
+ * @read_retries: the number of read retry modes supported
+ * @set_read_retry: Enable/disable the read retry feature
  * @priv: manufacturer private data
  */
 struct spinand_device {
@@ -469,6 +480,9 @@ struct spinand_device {
 	bool cont_read_possible;
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+	unsigned int read_retries;
+	int (*set_read_retry)(struct spinand_device *spinand,
+			     unsigned int retry_mode);
 };
 
 /**
-- 
2.25.1


