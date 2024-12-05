Return-Path: <linux-kernel+bounces-433209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F27C9E5528
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC641881AA8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96C021858C;
	Thu,  5 Dec 2024 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KAQvd5HU"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8622C217F5C;
	Thu,  5 Dec 2024 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400915; cv=none; b=TOOQc2cpnfaEraDExSojVAnKkWFU98KNgPkr6Bhr7rNQ++tXEcNZIbeSUh5CebCib7rMS/nkWuBvDymhl/abypxoStI4jsAUWtSBd4awB+euNVY5qMZH5011vtFcS11gVpe082Z8BYW7GlvEqdNgI70hZ/UT81J6SXKfEqHyUSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400915; c=relaxed/simple;
	bh=3osrUVPXdinibWxj7SczBHB1PesbS1XtEfk4gNr9G/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kzZipmWbU/5KVYdd1HcG91TIJoDPW7RfB6P+kWjV85bQK+/xKVxsYLyS+eOTPrR3tcMhHEObnB0oYJpUEgy9xDzJXWUphb6QPzxJRwJawYpjP+7A5fP5kf/VPsxmuZgSX72egSaDZVvS/oNAQVOUr8Upjs98G5hk4SOTxbfu6nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KAQvd5HU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733400911;
	bh=3osrUVPXdinibWxj7SczBHB1PesbS1XtEfk4gNr9G/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KAQvd5HUAJXQSUc6jyaZmoSIdmH+nc+sZqpV1GDQ1Kws6RScKaPpY3zrDlnyQN8Md
	 YvHIMeqksV2Gju4JmnubLAoKYj8RbZkFWKI9nbCoIE4pNopDD/JLXqUzhkAp7EsIVT
	 nGvfz5V2fTUuBaG3Rg38/taZjnpP1C4e2QcxJ/3o+E2DRqlnUg5BN+OgjR+vgLLKlK
	 ot19Q5RKcILbXgqoF8ipQVUal98/mGo7q//1Ib0eUfXN45HYigjZ/XsPlzXrCMe+99
	 QZG0lQhSgH4gJrULZro6jrqwDTX5NPzCaRBWYXZ6Juq8dcwt3755noh7vBQ6B5UkKY
	 CffPmOwPnYGBA==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1000])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7216217E3661;
	Thu,  5 Dec 2024 13:15:08 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Thu, 05 Dec 2024 09:13:54 -0300
Subject: [PATCH 1/5] arm64: dts: mt6359: Add #sound-dai-cells property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-genio700-audio-output-v1-1-0e955c78c29e@collabora.com>
References: <20241205-genio700-audio-output-v1-0-0e955c78c29e@collabora.com>
In-Reply-To: <20241205-genio700-audio-output-v1-0-0e955c78c29e@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

MT6359 provides digital audio interfaces. Add a #sound-dai-cells
property for it to allow pointing to it from dai-link nodes.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6359.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
index 8e1b8c85c6ede94a7beaefcdfc74ce47b3ab50fe..150ad84d5d2b30ab6064c71e1375ce5df5ae4b36 100644
--- a/arch/arm64/boot/dts/mediatek/mt6359.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
@@ -8,6 +8,7 @@ pmic: pmic {
 		compatible = "mediatek,mt6359";
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		#sound-dai-cells = <1>;
 
 		pmic_adc: adc {
 			compatible = "mediatek,mt6359-auxadc";

-- 
2.47.0


