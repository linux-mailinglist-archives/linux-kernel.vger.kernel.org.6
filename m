Return-Path: <linux-kernel+bounces-510861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC78BA322F8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5343A415C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D862066F2;
	Wed, 12 Feb 2025 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XCrhbX9J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E48D207E12;
	Wed, 12 Feb 2025 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354271; cv=none; b=WLk7p7MX31fERwoJZK3oGaIgw53J7JRiBs18GQ9dXRlV5zhBQqNiUbD8PqTObfdbw0NN4DW7CI6hDNnyAOWXux41BrUrBp3waUjkZBKLMc13m3e9ULXdfu1KVcLaMknv33T/yZMELW/j3YDeo0u2lanFkBsRcaj3qY8o73K1uzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354271; c=relaxed/simple;
	bh=s4ttT1g36Eo0E0CZt2OBpnwxJIufA2Xwc1ViQTNB6k0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R5T0owO0q8MLXLFoaCfVrSSpGfqblmmDmxEXPqAkSbsGjEI+GB8pRvhWJFh7IZce+cxpkPZdPeGMFhuRSEQBlBxQ6LASMpFYxDn8uQbTRvhYg/4tTs4uPffsCnCEjUCcl1urh7/brHXBXKFnAoF6KUjNruyUJeA0ol7wTr0MpIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XCrhbX9J; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739354270; x=1770890270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s4ttT1g36Eo0E0CZt2OBpnwxJIufA2Xwc1ViQTNB6k0=;
  b=XCrhbX9J6OXWZfsNmQxEFT74zYVJQ0UTMizgeP4GqjjssXX9oB/Uq/ER
   vOLWvypjioO2TF3HnRtksQ/+EQ3XTxT63qsfTC5jWHnPxBpiTG71BEnOJ
   NnkxgSEteQQ/pNDVdE3SV1x1HWtBKbZq63IzXA4GmfEBeYR1f67pQf8fC
   15pp0ivOy0pZeNa7Y2yNhFdBHt1GWoRoH9wz042C8cn5qT57NvgcU4Kd5
   zB0B52ib2iCkwDUUoz6lhIIhN79SIwzuUBIdVI6FSvnuQPH30hRRnupoG
   5kGrQDZfC8A3VfHMfmqkcUC8wCu1yio4XRc6pvGKAi6FeGK6abipx0iza
   Q==;
X-CSE-ConnectionGUID: 8FsJjVZfSFaktjbJgCjVeA==
X-CSE-MsgGUID: kgllqEFeQBijf+OiaawU6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50224544"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="50224544"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 01:57:49 -0800
X-CSE-ConnectionGUID: d6lM/Aq+S02j0iwgU2XENg==
X-CSE-MsgGUID: fxGvHBrpR3ahXNpIjXMkrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112632051"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa010.jf.intel.com with ESMTP; 12 Feb 2025 01:57:45 -0800
From: niravkumar.l.rabara@intel.com
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	nirav.rabara@altera.com,
	devicetree@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: mtd: cadence: document required clock-names
Date: Wed, 12 Feb 2025 17:54:06 +0800
Message-Id: <20250212095407.2667743-2-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250212095407.2667743-1-niravkumar.l.rabara@intel.com>
References: <20250212095407.2667743-1-niravkumar.l.rabara@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

The clock-names property is required because the driver requests
the clock by name and not the index.
Update the example to use &clk instead of &nf_clk for the clocks
property to avoid confusion with the clock-names property "nf_clk".

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml b/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
index 0bed37a994c3..e1f4d7c35a88 100644
--- a/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
+++ b/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
@@ -33,6 +33,10 @@ properties:
   clocks:
     maxItems: 1
 
+  clock-names:
+    items:
+      - const: nf_clk
+
   dmas:
     maxItems: 1
 
@@ -51,6 +55,7 @@ required:
   - reg-names
   - interrupts
   - clocks
+  - clock-names
 
 unevaluatedProperties: false
 
@@ -66,7 +71,8 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
         interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
-        clocks = <&nf_clk>;
+        clocks = <&clk>;
+        clock-names = "nf_clk";
         cdns,board-delay-ps = <4830>;
 
         nand@0 {
-- 
2.25.1


