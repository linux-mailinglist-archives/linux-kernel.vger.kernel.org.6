Return-Path: <linux-kernel+bounces-573642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D82EA6DA19
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362DB189432D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2281125EFB3;
	Mon, 24 Mar 2025 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="OTVh+lHc"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F419A25E82C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742819206; cv=none; b=dGxPi8ABD2fTlsXVQOomDZepNUa3hEpqUZNR17Ut+gl7Oe5X3am+i1OzRwA3u7AYx0SF2zC1gvCwSlF7M2o14TXRC87NMPJzX+SkNI9SWiv3z4/Za6oTjh9M6lg6N6LH9IFzQQ/kkSlXRD4G3AFQR/ncuSszJWaa/p8SREZTv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742819206; c=relaxed/simple;
	bh=7H04Zj9dfcpDfaqboI+ReMx9thHZjBGdzhXtznFfaIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5zgDz22PCLp04t7AnBXc2nDN8l5PqbK5xeu8+VH968rBzd986p0ndzvaYjtFLIGvcN7bJeu5bHaatqp22dS42/OePCGtIzRys2ao6LOoqXIiHs5JlDDL5FUJJQY8beqZzQZmqcFDWO76Q1giCfB0/Z8vlutBjw5IkZar1XRJA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=OTVh+lHc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf257158fso28486805e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 05:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1742819202; x=1743424002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tinDb82Hg/cL/rLLrkoOUK4oALU+HSZjNBXFVyGDLBE=;
        b=OTVh+lHcQATxUxUI5ISBqTaZPqB7EgrG82ShJMyClLMjRCBbrxxIyNZiN0YeD1cpoo
         QgpwtvtSTO/HYDzle12auuRsE67tBHXYegO2m955cYsKc3RR12IdkShy4RlkIZsLe9Vh
         r/7MsrCioOYWFaeHbPAqMLUDnZb/DRPTmxcX1UoRWuM7O+Qd2+cfETTEe2fAcX/4l24t
         ydiEotGd1TnciKnOe/++cW2oTp14kMpe2/121g39x5DVfIxiRK3mFT+ZC1/00UR7j9PO
         8Flzx/8gxTjY9zBIv72v6vcxai+McvdW0rENc5/DUtXM+3xELQSal8OlUZdyCIizoO66
         e9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742819202; x=1743424002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tinDb82Hg/cL/rLLrkoOUK4oALU+HSZjNBXFVyGDLBE=;
        b=OXeg0Cg03hD2Te+eA6/DZ6PC46n4xhjTa2vc1mGSOuiVD4XT7UltnsBIBOTDr+RQPy
         hghMMCyQO6WatSK1h1EeekjqAEp9qaHemFVha/rJgIewwU/5YYarDQKfIVggwAS6Z8BT
         8uXPiUpRiA6Fx28liFNiLpbADCZQL874yGaUk6me4pV6TDp65bCme2weA+RTELrycthB
         8TumchH4Ja7b6VvtRI/2/Ig8s9EC7nML8NXS4lmF2Uwl/reKfXvYw2BLmkYNdii4HYJi
         zvCGWXvdWxUDCJUMJWG6A1PpXe/rr3EprKaRLjhGi3znMsSmCIZp0KVJc9VqN+7RE8h5
         zWPA==
X-Forwarded-Encrypted: i=1; AJvYcCUI2vF7uDCLMOnzvy3GHcIRcBv6eEsDFt4ohaSByvKXArXzB8Jv6LM2fmSD5/9gpc9QubLJLPKjdOKYAI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDMUjR9PCF7kDJaIswyVkLRNh+sDbpZ4rX9tUsH7A2B4WnmUJq
	XDk4I6mi118OWNY7VMs6ew009yg0GfLgph7nKfJ3tDAxXGQSjr2OuFB96H9gTo0=
X-Gm-Gg: ASbGnctAjZmqddPv5gM6IoNDVHINMbLZijcFrUzQ0psuvyBebm+4d2IZPECsj2djupa
	7IxkE25sUNhTsOYCf9H9ZdQcCacErYndevRgfmsBmLHrGdA2nPmbYF0nBpPwl9HrubpZHXeGz01
	GySzkurNhbsPozZiuqhBBsufv7GVQFTriy0m2UBsPxj9RR9bjVXByFab2vGnkQbkVI7KCUPirng
	bf+DRAr2imDKw4T9NMopdWuzEtTajmmekjdO8D/9I39Or9zIozE9tSqN7BWo3JHQlyZNRNgNqz3
	T6PXYFHwDhQViNzV0y+zwCE7I6wAo81HajMxyuR+db1b2AhYRD175Zo+6i2kgKQ2MyfMYklUSh0
	pIbI+jtbh
X-Google-Smtp-Source: AGHT+IHcSv65sB0v7RWUQm1j0qlh5lCjs9w6YcBrjLtA5IMtXqerZCXxE7wpguWt/oUrGng/6ctEjA==
X-Received: by 2002:a05:600c:8719:b0:43d:53c:1ad6 with SMTP id 5b1f17b1804b1-43d50a4ae7dmr91654135e9.26.1742819202163;
        Mon, 24 Mar 2025 05:26:42 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef16csm10729080f8f.86.2025.03.24.05.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:26:41 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v4 2/2] iio: adc: rzg2l: Cleanup suspend/resume path
Date: Mon, 24 Mar 2025 14:26:27 +0200
Message-ID: <20250324122627.32336-3-claudiu.beznea.uj@bp.renesas.com>
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

There is no need to manually track the runtime PM status in the driver.
The pm_runtime_force_suspend() and pm_runtime_force_resume() functions
already call pm_runtime_status_suspended() to check the runtime PM state.

Additionally, avoid calling pm_runtime_put_autosuspend() during the
suspend/resume path, as this would decrease the usage counter of a
potential user that had the ADC open before the suspend/resume cycle.

Fixes: cb164d7c1526 ("iio: adc: rzg2l_adc: Add suspend/resume support")
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- collected tags

Changes in v3:
- collected tags

Changes in v2:
- none

 drivers/iio/adc/rzg2l_adc.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 761ba19b83a7..3c96684fff68 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -89,7 +89,6 @@ struct rzg2l_adc {
 	struct completion completion;
 	struct mutex lock;
 	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
-	bool was_rpm_active;
 };
 
 /**
@@ -584,14 +583,9 @@ static int rzg2l_adc_suspend(struct device *dev)
 	};
 	int ret;
 
-	if (pm_runtime_suspended(dev)) {
-		adc->was_rpm_active = false;
-	} else {
-		ret = pm_runtime_force_suspend(dev);
-		if (ret)
-			return ret;
-		adc->was_rpm_active = true;
-	}
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
 
 	ret = reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 	if (ret)
@@ -600,9 +594,7 @@ static int rzg2l_adc_suspend(struct device *dev)
 	return 0;
 
 rpm_restore:
-	if (adc->was_rpm_active)
-		pm_runtime_force_resume(dev);
-
+	pm_runtime_force_resume(dev);
 	return ret;
 }
 
@@ -620,11 +612,9 @@ static int rzg2l_adc_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (adc->was_rpm_active) {
-		ret = pm_runtime_force_resume(dev);
-		if (ret)
-			goto resets_restore;
-	}
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		goto resets_restore;
 
 	ret = rzg2l_adc_hw_init(dev, adc);
 	if (ret)
@@ -633,10 +623,7 @@ static int rzg2l_adc_resume(struct device *dev)
 	return 0;
 
 rpm_restore:
-	if (adc->was_rpm_active) {
-		pm_runtime_mark_last_busy(dev);
-		pm_runtime_put_autosuspend(dev);
-	}
+	pm_runtime_force_suspend(dev);
 resets_restore:
 	reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 	return ret;
-- 
2.43.0


