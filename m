Return-Path: <linux-kernel+bounces-371396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7039A3A85
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1527FB24FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC00200CAD;
	Fri, 18 Oct 2024 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jbZYfts+"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FC8201009;
	Fri, 18 Oct 2024 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245174; cv=fail; b=eXBPgW5gruigQc/A7dpHBk97NmWwBvLeViIntQvPPQ6SagDO4irnYdF+xeGs1ZaiBWhvdpV2JLV6anDXcOydl7xaHYT/+9VARJmfSwEXd2MC6oWUaZiITxxL+ryqk2qtkbcvzAYZpGmciUzZZLnBwL5b4OTTfBUll5lshGDueVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245174; c=relaxed/simple;
	bh=v8ksMBxvbeVAy80xC/9SxZUA+6+FZGxZgqOBK4nC2MI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gc2Ep89sVR9Tium1Sv/a37AEZoweT/ZK1uNvHWm+qBtRIm0AUrqRPgkUnART0i2hQiw7erludZ71bjzompPrdomEGyO32jlU3GG+5HPUM3+nWZFqXEGK7bqYqdvUcbLft3CgZq2I0Yf55jGAH4ZT4m6RRuqdCJebXuet0qhClJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jbZYfts+; arc=fail smtp.client-ip=40.107.247.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/0LLIBBNeGZ6ZjSZgjtCXpatGAzlWQWssBxR27Zy7ZnsMSJLBF/Hr2I/bkOC0ta6ZB/7xtptXydSZOZNs6P8WKJ3ujoJlqEZZxww51AaPx+Z2ifzRWI/bPjQB78X1K2dJNHA1ncYNv7bpds4m5Q/Coxy/88M/otA7eDUfDQtAYzt08vuAFw7qTWiGAx/uHp44RouYRnqWWWTf+S4yihWFtDqR8DK5o4vXOYoD6WPCA9Zu3J1BuXMnkEeuKKMe0jnt/4LCgrF+Atc1zVwmWBSO5CCSH7cJNEI44lTwPk7Bsu7GcaKHs/Wvc5+NFvzyN8Dq42DsJiLdtU4k4HrHZa/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tll9CQpoI2JYPFCpRJcMtd6vZ7urFG2dHGkXxAOPskU=;
 b=ghCvP5JJaAb7nG4Eg0OEkwxwFdDlZh5ZvmuIAUSHtZFbqICDF59EFDcvOUPnxjmj2gDzjamBP+D4iOZT18AtotegP5NIQ0UV0Mk4cA044NbuzcdAr0/bRr2tzDvJ6sER3qCRDKVGa09HCaj8GhQQj5yI8JMIq/AP05z8wiNP5Q7C74hZ0Xku6UGDrHUP+Vstn8ceen+KWceEmmRugLppFAam/g0l/2a+dfdE2AExFyrn0ckpkw5FQ/4N8xpkllpGzuy8UvcdI/oQLJbH7Dy9waxwu9yNvKQH/rAUNi4t5X1ZvhjFiGDSDOilpPEPlJuvwb+xcsvNQU+SGKX2ZxUlag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tll9CQpoI2JYPFCpRJcMtd6vZ7urFG2dHGkXxAOPskU=;
 b=jbZYfts+LEQj2uhI+cLMeaaSot0zK0/WIvdfsZB8SQRZjtzJfo+qZJuEdml2krbp+WxSrESP9GZReuxPFeHEXqQNcuoE0nrFxG2uWqXLG2uP18l4WAVEGX5Tm/S9OzyoFVV+DtE27gAo71MW+0YihTaeDGlOZywMmCPdx9Km5eommc5SOoqSHxZ/Foq04Dsd+xojGYVulm2IYS9ZNa158qHCNqm/+BveXSEh09t1r7kWmjGsJW+R9MX49c4IOsjcRR2UockvxF1iQYsPwQ3lmNQ/ti2nZDJHiyr/uZj1VPdd/fMBvMBp6AYGDmkJ0yNIcuXgM/KU09Xcu1/lUQa1GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 09:52:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 09:52:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 18 Oct 2024 18:00:57 +0800
Subject: [PATCH v2 3/4] clk: imx: fracn-gppll: correct PLL initialization
 flow
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241018-imx-clk-v1-v2-3-92c0b66ca970@nxp.com>
References: <20241018-imx-clk-v1-v2-0-92c0b66ca970@nxp.com>
In-Reply-To: <20241018-imx-clk-v1-v2-0-92c0b66ca970@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729245675; l=1523;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Sv4CHyV16UexiFdZ+yIX03Ey/S7U3vzUPoU0hMATx6E=;
 b=DSOgn3MmfKf9qUurppWcHeibwzQ634wERjidpXq8wcEo6dML0JSZjn0YQQTXq6G9GACruCnpH
 FvZvsurJmT9CixVl+oBbQjkYWhWSNlD3FgaWeHqxwNGe4nt7VhB/xqI
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBAPR04MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c9acf6-5414-42bd-b798-08dcef5a9aff
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZG5oR08rMG1SUEF1QWhRdGdzbC9kd1dIOTQvVmlLOVdlLy8wZFdYazNjTkNT?=
 =?utf-8?B?TkxTQThBZ0RLTUN3UHEwbk41NEJIZklqNy9BWWp6QkhOM0phQ2xiaDNpL3Zq?=
 =?utf-8?B?R2lBTzE1T2U2dDFjYkM2cmhNZ0tRbFd6M2kya0tGOHVUZzYvcEdYL3UwdUEv?=
 =?utf-8?B?ZGY3dGRwOW5lbm1EQ3Y5RWcrQ3ZxRnJ6UzVRVVNpTU81b0tLSkUvSGxqYW4r?=
 =?utf-8?B?eXQ3SzBmQm41d0FMNEFsWTZMM0t0QldIelltVmhoTkxiV3VnUGtFV045YkdW?=
 =?utf-8?B?b0dpcFBOclNPTG5NQ2FsbGdsaUNKM3Y1QWZDMWw4U3ExQzcxb0Q4R2M1UUFx?=
 =?utf-8?B?bUdoSGdBSE9RSCsyNExXdlZRck14UENpYU13bXVqY3RNVlNueS9adElWbjR1?=
 =?utf-8?B?ay91MzY1MnNnN0hTanBNWm9VSURYZ3orK2pDOUozU3JvcXR4dmZMNndqQ2t1?=
 =?utf-8?B?NUN1dktRMzQ3Yy84aHRsNGZxSnFLZXdOU2xiSEUwaEt4eE1MZWZ5QVA0bEFB?=
 =?utf-8?B?TW1TN2F0MWlhMzZpcThyaFdnS2U4NVVCSlFmTUZwbjAvU3dWWlptN0NHellj?=
 =?utf-8?B?UGhBa3FESDc0ai9XQThtaVFuZ2JOeWRmU3UxcDVaRk5OMVRzQnY4U0E5UmlK?=
 =?utf-8?B?QmdacjV1WG1uSjB3L1I1WVRuMHJKL2lqUXpBei9DQVdHdFRNNjgraGJudkZK?=
 =?utf-8?B?OEl1UzFOcGFmekpIeXJib0NHdU5kNWhGMHJ3elVDZHlSMXp0bWRRcTluNjc5?=
 =?utf-8?B?VktiMkRqZ0NHeFhxV2NFYmNrV2ptc1hLT0pnTlhpMFEyc0ZrRENTdGM0OXI4?=
 =?utf-8?B?Y0cxSnV5U1pYZ0JZTnJ1L3M0UWtzc2U3a2xJc2NUMzl6dFlKaUNaTnA2RWVi?=
 =?utf-8?B?K2cwQVVwNWpMZ0pPRjJqeExvM2JwaHZxNEd0alNkckxiRFE0Q1IzS1JZQVl1?=
 =?utf-8?B?UWpmY1p5aWV4RU5TNlZzSFpvbnB1YnRYWktiMmtIWGt1cmdza25WdjNsS2Qz?=
 =?utf-8?B?MlVXRmxSdEZmUjVOeVFyaENJYjlUZ2FuUXpIbitYOG8zMTI4VWZSWWhub0NL?=
 =?utf-8?B?Ri9RaTBaYzZkcmV6VUxDNHhTemZFdS9aR3NVV1dTSk5oRGlHTzRYekQ3MmFi?=
 =?utf-8?B?M1M4MXhpNkwzcDhkWG1IQXNGaFFFNDZ3ZVFKeGsrSFg1cWwxRFNUZk9TRCtT?=
 =?utf-8?B?ajhUV01EUW93dkVQT2JTbzhvZnlFK1RDem9OV0JkVCtqTFNjTGtINTU0YW9C?=
 =?utf-8?B?L3pJS2ZoQ291WVl6WlJRRmJrTExnZG1wN2Q3bXF6NWdzRUVobkkvYmtvM0hr?=
 =?utf-8?B?bURsakFBeDB4RXNsQVdMUjRDcDFqK2dzS2h3NFFVOC8vWVJKVmRGYTNMdlNr?=
 =?utf-8?B?NzVMVkhtVkI3Y2pzem5zMTlpcjM0aXZ2SjFEWWFOeXlNTE11M3Uxc2tMbHlG?=
 =?utf-8?B?M0JoTVFVQnp2bHJVZy9lUWR0RUhSRVpIVmJCQW4zTDltcFhtZCtTVE9heGk5?=
 =?utf-8?B?cnRPZUZGZ2ZRSllrRnRvczJMYVFuVUVicURXcXpFZ3pHeVhuVkFNVmg3V2JK?=
 =?utf-8?B?blZ2RkordHlhalNKM3BkVXU3ZVo3Y1RZNGtULzRCVlN0WHZNRjZiU1VkTEpu?=
 =?utf-8?B?M2VUREhRSkwrQmZVTTB3cVVYQ3lCeXU2MkxWSHZZblU1dEtZLzhHVnRUcXEy?=
 =?utf-8?B?SEM5eFZ5R1pIZUhBVUNHcmx2bnZqU3RoVHE2U1Rvd1ppL0FyMWdwNWQveEF2?=
 =?utf-8?B?M1JrbHZuU0w2Ukd4SUkwejVuT1gzd3RXbXNHTHM0Q2VEbWkvSjVxcHZnSnNM?=
 =?utf-8?Q?6bahvL5r07wHzMB5l7rLc75hUrykp8jo6+LMc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STN3Ym5UTTc2RS9UYURyRVVYYWlMemtqcHc4c0xFZVZZR2FxbHNjbmYveU9x?=
 =?utf-8?B?akhVcmJnQ3BHbnlnSzA1ZC9pSG9LZEN3MDMwY3prVTk4ay95bXF0d3lVU3hN?=
 =?utf-8?B?cCt2d3plc2Faa3V5VjRaOHhYSG56N0J3Ni85VHhlMWZUS0JNcWdlZWdTRXIv?=
 =?utf-8?B?WEFZNXNDL0xIRnNzRUlUK1JtS3pJZEJmVDYrR2IxTFBrd3AvVm9vUFl6N20y?=
 =?utf-8?B?QlUwS0pKR0hycGFCcStuQ3FacWdqN29ENDR3bTJTNE9MRXlyWWdNc29lcFly?=
 =?utf-8?B?S0hpVm5BTXJ5VHF2cHB2ODR5aXJ0TXVyRnVKQjlLWVBGWXFLbEdFVDY1VjFx?=
 =?utf-8?B?WGpHQUhEZFhXT1JxM3kwZ1NHemZOY2pRQkh5dy9URjBYOXNzcmM0aHg1T1hD?=
 =?utf-8?B?c1d5Z1hETUJEWVlLYzFEd1hIbS84TFYxZ1d1M1NZaXAzUEdGTnNTRmR2UlBX?=
 =?utf-8?B?MjQ0T2VpOGpyRWY2NUYyTnpXNitBNEQyZHBDbDhnZ0JkWnFZZ051WExRQWlZ?=
 =?utf-8?B?RXdmNFp3YldJUjVZYUlpanl2empNM0NuVThGSmREQkZyWmJWMjJBamExU0t3?=
 =?utf-8?B?d0pkWnE0R3BTNmlIRi9LRThZL3NUZGxYNVhpZXVOYWNXcisyMmdaMlRZWnQv?=
 =?utf-8?B?WU84ZHRKZkN2cWdzVEx2OWF1T3ZBUVlFbitQUnc0M3k0Z3U5NUtWUVhIQ1Nr?=
 =?utf-8?B?ZUp6TXlqYXREMnFKY1NjSEpMa25SaXY3c3VVU1pHdVE4eWRIY2FaRGI4Nk5S?=
 =?utf-8?B?c1ZkSkQvQlFyQW5rTjJYRDZiVW1KZllsWXQwWFd4aXVEZnpwV1JlZUVWWFRa?=
 =?utf-8?B?UTByRVI1ODlsRWtVY1Z4MngwQW9QUjA2N3daTTcwMGxWTHNwOUxwMVo0dklL?=
 =?utf-8?B?RXVaWjdvclRsWENVVW1DUC95ZGRQL3Jnazcrd3RpbTBkcG1rQlNPanJZYkd4?=
 =?utf-8?B?eUlFVWtPd2ZyVnR5R1FaQmltd0VwRFI3aHlsS0JzaXZPL3p1My9RbnVtRDV6?=
 =?utf-8?B?Z0wzOTV2MVF1WVRtZk1QMWtvNmJRUE9Ta2orUmU4bjBOd2k0Ym9vR05jbkMv?=
 =?utf-8?B?eTFWdSttZGd0L3Q4ZzRiNlVMbUora2FkcmRNbkRGMVVvaHFOdkVPYlBDQjRM?=
 =?utf-8?B?RFR3REs1UnJUUjZVT2FTamdkdCtpY3hFQzBjbDY2bXJuV2hQNHl1eDhjczhW?=
 =?utf-8?B?SEpqc1JVVHdjNjVQN1drTWd2aHZGejh5Qm5BRmFFUlNZV3Q1bWdOY21USjZ5?=
 =?utf-8?B?bkZjWlJyUTcwNGx4MFczY2JZeUV0ZWt2elA1TW9jdEh5UFhqaE5UcDh6S2tD?=
 =?utf-8?B?YTBlOXNxdHBQQS9tazdMTmd4ekpXa2hXMW4rS3d4djFBL0VkdEVMeHdvVTZa?=
 =?utf-8?B?by9vSGJjZm9DSTQvcW1HZ1FldjlNSHNnSjdsSkJpK3RnOVQrTTFEcE1mTHJh?=
 =?utf-8?B?VGM2b1VkYUxSaXRWK1NyZVZoN2owNGtPbFBkdmkrRXl5R2pjc0NudnYrWFRQ?=
 =?utf-8?B?WmF3WWgreUZQR2RsUm13QkRSNlZjemswY25PSFl4Tm5rWHNhazBubjArSXox?=
 =?utf-8?B?WExYY200TUViMTZYRm9sbXZZMzl1VEJDcGpnb3ZISzNMTnhoZ01tU04yaWR3?=
 =?utf-8?B?dlVVY0FzTGhYVTgxWWVNay9jVGNqWVhDOHI3a2RCa1pERTRxcXdtNEVNWkU3?=
 =?utf-8?B?bTNkZzViSllXcWlQUUdGT2tpaTJkUkJOaFVDU1ZnR2U4cXNKbXk1cm51Q2dF?=
 =?utf-8?B?RisrQVI1amtzQnB0OWladm1FVnozdXNIOGIxdkFjcFlNNHVBeTN0aWtUVkZn?=
 =?utf-8?B?c3FDa2pObzNTMlhBU0pSTnR1d0ZLT2xVZjdpa1BlNWdGVlYrRWV4a2RuMTJP?=
 =?utf-8?B?cU5jNXVkYWRUOXZsbFIrQ3BRbWJEQjh1NHpleEtiZEVXZHk0UVkyMXBVdklv?=
 =?utf-8?B?MmxwRnAxK1ZmdHA3RDNTNXZsMWRlRXcxaVhKQ2phMHNaR0N6NUZpKytNUlhh?=
 =?utf-8?B?MjZWWTZiWDBnVXJmeFNTdGdrajNrRnAwd2lyWWI4YnczS2VvUDE4U0xQNUVT?=
 =?utf-8?B?M2pkTk9RRXUwZE80dU5UMWJZeEM3ei80ZWxvQzMxek90dWhhMjAzUVJ0SHZw?=
 =?utf-8?Q?qYZMo+bF4GGYnYhMAVPKWDitW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c9acf6-5414-42bd-b798-08dcef5a9aff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 09:52:40.7530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jV0Dfm9exJm7db9bb3L6Q+HDouyhCmMEL3V8r6I9aX3k5CotXdMT6/1Pu3wcR91rgre1+sq8iV2DMqDE06TqfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285

From: Peng Fan <peng.fan@nxp.com>

Per i.MX93 Reference Mannual 22.4 Initialization information
1. Program appropriate value of DIV[ODIV], DIV[RDIV] and DIV[MFI]
   as per Integer mode.
2. Wait for 5 μs.
3. Program the following field in CTRL register.
   Set CTRL[POWERUP] to 1'b1 to enable PLL block.
4. Poll PLL_STATUS[PLL_LOCK] register, and wait till PLL_STATUS[PLL_LOCK]
   is 1'b1 and pll_lock output signal is 1'b1.
5. Set CTRL[CLKMUX_EN] to 1'b1 to enable PLL output clock.

So move the CLKMUX_EN operation after PLL locked.

Fixes: 1b26cb8a77a4 ("clk: imx: support fracn gppll")
Co-developed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 591e0364ee5c113859a7b6271c8c11e98a0e0ffc..4749c3e0b7051cf53876664808aa28742f6861f7 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -303,13 +303,13 @@ static int clk_fracn_gppll_prepare(struct clk_hw *hw)
 	val |= POWERUP_MASK;
 	writel_relaxed(val, pll->base + PLL_CTRL);
 
-	val |= CLKMUX_EN;
-	writel_relaxed(val, pll->base + PLL_CTRL);
-
 	ret = clk_fracn_gppll_wait_lock(pll);
 	if (ret)
 		return ret;
 
+	val |= CLKMUX_EN;
+	writel_relaxed(val, pll->base + PLL_CTRL);
+
 	val &= ~CLKMUX_BYPASS;
 	writel_relaxed(val, pll->base + PLL_CTRL);
 

-- 
2.37.1


