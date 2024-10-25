Return-Path: <linux-kernel+bounces-382697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7099B1256
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05FB6B22980
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B452C20EA3A;
	Fri, 25 Oct 2024 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fI2A2BdK"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A83213140;
	Fri, 25 Oct 2024 22:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729894118; cv=fail; b=IUvg1K8JmCm2qHYNyMUajKD++XmLXS3MbIqDsxGUNdH4RHvdyBhKnXnijJt3f4EJCeOVHgQOajSlWshdyNLQ3c2reHCGoLFPLs+C0LUtiyjKq+ENXfy7iLT9PknbqmL4f6rJohcfFf3NOPOW0eFDKTHHhc7jKxrYp/yCMfX6LvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729894118; c=relaxed/simple;
	bh=VF4kz/tJ9ZUI0uuxgQlr8uC+hfC53Dx4ZmJXcwCQ9wk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wj8Pp6Sb342/Mv+dqRO2Ea1C93HIRoIT0HXkYmTO6luCkpqdjnfBq6IZmW1SqHXz8yaSufwL+JFCIUF7xcYCmYBtSovTkMkfWvk1TB7EsSytAMWyjci0YYRWriv+NhH2tHNhrrNmo9Ap4FApM7I9VQlx8kbUCq52Fw8KQtWuht0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fI2A2BdK; arc=fail smtp.client-ip=52.101.66.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsgG1zsnGET+Djf69mGP0wR/wkuRrPU44q+sE5ry6+GsKomLmItSIh9APBmhzFfMPYKbx3+xGItml31UcaTjJ602coQAwlWJX58WX2Z5cHRLGox8jdZgXPpAoarocpoGmVz+cVVjhpVYrg1hygpKPQaFa5Obzf+JZExZChSXahKLdHRMU5qV+cPgGn4evMAraaydLrF4XcfI9kXgK8hKDdJyBMBaKwEWOBFXGCJAdkRINC5SO551EYKcglA/XaoDKDuJW8OTMlx34H/VKcflcuLErTGpEuF14aKV2LEcsUgN9Kf69pq+u1ZEu1Jq/TBbA/qmrU9cEKTE7HZBIxxEZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTbuz0jxAwiykMv13rH0mVbXcqXEW3MW4KvSLsFNNnM=;
 b=hlpMv5WV3Cc3eOzwz2WvgnPh6MsJAKC5006Wg9x90yRs6Z+0/XssuBgChnBamvB1HeLZSJBGqvOZdg0TyN1he8rfRmpnrdZIIRbflN+7w1V2l0lY98XgZp4Kqn0gmvitdYoYqRMIOMeccmGf4grlC7ali831cKz32EG7YSnmJgow2tRUzjH/kZgpLREpQwju94gOoUiBpVCbzgQ7SC/AbXWZzHticfOY8sJTNUoztovdTgNC25fmphBhuJGhQ/H4XKfidx5t6CpTI3Fnvjk8HSDISSMgLRQKxQxsoLCSkDGx3TKJTAManskTCS03HxCaOhnnOMCTI1W7QenlKfXoHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTbuz0jxAwiykMv13rH0mVbXcqXEW3MW4KvSLsFNNnM=;
 b=fI2A2BdK3QaMJWrBKAvwJ9J1fGCDqbAF3jQrM2PcGzZNC1iGYO2sjyffgHEhe3Bw998tsyfhCTUOcF+nLDSXlOzVKP1F4xhGy1W02AqY+u1y0Z1+ndb6lWB/7uqKc7CR1j4oXrHtEajV4VjJmQpNMMr79hqBSivMHouRLy1oZPdvzOJ6eawBN17kcGFhRP7jPV4Np9Qcz4GPcQ2u0pLvdTn05r2XttiiMq7LD2sWhj70Ze2SOyWQw5azopBJKKtRMw+ES553vE0XwkFkol7XbYT1kUogt4Kfh8VmN6IQCFb0OIyn0isZE3gjDeyFdGZwZlcVCIk5TAmpkGWvBSx+0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9987.eurprd04.prod.outlook.com (2603:10a6:102:387::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Fri, 25 Oct
 2024 22:08:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Fri, 25 Oct 2024
 22:08:33 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 3/3] arm64: dts: imx8qm-ss-hsio: fix PCI and SATA clock indices
Date: Fri, 25 Oct 2024 18:08:10 -0400
Message-Id: <20241025220810.1833819-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025220810.1833819-1-Frank.Li@nxp.com>
References: <20241025220810.1833819-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0098.namprd05.prod.outlook.com
 (2603:10b6:a03:334::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9987:EE_
X-MS-Office365-Filtering-Correlation-Id: ac83b206-9bf2-4f4d-95c3-08dcf541912a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q5/29t0utDb1TSu/How1mzZsvQgFIn2g+5IGzvbGiJFQGXXphYcla51WJgh9?=
 =?us-ascii?Q?Mkp33/h1IDRdWM5n9CvMV9znMk+GsVG1SHhMIA7HHNETG8nNlc6L/YUvIvlM?=
 =?us-ascii?Q?c89H7+VuS2w7MQGAn4QoCDMY8YCzN7ULiHZbMwcFGppAU60Z/pKB/MkU2AUu?=
 =?us-ascii?Q?lhBQrv11he8p9POmdlZT3Q7Q4CiZUmTxJutdXNHBVFjkTR66APlE4gV92njA?=
 =?us-ascii?Q?jkwbSxFHQQ0wIaGpG9+DrmGJaWtnz0R1xiMd7QwJ9gtfSCFvpMSOZcgx4M8p?=
 =?us-ascii?Q?310I0ZZKsPl+XGzZKxuCTEiLltV5VLPfCjJga2HpRkX1JZvL22wNVeQVEqxn?=
 =?us-ascii?Q?no6ExU3Zyge9jh6cdE/PjVRjuRvsyYUEEJkzkNZSPYkbtB/8ArVfoXh2XibV?=
 =?us-ascii?Q?QiN7GmAGiVzq5RIAErdux6oVFklJL0OUCKMqUfzFhwk/MeVWIWkNOzlA/Mqo?=
 =?us-ascii?Q?adoPaG99zC8YLAeMUig6fydwxbMxUjJiOrxyAt0REOUknhsW0xrDSTmEmEm8?=
 =?us-ascii?Q?r9cZkCBhlYsLqGpVD2cv/Y0JJ0QRYCDkEWu8iU0yiVTcX6iXdfwNIZhORc2n?=
 =?us-ascii?Q?XXEbAeD7LuWFNTh4UsnETmIqn/1DiP4mAxX+AbEvu/4QxiwkV1MkDRDhCtJg?=
 =?us-ascii?Q?ml+EK6wvmrnhKAZxQViV3v0nnkyJ0u7asFcoesO3CLFM5uZtQs2I2oU9Oi3d?=
 =?us-ascii?Q?KVydA+h4FvbId+CdK0r99bib5xxVsbY09YZwcppyriGPlHH1SakOi15BCSDB?=
 =?us-ascii?Q?SHgm9NVEEqICD+TjbbEBuc4LpSy8AaoGRVfxmuSoiHdl1/iF5BAv0VP3PWuU?=
 =?us-ascii?Q?KD/jahlY50eYkeem2zVBBNUGVzLVZDIkXlK1X9zXZF7kkLlVnt2II0FMWqjx?=
 =?us-ascii?Q?hpWPyjgz+NIpgtNfLCMZLUVJXm6XeXhVI9T/GP/fOahKCvkfrX2iKoWtY7aV?=
 =?us-ascii?Q?VaCTMqbfhJYdruc5h25rCpGdK8mPGKmBeRlMD1dTGf1aw4bNHOcsBmK3DAUM?=
 =?us-ascii?Q?hkrEuk2fq84svx6BxBoz7ouy8FuEM3GqsvB2Uq5nWvRzDYRk5ipwBOJnWtJu?=
 =?us-ascii?Q?PCkVpM1l4N/miUoTPbEq9K2ZtJQfNlkbTYnN1Et+F7nS16MxC1JkQRGwMxpp?=
 =?us-ascii?Q?ZEgHQi/nB33drNaWNybhIPA5Y04DZB87koHVN2GvvKpgCVAoysuL7farYuJX?=
 =?us-ascii?Q?Ryzv242mh6/dTazYtUdc1FwXJecirfDP58kf+uPmgn8eVTVNhnNwewQem4An?=
 =?us-ascii?Q?sYN1oV+YhQ2NlsaKi3mPFnULdjZouwisinLsR8+ek1iMpIdEsvczTOJIFPYe?=
 =?us-ascii?Q?nBpZOMaYydKuZCmLz0VQojzlvYefPYeZ5YhoSPd3SidPiAI02SglGD5mMDHs?=
 =?us-ascii?Q?JERkqImfx32bdHx4NszJVJ7FA5E9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZZmDaN92mGnyUFXV94VKwf97IHAA8QdxKsAf5xVGBzsg3gtK+XPdAEqh3icu?=
 =?us-ascii?Q?WCafK5v+wmEkapa5FzbTZA9z4QiPMZKBNsH9q+nKfrVg5RtFPj7lM0b4OJQn?=
 =?us-ascii?Q?JDwLi6mPBD3Xzfvg1whStBqQDHSmkJN/MS5U+pEpqt9GYDwbE6c6oOe/9Zrs?=
 =?us-ascii?Q?jGjUoxs1yuPCX7uxoOFZtTMzodZL8Pv0GQ5HgScQ2gheRurPatz4bXDANQ/M?=
 =?us-ascii?Q?AwKoguOKNkD2QJn7IyqtMcFIYCdteI+iHpJLBif0bWKJgRGbPpOp8RF5kIZc?=
 =?us-ascii?Q?e8d8mQv2WpyS1PSQyH87ArLIs6X6sYDtkKHKLhOPP4HLuLTPWwsT5RpDVkNd?=
 =?us-ascii?Q?gRny4vueg71gucf31N/09s8/3SJBQP8TR3c4++e+aN6yAwJu938kDdfKxrYw?=
 =?us-ascii?Q?kwBWCF6RyMdkj9I+NS5YvYChd/FcnrQNKqV9+r0HKUZ7ZzQv1Rcmfbn0iSUf?=
 =?us-ascii?Q?rHbfhmr/SKnL1ZoUirBSeYmZyOde5W7+QjNkB9XX/RjClI/zSH9jRE24Fon7?=
 =?us-ascii?Q?A6hpXa90ICA0p7Qiaq1fRdR8rdYPQ2T0kabBQMssoX/ZKOoFppO52bQVijKm?=
 =?us-ascii?Q?czm+x6NVEX81YWsHvqZOo8J3gmkOKFltK0r4v5oWvgYAY4WLtas+Y/p49XvF?=
 =?us-ascii?Q?LfQai7OOrp86F62YMTtsn5iXoyXC0xKB89/NKjvTHijclnF1R3vE200KhhwZ?=
 =?us-ascii?Q?uQlmY9nClB7rI4Vclj1rdqbDj8Y+MjoME3FOTgU0G2FdY/rQ7UTP9n538biP?=
 =?us-ascii?Q?XKsdIE4cmws69JAO1ct0ltqV/VnbAdd4/aLJJkCOeN4OXEOeA4bvINqtOZfY?=
 =?us-ascii?Q?H9w6rgGGykoh1UyhWYMzJRbnht3sNYygoOk5D8BGKarAnNLOlsRxPHlyJ4z1?=
 =?us-ascii?Q?m1nDblOq5tfGrScTVT9gKAu9J2uEWN0DVtROLn459A1MObeGB91IvmnllpFq?=
 =?us-ascii?Q?ZgyVAa4vJZvEgvhizgJoIa+XqjN/LyXIjYx3gXNkUzASB2w10EUBmVaBcQzX?=
 =?us-ascii?Q?who1TM9RJo8x3eHK4Dj3U1WxJ6ftDB8js+4bhZxnQzGNAu83H6s1oGz2YfOd?=
 =?us-ascii?Q?InzXqXLBpgVeeB0U3ps9UWLiI8eHVkpJsRBl5pSo5qZYwb0gqc2E8cceFvIn?=
 =?us-ascii?Q?hQJ4OWDtuw1aW8YQyJeyvMCw8EdsMuzWc1taihR0Ylbsw9+OqEJAUx7Po2wb?=
 =?us-ascii?Q?KVV9XWkKI24z+UL2BRFeTtdQQOqYCdXHMC2Ajl+vyKx+nMJMFIAoa9CjyhDm?=
 =?us-ascii?Q?gZ15abjtPdHRMFgurJTAg5vX3tverrNO8PtbZizMGBSCXG4wRoVAKXiip1k4?=
 =?us-ascii?Q?JpOMkZckMHRTyd2hYJJrD0mUka6WtbT5fevcYBTWE2Ex3f/hEXLbmnJgWkIl?=
 =?us-ascii?Q?2P/pZMHQsnHOUZ0xd6jsS5Mczq1BqIXHU7zNvDdyJ+KDoQJoISYaKpq2Qfeg?=
 =?us-ascii?Q?uZEV+oWQ2oyQt+mzKhq7HjRIZZC0IB3+kWU6+hK8l8MxNaJCs5CqH46VtYeB?=
 =?us-ascii?Q?7XIktg4k/qpGe2fRvTXfMEBLIcFtvGj0QuCCYsqz0jUO9a9y0xQS837ALBwQ?=
 =?us-ascii?Q?ENdy1yZzTkvAuE8QBSXTdNbh30b/62axqLhWjbM8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac83b206-9bf2-4f4d-95c3-08dcf541912a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 22:08:33.8208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYExoyt9q0wtYrxpdAwplJFMtipSCnTqZxhpvROjI/TRxMu5LbAtjT+84IErdKbKNeyuL0RTn0Crd77Fz/AOoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9987

The first argument of lpcg should indices, instead of index. Fix it by
use predefined macro.

Fixes: 9f7053f67c8a ("arm64: dts: imx8-ss-hsio: Add PCIe and SATA support")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Shanw:
Sorry, I miss check this again. If you like, you can squash to previous
patch
---
 .../arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
index 59b6a670462c7..b1d0189a17258 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
@@ -24,9 +24,9 @@ pciea: pcie@5f000000 {
 		interrupt-names = "msi";
 		#address-cells = <3>;
 		#size-cells = <2>;
-		clocks = <&pciea_lpcg 2>,
-			 <&pciea_lpcg 0>,
-			 <&pciea_lpcg 1>;
+		clocks = <&pciea_lpcg IMX_LPCG_CLK_6>,
+			 <&pciea_lpcg IMX_LPCG_CLK_4>,
+			 <&pciea_lpcg IMX_LPCG_CLK_5>;
 		clock-names = "dbi", "mstr", "slv";
 		bus-range = <0x00 0xff>;
 		device_type = "pci";
@@ -54,9 +54,9 @@ pcieb: pcie@5f010000 {
 		interrupt-names = "msi";
 		#address-cells = <3>;
 		#size-cells = <2>;
-		clocks = <&pcieb_lpcg 2>,
-			 <&pcieb_lpcg 0>,
-			 <&pcieb_lpcg 1>;
+		clocks = <&pcieb_lpcg IMX_LPCG_CLK_6>,
+			 <&pcieb_lpcg IMX_LPCG_CLK_4>,
+			 <&pcieb_lpcg IMX_LPCG_CLK_5>;
 		clock-names = "dbi", "mstr", "slv";
 		bus-range = <0x00 0xff>;
 		device_type = "pci";
@@ -76,8 +76,8 @@ sata: sata@5f020000 {
 		compatible = "fsl,imx8qm-ahci";
 		reg = <0x5f020000 0x10000>;
 		interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&sata_lpcg 0>,
-			 <&sata_crr4_lpcg 0>;
+		clocks = <&sata_lpcg IMX_LPCG_CLK_4>,
+			 <&sata_crr4_lpcg IMX_LPCG_CLK_4>;
 		clock-names = "sata", "sata_ref";
 		phy-names = "sata-phy", "cali-phy0", "cali-phy1";
 		power-domains = <&pd IMX_SC_R_SATA_0>;
-- 
2.34.1


