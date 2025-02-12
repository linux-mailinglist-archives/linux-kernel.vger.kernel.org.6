Return-Path: <linux-kernel+bounces-510748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AB8A32172
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506E3188785E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F53205AA6;
	Wed, 12 Feb 2025 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oDIsCih+"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F7C1E9915;
	Wed, 12 Feb 2025 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350290; cv=fail; b=biDwDrtDcV6Gustlxf4AY7yQAvzjd5aZ8R+ZD0K8G7riw16p7BtfmquWOQM/HqDQGqbaBjOqAnbKCq4R+Ed09gdwBZoCTegc2B81nFK5W7qMA3s1nUWl0PpAqTuUX65UhkqtKfa9kkYOQZ5e1HvH86MGBiMLnud+JQNxYaK8Dg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350290; c=relaxed/simple;
	bh=imE4iiX7u35u2nFPCxQsuAu4IjPONrSy5mOVEsPQow8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FlZ9XNp2JUULdQn2fNBKyYE//uMxYGn7RnGwFg5dzQ5akKeS9G5QS3djT4EBSzQ994fLQPE973QwNeMyqigghVOp3cPdaF6XHMntfSvt4HCFmyhLFplpbECe4FkfkEL7Q+X+1mA6IaxoX0zG+M11MiYtlMBk0Z6g1mTmWBhL7H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oDIsCih+; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKtCNJxGbSAHPFl2nfqgwnhciAM21QiQPMK8DDHh426TPtow4nVfWiyJFt2eeEdm87viRxUs3eBrf2oMMfgr7WZNBgcXZ0h1PfP7LqjAqjadp0UTcQJrsCLRVDu9ljTHZ8CUe/71IModmskC1W0Zowp4tpnA5ctM1h3VVCFD3FiNRhON3bU/5sfAcXlRvx8lT1ODbCg9cmAWSFPiUY4ZhHkegQ8xHAq1QQ+Vcu+R1G4ESF2UcENOvkEN9HsW0Lar9MxyUDYhKZeQJLu55gEmP3pxhx88r2U4O54CdyMfVVvWk2ViVfRoRUzqPC1Ieym5CIVxdw5NdmTtKS8GqHMXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bz4MJO2mSFnMqOkg5vPSZHgnvPdE4psA+8nq54Ix8pQ=;
 b=t4vBoRviY6NnXXJ/WGRu2eRYAF1FRAHSsZqozOiHuKys1ToODmOEUOdIAktE2fTujhfczcnTdJL7aa/6Nm97GLMB9w+M9z8zk0vycK32wbbupQgxwtzgSF3R7p1WfhT9JvXcTtq6W915k7Dn82u50Q6nuOha/GHgw843KV2ImZCyt0hJyb4YfwwQ9w4bXhOET2/FxBNzmCOFKGT6DNfTCFGAA6o1njhOLLSbU8jet/ujxQ4HD8fMFxCBdtP6ijMhg3w6Me420HgnxvMqyElKCWrRxfdB3Tl9A3+y6igg/KTUbmTHMCda4MVJEoqI6reaySn5bItzAf4VfEissA/UTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bz4MJO2mSFnMqOkg5vPSZHgnvPdE4psA+8nq54Ix8pQ=;
 b=oDIsCih+W37MvLJKipPX/rxMDWy10sgmW4tkIPi34sZOd6tUNLeg7w/If7AvxcXSP9n4HyQgh1Q7RcGSuTmre3QH6EdG+r1Sn/j6nOasLlrDR0ceZgSWcV01AA5f4iJZho5+Yvqk2GcGBwoQHMdH6jCZq9mqt2Bz5Egs1osuVYJFgB7bR9wp0qOLW8D0EcXfsrVgFpDo3lrTsmXmz5MANcEC2hjAUp3Nl18R1ASBA4Um1tOorq856uBiCaZENyHp9i/CN6JoP/4QNFAZsBO7nmnEPVUY3yec3pR6CLDWw+KNp07U8WLRh76h8DNBhNhFINpOKTippK4URxUZz9byLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by AS8PR04MB7862.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 08:51:25 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%4]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 08:51:25 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: shawnguo@kernel.org,
	robh@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	frank.li@nxp.com,
	aisheng.dong@nxp.com,
	daniel.baluta@gmail.com,
	laurentiu.mihalcea@nxp.com,
	shengjiu.wang@nxp.com,
	iuliana.prodan@nxp.com,
	a.fatoum@pengutronix.de,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v4 0/6] Configure imx8mp dsp node for rproc usage
Date: Wed, 12 Feb 2025 10:52:16 +0200
Message-ID: <20250212085222.107102-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0003.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::9) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|AS8PR04MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 7316e737-5018-488a-b106-08dd4b426e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8z1FvTVbE+24/Duyvb7w3qJuNHN+1/frqwfSFTjFrsBFHEIFNHENnrsq5scq?=
 =?us-ascii?Q?04qrBJShJ697IR6tHAHAxPeuhS1c2HvPhxazAKnr+euBvfqVg7IGTj/Ab4yr?=
 =?us-ascii?Q?AICzOkjTLEcmAkiPHn9G5WqBeYD/imlYT7O1Yek5bIG0Q3gHJYbFpjnXVyCA?=
 =?us-ascii?Q?B+xbDSfFmwRLi1jI3ZZW9GghROsN7zy2Nqmy8DrjS/YZXghCVXOepMofckpR?=
 =?us-ascii?Q?ro56lkki8vwa2DplFG1wul53s7kmRvZBi1gi6LBPe6khWzVsBNI4b8rapHYK?=
 =?us-ascii?Q?Z7yAt7N49usfPMngOrcQlNj1V2dFmwlgrCAk5If+hhOTz7U/s7ksfjhAQ6Lb?=
 =?us-ascii?Q?LthaonvJyhva8BzxhabxMKmGseqsAbZvqYTwLC5tXcNa66BbNO1On3JvHTA7?=
 =?us-ascii?Q?Lba4+4QfBZk6aaGJevBHFTO6sX6/JK+wnZQkAkqzoxPzy93qXQOXyZfg454o?=
 =?us-ascii?Q?YP5NiVp/xxy+jBbz5pQN3A6Wc/FYLZeuXY1LFUWXdeVhYEseUNuleE/A83Au?=
 =?us-ascii?Q?LO/e6JrzsTqIWMmVvEBlQk+ATbhrXeLLM+ZGuEmDDbIBgEAZAmC3pejFPEi/?=
 =?us-ascii?Q?3sdw3SqFPXFwgAlvtiViMCKemuYRL/6YTf1E/q7E+Ok/2Dl17c5gU7uEoLKP?=
 =?us-ascii?Q?IgLmnRk9vl8nQuamHvcXqmCIcomO4+6kGGrQee8tWYWL53miFH+gJh7E0qyT?=
 =?us-ascii?Q?nJHGxB4APs47dLkXqY7Kd6kUNrIBYHUxkp0zHJxuvjPOJcJ5gIY8ylVr/Z2E?=
 =?us-ascii?Q?j86+rxKPoruVn0EinsvOuoePC7NUOWTmt740RKQBf4P79n9fB8hfJpkk4564?=
 =?us-ascii?Q?LnbnZA8BgKHxp0IBt/e48/zDuWmDDZtFXYXZy8NQQ7tWuIG378VycKpDFVst?=
 =?us-ascii?Q?+U4DAUOBvg6KS7ZjV8J74AFcm/VTeErAbB3sE3BQcfR7mt6JIchP/Bb8AsUR?=
 =?us-ascii?Q?Xcboux34AZvcH9Ad3L8LC//RPlJN6z4qfIZ93FJX5umSz5AjruNbp52RVeK4?=
 =?us-ascii?Q?f6n0Y6xwZiB32gVX/H9zI1ipprn6YCy+eFKvQPCWrNteXoyyX7BDbiQd5alu?=
 =?us-ascii?Q?PKJQycq4Y/+Pj14Hx8zbA+HEPELzM7Kh48JrihLUaCj61GeoJPddGloIw6vZ?=
 =?us-ascii?Q?DjaeCCSniwVWS1u62A4RI7avSMM5fEwmaBHE2VlVmqMNZoLyFAL/GeAIHTOM?=
 =?us-ascii?Q?ZArIfdt2O+xvaNtuoMGbLj6EvBew8E12oxS3+8LSEdJ11FiOcnuR5Vu2/QlB?=
 =?us-ascii?Q?MofBF8QXsOIKX8uInBmZbLxDsbwnfqdVgH/Vifprej50XlTJttKpFktGmBaR?=
 =?us-ascii?Q?v6uDbuBi99sHHeFE8Fc9d/mhE6IaMuWh6vmXg5PTq0JNXVUphILJ2u7TkXeZ?=
 =?us-ascii?Q?suQ+iJu1pG07qgP5YQGyby9Jem1j7Ire6+SEd31K5arm2ZbZXSsYZqskV3c9?=
 =?us-ascii?Q?np3pHLOMf23Fips8WO4lITHOTU5wrOTf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QsXWpFD40A03vzNgIZ3DfS9KjYqp3GMaiZjNS4jzmcTGDb09aALFqk/o2qyO?=
 =?us-ascii?Q?YF6xqPyfx3IrrLTmI74rg84UInhYACAJN+nnbPym2AjoYXjcGbqYUIxBF/ic?=
 =?us-ascii?Q?qqvz5VEUSpF1s8JtVN/tDi4Bx4llCPy0mbeXqrDhSBgIVhKysh5DqRWJF9sY?=
 =?us-ascii?Q?Wx1XBYNGJBn/niYwtcI1NV1ecQhyedn8EevNBYO8gwKpsM9JCC9OAgt+o2pV?=
 =?us-ascii?Q?wZtryJDCCRUXineoD3rvCjDrLVPeHSJ1VLUyh6qpcIm3l9GrLa+0ECfcup07?=
 =?us-ascii?Q?1qYsCw0rDmWND1DbwlpDQJfirAncCFPbKy1/KJJkkvT0r2isy0z4euadiPj/?=
 =?us-ascii?Q?abvhuUC9KNVICedVmmSicQkqKrj2MQl+RDeQMr2hypPp+8hAy58nd+Kgtl2Z?=
 =?us-ascii?Q?ILkTVpSox0qTXTm9bElAvZoDMTzJ+2tSYDkZT+rf50CbCelBp/dQOI+QdzAu?=
 =?us-ascii?Q?zfmwbaRj7n6kSiUQLBVjG60Q3a24UMrZqT/LeNuMLst6vAg6/OkofDVkbsd5?=
 =?us-ascii?Q?ltZ4jwNTvSdRabM2FnTXYnEpxYqqhPfyflt93ouugmCV7X5NCE24EKizwggP?=
 =?us-ascii?Q?ef/HfwQRdwqJevNS2lZjTtOHpSgEplkXbS9+xa7XGZqZI0SKIReqaPlbjKZU?=
 =?us-ascii?Q?PXo7JUhYjMW7BJb4dsNgfscffrBHdSP55rYBbze/hiD1SD8hSN4AYZxJHcQj?=
 =?us-ascii?Q?M+yV1i6ZsAbfS1ScsJVyqZZ8r7vEj7S2q+ieH4OTLgTpOTUkbP4f736KxvvF?=
 =?us-ascii?Q?cihBbDiR1KKeC86zFPuuzUixpXANYeKxjndEqKu+a3Yfz1lgxTeFcM4NLs/i?=
 =?us-ascii?Q?1sT8Mmf1ys8ZDixtaahWi3jluvDYomV25cr+C07G2qVosrfEKj64fpmPjn8Y?=
 =?us-ascii?Q?fNzllWk78ItYO5Fzlbk354VUN0AwIm/6UhxXOG2EAGp1QNQqQmfaWJ/AciZ9?=
 =?us-ascii?Q?AZD53qrVTkBrnmzKwyqLe5s0Afq4BpEAUqfJtchceJvchwwE0r7SdbtkARbR?=
 =?us-ascii?Q?BwvVUsRGD/rP9le2NQAj7n05x7Qysz3UCG+FGtknvq1Yfy2BZYUfxqxiApom?=
 =?us-ascii?Q?xHPN2a5k3yLlkS9/uJjYLhHoWFuZsjFvG10p9Ge9pC/RF0jqWFD+5ZOYh4AP?=
 =?us-ascii?Q?adIArDei4wvASKTSRGye8XrhfuVpg7JP85j/zmUu/BqxOMIVx8qT2g1mz01p?=
 =?us-ascii?Q?WO8Y6mfySUQ+VsweSbm967yad1CaPXilwtX2cV0kvGTR9jjOG4QkzYDu0ez7?=
 =?us-ascii?Q?9pKwKMhkW2Q0bCAlIoa/ssl3L1HNfylsdC1icm9Zk9aIEEUkRqB5XMTBFd42?=
 =?us-ascii?Q?rfomuw7vVS4sJh/+h7HFLjwfjV20JQGnIWUCGLM4sizkxbvdHjb9P9xydvt2?=
 =?us-ascii?Q?xjloxv8EsaR0Dev7f52oV11HS1vra8f+fYDEnijRFFZVtn1Dg6YOz91krwFw?=
 =?us-ascii?Q?ybjl4l4hqQezSm5u37Hv2hxQOJMofXvnlwOSxDqcS5E9iUKr7JwO2vnpg4ia?=
 =?us-ascii?Q?pvdPHKLqJvWWr/OepouhD5z0ysBvaHO6K0PtO23AoyUeJtKdfp9Y2rUHiyUE?=
 =?us-ascii?Q?XKTnD9PgGz516N7TYw7gtnQPnvipH8fQxP4+5CB3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7316e737-5018-488a-b106-08dd4b426e7a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 08:51:25.3391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIKwtSf3L7dk2W/OV1Np8o3HFu5fvPvUqcNWO/kUhBuI4UoJXsGHti90+GBkPzAxgkspYV/46Q31TZ2MD/H/1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7862

DSP found in i.MX8MP SOC can be used by multiple frameworks in order to
enable various applications:
        - rproc/rpmsg framework, used to load for example Zephyr samples
        - Sound Open Firmware, used to enable various audio processing
          pipelines.

Current dsp node was configured with SOF in mind but it doesn't work
well with imx8mp-evk dts. SOF controls audio IPs from firmware side
while imx8mp-evk.dts preffers to control audio IPs from Linux side.

So, configure 'dsp' node to be used with rproc scenario and later will
add a separate dts or an overlay to configure the node for SOF.

This patch series configures and enables dsp node to be used with rproc.

Changes since v3:
	- clarify controversy on the need of abstracting the AudioMix
          as a reset controlle for DSP. This is not the case! Audiomix is used only for
          Reset/Stall and it doesn't have the capability to reset the DSP. Reset
          is done via a separate interface (DAP).
	- Removed duplicate clock in patch 3/6
        - Add R-b tags.

Changes since v2:
        - Fix dts example in patch 4/6

Changes since v1:
        - document syscon compatible as pointed by Peng Fan
        - do not disable dsp_reserved node in the dtsi file as pointed
          by Ahmad Fatoum.


Daniel Baluta (6):
  arm64: dts: imx8mp: Add mu2 root clock
  arm64: dts: imx8mp: Configure dsp node for rproc usage
  arm64: dts: imx8mp: Add DSP clocks
  dt-bindings: clock: imx8mp: Add syscon compatible
  arm64: dts: imx8mp: Add fsl,dsp-ctrl property for dsp
  arm64: dts: Add dsp rproc related mem regions

 .../bindings/clock/imx8mp-audiomix.yaml       |  6 ++++--
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  | 10 +++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 21 ++++++++++++-------
 3 files changed, 27 insertions(+), 10 deletions(-)

-- 
2.43.0


