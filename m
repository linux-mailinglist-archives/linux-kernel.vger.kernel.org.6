Return-Path: <linux-kernel+bounces-405247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8073A9C4F05
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB041F25196
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 06:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521B720ADC6;
	Tue, 12 Nov 2024 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ehEdCGtm"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F47E208230;
	Tue, 12 Nov 2024 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731394780; cv=none; b=C+cfAD00hbFvyVLj7n5F8QiOU3uRweWxZ7R9tWMdNLoghBzHvhHCoU1/qurazNcCBa4DAkgaXZNkKxUw6kxLAezA6xj2LVFiPRFJZWGk00CZJyItIbWTQvzQo3kxl7U6Zfe7V5CHcDoN6r1r30ktKM4Q6k9F9KhcthAr/+JD18U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731394780; c=relaxed/simple;
	bh=Li0wIAtUQswoLVhPn75I6/mRc9FjMLJ+r6ZiOmHF4hc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KddX4ytnV+v9QREkLM6FwyZdLMtza0C2VUuAXs67YhPs9ZSSR3TiSMAtvD757KPlSd2y7ViKGFZRw5wrE5P7x/GsE8RIJHSOicnq3ho5zvdYYq+Ggh7Pt1VvU9g31KlNhOAsUadcnITexkpyf+2Oe4YPmthiuJo8fA7loragXfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ehEdCGtm; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC4LeWo031428;
	Mon, 11 Nov 2024 22:59:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=6L0rlNbqaOU8uamcn+aeH4k
	gFTUj+lf0ZzyEFVtxGLA=; b=ehEdCGtmMG5S7Ro6OvDe9F7udHFCMoOd1MulmF4
	T3d4n4ULUSWX5GcqN+FiE0jHgYdnHxtb1Ii81UvPrNwULlwMNfrQ7B3gnfB9U0Ib
	n0sSK/UWwOKyfWGntBUA+erqzq/AOvurmC9AFg3lOEK+/bKuPoqOUzVNIWTlf2uf
	x+tOV70l8DMWAG8t/Y0Ave7ql5TblvA/VzIZ2MWkE28McMowLgN0akJi04pXjNvx
	znpu1F56J2ROHwPilFc2gAPvPuaKmKVXcIDjc4TQ90zVv4qj87SMgmvw8sHY6Qvv
	aAYXnMNWDPaceX9PDQIrIkiAlisgKPyneooNA1jclUqROtQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42un9d1c33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 22:59:29 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 11 Nov 2024 22:59:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 11 Nov 2024 22:59:29 -0800
Received: from localhost.localdomain (unknown [10.111.135.16])
	by maili.marvell.com (Postfix) with ESMTP id C10F73F707E;
	Mon, 11 Nov 2024 22:59:28 -0800 (PST)
From: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
To: <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <salee@marvell.com>, <dingwei@marvell.com>,
        Jenishkumar Maheshbhai Patel
	<jpatel2@marvell.com>
Subject: [PATCH 1/1] arm64: dts: marvell: add pcie mac reset to pcie
Date: Mon, 11 Nov 2024 22:59:26 -0800
Message-ID: <20241112065926.756315-1-jpatel2@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 8Rs00MHIRqTVmuWdGVCsUnxvy8T3NJIz
X-Proofpoint-ORIG-GUID: 8Rs00MHIRqTVmuWdGVCsUnxvy8T3NJIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Add system controller and reset bit to each pcie to enable pcie mac reset

Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 7e595ac80043..f5aef6a23f65 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/mvebu-icu.h>
+#define CP11X_PCIEx_MAC_RESET_BIT_MASK(n)	(0x1 << 11 + ((n + 2) % 3))
 #include <dt-bindings/thermal/thermal.h>
 
 #include "armada-common.dtsi"
@@ -547,6 +548,8 @@ CP11X_LABEL(pcie0): pcie@CP11X_PCIE0_BASE {
 		num-lanes = <1>;
 		clock-names = "core", "reg";
 		clocks = <&CP11X_LABEL(clk) 1 13>, <&CP11X_LABEL(clk) 1 14>;
+		marvell,system-controller = <&CP11X_LABEL(syscon0)>;
+		marvell,mac-reset-bit-mask = <CP11X_PCIEx_MAC_RESET_BIT_MASK(0)>;
 		status = "disabled";
 	};
 
@@ -572,6 +575,8 @@ CP11X_LABEL(pcie1): pcie@CP11X_PCIE1_BASE {
 		num-lanes = <1>;
 		clock-names = "core", "reg";
 		clocks = <&CP11X_LABEL(clk) 1 11>, <&CP11X_LABEL(clk) 1 14>;
+		marvell,system-controller = <&CP11X_LABEL(syscon0)>;
+		marvell,mac-reset-bit-mask = <CP11X_PCIEx_MAC_RESET_BIT_MASK(1)>;
 		status = "disabled";
 	};
 
@@ -597,6 +602,8 @@ CP11X_LABEL(pcie2): pcie@CP11X_PCIE2_BASE {
 		num-lanes = <1>;
 		clock-names = "core", "reg";
 		clocks = <&CP11X_LABEL(clk) 1 12>, <&CP11X_LABEL(clk) 1 14>;
+		marvell,system-controller = <&CP11X_LABEL(syscon0)>;
+		marvell,mac-reset-bit-mask = <CP11X_PCIEx_MAC_RESET_BIT_MASK(2)>;
 		status = "disabled";
 	};
 };
-- 
2.25.1


