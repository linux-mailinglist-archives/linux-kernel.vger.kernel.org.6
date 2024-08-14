Return-Path: <linux-kernel+bounces-286182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C463C9517A4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E03EB21D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00D914AD20;
	Wed, 14 Aug 2024 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="MqO+7/Gq"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F91149C68
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627609; cv=none; b=DsGVvztvehNZ1H5Iyvtf2Ds9wRD36QNRPUPWZjrgbLV/MiNnZUY81zVtMq0xEgIswRk/IBKSIHAqIvr/B5/UaJyCPZfo2r5fNVe1JOyh17GWM0+SdRNIRcxky9uq0k7N7R86v/CwC7an8PcmBPPxCKRAp6N5Sd8a/CpIBzgeSlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627609; c=relaxed/simple;
	bh=d9r69nqmECkkEgXIbSmevUGwzmEqByJwViwec/ag+Bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KDanvhNd6NarcAnHbS17Pkmgv8xA+qffVex90speE8ZirVLdP3Hcoo7iPxBWnswZVKJ6p2PX/3LffybGYO/cqjKk5bhAlkWhDg/rYM+ssZtjObe9a+HMHfwXDoR1fP6l7DUtl/wBVMhoAH0dqLEtOB5Ujp94wsisCPyJEczktLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=MqO+7/Gq; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1723627599; x=1726219599;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d9r69nqmECkkEgXIbSmevUGwzmEqByJwViwec/ag+Bk=;
	b=MqO+7/GqmeM6s+KlyZeUDJTuUE1v9pYX94o1mW/ykBvfMDiayw86ZTcjgLT7D4HG
	ZXNxPa7msTtm4mhacQdvW5KyvblAT4ChnWrz06vaa8VOCNJaYjU/W05CTksVBUec
	U5HQwKbFRUO2GsUDaSnAcWmp4W13mjradgYOyPnsFMA=;
X-AuditID: ac14000a-03e52700000021bc-bd-66bc784f9340
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 09.54.08636.F487CB66; Wed, 14 Aug 2024 11:26:39 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 14 Aug
 2024 11:26:39 +0200
From: Teresa Remmet <t.remmet@phytec.de>
Date: Wed, 14 Aug 2024 11:26:11 +0200
Subject: [PATCH 4/6] arm64: dts: imx8mp-phyboard-pollux: Assign regulator
 to EEPROM node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-4-e2500950c632@phytec.de>
References: <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-0-e2500950c632@phytec.de>
In-Reply-To: <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-0-e2500950c632@phytec.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: Yannic Moog <y.moog@phytec.de>, Benjamin Hahn <b.hahn@phytec.de>,
	Yashwanth Varakala <y.varakala@phytec.de>, <devicetree@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42JZI8nAo+tfsSfN4MZcXYs1e88xWcw/co7V
	4uFVf4uZ91rZLFZN3cli8XLWPTaLTY+vsVpc3jWHzeL/nh3sFn+3b2KxeLFF3KL7nboDj8fO
	WXfZPTat6mTz2Lyk3uPF5pmMHv3dLawe/X8NPD5vkgtgj+KySUnNySxLLdK3S+DKONK4nLWg
	g73i+Jp2lgbGDrYuRk4OCQETiV1L9zB2MXJxCAksYZKYdOAsG4TzmFHi4/nDLCBVbAIaEk9X
	nGbqYuTgYBFQlZj0PgskLCwQJfFuzgFGEJtXQFDi5MwnLCAlzAKaEut36YOEmQXkJba/ncMM
	UZIscWjdLjBbCMiePu0uWCunQIrE9Zvn2EHWighMYpI4eu0E2EHMAn1MEp3TzrNDXCos8Xn3
	GjaIbnmJXZdOMkLE5SWmnXvNDGGHShzZtJppAqPQLCQ3zUK4aRaSmxYwMq9iFMrNTM5OLcrM
	1ivIqCxJTdZLSd3ECIolEQauHYx9czwOMTJxMB5ilOBgVhLhDTTZlSbEm5JYWZValB9fVJqT
	WnyIUZqDRUmcd3VHcKqQQHpiSWp2ampBahFMlomDU6qBMWb9oQk3vvUoXcx4fGNtz/o0qSUv
	czjdK9qLDsXO9OpyPr363aZ/e9nVn87hX7+r2nCtvbrdDTdLn613F6ULsU1s2HC3Mso3xfWq
	2atyFYn9Ghprnq88/CUpU2oeo0AVv8TJpRMY1r648v1Exq2OG18vb+loV53z99Tcj3pGRtO6
	z57+OeOCXLISS3FGoqEWc1FxIgCehAVVkwIAAA==

From: Yashwanth Varakala <y.varakala@phytec.de>

Add VCC_3V3_SW regulator reference to the EEPROM node to reflect the
schematic. This also silences the fallback dummy regulator warning.

Signed-off-by: Yashwanth Varakala <y.varakala@phytec.de>
Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 341baa167191..4cdb3b9fff08 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -171,6 +171,7 @@ eeprom@51 {
 		compatible = "atmel,24c02";
 		reg = <0x51>;
 		pagesize = <16>;
+		vcc-supply = <&reg_vcc_3v3_sw>;
 	};
 
 	leds@62 {

-- 
2.25.1


