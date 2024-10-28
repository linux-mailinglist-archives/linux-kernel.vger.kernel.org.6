Return-Path: <linux-kernel+bounces-384646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8451E9B2CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41990282AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67E41D3573;
	Mon, 28 Oct 2024 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HLTpS552"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E7E1990AD
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111174; cv=none; b=M9MddoYUBmmwG6ZRhoVZT6efWdZRjR4m/AG7z3uH7xyheKywndQzG1CIpJR4hkqj7u033PtceS2KOEF08wHkXYjBCGAibXlu0ot3eCTajolUklpjViWFipxtmGjdaq6hZRpjuXDayEhjOxsfSsbJ7oqEfvBe1YFUaPmDq9kGj5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111174; c=relaxed/simple;
	bh=Je0XRsrSlkfhC1gNXF4h9w/Pw1MLL8ees5oNHb91sd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SRg2JL5zdMohvFM0ocOsJ5Mfs5F0MZlZS9Z24QekWd8Jjul2DFhLhF7CWrKMzCWhcO/Ar4sVlmyOBA57V4kJnYVJcvukzbv9h0hfTERqgzLjO72jzKEB7JLFe7KMUB0oUl8FPQqFDnVyfbox97GWGvDlWWliiaZboTUIKUsZxBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=HLTpS552; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a26a5d6bfso635018666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730111170; x=1730715970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tjf17nGxadGEosYCdQe1mRaeFLEYOHfj3xwJxxS9C4Y=;
        b=HLTpS552jQkZZB10vKPKMtLZRZXGk/NFO8+BWun9DuiUqfXtI82pTgpqH3ebDic1qH
         V+df77KeC51u72QCPrh+DTCO8ROAaB1TmfvRF7PAGBLvHof7d82dCPIhqD7z8e8zbDCz
         09ADarA9UYfCdRw4UePh5RD5r5oQ1ETM04Q54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730111170; x=1730715970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tjf17nGxadGEosYCdQe1mRaeFLEYOHfj3xwJxxS9C4Y=;
        b=uDGCI1Ll58cHzfSZ5DEt9u3cUDWb7oFp+2U0irytoeL6zETv4FRqzQmEoLTrNW4zd1
         x2so4O4y5471CQHSIJMa8PE03khp2RHv2qbn1qD7gqyw14ImzbAm1tRg21hWqnRXeePz
         rcp+dd1YvlpIdTSDwH21pghpEntYnOxHx5V57x/HT/Jt1RUx/s9YiiO8IcT2/6TkuEux
         qx4R6d/QuVsNG2TyygcfxZOSBSeIVWtBnsIISqJ/ObqOWQjP0ooZK0ZCLWTqAHSuOvyF
         QjA41BeO4ljpb9AsS+4sowCSnLZYcDKQc4mcqzaK6V2b9NGiawLjqJ5OTjE6UmUE+BNr
         uiUQ==
X-Gm-Message-State: AOJu0Yz0MUHGgaL4W5vfWV5F3CRRY7ZNhcuHs9ViTULRvwd+rGxXOrX5
	JuYetjcTtXrythjuvY6/OK8WjxYBl+810Oy9N1FIUHXwTwmRR/56p5HF5D3dsa5wFhv5u6VRWXV
	ryLA=
X-Google-Smtp-Source: AGHT+IH1B0ko3VIpWkPI4RC1oi+MD1rEEYyYDNnVuUIYAatTCka4T6be6wD1IPac0B/RcE+iH3t9Yg==
X-Received: by 2002:a17:907:3f23:b0:a8a:8d81:97ac with SMTP id a640c23a62f3a-a9de5c9f5f9mr669847666b.4.1730111169568;
        Mon, 28 Oct 2024 03:26:09 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.41.121])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f297b04sm363613966b.134.2024.10.28.03.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:26:09 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Inki Dae <inki.dae@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marek Vasut <marex@denx.de>,
	Maxime Ripard <mripard@kernel.org>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Robert Foss <rfoss@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Simona Vetter <simona@ffwll.ch>,
	Stefan Agner <stefan@agner.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [RFC PATCH 00/10] Support simple-framebuffer on imx8m
Date: Mon, 28 Oct 2024 11:25:23 +0100
Message-ID: <20241028102559.1451383-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is the Linux counterpart of what was sent to U-Boot [1]
for the support of the simple-framebuffer for the BSH SMM S2Pro board.

The need to avoid re-initializing the hardware (power domains,
controllers, bridges, display panels) that has already been initialized
and kept powered on by the bootloader has required updating more than
one YAML file, with the addition of boolean properties to inform the
driver that the corresponding hardware has been initialized and left
on by the bootloader. All these properties are added on the fly by the
bootloader to the various relevant nodes.

Support for the simple framebuffer for the dts of imx8mn-bsh-smm-s2/pro
board has been sent with a separate patch from this series [2].

[1] https://lore.kernel.org/all/20240913095622.72377-18-dario.binacchi@amarulasolutions.com/T/
[2] https://lore.kernel.org/imx/20241024102800.3481574-1-dario.binacchi@amarulasolutions.com/T/


Dario Binacchi (10):
  dt-bindings: soc: imx-blk-ctrl: add 'fsl,power-domains-boot-on'
    property
  pmdomain: imx8m-blk-ctrl: don't turn on a power domain already on
  dt-bindings: power: gpcv2: add 'fsl,boot-on' property
  pmdomain: imx: gpcv2: don't turn on a power domain already on
  dt-bindings: display: panel: add 'syna,boot-on' property
  drm/panel: synaptics-r63353: don't re-activate the panel if already
    setup
  dt-bindings: bridge: samsung-dsim: add 'samsung,boot-on' property
  drm: bridge: samsung-dsim: don't re-activate the bridge if already
    setup
  dt-bindings: lcdif: add 'fsl,boot-on' property
  drm/mxsfb: stop controller and drain FIFOs if already initialized

 .../display/bridge/samsung,mipi-dsim.yaml     |  5 ++
 .../bindings/display/fsl,lcdif.yaml           |  5 ++
 .../display/panel/synaptics,r63353.yaml       |  5 ++
 .../bindings/power/fsl,imx-gpcv2.yaml         |  6 +++
 .../soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml     |  9 ++++
 drivers/gpu/drm/bridge/samsung-dsim.c         | 13 ++++-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c             |  3 ++
 drivers/gpu/drm/mxsfb/mxsfb_drv.h             |  1 +
 drivers/gpu/drm/mxsfb/mxsfb_kms.c             | 14 ++++-
 .../gpu/drm/panel/panel-synaptics-r63353.c    | 10 +++-
 drivers/pmdomain/imx/gpcv2.c                  | 32 +++++++++++-
 drivers/pmdomain/imx/imx8m-blk-ctrl.c         | 51 ++++++++++++++++++-
 12 files changed, 148 insertions(+), 6 deletions(-)

-- 
2.43.0


