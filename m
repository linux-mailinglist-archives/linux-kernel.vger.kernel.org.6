Return-Path: <linux-kernel+bounces-436670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561F19E893E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1668A281284
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 02:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF904594D;
	Mon,  9 Dec 2024 02:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KbTuKQJk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E2770801;
	Mon,  9 Dec 2024 02:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733711957; cv=none; b=m+0yVMox3fX0CNC1inQwu2ImemTXTI4VyV16MvMBmlXIkbhwsTRAW37piHCTOxMa8vpqxS8URXAyCTH5gy3Fb84aRWBAcMFCHziBOY0mqJ2WAHrP7ri8yfIB4q7ss2CsKDotImp4JdyCu13Pco1ynlqe8t3hRhFFluQPLxbOigE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733711957; c=relaxed/simple;
	bh=R3rsXA7MJNgkJGauIpjyQYKqR5OEmgC9NM4sVDYiz4k=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=o4nDH10RJzSUY1U4qAfxOZsGCBIPqGBD9O9OCEuEv2tdKtBQdwnihhn1bbc19+/U8VnwxdN8J6yKHXc7a4iSCCAPgLTsyS+BftgHHTYzAYv5vdM6UuipB+adH8ys6T3PNLbE+OWyiTvcnuUzwOUCLRcXoA/tN8JbNTj2lDNKM/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KbTuKQJk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733711956; x=1765247956;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R3rsXA7MJNgkJGauIpjyQYKqR5OEmgC9NM4sVDYiz4k=;
  b=KbTuKQJkjtSUPk+jRoE6Mbs9uSrXCd4h/wce4w98iN2ZtnQPlV0g4LCw
   BS9nT6uCxpcvgo9m6RsL58aVlSqtXbMz25yLnMp3xwEj3B4Yj3wMp5nn8
   LUYtgjn66LtDrB2q9rxAVmonKReaktQGkE6Qn4yBNgBOfXy44h7mAEbAH
   BuieLNxP9/Q+Ze44sNXe+SyOipBIm85fjMHFkv7QG6U8mZKLAzfPWuKjL
   BCHgetFjrNlyMlNmXvLpP6jmjyNiaBHn38bPNu+3Ck22DlUG0ts+Fx4eA
   XW6CtwbbXInLB0tFsCwYimCubVNSHwG8M1khqo8Wf2I8bprDFkFLknUE9
   g==;
X-CSE-ConnectionGUID: idT9F4aiQ5uDbx5vDxKrzw==
X-CSE-MsgGUID: cOgmiJHIT/WC9SVjpRemTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="44678764"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="44678764"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 18:39:15 -0800
X-CSE-ConnectionGUID: 8/ijerSrTmyjvds8T0snIA==
X-CSE-MsgGUID: SAZVVnrHQcWmHk6OnWxDQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="118183770"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by fmviesa002.fm.intel.com with ESMTP; 08 Dec 2024 18:39:13 -0800
From: niravkumar.l.rabara@intel.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	niravkumar.l.rabara@intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: socfpga: agilex: Add VGIC maintenance interrupt
Date: Mon,  9 Dec 2024 10:36:11 +0800
Message-Id: <20241209023611.1216499-1-niravkumar.l.rabara@intel.com>
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
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 2a5eeb21da47..1235ba5a9865 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -101,10 +101,13 @@ intc: interrupt-controller@fffc1000 {
 		compatible = "arm,gic-400", "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
 		interrupt-controller;
+		interrupt-parent = <&intc>;
 		reg = <0x0 0xfffc1000 0x0 0x1000>,
 		      <0x0 0xfffc2000 0x0 0x2000>,
 		      <0x0 0xfffc4000 0x0 0x2000>,
 		      <0x0 0xfffc6000 0x0 0x2000>;
+		/* VGIC maintenance interrupt */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	clocks {
-- 
2.25.1


