Return-Path: <linux-kernel+bounces-286189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61219517B4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5EB1F24F46
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5831547C0;
	Wed, 14 Aug 2024 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="eBFhzp/h"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238B5153837
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627648; cv=none; b=MrAeHcn9q/N4DcCo9Wt2mqifauwC3WeeTvS0P6wSCEHdAZIwE/SXmXoxnxgVKXrzafZbb6gS/eLeNz/fSgHIk4cV1RoWcYZnEbKw+9dprRC4C27gUiHJDC3CY5RY9o1naEpp3ZdTC+6NsfF3+ZJaTW3kBntzsJOJQ4Y3Sp0BkMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627648; c=relaxed/simple;
	bh=V4xR8HJBOjRNzq85JAVbW/MSGd6Vjw3RnTNYP4qg0zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ajNNTpyoeyau36olHvUmJ3RfjN2YAyP3GKg0byJlUlG6N0EtqBO5fZS0FspOVlIH19nsvtn1d9s7+er+pjW9gdkX/f/xYtnFGmNhefgaS4ImuuvnLvfAvnb5LT7RIQ+gb9I6VvIXr9gffVa90WJfqBl+e/I32jxaeD2HwhEL1zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=eBFhzp/h; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1723627639; x=1726219639;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=V4xR8HJBOjRNzq85JAVbW/MSGd6Vjw3RnTNYP4qg0zs=;
	b=eBFhzp/huzQIIR7FDW/Bw6e3g9WMr9BnXlvvsn0wpiMjtZyd+iNP8+d2gIAzoUSn
	f5oyo/pG1KLg/L/a/cd+EnWizer3gXRBvnJRQRgepPxcxjmy6EH9olTheONuCmUA
	p5LyblyqyDz6WfPNDf/EH0msqYT5OcF5a3f7ZCvVmnI=;
X-AuditID: ac14000a-03e52700000021bc-db-66bc787607ac
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 17.64.08636.6787CB66; Wed, 14 Aug 2024 11:27:19 +0200 (CEST)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 14 Aug
 2024 11:27:18 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 14 Aug 2024 11:26:38 +0200
Subject: [PATCH 3/3] arm64: dts: imx8mm-phygate-tauri-l: add rtc
 aux-voltage-chargeable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240814-b4-phytec_imx8m_rtc_updates-v1-3-10f1afc1b3ad@phytec.de>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWyRpKBR7e8Yk+awb9sizV7zzFZzD9yjtXi
	4VV/i5n3WtksVk3dyWLxctY9NotNj6+xWlzeNYfN4v+eHewWf7dvYrF4sUXcovudugOPx85Z
	d9k9Nq3qZPPYvKTe48XmmYwe/d0trB79fw08Pm+SC2CP4rJJSc3JLEst0rdL4Mp4t2oze8FJ
	1or5n9+xNzA+Zeli5OSQEDCROL1lHlMXIxeHkMASJonnVzYzQjgPGSWm9vYyglSxCahIPH5x
	j7WLkYODRUBVYvosc5CwsECkxM+3fcwgNq+AoMTJmU9YQEqYBTQl1u/SBwkzC8hLbH87B6rE
	T+LqowvMICVCQPbn+UIgYU4Bf4m/XXfZQbaKCExikjh67QQjRO9+Rom5t5Ig7hSW+Lx7DRuI
	LSQgK/HifC87RFxeYtq518wQdqjE1i/bmSYwCs1CctEshItmIbloASPzKkah3Mzk7NSizGy9
	gozKktRkvZTUTYygKBJh4NrB2DfH4xAjEwfjIUYJDmYlEd5Ak11pQrwpiZVVqUX58UWlOanF
	hxilOViUxHlXdwSnCgmkJ5akZqemFqQWwWSZODilGhhb3hxyfiz9t2YO9yTz/9dvtIuVvdxc
	9ZmZ98O643GM/s4B320Vt6Y/d9QUv8t15Wqj+z4Jtq1COv9iudM5+H6l2c995t+ul9BV0Xs5
	vJp7TXynw9a3qQ+/ixzW/XDtPXtmd2J6adxC6+5nbzM2hPT+FDyxMXVfoC7DjXz1zh6zJ7Y3
	U+q5dZVYijMSDbWYi4oTAfE1xziQAgAA

phygate-tauri-l has a chargable capacitor populated, rtc supports
charging it. Add property indicating this.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts
index ba6ce3c7f477..c3835b2d860a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts
@@ -215,6 +215,7 @@ &pwm4 {
 
 /* RTC */
 &rv3028 {
+	aux-voltage-chargeable = <1>;
 	trickle-resistor-ohms = <3000>;
 };
 

-- 
2.34.1


