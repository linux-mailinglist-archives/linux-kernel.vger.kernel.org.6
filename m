Return-Path: <linux-kernel+bounces-286187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D712F9517AF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EEAF288600
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71B1149DE8;
	Wed, 14 Aug 2024 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="srA0zbxh"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756BE1448E1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627644; cv=none; b=KO8Tz6oy2KtT6syR8ghFI4mZrppUmcinN8FYD4A4kVkfF9Y0wfFDSij2NmGaFDJqgj8ETqOIFFXywOWPdRvQ7WnsUcidUBj6IjPY1o12SGDKZQuaG7+CoDLh5/FOuNGXqPSYgyZqo0/52wPToUS0yoQiCGoTqE88Prv6eJRv0Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627644; c=relaxed/simple;
	bh=ABpiHTooLDQPwb7H2paAkwcbLN52e1Wa5keX1BSX8qE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=sLNkaQlYj5nz9DPB0WIXHCrE2Hwq178WXzpa5CXXRTho0evXRxNdhSFK7vIIyxUqSMembg8Y7hGhZiS3dCqmH9foyn9XOucyNRYf8tJ25ON8JezjVdeUrHWQ8fAqdfQJIWJQ3i7FPg4NSSRwWA9jwRLMBB4QFyrMFlJAhA+3ZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=srA0zbxh; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1723627638; x=1726219638;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ABpiHTooLDQPwb7H2paAkwcbLN52e1Wa5keX1BSX8qE=;
	b=srA0zbxhQsxaYE97roCgZWXXoEyndpMlf8dbbaHzHdtUd46i8crSbe2jQLhD1bK4
	Nvc3du3YpWgN1miCO0xOL++UFlqtFFOsoQfzz6CapajylH3CpWzEnrloPe6ObMO3
	kjqIStKblbySZ1DPrh7cWnxYhZ28UCcTOmJADnPmf2s=;
X-AuditID: ac14000a-03e52700000021bc-d9-66bc787692f8
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 75.64.08636.6787CB66; Wed, 14 Aug 2024 11:27:18 +0200 (CEST)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 14 Aug
 2024 11:27:18 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 14 Aug 2024 11:26:36 +0200
Subject: [PATCH 1/3] arm64: dts: imx8mp-phyboard-pollux: add rtc
 aux-voltage-chargeable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240814-b4-phytec_imx8m_rtc_updates-v1-1-10f1afc1b3ad@phytec.de>
References: <20240814-b4-phytec_imx8m_rtc_updates-v1-0-10f1afc1b3ad@phytec.de>
In-Reply-To: <20240814-b4-phytec_imx8m_rtc_updates-v1-0-10f1afc1b3ad@phytec.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWyRpKBR7esYk+awfVLuhZr9p5jsph/5Byr
	xcOr/hYz77WyWayaupPF4uWse2wWmx5fY7W4vGsOm8X/PTvYLf5u38Ri8WKLuEX3O3UHHo+d
	s+6ye2xa1cnmsXlJvceLzTMZPfq7W1g9+v8aeHzeJBfAHsVlk5Kak1mWWqRvl8CVceekc8Fu
	toqdOzeyNDCeZ+1i5OSQEDCR2PblA5DNxSEksIRJ4tieK0wQzkNGiam9vYwgVWwCKhKPX9wD
	62ARUJXoPbkGzBYWiJRobTvBBmLzCghKnJz5hKWLkYODWUBTYv0ufZAws4C8xPa3c5ghSvwk
	dv5ZzARSIgRkf54vBBLmFPCX+Nt1lx1krYjAJCaJo9dOMEL07meUmHsrCeJQYYnPu9eArRIS
	kJV4cb6XHSIuLzHt3GtmCDtUYuuX7UwTGIVmIbloFsJFs5BctICReRWjUG5mcnZqUWa2XkFG
	ZUlqsl5K6iZGUByJMHDtYOyb43GIkYmD8RCjBAezkghvoMmuNCHelMTKqtSi/Pii0pzU4kOM
	0hwsSuK8qzuCU4UE0hNLUrNTUwtSi2CyTBycUg2MGj/Wm34sOFapuU/VQ77o5vOoo7tY5TR0
	f7Jv+2NcOS3LNnGj+T2bD5/EDi7PPqCt1mX5+iDXmx/cTw78XZ+9fvYZgRUFkVWS9dyu8+7d
	a+bN7z1bJcx0p+KCtpTJtg8Kx/dEsfi53z4287OrmIiRkeHvCcVv2PzqW85ca7EPWffc59hC
	CanpSizFGYmGWsxFxYkAztrdW5ECAAA=

phyboard-pollux has a chargable capacitor populated, rtc supports
charging it. Add property indicating this.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 3427936f9045..6347b469fc99 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -222,6 +222,7 @@ &rv3028 {
 	pinctrl-0 = <&pinctrl_rtc>;
 	interrupt-parent = <&gpio4>;
 	interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+	aux-voltage-chargeable = <1>;
 	wakeup-source;
 	trickle-resistor-ohms = <3000>;
 };

-- 
2.34.1


