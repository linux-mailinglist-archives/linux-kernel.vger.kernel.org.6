Return-Path: <linux-kernel+bounces-314920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A618B96BAFD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA241F26589
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9EF1D0DF0;
	Wed,  4 Sep 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="oRHNE6kS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="qJkqOIJn"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F331D0152;
	Wed,  4 Sep 2024 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450095; cv=none; b=EvZT2DXLTm/gDwZfhyHaqm+0DVLwSYtN9cXTrGLONkzvBtteDltb2UQx5EUXoE8wujemRh5lRYQWuoFkO9JZlIJ69B7e/9Esg6A11opXK/SUzsmOqZOI46lN+Z7aGeNouUi2XUpKzjZHOs+1A6FO75TU5wTk662zqAGU09oRpQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450095; c=relaxed/simple;
	bh=9vDBZHymsDpAYwBeaEhUA5DEpd0UAPjqaad8mMrUNfk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ssdCmT46UAIt+nmVK2HmvvjTYf4DwPHmwyPeTjF4RTTb1S5vq92R5N6YzOmIYhQfc6xTMFo9tObIil63c3jnrLmYZNLZ4RC8ftkYnBrHKU2/ObyQwiDJMWxa9l1SQ8Nm5q6NYt0CimW4qmJVT5y823R9SNP1JbBsHVwQHLwZRkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=oRHNE6kS; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=qJkqOIJn reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1725450092; x=1756986092;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=50GjDQI+pSoabi61OIfDuJqzJLB8xHBCP1mouzolrew=;
  b=oRHNE6kSTez69wfGXhoD9R5j9wcsWp9zNF+UsXvlzEzjODWHNjvIxfx+
   brhB9UHGHTGwMkjWkld7/hiu92kJsz9iLiCv1p+WI2YeITUGtcWZqXwEi
   J7uRw5jRnGF77bHW2k3MxazI1csjlgjHK5FSnSLoxM5GCEi3L3n0k8qA4
   oTob6WvNotP4AIWqSBRIYQGH+oyHn/hr341vS1V/LevQatHbQQMN8doUH
   2BsQYf4kgLLsbiwVg5Ah+kgToQJ1aaVSoefe+yytzKHan8ADoxnwcjDn9
   UXOeQsJZRUKXPq/Zc/H4aHEMfDn3twRje/qTjluFRdu7oL+PLNbC9mbdh
   A==;
X-CSE-ConnectionGUID: JQjU9ZnQQjqTOhRyZOcAYA==
X-CSE-MsgGUID: LIQJAjhURkKkdd2QoQWWzA==
X-IronPort-AV: E=Sophos;i="6.10,201,1719871200"; 
   d="scan'208";a="38761777"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Sep 2024 13:41:29 +0200
X-CheckPoint: {66D84768-2C-5FF8EC80-F6CEE9F8}
X-MAIL-CPID: BC999EBFB5F1F2B338A0722EB8ED215C_0
X-Control-Analysis: str=0001.0A782F23.66D84769.0046,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB3A916A860;
	Wed,  4 Sep 2024 13:41:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1725450084; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=50GjDQI+pSoabi61OIfDuJqzJLB8xHBCP1mouzolrew=;
	b=qJkqOIJn1syPvvXoeTk5pIGXjxI8FyJNctdZYYV/jQ29aVA3HT0JaGNwHsIja+rEJ10JYv
	nFGZYNXoTXWEVzT82JQLvOSx+5QlP+oM6iN076CJtkyT3YLjYsW1l44S/RJ8o6g/bRmuQQ
	SkorVNapiTfjUr6TbmtJ1MRWJ1/BiyfgEVmi3FT1GUxMrZSlSIn33JzHY3VWfDCecvyh58
	74coOcbysdWYtqlrZ0KjWgL6NVRyaM+rrFT/ndu70aTr4Iut6+yzi6lUEsUbKPHRSeTjl9
	pPV3p52Dpd66++fmq3o+bED9+VcOoDu2ac928qkb7OFQHtLAUzPjumekCZIzGQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shijie Qin <shijie.qin@nxp.com>,
	Ming Qian <ming.qian@nxp.com>,
	Zhou Peng <eagle.zhou@nxp.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] arm64: dts: imx8-ss-vpu: Fix imx8qm VPU IRQs
Date: Wed,  4 Sep 2024 13:41:03 +0200
Message-Id: <20240904114104.1841269-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

imx8-ss-vpu only contained imx8qxp IRQ numbers, only mu2_m0 uses the
correct imx8qm IRQ number, as imx8qxp lacks this MU.
Fix this by providing imx8qm IRQ numbers in the main imx8-ss-vpu.dtsi
and override the IRQ numbers in SoC-specific imx8qxp-ss-vpu.dtsi, similar
to reg property for VPU core devices.

Fixes: 0d9968d98467d ("arm64: dts: freescale: imx8q: add imx vpu codec entries")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi    | 4 ++--
 arch/arm64/boot/dts/freescale/imx8qxp-ss-vpu.dtsi | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
index c6540768bdb92..87211c18d65a9 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
@@ -15,7 +15,7 @@ vpu: vpu@2c000000 {
 	mu_m0: mailbox@2d000000 {
 		compatible = "fsl,imx6sx-mu";
 		reg = <0x2d000000 0x20000>;
-		interrupts = <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>;
 		#mbox-cells = <2>;
 		power-domains = <&pd IMX_SC_R_VPU_MU_0>;
 		status = "disabled";
@@ -24,7 +24,7 @@ mu_m0: mailbox@2d000000 {
 	mu1_m0: mailbox@2d020000 {
 		compatible = "fsl,imx6sx-mu";
 		reg = <0x2d020000 0x20000>;
-		interrupts = <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>;
 		#mbox-cells = <2>;
 		power-domains = <&pd IMX_SC_R_VPU_MU_1>;
 		status = "disabled";
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-vpu.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-vpu.dtsi
index 7894a3ab26d6b..f81937b5fb720 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-ss-vpu.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-vpu.dtsi
@@ -5,6 +5,14 @@
  * Author: Alexander Stein
  */
 
+&mu_m0 {
+	interrupts = <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&mu1_m0 {
+	interrupts = <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &vpu_core0 {
 	reg = <0x2d040000 0x10000>;
 };
-- 
2.34.1


