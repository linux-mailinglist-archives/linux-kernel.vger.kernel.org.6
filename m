Return-Path: <linux-kernel+bounces-318441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BDA96EDF4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C41288891
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9BF14D282;
	Fri,  6 Sep 2024 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="tShGm2QP"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2134.outbound.protection.outlook.com [40.107.255.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD3075809;
	Fri,  6 Sep 2024 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611222; cv=fail; b=bYiXymp72X8xyfdQj+cAPZDFGHYMsg6VOQpLQ+eJcx5Rsbp/uAH+ffd9njL3RAwT0T2yF8JUrL450yQlXbtF5q9O4W04i+UeEn4Y964bB6XqQbuNFx4F5kCifjIPIvQAvSX6RP1C2sJ7X4ij8TqSX7peaX17cC5L4twz9Kcr+oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611222; c=relaxed/simple;
	bh=WEGtKwwqFX/Q1918HdEKMSfrdujxvipYBuuixgMlIZU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JKRRFGDaEfamGhkmIeL/ayKIpPanUZHXmRiZpOUbaGHEOo+oNWo+tTNRfFmEy0aea89Gj55iL6TzpcKOS7F4MQYBvUDK0S3qEOgphCU7gK60s8zZk+zi7sP7XQ6EHAWhe9PnTj97No76L/cJPdlXN2iOgYtfYPGuJO149YeCEvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=tShGm2QP; arc=fail smtp.client-ip=40.107.255.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LN8odeUYo8buOcVQZWeiQ2FQwTl4mg6Uc/inVFHcH/RYN+duISiaxvwO0PIZTqZQEZTiNFzNe6ckpG1VufdVnsrhaRR5GwI0xePv7uFv9RoGdkvofWVWBTGN+kGVcVJ2o4HXznmcGWrA8YBcLZVyvFDN98vw7jCWmPILcHE5Q+in2t0den6wGfpEyc0gHDrCxvKtgrFub6qb0NpTM2pmH+i6xxCim7L1t5X4/o8IWAStvIhthQbi6jFPbEcr4VESVWnMDKe+8fRo8fTB+yB55uEse29Zl+njqN9CG6cygFDSAnHiRL2suFcY7YJ1lIpCa1oUKQ+X2jZsbb+Tv+Nlkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1ciVIYjbskDo23gAthGkjKyQ3U0/cdZ5/QJpx8TVpY=;
 b=fX+AWWvKNCVuv5sgJGRwIlHE/HjsHEJ0eAm76tT1HIYPASLS6bp3z6y60HudspdJc7Kr/waE1J1K/qDs2AZsyHFCjslMLHZvxqDJ94DNKDT5btAaBK+yKceKrnZis2wuyP41phqIj25WfrFNMxHN3oFsbToWvHAfptYjHXgJ9N7ep0EXKwLTaqchYz//vinuyAyS9Fa33ygD47VZIU1Hu83Dfv11tD9cJt2CvCd95qr2GtEXSNB3iQrkxyK5H6UhEcsxUKFeRp30/6Mw3umEBS+hPT64yFvoWwSv/ckYVk5XnXbK8rqQz0RowYZfbU6X2RPqZV8/PDAJeW9VCux0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1ciVIYjbskDo23gAthGkjKyQ3U0/cdZ5/QJpx8TVpY=;
 b=tShGm2QP+94Gu5Eh6jaIMG7yGjTt9cVLUkuvNf2KyrPJuRYLX27Z0IhKhQ7ZMMxNJ/jlsJBa3WD+QBjikdupwwHGa8LUK/xidSHKr3dTIEZfZbLbo6/C7M3FrYehoC6D4Sni0EOuospR1Hs/6VJFodmNdG273UVQBxOqDhNbwSE4jpdNZT83CWH6mVy7k+SbRxdBDEd73/E2CW3nzjArGYu6zEgWSqHI+d3/q7X6fx3WC+Nv8TUzJFmxJr1X0CsyKdrFGooSrhbvB8ZVA0prERWNsi5MGGJqPRqXIWwnBunYMYOiYyE4yDRPyYRHB3tDi3eXbXWwihRCUq7BGVk4gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by JH0PR03MB8023.apcprd03.prod.outlook.com (2603:1096:990:36::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 08:26:56 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%7]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 08:26:56 +0000
Message-ID: <c2555924-8669-4aec-addd-da54fa4d34e2@amlogic.com>
Date: Fri, 6 Sep 2024 16:26:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] clk: meson: c3: pll: hifi_pll frequency is not
 accurate
To: Jerome Brunet <jbrunet@baylibre.com>,
 Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240906-fix_clk-v1-0-2977ef0d72e7@amlogic.com>
 <20240906-fix_clk-v1-2-2977ef0d72e7@amlogic.com>
 <1jy145qnil.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1jy145qnil.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|JH0PR03MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: 07667471-2f8a-4973-73cc-08dcce4dab45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3hidldvQU1pZ3lVUTNFVXZlMW9GNzViYzlZVTNHOUd4b3RmR1JhMFBZRjRB?=
 =?utf-8?B?S05xOC84K3UvSThPNkRLSGZmWGttcGVDcS9kZi95REwzSXQrdWNNWU82YXVS?=
 =?utf-8?B?UmxpejB3REVUUEhWcHJ4blNjQm1qb3JJY21iNUZ5dTR5SlpHcFQwZk9obThq?=
 =?utf-8?B?alJRQTRWMkRRdE5UY0Y1ako1ZWpnbHgxNllWaFdRRW83OVFoc1VTa0JTZWhB?=
 =?utf-8?B?YWh2bU5WbkRBTThua1dkUFRkWE9YTVI5VUZ5QkpmQVdjdUhpYVhNeUhVMC9h?=
 =?utf-8?B?RmRwSmIzeVZwWHNhWERPdERXNHBjcTJNYysyZUM1ZEx5ekJBRXlvdTVXaFBT?=
 =?utf-8?B?cDF6SkVHTkkrTGtxWnpJdW1aM1dpZkk0cGZPaGRuREp6YjAxV0dCU241dlpJ?=
 =?utf-8?B?UWtDWGp1N281eithS1lEcitVS2g2UXRQMFdrRVF3TzJZS2hsS3g4WXpwMlRZ?=
 =?utf-8?B?bUJybFdZQ2N2QUhWVkxPYUJkQ2JXWlVYWkMyQzBZektOd0IzNnc4bi9VdW8w?=
 =?utf-8?B?ZEpwcWN0bkM4Q0YyTTdPOGpHYmx1Wng3cTVpMElGM3NKR3ZvTTRwYWw2YVhu?=
 =?utf-8?B?TWRSNmM1VFo5MkNRL2xFcmlHVytlcytkRkhzWGkrS3N6WVdTQ3pwQ3RsUVlL?=
 =?utf-8?B?bFhxbDZuYXFNRU92eFhPOTJrU09UaWxLSklZNHI5MXBlZzFuUzZxUE02QU84?=
 =?utf-8?B?ZkREMlFTMktXNmlkS005MmJQUlB3ZFd6Z1RHL2VWbmtOR3BOQXR0U01iZVBw?=
 =?utf-8?B?MURWV2o2VUgxU21KQWkvZWZuWFovNU4xS3VxaWNJRnBVQVhjUklPS0lhTG1I?=
 =?utf-8?B?RU9xdFB1WUk4NFZvNGJ5RGdqenJvdzQvY0xtWkJXL0Y4UlVKemk2V2dnbG5I?=
 =?utf-8?B?R0Ruc1BWWUdoaGVTdTV0RVhQek5Vb0hxWk0rMCt2UU1GSkxTQ1NaSUc0TFI0?=
 =?utf-8?B?TzJJUGpzU1lRVFlpMkRuK2h2NjdEb2I1VFNZNDNXdnhwYWVPUzByQkpSNXZp?=
 =?utf-8?B?bW5UTlVwTUxCcHJyd0lIZGllaDdTSWI3bHl4N0QrYTAvYmIvWkdxQno0SGhQ?=
 =?utf-8?B?MWdCT3pSakJTNUwrSWRKNndWblR3NnpQb3IyUmE3cUExZnJIalkrVWtjc3hG?=
 =?utf-8?B?TTEzeWQzd3NqVUp5SmNUaUlpZmMveWh5YmdVYmg4Vk1raHlqRG5aWUwvLzQ4?=
 =?utf-8?B?dWZLK3k5ZUNOK1RjL1BpUkRHUkdwRE82VnZzbDBpMWI3U2pQMVNDTXBqSkQy?=
 =?utf-8?B?b0dsaC9GYnMvRyt3ZmlzMU9td0lHVkFic0NRb2dlK09TdFBieDNHWHBseFM3?=
 =?utf-8?B?RWlLUytJVkVCbm0vVzI0OUtWa0VVVC9mWFVzU2piS2pSOC9xdk5LME1IVko4?=
 =?utf-8?B?aGNTMVI1T2xsUEtIVHZ3TjRjWE1SaE1wSWZJNkZZRWx2NmJacXh5Q3NlQ0xk?=
 =?utf-8?B?bmpad1FhQ3crczRhcHNIUURNNEx1NlZWK1hXWC8xemJ6Rmp2aUVxYjF2Q2pn?=
 =?utf-8?B?cXViNldPYkJPdlhMTzlaZ2plZXZqQUJneDZYTDBOZDJmZnQvbyt5LzlmZkNq?=
 =?utf-8?B?SE9ONU1DRVlUVk1Vc0ErMVJnbFhLTkIrM2hzemZReHVLUUsrUGJEK1A2RG8y?=
 =?utf-8?B?OVp0WVRUWURIZCthb3VtRzA5ckVlWjZvWjFIWjdFRUl6RkYyL1pRLzQ5SUx1?=
 =?utf-8?B?RThUQ3JGYlY1Q0hqb0VnVVdZdEhpN2EzTEloOEcwd25YbDBkeXBjZ1hkSmtX?=
 =?utf-8?B?cFRqdURDNTlLN1FtZlFqYVIvUEJ4Uk5JVEl3ZGFWQ04wcExmcis1K0hOQVg0?=
 =?utf-8?B?S0xOcndNK2ZZdWtiMFBoQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0ZuSkZlZU94akdxbHB3WlUvWVBaZTNDMjZSZWZBdHNudCtiZW41d0wvZW1p?=
 =?utf-8?B?RUlnUWtTMVhQd0U3QWZKeE50WThGeXJ0aVpYTitoNUtZWlI0VnN2REk0M2th?=
 =?utf-8?B?aVRkS09tekplZkJlUWhlUjduZ3k3cXhBekdKazI3alNxWVVEM1RhZmFtYVZU?=
 =?utf-8?B?SDl3OXlCVWtselpraXdKRy90ay9LdnRBNlhDd1RDbkwyQ21jUkZpOWNBai9i?=
 =?utf-8?B?dWY0WFpOUnhGbjNodlNTNnZwZGpTNjJWV0JzUUc0TzJROGltNjRTbzB0U0ta?=
 =?utf-8?B?K1N6QlExNFVKWi9GVGJkdi9kU0FCVytteWNXdDU2V2lHUGRCRjZObVNOc0Ju?=
 =?utf-8?B?RzFEZlIrd0htblI1SzNaU2NiaURYSDYrTTZRNGNjc3IyOXcxdXEyUkIzZVF6?=
 =?utf-8?B?ZFFxaDJwMHZWdUhpVlJPNGF3YXA4NVl4QjAyNXlZaGhlcWNkR000UktTNWlS?=
 =?utf-8?B?VWtVbkxmd3JJK2JSdCtmam15MGx0VmtRQVI1YWp4bGVrc1lGQVBqSVBxenVs?=
 =?utf-8?B?S3oyRHBzRWVMREZVTzJsVFFXYWt4MU4vNlV0M1dnbExpNDFRWjlkMnhmOGg4?=
 =?utf-8?B?M1FnWUg4eFdFMUxBMXhNbmRlaWUwSTJOQ2s3b0dzTlluRDlkUmxIWEZGdnBJ?=
 =?utf-8?B?RitxZlNsbHQ3TUV5QU9pdWVCd2tMaTVsR1JBR0o1ZG5UVlNlcTVpcW5iS0xL?=
 =?utf-8?B?aEg3OFJ4ak40QnNqZ0hEem1zeTBRQk1JelpHd2prb3htdDlBYWMwNWZFdWFZ?=
 =?utf-8?B?Vmg5Q0FPSTcwckJmMVIyNHd3Y3ZndmFWdTdYdjZaOVRMU1pHTm5HNURxNUl0?=
 =?utf-8?B?Yy8rR2RuQVZkWG53Uk4vUmVWK1dPdmNtditvc1djVUtGNkhMWVJXQ1gxdmZS?=
 =?utf-8?B?NGtlb01XeFV6eEdadlZpWjg1WVpvU2diK1A0clJWMXl3czBMZnJLSTZPcFh2?=
 =?utf-8?B?YUlHZlVkNjY4NDJNUnR1YmtBMzlVSkZDdlN0b0IxdTlWYUNGUFhzdHFJMUdp?=
 =?utf-8?B?YndQRXIrTFJkUVZpSFIxNUZtbXJTbWxiWDFXblFLVm85a2V3bk1maTU2M1dR?=
 =?utf-8?B?U2F1c3hRQTZCakc0ZVR5V2tzYzRpNFY3NW0zM2RDREgzTjhBOElEYlBRanoy?=
 =?utf-8?B?eG55d3g4cnpWTzg1b2QwcHk3Vm53aENXd3U1bFhKOXdyNGRudFAzL3pjdk5R?=
 =?utf-8?B?MGRlZTFaZ1ZEZno1VHBRc25FR2tYekNmdGtseU1kYXhzNDZNdXBNMS9qdHFx?=
 =?utf-8?B?dzVmSTNHMUJZMVZYQVFYSlYyRjUzQUV5VlJWQW9OWU0rb0pZWjg0UFFrOTBr?=
 =?utf-8?B?NlpVTHp3RjlVUlg5OGNqSnFpK3VGcUE0ZjFDbENjc3ZYM2xPU1ZreGNNRDBT?=
 =?utf-8?B?UFlMZzhNU0RIS2MvWTBMcWErUlhEUm9NRmE4WlFDNjJTalhiaVZwKzIxNFRT?=
 =?utf-8?B?aFMvN1RwK2VqeTh4NXpZcEFwemJidEpOU2szU21zLzZkQm84TDN1OGduNk04?=
 =?utf-8?B?cFZ3RlBQZFpXSlg4VVI5ZkdkaUJ2RDAxMGxmVXI3bmhsTTQrOWNSMFI2TFJw?=
 =?utf-8?B?YjV5VzRjcTc3Mk9Ud1cxYk9wTk8yY0tQNzV5M1J3Sm9RaGNLT1NMQitzbElO?=
 =?utf-8?B?SkRGaGFhaWc0cGNmWlYvREJFVkxnUHBXUGdMUTFvNmhveDJWWUJqdHpZSTQv?=
 =?utf-8?B?bDIzeUpZZnBMNUo3ZmVMTHgwR29VVDMxbzc1bWxiK1k2VVRvcHp4cFZISlFX?=
 =?utf-8?B?WUYzK1MvZGlqcXJHR2dsYlhNYjY5elNMbHhaOU9oVE1tSnhqOUFMdk1qb1Jw?=
 =?utf-8?B?YTRUY2drZkhaSXRNU01GWWVHZXpzRWxqWFlFemY4bjBUN3lJUWpJNFJ5U3V6?=
 =?utf-8?B?bzRaSWM2WTdkVXMwbG1Mb2VoWldZbDlPVjIwM0NZalFhYWNnSDUvSjNYNnBK?=
 =?utf-8?B?NVlxb212NDZYTVFPZGRpdUM4c2RGWFVRZU5SVEM0QTZjWldLZ2UrczJ4Wk42?=
 =?utf-8?B?T2xaNUNBWUt0L3hFTjFHRXdybmlJSDNSMDllZElmb1pFa3MzT1FiMVlycHNk?=
 =?utf-8?B?ZWVCam1MY3BpUU9WL3NqRTliVWVCU0JRcDc2UkQzZTRMNE4yb3RJMUxyNmE4?=
 =?utf-8?Q?L5nkOnz58ezdo7Mh+lpKfJDnm?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07667471-2f8a-4973-73cc-08dcce4dab45
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 08:26:56.1948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P061fcz6tk90CuIHNm9jW6V2XO0SJ39070cHe/2Hbs+Emkst82ey4DvBMGatoJc7ct/91ugpEoRvQyW43jAucQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8023


On 2024/9/6 14:55, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Fri 06 Sep 2024 at 13:52, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>
>> From: Chuan Liu <chuan.liu@amlogic.com>
> The patch title is not good. the clock innacurate ... Ok, but you are doing
> something about it, right ? Plus just saying that is a bit vague.
>
> How about something like "fix frac maximum value" ? This what you are
> doing, right ?


Right, Fix in next version.


>> The fractional denominator of C3's hifi_pll fractional multiplier is
>> fixed to 100000, so flag CLK_MESON_PLL_FIXED_FRAC_MAX is added.
>>
>> Fixes: 8a9a129dc565 ("clk: meson: c3: add support for the C3 SoC PLL clock")
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> ---
>>   drivers/clk/meson/c3-pll.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clk/meson/c3-pll.c b/drivers/clk/meson/c3-pll.c
>> index 32bd2ed9d304..a350173efe90 100644
>> --- a/drivers/clk/meson/c3-pll.c
>> +++ b/drivers/clk/meson/c3-pll.c
>> @@ -361,6 +361,7 @@ static struct clk_regmap hifi_pll_dco = {
>>                .range = &c3_gp0_pll_mult_range,
>>                .init_regs = c3_hifi_init_regs,
>>                .init_count = ARRAY_SIZE(c3_hifi_init_regs),
>> +             .flags = CLK_MESON_PLL_FIXED_FRAC_MAX,
>>        },
>>        .hw.init = &(struct clk_init_data) {
>>                .name = "hifi_pll_dco",
> --
> Jerome

