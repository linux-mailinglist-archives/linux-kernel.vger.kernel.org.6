Return-Path: <linux-kernel+bounces-577121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9C3A718A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38E61889872
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB25719D07B;
	Wed, 26 Mar 2025 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hofgoHO1"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020072.outbound.protection.outlook.com [52.101.191.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B8C1F12EB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999634; cv=fail; b=d4yOW+yGSiIRKsfd2X2A0fgLI785aQysrxCv406HMqCXGamxaE8gzpvTiICctYhI5Nlq3LCyGMtZ02qcZyIut5g2M+jEOUIPpmaj6/BEPpNu7hgTrvuyMl8G3vKS03pxL9GNMOerWQ31u4ieqFw/lrXQUmfcR8MFhmpkz1BhROg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999634; c=relaxed/simple;
	bh=Olo+MyoEeS4U0MqmhsoN6ye9PN7laJ+RF1+vpojCbWQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h//vGtllJbBaoa6ysoZFDgjWecCTMW0TRQ79GQ3sy5LWpndipFEofRALWyDQA1/gGrvBHEjJrVtC35JeUJOUhOxL5B9bY7EDcnA0zAtO+sef5/TEjeDzHHxNfye15YCwd3H/4pzs14/3wlCTDCdGplRxhFmPtpGJ73mJ/OcKxTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=hofgoHO1; arc=fail smtp.client-ip=52.101.191.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0EfXaE7bX9pUTlEKHFHByO8dhTAKF2bQV50ppjlIiidC0LCpGUSwfjx3Akc8L0NjehyEhWS0AMfmzJ5CTodXmiu6SyWW39csBcUSChPbQ95gV3MtEwdtTPATWiCEfOIsm/luPHBtpnhFeF5AO/W1l3SrE8aAigyNEEI7QZUz/XGSaF7K3Vaby92l8Vd5lwcuvZ5gxLm88dPJzM8LMKuL13I4+hRCgDzjv8/YH/a9DbIxxinBF0x8RyDIFcuAO7WtxthrXqnH0Npkdo665T/wAMuEuu48FQ1xqY3N6JRokWeiY4LTULmMHPuEeP+1sQeuoJ6HUbtugB6wNFaESRQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GxEsdfXWEHaCdAT4urW0dvp6DzGzqJ5t1+yvXJFYFs=;
 b=P0hVvyplpxZXG8PWtPA0jl2ZlmglEOKxGYv+DYZlmX/qsRt93iysg4ccZHpkHBbvKlvkp4gfthrv0uijuMGBhuOKHAal/mOB5ElXyMBkBqUk7cT3MmJtsiW0LeJ34Z3rR4FovStOQWDiaux6LfZsbvj9bwpE3zN35ISqb4v7orr81SKOCAXNduBOo6ntHOXmYqqEs71erGS92jiRCBnaMXGx2Sl9n39tDz00N4zZEg8/ndidecmuDsCtlioyEmeqIbBkrrIfRPoVNGBY/wMxpLvL0BDVfXhajw6XdPUqceraGAtCNxzRNVsFyMxvtHrQUIJvRZmJh5uT6LYuBB6FhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GxEsdfXWEHaCdAT4urW0dvp6DzGzqJ5t1+yvXJFYFs=;
 b=hofgoHO1uRd8zh0wUzyZPooeWtKxNrxdd38eF8973QPl2y3AF171l/QnBFBvQIjY+UCpdv9XmLlDbYMXL8Yb4afBNT9Qmxo7d1xvJ25nBadMvCtYnviZOpAu0DNI34fUCzCFhhq37hVJ5juB+qzLVDTiErfsbwbICzrUIfnkk1F0DyH+206d+iPvNNCzXbT0mnfLXVrYPqLTWiQbqfm4lw4NWU2kQFLLvV1s/RHTD7iPV+FfiKszxmzh8bWMFBWe9H2N18+MVrl3+7Q/DwcCpATTt0N/8cF9p7Hp73ba1inRTUl28W8M6Ecw+hCphd4r1Jobf8Z4GHA+AbtK3a67Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB9241.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:ce::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 14:33:48 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 14:33:48 +0000
Message-ID: <89bc1d11-c2bc-43d7-9a22-e159175706cc@efficios.com>
Date: Wed, 26 Mar 2025 10:33:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/3] sched: Restructure task_mm_cid_work for
 predictability
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20250311062849.72083-1-gmonaco@redhat.com>
 <b0b6e10b8651ed59051e426c187ed64b785c4b8c.camel@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <b0b6e10b8651ed59051e426c187ed64b785c4b8c.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0297.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::32) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b793b0b-8741-4686-8fec-08dd6c733868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2RYc2xtb2IydGlRTU5YUE9YZWJxMkRXOVA2MU1JUGNXbmdySFdLMDUxUHd4?=
 =?utf-8?B?VGZGYjNCWDRNMUFVUEhuRHY4SVJYYXFjcmlrWmFUQVJySTRiR2VEL3VucHZS?=
 =?utf-8?B?YlFpSDVCZndFYkwyTDQ0QlNLZmlpMkhvelJzOTFZaFlDYng2alFjUWFERzBN?=
 =?utf-8?B?dTRFTzVhU2lmWnBZSzdRd0w0RmJsV1MyQms4d2ZXZCswKytIcVlVb3d3a0c0?=
 =?utf-8?B?ZW90RklGOXhhK2RvakxxK04vRVA2ekFHYWM2NUlCM2dCYzJhTWpLSEZMM3hF?=
 =?utf-8?B?a2VqcnIxOVkvUUwxUTQrTHU3TTVzN3NpREt3eTBTVUV3SE5xc3J3blpYZzBj?=
 =?utf-8?B?d3pIYmZiNXBGazJVQmtSMW43bzRKc2RxeSs0TVliSDlUZlFha1hFVks3ejVu?=
 =?utf-8?B?ZkU3enZreHB2ZVJTMFhXUUgzcm52TlBzeVYvZnEvMWNKK1h2ZTkzVVJydzJX?=
 =?utf-8?B?alpIWDljSWg3WGxiZlkrUStZWUJTRi8rZmJjMmhGS0VtdVVRR1FJSkRNM0FN?=
 =?utf-8?B?QlhBeXRZU1grOG4ya0tUY05ybVpvZW1RbXowaVUvNU5lbnhnZTQwVngxNXJn?=
 =?utf-8?B?aHNOdGdFRXRmNDdGK29ia0JpRkhIbm9OM01ib1dOaUZWeVNUaitSVUFWWnBm?=
 =?utf-8?B?THZJNXhQeW9uQzNQU1M2Q2FwQjFjT1dEU1UyWHIzWk15Z1hSM2hUR3gwMGhi?=
 =?utf-8?B?eG1QbnR0RFJrRWZ1L3RVdDlva0FER29NWFZtd0V6MG5kR0RzcEUvRkZTbHcz?=
 =?utf-8?B?Y0prbmZnRGtnbFBsWndRM0dwNWQrZ283aGV6UUZWeVA0cmpqREtLMDVqMWdm?=
 =?utf-8?B?WGtqaExHbFk1UkJJNGR1NjNwUUpoNm1rb0lVYUI2eDUweHRIQ1lPT0ppOWt1?=
 =?utf-8?B?eGwrOWpvcENpSURGZUw4R0FFMnY3RmZPTDMzQWpzNENXcHo4c3ZaVGtEaTlG?=
 =?utf-8?B?Z3p6K1UwYjhOVWZPT3hKMXAyK1BwcmhRTnR6OUozL3JJYXlGK0wzN1pNV0dk?=
 =?utf-8?B?V05Jd2RSN0pCWDMzeW8reXBnSXBjbWRBdXNKaXJadFoxL1FvbTN6TTFqTVd5?=
 =?utf-8?B?WFdKOXlvdUVUd0dkb1lMa2VvZmdDMlFYbG9ESkhoS1AzWlM3MFR2TTJMaExO?=
 =?utf-8?B?VWJOeXJOQm5wMHd4MzM5WHVFNWsvOG5MU3lGM21YNnp3M3R2NjBHZEJzL2NN?=
 =?utf-8?B?NWg1YWhVZ2xVWlFMclJuRDR2RW9ZektpTWx5YlJwVjZLNHptcGJuTzBibEt1?=
 =?utf-8?B?cTZOUXNXVGRGVFB2RUQ0WGtsMXp0RkpIZ0FRakJqQXZocHhsSzR1TTF2TmFH?=
 =?utf-8?B?RzIvUEU2OStJbTRmbmk0Y1lueFRGV3VLSUZFNVNzYVUrTHVzR3FROHAwckZu?=
 =?utf-8?B?VXRuODJEQkNyY0YzNDU1QkppcFFDd3NpVE94UEV5VVdHZ1ZkRUFzVHBnL2pJ?=
 =?utf-8?B?ejh1TldvTmZSM0c5dGxEN29lcVFVUUw3Mi9aRFlRbzRERXFGY3ExVnFVZTZF?=
 =?utf-8?B?cHlPS2JRN0V3ZDExS0h0TjBuOUQ2M2U2dXhWOUxDZFNoanlpdmxqYVFma3la?=
 =?utf-8?B?ZW9YOWcydVpIWUovQ0xzSHh5ZTdyRHBnNzUyUlFZc2pzZGVsMUUxeTVacmdQ?=
 =?utf-8?B?U2NST3BSUEttK2N3VW1qREJ5RXJCNmphUUxsbUJwUWZLZWM5TEFLeThtWm5W?=
 =?utf-8?B?L2pzVFJWcnRpTGJUNXVZQnNyaWJ4T2tYSXNNOGxYVmRRVnBVMjY3SWhLSjZ5?=
 =?utf-8?Q?t4OdER1YcesaJFjy/aMPB8z5AJgJPD2BZyz7BM4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3dZRnFUcm5mTlJkQUpYeEhabE5wNGRJYlVKYmU3KzV6MTlwMXVBc2s5U2xk?=
 =?utf-8?B?cUxvYmVXTGxuSEtlZm0rMkdTWTBkSXN1RGRmaldiOEg4TXlaV3BGejI1ZWFx?=
 =?utf-8?B?VDlsQUZ3YnR3UXZlN25rcWVRWU1KckhFYkUwTnBUTVloYWNaQlZ2VEh3MnZE?=
 =?utf-8?B?eUZaUGxqV0YrZW5sL3llaFZVSnB4MnJsME4zekkveXIyTXk5V1d0QzRyU1Fv?=
 =?utf-8?B?UVJFM1UxRU0rZHVkMWJIRkFHMHhySUtWTmxUeWR1ZGJWSWQ0dTBHQUlCb0Zv?=
 =?utf-8?B?dTZJR1dsVUxiOUx0aFB0V3RJYWdRUDJ0U09zUjhpb0pvbTlpby9xeDRZb3Jn?=
 =?utf-8?B?amY3bk9LandFSS9XNWYrRnJxRmFqTXZEYWFDZFU1NEJCbjBseTlJamVNOUxq?=
 =?utf-8?B?MitwZm55TnFlQ2NjblJtRThXRGdOSStRNExZbS9sM0poZ3l3MExpeVFQYloy?=
 =?utf-8?B?UWlQTkxCM2tLWWFyYlFJbk5zSktTNllVbnlIRnpjdFh3b2ZTQjVPUnYxUm9I?=
 =?utf-8?B?ZXZYa0RHRjdJU3Q0R0xDSi8zU1pZQ0RGenlxODNvNjh5d3BCVmdJay9jN0ZN?=
 =?utf-8?B?TWF0bi9xVS8vbEsreTUxaWJtdVdjTGFGSEozL3IvZVJjbHB0YXk1b3NxTWVJ?=
 =?utf-8?B?L3JaS3NVK1hYYlYxaTRmTHNneE9hUEdka3B4T0NwSFhZblJzN1hJcE44NkI1?=
 =?utf-8?B?U1VxM1FVcHBGYkt5d1AzTUZtcFFraEpnVEgxNVJWMWQ5dWQzaXArZzJ5bWdQ?=
 =?utf-8?B?elJESHZra3pUOUU5cEo0VmU5ZTQ0MFUvSDdIa1hQTk84amJET0dtaHA1U1J0?=
 =?utf-8?B?cFVMVkI3ME1iYk5vK1gybFQrZjZEOFlaUmI3TXp3eDNtVHdVaDhOYmU4N1ZV?=
 =?utf-8?B?Y3ZzVjlLQVlWTkJVdFJRcXh6UFV1TlB0NVg2ekNkMUo1RUdMTk1nalc0MExs?=
 =?utf-8?B?T1RRUTBWUDJ0Q1V6UGI5akFCRERoc3EyOVViVkI1eHNqRTFsZEMzdGk2N1p6?=
 =?utf-8?B?R0xhdGk1TVRySkdYS2VYcDM2UVV3ZjUyQ1FnZENUVGQyWENHK3BtRDN1Tm1O?=
 =?utf-8?B?TVY1QnprbHN3YkZLZzVqNmFsQXNyK3ZVNEhMeHczTXJjb2RIQ1RzYkRtS08v?=
 =?utf-8?B?dityYmo0SjduaTNpY0l6RTArMDF0bG5taU9uazlHUmYwMXVpWVptVjF6R05O?=
 =?utf-8?B?SmlHVlB4aG1ycDFELzMzemswL1ZxWWNQaTk3alk2Tjh3bTRzYVpWVFhXemZ5?=
 =?utf-8?B?T2ZoWDVkenBPOWJEZmYvWkRxbHRlZU1QNmd1cXpVMXBuMEYyZjJCK0xzZ2NG?=
 =?utf-8?B?THM5d3BUMUpCbGFybHpQNzloQ1IvMkQwV1NIZmk3NUNTR1F4VTB1WlpxVGFP?=
 =?utf-8?B?bXd0UitBamU0Qml1emJJR1V0U3hiMXdjem9DSGgrcDQrcnIxVGc0MndydDdH?=
 =?utf-8?B?WFZING5WTGJ2eExMWjBmNW1VYjhmeTE3bGU4VHlSbnhRWGp1bkNsRlUrSm5u?=
 =?utf-8?B?SDBtY1ZEcndNYU9mRnlUdWdyTjZTdEkrZXFFdDhtaTZYOGFCTGNMK3d0TTlG?=
 =?utf-8?B?UWV4SlEvYzhhZUJTeVlpUFZKcmYweVFDNHFCVWVQODhRR2lvVGltWDBFTWFH?=
 =?utf-8?B?MzFYYWJXTFkxbjdXUGJFUTJMU29CV0lDSlhNQUVJa0FTQkJkdUMwMnliaUNQ?=
 =?utf-8?B?ZlFyMFRPbjZtWDc5RFRXWjVFVTZOamxnTThEblVpaFRvell2SlpqMU9kd0Fl?=
 =?utf-8?B?S2xKTUw1RFhyU0ZkVXNuYVh4dDdwNU85SlVueFB5aW5zdEd5OC9IRksveDk0?=
 =?utf-8?B?bXBSSm5LbkJRZkd2YXVVUEJNd1YrWWZLVVVvS1drbUt0dlM0d011aHNRTzlI?=
 =?utf-8?B?UkpOank1OEJjSXNSeTBTbUVubUx5KzdxR2lZR0Vacml0MXZ0WFNIMkdUUnNm?=
 =?utf-8?B?b3FoN3h5MExDSndaK3lMSW0yMDV0S3lUWkVzZm5DUmF2ZWFSeU85RDFFZnA5?=
 =?utf-8?B?VEJ0cFJHdDdYZmMvNWQrUmJmWnFOazA1eFdrMTFGZm1WbDFYRXdSeHpuVk1M?=
 =?utf-8?B?YkFsZTBKNVV3M1ljYm9zZlJUMEhMRG1LUEVaQ1pRSzh6UDRQeDJNZHZmdkJh?=
 =?utf-8?B?R3lLTVNjTEN0dkgreFowTVNsNTBGaW9neitQT0VOaGlyNitubHdSL2V3NnRq?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b793b0b-8741-4686-8fec-08dd6c733868
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 14:33:48.1571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFgNZNyN3Bq9F6rCzUd5ay9r2YiK82UozdWGpwAfopePHFguyUkhrseNAYygbkh74iGkYjsd8Ifk9LYAjvWXnWAxQcWcxNwegfRtV4Zs5EA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9241

On 2025-03-26 03:31, Gabriele Monaco wrote:
> On Tue, 2025-03-11 at 07:28 +0100, Gabriele Monaco wrote:
>> This patchset moves the task_mm_cid_work to a preemptible and
>> migratable
>> context. This reduces the impact of this work to the scheduling
>> latency
>> of real time tasks.
>> The change makes the recurrence of the task a bit more predictable.
>>
> 
> The series was review and, in my opinion, is ready for inclusion.
> Peter, Ingo, can we merge it?

I agree. I've reviewed the entire series a few weeks ago and it
looks good to me.

Thanks,

Mathieu

> 
> Thanks,
> Gabriele
> 
>> The behaviour causing latency was introduced in commit 223baf9d17f2
>> ("sched: Fix performance regression introduced by mm_cid") which
>> introduced a task work tied to the scheduler tick.
>> That approach presents two possible issues:
>> * the task work runs before returning to user and causes, in fact, a
>>    scheduling latency (with order of magnitude significant in
>> PREEMPT_RT)
>> * periodic tasks with short runtime are less likely to run during the
>>    tick, hence they might not run the task work at all
>>
>> Patch 1 add support for prev_sum_exec_runtime to the RT, deadline and
>> sched_ext classes as it is supported by fair, this is required to
>> avoid
>> calling rseq_preempt on tick if the runtime is below a threshold.
>>
>> Patch 2 contains the main changes, removing the task_work on the
>> scheduler tick and using a work_struct scheduled more reliably during
>> __rseq_handle_notify_resume.
>>
>> Patch 3 adds a selftest to validate the functionality of the
>> task_mm_cid_work (i.e. to compact the mm_cids).
>>
>> Changes since V11:
>> * Remove variable to make mm_cid_needs_scan more compact
>> * All patches reviewed
>>
>> Changes since V10:
>> * Fix compilation errors with RSEQ and/or MM_CID disabled
>>
>> Changes since V9:
>> * Simplify and move checks from task_queue_mm_cid to its call site
>>
>> Changes since V8 [1]:
>> * Add support for prev_sum_exec_runtime to RT, deadline and sched_ext
>> * Avoid rseq_preempt on ticks unless executing for more than 100ms
>> * Queue the work on the unbound workqueue
>>
>> Changes since V7:
>> * Schedule mm_cid compaction and update at every tick too
>> * mmgrab before scheduling the work
>>
>> Changes since V6 [2]:
>> * Switch to a simple work_struct instead of a delayed work
>> * Schedule the work_struct in __rseq_handle_notify_resume
>> * Asynchronously disable the work but make sure mm is there while we
>> run
>> * Remove first patch as merged independently
>> * Fix commit tag for test
>>
>> Changes since V5:
>> * Punctuation
>>
>> Changes since V4 [3]:
>> * Fixes on the selftest
>>      * Polished memory allocation and cleanup
>>      * Handle the test failure in main
>>
>> Changes since V3 [4]:
>> * Fixes on the selftest
>>      * Minor style issues in comments and indentation
>>      * Use of perror where possible
>>      * Add a barrier to align threads execution
>>      * Improve test failure and error handling
>>
>> Changes since V2 [5]:
>> * Change the order of the patches
>> * Merge patches changing the main delayed_work logic
>> * Improved self-test to spawn 1 less thread and use the main one
>> instead
>>
>> Changes since V1 [6]:
>> * Re-arm the delayed_work at each invocation
>> * Cancel the work synchronously at mmdrop
>> * Remove next scan fields and completely rely on the delayed_work
>> * Shrink mm_cid allocation with nr thread/affinity (Mathieu
>> Desnoyers)
>> * Add self test
>>
>> [1] -
>> https://lore.kernel.org/lkml/20250220102639.141314-1-gmonaco@redhat.com
>> [2] -
>> https://lore.kernel.org/lkml/20250210153253.460471-1-gmonaco@redhat.com
>> [3] -
>> https://lore.kernel.org/lkml/20250113074231.61638-4-gmonaco@redhat.com
>> [4] -
>> https://lore.kernel.org/lkml/20241216130909.240042-1-gmonaco@redhat.com
>> [5] -
>> https://lore.kernel.org/lkml/20241213095407.271357-1-gmonaco@redhat.com
>> [6] -
>> https://lore.kernel.org/lkml/20241205083110.180134-2-gmonaco@redhat.com
>>
>> To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> To: Peter Zijlstra <peterz@infradead.org>
>> To: Ingo Molnar <mingo@redhat.org>
>> To: Paul E. McKenney <paulmck@kernel.org>
>> To: Shuah Khan <shuah@kernel.org>
>>
>> Gabriele Monaco (3):
>>    sched: Add prev_sum_exec_runtime support for RT, DL and SCX classes
>>    sched: Move task_mm_cid_work to mm work_struct
>>    selftests/rseq: Add test for mm_cid compaction
>>
>>   include/linux/mm_types.h                      |  17 ++
>>   include/linux/rseq.h                          |  13 ++
>>   include/linux/sched.h                         |   7 +-
>>   kernel/rseq.c                                 |   2 +
>>   kernel/sched/core.c                           |  43 ++--
>>   kernel/sched/deadline.c                       |   1 +
>>   kernel/sched/ext.c                            |   1 +
>>   kernel/sched/rt.c                             |   1 +
>>   kernel/sched/sched.h                          |   2 -
>>   tools/testing/selftests/rseq/.gitignore       |   1 +
>>   tools/testing/selftests/rseq/Makefile         |   2 +-
>>   .../selftests/rseq/mm_cid_compaction_test.c   | 200
>> ++++++++++++++++++
>>   12 files changed, 258 insertions(+), 32 deletions(-)
>>   create mode 100644
>> tools/testing/selftests/rseq/mm_cid_compaction_test.c
>>
>>
>> base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

