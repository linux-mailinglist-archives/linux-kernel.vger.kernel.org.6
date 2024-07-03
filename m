Return-Path: <linux-kernel+bounces-239751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE869264F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B09283BE8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C530181309;
	Wed,  3 Jul 2024 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="RxnZOft9"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2106.outbound.protection.outlook.com [40.107.21.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0D3181D17;
	Wed,  3 Jul 2024 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720020889; cv=fail; b=ZsWp0tTjrHkrzlYT2V9vHpL2aEA0W71ItUu+Sw11gTd4lNEqpSIGzjSxIl7bctLuB9CenuJ3OGyFoI0JMRbJW3CZApWpIqU5fLVsYnY31UozjMETk+QtAOL0ncckBnWVytksM/Qf7CuE4pwEqhQIE+X75mcrz+H8YXUsQtRHPEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720020889; c=relaxed/simple;
	bh=mky/3WRlt1IkKl9dhPhysDkWT5jla+ByQG7qQhhIE7c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QBPudvgMQoOZpO9Je6kajyg4hCTpzCIWyyIoflFU2OAG7ilhw606O2Yt8ckzjd80IPMNUmH/Tz9IM6nhAhctCQZG+cne/pLD6n10KmK1ZppW2xuKxk83E0/Tnm37beqVcuaTaoBBJnOi/nFFcg2qo46YBmeKp4VGmnhLs6k3xCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=RxnZOft9; arc=fail smtp.client-ip=40.107.21.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWJK+jp2MOGj3bozAWCx/rSC6JIky6Wx/NcbImqDzWjgcJGDjiODxsYy+vHNHsM0UsVI5uH24ka9aXnn1SjF5pg7ruuFMZX2CxzVz4fA8m1L3DTjX8uEYlNpqyTt/SeWUB2tf50S5SzYraaKxZ5ND2DJFtUrNWvJ47BJewv3Tn+RM3NU6RtTTvmfemn/XFh3rrO8eTOp0l7n0ZHoaA/SAI98FVfTJNitFmcTAgMuBOi9y9T+/Ix1WcGJ7lSsFuOlqEdSxIW/FyY6LYgkmzZobjtKCqveiE8Y+GH8qjP2WntvvgAPuS6KA4jsN1lIW+FJ7XDQTUVIfauF/O6PInRFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCcZvs6eei7B5KiUFdFQ0JvP4JMsNqOOA55fO3exFFQ=;
 b=kdTP6adzkDrEZ6VnsAo7QWMtV7VnY/P52tnNscKRZwbi3Y/debQAoBiAR5l46DdR8mMcZ0iKQCdoQe1jrA0AoWodEmSLbuC8OkfSXKg1186dQofxip+9f4KXfJoKVlJ/T6orUeeZY9sAL7Zm9xKPdGH36ftLWAwjKoyuxB4JlDkgmwW1A5sR0Ol45WvNfK56AbuAwy8rOSYr4g8wZB+HkOBFwt6rIEx8vFKrM8lDumsu4ef+ipSaXNYSG8Z+WOg0NgCrn++yzrbt0EqrHL6H1SMeHwhHyAY33/S8awjfGQv67GauU1sNIpZ/t4gRoRAjT706Wd6XmkmJALG25+8KPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCcZvs6eei7B5KiUFdFQ0JvP4JMsNqOOA55fO3exFFQ=;
 b=RxnZOft9xZrHZonUHSFnzl179PyCjwZ6yRabZsW2yUu3z7Tk17vwaogT4XaWqHUpacLsLGeT08C5OrHYRuKUSg+CgHU9bBy/WP6HHfkDDUdfo/HUVv4kGKrRMdQpw6Dih4EqffGrUdGuOXrmTdVxYL5GBmYtIW3Ln7k/myeIfRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PAWPR04MB9986.eurprd04.prod.outlook.com (2603:10a6:102:380::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 3 Jul
 2024 15:34:43 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 15:34:43 +0000
Message-ID: <1618cf03-f1ea-4fd0-99ab-2c6413601e61@cherry.de>
Date: Wed, 3 Jul 2024 17:34:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] hwmon: (amc6821) Convert to with_info API
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240701212348.1670617-1-linux@roeck-us.net>
 <20240701212348.1670617-11-linux@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240701212348.1670617-11-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0018.eurprd02.prod.outlook.com
 (2603:10a6:803:14::31) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PAWPR04MB9986:EE_
X-MS-Office365-Filtering-Correlation-Id: bd5aa058-294a-4415-4c9e-08dc9b75a8cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXdMZVcrUDk5T3FSWDNyby9nN2RHQWNqd0JKOWVRTmVKYXV5d01tcGNwTGtC?=
 =?utf-8?B?VHZFR1V6bVRhZU94WUR1WnE3TWQrVlFCdkp5R0pnd2xOUXpSWWY3T29yUi82?=
 =?utf-8?B?d3NZNGJNWUtwTWxwM1pDdGxacU1lT3h6RUxYWGM2NUxBeXEwWjNHRmFpaWly?=
 =?utf-8?B?V2czcEExMVlIQitLZXlqcEV0YUNpWk04MUQwUnQ3THllNnZtbjZDeXEwR0hB?=
 =?utf-8?B?clVSNi82NE1TQUd5MmdyUGtYc2w5UWZJcTZBYnRuOXhqR0dUVXg1MFhsaXA5?=
 =?utf-8?B?UE93REZhMWZuYlZ6TnV4WFV3TXhkbU03bWRZRFVpRWpkOEM5YXE2d2N0ck5M?=
 =?utf-8?B?Zms3ZU9Pc0N6Y1dINHFSUTJkL1BQdUNUcGJibEJBK09uWU04L2VPZ3Q2M1Uv?=
 =?utf-8?B?VWcyOXdZMGxnZEFHNTh4WkxNNFU1OGNWMG85SHcvWXI2MHZjZlhuT0R5L25j?=
 =?utf-8?B?TzB3Zk1oMG82elZNNmIzbzBFK09iazN6RFFDZ1E4Uk1ObXZJLytwU0xUZFlX?=
 =?utf-8?B?RGlFK3VlSnRvNDluajNRMW9Db29IVHFtZVBlNE82TnNETDlpSnBhd1I4SUl6?=
 =?utf-8?B?VTVJKzI1VjBuT0E0VkhoZitoT1lnK0lFT0k4WlNYSlpVSk9NVXJReVhwTTE4?=
 =?utf-8?B?aVYwaWRIWXZBWWFGQ0RkWmFIZG44OENPcVIyU3V0eW5wZ3lqWXZKcDF3WWlO?=
 =?utf-8?B?dWFaZVRrbER5bGczQ3JqVXNLQlI4WHp4U0EvaGlnSlU5eWtpTUZlUVhyak5S?=
 =?utf-8?B?OHJRSXFiL0k3S1BhN2ZDWFNWYmt4ZE9VOW9hVXdDeFhyZmNrbFBVK0FBbEMr?=
 =?utf-8?B?QTA2NTdtbllISVJUSjlscm0zOVJZVGRuYWRMcE9DZ0FGaEYraDAxUzQwQWJG?=
 =?utf-8?B?dTFjYmk1SEo1TStwTXR1S3RKMGZxdXlaSlF3eVFoS2k4T0VBWjliY1hrSU9J?=
 =?utf-8?B?akNKdGpBOE5ONm8zc1ZzSDhXV0NtM2x4eERHU1N3a1o1QStWa1pkSit2b3BO?=
 =?utf-8?B?alFYeHgzUlF2cTFheDRUZldZZmFabitWRWxqaDJSVGJRejFmWEd5aHFzZ0xN?=
 =?utf-8?B?OVlBdG96a29ISXVTUUQwckRROC9kUEVxS0Q4bGt1bnZGUWp6WERDNEdmbGV2?=
 =?utf-8?B?RERlYTY5cXpoaS8zM0RVYzFDRUpwT1hQMnBHL1ZXWnRjcmdHZ0RaV0ZaK25F?=
 =?utf-8?B?b2Rtd1F3cVFGSUJvZ0dtS1VHZnNMRDh0SXFFZXdsUUVUK2ZjQVNrTGp2VjRj?=
 =?utf-8?B?blhsYXJQdDNiT2xKbFJrNjdrUUt6MGhjTVRVbldmR2xmVEZPVTRiOHp4R01E?=
 =?utf-8?B?akQxN1Myb24vSGpacXl4Z0dqYkM5R09lenlCbDM2OG5pdDJ0VnVRMVJmelNn?=
 =?utf-8?B?Z3MrYWxXdVgwYnlqZ0dnMjczYm5XMHNIR3I5SkxwNm1uWmk0NlJxOVJCcytx?=
 =?utf-8?B?YmkrNDBvaHV0N3NWbEdSZ3ZFVUFpT1BxUXV1RlNsaUVnTFFnd1RieFJVL2RZ?=
 =?utf-8?B?RzdxK0h3YW9xY2xJSXVjWGhBcUNMcG1qME9pdk5semJMa1NWS3FGU2lYbnBw?=
 =?utf-8?B?REFMZTZqelhVSVhvTXhwbVdFZng1UzJtczV2RkVFRUI2aWJVWjZVZ2htNjI0?=
 =?utf-8?B?TVA3bWdCZXpmUkpDSWJNN3lqcFVlT0gvTFVKQWJhcDhaRkNDNkpVSW9Gdk1I?=
 =?utf-8?B?OHFCU2w5MmxvQnllRDd0M09qREh6cHFhSXYrblFJTnBaSEd6TUNCZFNPWFpu?=
 =?utf-8?B?TFY3MkFUWEl4RGJOTHdtZFV6YnYrMEJvaHU5dk1meERmMm45K29ab0tLaFVP?=
 =?utf-8?B?aEtnNzl5RmFvb0dhbHdCUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2Qya0RKUi9uWE9LSmRZZGIyQnc2MkpBdjdVckhFaXB2NFpRdTFLdXdwOXJs?=
 =?utf-8?B?RlFXZVkycHlRKzhHT25PMjg3WmRnc0o4ZFZtZ3B4RFFuUDdNNmlLT29BNWRv?=
 =?utf-8?B?UlNrVW9kazgxOHJ4YXg2SFZOK0RFRVhQanA1bEhrSEI5czFrL0E2Qm9kd1ls?=
 =?utf-8?B?NjM4T0svMkppeHlpV3FmL1Zod3RKK3JxeHRuSGxGZnBvZitTMmJ3ZUpIRkFL?=
 =?utf-8?B?UkRUY1Nrb0RVNXJXQzVoazBqT1BTWkVsaWhmNytxUWhoRUdiMDV3cVRoMnRC?=
 =?utf-8?B?SW9RTTR0VDJ3VSswYXhiWkNhZkdTZHZwa2VPL0MzbDZBdDdIM1NmRDd0TFcv?=
 =?utf-8?B?Z3NxUmlRSk84T2lzZy9zNVltZUM4ZHFtUE9KeERvVVQvSytMRUpiME14eWRI?=
 =?utf-8?B?MXk0bityWTNvc3JldG1yak9SNTRaWDlkL0lWNmFwNHdnTGlSdHk4NGNhcmFI?=
 =?utf-8?B?Zzgwc1ZBMWcwVWZxSGovOURabWRoaVR4R2dUbVB2bmhKVE9IRTU4eVBMbmhB?=
 =?utf-8?B?N2o1RnZFL09LVVlPQzdVSDFPbUorRlhicWFsR003OUdNU051Z0gzSDNiZkcy?=
 =?utf-8?B?N05kcWZ2T0FNM0xucmRDbFpnTDZlOExFRUdFeU9qb1ZMVXR4enUvdnFKNGpj?=
 =?utf-8?B?RHJ0aUxuT1RSUURDMDY0ZG5pNXVYOVZhSjZPTk1qTVFDUm1WTjlQYlRNMHgr?=
 =?utf-8?B?aFJBRUphVHVKdytneDdTMXNYei9MU1NvTjk3N05OaUVZY3VVWlEwejBndTE4?=
 =?utf-8?B?Y0JsdnNKMkdiOXc5cjFHMDFSQXRpTkx5NHkyV3B5aElnVHRBQlhXV0lDNGJ3?=
 =?utf-8?B?Y3YxOHFSRFJ3OG9CSERxNHVOTzdtbzJBRWI1a00wamtCTW9ELzhzREh1VE5Y?=
 =?utf-8?B?a1dEaENSWnRid3ZFVE82VSs4QzhBc09NYk8yVnd4SHgreWU1eXowdFdKVVJq?=
 =?utf-8?B?c1FESm81U1JLeko3dFZ2ZzI1L01Hd0pYcDBPVmk3Z1loSkNPdWhubXJoZWNM?=
 =?utf-8?B?RE5pWWhUdVdEMytPUC8zVzBxY1daK1dpeE9yY1Y0Yy9DZ3lESFhwU1hjbGUz?=
 =?utf-8?B?Y0QyNFFoZldGc05kNU9xSHZYT0Z3ZjU2MStkRTRNSk5FWHBZMnYxOVBTZ2Ru?=
 =?utf-8?B?Qk1iK2o0QVdUSmRaUW4xSVNZODZuSFlkd2MxbFNVNG5lc2RpTzFjUVJuK1NR?=
 =?utf-8?B?ZHl6M0dZZzJaSXJBNTBXamhwNEJmZmovbWlPNkp3bTJpNWNqNnozRHZ6RU1z?=
 =?utf-8?B?NDNCZmJYSFdabW5BeXZTMWhPNGNFL3hSUE1RczRXRzBiRW42ektFKzRTa1pr?=
 =?utf-8?B?a0VNU0k0NlU5ZnA0SHh4UDlYWTlUWHZWVmZJU2ZCSlRkeEdubHpabEwyRlVp?=
 =?utf-8?B?U0pna1FOd2RuK0xiQ25mbEdPSkMrazZ0OHlaU2xqZjU1QVI2czNReWJVSnE4?=
 =?utf-8?B?K0VhTVBrSDlkbGNKejlVbFg0MlRobnh4L2NwbWFLb1NuaUdnNUI5UXdpK1Q0?=
 =?utf-8?B?YjNJWGE4MTFhUXUvUkxFMG1ySk1sUVFXdVUzeFdNWDB3ZmJxcllvR21kYjFm?=
 =?utf-8?B?SmozMldMaXNYdUZMS1M4TjRVTmJ5RGJXQk0rNzBtaWxYYnZxUm91WDFWbERN?=
 =?utf-8?B?a09sSVZ6TUVpNUNzL3JZWldKZGFtMzBXUXI4Z0dUdHR3N0g3SlpEc04zV0J2?=
 =?utf-8?B?SUVMRCtod0V0b0xPNjNaSWFIeXNqZ3R1NlBIL2VIcXFDQitBVEM0K2kxSmZZ?=
 =?utf-8?B?ZmZiYWlwZjJHTVI1NjRhTEYxa28veFo0bEhDUzBWcmY3aUxNOXo1VWRFb2Z2?=
 =?utf-8?B?U21UbnljVmFqS0VGSmJ3ZnNGN0tQWXVpaldkcGpESTZFckVFK0lYZS9Jd0ZF?=
 =?utf-8?B?WUV1SWtFRldqZ0t1KzVBcnFjRGx4aXpSM3k2NFZSd1dPekNmUVBRYjV6MHlp?=
 =?utf-8?B?TU56dUwzWXFTLytBTmhVWlFSWWRNY1dtREIrNUhkQzg3WUtkRTZZejlHWnpp?=
 =?utf-8?B?OS9TTGNwWUcvMVJyUENOL3MwT2xFcXloRHF4YXoxb0IwTm82OVhaaHJwNGhI?=
 =?utf-8?B?WDJjYVZFUVQ2SW1HS3hobmppMURTYWFJU2EzV3kyZ2hBdiswcUpsVWUzV1lV?=
 =?utf-8?B?RHpKV2lsOVpVZlZWOGRXZXU2K0E5eDRlaDI5Wk85eFhLUEJZYlZ1V3NRTDJ1?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5aa058-294a-4415-4c9e-08dc9b75a8cc
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 15:34:43.0338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdrV7KQp7quUV46D1g9MNsrHFXMeH/3fxytCJWAkxWGVuN/TwPSafItpemOUCSBW4kysOb52UYUkm/7OZcyR4kj4wDODGtSmc29+qfg49+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9986

Hi Guenter,

On 7/1/24 11:23 PM, Guenter Roeck wrote:
> Convert to use with_info API to simplify the code and make it easier
> to maintain. This also reduces code size by approximately 20%.
> 
> No functional change intended.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Looks good to me,
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

