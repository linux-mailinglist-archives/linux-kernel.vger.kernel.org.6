Return-Path: <linux-kernel+bounces-390054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0029B74FC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D511F21452
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A9E17BEA2;
	Thu, 31 Oct 2024 07:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="QM+yJxZT"
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A289C14D433;
	Thu, 31 Oct 2024 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730358215; cv=none; b=idcSO+KtQLMXwvI534MoqmmM4VvrgxtvqizHQ7/4gWDBxohqpTB2Dtbr2TKDH+pFjQI5UHdvDytzzkknBzNUvZuLClvv2+4mzKCfm7Zr8HN6HzCHuWDX9FvjSNJkTyhC0HPXlYcAJPfv6C5D87A2JV9XirFN8RIK493MaTyCsDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730358215; c=relaxed/simple;
	bh=gWgh78qYIAfAOa8H5RFKaOcp8FXFvpf47/zA/jM4dGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzpZK930duolc28QcJZIVBwl9m2QJGxV0Cb/XFXUXgUNZceI1NK/xgvOJ1IdjzjiJ2eTze7JBVO0nGkirbfbw3ORxxzptXHmDiju563a8skHQogZMWCgjMXH/7hrtTk8rVMl7x+HY2XPgp1ACQ5sDGdlD88kjzPTLGcRAI13s5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=QM+yJxZT; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730358205;
	bh=gWgh78qYIAfAOa8H5RFKaOcp8FXFvpf47/zA/jM4dGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QM+yJxZTgU8QBuzMFjJT2Q5MgjOwsMRUAAEx9Y0ZPVmxoBEWSw1WC2z07YDGB7Zup
	 X+fy/B07X4jSRpwUAJz31K6/lIdrYc/j6Wf5o/2r3vG88JiNI7LwzYstgnudHG1oTg
	 yyWLso51ZQwrfa6tsZumZj3eKMAW7e/nszZ5eTlsPfjXhufW+iWHEt2r+o+Y9ljhJO
	 dvoNpGXKL857H1sJ0w2q0ogRxjq+6Sw5TohkwJwwaFPrWVjUO4lukVzev/Vdb2QcBd
	 Jgg7k3Qm8uU5QeYxkL53OMqPvFTy2DqD7Qdm7MMeoXTTd+eTh/QJUmbplq3Yi+/xwJ
	 +igzx/0NjEarw==
X-Virus-Scanned: by epochal.quest
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Nishanth Menon <nm@ti.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Parthiban <parthiban@linumiz.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Cody Eksal <masterr3c0rd@epochal.quest>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/13] arm64: dts: allwinner: a100: perf1: Add eMMC and MMC node
Date: Thu, 31 Oct 2024 04:02:23 -0300
Message-ID: <20241031070232.1793078-11-masterr3c0rd@epochal.quest>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yangtao Li <frank@allwinnertech.com>

A100 perf1 hava MicroSD slot and on-board eMMC module, add support for them.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
---
 .../allwinner/sun50i-a100-allwinner-perf1.dts    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
index 2f8c7ee60283..d418fc272b3c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
@@ -39,6 +39,22 @@ &ehci1 {
 	status = "okay";
 };
 
+&mmc0 {
+	vmmc-supply = <&reg_dcdc1>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	bus-width = <4>;
+	status = "okay";
+};
+
+&mmc2 {
+	vmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_aldo1>;
+	cap-mmc-hw-reset;
+	non-removable;
+	bus-width = <8>;
+	status = "okay";
+};
+
 &ohci0 {
 	status = "okay";
 };
-- 
2.47.0


