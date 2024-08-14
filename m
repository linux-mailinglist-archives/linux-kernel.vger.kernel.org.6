Return-Path: <linux-kernel+bounces-286183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840679517A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD261F243F4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C66714B970;
	Wed, 14 Aug 2024 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="pTSd5Ixh"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C787149E05
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627609; cv=none; b=dmGFMj5pIkVqlsdRaM2EjeJjYNrEFVzoTIngUlks2bCYERC1agqTmoSfumB86eUTuvBfWC6tTs9zpa25QoyXMZPhH1wLLDEKVY533HBU1iFdjHufySjsDoDp+hYm538rKsmLRKV+RcQEzercEkTmSja09UDQWNrcdKt0+RGpu48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627609; c=relaxed/simple;
	bh=+dsAQi+pVfp48Iz8ltFfF87UQX/PXN/QMw8KGQTIrBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JtI0Fz/ht53fzh3Yml9rl+7+qV7DeGEcGcbM3dpJjDgU35Q/R5fsX9gHNDx8wyqlrkrdqC1OgN3sgGnk51TFD8f69qlqmwwUyrg9TSXKEkeAqutRx5GQQ7yDQ83+4PicOGDg+h1LKJEgYFyTfcyFdY7EHcDXsq+DmnvLHv3GElM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=pTSd5Ixh; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1723627599; x=1726219599;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+dsAQi+pVfp48Iz8ltFfF87UQX/PXN/QMw8KGQTIrBY=;
	b=pTSd5Ixhubk+TBLBK13fyulxmOWJAjDkhca97DvMC0acIuvNUWcw1x5TKl5fZfZW
	ozkw6i2+jPkBacICxAzJbG4PqNejVQaYm3BLuqEl0FgULfyP48NsYSBR1Q/DSw/3
	wv7y06t85WmDATV6DFOuZl8zF8F7+WMYVykw1nyaH7M=;
X-AuditID: ac14000a-03251700000021bc-be-66bc784f43b1
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id E9.54.08636.F487CB66; Wed, 14 Aug 2024 11:26:39 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 14 Aug
 2024 11:26:39 +0200
From: Teresa Remmet <t.remmet@phytec.de>
Date: Wed, 14 Aug 2024 11:26:12 +0200
Subject: [PATCH 5/6] arm64: dts: imx8mp-phyboard-pollux: Add VCC_5V_SW
 regulator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-5-e2500950c632@phytec.de>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42JZI8nAo+tfsSfN4OhjY4s1e88xWcw/co7V
	4uFVf4uZ91rZLFZN3cli8XLWPTaLTY+vsVpc3jWHzeL/nh3sFn+3b2KxeLFF3KL7nboDj8fO
	WXfZPTat6mTz2Lyk3uPF5pmMHv3dLawe/X8NPD5vkgtgj+KySUnNySxLLdK3S+DK+HjtPlNB
	O2fFwQuP2RsYn7F3MXJySAiYSNy4dxbI5uIQEljCJPH/yF8o5zGjxMfzh1lAqtgENCSerjjN
	1MXIwcEioCrx8AUXSFhYIEjixpS9TCA2r4CgxMmZT1hASpgFNCXW79IHCTMLyEtsfzuHGaIk
	WWJly2NWEFsIyJ4+7S4jiM0pkCJx/eY5sLUiApOYJI5eO8EI4jAL9DFJdE47D3WpsMTn3WvY
	ILrlJXZdOskIEZeXmHbuNTOEHSpxZNNqpgmMQrOQ3DQL4aZZSG5awMi8ilEoNzM5O7UoM1uv
	IKOyJDVZLyV1EyMolkQYuHYw9s3xOMTIxMF4iFGCg1lJhDfQZFeaEG9KYmVValF+fFFpTmrx
	IUZpDhYlcd7VHcGpQgLpiSWp2ampBalFMFkmDk6pBka2DuPZ152aYo99SZ7OVWGzJpUj5svn
	1KzaRf6c91hTLbol/Re1hTIaVZeVt75jYuFfHKK9wkE6/fGCqz12fFMf226r5vrSPP+eE7un
	vAePia3zQ/6GfxVeTLbiV3LtX+9/8dBHfPK6o5837Lv3eMPCssumWmHnhf8rSWSVr9s2W+tw
	x/dFGUosxRmJhlrMRcWJAPqhtG6TAgAA

From: Yashwanth Varakala <y.varakala@phytec.de>

Add fixed  regulator VCC_5V_SW based on the phyBOARD-Pollux schematics
to reflect the connectivity on the phyBOARD-Pollux-i.MX8MP.

Signed-off-by: Yashwanth Varakala <y.varakala@phytec.de>
Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 4cdb3b9fff08..62f1819bc1a4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -43,6 +43,15 @@ panel1_in: endpoint {
 		};
 	};
 
+	reg_vcc_5v_sw: regulator-vcc-5v-sw {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "VCC_5V_SW";
+	};
+
 	reg_can1_stby: regulator-can1-stby {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";

-- 
2.25.1


