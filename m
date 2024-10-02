Return-Path: <linux-kernel+bounces-347462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B80698D30C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA49A1C210CA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6AD1D04BE;
	Wed,  2 Oct 2024 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iCop0QB/"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A11D043E
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871775; cv=none; b=kL7NrCupJFjyG4TYDoV4RFVNQIT75Ie1h0J3Gd/Q0LzjkOQO/p6HgHQ3H1PI6UoYOC9/5j/SvRfo+m8b/WfvEuD06hIczrOzs+yb6mfmq4DDr68tHgaIBf24m8FQilGx/18UrceCTkd6HHXAhGO9AQlobBs7P3Zdwr6NsSDgGqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871775; c=relaxed/simple;
	bh=4oMD95LmzrY2BBiXM7ugPb7ru7xnwAUSFNySR58E1js=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KhzCLbER5TInbPoOMxbD7Dg3QLiMb3dlzC5DcBSJd2EN7dFZtlNs0nJn9TMdNjnCzLti5Sc6x0Zs8jrDuE6calnrSXWvYer/Ar8iWSRMBb1lnktxKPKQ4dzorRVBPrBjPrLmQjzmO+2vpmOwbuBz6a4+2voGykZrCWChPvJ8b3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iCop0QB/; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53993564cb1so4090628e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 05:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727871771; x=1728476571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xhrWVuNulAVPF9JAXfDIgOPkMQL+mGco7UiYnj3y1Y=;
        b=iCop0QB/dqby4qdLQDmyVe81BE6NHl8/JDGAgB42J9Vs+CXbqua7HUm2yMGUFk6kec
         BiKLBk0IfQzSsDnSQvZNRUKXYxc4l2TXIymKsoMxUTEfzwPTE48i6iz350ronZLRN8eC
         bXejTzmLM12+vyW8dIbrO99CwjXYlqU4KI1CERGA299PtJ+a8omH0ZgkmWCoPclcYf6m
         fFYPifIQcg9EeaU/yAhDbPLuJ11L8nsgcm817YZy1i1dZeW8sbf0BVjG7toNaW8XCemv
         HveXypt2tCvRDJd6YjPliH4tO2M10kzbEY/DYbM/jvnca89x7S7SNXkchc7ANe6Z3NcX
         k8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727871771; x=1728476571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xhrWVuNulAVPF9JAXfDIgOPkMQL+mGco7UiYnj3y1Y=;
        b=lNKLznwpPVf6B4gcmHbJOn1cG/Xh/pQxfpZWMlTZ8zalSiHhPkMC9bTP7WJgQiUNv3
         gG8Ea2hh/NL7wjhP3Rr4f731AJFoFtNRM6L1JqcJETgxbI0r4e4J7+9WSjhGblqtYoiL
         BUOZmDlQOxGSUqU2S4CFyVIQYvfAZ/UDhZMbZwKeRwXop1baTWwfniSuIt7FaMYDbmFy
         pPTLlW7MgTWrhQz6kir9PYeAv5Eh6I4wZY+/voWmKgIqs3/FDvCjntitafaIeyaQjlRs
         hkFBiiCQs1gqssfnq8Q+ljlS1kt+ldyZGLsaWjYQd9N4q9a1yWprFl8olP+RS+wIBm/7
         fVAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlTBjvjOrS06mLp0SEAj5z79z3oWOp7DLklld4H4ZShPvgQO0q86dxz0r/v3acgoYHgCwWtEfLK05JifU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDalgCfqPOzDfiNHr4hQ+NEzMBat9Mzhja3apWWuj3PndN1gme
	dzCL177Wy5G6ghNIE68lEN0goNExQQ4G/a5eokJ1okmZhOgUYdKbLdZSUY7Zd78=
X-Google-Smtp-Source: AGHT+IFlrdWAbde1p7e4lL7d3a2kLfPGGaZt2qMjbzrVa76L6m2xNGY6jbMEy1GlEJDkWr0SrTwnww==
X-Received: by 2002:a05:6512:b18:b0:539:91b8:edc0 with SMTP id 2adb3069b0e04-539a07a64e9mr1661121e87.50.1727871771211;
        Wed, 02 Oct 2024 05:22:51 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a043204fsm1912659e87.165.2024.10.02.05.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 05:22:49 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Vedang Nagar <quic_vnagar@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
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
	linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v4 05/11] pmdomain: core: Manage the default required OPP from a separate function
Date: Wed,  2 Oct 2024 14:22:26 +0200
Message-Id: <20241002122232.194245-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002122232.194245-1-ulf.hansson@linaro.org>
References: <20241002122232.194245-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To improve the readability of the code in __genpd_dev_pm_attach(), let's
move out the required OPP handling into a separate function.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- None.

---
 drivers/pmdomain/core.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 5ede0f7eda09..259abd338f4c 100644
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


