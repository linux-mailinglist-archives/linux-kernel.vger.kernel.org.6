Return-Path: <linux-kernel+bounces-531638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1EAA44319
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9044F188F93A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56568270EA2;
	Tue, 25 Feb 2025 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aOpv/Txa"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0026FA49;
	Tue, 25 Feb 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494131; cv=none; b=iehzktFjgijTR+r559hKgqBVgwSP7dD4SNOxu1+R2exBj8Gs1XFsHvbawHb9phdT02lJ/WkOWtHdZfeN2AJNbEh7QJ+v4h7wFehTWeeW1jocUWwx/8nt8ugp6I7d5o5Z+E3YEgZQVoAmrKKi+pu5G2ax85WFeiggX3gHxfpsnLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494131; c=relaxed/simple;
	bh=3Q8vh4dqgs6gSrA2h35eYPA23DKBRh9HZ/RKTzTbByk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LTeah98Lpcfj3FN8v2xP1SGE2rX4k841Pa84pJXFW6Q/P14SUTWWYq00/Av+PHPHV2J74O2P7Lon9NA4H4L54V2GHvgoytLuon7VzpITGYRwEdaPcNv3MDa9LpoWBeQJsXcDfRSmQm/FTEV9kYJRg841uizb8NEs+x6pKzlcX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aOpv/Txa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740494128;
	bh=3Q8vh4dqgs6gSrA2h35eYPA23DKBRh9HZ/RKTzTbByk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aOpv/Txa7z0/W/NhoWZ89fCcbP5ZoXOVuz+qQ3c32YUPWNBkOX4Lf+nhWDZa9hTGX
	 GjUGu4xpPR52Npu3GzoXGbJU3E4HuKU7X4TDTzlqcORwnRGVQPQaP13clc38sWYUyI
	 UUoUtPhxLaG2UQzPlzaCGUE5gntqvLE76DdscerioVOfWf88e6DdDPOwu00qcShpMP
	 pxEY8Ix8CNNv7fSZM/NUIvhI03GuP49CtoIMsVYTR1VoaKaK4GnErDKhNPek4qJiCK
	 5a3UoZ5lGG39FpZ/DbLrcHCE08MvIl8Gfziw826qFX15E7+9p1zTF6JnP9J7JsC5AJ
	 EDWe0Zg5ejOkg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1004])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 119E817E0DB7;
	Tue, 25 Feb 2025 15:35:23 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 25 Feb 2025 11:33:52 -0300
Subject: [PATCH v2 6/8] arm64: dts: mediatek: mt8390-genio-common: Add
 routes for DMIC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-genio700-dmic-v2-6-3076f5b50ef7@collabora.com>
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
 parkeryang <Parker.Yang@mediatek.com>
X-Mailer: b4 0.14.2

Add necessary routes for the onboard dual DMIC present on the Genio
700/510 EVK. The dmic is supplied by micbias0 and micbias2, and inputs
into the MT8188 DMIC DAI.

Co-developed-by: parkeryang <Parker.Yang@mediatek.com>
Signed-off-by: parkeryang <Parker.Yang@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
index a37cf102a6e928440cc88e7e8fe0225fc28ec962..efdeca88b8c4e58f0c17825156276babf19af145 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
@@ -959,7 +959,11 @@ &sound {
 	pinctrl-0 = <&audio_default_pins>;
 	audio-routing =
 		"Headphone", "Headphone L",
-		"Headphone", "Headphone R";
+		"Headphone", "Headphone R",
+		"DMIC_INPUT", "AP DMIC",
+		"AP DMIC", "AUDGLB",
+		"AP DMIC", "MIC_BIAS_0",
+		"AP DMIC", "MIC_BIAS_2";
 	mediatek,adsp = <&adsp>;
 	status = "okay";
 

-- 
2.48.1


