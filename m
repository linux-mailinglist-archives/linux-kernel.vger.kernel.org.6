Return-Path: <linux-kernel+bounces-513220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 540E8A3445F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7093AF170
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E29242906;
	Thu, 13 Feb 2025 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LSfOPo3y"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020113.outbound.protection.outlook.com [52.101.191.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493222135AA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458334; cv=fail; b=Aoge/YLCp9rf2pfLI+tAjZEehXBUAodUmPuJdYrZPcwNqStFz1SaU1hbT2T1f5sZPLTQibRfw75byFktFJBfErXpuZbSrpv4s+POq64ULTQe5t/GXFofA/kuZd1BJO1je7WZ1nt7hZcX4qTI+lJ1UbJxq0AmKAyM6CCNI344O8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458334; c=relaxed/simple;
	bh=Bd+tWRT1gRGeDTahuEqVqqZzA3g+SWFWrk0TnuFVGmQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UWqjU2CokJvwdbVmlXRfdIa6W1hQhvbIyCsHvRfR6hyiLuvkrbnkessx/OBBo/qAPLUVPoQjsKzx1H858SaeXkGEfBkLUuSwDDxukaaN+PEUNn8YoOXJqlTBWMi5qPWdL9KolyAk4Gq0F+/2yYeh6HsqFgJWbpv3VcYrYhuBb9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=LSfOPo3y; arc=fail smtp.client-ip=52.101.191.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ij7enCsuoakj3QHf422OzzxDNXdmwQr7pWWgXZftW6GyDT1KMON2IC5E+7a4wXN4LWBFHn/N9Um+RtLj1Bz8bSlzQJxcCReySWNw0C64YXbu37TbtMsrMy4OVyg2TxQyQi/MKUgIO0kLxIhxkq9nkJwektolx4RkQTyHaPtPTaLQveoQlGdA4aHI+1r/UD1khSKSaLUNRk5Gq4KdnONzQSiK32bUmkRVQEPGDMFWEpWHZbL5B2H5osTzJPanACEClUJFbEgi40sFPe71jAUez3dSG6FNgLA4xo46COWkkGc8kH/6LpI4nK8y5zeDaYrcwa66vRb2b0Icwi9JdJJfug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBIQtkN/tN8v9xd8WdVDuT2Ar71BFhzaL7rJtE6PgAY=;
 b=jMJN6wZf1MvEWc7iEqYClc0iSPJNeDH8cIVooY2vQxOjb21jcpKOk8uiF3GBYPcPuwn3IaREQ3QIBUG3+sXgpnpyU58kfPLN/q6I1CmWerFeQQEJdvysMjBqjVM6YB3Guj/HuNa16fB6YY3pDqYa4o41MNjQ5brD2uSA9xNzOdVeiZC/M+iAGIcY/VmskWaw64J/pT773t11ip6NzTDhLAuqK+ow///aLKbSGoKOMnq3APFOHKXun1sjJPrHiXr/b2ticlUAMULhQ5E9jjNli26pU+it3/SD1FKyalxfX4iL0zGEfe+4D0zGGrSFi7tLsgUgQFCdFnCEpTMeVK7tgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBIQtkN/tN8v9xd8WdVDuT2Ar71BFhzaL7rJtE6PgAY=;
 b=LSfOPo3ya/ULFK8UNHoE0ZgO64IFoPnG/l8JZVwjAz6d55zSOSRaj2Vz2afDO+Ykc+VraqZWeuLvrT+1HHgEQeNpww97SrbHJQxsdBh61CJMXBMqtBKINDXGJ6XREl9o8ZL5V0HuuUTLPMKGKonU1ff5gniqPp7CGWMrOz5zak7Gwrnu69VdWInqO4Tob6qW0FFQ4Lez5cJ45DSzIJpoPrg2r/SHotrv/7Yxx5tTIJvHNdzA4v9c94CwRjNnM6DOQ6uHljCOFsDhuYCFZY31f6fseb/WF12Z0ODOkw5+oYmoPDeimk+ZIp/tpIcLuGp2mUiR4Q42OllJRbxYbooYSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB5390.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 14:52:08 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8445.016; Thu, 13 Feb 2025
 14:52:08 +0000
Message-ID: <32815949-dd1b-4cc2-9ba4-724bf6727010@efficios.com>
Date: Thu, 13 Feb 2025 09:52:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] sched: Move task_mm_cid_work to mm delayed work
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, aubrey.li@linux.intel.com, yu.c.chen@intel.com,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <202502131405.1ba0803f-lkp@intel.com>
 <17bda9071b6962414f61668698fa840501819172.camel@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <17bda9071b6962414f61668698fa840501819172.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::24) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB5390:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e87269a-24cb-44d8-423c-08dd4c3dfd0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWVBaW5tQlNEZ0VVbU5aLy83dEo5cDROYmhvMHdibW1ld0pPSVR4UVZobGtI?=
 =?utf-8?B?QVA0QUR3SDNZTDVhS0lscUIyY1RXK0hLRlNzZmhNK1Nidk11YUNjbGJuOG95?=
 =?utf-8?B?NE9nN0JOWXlIcVZvaFY2cVFHY2tFa2VYWURuSW04Z216NHBZb1BFU3hSdmtD?=
 =?utf-8?B?eG9EUVI4TmhLVmY5ZVc0ZVNkYTVJR1dnNGVUWDFIdUZVVTQzUnJteVpSa0Jx?=
 =?utf-8?B?d2R5c0FvRGoxL2dDclhWZ1dLaUVqQXkyR2g0VWpTTDVEbGpoU3UzWHZBSzN1?=
 =?utf-8?B?TlljdUFMVXBBSGpDRndHSWpFZGVuUllycDkyQWFKeTIwUm9qZGlLUC9xQjIz?=
 =?utf-8?B?N2ZISTMzNzBxVURhb2daWVpQMytWSm1JcmJmckxWQlZCTFRxREdiM1N4STJ5?=
 =?utf-8?B?cE1MOU42cEpKZ1F6djQzbGY1OHlvM2wrU2kvMEVGeGdBbXR5S0VndGtMUlFu?=
 =?utf-8?B?RDJOVGhZYkpjWDQ3akQ4U3RDMnp4clN5Y2ZQYnRqQ0s1ZmF2cU1ZYVdIVjhx?=
 =?utf-8?B?cWpSM2VuS1VabXRqV0JxTTFyeTdKb1ZOTGttUlhjZHlDajJzMXRuNUtURjUr?=
 =?utf-8?B?NlpDZnJIODhQYXNHaDNxb1hKdGtEc3FQa1Z5TlRGLzBEeXZzVTRiTmk4aFl4?=
 =?utf-8?B?WmMrK3ZZSW94RWU4NVozbjdGUVVva0Z2a3lRbE5ib3g5THY5NDJGbWlYYWJR?=
 =?utf-8?B?QU9kTHJGMXFPY3k4NTBTK2VSdnVDWCt5ME1aUUZpczZ3aGlLT0xiWjdnZzh0?=
 =?utf-8?B?UVNndE1LQ2hHdER2dDhnaHlRaENTVzBLWThocXBQd1dsVFF3d2hTQ1hKT0lB?=
 =?utf-8?B?Q2s5VlNRcDl3MWZGQ1dZTWEwaDAzOHVFNHJsdUtLWWtodmJBMlE5WWYyT1RO?=
 =?utf-8?B?dlorbUU1RUZPZ0VvdURnTFV5dEJZZzZFWnRET244RUJFNTlibTFFZlFBeHZK?=
 =?utf-8?B?bjVITmdsU0Z5bmxOODhaUHdrODl6YURObTRxT0hMYUdXWGROUkFVTUVxY2Rh?=
 =?utf-8?B?K0F3RGhtWmlDcTc5YXpXYlpYWngyZisxZHYvNDlMT3ZtTFhsb2JhUGxrQ1NH?=
 =?utf-8?B?ZGhyQ2R4N3BLemdRLzkxUlpwMm5wRVdYUjNoSnZLK2ErOGZCd1BreGo4dm5O?=
 =?utf-8?B?VHA1MEFsWkllT0pPUk9XM1d3N3IzcDFSUS9GOXVPMmFNclcwZXhyeXdDbHVJ?=
 =?utf-8?B?dm5rUkRFeGNlMG9ZQzZuZ1NoMHUzTGhkbElUS2dzdEFzNHlMY3Rra05iMnZG?=
 =?utf-8?B?Z1BNcWFVTWNOYWs1OWtiNEx4bUhuaDgzUVVJM3VTMWp6L20zVlAvRmwxNmlF?=
 =?utf-8?B?SGpPc3Vsc29pYXU2MHd0REsyRmpRMTVPU1loT01hVHdNYTBtbHBhNE0rcGM2?=
 =?utf-8?B?RGV1TzdWc0d3dEwyL0MvL0JuWnlsQ3RpYlVaeFJGbnZqTUliT21zOGUrTFJP?=
 =?utf-8?B?WnRFcjNUdW5ETksrWWxxdWRFUXpOWEVHL1JJQnBkbTNUK24rSkw1UUhGQi9k?=
 =?utf-8?B?R0FRRTFHK0Z1dC9VMnU5Nnlpa1VIdkdwWm9VQmJiV2NxM09RZ1Axc2tKYzdI?=
 =?utf-8?B?VGRsUWpaRkIzdUJJZUx4UGlXK2pyaG9LWmpBMkVqbE9keHk0dFoxTlUyUkV5?=
 =?utf-8?B?Y3VuVmhuU29VU0NBUUZTNlk0VXhOUlQxRk52S0M4eElpYzBna29UbEVvQ0N6?=
 =?utf-8?B?cUttRDExaVNVQlQySHR1VXhWUUxWalh5a1JnV0dIU2xoUmJNa2dkSW43RHZm?=
 =?utf-8?Q?RFB1n5JAfG3Mtf+8vajTDo1Uh2ioVwoGJQ92P9B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzR2SVRma2hnR01sdmpoQ2hDT3ZtdytqbFRxSHVFeEx3ZlBGNEZSZFE1bGl6?=
 =?utf-8?B?a0lGR09kTFY2YnJLQ0RzRWhDMFlJeEVvTHRFYi90WG9pak9zZ2RDWVdlVUg4?=
 =?utf-8?B?ZHZoV1RQUkVjcXRDWC9mcXk3QkRBQ0t1M3VSa3pNb1VsczB1elgrQVlhVCtJ?=
 =?utf-8?B?QUZLYloxVkx3Zy81UmYvMlBSSlZ6M3NvMjFKSFpRRDlhMERrb0lFTUo5d0JX?=
 =?utf-8?B?KzM4d3NqcHF1VWk5QnEwbFpQQUN2TUo0VWVJZWx3R09jZGdtMndaeFdqVzNx?=
 =?utf-8?B?SzliYU5PV2ovYUxCYkVST0xQNzdwbGxzOWFsY053cHpmNVpWT1VBamlESnFK?=
 =?utf-8?B?Q1Y1VVpFUTIyalE2SlhBMHB2RVI2MGJFMzA0WGxhU0NiQUoyTUFYdFllUEtL?=
 =?utf-8?B?NjhQYjMvazF6bU5ZOVA5N2RpUVZFREFsdXZpc2hYQlJXci9HcnliS2FWMWRm?=
 =?utf-8?B?V0c1ZFNDbHVMdjB4UDBxaTV6STdubEVmS3BqdVFzTHN2V3JZRXBvcWNTRVg0?=
 =?utf-8?B?K0s3T0sxbDZ4K3ZqUi9RODVyK3Vsd3pXVXR5Mk9UZnJEYklPaXcwekRlSGpM?=
 =?utf-8?B?d04rTEp4VWlPNUNwZXJRYUVWZlU2S0xoODdDZWlhU0REYW5oM1pBMFREeDVx?=
 =?utf-8?B?TnB4amZHbFRhQzI1a1BYYmNPbTlXYktKNWM4d1JFc09CdnJOeEE4QmVIbWtj?=
 =?utf-8?B?RmhSWmt5VFU3VjFzTXBqeUtGV2cxZVNCQTdHZWIrT0JpblhIODNNYjJyWDBr?=
 =?utf-8?B?T3F0aVg3cklrckcrMkxQN1owM2ZSbFVjZ2ltNWlnOUlWOXZVTE9iampmU2NO?=
 =?utf-8?B?eG84b3lRRGRwTU04dHF0NjlvTzAvTVludmZ2N3pRTVVTb2t4MG4wVlVwOXg3?=
 =?utf-8?B?aG1SM0pKdmRESlpaRkVKbEJLdkkvZHlDbHZpOG1RZ1l3ZnRtZllyS2RFOUJQ?=
 =?utf-8?B?Zml5TzdjM3YzK0xTa1E1UktkUFRXSjYwWkFzOHVRejBHWlpkZHVBK09VS2lT?=
 =?utf-8?B?dmhVQ1o0ZHZ2QU5sS1N2a1M3MnNSRTBoR28vTHlKNU4vT21RYUtpYksyQUpO?=
 =?utf-8?B?TGIwbTN4STYzcmRpckNKZlpFM3laUXR3YlEyODVxdy81QkdNOCs3SUxRTmpz?=
 =?utf-8?B?d1c2YnU5MkkrQWJYR01ReXJIdks5NkdFVHR4SVdsQUR6TWFuQXpwdkkzbEZl?=
 =?utf-8?B?WmZYYTFydm9YM3lFVzRCOHU3WWMrdVQ3blljY1U0enJUQUl1dE5RZWF2SkVO?=
 =?utf-8?B?Y0l4a25sWGFZN0FKbnpoVzFJbStablZhQzJiUC9XSWNaQkJJRGhLQWs0bFF2?=
 =?utf-8?B?S2RkRm5taEMwR1lYUnhNb0dncEViWHJEN3FkY05sanZkSlN0UFJ4MU56TDdm?=
 =?utf-8?B?NHhtMHUwZjdxU29XQ2x0dkR4aXVWaGJ4SlQyeXRVeFdoUktFQnRpdnBpTERB?=
 =?utf-8?B?azJhKzFhQWFzdW9Ra0JrZFlLNGF1N1d5Q2RqSERrVm8wVkRWbng2ZjNUbXl5?=
 =?utf-8?B?bkc0VG4wYkhRS1k0SUdMWGYvRlFMVXQ1SE9UNU9mMnJWb1JneGxsNGRUY1dp?=
 =?utf-8?B?WHVEOXRUWjlvSHVHb0NKM3c4bmVYai9xWm95RFF0ay9HRXJyZFVtMllCZHNp?=
 =?utf-8?B?Z3ROd3ZqalJLUUQ4UUNHTkRZcDNqU3JUMVhBbE9KeUF6Q2x1TTdMQUdnMUZQ?=
 =?utf-8?B?ZkJFaHpOTmtNbmlwUW9BdHN5c2FMSCswZHA2czA5NzdkUnREVUYya09tTFFl?=
 =?utf-8?B?SjVaY1lHcG9WR2lvMy9SUTNkZXJjeDZIWUtHT25zZFpqUTgwVUpaQnhHb3RT?=
 =?utf-8?B?a2NPdnEvci9LVGNCOForSmhvZThmL05ZUmpqRW5xWlMyM2VpNUQvWUVDdy9H?=
 =?utf-8?B?clVqMzd5QXlSeGdhK2FOTVdtSnNKWmp2SGN0TXRudVZ2TW5Zb3ZsSUJpMk04?=
 =?utf-8?B?L3liZi9XYVl3UkVZTFFmR1BFcTBMOXZHSHZqVHJWZ0FPUTV5OXZGSjZYNG1T?=
 =?utf-8?B?R2xKVzRkSDJjeXNxVmYycitpTUp1aDZJZ0Z0VDd2TjJIZ3A4VlB5NWVmOFJS?=
 =?utf-8?B?bG56NWJZRlVZNjVnN0RtUzJuZUk4Tk9lazVsTG8wRHdXUTBMQ1g3ZmJIWEUr?=
 =?utf-8?B?cnJSRklWRjJuTmhvS09ORFBydUZXV25ZNk5NUEFnNnhBWVQ2OUtBaVU1Mk42?=
 =?utf-8?B?Tk9BVXh2SXFyVU5TZ2N3WDhlbHpwMDdsQStWdGRuaVExa2N5VnpVNkJrblpz?=
 =?utf-8?Q?JmQkCQ7qGxdqkfgjO1TV3TTwBQS0Qx0n6ma2rfCn24=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e87269a-24cb-44d8-423c-08dd4c3dfd0d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 14:52:08.0304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hZs+A+tWF8XzG7p0xHQfVjRfoiHEvB5PJ+hMMrbKpRl7Z4xIrEcIDPrV2gYk1dem/3aKixxiW9ZGb23LDY2Ln+hHiQA0l2OdefEJBaKvdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5390

On 2025-02-13 08:25, Gabriele Monaco wrote:
> On Thu, 2025-02-13 at 14:52 +0800, kernel test robot wrote:
>> kernel test robot noticed
>> "WARNING:at_kernel/workqueue.c:#__queue_delayed_work" on:
>>
>> [    2.640924][    T0] ------------[ cut here ]------------
>> [ 2.641646][ T0] WARNING: CPU: 0 PID: 0 at kernel/workqueue.c:2495
>> __queue_delayed_work (kernel/workqueue.c:2495 (discriminator 9))
>> [    2.642874][    T0] Modules linked in:
>> [    2.643381][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted
>> 6.14.0-rc2-00002-g287adf9e9c1f #1
>> [    2.644582][    T0] Hardware name: QEMU Standard PC (i440FX +
>> PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>> [ 2.645943][ T0] RIP: 0010:__queue_delayed_work
>> (kernel/workqueue.c:2495 (discriminator 9))
> 
> There seem to be major problems with this configuration, I'm trying to
> understand what's wrong but, for the time being, this patchset is not
> ready for inclusion.

Patch 1/3 has been ready for a while though. Can we post it separately
for inclusion ?

Thanks,

Mathieu

> 
> Gabriele
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

