Return-Path: <linux-kernel+bounces-200617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5018FB272
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D8C8B26354
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D96914830E;
	Tue,  4 Jun 2024 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="sDL1xvTe"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007FE145358;
	Tue,  4 Jun 2024 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504770; cv=none; b=qxbNONbgPuMY+9U5lzyEDUytLuW6/MWiHxkCEcgp85YJ3/fQURlznpbrfwXfMK5fAmc+HsbSGl3mpwJxCK4M+MaZUiPGMTJvKFBoqJ/5iugWVDx09QOMT7ng8HFrH/gWcSFqI2RgKUGSdVKRbwdW2hoiHZjiIB/P6lctAfwZ4fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504770; c=relaxed/simple;
	bh=CpQdxsV8bHr08qgSs4fiUyuci8075LtVplEkoA/kEzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjOny8rLCVTAsZu/6EtBZ+n2OgWtKZAlktDUL3NGkyylYrH2zjwQCfLs+XkiSv+Xk4aq28aiuMkJvzU00oX4/gL8sOjlcgeFL1pyVmYD9SC/dERUIT7B48Ko5ee9VfeEBY6wKCOvJzEA929lzZ14sYp5TjHr5MCHBDDSZLmmF/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=sDL1xvTe; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717504767;
	bh=CpQdxsV8bHr08qgSs4fiUyuci8075LtVplEkoA/kEzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sDL1xvTeZR1ICVuDrYO4MuN3eVtUzy8Eq5zWP4h1GQQYEjvPxtV8NZflQIk3Rx60E
	 uZaKFEtuD6jMadkj+xgcqTdOekT4qvC/RbXNsk75XFOAbZbYzS9mxaHuXAQ4QjSyW5
	 7EIQI5zJ2HuzqaXW9iJqQCJ/VIdRpkwl198E7NfN6FrBo5QM76237nsPsR/lf0jIVb
	 p5R/c50axFNY6jXt4TPaQAHt4Yrfo1mbMOdoxIbi3Rkjd9tII+9Tmeb9zrTOJzsKIi
	 B1dRBNCVclTbyO73mJCD5qVCIHDbvtPc6OpSjvvFB42QKp5aegWFCGLuwKFzcp2na4
	 uTuIQgEFuUq1A==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3054837821F2;
	Tue,  4 Jun 2024 12:39:26 +0000 (UTC)
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
Subject: [PATCH v2 1/2] dt-bindings: gpu: mali-bifrost: Add compatible for MT8188 SoC
Date: Tue,  4 Jun 2024 14:39:21 +0200
Message-ID: <20240604123922.331469-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604123922.331469-1-angelogioacchino.delregno@collabora.com>
References: <20240604123922.331469-1-angelogioacchino.delregno@collabora.com>
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
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index e796a1ff8c82..8acb46adabe2 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -34,6 +34,7 @@ properties:
           - const: arm,mali-valhall-jm # Mali Valhall GPU model/revision is fully discoverable
       - items:
           - enum:
+              - mediatek,mt8188-mali
               - mediatek,mt8192-mali
           - const: arm,mali-valhall-jm # Mali Valhall GPU model/revision is fully discoverable
 
@@ -195,7 +196,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: mediatek,mt8183b-mali
+            enum:
+              - mediatek,mt8183b-mali
+              - mediatek,mt8188-mali
     then:
       properties:
         power-domains:
-- 
2.45.1


