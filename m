Return-Path: <linux-kernel+bounces-558694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AF2A5E98C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB833A815D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405917346D;
	Thu, 13 Mar 2025 01:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="tcuQClVl"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2112.outbound.protection.outlook.com [40.107.215.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EFD4C6C;
	Thu, 13 Mar 2025 01:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741830547; cv=fail; b=o6NfV/Fabl7zd1e9H+Wd0ZOnW/XAOjOAnNu96tNyJjcBmQdpt/dT+WPmnkHU5tZP5m/pIP/wUvD+2veFuQ65zgHlataGzOcNjy+eFabzCv1G2u5Q2wxR/uMy8tqj64oPb0FoozA4brvGBzoqKWMdHLiWWUYkgZtL5AWJ02fuAK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741830547; c=relaxed/simple;
	bh=nsInsX0QhVM/mIsw22JbDEoV0uFMJ2hISDc2mhlRyag=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gltz2gqpMPfRXVBF46p+WTJgVv8RyDsy90LNgIfr80tf7bqOcR//2tw1fAFDDQqQMtvx17EHftKMtpT3XFuyJkOV/qgxfJJVIFosqML5fSRcbmVVRfEK5dfdUW6JJX+lDamVWuZNNPazyXIbUqZYj24BUdKaEmsE+skqLOQ1IF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=tcuQClVl; arc=fail smtp.client-ip=40.107.215.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8w92O8EhXTdOCO3+GwEoFoQeohqUQvOGcCkT+hcU3nH9XfxkODGh7UzusUDIqebBzBuP1U4BbjspLuQ/AQmBLhlcEPbJIkkLzMJudOTN5m5TzIPWlG12GmSI3HnqcGWdVDdijrG0cX3PelIQIgYH5BVfbhrYJopxQ3Qpv7NaWOyeoRTYmxkyJvgKrWPxIGWDqyIaPOmYFzBxWzosmfZHH0GUrL+pjxEGt2s+iulk94zAB5Q208Os7yORZwvhLVP/yMN4OgOOBm4LjLHXXq9qkhXyexsKtsCCAMc88b0cAFbRocu0lWa0AtX6D4zH8A50rFbkk4mZ5DNE4RMxj1K4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7izwqDlsphk/cKyH6AVwQwaAo/wZ4PPab+sy0XjFIMY=;
 b=GpdLcD11TNFHsEdsU6M34BWQUJ8+0GlMpXoIvRhk0VPC8XUtNv/FY95qI43wo94WdynpcYcck7dLHfas8ZdK05FJKiiUk2Ub4DOhSwvUwrYva7arD9FQigSlWbpM+45O9VB6Xyr0YvYXt61fGNah1kZrcYUUdVEbENWrWJyi8AN3qCZaYbTGoAay56igxc8wk9NeRYkqXvDmPawgj0GbkGJqGTGKk2lL8y5QZjdtzywKfGhEz6j1Ihz/Ogo8ZWNCurkKEuAYpRpityYQ5h6I6ixYAzLahJ1sqNXujirdtCVKc6VMYEB2CA5T5m+GhFxK/TbrF1m4QHMVNCkzghBofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7izwqDlsphk/cKyH6AVwQwaAo/wZ4PPab+sy0XjFIMY=;
 b=tcuQClVlwC6UBfiN7Ww/YZiFOrd3b8FCl1xYl2SkNVMgwa2pBkM8nYZ3WDun+9Lw+sNBIDOfOjbHtpv0E9IAjAxEZ63Mw4LJ8fzrA0gjrGNpq4RJKsd7KkSRkDw1Lg9Kd4gbPRCV3kHu9mM5Y9/dmYyho6DRKAJLrcSMJjBJ6PTyl3G/UyCMqL/5dJ7Qg3cpvoV8DGJYATlPZh5p5k0kycL6Vq36V3zeTyK+pZJGWGU+odj7ezM9MNTQJ7YUaocTvyGAhdwJTFC8FUD4rzNqAH4xXDfa8dVsr0xJ3xjJ1KTqeN7kD31ocInDDbFbo+bvOdSxqS7apAa2ciPIpWdhbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com (2603:1096:990:11::8)
 by SEYPR03MB8080.apcprd03.prod.outlook.com (2603:1096:101:167::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 01:48:58 +0000
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::1ff4:d29:cc2e:7732]) by JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::1ff4:d29:cc2e:7732%4]) with mapi id 15.20.8534.024; Thu, 13 Mar 2025
 01:48:57 +0000
Message-ID: <b9d6a851-c43f-4db9-9a83-6eba3c9b1dd0@amlogic.com>
Date: Thu, 13 Mar 2025 09:48:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Add compatible for Amlogic
 A4/A5 Reset Controller
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>, zelong dong
	<zelong.dong@amlogic.com>, Neil Armstrong <neil.armstrong@linaro.org>, "Kevin
 Hilman" <khilman@baylibre.com>, Rob Herring <robh@kernel.org>, "Martin
 Blumenstingl" <martin.blumenstingl@googlemail.com>, Jerome Brunet
	<jbrunet@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>, "Conor
 Dooley" <conor.dooley@microchip.com>
References: <20240918074211.8067-1-zelong.dong@amlogic.com>
 <20240918074211.8067-2-zelong.dong@amlogic.com>
 <a5d9b775dd860d8f2bbf174300a2e3161b654035.camel@pengutronix.de>
 <20240918-delirious-skiing-224172be96d4@squawk>
 <84612c6b-621d-47cc-8a2e-41d1fa42f0fe@amlogic.com>
 <20250312-atlas-paver-0f0e888a641b@spud>
From: Kelvin Zhang <kelvin.zhang@amlogic.com>
In-Reply-To: <20250312-atlas-paver-0f0e888a641b@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To JH0PR03MB7384.apcprd03.prod.outlook.com
 (2603:1096:990:11::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7384:EE_|SEYPR03MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b47321b-022e-4697-0194-08dd61d13850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWEydjhiQkhwQTR0VFhtWjU0NVZBV2g0eUJ1NDhORTl5aHZYem5sdVZzQ0lw?=
 =?utf-8?B?a0ZoYklXWEpnWFdabU4raTQzZWNwU0k4emc1ZC9qdWFzUjZLRWtRMEYzUWNW?=
 =?utf-8?B?VGtIT1ltYmliWU56U0VIVHdTUHQwQ3ZsRi9LVTZ1ZXVnMzFIMGN6MFBrbDcx?=
 =?utf-8?B?cWRzQmxROCsvaFVVdmh5SmNlSS9kQzlRY2NMQWdXRXdSUCsrSHpFcG1qTFAy?=
 =?utf-8?B?YnBvYW84bmZEK24yYlk3cS9PVVovNWlPcUZBc3B1M1d1aVRjcCtEWStTMHdT?=
 =?utf-8?B?Z1dkYnprMkpJcnB0cjhQVjRXYU9yNStuMUNYRThjTmlMenhEd3lKaGw5OUpk?=
 =?utf-8?B?RUVXWFBKdnpxM0krbFh3ZUx0Zkxnd0VFM1dwM0kvMVBmN09yTFVzL28wSXdq?=
 =?utf-8?B?MzhVbjdqY1NhT1VQWllXSUt3RDBiemkwTjZjZjJMd2RFNEVHWS9QeGpKV3o4?=
 =?utf-8?B?Q2s0VisxK0FIaDFiVW1uYnBiNzlyVjJlRitmZGpWd0w3cUlqYS93Y1dZQ1VH?=
 =?utf-8?B?bFJ5M2JBWTlmZ2tjS3dKVzdwTDBKSGRYRGlZWUQzczRzeXhXazA1dzIrN3Rs?=
 =?utf-8?B?eE5lSENhWWV5UVRleEx6bjZzMHdJVFJmaWRobCtSTHZZc2p2U2YvOTVOclVq?=
 =?utf-8?B?ZEFxbGcrVHYva2h3UDVTYjArQmFRU1hzTENsSkI3eHNwU0dsMWh6WHFtbEZu?=
 =?utf-8?B?UVcvM0NFcXJOejgrNlFKMy82Y0ZYRnRzK0Q0NFVoN0pHOU1KRlFJYU9hN3Vv?=
 =?utf-8?B?eDJ4c0R1aGRCM1Z5aVRBQmlxSG9McEVNRFRwSDg2REErU2c4V2ZPOGEzNENL?=
 =?utf-8?B?bkpWNUNDaDQ4UmhFSllIZmYra3I3ajIwVW5nS1V2eFM0SDRHRnR0bE9BUllL?=
 =?utf-8?B?dkErNlJXOWU2d240TTZNWWE3cSt0NStEQWlzcTdIdGIzL0tsT3VJNzJZZ0xI?=
 =?utf-8?B?NjIrdytlaTY5a0dabDJEWC9MeDJ4VFo0TjhOa0NWalVYeFdrUFZaRzhtQzla?=
 =?utf-8?B?VHpwMldMa2R4UmY5R1dnM2NUNm5ndVZoV2VmcGZ3TnNIRkwrZ21rUDM4clBz?=
 =?utf-8?B?RzExUStaeWJBTWd5a0RBeGRTeDZsYzRMTjArTU13WkhLcTdtRTJscnMvWFhl?=
 =?utf-8?B?WmtWODFQZkc3SW5IeUJWdlVvRXU5YmNWU2xPc1AvM1FYTVVqdDBvdzBDT01w?=
 =?utf-8?B?ejRmVkFGRHNTck04SnhIQi9qSVZHZkY0MkZMZ0UrYjFYem1iZGZCbGN3NWFI?=
 =?utf-8?B?em5zWWRaa2haN1kvNnFtWFhIOVNmU0s4UVA2M2NzNTlod1h4RUVZZ2lCTEl5?=
 =?utf-8?B?NzdLN1ZlVmtsdGQybDFBWUxvbUd2OGkzUG5WQXRoeGg1VE51OUNGZU00MGU3?=
 =?utf-8?B?SkJzd2djRmlmdGh5N08zMmhpTlppK1JnTWJuNFJuS09neHhxOGp5ZFRVSS9O?=
 =?utf-8?B?WndyZHIvVENkeEE4QWFzVERuQXVUcUJRVnRkMm0rQjViK3BsbnpodVArcVFR?=
 =?utf-8?B?TFAraHVVQTJuNHVJQXNtUDdDaHpWMzQ1ZHhuUmwvY29uRzFZRWVEaVNEa3BE?=
 =?utf-8?B?TUttQUVEQ2lKMkJJS0E5VzI5WFlYSy9lbjM1U1BGM05McnJwQjBKckh4MUhE?=
 =?utf-8?B?MUlIQ3YwaTZoN0FaY2tpZkVacGRoSmxpTE9DckF5Qk0wZWZ6NE13Rk5rbWdw?=
 =?utf-8?B?OWp1SnZwaUR0NWtNcWh0L0RIcXR2SndwdmNZVlhSTkVOMFhuQWovQTBhU1Bm?=
 =?utf-8?B?VGcwdW0yQW1IQkRkckF2NEhPZlZnbDJuMDVWblZzemRFL2NaRXVYL3NvWlhs?=
 =?utf-8?B?OEhKYlF3QVlZOGNTUjBxT0tDd3BqU2hlMmJER2VBUG5PRzE0eXUrTExjeEZD?=
 =?utf-8?Q?pQ5O9KH6v1t2b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7384.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFFKVlNFNGhkWkVNbWxsTTJoN1hZWUpzbmVGRUpWM1lwaGVjZVlQRVE4S3Vh?=
 =?utf-8?B?ZHhTUEVsTlcvSjd5WHVmSmFkdERTSGt1d2oyMHFKNmpQbmNWMlN3NktEd3NY?=
 =?utf-8?B?em1uT3hwajdoNm5iQ2ttcm5SZGZiM3RXeFRocTFVZk5EQWsweE5MTytTNTha?=
 =?utf-8?B?dTlxamVITCtsMm0vMU0yM012Wk80c1J3MVBKemE5QXRKd3JxTWhPazRHVkkr?=
 =?utf-8?B?RHBHOFN1czltZkRpNnJxZ3p4aUw5OFphNWtEUE9mTk9XTHpFK3ZPSU9nYlZG?=
 =?utf-8?B?OWZYeU0yRzNsWHVFRXE3MTVHbTBtN2U0K1huSTNrYWRCYTFURkdpNDRGRllr?=
 =?utf-8?B?QUJGYVQ5K013ZGZSLytacm9MQXFuZFBaS3l0VU9ubDMxYzhDLytSbDl0aEdi?=
 =?utf-8?B?TGtmdVFLRk43WHlIaHZ4U0puWisrMGpUM3Z5MWJzTHhWOEl0M3NWZ0NHSUtp?=
 =?utf-8?B?Q3o2eTRIem56M2lSdm1KNkFBOVBVK3RWSWw1MnpyaGhEMFhMQkYzbTZ0cUNj?=
 =?utf-8?B?NHdyY21TdnJ3M0JOUWl0emVuajE4a1FadUVvZUluWStNdnl2M2dwV2g2RUZk?=
 =?utf-8?B?eGQ4ZlNmTFRMdzhNNTRQcEw3VVozUERVWVFtbGJNWFdFQ0Z4SUhOSXVPK1Fy?=
 =?utf-8?B?cUtTTzBwZHJpbUlZeGRHeUFvanZ1SFhpaWxmM1UxaXF0ejBlWGFwcVE1c1g2?=
 =?utf-8?B?SkQ2QW45dlVLT3FoZjRnT0lhK1lwblRacnpQYTB4ZEdWM1lNSGt0OWtBazQx?=
 =?utf-8?B?cFR2R1FYc0xMY1NjUktpdkYzQm9XRWJobGtYdUthWlc5cmpldERwQ3Y4bVpq?=
 =?utf-8?B?YXE4aWR5cU9aT1ZTU09GRnp5UjRHV0x5NHNVdUlUb0pLaVhBRVZMUU95bVlB?=
 =?utf-8?B?M0hELzVmdmMvZFVBN0oyWjBPblVEb1JpL3JEWXlmSE8yRTI2cllLcGZTU2tZ?=
 =?utf-8?B?V1dGQldJUFQzc25SdG5VSjdLZ21lbDVoYlo5Tnh0Uk5vR2wyZi9uYTE1YmxK?=
 =?utf-8?B?V2FDSFdFRVZubWtsUmRNbXhYL1g2QmVDUWRnNEE0VS9OUVJmdWcxZW41WmVl?=
 =?utf-8?B?US9aN283ZW1lOXFpakJueTdiaGVnZ1lFSmtWMk1PdFArOWs4WlJ0UzRObGFr?=
 =?utf-8?B?bVpqSjFJZUxxb2VnMXRoYzA5bjgyYW9SS2NkM092RngrTEpUeG5ZK0NIWTJh?=
 =?utf-8?B?VHhBMU9PNm9TVzZIc1lCdVk1N2pYVU1acFNQaHU5bGZISE51NUZUVGR1Qnd3?=
 =?utf-8?B?WEEyNVI0R2l2VzQwbGFhUnBpL2pONThOclFMK3AxY1IrQ2NiN2tuTkh5c2lT?=
 =?utf-8?B?U1kzQWNzYUNjckQxdkVINmxFZXl2UzhFUjdVUUg3eGVjWXNQSmRKSUV1WjBV?=
 =?utf-8?B?QjlJQ2JjbTg0Y2JmSm5Ic21kS1BNL2hseHgxYlFKSXhiRzZSY3BiYXE2UW5O?=
 =?utf-8?B?cmtISmNONmN4TDVGNUFzRWMraHlGU0JtQkhzbnNpNnF4cU42cFJZWlI5QzJv?=
 =?utf-8?B?VW4ySjRBVVpPUFpnekl2aEszb3NMaVd2dHZxQjlnekpxZ2tsK0cvODdQVENP?=
 =?utf-8?B?amlGSE9NS3dNb1VGZkw1Z0h5clk0dFVuYk5kbnlPZjliK1dJWVJTMTFqS1pI?=
 =?utf-8?B?T1BUSVFITmhEMHlpMFVsOExtMUlNSHRJOTFQOWxOVHNhd0hwUmcyVWNGbHg1?=
 =?utf-8?B?ZTY5Wk92V2VZSEFvRHd0YTZsZlA1a1RwdGhPM2NVVkZPL1d1M09UOXJZdTJz?=
 =?utf-8?B?MHFFMTZ6VS9TQThWci9SWVpiTFlDTW5IT0FsTzRWeEFXdGkyRXR0NGFWTlpi?=
 =?utf-8?B?eG4wMWNEN21wNmhHTUZpbzBNbExKaWFwdWxFa2taNGxhUEZDR3hFUktteGtJ?=
 =?utf-8?B?dXhUOFN0MWtVYjhvcm8rdERhem9nZXdDcTR1T2xKdWtJOG9ERU0rQmNZT0Yv?=
 =?utf-8?B?c1RhSkRrdGtTdkROT09oK2kwQkNqdXd5UHg4WnMxZVJSakVCUjFidkEySVJq?=
 =?utf-8?B?bTlLenNRckhCYUl6UUtHcTJoenNPcDRLejU5NFpUNkp0bkY4dUMxVUJWQnVn?=
 =?utf-8?B?NHpPRm1Ca2gweVF2S0Z3Zzl0TXcwTTJVWEg2blZmT0N3eGJvSHd0d1JOYWJq?=
 =?utf-8?B?MG5FbFdJQmwvaGx4dnd6SFo3MTBSeTIrenhYV2lQZ1Z6eU1ERDBLU1UvQWxw?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b47321b-022e-4697-0194-08dd61d13850
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7384.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 01:48:57.8452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpnzqVeAMNTtad1LN1WRCK7GMBdhdxJmtVmGuycOkUn3qrMsi3ncVMtdo/TLyMQ0INnvgcTsdmOm+wg/BsGWOyEkt2e0znjjB/haUmWY/QM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8080

On 2025/3/13 04:31, Conor Dooley wrote:
> On Tue, Mar 11, 2025 at 05:48:26PM +0800, Kelvin Zhang wrote:
>>
>> On 2024/9/18 16:01, Conor Dooley wrote:
>>> On Wed, Sep 18, 2024 at 09:51:28AM +0200, Philipp Zabel wrote:
>>>> On Mi, 2024-09-18 at 15:42 +0800, zelong dong wrote:
>>>>> From: Zelong Dong<zelong.dong@amlogic.com>
>>>>>
>>>>> Add new compatible for Amlogic A4/A5 Reset Controller
>>>>>
>>>>> Signed-off-by: Zelong Dong<zelong.dong@amlogic.com>
>>>>> Acked-by: Conor Dooley<conor.dooley@microchip.com>
>>>>> ---
>>>>>    .../bindings/reset/amlogic,meson-reset.yaml   | 23 ++++++++++++-------
>>>>>    1 file changed, 15 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>>>> index 695ef38a7bb3..0ad81fe7b629 100644
>>>>> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>>>> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>>>> @@ -12,14 +12,21 @@ maintainers:
>>>>>    properties:
>>>>>      compatible:
>>>>> -    enum:
>>>>> -      - amlogic,meson8b-reset # Reset Controller on Meson8b and compatible SoCs
>>>>> -      - amlogic,meson-gxbb-reset # Reset Controller on GXBB and compatible SoCs
>>>>> -      - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
>>>>> -      - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
>>>>> -      - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
>>>>> -      - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
>>>>> -      - amlogic,t7-reset
>>>>> +    oneOf:
>>>>> +      - items:
>>>> I'm not well versed in preferred dt-bindings style, but this items
>>>> looks superfluous to me. It only contains a single enum.
>>> Oh, ye. Good spot.
>> Hello Philipp, Conor,
>> Sorry for the late reply.
>>
>> Do you mean to use 'amlogic,meson-s4-reset' for A4 and A5 directly, without
>> the fallback?
> No. We are saying that
> 
> +      - items:
> +          - enum:
> +              - amlogic,meson8b-reset # Reset Controller on Meson8b and compatible SoCs
> 
> is pointless duplication, because your "items" list only has only
> entry in it (the enum) and you could just remove the "- items" line
> entirely and have the same outcome.

Got it.
Thanks!

-- 
Best regards,

Kelvin Zhang


