Return-Path: <linux-kernel+bounces-220731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EC390E65E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B6A1C2199F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA9B8002F;
	Wed, 19 Jun 2024 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="or7SDsQj"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0107D3F4;
	Wed, 19 Jun 2024 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787213; cv=none; b=ZUYsJnPZHVYsa0cLU2BkEcj1S1nPU8B71i9vTQXEnpGOIaP12NcgayJA/nl0robnJhZ4u1+ScnV/vQ1KVUarDJv5s45rY9HQIQq40/QRV/wlj161XkA+HXpD0djgVum/2wqdYtOq7VCI9liD/f5ojWhnLJ4vqadEiHKuCuC4hgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787213; c=relaxed/simple;
	bh=lCfHohG63RrD0UHXY1pyKLOU1ws6R6MqoXkdOh2BC74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqinMzbr1PR3Qn3I/5RPOwpD61xAH0r80lfIX3MtgA9OjNMM/yRXjqjJ4VAspKcYcDLL14dW5QoEjkUOZKuTCtH0S/IlqcYE68rbmg7BZGN6dr7lUKp5NJKc4DA6Wu+bHCSCxQGzoVJsucmGQQg3b2ecjdHJ0OhaZs9gc+bDf4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=or7SDsQj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718787210;
	bh=lCfHohG63RrD0UHXY1pyKLOU1ws6R6MqoXkdOh2BC74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=or7SDsQjpGnftM5Fo97nnYxjwHXbRR+Pgk3Pab1sbX4RJ7O0A1LncnW8xGZsoc4Tw
	 /GLKPK77f1yiu6VQAp32/oZMNecKgVceS/iVoDVaO8hO3UaYVO6f/rPhthgU4mZHIk
	 089vocbVpfBSSvIoGbDZPt4zJmHaQEfFRzmpcI8X+eqG4BCG0dAVYroAS5EUPyq5yI
	 KevjOlH0W9c1ArFRL/Q5KWE0sz8fRwMznpW+ShIVVEmUllicvS8kmvnwg6gBBzHbrd
	 s0Acm4ZVqH+98WbbBvVLjHlrt2z6XH1WROgJc5GnvQy3exEo/u+46wQx02JZq22TKY
	 CJhSOq/rxNWuA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8331C37821C3;
	Wed, 19 Jun 2024 08:53:29 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: krzk+dt@kernel.org
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	jassisinghbrar@gmail.com,
	garmin.chang@mediatek.com,
	houlong.wei@mediatek.com,
	Jason-ch.Chen@mediatek.com,
	amergnat@baylibre.com,
	Elvis.Wang@mediatek.com,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 2/3] dt-bindings: clock: mediatek: Document reset cells for MT8188 sys
Date: Wed, 19 Jun 2024 10:53:21 +0200
Message-ID: <20240619085322.66716-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619085322.66716-1-angelogioacchino.delregno@collabora.com>
References: <20240619085322.66716-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8188 sys clocks embed a reset controller: add #reset-cells
to the binding to allow using resets.

Fixes: 1086a5310f9c ("dt-bindings: clock: mediatek: Add new MT8188 clock")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/clock/mediatek,mt8188-sys-clock.yaml   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8188-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8188-sys-clock.yaml
index 4cf8d3af9803..db13d51a4903 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8188-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8188-sys-clock.yaml
@@ -39,6 +39,9 @@ properties:
   '#clock-cells':
     const: 1
 
+  '#reset-cells':
+    const: 1
+
 required:
   - compatible
   - reg
-- 
2.45.2


