Return-Path: <linux-kernel+bounces-243998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E07C929DBB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453EA1F229CD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914734D8AF;
	Mon,  8 Jul 2024 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bcc6folD"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADCD3BBEB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425035; cv=none; b=u1gqNWqADnVqxlrSwxE9i55GtScXYjODhNidKMG8xHvFWd0PVzNhYtsEiQa3dz7ovt73sGyxqNatilYuQgqw33hLwIxAtT5lqqc031jwFLBlnjZOqjwdHMObpSYLxWau60CEVy8rUy1MXsTX1UxAwl/nyUkiw1SDLTag8UB36ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425035; c=relaxed/simple;
	bh=I8ZVS0D82/R3RtH++gdSA2BpSL5i3uiqUGmj0KpPRmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQcMwPNsfaZKaxqgo96MlhQFDnio1jYR2eMqaqbXIgImCiIrqSsnkXUwlOF27sLWnC7Iq9h8VW/fFzzSHeTaVR1NEvb+SEvx+M32vlXlX+iJjpLoeOfHzH35V0C2uqfpcdxdPeFDADYeWslxIdNCARgiDQwR7JiBddlKlufd4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bcc6folD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4256742f67fso25286515e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 00:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720425033; x=1721029833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DH3kXkonM31DpQhN/1Hxs8pfB1Bit5q7zwIm1RL/Mck=;
        b=bcc6folDJj1sY3nQvsG6Hz1slvmi+IszcHp3OwgDcz2dOitWgcqcih05h5W7ivgjlo
         Fc4VXFXdk2MJ1aPEbW7+Zp/NrQbaLPZhUiLjg6/u+v8OeLCq8obv422hEtpe8LuWiVuq
         SPDxOotlvvL1GXT1yzseeNNnyn8tABxBnWsvgDeBo8Qs34cMOgsDcpLDXcJ0EV1zRJK1
         mrvjGzTtN02whD4l1WgyRPTBNfyn+MRVuknSD3g8jjPLCMF7DHOVRgynAV4tL8j5FZ5S
         HckPw5xragSqy4YILi+DMSw5ds1OlH4WygbljVdqkNFADPcb6NgCvHPPbFlBR77W+SdE
         yOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720425033; x=1721029833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DH3kXkonM31DpQhN/1Hxs8pfB1Bit5q7zwIm1RL/Mck=;
        b=YAwl+XeLeN2ZlQEDVhpegHoruWY8LHdT0goJ/sdYRHiGdhLSuUqVfBPdsFut/qdovQ
         eE76Hh/b+RfgvXe5LAHMwcvH5G26onPH6lPpMKLzueyzlNYFr3GmNjlGJ6c+3w+B+TNu
         tMM6C6IF3RAm013Ky9k9wl49k9KrxtLp/PcSXvbOFYdBTu+JV3IYAhg2GNGUpN+KpgKD
         2YrwSaZ2UlWSBH4LH/LdKpWkomldMZx5z3ATmZ1vERLxwGfDxcu8ZOR+A9crpEyeJsSM
         C49N1nZa9bqpb71K4JtrIi7uHtPIRfTiP4MAhXaGcWy2z5J45zr13cO/k8ADQ7lb/TMw
         nPkA==
X-Forwarded-Encrypted: i=1; AJvYcCWu4pyHrDTt7pDjDSdhKvd0fejDOe4H7I3Rl0i60pAJBCFrkm1emOwpTqry2DUtsVcQuVajJqo9GCns1UtoYbGPMnhp2O7Rktsks3DD
X-Gm-Message-State: AOJu0Yw4B37D77ZWe7690Y/dq4lKGCW6aPOSA7pHp3rMwYhzd5YZNO2G
	/ic/dlyISXD7t/YUHNSNqk3RaM6vNeC1wfvV31U72lFS7OzztxlLsXlUCEdT4Cw=
X-Google-Smtp-Source: AGHT+IFGHXf42qjKEYiucDNY+VpgnwFXf1LC7psqdBVMRctd1Pm+BjeZFIZfnElzKyJyj7JtJC18Lg==
X-Received: by 2002:a05:600c:1d03:b0:426:6667:5c42 with SMTP id 5b1f17b1804b1-42666675d11mr20254685e9.4.1720425032668;
        Mon, 08 Jul 2024 00:50:32 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b5f9:a318:2e8a:9e50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679d827789sm10160055f8f.76.2024.07.08.00.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:50:31 -0700 (PDT)
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
Subject: [RESEND PATCH net-next v3 3/4] net: phy: aquantia: wait for the GLOBAL_CFG to start returning real values
Date: Mon,  8 Jul 2024 09:50:22 +0200
Message-ID: <20240708075023.14893-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708075023.14893-1-brgl@bgdev.pl>
References: <20240708075023.14893-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

When the PHY is first coming up (or resuming from suspend), it's
possible that although the FW status shows as running, we still see
zeroes in the GLOBAL_CFG set of registers and cannot determine available
modes. Since all models support 10M, add a poll and wait the config to
become available.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/phy/aquantia/aquantia_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 974795bd0860..2c8ba2725a91 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -652,7 +652,13 @@ static int aqr107_fill_interface_modes(struct phy_device *phydev)
 	unsigned long *possible = phydev->possible_interfaces;
 	unsigned int serdes_mode, rate_adapt;
 	phy_interface_t interface;
-	int i, val;
+	int i, val, ret;
+
+	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
+					VEND1_GLOBAL_CFG_10M, val, val != 0,
+					1000, 100000, false);
+	if (ret)
+		return ret;
 
 	/* Walk the media-speed configuration registers to determine which
 	 * host-side serdes modes may be used by the PHY depending on the
-- 
2.43.0


