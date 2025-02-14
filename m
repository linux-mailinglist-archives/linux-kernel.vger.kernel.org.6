Return-Path: <linux-kernel+bounces-515506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AF6A365B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 488917A16D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0968E269815;
	Fri, 14 Feb 2025 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FnJ6qMU3"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B1214D28C;
	Fri, 14 Feb 2025 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739557561; cv=none; b=OzWQeoz52MsHEKvS5N4uvqnJdDBp6QJU8nEQvetE8Aq9siA6i4QLOHyCL0cViHVV8SU3Jw73mDLozlbDGrGIwZTtWyW904uZTWSHx0QMl8nY8QqIfU5ouf4uIG1ntVmiExo4Q8fRQ4eznFpzyOm1IIEtvglv/MCKVwgzDHM+ul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739557561; c=relaxed/simple;
	bh=+x+hwGbeiiewIBUcuyA6IeK0Cv+3CNmAHDuMbjvIz6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SwUZR3gCXuN4rUZ6g7R59Aog+Yx4D9op71Vgp4/1KpBED30BdwYnxieHP1/J/7jy/E3F+ELVgqxKcRy2z+o5NMvAcGTLWgS0Wh/QqBQ44UpCrA/Lb98t9zLVeVkB06ylPBpJdWOVh9kaqmlP1+ObeoTQ90NFNnaVtWuSF9mhZ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FnJ6qMU3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739557557;
	bh=+x+hwGbeiiewIBUcuyA6IeK0Cv+3CNmAHDuMbjvIz6Y=;
	h=From:Date:Subject:To:Cc:From;
	b=FnJ6qMU3StLaOoSe1JuVVdejdtt0RqIDPk1bTxBFNPP0dyUhngVKn9kqDNFKYlq2E
	 c1EEOmz7gTi9JWcSicMlwqgr7TGQMbQc2rDHUqj7zCYrhqLnN9o3LbZBB6gqV4mtdU
	 Zbm8NhvE0J7qGytFx+wCCli69zHhYmb+BfNhuO49HY0IBUCVXFcqclyXBYi6y9Nys8
	 GUJ/apo2REPQlP8MhiONgLcvqvV853LqLw1mqxUtGd7Ctg8ESzkLvX+i0SnE/p7HVS
	 mBDby8L0H1MDAj0JfXf4h5UapUUsLXug3j6Y+YW2T7dBxmShfluNJxI3W71lC3/NxE
	 FZlJogFvF3SWA==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F08E417E0FC1;
	Fri, 14 Feb 2025 19:25:54 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 14 Feb 2025 15:25:48 -0300
Subject: [PATCH] arm64: dts: mediatek: mt8390-genio-common: Add DMIC codec
 for delay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250214-genio700-amic-wakeup-delay-200ms-v1-1-0094837c62b7@collabora.com>
X-B4-Tracking: v=1; b=H4sIAKuKr2cC/x3NSwqDQBBF0a1IjVNQdvxAthIyKPXFFGor3ZhEx
 L3bODyTe3eKCIZIj2yngK9Fm31Cfsuo/ajvwdYlkxNXissL7uFtrkVYJ2v5pwPWhTuMurETmSI
 3dVMpyuoOCKXMEvC2/7V4vo7jBBfc4ldyAAAA
X-Change-ID: 20250214-genio700-amic-wakeup-delay-200ms-b7b6ae563ee0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Zoran Zhan <zoran.zhan@mediatek.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

The UL_SRC_BE DAI is connected to the MT6359 PMIC which can switch
between a headset microphone and a built-in analog microphone. Both
microphones' signals require around 200ms to settle after being enabled.
Add a dmic-codec DAI to the UL_SRC_BE dai link with the corresponding
wakeup-delay-ms to let the signal stabilize and prevent a "pop" sound.

Co-developed-by: Zoran Zhan <zoran.zhan@mediatek.com>
Signed-off-by: Zoran Zhan <zoran.zhan@mediatek.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
index a37cf102a6e928440cc88e7e8fe0225fc28ec962..6c934d70c1eadbc7af3f97af1961e629ab62ab3d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
@@ -218,6 +218,13 @@ usb_p2_vbus: regulator-9 {
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
 	};
+
+	amic_codec: amic-codec {
+		compatible = "dmic-codec";
+		#sound-dai-cells = <0>;
+		num-channels = <2>;
+		wakeup-delay-ms = <200>;
+	};
 };
 
 &adsp {
@@ -970,6 +977,14 @@ codec {
 			sound-dai = <&pmic 0>;
 		};
 	};
+
+	dai-link-1 {
+		link-name = "UL_SRC_BE";
+
+		codec {
+			sound-dai = <&pmic 0>, <&amic_codec>;
+		};
+	};
 };
 
 &spi2 {

---
base-commit: 0ae0fa3bf0b44c8611d114a9f69985bf451010c3
change-id: 20250214-genio700-amic-wakeup-delay-200ms-b7b6ae563ee0

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


