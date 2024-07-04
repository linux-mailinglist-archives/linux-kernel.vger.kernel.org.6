Return-Path: <linux-kernel+bounces-241099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2700492770C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D347B281A3C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7D11AE869;
	Thu,  4 Jul 2024 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IQkwDmAY"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010056.outbound.protection.outlook.com [52.101.69.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340F27452
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099285; cv=fail; b=cE1G5kmzmg8F0P9zKRGFc9vH4HR3KvNOEwktN9/OP++cv4ROXucet9IeUh2pV7gHJu5Rd72JcYOtCJKESCUNDdSO7sg0+4HuM5ncEQfCymGwiq/p9YTWQdgNCmZSjfEbjX60Rlmu6Dt13OWxpySFUAiQMpv16qpMj7ic5ifY0dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099285; c=relaxed/simple;
	bh=RVkWMjcCMqugx7ZXO4KK1b3IZ6Gy54ufQ1NT3e5grp8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FDHIUW8t2KgTOyAXdvowsxbiM66UnzrH0fXNjP47DhDMT7L2f/HzXwyz3KCNYYSVT0L3f3DTiDNGRLwZIjS6YMEVGmVqVApzeVUW0I/tnF7ZPPlAIfxzxdnCqOi1j5KNGsjK1S8w1YcOOyuVS7rA8LCa8LqxwB29W3DdxZ68DRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IQkwDmAY; arc=fail smtp.client-ip=52.101.69.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoVyJkbeTeDnPnOo9IaXEzpFc4Z7MZTo4fO2bqZpRwfKDSvbXNWeEuNNSKBvQg6JtBWPKPm9qwgyFOPflPstMfAEQ8x73Op9ZeBy7KzEvCkm46GPDc/jtAgcvG3BZAXth5G70saJUecd24fd3UTMzvsxAgq+Og89nPf1txYD8N4knJokL/hJaungGbEYYZ54rYiqj9/DPvQqq40dXlCz+QPI6Czxs0LxISSLgOrus1EPUFMub1pgMkwlohjd1z/pS5PLv2MzRxsA4H3FhmrmH61BWtWS91Z0Ne9uF/kT4xJqcX25dnfaPYmvj5aFH83gNt3vez86jwiS0A6aKpI6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aIGSENashp1opWHQNZ/LlzM9Td+liywpUh9IgXwvsw=;
 b=Uo1HzBpG/kQUzoZURUpeeqi/XVSdaG4UIY7sqcaSgjyuUYg98+I5Jp+/Vncj5PxO0XhyasPeyGKMLJYzFxVX6DGCLh2TJdliaQAa7F8uvgwSWURZeRXIr1HU4E8t9eVvq8RduZav2wtyPZmP55IvZvPcLoQDztmE5QwxtT/1Hs9XCEyqa6bOc7+zq98K1VQ6GI9PriKQ4U7dQQMRTnYiCDTXbCE+zFo8hNldHpGdCKG7znPEUskET1LxggJuX9AOV99oj080UzOHXUU61+Xgos8Gw7W7c4h9rwkb/xlf6zpUQH2sTF3whMPZjxBJHg4YD1LBmVwlZZH56nRQZNngtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aIGSENashp1opWHQNZ/LlzM9Td+liywpUh9IgXwvsw=;
 b=IQkwDmAYdyLAO6CVXvdFTVKuG4ZlzxHyxgImgYBgS18V0hTXdWfTsrAY+IHQZ5l9bjK83rnDQKmVRrpaBxVXNgKO5azmFaVV24Bq8icKmPGFquzmss1A3G/SMuWbKIgyvvpjIKRNs2KezCMlnhoO5DrGYEIN4uK4bNIBO+2AHb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA2PR04MB10422.eurprd04.prod.outlook.com (2603:10a6:102:417::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 13:21:20 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 13:21:20 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>
Cc: linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	s32@nxp.com,
	Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH 0/4] address several S32G2/S32G3 SoC based boards particularities
Date: Thu,  4 Jul 2024 16:21:12 +0300
Message-ID: <20240704132116.2865864-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0027.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::16) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA2PR04MB10422:EE_
X-MS-Office365-Filtering-Correlation-Id: 108b590b-f7fc-4773-a86e-08dc9c2c316f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDNkWlN0MWJEL3NMOXZENjRoa0I2VEpzajN1eERZRVhidDlJaGRPb1NQK1dO?=
 =?utf-8?B?ZUliR0tkei80cjlOcUlpMGpyYmxRUTVpajd6WTYxa3ZQQldPUmYweEQrbDhR?=
 =?utf-8?B?NFlkQmVmVlJtYllNeEZGS3gxR1lIVnhkVFlZZWJDOVZaMS9wemN6RkZMelBC?=
 =?utf-8?B?dTc5UUxGSjRxczRzSHBQZVRzNER2UXRPZHBoOG5rbTgwbEZqdDRzRG9UYnJt?=
 =?utf-8?B?ZEVZK2w3d2gvNDZGcFdYVmluRUI1SDhZdk9OZHl0amVVV1RSMlhVRC9aR2Rt?=
 =?utf-8?B?UWxrcWsrMVkzMkNhcCttTERwN0tybEJ5NTNaRG5KMXZNNXljWEJxL0s3anoy?=
 =?utf-8?B?SXhZYmJ4YTYvNk1TeFBrWGdNNWk5eCtEcHVMcXBIekdPaWdlRHdISDdNeUE3?=
 =?utf-8?B?S2ZJZTdSVWo5cVVkbUlpZ3puUXpqdmFBbnMzRVZRRjFqUFFhN3NCeVdwK29i?=
 =?utf-8?B?VEdKbC9ZVDlxbTFrLzVtTjNvYitPWStPQlpJNTR2aFBDbnk3Mnk4eGlqZk03?=
 =?utf-8?B?S3paYVMyeTJneWE0ekVVR2FJSEJPcHJDRmxlYzNIazZaaENUWUlOdlhDQTBa?=
 =?utf-8?B?VVZCMmp3SUxpS010OXN3aGxLb1VPdDJMcHNFWnhzT1pPaDFRM1ZpWjk1R3px?=
 =?utf-8?B?NU9sSFBybStpR1J1eTYrSzl0ZS94SHJ0VGd6TXpxb2JjQXFUOGV4K3B1dU92?=
 =?utf-8?B?bDJSUWpvTjdlMzhpcWQvMFIwSU0xYktFVitzd1d1N1ArMGFWTlJzb2Z4ejJz?=
 =?utf-8?B?WWh5VjZMVVB3NTI0R3Y1MjFOcTR5cXBVK3NOaEUzZ1BKcU8wNGxFeUZUVjZ1?=
 =?utf-8?B?QVZJY3JYaFpaMTlRMUdZbFJTZ2FPY3hXY1JiUVY2cTBGMVZCYTh4Z1ZkMjEz?=
 =?utf-8?B?dnRqNGxDWWk3ekVnSkw1c2hPYm1PbmVCekRwVi9MSkR3NUQ1MnloWUdVdXEz?=
 =?utf-8?B?VHg4cFpJY1V5c3cyRllmWktNZS8rYW80RnBXWnR3RmgwTElOMmVOaDlXajNU?=
 =?utf-8?B?WSs3ZkNrb3BDMGsyRWNtNnRidHFWU0FVU0NvZUF0NjAzQTNlOTNCbW54d1JO?=
 =?utf-8?B?Uk5TYmorakN0QjBFR3ZPNWpUcERiUjVyRVQvdnlxRFhEVVNTakk0dEFaalVk?=
 =?utf-8?B?NEtXQVNJR1BIVWVOT3RLUGZXeHFRbFhUVlo5UHJuN2k2bnRYamczMUlvVy91?=
 =?utf-8?B?cUtZd3N5M01oZ0w4UURTUXhLME9YV2taUXpMK25KNXRvcUgwNzRReWU5aEoy?=
 =?utf-8?B?RzBrbFZOcEJHODF2TzJRTldDaTR3UFBTTDZBb3MrY2c1VWNBbCtSVlViTlFB?=
 =?utf-8?B?bFRQRU5ETE5kU3FpZjRFZ1lKRk5KTmROa0p6bFVXbnZveXNhWTVJeE5LczBh?=
 =?utf-8?B?emVqeFoxVVBsTlhJRzcwVTl4MkxZNlJBOEVYWTlzMHhvYmRvV0pnZlpVVjVE?=
 =?utf-8?B?cXhlVk04c05BbnFpMVlGQ0g4bFFuNkJiZ3M2NjFKUTJjbG1tdlFUbVdZU2t6?=
 =?utf-8?B?MVY5dVEwV1JJWmNKZ3FEcElKcGRLUm56VzBFZHpBeW1sdUI2eFAwaWU1amVV?=
 =?utf-8?B?RVMySHhPY1NEaFZuRGFIMjI1OG5jcHVzUHl6ZjVSOUJLQUt6aUpyaWY4akZP?=
 =?utf-8?B?U0ptOVRtbnVWTFVwNDBRMlQzNVN0SWdhV2RQWDdCM2pBczRiamM3OVdZeTlw?=
 =?utf-8?B?UW5TemZrYzgvSlZSNXB4ZnJhZm83ZVNpc3YzNFRyNXFsL3RLcXBzeDg4ajA5?=
 =?utf-8?B?THBTZnpEemVMcHJtdUZYazJKMFJxSzFhWlE3eDdrTnFRaUplQkF0azkyRmJN?=
 =?utf-8?B?NnZIZnRGblN4UTRIbHVjQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Szh0VmJBNDVjMHE1dzZMTUhreHdJVUVFcmV6Q1JOQmMrRVRxeUxlL05pcngx?=
 =?utf-8?B?UHd2TmwwZVY4VUhuSFkwQlRvRVFWaXFzUENYa3I0WU1KaVN2QW9EWEZmOFl1?=
 =?utf-8?B?cEZkVEFtMlJDT0wzVWtEMUZ4enk4b01vQ0ZJYnQ0ZzAxZ2t1NVZjSU9IY3gr?=
 =?utf-8?B?WXI3MEV0Sm90WkszbmxLUlhBMENTTCs3b2QzTGZqOEsrYkZvcXZHUjN0aGZ1?=
 =?utf-8?B?aGhqTDZUS3BEZzVhZGpaWU9LRWkveHRGbmxsNnJldEduRFZlYjlsRCt3bVhX?=
 =?utf-8?B?Q3laY2Q5aTJMYkJmUlJYUkhNMGRPVGJldEN1RVBJcTdsTUwzMk5WR3ZoMG5k?=
 =?utf-8?B?VmlIY3doNVM2a1ZhWXFoaDBsSk5iRnpnSHZjdGlhdGNjd2VtYzBXOFNEN0tZ?=
 =?utf-8?B?Y1NiR3premdEOHdRYndOVUFPTkl4MXdCZ21hZm9EaUhIQlprUU9SL0RtZzBF?=
 =?utf-8?B?dEFsSUhlVWZsWVg3NkpYNDZlNW9Qb3VTMkwxVm93UlZIUkJEUThiams1aUpl?=
 =?utf-8?B?NXlaWmw1Zm5iMTdzeVpGTmZ4ejc3Y1V6YVlqa2xzdG5SRmZZQlIrS2h4SStq?=
 =?utf-8?B?TkZzNTBXZGhRcW5MbkJKTHY1NW9Uc1RBS2tvWGJMbGJhU3dGY2h1THRFVzFp?=
 =?utf-8?B?dWVnS0Nya3BrWEJrZStlby9hV0JKd25WM1ZaQ3hEVE52NVFWZURpaG14Yk1H?=
 =?utf-8?B?VVh2TjdYLzRDNE1VdXAyM2NvKzBhdExTWHRzU0xYaElHanMrWHFjK29WbnFZ?=
 =?utf-8?B?OWQrdmtkY0NhVjNzREdlSEtXRU0xYjR0YkxCY1RvMjl5RWdEYVdJcGZ6Tm8r?=
 =?utf-8?B?NTRjU0JPV3NaVFN5LzBncmVncVJNbUI3NlRFNzQwR3VHeEJmcGlxeVRTVlJ5?=
 =?utf-8?B?WkJaRWRYaDJ0ejFTUEVzNC9KSVRLUmtEZmxGeXlFWSt0WWZqeVl2NUwxWmZU?=
 =?utf-8?B?UFFTK3JCMnpLOXZTQ2ZLY0UrRzE5NUNhUFdQSVpyYlRtcnlnWFVpekVyaFNT?=
 =?utf-8?B?Um9vN2ttK1pkY2hFbTRvVGJQVllhV3NlbTVJYUFsQjlKVkZHbWVNcEpuWDZW?=
 =?utf-8?B?UnJVeHFodXpOVkR2cC8vOC9zQXpic2xYVUplVDJ6Sk1LT3llc1E0eVByTWR3?=
 =?utf-8?B?aW1ERVZLQjQwMmhjdEhmOGJvM2JqZEpGcjl5S0NVZlpIdXFpaGh1TkpkcGpR?=
 =?utf-8?B?SnpMenVrUHhXajJuSWRXVy9CdXA5QVlGVWlLWm9iZmxBMUhTZHlxYjQrVTAv?=
 =?utf-8?B?TkhOOTJLcHhaTFdwRzZzRGxoT1UzRkJtZXZtdk1MdktVZ1FUZEpSZk1GbVo0?=
 =?utf-8?B?YTkxUy9hSGZ3NjlrbGVrenA3TmNyRk9tOGNwQXdsR2s1a3BSSDNxK2xvMkNS?=
 =?utf-8?B?bUVpZGNuNlJPZWdob1F2VnRoNFRZYUdOVHMwNEhtTkk5Y1NVVFdWa25NRExn?=
 =?utf-8?B?Q2lkNkxDQ3cxL3lIL2lsa2xOU1ExSWNDdndQelZyZFppSmJQZzZwaGxKQVhE?=
 =?utf-8?B?Qkw3WEc0MzFHcVpuSytzdFhlQ1krcGhuVkIvL2ZHTCtrSXBYbE5rUkJtbzQ5?=
 =?utf-8?B?dWNuQ1VrVnJCcjlDdjZ1V2hGS1hxb0hBSE9NdDNGd3dkTXdwN0VyMkEwa3Ju?=
 =?utf-8?B?RTB4SXh2R3ZTN2NUR2dJdkdrNFNZdTBpb3l3czhqU0hvQjlQSVhVQWs3ejZ0?=
 =?utf-8?B?bCt3VkpuaEVEL1IyaGxDdllHN0dubXR0RCtvQnlwVGc0bDJtZ29KUVVvcVNt?=
 =?utf-8?B?bElyU0JCQUxJZ1NleUNMU3JJNUhsVm9PclQvYlpHelB1dHZvU2lSWEtINURW?=
 =?utf-8?B?OUJ0SGI0VkxnSW8xMjZOSUViSzdQWHI0a0d0SWhYeEIzVTdhaDVkV09IR2Zt?=
 =?utf-8?B?WDl1b2VvbFgwdVhydThXWWZrelZJdE1PN1lVMWswT3o1Q2h0TEJkdGFlVzdm?=
 =?utf-8?B?Ukg2c2drZjJIUTVuUTkzRFM3Y0VZTlB3VWFUZDV3SjFaYXVFcU5keFNQU1ps?=
 =?utf-8?B?NmNLY0pOSStXekV3SjdDOGxoN0Nod04yeHJsenhseWJ2eTNBZ29JbGFMenBD?=
 =?utf-8?B?WU5PVXNXUkEzRVNETEdseVV0c0lnYmI5ZUwzdUtES0VHTEMySlFvWDAwWUtF?=
 =?utf-8?B?cUtoTkVHOGF5bitsMkxUZVV1UnhjSDhJZVI0ZWFaRVhWdVoxc0ZuYjFWbnhv?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108b590b-f7fc-4773-a86e-08dc9c2c316f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 13:21:20.3719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8G0wfZl6q7ccqnuhThBY+4gwyUsuCOVsJh/gwJhatCDvyUjHxaOjAYmQhIDLW0gG3hzOeAbQEm+NLsqDtrpJPsZSXb4nO2GCXU3OGj37VWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10422

This patchset addresses several S32G2/S32G3 SoC based boards
uSDHC controller particularities such as:
- GPIO card detect wake mechanism is not available
- Changing the pinctrl state in suspend routine is not supported

It also fixes a clocking usage issue on 'clk_get_rate',
in case of 'per' clock.

Ciprian Costea (4):
  mmc: sdhci-esdhc-imx: disable card detect wake for S32G based
    platforms
  mmc: sdhci-esdhc-imx: obtain the 'per' clock rate after its enablement
  mmc: sdhci-esdhc-imx: add option to not change pinctrl state in
    suspend
  MAINTAINERS: add 's32@nxp.com' as relevant mailing list for
    'sdhci-esdhc-imx' driver

 MAINTAINERS                        |  1 +
 drivers/mmc/host/sdhci-esdhc-imx.c | 28 ++++++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

-- 
2.45.2


