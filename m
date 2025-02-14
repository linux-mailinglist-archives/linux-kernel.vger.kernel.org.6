Return-Path: <linux-kernel+bounces-514474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B0CA3577B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644EA16B3C6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77B920550F;
	Fri, 14 Feb 2025 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VCz234Ui"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27112753E8;
	Fri, 14 Feb 2025 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739516348; cv=none; b=I/vIcknRnHA/IBD/WcVGd36EWAAy/NqRZZ/KHAqG2HRtTVsv56jk0B2TtlmjJgysHkFEtNp6hQN/sWcvmQkqDsXzQfcpc5Ad5CBMfwitgwlygMPMYaPi3Ic4nHVp4aC0jEfZrqc8y3Sjr94KB74PUsUN4nVXoCqMq0Aj1jZBfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739516348; c=relaxed/simple;
	bh=akFjVw1HJeD3rGU/bp4UxDE/mU36gF3zt5HxePPP0ag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SPMj/Mf/AdMRVXUkYl65GBnb2XGp26UseEqM0HF3o8u+v5jeztxSFBW9RG0GHpRvZI1zy1ari0cdMuH8KNfxLAYQ4nwXYRGEdk/kTv/6gMvSSADreK+MpMMoGvclq0fhSntGQbCyfdHY7+aDY0l8bM+zm8NB768DlzGbz6uqh+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VCz234Ui; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E5nq5x012357;
	Thu, 13 Feb 2025 22:58:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
	qcigeTLdMurTiiZX6EZ+y04SiHPGF2hirIhUkxRgI8=; b=VCz234UitLNAJTQ8g
	oiUTz0+evuakApf6h06uGUhkqa2y57GJcq1amKIAWn7Hs/11G/bqnmyJFVgMDWVr
	Lfc2t5SQRser9qhvcyo/1pVI2RqIzOQHvgu4qoTSxaC0eRRFk1L59DgS7QfWA9zl
	fflbI4jaPttbsmgEz4mF1CvyJDgVcwxeJRwdBStb7plNeS+oeea7bA9SpYTwLmvD
	ZkWWU96qZX37S8rMkKEeMttcTuqKX4J7rgymkX90v7bpuzJncuj3sZBckCzoPv0V
	uhP+faFjB15V+iqheMwYZxM5T9DJT9q6l/QOOxItR29vP75VH1F2E/wgxm1Kc2O0
	jsp3Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44t01f03e2-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 22:58:52 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 13 Feb 2025 22:58:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 13 Feb 2025 22:58:50 -0800
Received: from wd-ubuntu-24-04.marvell.com (wd-ubuntu-24-04.marvell.com [10.111.132.113])
	by maili.marvell.com (Postfix) with ESMTP id 06CF73F7090;
	Thu, 13 Feb 2025 22:58:50 -0800 (PST)
From: Wilson Ding <dingwei@marvell.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <salee@marvell.com>, <gakula@marvell.com>,
        Wilson Ding <dingwei@marvell.com>
Subject: [PATCH 3/4] [PATCH 3/4] dt-bindings: cp110: Document the reset controller
Date: Thu, 13 Feb 2025 22:58:32 -0800
Message-ID: <20250214065833.530276-5-dingwei@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214065833.530276-1-dingwei@marvell.com>
References: <20250214065833.530276-1-dingwei@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Q_8QgP-V-canHPGPNXCrgp8Oi7CdQaaD
X-Proofpoint-GUID: Q_8QgP-V-canHPGPNXCrgp8Oi7CdQaaD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_02,2025-02-13_01,2024-11-22_01

Add new compatible to be used for CP110's reset controller, and document
the supported reset lines.

Signed-off-by: Wilson Ding <dingwei@marvell.com>
---
 .../arm/marvell/cp110-system-controller.txt   | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
index 9d5d70c98058..a5cc1360969c 100644
--- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
@@ -190,6 +190,38 @@ CP110_LABEL(syscon0): system-controller@440000 {
 
 };
 
+Reset:
+------
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
+ - compatible: must be:
+     "marvell,armada8k-reset"
+ - #reset-cells: must be set to 1
+
 SYSTEM CONTROLLER 1
 ===================
 
-- 
2.43.0


