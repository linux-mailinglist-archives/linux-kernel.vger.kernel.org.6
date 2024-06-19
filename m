Return-Path: <linux-kernel+bounces-220732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161CF90E661
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACBB1C20A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC5680038;
	Wed, 19 Jun 2024 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nMDm5Lng"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDBE80025;
	Wed, 19 Jun 2024 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787215; cv=none; b=iejm8uk1rq8sm4NtUfvWYtCbOHGAv8zGPN/L5qje92CQeLDTtmOaZkVsoj9C86q09pXasmyBofVFFPv73dwWDlgD2ydKsuvh5bgPG9AJ2kk2DZI0SfPWXnsv6tlG/DW47P0hLy6XgUirFk1rKka8WTlZKCBOZwEYuHQN9sUFo1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787215; c=relaxed/simple;
	bh=IuOjjnE7/JrOSwZhq2h99WsYClEcZOw4C24NtZSA/0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xjp7zcsKE7PAO3cfCrV6+zOuP0qRozOplXWTI83SzpIrGSNnGC6+v2UEepTGgbrMQzX1jziR3q8Xa6xc0/PP2Ug9wYc9y1w83wsdFx+fcBceWfw7KmvoI5iT7Km72CoBv6xX1gUL2h8hLv0zp2yNR2XEpSIc/EzLr8Vyb1QzMZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nMDm5Lng; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718787212;
	bh=IuOjjnE7/JrOSwZhq2h99WsYClEcZOw4C24NtZSA/0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nMDm5Lng3xQg3UXdS7i794m5nt2CTE76H5thEstpbtBboh3nQsktGx3HUKU/7eD6u
	 cDmBHP/bAD32qrGFhH0yrfQBKb6GoXaa9bcfzmYM80fJ0Z60RiDdwkzSv/5cRTKCcz
	 AwWd8ExsaTWcxLPJ13oDD7Br/2Xuc1MtdXTPW9pV1i3D+wTeMluBhUmg4DM5XXwEjB
	 e3/+L1F5ds/NI6jAfIB18hsaIfj2tttiza6OhyY3Izoml6sEPvIhwEPUsKTvtR+22g
	 dcJiOPArMDG4OPgIgn1Ls51YpiirbOZcwdYWJV9atkGuZjJC83AJLcG7vED39iKzOm
	 JasMKkPNGRJbw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E6B7237821C0;
	Wed, 19 Jun 2024 08:53:30 +0000 (UTC)
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
Subject: [PATCH 3/3] dt-bindings: mailbox: mediatek: Avoid clock-names on MT8188 GCE
Date: Wed, 19 Jun 2024 10:53:22 +0200
Message-ID: <20240619085322.66716-3-angelogioacchino.delregno@collabora.com>
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

Add mediatek,mt8188-gce to the list of compatibles for which the
clock-names property is not required.

Fixes: f2b53c295620 ("dt-bindings: mailbox: mediatek,gce-mailbox: add mt8188 compatible name")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml     | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
index cef9d7601398..55d4c34aa4b4 100644
--- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
@@ -62,7 +62,9 @@ allOf:
         properties:
           compatible:
             contains:
-              const: mediatek,mt8195-gce
+              enum:
+                - mediatek,mt8188-gce
+                - mediatek,mt8195-gce
     then:
       required:
         - clock-names
-- 
2.45.2


