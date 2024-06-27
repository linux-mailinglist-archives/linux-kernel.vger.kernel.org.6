Return-Path: <linux-kernel+bounces-232231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2876491A57C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7351C22736
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776681514EE;
	Thu, 27 Jun 2024 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KtcJVRIy"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8F8145A1F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719488401; cv=none; b=CCE4MPEl5/v1YVzPoPq18XVQtA8j5AC1ZX3qBwbaWd5kwzFC8Tau3IA6sTCtIbySN7rObqUQ3wDf0F3WZ6LdGxjJGy5HJXsCobAFimlBvx8JhignU2FJVymwkEGyqrGMQOQZJOc6lWG03mIk3Xx+jQSZy7HPqPyd9QsVmZy6gmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719488401; c=relaxed/simple;
	bh=Nzm1nEbgG1D0fKsu4Slvc8dGgaXYua6EPR3wbZL6IJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GktlFjvD6xFChH1o/Up500ZqlSZ3mKg6yk7LGDGFXRwnhVi2JEmkLRein/FRgmPgfXDh2e7jcG9Pl/Cj5PrD0hEnXjfncawNItwRZ/h4eVDT1mBJ3PGYGrhOsIpe6S3fVo8U1pOWxH2m0YKtTvJh2ipjDpDON4yspwdg618iViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KtcJVRIy; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec58040f39so53343051fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719488397; x=1720093197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxu9SpdSTVz3ebvxMLh70e0y0HDyyRtIxZX5+1VZmbE=;
        b=KtcJVRIyTDj3+PsuJ9LjDtUeoh7Ila/Kh3xkxhkonNMcc3R2+DtiKqj3Sid+mwOcF/
         3FNAEzeCzN9a14vPtFf3nhd4uwV08pRuFy25g/mSFIqoBdBvoH4e89c8dD8s6cUG17EV
         VNxXFSl/JaOPa3ZKuY6UTEjvn09CofREFvUIA7UtD3ZvQTM660cwWUXiZYByAbzpS/y7
         Od/MJ9XpXgUQvh8e6IEDWZT5nncR5EojuWnheVBnHRIZskmF5000A7TQ1rpKz0eJjIzs
         MzEG3uyiC8KvqDyNBd32Dj3i4GcLQp6j+ZRlM469CL25agbkSYw0RY394UnjVBC5hhOJ
         /tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719488397; x=1720093197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxu9SpdSTVz3ebvxMLh70e0y0HDyyRtIxZX5+1VZmbE=;
        b=HlVhIjUcOMYofkmaSeJFfPGx7w9vK358xymVRsKDYqOaVnDYtwBMp/0lL7PkC9So+s
         FTpc1CBB8zOM72dnqSvZogr8OoVXxN/XIUX39RPfx4/TkrAApYG5wP1Nq9lED1uB03e9
         7jUrgrbnFusmdQRX8q+9OZOP3TQ6vUrc13LLZoa0IF2F9/suYx+m/LzB+peAUKwV5ISk
         0j1p1WgH+F/jQlP3BvkGpHhs5M2AX0/ESxLJAX9gsHCoAZ+QCuwXESE7cbWymsAZFwQr
         ftrNqMIR1th/89stbNnCb8lFPnjldwYTPJSouHA6Lh7T4MAn9qVk7gyHJhT7EZh8aVt8
         1YEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJs7lzd/0OeZ44S8BIeTwmjVnvmAugvkCORSb17gyqfu06zZtmT9ArlBYJIVqRqrfMXTe5JbnjxBvI+LQWNDuEs21e9a9G1EYX/SNG
X-Gm-Message-State: AOJu0YxPqU0IwTgOdJ57AcunpER3n+gaeOKtWuBLVSkZtUVzDZXOa0Y6
	c2pIM2qgnm4tLwtGczQyUCrfVQEqxAUai8sbjJA+0S2kWi5QrPEoyn/3yH9AmtM=
X-Google-Smtp-Source: AGHT+IEX942vNvyHTmy9tspQQQL/qKLX+sbQ4RkDTe+pTb3TOEUopxyuIw7WbECrr/t329Hui5TQGA==
X-Received: by 2002:a2e:8047:0:b0:2eb:ed3a:9c65 with SMTP id 38308e7fff4ca-2ec593d93a0mr77254481fa.15.1719488397179;
        Thu, 27 Jun 2024 04:39:57 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7fe5:47e9:28c5:7f25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8468613sm62081815e9.39.2024.06.27.04.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:39:56 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Vinod Koul <vkoul@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 net-next 1/2] net: stmmac: qcom-ethqos: add support for 2.5G BASEX mode
Date: Thu, 27 Jun 2024 13:39:46 +0200
Message-ID: <20240627113948.25358-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627113948.25358-1-brgl@bgdev.pl>
References: <20240627113948.25358-1-brgl@bgdev.pl>
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


