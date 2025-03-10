Return-Path: <linux-kernel+bounces-554801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E04A59DFD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C030A7A40A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD3C230BF8;
	Mon, 10 Mar 2025 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="J2SUldNE"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022099.outbound.protection.outlook.com [40.107.193.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B17D233721
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627569; cv=fail; b=Qss3Y/B8dzwd7aKgYyyoPTP4Pb5/z7XmnubXpEnBUr+2+unocHaVHLCg/JbK8E3f5COHAX16jq64kOxnKjEY1ALkPE9tz+inw5WP4J9XL5nrIbPhcC+mDkS/yWw2MrTMGWaC5o/Mmxpee7ADJfW21T125K9hELJJbU3INqnAwbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627569; c=relaxed/simple;
	bh=/WRbK9wojHKK1HN2lGFmwNAzxVYM/hu+Cx44YhQyScM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o4WYySNS7eiuF5gnpz44VjK6ymMvQbzBhONhc6VW3Co1o1aEEXwZM1btNrjNLC3JcmILgSUPtmXNXpfcRvrGdgihWxh4aX1vLbAbjXU2xxqjUTLNB/QmO06JqXaSzWo/ZUbbUMl263cx5P5AHdOB+UdxxxMKgzF8DLGqCH0FOBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=J2SUldNE; arc=fail smtp.client-ip=40.107.193.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8FvyatKGrzFYA2QtTJC6MgjGxQLvJCLT5Eig9KS3Dp4HaMk1EzNAwHyyFAvi48gN/DuBVeo5GTclWeLZPguf0SPTVxcPBy1FHQctEzYhL4riVSoJEQ8tIxQYBASo0CcdCq/3+9jXfGsAoJpOPeLt7GSlHTWuIEXPK8x3gTaDSk/yoFmX5eSYJbw5PLOAEqOgRFu9g3fZaBahynx9PwA7I/h2RSdLs5XD2gOvFn2lo4MQGsW2etV4clX4bvU0iG+wWTZCr4JYSilAIj5siYC9QEv9I/RLxRd7OXAyDGAfO70bn+zHJxkGvnQ2Di3mKWuJKzBKzwHaXYSDrWYt/PoZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlAghg0uCrazKGNfYGzwMPSVCOsX0Gk+5XWAEpLmHhI=;
 b=vroAMHmxm45EnA9akRxrDZ37d+QNfowdc/a0uw/xEslypV+DUhLs3YN8qoWvCYAUTw7tcHxQ1NW9nFvs0IUVgwXLxUuOgEWMmaFfbacLUfQ4q6yQbJNPZRHhAe4++UivqtthFdDJP0gMIUiCuBWgQn99yeUmuUNJWXHZDF4aK/CZutqW5mup4894Uh4JmWmuS10DpOsrAEwK+7Db3iGhrU/4EKm8z6ACu1mal6CH29Z3Kw6RSd4ipAf7beJjjc0YSnmgRF/9Xe1b8jh4KikLKP8YtaEqruNbTexkji2qY2ekqG4HGMQaFFu+IEnFgj5MVATV1U9RqPYmpcQlvFiTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlAghg0uCrazKGNfYGzwMPSVCOsX0Gk+5XWAEpLmHhI=;
 b=J2SUldNE632w3qWdt713SJrSCb7PM5tIL/vC3KtnfKHLmn3ag4iGNr5osHlQ7rRAQj+fpqStpDNt6/XqjEH4Lkw5t9FIgXXddxIsPWxkLHkVAr0QJqvzsAi7kztEqsLUldm2TncbwKJLAybSoDU9c95Vc5Mm4jthSufAZqYR8YxOPjqM3Vhb1C6G/nQ8B4CDdSpa9s1jXm/vN/W8ta4JTOeHYuvNYexyA1ZnEOSwnqDTpk5WLdBS1ua7GRyCoB8upIlhLhuWfNdB3jqXoNstk2WBmLfeFhMV2mdG3Hwg6AprMjY752KrxOoMnnnPAzxbCQVPkatwJRYTS8ZZP9lRjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YT3PR01MB9660.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 17:26:03 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 17:26:02 +0000
Message-ID: <8a984527-5775-479c-8f16-f9feb38064c0@efficios.com>
Date: Mon, 10 Mar 2025 13:26:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] selftests/rseq: Add test for rseq+pkeys
To: Dmitry Vyukov <dvyukov@google.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 aruna.ramakrishna@oracle.com, elver@google.com,
 "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Michael Jeanson <mjeanson@efficios.com>
References: <cover.1740664852.git.dvyukov@google.com>
 <9a98ed5d655e9a0d66027779c75c3ba67601e1bf.1740664852.git.dvyukov@google.com>
 <26b779d4-0478-4926-ba5c-e71449e92020@efficios.com>
 <CACT4Y+aT9z8qjY-66wiOR0Wiep2BoTN7QJYxj-QK_KRXLmgiLA@mail.gmail.com>
 <c3781655-b667-4477-9337-445d8250fb4e@efficios.com>
 <CACT4Y+YpnCfm6xjdwnUJ-3ND_YPNdAqReffueF1dWGfxmJLWEQ@mail.gmail.com>
 <3c45a374-804f-4a9f-8885-5ef1bfc8676f@efficios.com>
 <CACT4Y+Y1Hgw9xmqhcCqPmgspOKLqvm6c54yxZus4uXd==PJxuQ@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CACT4Y+Y1Hgw9xmqhcCqPmgspOKLqvm6c54yxZus4uXd==PJxuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::20) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YT3PR01MB9660:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8dd5a4-4877-4f74-9c81-08dd5ff8a1b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm0xVlEzcXQrbWFQWU1HYmdWcHMwY2dYblY4U0JLenFiZ29XVWozczFXeG0r?=
 =?utf-8?B?VmVlYksrRFBMek12Y2hmM0hlOEZOVjNiOHNCOEtGMmN5eEdJd0NEZVQwWC9o?=
 =?utf-8?B?Mm9IOVg0RDhxS1pnNWZ0dHJqL29Kd0R5WjRNc3BQaTVPblhnMFpicFBPTXVQ?=
 =?utf-8?B?TXorRjMvbUttcmk1Rk1SMVpQOHRtMDFYZVRtWW9mdTc0dld1TFU2WkxwR3Fv?=
 =?utf-8?B?MTFFOXdNSUFaT2U4NlJzM1IwckM4TEZIRE5PWVJqYlBLbFJRYW10SHgvTE8w?=
 =?utf-8?B?aDR3MVdYemJtOStFUzMzV0k3ZzVwd3NmTUhWaEI2SmlRQlZlZVkyMUR2d2lz?=
 =?utf-8?B?Y2lrR01qN3ZkNjNXOCtrYWpaTUVBc1RCb1JNZ1lTckVqdUxVc3RNR2t6MmF6?=
 =?utf-8?B?dWRrRGQxWjBTdHVhdEpZK2lncHBaQWxPdGVISHJQdC9tQ2NZaTVWWEJvVHdn?=
 =?utf-8?B?bEtyMWppN09qdnhqV2NRekhyelFBWkVER3E0VnBjRTlTa0FueDZIVnYwWC9v?=
 =?utf-8?B?Z2ZvdzFWTXNxWjZ3UXprdDlRMjdDVG4vVTRKU1dmNUlUeHpYbTBGTlR1VWF6?=
 =?utf-8?B?VGswQ2hPbXg2ak9aZ3RqZnRJakVzRTZsYUt4OUtsYmUxTEtVakZ1djBKbkNn?=
 =?utf-8?B?eG80YzVpRlpQeWR5NGdtSis4dW9MeWN3bVRYcWNWeEV2UHRDRVZSclovRnBp?=
 =?utf-8?B?YjA0N3doQjNQSmk2eHdtNys2Tkdzd0haZi9mNmg4dWZIZTh2Ui9hSUh0Y1JM?=
 =?utf-8?B?VGRMVWpEUENGeU5SMmNKS2R3cnJLd1JHSGlJTjdRWHhVaUVpUzYvcVl3dWZq?=
 =?utf-8?B?dUVNVG1IUEhWTGVvWFk3LzVTOENISENhNTV0SXRzeHVRWWM3NXZPd0tuRDcy?=
 =?utf-8?B?K2tsY3pmVEFKM2xCRDZ0bEVZTmlYSmovdmgxOHdISDgxUWxYM09qQzFoUW9a?=
 =?utf-8?B?LzVCVTVBbkZSV05wUGtraUtKZlIzejQwYVZ1MU5EdnUwUzZRQnJncjlUMnEx?=
 =?utf-8?B?UFhlZ2dOS0tla01veHVMRS95NnZsRU5xYmNGd0Z0SjZCdFJxb1RHMHI1RVQz?=
 =?utf-8?B?M2xvQ0hGcDQ2RVdtN2QrOFdxTnh2NUEvbFRlaGZjWG5janZ6Z240dkorbmdY?=
 =?utf-8?B?ckR3cmViOVFDY2xhSmFPMUFkZERUM29RQ2dBdmVad254dVRMRmRGckg5L0tx?=
 =?utf-8?B?YlF0dlo0bnBpUVppdGNLNXg4TDI5YnlwZzkxbWZ0by9UdFlJbGlkejFRU0FM?=
 =?utf-8?B?RHJRNFJuR2l4UmJ3RjIxQU5aWHZDdVI2YlcxZmptNXQyMzBPM216ZjZMR2pm?=
 =?utf-8?B?ODdRMkt0Wi82SmhWeGdxaE0ycktIQWtIU2NFci9GMHhwbDhvUEpoTGVyRHU3?=
 =?utf-8?B?NTlpVE1Qd0tJN0hjUG1DYi9iUG04eW92U041UzhiNGZLZEpsbUpLWnR0bmlW?=
 =?utf-8?B?bjJyM3o2bWZPdlNEemhyYnNmb3VZVFBraGlGUXJqcmk1R0gxZ0dZQVRobUda?=
 =?utf-8?B?aHZGVENQdWRhV3NjY2dkVlB5a204ZTJmQXE3MUxibkZnWFlWTVhqVnhIMlQv?=
 =?utf-8?B?SFMrK3NneFRxaWYzQ0tpS3VQeG5rYVh6SkNWb0U0NHJvbU04bi9uMWlSaFFM?=
 =?utf-8?B?eWVtdVNRbUg0TVk5U0Nua2hkRmx6ckpJeCtnZXdYc2tuRWZYWHJScWdvYXM5?=
 =?utf-8?B?N0hzSDJhenNUU2RQSm5rZ2xVS0hzWDZ0RG9BbzFPRHZLRVA1Rk5xN2UrMFFw?=
 =?utf-8?Q?tLRkwB3MWbjVH19BTQ1JswjZN7LxQvp9uoYWB40?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXdET0drc1dVeTlBM3d1cHo5TTF2TmMvYld0S0k0M25iVzluc0UwOWJGOVBw?=
 =?utf-8?B?aXBWVktwNDRtQjB6bDdOcmhmeTQ5TUNYK0tnTHI1azJQZi93a2Z3REhjRjNV?=
 =?utf-8?B?Y256N29xdngrMFB0L1EvNHdoUWVEeENPUjBpSDJPNE5KU2llUjIvYWdpRTdo?=
 =?utf-8?B?Y09PWWJzU2dWQ0ZvWEZseU9wVHpMMGE3c05jaVRwY1QvckozNTRMb1h5K0F2?=
 =?utf-8?B?V1M0NmNoMzFlQ1BGYkNYZlhCWGs3a05YRnl5MG53c1N2Z1B5Y3piVUQxWTZ0?=
 =?utf-8?B?WXRKMm9vYWdtY2NYdjBrWGRwWWhPODhFcWdHRFFBQnJjczdEeHBZcmVTUysw?=
 =?utf-8?B?Uk9ROVpuQ05jbnZSSExtbTlRdTlmY0NDTi9nbmxaMFcwd1h1WmJzVUliN3B5?=
 =?utf-8?B?dTcxTmZ4dHBKWTBmbUdYM1JvYzhudnhPODNDdkdiUE0zNTd3SitaYTlVVk5E?=
 =?utf-8?B?Mm91amJmM0FwRWtVSWdVdlZnVGVoQ0RnL2Q1MXNPNzgvdlVxY1I4MVRkMmFC?=
 =?utf-8?B?R2M2aHBrUzRzRXVPS3ZQMDhuN0o0WUI2RGpyT0Z6ajJtT1l6ZDUvdVRic014?=
 =?utf-8?B?bFNjdUJ0blB5am95N1NYbWYvMzZ6T3ptbWpJMFFSV1d5aDZLYnJ5RWpXMFd1?=
 =?utf-8?B?S2hJZ2ZIOTA3TXVudlhPTUJpbUlSVlp3QjhnM1BpV1FIN2pjWEVHSHo0bEFJ?=
 =?utf-8?B?a3pta2xOYjJ0QzVnQTBwZnNCeE8rUUJZNGhlSHBnRTlPcGJLeDJZSzNrZTQ0?=
 =?utf-8?B?TTU1SzNEUTNBREI5bWJnRlhGbEtEckFOU0RadytIZ3hIbFB2c2FHVnhIbHpY?=
 =?utf-8?B?S09XaUJPWlRUNTRKbXM2YkRXRlRjNUlodDNHYlVNOSs1OUdlRjJwTldVL3h5?=
 =?utf-8?B?WGVKNFhoSFlhZGc0WHNLQ3NXWDRXcTZLMjcwMDJjSS9TRTFCMFcrQWJ6SDZM?=
 =?utf-8?B?WkJxVG1OeSs2U3BvSDk4aVlyZXZrdWx4MEtYMkxabmI0S2UvUVZIQ2x5Sm9F?=
 =?utf-8?B?aERXNGtMcE1Dem9KQy83OTBIZjFUM0xwODBISExUUHR4bVIyam5QSTdJYXh5?=
 =?utf-8?B?dXkrdDJZYitEanFhbTJzMjJaUXdlMk00RDNNc3pvbXNwZnJ1UVhhUnZIVlp0?=
 =?utf-8?B?SDY0RUpQOVFnSi9ycU9EQ1lQSjcyYkRhaDMzZm5xN0llU1NkVGpJUnZ6d1Q3?=
 =?utf-8?B?ajVudmN0VTNCVE5UbTFsUEZYcUxIU24zMkwvU3lGZnJWeG9JOWNQall0QjVz?=
 =?utf-8?B?ZldJVWJxeU5Nb2NQaVlIS0JYODFLWjBLQU9oNGpjcVNhVGdSOTJMVEJ1Wi9D?=
 =?utf-8?B?ODFjZEFWVk5vTGdaRWt0MENWK3RNeUxlOS9RajhNYUxscjZRTFpMTC9uZ0tP?=
 =?utf-8?B?Mjc3bElKeTNnUklmN01uaG5PQmJZSGtZV3FXQ3NoS3ArdUtYSUVtaE93UkJv?=
 =?utf-8?B?S05ES29GdHBoTVlIS2M2ZUNWNGNxZlAzTlFwejR1V3FTQ1d2YTNzdXpPUTVl?=
 =?utf-8?B?RG41VEQzQmxrNkdVM3ZSVk45amovUERJdGhzZm9zZ1ArRXBwNFJvd1JHTDRa?=
 =?utf-8?B?WFF4QmZNU2FJV0hWdW9rM0xLeEZ0WDFPVW5ibUVBV1BRVTVtTEI3ZVdldTA2?=
 =?utf-8?B?aEJGNGFxcDkwQmFmVW1HQlNEQVpQdHU4UmpsWHJmUzJOWmNZWVovb1ZHWVN5?=
 =?utf-8?B?Y0hCY3ZxNGVXeDVrUXloYk1LcHN2ekh6SWRkVHI5ZTRPN3U0SFRBZDhndHVu?=
 =?utf-8?B?M08vQlVIL3M4dEZhbGM5aEtHcDBiZXVjZWdvSHlZZFJrR0tFU2RwOHRucGJJ?=
 =?utf-8?B?aVc2SGNrOFB0NGNkMzdOZHF1RHhmS003aTJSbm80WEtydEJIdGJaVnhTUlQy?=
 =?utf-8?B?RWNhT2toZ3p5VHZZOFlwcCtRSC9rdDQrUTFjVUJHZGNrVzEwVm5TNXVnTUVF?=
 =?utf-8?B?eGR5T2MvSEF4K1BiNjU4N3kxdTFxWHh4M1lEdFBrcTRaZnk5bXpmTENyVmlj?=
 =?utf-8?B?VmF2c3hlSnlnOXJjcTI2dENMNU9DNHhldXZ5RmxKSUNtWGsycmdhNlFwSUV0?=
 =?utf-8?B?RmJJMDdvaE14NnhlS1kxRkRKYUtNbU1Nc3V5aml0SXJ3aEM4azVPaTFnaVhB?=
 =?utf-8?B?NTJSZE1LUnZFUkNGbGE5SWJRc3V4SEJER2p2K3JSN21SS3pGcS9VRnR6ZUJJ?=
 =?utf-8?Q?xxDjo/sw/AcvKBPbyuBhWyg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8dd5a4-4877-4f74-9c81-08dd5ff8a1b5
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 17:26:02.8434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQH0BPQgK1MurbW+PiTY84o3mGNPpLl8kJpH+5FzAjdbUwtpdu7nYRlc7+7aF8vjfXTjoe5/rq1oOugoNKAwLBiE9ZTm6vv/4SloZNWzpG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9660

On 2025-03-10 12:31, Dmitry Vyukov wrote:
> On Mon, 10 Mar 2025 at 16:41, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> On 2025-03-10 10:43, Dmitry Vyukov wrote:
>>> On Mon, 10 Mar 2025 at 15:38, Mathieu Desnoyers
>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>
>>>> On 2025-03-10 10:36, Dmitry Vyukov wrote:
>>>>> On Mon, 10 Mar 2025 at 15:30, Mathieu Desnoyers
>>>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>>>
>>>>>> On 2025-02-27 09:03, Dmitry Vyukov wrote:
>>>>>>> Add a test that ensures that PKEY-protected struct rseq_cs
>>>>>>> works and does not lead to process kills.
>>>>>>>
>>>>>>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
>>>>>>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>>>>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>>>>>>> Cc: Boqun Feng <boqun.feng@gmail.com>
>>>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>>>>> Cc: Borislav Petkov <bp@alien8.de>
>>>>>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>>>>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>>>>>> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
>>>>>>> Cc: x86@kernel.org
>>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>>>> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
>>>>>>> Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
>>>>>>>
>>>>>>> ---
>>>>>>> Changes in v5:
>>>>>>>      - Use static for variables/functions
>>>>>>>      - Use RSEQ_READ/WRITE_ONCE instead of volatile
>>>>>>>
>>>>>>> Changes in v4:
>>>>>>>      - Added Fixes tag
>>>>>>>
>>>>>>> Changes in v3:
>>>>>>>      - added Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
>>>>>>>      - rework the test to work when only pkey 0 is supported for rseq
>>>>>>>
>>>>>>> Changes in v2:
>>>>>>>      - change test to install protected rseq_cs instead of rseq
>>>>>>> ---
>>>>>>>      tools/testing/selftests/rseq/Makefile    |  2 +-
>>>>>>>      tools/testing/selftests/rseq/pkey_test.c | 98 ++++++++++++++++++++++++
>>>>>>>      tools/testing/selftests/rseq/rseq.h      |  1 +
>>>>>>>      3 files changed, 100 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
>>>>>>> index 5a3432fceb586..9111d25fea3af 100644
>>>>>>> --- a/tools/testing/selftests/rseq/Makefile
>>>>>>> +++ b/tools/testing/selftests/rseq/Makefile
>>>>>>> @@ -16,7 +16,7 @@ OVERRIDE_TARGETS = 1
>>>>>>>
>>>>>>>      TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
>>>>>>>                  param_test_benchmark param_test_compare_twice param_test_mm_cid \
>>>>>>> -             param_test_mm_cid_benchmark param_test_mm_cid_compare_twice
>>>>>>> +             param_test_mm_cid_benchmark param_test_mm_cid_compare_twice pkey_test
>>>>>>>
>>>>>>>      TEST_GEN_PROGS_EXTENDED = librseq.so
>>>>>>>
>>>>>>> diff --git a/tools/testing/selftests/rseq/pkey_test.c b/tools/testing/selftests/rseq/pkey_test.c
>>>>>>> new file mode 100644
>>>>>>> index 0000000000000..cc4dd98190942
>>>>>>> --- /dev/null
>>>>>>> +++ b/tools/testing/selftests/rseq/pkey_test.c
>>>>>>> @@ -0,0 +1,98 @@
>>>>>>> +// SPDX-License-Identifier: LGPL-2.1
>>>>>>> +/*
>>>>>>> + * Ensure that rseq works when rseq data is inaccessible due to PKEYs.
>>>>>>> + */
>>>>>>> +
>>>>>>> +#define _GNU_SOURCE
>>>>>>> +#include <err.h>
>>>>>>> +#include <errno.h>
>>>>>>> +#include <stdio.h>
>>>>>>> +#include <stdlib.h>
>>>>>>> +#include <string.h>
>>>>>>> +#include <sys/mman.h>
>>>>>>> +#include <sys/syscall.h>
>>>>>>> +#include <ucontext.h>
>>>>>>> +#include <unistd.h>
>>>>>>> +
>>>>>>> +#include "rseq.h"
>>>>>>> +#include "rseq-abi.h"
>>>>>>> +
>>>>>>> +static int pkey;
>>>>>>> +static ucontext_t ucp0, ucp1;
>>>>>>> +
>>>>>>> +static void coroutine(void)
>>>>>>> +{
>>>>>>> +     int i, orig_pk0, old_pk0, old_pk1, pk0, pk1;
>>>>>>> +     /*
>>>>>>> +      * When we disable access to pkey 0, globals and TLS become
>>>>>>> +      * inaccessible too, so we need to tread carefully.
>>>>>>> +      * Pkey is global so we need to copy it onto the stack.
>>>>>>> +      */
>>>>>>> +     int pk = RSEQ_READ_ONCE(pkey);
>>>>>>> +     struct timespec ts;
>>>>>>> +
>>>>>>> +     orig_pk0 = pkey_get(0);
>>>>>>> +     if (pkey_set(0, PKEY_DISABLE_ACCESS))
>>>>>>> +             err(1, "pkey_set failed");
>>>>>>> +     old_pk0 = pkey_get(0);
>>>>>>> +     old_pk1 = pkey_get(pk);
>>>>>>> +
>>>>>>> +     /*
>>>>>>> +      * Prevent compiler from initializing it by loading a 16-global.
>>>>>>> +      */
>>>>>>> +     RSEQ_WRITE_ONCE(ts.tv_sec, 0);
>>>>>>> +     RSEQ_WRITE_ONCE(ts.tv_nsec, 10 * 1000);
>>>>>>> +     /*
>>>>>>> +      * If the kernel misbehaves, context switches in the following loop
>>>>>>> +      * will terminate the process with SIGSEGV.
>>>>>>> +      * Trigger preemption w/o accessing TLS.
>>>>>>> +      * Note that glibc's usleep touches errno always.
>>>>>>> +      */
>>>>>>> +     for (i = 0; i < 10; i++)
>>>>>>> +             syscall(SYS_clock_nanosleep, CLOCK_MONOTONIC, 0, &ts, NULL);
>>>>>>> +
>>>>>>> +     pk0 = pkey_get(0);
>>>>>>> +     pk1 = pkey_get(pk);
>>>>>>> +     if (pkey_set(0, orig_pk0))
>>>>>>> +             err(1, "pkey_set failed");
>>>>>>> +
>>>>>>> +     /*
>>>>>>> +      * Ensure that the kernel has restored the previous value of pkeys
>>>>>>> +      * register after changing them.
>>>>>>> +      */
>>>>>>> +     if (old_pk0 != pk0)
>>>>>>> +             errx(1, "pkey 0 changed %d->%d", old_pk0, pk0);
>>>>>>> +     if (old_pk1 != pk1)
>>>>>>> +             errx(1, "pkey 1 changed %d->%d", old_pk1, pk1);
>>>>>>> +
>>>>>>> +     swapcontext(&ucp1, &ucp0);
>>>>>>> +     abort();
>>>>>>> +}
>>>>>>> +
>>>>>>> +int main(int argc, char **argv)
>>>>>>> +{
>>>>>>> +     pkey = pkey_alloc(0, 0);
>>>>>>> +     if (pkey == -1) {
>>>>>>> +             printf("[SKIP]\tKernel does not support PKEYs: %s\n",
>>>>>>> +                     strerror(errno));
>>>>>>> +             return 0;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     if (rseq_register_current_thread())
>>>>>>> +             err(1, "rseq_register_current_thread failed");
>>>>>>> +
>>>>>>> +     if (getcontext(&ucp1))
>>>>>>> +             err(1, "getcontext failed");
>>>>>>> +     ucp1.uc_stack.ss_size = getpagesize() * 4;
>>>>>>> +     ucp1.uc_stack.ss_sp = mmap(NULL, ucp1.uc_stack.ss_size,
>>>>>>> +             PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
>>>>>>> +     if (ucp1.uc_stack.ss_sp == MAP_FAILED)
>>>>>>> +             err(1, "mmap failed");
>>>>>>> +     if (pkey_mprotect(ucp1.uc_stack.ss_sp, ucp1.uc_stack.ss_size,
>>>>>>> +                     PROT_READ | PROT_WRITE, pkey))
>>>>>>> +             err(1, "pkey_mprotect failed");
>>>>>>> +     makecontext(&ucp1, coroutine, 0);
>>>>>>> +     if (swapcontext(&ucp0, &ucp1))
>>>>>>> +             err(1, "swapcontext failed");
>>>>>>
>>>>>> Should the rseq register be paired with a rseq unregister here ?
>>>>>
>>>>> I dunno. It's necessary for this test and in general. Tcmalloc won't
>>>>> unregister on thread exit. Even for a libc it may be a bad idea due to
>>>>> signals.
>>>>
>>>> The rseq register/unregister is only for the case where libc does not
>>>> support rseq. But if you want to use rseq_register_current_thread(),
>>>> then you'll want to pair it with unregister.
>>>
>>> Why? Isn't it better to have tests more realitic?
>>
>> If you use rseq.c rseq_register_current_thread without
>> rseq_unregister_current_thread, then you rely on implicit
>> unregistration done by the kernel at thread exit.
>>
>> Then you need to ensure your userspace runtime keep the TLS
>> that holds the rseq area allocated for the entire execution
>> of the thread until it exits in the kernel. Note that
>> disabling signals is not sufficient to prevent the kernel
>> from accessing the rseq area.
>>
>> GNU libc gets away with automatic unregistration at
>> thread exit because it completely controls the lifetime
>> of the registered rseq area, keeping it allocated for as
>> long as the thread is executing.
>>
>> So in order to minimize the dependency on specific libc
>> behavior in the kernel sefltests, the selftests rseq.h
>> requires explicit registration *and* unregistration.
> 
> If libc registers rseq (!rseq_ownership), then
> rseq_unregister_current_thread is a no-op. And if libc has not
> registered rseq, then we are not relying on any libc behavior. I don't
> see how calling rseq_unregister_current_thread helps to rely less on
> libc. Am I missing something?

When libc does not support rseq (either because of the
glibc tunable, or having an old glibc, or running another
libc), rseq.c in the selftests registers an initial-exec
TLS rseq area. This TLS rseq area's lifetime is handled
by the libc. I don't want to depend on implementation-specific
libc behavior, unless they are documented and part of the
ABI.

In your case the area won't be re-used because the program
exits, but I'd rather use the same approach everywhere,
which is to unregister explicitly.

Note that in the librseq project, we are currently planning
to remove the explicit thread registration/unregistration
from the API, and will exclusively depend on having rseq support
provided by the libc. It simplifies the implementation, the API,
and will make it OK to link a dlopen'd .so against librseq.
There has been no official release of librseq yet, so now is
a good time to simplify the API and aim at what is becoming
the primary use-case.

Thanks,

Mathieu

> 
> 
> 
> 
>> Thanks,
>>
>> Mathieu
>>
>>
>>>
>>>
>>>> Thanks,
>>>>
>>>> Mathieu
>>>>
>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> Mathieu
>>>>>>
>>>>>>> +     return 0;
>>>>>>> +}
>>>>>>> diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
>>>>>>> index ba424ce80a719..65da4a727c550 100644
>>>>>>> --- a/tools/testing/selftests/rseq/rseq.h
>>>>>>> +++ b/tools/testing/selftests/rseq/rseq.h
>>>>>>> @@ -8,6 +8,7 @@
>>>>>>>      #ifndef RSEQ_H
>>>>>>>      #define RSEQ_H
>>>>>>>
>>>>>>> +#include <assert.h>
>>>>>>>      #include <stdint.h>
>>>>>>>      #include <stdbool.h>
>>>>>>>      #include <pthread.h>
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Mathieu Desnoyers
>>>>>> EfficiOS Inc.
>>>>>> https://www.efficios.com
>>>>
>>>>
>>>> --
>>>> Mathieu Desnoyers
>>>> EfficiOS Inc.
>>>> https://www.efficios.com
>>
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

