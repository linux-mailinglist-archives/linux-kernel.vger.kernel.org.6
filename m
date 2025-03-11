Return-Path: <linux-kernel+bounces-555440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E14A5B753
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 04:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A756169D26
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11C71EB1B2;
	Tue, 11 Mar 2025 03:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJqogdby"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C517F9D6;
	Tue, 11 Mar 2025 03:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741664404; cv=none; b=AawgrWxQgOaXhVz2SN6SIsjZQntP8TUviRWjL56b4XfyWfIf4divFR3zLf4cCSgiqTzZbQSFpevx3tacIPR5ly8XsmUe8jqj6YG3NnQaioCH89Yindd8j1Rmud64FR8u/UKNBEK3oAfQ0RA+WY+5nggavNGQXxiukwzZQ6G03fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741664404; c=relaxed/simple;
	bh=pMgpc6HC7nxifpscxz3EGmrjoCJUYcrNonuhhGwdVeg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=DBd6mT6+rtbeAALhZdfptKiR9pLLb/29L+bBrdjX1kbz19BGwe887OD2byV5du+6RKiuAXxm5iY0Jxarj+7hI0/+tB75xLVOrX2bvHoYkvrnwVK9CRT44fPjNIHzOmxQ3onmijlvPNM4H5AskVOZiHbi5suc+lstAt1iiaBaBaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJqogdby; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741664403; x=1773200403;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pMgpc6HC7nxifpscxz3EGmrjoCJUYcrNonuhhGwdVeg=;
  b=BJqogdbyyZJ8xfH+mXnBpQIk6jNfQrRX9kB81mpMp2w1m46U7kh1M8fk
   903tBTp+p2LxGWVdPh2TF+JeVlHNplyg0PDHASNzxGKPJIpG7bK6WF+Eu
   PuQ7TwZ6GNQfOq4tWwvHC/KCOTenBpD4x3QmSUyhhK34FWdn3OnkBTQac
   c7Zk+eTGuCRd1FaL0milVOm99DCVFKNNISRrD0MKYpg/O/r7IqIScsvQu
   zZxo/wArU9Yz8WdUSmyAQA0Zwxqt83Dc4aMqCXOXjLC/86+lO7OZqB9vq
   kTNvydngwXZqSaiN2Y43tTkWpYU6qpPLDEhGvUWBM92Gc/hXuz/qbGqhY
   Q==;
X-CSE-ConnectionGUID: BGVr7c+0SMqGm9OKxeZ1kQ==
X-CSE-MsgGUID: BJS3E3QSScSRHHzwqbjRiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="68042245"
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="68042245"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 20:40:00 -0700
X-CSE-ConnectionGUID: tVuMo/dXTSO4WZpIKx/95w==
X-CSE-MsgGUID: bAy02E9YTl6TpeHpgUJ97Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="125392660"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa005.jf.intel.com with ESMTP; 10 Mar 2025 20:39:57 -0700
From: niravkumar.l.rabara@intel.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	niravkumar.l.rabara@intel.com,
	nirav.rabara@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] arm64: dts: socfpga: agilex5: add VGIC maintenance interrupt
Date: Tue, 11 Mar 2025 11:36:01 +0800
Message-Id: <20250311033601.1940199-1-niravkumar.l.rabara@intel.com>
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


