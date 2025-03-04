Return-Path: <linux-kernel+bounces-545640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1224A4EF81
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E53D3A9EA4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76242777EE;
	Tue,  4 Mar 2025 21:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LbGXHHBl"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE1A259CB0;
	Tue,  4 Mar 2025 21:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124640; cv=none; b=MXoTXkLdtyN7fj6INF9yUSPOOFRWLSpXF5k+PN+spAFiMYdxeb+tEhMaLYzMMrktRvfhn3v7xeU1yz2m4AeWAIg3b1pOm4JRmlB5xmXRDhDeGMAIZuAFmFWTZwBEn6rLUb54RvBtR6uDTSV8wxSkt7XjLYEuu7N+xHaoXVEsHHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124640; c=relaxed/simple;
	bh=uJqRyRDrhR+bFdnuWX2kCJ50vTE2fJm3kzGtsIJnJxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PEgip5fbDRaRY35ze/dXk2CaO7bet/Em+/u+hs2m1jndCbu8uV5iGMGwmnQWzL+goMw69Na7/X+AYkKQLDi9aduytULU/cSOZcvqiVQJDK2J75D9sVn9SsH47zm4i9Pnxv5bF3UOyWkU0d2Ckyl99WZsSMnUhxSJAxtvhr8knkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LbGXHHBl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741124636;
	bh=uJqRyRDrhR+bFdnuWX2kCJ50vTE2fJm3kzGtsIJnJxA=;
	h=From:Date:Subject:To:Cc:From;
	b=LbGXHHBl6KhPy/rpTrUoczuClXv2maOy4LlaICgDAB0XkxKniLAlukTFjfjubpynP
	 /YHL9hz9jarB6GSaY96TCvaTf1wUfIfEV0HZwyYnD8X5t0nAarZfqh5ztcJ2/bbBi3
	 tBc6LXK4gsnMjbFgHBXXgdJYtkp9T0ozQ0r/kQAsJI7329SbgnUwbV5jlWNLpx04YI
	 wyOo2oAUEcHs+8UTT87+rvVbNAAxKG3NweMNkLqIDcgcVMXLh8MZugLJ1nqwSa2hpC
	 lDW1+UdyN9D9l+l2pKTYJpbibsbARcOeLL9yLXcnhJPP8X9uKgoScCdS0m7Sh8ecj5
	 6IbI5zRDLFtQg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2D20C17E087E;
	Tue,  4 Mar 2025 22:43:53 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 04 Mar 2025 18:43:49 -0300
Subject: [PATCH] arm64: dts: mediatek: mt8390-genio-common: Add jack
 detection with accdet
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-genio700-accdet-dts-v1-1-86d77c5cc745@collabora.com>
X-B4-Tracking: v=1; b=H4sIABR0x2cC/x3MQQqAIBBA0avErBuYzBK6SrQQHWs2GhoRSHdPW
 r7F/xUKZ+ECS1ch8y1FUmwY+g7cYePOKL4ZFKmJRtK4c5RkiNA65/lCfxXUVpvZBA7KeGjlmTn
 I81/X7X0/CZbG82UAAAA=
X-Change-ID: 20250304-genio700-accdet-dts-4a4767fef27d
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Enable audio jack detection for the Genio 700 and 510 EVK boards. This
is handled by the MT6359 ACCDET block, which on these boards has the
HP_EINT pin pulled high and connected to a normally open 3.5mm jack.

Add a phandle to the accdet in the sound card node so the machine sound
driver can initialize the accdet.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
This patch depends on both "Allow retrieving accessory detection
reference on MT8188" [1] and "Get mt6359-accdet ready for usage in
Devicetree" [2].

[1] https://lore.kernel.org/all/20250304-mt8188-accdet-v2-0-27f496c4aede@collabora.com
[2] https://lore.kernel.org/all/20250304-mt6359-accdet-dts-v3-0-5b0eafc29f5b@collabora.com
---
 arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
index 992bf60c097ae3b1fd6d4e62ef1a327b146496ef..e53c6b0b5a53a616a1684e6efc3758f449294bb9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
@@ -1189,6 +1189,7 @@ &sound {
 		"AP DMIC", "AUDGLB",
 		"AP DMIC", "MIC_BIAS_0",
 		"AP DMIC", "MIC_BIAS_2";
+	mediatek,accdet = <&accdet>;
 	mediatek,adsp = <&adsp>;
 	status = "okay";
 

---
base-commit: 20d5c66e1810e6e8805ec0d01373afb2dba9f51a
change-id: 20250304-genio700-accdet-dts-4a4767fef27d

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


