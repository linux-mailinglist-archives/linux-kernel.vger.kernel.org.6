Return-Path: <linux-kernel+bounces-214086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8E0907F35
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F03F282FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE60C14D6F7;
	Thu, 13 Jun 2024 23:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="MuyjXCM8"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2100.outbound.protection.outlook.com [40.107.94.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F7F13B797;
	Thu, 13 Jun 2024 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718320168; cv=fail; b=EG6vytfOM4VqHmU2SkL+bBfaPBN7X3cvE4Gy1Zx11zReRjlmL/gk+W+wrNgzRq7dfTAOu05Jv1CVskfxZmyWneqFOyUxYsvvnipw755kJF0zHgH97NIVXp4FQ2BTzVBlMX0xtxy7T8aeX3hbie/oVc5RXlk4Ej+UoSOLqPRBMxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718320168; c=relaxed/simple;
	bh=xSz/sI76HHJ9Ggdgfku3BsdoJIZs3lu+QdSRucwAdL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CKvGOM1Y3xGx2Kj6qbKFqVBrQDs2xpGfrMYhy7iSVy60ptPJCUH4RbSN+j9VlYtAzOg22PMk3H6vQRQpG8yDx4sIZ5sZGvXGGxauEAiWn+ZPuHwEpRI4FHu8m6dLQYhwNrmabEBRCRERN7EemZz+AdENWnZUw0CA6QYxWp4Q7zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=MuyjXCM8; arc=fail smtp.client-ip=40.107.94.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laHetUSdJFMAL9d2L5iDcLZKzbDhIf0FEelE85MFEbwhngpNcK62W//4pBLauOJBteCoFuesM9Dl3V2HWzmw4LW2sLwRJUFLhBMjpvM52rUAzqH2uikHB5RBn7EzFw56kvLoU5E7N4EdmZPTSpl1r9lwBasmIpAOBLybjcEW+qi8tLE6cSRAbfulSaHmEtIqwBim6IrVLnvdafDJVa9yCxO+T2bD1PwDeeKdb5jl3zoTPEf/cKWn+wnqOKbsZTEi1w3ivoNRpf2IB1qrn+t4H/Y0AZMYkJm7S65J6F9VA7N9WMwVAc1tOnlxFalktPGrzwBvgQqt1lG8mgkLXtQE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGWw1xfaitlu1Q5obfvANYkGsvxSM9Mv/QAXLwP8oeg=;
 b=dQmhEhIpYHCvUNAc7LjxGk87cwBJlkVJ8QJ44TIRDgMelDUnhf3TuBEGBgubRKTmHZYc5uh9A9CNPeCBcE2pw3UhTdQZF/B/0xxpBuI4ny36DdBz64rsSNw8wzZsU6I8avfz5zfBbi2aZmY2DluiR2cknnkYN3NxHDU97r0ZnMlBX2XxkMwkfIg9xZKzhIRZvwIt+r7crW34zzhcRVcWsW57tOPqSYBzxoBy13vaMoUrK7stD0RrpAtW9FBtMUBY6krS+k8O/VEyWTV2YGpz5QFKhysZonuIYyiGRGEJgDp8wKRs9Q32eCQ4WVxn/JrqTUao9YJxVRxAp2IPMBltOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGWw1xfaitlu1Q5obfvANYkGsvxSM9Mv/QAXLwP8oeg=;
 b=MuyjXCM82RysHqsrRgf2kuOp7pKtlVbbIeNheuTFSUbra0F0FKidIDmAPvXctFJPos4M7CE2yxr4HNHsL8+mx5wIUJINnr1L5bKG0lwwjYNRseX7RNxgwngAkxr3eeiriNRH1M+EhVHtThijCD711ueS/4Sx28HjTJVhLRU1T00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by DM4PR22MB3423.namprd22.prod.outlook.com (2603:10b6:8:46::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 23:09:25 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 23:09:25 +0000
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
Subject: [PATCH v3 1/4] arm64: dts: ti: k3-am64-phycore-som: Add serial_flash label
Date: Thu, 13 Jun 2024 16:07:56 -0700
Message-Id: <20240613230759.1984966-2-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613230759.1984966-1-nmorrisson@phytec.com>
References: <20240613230759.1984966-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:610:e7::29) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|DM4PR22MB3423:EE_
X-MS-Office365-Filtering-Correlation-Id: e361de0a-f9b7-45db-5284-08dc8bfdde2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|1800799019|366011|7416009|376009|52116009|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bZ5ymD2plyrA8d/NMK71dp44/Jxx6e/lVAUZUUH54GjB59hw94VYRT+/PGYO?=
 =?us-ascii?Q?naWG+Wlvj24pVV6EaK3KdsAexKsFhpqRy8NR8yDWxHMpY2Qo2FVk9MwT+DEi?=
 =?us-ascii?Q?ZMC+LL2ki0R4uIx1WgvnyDWg5O5Ktu3DhD48SVLCWOVF0cOhxA5xXkOvs8Ei?=
 =?us-ascii?Q?7lyXMpNJmJmK9K+6+AJSQi8Ql35j3emH3dwZTvx7xxFnyrUkWrn3PVRskoE7?=
 =?us-ascii?Q?xQl8+KHa6Vc5/4C81HulHcjuYieVNy4M1g1a15tQFIYOJbGBLCmCAOlY3/eL?=
 =?us-ascii?Q?y1HJ+3HwUV7KuJBic00pvDpVLFnSmwmALA4Mb/kGoiREwZO7oaUMO+Zz1t+d?=
 =?us-ascii?Q?oZ6mpolgV7lnAic3EZh6xy6blyxg0+L7I5ik9Nk8Vy9Jin8dYCRMnSCmwkZn?=
 =?us-ascii?Q?7sK7agur0v/53JZBojiaCrJPmDHQ57/Qi/YqvX6QVUc0DOaBwjuhVJ+aTUu2?=
 =?us-ascii?Q?NnRo/X9wwa0GqbDDj3kHI7NxN7I5XUAs5WCDbbW0q3aK8u8yfbq5bb5Xs7ZT?=
 =?us-ascii?Q?G6KcdhN52tYlT/OwZIzTWtMpfMVqamSyVtsMACXBZRJoVrcW5DdZ1S4Kuq16?=
 =?us-ascii?Q?3qZaNTovNyvKUjtaMCfgq+nSzolqH8IPmXpKAQc382jTojzdtVgR6faf/4H/?=
 =?us-ascii?Q?OYuaoyVENRupTdTt8UhnRrFb7GiKenyVaijk4gwnDrJ3rSq5OEo4/QntayRn?=
 =?us-ascii?Q?N7G7nfx8gLmgNDFlvvhLRTYujatubmww9D5hmv/1wmee4Cqh7mCWZWoSwKr3?=
 =?us-ascii?Q?9wWcw8MO2+7i2vsJZaHiP/kXGdlOwZ1fML78QcbwXtzs3dbcrZtfCw7WoZ/3?=
 =?us-ascii?Q?1oVuLJE5KevGFLyw3toPgUOG6fDCAqgltRSlYIj7pAAgsc5nk7vjtdxc078E?=
 =?us-ascii?Q?onGXD9km4E5glrJDg38x7KjUu9S++/VBaEbP/MtDAf5lNk5DaI5xtW7sK6C3?=
 =?us-ascii?Q?oW8zDeZdSYJDgODyFVTRadl2fShdE4xrpBlfr2EwVdlMM1iPAQGXkBbiDZkF?=
 =?us-ascii?Q?eCK8+fgiyRPSI63dpo8Ofb6cmBbsemE9hojDSsqdVWb/FEfAC9PxWahzjeNC?=
 =?us-ascii?Q?XjlEh7eJaRWNZqvUr1q2n6rAmFsU+IPXAxFW+d8EHSFFgys8awbk49tUcsbd?=
 =?us-ascii?Q?mmnHz8igAyuNdp4bwi038/TkwQzL/xohVQIh9AaqUzhYE7JMC2hcaqKNLzdJ?=
 =?us-ascii?Q?X7T3KEm7cG/VytbJ7VT47ep0PTYu37p+7wHsrGGROBw8aWbhyCEdmY94ps89?=
 =?us-ascii?Q?OnjAzky9k8q3N13rqWTNkAHTUmba1dO/PRapBQ/umyI7LBFTRbl66LBPQmxS?=
 =?us-ascii?Q?+/IRpq0ybb2yHREAWaUVEluNqBWhcsg6gLz0V9N1A/Eb5aPYhG4e9OpOGRRJ?=
 =?us-ascii?Q?XwvqsT0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009)(52116009)(38350700009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rWDEOQmQCbgm9/ylugYpdj0UAwLPWfsrE4ARVXcTNmPORxHXnD1E8zbHQtv6?=
 =?us-ascii?Q?RpzPE0qcEEF1R5eOv+fusO0DDtxuKA8dwDPqdid3gn0+WB+vUqysdymncU0O?=
 =?us-ascii?Q?zn2bLPUhXBGItYlrnrCt2jbyJ1wZTOuhw0Oa3tmhrTyLm/Lv9LgF72lryZyP?=
 =?us-ascii?Q?4gS4bb97SOT3W+Mjajm6O3mbfDEdAGcaDM66N4Xchixw/iXsZPQyhoPNlu17?=
 =?us-ascii?Q?Wtq1s4+Nsbn57/eiOwGNy2ftGWIBD6CZCCtpAysL1+KCep4mMYpDrT4duBXF?=
 =?us-ascii?Q?jrDdYKsmM4VeYsMCuIikubD+0gcZBHTL7H2gf0uFNk1Rl6zqSWakvUVwA3tb?=
 =?us-ascii?Q?YAK9PYG7OFQRcWUYyglGbA8U1tcPgqCWDyOjFLSbiDRCEueJS7PJrg5zhOGF?=
 =?us-ascii?Q?kG4sDS1QshdkXwcHBRbNQh4cORtGlNmUvfqHB4XRIGI4Pf1Wq5FIemf6orl/?=
 =?us-ascii?Q?UMiLbp16Kr4CBkwlKgrVKG9YgLgNxXrChUxCf19/3I7Ng/POlnjfGqYvakrG?=
 =?us-ascii?Q?79G6WHFVTitK6Ecj1KEucxUXSaFfZW5P4da9l8G8HNUpqcl1aczJqq2k/ghe?=
 =?us-ascii?Q?fodpA1NGQ0jIkp+gtRVET8bVBeBDSg9uyhwaNCsQ7sUD6ZSGLjYpLXjcK94E?=
 =?us-ascii?Q?l6t3Ay9b1vkbvLmzgkyNlVADFd1+B03fWaLTd6Ga21jX4f4Bc3NzE2BJgU9k?=
 =?us-ascii?Q?dIZFP+K7HCJ2R0rnWs/nbBW63sY9to3u/ikzhUnCWhY8FkUiWchHkNb4F6yS?=
 =?us-ascii?Q?PtFHa2ucuFhg5NKQT6yk3br8SUsD+Nk914nvWExbtaLN7p9BzNgVRyb5mPHZ?=
 =?us-ascii?Q?LuraPMNlLJlSBwQ41wFac2K+NWA3AdpRTnO7tQEv/GBfpMpMNInjRROluJy6?=
 =?us-ascii?Q?yN/uQF9p0U0YySuy41b94wHuG8lcvj4ryf7yaTYBhNB/cbuVMbC/7/siEUG5?=
 =?us-ascii?Q?m1P7veJVFSUmhyNM1ho4WbD/p07f55WmsGgbruSnA5hjgxJcPPJW9aGgdSl7?=
 =?us-ascii?Q?C/xtY8RWvA4JIizB30NAvP36oiaEpPbNUFcxI69Vm8/gX+I3iwDymbHHPxHk?=
 =?us-ascii?Q?bw8eGp8/D+y5NmhsBe4+F05k6bm51FZiFB0bH4AGoQyGDvt1AG8JSE/PiExm?=
 =?us-ascii?Q?YD+R/qdsMLDnYWrAVMAHYJJLn2j1FDLrwElTYVxixT2td2e5cw1dTHNiX3bI?=
 =?us-ascii?Q?BY0o3fzKGVhY1MQsdU7CzYDlsnduC6/DH9//V20ksqm34pGm5Df8oHtfT0mU?=
 =?us-ascii?Q?G8bl2Schqix5g7iIyXBKeV0gpJJPiOvPjem68f/0RPF6eZ6O7uIYrVNHJEq1?=
 =?us-ascii?Q?hfuzuNE1FTSfc15bmwFX0+T6q7C0PmGZIv093rhLN80SnV3B14lDZciW7KNb?=
 =?us-ascii?Q?u/ivjQ4/e8rf2qEaTnWttzkSplGjAg3QSQ4ElrlDwbdQcE+4YRO5k3L67Kwt?=
 =?us-ascii?Q?mnLqZuAP+zWy7TGxIssaNIrm0mYMO6SnCXBbr9LfPYQs+d+Reai74HAvGZy1?=
 =?us-ascii?Q?mfXVTifnwopffkqyKqvUrzdqLXXwpaKa4tN0CuS0Kqes68zaB4hSTcFC0Adf?=
 =?us-ascii?Q?82iUIVvMfuORtcbERUu/AuLUMaAKTGFYxXh396Ca?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e361de0a-f9b7-45db-5284-08dc8bfdde2e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 23:09:25.2376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laJrEijmtoYmGhf++2jIUHLYX1bvvMDkeJhQ0ikiIU8W9vN+2KLuI1ql5d5OC20K8jVQonEDcE2Gj9wSDWCByg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR22MB3423

Label the spi nor as serial_flash. This allows us to disable the
flash with an overlay common to all am6xx-phycore-som boards.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
v3: No change

v2: No change

 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 125e507966fb..ca0bbf21f7fe 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -296,7 +296,7 @@ &ospi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins_default>;
 
-	flash@0 {
+	serial_flash: flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <8>;
-- 
2.25.1


