Return-Path: <linux-kernel+bounces-343650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48526989DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AEE31C20432
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EF9186E39;
	Mon, 30 Sep 2024 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="RYFGaV3o"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012069.outbound.protection.outlook.com [52.101.66.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5B187FE3;
	Mon, 30 Sep 2024 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687526; cv=fail; b=QC0lI5LS8+L3YsFXvBIQT7DzVXUmME+5dSm9G7kmmyfPAZSQG+/S1chsOgsC8w2yuuRdpQ6wpBXgrB2cySRKRxxdfU0JA2e1JXs2x6XTFPCixdDGAuyZT7+2ooRtRzsFj9bxU517lgFQM1tQlAoyJsZgmxj4Om55pT1v4/joDhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687526; c=relaxed/simple;
	bh=VMTaF0cfZDB6r/Z8P0WD/aEQVc8fbd2mUqii3JthsXU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tWgJOINutnlAKIIRydF02sWW6Z5clsHgVqrk8tQJyPckKKGB/6cqYutslNx6F9en69D2SEsarBgq5STcxTni4oZOnlCfVrX5wRGWn17RB931Z8IhduxZPAzqbh1D58OII1eihnJJm213SR7HGyCwC+PCzUiwmjDFb7U+OL2w0Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=RYFGaV3o; arc=fail smtp.client-ip=52.101.66.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6OckKbbKSdwYFFTmdGk8N/tjuan+E69PJf0ul9lVxnEScI79t6wYOVO+durNI2LXAvU+Ixj0sSQ6tfawmpbST6zTDn2qRsamXFw8EyRNzsjNV42XWSN7aqJkGQ+xzP1wZnWoQ1dOxKMHWLWyWbrO8xdVOPCUlrSD9dwTDOBxokrSPIKE8J/jKC0Pat1OsW592Y4HdXzwNA3nRbC+dkMkl+ScnieghPA9/U6I9wjTfqh8CH9UZvp95gkNPMgETuPv0BP96jhbbG05uztGJf/EReX1QEZHE1ZwH44tSNMUbGCzrE9sHBD6WjkH1nXLa5nixqVcNNQNRabo5x2DaMv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMPT2yYkvNPnY8xpCPc7dZ5QdXmZMUazVJ+otZdYKU8=;
 b=mwFXyfm3q4svbc0wMFTa4ZU0im/X9r1xJUN7gLYTBTzldo+cLOM2KfRbJ3vEAA8RmtmFfXOtDMGjvxIF17WjXdaiAGBHjdS8gab2oZonMsaee9GrvC4vs+mTAdEGLTMnJyVYelWHZEmEHVnh3MsfTgupe17YlC75s8OYLQm27fTM3xlNXz1P4MJKidUHXp0XkdvXMSkGdDcSsedgB7UV/bFvt1sTKiCeSYP8MJ9BynA5I++T5g69zPrucwRE3RfW/l7UBOyF/gQDFz2Fyw1sulaCPnNVq3N0wrLcvVHSm1RG+5/nxI8AdGlQG+2hLsMmxXRF4VjnJubfVB9hPYvsIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMPT2yYkvNPnY8xpCPc7dZ5QdXmZMUazVJ+otZdYKU8=;
 b=RYFGaV3opggjidEOvuRdpIi/YA0gNzxxKBOxd/3Wn6ZT6V1sILFmsJxRfcJFO1UtJibE0EmBAuOENUOZ6y2v37LV5P1XWFh6jggGustwN8TjV4emYhgiYJFSDMYTRqih1W1ttxv2IMGDzuCgwsHNwbKu8qO8o/QXdRPb3aJvghY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by GV1PR04MB10920.eurprd04.prod.outlook.com (2603:10a6:150:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 09:11:57 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Mon, 30 Sep 2024
 09:11:57 +0000
Message-ID: <5f73e2cf-cb18-4b65-9e42-cf3192aee706@cherry.de>
Date: Mon, 30 Sep 2024 11:11:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Add power button for RK3399 Puma
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Daniel Semkowicz <dse@thaumatec.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Dragan Simic <dsimic@manjaro.org>,
 Farouk Bouabid <farouk.bouabid@theobroma-systems.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20240925072945.18757-1-dse@thaumatec.com>
 <54c49375-cb2a-40fe-abcd-fc56c04d0c53@cherry.de> <4620941.LvFx2qVVIh@diego>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <4620941.LvFx2qVVIh@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::18) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|GV1PR04MB10920:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fbc1f00-4805-49dc-287e-08dce12fef4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0lMZmxBMGgwdTduLzFHZHpYVklPSU5zUHROVFJ6RG01NEtFdnpVWjM5dEQ1?=
 =?utf-8?B?TWNNLzFjSm95TWhNMkJVSEtHUFlTWGVod1pQRUEvN3VWS1JPSHJyUVJmbnBw?=
 =?utf-8?B?a05kQVEyM2pxWTVCRkdmUXF2SlEzNHFqaWl0VTVrQTlxUVdVNVBPZElydzZi?=
 =?utf-8?B?d2ZIa1pZM2xKbmhxc25GMHVZdHRGSyszdURaNzFPeDJJbnFTaURUNmQvZG1p?=
 =?utf-8?B?WXdVdXVYU3YydHlHTDBtcXpHZGpRTWhDdHRHMlRnZU1Uc2NTaElDL1R2K2Fo?=
 =?utf-8?B?aDhYRVZ4UlYxcm5aQVlmN0tQUXpGMkZTUTZHS09PMkk4S0FrMGJUN3VRc1JG?=
 =?utf-8?B?V09INFhKWlV3bWJvcDEvVStYZStsQjJrV2VRbUQ2N0daWnBzcVNYazJ6c01q?=
 =?utf-8?B?cEtRODA5aHlrY25kYldsTVpmSForY2YydjFER3VpVDJXUHZTVG1oM1I4cjZ0?=
 =?utf-8?B?OE5oNDYvK1c5OURLUUx4ZGVBUURkMVVzM29QSDV3Q0h0c2RtekxTNEE2eEpu?=
 =?utf-8?B?UGxodjdRZUU2S2Vsbnh0R2xOc1pzamFOVjhqZXdvcjRZTytvZFd4UHBjZjRI?=
 =?utf-8?B?OXdoMVBncFQvUzRUNTN1UXpNQ3lqc3QwdStnUkNYaS9SM2hZWFJRMUxSS2xO?=
 =?utf-8?B?Qm9KNlJLNnZYZmc0Uzd3U0tLeFFOTEdpQUc5R2R3QVdOV1ZMMlNpUEd3NnJs?=
 =?utf-8?B?bG5uQ2ZqN0NqeS9HRmZYQkRISVJSanR5ME9XeTBQYlNNWWRVZk95TmZsRW9O?=
 =?utf-8?B?TjN2OWYwYkFtK1Q3RytNYUJFeENJd2lDSHV4bkxtSzdCdDhtaHlLRHZqelc5?=
 =?utf-8?B?Z2xWcUtkYkRVQm9oVVBNSGwwZDhCRmpvN2RSdDNQRG8zaWhub1JrOUErQWtO?=
 =?utf-8?B?ZWVZMG5CeHRvN2VWUHZlcWdIQkpuN1ZjQW1VamVpUW5mVFJ4YmNKYUU3MUlJ?=
 =?utf-8?B?L0lBaWRTcUxBVGU2aCs5NkdmZzRxb2hrZlJDdWNMUG1DYVo3bTJLWTExQnE5?=
 =?utf-8?B?YW9VdTk4cEpMYzZJZExGQjVrby8vNnFValBPTHB5Ym9LNFVjMFdGREFNZU5j?=
 =?utf-8?B?b2lLYWZ6TzB4a3hKVlpHOWZRNDZnMWxxRGh4cmxpMC9NeVVUR3ZXZzVuTk9s?=
 =?utf-8?B?NUxSUG15cVA1TVRLTGdMUW82UWlCYWJJOUYyZ01YekttL0pXSmdHeXVlUXVP?=
 =?utf-8?B?aEhST1lCOXY3cm92eWZiSnNid0dudldQWGVNeXhKM2txZVZMOU1VMkhvZXRi?=
 =?utf-8?B?bWFnUmRpYzB0Q3JLZ3JIZjllS3BEWmlkYWpaUlRsQy9RM2M2cDErU1VDZmh4?=
 =?utf-8?B?Tm1RbVFpODdERnRaUFJxN2dnYWFjb3BhRVFQSlp6MDBYSFJQbHpmNWRNS3RO?=
 =?utf-8?B?MjZLVnRHVitoZUgvWVYxUTdjRG9CeHh0dmtucEpZYU5ZTGJoZHo0U0h1cUhl?=
 =?utf-8?B?ckhDQ0dtNXBNRU0raTMyc05tUWFTUi8vc3d1Q3pVWm93d0ZjV1p1OFJ1d3RR?=
 =?utf-8?B?SEFiakt5NS9qczZHU2ZiUUN0R1Bic0R3Tk53alhtUnpwcmFWZXNGNUZPSytF?=
 =?utf-8?B?ekNzdEJhM0VIbkVRdjJWckM5Q3hVUjlrUEdjS3BtZXZpR1Y5SW5yNExRWGky?=
 =?utf-8?Q?avRxV+moevNK7IVrNhsgVPggj4RTweryNj+addjjU8ss=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cllhb2FoeHNwU054TUpyZGRsdFY0RndCVTZlcW5MdHVPUExBeG5SckJzenc0?=
 =?utf-8?B?WVVVeU9pZUpQY1NSM1hGKzVJTDFLR0lMMW9IbU5HcUZaMDk1dnJmb01QVnZq?=
 =?utf-8?B?S3ZuanhVSWtGZUlYdnpudjQyMTlKUWhZTG96bXg4YTRzQU9sNGw5c2tBcHd3?=
 =?utf-8?B?TWM2ZXM4QjV2Ui9xMUZLMzA1NHVXVjRodUp3SnYyM3dFeHRvUS9PaUFjcjhX?=
 =?utf-8?B?Z2NqcmtYd1ZPaWRIT2dGY3NoL0JOK0NWNTZtRkY4SXQrbXJZR25Ud1RwWGZF?=
 =?utf-8?B?T0FidE14c0dlMkJWMmo2YkNLKzMyVE1NOWIyR29xMnpaek9pMnlIVGdZZWNm?=
 =?utf-8?B?dmhCYjV1dUZMSStLTFg2VGFXZmJLbDJzTHdwZVNmazJBM1BRdW5kNEZtSDBC?=
 =?utf-8?B?a1BzY01PK1B3dk5BbkRLT1IrT1NOL1NmV09CSSszU2s4MngySmtubDRaRE5Y?=
 =?utf-8?B?ZkpaZGNsRzAwRkdTYTRUU2kwY3hmcnJKenhlYUlJTVd3N0MrSUVjNnBUWlF2?=
 =?utf-8?B?MStxSlZlRHUxRytSNTNlcEFINE5lTThVY05jSDdmZk5VSGt5aDJCVUtSN1B0?=
 =?utf-8?B?WHZRSDA2bUZTbjFUOTlXeU5Tb0J6Y3JKdmFqdzBGMjZiaDRlYWg5RXNxVU9R?=
 =?utf-8?B?VnBhV3hMendtSFFPVjNDQVd6cWN4UTMzTENTdnMzb0drS29ZdENKTThWWk0z?=
 =?utf-8?B?OSt6VHdWdkVNbzBYRXNaMjFDQjhSSDJraWZ4RHE5bEVyZWoxMGQwY2JyYjJh?=
 =?utf-8?B?MDlDNWFKMGVlTll3TDI4TytDVFBEMzNFS1VrWFRFL2hUSzNsd3QzcmZyQkxn?=
 =?utf-8?B?WkNZZFpML1FIdWFBeEFHTitjb1ZZZmZCMkdqeGJBdFRlMmM4ek90Z0hkcTBy?=
 =?utf-8?B?Z2UxblBBNm9TQ24wR29Jb1k1L0U5Z2Y0VTJwSHRpNTQydlFlQ2VRY210ZG9F?=
 =?utf-8?B?RVVlYlhMbTUyR0NqYjE1UWdiTE51djBJanZzb2NaL2cycDQ4ZmdGSzNnKzlU?=
 =?utf-8?B?ZExYaExEMUxBZXJPb1d4MmdNK1Z2OWFrTVhHU2VXRThtSkNDLzBhaElZWlVz?=
 =?utf-8?B?UWNxbTE5anMwQjVNSVRpNWx6WkF1QzZ2WEJoYWpndnd3NGxBOFdXTXNRTXcz?=
 =?utf-8?B?NWk1WVdiQ0Z3NkVQQXMzN1RleTcyMzZibVF6bWl5NTJ2MUtpVzE2RE5RV1R1?=
 =?utf-8?B?dGMxNnhOdWEzS0x1Nk04TC9ualRGdVlnUGlHdEJpRHFmRDNvT2NkL3cvTXZT?=
 =?utf-8?B?RE1SczhEQkQyUWpIeDdZbnpXckZ3eEFvT08yb2Z0OTBHNUZHM1dYUG0wT203?=
 =?utf-8?B?dEQwenY4RVI2bVpWRzF3U2tqRHpaTlAwMmlmK1NEc2pwWXV1VGlsV29KT0Fk?=
 =?utf-8?B?allMeUZvYVZ6K25FRlc2RXNqbGhkWm0xUEJuclk4NXJFZnpjTzBPdFNRN2Q5?=
 =?utf-8?B?U0VGbG5jTG5QeXlJdlpiTVRCZFlLUituTThvc3BYdXBYNFlVWXJjK3VYVUtE?=
 =?utf-8?B?QzN2aVFUVGpueldkNWJSam9xRXE2Q3JSS0FQK0RoejRjaXFvenpZWjJVMmpZ?=
 =?utf-8?B?akFmeGdEY1Bvci92cmQ4ZGlNZmFEczBkbFBsd2RJZTViZldlVEJ2SkZUSTdG?=
 =?utf-8?B?NkJQQjByL0k1Rng1UWxKcnlvY2o0eVVlczg2ZzlZYWdzK01WMThPOXlycEFj?=
 =?utf-8?B?WE9QNjFkTUhnQnU3NHlwcVBSc2VFcTlXUEpuekRQcW9jbzBaWk05V2VWMWVU?=
 =?utf-8?B?SCsrOWl4a3lwNDhVa2phMm1pa3ZKTjBFSXluUVRHWWRKUDcvcFdhRzFFMG1u?=
 =?utf-8?B?N1VmbEo3MHJFKzk5NmlnVUtZdmFQaXlrWXl3VEpjdUc4SDYyYlBoZC9ac2J5?=
 =?utf-8?B?WFlWRGFJRm9xR0ZlMUtrU2xtYmQ3b1VRS0t2OUN3UVBnOUwvSzh6MzI3Umg4?=
 =?utf-8?B?bDU3aVdPeFV2cXpQWURCb0d6cGxCTlpoTFJSZElZZmhCc211ay9tVWkzZTRN?=
 =?utf-8?B?WVNIQ3hJcFMzQVR3VSs2aDg0NFYrU1k0NGRGdzBGK0lFOUFicG1QT0FRblVz?=
 =?utf-8?B?SUp2RjhlNDdiejcwUUU5L1cxSFEyKy9iejlhZ0o1U1dzNW5UajgzNVNOSDV1?=
 =?utf-8?B?bkVFTVZiYXIxOWhBSi9vMUkzMFZWUTdxWDlYdzY5NWdEcUhZSFZtSjZRNjlt?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbc1f00-4805-49dc-287e-08dce12fef4e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 09:11:57.5724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8G3IsDE0z65XbPCqZ76pj8IoTHuI0yLxqM1Y4EAhsmwKiIVo4VwnaGJnR1oTqMVHoMRy263lZdmbSCuLcZjVQH2aeCwdf2sVd/AtOih7nNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10920

Hi Heiko,

On 9/30/24 10:49 AM, Heiko Stübner wrote:
> Hey Quentin, Daniel,
> 
> Am Donnerstag, 26. September 2024, 14:34:30 CEST schrieb Quentin Schulz:
>> On 9/25/24 9:28 AM, Daniel Semkowicz wrote:
>>> There is a PWRBTN# input pin exposed on a Q7 connector. The pin
>>> is routed to a GPIO0_A1 through a diode. Q7 specification describes
>>> the PWRBTN# pin as a Power Button signal.
>>> Configure the pin as KEY_POWER, so it can function as power button and
>>> trigger device shutdown.
>>> Add the pin definition to RK3399 Puma dts, so it can be reused
>>> by derived platforms, but keep it disabled by default.
>>>
>>> Enable the power button input on Haikou development board.
>>>
>>> Signed-off-by: Daniel Semkowicz <dse@thaumatec.com>
>>
>> This works, thanks.
>>
>> Tested-by: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> Now I have some questions I wasn't able to answer myself, maybe someone
>> can provide some feedback on those :)
>>
>> We already have a gpio-keys for buttons on Haikou, c.f.
>> https://elixir.bootlin.com/linux/v6.11/source/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts#L22.
>> Those signals are directly routed to the SoM and follow the Qseven standard.
>>
>> The same applies to PWRBTN# signal.
>>
>> However, here we have one gpio-keys for PWRBTN# in Puma DTSI and one
>> gpio-keys for the buttons and sliders on Haikou devkit in Haikou DTS.
>>
>> I'm a bit undecided on where this should go.
>>
>> Having all button/slider signals following the Qseven standard in Puma
>> DTSI and enable the gpio-keys only in the devkit would make sense to me,
>> so that other baseboards could easily make use of it. However, things
>> get complicated if the baseboard manufacturer decides to only implement
>> **some** of the signals, for which we then need to remove some nodes
>> from gpio-keys (and pinctrl entries) since gpio-keys doesn't check the
>> "status" property in its child nodes (though that could be fixed). At
>> which point, it's not entirely clear if having it in Puma DTSI is
>> actually beneficial.
>>
>> Someone has an opinion/recommendation on that?
> 
> I guess from a platform perspective nobody really cares, so as that is
> "your" board, it comes down to a policy decision on your part ;-) .
> 
> While pins follow the q7 standard, there may very well be some lax
> handling of that standard in some places, and I guess gpio lines could
> be re-used for something else if needed, as something like the lid-switch
> is probably non-essential.
> 
> Also a gpio-key input does not create that much code-overhead if
> replicated, so personally I'd just stick the power-button with the other
> buttons in the haikou dts.
> 
> Which is also a way better thing than having multiple gpio-keys instances
> that userspace then has to handle.
> 

Yes, but this also means "code" duplication for whoever needs this for 
their baseboard, instead of just having to add a &gpio_keys { status = 
"okay"; }.

I don't think there's a good solution here, so I would suggest we go 
with everything in Haikou's gpio-keys as Heiko suggested then, @Daniel 
if you agree can you send a v2 for that?

Thanks!
Quentin

