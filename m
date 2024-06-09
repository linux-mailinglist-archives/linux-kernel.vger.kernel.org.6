Return-Path: <linux-kernel+bounces-207529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D8B901885
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 00:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C3D2812FE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 22:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD81558A0;
	Sun,  9 Jun 2024 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="V+25u3ST"
Received: from shout12.mail.de (shout12.mail.de [62.201.172.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82397446AB;
	Sun,  9 Jun 2024 22:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717972028; cv=none; b=AN7oNTVBLTCZM2xDBd8/cfr5WmnSpHEwLG03bl3z62ZqoZhCBeJ6R1Wy1ULgtzZ34MIoLMdkwr3z6CBgq2oHCEqjClob2dBHz47G8XYvugyJQojOWHYHwPI4/HCYsM1ChIcJgUfvgseeamS7wO3xUVo8Z4NIRouD+hTMqMg2Wdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717972028; c=relaxed/simple;
	bh=l2vdRBAbtE/p7Lk44UFPAG0xcSQFQjBbVrpUsAwztsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9yHmV0VAC4sHX1CDpY8ETv98uUtxbGBOY9oLDhdy7JbHSLKx/dCrWXrD4FBvkH1oJUjc/d3ktv2XFxNBYIQba+fKcAqOPfJ/q/UdMqgE2LCdZiCe4bKXziNkz/FtlmvsBY444yCILWvCEbaEhgU3xLgxVS4rfVJXma8Cd5z764=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=V+25u3ST; arc=none smtp.client-ip=62.201.172.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from shout02.mail.de (unknown [10.0.120.222])
	by shout12.mail.de (Postfix) with ESMTPS id 282C3240A4A;
	Mon, 10 Jun 2024 00:27:00 +0200 (CEST)
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
	by shout02.mail.de (Postfix) with ESMTP id 05FCE240B55;
	Mon, 10 Jun 2024 00:27:00 +0200 (CEST)
Received: from smtp01.mail.de (smtp02.bt.mail.de [10.0.121.212])
	by postfix02.mail.de (Postfix) with ESMTP id D1571A00E2;
	Mon, 10 Jun 2024 00:26:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1717972019;
	bh=l2vdRBAbtE/p7Lk44UFPAG0xcSQFQjBbVrpUsAwztsI=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
	b=V+25u3STtZZpuxc81J2Dk3FpXQJG7EmWeAPk0FhvfKf7VdaY/J0YYmZqmgwk1COAj
	 +pYchPvcer0iUkwujMX8qQm8WLxhlml4lyMduKj8R0mxmqWmlgl/WIaXK4DQDPg1cu
	 0+cmfrtyjTxmNyCqgNxyGoES3ULCN1VDflfM9O1S0FD7akAD5mu03vxYCNISUTBBm3
	 fd24CEvBn/fDYD/UdHxMlQIriTkPGlGEBNJsbWR8KvF52ZJuAwogkgHy2ltdtpui5W
	 tESlQ5Bl/ra8wWNzdqTAavKbxtOrvB+eAEgNV3Sn/Ua4NESnEXTaF1/8ieOfuTKaVu
	 a8bzqY2lqp/eQ==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id D4706240A46;
	Mon, 10 Jun 2024 00:26:58 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Space Meyer <me@the-space.agency>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: arm: rockchip: Add FriendlyElec CM3588 NAS
Date: Mon, 10 Jun 2024 00:20:16 +0200
Message-ID: <20240609222428.134977-2-seb-dev@mail.de>
In-Reply-To: <20240609222428.134977-1-seb-dev@mail.de>
References: <20240609222428.134977-1-seb-dev@mail.de>
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
X-purgate-size: 1146
X-purgate-ID: 154282::1717972019-FED2B878-08DBCF11/0/0

Add devicetree bindings for the FriendlyElec CM3588 NAS board.

The CM3588 NAS by FriendlyElec pairs the CM3588 compute module, based on
the Rockchip RK3588 SoC, with the CM3588 NAS Kit carrier board.

Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 77469270b271..eca0a42eb384 100644
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


