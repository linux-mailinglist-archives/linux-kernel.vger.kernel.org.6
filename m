Return-Path: <linux-kernel+bounces-249272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A2F92E90E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF609287947
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E380214A601;
	Thu, 11 Jul 2024 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJksXENK"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7715ECDF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703777; cv=none; b=MbZUO+PLpDdJgDuce9Jpg/BJpoYRSv02FhdixlIQstbW3Ry66cj23a3cZvCli/4yBBq8Q09bhE6XE3eslnFv5AEAa58Ejci4BpghBqv0iCoIS5hWKl+KOQ3jiZ/tSQu4gjBvOUSCovdsnisoitG5d0amLWDqWkCOkNHMKsPrgaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703777; c=relaxed/simple;
	bh=h/SnQjeIotE/r0mBrmeTceepJ5qYMrJlJH23q1ifQhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fAFd5qqKNe3TTMl62Gnpjibd8K2KJYZOFvUPJoZB+Pu+H2pSRVHGRgtKk8aI6Jg6jvKxMKrErVeSx5ZuFK6oKYg4bJ7rgC8TJ5tBbotqE305WmZl8MCgtwgFRoeohg4ZaOWz3AaNJ3JYkPRgKbVLh2FWbn8XfK9IayNu/UAKwrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJksXENK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4266fd395eeso6308405e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720703774; x=1721308574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C+btIB698AoBarUXfbFVZZbKwRwcIjCEhAp+IjhWQE4=;
        b=FJksXENKjGYQsiIsUkSH16iKviQ8SP0Loy4WFwKnNtcZhD96zpA/RwZIxSz15pShr2
         cQ0Z5sZ5zW3xTuMh0QYj++cWIOjit7NHwqxBIg+vnK35tIYPjlHNfwfMpEGZCb/sM6Eq
         hsscvTNZmqJCntPKiz87Cuj4RG8H0rQH5LJk6iyQqO3jZgStcdZ+oA+JzykdMb0QDodV
         RBgO9Rlb1EEIN7AVFwKe6OH8KsS6ZRxDZ6ZKHk4tAthqfiXu0z8b89roRK0iYM9JiYhq
         BFyFg4QY0H3JxlJsg5DlZsUP6MMNPhUkog6FcN3cgQMmvUhypLRhb8WmpMzzj/u0bXa1
         MIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720703774; x=1721308574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+btIB698AoBarUXfbFVZZbKwRwcIjCEhAp+IjhWQE4=;
        b=bzIzKr9JqgQKB50M1qbgERIsgtYrqRlQCTS+mitf6Lfxx8uVyMiPJuRjQyeYCmefsh
         QC+uI3AlaW4tzGGZHR2hm0fCr503lQ/CuvolZFnHsBoZ+chiHXJy57UEeCx+DITrOy8L
         GxCnfw+noXtpqb3302qd609Q6dx2RnQuT65TLFTRqeoXuP6YXiEt2gDO5WuHjsVO7Sok
         bJ7HPHECk6gsywbXtLBmzbU7kcT/E1m7hEccaXjRuwOCFyncCFXpLkjwN5KDAwORumBm
         a16w44ddH0pOEBdJdx4JzztV3xzvIko0i5Xg+H+a9KNySCubIOA+Og7jaH0Hr/zziDa0
         zPUw==
X-Forwarded-Encrypted: i=1; AJvYcCVdRGk6yYwMzrCirq1THejkA3GILa/Q7EoCUq2MuP0Hzt11X07YWSkDs66BWyiFZATXDzjYZPORFWqWXQqxRF8MaWBJFFXH+lzLZYg4
X-Gm-Message-State: AOJu0YwxyPV1NPx9RxayUZXB43M+HZdRPAA6drOwbPsikPvgcy9RyN0m
	L3TzltCwPxm03Fq6IGBDUksHswQkv8snwWddIFI9Hs4BUSiaiSP2
X-Google-Smtp-Source: AGHT+IFL0UaiWD7mdTfNHJBjD/TlYPEODih+gOwr8wL08Wda8w+hrgiHASHLfRhsDgZcttdrt9CW1Q==
X-Received: by 2002:a05:600c:54ca:b0:426:6902:7053 with SMTP id 5b1f17b1804b1-426707cc0d7mr58888065e9.15.1720703773802;
        Thu, 11 Jul 2024 06:16:13 -0700 (PDT)
Received: from eichest-laptop.gad.local ([2a02:168:af72:0:49a:1bc0:a7da:9525])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4267255858asm74132645e9.0.2024.07.11.06.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:16:13 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	sergio.paracuellos@gmail.com,
	florian.fainelli@broadcom.com,
	krzysztof.kozlowski@linaro.org,
	eichest@gmail.com,
	robh@kernel.org,
	frank.li@vivo.com
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] phy: marvell: phy-mvebu-cp110-comphy: improve eth_port1 on comphy4
Date: Thu, 11 Jul 2024 15:12:47 +0200
Message-ID: <20240711131612.98952-1-eichest@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the CN9100_MPP_information document, CP_SRD4 (comphy 4)
supports 2500 BASE-X and 5000 BASE-R for ETH_PORT1. I was able to test
that 2500 BASE-X is indeed supported. Unfortunately, our HW does not
support 5000 BASE-R, but I assume from the document that it does, so I
set the muxing there too to 0x1.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
---
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
index da5e8f4057490..fefc02d921e69 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
@@ -244,8 +244,8 @@ static const struct mvebu_comphy_conf mvebu_comphy_cp110_modes[] = {
 	GEN_CONF(4, 1, PHY_MODE_USB_HOST_SS, COMPHY_FW_MODE_USB3H),
 	GEN_CONF(4, 1, PHY_MODE_PCIE, COMPHY_FW_MODE_PCIE),
 	ETH_CONF(4, 1, PHY_INTERFACE_MODE_SGMII, 0x1, COMPHY_FW_MODE_SGMII),
-	ETH_CONF(4, 1, PHY_INTERFACE_MODE_2500BASEX, -1, COMPHY_FW_MODE_2500BASEX),
-	ETH_CONF(4, 1, PHY_INTERFACE_MODE_5GBASER, -1, COMPHY_FW_MODE_XFI),
+	ETH_CONF(4, 1, PHY_INTERFACE_MODE_2500BASEX, 0x1, COMPHY_FW_MODE_2500BASEX),
+	ETH_CONF(4, 1, PHY_INTERFACE_MODE_5GBASER, 0x1, COMPHY_FW_MODE_XFI),
 	ETH_CONF(4, 1, PHY_INTERFACE_MODE_10GBASER, -1, COMPHY_FW_MODE_XFI),
 	/* lane 5 */
 	ETH_CONF(5, 1, PHY_INTERFACE_MODE_RXAUI, 0x2, COMPHY_FW_MODE_RXAUI),
-- 
2.43.0


