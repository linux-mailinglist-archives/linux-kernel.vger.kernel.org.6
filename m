Return-Path: <linux-kernel+bounces-240009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CE59267DF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818D028A42B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190851891D9;
	Wed,  3 Jul 2024 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ik5ysb32"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8332186E22
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030311; cv=none; b=JHmICs8fwjrVIJejMYrd2IjRs4F00DpGInF744piBFYJ2wSM1Q2Wr0oOscZGAkY2uG9b35TPoHsVGbKp4PD0j4Qavc7lA2H9lcY+UPhIYtbKFXYLtsp1N3xWl3OdpRlwpEGGmUyV4uAFKEEuyFZlvy/kHSecWNF+wlMw+BFdZoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030311; c=relaxed/simple;
	bh=Ya7JRuOpvI1mc23hT3kq5HyKGwwymGLsHGeOErmvRQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3kpxLIkGrwek9R/yEuEmRAPdhaBQRNs0YilemsFFLhgT2flO867KUbmfmu5BEmuh88QKWooFX9C1/DnUlNov2chwpQ8MRJQZcHVtvV50Dv6kxmgAucjPZzd73dc4E1x3BJIQPNtdKVEOFhwjThUmhvq1aeN5rSK6FRlPeTmgjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Ik5ysb32; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4256f102e89so38969325e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 11:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720030307; x=1720635107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0QRgM6fvt7mWflQHel1qsIOJCVNJNaGUQC7xIWGyMo=;
        b=Ik5ysb32mOl0oXNfXsMaGpmiIGVI98ZJQ+6ckvjkrwcJ8lrvUW03ee8CH+BR4k+ICh
         l1P+5GSbDpcgt6Wku1PP5cH9MjWJcw1MH/G2rygUbXwyec4rdP55fD7z32Iybl5HKGMn
         Z/0hlgLW8jFr5cWmrlo6Qii+I/ASP8l8V0Y9istyTl+MdDdxp26+Lm3umWi4QPrGozXS
         v0a4hOKeE3z6EOC7w+OAUvKLeWX4nVOfPEWPJpO7+FitiVu7A0HAsIKvNwIRXEjT286A
         QoQzFbyDlxziZX0SfcKYRoIcVpMTK2aIRF7y4gd8CV5n0BWMlGoo6ahvZJ1bsbTC8kNT
         +7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030307; x=1720635107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0QRgM6fvt7mWflQHel1qsIOJCVNJNaGUQC7xIWGyMo=;
        b=l2U/55GQWhKvG+rZlWfMU/XKxpMaGpxda5ZbAGRotgYg1yn42vGpLyu8nNUV/ZirJt
         ZbbF29gD67Y5uw/gjrBU375P4GN+Ekoj21fGYXaQi998/Ax5umKHPSfMNjMkHozwj6a9
         n9Akfs2HYaUi6+GEnRN7BC7ZKMTX1/Knbuw/39EcgUTlyUbAVtrPzMRXbN04xJEBNwWs
         zSBG6iMMxcxpSdIkFWPc1JvI/ENS4w476rN7tjl3yeKP4SXIonH7XSEqeRm28B9+ROyz
         HT2/MwlLntSFKoFfOfsULOJcxJeJ0DELY+DWSz/vytxfYLoJVEiylOATHJaSzLKe2VQZ
         t1eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJGrdfIE44AoZQS87y9Rryo2zsotDersiMttjh4jyT8GE9k3QSODl3gGO4B+iQlmoMUpQ5VA/U8ntesWhxSemN327BbUvV5rSgTZ9X
X-Gm-Message-State: AOJu0YyHbYizf+dAAq6wNwa6gcb3NmVLbfIRmjbIE6vP9tnyPqU4oPgN
	hDesB0+RDyWeSpTNM5DiDVw11jl/4icW8L5q0SkdAmp7c3RXjfedp2OHrk1EDd8=
X-Google-Smtp-Source: AGHT+IE9ecYh0TynIiGek+n1mnz5lEz375vFlXm+NaSRncFsOuV60WslfeQFIDqe0ZUtBf/d5YRwVA==
X-Received: by 2002:a05:600c:54cc:b0:425:849c:86fd with SMTP id 5b1f17b1804b1-425849c8732mr60047875e9.14.1720030306764;
        Wed, 03 Jul 2024 11:11:46 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c37f:195e:538f:bf06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af37828sm255295965e9.9.2024.07.03.11.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:11:45 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/4] net: phy: aquantia: rename and export aqr107_wait_reset_complete()
Date: Wed,  3 Jul 2024 20:11:28 +0200
Message-ID: <20240703181132.28374-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703181132.28374-1-brgl@bgdev.pl>
References: <20240703181132.28374-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This function is quite generic in this driver and not limited to aqr107.
We will use it outside its current compilation unit soon so rename it
and declare it in the header.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/phy/aquantia/aquantia.h      | 1 +
 drivers/net/phy/aquantia/aquantia_main.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index b8502793962e..2465345081f8 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -201,5 +201,6 @@ int aqr_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
 int aqr_phy_led_active_low_set(struct phy_device *phydev, int index, bool enable);
 int aqr_phy_led_polarity_set(struct phy_device *phydev, int index,
 			     unsigned long modes);
+int aqr_wait_reset_complete(struct phy_device *phydev);
 
 #endif /* AQUANTIA_H */
diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 6c14355744b7..974795bd0860 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -441,7 +441,7 @@ static int aqr107_set_tunable(struct phy_device *phydev,
  * The chip also provides a "reset completed" bit, but it's cleared after
  * read. Therefore function would time out if called again.
  */
-static int aqr107_wait_reset_complete(struct phy_device *phydev)
+int aqr_wait_reset_complete(struct phy_device *phydev)
 {
 	int val;
 
@@ -494,7 +494,7 @@ static int aqr107_config_init(struct phy_device *phydev)
 	WARN(phydev->interface == PHY_INTERFACE_MODE_XGMII,
 	     "Your devicetree is out of date, please update it. The AQR107 family doesn't support XGMII, maybe you mean USXGMII.\n");
 
-	ret = aqr107_wait_reset_complete(phydev);
+	ret = aqr_wait_reset_complete(phydev);
 	if (!ret)
 		aqr107_chip_info(phydev);
 
@@ -522,7 +522,7 @@ static int aqcs109_config_init(struct phy_device *phydev)
 	    phydev->interface != PHY_INTERFACE_MODE_2500BASEX)
 		return -ENODEV;
 
-	ret = aqr107_wait_reset_complete(phydev);
+	ret = aqr_wait_reset_complete(phydev);
 	if (!ret)
 		aqr107_chip_info(phydev);
 
-- 
2.43.0


