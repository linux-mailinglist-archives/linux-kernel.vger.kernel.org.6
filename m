Return-Path: <linux-kernel+bounces-365875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF8599ECD7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46DD286032
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C271DD0CB;
	Tue, 15 Oct 2024 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WliD97sU"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1571C4A31
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998321; cv=none; b=Rv2kjj8OD0WkCLC77c0qgInONxFV9rL1CuzmLuQjtFANWOOGzEpf95Ia9cB1mXc61Xvx8ThLh2//ZiliFjd5DFYp2L3ZGHTJzgSjjojs+jf2Vy3fQG9aZXk/IzJCmTVDOkv+aQ3Pq/UJqrtQLrLO7SvSdiKLJznCek2+1DPGpI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998321; c=relaxed/simple;
	bh=2CgSbgvvkBqtYryev+VqkEOiD0s0o6aEpuEPDRBhRys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+Qws/3BZHLkIsy1Mjym2+V0nPmKY8u9YGnYZuXJk7bqydkNafeGVM++tsOmhTeupExxbOuwaZxHmwpf2qZmRSKTZSv8dmvN05lTKhISbFSRMnyTuntSqRKw2GAWFAGCwyV3VYBVVAAytap1uTi40SporkC8VkM1B9Er7WJNQqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WliD97sU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4305413aec9so51634615e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728998318; x=1729603118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNdD2EpO9Y6gl3mviWbnlvM90nN1wpIKGR3Wg7HuC28=;
        b=WliD97sUtjxz2c1959dBaBopri2fKhugC79qdHE/I0UJSqjIW0zULB7S47VLOKQwHT
         BooUVe542fZYodKX3z6ijRZmkDKvq1r9UNl2AkU+Cxu3txtz5ZTPUnA/QJm3W+sOQd7w
         GRL2YfQEkCVCFBIIWXsMD/CqH9wKOyNGUmATJzRRxJYKxPxSKCdcn01vcsOjpTbLoH6g
         jRcZVdzsA+nR2a4E3WDtLS6nZKXkBkVU8t7/03OEIPSjv8QF9lsM2eFGxkcQxmHyGVSD
         UVm5Uuk/NZRLPPzKM2ZZ+wjmtz+uvJFZX4okOS92RlSr+Fl/T68/KmhlJrMTN6tL0cm0
         VEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728998318; x=1729603118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNdD2EpO9Y6gl3mviWbnlvM90nN1wpIKGR3Wg7HuC28=;
        b=l+h8Zx4kwGRMAj5c6VbAECoCgUEAz7Nqm0FfoxgABiyA5ez0NpiH1Se8VEMrFoMo0J
         ica7U3s1fonjHUFP87KrrO2i8fWRFzO22GPZ183SRu5jdLGklA3eg4jCICYjC68U6gTZ
         MqMxdBMOYRZQiulCPfjdCWSP82qy+k6b9U30vKJMLydQ7Lvqgf1Bi4QLSjyHqJE/rOv4
         tJvN08AHZoYJ973ppvbwjwNAXEp0R9iWEL5jBgXNB1x0fW03Y16QM3RoVObExBltsRyS
         /ccORgO7c/DA8VlPBWim4UOM8WU/NMGR5Xp5uIahfxdqhG/bYc2utAww+TB/9g1CY4MY
         PIhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc1Fh4DhWtUNym//y8YQ/R3v/ZEEr7QiAZipueaK4WdbOVXXU+eMdyrqza0qoT2dp5gQYiMRxtLGxV2CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOt2r6kCyXtujr3Q5jaTBHIz1nCgofjv9hZIwstFU4R6FGof0C
	AiMrImKrtlqnkfuXYxPoQtnnBg16By29DiZbdK8jitMHahX1uXZIggQBkMp/Ix0=
X-Google-Smtp-Source: AGHT+IEjyVoGglejbSYjd5SDXqkOOWcWTIBT5N32UHdipzbJXhnvu7JKVdu/PvuBY9EOWP7lb2tj0A==
X-Received: by 2002:a05:600c:1906:b0:42c:b45d:4a7b with SMTP id 5b1f17b1804b1-4314a37bb99mr4361445e9.25.1728998317447;
        Tue, 15 Oct 2024 06:18:37 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:d382:b11b:c441:d747])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6c5524sm17676405e9.44.2024.10.15.06.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 06:18:37 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 4/4] gpio: grgpio: remove remove()
Date: Tue, 15 Oct 2024 15:18:32 +0200
Message-ID: <20241015131832.44678-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241015131832.44678-1-brgl@bgdev.pl>
References: <20241015131832.44678-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use devres to automatically manage resources and remove the remove()
callback.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-grgpio.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
index e11d7c4ad04d..7ffe59d845f0 100644
--- a/drivers/gpio/gpio-grgpio.c
+++ b/drivers/gpio/gpio-grgpio.c
@@ -318,6 +318,13 @@ static void grgpio_irq_unmap(struct irq_domain *d, unsigned int irq)
 	raw_spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);
 }
 
+static void grgpio_irq_domain_remove(void *data)
+{
+	struct irq_domain *domain = data;
+
+	irq_domain_remove(domain);
+}
+
 static const struct irq_domain_ops grgpio_irq_domain_ops = {
 	.map	= grgpio_irq_map,
 	.unmap	= grgpio_irq_unmap,
@@ -394,6 +401,11 @@ static int grgpio_probe(struct platform_device *ofdev)
 			return -EINVAL;
 		}
 
+		err = devm_add_action_or_reset(dev, grgpio_irq_domain_remove,
+					       priv->domain);
+		if (err)
+			return err;
+
 		for (i = 0; i < gc->ngpio; i++) {
 			struct grgpio_lirq *lirq;
 			int ret;
@@ -416,13 +428,9 @@ static int grgpio_probe(struct platform_device *ofdev)
 		}
 	}
 
-	platform_set_drvdata(ofdev, priv);
-
-	err = gpiochip_add_data(gc, priv);
+	err = devm_gpiochip_add_data(dev, gc, priv);
 	if (err) {
 		dev_err(dev, "Could not add gpiochip\n");
-		if (priv->domain)
-			irq_domain_remove(priv->domain);
 		return err;
 	}
 
@@ -432,16 +440,6 @@ static int grgpio_probe(struct platform_device *ofdev)
 	return 0;
 }
 
-static void grgpio_remove(struct platform_device *ofdev)
-{
-	struct grgpio_priv *priv = platform_get_drvdata(ofdev);
-
-	gpiochip_remove(&priv->gc);
-
-	if (priv->domain)
-		irq_domain_remove(priv->domain);
-}
-
 static const struct of_device_id grgpio_match[] = {
 	{.name = "GAISLER_GPIO"},
 	{.name = "01_01a"},
@@ -456,7 +454,6 @@ static struct platform_driver grgpio_driver = {
 		.of_match_table = grgpio_match,
 	},
 	.probe = grgpio_probe,
-	.remove_new = grgpio_remove,
 };
 module_platform_driver(grgpio_driver);
 
-- 
2.43.0


