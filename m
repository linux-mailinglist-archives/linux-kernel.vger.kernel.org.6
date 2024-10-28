Return-Path: <linux-kernel+bounces-384648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30B89B2CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C78282B01
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86F81D61A1;
	Mon, 28 Oct 2024 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Ma0I00Jc"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7001D358C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111177; cv=none; b=Dl/sDElVI6TIjI+ghXij102QM+UyqiMpr3YRna1gdS4SIjLlQPldzLR6rWe+j08mkBtzrd1F477izqJ6FMMLP1TESCo5kKQfLN7i00rNDXgV4dhrjifM4brldiVpf7+qyaSJxCNxjTOL33hpM5SnptWizQ/QsNfh4H1It2JydA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111177; c=relaxed/simple;
	bh=jOASmNrBy0k5ebd7B11buXOeSSx1yKz2tcuTybTDs10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLRtuCJYUo9wcKk5yXUJfm72Y53o4u1J0anJii+c8dlJHQzGsrpeRyECehfNAWTmhBG3nyb8poKgPQlzn99LDAaiSlwNM88nRMYMRMNzjLxpKVbFoHGVqeaizIJX7y5VEuXdrCdeukkhLNsOv8vudf4PtpLL7KOyNfxuJmwAAQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Ma0I00Jc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a16b310f5so641619366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730111173; x=1730715973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErPoXh63XrcFWpHe9zG8v9aPuGfFzlqWX+d+j6TRc4A=;
        b=Ma0I00JcwZ90ofVYmxYwzGuUdJ8zjGZOLrVZM728a6LeUpodhyFXp/yhlcEvp1z/Z3
         q+eeksdxtxX6ciUCnUfWQK9HwpsxHvVV2QXCOTBk2BJy43jlDLl3/7kgt2qwRDM7kFiS
         XGQRg8wv1/BJsWIRrcyVGADM/mIIWkHRrFYlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730111173; x=1730715973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErPoXh63XrcFWpHe9zG8v9aPuGfFzlqWX+d+j6TRc4A=;
        b=EBlZXygsjflpMyWoLkDF4zxE/vFyGgi133s5LZU9hLJS180mQZvmAEs5DZHNcaha+6
         TBjz5RJlvOOdyaRyq3Qw2glhT+kHKh6ikYy5wHpLqMbZUM186BTo9uAtyNfuK6DUFyG+
         ETJQZLZRb1ViJjRgcyi2I7E7RZig+wxWDanYXniBZcImVp6WDlMLD1oiFOm7mr7oJ6qO
         zQcTlf+yb1VBi5aDC9eDe731FeyjKrdBzmy3ZtwbNvCJC8YXVAfcKNYnq3pDb+6/4Dvr
         EkInA419bkT8tYfda9F+AqX4pnkayy7vX2z6cj/QfX9/bcHcQ2899GsdPLeIYk9n9wT5
         lK/w==
X-Gm-Message-State: AOJu0YwPwW+fB5Wd//rNegwivly1+zmM+4r+DrlXpk7MPZsS3kh2JcPv
	a8CZaVOw0Rx8EMlcwKTnKjhojAXHBANp3+Gfk7Qs99C1tnU17aziU2kmPC3U4X8latxP9oli1JT
	cjjk=
X-Google-Smtp-Source: AGHT+IGCR28JnEaozP81Xbh2KLif47qmv9KNL7NMIxup/Qx2H3ia0ChVJ6kRCnNRLDGwqzzr1QgmvA==
X-Received: by 2002:a17:907:9712:b0:a9a:2afc:e4d7 with SMTP id a640c23a62f3a-a9de619d18bmr803160866b.44.1730111172695;
        Mon, 28 Oct 2024 03:26:12 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.41.121])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f297b04sm363613966b.134.2024.10.28.03.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:26:12 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Marek Vasut <marex@denx.de>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [RFC PATCH 02/10] pmdomain: imx8m-blk-ctrl: don't turn on a power domain already on
Date: Mon, 28 Oct 2024 11:25:25 +0100
Message-ID: <20241028102559.1451383-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028102559.1451383-1-dario.binacchi@amarulasolutions.com>
References: <20241028102559.1451383-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch, by informing pm_genpd_init() with the "is_off" parameter that
the power domain is already on, prevents the power_on() callback from being
called, thus avoiding the unnecessary repetition of the hardware power-on
procedure. This feature is crucial when supporting the simple framebuffer,
as the power domains have already been initialized by the bootloader.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 51 ++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index ca942d7929c2..8dc1508571dd 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -166,6 +166,24 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
 
 static struct lock_class_key blk_ctrl_genpd_lock_class;
 
+static bool imx8m_blk_ctrl_is_off(struct device *dev, struct generic_pm_domain *genpd)
+{
+	struct device_node *node = dev->of_node;
+	struct imx8m_blk_ctrl_domain *domain = to_imx8m_blk_ctrl_domain(genpd);
+	const struct imx8m_blk_ctrl_domain_data *data = domain->data;
+	u32 boot_on;
+	int index;
+
+	index = of_property_match_string(node, "power-domain-names",
+					 data->gpc_name);
+	if (index < 0 || of_property_read_u32_index(node,
+						    "fsl,power-domains-boot-on",
+						    index, &boot_on))
+		return true;
+
+	return !boot_on;
+}
+
 static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 {
 	const struct imx8m_blk_ctrl_data *bc_data;
@@ -173,6 +191,8 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 	struct imx8m_blk_ctrl *bc;
 	void __iomem *base;
 	int i, ret;
+	bool init_off;
+	bool *pm_runtime_cleanup;
 
 	struct regmap_config regmap_config = {
 		.reg_bits	= 32,
@@ -221,6 +241,11 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 					     "failed to attach power domain \"bus\"\n");
 	}
 
+	pm_runtime_cleanup = devm_kcalloc(dev, bc_data->num_domains,
+					  sizeof(*pm_runtime_cleanup), GFP_KERNEL);
+	if (!pm_runtime_cleanup)
+		return -ENOMEM;
+
 	for (i = 0; i < bc_data->num_domains; i++) {
 		const struct imx8m_blk_ctrl_domain_data *data = &bc_data->domains[i];
 		struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
@@ -274,7 +299,8 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 		domain->genpd.power_off = imx8m_blk_ctrl_power_off;
 		domain->bc = bc;
 
-		ret = pm_genpd_init(&domain->genpd, NULL, true);
+		init_off = imx8m_blk_ctrl_is_off(dev, &domain->genpd);
+		ret = pm_genpd_init(&domain->genpd, NULL, init_off);
 		if (ret) {
 			dev_err_probe(dev, ret,
 				      "failed to init power domain \"%s\"\n",
@@ -283,6 +309,24 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 			goto cleanup_pds;
 		}
 
+		if (!init_off) {
+			ret = pm_runtime_get_sync(bc->bus_power_dev);
+			if (ret < 0) {
+				pm_runtime_put_noidle(bc->bus_power_dev);
+				dev_err_probe(dev, ret, "failed to power up bus domain\n");
+				goto cleanup_pds;
+			}
+
+			ret = pm_runtime_get_sync(domain->power_dev);
+			if (ret < 0) {
+				pm_runtime_put(bc->bus_power_dev);
+				dev_err_probe(dev, ret, "failed to power up peripheral domain\n");
+				goto cleanup_pds;
+			}
+
+			pm_runtime_cleanup[i] = true;
+		}
+
 		/*
 		 * We use runtime PM to trigger power on/off of the upstream GPC
 		 * domain, as a strict hierarchical parent/child power domain
@@ -324,6 +368,11 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 	of_genpd_del_provider(dev->of_node);
 cleanup_pds:
 	for (i--; i >= 0; i--) {
+		if (pm_runtime_cleanup[i]) {
+			pm_runtime_put(bc->domains[i].power_dev);
+			pm_runtime_put(bc->bus_power_dev);
+		}
+
 		pm_genpd_remove(&bc->domains[i].genpd);
 		dev_pm_domain_detach(bc->domains[i].power_dev, true);
 	}
-- 
2.43.0


