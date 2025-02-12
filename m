Return-Path: <linux-kernel+bounces-510862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270AFA322FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCC5162B69
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46CB208965;
	Wed, 12 Feb 2025 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGkKfUzk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE6C20766F;
	Wed, 12 Feb 2025 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354275; cv=none; b=uIT4cNjpeHyoOtPWQiShQJ3ZeHDT/OcTshQBIWaJRA04PtYmw9p/lq8d2pm8ychkU9wxC2oGcAKd1RsDjB/ogx5Hif0C95K9Y+snrRp5YirMC32lsphnp4rGKY92vUaO2N4HKSY6D4vCGg9wWynbVicJpuo4mjNK3wCsZbO3ihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354275; c=relaxed/simple;
	bh=BzyghW93iAlPxY+WnjStv3bNbo3dV9daNhUGHnjjD64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UcY9zH8NY77vnLIhFczOA9xOu1bda4LsX6hyPAc7Qsja50agn7aizl/Jq4yfRw0DLD1BtrCSMeYItjQOdqQshCxZOn8OvrrYC5Zqzf0jqiTvjrxF+wPQFIiSGLE9Zp87016lifceVzz3zEovpX5vga86M2aWF+Q/PxZBbbPEHzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FGkKfUzk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739354274; x=1770890274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BzyghW93iAlPxY+WnjStv3bNbo3dV9daNhUGHnjjD64=;
  b=FGkKfUzk2R850tvm0T+Vn6yYZ6dCsXMoCoKWsdgodQzwSLnFS/O80KmC
   bAKvp3p/el9MreTXX+SiiW9v3W9hfnN1VcOhj15ckKnr5ui4oV84VCZk8
   7dC0Iz5KRmlk6RbzpRM/CC0y1HJXadKJAWNeEtL8CuUNeoFmkli8UtMQG
   /b7gF9d4dmWjOGsVv/NVf+iiQT+nFbmTO8dVB98pHrlWMRgFxkilDFmwf
   c+prbcUJx5fe+Oqm3HXdTU1dweLdwuL9vfS8NvlPEMpkPppzipItnm8I5
   wvM3xFLTtwrkM/UmEItVckH5coOpsP2K0L/KKkj3quyMGlFwKmPy6xpzb
   g==;
X-CSE-ConnectionGUID: wA+sdtIWRiGYiJQUIBfWgA==
X-CSE-MsgGUID: wdnsSpDQSoC++4d2+N5pLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50224553"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="50224553"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 01:57:54 -0800
X-CSE-ConnectionGUID: fgn2dMg2Tga7/YPHJGnQyQ==
X-CSE-MsgGUID: 09qUeucSSeujz4OMvpFMyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112632062"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa010.jf.intel.com with ESMTP; 12 Feb 2025 01:57:49 -0800
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
Subject: [PATCH v2 2/2] arm64: dts: socfpga: agilex5: add clock-names property to nand node
Date: Wed, 12 Feb 2025 17:54:07 +0800
Message-Id: <20250212095407.2667743-3-niravkumar.l.rabara@intel.com>
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

Add required clock-names property to the nand node.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 51c6e19e40b8..27f75e1bc8eb 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -271,6 +271,7 @@ nand: nand-controller@10b80000 {
 			#size-cells = <0>;
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clkmgr AGILEX5_NAND_NF_CLK>;
+			clock-names = "nf_clk";
 			cdns,board-delay-ps = <4830>;
 			status = "disabled";
 		};
-- 
2.25.1


