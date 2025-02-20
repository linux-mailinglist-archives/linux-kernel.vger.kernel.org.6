Return-Path: <linux-kernel+bounces-524886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA5CA3E869
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB273BC18C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70A9267731;
	Thu, 20 Feb 2025 23:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="K70Q6mUT"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE582673AB;
	Thu, 20 Feb 2025 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093946; cv=none; b=mnSLuEi36YRvucbYTIM5nc3vizfnoCVj0QPRX4y4jZVgVVeQenc9IfZ7ZCR2Ozb6GbjUAjjdk8E09unT2O7rVgomdGXOgBuR7UNxJbLgqJevJ6evwlNfdS0ceB5/tiqekysZuxu7U498lhtiMjInw9XVMbLbbiubqu4I6hcQxeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093946; c=relaxed/simple;
	bh=7n8vU1mDzNEJgHxmKtmshFKGwJhQB+ahwsmQS246Z7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gt9OpZxc89GizzRRYjZgDNONA8A1cQRphWNCAW3ljUjFmLnmYHLSbePXAulv9eSuXU0WzT410OUpr9fkr3zdf8CK9mP+XeWvmcEm8Av7dmvcwmcAX1ZNYUlQImWUkwvWSEyL/avDhFECZvdN2hoN+1VXALIg9bx7OOwZ6zvPNmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=K70Q6mUT; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KL98lb029131;
	Thu, 20 Feb 2025 15:25:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
	4WNw3INmA6Tm9LKCn9lCpP+uwr0eB1K/hOe2FJk4xM=; b=K70Q6mUTvtI5nGZn6
	1Hs++NyjQfsH4radtMiAMmn/egrnHrskS+dKGP9bHH0pMuggA4HadiSNNn57zMHK
	lMeUGi1Y0wju413lYkiGfMhDKxtevuIs1wMonz0VFiy4SZOf5UYKUY9zMxxcyBQl
	UOINnj62izlqcXDM4dDCbmNn/YL6qi9CEIUrFd/rT75C+1wNgVzbcn/fJcuMRbXT
	DBfNdhFNvZVTh+Gcx5aMNtLE3PdzC7itYFvMQZQED58B60AyCp7qtbfm7GAkLUZV
	5M4CWy9YVyZc8FNQpfvONuxaG/SIN1bk1xBCdlrGOgqWE15xfC3NWhzW8ZTspO+8
	sMyFQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44xc24r917-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 15:25:31 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 20 Feb 2025 15:25:30 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 20 Feb 2025 15:25:30 -0800
Received: from wd-ubuntu-24-04.marvell.com (wd-ubuntu-24-04.marvell.com [10.111.132.113])
	by maili.marvell.com (Postfix) with ESMTP id 2A2FA5B692F;
	Thu, 20 Feb 2025 15:25:30 -0800 (PST)
From: Wilson Ding <dingwei@marvell.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <salee@marvell.com>, <gakula@marvell.com>,
        Wilson Ding <dingwei@marvell.com>
Subject: [PATCH v2 4/4] arm64: dts: marvell: cp11x: Add reset controller node
Date: Thu, 20 Feb 2025 15:25:27 -0800
Message-ID: <20250220232527.882888-5-dingwei@marvell.com>
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
X-Proofpoint-GUID: ZhSG1m-If48OwYoUY57nWW1XOUcCtsvo
X-Proofpoint-ORIG-GUID: ZhSG1m-If48OwYoUY57nWW1XOUcCtsvo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01

Add the reset controller node as a sub-node to the system controller
node.

Signed-off-by: Wilson Ding <dingwei@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 161beec0b6b0..4cd900c02b3b 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -273,6 +273,12 @@ CP11X_LABEL(gpio2): gpio@140 {
 					 <&CP11X_LABEL(clk) 1 17>;
 				status = "disabled";
 			};
+
+			CP11X_LABEL(unit_swrst): reset-controller@268 {
+				compatible = "marvell,armada8k-reset";
+				offset = <0x268>;
+				#reset-cells = <1>;
+			};
 		};
 
 		CP11X_LABEL(syscon1): system-controller@400000 {
-- 
2.43.0


