Return-Path: <linux-kernel+bounces-198453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 928F98D78CA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 00:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 287CCB20EAC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 22:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC30770E6;
	Sun,  2 Jun 2024 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="Wgv3/K+N"
Received: from shout12.mail.de (shout12.mail.de [62.201.172.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAB9374C4;
	Sun,  2 Jun 2024 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717366826; cv=none; b=jeuWozunod6osJ0y4ZjsA0psekR6VymCcsklwTom25rqX2u0hHcxWUeAKb0b5+cdCiMCCmWODmwlIxIwqdb+mXeurzFsdUCd8KX8TCBH5jMrIjDwKk1Bi7LF6zxqGubiPLegdqVqDxXHB2ubTxE0Lp8+1dfUyqI+fPXanfF0E6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717366826; c=relaxed/simple;
	bh=0PpPfOnAV9dATDb1aHsLlHM/c47rHUIRIb9Xva8BQM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhYVz7Y6S9cBt0Nmw0+zzUl4eYazqgfwF4C9gDWUsDBZJAlbuP10PAuJUOoOG1hJZvrvvxLLrO8+qy3j+gyXHSXC1oVnZr5dGiuB5mNNdx6m+zhn+wIRtw2DcNCLMLWfOR0terVMid0KQNqOeQkY760X+cp4GOt57rE9hUhNEPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=Wgv3/K+N; arc=none smtp.client-ip=62.201.172.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from shout01.mail.de (unknown [10.0.120.221])
	by shout12.mail.de (Postfix) with ESMTPS id 3DAFE240AD8;
	Mon,  3 Jun 2024 00:20:23 +0200 (CEST)
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
	by shout01.mail.de (Postfix) with ESMTP id 131B1240B53;
	Mon,  3 Jun 2024 00:20:23 +0200 (CEST)
Received: from smtp01.mail.de (smtp04.bt.mail.de [10.0.121.214])
	by postfix02.mail.de (Postfix) with ESMTP id DF7CDA03C4;
	Mon,  3 Jun 2024 00:20:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1717366822;
	bh=0PpPfOnAV9dATDb1aHsLlHM/c47rHUIRIb9Xva8BQM8=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
	b=Wgv3/K+N2SJ/BixD9oLK5+SRzYFf1/rkJEIfUmAQawIVwbiBBsTPdcT5bVsTFDBFF
	 uIC06QYIBfnYHrOXQGNEEE0jDSA6E37GfsaJ1Gjie589N/ammTgsSX+32phwfNRvTi
	 sGqBx/1BHvdlRElXujJyMW1bBO2Gfxu66/CXHb8xw/zm+hday76083ihUBxeEbkHKd
	 sfBrkiJWjn4tfYVexGDybyT+YVWVEy7d129wmVM+V5FkUH/THaWLkmYs7Xiao1sNDp
	 ocJxe+Ed35ArE+Et6Cr/fKnD6zYoaCyHnyT4XjGA0Gnc7H98BJHPQ+gdzfVuCrVJJ0
	 1o1WylOpdzQeQ==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id C579B240099;
	Mon,  3 Jun 2024 00:20:21 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Dragan Simic <dsimic@manjaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sebastian Kropatsch <seb-dev@web.de>
Subject: [PATCH v2 1/2] dt-bindings: arm: rockchip: Add FriendlyElec CM3588 NAS
Date: Sun,  2 Jun 2024 22:20:40 +0200
Message-ID: <20240602202132.2012-1-seb-dev@mail.de>
In-Reply-To: <20240602211901.237769-1-seb-dev@mail.de>
References: <20240602211901.237769-1-seb-dev@mail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 1422
X-purgate-ID: 154282::1717366822-B4FEA338-D6DC935A/0/0

From: Sebastian Kropatsch <seb-dev@web.de>

Add devicetree bindings for the FriendlyElec CM3588 NAS board.

The CM3588 NAS by FriendlyElec pairs the CM3588 compute module, based on
the Rockchip RK3588 SoC, with the CM3588 NAS Kit carrier board.

Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
---

The format (const for the SoM + enum with one entry with the baseboard)
was suggested by Heiko.
I did not collect "Acked-by: Krzysztof" since the diff changed. Please
have a look at this new change.


Changes in v2 (this patch):
- split devicetree into two (SoM and baseboard)

---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index e04c213a0dee..2b8aff11fc73 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -248,6 +248,13 @@ properties:
           - const: friendlyarm,nanopc-t6
           - const: rockchip,rk3588
 
+      - description: FriendlyElec CM3588-based boards
+        items:
+          - enum:
+              - friendlyarm,cm3588-nas
+          - const: friendlyarm,cm3588
+          - const: rockchip,rk3588
+
       - description: GameForce Chi
         items:
           - const: gameforce,chi
-- 
2.43.0


