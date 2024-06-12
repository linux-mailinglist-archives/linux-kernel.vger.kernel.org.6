Return-Path: <linux-kernel+bounces-212243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3246E905D37
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1BE9B22E33
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2E612BF1B;
	Wed, 12 Jun 2024 20:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="Xv3IXYUr"
Received: from shout12.mail.de (shout12.mail.de [62.201.172.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6D7126F1A;
	Wed, 12 Jun 2024 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225670; cv=none; b=O6zPH475RjUEMBolJy+Y4KLql9O3nwOZ0IFWH3xqJ44YayarbRaHHcqypHxD4/DRS/UZlrCVf67Tm39jmQb5+9pxWEonPXiryn2ydFiLzhPrCS/rw6phmP2fFhB1hqEespOQCBO1XzXgKoWWSrYcTpInL9NXfDRitNOKG/kHK64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225670; c=relaxed/simple;
	bh=BvUjBepg9rtChkeT/pdj72DFwlLCiHqhtDRbHO1RpT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3jDUw//sLn7t99duThttuCTWpXwBPE7PoeCe8GpvtLtDnlxiX/eMA5kLE96AQylIwgVPRSbqLRf37mCkV0pSmpTzlnB4sqfcKSkGvMc5B4359VseqD6qsSwefB2ZCNzisT/2ietcVsmMkQPW6rl5s/Kqtz1WiOPEUvv0nvZs6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=Xv3IXYUr; arc=none smtp.client-ip=62.201.172.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from shout02.mail.de (unknown [10.0.120.222])
	by shout12.mail.de (Postfix) with ESMTPS id 6B134241947;
	Wed, 12 Jun 2024 22:54:20 +0200 (CEST)
Received: from postfix03.mail.de (postfix03.bt.mail.de [10.0.121.127])
	by shout02.mail.de (Postfix) with ESMTP id 542CB240B18;
	Wed, 12 Jun 2024 22:54:20 +0200 (CEST)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
	by postfix03.mail.de (Postfix) with ESMTP id 3320480192;
	Wed, 12 Jun 2024 22:54:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1718225660;
	bh=BvUjBepg9rtChkeT/pdj72DFwlLCiHqhtDRbHO1RpT8=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
	b=Xv3IXYUrqafsca3VME6fWD8IiJ3nt1og0+DXjskBitKFPJxsDC965JFd4S7ChlpY7
	 0ixR5w1dnZsZb9xt4ZFM9+G39Ql+/aTSKPhwF9HXtRkP0QLG7R62ZxTOgCd3HvB93X
	 RXQx6uwFVWSvNdvjctYGeKrYT+hLvmW36YF29tSPzyv8LTwAouwLYRBcwzPbNMYWR7
	 maFfFrhl/Sdqi6YJbE//Qh14egbjgfA3qwe0GkafI2e470eBMyrL0WTBabuNO0X0eH
	 g0hJIH+j0Iwj6HflJY7VBgaWpR55FTwUxmJuULy6QJy7CuwHKqnMQNzFkWBTa8vRf9
	 anOXKckBUeLdw==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id 251F52400C1;
	Wed, 12 Jun 2024 22:54:19 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: rockchip: Enable lower USB3 port on NanoPi R6C/R6S
Date: Wed, 12 Jun 2024 22:48:13 +0200
Message-ID: <20240612205056.397204-5-seb-dev@mail.de>
In-Reply-To: <20240612205056.397204-1-seb-dev@mail.de>
References: <20240612205056.397204-1-seb-dev@mail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 1458
X-purgate-ID: 154282::1718225659-FE5BF670-EFB7948E/0/0

Enable support for the lower USB 3.0 Type-A port on the NanoPi R6C and
NanoPi R6S. The upper USB 2.0 Type-A port is already supported.

Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
---
 .../boot/dts/rockchip/rk3588s-nanopi-r6.dtsi  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
index 69d0f1f2349b..9676e7194451 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
@@ -740,6 +740,17 @@ &tsadc {
 	status = "okay";
 };
 
+/* USB2 PHY for USB 3.0 Type-A (lower port)*/
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	phy-supply = <&vcc5v0_usb_otg0>;
+	status = "okay";
+};
+
+/* USB2 PHY for USB 2.0 Type-A (upper port)*/
 &u2phy2 {
 	status = "okay";
 };
@@ -755,10 +766,27 @@ &uart2 {
 	status = "okay";
 };
 
+/* USB 2.0 Type-A (upper port) */
+/* PHY: <&u2phy2_host> */
 &usb_host0_ehci {
 	status = "okay";
 };
 
+/* USB 2.0 Type-A (upper port) */
+/* PHY: <&u2phy2_host> */
 &usb_host0_ohci {
 	status = "okay";
 };
+
+/* USB 3.0 Type-A (lower port) */
+/* PHYs: <&u2phy0_otg>, <&usbdp_phy0> */
+&usb_host0_xhci {
+	dr_mode = "host";
+	extcon = <&u2phy0>;
+	status = "okay";
+};
+
+/* USB3 PHY for USB 3.0 Type-A (lower port)*/
+&usbdp_phy0 {
+	status = "okay";
+};
-- 
2.43.0


