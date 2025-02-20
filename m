Return-Path: <linux-kernel+bounces-524887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BA7A3E864
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456DC17EEE3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD9B26771F;
	Thu, 20 Feb 2025 23:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="M8CY3mo5"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDE4267384;
	Thu, 20 Feb 2025 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093946; cv=none; b=Hp0bsqUAQTohjoulMD5Vqmj2tJjPcHPccidWNr7MLmMY9oJhUOjkFK7+amZacnDHCGyMJQQZ11EfWgYCbzeSrNW13tET5r5qzDvU7t+NyzZC5BLvPxSw9wELtk27S/ga94fek4/rrqNUKwp/8uBZ4FLauarqS4kqaljr+GWzjqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093946; c=relaxed/simple;
	bh=RfPJaF8vGDF8FUVjsFAkzwbqQcHJ9bj6s+xNRI19AuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHknIWTi9NKxsSerazek6dw0PC22lAjTSevbt6pAsdPqhEk7LRNoDfuovNRyW0E58MS71la57vYf6dpaIoaNZPt0b8yDuxzpm+mVFPJdmSipETcdJzpNkBRfSJazwh5fIcGbMPkBl021bsef1E+KDQa/PEDzuWJItP5HoaFpVps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=M8CY3mo5; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KL98la029131;
	Thu, 20 Feb 2025 15:25:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
	sNatOIdCf+dWFsC2Ec22WGLHQHGgHjGPGYvs0F1zgE=; b=M8CY3mo5O0hVeDfZe
	siJq37ekYYYcdCMV2qTr6ngJcgzG5OZM3y6AUbD0a7e+45gJbjlAiMm5/LIcBGwf
	Ptd/qa7YWm+UafGbj+pp4VCWa8V+9hh22eRYv1D6qe/bEHjjKK3cY88CW4DfMpp9
	MCtjTUVVCPXXCZpZYY26n4fpAIp4nrtyMoENdRNXMoDtjf0pl1IaILdvDu3ZbyIF
	gAe91ihidVX4WIjUpQb8BzDxhidOOkWqvCT9qFNH/jjOCzT4gmYu6Z0kHRw3o/i2
	P3rLVyznZRvv6KT5wXgB1vPhX9Gpc347OZXpA2Ef/E7NXnxNk6m35j0YAciG4s2c
	b5YuQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44xc24r917-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 15:25:30 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 20 Feb 2025 15:25:30 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 20 Feb 2025 15:25:30 -0800
Received: from wd-ubuntu-24-04.marvell.com (wd-ubuntu-24-04.marvell.com [10.111.132.113])
	by maili.marvell.com (Postfix) with ESMTP id E289A5B6930;
	Thu, 20 Feb 2025 15:25:29 -0800 (PST)
From: Wilson Ding <dingwei@marvell.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <salee@marvell.com>, <gakula@marvell.com>,
        Wilson Ding <dingwei@marvell.com>
Subject: [PATCH v2 2/4] dt-bindings: cp110: Document the reset controller
Date: Thu, 20 Feb 2025 15:25:25 -0800
Message-ID: <20250220232527.882888-3-dingwei@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220232527.882888-1-dingwei@marvell.com>
References: <20250220232527.882888-1-dingwei@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5Rj606Czmw0BFWfCNeTiYDmdWPKP-pKN
X-Proofpoint-ORIG-GUID: 5Rj606Czmw0BFWfCNeTiYDmdWPKP-pKN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01

Add reset-controller sub-node into the system controller node, and
document the supported reset lines.

Signed-off-by: Wilson Ding <dingwei@marvell.com>
---
 .../arm/marvell/cp110-system-controller.txt   | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
index 9d5d70c98058..5e2c2f2b147c 100644
--- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
@@ -164,6 +164,43 @@ Required properties:
 
 - offset: offset address inside the syscon block
 
+Reset Controller:
+-----------------
+
+For common binding part and usage, refer to
+Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml.
+
+The Device Tree node representing this System Controller 0 provides a
+number of reset lines:
+
+The following reset lines are available:
+
+-  0: Audio Software RESETn
+-  1: TDM Software RESETn
+-  2: Interrupt controller unit Software RESETn
+-  3: Packet processor Software RESETn
+-  4: SDIO Software RESETn
+-  7: XOR-1 engine Software RESETn
+-  8: XOR-0 engine Software RESETn
+- 11: PCIe-0 Gen.3 x1 Software RESETn
+- 12: PCIe-1 Gen.3 x1 Software RESETn
+- 13: PCIe Gen.3 x4 Software RESETn
+- 15: SATA port 0 and port 1 Software RESETn
+- 22: USB3 Host 0 Software RESETn
+- 23: USB3 Host 1 Software RESETn
+- 24: USB3 Device Software RESETn
+- 25: EIP150F Software RESETn
+- 26: EIP197 Software RESETn
+- 29: MSS Software RESETn
+
+Required properties:
+
+ - compatible: "marvell,armada8k-reset"
+
+ - offset: offset address inside the syscon block
+
+ - #reset-cells: must be set to 1
+
 Example:
 
 CP110_LABEL(syscon0): system-controller@440000 {
@@ -188,6 +225,12 @@ CP110_LABEL(syscon0): system-controller@440000 {
 		gpio-ranges = <&CP110_LABEL(pinctrl) 0 0 32>;
 	};
 
+	CP11X_LABEL(unit_swrst): reset-controller@268 {
+		compatible = "marvell,armada8k-reset";
+		offset = <0x268>;
+		#reset-cells = <1>;
+	};
+
 };
 
 SYSTEM CONTROLLER 1
-- 
2.43.0


