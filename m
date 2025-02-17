Return-Path: <linux-kernel+bounces-517400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF5AA3804D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AD93B3C29
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B367721764D;
	Mon, 17 Feb 2025 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="T5yjlt5c"
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A7818C907;
	Mon, 17 Feb 2025 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788459; cv=fail; b=WzkywPFRuGRWcL4v753RGh80LcBhFsHcwIEUzG8rOYLS3A3ssQ+/N6m0haBczf5zXNXyKtBA83bG8u+5s/AmTk7gWr5wrNF0ziaiyOrR9Szz9Z//b6VThZhfPkBQKPg4xiAPIeyWC09QIovWtoZogmIXpVu884X85MTx5qALwSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788459; c=relaxed/simple;
	bh=bsAR8kIQZo2mwBXDtauSCZ+aTJ600FbvOKNaDqZ6xAE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hmXNPFhIU1B0l8nGEmz66Efej392wIpfroH8ff2hu2x/FjpxzkZJesA9Pawi70dj/f4FGJz+A38edjEFH7GYNKpzjAB9418V+lLEj49FTik7DLCsT77DhCel4kUYoxIXB0+yi/PqNHEGALpWJlsbefb9bkCl1spSAsJVETRsE04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=T5yjlt5c; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfmBPQKvJBqPKbBPzgrtxQKbfyqafbfbAUC0CYhXm/CFP3REIqBzN8kdIfgVP54ZHNfw5IqdDKs8nzIc7YmlvYEMTjdEADzIkVIfhcuNIEIiY62yz2blT/ovYcwxoAwPc3LmmoQu8+o7cw+evjk0nBKFnX8OAyGx+d084RTdOmD7dhznB8LzQLGvGihp/QqTuep0OHOwZGgwPC/8rpRlgZs+8qXOrs6vitrmFeYV/ncMxnFfs4nS+sVrHYxSokBDJQrhjmQmCmXd1YMHTc5ZqgTa4tR/SqpVjLkcPi4Vcfboq7Vh/ArDaEf0BkCDM+drSl40GiiaO8LxcV7pNkaehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwf97nhjhEq1iebpPiDv/S44bsLkbtpVZG0DxAHDNQ0=;
 b=yZfk7bj/vBroodWnQecbdP4uDryIyaWfCCJVYCkAZPGsfP/vArebhODQ8/U9UgqdF9rdQW+mvjS3j6uOs6DyS74f8FvMlwS4nubqgQTX2swdjY5fy5heXN+dzncY7BsC8MknewzeJ8vNuf6Gx05j4eJXCtgRsuMsFnpOUCFavRF86lOWccu+tkxpbUYbrPJ4UCB3qvsGzY2CCZGpmFVkAWVe650MI5XazeSn7ePxshI4gad6fPZoDdYL+u/7wd4YY0um5oBob2y0TD44pyUSlxBbQxZRt3xkfSYrlyIjNoeClmYrPBviHeXqlz2LwfzGM0+SS4fPKA149P0BG6IiCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwf97nhjhEq1iebpPiDv/S44bsLkbtpVZG0DxAHDNQ0=;
 b=T5yjlt5c8H7eI9VP8uz6uyj7ozw/gEI0vOvMILwQtsR5Uv7Uopv3RoiCzHdWGgvce4uvUFPzyBso48Qy9IssYF2GeU078e978y2iZs/LRqaJSSPcOz81HIPCv3+C7k29c1ROmjZKDb4KEN37I/DoirimpjneNgyoCSZv7KIhPXyYTL27Jhl4uyuYf1lwNpehvohx4SbimKqdcsOJabU3tEw2NJMWIwR17GtRc1fsBHJ6/bsKF/6KgFswPhRyhPaX0RECUjBCKYIMB6yWA2Ub1MQYkXLVYCWzOdI43vpmPiXyXLFurYV8Q/l1jeuPu223hC3mniHSFj65DKI/xvyCYw==
Received: from MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:6e::9)
 by PNZPR01MB4351.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 10:34:10 +0000
Received: from MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::6e06:bc2e:85c0:c2ee]) by MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::6e06:bc2e:85c0:c2ee%2]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 10:34:10 +0000
Message-ID:
 <MA0PR01MB5671D4A748A88CABFF0FAB20FEFB2@MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 17 Feb 2025 18:34:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] dt-bindings: rtc: sophgo: add RTC support for Sophgo
 CV1800 series SoC
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 devicetree@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250216180924.2506416-1-alexander.sverdlin@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250216180924.2506416-1-alexander.sverdlin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:6e::9)
X-Microsoft-Original-Message-ID:
 <719fc543-143b-4c20-81ce-66d2c92df1ed@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB5671:EE_|PNZPR01MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: e6dcad20-3a3d-474a-7b63-08dd4f3e9d4a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|15080799006|461199028|7092599003|6090799003|5072599009|8060799006|3412199025|440099028|10035399004|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dU1SQUgzWjE0R0FPc0xUSlljZzRQVUpBRVlZRGpSQUxkRE1OZ3dzUERaM1RE?=
 =?utf-8?B?RTUrcFhJKzhGbVllaEpPeEpsMEF0OFNZQWRvMUkyL0EzVHJzcEhFQ2NvRU4r?=
 =?utf-8?B?eDlTN090ZktjNVBtM1hnRFdORXduQTB3dkw4RUk2TldQaE5oTmY5R3Vwbis2?=
 =?utf-8?B?SVJaeGt0dHd4YUdCY3U5bGZxWnZsRGRxck5USVVhZWtsQmNVUUZrdXZKaC8z?=
 =?utf-8?B?eTh2ck4vczB4YUtMQ0tmazdocFdXKy9Mdk1Yam9XR2x2RFZqVk9PWUNBaUlW?=
 =?utf-8?B?VnFPYWV6ZVpZbk90eEg5aTVjdFpkMkMyT2J3dHFtRW1mN2syL1Z5c29WZHhm?=
 =?utf-8?B?L2hKVDRER0QzTTBZMER5UlFZS1ltb2h3bjdEVmtVcjB3QWZnTFBQTWwzelQ0?=
 =?utf-8?B?YXBGVWNNb0pMQ0xqdGUxL25rcm1FSU05UU9xeEpTVGYwOE54Rjc4NG10YTZy?=
 =?utf-8?B?QitXdUlIeWR3M1Q2SHV0eTdQVWhSMCt4UmVram9lUE1VVWp1VVJrV3FCTlRJ?=
 =?utf-8?B?SGJwUXRlWlkrelJqVFVzLzM3M2VlbFBxSlNaWFVXVHVkWmwxMjQ0dlVFRUM4?=
 =?utf-8?B?c3B0d0hqZ2MwL2dYQ3BQMzZNUHc2TVBHVXRMYUU4bWtCRnphWHowMUIrWEdN?=
 =?utf-8?B?ZFN4amtiaWgrRFY1UUl0MlhKTGJlZWRKTDc4Wk5IM2xqNk53Qk1xTTI5TVJS?=
 =?utf-8?B?ckNZSDdoRFVqSkRyZ0FWRERuOFM3ZUNNOEpYYkFza2VVd0cxZHBGY0Q4eE4r?=
 =?utf-8?B?cmdsdDUxbnMxamI2VFhpWjFkdFBxMUM1QjVablkvc2VLblMvTWRxWlhEb25S?=
 =?utf-8?B?THk5dy9iUzU1MXF4ZlIvSjFhOC9XZFh6Y3FxWUxwMmNMVmZXbTY0RHNSL29p?=
 =?utf-8?B?cHorNHpOOFI4NkZLNkpTTGxlMUtnR0t4MVdObGliL1JrTE5VMXlkaU91d2xQ?=
 =?utf-8?B?WGxlMjlMSmtsKzZIVUcyQmhqRHF4TFBDZXI2WlpENGZKclE1L2hUdnhKdDcx?=
 =?utf-8?B?TFRSR3hVNnJCSEpNQlFYL2xSOWNaMXBvZ2tibXRmR1NCUStDdUVKbWpiRENm?=
 =?utf-8?B?STJBN0FpMVlRSlBGQ3U4SWY0NzJQZjN4bVdKRzlOekZMeEtORDloSGxLd1lQ?=
 =?utf-8?B?b2NDWU51SGpBNDV1bnNxSzFrSlBrWUdqYVZUbEVVZFZtQWpyZ2UyU0pEVFZN?=
 =?utf-8?B?VTErczJVVGN5dTF1MG9zem1PaERoNlRPVFpiS1VrWDlPeUVhWVNady9TM2Mw?=
 =?utf-8?B?ekRKekRwMktYWG4yTTNYUzI2ajdnalA2VWdza1R2S0R5bnpXS2tjZWNvb1Fk?=
 =?utf-8?B?QlljWlR1ZHAzYVVtcmJxUUNWWEJvWG9oeFBQeVpTckVCWlRWY1VMVzZpa25r?=
 =?utf-8?B?VWRKQ2VOMWs2RjgxWlBFbU03akVpTXladjRjRG4rOEcrWGpLc0RGb0QwL1VX?=
 =?utf-8?B?ZUJ3R3BKdnRPQUF4YUdVNGVwWWpFSUpPeW1sUWNOUHlWTUMxVXpUOTc0YWJv?=
 =?utf-8?B?eDNlVTl5VjNhQ01hQldDMy9QT1kzUWFRWHBzdndsNzVpOExibzNYODVEWXo4?=
 =?utf-8?Q?DKNUz+t0v4PU7uXqfiQrP+eNEFsjHTuMMLgIrHkSO51kuf?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STJHczRubmROZEc2K2Zva0ZXa3QybVIreUMwZXBsdGllcUNwa2RqREgxN3VW?=
 =?utf-8?B?N3AycEV4cEs3MGNCRitZWVc1YmhHbHFZT3h4UDk3ZnZ2emFKTlorRkRMVHpj?=
 =?utf-8?B?VisvSzlsS2d5Zjd5OXpiSGRrSnI2OCtQdzd0ODVnbVplUHA3Q1E2aUFvdUgv?=
 =?utf-8?B?RjlYSGg3SG5xbWlwRE8vS2xZLzVxRHNRdk93UjF5THZKM0Y4Rmo0MC85NVpB?=
 =?utf-8?B?bm12SUNmZWNMK2xrbW01Q21hY3VrOGZCa3ZQYzFGZlFrSkl2bXZxOWZqNXgy?=
 =?utf-8?B?OENLNXZxZnM3bkNLSGk3TzdHUzBINzJyb0ZQUW4zUXpUWmJZL0xnRkVxbHdv?=
 =?utf-8?B?Z09ScnhvL2RTckx6bW5WaitjVW5vL1RwaEE2ZjcvdVdQV0p4OURYbnFIbWFR?=
 =?utf-8?B?SlBtZFBodEphaHJEV0g0dFJpUEZsVlNlaC9HandQZHdqcEFXcUY5dzB6RkEz?=
 =?utf-8?B?QmV5cUhwZS96MGV1WVhML1NhcVUrazFVVGtQWnZDOC9aUCtFcGNRazh5NG1G?=
 =?utf-8?B?eHJDcU50YmZnSGdDWFZaTUpVUUhnNGpZNldpK2xJVG16S05NQi9udHduNTcx?=
 =?utf-8?B?MWtYazlCVWJWaTJnWkdPNkhaNlBadnpBNDVVbWNxdGxiYWR0NDlHdVBrMUZZ?=
 =?utf-8?B?QWFnRzJFcWwrMVFhVndGVm5PdjB5Skp6ZVd3SFBzU09PamlVSkZKNDg5b0xC?=
 =?utf-8?B?WU9jb0VNRG4xSEdjVzZnbUJ1VTNaYVhTNDBLS3JhU1hQS00xUmpVWnRYVTJU?=
 =?utf-8?B?dTMxUlEva3FUNGROc0V4ekpUZGpyRDRITklIRDdzZVdrYmdadkdNelRjc3kv?=
 =?utf-8?B?V05FMTUrRGZQOFd6c2drbVJMQVpHMDZoLzhUUXpEOUo3VlJHYWtwMGEwZEtq?=
 =?utf-8?B?MkhBaUw2Sy9wekI0bDlESHhjZ1R0Tkh2YkxNTFJtWUM4endDNlRTVzU2UEk3?=
 =?utf-8?B?WjBHRkl2ajBMUnI1czJIRENSOFhkeG9qSkxyUFdJT3ZtTmtVZjlBemZGdWtM?=
 =?utf-8?B?TkJUaVg0UkJ5Z3ZJNU45ZWkyaXpyRWhsVG45M2hkMDNJZWZoNzduYzROK0xJ?=
 =?utf-8?B?RnNsbDd0dzVVblZzTWlHSHd3T2hCcFRGdjcveTZldXkvcjZ4VWdNQkJhS2JS?=
 =?utf-8?B?Q1FBaXZDbEwxY3VPRktpakwvZm1IbEJpNVJielpnMytWdVV4N2hRb3owaWdF?=
 =?utf-8?B?eG5vaWlUa0psRTlTT2x3ek16RVpzMldUKzZ0eTFrWnQvK0NsTlVXeHRjOVVI?=
 =?utf-8?B?am5TNnJ5dFZDN0Q1b3lPRVpIUEMrcmRWOGhZUTZkMXlRTzhsV1pGNzc2Z3F0?=
 =?utf-8?B?b1JHdFZsMThMa0FJWENmYVROcjFqYnRwRzRhSk5kZnhsRXVqL1lLOGY0cTAw?=
 =?utf-8?B?Q3JaYTJ4Tncveng5bTNSTDFoZDVUSUJnWktwa0MreWJERzlVRnc1VWI2M2pj?=
 =?utf-8?B?TWNxeEpta0JadkVtS2ZkWTdLOThSVVhwZWNoR2FaSlVjNmdpb1IvM2RIclg3?=
 =?utf-8?B?TU8yQmJBVnZjT2NJdGxGeUxtZkhaa1RuTURmVlRaSzQ4eHNpR1RFQ01rMmFq?=
 =?utf-8?B?V2M1Nld0NG1DZmJ4RVcyTWpycGtXaFBTYWpmMVdpUVhvMWNiTEd5NnZjdnBK?=
 =?utf-8?B?aU1xNVN3TXErbHppLytobDA0bjU5SFRzSlVyWXJKR205ZHl4VVNkdWdGSTNO?=
 =?utf-8?B?TXFWc1lwUTlzWEVFMXBKQWxZWjRvMEhWaUxXN2FIUXptOVlCRkZJM3RZeDVD?=
 =?utf-8?Q?5x+slawyyMr3Mp9WMVslAPcGQ+AjbCpB8iokFqn?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6dcad20-3a3d-474a-7b63-08dd4f3e9d4a
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 10:34:10.4698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB4351


On 2025/2/17 2:09, Alexander Sverdlin wrote:
> Add RTCSYS devicetree binding for Sophgo CV1800 SoC.
>
> The RTC (Real Time Clock) is an independently powered module in the chip.
> It contains a 32KHz oscillator and a Power-On-Reset (POR) sub-module, which
> can be used for time display and scheduled alarm produce. In addition, the
> hardware state machine provides triggering and timing control for chip
> power-on, power-off and reset.
>
> Furthermore, the 8051 subsystem is located within RTCSYS and is
> independently powered. System software can use the 8051 to manage wake
> conditions and wake the system while the system is asleep, and communicate
> with external devices through peripheral controllers.
>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
> QUESTION:
>
> I'm unsure about reg properties in the subnodes (child devices) of
> RTCSYS:
> - they will not be used anyway by the drivers because they genuinely
> overlap (the whole point of going MFD) -- therefore the drivers will do
> syscon_node_to_regmap(pdev->dev.parent->of_node)
> - as I understood from the history of MFD dt bindings' submissions, regs
> are encouraged, if can be specified
> - overlapping regs cause dt_binding_check warnings:
> Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.example.dts:34.19-39.15: Warning (unique_unit_address_if_enabled): /example-0/rtcsys@5025000/mcu@0: duplicate unit-address (also used in node /example-0/rtcsys@5025000/pmu@0)
> Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.example.dts:34.19-39.15: Warning (unique_unit_address_if_enabled): /example-0/rtcsys@5025000/mcu@0: duplicate unit-address (also used in node /example-0/rtcsys@5025000/rtc@0)
>
> Shall I remove the MMIO resources from the actual devices or rather ignore the warnings?
>
>   .../bindings/mfd/sophgo,cv1800b-rtcsys.yaml   | 222 ++++++++++++++++++
>   1 file changed, 222 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.yaml
>
> diff --git a/Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.yaml b/Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.yaml
> new file mode 100644
> index 000000000000..2dc7c2df15c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.yaml
> @@ -0,0 +1,222 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/sophgo,cv1800b-rtcsys.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cvitek CV18xx/Sophgo SG200x Real Time Clock module
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +  - sophgo@lists.linux.dev
> +
> +description:
> +  The RTC (Real Time Clock) is an independently powered module in the chip. It
> +  contains a 32KHz oscillator and a Power-On-Reset (POR) sub-module, which can
> +  be used for time display and scheduled alarm produce. In addition, the
> +  hardware state machine provides triggering and timing control for chip
> +  power-on, power-off and reset.
> +
> +  Furthermore, the 8051 subsystem is located within RTCSYS and is independently
> +  powered. System software can use the 8051 to manage wake conditions and wake
> +  the system while the system is asleep, and communicate with external devices
> +  through peripheral controllers.
> +
> +  Technical Reference Manual available at
> +    https://github.com/sophgo/sophgo-doc/releases/download/sg2000-trm-v1.01/sg2000_trm_en.pdf
https://github.com/sophgo/sophgo-doc/tree/main/SG200X/TRM would be better.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - sophgo,cv1800b-rtcsys
> +      - const: simple-mfd
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^mcu@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: false
> +
> +    description:
> +      The 8051 subsystem is located within RTCSYS and is independently powered.
> +      System software can use the 8051 to manage wake conditions and wake the
> +      system while the system is asleep, and communicate with external devices
> +      through peripheral controllers.
> +
> +    properties:
> +      compatible:
> +        items:
> +          - enum:
> +              - sophgo,cv1800b-rtc-dw8051
> +
> +      reg:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +      resets:
> +        maxItems: 1
> +
> +      sram:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        maxItems: 1
> +        description: The SRAM controller to host the code/data
> +
> +    required:
> +      - compatible
> +      - clocks
> +
> +  "^pmu@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: false
> +
> +    description:
> +      Power-On-Reset (POR) sub-module, hardware state machine providing
> +      triggering and timing control for chip power-on, power-off and reset.
> +      Supports battery low voltage detection and interrupt generation, as
> +      well as button-triggered wake up from sleep.
> +
> +    properties:
> +      compatible:
> +        items:
> +          - enum:
> +              - sophgo,cv1800b-rtc-pmu
> +
> +      reg:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +      interrupts:
> +        items:
> +          - description: long button press interrupt
> +          - description: vbat detection interrupt
> +
> +      interrupt-names:
> +        items:
> +          - const: longpress
> +          - const: vbat
> +
> +    required:
> +      - compatible
> +
> +  "^rtc@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: false
> +
> +    description:
> +      The RTC (Real Time Clock) is an independently powered module in the chip.
> +      Its calibration module uses a 25MHz crystal oscillator clock to calibrate
> +      32KHz oscillator.
> +
> +    properties:
> +      compatible:
> +        items:
> +          - enum:
> +              - sophgo,cv1800b-rtc
> +
> +      reg:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +      interrupts:
> +        items:
> +          - description: alarm interrupt
> +
> +      interrupt-names:
> +        items:
> +          - const: alarm
> +
> +    required:
> +      - compatible
> +      - clocks
> +      - interrupts
> +
> +  "^sram@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: false
> +
> +    description:
> +      Provide 2KB of SRAM, which can host software code or temporary data.
> +
> +    properties:
> +      compatible:
> +        items:
> +          - enum:
> +              - sophgo,cv1800b-rtc-sram
> +
> +      reg:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +additionalProperties:
> +  type: object
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sophgo,cv1800.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    rtcsys@5025000 {
> +        compatible = "sophgo,cv1800b-rtcsys", "simple-mfd", "syscon";
> +        reg = <0x5025000 0x2000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0 0x5025000 0x2000>;
> +
> +        mcu@0 {
> +            compatible = "sophgo,cv1800b-rtc-dw8051";
> +            reg = <0x0 0x1000>;
> +            clocks = <&clk CLK_SRC_RTC_SYS_0>;
> +            sram = <&rtc_sram>;
> +        };
> +
> +        pmu@0 {
> +            compatible = "sophgo,cv1800b-rtc-pmu";
> +            reg = <0x0 0x2000>;
> +            interrupts = <18 IRQ_TYPE_LEVEL_HIGH>,
> +                         <19 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "longpress", "vbat";
> +        };
> +
> +        rtc@0 {
> +            compatible = "sophgo,cv1800b-rtc";
> +            reg = <0 0x2000>;
> +            interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "alarm";
> +            clocks = <&clk CLK_RTC_25M>;
> +        };
> +
> +        rtc_sram: sram@0 {
> +            compatible = "sophgo,cv1800b-rtc-sram";
> +            reg = <0x0 0x1000>;
> +        };
> +    };

