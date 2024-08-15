Return-Path: <linux-kernel+bounces-288689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D18953DB3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90230288A04
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB9115B11E;
	Thu, 15 Aug 2024 22:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ay36mJCs"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B214F15B0EE
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762684; cv=none; b=L5CwcOwXDLzc9RqVcJZY2Zan4lLzX7WE8CYYh/pjQOb6Geq40QRSdKmO7vOvERT0bYZI24MR7jM1WlJrXrrZXMRvEcEHI/8aHqOTCT1TxfU7f3DV5OCA4CHSM1JwZ6obzXkFX+VqQA4bhM1EaujZwFqSpxdogBd5+PLFLHGDaKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762684; c=relaxed/simple;
	bh=Y+MjKmHp5mUh5aY4SnwaOPwQvDeezXwzT1w3bwpZJIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XkXVVIFdP8rs1nzRSRhcosDUQrafNQmh7h0dty8IBkmAekpPI9W8jv7WPJ4CD8pHIlM4mWxbpNXQ7znch2gpEqOC5KQH3Dlr++JrYAcir3MrYHnrdoveKHa764bs9X8I+B6GWXo9AlpueuqEzEzqR+YqeSbmwaQinFtJSWqqnIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ay36mJCs; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3c071d276so1058832a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723762682; x=1724367482; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cQNUR4eo2grqHmWzloaYQ1piFbFOSyvLprH/Wsr2BKQ=;
        b=ay36mJCskxMUtT7+4/O0Mjy4CVPPhNbrzD0oTGc4AgM5YiKD/Y2k/9Wgng8cXrHLeP
         GmwFLgBwmBSpRPlZlnfcNTJQA+NMTSsDK3iVbR5tt7+SHpKpR3XIdgUrK0dD24ab7xmR
         nbVir2N/Q1BLovvFXCniMcHwa03z+rSWaK60Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723762682; x=1724367482;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQNUR4eo2grqHmWzloaYQ1piFbFOSyvLprH/Wsr2BKQ=;
        b=cjY26/mtn52acdU4fYJIkE2LNSlBaXb99jvGazuiyP6cszXlOQaTg9XYkzUA3D37+d
         PC8b6IqX/m2sKKkuDYX9dACcg32BuAnhWVh2w6WgLptOMsrgzbqBNTgwCp2GwYC/Xz0k
         Uwn1jLIgzD8R/rrC+Ok9bGhzuf3ERPlFasjaostnqTO7NUrnPA86O5BN4RkT8xlf8fAP
         ZfduMKm3pF3L6drGoSz/P0G7KU4SWWDLKKy44Rkd/HWw20lbljUXGPgGyGOCxt0m63Td
         ZPaqQpRgVkO3LsnJlymzezkVEItXkQJ9yOc6W6563A8rwf/DHbtSPyxw8xy6mNek+GFx
         zlsg==
X-Forwarded-Encrypted: i=1; AJvYcCXPtzeB43SZE6hrqqs8SIYJ/D48doFf7SOYuHK3JyNzFAujUr9eVDJ/0rYAd3doe4lpDKEhrHqjpBL1KrZDvVFGi/50xG/61L1IL0il
X-Gm-Message-State: AOJu0YyVuo4XGPUqm0lSP8hqpfJxhn8BWSsCofoPXkAZEqsLsT9B7e/Y
	E62CubSBQQ+CSl4G8+Dh1xAnAz/iOm4CepbpFPGgUF+J+M3OVKEsbow3YU1a6Q==
X-Google-Smtp-Source: AGHT+IHhhzzPytfNy1akq9lEmeO1LBTMtBLfCNyTCRSEt91lpkiU1VmEpGZ8WkgxTVaHZ49GNZvZ5w==
X-Received: by 2002:a17:90b:1208:b0:2cb:5455:8018 with SMTP id 98e67ed59e1d1-2d3dfd8c73cmr1309322a91.23.1723762682128;
        Thu, 15 Aug 2024 15:58:02 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6b2d1sm373997a91.18.2024.08.15.15.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:58:01 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 06/13] PCI: brcmstb: Use swinit reset if available
Date: Thu, 15 Aug 2024 18:57:19 -0400
Message-Id: <20240815225731.40276-7-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240815225731.40276-1-james.quinlan@broadcom.com>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The 7712 SOC adds a software init reset device for the PCIe HW.
If found in the DT node, use it.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index af14debd81d0..aa21c4c7b7f7 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -266,6 +266,7 @@ struct brcm_pcie {
 	struct reset_control	*rescal;
 	struct reset_control	*perst_reset;
 	struct reset_control	*bridge_reset;
+	struct reset_control	*swinit_reset;
 	int			num_memc;
 	u64			memc_size[PCIE_BRCM_MAX_MEMC];
 	u32			hw_rev;
@@ -1633,12 +1634,35 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pcie->bridge_reset))
 		return PTR_ERR(pcie->bridge_reset);
 
+	pcie->swinit_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "swinit");
+	if (IS_ERR(pcie->swinit_reset))
+		return PTR_ERR(pcie->swinit_reset);
+
 	ret = clk_prepare_enable(pcie->clk);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
 
 	pcie->bridge_sw_init_set(pcie, 0);
 
+	if (pcie->swinit_reset) {
+		ret = reset_control_assert(pcie->swinit_reset);
+		if (ret) {
+			clk_disable_unprepare(pcie->clk);
+			return dev_err_probe(&pdev->dev, ret,
+					     "could not assert reset 'swinit'\n");
+		}
+
+		/* HW team recommends 1us for proper sync and propagation of reset */
+		udelay(1);
+
+		ret = reset_control_deassert(pcie->swinit_reset);
+		if (ret) {
+			clk_disable_unprepare(pcie->clk);
+			return dev_err_probe(&pdev->dev, ret,
+					     "could not de-assert reset 'swinit'\n");
+		}
+	}
+
 	ret = reset_control_reset(pcie->rescal);
 	if (ret) {
 		clk_disable_unprepare(pcie->clk);
-- 
2.17.1


