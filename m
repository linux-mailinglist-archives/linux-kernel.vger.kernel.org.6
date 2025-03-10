Return-Path: <linux-kernel+bounces-554391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8609A59724
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2423AAA70
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77FA22B5A3;
	Mon, 10 Mar 2025 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="LrCLI2fm"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96522B5B8;
	Mon, 10 Mar 2025 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615876; cv=none; b=IqVUIt0W9D9CjyJaSa8t77fVY3D3phZjO/nUJZ7wUfMr1qI1M1M4lDBuRvGSIBXXAi88Vf9g7hcHCsUCoXfAdKsMm25nekszK0I+SOZUW7/tocHQ3Y9WnYSxMtQq9hZ7dIhONw9RlC5+K295d3eYaUcAw27iA0y8mJqF1/wzjGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615876; c=relaxed/simple;
	bh=h7IG7Iw5c8FBRHktz05awjGUOLRAhFTuYTO3Fk3rjPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MEfrVaI0LJX5cSew7BYP6WU4BZ6F/tA3Y/DcArR1cJNw88AwAPPm9Ib8f+XsF3ZqpS7FZrmhNyIkUnwrINyYj119C/6uWSFdyz+1syJFC6lHFNuWmAtu+SMplA410smY3WD1wTFQ7lJKAplSl9duRivN8ojM34Qaov7Oug4iaps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=LrCLI2fm; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 55FF820E07;
	Mon, 10 Mar 2025 15:11:11 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sNrT02Q0KMYU; Mon, 10 Mar 2025 15:11:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1741615870; bh=h7IG7Iw5c8FBRHktz05awjGUOLRAhFTuYTO3Fk3rjPg=;
	h=From:To:Cc:Subject:Date;
	b=LrCLI2fmEFFUjqJfD6ojRGOv5jvEJu08U1Mycn2bhc1P+G0yAf0j+SEqO3LDGQbTQ
	 T9ejM1B9XkwiWNjm2+h9NHjdzLEFwVM6MyEjkStLJzHX81iTKMfQlerSkboX0A1q+8
	 aO0oDX1Vo/Q7F9v+SacOUcZWeKLTVqCNq/LmVWVuEbZ9M7EJ5PRVIXjw/gQIykemc3
	 JgspNxqf8lJVuzWYYN1fPlXHbqsBRwGdGcvHjN0aoPuTl7sbFxx1JgVDLhrNRVl+J9
	 iuoIqcs21uSNXl1k9aoIMnx62lKmQTaS9f9JJIczdDuGtLgZeN2szmEf8VAT59f4gF
	 Q6bBtONyrrSFQ==
From: Yao Zi <ziyao@disroot.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Yao Zi <ziyao@disroot.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Andy Yan <andyshrk@163.com>,
	Damon Ding <damon.ding@rock-chips.com>,
	Jing Luo <jing@jing.rocks>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Fix PWM pinctrl names
Date: Mon, 10 Mar 2025 14:09:17 +0000
Message-ID: <20250310140916.14384-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These Rockchip boards assign "active" as the pinctrl name for PWM
controllers, which has never been supported in mainline Rockchip PWM
driver. It seems the name used by downstream kernel is accidentally
brought into maineline. Let's fix them.

Fixes: 4403e1237be3 ("arm64: dts: rockchip: Add devicetree for board roc-rk3308-cc")
Fixes: 964ed0807b5f ("arm64: dts: rockchip: add rk3318 A95X Z2 board")
Fixes: e7a095908227 ("arm64: dts: rockchip: Add devicetree for NanoPC-T4")
Fixes: 3f5d336d64d6 ("arm64: dts: rockchip: Add support for rk3588s based board Cool Pi 4B")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---

It's uncommon to have a commit carrying so many fix tags, but otherwise
four seperate small commits will be created with the same topic. I'm
willing to change this if it's inappropriate.

I don't have these boards for a real test, but the change should be the
right way.

Thanks for your time and review.

 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts     | 2 +-
 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts    | 4 ++--
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi   | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
index 629121de5a13..5e7181948992 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
@@ -147,7 +147,7 @@ rtc: rtc@51 {
 
 &pwm5 {
 	status = "okay";
-	pinctrl-names = "active";
+	pinctrl-names = "default";
 	pinctrl-0 = <&pwm5_pin_pull_down>;
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
index a94114fb7cc1..96c27fc5005d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
@@ -274,13 +274,13 @@ otg_vbus_drv: otg-vbus-drv {
 
 &pwm0 {
 	pinctrl-0 = <&pwm0_pin_pull_up>;
-	pinctrl-names = "active";
+	pinctrl-names = "default";
 	status = "okay";
 };
 
 &pwm1 {
 	pinctrl-0 = <&pwm1_pin_pull_up>;
-	pinctrl-names = "active";
+	pinctrl-names = "default";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index b169be06d4d1..c8eb5481f43d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -603,7 +603,7 @@ &pwm1 {
 };
 
 &pwm2 {
-	pinctrl-names = "active";
+	pinctrl-names = "default";
 	pinctrl-0 = <&pwm2_pin_pull_down>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
index 8f00e0444c00..8b717c4017a4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
@@ -433,7 +433,7 @@ &pwm2 {
 };
 
 &pwm13 {
-	pinctrl-names = "active";
+	pinctrl-names = "default";
 	pinctrl-0 = <&pwm13m2_pins>;
 	status = "okay";
 };
-- 
2.48.1


