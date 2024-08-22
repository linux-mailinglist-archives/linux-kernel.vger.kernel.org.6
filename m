Return-Path: <linux-kernel+bounces-298043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C4595C10B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 00:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A3B284B58
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CDB1D2F59;
	Thu, 22 Aug 2024 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMIte4RG"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00C71D278D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366772; cv=none; b=JVBnmxLX5Z/AhNnfrJUPzkwuMEUl3UwPCHncag4H0NgR2NkfXlmrjYIgmU+akTsEF14kdaFjmJjwCoXfIPTjnh7xQU+AbDMG5EdR6fbaZypb1BPAk2rhDUNXm1s4xtZ7HDDGk8bZ2H2ELqMoT64ZOgBsRfY/eQ/+bj0zW2Y1wok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366772; c=relaxed/simple;
	bh=hYhQGKE1LwPkoZhf3M1NbzKrzI4lCg6eCswGukUEMHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qyBqrQM34c7jeiI1UjPGncTwyhN+PBBI6c2NSOAaTrs6kzlK/IpPzoj1UJYtCjLG90uz3EOoIG7a+yRw6K2xnJK8BB7zs/vwyHJVugjamICI/hVtX/mqfzjF6/t5WwdR81b7WAehRZkLgbAQQGD2Jee1wnroBoHrH3vA9Lt02gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aMIte4RG; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-533488ffaf7so1786030e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 15:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724366769; x=1724971569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24E2ZJlxZRFr5xBB3D3mkMAuhlD0R/qQC+7zUcBQFEc=;
        b=aMIte4RGqNOSHiRa/8OigcuE37kk5vNc099jNq0JTO2c0rxJRkKT+cgiNZwBk06yYq
         zTIZucuYrTjH3A1fYZNQoj4FYupk7JbX0PbV+T8Vf2iy3xciC2MaTKX9DyZEp7YAigd9
         OwsXsSeA1nfPYnjLx/ZuSX7S9+U6dcobdu0/tm7pck0u10wuhzC+nbTxtHm08iFVmDJc
         f7Inp86vravRPkO/NMFWTBqKZwVcjcJDYl0b92/ukpwZ/FaKMO0SaUK7KLQgYHp4sGZd
         ei8mhcqGVWuYWVAS8f49ktBUDpxBoaGO7qxnUF4PYZ+qzX76heCzMom/L0o66gfi85vh
         vY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724366769; x=1724971569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24E2ZJlxZRFr5xBB3D3mkMAuhlD0R/qQC+7zUcBQFEc=;
        b=oJSS6uhyF9wC3maaSq61/TRuUNrEY5MgIZgHydgO+5OhT3OX2eDkH3RTMKWedmTQvs
         Hu2n1ge5xWByNuQelPeAE9Ps81jtPtQsneejgqDJNCGlF181kYWG50dCwaSiv2nwVg8y
         EamMAYXEpZQmmhxYR+THDqF9mT/8nib2fHTgfEZI+YxbWIhllgOs47phpU3oWGtcIGZ9
         9QeVZ9L2LBHuCHsRsoYsYX9dGmzaXNKFODnIq0/ZctzPvLBc31M5RF1zJkDiDFTapc5n
         AP+mohnb2GZSpaBDsxlTfhvtlWBrbkRyUdgg9d/Uq5rJW3sBhmg1bUIwcrFjkqE3tg35
         l3dg==
X-Forwarded-Encrypted: i=1; AJvYcCUQJQEHiN3ypOwA+PK3NAKOIplaG6QQXZVUiAydh/DVtWJMHpVcHgm9g1Inbk+qoESNNrR5OxAnDXtgTIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhZvdfv8htKHWQdIK0oYGKQtiCZUE7MA//TykZOH5uJlGgXxSC
	f2KUgKAQaxuZygs7eQ72GvLz/IdGfpNhZFDdTzx3xr9jiAfc+mgF2zXSJNbtUkk=
X-Google-Smtp-Source: AGHT+IELTL8/y0e0fGbr2lzzbBRJ4DDHIa+OZXd4j/RR2q0PvMAUXPDsy1xGSGg5oKqO9JdJ+zyCrg==
X-Received: by 2002:a05:6512:23a9:b0:52c:d27b:ddcb with SMTP id 2adb3069b0e04-534387554cemr259563e87.3.1724366768686;
        Thu, 22 Aug 2024 15:46:08 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea362a4sm379443e87.66.2024.08.22.15.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 15:46:08 -0700 (PDT)
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
Subject: [PATCH v3 03/10] pmdomain: core: Manage the default required OPP from a separate function
Date: Fri, 23 Aug 2024 00:45:40 +0200
Message-Id: <20240822224547.385095-4-ulf.hansson@linaro.org>
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

To improve the readability of the code in __genpd_dev_pm_attach(), let's
move out the required OPP handling into a separate function.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- None.
Changes in v2:
	- None.
---
 drivers/pmdomain/core.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 2731b285e017..08c2192c02b4 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2884,12 +2884,34 @@ static void genpd_dev_pm_sync(struct device *dev)
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
@@ -2918,17 +2940,9 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
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
@@ -2950,8 +2964,6 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	return 1;
 
 err:
-	dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
-		pd->name, ret);
 	genpd_remove_device(pd, dev);
 	return ret;
 }
-- 
2.34.1


