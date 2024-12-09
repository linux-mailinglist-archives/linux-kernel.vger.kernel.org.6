Return-Path: <linux-kernel+bounces-437419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF899E9304
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62128287345
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D081C222584;
	Mon,  9 Dec 2024 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jldf+6SX"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B432206A5
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745389; cv=none; b=ddxRduD8RNr17xA6zWzczAOcBz7pfOK+mAVhyTBDPluslkrfXAdPsHQQY0vhQQcdibp3QP/9pxGvrOqEa4+uHO2Rm6nCyanQOvwzXyJ3brOo+VXWb2yZxF/ltQxmWAzSb384RICA4gTQm2bw00nj2vvV/KCqy91Sj7QJflMKtCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745389; c=relaxed/simple;
	bh=UYoZ37RyjculWpGQiCFSZYiIahzyfcf1uiQSJqQ8/ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1aO57KgmiQyO5nwmpHsd67Gdim4M0SOeKw05sdyeXv7ziISjTF6gubUBgnVIzlRPH9Yjhz/ka1D9msP85rLobnmkvBSFu59R9ZE2I92C395Gt8fgmC9IjWkZI2v7qnqtO0/niXiyK60sKIkqOLsV5GhTzQ9D8DdOMVYXDw5ou4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jldf+6SX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa67bc91f88so28135766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733745386; x=1734350186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hn1iITUqCTWw5geBpowIVLe7vef2f6kBTXYqRCfLbA0=;
        b=jldf+6SXzkNxO5eR3FCMfMXk3TTrrbFryRvlxyefDC7+Iwip4K7LQPakSquKhcKnFL
         lbr97RAcmoHMlmUyuVYB8wTpeyTxEd3FNfWzSviBxo7kr+lQKy3/P02GyPhB3gO7ce2p
         5jqTWKk8to0zr5qzfCr5416wlMDlleqtVsD+qZGN8eRmqLv1R/wNg+4hgjawG8TtWXMY
         Wq9kkJ1M7Tgsn8mNPanOXDMZCfrwzyQ5Pqcj2iot29w63epl1aVyZq5zECCk48fg2K4f
         DdEH2+O9BD9IEd0fzegfKcPMH4PJo0eQeMO7aNsK2/VAzdnLXKc02dKewZNOyeRifXA6
         1aYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745386; x=1734350186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hn1iITUqCTWw5geBpowIVLe7vef2f6kBTXYqRCfLbA0=;
        b=TjrEs0BYV8HzIqPOwywx7WXi4GCeErWSr6N7NJEhkuhCO1kB5DwcAHJm8afVQyuGJZ
         100X/AQMNnqkXgkJL6D7wp6g/XvU6NPbWmqq4PamLYNBKSwwHhoOqGYiiQkTnxq/Sjnj
         nGolcmNmgznlCpPyFecQiOCt60JRRnqnTjq14wfElL1l7diZ6ggFiw1v9lGv7iQ7M3qq
         fftBBF+1UKhQZp9qDVFP9J3FqHk6Z143/Pq9m6IQ+xBbudYg6jEf6/ltjH3rhpTcPgUt
         tC0qWzZhheAtRDm9Mnn+Oz1mXdT6v3PlmX6omA0NTuiUFgxBBSTKYju4UXQr5MlXSixH
         xJlg==
X-Forwarded-Encrypted: i=1; AJvYcCVDBAA2d5OUNBzVUC+A0IDe1Df5ZlwPsj7mwFZ59/oRLwtRdSmpR4famidvk9+cm1jEnseDtruQbDgQQ8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMK3cAGEUHsVC4E7zTfpoMZLve8mR73PEaIbZw/Y9P7KeBegwP
	Qaj6+Yvc1Gnt8FRxtJ0OjdZHHkG5o3f2NEf+sbsH5U1OwEH3ceLq/RuLX+AUm94=
X-Gm-Gg: ASbGncuHKYKZtTswjE/HfKHAW2idlpz9qGNIK5gM1NU+YMY0Gli4Mx4qw01Jd31eqFG
	PwW2dn0Sr0Uij7Cqvjk43PEIifhM+huaiaSXG+bGqXIbyZEDySnIv4VWvjl1sh5fSII1vH24+tl
	SWryUFKb+bgBelJlsRJ6GN93lVbDo05wlN12yuTn/3ffoTr+DXsnxqIZ52HIs2IsgDdgru6tjWG
	sUP03wlqarf92/YMe1UHVccq9ztBnJlTbRECBwDSOExzMHUva+B/9kdXyxWjMeP
X-Google-Smtp-Source: AGHT+IH6FhBYyaKwHnnukYERgUgguK/+8BJ07//maa179WbVCtwvOKPm8MChdcKGphqtryASdBJurg==
X-Received: by 2002:a17:907:944d:b0:aa6:3736:bad4 with SMTP id a640c23a62f3a-aa639bd5e31mr533078466b.0.1733745385627;
        Mon, 09 Dec 2024 03:56:25 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6651c01c5sm343333766b.23.2024.12.09.03.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:56:25 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andy Gross <agross@codeaurora.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/4] soc: qcom: pmic_glink: simplify locking with guard()
Date: Mon,  9 Dec 2024 12:56:11 +0100
Message-ID: <20241209115613.83675-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209115613.83675-1-krzysztof.kozlowski@linaro.org>
References: <20241209115613.83675-1-krzysztof.kozlowski@linaro.org>
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

Changes in v3:
1. Rebase - bigger changes in pmic_glink_send() comparing to v2.

Changes in v2:
1. Do not use guard() in pmic_glink_probe() because of jump.
---
 drivers/soc/qcom/pmic_glink.c | 51 ++++++++++++-----------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 11e88053cc11..f842ffa3c356 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2022, Linaro Ltd
  */
 #include <linux/auxiliary_bus.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -100,15 +101,13 @@ void pmic_glink_client_register(struct pmic_glink_client *client)
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
 
@@ -119,28 +118,23 @@ int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len)
 	unsigned long start;
 	int ret;
 
-	mutex_lock(&pg->state_lock);
+	guard(mutex)(&pg->state_lock);
 	if (!pg->ept) {
-		ret = -ECONNRESET;
+		return -ECONNRESET;
 	} else {
 		start = jiffies;
 		for (;;) {
 			ret = rpmsg_send(pg->ept, data, len);
 			if (ret != -EAGAIN)
-				break;
+				return ret;
 
-			if (timeout_reached) {
-				ret = -ETIMEDOUT;
-				break;
-			}
+			if (timeout_reached)
+				return -ETIMEDOUT;
 
 			usleep_range(1000, 5000);
 			timeout_reached = time_after(jiffies, start + PMIC_GLINK_SEND_TIMEOUT);
 		}
 	}
-	mutex_unlock(&pg->state_lock);
-
-	return ret;
 }
 EXPORT_SYMBOL_GPL(pmic_glink_send);
 
@@ -227,52 +221,42 @@ static void pmic_glink_pdr_callback(int state, char *svc_path, void *priv)
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
@@ -379,9 +363,8 @@ static void pmic_glink_remove(struct platform_device *pdev)
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


