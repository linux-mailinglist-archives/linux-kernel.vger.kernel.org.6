Return-Path: <linux-kernel+bounces-401657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C78569C1D95
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C826D282BFF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489091E1C22;
	Fri,  8 Nov 2024 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="YvvOgwWh"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2139.outbound.protection.outlook.com [40.107.255.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133041E7C19;
	Fri,  8 Nov 2024 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731070997; cv=fail; b=DvHAVvI0tjlY/Qef99okNQ8qTJWk3h+x8tjqO9gtTK4Camr73XRsFGsVqiJBW/noXmo2aMwpf2ZXqUtZyBv0Fqgso7LspgmXO+D5RvFsjnVeAB2Z1L0Ue3mq6GvPNYmAKzX2LI5FDhptqmrL1ce2rtjPTU83dy/CRuPsF62CgzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731070997; c=relaxed/simple;
	bh=jnkEFULCYj0BcAQz77fZ/iewyyWOuMDo+5Ceb79oc5Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LMq7GcYd4+jLAfZfb9TJft0nHUJg7/lanarpYUDGMwubaDTGi1Vzy8cbVEkYKQmesgPvGM65mryGGI9Pv+i0/qz/pZhVVM+V/rNo7O43UvHsnVt7ItuDKtjVVJktmM3iiHYMMCCJjay34eEcK0fHMtB0+E2WPishyheQfNeqsZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=YvvOgwWh; arc=fail smtp.client-ip=40.107.255.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4NKKV+atPzwLeS1gt6ciLNPdLDaRFW8b/CzyBHMazi+Y2WoY0h5mpItow3C3KbPp2M1qun3EY4ZT7BUFBdqoH//DlW6FO/nTG+MCCJbv3N1pYrSC3JdeuMWUZBpLMhh8ETesPOcNBj2GrEfvz+dZ/U59weKJQreeSc3tAxdAwrph7iYS3xynUzxyT3rMHsZVQnDPb6o93DeEX1L1CIvmxjluXaY6OZoLT4de8W0IuwqwRlwSRxtoLrTkx26cbW+FHZ3VWsCHV+pAy4irgFbXtsudeRid/sn/HnHrpphWYwbRLelXUePxX+0fblL58V3gcmi3vceo5VoJxmj6eusuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFEvKZ6ONsrlCoP1CozYnCA410fW35kl20UxukAJUYM=;
 b=tdz1x8mfvcjjMjuvzaF4gCFcTAgYhzsr13wYceTLuTHZt701JNWCEXH44smNG4gWEh9i1Okjx3W2Z4kHBVX060j/hLk8S8iHWjbFu43jL2jXx6hNym5YXRrD6lzKdhj6O7cgSvqEydhAbJuMe/UKj4moE1fMi2ISXxisTM8dKnnkiVpSlJxKjsC5iJy6dpi8VGxg6KtjYazRcMuecmRO8oS5vCx1fE/UHWAz+5Y/hCpURABc2nMJFlUbBmMnMhwU0m6er0UeIm8uowbzayw6TibfF6Wvhz1C2IMcjHpAa+zRl8/EzzSlHVbjH6qR9HTOCECCDvlmeJ4VbKT6GTHwCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFEvKZ6ONsrlCoP1CozYnCA410fW35kl20UxukAJUYM=;
 b=YvvOgwWhvvgdRxe1Cx7LpJx480JVyTXvX3vnw8eAlhKHn2UAJPPFi/IgsgwmKs0LpAjaPYX9g2Z4lJzcWX5LEc1GZVS5ByLn0IlpD9EzZAhW3X4u1BUYyX7qKXlSdv7RPZpT0kgZhAMsCLHaGEUr9W30Tky7FjNK/EfNvG3IHPBEOC9Uc3vADtz6yLgPg3hAjAQsk/25/DJK7Sw6FjS3Ljvbc1toEufj0imhCMl1S86Vl+uUTHZ0evno0qAXvdOqfRL5A/gqJCmFma/16bOO9IIx1XoL6tUnFgcqGmOn7GQZNeV5/8G/hyd5poBB7/by0lJzlwWzWRTHrX76GanWiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by TYSPR03MB8447.apcprd03.prod.outlook.com (2603:1096:405:59::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 13:03:05 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%7]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 13:02:59 +0000
Message-ID: <41ddb893-0eca-4c62-9002-310ba15a89d8@amlogic.com>
Date: Fri, 8 Nov 2024 21:02:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: Fix the CLK_IGNORE_UNUSED failure issue
To: Jerome Brunet <jbrunet@baylibre.com>,
 Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com>
 <20240929-fix_glitch_free-v1-1-22f9c36b7edf@amlogic.com>
 <1jed51tjhj.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1jed51tjhj.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|TYSPR03MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb1cf24-fcda-4417-a00c-08dcfff5abb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZElJRXlERjUvdm5uM1BTbXB4VUhRNmdBMjVlSTQxUXlZaVNvYTFETEEvbjQ3?=
 =?utf-8?B?ZFppSWRSRGpqamxPUk16ZFhRQXdUaUtUT0tQcHJXK0c1czQ1VW10aDY1MUVv?=
 =?utf-8?B?d0tvbTJQK0pDNHdVbFlyMXIxQ3lTNUtWc0xoa0l1ZjF3L2hkRmllVGpSTU50?=
 =?utf-8?B?RWZPeGtRSHF0Ui9iek9JbkRMUzRPSExUeFFkL2tmUzBuR3VLZVJGai9hOTZD?=
 =?utf-8?B?VTJXTVMrNzBDcU9HWXVLOUFJK29QVHdhUWsxMCtLM1J6bEIxVDI1bEc2aUhw?=
 =?utf-8?B?bE9jWVJOand5aUNqeDgzZFg1d2crSlBJRkpUdTdIdW1JWWxlaFdsMzkxUXpI?=
 =?utf-8?B?bmhEQVo5ZG9NRTBJUEpkOFhKRlFCWEVPcnM3bWoyQ0FLdXpvb2QrZ0VJTDM1?=
 =?utf-8?B?dU9tMmFLQkYwRS9vM2tVOVNiRWd6UEo4Yi9yMjhzcmNhOUhWTVFqbHFwdmtG?=
 =?utf-8?B?S1pJYVU1VXFWSWppcWszcmlYemtPcHJsM0xsTTRLRUE3N3BmYTFxY1cxT0FW?=
 =?utf-8?B?Zk16bHEraXkyRW5oeU5Ob1ZFbGhBZ2NtZzVGWVRwNkUxRlFTMnZQRUY1QkpX?=
 =?utf-8?B?Q2VjWVcxUHJ1eWJQN3FJZElaaENEZmdVOWwxdHhZMkhTbEhsNldBamlsek1t?=
 =?utf-8?B?WmR3U2RHTXVXc0dlU3VvWmphSGx3SUplZEtOQnNOOXNKVGRuaG9Gb3B4Y3Rq?=
 =?utf-8?B?QmZqbUkrTHlFRjkySHg0S0llWS9QVFdSaXRMdnVWS1V3bVRPenVHbXBKc2Vs?=
 =?utf-8?B?eVJUK1o5WndIbXQzb2s3a0laUTl2TE0zMnM3eXQ4M2V3ZWNVTjc0NURmMEZj?=
 =?utf-8?B?M0YrUDVYcHJMVHNlNmFQU0x0Rm5FTnNXMFpWTlFyMEpGMnpjUkYxazZWMi9j?=
 =?utf-8?B?R3hWcTlSVWdNbVY2VkZXRWdlSjNnRSs2bndkNEdUMWtWRXliQzZFTC93WnZN?=
 =?utf-8?B?aWtMNkxtRlNGc0ZTOGNkVUxHTU1xNVJmczdwdFNFQTR3b0h4K3U3SWhVS1FB?=
 =?utf-8?B?RlZVTlU3clh6amtoTG4weDBBbDVZWkpuNDRPcy8vZzdnSEVCaTBYeXdhTGdu?=
 =?utf-8?B?SXFZK3ZEdndnWndTWWM1dTE4cmZoRmZtNXQwKzg5ajFrRXNyOTVDcFRFdlB2?=
 =?utf-8?B?QUpXSWRUc1krb1FMNzUxL0pFVFk4Vjc3b2hJQ20rTkpKam1YNW94dEJ2Q00r?=
 =?utf-8?B?Q01CZ3dXTUduSGdWQW9xOFJRUEhzbGxsV0FHVWdYZGtiWGF2TkxmRjIvYk45?=
 =?utf-8?B?NlVwSjZKWTZ4dGxsZEFyMjJlYjJqd3YyekprdktRanp3b1lhdko5TGdPNUZy?=
 =?utf-8?B?cFBYTk5yLzlPSzUzUTRDU0ZvWENyZklidkc4MnJySmRPOU9WemZUZnJBYlMw?=
 =?utf-8?B?OE5LaUZvdWxOYTRGQkZiaXlLSW56MEwvS095Q3lXSVVGc2I5Zkxkc2JKK2tI?=
 =?utf-8?B?WkNYNGZFTklCd2htRXlFUnR0K2xYK25hSm5OSks0WEJsTGhNQkxPN1ZlNWc5?=
 =?utf-8?B?bmdZaDZ3ZGtiYUZFcFJUZzdrUmpmRithQnlZSWRQeHJtUUVaOTBMcjlEa1dn?=
 =?utf-8?B?SDlaMjc0M2hkRjRVempnQkZVbnQ1aTRtdnlhRGdSZ0VjRWQ3eEdDSzRKY0gx?=
 =?utf-8?B?SzllbjdCRC9TYzNFZS9zQ0xLR0IvVytCQUpQMVdyVkNVbnhuTE9NK1FjMEhm?=
 =?utf-8?B?RENhemRXcTh0eFcxZ3RlSDM3R2xjODJ5dHprQ0djd2tIRzNMVDRVL2R0Zmk1?=
 =?utf-8?Q?pNIkqSUITa3aT5EnFXJCFfyPbpt3aRedTR/tanM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzFlZVkyTlZIa2twakJ5eVRHck4xMW0rS2t0TWdPb25iUyswV0pTR1pYYUli?=
 =?utf-8?B?SHVQeTFCRVVWdjdJeWMwa01hNFRkWjNBZDBnV0EvcUdzdjdmdGhGYWZqekIz?=
 =?utf-8?B?S0MyQmo1bVlxUmd0aEZGTVd4TUNHRHR6RlhFbG13cGphWGpJWmNReTI4a2pO?=
 =?utf-8?B?bGtpbkJuekZhU0ZEcVZlU2srMFdTQUZRcE8wOHhMWHZSQU5OWlRhYk1JOWdH?=
 =?utf-8?B?dVdwQzgzUDF4QnJCQWY0YXZncFMwczlqbXZaZFBhTERNbklyN1p5V3R5a1J2?=
 =?utf-8?B?Q1VYcm81RDlZQ2F3ckZXSjRFZG43Rjg2ejFMUzU5Ukk4a1EvUXRnUHVSMU5i?=
 =?utf-8?B?SHh1MmRUUHR1L2VlbG5tSFBsdEp6cmo2LzFPS2NUTGswWEN4d2duaDZaUUo0?=
 =?utf-8?B?bG1BSUQ3UUJDY2paN0szUFRabno2aHo1b1kwaCsyYXIyV1UxK1pzTDNVZzRS?=
 =?utf-8?B?TmpIZFo5bkczQUhBR0pxWndyMTlHNVQ5OGZHM0N3S3pDNUVUMVRtRXdMVHBK?=
 =?utf-8?B?K0p5SnJkbzhNOEd5Y1I3eXFuRVQwRnRhVkMva2hKNFdadmxpcVhxOU5nZkhC?=
 =?utf-8?B?L0hBZXNySjluclB5b3hzREJoWWdqVmZSb3BrN1puMHc1SHhLRThVMjcyN0pt?=
 =?utf-8?B?QVZZeE5qK1d2NEVaMWNDOWdOc213UlBNZjgzd3FwWW1YOTJ3QTlpR01Ua1hD?=
 =?utf-8?B?QWd1aHpzckVEaVdmZmltSVFkVmFvdnRRemF6Um9YUUhmeDl1OVZWSlBFa1lF?=
 =?utf-8?B?cmtPU3NNRHkyV21KZ0lSUkJweW1NYTZuV0pyejJaSzZzdzhWVDBzMkMySVpp?=
 =?utf-8?B?VGZkS2lTRjkydW95aWtJNnp5OGFYd0o4RFJnZFpscnhKd093cHA5T1QzZ1kv?=
 =?utf-8?B?dTNqSTJuNWNzcTQrWE1WMmQxRlVPbWNyV1ZGeDZzcmw1Z050TXY1R2w1Y3JZ?=
 =?utf-8?B?SU1NLzFsMkRSbGpyWElkcUdjWDl1SUR3NUlFbldmM29JM2MrQ2VvYVBhNUtE?=
 =?utf-8?B?SEdrbUJ0aTc3Unk5WE52bEpRYWswdi82dUFKSjNuTUxKTTBIY044RjJIck94?=
 =?utf-8?B?TENVZlA1aGpPN1V3c0VjYlY0eWdVRHViSnlVZE5WdlZUa2U3VjNVT3dnakQr?=
 =?utf-8?B?bmVrYWdYZWZHYVA5QkpuWTJ4bnI4SFpSN1lwMDcxUXg3K0VycGxYMHpTejdm?=
 =?utf-8?B?d1pXKzBiSk5MOUwwSTVYOW5Qek9nNU1QOThubFgvU012VDMxcEJuUzM5RXpm?=
 =?utf-8?B?OUpjVXBKd3YzdnFmV0w2RkFlbDRRNTR3VEl3d1RZb1BScDhLbW9HOEx1UGRv?=
 =?utf-8?B?M1FGTXJISXRsbXZwZEJiNUJrb3FIYm5yN1pKTkFYSElzVmxtbVFpa0szNFh3?=
 =?utf-8?B?N0Q0SjNraklRWm5yTHNFNmx4cEt0Sjk2RFJPdU4rRmhIYlpmQ3JOMlJuck9O?=
 =?utf-8?B?Tm9aaWdVTU5qc29KNXJOdXFzWVBzQnRLeUJxTzBWOWYwVTlJNHRQMTVEcnVy?=
 =?utf-8?B?NVc4MVRKenN4dnNEMWNuWW1pa2s0TnRFdzVBMk55NXNXczQzeTkvU0ZzZjQy?=
 =?utf-8?B?WlZoK2cvTmxuYXR6cENjTy9mQ0dOcDFDM2YxYS92cEtYZzBMZTJJSUlKTkMv?=
 =?utf-8?B?ZlRwbWdMcUNBdkNlT0hNRkdzbmMvaS81VlVpcm9Wb2J6NVlNcERPc0Q4T1oz?=
 =?utf-8?B?a3BWWS9wVnB6SkthK0M2V3AwYXk1dFAvQTUrdlZJNG9hQitucm5aREZFK21l?=
 =?utf-8?B?MXlSUjJRNUx3N3AveG5zOTBkQmY2emZDSlZpeUhTUHpNQzZEZldOWjZkZ0Uz?=
 =?utf-8?B?UUlXbVRVSCtkY0UxRjRoYWdTRTcrZEp3dnJrdVNNM2dtcHBpaDk5VXhYMFNC?=
 =?utf-8?B?NHlLOFVuZGdmb2dZcEREZDBFZ2NSbkFsS1lDTlFkQk1HaGlPWTlpNk5sNDJU?=
 =?utf-8?B?VUd5UkVhbHJmTWNMUytBcHRZa3VsWVRuMDZsT3h1N1QwTGhURUN5a3pqYVRo?=
 =?utf-8?B?djQya0tGSDlQZ1RLdDJSc2xUbzZhSW1aV0FaVHdLclkxMHAxbzEyTUJsYnFn?=
 =?utf-8?B?ck0zdzgwWlRNcXNScWFWdUdBaU4yQldrbG5SR29XazNQWmZDazN0WnlEWkcx?=
 =?utf-8?Q?UQnhXv16L8sLf6FM5lhtkVsbR?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb1cf24-fcda-4417-a00c-08dcfff5abb8
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 13:02:59.4534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnXum+XEyzMKY162OYbP8TNPsLQq1jhCiaG6U2KxtWV68cbitCIRRfbaNKuuixHC8umjoHKpsVSO/F2k9bvXFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8447

Hi Jerome:

     Thanks for your suggestion.


On 9/30/2024 8:27 PM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Sun 29 Sep 2024 at 14:10, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>
>> From: Chuan Liu <chuan.liu@amlogic.com>
>>
>> When the clk_disable_unused_subtree() function disables an unused clock,
>> if CLK_OPS_PARENT_ENABLE is configured on the clock,
>> clk_core_prepare_enable() and clk_core_disable_unprepare() are called
>> directly, and these two functions do not determine CLK_IGNORE_UNUSED,
>> This causes the clock to be disabled even if CLK_IGNORE_UNUSED is
>> configured when clk_core_disable_unprepare() is called.
>>
>> Two new functions clk_disable_unprepare_unused() and
>> clk_prepare_enable_unused() are added to resolve the preceding
>> situation. The CLK_IGNORE_UNUSED judgment logic is added to these two
>> functions. To prevent clock configuration CLK_IGNORE_UNUSED from
>> possible failure.
>>
>> Change-Id: I56943e17b86436254f07d9b8cdbc35599328d519
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> ---
>>   drivers/clk/clk.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 65 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index 285ed1ad8a37..5d3316699b57 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -94,6 +94,7 @@ struct clk_core {
>>        struct hlist_node       debug_node;
>>   #endif
>>        struct kref             ref;
>> +     bool                    ignore_enabled;
>>   };
>>
>>   #define CREATE_TRACE_POINTS
>> @@ -1479,6 +1480,68 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
>>        }
>>   }
>>
>> +static void __init clk_disable_unprepare_unused(struct clk_core *core)
>> +{
>> +     unsigned long flags;
>> +
>> +     lockdep_assert_held(&prepare_lock);
>> +
>> +     if (!core)
>> +             return;
>> +
>> +     if ((core->enable_count == 0) && core->ops->disable &&
>> +         !core->ignore_enabled) {
>> +             flags = clk_enable_lock();
> Used core->enable_count without taking the lock

My understanding is that adding a spinlock here is to ensure that
the disabling of the clock can be completed without interference.

>
>> +             core->ops->disable(core->hw);
> If the there is any CLK_IS_CRITICAL in the path, it is game over.
> You've basically disregarded all the other CCF flags which are equally
> important to the ones you are dealing with.

if clock is CLK_IS_CRITICAL then its enable_count > 0 does not go into
the 'if'.

>
>> +             clk_enable_unlock(flags);
>> +     }
>> +
>> +     if ((core->prepare_count == 0) && core->ops->unprepare &&
>> +         !core->ignore_enabled)
>> +             core->ops->unprepare(core->hw);
>> +
>> +     core->ignore_enabled = false;
>> +
>> +     clk_disable_unprepare_unused(core->parent);
> Here you are disabling the parent of any CLK_IGNORE_UNUSED clock.
> IMO, the problem is not solved. It just shifted.

Yes, it does not take into account the situation where its parent is
disabled without configuring CLK_IGNORE_UNUSED.

>
>> +}
>> +
>> +static int __init clk_prepare_enable_unused(struct clk_core *core)
>> +{
>> +     int ret = 0;
>> +     unsigned long flags;
>> +
>> +     lockdep_assert_held(&prepare_lock);
>> +
>> +     if (!core)
>> +             return 0;
>> +
>> +     ret = clk_prepare_enable_unused(core->parent);
>> +     if (ret)
>> +             return ret;
> That's adding another recursion in CCF, something Stephen would like to remove

This patch is meant to throw out an idea and bring attention to the
problem that was discovered.

>> +
>> +     if ((core->flags & CLK_IGNORE_UNUSED) && clk_core_is_enabled(core))
>> +             core->ignore_enabled = true;
>> +
>> +     if ((core->prepare_count == 0) && core->ops->prepare) {
>> +             ret = core->ops->prepare(core->hw);
>> +             if (ret)
>> +                     goto disable_unprepare;
>> +     }
>> +
>> +     if ((core->enable_count == 0) && core->ops->enable) {
>> +             flags = clk_enable_lock();
>> +             ret = core->ops->enable(core->hw);
>> +             clk_enable_unlock(flags);
>> +             if (ret)
>> +                     goto disable_unprepare;
>> +     }
>> +
>> +     return 0;
>> +disable_unprepare:
>> +     clk_disable_unprepare_unused(core->parent);
>> +     return ret;
>> +}
>> +
>>   static void __init clk_disable_unused_subtree(struct clk_core *core)
>>   {
>>        struct clk_core *child;
>> @@ -1490,7 +1553,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
>>                clk_disable_unused_subtree(child);
>>
>>        if (core->flags & CLK_OPS_PARENT_ENABLE)
>> -             clk_core_prepare_enable(core->parent);
>> +             clk_prepare_enable_unused(core->parent);
>>
>>        flags = clk_enable_lock();
>>
>> @@ -1517,7 +1580,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
>>   unlock_out:
>>        clk_enable_unlock(flags);
>>        if (core->flags & CLK_OPS_PARENT_ENABLE)
>> -             clk_core_disable_unprepare(core->parent);
>> +             clk_disable_unprepare_unused(core->parent);
>>   }
>>
>>   static bool clk_ignore_unused __initdata;
> --
> Jerome

