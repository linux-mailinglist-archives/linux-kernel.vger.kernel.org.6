Return-Path: <linux-kernel+bounces-519811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE9FA3A233
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72DCC188704C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0E326E64A;
	Tue, 18 Feb 2025 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XJy9PO6u"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5EB26E16D;
	Tue, 18 Feb 2025 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894848; cv=none; b=hgT0ZHDefW2hPbJB8y4kxTn2CzeiDsR+QdYMmCvcGDzDHOsg7q9zH9gYs+J0P3WfPkqcHmAt5XBbUHiULA3Y1IGquEQPCEt8xfmYIWuYmaVnQbu2jbq4TeS3md6Mq8qTY8Q8QIc4vWfmWr86s5/2hmDASerTwtKAVBwPioaH0qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894848; c=relaxed/simple;
	bh=ZO0lUUOVRwRafqNoWetQgISwi5s0VD7UwZ87lSrTg34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNmHKkKjrl+NpeI7Oxk7vw1FcTNw/c2kzDuQ3kKk4TzrRRdsmSqzBMqmm423jW2clk76oI589Ssck1fj4Rxcl1KFUEFRvYYwi9oYOX4KZ1rGsul9XGo0xnO2o5fd+FyKPFSNd3aMb/uaGR7M7ipTKms/znwdRvkWh9vOYRc+xCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XJy9PO6u; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739894845;
	bh=ZO0lUUOVRwRafqNoWetQgISwi5s0VD7UwZ87lSrTg34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XJy9PO6udy88MzzypCBFe7Tn0YyH7CjsxUwa5DLaQfjhsrV5+SLvIEbb5ZERnGedd
	 ewzY1fIvN86U8IxWup4VL91EjMI0oqhhQSH9NGG8wMSdDAlOzd5UtVt1eJuqh3Sg1X
	 SG7xM8PGJh23FRWcrsipcNyzQ949lGWXJ0WMePEMaRcAAGJbAmqKaQgbyWZgdYoSu2
	 SbNZz6pwNQksIkT0O6FfGlvPpatT43NpiUb0JDZmUiVLGNvtd075chRlQJuqS7lhia
	 2LZAlaPgm8bCGvIrp04NSXh7wIY+jDtQNlSqaZZnRTSzBB1ZNXuoPu1QM8OjXML4ZO
	 T1IqkFftRMcbw==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 87AE117E1411;
	Tue, 18 Feb 2025 17:07:22 +0100 (CET)
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
	Michael Riesch <michael.riesch@wolfvision.net>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Alexey Charkov <alchark@gmail.com>,
	Stephen Chen <stephen@radxa.com>,
	Elon Zhang <zhangzj@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: arm: rockchip: Add Radxa ROCK 4D board
Date: Tue, 18 Feb 2025 11:04:18 -0500
Message-ID: <20250218160714.140709-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218160714.140709-1-detlev.casanova@collabora.com>
References: <20250218160714.140709-1-detlev.casanova@collabora.com>
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


