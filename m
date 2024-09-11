Return-Path: <linux-kernel+bounces-324946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD2397530B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BE428610B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5B519CC03;
	Wed, 11 Sep 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="GCr4RyQt"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F8198A21
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059516; cv=none; b=V8S3MCNGasTaQiaYFhQN8J1BaebgpXmbDK1+OnHzzlOX5EqppUdSTSUIZKMvWdp8uiBpvJ54yBTLndEfsDqPNRI8280VheDibJ7ctyl2KJn7kIuilprGGIux4i9Egqnq++Tg+ZLDAX4Q9hHm7EtkI+odLYYJc0mwaD8ScyaZiPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059516; c=relaxed/simple;
	bh=V0kLceQ0WcbG7t28DFnms44uXcaiBfy6qibn4T4i1UM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1Dgy8fYkdvq1hkmWqULJO0paoViAzL5kcFRshjMSfDD3VJv/PJ7UFS0z2L7YFgEkjwzir4CsYdalEpEiSD+YbaeWDEWooWnza5esOX8Sb2Wi0OoOpn8jYzutlxCQFljpW3TFZxMduc/j9qzGYvsGZ/5UIaXw6M8O2i024fXNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=GCr4RyQt; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1726058586; x=1728650586;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=V0kLceQ0WcbG7t28DFnms44uXcaiBfy6qibn4T4i1UM=;
	b=GCr4RyQtcEbmdVVcbxXAR3zSrMUUAqkpJnyGDDseQHMHZ1EmqTmdUXYK/LuXjKoK
	ly6Vrz8uyYOAyUTmUxEQugq8XC7HCAFCgAyqesit7Ab0g0qc8DQWvJy0zr4DjolT
	srz+9EglfK/cR5g6yb1MSLQl8ARHmIx+BT2phkY7mxY=;
X-AuditID: ac14000a-4637f70000004e2a-e1-66e1905ae0e2
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 9B.35.20010.A5091E66; Wed, 11 Sep 2024 14:43:06 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 11 Sep
 2024 14:43:05 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
CC: <d.schultz@phytec.de>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
Subject: [PATCH 3/3] arm: arm64: dts: ti: k3-am642-phyboard-electra-rdk: Enable trickle charger
Date: Wed, 11 Sep 2024 14:42:51 +0200
Message-ID: <20240911124251.702590-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240911124251.702590-1-w.egorov@phytec.de>
References: <20240911124251.702590-1-w.egorov@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWyRpKBRzdqwsM0g+MTuSzW7D3HZDH/yDlW
	i+WfZ7NbvJx1j81i0+NrrBaXd81hs3jz4yyTxf89O9gtut+pW/w/+4Hdgctj06pONo/NS+o9
	+rtbWD2O39jO5PF5k1wAaxSXTUpqTmZZapG+XQJXxsLWmIIWjor9P6eyNzC+Z+ti5OCQEDCR
	2Ho9qouRi0NIYAmTxNrWm8wQzmNGifVH9jJ1MXJysAmoS9zZ8I0VJCEi0MYosfLvdTYQh1lg
	EqPEhX8/WUCqhAXiJQ5+2cQGYrMIqErc3/2bHcTmFbCQmL39PliNhIC8xMxL38HinAKWEs9P
	bgSrFwKqufS4BapeUOLkzCdg9cxA9c1bZzND2BISB1+8YIaol5d4cWk53Mxp514zQ9ihElu/
	bGeawCg0C8moWUhGzUIyagEj8ypGodzM5OzUosxsvYKMypLUZL2U1E2MoFgRYeDawdg3x+MQ
	IxMH4yFGCQ5mJRHefrt7aUK8KYmVValF+fFFpTmpxYcYpTlYlMR5V3cEpwoJpCeWpGanphak
	FsFkmTg4pRoYRet2zhUyWS39JWUW16vLGdv7OH+YKex5f4p1S7f+pHM/HyRwv3MynJH/TVu3
	Wm05h5aenoLQt+s+tdZKCQuFk6QEP9zzUZ7BOL9Nyrlm+yttt7I3P+4+1LWataOkJlvyatFp
	K1fF2GVXzt2Ry6hzOrNNlCdL65P0hNBLcgXxaW2qCRJfTjsosRRnJBpqMRcVJwIAROuCjYMC
	AAA=

From: Daniel Schultz <d.schultz@phytec.de>

Be default, R511 iand D19 are not populated on our phyBOARD-Electra.
This resistor and diode connect VCC_3V3_SW with VBAT and permantly
charge the RTC battery.

Enable trickle charge to charge the battery through the RTC.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 30729b49dd69..fec917fa067c 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -198,6 +198,10 @@ AM64X_IOPAD(0x0040, PIN_OUTPUT, 7)	/* (U21) GPMC0_AD1.GPIO0_16 */
 	};
 };
 
+&i2c_som_rtc {
+	trickle-resistor-ohms = <3000>;
+};
+
 &main_i2c1 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.34.1


