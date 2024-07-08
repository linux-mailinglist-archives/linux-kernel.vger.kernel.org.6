Return-Path: <linux-kernel+bounces-243995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7CC929DB4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6779D280CFC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D2E38FB9;
	Mon,  8 Jul 2024 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ScBGe3xI"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E990200AF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425032; cv=none; b=go3+CRIuHXVxk+VbNuY3tV/JKvjFoUAUyjh40KPBP8WBSYSLIitQXG8Oix1aIQOiG6fBxrydKfQ5bwm39J/8XTDK32Z/Bcdw76RKM/2MDIv/LrSPFRZ2phxDv39aFph6UyTYJAqy7RgGGzkvhN9zMGEGcjiazRG9zQkQUa09vNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425032; c=relaxed/simple;
	bh=zlqTiyiSFReaiDoVro5r1Tj6xxCarZuSRspRmcKnFcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hGEm2nXr8pWiX2N4lNm4aT3+pdP9AfRISdDUTRkektQALjkTf36uRDHL9kq5AFVqC11EwjIV2Cmb3VROXGOjIP3PSzrxn1i+0DhX5T1VK9vxkzbECYQxRKKdBvjaEq/fBZTqXVdqLzRF1UKyH8LZUWSFyHhrx06Py6XMiSfrnss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ScBGe3xI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4266381bdf1so9810035e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 00:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720425029; x=1721029829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rL5EmpXsyEHR5xbjqSORtM1Tgm1TFK+MLaWF6mslrng=;
        b=ScBGe3xICf4jsjVwqhrMdU3o8lpMckKla7jGHJ83qMZ3AEeA5HBlbacxsAG04HeSB2
         +ijhlXrZ0PsT5m47UtQq0Xawik69p+xMGz+UuJCa8DcgblIpYea9R+cZmdP+ElYKw04i
         d/dm7wm947wbmvyC7eTPtzegrprA+TTW93CVoQ6dYMXfelpRADJ8nf65wfSZBp5GYlt0
         vqcLoYZoH9cW9OfuDO9MuQe2WZ108CaUIK7USBSzoR7nLFEYKMaB2CIo5dEtKAK+rf3l
         QgC9+SgfTNiAOOipw551bZu3sSCfNF1AtHC2hGNHPjxeCAx/RRV2PQ0V1+hjVBGYrzsA
         aXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720425029; x=1721029829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rL5EmpXsyEHR5xbjqSORtM1Tgm1TFK+MLaWF6mslrng=;
        b=quDMfLb2ZVKBlsNAgrvlRptzcs0eezh8Dgm1B3J0TAVXONbqtxkrgb14WyYJ/nq8y9
         4S2zulCbg4c6+0IP2Q+GRGVfdsmh+TbCgUeP7pC/zFJRLai1lp/cNnSb+ix8LTbPYkIU
         Rfq7j5R69aSP0pbM+/FKZJFuyhFU0n5QmPW79NmUhyhICMD0Z3aWXz943w4YwkcZu02L
         VlASQ1wVpwchayvWhFdkYuEBZ0WryLliZqvDlD+/YocuFKAd9WX39d40nBJ539TDHD6r
         B0Pqfu5b96190wuIOphsNnTSbLbBXZcZmvxJP7WMPmSbLXYkqyrD6l95LfzlCIQGMZF8
         Hi2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9jsQU+xGiBzfD/eRYhavtXwc2eiyxkMde7aO5XsfBf2K4DMQXSOzOxKZZxtyWneaFU7K2ZtbKfB7btL2hplJT7mi5cwgmo+AuH+At
X-Gm-Message-State: AOJu0YwQcRDYPJLI3en79p6v392+ph703sE6udKHU9sdeyQlCu7b7dED
	RzM7e2oIYh6yB7BUCZVwPX3+D7LBItUvacC+8tPY0wkJxd6VWYDWteH4YX4fIj0=
X-Google-Smtp-Source: AGHT+IF8wgRd2T3knWIhdjphcEX1k5ZGI+v30Lz6M0/6seTTCf6NS4sgCajGkmxPTZ7m2e6Ohzxodw==
X-Received: by 2002:a05:6000:1542:b0:364:ee85:e6e4 with SMTP id ffacd0b85a97d-3679dd658b8mr13290035f8f.53.1720425028552;
        Mon, 08 Jul 2024 00:50:28 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b5f9:a318:2e8a:9e50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679d827789sm10160055f8f.76.2024.07.08.00.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:50:28 -0700 (PDT)
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
Subject: [RESEND PATCH net-next v3 0/4] net: phy: aquantia: enable support for aqr115c
Date: Mon,  8 Jul 2024 09:50:19 +0200
Message-ID: <20240708075023.14893-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Resending rebased on top of current net-next.

This series addesses two issues with the aqr115c PHY on Qualcomm
sa8775p-ride-r3 board and adds support for this PHY to the aquantia driver.

While the manufacturer calls the 2.5G PHY mode OCSGMII, we reuse the existing
2500BASEX mode in the kernel to avoid extending the uAPI.

It took me a while to resend because I noticed an issue with the PHY coming
out of suspend with no possible interfaces listed and tracked it to the
GLOBAL_CFG registers for different modes returning 0. A workaround has been
added to the series. Unfortunately the HPG doesn't mention a proper way of
doing it or even mention any such issue at all.

Changes since v2:
- add a patch that addresses an issue with GLOBAL_CFG registers returning 0
- reuse aqr113c_config_init() for aqr115c
- improve commit messages, give more details on the 2500BASEX mode reuse
Link to v2: https://lore.kernel.org/lkml/Zn4Nq1QvhjAUaogb@makrotopia.org/T/

Changes since v1:
- split out the PHY patches into their own series
- don't introduce new mode (OCSGMII) but use existing 2500BASEX instead
- split the wait-for-FW patch into two: one renaming and exporting the
  relevant function and the second using it before checking the FW ID
Link to v1: https://lore.kernel.org/linux-arm-kernel/20240619184550.34524-1-brgl@bgdev.pl/T/

Bartosz Golaszewski (4):
  net: phy: aquantia: rename and export aqr107_wait_reset_complete()
  net: phy: aquantia: wait for FW reset before checking the vendor ID
  net: phy: aquantia: wait for the GLOBAL_CFG to start returning real
    values
  net: phy: aquantia: add support for aqr115c

 drivers/net/phy/aquantia/aquantia.h          |  2 +
 drivers/net/phy/aquantia/aquantia_firmware.c |  4 ++
 drivers/net/phy/aquantia/aquantia_main.c     | 40 ++++++++++++++++++--
 3 files changed, 42 insertions(+), 4 deletions(-)

-- 
2.43.0


