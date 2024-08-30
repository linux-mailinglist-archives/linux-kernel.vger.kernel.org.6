Return-Path: <linux-kernel+bounces-307955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF59965593
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61338285246
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6033C13A261;
	Fri, 30 Aug 2024 03:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E4xFr4YG"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012012.outbound.protection.outlook.com [52.101.66.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FB34C7E;
	Fri, 30 Aug 2024 03:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724987729; cv=fail; b=fkXoKyHx8Te//R9ghRYQtWMfl5S6yBvwZpbkUGiPIQmMmZsM88OWtpX2XE/NXOhAfd7XhqU7Lxq/HNDT0VikqkmWPc44fiTuhfdzQubutW7EGh/KRW/ZT+ADwzg86axZuJ+IRtsuk4aZrHcpAM14QAakH96fKVACkPoodZ3AcHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724987729; c=relaxed/simple;
	bh=kuYJoFtqiI9o2pY5tHyaEQxKkSQMaDomHZXXX4ZezdU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CFIxSXV20VaF8KOOBx/hAHF+ISmFy2thpRVk/RaPw3c4ynyorSL0cujNEgsljL+kVHYw972J1IPRqlc/q/oICfzFqZr9EXNVfyAPzSphQc+Om/TN1u3oGzQuN5ifsYb4tTaOPOwhn/xbc4bxLb4cuAsWUMr350sVeRzRUbSqmEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E4xFr4YG; arc=fail smtp.client-ip=52.101.66.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0CKzw8fX+iqni1mY+VUYuQbPLmXlI9E/rL7781Fhd6gLuH2+7kDE9+NWC3p3it6VaJOH2h0CR/vc01XkkI3rNEaf4yZSTeJ1r+lOQrK25kxEN1ipLeva5lAIQihzwfCTsAG95rfepzLzdAPHVzqYPpqWZ7biLz0OytXzyq/NI4Ww72lWMTLNFd5wSwTW4/e52hn6Ev9HQUKTetbl9EJpqCuleHqa0nGtq9yyuAaCw6/mKWs+QajZsNCf1WRWaYQg+ydQ6lJl/H9sEiiYRcr7pNioJS2rdmtq2JcF2z43PiacaBNlpQzUB4tbLXqJi5uSD8VtcKBREIVw2+t0I3BuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+N0CTPK795UBaMyeJwOh9ukZA03cAWmDc1XEiZsGcg=;
 b=nkvZ2gApMx56elGSk4IOudByLnptdMu2QJtyQu9A3ISnlYoALs1kUnLiD+3eunZEh0ruBDCCnr+piQU4KkFIzGzq166V1T03Ia6rkLKe/QuwZ78XAUxJCBBSwcvsWiF++DNVIYnUNaHm8li66WFPrvrVRuHbz2UpXdnETSwzfRcwxmBzFNOALg2vLLsIOp0keA3LDpOioxUCJkTP8Nht0kTLzDXM3kcjvCOVUmAigYfr875nPT27namo0n33lPA1piuQYRrZaaFiBvt+LO0xLmDq5H0jsUS8toT0V4OMqmNhfpiLYcBE66nBNI2mL0cnFDnGStQskBKycShYuSq3Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+N0CTPK795UBaMyeJwOh9ukZA03cAWmDc1XEiZsGcg=;
 b=E4xFr4YGIN5yoIcTO+Wt8rYaMmZVIE+C5XW9ofI0pwzTCGdXR/hCKkQ33xhCy4mGipMUdXPMCEkqfdNC2zjZuB2x4hGSSRrXdddQWLY6OpOM2TX9jCIBU38En1+dgqKrzAiMswwVZE5qxECz2BzsbMxR2U6iZp/PGBkRG0WvsnlPqws57d7w+z8FPRCeYyXm0RoEJK+aHVvZaAEFB2uuIVr7HZUmVNhHaz6iJN1h2kKT+We/nr5QZWAaSOrhc0WhAitnAIT9PieEa4bbyRMS+0Rf5hZl/qdDXfM93hrMNkUNfOOXOFkUvuF0SCAxxfOzb8g8dWxhDf6FIpQteP2reg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by GVXPR04MB10612.eurprd04.prod.outlook.com (2603:10a6:150:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 03:15:22 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%3]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 03:15:22 +0000
From: Joy Zou <joy.zou@nxp.com>
To: ye.li@nxp.com,
	ping.bai@nxp.com,
	peng.fan@nxp.com,
	shawnguo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: ls1088ardb: add new RTC PCF2131 support
Date: Fri, 30 Aug 2024 11:22:56 +0800
Message-Id: <20240830032256.3701116-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0252.apcprd06.prod.outlook.com
 (2603:1096:4:ac::36) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|GVXPR04MB10612:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c2f59c-9548-472d-d250-08dcc8a1fbf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WhiEEvlkackgqzEE1HP/EFguY1zuLgD8XGlJJhXImm7fW+XSQ5Cu8u17zg3r?=
 =?us-ascii?Q?tjrEpSC8SQlgFuBeGitixfczUMDFM1FB65fNOInOd09zn4rRfGRNzaqjI5iu?=
 =?us-ascii?Q?nVLOizEwfgvSGxBTvXPopifdzy9OCbehqfwRga9i/+EneadDCE+XGuSj1lAe?=
 =?us-ascii?Q?RR2nyHhC9dDI8f6E4iYD5Oo7SlUnVC7JUTSEUMZQu7uGn4qCSJiiSpBIhfQX?=
 =?us-ascii?Q?975UDWExIb04tWCsAWHlIQOebVkuh7oiFiNt4B8a3K0jA5hrziJSF2ZVDohw?=
 =?us-ascii?Q?hRxSBdremnhyO9cq6LqY1YffQCRwcA8tJT4goDwalPKeUxvRYX+qGBDczNzF?=
 =?us-ascii?Q?JSKaCUjpR/QuAZvOYktW31CUmGMLWv5IKo3AtPB41NExnFhFRC7x+AVtEPy4?=
 =?us-ascii?Q?81d/I2k4N6hAaMXtdVk+bHhYfoSpquyTBU/O35CO7Ksz4mLUMaPspb6p7UIe?=
 =?us-ascii?Q?H7R6MTG2wulyLn30kWxnB3VOxjJ670LDiWefhM7bf288rR9hFmlhpndGz7lq?=
 =?us-ascii?Q?ScGoV8R3p01LcrwAjQv0rxCqbjmRafA/gQrXPM8l2LTQThfQibOguZqkQGhB?=
 =?us-ascii?Q?IawqE54oJMh9mT9yUlTPm62RCj8ITdCPShcLNSBhbYW1QX/vJ2WJ62NIr3/g?=
 =?us-ascii?Q?vkae6vL0TpIEgqY0ySnM/HMXs2j6XXhLJUfkn5kx8orISHRAwWn4GVSJ65fg?=
 =?us-ascii?Q?nyHwremh2hYu5MuKL3IJdPXPIatRJUGAM8JpKV4DkDuQU+XMqQJEndLoJA83?=
 =?us-ascii?Q?ncscfPIAjUbssZ+iFdLqYJgE5L5d7sEBstrDGXxMwt7KulrXPEkyoxfxJGIs?=
 =?us-ascii?Q?5g1DUmOsazgk869ZSrE+I4Uw2m266ON0mB5D/hKa34Amdn0tRZtmiWUy9Rx3?=
 =?us-ascii?Q?L6HarKR9xHYQs0Ret5p8ERipZ4B0aOOlyd17l+9b3iDwfsy0HrjMFbF+AqWY?=
 =?us-ascii?Q?lp2UgIFOALNC3iCnCwyuZZAmyq2bs0H3JhtU7JqmDxATfvMNlUUCTZD1C/aB?=
 =?us-ascii?Q?OrW0XiWE632WkPwFRgebQw3ISy/cjN7QgHUkFMfUL8JxHCX9lSuvKHUUluXC?=
 =?us-ascii?Q?bb3R4NUvhnlBcmcqA9TTjco74/KVQ3PLiYbVaR4Bfn6UIW+PSkdTPQGH8a6b?=
 =?us-ascii?Q?Z7QaGEbwYEJ3w6k56e7GJzG2eiaih/ChjLRM5htyRShsKBaC1k7FHDR/PA8f?=
 =?us-ascii?Q?gWO8SiYOfzegh0NJ0oBNVaveNPC7NVwty8dSwkERiOCOsIrHXZydw2kZRrJa?=
 =?us-ascii?Q?o2mbeTx24on/m/a7GJ7h6B2PHEctuMDsavh0PXnjeT1z9MjNDlvj2e4EJ2Nx?=
 =?us-ascii?Q?l8+XhFmoI9T6NJa+WfRoi5lCvvhshWZjZ1WNhvNietYQz039hqAmAcIb1cYj?=
 =?us-ascii?Q?VPD1JlkbzRtnvHSW+cSelPahZedlKouaEpPVjBphaQtja+plmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wFitrlkL8eKE9TUrsS16jnIU+OCMTYBTiUrmhU3yDI+IhYPpxNNAahVKsXrC?=
 =?us-ascii?Q?Yrjx54xUuQStJlnmxEVikbKFP1hLP+uYDPUNeCxv0QBDfOoETyfMBjicz56A?=
 =?us-ascii?Q?yDdj7MpqjrSAGz9usEyBpOkALm1r6eQGzowkdWJU+wWDdAcs5VGFynQshm/t?=
 =?us-ascii?Q?i5ZyrVQJFfIVn9FjfPOrwL8AMqr8bNQyQxYIJelxBB/sXO87RSH9eBwTTq7g?=
 =?us-ascii?Q?MEm33dRqV3v39NjukHwOtZUO5BCShjUHOcQ+xaTKsVomWTK3BwQ6SRPpH4y1?=
 =?us-ascii?Q?43SvhZXb1H3X58dRtWeVHFbw3WbPjE241NhT60IyQolX6RZlyJ5lWbZlNqxB?=
 =?us-ascii?Q?QIyDFdyd75Q46kqPXxDgjOXogRKdKSShIPMqhdYkGYak8XHRA8unbeO/uoem?=
 =?us-ascii?Q?V695NNavikfua7bsO2Pj7rJChTmC0B03Gm0MEYerdZ1ls5aXhcYtbCW7bqfK?=
 =?us-ascii?Q?E8CPmuyCibLz5pG2JJ3uJpHdJOobd3vxLm5d69/ty/hJdPr6s8PXmfp9DZX/?=
 =?us-ascii?Q?Hx8dqyOiLMw3fXgaom3Fdqsj8m6iqjMcD1IEUcaD7rVleM/JXJqTYRpgt4NA?=
 =?us-ascii?Q?aUcByshDDsWhHDIwS7f5eJ3QmyGFDcmxq8oROwlgtAl8Llp/NR4eeZfqkRDg?=
 =?us-ascii?Q?1jGqXnmY8j2unFuZSNkn0dGHYEH4Be4uOtVOJCPCAxxU/8ggjf5MmrJ4Ybow?=
 =?us-ascii?Q?8zM84wkOx5rtlfB3SMEY4Nf6p5vkYEWLiRZlgs6jbigbCycaBmfILVo64QW9?=
 =?us-ascii?Q?hK3Tprd+19j/Whb48vwLiFaeLx8DdSaEKL0R42M0PpjhFBnB8lS9S8NZo6Dk?=
 =?us-ascii?Q?oucCsro4d7N6D2WkXxnZGey8E+PLWqp7DoXiWa82aq+RfUUNyDRhRRdYcUnc?=
 =?us-ascii?Q?f0CH1ZzXeJAEcob+CQtpKCKCNmqqRSYpcwR6OmFZZBRO6Oq08Rjk82isBPzG?=
 =?us-ascii?Q?DH9B66e/QDos54x85MvSo64IUTYkIyAu+KX9NfqNo0JPoLa8uqjwnSrE5Y+7?=
 =?us-ascii?Q?c6UOXZGrhj1PxY0JKH2aLDE0ycyvF7HHVLLfI6MM7tJittidnkIFU+SIc5IV?=
 =?us-ascii?Q?wf3FdyoHJuUla8hSjszKOq6bNXQtRnJN2mC0POYDfuA9uWh73i2r912ArWUm?=
 =?us-ascii?Q?1fDGteooILwKp1GfXzLrZg+xtty76Y6dz/FCX9T3bfzZzWRin04wTjGjZr2m?=
 =?us-ascii?Q?JOEwkDCLZu/2ziruaU80gszuInjzfAC8Mz5LdIrbuVIwHoQXMYSlaWhc64dD?=
 =?us-ascii?Q?lAxu9qWKzlFsvu/o974l9FJLL5Y6TZanm8F0mDrBaLS4fN94uy6bcnKX8lgv?=
 =?us-ascii?Q?tbKNxtI0OB5o9JPy1O7pkU9bADFrguYoq2f7eTaNlCiWEKKtN3wStiEFL8+A?=
 =?us-ascii?Q?Izf119BDxFKuSbyyCVzMU8T7ErC3qqhMCve6j02NDTJQhp2x/yZyqiFCI/T/?=
 =?us-ascii?Q?nipZoIXJuFiASiqbSFTveNpn1gwmA3pQPyZh4UI4YuC2t01B7riHhWybMQKX?=
 =?us-ascii?Q?lvr5hCSRkvD5H7RV0xwQTfhCL0+DGFab4ZPq1l3kbhFE9aSBFU0Q0lGM3RNF?=
 =?us-ascii?Q?xnt1uH/t/2HeC4zwZ6Ttz8jjyTGl3ZR+70iKM/3o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c2f59c-9548-472d-d250-08dcc8a1fbf8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 03:15:22.5599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbNlFTfmVV+vVJLN7UFBs2ISrT0JEHNCU82o27RdYN1LzwfUH175XJO0dALQNYk4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10612

The ls1088ardb new board use RTC PCF2131, so add new RTC node.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
index ee8e932628d1..2df16bfb901c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
@@ -170,6 +170,13 @@ rtc@51 {
 				/* IRQ_RTC_B -> IRQ0_B(CPLD) -> IRQ00(CPU), active low */
 				interrupts-extended = <&extirq 0 IRQ_TYPE_LEVEL_LOW>;
 			};
+
+			rtc@53 {
+				compatible = "nxp,pcf2131";
+				reg = <0x53>;
+				/* IRQ_RTC_B -> IRQ0_B(CPLD) -> IRQ00(CPU), active low */
+				interrupts-extended = <&extirq 0 IRQ_TYPE_LEVEL_LOW>;
+			};
 		};
 	};
 };
-- 
2.37.1


