Return-Path: <linux-kernel+bounces-174566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CD68C10D8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8B62831C1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6547015E1E6;
	Thu,  9 May 2024 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzbHWYQI"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154EB15B120;
	Thu,  9 May 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263619; cv=none; b=gQ8k4hMz0eFsyi1AZ7sIHKsGnuSHhd/fWGWBfM7dI+W7RY5AKXjqUwbcCWJL4xhktP22tNA8hFH9SA9ahjv44mj8BLSYZfbaF/HS/0CA7QOfbwOY0ADGlnu9L+yiQR9mOJ1OaL2DTgK4HqFk6b+e/CAii8fYYb2l5JsXabeXI/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263619; c=relaxed/simple;
	bh=cOoaeffNqgYSpa66yVAcVPa2PM0favsqNw+tl7uH6GA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WpSALIktpPzE5CuKtCVHbDAxORWoGhV4/7VY6WwM/RGs8sg0kQx3w64o1qQh6fT4y2Pdd1Me61LswBuGAEqJrZt5R/3g8EnWJm7nzDHyY8AuoYl4zJmVGc2OGEH6OnQmAy5dGMSoaSG28KLTL6yIFJUUcD7JN7RDK9QaQ9Wb/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzbHWYQI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41c7ac6f635so5843485e9.3;
        Thu, 09 May 2024 07:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715263616; x=1715868416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ygKOaLULm9Ty8/azGUq2u8NIEd5rcobuUSoqUbVVSBY=;
        b=jzbHWYQIRiSwFBTKo2cRWISebNAbbdgEIUD4h3fI/5EDa7Ty+lWEWVn8lqkPoYvY4j
         pwYE756rSBSrE36o0oEN8YKxy5Jjm8FkS3lBc4xjgiAhby8S4ep/q/zWuxP2ig1exFPt
         d4m/xjq7Odx2rIz2B2CGmZsS2/O+xTA4L9wf7/CXntLU1/xsGK7AA41QJKsP2+DXaftc
         CigmZ6V5vji0BfCyoH3kEQP3juExA2qfaBSni4VUE+4fgJwo8VIRNhsJCzbTb8NznZfo
         Fr0AKQPsb55xMDUXVBoe6SP9n5Uz22U6HU4U7XfBzcNGnObTMw+tZWJHj0CkfrkyBuNG
         d+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715263616; x=1715868416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ygKOaLULm9Ty8/azGUq2u8NIEd5rcobuUSoqUbVVSBY=;
        b=KJyCE/om1twXiGMjV098kmY2tPoOMEhiUePqGNHk7y/WL3YeqmrOlnPQBFkKOiLsy7
         NmIEnx8vK6hy3yJIRlLhmOIcYo2FPVi+B43myOlQRApvN3Wy8X0cVGakl4fznhDHWJfX
         Rm1K+V0ccEUwcUnNtDMQA0f/+W99kYjHAo5DSaMvj7tAGZTJiVr5oa0RgT5TPXraUYEV
         k8liiEHfODMlV2UmHJ7mNUy8nUWAqefS9qqm8I64eM09QAAjo7Vj4YE0zjIU+O1+z4YM
         DWGNjUxC5w/7xfYTZtSL2+M8WCpCuhV4maT01KrmfW/wAYXbVbClSalD/Ghz6a9Hqm/4
         U+6w==
X-Forwarded-Encrypted: i=1; AJvYcCXxDHUtZJtswUwqrMTWXAN3uUBMlIgEyOc5RO1J6tpxJsWjTg4ZpRAR5Icp4ghJdCB7A/Fu+CdUGs2Xs0UsOUHlbYT0CdLmsTTeUX+7tjsch6iIegC9awzsQMm1Vnz3x0QsG/eEevQyMx9KLiTQ7vQFMVEEgaZJk71zOzUb7v1cnaLJqQ==
X-Gm-Message-State: AOJu0Yw5Sh+yb9HCejBgUug77RkDQ6Bwk+wSyVH25L/Pl8eONLeOP6j1
	MkBR+hDhiMasAvA46yNdOeZe+djDvTsqgIeF6JRKWT/cc/sdeF8=
X-Google-Smtp-Source: AGHT+IHVkPjBZZWpO88u2YrMojjQRZm2+OXl2pDCRbpsX72BfqrrTJABv2eO9OkV1+awudthPDrRNQ==
X-Received: by 2002:a05:600c:4f0c:b0:41a:8b39:8040 with SMTP id 5b1f17b1804b1-41f71ec26d4mr53830265e9.20.1715263616318;
        Thu, 09 May 2024 07:06:56 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b44:d8c3:6fa8:c46f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad058sm1793311f8f.66.2024.05.09.07.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:06:55 -0700 (PDT)
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
Subject: [PATCH v3 0/7] Add DSI support for RK3128
Date: Thu,  9 May 2024 16:06:46 +0200
Message-ID: <20240509140653.168591-1-knaerzche@gmail.com>
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
this SoC and do some changes in the SoC's clock driver. Support for the phy
was already added when the Innosilicon D-PHY driver was initially
submitted. I tested it with a 800x1280 DSI panel where all 4 lanes that are
supported are used.

changes in v2:
  To improve power-efficiency when the DSI controller is not in use, I
  dropped the patch which made hclk_vio_h2p a critical clock and instead
  added support for an AHB clock to the DSI controller driver and updated
  the bindings and the addition to the SoC DT accordingly.

Link to v1:
https://lore.kernel.org/linux-kernel/20240506194343.282119-1-knaerzche@gmail.com/

changes in v3:
 Dropped the changes for the additional AHB clock for the DSI controller,
 as it's not part of the IP block. (Heiko)

Link to v2:
https://lore.kernel.org/linux-kernel/20240509120715.86694-1-knaerzche@gmail.com/

Please see individual patches for details about the changes.

Alex Bee (7):
  dt-bindings: display: rockchip,dw-mipi-dsi: Document RK3128 DSI
  dt-bindings: clock: rk3128: Add PCLK_MIPIPHY
  clk: rockchip: rk3128: Export PCLK_MIPIPHY
  clk: rockchip: rk3128: Add hclk_vio_h2p to critical clocks
  drm/rockchip: dsi: Add support for RK3128
  ARM: dts: rockchip: Add D-PHY for RK3128
  ARM: dts: rockchip: Add DSI for RK3128

 .../rockchip/rockchip,dw-mipi-dsi.yaml        |  2 +
 arch/arm/boot/dts/rockchip/rk3128.dtsi        | 50 +++++++++++++++++++
 drivers/clk/rockchip/clk-rk3128.c             |  3 +-
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 20 ++++++++
 include/dt-bindings/clock/rk3128-cru.h        |  1 +
 5 files changed, 75 insertions(+), 1 deletion(-)

-- 
2.43.2


