Return-Path: <linux-kernel+bounces-335472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 997B497E633
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E981C20A23
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFECD5FBBA;
	Mon, 23 Sep 2024 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vdFFyz/2"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DA83D556;
	Mon, 23 Sep 2024 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727074256; cv=none; b=puTB3k1QMRwb3ejRgsoiBgoPAzY/66uv452OxYOU5BXxBy7vGv1RPP/7w2Lg9LRUur22lNMtP9G9D3Y4ymiMgw+Uo7We0tw1CRL+PGcClsV+iUNMiGVFZvJvCUsvUbCawP5/ua0wsPofkKBoIt3fJ+jM3F8ce+dqmQQdb7pSDmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727074256; c=relaxed/simple;
	bh=I5L8Derw58tSEC47Am0Yn8oNzi6p4Swk4/yxKYbMZEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfts5ETV5RxQI1sA6JmldOj2yediahtphJWugY/ELI1z5kH/Snrr56lnpL9phYcWjZRN8Wfwhk4vi6k6M+Q3vkZY+Jg0JrAuDNgWRXBi3/X+4QecNCrvM0Sjwoc+IlcMyFDQIQGwVFGjcSPK0tNMZuRXboneFv0gZM6laKA8SO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vdFFyz/2; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727074255; x=1758610255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I5L8Derw58tSEC47Am0Yn8oNzi6p4Swk4/yxKYbMZEc=;
  b=vdFFyz/2A7rpcskcz4eSAz6c06VavRwh181Tvh816ZJWiQnluq+TZXAf
   e74n8KcA+RTB5UzkguLDDG6Pt3pdGCi97V3ifdIuC5/lX2sWHuHtp9p8d
   Va6OijHOj/Vjs3ZTCU7tC255X2ryEfpnoxhc0eu7Nwsv7QksZU3S92oZI
   pg1gwOabrZYkOXZWNXmM/iaN0eCBLAE+vfUVKIwnb6QAAkcnnDSJCgRTB
   QXcTtTlQEvKpOAV0/PYqksVWB60C1+gD7DwFGTc+WNnj/J8dcY6pTglWJ
   zCu4KQjWcgxoP0kfFHjxmtXwG2J/iKYSm2Ba3m2UVD+J2KSD9CRn/G7EJ
   Q==;
X-CSE-ConnectionGUID: nbowMA2OSLiJEr3vdSwxZA==
X-CSE-MsgGUID: ofM9s08gTE2AfR4IXfdH4A==
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="263115668"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2024 23:50:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 22 Sep 2024 23:50:17 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 22 Sep 2024 23:50:15 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 4/5] ARM: dts: microchip: sama7g5ek: Add power monitor support
Date: Mon, 23 Sep 2024 09:49:31 +0300
Message-ID: <20240923064932.5797-5-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923064932.5797-1-mihai.sain@microchip.com>
References: <20240923064932.5797-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add PAC1934 support in order to monitor the board power consumption.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 .../arm/boot/dts/microchip/at91-sama7g5ek.dts | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
index ed75d491a246..5fd77abd4201 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
@@ -244,6 +244,37 @@ i2c1: i2c@600 {
 		i2c-digital-filter-width-ns = <35>;
 		status = "okay";
 
+		power-monitor@10 {
+			compatible = "microchip,pac1934";
+			reg = <0x10>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@1 {
+				reg = <0x1>;
+				shunt-resistor-micro-ohms = <10000>;
+				label = "VDD3V3";
+			};
+
+			channel@2 {
+				reg = <0x2>;
+				shunt-resistor-micro-ohms = <10000>;
+				label = "VDDIODDR";
+			};
+
+			channel@3 {
+				reg = <0x3>;
+				shunt-resistor-micro-ohms = <10000>;
+				label = "VDDCORE";
+			};
+
+			channel@4 {
+				reg = <0x4>;
+				shunt-resistor-micro-ohms = <10000>;
+				label = "VDDCPU";
+			};
+		};
+
 		mcp16502@5b {
 			compatible = "microchip,mcp16502";
 			reg = <0x5b>;
-- 
2.46.1


