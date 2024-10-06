Return-Path: <linux-kernel+bounces-352384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D38991E64
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 15:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D895B211B9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 13:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8449178367;
	Sun,  6 Oct 2024 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ol2S4NMd"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9057F176ADA;
	Sun,  6 Oct 2024 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728219972; cv=none; b=eySapbM8C6HA0A+3oR8mlwZQH3VUKYxLgWBk0FPkA19brwF7pkp8xAcJbEt5kaFob1o3qoCpgzD9hGBtZheNqUhUt6khZ22MAkhCmHuP5EB1s0w8re8TMC+E831wFa20dbs5kDVflAZXqE2yUDFEqzmtvnB4AJRFHWetzaKEpsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728219972; c=relaxed/simple;
	bh=PDm1f5NEBuhwxeXGvwzqxiOMHTZXe7TWbR431qOgkS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DY/HCnueQX+337dirxxgq57mvWavQi0bboPWa6lRioonH8c48ABfqs01QZhteqNU/BkmidcEjV+N8NdjinNW/OvOxvRGqHZcI9JlZ9XhjKLmsfWjzaTfOsl2Gj7eD8nOLqpPqpJWhqbACEMh5XyEHqDAIhprmmoALYPEKo4bCbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ol2S4NMd; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53993c115cfso4468647e87.2;
        Sun, 06 Oct 2024 06:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728219969; x=1728824769; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqCsg44tBpEIKTMwf8yZOmaXX9/g3lsiJW70OB7Ta3s=;
        b=Ol2S4NMdYLVLvkdcGaC9xf1ap77ieKnzsg73BRYDD31gldFLeJRysCLhZa21Ntb4/8
         Zd8krrDFPMBZ62D/A1TrLZuoIc1/RpCAqkK7Hc+9JQeTYmlEDb6UYQjlFZnOL0Ycqyxs
         2d/cXKl/MCwXWpEGQFTpr1yXgZJPKfmjuwJGLDrhRpF05qmqVkMmY70heY9Degjb+rpK
         /LJNAMaZxY4lFaKdLbsRNAqafq4/D3rL4jkpVEtomUsqvJEBJh/4/yto3xEBN7tG2L3K
         FmsEClTK+wszDgDxt/rPJPYT6rIWJ9ngmhI670t2cujfjxm3quBNaiDMEc8wGGWt8RIt
         CEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728219969; x=1728824769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqCsg44tBpEIKTMwf8yZOmaXX9/g3lsiJW70OB7Ta3s=;
        b=sUZmPalTrXHGmTcySPYJL4x3RXDqLgr3U7LSIMCHn4fs9011WcwuslpVMd4mXdx5Wk
         QRI17wNt+XZb5su1inoGly14ru4GPPGJqpbgWgP4O9AWJNRnMPgBVbyowTIPXXVFYSCW
         q2VgjehGkwfvVHMH63clNDYztNvotARLCThbqCXcJiCGgb2ArfL641PTUPtFajDyu80P
         tq9Q1UnVK5va3N+4gPTWCClLPASBIZK8ycxnlUb7G0yjKnN230/wzLgpyyZSXMtNtWRN
         nJ9IVsmHQEc0NnzDie3aFyi8l+n7Jk1G8W5ZiYFF0gXk91i9/DEE2VEfnTXBLWn+7ZwB
         I5IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHl1IAZ7jSYPm1T45HQpeBUGftQ06urQRRrPbPpr3TNE/iqlFZL3XTWEDtR4wtoyBhelWrOYoyzz1Ubv18@vger.kernel.org, AJvYcCXYiZGA9O7whRzCOVPrruB/x3GXYpXxZbfG6NTSdGLNLQfDxvDxRwPS5Dc1Z2rmbKMLOVhMK7dsdro5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz8Sn9e3jqVLoDX1TTQPmS9m/qyhbJhFEayNoJaKZptYq7cXAf
	SCj+Qm3jMfgw3DWN+/n74NjNlbfqACz6To6LHbqZoMsmArgtbjWyCRWnRnNt
X-Google-Smtp-Source: AGHT+IFHqIqGqXtJ+xCvOKuflBKgh6mxClHsjT61U0OhrcQrDQ3ZJ481fuo61ATx/3yQc3Ga4fqBvQ==
X-Received: by 2002:a05:6512:e91:b0:52c:dd3d:85af with SMTP id 2adb3069b0e04-539ab88a2e8mr4163371e87.25.1728219968324;
        Sun, 06 Oct 2024 06:06:08 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff2904csm512749e87.304.2024.10.06.06.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 06:06:06 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sun, 06 Oct 2024 15:05:46 +0200
Subject: [PATCH v4 1/2] mtd: nand: davinci: add support for on-die ECC
 engine type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241006-ondie-v4-1-ff9b9fd9a81d@gmail.com>
References: <20241006-ondie-v4-0-ff9b9fd9a81d@gmail.com>
In-Reply-To: <20241006-ondie-v4-0-ff9b9fd9a81d@gmail.com>
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
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBnAoswOJ1pZOzYvme7rOBZkvdBMKiY6lb2UMKMQ
 hfdLyGcOKWJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZwKLMAAKCRCIgE5vWV1S
 MkpiD/0ZNPL/5fjeuikolIZe2d2NTBwIUOMM6jr9VPfQYdO5KNWn85H9ZqKMwTCMpi6wauqElni
 XeAnDHP1eTfyoyqiGbf709Og0pvZAY8ONQ8WBNAnto5DkzH3/TPDMKR/Rqhn+jJpDE9BTDSADs3
 kUHaIzA72NnB//pgJksJ3UzzTxOvTzVuc+LD8SviYB6sTz+iQNH+/KOCQsAr9maaycHBsXeI5U1
 UE74yq4j7z/uRf+ND/Pr2w/c0OqUKP+qskMgE2bWrKblSGOls/NOMMRI5swdW+PxCEFEZwwjEkk
 RbWJILBS/ccypyYqEVfYPPoCFu48TGGyMY2bObxDPpvZAScXt5V6mRqmA8ELywuUvR1EGCnCSRd
 AYwmi42jTlw8a65wBx6GzGo5mK2j0/EjIgsu2wZhT8FPdygS74pw78Be2TxIAWysokUgEC/WToG
 PIQoslNpne7CRMj67QhMUEfgoZGuivXlm9UQpj/j8IcDolY78ZXhLD57G2aprw5ePsBo/2viwo8
 2TqnfZcmTNnCTT549VaFwUVI2b+oB+CcLhy47CDYpzOmKUfQlVi8cvcxP5p1LQvzVclqdAL1m0r
 pdlnm1XNW5bVEcJ9Cj2eVZbdOCUWfZTnZIRHAqX9oplgEU08ivX1gRbi+sfT5QYKiou0syu6WXk
 Rk/6u/lw2z0/s5A==
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


