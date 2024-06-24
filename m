Return-Path: <linux-kernel+bounces-226576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B5A91408B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5A72810CC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 02:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B17523A;
	Mon, 24 Jun 2024 02:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="InJpB/u7"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88DD442C;
	Mon, 24 Jun 2024 02:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719196498; cv=fail; b=lVwKVSfdnet8ZjfZ3hGXzDZsBycGbajIzrzytQMwWSHXbG5e6wMQpg+7FM9w5yuO0P3149zWiU5viTiCQyf4zEkOnL5NLPR2S7Bo8ko6AlfYfdlBiMtD1+S44UZOPvN1UcVJSw+yQL+EDIi5W8X1DNbBJ9Wl2l4l5BK76saQPZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719196498; c=relaxed/simple;
	bh=D7EQCKBO+Rz5rUVHnfRJPJQRJY8ZfZQ8zt/FU6hxAIk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KP0q7fZqjW3sXds8us1laj3ZNUfLTYEEXAQmED0Yhye1wIwRNJpbW9NZbV7xf74tIHoYyo0pqjhrLtxiFHA+ZsnoMhdTefnjgkkqwFZRE7RSvh4ouVOGOS4pxq0SCh6xtvcvfxzd1kgOU3+xiSRoLwamOjj7GLgWDIegXrzLeyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=InJpB/u7; arc=fail smtp.client-ip=40.107.8.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHFkvVaH/n7dD8HJN70igCsMgEDe5c9ftrcsi3vkj6Gg8yegSXxS7Vdawe1D3c1cKhFtpL0bdMFbamJlQBMOqs4+3yO8orP3UV5F+5NR6zrGBsApqtlviOWVoiBAHAvzouNBMszrTQm2elVDRgcqEEx4su3jcs9bCONnt257cc8rMCHWtjrG5Wdg4s+RbrkBLSExzD00R82KjimLOvi93r1sqzHKo6CT133UfYdm20m3CUF9x3/LrvaDa2OJ7a3ZzjmWEBcbJk3rpyLDQ5HN4NAmNMCjvUJpxCm7t4HE3FrtwS8FCkTOzRmB92Tb2dCwG+PGgfZ+k955F8dXom6ugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qj1C8uMM9mCl5UNe6//0tqzioHN+0eXZhd7GorEozAs=;
 b=ZMu0sVWt8ocDKAyQLblO/G5ROPzrgRS44usPTJe20SAYfx6NhOmTdvLcPdRbRom8CtkA0F9WNP35cPFV3R0k7GvFKGMszE4w1fJbeX4OsUDUg2Mr1sCChWTeWdYC6+DWpq3ZEffhrtp3GzxrwxGoNsnIAjsfGZnB4XpuO793HMxVNRuiYfz/LNBFt+mf8LTtfjUr30F0AL8JHymyYxR4m+bJckP0ti5xxKV7LhMjU4DeYYtlO4ChU8sIzyK/1DJdUa6fYrmI12ttfeoX7SjNE7/A7l2LvVHReHE1RRTORM+fTfhsNDScMMtSE8/TSCyh1P9mxDwjw3pGMt4C/m1Lzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qj1C8uMM9mCl5UNe6//0tqzioHN+0eXZhd7GorEozAs=;
 b=InJpB/u78bGgcCvZOZPyYTMUNRfBlESCbvPcoeiDmPNbwks1kD0oCMx3ImT4LD3yfDT1ny5nzvZIVsO2D3/t4YpEv5uExnv6P4BDlbRMPnny2xyW094DHGi276yqjLftVQUSD9qN0aly7NCaj5yglorBl6aGHLXlF309qOWwXD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAWPR04MB9912.eurprd04.prod.outlook.com (2603:10a6:102:387::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 02:34:53 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 02:34:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] clk: imx: composite-7ulp: Use NULL instead of 0
Date: Mon, 24 Jun 2024 10:43:51 +0800
Message-Id: <20240624024351.488492-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|PAWPR04MB9912:EE_
X-MS-Office365-Filtering-Correlation-Id: ac97347d-0764-430b-96bb-08dc93f63a1a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|7416011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wmYVOfc6XHc+zundsBFmvtAf/Jzm8gp13+tmyQf1kGAWKjvIda8+yeNK5WLo?=
 =?us-ascii?Q?9hqF3doxSexp+hFfnuiOTyzGD7FSpeKwgdUMGZdfSk5NhySt0SAp7LdU7Jgz?=
 =?us-ascii?Q?Fe3W8+lre4LSD+dw6yJZGjhKE39wSCwHKMdETGHIfSkvXJeSO5Z4e8DcZCsr?=
 =?us-ascii?Q?YfU9Dm9ZkCiHApTELC5DA4VI4LUvuThHi7LAR/S6KhqDk20iR3qZaSX1oBR1?=
 =?us-ascii?Q?DsEPVHz4odsgHbjmw5F4EuonZXpI7T3do9FeL3vhtlPzjjImg7qPYKzT5hUb?=
 =?us-ascii?Q?1GeNgj7AzG9QT+thuxt7uIGMF4Zj2WxvvoMfRQ9k8+v/YJ0Fn0ufiYPkL3wf?=
 =?us-ascii?Q?fuyE7FR9kO40Od/SY9eBaECWct3oHh/G+lPozR64iQTSEqlxlcZDQ07O/gd5?=
 =?us-ascii?Q?YnFhL7daauNvqGrIyZnT54j1JqQDh0PpmWkPA19DwtJYN/PsZwsQGSRpT8jW?=
 =?us-ascii?Q?BqJ49xuKTfHcPllLMACnOsHPMvtJR/Z9vslR4WuKePeclLWeJwSS4qg4HpAh?=
 =?us-ascii?Q?hsCS3Ozn9s8x6NXvngZs9OftRCQ79sQzt2QavZ5YeHY9IMVs9aihApV54nPP?=
 =?us-ascii?Q?kXnOO4I/01ex0/OKt4VMkT5Sdi8g1u9f+aUtf3MfNv1qIs0Zk1lYqMzriZkM?=
 =?us-ascii?Q?YOVJcg2lRjiiCqDGe2dyOsVTD6KDJ+QDbr0VwQyQuwjSk9/+azzGW44HTces?=
 =?us-ascii?Q?mLCWpHF/mBfZBDyvCLvwZqaz3Nz6eaRFc/bo19lqjGdTJu7WRzEA1hRcWBCl?=
 =?us-ascii?Q?UoCthrgeyGsVzMs+ELlmRjnIemO7PrnAR4HiqwVsVqSuA/2V8LfezBTAWEqf?=
 =?us-ascii?Q?f9T306656Dlv8Rdpw7tFQkRLt59guBLwPCnIx1rbNWvKLeqVlCt7ao+CO4hr?=
 =?us-ascii?Q?msJx1aHWtMsTdKMwdDC4ygcZlLWWaMVcaftDkvLdWtUcPl43VrAU+Zpaechp?=
 =?us-ascii?Q?UAY8rtTRgBoJubC3hJ5vDo4tQEXYAMdChJ/A9Nm44hStSFtBfCu4bMD+5sZ4?=
 =?us-ascii?Q?yvKlaa9BiwMLho7nWcDZt278Qnq2PdaZXPuuZc5Hze7x6StynXvlG81mbzM1?=
 =?us-ascii?Q?fICTsddbu16BmzMixBn4suoudFKuODnGg6ojiZrz7dSsVSgeW3xpoqMQ8+PH?=
 =?us-ascii?Q?8LkuZP82xc/OgI7UTJsNSoR6uFQpBDVBnR/Thrg29qoXN8ygGjI927CWZqWf?=
 =?us-ascii?Q?FkUKhLgH5ktoCIGPkD7aSEw3UK2CXDJrrxd4AiFwj1DAE1A2/791lz5xbwLK?=
 =?us-ascii?Q?ui9rmgkEle4suQZlM/nSgH7o3jwGeGbnc8uo5tYsazcUyO56Eba1EPgcG6jV?=
 =?us-ascii?Q?RWD3FTB95LISCOQUWx5fIIND?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(7416011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DmbffPqRUZ9OrB65iAr51zUgmADCX1tPnezOB8ACFBLSUk9FRGlkQhSVqzpp?=
 =?us-ascii?Q?JUMEcdgre+/R8rO2MWALMVSC5q1FnB94lZAlKqFTX1UL7DWGzknyiCSbxs6l?=
 =?us-ascii?Q?w4XTAyecEHLubry0waaLpuVH8RFZttyseJMgRFVgg5wlL3R+Il02QF9D5Zpg?=
 =?us-ascii?Q?e9/GzoTYcQfVO/sjOeHWquNZoxhFE8y5XhzQoh9AR3H6vx3eZF9RFxHWg45A?=
 =?us-ascii?Q?59RztiRwJXTUpnA1wCaEA69dF3md3Rhb6Zzi4wrDlFga41z7c3vHciIKmL8M?=
 =?us-ascii?Q?7HNHSbu/Pod37Kn+eE6cNIW5KAotg5tMf+uhf1Maw1bfZXXlrgmGSIl+JUvz?=
 =?us-ascii?Q?OAspzY4ycP/NLXX2w1pMal2UGC8GSU6c1dWITKSl6G1YVhVoMXp6jXiOmAo8?=
 =?us-ascii?Q?65KbDUOzH8Qk3yLuLvJtMGAWvW5cApsC34r+ZdQ01Xo2Ts5mi13Ah3WLEOTl?=
 =?us-ascii?Q?uwZBxuGHLRSKSkn7pRcZeTFhwoBRaV5Gzdv3FXXjwYi4H2Ak6LhbSnuCsWaa?=
 =?us-ascii?Q?1pqMgRTxLOYS8scw6RKhuWQwYNBQ4dvc8TQl0je0SwBloysVR54QC7jK7Epc?=
 =?us-ascii?Q?GHadub+2tXZS0qJM+kMf3qzBLD+rd980yV7lmVCtllDAnDCUcS/G2IaKB3mF?=
 =?us-ascii?Q?tKhoilZBpRg7rn3ryTu4qMjz0RxnsmdhilyV/4otPruPLMbtCUwEq5HnA4RO?=
 =?us-ascii?Q?1WPrrehVdkmWU7vQb0bzIOvFxKEcNekPhDViRmsDltP8yY3KR9B+ZuE8Rh1b?=
 =?us-ascii?Q?KgB++aapHVHV28DANPyeae3IIp8Ty//YbMxU0DyXX+pJjymplYATKem/obKp?=
 =?us-ascii?Q?J7PGl9YkzCShkp9aFQqKti/X3AttVPDxZLQSwYuojwoBeaTLnmYmxP7O6IyZ?=
 =?us-ascii?Q?WqLSgZFw2ouK1Lap4YZ/46TFM/MU8RWAZqmhvbUSYj+7a3BporfjKMv/q+pF?=
 =?us-ascii?Q?+IeP/CmTJYzGLGQ9StILXXXlLDUVC1dUwLO5tIadN5kaAxfVUMeBuYjdTQQh?=
 =?us-ascii?Q?DrWrtovX35XniEF0t3rEBhixItXOwzR4IPyjj9P1l5QW1yrN77Ghh5P5LeBK?=
 =?us-ascii?Q?bsGRLyy9TQAEjjkEWscfL4Okve7KYUrZD5N0FXmgkpA+hUZ0yquw4QRuIc/7?=
 =?us-ascii?Q?SuArWghooLwTCHFP1+L0gEWjJhmpjZb1pPxpwv8VJBr66H+7IAgXnYm2TNor?=
 =?us-ascii?Q?blVFmcto7HNRpgbH1yeeW68l1ipzDrmEiK53g0/McPKDPDUWa2govyMXgijx?=
 =?us-ascii?Q?XngaZ1uwMntpLJo2YqCs0Z2jsXKxNyPOW811nQ0ntKe6dE6hdqLjE704jN5x?=
 =?us-ascii?Q?co5GrsGu6JoCw0RxYjlHN21hW32gZCng7dnFnuWIvXGG8WFCHXoKBR6JjCJG?=
 =?us-ascii?Q?NTkPIQHLVOzUwSpYhC0aAvnswbMBWy8mEJmEmXcRqwC/NeCRMY4x1TWiKJO0?=
 =?us-ascii?Q?AZk86H7e9BpJVdHB1D7Lmpx06PSzbrU0/G07zci91fM19PgfnkCrRenEbjis?=
 =?us-ascii?Q?eDUoqLDi+YgyO5YvyUMJvx+lzsgT2ecusTlhPpi6CGLbJXdp1JWEwLwMsxRu?=
 =?us-ascii?Q?0oqN+kYvw5GFTM2j7Mc5XjAaFiuPWjszRd+/GKQA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac97347d-0764-430b-96bb-08dc93f63a1a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 02:34:53.1286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPfsjFpvYH1SZBCo/HF6hOdC11pGuvCFBy7SYts26GZUwMKxE0Zo2AWNvTSGmniRnkx89+ApU70XLy7r1NXAIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9912

From: Peng Fan <peng.fan@nxp.com>

Address the sparse warnings "
sparse warnings: (new ones prefixed by >>)
>> drivers/clk/imx/clk-composite-7ulp.c:85:24: sparse: sparse:
Using plain integer as NULL pointer
"

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406220536.JnAncjqz-lkp@intel.com/
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 Since the orignal patch is still in linux-next tree, so not add fixes tag

 drivers/clk/imx/clk-composite-7ulp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-composite-7ulp.c b/drivers/clk/imx/clk-composite-7ulp.c
index db7f40b07d1a..8ed2e0ad2769 100644
--- a/drivers/clk/imx/clk-composite-7ulp.c
+++ b/drivers/clk/imx/clk-composite-7ulp.c
@@ -82,7 +82,7 @@ static struct clk_hw *imx_ulp_clk_hw_composite(const char *name,
 	val = readl(reg);
 	if (!(val & PCG_PR_MASK)) {
 		pr_info("PCC PR is 0 for clk:%s, bypass\n", name);
-		return 0;
+		return NULL;
 	}
 
 	if (mux_present) {
-- 
2.37.1


