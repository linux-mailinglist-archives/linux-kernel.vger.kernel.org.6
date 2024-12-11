Return-Path: <linux-kernel+bounces-440552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2DB9EC0B8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A0C282EEA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D81C13B;
	Wed, 11 Dec 2024 00:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMjaLFdQ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F4F2AE90
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733876876; cv=none; b=Dpw4N2k/BKIYNmfUjuPoSFpxYrBQOCjgNPsdvlJlfggqlx8vsmGUdrCIMRqzgad2f/S0RRP0SsmHO0RSROs5jlSmu2gxD1RBhi5rLbYz66VEX1xY+4aHBApojrFoGmDMpvS9+dbLr0lV92P/pIFlCS9c275ipoMeYiBLKj2zGZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733876876; c=relaxed/simple;
	bh=GGEzBDxdw4Cs7Z+YXljmiFHrL/P3tbwHZRh0FXuGLwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e4D3go1oc/8RrGHfdTtpbWtSakmHX005T0a87hfo1d4Yq46xJauNhYNNQK4i0uCgiiH8nhrWZL0aOp2MaBb/pK1aOkVH1Cdjv6+mGqCFvvenp6uEsM1zNUTtjJIKWlfzo0G79qx60HwXws5uSxCJgldQEXo2ZyyvdC3nYq/v+0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IMjaLFdQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso6097815a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733876872; x=1734481672; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ean54aJ576hyNjG6ecCmH7/T6VuvQKNmJScSRkfwNqc=;
        b=IMjaLFdQI/9K8DbIB9AvemmRASfX2iXNnDeImhA/2v/aTSiUeHBJekuYO7Vb1FlSLU
         ixhb9RjTGD0V6Jadj7mEJbDB2D7m+dTZUvReXSohPpIJk/skoYMpfZlrso4Q4JPaObVU
         HGVMTJhYY0hUs6zwpuqYlq4vvlA6P1BAmDkKJDqQObG+QmI7RPNBxVJlM50lE6zI+Ut7
         9hB0FdfWBPdppwnY81ISvzdiBHVDkeu20zxscS9ASo2EQbzVHAIslHqTW4fBKs7j9dyU
         PnkgGHFOQKIyG+hukReLjAG/NN9breP50wV8H2VoVMrnxCUvOBQSe53bsDWfArPw6oG8
         MsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733876872; x=1734481672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ean54aJ576hyNjG6ecCmH7/T6VuvQKNmJScSRkfwNqc=;
        b=CVD24khgdHUvNDETVurD9JUGJRfSFF7cWjklC7Mc3QaM2Abu5AhRHY03p9Bje2tB0c
         yiP9Gp94CJcuBWP+pbdXyoRGrHsp1orCd+BEwgHC5L4ESOkXAxOO1p2Xxq1Lu8ErzFlj
         iaBG8aIyInrj7frX7Ob3Was0uz16JD4Nkx4zQx/VF1+1I+avIbZA5fXGJXzFn4rzes6T
         79ojyili4aZbxtRoo5Nbef2r1sDA3FMZ4FLZ7vDJFu38eZbrDIZLQiB3iHQkjV9akXIZ
         Y4MML92ae7+qRTvG5vjEVHlANtYYyXnjI3Fp4rct1OI5Cu6tve2EwYwG0RUl+AiE1m5h
         oxHA==
X-Forwarded-Encrypted: i=1; AJvYcCWFdnY0qMQN4mumwnBwwNxA6VqtRiLrG5oru+smMJ9ndUwWkvJWDmsHj7N3CpkIqu5FDX0shGRKAWW/MlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB4DTEWnSYdNJDyppP+TBXQduG5nxgrqqH2lyZYzQu+ZQm/tHZ
	/bjwV0PphpHt1mGciMKQKmemrl1XyRAyOtRyI6Yxjbuzn7BdTKOmhRwf8dNAcQM=
X-Gm-Gg: ASbGncvOWn6TEuv8Xeavs/yai+DB75vwzQ3zGDP61cYGpHD+6nsXkTYYtVxOMFfcIx1
	grpiKFyjm//0EQGicBB7GLKF8wm3TCNNDla3/WHN73SYCWsVEda7OmKnRZgEjA6ZUmFKjWg+iek
	A5YnpWej/M1wOkcJhJ7Rr8Es7yP1q3HvKI51uJxXJylZOqhSp/qBMe40Uvxab+wUxJoOJCEHajT
	Gj/rQvjl1NCKnW84SY3OGA+hopkBlfzCpFZUpm1GM6lFqPxKNFvHIRkMD8EdKU=
X-Google-Smtp-Source: AGHT+IEWJjacs6/Vi8Wgp+T+P6zRpctQgRZuLwDJVyqVesrXMeuGcknxu/XX+Ba2+fCdKTyDSHXisA==
X-Received: by 2002:a05:6402:360b:b0:5d0:c684:bae5 with SMTP id 4fb4d7f45d1cf-5d4330a4d9dmr810204a12.13.1733876872247;
        Tue, 10 Dec 2024 16:27:52 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c7aa97asm8155530a12.73.2024.12.10.16.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 16:27:51 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Wed, 11 Dec 2024 00:27:43 +0000
Subject: [PATCH v7 3/3] clk: qcom: Support attaching GDSCs to multiple
 parents
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v7-3-7e302fd09488@linaro.org>
References: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v7-0-7e302fd09488@linaro.org>
In-Reply-To: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v7-0-7e302fd09488@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-355e8

When a clock-controller has multiple power-domains we need to attach the
GDSCs provided by the clock-controller to each of the list of power-domains
powering to the controller.

GDSCs come in three forms:

1. A GDSC which has no parent GDSC in the controller and no child GDSCs.
2. A GDSC which has no parent GDSC in the controller and has child GDSCs.
3. A child GDSC which derives power from the parent GDSC @ #2.

Cases 1 and 2 are "top-level" GDSCs which depend on the power-domains - the
power-rails attached to the clock-controller to power-on.

When power-domains points to a single power-domain, Linux' platform probe
code takes care of hooking up the GDSC to the clock-controller.

When power-domains points to more than one power-domain we must take
responsibility to attach the list of power-domains to our clock-controller.

An added complexity is that currently gdsc_enable() and gdsc_disable() do
not register the top-level GDSCs as power subdomains of the controllers
power-domains.

This patch makes the subdomain association between whatever list of
top-level GDSCs a clock-controller provides and the power-domain list of
that clock-controller.

What we don't do here is take responsibility to adjust the voltages on
those power-rails when ramping clock frequencies - PLL rates - inside of
the clock-controller.

That voltage adjustment should be performed by operating-point/performance
setpoint code in the driver requesting the new frequency.

There are some questions that it is worth discussing in the commit log:

1. Should there be a hierarchy of power-domains in the clock-controller ?

   In other words if a list of power-domains = <pd_a, pd_b, ..> should
   a specific hierarchy be applied to power pd_a then pd_b etc.

   It may be appropriate to introduce such a hierarchy however reasoning
   this point out some more, any hierarchy of power-domain dependencies
   should probably be handled in dtsi with a chain of power-domains.
   One power-domain provider would point to another via power-domains = <>
   in the dtsi.

   For the case of GDSC on/off there is no clear use-case to implement
   a mechanism for a dependency list in the GDSC logic in-lieu of already
   existing methods to do dependencies in power-domains = <>;

   A defacto ordering happens because the first power-domain pd_a will be
   powered before pd_b because the list of domains is iterated through.

   This defacto hierarchical structure would not be reliable and should
   not be relied upon.

   If you need to have a hierarchy of power-domains then structuring the
   dependencies in the dtsi to

   Do this:

   pd_a {
	compat = "qcom, power-domain-a";
        power-domains = <&pd_c>;
   };

   pd_b {
        compat = "qcom, power-domain-b";

   };

   pd_c {
        compat = "qcom, power-domain-c";
   };

   clock-controller {
       compat ="qcom, some-clock-controller";
       power-domains = <&pd_a, &pd_b>;
   }

   Not this:

   pd_a {
	compat = "qcom, power-domain-a";
   };

   pd_b {
        compat = "qcom, power-domain-b";

   };

   pd_c {
        compat = "qcom, power-domain-c";
   };

   clock-controller {
       compat ="qcom, some-clock-controller";
       power-domains = <&pd_c, &pd_a, &pd_b>;
   }

   Thus ensuring that pd_a directly references its dependency to pd_c
   without assuming the order of references in clock-controller imparts
   or implements a deliberate and specific dependency hierarchy.

2. Should each GDSC inside a clock-controller be attached to each
   power-domain listed in power-domains = <>; ?

   In other words should child GDSCs attach to the power-domain list.

   The answer to this is no. GDSCs which are children of a GDSC within a
   clock-controller need only attach to the parent GDSC.

   With a single power-domain or a list of power-domains either way only
   the parent/top-level GDSC needs to be a subdomain of the input
   power-domains = <>;

3. Should top-level GDSCs inside the clock-controller attach to each
   power-domain in the clock-controller.

   Yes a GDSC that has no parent GDSC inside of the clock-controller has an
   inferred dependency on the power-domains powering the clock-controller.

4. Performance states
   Right now the best information we have is that performance states should
   be applied to a power-domain list equally.

   Future implementations may have more detail to differentiate the option
   to vote for different voltages on different power-domains when setting
   clock frequencies.

   Either way setting the performance state of the power-domains for the
   clock-controller should be represented by operating-point code in the
   hardware driver which depends on the clocks not in the
   gdsc_enable()/gdsc_disable() path.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/clk/qcom/common.c |  1 +
 drivers/clk/qcom/gdsc.c   | 35 +++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h   |  1 +
 3 files changed, 37 insertions(+)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index e6a024e95ab5f4b0776ffc6c7b3bebfbebb007fd..2976e360ed383f148995efcebbf73e2ebc917c83 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -327,6 +327,7 @@ int qcom_cc_really_probe(struct device *dev,
 		scd->dev = dev;
 		scd->scs = desc->gdscs;
 		scd->num = desc->num_gdscs;
+		scd->pd_list = cc->pd_list;
 		ret = gdsc_register(scd, &reset->rcdev, regmap);
 		if (ret)
 			return ret;
diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 4fc6f957d0b846cc90e50ef243f23a7a27e66899..cb4afa6d584899f3dafa380d5e01be6de9711737 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -506,6 +506,36 @@ static int gdsc_init(struct gdsc *sc)
 	return ret;
 }
 
+static int gdsc_add_subdomain_list(struct dev_pm_domain_list *pd_list,
+				   struct generic_pm_domain *subdomain)
+{
+	int i, ret;
+
+	for (i = 0; i < pd_list->num_pds; i++) {
+		struct device *dev = pd_list->pd_devs[i];
+		struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+
+		ret = pm_genpd_add_subdomain(genpd, subdomain);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void gdsc_remove_subdomain_list(struct dev_pm_domain_list *pd_list,
+				       struct generic_pm_domain *subdomain)
+{
+	int i;
+
+	for (i = 0; i < pd_list->num_pds; i++) {
+		struct device *dev = pd_list->pd_devs[i];
+		struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+
+		pm_genpd_remove_subdomain(genpd, subdomain);
+	}
+}
+
 int gdsc_register(struct gdsc_desc *desc,
 		  struct reset_controller_dev *rcdev, struct regmap *regmap)
 {
@@ -558,6 +588,9 @@ int gdsc_register(struct gdsc_desc *desc,
 			ret = pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
 		else if (!IS_ERR_OR_NULL(dev->pm_domain))
 			ret = pm_genpd_add_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
+		else if (desc->pd_list)
+			ret = gdsc_add_subdomain_list(desc->pd_list, &scs[i]->pd);
+
 		if (ret)
 			return ret;
 	}
@@ -580,6 +613,8 @@ void gdsc_unregister(struct gdsc_desc *desc)
 			pm_genpd_remove_subdomain(scs[i]->parent, &scs[i]->pd);
 		else if (!IS_ERR_OR_NULL(dev->pm_domain))
 			pm_genpd_remove_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
+		else if (desc->pd_list)
+			gdsc_remove_subdomain_list(desc->pd_list, &scs[i]->pd);
 	}
 	of_genpd_del_provider(dev->of_node);
 }
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 1e2779b823d1c8ca077c9b4cd0a0dbdf5f9457ef..dd843e86c05b2f30e6d9e978681580016333839d 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -80,6 +80,7 @@ struct gdsc_desc {
 	struct device *dev;
 	struct gdsc **scs;
 	size_t num;
+	struct dev_pm_domain_list *pd_list;
 };
 
 #ifdef CONFIG_QCOM_GDSC

-- 
2.45.2


