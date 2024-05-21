Return-Path: <linux-kernel+bounces-184655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C78B78CAA1E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E19F1F2236B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C436BFBC;
	Tue, 21 May 2024 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GGrm8FTu"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE185579F
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280514; cv=none; b=T/dXfF+MW62GkmQOXb+OZFAYqa8YluJIl5DC3W+aj63cFSTlqveqPCG99p/0qKoFtG2RqOluzmZcPVpjjHU5xE2RndO1C7NSwxuyLdbbqAmwRzjAM2Oa3SZI+pxxyHtyzwAx4DPthbqs1WGZ7m0vd2pgey03PSRpG18bA4x/gVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280514; c=relaxed/simple;
	bh=y5QaR0C7PpeJzmsQ9dDbD7B8GvNZlMj9O7OXHSq0r6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mm9g1F3W4uAOWMRrScruG8onQ1TWTjsH6SzjhnibAeZVJlxB1x1qO06FcZqpdYQkt+hdInUVmsiIT25wUuzbebXA/Fz4C0ywIui4MwC9tvgXihLtvXVg4P9QH50/0j3VADAckVNDNT+R4Y8/2zKRHggXjLizHYpm1zOMcJz3qYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GGrm8FTu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5dcb5a0db4so328956666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 01:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716280511; x=1716885311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2fOQltsojx/EfK7u7I+TssNN5t4CrMscEHwUz7PdS4=;
        b=GGrm8FTu7m9CxZw9AcltcugEzu3enmPkwFmjcZ/BHbJLM7GchV7K0iccW6t8Vh0sbG
         N3CZShY0vu78WFMhWFgSQyFLAxl4hi3hM8OxP/0nz903Mi2rS77YuSyjCEU1ttrZEhp2
         0Z6/rCVLM67T3YQ4QIaT1hRoaBRja9mEY6zrsbJcAu+shkjFY7NyfS+8Yg7zI7iK9Gjp
         k6DrdSy5/sUqAO0yoF6U2/kmqjKzGKGA8gmXzzIXbXCwRzjWqLYANKC+e60Ui6r6GbML
         OM+dp/jYJ4EZ+ffokDb/jKByoK4x052DmLWlT6z1FDEDSnTfDz7KKrWitnoteg0ev1+x
         Bcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716280511; x=1716885311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2fOQltsojx/EfK7u7I+TssNN5t4CrMscEHwUz7PdS4=;
        b=nE0FqV931eUJKPTDMbo2uM4YUI2X82lVM216wfwIQn+ij77mZ8OOQZkwkupPdOu+cg
         tFqgp21lR8E16A2G90iZgdHAoTBC5ospSvboAlaiDe8dO8TUE1cWQEYY8zxHhXuqzUAV
         4yTWiS+AIhYRDB6JBhu+1Hc6XAbkqHiWFcO61nviIgq2CiXM3w/Z1AXyY0llQXA8XRPb
         GN/AudZgaWzh6zOU09CWd/85UcyZYJpV6OpY+TXCEQjr5SxH/ACBOXRmwASwlDmlLwp6
         rcOvg9SIUKXaP6q0UKNaZ7TWEFO+dEC8o8500jMg5eqf6z86rMTyLszt3vj/I2WYLKJK
         EiTg==
X-Forwarded-Encrypted: i=1; AJvYcCXKB8ztphIhd2PFK0R9QPUKjqxG9SzdLkOTearvUO4hGUXKsfZ5FM9958UBTgE0cXXHYbdlFpLQem0+8QTNtKN9zo0x5QxIbJB1KLCF
X-Gm-Message-State: AOJu0YzIgukNPkbVdz6ofHF/omreLjhH4C7LzNQQnoL944P31n3AM2Ie
	h1r/Nvwfb+H0B/VWcggf+UWb/TtlkyEe3CdzcxwuidurebqqlG4QTCT+21HX7yc=
X-Google-Smtp-Source: AGHT+IEvkv22JFzUjiKZ/QCHeIdDQIX0EZHONqalNwfZwbu9gG6VO37bmkSctPmgWFlMfN25yeFZrQ==
X-Received: by 2002:a17:906:37d6:b0:a55:9dec:355f with SMTP id a640c23a62f3a-a5a2d676774mr1842300566b.70.1716280510921;
        Tue, 21 May 2024 01:35:10 -0700 (PDT)
Received: from localhost (host-87-18-209-253.retail.telecomitalia.it. [87.18.209.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01932sm1570871666b.168.2024.05.21.01.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 01:35:10 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Marc Zyngier <maz@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v3 3/4] mmc: sdhci-brcmstb: Add BCM2712 support
Date: Tue, 21 May 2024 10:35:15 +0200
Message-ID: <c413737f538d9bd403c30104a83a7fbb1ea7461d.1716277695.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1716277695.git.andrea.porta@suse.com>
References: <cover.1716277695.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Broadcom BCM2712 SoC has an SDHCI card controller using the SDIO CFG
register block present on other STB chips. Add support for BCM2712
SD capabilities of this chipset.
The silicon is SD Express capable but this driver port does not currently
include that feature yet.
Based on downstream driver by raspberry foundation maintained kernel.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 65 ++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 9053526fa212..b349262da36e 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -30,6 +30,21 @@
 
 #define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
 
+#define SDIO_CFG_CQ_CAPABILITY			0x4c
+#define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
+
+#define SDIO_CFG_CTRL				0x0
+#define SDIO_CFG_CTRL_SDCD_N_TEST_EN		BIT(31)
+#define SDIO_CFG_CTRL_SDCD_N_TEST_LEV		BIT(30)
+
+#define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
+#define SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE	BIT(31)
+#define SDIO_CFG_MAX_50MHZ_MODE_ENABLE		BIT(0)
+
+#define MMC_CAP_HSE_MASK	(MMC_CAP2_HSX00_1_2V | MMC_CAP2_HSX00_1_8V)
+/* Select all SD UHS type I SDR speed above 50MB/s */
+#define MMC_CAP_UHS_I_SDR_MASK	(MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104)
+
 struct sdhci_brcmstb_priv {
 	void __iomem *cfg_regs;
 	unsigned int flags;
@@ -38,6 +53,7 @@ struct sdhci_brcmstb_priv {
 };
 
 struct brcmstb_match_priv {
+	void (*cfginit)(struct sdhci_host *host);
 	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
 	struct sdhci_ops *ops;
 	const unsigned int flags;
@@ -168,6 +184,38 @@ static void sdhci_brcmstb_set_uhs_signaling(struct sdhci_host *host,
 	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 }
 
+static void sdhci_brcmstb_cfginit_2712(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *brcmstb_priv = sdhci_pltfm_priv(pltfm_host);
+	u32 reg, base_clk_mhz;
+
+	/*
+	 * If we support a speed that requires tuning,
+	 * then select the delay line PHY as the clock source.
+	 */
+	if ((host->mmc->caps & MMC_CAP_UHS_I_SDR_MASK) || (host->mmc->caps2 & MMC_CAP_HSE_MASK)) {
+		reg = readl(brcmstb_priv->cfg_regs + SDIO_CFG_MAX_50MHZ_MODE);
+		reg &= ~SDIO_CFG_MAX_50MHZ_MODE_ENABLE;
+		reg |= SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE;
+		writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_MAX_50MHZ_MODE);
+	}
+
+	if ((host->mmc->caps & MMC_CAP_NONREMOVABLE) ||
+	    (host->mmc->caps & MMC_CAP_NEEDS_POLL)) {
+		/* Force presence */
+		reg = readl(brcmstb_priv->cfg_regs + SDIO_CFG_CTRL);
+		reg &= ~SDIO_CFG_CTRL_SDCD_N_TEST_LEV;
+		reg |= SDIO_CFG_CTRL_SDCD_N_TEST_EN;
+		writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_CTRL);
+	}
+
+	/* Guesstimate the timer frequency (controller base clock) */
+	base_clk_mhz = max_t(u32, clk_get_rate(pltfm_host->clk) / (1000 * 1000), 1);
+	reg = SDIO_CFG_CQ_CAPABILITY_FMUL | base_clk_mhz;
+	writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_CQ_CAPABILITY);
+}
+
 static void sdhci_brcmstb_dumpregs(struct mmc_host *mmc)
 {
 	sdhci_dumpregs(mmc_priv(mmc));
@@ -200,6 +248,14 @@ static struct sdhci_ops sdhci_brcmstb_ops = {
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
+static struct sdhci_ops sdhci_brcmstb_ops_2712 = {
+	.set_clock = sdhci_set_clock,
+	.set_power = sdhci_set_power_and_bus_voltage,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+};
+
 static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
 	.set_clock = sdhci_brcmstb_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -214,6 +270,11 @@ static struct sdhci_ops sdhci_brcmstb_ops_74165b0 = {
 	.set_uhs_signaling = sdhci_brcmstb_set_uhs_signaling,
 };
 
+static const struct brcmstb_match_priv match_priv_2712 = {
+	.cfginit = sdhci_brcmstb_cfginit_2712,
+	.ops = &sdhci_brcmstb_ops_2712,
+};
+
 static struct brcmstb_match_priv match_priv_7425 = {
 	.flags = BRCMSTB_MATCH_FLAGS_NO_64BIT |
 	BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
@@ -238,6 +299,7 @@ static struct brcmstb_match_priv match_priv_74165b0 = {
 };
 
 static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
+	{ .compatible = "brcm,bcm2712-sdhci", .data = &match_priv_2712 },
 	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
 	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
 	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
@@ -370,6 +432,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	    (host->mmc->caps2 & MMC_CAP2_HS400_ES))
 		host->mmc_host_ops.hs400_enhanced_strobe = match_priv->hs400es;
 
+	if (match_priv->cfginit)
+		match_priv->cfginit(host);
+
 	/*
 	 * Supply the existing CAPS, but clear the UHS modes. This
 	 * will allow these modes to be specified by device tree
-- 
2.35.3


