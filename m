Return-Path: <linux-kernel+bounces-519317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E9CA39B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7F13B49DE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056C22417C6;
	Tue, 18 Feb 2025 11:55:16 +0000 (UTC)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE09240613
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879715; cv=none; b=lCPaXXPcUTmxq+iV5FxM8pDB7Ulfxhvj4RqRZKlX3JWS+Fd5tVb33unNAoemdOvCTCy//TWit7gn5AqtbG/VZPc5x1kANdpECJUCYF4wn1tCNgUCQx/XZg++U8veCLZM8iTgHrOTrojesG/39zgq8XZX7F1sYbmvy0L2w/INIfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879715; c=relaxed/simple;
	bh=FhCqxLQkgt7EE34RfFpYbVg7c/EXcIhB49j48kvMS1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XpjSoxubH6x6bV7cp+sQOfRH6325qwtqBQTJAxgxKCOvTmPyAHrRzZTGbrZ07dTfZ5gSHPxwM9/fK3LZNAFJBCE/Zt2CmIa68Fdm8qs5BnrurUDScBl7LsA9NBQOw3mxulcqTm+4Vf9D5mgqnGJ6fhH+tC72htf+O0yXWCP/jgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YxyVd6cw2z3GT;
	Tue, 18 Feb 2025 12:49:29 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YxyVd2XrpzkJJ;
	Tue, 18 Feb 2025 12:49:29 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Tue, 18 Feb 2025 12:49:12 +0100
Subject: [PATCH 1/9] arm64: dts: rockchip: enable UART5 on RK3588 Tiger
 Haikou
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-tsd-align-haikou-v1-1-5c44d1dd8658@cherry.de>
References: <20250218-tsd-align-haikou-v1-0-5c44d1dd8658@cherry.de>
In-Reply-To: <20250218-tsd-align-haikou-v1-0-5c44d1dd8658@cherry.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@cherry.de>

In its default configuration (SW2 on "UART1"), UART5 is exposed on the
DB9 RS232/RS485 connector. While the same signals are also exposed on
Q7_GPIO5 and Q7_GPIO6, a GPIO header, and thus could be used for other
purposes, RK3399 Puma Haikou and PX30 Ringneck Haikou do enable the UART
controller exposed on the DB9 connector, so let's keep consistency
across our modules and enable it on RK3588 Tiger Haikou by default too.

Add a comment while at it to explicit where this controller is routed
to.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
index 3187b4918a300dae49fe05d760fb7e1fd55f14d5..7bd07e5026ed914063965c9f1ec6a29357b0c05d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
@@ -310,8 +310,10 @@ &uart2 {
 	status = "okay";
 };
 
+/* DB9 RS232/RS485 when SW2 in "UART1" mode */
 &uart5 {
 	rts-gpios = <&gpio3 RK_PB3 GPIO_ACTIVE_HIGH>;
+	status = "okay";
 };
 
 &usbdp_phy0 {

-- 
2.48.1


