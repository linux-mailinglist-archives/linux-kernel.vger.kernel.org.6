Return-Path: <linux-kernel+bounces-574091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26221A6E07C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A44116BE87
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E98C2641DE;
	Mon, 24 Mar 2025 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qhcWTwB7"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4DD263F44;
	Mon, 24 Mar 2025 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835866; cv=none; b=ferCkpy/BnEk/PkGiX7g6e/k7SzcriipQpCc0OuP5qXvFg+A8IW9X1tQ7dm5Sxi9YGCI11OUqbZkSrSQWkkz0+bREFRmVRGl223dva7EvEzTTK2zmOqzBuP6Pfa4qrI80uNNEz4QG2yqZlA3BHd+50h57fHr4OCwCGKFm4brI/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835866; c=relaxed/simple;
	bh=KRP0aB0pusR6DQBo1puDDmnz/hEZTuxKlnUQvRPL9e4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hWXEOL3QrHuV5lIquOZsM2lvVvapcIUhUuzLkMGvp7lOOlLnYOd9HtV3UsrL6Xupwm7wHiuHQsGk8mDVZA4nErkqzzpOw+/3V3q3+XGb8EO6DkiLljFNe0pBQEFk1aTwGQkobvyyLDuo1S81Ald2sS5N4qQGMUZIi3Gct3i2lOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qhcWTwB7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742835863;
	bh=KRP0aB0pusR6DQBo1puDDmnz/hEZTuxKlnUQvRPL9e4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qhcWTwB7Lw72A+2me8o8c+bw2ezh2TtX0zW8WGnP9szUu5+aLPcX9tYZxld1GLQFs
	 BjzN/BHtK61M1mmOQOxR5TO0UmjaZFLR1Nww5xDHv2tWuG1/a6MXqsSfn7MXBznc1v
	 GrCI2AIptqKFlw5ZZGtzN3JVEBfyuheZ+kRZwQq+1Hihm3EUq/4klWGwPKxgLOfhGy
	 qpTAG5oaTRNXEJsIdcGLRW/9aY76TShdiLJAIOH52q5iKoFyIgD209XDOGAPcplAqb
	 RoAeTqq2p+KLV5UfK2moqcLLu41THZrQnyoGKF5z59wvVjFtdgKZf2tB0ysSdiKWWG
	 ioYwN8i+VCdyg==
Received: from jupiter.universe (dyndsl-091-248-188-184.ewe-ip-backbone.de [91.248.188.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1DA8F17E0C37;
	Mon, 24 Mar 2025 18:04:23 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id D89FE480038; Mon, 24 Mar 2025 18:04:22 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 24 Mar 2025 18:04:24 +0100
Subject: [PATCH 3/5] dt-bindings: arm: rockchip: Add Radxa ROCK 5B+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-rock5bp-for-upstream-v1-3-6217edf15b19@kernel.org>
References: <20250324-rock5bp-for-upstream-v1-0-6217edf15b19@kernel.org>
In-Reply-To: <20250324-rock5bp-for-upstream-v1-0-6217edf15b19@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=917; i=sre@kernel.org;
 h=from:subject:message-id; bh=KRP0aB0pusR6DQBo1puDDmnz/hEZTuxKlnUQvRPL9e4=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGfhkJa5ha6/bzlUoT/H5amcvXsgWlJstfOTA
 B+/e6TTdOYmjokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJn4ZCWAAoJENju1/PI
 O/qar/wQAKYdC1NWfYRLSF+z7pSP/dBf3sqEwevqmFHlNLJkmXJeFa5NTxxfvuwcX4vGn+sozlj
 VvYxkIk1VRb7evsbngaO8LYLdGqt3EGfgcHZFAGvA3X+pldhP5zWragTrkYA1Br2DGC0s/8I+xd
 8dc++0XPVS6XvCucWxGdslvFehTSx/rjPP64DcZ/5lSJHzlIg3s2Jx8CXE7q+EOUBPkAAikUAKz
 jX+QWwrgF9IkP0VEcsy8pEyjMMs2aXi9tbnJW0Ci41tz9usgDuL9DbzHgMvrtToPQ4d0kyOKz7A
 iAL/GEZfkoilnzWAsAJ0spIiA9hP3lPoPerxu9nacOOgX75iD/wAZ8Iz17gtpJM1oKaR53m2MYN
 OQaN7U44NjwImIENC92Ncq4NELtMCvd5UwKv/G8FATswloGw4t1ynWxM87ZWh4QOPmcIDjK8JWh
 synW/ILzuBKif1a0PljfrgMuWqmrZJa6brU/bJmBxnD9sPYp6jslK4FbAgYJiygxkGaerb8tWdd
 BQjQYXUdU4qwU0TW4zjXFt8Jwhq9fIFsvIB5Ei6GGPWPDDubDO7hseeiGGyK6ivqhXBIyOVyeau
 cLwWqkMLQqZTbKoZh+AfMvRyzefmxpoUPG1tv2hzywI2ScSNpa8xbOkVsIEpXSPsoU/VlTpAEDo
 YRbUI/YM0GswTPeSGsfsv+w==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

The Radxa ROCK 5B+ is an improved version of the ROCK 5B.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 650fb833d96ef67ea1bba33c0767777378a38fa7..fe1fe8fe52fa3594a0da8e0263cb46949436a021 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -946,6 +946,11 @@ properties:
           - const: radxa,rock-5b
           - const: rockchip,rk3588
 
+      - description: Radxa ROCK 5B+
+        items:
+          - const: radxa,rock-5b-plus
+          - const: rockchip,rk3588
+
       - description: Radxa ROCK 5C
         items:
           - const: radxa,rock-5c

-- 
2.47.2


