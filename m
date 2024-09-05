Return-Path: <linux-kernel+bounces-317922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5B896E593
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17DE21C234D3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C3E1B252E;
	Thu,  5 Sep 2024 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IhWa4/Ry"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2C815532A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 22:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725573806; cv=none; b=Zp8SCg99CY97hHiCQvjNY521UuF4qbgDjwo8Kuher0CgVtqdd3CFJ/C8yU2ZulD0iIWMpwSVubfhCwf9bvfsPHTEuTBPzRgrRzps8yAs4peIuXB6yMrjpBYpkOH6hkSrRQI/MeVTq88z8A63G/SAM1uPTJCnZOfvnJgGevc+19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725573806; c=relaxed/simple;
	bh=OTRIi3ecXXaMLiOVU6kmi/0lN9C40N50eKF9jB9sXbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OL+fo5sPE7UxZgqTYIRGIC++HT1aqYLPKq8J0Z7wCJOwTHFKdT8Xj7XIsVs1jYfVONvlN/0vVKS24QsN+iBZTUMvKEKOJ6mm3C7XKqcCMe0vfijtH/S8MhVwPwgOAcJcB8GxUmb8sxV2aizkJu0SwAhmxov7mxgEFCLC926XJdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IhWa4/Ry; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d8818337a5so1823704a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 15:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725573803; x=1726178603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dnpXOu3Zyeo2ogS49DXnfXg2JaQ5OAoSQd/Cck+x1g=;
        b=IhWa4/Ry5jZt7Y5gI2gDGxi4Ze+6AmovJf23UUa6EDpdr938H/SUUh/RJdKNXKFhE7
         OfwSMeoxdK3Qikf7HZDvVLnRxvox66iWaGJYV4MNY/KFuyp2WOgTRYcI1gDifbyTwXM1
         3/uQ+xWNz/uQWKglBeZkXKmyO+VYtd/8Z9jwsohfFxkUOUgQD6TynEJ8nNLvnWCK4Gqg
         NaAc2u/YWMQv047IqLyougOTCzfx3uISbKZSyZJWSyOi32MqvtJXfyAJbqlJJOuRpL8e
         N9DBplTE0D0C4EY+9FkVEum5V69KOx2lzWtPUphj7YGgE/9b119tb+M+EW5VazopVV8L
         1DWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725573803; x=1726178603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dnpXOu3Zyeo2ogS49DXnfXg2JaQ5OAoSQd/Cck+x1g=;
        b=sOURbjEIfbt2Ph3SOFovy8xmgy8GlKnmI2PpLyG3cSI2CY6ZCfMoDytEbWmRYqOKiT
         w3TjDrDoLdyhvd3ehBxm8C+IZbzqt7/GElX4bgCBqwRQAfGcvrkgRXHWnDDADevF3jdc
         fskBjxbX0hTMzeU+IJfPBNIyxmw/9QrSH8h5fXzXjcjmS/l5PHaPgyi/8h1e8cCzvVrQ
         ojVX529y+ME0YA01Lb7YaLh2gozo5WMMxI9nVgU6DcFjeTE/tBfspG9dINEpxh+timQ3
         3nJPqpcJEnDJFi+neUHN8Jxv7gQK6Gm/VMJl1MCDBCfxoCxjKo/wqIEZcE2v7NEKmIFA
         W4cA==
X-Forwarded-Encrypted: i=1; AJvYcCWrpnc1oY7cqYFrvZ7sI7i++/FARNWxHqtJkNpy+H7ReYyk8G+eeVgtro44lZselOtQBN+uSU+CsnxQY8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXhIeKO+6QuC0aoiURMKGrP4qe7aMVJZqQ51jCLzAttit1GeGJ
	4scLXTbTisxqDD0gKbLQA+2M+idiJRbPz7J9N9ic5JymYt7PhIVo3WIIJZhN5d3aDhIUWZKX0Fz
	dIFc=
X-Google-Smtp-Source: AGHT+IFAOmsjDchvyfmMDfyN7DLMT/o9DCSeWaPD7WLIQHvg3YDxCAVww3yIkyRqm8MsQ8qITK6spw==
X-Received: by 2002:a17:90b:3881:b0:2c9:5a71:1500 with SMTP id 98e67ed59e1d1-2dad4bfb4c2mr1243813a91.0.1725573802747;
        Thu, 05 Sep 2024 15:03:22 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0213a7sm11715a91.18.2024.09.05.15.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 15:03:22 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Thu, 05 Sep 2024 15:02:49 -0700
Subject: [PATCH v3 1/3] pmdomain: ti_sci: add per-device latency constraint
 management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-lpm-v6-10-constraints-pmdomain-v3-1-e359cbb39654@baylibre.com>
References: <20240905-lpm-v6-10-constraints-pmdomain-v3-0-e359cbb39654@baylibre.com>
In-Reply-To: <20240905-lpm-v6-10-constraints-pmdomain-v3-0-e359cbb39654@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3724; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=OTRIi3ecXXaMLiOVU6kmi/0lN9C40N50eKF9jB9sXbI=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBm2iqotPkPjLYhJaKyF10Ks4uB4RC0mn6OaGP/d
 jObvk4gU5eJAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZtoqqAAKCRBZNxia0/vG
 ZfCFD/9rYJGVAeDL1KqsXoiEj8HP5ckh18dNXheF8ASrqNHiZtM//IAiZpD8/d5g3h6KM6Q4qai
 k96wlkJEew6XU8mI3bsjINc4Q/1NEO/SzzEJQmEpB1Ieh/xsGAhQuFrLhycYX/Tq8PkWMuySYr1
 AT+/jo7jqDrvEqRP3cdUyucWWAnZOFuKgni9PGjBTHFkZN442tDCd5zAoYY404rbtT1FsusNwh9
 0k/aJXU7CFjNEStTVrgAmavqCZ1vQvK/3hl39Lp4HEcCc9O++v9EqI+2r0Tvj+FTDl6npotEax6
 qbmV0tf5VwpTIAvXeH7WrpZYb69ZiGyAhWjUdiY+Ekia64fAK1Zq3FZKU9MzlWR6cX1rlhm4KLw
 8RatpDZbNAMuRTEnYkLxOlHbjMod8/IzOyobB+bSEQ4x0902TkUuvccX0ri2OQ6beNP1t+Fl3lS
 DC8dT5J7RKGtv2Vqm3TOcMIVion/v5/WQBTTwmtDAKyYNCvNIIsiqkRZDFSnX/BN9ELblC/c3x5
 CtVxBRkFuGMAo+hO4RlD6ZgvTOCVc1TzThr2b/CASkV1x+MV+zoZcE/m2kLbw6pRfPro7SuNyG8
 lXdQg9tZoGj2X/FYb5CNQWYDVTbpO5BbRY4wVHyyPF5vmeR/85Z8dV6/eX6Pidd84W5rrbugfnS
 ifR21xvqZ5OYyWQ==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

For each device in a TI SCI PM domain, check whether the device has
any resume latency constraints set via per-device PM QoS.  If
constraints are set, send them to DM via the new SCI constraints API.

Checking for constraints happen for each device before system-wide
suspend (via ->suspend() hook.)

An important detail here is that the PM domain driver inserts itself
into the path of both the ->suspend() and ->resume() hook path
of *all* devices in the PM domain.  This allows generic PM domain code
to handle the constraint management and communication with TI SCI.

Further, this allows device drivers to use existing PM QoS APIs to
add/update constraints.

DM firmware clears constraints during its resume, so Linux has
to check/update/send constraints each time system suspends.

Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 1510d5ddae3d..bb95c40ab3ea 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -13,6 +13,8 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
+#include <linux/pm_qos.h>
+#include <linux/pm_runtime.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
@@ -51,6 +53,27 @@ struct ti_sci_pm_domain {
 
 #define genpd_to_ti_sci_pd(gpd) container_of(gpd, struct ti_sci_pm_domain, pd)
 
+static inline bool ti_sci_pd_is_valid_constraint(s32 val)
+{
+	return val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+}
+
+static void ti_sci_pd_set_lat_constraint(struct device *dev, s32 val)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
+	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
+	int ret;
+
+	ret = ti_sci->ops.pm_ops.set_latency_constraint(ti_sci, val, TISCI_MSG_CONSTRAINT_SET);
+	if (ret)
+		dev_err(dev, "ti_sci_pd: set latency constraint failed: ret=%d\n",
+			ret);
+	else
+		dev_dbg(dev, "ti_sci_pd: ID:%d set latency constraint %d\n",
+			pd->idx, val);
+}
+
 /*
  * ti_sci_pd_power_off(): genpd power down hook
  * @domain: pointer to the powerdomain to power off
@@ -79,6 +102,22 @@ static int ti_sci_pd_power_on(struct generic_pm_domain *domain)
 		return ti_sci->ops.dev_ops.get_device(ti_sci, pd->idx);
 }
 
+static int ti_sci_pd_suspend(struct device *dev)
+{
+	int ret;
+	s32 val;
+
+	ret = pm_generic_suspend(dev);
+	if (ret)
+		return ret;
+
+	val = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
+	if (ti_sci_pd_is_valid_constraint(val))
+		ti_sci_pd_set_lat_constraint(dev, val);
+
+	return 0;
+}
+
 /*
  * ti_sci_pd_xlate(): translation service for TI SCI genpds
  * @genpdspec: DT identification data for the genpd
@@ -188,6 +227,13 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				pd->pd.power_on = ti_sci_pd_power_on;
 				pd->idx = args.args[0];
 				pd->parent = pd_provider;
+				/*
+				 * If SCI constraint functions are present, then firmware
+				 * supports the constraints API.
+				 */
+				if (pd_provider->ti_sci->ops.pm_ops.set_device_constraint &&
+				    pd_provider->ti_sci->ops.pm_ops.set_latency_constraint)
+					pd->pd.domain.ops.suspend = ti_sci_pd_suspend;
 
 				pm_genpd_init(&pd->pd, NULL, true);
 

-- 
2.46.0


