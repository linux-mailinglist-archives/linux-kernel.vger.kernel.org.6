Return-Path: <linux-kernel+bounces-400030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 842A19C07F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A810C1C22040
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C499212EEF;
	Thu,  7 Nov 2024 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpIYFR9B"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176A8212647;
	Thu,  7 Nov 2024 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987258; cv=none; b=jzgzkBs1SKoNha3tiPIobBCGudPo1LtTN5zcmC4t8Gdt07ZfCZ1S8FRHPKCnoNjYAbBdWu1wp104yc0DirG8dtIwH2A7D1RdFC68zNOLCAJxeVIhhs2KiBjfbJekU3Oxrs376I6gXTJUg6GeKZJ5Vj6Vi22U0PGVwm3OGcx7MxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987258; c=relaxed/simple;
	bh=aEezSAYRZux5sp8R/V/BZi69L/f49HVcP44j8wR1Vf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Owf5yuqlHT5A9ovd04g1HZPYc8n077XH7XmjajC2BzUOfxyxSWjpD3aN40ACiziXXbzkQq6uGZH0qMqRPhaZU0K7zg491u+Y3b6Ntm9QWmGs6CS9zAEp4SUgA/2elo+KQ6l1Xe/vzztXR8+TLg5aSEQPg+I6Lt9vARHJu6DDOxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpIYFR9B; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so1146062e87.0;
        Thu, 07 Nov 2024 05:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730987255; x=1731592055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smTKmYgVjf2tZh/nJwAXDtC0KskLoU7un/mwCANgBrg=;
        b=jpIYFR9BCNNjWhunUJlKvYl1nh7m6JkEoFfVcf8ixH0mrZJrVVt2JmgWHrlhm2jSmV
         9xyy88ValnEjVYifTVcKz7hCVTEBdtr8nDWlueaTVI28/e7c/EsvZIc4MsHXmRv7730t
         CNHYjmGydS7qNN5OVJRIel5RR4N/bYfBiwAL6dFjLQT81NsIAgNHXKbUl+ydoFEZGkmJ
         ycKYPoCmTd0bmSA5LFbXzYEYJyn8rcS+V1O6j9G2h4ZruJM8B31ElNIPzUvBsC+tM+RY
         4tEwpPwugkswxMJb3AyTildLL4weZE4GCJMQ83X8u/c6IF3o5jREIJNyn5p9aspqrntJ
         vQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730987255; x=1731592055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smTKmYgVjf2tZh/nJwAXDtC0KskLoU7un/mwCANgBrg=;
        b=MB558nqd9Hv0bN9EavgFTRo77stfwzAeQaSfK5zP97EwfwdttqslZBn/Bowg9/JChK
         Fq1v5/H5sXIV4tpUHB+pogfsyMX4ezPCknAacPbqqKm4xpVg/NPI8BBofg3tryH52cwc
         zboPylASg5r6i1JT+K8VI9EvgK1IeTmWKHYQoXiiq4ESD18f8vPccmDiWBFJfqB2aFiC
         SHUKYReW4b5Dj8HXaQXArtdmam8OidvmyE8l+ZL6d03QIbwJeSnkzsbfv4JCIiOxnDO+
         o03Bt7YlQC1ISxuGzlF5duQpi3VPEz4n2yaLRPRhFM4D22EkDrQRcYqxlqnRw6PQvrK8
         6k7g==
X-Forwarded-Encrypted: i=1; AJvYcCUy6birI2YaHdMgl/euvS3e+UcvMHO8xkhJ2AnL2kerI838450kTlG0GV1LHSKrQjJ/370E37rX6jG2z8+5@vger.kernel.org, AJvYcCVbvd0K4JqAFx1x0lM4hnE4bowoVjOSslbKxwYfFWBD9qgV+f6h2iKwaEbZWU5AqeCdLIUoYD0jnn+h@vger.kernel.org
X-Gm-Message-State: AOJu0YxF2p5Kbjxufnwl/InDNzFD16g/onTfD9WcrE6DrA5QXl7e8qRL
	+zp+FofDyhfmm43Y+zgrOVTPS20z2HYE4MCfuaz43bJUbbckq6z7OMOWVDDl
X-Google-Smtp-Source: AGHT+IFhbSo5pXZ6+Sbeo6H9y9g5iMqsCOoUVCmNbcBaUywv9O9gtHsU2QUKclCRiOp0TTaJsxBQSw==
X-Received: by 2002:a05:651c:2226:b0:2fb:8de8:7f9e with SMTP id 38308e7fff4ca-2ff1e889520mr330911fa.1.1730987254965;
        Thu, 07 Nov 2024 05:47:34 -0800 (PST)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff179d80f5sm2276591fa.105.2024.11.07.05.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:47:33 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Thu, 07 Nov 2024 14:47:07 +0100
Subject: [PATCH v7 1/2] mtd: nand: davinci: add support for on-die ECC
 engine type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-ondie-v7-1-98829fc8a958@gmail.com>
References: <20241107-ondie-v7-0-98829fc8a958@gmail.com>
In-Reply-To: <20241107-ondie-v7-0-98829fc8a958@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1761;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=aEezSAYRZux5sp8R/V/BZi69L/f49HVcP44j8wR1Vf8=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBnLMTomdUX6qyJCp5iC5mJbbMGc/zZt+dO48AXd
 cJzzvAvBlOJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZyzE6AAKCRCIgE5vWV1S
 MrR3D/sFuhOd8C3qeA1eeAPtI5jyaqZ501Z7Jvnijo/eKG2sexB2doGkM5mDbHfmanCYTEaX6R6
 OfVO03LCSAqElMilqYG8q0o8hfo2Ad/dmDg58tjrKCAqaEsiElMjdr5FpI7Q782s3XnbZ8vq5Ih
 6SlzQwyMLQxeJMVlaIUVYnm6gh5X4y37NHABs7Kr+IpbpppUdcHjyxc6gUOZQFopGA65uQIaDZy
 X4gc0yO8d+qxyRTpnZkNcZoLz3TyyakL3ikVLYXkxjryeLYF9p7bO95vXytU4Zi1SLNyyJ6hCdW
 KV1rItkX1Id4+3HyqWrEii90BIw/CzoVoCOUSMHxSc//BKihZgFznpbLuJXHCWh/afTzBvMuH6B
 Z8zp+knjRwbcfgU5vpkiDSvMTLrM1xKL2wvmwcy2P+mJiAYDYo8VMJBUOPV8eHAmMQwM9KBXhge
 NhhyD5hRC8Nlq03Kju7D+IMnB+M3P+9I3CNrh5BxS0W5pkaMyIiJDcZ5mbfTEGa+D1RtHq+X8xe
 dLHMUdHHBpe2F/fZ7jMJ1/PW5iuq1xyqyb5yGHDfcLVTBycTD9UEojc5drZlHyyz50YMs9Ueoe5
 W+FW0e5ZT7WXTNHG5u5TP6RZHRkpsdfAzg/6OHTridZcPbUi5i6hkUE8mID/0j2Y9UGbVQI/u8+
 7qd1Wm3wWJnLchQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Some chips, e.g. Micron MT29F1G08ABBFAH4, has a mandatory on-die ECC.
Add "on-die" as ECC engine type in order to be compatible with those.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/mtd/nand/raw/davinci_nand.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 392678143a36b20b42c1827eee8203dc2e41889a..79e768d337ae12f6e8d7f21f1acd4e259f4f3020 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -66,6 +66,7 @@ struct davinci_nand_pdata {
 
 	/* none  == NAND_ECC_ENGINE_TYPE_NONE (strongly *not* advised!!)
 	 * soft  == NAND_ECC_ENGINE_TYPE_SOFT
+	 * on-die == NAND_ECC_ENGINE_TYPE_ON_DIE
 	 * else  == NAND_ECC_ENGINE_TYPE_ON_HOST, according to ecc_bits
 	 *
 	 * All DaVinci-family chips support 1-bit hardware ECC.
@@ -524,6 +525,8 @@ static struct davinci_nand_pdata
 				pdata->engine_type = NAND_ECC_ENGINE_TYPE_SOFT;
 			if (!strncmp("hw", mode, 2))
 				pdata->engine_type = NAND_ECC_ENGINE_TYPE_ON_HOST;
+			if (!strncmp("on-die", mode, 6))
+				pdata->engine_type = NAND_ECC_ENGINE_TYPE_ON_DIE;
 		}
 		if (!of_property_read_u32(pdev->dev.of_node,
 			"ti,davinci-ecc-bits", &prop))
@@ -580,6 +583,7 @@ static int davinci_nand_attach_chip(struct nand_chip *chip)
 
 	switch (chip->ecc.engine_type) {
 	case NAND_ECC_ENGINE_TYPE_NONE:
+	case NAND_ECC_ENGINE_TYPE_ON_DIE:
 		pdata->ecc_bits = 0;
 		break;
 	case NAND_ECC_ENGINE_TYPE_SOFT:
@@ -914,4 +918,3 @@ module_platform_driver(nand_davinci_driver);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Texas Instruments");
 MODULE_DESCRIPTION("Davinci NAND flash driver");
-

-- 
2.47.0


