Return-Path: <linux-kernel+bounces-221174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8992490EFC6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3833B2834FF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5371509A0;
	Wed, 19 Jun 2024 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cDMuDzVA"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F18A153582
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806159; cv=none; b=YpMPlNHyUw1XbhoyjH6jfiAthLG+lU13WQkUwI3Csft9N0tIiBa2u0meJVfv8Y3yU4q+2b7mQUsLHsro7w9QzLnAxzbHMfWsiKkBfiTyoU/xrTSbXUEMRVmKHsgsOQC8ZdibwJCf6P7BcI/9sBAhjUH2ed+QtyD9TeZNTbJfy5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806159; c=relaxed/simple;
	bh=BCICaCFGMmLOmUyHekQXCYwkgEJHZLXP9WCwg2mTagk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F28lb6520Orn1kvAFN/tY3XvZu9JNwfIJnH583X/Xk6NvZkvCkwG2+kMDZ11reOkvL3sTT4u881oYF1U5c3hBE9Tv4TiQuu9IkLez4qhe7iXuXzr8WvjyZQJv7YzrSheA/SzSZTp1CNzogAwuCV2FEhK2Mx4aEEkaCHT+J9uJ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cDMuDzVA; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5295e488248so7162568e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718806155; x=1719410955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htFpAgDo306pFLyFNLJIsFnxeXuNDgJdkPPYgP2iQ3A=;
        b=cDMuDzVAxB+RkzVufgRrgeI2dN1yf80nzlXdJ8BvBTplY9O2Kkl6UF9iHJcc312xEZ
         poLY6VOqX0xoyAY9s4xEDNVkvW9zd24fOFvOI9lUPwML6daw5exQ0KdYDqdQNhDPzmXn
         CbNwCqTXf+DW4AnUoWECdnfMr2RWgfVQ1cNH3g24Tv5x7/ajuu57yJHDY0lXilC8xy1G
         U9GlBK/16ZTlRhiYA+oTOBt9kQXiC2PXejwNqt/10pqmpF0hK0smeZoXu7V9PFtT6Xwl
         /m+sHbW+LLk6JfV+27cadEMkw0KPl5pvA1dl0HQ95MJvyMsxUANTyYTJoxs0UlrIFndP
         qlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806155; x=1719410955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htFpAgDo306pFLyFNLJIsFnxeXuNDgJdkPPYgP2iQ3A=;
        b=h1PHSqPYDb7IR+lEwQg+S3RMyHueTvwg6jLCYaMbktpmucRtmbOXkqJZXL/S2BYJQy
         giurkH85CB59e5Rrx0QsuX59XhdJ0shUgIjGbOimHHpXBrs1SG2PJJlgYdecq0AI1Hmq
         SWC788seANRAQZSzLFGQZDfYyAZbmigIeOurZeFMNt6oo71beAFk4pTkwR7OoAXdAPS9
         gawS4PFuAjL6U2N3eUkPy42cOmYVFXuwo5SBmZW12cZXbrWOCMN+HLswgHoNzwVghRz/
         RXObig+92TgalIabz9W+6wu4P3y4Gh9WA7+lSS+/QIPpkJ6mtA+GakPP7eA+kboj/Nmb
         abAg==
X-Forwarded-Encrypted: i=1; AJvYcCUZotNu91YWdj5CrkH3dLrtnY4XUfe60gIHCAKTvCpGx9f+IZFfTmS5ioWmXSUcRYO4a4Kc2G8eDuRgqwLdigF/cmnf2cx+bpZz7r7/
X-Gm-Message-State: AOJu0YxHf0U7t7RZpyaTzgbm8Lz09nQi853or+VBo0JuJmM9uc7YRATy
	JFKDjD0rtY1PkesvK5CJ49cGGm9j0NTzH6B6hbUCMKcSvpX5TnQ0sbQSTCOW/OY=
X-Google-Smtp-Source: AGHT+IHfAlr5DrpIAaWiiNsj4x6QaAAeJHHW2gKvh16J7kuwaVsds0u8zDkuPraMr/WEHw60Qa+NSw==
X-Received: by 2002:ac2:44b6:0:b0:52c:893c:6c2c with SMTP id 2adb3069b0e04-52ccaa3756amr1415929e87.40.1718806153456;
        Wed, 19 Jun 2024 07:09:13 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2872241sm1787003e87.124.2024.06.19.07.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:09:13 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] pmdomain: core: Manage the default required OPP from a separate function
Date: Wed, 19 Jun 2024 16:08:47 +0200
Message-Id: <20240619140849.368580-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619140849.368580-1-ulf.hansson@linaro.org>
References: <20240619140849.368580-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To improve the readability of the code in __genpd_dev_pm_attach(), let's
move out the required OPP handling into a separate function.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 83d978743659..74ebb8a423be 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2774,12 +2774,34 @@ static void genpd_dev_pm_sync(struct device *dev)
 	genpd_queue_power_off_work(pd);
 }
 
+static int genpd_set_required_opp(struct device *dev, unsigned int index)
+{
+	int ret, pstate;
+
+	/* Set the default performance state */
+	pstate = of_get_required_opp_performance_state(dev->of_node, index);
+	if (pstate < 0 && pstate != -ENODEV && pstate != -EOPNOTSUPP) {
+		ret = pstate;
+		goto err;
+	} else if (pstate > 0) {
+		ret = dev_pm_genpd_set_performance_state(dev, pstate);
+		if (ret)
+			goto err;
+		dev_gpd_data(dev)->default_pstate = pstate;
+	}
+
+	return 0;
+err:
+	dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
+		dev_to_genpd(dev)->name, ret);
+	return ret;
+}
+
 static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 				 unsigned int index, bool power_on)
 {
 	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
-	int pstate;
 	int ret;
 
 	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
@@ -2808,17 +2830,9 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	dev->pm_domain->detach = genpd_dev_pm_detach;
 	dev->pm_domain->sync = genpd_dev_pm_sync;
 
-	/* Set the default performance state */
-	pstate = of_get_required_opp_performance_state(dev->of_node, index);
-	if (pstate < 0 && pstate != -ENODEV && pstate != -EOPNOTSUPP) {
-		ret = pstate;
+	ret = genpd_set_required_opp(dev, index);
+	if (ret)
 		goto err;
-	} else if (pstate > 0) {
-		ret = dev_pm_genpd_set_performance_state(dev, pstate);
-		if (ret)
-			goto err;
-		dev_gpd_data(dev)->default_pstate = pstate;
-	}
 
 	if (power_on) {
 		genpd_lock(pd);
@@ -2840,8 +2854,6 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	return 1;
 
 err:
-	dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
-		pd->name, ret);
 	genpd_remove_device(pd, dev);
 	return ret;
 }
-- 
2.34.1


