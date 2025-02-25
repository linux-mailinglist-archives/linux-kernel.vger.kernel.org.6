Return-Path: <linux-kernel+bounces-531646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A2AA4430E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A267860C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09409272907;
	Tue, 25 Feb 2025 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FhjLbkqd"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A2F27424F;
	Tue, 25 Feb 2025 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494140; cv=none; b=ucMI/u3qi2l+LiYl7+XfJ/OKqWCktpT+bkjYBupOrfrZVuGoK9nV/pbItWREH3HadQN7OxtveWNW2y/V0+jPYRR8DbSq26i+8Rj8GV2DKoyD7u3QpUs+n75zzO049rdndL92WN/tattPHwDkHjRI04AiM/TxfJbgO/NbgyrNF6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494140; c=relaxed/simple;
	bh=qVV8kVOhgmF8ivc217Cn73eSTlkBc3CdkndiqKhaMgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uZhRPrnnMavJY55JdewurCxY+/sC4LzLWbfNlEgp5UbkgLl9E+dYoSFW6H7T7F+qCMT2pAPzixDTsqNPOq3cJosyqkElXInVzbpEpr9rO0TfATQxfpwPCmK0GVqFnaPhGJkEc5nU8Be5nJLPvQfQ5XsaxJEwfscYLxnLvAyiWfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FhjLbkqd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740494136;
	bh=qVV8kVOhgmF8ivc217Cn73eSTlkBc3CdkndiqKhaMgE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FhjLbkqddWAwTD4TtQ4cAhWO0rMwRCsgE9B3muy8SXbHEEhqkSiG+9bwExP/7MBCJ
	 44dvHpYoviV1HjASKa7hm8dSvLG6t4hV3pMyhlFLOFU5vA/L+9sj/diiU7r6v8Hx98
	 qaRfiJzJj7esvIksUT2kAyIpJXDZWyYEZujAaTeYC5M9W3nehQAwVRGz22x2TrdKVB
	 AlwWx6xJ4WPvO6an2zvWKoXUFxf6OugCKBPuSwfNO90VfLXfGwL7+F2q2x7YbNNU+a
	 i9IRZlWuHkKf2CwWlvHKC74vUrBH2fZft5IlSFRSgDo5jOuIKHOQDQFfAnYFfzrnTa
	 bGccwDUcUBp1g==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1004])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F15BA17E0DD7;
	Tue, 25 Feb 2025 15:35:32 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 25 Feb 2025 11:33:54 -0300
Subject: [PATCH v2 8/8] arm64: dts: mediatek: mt8390-genio-common: Add
 delay codec for DMIC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-genio700-dmic-v2-8-3076f5b50ef7@collabora.com>
References: <20250225-genio700-dmic-v2-0-3076f5b50ef7@collabora.com>
In-Reply-To: <20250225-genio700-dmic-v2-0-3076f5b50ef7@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Zoran Zhan <zoran.zhan@mediatek.com>
X-Mailer: b4 0.14.2

The signal from the dual digital microphones connected to the DMIC_BE
takes 30ms to settle after being enabled. Add a dmic-codec with
corresponding wakeup-delay-ms to prevent an initial "pop" sound when
recording with the microphones.

Co-developed-by: Zoran Zhan <zoran.zhan@mediatek.com>
Signed-off-by: Zoran Zhan <zoran.zhan@mediatek.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
index efdeca88b8c4e58f0c17825156276babf19af145..6aa59acd77c245e5fcf7044859a5985f503daeb3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
@@ -218,6 +218,13 @@ usb_p2_vbus: regulator-9 {
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
 	};
+
+	dmic_codec: dmic-codec {
+		#sound-dai-cells = <0>;
+		compatible = "dmic-codec";
+		num-channels = <2>;
+		wakeup-delay-ms = <30>;
+	};
 };
 
 &adsp {
@@ -974,6 +981,14 @@ codec {
 			sound-dai = <&pmic 0>;
 		};
 	};
+
+	dai-link-1 {
+		link-name = "DMIC_BE";
+
+		codec {
+			sound-dai = <&dmic_codec>;
+		};
+	};
 };
 
 &spi2 {

-- 
2.48.1


