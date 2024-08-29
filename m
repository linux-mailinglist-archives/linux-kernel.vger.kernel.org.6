Return-Path: <linux-kernel+bounces-305995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCBE9637C6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20881C22849
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99091BF2B;
	Thu, 29 Aug 2024 01:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B/qc3G9N"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012001.outbound.protection.outlook.com [52.101.66.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B7E2C18C;
	Thu, 29 Aug 2024 01:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724895210; cv=fail; b=W/TWSgWb6iiivYn7IMBeovLhM8X8rlSQteIJjYbUytqdymTkSYJbq1SencOcGIO5/7Ws4bL1U26dEBNJUBWngIB0fvEcOnZaijbX6oy2zJOCwAAXjgYJ2NwR+aeul7yrFn22PZBcJDc+6oLEDxzVEs9J1OGJVAROYtO81fN+LKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724895210; c=relaxed/simple;
	bh=7au1s8Cf94cA4hqRUNDmB4EYspyUVxccKc78kEMJv2g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Hcq9BSbH9kFwzAUE43V8TJS6qrIooLfkTuqGw7ZmMev/r5o0vM4bCEGVMpyoCBSOtVal6FePT6/p+Nz4nYMNnpeqGM7UdKiXF0M6Hz/cHRwst8dtOAjL+EBhS8eruvRfNFcxdlmL2+5l5tAZv5W5zMGDYoK/EeYEbuqzmfXLN28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B/qc3G9N; arc=fail smtp.client-ip=52.101.66.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Loi1uEO23u8T+szJGtsOUfkYFNClO3BtH5PKBhPQrDi7iQYr0j2HL7Pvj3ANc5pM3oDMlPX3oDhpt2//PGdMFiyFkHy0e/evcZbvrcLKxOvCJLOh1TevwfNAKwyOyGHIoDmvTkYh9s54Kp0xcPDXIRb1Q0+SCNOIMh6C+fMsMLnSLD26JeGL8eKcJq/d+0zkNBqnb+YF0Ni6J+1wHqT77Gi4rT+f1DNcEilCRur4PkNODQPewqZdO0zGxAPLjQ9cgEN17CONaDpqvXz69FOzdWQRja09fXmwbX1em2Cxsht7VFXoAEJMOrHRXyg+Q2A00kCkg3yK0LtWJrVznCYlRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYSWi0Gs2vbw9esSVCl6BwkmwVy2PQTwb8B4vPmy3q0=;
 b=WRu66HtfrZGLNv+gkj5oIZAxBzzWOkM4VInNWVMUhamJ1R/SyKK8EoU4V6cAyrfECtv/MSE/CTBG8en54CPVUbK8wdb0rjsoIOLlVtmEerTQ+XT3R7GdPwDsX9RGwU5VUIkeeCOoCmRz0HWhdALJ+m/FAwrJM8wbSZIgP7yw1I02cXed8ej5ZCNYkeoxkOXokhWuCZIncCYt5lsUBK5sB99AFnHujhU4ff68RCfh0XCVv3SyBuGwGZl0hSwFoDVY3srvUqFiDEJJrneM6z0Vw7UMbBVYJLlTxEn/ccDEECXeWFMqeR20yLZCH9iB7To8rnVBZFLvtqsAgU2Nz4k7jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYSWi0Gs2vbw9esSVCl6BwkmwVy2PQTwb8B4vPmy3q0=;
 b=B/qc3G9NgELT3CoC8PMxX2GMsczAAL4hEHCobyHUdy3wULyLYpIp3pAYx6NVcBKQwYv08cLkAUcjLbM12w2iWiYhgVk+WMbQ+l5Ro6biXicHW6uDYwvtCrG0zQazfa/uuS9HXuL4LT5T9ky0NiT8EvbunmwRuNAoROyLfHfkJvhA4wDWUWHejyiZUiouIbnO/J9JddaoRrSqs+GJQQPWHn47HJR3/BHAMWr8xYue5NHpMG3YgnS8z9dygTdVDs2HDdS2mga7hEZ0cyKbXcrG+Q5vqdwtfTjZibz+0PpNEGsCP0xTfhHqB6wKOX+NPKLDqL/sokJURaWCUkv8X/eSQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10924.eurprd04.prod.outlook.com (2603:10a6:150:224::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 01:33:23 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 01:33:23 +0000
From: Wei Fang <wei.fang@nxp.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	abelvesa@kernel.org,
	peng.fan@nxp.com
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [Patch v3 0/4] add NETCMIX block control support on i.MX95
Date: Thu, 29 Aug 2024 09:18:45 +0800
Message-Id: <20240829011849.364987-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GVXPR04MB10924:EE_
X-MS-Office365-Filtering-Correlation-Id: 053716ef-4445-441c-f991-08dcc7ca9255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SqU3mAEJ+4BQc7SzjubHe0eA0SOiYkH+h/LEkTgVDoBsVnflYXeNicKij9Wf?=
 =?us-ascii?Q?E1Y3zmcdVov8/Rp2XsKbIiEu115jxCUKj3AxTlotzGSIIFUfGg8/RT3uot8j?=
 =?us-ascii?Q?GVYPZfHFafyJ+5TsdkkV/4fRqyzSh36/LRgapptVyNbTkP6l8zqmu8RrdALr?=
 =?us-ascii?Q?Bux/EHPPzIrg20eaO6K6V3c49Mc9hJQkAlUdgNUTUPr2ZIImxsAXiuCPZsvY?=
 =?us-ascii?Q?C0FWx/7FLZ2KJDunr8OWY9aGordzypGNCVE33+hRYR+dm0FAAHJPuSX6Z5GK?=
 =?us-ascii?Q?hlOk61fVmMNcoNmNKMQorBNmBPkpxS+baMTClxXo8ZTFzv/FfrkFFOmGBX4k?=
 =?us-ascii?Q?15LbxUNhA7EOQ0R66rQTRVllRFvs7Qe7R62s8k3MD7J/KXSHx3Y+PGQalVD3?=
 =?us-ascii?Q?9ByPS1XLwVAqQZSa/4tIifFj83pjxDv/ePs4J0Cln6nmLJcsC9gvNEQ610qL?=
 =?us-ascii?Q?MDv3Ul9UA9id7BnjJqheUcqDK6yrbNKhI+9PpPiH9YdOmiEaiDsAdeNCjoE6?=
 =?us-ascii?Q?C0vNyrP/xaUuRKPz2Tx1JW9cNeVasmvk++SU5odoV+MXLZtpg2VpyJMQsKfY?=
 =?us-ascii?Q?MAR7bKkT+Qj/PIq3zNBKfGIW5YmUR4rdsXKXVf5fTGPW8rdmZHL44YsbG3wm?=
 =?us-ascii?Q?Qmt8YyZrxwLWcQUHRXkK/tpq+/myKb8w85YuX/lWZ0txgpf9DzD6wsjImHpi?=
 =?us-ascii?Q?NtcmZO1fVmiL0uilyb8VkrjtUFyPMCOgQIZ+pHpC/LH5KiBhHai8GkhWnKIJ?=
 =?us-ascii?Q?nF3ssjLWsK5eqVcIXYjTEMi0Nh9UX8K6lgLJTXfQH1zLTxenkPZA95WERpy6?=
 =?us-ascii?Q?1BUS66L+f0rkiEVR8hjtghK547/4b+cGjul6Nve+iKVIayPIvAYnR9WCU8Iq?=
 =?us-ascii?Q?S6GfzSJb6VDKe30VKmjfqyBvh6yAU1RHw5DniibYfrobBOoseV2Cc3Asjluv?=
 =?us-ascii?Q?N9N1pcVBiUNRBXfeGkfIuuEMptjIxz6oPr3Hoeunf1h6e6GRPXp5CmCozz+I?=
 =?us-ascii?Q?uEyJLALqOnipSqq8q44NkCqHKzjarEj1W1rQl7V1gQwR8//NbNLsAJvHtcdJ?=
 =?us-ascii?Q?JSJ8QtiTXf4FEGW7i5G687HuTJ40Sg4hl3/Mk7Goq2t0G6FkdssJrXqVvur+?=
 =?us-ascii?Q?z0TqfFhMPgY9ZeKKMNKz8GajW4v7pd+dJynXhztjfIE6gr4fI8dqIc0j+3pf?=
 =?us-ascii?Q?LperG3TnqWh/yPjtkFTrDveDvKGfju+dF1b64R7RvsBWY5ZrnctsIMPlcX3f?=
 =?us-ascii?Q?+oSnCtI+oY3VbIpMqk3xcRzJUdG+iYalAzMxt1q7EA64leC+6KTktsbwS3Z8?=
 =?us-ascii?Q?QIhICA9UIYKycd/vHbNgbwqaHbO1sKR9DLg7ov/WqAC+CPnqemcZeJ/Gshsn?=
 =?us-ascii?Q?JX5yPyvUFIKPQ27/8hXC/GYapeJMgIGdq8nwZkXqh0XB/Av0Bg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oeY8qnoX6p1vurqgdxe9/rspDZFVtN9/Yzx0N26FiEyrqDceTE4NRPhXpckj?=
 =?us-ascii?Q?ienUN8AaC5zmd6paUn19IWUER+NM8pByad3iphCy3AIKhqG7cAFfocKLxLiW?=
 =?us-ascii?Q?vnWFEUj8BmYaoOgdiX3vmY30D/JgrBBZn5N86S8+MjWT0mxrP9dBaJmQh5Wk?=
 =?us-ascii?Q?OotnjgpShuV4BS/U+NQqF/IFLj3XYYZgHfQU9eG7c1ZFEQlWVwzmHFFPd+ou?=
 =?us-ascii?Q?ASLlnVx+0HNDYBWUdj9Y89CTL40PZlF34YEsvA6nbjBW5jK7hs7hXSdcge7j?=
 =?us-ascii?Q?oP4Vx8sEp2G5j9WyfKhhsKTL4ZOAAi7d0ghArr/P2TIfsCfL2wQ/dUpE831q?=
 =?us-ascii?Q?0raSOO/Fa1XgieAou7B+xbhQqsii9XiXA29CiKbioAefQ2ktMz8jTLaHCfxG?=
 =?us-ascii?Q?QPXGyB33i4nFYTYDsnu1/I6xAOcrWp4DBKS1bE0Js30nyhYxDEYv8t30bcIW?=
 =?us-ascii?Q?hxJM9K3Pxs55cg+F4jWXnmfDTJjI5xGM79j9829EWVEDgYVG/fTZpuDudUhc?=
 =?us-ascii?Q?wFC3aGZ/p1mbcJ+FM5lCfdRVdJHWca1cuN+UgCnDsbbpVR+1f5lm4BRS9yZ6?=
 =?us-ascii?Q?Ti8kF7BUd/MWSSyVKA6XBbrJX1ws+kbiX5rAQtkk1Q9QRImrg9L1lxttIRO5?=
 =?us-ascii?Q?UbNdkkKTDBhiHjsZ5ar5KnEK4ikd/rSuTB4A3iB1hPCd5iwXTghuGwXJlIYh?=
 =?us-ascii?Q?Z5kHfh75tWdkehSbPk2u4KmmGu5jQ2SNXcRGp6tkbrNL+ijM2t5wqzcc821O?=
 =?us-ascii?Q?H/mlEKEv3GIBgeMq8CJS1xMuucrHPdyxhuxUQJRVaNI/ZfcbQ8k+4sYMoDhC?=
 =?us-ascii?Q?0vvIMrCxwC+cQF1FGFtuM4AjP0zgNeAGfWvo4J1uGc/s7SSuPnW3XMKGClH/?=
 =?us-ascii?Q?/K3bNB7wMqJgs0bslJzXpPntDC9xJ3sjRYM1RLYG3hCaWVcwdD56Bg5XdK+p?=
 =?us-ascii?Q?B97SFoAqABD7/L/QS3ohSqKPL8S1UVzXYpL9ctfHTXyyZSFWEcwiu0RD0mh8?=
 =?us-ascii?Q?zds166yXVFwehObD78CVLbGp/orwaPhbo5zJLtWHp5dvsJzGwhdd+B9+FzO0?=
 =?us-ascii?Q?qLKLQOsKe4tig9FAboDR+lVscpYYCsytdeFE4wqwnDccoboiaP81VxEy34b/?=
 =?us-ascii?Q?4q4pf7o5Echl4Drk6COBvov9qqGf9g9R21y9/A1HCLhoZtDL7WAcwofba+3Q?=
 =?us-ascii?Q?4tlLG4dfjLTtwP+pK2WsqMsWd7nRjtexLVO2IZYF+UJmbJ0X63BIjrEMDZ+V?=
 =?us-ascii?Q?TKEnyX698YRIdInFTJTi28+TJ1Vzm44ZS7HPhMLzNn55SJe23g3mPlQU5+uS?=
 =?us-ascii?Q?BioORTZ4ndRiW7IhdoN5o4IiWQeDR5XvcGNyqeA+zAtB5GnV8Cs08zXUzzvy?=
 =?us-ascii?Q?jvA5zB03cYi7bib/LF2jLu7AXn5ZH1CJm87Rpj2bNr225FZAWj/0Bsll2aCK?=
 =?us-ascii?Q?/sa3sTnmZkn0wn4tEIQDXQAD3KPh8LjzT4PF+rgG/nH2VNkWX9HYKIRVAltN?=
 =?us-ascii?Q?+Yqkclrdb6futMh20Xig1YT/ppn7y+CbsDuJDmgC+6TSWY2bPxM6QZeI2cAQ?=
 =?us-ascii?Q?+RQGDIJynFELPmSUoxvtW41puR4dq+PKKL/nBL4V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 053716ef-4445-441c-f991-08dcc7ca9255
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 01:33:23.5842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yibb/LXCFD7b3yq/TYSzfu/WRdzZPmNs2qoXxlON8Vu1wzy55dDaGzfl8nhrblneYVsZnn79HlvXF5h3qZW/xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10924

The NETCMIX block control consists of registers for configuration of
peripherals in the NETC domain, such as MQS, SAI and NETC. So add the
NETCMIX block control support on i.MX95 platform.

---
V2:
1. Patch 2 is new patch.
2. Add rmii reference clock mux for ENETC0 and ENETC1 in patch 3.
Link to V1: https://lore.kernel.org/all/20240709073603.1967609-3-wei.fang@nxp.com/
V3:
Respin the patch set due to merge conflicts.
Link to V2: https://lore.kernel.org/all/20240729012756.3686758-1-wei.fang@nxp.com/
---

Wei Fang (4):
  dt-bindings: clock: add i.MX95 NETCMIX block control
  dt-bindings: clock: add RMII clock selection
  clk: imx95: enable the clock of NETCMIX block control
  arm64: dts: imx95: Add NETCMIX block control support

 .../bindings/clock/nxp,imx95-blk-ctl.yaml     |  1 +
 arch/arm64/boot/dts/freescale/imx95.dtsi      | 12 ++++++++
 drivers/clk/imx/clk-imx95-blk-ctl.c           | 30 +++++++++++++++++++
 include/dt-bindings/clock/nxp,imx95-clock.h   |  3 ++
 4 files changed, 46 insertions(+)

-- 
2.34.1


