Return-Path: <linux-kernel+bounces-321781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AEE971F5D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F891F2287C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C0B166F3D;
	Mon,  9 Sep 2024 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oPyu9U4P"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EECB1758F;
	Mon,  9 Sep 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899782; cv=none; b=tj0ZMcOIcd5sOkTd+s5yioiuYvUjQE6NPgNfIsyowe0S2Q+pNsTzg3WPKEtZKFgYK5P49eKryUhUnjtKuE5UtsTO8XjTSay55INSel2SgNQRGNGtaBE/MTEF5FSTH2DXysAj/DhIm4QnyZR/wkX6vhk1zmjSO3uUgB6jYcoVzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899782; c=relaxed/simple;
	bh=FclFSf8FsCbG3fQav3OgUtvEsLk1smEIFvpfVk170gU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWpC2NjTulrP6x/levPTb7f3IB2rYVeDxvzlpxuAAZ2N7cnrwLvp2fozdTOVk0JhXKQlBDf1W7jravWrqLWfivNjRx4SQgnvOQj7+ziLG4+i/55tfr9lYmyLC+BIpsngPttbfQrSqm2J1/PjDxC9VsAW5Xb34ZjK4OEFueNXr3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oPyu9U4P; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725899777;
	bh=FclFSf8FsCbG3fQav3OgUtvEsLk1smEIFvpfVk170gU=;
	h=From:To:Cc:Subject:Date:From;
	b=oPyu9U4PgYBX/KN9dZCJ8ufd/krOlZpiQeuq8Mo23NhVMrpsh8Y64Tv/fAd8uTTmN
	 tMoL2tLhYhwdwLO4QmHJScRo+Tu5N526kVlJXoScWUwGqUeg0KGuL72DApqSWSCz7p
	 VoOau2YMyUYI2M2TaAW+18AlJP+WWUhht0Wu066TdJvdVpmwBWUiVlKX3j0Cn7Xgab
	 Jul+9tWGUWgModujrZDgvKovXSQnwVIiSduMjmh8jlK82wAofX2KDSZFTaNSxHW2my
	 0SOpcF/FopJvZJQrGWhdVNMajsaIIt4NZK/k9/z92J7xnt0t0pc+b6TwNl5T8CBAWI
	 FjbqWeE0vGjVA==
Received: from pan.lan (unknown [IPv6:2a00:23c6:c32f:9100::16d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: martyn)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 73D7717E35D9;
	Mon,  9 Sep 2024 18:36:17 +0200 (CEST)
From: Martyn Welch <martyn.welch@collabora.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com,
	Martyn Welch <martyn.welch@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: arm64: dts: ls1028a-rdb: Add iio-hwmon compatibility table
Date: Mon,  9 Sep 2024 17:36:07 +0100
Message-ID: <20240909163608.80541-1-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ls1028ardb uses the TI ina220 power monitor. This device has an IIO and
hwmon drivers, but can't be used with both at the same time. To enable us
to utilise the iio framework, but also access power information via the
hwmon framework, add an iio-hwmon map. This allows the IIO driver to be
used for the ina220, with the iio-hwmon driver mapping the data from the
IIO framework into hwmon.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index ecd2c1e..b062de5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -94,6 +94,12 @@ simple-audio-card,codec {
 			system-clock-frequency = <25000000>;
 		};
 	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&ina220 0>, <&ina220 1>,
+			<&ina220 2>, <&ina220 3>;
+	};
 };
 
 &can0 {
@@ -222,8 +228,9 @@ i2c@2 {
 			#size-cells = <0>;
 			reg = <0x02>;
 
-			current-monitor@40 {
+			ina220: current-monitor@40 {
 				compatible = "ti,ina220";
+				#io-channel-cells = <1>;
 				reg = <0x40>;
 				shunt-resistor = <500>;
 			};

