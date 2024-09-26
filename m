Return-Path: <linux-kernel+bounces-340953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C95F0987970
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA471F221EB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E34176AD7;
	Thu, 26 Sep 2024 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="E/6Sfvu7"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2090.outbound.protection.outlook.com [40.107.244.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238F613777E;
	Thu, 26 Sep 2024 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376574; cv=fail; b=OaNWAYV8q+25P0gcMG1F4mGVwVvWi3qHrZgyyCiSQScHMeo4QVIlyjbfwwLPRysnGlAuDW7vPPMdtFMxsBXF2dnmFWIX5fXnGjo4JRUxORlrJNVF7KDM9OqgU2Oh76nukqU0LfppDDusq5haZpYvn8SMk1T3rQeBwOjlM+TBBIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376574; c=relaxed/simple;
	bh=7DCVhwhcumfaPPvoKYoBkQ0a+J3Ymal3mSu2T717NcE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uvsb975oRjRpjgyn+A81oyCFjosvHLZyzNYP7UGcIkC/QONfyaqdumHMImNIJTZHkHe8g8rmbjazlkYyHHoYvkgB6IYTQwmU3Zbtw2b0rrVCVg9wvMyJ8MdR4/D2lgctpqRUniL6PLmEZBazpVvVERoCpeNPiKqN8NzuqkU6tlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=E/6Sfvu7; arc=fail smtp.client-ip=40.107.244.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fH5WcpJWXy02YqvSt8C8Z4M/o4i0TlJWDnAoBuEhToFc5iClMeu+ViARh8yY55x39fbe2VGKQfkCfN2mqm4MJ1snoLGTZbvLFf34c2P65dWVxir8lQThh7YGIphjXIMAaphYDjqMngmlh8wTWyI9FeTkEqU/QGrGR9wLsuRGIU42XCKrUlj7RJ0LFVnYlP5DMmPa0t72uk7e3goQFvk/qaVHFjbxJdD5RJS7nSOtHC5a3EbvFdm6vhjyM5DcgUac5ZJBG3QL0/LNj2/KsF+4dsc22PsXBIpIeXAj/lyx0TNq3CvMxMmpGu3XvBZvGMeJrz0bF7Pm8HFEk1AoP1A5tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZ80YyRoB3/dYaBUaAliW7mLAh4ANVW6WD0oyS8W7fA=;
 b=pZQPuftT7ASS6aTsdJ8e6E9o97czLLVzQdiHIHMoUO5W04Pay0WqSCeqw2jVYHSofyp1a9ygHePyPYfoVnjminn1/G3wbUc43YxM4eHXuF1p3MW3ytNgijnYy6XhK5uHb3iXf8yrzASFxdZK3dD+Np/JOR1rILU9N9/P9WgMFfoQdynugtXIXNVMd2kXiBBCNRsN3iJ0n/18i8JxgaKeuDemEJlntqA8e2XiUWY0+NwSzyJfmDp9OG6p4s2fspNjZq0zvWuq3aHKKOFrOLe4wjNUV/d1MTbUXEzYJHuP9QuBUQEV/4BGvsrP+d8CNeqOPXsGy+i8X38fnc9L2cZYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ80YyRoB3/dYaBUaAliW7mLAh4ANVW6WD0oyS8W7fA=;
 b=E/6Sfvu7w8Hq11uj5w2bOn3EalnYxy6I5xv9AMdWl9zcVR6Om9R1BFvCtrII+/0LnX8WoKmlKaznfJxLhvBaBjNePqGHIK90PyawLdfjE/bExpjjhvj9dWb8wh7eQOfBu0ON6m5wTbMFNQblZg0gISgRFip8wZk18JTT4olnVdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from CH3PR22MB4407.namprd22.prod.outlook.com (2603:10b6:610:167::14)
 by PH7PR22MB3505.namprd22.prod.outlook.com (2603:10b6:510:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Thu, 26 Sep
 2024 18:49:28 +0000
Received: from CH3PR22MB4407.namprd22.prod.outlook.com
 ([fe80::a87a:b781:ffdd:3256]) by CH3PR22MB4407.namprd22.prod.outlook.com
 ([fe80::a87a:b781:ffdd:3256%6]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 18:49:28 +0000
From: John Ma <jma@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	d.schultz@phytec.de,
	w.egorov@phytec.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	John Ma <jma@phytec.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am64-phycore-som: Fix bus-width property in MMC nodes
Date: Thu, 26 Sep 2024 11:49:17 -0700
Message-Id: <20240926184918.3342719-1-jma@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0253.namprd04.prod.outlook.com
 (2603:10b6:303:88::18) To CH3PR22MB4407.namprd22.prod.outlook.com
 (2603:10b6:610:167::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR22MB4407:EE_|PH7PR22MB3505:EE_
X-MS-Office365-Filtering-Correlation-Id: aec9a263-4837-4797-3c78-08dcde5bf359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N1cH6z98rEKYim0JZhQkYhzkbw7T1rU2vIF9BDKqXsEQ+28iGuVZbcfLB9fQ?=
 =?us-ascii?Q?gybeODha+P6hnNq3Ok1UWm5LvgYfhe/KU21viCTmWX7+wLZh5jnqelJ8JqlI?=
 =?us-ascii?Q?xHXrq2Vexs25eRsx2Do/TEj/VSU4utZCVr4w/7JaZv/voLUsG7xVLAkfVkhG?=
 =?us-ascii?Q?GzA6kODqU0xbl9GT2Gw3u/a73Uv9UOeX+4m2P4IC8ErP0BX7eSt9lD4BdwP8?=
 =?us-ascii?Q?+h0kQpIqXr82DSBYOIDY95I2KPrLY7ic7gJQM7oAtr2WfFetQ20CmEO3u5/j?=
 =?us-ascii?Q?/gI8s9jQxx+sd8eqDOzT9kEpK56twLPxuPVsB1SjFivNRBFjIOv4aiGnIbK6?=
 =?us-ascii?Q?iwj+tmMco7qzAQb9PJWcFRvhehtEZeTUlB7QsxBWrdkI2AO2G4ff3eroGcfh?=
 =?us-ascii?Q?J+/XAF3r9qzTShY26Q5i0/JGFJnGAZaoCWfAUx0xycLaMpTSRbETlUPA3Q4H?=
 =?us-ascii?Q?nZ0/DDEkzxgkWKfej9AmDfrFhEfkumzpTv1TQ4OzFh42wa5EjcBjuUjW0qas?=
 =?us-ascii?Q?+C/tf5I7njED0YcJtqG+5vVJ7dZnJlZ4FSv7jGTg6X3CBFWfbkng0zJ21txU?=
 =?us-ascii?Q?webixaClrWbDwxX2PcputjlVICoRi/YP2diJDPOTlAKo/yFQQ3qz1rZPAfoQ?=
 =?us-ascii?Q?5qQSeEzYm/m04Hzvt8JFE+ToM0GyZ/WLi3VGmN19x2ADgCuPrYOqdI5Natk+?=
 =?us-ascii?Q?ya84s7P/ny1ESiZMSi1mpUfl2u1ejCtQVYlddwkmcO3kCpoa95YoegEiLpwj?=
 =?us-ascii?Q?nGxjNj21AkxS8xRVn71uvFIJ/s0Tcw/qV/DLlAfWRM9zqI7N6BZBkDek2cVG?=
 =?us-ascii?Q?hIcwotnRtgCx9/AFtyd5W3GWvSDLbP0Yux1wXwSX9lj93Be3FFmVdvyAVqI+?=
 =?us-ascii?Q?ikoxdOXusP3kqdZG5Z5Q/nD6TmSDW5Obnb45PkF49j4CQ9SY2T5EDzl/3leJ?=
 =?us-ascii?Q?jj7Aq7W3bEXOp6PFhi9WahPp8ArGQClSC7ImZg5Mwp9QV9kdTyyqcUwnLx5N?=
 =?us-ascii?Q?XuDgIFE/MyHu6F8lejdR8P7pM9BiYThKCogU/4p42SCtCSc6mmoA79nUtbRf?=
 =?us-ascii?Q?tHiepTxRemAQNDsL1rmfTvYYwFR9429oujCZqg+MHk4Q20Q08yK+I36Ye4Js?=
 =?us-ascii?Q?Dz1UkGqcfQlgKAS+i5H//OX4yFVtd+lqG8d9XAv/+75puP6yQQ8ZlCFDh/3v?=
 =?us-ascii?Q?TtpeGSwgvR6NMKZNgV0IgsMW1RQGOFYE7rF9S6ra9QkxPOrzEq+12yKIzym7?=
 =?us-ascii?Q?CnjLk44Oh/+CZ4xqTnax1K1UOgWKJQt+Ff6rJtaa0hKhiybZxVLMJrsJnVeu?=
 =?us-ascii?Q?Vzrzj5q5WvaxUNaCfia80FIhyDBewv915ax7wrlK+akD5pFwD/IBjbwuwMHU?=
 =?us-ascii?Q?0WKt4Y60cVfsbuAhXY7v+JJS55MfBTT/umgHQ7u4D8sxBz9f5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR22MB4407.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oZeYaSVqf4VtWEwRlMNr2MGEJ2XDkZ7OZF24W9uJ9lcuRobi5oFO6v3D+2PX?=
 =?us-ascii?Q?cq1DBqgViD45mqCcPGZALwiLUXU1y2yGgWWxJgi21hWxRpCevtoYzktLB+hQ?=
 =?us-ascii?Q?Sh4uDjV8c3Fd61xgLDxPHF90hrl8yhmpyw0rkdB8hyjh4vwXhnvsLiv4PAAN?=
 =?us-ascii?Q?9SZW1YcurqP7rlZTJm5yG71ttFXbcbzjmxvLhKv1r5UdiFkI9QqS+I6xppoE?=
 =?us-ascii?Q?07aJoyLrcwWC7ntRpi6V1ZsTLIx09grFeKjVrY0FTOrG3yfPLqAZstY6BJzD?=
 =?us-ascii?Q?bvXGrzPpo1i6m5VH6yZvGKx5HAUA1aSl+G+APFdC+UTG5Y8ltrwVl9qUIIMz?=
 =?us-ascii?Q?+btZKIByYDRFM1SkF/W5ZGO3Sw7cAbXW/7kjPi3PRrqs3CWFeE117qYIMLGS?=
 =?us-ascii?Q?qyK8EIG0Vq8N40LQ7EJGhcyaRIaBLnilE/nTGj8E5d6pFxX0SngxZIWHKN14?=
 =?us-ascii?Q?9dfSXPvCb97cDgcGFWilITL+NaoQxj+sO87aqAV+X6oDFSbWVlFxcASHT9Yv?=
 =?us-ascii?Q?ON3kvfY62rDkzGrWMonYpvpiPF1zPD8EUkTkskbQjeEThfXuqNSHOaXHR7LU?=
 =?us-ascii?Q?b/qCEhnWUlyNIz6ysgkQp3YpAx9Zqg/r8B7Eh/Iu2crJED7M6nocOCsmIzjj?=
 =?us-ascii?Q?40PGz1BJhhuhufGadHlE8HPvx30MLbsHuptUEndbsX4SpAtNyaDC5LGeL3ED?=
 =?us-ascii?Q?1+pV1g5ruaEL+jAHp1dg3Ms+gXZkHJDFPMnuZED35ek4km9jb//9RXGAaCIQ?=
 =?us-ascii?Q?F6F2KoILrLa5FpoBURpAHEGcfN12ZKTpLRwzjxFv/RoDG5nb7iCbJRYrNMzt?=
 =?us-ascii?Q?LNqonH+5Fe1/3/4k5zo38H1TI/dohqIui9M51zpBB5dEivkRW6s184t0zXh9?=
 =?us-ascii?Q?ft3Whbin0JKxBxPLFbyiSVdx6szSnBaVHUtHHTZl4vnIotK+SVf9DA4k3mOz?=
 =?us-ascii?Q?GD6pJJgqGjiqg/h680A/GoMr9UlpfGizIuXeyF41wna8XezPCJHIsysAbrLH?=
 =?us-ascii?Q?m9OyHL0LP+zrOj8IVh5tptD5p+PGy9MbtWhCXPBKGhHo1v0vpsrKatuxwk6I?=
 =?us-ascii?Q?DyyZQqP1qMIroqO1tfop/WPcinjohVoIXSmP6pNzT4pjkVcyPAtwUdRIO8Im?=
 =?us-ascii?Q?3tod7mG+jA91tup3NSCRUGiZOm4JQBOKxtNsX6wBHPIYha2WZKWbxS1iPe0u?=
 =?us-ascii?Q?3VrUf1ftPWxySwh1zj1twZ/EZ1aO8rHPWZvnIYAkNuEL+yFbgFhfhGPAkXod?=
 =?us-ascii?Q?e6xUwDieIulPEip2BpiokaeFySurdqiLs5/I1za6EI6kihOyDcNDuFSPUUBb?=
 =?us-ascii?Q?P0z+9aobgFzxoq8bdsANXKkImwmKm7GBboHMGMmuAfCaso5hc0L8Vg7srP2I?=
 =?us-ascii?Q?uC8/GnsWFAqQlMRQAAkbVK9g0Rp0ZZoZ6ncp1K1qI4wb6KPBiOb6ZAHiIJ7f?=
 =?us-ascii?Q?jWeUC2uj0aVJwL/lfNb6pkhRgQbM1N69bDK05Ws4ODH8xXgFotSl0zguOqHw?=
 =?us-ascii?Q?kgn5LTWHNYCjjARlH/aXpPYEPcoTOZUEA44KVgH/QKVXRPL05StKKDnuBqli?=
 =?us-ascii?Q?gMW9n1U8vc5SqcKMSvk=3D?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec9a263-4837-4797-3c78-08dcde5bf359
X-MS-Exchange-CrossTenant-AuthSource: CH3PR22MB4407.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 18:49:28.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlZX2PYK366LDc3HrjH3dKBsFkFeP3l8C4O7RXIJgeMQnUvFiX6je1LNrJsAY0SU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB3505

The bus-width property was moved to k3-am64-main.dtsi.

See commit 0ae3113a46a6 ("arm64: dts: ti: k3-am6*: Fix bus-width property
in MMC nodes")

Signed-off-by: John Ma <jma@phytec.com>
---
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 6bece2fb4e95..75e08d0bf4ab 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -354,7 +354,6 @@ serial_flash: flash@0 {
 
 &sdhci0 {
 	status = "okay";
-	bus-width = <8>;
 	non-removable;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
-- 
2.25.1


