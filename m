Return-Path: <linux-kernel+bounces-569724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F191AA6A6AA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FAD0189F2BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88832204C3A;
	Thu, 20 Mar 2025 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1Vwat0c"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1361117BA5;
	Thu, 20 Mar 2025 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475689; cv=none; b=aq/UEy0OgZeYNm53FrnFuxrNV3Pm1S1OgihihAYzyGVfgBGKpotwUIrWrj7z9Vn/ALe4RsJAH9M6XIsQyNYn1s4B10ngUoY42s08brZmFBP6ih31OXztYS/9NQPNwOkiNrcMZf+3VdBaQSk2Ljc7vMgivx7oj3/LYIFYGQt2jtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475689; c=relaxed/simple;
	bh=WMto3apGvnTVFrZ2Rgo/7crodKVQXZ4U2w2f+ZqEgcs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=owXTFzCL+W/Tq8S8YWA2Ticjw9dFmCeApjOsThDak6JMCnm3FL5SkPk++auR6EIbVESdxJxdudHdxwvkpirUHintkBPKGaSlg1EDaC32BaOPyJgrvwwHS/2GUZiE0SzPLNJu4tWwngFrDRsrT9rdHUqZfXMzqaLk2YCRJqFleCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1Vwat0c; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so8097985e9.3;
        Thu, 20 Mar 2025 06:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742475686; x=1743080486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E4jlgljNt40Vu2CmEv7FaT2u7xedRKcXuIPlI99mDNo=;
        b=O1Vwat0c/VNDjj9z71/B8wZnJHyk284iFJye+OHL1Hv2aySuJ9jwXSuHPH8OzDXUqR
         2OTJYg/6uRthH2xDCe3SWZzCoOkGMFfeOctvnLQtEZtBzrpNpDE8XnrsMJ1slotfP9yb
         bpX1dpvkvTwc2/NTXzRiq0RysBlObKohwJtQhrqX93mw1mozfNMiyPXC0rEBjxrpgUQM
         6163reAt3htrfaBqs/gRjO71gKxKiHfKukfAJWOLV7BNfN4x6qPbZZKjvHjqeZIDLNTO
         o3UvjJk0m8oM15SD+gmgdTVc5L3bI2Kkjco62Mw7gtXaJ3eTu0sfFnl7A4peQohgtEyo
         BwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742475686; x=1743080486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E4jlgljNt40Vu2CmEv7FaT2u7xedRKcXuIPlI99mDNo=;
        b=pcjipTsQp2t6+24XnMOsjNb+fOo5RaGySn8OHPbGpf3gLCzPhw2InN0DJYcLZBU6nt
         szeTfii76nLgG8gHYy1QoI0rA4DcsyGs3dUZrVSVaFlhbzPRQN50FbxDDKNyv2UwK98i
         WMtBr433vNflW7FGF+F2wmMOTjzjMqf9YGLu7fg9vVb5wDEgwxob0Vwx73Cas2JTH0q+
         Yq4a6kv0yjHGZasmTXUUoQYgKWNKfPOyopPbFNKbYYxcr970USywk6Uszi1WgYbnrYQe
         hT6IKZMbKmnCX9Mft01UpNftHJSawUSbflLs/u8gXu4dO5sLEPx8uW6UKbzZeJObq20w
         fssw==
X-Forwarded-Encrypted: i=1; AJvYcCUDRjUfSAwtCpSYcTri6sSntIpdwZz+7gpJUO4WtAuO8aU7L4Vy//Xv2RBhWu3FpNWJ2SA6mqyYkNyn@vger.kernel.org, AJvYcCVz2nMD9uK1TFun0Jd7CaDonKgCu0zWmF+XzIL6rgRR1Tgx34dhKiogQoX3Ny2bWMdxborQGet6Bcdk@vger.kernel.org, AJvYcCXKHbbrW2I0HkE7uTDr9uU8kLE3ym8dr0dsdYVCWX5wQMq5fqtPFzdoJYx2vEZTR/HJYxftQgtBI8xdhG1d@vger.kernel.org, AJvYcCXqVUEJ0wpnxi7+qjcoEyzH46tlvPPCPi4336Taeh1Hrr9DNZ08573te5HgfAkiCd63JPTMafIhITH+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzixv3BfeICefV5U5NTnlxzViRz/B8D3fsHRN/ODsJebFTjFS1H
	L9EE8kiI++1Tt1CFG2yfwy3HihX2WDUP1e7eGMiAGCFQ0vKYIg5LvKUPjw==
X-Gm-Gg: ASbGncvq/AvmJTM7RC5tEqzxOI+jB02dYw7GO8sViLoBKBolTYkv8/OgAdCprQgkHiE
	iX6Hx11ZrhWS1HcTU8SM6K7xWzmgo9f9jAB6Inuy3/MTYNUQ2qwNZr0MllGNeeIn1kgtkoj54k+
	0ZOab2V6JiGE1yiouYEvrGTJuQOTFWsZ8Bs0rhsAl/W8oy+rlWsXkcs7ZNo+kech/V3NwSpsJOn
	hGl/zBrUDcmQu5Fab7ItO8sgyIO6XHVDICwSbPYYZKlOb81zsGTT9xzPCtlpMNT2TYg48UChnvB
	Oi7u4mYvqogD3b3EhQdqlAm2GRr7nswXPIPefyY5wDmMf/c8vkHRfnz54t3pgqj4mM1qQuG0SSX
	Sy94b7LMn+tnewg==
X-Google-Smtp-Source: AGHT+IGqvxRe9sNnKeQqg/T2zeY+NXunY9lY/OA3ABv2ihxgYNSNA4zfa6VlIvxCoHVeEJdasraRWg==
X-Received: by 2002:a5d:47c9:0:b0:391:13ef:1af5 with SMTP id ffacd0b85a97d-399795e6d96mr3565437f8f.48.1742475685246;
        Thu, 20 Mar 2025 06:01:25 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-397f2837e61sm18492328f8f.97.2025.03.20.06.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 06:01:24 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Danzberger <dd@embedd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Linus Walleij <linus.walleij@linaro.org>,
	Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v2 00/11] airoha: en7581: clk cleanup + USB support
Date: Thu, 20 Mar 2025 14:00:23 +0100
Message-ID: <20250320130054.4804-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implement all the changes required to correctly handle
USB support for the Airoha EN7581 SoC.

The first few patch are cleanup for the clock driver and the
introduction of the SCU SSR SoC driver.

The SoC always support USB 2.0 but for USB 3.0 it needs additional
configuration for the Serdes port. Such port can be either configured
for USB usage or for PCIe lines or HSGMII and these are configured
in the SCU space.

The xHCI USB is based on the Mediatek implementation but the PHY
handling although conceptually similar, is indded different compared
to Mediatek due to SSR checks and different port power up.

The SSR driver expose an API to poll the current status of the Serdes
port and the USB PHY driver validates it. Refer to the specific commit
for additional info.

Consider that there is currently an inconsistency as AN7581 and
EN7581 refer to the same thing. This is due to the fact that
the SoC born under EcoNet but then was acquired by Airoha.

Changes v2:
- Drop changes for simple-mfd
- Rework PHY node structure to single node
- Drop port-id property in favor of serdes-port and
  usb2-monitor-clock-sel
- Make the SSR driver probe from the clock driver

Christian Marangi (11):
  clk: en7523: convert driver to regmap API
  clk: en7523: generalize register clocks function
  dt-bindings: clock: en7523: add Documentation for Airoha AN7581 SCU
    SSR
  soc: airoha: add support for configuring SCU SSR Serdes port
  clk: en7523: define and register SoC SCU SSR driver for EN7581
  soc: airoha: scu-ssr: expose API to read current Serdes Port mode
  dt-bindings: phy: Add documentation for Airoha AN7581 USB PHY
  phy: move Airoha PCIe PHY driver to dedicated directory
  phy: airoha: Add support for Airoha AN7581 USB PHY
  usb: host: add ARCH_AIROHA in XHCI MTK dependency
  arm64: dts: airoha: en7581: add USB nodes

 .../bindings/clock/airoha,en7523-scu.yaml     |  101 +-
 .../bindings/phy/airoha,an7581-usb-phy.yaml   |   83 ++
 MAINTAINERS                                   |   21 +-
 arch/arm64/boot/dts/airoha/en7581.dtsi        |   49 +
 drivers/clk/clk-en7523.c                      |  340 +++--
 drivers/phy/Kconfig                           |   11 +-
 drivers/phy/Makefile                          |    5 +-
 drivers/phy/airoha/Kconfig                    |   23 +
 drivers/phy/airoha/Makefile                   |    4 +
 drivers/phy/airoha/phy-airoha-pcie-regs.h     |  494 +++++++
 drivers/phy/airoha/phy-airoha-pcie.c          | 1290 +++++++++++++++++
 drivers/phy/airoha/phy-airoha-usb.c           |  571 ++++++++
 drivers/soc/Kconfig                           |    1 +
 drivers/soc/Makefile                          |    1 +
 drivers/soc/airoha/Kconfig                    |   18 +
 drivers/soc/airoha/Makefile                   |    3 +
 drivers/soc/airoha/airoha-scu-ssr.c           |  271 ++++
 drivers/usb/host/Kconfig                      |    2 +-
 .../dt-bindings/phy/airoha,an7581-usb-phy.h   |   11 +
 include/dt-bindings/soc/airoha,scu-ssr.h      |   11 +
 include/linux/clk/clk-en7523.h                |   10 +
 include/linux/soc/airoha/airoha-scu-ssr.h     |   34 +
 22 files changed, 3202 insertions(+), 152 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
 create mode 100644 drivers/phy/airoha/Kconfig
 create mode 100644 drivers/phy/airoha/Makefile
 create mode 100644 drivers/phy/airoha/phy-airoha-pcie-regs.h
 create mode 100644 drivers/phy/airoha/phy-airoha-pcie.c
 create mode 100644 drivers/phy/airoha/phy-airoha-usb.c
 create mode 100644 drivers/soc/airoha/Kconfig
 create mode 100644 drivers/soc/airoha/Makefile
 create mode 100644 drivers/soc/airoha/airoha-scu-ssr.c
 create mode 100644 include/dt-bindings/phy/airoha,an7581-usb-phy.h
 create mode 100644 include/dt-bindings/soc/airoha,scu-ssr.h
 create mode 100644 include/linux/clk/clk-en7523.h
 create mode 100644 include/linux/soc/airoha/airoha-scu-ssr.h

-- 
2.48.1


