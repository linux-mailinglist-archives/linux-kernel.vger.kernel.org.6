Return-Path: <linux-kernel+bounces-429959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FE69E29B0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A0B284E43
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8552B20ADCC;
	Tue,  3 Dec 2024 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c3iCQAy8"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1665120A5DE;
	Tue,  3 Dec 2024 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247685; cv=none; b=FgRDsll8qzH2dVyTRFLuGLKEMAXV474cfQVSoFC6F7OOZB2zFnGJGmjWmf2NvHJqMYi/j92TGH8BKhlElDwpbvty7kpvr6BrQ24paQUJ4/OOv8YDPw8zSeesnAzQLx9K1iyqMJOp98dBiAja1GbBen4cmx10Eg6EwqJdYOXu0h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247685; c=relaxed/simple;
	bh=v0mCBez+5qgXVTzPF2L2SlrWPp4f0NZziMfLurhcEFo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f50xNvV2ZTn6BkrFU6aA6XMkFgnwL3p1WWlr4xdPQGPGZFXsKjLH538IaouhlLAvMTu5Q5E0wXGz1Yxp12huPNaNk0MNwxxpT45QT3UI3BDYYHxioaylvhsbXhNbj27oXy6t7wDQacKy+P0IgB5bzxeTOnk5IBJLk0fIlcA/T1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=c3iCQAy8; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B3HfGOt124421;
	Tue, 3 Dec 2024 11:41:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733247676;
	bh=NtMvoGrC5lRoQDf3XgqTaQQ7eW/ep2GbwTcmnxYU/qY=;
	h=From:To:CC:Subject:Date;
	b=c3iCQAy8zy66ZLCkKI6X579GFhC8V/o/r/GQJqLf02K1N4LjC5PRGZhJIi/3u5bfI
	 9bGaXfXmHo0BhwWIyZxQcsSplvOAwl9xSZEbHi6AM4DE1mW+dyBnH7WjtUzCutZZu7
	 wJmPdN7I6E3fJyJk4OHRK7GWQYKhNWC4OKqPjN84=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3HfGQg074922;
	Tue, 3 Dec 2024 11:41:16 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 11:41:16 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 11:41:15 -0600
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B3HfF8J076485;
	Tue, 3 Dec 2024 11:41:15 -0600
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert
 Nelson <robertcnelson@beagleboard.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am62p: Enable Mailbox nodes at the board level
Date: Tue, 3 Dec 2024 11:41:13 -0600
Message-ID: <20241203174114.94751-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Mailbox nodes defined in the top-level J722s/AM62p SoC dtsi files are
incomplete and may not be functional unless they are extended with a
chosen interrupt and connection to a remote processor.

Disable the Mailbox nodes in the dtsi files and only enable the ones
that are actually used on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 4 ++++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts                | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index 41e1c24b11441..39f5c2d12fadb 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -768,6 +768,7 @@ mailbox0_cluster0: mailbox@29000000 {
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	mailbox0_cluster1: mailbox@29010000 {
@@ -777,6 +778,7 @@ mailbox0_cluster1: mailbox@29010000 {
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	mailbox0_cluster2: mailbox@29020000 {
@@ -786,6 +788,7 @@ mailbox0_cluster2: mailbox@29020000 {
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	mailbox0_cluster3: mailbox@29030000 {
@@ -795,6 +798,7 @@ mailbox0_cluster3: mailbox@29030000 {
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	ecap0: pwm@23100000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 7f3dc39e12bc9..ad71d2f27f538 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -621,6 +621,8 @@ partition@3fc0000 {
 };
 
 &mailbox0_cluster0 {
+	status = "okay";
+
 	mbox_r5_0: mbox-r5-0 {
 		ti,mbox-rx = <0 0 0>;
 		ti,mbox-tx = <1 0 0>;
@@ -628,6 +630,8 @@ mbox_r5_0: mbox-r5-0 {
 };
 
 &mailbox0_cluster1 {
+	status = "okay";
+
 	mbox_mcu_r5_0: mbox-mcu-r5-0 {
 		ti,mbox-rx = <0 0 0>;
 		ti,mbox-tx = <1 0 0>;
-- 
2.39.2


