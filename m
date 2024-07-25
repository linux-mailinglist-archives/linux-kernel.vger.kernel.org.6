Return-Path: <linux-kernel+bounces-262570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E356D93C8BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5881C2166D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F031524B4;
	Thu, 25 Jul 2024 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EJZ8RF1O"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCBF3BB59
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721936060; cv=fail; b=MPcF45l6SSWQxlkGf8+HuIS1zz7Wt+F+qxZ6bj0RctEd82L+OCQn8fPVU2MGt1altfRoqQJAKg6KULzNZfi6CZdViQsdkAi23OsjPA3a7uKnNrt3gvy/F6cHj4b2TjGbZzOp5bdEF7FBJ0Y0LZbeOF2xi1EC1z/9NaMTu/lT8dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721936060; c=relaxed/simple;
	bh=RBZR9q9661RvW/QVaVFTyNRc9zoZXV+3KuNjuakk6t8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZczFTRIy1RnVcmE/u9ofIwsoX9yVku7hGZ26IX2V0jaURdpp5G2IBxUOb3h/ensdIxSA1Shx+JTzheIAzKo37I8hXZkNzuxrhpYB4Xoy2z2cTGh4J1qfLy/I1YICAIfGlLjPTP1lOhX5Dh6BdPgmLzpFhTWVYR03gobWWNF9IcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EJZ8RF1O; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrWRSJWoNp6wXDwfV9e3VvT6j23u/U1Nxu5iCDjGlreLUbJjl4MEOW13VVA/rCB1nu/W1VplpAaiXfXtelQcZ4UNJg7UGrGkK9SwzUlT/LbYEraZhElRhUr1nMCEb62hywtMB4i58vFk/CIKFylyHxf1dMTbAehgO9Nov7yQFTclIP6IvrOuZs4WbWto4h9BmkgLZoNwkIhhRKmQIDNkzYncRV9+zCDPmqLYamwLpPQ0ouwaLtSUOJFsuQ3fTIf0z4buio7eB8/fNG/RfJP7heKonpXEyN84ir87akwye10enUmGAz9qu3M587XbSCrBmfBCXR2YjYJACLMg2YG0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se9rtGe0gsx2t28vr9Hga6+vIF8IF05glvFWcgoTFuw=;
 b=t45UWM/hbnGQ2YmQ/1BclzmgyxvB1F8HwuiyoaxJr9/hyUIzOocni5de4ZeoK38lB7bbIHLaonqMOo7jwT136F6+rkgYFmLyY7DgEwJtB879VJEkXj0hSPQfz1FAc/fy0pgcoyJB0g28Kaw7cf4MJqqE2l5w+aVe0rQ412WWT6Otyl4eZr3sJU4yu7FcoAROW1Mw7PsEvexlrack+oFCz6bPXZMltKv6NmVP/9bntYNlIngNpUOOgcwWBdHzxht08aoTRLRZLQkfXD537bzZN/5IZSUfcp6ITEP6nO6NdVvTdczbagnWRkBRx0T0EoxhLEVmmfpapdqOMKJSqVUNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se9rtGe0gsx2t28vr9Hga6+vIF8IF05glvFWcgoTFuw=;
 b=EJZ8RF1O9f2/FOY5D5guaoTHW3UqaA5k8dhcTA8LKd6jOvRSmIDGRl8Gu5T56ziScRzLvLi24gf6ARccv5/d3x+dMjaV29WzEJ946v44H7JB4cuhbEZyHMmSSuo36qYuzw3SGVaSp4YlA1nCcotWbODrxgQq7UtZNeeBYteKP6/fGVJpP5JlG1VyeE+/oyccxtSNTmWVLtQalInaGKApzCorHv/MvPzUmKmIX85ZkG8M5NQTTcnxYKmbR+6PZGqlEGPURRn3jbmmNQZpk7an11CCsYWiSQJT++7v8YVKJgl1HOW6EbZA971jRhS2ZM2a7L02hnVDpg9Lf2ayMGBfWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8791.eurprd04.prod.outlook.com (2603:10a6:10:2e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 19:34:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 19:34:15 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/2] clocksource: imx-tpm: fix return -ETIME when delta exceeds INT_MAX
Date: Thu, 25 Jul 2024 15:33:54 -0400
Message-Id: <20240725193355.1436005-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0062.namprd02.prod.outlook.com
 (2603:10b6:a03:54::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d9fc54-e00a-4336-08ef-08dcace0c46c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4G2Q9Sp+C1qrVElvvdMZC0hEfSqS1zb9UTXDlNcdFZk5Ge+ALF1T6bkomNA8?=
 =?us-ascii?Q?ZNrHpa11ZNfbo5QI9w7MFQSnlmea9Hn3pyrvofrBTC+gE6FbdIBBGa207NVQ?=
 =?us-ascii?Q?ZfCZ0Z5Ur5YKpnD4daN3be4Fw4v5Ao44vt6voIjsFWLtIb4L6lKWKyr1LzSi?=
 =?us-ascii?Q?UpKcnybPeQv9oaMCfHXZkej0aIFWYRKIbsU/0BqNXj/MRagOwCWIuwW4GkhQ?=
 =?us-ascii?Q?aseVfC/TjkKovJZcr5C0wVUt160S2JyENdeMRql9rqQXx7+5kH04T3iq5N7W?=
 =?us-ascii?Q?7kgZbFrCoU38je7r7fW2uh6iHJo23zi/s/c0BGhecMdZ//2Adqo936q5AD3b?=
 =?us-ascii?Q?T3+4aiO54jMGyELqKaW2czrbsVaQvMwAGpqMTO1vYQgxJdhDcBM6Kouu1yUw?=
 =?us-ascii?Q?JM4lXuePmoThAk/VqAhT3eUOqOEtaoVUDXLb0QxZMQjBBB80Xw+06+2p9H0Z?=
 =?us-ascii?Q?VMetsUFotcibls8305eXp4tbolBHjepCdbvKAAoziQevug3LBOxKDQiFD7cT?=
 =?us-ascii?Q?NcPlnlm3Ud3rPQWGQFvdK7vJMWZmyjWHy/FhuLhKIvRG2p1hsYQ4xamSxFSi?=
 =?us-ascii?Q?R37hbhmVtZ4FX4gq4LYJx5ec2fSb8wYfNujHYksbycMfKMb9X/N4xfFLDv/F?=
 =?us-ascii?Q?GoFcFfPjdHyajzzCsero+UNgaJeLh3Qd0d0RVJkEx4W904n7PA04XGQynOm6?=
 =?us-ascii?Q?ki8OKIP7Y2QU/UVBMHuF/mFL7ZY1j9SnSvmmziv0VC6viPecAUplIsHr5Pa3?=
 =?us-ascii?Q?ARFQcJTrWd7gDCjiJoWzCjcCMWVhjKxE2GcEH7SQbbxn2FJgVVHRy1zfn4hB?=
 =?us-ascii?Q?FlaJvdUwWEuir54xO9pz0/327SAKm3C9Zrk5Vv3B6wk7Fge95Q4Wcxno/ACm?=
 =?us-ascii?Q?x/5CZhCDsl1FDFP+84aL89Ew5QmrQjzI5jm/nfM3bgdTRdYJfILveGGaQffy?=
 =?us-ascii?Q?TM8S45/Fy9rPuwJiRpIcJ9W39kADs5uL9hxC1I5s+yogH0acsA1jQYGXRGxb?=
 =?us-ascii?Q?eVe+wj3v9WkVFWTwuki/FP8gURSbsKYSPU1zr4PugYSw3BoWan7k/qS5lgK1?=
 =?us-ascii?Q?2KKE/alr+oVG3w6UWjf+1YRHToD2CIgztv0W2YjAKD+zlVXmX5QqCEAi1q5q?=
 =?us-ascii?Q?K0k86Hs5N9EbcRe0YQBKR0iWABr2s6NTlWn1eb7cj5bX+OXzcrWVSNG/7ejg?=
 =?us-ascii?Q?DmlU09VPRX4DvyDhgJKP3FDFfwfDCG9v5YtxiHI55bczhduBGhk6EfQQKRgq?=
 =?us-ascii?Q?U3JcIsjzsCvJaoVfzwuzL+qwLi8H8h17YloG7IzCI3zwFFkQUBnccimy1Rgb?=
 =?us-ascii?Q?ynXxkUEvQ/of7vT1h4nEQS7G0HcFjIuJztbt+SUlbWYv5See9gViejbMr41x?=
 =?us-ascii?Q?E+NGZhpNXeHF9f/o6KFfuwr8Luo+ONpA3fh1JqkgubTGSdzHi7z+JqvEgVGE?=
 =?us-ascii?Q?oHCopMh2XS8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ASg/prKSCNXmZmYSKDtQF3KB7S4uLP9wG3WWGlXYi2cf6LsKg0+i8g0VxayW?=
 =?us-ascii?Q?RMsyBsfT2vdotHFuA17G6n0eZhrCD9IufzsLH9SUwjFEvyZPPgjMZ5SgeM9D?=
 =?us-ascii?Q?0TzUMI/ay26qIrz/PSYUrXZ77ojW/+w/gZOLwZZ03x+Pc3V69VwtZ27QEJ4i?=
 =?us-ascii?Q?H9suk0Cd4IDd6bVEOxl/aZVd320BBZVxdHdBhAC1UtqhBdby96VOdGS6a8nF?=
 =?us-ascii?Q?AKs0hzDmKVKutUq8fqS+xXDS4mlzrwIIv9rqVlUbMU0cU/swM8Rv1LBX8tCV?=
 =?us-ascii?Q?YfwJpBYukCgqr6th511GTvYTkM9cvi4JxYdqicowK8WjvN4rix3mjIK9h5l0?=
 =?us-ascii?Q?rynmXUq82BskuicOb3VGlaIzEte9MLr5TpScBNKiIv+9Xu8+MK+f/Ox1tz6n?=
 =?us-ascii?Q?WwscDTYMCxtEDHGLL3EYtDHCVTRuulX2z38D56hVu0xMx8wgVVOmeO0HeaE9?=
 =?us-ascii?Q?gWc40gvCNl3zfFazMEH2s8qsY/GfIDOKvTiIv8zN0wwf1X0YWQXXngD/soWE?=
 =?us-ascii?Q?CD9PX2m/xhGvlEhiPnzj4/Xu6G7YFefp+/awtATCtXUKLiiCdDt7P1IZuzOw?=
 =?us-ascii?Q?MZ77/qhF+W1JrXHDYYkD/o+woQEt46g/QAxEHIApiU0hmXF5DpoyWzaE3Rok?=
 =?us-ascii?Q?TiUN5UMN+fD+AehcbsWVRFhEz5r0vdaK/jdePp6Ayy2dqOx5OTTsoaJh0rq+?=
 =?us-ascii?Q?tNcICUdJ0v3m4Zlh2s12B0J+bAZHWx2i8tpxtVylriqJ6HJPDm8mtH0EiNAw?=
 =?us-ascii?Q?ijgFKr9f4oayyl6I3G+y2kKgv3FwEomXNX9GRyL4vedZnHOauqs7t6E2hcXo?=
 =?us-ascii?Q?xS1g49/yYAufjQ4YByJic67vjETaaZHSzQ4nEPaCrk0WnlpBr3EstvGTOAc9?=
 =?us-ascii?Q?GmMmATi6Ndzjx5i0A1Kf/on2/YywV4ypSUWDIyjB6vi3cyoxnV/JFiHtsqJX?=
 =?us-ascii?Q?lgfICC/2E6au4NMUhVHHOZsu6x3G8jY0PWzLWOFCRgvE6jRZ00OtD/AYjrCw?=
 =?us-ascii?Q?djty8Y/O1V01xx1iqVqX9NGnDFiFldJhfe/cDtUoY7Ej7RlZF8dIzWXGhH6V?=
 =?us-ascii?Q?Qvfwhh6bFf7nhctqNSWY2siaLIb9lM9/69gxstbs7Szm3J7IJOUD897GaxpN?=
 =?us-ascii?Q?uXOKBKKI6N92q8rI4HoKAPOl1JwTR4AjAeOrcZMDhDLcLJsIAC5qfcvs00lP?=
 =?us-ascii?Q?YqOPo6bdfSrCJ8EmAxC8KsW3wFpgBpnjCVVUIfCH9hPrXROwweFsghjt4vg1?=
 =?us-ascii?Q?YqMmLjJIfDWbiRBFDssPf72le+ShwakNZXrrLd5Gu0r65Irp9SGxhe4ewCNG?=
 =?us-ascii?Q?GzUyB8quve31vlSVicIrJ63iiokuvV7M8ZuPgfjaTqLtdgGOpLuUM7SVadHe?=
 =?us-ascii?Q?tou0LaREVcSGIv7yu4rH/536dVhOonZNICEBXRZd1eYcRG7DfVlY8qhRw4BX?=
 =?us-ascii?Q?7KgoKWoSv+FCNDl2dFmt3l7mipFVhymRJiGyFGAsS/KIRWGciZNO0e+MOxH6?=
 =?us-ascii?Q?TXtu/RVWqJpSvKMR5iHBb3ild3IYIUboa8/1aQMoTUnOBCZzzBkwnG2QMS6L?=
 =?us-ascii?Q?Q5CWhKSBmqusOcEBQRwIH4nR8P8yLc9zrSw3I//w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d9fc54-e00a-4336-08ef-08dcace0c46c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 19:34:14.9666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRT0HLDDcNE75z2z2ZK8D6JNVQ17SQ04WekjT5KO/kDuyyf13D3d6rT4Zsp6F/RpC1nkmGotqz/lXNmvh7xFAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8791

From: Jacky Bai <ping.bai@nxp.com>

In tpm_set_next_event(delta), return -ETIME by wrong cast to int when delta
is larger than INT_MAX.

For example:

tpm_set_next_event(delta = 0xffff_fffe)
{
        ...
        next = tpm_read_counter(); // assume next is 0x10
        next += delta; // next will 0xffff_fffe + 0x10 = 0x1_0000_000e
        now = tpm_read_counter();  // now is 0x10
        ...

        return (int)(next - now) <= 0 ? -ETIME : 0;
                     ^^^^^^^^^^
                     0x1_0000_000e - 0x10 = 0xffff_fffe, which is -2 when
                     cast to int. So return -ETIME.
}

To fix this, introduce a 'prev' variable and check if 'now - prev' is
larger than delta.

Cc: <stable@vger.kernel.org>
Fixes: 059ab7b82eec ("clocksource/drivers/imx-tpm: Add imx tpm timer support")
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jason Liu <jason.hui.liu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/clocksource/timer-imx-tpm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index bd64a8a8427f3..cd23caf1e5999 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -83,10 +83,10 @@ static u64 notrace tpm_read_sched_clock(void)
 static int tpm_set_next_event(unsigned long delta,
 				struct clock_event_device *evt)
 {
-	unsigned long next, now;
+	unsigned long next, prev, now;
 
-	next = tpm_read_counter();
-	next += delta;
+	prev = tpm_read_counter();
+	next = prev + delta;
 	writel(next, timer_base + TPM_C0V);
 	now = tpm_read_counter();
 
@@ -96,7 +96,7 @@ static int tpm_set_next_event(unsigned long delta,
 	 * of writing CNT registers which may cause the min_delta event got
 	 * missed, so we need add a ETIME check here in case it happened.
 	 */
-	return (int)(next - now) <= 0 ? -ETIME : 0;
+	return (now - prev) >= delta ? -ETIME : 0;
 }
 
 static int tpm_set_state_oneshot(struct clock_event_device *evt)
-- 
2.34.1


