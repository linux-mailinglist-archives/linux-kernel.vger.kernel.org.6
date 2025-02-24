Return-Path: <linux-kernel+bounces-528294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5901AA415F3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771F4169C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962D923F420;
	Mon, 24 Feb 2025 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTLw72nh"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ECC18E377
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380893; cv=none; b=JYCb1R9vLrLQmd09WIo7a2VBtXal9DRriK6ShMnecqIE5NmJVth3bM+F7drwKBLlidp4U4RClgrn3qkRLdq4R8XFRatcZ/+RgBwziVhhbY+GYXDtuQVql9OWkWzga5909wVeOJgNiTMK+dCgJamGKopne5HebguYBlQFOKrDxQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380893; c=relaxed/simple;
	bh=ODgiHPEXc/mmRun9++koS+tR27XjVzBq3ja1K7PYHg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eFR7FAHqZIM0QBI/RWK89eCe9/mvZST/9WMPQkf8+GKZbOeiIiy+AgJQcxw6hePxDLRt4t8ffzIASxsOwrk6v7epthPGiZnvjNzL9IHqwJQor6ajFjVEuWiLPMnFckpmUbNfcKs23VrJVep5peufbSeSNbM7L18UucYx/I54vYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTLw72nh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220c8eb195aso87586855ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740380891; x=1740985691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuwxW0/kSg8UdM9sxgaU8RMlCzyHiyIIgr/U3aOdQEY=;
        b=NTLw72nhAbN6OwaB3oYb1J6B9+saoIstsLAYBNHGSPyq7avBPFeFBEjxN///GFWqHI
         SoCYh94h9/e3F9inqQXAYcr/RtWDxMp4+xQ8sy3jOzuRZrk0NbdK5M7wWdG5ai1tZLpj
         dehYzMlD+2GSqrD//1/79jhHt4M/0OIHI4Mx4ouYymsB/FbMSUdPmKAfIwCaAwDPe43+
         u7EnhSw8Q2mSqadGVP37ajxViiDILBeWzhg2cBqeRdElAFVHx3JyjHqgwV6ZB6AcIQif
         eRhuGTX/tSi41ENS8+5rGlsh41+BE+lZ6J7i2QgYMy5zNFROkcKzqDH+eML812r9mKRd
         qg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740380891; x=1740985691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuwxW0/kSg8UdM9sxgaU8RMlCzyHiyIIgr/U3aOdQEY=;
        b=UTqxbVaZiFKBxSoDR/uklgp5lbYWlpHThjVlUvmKNYo+9UjP341lDvb/flalhbtsPg
         EekzdyJ/1/31VEZRyOnE/79Noe3CW+s40XeOLIoR/Hw8rF/VcmSCeqNQJH8/KFz963PU
         C+SniU8jVww+zAvp88ETu2zZnvWTnQmDUHleQxOdVIY9UpZh2dO1PboOnUaZT476nb5w
         vCkunQd8JwfDfCG/rrno82o7NcWR/TPk5Bw6Ci2awc22LWNUwckQJW7cbyXv9gGJBFkV
         7dOdeaA/2c2hR8hchK60SckOc7/uJUJUjjP5Iun+ZBlM36uVUeKkpsUPGV+/Vwb0GfNs
         RJqg==
X-Forwarded-Encrypted: i=1; AJvYcCWVcTq1MbsXC13k9FEGovkikiQdKpBArr1dpWbaAoch0utB4Fcecq52HkxPJG1LdeiL2w8R+TcYRKZDsbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbKY1NkkbUwwyiiPAQROHT7PHIY2p3PBl2sz2UjixuJumoO/MU
	TMm9CqErO6j8c4H0hsBU+6hzLyudOlBtU0Df45BGm46lLOtLR3Vn
X-Gm-Gg: ASbGncsOC2LwKXK+40owrxdIfQARvL4A3iQfv8LcG8ubBATdGbjvQ+k5RN6bju6OBcz
	zlnr9lOY5w3tub8HV6+pkCiU09I6+dVvdprCmjvraBxi0qIFX9Iof0KI7/ueI78W+seLlCiutWL
	T0ES0eyvZ3AM8++4GiJi3RFNZqd1n1a2eqo+eWsA2oOtkUiiHWe09vVYGbv2Ce9Z8X8JUGObhgY
	duAEvuTG7r42gAvW0ILI0d07AlQptFDc/FuYKLDsck9/SOmsr8+TC+E6DRI1pV9ABLI6wmhQa07
	ZrD8LFW78IWc+pfHHzESrx4am3OhnXKndDmWk/Zp2JjXe5u0RA==
X-Google-Smtp-Source: AGHT+IGfszCtI/n/y/N1a12SDHSeE9d2dYjSptoYpB6Sb9ADrTYnehoVJIVKr/VCIRLpEtH3TRJxsg==
X-Received: by 2002:a17:903:2283:b0:216:48f4:4f3d with SMTP id d9443c01a7336-2219ff50ddfmr143610565ad.13.1740380891444;
        Sun, 23 Feb 2025 23:08:11 -0800 (PST)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349061sm174504825ad.5.2025.02.23.23.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 23:08:10 -0800 (PST)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id A6222806A6;
	Mon, 24 Feb 2025 15:18:18 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v5 1/2] mtd: spi-nand: Add read retry support
Date: Mon, 24 Feb 2025 15:03:48 +0800
Message-Id: <20250224070349.446739-2-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250224070349.446739-1-linchengming884@gmail.com>
References: <20250224070349.446739-1-linchengming884@gmail.com>
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
 include/linux/mtd/spinand.h | 15 +++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index dc5b11fa7a15..d16e42cf8fae 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -700,11 +700,15 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
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
 
@@ -716,18 +720,43 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
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
@@ -1320,6 +1349,8 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->set_cont_read = table[i].set_cont_read;
 		spinand->fact_otp = &table[i].fact_otp;
 		spinand->user_otp = &table[i].user_otp;
+		spinand->read_retries = table[i].read_retries;
+		spinand->set_read_retry = table[i].set_read_retry;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 73424405232a..5837a09ab9d8 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -452,6 +452,8 @@ struct spinand_user_otp {
  * @set_cont_read: enable/disable continuous cached reads
  * @fact_otp: SPI NAND factory OTP info.
  * @user_otp: SPI NAND user OTP info.
+ * @read_retries: the number of read retry modes supported
+ * @set_read_retry: enable/disable read retry for data recovery
  *
  * Each SPI NAND manufacturer driver should have a spinand_info table
  * describing all the chips supported by the driver.
@@ -474,6 +476,9 @@ struct spinand_info {
 			     bool enable);
 	struct spinand_fact_otp fact_otp;
 	struct spinand_user_otp user_otp;
+	unsigned int read_retries;
+	int (*set_read_retry)(struct spinand_device *spinand,
+			     unsigned int read_retry);
 };
 
 #define SPINAND_ID(__method, ...)					\
@@ -520,6 +525,10 @@ struct spinand_info {
 		.ops = __ops,						\
 	}
 
+#define SPINAND_READ_RETRY(__read_retries, __set_read_retry)		\
+	.read_retries = __read_retries,				\
+	.set_read_retry = __set_read_retry,
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
@@ -572,6 +581,8 @@ struct spinand_dirmap {
  * @priv: manufacturer private data
  * @fact_otp: SPI NAND factory OTP info.
  * @user_otp: SPI NAND user OTP info.
+ * @read_retries: the number of read retry modes supported
+ * @set_read_retry: Enable/disable the read retry feature
  */
 struct spinand_device {
 	struct nand_device base;
@@ -607,6 +618,10 @@ struct spinand_device {
 
 	const struct spinand_fact_otp *fact_otp;
 	const struct spinand_user_otp *user_otp;
+
+	unsigned int read_retries;
+	int (*set_read_retry)(struct spinand_device *spinand,
+			     unsigned int retry_mode);
 };
 
 /**
-- 
2.25.1


