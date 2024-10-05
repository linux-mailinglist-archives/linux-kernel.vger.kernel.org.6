Return-Path: <linux-kernel+bounces-351719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3AF991549
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 10:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809AF282C36
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 08:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432032F5B;
	Sat,  5 Oct 2024 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiYuTyQR"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E9113D276;
	Sat,  5 Oct 2024 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728116808; cv=none; b=Iz/aDxdn1C2wVb1iGLCI/HOZaqJXWFIQmF0Sc/Fiu88NUGghvV41l6UuwteigZEAR4ByGO8amCAs3mN5Rj6M2n0VL/8zng/e54vnh02xOvMU9wNOhkGtRxyPVO+Xy0YzLmAGzMcRWanSMao3pGkugQ/ZLzbQd1xI1j2s7h0QBsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728116808; c=relaxed/simple;
	bh=PDm1f5NEBuhwxeXGvwzqxiOMHTZXe7TWbR431qOgkS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qr6nDCI5kO1otj2vdwNXXmJMzAGNR4QRSuXnBvJzjdOJ8x/aY8o+tuipUU3P1Bqr/ynWkdqikDeBC0zNJpciWZp/igbyS0BjkyF4hPJ17NfcLpEZOa+nyjmhU+AZqx8Vo8NiW+KT+ns+azKCoZMr3adwswH4tCOkfQz5/C1IMUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiYuTyQR; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fabe5c8c26so26575081fa.2;
        Sat, 05 Oct 2024 01:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728116805; x=1728721605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqCsg44tBpEIKTMwf8yZOmaXX9/g3lsiJW70OB7Ta3s=;
        b=eiYuTyQRpo5Nj09zG5l0QID8Z53AzJHafS3ErGV4lYAQw3cr9QjER1n9YS/6Ucky7e
         h6/u3eSQniDliXiXPYsDIo57q+dyJYIhM8fQkSIW8/3VQNm7zzRFlY0+YgzYxrsF69pN
         BRI7YKxnxh+wTZPb8447SqkDMHDL5ZhV+2cTPFix8Ns/55h3tHwCwGeAPy/Mq3jqFs6r
         cNwBUg0zkVbHlaNdkLjwnV1t1K6LFa5J/m67wxR+I1dt1on8ZpYYIk/NddvBrI/yLfuF
         auSyV7NY4LKv6UTj6t2BStul93vsr8YG+d64f4iamKmmKrALqX5w8ApuCxiFnmU81Yib
         caew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728116805; x=1728721605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqCsg44tBpEIKTMwf8yZOmaXX9/g3lsiJW70OB7Ta3s=;
        b=XX3K3RKDELkr9V3bxUdXDc2SyX6ktfDRlo5eLmg5k5NEunSuQT4LZ1WBfuIo3aYdVr
         pm7uQ7wNOyXUOTnfV5yRaZ5NmR14SYJYbqT7AHgz9LlT1mrS77w4tWJphhhFNFMA8FKG
         3LLpfw4dDyZrst+EfV26w3mZZ3HcOylWSy+a/CDpi99kT9FEd+SPvGPijQoRhk11FfWs
         vd7Q4ZIIB1hfnyZEvUPDjL8ezQ//xwdLPYRmb/C5SXW6yecFNmAjtz3FlEMBO4tGTu1k
         aoI8p143h78mhIHuZWf/yWLfk+EyLIqMNnzkV6ucD3cJm2LkAYswQVNaoBAS020vcK0W
         OTJg==
X-Forwarded-Encrypted: i=1; AJvYcCWyq47wuTQJHMRqXGu6WtBm1kfkMf3q9Ax5ZOpd1J7xnPZ5OAfl5Z2m2dBYYnwqd13KOgLn3DPR79cx@vger.kernel.org, AJvYcCXlw5yGtDdc17fPbRWPmMoa0vXCCJtmSRUVLQ8QCrV25t35awawGYxFM+wAb/B5yA45c8Nl5teuiime29tM@vger.kernel.org
X-Gm-Message-State: AOJu0YyDeDsWiKr4sonB/QRvbuRL6RX+qXnuGLBIvsKNP9avRS/iubCm
	ToOQ+ME1KySu8iHazz4WtzFhbIxRUKmKfHbTv/SezqeQ75NEdV1z
X-Google-Smtp-Source: AGHT+IFVwvOqVPGo03VnhqxHzm3JDs5eAGUx4DD90f/N4FGPaFbMyYpEsXFOvf6ViHdbr9hk3Y461A==
X-Received: by 2002:a2e:5119:0:b0:2fa:c59d:1af3 with SMTP id 38308e7fff4ca-2faf3c41693mr19330691fa.20.1728116804793;
        Sat, 05 Oct 2024 01:26:44 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9b3a88esm1857711fa.125.2024.10.05.01.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 01:26:43 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sat, 05 Oct 2024 10:26:11 +0200
Subject: [PATCH v3 1/2] mtd: nand: davinci: add support for on-die ECC
 engine type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-ondie-v3-1-459d9c32225c@gmail.com>
References: <20241005-ondie-v3-0-459d9c32225c@gmail.com>
In-Reply-To: <20241005-ondie-v3-0-459d9c32225c@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1761;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=PDm1f5NEBuhwxeXGvwzqxiOMHTZXe7TWbR431qOgkS4=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBnAPgxCpGkVQjrQwxeY7yelCHPP4Knt13Zym1Ok
 Mdnp/0SIeqJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZwD4MQAKCRCIgE5vWV1S
 MkiDEACc732NOWaYcnSMRquMSA/lGhB49H478+wBt9qie+3WcgpwB5JT+mC2G4iPmmYRQK3nGVG
 dHotjDqMC6Iw4S59OS3uHUIPItzhaBP+Yv+yE7ds30pRyVrW3ELjACNIbM1/l+krxjgt3HMp97P
 uRYBx/zN/ClslaVSKoExd9DG+o2u8n+OSb0mjKskVnn3qGnOm/Rx17dMSLVSs1Y7uonitNUhPWm
 JNz9epjEfNBtV9Neh9KjmctakSNua8O0Mt7Vfq/uHbVePn1Nof/kbRElO/fFZiTifpOrZJ6Fxk+
 8W8m8Z1Ag0Uz+v7jTo0lIbZdpM9E+GL7sORwtlzVVTtf9ZCDKEci+2drsq4oZWJ+akDkqE8/akz
 rG8LbEGztQunNugJhLaepROxbusYOJoK8KY9Q6IYlh9CBINFRXbB9OItX8LTwtpezUrudj3Sw3V
 7zi0r9JC6/slryo6exmc1GnokhP/ww3MUFflwqRO/EqXm3vzmfcXd+9CqGaohFfaFhU7S0Dg5/j
 6E3a+BMYisHWJK+tV5yyWRqWBAsZYhfGxbD+CNh3Kt/yIXiZRJq9jA4vLp1pXvGloAMSWWiLFQR
 uicjj8xkP3jOVrPfpXz+3RlZBnSGptba9lUVVyisN3kYSDc8AWhMXiyymGcf4RUN8erfFSzI3Fg
 9qPUeZD7pDCOnXA==
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
2.46.0


