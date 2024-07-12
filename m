Return-Path: <linux-kernel+bounces-250938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C4B92FEC8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B566E1F22547
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CB51779AB;
	Fri, 12 Jul 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaQF3wmi"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E965177986;
	Fri, 12 Jul 2024 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720802809; cv=none; b=Bklqcrw7Ogj9xBKW1xcC2XBdzPGjc5Gz6ldzjLUs++aNaprQc9Lut+XAE5OXy2FFLZ0RHRpfEj5olKvj+BDkyX3MIZ57CGT8pKIvNXAc+sT1iMRrumg+rS8Sv5RpT5PfTjPrEgBGEmqPctnchXewTn+x7ubrrsTWVdhGuDLgI58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720802809; c=relaxed/simple;
	bh=CshEcl3u//JHZZ/m/Pc3kIPelU9uFZtB0QMyJ9ZX/PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6jDqhDlzZ5xkiDe61vN3ciLdaRHN0iyRtsMbqobm5R+oPYtzRdQXDnKrZxWykzq2VMbiOx3+YhM1+qjNMwZKkVRuVAXDNUOovCMj4LGptJ7sIGM83KgTjR8vV/6+cja+v/Gj9cflpFxG4jtttrxE3Xzp89X7PqKMeQpnFdNwcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaQF3wmi; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ca8dfa2cceso1711391a91.2;
        Fri, 12 Jul 2024 09:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720802807; x=1721407607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlSTu8e9NEa7x8cqCEciuuE7yj+zz0dZw/tC3iuljOI=;
        b=MaQF3wmiNZ30ZqR1HqhUbS+ly7ap5f+yg9AFq+FNG4cMqKdS5U4jS/iU/tFfG1U9eB
         /jdgqOEbirAYxpKGHjQ2iJPnmMOhiTdV7ThBMojs+u9VCWW2ySjnzACVl6X44ncCEOoq
         EYw0vuiOA6sujZtzjtyMN7LJZ5LaQle0u7eLm2tnq31QO757MZQS/dK6BXtS96phdAfA
         xxetEXmN0koc3tRhKsBa7eMmwjuIwiIdb9I+sWWE4a3aJw4cfNNvpo4U4WqzdaYhZRCt
         lcw25juc8/n4plVKPa6g3MiU251Iq04m8FWP5DD+18srzihZ40cNVHkLCXHL9FzGS/xW
         7hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720802807; x=1721407607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlSTu8e9NEa7x8cqCEciuuE7yj+zz0dZw/tC3iuljOI=;
        b=hoqi6l+hOHEliWnaGvUw42DlDNQLwOuRXRZkxP7ft/A/pHJYPhul9X5tTuRlgCJQHM
         3PqpikmR8lV1g7Na+0TbuwRSyw3rMaEKJTpk4C8x1r6DAWoZwTM8fzRg1BEPYpjs+4O4
         15JoStPZtQ6VpORegBOlelNSIELVkmli6lBIy+LBoJFwunbfF8VQt0YMfW9NIPs9zuE4
         ZYUkqKskC1G9Jv6rXWklJa5DnACgdOnrygdfvJxoGHgvoMgWC/f9wy/mOJnsuN30SvaT
         wFnBtv+JodVcQzaOfi9jlY0PeWCGKGqacB1aI40e/YBuvC4w6j3TgzTdQlZg+GlcQEPd
         LNSA==
X-Forwarded-Encrypted: i=1; AJvYcCWTvIsLbzJS9k0NIukvtHzubLcfFx3sn7wesbfmylV0rxCrmsJ7TwBWkwY0kdMoE/IBKe2RmasjS9HUNQfWjK9uhJe3uiqthFoYm40VVxHE8YTrdvJ6IMpCbZcoREqmu+sZjvTsQta/JA==
X-Gm-Message-State: AOJu0Yx9gFNDRxQUn+W/RbAJWZsVOmltYLO/DNhvDhQFV8xBkQOtA8Qr
	S7MD+3Tspv2zhy5r/djQTAyZitMQ5L3pg4U+Er/Rze8ud6cM+Ow+
X-Google-Smtp-Source: AGHT+IE3gd839oKFIr0D0QdBOBET0btxNgDgPKYQ9uzxuv19+FxgjT5x6cE0vXTyKc33JJRvBRpF1w==
X-Received: by 2002:a17:90b:d85:b0:2c9:6b02:15ca with SMTP id 98e67ed59e1d1-2ca35d4b0f0mr9339931a91.39.1720802807357;
        Fri, 12 Jul 2024 09:46:47 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd65a663sm1765436a91.40.2024.07.12.09.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:46:47 -0700 (PDT)
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
Subject: [PATCH-next v3 3/3] arm64: dts: rockchip: Add missing pinctrl for PCIe20x1 node
Date: Fri, 12 Jul 2024 22:15:51 +0530
Message-ID: <20240712164554.1763-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240712164554.1763-1-linux.amoon@gmail.com>
References: <20240712164554.1763-1-linux.amoon@gmail.com>
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
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index c5ac233264fc..a1e83546f1be 100644
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
+				<3 RK_PC7 4 &pcfg_pull_up>,
+				/* PCIE_PERST_L */
+				<3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>,
+				/* PCIE20_1_2_WAKEn_M1_L */
+				<3 RK_PD0 4 &pcfg_pull_up>;
 		};
 	};
 
-- 
2.44.0


