Return-Path: <linux-kernel+bounces-247441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF5E92CFBB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39EB6B2B0F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8B3194AF2;
	Wed, 10 Jul 2024 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t2iuUmxu"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF6F190049
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607793; cv=none; b=YJs8640ZhaBvjchGtUEkHn84fNyhKPqtxXUQvc8X/X5OJa1s1rwHblOZuohL9+yER3nSLB93kqEVdveMaUcIJ0vFPsIGV7Xr4WqaSVdMvKBlsleSsHYdXxMABFNeQXAEvatM10tSa8m3bAvnMD6vS13aMgApjfAy+NbCYFhCPoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607793; c=relaxed/simple;
	bh=5yRLOBbpIkonyEMF2zlkIakdxYmFf6q9yRfJ8EyXCI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HOdAsPuPn3RcUMsV3mj05C8sgCWH1IKynWSrDO4f9kuJK5F/bJ93StbRKex9/36ksPHYuX2Btr1F3YrEHO/1eNZ/J3GPC8tGl5Hozu6I7Z9/6k2qqkYlmR2JkD5hHS5KcOEI2K1y7YEcZ8zYXV93cS7B+5qAbchTixLCIozJHy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t2iuUmxu; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77baa87743so665845766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720607790; x=1721212590; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYMGxlVQPX5oebPOJL95p63LDeiB2wZboyKuWqi62pM=;
        b=t2iuUmxu/JD0RJmUdNdUC6/sahYaSXdMd9idXe/zvL6WBe2JddU1mNjG1j5O0A3jTH
         7R3zxhioJLND98IyPN38hf2sPQh/l1m2NS5tzeD6LBMy6sN0fBMXnBzaS+3lUgPIMNVh
         wpWqCQIlcTDtdJMCnT5NGOcRa4VOMmvhXD9hqfcdDL43mcIZRZQNMKaV7LtOGz+B3j1l
         rpgySzBrU0MpzyIKJ/i3Lg6zxS9LXwPN70qF2j05Sg187ph2/b7eMGTlVUwzlKda2qo6
         cek+H56/A6WZFZg9sUlYjgig5cipxBuGBub/H1WEXtzwcp4SSk1MEy2QCs4RgMohx77b
         v+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720607790; x=1721212590;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYMGxlVQPX5oebPOJL95p63LDeiB2wZboyKuWqi62pM=;
        b=cCNa2VB/T1uR6PZwDha7aY58BsRxthreNh0/H7yaOsdVj8ZrQXvimi/gQwK3N/Mr6L
         n5TO+lPZJY7j/tC+bd4kylM8x7gYlpD0NtDZ40gBCKCEsrzQu+cvo/WSKTKrrNnzE/RO
         z37IHpAm5+Zi5P70okqg1dDbW2R5sE5/yrPMbe3LcntP4gB1v4iyKT1Tq2FigEFww+ti
         fJzjC+uyzmmm412hUA/di8kTrgohgoZuthBS0D8eWU8wKFTi+dpUJYxdAyO66DYnlsKV
         5OWlFsDvhFXDLs3EdyHjJWWo/YSovxcLc9A/NZGjxFNJminiG50f920YwZAcV3s1a8iz
         YkVw==
X-Forwarded-Encrypted: i=1; AJvYcCWeQ3/nXDj/Wup9HFAGwuaLCGEbax0a8RBt8YrDSdgbWHFPPT5hPiWcVBRrv8LmF5zq4MmxxJcppDfhcs6XENVqmeDsCDPjMzosi6Sp
X-Gm-Message-State: AOJu0YzPEfvVPugDKHs5b2qUkj5ORDixGuVa/RfPZ+VRb/UiCxgr/2CL
	b5sDezYdCWoFlDtqhO/W3ATyQdx/SCpqHfGRlOXDDFq0UJlBvIB3cP9as5gShhA=
X-Google-Smtp-Source: AGHT+IF1B0nCfAGt+fXGX3owUMA0Hi5Y5naIp5/iV6A4WHwQy1qFb0eKndiXPEm0xY4mUwcKTmld6A==
X-Received: by 2002:a17:906:1610:b0:a72:aeff:dfed with SMTP id a640c23a62f3a-a780b8826b7mr381618866b.53.1720607789980;
        Wed, 10 Jul 2024 03:36:29 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc77dsm146576966b.52.2024.07.10.03.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 03:36:29 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 10 Jul 2024 11:36:20 +0100
Subject: [PATCH 13/15] usb: typec: tcpm/tcpci_maxim: use GENMASK() for
 TCPC_VENDOR_ADC_CTRL1 register
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240710-tcpc-cleanup-v1-13-0ec1f41f4263@linaro.org>
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

Convert register TCPC_VENDOR_ADC_CTRL1 to using GENMASK() and
FIELD_PREP() so as to keep using a similar approach throughout the code
base and make it arguably easier to read.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/maxim_contaminant.c | 7 ++++---
 drivers/usb/typec/tcpm/tcpci_maxim.h       | 3 +--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
index cf9887de96c9..7bfec45e8f4f 100644
--- a/drivers/usb/typec/tcpm/maxim_contaminant.c
+++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
@@ -76,8 +76,8 @@ static int max_contaminant_read_adc_mv(struct max_tcpci_chip *chip, enum fladc_s
 	int ret;
 
 	/* Channel & scale select */
-	ret = regmap_update_bits(regmap, TCPC_VENDOR_ADC_CTRL1, ADCINSEL_MASK,
-				 channel << ADC_CHANNEL_OFFSET);
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_ADC_CTRL1, ADCINSEL,
+				 FIELD_PREP(ADCINSEL, channel));
 	if (ret < 0)
 		return ret;
 
@@ -96,7 +96,8 @@ static int max_contaminant_read_adc_mv(struct max_tcpci_chip *chip, enum fladc_s
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_update_bits(regmap, TCPC_VENDOR_ADC_CTRL1, ADCINSEL_MASK, 0);
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_ADC_CTRL1, ADCINSEL,
+				 FIELD_PREP(ADCINSEL, 0));
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/tcpm/tcpci_maxim.h
index 34076069444f..a41ca9e7ad08 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.h
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
@@ -37,8 +37,7 @@
 #define WTRCYCLE_4_8_S                          1
 
 #define TCPC_VENDOR_ADC_CTRL1                   0x91
-#define ADCINSEL_MASK                           GENMASK(7, 5)
-#define ADC_CHANNEL_OFFSET                      5
+#define ADCINSEL                                GENMASK(7, 5)
 #define ADCEN                                   BIT(0)
 
 enum contamiant_state {

-- 
2.45.2.803.g4e1b14247a-goog


