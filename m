Return-Path: <linux-kernel+bounces-380414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3143E9AEE1C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C511C21A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED211F9ED6;
	Thu, 24 Oct 2024 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="Qtm9G31K"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB01EB3D;
	Thu, 24 Oct 2024 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791111; cv=fail; b=GrCx84Zf01qljIzlOdQloOu0zrYeC7eYE90gub4FNmp7jM/WaL8t/JsrW6PF52XpH5cpi2Vt2EYCmm/1k2uwCG02cAJOLyIXl/fsUbxZ2s0EJDJjWUryhuwpDjPJB1ZDa4L5sbfe7Z3BPRE8ol4Z+YO6F3RKjrGjGI89HdI+Uq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791111; c=relaxed/simple;
	bh=hfewqWn37rl4buA5iz563EKqW+eSOwTTBKcePELMYFM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hDXZP8wbHZJjH/DnJ1qYKFEWY0q61/BK5J6+Gi12s57OEJkjCrkn0iPxwCDvr2IYy9TFWG/4DlkC6r0U5Iu6FTxHwcpISuY61CQLdQ0sUdoInqpLk/a9I5ANHRZOHLdLBRwyZn0USFUIzMavE8k1kLu1MLh9o0cjjKsehWPKy+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=Qtm9G31K; arc=fail smtp.client-ip=40.107.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWMDyjRDM7nhRULEmVb9UxUVIu1pzQQmHRskW1MPiwqYI5Qoy5DdePx+ZTpaRrHfK0ZNScgpoqnN5Dy9e9Oz+MbyJhktgJuYzzjYlAxikY4aOAIwj0YW12DBGuCqLtHi/l27EVNyRbuN6HrlK5ukANI4nujS5kvYc1T1kRM9lM2fgsrCK0yqihnN5Vti8G0dhQCd8C1NvJBHoZHni78PMi+mZ9uuNXIfLDYnZLMAXwrcTbbKC+ViHW3ou39C8Ln2DpAW2+VRQluB3mInUZZj19GE6tvO+7QMjFmsFSap9Hl63dbeekfix7d59/F9BJXB1A5ALkILp8Zj7QMnJCZNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFi9Cn0P9kehzvP5Jhh8bw+eATSPhczTLW33WmZA8QE=;
 b=nnbbUL0yHoSg1EdQs/iYx6r1yg2H1oXCdaw4dKnUo6t1DAXTV5AucAFuMOUGkm7TPgM1sAZWaFG3fwEs9WFWgmfSABrfdV+CyAOuwy9aeK7sC/bV0rHfo4OeGlQ6p/ueBGIMZFcWi7KGmZxDmrX+5joCcNuG9wm0+SSK/v9+yu9jy4ujsZuLDLs8NxW5L2Btlub1ToJmTMAeht88AFtknxpotg+Xc41ph8VO0Dh8iTw0h6DcT2W5WjbipGnfU5hnIo72IbCuhfnMa1v2GVb18fFnNmfYjMPyhDBdGuYULnMLFfGOQ4IKdB2C6drjgnxRh9xJ85nnySTrcmttchVnMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFi9Cn0P9kehzvP5Jhh8bw+eATSPhczTLW33WmZA8QE=;
 b=Qtm9G31KqyLYyZ9ZMn5ots9m3FX6TsvSh5HUqphdCwUVjVItSXE6uZEcX40W0fy1xe7yXDP+7LRPS3DG3tjiw9uNSskUW+YrDBJR8LjGpFjeA4dRwMEfG1JPrFMKZhgvR6/akhXt1lCTqKcXmmS+XzrnU/QPTOvzV0CEzhUw8VU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS1PR04MB9334.eurprd04.prod.outlook.com (2603:10a6:20b:4de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Thu, 24 Oct
 2024 17:31:45 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 17:31:45 +0000
Message-ID: <6ea01da5-076d-4714-a45c-6c7407b00214@cherry.de>
Date: Thu, 24 Oct 2024 19:31:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: rockchip: add HDMI support to
 rk3588-tiger-haikou
To: Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20241024151403.1748554-1-heiko@sntech.de>
 <20241024151403.1748554-3-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241024151403.1748554-3-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0286.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS1PR04MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c121d2-6bca-4fe7-79c2-08dcf451bb3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjllQnQxTzZpaUZDeEdud216enNOOWVISXZTbitZYlZUOG5PeUlodm1BSWlH?=
 =?utf-8?B?YmpZclU4NDc5Rlg3UXI5aloxRTBYd1k2dVdWWHBJWFVYYS8yL1BlSVlzeE5y?=
 =?utf-8?B?ejJhZXlRU3dYWndYNTdZRWlyWTNUM1c1ZE1FbDJxTHNFMkhqWWRCWU9kMFhs?=
 =?utf-8?B?RUR0Nk5aVk9pcmRSMlhzaVUwNnptN2x1dXpJSkRFdklOMlpwOFFVS2hrRGZy?=
 =?utf-8?B?ZFFXbjI3S0swa0Jpdk4vQ1ErUklPaFV0MWtleWNKY3BWSit1YzdPNU1KZFdX?=
 =?utf-8?B?SzQ4c2hlQjRXaEpLQnJ4VkZWcTc4eTFzbnFTYzMwN09rUEFyL3NxalpFWTZh?=
 =?utf-8?B?N1pGY0NlWHpBUEdrdTZ2UEZPVnF0eWlIb1N0bitOcjlDSk1Gb2ZxTGdDeWMy?=
 =?utf-8?B?aHJEZXNVNGlabmUxcTl0SFRYb2V4NDVON0E1M1VVT3YwNnVOU1BHUjdhM3dw?=
 =?utf-8?B?VUp3elZiV0RrVUlxSVZTTFVsemcwSHp4SCtpcnMxRlVuWDRCZW1FY2NuTlpu?=
 =?utf-8?B?TUE0Z29VMjZMMGU4MlpmT3VXNWJvRkk0YkxkOGtGOU9hRWE0ZW5HcWdLUUdO?=
 =?utf-8?B?TVRZbVVpU3MrQ3FnMmIvdytaYjhNbitXM2MrbjJjZ1JjdlE4NndnR2tWVmVX?=
 =?utf-8?B?YXE5bmg5dTVYQ3VsY2c0OXFqVFFtbzlvN0JTUXhacDFWVHFLd2tDQXhmSzBJ?=
 =?utf-8?B?YWxteEZvL2huNU43SEVhS09UTHJTeHRyd3FORDUxckNxMEFsYW96WDZZdk1u?=
 =?utf-8?B?T0lsSUd1UVI5bVdGRklNM2JGNW5RV2RUaG9QNEhzY1ZKUC9DK0IwTGNEcWpi?=
 =?utf-8?B?eEpMVHhDM3lGTmdXMEYzd3dSR3ZqcWl3TU80dEg2ZGN3REdSakJRL2VBWWll?=
 =?utf-8?B?NEdZVE5QU1pseU5DUHpPK3RWSXFRVWZQMUs2Q3d4OFNKbW5GODY3ZHFud1RP?=
 =?utf-8?B?MERrMnptcHFTMXpyUmZsVmNsL0p5TmxGbDJGclEyaDlVUk1MUWl5djcrakZD?=
 =?utf-8?B?U1lHUTFrVHpua0hoSXQ2L0tjVE8yeEJ2a1UrcUdqNW5mRVp1T3kyMDNxck43?=
 =?utf-8?B?cUN4cndEVHNmdTNlcThrS3IyaWJScVh4OGlnZmlQK1lYQmg0Z2lCZkV0VVhj?=
 =?utf-8?B?ZTUrR1R0dTdBZG1pT21ITWgraEpuSlZ1dkpxUEJsSU9GeE5PUGNHV1RyMWxa?=
 =?utf-8?B?eXAxeFZXUnJrZTFTbmx3MitIclJLSFYzQjVLaEpkMGF1blo3ZzdzRnZXN3dr?=
 =?utf-8?B?RVoxS2x1cndqd0EwL0szTHFlY3JETmxFQTI1dWU1UHN1RFJWM2EyM2s2eDl5?=
 =?utf-8?B?eVFJSjZPeDRZczNHYVhVNFNIMmFyTDgvbHZXVUtjaEtTWXIyTklFc0xBaGIy?=
 =?utf-8?B?NHFPUXRPeHhWdGVKY3QvdXE3cklCRmc3ZEl1R0lGQlAwUUZHOE1RVVBoNis0?=
 =?utf-8?B?OUo3ZU9PQnJ1MjRiVVp5RVJLQXNTSmNDck5ZMEpNMmsrN1Q2UnhXVUtpMUta?=
 =?utf-8?B?bVQyRkxSbHB0RWxEcUMyWnlXOVFub0IzaE0wU1A3eHJkODNXaVdmbWx0MFhu?=
 =?utf-8?B?OHFHL3N5NDU4bWF0dXpqVlNHYlFVQmM1TlBxMzd3TDBmS1UxTUd6dnJSMGtW?=
 =?utf-8?B?TVAvVFdibEFMeGhESVUrKzhLU1NTbU9TYXhzL05UeFNGMmJ6VVRXN3VXYndU?=
 =?utf-8?Q?0lQpKLVXSCPYiJpSRC2K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0N1dkhsVDdKNnBjQlJRWXd1STd0UVYwN0dtQTMvSitrbXowVXVWVHJjQ1JN?=
 =?utf-8?B?aFFSekxKREtaWFRxRzdYWWpROXZkOHRSWWNYeDVCK1V5V05HeTYxTDdQVVRI?=
 =?utf-8?B?MmJiVjQ5em5VREk5YTRJOE5XNWZ1QWs0NHlIRXhsTWpMNUl1bEloMitYZnRP?=
 =?utf-8?B?YUVSLzY2ZVNRc3YzZ2s0c2txZDR3NHdrUHROZTlTTDZSckZaWk5EdkdwbUxP?=
 =?utf-8?B?MXowcDlaL3FqOWllaVZuZHFBb21NcGtBTmxubDEzc0tqdTlrb2RXQ3hRam1W?=
 =?utf-8?B?a3VlQmFmWElOWDNvSXZqcG1tKzRsMHlnN3NjVjNUcFRRSDFIQmpieXdjMW1E?=
 =?utf-8?B?M0lYU3hJd3EvKzFVMkhRNm1lNUFZSFZvdzlNbmRyQ2J1YUJuY1FwN0ZwYlU5?=
 =?utf-8?B?eis2Zmd2U2ZIQ3Z4cUVWR3c0VEpxeXVxbjNxMFVDd3pvaEdhaVBIczZob2VJ?=
 =?utf-8?B?RUVLQ0hOcHhHMm1yTnhnVHNEdTVzcHZOM1l3QUQ3UG1JQUZ0YTVUY2U3c0pY?=
 =?utf-8?B?T0xaSFUvVjdNa2hGSk9XSzlOR0lVNmRUZEszbm1mcndMVmc1MWZJeWowa2tr?=
 =?utf-8?B?cWhuZTQ4b3BOZXIwbmF3NWExMTZzVzNpR2RRT3Y1VWdFOHV6Rk9rQjg5SElJ?=
 =?utf-8?B?UGpIZFpseW1RRENvQmxVbXFZTllCNm1IZEkwRVFlc1c4am10bXk1Z3ZpSnIr?=
 =?utf-8?B?bHdBMWNveXFGVVZEMEJxbGhHS1VWQmR4ci9XZ0g2amJtMGQ5NzNTdkxwUWJx?=
 =?utf-8?B?SXJuZVpoazNmODFKY2g1VWNQcEpERW1uL2VtRUR3d0duanVRNWduTldYdTNn?=
 =?utf-8?B?QjBNdllrZ2FIUzNwNWE0T3NrdHFRaUVIbHNFQ0hlSW9FT0xqZXRhM0VJZjdk?=
 =?utf-8?B?SGdYR2ord2R5anBwZ0ppZGx6YlRia0JNVkE4cVp4L21pUW9JVGJ6NWxYVlN4?=
 =?utf-8?B?eE9mbnlYUmFlQ3dtN3NDRGd4R29YY2xGU2R4YkJSTE8xbUg1bmtlWDRJK1d2?=
 =?utf-8?B?NGQyc0dvb0F1ZkxHK3BlZFpzWnEwSkMreXNiNkVIN1I4K2JlOVRPSVpxb0JX?=
 =?utf-8?B?bVJ3K3ZtKzhGcE9qb1ZrU2M2dkJvVXhFZzUvYVVJYXZud0p1MU9nbG5pK0Zi?=
 =?utf-8?B?cXpXd0RpQVBWVi9RUzFGeGFJdmpvUy85UVJ2L2JibVNyUXM3WlM2bkpSMlVT?=
 =?utf-8?B?UlJyOGJ6OFR4eUVSNkRoS1ZnVjY3OWNHWTR3Y1dOYXJpMGR2Qjc3TEdOQmlw?=
 =?utf-8?B?amwwM1I3ejBia0pHa3UwcXJYc3ZTbXkxZFd4aGNQRURteTI2TXNoODQ3TWtl?=
 =?utf-8?B?RHZpdmdxeWZIV3pDUmxjdmNUSXFkSXNQZGJ0ajQrcWRNL0xQdEpyS0VJYms0?=
 =?utf-8?B?NFIxR2s4WEUvRVNLL1NVbmRrSnQyWXJqMHhmQ1MyRnF1aXZ0TGhWQ1AxZGNh?=
 =?utf-8?B?N1RMYlpXRFJ1aCtOZ2FKcU1qd2VxRFpUTStDZzkvazBOQ0o1SDlLQi9VclVx?=
 =?utf-8?B?SlFlTTFxemZlajBJOXN6UENUWjhuM256NEpjWWpJNVpjVnM5ams1eUlnek1x?=
 =?utf-8?B?TVhrV3RsSGNIMmQ4eTE4QXVFUFUxUytJREJtV0hPaGttQ1FSbkYyc25ZWnVo?=
 =?utf-8?B?cERJZEZXQkNtb3o5UVcvS2NrZDV5VFMvV2xldjJqU2tGd0JNWC9wTVp5MTUv?=
 =?utf-8?B?ZElzcWdVWm0wTlZ6QnFtM20yaGJBcWJ1SnRzcG44cERmTXF6N3RMa0Zjbk5R?=
 =?utf-8?B?WUFZaVAySUdxVFNISGF0U09jN3J3dlV6ZWkxcUJVRm5SbW5tMVl2L24yRUpB?=
 =?utf-8?B?V0lhNUhCbEMzbVMzSmZ4dzVROTRkdjIyalNhNllJaDZBQndyeDgzR2d0dkJl?=
 =?utf-8?B?SlZzdWJEMEgzcHlWZDkxUjhFRlEzTWlDSE5uemMxMzJiRjI2NFJyTWFOZHVy?=
 =?utf-8?B?SWY3K1J2dWJWTUdXVGh5bkw1Z1RFNUdCRkp1M1I4a1VXaFJwVWN5anVJanRB?=
 =?utf-8?B?OXlDVHdQU01OTTAyaGUvUCtvY3dpdU5EdWtwQlFzelNsTVVSM1JENDZCWVdt?=
 =?utf-8?B?R21WVnVDOEZGOXJtUmpWSjdTcklXUFNLUVJLbFg5Ym5tQzduNkZrc2tRY3dj?=
 =?utf-8?B?V0dNWXpaRFF1aksyd0lsSmU4ZlEvWUJhVGZJVFFwREhKYlN0OTU0N29SbFlV?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c121d2-6bca-4fe7-79c2-08dcf451bb3e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 17:31:45.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9xkVgPV0thFSlJmQMPPr7T1FpjfVMHE/spWV/uZIbCXpg5EMQ2pbNOpPbwai6BzwF8jTGvzBD9wbXt5PMYnbNIQhc1/XSWDiIs+4b6oGWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9334

Hi Heiko,

On 10/24/24 5:14 PM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The Haikou baseboard has an hdmi output port, which is connected
> via the Q7 connector to the hdmi0 controller of the rk3588.
> 
> Add the necessary plumbing to enable it using the recently merged
> hdmi-qp controller.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

I have this Chinese portable HDMI display[1] which doesn't print 
anything at boot but works with modetest. Same behavior can be observed 
on downstream, maybe we can get some people interested in debugging this 
now that it also impacts upstream :)

With a decent, FHD, monitor everything is fine so:

Tested-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

[1] https://www.amazon.de/dp/B0CKYR6FN5

