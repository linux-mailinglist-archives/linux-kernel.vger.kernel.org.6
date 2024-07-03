Return-Path: <linux-kernel+bounces-240018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6E49267EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD4B28DBC1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07CC18A95E;
	Wed,  3 Jul 2024 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0TGKb5gA"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFDD18411C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030510; cv=none; b=gMo2xQW0OLB7IGtlQoohBRvq8NZAzqXD9n2cALw3sUa1W3+TjjpxgzRo4XtH0CvnqsAY7JpyzETPM5qKg0qOqcgCbXQ+y5Hpw5GBwwdfJS38vHiWtc4mtULpZxhequGAONqZQ+sJkgwpeEjHdvgoTcMZsroGhTFsdd+I1oYEk+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030510; c=relaxed/simple;
	bh=Nzm1nEbgG1D0fKsu4Slvc8dGgaXYua6EPR3wbZL6IJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfeNpNoxl3no/3dIc8ay6Rsvu88Esmn3snmNBpGl5rb/PFo5Wy6gxVcShI12hnl4hxYiHfOmSPgynrJcRYLVl/B2wq8cjzaijboJuoJ8E+ErNKOPzAhz8B/cy+Mh8FH4pnUnzTkG/MdiqQsnuGAZa9/r2ieSKoKOddG0SYYaESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0TGKb5gA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42564316479so34998555e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 11:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720030508; x=1720635308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxu9SpdSTVz3ebvxMLh70e0y0HDyyRtIxZX5+1VZmbE=;
        b=0TGKb5gAt2SAnpMGpEjqfITXlMPG60r/lvwJ0UBmC8GfjCkXx66SePUWfPAjjxbfEe
         Jpbt24EN9BF4l3pkuY6xKYUlnUnSrQMf1sJvsFDna0RudrxDA8d3LbnThJ2KQCXj1nNE
         A54L2kuhQNGDZFBgfbVE+rSnybbfJTomrqFoMJUGwOLxXYxBMJRUe+vjNSTcSzqimp9i
         uCBaAHXCvZhHX0+/XixWjqrhVvimU+4rdB/VcnGbKWFjbyrN4WHvzPqsC8lA4n1xpAqX
         8weFX8neOdL5cX7XWtMuh36oSwouo9JcmHMfnh6N5MjntPMi2WjXN7qDM48BughbAR/o
         pjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030508; x=1720635308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxu9SpdSTVz3ebvxMLh70e0y0HDyyRtIxZX5+1VZmbE=;
        b=ir0iViWPnm4EWU59T4MtaOFaDEfx9ft0A5U9ZnoWFCclDapWAOg0MZ73mIzB60ZGZm
         tfek1lE4CTZBdt7mx5lCNOz8VYFWMhYN8CbBpX0fG/1FYJojPhJZlgEnoNRS2qa4efYN
         3nTcvZjSefzrBevKnsVD+++pBW4bEebUkxkNpJt4JOYFkzjy82Sl8zpctsyUY1+edGr0
         en2sABNxh9RakgUx783KYAph11iUGVZGQ2iqSkqaGn4hwuYvsJ/ePJq8KK7dZwR65QPu
         XjRxEbaOCjfTlLeTFSPb5pSN7UF4DBDXtOCs1DWORiWfGJWYTNCBskOX8BHd+OJHNcBH
         e15g==
X-Forwarded-Encrypted: i=1; AJvYcCUi2AxRYmIiepJNuS6Q6h742VuAyc4kYaJAdXOKMRE+w+8zOGZUYwmFmQEDc5AuaMszPUpd3SW7h6oFNgQg7q3/jF+yKEppS5o3KNps
X-Gm-Message-State: AOJu0YyG46332BcCx53svmh1e3mGFlMOedtmudf5sJmePGK18bKAbSs1
	i5tu4Q4fjFFAbZcOY5Nb+zsT/6/rdmGCkdIHumuz9dgtBZqLyShLzS77Aqyp+Yo=
X-Google-Smtp-Source: AGHT+IEjkf41YeErUSmpNJnOMi95oDdVEgwvmMm7MFfhiFw5YUppyz+R82Mw2+TluKNGgFxKSGI00w==
X-Received: by 2002:a05:600c:3b1c:b0:424:a74b:51c7 with SMTP id 5b1f17b1804b1-4257a02180cmr81882125e9.2.1720030507898;
        Wed, 03 Jul 2024 11:15:07 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c37f:195e:538f:bf06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c0f26sm245178845e9.39.2024.07.03.11.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:15:06 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next v3 1/2] net: stmmac: qcom-ethqos: add support for 2.5G BASEX mode
Date: Wed,  3 Jul 2024 20:14:58 +0200
Message-ID: <20240703181500.28491-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703181500.28491-1-brgl@bgdev.pl>
References: <20240703181500.28491-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add support for 2.5G speed in 2500BASEX mode to the QCom ethqos driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c   | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 80eb72bc6311..91fe57a3e59e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -665,6 +665,14 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
 	return val;
 }
 
+static void qcom_ethqos_speed_mode_2500(struct net_device *ndev, void *data)
+{
+	struct stmmac_priv *priv = netdev_priv(ndev);
+
+	priv->plat->max_speed = 2500;
+	priv->plat->phy_interface = PHY_INTERFACE_MODE_2500BASEX;
+}
+
 static int ethqos_configure(struct qcom_ethqos *ethqos)
 {
 	return ethqos->configure_func(ethqos);
@@ -787,6 +795,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		ethqos->configure_func = ethqos_configure_rgmii;
 		break;
+	case PHY_INTERFACE_MODE_2500BASEX:
+		plat_dat->speed_mode_2500 = qcom_ethqos_speed_mode_2500;
+		fallthrough;
 	case PHY_INTERFACE_MODE_SGMII:
 		ethqos->configure_func = ethqos_configure_sgmii;
 		break;
-- 
2.43.0


