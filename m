Return-Path: <linux-kernel+bounces-426686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D2B9DF6AB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 18:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4672FB210DF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4F41D7E5C;
	Sun,  1 Dec 2024 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gBU6/WMc"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EF41D5CD4
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733075241; cv=none; b=iF42p+xNly1dyUxWuKPQFXUoYefiP8IMzn4qQhlmTRqblnmi8M4D3SalBk9bA0SlRCjJOGktA2RIIxcU/LoZDjYP7wKatEBSNSQaxdDXIH40OlOvMOcEEbp1daXwYpWVwrIq47vkdzqQcHqBqGnFZaFxpvqB0MggHI/hE1j9Qe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733075241; c=relaxed/simple;
	bh=qGyDbu8dbHa9uRw+TklcwCPRNvx4qe8HGiBX4mxWY1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iXMw7t6IxocPzUQ+Guc3H74RGbQ9EifJQiXhvhPfnKFyVBTcR88kX54AxHVIeQr0IFgyqlFKl1bcdQZPql5PWo/fNMxdVSq/AGKp8xoMK3zpQtzNsnSaROV/D+Dxe48B12BxClCMCfAmTdGSfu4+vB99H+2Ij+buK9ATT3cvyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=gBU6/WMc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so4284160a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 09:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733075236; x=1733680036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rchwEG8OXdVUFDvOBxqjyl0K00WGKeVLIMzEYmldbsw=;
        b=gBU6/WMctDODqs2hcUo5lj8/jP16Ulrv43+IFNQHyXyawAhX12D6n4nBGVeZCoNqSu
         2RKBb1KPHA3lS8HJn3fyEiBsY/NAfqyvZ4VA07HVNUdvr12+JiJRgGE+qqFfO05gCYOh
         1tqaNjpQUiwG6xom2IxJ2++aP32v/bzzUXNlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733075236; x=1733680036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rchwEG8OXdVUFDvOBxqjyl0K00WGKeVLIMzEYmldbsw=;
        b=GTVEzcMAcInaq7p3GUmY4Mj7Jsdh77PhBTqRTp3pWw8jBVULU2bNuXYnivaMifO5gf
         GOGYOylp7sDeB7V3yrJ94P5RclZnw3kx2bV0pxaHOsi7eoQn1WTKqKkh12Rjr3cLfJiQ
         8UviLJhHoQgfJ5sWGBPmkiDvuGzbwR5VXoX3UQNjJP3QEdNUx89kZx/2nibNkRvOoCuj
         NlHopm2438MjRS3n3oRYU7kOP4NwoXapJG1KMnFmhN/O3ByaB8owanjySJ9nLVH0beEV
         M4TTUzlUFV2hb76CUvMVks0SOkloSGJIacxGxvRtYOMdTGYjgs9RaPEqxRsY0p5bmTEw
         +AUg==
X-Gm-Message-State: AOJu0Yz+ODPbDbK56lWhSdMt+kH0bCyvH6mQipvRYHgDX9rPCkgudWS3
	yADwbokX9M4eKCC6XV/uXjcTEvVOSaALgKfIdEL7aWjuomAaUBU1dtUJVZOGUpqFVey8slQMrqP
	Q
X-Gm-Gg: ASbGncu5dW9S66QrBzDmtCmfd+92hyu9FmVK7Xf6418P0JHqeA0VjhlTqhFN0yVW+1L
	y2IEruGCnm3JCgQvZF2UZ4oGtDDOY3HA6G19kB9TBuRQVPy0sjJBPtiWAjvVVTkDU1ciPOrTTvv
	LP5vjtluEoMQLWikyEHfXicCoa7L6W27vayCz+MpQbb47JRrKiSKwfxT4FuY1dKcW+xHIjNLc7Q
	F6l4gbUMbw8BiIinwhsoG+irw+0j5bJZ9LD9qgFvLRy/OiKJc3Sy62FdE6cQUPoOE4H/n4grhfR
	rteWLDbLJPDqhn6ZCsi4a37obJfy2DwhAdfb0akMPW1n4mh9pBqXhJ3ab4ngH4/aOJ/mVjSkVq7
	dqM2kDpGB+VstgyE8
X-Google-Smtp-Source: AGHT+IHOVUCcxf0ALDonprqfVqUEbAzV53v0SZ4mU7f60wTN66QJ2QUiGKJxXNAkQ6tdMuSLScJWrA==
X-Received: by 2002:a17:907:7742:b0:aa5:152a:d0a5 with SMTP id a640c23a62f3a-aa580f2c2ecmr1673821766b.18.1733075236544;
        Sun, 01 Dec 2024 09:47:16 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a78esm415220066b.163.2024.12.01.09.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 09:47:16 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v4 00/18] Support spread spectrum clocking for i.MX8N PLLs
Date: Sun,  1 Dec 2024 18:46:00 +0100
Message-ID: <20241201174639.742000-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series adds support for spread spectrum clocking for i.MX8MN
PLLs (audio, video and DRAM). It has been tested for the video PLL on
a board using i.MX8MN.
The patches added in version 4, such as the dt-bindings and the driver
for anatop, were inspired by the extensive email exchange from version 3:
https://lore.kernel.org/imx/20241106090549.3684963-1-dario.binacchi@amarulasolutions.com/

The series added spectrum spread support for the imx8mn platform only,
but in case it was merged, confirming that the directives and suggestions
made by the maintainers were correctly understood and implemented, I will
extend this support to the imx8mm and imx8mp platforms as well.

(no changes since v1)

Dario Binacchi (18):
  clk: imx8mm: rename video_pll1 to video_pll
  clk: imx8mp: rename video_pll1 to video_pll
  dt-bindings: clock: imx8m-anatop: define clocks/clock-names
  arm64: dts: imx8mm: add anatop clocks
  arm64: dts: imx8mn: add anatop clocks
  arm64: dts: imx8mp: add anatop clocks
  arm64: dts: imx8mq: add anatop clocks
  dt-bindings: clock: imx8mm: add binding definitions for anatop
  dt-bindings: clock: imx8mn: add binding definitions for anatop
  dt-bindings: clock: imx8mp: add binding definitions for anatop
  clk: imx: add hw API imx8m_anatop_get_clk_hw
  clk: imx: add support for i.MX8MN anatop clock driver
  dt-bindings: clock: imx8m-clock: support spread spectrum clocking
  arm64: dts: imx8mm: add PLLs to clock controller module (ccm)
  arm64: dts: imx8mn: add PLLs to clock controller module (ccm)
  arm64: dts: imx8mp: add PLLs to clock controller module (ccm)
  clk: imx: pll14xx: support spread spectrum clock generation
  clk: imx8mn: support spread spectrum clock generation

 .../bindings/clock/fsl,imx8m-anatop.yaml      |  53 +++-
 .../bindings/clock/imx8m-clock.yaml           |  77 ++++-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  11 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  11 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  11 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |   2 +
 drivers/clk/imx/Makefile                      |   2 +-
 drivers/clk/imx/clk-imx8mm.c                  | 102 +++----
 drivers/clk/imx/clk-imx8mn-anatop.c           | 281 ++++++++++++++++++
 drivers/clk/imx/clk-imx8mn.c                  | 188 ++++++------
 drivers/clk/imx/clk-imx8mp.c                  | 118 ++++----
 drivers/clk/imx/clk-pll14xx.c                 | 127 ++++++++
 drivers/clk/imx/clk.c                         |  26 ++
 drivers/clk/imx/clk.h                         |  22 ++
 include/dt-bindings/clock/imx8mm-clock.h      |  78 ++++-
 include/dt-bindings/clock/imx8mn-clock.h      |  67 +++++
 include/dt-bindings/clock/imx8mp-clock.h      |  79 ++++-
 17 files changed, 1022 insertions(+), 233 deletions(-)
 create mode 100644 drivers/clk/imx/clk-imx8mn-anatop.c

-- 
2.43.0


