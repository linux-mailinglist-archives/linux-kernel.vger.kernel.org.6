Return-Path: <linux-kernel+bounces-247442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C514B92CF80
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01EC81C22290
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59FD194AF8;
	Wed, 10 Jul 2024 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aN6AsiSq"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF06319149C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607793; cv=none; b=phaHip49oNZ38Q6KJLPcNxFzLz/BcLmH7mGzgsGepDo+mU2Bq3HwCJHcQxfED14MgIaEe3S7MhaFCWMU2UQtbPI0ldcOiWRb2a3EAtkuulFY/xvap3Hdhb3QMKZfBn6119AQVf6L69UN3PkEwGt+oRIWlUOpnY852kcN84dN6ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607793; c=relaxed/simple;
	bh=kTwbKe61QUCPrnbb1cpVQTggcXTOn/D7Df0XXPC5NLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MFKNLIVfoHnKmLQafGtE87+Ybu4wYlcXOXZgZ9albwCJ6zZDGsFKbPiH/bDm1S4x1ABBbt2B6DW48iJnpVIYmFmkrGPqeKa6ssSsMH1zMrKVRw9ANaAZiiilljlzS+JQHmd0bKU/Syh0077fQiGhQd5lwrPGjLxoHjkiWI0PUc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aN6AsiSq; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-59559ea9cfdso1953374a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720607790; x=1721212590; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBsGAX5ucZSs0rabFc3mHUKWbMSbxv4GqyzeE6M9P0w=;
        b=aN6AsiSqKEPV/GkeK3JuGMezSZlnBUuSDp0gfUsz/zlELkF9A3i4RSOof1ePNraetk
         2PUPPjW8C7vx/poo4SprZYa/tf9QkXHotlpj0H98weKFBjhX7pn5dYXNRuziZvmltxFx
         eyoB0eKlsUesjwY34YL5+vj5E7SO7fpR1wq4EWDR6X010EvpihQOWI0nFQX2xeFacxZy
         997Q1pFhZn/TvUM1n+YxrQCT+dQoD9AV/SVFogFfHeQ2mmNuGALUqgwlvVVOY5cJnXcX
         TVe5JRPGRFTULq1rL7MIv9zUWpUQPa/fD9ONfksqCuAM+5mfjdbxzLBl0xseU/K+dRSt
         ZBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720607790; x=1721212590;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBsGAX5ucZSs0rabFc3mHUKWbMSbxv4GqyzeE6M9P0w=;
        b=UMMuzoD2wSnf3pSNaBWKpSka6PCiTEHwsTlgjtMEUR/PQcDaBr7ehBuUKemA6ZZsAL
         VgpG9T2rrgy44ndPMWGLLCTH0l8fi82hc8qgVp/9xtrZfan163HfEx1fpyxunw2fdaq2
         7M6XlXR7GDXgya1bBs00oxMBi2TS/THvdK7UMxJ2q+Va6woIs6FbXfWvHPULeocf/OU9
         vL5zHN8i1glh3dOLn4ec2HKdWyYTqm7jtcLWlXTomVC48XMM176d3A4+jstYScqjvcR/
         vtuhWNp8SVXeNMwBgusZiDebAWlAQohlVS1R2vT980JcEnb/3dOKxuuMSD3VupwqGdpb
         fVyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTCZ2DgxpAA6EhVOklRwP8ResddDjUM7KuFoXmwaspOFGxYa4/LHrjqO2XwcHn52P1W3hK/zZ7ZVTv7dFKL7AkIRVEy4tog4niQ7E+
X-Gm-Message-State: AOJu0YzIbZTP+TrWUBjPFW76Ct6e9YnSOYX6dMqaCrr3aCVeaYcSZfEc
	jN9+7ptYuH7522ZOkmIr9Pd51NiDGqXqkpLd0wEa+hQPEg5/J5eNWo+h6a6o5bM=
X-Google-Smtp-Source: AGHT+IHX+sxCHXBwTJmD4epP7d3YbfxuGZjRjObQdw7BJhHSOlvO1QQLECp833J9njXjW0as97YSGg==
X-Received: by 2002:a17:907:3f25:b0:a77:c13c:2170 with SMTP id a640c23a62f3a-a780b89ddb8mr357976066b.77.1720607790415;
        Wed, 10 Jul 2024 03:36:30 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc77dsm146576966b.52.2024.07.10.03.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 03:36:30 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 10 Jul 2024 11:36:21 +0100
Subject: [PATCH 14/15] usb: typec: tcpm/tcpci_maxim: convert to
 dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240710-tcpc-cleanup-v1-14-0ec1f41f4263@linaro.org>
References: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
In-Reply-To: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 Badhri Jagan Sridharan <badhri@google.com>, kernel-team@android.com, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

dev_err_probe() exists as a useful helper ensuring standardized
error messages during .probe() and using it also helps to make
the code more legible.

Use it.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index 5b5441db7047..ee3e86797f17 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -484,17 +484,17 @@ static int max_tcpci_probe(struct i2c_client *client)
 
 	chip->client = client;
 	chip->data.regmap = devm_regmap_init_i2c(client, &max_tcpci_regmap_config);
-	if (IS_ERR(chip->data.regmap)) {
-		dev_err(&client->dev, "Regmap init failed\n");
-		return PTR_ERR(chip->data.regmap);
-	}
+	if (IS_ERR(chip->data.regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(chip->data.regmap),
+				     "Regmap init failed\n");
 
 	chip->dev = &client->dev;
 	i2c_set_clientdata(client, chip);
 
 	ret = max_tcpci_read8(chip, TCPC_POWER_STATUS, &power_status);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to read TCPC_POWER_STATUS\n");
 
 	/* Chip level tcpci callbacks */
 	chip->data.set_vbus = max_tcpci_set_vbus;
@@ -511,10 +511,10 @@ static int max_tcpci_probe(struct i2c_client *client)
 
 	max_tcpci_init_regs(chip);
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
-	if (IS_ERR(chip->tcpci)) {
-		dev_err(&client->dev, "TCPCI port registration failed\n");
-		return PTR_ERR(chip->tcpci);
-	}
+	if (IS_ERR(chip->tcpci))
+		return dev_err_probe(&client->dev, PTR_ERR(chip->tcpci),
+				     "TCPCI port registration failed\n");
+
 	chip->port = tcpci_get_tcpm_port(chip->tcpci);
 	ret = max_tcpci_init_alert(chip, client);
 	if (ret < 0)
@@ -526,7 +526,8 @@ static int max_tcpci_probe(struct i2c_client *client)
 unreg_port:
 	tcpci_unregister_port(chip->tcpci);
 
-	return ret;
+	return dev_err_probe(&client->dev, ret,
+			     "Maxim TCPCI driver initialization failed\n");
 }
 
 static void max_tcpci_remove(struct i2c_client *client)

-- 
2.45.2.803.g4e1b14247a-goog


