Return-Path: <linux-kernel+bounces-395657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8936D9BC143
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF8C2829D8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C441FCC7C;
	Mon,  4 Nov 2024 23:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Y3R5bwbZ"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49CD16087B;
	Mon,  4 Nov 2024 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730761663; cv=none; b=tFtGuOd4MAH9BLQVzZZsxExDnrildypblRKNdW/bBu1lmruiNPtcWQ7r/CW/VSFUxcUmF+j0c5gbAhUME5Oc++zaphrBePDl4RxM8tmZehXYAcALvg68FBhM9+vYTX4Iwy5G1Gd3pfAyr8OfbQG7CNl69/Dw5xKi5MvK/7eNhWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730761663; c=relaxed/simple;
	bh=+VfH4fvW+9d8dvRTPYPKDM3ymW0NXD+fA2osgzdzeRc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ezA4uJKJBly7L9CSDevJ/uc6QfikKezELVRkNolYGTvDk587txnJt8S0KapZ83hrPM0NTOZD4lNUsZUZ5KZ/4qU3lEWdvRc+98Zxx4kPUYWDmsoNIWU8f4zAwM+uQB70A+DoSNvVN6jKRwDJaArNCJiX3uiPgg2ceahlBZfqpTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Y3R5bwbZ; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 0BB31A0242;
	Tue,  5 Nov 2024 00:07:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=3SU0Hz8yQJ8VxaLNaO1Vtp9LHZMmrfztXZDJGoyiC6I=; b=
	Y3R5bwbZOPC2SEzr6D/jllq7kjMiy3HgqL6P6XhLIeB9U5xTL7jINNxg5kaThBrp
	56M+YM2KpwYFu9EeuA8RUtrQ9u+bSeLdHkYAQERnBjqyemjdHAHis9r5hREQG6Bb
	c4YUAtyEtie5dvfTO1VO4dXn8LOTW1SGOiw5Eb10Fq6WiXHPwNZ2VutOe00Y8Q6o
	h4uq5Fjk6rK9+qZucw+YsS/Dpeh8gW/EdfSa1P/sF4A3PSC1IUVcBAe/EJ9Rd0pq
	5QJ1Go4U2eqJdEbft45z8T/LaE7NC3290tpkLd0OzM0dL/qFshLnJiHgADmaabzN
	IJ8znJDu1Sk6MRfdCJd+9x36jIRPShHtIguAV5FD/PuLJfXv5yQP0nNs9dDSiwh/
	0o/YqIHpOcpc9Yv0R+gj/bggArjRdcR0tbAL/SY+IXbH4Nm/gdlNd47XSyMCpKLe
	n09q46T5letUknQ4bU6mLa5jJkz4INBp9e14vy9oyPaEo34wZF5gSVJsginRfrKZ
	W2hvzHz2ekQNb0cxaLnd/BpDh3vkGw47t2f9vxu29BYJFCyBwTT3y8HX23huy/Dg
	2Q9PBvLtKIBnpYfaU+YYAqwliQP0RdjfCBXeP8t3t22sAJCDb/74lHEpKWFm+4CO
	gn4GBcHuN+E5kTewkKUoRVWlmAl4/uW5Up3L9zC7SNg=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: Andre Przywara <andre.przywara@arm.com>, Florian Fainelli
	<f.fainelli@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Enric Balletbo i Serra <eballetbo@gmail.com>, Alexandre TORGUE
	<alexandre.torgue@st.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, "Tony
 Lindgren" <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>, "Kunihiko
 Hayashi" <hayashi.kunihiko@socionext.com>
Subject: [PATCH] ARM: dts: allwinner: Remove accidental suniv duplicates
Date: Tue, 5 Nov 2024 00:06:27 +0100
Message-ID: <20241104230628.3736186-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730761655;VERSION=7979;MC=3740397895;ID=239242;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855667D63

Allwinner suniv boards' DT files were accidentally duplicated
in the Makefile when they were moved to the new directory
structure. Remove these duplicates for code cleanness.

Fixes: 724ba6751532 ("ARM: dts: Move .dts files to vendor sub-directories")
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 arch/arm/boot/dts/allwinner/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/allwinner/Makefile b/arch/arm/boot/dts/allwinner/Makefile
index cd0d044882cf..2ea5df3d9894 100644
--- a/arch/arm/boot/dts/allwinner/Makefile
+++ b/arch/arm/boot/dts/allwinner/Makefile
@@ -268,7 +268,3 @@ dtb-$(CONFIG_MACH_SUNIV) += \
 	suniv-f1c100s-licheepi-nano.dtb \
 	suniv-f1c200s-lctech-pi.dtb \
 	suniv-f1c200s-popstick-v1.1.dtb
-dtb-$(CONFIG_MACH_SUNIV) += \
-	suniv-f1c100s-licheepi-nano.dtb \
-	suniv-f1c200s-lctech-pi.dtb \
-	suniv-f1c200s-popstick-v1.1.dtb
-- 
2.34.1



