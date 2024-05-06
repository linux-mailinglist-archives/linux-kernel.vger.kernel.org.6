Return-Path: <linux-kernel+bounces-170355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3958BD596
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5742812BA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27B715ADB5;
	Mon,  6 May 2024 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCzE4tmW"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B9615749D;
	Mon,  6 May 2024 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024641; cv=none; b=atMrV7bgqns+IcqjeIyMaa7IImTRKE/LRQAdTFXTTDV2TiOsKrCoC5BAAl+5rSRp93sv6lyqgOJ/F9Z5enFFCMk6MC/ZzmGqWib7g/Xyly0cqw3jaZsC6tneIS9vC9i/y+sFkgp2vQksfef4/aT0oJhthJ5mvjXNLnZ/K+e/O5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024641; c=relaxed/simple;
	bh=2I3ypQET8Udotp792qx7UWQr9MVhlBbMPpS0T9SwA9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8wFN6q+WRThO9GQknoY2d4lmSjkHlWOt2TzMaqKm9W3d3AJhWm38Ob8zMxOtpiQnZR7+VVi/lMRy8rp8eegTSJNuFNQalQyz3r8hf3BrTuzFCcnOwrghN92kE6onXNQOUZGA6Etl5W00TQ8+TQsydhnWRH8shHhevh8uyMWfn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCzE4tmW; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59cf8140d0so310416666b.3;
        Mon, 06 May 2024 12:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715024638; x=1715629438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V4nG5Ru4AQ6B28lW7pREyT/j4oSGmxSZ0QdDsskHOqY=;
        b=CCzE4tmWhGCm8wUKZTn8RCkvfpj3NJB2Gh+KpbdcxrrZDMeOhokLesSixCuHmGFK6C
         aPVFyHkJyocKRZM20AfpakMGcGLNfZDfs3OpK0900TUk9FvL54yiJheH5zJNARQbXY80
         0aWztXYBCICfKCSAsq6/MQ8Wa3XSRgGStVsY7OdE1r/yZpCRuX72c/OFBORQXWNnJwZp
         skJpeZPrrwn/oC17B/WSouptYxlyJmkFYEBw1hv1qFEm9yGCnxO0+rB3y+508RTyjICn
         fDafmWewIo9koi8i+QI+Kv4tsJ5B/gtrPYM8au1ATqmG4zipFKFaHolIPjCdZdOzwnVt
         9p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715024638; x=1715629438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4nG5Ru4AQ6B28lW7pREyT/j4oSGmxSZ0QdDsskHOqY=;
        b=noMPbEarIzmbJqvWxjN4m1zFq3vp0ochbUnY1CChKGC0r+u6tLRieDEVAdUGMO9WhO
         oKiLek8nQZKTWI46KvZ+Fv3slSBHJUiajK/EZt47dOQhZuQ4SSNromdkqZKr4Kel19ru
         XnC13S25FX+dR7Ra7flzVK6CD/KLslZIquXUp2afmfagK0Nntf4poFGXvSmU3/aBxTM3
         Bx0wXX84OleFirpsJaDp7fSeiqn13vgDE8vmsmodnWjLx7hUCbwcvGFB7ImM9wBmKYP2
         fsjXdsB0ljRnYTAAswb90nshREfwdk1D0Snl0XTC7P2sK3fKJq4a2+gvlG4nt0aXVLTG
         5aBw==
X-Forwarded-Encrypted: i=1; AJvYcCVBibyVxj9o4vy9hs/JlYgzf6P8wJJ1fpgyCCQf08UIA0S06/J7EMLd/UsnVJw6obMKkVsqR1uvl9Kv84u7SGkgmhPfWc2DsZWQ3dF8eBpTN/geP8C7Ml6Fy5ZOd/ISsK+K/Yr3PaydhA33w23AgQx1D3Dqg62fj5YpnB0R6CI7s8e0RQ==
X-Gm-Message-State: AOJu0Yzb4AEdG6mgXDRr1fRBKz1+VVJ8wxb6RPfKD7+IFEA87JoH9/wB
	8xwklkXl1vvKzzHrwSN+67sWboWlqcdnogREfqQUFqutttI8jP8=
X-Google-Smtp-Source: AGHT+IG5wO/BC2YkyOc0seTpxcAbP5RUVkEbXlDffmS6YgXfw+RgMayivTNE82/BCMH/QU9lmivYAQ==
X-Received: by 2002:a17:907:94ca:b0:a59:cb29:3fb2 with SMTP id dn10-20020a17090794ca00b00a59cb293fb2mr3186521ejc.57.1715024637718;
        Mon, 06 May 2024 12:43:57 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:1c62:e77:6753:5729])
        by smtp.gmail.com with ESMTPSA id f13-20020a1709067f8d00b00a59d146f034sm1367321ejr.132.2024.05.06.12.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:43:57 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 0/7] Add DSI support for RK3128
Date: Mon,  6 May 2024 21:43:35 +0200
Message-ID: <20240506194343.282119-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series aims to add support for the DesignWare MIPI DSI controller and
the Innoslicon DPHY found in RK3128 SoCs. The code additions are rather
tiny: It only need some code in the Rockchip dw-mipi-dsi glue layer for
this SoC and some changes in the clock driver. Support for the DPHY has
already been added when the driver was initially submitted. I tested it
with a 800x1280 DSI panel where all 4 lanes that are supported are used.

Alex Bee (7):
  dt-bindings: display: rockchip,dw-mipi-dsi: Document RK3128 DSI
  dt-bindings: clock: rk3128: Add PCLK_MIPIPHY
  clk: rockchip: rk3128: Export PCLK_MIPIPHY
  clk: rockchip: rk3128: Add hclk_vio_h2p to critical clocks
  drm/rockchip: dsi: Add support for RK3128
  ARM: dts: rockchip: Add DPHY for RK3128
  ARM: dts: rockchip: Add DSI for RK3128

 .../rockchip/rockchip,dw-mipi-dsi.yaml        |  2 +
 arch/arm/boot/dts/rockchip/rk3128.dtsi        | 49 +++++++++++++++++++
 drivers/clk/rockchip/clk-rk3128.c             |  3 +-
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 20 ++++++++
 include/dt-bindings/clock/rk3128-cru.h        |  1 +
 5 files changed, 74 insertions(+), 1 deletion(-)

-- 
2.43.2


