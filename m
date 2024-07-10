Return-Path: <linux-kernel+bounces-247439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB32892CF7E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1E01C21D19
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD601194A42;
	Wed, 10 Jul 2024 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XSEVjnrf"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7806419307A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607792; cv=none; b=rTOMB6RKLBlglYnFYskq0NXUOBIY1LsNXzcp8A5kkv3HLv25KBLJYt2JA2O5HKE+JD2ZMQVu/lQJdsekNt2HLqY+FpOmQAaAxmssp796wJ75WnpA7lvPEpa5m16mazWyZqiXPgKB82Ppy2D1s8PyQtMdIxtIpWvyed9edkrik8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607792; c=relaxed/simple;
	bh=iKZAjrHtfdkDTBcwqIT8IIAuEteBm+oT+4/Ldd8Zv/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O4QORRiP2KdNuoMp487Z5I1uJC7RcUbbhtWbTv4VdCkSY/uXN3YJgRJvUfwuwGqYpEyhFtKF2d4cYDz9u6s+fGzvoKlUm11IP4lSA8S2VMKPySlKg18N2+o8NcqjuM/c79edLoADp0GUEI4EZEFzgQZ/Xg2XubWwdSZEUGV6mU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XSEVjnrf; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6fd513f18bso644506666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720607789; x=1721212589; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4f4U8/fOsC4P4OR6kmi2OCEmKlH0wqzpnH4yJN7zB2M=;
        b=XSEVjnrfrZwSrgh4Il98HiOYv0vLV+uEN6PJkWiSU+kVeRhLw8EU08D+4RZ2rNgvvb
         w93W6aaJmau7Y0bb22oMqWoNIJItBmPSbTH+BuFSEuS+tzy/bfR0ji4zNSSM7ExVoSqN
         2OMj/uFdEU39EBsT8P82by/+B6HemnaRTO6OMYr7SwHbbiGs5pFC7UnFAvlx+zhVz4cL
         GonW+VMwARPSVCAtREXDjio+TuEh3Uo/l+DuJzlkPJoEmZzGKNVuRm5YKkS+FF2xsc8P
         v5lAeRMCi0Fzs/0ZNOLdBzAqKQ4fkXEMRxFf61egaCJZf34lbh6wbvJC6gRMvjE1xSqn
         8XaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720607789; x=1721212589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4f4U8/fOsC4P4OR6kmi2OCEmKlH0wqzpnH4yJN7zB2M=;
        b=DcoGeQo9cE8RzOQ9azvzT0T2yMIWdgXd0dX3RPw+1WcGKGXsnabM03c995yv2NgDEp
         og9syAuFEOR/mYXViqGDAKsgb2V8N99Hoe1xeg41OfHbNvjQqUoUaG2iWbsIjERAsC7X
         l7w4povFBX0jXoVRLOh4vHcKeaWjxBQj4LFG08jv4x4Yi5u805dL0zaRtmf7PVdOwBXa
         VAoePWJqA/5WHKZS6wtQ5Ccy+Tw6gaJVJr7tW/2pbCayWQcnOqZ4BkHqBVklqpS+FqH/
         xVxaiZKw0oJmwm5nK41csjhvj09IdEF93mao6KgUKwSOqCiFFPU3QhSzhqfeG5HpOUM2
         oAnA==
X-Forwarded-Encrypted: i=1; AJvYcCUM5ECh7nvTrr1ZGfpmV9CevebyeSVlVPmtJmQfS15SA26BtozfwqunD/kioF+EzZ9A/BlxB5ddHijHieOvLlNtWJ2EiQj1yya/NoVd
X-Gm-Message-State: AOJu0YxBVQHZCMln1BjLojkYohy0ES7IJCCKqdZlceRQS8k4nGAj9HUr
	EUF19PZ9AO+TSCK4HNhXw0l/2LkiMAK/SwDGH1Ulkut3N91fJ363Rz5buLL0848=
X-Google-Smtp-Source: AGHT+IEvqzy9YTroir6a8Gy3exKL8AyeWU3F+zp1bH+uYbn1XzaklbsibxtyHBAUB/KlXQLl381+AQ==
X-Received: by 2002:a17:907:7e82:b0:a77:bf32:b91e with SMTP id a640c23a62f3a-a780b8848e7mr366241666b.49.1720607789137;
        Wed, 10 Jul 2024 03:36:29 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc77dsm146576966b.52.2024.07.10.03.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 03:36:28 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 10 Jul 2024 11:36:18 +0100
Subject: [PATCH 11/15] usb: typec: tcpm/tcpci_maxim: use GENMASK() for
 TCPC_VENDOR_CC_CTRL2 register
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240710-tcpc-cleanup-v1-11-0ec1f41f4263@linaro.org>
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

Convert register TCPC_VENDOR_CC_CTRL2 to using GENMASK() and
FIELD_PREP() so as to keep using a similar approach throughout the code
base and make it arguably easier to read.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/maxim_contaminant.c | 18 +++++++++++-------
 drivers/usb/typec/tcpm/tcpci_maxim.h       |  6 +++---
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
index 8ac8eeade277..f7acaa42329f 100644
--- a/drivers/usb/typec/tcpm/maxim_contaminant.c
+++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
@@ -116,13 +116,14 @@ static int max_contaminant_read_resistance_kohm(struct max_tcpci_chip *chip,
 	if (channel == CC1_SCALE1 || channel == CC2_SCALE1 || channel == CC1_SCALE2 ||
 	    channel == CC2_SCALE2) {
 		/* Enable 1uA current source */
-		ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCLPMODESEL_MASK,
-					 ULTRA_LOW_POWER_MODE);
+		ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCLPMODESEL,
+					 FIELD_PREP(CCLPMODESEL, ULTRA_LOW_POWER_MODE));
 		if (ret < 0)
 			return ret;
 
 		/* Enable 1uA current source */
-		ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCRPCTRL_MASK, UA_1_SRC);
+		ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCRPCTRL,
+					 FIELD_PREP(CCRPCTRL, UA_1_SRC));
 		if (ret < 0)
 			return ret;
 
@@ -176,7 +177,8 @@ static int max_contaminant_read_comparators(struct max_tcpci_chip *chip, u8 *ven
 	int ret;
 
 	/* Enable 80uA source */
-	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCRPCTRL_MASK, UA_80_SRC);
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCRPCTRL,
+				 FIELD_PREP(CCRPCTRL, UA_80_SRC));
 	if (ret < 0)
 		return ret;
 
@@ -209,7 +211,8 @@ static int max_contaminant_read_comparators(struct max_tcpci_chip *chip, u8 *ven
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCRPCTRL_MASK, 0);
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCRPCTRL,
+				 FIELD_PREP(CCRPCTRL, 0));
 	if (ret < 0)
 		return ret;
 
@@ -298,8 +301,9 @@ static int max_contaminant_enable_dry_detection(struct max_tcpci_chip *chip)
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCLPMODESEL_MASK,
-				 ULTRA_LOW_POWER_MODE);
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCLPMODESEL,
+				 FIELD_PREP(CCLPMODESEL,
+					    ULTRA_LOW_POWER_MODE));
 	if (ret < 0)
 		return ret;
 	ret = max_tcpci_read8(chip, TCPC_VENDOR_CC_CTRL2, &temp);
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/tcpm/tcpci_maxim.h
index 78ff3b73ee7e..92c9a628ebe1 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.h
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
@@ -20,9 +20,9 @@
 #define SBUOVPDIS                               BIT(7)
 #define CCOVPDIS                                BIT(6)
 #define SBURPCTRL                               BIT(5)
-#define CCLPMODESEL_MASK                        GENMASK(4, 3)
-#define ULTRA_LOW_POWER_MODE                    BIT(3)
-#define CCRPCTRL_MASK                           GENMASK(2, 0)
+#define CCLPMODESEL                             GENMASK(4, 3)
+#define ULTRA_LOW_POWER_MODE                    1
+#define CCRPCTRL                                GENMASK(2, 0)
 #define UA_1_SRC                                1
 #define UA_80_SRC                               3
 

-- 
2.45.2.803.g4e1b14247a-goog


