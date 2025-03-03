Return-Path: <linux-kernel+bounces-541829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E441DA4C21A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D59162ACA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C265211A01;
	Mon,  3 Mar 2025 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h3+TJF+Y"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190761E86E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009017; cv=fail; b=JPKvkqaUhxgnYmyBUGTFWDXRusw25f+DTTUgeTfhqf3NR2u/GaSYb2jRjWWzxEawzIupgRqwT6vccy7QnSBuFWYHc4OesxDX0jLwgfwcN6d41zlZg+V76e06T/2HrrqQqQh9b/8OyrizPTyugCGkEoMLbHJMZhP9tjFydhvIrIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009017; c=relaxed/simple;
	bh=g1BqPN1TB4Z3W1BMHebbUYIGZbscFTFTGNlPk9OwO8w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eD9FpX4HgA5IdBAbShvsOOb9OGjlSYENqhDnnSBMpIg0VgtoYsKEU8+1855SiEoyrhOkXo4nwiHKNlULqt9GXGMRyRIagSRmNp+nWe8iFm54+KZszN/kqOjooT6HIWaq9gBdMDumMZ1WJvwq+HldsrHUJOjNaDtoI/J7JxFbLgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h3+TJF+Y; arc=fail smtp.client-ip=40.107.101.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ow912h5s2JYJnEVivlDA4cyMSQyEdyHaF3Oz4dPJ9aezy/1Bc1JJgwc3LYZSXiwd2KLEwUQ2UaxntFoW+R2bazdTxvkGPxdSu1Yl5rngQy5I28WmHNvL2yWA1cy4BxnS6MBwjSjV4rbsheCB8rLrtYqli4nJv/ax1iz1vqsE9WrOJFwPWINaCfoB3gGXqAOwGHtAtpAsD4nbHt9aM4tm0BgjBi9AHK44ESgJjTXVeSENmb5B/wSVwlM8dSkRCQOlmZFZqe6UvlmdjdjYz6Lpun0tlddyHbgqz/AQY5PpgbeLHfSZSCscGsfjIqaeLvk9OuRjCOkxQ0f5uXKUOMderA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3QoD9KZcSJUx7t4XADrLBas78T3scZvb03PDkA31vY=;
 b=Cz9dA7B2LqY0dD2MuKIBw0V5ZfnfDmGbklmNffiYrDCrLlwlBZf5lpOleuluMBu4DPhP1RI1V2N8Pz7p/8O+Cj7F5sY9Bbfd+Suo5aYLVD7YE0dldQTNIATnBRiVb5Ed6yC0n7i+OyjCmumrj9pp39FbgLyqd0l+tMWAgyqUdJ6o+JBpmxzJFbM735mgIo3Zkstcwb1FaRl19faDRTTM/Zu5fzDg4EmKTfNf9PzhkQlYo3H0wFfnFbrhuOmJ1p9g0eSNK5N/D62dQw6KZCdzENygHl/xDZo5CvjH+xoLglpBNPMrkJdoMJejbjg2UFjdawSlAPCYITjIOXvilcJ8IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3QoD9KZcSJUx7t4XADrLBas78T3scZvb03PDkA31vY=;
 b=h3+TJF+YekWDicEnwKC55OyJKL968PH7Eg7ZnUqBh0wwXSG1PPtdrKc/KS9ZlzY0Z4PkKA4LACTSS4RBJtDeE3u095Twfz1z7zRuKYwWhkBstZlHfIsC0aqtWLNi2VS1ubVKRvTijnafZhFNkdNak+MDdP5nX/IHFpTj/0eAVcs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CY5PR12MB6597.namprd12.prod.outlook.com (2603:10b6:930:43::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 3 Mar
 2025 13:36:52 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 13:36:52 +0000
Message-ID: <61d3449e-d5f4-4099-a25b-cc8925b80e30@amd.com>
Date: Mon, 3 Mar 2025 19:06:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/24] perf: Simplify perf_mmap() control flow
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 willy@infradead.org, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 lucas.demarchi@intel.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250205102120.531585416@infradead.org>
 <20250205102450.350989371@infradead.org>
 <932e26ff-0654-442e-b6a9-166a7da03fd7@amd.com> <Z8WQPds5x8-9ABOm@gmail.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Z8WQPds5x8-9ABOm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::6) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CY5PR12MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c4b5eb-f394-43ba-f663-08dd5a587499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1BRejhxNnJuMFQ3L1A1YW5VRCtQT1dWbkI4ME9CYzhNMzhHdVI0U2JDZzAz?=
 =?utf-8?B?b0w0RVRSQ0RBaWZTUzZHQVdJcjFWTTI4ZWNPV0tDZWhoVG5hZ0tWSHhLQjJi?=
 =?utf-8?B?Wm1PQ0NSUU9TMjlvaDBkQUhmVmVRTHAwV0dnVktrY1dSQmI5dXJuN2VEUTNj?=
 =?utf-8?B?VWxoN3E0ZlZxckVmcFNRQy9XbDdCRDRnY3dxL0ZiZE0rdG5JSENHcmllOVVs?=
 =?utf-8?B?OHFYc1dFMi83T21SN3Q1V1hYYUZNNVFFL0pWOTVZQUJodHFKVm9QTEpGbVpU?=
 =?utf-8?B?VGlkblkrSjF4cUViQUtZQ1gzd3RscGhscUFVUm1UT2R2K0djUVExenNoSzNh?=
 =?utf-8?B?d2FEakh4elpIREFSbFJBTU5jdUNKM1hYVEtyVkt6anZZOXBRRmVRWDhIRjFP?=
 =?utf-8?B?REg5Q1VlWThGUW9ZVENpNGZKUVZiNDdKQjUwQUQzUUVGM1IwaFB3aXhVdkRJ?=
 =?utf-8?B?N0pIWGwwYU9kRGhNRklYSENtU3JwYlRSSzhiNnk1dzZvbGFYdThMdlNOZjNl?=
 =?utf-8?B?MzRhYTBlTmJPTCtnOFVDTUkwR0hONFY5OU9lUFhpMDE3UzZ6Vk4rZ1kzbmt1?=
 =?utf-8?B?NjBDU2lpTWVlc1dpTXUxZUozSWxUWTdoREw4cWtnTlZEc3lYSWw4S0NBRlZ4?=
 =?utf-8?B?QXNaUk1pQzFKekE5M3pzOVZ3blNzVGVBMEUwUVlJNTc4a3VvWnhncjN6ZXJo?=
 =?utf-8?B?WDNBUjFRMUNDR3FpU1gydWJqTVVZS1NtK0ZZaEVYdFdhSHpIOFZuSVdWT3ZG?=
 =?utf-8?B?S0lpdnVObnFINFh3YlJSbWpjM1A3clZMcXZBSENYRS8wVU1BeTZ4OVRCbWto?=
 =?utf-8?B?RUtWeTlrYmRSNTdrWlViWUVFaHIxREt2TVpuVkFhWHZhVGlPRUtXSmgrcmlr?=
 =?utf-8?B?MlBkMzJObEJ2aThoQTNJQ1JBK3QyTDhrZ1RkTFdHaTUxY1VDSTJUWE85MTUz?=
 =?utf-8?B?RkZtTGhTUlNacktPK01vcmpBTFE4S0FCYTE1YXZ0c3dIcjRCQTFkK2JkVzJs?=
 =?utf-8?B?UFhReldKRWxWU1YvRjhuWndlZXh6ZTZVQ2x2RS84dTRHbEpXeUZpUUZWM2Zp?=
 =?utf-8?B?OFFwZzdtdnh2TlJtSXY4RnlZbXExenRjSzY5OW00TytFcmNRczlRSDJ4UW01?=
 =?utf-8?B?MGNRRlA3M2dYRUpFNSsrSmxOdTVMYWF0b1JTODVEdzNXenVpcjN6Y2FnWXhL?=
 =?utf-8?B?UWZaakFhMGN5MmZ2bXhybVpFR01GenFzM1BsL3VKVUNhK1h2UGFyVG1XbDF6?=
 =?utf-8?B?QW14SGVVNnk4c2E2bHJXTnZjSkwxNlpBUzlOZFJiL1VjMjFDLzI2MTQyR3Q0?=
 =?utf-8?B?MWJLejBBSTAwZGdQRDl3MnFZd1RjbUtPaGJmazY3VndNVkJHWitROWNDQ0VZ?=
 =?utf-8?B?a0JNczVTcEZUOEpWL1hhbVEyRVdTNFBGemVnbE5FZUtac1ZBa05jclFtZk9O?=
 =?utf-8?B?OTNRaTBTOWh2dHcwRFNnaWlPVkFWcDJhZHUyUmxGaTIrdXJXSkZtdkl0alJo?=
 =?utf-8?B?WWlKVFdZMGxYdk56MXVsQlp4aCtvSTlpL3ZCK252bXprRUJIbno1YmJCYkdw?=
 =?utf-8?B?TzMzL1hLbWU1S0FQdGNpRXNCK2c2Qm01a0pmODg4U0pPMHhzQUZNNVA2RHhs?=
 =?utf-8?B?NEN4UUF2RkYra2VONGdqU3VuRS84WDJNRkEvR1NCa0VWclgyWktZU2MrZzFP?=
 =?utf-8?B?UWROb3FmU3k3TGdiY2JacExwNzNrR3B6US9tbXlGbVY5RzhDU3QwVlZzeDc2?=
 =?utf-8?B?Vk1xbWxzS0dBQXRpV1F5YldqVzQ5TkhCWlI0MVlYRTZISXIxcVcybDJWNytI?=
 =?utf-8?B?eUcrcVdKb2lpTXhjNCtqMnViUDhBb0k0ZVd1YkdxVlBIT2hIeGIrWjNHSmRR?=
 =?utf-8?Q?GahDc+ssa5f57?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3J5ZlNDUVBJV0NOOWkveUphc0FLcm9CTWNkdmc3cE1GVnJmRGJ6MmFSaWtr?=
 =?utf-8?B?KzZicGNtZEp6TVU2SGZUdkgxaG9EdUNmdTdzSitGVUwzR213eVBtSVNkOGht?=
 =?utf-8?B?Z1NJYWhvRFVyRW1XUy9veTA1eFBPeTNLTENNWW9rWDB4eTcyN0tBbjVkcm5K?=
 =?utf-8?B?R0dHemRQckVheU5zUnRiblpZR0g3TFlzUzUrK1JTUDVaRWxzdGxvcG91alhG?=
 =?utf-8?B?elcxZVk2UmtUdXZTMjZsWm1SWXRLbWprQ1dSSElGblJZd3hEVzhKMUU2cVJq?=
 =?utf-8?B?TnI4ZUZvTjFIbHdvc2dmcXJjcUttbzRsTXhFNC9Jbm5OUjNJZlNvUkY5M3Qx?=
 =?utf-8?B?Q2hJdXJTL2hyK3RVNGJrSVgxNHFIM24vMGRaNWhQZmRjWDNiQzI1OVFJZ0dm?=
 =?utf-8?B?ZzZEZ0dUQzQ3MDVjUFM2cDZ4WHhBZDdaL0V5dnhtLzIrNk1EYzJlNVZwM1NB?=
 =?utf-8?B?RTlCK1FRd09JQ1JzeURPRWZMdzc0T2hLWmJvYk5SZnJCaEVJeFRWaDZmU0dY?=
 =?utf-8?B?a2R4SG1QMUNXcHNVSHNwSnd5bTlrWDcrNVJMZmZJNmkyTXZEbXQ0MmRRN052?=
 =?utf-8?B?dnE1MWx0aytPSEgvYmI3Wll3dVV6RWRqc0pPRkdxbWhwSWFnYUZWaE5nL01k?=
 =?utf-8?B?VmwveldlQjdzV21yNHBFdVNhcmtEU00xN2VWYnJUL3VRMG9PVEhYS1pkWWRQ?=
 =?utf-8?B?NEdrc1JqYjFmRkNJYWx5S1pKM09PYi9SWmlrUU1WTmRkY0pFdW5SWmxzNTBs?=
 =?utf-8?B?WUxmbWFKTk9GNEZNNFMwTFI1TWhRU0FXa3NuVHRjREtrbnRtY0oveUZXN0pj?=
 =?utf-8?B?V1duaFFPWlJzNFlwVWhoZG9HaTJGR0Y2UlpUNllFbVdWSHg2ckQzSnRrcjR4?=
 =?utf-8?B?RUZQZUpzVEtzT01YK0o1U09meVRnbFFVbS9BYy9yT0dqV09IL3lXa0doTVBo?=
 =?utf-8?B?QmNSQ04wN1gyWnFHSkxwRnpBaFhUOERvUVdHTU4rd0NCUytpeXdEZFNYUVoz?=
 =?utf-8?B?RTJiRmpmamduS3JQWG5LaEs5cnpYeWJubnhOQzduL0RLNitka1dyQ3VQMVRT?=
 =?utf-8?B?YkNBRHQ5ZTkvMzdFaUkvNEF6Sm56b25mZk83aHRBNmpvQ0p0d0p6aUpmK0F1?=
 =?utf-8?B?c2ZrTm1lcXI2OXNCN2NuSEJuNGxLMEpmZG10ME5UcGgrWUJYVWQzbHJ2NTdN?=
 =?utf-8?B?Q0h6Y2JsMW5INlYvMnBTU2Z2Qld3cG9qenRIRWxKZlJtODhHVHdEbGM2WURk?=
 =?utf-8?B?RGVtbjFGRXlsYTk1NTA2ajVyTEdKSjAxcXN4N0dBZXJzN2ZWd1RrS0RFZHZY?=
 =?utf-8?B?OWpjL0Rrc25iYlBzYnlBTENVYzNyNjR6SG5Ud0xHYnRHM0EySGVEbCtrazRt?=
 =?utf-8?B?d0ljeGpSS3cyMG5XaVl3R3RibEVSRnlVc09ZWDZEV2Mya1V0MDhaRjNUdE1V?=
 =?utf-8?B?OGM5bGsyNTRVV1dFNUIzbVFYR25HT09XOTFwVVFENEExV2pTSzFnMHE5OE5i?=
 =?utf-8?B?eExzUUEra3djNmNpM3NvQ2xxa3B1S0hvUjl1MFhZRGlqR1ByRXV6T3JKc2JJ?=
 =?utf-8?B?ajdaUERtSVRXNkZ6VWR4Nng5aUkwK3l1Q1pIVVJpbXlMSTIvY25ObHRFSEJQ?=
 =?utf-8?B?QWtqVTF2YVZJVSs0K25waVRiV09lT3ltV2ZQcE0zeitlbDZsNTAyNEhUQ1Iw?=
 =?utf-8?B?SElzSmJzbEM5WHJvMnV3MnRRNms2OXZGblN6b1d3eTlCQTB2WDJGRGhFbW85?=
 =?utf-8?B?RnFQbk1QOVRLQmJvSWs2OWx4N0NhUG5qL2IyK0ozL1BEU2l5L3hFbCs4L3ds?=
 =?utf-8?B?VUlndXJLcnZOTGtVNUZVdWU1Y3VZZHpoVFl1ZzRPRHdNdlYvK2hiMEpDaTdR?=
 =?utf-8?B?U0JrTDRTeDNVQlVmeXY1MHZkT3FRcGN1a25vdU1oS0l1TUUzRHpFSjJ5NDU5?=
 =?utf-8?B?OElvdjVnVW1LVTlqT2owU0lzOHNCVXF1RHJ4ZnViSVJycFVHRkpYcFBPR0VB?=
 =?utf-8?B?VTF1WFVQV2dGa21MZkhBcWNQNlFDM2tOT3FGWFJ5bkdsZVl2RU9RQzVvbXVY?=
 =?utf-8?B?aEluVVQ5azRzRGFJSEsycHpWcVptNS9NVCtma05GY1h5K3hJMjBRaXkxV0o0?=
 =?utf-8?Q?2syrGyNhqYuNA0wututgTK+Iy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c4b5eb-f394-43ba-f663-08dd5a587499
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 13:36:52.0561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mW+e602ThveF3oBR3bc+FUfzl4h6VLLsS2KQXzp/x69ISzqfAXBspUvh7MgT9o+2hzcSpDRg8zHkJIMXTYt/7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6597

Hi Ingo,

>>> -
>>>  		/* We need the rb to map pages. */
>>
>>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> This comment should also go up. Keeping it here is misleading.
> 
> Yeah, I did that in the conflict resolution (which conflicted in this 
> very area), so the end result in tip:perf/core (or tip:master) should 
> be fine as-is, correct?

Yes, tip:perf/core looks good.

Thanks,
Ravi

