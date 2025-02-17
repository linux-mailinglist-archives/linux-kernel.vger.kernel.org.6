Return-Path: <linux-kernel+bounces-518077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4C2A3898D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADF81891E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048D72248B2;
	Mon, 17 Feb 2025 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QpvRt917"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39D31531DC;
	Mon, 17 Feb 2025 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810428; cv=none; b=odHCyBUW4nmVdCQTuXyy71Y2epWYDnQJdYjM4zmLf/gr8fwEDPf/5b9KfA01qQ6qi9vCWmSYIm1Wx/+5Ag2BULQwC0uDm6O/Xha8Z/qEquJrl3Smk9ZGie9nXSXMk+HHmBJslgu8QRDYv41dO4upjeIYVCp+IYeBuVKTj3bcmG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810428; c=relaxed/simple;
	bh=ZO0lUUOVRwRafqNoWetQgISwi5s0VD7UwZ87lSrTg34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AY3ySS4MLQwH+fn10nL+rLeZxPcT09wryllC5LNGHKwtOixY4RbPmxjm2ZqoJSvjqYjNZZke4razg1PAeji4D5GaA6Ft7LRHhBcI3IObULIHxsJWqAPtZljxxTwR6wKN0YSVCfUJYZ1vsPz6VtggjVA5RKLSYjab1Ed1nZfQCpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QpvRt917; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739810424;
	bh=ZO0lUUOVRwRafqNoWetQgISwi5s0VD7UwZ87lSrTg34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QpvRt9174RSz/2WWS1HtWCfx5iYmw5FRak+kNoAEF362fAiJ6IxTVOSqegB9jswsK
	 mqg/jOTL4wbDF4KTAvuRetacBZskgloEvDttfxmYyG1gdJt2ifGYLpXXhWzM2fqQjB
	 X8Q5RKt6gzbmrJ8Ztp2R5fgBeP4MeDofRA0hPt7Iy5RdiCss9tKsDIercTIN7gZsC7
	 ksCB/CCS0GSle0j1PV1GIgKLdaOEln17b3VeeLQw6M6Wh8GnW4Cs39AcH0ng+zBGTC
	 1SghL+Dzg10+nBSJGMiw4j5G1IQZnaErno/Z5kk36dEWpkVb1/CKRXa0fkVLp3illb
	 8k7JowKHBQkKA==
Received: from earth.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AE1A717E155A;
	Mon, 17 Feb 2025 17:40:19 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chris Morgan <macromorgan@hotmail.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Tim Lunn <tim@feathertop.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Stephen Chen <stephen@radxa.com>,
	Elon Zhang <zhangzj@rock-chips.com>,
	Alexey Charkov <alchark@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: arm: rockchip: Add Radxa ROCK 4D board
Date: Mon, 17 Feb 2025 11:34:30 -0500
Message-ID: <20250217164009.130286-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217164009.130286-1-detlev.casanova@collabora.com>
References: <20250217164009.130286-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The board is based on the Rockchip rk3576 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 522a6f0450eae..9ddb20890627f 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -862,6 +862,11 @@ properties:
           - const: radxa,rock-4c-plus
           - const: rockchip,rk3399
 
+      - description: Radxa ROCK 4D
+        items:
+          - const: radxa,rock-4d
+          - const: rockchip,rk3576
+
       - description: Radxa ROCK 4SE
         items:
           - const: radxa,rock-4se
-- 
2.48.1


