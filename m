Return-Path: <linux-kernel+bounces-547644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2E4A50BF0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2048E3A4974
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E8D25525A;
	Wed,  5 Mar 2025 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="OYvNPBIx"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11011013.outbound.protection.outlook.com [40.93.194.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D44254B0A;
	Wed,  5 Mar 2025 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204225; cv=fail; b=BH0M+/gMoOAxkWCPeFwTkXPvVVtDXNd0WOabzmtAjfTDlUBYz8g05FVDS4CuDXMbd4HnzBMnGe+KMv3C1tn5P2PZEXt6yegTQY4NoGuXbv752J3r0Di04RtbEL2+mc6xD4OjZvVt9uRS6TrjR3qekmIhhaHarWCTAjwB6CAG94c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204225; c=relaxed/simple;
	bh=A2fBfUE9KdRPPNxErMhf6LFXn26CF7wXDcN0BklppTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GzoyF39+mZn/vcnAHKQonAzvuKEzSnNpkttk8bIdgFTtsSWMbIyP//HzNSDV5zH29sresBtmTp+D98/jgmdLzU3K7ScWPfj+zsJ31ftrawjdogk/zXcNia4IFQGgLvirvzg24sjKJ6KKNRKA12Vpfm42V3d8okKSXdmrLDxSEIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=OYvNPBIx; arc=fail smtp.client-ip=40.93.194.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOF4i+ZVpJzX9kOTqcOeXhvhIwByodh3YE9GWatyH3Mqswq0icJEFz3m8ZQQc2+zNdlPGQMsu//XWiKdS/3Z/nXOBB6tKwXLw6hoVSpgbwE0ypQJsF9TKqdYagyZxIt67fleCvai2HQrHWExlvszIFMz9KvSRTLiUfZHBBYwQo+Y1rGcomKJhC4tokTXS9sKMllcqO1henBSsWJCQjtTqjhttC4CFb47YB/MFSzXrWWjI814H3E6oEQlNBKNJAUfbELhL7wod6O7yXTKEpXa9/GPewbNGsddEU+F68olMfdbvDZgXU0NIrLJK3wEd48+PjKcS3GHVVsKoNdf7YGsSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSVSgeV/tM4u4BMKwCSQB2g4qcnUmOaWhQnoQqzDT2o=;
 b=ibR1tNoEbAQ7Hk+ymXdQgMUfbgZtSl2GT0I7XIdAJXUfbmPyMyefYiWHAUgIPErZNg3yfgpu6yhgvTvlJo7ho6+XUlvBmTsmNG3zUftKGOAsh+UBj4ampbCzj5P4hb4lDQhTCiSn/1T4piNefosdAeVrQW1ScBQT5LnP/Cnsd8hsiE8qA/FEg4PPKtxtCDixg+aFFIdzQqhYL5q7m0xrfmujDftzuZBJeOAqZrOJdtfnlQ1sm3TU0tDwZZOouuQlzuBiNyK10LvkcAs/WKnhOyWU04MM1jXFWUivM0Hdl/aVjXHFtNuPfM4W0w+pLmCKQpXVBS2AaefR1nczLdFNwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSVSgeV/tM4u4BMKwCSQB2g4qcnUmOaWhQnoQqzDT2o=;
 b=OYvNPBIx5iFJC9QZC+EfjpkQFPxIhfwhMSCjTaz+RzKJ9Lz9NQ7e/30+lgn4Sh38yePlJHWhLDVS+hgJpF2byH6ELNwV2GMW/EP2N1UOMbF4s+P+G8iMYLYlbKZ7t7zLWYPXujPFqh/XHlQB3cVWIphzs1X0CMVBYlDI76Rd6jXJdZfYSD6AD2h2ZvBx8f3VY7sViqYFuriHI/NslJ768eP8UjJ6gPUIS6zA6x6fp5JjZObA95SKPpaRl9kAkBgMHicKjOZZqLqo/Wcw5sgDyGtofkZWFs2KA2BvJUNRaAOV3e0rKAbNnd8fa1lS5pbzNB300gP7nKXPdvMh+aeb5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by PH7PR03MB6972.namprd03.prod.outlook.com (2603:10b6:510:12f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 19:50:20 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%7]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 19:50:20 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH 2/2] arm64: dts: socfpga: add Agilex7 M-Series SoCDK
Date: Wed,  5 Mar 2025 11:49:51 -0800
Message-Id: <20250305194951.7226-3-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250305194951.7226-1-matthew.gerlach@altera.com>
References: <20250305194951.7226-1-matthew.gerlach@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::34) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|PH7PR03MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: d6bfd41e-dd07-4b9e-4f34-08dd5c1ef2ca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZIcHts+UCR7ik+9ldoUoabyFczWMAmaCoSFJzwQyvL/ZWDzW5iQs8DAjiJNz?=
 =?us-ascii?Q?Im1UJvicvXQVwGUsbPBAc9MgFU40o36htr2ZXOBSBT0PfWn98/YTJ9ulM9Ti?=
 =?us-ascii?Q?9Po76I/rUBHqLLHPCLJo6jn0UpIaYsA9KMFpBmh/fozt+hNq/BHDAX8wk1iO?=
 =?us-ascii?Q?oxWfiE1gJX+EEbj9FyVL4639zmofo/kyI0vM3kKodd5vS7WYh9KBWZVmoReN?=
 =?us-ascii?Q?yUp0PS1lkBVutYUH2nZOYAA49BkypfLAXo1VPh6JyIYbwPS/cn2xddghHfgv?=
 =?us-ascii?Q?nM7fwdAYzGuTcQ9Md0aSBxuStW52db9KMdXm9G5yh+iFpWQogcMDB9R5mZ54?=
 =?us-ascii?Q?tbOVmWNE2eou8A2d8Jig5oj2weURF2rX3Cmqm+ghQR3ejxjBCI5WpWOEtQkj?=
 =?us-ascii?Q?rMf+kAGhIIN0jbEqpKPsQ+BrlbBZtQPLsNjFN00/lMeHQzqpng1HEQ3i18Ld?=
 =?us-ascii?Q?fNKBCOyL+AWWVNEIpxFcZAhlVlQniqg9jNISBMJDWZ97lmdPQJeXRYXMU2yZ?=
 =?us-ascii?Q?riRAZ6aUhN9dwwDBBQ/Yte5uulYNe08LI7/+qYJOhtdCK+JAwNAV6w/lOvjO?=
 =?us-ascii?Q?Vb3kfGajxCfCtgkvMzyFLlrlul1ebJ0cHOu0sdpieB/sVlZZXswkpGSHSPsp?=
 =?us-ascii?Q?nbw70Pvoy5uSMkdj1iU1XbomZ/vLLfOd5P4Y9e4LVl7nT4Mr6KKR+RqezxEk?=
 =?us-ascii?Q?PJm4CnT3bDxj2yZdR3jARHerDQyNE1u23nFhBGLB5rVr0WMLT4z317m+uhZY?=
 =?us-ascii?Q?OhVOWS8RvoKkwq4Ba7wt4xErIljWH0PkOAYm+qzNRsG/G5euZc9tI9GlIQLn?=
 =?us-ascii?Q?Q4vJdaSC45XWkxRIkRD36DQi1MTSKCB/GGGgccJMKtG/z7JbYtGK+yOcUX+h?=
 =?us-ascii?Q?Gzo4+NXFkYhn1RMhOlRPzia7L/oZF2JgEgh63mmaooIib8+UyxBn8AX22E6I?=
 =?us-ascii?Q?/8DWz0Yprq3hqtXAmSUo0xq6x/H0W0KaxfSSuw3UKSShHh4m6JXp0R1tXuqM?=
 =?us-ascii?Q?zYR12Rz6xS7W+5AhyMIlfuzE9OdiPRN35dKPmsbsTVVtl/2R5iThQRxIis0l?=
 =?us-ascii?Q?3p4TvlY5t+LsJaE/uA5FbKhapT7u22v0XQlCG3oSJmonoJlS1fJOqMxzqqSk?=
 =?us-ascii?Q?nK7wBMwINoVXaBqTfBb1u5mqTeyA2BgHZkbG6HJWrKoPdwr32HxCT04vLEM4?=
 =?us-ascii?Q?jZAsLV4NlDthxcrxy2L7P+MTH7Sx4BWGJ2m4hAAC/tfyMvDgsqBANmTsZtDL?=
 =?us-ascii?Q?CGzVQ0YYVw8n1uQxGXmSYFEcvbbPSSxl5DbB/bT2u8AJWnnDlEiZJG8HZTrY?=
 =?us-ascii?Q?oxIRzg1/4kQQMF24G9l7rRGkUzop9uVoyhntHDuRdSIJF+ruMz16bj3meKfH?=
 =?us-ascii?Q?x+IpgUYk+G6C9qSVMbWtWrkfjmDy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pDWFzeurL0JXHEQ1TZtdH9f/YAK92BWfkHM3LOogWB/NCyvoO3NRiFf19CH0?=
 =?us-ascii?Q?lRG7gkwF6LR1GrLk9s+vNA3blGrL4E02Yz/UKkzKmnG+0PyKk++YZEc7cMco?=
 =?us-ascii?Q?2mmnmsrYkI+V7RiZqyHac6GOf+ojjUj3nC1V54aJiZbkkEcSZ7kgjkKNGfwk?=
 =?us-ascii?Q?dIqQ2jBGYjRzcy8Q1ghqtee+9n8CHufYV+zshNYq5VUOTOafnoi5vzUo4ul+?=
 =?us-ascii?Q?K6Ik+X1+uTVCvq8T4Ptrso4RyIuwigRGW9dCHD7PLUDS14OtOm1e1Ldf+vcH?=
 =?us-ascii?Q?INjnkB44/UpeOCFCJnYcwIfWynPxQISRBBdWmO0aJ31YhTd68QyxtoC7ZJSw?=
 =?us-ascii?Q?7DIka8TM7ovHZ+M7rDq2CaDmH6is68SzizeETlsqCb60/JCghFETgWTJkKpX?=
 =?us-ascii?Q?cFQO++391sYhtpnqMSmLqtc4aYmankRwdZMQGKYmO95bbL1o5ZCJzePoJ5VE?=
 =?us-ascii?Q?LWf7rihr9AnK0pYAtjpGcXDstRr6TTUOZ0S8PeD3bs8NC97BjyZ5JEVi6viI?=
 =?us-ascii?Q?7BdYJcC81MiMgqkkxHTVydM4iN8iys9XazP/uouoUTeSaSud6DUZVaBRydZv?=
 =?us-ascii?Q?BOck8FKP+3Ec2fKeBKZSsgm4QwbgoaFeqHyfUehuL8SktcaM3lOcpHO+6bwV?=
 =?us-ascii?Q?a847Jj6t/XvNe2DkB9mczSHoc/pZ3UkyTSwluhDGie79HGOHfx8GjKfWcBY1?=
 =?us-ascii?Q?aI2VhH6uWO9LFPjh04bpN1jd2GzsqIZhQVueSflNxevQDssuHTkRygovJHDF?=
 =?us-ascii?Q?aM6CuReMgvXMbzYX6jpm3MybnzP2PMF5PIzmYYhVI1NSaReGT5YO72CUOzNH?=
 =?us-ascii?Q?KfukEEVvo2Dja4+Bm5q4C/kDQCw517iaXONXIP/lmZl2Pk1EJ3sSReLfeM/M?=
 =?us-ascii?Q?VIq7B7Ny5mODFddhh5ykc/u7wvGBW7MWjf9X1ysQSbW9i7OfSg9XSWHaTrE2?=
 =?us-ascii?Q?hc/UwKrqKRm85HRO4P/9OayzJXzDzlpGcBkNi+tiG4HCdrYB+6nvIwYmEd9F?=
 =?us-ascii?Q?EhPUYvrg+TNiXNel1/5cakmdn6wVRmuNvtxH45nrEKHIP9cClGBdRwbg0ZL9?=
 =?us-ascii?Q?FSFKUJehxf9PhBtpQQ4+J8Zo2Ae7/iMWVXJE/iHNUdK8vV+zAnQ2Zjj/k/nm?=
 =?us-ascii?Q?cZ3Y8cspiySbftbnmJ78D2OtSihGDkh6BPLXXhLc8qB13GUIYFn+VBuROOir?=
 =?us-ascii?Q?CaMJVLVcAmqLTNm35ayEYO/2uMF7EudgDWJVUAW+361GroNOWPRGR4vy76hv?=
 =?us-ascii?Q?ICl2tG9hTLuFFQwNIEija6BgauFssy+POElhOxKQyG2BbcI165H8QqSQgdy+?=
 =?us-ascii?Q?KXgsRCWyD/iKgO0CI2voA9mxddjaqR5iHwsNvR9wGsnnsZ2boUYPiw2RGrTV?=
 =?us-ascii?Q?66AM819/vXFyiGxshWdXNhJUVFMaobCUxwbbrJdKnitXa6+8JrXq6w+CShx/?=
 =?us-ascii?Q?ikn9FrRHL9nA9VjviRwRZeQXuWUhvDBX42+bAj/eNLinFBHi9DCtubv7zEVE?=
 =?us-ascii?Q?voCmWQSySEEQHnZfM6k9R7IvWYwaZdyfdHssPzYNmWVxWmxxu2KVGUpSClQu?=
 =?us-ascii?Q?ig/Rq4QglLfz9XbuHO4JSOhGw9/EKoKZvQpCJ+3dqXM4eGbysxgEjsbGmYK3?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bfd41e-dd07-4b9e-4f34-08dd5c1ef2ca
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 19:50:14.9658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /F7J2ioy+JTyq5NSQJOYldV+AgVvqKQw8nOgXVyFLO9JK6sJUVB3s0E33764ncVmkB7nz5ZSbivSiTBUl3D7WYUkhUfd0SzOQbFs6Wj9cWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6972

Add device tree for an Intel Agilex7 M-Series SoC Development Kit.

Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../boot/dts/intel/socfpga_agilex7m_socdk.dts | 108 ++++++++++++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dts

diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index d39cfb723f5b..5eeaab890d9f 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -3,5 +3,6 @@ dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
 				socfpga_agilex_socdk.dtb \
 				socfpga_agilex_socdk_nand.dtb \
 				socfpga_agilex5_socdk.dtb \
+				socfpga_agilex7m_socdk.dtb \
 				socfpga_n5x_socdk.dtb
 dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dts
new file mode 100644
index 000000000000..6e970e916342
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dts
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025, Altera Corporation
+ */
+#include "socfpga_agilex.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex7 M-Series SoCDK";
+	compatible = "intel,socfpga-agilex7m-socdk", "intel,socfpga-agilex7";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led0 {
+			label = "hps_led0";
+			gpios = <&portb 20 GPIO_ACTIVE_HIGH>;
+		};
+
+		led1 {
+			label = "hps_led1";
+			gpios = <&portb 19 GPIO_ACTIVE_HIGH>;
+		};
+
+		led2 {
+			label = "hps_led2";
+			gpios = <&portb 21 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0x80000000 0 0>;
+	};
+};
+
+&clkmgr {
+	clocks = <&osc1>;
+};
+
+&gmac0 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&phy0>;
+
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy0: ethernet-phy@0 {
+			reg = <4>;
+
+			txd0-skew-ps = <0>; /* -420ps */
+			txd1-skew-ps = <0>; /* -420ps */
+			txd2-skew-ps = <0>; /* -420ps */
+			txd3-skew-ps = <0>; /* -420ps */
+			rxd0-skew-ps = <420>; /* 0ps */
+			rxd1-skew-ps = <420>; /* 0ps */
+			rxd2-skew-ps = <420>; /* 0ps */
+			rxd3-skew-ps = <420>; /* 0ps */
+			txen-skew-ps = <0>; /* -420ps */
+			txc-skew-ps = <900>; /* 0ps */
+			rxdv-skew-ps = <420>; /* 0ps */
+			rxc-skew-ps = <1680>; /* 780ps */
+		};
+	};
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&mmc {
+	status = "okay";
+	cap-sd-highspeed;
+	broken-cd;
+	bus-width = <4>;
+	clk-phase-sd-hs = <0>, <135>;
+};
+
+&osc1 {
+	clock-frequency = <25000000>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	disable-over-current;
+};
+
+&watchdog0 {
+	status = "okay";
+};
-- 
2.35.3


