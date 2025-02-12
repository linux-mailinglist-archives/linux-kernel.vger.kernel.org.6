Return-Path: <linux-kernel+bounces-511040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 813F5A324FF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC4016A4CE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774EF20E01D;
	Wed, 12 Feb 2025 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjWqq/zH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D3520B1EE;
	Wed, 12 Feb 2025 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359757; cv=none; b=IIeP0LXrd2jie44xnZOAcj4KNAlIRWqD161K8wd4rA/Gh9VQThEAncQ8iAaCwx9S/3BPFuIIYxx6kF18uoBPM9RwuzkjAtCRANKJH9M2HS/2ioSaVZPIy09vz3OJToAkjCed2erzb9RauGwNb7BgAa9NbtNl4NbYKP/vOtWiOGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359757; c=relaxed/simple;
	bh=gux9UCdK4p0q+jE3IHrHjrU+Po2kg7wuDTli0jqGFLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Es+vPXrQQszy6fG0hY7qnpuSP8F1nGXiUUW18TmrpwIeAJfz0oiq6kKlB3jZ+wpc4eqPeU8eaUWiF/NzYpcf1INZCX+qk/baXtJXJpXMbRKgys7Jg902sD2KqHC+cJ3evc41InuS+tjt5NZqIa9iOpi8P8fWRzBpCmLjetPsiRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjWqq/zH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739359756; x=1770895756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gux9UCdK4p0q+jE3IHrHjrU+Po2kg7wuDTli0jqGFLw=;
  b=fjWqq/zH5KsCu/rtlyxVuvG5F50LzO8otmu3JIS0OblyXyEwROvRuMyB
   nRehfzNikVIaFPPH+USbMW1F3zxBGP28iViOsxOFuuMx/2MKqL2+LEL9L
   oHliepyurMBzbN2DnXm4zci7UPw/jDVeV/3MpsZz4MEaXZ2IawUyu9KZN
   7lsvu3Rtvj05em/3mZAP0eYkCONg1QDp2ccfTw14x33VjGRQazzcFi8Qc
   l+Q7s22JKu+x3KixA/EQS6LA1WuugT7Im72KT+4iUp4MRX9c9VOjI5Kxg
   JtEpheYiYi9f2AneXXVciPBjaDtH/4Lf9NER8C2mV+2Gsgz18cO8N+DDu
   A==;
X-CSE-ConnectionGUID: zZggF0yhQ5es2qqdywD4lA==
X-CSE-MsgGUID: YW+PRiZnRfWB7RYyI8Pirg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39895748"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39895748"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 03:29:16 -0800
X-CSE-ConnectionGUID: FDvl+/O4SfymzWNyy/vWyA==
X-CSE-MsgGUID: tPEjogDAReaAunXJACGNJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112648507"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa010.jf.intel.com with ESMTP; 12 Feb 2025 03:29:12 -0800
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
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: mtd: cadence: document required clock-names
Date: Wed, 12 Feb 2025 19:25:34 +0800
Message-Id: <20250212112535.2674256-2-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250212112535.2674256-1-niravkumar.l.rabara@intel.com>
References: <20250212112535.2674256-1-niravkumar.l.rabara@intel.com>
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

Fixes: 1f05f823a16c (dt-bindings: mtd: cadence: convert cadence-nand-controller.txt to yaml)
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


