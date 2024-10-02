Return-Path: <linux-kernel+bounces-347205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0382B98CF6E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353711C22588
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8949719885B;
	Wed,  2 Oct 2024 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri+l49SN"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A64119754A;
	Wed,  2 Oct 2024 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859725; cv=none; b=UlmMGIQc+Rz9Msoj+mqc/UjIP5eS5cPT5nk38WIWJ463AtYsYtqp33tcsmTTqOErc0M2Aw/Aoh9ARCRo3TiCnDeBtsWYXobzKGUPa1NxUGaOeHosFeaTHcOcNnsR8jnhjQxEvIRlRyfqeQvJTk/+cTVRxIs+zB+y2ag6QfVonmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859725; c=relaxed/simple;
	bh=PDm1f5NEBuhwxeXGvwzqxiOMHTZXe7TWbR431qOgkS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VIkjKNe0XMDUtXpEmYuBQyk/SkfBDYNGchNMbBO8eBsYhos3R4c5HyRtExICv/IkKhG1avcvk6ilxYTbF/TCuB51V0bLnlTAbSCanQ0GbB2nMyHJNM9BjshxebjqJdYjKd3bmwRcc/WsDBOy+Gn+65ER/+Oa/ORHcaRQoS4fZaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ri+l49SN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-537a399e06dso7381148e87.1;
        Wed, 02 Oct 2024 02:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727859722; x=1728464522; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqCsg44tBpEIKTMwf8yZOmaXX9/g3lsiJW70OB7Ta3s=;
        b=Ri+l49SNDpYBnL4kDixwU7ERfLPvrpuZx3a3RbvJ8ysnkmH0D9GgzLNh+HvavDGZGv
         2rjfYNibMqN9lJAffw9r/2uf7qXdjA+JIz9DbDF/193J0ppQ0IShoFezjuBxcrbOzZy1
         K6KK4v8YSgHDOors6qzD6QP93c9foXvSa7rHbE32K/gWgVM+1/VnsSgbuTMraV1wRIKx
         bPnUZ0CDR8wBH2adQPh818vGq+BNcokVSOezZN9/RyZuciWGfshU9D4dNNNgb9cx9lB/
         QOLuykcI1NgMoUbdqvcfRI3RY15JIhbUduRWh/a9hpUgM578sgT50Lgooqx+z9nMYITS
         j3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859722; x=1728464522;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqCsg44tBpEIKTMwf8yZOmaXX9/g3lsiJW70OB7Ta3s=;
        b=YBCZxl/WPhi/tYD2PZ2OAzUOjoAGmxLW59iNkrRPcNEqqLrB1UzVQSugwmw31bFNzt
         spVsq9oVGsmjGf5Ij2dObyQEzObZSsaS7Ev+lznbmsAruuU+o1hVJJBIWIv6CQZ7Gl7k
         L1oRyPshZorFsi9WnkYrNVHbYmmsEmD0fTAGVns9RFxngon0flQ+uZn6bkGaFtow1UAw
         WBF2QfQbmHMxAuAp7j+zeLvhTj7IqS1OZJnhn8nm8p0SHKQMXkDqyWrznttqJhHHufQ6
         dPtQwCcH5Q3P1jCpekueD6UgievQ+A5YaOJ/ZpGxg9cl8BcdiAakvsp6eptYHNtADnDX
         dFqw==
X-Forwarded-Encrypted: i=1; AJvYcCUU6KqkyCXwxkjNmCYYZV+i6OPMYMePZDm/t+BmdwBfni07LkauUqogjv4Gx8RhpnT1PX48BMZ7HwLftq/1@vger.kernel.org, AJvYcCV+ZpSLBqn0hwE8+LEqJKWcDHE+F9/ZL+fiwlQI+q76dd6qkIf15LwxL6NnOddhPpMS8idg38rBX1SX@vger.kernel.org
X-Gm-Message-State: AOJu0YzsKGK7MVgByh5RwoTd25zX0YeqRlYSFErrsq80uLhbKikhQX/Y
	K/HXagZpNFE8mu2gRGyjRyhiG3gJFxjRZrypXMPLA79DFzVZmDyEyBkiLvgH
X-Google-Smtp-Source: AGHT+IHjviN380Pp6qWXhdhusVCqvi5yTuTTpLcAiPqKXlHfeD3P5nLoR0Ak/54fJeBl2C3coR7BiA==
X-Received: by 2002:a05:6512:e9a:b0:539:958f:1b8b with SMTP id 2adb3069b0e04-539a07a8926mr1231265e87.50.1727859721623;
        Wed, 02 Oct 2024 02:02:01 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5389fd5e35asm1846796e87.85.2024.10.02.02.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:02:00 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 02 Oct 2024 11:01:30 +0200
Subject: [PATCH v2 1/2] mtd: nand: davinci: add support for on-die ECC
 engine type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-ondie-v2-1-318156d8c7b4@gmail.com>
References: <20241002-ondie-v2-0-318156d8c7b4@gmail.com>
In-Reply-To: <20241002-ondie-v2-0-318156d8c7b4@gmail.com>
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
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBm/Qv43YX/2P3sukVbRasUZMx6dKxjhGPrFgfVf
 KUfT2lsozqJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZv0L+AAKCRCIgE5vWV1S
 MlLuEADUsGNiGCfepQjcAvRqERhoDTlGdHv+qa/i8b9LGFfJK/PsS7K4f8VBPWVSNtunoU5wYag
 zTz5i9C02Zfpsf9X0b+OLlTJrxfAQrksQYpLSYVwJQZi8R/ME5uQHYV6yxnEl6tG3iEd0mIb/S1
 yW5ddFkCioIHPGhuAdVOPmzfSg513NTA5prI4RsVE3yk5z41T6AoHqV1J5/p4XrVmfrxiDXYD+0
 xLoPlhssJudHqbv0aVd4kJsQG7zRkjhFL2qlQ0qcVEnRxXpnrlrhvClUO3TC7yeA2D7HUS60CnP
 +EmeIxOuKLQ6Z4MuYATPnq1a2S88sEb0U+bN/XyIhusLJK/ev1vBHa2AVVmmBliIhcQ8WBHv7W8
 eHQ/ogFs3Qm0S8gTAYwdva4hbCrHAxM+Sews9jZuJMr3iSUmELp3RCJq26zdqphyhXah/z5bDDU
 YzG3LW6LuKvlb1D4T72mkAI/yP25RZpDhfebZWqZcaL3THkDSjNcYWqqXFxBaAGU3mWM0qTdkSP
 vxa4fyNPSXVGjxn6qx0PZJ47lknAh9IDDaLJ9ncUmrzo9i02UT3RGhftt26D5C+K+evK7VyRplj
 Zl2M7Wi+JxDulRSNqwFjmbFJ2Gyaiuz7h8DpstMMpK2Y+ovs4EcUfReaXHD+ehhsofHyZ9SGXNW
 KfAygC7/840d1bw==
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


