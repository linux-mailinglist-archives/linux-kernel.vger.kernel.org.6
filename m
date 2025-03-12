Return-Path: <linux-kernel+bounces-557934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726CCA5DF81
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E707E3B6DED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D5524BBEF;
	Wed, 12 Mar 2025 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FWGyBk7+"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012013.outbound.protection.outlook.com [52.101.71.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B7B23BF93;
	Wed, 12 Mar 2025 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791278; cv=fail; b=qIemTsGy9I7g2ZxyqOIZMZ3UVJLOnxM7cNJLFSbb/w+191MskzTQZD7KAVdSEMnRh1oerxKO7N0Pkx9Q4dRJe+KU7OKzawDMVTehDMhJ0DkGvgAhQqPzv7sz7SO6mO4OHN6VeyDP/EgEGCFg1D8nSEq6DepB5sK6JGzXU9jj65g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791278; c=relaxed/simple;
	bh=Z9qjywQqL23qrtReOktG4MIFutwYsL87HB2+3k040kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=upIwuXQlkowNSX+sFc3WeqXfwCLK/QFaNsIo5n0/ua8PXg6/0Wr53j+9vbWUiToR/zyBRwbGiy6C4Z+PJhSrhUtoWjsaA13YXiETP2MIxl2Xlqp4CiQp8JMep3Mi2hal1idZCSxJQ6IMYxp/MHwf71Ux0Kfq6SKr5NxGqKYEfVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FWGyBk7+; arc=fail smtp.client-ip=52.101.71.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKza/58/hPpphVbYFWS/FCN3kwZqQpBqHcfLLUFRftajb0H9eL5aIx9bA9RsqMDHtHaLLcuywr2I0b3iQOUrIYoUanMmsLq8Ly/C6ehxdQXoLYTwQuMsH8XTUjpX1ssyFIGbhBKCWLAk24NKrHK1O7foi3eTM2IzhllZg/tOSnh5LPvBWExP3+12mUZdRimEySY+Ggh6UNnfWwt341GXZUwX+LwyP4yBIbU6W2V+C2oTQiNzaYapROAqDV/2HBGZy2xaG+yOq/WHMKeQx0lbtF2sfjCvbG47k2myC0ZzghoRCKr8bGLLZ8QHdIJc2t5IrQ3q/TUvwZ/GkFTC9vooAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3u10ez0PBDJl3I2341zM8S1nxZdGcY/LDkftrk4+Uc=;
 b=xLDOuqnAUzlYt+fKrCj2hh8kX9hxz9UvtC9ptBTXfpoE3kVjo3461XT4U37TP+OjzI0L20vYrieQHsYejzfjYEtK2Gbtm5bcmGKxuvd+12bsOLRM8ozwADemvIPZ5NsJDbjJeojxkYCL3C6bohVrEJFMPaXKA0xosfgaV+ymn/1SJ8cTUo+yHKUCTsick5aGZ7N23yujjxJl1FdklLAoyfj4ZhMOdiW7BRzkLdoPzC+hDbAeuEz2CgCQR7cZrY0DtAnFW+ThxCbrb8jg6xgaZGvrt20jkNo6FFzd6uh6qEveZnh8WgXTt8FXTvItAnGxol/cMt2Jz204x74WuNZpUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3u10ez0PBDJl3I2341zM8S1nxZdGcY/LDkftrk4+Uc=;
 b=FWGyBk7+3kxPUj7U92Qx7dhiXHgUUComPoFaVRN2puZjq2IYh3NTyBUhvSSlRndkhBI2xTDAiq8fxQHLRonc3G0LcxqCrjGodn1zHlv9dmkNfeQSSeVKNn5F3lHPAiejdBZsPW0onC3A11BUeDneoN7PFt7H2K/W9Uf+3i0w8zJq9P2C7lEiz+YIdFuFLdTPKILtVcAHSG8PsHvzgt7lkb3DlLxrL9PvbLU39Xdp5ibzLEc3N21irqfNhoe/YAqTMub5zRa/sn6v2/VaKFcH6g1Ao6rcRMwPo7BF+prVaetfMcMJpo8Cv0yMswjMmzADRrdVwIb45KWuplAA5qrjfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10408.eurprd04.prod.outlook.com (2603:10a6:150:1db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 14:54:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 14:54:30 +0000
Date: Thu, 13 Mar 2025 00:02:07 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v2 0/4] clk: Support spread spectrum and use it in
 clk-pll144x and clk-scmi
Message-ID: <20250312160207.GA21518@nxa18884-linux>
References: <20250205-clk-ssc-v2-0-fa73083caa92@nxp.com>
 <PAXPR04MB84596732B538D24F95E9FAC488C02@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB84596732B538D24F95E9FAC488C02@PAXPR04MB8459.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10408:EE_
X-MS-Office365-Filtering-Correlation-Id: 471bb8fe-548d-4129-0a2e-08dd6175cb39
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QbIT+TXALeTgSX6GVIevx4LWRcQkxzigLo0GE4iESUeAYHMhW066gcRRPqIZ?=
 =?us-ascii?Q?o+OJxgLcydvZ9UbxZL6xISSj9T3VgLvbMiRVAF+ipRIO1QKI1cIZDLNytxyZ?=
 =?us-ascii?Q?+Yzu4i6rublr0QIr4h1gi41TYky2wnsSDMZZBEYpXag9kDBJqpDGdtvl7THJ?=
 =?us-ascii?Q?5UZc/7ct3BxlKqGdTEf8J1U4Mbk2N1jQS7fWTVBAZa+1D50rTMtwVUQO1SOn?=
 =?us-ascii?Q?gIyuJ3YUWxJIZcPeliJq65oHYXNc3oiIKojJ1PuA9spognZ4i6HCIUwvevdy?=
 =?us-ascii?Q?bRwv8qixhViXSa14ENEEML/XDixJxON/bxnwEwINg+yY9E9m0WBXWm2FFgl0?=
 =?us-ascii?Q?qtj7a7ZOpVxsB37yQPuSYAgQQSghX9zO/unjxdgZo62ch0SUoH4LwTqSmAxr?=
 =?us-ascii?Q?Y6oGlT/t1vHovx370F4ntIjLKxrmGI1P4PIP2oIA20dmKbB3yfwICGg1XNp8?=
 =?us-ascii?Q?QVTTGvglxsMUyTP/tDI1dmD8nQWegCNuuOYrkTXnnQqCw94/ZmJEggTIwgr4?=
 =?us-ascii?Q?E5fbcMuYOtn5olu4eO99sHA7OUSDs0Lm9kJ7nTBDToDN3PTl71l2zGzsv1bi?=
 =?us-ascii?Q?cb7ILZoH5Bj5cal6UtZgOjivqJ1dYUhRDhmdFWARv/N57vmfSINC/g6hSRhy?=
 =?us-ascii?Q?S7/wLxEMnsVz0xeGNmju1iQBwKE4RrRNVcdDFJllOMLI/NMysffPCH+MxaBj?=
 =?us-ascii?Q?QPdmTXxZhLZ4/AEL6dpQWjCp793kVCkW7+2SpM9OnA1YyMv+xpPeDxr1dq8E?=
 =?us-ascii?Q?6wGHbVt3supRIxnCerRWDQab5N7R5SuIxxWe2Er5kdV0EPcFK95r19iCUACw?=
 =?us-ascii?Q?q8Egthj/yxcOD4+ldbjVeKxEhAGQ6iL+tkf/827tjrlJ4dyn0bOrcRhbJv2h?=
 =?us-ascii?Q?uuaGN9eM/9YVoxCjlIgW/pHC5VB98MfRlKeayeZsOphgojlVFWQNaApQuRyZ?=
 =?us-ascii?Q?JKYQ2W12MKcgSBPaGxSlkT/v1xCP8pSsDpgwTlb7BDen9KU2eMrWPh0vlhiM?=
 =?us-ascii?Q?ELmD1ynchH5xfMQv+ykuF2xybCn6+rZcw82tkGDrqdX9zEEhN4M2tsg3nyZW?=
 =?us-ascii?Q?iaymoqP6WXeyxlqMG9nKZhoaX65v/fmssZUyZbiyW/fXoED8ERQTMSfl2tSn?=
 =?us-ascii?Q?BYKoe5HQDGP1kH/yLxsQIdlHfu9CCuflhr01MeC+MULu5hKJLOkMMNCaXq2T?=
 =?us-ascii?Q?V0YevbJwShTRyBfevW2ry32EiUunUr6tvZ1r93W/Im2fg2Ez0W+tIIyLkUTt?=
 =?us-ascii?Q?bFmdqRyFzxXEIh8pxl4rQUnlUvEhq6iN4AYshLMfXD7urKTGyCimj9PClt1p?=
 =?us-ascii?Q?ryQda1DLhmAL9aleyoKs0i+w4hRcd7r9u86Ix12jzkFSDBl5QZPb5/zae4q6?=
 =?us-ascii?Q?pgx44UjWh1NBCX+43/d72NNNm8FiL281yeERDeDMB2iks854gg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(13003099007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?st5iZFi81VHjbBcVkm2AncRtU8bCg4WualtCQgefe7oSG+IO30325cCaNfdX?=
 =?us-ascii?Q?vmOgKaqdQpjzunb7ie4xAOLafFNBBRm/rpgmM7XDgBr1A9jc2msyol+q4y9V?=
 =?us-ascii?Q?wysF4R1IswrQYjGdtF58k7NP073/mzPTbnJvRlskrCjr2qu2hIQ/+cL5EEZc?=
 =?us-ascii?Q?1qSuISIhND011VuevRauVuGLJxjEA0574wCN6kgJVLiax5cJFcpxHUoNWKkN?=
 =?us-ascii?Q?8p5GLP/6yhsPI/Jzo+4HikCeb6PjkXB9Q/YOQXgIaNbgsOVWSpvLsnXCVRIT?=
 =?us-ascii?Q?5DEANH9t1jMt3m45YuVbX1Xy1EIQR9ji5N8QSnP5jdvdkv2kE30OAwiJEcBL?=
 =?us-ascii?Q?96pt1XvxiOqnzndz0JdmiMaaL5VlxWp7qtsdrCmehxGK2Isl7ATkcouPM8Du?=
 =?us-ascii?Q?yKbGFyDPE8u+IbtU32NUwrxdPMs2eK1nouH0WgD9YJ2odmNg+sM2sZIV7h6n?=
 =?us-ascii?Q?8rsfMdIut7wLIH92lBgftUQVYU9w6hn57+AJP+f67QnBYSFwpgIgPgQMUeOy?=
 =?us-ascii?Q?OwoTzURta8mkDQvA5xZ0rjyb693qGnsG+ksuvUQuH4BfDQ9CuFGfCWZHjBG8?=
 =?us-ascii?Q?2Hlu1smAq+jy1reRhAY2L/JBn2VCEPn/Xytx9GqER/h1RzLY9qRu8aKDEHya?=
 =?us-ascii?Q?3kUKyUlgejx2YQjAIJCAOnggGurcPipM4LsdX1okQFlrpiduL49pBQ+e7Wmm?=
 =?us-ascii?Q?DqI3AXhrzuca9b/L2LMy46GvR/hXm+1ahvNc21rYxVVk7BCllKUk/YSgLJyT?=
 =?us-ascii?Q?gnSKA41Z9za8yr4jBXbWnXrihGNZDijs1OcQtphOrpg9Jfe8y8l8oYDq3haH?=
 =?us-ascii?Q?CcLavrpdwf6kpTd6ES+gcWONcE2dQNXsXNUowNnc34Fy54ztzlPs4Dw+wDMA?=
 =?us-ascii?Q?ZlKIOUWCbaQKgIB56c5H61ICwKm4XhRqK4UShfIJo8UDR0d+9YOS542A5wJc?=
 =?us-ascii?Q?U88IwkNcLkKWuprJRjtOCB/NuBf3f7/yAin7Sj2ZjSMZcTDLHAhMnBQDzkfx?=
 =?us-ascii?Q?0VQFS5Cay3MSCvjgDFDlmxZEkedHGyvY/wu5ukYU3YpHbYUCdL2nUJh3KFWk?=
 =?us-ascii?Q?147AK8ABmjKcdHEQ5r3plYky4cbD8p72V4ikfQ0jI/kU0Hv3nsWRmuzdbSHW?=
 =?us-ascii?Q?Yll0vnQkGNv/1F9FwoAUHac8RhXBWFNwrn4UHWMHTkO/hHCEYHqlDohfZ2oP?=
 =?us-ascii?Q?H3upTbcwzsQS2NkmDT1E0gQs1ece4iuPgVVwBDnUF2WoRADGDlG52aN4FANg?=
 =?us-ascii?Q?ReLGySUza2dnfVhetqkhPPBUIpQd/aR0mDB8RXPOhoW4CxccCSkjuIDpjMfh?=
 =?us-ascii?Q?Olu5Vuh5Rt5GLIT8QME7yD4NHPO8b0vZTaJ4jIt0OblemZibxb6FCLkoa3F/?=
 =?us-ascii?Q?re8QP83XBXuImu0FV27r+wN5B7o/lkt3rSDyRd6gIfSexVE9CmF1VYYUZijZ?=
 =?us-ascii?Q?R3NgaUqkKzParPYcqyEHopuzMvHLIqtJ7Fpjzg/9ONKb7U2NEtAMUeYisEpd?=
 =?us-ascii?Q?d/usT+yTA+Q7XFfQ+syfBvm6dStvbaiE1qifwPEJt7mz7U2XBPYokAKZqSwo?=
 =?us-ascii?Q?l3gK7TVd53bpfCvuVYW7t7+UDdG38rrTm7Rw7YyF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471bb8fe-548d-4129-0a2e-08dd6175cb39
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 14:54:30.8167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlEG26S06kuiR+LiYKSeZYgeAsTZ4KbFKXIC/9r+v00y4XCnI0MLPh1ToVZS0qRPpIysZHR2qPaZ6Fl5s2rQAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10408

I am still waiting for a yes or no, or any suggestions.

Thanks,
Peng

On Mon, Feb 24, 2025 at 01:09:20PM +0000, Peng Fan (OSS) wrote:
>Hi Rob, Stephen,
>
>> Subject: [PATCH v2 0/4] clk: Support spread spectrum and use it in clk-
>> pll144x and clk-scmi
>
>Do you have time to give a look on patch 1,2 and the bindings
>part in https://github.com/devicetree-org/dt-schema/pull/154
>
>I would like to see if you agree on this approach or not, then
>I could work on next step to explore new method or else

>
>Thanks,
>Peng.
>
>> 
>> - Introduce clk_set_spread_spectrum to set the parameters for enabling
>>   spread spectrum of a clock.
>> - Parse 'assigned-clock-sscs' and configure it by default before using the
>>   clock. The pull request for this property is at [1]
>>   This property is parsed before parsing clock rate.
>> 
>> - Enable this feature for clk-scmi on i.MX95.
>>   This may not the best, since checking machine compatibles.
>>   I am thinking to provide an API scmi_get_vendor_info, then driver
>>   could use it for OEM stuff, such as
>>   if (scmi_get_vendor_info returns NXP_IMX)
>>       ops->set_spread_spectrum = scmi_clk_set_spread_spectrum;
>> 
>> [1] https://github.com/devicetree-org/dt-schema/pull/154
>> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>> Changes in v2:
>> - Rename to clk_hw_set_spread_spectrum and not export it as
>> consumer API.
>> - Fix error handling
>> - The enable parameter is still kept, because 0% is valid per
>>   https://www.ti.com/lit/an/scaa103/scaa103.pdf?ts=1738667308903
>>   https://www.synopsys.com/blogs/chip-design/understanding-pcie-
>> spread-spectrum-clocking.html
>> - Include the i.MX clk pll14xx which was an effort to enable SSC on
>> i.MX8MN from https://lore.kernel.org/all/20250118124044.157308-1-
>> dario.binacchi@amarulasolutions.com/
>>   With this patchset, things could be simplied a lot.
>> - Update the clk-scmi extconfig, marked as not apply, because spec not
>> settle down.
>> - Link to v1: https://lore.kernel.org/linux-clk/20250124-clk-ssc-v1-0-
>> 2d39f6baf2af@nxp.com/T/#mce926ef10d3d9c1c960c21867c2f1509f1
>> f87cb9
>> 
>> ---
>> Peng Fan (4):
>>       clk: Introduce clk_hw_set_spread_spectrum
>>       clk: conf: Support assigned-clock-sscs
>>       clk: imx: pll14xx: support spread spectrum clock generation
>>       [NOT APPLY] clk: scmi: Support spread spectrum
>> 
>>  drivers/clk/clk-conf.c        | 70
>> +++++++++++++++++++++++++++++++++++++++++++
>>  drivers/clk/clk-scmi.c        | 47 +++++++++++++++++++++++++++--
>>  drivers/clk/clk.c             | 34 +++++++++++++++++++++
>>  drivers/clk/imx/clk-pll14xx.c | 66
>> ++++++++++++++++++++++++++++++++++++++++
>>  include/linux/clk-provider.h  | 32 ++++++++++++++++++++
>>  include/linux/clk.h           | 22 ++++++++++++++
>>  include/linux/scmi_protocol.h |  6 ++++
>>  7 files changed, 275 insertions(+), 2 deletions(-)
>> ---
>> base-commit: 40b8e93e17bff4a4e0cc129e04f9fdf5daa5397e
>> change-id: 20250124-clk-ssc-f3d70fb6cd1c
>> 
>> Best regards,
>> --
>> Peng Fan <peng.fan@nxp.com>
>

