Return-Path: <linux-kernel+bounces-265806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA15293F633
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E32A1C21F20
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E528155392;
	Mon, 29 Jul 2024 13:07:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9514148FE1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258420; cv=none; b=ZU5XyRKWCgl+ZuDA+DtJWdwZfxUx/8i4CmdeqvVbIzZ5o3rOkKL1Jt2lX7ytWUxuetjTdgd1YIntzoQYxQc1WXJE8mCqp2l2Y7Lr2VjeEbZwA5VvC8YHAUPA/QO/+M0xDVlL6DOeD9SM0G6CFT3LUwWOIBCgNLMnPSvbQCwE0yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258420; c=relaxed/simple;
	bh=j99WKEfBnDah/eq5FH9CNsuMV16ZA9Q3V+eV4/bIM6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qfhhOUBfwT859L5/nwXwiIWSrU1CqyUCjgBg3Ymh5RksZ3SkKtmDo+buUmUh4h6zD7Xy6AKsTDJ377RxfsyQbRI4bJZbNMOPAVt//kW815vg9O8LJZ5TjuL8gOPVE3H8bLRaXF3b+VNZNh3Xv8T8OjLPS+WtgwqxdUOUe4/gRfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5Y-00008w-45
	for linux-kernel@vger.kernel.org; Mon, 29 Jul 2024 15:06:56 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5X-0032z6-Kt
	for linux-kernel@vger.kernel.org; Mon, 29 Jul 2024 15:06:55 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 564E1310DBD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:06:55 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 33B36310D5C;
	Mon, 29 Jul 2024 13:06:43 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6e971322;
	Mon, 29 Jul 2024 13:06:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 29 Jul 2024 15:05:34 +0200
Subject: [PATCH can-next 03/21] arm64: dts: rockchip: mecsbc: add CAN0 and
 CAN1 interfaces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-rockchip-canfd-v1-3-fa1250fd6be3@pengutronix.de>
References: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
In-Reply-To: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, David Jander <david@protonic.nl>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=6EUgL/CjJOuGqTkyqYsLA1JOqEcpFRFT9gT8iw/L1o8=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmp5O49OAaTZj8/tfriKSzQd7M3Ozdnqgdzt/0v
 o1qqGIPDruJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZqeTuAAKCRAoOKI+ei28
 bxS9CACV5Glrmi7N3+JvWtRUSgDoVv5IkPfmtGo1KhBqsSfbGtmrt/L36x0hNmJ3OMxkPJfm7jm
 yBAX4PPfye3Fvepw9mraHlFQOpVcZ/TBrUJ/8HOQO3N/LGHHx+8L+X3OpFFsspcP4r5lTGO9IdV
 B65pHkTu5alXhrBiZRceSLxjD9jUjgASM/igp11KJmkiTfmeYWb8MHv2Lz+JEZe0tS6crd9w2ZB
 0lBIv7VxPp0th5tFxCPbY2GZxB4Kq8O+vy0H6f5N395D2oPbVjK1lxPHc1BluAKOffKUjjUtPz0
 SNyrF4umkwUsm0jtE76TGKG9sSsOOe/jVXILCaIOUaOPXAIx
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: David Jander <david@protonic.nl>

This patch adds support for the CAN0 and CAN1 interfaces to the board.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts b/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts
index c2dfffc638d1..b518f430da84 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts
@@ -117,6 +117,20 @@ &cpu3 {
 	cpu-supply = <&vdd_cpu>;
 };
 
+&can0 {
+	status = "okay";
+	compatible = "rockchip,rk3568v3-canfd", "rockchip,rk3568-canfd";
+	pinctrl-names = "default";
+	pinctrl-0 = <&can0m0_pins>;
+};
+
+&can1 {
+	status = "okay";
+	compatible = "rockchip,rk3568v3-canfd", "rockchip,rk3568-canfd";
+	pinctrl-names = "default";
+	pinctrl-0 = <&can1m1_pins>;
+};
+
 &gmac1 {
 	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
 	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru CLK_MAC1_2TOP>;

-- 
2.43.0



