Return-Path: <linux-kernel+bounces-537784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC28A490A7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991D816EE99
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448341AF0B0;
	Fri, 28 Feb 2025 04:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlJg70sV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BDD1A3140;
	Fri, 28 Feb 2025 04:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740718655; cv=none; b=CMsd1gML9zAUnAJbhyaYUPhguDtk28kFcZJjTkZpcBDs05Jtln3TJ/sEsYd6R9Ld17EpNZCTooeUeEhhXg4ULCG4F8TQLCHsXrzYhKYxADyMIc4HJ8MIQXyoSO8fiIJ7XHQu5tzc7FZEZFkJPmSTDTfP8oBTaMvaZboQh35F7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740718655; c=relaxed/simple;
	bh=QrNGroVYoQ/+Oe6QW8oV1ySJLkXG2GnrUIjFbYRGZW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZucUkzYM11JFXRcLcF6zP8aE19aOXOeNmVvjn1TPq3HmHrfLmNqlENAkgOwS2MTbAnGnOwBWOb/5986PM8tA4JBcvZpH7bs+SxmwzrqNukXAxmmCPFMVm1MwuljGA1vLeIPDGb4mNlf7zm2sraFtCKl938Ye5B/noKTG558HHT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlJg70sV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740718654; x=1772254654;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QrNGroVYoQ/+Oe6QW8oV1ySJLkXG2GnrUIjFbYRGZW0=;
  b=MlJg70sV5AWC/SSfeen7/DxOW0N4ffX1ZtcSmdlHFKst4BYOk35V3B5a
   lABJG0ZnTKIv1uUnJLjSj4ffwK5CYoSpCZsuWXozzOQsyBHwzjJnsUOu2
   qAPr8Lr9JW/75jj4Et9G1HK+YufBKrPcqSejTIrscEQd1ZlMVbAv7Ll9d
   ZcESaQfLIJ2hC4vEFyiGIjIbVE8x1gvEdJMoipyhmN/SLVeX7vFfxBPXZ
   fBvYWelWihYy8zn9f37OkNaWcoSl00acQIvTTWV3tI3y3x9WImQfJaF3L
   B8clL4l6JfKEAa0wO0QaJNhxLPmLactJAABBRxFs7yzJCHnPrKPkHDaP4
   A==;
X-CSE-ConnectionGUID: Xlda4NQqSVGy+ud8x74OUw==
X-CSE-MsgGUID: h8JjRYz9TvaG3hg/wpktGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45554641"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="45554641"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 20:57:33 -0800
X-CSE-ConnectionGUID: szytzD3xRbmOecp98ULNPQ==
X-CSE-MsgGUID: eXIAEFFHRYKJvvNvGBm1Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="122245976"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa004.jf.intel.com with ESMTP; 27 Feb 2025 20:57:31 -0800
From: niravkumar.l.rabara@intel.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	niravkumar.l.rabara@intel.com,
	nirav.rabara@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND v3 2/2] arm64: dts: socfpga: agilex5: add clock-names property to nand node
Date: Fri, 28 Feb 2025 12:53:49 +0800
Message-Id: <20250228045349.1429680-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Add required clock-names property to the nand node.

Fixes: 2d599bc43813 (arm64: dts: agilex5: add initial support for Intel Agilex5 SoCFPGA)
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


