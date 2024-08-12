Return-Path: <linux-kernel+bounces-283833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5F394F929
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9A48B213C4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0BA1990A1;
	Mon, 12 Aug 2024 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LaCUyZcG"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ED5197552;
	Mon, 12 Aug 2024 21:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723499501; cv=none; b=cPiFi7WCBSd+uBaYzeenY2xRbWIWS/SXo513V2zgQuoDDgVU1BT/pPLznLYRumKC0Qr4H2ZUYaT0/YBtA5txHQQ2m+jE3rPNt5IBtkgpm+qELDeycIGshPDKkFpdhS5P3gcOFfYN5vxwcJdAa/oNRbNG85PkzdrJgio60BOgxNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723499501; c=relaxed/simple;
	bh=XBgzzieWts/yI/JNh6i0XFTBfTvHjr3OAD3yxf8bbI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBg6Bye4ZfQC8kyvDPWkwnJccwOdBUvZCpd/9JscYZGYzOH4PHz8NBNHWd7Q16IifdwLl9olQ+kFAVz1kG9aQNJh8yeL/hjh+sgyBw7u/QR63f2CtCi0UZ7ARV7VVXFGwkVdNU3v56ETfVBJ1SSa+XYmA1nsFQ+3v3EeOvfvJD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LaCUyZcG; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723499497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mF4lpXQ81+wCK5QEf8V7sejg4qABTPRYD7pfCEhu5eM=;
	b=LaCUyZcGSX2H+fHtvHS1VqS23JBPJG/YT3Z/SFkSYhnx9BPJE47J2G14l55rPOvW5wrWLo
	8IRSc9QHncwSJTHgN7fYX7LmwiLjQ2YXedcb3jdS25SgmMLF3P/bmmwBqlX10atOmQNUWI
	7olP4HcsV9JkCHraN39DRzo4zGfchqA=
From: Sean Anderson <sean.anderson@linux.dev>
To: Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 2/3] arm64: zynqmp: Expose AMS to userspace as HWMON
Date: Mon, 12 Aug 2024 17:51:27 -0400
Message-Id: <20240812215129.3599832-3-sean.anderson@linux.dev>
In-Reply-To: <20240812215129.3599832-1-sean.anderson@linux.dev>
References: <20240812215129.3599832-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Expose the AMS to userspace, allowing monitoring of internal voltages
and temperatures. For compatibility, we keep the node name the same as
on the SM-K26, and we keep the ZCU100 Rev C. around (since it is named
differently).

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts | 14 --------------
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi            | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index 4e0e7fdf29ca..bfa7ea6b9224 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -90,20 +90,6 @@ ds36-led {
 		};
 	};
 
-	ams {
-		compatible = "iio-hwmon";
-		io-channels = <&xilinx_ams 0>, <&xilinx_ams 1>, <&xilinx_ams 2>,
-			<&xilinx_ams 3>, <&xilinx_ams 4>, <&xilinx_ams 5>,
-			<&xilinx_ams 6>, <&xilinx_ams 7>, <&xilinx_ams 8>,
-			<&xilinx_ams 9>, <&xilinx_ams 10>, <&xilinx_ams 11>,
-			<&xilinx_ams 12>, <&xilinx_ams 13>, <&xilinx_ams 14>,
-			<&xilinx_ams 15>, <&xilinx_ams 16>, <&xilinx_ams 17>,
-			<&xilinx_ams 18>, <&xilinx_ams 19>, <&xilinx_ams 20>,
-			<&xilinx_ams 21>, <&xilinx_ams 22>, <&xilinx_ams 23>,
-			<&xilinx_ams 24>, <&xilinx_ams 25>, <&xilinx_ams 26>,
-			<&xilinx_ams 27>, <&xilinx_ams 28>, <&xilinx_ams 29>;
-	};
-
 	pwm-fan {
 		compatible = "pwm-fan";
 		status = "okay";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 256cff250717..21c1adbaf35f 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -392,6 +392,20 @@ r5f@1 {
 		};
 	};
 
+	ams {
+		compatible = "iio-hwmon";
+		io-channels = <&xilinx_ams 0>, <&xilinx_ams 1>, <&xilinx_ams 2>,
+			<&xilinx_ams 3>, <&xilinx_ams 4>, <&xilinx_ams 5>,
+			<&xilinx_ams 6>, <&xilinx_ams 7>, <&xilinx_ams 8>,
+			<&xilinx_ams 9>, <&xilinx_ams 10>, <&xilinx_ams 11>,
+			<&xilinx_ams 12>, <&xilinx_ams 13>, <&xilinx_ams 14>,
+			<&xilinx_ams 15>, <&xilinx_ams 16>, <&xilinx_ams 17>,
+			<&xilinx_ams 18>, <&xilinx_ams 19>, <&xilinx_ams 20>,
+			<&xilinx_ams 21>, <&xilinx_ams 22>, <&xilinx_ams 23>,
+			<&xilinx_ams 24>, <&xilinx_ams 25>, <&xilinx_ams 26>,
+			<&xilinx_ams 27>, <&xilinx_ams 28>, <&xilinx_ams 29>;
+	};
+
 	amba: axi {
 		compatible = "simple-bus";
 		bootph-all;
-- 
2.35.1.1320.gc452695387.dirty


