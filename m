Return-Path: <linux-kernel+bounces-382217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322EC9B0B16
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A474A1F20F1B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3237F20F3E9;
	Fri, 25 Oct 2024 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="W8hyX7q0"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A138B20F3DA
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876566; cv=none; b=YmwzQN9snmDQy71kG2m38lG9LgB5YAe8SYHDHsPhk//33IRJ89+lQARWqq31y+iwG6whddrp6TpXGha0kVA4krHsQ1dnr0o/k3laVuwVwnMzAnFnZ3/SEPZr+ZiZWC4UyR26lkg3uNZ+iPOQRKq8xcXoSTg8+U/ao9CmtkcY/u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876566; c=relaxed/simple;
	bh=MgkkUcMYNnVDxl5Ht92rDmj1JTcqFQYUlxNOYOSYbIQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YDfBsspfJ82MI1oCm2ioCrFLjV485a/lUKTrOoqDl5XcmSqRb5eWNmru+JEw2HDxaHG7BLmnhKsNXuEfyRVIhF3nmE6UPH98TDZr5QNIE6OEKKetvC7/pVhluzbw+WRftIjCChij6FDf021SKVSzISYqdkFOA9CR0MQum324Bu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=W8hyX7q0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315baec69eso22729465e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729876561; x=1730481361; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D8BkQHxl/jl98jZceXhfQCyyW7/L0TBeWdJpzjggPMw=;
        b=W8hyX7q0+Wx9tp8hYLL7dtfDN2miUkap7mH4vzTbdblaG5+rO6oIzyA4zOZ9iRmlqA
         RkB8ueRzGgqG20FdVeQkF1YjKSfaDbbcaxxaA9zgcZ0X0F4EI0AWoCf9ihapEMs9L3uX
         bXINBmUNjuq4u3UFOlSuTfQwQiGMAnt0iA81m1wTj1kxuEnINMBoryE3ZVrTW2+oJvgN
         l1csIDpePNKtE9LXg/w+ZBA1zvei/vJnC5WjcHFwB89XGYRDIlIRptaGGLZ02Q50g5IT
         p72+Da4JoaAVmsz3ircPYxlhrb+j2bw/t6r4ZOpizEJBd1VD63W+zmGS52rX/fvKxu0V
         yoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876561; x=1730481361;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8BkQHxl/jl98jZceXhfQCyyW7/L0TBeWdJpzjggPMw=;
        b=WBLYqtufBJqvStXGuaICxrYqbUQNtVQloIYcBcG3gRAZ5JQOr8d8mrtX8qt15f1PNj
         Q6Ret96VnbWQ1G4OTBZEt37VK5lPdmB3//k16hvESq7x45Wl54CV2htFxl01QYHmoOaB
         914IWUfLedVwCgSWTSPzIBtwhUMrvEYAe58yV9+99UWZSkKxsU7XFVQnIdITCVeMroku
         haXlm2ZaIxiAjEenduBsVQcsmpYTHJTv/wsG83mzMBLX7OqRTETEPM1BJa74EAbMnriV
         F00u+5/67ETgAMwJhipBc0flSV8kiZ28knHXT6XgfIzx5Uawz9Ckpcm6SXghJlsqQoUk
         a7LA==
X-Forwarded-Encrypted: i=1; AJvYcCVIB7LNxcyXFjeIDvhTkfZ0quxee9+txTLqLpKIafKKd/ZDIamfMjfxuPAlAfPn67JLq+/GijSZVplHMmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHR9Xdp6e5ueiVkNNzW/eCW+A1MVQVFsl9JqQR3PTSQso6t4i/
	YBFxU5Edi/yAfdu/O6wDct1ee6kZVn6vbSlxSOPmJTfEhK7t2hKXji/7IRy1g9g=
X-Google-Smtp-Source: AGHT+IFmFpJPOGOxqboe3FSCJG1p90kkm0iTmlWq/Ni/uCdlNc+9cgBNSEFM0DbQDQceCqmCnrSi6Q==
X-Received: by 2002:a05:6000:11cc:b0:37d:3650:fae5 with SMTP id ffacd0b85a97d-380611f5202mr113855f8f.52.1729876560748;
        Fri, 25 Oct 2024 10:16:00 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b91f50sm2013649f8f.94.2024.10.25.10.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:16:00 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH v2 00/36] drm/vc4: Add support for BCM2712 / Pi5 display
 hardware
Date: Fri, 25 Oct 2024 18:15:31 +0100
Message-Id: <20241025-drm-vc4-2712-support-v2-0-35efa83c8fc0@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADTSG2cC/22NQQ6CMBBFr0Jm7Zh2ChJceQ/DorZFuoA2U2wkh
 LtbiUuX7yX//Q2SY+8SXKsN2GWffJgL0KkCM+r56dDbwkCCaikEoeUJs6mRWkmYXjEGXrDTVpG
 6OGX0AGUa2Q3+fWTvfeHRpyXwerxk+bW/IKn/wSxRoDSGbNN0dSfaG+sUH455jf5swgT9vu8fY
 xbB6b4AAAA=
To: Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dom Cobley <popcornmix@gmail.com>
X-Mailer: b4 0.14.1

This series adds the required DRM, clock, and DT changes
required to support the display hardware on Pi5.
There are a couple of minor fixes first before the main patches.

Many of the patches were authored by Maxime whilst working
for us, however there have been a number of fixes squashed
into his original patches as issues have been found. I also
reworked the way UBM allocations are done to avoid double
buffering of the handles as they are quite a limited resource.

There are 2 variants of the IP. Most Pi5's released to date
have used the C1 step of the SoC, whilst the 2GB Pi5 released
in August is using the D0 step, as will other boards in future.

Due to various reasons the register map got reworked between
the steps, so there is extra code to handle the differences.
Which step is in use is read out of the hardware, so they
share a compatible string.

Thanks!

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
Changes in v2:
- Collected Acks and R-b tags
- Dropped patch 1 "drm/vc4: Limit max_bpc to 8 on Pi0-3". Already fixed as
  noted by Maxime.
- Fix unintialised var "mux" in vc6_hvs_pv_muxing_commit.
- Fixed uninitialised var "reg" in vc4_hvs_cob_init.
- Make bcm2712_mop_data and bcm2712_moplet_data static.
- Removed the "disable_turbo" line from the struct in
  raspberrypi_clock_property
- I'm confused by the CI error "performing pointer arithmetic on a null
  pointer has undefined behavior" for PCI_IOBASE as I'm not using it.
- Link to v1: https://lore.kernel.org/r/20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com

---
Dave Stevenson (11):
      drm/vc4: Use of_device_get_match_data to set generation
      drm/vc4: Fix reading of frame count on GEN5 / Pi4
      drm/vc4: drv: Add support for 2712 D-step
      drm/vc4: hvs: Add in support for 2712 D-step.
      drm/vc4: plane: Add support for 2712 D-step.
      drm/vc4: hdmi: Support 2712 D-step register map
      drm/vc4: Enable bg_fill if there are no planes enabled
      drm/vc4: Drop planes that are completely off-screen or 0 crtc size
      arm64: dts: broadcom: Add firmware clocks and power nodes to Pi5 DT
      arm64: dts: broadcom: Add display pipeline support to BCM2712
      arm64: dts: broadcom: Add DT for D-step version of BCM2712

Dom Cobley (3):
      clk: bcm: rpi: Add ISP to exported clocks
      clk: bcm: rpi: Allow cpufreq driver to also adjust gpu clocks
      clk: bcm: rpi: Enable minimize for all firmware clocks

Maxime Ripard (22):
      dt-bindings: display: Add BCM2712 HDMI bindings
      dt-bindings: display: Add BCM2712 HVS bindings
      dt-bindings: display: Add BCM2712 PixelValve bindings
      dt-bindings: display: Add BCM2712 MOP bindings
      dt-bindings: display: Add BCM2712 MOPLET bindings
      dt-bindings: display: Add BCM2712 KMS driver bindings
      drm/vc4: drv: Support BCM2712
      drm/vc4: hvs: Add support for BCM2712 HVS
      drm/vc4: crtc: Add support for BCM2712 PixelValves
      drm/vc4: hdmi: Add support for BCM2712 HDMI controllers
      drm/vc4: txp: Introduce structure to deal with revision differences
      drm/vc4: txp: Rename TXP data structure
      drm/vc4: txp: Add byte enable toggle bit
      drm/vc4: txp: Add horizontal and vertical size offset toggle bit
      drm/vc4: txp: Handle 40-bits DMA Addresses
      drm/vc4: txp: Move the encoder type in the variant structure
      drm/vc4: txp: Add a new TXP encoder type
      drm/vc4: txp: Add support for BCM2712 MOP
      drm/vc4: txp: Add BCM2712 MOPLET support
      drm/vc4: Add additional warn_on for incorrect revisions
      clk: bcm: rpi: Create helper to retrieve private data
      clk: bcm: rpi: Add disp clock

 .../bindings/display/brcm,bcm2711-hdmi.yaml        |   2 +
 .../bindings/display/brcm,bcm2835-hvs.yaml         |   5 +-
 .../bindings/display/brcm,bcm2835-pixelvalve0.yaml |   3 +
 .../bindings/display/brcm,bcm2835-txp.yaml         |   5 +-
 .../bindings/display/brcm,bcm2835-vc4.yaml         |   1 +
 arch/arm64/boot/dts/broadcom/Makefile              |   1 +
 arch/arm64/boot/dts/broadcom/bcm2712-d-rpi-5-b.dts |  37 +
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts   |  42 +
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi          | 188 +++++
 drivers/clk/bcm/clk-raspberrypi.c                  |  33 +-
 drivers/gpu/drm/vc4/tests/vc4_mock.c               |   8 +-
 drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c     | 106 +--
 drivers/gpu/drm/vc4/vc4_crtc.c                     |  96 ++-
 drivers/gpu/drm/vc4/vc4_drv.c                      |  19 +-
 drivers/gpu/drm/vc4/vc4_drv.h                      |  54 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     | 107 ++-
 drivers/gpu/drm/vc4/vc4_hdmi.h                     |   4 +
 drivers/gpu/drm/vc4/vc4_hdmi_phy.c                 | 640 +++++++++++++++
 drivers/gpu/drm/vc4/vc4_hdmi_regs.h                | 217 ++++++
 drivers/gpu/drm/vc4/vc4_hvs.c                      | 737 ++++++++++++++++--
 drivers/gpu/drm/vc4/vc4_kms.c                      | 105 ++-
 drivers/gpu/drm/vc4/vc4_plane.c                    | 866 ++++++++++++++++++++-
 drivers/gpu/drm/vc4/vc4_regs.h                     | 297 +++++++
 drivers/gpu/drm/vc4/vc4_txp.c                      |  91 ++-
 include/soc/bcm2835/raspberrypi-firmware.h         |   1 +
 25 files changed, 3461 insertions(+), 204 deletions(-)
---
base-commit: 3ae80b375739495e36fc6143ff27716fe390a13e
change-id: 20241002-drm-vc4-2712-support-9ad3236e3caf

Best regards,
-- 
Dave Stevenson <dave.stevenson@raspberrypi.com>


