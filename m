Return-Path: <linux-kernel+bounces-538363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE14A49798
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29AA83B7E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC4A25F984;
	Fri, 28 Feb 2025 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Of04d9A1"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4504725F97E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739209; cv=none; b=Pm+iGgpjW2thWGyTfOx3wwKzCpW5YkBWSaRDrqEUGqSlZK6XK9s9gfyntRqRmY5EXikNvKZzgaINrD/xOn+sQjsFsDPjVrHcZTQ1bxpNcXP0Q+Z8gcHo7lGeW8xWR2aJ+AgZQbwcuH+gxiY4Z/BZhvT7tnW8oMp+CSccxgGPlZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739209; c=relaxed/simple;
	bh=it8keP00Y+Nd5kfx7A3bztiKx9hyKFAAHBswegYUOxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaJ5LRe9DIVFTvRjolzHjgxiLhq7P1ZIHYdGAzB7aJjaiPVSGPQOKZBbBY6cMC4PgwoDQ30LF9KJDG5Oz6WPDQ8rPXXZ6f64El+Cy5vVtivDJzz5tFGiQzbdTo2cbAtFGRU0Jjff2l0Y9lUgcV6imomdf1yDzf23PV65LNoepQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Of04d9A1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso20209625e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740739206; x=1741344006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=312sLNrqEv63+Mv44pzQbo4rdknipAPccCqJcSeXheU=;
        b=Of04d9A1c/U+B5RTzflYCsXsalwSXPmY4dNcyA3y4cyjqu9BhzEuHo4M3umPVM+4yH
         LsL16HNKCgSUsDyYiovd97HiDjx3/qMkwgIXstTdHqdYlWazo3zq+dvZL95xu7ue/lyo
         sXwcW/PrztV+PxSVbJ/8kajZ3MRljxB6kdPY9Pu7vpKbFNRt6FF8JgBscE8xVqcTbXY0
         wUbiXpyTm8IUJ2Tw9Gb4UCiGqxBY8lNEL/KhD/aNAp9nkTU9//Te/lw3L0nCoAuDeH0W
         9lMTxQoJfeCpwXRuspQlF3yhWEdl4DKPb4ffgdhqU7d42YBn4CaUqRAY8NuPjuG8t3r9
         vO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740739206; x=1741344006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=312sLNrqEv63+Mv44pzQbo4rdknipAPccCqJcSeXheU=;
        b=ZXavUeu4O2vGJQv+VnxkBDRs4STdNBszd5PABdPmjc8gZCcNL3DkBrTiuM9FgoJ7tx
         QEUz3kyIGsgPshceDdSwGvHoA+jBRlMKbKfRONtyoZpeFZhOA59/kYm6HwnSrlrXSMjo
         1FQQJMh4VC05b+RWkbnTaG13T+peYyG2kV5ymC2GjAgZtQQ9/Ze5iiiZGKlJigz3MWjf
         40gqLpOptSRRN/r3OSkVVcZm3xkiGE70YKSyvjnN3rYoCro939sP3kSrc2ykf/zuuuuY
         9SWUm70y+n4fEU5QZxgIBQBzmcPtVhunocqdnG9/+4CCxD3e+QbdO55S66qlQrQD5RZ0
         g9zg==
X-Forwarded-Encrypted: i=1; AJvYcCVioIBmlaNHbyVVVNm9EmxmOuoJvl6XNo1npFFfSAqy/GYn9SSRmArrNX6HWKimP/IJGRSlrvryvzzWS5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9pjJVLGnKzXBy6NenqAr4h1fnOLeMIB8hoiw1jRZLBTyputI/
	3WKr7eyfN/DIYTye2KMipSs8q9vUF9JHNJF83uOS5Nt1LPfI/8et
X-Gm-Gg: ASbGncsKWhM5NMkNy5e3u2IR5AlFYdk2yTohSisp539BbAgiBAcLrCFmg6fWUYiPO85
	RKQ5Ycx4EkdPtQF0BshcIJFGb+XJDEuzRSdA8Tu3l4SWDkxfvuYmnWBMOJeVsHtCtc6cvQP1ATw
	+Q1/N9GzRLtJVHoPBGt9+oiotxS04FFeOUsdJXbvNQt0WkEtnmDtdwBsqnzlixGJsELOPTzYJWy
	KvxkME9R8v2sRdTHhaWsZD+PXWYgLYG1iWT9AKrUBHkTaXPU38sCClwEGo+6rFeZfuP0FJ3+3nG
	MpkSZbzY+OPFDZvQWekdvMelJj0NcNDfD3JHKWLXfg==
X-Google-Smtp-Source: AGHT+IFncYfQLZzLO9PxJRHTbcQAlKTjUNCZ0jwHv2Xpg6+UDCdisti3XOyvr9rdDHjH0Z4kclaw5A==
X-Received: by 2002:a05:600c:4685:b0:439:a0a3:a15 with SMTP id 5b1f17b1804b1-43ba67045camr27125335e9.14.1740739206381;
        Fri, 28 Feb 2025 02:40:06 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:31d5:4145:8035:cb68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73703caesm52078855e9.12.2025.02.28.02.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 02:40:06 -0800 (PST)
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
Subject: [PATCH v1 1/2] phy: freescale: imx8m-pcie: cleanup reset logic
Date: Fri, 28 Feb 2025 11:38:33 +0100
Message-ID: <20250228103959.47419-2-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250228103959.47419-1-eichest@gmail.com>
References: <20250228103959.47419-1-eichest@gmail.com>
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
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index e98361dcdeadf..00f957a42d9dc 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -141,15 +141,11 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 			   IMX8MM_GPR_PCIE_REF_CLK_PLL);
 	usleep_range(100, 200);
 
-	switch (imx8_phy->drvdata->variant) {
-	case IMX8MP:
+	if (imx8_phy->perst)
 		reset_control_deassert(imx8_phy->perst);
-		fallthrough;
-	case IMX8MM:
-		reset_control_deassert(imx8_phy->reset);
-		usleep_range(200, 500);
-		break;
-	}
+
+	reset_control_deassert(imx8_phy->reset);
+	usleep_range(200, 500);
 
 	/* Do the PHY common block reset */
 	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
-- 
2.45.2


