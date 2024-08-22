Return-Path: <linux-kernel+bounces-298047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D38EB95C114
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 00:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8116E284873
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C121D364F;
	Thu, 22 Aug 2024 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7BV5jQ+"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162421D31A3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366778; cv=none; b=aHS8J8jg8C6SMWQkRntG6fZMmXLxpxVbOFwHv/APBDag2B9rQ+o3ViMQui6usOkhylbGZkJAYzNSwGH5eLtvfmOsNb+eWUoKILBCAs+lvKYrScV2i3VFQ/P6V3UFpyWCcW5cxOL2Txb5XpKz//bJCsf/ZOnzCnX1IOcB4a8fDCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366778; c=relaxed/simple;
	bh=aTdXvkE8ROQKXFHFBAQ24D4NEQho2z3rdw1RpRjU0c0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kbnZSi2sn5nneW6eDAsVLFyGj17bZvUxfJ4O0XoDXoUV1p8wYO7FGuHpq4lwRI/bRBJh4hYvMnwhU/tz53nxPz7ctz/AhcvHu3BJ+mGYUG+qrCDGSCkexuO1H9axQAUm6rNU5nh0OewYMiVaaLhF+1Xvd+6s9dDfQuV5+A3ux+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o7BV5jQ+; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f3f163e379so22750741fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 15:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724366774; x=1724971574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SUsoi4RcXT0izJStB+EvDnWgGn5xCm1gI9JONZb3y0=;
        b=o7BV5jQ+N0P62oXue/wvqFkHWl2zRVz5w06+d3+UNS/O6K/oFROhrWnanEvc8M97Ya
         FIbEay6117dGgDHn47H+yJScq3Lq153bbpXr6qrxb+RgS/U8zoi60hjGvFv7o2wzQYOS
         yJw0AeenZO9bMG4YAXjbjzH1TBoicW4i/iHnAn3kJrHxjQiECy0liUxIjP7c0+tDUaF2
         rTAkEcGB+jCp+Jg5IpQ4BqmrCpGLcWP6MSOqICI7mYzHE8cNPlloWK0qKVfSVMrVdkFV
         ZQTLXmoKge4Br18jaOVaGGMZ9xmHgUk+FC46T+eSDdUjf25+Y7RNdLgGhD36KnDAfhuk
         r76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724366774; x=1724971574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SUsoi4RcXT0izJStB+EvDnWgGn5xCm1gI9JONZb3y0=;
        b=CzMD85S/JZnWb7q1NiKKuDBthlsBkawOwhFdAhh8riRO+qehhWfsR9NJ60hc+Xp08/
         qSFKgEtQDA3n/wHmayJysMFkeuUooPuIl+gC0mBpM7hegAJj/9oYnVQf9BCs/LZvRPF6
         U9FhZRcxxV66f/ilVaGvUfDITOYczkIIZ8hrPLs0XXspExC03YHIZq33JeW7d9J7fRfd
         dj3oAfYBmUv61okW6w4JTD0Su6Apag9+A51RLcHxOtGH3T7DoZz5RyGCsr3oVqeXk7nZ
         i7zyk+2aWZvLoJdoQlhUNgAEejjM8P7DZ6BEXrIFRxXDUa57H42coZpEp2q58fnrNdeg
         8yrw==
X-Forwarded-Encrypted: i=1; AJvYcCXep1kOcYv4dAc9Vqxj1a674Qm/WHoyU2fZYPJe6UPTircJvkGUJkW2sVPImJN4jn3IY4l45LQRlh82mq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAiTcyLt2foe2Whf6Ilv9i7VoCRWPHjyGRaaQftxF4DzJV1XLv
	GnU9acyxQVQRNFfxW5sD3sUHGiYnkPAmTnu7horTFxlXXStiNRFeXTKXeLwCoLA=
X-Google-Smtp-Source: AGHT+IFCCObzEZAVeGe1xfyTqYfuTrbw8eyiD2QimVszxWbvB5nuySwzUySXFi47i38a78U9YOXQGg==
X-Received: by 2002:a05:6512:3e19:b0:532:fb9e:a175 with SMTP id 2adb3069b0e04-5343883d5e7mr474551e87.6.1724366774161;
        Thu, 22 Aug 2024 15:46:14 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea362a4sm379443e87.66.2024.08.22.15.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 15:46:13 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ilia Lin <ilia.lin@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/10] drm/tegra: gr3d: Convert into devm_pm_domain_attach_list()
Date: Fri, 23 Aug 2024 00:45:44 +0200
Message-Id: <20240822224547.385095-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822224547.385095-1-ulf.hansson@linaro.org>
References: <20240822224547.385095-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than hooking up the PM domains through devm_pm_opp_attach_genpd()
and manage the device-link, let's avoid the boilerplate-code by converting
into devm_pm_domain_attach_list().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Updated commitmsg.
	- Converted to devm mangaged version of dev_pm_domain_attach_list()

---
 drivers/gpu/drm/tegra/gr3d.c | 38 +++++++-----------------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 00c8564520e7..d52433cf939a 100644
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
+	err = devm_pm_domain_attach_list(dev, &pd_data, &gr3d->pd_list);
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
 
-- 
2.34.1


