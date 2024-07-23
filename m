Return-Path: <linux-kernel+bounces-259854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2F2939E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DED31C21D81
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767BA14D43E;
	Tue, 23 Jul 2024 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JE1Jp5wa"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013018.outbound.protection.outlook.com [52.101.67.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7385F22097;
	Tue, 23 Jul 2024 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721728292; cv=fail; b=Xa81hcm3YR55d/PyVjeYoqPoehDRc8L4l49aEe+h3YtCF6HmbrL8u/HI9Uy26Lk04nPycvUtq/FIkZK42MJ0qSN53lec5CsKg/jxNtH8ovJsfVu3u/sL6R/zPcqVhDKgpg2ci0etILtpSmQjieE0CCwG6cCsk0XzdeFcmvmIiXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721728292; c=relaxed/simple;
	bh=wkAL+d08vqq6PhoFaZ1vCfZ4QfKq7sgpeCzfYJqMLMQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K3L4ztWjftJx6xM49bcaZ4gDG1H1YlRXMkXjT7TM/V1sl4V9bhuiPztfP73ZrH/H+t+RSfo+z2CKO7Z0BcyKK7T/oi/WizMD8ODSKIt2hBRqw7VfN+4cHEXdZPvVlAFzE7Zw4eWxwII4dF2iwXONVsDZT3KC2etCeuZZjcf2En8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JE1Jp5wa; arc=fail smtp.client-ip=52.101.67.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+wtBnn2Q5S9kQaq70t8IGH+JGu2UzI1nlv8UGrL6RidqBKtrD/oE2jCvWxSCqUKs7lrWh8k9l/V85Yii7hsVGMdeuh7bQ/gGxSseTeVuiHX3/JCyWN5rs9XNezTqDefKFyTvfJPHyOJdg2hLIjrdaELAZut9yvOIvwkwbS864xLdexyQbjKnFK0F7Dn3uqdo01HDep0CuCACNi9nHDgxawYnyb8l6BMlvweyEmYGX320/mx+HPNVV5N3i06tRXFCU7bX5iRWlQ+KSvYJhIGAuN8MEH52KCg8uQgIXECcCplDvhV0mIr/UXLp6ImwXSgeLH3FUjY0p2Ecx7mYQVFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPjPrAl6zfwWXhOl8ue9Oot/8GJ+3AtBbAVusWv5lCI=;
 b=O6eUx/VEHpZkdMORFQC5FWyF7CghFo3uVm+LyosBMeKW8Y0oMwc8RXFCmXDsmmV/Al/GMEEI4xfFcmo4h2j28emAHUSkeA1nqbX1BR7KUX72ni2G4Td0WG9gd55qKRGCPioha/W4rkQ5bMDwUli2+GL/sRROI+ighdwvJr7tywzI/aqEr0/KJSWfmhpkKhC9PpRjWTfeE518WX72XYPC3a6GPuTGjBk9bcBMc7+sFlooADmnaZeTUXmcEbU9C3d9/KWJ0I62U98ZPYFm8M6IRNdsMVg6XiafPBVV1OeXXKdbPZTdXVzabpLLM/gMxXm6+1HaXpuXqd1H8fpNfZiM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPjPrAl6zfwWXhOl8ue9Oot/8GJ+3AtBbAVusWv5lCI=;
 b=JE1Jp5waJyC5ctR1Wfx4jZTUiMJgtaGJ0eD4WIlCie9SDbLde5lkIaMQFwW6BUx7+paxqp87c/WfxPcpuoUDsGeRmnoS2TUIS/JTkbQBYhe+pVdqHwK04y6Y4QbhtBJ+3tOmIsK1SoZ5e/ITvxstmOoqSMOaEXNGQRkG+jIaWGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by GVXPR04MB9830.eurprd04.prod.outlook.com (2603:10a6:150:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 09:51:27 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%2]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 09:51:26 +0000
Message-ID: <963879e7-f45d-4d34-8fc6-643333a8d24e@nxp.com>
Date: Tue, 23 Jul 2024 17:51:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] dt-bindings: display: imx: Add i.MX8qxp Display
 Controller display engine
To: Rob Herring <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 tglx@linutronix.de, vkoul@kernel.org, kishon@kernel.org,
 aisheng.dong@nxp.com, agx@sigxcpu.org, francesco@dolcini.it, frank.li@nxp.com
References: <20240712093243.2108456-1-victor.liu@nxp.com>
 <20240712093243.2108456-3-victor.liu@nxp.com>
 <20240722225708.GB183822-robh@kernel.org>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20240722225708.GB183822-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|GVXPR04MB9830:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d4e56b-ca9b-4771-02c9-08dcaafd050a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a20zVmRNakNrZGthM1VPYVd1enpydzU2aVlyc2VHN1pCRWRiZkxoSGJBN09n?=
 =?utf-8?B?NUUxTlZpZmMvOCtIOTFVdU5wODJqQ3pETis5THJLaEkzbUh6ZWZlaU1QZmxp?=
 =?utf-8?B?anBnU0IrUWxId0xuYzNOenpLWFRVa0J6YXB6OVprV0dqcFdXdFYzTnZ3ZHgz?=
 =?utf-8?B?T2VFSWE2NXlDR1dBalZvcHJHTS9WMWdrRmlTa091OFlZaEdveXpmN2RiUXdZ?=
 =?utf-8?B?YVdRSy9haFdPV21ycHhBTEdUQ1NScDV6SkZqVDJWUkQzc1dSYXNoN29FUWVa?=
 =?utf-8?B?K0FkUWQvdUVnZW53c2F0Ukx3RnJ1ZzVGYWZTS3Y2VDRzZmdoMUE4cUE3MFpO?=
 =?utf-8?B?aWZ6M1U4eWhmOExqSUZFUjhsd1FoYUJYSHAwUzh0UG1hWVZZaUNzUW1USVZl?=
 =?utf-8?B?aGI1OEF4S2ZJM1cyRlV1YzhTVDZnOEIrcGVTaDRmWGkwMzdoSGRhdEd1SFN0?=
 =?utf-8?B?ZkJoMjhjKy9DUmd6WFV2dUNGeXludTBZaGJvZElteElnZWliVjR1L3FHejVQ?=
 =?utf-8?B?UCtzRGM1ODJCVDhtdmtzcHE5bVY3MG42cmk1SGZBSW1Xc0thSEcwYWFhQ1Ni?=
 =?utf-8?B?d1dEdm9Zc3FKL2gxWGhxOVZDUklWVlp0WmNVZzRNN0g3K1FaejFmVnFDc3NV?=
 =?utf-8?B?L2tIN214K294TnF5WlQ1aVMxSis5NDZQQVhDZE9Zbks3S1REenhoTTFLdkY3?=
 =?utf-8?B?ODFFcDRPbmp5NmcrdFlhbHREZ2RZVkJpYTQrcW52Q25DMXgreVF5NmQyQ1Rt?=
 =?utf-8?B?YU1IR3F0RGhPN1BxY29xdUkzUWdRZ3VPS1ludkxWWCtiZ1RqNFVBM2p3RFpN?=
 =?utf-8?B?WFpXV1FKQ0E2bXE0Z0NWcHVJcVhTSzRtWTdwbGNaQzl5VWJFRUUzRkNqNk9I?=
 =?utf-8?B?U0VlVHo4TXFEZm4rRGp1ZUdndUN3djgyQWdlYVlMWG82T2doQTByR0ZHYzdI?=
 =?utf-8?B?dW1FejBYdnlKczB2OWdMV1pZTTdmWS95SkJZemRiV2gwR24vTzVBb3dFUytm?=
 =?utf-8?B?dG01T1lyMGtoVU8yNUVVN0Z5a2ZyZjluWVg3dGFNemN3TjcwLzM3SHVERnh6?=
 =?utf-8?B?NXZ3Y0U2QytzYXp2cmRKSUtiQnpDU2d1Mm8zYUpaQW5IQ0tjR24xT1NOQko1?=
 =?utf-8?B?NzF3b1dzNVlJQy9vY0ZjMGtjZUd1MGROb094UVBUdXM4ZVI3YmFtYlVRdFJN?=
 =?utf-8?B?blB5Q0drTDBXVFBKVTV0Y1NEaGl1Uytub1UxY2JaZ3lSbmNDc1BaVEljRmNE?=
 =?utf-8?B?WHhLdVlQR1ZiZnVhdE00ODFPN09kYkFpS3I4K0Q5eHltQ1g2MVA4dnVnU1Vs?=
 =?utf-8?B?KzZrSW5oWCsrTU5xS0ZWTjhaeHpmbWFWbHArN1huUFQybzBMTW5KeFZ6bTdD?=
 =?utf-8?B?QXpBMGt2d1c3YkV6YlQ5YlZtWFpBNXZaVFk2RVA0TnBKSExRSDJPRkVzcldC?=
 =?utf-8?B?bGkybVpRLzQ0azV4N1BvMnNGU3RMTnFIMHp5VmI2djNLeTduUytHSk9qTXZQ?=
 =?utf-8?B?MjNxWXNJdmpITW01dlVBblgyTjBkR3FTV1IycUR2cC9xbG1pR213Rkd5SkNO?=
 =?utf-8?B?U0o5d2wyREQzdFlHRit5Y0VGVE1aSFJjYXFWZUNBYTdndEtDOFRNa1lWNFN3?=
 =?utf-8?B?RHoxMnF1RWdEemxLUHJDTUpVdE0venNaVWpYQU9MbTVuQTQraUwrTFh6VTdG?=
 =?utf-8?B?dUZzZ1QxNWNyV2wzdzdKT1Nsc1pVd3NhTjI3MzlGS1I5NUh4Qmt3MnlMdlZJ?=
 =?utf-8?Q?dZPEnvx4HCEQvjdffU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzFzeEg3R29aZWJyK3hEeDlndlMwcGlibDF6Q1FrdmR3cndERTQ4Si9SK2Ny?=
 =?utf-8?B?NjVnMEplUE5PVytGc3h3bWl3clMraDVXeSt4bEFad0VzRFdLRlBuYTBnQ0xB?=
 =?utf-8?B?UytPUHNVaDdmUktUTFBrZ3o1c3U1elp1TitDNkcwNzJBWVZkVHE2SnZFaVg4?=
 =?utf-8?B?VlVQQ3BRM2d5V2MyRVl0Snd2RkVwT2VqK0llK2FkSDBCWHFObkpWM3FJWW9W?=
 =?utf-8?B?WU1ERi9JVVdFSDdyQkZ5M2RabWVVVWVPSmlOcGUyOUlwait2K2FhMTByQmRz?=
 =?utf-8?B?eitEM2NZN3ZVQnZnUlJtblFMbE9ER1NGbjd0NkQ4QVYyMzd1Y1RveldYelhK?=
 =?utf-8?B?bUVvTW1EWDlSSmU1ZGtoVkJOdVU1bEFmRG5iQi8wZjltbjVDSk9SZnNPOStT?=
 =?utf-8?B?bCtTdktkSDExRjh0cXNCdDJFQlR6VWZXWDduRnhMZnNaeWR5cS8rK1RzWEUz?=
 =?utf-8?B?VUdmTDdHTFVtQnZGZzdYcU5PR2VoWHNwTzdGVG9UWFIxbUlpajZJN1ZSVUh4?=
 =?utf-8?B?eEhMZXhhOWFGYzdBbDVYajk3Z0w3d1B5eEZkcDEzbUFqaGFZVjduMXptY0hk?=
 =?utf-8?B?KzhxY0RMMUJUK0t6R3dyWk9kUFlVdlQ0QnJyRjluSHgvYm1GbGgyYm9vNEwy?=
 =?utf-8?B?Z0ZZV1pPTTJNVnhNK3haMHBhN3QvUDlydkF3d1FmcWl3TUJFdEtvZ3lBWG9u?=
 =?utf-8?B?SktsUkRJQzM1VzlGZzVEcElPRGxrRG5ERitpOUtPZFJWZ0ozcmMvTlRZdjZs?=
 =?utf-8?B?ZGp4K2RCWjNxNGoxQmx4WVVzc0VvblpicUFuWjJGUndLaWd5UU1jOGtibENt?=
 =?utf-8?B?SEwxV01PM3EwaEphRldRNlY1cXg0QUxoYUQ1eG83ZUxYV2ZyNFVwdmFJa3FR?=
 =?utf-8?B?b3lzQTIvMk82dTQwV0t0Z043anMrM1BGRlJpTkRmZlp0eHUxZjhReHk1bDF0?=
 =?utf-8?B?VXlnenh5dHVTV2lYNGNKeEV4TjY2c0p4T0pjdTdVdExYM2o3Yit2dXJnRklx?=
 =?utf-8?B?dGtSMUNqdnl1VHp3UGVPWGUwZWh5TlBEZU1KeC9BL2R0eUhiV1ZxcHZHS1JV?=
 =?utf-8?B?dU9raTZ1L3cxbjh1M0djSHNvK1grdHY2SVdvQkwwcmtQeW8xTmNRRXVzSkVu?=
 =?utf-8?B?QnFIZlVIMkFJZjE2WnNBSXhXYmtlZ20rMXdldFBpME43MGZEbDFtVG1UM3BH?=
 =?utf-8?B?UU9saU9JRjc5UEJ0MUx0UHIwOFljR1dEcHdtN0VwZUdNTG1IYjZkMnFseGZU?=
 =?utf-8?B?QTFFZ1dtVU1NcHErZC9tZUI0R3ZpSzRsOGF6TGl1OFhkNzhtNkJWa0l1VG1M?=
 =?utf-8?B?KzdwanViT3FqbmFTOTFWcHNEeTBTWXZBRkN3UmRXU1pFcXRQNloyVVdYdzcz?=
 =?utf-8?B?QWdjWWtsc01EMlB2bXRaVXFvOXRwNnEwT3hoZ09aL2hKYTlTQUZYN3J5N3Ft?=
 =?utf-8?B?WFlLVy9HaENndkVMbHB1M1pKWmd3YlVkS3BuZVRveTFXRTJTaEgzdmN6cnpL?=
 =?utf-8?B?RlZLTVJzWWF2TTBBSitkVDlMNTNvQ0YvUkhXcXdQS1dQbkdNTjM5V0ZndWhD?=
 =?utf-8?B?bDg1RnRYU1cwS2dob05ML2dzdEJrczZBMXRiRit0N1hsalliL3NTQWliVXVL?=
 =?utf-8?B?aWp2OS9UOCs2bXFxemZicTV6eitVTDdzZjZmYzJJZ2FTeVJMR2lHMDRoMFpk?=
 =?utf-8?B?YjAxbnBKVEZOUUo2cDA2cVQxSXRNNHAvSFBEWDJHT2Z4dFp6T1h1eWZ1ZVVX?=
 =?utf-8?B?MnYweEJmTDE2QXpISDJmY2pvTHhLaWRqWTg3VmIxbGRpVDFQRk9FRk8wUGU2?=
 =?utf-8?B?bWxpZnVrZG15RUpDdk9xSlBVY0Jlc0ZISjZvVkNxQXJRUUFMUXYvVk4rRU1l?=
 =?utf-8?B?ckhxa2ZhRXNtdDl0eGpSUVM5TU5weXJtZDRrM29CV29ZSkk2RTd3M3BkNTFS?=
 =?utf-8?B?S2NVV3duQm1xSDM2bmc5K3hTU0kwVzdhODNaUVAvWldvaEhEZUI5akpiblZp?=
 =?utf-8?B?UDlHME9DOG1WNFZpUXJ6UUM4dkJUTEVJb3ZBcnpINFN0OTJKZXFqSTZzbFZG?=
 =?utf-8?B?RloyejNveWZFaVdzMXdNNjdqNmZPQWhGN3lLd0lDSzZac3FsUDhuanpMMEd2?=
 =?utf-8?Q?tVBa84FRMFyLQI0v1TXpJpDNW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d4e56b-ca9b-4771-02c9-08dcaafd050a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:51:26.8835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWORN929iOQxhUnGDUUBC0hoD3XhwsPTSZxMJ030jIKsIfLqF4fWdft/avA6JRrEUJrz4NEyqpk1itIehUUVTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9830

On 07/23/2024, Rob Herring wrote:
> On Fri, Jul 12, 2024 at 05:32:29PM +0800, Liu Ying wrote:
>> i.MX8qxp Display Controller display engine consists of all processing units
>> that operate in a display clock domain.
>>
>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>> ---
>> v2:
>> * Drop fsl,dc-*-id DT properties. (Krzysztof)
>> * Drop port property. (Krzysztof)
>> * Fix register range sizes in example.
>>
>>  .../imx/fsl,imx8qxp-dc-display-engine.yaml    | 152 ++++++++++++++++++
>>  1 file changed, 152 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-display-engine.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-display-engine.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-display-engine.yaml
>> new file mode 100644
>> index 000000000000..91f3bb77d8d0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-display-engine.yaml
>> @@ -0,0 +1,152 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/imx/fsl,imx8qxp-dc-display-engine.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Freescale i.MX8qxp Display Controller Display Engine
>> +
>> +description:
>> +  All Processing Units that operate in a display clock domain. Pixel pipeline
>> +  is driven by a video timing and cannot be stalled. Implements all display
>> +  specific processing.
>> +
>> +maintainers:
>> +  - Liu Ying <victor.liu@nxp.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: fsl,imx8qxp-dc-display-engine
>> +
>> +  reg:
>> +    maxItems: 2
>> +
>> +  reg-names:
>> +    items:
>> +      - const: top
>> +      - const: cfg
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 3
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: shdload
>> +      - const: framecomplete
>> +      - const: seqcomplete
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 1
>> +
>> +  ranges: true
>> +
>> +patternProperties:
>> +  "^dither@[0-9a-f]+$":
>> +    type: object
>> +    additionalProperties: true
>> +
>> +    properties:
>> +      compatible:
>> +        const: fsl,imx8qxp-dc-dither
> 
> Doesn't look like this and some other compatibles are fully documented. 
> They need to be.

Will document all processing units, command sequencer, axi performance
counter and blit engine in v3 if no objections.

> 
> Rob

-- 
Regards,
Liu Ying


