Return-Path: <linux-kernel+bounces-441722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D48759ED311
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344A7188213F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92001DE8AF;
	Wed, 11 Dec 2024 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Y0+IgHaF"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020112.outbound.protection.outlook.com [52.101.191.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DC81DAC90
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733936882; cv=fail; b=e2Hp1Pzl6BUMH4azbOdcjmWPwmt8/vXBW9cvKwlShpuUOhI/snoZ6G54XbE40jcOeWjGI+Lt9JtJbOO6pycFBVm9l+cYEsOAw8ndw1mmZkEUNWK9VmU+yyvKhJWgWirJ3p/ArfLqso8R4n3Ig78MjfNPE2TR1iPqcg/ufzlPpjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733936882; c=relaxed/simple;
	bh=Q18F7Wq7kFMpkm4k4O49zS1luDD9gtwYi0H+Bl+lY/U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Eljipc1vJJo5Qh+swBgCuOm6wsEbjKrNxk8YDk6Kg/UmmgthoR0i+r8HRY6t3EhFDtBBs5bapz3SUk50i4itJwkEh7SuZSvMukKxZcBny1qTkxMnzcy2lhTxdI42PELh13nV2rUEBHK4f0b05bKQF5IkeeSCPSDsL8dvvbDTbo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Y0+IgHaF; arc=fail smtp.client-ip=52.101.191.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7MwplhyGo3A9xhynw60DdD72G5b7zcp/UG6lQ7tmFCJfnvuXL6QiN6UDPAUG7BAcfVkWVVDi8zLT6nOZoUTfM72SRNCE9mjVKAmE8xzwjkCfHOpVCbxGactuykvBESFkW6Ca1xvp0PlGbdrvXwXGzsV9pbtf1FJV7YY6n4gz3Z8+OEpcLlyQ4BTfpMDIYygli/QfuVbUHIIgBSqvTme2cJUU39i8JSX274KA7cOmD2ow17Bi43MHrQyh9BKnv4HXonSBM4oRO97N4veREjmvwkZJRMX7RoNXiVG0vmU4bSDMoGkCJ0jf3yQ0NcjiMxR2l0+3p1/KZaWsURs7PtcLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UL23JCvZR32ibYKKGW6Ow9KT+8ESUtb+hEQlYkUDZg=;
 b=UouZbejApULeSo4niITOhEYyKum13wlvwNSUlwaq32ybe9eaqGJHCWlYqOfntiZmQ9vPXMS4FCIn4B4ieG7MoU5gsCb+mx8AZYCsX4DqIysEPnSsmOCEiR5eIxF7QVYQqFHhB5VgURtOI/6H+BQOVimevb/Ym28JFUIhTpsLiiw7FbjgEgip2wyPb0ud8YAyzraNt9K+h+dwiK60BuDkV1grIWQjLIclxj54EUPlVxnE2Td7CJkxbub6xZ0Ue2STmzUd6QESZI/mssc7kIopy7HS56nfHb4L7fXv/ydvLB6e3kNi0iJeh0w9AV8TRNZ9o70C/DG6WD+yw0gu7LCDrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UL23JCvZR32ibYKKGW6Ow9KT+8ESUtb+hEQlYkUDZg=;
 b=Y0+IgHaFL5/G4nZN1HBsEQ6yBNfxryvmcR/bSuFeeLOMPbpMJvAEuGHmElKCmZLKt3Nr3n24bAAP40QCY3REeInr0+Wc3W/8VsXlp9AR1CZ+TUCn6RGmOr50Tkv0HBKHAwnXdpgCdcaHnw6YdXMdcLWVHQRHkC7XXWNfFaniXdfGuiRvhjOv8B+NGNSiytCZ4U3ZwFcGmNqC2msrdsRt02zb7O7PVEiiIU59UuxlIOxn6aErP7SGz3WJHbJJ/2s92a/4UbFsWiQrzH2EZeGQ5LucxF/zLYbj0jvQKKAxYLX4Y3UKUzjSZ/Mh4e/r/PGQ6JtNK3VBE287NtBVobS+ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPFC07946807.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::581) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 17:07:56 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 17:07:55 +0000
Message-ID: <eee21fae-dc64-40bf-90ac-c7228ae7ef48@efficios.com>
Date: Wed, 11 Dec 2024 12:07:53 -0500
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
 <5ba975e2-06b9-4b98-bece-d601b19a06db@efficios.com>
 <ead55d690448cbf23677bcc1b4c1a5c129240c90.camel@redhat.com>
 <445b4203-940d-4817-bd45-9da757f22450@efficios.com>
 <481a7b7716cf4eb2d592b08558d297d343d9aa25.camel@redhat.com>
 <cbc0a3c5-2ae5-439e-ae5d-7fb68ea49aec@efficios.com>
 <1f4a8928-8450-48e2-bf40-e75967240d79@efficios.com>
 <7c4d0c6800a4bd7a5cf4928e28d59fb469c944b9.camel@redhat.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <7c4d0c6800a4bd7a5cf4928e28d59fb469c944b9.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0007.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::11) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPFC07946807:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b9a340-213a-490f-9b6d-08dd1a065aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|41320700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFcwRm9wdHd0bnpMN0xlOCtzdHozRFQxRHhVSnlteFNZUnVTb09aZnMybnZv?=
 =?utf-8?B?ZDRHYVE2dGFuQ0pXakR4bHVWZlVZemp6TGRaU2paZ056T3FZL1FscG9MSzZs?=
 =?utf-8?B?RmI0WE1yaDZNSmZwTmtQaVI4Y3VvRlc4T09BWXNwNWQ2VmRQSVFUalpmWC9r?=
 =?utf-8?B?WUVxa1hISkJtdkN5SmZkTzhUY0JDQ0syaSt0WWllWjc2SFpRVXZTQzMxSUxQ?=
 =?utf-8?B?aWMrSDhHVWhITTBXYmR0aWRSa3pHa29xUWt4SUNEWTRUN05rMWQzMkxSdnpl?=
 =?utf-8?B?MS9qVEFVeEFwS0lULzdYaUxXNGJIY1hGblFVRy9oMlRzZjBkNmltdVhaeHFE?=
 =?utf-8?B?Y29mTEVKWE9aYVNTRUt6bHpDbWlDZ2QzdCs5TFJ4RldRdHhuRW9JZC9BOHhq?=
 =?utf-8?B?b0NXTTFTUlZCV0ExZEQwYkcwNlpMNGlXM1ZuMEF6OUM2WFFtZk0xVXhEQ0hl?=
 =?utf-8?B?Vys3Tk9BQ2NKTU9OQ1ZacFJZOEJwL040V3E2bStyUWczbmJFWUlkWWpoRm5w?=
 =?utf-8?B?ckpqRGd2a3RCM1lFUmJGZHA2M3gxNVdiRFQvRGxIWmM5c01kSjNpMUFFRnYz?=
 =?utf-8?B?NVd6RDRRM2lQTVlRVGZjMGt5VkJFWFV4ZGdRVTJ5eTJnMWh6ZlJHYzlCeWVt?=
 =?utf-8?B?eUx4ZEcrSDRvSTl2S2lxcHNpa0ZjcWo1bjg1QlVlR05YNjFyczhkb0tIRWI4?=
 =?utf-8?B?ZHpTdUU5RjZwMU1DTzQxTVNUeDRJUTlhMmNOb1JwaVN2U2VCTDlHNm9WdTVU?=
 =?utf-8?B?dldsemZrdmxzbTlKeTVzeU5VVWFHbWpkQnB4L2pES1A1anNCQVBZQ3V4MVFw?=
 =?utf-8?B?SU5ERlhxUS9aM29CRk5ISHlVbHVCZExsa1k5R2hpRGJPd2VjYVNLSG1HYm5G?=
 =?utf-8?B?aG9iNGVkVUtWWml1Um9IaFVnMUo4SjJmTjN5SWx1Y21FVDBhRG9IWUxCaUhq?=
 =?utf-8?B?d0J2emtkOWE4N3BsRkZQcGlHakhZUFk5bDlzVzlkT1lndUhzV2VjWjVJcVky?=
 =?utf-8?B?dVNVY3BhYTQ0N21KemduVkhNcG8reVlObHRTUTNPdGVKaExJSnVqNTd4Vkxx?=
 =?utf-8?B?T2doakYwNlJkSm5seVJMMUY2MjhKWlNVcFVKR2JsbmoxMTRNSXg4cnVPbDlB?=
 =?utf-8?B?OUNJS2Z2blRwWFFXYUFjUkdNajZqSHFza3ZtUzBGUDZoaDRtTC9sT0NvMEZl?=
 =?utf-8?B?QTN6ZThva0dPTnRrSjBBeXNXM3FRa3dyUVlUTWtJREhVKzdqdDN3Nys3alB0?=
 =?utf-8?B?blRNc2Z5MkQxWEdKV3ZyeHpJMVBiS2RMemxZUkQrVEV2MS9JaVlNQWIvN0du?=
 =?utf-8?B?ZzF0ekliQ1ZEVHJaaDFrekFYanNiYy9iYThrRzJBNnlHUXRydFVJaDJMTmxy?=
 =?utf-8?B?WHh4cUFCNEMrOC9UbGpRZnJrcWpOS3NtdFYrNVkvdWc4Z3ZQd0hVYmFVSEUx?=
 =?utf-8?B?ZTNGdHlpdE5HZFV5Njl1ZlBnTExvV0UrWHIyOUkrQXJGV1NTVGlXeVppd2l6?=
 =?utf-8?B?cXkwakkxNVVjZXluVEJYWDE0RzI0YkJjZzRnREprQkp1dUNNZDJxNWdTWjMw?=
 =?utf-8?B?NnQrS2p0d0tJZXhianZrOFpBckk0c0ZEd1NRb3VPRXBwUkRKYWEzY09kczcy?=
 =?utf-8?B?dkxScVRYV0JZR2JGdHZYQ1BJdERuUkVqT0M5aEw4L1NQb0RWMkhyY3RzVHg3?=
 =?utf-8?B?M1N0QkVUWUg4dUNKOTdFR3VFQ3YwWEVWQjh2ckM2QjJVNCtlOERDS0JzZXRY?=
 =?utf-8?Q?uD8JvYL1c/R7D07q50=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(41320700013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEErekljcERmQ2ZUMkt2cXNUWUJpclREaFBiaVVVem1ycEJadlc5OGZTZHZT?=
 =?utf-8?B?dExwcjFacmdnVUc4RTlCcWFoNW80TjZkQ2YvVDU5UTE3M3ljS08xVytRL1RN?=
 =?utf-8?B?L1I0d1FHcnlZdlRvV3V5VnI4b0ZsNXBReHc4TUhGeWpMUEROaUxDRzBpNXI1?=
 =?utf-8?B?elVuZlg2SW5XS0tzL2lWVkgzM1lZSE5KQlVoWVFHVkVPVzJoTm4xU013OUxk?=
 =?utf-8?B?Q09QTDIrKzNYL2tPTHVGenNrM3JJenQ4bUN4VG4wbVVybjlLL1ArZVNFUFVR?=
 =?utf-8?B?REFkL1QzN2IyKzF2L3grVmIwRmRUTlpQYW5YUHZIN2pBT3RWaitvY052alhN?=
 =?utf-8?B?bXJKUk8wOFEweVZCcFl3Q3lNcExFNXA2WHdHR2ZGY2lFZ3lDaTRxUWZjRy9K?=
 =?utf-8?B?MkcxUHA3dkxmYVhzKzJjd1hScSs5ZkhpVkhENGVIRWMzc05uaml2WElURlc4?=
 =?utf-8?B?NU55cnFPRjBhUFFTaFZaSXZrOEdyVVA0UlRvWTNMVTAyeklrMHdQaHZVUlZO?=
 =?utf-8?B?Y0xlcy9yek1OMnBHazhTRUxDVUlCYm1pdTE0MXJrMFF1WGNGZXM1b3BMdFhL?=
 =?utf-8?B?M3F3d2FwS0hkSEIvdjkwVno5aWp2SS9EV29nVTd4UGVxcW4ybUFiY04zY2R3?=
 =?utf-8?B?WFFUQlNtUXMxTFFpNG9wcmlhdmp3Q2RKN2FCejFLeWlQbFpmSFN2aXN2bXlO?=
 =?utf-8?B?WHZubkRIRnpESThrTm14ZXlqRDdScFZ2Szd1Q1dBZHFQcFRCU3B0U2JGckxu?=
 =?utf-8?B?WDBPMW40UDAyZmNQdTZINmhUcEk4MXFGOGJneWdDMk5KNEVrTGVLTzlwUE9z?=
 =?utf-8?B?cXljb01LT1dnOE9ua3BlWVdaUkRFSXFJL21MNTladjZFN2RDRG5FL1BpOUd1?=
 =?utf-8?B?M2Fna0ZPaG5BK0NPZlBmQlplS2hmKzVmOHhXWTh1anlkWlNOQ3VnSWR0R2NX?=
 =?utf-8?B?dUdJdEwyL3hpRm9haW1kcng1aW5wZlQ5S0t5cEN3MjdBR1k3cXF1bE5wdzB3?=
 =?utf-8?B?UXczbjNZSU9qK1ZjRWxEY2pSbHYrcEJDbGsxTk1KbWhDTGNvQUszdFhTZG10?=
 =?utf-8?B?NWRMbEtiNFY2cS9HQUxGVzEvOTlHYWc5ZlNraEtTSFFMNG9mV2NLci9LeDRR?=
 =?utf-8?B?TnhKY2VqNGFYajFVZnBpTDdQQ08wVCt0M1ZTeGNFTGp2bytEUytDaXhNUFhZ?=
 =?utf-8?B?RzJZOUpZY3J2R2ppUmpNOXR3clNBc0xKdi9GVjI4QTYxazdsVmdBS0J0MXE2?=
 =?utf-8?B?TTBMUjRXNldrS1BFTEJjV2hNMjlBckpQdkRPajhjQlUyYWZFZCtqMXNYTEdh?=
 =?utf-8?B?VVMrTWJ2WkllVHNKekhjUm9wQjRMWDdqaU5NaWJmdG9GdEIyM0l3U25DVk4y?=
 =?utf-8?B?OTNwUzBXamsvYUZYbkdZZ3RlZi9rT2ZpbURzNW9aejBCbSs3aUFnc1pGeFd3?=
 =?utf-8?B?K0E5UEJFUDVhQzdjUk5VcGJCME5kM1NyMUphaUVpSmdSQzl3RWVPMnEreHNz?=
 =?utf-8?B?RHJSUFpsWFJEbmF3dGRGTEFTN0xmL2xxK3A3Z2lReU1hRmZJUUR5YjBMNHZv?=
 =?utf-8?B?N2hxQndGSDNUaUUxSXFnOXNaVFZ5cGYrRk91NUo1aGpCS2x0UXFuUWJUZkN6?=
 =?utf-8?B?VHUxMWI1RWJvSTlibVhnbEJySEQxZlpRMkpGUjJWU3hLTkR1ZkRibjVJUlpy?=
 =?utf-8?B?WDFBanBkb1dCZmIrUXlCcnJxQWRsWGliTmdyZDNDZWlRSi81QmJFeHFkQW5I?=
 =?utf-8?B?VVpsQ2tSbUJ5OHlqUENQb29kR0JOOTd2bW8vWlJhNGQzTFJwaHQrVjB0K2xR?=
 =?utf-8?B?TTR5TXBvajNSZlNreUsrMk1nbXhTZjFBSVkwdjFPMXBOQkhXNkxHYVlsRFlH?=
 =?utf-8?B?MURjTWZQUnV2b3BMckJCdHVYeXBNMTcyQlI0N1lmdGdWUWRESVp1eXRST3hY?=
 =?utf-8?B?Zk9nRnFCNkVGajJ1anJ0dmY2V1VtNytIV3ZsWXQwN09JRHdYd01ZOFNwTEcx?=
 =?utf-8?B?SWM1UklQRDNpckxxZ21XM3RxbzJwY2tpUUlKNUx1SHcyV2FwZzdZcDdBbTQv?=
 =?utf-8?B?VWVKelR2S2cvQ1YwTDdSRUxIQWNOOXRiaGorZWJEWGY5OTZwdHBncFFML2VV?=
 =?utf-8?B?VUJpaytORFFiLy93UGozcFFTQTE0Vk1xdkg1UVJ4bU56cDVTK2FYemVoaW5Z?=
 =?utf-8?Q?fHV0tlc176MCSx0VVK5G0dU=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b9a340-213a-490f-9b6d-08dd1a065aae
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 17:07:55.1285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jD2eKa1Gx+YUIueOIZY+gBWIpX93KMzK3RRQCDc+B9n1UtxF0RdRzADIelU9HUnE9RIfJskioZDQDeTXezD1neVRgADW5aIX9+9BjcXLuYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPFC07946807

On 2024-12-11 07:27, Gabriele Monaco wrote:
> 
> On Mon, 2024-12-09 at 10:48 -0500, Mathieu Desnoyers wrote:
>> On 2024-12-09 10:33, Mathieu Desnoyers wrote:
>>> A small tweak on your proposed approach: in phase 1, get each
>>> thread
>>> to publish which mm_cid they observe, and select one thread which
>>> has observed mm_cid > 1 (possibly the largest mm_cid) as the thread
>>> that will keep running in phase 2 (in addition to the main thread).
>>>
>>> All threads other than the main thread and that selected thread
>>> exit
>>> and are joined before phase 2.
>>>
>>> So you end up in phase 2 with:
>>>
>>> - main (observed any mm_cid)
>>> - selected thread (observed mm_cid > 1, possibly largest)
>>>
>>> Then after a while, the selected thread should observe a
>>> mm_cid <= 1.
>>>
>>> This test should be skipped if there are less than 3 CPUs in
>>> allowed cpumask (sched_getaffinity).
>>
>> Even better:
>>
>> For a sched_getaffinity with N cpus:
>>
>> - If N == 1 -> skip (we cannot validate anything)
>>
>> Phase 1: create N - 1 pthreads, each pinned to a CPU. main thread
>> also pinned to a cpu.
>>
>> Publish the mm_cids observed by each thread, including main thread.
>>
>> Select a new leader for phase 2: a thread which has observed nonzero
>> mm_cid. Each other thread including possibly main thread issue
>> pthread_exit, and the new leader does pthread join on each other.
>>
>> Then check that the new leader eventually observe mm_cid == 0.
>>
>> And it works with an allowed cpu mask that has only 2 cpus.
> 
> Sounds even neater, thanks for the tips, I'll try this last one out!
> 
> Coming back to the implementation, I have been trying to validate my
> approach with this test, wrapped my head around it, and found out that
> the test can't actually pass on the latest upstream.
> 
> When an mm_cid is lazy dropped to compact the mask, it is again re-
> assigned while switching in.
> The  the change introduced in "sched: Improve cache locality of RSEQ
> concurrency IDs for intermittent workloads" adds a recent_cid and it
> seems that is never unset during the test (nothing migrates).

Good point!

> 
> Now, I'm still running my first version of the test, so I have a thread
> running on CPU0 with mm_cid=0 and another running on CPU127 with
> mm_cid, say, 127 (weight=2).
> In practice, the test is expecting 127 to be dropped (>2) but this is
> not the case since 127 could exhibit better cache locality, so it is
> selected on the next round.

Understood.

> 
> Here's where I'm in doubt, is a compact map more desirable than reusing
> the same mm_cids for cache locality?

This is a tradeoff between:

A) Preserving cache locality after a transition from many threads to few
    threads, or after reducing the hamming weight of the allowed cpu mask.

B) Making the mm_cid guarantees wrt nr threads and allowed cpu mask easy
    to document and understand.

C) Allowing applications to eventually react to mm_cid compaction after
    reduction of the nr threads or allowed cpu mask, making the tracking
    of mm_cid compaction easier by shrinking it back towards 0 or not.

D) Making sure applications that periodically reduce and then increase
    again the nr threads or allowed cpu mask still benefit from good
    cache locality with mm_cid.


> If not, should we perhaps ignore the recent_cid if it's larger than the
> map weight?
> It seems the only way the recent_cid is unset is with migrations, but
> I'm not sure if forcing one would make the test vain as the cid could
> be dropped outside of task_mm_cid_work.
> 
> What do you think?

Can you try this patch ? (compile-tested only)

commit 500649e03c5c28443f431829732c580750657326
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Wed Dec 11 11:53:01 2024 -0500

     sched: shrink mm_cid allocation with nr thread/affinity

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 76f5f53a645f..b92e79770a93 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3657,10 +3657,24 @@ static inline int __mm_cid_try_get(struct task_struct *t, struct mm_struct *mm)
  {
  	struct cpumask *cidmask = mm_cidmask(mm);
  	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
-	int cid = __this_cpu_read(pcpu_cid->recent_cid);
+	int cid, max_nr_cid, allowed_max_nr_cid;
  
+	/*
+	 * After shrinking the number of threads or reducing the number
+	 * of allowed cpus, reduce the value of max_nr_cid so expansion
+	 * of cid allocation will preserve cache locality if the number
+	 * of threads or allowed cpus increase again.
+	 */
+	max_nr_cid = atomic_read(&mm->max_nr_cid);
+	while ((allowed_max_nr_cid = min_t(int, READ_ONCE(mm->nr_cpus_allowed), atomic_read(&mm->mm_users))),
+		max_nr_cid > allowed_max_nr_cid) {
+		if (atomic_try_cmpxchg(&mm->max_nr_cid, &max_nr_cid, allowed_max_nr_cid))
+			break;
+	}
  	/* Try to re-use recent cid. This improves cache locality. */
-	if (!mm_cid_is_unset(cid) && !cpumask_test_and_set_cpu(cid, cidmask))
+	cid = __this_cpu_read(pcpu_cid->recent_cid);
+	if (!mm_cid_is_unset(cid) && cid < max_nr_cid &&
+	    !cpumask_test_and_set_cpu(cid, cidmask))
  		return cid;
  	/*
  	 * Expand cid allocation if the maximum number of concurrency
@@ -3668,12 +3682,11 @@ static inline int __mm_cid_try_get(struct task_struct *t, struct mm_struct *mm)
  	 * and number of threads. Expanding cid allocation as much as
  	 * possible improves cache locality.
  	 */
-	cid = atomic_read(&mm->max_nr_cid);
-	while (cid < READ_ONCE(mm->nr_cpus_allowed) && cid < atomic_read(&mm->mm_users)) {
-		if (!atomic_try_cmpxchg(&mm->max_nr_cid, &cid, cid + 1))
+	while (max_nr_cid < allowed_max_nr_cid) {
+		if (!atomic_try_cmpxchg(&mm->max_nr_cid, &max_nr_cid, max_nr_cid + 1))
  			continue;
-		if (!cpumask_test_and_set_cpu(cid, cidmask))
-			return cid;
+		if (!cpumask_test_and_set_cpu(max_nr_cid, cidmask))
+			return max_nr_cid;
  	}
  	/*
  	 * Find the first available concurrency id.

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


