Return-Path: <linux-kernel+bounces-174467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAC58C0F32
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3498F282BDA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2B614B951;
	Thu,  9 May 2024 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwDh+bNe"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8491018E0E;
	Thu,  9 May 2024 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256445; cv=none; b=YD2StTvEvmq98CU17R64jH2bNCvBygLQzv1dwCkIAUETbOnbEgXbPltpbQRXE36sx99l1Dv6h+fPyc4C8LMLQZAy3qc0Lv2Q01vjBz4xcfjqgArKiHadsRWNnb7tMwffkaWM6HTG4H7ZrDiGjFBsbkPsvrpApyaxepEB/UITqBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256445; c=relaxed/simple;
	bh=H5tnMMMo1fgthWtk1i8YGaD+9JAHegwdlrrPGOnzJNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3yT7BZb8YW4lhMAoGPnXQj+uYvhGJBNJNAePeAGj63aHXoXDLlUGGSzUovrAnoEX5lQ61UbhltLedd39kXVURKjOp98icbuVcjGC9sVJqfjWAfcRwgYO6u/yiq19IScKdwW149bYZdf8HfHlozzxVb6uX3zQLIpEtFt94lX+ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwDh+bNe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41ecffed96cso6413105e9.1;
        Thu, 09 May 2024 05:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715256442; x=1715861242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wXW0NpQxST0KcyNsoS559akCnXX6lhKBOvqAS2ZY6IQ=;
        b=mwDh+bNeHOuIKA/HU5aJA86WDjmUluiUXnrvD21fPR1HCAlC0k2IYvMQUjgb/bexEO
         dF0t5WJhRPizojyy+hGeetCfQhg0CHyQR5xYYQPOpAjseKfJ1zjP8bI4p0QO/69YS5v0
         LPpaFZoBgf+uUJaCpTixbXkJXHxfGzqy12BjjDJ3Lv/MrKDLTy4w5hVBA6G8vOETCe1Z
         lI3Ifk0SjjLSb9GkHAEAyN8MBSr+fjx8Vc02z+bMGmIVPZ2FXOg3LUr4bE+WzbxrUwD9
         aEr8hI/NDu5m76fA9dtQexKbjEgJPQ/UU5nYcPIGggfcUkzcwNEGIpqOhMzYxG7ug15K
         Zvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715256442; x=1715861242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXW0NpQxST0KcyNsoS559akCnXX6lhKBOvqAS2ZY6IQ=;
        b=jIkeuG91dXlOekyT65S9xapkAkusmZ/Q1XMuANUqPEuHVuZzwmFCmS3drnfpZiFm+I
         QxvlOevpd1rPB4wBqvdFz5hVn1UETx2+YLGGq7FpO75pS9cI5VEn2GXYWufs32QiLsk4
         EBJboHEvVkKLjQ8HV818qg1yMao2dLmhtH1bNFYHTzlUHIPUWrYyE4vtbqHwwwgN6r0Z
         X7crBT81G5TN4aSxZSSFbNT05JH/gBbEd9OeKa/l/ieFTwhsVHTY3a01AcR5uzHcV7+n
         3fj+GMZDSyjtxB7IAxn/2Rwd99Swcv3/I7XfP+WRxNd0M9TcAcxtP0ksUvtP1v1bB2dK
         nStg==
X-Forwarded-Encrypted: i=1; AJvYcCX4OHTIFB36QbmVYmwiPxz3KI5fD0wy89FlnY3jYvt5isbvjvzQ9Lg6GIfMY82gsgLmoDO6xP//ToyvzRAIRXjvAoK4De0eUZL6/40+/qvelwjPuFysWben0ZUn36SluRH+9o2go6LPR8eogp/N3hN4H5/LoNyCd8EmeeqHLw2b1961dQ==
X-Gm-Message-State: AOJu0Yz2HMMSp2qcWM3+F2znz201XjJW90RY2oopfg0v222ymu2DYmYB
	K5upoSYEDLPKWJ9wDg/wfWyY3DcRIsf4PvNAC3z0QNog2YnLx88=
X-Google-Smtp-Source: AGHT+IHiTcqgDtLhCAgVy2xR30nYXqmOfWtS5RaJG90R9viY5LmZtTGSnjgy7WvJDU+f7B9EzWGwWg==
X-Received: by 2002:a05:600c:348c:b0:41c:1434:f571 with SMTP id 5b1f17b1804b1-41f71ad0a6amr46179165e9.37.1715256441686;
        Thu, 09 May 2024 05:07:21 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b44:d8c3:6fa8:c46f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce1912sm24112005e9.11.2024.05.09.05.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 05:07:21 -0700 (PDT)
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
Subject: [PATCH v2 0/7] Add DSI support for RK3128
Date: Thu,  9 May 2024 14:07:08 +0200
Message-ID: <20240509120715.86694-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series aims to add support for the DesignWare MIPI DSI controller and
the Innoslicon D-PHY found in RK3128 SoCs. The code additions are rather
tiny: It only need some code in the Rockchip dw-mipi-dsi glue layer for
this SoC, add support for an additional clock and do some changes in the
SoC's clock driver. Support for the phy was already added when the
Innosilicon D-PHY driver was initially submitted. I tested it with a
800x1280 DSI panel where all 4 lanes that are supported are used.

changes in v2:
  To improve power-efficiency when the DSI controller is not in use, I
  dropped the patch which made hclk_vio_h2p a critical clock and instead
  added support for an AHB clock to the DSI controller driver and updated
  the bindings and the addition to the SoC DT accordingly.

Link to v1:
https://lore.kernel.org/linux-kernel/20240506194343.282119-1-knaerzche@gmail.com/

Please see individual patches for details about the changes.

Alex Bee (7):
  dt-bindings: display: rockchip,dw-mipi-dsi: Document RK3128 DSI
  dt-bindings: clock: rk3128: Add PCLK_MIPIPHY
  clk: rockchip: rk3128: Export PCLK_MIPIPHY
  drm/rockchip: dsi: Support optional AHB clock
  drm/rockchip: dsi: Add support for RK3128
  ARM: dts: rockchip: Add D-PHY for RK3128
  ARM: dts: rockchip: Add DSI for RK3128

 .../rockchip/rockchip,dw-mipi-dsi.yaml        | 25 +++++++++-
 arch/arm/boot/dts/rockchip/rk3128.dtsi        | 50 +++++++++++++++++++
 drivers/clk/rockchip/clk-rk3128.c             |  2 +-
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 45 +++++++++++++++++
 include/dt-bindings/clock/rk3128-cru.h        |  1 +
 5 files changed, 121 insertions(+), 2 deletions(-)

-- 
2.43.2


