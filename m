Return-Path: <linux-kernel+bounces-573640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0871A6DA15
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D5518943B6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7507C25EF8A;
	Mon, 24 Mar 2025 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NmzVO2vU"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D7D25E81F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742819204; cv=none; b=rlWBjNnY6ycY6plruOJFjKU/VV+nM/0YV7KcGgqisiFR2Mhbb8cYwwNeBSbPG/IhEv5H8RpdVHkflZRBQ0j5TWyIh9iGUPLPW4bLdc4YYRytWmA6fkQuvhFVZDailtHj/M8Ljh6rNzl9K5UpxfRp1l7v82mrpxR9pYEMkXWH7+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742819204; c=relaxed/simple;
	bh=zr9wey0DgSZWw2ae2SBj3x677vv6HVd2wGmNFkfzeg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAjMerXf+oAfeTaZNgQopqOC8aAUgAqxFjA2QhUtqV1NvPBz46W2MP9QamI53OVf+mnzlUjsovkKLMrC938qOpfwLcqYdIQpn/GeUxrMiAqDzwxl7VQ/zQo2vVq2gX2Yslbc/qb5M7ZC9YNczxGLIRhQAfNMAk14d/wHhk4wmPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NmzVO2vU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3913d129c1aso3044462f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 05:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1742819201; x=1743424001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAOn8TrbonpHNJYP5H94LrCNELCBBbFSlDMfGma6iFc=;
        b=NmzVO2vURINB/sFAGqhwS8AKXuENstdTUd/YgWQt65LeFFXa4BUea4EDu3gMMR8KUT
         4ezMjFey2zIu1A1kh7pIwKUAO+kYJ26eZtExFnrhN394u4TMgQ3OISe+l9zT6llVhFtr
         Thht0PSx1Di28Pa7zfUgxbmhVN+IAjd8ytl883XQHpQL3Kv5QVszLW99RuAXs/xQJFU0
         lBewPK2g9aCq4Xeq9aFuXXLOhgV8nKariG8fXDT6/FbXf6VQQ+9Hs2wj0YFh3p2SaPW8
         zPr7yT0hqXTXIQBO0fGbnq7T/ANOIo7x/v8I9HN3jkn4PhZ9mROk91iR0+MxvRjM9BmZ
         giAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742819201; x=1743424001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAOn8TrbonpHNJYP5H94LrCNELCBBbFSlDMfGma6iFc=;
        b=joCn1XmzkXsKhizZiHj5hjB5UMW4F4kgnHpRhP/HSDGhDs9rGTuLMbiTuhyVHeMBvN
         dKCrtUmgG4iiu6rUCudBJjBPW1dHiRWO0CVAxmjyHoFIW0dppizBeSD26hf4hiASrTgU
         /HoHISlKN3k1AoIOumoa7qEwfL7WQuUJawOO8UklX8+kwit1U9YEu8ceJstKs/zfIVyz
         qOm1h6yx3RL1IPkIKX/C2zLqjrrOJMMyKYRp/PwGqfaH8ea1ylT8h7WncBusKs8QiZMU
         bHIY5kPP92gpsTTDdlM/HTXWVE/jpYvNEt/FC1HQ8rz7fApGoX5URBojHxdyzA95R+1T
         zM/A==
X-Forwarded-Encrypted: i=1; AJvYcCWVEmefpPGqoK8vof/3WvqGXqUPl019lunMh5T+a311qUbNJpHDZSXzu4zoa1zwfBUDD2oWRj/DM/aa1z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqcHtJIr7sebxuryWiwiqkNsINLPDA8Kmx0r9jRWKDqLCIymAd
	X9xzV9Ev5/InNljQxq0EjwEAmXXoMgc47NwtH7soZfezvUyrBMAWGmnw6OklzQw=
X-Gm-Gg: ASbGnctTdgpeVd/ABcNou/8Rp6CPtlbDYZC7vbZ8G38VAJDGQSXIDF8amc1PQk0WpIz
	xkUJAI7zJl68gnDyd3ah+fEebG+/Fli5GYOKgfCcTqN+SdRgwVYDTgtg7HehYgFypq38cywyvBR
	FjPCWlJHr+o0j3HpH8TNLFjPqgHj1Kbsn1ZmqYbSdv4WRZrVSEBz+IpfpLpDbLGTrLIdoLrS8E3
	2rGHGI/cx7hF+sdpjgTf6j8+/09SSkDn9vzfcv3EFM9PdsFrkbOYMNMTXbNIk6ecf8DoNPcZo0E
	T9kHvTCfL0Oz4qTsmSP/670LQKJ5jLU4SiMadMDEbNOFZ3GRoSUrX3Mk0qp6pbY5/PnC19g8kA=
	=
X-Google-Smtp-Source: AGHT+IGMV8QjZPQKgsN29nFO7qndrzF9UKHCNIkeRyoOoMBK8Vl+dEmqDicju8hA6KpeRdjf0jnK0w==
X-Received: by 2002:a05:6000:188e:b0:390:dec3:2780 with SMTP id ffacd0b85a97d-3997f93c60fmr9506044f8f.24.1742819200925;
        Mon, 24 Mar 2025 05:26:40 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef16csm10729080f8f.86.2025.03.24.05.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:26:40 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 1/2] iio: adc: rzg2l_adc: Open a devres group
Date: Mon, 24 Mar 2025 14:26:26 +0200
Message-ID: <20250324122627.32336-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324122627.32336-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250324122627.32336-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On all systems where the rzg2l_adc driver is used, the ADC clocks are part
of a PM domain. The code that implements the PM domains support is in
drivers/clk/renesas/rzg2l-cpg.c, the functions of interest for this commit
being rzg2l_cpg_attach_dev() and rzg2l_cpg_deattach_dev(). The PM
domains support is registered with GENPD_FLAG_PM_CLK which, according to
the documentation, instructs genpd to use the PM clk framework while
powering on/off attached devices.

During probe, the ADC device is attached to the PM domain
controlling the ADC clocks. Similarly, during removal, the ADC device is
detached from the PM domain.

The detachment call stack is as follows:

device_driver_detach() ->
  device_release_driver_internal() ->
    __device_release_driver() ->
      device_remove() ->
        platform_remove() ->
          dev_pm_domain_detach()

During driver unbind, after the ADC device is detached from its PM domain,
the device_unbind_cleanup() function is called, which subsequently invokes
devres_release_all(). This function handles devres resource cleanup.

If runtime PM is enabled via devm_pm_runtime_enable(), the cleanup process
triggers the action or reset function for disabling runtime PM. This
function is pm_runtime_disable_action(), which leads to the following call
stack of interest when called:

pm_runtime_disable_action() ->
  pm_runtime_dont_use_autosuspend() ->
    __pm_runtime_use_autosuspend() ->
      update_autosuspend() ->
        rpm_idle()

The rpm_idle() function attempts to runtime resume the ADC device. However,
at the point it is called, the ADC device is no longer part of the PM
domain (which manages the ADC clocks). Since the rzg2l_adc runtime PM
APIs directly modifies hardware registers, the
rzg2l_adc_pm_runtime_resume() function is invoked without the ADC clocks
being enabled. This is because the PM domain no longer resumes along with
the ADC device. As a result, this leads to system aborts.

Open a devres group in the driver probe and release it in the driver
remove. This ensures the runtime PM is disabled (though the devres group)
after the rzg2l_adc_remove() finishes its execution avoiding the described
scenario.

Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- open the devres group in its own function and rename the rzg2l_adc_probe()
  to rzg2l_adc_probe_helper() to have simpler code
- @Prabhakar: for this ^^ I haven't yet collected your tag
- @Jonathan: as there is no outcome yet from [1] I only addressed your review
  comments on v3; please let me know how you consider this version.
  Thank you!

[1] https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com

Changes in v3:
- open a devres group in probe and release it in remove; the failure
  path of probe() was also updated to close the devres group
- dropped Ulf's Rb tag as the patch is different now
- updated the patch description to match the new approach

Note: a generic approach was proposed in [1] to have this in the platform
bus itself but wasn't seen acceptable.

[1] https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com/

Changes in v2:
- collected Ulf's tag
- add a comment above pm_runtime_enable() explaining the reason
  it shouldn't be converted to devres
- drop devres calls that request IRQ and register IIO device
  as proposed in the review process: Ulf, I still kept you Rb
  tag; please let me know otherwise


 drivers/iio/adc/rzg2l_adc.c | 38 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 883c167c0670..761ba19b83a7 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -85,6 +85,7 @@ struct rzg2l_adc {
 	struct reset_control *adrstn;
 	const struct rzg2l_adc_data *data;
 	const struct rzg2l_adc_hw_params *hw_params;
+	void *devres_group_id;
 	struct completion completion;
 	struct mutex lock;
 	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
@@ -424,7 +425,7 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 	return ret;
 }
 
-static int rzg2l_adc_probe(struct platform_device *pdev)
+static int rzg2l_adc_probe_helper(struct platform_device *pdev, void *devres_group_id)
 {
 	struct device *dev = &pdev->dev;
 	struct iio_dev *indio_dev;
@@ -438,6 +439,7 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 
 	adc = iio_priv(indio_dev);
 
+	adc->devres_group_id = devres_group_id;
 	adc->hw_params = device_get_match_data(dev);
 	if (!adc->hw_params || adc->hw_params->num_channels > RZG2L_ADC_MAX_CHANNELS)
 		return -EINVAL;
@@ -495,6 +497,39 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	return devm_iio_device_register(dev, indio_dev);
 }
 
+static int rzg2l_adc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	void *devres_group_id;
+	int ret;
+
+	/*
+	 * Open a devres group to allow using devm_pm_runtime_enable()
+	 * w/o interfeering with dev_pm_genpd_detach() in the platform bus
+	 * remove. Otherwise, durring repeated unbind/bind operations,
+	 * the ADC may be runtime resumed when it is not part of its power
+	 * domain, leading to accessing ADC registers without its clocks
+	 * being enabled and its PM domain being turned on.
+	 */
+	devres_group_id = devres_open_group(dev, NULL, GFP_KERNEL);
+	if (!devres_group_id)
+		return -ENOMEM;
+
+	ret = rzg2l_adc_probe_helper(pdev, devres_group_id);
+	if (ret)
+		devres_release_group(dev, devres_group_id);
+
+	return ret;
+}
+
+static void rzg2l_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct rzg2l_adc *adc = iio_priv(indio_dev);
+
+	devres_release_group(&pdev->dev, adc->devres_group_id);
+}
+
 static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
 	.num_channels = 8,
 	.default_adcmp = 0xe,
@@ -614,6 +649,7 @@ static const struct dev_pm_ops rzg2l_adc_pm_ops = {
 
 static struct platform_driver rzg2l_adc_driver = {
 	.probe		= rzg2l_adc_probe,
+	.remove		= rzg2l_adc_remove,
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.of_match_table = rzg2l_adc_match,
-- 
2.43.0


