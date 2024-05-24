Return-Path: <linux-kernel+bounces-188486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F139D8CE298
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A992A282B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D3138F97;
	Fri, 24 May 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GcR+a84q"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA49112AADF;
	Fri, 24 May 2024 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540514; cv=fail; b=qpVkBsEyu1vEDhP6/seWE4vAc3+VXCgZroL2DiLEYJC9xlunfPGVfNOfcsxFOvcZf3BtJbakIcVTUPElZENeb05nPn3qfJjjC2rKQ8KofOKGsGEdeQq6j39xrOfRdfkeB6Iy405lVWXYXL45HZhA/jQQ1QZ11R/EBG59er+XqRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540514; c=relaxed/simple;
	bh=LWKAGIH9tDc36UufMMQOuwjIC6V0io4ZsjiO8HoKU80=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ElyIEywgTsPKETIlLDjC4iTCV4PZLwaLKiuzLj9GOZrvaM31x2FLkpgKiVNyqoTaFsT7Eoj0pmZYYcHOc0xYJVwhNXg9H9uQ0KBEknfb9enM+Al8o3x8jPAbILL+HwJ8mx4TlhpyA4mpayk3Vcz9YguI51vN6Kfp2gArtvYFVho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GcR+a84q; arc=fail smtp.client-ip=40.107.20.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9wns8TzJs58rdOaQITyoD0EtlEFi0ewDj+1S/7IvI9BOX/QjEvjB6z9XRd+1S/91MIA2+Y/uDT2pJXnmnQizVGnEb6XmUiJp2Ku3YpqpacMreLeXf80/HLd+pyRr/EDzPNx+kG7IecovIs9olo5Mk7CO0ZteVjaLo3J41UnlePvgfisV7TMgpnifcCc8vJjeZblDoGjlvFHlbbW7PGZ/eBz1D+7a3BDLbo7WuOnrrDHr6U1zAOT5emSZfNS4L69QismalnxX1ftIBiQFtB86VVH4Ziigdcpfo4VIZvDSl+RPgT4q2wQlp4aaOSNLw7x7n/ntUhRsuGkiad+jkaLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxAD0WISAG0EhoVXlvP6rzvlgsWO9vyOxx9AzUN1bCU=;
 b=SZ0cVxhek+iuW9EQOL6eIrwCNK9lQMHQYdcvIR5ADO9lGI09/oQB5kugmPAIjLRmLsrIsk3dF6oPMNeXxXiIvDGcmHDfxbgtxpXPio6jFOw3oACco8DfeawNY99e5ZgM9n0ISkKKtkZEiiewdwQ2DsIiav5MZW6D/8N5p/feakHO/lS8gb1y4Vdb02bvT7y7hy04rA+xfTspG1wFWKQ/w0sCwtFAPyc9GZ6m4HhbAcLx9vPffXlxIkW8JM6wqF+7SX3SvalMSN3zcbG6Nlo6yXhN3J26qC8KvI1Tcl5ySdrewX0Cu2t4r3OAez90Pu6sGP9Ggu/LeaVuozr9uXodIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxAD0WISAG0EhoVXlvP6rzvlgsWO9vyOxx9AzUN1bCU=;
 b=GcR+a84qnTWWVALBjwNhRXHGvLB9T/lf7VSUqGkSi98gwj/Y/w8l/re2ZaITSq9pYVLUrOg/ZqfRLQ4sO4IpSjISYLqesBrH5Y/wZzvdstnZmjmC/9vn10D5r0SzYg+er34zKuHWU0fqVehKqVJv0pnf1fXmFnT0XnUs4e6Ad/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7149.eurprd04.prod.outlook.com (2603:10a6:800:12e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 08:48:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 08:48:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 24 May 2024 16:56:48 +0800
Subject: [PATCH v4 6/6] firmware: imx: add i.MX95 MISC driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-imx95-bbm-misc-v2-v4-6-dc456995d590@nxp.com>
References: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
In-Reply-To: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716541024; l=5269;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=pFqUijGRbVOthzctHp+yS2z1grZ4Uyz1kZw2bfBgIOs=;
 b=r5S2v6roL2kbPs7O8mi0MQNHJfg1moHv8hZi8JFaX2cH4+7SqR13KWXsfZE8JFXEff1LTi8SK
 ixZsX/9WBzQB22Yitx4YCB2202Jlj+Jwad5ePQ/Md4g4vRBVAYGMSuL
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: d543bede-051e-41cb-9885-08dc7bce48e5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|7416005|52116005|1800799015|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2hTUm1zTVhNKzRHNnZYZ2wwOWk0VFV1cjI2amV4TWtmd2x2MlVRS2NzRndk?=
 =?utf-8?B?OUtlYWxTT1JPdyszNGg2M3k1cVVBbi9OMlNXT0Z5ckxJYWRpT2NyZlZNMDZr?=
 =?utf-8?B?YUg3bDhpUGQwTEk2cE5WdTFlVXpVZnN2VCs5UmZ5VGRBUXpuZ1YyZUNDazZl?=
 =?utf-8?B?RXpGQ0JFY0NKZ0kxRjlheURQWnNYMHk5c1VuUVJLVGxWV0tja3RWQmhjS1o5?=
 =?utf-8?B?YkRqTGg4bWFETGE2S2VpK0NRQ2JXNFZMZmRsYnFGWWU1WjZIRXhBZ1pITUlN?=
 =?utf-8?B?WEQvcXBKTGhpSXgvUzBFK1BCU3FzSVZZMlNlNkZvQk5tSnVzS1l2NFc2MFdO?=
 =?utf-8?B?bFRRYmtlV0xxODNPM3RFc1FQekdtYXoyMnFIUXNOaVJzVGJadk90K1pkWVpR?=
 =?utf-8?B?VjBvbmcweDhYNGJOdXJSM2puMXNMTXRMVzUvMTI1R1dzdjZtRm9CdXNFUTh0?=
 =?utf-8?B?R2d4SUVHZjMyNzhEMkp1bXorcFo2TjVSVXdyN0U5VVVSUVF4VkoxRWNDb3RB?=
 =?utf-8?B?cDVkOHdmcDlHOGFIOERVVURDd3JhcmIvUUp4VDN2S3V4cS9STjhiQXh0MHkv?=
 =?utf-8?B?QXd0ZXVCUXYxeGVDYnJQck5NbERTYVhYY0QwVjRXQ3BDOWZhcmpwTXkwNUhU?=
 =?utf-8?B?TS9rc01GZmdxRVJmOUZ4cm1KZkx6YUY4a0JrVU1SRG90RXFBQis4Qk9Pempw?=
 =?utf-8?B?TTZ0ZFBuNHQzQTNOT0orbm4wWC9nVUk1cXdIeUlRR1AySlhaQnBaR0JheDJ4?=
 =?utf-8?B?c2RVUm1idDZMWjFoN040R3BjVjlydEdZZ29sTi9PSE5jWUNhcUxQbkU4dmh4?=
 =?utf-8?B?MTJ1UUwxN2JrSkVza2R4cjJCRVNNVzZKUGhwOCtBaWpDdHdqcUFDcVl1MlV2?=
 =?utf-8?B?VDJJaHFoU2hKWWRSYkpYcEhkclhKYi9rbkFlU0FBenZid0M3VWc3TjZ5Y3FE?=
 =?utf-8?B?eGVOMHNQSk1ZNGpNZVpIcTZ0TFhUUkFOSldYd0UybGp3YVdJOGVJQVN6MHh4?=
 =?utf-8?B?NVFCVjNXbW4zQWE5VnU3cU9jemZWUi9RTnZKVCtueiticWppNTR2cE5rd0ZF?=
 =?utf-8?B?bEl6YzZsb1l3c2FwNUhNWTlmTzZKcjNmTDIzOVBvckJ2N3VseFdXK3FULysy?=
 =?utf-8?B?UytxSUVOSzQ1WCtPQ0puSTFKZ1lLQTZTVU5Ub0VxVm9hMnV0Q3FUdlFqaEdw?=
 =?utf-8?B?eUx5YXdoS3VGQllIMGZMTVVyaVUvSm02cW9ETE1xY1F4N3dYeVZ3ZEgrajJr?=
 =?utf-8?B?TFA5b0ZSc2NQOThlMDJzbGE1RHEza0RXMzg3Rkwvd2Voemw2Vk1XN1FMd05z?=
 =?utf-8?B?cjFMRzdEVm14MDc0R2tXYVRETHRuQXNlQ3hBdmNMcFZ6QU1KN3FCVk5ZREs2?=
 =?utf-8?B?eXczVldEUVUweHNqWldZV2svOVBhdlpzSS9jZWgrbFNqTzZhNERiNHV6R25y?=
 =?utf-8?B?NzVaangvQnRrQmI5TkxteDY0VE1aSnI0cjJubTJ4SmliZFVxeGNFUEN3dUky?=
 =?utf-8?B?QlhKTWQrUUVpRU9Oald4SGZLS2hna09La1ZRQ2FtU3l0cDZIOHRaVE9HRWg2?=
 =?utf-8?B?MjFDdG9FS0g5TG93cHNZM1BuTEsxeVBiUisrOXRlbkJSajhPTndtYVpXSHlR?=
 =?utf-8?B?NmtqbjcrWUdEQ1VZU3M4eUEvdmkwSXF3ZlJDaWtBVHd4T2NCcHc1a3ljZEs3?=
 =?utf-8?B?VFhLa0psR1ZZV0UybUdvMW04L2hCZlJnZnRHMlNLbDdHOVVTMThzekNZZzdh?=
 =?utf-8?B?RmZsUUlzMTE4aEV3TkFRMHBmOHNmQUd4dklWbDIxMjlSRm5oM2VtdlRJK2Nv?=
 =?utf-8?Q?Scq106TpgCTGipFyc+tnsWCeO1AibwtD/mwX8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(52116005)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmcxemVUdTVCTzJGT0ZUQXBrZ0J0M2FNb1ZqNUMwRmN4YVNIN0RjMkgvb0tF?=
 =?utf-8?B?MEh4N2hYejJOd2xGTWVGUHFDdnNaa0hIOHZhMUxNWFVEbzBvRjE5bVJUb2JI?=
 =?utf-8?B?U2U0MEs5Y2x5cWhmRWtpZWhBTjlXNUpvZjc1cmR5M3MvdWdjZENWbEJiZlJr?=
 =?utf-8?B?Nmc5TTY2SEEvdFRVZDY5azk4YitjcE11OWMyUGU1b2Z4YTJJZVd1MGYxOGFN?=
 =?utf-8?B?OVRTZTh5VHVKUnB2WHhmeGcvdUJGcE53cHAxQlU0Y056dXBjQi9WdVU2QkJW?=
 =?utf-8?B?QjR2VHpOMVd5SXJtcmpxdXVPV2w4aFNBQnpra0lVQStFYlZxcm10MVQ0VGdw?=
 =?utf-8?B?elUzZWx0Rzk2eFpFeFQ0T1liOTJrNGRTa2FlQkdlRHh2OGdiZzNHSUNVMk9z?=
 =?utf-8?B?UmNxcEdZejFnL0dNZFlTbTNENTBjMm9QclVUL1B2QVg5LytVMC9wKzUrSTlV?=
 =?utf-8?B?MklaeTZlemxPQTNrTTFiYy9IeFAxdWJQWitKaHF3bU9sZHpRd0xvVmZOdW9Q?=
 =?utf-8?B?QkswNGc4Vy9haUdrcmxYazVRZjBpdXJ5dVY2enBQaXJhWWVrSU1BS3JKWnRI?=
 =?utf-8?B?ckFPN0tZY2RyaFp6dDB4N0RwbmxNM3lzcHJPT3Mza0NRSFpmTENSZkhUUm9o?=
 =?utf-8?B?VHQxRXJZMXAwcklxWTc5K1ByckJlVU9MeFZIK0llRk81K1d2a05Na0s0Njhh?=
 =?utf-8?B?WGk0bE8vRlJxSGMzQ0Voc0lhRTY2RUI5cnB2Z1UxeTZkR21Ta0RWUTZYZk8v?=
 =?utf-8?B?L0svVlpMUG5tTzZxQ1BHMDNyaGNYcWNmeUFWRUwyV1lrL0wvRXMwdGJQU0Ux?=
 =?utf-8?B?T1ZST3RSUlJqNDFEV3JCajgvRzd6ZUt2MU1aclNzUmkrcWRqRDBsRmFRTmQy?=
 =?utf-8?B?dnFOUHBLbG5zSjBKWDByelNaanBEeDlxNmlHVlZuMW1pRU1SZzc1ZVJJM3BM?=
 =?utf-8?B?MmVRdE9acklXL095RXRhbklZUlRwOWFXNFNPZ05VVUE0eTNwdlk2eFNHa0ZW?=
 =?utf-8?B?QUM2WmY0K3RzRldnZmZ1UG50czRDVGQxQWJ4RVF2aThlZ05Yd3kyUVZ0MXZJ?=
 =?utf-8?B?NzZWbGFuTTVsNVcrNWg4ZGo5WnhoWE54WnBxTFV2dnhKanBsaXAzTEFYdElG?=
 =?utf-8?B?cVNxaUl5RlQyeE10RythL2lSdFduOVBNdytwY2k3bG9CL0t5blBTMitQWXVZ?=
 =?utf-8?B?YUNVYncyQ2FLc2pGRUZMdDh3dWJSdDFlYjdTMDRSaS9QdTlsTWRGcjFibU5Z?=
 =?utf-8?B?UXpHcGNiYkpxbW9xeXBTcEVacDUrTTRSZmxSVjhSZXJSRDJhckxXbElwVWxq?=
 =?utf-8?B?dUlMZ05semlzUWRMNVNMZFdxcWkya3pod0tFRFNjdVZRZCtzTk1OWEYxU08r?=
 =?utf-8?B?VTBUZlViVEVkeE5OY0d6bkpKMWEvQVBpbFVvWFEwbkhXMGxFUzcrNUNZQnJ3?=
 =?utf-8?B?WGJKL2RqZDN4M0xDd3E2bHAvYmI0NFExa1BvLzZRS2VVejJHcUxhcWMxWjda?=
 =?utf-8?B?NUtIOXF3cWljSUpTbGFnN2svTm9LeHRCVGlGaktyTzJCTkllMGFtVVdhZ1V2?=
 =?utf-8?B?SnNSOFlhT2dzOG83UjlVYytIaFlwNXNnazBqWTVlQTNSTThjT1J6U3VQQUwz?=
 =?utf-8?B?NCtWSC91TGhyYzRWSnJKaXJmNW41RHg4Ulhac3hvdUJHNjBUaXl5NDE4a2xD?=
 =?utf-8?B?eUh0d2d0QU9NYWZqVDhXSDd5Nnk1bG12aithYTF2YmphRVUvaHlmaTFvVzNJ?=
 =?utf-8?B?UzlYUUNoNklSVTlWYlFVMXNXTzNrSnRrR0FKYW9aM1ZySGpBeTFmRGR0WFlx?=
 =?utf-8?B?SmJDQ1U3QTZmc3o1WkI4U0xnSXpkVVhpdjJvNkFaczlOVlk0UWhNM3c2TFF3?=
 =?utf-8?B?UkdxOVB5ZWh1L2F4Q1pzUmwwZUxPNkdTclB0MDZObzI2UFVwMVBZK0RONmV6?=
 =?utf-8?B?aUVSamVkN05MQTR1bVdaazlpT243SEc5TVUyWVVVMTZhNHpjVE5jeFVmSVA5?=
 =?utf-8?B?UXNzKzZTN3ZkakpvcW5JTlVsUmRTa2RuczVHdjlLaUh3cWdwSlFhZ0lRbElH?=
 =?utf-8?B?bnhoK2xJWnBYOGk2bkJtdG9nWFJEV2Rwd3d1QkdjNFNYK21xZy9nTmc0ZWpz?=
 =?utf-8?Q?G1DMh3TM+oNzM2QOEpVd+V/Ms?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d543bede-051e-41cb-9885-08dc7bce48e5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 08:48:29.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gL5+k130hyxT1fdH2B9iUPcacBRoSicVJCbP5maOj8e8S9R9p4tphjqBE1s2UzG1EyKFCCtBrcbTKDn6EL+YDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7149

From: Peng Fan <peng.fan@nxp.com>

The i.MX95 System manager exports SCMI MISC protocol for linux to do
various settings, such as set board gpio expander as wakeup source.

The driver is to add the support.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/Makefile   |   1 +
 drivers/firmware/imx/sm-misc.c  | 108 ++++++++++++++++++++++++++++++++++++++++
 include/linux/firmware/imx/sm.h |  33 ++++++++++++
 3 files changed, 142 insertions(+)

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index fb20e22074e1..cb9c361d9b81 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
 obj-${CONFIG_IMX_SCMI_BBM_EXT}	+= sm-bbm.o
+obj-${CONFIG_IMX_SCMI_MISC_EXT}	+= sm-misc.o
diff --git a/drivers/firmware/imx/sm-misc.c b/drivers/firmware/imx/sm-misc.c
new file mode 100644
index 000000000000..22c1a5819425
--- /dev/null
+++ b/drivers/firmware/imx/sm-misc.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP.
+ */
+
+#include <linux/firmware/imx/sm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
+
+static const struct scmi_imx_misc_proto_ops *imx_misc_ctrl_ops;
+static struct scmi_protocol_handle *ph;
+struct notifier_block scmi_imx_misc_ctrl_nb;
+
+int scmi_imx_misc_ctrl_set(u32 id, u32 val)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	return imx_misc_ctrl_ops->misc_ctrl_set(ph, id, 1, &val);
+};
+EXPORT_SYMBOL(scmi_imx_misc_ctrl_set);
+
+int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	return imx_misc_ctrl_ops->misc_ctrl_get(ph, id, num, val);
+}
+EXPORT_SYMBOL(scmi_imx_misc_ctrl_get);
+
+static int scmi_imx_misc_ctrl_notifier(struct notifier_block *nb,
+				       unsigned long event, void *data)
+{
+	return 0;
+}
+
+static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
+{
+	const struct scmi_handle *handle = sdev->handle;
+	struct device_node *np = sdev->dev.of_node;
+	u32 src_id, flags;
+	int ret, i, num;
+
+	if (!handle)
+		return -ENODEV;
+
+	imx_misc_ctrl_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_IMX_MISC, &ph);
+	if (IS_ERR(imx_misc_ctrl_ops))
+		return PTR_ERR(imx_misc_ctrl_ops);
+
+	scmi_imx_misc_ctrl_nb.notifier_call = &scmi_imx_misc_ctrl_notifier;
+	num = of_property_count_u32_elems(np, "nxp,ctrl-ids");
+	if (num % 2) {
+		dev_err(&sdev->dev, "Invalid wakeup-sources\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < num; i += 2) {
+		ret = of_property_read_u32_index(np, "nxp,ctrl-ids", i, &src_id);
+		if (ret) {
+			dev_err(&sdev->dev, "Failed to read ctrl-id: %i\n", i);
+			continue;
+		}
+
+		ret = of_property_read_u32_index(np, "nxp,ctrl-ids", i + 1, &flags);
+		if (ret) {
+			dev_err(&sdev->dev, "Failed to read ctrl-id value: %d\n", i + 1);
+			continue;
+		}
+
+		ret = handle->notify_ops->devm_event_notifier_register(sdev, SCMI_PROTOCOL_IMX_MISC,
+								       SCMI_EVENT_IMX_MISC_CONTROL,
+								       &src_id,
+								       &scmi_imx_misc_ctrl_nb);
+		if (ret)
+			dev_err(&sdev->dev, "Failed to register scmi misc event: %d\n", src_id);
+		else {
+			ret = imx_misc_ctrl_ops->misc_ctrl_req_notify(ph, src_id,
+								      SCMI_EVENT_IMX_MISC_CONTROL,
+								      flags);
+			if (ret)
+				dev_err(&sdev->dev, "Failed to req notify: %d\n", src_id);
+		}
+	}
+
+	return 0;
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_IMX_MISC, "imx-misc-ctrl" },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_imx_misc_ctrl_driver = {
+	.name = "scmi-imx-misc-ctrl",
+	.probe = scmi_imx_misc_ctrl_probe,
+	.id_table = scmi_id_table,
+};
+module_scmi_driver(scmi_imx_misc_ctrl_driver);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("IMX SM MISC driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
new file mode 100644
index 000000000000..daad4bdf7d1c
--- /dev/null
+++ b/include/linux/firmware/imx/sm.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef _SCMI_IMX_H
+#define _SCMI_IMX_H
+
+#include <linux/bitfield.h>
+#include <linux/types.h>
+
+#define SCMI_IMX_CTRL_PDM_CLK_SEL	0	/* AON PDM clock sel */
+#define SCMI_IMX_CTRL_MQS1_SETTINGS	1	/* AON MQS settings */
+#define SCMI_IMX_CTRL_SAI1_MCLK		2	/* AON SAI1 MCLK */
+#define SCMI_IMX_CTRL_SAI3_MCLK		3	/* WAKE SAI3 MCLK */
+#define SCMI_IMX_CTRL_SAI4_MCLK		4	/* WAKE SAI4 MCLK */
+#define SCMI_IMX_CTRL_SAI5_MCLK		5	/* WAKE SAI5 MCLK */
+
+#if IS_ENABLED(CONFIG_IMX_SCMI_MISC_EXT)
+int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);
+int scmi_imx_misc_ctrl_set(u32 id, u32 val);
+#else
+static inline int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_misc_ctrl_set(u32 id, u32 val);
+{
+	return -EOPNOTSUPP;
+}
+#endif
+#endif

-- 
2.37.1


