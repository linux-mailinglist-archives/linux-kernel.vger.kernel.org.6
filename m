Return-Path: <linux-kernel+bounces-545530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E046A4EE37
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480F0174F40
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8DC2780EC;
	Tue,  4 Mar 2025 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="jjozYlPz"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9513927780B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741119425; cv=none; b=dd+hTd5gwq/TFEKfn6E8iACL3FlzMjeZNFFkVB/quyDimtcQA7YC5iEYTQ0qGhRPPnQO962Ae2PmMkkYvrtqDTpJsN6ShF3VHcJn+im/djvosCYAi7jIBHILkH2FvQ1OyVGGkZqrht/q8MIhwvIGjkUPwbvyeMcebyUm+fUED40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741119425; c=relaxed/simple;
	bh=KEWf7o6M5uza+0eEeMvN5HllXi+t5sdq1WVFkwZy/U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOZmGbGiyFQwn4XcWpfSswn+4+f+VtsYIJJ4nkqTePIx+4kICFxMcQZoWq3SibdDYQuxiQpFB5EWQ1TeWISUMBGNOxSeio0pUoc+/jF94qKb8/IfGXPUM/zu/btzTDNAFjC3p0CUJbRbrM6XsXv4873q66GTptSDSyNTjHbwVus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=jjozYlPz; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1741119417; bh=YjwIne5TvQyIGFZn7AOjsAAARhRhaBHJQjw6qbw1ro0=;
 b=jjozYlPzY/1EDw5yPf3JYWBmMYF4x/CR+hddJWUKSHnFSHZen0mIj3SxYKc0X4NF5cYousj0w
 S6hDypuI00es/IsJqJ3efojmzqSIiJvoPsUHKzbzxYGiOc/oQWnw23G9jOR+Ll45u9NhrQpju+J
 ifETV6gAoX1VOmw6HZM060QCmOKrbNPhoWSFVydztK7zuoZcNMSjgZoO4jSBd5XK+W5frgHKTl7
 aRpXAeaQ8cGXyO5/iW2QEvn408jCu6MtkRJ9VlXWgJNIrUj/4WVy5+sWafqny0AXijhd8jetvAv
 brqaKx+nXprBICY6ATYkk8u5s/G+Ta6t2l/xrTQitajg==
X-Forward-Email-ID: 67c75fb666a4509299dbdf80
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 2/4] arm64: dts: rockchip: Add user button to Radxa E20C
Date: Tue,  4 Mar 2025 20:16:35 +0000
Message-ID: <20250304201642.831218-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304201642.831218-1-jonas@kwiboo.se>
References: <20250304201642.831218-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Radxa E20C has two buttons, one SARADC maskrom button and one GPIO user
button.

Add support for the user button using a gpio-keys node.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 .../boot/dts/rockchip/rk3528-radxa-e20c.dts   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
index 7f0237206405..b378774d2a4e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
@@ -7,6 +7,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include "rk3528.dtsi"
 
@@ -18,6 +19,19 @@ chosen {
 		stdout-path = "serial0:1500000n8";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_key>;
+
+		button-user {
+			gpios = <&gpio0 RK_PA0 GPIO_ACTIVE_LOW>;
+			label = "USER";
+			linux,code = <BTN_1>;
+			wakeup-source;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -50,6 +64,12 @@ led-wan {
 };
 
 &pinctrl {
+	gpio-keys {
+		user_key: user-key {
+			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	leds {
 		lan_led_g: lan-led-g {
 			rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.48.1


