Return-Path: <linux-kernel+bounces-325866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81344975F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F271F23FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C7213DBBC;
	Thu, 12 Sep 2024 02:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIr9gwA2"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A4C126BE3;
	Thu, 12 Sep 2024 02:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109540; cv=none; b=T+ZWTOUSvCBtISgYi1T37QPktVvnhRrGeY8zUUsANBKpebOayklvkLFsd2Npab4d2T0Tqa7CIlDEYjvRH9WrNkSvVjL0If5qzQAeC1ntUoBudhmcjedOwjp+W8ucZXpDKh1R6FKbiEGCXSs8cd0tNzNxLcB1PAanQ59ZzclWVrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109540; c=relaxed/simple;
	bh=9ZbtgxkjecskxDAFH0Tck0aQOopEe1PaKMe48eBo3ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JU36njfWl8YPWPPi42LSjN0g9+L1fWywl2VTCplcW+3+fnTWgWu0vm8LdRYcciNEu7grUtE762LD+r/zGp72XuQJkZcaPuPzTScXQKRXV3l8xs43YrWneYh0FsBsBhMkDbKecV9Qwsh73mFd/1+ZUmgvdGLkCcleKbcbcnxphiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIr9gwA2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-207397d1000so12617885ad.0;
        Wed, 11 Sep 2024 19:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726109538; x=1726714338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2m9Y7VEzIdtTTSozHQvuk3QbiCNAmrj9ISK6fH2bqY=;
        b=iIr9gwA2EUS/iLOmXvXY0bJj7lxx9dZAJzHIMQHi2bk/gyKH8caImEkREhuF8d1NgE
         +SLqTtEtBRS13K5PVGn4GAxplhr0YM1lDqmYqWZxkRJ8YITRGg4PLXqXY5AexJkdzpyq
         VZSpsYvScUBpQVnMzeaNc1syCTr2Zkp1lH1o4TI//rdanUxxiPilzNkI8V5wPinoNytD
         kmRYD0vMhq81jd//fhahUnVeujNNr5EuwkfEyX+HElz1hqJEI+p/0JN+1es20SLKSxcV
         zLPwewsA4sxlNh1h4RB5asCsOp630E7SAH9BuUKxi8BaCggRx1XexR49Ttq/v6fhxTNm
         vKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726109538; x=1726714338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2m9Y7VEzIdtTTSozHQvuk3QbiCNAmrj9ISK6fH2bqY=;
        b=gm4HBgkubIN36kVVhTQ2vf61gs0+wldpt2TmQxDhjIgKRXzKCaitA+yN4JBLGMmlKF
         0E/yUyskABtjplmhstF3nSP3aW41qwI5QAKGFW8m3+Fg5ZH5hIvEretMCi/Y27B9Q7ti
         hdBAeqPLzafTN81FugmIrqckVlMnpcSZgurz9k5ehOjxEwl4RxAzBsXxCOJFZ/7sWqy2
         U8/+ZEFfqB+65tM3Zz0Ox1LBAORibNJ6rlrY2+aBzwwo1EfsQIypSOCe+IU0HZkD7Kcz
         CA8t6HtJP1KBpiacTQFDX/gpnJGOU61X6hJZh1fjDpOzVfVs2jyOprB753XSAQWibeTN
         i68w==
X-Forwarded-Encrypted: i=1; AJvYcCU7h5D+BCA/ajJfFxRHxHQ8YXL7J7l4YBTERmNfGJX+pOYjQidtnf9CTXUSMjsb9BUemgU7Uppn9ZVS@vger.kernel.org, AJvYcCWYASWJ6fFxvWjK4lDFR1LhL7KKFl8BEBh4JKxDLcELYAnYNsYVqs88QO4zfBVR6/XYiBnopcsMMPt+CLMd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/2Pk5GXeEdQKTRLVltNXKT9/3MhTOOaaGGJrkTREtCYSWYq6a
	3jerGFpDaXVAL3eXNjv+gJxZpSqPKw690gFLJjnDRd9ztTuveWK5
X-Google-Smtp-Source: AGHT+IGIsypAwH2BfcUev4iLPKNgb8VkdfI4kXvmWoMdEIHBfdzIHbtUfJ9hIl78NJDzFO5X8+CtTg==
X-Received: by 2002:a17:903:183:b0:205:7998:3deb with SMTP id d9443c01a7336-2074c6dcc54mr92045545ad.19.1726109537951;
        Wed, 11 Sep 2024 19:52:17 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00::315])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbbf877sm569023a12.50.2024.09.11.19.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 19:52:17 -0700 (PDT)
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
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 1/5] arm64: dts: rockchip: Split up RK3588's PCIe pinctrls
Date: Wed, 11 Sep 2024 19:50:30 -0700
Message-ID: <20240912025034.180233-2-CFSworks@gmail.com>
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

These pinctrls manage the low-speed PCIe signals:
- CLKREQ#: An output on the RK3588 (both RC or EP modes), used to
  request that external clock-generation circuitry provide a clock.
- PERST#: An input on the RK3588 in EP mode, used to detect a reset
  signal from the RC. In RC mode, the hardware does not use this signal:
  Linux itself generates it by putting the pin in GPIO mode.
- WAKE#: In EP mode, this is an output; in RC mode, this is an input.

Each of these signals serves a distinct purpose, and more importantly,
PERST# should not be muxed when the RK3588 is in the RC role. Bundling
them together in pinctrl groups prevents proper use: indeed, almost none
of the current board-specific .dts files make any use of them.
(Exception: Rock 5A recently had a patch land that misuses _pins; this
 patch corrects that.)

However, on some RK3588 boards, the PCIe 3 controller will indefinitely
stall the boot if CLKREQ# is not muxed (details in the next patch).
This patch unbundles the signals to allow them to be used.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 .../dts/rockchip/rk3588-base-pinctrl.dtsi     | 271 ++++++++++++++----
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     |   6 +-
 2 files changed, 228 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
index d1368418502a..7f874c77410c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
@@ -1612,23 +1612,43 @@ npu_pins: npu-pins {
 
 	pcie20x1 {
 		/omit-if-no-ref/
-		pcie20x1m0_pins: pcie20x1m0-pins {
+		pcie20x1m0_clkreqn: pcie20x1m0-clkreqn {
 			rockchip,pins =
 				/* pcie20x1_2_clkreqn_m0 */
-				<3 RK_PC7 4 &pcfg_pull_none>,
+				<3 RK_PC7 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie20x1m0_perstn: pcie20x1m0-perstn {
+			rockchip,pins =
 				/* pcie20x1_2_perstn_m0 */
-				<3 RK_PD1 4 &pcfg_pull_none>,
+				<3 RK_PD1 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie20x1m0_waken: pcie20x1m0-waken {
+			rockchip,pins =
 				/* pcie20x1_2_waken_m0 */
 				<3 RK_PD0 4 &pcfg_pull_none>;
 		};
 
 		/omit-if-no-ref/
-		pcie20x1m1_pins: pcie20x1m1-pins {
+		pcie20x1m1_clkreqn: pcie20x1m1-clkreqn {
 			rockchip,pins =
 				/* pcie20x1_2_clkreqn_m1 */
-				<4 RK_PB7 4 &pcfg_pull_none>,
+				<4 RK_PB7 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie20x1m1_perstn: pcie20x1m1-perstn {
+			rockchip,pins =
 				/* pcie20x1_2_perstn_m1 */
-				<4 RK_PC1 4 &pcfg_pull_none>,
+				<4 RK_PC1 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie20x1m1_waken: pcie20x1m1-waken {
+			rockchip,pins =
 				/* pcie20x1_2_waken_m1 */
 				<4 RK_PC0 4 &pcfg_pull_none>;
 		};
@@ -1654,52 +1674,127 @@ pcie30phy_pins: pcie30phy-pins {
 
 	pcie30x1 {
 		/omit-if-no-ref/
-		pcie30x1m0_pins: pcie30x1m0-pins {
+		pcie30x1m0_0_clkreqn: pcie30x1m0-0-clkreqn {
 			rockchip,pins =
 				/* pcie30x1_0_clkreqn_m0 */
-				<0 RK_PC0 12 &pcfg_pull_none>,
+				<0 RK_PC0 12 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x1m0_0_perstn: pcie30x1m0-0-perstn {
+			rockchip,pins =
 				/* pcie30x1_0_perstn_m0 */
-				<0 RK_PC5 12 &pcfg_pull_none>,
+				<0 RK_PC5 12 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x1m0_0_waken: pcie30x1m0-0-waken {
+			rockchip,pins =
 				/* pcie30x1_0_waken_m0 */
-				<0 RK_PC4 12 &pcfg_pull_none>,
+				<0 RK_PC4 12 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x1m0_1_clkreqn: pcie30x1m0-1-clkreqn {
+			rockchip,pins =
 				/* pcie30x1_1_clkreqn_m0 */
-				<0 RK_PB5 12 &pcfg_pull_none>,
+				<0 RK_PB5 12 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x1m0_1_perstn: pcie30x1m0-1-perstn {
+			rockchip,pins =
 				/* pcie30x1_1_perstn_m0 */
-				<0 RK_PB7 12 &pcfg_pull_none>,
+				<0 RK_PB7 12 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x1m0_1_waken: pcie30x1m0-1-waken {
+			rockchip,pins =
 				/* pcie30x1_1_waken_m0 */
 				<0 RK_PB6 12 &pcfg_pull_none>;
 		};
 
 		/omit-if-no-ref/
-		pcie30x1m1_pins: pcie30x1m1-pins {
+		pcie30x1m1_0_clkreqn: pcie30x1m1-0-clkreqn {
 			rockchip,pins =
 				/* pcie30x1_0_clkreqn_m1 */
-				<4 RK_PA3 4 &pcfg_pull_none>,
+				<4 RK_PA3 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x1m1_0_perstn: pcie30x1m1-0-perstn {
+			rockchip,pins =
 				/* pcie30x1_0_perstn_m1 */
-				<4 RK_PA5 4 &pcfg_pull_none>,
+				<4 RK_PA5 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x1m1_0_waken: pcie30x1m1-0-waken {
+			rockchip,pins =
 				/* pcie30x1_0_waken_m1 */
-				<4 RK_PA4 4 &pcfg_pull_none>,
+				<4 RK_PA4 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x1m1_1_clkreqn: pcie30x1m1-1-clkreqn {
+			rockchip,pins =
 				/* pcie30x1_1_clkreqn_m1 */
-				<4 RK_PA0 4 &pcfg_pull_none>,
+				<4 RK_PA0 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x1m1_1_perstn: pcie30x1m1-1-perstn {
+			rockchip,pins =
 				/* pcie30x1_1_perstn_m1 */
-				<4 RK_PA2 4 &pcfg_pull_none>,
+				<4 RK_PA2 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x1m1_1_waken: pcie30x1m1-1-waken {
+			rockchip,pins =
 				/* pcie30x1_1_waken_m1 */
 				<4 RK_PA1 4 &pcfg_pull_none>;
 		};
 
 		/omit-if-no-ref/
-		pcie30x1m2_pins: pcie30x1m2-pins {
+		pcie30x1m2_0_clkreqn: pcie30x1m2-0-clkreqn {
 			rockchip,pins =
 				/* pcie30x1_0_clkreqn_m2 */
-				<1 RK_PB5 4 &pcfg_pull_none>,
+				<1 RK_PB5 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x1m2_0_perstn: pcie30x1m2-0-perstn {
+			rockchip,pins =
 				/* pcie30x1_0_perstn_m2 */
-				<1 RK_PB4 4 &pcfg_pull_none>,
+				<1 RK_PB4 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x1m2_0_waken: pcie30x1m2-0-waken {
+			rockchip,pins =
 				/* pcie30x1_0_waken_m2 */
-				<1 RK_PB3 4 &pcfg_pull_none>,
+				<1 RK_PB3 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x1m2_1_clkreqn: pcie30x1m2-1-clkreqn {
+			rockchip,pins =
 				/* pcie30x1_1_clkreqn_m2 */
-				<1 RK_PA0 4 &pcfg_pull_none>,
+				<1 RK_PA0 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x1m2_1_perstn: pcie30x1m2-1-perstn {
+			rockchip,pins =
 				/* pcie30x1_1_perstn_m2 */
-				<1 RK_PA7 4 &pcfg_pull_none>,
+				<1 RK_PA7 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x1m2_1_waken: pcie30x1m2-1-waken {
+			rockchip,pins =
 				/* pcie30x1_1_waken_m2 */
 				<1 RK_PA1 4 &pcfg_pull_none>;
 		};
@@ -1721,45 +1816,85 @@ pcie30x1_1_button_rstn: pcie30x1-1-button-rstn {
 
 	pcie30x2 {
 		/omit-if-no-ref/
-		pcie30x2m0_pins: pcie30x2m0-pins {
+		pcie30x2m0_clkreqn: pcie30x2m0-clkreqn {
 			rockchip,pins =
 				/* pcie30x2_clkreqn_m0 */
-				<0 RK_PD1 12 &pcfg_pull_none>,
+				<0 RK_PD1 12 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x2m0_perstn: pcie30x2m0-perstn {
+			rockchip,pins =
 				/* pcie30x2_perstn_m0 */
-				<0 RK_PD4 12 &pcfg_pull_none>,
+				<0 RK_PD4 12 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x2m0_waken: pcie30x2m0-waken {
+			rockchip,pins =
 				/* pcie30x2_waken_m0 */
 				<0 RK_PD2 12 &pcfg_pull_none>;
 		};
 
 		/omit-if-no-ref/
-		pcie30x2m1_pins: pcie30x2m1-pins {
+		pcie30x2m1_clkreqn: pcie30x2m1-clkreqn {
 			rockchip,pins =
 				/* pcie30x2_clkreqn_m1 */
-				<4 RK_PA6 4 &pcfg_pull_none>,
+				<4 RK_PA6 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x2m1_perstn: pcie30x2m1-perstn {
+			rockchip,pins =
 				/* pcie30x2_perstn_m1 */
-				<4 RK_PB0 4 &pcfg_pull_none>,
+				<4 RK_PB0 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x2m1_waken: pcie30x2m1-waken {
+			rockchip,pins =
 				/* pcie30x2_waken_m1 */
 				<4 RK_PA7 4 &pcfg_pull_none>;
 		};
 
 		/omit-if-no-ref/
-		pcie30x2m2_pins: pcie30x2m2-pins {
+		pcie30x2m2_clkreqn: pcie30x2m2-clkreqn {
 			rockchip,pins =
 				/* pcie30x2_clkreqn_m2 */
-				<3 RK_PD2 4 &pcfg_pull_none>,
+				<3 RK_PD2 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x2m2_perstn: pcie30x2m2-perstn {
+			rockchip,pins =
 				/* pcie30x2_perstn_m2 */
-				<3 RK_PD4 4 &pcfg_pull_none>,
+				<3 RK_PD4 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x2m2_waken: pcie30x2m2-waken {
+			rockchip,pins =
 				/* pcie30x2_waken_m2 */
 				<3 RK_PD3 4 &pcfg_pull_none>;
 		};
 
 		/omit-if-no-ref/
-		pcie30x2m3_pins: pcie30x2m3-pins {
+		pcie30x2m3_clkreqn: pcie30x2m3-clkreqn {
 			rockchip,pins =
 				/* pcie30x2_clkreqn_m3 */
-				<1 RK_PD7 4 &pcfg_pull_none>,
+				<1 RK_PD7 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x2m3_perstn: pcie30x2m3-perstn {
+			rockchip,pins =
 				/* pcie30x2_perstn_m3 */
-				<1 RK_PB7 4 &pcfg_pull_none>,
+				<1 RK_PB7 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x2m3_waken: pcie30x2m3-waken {
+			rockchip,pins =
 				/* pcie30x2_waken_m3 */
 				<1 RK_PB6 4 &pcfg_pull_none>;
 		};
@@ -1774,45 +1909,85 @@ pcie30x2_button_rstn: pcie30x2-button-rstn {
 
 	pcie30x4 {
 		/omit-if-no-ref/
-		pcie30x4m0_pins: pcie30x4m0-pins {
+		pcie30x4m0_clkreqn: pcie30x4m0-clkreqn {
 			rockchip,pins =
 				/* pcie30x4_clkreqn_m0 */
-				<0 RK_PC6 12 &pcfg_pull_none>,
+				<0 RK_PC6 12 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x4m0_perstn: pcie30x4m0-perstn {
+			rockchip,pins =
 				/* pcie30x4_perstn_m0 */
-				<0 RK_PD0 12 &pcfg_pull_none>,
+				<0 RK_PD0 12 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x4m0_waken: pcie30x4m0-waken {
+			rockchip,pins =
 				/* pcie30x4_waken_m0 */
 				<0 RK_PC7 12 &pcfg_pull_none>;
 		};
 
 		/omit-if-no-ref/
-		pcie30x4m1_pins: pcie30x4m1-pins {
+		pcie30x4m1_clkreqn: pcie30x4m1-clkreqn {
 			rockchip,pins =
 				/* pcie30x4_clkreqn_m1 */
-				<4 RK_PB4 4 &pcfg_pull_none>,
+				<4 RK_PB4 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x4m1_perstn: pcie30x4m1-perstn {
+			rockchip,pins =
 				/* pcie30x4_perstn_m1 */
-				<4 RK_PB6 4 &pcfg_pull_none>,
+				<4 RK_PB6 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x4m1_waken: pcie30x4m1-waken {
+			rockchip,pins =
 				/* pcie30x4_waken_m1 */
 				<4 RK_PB5 4 &pcfg_pull_none>;
 		};
 
 		/omit-if-no-ref/
-		pcie30x4m2_pins: pcie30x4m2-pins {
+		pcie30x4m2_clkreqn: pcie30x4m2-clkreqn {
 			rockchip,pins =
 				/* pcie30x4_clkreqn_m2 */
-				<3 RK_PC4 4 &pcfg_pull_none>,
+				<3 RK_PC4 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x4m2_perstn: pcie30x4m2-perstn {
+			rockchip,pins =
 				/* pcie30x4_perstn_m2 */
-				<3 RK_PC6 4 &pcfg_pull_none>,
+				<3 RK_PC6 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x4m2_waken: pcie30x4m2-waken {
+			rockchip,pins =
 				/* pcie30x4_waken_m2 */
 				<3 RK_PC5 4 &pcfg_pull_none>;
 		};
 
 		/omit-if-no-ref/
-		pcie30x4m3_pins: pcie30x4m3-pins {
+		pcie30x4m3_clkreqn: pcie30x4m3-clkreqn {
 			rockchip,pins =
 				/* pcie30x4_clkreqn_m3 */
-				<1 RK_PB0 4 &pcfg_pull_none>,
+				<1 RK_PB0 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x4m3_perstn: pcie30x4m3-perstn {
+			rockchip,pins =
 				/* pcie30x4_perstn_m3 */
-				<1 RK_PB2 4 &pcfg_pull_none>,
+				<1 RK_PB2 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie30x4m3_waken: pcie30x4m3-waken {
+			rockchip,pins =
 				/* pcie30x4_waken_m3 */
 				<1 RK_PB1 4 &pcfg_pull_none>;
 		};
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 294b99dd50da..87fce8d9a964 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -310,7 +310,7 @@ rgmii_phy1: ethernet-phy@1 {
 };
 
 &pcie2x1l2 {
-	pinctrl-0 = <&pcie20x1m0_pins>;
+	pinctrl-0 = <&pcie2_reset>, <&pcie20x1m0_clkreqn>, <&pcie20x1m0_waken>;
 	pinctrl-names = "default";
 	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_wf>;
@@ -328,6 +328,10 @@ pcie {
 		pow_en: pow-en {
 			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+
+		pcie2_reset: pcie2-reset {
+			rockchip,pins = <3 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 
 	power {
-- 
2.44.2


