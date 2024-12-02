Return-Path: <linux-kernel+bounces-427005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B2C9DFB1F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9D1163AD2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE06D1FA829;
	Mon,  2 Dec 2024 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="MEmIfd53"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3E1F9F67;
	Mon,  2 Dec 2024 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733124088; cv=none; b=JZ4yuv1WRwbbVaEpxHPATjxI69stFdSQktjs1+Er+TJwfiCb9RBevbEKA/EPVfVWdT+fvxgJ0Shbwa2glgDBqH2r6oIeUjzha75Xqo6oitKzI/Sna99/P3J386ScM9Mlbo5bZWP+Wh4iWsb1oNmJ3JsRVkcdIMl6swptyZJBy4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733124088; c=relaxed/simple;
	bh=tqbqXpW+loeWpRzTTVlL6+p0G4UpfBQgMx+wCJ+XAJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uJ7f9M81nAXI1b3fiUrx3GjOZoVwGMR2X++4blfZqtWzm60vS9y01ZhfEKl2RBvVUeAfFDePFMcJzRZPXcybDE5OjgHEJC3i1HevYdAUbNBPq1WlzihzLuQy/N7ibNt8s5uZ+MUENn4knWzpkx8vycRZ50EXFvs6UJ5B/ibwEKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=MEmIfd53; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bantzhwh/JQi8eGyb6CIiIiwNEHnowhlxIlaKq4g4mI=; b=MEmIfd53Kd1sMSjzM5w0cLblX2
	uP6wnJINVmNPJKtefvkl3QdZConWWXRJdVLzE4xaRsrAqRM2lRSa1jiWAHRlthZhxS//bLmUCBiVI
	RXbrhx+RpbJv2pkX/zsk74w30N7wSzAVXB4iObtx89Yqm7Da6vPYWKgPKgQ/nyyDh6RckdGT+BGiO
	Sr00ZBalPxtWp23t2rUhtJEzzaQ/4p3SgJMIqJpjcOm9GLlk3LTfmTGw3S8pgObqjMHsZwVb95mEi
	havgWJpOac+hMQgx51agTbkjUCQjpcK8yupw8IY/1ux8Pz77nF+fFhF1d4MZxYxvxSGxxKfsO/BNu
	cSSzKvBQ==;
Received: from [89.212.21.243] (port=53766 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tI0kF-007Bva-2V;
	Mon, 02 Dec 2024 08:21:23 +0100
From: Andrej Picej <andrej.picej@norik.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH v2 10/15] arm64: dts: imx8mm-phyboard-polis: Assign missing regulator for bluetooth
Date: Mon,  2 Dec 2024 08:20:47 +0100
Message-Id: <20241202072052.2195283-11-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202072052.2195283-1-andrej.picej@norik.com>
References: <20241202072052.2195283-1-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Yashwanth Varakala <y.varakala@phytec.de>

Assign the missing regulator to the bluetooth node. Absence of
this regulator triggers the warning message from kernel as driver
uses a fallback dummy regulator when there is no regulator assigned.

Signed-off-by: Yashwanth Varakala <y.varakala@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v2:
 - no change.
---
 arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
index 17e5dd40b5d7..be470cfb03d7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
@@ -266,6 +266,7 @@ bluetooth {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_bt>;
 		shutdown-gpios = <&gpio2 6 GPIO_ACTIVE_HIGH>;
+		vbat-supply = <&reg_vcc_3v3>;
 		vddio-supply = <&reg_vcc_3v3>;
 	};
 };
-- 
2.34.1


