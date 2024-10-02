Return-Path: <linux-kernel+bounces-348344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C876D98E642
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 00:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80740281576
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2C3199954;
	Wed,  2 Oct 2024 22:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="khodUsjQ"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2106.outbound.protection.outlook.com [40.107.243.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780BDDDD2;
	Wed,  2 Oct 2024 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909294; cv=fail; b=okARX53fs9xEziu1ZG9Y1gGzghZeDPlBIDj274WcsVgPFX7K6fojWHubAaLgiz9w7gCrV7ISzIWrWwf2+0VAh2iBljC70ZJ9kVrH1lAXC4+5WmCWDGDhEkN2jbX7nNml15lPZbuOIc0kIIXl3HKRmnm/qN2VOq5vKbIKdzzrcWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909294; c=relaxed/simple;
	bh=NWH4QsuZdbTUA2ESScgGZxwMsQ6DTAGYXNOdzS1B6dk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qJ5XOarvoJiW/DGEANq36VoFauQED0aJ9sD2QDQUsn9CDxjWG05TsPw8LC6cftSmR35F3KdkP7qapvck5lCzxk5BlQLFOlFKAaAFxKIP9Gv4jg1T1FSNj65bSXfuyDZ4sEwXSuvZtC2Wso08AYTGzfLwgy4u61A06uPqIXupoCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=khodUsjQ; arc=fail smtp.client-ip=40.107.243.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdakP53hFpnXm3l8kt59zPKFvkbaM+tK/+P/Dm3tIW+4D50uAks4kDPc/GfwQMo/3/+IkzEAPtypfXlMvhGAw5l5CzgP7d67bvTqBu+o9T69erIXBIeSBiKOAgxOUaPsfo9H7U0yqvsblbvl9txc6QZqH5a4NK0PQZX0y8Z+nrTfVnPbPRd4cI1pohObPfZFMsDVD9T/y2okZ7doMC2yMu3f7G+J7YaSo0CRNSHv26Mjn2EhOJoorxjSd+Vsczs5i8/K6NiXxEUn2y5e2X9DzTShLO+PrxuXGRGqS+y+kT57rPPSxYyAT/PSf0nd0k8DuIaG8VjQ35ZlLVVCbjsmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsQyh18rHzIWcl9mH4W6QdkQrRi4vtLGZ65IfF3Pcu0=;
 b=oCtMBq2uJ0vhLVPkDUnW72iJ6Ihof4opODia177ALRneHZo+dZcIf/MbRa8MjYaytSLyeAsrCNgPrVC8thSKcovmt0vkvUAZlAOtKwJg2KDYOQsJLNPFvvMeYovHutVOV+xK6UyAPQyv2S/ZRUX6FzJ+r1ALzUn94OjMYZL54rGuoE4iDB/Gm9AQuhps7nnb64kZB5sMm68Ij5knA+lfXeEf2CkYwbCaO+TpNxMteUN7wqjBE5u8KZnkam7JXfRP73dNyIQdl2v3Xus0Qjn3h2XJNOSLwyf4FNTu2ktzuvu7KH8vEfsoTKJMAydVUFCS65wVM/eIy8ViH9WJFbPaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsQyh18rHzIWcl9mH4W6QdkQrRi4vtLGZ65IfF3Pcu0=;
 b=khodUsjQxt/uLW+5cH7oF/OgB/dns9Wfs0LBo4vqA5Fe5etf8ViISjlmsth1/BGXsSvpFClBaeGKie9hnV0MLlp9LIt5A8tZQqTe0faQcpGHVwSV86pVmGpEwPwXSDSfqhZ6MglvCA85NktlXDpoBzcB/2wr9pLwE90+LrTW7Dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from LV8PR22MB5389.namprd22.prod.outlook.com (2603:10b6:408:1c2::21)
 by DM4PR22MB3490.namprd22.prod.outlook.com (2603:10b6:8:41::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Wed, 2 Oct
 2024 22:48:09 +0000
Received: from LV8PR22MB5389.namprd22.prod.outlook.com
 ([fe80::e13b:a158:3ff2:8174]) by LV8PR22MB5389.namprd22.prod.outlook.com
 ([fe80::e13b:a158:3ff2:8174%4]) with mapi id 15.20.8026.014; Wed, 2 Oct 2024
 22:48:08 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	j-luthra@ti.com
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH] arm64: dts: ti: k3-am62x-phyboard-lyra: Drop unnecessary McASP AFIFOs
Date: Wed,  2 Oct 2024 15:47:54 -0700
Message-Id: <20241002224754.2917895-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:610:53::23) To LV8PR22MB5389.namprd22.prod.outlook.com
 (2603:10b6:408:1c2::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR22MB5389:EE_|DM4PR22MB3490:EE_
X-MS-Office365-Filtering-Correlation-Id: d3858375-e09f-43c5-14bd-08dce3344931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jUn9/pMmIiPWaa7qMhZU3kRWle3IcJc48QYhLBSr8/x8T2VOY2bK7BMR2UaP?=
 =?us-ascii?Q?pzBjNPquPO3Yd9g5i8Qp6rDta0hnu40Dq5JvN5jSkUgRgWPemSy42TdQw+kq?=
 =?us-ascii?Q?H1KDZmh0CQStbgkBTlqsaY4rvDzV2YiY6LbOId3mY12BeOENRIUa7vSdz1VC?=
 =?us-ascii?Q?LniUBDqEBBCeicPyqxx9Jp6X9zHVUvPNLF4Dw4tfjQP/9kQpBMdh+omDSi5z?=
 =?us-ascii?Q?sqCjfpYTpjDIfO3qvpDQEu/zym8khEW3M1f7a/jqMl6B6v4qJYCy6C6I9lS1?=
 =?us-ascii?Q?sYe1JPVd/1gNb5nFpffzXqc+gIPOjvmiqrzJQ9iSmJqm0cc49HqV1sekLGVO?=
 =?us-ascii?Q?d9+vxRdAKOrUB12XVEBqFVy4U3Yb8RhnmiTZinIGYYJbcn3iOq81aYc3Ai03?=
 =?us-ascii?Q?LNcqnmbZc41lTX5UPCBn4rOKXc2DDzLQ3XZ6gELkmn7jbuS9N90rznNyUZYM?=
 =?us-ascii?Q?xVXvsksg8qBP/F4VNmNNLQLr2POM/cYXe8R5KhDWDaiBbNBVBImUp2pyTjwb?=
 =?us-ascii?Q?W7LaDjDc3GDyf+HicREqx5GLFKOFRdevwZopokgQP0K5DxjfrMuUT1LURHUa?=
 =?us-ascii?Q?hjyYMm/6cItov+zOIwinRGF0PRskLiovmh36JobLw0I0lQ1nd/D5/S5C8OFj?=
 =?us-ascii?Q?sMbWM0klG6VeYn6+87Y+I626KoqA5WJa//sNYFF1zlejv8ETCXjVJi7ydHJK?=
 =?us-ascii?Q?esMSFqa1hmNidUKxRtKXds/9BlFPSwrfCzEgCPvSo3AoeyD81iskHexucn3g?=
 =?us-ascii?Q?6v2qGOWt+Bul3AAaVIAP2eLGaS518azYrXl+faIhUzeLixWBFPW7sjt6xqIJ?=
 =?us-ascii?Q?AH9q0eErca5kHx7ER1AUGQwemLuRoDQHqponXOucucF4L5w7fgU7YHmWl7QH?=
 =?us-ascii?Q?SPBg5oqDjJSLO3jQap8Si4jPtRgba6XiXjSQgWQsxRrHYzmd4DViX3KEVl52?=
 =?us-ascii?Q?+DaEpynYtVv2WHBiBHzxLuwvymlCNlAnW0l+NNVpzrZxsK5SKEf5nSOP/ltL?=
 =?us-ascii?Q?dKP0tSD+fhnKSP+JAn5UBQmEVBWPWbzOfqDQT0ALYO/pri0GgZ2tmWd7iiiX?=
 =?us-ascii?Q?n54uWSRC7zpiNlw5abS2vP+nq8wrTVtpjRufWqUUV4R988zKRtP/WCHSyqsz?=
 =?us-ascii?Q?KGyy6bkV7TMUk7FbEGOk/c1SPgUfBmcAmCD2c8PvLrsDBoAFx5OuYEniH1R8?=
 =?us-ascii?Q?MntyCBHpLKc0ttKl0mPH2rn6xadlJR4fKd7y+QrzR+wkGRQaNwLizkxHnFrf?=
 =?us-ascii?Q?q3V7u2OK+QaZjXcOE6ERopK6Rk4PGELXYjph1C41Fmf411h5b3Jl6oyC6+d9?=
 =?us-ascii?Q?TrntgNj3RkXwSKTWzJC5YVm8JBY4cRiMMUnPf8ocPKXxJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR22MB5389.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?geBAh7+scSpLBSWF+RY6uiz3OQlvzUOGtA/QcgOo/axyOITq7IrUMFwQ4tfV?=
 =?us-ascii?Q?Jblrh11tj5t5Mg1MMYP5NEJ+MLG+2MvOlzYAswI/RpIOD/DgM5pqha7Hi0cb?=
 =?us-ascii?Q?6d9cTLtZT1JINgFikNazyMbvqKBEvtzs9eTHxldnwBH6Fkbw85nv8ZnmgWZz?=
 =?us-ascii?Q?ISsJzGkFaLy65I4GksjNY0gWfy1twBBU5BVoTHVmhEkoqiM6ETwtbbPWLEGN?=
 =?us-ascii?Q?BUEdHFKkhhsaAPUog9G+C+zlchI5vViPYerRSXdsr9++zTcymETyzrlt4FlQ?=
 =?us-ascii?Q?MJM5ecLaSczwutXT3kGPWWa0TMq4s3uK6BY1t3UmnYB21CnYHsl+lRWF+NvQ?=
 =?us-ascii?Q?0Ifhy0uQVc2n26cr2RlZaM8zhI95uboTbrjocQGXinFu1SUlkJkp2kSl2Vlr?=
 =?us-ascii?Q?4kM4JRaakPNr6bIAmyWsOCtnLKhAXNd6crGLBMiYR2b2K+2pp4UTfzje8+89?=
 =?us-ascii?Q?cBnrXvC2O9fhZpuVCW9n3wI8hB2ue+UbsQfFjF1N+kBEFKQPUx5RfOZ8rtAD?=
 =?us-ascii?Q?2zjpcZSPi69tltXjviQ+VOOiUUGfEmdyiX5PwMEayO6CVtsY2+OXrrj/rmGk?=
 =?us-ascii?Q?ED6/QAmWSsqpcsIjNhFJ7f3XUVf56gOa2JZUrma6XS+NVEMgjJkW0qLX2QEk?=
 =?us-ascii?Q?dXttetQVMkZViU9B262N8kZULcYsEZlcaq2yHErLgMEaiw8foV3uNj06mlRI?=
 =?us-ascii?Q?FZvM2clDBJLa20396VSqoYIO2RfDD4eSsoQCcuSDNJD4mBzWUJPIA++BBMdr?=
 =?us-ascii?Q?+D51piZTCvmJ9ByR0XlKr8dz6GPHSeBDllz+fdMKSTr84WRCdAUQto5H++LL?=
 =?us-ascii?Q?kq+QeIMA2jxuCzTncmo5vrxeZpyirqT1g/KtjAx06z/hiDJs38eQcTcreyHu?=
 =?us-ascii?Q?blnv1Vhov9A5m/cUpMb0ycBvy0tDnqRRZrz40X6ZCgloj8xMyLSruhK6QoN+?=
 =?us-ascii?Q?jTb4x8NT8oltbBONLL6KQ6fKNNl705hXSIB/zTa6YMfOhUcmmX7jCINgbC0V?=
 =?us-ascii?Q?z3le9S3PIGj0DDLFy5gChpuXs/YR3VqW7LPxi2fHNpCtP9psDF0ViGbWqODi?=
 =?us-ascii?Q?02fvBNDBVoU+aw1T2YeyS2oWFOKReFotG4cGMURvk+gtQPcoTlhcSe4jStMy?=
 =?us-ascii?Q?9cOWM/Bv7Cx55z8LKvFftSKRvp4bFpTXiKRy7EChorQXrbnwDnuu7WlxAeym?=
 =?us-ascii?Q?Kl/5C1gfQAvyFz10p+uRftbP/k1kgkBFTVDjxAc6PBXrqB/uLIHGjXdg28b2?=
 =?us-ascii?Q?/j8LP/IQ6yOkd3b+uxAzLeFm1OR0cMfj/eCUtaJjxV0V/gK1kYUnoN1iMStD?=
 =?us-ascii?Q?umTwOJiHY5PxkQ0PyFQGlMTlgPcEQScdVc14AWNUKmrRIGl4HXaTSg5shu/Y?=
 =?us-ascii?Q?LwQY3aVbRQdJlkIIykCul5zNKXJduZh8NXbVjVvnt99W3o3eibZstRjaB2CF?=
 =?us-ascii?Q?RuQpiKH2NFW9jseSrkx1wC79mLK7N+KrppjodGF8wxDtYdDqSYaCv0MLfUmi?=
 =?us-ascii?Q?K01lbE12hnjGRaoO9s04rqjdnBk9BKDEjqRrsWSnVGjzzlunzr1LSxbB+AUX?=
 =?us-ascii?Q?ahnPyHCT54NL1ol2T5Bwh/lhtJYB/sKjzZwDlS4P?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3858375-e09f-43c5-14bd-08dce3344931
X-MS-Exchange-CrossTenant-AuthSource: LV8PR22MB5389.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 22:48:08.7805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nM5ZZu/wbynkXgmKc49XPyia/sHKHnQNFxd5S/84Ft+4zG70GVLI+tNmr6fBqXjy2IKvkVsO0X5a6fLWu61Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR22MB3490

Drop the McASP AFIFOs for better audio latency. This adds back a
change that was lost while refactoring the device tree.

Fixes: 554dd562a5f2 ("arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Drop McASP AFIFOs")
Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
index e4633af87eb9..d6ce53c6d748 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
@@ -433,8 +433,6 @@ &mcasp2 {
 			0 0 0 0
 			0 0 0 0
 	>;
-	tx-num-evt = <32>;
-	rx-num-evt = <32>;
 	status = "okay";
 };
 
-- 
2.25.1


