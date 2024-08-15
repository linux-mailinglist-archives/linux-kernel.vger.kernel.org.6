Return-Path: <linux-kernel+bounces-287868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A2A952D6A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4F91F25ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A744E1714AA;
	Thu, 15 Aug 2024 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nqnjnnJf"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE917DA7B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721124; cv=none; b=CZkyIV67FGm9hMKVxYzBj0WOi4GZ7Os2sV6xSxt0y1ZaPoShLB2qmTSS/yOb+E4I/MOnYg9M7CrzByJC6zLLlg2dcxiISsDOys96ZA0tYfV/5dPRpjASB2vPHYocm3S9MufEtpwopKpb6UoI3UakVWDdVb1jvNKIDb4/0xn5TYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721124; c=relaxed/simple;
	bh=9r69U4+Vlyv0XEbqFBAdBfxH7OVJ2VXkioo1Q5babH8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uiXupWC6upljJtwcb0z32qsDItbDmGPZqkvurUozpywHpTLORfOiXOIY5E843RGCfyT3k8D0OUE4K0UbjsuBXAGqEqZe7OyGvi5elHf+XYezB8ghep78GbvK3WSbxu5Sx5xsGqLP/PvoP0dnSmkFcEDI/wrLBChWvFRUjxh9eCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nqnjnnJf; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a8caef11fso110881366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 04:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723721121; x=1724325921; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qswmFLJc+rRJnvMK5o1RhUuE0PL9fCewlpe2LTSF+JQ=;
        b=nqnjnnJf1rHF/uJZn/spsnW74eBXGyx7YH9gvunkPJUwrsWFb+eglQrIXF6ACVucY3
         WAxYb7UHO4uJUFMaiASIx4AonUjmgQdA5yDOjm0jTaHl5iFc5yw9HWNWbqTkkkSr2BUz
         LZHStdI41ipF4c1OHTL/G1dodqC/u1TwmQHbvREf3piAWFUcJ2M4j3ycWvpiKRw4QXSm
         5SkwevxcA+yGdpbrB7w1pNUKQ3aalop59RXyBRwAODkeNb60eOhm7cQ9pHYTWLLdCypl
         Ugd4zSSmDpqFRUjlByl6zkpJRpj2/2GUrxKj5rhCNi5lKSNSSFLCRfCfaDDe3Urjc+Cj
         yQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723721121; x=1724325921;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qswmFLJc+rRJnvMK5o1RhUuE0PL9fCewlpe2LTSF+JQ=;
        b=KGF0nFQ6d0r9XZO4UnpPDnmauSCEafevvb3v7OOxwSF/Y5vzbgFEFtfIfYKpC6kWOL
         jw7K9jGbdIZ9nOPl1IGYUF4sqqq+Gd9wlgeFFWwKoxsCK4D69b1ePF2cvVDzN3vXoWi8
         9OREeihLBDT/C9698Bm4zUUmyCDaoSAqt09yNzpSYpBIR6mq7ibALLxxmGzRJGKZGn0M
         /Bxr4RuuLii+LhHDyv6raag0QGZO6Q3I0xFTnz/2sT2WIdJA3BqmXq5R2rutK46sedRi
         mitZrDkiA2/lwb5/tiBp3PRleddevGYW/jL/eZb4Wad7UNbonr4qFlRVSd+l/Eq/9IRq
         UHvg==
X-Forwarded-Encrypted: i=1; AJvYcCWo4Oq0rPbV2au338fl+RgwtJm6B/1QJUJzhcHZEaxyH6aOc6F2tNjRyUxkZsKM9Zvgth6lDoLHo1yNI3X813ZjObBnaYlRb2/6QrB1
X-Gm-Message-State: AOJu0YweVT79j0ljXjp823j8A6QimFcW3q7wMQY/GGCIiyPFR3uNkW9U
	r1Wu8UGAtbCVZ4igSRzdjosfJHk5OCahIap+5HzAOzgiQigvXTgs+XjUAB0II6A=
X-Google-Smtp-Source: AGHT+IE04IYzhOFDEe/StHeMv+I9KreAuEIMLJabn0MgWVsiJJeJsCqyh9XE5pP5z25EACFGgtwnLA==
X-Received: by 2002:a17:907:f1d4:b0:a77:e1fb:7de9 with SMTP id a640c23a62f3a-a8366c0f0e2mr501782366b.5.1723721120636;
        Thu, 15 Aug 2024 04:25:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396ce0asm85941166b.206.2024.08.15.04.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 04:25:20 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:25:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	linux-ide@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ata: ahci_imx: Fix error code in probe()
Message-ID: <cbcbdfc2-ddc7-4684-8ad4-018227823546@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return a negative error code if devm_clk_get() fails.  Don't return
success.

Fixes: 3156e1b2c071 ("ata: ahci_imx: AHB clock rate setting is not required on i.MX8QM AHCI SATA")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/ata/ahci_imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 65f98e8fdf07..6f955e9105e8 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -963,6 +963,7 @@ static int imx_ahci_probe(struct platform_device *pdev)
 		imxpriv->ahb_clk = devm_clk_get(dev, "ahb");
 		if (IS_ERR(imxpriv->ahb_clk)) {
 			dev_err(dev, "Failed to get ahb clock\n");
+			ret = PTR_ERR(imxpriv->ahb_clk);
 			goto disable_sata;
 		}
 		reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
-- 
2.43.0


