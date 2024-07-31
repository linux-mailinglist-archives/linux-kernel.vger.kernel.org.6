Return-Path: <linux-kernel+bounces-268570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EF9942656
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 485BAB246A9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C568716A92C;
	Wed, 31 Jul 2024 06:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MXYS9aCZ"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2088.outbound.protection.outlook.com [40.92.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDDD1BC40;
	Wed, 31 Jul 2024 06:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406643; cv=fail; b=FL9TxKHZLlg0qJMqeR/loAFVu3uJUxf297LY6KL//lCeZ0C+Ljvvq8JH8O1fGw2hTE7Mhwzpo7tKPiigzrnVab15B/+JwPB66K7qHUCHQcZRAT7vv1TZQtV9xUKErzntCmF6FFCKYJevRqWPWRdpxeG2lW6h+tsyBMqK1VrIkss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406643; c=relaxed/simple;
	bh=ag85/mo16wjY0D1996KU/GIcFArNPIU+Py79d0HALTA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DgEsGo7jF5hJiOTKtmL2kIOShcU1VEvptt5H+oHiAxopXTZx6jo09gbkoWvqs2KCsLKgiAH+kPOtOcPaiF8jbtMsB4IQ8XhagikREF/NHI9TJwY983wYnM85tbH+9ie6i5n4Q8ztFx6pzVWfGVUVqcLbzgXCHXNN+7rPvcW9LS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MXYS9aCZ; arc=fail smtp.client-ip=40.92.102.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6SSiEBRbpA0ihBIfRxeAhi3liWh/3HJojX22Fbe/NBgoZbICaf45juvOLIPULKUWGjtBAszDLkef7OcaQBxvLmb2T9tnEk4vkk4uFSSMk9GhiKG9bthFECCWRtiAToGwgNy08/JcPCEvtQhAiXkI1mtWGYAzh+JpAA0B66gegbjDpluPVX8y3LNnwZCm1iAb1LLGpdPy9I0/9PoIZeNrpE80jbXVL+uhzXKGXfLanI9S7LXyUYM5kX5rHfjX/bLr7xENx/oxcj2KOhcgamfVLg7EWfNqmWj+DpkB8UuRwJkjGPVaRk05ps0akB7eK6f4eqHG8K5AwTNwSXi5U3s3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ag85/mo16wjY0D1996KU/GIcFArNPIU+Py79d0HALTA=;
 b=MyoaUy15dVn3prMwyqV/4Kwt54pHoXo3+Dpkmp9qzh8vLybtpPT8I/ZsxULLdcqgB4ExFLeHDUKGFcM3zbP+sFYWuJ+o0/w70Q+chxH28TbiLu2BqbIZKWSTH+cl5od3COgZMNxbPheIw75+3i2F7DW7HSGFZxU9GT3MbN196rd/QFCuz+vmC133tHVvE1CeWYdJXg8V1E6PZ3b2MSoOB3IZc3YhHMBNCMbgHtd1wlsC+JJJlgg3e3a54xx2X14kG1a3z5lcGCZGDqPzB01T5Znwdk3Rrw6o5gkkKO+lM8ehXUkvCVjsQP01XVNRUhpnSHj9UkBQ+zdg7wAR+tlCOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag85/mo16wjY0D1996KU/GIcFArNPIU+Py79d0HALTA=;
 b=MXYS9aCZD3wrTfG2DyNbhMIPwBh69tW8svvebkbL5hsvKl2LF52qc8i4nb6wX54Qj048mJsnLdOIvAZiszpKAL+1CNGoYLdEI54chuvpNdhuVyM7A57d2u9tms+Tic7WrXhaJWzTiUbbxrOS3IxSVLJkegICa4J5s092A1SpGK0JHCheotL95YNvXCIPIHSnobJl4o0DG/Xi2ur1P7ILyibMZCgm0RRC8hUZ8pZi4GKngQLQkwy33DMYLn3XadkZxsq5VQE0tOYF2k6PkzP9FaOP77mt6QI+WDahDGLickoKriXOZRWuquH1289CviJq/3o9AInXRKzIR6ed0ZXuQQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB1790.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 06:17:13 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%6]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 06:17:13 +0000
Message-ID:
 <MA0P287MB282211CF334C521A1BFD717DFEB12@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 31 Jul 2024 14:17:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] riscv: sophgo: Add SG2042 external hardware
 monitor support
To: Inochi Amaoto <inochiama@outlook.com>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, Chao Wei <chao.wei@sophgo.com>,
 Hal Feng <hal.feng@starfivetech.com>, Jinyu Tang <tangjinyu@tinylab.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <IA1PR20MB49538C09E94D90F07B7B2562BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB49538C09E94D90F07B7B2562BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [p3VAc2Do3eBR1MObLuDaQJVqYvP+nlgd]
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <5d7e4088-b9f0-442d-9668-2896820120ad@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB1790:EE_
X-MS-Office365-Filtering-Correlation-Id: 15cca108-5771-4857-225b-08dcb1286b04
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|5072599009|3412199025|4302099013|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	dFyEuEaFVL3KOobaCweoyxl/nGAbvAmBwjeYykq04zgpm+QyZ/sfOP4sdEMrrAWM7utTNuKwFYNlLYFup6B2Beg6psTDEyr7RYaguDW74TitCW424Z4wzBKf0x3uJjAyS/7iZQaundoypMZBTyF8hrMiDegIF/NaY0zSCguL10FpRTU7ij66tPzgHM2v/e1WL734RKd8kQEjo2xVngQs4Vhywlg4EmNPsbW/wfJkkGzfwKZP02rJd+YoXHG6kfFWbPF5CnkllrhzGMYX+mAEnX4v2iuNWeC/fsRMH7ZUyX6dHobQEvWn7yHdwFDvZNJ69UKYT89M6dydxL9RFCfMkwRGtwd67F6B5Cbz3ddSy7S18IhDVW54m6cvZGNzZqYlSueiaYm3TKlED/iMA6xUN4ySv++vcJnS+6jnBuBkIw//CcMBD/YRquTusX4myYgg3UUckVrszWhvBKTJ42nGcLkOQ1s8vcYUXx7r5vawlmMPhaRaU/nG8tly1c0jmzR1NUlbLKvHQivi8eR8d0+aJ/WyQa7KwED6V+rqYVGW76IIDJAtYJ+MtiWVIGnCt5eCjH6EkWB0oW+E6c+bzybspk1KU8ZaCIsVounla2Mq8J4xsaJuigwVEpsRsc2merS1gF5kHg4c4XDxK7p76BC/FKr+Zhh8gKhx/lfUPCIJz5crm0ZJKv67A0wPD7wadZ04JliCWGZb7PlrkAHz4vBbyLEBHvxfvJlGISZK8be9qpxXOQ+VZi0t5+Goy+G/pzZtIjyOiwwTpoLrd5JtNt8vkA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlRzUTZEZEJVdzJtdnF2alpNcFExSnFtQWZGSFZyb2p4eC9XV2dBakVFY0lM?=
 =?utf-8?B?ekZNQnR0K2Nnb3cyZEpkdm16cWwyd2JhNlFwdUdpa2pSaUpGRFhwVnRTYnlP?=
 =?utf-8?B?QUNGY0hwbEh5cWN0UitvT3lUalNhelZubFlrbWk1YVpjMWNjc1p2WFBJRzFG?=
 =?utf-8?B?R3NlUTA3bXNBNTBoMnJxRXVRMVUxaENjTXgyNDJORWJwNlVUTEtCMGFiODRX?=
 =?utf-8?B?YXlOdXZXeGtJcjZKeklmL0YyVkYrc25PL1F0dURYMndqcTRCejV4RUN6TGJo?=
 =?utf-8?B?Rkc0MWpzMDl2NmJpZ01qK3dIUCszeXA1aHl3TGVhZGVEd2tDYlBFZHlwOTha?=
 =?utf-8?B?R1lxQks5SUtlaTlOUFA1WFpKOGQ0NXQrNkc0ekIvWS9UUzhSRCtUZW9nOTk3?=
 =?utf-8?B?S0E1S2huVGc5K1M3eUdoZ1JEV0FOcGc2SmlhOW1kQ3Fhc0srbXhPblRwRHlh?=
 =?utf-8?B?MHZBb2JEYnp3a3MvNm40WHhRU1ZxaUpyWmNicUVQb0hQTmRPSU9DbldiMm4v?=
 =?utf-8?B?Ny9PWVF5ejF5K1QyYWhObDlNYytEbzlBdUNHRkJXdnFWWVdSNWUrblRxVE5D?=
 =?utf-8?B?SXd4b1FPRXkxbkx3dGZxc2kvVEd0L3kvMzdKTXNrMDlROURmVFpnZHVEVmFz?=
 =?utf-8?B?MzVCVFg0NTlNOXh3NmQ1blVtVkxibGRVR29yMWpFOU1Qalh6cGJsV3drSzZX?=
 =?utf-8?B?aHVrWFFyTXRhakxVbFNjTWtwZFZFMi9IdGJrcXNCdFhUcUhBcENEazI4cnlo?=
 =?utf-8?B?SUtXNFh2bjV3OGdhaUh0cXNxcHZUaTZHekhZV1pBcXdlR1RZVmVNQzdkeU1P?=
 =?utf-8?B?ZDZpZTZyaVFuVlJET0pLZUJIMHFPOE9qbHloV3ZRc3QyWVlpN3FBWGRmUXRJ?=
 =?utf-8?B?THRhZWIvQzFBTHFIbjZUUDJKTFNGRU9ZQ3V3SnFSdU1zV05ZZkVKWEMvWlE3?=
 =?utf-8?B?ZUNWUnJVKzZkK0F1bldibkhxNHZxcUUvRHN3dTRrYmNXNVpjRnpRcTU5YUNj?=
 =?utf-8?B?Uk5sS1NZRldpeGlucVVWZ3pvYzhkTW52OWlvajRFTVRXSGhmcHNqRmtOeXhx?=
 =?utf-8?B?UWV5REI4REphcDlUVS9JRXJ4ck85ZHYzSVVKT0tDc1VjMmxXSE9vWldaUUwx?=
 =?utf-8?B?aS9xUFl1UktTWTJScTNtTkVlc2hWN3M5LzB1SDEvV2ltWFVITmtobWpObnAr?=
 =?utf-8?B?Rjg1QlpmdTlrWExxWllSTjFUUnA4SEI1RVlxVi9xMEdMZEtLV21DWW9XK0pJ?=
 =?utf-8?B?MlBhanIwbzh6ZEZJQ2tGa1J5RHpyL3BEUlpoNkdDK3RJbnJRdGVlcTJjSVU3?=
 =?utf-8?B?S00ya2FQQncxN1MyQUJmU2ZhUUUxYmlVWjJST0FUcENtSXd1L214NHVzMmRJ?=
 =?utf-8?B?cXl6akVsTXFXa3pMNmhGVmdDN0l2RkZ4VE04QjZmcFI2VVBjOFF1dlJPbnc4?=
 =?utf-8?B?TG9waHBrd0RuaVBaUjA1R3RyMHZ2QlBDOTcvN3dRbmdkajNUbTFhRVpwYzJD?=
 =?utf-8?B?bjEyYUkveHVVNW4yVGtubFNoQjhDbm9vRVR0ZzhVWnNnTzJsYkZJWDI3VW5O?=
 =?utf-8?B?UGZtaDloWXRaNmluM2RRK3RseCtRdExkZFhiUjJObytLZkhKTWMxcnN6MFp1?=
 =?utf-8?B?VkE4eTFNbW53S2hhcTU4NWhnVU5SSk84SVRldCtQdFNOY2NwZWpJaHQ2NXFX?=
 =?utf-8?Q?Dxax7v9lqO7wcejqtGUu?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15cca108-5771-4857-225b-08dcb1286b04
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 06:17:13.4448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1790


On 2024/7/30 15:49, Inochi Amaoto wrote:
> Add support for the onboard hardware monitor for SG2042.
> Can be tested with OpenSBI v1.5.
>
> The patch require the following i2c patch:
> https://lore.kernel.org/all/IA1PR20MB4953DB82FB7D75BF8409FFF4BBB72@IA1PR20MB4953.namprd20.prod.outlook.com/

Please check my comments on patch 2 of this serials.

Others are LGTM.

Tested-by: Chen Wang <unicorn_wang@outlook.com>

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

[......]


