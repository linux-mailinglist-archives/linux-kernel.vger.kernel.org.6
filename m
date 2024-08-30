Return-Path: <linux-kernel+bounces-309450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CEE966AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894431F21D29
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29831C172C;
	Fri, 30 Aug 2024 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="G/P2JBMB"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF281BF7E5;
	Fri, 30 Aug 2024 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050319; cv=none; b=VKfhuNbQYvp9yE0TPvBzQ23ev45zpU56HmocedLpR48Zggb9xGJ7dD7t2BkmH6D2rWvd4F/3xy6INULNd11Y6mOZ4qHi7scYhxIhaQHwFsRG6fvYtn5p+L8vT5sik9jbRmN8t90Vmqe+/4ZS3quKYPRGlsBX2TTTcEprrHKj8vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050319; c=relaxed/simple;
	bh=ahXzD4vAJ8aNAdHeGAFeLGMOl9NsfJ3WUZt3j7BnC74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ox1Jc8/Rv9R9+gaXaDxUMRHPZ8XPpxXmSe/9i+ifeIh5ZPBDTbBx8dkyxbWHdEjRQtP9O46R2dR5kNcpOf7ueCtJpweP1KZ08B+8mQRIvxm/Ezz7yS2DCxpwsiuuTUmc9795JlJHj5I638DMcFdGX9zQ4Ijh2c5bPTgnE+aeNP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=G/P2JBMB; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Cve/jX2zAtDpvODGJR1P6htvkNqxysFCrhk+BT6Ib2c=; b=G/P2JBMBMxZ98lnknTZtZqnFrT
	55n4lNzdne2ig1jsP/WrHu43ppM2wQ/tTpDG9Uw8rJ0Pf7NWRWWKnc8UOgkfmpsDtSACnBpDSpo0m
	rbfpVfxuhZRctGTLvO4cMyrL8GhZijFIzuA2DrtmFSgNkDvUt8+xkGZHJ9QlHqC9CzldWyqWGGytP
	Z+kXrItkd1ckHJImL/z1BMmXjkhDPzKwYEjVYIOLJ4sCMlq/T9mdixmb+zhW8Qa+Acgs+WxYECXaY
	YFkO+mcZ6K1Ht5lRbGFZn6m+dX01GEvyb1MiRzcrYd7/xE8j45f5+BWn12p0/4U8T7feaVn5EwT4K
	bUboFwQQ==;
Received: from i5e861921.versanet.de ([94.134.25.33] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sk8OA-0006ey-Lz; Fri, 30 Aug 2024 22:38:34 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	marcin.juszkiewicz@linaro.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 2/3] ASoC: dt-bindings: realtek,rt5616: Document audio graph port
Date: Fri, 30 Aug 2024 22:38:18 +0200
Message-ID: <20240830203819.1972536-3-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830203819.1972536-1-heiko@sntech.de>
References: <20240830203819.1972536-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The codec can be used in conjunction with an audio-graph-card to provide
an endpoint for binding with the other side of the audio link.

Document the 'port' property that is used for this to prevent
dtbscheck errors like:

    rockchip/rk3588-nanopc-t6-lts.dtb: codec@1b: Unevaluated properties are not allowed ('port' was unexpected)
        from schema $id: http://devicetree.org/schemas/sound/realtek,rt5616.yaml#

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/sound/realtek,rt5616.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5616.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5616.yaml
index 754111f2e70a..29071044c66e 100644
--- a/Documentation/devicetree/bindings/sound/realtek,rt5616.yaml
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5616.yaml
@@ -38,6 +38,10 @@ properties:
     items:
       - const: mclk
 
+  port:
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg
-- 
2.43.0


