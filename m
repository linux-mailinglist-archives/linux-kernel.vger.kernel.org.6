Return-Path: <linux-kernel+bounces-538826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FB6A49D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3114D7A3C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D822E81724;
	Fri, 28 Feb 2025 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="HUM7ZBGD"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013063.outbound.protection.outlook.com [52.101.67.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CE04A07;
	Fri, 28 Feb 2025 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756693; cv=fail; b=ak+NIXgCCEe7CR8h3fmXNAoHlso82NsOF6vwtanNWALNHryYkTgA6UXSRZHKKaj28ZbX5n7UeLOCuZn9hXomFGV4vyGlBJrb1Hom2tnxhQnFywfb7zt5m0H/7Bsx6t/ngzDPCiXKcT5zmiUdMnND1teFG0KAle8w4pUjqMzMfI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756693; c=relaxed/simple;
	bh=Gr2JPxCci7Uik6VwD0GGUWZ6uov29xkAUFIvkxRpiS8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NZFoAO4zVnpCtIC19kogNoMYLbPfzuE8HMmEX71roB86rFE9UXilGhkm0Jwo/Lypa4loLv+mAJ8SK0VnnzRv0NLg9QF/ua/Ria/ESINbT/NdN97vwoGwR1XJZWMKoXKRKtli13EAga1iGwO/TT9EDY+GEI4jLLILvA8hDx3IQMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=HUM7ZBGD; arc=fail smtp.client-ip=52.101.67.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhzxLOl4HOVO0zhry4UODPOpiLONBUH8Ty3z3ofJtQFRocHpOAhSezz3pVynfjNqm5H4kW/EUn2FV36DFw2uY8ffQvn/Z2f06k6OK21KZJKht5WfymulUtyRwpWdVHA+mdLCp6eI3056dnKaU82uFLwrl9Agd6LeEzVUknodmy1vCLg4bR+nSgdx/BRCIc+ihID3ABVtIBwhn7G53B6G5uD029/32+u5sdnK+DXDKi0teYO9/uHZGN4iuJc87Gf6wnhhbrLFlhVi/CoZVkU5n1NBD1K4dI14Hp2ry1hKg75x5t9ZQ6i2Ntc/qFTGTGh+xZEVw7hWne3+3lC2tHPDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeXL6NbCujU/VIBDRPcf7aMcGEY88x5uiWAKVGDSbTI=;
 b=gUTnkrKlKbRdPTPaqJMplayDtJaLy/YNpRPknyguTrESTX3BG+7PB32llSZMLevey01Y0TW12283JQnuCo+iXb1lAHCGDaj1SuQxF2ma8+TbE8BllxU8n7WemixgjPr2hAKLk62ijnvmLmB3G0kUHawjSDzbP+JkmhMFT9vNXuSuZdbtI3IDsuo7z5W/3460M1WB5ZLlMbMG3fLrvDwbLxja1IbXXD4yK+draEumocyLJkXekWRHsJS8QbnbQIQGxNPCL4peeLz/mYAyiN66vmiBB40B94VEFk0lkqULdA5l3Zx+bxl5ZFhz2IFVh834O0Y1LQNMqQEE0wyRCftJbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeXL6NbCujU/VIBDRPcf7aMcGEY88x5uiWAKVGDSbTI=;
 b=HUM7ZBGDGLLis8mIicGF4Qwz89+R2jfvHt4f19uHAhM6GSW1hPVd2RrnkzY1GzBInksZI5igif2V+qY4ABetl+EFYM3lz6+dgrWJSRbzounsPbKvKVqAYmA10WY69vSvVoXmxoofCU7D9BKGgFvSd7JSya1Ek/uo/2iYHdGwu2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PR3PR04MB7450.eurprd04.prod.outlook.com (2603:10a6:102:8a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Fri, 28 Feb
 2025 15:31:27 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:31:26 +0000
Message-ID: <c44c06ef-8a21-4e2f-9230-f30cea024baf@cherry.de>
Date: Fri, 28 Feb 2025 16:31:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: dts: rockchip: add usb typec host support to
 rk3588-jaguar
To: Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 dse@thaumatec.com, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20250228150853.329175-1-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250228150853.329175-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0000452C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::352) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PR3PR04MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9d2719-c2de-473e-033e-08dd580cf738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGN6d2pUdkVVQzl1TUhKbjI0cU9lZ0JLRXRXK3pHWG1JTjZoVFZUZC9Ea0tP?=
 =?utf-8?B?UjVsaUVUVjFTeGlpNll4RjRVVlJCaVdGNW5lRjdDSDgwM2U5OGh0VngvVCtu?=
 =?utf-8?B?d1Q5azZoU2ZHb1FKR0hLWjRQd0ljRHBWN0FSSDBMaVZCWDRtNjlKTmIxZ01y?=
 =?utf-8?B?bU5RTHJTN0ZCMnBIYktMeXdBWk40SWQvLzVBa0xpRXNjNzlRdExFMFNzeDVM?=
 =?utf-8?B?OExlWUpYd3JDemVuYWdxRlVMQWM1c3h4SHRRbS9qMFcwWTh5UCtLaGhDdEhS?=
 =?utf-8?B?VzFrQ0pWUVhDamdscng5aWRONmlXUTFrZExxeks2c1NGNHBYOGNOYk1ORU9U?=
 =?utf-8?B?UjVVS2U2UHhhK2k4cHdlMER0L294bk1DTnJRRlJ4WXp5T0VmOFlMMnQ0dkNp?=
 =?utf-8?B?alQrRGt0aUoxa2ZBR1dLMndQS0lyM3gzdUlNZGJlL0tBeGdXTFJzOFl0ME5I?=
 =?utf-8?B?N0NPOVBVQ21EMTNQelpoTEY2aGZ0VGdTQmx4NUxNYzdDRkFTVldPMWFFbGVu?=
 =?utf-8?B?K2Y0bGJtcEwxc3ZyVmF1aWxxNUhYdFcwcW9pN1lHSTA0WEZPc1l3V1hsZmhP?=
 =?utf-8?B?UjEwZkNSK3N1S053SU1UbjcycGlrRWJFNk9VZVpLQ2hRMTdsT0laaVVUakQz?=
 =?utf-8?B?TDdWalA5eERjREJ5LzhlWGtOWTUyajJQQnhwaGlBVk1tZ2VIdE5YU1FWN0Nx?=
 =?utf-8?B?OXRIbHNsaktDNjRlaGw2WmFRdUhPanRUMnNoMERkLytNUm54WmdJRjNyR3Rv?=
 =?utf-8?B?b253UktISUVNSk1jYXlISUZaY2VrVSsvTW52aHpyZzBGb2o4ZWpZdW85RGJt?=
 =?utf-8?B?Q3huTXdjU3pSMEFvYml3NHh1RytTZFYrUUR6Z2tUUkJySjhMckg3djdnZnZP?=
 =?utf-8?B?WDN6N1dBK1BJOUpKOFVpTVJpT0lXaDE1dnJ6Zk4zOCtJTW1vTDZ4SlpnekVq?=
 =?utf-8?B?UzZqQ1pSSjdiRHJab2hzY0NiSnV5bUd3ODJMU0FCdW55QkQyVVNmOVlSajV2?=
 =?utf-8?B?YUFFNnIyV1NpZjhtVTYrU0I4ZVZyOWc4MzVLeHZXZWFnVThFY3RDNlJ3Tmxw?=
 =?utf-8?B?aWJzVGZ4RzloNGpFS0Z3ZTlFNldVUGJyNzMrQlZSNndkenYySjFrQUxxTXVj?=
 =?utf-8?B?UHRqMFRoTVJ3RkFmSTJBazVSdmhjRXYrc05qYTZaUkRkaUw0Z09xQmFJM1U5?=
 =?utf-8?B?UitnMGlPVkppQitENmlaN2xiTEd6U1NDNXpCUXJpWUV4Wm0xVGlhUHJNdGV2?=
 =?utf-8?B?c1ZqMVUzUXluUjFBNTVzam5Yb3R3SkRaOUo4bm9ET1VuVTNRcXpKdHRUbm5w?=
 =?utf-8?B?VVA5aUlDNFJNaXdLOTVCVHYrZnAyL09jRjZXbWJqTEswWlh5cmZubmx3T3BO?=
 =?utf-8?B?N3ZzUUtxa0ZrUVE5UkFaNm9venBicmExaW1LT3ppODJXSFcvK2N1WW04c254?=
 =?utf-8?B?MEo3YUlFajVaTTVuWjJCMEs2a0treCtxS3hBaVNzWUdiVkUvWVVmNDhhTU54?=
 =?utf-8?B?bDM2WmJ2eVExUUxGMW5xK0kzQmJPNUlweDhwQ3daaGlaOEJjVTkxZllTQlpM?=
 =?utf-8?B?UkhJY3F4OUM2QUZhbDBGS0FzaFN0WmtBZFJtdG0wS0JDUjBnZ2hYNS8wSGtV?=
 =?utf-8?B?ZVF0cnpoekpQd0Q2U2tpdksveFNIeEhvVlhQRy9QQ2t2dmxmK0l0ZzdxOWpu?=
 =?utf-8?B?SVN2WVhyemdja0NCTE0yYUlFOFdMZ3pHNDNPRWhHMTZLY2wrd0pJNjdEV2VD?=
 =?utf-8?B?NWJHZ25PbURlRXptblk4YUZoblNGa0JSUndLd1AxREY0NzQ3TFhsTmRjYjVt?=
 =?utf-8?B?SnMxQlM1bXIvZHdhbE1LOTRzdW85MlFjNUxMTFFmRVMxMFpzcmx1d01GWk9Y?=
 =?utf-8?Q?SlPU8rUn7eSOg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDNwWGZjY2JJSGNCNnVVUVBtSTVKZjNBT2JQME1MUFJaQkQ0UVJLbFZ0aFFL?=
 =?utf-8?B?bmM4RnVxZnkvOGhlVU4yRHVpR1ZjNmVXYWVnYlcyTHNnK2FyV3FBbnJ6c0FO?=
 =?utf-8?B?TThqSHN4NnFkTnZmODRPamhMUjZUR3YrRExuT080VVMwUXNPYmdWVjZBY2xp?=
 =?utf-8?B?RnljYUtKekZKYndVTVlzMnk4M0VTbXJIK3JTZ01pdTFtNDB1UmFLZnl3UnJy?=
 =?utf-8?B?UE5HSGY3RlY3RXRYZ3lkd1pZMHFOeGVjSnFJbXJHS3RDSVRuWXdOOUk2ektV?=
 =?utf-8?B?b3ZnenpleFBlS3NQSHNyeHRlNktIMzBoTDBpMFlLU1RQRmM4bUNrMHllaVls?=
 =?utf-8?B?TGV4enhvNlkzczdMektwU3ZYYkFHTHl3azJGYTV4UjM4VEE5aFg0SGhrdXJo?=
 =?utf-8?B?dGFSOFd1OUhQditLUnlBUE9KSFc3VytIMWJOdFJWMjdzVTVyTGY2bTNFbG1u?=
 =?utf-8?B?Z0RxeEYwMVlGQm1mQTAwZVJpQ3hQQlVGRjVRTERVYUJnRERRbkRjTGhWMEdt?=
 =?utf-8?B?Q1VsR0hEQjhtQmFjRG9RQzNkeHUzWEkweDQ5MFViZVFyc1k1SXlHYmtLeFZ3?=
 =?utf-8?B?bVJJM1hzbHdUbWIyTGdoNHZaUGwzRHljR3Z2ZHN6TGQ5QWJSUVBvVVVaRFFO?=
 =?utf-8?B?TzZhenhZUkhzYVRhdFc4dG1aR1Z4V0pra3N4U1FSZER0b2ViWmY2bStmZWh0?=
 =?utf-8?B?N1BTUjdnQ1kvVEc0ejFDalZGNE51ci9pY2piMHlEWmxQVzdoS0NTN0xsVkhZ?=
 =?utf-8?B?YWVrWExmRmQ2M3NZZGZyZFpsLzdIblNPeUtJZGFDVTVJd2tzRHR0QVB0RjRB?=
 =?utf-8?B?ODIrdGxsanBHUUp1R25UQWYrVm8wK3ltWGQyMFBTZE8xNEFhQk1MSytMSDM4?=
 =?utf-8?B?eVB3RkRyZkVITlY1YkJnTFl2dDZhVUg1VmhZbjlkS1hhTUJxYjlhU3NPZEln?=
 =?utf-8?B?VW1iOS9PZ1B2NDJuanNoRVpaRkdMMGJTNjNMM0I5Y2JmMjAxYWkyWUw4MjVx?=
 =?utf-8?B?ZmZxdkpQUE5zWUpKRHFVR21kMFVRa2Z6V3M1TlVZbTRjTkRYMUxVUzRrd3Bz?=
 =?utf-8?B?MDdMQm1kRkxtN1NvTUFlNys1SThCTThIS2tRYzNjakVLNEYzeW1ncjd2QUNr?=
 =?utf-8?B?N3JEUk5PSlllT0lZMUJERTgwL1ptUS9Qa1lVS1RrVGE5Y0ViRVMzNHg3WGFK?=
 =?utf-8?B?bW5SREUvbmNxTkhzQ3g2MGp6NG5CMlFic1FTU09HREJJd3hvMmVPa2hnWjJ6?=
 =?utf-8?B?Vklsa0VZd2hrTGtlZEdGL0NGdVJNVnJEdnRWd2dMVmluV1RJQkJ4K1hGRTZ5?=
 =?utf-8?B?c2JWN25kNVlSdFE4QnNwdkpFQ0YwOUFmR0R3QmtaS29RRG4rbzlZUW4zQ0Rw?=
 =?utf-8?B?QlFpMitpdVBuT1lrMnpXTzl6c0dvOHQvU3M0RUxuejNpZ0NlTXhUa1BDcTR4?=
 =?utf-8?B?clFkdzhvcTJqeWoxSGREWGxFeHRIb1FKamljN2ovOXFmWXp5NDVobjdzcTdt?=
 =?utf-8?B?ajN5QWZ0TjJISTNlb2pQeUdRQlVLRVBSaTROY2JHd2ZxNFZmQ25vTXBaTTha?=
 =?utf-8?B?S1Q4SEN5SDFZbmNpTkNRcHpWQ0krdWRlQjhJUG9SMm41c0hnWitWUFVTVEdt?=
 =?utf-8?B?dFp6bm9OS3VvKzBMbFlyMWNCcmgrbmwzSXdtQ2pNVE5Dak5OeXBtTjRFMCtJ?=
 =?utf-8?B?ZGxUd3FVaER4d1V4MzBHUUZ6OWNQbWswUlgvY3ZNYWc3OUV4MzlMeE9TYVFr?=
 =?utf-8?B?LzlLMHkwempFQTJObWNuRmgxSnEwc3d3MjlpWGxVY25rZGpFR3dEeDJOQm03?=
 =?utf-8?B?YitkeWpISFJJZEZjODVBNytOdFNSQ1pDN0F0K0VzdUZXemVpWmRKRXIrY3hX?=
 =?utf-8?B?Q0hySE0xWk84ejBGYXdFNk9XczN6YWhCWWtnOFZ2emt4TERGYVJPRWN4Tm5R?=
 =?utf-8?B?WFMvYnBYR05nSTc0MGJyRXEzOGNJU3ZvS2gwMkN2V1gxR2cxN25OeCtSaUk3?=
 =?utf-8?B?N0ZFd1RiYlpQbFpGTHFKNjRDeTBoOEhDSWNFWGx0b0tOdVFHWTgxMXRCWUtI?=
 =?utf-8?B?ZGdpdnducWZ5ZnJBR0djSC9JSW1wR0hpVFgzcGtNaXVhRzE2VStpaGx2aFow?=
 =?utf-8?B?TXdOZHZ2WVR5bFZ3SEZSVDM4RGlTRzh6NlF0WEFnODJ1MW9jOEZ3RlFuLzZC?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9d2719-c2de-473e-033e-08dd580cf738
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:31:26.9008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQ8RHeJRToldFTBLvYJcXWnsKcHw3GE+Et4eL164PIbHZMVq9pEbiZEocef+gV9lrcWoDeO8YKpwe9g4xF5e9dPCuFGr1ET75aMZATlm564=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7450

Hi Heiko,

On 2/28/25 4:08 PM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> Jaguar has two type-c ports connected to fusb302 controllers that can
> work both in host and device mode and can also run in display-port
> altmode.
> 
> While these ports can work in dual-role data mode, they do not support
> powering the device itself as power-sink. This causes issues because
> the current infrastructure does not cope well with dual-role data
> without dual-role power.
> 
> So add the necessary nodes for the type-c controllers as well as enable
> the relevant core usb nodes. So far host modes works reliably, but
> device-mode does not. So devicemode needs more investigation.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> Tested-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

