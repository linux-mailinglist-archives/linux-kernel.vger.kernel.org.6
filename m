Return-Path: <linux-kernel+bounces-548756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFBCA548F9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 245737A79FB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493D120C46C;
	Thu,  6 Mar 2025 11:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tKdmZ+uA"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFDA20ADD6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259767; cv=none; b=Gtu2avIhcmT47pKevM21Usrd6p/gloSsUSzJIrrHxx7Xt4SPtYj2xYAQMzXRS9ivieXzCC+s06S9pwgJQsjJuilH0OMriIiZoopvyeTcX5jhXqiYlKmtTi2Jz8E3Zo9P5Zus1g5q7mN2ntqEFovvWSz7RqM/uqrib/ZrB4P0xMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259767; c=relaxed/simple;
	bh=mSNYgSWj+YADxcJYTld46k4BIENA6g6D+Jdi+6l+eLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ugbt1aKXSln/XSXDvsnM2JtFNYCJwTAsh5/uqfZaMUou7LiuqtaG54X4GakImHX5iyXrA02CAnuZKSLjZ23nGeqj3MYVp1IDmKOrtyp1Ob8nGq9UO/GJL8oT7qQ0+BYdPPfREMOCSWiHQhW+C8fmbH3Jy5XXqbZzrR096hbuo/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tKdmZ+uA; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abf6f3b836aso82323566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741259764; x=1741864564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5B/1MAbm7XWDn7sksBQeFE3Zfzb3mpfhe3LWfzUyF0=;
        b=tKdmZ+uAue6jblcWA9Epcjfh9HOiC1PvwGoEaQMYQ+1x8QoJIFUUDGWfMf80oXPPd1
         qk9dOKEPe+wAwKqErMItQdoTRevdyPFdSyQ9uCTrxPUeDkFlIDX+u0m7OTTxz/LJ/fO/
         UY3jjBKdKZzxdbo52SEhkq7GOIXH5WLnGnyJ6L+mUx37PBbF4sYN38pJs3UpTVzrUbAf
         QI37HDtKWL0YEJckeMbh7ZbYccNVyEWVc6prHUwbd6QE4xZ/FCQDC5LIDEpLhDR4i5sG
         objmpJs6Oos7NejI0v5D3Uvhfdmg6uEBP0fkVP5OyLl7SplqM4vk4fsnqKmTMoqiLKBI
         j6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259764; x=1741864564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5B/1MAbm7XWDn7sksBQeFE3Zfzb3mpfhe3LWfzUyF0=;
        b=fi5SowXq0LdCqZVo1Z1/tq99tP1eaxFHMafl+CHwkTFO/K1ZIvT6xmjgpPPCXrxkNz
         YI0lwixoA1AAfVyRdUBz1Li/pFJTudKNbMwpjrl9sbVlMpIF3HMFoVN5Uszunlu+hP+K
         b9umBPiOubPSrTw+CWHE5izVp/IbWSCNJsTZ2ApeCgrze6WZFfVfer1wQjXDO6oTz96a
         GHCd+geJueUFu6dp4kFDX5CgYc7POWEaYt5JLJWcJ+j6hETgJvJf8W2shRwNQGK63Imt
         fcRzmQeDNrz8D6PnTqqQxF8Bh4WhbPt+X4pPxzA9IvgdK8MITu81adubHuYbUweONFe2
         FdoA==
X-Forwarded-Encrypted: i=1; AJvYcCXRsUWe+WXO70DiSc/uD+Chb4c/lx5VIuLMGQi6JwwPTAvh5U0fNKq09+yVzg01wLUmUitXWLbqV5bipFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhpD7c2yXtDFfCa/4TRHwqmmdzdA17+cY9aTG/M9Ig7vO7iSH0
	aPaxgQ3h2UN84UzuLgDk+NwgoqL5QqlyTaOAoKb8g+5paRGR8EewkeBIFnCIpnQ=
X-Gm-Gg: ASbGncshn7OrfjbO/9JcMdPKTM/bLIlC64OF/Pfhk93esPadQOHLAFhtucOszM1wDTG
	ABJMlXpm9fCaSqz2B0ixcMgm7BIPy9B8pxH4z814IunS++jkQomgvQiQ4SRznG21giaTXGgI+h+
	UvMjU8fTPsfA8dGz5U7BqOhOBRp1PFQm8+mNac2YxoF6//dWk9UIyu53GLlf3fPt2UTWNc88pfa
	sUMBomunDbdvXJRsL0DInupvCy2RPxZa78aNBDJoZ/VUW43X3vNvWFlstVFhe8CiM1yGafhgTEu
	KAP+mkOubBNVbw+lqyWXVrV1BFB461NdMqd9U/ZX+w==
X-Google-Smtp-Source: AGHT+IGEsRF+ZuhCrECUeqOSfOd/YhlB/c+V8tdTbUibcDVmAxZHV2uaYCpCEp4a4SsOt6thlQaVKQ==
X-Received: by 2002:a17:907:3f89:b0:abf:3f82:1218 with SMTP id a640c23a62f3a-ac20dd0539fmr697232066b.46.1741259763526;
        Thu, 06 Mar 2025 03:16:03 -0800 (PST)
Received: from localhost ([2001:4091:a245:8327:80ad:8144:3b07:4679])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac2394399aesm78672066b.30.2025.03.06.03.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:16:03 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 06 Mar 2025 12:14:44 +0100
Subject: [PATCH v5 06/13] can: m_can: Support pinctrl wakeup state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-topic-am62-partialio-v6-12-b4-v5-6-f9323d3744a2@baylibre.com>
References: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
In-Reply-To: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anand Gadiyar <gadiyar@ti.com>, 
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Kendall Willis <k-willis@ti.com>, 
 linux-can@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4086; i=msp@baylibre.com;
 h=from:subject:message-id; bh=mSNYgSWj+YADxcJYTld46k4BIENA6g6D+Jdi+6l+eLo=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJPNh9psOCQeNLEOCn+b9SePUt9tki7Hto5sTxt5WbzS
 MFGOzufjlIWBjEOBlkxRZa7Hxa+q5O7viBi3SNHmDmsTCBDGLg4BWAiiQmMDGv+Cuxsuy9m4Bt+
 5bq2c0U4p+yipf2Kv94uemPBsfXvuSuMDM2GYXFdIh8YnRnetSdYFXOIHROwcC0LWJR/88vTsAs
 uvAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

am62 requires a wakeup flag being set in pinctrl when mcan pins acts as
a wakeup source. Add support to select the wakeup state if WOL is
enabled.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 68 +++++++++++++++++++++++++++++++++++++++++++
 drivers/net/can/m_can/m_can.h |  4 +++
 2 files changed, 72 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 20fbef50db20ab5cea5afe4c44fda8b03e5c8c85..c1c5f8e90d37cde1daa8ab17c2be4b8be451dc50 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2233,6 +2233,7 @@ static void m_can_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
+	struct pinctrl_state *new_pinctrl_state = NULL;
 	bool wol_enable = !!(wol->wolopts & WAKE_PHY);
 	int ret;
 
@@ -2249,7 +2250,28 @@ static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 		return ret;
 	}
 
+	if (wol_enable)
+		new_pinctrl_state = cdev->pinctrl_state_wakeup;
+	else
+		new_pinctrl_state = cdev->pinctrl_state_default;
+
+	if (IS_ERR_OR_NULL(new_pinctrl_state))
+		return 0;
+
+	ret = pinctrl_select_state(cdev->pinctrl, new_pinctrl_state);
+	if (ret) {
+		netdev_err(cdev->net, "Failed to select pinctrl state %pE\n",
+			   ERR_PTR(ret));
+		goto err_wakeup_enable;
+	}
+
 	return 0;
+
+err_wakeup_enable:
+	/* Revert wakeup enable */
+	device_set_wakeup_enable(cdev->dev, !wol_enable);
+
+	return ret;
 }
 
 static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
@@ -2377,6 +2399,44 @@ int m_can_class_get_clocks(struct m_can_classdev *cdev)
 }
 EXPORT_SYMBOL_GPL(m_can_class_get_clocks);
 
+static int m_can_class_setup_optional_pinctrl(struct m_can_classdev *class_dev)
+{
+	struct device *dev = class_dev->dev;
+	int ret;
+
+	class_dev->pinctrl = devm_pinctrl_get(dev);
+	if (IS_ERR(class_dev->pinctrl)) {
+		ret = PTR_ERR(class_dev->pinctrl);
+		class_dev->pinctrl = NULL;
+
+		if (ret == -ENODEV)
+			return 0;
+
+		return dev_err_probe(dev, ret, "Failed to get pinctrl\n");
+	}
+
+	class_dev->pinctrl_state_wakeup =
+		pinctrl_lookup_state(class_dev->pinctrl, "wakeup");
+	if (IS_ERR(class_dev->pinctrl_state_wakeup)) {
+		ret = PTR_ERR(class_dev->pinctrl_state_wakeup);
+		class_dev->pinctrl_state_wakeup = NULL;
+
+		if (ret == -ENODEV)
+			return 0;
+
+		return dev_err_probe(dev, ret, "Failed to lookup pinctrl wakeup state\n");
+	}
+
+	class_dev->pinctrl_state_default =
+		pinctrl_lookup_state(class_dev->pinctrl, "default");
+	if (IS_ERR(class_dev->pinctrl_state_default)) {
+		ret = PTR_ERR(class_dev->pinctrl_state_default);
+		return dev_err_probe(dev, ret, "Failed to lookup pinctrl default state\n");
+	}
+
+	return 0;
+}
+
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 						int sizeof_priv)
 {
@@ -2417,7 +2477,15 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 
 	m_can_of_parse_mram(class_dev, mram_config_vals);
 
+	ret = m_can_class_setup_optional_pinctrl(class_dev);
+	if (ret)
+		goto err_free_candev;
+
 	return class_dev;
+
+err_free_candev:
+	free_candev(net_dev);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
 
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index bd4746c63af3f0a032910644dfd48a9ebb3a6168..353ad73649218dc0a03d9ba947c6abc847c958eb 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -128,6 +128,10 @@ struct m_can_classdev {
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 
 	struct hrtimer hrtimer;
+
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pinctrl_state_default;
+	struct pinctrl_state *pinctrl_state_wakeup;
 };
 
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int sizeof_priv);

-- 
2.47.2


