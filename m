Return-Path: <linux-kernel+bounces-440930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA21B9EC693
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EF618849F9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8401D4610;
	Wed, 11 Dec 2024 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="YG55JjjV"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2130.outbound.protection.outlook.com [40.107.255.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE3578F40;
	Wed, 11 Dec 2024 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904510; cv=fail; b=LT9ziiuQtWY2pSf6l8C+9MBUMCCaOlAPZKiEs9z1KjWjU3n63U/ZjaLUlghhwK8UdSensDR0VpbZJUIaYwNHcDAKWkd44kvgEegyyRd8CZHA3DqTRYfuZWH64GiWgccjjCv6W6jRYbC9P1lydq4WnqYdDMTvGpK5wn25r42F9OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904510; c=relaxed/simple;
	bh=omVYWSTvzMi7yG8Jv7TuK7g3Gnai4zz/IggMhB4ZiTA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UcM+BB0XPOU49egf3nmCZkvm470UXW7droKtDNVij8KTDoMcNbGd77nxwSQ0DyHU1nu7PqAz1z1kIqU2oh1BPNfckh5ocWvXrCQpQ72baN3NSCJVt0v7Y2pw9O7BRvNEkaJmIMrYYBlbEzxV04L+zoAFUat6EWS7a1wLbcSKUDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=YG55JjjV; arc=fail smtp.client-ip=40.107.255.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLE+xw7uEAl8zdWiijUJQyr+vfxl2itxa1ChTVEAt1fAhJ+PWuz6m2Fxi2C3GkXCaQfVYunq1znyLDJCkW3zk4dEN19T8gzF3rIlfcbtfQqtYbfadn67v2ubNJYtACsXjnOk0IhYDspaOvHhOr5qc7u6Fj0sjpwxsn8jefSQCzokmqDNa21hpKexYWbdm7Js26KjYKyRfjGQBaiUH/GIMOA+4dJh7UI6T/b4Q5g5TTiR/LD6srxnd1bQo6pRFukUS27fwfpMmzyV+gjoEmDzs1KmWejy1+q1pG6EZqbKyKqMUVRgvHxo5gjxH3WALqgRjFBk6CGADmNXghaVepIPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gpBxG1nXBaF9LCvFEuPskDso8Z5Mv6/V6ZY2iO+10U=;
 b=dvTUGXwroPDP31AbL+m5fLJM98rGzgfrFyfe0g+Gb5wtkNI7GNTYqkIUBBYqvj81bxGRgdKOGWwv+qZ4CQZz6csvrPtYWuiUJfdDoAwG3RcOtuFIPXe4TzhRoNJOGE1bcL6GG4rnOgv2czwRedjWsDcd50GCPJTFejzV8ge11mV7Tidq+kXlFCBfFusIHLLd68Vw6th3k6zaGlp5zXNsqExpyrLkCJhdMalasoo/TswBOxdLI+i5u4tlmEl2uvgBeOLInO9IgdOagTCepBW9/pDHMYwhrBYEe+BV4HkPWhrXdvjcESV4DOu2qR49huFyBZDeC+MRtKPW/ZufGjvmyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gpBxG1nXBaF9LCvFEuPskDso8Z5Mv6/V6ZY2iO+10U=;
 b=YG55JjjVRbAqiQ3KQ4+tcl69zYW2Axq0KntDwb56rXEI+vS1q8AiasZ2Rb4hXGea4D3UHIKYShjCA5zzrpQxs8gv1epLm2dobGyw/CO8uwc0B2q56MouphmqDaNDEissVFgMXmrvb5KLGaNw5ADHjEU+TzNOhxs1IPHf5CmZ0bxJ9gfxXtbSbDSO6+8pUJtmTJAbXHcT3B4Q569xAa5w1PdT25Y+Qruojvv1gDh7zr1nHf+QDfDmXeLMX20pvGWHCxYc7D7AhasKcWV4PKncd5664vELFJlFrDXiI1BKsMetxEn5UbJ3JZXzz8GIcIqk+GcZrC4XcpvoRtxe4tOKlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEZPR03MB7123.apcprd03.prod.outlook.com (2603:1096:101:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 08:08:23 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 08:08:23 +0000
Message-ID: <d0cb6c31-aebf-4662-93ca-274ee1bf4f98@amlogic.com>
Date: Wed, 11 Dec 2024 16:08:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] clk: meson: add A5 clock peripherals controller
 driver
Content-Language: en-US
To: Jerome Brunet <jbrunet@baylibre.com>,
 Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20241120-a5-clk-v2-0-1208621e961d@amlogic.com>
 <20241120-a5-clk-v2-5-1208621e961d@amlogic.com>
 <1jldx7tffh.fsf@starbuckisacylon.baylibre.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <1jldx7tffh.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEZPR03MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 87dc2356-cf46-4153-083e-08dd19bafbc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVdqTEZST3FCMk1HY2pUY0RDMVlDOXVzVWZzQm5jY3RNbUtqM0FXV1NEUXNT?=
 =?utf-8?B?V0pGdStab2JEOXBDaWVRME10em4xZUxEVlBaT3RFenB0S080RnV3czcwMS9S?=
 =?utf-8?B?Sk95YURmVUIrREhyeFdTMnhUVjRDY29HRS9mK3NLZkgvQnZ0Z1NERGNYa0lW?=
 =?utf-8?B?VDdUTlBKWjVhNXNZZUhMRGpPN3dHM0VwWXRJUE9Ic2JsNU9xVW4vQkpvd0xt?=
 =?utf-8?B?VFZ5MWVYTUh1M3FmTTROeVZsQXlyNXk0YThFaHFiY0gvckZ1YndYL01oRWlq?=
 =?utf-8?B?TE1tU1VCOUU2ZGFNSjBGMzMxc0hEcG0xK1pvVVEzM0M2cTFKOEJ5NENncG4z?=
 =?utf-8?B?OHNvUzFCRXgrR0FacHVsUmVkbWVLbWtXYWtsU0tEWFVDSVJKQWpNeXMwSWw2?=
 =?utf-8?B?ZWZad1lMNDRYUG9tYzZtczkvSWliT2NVVTdxeGU4RjRRY2tjdjF1b1lyZVN0?=
 =?utf-8?B?UDBpU2liMEEzUHlaejh5VjBCWTNmRUFFUHQwVFNnbjJoRm5QK0krbzltRjZI?=
 =?utf-8?B?VXRLRnM0UkFSNitGQmZuVUx1akt4Z2hUaEZBaWExcHduUTA3dGFFM3lIR01H?=
 =?utf-8?B?VlljNzE1NWhwK3VoRWlnUFdwdjE2MWljNXBjd0NxN0FyMXlCMVphU2RqR1hH?=
 =?utf-8?B?UEpPYU00YkovVHBsRTZncTZmdWhMN05FcHJrZE9tVmtGS2FiRnlIampURkJH?=
 =?utf-8?B?MzkrWFc1SXBBcDVKaDVnS3cyVXQydUlQNnM1YndYb1lqVEdwVzdJaXZYL1RQ?=
 =?utf-8?B?MGZyRGFpNWwvSW1nTWtZemZhcnQ3alRxbUd1MUtnN1g0TlRUSUpONFVGL1lN?=
 =?utf-8?B?RDBiL0k3MWQ4RjlXdE5LTHBiZTUrNDVsQnVBVXJaaktzQXAyek9zRm9yM091?=
 =?utf-8?B?ME50ZUwvQ2d1WGtVUUx4NmUzTWVkbng1NDB0VUFVTDlrRCtTczNEZXRyeTky?=
 =?utf-8?B?QUlMYVZEOVk4ZWNORmI1Y0RxVm03Mm5SN0JPcVRrYkxackwwcmpibldvMk8r?=
 =?utf-8?B?dUY1NDloVUpoQUN3S29JVWQzcjdFRDJUandKbUZGVk95cVk3RDl0Q0FjN0p5?=
 =?utf-8?B?YUY0UTBBTVFibmUwdkxRUytkYTNld09VK1Fpd2NGVWJXQjdVU3EwN0RxTEhR?=
 =?utf-8?B?V09mNG11dXBpN2M2S09UVndpUUVUYTNzMDlIV2I5UVpNMlhSc0d1dXhLM0Yx?=
 =?utf-8?B?cTN5dnJ6S0VXUjMxVDZaSjdTSVl0TFIrRFNpUGZJMFpYZXdNeVBNWXNxaUxt?=
 =?utf-8?B?RjFKR0FXWHFkdHcya2JzL1dya2ErR0htRVVzNDZvUXBQYVBaZFNOTmphYXFv?=
 =?utf-8?B?R0o5dVpJb1g0MDhlMUdFSHVRVmpGbkJDRENnR2hacCtGU29wUUNTRGJQTmFl?=
 =?utf-8?B?dnc2RWY0NmNPRXlTd1JpbkNkak1jQ093OTRxUEg4VU9ZT21VMnVsa016aGhm?=
 =?utf-8?B?TXV5Si83c1Q3OVJEWWNFbzQ4eDZzZlZkK0xoS2FHOEViVkNuck96UkpsQW5I?=
 =?utf-8?B?Rmlsbm4wVTQvWmNlT0ZSMWNodnNsVnBpamZNNjF0V0kvend3K25pWkRuS3Y1?=
 =?utf-8?B?Y3hYQzk2ZE9GM3JCT0h5VUhBNy9NUUZ2SW9BdHdrN2FOTnBBNGpiZDVkaW5X?=
 =?utf-8?B?YWVJWVZmV1grbzYwVjZPWEd2QTUvVDhkQ1lidnd5elUzS1pkRWZQcXNDb0Mz?=
 =?utf-8?B?QXZuanJUWDAwTDl2cGRBTitXbEpDcGh2a3pjdEFVZzVlWmxQS2Z3ZG1YRWE1?=
 =?utf-8?B?UXFKRTJUUFJBVGhDd1VHNjl4T1pBV1lUeUt2WmVCekgxYXY0VEF2Qzhicnk0?=
 =?utf-8?B?ZHpLVGR4Mkd3TnhoVDM5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUFIUHRDR0VXektzWm55cVRuMGpMb003U1BmVUZkbFRBMGZRd3F0aWtEZjlC?=
 =?utf-8?B?ZGlBR0VUY0txbkJLVHNVZGVqcWhZRVpsSmFjbmhDNXE4MGFBQnBlWDc3YmdR?=
 =?utf-8?B?QzhPc3BibUZkVkM1bS80RkFraGtUSVRaeklnbUZWRzNoOHNISXIvdkM2bGZy?=
 =?utf-8?B?NU5kb25rajVWZWUzczRqbE9BK0VQbmMwMzhnL0tSV2FScG04SFJ0ZFpXNlpY?=
 =?utf-8?B?WnE0UDBEaFFHQ0Y5a21jOXpQTlBldTNKR3ptVnRDT3p0aDRlM3NvY0xueGcz?=
 =?utf-8?B?bzlrR0RFcWpHeld0Qnk3aHRabi9sSDRjaC9aclQ1NURXY21UanR5RFN3dXI4?=
 =?utf-8?B?V0M0c2lBZG5IN1lEUW96eVo4aGdUQy9wbWgxQms1YkloVkNsT3h3ZHY5ZWlv?=
 =?utf-8?B?eVZFK2Z3WjN0cWgyWndHZVUxVG40OVBSQXdFSys1MVNFU3orZ1NOYkM3UGZG?=
 =?utf-8?B?Ym5RRVRMR2dzWXN6TkpSU213UTVzVFhyT1FjbThMS1Q2TUU0OUdIdlp1KytN?=
 =?utf-8?B?cHo4dHNRZFZWd2R5dDgzSjhzVWN3UWNDTkNTc0xzVFRxZkZoanFaV1pXS2k4?=
 =?utf-8?B?ODFybmM2NklwM0FaY1BVRGhwNS9PZ0lqelh4aWtHbUhQcVhZbDVFWXZqMUln?=
 =?utf-8?B?R0xZeXV2QTdTNE5LRDZyWU1RNVhYZmloMTMwOFh1dnRHNjVOd0tjd1pFVzNV?=
 =?utf-8?B?aVdOeUs2djduTG1TYVJVeCtDY3prdVNTaGhlVjFlNDIzdXVjSXlCSWt4aTNI?=
 =?utf-8?B?aWhXY3BoTno2NjFYUjBjSG1yQlc1eFArVVI5YU5pQ3FoYlk0emFOMi8xSGVK?=
 =?utf-8?B?cXUvdzV0OEx5N0N6OEdBZW8vMTU0bUtWZmE2eCtaRlQ3Z2ZYTkFvb2VEVktu?=
 =?utf-8?B?Mk5YZnd6Z094Q09oUmVpWWdlT0lkN3ZtWkIyQ2QyeEhSbUVESjdoTmVPek94?=
 =?utf-8?B?eGxrbmZrUyttWDZoMml2Z3YxbE42ZUdiWlpUc00zM01JNzFCcjlKU3h3MlJq?=
 =?utf-8?B?S3FIZEdVUDBwSkxZOWk3Ty9tYWUvTUdpa05WNitnUnJxWEQ5c3JzL0NvZUZn?=
 =?utf-8?B?WmljYW5SQ2xwSmVxVnY2eCtxV3NBei9wU2pyV1ZXUUlNWVBXazU4M2Q5c2hq?=
 =?utf-8?B?TmxJNXNWMFNFbXRxRUovMFYxazNRaXd2QUNBVTRPOVdYNVlxUFdxK250SzNI?=
 =?utf-8?B?OTZmT0Y1SjJqdkZNNTBmd0k4S2taRHdkR00xWHdCNlZGUExUci9VdnZldUxj?=
 =?utf-8?B?bTZKdGNSUkJ1ZXJIZWpIeGsrVmRDbmlGZWU1MGx2dXFmMlVEMkVPNlZtV0F2?=
 =?utf-8?B?cUowZlN3dDRtUXRZK2RpUnJrZFFkYzZwZXRMd29RVy9GNThHazJ6NnNwak03?=
 =?utf-8?B?czJnUzVNU2RKSHV5RUlpRVJLZ3M2clZFOG4zWFJEQkRwTEluTGFWU0tCOVo3?=
 =?utf-8?B?ZHRxdFY0cmRXQXVnNWNJYnozVUZ4RlJxWjArOHVsajg0MUw0TFZFUUE5dXBC?=
 =?utf-8?B?M3VTMjJ3cU5QOWZXNlVKb3VQQ3RoVjY3YndtR2pmTS9LYjBQV2JURlpKbHpx?=
 =?utf-8?B?SVErL21EUVUwdXhNQnhTM0hoaWVUbkQxUzdSSG9KZXRXNHFaK0RGeC9uZGhY?=
 =?utf-8?B?WEkwVWRQM2pLbmY4c1hBNUN1d3hMMlFqa2ZaM3IvYmZtVCttOHh5MHJFY3Y3?=
 =?utf-8?B?UU1KVEV2TVNOdHJiWHlXM1JBdWVFRHNwZXBGdElmZmpOMWlINURiMHFTaHVa?=
 =?utf-8?B?Ym1IaHoySHRtcnNIa0NUWkJxczA5OGkxU2p2WjZoa1pOYXZBSjhHQ0pKYks4?=
 =?utf-8?B?MHZmb3RmdzRlUUFhNmRVU2xrY1FYSFdJUnFzS1RVem5yenBGWUhHU21IR281?=
 =?utf-8?B?eHQyeWJSKzRDYVJ3N09TTkUxMlpYNzlCVTUzM3U0elFjRjV2OGx0ZGlzZzBz?=
 =?utf-8?B?UlgwVjlyVEM0YTVzSFFwdkJHMmRIdlJNaG1uZ1pHTHlBL3I1UmJ2V2RleFJn?=
 =?utf-8?B?TlJlbmJDWlJRYkV5WnNNeEk5WVB3dDBjQS9mMlJWajUyd1JUUndiM1VNZWNn?=
 =?utf-8?B?eGhsMTYwWHFpbTR3V2ZuRGRSNUVQL2grT2swMG1Zc1VvclVFSUc5TUxMUUI5?=
 =?utf-8?B?bkhkVnZiQ25vNC85YlhDMmlCNGo0eDVobWZybDZFTHJFM1FpMldVQjBkM216?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87dc2356-cf46-4153-083e-08dd19bafbc1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 08:08:23.6500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lB34OmmnxKmMtekxXAMkGs3MUqz5kq8E4J7oCsgWGyHbZNpa/nk+Sdw5oStLDh3tdTKGT0rgkFcqGq9UsJIQ6Up5djeEE0giTeNHfZ/Rf3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7123

Hi Jerome,
    Thanks for your reply.

On 2024/11/26 01:02, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Wed 20 Nov 2024 at 15:01, Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
> 
>> From: Chuan Liu <chuan.liu@amlogic.com>
>>
>> Add the peripherals clock controller driver in the A5 SoC family.
>>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   drivers/clk/meson/Kconfig          |   13 +
>>   drivers/clk/meson/Makefile         |    1 +
>>   drivers/clk/meson/a5-peripherals.c | 1387 ++++++++++++++++++++++++++++++++++++
>>   drivers/clk/meson/clk-regmap.h     |   17 +
>>   4 files changed, 1418 insertions(+)
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index 3c97b3a1649d..79ec72156cee 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -146,6 +146,19 @@ config COMMON_CLK_A5_PLL
>>          Say Y if you want the board to work, because PLLs are the parent
>>          of most peripherals.
>>
>> +config COMMON_CLK_A5_PERIPHERALS
>> +     tristate "Amlogic A5 peripherals clock controller"
>> +     depends on ARM64
>> +     default y
>> +     imply COMMON_CLK_SCMI
>> +     imply COMMON_CLK_A5_PLL
>> +     select COMMON_CLK_MESON_REGMAP
>> +     select COMMON_CLK_MESON_DUALDIV
>> +     select COMMON_CLK_MESON_CLKC_UTILS
>> +     help
>> +       Support for the Peripherals clock controller on Amlogic AV40x device,
> 
> Same
Will remove it.
> 
>> +       AKA A5. Say Y if you want the peripherals clock to work.
>> +
>>   config COMMON_CLK_C3_PLL
>>        tristate "Amlogic C3 PLL clock controller"
>>        depends on ARM64
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index fc4b8a723145..58236c6e8377 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -21,6 +21,7 @@ obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>>   obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>>   obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
>>   obj-$(CONFIG_COMMON_CLK_A5_PLL) += a5-pll.o
>> +obj-$(CONFIG_COMMON_CLK_A5_PERIPHERALS) += a5-peripherals.o
>>   obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
>>   obj-$(CONFIG_COMMON_CLK_C3_PERIPHERALS) += c3-peripherals.o
>>   obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>> diff --git a/drivers/clk/meson/a5-peripherals.c b/drivers/clk/meson/a5-peripherals.c
>> new file mode 100644
>> index 000000000000..ed408f1c5b1f
>> --- /dev/null
>> +++ b/drivers/clk/meson/a5-peripherals.c
>> @@ -0,0 +1,1387 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Amlogic A5 Peripherals Clock Controller Driver
>> + *
>> + * Copyright (c) 2024 Amlogic, inc.
>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/platform_device.h>
>> +#include "clk-regmap.h"
>> +#include "clk-dualdiv.h"
>> +#include "meson-clkc-utils.h"
>> +#include <dt-bindings/clock/amlogic,a5-peripherals-clkc.h>
>> +
>> +#define CLKCTRL_RTC_BY_OSCIN_CTRL0           0x8
>> +#define CLKCTRL_RTC_BY_OSCIN_CTRL1           0xc
>> +#define CLKCTRL_RTC_CTRL                     0x10
>> +#define CLKCTRL_SYS_CLK_EN0_REG0             0x44
>> +#define CLKCTRL_SYS_CLK_EN0_REG1             0x48
>> +#define CLKCTRL_DSPA_CLK_CTRL0                       0x9c
>> +#define CLKCTRL_CLK12_24_CTRL                        0xa8
>> +#define CLKCTRL_AXI_CLK_EN0                  0xac
>> +#define CLKCTRL_TS_CLK_CTRL                  0x158
>> +#define CLKCTRL_ETH_CLK_CTRL                 0x164
>> +#define CLKCTRL_NAND_CLK_CTRL                        0x168
>> +#define CLKCTRL_SD_EMMC_CLK_CTRL             0x16c
>> +#define CLKCTRL_SPICC_CLK_CTRL                       0x174
>> +#define CLKCTRL_GEN_CLK_CTRL                 0x178
>> +#define CLKCTRL_SAR_CLK_CTRL0                        0x17c
>> +#define CLKCTRL_PWM_CLK_AB_CTRL                      0x180
>> +#define CLKCTRL_PWM_CLK_CD_CTRL                      0x184
>> +#define CLKCTRL_PWM_CLK_EF_CTRL                      0x188
>> +#define CLKCTRL_PWM_CLK_GH_CTRL                      0x18c
>> +#define CLKCTRL_NNA_CLK_CNTL                 0x220
> 
> Same comment as previous patches
>

there are no registers of other modules interspersed in it.

>> +
>> +static struct clk_regmap rtc_xtal_clkin = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "rtc_xtal_clkin",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "oscin",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static const struct meson_clk_dualdiv_param rtc_32k_div_table[] = {
>> +     { 733, 732, 8, 11, 1 },
>> +     { /* sentinel */ }
>> +};
>> +
>> +static struct clk_regmap rtc_32k_div = {
>> +     .data = &(struct meson_clk_dualdiv_data) {
>> +             .n1 = {
>> +                     .reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .m1 = {
>> +                     .reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .m2 = {
>> +                     .reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL1,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .dual = {
>> +                     .reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .table = rtc_32k_div_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "rtc_32k_div",
>> +             .ops = &meson_clk_dualdiv_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &rtc_xtal_clkin.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data rtc_32k_mux_parent_data[] = {
>> +     { .hw = &rtc_32k_div.hw },
>> +     { .hw = &rtc_xtal_clkin.hw }
>> +};
>> +
>> +static struct clk_regmap rtc_32k_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_RTC_BY_OSCIN_CTRL1,
>> +             .mask = 0x1,
>> +             .shift = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "rtc_32k_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = rtc_32k_mux_parent_data,
>> +             .num_parents = ARRAY_SIZE(rtc_32k_mux_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap rtc_32k = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>> +             .bit_idx = 30,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "rtc_32k",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &rtc_32k_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data rtc_clk_mux_parent_data[] = {
>> +     { .fw_name = "oscin" },
>> +     { .hw = &rtc_32k.hw },
>> +     { .fw_name = "pad_osc" }
>> +};
>> +
>> +static struct clk_regmap rtc_clk = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_RTC_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 0,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "rtc_clk",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = rtc_clk_mux_parent_data,
>> +             .num_parents = ARRAY_SIZE(rtc_clk_mux_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +#define A5_SYS_GATE(_name, _reg, _bit, _flags)                               \
>> +     MESON_CLK_GATE_FW(_name, _reg, _bit, sysclk,                    \
>> +                     &clk_regmap_gate_ops, _flags)
>> +
>> +static A5_SYS_GATE(sys_reset_ctrl,   CLKCTRL_SYS_CLK_EN0_REG0, 1, 0);
>> +static A5_SYS_GATE(sys_pwr_ctrl,     CLKCTRL_SYS_CLK_EN0_REG0, 3, 0);
>> +static A5_SYS_GATE(sys_pad_ctrl,     CLKCTRL_SYS_CLK_EN0_REG0, 4, 0);
>> +static A5_SYS_GATE(sys_ctrl,         CLKCTRL_SYS_CLK_EN0_REG0, 5, 0);
>> +static A5_SYS_GATE(sys_ts_pll,               CLKCTRL_SYS_CLK_EN0_REG0, 6, 0);
>> +
>> +/*
>> + * NOTE: sys_dev_arb provides the clock to the ETH and SPICC arbiters that
>> + * access the AXI bus.
>> + */
>> +static A5_SYS_GATE(sys_dev_arb,              CLKCTRL_SYS_CLK_EN0_REG0, 7, 0);
>> +static A5_SYS_GATE(sys_mailbox,              CLKCTRL_SYS_CLK_EN0_REG0, 10, 0);
>> +static A5_SYS_GATE(sys_jtag_ctrl,    CLKCTRL_SYS_CLK_EN0_REG0, 12, 0);
>> +static A5_SYS_GATE(sys_ir_ctrl,              CLKCTRL_SYS_CLK_EN0_REG0, 13, 0);
>> +static A5_SYS_GATE(sys_msr_clk,              CLKCTRL_SYS_CLK_EN0_REG0, 15, 0);
>> +static A5_SYS_GATE(sys_rom,          CLKCTRL_SYS_CLK_EN0_REG0, 16, 0);
>> +static A5_SYS_GATE(sys_cpu_apb,              CLKCTRL_SYS_CLK_EN0_REG0, 18, 0);
>> +static A5_SYS_GATE(sys_rsa,          CLKCTRL_SYS_CLK_EN0_REG0, 19, 0);
>> +static A5_SYS_GATE(sys_sar_adc,              CLKCTRL_SYS_CLK_EN0_REG0, 20, 0);
>> +static A5_SYS_GATE(sys_startup,              CLKCTRL_SYS_CLK_EN0_REG0, 21, 0);
>> +static A5_SYS_GATE(sys_secure,               CLKCTRL_SYS_CLK_EN0_REG0, 22, 0);
>> +static A5_SYS_GATE(sys_spifc,                CLKCTRL_SYS_CLK_EN0_REG0, 23, 0);
>> +static A5_SYS_GATE(sys_dspa,         CLKCTRL_SYS_CLK_EN0_REG0, 24, 0);
>> +static A5_SYS_GATE(sys_nna,          CLKCTRL_SYS_CLK_EN0_REG0, 25, 0);
>> +static A5_SYS_GATE(sys_eth_mac,              CLKCTRL_SYS_CLK_EN0_REG0, 26, 0);
>> +static A5_SYS_GATE(sys_rama,         CLKCTRL_SYS_CLK_EN0_REG0, 28, 0);
>> +static A5_SYS_GATE(sys_ramb,         CLKCTRL_SYS_CLK_EN0_REG0, 30, 0);
>> +static A5_SYS_GATE(sys_audio_top,    CLKCTRL_SYS_CLK_EN0_REG1, 0, 0);
>> +static A5_SYS_GATE(sys_audio_vad,    CLKCTRL_SYS_CLK_EN0_REG1, 1, 0);
>> +static A5_SYS_GATE(sys_usb,          CLKCTRL_SYS_CLK_EN0_REG1, 2, 0);
>> +static A5_SYS_GATE(sys_sd_emmc_a,    CLKCTRL_SYS_CLK_EN0_REG1, 3, 0);
>> +static A5_SYS_GATE(sys_sd_emmc_c,    CLKCTRL_SYS_CLK_EN0_REG1, 4, 0);
>> +static A5_SYS_GATE(sys_pwm_ab,               CLKCTRL_SYS_CLK_EN0_REG1, 5, 0);
>> +static A5_SYS_GATE(sys_pwm_cd,               CLKCTRL_SYS_CLK_EN0_REG1, 6, 0);
>> +static A5_SYS_GATE(sys_pwm_ef,               CLKCTRL_SYS_CLK_EN0_REG1, 7, 0);
>> +static A5_SYS_GATE(sys_pwm_gh,               CLKCTRL_SYS_CLK_EN0_REG1, 8, 0);
>> +static A5_SYS_GATE(sys_spicc_1,              CLKCTRL_SYS_CLK_EN0_REG1, 9, 0);
>> +static A5_SYS_GATE(sys_spicc_0,              CLKCTRL_SYS_CLK_EN0_REG1, 10, 0);
>> +static A5_SYS_GATE(sys_uart_a,               CLKCTRL_SYS_CLK_EN0_REG1, 11, 0);
>> +static A5_SYS_GATE(sys_uart_b,               CLKCTRL_SYS_CLK_EN0_REG1, 12, 0);
>> +static A5_SYS_GATE(sys_uart_c,               CLKCTRL_SYS_CLK_EN0_REG1, 13, 0);
>> +static A5_SYS_GATE(sys_uart_d,               CLKCTRL_SYS_CLK_EN0_REG1, 14, 0);
>> +static A5_SYS_GATE(sys_uart_e,               CLKCTRL_SYS_CLK_EN0_REG1, 15, 0);
>> +static A5_SYS_GATE(sys_i2c_m_a,              CLKCTRL_SYS_CLK_EN0_REG1, 16, 0);
>> +static A5_SYS_GATE(sys_i2c_m_b,              CLKCTRL_SYS_CLK_EN0_REG1, 17, 0);
>> +static A5_SYS_GATE(sys_i2c_m_c,              CLKCTRL_SYS_CLK_EN0_REG1, 18, 0);
>> +static A5_SYS_GATE(sys_i2c_m_d,              CLKCTRL_SYS_CLK_EN0_REG1, 19, 0);
>> +static A5_SYS_GATE(sys_rtc,          CLKCTRL_SYS_CLK_EN0_REG1, 21, 0);
>> +
>> +#define A5_AXI_GATE(_name, _reg, _bit, _flags)                               \
>> +     MESON_CLK_GATE_FW(_name, _reg, _bit, axiclk,                    \
>> +                     &clk_regmap_gate_ops, _flags)
>> +
>> +static A5_AXI_GATE(axi_audio_vad,    CLKCTRL_AXI_CLK_EN0, 0, 0);
>> +static A5_AXI_GATE(axi_audio_top,    CLKCTRL_AXI_CLK_EN0, 1, 0);
>> +static A5_AXI_GATE(axi_ramb,         CLKCTRL_AXI_CLK_EN0, 5, 0);
>> +static A5_AXI_GATE(axi_rama,         CLKCTRL_AXI_CLK_EN0, 6, 0);
>> +static A5_AXI_GATE(axi_nna,          CLKCTRL_AXI_CLK_EN0, 12, 0);
>> +
>> +/*
>> + * NOTE: axi_dev1_dmc provides the clock for the peripherals(EMMC, SDIO,
>> + * sec_top, USB, Audio) to access the AXI bus of the DDR.
>> + */
>> +static A5_AXI_GATE(axi_dev1_dmc,     CLKCTRL_AXI_CLK_EN0, 13, 0);
>> +
>> +/*
>> + * NOTE: axi_dev0_dmc provides the clock for the peripherals(ETH and SPICC)
>> + * to access the AXI bus of the DDR.
>> + */
>> +static A5_AXI_GATE(axi_dev0_dmc,     CLKCTRL_AXI_CLK_EN0, 14, 0);
>> +static A5_AXI_GATE(axi_dsp_dmc,              CLKCTRL_AXI_CLK_EN0, 15, 0);
>> +
>> +static struct clk_regmap clk_12_24m_in = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_CLK12_24_CTRL,
>> +             .bit_idx = 11,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "clk_12_24m_in",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "xtal_24m",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap clk_12_24m = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_CLK12_24_CTRL,
>> +             .shift = 10,
>> +             .width = 1,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "clk_12_24m",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &clk_12_24m_in.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap fclk_25m_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_CLK12_24_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_25m_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "fix",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap fclk_25m = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_CLK12_24_CTRL,
>> +             .bit_idx = 12,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_25m",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fclk_25m_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/*
>> + * Channel 4 5 8 9 10 11 13 14 15 16 18 are not connected.
>> + *
>> + * gp1 is designed for DSU (DynamIQ Shared Unit) alone. It cannot be changed
>> + * arbitrarily. gp1 is read-only in the kernel and is only open for debug
>> + * purposes.
>> + */
>> +static u32 gen_parent_table[] = { 0, 1, 2, 3, 6, 7, 12, 17, 19, 20, 21, 22, 23,
>> +                               24, 25, 26, 27, 28};
>> +
>> +static const struct clk_parent_data gen_parent_data[] = {
>> +     { .fw_name = "oscin" },
>> +     { .hw = &rtc_clk.hw },
>> +     { .fw_name = "sysplldiv16" },
>> +     { .fw_name = "ddr" },
>> +     { .fw_name = "gp1" },
>> +     { .fw_name = "hifi" },
>> +     { .fw_name = "clkmsr" },
>> +     { .fw_name = "cpudiv16" },
>> +     { .fw_name = "fdiv2" },
>> +     { .fw_name = "fdiv2p5" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "fdiv5" },
>> +     { .fw_name = "fdiv7" },
>> +     { .fw_name = "mpll0" },
>> +     { .fw_name = "mpll1" },
>> +     { .fw_name = "mpll2" },
>> +     { .fw_name = "mpll3" }
>> +};
>> +
>> +static struct clk_regmap gen_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_GEN_CLK_CTRL,
>> +             .mask = 0x1f,
>> +             .shift = 12,
>> +             .table = gen_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "gen_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = gen_parent_data,
>> +             .num_parents = ARRAY_SIZE(gen_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap gen_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_GEN_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 11,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "gen_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &gen_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap gen = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_GEN_CLK_CTRL,
>> +             .bit_idx = 11,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "gen",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &gen_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data saradc_parent_data[] = {
>> +     { .fw_name = "oscin" },
>> +     { .fw_name = "sysclk" }
>> +};
>> +
>> +static struct clk_regmap saradc_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_SAR_CLK_CTRL0,
>> +             .mask = 0x1,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "saradc_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = saradc_parent_data,
>> +             .num_parents = ARRAY_SIZE(saradc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap saradc_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_SAR_CLK_CTRL0,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "saradc_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &saradc_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap saradc = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_SAR_CLK_CTRL0,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "saradc",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &saradc_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data pwm_parent_data[] = {
>> +     { .fw_name = "oscin" },
>> +     { .hw = &rtc_clk.hw },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "fdiv3" }
>> +};
>> +
>> +#define AML_PWM_CLK_MUX(_name, _reg, _shift) {                       \
>> +     .data = &(struct clk_regmap_mux_data) {                 \
>> +             .offset = _reg,                                 \
>> +             .mask = 0x3,                                    \
>> +             .shift = _shift,                                \
>> +     },                                                      \
>> +     .hw.init = &(struct clk_init_data) {                    \
>> +             .name = #_name "_sel",                          \
>> +             .ops = &clk_regmap_mux_ops,                     \
>> +             .parent_data = pwm_parent_data,                 \
>> +             .num_parents = ARRAY_SIZE(pwm_parent_data),     \
>> +     },                                                      \
>> +}
>> +
>> +#define AML_PWM_CLK_DIV(_name, _reg, _shift) {                       \
>> +     .data = &(struct clk_regmap_div_data) {                 \
>> +             .offset = _reg,                                 \
>> +             .shift = _shift,                                \
>> +             .width = 8,                                     \
>> +     },                                                      \
>> +     .hw.init = &(struct clk_init_data) {                    \
>> +             .name = #_name "_div",                          \
>> +             .ops = &clk_regmap_divider_ops,                 \
>> +             .parent_names = (const char *[]) { #_name "_sel" },\
>> +             .num_parents = 1,                               \
>> +             .flags = CLK_SET_RATE_PARENT,                   \
>> +     },                                                      \
>> +}
>> +
>> +#define AML_PWM_CLK_GATE(_name, _reg, _bit) {                        \
>> +     .data = &(struct clk_regmap_gate_data) {                \
>> +             .offset = _reg,                                 \
>> +             .bit_idx = _bit,                                \
>> +     },                                                      \
>> +     .hw.init = &(struct clk_init_data) {                    \
>> +             .name = #_name,                                 \
>> +             .ops = &clk_regmap_gate_ops,                    \
>> +             .parent_names = (const char *[]) { #_name "_div" },\
>> +             .num_parents = 1,                               \
>> +             .flags = CLK_SET_RATE_PARENT,                   \
>> +     },                                                      \
>> +}
>> +
>> +static struct clk_regmap pwm_a_sel =
>> +     AML_PWM_CLK_MUX(pwm_a, CLKCTRL_PWM_CLK_AB_CTRL, 9);
>> +static struct clk_regmap pwm_a_div =
>> +     AML_PWM_CLK_DIV(pwm_a, CLKCTRL_PWM_CLK_AB_CTRL, 0);
>> +static struct clk_regmap pwm_a =
>> +     AML_PWM_CLK_GATE(pwm_a, CLKCTRL_PWM_CLK_AB_CTRL, 8);
>> +
>> +static struct clk_regmap pwm_b_sel =
>> +     AML_PWM_CLK_MUX(pwm_b, CLKCTRL_PWM_CLK_AB_CTRL, 25);
>> +static struct clk_regmap pwm_b_div =
>> +     AML_PWM_CLK_DIV(pwm_b, CLKCTRL_PWM_CLK_AB_CTRL, 16);
>> +static struct clk_regmap pwm_b =
>> +     AML_PWM_CLK_GATE(pwm_b, CLKCTRL_PWM_CLK_AB_CTRL, 24);
>> +
>> +static struct clk_regmap pwm_c_sel =
>> +     AML_PWM_CLK_MUX(pwm_c, CLKCTRL_PWM_CLK_CD_CTRL, 9);
>> +static struct clk_regmap pwm_c_div =
>> +     AML_PWM_CLK_DIV(pwm_c, CLKCTRL_PWM_CLK_CD_CTRL, 0);
>> +static struct clk_regmap pwm_c =
>> +     AML_PWM_CLK_GATE(pwm_c, CLKCTRL_PWM_CLK_CD_CTRL, 8);
>> +
>> +static struct clk_regmap pwm_d_sel =
>> +     AML_PWM_CLK_MUX(pwm_d, CLKCTRL_PWM_CLK_CD_CTRL, 25);
>> +static struct clk_regmap pwm_d_div =
>> +     AML_PWM_CLK_DIV(pwm_d, CLKCTRL_PWM_CLK_CD_CTRL, 16);
>> +static struct clk_regmap pwm_d =
>> +     AML_PWM_CLK_GATE(pwm_d, CLKCTRL_PWM_CLK_CD_CTRL, 24);
>> +
>> +static struct clk_regmap pwm_e_sel =
>> +     AML_PWM_CLK_MUX(pwm_e, CLKCTRL_PWM_CLK_EF_CTRL, 9);
>> +static struct clk_regmap pwm_e_div =
>> +     AML_PWM_CLK_DIV(pwm_e, CLKCTRL_PWM_CLK_EF_CTRL, 0);
>> +static struct clk_regmap pwm_e =
>> +     AML_PWM_CLK_GATE(pwm_e, CLKCTRL_PWM_CLK_EF_CTRL, 8);
>> +
>> +static struct clk_regmap pwm_f_sel =
>> +     AML_PWM_CLK_MUX(pwm_f, CLKCTRL_PWM_CLK_EF_CTRL, 25);
>> +static struct clk_regmap pwm_f_div =
>> +     AML_PWM_CLK_DIV(pwm_f, CLKCTRL_PWM_CLK_EF_CTRL, 16);
>> +static struct clk_regmap pwm_f =
>> +     AML_PWM_CLK_GATE(pwm_f, CLKCTRL_PWM_CLK_EF_CTRL, 24);
>> +
>> +static struct clk_regmap pwm_g_sel =
>> +     AML_PWM_CLK_MUX(pwm_g, CLKCTRL_PWM_CLK_GH_CTRL, 9);
>> +static struct clk_regmap pwm_g_div =
>> +     AML_PWM_CLK_DIV(pwm_g, CLKCTRL_PWM_CLK_GH_CTRL, 0);
>> +static struct clk_regmap pwm_g =
>> +     AML_PWM_CLK_GATE(pwm_g, CLKCTRL_PWM_CLK_GH_CTRL, 8);
>> +
>> +static struct clk_regmap pwm_h_sel =
>> +     AML_PWM_CLK_MUX(pwm_h, CLKCTRL_PWM_CLK_GH_CTRL, 25);
>> +static struct clk_regmap pwm_h_div =
>> +     AML_PWM_CLK_DIV(pwm_h, CLKCTRL_PWM_CLK_GH_CTRL, 16);
>> +static struct clk_regmap pwm_h =
>> +     AML_PWM_CLK_GATE(pwm_h, CLKCTRL_PWM_CLK_GH_CTRL, 24);
>> +
>> +static const struct clk_parent_data spicc_parent_data[] = {
>> +     { .fw_name = "oscin" },
>> +     { .fw_name = "sysclk" },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "fdiv2" },
>> +     { .fw_name = "fdiv5" },
>> +     { .fw_name = "fdiv7" }
>> +};
>> +
>> +static struct clk_regmap spicc_0_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_SPICC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spicc_0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = spicc_parent_data,
>> +             .num_parents = ARRAY_SIZE(spicc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap spicc_0_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_SPICC_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 6,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spicc_0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &spicc_0_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap spicc_0 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_SPICC_CLK_CTRL,
>> +             .bit_idx = 6,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spicc_0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &spicc_0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap spicc_1_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_SPICC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 23,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spicc_1_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = spicc_parent_data,
>> +             .num_parents = ARRAY_SIZE(spicc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap spicc_1_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_SPICC_CLK_CTRL,
>> +             .shift = 16,
>> +             .width = 6,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spicc_1_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &spicc_1_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap spicc_1 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_SPICC_CLK_CTRL,
>> +             .bit_idx = 22,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spicc_1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &spicc_1_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data emmc_parent_data[] = {
>> +     { .fw_name = "oscin" },
>> +     { .fw_name = "fdiv2" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "hifi" },
>> +     { .fw_name = "fdiv2p5" },
>> +     { .fw_name = "mpll2" },
>> +     { .fw_name = "mpll3" },
>> +     { .fw_name = "gp0" }
>> +};
>> +
>> +static struct clk_regmap sd_emmc_a_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_a_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = emmc_parent_data,
>> +             .num_parents = ARRAY_SIZE(emmc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_a_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_a_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &sd_emmc_a_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_a = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +             .bit_idx = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_a",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &sd_emmc_a_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_c_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_NAND_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_c_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = emmc_parent_data,
>> +             .num_parents = ARRAY_SIZE(emmc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_c_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_NAND_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_c_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &sd_emmc_c_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_c = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_NAND_CLK_CTRL,
>> +             .bit_idx = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_c",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &sd_emmc_c_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap ts_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_TS_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "ts_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "oscin",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap ts = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_TS_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "ts",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &ts_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_fixed_factor eth_125m_div = {
>> +     .mult = 1,
>> +     .div = 8,
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "eth_125m_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "fdiv2",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap eth_125m = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_ETH_CLK_CTRL,
>> +             .bit_idx = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "eth_125m",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &eth_125m_div.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap eth_rmii_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_ETH_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "eth_rmii_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "fdiv2",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap eth_rmii = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_ETH_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "eth_rmii",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &eth_rmii_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/* Channel 6 is gp1. */
>> +static u32 dspa_parent_table[] = { 0, 1, 2, 3, 4, 5, 7};
>> +
>> +static const struct clk_parent_data dspa_parent_data[] = {
>> +     { .fw_name = "oscin" },
>> +     { .fw_name = "fdiv2p5" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "rtc" },
>> +     { .fw_name = "hifi" },
>> +     { .fw_name = "fdiv4" },
>> +     { .hw = &rtc_clk.hw }
>> +};
>> +
>> +static struct clk_regmap dspa_0_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_DSPA_CLK_CTRL0,
>> +             .mask = 0x7,
>> +             .shift = 10,
>> +             .table = dspa_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "dspa_0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = dspa_parent_data,
>> +             .num_parents = ARRAY_SIZE(dspa_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap dspa_0_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_DSPA_CLK_CTRL0,
>> +             .shift = 0,
>> +             .width = 10,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "dspa_0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &dspa_0_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap dspa_0 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_DSPA_CLK_CTRL0,
>> +             .bit_idx = 13,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "dspa_0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &dspa_0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap dspa_1_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_DSPA_CLK_CTRL0,
>> +             .mask = 0x7,
>> +             .shift = 26,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "dspa_1_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = dspa_parent_data,
>> +             .num_parents = ARRAY_SIZE(dspa_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap dspa_1_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_DSPA_CLK_CTRL0,
>> +             .shift = 16,
>> +             .width = 10,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "dspa_1_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &dspa_1_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap dspa_1 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_DSPA_CLK_CTRL0,
>> +             .bit_idx = 29,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "dspa_1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &dspa_1_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap dspa = {
>> +     .data = &(struct clk_regmap_mux_data){
>> +             .offset = CLKCTRL_DSPA_CLK_CTRL0,
>> +             .mask = 0x1,
>> +             .shift = 15,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "dspa",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &dspa_0.hw,
>> +                     &dspa_1.hw
>> +             },
>> +             .num_parents = 2,
>> +             /*
>> +              * NOTE: This level of mux is "no glitch mux", and mux_0
>> +              * (here dspa_0) is not only the clock source for mux, but also
>> +              * provides a working clock for "no glitch mux". "no glitch mux"
>> +              * can be switched only when mux_0 has a clock input. Therefore,
>> +              * add flag CLK_OPS_PARENT_ENABLE to ensure that mux_0 has clock
>> +              * when "no glitch mux" works.
>> +              */
>> +             .flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
>> +     },
>> +};
>> +
>> +/* Channel 6 is gp1. */
>> +static u32 nna_parent_table[] = { 0, 1, 2, 3, 4, 5, 7};
>> +
>> +static const struct clk_parent_data nna_parent_data[] = {
>> +     { .fw_name = "oscin" },
>> +     { .fw_name = "fdiv2p5" },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "fdiv5" },
>> +     { .fw_name = "fdiv2" },
>> +     { .fw_name = "hifi" }
>> +};
>> +
>> +static struct clk_regmap nna_core_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_NNA_CLK_CNTL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +             .table = nna_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "nna_core_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = nna_parent_data,
>> +             .num_parents = ARRAY_SIZE(nna_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap nna_core_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_NNA_CLK_CNTL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "nna_core_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &nna_core_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap nna_core = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_NNA_CLK_CNTL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "nna_core",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &nna_core_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap nna_axi_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = CLKCTRL_NNA_CLK_CNTL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "nna_axi_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = nna_parent_data,
>> +             .num_parents = ARRAY_SIZE(nna_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap nna_axi_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLKCTRL_NNA_CLK_CNTL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "nna_axi_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &nna_axi_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap nna_axi = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLKCTRL_NNA_CLK_CNTL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "nna_axi",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &nna_axi_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_hw *a5_periphs_hw_clks[] = {
>> +     [CLKID_RTC_XTAL_CLKIN]          = &rtc_xtal_clkin.hw,
>> +     [CLKID_RTC_32K_DIV]             = &rtc_32k_div.hw,
>> +     [CLKID_RTC_32K_MUX]             = &rtc_32k_mux.hw,
>> +     [CLKID_RTC_32K]                 = &rtc_32k.hw,
>> +     [CLKID_RTC_CLK]                 = &rtc_clk.hw,
>> +     [CLKID_SYS_RESET_CTRL]          = &sys_reset_ctrl.hw,
>> +     [CLKID_SYS_PWR_CTRL]            = &sys_pwr_ctrl.hw,
>> +     [CLKID_SYS_PAD_CTRL]            = &sys_pad_ctrl.hw,
>> +     [CLKID_SYS_CTRL]                = &sys_ctrl.hw,
>> +     [CLKID_SYS_TS_PLL]              = &sys_ts_pll.hw,
>> +     [CLKID_SYS_DEV_ARB]             = &sys_dev_arb.hw,
>> +     [CLKID_SYS_MAILBOX]             = &sys_mailbox.hw,
>> +     [CLKID_SYS_JTAG_CTRL]           = &sys_jtag_ctrl.hw,
>> +     [CLKID_SYS_IR_CTRL]             = &sys_ir_ctrl.hw,
>> +     [CLKID_SYS_MSR_CLK]             = &sys_msr_clk.hw,
>> +     [CLKID_SYS_ROM]                 = &sys_rom.hw,
>> +     [CLKID_SYS_CPU_ARB]             = &sys_cpu_apb.hw,
>> +     [CLKID_SYS_RSA]                 = &sys_rsa.hw,
>> +     [CLKID_SYS_SAR_ADC]             = &sys_sar_adc.hw,
>> +     [CLKID_SYS_STARTUP]             = &sys_startup.hw,
>> +     [CLKID_SYS_SECURE]              = &sys_secure.hw,
>> +     [CLKID_SYS_SPIFC]               = &sys_spifc.hw,
>> +     [CLKID_SYS_DSPA]                = &sys_dspa.hw,
>> +     [CLKID_SYS_NNA]                 = &sys_nna.hw,
>> +     [CLKID_SYS_ETH_MAC]             = &sys_eth_mac.hw,
>> +     [CLKID_SYS_RAMA]                = &sys_rama.hw,
>> +     [CLKID_SYS_RAMB]                = &sys_ramb.hw,
>> +     [CLKID_SYS_AUDIO_TOP]           = &sys_audio_top.hw,
>> +     [CLKID_SYS_AUDIO_VAD]           = &sys_audio_vad.hw,
>> +     [CLKID_SYS_USB]                 = &sys_usb.hw,
>> +     [CLKID_SYS_SD_EMMC_A]           = &sys_sd_emmc_a.hw,
>> +     [CLKID_SYS_SD_EMMC_C]           = &sys_sd_emmc_c.hw,
>> +     [CLKID_SYS_PWM_AB]              = &sys_pwm_ab.hw,
>> +     [CLKID_SYS_PWM_CD]              = &sys_pwm_cd.hw,
>> +     [CLKID_SYS_PWM_EF]              = &sys_pwm_ef.hw,
>> +     [CLKID_SYS_PWM_GH]              = &sys_pwm_gh.hw,
>> +     [CLKID_SYS_SPICC_1]             = &sys_spicc_1.hw,
>> +     [CLKID_SYS_SPICC_0]             = &sys_spicc_0.hw,
>> +     [CLKID_SYS_UART_A]              = &sys_uart_a.hw,
>> +     [CLKID_SYS_UART_B]              = &sys_uart_b.hw,
>> +     [CLKID_SYS_UART_C]              = &sys_uart_c.hw,
>> +     [CLKID_SYS_UART_D]              = &sys_uart_d.hw,
>> +     [CLKID_SYS_UART_E]              = &sys_uart_e.hw,
>> +     [CLKID_SYS_I2C_M_A]             = &sys_i2c_m_a.hw,
>> +     [CLKID_SYS_I2C_M_B]             = &sys_i2c_m_b.hw,
>> +     [CLKID_SYS_I2C_M_C]             = &sys_i2c_m_c.hw,
>> +     [CLKID_SYS_I2C_M_D]             = &sys_i2c_m_d.hw,
>> +     [CLKID_SYS_RTC]                 = &sys_rtc.hw,
>> +     [CLKID_AXI_AUDIO_VAD]           = &axi_audio_vad.hw,
>> +     [CLKID_AXI_AUDIO_TOP]           = &axi_audio_top.hw,
>> +     [CLKID_AXI_RAMB]                = &axi_ramb.hw,
>> +     [CLKID_AXI_RAMA]                = &axi_rama.hw,
>> +     [CLKID_AXI_NNA]                 = &axi_nna.hw,
>> +     [CLKID_AXI_DEV1_DMC]            = &axi_dev1_dmc.hw,
>> +     [CLKID_AXI_DEV0_DMC]            = &axi_dev0_dmc.hw,
>> +     [CLKID_AXI_DSP_DMC]             = &axi_dsp_dmc.hw,
>> +     [CLKID_12_24M_IN]               = &clk_12_24m_in.hw,
>> +     [CLKID_12M_24M]                 = &clk_12_24m.hw,
>> +     [CLKID_FCLK_25M_DIV]            = &fclk_25m_div.hw,
>> +     [CLKID_FCLK_25M]                = &fclk_25m.hw,
>> +     [CLKID_GEN_SEL]                 = &gen_sel.hw,
>> +     [CLKID_GEN_DIV]                 = &gen_div.hw,
>> +     [CLKID_GEN]                     = &gen.hw,
>> +     [CLKID_SARADC_SEL]              = &saradc_sel.hw,
>> +     [CLKID_SARADC_DIV]              = &saradc_div.hw,
>> +     [CLKID_SARADC]                  = &saradc.hw,
>> +     [CLKID_PWM_A_SEL]               = &pwm_a_sel.hw,
>> +     [CLKID_PWM_A_DIV]               = &pwm_a_div.hw,
>> +     [CLKID_PWM_A]                   = &pwm_a.hw,
>> +     [CLKID_PWM_B_SEL]               = &pwm_b_sel.hw,
>> +     [CLKID_PWM_B_DIV]               = &pwm_b_div.hw,
>> +     [CLKID_PWM_B]                   = &pwm_b.hw,
>> +     [CLKID_PWM_C_SEL]               = &pwm_c_sel.hw,
>> +     [CLKID_PWM_C_DIV]               = &pwm_c_div.hw,
>> +     [CLKID_PWM_C]                   = &pwm_c.hw,
>> +     [CLKID_PWM_D_SEL]               = &pwm_d_sel.hw,
>> +     [CLKID_PWM_D_DIV]               = &pwm_d_div.hw,
>> +     [CLKID_PWM_D]                   = &pwm_d.hw,
>> +     [CLKID_PWM_E_SEL]               = &pwm_e_sel.hw,
>> +     [CLKID_PWM_E_DIV]               = &pwm_e_div.hw,
>> +     [CLKID_PWM_E]                   = &pwm_e.hw,
>> +     [CLKID_PWM_F_SEL]               = &pwm_f_sel.hw,
>> +     [CLKID_PWM_F_DIV]               = &pwm_f_div.hw,
>> +     [CLKID_PWM_F]                   = &pwm_f.hw,
>> +     [CLKID_PWM_G_SEL]               = &pwm_g_sel.hw,
>> +     [CLKID_PWM_G_DIV]               = &pwm_g_div.hw,
>> +     [CLKID_PWM_G]                   = &pwm_g.hw,
>> +     [CLKID_PWM_H_SEL]               = &pwm_h_sel.hw,
>> +     [CLKID_PWM_H_DIV]               = &pwm_h_div.hw,
>> +     [CLKID_PWM_H]                   = &pwm_h.hw,
>> +     [CLKID_SPICC_0_SEL]             = &spicc_0_sel.hw,
>> +     [CLKID_SPICC_0_DIV]             = &spicc_0_div.hw,
>> +     [CLKID_SPICC_0]                 = &spicc_0.hw,
>> +     [CLKID_SPICC_1_SEL]             = &spicc_1_sel.hw,
>> +     [CLKID_SPICC_1_DIV]             = &spicc_1_div.hw,
>> +     [CLKID_SPICC_1]                 = &spicc_1.hw,
>> +     [CLKID_SD_EMMC_A_SEL]           = &sd_emmc_a_sel.hw,
>> +     [CLKID_SD_EMMC_A_DIV]           = &sd_emmc_a_div.hw,
>> +     [CLKID_SD_EMMC_A]               = &sd_emmc_a.hw,
>> +     [CLKID_SD_EMMC_C_SEL]           = &sd_emmc_c_sel.hw,
>> +     [CLKID_SD_EMMC_C_DIV]           = &sd_emmc_c_div.hw,
>> +     [CLKID_SD_EMMC_C]               = &sd_emmc_c.hw,
>> +     [CLKID_TS_DIV]                  = &ts_div.hw,
>> +     [CLKID_TS]                      = &ts.hw,
>> +     [CLKID_ETH_125M_DIV]            = &eth_125m_div.hw,
>> +     [CLKID_ETH_125M]                = &eth_125m.hw,
>> +     [CLKID_ETH_RMII_DIV]            = &eth_rmii_div.hw,
>> +     [CLKID_ETH_RMII]                = &eth_rmii.hw,
>> +     [CLKID_DSPA_0_SEL]              = &dspa_0_sel.hw,
>> +     [CLKID_DSPA_0_DIV]              = &dspa_0_div.hw,
>> +     [CLKID_DSPA_0]                  = &dspa_0.hw,
>> +     [CLKID_DSPA_1_SEL]              = &dspa_1_sel.hw,
>> +     [CLKID_DSPA_1_DIV]              = &dspa_1_div.hw,
>> +     [CLKID_DSPA_1]                  = &dspa_1.hw,
>> +     [CLKID_DSPA]                    = &dspa.hw,
>> +     [CLKID_NNA_CORE_SEL]            = &nna_core_sel.hw,
>> +     [CLKID_NNA_CORE_DIV]            = &nna_core_div.hw,
>> +     [CLKID_NNA_CORE]                = &nna_core.hw,
>> +     [CLKID_NNA_AXI_SEL]             = &nna_axi_sel.hw,
>> +     [CLKID_NNA_AXI_DIV]             = &nna_axi_div.hw,
>> +     [CLKID_NNA_AXI]                 = &nna_axi.hw,
>> +};
>> +
>> +/* Convenience table to populate regmap in .probe */
>> +static struct clk_regmap *const a5_periphs_clk_regmaps[] = {
>> +     &rtc_xtal_clkin,
>> +     &rtc_32k_div,
>> +     &rtc_32k_mux,
>> +     &rtc_32k,
>> +     &rtc_clk,
>> +     &sys_reset_ctrl,
>> +     &sys_pwr_ctrl,
>> +     &sys_pad_ctrl,
>> +     &sys_ctrl,
>> +     &sys_ts_pll,
>> +     &sys_dev_arb,
>> +     &sys_mailbox,
>> +     &sys_jtag_ctrl,
>> +     &sys_ir_ctrl,
>> +     &sys_msr_clk,
>> +     &sys_rom,
>> +     &sys_cpu_apb,
>> +     &sys_rsa,
>> +     &sys_sar_adc,
>> +     &sys_startup,
>> +     &sys_secure,
>> +     &sys_spifc,
>> +     &sys_dspa,
>> +     &sys_nna,
>> +     &sys_eth_mac,
>> +     &sys_rama,
>> +     &sys_ramb,
>> +     &sys_audio_top,
>> +     &sys_audio_vad,
>> +     &sys_usb,
>> +     &sys_sd_emmc_a,
>> +     &sys_sd_emmc_c,
>> +     &sys_pwm_ab,
>> +     &sys_pwm_cd,
>> +     &sys_pwm_ef,
>> +     &sys_pwm_gh,
>> +     &sys_spicc_1,
>> +     &sys_spicc_0,
>> +     &sys_uart_a,
>> +     &sys_uart_b,
>> +     &sys_uart_c,
>> +     &sys_uart_d,
>> +     &sys_uart_e,
>> +     &sys_i2c_m_a,
>> +     &sys_i2c_m_b,
>> +     &sys_i2c_m_c,
>> +     &sys_i2c_m_d,
>> +     &sys_rtc,
>> +     &axi_audio_vad,
>> +     &axi_audio_top,
>> +     &axi_ramb,
>> +     &axi_rama,
>> +     &axi_nna,
>> +     &axi_dev1_dmc,
>> +     &axi_dev0_dmc,
>> +     &axi_dsp_dmc,
>> +     &clk_12_24m_in,
>> +     &clk_12_24m,
>> +     &fclk_25m_div,
>> +     &fclk_25m,
>> +     &gen_sel,
>> +     &gen_div,
>> +     &gen,
>> +     &saradc_sel,
>> +     &saradc_div,
>> +     &saradc,
>> +     &pwm_a_sel,
>> +     &pwm_a_div,
>> +     &pwm_a,
>> +     &pwm_b_sel,
>> +     &pwm_b_div,
>> +     &pwm_b,
>> +     &pwm_c_sel,
>> +     &pwm_c_div,
>> +     &pwm_c,
>> +     &pwm_d_sel,
>> +     &pwm_d_div,
>> +     &pwm_d,
>> +     &pwm_e_sel,
>> +     &pwm_e_div,
>> +     &pwm_e,
>> +     &pwm_f_sel,
>> +     &pwm_f_div,
>> +     &pwm_f,
>> +     &pwm_g_sel,
>> +     &pwm_g_div,
>> +     &pwm_g,
>> +     &pwm_h_sel,
>> +     &pwm_h_div,
>> +     &pwm_h,
>> +     &spicc_0_sel,
>> +     &spicc_0_div,
>> +     &spicc_0,
>> +     &spicc_1_sel,
>> +     &spicc_1_div,
>> +     &spicc_1,
>> +     &sd_emmc_a_sel,
>> +     &sd_emmc_a_div,
>> +     &sd_emmc_a,
>> +     &sd_emmc_c_sel,
>> +     &sd_emmc_c_div,
>> +     &sd_emmc_c,
>> +     &ts_div,
>> +     &ts,
>> +     &eth_125m,
>> +     &eth_rmii_div,
>> +     &eth_rmii,
>> +     &dspa_0_sel,
>> +     &dspa_0_div,
>> +     &dspa_0,
>> +     &dspa_1_sel,
>> +     &dspa_1_div,
>> +     &dspa_1,
>> +     &dspa,
>> +     &nna_core_sel,
>> +     &nna_core_div,
>> +     &nna_core,
>> +     &nna_axi_sel,
>> +     &nna_axi_div,
>> +     &nna_axi
>> +};
>> +
>> +static const struct regmap_config clkc_regmap_config = {
>> +     .reg_bits       = 32,
>> +     .val_bits       = 32,
>> +     .reg_stride     = 4,
>> +     .max_register   = CLKCTRL_NNA_CLK_CNTL,
>> +};
>> +
>> +static struct meson_clk_hw_data a5_periphs_clks = {
>> +     .hws = a5_periphs_hw_clks,
>> +     .num = ARRAY_SIZE(a5_periphs_hw_clks),
>> +};
>> +
>> +static int aml_a5_peripherals_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct regmap *regmap;
>> +     void __iomem *base;
>> +     int clkid, ret, i;
>> +
>> +     base = devm_platform_ioremap_resource(pdev, 0);
>> +     if (IS_ERR(base))
>> +             return PTR_ERR(base);
>> +
>> +     regmap = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
>> +     if (IS_ERR(regmap))
>> +             return PTR_ERR(regmap);
>> +
>> +     /* Populate regmap for the regmap backed clocks */
>> +     for (i = 0; i < ARRAY_SIZE(a5_periphs_clk_regmaps); i++)
>> +             a5_periphs_clk_regmaps[i]->map = regmap;
>> +
>> +     for (clkid = 0; clkid < a5_periphs_clks.num; clkid++) {
>> +             /* array might be sparse */
>> +             if (!a5_periphs_clks.hws[clkid])
>> +                     continue;
>> +
>> +             ret = devm_clk_hw_register(dev, a5_periphs_clks.hws[clkid]);
>> +             if (ret) {
>> +                     dev_err(dev, "Clock registration failed\n");
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get,
>> +                                        &a5_periphs_clks);
>> +}
>> +
>> +static const struct of_device_id a5_peripherals_clkc_match_table[] = {
>> +     {
>> +             .compatible = "amlogic,a5-peripherals-clkc",
>> +     },
>> +     { /* sentinel */ }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, a5_peripherals_clkc_match_table);
>> +
>> +static struct platform_driver a5_peripherals_driver = {
>> +     .probe          = aml_a5_peripherals_probe,
>> +     .driver         = {
>> +             .name   = "a5-peripherals-clkc",
>> +             .of_match_table = a5_peripherals_clkc_match_table,
>> +     },
>> +};
>> +module_platform_driver(a5_peripherals_driver);
>> +
>> +MODULE_DESCRIPTION("Amlogic A5 Peripherals Clock Controller driver");
>> +MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/clk/meson/clk-regmap.h b/drivers/clk/meson/clk-regmap.h
>> index e365312da54e..1e592d809bfd 100644
>> --- a/drivers/clk/meson/clk-regmap.h
>> +++ b/drivers/clk/meson/clk-regmap.h
>> @@ -134,4 +134,21 @@ struct clk_regmap _name = {                                              \
>>
>>   #define MESON_PCLK_RO(_name, _reg, _bit, _pname)     \
>>        __MESON_PCLK(_name, _reg, _bit, &clk_regmap_gate_ro_ops, _pname)
>> +
> 
> No Amlogic specific clocks should be added to this header.
> This was meant to be generic.
> 
>> +#define MESON_CLK_GATE_FW(_name, _reg, _bit, _fw_name, _ops, _flags) \
>> +struct clk_regmap _name = {                                          \
>> +     .data = &(struct clk_regmap_gate_data){                         \
>> +             .offset = (_reg),                                       \
>> +             .bit_idx = (_bit),                                      \
>> +     },                                                              \
>> +     .hw.init = &(struct clk_init_data) {                            \
>> +             .name = #_name,                                         \
>> +             .ops = _ops,                                            \
>> +             .parent_data = &(const struct clk_parent_data) {        \
>> +                     .fw_name = #_fw_name,                           \
> 
> I think is making the macro difficult to read when used. Pass a string,
> that will be a lot more clear and will not look like a weird identitier.
> 
Will do.

>> +             },                                                      \
>> +             .num_parents = 1,                                       \
>> +             .flags = (_flags),                                      \
>> +     },                                                              \
>> +}
> 
> Given that this is used in A5 only for now, I don't think this needs to
> be in a header just yet. You'll modify this when needed.
> 
OK, I will place it to source file now.
>>   #endif /* __CLK_REGMAP_H */
> 
> --
> Jerome

