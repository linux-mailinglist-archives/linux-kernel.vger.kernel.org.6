Return-Path: <linux-kernel+bounces-368358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910299A0EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2BA41C214FC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF95B20FAAB;
	Wed, 16 Oct 2024 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mentallysanemainliners.org header.i=@mentallysanemainliners.org header.b="lcDDjGp1"
Received: from out-03.smtp.spacemail.com (out-03.smtp.spacemail.com [63.250.43.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB64209F3E;
	Wed, 16 Oct 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093701; cv=none; b=PcVH0DZFbmMw295d/YAQgNkrzX0At5ffILH53Xf+fc+70Can6PDZ6jgmmKj1r1OWQb8Z6RbOO8DdkCpKLZBGcEuka63MwkbW7GxApcmcg6WUKbvuSEOo5PgmdisPN3t87gHQ7d4U0wAGk6Rl1yF2iYjerEi9zKpzUyn5hBLeD5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093701; c=relaxed/simple;
	bh=i9CRyCmH1jmIrAYXtqp2Ol8Cit/CqxernI4YANbTw1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLtkCj9vOx1aQ/Hd9HW5l2u3n3RXVAGLKUBdZGF9fxK5KbgSq1DLO29MkYsn8YWDDSH0HLF5HxewlIcOBmNuKVM0IvRXDAR2lTcs+gd8DUOsA8aBuLsymaR55AIyjNzKJT+VC3lypsd4sqSkoWtagzOZHJQWcEhHdoJY0Vu+cJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=mentallysanemainliners.org header.i=@mentallysanemainliners.org header.b=lcDDjGp1; arc=none smtp.client-ip=63.250.43.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Received: from prod-lbout-phx.jellyfish.systems (unknown [198.177.122.3])
	by smtp.spacemail.com (Postfix) with ESMTPA id 4XTFjt2KHFzGpQ7;
	Wed, 16 Oct 2024 15:48:18 +0000 (UTC)
Received: from igor-systemproductname.lan (83.8.245.91.ipv4.supernova.orange.pl [83.8.245.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4XTFjk5kq8z8sWV;
	Wed, 16 Oct 2024 15:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=mentallysanemainliners.org; s=spacemail; t=1729093693;
	bh=i9CRyCmH1jmIrAYXtqp2Ol8Cit/CqxernI4YANbTw1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lcDDjGp1nogtyH9epICz7XgNWZqy8XF4V0mv/+L3H0Uepug7gHAl3x1vdo7OMsfrC
	 kG7Uk4Uo8G1I+Njfev4RFL7j5GsHIRhhUPnrKl7nQoNqeRBca9qI/zVKiYuJ80hCOD
	 f3hLWgknTvOZgLehgWLCFNApNiKxm5UHV/DTiEPRD6jIrQ2KdFEMRksFcd/yefJgYV
	 /XbzFbnJWZgnhXgbZEfZ2HIKhXFWx6O0H5cGtKVcRfeQcf5EPrxnSRaLOy/NZzq2cT
	 JjaSb6K84wAC8nEJTFF4IobMb3ATdYHThgVFoZocknYVnflE/RV1FSebz92ujrmwEZ
	 zE91y0Hp+wajA==
From: Igor Belwon <igor.belwon@mentallysanemainliners.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Igor Belwon <igor.belwon@mentallysanemainliners.org>
Subject: [PATCH v3 3/6] dt-bindings: arm: samsung: samsung-boards: Add bindings for Exynos 990 boards
Date: Wed, 16 Oct 2024 17:47:44 +0200
Message-ID: <20241016154747.64343-4-igor.belwon@mentallysanemainliners.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241016154747.64343-1-igor.belwon@mentallysanemainliners.org>
References: <20241016154747.64343-1-igor.belwon@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree bindings for Exynos 990 boards. Currently the Galaxy
Note20 5G (c1s).

Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
 .../devicetree/bindings/arm/samsung/samsung-boards.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index 49884a7ab5c6..d25a17e69725 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -230,6 +230,12 @@ properties:
               - samsung,dreamlte                # Samsung Galaxy S8 (SM-G950F)
           - const: samsung,exynos8895
 
+      - description: Exynos990 based boards
+        items:
+          - enum:
+              - samsung,c1s                     # Samsung Galaxy Note20 5G (SM-N981B)
+          - const: samsung,exynos990
+
       - description: Exynos Auto v9 based boards
         items:
           - enum:
-- 
2.45.2


