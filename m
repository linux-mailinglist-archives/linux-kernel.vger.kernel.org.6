Return-Path: <linux-kernel+bounces-440282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893659EBB39
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D73284163
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D6522FACE;
	Tue, 10 Dec 2024 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D5DLps8m"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F8A22CBEE;
	Tue, 10 Dec 2024 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864094; cv=none; b=JwrvXjhZAK2UAjsCLTW9RQmJlslCyxsIXiTwi2WqxvqIF7AcbHPSrzSCk0WMGMBdRLiR7bw3YhMIr9HDaEoRn/Jnciv3k02BqDJzbRXJ+4vmmJJQiIG97OCsT2aSoiz2GCqvegBfBZ/pKOX2T7mWLKcuZ5L+znil8ksrfBx7K2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864094; c=relaxed/simple;
	bh=bX5IBMFvCW3Tl5rVU/2EPDmVSZsaIwEI7lqJXqvl0Is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gx/0Q7Oituak7cUml1eTcZmetWCtramvytaV62xNK/yDocK2iR9KD22yDan1+qI6oUix05l2nmNsexqkOem2xyIZ5i4tcyyEEy8a+ij3E4+pQX9779N43N6zwr1jiDkWO4KZyMugFrkWpy3vEDA58X28h2OBMw/h2ILDOSlk1tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=D5DLps8m; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733864091;
	bh=bX5IBMFvCW3Tl5rVU/2EPDmVSZsaIwEI7lqJXqvl0Is=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D5DLps8mkdsk+IVa1L7HH//QDHh4n2jJpod55gEbQQitR13hw15rssO8pmgJdEM/Z
	 ZVIfGpPZAoFIgMChKLGxsRXlLzAQnBEujf9P0PxONqvXER8Uj5FuyaspI15fgeO4pU
	 M9BOZHq08DEzoDGvt7K41or/H7kD/wvSdcgNY1JcqE7F3rRGEjs4GdlGl760wAFWSk
	 B6esiTOKTKAG+LKk/GRjH1KoUBHH0jnOC3nsrQwsO40rlgXd/lQS4YX0NZpTGkLOkB
	 Peu3e75SFvMp5+rzEy8rLOI3SPQoqbWTNWI/SnUO1tQydkdzjAiBSYxOEWDDhHAEVw
	 OinXjE5GYWQ7g==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 02E9817E3804;
	Tue, 10 Dec 2024 21:54:47 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 10 Dec 2024 17:54:28 -0300
Subject: [PATCH v2 1/2] arm64: dts: mt6359: Add #sound-dai-cells property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241210-genio700-audio-output-v2-1-c50886ae0be2@collabora.com>
References: <20241210-genio700-audio-output-v2-0-c50886ae0be2@collabora.com>
In-Reply-To: <20241210-genio700-audio-output-v2-0-c50886ae0be2@collabora.com>
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

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
2.47.1


