Return-Path: <linux-kernel+bounces-311842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D7E968E76
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 21:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58DA1C2278B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB151A3022;
	Mon,  2 Sep 2024 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D5d2SAbC"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC861A3ABB;
	Mon,  2 Sep 2024 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725305438; cv=fail; b=ZxVUPoa4Es4i5cV6PSb0mwXwAeiM3EU1MiIOZbWBAVW55KUeXHwtIKQnRzIHClNdeCB3ZdH44JWGozbo+YviHuL9vUCWFBgSQxLzMqd6DgQJk8mtdATBUo0T5SzeBjoEpYfU71xWMnOUWh3o2Ty52CNCDGmqyrY7Q4PEI18D8P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725305438; c=relaxed/simple;
	bh=4Dd5CEHfnvGXHDPjX0plxBHpSzU+2mIOZdsFVTeq6ao=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=g9PNr4aFplOJ7w6LNx/LpQ9arGo054axH233GMe67Gyba9hzAtkIb1Yapg5cUF7kREAhGJo73az+VLyA/I2WtsO5vq1UIDVFTkCxI+OtxHbjDuX6M4B2OZwj69asTLgYzo8c7P+pDHHZjpOpH0d0ockfS9RuW1tGYyJQ400PTFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D5d2SAbC; arc=fail smtp.client-ip=40.107.22.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xz98wUTK1rljk9NqSlPs6ph9CrVamqcd7EXFrr8CK/1qQNjCqM5ioDyRMlyWqave11FMvAGcCdA2322vfNjJ2+Mlnu13wFiW8qfWtwn1jfqF3xCptoh6aBRYeZrVeEsDULBGQXFYIMMcU026DlRelfIG1Xj03Sl7TR8nPcVngGSDRawbvsLSuMUzxifU7JSp1OSxsPomuwR5NTXFWXVgQweaiHotDLw2egM3yytSTi6ycVSNnEy2vUL1WDG8SYu6OFgDNlA1J0Wa+0ahUizRuYIdGdIfNxzRJbSUDy1k1oPSyWboZacUBf4/WDUZ22HwN+hlRg4zvFjlpHtFRKPruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwiY0Lxpc1eV9uulU5h7qu4Gqm6ZAklFq87JmeLXU/s=;
 b=p+KnByGyrJl7SFCckUKL49ls63ylHXM6vTA1EHPreJWoRUZGZFF0EUm7XXB88yaXtUgwiHENqEu5+NI7z1Wsi8rohRhlFzxUUQWg+7wTlnhvTuye3fa+3R/5TGfw+Xx0Hv/8GUgM4V9G4q0rgV1hl01VMow3PEWWpU00UPhqAogoH8AMo3F5yX5w7y20XHOL6y51g95Y8wG0ZVSqiQeee7991/Os+HUItFDfHe/Nqywny/IBq0wmvC98Tc/jVZezsbAZhWZl14PjwpFMtIUhADn/AAWJL68u9oE5IDOUto7/XyUrAexvGkG8LQCioSFLzIXXAm/V1a6DmT1yasdnig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwiY0Lxpc1eV9uulU5h7qu4Gqm6ZAklFq87JmeLXU/s=;
 b=D5d2SAbC/+Q8Br7SdtoKOsQdy4ASLxjkOBTBdSJrnPZfwJXHiaejQ7TGwoumXMJQ/DvKnALJK1LtZPUwrP/mQGrZf/ipWc/l/7nj/JZBRM4KDfsTlVGgJqFwBG5YA5xLRtKUsok73k7C3HJ5ACwomPoxue+xeeC5Yr5k4/Z+dSZguT7MZ+ehXu3E96Xr8qe0WHUEQ8y/rCduJrUWqjneo8M9bNn4R8nOoqah4C86vsn4TzI4cMFG3D7y26ThLyhbhEaw7VRUIyqhsC2dXiz4zNY2VbR9alPUSU75ewervD4TvTg5n8ezp4GmTfAoqW5mgm5Wb8el96sFkM2A7GuOog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10444.eurprd04.prod.outlook.com (2603:10a6:102:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 19:30:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 19:30:31 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Cc: imx@lists.linux.dev
Subject: [PATCH v3 1/1] arm64: dts: imx: rename gpio hog as <gpio name>-hog
Date: Mon,  2 Sep 2024 15:30:12 -0400
Message-Id: <20240902193013.1456513-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0061.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10444:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b607fa-0ba0-4664-d335-08dccb85b52c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nDDhqc17VgfJgaKK+CUdzWUj7ubcvQ1cM6svo70VDM1MmQ5D78c0XZlidp0s?=
 =?us-ascii?Q?qNGZloShWfdEgouI8kWVcX9YHgRwI5+cJru7AmbSM7Asq8h8CJ5UTuP6OVdj?=
 =?us-ascii?Q?AkS7ky5db719OT2ZUUFTo/M8WzjV9G1LKrFrgm/RCiAzAe7gff8YeTcNoGJz?=
 =?us-ascii?Q?UUvN0GGcBXxHGhMFrieU/tIjFzzu8x8hxWADlBZFhR/gLfJK6DFxnzQta44l?=
 =?us-ascii?Q?jTpX17i6g6X+jRF0Xn0VKXYsSZhHq5EHPWtGaStynWy1ehBRdr5+OXSkMVvm?=
 =?us-ascii?Q?J8x/ingjF1XRRAQgWGlmKhg1Npcl35OqtFcXtHLQoIoXOqy9gqTFGbMv59Ap?=
 =?us-ascii?Q?qJrru6ydT62kT5DWVoJBXOCHNzlKTFTrxzUODH+ep6ui3G7KRrqaSqVthFR/?=
 =?us-ascii?Q?T910FLE0YL0cG4UKFdXG1BGHe+nL51ul9MDf0wwFVhzDLtr1TG8otN5GUmXa?=
 =?us-ascii?Q?LYex0xVkga0dfaRtkdivfTAB5MwpOjKgcdjdfgKQx1aMG0MlBlhGF1Lqkchw?=
 =?us-ascii?Q?qHfQaQB+6RmKOr/H5y47oP5Gu1JZfXYO8lELRWAjxDFyLN8AR9NVvPSBNQmA?=
 =?us-ascii?Q?x+law+7d5IW+MZ2zR8/1SubDas7N4heBuncNCAQr+MI/FdIHygA6SMPLXIfs?=
 =?us-ascii?Q?E02dWRYeFcwAsYCDhmp1tKcBLZ1rjl+JTu8C5b2p8XEY5vig9psFD6D3IULM?=
 =?us-ascii?Q?WVVvRO6vlFKdcVsCUulokZwYYdeg3UWR/ooSDLo4X4LknWn/MRsQrlTx+ot/?=
 =?us-ascii?Q?9EOTinuCYDSzU5R7X+A6st0PIrTKiBD0FqetAkeJP0dzW8/p9gYCYFnP07qX?=
 =?us-ascii?Q?38KzNzj2SidMDtejwQHG8+U5qlHO9WNIQ5IPNaEiRFTJDLeV1iaUqiyP42Nd?=
 =?us-ascii?Q?ygWxO0thm9Uj81dp1I9Xpl0/cI/0CB51/AEgy+c0PJoQUBCI/aHSiFuOD/GD?=
 =?us-ascii?Q?uReSxoqvfo0mDuLhW9jJGbe62p4FIwms0l1DidekXq+Ei7Tqo2YDPaoWOSAb?=
 =?us-ascii?Q?SzzFrQhyiHY0Udf8ZACgsmvSgwbsYR4A+9HCEd30PGSpskYG9LDfWyDx6TQe?=
 =?us-ascii?Q?+StoiMNg7prXRHhJwZuZExW+odPOxhZrma6wH9PLQwH9Vj103tuPqYBn5vHc?=
 =?us-ascii?Q?D0Ni9OtYpkj3NqzDRJYMPicQuWq8Oo/CaWJo81yOQXpd7Tv1Uv6EUUxas7Cx?=
 =?us-ascii?Q?vNlMTlPkxFOulKpG7G8L/7+Ar+oPFczMrgi+EtLQqHdojn1gnIuq/JE27645?=
 =?us-ascii?Q?QFJxolAMt7rBfi+IO5675X3tBIllHvAz4e58TgiMk99TM/jigvCe1rJSRDEo?=
 =?us-ascii?Q?E7UW/4VKOV1VU8Bv7wRMxx+79/3GV1pY0ruKuMpyppnDVEZfeF+xKxLMOZfF?=
 =?us-ascii?Q?4+WvnXWHk/fsyxPBAmqcAqro+pzIfc2fq6dzscXLkZCjnq7m92re1nWQAdOr?=
 =?us-ascii?Q?eKUwww7YJf8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M2wZOF4y6GxgOTHbAJ4HqKGZMYjtNzIAbzuIHR0G36GNQCfZcyoWZGUg0/XP?=
 =?us-ascii?Q?XlafvQToLCpIsds2ZPQcoou4JXkF0ino9olo90jGzFBy2HhYeTAnp9k7YW4L?=
 =?us-ascii?Q?j/TYwnBDaWKjpUVS7IqUfrjGB0rnC4oviehSyoMSNjhUMmW5SJLq5Uh9ZvlJ?=
 =?us-ascii?Q?xBAKHAbH+gUqBYDyUqviEeORHgyuLXwv8jt8E3CG4bxZ3Z70WUTm/HZa2n4k?=
 =?us-ascii?Q?iOrxmbUzPhDcV7RaPIJBL1vPMkTM7WgEsx7M9vUmgJZA2YSbN2WpQOEs6n8g?=
 =?us-ascii?Q?idpArYnixCByTrAv3rC3bKyU+w6wb3IPUc9oiqpY99o9xiyJe8hC4id1lfT+?=
 =?us-ascii?Q?67XvDlSUJS1n+XmSpT3tqs9FJtC4I4dKp7M+r40hrqs9r+NcecsXoimTFLNk?=
 =?us-ascii?Q?zQn0gM6DqLUd023m0UEbwaLubNZ7perFXEEqvzA351IaI13HYE6VNtHeunNv?=
 =?us-ascii?Q?/9SWgNfSTPLnV348SflySpmiLKYER51MGjGUIwf7EiZwRkQN2PW7AFMvkOA9?=
 =?us-ascii?Q?5LuurVfH+sF9cZFWaI/FKF7pnFfLGzJkV7PTcpHt+RjEaZvDgktn/5NZwirU?=
 =?us-ascii?Q?o5lcaLSn3rfa7/CF0AfC8K55hf7Pf0RmVY+b2OS9MWaVBV2APneBcqiJvaQt?=
 =?us-ascii?Q?YC6np1nUEfSE7WBsZewBTIRWufiqP+cPLdDbnnlZbMqEBiQOMMrjTzrRGYEM?=
 =?us-ascii?Q?/1wloaD2r/hwOw1vQcVFYjUJvb4nHsXd+yimdSKBG4Fax5LbmgBeelFaVxqx?=
 =?us-ascii?Q?zNf6dKg4RBN+AOPgmmGUilLfLR68BJgIrhqUWjwEc2pSjZPneqefyZV72s8i?=
 =?us-ascii?Q?VNmWHhPXscTpmVJRJvwYnpL/aFYpzzCtDIixnwVtoXYX9qO5fNBPo+LUFFqD?=
 =?us-ascii?Q?d1HJ7120qlWp3x8/IipWXIg1VCcPHfC4Sz0KAIyqyj3qtJ6Pl7+Fo2kfUA6r?=
 =?us-ascii?Q?rFBL1Aqhsd6yIqmIuYqwqc9JFMP3NPyKNeWS7GrB2/uJci18Ubr/yNAvVPrM?=
 =?us-ascii?Q?rdbZ1jd7kg17rh1heWSfoaR+fSNMbC7dRYUZ6z+aFQ0KocgkVcFB8/ATvvOi?=
 =?us-ascii?Q?qH4abHj0DOfRuRmHIhM8ZXAhKuxhhQ71D9XybMGDtQmMoIHli3pZwWma8v+J?=
 =?us-ascii?Q?8GlON5zpluUDrGlNWowesAUDfZjl9NxcQ/alMG/8qvWMVyXebheAhiqxp8ud?=
 =?us-ascii?Q?k8ddPKz9bZe3C0bQuFnaAEJ/HL+IE2SXEHewDu/kYGG1If7zqB43i/q4FQNx?=
 =?us-ascii?Q?/r1WVvSoTkXW9RKZbUkBZD+XWWvQA89v4zTDOCNpfvyMCdScMJQm363K64nE?=
 =?us-ascii?Q?9VnN/UG/y/DTBnwLhNnXlRTKca3SOFeDgc3r8QFgzkqe8EamcGeGOgCqMogx?=
 =?us-ascii?Q?wUHq35KZh1sndp78DV/TpQ3Rhn/YQ99G9hahbY+VIKbA5P1Th+5SYtuLypSl?=
 =?us-ascii?Q?FL5EQ4wjdlg3fAAc8xHxyT/m6NeHl54nU6jSBAOk9KFGFG9Zk7Mh9Ygx/JpP?=
 =?us-ascii?Q?ouic9aEyYfLpLtaBYkH6nfNXtUuTBNRAJ7/yHv2jwP0yaEQ5W/OC3JLGu1P9?=
 =?us-ascii?Q?BzrHuB/8P6iqVIBAf1g5gUNlVMUWIDhLCgQdxDQC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b607fa-0ba0-4664-d335-08dccb85b52c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 19:30:31.2761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/Wj1G5Wp/qIIVJItammP2mx+kPYS7hKAfdfYvCYyJpSnT632P5MsdysHGtHfW9zWPqW8CQTKtdKoDdj4EN2ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10444

Rename admin_led_lower to admin-led-lower-hog.
Rename gpio rs485_en as rs485-en-hog.
Rename gpio uart4_rs485_en to uart4-rs485-en-hog.

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: gpio@76:
  'admin_led_lower' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtb:
  gpio@30230000: 'rs485_en' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtb:
  gpio@30220000: 'uart4_rs485_en' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v2 to v3
-rebase to guoshawn/imx/dt64
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts           | 2 +-
 .../dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso     | 2 +-
 .../dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso     | 2 +-
 .../boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso | 2 +-
 .../boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso     | 4 ++--
 .../boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso     | 4 ++--
 .../boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso | 2 +-
 .../boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso     | 4 ++--
 .../boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso     | 4 ++--
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
index bea9e8bcafc47..bc0d89427fbe5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
@@ -220,7 +220,7 @@ sfpgpio: gpio@76 {
 		#gpio-cells = <2>;
 		gpio-controller;
 
-		admin_led_lower {
+		admin-led-lower-hog {
 			gpio-hog;
 			gpios = <13 GPIO_ACTIVE_HIGH>;
 			output-low;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso
index 9dd0703423635..4de22d2044d69 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso
@@ -18,7 +18,7 @@ &gpio3 {
 	pinctrl-names = "default";
 	pinctrcl-0 = <&pinctrl_gpio3_hog>;
 
-	uart4_rs485_en {
+	uart4-rs485-en-hog {
 		gpio-hog;
 		gpios = <20 GPIO_ACTIVE_HIGH>;
 		output-low;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso
index 045cd8082781c..e259d8d5d9e39 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso
@@ -19,7 +19,7 @@ &gpio3 {
 	pinctrl-names = "default";
 	pinctrcl-0 = <&pinctrl_gpio3_hog>;
 
-	uart4_rs485_en {
+	uart4-rs485-en-hog {
 		gpio-hog;
 		gpios = <20 GPIO_ACTIVE_HIGH>;
 		output-high;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
index 47d3c0c49e8a0..bb2056746f8c9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
@@ -16,7 +16,7 @@
 /plugin/;
 
 &gpio4 {
-	rs485_en {
+	rs485-en-hog {
 		gpio-hog;
 		gpios = <0 GPIO_ACTIVE_HIGH>;
 		output-low;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
index 7fcd8c851159a..45ac8bdce8699 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
@@ -19,14 +19,14 @@
 /plugin/;
 
 &gpio4 {
-	rs485_en {
+	rs485-en-hog {
 		gpio-hog;
 		gpios = <0 GPIO_ACTIVE_HIGH>;
 		output-high;
 		line-name = "rs485_en";
 	};
 
-	rs485_hd {
+	rs485-hd-hog {
 		gpio-hog;
 		gpios = <2 GPIO_ACTIVE_HIGH>;
 		output-low;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
index b19e38fc27bae..30aa620d7004d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
@@ -19,14 +19,14 @@
 /plugin/;
 
 &gpio4 {
-	rs485_en {
+	rs485-en-hog {
 		gpio-hog;
 		gpios = <0 GPIO_ACTIVE_HIGH>;
 		output-high;
 		line-name = "rs485_en";
 	};
 
-	rs485_hd {
+	rs485-hd-hog {
 		gpio-hog;
 		gpios = <2 GPIO_ACTIVE_HIGH>;
 		output-high;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
index 1f8ea20dfafcb..9bee7159a67b5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
@@ -20,7 +20,7 @@
 };
 
 &gpio4 {
-	rs485_en {
+	rs485-en-hog {
 		gpio-hog;
 		gpios = <0 GPIO_ACTIVE_HIGH>;
 		output-low;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
index 3e6404340d529..e98f50bcec57f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
@@ -23,14 +23,14 @@
 };
 
 &gpio4 {
-	rs485_en {
+	rs485-en-hog {
 		gpio-hog;
 		gpios = <0 GPIO_ACTIVE_HIGH>;
 		output-high;
 		line-name = "rs485_en";
 	};
 
-	rs485_hd {
+	rs485-hd-hog {
 		gpio-hog;
 		gpios = <2 GPIO_ACTIVE_HIGH>;
 		output-low;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
index 2c71ab9854cb3..e875ff4637bd5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
@@ -23,14 +23,14 @@
 };
 
 &gpio4 {
-	rs485_en {
+	rs485-en-hog {
 		gpio-hog;
 		gpios = <0 GPIO_ACTIVE_HIGH>;
 		output-high;
 		line-name = "rs485_en";
 	};
 
-	rs485_hd {
+	rs485-hd-hog {
 		gpio-hog;
 		gpios = <2 GPIO_ACTIVE_HIGH>;
 		output-high;
-- 
2.34.1


