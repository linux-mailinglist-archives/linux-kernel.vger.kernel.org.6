Return-Path: <linux-kernel+bounces-398277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FD59BEE9C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13AE91C24768
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4711DFE38;
	Wed,  6 Nov 2024 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="fntnaTIZ"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C108646;
	Wed,  6 Nov 2024 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899138; cv=fail; b=VTM+bDHD2Vad/jRbsVB4E/OB7Qnfb98PYFIU3Mk8F8eyA7oyDVqhOhN4zjsBkaqwSIvg7q4NGwVIU+o9SLauqj7BnG9/ANG3DATy6NwShTXGjrnoaiTIPlZu4L8YMy6KZ5vJpgIeE45IoBXDvWT6x66ri1MwAYA4ma7fTahtX68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899138; c=relaxed/simple;
	bh=azXu0KHP7hs5c5Z0fLTcF33wtAqXFmB3LzG2ko8+2rE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BApaIHeyQ2sUjCR9YztQXwmuyQs2ZGh6lmmk+cKeNos6osFS8Pcj12hp94DXy8ZVYlV/WidyABT0BAPix9Xy0MVexsjhijd+n7UkUXJ4cvip4rbJseoohTbRtllZq4TswOx0r1Oayb2AAjBayZiWDhSsk8aiRgbnMhNorLmcpY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=fntnaTIZ; arc=fail smtp.client-ip=40.107.104.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0u1sx8qJvfFbUEyJq3uQMrg9wyly+232cwYJGJIY5kpSZjEukkuFX43svkM+Fr9RYL+sSPz2WHPh9DUj7URgBcr7sm32a+c1ORQXyOUgvAl85TQgs3P1g0S7+neReP3Mm4m6B2xvgd6isjCKPBFwIcVBY9/bIxzFCCpbceHJwso1MW00q6I91/7cKRCES67FELKy3u4c414Df+fngTqJajuIl0HyDE9uQ1A3NEy39+AdWUkFjLywe254U0x5W8fqMJOvbw1nFFk//DFMoGXPBV42az3A+ryjcfWH0ZQRgCcDSXdcGlsYiNz31VAgTocfaas3JFls4t9mnTwVfMjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2K6dgjN5KzaaH9tZiZ6WedJuuaUsgkKqMIFPblQUvKA=;
 b=KXM6VSXeg6/Zl0jt6wszZQKBBS6dEDM4YxNvxEAk329uc/TUjSaveUzCQjwkldV/F0Osrdsuzr0SBf3De/UnXvYI2qcpBhwUGfa287oS534sJsJu0qgBkOoANGEIOPJB65xpD1o5QZmJJoz+l3WnYTK0atLjkzcH9Xg80O386Sgw+FqTwfFkGxgah9A5nQTqUFE5R+raUEGQL/tBE6h5tCjY8pXJNQpH+9NK78U0dLjkc/DIn/JuKzXK96d7/t/fTJE5xLGRIMYdFCNiBMsoy0V69cZ80GPSr2E+4wEY3Db4IBM5T+Ubr0KZhDAPkUzKU9UUXDqeW4XCT+FkpH810g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2K6dgjN5KzaaH9tZiZ6WedJuuaUsgkKqMIFPblQUvKA=;
 b=fntnaTIZBEK5ndOcG6DhM2ANa8khyLjHmFPpOZL2d6+FoMUnmoIbITZ39hzxfYBsbQOaViCdBlL/6+CXhEKnjnikyGRyVK9Bp8kgq+BufiGS/1zgCT7TZI14z+H0zc9lhOOCP4rJhNHEYPkJ4AYQEXLWl3u77GpoFNq4VourS/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB7600.eurprd04.prod.outlook.com (2603:10a6:102:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 13:18:51 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 13:18:50 +0000
Message-ID: <c53b4149-fc8c-4357-a881-de07d6ebf7ac@cherry.de>
Date: Wed, 6 Nov 2024 14:18:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add overlay for tiger-haikou
 video-demo adapter
To: Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20241106123758.423584-1-heiko@sntech.de>
 <20241106123758.423584-4-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241106123758.423584-4-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 2172e59d-9d13-4390-11f2-08dcfe658dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkJQaTBoL0F1K0ZHK1A5S1pLNkFFNGY3emF1NWRnNnlydi9ZbTZXNXpYblov?=
 =?utf-8?B?Zy9Obzlmd3NJU0NHc1I2WW5nYWo1Tk5CMUszejNFSmpyVTBWMXRSZThjMHpN?=
 =?utf-8?B?TU5CVGZCSGQ1WUVHT0VaVDVBVVdlbVZzdXRFaVpQTGtpcU91UEFBTXA0SFBV?=
 =?utf-8?B?ZmVUQnJxL0g1RlB6b3Z0aUV2OXFqYUJzcWwvN1hUbHNmQnNEWmh4STRmYXFk?=
 =?utf-8?B?SndGUG1lVmpQQlM1akVJclM1RlhKWk1YejA2eWRnajRJT3JsdUV4eUhUWEFl?=
 =?utf-8?B?Rkp6eVBuWmIvTklYRmZOUS9EdHgvUlhReWhjZk9FU3h6NVoxL1paRmVWQWlI?=
 =?utf-8?B?RU16Q2Z6MTNnbHlzRHZJQldMaytVY3N3N1RRZkxrWnI5N0tWNXMyN0dtOWh1?=
 =?utf-8?B?V0V2cC9Pa1dER0xydkh4d2NJU3F4NE5wcnB2OE5lTjBDMzdkUTRHWVpaOXFu?=
 =?utf-8?B?ZjJvZE5TS1puRU51Z3lSUFAxdU53bytTei9BejFlbGw5S0pqVlA0NS9MeFQx?=
 =?utf-8?B?dHVlSzlneFdFYUVvRzhzRTFUai9JV0RsOXNRWFZ1cGFId3JXamJSTUJuWnpY?=
 =?utf-8?B?N09WR2NaT3VuaXlyd0tUZkNqa0ZJK0dUQ3NTWEk4ZXl1SW5aMkZickpCVnRw?=
 =?utf-8?B?N01wQnFYdjl3N0Uza2h5L0pIOWk5VXg1TndCUUZiVUdkTy9qY2NOZkczU0hz?=
 =?utf-8?B?b0hMWWx0L1I0OVdZQ3BnV01VZC9Dc3JvUmZTVEZPWjc5M0hnbHNWUXlWTzY1?=
 =?utf-8?B?bHZrNytDdFZhaG85UnhzQjV0STFmY3V6MCtZSTlsTFF4V2RCUkxEOVVwdFg3?=
 =?utf-8?B?S0RYQStML3BJUHllVitnVXdRRFJpeWYvODJJYTZzaWVhb2N0RlduUGNLR0Zn?=
 =?utf-8?B?MFJTTlIzbzFlS3VyT2hFWXl4bTZuRUUzdTBZS3pVaUFlZjhXUnNpZzdMQVYy?=
 =?utf-8?B?OHhRdVNiR25uRXFzQnQ0UllMSE1RS3IxdlU5V2htY01wb2J2YW5YMFByV3Zj?=
 =?utf-8?B?OUhJWEhJcDNVVDBRRVlnSkppVjRQWXBYcUZZanZzR1M1RVBXeFppSUZlUDM3?=
 =?utf-8?B?RXZ4MHhoN1d0ZTVOZVJOVDBpamY0ZDBGYVdZdy82SWJ3bUlSK1VyZHMxOEhl?=
 =?utf-8?B?b0F6aERmUEo2djZJT091NldYN3JTZ2ZLalY5Qy9oTzRpdEJUeThqQy9xbTFP?=
 =?utf-8?B?UnQwMG5xNXZlU2ZEQWNpbStrVDBqK0diK2FvNWNqYkpUalhFa2JOQy9FUUxC?=
 =?utf-8?B?NGFCZkJTc0MzTjlreTBOSjFIdjIyS2dhbEgyODB5N1h2cXZOMDNZb2Y3VEdx?=
 =?utf-8?B?NS9XUEFzZ0RqRThQKytnZFkwT1lQRkRPbmtUT0gwd1BlbFJja3kxTngwbTZ1?=
 =?utf-8?B?OEkvL3VLMGJWYjVCV0tOYmNKOUYvdHpwcG1VajdLdkxWL2F4c3NBOW1WazZ3?=
 =?utf-8?B?cnBpWFlqWS9wTE5GOUdPQTRieDJETGxCaTUzandJVmZFc1pwN2pwcVJjRytX?=
 =?utf-8?B?RDQ3Rjkwa3ZLSzg4ajNKUi93RENwdlRPNEM5TFpBanNhYi8rN0VHcHo1Mmlw?=
 =?utf-8?B?WWF3M3grUXZBYnIwTzVlMXJjSHI5YkNFTDF1M2dMdS8rejA0R0VwL3hPb3Vl?=
 =?utf-8?B?NE1EZHhjakIvQk13ZzdSU3RVQ0lESnhSR0xxM3lKcCsrbXNhNnQ1cFkwMng3?=
 =?utf-8?Q?xKlpZa7zR0yoodZZkwr8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDlSZi9ORXp1cDN3dDdqazd2NEFUNCs1czh3ajdxS0o3aTZpZlRpU3F2aGNG?=
 =?utf-8?B?Q2ZWTkxHODRTTklDNG13YlYvVnJXZzZhRDZORU5JRG0zUi96VmMwZGl0dUhV?=
 =?utf-8?B?ZnlmcFFWTFhqZ2ZEdzM4TkVLdE1pVHN6bzkzbEdCR0hVVllzS3NWZjc1ZnJP?=
 =?utf-8?B?WWZzTkNrajRnTTcyS1ltaTBwRlpFeXRCYjI0RGpSbkF1ekh4c3hEeTBpbFJl?=
 =?utf-8?B?UTdKTmRHcDhiS0NVcS9VWlpHRkFHNTdPcGt5TEpzbjNtS3VQVzFRT00xSUJ4?=
 =?utf-8?B?TFNWZTRiN0xEMlFqclFTUlhKZXdpaHlncFRYZTh2NWo3VGFZa2d5bjcxWElk?=
 =?utf-8?B?N3RZanZyNk9uYkk2Z2JDSVhQQzVyYUczYlRUdnNpRWxLMml1U29CNlQvdWlS?=
 =?utf-8?B?Q0JpczRnamwzTVE4UzVVUjNzM0dKK3lpMlJ2My9OSDRDeEVnaU5LWnByZWFp?=
 =?utf-8?B?UHhUNzdUWGZ3cHZPOHdsRVBBMjVPeEd5RHdLN3pGUm9vajY5b2dVWGc3MnZh?=
 =?utf-8?B?V1Ivckh2NjRVTFFmZjJrRnVSQlJLN2xxNnNYK2Y2akkxL1hUMzRBeVdkWDlS?=
 =?utf-8?B?OSt1STlSRG56aTBqazlnZHNvSEhjbGw1ZHFUeXgwWVpVK1lmajNwK3NTUUky?=
 =?utf-8?B?bUxwSVBCQWVldGdrUmVseldKcy9wZmxMN3k3eVdxTk14bS9JaVZ3K1k1UHVj?=
 =?utf-8?B?b3RVOUh6MWlkRWhLclRJdnl6czRQeEtVa2U5UUZTYVFzdlJNcEZDU1p3R0dR?=
 =?utf-8?B?eGduc05JMDRtSnBqTHJVKzVDTU5STEtpeHVDRlBEVGZmQTZxWURTd3E0TTdO?=
 =?utf-8?B?RHRDMThqOUtyd3pVYjJLSjN0ZzRTWHlxSTAxUEh1WE1RRzJtT0RoeG1jTVEy?=
 =?utf-8?B?V2pPWVdpbHR6bUZLcktUdldsaHhzMExGSDh4Qjh6WFB2ck0yVVhUVUlhSUEx?=
 =?utf-8?B?c3QyTkxaZ25KMlYzU0JxVEgzM2pnV0JFTDkzeWRYZ2xBQ3puQzBWSHlicW4w?=
 =?utf-8?B?N012THdFWlFlbS9nQ1Q3NW9SbmF1cXE3WGZoYUY5MFgyTCtpSWhJdzRQZUs3?=
 =?utf-8?B?UXRTczYyblV3WlFBcm1xeUdSNHlxZ3ZGZDU0bkhNUXl3TlVTSS9mRHYwUDda?=
 =?utf-8?B?SUwvQzhIRmczVzVwSFoyTU14RG1pd1B1YzNoaFpqNHhuM1J6RGhqclZIbTUz?=
 =?utf-8?B?SnF5c0lHbGVOblNLQjdXS0QwaER0U2NTMmc0dkNwRXBIdXpmVjgzUnF2YW9u?=
 =?utf-8?B?YXAyaFd0OGk2V2lsOWRJMHlMUy9Ba2tFbldEUkx5WFB2WUVJMlQ3VS9MZXdv?=
 =?utf-8?B?amRyOFBTeGdkdFFiWHRpK1RpVkt1Y2MzRjl5RjJvcEh0eGtpd3pmM2NxMFpM?=
 =?utf-8?B?dVpZUkY1WnZTblgxWlhwMHc4Z2VOZTdKNnVHV2ZTTmsyckJGMzJSbDlEN0ky?=
 =?utf-8?B?U2lmNVhJQXNNZmxHZk5PYXlML2xpY0lTU2krdEVtUndrU2VNdUl2d25ickR1?=
 =?utf-8?B?aG5FWXpXMVlBWnVKdkdYamxsV01wYUh0bnRrclo1S0ZTeis4ajArT2ZLWE1U?=
 =?utf-8?B?N2piUWdhc2Q3S1FjSTA4a1Q3cUxKcXlRNlQ1MFgvN1crWDRBeDFDS0pldUV2?=
 =?utf-8?B?SHRGQlppcnVpMnRGZlJPcVprU0djTGxRMmRvQXM1eW9pV05ueWVuYlVyeS8y?=
 =?utf-8?B?V1NoU2pkTEhabmhWdjNqKzhRZHlEQTdTSnFEZjJadU1ReE5TcldibU1tRGsy?=
 =?utf-8?B?c0VCZG9LOFVYZUpzWWg1VVBJeHJUei9XeE52Z1ZVNnNISGhqNXBGOU1GbElu?=
 =?utf-8?B?MDU1a2dvSjlwSzMxM0tiaHNURVlCaEFlTmJld2Q3Mjg4c21RMzJ0ejNJM1Jq?=
 =?utf-8?B?N2pkVTk1c28yZkNQNGw1VU9maEFXQnZEUEVIVFhNZUFGbjU4aCtTUXJ1ajZB?=
 =?utf-8?B?eXpTVEZNaVY5QjRFK2pqSFNNc0pIblUyRG53aHFCNm1zN0k3c2dZR296RnRs?=
 =?utf-8?B?R2xsbnk1a2s2ckFXNmhUMTRxbDFaOHRESi9LTDZNT1U2cFdwM1l2cWYwMGhh?=
 =?utf-8?B?aTBLbWcyNkdWVXUvVERPbkFZbWpGaEdTUkI5Q1RTZHY0ZnRUaHlKdmR1K1J0?=
 =?utf-8?B?eFRBRnZpNytJak9hV3FwdCsvMkpGS2NBQ3EzTDNWVjNIVElJdVJVSU9STHV5?=
 =?utf-8?Q?L2xsGezY26OMrSmtn3Fstpo=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2172e59d-9d13-4390-11f2-08dcfe658dfc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 13:18:50.8758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8AaEgRisaHGbvMT+AWun/ZhEIxv9DHfNgPwAvQhKQAJJmJHKATGI5Eu15GMpDkfti+OqL8eQGULgnwTGatv/0Iyrhpg5odHMYa4tFKdrqDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7600

Hi Heiko,

On 11/6/24 1:37 PM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> This adds support for the video-demo-adapter for the Haikou devkit with
> Tiger RK3588 SoM.
> 
> The Video Demo adapter is an adapter connected to the fake PCIe slot
> labeled "Video Connector" on the Haikou devkit.
> 
> It's main feature is a Leadtek DSI-display with touchscreen. To drive these

Well that and a camera :)

Maybe we can provide the "official" name of that adapter so people can 
easily find it on our product page?

DEVKIT ADDON CAM-TS-A01
https://embedded.cherry.de/product/development-kit/

> components a number of additional regulators are grouped on the adapter as
> well as a PCA9670 gpio-expander to provide the needed additional gpio-lines.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>   .../rk3588-tiger-haikou-video-demo.dtso       | 153 ++++++++++++++++++
>   2 files changed, 154 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou-video-demo.dtso
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 09423070c992..0c4ee6a767b8 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -143,6 +143,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-ep.dtbo
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-srns.dtbo
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou-video-demo.dtbo
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-toybrick-x0.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-turing-rk1.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-coolpi-4b.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou-video-demo.dtso b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou-video-demo.dtso
> new file mode 100644
> index 000000000000..c7416349e7d5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou-video-demo.dtso
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * DT-overlay for the camera / DSI demo appliance for Haikou boards.
> + * In the flavour for use with a Tiger system-on-module.

Add the official name in the comment here (maybe a link too?).

Aren't we missing a copyright notice here as well (I personally don't 
care :) )?

If so, that would be

Copyright (C) 2024 Cherry Embedded Solutions GmbH

for us.

> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
> +
> +&{/} {
> +	video-adapter-leds {

Please order the register-less-direct-children-nodes-of-root alphabetically.

> +		compatible = "gpio-leds";
> +		status = "okay";

Isn't the default if omitted already "okay"?

> +
> +		video-adapter-led {
> +			color = <LED_COLOR_ID_BLUE>;
> +			gpios = <&pca9670 7 GPIO_ACTIVE_HIGH>;
> +			label = "video-adapter-led";
> +			linux,default-trigger = "none";
> +		};
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		power-supply = <&dc_12v>;
> +		pwms = <&pwm0 0 25000 0>;
> +	};
> +
> +	hdmi-con {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi0_out_con>;
> +			};
> +		};
> +	};
> +

Wrong copy-paste here I guess? No HDMI connector on that adapter :)

> +	vcc1v8_video: regulator-vcc1v8-video {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc1v8-video";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc3v3_baseboard>;
> +	};
> +
> +	vcc2v8_video: regulator-vcc2v8-video {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc2v8-video";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <2800000>;
> +		regulator-max-microvolt = <2800000>;
> +		vin-supply = <&vcc3v3_baseboard>;
> +	};
> +};
> +
> +&dsi0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;

Shouldn't those be in the SoC dtsi? Is there any world where this would 
be different per board?

> +	status = "okay";
> +
> +	panel@0 {
> +		compatible = "leadtek,ltk050h3148w";
> +		reg = <0>;
> +		backlight = <&backlight>;
> +		iovcc-supply = <&vcc1v8_video>;
> +		reset-gpios = <&pca9670 0 GPIO_ACTIVE_LOW>;
> +		vci-supply = <&vcc2v8_video>;
> +
> +		port {
> +			mipi_panel_in: endpoint {
> +				remote-endpoint = <&dsi0_out_panel>;
> +			};
> +		};
> +	};
> +};
> +
> +&dsi0_in {
> +	dsi0_in_vp3: endpoint {
> +		remote-endpoint = <&vp3_out_dsi0>;
> +	};
> +};
> +
> +&dsi0_out {
> +	dsi0_out_panel: endpoint {
> +		remote-endpoint = <&mipi_panel_in>;
> +	};
> +};
> +
> +&i2c6 {
> +	/* OV5675, GT911, DW9714 are limited to 400KHz */
> +	clock-frequency = <400000>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +

Mmmm why the address and size cells properties here? They should already 
be part of the SoC dtsi no?

> +	touchscreen@14 {
> +		compatible = "goodix,gt911";
> +		reg = <0x14>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <RK_PC3 IRQ_TYPE_LEVEL_LOW>;
> +		irq-gpios = <&gpio3 RK_PC3 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&touch_int>;
> +		pinctrl-names = "default";
> +		reset-gpios = <&pca9670 1 GPIO_ACTIVE_HIGH>;

So this is correct because of a cancelling mistake. The driver inverts 
the signal and here we invert it as well. c.f. 
https://lore.kernel.org/linux-rockchip/20221103-upstream-goodix-reset-v3-0-0975809eb183@theobroma-systems.com/

I haven't send a new version yet, I don't really know what should be 
done there. The main pain point being that this is probably a big patch 
that spans multiple maintainer trees at once?

> +		AVDD28-supply = <&vcc2v8_video>;
> +		VDDIO-supply = <&vcc3v3_baseboard>;
> +	};
> +
> +	pca9670: gpio@27 {
> +		compatible = "nxp,pca9670";
> +		reg = <0x27>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +};
> +
> +&mipidcphy0 {
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	touch {
> +		touch_int: touch-int {
> +			rockchip,pins = <3 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&pwm0 {
> +	pinctrl-0 = <&pwm0m1_pins>;
> +	pinctrl-names = "default";

The other two pin muxes for PWM0 are either:
- the pin used for CAN
- the pin routed to an internal component (unexposed to Q7) and used as 
a GPIO

so please move the pinctrl to the Tiger SoM DTSI.

> +	status = "okay";
> +};
> +
> +&vp3 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +

Shouldn't those be in the SoC dtsi?

Cheers,
Quentin

