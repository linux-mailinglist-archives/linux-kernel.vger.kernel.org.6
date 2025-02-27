Return-Path: <linux-kernel+bounces-537183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAA2A488F5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1188C3AD341
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3696626E96B;
	Thu, 27 Feb 2025 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iqKZCRay"
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC9826E958;
	Thu, 27 Feb 2025 19:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684362; cv=none; b=V6YRLYgNnTXBF5bC7vhECczpW8Q3NM8ezDA25XmCfPg3jbS1D1Kn82TDc+gp/zZ8XGZQcZ0MPQYSRRAbch6v+ayqdC/xIv2sPVD3yMZQA+INFwYk/1gF44rrhyAl5xwc04PqVxsRwF0owTVuT7ufBz4L1UwzwW4iS5mBCfDccDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684362; c=relaxed/simple;
	bh=a6NvEy6QBLiN8CY+IhF9/3XHktH32/23x1gAefp+5zg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZKw44noNLuNXxKiLJVhlUnCPzvJDSwE+pB4Vy6KkdGLTSIAgcQaE7Wvsj8bBxzWuwfE4cKOggdnGRFbyhZjcExml0inVA5KCYfy3TKvCELJThZXkMUDJi9Awre9s2toZnyj+eSYxLAb2Z5FqGk5FXzsI305Wmi1/YFEDC2nmGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iqKZCRay; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RFjKPv005358;
	Thu, 27 Feb 2025 11:25:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
	YTLXJD40V2QUBA5lQJUGgPgBRx7eVqymsySQ7bcibY=; b=iqKZCRayiWsTCOtm6
	MC4DlAwa5vb6bboPXL205jex4Ctny5Bm2umMCnF1La8FITfNL3OEIKb6hrfB+Arm
	AIrRf/Jb1YIlrsVlt4KKA4sramAhrxZOA0iOgwtHJyJRQQJeRGzwc53wvUu6e55e
	Rqu6ANnYijHb+vhPIo0ppugjXdwgj801+pih0i0NIxmvq4es+tKmWY0/1CCFq+eB
	yLvCVuO/QXQwNIF+8ltgz8nplgCPUfXoIqhQskujZDdouN4qv0+DYU9Xqudek5uQ
	9Nhy5mAFKbxRtgiStr3sTwowNbKKE6ftGxesOL+lXPpE6DO5WWbSmkjCcOZX+89m
	vM4xw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 452tyjrhbm-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 11:25:40 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Feb 2025 11:25:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Feb 2025 11:25:38 -0800
Received: from wd-ubuntu-24-04.marvell.com (wd-ubuntu-24-04.marvell.com [10.111.132.113])
	by maili.marvell.com (Postfix) with ESMTP id 786455B6927;
	Thu, 27 Feb 2025 11:25:38 -0800 (PST)
From: Wilson Ding <dingwei@marvell.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <salee@marvell.com>, <gakula@marvell.com>,
        Wilson Ding <dingwei@marvell.com>
Subject: [PATCH v3 3/3] arm64: dts: marvell: cp11x: Add reset controller node
Date: Thu, 27 Feb 2025 11:25:36 -0800
Message-ID: <20250227192536.2426490-4-dingwei@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227192536.2426490-1-dingwei@marvell.com>
References: <20250227192536.2426490-1-dingwei@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: F9GJO5NrJ5WTW0ERHCE9qRfpK7xQkZIZ
X-Authority-Analysis: v=2.4 cv=UIYnHDfy c=1 sm=1 tr=0 ts=67c0bc34 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=T2h4t0Lz3GQA:10 a=M5GUcnROAAAA:8 a=DYY7cqjbEommNVqY-hUA:9 a=cX4pScRg4-JUD0_czzmr:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: F9GJO5NrJ5WTW0ERHCE9qRfpK7xQkZIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01

Add the reset controller node as a sub-node to the system controller
node.

Signed-off-by: Wilson Ding <dingwei@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 161beec0b6b0..c27058d1534e 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -226,6 +226,8 @@ CP11X_LABEL(rtc): rtc@284000 {
 		CP11X_LABEL(syscon0): system-controller@440000 {
 			compatible = "syscon", "simple-mfd";
 			reg = <0x440000 0x2000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 
 			CP11X_LABEL(clk): clock {
 				compatible = "marvell,cp110-clock";
@@ -273,6 +275,12 @@ CP11X_LABEL(gpio2): gpio@140 {
 					 <&CP11X_LABEL(clk) 1 17>;
 				status = "disabled";
 			};
+
+			CP11X_LABEL(swrst): reset-controller@268 {
+				compatible = "marvell,armada8k-reset";
+				reg = <0x268 0x4>;
+				#reset-cells = <1>;
+			};
 		};
 
 		CP11X_LABEL(syscon1): system-controller@400000 {
-- 
2.43.0


