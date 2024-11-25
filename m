Return-Path: <linux-kernel+bounces-420584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896F29D7CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2FCEB21C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1E918C322;
	Mon, 25 Nov 2024 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fs8vT4iO"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3F62A1BA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523492; cv=none; b=AERByewHeVH+c22mbQR3cvQ3CbhWo4IWu6oByIp09rhyPleDBl+5jyDeyWYhIHGuLQFFSVEObvIqu1a2oqLHDF1l3HtYdUR0Z6cYpOWFB42olB9FhxNsrSRxYkAbxdMNP0f7Hu1dRM85t4LCvFlyTQoTwHMAQpuB9SjWgbTuOt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523492; c=relaxed/simple;
	bh=Z9o0zBt1p8Fbtg42SUEpQ9tA831XqF2aBKjtqmgJJZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q68DOZrPkTspRzn5zygRL0D2gDPdseEkqYbWtvoykMJI23NHtRG/WIcijCRw0KmnbYAnfl1/S74/9ixIHO7/wtJi+zNc84C/7rvyhlNrz4agJRJ815B6qYxjD9AE8NUcHDrcJE8ggbs2V07nzWD7DPE6do1fGxZPyex/aX3KSGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fs8vT4iO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7251331e756so287875b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 00:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732523490; x=1733128290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsxN4SRIKBH72Tu6V02jm4aTE1CgMy52+kme9RyF4tE=;
        b=Fs8vT4iOVcLGtKwwlNC/r/uLXsQVl2irboCafbwNoGiVz4GZRZ8rqFs85pLms81+XN
         /0ddEbTslWgdLBQehJYxGaODPO803Ph4LouKWhBN7MuHBUIWeTQju3yZ7oCyoWxSWF1p
         ij1a84CSAsRaDFq6Vx1GwBjgn/lwJANqjxFWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732523490; x=1733128290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsxN4SRIKBH72Tu6V02jm4aTE1CgMy52+kme9RyF4tE=;
        b=S1q5vbV2MG5FgPfm8ye8jc/0IGuSUXQGiLBolZ/V3bzPJThefw1IhLwvBxvYmm760+
         I5gzGDu6fgMTWKl5rFkUS5oVWiu+KD9H15Tm9I0zwBGmYw5MWDqUMGlxyzG6mZq+m4n0
         oeAC52RUJtUlFyZUbgw0zBAgeRPD6H0flLH4oenUdfElO8IZ+WIr99jEj6m1GqnGu6jU
         8vNhEOwAWDXFurP2BEeUEdDtXQreDWZeR7PtmLt/W+8iPJ/hfPG886gyk75r/huL1aEv
         Z8+3LlPWpnpmWrP+HW+evSOuGYkNkBOjdSzgEUslRVW4QEqXTaDo2Y80di48w2hD/kGx
         6l0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYt+PmyJROdXzqoNPtxM3zRc7BRFKr5bPRXzbJVaUwGWxy6WUadvCqYmNeorRdNNeTM2KdwuCMJSoNeoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwlufS9ALEMohE5nvtwP7zf24h7AsyxNepQJ721Z5UpMWJGdod
	3MRzO/pjcaqfdOstp1SepTe63t7wPwp2mjybCltVWzFeGH5JOuYHa9q7MSTbJw==
X-Gm-Gg: ASbGncsKxoCYsUiRJ9veInypzWvmjix1KueCItIBHOiwvM2mXjCktdnzbruuXxW9VwS
	8HOLvBG05z+AUf60cRIvkLJuDoUdKQUSfIWHY7NLpYA7u9cGaeAakwssJ9o0O/eWy/CoxetK4vp
	yS6THXIjEbi05C6j8mpbw71nXr11D8SChGnjbh1PT80HurupyVP/CBvaPOX9n/i+8KRSwg84t4K
	bLS+QdkiJUYMW+SvbOGvlUNNFaKKBJvN3RcGnrGBBZlOgT0PTi9iF6Z/QPSdV6d2U5k45CE
X-Google-Smtp-Source: AGHT+IElfYm4ovmTHj2+mTSX4Iki8fGKuWTAto+ePAtH8SREZcFJUbZFxKAbnjYxZwRfgDH7pFKmgA==
X-Received: by 2002:a17:902:d48b:b0:210:fce4:11db with SMTP id d9443c01a7336-2129f557214mr205937125ad.22.1732523489941;
        Mon, 25 Nov 2024 00:31:29 -0800 (PST)
Received: from lschyi-p920.tpe.corp.google.com ([2401:fa00:1:10:66a3:d18f:544f:227a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dbfece2sm59090025ad.157.2024.11.25.00.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 00:31:29 -0800 (PST)
From: Sung-Chi Li <lschyi@chromium.org>
Date: Mon, 25 Nov 2024 16:31:16 +0800
Subject: [PATCH v2 1/2] power: supply: cros_usbpd-charger: extend as a
 thermal of cooling device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-extend_power_limit-v2-1-c3266a86e9b1@chromium.org>
References: <20241125-extend_power_limit-v2-0-c3266a86e9b1@chromium.org>
In-Reply-To: <20241125-extend_power_limit-v2-0-c3266a86e9b1@chromium.org>
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sung-Chi Li <lschyi@chromium.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732523485; l=5418;
 i=lschyi@chromium.org; s=20241113; h=from:subject:message-id;
 bh=Z9o0zBt1p8Fbtg42SUEpQ9tA831XqF2aBKjtqmgJJZg=;
 b=u0ppdMgicsIpoqlOU/qoi5m7vJzwW0+wr7fdKUJ/u8eOUo4g3VrbIQDpVcfRCAqswBMrxU2QE
 W4e9WxlOzFJCCy9/oekvD4I0EUjz3+jrDw1b2ZfOP6/qqwX/gCaZZj/
X-Developer-Key: i=lschyi@chromium.org; a=ed25519;
 pk=nE3PJlqSK35GdWfB4oVLOwi4njfaUZRhM66HGos9P6o=

A charge chip is connected to the ChromeOS Embedded Controller (EC).
When external power input into the system, current would go through the
charger chip, generating heat in the system. The EC supports limiting
the input current, thus reducing the generated heat.

cros_usbpd-charger is the driver that takes care the system input power
from the pd charger. This driver also exposes the functionality to limit
input current. As a result, extend this driver to make it as a passive
thermal cooling device by limiting the input current. This commit
implements the required cooling methods and OF style registration.

Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
---
 drivers/power/supply/cros_usbpd-charger.c | 84 ++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 47d3f58aa15c..a080090898c0 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
+#include <linux/thermal.h>
 
 #define CHARGER_USBPD_DIR_NAME			"CROS_USBPD_CHARGER%d"
 #define CHARGER_DEDICATED_DIR_NAME		"CROS_DEDICATED_CHARGER"
@@ -22,6 +23,7 @@
 					 sizeof(CHARGER_DEDICATED_DIR_NAME))
 #define CHARGER_CACHE_UPDATE_DELAY		msecs_to_jiffies(500)
 #define CHARGER_MANUFACTURER_MODEL_LENGTH	32
+#define CHARGER_COOLING_INTERVALS		10
 
 #define DRV_NAME "cros-usbpd-charger"
 
@@ -76,6 +78,8 @@ static enum power_supply_property cros_usbpd_dedicated_charger_props[] = {
 /* Input voltage/current limit in mV/mA. Default to none. */
 static u16 input_voltage_limit = EC_POWER_LIMIT_NONE;
 static u16 input_current_limit = EC_POWER_LIMIT_NONE;
+/* Cooling level interns of current limit */
+static u16 input_current_cooling_level;
 
 static bool cros_usbpd_charger_port_is_dedicated(struct port_data *port)
 {
@@ -459,13 +463,19 @@ static int cros_usbpd_charger_set_prop(struct power_supply *psy,
 			break;
 
 		input_current_limit = intval;
-		if (input_current_limit == EC_POWER_LIMIT_NONE)
+		if (input_current_limit == EC_POWER_LIMIT_NONE) {
 			dev_info(dev,
 			  "External Current Limit cleared for all ports\n");
-		else
+			input_current_cooling_level = 0;
+		} else {
 			dev_info(dev,
 			  "External Current Limit set to %dmA for all ports\n",
 			  input_current_limit);
+			input_current_cooling_level =
+				input_current_limit *
+				CHARGER_COOLING_INTERVALS /
+				port->psy_current_max;
+		}
 		break;
 	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
 		ret = cros_usbpd_charger_set_ext_power_limit(charger,
@@ -525,6 +535,64 @@ static void cros_usbpd_charger_unregister_notifier(void *data)
 	cros_usbpd_unregister_notify(&charger->notifier);
 }
 
+static int
+cros_usbpd_charger_get_max_cooling_state(struct thermal_cooling_device *cdev,
+					 unsigned long *cooling_level)
+{
+	*cooling_level = CHARGER_COOLING_INTERVALS;
+	return 0;
+}
+
+static int
+cros_usbpd_charger_get_cur_cooling_state(struct thermal_cooling_device *cdev,
+					 unsigned long *cooling_level)
+{
+	*cooling_level = input_current_cooling_level;
+	return 0;
+}
+
+static int
+cros_usbpd_charger_set_cur_cooling_state(struct thermal_cooling_device *cdev,
+					 unsigned long cooling_level)
+{
+	struct charger_data *charger = cdev->devdata;
+	struct port_data *port;
+	int current_limit;
+	int idx = -1;
+	int ret;
+
+	for (int i = 0; i < charger->num_registered_psy; i++) {
+		port = charger->ports[i];
+		if (port->psy_status == POWER_SUPPLY_STATUS_CHARGING) {
+			idx = i;
+			break;
+		}
+	}
+
+	if (idx == -1)
+		return -EINVAL;
+
+	current_limit =
+		port->psy_current_max - (cooling_level * port->psy_current_max /
+					 CHARGER_COOLING_INTERVALS);
+	ret = cros_usbpd_charger_set_ext_power_limit(charger, current_limit,
+						     input_voltage_limit);
+	if (ret < 0)
+		return ret;
+
+	input_current_limit = (current_limit == port->psy_current_max) ?
+				      EC_POWER_LIMIT_NONE :
+				      current_limit;
+	input_current_cooling_level = cooling_level;
+	return 0;
+}
+
+static const struct thermal_cooling_device_ops cros_usbpd_charger_cooling_ops = {
+	.get_max_state = cros_usbpd_charger_get_max_cooling_state,
+	.get_cur_state = cros_usbpd_charger_get_cur_cooling_state,
+	.set_cur_state = cros_usbpd_charger_set_cur_cooling_state,
+};
+
 static int cros_usbpd_charger_probe(struct platform_device *pd)
 {
 	struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
@@ -534,6 +602,7 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
 	struct charger_data *charger;
 	struct power_supply *psy;
 	struct port_data *port;
+	struct thermal_cooling_device *cdev;
 	int ret = -EINVAL;
 	int i;
 
@@ -674,6 +743,17 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
 			goto fail;
 	}
 
+	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
+		cdev = devm_thermal_of_cooling_device_register(
+			dev, ec_device->dev->of_node, DRV_NAME, charger,
+			&cros_usbpd_charger_cooling_ops);
+		if (IS_ERR(cdev)) {
+			dev_warn_probe(
+				dev, PTR_ERR(cdev),
+				"Failing register thermal cooling device\n");
+		}
+	}
+
 	return 0;
 
 fail:

-- 
2.47.0.371.ga323438b13-goog


