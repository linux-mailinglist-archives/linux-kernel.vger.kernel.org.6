Return-Path: <linux-kernel+bounces-524069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E6BA3DEAE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4F8171EBD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31D21FF7BB;
	Thu, 20 Feb 2025 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kcFG1A7i"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022137.outbound.protection.outlook.com [40.107.193.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68441FFC4D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065446; cv=fail; b=rHJOOepnX4jMRhwrS1vcKiu493cu8hl85eOhC4xR9FjTzQ1PM+ohUjdMNEwXdXwDug5Pd1MH6K6rWQItJiIsiixRZw5lLV7XL3uUFgem0V5/C2fC+PobSa9BQPsJzxBKe24rjDbHdaIjZzu9L3+t/QAeLkKrZoAy+MKax9ROTcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065446; c=relaxed/simple;
	bh=DjdXmELL+gX/QrJT85kooxprLkxnBQHKmqIPz8j+PEw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sqUdvWQC58jniKrJIp5/FB6U3mGCUXDi7kOY6J3+D3iz4Qi/+Rkqs1qrVcAkk90syY0Vl4ZKrKgOY10Ql9t2ZNleK/Lmk+5lvdB9JSs79TtSwgvcQxkonM1ehnDu9xddi2VD5h7H8UKnihmQW9jLNeebFc2XxI5qBeVVvNalAMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=kcFG1A7i; arc=fail smtp.client-ip=40.107.193.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTm774wXrs9vmz79DaZj9z5vwPNrO7+0lWWunRTxoEq5DcPJFLE+jsHwu+r/nKCV/C5OBzeuUQRf/VSozQAxSTzlleJLjUoXpMuG05AlBXaVblp6XkRcXPH7Coqh8RyezJA2Wi5yjSJtMAR0/auO5RC53N4ihpw2Mkk4lmCxTWNNi2ScNKo2/dNvFAvLykioaIop5rgDJwdVvkSz918WZh88SC5EPhDRUED9FoghbMUQltFVPMCm79sJsMmlMisNBWvJ6btlMmSTKcGfzfy8Oss4hLTL6OJ62/Y74k+D8MZAFiDYMbVZ79H7CH+Ay8c41Z6mO5IhU+7iVxOMwLF71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA1svIRaJ94CaihaVIqTXEOni1Gf3LOgbSn9MXPDorE=;
 b=jzqASBh7qlTPepBhoIFhMJg+H9HnaqLZlFyV5Kw6sN87c1FBljt4YCM1qbEXnm3tzHzFYEJcPPTkjOEmbrzDtYTr/ondEmW1/hkM7BoCMJRlxwqwEpzzDUUPW4paI0tjoHKxmM+Im//nzosSVzQYbSntOvOrlsH2q/pFbMymfxJBGOtQSgegnCiwzNcvrfxCQYTA0JvV8QQsMIh7YcMiVb/sEIdlKJzdkcISMZjw6dhSLpGPU91Y0uFnYQurbaC2MPJQwxbOiMCjYyTFZOrYkUWV9kSPEUly4CFHfoT93ehW7fEMtjoQhs7tqwyC4jpzccJCxd+eb8LedcFMqrYK4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA1svIRaJ94CaihaVIqTXEOni1Gf3LOgbSn9MXPDorE=;
 b=kcFG1A7ik7yvuFxe1g4DN6rSTjfne+z4aeIiK0lqNJooRVyz93sikTtBBwjKhNeaS8MpB+Bbab41W154jtGGV/vWpWVM+npTa7vybt6JvGR9U9IKdeBmTXA/0A7qwPoL5qox+qgn9DlwY23WgKsUf2V5E6HATu/W64ISNOCq3eGLbyCCyWoufOLgLnal4ewCAx+7cSfcTbfrZ7flYtBpmbJ+iUo5aoBHY/5pIhz7DsUUoIOOAl28NUd4ghGZ8z0SwTmR5bK88hOOnBzKCkMBFau8fxf5xkN/1MYyxl8fyjiiOPuX67vt3jNzcwosWaKd7WBOJnPkQZPZSLq00Fl9dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB8200.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 15:30:42 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 15:30:42 +0000
Message-ID: <5fc6daa0-30d6-4fcd-b58b-a570aeed5691@efficios.com>
Date: Thu, 20 Feb 2025 10:30:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] sched: Move task_mm_cid_work to mm work_struct
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, linux-mm@kvack.org
Cc: Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20250220102639.141314-1-gmonaco@redhat.com>
 <20250220102639.141314-2-gmonaco@redhat.com>
 <c9026605-da1b-4631-b0dd-68ae0700ec87@efficios.com>
Content-Language: en-US
In-Reply-To: <c9026605-da1b-4631-b0dd-68ae0700ec87@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0003.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::18) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f33baf-fabd-45ef-0dc7-08dd51c3893a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVYzMTV0OTRoM2NvY3h6dmUyZWFaYmt4eTc1V2Q1RXgxYVdIN0RxQmtkQ1Va?=
 =?utf-8?B?YVNnZkpPY2s3bUtUdTduZ1NOZVdEcmVVVThaRFk4MnI4a0tVVWVRVWtoN1hN?=
 =?utf-8?B?akFlWENnUWdSQlROanRpcUU5ZEtUcjhlMk4yMlQxVk8yaFNqU3FnU1pvOWxj?=
 =?utf-8?B?UkNlUGdqWFV5K1I3blhGdFg4RFFyRWt2cFMrYWl6UmkxTWpKNDVQRmZFMkdZ?=
 =?utf-8?B?cDVjNGFrZEVFRm52Zllhdy9ObWxwOXRJVkRQMDMyNnEzampJY2VETG1pWWZ2?=
 =?utf-8?B?eVp6WUN6M1Y3OGpscFRSS0lpL1p0RnVqWDdZUUhIaFNxbnhjMlRTZDVJNUgr?=
 =?utf-8?B?N1dBWVNkdERNeU9KVnhDRDZlUzZ2TjZ2djd5K2Uzek5nS3Fhd21YNHB0NkFO?=
 =?utf-8?B?Vm1OOVFjWVNjL0NLZXB4bjg1WFpvMkt2bDRzcjBlaHp2YkdTb2g1WmZIRTRG?=
 =?utf-8?B?YUkwU25od0VPQTV1NVpSRkVHeGE2bHNWbkZoK3hhcHc5NjN5cy8xdzR0V01Z?=
 =?utf-8?B?a1JvbzF6QWpkaklOenltWlRYZ2RrQ0hQY0lIRDlON0NQeTVkK2daWjkzL1Zs?=
 =?utf-8?B?Ym1aQVlFOWI3cVVmb084NDZxUjkzUEhPT0hRYUVOSjdGdUpOR0puRHI2SU9J?=
 =?utf-8?B?UVNMVHVXRTNOSnRsVitmaGk4Qlo4c0k4U1gzUXhpRjVEZjBBaVk2UXFDVzRT?=
 =?utf-8?B?bTVRd2xrdDloOTNRNHNJa25XZU1MMTliZTJDd0ZrQnZDQ01oWUNrdGNveEw2?=
 =?utf-8?B?SVRPSXNJanF3V0xmMGErdURYYlZsZDNIeFhKNGovVDdGellEeVZWZ1dZY0w0?=
 =?utf-8?B?eGViY3dwNjk4UWptaFNnREJlMSt2Z3RpZkVOTU42WnE5WGtCS3dWUlBNaHVY?=
 =?utf-8?B?bERqSEZydFhybkd3L00wUUtOeVp3WWpGYURXK1ZmZ0pWbG1qelh1VWd6RDJ0?=
 =?utf-8?B?MTVPSE80YnJNZFk3SmZCOXlaZUd5ZGlnSkROaHQwVnlWZExDS21zbURTcmJW?=
 =?utf-8?B?Q0MyWGVFMVVqSExkbURwWFZmaWVIQ3pKS05LcmZRRmFTTWlNUUo1Z3VJZ1JY?=
 =?utf-8?B?TVhJVW5nUXNYRUprSU5menkvVXcvb3NwVlMxSEZPQ1I3d1ZTK3RIVk45V3Mw?=
 =?utf-8?B?N1FsUitwbnB4bExpdVA4czExQSt5KzUvV3RIVkxXN0FtTDczdEE5aVBLQ3A0?=
 =?utf-8?B?aU9Eck03STRIUWFjZU5WNllyaklGVVdVUVgzMkhlYnlDRlBDQ2pDV01uZ0pP?=
 =?utf-8?B?WTVtS2hRZFVNZEVGZHNVQzlsczdTUlpuT0Q2RVV5bmI5dVRabmVGaE1zRDhZ?=
 =?utf-8?B?OTBZTFAxRUNlMm1Udng0Y09hazRXcStzaFh0eDl1VjM2WFlFSmNRL3l3Q3hK?=
 =?utf-8?B?dGMwRXlncVMxU3IyMUEySEpmN1V6TjNwUXdaQnVVdUJWUE5PSmo3UVplcmZh?=
 =?utf-8?B?ZnBITnFRVXFYUUZTNkgwSW1oNXcxVjgweXptenVTSmZROC9sL0J5b3NJV3Nj?=
 =?utf-8?B?MnJINnY4alVDRWlxanVZOFJLMlJUemFjVzZ6OCswdEhPeTRRSGF2MW9pakZG?=
 =?utf-8?B?SUF6VUFCOGdSekhFY2RRRE5FV1NxbnRsbUM4azIwZC9WVk1kdERrbjE5ZzBm?=
 =?utf-8?B?alJ1cWplRXR5QkxmMVRyTmh1QnRKZGM1Y3U3bm1FSlJBOGRXQ2pNNElyMU0w?=
 =?utf-8?B?SVdtZ1BCcFoxdnhHWGtWY3cvdmRrNVBsQ0NKRkU3L2FnamtUTGlyMUNaZ2Fq?=
 =?utf-8?Q?7ORLjF6zY41F2yb4+Vp+O3u0VXT6Ob8bDW2gYSn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnY1WDEvaE5DU3AvQmY1aFMvR2pQRnpGc1NCb0hIaVQ4V3NDMk1MNHR6bE5E?=
 =?utf-8?B?RW80eDlSakI4Z2gycEdNVU5xTHYzTElDVzU0ZXYzOW1jMGRGWTV1bmNHNzRt?=
 =?utf-8?B?S251SjQ0NnNnQmZVN2xhRDIxNlRuS1JRYnM2S0lEYUZIUWJkWEE0NUdoenhD?=
 =?utf-8?B?TExHTTVYQ0dCdW43ZjVKTmhITm40NUV4bWxzb3R5S2o3dXRLWSt4VEFiSHB4?=
 =?utf-8?B?VzFKYWdNdU9GY3FmYi9sT2QrRnBxdXhLaVZRdnYvTHhjRUZZRVh3TGhhMWg4?=
 =?utf-8?B?ZUNvQkRZVmZ3UWxBZS9ITkNBODlZenFiUmRzSGxnaUMrSXNmZ1A5NlFkVzR2?=
 =?utf-8?B?V1c3KzZieTBBRDkydDhlVnBTQ0JwbDNRT3hMbWJ3NEpoTXhwNGJ5bEFrUlJt?=
 =?utf-8?B?UUVtcUU0Y1hQcWtzQlpxcjd0eC8wMHBDNGRyeXR4ZkNVWjY1NTdGK1dnc05v?=
 =?utf-8?B?RjRiZEkvdEtrMW9iVytDSFcrVks4bHJTdkwzWUpQWG5YTGZ0VjNlMTVSZ2lY?=
 =?utf-8?B?QmVkUzR0UEtXTHJPQ2ZNODdHUzhEdWwvMEVGaUJHeGNWYkkxQ3FObkNUZjNC?=
 =?utf-8?B?VUhnL2F2NGxkZ3F1alB1NnhvOUJVNG1rSk9EZHkvS29hYVhTbnA4bHF3M25L?=
 =?utf-8?B?RXl4dVVYQnR1QnJ4dFZZUDF0NEtBbE5IM3QxNm1XS2k5dCt2OWxmbVJPN1ZD?=
 =?utf-8?B?dUhYNXUrTndwMUlNRDhBN3I0VEVBY3ZOdXVwa3RKTS9ic2pENEFxblU4NmI5?=
 =?utf-8?B?NmFzdFVUQlAvRG95d1B4c2NjTWFua1c3Nlk5TUNkbDk1SXhzUkdlN3k5RHk1?=
 =?utf-8?B?SW9ZdHAzMlFqZXdtWWE3WFl0VzBnb2FqajFDb1NkU2lNQ0hUV09YRHg5dlpN?=
 =?utf-8?B?bDVuR0VzY3YwYWF1bkMrMjFKS1U4YWF3NWt5UmZIT3BEQklkS2Z0L1VPYU9k?=
 =?utf-8?B?RmlEY3paYkRqeFF0Z2EyV1VnbzlQTGcvS1VUNS9zTVBOUTV6M1dMLzA3Sk9o?=
 =?utf-8?B?ellqMDV2RnRYSmtSU09zUlNUTlpvU013cTRPTzFFVk1yMFB4TjZRS214Y3RD?=
 =?utf-8?B?eG12QWVFVCt0Ri9WVGZDNkVUTmZWc0RPblR3VDh0VWkwNGRHS2RNcW54TU9R?=
 =?utf-8?B?RnhpNHdBMnJBNzNuLzYwMmNzaVMvQmtHb2twUlZGamdkOFdTNUlHVlQyU0hl?=
 =?utf-8?B?L3Q0cE80VkNzakVpYVpUcVlwZW9mb3JrbE9Kb2FWWDBkOVFwcndaZFpKZmtT?=
 =?utf-8?B?aW8yNGk4akQvbXErRUdmcHJBL1BDVXBaTzhzd3ZkcUVFTTBobkFWUG5IWWc4?=
 =?utf-8?B?N05YZ3NvUERUZGlVN2t2eXcwR0tTTnc0bnRzZzFWaFlNdGpwWTRxb3B0ck1z?=
 =?utf-8?B?NGErRlJRUUY2T3pJakJwSU56RjdSY1g2OGpER3R0d05QNkMyRlRuNXJ6Vnl3?=
 =?utf-8?B?VXFsQm5Ba0xFbXk4TTlBNW9TZzJHVWZCRSsxNTFtZkt0Vjl2YkdLVFo0M2Ro?=
 =?utf-8?B?MjFhTnpSUXN5T3J4ZHdrcVFSS0swTnV6Mk5CVmg1MzhGRDBrenZ3UTl2M04x?=
 =?utf-8?B?UkVzem5hZDJhcng3M2tJTFZOZ3MrSjFhNHVraGtuOGV2a0J2WXZvOEZmTjlw?=
 =?utf-8?B?S3FVMUNHMUw1K3BTd0VUYjNVYmdNL2ZFK0k4c0p4WGM4ekpHRVh2VldDK1FJ?=
 =?utf-8?B?cmNYY3l1bGhRMlEyTFRDanh6MkRmVFVrNkRiSXBMb1FaYXViaXc2WFZtNWdq?=
 =?utf-8?B?c0tValZFVjRlQ0s4M2tDWlg1OWpVdld5bkRPblFmUjNsR0lKVjRBMktPQ1VT?=
 =?utf-8?B?OS9kK0wwcGw4OUhxUW9hMHFHa3hIQ0JUalIyeUd5ZXhZQkc2RVROYkx4RDBX?=
 =?utf-8?B?S2JDRmFvY3BwVWVWQUZRMmMrY21UeEJ5azYvS1VmSnRteXRzYVhCWnFzckxw?=
 =?utf-8?B?cUtPbFEzYkMyR2twVXVEcW1IbzBOUWdCaEFiZENyU0VKZzNqRDQxbWZKMVFU?=
 =?utf-8?B?YlFyTzh1SmpaY2lwUHd3cVBLRlY4T3RIa1A2VGM3anM5R2Y0QjZYaEpCYVRy?=
 =?utf-8?B?ekRWdUZPNEJIbWdyK2VOSVVLRmpxNllGQVE0cUtEUzNGMkFOMXlGcXh4ZlNm?=
 =?utf-8?B?NS9QWjNHS1lITTVKNSs1ZEZkdkxkMi9qZEwydzZwVzJCdFNudDlkRFQyTVZk?=
 =?utf-8?Q?eaV+IHgZQQU5XCEIJfAqRaI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f33baf-fabd-45ef-0dc7-08dd51c3893a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 15:30:42.0577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKVdCG/Q6hVGAfNO+Xds044LFxS5rFnt1sj7Mj6BpUjOUTRUpbT/XPXS5ZjXH2K5/kJQTjDoTpct3DFgBWAmWZEBSVO8ybK2nqmRgA1fRDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8200

On 2025-02-20 09:42, Mathieu Desnoyers wrote:
> On 2025-02-20 05:26, Gabriele Monaco wrote:
>> Currently, the task_mm_cid_work function is called in a task work
>> triggered by a scheduler tick to frequently compact the mm_cids of each
>> process. This can delay the execution of the corresponding thread for
>> the entire duration of the function, negatively affecting the response
>> in case of real time tasks. In practice, we observe task_mm_cid_work
>> increasing the latency of 30-35us on a 128 cores system, this order of
>> magnitude is meaningful under PREEMPT_RT.
>>
>> Run the task_mm_cid_work in a new work_struct connected to the
>> mm_struct rather than in the task context before returning to
>> userspace.
>>
>> This work_struct is initialised with the mm and disabled before freeing
>> it. The queuing of the work happens while returning to userspace in
>> __rseq_handle_notify_resume, maintaining the checks to avoid running
>> more frequently than MM_CID_SCAN_DELAY.
>> To make sure this happens predictably also on long running tasks, we
>> trigger a call to __rseq_handle_notify_resume also from the scheduler
>> tick (which in turn will also schedule the work item).
>>
>> The main advantage of this change is that the function can be offloaded
>> to a different CPU and even preempted by RT tasks.
>>
>> Moreover, this new behaviour is more predictable with periodic tasks
>> with short runtime, which may rarely run during a scheduler tick.
>> Now, the work is always scheduled when the task returns to userspace.
>>
>> The work is disabled during mmdrop, since the function cannot sleep in
>> all kernel configurations, we cannot wait for possibly running work
>> items to terminate. We make sure the mm is valid in case the task is
>> terminating by reserving it with mmgrab/mmdrop, returning prematurely if
>> we are really the last user while the work gets to run.
>> This situation is unlikely since we don't schedule the work for exiting
>> tasks, but we cannot rule it out.
>>
>> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by 
>> mm_cid")
>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>> ---
> [...]
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 9aecd914ac691..363e51dd25175 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -5663,7 +5663,7 @@ void sched_tick(void)
>>           resched_latency = cpu_resched_latency(rq);
>>       calc_global_load_tick(rq);
>>       sched_core_tick(rq);
>> -    task_tick_mm_cid(rq, donor);
>> +    rseq_preempt(donor);
>>       scx_tick(rq);
>>       rq_unlock(rq, &rf);
> 
> There is one tiny important detail worth discussing here: I wonder if
> executing a __rseq_handle_notify_resume() on return to userspace on
> every scheduler tick will cause noticeable performance degradation ?
> 
> I think we can mitigate the impact if we can quickly compute the amount
> of contiguous unpreempted runtime since last preemption, then we could
> use this as a way to only issue rseq_preempt() when there has been a
> minimum amount of contiguous unpreempted execution. Otherwise the
> rseq_preempt() already issued by preemption is enough.
> 
> I'm not entirely sure how to compute this "unpreempted contiguous
> runtime" value within sched_tick() though, any ideas ?

I just discussed this with Peter over IRC, here is a possible way
forward for this:

The fair class has the information we are looking for as:

   se->sum_exec_runtime - se->prev_sum_exec_runtime

for rt and dl classes, we'll need to keep track of prev_sum_exec_runtime
in their respective set_next_entity() in the same way as fair does.
AFAIU it's not tracked at the moment in neither rt and dl.

Then we can decide for a threshold of consecutive runtime that makes
sense to trigger a rseq_preempt() from sched_tick(), and use that to
lessen its impact.

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

