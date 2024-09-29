Return-Path: <linux-kernel+bounces-342859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ECA9893B4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 10:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107DB1F21DCC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 08:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C557A13B5B6;
	Sun, 29 Sep 2024 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="meNMIn0j"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2121.outbound.protection.outlook.com [40.107.215.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910DE1F60A;
	Sun, 29 Sep 2024 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727597875; cv=fail; b=jRKkI44qWHKRsv4vu9P8wsUU35u+DOLkONQlQhPpODtQxTmjSDwjX8YhF2KOMj6BTn3VW/SUhhTgnBmmqzreK+Z6ZSuj17qs6i5kEp187NwitJ9QfGqYICyWMWYix6qvo+WXzj8JIl+mh8QMj4feiHlA1uJOI8kMLMuhSSxgqAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727597875; c=relaxed/simple;
	bh=FLxiGqM+1MWvYxjepZmp0+ROLWJQcDLoV0hDqKsE+NA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wk2I1X5qaspM+iLYfDUHijac+T532g0XccIAPHShUAmJ7/SKHTQJtaKR6L72snK0+qXSbnpFb3gIIdP+EqeHgDbcUOXhDKNB9OXTUcdubtwfy+OBu0+G7BHGTGlpZqOM4/3XlKZ5GWCJs8m1gOYjVxMZLBYffAQcjQhke/wPMdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=meNMIn0j; arc=fail smtp.client-ip=40.107.215.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sg05U9aOX0dKE4/4MXNiN1DCil3oJSJOVLIK3/nhEd/MFquMbZFsAMnv28LJR4RpBgXAvv2K1l4UniEFKmg89vB7ltmFhVQgRawF0yEwL5MR7Vb9ek8dSL3V2A6b/j45ypY+eXrQ1NZJ077AGdFgSIGsw4zLYpE4HoLK2PZye/Ujuq/ci5gsJnyZIbjafh5D629o84jirNZPfF1i4giqRgPAKvL9ObpJmEITR7Yz2dyccffvW/GJi5T7KlJYkd7rrk76Qk6jG8burdyme7T8x7kAdOCA56fILPW3OqAUSvlcmw2l4nYhuCuiTP+7k8/ogFyuU58V2n+PsxACrZlAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49gT2r16Nrw6xBNmqBz+yS47ZYzksTnAHkSqGfn5MrU=;
 b=a3jhYFxSDHyaTz9iOOAV0edpLz/l6MAaXnpMfeMuuXlv6f4SqvmsOkqk0Dv013Qv19YzOlal4NtDgYaSSKDheaCnOkn2hL3gN89S14a9Ib9kefBPF+6VlYUClGExEQfZ15GkXE5cJg+yQo7qCZ5SOHOZ2J+sIIq0OMeBlb0F9/VbjsR614LE8t8zCoTU0wSEjX6H5ZcQwF81QSez1dzU+RDv3n+TgrvCArg71//HZV+kZnu8UOO0qVRqzKn7YHKM8w0U9QdtRuDR+x3V1yzDv59wMeFHBHFvvLQxZqHyoAvbhqzEWgv7Dw24l54zsXnvsphg8J7hvnakQ6Ld9sQMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49gT2r16Nrw6xBNmqBz+yS47ZYzksTnAHkSqGfn5MrU=;
 b=meNMIn0jsq3+uQkFNf+f03x1FnVb3hThXi+1x3ZoUeybJIDr8hlu80WPm0lVimGN0GDG5VcblOx+I4DzK95BrUslOmiWpjwiTk7NrGJcS1AgqdByo49sKao2hXeVPGoGAgHUAGE5083fk58qoq7SR0lkoMjDFFtLMn+dWBBLYwlfvz49e++byE42QIf8CKkdu1FUccDF2SVYCFzcCApy2h6kVxd4ZS30MXlT+Coal8Bu7vXRWeYvy7HEpcdDSKrVLeLJMbTU1dDPOSMuHcyOwcdJ7Bo3UUhNe+7YqCEMPOXoXwkSjZCo44FNP81JLJKM670s7My+eINrRHwq4oCglQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KL1PR03MB8087.apcprd03.prod.outlook.com (2603:1096:820:fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Sun, 29 Sep
 2024 08:17:47 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%3]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 08:17:47 +0000
Message-ID: <4e2c7bb7-b97c-43c3-8938-4831e9d1376d@amlogic.com>
Date: Sun, 29 Sep 2024 16:17:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] clk: meson: add support for the A5 SoC PLL clock
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
References: <20240914-a5-clk-v1-0-5ee2c4f1b08c@amlogic.com>
 <20240914-a5-clk-v1-4-5ee2c4f1b08c@amlogic.com>
 <1jplotxg8e.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <1jplotxg8e.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KL1PR03MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: eec465c9-0648-4ca6-e708-08dce05f32ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXhnYU95VkdBV0xsMlBSM2ppandickE1L3pRWWpoMGYrUXpCWU5BcTUyWkdp?=
 =?utf-8?B?WXBHSXNLaEFkdHZ4TGdMUTd1ZVRkVFdnWVNZZ3I2TklaakNDL3dPZzIraW9D?=
 =?utf-8?B?VjdsOGptczZPZ1Q2RlJhVVgrUGVzK1hyazZSQVo0a3lsdUI2ZENyQWlESCt4?=
 =?utf-8?B?TkRYQ2xVcW10TFY2RW1pNGRad0dxQmk1SFE2SWhzQ0JoVU1KUzg1dWlDM1dl?=
 =?utf-8?B?RlNESW9oUkpjYnlIS1dxb0Zoc0s3RUxZREZxNlR4SjNuQ3RHbktLVTArZlQ4?=
 =?utf-8?B?V1F0Qmg4KzBNeENMMlZWeTQwaHZIVjZJcW9vWHFhSzZ2N2dBSVBhTzYycm93?=
 =?utf-8?B?dzRPNjZxZzY3SDVpWmhzbTlKWS9Yd3Q0d2ErcmdZM3BmYXVjTU1sdmhoNVdL?=
 =?utf-8?B?eFZ4NWpueUxTeDdjbFFURmt3U29jbndQOTRFOW1oajBubCtoWWVpSTN2TUlj?=
 =?utf-8?B?UE4zaUJCN3J0ZGlIQ2xRNXhsU3FqMnNhTnZ6ZFgxNkgva3o2MHJCM1A3NjVI?=
 =?utf-8?B?WHRJcUpLVkpuVnFsU3ZqZk5QYkpUZFVrdHpPRDU1RHhuQ3o1MENnZXBkRzRq?=
 =?utf-8?B?VkxTaTR6bjNENWo5OExTRzFyRW5EOGpxNUNleWtzR280YkpzVjltbFM4cEJV?=
 =?utf-8?B?Ni9HUmd1VXo2RWlWTml4WnFuWjlVdWNyWS93UVF1RVFOSUJzUlE5MDNxNXBG?=
 =?utf-8?B?UzU4cnJtRkl4eG9sT29pQWNURUw4RFJQTkpEUjdsV0R1akRKM29tV2RLZW1l?=
 =?utf-8?B?Q2xERFl5dCthRTlWVkpvRDloaXJlZVBTY0wyb25VT2NYS2Y3N29UMzBuVDBQ?=
 =?utf-8?B?MFppeWllOWY0N2J3a3M1WGQyRklHUHBwUkd2YS80bFIvK3FBb3UvZXBiUzJN?=
 =?utf-8?B?RUgrUmdXcTRZOTJUSTFrSjRuOWFFY3M4cFdhcVRaQ29LYUFlZVMrSjBjMFVE?=
 =?utf-8?B?ZysvRmtQeElDSkw2UDZhUlEwMlpwRjl5TzcxK09XRm00VGJ5UXd0UHhDUDAx?=
 =?utf-8?B?V0FpeDJRbnRqSUtHSm8ya25SemNwL2Qxc2RSUVJJVFQxMUpwb2R0Zys4eFRq?=
 =?utf-8?B?aGhvQXJYN2xxZGNUR0VlTDVTZklLNDFLbHVwVHhvUHc1aWN2VmNPOVBKRVNP?=
 =?utf-8?B?T2xKcnVqRU1IWGh2RGdlUjhDTDlRdjNjQ0FtbTA1dE5sWVllUTNzdmUvbzJt?=
 =?utf-8?B?NUhJdEFwNFhzUmdUS0JrUEpKRk1BbVIwWjAyaHJSS29ITlRZSXhQM2wzNkhi?=
 =?utf-8?B?bVBzcXJscUljemxJeGFTN1JsT2FsT0d5V2l6M0RkblBwT0F2eHR5UHloOEow?=
 =?utf-8?B?MkNWczZpWXJnNVo0RUpwakNXemNSYzVjaTFCd2ZsTDhmZzJvZ3JBcXZmNHhK?=
 =?utf-8?B?SVRCTEYyZzh1eno0YkVwNjcyTm1TTVlVVUpIbEp2S2x2TFh3Kzd6OWN0aGdi?=
 =?utf-8?B?bUxUOEoxNEVHY2FWQWlYOTBBTmY4M2tOMmIwNnRNWWJqcnVNd1JYelBkcW8z?=
 =?utf-8?B?VEh3aW91aWVYVDJOQVZDVWg0K1ZyQXQ2d0FxY0VielQ4d1BpRlZGUTNHVm5w?=
 =?utf-8?B?ejdSUFgxWE0vWnZydEU0OFZ3STIvMCtsa1hiYUlKUWdkTEJRUmhzQXJxSVFp?=
 =?utf-8?B?YXhkUnBoRmxrNllkNitwU3MwN2JUdkQ5OUE4S1BNd1RZZnd1YkNKUHRGLzl4?=
 =?utf-8?B?eXU1WkpUM0sya04yWlduSkNsTmloekJEbUNRVmdIbERnVWljM1RhMDZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0lEc2srUzBQbGFEOGdyeUl2ZDBEWm9ycmVkZzZpMTJwTFBkdFpVWGNhbjRU?=
 =?utf-8?B?b003YnhVNVgzb1FPNEdxbUJ5dUpNVGRwTmNjUFY0QzQrd2Z4Q2MyMlE5aDVX?=
 =?utf-8?B?Nm55R2RiZ3A3MG5obGI2VDZlWjl6bUFvU0h2UEp0ZWZNTk5xQjNURE1aYTVT?=
 =?utf-8?B?OEhUZk5ycEJpejh5VHU5d2ozdDUyaCtHMG5GbHBmMDdIQ2lJYzZwTmtvcWFR?=
 =?utf-8?B?aVNqRkNNUnBNMnBWWXlibE4wVHc0c3hBc0VZK3dLU1RSYWlmb3JpL0UwZWJ5?=
 =?utf-8?B?RnhCRWdmK3FvbzhuV2hyM096aXhWQWx4MktUYStmbTYxU0hWUFF1OXU1Wk5F?=
 =?utf-8?B?TDNxbFFHNFFJZitGSTZEditOVjRqSjNLeXJtd2poYlVYTlRNQUdkSzBsR3pO?=
 =?utf-8?B?WFE0UitpREVpUFJpQVBmL00zVEJTQ1NaTzhwMGhKeGRtRy8zRDBXNTdjc3o3?=
 =?utf-8?B?d2Y2RTBZSDFraGlDbW55Y1pweWZ5NHBVOTNSTkZTSEhMaTVnUmF0VW8xcXhJ?=
 =?utf-8?B?MlZoQk10alNWY20rYTEwRGxZUzdsdVhwdjA1NW1iK3ZDQmo2dDM3TFFHbndx?=
 =?utf-8?B?NWZ5aWNlOERDQk95MUR1VysvRWJOa1NENHZNNG93V2V3RjdmRDRGNWFFZ3Nk?=
 =?utf-8?B?TXdNVDJ5MGhDSDNKMm1zV012ZzF5Zmcyc3BTdDJHdW9NTHViOHI1aEc1STJU?=
 =?utf-8?B?cGRmNEo4MmhZZ1FUSnFhSzRsalEyRFcyRlhPT25QU2VzQlQ4alVVN0Y1d2ZT?=
 =?utf-8?B?T3I2dXVhUnE0bWJyS0ZSOVRTc2RrS3NBN3ZpMUUzWXZIR2hUOWpyazFFeDRR?=
 =?utf-8?B?a284UEs4S3JDWFN6WS9ObEdjODZVZVAzcVE1N0pCNzNVd1htNm12c1VQZnF3?=
 =?utf-8?B?a255T3RsQThQN1FUVEp5T29IajNxRWhPWjRsYTUrVzB6cFNVV0tuWGViZkZV?=
 =?utf-8?B?c1NsSWlpT2V0MC9JbWFIM2RxUElodFp3OVpGU2RKUUxFTm9SaGFYVEUyYWNp?=
 =?utf-8?B?QmpqMjl3NjhIZExJek1wZXBob1RJSDQvekpQYUoxV25KLzhyN0gvdmg5M1BE?=
 =?utf-8?B?azJGOXcwU1dyY1dDV0FDWmdyMUptUHdwOEZXZFBaRTVwOC9BNXdDM3lsVnpZ?=
 =?utf-8?B?YmpnYXBJUE5qOFNydlBnbGZpZHA2cE00ajEzYTM0cTIzbkNVZUluemR6Mncy?=
 =?utf-8?B?ejBJS3c2WkZhUmtoVExCTm9RZEF0Q1pQcERGOW9PajNQU0VPRU5hdUdnZlp5?=
 =?utf-8?B?djdMK2ViYm44VEMzSm96UXhlM2JXamxYRS9DclB5T3V1SU9xRDFMNWwzU1Fa?=
 =?utf-8?B?U0lFdmlsdDRheE93RVUrSmhEeGE0S3lPeGN4ZFdzRzJnSFFxeWhoZE9TRHdj?=
 =?utf-8?B?ZGhWVzlIR2t0SEFUUjZkbHByTTk2UWJOSDVtd2dNeHd2aHR5SlJ3OXFWWU81?=
 =?utf-8?B?aHBQOHNBakM1dlFzK2drNDhxYjVGL2VvYXdDR3pBZGRtYkMyNTc2ZHJJY3F5?=
 =?utf-8?B?NEhRU2Z3eCt4bWRrc1FVaVRPc3hzTUltWjJtS2NibWlUNCsvc2JBVXNuM05s?=
 =?utf-8?B?UGVSY1ZGVk5YSHhYY0ZDK0hFVG8wdU1oM0tjUENsTkR3U09WcitJbVZPUW9J?=
 =?utf-8?B?bGxtdStqQkgwS3psSnJqQ3VzYW43WnhIRE1BeFZnRUtlWitld2RTT2hvQk8r?=
 =?utf-8?B?VTRPWjlUUkJydVR1bU9RTTB2ZDVZL1BtNlIyQnBUUkQ1KzQzVnAyRVNBc0ww?=
 =?utf-8?B?VEFFRlJFa3hHSlYxOURvbjE1bEV4R2tVWURRdEJ0dDg3SW5uL0JyVmh1UWIz?=
 =?utf-8?B?NTZLbFIxbHA0NTM0dFJ5T3l3NUhzMFV1Vnk2VGhjdnp2djdiQ2FLTW56Wmlj?=
 =?utf-8?B?OTc4T0liWFJYdmFJT1B1NmxrUDFZRHhDVVhDM0RuU3I0V2UwZi8yYUJSOXk3?=
 =?utf-8?B?L2kwNVBiNmlPVHJkMTRqaWR4bURrdzZMa2dmUlVaZDhvRWJSZTZYSlhyQmVV?=
 =?utf-8?B?MWdpa2pCdFpGRko5dnZINE9mbWNNM0VNNGs0TktTRGFTUmdvVjZjaXM1R3FM?=
 =?utf-8?B?UFF5TDBJSkNzd1FDbkZPRkZKcXBGbENGVEdqVDVuL2liQ1FpNmd0bE4rNk9Z?=
 =?utf-8?B?UHMvNWRWVnNRYXA3RWFjd2ZyVnpYNE1EdW5yN0MyMzl6M3VyVXFzNmpmWitH?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec465c9-0648-4ca6-e708-08dce05f32ae
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 08:17:45.8402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/ToKsKx8fN3GyY0N/RifdxOXU9smYbsREUyAgdvhQm2Zm2W23lrd6nOsEkggOGtr1cRVmDGqeeQElnPuVJsO6IIiA23hprW2/Xdys3eEXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8087

Hi Jerome,
    Thanks for your reply.

On 2024/9/24 22:45, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Sat 14 Sep 2024 at 13:25, Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
> 
>> From: Chuan Liu <chuan.liu@amlogic.com>
>>
>> Add the PLL clock controller driver for the Amlogic A5 SoC family.
>>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   drivers/clk/meson/Kconfig  |  14 ++
>>   drivers/clk/meson/Makefile |   1 +
>>   drivers/clk/meson/a5-pll.c | 553 +++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 568 insertions(+)
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index 78f648c9c97d..2a713276e46c 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -132,6 +132,20 @@ config COMMON_CLK_A1_PERIPHERALS
>>          device, A1 SoC Family. Say Y if you want A1 Peripherals clock
>>          controller to work.
>>
>> +config COMMON_CLK_A5_PLL
>> +     tristate "Amlogic A5 PLL clock controller"
>> +     depends on ARM64
>> +     default y
>> +     imply ARM_SCMI_PROTOCOL
> 
> don't think this is needed, same as c3
> 

Will delete it in the next version.

>> +     imply COMMON_CLK_SCMI
>> +     select COMMON_CLK_MESON_REGMAP
>> +     select COMMON_CLK_MESON_PLL
>> +     select COMMON_CLK_MESON_CLKC_UTILS
>> +     help
>> +       Support for the PLL clock controller on Amlogic AV40x device, AKA A5.
>> +       Say Y if you want the board to work, because PLLs are the parent
>> +       of most peripherals.
>> +
>>   config COMMON_CLK_C3_PLL
>>        tristate "Amlogic C3 PLL clock controller"
>>        depends on ARM64
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index bc56a47931c1..fc4b8a723145 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -20,6 +20,7 @@ obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>>   obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>>   obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
>> +obj-$(CONFIG_COMMON_CLK_A5_PLL) += a5-pll.o
>>   obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
>>   obj-$(CONFIG_COMMON_CLK_C3_PERIPHERALS) += c3-peripherals.o
>>   obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>> diff --git a/drivers/clk/meson/a5-pll.c b/drivers/clk/meson/a5-pll.c
>> new file mode 100644
>> index 000000000000..d96ed72ef8d4
>> --- /dev/null
>> +++ b/drivers/clk/meson/a5-pll.c
>> @@ -0,0 +1,553 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Amlogic A5 PLL Controller Driver
>> + *
>> + * Copyright (c) 2024 Amlogic, inc.
>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/platform_device.h>
>> +#include "clk-regmap.h"
>> +#include "clk-pll.h"
>> +#include "clk-mpll.h"
> 
> Kconfig does not select support for this, so something is odd.

Will add select COMMON_CLK_MESON_MPLL in Kconfig file

> 
>> +#include "meson-clkc-utils.h"
>> +#include <dt-bindings/clock/amlogic,a5-pll-clkc.h>
>> +
>> +#define ANACTRL_FIXPLL_CTRL1                 0x44
>> +#define ANACTRL_GP0PLL_CTRL0                 0x80
>> +#define ANACTRL_GP0PLL_CTRL1                 0x84
>> +#define ANACTRL_GP0PLL_CTRL2                 0x88
>> +#define ANACTRL_GP0PLL_CTRL3                 0x8c
>> +#define ANACTRL_GP0PLL_CTRL4                 0x90
>> +#define ANACTRL_GP0PLL_CTRL5                 0x94
>> +#define ANACTRL_GP0PLL_CTRL6                 0x98
>> +#define ANACTRL_HIFIPLL_CTRL0                        0x100
>> +#define ANACTRL_HIFIPLL_CTRL1                        0x104
>> +#define ANACTRL_HIFIPLL_CTRL2                        0x108
>> +#define ANACTRL_HIFIPLL_CTRL3                        0x10c
>> +#define ANACTRL_HIFIPLL_CTRL4                        0x110
>> +#define ANACTRL_HIFIPLL_CTRL5                        0x114
>> +#define ANACTRL_HIFIPLL_CTRL6                        0x118
>> +#define ANACTRL_MPLL_CTRL0                   0x180
>> +#define ANACTRL_MPLL_CTRL1                   0x184
>> +#define ANACTRL_MPLL_CTRL2                   0x188
>> +#define ANACTRL_MPLL_CTRL3                   0x18c
>> +#define ANACTRL_MPLL_CTRL4                   0x190
>> +#define ANACTRL_MPLL_CTRL5                   0x194
>> +#define ANACTRL_MPLL_CTRL6                   0x198
>> +#define ANACTRL_MPLL_CTRL7                   0x19c
>> +#define ANACTRL_MPLL_CTRL8                   0x1a0
>> +
>> +static DEFINE_SPINLOCK(aml_clk_lock);
> 
> Re-submit you lock patch first and adjust please.
> 

Will do.

>> +
>> +static struct clk_fixed_factor mpll_prediv = {
>> +     .mult = 1,
>> +     .div = 2,
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll_prediv",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "fix_dco"
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static const struct reg_sequence mpll0_init_regs[] = {
>> +     { .reg = ANACTRL_MPLL_CTRL2,    .def = 0x40000033 },
>> +};
>> +
>> +static struct clk_regmap mpll0_div = {
>> +     .data = &(struct meson_clk_mpll_data){
>> +             .sdm = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 14,
>> +             },
>> +             .sdm_en = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL1,
>> +                     .shift   = 30,
>> +                     .width   = 1,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL1,
>> +                     .shift   = 20,
>> +                     .width   = 9,
>> +             },
>> +             .ssen = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL1,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .lock = &aml_clk_lock,
>> +             .init_regs = mpll0_init_regs,
>> +             .init_count = ARRAY_SIZE(mpll0_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll0_div",
>> +             .ops = &meson_clk_mpll_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mpll_prediv.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mpll0 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_MPLL_CTRL1,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &mpll0_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct reg_sequence mpll1_init_regs[] = {
>> +     { .reg = ANACTRL_MPLL_CTRL4,    .def = 0x40000033 },
>> +};
>> +
>> +static struct clk_regmap mpll1_div = {
>> +     .data = &(struct meson_clk_mpll_data){
>> +             .sdm = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL3,
>> +                     .shift   = 0,
>> +                     .width   = 14,
>> +             },
>> +             .sdm_en = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL3,
>> +                     .shift   = 30,
>> +                     .width   = 1,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL3,
>> +                     .shift   = 20,
>> +                     .width   = 9,
>> +             },
>> +             .ssen = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL3,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .lock = &aml_clk_lock,
>> +             .init_regs = mpll1_init_regs,
>> +             .init_count = ARRAY_SIZE(mpll1_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll1_div",
>> +             .ops = &meson_clk_mpll_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mpll_prediv.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mpll1 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_MPLL_CTRL3,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &mpll1_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct reg_sequence mpll2_init_regs[] = {
>> +     { .reg = ANACTRL_MPLL_CTRL6,    .def = 0x40000033 },
>> +};
>> +
>> +static struct clk_regmap mpll2_div = {
>> +     .data = &(struct meson_clk_mpll_data){
>> +             .sdm = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL5,
>> +                     .shift   = 0,
>> +                     .width   = 14,
>> +             },
>> +             .sdm_en = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL5,
>> +                     .shift   = 30,
>> +                     .width   = 1,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL5,
>> +                     .shift   = 20,
>> +                     .width   = 9,
>> +             },
>> +             .ssen = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL5,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .lock = &aml_clk_lock,
>> +             .init_regs = mpll2_init_regs,
>> +             .init_count = ARRAY_SIZE(mpll2_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll2_div",
>> +             .ops = &meson_clk_mpll_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mpll_prediv.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mpll2 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_MPLL_CTRL5,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll2",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &mpll2_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct reg_sequence mpll3_init_regs[] = {
>> +     { .reg = ANACTRL_MPLL_CTRL8,    .def = 0x40000033 },
>> +};
>> +
>> +static struct clk_regmap mpll3_div = {
>> +     .data = &(struct meson_clk_mpll_data){
>> +             .sdm = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL7,
>> +                     .shift   = 0,
>> +                     .width   = 14,
>> +             },
>> +             .sdm_en = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL7,
>> +                     .shift   = 30,
>> +                     .width   = 1,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL7,
>> +                     .shift   = 20,
>> +                     .width   = 9,
>> +             },
>> +             .ssen = {
>> +                     .reg_off = ANACTRL_MPLL_CTRL7,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .lock = &aml_clk_lock,
>> +             .init_regs = mpll3_init_regs,
>> +             .init_count = ARRAY_SIZE(mpll3_init_regs),
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll3_div",
>> +             .ops = &meson_clk_mpll_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mpll_prediv.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mpll3 = {
>> +     .data = &(struct clk_regmap_gate_data){
>> +             .offset = ANACTRL_MPLL_CTRL7,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data){
>> +             .name = "mpll3",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) { &mpll3_div.hw },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct reg_sequence gp0_init_regs[] = {
>> +     { .reg = ANACTRL_GP0PLL_CTRL0, .def = 0X08000000 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL1, .def = 0x00000000 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL2, .def = 0x00000000 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL3, .def = 0x6a295c00 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL4, .def = 0x65771290 },
>> +     { .reg = ANACTRL_GP0PLL_CTRL5, .def = 0x3927200a },
>> +     { .reg = ANACTRL_GP0PLL_CTRL6, .def = 0x54540000 }
>> +};
>> +
>> +static const struct pll_mult_range gp0_pll_mult_range = {
>> +     .min = 125,
>> +     .max = 250,
>> +};
>> +
>> +static struct clk_regmap gp0_pll_dco = {
>> +     .data = &(struct meson_clk_pll_data) {
>> +             .en = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .m = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 8,
>> +             },
>> +             .frac = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 17,
>> +             },
>> +             .n = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>> +                     .shift   = 10,
>> +                     .width   = 5,
>> +             },
>> +             .l = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>> +                     .shift   = 31,
>> +                     .width   = 1,
>> +             },
>> +             .rst = {
>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .range = &gp0_pll_mult_range,
>> +             .init_regs = gp0_init_regs,
>> +             .init_count = ARRAY_SIZE(gp0_init_regs),
>> +             .frac_max = 100000,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "gp0_pll_dco",
>> +             .ops = &meson_clk_pll_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "xtal_24m",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +/* The maximum frequency divider supports is 16, not 128(2^7) */
>> +static const struct clk_div_table gp0_pll_od_table[] = {
>> +     { 0,  1 },
>> +     { 1,  2 },
>> +     { 2,  4 },
>> +     { 3,  8 },
>> +     { 4, 16 },
>> +     { 5, 32 },
>> +     { /* sentinel */ }
>> +};
>> +
>> +static struct clk_regmap gp0_pll = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = ANACTRL_GP0PLL_CTRL0,
>> +             .shift = 16,
>> +             .width = 3,
>> +             .table = gp0_pll_od_table,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "gp0_pll",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &gp0_pll_dco.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct reg_sequence hifi_init_regs[] = {
>> +     { .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0X08000000 },
> 
> What is bit you are flipping in CTRL0 ? it is suspicious
> 

Yes, CTRL0 and CTRL1 are not necessary here and will be removed in the
next version.

>> +     { .reg = ANACTRL_HIFIPLL_CTRL1, .def = 0x00000000 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x00000000 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL3, .def = 0x6a295c00 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x65771290 },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL5, .def = 0x3927200a },
>> +     { .reg = ANACTRL_HIFIPLL_CTRL6, .def = 0x54540000 }
>> +};
>> +
>> +static const struct pll_mult_range hifi_pll_mult_range = {
>> +     .min = 125,
>> +     .max = 250,
>> +};
>> +
>> +static struct clk_regmap hifi_pll_dco = {
>> +     .data = &(struct meson_clk_pll_data) {
>> +             .en = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .m = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 8,
>> +             },
>> +             .frac = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 17,
>> +             },
>> +             .n = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                     .shift   = 10,
>> +                     .width   = 5,
>> +             },
>> +             .l = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                     .shift   = 31,
>> +                     .width   = 1,
>> +             },
>> +             .rst = {
>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>> +                     .shift   = 29,
>> +                     .width   = 1,
>> +             },
>> +             .range = &hifi_pll_mult_range,
>> +             .init_regs = hifi_init_regs,
>> +             .init_count = ARRAY_SIZE(hifi_init_regs),
>> +             .frac_max = 100000,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hifi_pll_dco",
>> +             .ops = &meson_clk_pll_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "xtal_24m",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +/* The maximum frequency divider supports is 16, not 128(2^7) */
>> +static const struct clk_div_table hifi_pll_od_table[] = {
>> +     { 0,  1 },
>> +     { 1,  2 },
>> +     { 2,  4 },
>> +     { 3,  8 },
> 
> Why don't you ajust the mask then ? Looks like a POW_OF_2 basic
> dividider to me.
> 

The maximum frequency division value above the design document is 8,
such as the configuration 4/5/6... The actual frequency division value
is still 8, so this table is defined, why there is this restriction in
detail I am not clear about.

Will add these comment ot describe it.

>> +     { /* sentinel */ }
>> +};
>> +
>> +static struct clk_regmap hifi_pll = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = ANACTRL_HIFIPLL_CTRL0,
>> +             .shift = 16,
>> +             .width = 3,
>> +             .table = hifi_pll_od_table,
>> +             .flags = CLK_DIVIDER_POWER_OF_TWO,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hifi_pll",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &hifi_pll_dco.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_hw *a5_pll_hw_clks[] = {
>> +     [CLKID_MPLL_PREDIV]     = &mpll_prediv.hw,
>> +     [CLKID_MPLL0_DIV]       = &mpll0_div.hw,
>> +     [CLKID_MPLL0]           = &mpll0.hw,
>> +     [CLKID_MPLL1_DIV]       = &mpll1_div.hw,
>> +     [CLKID_MPLL1]           = &mpll1.hw,
>> +     [CLKID_MPLL2_DIV]       = &mpll2_div.hw,
>> +     [CLKID_MPLL2]           = &mpll2.hw,
>> +     [CLKID_MPLL3_DIV]       = &mpll3_div.hw,
>> +     [CLKID_MPLL3]           = &mpll3.hw,
>> +     [CLKID_GP0_PLL_DCO]     = &gp0_pll_dco.hw,
>> +     [CLKID_GP0_PLL]         = &gp0_pll.hw,
>> +     [CLKID_HIFI_PLL_DCO]    = &hifi_pll_dco.hw,
>> +     [CLKID_HIFI_PLL]        = &hifi_pll.hw
>> +};
>> +
>> +/* Convenience table to populate regmap in .probe */
>> +static struct clk_regmap *const a5_pll_clk_regmaps[] = {
>> +     &mpll0_div,
>> +     &mpll0,
>> +     &mpll1_div,
>> +     &mpll1,
>> +     &mpll2_div,
>> +     &mpll2,
>> +     &mpll3_div,
>> +     &mpll3,
>> +     &gp0_pll_dco,
>> +     &gp0_pll,
>> +     &hifi_pll_dco,
>> +     &hifi_pll
>> +};
>> +
>> +static const struct regmap_config clkc_regmap_config = {
>> +     .reg_bits       = 32,
>> +     .val_bits       = 32,
>> +     .reg_stride     = 4,
>> +     .max_register   = ANACTRL_MPLL_CTRL8,
>> +};
>> +
>> +static struct meson_clk_hw_data a5_pll_clks = {
>> +     .hws = a5_pll_hw_clks,
>> +     .num = ARRAY_SIZE(a5_pll_hw_clks),
>> +};
>> +
>> +static int aml_a5_pll_probe(struct platform_device *pdev)
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
>> +     for (i = 0; i < ARRAY_SIZE(a5_pll_clk_regmaps); i++)
>> +             a5_pll_clk_regmaps[i]->map = regmap;
>> +
>> +     for (clkid = 0; clkid < a5_pll_clks.num; clkid++) {
>> +             /* array might be sparse */
>> +             if (!a5_pll_clks.hws[clkid])
>> +                     continue;
>> +
>> +             ret = devm_clk_hw_register(dev, a5_pll_clks.hws[clkid]);
>> +             if (ret) {
>> +                     dev_err(dev, "Clock registration failed\n");
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get,
>> +                                        &a5_pll_clks);
>> +}
>> +
>> +static const struct of_device_id a5_pll_clkc_match_table[] = {
>> +     {
>> +             .compatible = "amlogic,a5-pll-clkc",
>> +     },
>> +     {}
>> +};
>> +MODULE_DEVICE_TABLE(of, a5_pll_clkc_match_table);
>> +
>> +static struct platform_driver a5_pll_driver = {
>> +     .probe          = aml_a5_pll_probe,
>> +     .driver         = {
>> +             .name   = "a5-pll-clkc",
>> +             .of_match_table = a5_pll_clkc_match_table,
>> +     },
>> +};
>> +module_platform_driver(a5_pll_driver);
>> +
>> +MODULE_DESCRIPTION("Amlogic A5 PLL Clock Controller driver");
>> +MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
>> +MODULE_LICENSE("GPL");
> 
> --
> Jerome

