Return-Path: <linux-kernel+bounces-433657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556119E5B52
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5332859CE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45573221479;
	Thu,  5 Dec 2024 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="A4+heylE"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020073.outbound.protection.outlook.com [52.101.189.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087DD21D585
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415941; cv=fail; b=Gcaa65ylTmIifqSL7gztBy+PqrnEtpi4k2KJLMUy4NZKGR7racmB3ksUcly5LCvI/0lJmCCDVZes1wyt45eqE1iPguHt64tsVKQgtezwQuoXenL0JQoZW2esZ63twliyohFtkoL89NsdFyoyesC90OkNe6oXQxQqmFsDgrZT5Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415941; c=relaxed/simple;
	bh=pdzsZ18nNqzkHb/QlxW150ldokT7DCbM6DEpLW4/EBU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q0Ati8cKi3HVn2Yn02Ui/GeqT8FZCFuqMQpZnk2c+MpnDhzx6pJSQOUOmJg0Bj5tQsNLjPhx07uZ/jZE83aYxqu+gAodRu2xh2yYlj/7erbcLdu0A++3HdCAzpURO50m0v3iGl28p0BsSHcRkEs5C5tFkBLRJSh3Clerj4EsHpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=A4+heylE; arc=fail smtp.client-ip=52.101.189.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfjsyQFcA6hToVHarA3aNJb/x/6ZpEP4HI9ncA7v4vufZhAVHULcFQFrQ/TJpoH3ox6Y1OA76CKTKeOM+t7tN51X8zBpcljAXtUitXQ+oLKXdbeyeTtSmJ0zLy09pQNC2XIs6mzQmLrd7wXQELoK3vR8bdE/DfFdcQ2Snqw/MK08DA1XZE9fOFqkYilcY2ljzJMFxIxYoS+KAqcEHdozXpu4+V3Hlw+zDcx0BJjHAqQ/U5FYZziT68Xu4zlwXBMgVx5qPlbkY8Puo0SoYNSS5gMrkpqpcNX3pVnau9ncZygBax5zne8ejEcQEnUbxPM+K4uI3UP0BYkjBWaoASPHPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnM4u/GDqKiyw4M1VqQBEI92MauzLhM5KrQw7v7eQTM=;
 b=TmX1zI8GdJX3L33B+KZWPLfmSP4QbN4j7essGZnZ8+abz2kFaVFkEul31O+GscxX/zQHc0K5qHnv5hp/FGg9Om2SwaM2Qi457co691bXFAmhH18UZXkBnuSV9vZ6jqoU70pt7k/tb+XCi1y+yRYP8B7UzKCrAYXqOVpGWVlmjrMfyj/5S/ZQO/kdU4fZKcGKlKqhkWsMnTfekFJPi6kPdc/qwz31jlIhsMusSljkhSRHrdJFaawjzhKUdOQye0YMvHcED8mdJbUngUDq6sLnlZLhKid2h9uyDn3ogeKX/Htquth3K+w3nOKaGvJeKEqtzzolIFGGl//yHD401RO1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnM4u/GDqKiyw4M1VqQBEI92MauzLhM5KrQw7v7eQTM=;
 b=A4+heylEBeSWZ9b3/BRxOH+icYEV5GXtU2fTr43joXHkemcYwqzBfSOUMSv6x8yX7dYx5cg9u4l/FQVO2D8EVm4wJ+n9n/2IdwOWtuIgh8yUAuVyuqI499TCT4xmrGLsda6IT6WhZFQFyhiTNHTPMmJAZkDQCPKmH41eA9wpUlS+LXbG0p4HtzHg72MnRxSjfm4XIHCRuo3YiJAVpp9ElL3bKnjLgMqnZ/QjlSiFvQoeQ/NY4tP3Q8FnQuqbaSg3jKRnkR2moOsD3xe6VeoHYsLlLZC9ZsUh9IrDuQkdgmG/p2D5DV0qF77FK8vbhZJ0TIDnRSH6ybI+pl5o3Kz4yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB8781.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:58::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 16:25:35 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 16:25:35 +0000
Message-ID: <5ba975e2-06b9-4b98-bece-d601b19a06db@efficios.com>
Date: Thu, 5 Dec 2024 11:25:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Move task_mm_cid_work to mm delayed work
To: Gabriele Monaco <gmonaco@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
References: <20241205083110.180134-2-gmonaco@redhat.com>
 <4c067b75e06aadd34eff5b60fc7c59967aa30809.camel@redhat.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <4c067b75e06aadd34eff5b60fc7c59967aa30809.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0161.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::17) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: acc36043-28bb-4afd-8f2e-08dd1549729e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmsxNkpNOHBKVmhVMmRtRHF2SVd1TG02Q2ZkeW9oSVJYN2NZY1RlVDNjR1BS?=
 =?utf-8?B?S0RaUUFyYlh2MVdRRlFlQlBielAzcFd1czdtRFVFVHhhWlYwcStBc1I0TUhq?=
 =?utf-8?B?VW5LL20zZFB0V3ZmY1BBbWloZ3h4WHVQK2VnRVVyS3BpeldMR1laQ204QXpt?=
 =?utf-8?B?dU5lMk9QVDNCTExCMTVRT0J1d2JGaisweitzOEdPKysrWlpTaXBTUE1vdDFK?=
 =?utf-8?B?NnhDK2pBbVc1YnFqVVY4NGUybkdyLytHZGxrNFZROENZcUQ0cnBoL1h5Q1ZU?=
 =?utf-8?B?ZjdnSThXMkxvOUphRGk4cTQzVUVYcFNYNGlWakZ3SThobGx5c0RVam9XK3VY?=
 =?utf-8?B?QkFKajRqMU51NDdvRjVVUlRmU1JVQWNSeWFZWlJOOERGQis5dURJNFJodzVs?=
 =?utf-8?B?RzNORFhhdlV6YmUxcGdBTzhwdlVNY01FWW5FSFBPcTVEVFBLZHdPR0FURWUw?=
 =?utf-8?B?Z1V5TmtLejZlV2lPN0o5Z1hYc2d6ZG4xWjY0Qm5YK2Q1R1l4b0ZJRGtXSzJ5?=
 =?utf-8?B?VjlNOGpSZUd5d3lsSmV2SHo4a0xDRGRFaVkyUnBXUzdwQUxzRGYzd0RwUG5P?=
 =?utf-8?B?ZjZOdzZKK1VEVlRsSEQ2SmhRVE84RGJsa21jMWFKUkhFcFhwTzV6UUhYQng5?=
 =?utf-8?B?RllCKzI4K3kxWXZMYkNnUnYrYnlYUUE1N0xDNlJDYjdOeGVzUVB1UjdxK3ZJ?=
 =?utf-8?B?b3dwcEEwMHorOXJJTVZGV0Z1N0M5S0NQOVdOTE5nYlhVVlhHeWpWUThhREJL?=
 =?utf-8?B?c0cvRVAvMnlSTllXakpOL2ZrT2szdlc5S09IQ0NnbGh1V0cvTVZvTnRGM29U?=
 =?utf-8?B?YzZMcGhDeEwyTWR1d01sLzU1Y1IyeFVyMjB5aTJGRWxrd3NkSnEzYTVJWHZS?=
 =?utf-8?B?K25XRDFNVVhJN3BNVmZFVlZEMGFNaFJsY1hkZ3VHbGN5N3VxenJidEg1VXBK?=
 =?utf-8?B?Mk43Z2g5UHBKdzA2UGJmZU5LcWtDSG1FM0xOcG9TNEp4RUVFUFU3emZVd2F0?=
 =?utf-8?B?MXFGTXZKeitZTjhaMzdRNElMR2w1azJrN2llWXFUZEYwc2ZEdkFsOERRNFIy?=
 =?utf-8?B?YmxpWGhMNnQxNTNjdkIzSGV3WnpPbldnYllleXFneThXSmhzUUVVMVBhRG5B?=
 =?utf-8?B?SnB1SDlBcDJvNS9pcHBZNnhUZnJtNDVaQ1Y2ckR6cC9odGFIcG1yUnBwMU1Y?=
 =?utf-8?B?RFNzbHBKSU9rdENpbG5UczlSenVKQlY0Sm9LM0pjSThMdzZGYk8zVnlmampo?=
 =?utf-8?B?b3ZGWVgrck5ZRWY1K2E1dWovTUNCNWVEZHBEczROZ3UvTWNnbGlZLzEwRnpG?=
 =?utf-8?B?UTExenRBN29sWHR4djkvZ0VtRHVmQlJSWXdVTGg5dWswK1JUazJnVkVOU3dN?=
 =?utf-8?B?YWFmTlB1eGE4dmZNRS9kQ3c1WjQwTUdKVzdYeVEyeC95ZVpsbXFvdkE1T2hI?=
 =?utf-8?B?Y25pcDQramlRSkE2ai95ZjVVK0NoRDR1ZWRBRVpvSndCMHpGb0U4M3Z0ekFF?=
 =?utf-8?B?R3YzVzYwTUxzeVJidFIwK2Jua3ZkQ2gvR3AvOWNtQjl0YitRMFFNMnorWDZi?=
 =?utf-8?B?M3I1b3FEck8yc2FEaHFUdllkRTRPOUVlaFpVd3FFd2RJbjJFUk9YcUdvK0xS?=
 =?utf-8?B?b1JHM3cvNElHMCs4ODg5RXpUZkVMYll4SVJBVU8wc3lYZEM5QjE0L05XMERD?=
 =?utf-8?B?SEZVQ1lpOUJPZU5QNVAxMDFVS1Y5b3NXVThjRndnZEE5d00xL2Jtd2lwaS8w?=
 =?utf-8?Q?KWsWLAFD+l2keVujSo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHRMeW9EZW1KQndnUkwwVHY2S3duSWhKblpYTEd4ZTRyV0dVQ3dCYjJYY25D?=
 =?utf-8?B?MnhsQUgySnZUSFRxY21BeGFyS09KMnRDY2NDRzliUHpBNEpPZzl0bWRiLzNj?=
 =?utf-8?B?a2E0N0JvSkY1Y3lsQmhBcStoQlo2bldKbkpOR3ZSSERWdlRLalF1dmJkaDZU?=
 =?utf-8?B?bFpBdjkyTUJjTEZDNmd3aGRMS2NzeTNvZkdIcGdTa0hqRnU3c3JFVUNNeXVJ?=
 =?utf-8?B?RGs4Nk5MTWdCQktodHp5eTVyajlUNUhJbmdhSnRMWDNGc0szZWJIYjZ1MWxI?=
 =?utf-8?B?VHNuYWswWldtV0RGajE0UVV3OXJ5eTAwYlBQSTRkNS9WWkc4Q2lVVnpJcnda?=
 =?utf-8?B?dkJtWTd3dkZlQ05qQ2N2MXFkRXp6MjV2dmd3YVRHMnhjOC9VZ2RLc0QrdlpX?=
 =?utf-8?B?U3Frd1JxREl5eFdKZXJwK1BhdVRyR2VCM3g5TFNaR0JZemxGTDdDWGswRkxq?=
 =?utf-8?B?SXpnNVNTV0RaWUlVcFJGelllT0IyTCs0L2lLSkdKK3lTT0NFNXlSUEJZK1or?=
 =?utf-8?B?UnFYSlp1MGNQTkk0QWI0V3RvVGhpZ0M5QXMzdXU5eEJhS3YzZWh5bXd1MTRu?=
 =?utf-8?B?SHF2Z2xTQTJFSVNVY29FRnVqcW9XTU9iSkV5Ynd1aGNlcGFyRmtzbXR4SGFj?=
 =?utf-8?B?L1NpRE01RGM5V0xzNmxYWlNjbWQwaDg4eG85Njk3UWJZODMvQTNtbEFtZGZH?=
 =?utf-8?B?Yit4ekhLaHJGNXZKMkt5d3pBZmJGU3JNM3NzVVFtQVdJbEZJQysyaHZva1lj?=
 =?utf-8?B?WEpoeGRpNXpzQTNBVnVGUXNOaVZEUytCa0NSM2hYanY2K2xiUndMOGFRN24v?=
 =?utf-8?B?UC9Na055R1pLa0g3UEJMMU92NllBNkhtNFZHQisxRWFkenZ2R3VmYWtnNWhW?=
 =?utf-8?B?TXRZNHBSNnhuMDB3T1k3aG1iUGFFZElxUGFTVkxicXB1MmkxbTZRdXBVbEJl?=
 =?utf-8?B?aW05Q2lVZWg4QVYvYlFheTFHeFlMRHQrZnFtL0UzVHA4OVNESnpyaUpwa0tl?=
 =?utf-8?B?UC9JTCtLd2l3T2FWYWVVdSs1MVpMZTVCOC8xakRqU1Uxc210cWlaZ2xXcU5R?=
 =?utf-8?B?dVEwZUp5QWJrVmFza21Zd1BubVhGSXV6ZHU1UmE2TVhOK0xmd2gzOGkrZ3FG?=
 =?utf-8?B?dG1Zdjl1R2ttY29NbUVFSU83ZGJ2RjM1dkFGNzRLUi9ud1pRbzlSbmQvRVFl?=
 =?utf-8?B?ZDV4Q3R2L1E0TERwRHMwdlZKWXBLaTVoSDJxb3ZMSTNCVjRvWkNaU2Y1T0lp?=
 =?utf-8?B?Z3FNZlJwOTlwWWFlOVo2ZlB0ZG0wL3VBTlJ1S2Zud3VTSUtySWNWampTL2E1?=
 =?utf-8?B?YjVlaEVzTy9rNmo3U0pRWDA3NHhoRGNYbTI4TWVQaitIV3p6UjdueXhjcDFi?=
 =?utf-8?B?UjY3RDVRTUh3RDRLY3dkQ0ZTeWdXWTNlei9VSG5mTVBmVjFpd2xCT1pQdVFw?=
 =?utf-8?B?M2Z3SDE5aXI5dURYcFdvRldNNGpZSHJPSCtzVGQyWlRNUk9sd0VOb3lGZnh3?=
 =?utf-8?B?Z3BDd1ZYWmFMNGhZRUNsdThQc1Z1QURNd0tnNHFqZ2hQOUhtbzdjQTlsdHdx?=
 =?utf-8?B?UEtWN21qWjZUYWJCRTFVRXFIWW5TNS96TXhxUngyQklvQVJ3emZ1NlhYQXJ6?=
 =?utf-8?B?VTBFa0E2cHVyMFRRUXp1d2JHK2o3MSsvVFc3RFR0Z1pCbGkzM3JabWc3Rmpj?=
 =?utf-8?B?RTdpT25FUmUxTjZFZU1BUk5TQlEwSm4zb1J1cm0rQSs0RWozbDdPK2Y4WmRl?=
 =?utf-8?B?VGlKcC94MFhDb1NXRTF2MG5Eb0VEMWg4NWVnb2VGUGloOWFDczZQZDk2WUht?=
 =?utf-8?B?SE52b3RjUjVoVjZsV2ZCVThoaVZ4NVVMbitDaGYxYU92Zmp5QTdVbGN6RXV3?=
 =?utf-8?B?anBtVy9Rc08raUdyZmRTRndMalArMktBSklKMlkwNzY5ZGo5OTVKSGFDUlpS?=
 =?utf-8?B?bzZUYzVvNjMzeExIUEZRTk0yMWZFd2RNZjNjMkgrV2Q3ZGpuQTV5WmVvNUEx?=
 =?utf-8?B?SzY1eGJ6aVBJbE5mR1lYT3BLQzVpVTdWeUtIQStqUmM4b1RHamxUS3ZHQ2Fq?=
 =?utf-8?B?RUFCQ1MzMG4yTVBYYmlNenhlSEJlWGNBK2VaQlN2UHFIN2E3NUhWUTNsUGly?=
 =?utf-8?B?M0NiNXUzc091dUswV3JVQi9pUndjRkxlbyszdFRhZ1lkR3AzT3kwcFlBVzA4?=
 =?utf-8?Q?tVJds1Iuuf+oRl6Ay9rz8G4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc36043-28bb-4afd-8f2e-08dd1549729e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 16:25:35.7533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/4ZU5Zii3C5AvPKp82ypyxFMLiQZ1EszJ+yWXHuOcd5v1TMBcdTU72eaa5dVZpAV30ip+rHjRMiY3g4Ap4lzVN7ltY4+WwMVAc7rkdpNWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8781

On 2024-12-05 09:33, Gabriele Monaco wrote:
> The patch is fundamentally broken since I somehow lost the line calling
> schedule_delayed_work in task_mm_cid_work to re-schedule itself.

Yes, I was puzzled about it when reviewing your patch.

> Before sending a V2, however, I'd like to get some more insights about
> the requirements of this function.
> 
> The current behaviour upstream is to call task_mm_cid_work for the task
> running after the scheduler tick. The function checks that we don't run
> too often for the same mm, but it seems possible that some process with
> short runtime would rarely run during the tick.
> 

So your concern is about a mm with threads running in short bursts,
and those would happen to rarely run while the tick interrupt is
triggered. We may indeed be missing something here, because the goal
is to ensure that we periodically do the task_mm_cid_work for each mm.

The side-effect of missing this work is not compacting the
mm_cid allocation cpumask. It won't cause rseq to fail per se,
but it will cause the mm_cid allocation to be less compact than
it should be.

> The behaviour imposed by this patch (at least the intended one) is to
> run the task_mm_cid_work with the configured periodicity (plus
> scheduling latency) for each active mm.

What you propose looks like a more robust design than running under
the tick.

> This behaviour seem to me more predictable, but would that even be
> required for rseq or is it just an overkill?

Your approach looks more robust, so I would be tempted to introduce
it as a fix. Is the space/runtime overhead similar between the
tick/task work approach vs yours ?

> 
> In other words, was the tick chosen out of simplicity or is there some
> property that has to be preserved?

Out of simplicity, and "do like what NUMA has done". But I am not
particularly attached to it. :-)

> 
> P.S. I run the rseq self tests on both this and the previous patch
> (both broken) and saw no failure.

That's expected, because the tests do not so much depend on the
compactness of the mm_cid allocation. They way I validated this
in the past is by creating a simple multi-threaded program that
periodically prints the current mm_cid from userspace, and
sleep for a few seconds between printing, from many threads on
a many-core system.

Then see how it reacts when run: are the mm_cid close to 0, or
are there large values of mm_cid allocated without compaction
over time ? I have not found a good way to translate this into
an automated test though. Ideas are welcome.

You can look at the librseq basic_test as a starting point. [1]

Thanks,

Mathieu

[1] https://github.com/compudj/librseq/blob/master/tests/basic_test.c

> 
> Thanks,
> Gabriele
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


