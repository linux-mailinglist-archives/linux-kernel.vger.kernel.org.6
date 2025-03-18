Return-Path: <linux-kernel+bounces-565924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6F4A67122
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C840342203D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8202080F5;
	Tue, 18 Mar 2025 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZgirUvtv"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972C0207E0D;
	Tue, 18 Mar 2025 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293415; cv=none; b=FTEFD8m2n8yy/sKH92oPyXp7cpC+SLbhO4wWihZu35BUuD5m/m4f06vldV8t8JMA2HG3v3ydGbjovHECx1Wi1W0FZs196A1Y1dFaYRy4lmLlbMFXotLMF5tVgm4Lb48VXwqUkR0QuZcLU4uSq9A44C6ung407NU/L1Fk7gCuPko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293415; c=relaxed/simple;
	bh=MXp/aYEgJIRz1h77NEm+oyEhJoefXLGLbsCnRTPjoSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HGUFHEX+eSS8lPnskQ3H1iGEIEcjefvcFCCgAz1xAogJkecDPIJ7MOp9K1wWT26/F4yn8gipB2QQ7Od59W3OYj+4Lzkc0zAfygIzKOVm4+/0s2LKd0D9kyRLgiA/pg6wx0QH4mHPJo1nZ9gshuocP+mCiYaZoDNtVjsRXg5xyYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZgirUvtv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742293405;
	bh=MXp/aYEgJIRz1h77NEm+oyEhJoefXLGLbsCnRTPjoSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZgirUvtvTJlzz8+DjhuOddBdW2GY6kD/5YNW/T2N9njNVVEfkdvf6BgIXKhnNG/8m
	 Bsuw7tbiBkcG9Ah7XL2rsIzs9mBlSSzGK4/1bLbRD/Twlzo6xOO6u06m0cX776sU4N
	 f3Tmt9Va+AzoJtTcOZZVRCaSGiXdTKH7+mZmI+cg4W/SPhnZmniHUQCYnh13DiNVKl
	 pAhOTXgUTwn7iAV+mUKa4qevGHg2WxV5aVPfbvuewmPSC3EJntNk0XOlEKIidrFrNl
	 aJ5lzp5REDeSAKqS9rzXVbAIp09TS2q1M2bL8CZa0y0WLrBW8DwxwQPs6RBTl69RnK
	 Y8uyxymn+WuWw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:79a1:e959:3816:993])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 073CC17E0B25;
	Tue, 18 Mar 2025 11:23:24 +0100 (CET)
From: Laura Nao <laura.nao@collabora.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	bleung@chromium.org,
	tzungbi@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	nfraprado@collabora.com,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH 2/2] arm64: dts: mediatek: mt8192-asurada-spherion: Mark trackpads as fail-needs-probe
Date: Tue, 18 Mar 2025 11:22:59 +0100
Message-Id: <20250318102259.189289-3-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318102259.189289-1-laura.nao@collabora.com>
References: <20250318102259.189289-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Different Spherion variants use different trackpads on the same I2C2
bus. Instead of enabling all of them by default, mark them as
"fail-needs-probe" and let the implementation determine which one is
actually present.

Additionally, move the trackpad pinctrl entry back to the individual
trackpad nodes.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 .../arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts | 7 +++++++
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi           | 6 ++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
index 8c485c3ced2c..163960f58db5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
@@ -85,8 +85,15 @@ &i2c2 {
 	trackpad@2c {
 		compatible = "hid-over-i2c";
 		reg = <0x2c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_pins>;
 		hid-descr-addr = <0x20>;
 		interrupts-extended = <&pio 15 IRQ_TYPE_LEVEL_LOW>;
 		wakeup-source;
+		status = "fail-needs-probe";
 	};
 };
+
+&trackpad {
+	status = "fail-needs-probe";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index dd0d07fbe61a..b11b32a63bbc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -335,11 +335,13 @@ &i2c2 {
 	clock-frequency = <400000>;
 	clock-stretch-ns = <12600>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>, <&trackpad_pins>;
+	pinctrl-0 = <&i2c2_pins>;
 
-	trackpad@15 {
+	trackpad: trackpad@15 {
 		compatible = "elan,ekth3000";
 		reg = <0x15>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_pins>;
 		interrupts-extended = <&pio 15 IRQ_TYPE_LEVEL_LOW>;
 		vcc-supply = <&pp3300_u>;
 		wakeup-source;
-- 
2.39.5


