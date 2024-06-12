Return-Path: <linux-kernel+bounces-210968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99288904B76
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD961C21006
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C117B167D80;
	Wed, 12 Jun 2024 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="heBoMDNc"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18BF13BAD7;
	Wed, 12 Jun 2024 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718173132; cv=fail; b=VvnPtNvz+On0TdvUvxrZHirDF4X8jLoNL/EMmZuhzZf3NoXHaOs3bW5zbd8pjFZBqNml2e9KjETK78xIXHFVOr95+CIgNbgaoAaJqz/K2oOMec4zeO7mxOmhMAZvAkKZtUAbajBGJt55yeBm1UNFB/SFRB7uuPoNI6yXbPr71rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718173132; c=relaxed/simple;
	bh=9qmVcGcov4NL9U650rX5AxsRVw+ZqWwkY69Y0hPg7DE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dcu0IDpOrj20tkjjllZfrvsI1pu8dXZlyHxAfTPJ+NkDq7l6vFHUEqgMcO7OrK8kNb4kBjPTTQ7CbIVa2BspTiPc6gBJmCuSGBG6SApr2Zy5GPDFjqw/SDpRnkti2EL7UnY9bzUnn+Jea2+OTlMoWxaEbxgZ4WQU6sGdvopt1Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=heBoMDNc; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJkeVGXWqNmgrGFcdsi8Cq1pEPjKKtYR66nDLtm0lO3SPVBzwTXJpuhzuAKgoGtDhvNh2dSgDaXUUGClGCVg7n/bq4swNXUnSydWOpvClo3JwGabuDzaCv4KOgevwDLbEDp9RgKW12q04doRZ6bk883HniKuaWuct4OEmbcSXEJr0N1hzmIMjInQeyBb5+D9xCrl4ktOO1atgmB9l8qfNpqRZNbYQCP6U630hn4y4m+P+HpGzPO36QUxdvTpCv8T21Gw6ou4uYxB2QsDck5Uj9GqC/YTQL2qrZURVw40nV/pd2m3Iw4CeaT+djBEdQrd3zTFMApIOSUL95pvAWxH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6tz0jG/wn3EbQEJpi1PXob/zB6l4ssTtJEl8hbZhJ8=;
 b=DaGTC/W3uuGW2zp8lzgdrWtOIrwLgenY0ddggV/uJ02zvtF8kIWsiDMHcfJrXlWwSIhdPbCSPp6K3zoNWVxDkZteJnO9WhD22sZDwTFeVw4bKyFqpZnYvJbcCykbtH3s5ptxzFptRwW50DTd7+7I599CTrQFwAwHLzqjgUg8tCjOkZmEFdsV/Wd/DY3My4AjwEYEHXZBu6xY9u3aGJ8g/FQlI7Vs+TXi8IMlXfLvuo8jMiSMaHu5zY7Cje6p55qArKEoQ6prbt75yYsowHKKnBrB6kjaotYYbo9+BsF2+DNm56iWxmNGgdQq0BO9igj7Ex91fm6+JfhRrSr13nJzOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6tz0jG/wn3EbQEJpi1PXob/zB6l4ssTtJEl8hbZhJ8=;
 b=heBoMDNcR03AUq4qOjTsq5Bv/C9VpAaSrhmNwAohHok+kQXlk3h6jUodKuOnw36MgOe0iH4QJnUNTEzdi6y+vEBAtRvgB6JwgsrVamLA4YsamPLX+vBLcCmAECb+E/0DXBWqSGBRTlGT4i626hRzzabOihmra/R5loOafRjlo4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB9PR02MB9994.eurprd02.prod.outlook.com (2603:10a6:10:462::8)
 by PA1PR02MB11008.eurprd02.prod.outlook.com (2603:10a6:102:48e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 06:18:42 +0000
Received: from DB9PR02MB9994.eurprd02.prod.outlook.com
 ([fe80::f9a2:77a1:a5aa:8f8b]) by DB9PR02MB9994.eurprd02.prod.outlook.com
 ([fe80::f9a2:77a1:a5aa:8f8b%4]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 06:18:42 +0000
Message-ID: <ef71090e-13c7-4ef1-b34e-d6fe9546b705@axis.com>
Date: Wed, 12 Jun 2024 08:18:40 +0200
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
Content-Language: en-US
From: Amna Waseem <Amna.Waseem@axis.com>
In-Reply-To: <34fe20d5-c67a-44e6-8ec1-566d80e25447@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0094.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::35) To DB9PR02MB9994.eurprd02.prod.outlook.com
 (2603:10a6:10:462::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR02MB9994:EE_|PA1PR02MB11008:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a7bf82-35ec-4af8-620d-08dc8aa781cd
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWY0ampzWTFLMlJVWERsMnoxeHgwVTdmbldHSGx0b0JvWnVwaXhTbDRteUlM?=
 =?utf-8?B?U3ZNcjFYMVBWa3lReklTVVVXYVdweUNqZU9SOXAzL3plZ3k4Y1ZTeEE5M0xz?=
 =?utf-8?B?MXdqRC9VS0JGZW9oMGdQVFZuaC9TK083MGZtbEZWNFUyYWdPbmRzQXlpQWRP?=
 =?utf-8?B?SkoyRmlxaStCNHRIbHJ2TjRVZWtrSGtWdFVjU003cG5EY28zbGwzSXZTbUFC?=
 =?utf-8?B?akJzcG5KNVlWNkFyekIzOFc1d0ZPd1N0S3A4MWRKWitYVUJvM2picUM5Sjh4?=
 =?utf-8?B?eUV4NExwQzAzRU9vQjVZbjF0amJaY0gzWnhRMS9NSUVlREJaVnlGdDYwVFVw?=
 =?utf-8?B?RGhDZTJ4NWJrYm95Q2tIVC84YnRadkk2RUZrWVU4dFVtNndrSmtpZWRESHNU?=
 =?utf-8?B?YXJoNGNldFdFVEwraVZVTUh0dE0vc3hKUXFHS0VSNzRUSzdTNE5EblpLRVlR?=
 =?utf-8?B?enJZbWZTUFRmV0RtYWw5M0lDeU9nM2lua2w0VkcwYU9ZeUxzVDErbjJSN0tJ?=
 =?utf-8?B?d09oSkZMZExoNWlVb0tDQ1hlNmUwWmovZThBM29lK3l5dldqMTJEem9EaFB2?=
 =?utf-8?B?UnZ5d3N6bWZkem80UWNmek9EYnc5a0o1ZlBhNGZlakdOMks1SngzTEpDL2Rn?=
 =?utf-8?B?b255OFhSaENMWjBUM21LK3VxTUY0bjV2c3RMSTR5ekpHUENGbGJTYUtYZXcy?=
 =?utf-8?B?TXpidWZRMC9scHJMejh4aEdvbjRLV1VPbHlLcGN6SmdXb2dmT2dVa0h4akp4?=
 =?utf-8?B?MVNVUWdadTB6U1k5QnJWekRybDlhdnorM2VRNjROZnh4ZVdWOGJNNVJEQlR6?=
 =?utf-8?B?ZjltRm1mUkNTRTFER1F0Zi9Id0RCZDFGZXpPZFZpY2NHclAwQ3lhZitYVmtp?=
 =?utf-8?B?aHB4azVuU1ZTUGk3SlphT1FleHFKc1ZiRlZtbllPM3MwclJVRUp3cHUzMnlH?=
 =?utf-8?B?anZEZksxLzJMWm5jU2VsUVFuNC85ZG5ycWNZS2xFQTU0cERKZ0pzOFB6RUln?=
 =?utf-8?B?V2lJR0htYVRJODFOWTMrZWY3US9Jb0xKMXNpU2ZVS0xMRHdUdFpNOHFaYmhG?=
 =?utf-8?B?ZE82aWdkaUhMOXlBcWRnaFhDbGVwTmRwbUFrSDArb25TREZYelVidzdoUmp3?=
 =?utf-8?B?T2ZTN29PeWhKN25iSEZJRXhibU50WHlIbnZPdkh4a2krZ25BRUZaZ3VkK1FQ?=
 =?utf-8?B?MTlKNHFmUTJuOUxFQXBNVkZkREROR292NmxFakRmbUp0T0xST1MzYWpOWmFa?=
 =?utf-8?B?WTJNUFplYXVFOWd5Yks5M210dEJJSlZtb2lMVnBkVi9EaStUcjh5dCtIY3Br?=
 =?utf-8?B?V1N0SmFlMStKZ0R0SGpEWVN6L3VNZ1pBSEJQSlFRZjVJVEd2LzVSblZ1OTQ4?=
 =?utf-8?B?SlJBMThpQmxHNVdkbUM5cXRNNXFDUzc1aThpS3dCSVVNZHUvaFFRYjdzaVJG?=
 =?utf-8?B?SFo5VnJWZlN4eG5WQ0thN20xbEtESml2cWdOUllmUjFVWVltUW9pdVY1UEMx?=
 =?utf-8?B?SEp2OGdRTlpqMkx1MWd4YlNEOWN0d0h2b2RESHB4dnZseDd1dnhlSUdZYTVO?=
 =?utf-8?B?dnVyRDRudndkc25ldlFtc1JkMDk3RXlyQzltMWI4UTU3UTRqZkMzZzNMRFV1?=
 =?utf-8?B?aXlZUVdwZklWbHhYMTRXZ2crN3hVK1g0UVA0MlQrZDVuN2NETE9OdXEyUDNx?=
 =?utf-8?Q?y6qLD1Rcb7kAmMHfndFL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR02MB9994.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVVUbEkwU0tjaFhRZXNDekkzSklENllZTkxsbFFTMDlRZ2pBMjZEK3pEWVFq?=
 =?utf-8?B?RVRKejMwZTZKRkxTSFMxMk5seXZEb1lKTnJReS82TG0xWUJtaXNFYTN3a0tE?=
 =?utf-8?B?a3FaaHp4OEdycUovd1RvcUlaNlJyMmhHVlUvWXFGem5XdmFhVEhza3Yrc0h4?=
 =?utf-8?B?cHJFNUEvNjUzay93L2NIZ2hDQVlqdThWSGR6SWY0YlJ3RUlBa3U0b1d3TXRs?=
 =?utf-8?B?Z09oUHNNcDhyK0sxZGFRZm9Xc0FSUVhmUmZSWWNqeG52L3YwS2FLQjdKWjVk?=
 =?utf-8?B?L01iUEZJVDNvUDRKZXpxOWZRQ0JOd0E1ZWF3ZFcyamh5WmlBZlZMZXdrNDZv?=
 =?utf-8?B?TmZ2OU9RV092bytSQ3RkSUs2Z052V2hRRlVFQUNBWU9kWlF3c0JlUy90b0lJ?=
 =?utf-8?B?N1ltSTV4NnFIUTNiUHhPWWE3Sm1sUmx6aXRKcHNRbzhwSEVBTUU5cEdZTFpz?=
 =?utf-8?B?UlA0UTVqWE9adHBMOFBzV3RhTjV0Mmw2TWI3WktLVFFCTXNPZEVBQm1IRGlV?=
 =?utf-8?B?TUhpT002K1BUZ1lOUVdaYmg5VTVnS3FuaXhiVFZmV1N0ZkpkRkRORGI3ZGxn?=
 =?utf-8?B?Y0dGY2toSUs0WmlPQ2N4K3l4dUd5N1ZRMU95MVAwbjNOT2p0OFFFdzZ5WXJh?=
 =?utf-8?B?OVVkNENqNFlFR00rakhJTWYrRnNkNUsvVmZvcWxLbkIweHNFQlQrQnIwcE5p?=
 =?utf-8?B?QlFMa3MzUm5jMHcvQnRBVEFVRmxqamNUYUhHUjNBK05zMFRQb3B5bSt4eGtT?=
 =?utf-8?B?ZzZJdUpyQ2Z1RTdEZ0llV2YxMWh5ZlFEUThueFhCTThFMXVBRE1tQVhXTC9L?=
 =?utf-8?B?RzdVcHdCZk80czhOTEI1NEFoMkk0Y0o1bmpJemQ3V2s2Vld1V013eGlvT05x?=
 =?utf-8?B?bjUybCsyZ2VRUnovT2oxWnM0K2xzQzZKakFVQk5iNkpxbzUrWDZnSEY4TUZ4?=
 =?utf-8?B?RWNueVFBVUswWjBYQkZtTmdQd1pXTk9KOG40cS8yQzhnRXVEaE5nQmR5bjhN?=
 =?utf-8?B?eGwyMkpUcEVYSVdtY1ZFZElyd0FjcUdudVBZNVMySkdicGdIWFVXbysrYzJE?=
 =?utf-8?B?WENKWFNMVXNzTS9UcEZwelh0cEx4K0FaZmNOZTJseXkyYWhoekEzZWMxTlQ4?=
 =?utf-8?B?cng4aWhtNzZrNm1uTUpGa2dmVDBTNWxmNWk4VFZrSjh6aXdZODNiUmRaQWl1?=
 =?utf-8?B?OEQ4M0pQZUM1c2pKRnlKNHYyMWNqRm54ellaWERkazViRW1NOEhkUHZVelZ4?=
 =?utf-8?B?TlJvODgzdmozKyt1TG5LVytWL3hNOUM0c2FadHJBeDViWkpsdWNhamRpSi9N?=
 =?utf-8?B?dEkyUklMZ0FhT2RSWmFrd1RvTy9FL1lUQkc3R0VHdkpFTFZlWUg3SEpPZzJ4?=
 =?utf-8?B?K1pLWWRlTTkrR0pNbmh1c2JQWGNWc1FodzVyRFJxMFZ3K1hnZ281WCtDcTJu?=
 =?utf-8?B?UnhhTnZHcDAxalJsdzdJM1ArOUVnM09wQjU3dEgrQnE3SEhkd3l2QUlHQkNX?=
 =?utf-8?B?OHVla1JJVkNHakFwSGNlNnhXT25Kck1LU0NwMkwzRjNDTWtXWXE4ZHcrMXVu?=
 =?utf-8?B?NUowcWw5OVZNN1VadnJBZmFiZmVTejZXL2lCS2ZHWE9SWDhhUWVJMHZ1THhH?=
 =?utf-8?B?blRIVi9TVitLc0pLTkM0OXJCWk5jdkRDekpPUHNGbUJHM2s0aDQ3NmRpWGll?=
 =?utf-8?B?ZFh1MW5LR1VqdmhRNnorQWVneHFqOFdFeGtkdmlKZnhXWllhdEEwaE5QVjN2?=
 =?utf-8?B?MCtWVml5OElzT25lNWxHUEFOaUhPdUJzSXJ2RUJIK0FzaDVPTzlnaFZaMDZU?=
 =?utf-8?B?cTVtemorOHVYRDIxUWVrUi9Xamp2Ni8zcFFuZzNGandBWVZVc2lBUjlKeHdq?=
 =?utf-8?B?TVBoVVBtQTNzT1JUVkYrRDFHRDh0L1ZPcnNYTkh1WTV6dTV5M3FacjRJeDJU?=
 =?utf-8?B?MldmbTF4L09QeS9ubjd3MGFwdkY4MklFNFc4c3dVN3ZvN0hSZHVNcHhPeDR6?=
 =?utf-8?B?VTNrRW1FUEhTMTRDeDlkSVhyelZCMmMrVmJBMEF6NWNFQ2ZMWU82L0E2bDNI?=
 =?utf-8?B?aCt5a3dqSDlCOEtEZ3hqb1VpRG9JaHM5R0YvNUNTSy83NGJneW96Mzg5a001?=
 =?utf-8?Q?b95k=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a7bf82-35ec-4af8-620d-08dc8aa781cd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR02MB9994.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 06:18:42.3691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hp+z80wQ0k+LQXNSJRhp4sqAs0j9KIQL+oavmoKAZ9tio3OoKrNl9CiJKsACbWTx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR02MB11008

On 6/11/24 14:49, Krzysztof Kozlowski wrote:
> On 11/06/2024 11:36, Amna Waseem wrote:
>> The INA230 has alert polarity bit in Mask/Enable register which can be
>> configured to be active high or active low depending upon the requirements
>> of the hardware using this chip. The patches in this series adds the support
>> for passing alert polarity value from device tree to the driver. Alert polarity
>> property is added device tree bindings and the driver is modified to read
>> this property and set the Alert polarity (APOL) bit value in Mask/Enable register
>> of INA230.
>>
>> Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
>> ---
>> Changes in v4:
>> - Remove unnecessary checks while setting alert polarity bit
>> - Link to v3: https://lore.kernel.org/r/20240603-apol-ina2xx-fix-v3-0-b9eff3158e4e@axis.com
> <form letter>
> This is a friendly reminder during the review process.
>
> It looks like you received a tag and forgot to add it.
>
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
>
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
>
> If a tag was not added on purpose, please state why and what changed.
> </form letter>
>
> Missing this is really odd, considering you are using b4. Please read
> the b4 guide.
>
> Best regards,
> Krzysztof
>
Thanks Krzysztof for the information. I have read the documentation in 
the link you provided and I will keep it in mind next time if I submit 
patches.

Regards

Amna


