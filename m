Return-Path: <linux-kernel+bounces-297679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C03A295BC65
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAE12841CE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8941CDFBD;
	Thu, 22 Aug 2024 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rO0f6lAP"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DC31CDA23
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345304; cv=none; b=hwp4PaKlI2zaNq472xQvv4QtrUJAwJqqpashEbTY0TxNzPN3rklBaZ4JJ95VQC65q7ZIDjJtYwIXUL0NzOmBbJ0BFwPm3479vdPrLdbdZYTVkqwQA8XftkdysCTQqS29Oe4/oiFVVbuL8hf3NypcDzoI+ZuirRUE4UE2PfO6jKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345304; c=relaxed/simple;
	bh=uBNZbCFTBgJoN0EUdn3iQVSkiB93jKhDi2c0z8cz1PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQGvKiOT1cbM8GWzDXVcH9OmAHGbms4V0DeLR/ktXP73mKM0+m6ODhGZFdzskfhJK+On0jviI+BAa8Yr/MaepJvvtAG/qynkb0QXpegcdM289nhQnPE38kLv05ejWFmqo/6UUTJtq8Bf49sCP88/P7aXmc7BCo2TNnTnBChhI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rO0f6lAP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428098e2b3bso1002355e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724345301; x=1724950101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPH2A+W/GQZxwxyg/ovZd+OJfVU5LgRIBmdNRtgZeSE=;
        b=rO0f6lAPiWvxIHPQfeySY5eHfkQGCMIZbLjp1Vh1N8w2B45/1KGkfIoGOCVEibsEn4
         FGlYhvkl+Ndq9SCmRFKcAQVuk9yR6aD/oMf+F7VipGhrPv4sBhJIcNBaatDTpu+SSfxJ
         2ymH6OceigBTLrFvckdc2kCnMexajFj4pvd0aMEx8+Mj7CzmDNmz6me42BgHNXN2yhPt
         v6RENlGop6ebj6GNPLqOdsR6Z1R/+eLOGf84enFlXAOYR94nLuIbrnZvQ6kn/FZQoxzt
         PN3UG4j3WZe5jggacLEzskUYSRtUaprzJsBo4XRuUeEdApFuuuvZlnMwX7wDQ5J9UzfV
         rb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724345301; x=1724950101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPH2A+W/GQZxwxyg/ovZd+OJfVU5LgRIBmdNRtgZeSE=;
        b=lnfEzluFrA38NfW8kSarVpPTKkv9TJpiDynwRt90NxIPbCJ/rPWk0AOtaKgVEVkUJK
         WCBUR87csfNJs7zJHuFqVsotodPIiRL2UCH3k5BK5NuuPyKyw71WrDHGrJgZsLHODOA1
         0GZEFJh7tEcOrGR0c1AZCmtQkf17LOvfhey7UX/QcZLF0TD2esQcjJ7Q2tCSQ4GcFYNb
         6Et7SLPRVhB21hbHRRFL37LP18WQP9+h/1Hu4qL9fz37SsfYN9uWjiSUINYou4PNs4ah
         TsTijS4HbZZsakBtR354UXnDnBQy7b0OsRvcfpwJYyeKEfmcc/i1UwsoXq2gJKdQRjcp
         pAAw==
X-Forwarded-Encrypted: i=1; AJvYcCXzbjOHPQ7fY7gOu3pS8jX5i5Z85BobVzAkx+COFnB5RtLUAK3MIKTedun3mFPCZnhI56mzfQbC5O0X1B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxObkiuK5FbKJcL8Vi14CcyuecnZuCyjEW6goF81Ujb0iuIS3xp
	ZLg0OhykXcHJRXbE+aYnwUFG1qkdlXXAZIFMOwS0TW/MrypVHAE8WzTbUxnolI0=
X-Google-Smtp-Source: AGHT+IE1u82YaoZSBDlIR1/Eh6fDABkp/YzgT+n7gQrLwoJmIk1kUCT5m84759QWSwZGpcU6DeW/DQ==
X-Received: by 2002:a05:600c:1c90:b0:426:5f08:542b with SMTP id 5b1f17b1804b1-42abd0e7d9dmr29853575e9.0.1724345300482;
        Thu, 22 Aug 2024 09:48:20 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730814602asm2073890f8f.44.2024.08.22.09.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 09:48:20 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/2] soc: qcom: pmic_glink: simplify locking with guard()
Date: Thu, 22 Aug 2024 18:48:15 +0200
Message-ID: <20240822164815.230167-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822164815.230167-1-krzysztof.kozlowski@linaro.org>
References: <20240822164815.230167-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify error handling over locks with guard().  In few places this
elimiates error gotos and local variables.  Switch to guard() everywhere
(except when jumps would go over scoped guard) for consistency, even if
it does not bring benefit in such places.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

The part in pmic_glink_rpmsg_probe() depends on previous fix.

Changes in v2:
1. Do not use guard() in pmic_glink_probe() because of jump.
---
 drivers/soc/qcom/pmic_glink.c | 46 ++++++++++++-----------------------
 1 file changed, 15 insertions(+), 31 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 452f30a9354d..6fd7748f7693 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2022, Linaro Ltd
  */
 #include <linux/auxiliary_bus.h>
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -97,31 +98,25 @@ void pmic_glink_client_register(struct pmic_glink_client *client)
 	struct pmic_glink *pg = client->pg;
 	unsigned long flags;
 
-	mutex_lock(&pg->state_lock);
+	guard(mutex)(&pg->state_lock);
 	spin_lock_irqsave(&pg->client_lock, flags);
 
 	list_add(&client->node, &pg->clients);
 	client->pdr_notify(client->priv, pg->client_state);
 
 	spin_unlock_irqrestore(&pg->client_lock, flags);
-	mutex_unlock(&pg->state_lock);
-
 }
 EXPORT_SYMBOL_GPL(pmic_glink_client_register);
 
 int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len)
 {
 	struct pmic_glink *pg = client->pg;
-	int ret;
 
-	mutex_lock(&pg->state_lock);
+	guard(mutex)(&pg->state_lock);
 	if (!pg->ept)
-		ret = -ECONNRESET;
+		return -ECONNRESET;
 	else
-		ret = rpmsg_send(pg->ept, data, len);
-	mutex_unlock(&pg->state_lock);
-
-	return ret;
+		return rpmsg_send(pg->ept, data, len);
 }
 EXPORT_SYMBOL_GPL(pmic_glink_send);
 
@@ -208,52 +203,42 @@ static void pmic_glink_pdr_callback(int state, char *svc_path, void *priv)
 {
 	struct pmic_glink *pg = priv;
 
-	mutex_lock(&pg->state_lock);
+	guard(mutex)(&pg->state_lock);
 	pg->pdr_state = state;
 
 	pmic_glink_state_notify_clients(pg);
-	mutex_unlock(&pg->state_lock);
 }
 
 static int pmic_glink_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct pmic_glink *pg;
-	int ret = 0;
 
-	mutex_lock(&__pmic_glink_lock);
+	guard(mutex)(&__pmic_glink_lock);
 	pg = __pmic_glink;
-	if (!pg) {
-		ret = dev_err_probe(&rpdev->dev, -ENODEV, "no pmic_glink device to attach to\n");
-		goto out_unlock;
-	}
+	if (!pg)
+		return dev_err_probe(&rpdev->dev, -ENODEV, "no pmic_glink device to attach to\n");
 
 	dev_set_drvdata(&rpdev->dev, pg);
 
-	mutex_lock(&pg->state_lock);
+	guard(mutex)(&pg->state_lock);
 	pg->ept = rpdev->ept;
 	pmic_glink_state_notify_clients(pg);
-	mutex_unlock(&pg->state_lock);
 
-out_unlock:
-	mutex_unlock(&__pmic_glink_lock);
-	return ret;
+	return 0;
 }
 
 static void pmic_glink_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct pmic_glink *pg;
 
-	mutex_lock(&__pmic_glink_lock);
+	guard(mutex)(&__pmic_glink_lock);
 	pg = __pmic_glink;
 	if (!pg)
-		goto out_unlock;
+		return;
 
-	mutex_lock(&pg->state_lock);
+	guard(mutex)(&pg->state_lock);
 	pg->ept = NULL;
 	pmic_glink_state_notify_clients(pg);
-	mutex_unlock(&pg->state_lock);
-out_unlock:
-	mutex_unlock(&__pmic_glink_lock);
 }
 
 static const struct rpmsg_device_id pmic_glink_rpmsg_id_match[] = {
@@ -360,9 +345,8 @@ static void pmic_glink_remove(struct platform_device *pdev)
 	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
 		pmic_glink_del_aux_device(pg, &pg->ucsi_aux);
 
-	mutex_lock(&__pmic_glink_lock);
+	guard(mutex)(&__pmic_glink_lock);
 	__pmic_glink = NULL;
-	mutex_unlock(&__pmic_glink_lock);
 }
 
 static const unsigned long pmic_glink_sc8280xp_client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
-- 
2.43.0


