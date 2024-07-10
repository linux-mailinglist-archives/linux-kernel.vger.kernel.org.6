Return-Path: <linux-kernel+bounces-247438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A458392CF7C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD6B1F232F4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEED1946B9;
	Wed, 10 Jul 2024 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWP61PZO"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9D518FC61
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607792; cv=none; b=rpRGmAx1WYQVGVca617Jq0FKXbfsDMh0f1gvizyGfTQqdrxvJyWz+1IaboVBVhmPu21r8C1T0I53WGoCBZ0RhWOTn2a+WYcje938kxgpJTRIiYo9I3EEXRHJR/4zBJejB1Ijs/bvVTQnKvO1pNeztLnAbZY03Ik9pRmqrgynZtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607792; c=relaxed/simple;
	bh=Ju9WlpABJdDrRTF/57aRXBECK1G9qdIeBIwu/UKN1oY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hf80fXiKjylGvIj8niOGpNdAbdl4AUylA04shcNA1OiprRosS2BXNfpBTkLsSSKJr9JtAjcVMSPdgOrBRHjidIXSWy2HWPgNg8nP21LzG6YYyD9p6yzvhtRi3yuVIorMY8D2YRKDT7PoDBssifrAf1s3Fvrwp8DHmUfxIHgPTlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UWP61PZO; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so88730491fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720607789; x=1721212589; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6OaJXkmGsoVDOS/uUKpK/gkJkaOn2bDjRVF7bUSlD2Q=;
        b=UWP61PZOTBH+43o19N/jnIyrCq5VV1vuT1jPAws+ISosKcVU/hYWwYhvq8iLOXsAlO
         q12piSif9bf2UmLenLmfTc8OEHhbK4hZtz5V/i7DhAPaVg+ZWp/yyCfr+pi7LM67wuF/
         ekX5XnVUaCvFCs2HL4QA+P6O0ImuwcpBkhRUX9xz8wh63XHmG3E+oyPZqILOECiE2oBr
         Q+TZyNdzUJ037IW6UI2kVSnG8l3lnrN0djyoFCBKNCQgVG4CTtR0pIZm/gOSerFnHXNJ
         RCE/D8zR3L5baVP7+BDojte/NiuLx+64nuriclY37sn6cX1hZ5kRnrxA+C7lWMJREXYc
         IFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720607789; x=1721212589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OaJXkmGsoVDOS/uUKpK/gkJkaOn2bDjRVF7bUSlD2Q=;
        b=iQ4cRxsGWYMXy6UBv0DSAUU54Rs0LvyQLYNQ1Ui66valdTHV7EeIOPgzkYg7ZDvytt
         m0nnHqykuny9y3peU/EyqW21CGiw5t5y5wzwFjrHbud6c97SOqiobgav5WdydLj3th0m
         mmfzY2bOPIijAVowkyeiKNUExSGkYYbjSD35VqEgJ3j2L5Fs8JKyZtcIoQtEeguv0JDu
         4vZhvPQiLxSMdzNukt1DPGPl2N6UvCWhHqghd3Gqt18cWU3D2uMRJMEtxbmIK6UV1s+O
         UijLJof/6r1sUdQRUTX3tah2FVbwWCk+k9NqI5Eh8LCZkGl0P0gXFF5WRfEvZigdF7sd
         3qoA==
X-Forwarded-Encrypted: i=1; AJvYcCUDgQ0eKl3b8yOKayMxTpUspGwyOYIUwsJS9nLrruxUqWBB+6LMujYy4IdKZ1qv+ou724tLPLGjYoer2tQPc22gS5BqtSYT/K7fGJLq
X-Gm-Message-State: AOJu0YxB7GCVE2Q/3Ox0rAQVZ7d88uqmK+/ZarkmYJhMbyAgS/1Tv2co
	Hc+zgrMNVDdhmEQRlcS4ehB9rTWFqjHt4xwZzp4UGELWMTbT+kLijo6Ljh2nIvc=
X-Google-Smtp-Source: AGHT+IEMpfogYtC0LRvrYarAjzqKHCaspVd/d5SG1JDi4DhoiWZSU86bS9h+zxWDd25iFHnSWgJRwQ==
X-Received: by 2002:a05:6512:1286:b0:52d:582e:4111 with SMTP id 2adb3069b0e04-52eb999b398mr4345456e87.18.1720607788683;
        Wed, 10 Jul 2024 03:36:28 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc77dsm146576966b.52.2024.07.10.03.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 03:36:28 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 10 Jul 2024 11:36:17 +0100
Subject: [PATCH 10/15] usb: typec: tcpm/tcpci_maxim: drop STATUS_CHECK()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240710-tcpc-cleanup-v1-10-0ec1f41f4263@linaro.org>
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

Only one user of STATUS_CHECK() remains, and the code can actually be
made more legible by simply avoiding the use of that wrapper macro,
allowing to also drop the macro altogether.

Do so.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/maxim_contaminant.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
index e7687aeb69c0..8ac8eeade277 100644
--- a/drivers/usb/typec/tcpm/maxim_contaminant.c
+++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
@@ -46,8 +46,6 @@ enum fladc_select {
 #define READ1_SLEEP_MS			10
 #define READ2_SLEEP_MS			5
 
-#define STATUS_CHECK(reg, mask, val)	(((reg) & (mask)) == (val))
-
 #define IS_CC_OPEN(cc_status) \
 	(FIELD_GET(TCPC_CC_STATUS_CC1, cc_status) == TCPC_CC_STATE_SRC_OPEN \
 	 && FIELD_GET(TCPC_CC_STATUS_CC2, cc_status) == TCPC_CC_STATE_SRC_OPEN)
@@ -368,7 +366,7 @@ bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect
 		}
 		return false;
 	} else if (chip->contaminant_state == DETECTED) {
-		if (STATUS_CHECK(cc_status, TCPC_CC_STATUS_TOGGLING, 0)) {
+		if (!(cc_status & TCPC_CC_STATUS_TOGGLING)) {
 			chip->contaminant_state = max_contaminant_detect_contaminant(chip);
 			if (chip->contaminant_state == DETECTED) {
 				max_contaminant_enable_dry_detection(chip);

-- 
2.45.2.803.g4e1b14247a-goog


