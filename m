Return-Path: <linux-kernel+bounces-263540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6615F93D76E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5CCDB23463
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9353A17D894;
	Fri, 26 Jul 2024 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFGLURIi"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C683F17D88A;
	Fri, 26 Jul 2024 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014115; cv=none; b=J/0GPyJNnFa7aVdf6C9dl/8wekSYmLG9lugECwc7+REGJLLzPd6zDpfEAPCigFnqX7H33nyY/G8A9uBBJ43anI4XzLAukpnDlbWGIBYdiG5SqLRAjUeFCExxo/f4zV/xyBdZkQjHMSSPizbGs3g+y87b5wApmX+8jFFqT/yTI88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014115; c=relaxed/simple;
	bh=Xjke6rVR6dEfgaQ5g4hKX6iiE3ipqXqz8eG2hMIm8oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgov10W34yElO8bvuMhAkaVzojmYWKiu6jaUIi1x/lzfP40rn4fzP2Nzu/CrFXAtojR6ViigHv3kAo+gwWUEuuzfsOgG9b3QLiX/9nHJgzn8U1kHbVotWAiPZwhHvAGz+RSnK7u/Y3oyeO2GOdsDam+lGQaoDeiTz9we39i8ciM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFGLURIi; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cb55418470so858443a91.1;
        Fri, 26 Jul 2024 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722014113; x=1722618913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWES2bQT90aeNpHB9lBbGnFEyMSuVA3NqfH6hD88dJc=;
        b=QFGLURIidziQtwSuuPZoLiF2VdzEqKXTGPwiMDtzmIHLdMVc321grhRv5oodnUD81C
         Rfq7RWBnrbKWbkAqIT9xq5oKpz8rDu1hkSSIhXFEqaqI/MCPne0GNraVxJqc1c+B69RL
         /F0QhS8wYAaIRWBgYbB3CnPbrIBBkHGLIAu9VKTD1duD9sJ7a3qnglIDgkFSJ9KRlj6P
         e30bP1jlDZPgINnbk+mITl/YtQ5jqNHKOWkXETuaVt7vxpNCCbTesglzk6ai5YDjCTTd
         HXXzLsy1hIrGEXLCnG/yfXoW+7OKZi7zYk8u//4lf7SphucW86I94CWC1eabNghHObuP
         voXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722014113; x=1722618913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWES2bQT90aeNpHB9lBbGnFEyMSuVA3NqfH6hD88dJc=;
        b=mio0CVyRMZA4Gbd/EkUVKBZiWabBhS6YTK+KzkfoBapcr8N9KAalLdf3S1DtcUWH7k
         PNmTrLTXdjN/JgHj3S87qih0S2hqFH7wBgAEMZYEzpSa4XszaASfA92UMfzzjDibMXD7
         Tq57V9eCbO6plaxSAytX6xrwsJTT1txd1M/2ybwel3dXouruKl4ifuvZi+fHMcJ61sOZ
         ZUd2fvYe+GzH3Ujo/w9NJOF27H8c8H9I5j5MbyZPnZmSXKtgm6KudLXdw3Bh7tTxUhx9
         Tnt3oYvbO3nDqSv/ggAtfXmsKWy8oSPhRISCM5e1wSSob7/20yhYzK6NS8pNRqenFozx
         Wrcg==
X-Forwarded-Encrypted: i=1; AJvYcCW0qiUp/5tDM4nWIZkMg6ok++U1eJMkESH2KB1lPiqtDa8eyQEhng5ww+xPU8GaD41wt1PiJNlPBdel6xVootDm9YB18qC+5xX2uM5TTF+9KrKXp4klTlljGfCJV60ZhbVnI4N+KDVW2g==
X-Gm-Message-State: AOJu0YyixKSeD4vbQURBsGHtjw/hoZgOhMRduKTM2WykyNdp1jJWc4RZ
	vLU9iHGzptH8M/PdhRjIMjAf0YI7uNfQYNggayn+MNb/8/L5lkOe
X-Google-Smtp-Source: AGHT+IGJg1vkK8mEH1oYikk12jQXh5IJ2w10jCagEsadDUeCGJRIDXEshIIM4ECEILPSh+aPCPnL3w==
X-Received: by 2002:a17:90b:4c04:b0:2c4:aae7:e27 with SMTP id 98e67ed59e1d1-2cf7e1ff170mr172266a91.23.1722014113033;
        Fri, 26 Jul 2024 10:15:13 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73ededcsm5718855a91.31.2024.07.26.10.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 10:15:12 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] arm64: dts: rockchip: Add missing pinctrl for PCIe20x1 node
Date: Fri, 26 Jul 2024 16:30:46 +0530
Message-ID: <20240726110050.3664-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240726110050.3664-1-linux.amoon@gmail.com>
References: <20240726110050.3664-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing pinctrl settings for PCIe 2.0 x1 clock request and wake
signals. Each component of PCIe communication have the following control
signals: PERST, WAKE, CLKREQ, and REFCLK. These signals work to generate
high-speed signals and communicate with other PCIe devices.
Used by root complex to endpoint depending on the power state.

PERST is referred to as a fundamental reset. PERST should be held low
until all the power rails in the system and the reference clock are stable.
A transition from low to high in this signal usually indicates the
beginning of link initialization.

WAKE signal is an active-low signal that is used to return the PCIe
interface to an active state when in a low-power state.

CLKREQ signal is also an active-low signal and is used to request the
reference clock.

Rename node from 'pcie2' to 'pcie20x1' to align with schematic
nomenclature.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v4: rebase on master, used RK_FUNC_GPIO GPIO function instead of PIN
number.
V3: New patch.
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index eeae14842b71..813a28b8916e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -326,7 +326,7 @@ &pcie2x1l0 {
 
 &pcie2x1l2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie2_2_rst>;
+	pinctrl-0 = <&pcie20x12_pins>;
 	reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie2x1l2>;
 	status = "okay";
@@ -363,9 +363,15 @@ hp_detect: hp-detect {
 		};
 	};
 
-	pcie2 {
-		pcie2_2_rst: pcie2-2-rst {
-			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+	pcie20x1 {
+		pcie20x12_pins: pcie20x12-pins {
+			rockchip,pins =
+				/* PCIE20_1_2_CLKREQn_M1_L */
+				<3 RK_PC7 RK_FUNC_GPIO &pcfg_pull_up>,
+				/* PCIE_PERST_L */
+				<3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>,
+				/* PCIE20_1_2_WAKEn_M1_L */
+				<3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 
-- 
2.44.0


