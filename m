Return-Path: <linux-kernel+bounces-433212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCDC9E552F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFFA283606
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155E02185A3;
	Thu,  5 Dec 2024 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AyCr3/RQ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3303218AC1;
	Thu,  5 Dec 2024 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400926; cv=none; b=LHMtrmZbR9tX3FUxBhh3qTxYhkvedr8st+svxX0QzERlKH4gX/JMmMBcGx0gzcA78d3Ig62LswONaLlx6dXSTBN48OMETKHZyf2qiELvdyI2+7hovlpQoEzkGcYjPwAZKZNRzkD+jF71g6v+Be6DMfJw451RabaaZhbqgoAA7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400926; c=relaxed/simple;
	bh=s9PqXLkNpVGPkGaqAGeOVRgPs+SSzp40pXGX6y3dMVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iAd8JMlXCctpG1N57D8lj8We4b7bXbvZ107n1wHe86jMJpS66Raw7RWq4XAqZ3p25wdOLa7BtTw5F2Ie9ofiyFsti2WTyYsx2fsAXeiNm9fI89I884KIwO70t5QqdqbR5VBsEAvz5SLNxxIWyJ8kBM1v5G5dceFVtyC9aEnr6vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AyCr3/RQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733400923;
	bh=s9PqXLkNpVGPkGaqAGeOVRgPs+SSzp40pXGX6y3dMVc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AyCr3/RQDBbHkpLbU9EyjM0n0rRgWL876AM4B2L0KQCXM/phSpOoYxqKWtkvRsq4U
	 TDNgLWcIOdnRqrx4TI9ztjOSwagwi4d+f0ofOb9TqZAlNzedHOQhxzX8cn3qeylKWN
	 9FGIWub2DTBXBEiGkJHUqTtZ03MN3JLQqmWZoc0EULG1c753LnNGr5GaOiOmX13Rv7
	 /o7Pybotnudaa0hRMMH73UXnlPLOqlfA8V+rzAgqgecIH2d/b8zQs9fylTvkw+JICj
	 taepxs+mYssa46ygpIFySRHF2SiXXfb9dFJE3lq2ODSIJTOu/j8jJS/R0ooZszj+KT
	 JNydJ5GxId8Vg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1000])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BC57017E363B;
	Thu,  5 Dec 2024 13:15:19 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Thu, 05 Dec 2024 09:13:57 -0300
Subject: [PATCH 4/5] ASoC: dt-bindings: mediatek,mt8188-mt6359: Allow
 DL_SRC/UL_SRC dai-links
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-genio700-audio-output-v1-4-0e955c78c29e@collabora.com>
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

Add DL_SRC_BE and UL_SRC_BE as possible link-names for dai-links. These
DAI back-ends are currently hardcoded in the driver to the
MT6359 codec, but they may still be overridden with dai-links in the
Devicetree to assign them additional codecs or even to make the
dependency to the MT6359 codec explicit and allow device links to probe
the components in the right order and avoid unnecessary probe deferrals.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
index 1e282c34dbd99851d3959b641096968c0b2e71be..8993dff01244db9fc2fbf7bdefe7ea863be7c362 100644
--- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
@@ -63,6 +63,8 @@ patternProperties:
             - ETDM2_OUT_BE
             - ETDM3_OUT_BE
             - PCM1_BE
+            - DL_SRC_BE
+            - UL_SRC_BE
 
       codec:
         description: Holds subnode which indicates codec dai.

-- 
2.47.0


