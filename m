Return-Path: <linux-kernel+bounces-321924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A2D972139
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188CC1F2593E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4178418A95F;
	Mon,  9 Sep 2024 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="MSGNL6PH"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2119.outbound.protection.outlook.com [40.107.92.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18F118A949
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903515; cv=fail; b=kXSI9mx5ZepP0Gj4LKVTcvD01761Itk92WhfJjQjm9w5c6dVGmOnIAAYEovkc7NXoxCBAAoL96BDQCqsdSdEgGWI/PXrQwK9WX2C86G8LBdsmEcZGFDJ4c7VXnH6eRrx/oqBQ0Kc9H+apSDqyIv2B2dcb6N1jMflGdeNjBTJwEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903515; c=relaxed/simple;
	bh=IOzx6jWfi34yBu4XgyX1S2EJqYsZfokPyo4V0nqzs8w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WCCfdHPZw54aEBalH93P+H+Rprn2dgJoIlGx/BtfTD5KZLQtwpw7idO8ECUp21olSJl0XzC90m6CLar1v1eSpCzpIRzUi2TvJrvI/RGECXPyG8YrQw91KJ5eGnv/1/NHKd0sRhMsCjdRS3+Jc2HYUZX9InUG0r58BAnQDrMbpeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=MSGNL6PH; arc=fail smtp.client-ip=40.107.92.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbHiRGkstoihayFY/yvHYvMQgydO2enrQIM+io6XhK1DkxI95Z0i71stYeJb7KLI3JAWJxUoKHWCDgS80S6Xrfxv2Jeh8++x8m9nhSiM44BP+opdnnrHgPxeYxeVa5lT7Ho232vWIeZGNkIWv6IhFojHrsHABQwXdAcESdPhX/+cjMmsDoVmy/jD6lJfHcfXAduawvnevYzGvC0iDmJxpNmo33mBMn1Yi8W5e1oDUBHMatNNJAClbBPPqBTgfVyW2VmvkUno6UJGvxANyaH0AWrQaEbwGdaSkZwsh5o2BvkJ1MNLijvvrdWi7EK3e9Y0/p+HTxvA9qJ6P4Wrdb/2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xgb1vbXP+XFXxWgX6LV0WvAdbsFCH5ES0Zn2K6i0js=;
 b=as25vcCBZ/e9oNgH4yNbkAwso6IXAkq4wb7/V/87luOXHrcVz/aWJCODMAJ0HEG/14U/u7/C+rqlJWjixiJ8QRaTjiGRgLSt67GIQJW+b0W4SH7DTVhTgcKawgnpeBLka9VyBjCbm15x08z7rekeVXRVRbxWTF85B2uOgmRTGDECo9CbY3kBkLsi4S7a8yP+lXx2wwp1ra1ab6VFt2t02OpDg7dYYCuQo8kQzQT7svsfsmloW+LZGd9PBR8oX2jbpk+X2WQkiofpAOQUDaewQrftv19T2HemjZoz58AZFcXSUauSl+L5EPotFIQloWVpNGrbd9rskS6aqxL68/D8cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xgb1vbXP+XFXxWgX6LV0WvAdbsFCH5ES0Zn2K6i0js=;
 b=MSGNL6PHg4hn5FfJZ2lU7H/8fEhgXFpa4dY4NaNNJTlKWXk+HD7bFQQfB2kGjO6W0/3AWTCdtEKbr11RW59UjwhkVOFQV0UtL4wtDlhkkKc9WUqDQs4A005ZselDssd70iV8CjNHjchTfYNP4twVA0Wfspc2DYnxcOCjSVcW8OU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CH5PR01MB9077.prod.exchangelabs.com (2603:10b6:610:215::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Mon, 9 Sep 2024 17:38:28 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 17:38:28 +0000
Message-ID: <75a173a1-1253-45c3-b89e-e4cf3ba25879@os.amperecomputing.com>
Date: Mon, 9 Sep 2024 10:38:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 PATCH 1/2] hugetlb: arm64: add mte support
To: David Hildenbrand <david@redhat.com>, catalin.marinas@arm.com,
 will@kernel.org, muchun.song@linux.dev, akpm@linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240906175945.3636193-1-yang@os.amperecomputing.com>
 <dfd118c5-a3d3-42d2-a25c-43e668247879@redhat.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <dfd118c5-a3d3-42d2-a25c-43e668247879@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::29) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CH5PR01MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 8808547f-1fd9-4c69-940c-08dcd0f636f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHN1SGY2YnAxVU43d2pGSmJkaVRPWlNVOVB5ZUp3WlRmSzNMYnRNRE42cGt0?=
 =?utf-8?B?OWFVSVJGTnpLTnFpNEFXc09uanYvQXRhd1RxK2dXVGVsc3NwcDZyQVdERm9t?=
 =?utf-8?B?eDMzeitWWDZJOFl4WVQ0Z2hjbkpRak95RXo5UkJxMlBkT1pWQWg0WTBydUo4?=
 =?utf-8?B?N3VxRS9wQ21QZWlIWlN6aWZ5ZEl0eHRWSVE4UWhnMmZnbjFwaGhKdndBRC9a?=
 =?utf-8?B?bW80eGQybGZQYWl6M1pmUHJNVS9pbWJ0YUI2R0IyYzRvTGJob2Z0QnU2ejFZ?=
 =?utf-8?B?d3FwTjZkWmxMUjl3V1h4eXpyaFVUaTBCN0h1Risxa29DNk1HNmVjc1ZSeVJu?=
 =?utf-8?B?N3hGSTFkN1p3Mnp2RkoyandvNElEV1EwMFBuaXdEZGRvNXRUOFlkcGxjaUoy?=
 =?utf-8?B?eFNWSzdEUE9iZnc4REVHTjM3eE9teDkvTVJUbGxwdnduaW9wMG9EVEx4d2hz?=
 =?utf-8?B?TUtwY0Z5VUhFa3NON3Q3aWNIR2RMa2JEM3pFTTlCemZKYnBXR3UvN01KaWlo?=
 =?utf-8?B?S0Y1aDZQVzNHNzFxVXJ5VzVORThXcGNoZXdUQXVZS0tLMzZPd1BuOUpCQlo1?=
 =?utf-8?B?enZ2Z3lhQ0o4V2hLLzBDV3FENjhxb1lyS1JOeDBsQlVsN0t1Wm11UnJ1RUJG?=
 =?utf-8?B?OTdybHBWWjhyRmVLQXVMeVgxV1FrM3IxMVZkRDlqeXlxQXNtcUc1ZjVuN3hx?=
 =?utf-8?B?dkpzSXhhUzQ4S3VJNnI4SDkwMHFJU29jVmdmMitBZElYNER4KzVKZ1lLRW41?=
 =?utf-8?B?cnBLNWU1OE5iWTEvWHUyZzdYZzhSVE16SHJnZFVMeEtMdmx0Ymdkd1o3dnor?=
 =?utf-8?B?a3lVdG9jUkJDdmluV3JhZ3JHK2xPVk9EbWJPczA2QlpWOXlTVmhhK0dyNlpm?=
 =?utf-8?B?a1NFUGtCZTBDQzk5UFZpckRreTRSdk9LU25UbUZLc0pYOE82aVV6QnNwcGhh?=
 =?utf-8?B?dGVsaUZNZVczY0poUHpudU8xSk94dmJqd0hFSzJ5MTl1Z0F1NHJCaWw5Mndm?=
 =?utf-8?B?RGlGWU4yQkd5bzhxeENlQjErRG0vek1PbDZZT2ttei9MWWR6RDU2Q25GSHRj?=
 =?utf-8?B?clF1Qzk2d2I0elp6UmtUT1ltdzFJNmRUNjUrcEN3cDAxQVFnVGdsMkUzUXBw?=
 =?utf-8?B?c2RvSDNaZFZEWUhVUXQwL3ltRm5za0tOWE13VTdUd2tUbnQ0RW44enhPQXZr?=
 =?utf-8?B?ekk4RDdRMEhBQS84eGdzVElZbDhOMEVSSXZncHBPZVloTklMM0lkMzJ3OWVo?=
 =?utf-8?B?TkpLZmhhNHovd2MxcmtBYjFyWTFQallEckxqbTZIWkFHUG1lRStTYnJJWVNT?=
 =?utf-8?B?UGk0TWw5VDgvcmFRK25yNE1OYW12UUJvTDVSZTJ1Z0ZBT2xFZi9Ha0RzeFFh?=
 =?utf-8?B?Y3phTjNFYkc0bVdadVdCYitjMGJUY3ViQ2J4alBZb1FIdmFJd3BiVnRqSHo5?=
 =?utf-8?B?YmtJRW0vQStxcFBRT1k2MUMxL2pEMWVGTzlWeXo1L3hQMkpxNU80QkV6R080?=
 =?utf-8?B?QlQ5MWlSZjFtdUd0eTd6MlJHOGZwb29rY09GUTRSOE94bWIzUWg2ZFhJRzg3?=
 =?utf-8?B?RHpzbVZvYlhqUlhoQjJHQ0E0TlQ4dnhmcXFLaGs2aGFzek5yOWV2amg2SkpS?=
 =?utf-8?B?UElsNmU3Q0N6WTlTMjJIQUxPbjMrNFI2SzBWakdBZC9jOGZINGd1NkRBSmp3?=
 =?utf-8?B?SHV0eXEzV1FSVUkvTStkV3laR3NraG9vMWF5aUVUUzYwMXphZ1BMK1p0R01L?=
 =?utf-8?B?TWQ0TXgveksydUV1a3BpOVdBN2thcXYyRjB6MVU0bXh6Q0tsaTRidDRZSU9I?=
 =?utf-8?B?TlJhb010OGFRK1QxdFlmdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0lsSzYzNVU0TzRhZ1R1SVJHS0xidExRODZqT3pjWVZtVHluV2Vhc1NYRktS?=
 =?utf-8?B?bDZvclR3NGtnZzF3ZFN2VDBBYmRSRGl2ZWY1WE5meEpvNjlKT2RuS2hlMXgr?=
 =?utf-8?B?bERIOUJTL21XLzB3Zi8rYzFtOWdibGtrZFZLUjNROE1mb3daRkFFV2xaS3ph?=
 =?utf-8?B?ZVNiVzh0SEZJeDhZUktHVzRBUmpNYnR5QldNaTkrcmRLck9nazZFdStpVlhw?=
 =?utf-8?B?UHJtY3JSNkRGV3JGR2U2VkxtR1dqY21OYkZzQTl6amVzRjRhcEcxK2dFWUth?=
 =?utf-8?B?S2RyUENScEpUcWZNM2FVUWYzcW9QNUVVVUFnbVlWdEdpS0ZOQm5mQ3VWanZJ?=
 =?utf-8?B?aVZFTWZLTjNWL1psMEFENStzdFpTUGhlK2c3VW5YZGl4TFBsVmIzY2Z0NjM5?=
 =?utf-8?B?Zy85ZUMwUkt4YkJTOEtlWjdDc0ZqeGdXZm5QUjR3WCtOVExSRndDaHcvNkVR?=
 =?utf-8?B?WksxODRRazlzak44WWR4cXdHcG8yOHRNWGVLT3ZwZlNqMHdMNkV4WWgzTnU5?=
 =?utf-8?B?TCsvVDQya0cxUU84UzNDWG93ZFJyQTIxRE9SNndFU1Z1SUkvQjRySWhuTXVY?=
 =?utf-8?B?MFZwNE1RM3Y1ZE9LbUhxMHlUOUJXbDJBMFhHSDUyMVBSdjExRU13M3BhdnIz?=
 =?utf-8?B?dkJLb2FwMWYydTVXbmxIcEJsVWgramFRWVlmOXlzRnVkZ3hRa1R4b2RNTUNQ?=
 =?utf-8?B?THlZNG5hYnZWbDU1VDNGMTYzM2E1NHY5bE5xc3RQNXM5Y3JsUXVLMy9JRXpV?=
 =?utf-8?B?RUVsNjVwbXNHb2Y4TVlHTmdPUnk0dktaYWl6WEMvci83Ri9BZ1JWYi9YNGUw?=
 =?utf-8?B?NTFiU05OeHlTaWNpMjdoS05haUNZeDdGejJUZjkyYk1yY2x2WjA5OTM0Yjhr?=
 =?utf-8?B?L2l4bVdMbU1pTFlsN0NRRklRUnA5Q1dGWTlhT2wvRjV6Q1hEdWIySVBrWUlK?=
 =?utf-8?B?S3d2cXNyZ1BpOWJkWmJQZDlGRE1xQzRYN25oVWJnMitNRFRObWJ6OXZEZDgx?=
 =?utf-8?B?MVZ4VU42dWFDa2ptMGN5cDhBMk9va1FBTjgrRXdOUEJyNkNXMVRjY1c2eFh0?=
 =?utf-8?B?c0xiSG90SzFzVFRUWWJiMUFBL0F0VU1iOWU3OE5QTnlRaGg4M21YamRMWHhJ?=
 =?utf-8?B?aUh0YWl2YXdNMnVGYy95bDkzMFRmazZkd25USG5DZWhKdTk5RS9wb3JmKzJ4?=
 =?utf-8?B?L0pXdXI3cG5SbWw3a0RXWmJKWml1dzFxMmdmTER5Zm9QQjZydXUxc1lINysx?=
 =?utf-8?B?c21EOGduaFZQSUlGUnFnQjhic0luVUNhdTdRenpyNy8wUmxPZmZoRytTdUFT?=
 =?utf-8?B?QWFaV2p4Rjlxa1ZjalNsY0U1dmgveEI4U0NPMytGVjFCZkNFN05aZnZSWHd2?=
 =?utf-8?B?K0pnQTJxNDBsYS8rTk9FSlJoSDdNVnVpQmRtdGdCZkRULzduTU5obHFqUDRs?=
 =?utf-8?B?SG9zUk84cFNCRkV5eFVLeG1OQkdISExHVkxOU3BzYW9FdGgvSTU4b281cnFk?=
 =?utf-8?B?SDVCM0xTMTMxaFNlb254K1NzNlNyYmwzaFc0K1Q3dHRkMUZCbVZaSE1TVGwx?=
 =?utf-8?B?MFdtbUdnUjVLQmpWNHF6SWJ0ZzBrUDBVRGFPVGs2cW9NdFhVbmtac2NUeVV3?=
 =?utf-8?B?ZFduS3liT053UzRDQzV2SFlwb2p2a1hGeXNUZ0lUV3pJb2ZjUkZUWk04NWJk?=
 =?utf-8?B?K2xHdE1JUGtBT2JxUENGMzFzUUFmSUxIL3VZRzN3N2dzSXlVZFhVVXQ0QzZG?=
 =?utf-8?B?NFBLYXJxTU1HWCtIRW9GUlJDYzJSeTdpV09CaXZoMU9wOS85ZC9ZdDZabHFa?=
 =?utf-8?B?YjFWbTRVSEJ0aTFabWxndjJzMDFuYmVoemRGRkRnelg3Mm8xMlA1TVBNbXg3?=
 =?utf-8?B?ekRaWFQ4dFg0dzlWY0hNZ3BJMU45dlVhQnBNcHNhbWdtR1RXMmN1M2cxaWZJ?=
 =?utf-8?B?S3lpd3NyQXBZNmVmeXhRRFhQV01Pa1FKOUl3d3RvVUtlNWRaVHpmdGdkVlAz?=
 =?utf-8?B?cHdWUGprMFlwYlRaMXhEU1h2WjBNWGFxOHRHb1FFQmlTZHdzbVQ2TVVhV1Qy?=
 =?utf-8?B?aW16YXFDYUhCNXMxaVRTNmdJSTVnWmFaNVJhR0FVa3J2NTNqM3p6KzIzQTFK?=
 =?utf-8?B?cEVUeFFTWHNPN3BwUmxCWGZwcDA2TlR3dWpGc0p5L2U2SUZOZkRIQkZoSlVK?=
 =?utf-8?Q?rrHaft1J4TMNPOUJtf0shGU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8808547f-1fd9-4c69-940c-08dcd0f636f9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 17:38:28.4446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oF6TMQqEV3HkEKs2zxBMi2w34ZfnfyhmYlYz+DeRr/2K6DnIEB3sJkEQil6HiTpGXi2k98r9OaPkDM5enqoK2VqsBgak4oPs5aCdOMRTdyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB9077



On 9/9/24 1:43 AM, David Hildenbrand wrote:
> On 06.09.24 19:59, Yang Shi wrote:
>> Enable MTE support for hugetlb.
>>
>> The MTE page flags will be set on the folio only.  When copying
>> hugetlb folio (for example, CoW), the tags for all subpages will be 
>> copied
>> when copying the first subpage.
>>
>> When freeing hugetlb folio, the MTE flags will be cleared.
>>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/include/asm/hugetlb.h | 15 ++++++-
>>   arch/arm64/include/asm/mman.h    |  3 +-
>>   arch/arm64/include/asm/mte.h     | 67 ++++++++++++++++++++++++++++++++
>>   arch/arm64/kernel/hibernate.c    |  7 ++++
>>   arch/arm64/kernel/mte.c          | 25 +++++++++++-
>>   arch/arm64/kvm/guest.c           | 16 ++++++--
>>   arch/arm64/kvm/mmu.c             | 11 ++++++
>>   arch/arm64/mm/copypage.c         | 33 +++++++++++++---
>>   fs/hugetlbfs/inode.c             |  2 +-
>>   9 files changed, 166 insertions(+), 13 deletions(-)
>>
>> v3: * Fixed the build error when !CONFIG_ARM64_MTE.
>>      * Incorporated the comment from David to have hugetlb folio
>>        specific APIs for manipulating the page flags.
>>      * Don't assume the first page is the head page since huge page copy
>>        can start from any subpage.
>> v2: * Reimplemented the patch to fix the comments from Catalin.
>>      * Added test cases (patch #2) per Catalin.
>>
>> diff --git a/arch/arm64/include/asm/hugetlb.h 
>> b/arch/arm64/include/asm/hugetlb.h
>> index 293f880865e8..06f621c5cece 100644
>> --- a/arch/arm64/include/asm/hugetlb.h
>> +++ b/arch/arm64/include/asm/hugetlb.h
>> @@ -11,6 +11,7 @@
>>   #define __ASM_HUGETLB_H
>>     #include <asm/cacheflush.h>
>> +#include <asm/mte.h>
>>   #include <asm/page.h>
>>     #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
>> @@ -18,9 +19,21 @@
>>   extern bool arch_hugetlb_migration_supported(struct hstate *h);
>>   #endif
>>   +#ifdef CONFIG_ARM64_MTE
>> +#define CLEAR_FLAGS (BIT(PG_dcache_clean) | BIT(PG_mte_tagged) | \
>> +             BIT(PG_mte_lock))
>> +#else
>> +#define CLEAR_FLAGS BIT(PG_dcache_clean)
>> +#endif
>> +
>>   static inline void arch_clear_hugetlb_flags(struct folio *folio)
>>   {
>> -    clear_bit(PG_dcache_clean, &folio->flags);
>> +    if (!system_supports_mte()) {
>> +        clear_bit(PG_dcache_clean, &folio->flags);
>> +        return;
>> +    }
>> +
>> +    folio->flags &= ~CLEAR_FLAGS;
>
> In contrast to clear_bit, this is now not an atomic operation anymore. 
> Could we have concurrent modifications (locking the folio? mte?) where 
> we could mess up (IOW, is there a reason we don't do __clear_bit in 
> existing code)?

AFAICT, I don't see there is any concurrent modification to them. 
arch_clear_hugetlb_flags() is called when:
   * hugetlb folio is freed
   * new hugetlb folio is enqueued (not available for allocation yet)

And is is protected by hugetlb_lock, all hugetlb folio allocation is 
serialized by the same lock. PG_mte_* flags can't be set before hugetlb 
folio is allocated. So I don't think atomic operation is actually 
necessary. Not sure if I miss something or not.

But all arches use clear_bit(). As you suggested below, it may be safer 
start with clear_bit().

>
> Maybe start with:
>
> static inline void arch_clear_hugetlb_flags(struct folio *folio)
> {
>     clear_bit(PG_dcache_clean, &folio->flags);
> #ifdef CONFIG_ARM64_MTE
>     if (system_supports_mte()) {
>         clear_bit(PG_mte_tagged, &folio->flags);
>         clear_bit(PG_mte_lock, &folio->flags);
>     }
> #endif
> }
>
> And if you can argue that atomics are not required, convert all to 
> __clear_bit() and have the compiler optimize it for you.
>
>>   }
>>   #define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
>>   > diff --git a/arch/arm64/include/asm/mte.h 
>> b/arch/arm64/include/asm/mte.h
>> index 0f84518632b4..cec9fb6fec3b 100644
>> --- a/arch/arm64/include/asm/mte.h
>> +++ b/arch/arm64/include/asm/mte.h
>> @@ -41,6 +41,8 @@ void mte_free_tag_storage(char *storage);
>>     static inline void set_page_mte_tagged(struct page *page)
>>   {
>> +    VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
>> +
>>       /*
>>        * Ensure that the tags written prior to this function are visible
>>        * before the page flags update.
>> @@ -51,6 +53,8 @@ static inline void set_page_mte_tagged(struct page 
>> *page)
>>     static inline bool page_mte_tagged(struct page *page)
>>   {
>> +    VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
>> +
>>       bool ret = test_bit(PG_mte_tagged, &page->flags);
>>         /*
>> @@ -76,6 +80,8 @@ static inline bool page_mte_tagged(struct page *page)
>>    */
>>   static inline bool try_page_mte_tagging(struct page *page)
>>   {
>> +    VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
>> +
>>       if (!test_and_set_bit(PG_mte_lock, &page->flags))
>>           return true;
>
> [...]
>
>> +static inline void set_folio_hugetlb_mte_tagged(struct folio *folio)
>> +{
>> +}
>> +
>> +static inline bool folio_hugetlb_mte_tagged(struct folio *folio)
>> +{
>> +    return false;
>> +}
>> +
>> +static inline bool try_folio_hugetlb_mte_tagging(struct folio *folio)
>> +{
>> +    return false;
>> +}
>
> I would suggest to stick to the format of our folio_test / folio_set 
> ... functions. Please refer to 
> folio_set_hugetlb_migratable/folio_set_hugetlb_hwpoison/ ...
>
> Something like:
>
> folio_test_hugetlb_mte_tagged
> folio_set_hugetlb_mte_tagged

I don't have strong opinion on these two. They are straightforward 
enough and the users can easily map them to the page_* variants.

>
> But the semantics of try_folio_hugetlb_mte_tagging() are a bit less 
> obvious. I would suggest
>
> folio_test_and_set_hugetlb_mte_lock()

This one is a little bit hard to map to try_page_mte_tagging() TBH.

>
>
> We should probably clean up the page_* variants separately.

Probably. The most confusing one is actually try_page_mte_tagging(). We 
should probably change it to test_and_set_page_mte_lock(). But anyway 
they are just used by arm64, so I don't worry too much and I'd like to 
hear from arm64 maintainers.

>
> But ARM maintainers can feel free to intervene here.
>
>> +#endif
>> +
>>   static inline void mte_disable_tco_entry(struct task_struct *task)
>>   {
>>       if (!system_supports_mte())
>> diff --git a/arch/arm64/kernel/hibernate.c 
>> b/arch/arm64/kernel/hibernate.c
>> index 02870beb271e..ebf81fffa79d 100644
>> --- a/arch/arm64/kernel/hibernate.c
>> +++ b/arch/arm64/kernel/hibernate.c
>> @@ -266,10 +266,17 @@ static int swsusp_mte_save_tags(void)
>>           max_zone_pfn = zone_end_pfn(zone);
>>           for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
>>               struct page *page = pfn_to_online_page(pfn);
>> +            struct folio *folio;
>>                 if (!page)
>>                   continue;
>
> Nit: I would drop this empty line.

OK

>
>> +            folio = page_folio(page);
>> +
>> +            if (folio_test_hugetlb(folio) &&
>> +                !folio_hugetlb_mte_tagged(folio))
>> +                continue;
>> +
>>               if (!page_mte_tagged(page))
>>                   continue;
>>   diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
>> index 6174671be7c1..c8b13bf36fc6 100644
>> --- a/arch/arm64/kernel/mte.c
>> +++ b/arch/arm64/kernel/mte.c
>> @@ -38,7 +38,22 @@ EXPORT_SYMBOL_GPL(mte_async_or_asymm_mode);
>>   void mte_sync_tags(pte_t pte, unsigned int nr_pages)
>>   {
>>       struct page *page = pte_page(pte);
>> -    unsigned int i;
>> +    struct folio *folio = page_folio(page);
>> +    unsigned long i;
>> +
>> +    if (folio_test_hugetlb(folio)) {
>> +        unsigned long nr = folio_nr_pages(folio);
>
> Nit: empty line please.

OK

>
>> +        /* Hugetlb MTE flags are set for head page only */
>> +        if (try_folio_hugetlb_mte_tagging(folio)) {
>> +            for (i = 0; i < nr; i++, page++)
>> +                mte_clear_page_tags(page_address(page));
>> +            set_folio_hugetlb_mte_tagged(folio);
>> +        }
>> +
>> +        smp_wmb();
>
> We already do have one in set_folio_hugetlb_mte_tagged() [and 
> try_folio_hugetlb_mte_tagging() does some magic as well], do we really 
> need this smp_wmb()?
>
> In general, I think checkpatch will tell you to document memory 
> barriers and their counterparts thoroughly.

It is not used to guarantee the PG_mte_tagged flag is visible, it is 
used to guarantee the tags are visible before PTE is set. The 
non-hugetlb path has:

         /* ensure the tags are visible before the PTE is set */
         smp_wmb();

I should keep the comment for hugetlb path as well.

>
>> +
>> +        return;
>> +    }
>
>
>
>


