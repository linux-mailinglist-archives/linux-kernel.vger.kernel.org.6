Return-Path: <linux-kernel+bounces-192719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000BD8D213D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5B928708D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7C1171E7D;
	Tue, 28 May 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="awEHBtw1"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2091.outbound.protection.outlook.com [40.107.15.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E7332C60;
	Tue, 28 May 2024 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912499; cv=fail; b=r8dSVf2XVFO0FvxLLD32vnHBA92F2JhBkJ189+q1h9v5EDvCQGXmC9N8uqP46rkvag+bYhwTsrSEkjpv6k+6nRrThYVav7U/kmpZzA/aL9FSPd/9kEJ/JjXIsKvB+gPqUbsZOn0JPVqscmePFHIaZeTVnd1ueQnbpn2uBCESx64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912499; c=relaxed/simple;
	bh=Z5VeJvAg9/JgmfYDzBmwOTfi1qKfCWZNY7xiyo+f2gw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FqwE5h5sBd3WuSs915nZ3IISJUgVoaqD6aBNaznP6HwPzjiiLOPvFP9AQnC+GdiE0hzdDfEW4OXe88I6KS13K3eRBeM56BGgw4qNn4KCdxXM30P2YmY9XUI/q+MfiZ/cC9/aPH12FUUM1mlwV5mQc+XWuUfHprZHjVPBxuIkCiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=awEHBtw1; arc=fail smtp.client-ip=40.107.15.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7IttFq+6CBlAu00ch5CybTNyFM9KijbfpKeqbPZJ6onm+PRHK8wvUYF8iZ5SANybedZ6lxhHqA92IwRLSNl5agfwjRQI1tDFaJgD8+5Dx3PZvsliMWwZqF5ErW3keisSgx1fTPln3muEQ+XT0nkALJJ/7kJdvEQYQvpldp6lqrmOjPYhGtEMToioUrVML16zAjW87US/aqoMb+OL93u0blYTEfTDWLj0dFt74y1u4jFruj+f/iPA0nGiVUGLXLhR0P6A0KmXMc5wLNHHPBzmZfMke02g7JJyugzqhxi2ZgL4+qhRyIwGxYYgzgEVWEUXM3V41ZtL+SQpRgdkvBw7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSG8Anr5bL/JthjCUMGIktzIGlDBGYXVK6IoFyfJDtU=;
 b=VmAKuPP7btMZ0ZvkfLUVgsAWCf6XTUsAucumyw6TwWaqsvKoXyYiWjyPXHGavK172yV8JPG87YPm6u2T+XWC53GPMQLfH2K5zMS16zJY3QRLE1vpxdeIOVCWhW3EJjCnfa9iIRS1BJ7a2uVcYZoc1kHNSuQcLyFCAxBGp6MeBWVJK1gyrKqkt/dDF5yYcRezXaeLNVZqfVhJWe9rDf6yJx+iVyfcmMmCjJuTuqTWsKswxVq0uHHLENFlsv6VJ3YSLPtDcgPzZjV0n0tA39ZbOGvH7qfQF7De0EvNzNGauCkD+n6v3FllIvPEtAEfXReFOqMI/xwhMDHnwqbf3t54Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSG8Anr5bL/JthjCUMGIktzIGlDBGYXVK6IoFyfJDtU=;
 b=awEHBtw1HWAypmudIgPdjvN11nq2e6gQz7vnNY1dI6WRFKpvE15u75sYDtyjpsjO+2/VtVlRD5E2D6/KGxwttRRJS2OlUg0MupNiDUfnEzOTTJeN8UBH+uzAe1lPQnIpb6J1yll0CTa1is/j1T8tV0TAciboWvOH5yfXfUCBQWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7980.eurprd04.prod.outlook.com (2603:10a6:10:1f0::12)
 by AM0PR04MB6964.eurprd04.prod.outlook.com (2603:10a6:208:18a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 16:08:10 +0000
Received: from DBBPR04MB7980.eurprd04.prod.outlook.com
 ([fe80::bea5:77ec:cc32:e52c]) by DBBPR04MB7980.eurprd04.prod.outlook.com
 ([fe80::bea5:77ec:cc32:e52c%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 16:08:08 +0000
Message-ID: <646a33e0-5c1b-471c-8183-2c0df40ea51a@cherry.de>
Date: Tue, 28 May 2024 18:08:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] RK3588 and Rock 5B dts additions: thermal, OPP and
 fan
To: Alexey Charkov <alchark@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Chen-Yu Tsai <wens@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Diederik de Haas <didi.debian@cknow.org>, Dragan Simic <dsimic@manjaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <5122636.irdbgypaU6@phil> <8727e1c29bd6f562a7fc3de0ddac62cf@manjaro.org>
 <6230150.aeNJFYEL58@phil>
 <CABjd4YyRJS0AGehuBTDn8ys9uRRkGc0Usme3GX1POq3AQiWTBA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CABjd4YyRJS0AGehuBTDn8ys9uRRkGc0Usme3GX1POq3AQiWTBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P194CA0041.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::30) To DBBPR04MB7980.eurprd04.prod.outlook.com
 (2603:10a6:10:1f0::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7980:EE_|AM0PR04MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: a715dc6d-68e3-4dc3-38c2-08dc7f305daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTdTQ3YrVVBtT1hpRi8yWmhCaGY4eUZiRTVwWUtRYktHZnZFMWswRDFKRmRx?=
 =?utf-8?B?Y1FHR0FVdzJqRU5HbTdEdWtmLzN0bFBGTmJJZjlTSDQwaHlsWjZxNGc0SXJo?=
 =?utf-8?B?eUswOXROUDBTNGIzMGczSHV4VDBRalJ0TEZ4RXpmMGlYMWdMNk9OVk11NWpN?=
 =?utf-8?B?c25IUFVKNHZGTUVBU2xDWWY1UnFub01TZVQyeUlidU5hOEd0d01HNlJCYmdK?=
 =?utf-8?B?aWxtSDFvMy8vWlJOVzZXNnFlelA5L0pkUm8rUXB2L0NxNFNvQjBEcSsxMVdh?=
 =?utf-8?B?cVR4OGxEZzJCTHdqaXFMemo2U1pCSFhFTTFIZGR0NzY2U0VQdEQ4a1Q1QnJI?=
 =?utf-8?B?YUZFZ0NnendYKzVlVWhKWU9JMTgvZmZRSDAwR294TVFqbS8xUEpEdnp2UVpa?=
 =?utf-8?B?RWVDV3ZKV1RjcVJKQ0hqeCtMVkVvb0haYzg2NW9KUkwvZEJOS2JUeUpzMTlw?=
 =?utf-8?B?V24yMUV0RG13dm1jMUFHT3JvM1NReHRiNzUwTzBwcE9wR3dOaGV4L08xN3Z4?=
 =?utf-8?B?RXQ5WTFUZmVGZzRsRDk3TmEwdnRyUG1yT0U4VEV5YnlxejVQOGx5WXhKSDdi?=
 =?utf-8?B?cC9KaTl6SFl2RXd2WW10T2xNV3RMTTdBZnlISk4zc205YkJ6cjRLZ1h1cEgw?=
 =?utf-8?B?NC9BVnVsSFlSVDFteTR6WlpwS2JwdU5pSHh3OVAzZkFsTXBWOFlkbitPMER5?=
 =?utf-8?B?KzVPZnljSWR0eUE0VzZRZXJmTVg0Q201TWhDcWpUbFVJTm9LSlRtejlEZ2g4?=
 =?utf-8?B?Tmpla0NlU0RtZkgwUlZ4TGRxa0JhZVNnTjVaOVRyQ1hIUnJ4dEU0d2xGTGhD?=
 =?utf-8?B?QTNwSDQ4cjl5WWFacEpFd0FvOE5mSUNmTWpHVjgyTWE3TzRQcURENXpDNFJK?=
 =?utf-8?B?MEZxTzJBbk9jaTRxcHpWam9wT25tcVpST2g1VitmUGdsc3NIeUlERXV2cjds?=
 =?utf-8?B?bmdlNHM3TENLcE5Sc1ZMUENpNXlaNlljM0Y0ZFNVKzVQTHlHeC82YzlxSlFV?=
 =?utf-8?B?Q3RpZENXc0g2dXVQWUczc1hOcGk5UmJ3M0J5Ymp3eUxadmZ1NmxyY1d2YThQ?=
 =?utf-8?B?UlMxQjBBeUdJV3lBYmpFTHFBNkY5UURPSCtiSm03UHRCb0c2L0xPcUJCYi9R?=
 =?utf-8?B?VmFzOHNhUVZlN3ZxNW5EeFhEMWVpY0wwT2Jua3NXbFBqMnB1Y0Y5TDkwN3Zy?=
 =?utf-8?B?MUFSaFl3WlpYelMyOXg4Uk5DTi9PcnpuRzNpeGdPRm1jK3k4ZG1lWWRySEV2?=
 =?utf-8?B?bDQzNWZST29sT0tSSDQ0bUR6bi9LNU1qQWlxN1NyejBFMzFDUGlxZldheVpX?=
 =?utf-8?B?MHltTHo0a1kzZndlWlhpa2p3NStZNjB5cEJzRmhtMXM1WXdRcU9aajY0Mkx6?=
 =?utf-8?B?MFptS0ZuVUlQK2M0S29QSDkwOGgyeHVFVkpHWThsVEhDemFjOW0xLzlQVmto?=
 =?utf-8?B?VThjSjY3ZHdjN3NiU1p5Y1BZaldPb2FoOXdFSE5NNUozQThkQjV6NEord05s?=
 =?utf-8?B?bFhDaGQxcUhUQ0J2YW1ZcVJDZzdxakllOWpSQlB3NE1QNGhpUlpadnYzc1lr?=
 =?utf-8?B?V2FXZVVIKzlnSmNwdWJXZE4yK2FHSHhUUnBsOG81SEg1OEtpTnlweEdZY0xq?=
 =?utf-8?Q?3DdbHUc2oVBf+dzf0+MNHF8G3Lub2U/RI6GKlZMsAx7o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7980.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE1PdTdYUUlpcjdONGlRait6UzlUeC9XY3M0d2FVREU5dmZMWXc0WGxOdW1M?=
 =?utf-8?B?d2cyVTZKRWl2dithTzJYZnFkMlI2MG1NajZFZXNTK1JFR3l0ZzM5Q21sYmoy?=
 =?utf-8?B?b1RYWFRob2wzaldHNXZjdGFnc0hCZjE4ZTk0NjU4UWxkdDI4WXIrNWo2VWZx?=
 =?utf-8?B?SzQrbktHTGxZSDdPNFZZcXFNbnM5dmI4Y2lIbjdHaWxRbXlwVDBMcHRFdzRV?=
 =?utf-8?B?UXowZ0RqWnZRSHdzSXc0QUgyS1ZhU3FVWVlQdlhnLzR2QlRqSEFUM1gxMGtK?=
 =?utf-8?B?WEJVbWhlajM1bWN4RGcvaVVoMElBNTZtRkZwc1YrOUxLeW02aGhHUXMvS21V?=
 =?utf-8?B?YmZRNFZOUUhNTjdkbHE0MWVTME1tcWJQejE4OEVEM2t4dm9TQ21aWklhODEw?=
 =?utf-8?B?VmFiaWM3VVBCVkxRNndpWXBIWC81WlpOLzBHa1pZcm9ib3lKd2RvQkFFT1lj?=
 =?utf-8?B?SkVING1DS0FwTmZRVHVBVzJvcTBVdjZzcElHMC9aSzB4YXNjUU5sbXZqKzNj?=
 =?utf-8?B?a1g5Nyt1L3kzT0k2ZklGdUhXL1RBYnF3cm9nKzJvcEw2eCtNcHFtZFlsMXhK?=
 =?utf-8?B?eGFqOE9rcHRvMHRjb3dPd1FtcDNyWlRRNEJMeVFCdGJSVGJlcjRaVkl6eUs0?=
 =?utf-8?B?NU5kNjRnemZtbmZ2ZjVpaXpmZSt2ZVlOTzVoTENFckhjZjRlbkRRNDd2NTdj?=
 =?utf-8?B?RHNPQ2N3Y0dJUE80NWl2YlZDQnR1c3BqZWMwTFdkd0ZuRGt3cU50SnFUenBZ?=
 =?utf-8?B?MXdqdUFoSlVkQTJUY3dBdU5pbUNHb2ZhWmIzTUdhdS9Tei9uU1ByZWROQVk0?=
 =?utf-8?B?cU00NjFleWp4R2tVajJKUkNuNEFjQWNYS0xhVy9KWTVURDlBOFg3YWNLSE5H?=
 =?utf-8?B?WmNTQ0kvNDlZNUJJWkhEc2puMW5oams0WWt6TitBZmNzUDd6SUdlU1NtcmUw?=
 =?utf-8?B?eER5TVduaExMOWNpTTlMOUNYekdYKzZyWnBVVXk2K2UvTSttK2I2M1dQam5o?=
 =?utf-8?B?NUJ0UmxRSzFpdGsyOUtWQ0RGOG1ldVgyUG9XZXVLSXVvRDg5TXc1cCtTNlJ6?=
 =?utf-8?B?T0FzTDVxQkZ4NGE4NHFyc3FjbHh4MEthRW1UWFBLV0NGVG10TzVIeUtlOHlz?=
 =?utf-8?B?aCtFeDR5RXMvWVRNS3M0ajFnMmNHWHlDSGRjRC90SnM4WU1SK3R5U2xTdEx0?=
 =?utf-8?B?OWFlVHM1UjNrNURPeVBLMjYxRGJUeDB3N1JKU3BxdlMrSVEreWhZVk1QTUJa?=
 =?utf-8?B?UUpKUFZlOW1idi9WTGlmT1hNR05Yb3lGc3BCbnV1bkJNRlY5cXdOTmNLNzVJ?=
 =?utf-8?B?cW54bDQ2M3JNREhZS2hNamdZejVDb25kY24zdUNPeURoSjRHQzdiazNqVDFw?=
 =?utf-8?B?bWlpNTdINXJNbnZuU0k2TVg1OEVhbUV1dG5QakFhb1lEaXRSQktqU2MwYXc2?=
 =?utf-8?B?VzlHazR1Mk5pNk9FdnZrZXN1T1M4Z0NmQ3ZXbWpQV3BLOXdCb0FXN1hPNE1a?=
 =?utf-8?B?SWk2U0xpQTZYdnRiMDg5VStIdmFhQU9wV3h1VEppUVJ3MU5CRDVpQUV3bGQw?=
 =?utf-8?B?ZnN2UTBTVVVjY2NZYlgxT0lIZnAzeEFxWlhxNVlHVUZoUWE0eUsvY2hCN095?=
 =?utf-8?B?VDkydUhUbklHVjFaTGNKS3EvZ29HNnJmWGtzS055QllQcUFLa0hYZmNiKzZW?=
 =?utf-8?B?OENDUmNaTk1tQk5RdGh5V254ZW9mcHg4dTI2MHMwY3J0dGRIUFA5NzU1bTVl?=
 =?utf-8?B?a3piUmxKaE8wRlZIR2phc2RkdndqVG9RQTlkak5Bd1k2MG53T3A5eGdsNzNr?=
 =?utf-8?B?QTZFbzZIdGlEc3g5R2RsdGNlR0lVSmtmZi8xV3VoWkV5VGJnMHJaa1o4Rjcz?=
 =?utf-8?B?RW1xTDVzMm4rOEZIU0c4Z01lV0lzb3ltcUFFL2I2cnZkYnpTMyt0dGFrd1lV?=
 =?utf-8?B?WUJGYlREaGtLcCtBSS9yTHRmRnp3Y1ZXcjdNUy9VTStnV0l2a29ZRVphck1G?=
 =?utf-8?B?djJMM3E3VlFldUFuT3Z0VDVyZ3dxSUc4NDFKR0RQNm95SlNRY1R4UWREZzdh?=
 =?utf-8?B?a3c3Q0Z2dDlSZGdlc0JBT1ljTnJpbWMvU2hONURvN04xMVA4NFp3OFFSUmp1?=
 =?utf-8?B?aUNoT0p3TVZ5cm94N1AvYWtOZktrTDV3OTRPcHhlNHk4ODI4elc0aWlkYjAw?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a715dc6d-68e3-4dc3-38c2-08dc7f305daf
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7980.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 16:08:08.7955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DnjnalDj/RWWBUXSAMbArmncIFiCFJyaRk3XpbSEHs0mp5iEYcUQ0sZfHbtHvWgHjj0+6oPRTOWWHcMc3/wA1BuTvAV4YceS73QKhLsq1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6964

Hi all,

On 5/28/24 5:42 PM, Alexey Charkov wrote:
> On Tue, 28 May 2024 at 19:16, Heiko Stuebner <heiko@sntech.de> wrote:
> 
>> Am Dienstag, 28. Mai 2024, 17:01:48 CEST schrieb Dragan Simic:
>>> On 2024-05-28 16:34, Heiko Stuebner wrote:
>>>> Am Dienstag, 28. Mai 2024, 16:05:04 CEST schrieb Dragan Simic:
>>>>> On 2024-05-28 11:49, Alexey Charkov wrote:
>>>>>> On Mon, May 6, 2024 at 1:37 PM Alexey Charkov <alchark@gmail.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> This enables thermal monitoring and CPU DVFS on RK3588(s), as well
>> as
>>>>>>> active cooling on Radxa Rock 5B via the provided PWM fan.
>>>>>>>
>>>>>>> Some RK3588 boards use separate regulators to supply CPUs and their
>>>>>>> respective memory interfaces, so this is handled by coupling those
>>>>>>> regulators in affected boards' device trees to ensure that their
>>>>>>> voltage is adjusted in step.
>>>>>>>
>>>>>>> This also enables the built-in thermal sensor (TSADC) for all
>> boards
>>>>>>> that don't currently have it enabled, using the default CRU based
>>>>>>> emergency thermal reset. This default configuration only uses
>> on-SoC
>>>>>>> devices and doesn't rely on any external wiring, thus it should
>> work
>>>>>>> for all devices (tested only on Rock 5B though).
>>>>>>>
>>>>>>> The boards that have TSADC_SHUT signal wired to the PMIC reset line
>>>>>>> can choose to override the default reset logic in favour of GPIO
>>>>>>> driven (PMIC assisted) reset, but in my testing it didn't work on
>>>>>>> Radxa Rock 5B - maybe I'm reading the schematic wrong and it
>> doesn't
>>>>>>> support PMIC assisted reset after all.
>>>>>>>
>>>>>>> Fan control on Rock 5B has been split into two intervals: let it
>> spin
>>>>>>> at the minimum cooling state between 55C and 65C, and then
>> accelerate
>>>>>>> if the system crosses the 65C mark - thanks to Dragan for
>> suggesting.
>>>>>>> This lets some cooling setups with beefier heatsinks and/or larger
>>>>>>> fan fins to stay in the quietest non-zero fan state while still
>>>>>>> gaining potential benefits from the airflow it generates, and
>>>>>>> possibly avoiding noisy speeds altogether for some workloads.
>>>>>>>
>>>>>>> OPPs help actually scale CPU frequencies up and down for both
>> cooling
>>>>>>> and performance - tested on Rock 5B under varied loads. I've
>> dropped
>>>>>>> those OPPs that cause frequency reductions without accompanying
>>>>>>> decrease
>>>>>>> in CPU voltage, as they don't seem to be adding much benefit in
>> day to
>>>>>>> day use, while the kernel log gets a number of "OPP is inefficient"
>>>>>>> lines.
>>>>>>>
>>>>>>> Note that this submission doesn't touch the SRAM read margin
>> updates
>>>>>>> or
>>>>>>> the OPP calibration based on silicon quality which the downstream
>>>>>>> driver
>>>>>>> does and which were mentioned in [1]. It works as it is (also
>>>>>>> confirmed by
>>>>>>> Sebastian in his follow-up message [2]), and it is stable in my
>>>>>>> testing on
>>>>>>> Rock 5B, so it sounds better to merge a simple version first and
>> then
>>>>>>> extend when/if required.
>>>>>>>
>>>>>>> [1]
>>>>>>>
>> https://lore.kernel.org/linux-rockchip/CABjd4YzTL=5S7cS8ACNAYVa730WA3iGd5L_wP1Vn9=f83RCORA@mail.gmail.com/
>>>>>>> [2]
>>>>>>>
>> https://lore.kernel.org/linux-rockchip/pkyne4g2cln27dcdu3jm7bqdqpmd2kwkbguiolmozntjuiajrb@gvq4nupzna4o/
>>>>>>>
>>>>>>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>>>>>>> ---
>>>>>>
>>>>>> Hi Heiko,
>>>>>>
>>>>>> Do you think this can be merged for 6.11? Looks like there hasn't
>> been
>>>>>> any new feedback in a while, and it would be good to have frequency
>>>>>> scaling in place for RK3588.
>>>>>>
>>>>>> Please let me know if you have any reservations or if we need any
>>>>>> broader discussion.
>>>>
>>>> not really reservations, more like there was still discussion going on
>>>> around the OPPs. Meanwhile we had more discussions regarding the whole
>>>> speed binning Rockchip seems to do for rk3588 variants.
>>>>
>>>> And waiting for the testing Dragan wanted to do ;-) .
>>>
>>> I'm sorry for the delays.
>>
>> Was definitly _not_ meant as blame ;-) .
>>
>> The series has just too many discussions threads to unravel on half
>> an afternoon.
> 
> 
> FWIW, I think the latest exchange we had with Quentin regarding the OPPs
> concluded in “false alarm”, given that this version of the series only
> introduces a subset of them which should apply to all RK3588(s)
> 

Correct.

However... I'm wondering if we shouldn't somehow follow the same pattern 
we have used for the rk3399 OPPs? We have a file for the "true" RK3399 
OPPs, then the OP1 variant and the RK3399T.

We already know there are a few variants of RK3588 with different OPPs: 
RK3588(S/S2?), RK3588J and RK3588M. I wouldn't be surprised if the 
RK3582 (though this one has already one big cluster (or two big cores) 
fewer than RK3588) has different OPPs as well?

So. We have already discussed that the OPPs in that patch are valid for 
RK3588(S) but they aren't for the other variants.

In the downstream kernel, any OPP whose opp-supported-hw has a first 
value masked by BIT(1) return non-0 is supported by RK3588M. In the 
downstream kernel, any OPP whose opp-supported-hw has a first value 
masked by BIT(2) return non-0 is supported by RK3588J.

This means that, for LITTLE clusters:
- opp-1608000000 not supported on RK3588J
- opp-1704000000 only supported on RK3588M (but already absent in this 
patch series)
- opp-1800000000 only supported on RK3588(S), not RK3588J nor RK3588M

For big clusters:
- opp-1800000000 not supported on RK3588J
- opp-2016000000 not supported on RK3588J
- opp-2208000000 only supported on RK3588(S), not RK3588J nor RK3588M
- opp-2256000000 only supported on RK3588(S), not RK3588J nor RK3588M
- opp-2304000000 only supported on RK3588(S), not RK3588J nor RK3588M
- opp-2352000000 only supported on RK3588(S), not RK3588J nor RK3588M
- opp-2400000000 only supported on RK3588(S), not RK3588J nor RK3588M

This is somehow also enforced in downstream kernel by removing the OPP 
nodes directly (hence, not even requiring the check of opp-supported-hw 
value), c.f.:
https://git.theobroma-systems.com/tiger-linux.git/tree/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
https://git.theobroma-systems.com/tiger-linux.git/tree/arch/arm64/boot/dts/rockchip/rk3588m.dtsi

You'll not that the RK3588J also has less OPPs for the GPU and NPU (but 
those should also be masked by the opp-supported-hw value).

Cheers,
Quentin

