Return-Path: <linux-kernel+bounces-517027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 657D9A37B18
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BB016ADE2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172A318C932;
	Mon, 17 Feb 2025 05:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLIfBT6E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE2C185B67;
	Mon, 17 Feb 2025 05:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739771931; cv=none; b=hSSYbnFxbr+3/XQb57HOS2aDTjohboQB20Fl1ySH+4AMhwPayD+qpNwNJEK6c0RBnhly0KOmDK+8C5bFpULO1HBWw/AmiimWM5c6JRpqviL6No1gRW1PEzlrnsYYio6XSvisuqpdhURRUZ6mtng7cKYHKDGJ9gFBmjkb7dprm34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739771931; c=relaxed/simple;
	bh=pMgpc6HC7nxifpscxz3EGmrjoCJUYcrNonuhhGwdVeg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=YQ6/j2w0SIULdycG7euSQgKWLp/HHhl6KMvG4apgjAKJ9Xn23qTHaKU1W1fhWLFl0s+n9v2VWA5CZg4Bhb94LGjQAZz8YSmJwdTFkHRfR3AbgQaao0EcVEU9/cs01TraOo5gF+61smFsdVBlqz0P7CDfwIA0adjPQViA1JXG8Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLIfBT6E; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739771930; x=1771307930;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pMgpc6HC7nxifpscxz3EGmrjoCJUYcrNonuhhGwdVeg=;
  b=hLIfBT6EJFg2jPM82BK6kfqdpNmBU8VJqZ2f8MU6rJaV7tztiAhwxfP8
   sACEb3PDSEpBn8i+warEy2idApe5WTrFqtCgKcLo9KGASl1YQ/7i5jyA5
   JUW7h5mAaaKbDhl503Idp2fM2MukTeY5WuwEm8ySWC8jQ5ci02fzPB3RG
   ESKtisbo3erhH3RZn+M9b4K5u16DwHgRx5QlGUjczsAF+NmXjwn710D+T
   pyD6ruxEHiAFP7UwnEXykYCaXeWpB6Jv6BPqPed32/VwNjKT4PXR8sZWf
   2eGBJf0LBtYKco+32kgJTqD89ZjQfaaLgIqnknA8J6eQznYXLzm9aaj8l
   w==;
X-CSE-ConnectionGUID: VPOrQwudT/aQ7vtZ4zgHCQ==
X-CSE-MsgGUID: Ydx0vtlVQCm0ruIWXFBiKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="28042123"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="28042123"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 21:58:49 -0800
X-CSE-ConnectionGUID: HF9UUoHERhGp2oCvltl2YQ==
X-CSE-MsgGUID: qzsSmBxHRsqSlPI5vKo5/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="119136460"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by fmviesa004.fm.intel.com with ESMTP; 16 Feb 2025 21:58:46 -0800
From: niravkumar.l.rabara@intel.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	niravkumar.l.rabara@intel.com,
	nirav.rabara@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: socfpga: agilex5: add VGIC maintenance interrupt
Date: Mon, 17 Feb 2025 13:55:11 +0800
Message-Id: <20250217055511.3473717-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Add VGIC maintenance interrupt and interrupt-parent property for
interrupt controller, required to run Linux in virtualized environment.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 51c6e19e40b8..75397e84bd2c 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -75,8 +75,11 @@ intc: interrupt-controller@1d000000 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		interrupt-controller;
+		interrupt-parent = <&intc>;
 		#redistributor-regions = <1>;
 		redistributor-stride = <0x0 0x20000>;
+		/* VGIC maintenance interrupt */
+		interrupts = <GIC_PPI 25 IRQ_TYPE_LEVEL_HIGH>;
 
 		its: msi-controller@1d040000 {
 			compatible = "arm,gic-v3-its";
-- 
2.25.1


