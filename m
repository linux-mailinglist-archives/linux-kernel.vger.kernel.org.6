Return-Path: <linux-kernel+bounces-252012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C83D930CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 05:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB351C20DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 03:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90F117E476;
	Mon, 15 Jul 2024 03:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="tpfTdM6X"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020108.outbound.protection.outlook.com [52.101.128.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C8017E463;
	Mon, 15 Jul 2024 03:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721014301; cv=fail; b=hWNgi9s5ILAZz912sXHMJBi+ASJgYnLj/Yt9XY88QqBDw8KHmUEdmtdUj4ZEj537wPqaDDCZEBDeW0OLwtKGHv9rbX0bivkMA5HrJ8JIIEv7PNpgbNfylXrevQ1xaKOmEwrAR2LB+abt1d+Ftsew/2kwYEbY+XIgIaE9Z90ZrK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721014301; c=relaxed/simple;
	bh=2J2VC/lVF76IsTSqkMxszp+LrmN3MJpAFzcMQWgDdnE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IJhBIf/Ol5nYp5VYznPawTxYCg3fnuj0COj1VachpFb8LBSGkVlNg1tWRoRTQIS7JG2pAZY7+Ig3tfP0hrXCx+8MOXP58zQaYA9chHX5222SJSVk2PlR6m1o4Tj/rpYWfpJKNqnO6PKw1OBMBvBAAtGXhbLPk0/zqHsn5L4aGHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=tpfTdM6X; arc=fail smtp.client-ip=52.101.128.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dR7jwD1Ba8LrR2uLrSXR01j1Y2CmFZ+IdhpxH4YcdGNME7u280kHVctKVBfIQuNwpvtaZP5gKIAU7YSBomF+//qfJH4kmL33/8vERAPlqp6uJ0jvAHG3VuZLl2PF1fGTyPqBnWevKx1dVQNz79Iqnt1j7pr/9TFgBxWMXTmFOKAwsdI37RO0PkyInOpzC2/G69j8LdIfz8x8K8WKGCKsXoI9Ug5vTzDnBoRMiUNt2g1/KDGNfBFt+FKWoJ7vsFgPT4TzTGK+kxO7IC1IWu2AWSsQxyL/LURbgqIvCf+xsfaTYf7P0GCGRtgM7+dUUPfCBcv4MqRoi4279TMpN6CuXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gePcNQJQd4YIhp4OMoedwNYRIF3YTezMUEfvkT1WwBQ=;
 b=hisatnQzMrSMiay6KonzYjKSXbJL40n7yI05uBDJUWjAej+KJ67VAjXQVcvf/nlNgB41F0XckGNIOroV7lYyj0F5KkJyfjtqKdn1sby5LUfN8EAXZU2EXOhXYlgCy5ZIyIc29wCJDeo7ToDXVeyFbSwcYFjRo8d43YAiNFHoLlpFij+r6JdYwkc6l3oAckRxfPwtObelOgELRZ265jqrMq1gbGMj24nKl8R93yDajB5LKGnMUZhPt1C6Vor76eLMfjlWX9yLjXyImlu0HemVEdvkvHr4g5T9efgMG8nDt6rdaMUz0CUqexLOF5bVw1ExIXDGrXK5ObmahnBuY4sZvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gePcNQJQd4YIhp4OMoedwNYRIF3YTezMUEfvkT1WwBQ=;
 b=tpfTdM6XtCCSJCaZnFc9rWOVJ8Q9U6KyfCeG9uz3BnL/6RF3NL7eblqKmxGsnIBi5sdxn3m6QyHCLLxYZegp0t0/O2bMXNkIbiiNvxPtRp4AHZkY2tHa3BSXw/iAXwmFR+9PgfrCniJqcN5hbNzTmtSA8cbF81qXmdOjUMeCotRrKHysi9zpifabOO2yLysLU0exeCQxCgX5UpUtLpMAYHdzNBO1RbP1JWMzeEQtCAQpE1nnOKB4UonRYm2vaFVd/qCpCHY57PIuNrqAOQPJ0Q58uDSNNmjDDgCIMcr+fU3IZPpkObTvRO35QdLfxx4SMogbKGZg9M77QlIWkfKhjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEYPR03MB7251.apcprd03.prod.outlook.com (2603:1096:101:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 03:31:35 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 03:31:34 +0000
Message-ID: <f5b8a25f-6d5f-490f-8526-12d260958c37@amlogic.com>
Date: Mon, 15 Jul 2024 11:31:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: amlogic: s4: add ao secure node
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240712-soc_info-v1-0-05ba95929d5a@amlogic.com>
 <20240712-soc_info-v1-2-05ba95929d5a@amlogic.com>
 <bc3b08ee-f500-458a-b23f-0be4bbe0ed8b@kernel.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <bc3b08ee-f500-458a-b23f-0be4bbe0ed8b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0192.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::18) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEYPR03MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b07cbc-25ee-4885-dbe3-08dca47ea09c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0pEUi9TSEhadXpTRE5Kdmo0bUE0djcxSWVoUzMzUytJRHhiZTFNMS8xOS84?=
 =?utf-8?B?OGRVaUs2SWQzOVdlbDBhclB6THh0WU55Q2JIQWt3UThEMmJ0VVlvYjJoZGtj?=
 =?utf-8?B?UCt6emNYL2drbUd2bkRjbStjVVZRdVlLZ0VVSkIzTHdEcjVxdUI2WEFOK29l?=
 =?utf-8?B?TnJIN0crMnl4MDA4REJncWNENW9zTTlWV3hiVGVuc3l6SUpJQVpMM29IWVNI?=
 =?utf-8?B?NUJDZmZtTEE5UVA4NmJUelFIWGFZSDYzR3UwOVlJbUR1VGFleWQzSU5QUXpH?=
 =?utf-8?B?RU9VbmMyRGxyRm5KTkJNVjh5WjR3RUZoZHV5dlRwU0VISHJDdThwLzZ4UXln?=
 =?utf-8?B?UXFwNFNpT2ZIKzhDZXZDODM0bVlEZ05Ud3JScWc5OElzb05zOUxickNxRnpi?=
 =?utf-8?B?UDRWcFVsMHZ6Slo4YUJGTEFtQk1ySWJqaVFNSmZUQ0o5VllmbGNjdERqVVFn?=
 =?utf-8?B?ZUpWdHZQL0RTd2hBZWJLcDVaTjlmWHIvUlZvSE9NcEYrV3hNS0RHZXpHeFpq?=
 =?utf-8?B?UXFGVWFlVFBaRHdWQjVGSWNob0VNQnVSejNkbkduY1NvOTRpUVJtY01xN0FV?=
 =?utf-8?B?UFZFRkpLTStGcGRseVNWZDNGNGs4N2NlWUwwUi8wMHdMeFZaU25oK3pZM1JM?=
 =?utf-8?B?N2pCdlEveHZCOG9xajJqbTdKZTNDWk13UUN3VFRualVWNThwcmNsN3pqYWVO?=
 =?utf-8?B?T1BMQzNxUEdOaTFnZm1FZEw3M2liTm1nbElBU3M2YjlMK2o4SXdxdlBCdlhw?=
 =?utf-8?B?WE1tOUxSM2VZT21GZVNIWE5GRjRERWFFVUo3Q0syZitjMkwzYUpWUzBtQ2Za?=
 =?utf-8?B?YWwvQk1jSXg5VFMzQ3NNeW5rZVVMVE5Yd3VVcW5zb3d4ZlhPcWRzbXh5K2lF?=
 =?utf-8?B?d1QyTitNdWVDRXRXd1FVWFo4WEtCZ0M3RVdyQ285M25aV2RhN3ZQS0VUUUtU?=
 =?utf-8?B?MGQwYnA0YTl3Rk51QkxhV2M3Yzh1Mll5SnhlR1F2aHcyMHdFdzRUaG9Ib05x?=
 =?utf-8?B?UVVBNGMvVTUwRjVKV3pSQUtLcC9CU25UYzM2OFlNV2o2YjUrZjh2eWtRZUFM?=
 =?utf-8?B?dHBQOW1td2pxd2R2V01kL3BMTS9lWFM3TElHcnFtZHo1ejBjcEhnU3J6NXoy?=
 =?utf-8?B?dzNMbE0yRkg4cHE4dS83dU9JaHVPNlNwRmVHeXFHWG5IM3RjZEVNeU4xRlpW?=
 =?utf-8?B?dDU3cGRVRDVQUVR4M01ONm96eGgxWmVaYjVDdEFmemdsOTR6NWk4aTNPcjNJ?=
 =?utf-8?B?bFlPbmcyMkpGUFNXVjRzYURod0FTUmx0UUxVR0NMV3M0WnByYWRrdTN4YmFo?=
 =?utf-8?B?bWV5TFdmQnVZbW9JUUMxY2NsTzduZ2dmUGMvajJoY1NwZWM4ekY5V0tSbnNq?=
 =?utf-8?B?NWd3L2R0T1pNUUhtMC84UkFyZ2E4eTNCY2VnWVhQOVBrR1Q5dVJHeWVjSFR3?=
 =?utf-8?B?TzcvTU1KdlNJVVdoR1pSdUJucmZna2VWS1U0UGtnVXZFVkIyTVd2YnBaaWhF?=
 =?utf-8?B?KzJ0cHJQNXIrdUUyUVVydnAxS2tjWG1TZGdpNFErYlYrdENEd05VZTVDSzBO?=
 =?utf-8?B?emowSlcyWmU3NlZYR3FNUDVDdm93WVdsbXJqbTZ6U3ZzajFIRlNzUEFIMVRB?=
 =?utf-8?B?dS9reFlIb0tDL0ZwQXNUSnd0MEdCZXJWSStXaEdLU2wvUjd4TjZ5bW5CeHRX?=
 =?utf-8?B?b1NVR3JYUlVFRmNkWkNrL0hVK0lCeVVWOHJyZmdnNXRieVQzRm5GRzVwM1gv?=
 =?utf-8?B?eXNzS05FVnVoQzRzKzRLeDAzV2lNODV5MElNcWl6RGlheU8xT3ZoaUQ2Z21O?=
 =?utf-8?B?NTl0TGpIOFkxZlg5U3g1QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUd3MG9XVGkvdm9aaVdkN3pDZDJXN3dyZGNtKy85UkZnZVdvU2FlSDdBblpX?=
 =?utf-8?B?aXNlS0R1SHdyeFBPYm9YT0JHZGluaUFEdWllNnRrTUYvNEVrcjFoaEc5U0VF?=
 =?utf-8?B?ZzFvWThiWG5ZSG45VmY3UVVxalA5c3laQWRReVZCU1NGOFdjSHlJQVJTSkxQ?=
 =?utf-8?B?Qk1XdTFOS3RpbUtRR1kxVUljS1lOQm8vTUNzT25jYzAreUwxVHFBSzZvQU1n?=
 =?utf-8?B?bHhRRVdOaXhMOTdwLzJoM0UybkRCVVRDSGxwOHQ2UFdCZ2dvZXRRMTdyQjRP?=
 =?utf-8?B?dDFjelhZUW9zZGI2RnBqd3dDTEQwZlh6MDZmUFVodlRvTlRqc2VYZTRselFG?=
 =?utf-8?B?SnF1bDY1SU5XOVk0KzRzMnRzbXRGZUNrMXVZZE1KZUc4QTZ3cjJjTm1oeXRT?=
 =?utf-8?B?Tzl6bHZCNmVMeCs5Z2szZFNKVHFLWlVTNkFYeWR2T3JBV0FlTFQ1cFVveGF6?=
 =?utf-8?B?MWFicGRzWXd2YktoMFJYVHJzdEVVaDdHaFFPMVV2aG55ZzB5WTFXV05vVnky?=
 =?utf-8?B?VE11VEU1c3R0cXpKRk96Sjd0VGVtN1JDeVFmNFdWMzNCUXVJcnNrNy9hTEhQ?=
 =?utf-8?B?QW1CcVQ0NlFzeFNVSjNsbktMbENqeERnUEcyWmRuWERMeG5rYlBNL1NvdVNi?=
 =?utf-8?B?NjVMczRUZU1GUHEvaUx4ZGNZYkNBWW1LMXgwL3NLTHYrSTg5Wm1tL1Fub1Ex?=
 =?utf-8?B?NWhGV2JFVTU3Nzk2MUViWnFuemswT01vWmFDc3RQcHZkSmlObmtubllTQ0RV?=
 =?utf-8?B?UnJzSGFabHgvV0ZxU0ZBT3V3aUJOOVg5Q0xzcTcvSzVtQ1dGMEtQekxwWlRM?=
 =?utf-8?B?MDV3MFV1RHNPcFZVaFBtZ3Z6RTJUSFQ5MkNyVW1LaDlScnFZYS9SSU9lRzJs?=
 =?utf-8?B?UVdlZFo2bFBYeTFUeEJ0bTQ3TXhGVkI3RXQ0MC95SFpVTUE4TFV4YytVcHlD?=
 =?utf-8?B?ME82WFVDNGw4b2xsQ1BzNUhnMWI4OVVOSXVTenEzUmFvRjRSTi8wOUdrazJT?=
 =?utf-8?B?VTNGanZFN1pWQ1J1YXk3a2Z3VnNCdUpkZ0puVVJRL0Q0MTZ2dC9FQUFxSUVN?=
 =?utf-8?B?ZXdUQytaOHMvNnVIWC9DV21OQzNJV0NMR0orTEhNaGNWWnZnbGxZWmZYdi9u?=
 =?utf-8?B?QUw4eTQyNUkzZEZjMzJRTlNSV20rMWV5WW9qdjhUM0NNaXduREJwRHJtcm90?=
 =?utf-8?B?c0htN3F0ZWhNYnN5Mkh0T3d6eitDN1o0MDRFL0NZdmZObmEvalYyYjVaNzJU?=
 =?utf-8?B?MEZFY0U3a1NEZk9XdTQrcUJqZjY5VnAxQml4aW1aNXByM21lWGNMc2ZJRm4r?=
 =?utf-8?B?ZGZlMWZqWGw1UElRWVcvVUtqSEhaWEFQQWtmTlZiL29FMGFCZnZ5RE9SR09j?=
 =?utf-8?B?aE8zSXdkL1AxMWpBM0xGWlg3Vi96b212b2ZqTXFtb3VRSzNmVVFWeTE1bk11?=
 =?utf-8?B?ZTZjc3NPc04wbitKZTN2TkViZWxtanluU2o5dHVka2hmUVIxaS9lRFpVb3VY?=
 =?utf-8?B?dTVhUzYvNG9pb3BtMjB2Tk5CVGduTmErRWlsT0dHUkxHZExBUDNlNy84Q1Iz?=
 =?utf-8?B?cGhnU1lDVitkck1MdkN6RjNaNDJNMFRhbnlZbURudG9OSEFGbE1DRFpGaU1E?=
 =?utf-8?B?cFRFaW9vcktwdHpSRTU5bVhMc0Q5ZE5CM3IzTFhwenltR0s4bjNTZDVtRzFO?=
 =?utf-8?B?ZmFBek1tTXQ2YU56L0NBT3ZkSEhZZ2cwYmFlNy8vV0xBK1RodUdHUWl2dTJY?=
 =?utf-8?B?TUlZUWU4Tm03d25yZ2d3OTNGSUs5RlJnVTYxdDJ4bWN2RTZhNFZsOFJEVjFq?=
 =?utf-8?B?QXhmcXl1aThWbEpndWJ0UVZKM0UxVG0xbExSQjk5SWdoQmpyeWNQLzd6aTll?=
 =?utf-8?B?dk9PbDlLemZHUG5qZllwTk1pVHY4SWdHWXN5MGU3U09JNjZRdklVMHhhbjFW?=
 =?utf-8?B?RGxJZDI5cXJ0WnByMC9oQ1BRYW9QcTBYQjUzMTM0bEJNVG5TTmg2ZFJnUDNN?=
 =?utf-8?B?VE53U1JNQUVrcVBmbzB5VE95S2xIaXQ5SHlXRVNubkI3R3lxRHRvZmxUaUtM?=
 =?utf-8?B?TXE1WUdWcDBuSnh0NkQ0SEpNclBGaTdUQVJ5S0pjNVBlMnFpdnVRUUx3VjJa?=
 =?utf-8?B?YytlK0o3QThvc3JCWTJxUjVuMjFEOHpjUlM3TDltUUNvbUdXa3hLY1dWd0Zp?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b07cbc-25ee-4885-dbe3-08dca47ea09c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 03:31:34.8209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dmZMZe4LkV/H0ImjZFUz3VVJtZx92+t0q2U5Efyou2uPtNjP529jqaBc3TDWDo2gLZzsljns2wwSElpm4QOYv/lFOFjpysDnKKlaujpUyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7251

Hi Krzysztof,
     Thanks for your review.

On 2024/7/12 15:49, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 12/07/2024 08:54, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> Add node for board info registers, which allows getting SoC family and
>> board revision.
>>
>> For example, with MESON_GX_SOCINFO config enabled we can get the
>> following information for board with Amlogic S4 SoC:
>> soc soc0: Amlogic S4 (S805X2) Revision 37:a (2:1) Detecte
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> index c11c947fa18c..316905ec191c 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> @@ -763,6 +763,12 @@ reset: reset-controller@2000 {
>>                                #reset-cells = <1>;
>>                        };
>>
>> +                     sec_ao: ao-secure@10220 {
>> +                             compatible = "amlogic,meson-gx-ao-secure", "syscon";
> 
> This is not gx, but s4, so incorrect compatible used. Same for all other
> patches.
>
Will use fallback to fix it.


> Best regards,
> Krzysztof
> 

