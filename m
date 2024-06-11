Return-Path: <linux-kernel+bounces-209532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D59903742
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6403B30332
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79473176AD5;
	Tue, 11 Jun 2024 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1T+zp0TU"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B26175573;
	Tue, 11 Jun 2024 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096171; cv=none; b=iQD6M8ftBl1DuxcUPT472Sx7j83NfStb5RXhaBkyXfKvE4fMVqnbDfKxF0cuWyMK2fxN6z2RYsrc53wFgqi7WpR8VrYHrrlNelo2W4R19DOtY5E5sRf4c3a/FHEEs0Id6OnV9awzOLESmRdDnNwWfHgBjjylcRqKPgbueHwI4qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096171; c=relaxed/simple;
	bh=twG15UdjWXRB0IFFj6bI1+cRICgjEaOW//2cOBbp4BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3/bSaJDP1k0yo2Xq75cDJCml2bmauIXcIWKMVqOPpzxdHxY9KIQDIBBEVpjpOkbnQ8EKclShFV2WD+ojrLxLFZnaXfLkdSC/Nshlqm6GXYYgSDs0i4+AifVhYawiDJ13F1Wc8fna8srTxehjXBjW0CAT8SYybDQDFrkmZgTm6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1T+zp0TU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718096168;
	bh=twG15UdjWXRB0IFFj6bI1+cRICgjEaOW//2cOBbp4BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1T+zp0TU9AD5jSP+4g31G7oBmmeksfl1anVMrptEDBrSnE6WjYhcPR608yehrm0am
	 eIDp5pk3KEFIpMdA+EU0TutknCpJoZMcVfSOC7B3Z2gFetgBWfwrdJN6T4w25Vy2F/
	 rHoa02qyVICck3L8FNZ3uOA63S/kphyNMTIUtbgJ/XAvDXQhxIEk/k5X1T7cx1s1Pi
	 pqHc09m9QVx5InSgrKWzseJDUTkeh62MCpxdfg1p6O7i4jGCLonTA42Jnaf4HOOkfH
	 UWptsFqKmMH0sNRQa0NHYlnb4rwUo/15f2hNeW0YEl/gjPZLxO9CfJ/t0ssmbTkTSK
	 A4Pdxe/TxYEFA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C7DF237811D1;
	Tue, 11 Jun 2024 08:56:06 +0000 (UTC)
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
	linux-mediatek@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v3 1/2] dt-bindings: gpu: mali-bifrost: Add compatible for MT8188 SoC
Date: Tue, 11 Jun 2024 10:56:01 +0200
Message-ID: <20240611085602.491324-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611085602.491324-1-angelogioacchino.delregno@collabora.com>
References: <20240611085602.491324-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible for the MediaTek MT8188 SoC, with an integrated
ARM Mali G57 MC3 (Valhall-JM) GPU.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index e796a1ff8c82..278399adc550 100644
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
2.45.2


