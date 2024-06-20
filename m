Return-Path: <linux-kernel+bounces-223210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2842B910FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37BA287BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2125F1BC067;
	Thu, 20 Jun 2024 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="Ef2yOdoP"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7D31BA87D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906240; cv=none; b=eMCm8zGJ2vHLhQLlqxDMA9npvQUOSUuEAdLz5QsgM/FzOtrGxtn99ytq60g3jB1gSnb5DH0cww+9WB+QwqC347gOwp+ZmbDr3oQgG11FPaZMOcj2e0L7WiybBCnCLGG4Pj9dPLV50934Enpv4ffws9SzQ7NiS+s0QNoBpdqVUI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906240; c=relaxed/simple;
	bh=lL5HxCJiZymjowcOr7xVA2M7Te/xs6i3j2oxZgMh+rs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f63EbqVpAZRa9OAQT4iARcmYNe9SjdNCXT+XU0z/yCimPdrM0mh5xEjGqaJAhqKqGrrwnlOCDXNRrUyts5zW4M3sZQUK4luKgkfBi4KJIeuEEsfKF/kOInLekzIYqhFfFusNwj6hQHV9LeWWJIhKqWkm7HtOaZySGHAqFIn/BEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=Ef2yOdoP; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6fc30e3237so128642566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1718906235; x=1719511035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UP/GNN9hhxz4nMUGrLaNfWrPk3mVaVMWtBi9huNJxPk=;
        b=Ef2yOdoPvdrdIdPhr5LQiCJ0I9SLxjRSKaL/OqYMX5sqAZCEuTYZ7p/dgSstRd9dBo
         453/Yyxx0wzRqZnwLXEhOVZlIMMOGUCt9mtMNngn1z/AFwrxtSyZeZigZvfq7nDB88xV
         bfv/JdkfvxqG+JcOdNlu83TuBlMu8F15agYsQp6cQBRiayP82/3wP2Zfym+grexo+RbH
         33uSmqeotVnrH7QfBwkcsJPqVTYCS6ltvJkZVCpj529Q28XwqxMs+LKs1pdi2dvKdODM
         dBTtra4ZW7mcWHzmYzVTyIVE19mJcpcSI3bWWiS5kWd408yqD4I5puVMvo6ZbWc9XIqN
         69lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906235; x=1719511035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UP/GNN9hhxz4nMUGrLaNfWrPk3mVaVMWtBi9huNJxPk=;
        b=DKKMQH1O6f6wlY4Ba37LKAPaEN5khz9WeL12G2aqW3YZeHYxeVTT/ft4TUH7N1AsLA
         5M0pqJQ7iLieZPDygZMYhc+fQr8ZnK4AyBaWq8QqyYBgvHBbwH71elGPtVLMj6pWBpQm
         UKkaOMxQxSvilp4TgqCOHX24pB+HrF7wFGOH3AIlbu7azlzNzeRfPoa+BSZip6w082Rv
         tgCIRVqBf4aYOG+auIy95Ag2YUlIvmu8M744nvS39gk5nEMmL+nE7+TzfKPwysocq/Kf
         Hy5VfL7xipIicF9bKzTAeI7ZHRhmYeLCyP4yRbuQk7DVpb5/e5b+Dh8vmEHm+8rnMWsD
         FjnA==
X-Forwarded-Encrypted: i=1; AJvYcCVac+Uj8R6AtgAP5ahfTU3QZDoiLVn8oMEHSLfA8jw21+szM58hELsTX0t+BVpNm20XWLzQj2ND8OHJfEtt99RnjLhgOTMi3DULi1pD
X-Gm-Message-State: AOJu0Yw6bpXSmCMhzpPPGjG5IU8hfSlluiQJTifOGcfwFXNSAD7+BR5j
	f4LC8ya7F4jj8ATW5qjToQq+QJGKV4NuPPqBQUrqcf0qGLjaApnS9Vtx7eOh4+8=
X-Google-Smtp-Source: AGHT+IHwzCxasTWecNI2BQg/1Mqv76qvz0pqMMUj9hgHTBodTuDhBkY00q2aX9YgUG43J9U17WwHFQ==
X-Received: by 2002:a17:906:a09:b0:a6e:f7bf:712e with SMTP id a640c23a62f3a-a6fab618973mr379689666b.27.1718906235388;
        Thu, 20 Jun 2024 10:57:15 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f42e80sm781370766b.186.2024.06.20.10.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:57:14 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"J.M.B. Downing" <jonathan.downing@nautel.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Yangtao Li <frank.li@vivo.com>,
	Li Zetao <lizetao1@huawei.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Chancel Liu <chancel.liu@nxp.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: Markus Elfring <Markus.Elfring@web.de>
Subject: [Patch v4 00/10] Add audio support for LPC32XX CPUs
Date: Thu, 20 Jun 2024 19:56:31 +0200
Message-Id: <20240620175657.358273-1-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This pach set is to bring back audio to machines with a LPC32XX CPU.
The legacy LPC32XX SoC used to have audio spport in linux 2.6.27.
The support was dropped due to lack of interest from mainaeners.

Piotr Wojtaszczyk (10):
  dt-bindings: dma: pl08x: Add dma-cells description
  dt-bindings: dma: Add lpc32xx DMA mux binding
  ASoC: dt-bindings: lpc32xx: Add lpc32xx i2s DT binding
  ARM: dts: lpc32xx: Add missing dma and i2s properties
  clk: lpc32xx: initialize regmap using parent syscon
  dmaengine: Add dma router for pl08x in LPC32XX SoC
  ARM: lpc32xx: Remove pl08x platform data in favor for device tree
  mtd: rawnand: lpx32xx: Request DMA channels using DT entries
  ASoC: fsl: Add i2s and pcm drivers for LPC32xx CPUs
  i2x: pnx: Use threaded irq to fix warning from del_timer_sync()

 .../devicetree/bindings/dma/arm-pl08x.yaml    |   7 +
 .../bindings/dma/nxp,lpc3220-dmamux.yaml      |  56 +++
 .../bindings/sound/nxp,lpc3220-i2s.yaml       |  73 ++++
 MAINTAINERS                                   |  21 +
 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi        |  53 ++-
 arch/arm/mach-lpc32xx/phy3250.c               |  54 ---
 drivers/clk/Kconfig                           |   1 +
 drivers/clk/nxp/clk-lpc32xx.c                 |  10 +-
 drivers/dma/Kconfig                           |   9 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/lpc32xx-dmamux.c                  | 195 +++++++++
 drivers/i2c/busses/i2c-pnx.c                  |   4 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c            |  10 +-
 drivers/mtd/nand/raw/lpc32xx_slc.c            |  10 +-
 sound/soc/fsl/Kconfig                         |   7 +
 sound/soc/fsl/Makefile                        |   2 +
 sound/soc/fsl/lpc3xxx-i2s.c                   | 376 ++++++++++++++++++
 sound/soc/fsl/lpc3xxx-i2s.h                   |  79 ++++
 sound/soc/fsl/lpc3xxx-pcm.c                   |  73 ++++
 19 files changed, 954 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/nxp,lpc3220-dmamux.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml
 create mode 100644 drivers/dma/lpc32xx-dmamux.c
 create mode 100644 sound/soc/fsl/lpc3xxx-i2s.c
 create mode 100644 sound/soc/fsl/lpc3xxx-i2s.h
 create mode 100644 sound/soc/fsl/lpc3xxx-pcm.c

-- 
2.25.1


