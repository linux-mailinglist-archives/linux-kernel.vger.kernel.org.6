Return-Path: <linux-kernel+bounces-436087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DDE9E8109
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8751F165BC9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 16:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9661494B2;
	Sat,  7 Dec 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JlLCRiwb"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022088.outbound.protection.outlook.com [40.107.193.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013DE28F5
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733589494; cv=fail; b=is01uD/8knfb4LeNH8SB3UZ9MXzAvVoDJk6lZ1wGNwqTHh3MDzyDVKPcMxrXqPJwpa1rYV2yZfwOULTxmjcm9EiOJ27pK20EOg4B8nihyRt8RmI88m4uOH/t5LbF/A/bIf3yWADo1QKPGSIVANdOGxaAgUm+IhEaoSuEyjMxGzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733589494; c=relaxed/simple;
	bh=zfsDf+HSYcQXoBzII9Qd1FvtttBo+MPWrCfTKlTn3NM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WIsWMI3kK9qxvbPF4Loys+8XvfuBgnNxKS+0qtQqva0GEmZCKDIsf8BbBawihtDzl52ciMt+49NaN/EUw/FWNZjQDio9DuG9v07rQYGDXdHMWfHAKKpSOG4d0apsvnlvBM71ymTT1pnXtOWdSszub7jYFFOb9EbH5iDnLqOYVcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=JlLCRiwb; arc=fail smtp.client-ip=40.107.193.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWT85opdxGOWNKfnHn75UD1sho+v2c4aybSDnP7qSlfBawnd7JfQp/Yk252rXHcoGRMAuM6c1oEmAAx/DOQ8IuoylNIRNhs/jTqIGzPmdTz7/yflMYm6fq46dWT94me0w9q1VyRs6wdy20h8ft+qeXEZcHjPueQJWNPKJhQ8av11v1FcvGVV/i/38sgP9O1YP0GjGXUdaW0ubhC7fn5CaxHCSpu0VbQsHCxQLw2fSc8Lxxr2W/Z/9sFuX8ulHHkGZANkXlcnav/gCcSp35IgZQOXEx79UniKrn/Qbzd93lNrEEKCzyeW0Sp/+K8fhGDBJq4/6RIT8uRWihJ7xZk3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9WYSl3MaJ5ZSPXRqn+UUHfL6r5kUc4qzh5Kw/jPvcw=;
 b=ZsW5TmErnxFvC9m1QuweXsY1buPE6jPnhunMzvoGykaLJ6pmVJV9q86LiAdq+gbjTM7rR3wG5PAS5Ld1h96c1aIy15nvdHJpMA/7dzrXYxJ/lRTahu1rCZiIVw/2Zjx65XxM8jGiciZuJd6dtWiiDKNuNJr3yqRxgpWhatQ7FujDX0vajqFa5nctAVIeuD4rkTV9/Xyyuu3XHwAretIXC+oQXqZUwbnQsKvxUwmGU3HmLFmI+a976YtNYnj93d8fK7eMfmCzs19FZCROznL1LV5toyBRIr/dClMcFNOv74C7X8Vlhj6cPuXXPr9FHpuIXqQNrp5ojblEvqjJplz4aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9WYSl3MaJ5ZSPXRqn+UUHfL6r5kUc4qzh5Kw/jPvcw=;
 b=JlLCRiwbkodCYoEnriH9Ah7r6bmQz9LGD/AWyPlVDnyHE7vBkZNROEkW5QwmN8xGKq3yNetxJ0YssaujeQGxPq7kODRjDdvTV9kZ9oHM49SsmKD4ofFgH99Z3LthB1Zn6xPsg0so+R1I57SGcuA2/P2aI4i00D0m4meGHXc798e8tZWQKOvKjy/LMCR6ku38tyyjT6bCrrKqNTbQeIOuXB91+92i20lO7jVQwgpRtrV26fgIr7v2EVniPrXlyiMfWPOIVHf+oT9SiMSR2205Z5qRmMHtPXzVGMshAyb4x6pkFvCHYsJi0z7ln0t1ycLJaQsd9T5mwkzhrvAro+MGfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB10672.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Sat, 7 Dec
 2024 16:38:10 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8230.010; Sat, 7 Dec 2024
 16:38:10 +0000
Message-ID: <5cfe4e6a-21e8-43ad-99e9-7209ce814d84@efficios.com>
Date: Sat, 7 Dec 2024 11:38:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: use clear_user_(high)page() for arch with special
 user folio handling
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Vlastimil Babka <vbabka@suse.cz>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Alexander Potapenko
 <glider@google.com>, Kees Cook <keescook@chromium.org>,
 Vineet Gupta <vgupta@kernel.org>, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <20241206174246.2799715-1-ziy@nvidia.com>
 <acd263a4-824c-4c8d-a3e2-8b2f391fc775@efficios.com>
 <34C615C1-E1CB-4D8B-81D2-79CE7672930D@nvidia.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <34C615C1-E1CB-4D8B-81D2-79CE7672930D@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0244.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::16) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB10672:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5a18d9-7805-48c6-fca2-08dd16dd893c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFdTa0FiaDc3TE01QmJIZXM0bHBsMEUzdTJSZlVhUG1CeXY2Z3hucTlJOGx3?=
 =?utf-8?B?UmtTVkkwdWJDWkVIdHNZQXNrTlNnc2RwZStKaWtDeUhZZ2NxNlNrQ20wU0do?=
 =?utf-8?B?SWxIT0RheWJYV0JEcndHT2FBQksrTi9IVmRmNkdNd0FNaHB2TXNGUEJlZWd6?=
 =?utf-8?B?ODVXNHpMYW1sVWtvQkFaakZJUGI5N2ZKTGRSWHV2UzV4V1hnYWo5bjJRNWQx?=
 =?utf-8?B?SVVURE5aNnRyZXFNWExJQjROZGFJbG9xVWxvbVQvL01hQjdWTGJ3ckluUnpO?=
 =?utf-8?B?YmRGTk9paDFlb2lRUEhaZDFrWm5TM21FOUVVdkx6cWozMm1OeGpEOGlKM28y?=
 =?utf-8?B?NTlPSlNUMEk4aG5wYXFPczNUTFlndXozWm9xK1FBaElxTTFJTW45VVlVY3pE?=
 =?utf-8?B?ZEZCeE04bjVPMUhWVGRGSVdwTWY2UjBUNVk0RlJ5S2dJYnlXaVRjRWNFNFpv?=
 =?utf-8?B?SjhPcElPUmUrSCtDMzF6QmxDb2pDVjdHZUFLRTZPSGNaQWZIcTFDWGhZTUJR?=
 =?utf-8?B?WE9Qakg5MURDalpKWHcvTzJPTnlJYnE5UHQ2UTZrZXVndXMzYktmNzVtZW8r?=
 =?utf-8?B?Vk5WSWpuVCtNVXZKQ0tUY1lpZDVwaE9YQXA4cWZaUHFsbjJmV1dPb244Q2po?=
 =?utf-8?B?WEtTbnNESjFSWDBKZG54bnQwTXgrT2F6MExIRng2OVR4QVllWTc5KzMrWVpD?=
 =?utf-8?B?U0YzWXVYT2dadWJlRjI5R2RZUXNVbjhOTVZ4N1NQWWFjdEFnSE4vdkpMaFZL?=
 =?utf-8?B?UHY4a0N3UGxKU3VZNmk0bFRsVVNqa3NoYmlJMjcyRkVUOWI1UHFyeTBEc1JD?=
 =?utf-8?B?QnJlNHgvckEyVVBwNUNwY1NXRzdQSWlZY2tSRnkyQzd3Q0ExRmllbVFiQlpW?=
 =?utf-8?B?NEhIVnppZGpCTm41YTRqVFFQN3FST2dnUU1kbDhqSml2cERWc1ppU0o1M2Z2?=
 =?utf-8?B?R0hrczVMcXJORXB3dXVwbnRNVk9lSFUrRGdFekRGTlpoYVlDUFZMaWQ0ajFO?=
 =?utf-8?B?bnNhSENoSTBTUHU3d2wrV1pOaU1uQ2t0UXhsNTRVYUdCcUYySDBiOUcvZEh2?=
 =?utf-8?B?NzR2aUJVcE5QZ2hYMDJwbmd6d2t4Zzk0eG1TQWc2UFQ4QVcwYTlmY1JZK0ZV?=
 =?utf-8?B?eXM4MU0zZ292dkVzWGVxV2V4bUFadjE3WTlNanF1aFpDVWd0VlIwMXZiMmJT?=
 =?utf-8?B?YUVJc0R4dnBDTXM0ZzdaK2VUU0MrcCtGWXpGOVdLSFZTY2JvdFVZdVlMTFpq?=
 =?utf-8?B?Njloa28vcGJUUW9LaWs1M3JzMFhpSGNtakplM2ZWSUZkSi84eko2a0lJRnB1?=
 =?utf-8?B?aTNyd2IxbUF2ZEVTYUlOc1YxWENPVDA5ZjVDZ29ZamlQVTZNZldQeEdTdWdI?=
 =?utf-8?B?QndxMldwdGtoOVBxRG9nd2UrSTd3TTl0U3VmOGw4REpsUkx6Tk9QcUlSQWhw?=
 =?utf-8?B?L3BaTnJ6YTlHeXc2eHk0TjBrTFZpOTNZU0h5YzFNaGVjQTNjOCtJcWVtVGEv?=
 =?utf-8?B?MWMxSERPS2pYMFFMbko2VmFuR0hUcy8xVXI0RkFyUVpKZjIwcS9RaFFBaGhs?=
 =?utf-8?B?aytZUkpqUVBYREk1SnoxNzdhVml1MFZqNnpmYUNzMU1sUHFHajUxVVA4bW81?=
 =?utf-8?B?bmRWSFZ5eDEyVmVZSUUrSVdNRTNxN0t4UkdrRmZtMU1yT3owYVk4THVDN3Y0?=
 =?utf-8?B?cm5rYUNhNTY5V0FkWWYwV0lRaWRBc2NaaXFSbTI5Y0x0OGplc3RmTHVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmxhZFptSUhHNWRoOTRNMzJDbmpQZXkxbTJaamNPTlU2Mkd4K2tyZGxCTzRU?=
 =?utf-8?B?bHpHY2VZalB1RDJtR2szNGVxOEc1QURndXpROVZMcUVRQmVGanhSclJFMGNX?=
 =?utf-8?B?cHd2anFsVW9VMS9rMDc2NzdkQllTOVdyMHlTK3ZqVHhiakpPUlBSRVpBdGlm?=
 =?utf-8?B?UUVqUkxqT09YMTJTdVArM25kV3dObjZHaUdaK3cvelJ1eU54M244UXhobm1u?=
 =?utf-8?B?MjAyTFlBMk1RK1lNTEx4MWJUVzF4eFRLZEYxNkZLVzJzU21FVWhjZC92Ymtv?=
 =?utf-8?B?d0xCTmFuNEZWTXFqUXFOR0dWUWZpWUtkTnJZekd1TWhPbXg2elBLMnN6U2k4?=
 =?utf-8?B?a2RKcEg5MldyTnlNaC9vdUN4ODVBUGU3VDduM3RTZnRYUXRkTHI1RXJGdU41?=
 =?utf-8?B?NG1rdXFmQllPRkh3bUV1cjdPWGJ3eUxGYThCM0NLNVRJY3dXSG1Rdnd5Zmow?=
 =?utf-8?B?OXNWL29PRGs0VWtvcFZSY2NvRm5FeTIrQzQ5R21JTXR2OVcvakpKRGdpRVRE?=
 =?utf-8?B?ZVpxZFJuVWNyRnd6b1A1dEJMbXJ2bjYvM0RsMTBEVmVKTUJ4eWVsbldiSU4x?=
 =?utf-8?B?Zlc1Sk5GelFzZ0Y5MnlnSzhjMUhCOHNLcHNkb1h5YkJaY0JMQkdDYi9nNklP?=
 =?utf-8?B?QUlubE05UHJsU0RxNGFzVHJ0emdRTHFEQmU1OHlhaHJUeGtQU1hhNHpKVGtM?=
 =?utf-8?B?ZXFlRVlwd3pzeG1iT1c5bG51Q1AzQ0VlM01EWXJGSURMUnhoWnMzd2hWM052?=
 =?utf-8?B?RGZ6aGJpWkdhbDZLczJjekg2Z3k3VWJVL2JkQ3phL1N2UTZsK3R3ZldobjZP?=
 =?utf-8?B?M2o3clRTTVdZNVdORHl5VGJHN1V5blEwV3ZRNUs4bm40Y2lkTXpqL3kzZzhs?=
 =?utf-8?B?bTFvczJkckdXK1FMM0I4ZTRNT2ZKSkN4SFdUWjRWTGpKS3JqNHZNYS9Qa2U2?=
 =?utf-8?B?ZmExbHJEbktuN0w5RmNOL2h6SWExRC95cllOZk5mWU5IMWp1RGVQWGJ0WjU4?=
 =?utf-8?B?RmFsL2x2WHFhalJ2WFFvVzlFblhvSWVmTkpJdG5UcnE3cjFMUFI5V3hlbUdO?=
 =?utf-8?B?bThaaC9FZ1NxdSt2ZmxaM3IrY1FvOUw5TlhJem9LM1FJQ3V1NkViaCtyVGtt?=
 =?utf-8?B?SW1nQ3NUWURvRmVzdnVUVDB4c0ZzMjFoNEwzQ3p0d3Q0aiswM1VlNm83WWl0?=
 =?utf-8?B?NzNad3RHbmR1bkJNV3FtaTMvUHpDTlllVyt1Q1E2Rk9VaEg1bEVRbFdySW5u?=
 =?utf-8?B?Y2J2SjJNZmM3bVlOd0t1aTZqa2pSamJob0FjOE8ydUlYZnpYZmZYdktkU3ll?=
 =?utf-8?B?bXdmcjNENExTN2NCMXJqb2Z0WlZwd05YRnJRVHMvU0U0aU93SThBNTAwSE1q?=
 =?utf-8?B?a1d4QkNPbEpRcmxidkhKMm1VaWIrUDF1aHhZd1JpN0dHaUJ3czhHaGN5VWhL?=
 =?utf-8?B?NlpCVXI2WnFoVWVyZnNiYkl0SW1PMzIyR0dwdU9VQmJuVHdpMEFGOU52MVEx?=
 =?utf-8?B?VHVLUUZGTTdNM1BXUHRoUjRqOCtxVmhGenhkSGxxSFc3UGJqeWRqaVo2UzQw?=
 =?utf-8?B?QldaeVBZNzhDMUJMRXNrUmltTTFqTGxudCt0aytkdEhzOFVkallWeDlFQmZS?=
 =?utf-8?B?bk11eVluYUZ2RXdmV01ldDU0RGt6WkJURjVNV1FENUNkWWhTcWMxbXJjSS9k?=
 =?utf-8?B?YjlqdDFwRisxQ0RqU2grWWRWUHRzL3FmUS9HaWcra0hYNVNXNURBWDUwT3dy?=
 =?utf-8?B?RTg3aUNyeFgreGtSam1qNHpTNHlrV1ZkWjhEcEpoblZqeDQyWHhRYm04aThD?=
 =?utf-8?B?OFZlWTR5Y2t6SVEyaW5BenpxVnpWenhLckp3RTloUzBnbklyOUhpWk5HMmZh?=
 =?utf-8?B?UEhQakY3UkZKbndJaGN6cERWME1OSUloYVR3U3RlRCtZclF3WlNraWxiK1lH?=
 =?utf-8?B?Q3Z5b2EzUGFlVTM2Rkh4NmI1bFpuY1VmdHVFZXFHS3VHd3hobXk0RUxybC84?=
 =?utf-8?B?cWVkM3pKN1pSRXQrV2hwdW9LV0RZUW90czZFa1dDYnVNQ1dsTXplWEZOM05u?=
 =?utf-8?B?RjcweFRGZjZrNkNtcWJ3djhYbDJkaHlVaHcwSERWRDIxcStvNHN6MlpJNlRM?=
 =?utf-8?B?eStzbzduYXJINEF4aWpnVTJ1NXZVNUp4dUI2Slo4QkVJMlMwKzRncm51VHNF?=
 =?utf-8?Q?Dc+gQ3qG4Q33+gf4sBS6rys=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5a18d9-7805-48c6-fca2-08dd16dd893c
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 16:38:10.3937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXIL5ymngVWHgruek6dnFSgMQp4nyfhtv+v0GcZas3zOfJKy6pVw6VoKtAZQeHWfl3gF00yIpHQENQM84b+nIhYopywDk1KTWIHFWan77Gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10672

On 2024-12-07 11:20, Zi Yan wrote:
> On 7 Dec 2024, at 10:31, Mathieu Desnoyers wrote:
[...]
>> I'm not entirely sure if we want to go for the wording "is_aliasing"
>> or "is_incoherent" when talking about icache vs dcache, so I'm open
>> to ideas here.
>>
> 
> Let me know if the code below looks good to you. I will use
> (cpu_icache_is_aliasing() || cpu_dcache_is_aliasing())
> instead of
> (cpu_dcache_is_aliasing() || IS_ENABLED(CONFIG_ARC))
> in my next version.

Yes, this is in line with what I have in mind.

And I prefer your second version with the generic
cpu_icache_is_aliasing rather than defining it for
each architecture.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


