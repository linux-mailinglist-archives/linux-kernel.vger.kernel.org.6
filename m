Return-Path: <linux-kernel+bounces-402630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5175C9C29CE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 05:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750851C21025
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 04:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B364813AA35;
	Sat,  9 Nov 2024 04:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N5zqiLhb"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCB51114
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 04:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731125054; cv=fail; b=tIFeOP1onsQTI7HKams20Ol64BrZyvtFkv7C5qhYroZcnZ94/0HAvjR7I0o+6ArtU0hjBGee2E99Kq4Rk06hll567sp1q26bYeHGbLMk5Y3QnIOY9hUBymuCtc2/spPhvKZeO/G94VtFMGKf/N2tvERpbCq42BXTfa5bN+A7HO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731125054; c=relaxed/simple;
	bh=c6gEktyPBaaxhPbzHk7dBK8N4gDrmuTeVD6x7o6hFrI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W4t4MGzxJ8LE+EFI8/Ej9f2Ikvfi6UIg912C3RRKwfSyaPA1tINoiBYCNMxug53ObD3KovEB/6yTxKGSGSpMJJsZFYq0sttHveKaDvhqAm+/DHazQaqsvtcSA0YxCO5rR+G39oZzBb+U665zJk2tCI8yh39yLZxiXnD7XR5WViU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N5zqiLhb; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+p1TCzXbb1DbLV1R6X95TEworAcnHQvpYLI4wB6TwUM1qeDKSSM7q57dc7ho2jFB6kRuxK5j10dS3ZW+3B/IZsBu5T61JF3korkLjjk5fXu9eSp2yhQq4l6gJeVVFtulTbIqDuzhRTxgOeJVoc7MYa6CQ+getcvSa/GkY926xHC/Q+baTJK+kCS+hRCBGjS5wI2i1IYEoyBCDtprC4JKnYHzjAaCQgdZTi78u19lIRzv32zu/4XfrvMMIlDMMsYJQaLh2UnvEUQ6C9kzzBQBrVHmk0ZKDSW1yYeo/m56sw3WcHx4oaDxClb2owUbdo4xq/VBuD6NM6hccr/bumaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naD7wgkNY+uVHITwWR8DQO6H0WzFQU/JbGfME1tgKL8=;
 b=q0XanpZENW9BukZW+zO1DBFvqX1hoDS5+CcUzczFdi3O5tCqZp40uU8GY93lXQpztXojqnLmjjDUmhMU0Ap1e3IH5MF8c/Dmg9aFNXmjHwpnh/QOkJT3Ao03E8O1RRBkDDs3M6AFI6p5IUBqpGUDlEUEKVQhPc2QZzhvL9CYowAKnUt0l0jyA2IKn9eWKimGXRxtmGe9QgClx9ofwcfDCegmKHls1Me40trnrqZQFgC4YtKz8NQYvxoyeg45ZmQcdivPBFk7oRp1QZegjUAf028OhTjB4CtmeujJAMGvawXsQOND+nDi02yRh8HZ86g+dSDAxJPtwHW4nIiliR0m1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naD7wgkNY+uVHITwWR8DQO6H0WzFQU/JbGfME1tgKL8=;
 b=N5zqiLhbBUDZx3WPJQdl/N/hN6oAOa7vkwof0bCP7L/OAjhbodwuHFkDivWgMuUNi3NTbU15LYc+IZGfF5mqszv4mJKuhzc/Z7LhHl4SjVWacWqffJt0z/+A2cScqqUzm+tDytzS2UuKSiDuN8ulEkhWs9MWNji87V6rKH6H4fE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by IA0PR12MB8715.namprd12.prod.outlook.com (2603:10b6:208:487::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Sat, 9 Nov
 2024 04:04:09 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%5]) with mapi id 15.20.8137.018; Sat, 9 Nov 2024
 04:04:08 +0000
Message-ID: <1794be3c-358c-4cdc-a43d-a1f841d91ef7@amd.com>
Date: Sat, 9 Nov 2024 09:33:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sched/numa: Fix memory leak due to the overwritten
 vma->numab_state
To: Adrian Huang <adrianhuang0701@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Adrian Huang <ahuang12@lenovo.com>, Jiwei Sun <sunjw10@lenovo.com>
References: <20241108133139.25326-1-ahuang12@lenovo.com>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20241108133139.25326-1-ahuang12@lenovo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::7) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|IA0PR12MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f985bb-3a02-452e-3417-08dd00738f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFVsUUdDdWhkSnZ2TzZrdiswSCsyc2hmaHIzZDFQWW5sSlBsTTk3eXVnaGxG?=
 =?utf-8?B?ekQ4aHdocGpTdTFnekJMQkdSY1RwZkFCL2VjeG8yUGlWK2JxUVFWbXhUMHB4?=
 =?utf-8?B?QU5hUzRjQjVRWHdldHZYNVFGV0JsNmxjamVZM2lodm9oVFgza1BuZlhPc3Bq?=
 =?utf-8?B?Y0h2TjFtU09WSTJrT0lTWFdia1ljNFNPUVhHek5PMXZ0clFyekEvWjFReHZ3?=
 =?utf-8?B?R1VuV1JNYlkvekJmS3FBWFg5b0FsVnVYK1RsZW9pK214UmNrd2ZlN1BxdHJy?=
 =?utf-8?B?c1FneGdWSjIxR2N2WjBRM1NVN2ZRV0ZTdG5KVS9TUldoYkZqSkVTVXpjUjBx?=
 =?utf-8?B?RFcxMWtpUnVlN2JqUVRGVjlVbGJoeUcyZURrMFFOZDZlYmZrQUhNMVI0QVZx?=
 =?utf-8?B?eE51ZjBKRUFmOHNWcVRYSjgxU2ptOHErZFhPdkdhcGRRTkZCWXJlZlY4c1dh?=
 =?utf-8?B?SnYrTjlka1ZRc2VXaVhJMktMOHUrb2dtZEFoK21OVC8rcXdnNk5jbDkxSDRL?=
 =?utf-8?B?aE5JQUFwaXlZYVVzUzJrSjhVUk9KOUJHNWFnQ3c0TWNJYUVvWDhzMGlVakRu?=
 =?utf-8?B?NG54QXVRbkQ1R1B1OEI3QmsybDgzNHRBcmJWTlZVQXQwR1RMczhDbTRIZ2Ew?=
 =?utf-8?B?MTdrR0JFR3pLNzhkMDhJUzUwVVFhSmVLMTR6TGhyczBSL25PL1Z1VWhXa3ZJ?=
 =?utf-8?B?dFVlUVJFc0ltQTZZbFd1Y3ZKeVA0N0ZqRzdHTTV5QzFmKzNjL05LODY3WWxJ?=
 =?utf-8?B?d2hhQlFxWHpkZDJkdng5YkNxbW1MZkhhTnUzOFFienE1QnN5TDJLUFNOeHhr?=
 =?utf-8?B?NWpKVzVmbzB5QTFwcStBMVFVRDVwMGxlTnhrQVVyQnFaekJlbkdiSXpMc2w5?=
 =?utf-8?B?clA5Z3dTQTdjckk2dnNKKzJ4a1Q1bFV0eUhZaDdNTnNMaXQyeVhUUjhyenlk?=
 =?utf-8?B?NmpSYmtYTFRUZDJXb1VCZTJlOEIwSEZNeFNraHVoTnBxczBQTWFZZ3ByZ3J1?=
 =?utf-8?B?RS9VcjlWUjA4SGdhVlFRaDdUTm1zYXRBYnVIV2M3S2lHMkdiREg1N3E1V0NS?=
 =?utf-8?B?eVNyRllzRkxTZG5TNlpkTHN2Wkg1SFdqM1Ivd056MFhxb3ZnVzRrWXNEWHJX?=
 =?utf-8?B?RWUxd0o5WFhreTB2K3VnUHZyTWNDRUpXaVdVK3pHeFZrYXZ0WHpXNnJPbllr?=
 =?utf-8?B?ZVVhemUyc3g3dWFMZ24wVUtLbkYyM1Z2czk4eXpYMjBObHEzZHovRFVjSDBm?=
 =?utf-8?B?WVNraGJySmE0M0U3cnZSOFB2T21sRW9ycEw3WWFoOUFlNHVRcEwzVDA5eWlJ?=
 =?utf-8?B?YXZ5L0dQSnpnNWJYSGl1eEtJNXBQVE4zM0xsZjhlZUQySVVnUkpxblNmbnJ1?=
 =?utf-8?B?aDAxSG1tcGtOcmNBaHlHMGFONHd5R1NZZlF5dHlZcjdEU3M1NFh3YUdLbklL?=
 =?utf-8?B?dUtiaTVYM3pPZmZmc0VxYi9lQ1dYejZDL2pqbWZ3YXZpNytZbVRqUGU5VEg2?=
 =?utf-8?B?MzBGTm0wR09hM3lQVXpxOVB0enpPU0pJNVJVN3M0ZEFEQlQ3enYzaUt4cVZj?=
 =?utf-8?B?UFJYekdMQ0VKS2JBclcrVExCcmt6enBBcTZqdzJFeGJ5bnZDK2NTdGIyL01k?=
 =?utf-8?B?RWxtQVNEMDJZOEFjNTkvbW5RdzVhM2hOY1Bna3dobFNvdlJ2eWQxTzJMQTVh?=
 =?utf-8?B?SlM4REJDSWt3TkNKbDhGU2ttcnJlU0Q2QVltL1oxbUVmdUlpSVVQNFdSNDZQ?=
 =?utf-8?Q?iBHVid/dg4u5AsVSpA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUdwU0dNaDA2QmdxVkpDMldSOXNuK3p1ZTlRWGN1TUNpNXZQYTl3cFQvMk0w?=
 =?utf-8?B?UXdqc1R3NGhHZXFyQ3MzaWc2RGNrWXd2b1NvRnhXRmZnRTJlc0xCRUF1ckJ5?=
 =?utf-8?B?VnBpa0c1SlpGKzArTFZwc1VyOExIMkRGRmxyRS92MFJXRGFHUDJrU2QzS2Qv?=
 =?utf-8?B?Mm45ZjdFLytBVWswQ2c2U1F3TExLbDAxOHBWQWRLeXRuUFBoZHltaXVBSmZP?=
 =?utf-8?B?Z2w2VTRUU1o2aVFhM09YZ3NIaWxiL0cxYVN4Y3pRd2RSdmZka1BERzdVL3FS?=
 =?utf-8?B?MForQ3NLRjV0Z3owWC9SbFZPc1M4WFpLVFdreEtTZkpBNHNPVkJhZnIyYlN2?=
 =?utf-8?B?L0pSdzZPV0xNZCtGY3RmeHRTU0RFMzhhYk5LelNqT3lYbGFOeFZwa2w5WEU3?=
 =?utf-8?B?RFIyMksvU0ppMzJxUTJzKy9sZUROQ0Z1WDJiQWN4dlVBZ2REMCt2eWJ6eDlE?=
 =?utf-8?B?UXgzQ0g4Ky9MSXVZL3VJdEF3M25WR1JRTXFzTmNVTWdSc2VzWW5PZ0RFNUx4?=
 =?utf-8?B?Q0FhREdyUjBrbDJ3R1NscTZhZDg4QlorUkgxQ2tTdXg1ZVdqVlpIVlFuYVls?=
 =?utf-8?B?Lzdrb2MyeGxQZXhsUkIvZE92cHhnZ3k4RXlkWi9hN2JrTUx4ZzhhOGwvT254?=
 =?utf-8?B?VUpJUHRsdGJRMFdCZy9zVFRMV0MzcW16MEV2TTNqOVdneVAvSVN3Wkc5aVV1?=
 =?utf-8?B?M2VkK3JuMGZ0ckNKdHNNY0o3V0xEUHFEZ3NycTRIWU9Lbjhndm9VQi9ZWDhD?=
 =?utf-8?B?eU1BcU10SHVMM2U0TTRRME1RcnpPY2hXZkcxOXdPU01GZ0g1MkJYTDlENTFN?=
 =?utf-8?B?ZXdwM1ZrYnlyNjlieHRBRno3OWhJelhwYU9yZUNGTjNvYUg5cFFRVGJCSlJk?=
 =?utf-8?B?Z2JERVFZYldLOHFvVGZaZU5xRXBrK25BczllMnBTdlRlZyt5aDI4UnA5NHZE?=
 =?utf-8?B?K3I1amVmdE9sQ0JERHlFUEg4akxLSTNKL0ZTMnhCYng5U2w0V2NwNXZmVVBr?=
 =?utf-8?B?VklHUTR0WjN3bmxXNTYzNDdLcWtmR2lCd0t4RG1qdFV3QXV4aGFCL2xMNUJ0?=
 =?utf-8?B?VjdrZWluM2NTL2NxeU5vMVp3R2swazI4SzM2T2tIS3FhU3BCejc5YnI3eFN4?=
 =?utf-8?B?YlNZRW5PeTlMa0gyZmZ3UjlubVYzeWpVdUJPVkZhenBFVmpjdjZGVkFXaGtR?=
 =?utf-8?B?NmkzSVpqTXlxRW1Dd2dYRG1JVUkyYmI5d1J0eWFoRUVlU2NpYVJlTms0UGxE?=
 =?utf-8?B?eWs4bGF3ZWxDbXVOcFcxMnFGdFNFdzZKMzhoWUI3YjRHT3p6cXRSVnRna2Js?=
 =?utf-8?B?M21WTUlQZGR3aTQwdEVEdlNPQ2U5K3J2WUlITTVTRmZLc0RHbGEzdmVpeDRy?=
 =?utf-8?B?Q3hNSUxRbnM1OEkvc2pjQ0xuTXZHT1J1Rk5Ibk04WDFiWnMxYzFHQjFlNjdY?=
 =?utf-8?B?c0taWjRuZ0ZmVTFVWlpabi9ScTF3cEsyZ2xKdmRWT3hOQk1hQVhXMzJ2cWxp?=
 =?utf-8?B?UEZtRmdmTWxCVVBGa0Z4cUpTSEp6REVnWVRPQ2szUE9WMXNaSjBBZkRpTmVu?=
 =?utf-8?B?bHVLb3JBVHhYOG8xK3NpZEl6WUR6ZnptUG9GMjdPbVk0TUV4dE5VeE92WnVz?=
 =?utf-8?B?UzQ2bFRDVStaQVE4MmQ5alhzOGdoR29wUzVhenVIZDEzYVo5ZlY2UjI2V21j?=
 =?utf-8?B?R2tHQzQwN3hpMHZKU2hBMzBwMUU2KzdCWjJYendMNGpBbHFtQ3pmRGppcVJE?=
 =?utf-8?B?Z25ReXBJZTFjbmwxbzk4UUp4L2ZPcXB3dEowV0VpUFFNUHhWMG1ma3ROZGV3?=
 =?utf-8?B?YWRsbEpHQ2VIeDNBUEpXN2w4S1dCL1dGNHpKRmVKVk5lUnMxRWg5by9Qaytn?=
 =?utf-8?B?V3o0WXdyalFVbzRSeDY5Q1FLUWFLZityeHpGTmtwRWk3bE1ZcGRyc2lKckZF?=
 =?utf-8?B?L1J0YVh2VXJrNnJuNUthV2R2YzhFSWpsQTBIMWVVb01GRnQwaWpmYS8xekp6?=
 =?utf-8?B?SXN5MWh2Z2c3aGQ0THZ4SnREM1o5ZUNEcWVzZlBsNmlzQTJPYjNhR0ptOGdD?=
 =?utf-8?B?TTlUTXBIMFNBSDVNUUFVa0c0aTVFQ05KUDNFalJPZUlxWnYxVTlWM0FvdGla?=
 =?utf-8?Q?35tWxO3QZJCK4pvPUahoUyv5D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f985bb-3a02-452e-3417-08dd00738f40
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:04:08.4765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kyF+eC6WUSHypBgL1awnL4hwy47LNkLyD3wnb00IYy07uOASDAN2YL/O5jYvKSsRQvhsbuPxmAimLnWJ/cVBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8715

On 11/8/2024 7:01 PM, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> [Problem Description]
> When running the hackbench program of LTP, the following memory leak is
> reported by kmemleak.
> 
>    # /opt/ltp/testcases/bin/hackbench 20 thread 1000
>    Running with 20*40 (== 800) tasks.
> 
>    # dmesg | grep kmemleak
>    ...
>    kmemleak: 480 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
>    kmemleak: 665 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> 
>    # cat /sys/kernel/debug/kmemleak
>    unreferenced object 0xffff888cd8ca2c40 (size 64):
>      comm "hackbench", pid 17142, jiffies 4299780315
>      hex dump (first 32 bytes):
>        ac 74 49 00 01 00 00 00 4c 84 49 00 01 00 00 00  .tI.....L.I.....
>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      backtrace (crc bff18fd4):
>        [<ffffffff81419a89>] __kmalloc_cache_noprof+0x2f9/0x3f0
>        [<ffffffff8113f715>] task_numa_work+0x725/0xa00
>        [<ffffffff8110f878>] task_work_run+0x58/0x90
>        [<ffffffff81ddd9f8>] syscall_exit_to_user_mode+0x1c8/0x1e0
>        [<ffffffff81dd78d5>] do_syscall_64+0x85/0x150
>        [<ffffffff81e0012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    ...
> 
>    This issue can be consistently reproduced on three different servers:
>      * a 448-core server
>      * a 256-core server
>      * a 192-core server
> 
> [Root Cause]
> Since multiple threads are created by the hackbench program (along with
> the command argument 'thread'), a shared vma might be accessed by two or
> more cores simultaneously. When two or more cores observe that
> vma->numab_state is NULL at the same time, vma->numab_state will be
> overwritten.
> 

Thanks for reporting.

IIRC, This is not the entire scenario. Chunk above the vma->numab code
ideally ensures, only one thread descend down to scan the VMA's in a
single 'numa_scan_period'

     migrate = mm->numa_next_scan;
         if (time_before(now, migrate))
                 return;
         next_scan = now + msecs_to_jiffies(p->numa_scan_period);
         if (!try_cmpxchg(&mm->numa_next_scan, &migrate, next_scan))
                 return;

However since there are 800 threads, I see there might be an opportunity
for another thread to enter in the next 'numa_scan_period' while
we have not gotten till numab_state allocation.

There should be simpler ways to overcome like Vlastimil already pointed
in the other thread, and having lock is an overkill.

for e.g.,
numab_state = kzalloc(..)

if we see that some other thread able to successfully assign
vma->numab_state with their allocation (with cmpxchg), simply
free your allocation.

Can you please check if my understanding is correct?

Thanks
- Raghu

[...]

