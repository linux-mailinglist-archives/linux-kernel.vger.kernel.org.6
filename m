Return-Path: <linux-kernel+bounces-190356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C82B8CFD3B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026041F261A5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1AB13AD3D;
	Mon, 27 May 2024 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uDju4Zop"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CD513AA5A;
	Mon, 27 May 2024 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802755; cv=none; b=AxA2O/f9UEh9AF0lQRO01qXPAEoDivAMm12r4gichjXeBsgsuwt1t6pHou3hC95SOtmyHpxXtnhDuYdz5CGvjqVn+pn/fjBa0oX+nmD/OjRluzmnzSBCAnIrEP/ITeimT/q9wmZreJ56vgFsACj7sWDnXrN/J3wQwFnSy/a080g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802755; c=relaxed/simple;
	bh=/Pi5oJU7aEoIDdHU8CS0oZMV/OUfjI2UVTwuZAZZZoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARk3fdVKQjadvp3fNt+iANaLXbw5bP+Ma93np6rzQd0p1NOSLFIAmnRwIyRirTiCrF6jWd1NAgcb8d9bgP2C3yJBxTVIqOsDQc/P7a+IHi93U8X/b4Nkugq1DT0qkFRpl3haapKU352iFMlgamntfUFPAwh6W0sP3+efcn3N/dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uDju4Zop; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716802752;
	bh=/Pi5oJU7aEoIDdHU8CS0oZMV/OUfjI2UVTwuZAZZZoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uDju4ZopbhFdpJxkuzKCxrtzDM/whBB0cpilfSHMcBV0UbANXRP1PZ+MUeTHO5cmC
	 ZdLTy2m5HqdT7hcr0TrN0+vk6wpbJ15c8065nn4x8Rr9+imowysMod/LR84jjyL60H
	 tLkJcz1eA6Yp1U9KwMT0r/N7oa3q/icUO91W8JdtR+zpPZzVZg+Dm6QflXq3IgRVm+
	 FaqyRXSEAIuTxy+Zi9q1eNP9WRgcX9RoBPwIp6YOyUaqaBg5gGL02JYyqFJA7m/bxX
	 B7kPe3ArGKQbOauzIV1+XrlHbgk8CU8p77IGl0GCtlDTMv2WgaspNBMk9+T0I8pS4a
	 Hqi/jP8jh6ftg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DDFC3378203F;
	Mon, 27 May 2024 09:39:11 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	mandyjh.liu@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	jpanis@baylibre.com
Subject: [PATCH 1/5] dt-bindings: mfd: mediatek,mt8195-scpsys: Add support for MT8188
Date: Mon, 27 May 2024 11:39:04 +0200
Message-ID: <20240527093908.97574-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527093908.97574-1-angelogioacchino.delregno@collabora.com>
References: <20240527093908.97574-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible string for the scpsys block found in the MediaTek
MT8188 SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
index c8c4812fffe2..a0d646dfec42 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
@@ -22,6 +22,7 @@ properties:
           - mediatek,mt8173-scpsys
           - mediatek,mt8183-scpsys
           - mediatek,mt8186-scpsys
+          - mediatek,mt8188-scpsys
           - mediatek,mt8192-scpsys
           - mediatek,mt8195-scpsys
       - const: syscon
-- 
2.45.1


