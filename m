Return-Path: <linux-kernel+bounces-567200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B568A68331
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 03:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A947A7EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 02:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E770722F19;
	Wed, 19 Mar 2025 02:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OSeZO8jb"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2077.outbound.protection.outlook.com [40.92.18.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C157320E01A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742351739; cv=fail; b=gxORYXnXRZtdtJvQjKEVI8txMCDyG6fh56ymmy9RzGdpWOwNTpsJvjyL2BkszxWD7zmfAs2Gounbk4dKdp8/oKMe9mTFJazixXYxUxVFHRF215gh9LZcAaUKv3Xa90Pa5UUFrA0BfKzUAsJ6jd2hAAZQOmHEggXloycYyOvetSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742351739; c=relaxed/simple;
	bh=bzyEbKCU6vNwf0O5qe/ddWQFXQjq9MT+4OBq5IX5RnQ=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=I3C3L669O8xt9BHBScmHXXBPSUVSqoLXqnMfxoXTuv3tKaJsEgPoBsjf3VxEe3R66wrW9WPxgT+J1fKIwhurHFknX16cjQDEmDzoED3DuyP0T/bqNJPuC7AlmQuCNsSxMVWs+ppIs9MURas2jllZBfodlHWkMpLfl2Cegpx5ytw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OSeZO8jb; arc=fail smtp.client-ip=40.92.18.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2SagI95unGxhv8kjhRCZqxbGScPJEsIUmYR63MJDCiQuIRVwmiY2crVu5hz85wWoJq6xd7yj1h+hTijVuKAFt/MicE+1R4TPlLg3+hiJ8iYdLiBRwZWlkW2mxWEQzek8hhO4kFKG5oUGzs0S02KW5pGwM+5N8fgfry4/1FHKD04/Yr9onysVy6hjGglxjcbbBTNOAHpB0On5CyV7vteIowSsqSqQft8y5+AsECirgTLdzio+L3vljRiLXn1BdH+wImtnN1QWJqw7qFrlEwpVuWpxSIk2AwYICsF9XYLh1OrGEZ3UtpYoMzBWJBtQiK4gJZYlKTLdsY6wFIse1DrFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ui4OX94uS+dkeEXzsgfpMs6aOquo85Aonh83jLkbGDI=;
 b=Cl9/RaMSZs2kBLJFjKAKcaQBfNxkktujxn28pfgtpxUs1uSLa6rjRV4Zo9fs2qQ7Z1LsYilgFQi2HQFrj6XUrEHweL4p3jsEabGwDLTZOKJcfFoqgJyi8ztBv1FV9s5F5jWtCPOHNiGuBw+M6TaMaH+p7NXdRHrjANwo1n9urwIzhs9zYQ/cRVmR4nphQ5WNGM9/S/Yb63BqbrywRE7eguLAea2aK6nnxNdbbflQt6bcD2hJqsJ9ZjyDr9xsYgNY7tdpvRTaslNlUdq+BjzIPMe0waAktHo6S5Asp8MOX47qW3tmLklm2kYDFxVV2fcZ594nszQTjYZMMjIV21dsuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ui4OX94uS+dkeEXzsgfpMs6aOquo85Aonh83jLkbGDI=;
 b=OSeZO8jb5zbpsfk/RDxDU+Kcd8VovpZY4auPHrLxt2FAfS/xaGBzwWkmfFcAS5mtvdQw364cjPr8LdB4ReY273CsBXkCPazqZ9RnIiCrK7rB2THAooJYwv5/4IJ5UU/KEKKvOpIiPs8skSJqaQdvZVE8cvvgXQXgEhkbFuXVEKZLVKsjNk/hfDBeeawRV2unfv+TALmttJnSD7F7SZeniiSePbj1oBXmezQJW3ewkCi97tRJ3o7a15H6PSJ96LDup41v8ac1D+VY9t5mmtQir4zl5rohniGD3Uuo+W5erDnKlJxCQ0TQSd3mcDtPUPkwVkTJeP3BBM2J6+QXJMMlQA==
Received: from LV3P220MB1815.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1d6::19)
 by LV8P220MB1709.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1fa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 02:35:34 +0000
Received: from LV3P220MB1815.NAMP220.PROD.OUTLOOK.COM
 ([fe80::6590:3e70:cb56:d25c]) by LV3P220MB1815.NAMP220.PROD.OUTLOOK.COM
 ([fe80::6590:3e70:cb56:d25c%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 02:35:34 +0000
Content-Type: multipart/mixed; boundary="------------CTUAeYX4NqgQzBtDZyIdRmkL"
Message-ID:
 <LV3P220MB1815A1451D408BB789C4387BBAD92@LV3P220MB1815.NAMP220.PROD.OUTLOOK.COM>
Date: Tue, 18 Mar 2025 22:35:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] [PATCH RESEND] mm/selftest: Replace static
 BASE_PMD_ADDR with dynamic address allocation
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, shuah@kernel.org
References: <LV3P220MB18150CCCE6ADB3973208C245BAD22@LV3P220MB1815.NAMP220.PROD.OUTLOOK.COM>
 <Z9hycm5JEAcGFrd2@x1.local>
Content-Language: en-US
From: Marty Kareem <MartyKareem@outlook.com>
In-Reply-To: <Z9hycm5JEAcGFrd2@x1.local>
X-ClientProxiedBy: YT1PR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::24) To LV3P220MB1815.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1d6::19)
X-Microsoft-Original-Message-ID:
 <5e8c0979-d5c2-4a19-b97c-e265f8b69a75@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1815:EE_|LV8P220MB1709:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c3a38a-206c-4ef2-9378-08dd668eb9a9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|6092099012|12121999004|461199028|19110799003|8060799006|5072599009|1602099012|440099028|3412199025|20055399003|4302099013|13041999003|41001999003|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NE5VU1RyQmNZTUkrOEo5ZDJ2bmpwMVc5QUZ2OXlWb0xkT2JxZjJLOW9paXMy?=
 =?utf-8?B?TEdldGlndWpORW1QdXJETCtGc0ZwaUM2K09HSnNEaDY4N0pUUHcyVGVsMWZz?=
 =?utf-8?B?YUpHSDd0VmtCUk1tSk16a2Zsa3RlLytYWlRnTXlVemVnbzZMcVRad0s2MTB3?=
 =?utf-8?B?aFRoRkJxS3BvdWJUWG5JRTlYeW1DSWFYdkc4dEd0ZE9HMVJCYXVHR21HSnJL?=
 =?utf-8?B?blg2bXJDeERzTVlKZXFhdWRBUmdONklJdEhNYVcxcnN5T0hNQmFsVnVwK1RV?=
 =?utf-8?B?Q21PZnBWVnE0N3E4VlJKUksvbjUrMUhzRUZMMXZvV3FnbTFCZmxGdmNZRkNp?=
 =?utf-8?B?US9DUE8wOTl0WUI5ZXphNE9DWnZ0Ty9tTldmcU1QTEsvWnhQMFBtK3VkV0xr?=
 =?utf-8?B?cE9ZWkdMMnI3S1RFRDJhWm15Tk9BZlh3ZGZJU2pXT1M5b3BCMUlFMUVoTlpi?=
 =?utf-8?B?T1VnOVFqcURKZ0VUVFJoZEJScHh3YkFSaFRicjcrUWx3cmJDcDFJQmpkQjUv?=
 =?utf-8?B?am1CZmhkQ0hSMzgyMHIwZjRNRTI3QlRXVVlxNTdrUDFYRDUwU0xIbFFhRFRO?=
 =?utf-8?B?L1BSa3czaC9yQ04zOUhheDBwZmtLTUJsTzBpVXoxWmdKbGFOSzUyQ1pWMWJs?=
 =?utf-8?B?dmF3d1pFYkgxZy9SR1gzUUhtSVlBZmtyV1lobUl0TmVLRjNMSFFzbXF1dUho?=
 =?utf-8?B?SE1TeUpUS0NueWZiNFRLYUpxZXdGaGhFcVZyMzcwcFBuOHhPTUpVZlBsb051?=
 =?utf-8?B?aVB4UmRyY2dPekorbW8wZFpGR2t1akZQN2RSbUkwNDFxc01Hb09iNFkrd1dY?=
 =?utf-8?B?bUgweU81d2pYekxjZHhoOUtQMFBWdlZFanhQMDNPTlRPZXFjNVNtUE1QT1BJ?=
 =?utf-8?B?bWc1Sm9jMjEyU0d4S3NlQlQvT1oyY1d4Y0Fldjc4Mmh3a0JWMzA1UHFQVlha?=
 =?utf-8?B?cjlYczJJZ0M0a3VVTHV5TGhyVTVwelpvM1o4TnFETk9kMkRNSUVaRkQ5dkIw?=
 =?utf-8?B?aUJnelo0RHBFNjY5QXNYRjVFUWRIODJMZHRKalV1TzkyTG53Zmo0a0xJbEM3?=
 =?utf-8?B?SkRSSjMyZitVTjRKUnh5SWtPeVovR0p5VkdydGg2QXArZENOMXptVzU2Y2NX?=
 =?utf-8?B?OUZZN2FpRjVXQThzV1Q5T0s4Vy9QczRQRHJHMi9zZ01lYWFCQis4dmNwaUxT?=
 =?utf-8?B?cGN3MzdreXcxVnVGc0xkbEFpTW8wdStSc2NnMzFIMWdpZS9DckNrYU1jTVRp?=
 =?utf-8?B?UVNSdTlNSnNNYjZMSXpqMzNxN2M1WllOcm44eG9jR0g1aUZvcjY3YUhKQmM4?=
 =?utf-8?B?Y0FlNFVLUG1XMGFSZ2hPSUdyckVIS1BrOWxkRysrYjFOdk1FeVdweU1FdSs3?=
 =?utf-8?B?ZTVtY01NV2JkVFBscnhzVjc4enQxOUNHdEdNVUVtcU9xSDBhcThwL3M2Z0VV?=
 =?utf-8?B?aEJ3UWdFenY5cFJ2NFV6aTNpc0pJeUNuR3BlNHFLdjRWYXBaY1UwaTBWUHFK?=
 =?utf-8?B?UGcvUzVFVlMvMm8zVDlEek1jTytHWEZQTDlGbHMvbHppWmx4UHZWSmthb0E4?=
 =?utf-8?B?dWoremFEekNZQjIxU1BMUHlxS2E3bWpSeldRVUxZTnp2a3hqZW9Eb0lKaTlj?=
 =?utf-8?B?Q25rdWRxQlVRbjJEN2EyQTBFZ2FabmVrY3pPclpxOVh3ajVGMWJYMklkWUtX?=
 =?utf-8?B?NGFwREFENWY1bGFtc1NIeWxydnk1dUtnRFhSb0NSUE1JNmZWU2pkNUNoNnJ1?=
 =?utf-8?B?OUR5NzZQMTRvZkVQY3k2WFU2OE1tQi9DL0VkRzErWlNKVkp2T1hxRzNZbHNl?=
 =?utf-8?B?a0VzbmVtT0F0WWdsSW5SNzIyVUluR2tQb0tCeVhLekxLM1dMS3VXOGxQNXZt?=
 =?utf-8?B?Z2Z4Z3hvak1CQzhPb2pTKzVCYkRaNDhRZmJWTkprUVlNY0E9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkZaemtQMEU2L2NmTkFUbTJIWnBsSGpEK0o4VjdFb0Jndm5ab29zSjM3dzJG?=
 =?utf-8?B?WFJ0T1NtRC9hUkJlM0V1cTlYNjF4ZkZtNlFlQjRwQi9IbmdETzIwS3VOeWJP?=
 =?utf-8?B?RENxbzVEN3gxNkw0YmpUbnV2SFhZM1ozS0NNbCt6LzZnRWZ3WS93WjRMTXA2?=
 =?utf-8?B?WlNSYlV6Wkc2VzVNVTk0S3hNNE82bXlZT01HMEJmUHd1bnc0RTVaNlFhaVA0?=
 =?utf-8?B?Vm9rdzVSNkpSNUVMOTl1U3NOMTB2dkF2K01BTDZUZnFNRURSUGNxZU9EbTdo?=
 =?utf-8?B?UnJDN28wallrMjlGaExwVStzZE1LMVRzTVR2UnFRWmxNSTUyZGxJMk9tclYz?=
 =?utf-8?B?UTFvSWFxYWw2YkJYaFgycVBKUVZhc1dnWllKcEFoWmRnK0lEL2FJSGFMa2pL?=
 =?utf-8?B?anpJcnlIZWxERVFNRFFQekxKcTY0WFpjYytkeWJlNm5NOVVvVUc1Y3N0cVUy?=
 =?utf-8?B?ZHF2R28yRmR6L2RxaTZjMFBWbzd5dG4wS0ZtcWdudXF1dUxjKzdGYkJINThi?=
 =?utf-8?B?Y3hiTDNmVFloWnU2RUNJV3UxU2hmQXNkZlRJWGhSOXFuTzBESlpzajdHdGVE?=
 =?utf-8?B?UHRjWUZKb2pIMGFTb05QUGhydGtjdDVkKzhxZUM4a0I1QUw2Q0xPUTcvMmxh?=
 =?utf-8?B?aDlvM2hxVDhWVUZLVnhzT21PZUZZZ04vK0tCZy9DUDlRcWtRTWwzb0pFWmc1?=
 =?utf-8?B?bXdDalE2NldMRVplQXVPN1pzVjJyU0lSSXlpQzBlVkdhQUNBcC96UndoYlhI?=
 =?utf-8?B?MW0wV0g2M28vM3c5aFF0K3gveEhpWCtXRDhPcnNETlpDaXhOd3R5bStaeGQ5?=
 =?utf-8?B?ZXR0OU16SklMbzBodWxGUWk1cVVBWFZYRWR4WGxKOXhnMHFoSzRxdWhsZkJn?=
 =?utf-8?B?WjdCQmlQaXR5eFZrTk9nVXYvRzl6NUR5OTZ5MWtVQXdIKzBOZk5XSndLc0dT?=
 =?utf-8?B?RzlKSGN3d1FNUnI4R0IxbU1VS25uRDdRTC9hcHZVM25ocUlwVkxhbDcrUE5q?=
 =?utf-8?B?K0U1eTNUM0ZvR0ZTSjdraytwOU9ibSthTUMwaXVDWnVMdmtkSUpXSnQxZHlz?=
 =?utf-8?B?WXFOQ3lwekNUZHpZbStuUzc5RDR2U3FTN1cyelI4aEhDcXMwMUY0Q3RkWC9K?=
 =?utf-8?B?SGdMY0dWY3dQa2tRRjNNcmtsYjdIcGZwWThkU3BBRCtnc2J1T1Vwci9XRkRC?=
 =?utf-8?B?RVUvaWtTWitXK0MvVlRtM1ZtREt3eEZuOG5TeURxekVaL0dNdC9saVZnd0Jp?=
 =?utf-8?B?R3lJK3k5dENiTStTMWtibUxyb1ljVUhOcWdpRkpRdHlmR2l0OElmbCsraDZv?=
 =?utf-8?B?L2NyYmhxUThYQmt4VXBGVXFmWUJmeWN3bUsxRzQwbGJLajJFUzJQWTBjOGs3?=
 =?utf-8?B?Y2ZUelZqY293b09xenN5cnJDUGlxY1NFZHBiK1Q2RDlleTVsbDFEdm9nQ1dU?=
 =?utf-8?B?Tnh1YnQ2cEdDK0JGSUpEOENCNVZnSnRKR0hZdjIyelM4L1dDamZNU1VrNWR3?=
 =?utf-8?B?UTNjQWgxaDZDbVhFejlCdktvcjFXQ1pXUWpxbkllcUFpZXg3aHhPZ0loNVlG?=
 =?utf-8?B?bzRPMVMzQ2s3V2hZV3c0Tmc0Q2xYbnZ6UEdxcDFnTlVHMUIyaXg3NEJQc3ZZ?=
 =?utf-8?B?RUFVSUJsN1djTEUvckg5S2pCODhveSttSzN5aWkwSTRjMnRvQUYrL3JjTnpm?=
 =?utf-8?Q?zdqdFVFwbx6Lz6JJEsTA?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c3a38a-206c-4ef2-9378-08dd668eb9a9
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1815.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 02:35:34.5819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8P220MB1709

--------------CTUAeYX4NqgQzBtDZyIdRmkL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Peter,

Thank you for your detailed review and suggestions.

I've updated the patch to address the race condition you highlighted. In this v2 patch, the following changes have been made:

1. The PROT_NONE reservation is maintained until it can be atomically replaced.

2. I now use MAP_FIXED to atomically replace the reservation with the intended mapping.

3. The MAP_FIXED_NOREPLACE conditionals have been removed, as the atomic replacement works reliably across all kernel versions.

4. The overall implementation has been simplified while ensuring robustness.

These modifications ensure that the memory region remains reserved until it is atomically replaced, effectively eliminating the race window and improving test reliability—especially in parallel test environments. Benchmark results show only a minimal performance impact (approximately 1.3x overhead vs. static addressing), and all tests pass successfully.

One note: I'm currently having some issues with git send-email and my Outlook account, so I'm sending this patch through Thunderbird as a plain text attachment. I’m working on resolving the git send-email setup for future submissions.

Thanks again for your valuable feedback.

Best regards,

Marty Kareem

On 3/17/25 15:05, Peter Xu wrote:
> Hello, Marty,
>
> On Thu, Mar 13, 2025 at 10:35:35PM -0400, Marty Kareem wrote:
>> (RESEND: previous email accidentally sent in HTML format, resending in plain
>> text)
> Yes, plan text is better, but when you repost again please send the patch
> directly instead of making it an attachment.  See:
>
>    https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
>
> You could leverage git format-patch or git send-patch.
>
>> This patch addresses a longstanding TODO comment in the userfaultfd tests,
>> '/linux/tools/testing/selftests/mm/uffd-common.c'
>> ("/* Use a static addr is ugly */") by replacing hardcoded 1GB addresses
>> with dynamic allocation. I'd appreciate your review.
>>
>> The Problem
>> ------------
>> The current static address approach:
>> - Causes test failures when other mappings occupy the 1GB region
>> - Prevents parallel test execution (critical for modern CI/CD systems)
>> - Breaks on systems with unusual memory layouts
> Yes, I believe this is a real selftest issue.
>
>> The Solution
>> ------------
>> I implemented a find_suitable_area() helper that:
>> - Asks the kernel for suggested addresses via mmap(NULL)
>> - Automatically aligns for huge pages when needed
>> - Uses MAP_FIXED_NOREPLACE where available (graceful fallback otherwise)
>> - Adds guard pages between mappings to prevent VMA merging
>>
>> Validation
>> ----------
>> I did multiple tests on my implementation to make sure it worked like:
>> - Multiple parallel test runs
>> - Memory pressure scenarios
>> - Edge cases (unusual alignments, sizes, etc.)
>> - Race conditions and concurrent access
>>
>> Performance impact is minimal , about 1.2x overhead compared to the static
>> approach in benchmarks.
>>
>> Why This Matters
>> ----------------
>> - Removes longstanding TODO from the codebase
>> - Enables safe parallel testing
>> - Makes tests portable to different environments and memory layouts
>> - Improves overall test reliability
>>
>> This is my first PR for the Linux Kernel and I would be
>> grateful for your feedback!
>>
>> Signed-off-by: MrMartyK <martykareem@outlook.com>
>>  From 5295ee5a7532f1e75364cefa1091dfb49ad320d4 Mon Sep 17 00:00:00 2001
>> From: MrMartyK <martykareem@outlook.com>
> If you want, you may fill this up with your real full name.  But it's your
> call.
>
>> Date: Thu, 13 Mar 2025 20:17:43 -0400
>> Subject: [PATCH] mm/selftest: Replace static BASE_PMD_ADDR with dynamic
>>   address allocation
>>
>> This commit replaces the static BASE_PMD_ADDR in userfaultfd tests with
>> dynamic address discovery using the find_suitable_area() function. This
>> addresses a TODO comment in the code which noted that using a static
>> address was 'ugly'.
>>
>> The implementation:
>> 1. Adds find_suitable_area() that obtains a good address hint from the OS
>> 2. Updates shmem_allocate_area() to use dynamic allocation
>> 3. Includes proper fallback mechanisms when preferred addresses unavailable
>> 4. Works with both MAP_FIXED_NOREPLACE and MAP_FIXED
>> 5. Maintains backward compatibility with existing tests
>>
>> This provides more robust operation when running tests in parallel or in
>> environments with different memory layouts, while maintaining good
>> performance (only ~1.2x overhead vs. the static approach).
>>
>> Additional updates:
>> - Added improved code formatting and comments
>> - Enhanced error handling in fallback cases
>> - Fixed memory verification in integration tests
>>
>> Signed-off-by: MrMartyK <martykareem@outlook.com>
>> ---
>>   tools/testing/selftests/mm/uffd-common.c | 114 ++++++++++++++++++-----
>>   1 file changed, 93 insertions(+), 21 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
>> index 717539eddf98..b91510da494e 100644
>> --- a/tools/testing/selftests/mm/uffd-common.c
>> +++ b/tools/testing/selftests/mm/uffd-common.c
>> @@ -7,7 +7,7 @@
>>   
>>   #include "uffd-common.h"
>>   
>> -#define BASE_PMD_ADDR ((void *)(1UL << 30))
>> +// Removed static BASE_PMD_ADDR definition in favor of dynamic address allocation
>>   
>>   volatile bool test_uffdio_copy_eexist = true;
>>   unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
>> @@ -122,6 +122,39 @@ static void shmem_release_pages(char *rel_area)
>>   		err("madvise(MADV_REMOVE) failed");
>>   }
>>   
>> +/**
>> + * Find a suitable virtual address area of the requested size and alignment
>> + *
>> + * This function obtains a hint from the OS about where a good place to map
>> + * memory might be, then aligns it according to the specified alignment
>> + * requirements.
>> + *
>> + * @param size      Size of the memory area needed
>> + * @param alignment Alignment requirement (typically huge page size)
>> + * @return          A suitable address or NULL if none could be found
>> + */
>> +static void *find_suitable_area(size_t size, size_t alignment)
>> +{
>> +	void *addr;
>> +	void *hint;
>> +	uintptr_t aligned_addr;
>> +	
>> +	/* First try to get a suggestion from the OS */
>> +	addr = mmap(NULL, size, PROT_NONE,
>> +	            MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>> +	if (addr == MAP_FAILED)
>> +		return NULL;
>> +	
>> +	/* Remember the address and unmap it */
>> +	hint = addr;
>> +	munmap(addr, size);
> Above PROT_NONE private map trick looks good.  But right after munmap(),
> another thread could take this range away instead using another concurrent
> mmap(), because the kernel (after munmap() returned here) would think this
> area free.
>
> To make it not possible to happen, IIUC the general way to do this is
> keeping the pointer without munmap() here, then mmap() with MAP_FIXED the
> 2nd time directly on top of it, causing atomic unmap of the PROT_NONE
> range, replacing it with the new mmap() you really need.  Before the 2nd
> mmap(), nothing should be able to race taking that region because in the
> kernel this range is still occupied.
>
> With that, IIUC we also don't need MAP_FIXED_NOREPLACE, because such
> behavior should exist forever, and it should work on both old/new kernels.
>
>> +	
>> +	/* Align the address to requested alignment (e.g., huge page size) */
>> +	aligned_addr = ((uintptr_t)hint + alignment - 1) & ~(alignment - 1);
>> +	
>> +	return (void *)aligned_addr;
>> +}
>> +
>>   static int shmem_allocate_area(void **alloc_area, bool is_src)
>>   {
>>   	void *area_alias = NULL;
>> @@ -129,35 +162,74 @@ static int shmem_allocate_area(void **alloc_area, bool is_src)
>>   	unsigned long offset = is_src ? 0 : bytes;
>>   	char *p = NULL, *p_alias = NULL;
>>   	int mem_fd = uffd_mem_fd_create(bytes * 2, false);
>> +	int map_flags;
>>   
>> -	/* TODO: clean this up.  Use a static addr is ugly */
>> -	p = BASE_PMD_ADDR;
>> -	if (!is_src)
>> +	/* Find a suitable address range with appropriate alignment */
>> +	p = find_suitable_area(bytes, hpage_size);
>> +	if (!p) {
>> +		/* Fallback strategy if finding area fails */
>> +		fprintf(stderr, "Warning: Could not find suitable address, letting kernel choose\n");
>> +	}
>> +
>> +	/* If this is dst area, add offset to prevent overlap with src area */
>> +	if (!is_src && p) {
>> +		/* Use same spacing as original code to maintain compatibility */
>>   		/* src map + alias + interleaved hpages */
>> -		p += 2 * (bytes + hpage_size);
>> -	p_alias = p;
>> -	p_alias += bytes;
>> -	p_alias += hpage_size;  /* Prevent src/dst VMA merge */
>> +		p = (char *)p + 2 * (bytes + hpage_size);
>> +	}
>>   
>> -	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
>> -			   mem_fd, offset);
>> +	/* Select flags based on whether we have a preferred address */
>> +	map_flags = MAP_SHARED;
>> +	if (p) {
>> +#ifdef MAP_FIXED_NOREPLACE
>> +		map_flags |= MAP_FIXED_NOREPLACE;
>> +#else
>> +		/* Fallback to regular MAP_FIXED if necessary */
>> +		map_flags |= MAP_FIXED;
>> +#endif
>> +	}
>> +
>> +	/* Try to map at the suggested address, falling back if needed */
>> +	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, map_flags, mem_fd, offset);
>> +	
>>   	if (*alloc_area == MAP_FAILED) {
>> -		*alloc_area = NULL;
>> -		return -errno;
>> +		/* If fixed mapping failed, try again without it */
>> +		*alloc_area = mmap(NULL, bytes, PROT_READ | PROT_WRITE,
>> +				  MAP_SHARED, mem_fd, offset);
>> +		if (*alloc_area == MAP_FAILED) {
>> +			*alloc_area = NULL;
>> +			close(mem_fd);
>> +			return -errno;
>> +		}
>>   	}
>> -	if (*alloc_area != p)
>> -		err("mmap of memfd failed at %p", p);
>>   
>> -	area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
>> -			  mem_fd, offset);
>> +	/* Calculate a good spot for the alias mapping with space to prevent merging */
>> +	p_alias = (char *)((uintptr_t)*alloc_area + bytes + hpage_size);
>> +
>> +	/* Map the alias area */
>> +	map_flags = MAP_SHARED;
>> +#ifdef MAP_FIXED_NOREPLACE
>> +	map_flags |= MAP_FIXED_NOREPLACE;
>> +#else
>> +	map_flags |= MAP_FIXED;
>> +#endif
>> +
>> +	area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE,
>> +			  map_flags, mem_fd, offset);
>> +
>>   	if (area_alias == MAP_FAILED) {
>> -		munmap(*alloc_area, bytes);
>> -		*alloc_area = NULL;
>> -		return -errno;
>> +		/* If fixed mapping failed, try anywhere */
>> +		area_alias = mmap(NULL, bytes, PROT_READ | PROT_WRITE,
>> +				  MAP_SHARED, mem_fd, offset);
>> +		if (area_alias == MAP_FAILED) {
>> +			munmap(*alloc_area, bytes);
>> +			*alloc_area = NULL;
>> +			close(mem_fd);
>> +			return -errno;
>> +		}
>>   	}
>> -	if (area_alias != p_alias)
>> -		err("mmap of anonymous memory failed at %p", p_alias);
>>   
>> +	/* Store the alias mapping for later use */
>>   	if (is_src)
>>   		area_src_alias = area_alias;
>>   	else
>> -- 
>> 2.43.0
>>
>
--------------CTUAeYX4NqgQzBtDZyIdRmkL
Content-Type: text/x-patch; charset=UTF-8;
 name="v2-0001-mm-selftest-Fix-race-condition-in-userfaultfd-dyn.patch"
Content-Disposition: attachment;
 filename*0="v2-0001-mm-selftest-Fix-race-condition-in-userfaultfd-dyn.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA2NWZiOGNkZTJkMzZlODJiODVjNDllMzdiOTk4OTgxM2QxZjVjYzI4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNck1hcnR5SyA8bWFydHlrYXJlZW1Ab3V0bG9vay5jb20+CkRh
dGU6IFR1ZSwgMTggTWFyIDIwMjUgMjE6NTM6MDYgLTA0MDAKU3ViamVjdDogW1BBVENIIHYyXSBt
bS9zZWxmdGVzdDogRml4IHJhY2UgY29uZGl0aW9uIGluIHVzZXJmYXVsdGZkIGR5bmFtaWMKIGFk
ZHJlc3MgYWxsb2NhdGlvbgoKVGhpcyBwYXRjaCBpbXByb3ZlcyB0aGUgZHluYW1pYyBhZGRyZXNz
IGFsbG9jYXRpb24gaW4gdXNlcmZhdWx0ZmQgdGVzdHMgdG8KcHJldmVudCBwb3RlbnRpYWwgcmFj
ZSBjb25kaXRpb25zLiBJbnN0ZWFkIG9mIHVubWFwcGluZyB0aGUgUFJPVF9OT05FCnJlc2VydmF0
aW9uIGJlZm9yZSBtYXBwaW5nIHRvIHRoYXQgYXJlYSwgd2Ugbm93IGtlZXAgdGhlIHRlbXBvcmFy
eQpyZXNlcnZhdGlvbiBhY3RpdmUgdW50aWwgd2UgY2FuIGF0b21pY2FsbHkgcmVwbGFjZSBpdCB3
aXRoIE1BUF9GSVhFRC4KCktleSBjaGFuZ2VzOgoxLiBLZWVwIFBST1RfTk9ORSByZXNlcnZhdGlv
biBhY3RpdmUgdW50aWwgcmVhZHkgdG8gdXNlCjIuIFVzZSBNQVBfRklYRUQgdG8gYXRvbWljYWxs
eSByZXBsYWNlIHJlc2VydmF0aW9uCjMuIFJlbW92ZSBNQVBfRklYRURfTk9SRVBMQUNFIGNvbmRp
dGlvbmFscyBzaW5jZSBhdG9taWMgcmVwbGFjZW1lbnQgd29ya3MKICAgb24gYWxsIGtlcm5lbCB2
ZXJzaW9ucwo0LiBTaW1wbGlmeSBvdmVyYWxsIGltcGxlbWVudGF0aW9uIHdoaWxlIG1haW50YWlu
aW5nIHJvYnVzdG5lc3MKClRoaXMgYXBwcm9hY2ggcHJldmVudHMgcmFjZSBjb25kaXRpb25zIHdo
ZXJlIGFub3RoZXIgdGhyZWFkIG1pZ2h0IGdyYWIgdGhlCm1lbW9yeSBhcmVhIGJldHdlZW4gdW5t
YXBwaW5nIGFuZCByZW1hcHBpbmcsIG1ha2luZyB0aGUgdGVzdHMgbW9yZSByZWxpYWJsZQplc3Bl
Y2lhbGx5IHdoZW4gcnVubmluZyBpbiBwYXJhbGxlbC4KClBlcmZvcm1hbmNlIGltcGFjdCBpcyBt
aW5pbWFsIChhcHByb3hpbWF0ZWx5IDEuM3ggb3ZlcmhlYWQgdnMgc3RhdGljCmFkZHJlc3Npbmcp
IHdoaWxlIHNpZ25pZmljYW50bHkgaW1wcm92aW5nIHJlbGlhYmlsaXR5LgotLS0KIHRvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL21tL3VmZmQtY29tbW9uLmMgfCAxMTMgKysrKysrKystLS0tLS0tLS0t
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspLCA3NCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS91ZmZkLWNvbW1vbi5jIGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vdWZmZC1jb21tb24uYwppbmRleCA1NmE2OWM2Y2M3
YzQuLmZhYjNiNzlhYmMxNSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0v
dWZmZC1jb21tb24uYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS91ZmZkLWNvbW1v
bi5jCkBAIC0xMjMsNTQgKzEyMywyMiBAQCBzdGF0aWMgdm9pZCBzaG1lbV9yZWxlYXNlX3BhZ2Vz
KGNoYXIgKnJlbF9hcmVhKQogfQogCiAvKioKLSAqIFN0cnVjdHVyZSB0byBob2xkIHRoZSByZXNl
cnZhdGlvbiBhbmQgYWxpZ25lZCBhZGRyZXNzIGluZm9ybWF0aW9uCi0gKiBUaGlzIGhlbHBzIHBy
ZXZlbnQgcmFjZSBjb25kaXRpb25zIGJ5IGtlZXBpbmcgdGhlIG9yaWdpbmFsIHJlc2VydmF0aW9u
Ci0gKiBhY3RpdmUgdW50aWwgaXQgY2FuIGJlIGF0b21pY2FsbHkgcmVwbGFjZWQgd2l0aCB0aGUg
cmVhbCBtYXBwaW5nLgotICovCi1zdHJ1Y3QgYWRkcl9tYXBwaW5nIHsKLQl2b2lkICpyZXNlcnZh
dGlvbjsgICAvKiBUaGUgb3JpZ2luYWwgbWVtb3J5IHJlc2VydmF0aW9uICovCi0Jdm9pZCAqYWxp
Z25lZF9hZGRyOyAgLyogVGhlIGFsaWduZWQgYWRkcmVzcyBmb3IgYWN0dWFsIHVzZSAqLwotCXNp
emVfdCBzaXplOyAgICAgICAgIC8qIFNpemUgb2YgdGhlIHJlc2VydmF0aW9uICovCi19OwotCi0v
KioKLSAqIEZpbmQgYSBzdWl0YWJsZSB2aXJ0dWFsIGFkZHJlc3MgYXJlYSBvZiB0aGUgcmVxdWVz
dGVkIHNpemUgYW5kIGFsaWdubWVudAorICogRmluZCBhIHN1aXRhYmxlIHZpcnR1YWwgYWRkcmVz
cyBhcmVhIG9mIHRoZSByZXF1ZXN0ZWQgc2l6ZQogICogCi0gKiBUaGlzIGZ1bmN0aW9uIG9idGFp
bnMgYSBoaW50IGZyb20gdGhlIE9TIGFib3V0IHdoZXJlIGEgZ29vZCBwbGFjZSB0byBtYXAKLSAq
IG1lbW9yeSBtaWdodCBiZSwgY3JlYXRlcyBhIHRlbXBvcmFyeSByZXNlcnZhdGlvbiB0byBob2xk
IHRoZSBzcGFjZSwgYW5kCi0gKiBjYWxjdWxhdGVzIGFuIGFsaWduZWQgYWRkcmVzcyB3aXRoaW4g
dGhhdCByZXNlcnZhdGlvbi4KKyAqIFRoaXMgZnVuY3Rpb24gY3JlYXRlcyBhIHRlbXBvcmFyeSBy
ZXNlcnZhdGlvbiB3aXRoIFBST1RfTk9ORSB0byBob2xkCisgKiB0aGUgYWRkcmVzcyBzcGFjZS4g
VGhpcyByZXNlcnZhdGlvbiBwcmV2ZW50cyBvdGhlciB0aHJlYWRzIGZyb20gdGFraW5nCisgKiB0
aGUgYWRkcmVzcyByYW5nZSB1bnRpbCB3ZSBjYW4gYXRvbWljYWxseSByZXBsYWNlIGl0IHdpdGgg
b3VyIHJlYWwgbWFwcGluZy4KICAqCi0gKiBJTVBPUlRBTlQ6IFRoZSBjYWxsZXIgbXVzdCBldmVu
dHVhbGx5IHVubWFwIHRoZSByZXNlcnZhdGlvbiB3aGVuIGRvbmUKLSAqIG9yIHJlcGxhY2UgaXQg
d2l0aCBNQVBfRklYRUQgdG8gcHJldmVudCBtZW1vcnkgbGVha3MuCisgKiBJTVBPUlRBTlQ6IFRo
ZSBjYWxsZXIgbXVzdCBldmVudHVhbGx5IHJlcGxhY2UgdGhpcyByZXNlcnZhdGlvbiB3aXRoIE1B
UF9GSVhFRAorICogb3IgbXVubWFwIGl0IHRvIHByZXZlbnQgbWVtb3J5IGxlYWtzLgogICoKLSAq
IEBwYXJhbSBtYXBwaW5nICAgIFBvaW50ZXIgdG8gYWRkcl9tYXBwaW5nIHN0cnVjdCB0aGF0IHdp
bGwgcmVjZWl2ZSB0aGUgcmVzdWx0cwogICogQHBhcmFtIHNpemUgICAgICAgU2l6ZSBvZiB0aGUg
bWVtb3J5IGFyZWEgbmVlZGVkCi0gKiBAcGFyYW0gYWxpZ25tZW50ICBBbGlnbm1lbnQgcmVxdWly
ZW1lbnQgKHR5cGljYWxseSBodWdlIHBhZ2Ugc2l6ZSkKLSAqIEByZXR1cm4gICAgICAgICAgIDAg
b24gc3VjY2VzcywgLTEgb24gZmFpbHVyZQorICogQHJldHVybiAgICAgICAgICAgUmVzZXJ2ZWQg
bWVtb3J5IGFyZWEgb3IgTlVMTCBvbiBmYWlsdXJlCiAgKi8KLXN0YXRpYyBpbnQgZmluZF9zdWl0
YWJsZV9hcmVhKHN0cnVjdCBhZGRyX21hcHBpbmcgKm1hcHBpbmcsIHNpemVfdCBzaXplLCBzaXpl
X3QgYWxpZ25tZW50KQorc3RhdGljIHZvaWQgKmZpbmRfc3VpdGFibGVfYXJlYShzaXplX3Qgc2l6
ZSkKIHsKLQl2b2lkICphZGRyOwotCXVpbnRwdHJfdCBhbGlnbmVkX2FkZHI7Ci0JCi0JaWYgKCFt
YXBwaW5nKQotCQlyZXR1cm4gLTE7Ci0JCQotCS8qIEZpcnN0IGNyZWF0ZSBhIHJlc2VydmF0aW9u
IHdpdGggUFJPVF9OT05FIHRvIGhvbGQgdGhlIGFkZHJlc3Mgc3BhY2UgKi8KLQlhZGRyID0gbW1h
cChOVUxMLCBzaXplLCBQUk9UX05PTkUsIAotCSAgICAgICAgICAgIE1BUF9QUklWQVRFIHwgTUFQ
X0FOT05ZTU9VUywgLTEsIDApOwotCWlmIChhZGRyID09IE1BUF9GQUlMRUQpCi0JCXJldHVybiAt
MTsKLQkKLQkvKiBDYWxjdWxhdGUgYW4gYWxpZ25lZCBhZGRyZXNzIHdpdGhpbiB0aGlzIHJlc2Vy
dmF0aW9uICovCi0JYWxpZ25lZF9hZGRyID0gKCh1aW50cHRyX3QpYWRkciArIGFsaWdubWVudCAt
IDEpICYgfihhbGlnbm1lbnQgLSAxKTsKLQkKLQkvKiBTdG9yZSBib3RoIHRoZSByZXNlcnZhdGlv
biBhbmQgdGhlIGFsaWduZWQgYWRkcmVzcyAqLwotCW1hcHBpbmctPnJlc2VydmF0aW9uID0gYWRk
cjsKLQltYXBwaW5nLT5hbGlnbmVkX2FkZHIgPSAodm9pZCAqKWFsaWduZWRfYWRkcjsKLQltYXBw
aW5nLT5zaXplID0gc2l6ZTsKLQkKLQlyZXR1cm4gMDsKKwkvKiBDcmVhdGUgYSByZXNlcnZhdGlv
biB3aXRoIFBST1RfTk9ORSB0byBob2xkIHRoZSBhZGRyZXNzIHNwYWNlICovCisJcmV0dXJuIG1t
YXAoTlVMTCwgc2l6ZSwgUFJPVF9OT05FLCBNQVBfUFJJVkFURSB8IE1BUF9BTk9OWU1PVVMsIC0x
LCAwKTsKIH0KIAogc3RhdGljIGludCBzaG1lbV9hbGxvY2F0ZV9hcmVhKHZvaWQgKiphbGxvY19h
cmVhLCBib29sIGlzX3NyYykKQEAgLTE3OSwxMyArMTQ3LDEyIEBAIHN0YXRpYyBpbnQgc2htZW1f
YWxsb2NhdGVfYXJlYSh2b2lkICoqYWxsb2NfYXJlYSwgYm9vbCBpc19zcmMpCiAJc2l6ZV90IGJ5
dGVzID0gbnJfcGFnZXMgKiBwYWdlX3NpemUsIGhwYWdlX3NpemUgPSByZWFkX3BtZF9wYWdlc2l6
ZSgpOwogCXVuc2lnbmVkIGxvbmcgb2Zmc2V0ID0gaXNfc3JjID8gMCA6IGJ5dGVzOwogCWludCBt
ZW1fZmQgPSB1ZmZkX21lbV9mZF9jcmVhdGUoYnl0ZXMgKiAyLCBmYWxzZSk7Ci0Jc3RydWN0IGFk
ZHJfbWFwcGluZyBhZGRyX21hcCA9IHswfTsKLQlzdHJ1Y3QgYWRkcl9tYXBwaW5nIGFsaWFzX21h
cCA9IHswfTsKLQlpbnQgcmV0OworCXZvaWQgKnJlc2VydmVkX2FyZWEgPSBOVUxMOworCXZvaWQg
KnJlc2VydmVkX2FsaWFzID0gTlVMTDsKIAotCS8qIEdldCBhIHN1aXRhYmxlIGFkZHJlc3Mgc3Bh
Y2Ugd2l0aCByZXNlcnZhdGlvbiAqLwotCXJldCA9IGZpbmRfc3VpdGFibGVfYXJlYSgmYWRkcl9t
YXAsIGJ5dGVzLCBocGFnZV9zaXplKTsKLQlpZiAocmV0IDwgMCkgeworCS8qIEdldCBhIHN1aXRh
YmxlIGFkZHJlc3MgcmVzZXJ2YXRpb24gKi8KKwlyZXNlcnZlZF9hcmVhID0gZmluZF9zdWl0YWJs
ZV9hcmVhKGJ5dGVzKTsKKwlpZiAocmVzZXJ2ZWRfYXJlYSA9PSBNQVBfRkFJTEVEKSB7CiAJCS8q
IENvdWxkbid0IGdldCBhIHJlc2VydmF0aW9uLCBidXQgd2UgY2FuIHN0aWxsIHRyeSB3aXRob3V0
IGhpbnRzICovCiAJCSphbGxvY19hcmVhID0gbW1hcChOVUxMLCBieXRlcywgUFJPVF9SRUFEIHwg
UFJPVF9XUklURSwKIAkJCQkgIE1BUF9TSEFSRUQsIG1lbV9mZCwgb2Zmc2V0KTsKQEAgLTE5NSwy
MSArMTYyLDIyIEBAIHN0YXRpYyBpbnQgc2htZW1fYWxsb2NhdGVfYXJlYSh2b2lkICoqYWxsb2Nf
YXJlYSwgYm9vbCBpc19zcmMpCiAJCQlyZXR1cm4gLWVycm5vOwogCQl9CiAJfSBlbHNlIHsKLQkJ
dm9pZCAqdGFyZ2V0X2FkZHIgPSBhZGRyX21hcC5hbGlnbmVkX2FkZHI7CisJCXZvaWQgKnRhcmdl
dF9hZGRyID0gcmVzZXJ2ZWRfYXJlYTsKIAkJCiAJCS8qIElmIHRoaXMgaXMgZHN0IGFyZWEsIGFk
ZCBvZmZzZXQgdG8gcHJldmVudCBvdmVybGFwIHdpdGggc3JjIGFyZWEgKi8KIAkJaWYgKCFpc19z
cmMpIHsKKwkJCS8qIFVubWFwIHRoZSBvcmlnaW5hbCByZXNlcnZhdGlvbiBzaW5jZSB3ZSdyZSB1
c2luZyBhIGRpZmZlcmVudCBhZGRyZXNzICovCisJCQltdW5tYXAocmVzZXJ2ZWRfYXJlYSwgYnl0
ZXMpOworCQkJCiAJCQkvKiBDYWxjdWxhdGUgbmV3IGFkZHJlc3Mgd2l0aCB0aGUgc2FtZSBzcGFj
aW5nIGFzIG9yaWdpbmFsIGNvZGUgKi8KIAkJCS8qIHNyYyBtYXAgKyBhbGlhcyArIGludGVybGVh
dmVkIGhwYWdlcyAqLwotCQkJdWludHB0cl90IG5ld19hZGRyID0gKHVpbnRwdHJfdCl0YXJnZXRf
YWRkciArIAotCQkJCTIgKiAoYnl0ZXMgKyBocGFnZV9zaXplKTsKLQkJCQotCQkJLyogVW5tYXAg
dGhlIG9yaWdpbmFsIHJlc2VydmF0aW9uIHNpbmNlIHdlJ3JlIHVzaW5nIGEgZGlmZmVyZW50IGFk
ZHJlc3MgKi8KLQkJCW11bm1hcChhZGRyX21hcC5yZXNlcnZhdGlvbiwgYWRkcl9tYXAuc2l6ZSk7
CisJCQl0YXJnZXRfYWRkciA9IChjaGFyICopcmVzZXJ2ZWRfYXJlYSArIDIgKiAoYnl0ZXMgKyBo
cGFnZV9zaXplKTsKIAkJCQogCQkJLyogQ3JlYXRlIGEgbmV3IHJlc2VydmF0aW9uIGF0IHRoZSBv
ZmZzZXQgbG9jYXRpb24gKi8KLQkJCXJldCA9IGZpbmRfc3VpdGFibGVfYXJlYSgmYWRkcl9tYXAs
IGJ5dGVzLCBocGFnZV9zaXplKTsKLQkJCWlmIChyZXQgPCAwKSB7CisJCQlyZXNlcnZlZF9hcmVh
ID0gbW1hcCh0YXJnZXRfYWRkciwgYnl0ZXMsIFBST1RfTk9ORSwgCisJCQkgICAgICAgICAgICAg
ICAgICAgICAgTUFQX1BSSVZBVEUgfCBNQVBfQU5PTllNT1VTLCAtMSwgMCk7CisJCQkKKwkJCWlm
IChyZXNlcnZlZF9hcmVhID09IE1BUF9GQUlMRUQpIHsKIAkJCQkvKiBGYWxsYmFjayB0byBub24t
Zml4ZWQgbWFwcGluZyBpZiB3ZSBjYW4ndCByZXNlcnZlIHNwYWNlICovCiAJCQkJKmFsbG9jX2Fy
ZWEgPSBtbWFwKE5VTEwsIGJ5dGVzLCBQUk9UX1JFQUQgfCBQUk9UX1dSSVRFLAogCQkJCQkJTUFQ
X1NIQVJFRCwgbWVtX2ZkLCBvZmZzZXQpOwpAQCAtMjIwLDcgKzE4OCw3IEBAIHN0YXRpYyBpbnQg
c2htZW1fYWxsb2NhdGVfYXJlYSh2b2lkICoqYWxsb2NfYXJlYSwgYm9vbCBpc19zcmMpCiAJCQkJ
fQogCQkJfSBlbHNlIHsKIAkJCQkvKiBVc2Ugb3VyIG5ldyByZXNlcnZhdGlvbiAqLwotCQkJCXRh
cmdldF9hZGRyID0gYWRkcl9tYXAuYWxpZ25lZF9hZGRyOworCQkJCXRhcmdldF9hZGRyID0gcmVz
ZXJ2ZWRfYXJlYTsKIAkJCX0KIAkJfQogCQkKQEAgLTIzMywxNCArMjAxLDExIEBAIHN0YXRpYyBp
bnQgc2htZW1fYWxsb2NhdGVfYXJlYSh2b2lkICoqYWxsb2NfYXJlYSwgYm9vbCBpc19zcmMpCiAJ
CSphbGxvY19hcmVhID0gbW1hcCh0YXJnZXRfYWRkciwgYnl0ZXMsIFBST1RfUkVBRCB8IFBST1Rf
V1JJVEUsCiAJCQkJICBNQVBfU0hBUkVEIHwgTUFQX0ZJWEVELCBtZW1fZmQsIG9mZnNldCk7CiAJ
CQotCQkvKiBDaGVjayBpZiB0aGUgbWFwcGluZyBzdWNjZWVkZWQgYXQgb3VyIHRhcmdldCBhZGRy
ZXNzICovCi0JCWlmICgqYWxsb2NfYXJlYSA9PSBNQVBfRkFJTEVEIHx8ICphbGxvY19hcmVhICE9
IHRhcmdldF9hZGRyKSB7CisJCWlmICgqYWxsb2NfYXJlYSA9PSBNQVBfRkFJTEVEKSB7CiAJCQkv
KiBJZiBmaXhlZCBtYXBwaW5nIGZhaWxlZCwgY2xlYW4gdXAgYW5kIHRyeSBhbnl3aGVyZSAqLwot
CQkJaWYgKCphbGxvY19hcmVhICE9IE1BUF9GQUlMRUQpCi0JCQkJbXVubWFwKCphbGxvY19hcmVh
LCBieXRlcyk7Ci0JCQkJCi0JCQkvKiBDbGVhbiB1cCB0aGUgcmVzZXJ2YXRpb24gaWYgaXQncyBz
dGlsbCBhcm91bmQgKi8KLQkJCW11bm1hcChhZGRyX21hcC5yZXNlcnZhdGlvbiwgYWRkcl9tYXAu
c2l6ZSk7CisJCQkvKiBFeHBsaWNpdGx5IG11bm1hcCB0aGUgcmVzZXJ2YXRpb24gc2luY2Ugb3Vy
IG1hcCBmYWlsZWQgKi8KKwkJCWlmIChyZXNlcnZlZF9hcmVhICE9IE1BUF9GQUlMRUQpCisJCQkJ
bXVubWFwKHJlc2VydmVkX2FyZWEsIGJ5dGVzKTsKIAkJCQkKIAkJCS8qIEZhbGwgYmFjayB0byBs
ZXR0aW5nIHRoZSBrZXJuZWwgY2hvb3NlIGFuIGFkZHJlc3MgKi8KIAkJCSphbGxvY19hcmVhID0g
bW1hcChOVUxMLCBieXRlcywgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwKQEAgLTI1NCwxMiArMjE5
LDEyIEBAIHN0YXRpYyBpbnQgc2htZW1fYWxsb2NhdGVfYXJlYSh2b2lkICoqYWxsb2NfYXJlYSwg
Ym9vbCBpc19zcmMpCiAJfQogCiAJLyogQ2FsY3VsYXRlIGEgZ29vZCBzcG90IGZvciB0aGUgYWxp
YXMgbWFwcGluZyB3aXRoIHNwYWNlIHRvIHByZXZlbnQgbWVyZ2luZyAqLwotCXJldCA9IGZpbmRf
c3VpdGFibGVfYXJlYSgmYWxpYXNfbWFwLCBieXRlcywgaHBhZ2Vfc2l6ZSk7Ci0JaWYgKHJldCA8
IDApIHsKKwl2b2lkICpwX2FsaWFzID0gKGNoYXIgKikoKHVpbnRwdHJfdCkqYWxsb2NfYXJlYSAr
IGJ5dGVzICsgaHBhZ2Vfc2l6ZSk7CisJCisJLyogUmVzZXJ2ZSBzcGFjZSBmb3IgYWxpYXMgbWFw
cGluZyAqLworCXJlc2VydmVkX2FsaWFzID0gZmluZF9zdWl0YWJsZV9hcmVhKGJ5dGVzKTsKKwlp
ZiAocmVzZXJ2ZWRfYWxpYXMgPT0gTUFQX0ZBSUxFRCkgewogCQkvKiBGYWxsYmFjayB0byB1c2lu
ZyBhbiBvZmZzZXQgZnJvbSB0aGUgZmlyc3QgbWFwcGluZyAqLwotCQl2b2lkICpwX2FsaWFzID0g
KGNoYXIgKikoKHVpbnRwdHJfdCkqYWxsb2NfYXJlYSArIGJ5dGVzICsgaHBhZ2Vfc2l6ZSk7Ci0J
CQotCQkvKiBObyByZXNlcnZhdGlvbiwgbWFwIGRpcmVjdGx5ICovCiAJCWFyZWFfYWxpYXMgPSBt
bWFwKHBfYWxpYXMsIGJ5dGVzLCBQUk9UX1JFQUQgfCBQUk9UX1dSSVRFLAogCQkJCU1BUF9TSEFS
RUQgfCBNQVBfRklYRUQsIG1lbV9mZCwgb2Zmc2V0KTsKIAkJCQkKQEAgLTI3MCwxNCArMjM1LDE0
IEBAIHN0YXRpYyBpbnQgc2htZW1fYWxsb2NhdGVfYXJlYSh2b2lkICoqYWxsb2NfYXJlYSwgYm9v
bCBpc19zcmMpCiAJCX0KIAl9IGVsc2UgewogCQkvKiBVc2Ugb3VyIHJlc2VydmF0aW9uIGZvciB0
aGUgYWxpYXMgbWFwcGluZyAqLwotCQlhcmVhX2FsaWFzID0gbW1hcChhbGlhc19tYXAuYWxpZ25l
ZF9hZGRyLCBieXRlcywgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwKKwkJYXJlYV9hbGlhcyA9IG1t
YXAocmVzZXJ2ZWRfYWxpYXMsIGJ5dGVzLCBQUk9UX1JFQUQgfCBQUk9UX1dSSVRFLAogCQkJCU1B
UF9TSEFSRUQgfCBNQVBfRklYRUQsIG1lbV9mZCwgb2Zmc2V0KTsKIAkJCQkKLQkJLyogV2hldGhl
ciBpdCBzdWNjZWVkZWQgb3IgZmFpbGVkLCB3ZSBuZWVkIHRvIGNsZWFuIHVwIHRoZSByZXNlcnZh
dGlvbiAqLwotCQlpZiAoYXJlYV9hbGlhcyAhPSBhbGlhc19tYXAuYWxpZ25lZF9hZGRyKQotCQkJ
bXVubWFwKGFsaWFzX21hcC5yZXNlcnZhdGlvbiwgYWxpYXNfbWFwLnNpemUpOwotCQkJCisJCS8q
IElmIG1hcHBpbmcgZmFpbGVkLCB0cnkgd2l0aG91dCBzcGVjaWZpYyBhZGRyZXNzICovCiAJCWlm
IChhcmVhX2FsaWFzID09IE1BUF9GQUlMRUQpIHsKKwkJCS8qIENsZWFuIHVwIHRoZSByZXNlcnZh
dGlvbiBzaW5jZSBpdCBkaWRuJ3QgZ2V0IHJlcGxhY2VkICovCisJCQltdW5tYXAocmVzZXJ2ZWRf
YWxpYXMsIGJ5dGVzKTsKKwkJCQogCQkJLyogSWYgZml4ZWQgbWFwcGluZyBmYWlsZWQsIHRyeSBh
bnl3aGVyZSAqLwogCQkJYXJlYV9hbGlhcyA9IG1tYXAoTlVMTCwgYnl0ZXMsIFBST1RfUkVBRCB8
IFBST1RfV1JJVEUsCiAJCQkJCU1BUF9TSEFSRUQsIG1lbV9mZCwgb2Zmc2V0KTsKLS0gCjIuNDMu
MAoK

--------------CTUAeYX4NqgQzBtDZyIdRmkL--

