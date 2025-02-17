Return-Path: <linux-kernel+bounces-517576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BC2A38294
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788EA3A8F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE82219A78;
	Mon, 17 Feb 2025 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjJ9LrWQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F96C2EF;
	Mon, 17 Feb 2025 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793905; cv=none; b=k+r7sjuvMf3tYT3hRf0iH8vw6BkvqdK+jepDnULYaKR110DoIOtI3AERT/OSRtES4u7MN1CB62FM+5GaJ02I0k1eWe60DoZ3sXcJ/l4n3n3TBupJG4SVkS6ik3+1tVOk6yeXGr/WbN0n1KlveGOWHCllEcP/1zrXS0B+6A4YfYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793905; c=relaxed/simple;
	bh=k0ACiT4+b4nMzJtkhFI0xgwWYBfdQqCLEShY+Lxuh6c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=k+oT9FwF+tvBnFAXqKVmyUvMIg2OBqKct8K9P+ADz3/al3KJZoUfy03VQ7OuGRd/Q0GBBHio6hrVvhIJ+zpZcL3838HRJM169v1uhSswWOYozsW33zBNVG6+00LEIogAsUYFhYBU0BMtgRYuxy919AjG0bxFxhmzp8SoNgHFiwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjJ9LrWQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739793904; x=1771329904;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k0ACiT4+b4nMzJtkhFI0xgwWYBfdQqCLEShY+Lxuh6c=;
  b=TjJ9LrWQ81dnQWfOMJX8v5/5EItGzHoV1/Iil/pWaiTJpBuYkq+Rxbje
   zp21InU9kCwhHMswWSY7l3wRXlIGbPQSuYO6dpfJeK/wYPJMOrH4mZLos
   IDx7BFyJuBPy94FVTyzn5joIyTM8j54FLpMH+yG9GX9p395LurooRmBQy
   TPRSB/627Zt2AgH24ql/62VxaOewqxOLHMI7OVmgAb/Ywb4FhbIr3SNpi
   cDKhCTUrPCtq9Ogt9GR1dP2Rv+gSmNDYAuo9/DgQD40Qv8x7oqvACjT5g
   V9ppJWbOCqst+4ZXysqYEnubfZ+4/xm7N3R8YxXF+Ht3noBqGF6k2ZXD2
   w==;
X-CSE-ConnectionGUID: CwQOIw6QTdW8e46bsXER3Q==
X-CSE-MsgGUID: XSDhAZYAQoarMXaBic8fcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="28069742"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="28069742"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 04:05:03 -0800
X-CSE-ConnectionGUID: rXemuYMiRBKmrmXT2nDIWg==
X-CSE-MsgGUID: QqlHyB2zRJmb5N6y15a0Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114589482"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa007.jf.intel.com with ESMTP; 17 Feb 2025 04:05:00 -0800
From: niravkumar.l.rabara@intel.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	niravkumar.l.rabara@intel.com,
	nirav.rabara@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: socfpga: agilex5: add gpio led and memory node
Date: Mon, 17 Feb 2025 20:01:24 +0800
Message-Id: <20250217120124.3502476-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Add GPIO led and memory node for Agilex5 devkit.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---

Changes in v2:
  * Add mising blank line.
  * Changed the name to led-0 instad of led1. 
  
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
index c533e5a3a610..e106e48f1e3f 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
@@ -15,6 +15,26 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			label = "hps_led0";
+			gpios = <&porta 11 GPIO_ACTIVE_HIGH>;
+		};
+
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0x0 0x80000000 0x0 0x0>;
+	};
+};
+
+&gpio0 {
+	status = "okay";
 };
 
 &gpio1 {
-- 
2.25.1


