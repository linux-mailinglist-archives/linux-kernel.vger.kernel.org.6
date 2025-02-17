Return-Path: <linux-kernel+bounces-517008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB31AA37AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E4257A27CF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70BD183CBB;
	Mon, 17 Feb 2025 05:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GhVcEKhY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FCD137750;
	Mon, 17 Feb 2025 05:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739770244; cv=none; b=bh+RBPAracTtqOEQX15jZuzZIdlb5uKDLQEFcWabDd0U4+EWGQwIGwbLZzHT0omG9HOzYibblgtfbH5kM46SH6u1cb/6vYcAHZ+lyBBkZvZbF6D2OAvm+sh+ukx0E6SHa4y5HyVHfLynSw+vQbDITuL+ZoQJ/aMFkbW/Rpf+RgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739770244; c=relaxed/simple;
	bh=tLEA142kqkRYVemovRmr9rYeik42O73/peq4w3LNtpc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=WgTRC+XKIKGjAFOQbTpP9OhOl9eltV7bY/cphstaWYD9J/R2xw9xON2lByGwhy81C2/3EK1E16CnV6W5fQ9Y+yrwIx7sQsPBmgQPPh15BqJE1KNydV4OU7qAUsJMzk1j1dMWjSl4lld970wi1yA1NoXaryLIc0IZOv9zYfpwA9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GhVcEKhY; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739770242; x=1771306242;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tLEA142kqkRYVemovRmr9rYeik42O73/peq4w3LNtpc=;
  b=GhVcEKhYWOrRSv2jfvJj+FY8F9TLPNR+I0jMLDFq6sFi24Ad113JO43R
   JeQL1YvOPTN+axPMZjYjXWy71WXML0OY1xsghnOg/dx1xJZFG6GfJPTD9
   JMXsl18hmbKoZvFVnNKknCAvJ+vHwJkmJFSkfmKHNx2doHDqWcKCUu4TO
   lYH0J/zLQnGfHRxK8TSZFOp3M8EW5ZPK4IcWIGOewn7yod5QJtG4ENfBE
   ioeuj6lvwCiQz07vRIZ/E1pxfbtFrqROaVd+v0Oz8CFKy37GZThk6tMbI
   mtt8zohni78qHZg8XrZtsBKTXqKMF/M8q9zSrnby9oVitNZwZMiFS6dTW
   A==;
X-CSE-ConnectionGUID: 3rQe/15ESKCelKGYAiH7tQ==
X-CSE-MsgGUID: IRLvPjnGTZi8seAM0aCUsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="40471086"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="40471086"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 21:30:41 -0800
X-CSE-ConnectionGUID: IT7e8ShvTkSCkkAiM7+Hfg==
X-CSE-MsgGUID: AFHfU5GMQMKJg37xfSomnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="144937329"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by fmviesa001.fm.intel.com with ESMTP; 16 Feb 2025 21:30:39 -0800
From: niravkumar.l.rabara@intel.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	niravkumar.l.rabara@intel.com,
	nirav.rabara@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: socfpga: agilex5: add gpio led and memory node
Date: Mon, 17 Feb 2025 13:27:02 +0800
Message-Id: <20250217052702.3470096-1-niravkumar.l.rabara@intel.com>
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
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
index c533e5a3a610..59530eada2ea 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
@@ -15,6 +15,25 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+	leds {
+		compatible = "gpio-leds";
+
+		led1 {
+			label = "hps_led1";
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


