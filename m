Return-Path: <linux-kernel+bounces-325869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3084E975F44
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41F67B23927
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F0A155744;
	Thu, 12 Sep 2024 02:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws2uGbT4"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B591448ED;
	Thu, 12 Sep 2024 02:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109544; cv=none; b=kB3cNGdR0nQBZCpgBWTRtjyooOJzOOEkf++zbotlU85r4tg/5qsL0bWkfkmPzzk1VSk2FCU6ULRgZTPW/1Y+96e4iOOEEfPPjV2kq+1NQQF9xQ2y+PsaJoHa/GR+z5xs+ak/92kygd7275H/ucOIKX3AwFsbrydTFJtHmSIiQq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109544; c=relaxed/simple;
	bh=eFshhq/w2LQpCyZE9oL7aOlH/OX//62jxTyd0+J6kqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4HnF9tYL9cxueP8rUWBFJqHWiJUQQeKPWw1y7e2b+xz62bI4u/rn/lTCTMFiFfCEW4qjp9p4wkCGYtcgNANnscp9hnNzes7A4gx7caQeQYxrLlcErDmR8RtYzkKH1OpD3m0Dqdmyky7PXPrhn+3vK6HWAtVU1Hojwz/geuprFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws2uGbT4; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso337676a12.1;
        Wed, 11 Sep 2024 19:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726109543; x=1726714343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFtA1zNl0EVlgDNkgP1T2Lcb30Px4NHbKM0hs5oTZwI=;
        b=Ws2uGbT4JUIqxkIjxxCJbR3c5jmh2x72K4R6BIqt56ogxR9xmISvyuXKlVFmAmTuvC
         CVyo56tYIZuWI+DSko1tQp9HyDQS6ny42YULoZ2WtlxrqinjthaWqd9l2HdPXd9dmN+U
         jEuCdW9AqEQ3KijGEEDOR4DVXdNd/hFiJhvoQcMbmJNbwImQ4aCA7t70cGmZ4LBBAFqZ
         pUjSY9syngf/0RRCbNO8jNTMtVGYku4VZgYgRgM0s6oxogQYC1x4UC1+SA9xfQPtEivp
         v2G0ysaLoTLX43j0v5tAYulGEa61ZTQrvJFI4MA04cXc4MOt5RuC917ErHckChkyJDhY
         D7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726109543; x=1726714343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFtA1zNl0EVlgDNkgP1T2Lcb30Px4NHbKM0hs5oTZwI=;
        b=Vtg5xRZfUCHp6obfyQjSaPps+JcLtp7v2175b5BGOXfXMU7WrA2a+6L4nluB56HXQK
         49PAZw76XVC5FZJ5VKCxNsNZXomeAnK8hr93XS0lSFSH5cloHY0YlR0bRaknzAxvipCr
         2CH9ixCIBq9b8+RiI6oy/H3nG6nWdOom0j9NuUhTnYLnSf3PJgihlRkfy8cHkZP7qvf/
         eWqjGS9UTRJT1KReCTQBpLYrylBlWKoEcV9A2xnliBCEK+C1n0xHe2840IidWeDJcr7b
         usLeSuMmVBRLx9DiOCoOuO6/XkZkRPyOclPCT0HG1HMsOBSYjxw1xLTRC7H56U/KM+Lt
         7CTw==
X-Forwarded-Encrypted: i=1; AJvYcCUE6owHEo+PpXYl98HyyIK9YfjffiLUqZMgSyu81+K6Tr+ztLYX1urvt5h5629/dCFMZDJ+1VF13lsu@vger.kernel.org, AJvYcCUiyLrVXb+ln88xs0vkN//CPoeCNulP9I8okan1XyPZWzABxDY3zaFDc5P7I6T7tEqma8G6iyE2cqgPP4Lt@vger.kernel.org
X-Gm-Message-State: AOJu0YxWy/mz1NczHAWQj+ZVoww5Oy8ZWJFO2F718zmgo1O/j5ib3Md+
	ZBpQLrMwHvU4/nG4l8kqj3h4jCs+NuFIPQORA17gZ5W547dWGwkY
X-Google-Smtp-Source: AGHT+IForzEpWW/rjBRT7z81T61S+onZhDsyAet84xKc8CSzbJ3Vaqylg0VDpVe4V9IaQ398uZeILw==
X-Received: by 2002:a05:6a21:710a:b0:1cf:2fe2:a74c with SMTP id adf61e73a8af0-1cf761e58camr1685065637.31.1726109542572;
        Wed, 11 Sep 2024 19:52:22 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00::315])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbbf877sm569023a12.50.2024.09.11.19.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 19:52:21 -0700 (PDT)
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
Subject: [PATCH 4/5] arm64: dts: rockchip: Enable all 3 USBs on Turing RK1
Date: Wed, 11 Sep 2024 19:50:33 -0700
Message-ID: <20240912025034.180233-5-CFSworks@gmail.com>
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

The Turing RK1 contains 3 different USBs:
- USB0: USB 2.0, OTG
- USB1: USB 3.0, host
- USB2: USB 2.0, host

This patch activates the necessary DT nodes to enable all 3 buses.

Future work will be needed on USB0: it is not USB 3.0, but Linux creates
an unused USB 3.0 root hub and the controller also requires that USBDP0
be powered up. However, it is possible to remove this dependency. By
either patching the xHCI driver to ignore the enumerated USB 3.0 port or
setting usb3otg0_host_num_u3_port=0 in the GRF to stop the controller
from enumerating a USB 3.0 port in the first place, neither Linux nor
the controller will expect USB 3.0 capability, and USBDP0 can then
safely be removed from the `phys` property.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 .../boot/dts/rockchip/rk3588-turing-rk1.dtsi  | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
index f6a12fe12d45..6036c4fe6727 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
@@ -666,3 +666,67 @@ &uart9 {
 	pinctrl-0 = <&uart9m0_xfer>;
 	status = "okay";
 };
+
+/* USB 0: USB 2.0 only, OTG-capable */
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
+&usbdp_phy0 {
+	/*
+	 * TODO: On the RK1, USBDP0 drives the DisplayPort pins, and is not
+	 * involved in this USB2-only bus.  However, if the USB3 port is
+	 * enabled in the xHCI below, the controller will expect this PHY to be
+	 * powered up and holding RX_STATUS idle, or else it will generate an
+	 * endless stream of CSC events whenever a device is plugged in.  Until
+	 * there is a way to communicate to usb_host0_xhci that it doesn't have
+	 * a USB3 port, we have no choice but to power up USBDP0.
+	 */
+	status = "okay";
+};
+
+&usb_host0_xhci {
+	extcon = <&u2phy0>;
+	maximum-speed = "high-speed";
+	status = "okay";
+};
+
+/* USB 1: USB 3.0, host only */
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy1_otg {
+	status = "okay";
+};
+
+&usbdp_phy1 {
+	status = "okay";
+};
+
+&usb_host1_xhci {
+	extcon = <&u2phy1>;
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* USB 2: USB 2.0, host only */
+&u2phy2 {
+	status = "okay";
+};
+
+&u2phy2_host {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
-- 
2.44.2


