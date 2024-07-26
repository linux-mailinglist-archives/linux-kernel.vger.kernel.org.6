Return-Path: <linux-kernel+bounces-263279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E97493D3A0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523251C2346A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2846517B50A;
	Fri, 26 Jul 2024 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xLtfUdhF"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2064.outbound.protection.outlook.com [40.107.103.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187E823A8;
	Fri, 26 Jul 2024 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721998878; cv=fail; b=pO1wTfMkr5NgiiA9/LDkQTq2sSb8wD/eZo6zya+r22/JRTPD1qqKOTQ6UlYeeSRiuHViujP1qGutCVMCIhlAUHqmH2eilyXdjM0mYxkFzatA4h+OInZgnu7JvuBXcQXC3qK2B8usyHIVDGukIMgKR9e0eFROvfgcHkGxZRZpFnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721998878; c=relaxed/simple;
	bh=gsjNEtLduQEJkY1fAgIgk3Fy7ir7bfD3xcFm4HKG4Ao=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Tm6S6wF9eHIM1M/e6AaGtSQlK0DwV8NEB+Q8CWVYoFujXSBVF0n09xKUZiKhMNUBdUmN4IijjeG39Pr6NbQntpjOjzydPUPNr9BuBHMCwLv/tXk/1KHZqdlAO+p9h4gs9E7adNCNYFsHoJMynOTT2eOlFQWzI1y/V3oOiRV71vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xLtfUdhF; arc=fail smtp.client-ip=40.107.103.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LT1rbbaik+VO0KHKS4GY9xw4OMsYFzxvuz+ReDc3TsNMOrztRQ0XfuRjAoy9wyklOzkrVNRFrbSCeFJwVxuYUe1pwD+0PnYQpM20lWW7OfJK90cFiTttEdD9pTKXJBFGi/TIHfvZIbJ9hwiBuQXsyk8MFXiYDWSIX9+UNC1WvSI6CXKBw6EXDFRU1upXMTiYIbPs20d4lc1iJ07UhrpL05X1x4H0wfMfjSLJvYp7rY7+JarcyUB/6vBCJD2Ty3bgO7WjQldzbh3es7LbkPt2SgTwz0cKL/XHQWgTfpQhxMxA+DhpsnNP2h4kyRyxbmdK8FpMjxnJzQ6FYBTTACwG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Keyy6vEVFzXTIOIR6dOivt62Pu5oMfovI51GJEKTb7g=;
 b=Pdn9M7a3Vt6QKpCWefwy0zBxczSw9HQlZafQyvx+0fyCG1uT9hqAVSJCBo89GkEIEwcA+UvlwLA8jAD6OWKQ6/hsrLY9BRFtsVCC2W5xedOy/kros3gJqVAxSyttmabpCT7ipP7QPzxTCDmvye665YtLwvtbkqqpnWwM0H6XIXxPZJWl4+YUW5z27flmY96yRk9UWT4spgxUiVBJ8pC3Y2ddfcb/Ca+O95uWgcrNx1V4eleT9f/tuQvgZnZYVffLZEGZd3H186rTNRsdnnEGKzHILvt4QZW75ZNkno5YNLnIBb8dSp+LZcrIrBjqeT6qQZtlwOCRg3446lUnFMuCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Keyy6vEVFzXTIOIR6dOivt62Pu5oMfovI51GJEKTb7g=;
 b=xLtfUdhFQCOnP5kM20oYDU3XT0G9DKQF7kDOn+TfF8aUG2KFhl7bD7gH35StGqWVbtM7uljclo7wQvHXgmyoo4oF2NX00ziugP5kYOeoGXJzDtio2urzm43IoXrXOBnYi7cOis8YrNfe/ieDhSFzFUTH1f9gqJ5e1CnJ4Foiv7VwGFpeIQo0TjoSxM1BYjTxV42muf//JhW2Rxmx2o71DWfz64AlQk6OBCuUb8be7olVQkXoqi0LMbQO8aGMP6WltXLcmTQ7BSkCWCBADAUBJuy5yMnv/wpo4nH1KMlHoq0OExRXNMbmR8TMr4sd1CjD+mt90r+JR6P5BbGjFokVTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS4PR04MB9573.eurprd04.prod.outlook.com (2603:10a6:20b:4fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Fri, 26 Jul
 2024 13:01:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 13:01:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	d-gole@ti.com,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] clk: scmi: add is_prepared hook
Date: Fri, 26 Jul 2024 21:10:07 +0800
Message-Id: <20240726131007.1651996-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS4PR04MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b3cde6-3687-4f4b-c971-08dcad73064d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7X/fZEKajrBAaqkZl5vWhMtPgDbQBPAB9UyzGUAneP9PMgw9uBu29IGBvI1J?=
 =?us-ascii?Q?ETRSeWk459QaPvUVBomtNURbPtt2D2DYrkqvDxt2OaJxcVbZtuVKi5n6b6V8?=
 =?us-ascii?Q?2iDxCczyj3qEHVMvn4YUL5ytXrEXGBl+pzEpOa9QSSfkqXPXZr9yCUGARFDB?=
 =?us-ascii?Q?AoPT4pjchqv3FKygCrO/76FsUzW5OizquMWSso4HC/9PMs9ECtOTvCl4LqlN?=
 =?us-ascii?Q?ZkKgojdmZi70Gf2WV23Ua9Cyd379CQEHhuWgk8vgz5rfRpdtv5G8WtFYIuP9?=
 =?us-ascii?Q?tnGfdH8BTAw/vyEJF3PF56oExRvm+ZAVqtWCqAfdkNU9EmtpPVrPydFw/utV?=
 =?us-ascii?Q?GvckzkO4ctSNwJE8Ys8RLrVd1PzcL94tMntVFQ59H5NmjDVqQYsCl4YLj6qb?=
 =?us-ascii?Q?pSXRQ2v+/E1+61Z2yoCnsvNKMKSgtZimFlZpMHa8UKWQNQKKvhS/P9h4HnkG?=
 =?us-ascii?Q?flpzYCIt03lVZp09V1JnxQSKHF3CJ2bXNjKqnHjnZmFOh5gk1KAPzH6vs0nL?=
 =?us-ascii?Q?uonrApSz4qr+EtuNCzDYcOJ4gHOq3FWRntq3BdpL5CfFjmrKUUviXde/FuF4?=
 =?us-ascii?Q?TLs68Ox0kCb4WYV64dN/YDau2++z6v4BQImmtoCSCL9QXFRNnvfTBHDnQc7i?=
 =?us-ascii?Q?FvddOCvKf3Am557EyIK1MLq5401rEuTjdgTS69EkxQ5RTVWlXgD0IEd4R7l+?=
 =?us-ascii?Q?s8u6xeSifMZ8+7OxUz8sCKMOP2pxly7SYl32omZ/6tYmpWUG2armgKeG362W?=
 =?us-ascii?Q?fwazLTDANr3IvOPLua+eJGOohgmU4gqiqcdhxlvxR0rsDxDVuequqvVmGWrV?=
 =?us-ascii?Q?3AxJIif7ufojZwTZll9wNrezhXkZzq89+ThYKZh43MTbG5vHEsb5D04dd31z?=
 =?us-ascii?Q?eUpvVpp9ZbTeFjn54JrjDelO+VvzoLYMeDuDdIuAxwES8IHiUtlz5hgmUHcp?=
 =?us-ascii?Q?fKIkxuigURq0QjfRmUbh5Wder0E1mfM3pxDNs+ddFyUzBMUIdKa2tmux6cn4?=
 =?us-ascii?Q?eGFfqQjoi/yPM425NgDQAvB+Vi6ilFXgEaNUce4LLnAUd4Pmx99gGLDZ68ur?=
 =?us-ascii?Q?q3OjMbGn/jB5YwBk9o4GNtuuxUpWuNWeeOPGjLwzT4et6iERUNRHqliGup/G?=
 =?us-ascii?Q?GeymhWVaB8ZII9/2M5WuIHe6QsS46qM4j+bIhvbyHqk3e6i45trQFvySkRQM?=
 =?us-ascii?Q?6jraPQWgfePUxD0dT6NAIQA9y7Z2KGbgiCBqiUEbkOyFEaM5uSA9Dx7bnr2J?=
 =?us-ascii?Q?YkJBG2pJ2Fj+yJKTs4kQm8fbsCL37voyc+7mI12IyRABRHNLmgAixSMOFsMO?=
 =?us-ascii?Q?M3iWuEDR/NXLQ0F4Y8f5hajygdr2fPZNgc6ovfm+XADbuhmiM+3Fx+X2JZyt?=
 =?us-ascii?Q?tzmHtDU5dKxmv3gy++2ajxI0ecTZBX7hFPeAPUYxaZiKcguqjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wqaAvXLswLX2lx+KKClzF+QRZVi9+UvTl6Dvc+6zAOuLvTKQqDH1H3fSVuSU?=
 =?us-ascii?Q?GY9wabpGkntHFXXyZEtRS7OXI5OnG6AMwy856yZZppL6C5UuXIrhIfQml3GJ?=
 =?us-ascii?Q?rgRTmO6iMm/Jg9AZh5hny8JxiwI2RUq/1SjBgBlJmeCiJHp1wQKHh6th0bnw?=
 =?us-ascii?Q?1L0g0ZCzj8yve05qxWS2eouRqHgZUPnSfV1D1BKBkFSLorHT0rtLD0A6KIXs?=
 =?us-ascii?Q?BcOsJX92mP+4ZNUp5Nv/DeDAmfL31fwvWbwN8bQdrmZx2Q4XHf2fMnKFVv4Z?=
 =?us-ascii?Q?FUibmSRvA124Jm+MC1DgkrM82DjHxEY/ocPVhCf3KN0zXD+U0wJh16nWtLNK?=
 =?us-ascii?Q?0xC9tw2gGqCSe4Ybt8LlARknfMhHPN6LJXLesrPbAjJnIlj38D4EwW2Dc1xT?=
 =?us-ascii?Q?eieus2lMeP0h4jixrXY/x7CXM3LlBiz8VC6+hLAXaV+1WwbS1sX+HoC+2aC6?=
 =?us-ascii?Q?WnIUJl68xBzrZfQNHGr4av1E8KuwcY2kOHi+KM44J1baA58nlqEjESVij3pd?=
 =?us-ascii?Q?83PRuHw9Shs/XTb1fXGfe6r+7sBzPeNFU2oPcbl2jcCoZJkxf1Zg0qFNGbiK?=
 =?us-ascii?Q?wvA5FcAr5l8eUTtKVDBmEbixnNsa30+j3SCJN4ESQ7j1D4NhX5i6qf2MP5rs?=
 =?us-ascii?Q?wKiV6jCHg4rbAg7w5w2+HdvuawTHilFrB4iC7fpQAWbKI2y/n1RL7euOOci+?=
 =?us-ascii?Q?cgqvYKZaNVaVF8eAU/5alLkKoYeUo8UNzghwfkJ+DWYYSHh2r54b7mvDUOVJ?=
 =?us-ascii?Q?DbWAsZIBwc9hC8tsivdd/UdiYrSZ04zdI55C1WCvJhhv9YeB9NK/yPpIwPbZ?=
 =?us-ascii?Q?5Q7rnB7hXEUmrQfwk1cFc7it5vH1Y9UmsY7Zl7Rl4sb5rLvDS4H3BbDbXWdp?=
 =?us-ascii?Q?wsL0/MhGABQshkgOfSPSUUPozc0Hrk9dm5aq22DesOxmHgR6evYY3tW0utsj?=
 =?us-ascii?Q?v56nG4CkqYzhl9uooyuZvojMXh7NRkwqJNtLmImwIN0Hk7viVosRV3rwjwTn?=
 =?us-ascii?Q?7aEI9pDw7tnInHsVnO+zYHvlmOlNuhyYY6vURHDPLx//XYxwg9fHN92HVqYS?=
 =?us-ascii?Q?SagkEpp3E32tclKUWl/+21R7+pBH5xtMRtPyZWaZL2T1mNV91caq+q0fWr7H?=
 =?us-ascii?Q?djKjltbty3qkm5SGbEnPyuKULsmehs03Feb4pdavBUxBdG+L0iaT68K01gdB?=
 =?us-ascii?Q?OSB9SuBIaK8+Fx/1EBGwp0CWdG7a7o8sXDMp8qOmk1kjxgu1KgDXD16Als6t?=
 =?us-ascii?Q?BlW3Dv57zwFDsXsohAqd+xX25cNWzdtWweIqbKEMikw8jpFI6o3jQaQOAbgp?=
 =?us-ascii?Q?BX5vzVQocYpDX3ecOwNlw1tQlpKQkCnIu15JE8n+M/GfaRYepi1mglul9VGu?=
 =?us-ascii?Q?YfAVLnA1hXdD1SdDd3WM4ABjmq2Nwx6EfKDL9m6Kmd81De8ewtlxYVXld4T3?=
 =?us-ascii?Q?5T3iSc1BuvrfFLntC3XtWLnzA8Pzh6k3GOJK6FTnvhwdmYBsKPG4CfkQ55p1?=
 =?us-ascii?Q?kEIi86zLPKYM9D/1Fi4CWNAU7K75gpVhN8/2rhS/PUzhDBE1DqCYLQuAtbSi?=
 =?us-ascii?Q?dd5LcNMZ4hQWZC30XzTK5/Zc42NCOYyC0XewP/MU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b3cde6-3687-4f4b-c971-08dcad73064d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 13:01:12.2295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BY5ix16gWcyKpKU8TYZgMdTc4/F19xepxkoN++asHj9e8m7BDWtZGoElH2Yq+LyATYbgk0p4bMjXGNKGj8GZVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9573

From: Peng Fan <peng.fan@nxp.com>

Some clks maybe default enabled by hardware, so add is_prepared hook
for non-atomic clk_ops to get the status of the clk. Then when disabling
unused clks, those unused clks but default hardware on clks could be
in off state to save power.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Provider helper __scmi_clk_is_enabled for atomic and non-atomic usage
 Move is_prepared hook out of SCMI_CLK_STATE_CTRL_SUPPORTED

 drivers/clk/clk-scmi.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index d86a02563f6c..15510c2ff21c 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -156,13 +156,13 @@ static void scmi_clk_atomic_disable(struct clk_hw *hw)
 	scmi_proto_clk_ops->disable(clk->ph, clk->id, ATOMIC);
 }
 
-static int scmi_clk_atomic_is_enabled(struct clk_hw *hw)
+static int __scmi_clk_is_enabled(struct clk_hw *hw, bool atomic)
 {
 	int ret;
 	bool enabled = false;
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
-	ret = scmi_proto_clk_ops->state_get(clk->ph, clk->id, &enabled, ATOMIC);
+	ret = scmi_proto_clk_ops->state_get(clk->ph, clk->id, &enabled, atomic);
 	if (ret)
 		dev_warn(clk->dev,
 			 "Failed to get state for clock ID %d\n", clk->id);
@@ -170,6 +170,16 @@ static int scmi_clk_atomic_is_enabled(struct clk_hw *hw)
 	return !!enabled;
 }
 
+static int scmi_clk_atomic_is_enabled(struct clk_hw *hw)
+{
+	return __scmi_clk_is_enabled(hw, ATOMIC);
+}
+
+static int scmi_clk_is_enabled(struct clk_hw *hw)
+{
+	return __scmi_clk_is_enabled(hw, NOT_ATOMIC);
+}
+
 static int scmi_clk_get_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
 {
 	int ret;
@@ -285,6 +295,8 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
 
 	if (feats_key & BIT(SCMI_CLK_ATOMIC_SUPPORTED))
 		ops->is_enabled = scmi_clk_atomic_is_enabled;
+	else
+		ops->is_prepared = scmi_clk_is_enabled;
 
 	/* Rate ops */
 	ops->recalc_rate = scmi_clk_recalc_rate;
-- 
2.37.1


