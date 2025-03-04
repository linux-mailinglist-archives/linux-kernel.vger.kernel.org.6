Return-Path: <linux-kernel+bounces-545700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F381A4F062
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC5F188D1C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3A827CCC2;
	Tue,  4 Mar 2025 22:25:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B016278154;
	Tue,  4 Mar 2025 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741127151; cv=none; b=r63Pr6K36+r10eLmvq7YtJJUdDmwq7bT9i8X1R+gr5FumOFXpB39e4dSq0GM2tfpppxjGGeYguWCahN/CiV78kskp3FLXrlwSQBYdMyyRKCeg5kOaRfVpL/S0XPSC1TmQg34Z37apAQk/u+EOhG5qo5s5o2+UOuS7vZRH7UuDKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741127151; c=relaxed/simple;
	bh=+9BrNfN/II5WogLvKDzRyNR4sx+4VqrZ9EQTEmtqMUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7t9x/906sEseGBrrfILLU4ta+g9YRMlHOSDUnGUhSMAM35+J0rLuQggti5dmIDp/PVb1QMAu2ogUQjqnlGXCA4hVVyQu8V0rAq9Fn+kL5+5OPOlfZh2jGNyzQ7+E3NqpykyqQNo5dXsqcgTkjh5JiNYVqWAA0XsZsksC2NorMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 421051D31;
	Tue,  4 Mar 2025 14:26:02 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EA863F5A1;
	Tue,  4 Mar 2025 14:25:47 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/15] dt-bindings: irq: sun7i-nmi: document the Allwinner A523 NMI controller
Date: Tue,  4 Mar 2025 22:22:59 +0000
Message-ID: <20250304222309.29385-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250304222309.29385-1-andre.przywara@arm.com>
References: <20250304222309.29385-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner A523 SoC contains an NMI controller very close to the one
used in the recent Allwinner SoCs, but it adds another bit that needs to
be toggled to actually deliver the IRQs. Sigh.

Add the A523 specific name to the list of allowed compatible strings.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
index f49b43f45f3d9..06e3621a8c06c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
@@ -26,6 +26,7 @@ properties:
         deprecated: true
       - const: allwinner,sun7i-a20-sc-nmi
       - const: allwinner,sun9i-a80-nmi
+      - const: allwinner,sun55i-a523-nmi
       - items:
           - enum:
               - allwinner,sun8i-v3s-nmi
-- 
2.46.3


