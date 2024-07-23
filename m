Return-Path: <linux-kernel+bounces-260108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A74193A324
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC301F22904
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D17156F55;
	Tue, 23 Jul 2024 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v16j/tJY"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A7615697A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745999; cv=none; b=cIItwnfIVLCF4wNRLYRgjsiJAp2qmadDPXL3Hr/yiizNk0/Zff2P88NPPPbOn8zHP+UuT410jswy1CcBS72/hLbITp0ePzCEdyaihuCE7kLB/L39dmKiPyDNzjsAYjc/VNCHLwwz3+mtqNXGfjcLRD3Rxm45vTQSciolVVgXkxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745999; c=relaxed/simple;
	bh=G1bdc1Bbc1w5rYBE7Tc2f+lHBc5gkXwukaXyrq0t8+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B0BBCALCCYzNOEjkwu8gNJnufYXtsT9uXpqj7DEW7tJuf1zVMGJ7cLaEl+tRslhiImLBNyEwsIv5XHVuymQqWDdxaZRloZN+CpAf3ztSlGSShmkElz1JLFs+tQmtcfbWuBv99JmVYxYhPXiK+q29S2DbCQP7cSXPHMyEHoPemsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v16j/tJY; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f04c1e58eso2954230e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721745994; x=1722350794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMvMejcYTJIM4KIVqv1c9N6HVUpji/79NTaho6YiZqU=;
        b=v16j/tJYy846EjQGBTisf6koyNavGBk0U9LTqoxVFznPcGNliMDzFfVA2pNvP7xxHJ
         7ruRYZRnqhueSuzXNCEw0fPMcm96WdCeslCb8MQT6mztmT0gqoqie5UtGqDC1/yG/KPK
         qsigbKXMleH2k7gUKeut/JATSW7Rq3USugbcWBbvwuEmLHqhVYwTGzLMfOS/Ckpq/hdL
         iem5Cz5HqLJgT2N5b4UEXu732uxhfXi7acK+0IHMPTx+Fub0u6XIeYvHQgYEpniwfNMu
         fGxkpMbSYhUtbyg7nMt8wdgXxndYYZ5Ik3ZJhTIxBa5JXXkA2VOvwz7T3rfd1vD0ao/B
         2MbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745994; x=1722350794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMvMejcYTJIM4KIVqv1c9N6HVUpji/79NTaho6YiZqU=;
        b=ZQDNSGJJN+n88doCA75FzIkv0kaU+GlEDVR/Fu1VbpTvn1L+fZpKTyCX3MWEyt0Ee/
         AK/xQ84gSJwBwVIqbLILNDtxMbIfsXWJeMhmPcXLfj9HPWneijW8vlmkMvHiRHM3fm/r
         Z4WQTi66pc8DdHV9JpdkyDXy+s28YP1qUVGnHRhJqqGry6lllfZc+Qb6TtJzmQdRcagf
         j8w+MQ2S+DtAb8XDS/lE8LAQuf4Ur43y3qiHFgVHsJM7b+HATsFwC35R61Ss+Sc/Uwc0
         cZ1Z/f/Gg9ri2qfBg4lMVCS5jJcXTt2UyOxmM4t5DA7RjjeTuM0Dn7yCGx7uulb3q07y
         jutQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0BmAJyQ0XURPh/dPaDHWy69cEVEMlpTi1TPam2dmALpxd/7V5DroMUgAwUBWFlOEFr3YDiu70moaxcfmfohfPeMFMw4cvqoS6HfPO
X-Gm-Message-State: AOJu0YzsuqSHyA0e7SGzjiFBURgiggz7Jo0GSbI2lxsSMs9ZtLyjgIXJ
	H+Bjvk71NtDOq1UnWWZkIcVpsb5KiPp8e4eK+0ECG9uFSyUw2XlyxLw1OcO0nyk=
X-Google-Smtp-Source: AGHT+IEZ1h6MbPLjULEjFJKo9gP06D2/tDoy9HevGDIpR9mHTnvQPTceARptLwA/k582cDSpVdzfpQ==
X-Received: by 2002:a05:6512:4008:b0:52e:fada:f002 with SMTP id 2adb3069b0e04-52efb5223cemr8834295e87.10.1721745994036;
        Tue, 23 Jul 2024 07:46:34 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52f0415eb08sm774540e87.9.2024.07.23.07.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:46:33 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH 1/4] drm/tegra: gr3d: Convert into dev_pm_domain_attach|detach_list()
Date: Tue, 23 Jul 2024 16:46:07 +0200
Message-Id: <20240723144610.564273-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723144610.564273-1-ulf.hansson@linaro.org>
References: <20240723144610.564273-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than hooking up the PM domains through devm_pm_opp_attach_genpd()
and manage the device-link, let's avoid the boilerplate-code by converting
into dev_pm_domain_attach|detach_list.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/gpu/drm/tegra/gr3d.c | 46 ++++++++++--------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 00c8564520e7..4de1ea0fc7c0 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -46,6 +46,7 @@ struct gr3d {
 	unsigned int nclocks;
 	struct reset_control_bulk_data resets[RST_GR3D_MAX];
 	unsigned int nresets;
+	struct dev_pm_domain_list *pd_list;
 
 	DECLARE_BITMAP(addr_regs, GR3D_NUM_REGS);
 };
@@ -369,18 +370,12 @@ static int gr3d_power_up_legacy_domain(struct device *dev, const char *name,
 	return 0;
 }
 
-static void gr3d_del_link(void *link)
-{
-	device_link_del(link);
-}
-
 static int gr3d_init_power(struct device *dev, struct gr3d *gr3d)
 {
-	static const char * const opp_genpd_names[] = { "3d0", "3d1", NULL };
-	const u32 link_flags = DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME;
-	struct device **opp_virt_devs, *pd_dev;
-	struct device_link *link;
-	unsigned int i;
+	struct dev_pm_domain_attach_data pd_data = {
+		.pd_names = (const char *[]) { "3d0", "3d1" },
+		.num_pd_names = 2,
+	};
 	int err;
 
 	err = of_count_phandle_with_args(dev->of_node, "power-domains",
@@ -414,29 +409,10 @@ static int gr3d_init_power(struct device *dev, struct gr3d *gr3d)
 	if (dev->pm_domain)
 		return 0;
 
-	err = devm_pm_opp_attach_genpd(dev, opp_genpd_names, &opp_virt_devs);
-	if (err)
+	err = dev_pm_domain_attach_list(dev, &pd_data, &gr3d->pd_list);
+	if (err < 0)
 		return err;
 
-	for (i = 0; opp_genpd_names[i]; i++) {
-		pd_dev = opp_virt_devs[i];
-		if (!pd_dev) {
-			dev_err(dev, "failed to get %s power domain\n",
-				opp_genpd_names[i]);
-			return -EINVAL;
-		}
-
-		link = device_link_add(dev, pd_dev, link_flags);
-		if (!link) {
-			dev_err(dev, "failed to link to %s\n", dev_name(pd_dev));
-			return -EINVAL;
-		}
-
-		err = devm_add_action_or_reset(dev, gr3d_del_link, link);
-		if (err)
-			return err;
-	}
-
 	return 0;
 }
 
@@ -527,13 +503,13 @@ static int gr3d_probe(struct platform_device *pdev)
 
 	err = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
 	if (err)
-		return err;
+		goto err;
 
 	err = host1x_client_register(&gr3d->client.base);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to register host1x client: %d\n",
 			err);
-		return err;
+		goto err;
 	}
 
 	/* initialize address register map */
@@ -541,6 +517,9 @@ static int gr3d_probe(struct platform_device *pdev)
 		set_bit(gr3d_addr_regs[i], gr3d->addr_regs);
 
 	return 0;
+err:
+	dev_pm_domain_detach_list(gr3d->pd_list);
+	return err;
 }
 
 static void gr3d_remove(struct platform_device *pdev)
@@ -549,6 +528,7 @@ static void gr3d_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	host1x_client_unregister(&gr3d->client.base);
+	dev_pm_domain_detach_list(gr3d->pd_list);
 }
 
 static int __maybe_unused gr3d_runtime_suspend(struct device *dev)
-- 
2.34.1


