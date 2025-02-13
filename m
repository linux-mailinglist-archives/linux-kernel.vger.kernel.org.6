Return-Path: <linux-kernel+bounces-513235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 894C2A34588
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004BE189969D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352BB200B89;
	Thu, 13 Feb 2025 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lOE83DM1"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D858C1FF5F7;
	Thu, 13 Feb 2025 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458788; cv=none; b=C/AinTZrdePO7C5g+P36eftVZyZRF8d702mbGwAXgoOwCg31Zd50W8iO2Dyc3x3xBKIsYDleOOIrexUaCoXUtyNxbL/tzeIWFAGhPd/UyWnnQckC+3d1PwpBqWebQPAFU4trqL6n30BsjGwRyWABRk/jci0NRrIyidaFTBDIpOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458788; c=relaxed/simple;
	bh=Mh/H6vQ6A1hrURy8whbQOLd0UQiv3ywbjr/FbGu1Dl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvU3Y8ObCZ1Gf7TTX/ykKGWBFPlc4fevq0EKcAwGsdAOwtqkvgzjfHsDRVB5ZYIBTf3FFegr9T9gzVECfRPT0cyVddx8dYb36c/8JxVTCaSAAb5tX8a7H534IkT9p+9ICJnIN0iPW3Zr2JTqgsxTubgZpHWfnNeMjXBKdUe5GUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lOE83DM1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739458785;
	bh=Mh/H6vQ6A1hrURy8whbQOLd0UQiv3ywbjr/FbGu1Dl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lOE83DM1Rcs8YdJsFqk4qL57kFELrRb9e5OCj354qcjnKANYO9f194cfqHPZxHPQB
	 TeKRkANuFRgWu30YOxGwRHYq1XznwOFnyPQKegml7a2OtsXNFK2pUS7DQpb+6XSblc
	 cJDcYVy+g+CJjU4o4foTxm0F7q20FmoG+hAMnbJVsf20uNT2ULcyCXqx6oIKkVWxm/
	 +bOMeNPbK0b/Uhmh6e7YLniM7ZN6rO3feGFiFXGJkHYVrFxjP6PhvRW44M3B0GOZZV
	 zpR1j7DpNemDDN8Dft1s6UPy41mGay6allNkE6mTTUYkuZzAGp7FksoeL10omi7RDj
	 abdo9KV7wzqNg==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5428F17E0860;
	Thu, 13 Feb 2025 15:59:42 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chris Morgan <macromorgan@hotmail.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Tim Lunn <tim@feathertop.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Weizhao Ouyang <weizhao.ouyang@arm.com>,
	Elon Zhang <zhangzj@rock-chips.com>,
	Alexey Charkov <alchark@gmail.com>,
	Stephen Chen <stephen@radxa.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 1/2] dt-bindings: arm: rockchip: Add Radxa ROCK 4D board
Date: Thu, 13 Feb 2025 09:57:15 -0500
Message-ID: <20250213145921.133412-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213145921.133412-1-detlev.casanova@collabora.com>
References: <20250213145921.133412-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The board is based on the Rockchip rk3576 SoC.

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


