Return-Path: <linux-kernel+bounces-286188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 316E49517B2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DD72889FA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5601448E1;
	Wed, 14 Aug 2024 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="MVp7hKKf"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2949315351B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627646; cv=none; b=Tg/5JKpmZPJuN8QSDnwlRf2Y8AY3aJeRs2djQXW0WL8s5Y4fddCM66pIXgoMJai3fMALX8DvSuPpP4RgXO/SMvjev3c3p0AeiPA8BRwCv5WsXrhf0ZEKGzPFh/vqVXCElTMebofGp6x8XBBREU0rLVo+bDiBBELoYmbvIJzxtXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627646; c=relaxed/simple;
	bh=9A7avPDezlVbinNQfbmnx5waRbTWq0WyLotocTqMMg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Hlj2kQhis2Ont8QayHDkJEbY3fcU+Ws676e9SUQFS4B2ekN1T2NcWOm+g9Fi5vgKbEfG7ylyWnpQS1FVd9KsHm7WhMqMHtrEL5UAZWvTxBMc4U+AA2h6dlD/MYs0NTccXd7oNGunnLJCJk+WS4lf9LZLomx27ZASQHqycxNAy8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=MVp7hKKf; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1723627638; x=1726219638;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9A7avPDezlVbinNQfbmnx5waRbTWq0WyLotocTqMMg4=;
	b=MVp7hKKfkPzTVmcT6/jqwdrfT94JS1pM1gMkHeMBt2BX8MLpz8VTYhZAAOuX//jp
	rukl06SkyExJvzo5wOAWRc94dyICJlR/HWZRllCy3uLqITNbqs7Cb/92Aojr9JH7
	nlHhYn+OEED61SY+BSVd7ce0Xr2HRvZO14weM5IBcd4=;
X-AuditID: ac14000a-03251700000021bc-da-66bc78766038
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 46.64.08636.6787CB66; Wed, 14 Aug 2024 11:27:18 +0200 (CEST)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 14 Aug
 2024 11:27:18 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 14 Aug 2024 11:26:37 +0200
Subject: [PATCH 2/3] arm64: dts: imx8mm-phyboard-polis: add rtc
 aux-voltage-chargeable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240814-b4-phytec_imx8m_rtc_updates-v1-2-10f1afc1b3ad@phytec.de>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWyRpKBR7esYk+awfs9phZr9p5jsph/5Byr
	xcOr/hYz77WyWayaupPF4uWse2wWmx5fY7W4vGsOm8X/PTvYLf5u38Ri8WKLuEX3O3UHHo+d
	s+6ye2xa1cnmsXlJvceLzTMZPfq7W1g9+v8aeHzeJBfAHsVlk5Kak1mWWqRvl8CVcW7qE9aC
	K6wVP79OZGtg/MTSxcjJISFgInH4ShNTFyMXh5DAEiaJv0ePsUI4Dxklpvb2MoJUsQmoSDx+
	cY8VxGYRUJX4d+MuE4gtLBAhsaH/IBuIzSsgKHFy5hOgqRwczAKaEut36YOEmQXkJba/ncMM
	UeIncfDyUXaQEiEg+/N8IZAwp4C/xN+uu+wga0UEJjFJHL12ghGidz+jxNxbSRCHCkt83r0G
	bJWQgKzEi/O97BBxeYlp514zQ9ihElu/bGeawCg0C8lFsxAumoXkogWMzKsYhXIzk7NTizKz
	9QoyKktSk/VSUjcxgiJJhIFrB2PfHI9DjEwcjIcYJTiYlUR4A012pQnxpiRWVqUW5ccXleak
	Fh9ilOZgURLnXd0RnCokkJ5YkpqdmlqQWgSTZeLglGpgTBQ0OVIwx9qg7cJUs/6MsHN3DN19
	y+9XTO/xmHdCzjieOeXHqfcfv3npX44V4c1SX6kYeS+lxsNxWdyZV+lu6w8mnqvaVHpVpLE/
	zUdnvnDnVVP52UwHVt9pXKdbUR0o7+gYa/Ph8qnT+o2b2Y/Ki12V9Jk2t9nQa9XECXPjL67e
	eOZLvMMpJZbijERDLeai4kQA51JYHpICAAA=

phyboard-polis has a chargable capacitor populated, rtc supports
charging it. Add property indicating this.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
index 92e62fe31929..5eacbd9611ee 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
@@ -220,6 +220,7 @@ &pcie_phy {
 };
 
 &rv3028 {
+	aux-voltage-chargeable = <1>;
 	trickle-resistor-ohms = <3000>;
 };
 

-- 
2.34.1


