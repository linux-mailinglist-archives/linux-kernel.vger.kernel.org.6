Return-Path: <linux-kernel+bounces-518505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EADA3901D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 02:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25AF07A1FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 01:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751451E526;
	Tue, 18 Feb 2025 01:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AhWYI/XA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4185B1DFCB;
	Tue, 18 Feb 2025 01:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739840685; cv=none; b=BTmWc08TfhNqMWqEYhVWv+JUIouml0MkGc7g2wMJ/kZTKdHbobZxo6WeeSJ8rvkj/vsWN2swueROZbGxk7GiGhyCeSZ1evQRIKLX7dz2BPDIkw3ojSaL62ec+dw8O/mFMd77NGGWDGBjmnTkFSvcK6CxS81LuO8NHhODZxH3yIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739840685; c=relaxed/simple;
	bh=aaoQ8gKgzJPVqQSmP8gQjMPdFUpl9dkYQ0T4GzWMGEU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=syNFFRAaBQM8eSiCYf3z9FMDmDIP0YoK/nm/CF7JShICyyBWifpCXKiiAG3MABLhMOUBouO6Z8Xw8CG1kfATfADjVxC333GnZ2tdr8Wltc0U25cRdJcLlIHJ1j/tInsUrLZP5J4RwJqn/B/K4Ok9mfXMHdMCTpTRvB8Z3uwqQ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AhWYI/XA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739840684; x=1771376684;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aaoQ8gKgzJPVqQSmP8gQjMPdFUpl9dkYQ0T4GzWMGEU=;
  b=AhWYI/XA9P5c46DS5XLYVqi//f/r458BNc/QZIxZbshn0jAJSXNgGbHP
   WzPEKL0NuxHfi4vKZllbSYBXTiatGxiGpT02Ruys2yQqDNBnN9pqJ4MZU
   4+KfP6BwfB2y/iwejVR3+lQx3KoZh9O10L/604xBTmMvT7pwnb8P/9nNF
   MxhUf2Pvc8sTbrQMDPgZd8NqJU4gVGbcdT2/vGouwjGLunEs6ghi1uYPE
   /yvhLYMc5B/eYS8POc4voP4qwszE2974GCPWfVyWSNRGyUuoiR9p3gRWv
   6tKNOSJKMMzk0B1YYjDtlu3ANwHA+/YmqFRtB+9TFTfIOsGQbd6f+TnWc
   A==;
X-CSE-ConnectionGUID: PiEvdFp9Qi6P9/S30qoX1Q==
X-CSE-MsgGUID: rXhrls/KRZKpTMuQymRGVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44450371"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="44450371"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 17:04:44 -0800
X-CSE-ConnectionGUID: y0CgsUqRQZKsWXnRUlndvg==
X-CSE-MsgGUID: xDGLRu3gRn+SMexcvUh5ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="114894122"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by fmviesa009.fm.intel.com with ESMTP; 17 Feb 2025 17:04:42 -0800
From: niravkumar.l.rabara@intel.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	niravkumar.l.rabara@intel.com,
	nirav.rabara@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64: dts: socfpga: agilex5: add led and memory nodes
Date: Tue, 18 Feb 2025 09:01:06 +0800
Message-Id: <20250218010106.3536113-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Add LED and memory nodes, and enabled GPIO0 for Agilex5 devkit.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---

Changes in v3:
  * Update commit log for better clarity.

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


