Return-Path: <linux-kernel+bounces-514478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B7EA35783
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D053ACDE3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B250A207DED;
	Fri, 14 Feb 2025 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iVoZvPyO"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93002054F9;
	Fri, 14 Feb 2025 06:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739516379; cv=none; b=lf0vk4Xz2drakAZxTuvbDuLVnB9wntCxPQ0l0c0J515zF6h4y1tLdb87tFH9EHa9W8k9GCLUzaRmzNqSoSmW8wf8iXQlvcQsGAQEIMpKHwA3pS9j7gYnC2NZdU4UhUxwBj7i5ARyg5qzCgGMQgIGBDdR8w9O9RNUeAvP4q++iDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739516379; c=relaxed/simple;
	bh=6RJCkEJOTQ+9WOXhz16VaQjspPm76n7dlp+/1rHiQGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fn2AvqcM79LNw//wj+OSJHswMxEacsl7I1WJD8Pc7OwjTOZVr43SQgN1dxUah+Dha8zblWW6bFyuyH6qipwIoY6BoAC5yHSsYXLC8208zeaZTI1FHFAdgnl3GJZ/yZRKFHziFexb7S3wnziQyw6lLSYqZIf5Id43KY5osE0ri1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iVoZvPyO; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E5nqka012347;
	Thu, 13 Feb 2025 22:59:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
	MLO/iCmOTSngQQNsGrK0MQ2i9rDTojv8dggzu/KvcQ=; b=iVoZvPyOX4Mc48EsP
	y5jXce9IbS1KNO4Kbpjzjpw/u9ZhFTXNvU8xB+JwPQOsM30s3vytvzbXjBgbyutb
	Gp+n8+5rIpHNVPhq2PWvIB0TIRNa8UAwQwvSDxpfT63BoXJ2RLz2EyC2qvwDY3UU
	6mknYtRZNpCHQz5b9MBsCL8pgry+zcsWkRuuEJgcs/EWaaJPMnXLEptHenbkxaE7
	ViGEKYs5TyAQRQzcxtASiu3dcKqIAfS/astCSAxAifrPrjrE9tN7+byx070raF2I
	HxY/o3iA61AKsl6EYpmk+pplp7uhvu/WzPFtpsj65PHHDFLG0flxEVBVhpjVhXmB
	eLpQw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44t01f03fa-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 22:59:25 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 13 Feb 2025 22:58:51 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 13 Feb 2025 22:58:51 -0800
Received: from wd-ubuntu-24-04.marvell.com (wd-ubuntu-24-04.marvell.com [10.111.132.113])
	by maili.marvell.com (Postfix) with ESMTP id 206103F7090;
	Thu, 13 Feb 2025 22:58:51 -0800 (PST)
From: Wilson Ding <dingwei@marvell.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <salee@marvell.com>, <gakula@marvell.com>,
        Wilson Ding <dingwei@marvell.com>
Subject: [PATCH 4/4] [PATCH 4/4] arm64: dts: marvell: cp11x: Add reset controller node
Date: Thu, 13 Feb 2025 22:58:33 -0800
Message-ID: <20250214065833.530276-6-dingwei@marvell.com>
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
X-Proofpoint-ORIG-GUID: UucUwbdaaezb49L7FSoaz7o8m4tbpU_3
X-Proofpoint-GUID: UucUwbdaaezb49L7FSoaz7o8m4tbpU_3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_02,2025-02-13_01,2024-11-22_01

The unit soft-reset configuration register is part of the system
controller register.

Signed-off-by: Wilson Ding <dingwei@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 161beec0b6b0..b82003df15e0 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -273,6 +273,12 @@ CP11X_LABEL(gpio2): gpio@140 {
 					 <&CP11X_LABEL(clk) 1 17>;
 				status = "disabled";
 			};
+
+			CP11X_LABEL(soft_reset): soft-reset@268 {
+				compatible = "marvell,armada8k-reset";
+				offset = <0x268>;
+				#reset-cells = <1>;
+			};
 		};
 
 		CP11X_LABEL(syscon1): system-controller@400000 {
-- 
2.43.0


