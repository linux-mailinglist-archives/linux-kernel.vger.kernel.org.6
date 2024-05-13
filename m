Return-Path: <linux-kernel+bounces-178156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DF08C49CB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 00:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017C71F21F67
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2792F8529A;
	Mon, 13 May 2024 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="FOujYKQx"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2107.outbound.protection.outlook.com [40.107.223.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCC784D3E;
	Mon, 13 May 2024 22:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641030; cv=fail; b=flf7sWwVwA4kadYf7OKXb8sGAcuLsTrnnibxNCFGMiGVKE/oQ2cp5R/DXUlKOWm8r5YNe7V5PpIUCs/Ia+rNKX+/mzjlSolWk1SN5sNDy88bKKH7ji+Tzu2zySiYV69TMdqdWIy4k/V2YFjNGMgWtk8ZOp7YxKdcVBcwtwZ93s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641030; c=relaxed/simple;
	bh=92o05XhxBdo4lU60uz5b/EMpCvr+5C1zor2RRcYsIA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gR5MgQr534eRqjJgn4vr1Hw80oR/tPXYwZtg/U1gA+BUr4L7MwhxB61kDQeKhrw9P1Is3vnDdlBq+pQSz6leOC0fexiJJQS55P3eln5tAissfrwp4AuR0bu6yE/LT+u8j2ylnxqjXn8UW4K+/Y62AiV668i3ACurwaMxMxL6b4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=FOujYKQx; arc=fail smtp.client-ip=40.107.223.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQadqOQXIRk0zoiXBFIUPf07ERuTVE7+ESbZYJNSs63CZq055nbIfOTAUkvmg21fYhfjIlrBx3l6tfQRljJBl4SlIA5s7f/30a84nQWnXUoO/Rfnn302zEb3TTUZSmBKaaCzyJBtIpLZX08d6/At0oOUa5RbAi6mzLtDxjF5SY8gzXPnlp83pZ0FATmeg2PyLIqskpHrWxdCdlnVP7W2Vbadmrxg+9/vlT9tbK9IgMETRATasPbQmYsrtaCZbQtRAvDVJ+7l/8506bnCwSePWj8GnNIDIJnD7esu2A4esI1CZZPswI2CILGpEddu3Io7vqKGxbjUO0CHhst0Oe6iag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8r2XD9gAG03HKC01Q/Ah7dPAhRvOk9mQ+/8pHuwNgA=;
 b=gPZbmTaAoIejftlo0xcl4lMEWzYSJ1VFs3Wad8s6WXWVCiGZB/G/CY4XixR6t9onPca0oZp4X9FNHylzDNywO8a6w4pm6gNJI29yUolYzL77Cp1i+VDk5XqZuhGFZwLj4XZ1JeJ8IpyZtW2eV5mejjbJSdqb8eGYbPCOMMMVvEo7P/zpmpxctQ68tXiiWCwCCzT38VQ3alFO8s3TAKBkT/Q/sczF+1FxDXOIcmpSdLjeR2L83Cc36OsBIbsYzLTWRYKBixGjwiqf6NqA6gkJ75j7jPJah6fanKZ8ZcDf77JSUEeTBXZ4/zMPU5k85VZD3PjPR18dvJDBnEVSmYYyqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8r2XD9gAG03HKC01Q/Ah7dPAhRvOk9mQ+/8pHuwNgA=;
 b=FOujYKQxHn5zbNow/3hGzF65NA8jLejhqf9DoGvxXamOVYiYQZiWun3jnwVqDSfm5tv+r9s+Db+pZLb9Y7hNX66+AX7lrIWvMbMaVZyZx9rEb0yzuRIvPlvsSDT66qzo1z2dgIhy8JIouInrXAtM/VMlLN8Uy4wFZV/62Etz4p4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by MN0PR22MB3668.namprd22.prod.outlook.com (2603:10b6:208:37b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 22:57:02 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 22:57:02 +0000
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
Subject: [PATCH v3 1/2] arm64: dts: ti: am642-phyboard-electra: Remove PCIe pinmuxing
Date: Mon, 13 May 2024 15:56:45 -0700
Message-Id: <20240513225646.3603803-2-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513225646.3603803-1-nmorrisson@phytec.com>
References: <20240513225646.3603803-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::10) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|MN0PR22MB3668:EE_
X-MS-Office365-Filtering-Correlation-Id: 932da5d0-5bc5-4b57-255a-08dc73a00023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|366007|7416005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?buN5Cpplrv70vFnxk2dsBNQDAM7MvC+q3gXN5bG4P6TyBaPvLnhWT4PkAzf6?=
 =?us-ascii?Q?BAQN9sjFVTndgt/LAuQ1QaxTXDmsQpOjf+SmU0+1qU7Pk9T8k3M768GhE0Of?=
 =?us-ascii?Q?Jdi4p+BvE6cAF7Gf+GNmwKakOgeuh7NaZJbtDS+frdISOyCRKvPMr29J93oe?=
 =?us-ascii?Q?oWAZBBOottFbifCgpzGOvTLEpZL3nv0enyEU4nA+E2D8UxxAHDt19p4Iawi4?=
 =?us-ascii?Q?2/n0nrYYbOcsVQUH6UhnC71/RAfGpvMEvwv/Bj+DLfYBOsUyiVKoQuUttQwk?=
 =?us-ascii?Q?SVm+AR3fRs8rcfPvgZ3xN+FETVd0nA8YZnJEFJ1eHojJbeGOLgSXXWueWiny?=
 =?us-ascii?Q?6lIsfBn96o1yBr1xvrtKs5Ae+mSKaMKk/ILY4EYaSL6pIjTyjNrmO06H8aXv?=
 =?us-ascii?Q?jYFMd0E54bDYwJKFe1sCjAszcznCChtmTNDc/eCPV+aLD1A+Neb8529jONKB?=
 =?us-ascii?Q?FD5PL40la2wFaO2BvY53mIuZkuDMV3WBsacGYecLB37GTsiwXAExbku1eERj?=
 =?us-ascii?Q?JJVdcfn03qnIdmJUa0uqThGGyCcloKCGL2bK4sHkew/qrFkv5XbV/nhXXr/u?=
 =?us-ascii?Q?LXrTkEVT+UXw2HGrFC481/ZtHBmHwlqsJ/zSV+2ZLSy7TiN9Wjw5H7L/Z8OM?=
 =?us-ascii?Q?Q02fe6nd2n9nQdLb/IhQ3GlFCGwaLcDeWX5A1xG8zpwokkvdw6Sdg00PpA/v?=
 =?us-ascii?Q?51e/QkcCiicMQFcByezz+VEcKYBrfBGFsvEIzNPzhDi0+GhiBvR1KH0mqIMq?=
 =?us-ascii?Q?21jKEXSOVTFLdIMZGW9xXDGO1hCu1EO+v04w8VoiV0uQUy/aTJV4/p4Yr910?=
 =?us-ascii?Q?jfffobn9jOI7/ehE5/aA1H3fhZIYqXnEYrJO54GSERXd/zho/oDHU/S2nQzt?=
 =?us-ascii?Q?/osaxmh3eyVOUwcpG7P8t84KMDhqiU1M1Sk2p6MUyM55KXzbUTPo+TkRzlIp?=
 =?us-ascii?Q?SxRhlwvoI8JGgGF3Rnfp6YbCzkwy79t3HU2vimCEd4kuFlFv3gZQWcc5MSS3?=
 =?us-ascii?Q?6/KEKeIQ/406OwHIy3h5IK6XtE9qClRHPpbLzGVKXUpGFCUFciWLnFYD0fwg?=
 =?us-ascii?Q?lbLbJfXJTPnx0M51yOKlsC//5m0d+UaW6TAEH7+RmazxvcBSxa/MFhk4nzXL?=
 =?us-ascii?Q?ZbvjBVJWn324XxmYN3dSohif/Cn8yfr4nUJyiAHAsiRiviKtSq6pGTwvMA6O?=
 =?us-ascii?Q?rQCzJ/RhiLj0A1U3wRxqF3qz+N1X9Dd3TFRrGkpMe4c3T7zs/V+P14On7hM4?=
 =?us-ascii?Q?EJsbFyRvtSwsOEhBhsTAvtOF2Pyw2yMtztmilJXGcOur+q91N01CL0somEsi?=
 =?us-ascii?Q?iHDQE2fh4Ecxs2z0T9OdYO95OeVhx3XPUw2DlFS9t2kMtA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(366007)(7416005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UWJTMQjimfx/fZ7u4iQm1aoyIUfv/cy7K91DMq/wW5y4gCOxPvuX3AXvuhcG?=
 =?us-ascii?Q?Lu8TvNbDgWqMztCNf/20REIwMolrdOpgF9w3MTKemacydK0d9rsPmEgEtOFd?=
 =?us-ascii?Q?D3O9SdVg26tAgci0yZO1mktwwWeozVZs68W00ZJVKYMDL7L1Cs1cBP9HqAdB?=
 =?us-ascii?Q?u1BRy0/J7jZlnAHvVj/6GRPG638DB8/IajoBbdMMlSZygW5z6v+boVJ6Czfd?=
 =?us-ascii?Q?/kq8lCl1c4czpzIppSbnlGRkfjjQOTbW/qiFowfCCOEsqnbK1sMEvDXoobfK?=
 =?us-ascii?Q?bJ8H0IrDAxKjcnit5/GQophjwIjmah+QibP1Ud+Feyem8fM7guS+6gkDJyfD?=
 =?us-ascii?Q?I48Q0bMlokKD9YSyi6JYtv3lo52Lfyku+UJydjuHARyXsBQBBD1Gg1O7YUjf?=
 =?us-ascii?Q?vpLnxNs+1/VjAgP8wMrBzCDKbnqw+Dwr6c3hnAqTGbfu7WlPC3ryCE9rphWB?=
 =?us-ascii?Q?2sOdJq9r8mvklCTuIxxBz/GBU3GkaF+BJ38xQpedV5rKHYnoawvXjBh7Kpne?=
 =?us-ascii?Q?76mLKp7PTtFS/o3RdkYcsj3bikXM+DiveHIMq09pSlu1mQRccUkcq48aJWsi?=
 =?us-ascii?Q?ibtQ1VB5w3Y5GvIW60MLmuziI1EcnjbO5NUeSW0tJwEwfcf4YKDJNdQiWLWV?=
 =?us-ascii?Q?ol9PSLYy2qsUZ7FY1BPJN6dA54UE8EwlQPUlPiDcT9gM/FBlsTicCsg1zwjI?=
 =?us-ascii?Q?2arm9UHZO3u1Oa9i4nsZpouhxx9Dvp3Vypgs7/QgiMaxOxOOuKWwbaoShbrB?=
 =?us-ascii?Q?h0ou52to3ppUfNtT2T6PFx6xnAEBqwfQdclsM31VtoOn8u/K05ZIB8i9XM6b?=
 =?us-ascii?Q?JHalIzjpmrCvFjh45hXCd8WvWrbdbCdlDZ/yP6SMm0B8Z7kDop14qus/o+wt?=
 =?us-ascii?Q?dH7K2xZKxj3WNKRvLVcvYz1R+TiiYR4FUchptNgsQuGvueNo2OLBqS+CPPxP?=
 =?us-ascii?Q?0pqIV831gn7fRIk0KE219S1d+B8eRm+CY8DzGq7+npT4lyNzJBCxUQcfh3mQ?=
 =?us-ascii?Q?g8PGtgEwJMZehy3gEpiQxWgduuvITSexJrscge72mHjz75MCZ6d+JMIzzPoa?=
 =?us-ascii?Q?HdjGQfABx1OILoiV5Rg43+7yY7SxL6A2dgIpWHARgUmiF2wEG0GPK/eju93b?=
 =?us-ascii?Q?YlGl69md3mpkrrkLY4cfX6g9GAQwXGhKNOcWK5RtemeUyecaWcuhIwg1zZ/g?=
 =?us-ascii?Q?zhjWDHmUtOtZ3PIyLOlpRVMNEhx0xArNFF6VhFENLl+S9MWjfRFGNmp6/ScB?=
 =?us-ascii?Q?Au4GWX9JUixPBw/EE4Pcn6lmslbfndVAYvCW91Z6dXyPdoaatEEE9hyT3mdm?=
 =?us-ascii?Q?N2r2vAFE8L68q9iMdeXCXOOeJePoUOEYFmP4DZIk/VZfUcBdXX+OAqcjdcoh?=
 =?us-ascii?Q?YPhUUNLecq+dsnnhzPmv9PlPcWCB7NJUT02WrU3deNkcojLET9MW9jK464QL?=
 =?us-ascii?Q?FvZdSgT6+pL4/zNeePyZBiTNLlG6wwdlDBjpFw5UJlepfE1gxXGtk83Jv3c6?=
 =?us-ascii?Q?KkFZJcSjO4V7P1juYjBgK/ZC0+LuuBwP5IjZ9TZHuUq4pZaNboW16ZwAgQl4?=
 =?us-ascii?Q?oOLKKOwZAfqm6ZFz6fy/i9GOqfkF5QwDeh2hvywb?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932da5d0-5bc5-4b57-255a-08dc73a00023
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 22:57:01.5502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUdtvTydHBkoI+7VWfq5YOKgguPq09DY31RX/o/9OILb5bas0UXBagud3xaDyUd4AOmCj/3viO/PNKsGBAU5IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR22MB3668

Remove pinmuxing for PCIe so that we can add it in an overlay.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---
v3: No change

v2: No change

 .../boot/dts/ti/k3-am642-phyboard-electra-rdk.dts    | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 6df331ccb970..30729b49dd69 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -190,18 +190,6 @@ AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0)	/* (E19) USB0_DRVVBUS */
 		>;
 	};
 
-	pcie_usb_sel_pins_default: pcie-usb-sel-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x017c, PIN_OUTPUT, 7)	/* (T1) PRG0_PRU0_GPO7.GPIO1_7 */
-		>;
-	};
-
-	pcie0_pins_default: pcie0-default-pins {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0098, PIN_OUTPUT, 7)	/* (W19) GPMC0_WAIT0.GPIO0_37 */
-		>;
-	};
-
 	user_leds_pins_default: user-leds-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x003c, PIN_OUTPUT, 7)	/* (T20) GPMC0_AD0.GPIO0_15 */
-- 
2.25.1


