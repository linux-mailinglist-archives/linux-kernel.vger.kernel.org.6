Return-Path: <linux-kernel+bounces-190315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CB28CFCC8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8666B210D6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F1113A405;
	Mon, 27 May 2024 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pZlgJ/9n"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F11139D1A;
	Mon, 27 May 2024 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801921; cv=none; b=N+fCjGtHrJqamWJchSHsLwok3Lm4kzfLguTk7EBTqSwtBYpvLbX6N38Ib5hIYUyV5k7LFpkZG6LhIrpll7QEX0cDSkFkSYJhjds3xnydifywSC4bNrY5DkJ7ymWhBgFF+sN6WyfkJA1VT06FMwNB1KA4C02Byp+aS6+wSi9USf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801921; c=relaxed/simple;
	bh=XVR8YE9RRnYslpsTdox8CwVpumNgWPDF20WRxi9WmE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRRaH9gEmVE4SUQDa8pWOFjbcQ3FiAFeXZiEthsoxypNS3rjs3hV5fAsCKJGbEJP0LiUmsLgLnb5RiGP2zS6tMPgOzBlNzSYkmA5+fNO74A0gEdxhaYU5LEETWKIoB5klRjMiIe/t/oumetU2QGZJmC3zvyX59odb7G53m5ueeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pZlgJ/9n; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716801918;
	bh=XVR8YE9RRnYslpsTdox8CwVpumNgWPDF20WRxi9WmE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pZlgJ/9niwuZBXq9izGjUJTRI02i7jPQr1VbcQ6162TC+c3yqrx33tF7o1BOcBRH0
	 WjhrB3O39bRjZvjQjNA4bamPKF17UqZOs/n6TMARxigfdZsBUwlOmuNGaV76HeDUSU
	 P5E/VFSlat0O45CjUvfSV3dxLBQXtoWNKTsRuZgpPp+lkxOYlDIllbjvaQ21IPezMq
	 ojfTXeyNXiaTN27t5uQRh2s7zndRQFYClHfyAGkgw21i4zgeW2P2BXR0dcMgYPXHpK
	 xe/85nhHetEUIK0WgapR6zhd/tFi825YGnuybMgJYOheVhbZ3911cNiPUT8fdJQ/Do
	 TDq4ARw/0I0zA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 089153782113;
	Mon, 27 May 2024 09:25:16 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: boris.brezillon@collabora.com
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	steven.price@arm.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: gpu: mali-bifrost: Add compatible for MT8188 SoC
Date: Mon, 27 May 2024 11:25:12 +0200
Message-ID: <20240527092513.91385-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527092513.91385-1-angelogioacchino.delregno@collabora.com>
References: <20240527092513.91385-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible for the MediaTek MT8188 SoC, with an integrated
ARM Mali G57 MC3 (Valhall-JM) GPU.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index e796a1ff8c82..4cf676190ae8 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -34,6 +34,7 @@ properties:
           - const: arm,mali-valhall-jm # Mali Valhall GPU model/revision is fully discoverable
       - items:
           - enum:
+              - mediatek,mt8188-mali
               - mediatek,mt8192-mali
           - const: arm,mali-valhall-jm # Mali Valhall GPU model/revision is fully discoverable
 
-- 
2.45.1


