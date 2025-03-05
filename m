Return-Path: <linux-kernel+bounces-547065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35476A5028E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2993AA530
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B0424EF63;
	Wed,  5 Mar 2025 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNpWvNr9"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5210724EF69
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185854; cv=none; b=DjRcFlYVb260PurjIEsaiWYuhcTV9VRkDTns2LEwajebpC15wZ85EDZ/kHO8IFgDXQdw3MCncQ/cLuEd/GSWc572Vh3OzHMA8rizh5METCIOUcAZt56LiVP4cSQKeqnQDU0ADUWrYR+yZ6A4zDpWFCr8i67yUFRo9cK6mU93GLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185854; c=relaxed/simple;
	bh=656yZq6rNtUOx1YB7LPH8s26cM1Yb4fvkIYcST6VSoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsRbCSPKmKpBnc9GYYHUWhc8Mj6QCHYsYSj6DMl4jp34BlcFfCUNXIxpHjZvLKFQCOfvnITH8KxiEeG73bn78R/dpUKWjkxacr0kfjq+77b1SyvYkgF7uR/tNzLRo4o/Ib2rqaqfcZ4JiPeHOswMw0KXxkDTqsYsbFLEsSVhBfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNpWvNr9; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39104c1cbbdso1811051f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741185849; x=1741790649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adw/wXG4xAXtVNNpVBpZ7rOz/ozzGq1WFDZ6AcGQFEg=;
        b=dNpWvNr9NuWK9TR0/z3T4WeH0DVVoNGaMK/wdcX8ARGm6xNa2C12M/MZQWFyhL8BxA
         kskU74NbXBFwAHn1ejCLDqG5RLNVzi4+ZtRuwNdFSux+7wRCr5TQwbIfJAfdKtXFDy/6
         INxXM8HLrJUUZshqjml4Lqoeo3rSOj/j/3IK82o1+bAznu8f/KgmmTJkPNpOK5pf1+aO
         xrAYN8VnT3bEGJv7ECoBigCzQU+/Hceth411hryFKNdvOoJrg6VMt7X/cbErNEfybspB
         PwVSBKxn5D41DeREwMppNpEr34tmRbRVVL+MqAVvdxeLqUvj5bbQKxXOEGZJkAjaVZ44
         na5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741185849; x=1741790649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adw/wXG4xAXtVNNpVBpZ7rOz/ozzGq1WFDZ6AcGQFEg=;
        b=QW2pvX0SWlYVvqaQ1bDxTLHG1nYxKFcJkSBSDIU7DXk2z3kgClJEdgCvZiWDGy8S5E
         rwICUuvNkcav5ttf+QkmBDqPc/6N651NxXXUY/szlBGPoa/Qgfq/SVWvOXo3cf2OBb+z
         BMv/Fe2ANsRAwkvSZLuJbzRd4NQTAUjvhSZEj25i33kfgUxHEjFXGxq0hnk15CqVL/zm
         yM73Lq1K7JDRVBRQNLA140bWAOIDGUbi3BVaAyxQO3JyYt499tQgxdxeSO4T60uvC+A2
         N6HX8v/B5TL2fEGQZGLtyQB7za35jzSSS7W5XmCXgbnl+PiW0FebbJEVEo4jdrAG2IHf
         ncOw==
X-Forwarded-Encrypted: i=1; AJvYcCVsCNZtXFPqvEUF/Kgkfv+VYhsazA507IpE4ML09haC1Mh6f+cTDCS0BeaguxHbDEjoZCP3/qh0fz7CBo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFy9XasmrpKoqv4LVkW1G77zCQ+jOdHPZ9e6+2qgvDpFhpOSB9
	FtpFGbfoqaaNDcANK+Eb+sjcB9k4fHJ6wRC/qD2Mxeeqg+mfbIXS
X-Gm-Gg: ASbGncvidAP0FPb0y4XVD4EwG3/j4HTbvYn62qU9EsCkvpc3UNqVsVoQjwq7mOkZ1m6
	vKKNzaApSVOjH1n0dW/2vZBHs7VA+GdxmWnyo54UTovCH2UXW3OC+otBduih4mLzdSmaIXSOfsS
	NU1aujHQfYjKozagSeYiI658Y+DsDUTIxR2JbyFOFai2mkbR7cNAPr3rPPE4pnuCFv8kv5YaMxX
	lVy7y6lXcElwZ+t1zwevEH6JgKgcCYGOaiCYbr/UqzgUU8w0y9yXskSfWTNLssu3fS/+MiuH/bw
	To25R/r4jULbT7zkhd03127CwWfNR2UGeynDhRo6srH3uAsK
X-Google-Smtp-Source: AGHT+IFbsaX9wmtUFug2h6kZAAYC0Hb0y6lxNl62FVu79knUqZWExgLI4s21uIXSphigDaJmEpgWiw==
X-Received: by 2002:a05:6000:2cd:b0:390:ea34:7d83 with SMTP id ffacd0b85a97d-3911f76f519mr3393536f8f.31.1741185849295;
        Wed, 05 Mar 2025 06:44:09 -0800 (PST)
Received: from eichest-laptop.. ([178.197.169.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd435cd8csm19314375e9.40.2025.03.05.06.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:44:09 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	p.zabel@pengutronix.de,
	tharvey@gateworks.com,
	hongxing.zhu@nxp.com,
	francesco.dolcini@toradex.com
Cc: linux-phy@lists.infradead.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v2 1/2] phy: freescale: imx8m-pcie: cleanup reset logic
Date: Wed,  5 Mar 2025 15:43:15 +0100
Message-ID: <20250305144355.20364-2-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250305144355.20364-1-eichest@gmail.com>
References: <20250305144355.20364-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Remove the switch statement and base perst release on whether it is
found in the device tree. The probe function fails without the reset
property, making it mandatory. Therefore, always release reset
independent of the variant.

This does not change the behavior of the driver but reduces driver
complexity and allows for easier future modifications.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index e98361dcdeadf..5b505e34ca364 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -141,15 +141,9 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 			   IMX8MM_GPR_PCIE_REF_CLK_PLL);
 	usleep_range(100, 200);
 
-	switch (imx8_phy->drvdata->variant) {
-	case IMX8MP:
-		reset_control_deassert(imx8_phy->perst);
-		fallthrough;
-	case IMX8MM:
-		reset_control_deassert(imx8_phy->reset);
-		usleep_range(200, 500);
-		break;
-	}
+	reset_control_deassert(imx8_phy->perst);
+	reset_control_deassert(imx8_phy->reset);
+	usleep_range(200, 500);
 
 	/* Do the PHY common block reset */
 	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
-- 
2.45.2


