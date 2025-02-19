Return-Path: <linux-kernel+bounces-522298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4392A3C86E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519273AB4D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C45822A80D;
	Wed, 19 Feb 2025 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CdjODh5e"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013052.outbound.protection.outlook.com [40.107.159.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EBE22A81D;
	Wed, 19 Feb 2025 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739992887; cv=fail; b=kNXE6drQcakZcdwQfS87PaNuEtVt2QjDyT0X8vlhkuQNXIGwpR3BGp/yyYjU4wYhf4PKVYZ/uE8Lkxl7hwyrQhT/eiAq4nnkme2mJAv13EIe+Cum5gyvk4eEjXvsryHHoZTKaTH2PCBlMqNZ+zF8NDAyJBuYvdCl8eHvMq2FJfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739992887; c=relaxed/simple;
	bh=pbYXhBi2p5a0lFAejp+Y7x1pXk14JvjuL2ZYsCSKGxk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Qrtr4box4NsPOaggedp+1txE+W358w+2GGbMUp9fKxNNycyPwxBQyLKnEW3S+7dpbP9vsmY49ycEQvbcMBsKXB8DSQyqEAH9rHP4JZahs73dLA5lK5RIJAKNv9INW/ryl/OfB/keSNTo60QhUF7K9Qf134P3eOIktHXYrq94BuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CdjODh5e; arc=fail smtp.client-ip=40.107.159.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dX6od2gykE4m+ZChq/7Bs0/rcCqN9PWNv7IFrZh4B1CVH3gmrCBe6OkJRgvTvjJtl6ciDRfrfw8DmdmE3zG3reXWEt1VPt8KUYvw0A7rNt14zBA6WWEFQ8GiaTJ9gEjKYsCjQTmzNpJ1tsiRfWf007k5oqK4CZ68PjPfmMfX2Lttlh85d+dc0oocAy7RZy177incoYT+4gUCYgErmQmerYV2ODsO1ekclD8nOTv8wWklCqKbIYaOyjFc5ZdOUqY3LMSkr79k9Kv4GdAgIpsAJkMdq+QjxTUPL9OGFvc0wx1Tlwpbcd5x5lnV3t873/KvnsQjBtG2y1I+VDH02+7txw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kzrrzx1s0lw8quJt2PdXGz6VbdfRjf40V8Pm/eugYc=;
 b=IddTuxHfP97vFdGq6/JTBNbvGFyVNk4bpMhFHoYkjxixxiQpfxQtfNhKgA07Yqt+qIM364ypJWj+Nd9135y2blFXrbxpIVrEWSlY+6dpL6USFXdRm9sPTaQQyUGpkh0PggKPxghpM3irbPN5CvmKbuYR/Kh2wT1kaOi+6xpvqY8mzVkjDsZp7l7+zxJWFN3V2nOXWjBBErllFXbkQsLYmG4bhJynNozu83qKAKchK2/IAqbPJ1izotXx6+gNj8uO3U4AuoFXpKPXDSd1bFuvGinHi7P1n8QxDqncQwqegA1Lo8LORfzJLN1y5VMaqn8TbAQ2T96tfs3JkAs4LQHLJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kzrrzx1s0lw8quJt2PdXGz6VbdfRjf40V8Pm/eugYc=;
 b=CdjODh5ejxOtLTRUIC6TC23vMtHXWxfGZkaEYgiYvyUaSyNSmWzcvbOo3gbIyxRBoJOr4eh5JOpw7WRBV6Flrg8uqeX0w00Th61V1nSnmSdkF45ClayNs5yLw4BaAgPszfSV69F6lx2P8h3h+OUOOp4WdKeCi7gTwbJhiMR5iXtLER1zvHV4HaHjnC6ErCdLgY/VXWuZVvSBoy62LvaX3z/aMtaljDRyfnpABEKy9gAkdHqY0u5SK+qzFPvMo+PiWWZQvcekop45enoEUF1sVo7zl4A3c6Tocyp6t1kIyH4LzbR6q1Hg+0Mz6yBVHw83WW73WTqoGi7J+GOjw4afXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by VI0PR04MB10951.eurprd04.prod.outlook.com (2603:10a6:800:25c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 19:21:20 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 19:21:20 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: p.zabel@pengutronix.de,
	robh@kernel.org,
	shawnguo@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	mathieu.poirier@linaro.org,
	shengjiu.wang@nxp.com,
	Frank.Li@nxp.com,
	peng.fan@nxp.com,
	laurentiu.mihalcea@nxp.com,
	iuliana.prodan@nxp.com,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 0/8] imx8mp: Add support to Run/Stall DSP via reset API
Date: Wed, 19 Feb 2025 21:20:54 +0200
Message-Id: <20250219192102.423850-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0267.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::34) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|VI0PR04MB10951:EE_
X-MS-Office365-Filtering-Correlation-Id: 3982b332-80d3-40a8-8412-08dd511a9720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cNRhnkmFdUIL6oarRBOS8zJGroU56a+hQKZMiC3FGHSpddiWkQemrM7bxyU8?=
 =?us-ascii?Q?kL6wOMGtmzgFFbg12FX/j1CrS27eIFOYSeSlpCvhRE9wQiEsvlC1rbEhCRQ9?=
 =?us-ascii?Q?nC49RDUx4Hkkwp1iYS1NJ7ybh/bSh21krJ5gT0f8eJ3xLIbkXRAhFweqmyrl?=
 =?us-ascii?Q?Dd5qm5RQ3Cc6AaFWtlkvXBB67F4KAOmVzIBfySxwqYyvkZPoqYPm9Hc/YOhx?=
 =?us-ascii?Q?hv9M0eSycrJU9xN2uX0TTMgTHKIMFlqkzSubvYq5n5TEXF/G4y3qb6cqFtxg?=
 =?us-ascii?Q?2YOWPOompcRBH9WJCnym9F30HJFxmuX6XHwg0dswW4AizrFCuSGHTuMoxvdO?=
 =?us-ascii?Q?euM05irSpOIYPgv3TNvp3i9EsUAVXNFAUreGHtQWRFw3erK0BS0+3HZcIsuW?=
 =?us-ascii?Q?fUhdVO8ebZcSKezKGpBzx8FHoDZRz/+iSaxg+5wUcaY+/b43o1rZuT8boi2d?=
 =?us-ascii?Q?lUpYOOQJXy3hLDPEQnBnqyyAyQYSN4ePW74G27senODvLbUp6dy5h980jTJd?=
 =?us-ascii?Q?AGyEUHKoB15eAPS7iJXwjQowNvEZCQqZDJERaJhafRl+S4RnaEEHcA+TqNgF?=
 =?us-ascii?Q?nELmyBIQz0CdkfnaMTh4lF8VvpgNHl04n05jd5tTtsGxwuPiTPJ5socB2/H9?=
 =?us-ascii?Q?uOwayKeMaYFYuc7hPk2xqW9MgK2clFm85mwKRtBlQJhfInQUv5KzGInvd5fH?=
 =?us-ascii?Q?CJEriE2Yu7Tkk5DwA8F987MY1HHf4vJs49z8D3uxB1COdYKS81DpZ1l7WyyD?=
 =?us-ascii?Q?R+xgTB6dULle8CIh4z7kT5JJ0iplV1ruAw2qKWbLNT7nARw6iwWUrL5Pwkut?=
 =?us-ascii?Q?hY5k5ua3btHqLlDWbz/hSrW7vOZMBkMqUFum7rTekrj5eY+zfdGm2zD0X6Py?=
 =?us-ascii?Q?75du+HVsME5WJcig/RnHJ006+Kk6UitiqIpcty/gevRXSVhVeB0VvMDItNke?=
 =?us-ascii?Q?OvzDalOyIZsOxSXJ2DQaB9hF0whjfpeUlk/mFdgb4eIigcjAPh9ePjcFePtE?=
 =?us-ascii?Q?aH4/ByYq3lkSb4W2mA8LM9JfZ54nWiURRGKwXy0umOBqnD/9XxuiHzOU4Fby?=
 =?us-ascii?Q?Wmw8Y9TkrU30G660OY13v/gTCYN7Tnfpt4mB3zf8O2iDJQw6m8HzdyWs0i6g?=
 =?us-ascii?Q?44nnqsWXOs9aUcP7PeIFYv+EI5AR2UavhvquBSZz81r5OUW8zwdl/xdJzyH6?=
 =?us-ascii?Q?ICgRi7THUwKBCLXIetZlEcuV8+qGnKvuI65npd06DyGmefi5mLitsEoqnJcF?=
 =?us-ascii?Q?oM+lTEd9aFksG43OLHBsLpEHUsWr9ghI/OJm1WlAWYswghdRFYhhDTe7Smux?=
 =?us-ascii?Q?GFXExvdPq3H6jzrlH/fHCFNbZu1p7JDn5Ys66jTVEi6lwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eIo59vQgHC6RksE2UIG/mOlCd5nQ2xNmJaQxlJfGZgzWcDnJDFRpLlSS1POq?=
 =?us-ascii?Q?dAuuIFpFfxIyybYDAZqSR7voCZvfhNGhYCDWNh5h58TGPv+Fq4ROBAnt8rsZ?=
 =?us-ascii?Q?79tIn/9wNBkvQarmt42fxp5Js2UapTRG5x1gGStzP770ewaT6rRqXubRrWyR?=
 =?us-ascii?Q?KgOPMh4SnhDrU3+l9lzzolXhyFgbVGypba3l5xnTCcGyMypP/kKx0ZjmVmrg?=
 =?us-ascii?Q?RK1b0L2mxjwNHj7YhsK0eT+0W8preomZ7tFgAnsCnNQPAu82Ms0PgX+TXYTB?=
 =?us-ascii?Q?z+iudo6k6y72PfnmBxp+RuVloq0mZahaSMcskcOzWq1VmznKjUe6MeRf3m/V?=
 =?us-ascii?Q?mZFQskSuNNffNQYuIRtop49Z/RuLBRigxyd6NRf1CoaFnxyR7EVJ87vQW7cH?=
 =?us-ascii?Q?FNeZ9X4fPxAGK4l+ksz/O8uNP2yOttz+RCLcmW5hKS3ns0G3hsTJ12LSFunS?=
 =?us-ascii?Q?sDjb90mLPh+ZNSL+yg4e96oj4fhzGHlaHJYShpb0sN5gZjivU++woLSTEool?=
 =?us-ascii?Q?6wj1DHJQ/hrm6HJpTnGt2YXs5SDGAmJ/XLym6nAlRJm2d+jAgz2fBpYbQOPS?=
 =?us-ascii?Q?MJRAI5gQABpfzFeyCdHu16ZFPVMlslSuRG2/UbXu0uHdOcUM29yR4IT2nqim?=
 =?us-ascii?Q?DhhfdjmNweOswWOo/vH8Q/qlhEgU25Jkx/5nEZIgOVNlIwK/+aBjLsNYwOUo?=
 =?us-ascii?Q?mSvCsdWzCYFyvsBsTsOPeYclj3NxTpZ7SWrBCxMkokNL5mvZToxD1EoJfwtt?=
 =?us-ascii?Q?jMbslmJkRZBbKj9zRoraQiNTdZCHjC8bUB4p5amadTDV4SHuS4RpgsiY4spV?=
 =?us-ascii?Q?HK1whfgM76b+2cLsgXFYsmodEriZixcrIsljo4ITuBCfUKiYLiY9lFssEyAB?=
 =?us-ascii?Q?qV0Sd70dWO+i3BynIwpgEZZG45hD5b27dOC63Bq9y9chLT+/YNuzaboK1j9n?=
 =?us-ascii?Q?pLcrszX4GQ+3IH+pZ7Yaj9LG+MRA7EEF3qHowPuRdIdes4DcokUdWPOdAGfv?=
 =?us-ascii?Q?uowe3MddQyQaAi4Uicl/AvcBQJ/PIJ6ABVRJoEW9oHIPAhvfRt+lv5X5F6p2?=
 =?us-ascii?Q?+iws3BbEjvQTd5nkXbZMmoBcfjs4DMZ+fkZAlQyaGWcDEKhGJUqSjhtldNJk?=
 =?us-ascii?Q?IQ+ppSIBTCduUUKVVChIQAasjVSkjQB5HfO53eglDu6bR9UxwRo22W3e6rsO?=
 =?us-ascii?Q?cIGN32HdrtSIl+2TCA79cixUOBU0J8z1PRQO0lPEPRJaudIICZtdNWR9ksNw?=
 =?us-ascii?Q?3g01I/LRx8V/WRcFlo4WUpMVTBt5+MlIzINe8YnjyoSI0MQHUqdLfm6/Nb8D?=
 =?us-ascii?Q?f3fuSa5DpMR5zvVaQheTC+btMhxl/Q0gPJ4dGWsTvXB7jAzGExPWgFYH4lnz?=
 =?us-ascii?Q?NQtRc4bzSqy0E0P3bWob2G8Lgnk5bQHFql2nJEuN/ZEpAJTzEQgbWPiLOovw?=
 =?us-ascii?Q?rGIg1vYyCJDq9z4ME/YPG4UEtBjX6B5l0oMa2CI7GGaZcpbWJnvpYR9Q87AW?=
 =?us-ascii?Q?Nrm1Tx9iByvp9HvaLjVg9t23FlXKXN2NQ5IfvL5U6gSA4OkUHtJ4doE1bvhC?=
 =?us-ascii?Q?2fU0EvitvU2RqKvVVYtWdTAPHlAusLTIUFvJ6ECsjewW26uPY4pxOUN5LgJ0?=
 =?us-ascii?Q?zph11WpNxyCD7vIjndUYnqezZ0OO6BMhGK5q/iS5lTMPUKVUwwZfTPJio/K6?=
 =?us-ascii?Q?d246ww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3982b332-80d3-40a8-8412-08dd511a9720
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 19:21:20.4947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aolr3zHiX77iI/R3OZj1SiiHo5Xt/AJfuNDP6V6Iv5qe2k1zbtsSIvTBB6MUw2lOBZ3lKQjsahWJMdlUmYxfzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10951

This patch series adds support to Run/Stall DSP found on i.MX8MP via the
reset controller API.

I've addressed all review comments from v1
(https://www.spinics.net/lists/kernel/msg5556023.html)
and because of the review I've introduced 3 new patches (1-3) in order
to support resets ids via dt-bindings from
include/dt-bindings/reset/imx8mp-reset-audiomix.h

Also picked up all R-b from Frank Li, Peng Fan and  Philipp Zabel.

Patches 1,2, 4-7 - should go via reset controller tree.
Patch 8 - should go via remoteproc tree.

Later after all these patches are merged we can also merge patch 3/8
via dts tree (Shawn's tree).

Daniel Baluta (8):
  dt-bindings: reset: audiomix: Add reset ids for EARC and DSP
  dt-bindings: dsp: fsl,dsp: Add resets property
  arm64: dts: imx8mp: Add resets to dsp node
  reset: imx8mp-audiomix: Add prefix for internal macro
  reset: imx8mp-audiomix: Prepare the code for more reset bits
  reset: imx8mp-audiomix: Introduce active_low configuration option
  reset: imx8mp-audiomix: Add support for DSP run/stall
  imx_dsp_rproc: Use reset controller API to control the DSP

 .../devicetree/bindings/dsp/fsl,dsp.yaml      | 19 ++++-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  2 +
 drivers/remoteproc/imx_dsp_rproc.c            | 25 ++++--
 drivers/remoteproc/imx_rproc.h                |  2 +
 drivers/reset/reset-imx8mp-audiomix.c         | 77 +++++++++++++------
 .../dt-bindings/reset/imx8mp-reset-audiomix.h | 13 ++++
 6 files changed, 107 insertions(+), 31 deletions(-)
 create mode 100644 include/dt-bindings/reset/imx8mp-reset-audiomix.h

-- 
2.25.1


