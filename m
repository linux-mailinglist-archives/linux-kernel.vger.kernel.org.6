Return-Path: <linux-kernel+bounces-247430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA68292CF6A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18EEBB26417
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C60518FC9E;
	Wed, 10 Jul 2024 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4Xms5P0"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFBC18FA26
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607788; cv=none; b=XuFyEKfJ5KGfBK1qTNre4FESEcxNfDZaJQ/EbKlMOiHXwI+q15t+77nbkc2DMRJqIEdRY7A7//F4uz9FHkk6YoHJsnZ8oDQ4j5Ty9/tnE8GYcmx+k2QUZD0X1K4qaFaRlPY8QkBEMQ2Z5Dr64mF01jSLb+ZdqbyI9QbWv+ZCrTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607788; c=relaxed/simple;
	bh=ie2JmEfSUiTUhNpHVLVkQZYkMP0gFDlAbOaRX85e2bw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DOIVL/n3XjeMgxE4xpy6Fxg3WvDuzyhdu7SLAh9YWnFrag8Lu1GyZffqrEHGIZkGS/4RiKhm0Y+3yYjiJYl/m2SscFX9Xb5C1Fltk6LgGjluOO4mb3LV+WGAhzt8DFtXLUsMchajy/euuTmty9IE0QZLfj3wkkSQY0lBsVIcu9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g4Xms5P0; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a797c62565aso57511766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720607784; x=1721212584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwfQalACRRVjjbxpGdsLscOtRao7Xr+Lw/le1ijWaFk=;
        b=g4Xms5P0k3NYhR6cEKZ6Yg1+AQ7kQHEelBWQdxPUz/TkNav9AUo8vI7rYlc5hiSIEP
         z2Gfdlr8X367sGxpAIZaKIpoOEb+wkX0hHXaXVlUcpdx7mP+bcmsxT2BfYqz0fu35z44
         bKMm8X3zIpeZDrGpQIONUD5ifR8XC07jAqreZjanPKasA3Us4j8jLKbXQTPRqV+Cw87P
         FJSgFY7OUtH8FOSVK2f13/mzcG8cmTgCCLUYDhkDvfpRSg/j2qWLqqO1PIhUeZyhZmNo
         uTbbqRv3ge34vFmExB7IbM3OUC1/MWCYuCp8PdQg0iYxjX2Gg93qKV7IcurRB/9Wq6Ic
         TnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720607784; x=1721212584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwfQalACRRVjjbxpGdsLscOtRao7Xr+Lw/le1ijWaFk=;
        b=oYNYLMb9Do4xlUKRjmc93AQP42FGOLLXFxRMk9IolCv2l9stb/eQuEhc3tbN7FaOvT
         aPkG8OEzjyHTLznMryJ6fs7agml417wp9jAGFR4GBNOQoOieeg/xL6w6ASOW5mR3ubA2
         UB7Bv1hlj2tALQCzEp7kywEpwUO+I/lgGxd+aOHw6fLsJC9YBQe9bMsmoQ6AkAUnawzT
         4sBT9bMf4A5kzxOym+x501Nmv4HI4S6Klgfrjc19QtQfSEPOPo8goJNS0oTjG8xGlmpO
         eTgJNGpuzpSga/hlLPL9a5kg7MYJhXw3xtW9QkSJgcGWBeU++yuvkqEYPdaokaWEFwz6
         ozVw==
X-Forwarded-Encrypted: i=1; AJvYcCWrfeAzC3Lt8E6oNSnODV9YkjUPYV2RpJxKSRi7YNYtdiSocHVBfOEQ78W1KPbUss59WQEfnNPwhFDYJfma5xVId/Ls/ZWyS3kqdxOb
X-Gm-Message-State: AOJu0YwkGATLxpHHF5ng1okn4ixIvbl4ATOqI+Eo+gjNFTCjFEn/G3zF
	WoJgK62X2youN5pGMmA9i8QbkZCEo+5zBhiPwyWx+uxiDCWCM7dnxsX/ajXlG20=
X-Google-Smtp-Source: AGHT+IHBIzsNTce5pBOT96MfRjxpyaoMRtCO0GXv5dj4EAemMgtOGhYPOOBtYMfTkQaIQZk1FTryeQ==
X-Received: by 2002:a17:907:7da8:b0:a6f:e456:4207 with SMTP id a640c23a62f3a-a780b88498fmr439952166b.61.1720607784519;
        Wed, 10 Jul 2024 03:36:24 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc77dsm146576966b.52.2024.07.10.03.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 03:36:24 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 10 Jul 2024 11:36:10 +0100
Subject: [PATCH 03/15] usb: typec: tcpci: use GENMASK() for
 TCPC_CC_STATUS_CC[12]
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240710-tcpc-cleanup-v1-3-0ec1f41f4263@linaro.org>
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

The existing code here, particularly in maxim_contaminant.c, is
arguably quite hard to read due to the open-coded masking and shifting
spanning multiple lines.

Use GENMASK() and FIELD_GET() instead, which arguably make the code
much easier to follow.

While at it, use the symbolic name TCPC_CC_STATE_SRC_OPEN for one
instance of open-coded 0x0.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/maxim_contaminant.c | 8 +++-----
 drivers/usb/typec/tcpm/tcpci.c             | 7 +++----
 drivers/usb/typec/tcpm/tcpci_rt1711h.c     | 7 +++----
 include/linux/usb/tcpci.h                  | 8 +++-----
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
index f8504a90da26..e7687aeb69c0 100644
--- a/drivers/usb/typec/tcpm/maxim_contaminant.c
+++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
@@ -5,6 +5,7 @@
  * USB-C module to reduce wakeups due to contaminants.
  */
 
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/irqreturn.h>
 #include <linux/module.h>
@@ -48,11 +49,8 @@ enum fladc_select {
 #define STATUS_CHECK(reg, mask, val)	(((reg) & (mask)) == (val))
 
 #define IS_CC_OPEN(cc_status) \
-	(STATUS_CHECK((cc_status), TCPC_CC_STATUS_CC1_MASK << TCPC_CC_STATUS_CC1_SHIFT,  \
-		      TCPC_CC_STATE_SRC_OPEN) && STATUS_CHECK((cc_status),               \
-							      TCPC_CC_STATUS_CC2_MASK << \
-							      TCPC_CC_STATUS_CC2_SHIFT,  \
-							      TCPC_CC_STATE_SRC_OPEN))
+	(FIELD_GET(TCPC_CC_STATUS_CC1, cc_status) == TCPC_CC_STATE_SRC_OPEN \
+	 && FIELD_GET(TCPC_CC_STATUS_CC2, cc_status) == TCPC_CC_STATE_SRC_OPEN)
 
 static int max_contaminant_adc_to_mv(struct max_tcpci_chip *chip, enum fladc_select channel,
 				     bool ua_src, u8 fladc)
diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 8a18d561b063..ce11a154c7dc 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -5,6 +5,7 @@
  * USB Type-C Port Controller Interface.
  */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -241,12 +242,10 @@ static int tcpci_get_cc(struct tcpc_dev *tcpc,
 	if (ret < 0)
 		return ret;
 
-	*cc1 = tcpci_to_typec_cc((reg >> TCPC_CC_STATUS_CC1_SHIFT) &
-				 TCPC_CC_STATUS_CC1_MASK,
+	*cc1 = tcpci_to_typec_cc(FIELD_GET(TCPC_CC_STATUS_CC1, reg),
 				 reg & TCPC_CC_STATUS_TERM ||
 				 tcpc_presenting_rd(role_control, CC1));
-	*cc2 = tcpci_to_typec_cc((reg >> TCPC_CC_STATUS_CC2_SHIFT) &
-				 TCPC_CC_STATUS_CC2_MASK,
+	*cc2 = tcpci_to_typec_cc(FIELD_GET(TCPC_CC_STATUS_CC2, reg),
 				 reg & TCPC_CC_STATUS_TERM ||
 				 tcpc_presenting_rd(role_control, CC2));
 
diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 67422d45eb54..c6dbccf6b17a 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -5,6 +5,7 @@
  * Richtek RT1711H Type-C Chip Driver
  */
 
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
@@ -195,12 +196,10 @@ static inline int rt1711h_init_cc_params(struct rt1711h_chip *chip, u8 status)
 	if (ret < 0)
 		return ret;
 
-	cc1 = tcpci_to_typec_cc((status >> TCPC_CC_STATUS_CC1_SHIFT) &
-				TCPC_CC_STATUS_CC1_MASK,
+	cc1 = tcpci_to_typec_cc(FIELD_GET(TCPC_CC_STATUS_CC1, status),
 				status & TCPC_CC_STATUS_TERM ||
 				tcpc_presenting_rd(role, CC1));
-	cc2 = tcpci_to_typec_cc((status >> TCPC_CC_STATUS_CC2_SHIFT) &
-				TCPC_CC_STATUS_CC2_MASK,
+	cc2 = tcpci_to_typec_cc(FIELD_GET(TCPC_CC_STATUS_CC2, status),
 				status & TCPC_CC_STATUS_TERM ||
 				tcpc_presenting_rd(role, CC2));
 
diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
index d27fe0c22a8b..31d21ccf662b 100644
--- a/include/linux/usb/tcpci.h
+++ b/include/linux/usb/tcpci.h
@@ -92,11 +92,9 @@
 #define TCPC_CC_STATUS_TERM		BIT(4)
 #define TCPC_CC_STATUS_TERM_RP		0
 #define TCPC_CC_STATUS_TERM_RD		1
+#define TCPC_CC_STATUS_CC2		GENMASK(3, 2)
+#define TCPC_CC_STATUS_CC1		GENMASK(1, 0)
 #define TCPC_CC_STATE_SRC_OPEN		0
-#define TCPC_CC_STATUS_CC2_SHIFT	2
-#define TCPC_CC_STATUS_CC2_MASK		0x3
-#define TCPC_CC_STATUS_CC1_SHIFT	0
-#define TCPC_CC_STATUS_CC1_MASK		0x3
 
 #define TCPC_POWER_STATUS		0x1e
 #define TCPC_POWER_STATUS_DBG_ACC_CON	BIT(7)
@@ -256,7 +254,7 @@ static inline enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, bool sink)
 		if (sink)
 			return TYPEC_CC_RP_3_0;
 		fallthrough;
-	case 0x0:
+	case TCPC_CC_STATE_SRC_OPEN:
 	default:
 		return TYPEC_CC_OPEN;
 	}

-- 
2.45.2.803.g4e1b14247a-goog


