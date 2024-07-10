Return-Path: <linux-kernel+bounces-247436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489C792CF77
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D751F220A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABC9194081;
	Wed, 10 Jul 2024 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GHuzfaLA"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A36190697
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607790; cv=none; b=odOfJXDZqgkhSEixRkuZpJx2wGa5iPbm2oidpgnCGkNmkMR/7ARs1M79fBkSPh1h+V9XnF0s+myWJxtsZNU+f8Vd3LljKtK3ut4H48FC0WI+OUtVwDGShI0gukqWr1XEIw/4SME/uTQIR92VGsGMHRHk1McOICYMp4zC9PhijmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607790; c=relaxed/simple;
	bh=UAK71+lPiVudSRvlmklIgP5araaTerPQgArmnySOaQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HCdyk0G/79/NoLaJe4zIW9lWE/OZyJJAG1WGrKbohQHIweqxn+xwsTzcAygy3kK5a+ybBtQTEACLfE2xiaWCZz9oUTWlQnnT6ee7WjQYykWABYeCOQS8NgCC95QkEB54puveSLQ+ujSrjmXT9Epxand9F7BvvN7DeDPTaWNN/zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GHuzfaLA; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso9325851e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720607787; x=1721212587; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJ8rGYIkXyuBqurWfe+RKCWq1Fp47kuxHXtN7U7bICs=;
        b=GHuzfaLAfxUEjxmPSRYkzl70rG/3RBNa1geqPCG3Ge7EEjCoI/vLmrJPr0mT2YxRWR
         HddaGLk0x5+/elP/DzuDvVDEw0B4NFCeb27C8k+RjYz3bNyHiEZ+NpBFt7h0IR8Bgt10
         LguNxBKsj9BVLb6/9MZpTdFiij5mI78+A8iAnl5YOLxO7Phf+RFIf3dniU4yXYKcUZxz
         73fMFhhUftbvK53W++kKycUh3mgh6MkOqsWjRqSBvV1ie1y/LvhDO9X/TACT6HYHFJcK
         O/iYsfdqG15Td1lhDb7JFLw9syiV2zD6oKeA9DheDEQ/8uaB8o5LR7xgiHXRomWlYFvT
         MQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720607787; x=1721212587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJ8rGYIkXyuBqurWfe+RKCWq1Fp47kuxHXtN7U7bICs=;
        b=oINyF5hTRZDyMeCTaFsZEaZp3DY++kQScbSrlxS5yHLSyD6rtL18x2K/Arftq1HGFq
         1LVYxXacicrS/AZE2SAW2z0qayYFYVyjxTY09FNTaSsjqLeo67AFwgwnM+sQeVTx8uhw
         deTneYbG7+7NCfv7jbQmwu382WXriv4fkcODQF6aQct7yEd/ZtF997DF76BdJpMK/Lyt
         lkFtxGeHnvZ6cedZxscFCYu0AoomeSIdb3DSjhRJ5N/MRbIRCbUAkPCXxmJ7dgewxHxn
         nvpjYByS1BubKx9EgErSocB1AOZjWvTeB9qiL6rV91R3IqVXQGaldN6q1b19IJjaf+RC
         Y2GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEvI8Yyq9dz3aqxeTXzR2IA26lR8TALK29RUH94qH2Pr4GNWOpkKq6RUe+1ZU3YVQDhWR7sdnmxq1cLh9UeIqFokRhQ2RLEZspI8tu
X-Gm-Message-State: AOJu0YysxdzrmAIwgdAALUtU3tnGPVnrKrMe3lD9HkMKoakdlQcDe4Fq
	phJRF/QvplUFK2xUsyRwyeYhABqwepdPlUueLLOzm4gZWk946m7127EhPNNpehw=
X-Google-Smtp-Source: AGHT+IEAemkZcOpN1KiuMHE8Tjf4sRBQIebOpKvSDum9xj1upl9bH+uRFUUVBjy4KJUn2DphCFwPWA==
X-Received: by 2002:ac2:4355:0:b0:52c:cb8d:637d with SMTP id 2adb3069b0e04-52eb9991e7bmr3322394e87.5.1720607786736;
        Wed, 10 Jul 2024 03:36:26 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc77dsm146576966b.52.2024.07.10.03.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 03:36:26 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 10 Jul 2024 11:36:15 +0100
Subject: [PATCH 08/15] usb: typec: tcpm/tcpci_maxim: sort TCPC_ALERT_MASK
 values by bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240710-tcpc-cleanup-v1-8-0ec1f41f4263@linaro.org>
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

This makes it easier to see what's missing and what's being programmed.

While at it, add brackets to help with formatting and remove a comment
that doesn't add much value.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index 87102b4d060d..ad9bb61fd9e0 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -97,11 +97,13 @@ static void max_tcpci_init_regs(struct max_tcpci_chip *chip)
 	if (ret < 0)
 		return;
 
-	alert_mask = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_DISCARDED | TCPC_ALERT_TX_FAILED |
-		TCPC_ALERT_RX_HARD_RST | TCPC_ALERT_RX_STATUS | TCPC_ALERT_CC_STATUS |
-		TCPC_ALERT_VBUS_DISCNCT | TCPC_ALERT_RX_BUF_OVF | TCPC_ALERT_POWER_STATUS |
-		/* Enable Extended alert for detecting Fast Role Swap Signal */
-		TCPC_ALERT_EXTND | TCPC_ALERT_EXTENDED_STATUS | TCPC_ALERT_FAULT;
+	alert_mask = (TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_DISCARDED |
+		      TCPC_ALERT_TX_FAILED | TCPC_ALERT_RX_HARD_RST |
+		      TCPC_ALERT_RX_STATUS | TCPC_ALERT_POWER_STATUS |
+		      TCPC_ALERT_CC_STATUS |
+		      TCPC_ALERT_EXTND | TCPC_ALERT_EXTENDED_STATUS |
+		      TCPC_ALERT_VBUS_DISCNCT | TCPC_ALERT_RX_BUF_OVF |
+		      TCPC_ALERT_FAULT);
 
 	ret = max_tcpci_write16(chip, TCPC_ALERT_MASK, alert_mask);
 	if (ret < 0) {

-- 
2.45.2.803.g4e1b14247a-goog


