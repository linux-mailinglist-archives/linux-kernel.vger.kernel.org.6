Return-Path: <linux-kernel+bounces-325867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCB0975F40
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511631F23F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FB21420DD;
	Thu, 12 Sep 2024 02:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjNaN5iR"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A890913D503;
	Thu, 12 Sep 2024 02:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109542; cv=none; b=HcQLOk3Oay1hPbq3YrbrST/Ilvb13qxEZRVCMTm0LJaBfAuFqQ7gs4lEI2l6IBA8sI6K6AVSw2pOFY/UCm2gOnXIb9S3f/S7KAfigIREFTcGZO6tUpYilqy6uBKE2fYY4wCumkbDQcciQMMz3sflzyxbIM8PO+TEkd/bFJp4sI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109542; c=relaxed/simple;
	bh=/86Y1w20dCS1fi9KqIdg26CpaJQcqIjpZZhy7athhyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtIKrRnT5adaeDm4NSAw4CBQur2VnrR71dQ8mzcjPSm93p12ueF0NnOODCIBfy/bfG/JyyZc5ogqKvgfUHs7xnSeFfkMhIbiMfmijo0GHvXQ/MdEv5xmNoDxO6aQWxy2jPV/bhKjboPayYXjo59JkC125FL6b+aK4GEGZRhAP9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjNaN5iR; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-717934728adso337595b3a.2;
        Wed, 11 Sep 2024 19:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726109540; x=1726714340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/6wDT038m9pyQEZyE3iR606xVa5WMw7igyQP4+54lQ=;
        b=MjNaN5iRzY1xfwauS8NahWuQSznNFSHeKdahKizHQzfEY21B1CyQZi6kjut6Q6uwu/
         489bPZRQ8rojyagSch306+5dw4TPXhC4BHiC7RqJfSLMnYbYvh6zbAqYg6R9GLOFLC7k
         jFSvJqMCZdNJsr2/c7VcX9/+ktnvVFsSJ4AMjMdXgX28mkAG8Ve3LYj/up2r7+Irk9z+
         yWhjN5n/dsbCNSnIg9/ZKC2YHMiaGVFwGdyQAjSaSzMUivia6mb66zxenNh/UH2stzcg
         Dwt1YhDmm06AnpM5SjAmLO5WgqJX9bFbNKWiZ/KjwJ37uHYC+Bq2j17aYy5EKKmaD1n0
         n9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726109540; x=1726714340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/6wDT038m9pyQEZyE3iR606xVa5WMw7igyQP4+54lQ=;
        b=vLvOvFpMRSrvq7clXX+wZYI48qqRV+wtj8qajLsSespCP5ZMFhQO5F7EPb5j2FaZsl
         D2yiKKU7xuGXniK2ZH+y8SlNY0vi5x01++hCW/u10pJPTHClUkOye/2pEOTOcHWfj2YT
         /ZBfFjyQgSi1gXi843jKvYeksnrCDRPEU77O9PNW7K0DuYal6z8RuX+Y9Yogh9rndMsy
         Uyz7bT3oWbWrm0E39CogziT2XNePsxtT41gsFzqwA4ehbLkUF8dyjrsEjk+85Mjr2x+t
         vy9ZCn0rGn5VZZGbeW5E00/Qzx8bM2VLm5yfoLtDJrYVieMpyl2azq/EUu50rLNiWqR1
         Q+5g==
X-Forwarded-Encrypted: i=1; AJvYcCUfzEvDKrJrff21NRLb29nqv2XnDg7VlTh5nwQcw+f/ilPeIKwVxUjBRJym3NOctBohYv/ionPopw2zET6Z@vger.kernel.org, AJvYcCW+fJmpUR0+9dw3kSb216jgg+c2ASo9k3ZyQaU7jSzanHjBEb4VCAZHrXMo2wgNLktVb8xtx82sZ4SS@vger.kernel.org
X-Gm-Message-State: AOJu0YwFgl8ediIb1X1yKzXyL81JgVq1qMg3xrKQyNXhFFY+LpuuxsAq
	ZfNpRGHhrftNSJ7/ZQvcBIjA7tmoxI5NaHsHHAIc88R9F/a7FU+y
X-Google-Smtp-Source: AGHT+IELhmT8jSB9hWx2Rf1023+9YJ/U1SxinpSC0yVn1Ef2izwy2byLH1DNDEpEymLKs/BYyn8Tmg==
X-Received: by 2002:a05:6a00:1ace:b0:717:93d7:166f with SMTP id d2e1a72fcca58-719261fb2c4mr2073246b3a.20.1726109539684;
        Wed, 11 Sep 2024 19:52:19 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00::315])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbbf877sm569023a12.50.2024.09.11.19.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 19:52:18 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ondrej Jirman <megi@xff.cz>,
	Chris Morgan <macromorgan@hotmail.com>,
	Alex Zhao <zzc@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Jing Luo <jing@jing.rocks>,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
	Joshua Riek <jjriek@verizon.net>,
	Sam Edwards <CFSworks@gmail.com>,
	Jonathan Bennett <jbennett@incomsystems.biz>
Subject: [PATCH 2/5] arm64: dts: rockchip: Fix Turing RK1 PCIe3 hang
Date: Wed, 11 Sep 2024 19:50:31 -0700
Message-ID: <20240912025034.180233-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240912025034.180233-1-CFSworks@gmail.com>
References: <20240912025034.180233-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe 3 PHY in the RK3588 requires a running external reference clock
for both external bus transfers and some internal PIPE operations.
Without this clock, the PCIe3 controller fails to initialize and ignores
DBI transactions indefinitely, which stalls the Linux boot process.

On most RK3588 boards, this is evidently not an issue. But on some "SoM"
designs (Turing RK1, Mixtile Core 3588E, ArmSoM AIM7, to name a few),
this clock is only provided when the CLKREQ# signal is asserted.

The PCIe 3 PHY generates the CLKREQ# signal when it knows it needs the
reference clock for proper operation. Unfortunately, the current DT for
Turing RK1 does not mux out these low-speed signals, resulting in broken
boots and potentially other issues.

This patch, following the previous one that split up the PCIe pinctrls,
resolves this problem for Turing RK1 by explicitly muxing all of the
signals needed for PCIe 2 and 3 support.

Cc: Jonathan Bennett <jbennett@incomsystems.biz>
Fixes: 2806a69f3f ("arm64: dts: rockchip: Add Turing RK1 SoM support")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
index dbaa94ca69f4..9bcb5acdea54 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
@@ -211,7 +211,7 @@ rgmii_phy: ethernet-phy@1 {
 &pcie2x1l1 {
 	linux,pci-domain = <1>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie2_reset>;
+	pinctrl-0 = <&pcie2_reset>, <&pcie30x1m1_0_clkreqn>, <&pcie30x1m1_0_waken>;
 	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
@@ -223,7 +223,7 @@ &pcie30phy {
 &pcie3x4 {
 	linux,pci-domain = <0>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie3_reset>;
+	pinctrl-0 = <&pcie3_reset>, <&pcie30x4m1_clkreqn>, <&pcie30x4m1_waken>;
 	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie30>;
 	status = "okay";
-- 
2.44.2


