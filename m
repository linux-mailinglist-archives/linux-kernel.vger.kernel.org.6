Return-Path: <linux-kernel+bounces-515194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC8FA3617F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C0416A37C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF81267383;
	Fri, 14 Feb 2025 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fVp/E8Yz"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA06266B64;
	Fri, 14 Feb 2025 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546493; cv=none; b=Xavh3QuR4DxppgbTVbIX3VhRWiztnEIlJGzRSfVHLUCigCLcQrc5UdyXlUxzibju+JIpK94cfbUkhKunPteg1xomB2BYYlGURhtJVwgwCjRRe4Vp83Zd82dpZPpOwopLsWoS2/VmJzVuAquHukI1whGDvF8507fkUakhwZgZhCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546493; c=relaxed/simple;
	bh=3QtZFaY0HrQ2qIf35atRwXoQaAvu1LVwT8pVaLegjcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyvd+K3t1S5512k+Dbujqhlk3elug1vr+oPmrcSGKZCxfXixqMrFAC6bE6GWkPIjeIC3aEcCJOADd6v9HDyZiFGHJGrSW5t+CpQhdHcO/kz9IabmW6Y76tO6NLnEVMEteocTW75T2A9KjeywDTM7A28qGeQgnyEtNKMl0dqJ/o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fVp/E8Yz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739546489;
	bh=3QtZFaY0HrQ2qIf35atRwXoQaAvu1LVwT8pVaLegjcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fVp/E8YzLBUFCR0Mk1PHogxobf75P0Z11CQ0tPD4agBViSuqQ36z+FvUtaA6G5B7u
	 6ti/aOKX6bYxLpMrOeV110vpsd7RGPGFmBmh5T3JaUbOrl5CcsH6zyUVGawKDR6pJr
	 ye0MSXNpcNdzqVqAoNXSDSCKojJRZffB3dQXpWHjIU0XnCjemmZ+R1djDe/QjugWj3
	 sj8bCcyIy+iP/U5Z1y9daWowU6WKZzwYjjWmzfs5X65syZWTwKoNdHCUPL2x1RAJ7/
	 hUTCTCdbCj5jrd+NkjNRPoMmuwvAqJHiWMGn6+iR81jHvBJMcS7x0PXO/0hkydwRZM
	 FseGrdYiR2S7w==
Received: from earth.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6B81B17E0F8B;
	Fri, 14 Feb 2025 16:21:27 +0100 (CET)
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
Subject: [PATCH v3 1/2] dt-bindings: arm: rockchip: Add Radxa ROCK 4D board
Date: Fri, 14 Feb 2025 10:19:33 -0500
Message-ID: <20250214152119.405803-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214152119.405803-1-detlev.casanova@collabora.com>
References: <20250214152119.405803-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The board is based on the Rockchip rk3576 SoC.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


