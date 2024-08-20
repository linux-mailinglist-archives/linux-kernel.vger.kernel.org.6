Return-Path: <linux-kernel+bounces-294132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8AB9589D5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A547B22017
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B531A00C5;
	Tue, 20 Aug 2024 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YSLifkqK"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B58194C7D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164591; cv=none; b=RYscqQByGGnaAoxZxIDsix3Lp0cr4wAE2r7KnJ7gzq/AaWI8ftLaNvZxSe4Czffip4qkCN0hvEOtYgdDboBcLelnGqYEjPowROlc0d2mws6GbmjN5k3NQXEC2Jwqe1Us8uzO5lNJWBesCPF5/QhQkRPB+P2Jx3Xq7xvuIVJc+4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164591; c=relaxed/simple;
	bh=rqRJWAybH0BXIttqUWZDoJAhQfObjtFcdpdNsbc6tZ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpjg65HTxgxopEfUpCFxtJH6pjBZfiFaJW3fGvtjo2meecbfbrrqjM+9CrWxt9T9Bkd1q7FzzgyH6P3RR0cr2oWc6ayZuD+eIFJn1tSGbC3AKN4HpiF1vxPNFGqfjmIXzrP13w+sfT72iikapZWskVyceVNqlijpzUf+IsSn5yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YSLifkqK; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a975fb47eso637145666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724164585; x=1724769385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2Xgg30vYhCxJ1eXmEmY/H80RrAwzg/J7u+AAMEQheA=;
        b=YSLifkqKVWA/KeHBbfhq2pmwmCTWDyKL5wW3WBSQ2dQMOmWS34QncqhmMKat7cxWd9
         5/WCyReOBCqMDfnPs1hzQU9k3ddmOp8Nerb+y6IJr2CbettwzfbSdC41Hr8/lr7isGgK
         DtdVWqy/YG/UGMMbAzEbVEZFhmfm5KEQfkjQydFQOMBRWPgqA9eNuXU94lX1lUoFnN+5
         KUhjbVHCNHCquCMJ+AjDGlKGdBrxbQVyHXbc2gdtkWiyH0GsiXwSgBj6lqbvXc9uLiD9
         bMyIx0hMoAlez93553EMQ2emwSLH+zk81fj/0Pv0hNb6gIdiNIlhU3jLkwBcyRXWhi3k
         Qrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164585; x=1724769385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2Xgg30vYhCxJ1eXmEmY/H80RrAwzg/J7u+AAMEQheA=;
        b=rQFohoZdXApDIqIFT8dMG+UhAwJTDV3Fh0QoOcpi5xKk0h8JXRlcXNMF8hnlpszh1h
         HC7yMpAZnVY8TsaCsSBT3SX8GY0XIjOlpmTQ1+PxM88PZJfNM5wHbx5U2Ij9U8YsH+g+
         0IrCGJQLq0Q7mSqk/6W43p8FiK7Yvry5g+8PuewLetP087UHUrUvJxBxuPoQ/AglrWVt
         PJGYM6uYF8Qj9dONZ7Q6Rgx8Q6mY1PM0+5wrribMiMGcf0m0Oh9QMyPVEQj+KgJv8CLU
         TbA/LPNkBzw6RPQFgkgUuxgVPRwY9PcIW0WEzvwUCJCIMvJ5mkzYOlZKYcn1OnbZNPrH
         hdUw==
X-Forwarded-Encrypted: i=1; AJvYcCXE5VpgMuj+7glO49HY97nfnntuJNSLe9WdbgF50GKCguAN+vv/6TbBvcRHFMJ7+sjDuOJ6I9f7IVt79lY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8CWNdiB1GWfKHuvoKDfzv5xCTcCrjdc6mdANz30LvU+tvAT0S
	fwBa8cCL0j94xynwgUw5OyJUoVb2onOpAh7yvcqmHlcMuyGrr0yjxLxhsV3fmYs=
X-Google-Smtp-Source: AGHT+IHHwb3kDEyWmIFiefIJfKoeZp5N9YbDUkPf5M8lEPY+UbF5lCIpL7IY1EOzpJk/o4jN7+373w==
X-Received: by 2002:a17:907:f164:b0:a77:dbf0:d22 with SMTP id a640c23a62f3a-a8392a4b5e8mr1083160066b.65.1724164584705;
        Tue, 20 Aug 2024 07:36:24 -0700 (PDT)
Received: from localhost ([87.13.33.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb18sm771023766b.60.2024.08.20.07.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:36:24 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 11/11] arm64: dts: rp1: Add support for MACB contained in RP1
Date: Tue, 20 Aug 2024 16:36:13 +0200
Message-ID: <a3fde99c2e522ef1fbf4e4bb125bc1d97a715eaf.1724159867.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724159867.git.andrea.porta@suse.com>
References: <cover.1724159867.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RaspberryPi RP1 is multi function PCI endpoint device that
exposes several subperipherals via PCI BAR.
Add an ethernet node for Cadence MACB to the RP1 dtso

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/boot/dts/broadcom/rp1.dtso | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/rp1.dtso b/arch/arm64/boot/dts/broadcom/rp1.dtso
index d80178a278ee..b40e203c28d5 100644
--- a/arch/arm64/boot/dts/broadcom/rp1.dtso
+++ b/arch/arm64/boot/dts/broadcom/rp1.dtso
@@ -78,6 +78,29 @@ rp1_clocks: clocks@c040018000 {
 							       <50000000>;   // RP1_CLK_ETH_TSU
 				};
 
+				rp1_eth: ethernet@c040100000 {
+					reg = <0xc0 0x40100000  0x0 0x4000>;
+					compatible = "cdns,macb";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					interrupts = <RP1_INT_ETH IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&macb_pclk &macb_hclk &rp1_clocks RP1_CLK_ETH_TSU>;
+					clock-names = "pclk", "hclk", "tsu_clk";
+					phy-mode = "rgmii-id";
+					cdns,aw2w-max-pipe = /bits/ 8 <8>;
+					cdns,ar2r-max-pipe = /bits/ 8 <8>;
+					cdns,use-aw2b-fill;
+					local-mac-address = [00 00 00 00 00 00];
+					phy-handle = <&phy1>;
+					phy-reset-gpios = <&rp1_gpio 32 GPIO_ACTIVE_LOW>;
+					phy-reset-duration = <5>;
+
+					phy1: ethernet-phy@1 {
+						reg = <0x1>;
+						brcm,powerdown-enable;
+					};
+				};
+
 				rp1_gpio: pinctrl@c0400d0000 {
 					reg = <0xc0 0x400d0000  0x0 0xc000>,
 					      <0xc0 0x400e0000  0x0 0xc000>,
-- 
2.35.3


