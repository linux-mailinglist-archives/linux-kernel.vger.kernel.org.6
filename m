Return-Path: <linux-kernel+bounces-253642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F620932435
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAAE81F21F65
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232C3198E85;
	Tue, 16 Jul 2024 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="E6d9tU0w"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5751953A8;
	Tue, 16 Jul 2024 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721126136; cv=none; b=VLy8c2hYImrI175c4XzRENi5cQlq74K8kIpDoSGB+uC5PpZwQmwdW1zxv73R2flHfWlnpUr0BwA0Fet7y6HRZgCBzW6jPJiObdXVaMapN8hg2J3Q3UlBYMdOS2uvbcX3Dsmr296fYpd3YxV+EPThGLe4aW7ykOEz+Vo0zYtPk9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721126136; c=relaxed/simple;
	bh=5CCdHfoKyG99ocltjJIAeKrivlxiY29Hn9AXvqcSX0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UBj89Giqmx78swwrjX/jgb5XsVxBM5bMa1tKc4U4AN3i2PoUV2iSkVs1aNnHJ9PQR5wH/xYKDoTZf59eBm7pXJZUtc9CLZY9i9mVOCda0UUgTMqfagEuVQWYpqSyusVdhrTNQwzIvvwdYVwbz5EErOQ8+VJNNV65Jl8e1RQtXqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=E6d9tU0w; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3UOqNoGWLCSSnRSm7Q9UiHAs7PUq24bCJ52j6CIvkJg=; b=E6d9tU0wv9um9dxgbTievS6reh
	hlTBatpGhfWffLSRaTHyVStY6wQV5IumO9E5rYXu+iSyRKWhCc7AY0/5qdA5GPvdCCC2Wq/8xR1If
	jQfQ3MaPm4qkGWifWWtA323rpMk7WHKJKtaFGu0OZmDOZRt5D8CGSqHipSSOJbeliW9w3VnRaLpkO
	f3qCGh4DpV9q6AMIaK82v+Un6w+bLb8vPqMMWASiO5xXmo64Mh4ArJ9+tGBMsgOSh4QN18oKRlfOK
	6qyy4qH0Ac4nDjzfflf3RWamuy0J1HtcmnHt8HVnkJRyBm0jBkzmVgSCiCao8yR6YKeNb4RrRl+dM
	nb+ZyoIA==;
Received: from [89.212.21.243] (port=52716 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1sTduM-002T9N-0I;
	Tue, 16 Jul 2024 10:51:37 +0200
From: Andrej Picej <andrej.picej@norik.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH] arm64: dts: imx8mp-phyboard-pollux: Disable write-protect on SD card
Date: Tue, 16 Jul 2024 10:51:14 +0200
Message-Id: <20240716085114.3205582-1-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
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

Micro SD cards can't be physically write-protected like full-sized
cards. Disable this feature in device-tree to get rid of the kernel
warning:

"host does not support reading read-only switch, assuming write-enable"

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 00a240484c25..791909dca6e1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -267,6 +267,7 @@ &usdhc2 {
 	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_pins>;
 	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_pins>;
 	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	disable-wp;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
 	bus-width = <4>;
 	status = "okay";
-- 
2.34.1


