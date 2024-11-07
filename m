Return-Path: <linux-kernel+bounces-399577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4069C0107
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F941C2148C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6981E1C2E;
	Thu,  7 Nov 2024 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWxzNMz8"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9571DFDB4;
	Thu,  7 Nov 2024 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730971221; cv=none; b=Vn/s71shh+u+KtB16EOiddR5C+MB60K4YfoKijz5yI2NKx+++27KAugqXveSlqQbN2m9575yO+AUp4woF8AT0P4KDVdRI0sbgfIw+PsZKksIcOUWZfBZQgL5cZC4zfgxHYCSA+SVlTwqEk9/R3Jr+e/tipBf6j41uetBnXLJRpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730971221; c=relaxed/simple;
	bh=aEezSAYRZux5sp8R/V/BZi69L/f49HVcP44j8wR1Vf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hR5tBraaJqEUX1TkBMo8R+oawiFCLjFW7ANgMdx9Hpu4+4VoML2fp5zY+RXjl62nKPsoyvk+f9JmPzxQAPDUPI0ai4wRVuD6Q79AqAjaBxbXKJL3jJisgaNCqSJ7+eqUCfytE8lmtxKuHvscyP0Dfp19FttbNpcrCL7lIaY0M4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWxzNMz8; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f8490856so739076e87.2;
        Thu, 07 Nov 2024 01:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730971218; x=1731576018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smTKmYgVjf2tZh/nJwAXDtC0KskLoU7un/mwCANgBrg=;
        b=YWxzNMz8H62YNemL0RdK3y7YaSjT/mnUSxhLoy0Qdpvmp30gM6/JMJsTk9+7f9gegl
         4y6wksgMyfV2VgBHR3oRe+LLRfHyFNyHX9Y7Q1EWbQg59SBCaXoMSXJ3EtOyr4sOXPLK
         gpTp7ZClUHwvmQaiLE5bh+O5+4G7TjZwBlrt6m2uTBn+Hri/ULD3MsJvOZBS53wMJnRP
         zDW7egZv7KOlW+8NwmdTggSdSjCeHs3niBv1teDBDZopXH2aoP+4Uvt2pvI0436c+zjT
         bkX/SdAJ/I4PdGNvgjhCIgkgtLSWWhrPiTn4KDWbDiXqHKG4LGVRizjQ3qYpOVEVfNHb
         cB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730971218; x=1731576018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smTKmYgVjf2tZh/nJwAXDtC0KskLoU7un/mwCANgBrg=;
        b=Ar/WoQi75R8XdacXchEOFV+P4eiZgNrDqNo+rMZzVthgbYrmCbZBeo4YLfJ6AvtCkC
         /MpUWh+ACZ74hbTWC3TPMpH4QdQQI/rHLgBCrfZq4XlOgqsvXVOp5+S0DS2rr/WHiQZz
         pVMaPOvrXVYIY3pX/WxzblPzZ9a6xsArLaQjLFnPdlddqk/m9GQY0vLbCtDSaL1+n/Bh
         nspd7i62+GfxC5te2ZhDpzopP7UlIDSHC7qymzyd6LErRGlaTAlwGWdtlQtXnZqJFp2e
         PzRswcwKunuBhJlJTXWYJ1hQJz79L7IJ2Vhe9xzRZljkRc1AZJDCUHai8Y3+pNXCYUyi
         nomQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt4SG3vd17Ayoh81x2uXON4veCZ5WGDb/BZgdP0eP7s2Pocp2yjAPSiDQBk7mlAiWPHrsWC08wB3JVx1Le@vger.kernel.org, AJvYcCX2/AS4q1jabrVzRe5ipuBww0w6eUvnPbw0LrbNZPdsnRrJkrb5Y3ezbMeyztO9FPLkUMDBSFPsLuLm@vger.kernel.org
X-Gm-Message-State: AOJu0YyB9X1XdV7zbQahh7WsQBQVS0R5DfGH+sL4tvM2SqK+1HIRYJmb
	bOgqK6UlblTZy14COPlrNhOX60qPwduju0EiCM8cKoBKYQqOTE7Gq1D8H89O
X-Google-Smtp-Source: AGHT+IFuIiLW2mk1ed3zYO/2ZhWW3/RTdXo26ke6p/NuYlsoFxOGKyvFrI12iIQ0sjMuQZgqnxIZdw==
X-Received: by 2002:a05:6512:2248:b0:53a:aea:a9e1 with SMTP id 2adb3069b0e04-53d840a6931mr152942e87.54.1730971218007;
        Thu, 07 Nov 2024 01:20:18 -0800 (PST)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a9b50sm139509e87.182.2024.11.07.01.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 01:20:16 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Thu, 07 Nov 2024 10:19:53 +0100
Subject: [PATCH v6 1/2] mtd: nand: davinci: add support for on-die ECC
 engine type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-ondie-v6-1-f70905dc12bf@gmail.com>
References: <20241107-ondie-v6-0-f70905dc12bf@gmail.com>
In-Reply-To: <20241107-ondie-v6-0-f70905dc12bf@gmail.com>
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
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBnLIZAFjNw3EK+EcvSnpI7MpKvyuxjbmeYprbII
 Nj8FMoFDj+JAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZyyGQAAKCRCIgE5vWV1S
 MnnwEACCRn+mYJTDuG0gkPH7hwwi6zmKOcnUZD3SCKVhRNOrsVTg2PZ5Umq1fzK5h+5bE+NtpcQ
 qifVLbFXsZRTdioh6g39Jrv/tjnmFxqWU5GaHoGpkwIBtZL3D/m/UOX+DCLhZa2X68lJs5gQBpH
 Uh2uh2WJfKh+sPeZm1si8XFbdEH/n5c3HbALGsIcGTZ2pSMHdZmqVAkqiuc4+FPAgNZ2rhbzC+2
 t8/LcKGCCgEpx1K6r5U66qaDxJQBXOZGcpAw3PgV61L4PaWoD+IbQgLTK8U3vqOiTWuaYHBckWy
 6JKidxhiuQ4LhL2L9FQ8zLyx+Q7SQ0b1qk6Vg7+heGCBXaHs+M39oaT9TFAH/b+ErC04W47hTWD
 3r2txc0uFt4I37L+njC8FvlU+coNkddbXzPF2anYdroxAlZ58TGuNB//yORCtwfKBAcrbUSnO4g
 avgNppx7IgggmDscuFhSF1SUqJA+yLbypacQjgfUagaA3WXO3+GvYMQFi8RDY0bXMs9hJt/XF46
 u8RWKZlYJS0nfN+hVEDVBS/zgcml85faQbFY7Ed1tx8L0VAREB/7vN0C+oG0+BNO/DjuDHydtH1
 KCExe1TrVkK+xPR2gl4noWDoRbLHMj+tHZ2VnXCZAVk9glf/sj+YDMfNe08bY+UjwF+8BIkKqwV
 d+uOlwpVh3WdK/g==
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


