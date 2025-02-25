Return-Path: <linux-kernel+bounces-531644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6715BA44334
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7A8188DFC7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A910274248;
	Tue, 25 Feb 2025 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bE+rB8Y1"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275DD272907;
	Tue, 25 Feb 2025 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494137; cv=none; b=JJYAIv/LVKiyyQ8m7VJDfpegS1ds9jPyj9HuHDpHOytI6ZyjTGfS05cTt+PQg4Zgm9vhZXxlNgbEIMmSGq/hhd2KlSjeQRWcMB0TtjYZ9SlopMPeIY1Irq0UWIYJ+q/+NCqz1Zogyypn2GJF0r5qDY6SV/0ii9Lt36yksyebPrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494137; c=relaxed/simple;
	bh=Skk39L7rjdPJjn3Yg0DBWoQQlhn9HJYB37tSSwUK8o4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dmKUZxoOafuPixv5RBBNbpAxTnrPJs6Ru+AxQiswt/M2iMoywjD1Y4gupjS4kNTuHlwXFDpvWCh1yCeMdWjSRJ2BFn8+cPlV4nEIAus3/el5Kxza32ioUOgQ/SEVKOdMEmOb8sacRZ1kP8nyvi4VuBmZJPXee9XN82IbokkvOoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bE+rB8Y1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740494132;
	bh=Skk39L7rjdPJjn3Yg0DBWoQQlhn9HJYB37tSSwUK8o4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bE+rB8Y1zsPx3E+gIBvGT2pcZT6YLZKwtTgTLm+h+8lfv5Ru8YqRCDR420+DE+Pa3
	 xFJyKfgFFemOuRxpScg8CEf/Dvt/eeGk4PZfCntr5814qcMCCzm1sHv4NcAg9ojXKD
	 HU9jjhu3Jcqe4DcR/ujcLd+ikMu4d1Jgm6T0XPSmwRSFIsePIO85TTCMfUa3HWLJo2
	 xOLFEJStSXDcGmC2gN2//BAuhMn+WhbXukDVlQ3o2D+MP30fCWPlHw6SZAYQlZrYfP
	 +iNf4BRLAoWDpuJUa5aetmNnubRkTZuTWCrNDsLYXEusyCH8fnn8eh/BRhiFm0bSGp
	 b6mbv9rHe339w==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1004])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9055617E0E91;
	Tue, 25 Feb 2025 15:35:28 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 25 Feb 2025 11:33:53 -0300
Subject: [PATCH v2 7/8] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add DMIC
 backend to dai-link
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-genio700-dmic-v2-7-3076f5b50ef7@collabora.com>
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
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

MT8188 platforms also have DMIC DAIs, which were previously undescribed.
Add DMIC_BE as a possible backend for the dai-link property.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
index 362e729b51b43ec16716aee70ad736420def81f3..8c77e7f68ad7b6f5b88b53cedccb291139a2eeea 100644
--- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
@@ -62,6 +62,7 @@ patternProperties:
             - PCM1_BE
             - DL_SRC_BE
             - UL_SRC_BE
+            - DMIC_BE
 
       codec:
         description: Holds subnode which indicates codec dai.

-- 
2.48.1


