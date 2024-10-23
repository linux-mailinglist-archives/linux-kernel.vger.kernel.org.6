Return-Path: <linux-kernel+bounces-377236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CA29ABBCB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FDB0284C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D41E75809;
	Wed, 23 Oct 2024 02:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A1xbwQ4s"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3050A3E49D;
	Wed, 23 Oct 2024 02:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651641; cv=fail; b=M90b3eynNHq6BDGbx9rTCZy/SnrnSdzZF0EwPa/ckOOZ992Ehb082axk3SpE1d5Mjaztgglf/F1OnL5ZNWPXcM0lyrdtWWVYmreeYLZukhF6e3y1UBaP8sKQmjT/gENTskY923kJkwuEiqwMa8vkEzsAE7INAsjBw979UmRotWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651641; c=relaxed/simple;
	bh=MtKYQuIz7dKi9I024ajpOT3v/xrCJlTaBYf2AG2tqPU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=P6wTcT1tLyBo7uUWr7ldFKrMxv7wfFJMLDZxUiHF6L8PcvvNLTRpe1Scf9+PLE65XG0h7Q8HF4NrLOuyD6jpZL5EoPm2erpdJtSbqblNDiMXd99SJc2em3zu4j0VsjS+VaqpmWxadCcysiqhAo6md1woyTEnC5y4XKWVXP9I6lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A1xbwQ4s; arc=fail smtp.client-ip=40.107.105.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFwugvaY1K4VLFiJ3cIss2WRhcnK0kYyTl5wrMM+SMV8B8FoEiUb/9DqbC47o/0GPIimKekPE1o/9HlWOjmAn+d1Jg6F7GHsYfVkymMoZoyVGPVL0LFVvDsctuc1URaGVpgsn1avemjineOBKhuhIGtZ8YTSvCBmZ8yQbYMKXM8udTAXorLq49RcR87EiSmgBIXQ7mCxzFqxB5uyDzTR+zASC5KE8xlGEHr5NsDneiAzk54JWRaJSaBR0aO01RNsxXUC6JzeRt5dhTpG3sWLEx3fkse6xXRJ2W7TuODmWmE3aWfdLaBEhE2CqVfZwFoakcvC4N5I72cBtOmhvBUuFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJ09kDpAHUt6XodVDNFWX/4H++vYijEWhFOErDupOyY=;
 b=kZix8Hd3KCbJSwVBxkXeDgJk33ToGv21g2+YKXqAJliholvtRw04C7SITCy+YstzmnVThG5EMtoZxs7+IsRsbEbvUBxrIRetOw1EFDNQe7L6969whVCFn+gmd9+iMlPETL8NQVFsAOP1yFEj2X6EA+JHqOKPLYkzpY8CuW+7KPIlO+QAVGKDfVX2LiPJbAWxA4femzYGARER3OQoIRXzbhjxJI8Zb+bbRu9bCrp9RGnckMLQSks8gtZ9MIK2583QPKmf201Uiee81bO/QdcjEN33eF3AwwQY2+IAViobvCxyxNvIni6Tbe+85jbcvw0krIPqePcbrnBSSM+RkoLQhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJ09kDpAHUt6XodVDNFWX/4H++vYijEWhFOErDupOyY=;
 b=A1xbwQ4sYBfKp+snDI43cUgPPW8KXtZYlLwddq3meodKYNK66wKVG5/syPytu5N4UCuDUZPbyhH2w13ZAg8T7iK9feY29ybXx2J8Sl//x0yQTI+yTf/cUHdyztneL2SfYevS+YVyB8jOBtRt0PjWKLRfGpOlBLtfUI12P71Z4d45uUwxC9aBgwDzjeG0iWSa08/F0MY3Yy5brdkNzmZLs8dHK0Ly0tkF3D7mx8tNzE1NZv63+fiFY5XDhBV3Ge91QlabN3nAZ6YeMQfDN89c9lWqmxKr9nZQGwPaBSYdmunuwTe7REBAwn3yd1gL2n6ya2sk7ArokVNf/K6hMMm++w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by GV1PR04MB9216.eurprd04.prod.outlook.com (2603:10a6:150:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 23 Oct
 2024 02:47:15 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 02:47:15 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: krzk+dt@kernel.org,
	robh@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] Add iMX91 clock driver support
Date: Wed, 23 Oct 2024 11:46:46 -0700
Message-Id: <20241023184651.381265-1-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:4:91::22) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|GV1PR04MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7e6b4e-eefe-4189-af91-08dcf30d0096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EQnchLd4B3jxFZcJ+ZIxSuncmHmupDw7Jks4+zwCA0qIpvApmUOx7KwneTee?=
 =?us-ascii?Q?DDPKpiJt3Pz+54pk2DDg7gDc3PY1CHvA4F1LMMXPeMr6DDuvEagzitYP56WI?=
 =?us-ascii?Q?TxSDy4a2Hv3Ftzr0hHqcQt8eP+l5JDpjlyS6PPzoDq7uQ/0lOL4BUZn55WRl?=
 =?us-ascii?Q?Td1GD0knvcpWZrEavQliPjvzcvBUYi/LLjMLcAzZVxs5afhUuw+LO7XgT3Qo?=
 =?us-ascii?Q?fFlM6yUdN2rlWG28pfwllz4H1iV2Gha6nKf/Ws8oBUxg83cu/9jwNg7tZCbq?=
 =?us-ascii?Q?F2zWS7CK6vXNbUIH++Lr7ngjS1U1/CjE1s4P8bc9pF2u/Fxe31d8VNsvAsUk?=
 =?us-ascii?Q?E7WarpL8YTPe8n1/LAglnDEX2QFnRE1G8seeDzexN0xZpH3v88vCQSAAA/F0?=
 =?us-ascii?Q?DAgHdk6CyR7P3uCsgbvWJ5nb0sbZQqAGpCzB998kkwL5CSBP+ioqxVbVZDii?=
 =?us-ascii?Q?jQPzRNTwua11M4DmPRyYWt4J815yJ8xDifbcROIzxJKyXdKiepq4pDJIZ1nU?=
 =?us-ascii?Q?fyoi+gWLcpNOlSlUFnNcOLS1kNApli8hKhuzs+yXiU5vx+gQID/8tc/7gsmW?=
 =?us-ascii?Q?9YeAfBYxp1PTSt05mk1veWUSYtAfN/kWFfSddNHKl5RcHwXguoHH1p8fHLSK?=
 =?us-ascii?Q?vv7C2VIMNIYQ7EfmsAdicHBHJ5pJqRYXlrY4WB+ByUrhU5LchN6ZJj3jmcqF?=
 =?us-ascii?Q?RuDq7l3WO/fHpdSkt17SJ9sp5KlcIkbcTy5NIV9Qr9sk2eZKKrq+6Xc19Aw6?=
 =?us-ascii?Q?AVeAOP6ulqwPJMZ8e1NwIAezzckT9JEcV5HVlOqj6eXxq/nJ+Q/ZrPPFTu5u?=
 =?us-ascii?Q?yuhGUOL/uRz4HF8iol21H0DFqRozHd4zSvxL4wLuV3JM9h5i9QJ4XsPg5LnC?=
 =?us-ascii?Q?YrlD7lOnn+JToF9PROTRcAyKwEMkh73Z3y/c3s+N6WlcVgQB1tm8yr6vFuGm?=
 =?us-ascii?Q?ZL18swdtakjjKf9LGfUOrNwT+RPVdxS3PbAgnvavHzXwQxicDCI5PDG+K51v?=
 =?us-ascii?Q?P8nUze+Qn7YnlxHOG/ko8Yg2qypIdHYKF0V00s/BcjQN1/w5RTK5/SZWrJX9?=
 =?us-ascii?Q?VUnv7LetkiKh99eFD9BXNCPFqSHsu045kMzP9gXshugvrhS9+GG2wIXUIEzR?=
 =?us-ascii?Q?KwcZssbuHqmUC5C9gbzZKZ0D5N+coTAYrtBLU62bt/X2FV2yNWmr7HEBv+D5?=
 =?us-ascii?Q?HRmt54JU9Ze+b6TiEGrb90yL6yto/2INmkvb1heqfValfU0/gZXpkITF5jHR?=
 =?us-ascii?Q?e5/JGF8kms0nhmCHPTaesXsH977ifALYDuIX0v75HlwqNGkIxmF9HIXYg6NT?=
 =?us-ascii?Q?7as7Og1eg4GwOWe2EfeWke5YyNIiMy99JSXgZ8QLvl1CHZhViRNyVyeoM4GM?=
 =?us-ascii?Q?U1GioBxpogAcohd1dBnpJVHVlAPD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YBgZoG8cLVmcAPyWVoSiq0/izH6t/uHbQMBBS84cwdcMkyB/pnqDU2ssty6C?=
 =?us-ascii?Q?UFDngOFrtxy8G6ZPn2x/q5phIWkgSglBxEYOXjlis+qQEOdCLls646abbRE/?=
 =?us-ascii?Q?LD8pchqdtM/UQF1jvx4CkD4vRIUKtCQpeWrq2vX8WiiTMMl3tD/yP1wb97e/?=
 =?us-ascii?Q?HeBjbSWVG/AqglyNAwIUOazRl7DQqG4a1yeUgAf+2aH5G1jkReIJmeaBphdw?=
 =?us-ascii?Q?FdP+AbzMDIsFKVi5vtI4ZC7kFWGIvHQ3YSdNkQzmoOwejP3fF5VeGTg1uJUH?=
 =?us-ascii?Q?Oj+5bML6gPFwgHmtCvHP79c3mzpypNe6nhq1QHvdMi469qek7AsPB22jWoJP?=
 =?us-ascii?Q?8Zn4XiMkOG79E3gcMXaqi/zooHYbOQOBrJ86QqIpI8QKQDCRTxzlqri3tDXK?=
 =?us-ascii?Q?IZ4TQDr9awThixMBoqkcFddVrHNG1N0qc/mvqmmfFPip/I2eYqu2xNBQwoma?=
 =?us-ascii?Q?8Hr8cyFyiuNbZRUCEHx/wfFNdYt4FEFPC+wHTUpugvRZ6W5P5kT0Lmu2sHVV?=
 =?us-ascii?Q?e+Y8fyJg2KMcZrTMzacmXvN6seIeQ5gV+4uxuEKFNsLPsRnl0Cq6PXNhDJmQ?=
 =?us-ascii?Q?pLsUJBPNWynPxPlVbz9VIj/4gqkOcgxh9vGW+v04W2BDYd4sUJtQ5C2mAEoc?=
 =?us-ascii?Q?6ZaY78M2QcR1PNuPbCjIzGHNk1QxA4n92uRgEJCt++x/VNWce4qPgo5Qrcbh?=
 =?us-ascii?Q?7YXx3/yQNX+HLaSpaaHkkm4aGr30ox6u2zBCWyPbPZ4rbd2LQJjA4nsUUmfb?=
 =?us-ascii?Q?tszjV4Yi5wIaZJl8JTvOOv7YPfoEFwG0ttQmksZj7mTPCMpEMlNsEFdTXkGy?=
 =?us-ascii?Q?7uVQ2i2RFqAM0BHic+patBl2JNHphHS/PONchaC9+GvNgy7T52fMj5pbv8AO?=
 =?us-ascii?Q?SyeN75Rqmr/7Nh4ccErW8IZs6bdXWfgdtiIxfCExFp04U1Om3AoUXjG48XmN?=
 =?us-ascii?Q?AGNxyg2kemX1yk8GDLiXWHItfcWf44DZdLPUt1ne8X0THLGvTOPaqpUhUXsy?=
 =?us-ascii?Q?oKgwJ+UzAxKhlPnTrF3t0nYrn0ANVpSevNftr0hj67Q/c6KPf7sLkiUsZCGB?=
 =?us-ascii?Q?tcz3mcuz02zCP7aE95oDIML/Yrq6W6jXZ5dxt9c3//v4YacE0Zf83WD348tc?=
 =?us-ascii?Q?wPMlGsoZQRibs8EQLcG/vkDrNbUh8fy14hL143yiUmPHroZqDUODVEvDzBny?=
 =?us-ascii?Q?4KEcclH8UGFWUGKd68JEe64zoajvs2+3C/PmRPWjADSwYHRP8ri34H2DDeQB?=
 =?us-ascii?Q?LoP6wmfZ8/5exqgNB8rW5toJgKNZ1G3sMXPwuc1wK8djab7a0QYy7v7T1okI?=
 =?us-ascii?Q?QZLFrs/bpyAFHTIovp9HoOxQwk/3FeLTtW4/pMN9mSh7wAUbQv6/qcr/3PTV?=
 =?us-ascii?Q?whgAAnwv7RNi7LrdtPFS2RoQ5TaxhJPKHkygGxeJ/a2GsJY0TU8q3+LkOYOB?=
 =?us-ascii?Q?0JbJGmjYb1GiDOaGBJDQfJqb92Tpqh6WYA4WQc5nUEvJ9KE/gDkRqRMvN4At?=
 =?us-ascii?Q?kgs/8OXKVaYd5KJyoF+kCQ2r0wISqBdU0ivN1jwXhruwK4lSrQg8kw8Z/Hej?=
 =?us-ascii?Q?FvUpimpAKQFXcJIrv4Qd08QskTPb9E8GwBrtvjtL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7e6b4e-eefe-4189-af91-08dcf30d0096
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 02:47:15.3429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4C8PGrHvYdGyiXjZVUAcy9GxO51uSuCwZ4fMy/UO1BK7pRFDvgY3LV5U6m/9IL3r8aPn7zY6/ZJPJo4/jXnWYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9216

This patch set is to add some new clocks to binding header and driver.

IMX93_CLK_END was previously defined in imx93-clock.h to indicate
the number of clocks. However, it is not part of the ABI. For starters
it does no really appear in DTS. But what's more important - new clocks
are described later, which contradicts this define in binding header.
So move this macro to clock driver.

---
Change for v6:
- Fix checkpatch issues for patch 4: 'clk: imx: add i.MX91 clk'
- link to v5: https://lore.kernel.org/all/20241017225137.1158924-1-pengfei.li_1@nxp.com/

Pengfei Li (4):
  clk: imx93: Move IMX93_CLK_END macro to clk driver
  dt-bindings: clock: imx93: Drop IMX93_CLK_END macro definition
  dt-bindings: clock: Add i.MX91 clock support
  clk: imx: add i.MX91 clk

 .../bindings/clock/imx93-clock.yaml           |  1 +
 drivers/clk/imx/clk-imx93.c                   | 63 ++++++++++++-------
 include/dt-bindings/clock/imx93-clock.h       |  6 +-
 3 files changed, 46 insertions(+), 24 deletions(-)

-- 
2.34.1


