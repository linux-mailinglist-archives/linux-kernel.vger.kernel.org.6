Return-Path: <linux-kernel+bounces-344842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0E398AED7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF941F21C92
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39941A255F;
	Mon, 30 Sep 2024 21:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aewxxuq0"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A00194082;
	Mon, 30 Sep 2024 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727730451; cv=none; b=g1+VPlnrL6IzpIlDxTyWCiQUjWh3LTG6fZKOYfkbaBXvCS4llHxE8p/N/0CjF6iRzUxRPD4cvuAk+Jm3QSiX2LvA9HXHiq1O1T+0N7JxSNclJyHeeBHnL3zU/6/QLYRnBOWdvYR8g3+QV/F0rOPAonRDEk5XwZcdCaMn3xTKq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727730451; c=relaxed/simple;
	bh=MIuwoDgLe2AxxsbXxhhQTFYaYYVJ0K9c35h1FQ6Gdtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MzpK73YPGxMtbAWVmAqcaliRDwx1csDHE7uCfUcBlasPwXygDW67qvmFKCNh4wAWtF67yAERVJYzoylaikavNFs5s7Ryvb5ov2HQBwXGK7xGw7Gpaux65BhtGBOQ9Qo25WcW84n4t/aBjVy8z2VTnknbBsC+V3MhCaf2x/cdYWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aewxxuq0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71b0722f221so3701601b3a.3;
        Mon, 30 Sep 2024 14:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727730449; x=1728335249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kzJZvIAboYocgxdwgFUevxFj0WeoKQNCloTNimtHndQ=;
        b=aewxxuq0whYgz5yze68pxGjgVdnfo+iLqebWIwRM/a41LO7Q+dBVwyC0DtbH1NOER1
         TzZavl+kcDMQrvJoKo5+E1SEgwbxZDd54zgVZIRGAiyrYME3qnI6KJtXJOfsLoWgqr24
         uddxz2DA852yrOYOIa8d/ou1tZrvJ3QR8+KMdtSCoU6zWDbom/Rsz2Yl6Qf5K6+FszCE
         PKxzoxc9cvlBIg1QQ3+bfX0MgK9pljfWsUx87GhMZqjrtujARacwSyR5lpsyfn61kSgK
         mgDa4CulX/UMiFCPLLTaU03BfjZeq0cFvUhTmy/ZObcqvmxSpblNh7j9B+zJYHT1kxkB
         HSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727730449; x=1728335249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzJZvIAboYocgxdwgFUevxFj0WeoKQNCloTNimtHndQ=;
        b=pcCvfRVwEWVs3B2547hD0YPTpC0SXxYE9vXVpG+BPAR5jQLKYcrO7EsFG4wk896wrm
         71pFNyd7W8rbQTQW6qngeKEsN2nJgEpwlZDmtyi1Q6O40l39hnYybZkEN5tKZqBmPJL6
         yqTrBQpbgesjvJBc4pBY1xwVjHB157uVqm07cyS0KK8EsyT/psp4BLLNA1BA6RGax2KR
         eGXGUxYK/mJXju3ExBDZEBule2VA9HccJBkL44t5TAkoiBG3vPAe5IF3i7xGXWDv/agZ
         Zaa/GtVXvX6MIJuvnHSdZqPHelYuepm+R4M+lGGtQv0cI62oISszxWj2tJ10GlyGvvhU
         0bKg==
X-Forwarded-Encrypted: i=1; AJvYcCV8GFCV6mxc6hVuz32MNK88F8bQuilGJH9zkfEyoiqy/J+mnhWu3oA+LaFa9Wmdm0at7OuvNGCgEzMd@vger.kernel.org, AJvYcCWjeaucIy4MnR8gV1vXgPzCnf2mHK8YpQG/kM37mDwjOV05p7kUIEcNDf5WwQcOFri4fDj3fHdqkHjdEE4L@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9YIu41cDCOC49xl4gYGnsvfNttquco7ThxCA7954Bz7RSkYVB
	hBhI1MAlpNbfVmpIlGrWKJT3/yJVIVsgXXeryWTcjMz5DqpktMDcwrGM4X1lCC0=
X-Google-Smtp-Source: AGHT+IHunwyc/wkH7CD68flB2cwYZ/fEV5URz+9NNo3tl2FP3eO4wQo9g7Uyz5g3jz0dhYU2qa9Wsw==
X-Received: by 2002:a05:6a00:22cc:b0:705:c0a1:61c9 with SMTP id d2e1a72fcca58-71b25f45f2dmr18712842b3a.9.1727730448999;
        Mon, 30 Sep 2024 14:07:28 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00:f1c9:3376:480c:3b08])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26537e8dsm6683220b3a.203.2024.09.30.14.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 14:07:28 -0700 (PDT)
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
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2] arm64: dts: rockchip: Enable all 3 USBs on Turing RK1
Date: Mon, 30 Sep 2024 14:06:52 -0700
Message-ID: <20240930210652.1232951-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
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

Future work will be needed on USB0: it is not USB3-capable, so the USB0
controller needs to be told that there is no USB3 port. Per Jonas's
suggestion, the USBDP0 node is given a `rockchip,dp-lane-mux` property
that tells the USBDP driver that USBDP0 is not involved in USB so that
it can make the necessary configuration changes in hardware.
Technically, this is USB *controller* configuration, not *PHY*
configuration, so the underlying code may be moved in the future to the
USB controller driver instead, freeing up the (software) dependency on
USBDP0. A TODO comment is added to explain this.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Suggested-by: Jonas Karlman <jonas@kwiboo.se>

---

Happy Monday folks,

This is an updated version of one patch broken out from my previous series [1]
that enables USB on the Turing RK1 SoM.

Changes v1->v2:
- `rockchip,dp-lane-mux` added to tell USBDP0 explicitly that it is not
  involved in USB (thanks Jonas)
- Comment updated to more accurately reflect the situation, and to use one- not
  two-space-per-sentence style.

Kind regards,
Sam

[1]: https://lore.kernel.org/lkml/20240912025034.180233-1-CFSworks@gmail.com/T/
---
 .../boot/dts/rockchip/rk3588-turing-rk1.dtsi  | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
index 0c4d809a860e..cdc525a8b157 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
@@ -683,3 +683,68 @@ &uart9 {
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
+	 * TODO: On the RK1, USBDP0 drives the DisplayPort pins and is not
+	 * involved in this USB2-only bus. The bus controller (below) needs to
+	 * know that it doesn't have a USB3 port so it can ignore any
+	 * USB3-related signals. This is handled in hardware by updating the
+	 * GRFs corresponding to that bus controller. Alas, Linux currently
+	 * puts the code to do that in the USBDP driver, so USBDP0 must be
+	 * enabled for now.
+	 */
+	status = "okay";
+	rockchip,dp-lane-mux = <0 1 2 3>; /* "No USB lanes" */
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


