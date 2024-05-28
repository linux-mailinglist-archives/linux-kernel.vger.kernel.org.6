Return-Path: <linux-kernel+bounces-193206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19E78D2846
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D081F27590
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC0013F42D;
	Tue, 28 May 2024 22:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="LDlLfmq7"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2139.outbound.protection.outlook.com [40.107.223.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0FC13E3E5;
	Tue, 28 May 2024 22:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716936715; cv=fail; b=g4zSO0RoYKuzLPKrujIP3uzV4fn5Adh3MdHh+vxu3+WxaEng98L1z+/kyqwLshtvkvpRt/kV9kXVw3vLP3LqKs5p0KRsDA0et9UjKD1gvyXxtWsyE/zphb0S5X+1JUHUz5c8jDQTqtIeyT5DKDXq8Ngq8yEWeVOLAwchRn3i2tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716936715; c=relaxed/simple;
	bh=Sx3ez1MUQv0iuXwl/BgYlT7Le4hEPTFOuIQXe5g+kz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c2dvNbrqqTM4wdetLrx8hvoHP2VIyoPGtB+zd4Cv16Jk9Ov1Ag5DMX01YM6eBOGW3wWLDq6eF/gnqRW1Q8ZeO8P6l47CTYwZNrqB534I8opC8SUi28Qaibn4TROHNeEkNlK3uuMR3i4qozBZMBUtNxPmaynQKb3umAv8QmwP8O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=LDlLfmq7; arc=fail smtp.client-ip=40.107.223.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVajdtGJZ3R+wLPZD3fRk79YF3SO8srIagZJ2Kse26V80lzZD/tZ5ZjhTqBNWU4JlixD9Y+B8kadU96piWRqt4wkSyvpIyK+NtwVZKon4MatQ7B4MJ4oI7YkXOIJyAi3vU/6QhPwIfmGkLZVxdcMjVsK85PjEAw1KI84AyWvjWe9JI8TZrRtfTpnm7t77WSc/CeLUG9nCOH3KbTnwpnSEC5F12gS4ksqVJirJ771BvJnEfHxmtCaBUSZ0YCVqxqS156wWqtGCE4WIHRJ02HTFFBWxzcRNI06IAx2EEUjOchgZsWVJIHAm4dgNaO/VRBluHUfsg1VXh7AjULH5I/4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbA1oTadcfU3mhreyQDa1AbeUaNiy9gL+x386y9dSTA=;
 b=dNka/bnQOw0Xc0W0dJKS2xxr9ZNtlLyt5qFCsufCRFPFYsbqq1PqcmfJahn8BOSGmMWe+lhin+teZ69NDrs2htnTKXbT+BII3ZPAUur6pb3XzpCAkVQweCJh24K/5ONtJooAxNdIKoBER4rSCSt2cRKP7opmkWCYuRsVirmvyr+MPB9m+CvgIMBhu03QTyxGnuFL+JHzf5Bx1wtWkAsMOt4c4OixH2xRNKgcjH6j9w+aCg7Uj+PheiEAjTWwib/MRAGUMht142YL1dQrpBeeQuuTsT88b/JBDBoTDVL5+xb13xNSXVR34iuUfG93aufxiEVQ039ax8xGxHFos6JNIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbA1oTadcfU3mhreyQDa1AbeUaNiy9gL+x386y9dSTA=;
 b=LDlLfmq7yGYz8Abd0jfZESZjdbgTSS8nMBua/4oLb0YiUFiVTshvqOJ8pJrxl0iJ7d8JN6DPK62tYtZ8Io8AKxa4SxxZkGr8NLWkOs0OHEP9TwwXrFdXOSqOXIOvS6patRVxFghN9mz9X2/S4pzTVp/5tOkP0Db+C3rMYHR0fkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by LV8PR22MB5026.namprd22.prod.outlook.com (2603:10b6:408:1cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 22:51:51 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%5]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 22:51:51 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH v2 2/4] arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable eth phy
Date: Tue, 28 May 2024 15:51:35 -0700
Message-Id: <20240528225137.3629698-3-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528225137.3629698-1-nmorrisson@phytec.com>
References: <20240528225137.3629698-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0049.namprd07.prod.outlook.com
 (2603:10b6:610:5b::23) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|LV8PR22MB5026:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e725dbd-18bc-489b-4c23-08dc7f68c35b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|52116005|7416005|376005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aZ5xvQiNs2a6ZXncUhL0Ds/uhtlycLxpwj3muLHKlEapit7s4KMaD1rCfRDB?=
 =?us-ascii?Q?d7FFqjOjk32/OjHslkw1Yc3Fr4EOne67FRRMsWaNl3uw6R8hjYRn2flniSwX?=
 =?us-ascii?Q?7uFVcVBWdkkn3lV4qKuLsg7yGI288PjJXVIrYo27eyPeP+cRKZ2QRqwH4tqp?=
 =?us-ascii?Q?MeODmZbpO8WZ17q6eJCQRQ2JRF52MAJKRLqw2n8zKRRGab0s4aPiLhTLgC0L?=
 =?us-ascii?Q?kFcRpdmmcqSUoCTKaMkZMQuES6A/Bq5nD3+TgYk1CCZoqqhFZTShq6ydQ8+J?=
 =?us-ascii?Q?MYHw0JvS3N2tfrO/e3kMsBM/ag1EnK88IF5ZQ43xEaUsvrbXU3zEDYQXZBMg?=
 =?us-ascii?Q?PNJ6Wn598q9xwsxipNQAtrk64OY0mfuItMFo6zM3k/jvUNjDDzEfap65+iRp?=
 =?us-ascii?Q?WezzBa6EhKWqK+7siOyb3pC9lcKUfg8MqaBv1g9k2FmqNLA04AFZVS86hzrM?=
 =?us-ascii?Q?3KDWT/0nZrJRRGbZS2uEXIlEOOG67ZCgZVtUGCqyoIdT+LlXQnmnSYGrhoZu?=
 =?us-ascii?Q?0T3v69rcu2qWDCwyCknCZcvDj+0/IYUmndDghtt/PGWcmA69hl7Nzt4rHpPR?=
 =?us-ascii?Q?NVxDE6zL0jmQIGYTRpm3tplrPWxwF/qJgOkfwqZoBC2uAsvipeYgT605aHLA?=
 =?us-ascii?Q?j5oUQ6y5AxXYmnx4FERa0IlxGJLka6dWjxKrNjfsszASW7Ah1G1Y7xapaP6c?=
 =?us-ascii?Q?gSHSujty17eP2MQUEWeqTlRvdEm7XClKBBD3EATwHDn/bZL+YUv0k4zTYzoQ?=
 =?us-ascii?Q?h4rEyxojg5kDQek7QvuoXCSF+mkqpfqdWaOyYuCQPKiTHjjtc/3Igdu/uR0g?=
 =?us-ascii?Q?+OXqVa0fbInev95jfOrdCUVkjYvsJmQclN3Vfgc3pO2JCgc6nBzO5Vz4bs2j?=
 =?us-ascii?Q?rb02qYdev4AxAHwhDywcTXjC7bjWd4aRbIPdwOORdoZGzdP4aNXpRHPi3L/+?=
 =?us-ascii?Q?O0qcH1YnTy9mT1Im6ocNfp+/5/wp4eLFeJXNl7aUQ0BxRlqJMk21djURBlVe?=
 =?us-ascii?Q?t6s3RD2VZun03tfuDmrai4stXNVm354O1K00hMxgfPZB/urXi3fd8OCHuFnQ?=
 =?us-ascii?Q?pLF2gEn5hUlN5HRZ/mMkKmMTlF4lp7SHmuX4dZAHducsfPEz7NOAnQDoz3II?=
 =?us-ascii?Q?9q50VvHiBqt19mpl70cCDNft1qdWmjzuXGSZGbhvD49oKw7uPvTPVIhPGPz2?=
 =?us-ascii?Q?/g+yQHQEhmqFZID9Axc3/f92d7dROdxPJVtqiyk3n5IkL6zu4/itwre/iycR?=
 =?us-ascii?Q?Dw8inYSReN2ZasArbHj0RQ1QaDzxjyfsTyq0NHn3Pi3kfhwxuhmq5Ckr6hdG?=
 =?us-ascii?Q?9v5SGpOOIak5LtfydoBghsBpcGqbWcrnTn19HCYVL3zzYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(7416005)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zyTQ/gNDqet1Wr+M+P9gyOT89MfLaAwYFW1gQ/pPj9bB6OqtsDurOtN3VQgY?=
 =?us-ascii?Q?McpnhjLt++cLQb5S5VcH9JOxF1u3gGAvWBvRrVW5kP97uPpcRd8OxgT1pq9+?=
 =?us-ascii?Q?FmI2obb1Tkfr7FVDAqKuUjvxwUX76Uqy2S1+ARIHfbQfYLOZOXA6XOV8yjIT?=
 =?us-ascii?Q?rV8sMDx4vemyT45tYqr2XwbgXF5PDMSdu0zgK/OjPvkfMXvcijX1TiZGGGU6?=
 =?us-ascii?Q?42a/76/5bFxznHq9ka8g+UXcSwyxfJww502vjrRptr+bl0f6khWZAGaJXZBw?=
 =?us-ascii?Q?C/p3EvWJzrfHga+dz4qHyE13LhVUnmbnkrjokiIgIoL0n+ljXLa0QA7WyVhE?=
 =?us-ascii?Q?1KxS0jjLBg0Hu1+umKgXxjZLZB6x3IK1BK/FIrl59qlkoJLUvR5dIYg8zL8M?=
 =?us-ascii?Q?/IJZHsNz+9+6NQ3M9TdDZ+aFVN7qWOfavDJ+TNwQRS6v8VZ5PzW+EmNpvQHf?=
 =?us-ascii?Q?ENMnSlg2VfK+diWPZZAkOsZxhXMpk3cZIeTt3rKpdLMxMtDoWeBed1Pie6KF?=
 =?us-ascii?Q?j3PRyHPq/EMrg+hKbAJKrV8dbBlK4P4GDskFjq0Tz/kqxxb7geJ57ztWnoGh?=
 =?us-ascii?Q?KI+kuIhB6vylr+QLqFI1sBIB69NTjhXDxrsh2nUyVB/5FKRiLG1DQzGX/QRw?=
 =?us-ascii?Q?wO+BTIJh36RP2cIc9ZAirkbeqMvbQg1vmNMtX2ZqlktGIJ+FFNy2JluBlFBf?=
 =?us-ascii?Q?VW1+jZVht+HexF9NTPFqMWJDi2vTkU9LzDMHQv6hQZEwHAm/10QfiXR6K/DP?=
 =?us-ascii?Q?AOTiHFD9XIR+kDlKHTPzw1G6m3wpirlhLd8p7EBPHtXU4TK2H/mMmZ6hZXiG?=
 =?us-ascii?Q?yqHlNpvh1YfbVdP60O47BhzkNhWhCIvLVkh9pXYZTW7EmOp8q9lKCeyLbhyN?=
 =?us-ascii?Q?InHw15QXaidqPKuD4anPfg03P9PsYFLJqjbjsJXqmkdmVayHEC0aRoV6ko3L?=
 =?us-ascii?Q?h5HNtw5F2Sz8r19RLA3wxPyCJFvnxd5fZYe4uDZXCI7mpv+oSJjU2hrrUVow?=
 =?us-ascii?Q?+5+4JnXggQxjMkVVJUyS9bX6pCrfyB+y83aH1GHHwMIPJ3tI+BaHTOkCuqj7?=
 =?us-ascii?Q?xBEXxOMat6cFQyl8XP4PFSen9P0zQzykOK9tcdDKPrcbyMcU8IHWtc2mMefI?=
 =?us-ascii?Q?NWCksFR+5Rv0YkiE+yEgoohduUwfrkydztvP4KEBz+bH5D3fkEas4YpLeAd6?=
 =?us-ascii?Q?VNgBSJDc9bA/ag9cmOzWAjqLolk4fu8kfqnnAF/aokNRe3BhTIUwIsbT+3d/?=
 =?us-ascii?Q?j2PDU//3QPxW3/Sfsmw1Zibnnq7nH6j3hV7tFAZATLNk8kYX3dt/uNG0As/A?=
 =?us-ascii?Q?/CSKfMmyH6dZg330aLmtQn32V+TTwThKZs/qHj+P/tj1HCPYUR9xdLOwOXh+?=
 =?us-ascii?Q?wMmQX/U6QofnT90c8IDxiBkJSYr3Jy1k4mHW0fm05d5M71vjp2FrpjnzmUCe?=
 =?us-ascii?Q?8axgqd9O8Lro2DN8LxtX/2FU8QiZswLrzCU2iLm09FgvrhAbqR3krYXwhBv/?=
 =?us-ascii?Q?KIQqWvOSd9BO0WgeGg5b7CgFqqZbrR28vI/GepeYULUer0TKwVNX8u0Z1KY+?=
 =?us-ascii?Q?fXSwdpATun4QGLjdhO9YV3zEKUmjaUBdpuX6nt8F?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e725dbd-18bc-489b-4c23-08dc7f68c35b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 22:51:51.1666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wS9zhJLHa0bD0lBKtmnzJNq++UUXrKsQrM6ZxRDleQuV9ONEQXQjr5tT//j6ZoU0N5zy+eHJ0J1OxVDlDKr0qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR22MB5026

Add an overlay to disable the eth phy for all am6xx-phycore-som
boards.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
v2:
  - Add build time tests in makefile

 arch/arm64/boot/dts/ti/Makefile               |  7 +++++++
 .../ti/k3-am6xx-phycore-disable-eth-phy.dtso  | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 2c327cc320cf..320da5ea38e0 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -54,6 +54,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
 
+# Common overlays for the phyCORE-AM6* family of boards
+dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-disable-eth-phy.dtbo
+
 # Boards with AM65x SoC
 k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb \
 	k3-am654-base-board-rocktech-rk101-panel.dtbo \
@@ -107,6 +110,8 @@ k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
 	k3-am625-beagleplay-csi2-ov5640.dtbo
 k3-am625-beagleplay-csi2-tevi-ov5640-dtbs := k3-am625-beagleplay.dtb \
 	k3-am625-beagleplay-csi2-tevi-ov5640.dtbo
+k3-am625-phyboard-lyra-disable-eth-phy-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
+	k3-am6xx-phycore-disable-eth-phy.dtbo
 k3-am625-phyboard-lyra-gpio-fan-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
 	k3-am62x-phyboard-lyra-gpio-fan.dtbo
 k3-am625-sk-csi2-imx219-dtbs := k3-am625-sk.dtb \
@@ -132,6 +137,8 @@ k3-am62p5-sk-csi2-tevi-ov5640-dtbs := k3-am62p5-sk.dtb \
 	k3-am62x-sk-csi2-tevi-ov5640.dtbo
 k3-am642-evm-icssg1-dualemac-dtbs := \
 	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
+k3-am642-phyboard-electra-disable-eth-phy-dtbs := \
+	k3-am642-phyboard-electra-rdk.dtb k3-am6xx-phycore-disable-eth-phy.dtbo
 k3-am642-phyboard-electra-gpio-fan-dtbs := \
 	k3-am642-phyboard-electra-rdk.dtb k3-am642-phyboard-electra-gpio-fan.dtbo
 k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
diff --git a/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso b/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso
new file mode 100644
index 000000000000..356c82bbe143
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2023 PHYTEC America, LLC
+ * Author: Garrett Giordano <ggiordano@phytec.com>
+ *
+ * Copyright (C) 2024 PHYTEC America, LLC
+ * Author: Nathan Morrisson <nmorrisson@phytec.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&cpsw3g_phy1 {
+	status = "disabled";
+};
+
+&cpsw_port1 {
+	status = "disabled";
+};
-- 
2.25.1


