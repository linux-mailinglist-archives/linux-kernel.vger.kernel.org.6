Return-Path: <linux-kernel+bounces-347463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9D598D30E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA51B282F41
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AC31D07A3;
	Wed,  2 Oct 2024 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zsD4q0B/"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766471D04A3
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871776; cv=none; b=HA4Dp9hjYWK5tAxkgQiIQ6572eZnGUU78cvE8VJjJL/bcOIBTcEzKc9cNSPknvJd3CTlVnBgr/hkLEXHwfXqBvjDneaIQReO2ASPDaIQyQov7Ws9Pzh411/sdOMULm7qbDRuMZVmwq1J2j9A+M44pGKusF/1YcOpAlPbLeq0mjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871776; c=relaxed/simple;
	bh=/vKrvSejn1Gdmisdzt5mbHhhl+vKu31y2VR+4L/5Z6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LZyVAUJ7YcbPrR6/j9i03mhDHDS0AOgAIBeNdZk8MjTOMPzRyW97iM1LOAyfQaRYNA+z6VZngBG/ZKc2tigHyG/h8REEiWo9Iet/406hProheNi2qXkaz374APpLCL7GKE3JVwgO4hkI/49ee8RpZsmgW4s/6JiGEM9gYJjjIPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zsD4q0B/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5389e24a4d1so6681767e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 05:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727871772; x=1728476572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFH9tv3EyMbkQCesSF+Pisa4vxI80qkPcngq9hSO9D0=;
        b=zsD4q0B/p1FTzq1+pRwTjlioGtqHgxLxOyhn/QN9ST5ZBI++sS+JxVCJ/194fKF25r
         04FeXWBNQzY565cqOzg76sfSe4FKRjQVazq0F9n+42ZWMTPfI3XUmCLdzsGM6+OHziUp
         A8GzuxDl8S84+gxHapFhoavAi5h85prgDA2Ls19kNu5SAS/1TLnTRMew1f22TbGNoKBS
         qEpnpxsifETaWA0qLKAodJ1Myzh5n0SokqW/rZcwKxkDvzU3YrB7xSTSHsDl8WcXbZdG
         N53yYFDJStDkAjE4kdgR7XxhN84Z3M6yMwN1uIZ7jlAotmB/7LcimcNwCi2S8sVuWZy6
         YgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727871772; x=1728476572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFH9tv3EyMbkQCesSF+Pisa4vxI80qkPcngq9hSO9D0=;
        b=Z2RX0s06A9HdArhfpGulnj4tuJwR9DbIpCv1Ni5IpuE3Yw+hlrH7OIgQIcWwyQDeUe
         SoXxlgijbgFjkQyNTypv09I7WnmcCh+4iswKaSk5HYjbl0SINKBnbCyqv397b/rdiGCA
         ItR/FRW9GZlk11MSQTJg57lxdKgbsCDFVeUcRLuUirotwJnHTuK1LT1PvUzHHfG8N7M+
         A/Y/P29uhncdL5m7Wt7Ik4m1Z3/q+ThCZ14QEJqjEgqiTMNbrioE6HjqLkyS5jNIgYtt
         AxHla3MQKZllpcyRjYaCTmK44UQhddxH/i8FXrfv+zvfCewUsANQ4yJg6AnIcnnw8Tey
         IlUg==
X-Forwarded-Encrypted: i=1; AJvYcCWvMyjNIKNz6Vt3rmdvWGnCcHt3gcwPPsnT35nFb5Avl4cPsETsoi+yt8kdQln8w+0S1CdBAnGv/ff8uOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1zG8fmg93M+rHZd6gi6qSP6LXt4gkHGwYRkNxvlxzZW+V555C
	SupqnpWeZ6Y4C/ndB3JdXIEnU7rIA8gIxuMhUbYJQ7T9rPLVkXdicSB3RmmSTdS65QhoZq8++0r
	m
X-Google-Smtp-Source: AGHT+IHEjNv7ZCxNOSC2V6obj2+dWZVZVLatN/UEyPBuKnoG56fp85/7vBdsw6KDnsPAalW5KMVKog==
X-Received: by 2002:a05:6512:124d:b0:539:8f4d:a7dd with SMTP id 2adb3069b0e04-539a0795b71mr1720419e87.42.1727871772538;
        Wed, 02 Oct 2024 05:22:52 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a043204fsm1912659e87.165.2024.10.02.05.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 05:22:52 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/11] pmdomain: core: Set the required dev for a required OPP during genpd attach
Date: Wed,  2 Oct 2024 14:22:27 +0200
Message-Id: <20241002122232.194245-7-ulf.hansson@linaro.org>
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

In the single PM domain case there is no need for platform code to specify
the index of the corresponding required OPP in DT, as the index must be
zero. This allows us to assign a required dev for the required OPP from
genpd, while attaching a device to its PM domain.

In this way, we can remove some of the genpd specific code in the OPP core
for the single PM domain case. Although, this cleanup is made from a
subsequent change.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- Limit the assignment of the required_dev to the single PM domain case.
	- Use dev_pm_opp_set_config() rather than the resource managed version.

---
 drivers/pmdomain/core.c   | 42 ++++++++++++++++++++++++++++++++++++---
 include/linux/pm_domain.h |  1 +
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 259abd338f4c..76490f0bf1e2 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1722,6 +1722,7 @@ static void genpd_free_dev_data(struct device *dev,
 
 	spin_unlock_irq(&dev->power.lock);
 
+	dev_pm_opp_clear_config(gpd_data->opp_token);
 	kfree(gpd_data->td);
 	kfree(gpd_data);
 	dev_pm_put_subsys_data(dev);
@@ -2884,6 +2885,29 @@ static void genpd_dev_pm_sync(struct device *dev)
 	genpd_queue_power_off_work(pd);
 }
 
+static int genpd_set_required_opp_dev(struct device *dev,
+				      struct device *base_dev)
+{
+	struct dev_pm_opp_config config = {
+		.required_dev = dev,
+	};
+	int ret;
+
+	/* Limit support to non-providers for now. */
+	if (of_property_present(base_dev->of_node, "#power-domain-cells"))
+		return 0;
+
+	if (!dev_pm_opp_of_has_required_opp(base_dev))
+		return 0;
+
+	ret = dev_pm_opp_set_config(base_dev, &config);
+	if (ret < 0)
+		return ret;
+
+	dev_gpd_data(dev)->opp_token = ret;
+	return 0;
+}
+
 static int genpd_set_required_opp(struct device *dev, unsigned int index)
 {
 	int ret, pstate;
@@ -2908,7 +2932,8 @@ static int genpd_set_required_opp(struct device *dev, unsigned int index)
 }
 
 static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
-				 unsigned int index, bool power_on)
+				 unsigned int index, unsigned int num_domains,
+				 bool power_on)
 {
 	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
@@ -2940,6 +2965,17 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	dev->pm_domain->detach = genpd_dev_pm_detach;
 	dev->pm_domain->sync = genpd_dev_pm_sync;
 
+	/*
+	 * For a single PM domain the index of the required OPP must be zero, so
+	 * let's try to assign a required dev in that case. In the multiple PM
+	 * domains case, we need platform code to specify the index.
+	 */
+	if (num_domains == 1) {
+		ret = genpd_set_required_opp_dev(dev, base_dev);
+		if (ret)
+			goto err;
+	}
+
 	ret = genpd_set_required_opp(dev, index);
 	if (ret)
 		goto err;
@@ -2994,7 +3030,7 @@ int genpd_dev_pm_attach(struct device *dev)
 				       "#power-domain-cells") != 1)
 		return 0;
 
-	return __genpd_dev_pm_attach(dev, dev, 0, true);
+	return __genpd_dev_pm_attach(dev, dev, 0, 1, true);
 }
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 
@@ -3047,7 +3083,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	}
 
 	/* Try to attach the device to the PM domain at the specified index. */
-	ret = __genpd_dev_pm_attach(virt_dev, dev, index, false);
+	ret = __genpd_dev_pm_attach(virt_dev, dev, index, num_domains, false);
 	if (ret < 1) {
 		device_unregister(virt_dev);
 		return ret ? ERR_PTR(ret) : NULL;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 92f9d56f623d..76775ab38898 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -252,6 +252,7 @@ struct generic_pm_domain_data {
 	unsigned int performance_state;
 	unsigned int default_pstate;
 	unsigned int rpm_pstate;
+	unsigned int opp_token;
 	bool hw_mode;
 	void *data;
 };
-- 
2.34.1


