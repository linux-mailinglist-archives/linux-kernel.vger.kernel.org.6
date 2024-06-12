Return-Path: <linux-kernel+bounces-210991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5760D904BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095C2285EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62DF16ABF2;
	Wed, 12 Jun 2024 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="agdTafvN"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2064.outbound.protection.outlook.com [40.107.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2111625;
	Wed, 12 Jun 2024 06:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718174242; cv=fail; b=R8IpIYU9PCM29l7TYFy93IVkXr3qER7LV/K213ZLuTFYrnLaCVyHJ16p5TVnGqT+7SKfTV2jS2ZsYpfvzTU66I060mxnFNYZzw06NeGlug2CX1q8b07M+PxShkscPlAmZyOU0ENLnaMLmBmSvRcXdXUpQW5WlFnCZ0iX33CPM/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718174242; c=relaxed/simple;
	bh=mVaUPUQvQD9pCfXVQ83aaVFY8n/Xy5In/lRgUTkPEDI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g1XyBUWUyxnI37DYmEjxjwHRVIVjaoitYhRWMrQg7e0BkflvEqegr0f6wKKUuxDZGvqEQcTIBhJx+rKN6xoPhMNSOai3qql9Levi8bzAi7jJFqMXD+WRU//I1Y7zg0KvWRh0/1V27+YsyyfgpN4R39VZuaOt0mqGgwZFoRchITc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=agdTafvN; arc=fail smtp.client-ip=40.107.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enZe0A/7H05kHsdsJkG/oQ9PhPY8N1hqMxt3sTF0Anpt3kSCfOE7I7paRBTArV0jiFuEwPBQqi8PSPdJNEaCQi5QZIavwLMU7Hgjpgww+xktYWs/AyfNd4ktnS+nP5bjQVDQ93S5yiYJivHFPKu+ulJyJsW0NcmGSrSqfB7+EpueLUGwVWLe1IhH4T3DXzNiQZg4saySkuEXP9UvKxgLRhEN9TGkTTZeIVeDEVy3afJQNNz3E0yVFNWE7Ux16O5xEO9HLBsTB/9hkHRq8Z0NFqtDwxVSHJY1/c59dD7n/QYd9H/PM5TTWeOBZr/1P53tSSBSWW4VcTm8auin1fg27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVaUPUQvQD9pCfXVQ83aaVFY8n/Xy5In/lRgUTkPEDI=;
 b=lljxWKS6bPmPJ3orPykUPEmt3W3OcfeOKTKrCZ86VbHAR70EmZDtsmOaT5+ULIUjPrrL2t069de2Xl8bSa4pxrddjlwsZ0QbYfQKFNAa8nFH3PefeVDX+8kRZuZv3y5Vt3R4FI2W+d13OKSobBDyZxo2sxcmDs9VVW4bIuKR5n4BHFxSZnno9CmJH/xXcBJ4ciZ41QOt+D8DkagZmbrHjPgXMW9ZiKeN/jovsZTa46lYebO+COoAnONxnpKn/BheYTIhRMZKsb9LwGqvrjag/x396GK9EVtJ2I+UhbgGRr2++hSn2pUKMqTRE0OktUVHa06XfWNa2tDOn3/R/8Ktsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVaUPUQvQD9pCfXVQ83aaVFY8n/Xy5In/lRgUTkPEDI=;
 b=agdTafvNtW1cRz5KW6nudlBwVUSOXDTlCkYyRlitGkb5twuxJs8ZCkhLAjWS5B3DboXWn+58uL7OiMD7A5jy+KeNzzEMZMurUM0LpJIWQUFJ3dF8M8UENgJK54dzkzlVkS02XSRhUpZTRlN2Uj855R4B9i690trarnNzFZlQqbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB9PR02MB9994.eurprd02.prod.outlook.com (2603:10a6:10:462::8)
 by AM7PR02MB6338.eurprd02.prod.outlook.com (2603:10a6:20b:1c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 06:37:16 +0000
Received: from DB9PR02MB9994.eurprd02.prod.outlook.com
 ([fe80::f9a2:77a1:a5aa:8f8b]) by DB9PR02MB9994.eurprd02.prod.outlook.com
 ([fe80::f9a2:77a1:a5aa:8f8b%4]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 06:37:16 +0000
Message-ID: <4af156a3-37a6-4995-a3cd-8340c17345c2@axis.com>
Date: Wed, 12 Jun 2024 08:37:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] hwmon: (ina2xx):Add Suppor for passing alert
 polarity from device tree to driver
To: Krzysztof Kozlowski <krzk@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com
References: <20240611-apol-ina2xx-fix-v4-0-8df1d2282fc5@axis.com>
 <34fe20d5-c67a-44e6-8ec1-566d80e25447@kernel.org>
 <ef71090e-13c7-4ef1-b34e-d6fe9546b705@axis.com>
 <629a1867-94b7-4f89-821a-a38b92189af5@kernel.org>
Content-Language: en-US
From: Amna Waseem <Amna.Waseem@axis.com>
In-Reply-To: <629a1867-94b7-4f89-821a-a38b92189af5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0022.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::7)
 To DB9PR02MB9994.eurprd02.prod.outlook.com (2603:10a6:10:462::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR02MB9994:EE_|AM7PR02MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c3daef7-ee68-4776-9522-08dc8aaa19ea
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzRiQ3NlTEY2dExOTHU3QzlHV0tyL1E1dVZZbXErNUtSaWloTDVKeSt4VGpW?=
 =?utf-8?B?T1AyNGk5VXpqK3RZaTdmdGh4ZkduTnNMdFV5TzNGWUlKVlJDNmU1ZDU3L1hM?=
 =?utf-8?B?SGJOMlFDTWNLS0psMlhkNDJ3RitsMFYzVWNhSEdZbS80bTI4VWQ4dUhzcFUw?=
 =?utf-8?B?bjRXOGRDVEhOdDAxM3c3alloalZzdFFPa1VmdUNsRFRUQlRITXhBRS8yU2My?=
 =?utf-8?B?aGlkUUhkYVlTR0Y1S3dQRitUREFKZmhwQXJhWGp0Rk4wNnl5OTBjNDU1MEtS?=
 =?utf-8?B?cnpqS3RubWJqa0hxWVRpLzV1aXd0allnNWdYVGFlcjFubkZCbTNjK25ROTkz?=
 =?utf-8?B?dm9MRkxoZ3BwczhMTkxhUUduV1ZFMXpPdVQ5dWQ4Q1pydlJWNG5UTE9DQWor?=
 =?utf-8?B?SU5oWXI4cDBXMERpS25abVVOb3hsakd4VkZIeWd0WnArbVNtQVlwUlFXUHpV?=
 =?utf-8?B?bEIzS2FRbGFDTFROUnVWTkc5Q3REMEZKODlncmdFQ3Z0eEU4MzB4YlJZWjFu?=
 =?utf-8?B?N29tY0h4R0N3cEdWaVlEQWxyWWlNNFdVTG9zRFJMbCtnSmJHdEY2bkJwQi8z?=
 =?utf-8?B?RW9CVUR0aXNPS0lyOHNxa2haMGVuaWYrZWdWbWFJejkzVExpemhHUWs0QjhQ?=
 =?utf-8?B?MkRES0RNZWpNYnFiOTIxMG55bit5bTVSMUhjdzltME9RbTFyS0EwUytCZ1hP?=
 =?utf-8?B?M3NDc1pLMDlCSTVsWEdyVFlnZWJ2VW1MYnZ1UXJaSFBrb2pZK0xtUE1uNFA4?=
 =?utf-8?B?Vi9NTlk2U2hNL0JLK0ZjQmJnNEVsaXJGelhhdzZvR3UyWXVVTXd6ZUtiSHBx?=
 =?utf-8?B?RjF6bGVnbmlWZzJVMThTZUxhN1IwMWIxY3U4MkkrQmI3TXczNk5nMnR5cll6?=
 =?utf-8?B?VUhmQzRGYVRJZzZMMmpPdnBUeC9NemFxNTlYVVJtb3VPclREdFdJbXQ1dFo2?=
 =?utf-8?B?aWhJS2F4Slg0d25kbCtnSDZ4QW1DbjJ2MHFkdngxdHJ0MnV3NUlDOGZvRzhS?=
 =?utf-8?B?aDBCVVg0OUExNUlxY3ZMZDBESGVGZmlDbjZDTzg2ZzM4dGFJb0NKMnV3dk4x?=
 =?utf-8?B?NStDMW44UlJHalBHcFVQd1prTGtBRGRDUXhtQURORVp3SXo4WThsNVRLZjJH?=
 =?utf-8?B?V0VQWnpzU01uQ3JPOE5RM2VPUm1GZlIybmNiTmY0VHVhcmNJNXl1WmtiOWdS?=
 =?utf-8?B?eGl0YmhZRE9pQmt4YXd5c2gyQ3dMR3JLbDRvdWtBQmJqcWlQMVV0WVM2SFFN?=
 =?utf-8?B?TzNzbzRmRFFMck14a3ZhZHpEY2Y4b0E1Z01JYjdqckdTMUJFOUVwWG1wVXlK?=
 =?utf-8?B?MU8wdXFTQzQ1elBsejA2SGRJb3VlcGN3bGx6cDZ6YXFPeDNEcGYrMyttdk13?=
 =?utf-8?B?YkR4STh4bFVVakl0MDI5N2xsWDZSa005MVp0WHpCdUxHc0NkTGt5eEk0SnF6?=
 =?utf-8?B?Y3hvOUJPMkZzVlEwNmhVOVVwSmdIcGI4U0NKZnk0ckNQRWRFYitUTzZIN3Fa?=
 =?utf-8?B?SVo0eHNCbk1EQzhwdGpwczZvU1Q4VStKVElOU25KdnJ4enFLbWJVS3FZM2k3?=
 =?utf-8?B?ejJOd2Z6aTlxNEhqRE9zL0lHajhzeDhYMmxMdDZVbUVPeHB5YmUrK3FSMjJC?=
 =?utf-8?B?dTF5YWh5R3p4UC9teXpBaEFSSEQ1SDhXaGRvdE5ZNDMxRnVTRXI0MHlSSlFE?=
 =?utf-8?B?NnRIQ3pmbjJKbkNlTllrQzJTdkVFOHB5YnhhQ1k1VFNTSmg4WGpQUTZjaUhs?=
 =?utf-8?Q?Y5GUBpD8p4cyNaq90QHX+zvH8YLMe6DX4osl5UA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR02MB9994.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXN0bWZQQ2RrbkdsemlpczZlQXZDWHoyS2ttY3kyWWJlb2ZiYTRxeWdZa2Jr?=
 =?utf-8?B?ZFU5d1BUZk01REdlM2x5cC83Q3dMSHhGWUgyc3M0RFR1U2xjVHVGS3Nkejlk?=
 =?utf-8?B?cm42ZDh6WmxzNGNSdWNra21lTk51Zm14UWNrcFp1bTNCdEdmVENKQU1rSzZW?=
 =?utf-8?B?UkpPNVR3U2xVTVkwZWdsei9jWks0L29FcG5YUTdxTThXdlEwZ0x5cDFsTlFw?=
 =?utf-8?B?VUR2M05ONmhLNzlxQ0ZQU3Z4YXRLeEhVa3piamJaUkdUMXg5QUlDWUQ4TGdE?=
 =?utf-8?B?dEFqTEFuMGNJY2QzbUNkSnd4Z0RUWEtVUVA1TVkvc1VOZDBSRThsSzlvU0NU?=
 =?utf-8?B?YmVOOW1vZnUrYzlkQW9GQ3p4QlNSN21VRVFJeThycHNsZDFMV0RRRjlXRGhO?=
 =?utf-8?B?SGFJS1dENnNXYTVadzdNeS9jZTMxRUxWVVlZZzBnUi9qNlR2cngwWEEyY08x?=
 =?utf-8?B?SFZkR0FWcTZXdkFzVkMyNTg1TXl5RW1QM1I3cUpkdW1iaTlHaXVnVjhOZWM2?=
 =?utf-8?B?QzNoSDFJNkhzbmFwR1FFRStsNVdVVVJGbVZKbThDK3BjMEE1R29GSWVhcHBx?=
 =?utf-8?B?bVZ0WlZhMjNCZUJzNXp0QkE2SVB5SUVsQlFBZjA5SDVLMi95WTRzOEI2ZTE2?=
 =?utf-8?B?UXBxdk45ZE13RXlaSU9kZW5oa0sxampVMmJPQmVkQmY3aHN6cXZKL0JVVFZV?=
 =?utf-8?B?WTFWOFZ5VjBTMXBhbWREVzViODBXRWJZNDRpMnhkUkxxNVVCTXNMeGRUOHgr?=
 =?utf-8?B?SUdZNitLclM2MnVCUE9YdkdhcVd4amp4dmRZL3M4cUY0a0lTK20yazNmSE5U?=
 =?utf-8?B?MXRaOFhiREJGY1g4T1pFRGRid2JvWWxybmpKdXJURlRacmV2SUpXQTZyRm82?=
 =?utf-8?B?M3FFS2RLRlVzMm45dlFSK1NZTUZBc0VDT3hjQnB6WXVqK3ZNdjFYZ0J6Sjd3?=
 =?utf-8?B?K2xTMlJ5YzhLTEU2MEo1UlZVUnZmei9GdllQU24zd3ZQM2psTTdRR2QySEQw?=
 =?utf-8?B?YTVnM3c5M3lYdWVGMkREaS9OcFk3aTY4Vndxa3k2NXpHZURDV2lCQVIvOEM1?=
 =?utf-8?B?M1crN1ZNYksyRDRvRStnRXRXUWIyRUppdjlrZ2UvNWZXeTdVZndvZDdYT0Zh?=
 =?utf-8?B?MkE4RzdqbFd6UFlQalh1dDVMbDd4aW9NTHg5TDM4dS9WSjVUSWc2Z28vbmNO?=
 =?utf-8?B?b0xqUDJRa3N0T1lPa3F0c2hRazlSeGc5cXVnOFRSK0x0WkExdzF1VFU1RHpN?=
 =?utf-8?B?QXhwOXpLRCswZ05ncU1GbVVSYm1tdHBhSlpYMmRJWnRGdnQyTy9BUzFWRE9B?=
 =?utf-8?B?clgwQUU1NkxxR2M1TG5TLy96OC9jaG5vUlkwSGRCNjlIMEd0aDFuVU5BZHla?=
 =?utf-8?B?NDNuY2ZobHlsTUZMaVJQb05hQWFWZTJQczV1THNEbVNpSHVNZ1pkVkI3SGZX?=
 =?utf-8?B?NjFSUGkzSGNydVBqVXZMeXJEV1pTNThTYmJBb1FhNFEyQzBNY2xZVVJhaDF0?=
 =?utf-8?B?czdWeU52RytaMFBoSFFXUzEzdDRGc2pOUnp4c0htTDkrckJ5Y2RWTGxKc1p0?=
 =?utf-8?B?WTJvKzZpZSs2V2Q2OWU4bThEN0tTYkhOT216UDI1eHltcmJmdWMrQnZpN2Vs?=
 =?utf-8?B?eGd6V25BQ1paMDdWOCtSNTBYR1BRWjl1RG9rTjdHakJnZ1NGRVFMU1F1eVRa?=
 =?utf-8?B?MDU2d2l1VE9obURoSFRxVGRpNG52QUgvcmhFN2RrUVhPNG56RTBRdDRXNklQ?=
 =?utf-8?B?RFZKTko2TEczNGN0M3JKQXpGdDZ6dTVhdE1Uc0JORjNBWmE0dFNPdER6K2FQ?=
 =?utf-8?B?UlVKeHpBYnBBVjJkZENNdFJQZjMzR3Y2K0I3NUZpa212ZzhBNTZSTk04akts?=
 =?utf-8?B?SGgvT0xKVnZ0ZkpNTTY1dmZCYzdabGp0di9XTm41bVF1MnZNQzRDQzlVY3ls?=
 =?utf-8?B?Y3Q5U0lma2F2QTA4STYvUGw3Z2piS3hsNHRCWU5DSzJMaG1CQWxocHN0YTIw?=
 =?utf-8?B?VCtxU0Z0VGcxeHlxdjNTdXFWbE5CNGRPNUU5R0F0UnNFZ3NTSHlCUHVGMzdk?=
 =?utf-8?B?dGFDM2NoQTJDSVdjd1FzNTFHSktKRVo4cHJERDRqc0lGUWhNMnBYblpFZGpZ?=
 =?utf-8?Q?opdc=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3daef7-ee68-4776-9522-08dc8aaa19ea
X-MS-Exchange-CrossTenant-AuthSource: DB9PR02MB9994.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 06:37:16.5327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCK2Q31bZMvTLET79bx3Dw7pDml3sQIs0b8qbEW5VtH29SFDyyKnh56SQDJcJAKI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6338

On 6/12/24 08:20, Krzysztof Kozlowski wrote:
> So you require someone to re-review?

Yes that will be great if someone re-review.

Regards

Amna


