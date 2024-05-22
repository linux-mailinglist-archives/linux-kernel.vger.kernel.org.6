Return-Path: <linux-kernel+bounces-185914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6778CBCDA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2831C21F76
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C907FBAE;
	Wed, 22 May 2024 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="sQDB8K1m"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4144C138;
	Wed, 22 May 2024 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366232; cv=none; b=aoAU0Y/PpX30j3gWwfjiONTplGmynhEk/kfwod90fk0s9aBifltzVII+RMOa2Hvy5S0og99HC8vg1HeYFXvcTGEQ3nLRth9mnwLLBalag8wRNNeIcJutFAwU5eamZWpSM9l009Jgx2S6UFYMTDaHjudyrqr+mqn9+ibM30dnd8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366232; c=relaxed/simple;
	bh=AsSp7xzr2s2NSi5tpS5OvT8AnMRdnVDIybAsWaM2joY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t1jMbplFd7WNHo0Q1lRhPGuE/H0y4h5XZ2HKkc+MT8c49MeRSwh3DPXjGx7NHM/lwaWtnTv7OW5Xxd+2XAYwTnn2TfRdv4S6h9NgZPdOyq17ctDAnlhnABc69XWZh+7b9EbB2eC53oi+fesPO+qPYryeUaVRQjvmgbB79sGtYUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=sQDB8K1m; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=P7gzquHYAk77nHHQ5uNsf0UW7QweoRnYgjes1qcmeuE=; b=sQDB8K1m/Fh9+KrEvWpENqrvzT
	7KTLeQyP8h4s86XNL0NTxryDZS8ujbecjk1ptITqos63ezZLRt4EO2guWc+Gcn3Dc0kUo1MNcUBy8
	uSJghwwmc4MOyEM+gj1zTXTAxaAG9csLGn7Vhbhn6VoKLf/mv7wjPQUk57rknjeop8760O0XeJLXl
	5tK9EhjsjBQZJ15YVE1nzqV4ML7eY+7kHFR/NIZWi+6AFvvdsZuopY99fmgYL7+SXllxj4XuAA6kA
	+Idi16O1Dw7j0NzJV57uU7+QXgCQhnIAUwypAGzoE/gqG7OYpWmK9wT1snxrzcRHZW17w4RRPPLph
	hxcrBW8A==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1s9hGE-000FPM-Tb; Wed, 22 May 2024 10:23:46 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1s9hGE-000LzZ-2o;
	Wed, 22 May 2024 10:23:46 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Sean Nyekjaer <sean@geanix.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: stm32: osd32: move usb phy power to common
Date: Wed, 22 May 2024 10:23:29 +0200
Message-ID: <20240522082332.2471337-1-sean@geanix.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27282/Tue May 21 10:30:22 2024)

According to the OSD32MP1 Power System overview[1] usb phy power is
hard-wired internally in the SIP module to ldo4.

[1]:
https://octavosystems.com/app_notes/osd32mp1-power-system-overview/#connections

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts | 8 --------
 arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi     | 8 --------
 arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi       | 8 ++++++++
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts b/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts
index 527c33be66cc..854dfecd801f 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts
@@ -211,11 +211,3 @@ &usbotg_hs {
 &usbphyc {
 	status = "okay";
 };
-
-&usbphyc_port0 {
-	phy-supply = <&vdd_usb>;
-};
-
-&usbphyc_port1 {
-	phy-supply = <&vdd_usb>;
-};
diff --git a/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi b/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
index cfaf8adde319..aa28043c30fb 100644
--- a/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
@@ -590,14 +590,6 @@ &usbphyc {
 	status = "okay";
 };
 
-&usbphyc_port0 {
-	phy-supply = <&vdd_usb>;
-};
-
-&usbphyc_port1 {
-	phy-supply = <&vdd_usb>;
-};
-
 &vrefbuf {
 	regulator-min-microvolt = <2500000>;
 	regulator-max-microvolt = <2500000>;
diff --git a/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi
index aeb71c41a734..ae01e7a5339e 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi
@@ -214,3 +214,11 @@ &m4_rproc {
 &rng1 {
 	status = "okay";
 };
+
+&usbphyc_port0 {
+	phy-supply = <&vdd_usb>;
+};
+
+&usbphyc_port1 {
+	phy-supply = <&vdd_usb>;
+};
-- 
2.44.0


