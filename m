Return-Path: <linux-kernel+bounces-266000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CF993F8FA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DBD282586
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794C515572A;
	Mon, 29 Jul 2024 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MQ1hsHbo"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE515154C17
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265414; cv=none; b=plOhYfaXxqpp4WOi6IF8hvPjaPbvoXTZbACrmS0lD9cpBMLV2eLJuDVewsSPJxbgR27JIU90kWua7jb9GyTD4DCfSgHzY2uyeQGEtmPyCmyqxXCKGlwMHsOJ2SRcr/m/j0QKy3jlxQs4nBEy1fZmOzkee+bcypYTMu6wCf8ZBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265414; c=relaxed/simple;
	bh=LixSEKAWirX0NOPhznGfzZIIzCKChSYlVSRBuDE3gCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YbbiBUMkdi2LD8ozZWmdDEAGK25I7fv1y6X2pzneB1MEnTk/+0oW3bBwpTKaAl6HicpqxngO5pcnDaihloW5n6ascq2VVsYwHtmgLU5b7adGeYBpNJ2ZJxSiX1Zbrvm57s+FVO9dHmkhCB1w0+pU374icC3pNRQXDFmM1RruiNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MQ1hsHbo; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f032cb782dso38097371fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722265411; x=1722870211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lGkbzrAqMpJOKzg1gN9QMr+Bs2M7SGlMJ9VaOqKnPoI=;
        b=MQ1hsHboyYlBqO+vsbhDBktxTL/xJ0rl1qSap20TbmZegi+g4xh3qNhFPYWLz3Z7bD
         8hXbpAEPdOMqDHSotIbLC4i4ZSVYx/F77saP7kccsOu5hyvt1a94cAovpce/IrmdA+Ul
         5Lqj8swFJNCHnVzgPmUwQvR9wxZlbdej6xv6p3zaNAbqyvKx9UHy0QZDYH0gDXQz3vid
         eJVSedrtXyhuvM4ov7ZP0D0FcNG+rhSOm0Vk7duNWy1KE/rTNuGI2uc+Tk4SA+Dhfk7j
         IkKJLARfvDlEi9arYERHW5B6DGtS//oxoIUjNeaslvYnrHf4eDGvD1jVNuSv9wRgc4I6
         tDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722265411; x=1722870211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGkbzrAqMpJOKzg1gN9QMr+Bs2M7SGlMJ9VaOqKnPoI=;
        b=pBSWq//Ro1O4Y4oLIoLY3E2Op/jcwsms1IWK72EFDYfObX8rr9lse3ZrceGryWmz+N
         OURFoDmvI0xm+72vY0vEVdvZPDOs8/e9Qs/Lc7Y2LKXWAQis+RFlGOtAb9JXBW4yiIER
         yIB0LYfCuRjD6cm1USrGDMsmU5wDh9sMIuZi8AAWaBmOsAnGgezDqWMVsxLtCUapXCR7
         MQ7Xe38DEOwTpsUHCG7K7UpT9a4T7I4WIiFTWQZYTHL9TH/uFT5jOQmuirhdpzfCfuT/
         cb18D5MbnxwMUJUhXsCHwXNveXUAY9vGGoK9JnyjsJYsW+JqGhA6ZxbK2EqzqdA0S/R8
         PDCg==
X-Forwarded-Encrypted: i=1; AJvYcCUEey4ox45bfFiEzoFVXQdstpOfzN6peA70JvbhJ1y57P+psGX8ZxNid9YKl2NpgVBUrs3dyEbGSfZaqFC12eknIj6jG5L7M/JL5eVq
X-Gm-Message-State: AOJu0YwFREQ6Ff8ew5Vdv1BT1XVvVFqCWIAHlesC+kIELE/iDghUEafg
	nzLfHNWlyyZ148W02CRf57S/uTJhNlSfCWs2V2uqQo/mlx5FdxSRYbqjGDQltw0=
X-Google-Smtp-Source: AGHT+IGk/iWA5wi1P/B8XTv9G4vLUSNAph/qAsd9e1PTA/AJ+yhzpqUakiDFr/71iqFzUruHa/NSXw==
X-Received: by 2002:a2e:7307:0:b0:2ef:26f2:d3e6 with SMTP id 38308e7fff4ca-2f12ee5bd37mr52432071fa.34.1722265410471;
        Mon, 29 Jul 2024 08:03:30 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a777:82b0:b20f:20e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42802e2f525sm111899025e9.0.2024.07.29.08.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 08:03:30 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Antoine Tenart <atenart@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH net v2] net: phy: aquantia: only poll GLOBAL_CFG regs on aqr113, aqr113c and aqr115c
Date: Mon, 29 Jul 2024 17:03:14 +0200
Message-ID: <20240729150315.65798-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Commit 708405f3e56e ("net: phy: aquantia: wait for the GLOBAL_CFG to
start returning real values") introduced a workaround for an issue
observed on aqr115c. However there were never any reports of it
happening on other models and the workaround has been reported to cause
and issue on aqr113c (and it may cause the same on any other model not
supporting 10M mode).

Let's limit the impact of the workaround to aqr113, aqr113c and aqr115c
and poll the 100M GLOBAL_CFG register instead as both models are known
to support it correctly.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Closes: https://lore.kernel.org/lkml/7c0140be-4325-4005-9068-7e0fc5ff344d@nvidia.com/
Fixes: 708405f3e56e ("net: phy: aquantia: wait for the GLOBAL_CFG to start returning real values")
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- update the commit message to mention aqr113 too
- fix the comment in the source file: 10M -> 100M

 drivers/net/phy/aquantia/aquantia_main.c | 29 +++++++++++++++++-------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index d12e35374231..e982e9ce44a5 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -653,13 +653,7 @@ static int aqr107_fill_interface_modes(struct phy_device *phydev)
 	unsigned long *possible = phydev->possible_interfaces;
 	unsigned int serdes_mode, rate_adapt;
 	phy_interface_t interface;
-	int i, val, ret;
-
-	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
-					VEND1_GLOBAL_CFG_10M, val, val != 0,
-					1000, 100000, false);
-	if (ret)
-		return ret;
+	int i, val;
 
 	/* Walk the media-speed configuration registers to determine which
 	 * host-side serdes modes may be used by the PHY depending on the
@@ -708,6 +702,25 @@ static int aqr107_fill_interface_modes(struct phy_device *phydev)
 	return 0;
 }
 
+static int aqr113c_fill_interface_modes(struct phy_device *phydev)
+{
+	int val, ret;
+
+	/* It's been observed on some models that - when coming out of suspend
+	 * - the FW signals that the PHY is ready but the GLOBAL_CFG registers
+	 * continue on returning zeroes for some time. Let's poll the 100M
+	 * register until it returns a real value as both 113c and 115c support
+	 * this mode.
+	 */
+	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
+					VEND1_GLOBAL_CFG_100M, val, val != 0,
+					1000, 100000, false);
+	if (ret)
+		return ret;
+
+	return aqr107_fill_interface_modes(phydev);
+}
+
 static int aqr113c_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -725,7 +738,7 @@ static int aqr113c_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	return aqr107_fill_interface_modes(phydev);
+	return aqr113c_fill_interface_modes(phydev);
 }
 
 static int aqr107_probe(struct phy_device *phydev)
-- 
2.43.0


