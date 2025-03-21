Return-Path: <linux-kernel+bounces-571429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E513DA6BD09
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680D63B819C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E69A1C863C;
	Fri, 21 Mar 2025 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ltio/Pf3"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FA91CB501
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567652; cv=none; b=XW8ZbbyNhsxq9MWphnvxGaBcjxWzYOp+qbYvsw4+tVahxg0Fy+6ZrSpi0bkl8bbTsiYopEvIPIsxaK5aMe1lax/pfIb49KPOa3FpbS6AzJZiLgndSSQ5XCewb1H2bTvfPpCO6OxoI3XgiCD03qNrstAYyuuo6zrE9fyMJLxNpig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567652; c=relaxed/simple;
	bh=tlQRpQpjQvic1qXez0/nyHsRFfIfy8pmEkG+XWvnph0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EO+YZv4oMCKCwF6o79U6Je7OI464ZNiLA8caeieDrOc/DrwHhHzyzUJN4bTKPX0dh9e4Ydui9o+H/WzAJYpSkcugq/uwAds6snlbZogSC/4gUj3hbu1nyVXhiVuB6q+HyoSlRLitGa8uSdb72Lwg+EjfpuKxpa1ECcAH00Ehw54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ltio/Pf3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so12257505e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567649; x=1743172449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dn5MV4p4HQ7G2Y8DIgL0c1yin6zEacSDQc7QrsuKG8A=;
        b=Ltio/Pf3s817w2OksunZj5dFPRNLvBhk9MxCJBk4AA4INGjXFYC3/t9dU9uLmUgez8
         klXGhhmR/puhRfNZKfi3vlKoT5aDjoOsGG87LN1LwaT500GLrVJf4ExC0nGFWNke+Z52
         EHKYx3tuiS/wciaI/HbvvBaIxXFqDayvmhv6uVnhGYPzEMxYeQGsEj4DOD2Xba+EqsWj
         rJDZTo5x0yMVLI/BWU/tzNYNwpugCA3T4nh2N20HwT+VQXip1ZdLjRZ52/wL5LzI0YYb
         7TdcCxqYfpijHKcxPSHwHYxey880umrMvn18MIOzX5E5nZA2YD41UnstS/fuXl0DGQrs
         9Y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567649; x=1743172449;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dn5MV4p4HQ7G2Y8DIgL0c1yin6zEacSDQc7QrsuKG8A=;
        b=P3BOa13ul+iWz8ONP0jcUDVlI/pn0RdnPNOdrUU/Al+3P40ScAU+GZKlm5opyvVmIg
         5fNkfuKgzJNVrLCv59YY0Oi6KrhgbhoF8AHnEhS+qknE+NyezMmH/8BI+V1md/gH6urR
         vo6m9kaMpxDH+c2dM1jmEsb65bZE4OiWUZr1MHuzxiBQHYCOgGsjG6ETmt1ewpx7NyX3
         BZeABYRumIkt0RlRvl86t/cPFubrh1tGGm5WIEXOaWFxmhTayK/uKB6D2kUpXKBQc2C1
         b2o+qf5RmCZsdEgONYHRtr9q/YSzwGuZdNz82/L1ejPwMw1RuFcC3bive2H2/KO+j+XL
         Q5VA==
X-Forwarded-Encrypted: i=1; AJvYcCVZb5YzmA/8Jq+Qc76c0Xu8/9dFO8W2DnRJhbXIKBjIW6M06jUYj5WwreUsDRbvOsB5OPidmoOjp8XZj7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCgcwyfKOpvAXMF2R9ga83Qv+SPIJ3GXVe8Ox6VQ9s3ikk20BC
	aVqKpP/MvQa9OdvevI2chjBI8HcJnwMkltkVnxKoS4Je2L5+MHIX/R7wgp26jEw=
X-Gm-Gg: ASbGncvqDBtrOu66V1+WGMhb28yhepc5uOtYq6gdkwSGoxywUmOpfRb5HFnm4hhMVPa
	qy25JlUgD/hCEOvgJHb3o4KmiLLoNO9XFHvArJaEdrdXgKkwRc6YRoBDZ+1ivLGIrvwcqPrCYi3
	gO6Liw8zZWe8jXaJ/DJDz5G9hfIE4cXJOiGKNRmjd4mjZ8qdRAwmJ68IOI1VMZmfgUCCLyE74hY
	xonx2OXWbsh7UgwiHqtalikFjmth2bktYARpJajMMrSiC3GggEuV3mwHolNUA3xsKNjZqhjzolU
	qJyweBXvM37LVtTPOkv+Sti79XV/EadD4n6RwiNqkfmfEe9Wew==
X-Google-Smtp-Source: AGHT+IGxt6h0dPisO3HhNUj6iUzVe79pzrQ1FxQp78Ey1ug+TmaSuEtDysT8dPdfqLj+8Nbo4TB4bg==
X-Received: by 2002:a05:6000:1ac8:b0:390:f6aa:4e80 with SMTP id ffacd0b85a97d-3997f937b82mr4553904f8f.53.1742567649021;
        Fri, 21 Mar 2025 07:34:09 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9b260fsm2484221f8f.43.2025.03.21.07.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:34:08 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:34:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Lee Jones <lee@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] power: supply: max77705: Fix workqueue error handling in
 probe
Message-ID: <547656e3-4a5f-4f2e-802b-4edcb7c576b0@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94f55158-1776-4f2f-9296-e307e83d569a@stanley.mountain>

The create_singlethread_workqueue() doesn't return error pointers, it
returns NULL.  Also cleanup the workqueue on the error paths.

Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/power/supply/max77705_charger.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index eec5e9ef795e..329b430d0e50 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -545,20 +545,28 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 		return dev_err_probe(dev, ret, "failed to add irq chip\n");
 
 	chg->wqueue = create_singlethread_workqueue(dev_name(dev));
-	if (IS_ERR(chg->wqueue))
-		return dev_err_probe(dev, PTR_ERR(chg->wqueue), "failed to create workqueue\n");
+	if (!chg->wqueue)
+		return dev_err_probe(dev, -ENOMEM, "failed to create workqueue\n");
 
 	ret = devm_work_autocancel(dev, &chg->chgin_work, max77705_chgin_isr_work);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to initialize interrupt work\n");
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to initialize interrupt work\n");
+		goto destroy_wq;
+	}
 
 	max77705_charger_initialize(chg);
 
 	ret = max77705_charger_enable(chg);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to enable charge\n");
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to enable charge\n");
+		goto destroy_wq;
+	}
 
 	return devm_add_action_or_reset(dev, max77705_charger_disable, chg);
+
+destroy_wq:
+	destroy_workqueue(chg->wqueue);
+	return ret;
 }
 
 static const struct of_device_id max77705_charger_of_match[] = {
-- 
2.47.2


