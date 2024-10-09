Return-Path: <linux-kernel+bounces-356278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D029995EF1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFA32865D8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 05:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D63A156242;
	Wed,  9 Oct 2024 05:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VY5cZ0i9"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A995D39AEB
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 05:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728451582; cv=fail; b=bXHS+rOfcmQNVm7ycvXQAPvkT2W8AvaxyS+Sv8JHc7YYbMbHLpNGvdgIac9nDpsDq9ixAkhvNdrPy3pNnm/66u5pgdaTpEjajKq2UsrJeyXVfITJobuRcrURONiJaq+EJpdTfSr4pgCn0Bd5I9gEnvG1M92m/xvCQPbJ92bVEJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728451582; c=relaxed/simple;
	bh=6Io6p5nwRa6evz6qSjssHPpLpFiqiHuBrRMfRuhqVFs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iIFUcKzkkw6FRzNMJvviC+3TqJyDqcYzihPffTIRUjFDXj3SlQoU41d/YgsZNBxoh/MDCuITH1K4uEJ8jUHV8J8ELtL+VSw0Dx6g4wv/RUF3Mn7nZ+QGOBDSoMP0GrqAUEjQA1KCEoFjBwArUmIBSVMHjNKg8JRCoUW07ux8z5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VY5cZ0i9; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kP1xnF3GiAkg5qqRwS/GHYMW7+NKuEIyGYDWhj8eUsDZ533FuD6+weT4U3PvM48K0a1wQBsUgUsISUZni2oIAfEf5BmA2KTSqjXwgILmWeLD6Q2d5NKZCk3WqQThgcNw11Mx2CjUGj3nFR1aIR7f99Q3CwV3UrHmPS/OlcaviC/f7rMfpPqeahKt5Upl1srEzIatAJQp39OYvkRSEh4CWFicxumJ01i0XuJ/pAFW/8TpMUcQ+6GX6MPcU1Iiearx38TEaR5AvEfb6m2ufylZtNKfBJ0OQ79rtq5fb8uHNCNzCXcSpwupZvHalcA0DdaTHxgbOIld3mKYc0xDQ4I40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0xFSE7pNRZSdFnU1gTs1n3ggWS1wfWMXssPpMUxaPs=;
 b=g1enYm6lGqRiPc6uqi93aZykLHDDYXKhGHcfvxvA78qi0Pp1Cdv46DqBQajq3yslmKzSnH7acztyLAIHEfLQNPBteOz3/t6pdFo+JJgaM4FfbPpb10Ip6pwLU+xDBLiStGbKOiGGyb4sMRLJ2qVqxBkQDTCvwhkM23j9TpxTgqeJhFjBLChZW3lW2w31dmdoY9R7aV2PPBJiIjAyqSX5sZs+BT/cGtrdRJsei+I+RTON2KSpMkFQdc3xOwd1yUZjCuecWcHBsjVSuCKi4a6Sm90htiIOa+aWPRYByHr9YNT8d/x78MVtRbixERwqYeH4ydAfPjrLdRL/+8NSu1VvWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0xFSE7pNRZSdFnU1gTs1n3ggWS1wfWMXssPpMUxaPs=;
 b=VY5cZ0i9Gm2HbhNwqmwDYDoi2uF8UQzkfTaP5bozVzEAWqTXLNtnLiTelrtt/dXp2uzxMMezRHnrqHKV9nW117/xWQ7h5BOesL0s4U1lVcN8V5eYq4i3Lkbc1A6WoF7eRQojRLy9AEQt+6Bc9gd+YidQFmCt/4BEs2Puh03IQxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 05:26:18 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48%6]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 05:26:17 +0000
Message-ID: <99beed41-c7b1-3d62-9c6f-1b9999a3fefe@amd.com>
Date: Wed, 9 Oct 2024 07:26:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] kaslr: rename physmem_end and PHYSMEM_END to
 direct_map_physmem_end
Content-Language: en-US
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand
 <david@redhat.com>, Will Deacon <will@kernel.org>,
 Alistair Popple <apopple@nvidia.com>, Jordan Niethe <jniethe@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-mm@kvack.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20241009025024.89813-1-jhubbard@nvidia.com>
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20241009025024.89813-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::13) To IA1PR12MB8189.namprd12.prod.outlook.com
 (2603:10b6:208:3f0::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8189:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 35915faa-538f-4898-8f63-08dce822e672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anNhK3VuaVZyNjRlQXlCZ3pIc3JsanlyWjBPKzYrQmwyamVOWWo5YnRtcGY0?=
 =?utf-8?B?aU04ZUxCRC8yeVJwbXdnTjRlVHA5WFQvVE1VeXFsS2o5aDVkSDFnSzJxUFJj?=
 =?utf-8?B?TDdDbFNHZHJBK1FFOThtREovQ2hERThsSGlKNldCMFdlZnZpWWZKSCsxckN6?=
 =?utf-8?B?VXBUVW16S3A0Q2M0WllLVE1KblFYRXNVN3ZwbThidWxIcWZBZ2t2b042L3lW?=
 =?utf-8?B?M2lyOHdJUUNWQWNJU2F0NzByb01YTk1TcnB1aEF4T2ptSTdKS3N5ekt6d1hr?=
 =?utf-8?B?V3poSVNWVG00Z2plL1ZFY2pBWDZNQTJoOFFnSldwK0VwYnhsYUJESjdKTFNV?=
 =?utf-8?B?ZTNoYWxoVFV0aW5aRE9oc1lBMUhvTEpOcDliZk9pVUtGeHpPVlh6NXBZZk80?=
 =?utf-8?B?RGtHWVJHMXd0b2ZUMG5uSUswTkhudXZNdC9KdlA1djREa1RvVEEySmpOT0l6?=
 =?utf-8?B?TUxuakYra2VWNjh0Z08rU25jZnVZU3luSXg0d1VSNTZLRCt3bVJzYXl3YjNM?=
 =?utf-8?B?T0tDZVA3Sjg1NFA3VmY2NHBTMGE1MnA2NU1MajdxMWNzUWdWN3JaSlhPbDAv?=
 =?utf-8?B?YVNzamc3c2xkOS9LS0JPS1lla0dDVm1rR1hzRk5OY2FtZzQzV0VTTUtTNUhv?=
 =?utf-8?B?QXN6MjJnbEpCd29OMFB6NlNWTThYcHFDR2wwRG44TnZ3Z01CWHFmUWg0czFS?=
 =?utf-8?B?UTZzb00zdWI2UDlLQlljbytNNkpmZGNHVnMvc21YbWoyN290MWlxRGYzRVBH?=
 =?utf-8?B?R3BqbUdFY2IzRWlGKysrOG11aFl6bFJpM0RsREtCdm9QdVJralRnelcrajRp?=
 =?utf-8?B?ZkkwVWxZa21NZ2lZQXRxdSt3ekRITHIwYU5tSkVGcDRHb3RLSmx6YzdDVDZI?=
 =?utf-8?B?OC92cEVZcDVHS2FpZklzWGtPeGsrZWJnZlN6QmlVUDBqMWRzYnN5TGwySVNt?=
 =?utf-8?B?WnlOSThYWXBTLzRZY2EyNjMrUGhwbUR3bVhkdm5OcklzcE5vRTJ1WU5SbFR3?=
 =?utf-8?B?RDUxdU5RQTJmRGt2Qlk3ZVE4UnlsL3JYKzlESUZVemY1OE1sVFIvWDF3T2ZF?=
 =?utf-8?B?MEdEL2tXRFd5QXFNZEMveTJZZDhLemo4SXJueUJPTzd0ZlYySGdMNlJZQ0R1?=
 =?utf-8?B?Y213WHFlZ2haSUF0UkhMUFNlME9neWZVRUQ0Ty9WTk9PR09ISWxXNzVxVUpX?=
 =?utf-8?B?L05jWVZLSDZoZlV4Y2xSVDhEb3RHaDJ3anZxb2VSS0R5OC9oa0dTb3RiOWhv?=
 =?utf-8?B?Q3JIYVZYV2o5V3A3Z0ljK1hTdklwQklzaTdqbGljclR2L2FmYStmM2IxOXZx?=
 =?utf-8?B?S0l4Z3RrNllZWCtudGdLMDJoRzFPNTNSZmtFV1VrSEEzTTFRT1kvYXNvNW5I?=
 =?utf-8?B?TjhHSWIvck5RVERjM2VHMDkyQmVIZ0tKWGRzZTJqbGtEMmN5RVhEYW5qY1RN?=
 =?utf-8?B?RS9WaDMwQlJKaHdZUlZDMjQ3VnU0NnlJekxzSjNoYldpNER3dFFVWS9FVytC?=
 =?utf-8?B?cmd5dDN4SDFKRzZsN2tGSXh3WklCTzRneXk3cG45blBpYnVEb0R1eDU0S1FZ?=
 =?utf-8?B?U3VMYTBUeEtOd2lLbG04enVSTS8yL2wweCt0RnlKbUdxdnBCVjJ5K0VrSHA0?=
 =?utf-8?Q?zJXUAimrfaLmisEuYh2jC26aIwVwL3KQsYQ87yd0eYNw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2dzRlNaMjFhQUIyWVlyc091dU1uTHFtaVJiRVVJcmJGYmNmUW1SV3hqM1Zz?=
 =?utf-8?B?Yy9mejk4SlRrbXU5WWUvdTlZNDcxVG9mRFpYQ3F0b3ZwZzZvZXdGRVNJSHZG?=
 =?utf-8?B?ZHJ6MXN6UHBPaTVvNFhJVUE3NE02WjZSb0xaWXVpM1JnS0k4QXZ5Y29zWGlB?=
 =?utf-8?B?b1ZrR0gycGQrclhTVVc1dmNPNGtrd2lNcWpaL2p0ek9MRDhzVldvSTZiLzNI?=
 =?utf-8?B?bVdGUms5Smx3LzF6STZXNmk2NXhvd2pjbGh4UXk2Zmp4a0crMW1rK0lmTUJ2?=
 =?utf-8?B?ME40LzBIVkR0dXgzYlpUQkRnMThHdzZ5QVhmTi9ZYitCTGU3MFMrd1RaQzgz?=
 =?utf-8?B?WFZ5bHdBcnhZMEM4YVZPdW9UYXplQTlkU05nZUxQemxNbUl3c3ZEZURaOTlU?=
 =?utf-8?B?M3h2WGZWV0NoS25qcmtRMW5LSG9sYUl4MW9FMjdyTkFFUTdPd2NVSExocVBK?=
 =?utf-8?B?MytzNG42Ny9IUU5rS3dVOUlNYzhEWm1MWDJnVlNBcVdxUHN6SGtkbC8rMHBa?=
 =?utf-8?B?R2ZsWE95dFZiekZQdTZPSFpKbVZSdTZkQkhGcUVqU3NoZzArU0dnK2VjK0cx?=
 =?utf-8?B?NS91K01UanJFN0hrcEJselJhZklJMzhNeUVPWlk2OENUQ0xzWmkwZFpMTVA2?=
 =?utf-8?B?bW5ZbkxHUTgwUEpzaHNiT2xzZ0gxd3VmRjY5TWFoUENSQnJiS0hlbnVQL20z?=
 =?utf-8?B?RU90clBUZkpvVjVZcG9xN3NLd25ndUNoTTh0SGFBalRGZFdPTVJoV3cxTmR4?=
 =?utf-8?B?aUdKaG50VGRUNkJ3ZkozMkZ3TFZweU1uRElGbkQ3Zy9mSlRzeGFuRm9neldK?=
 =?utf-8?B?L213NmFBWEJNQkk4MkloMW0wRmE4ZXJ6VGJMbDF1Q0ZnQ2I0SHMreVNkcFk5?=
 =?utf-8?B?Y0VpM1ZGNTJzdW05aTNIWE5GZm1LS0g5cDBYL0RpbzJhMW5iZjFzK3FDR3Zz?=
 =?utf-8?B?RFFFOVNQMmhoSm9XRDZpdXphVzVFaHNmVzgrVlpqakRiVDFKcUV1eXcyejhB?=
 =?utf-8?B?dUdNSVlINmhCQTRJR3ZzdGR5aHc5c2hHTk0rYTlIbmMwYUtuOTBIem1pa3Jq?=
 =?utf-8?B?OTlhUTRGYStIdWlUTHh6SzVQOWVRNmZCTnZ5allwNGkxOHJCREhUSEJzemFH?=
 =?utf-8?B?ZXBDY295VkZQdVN6eXNFcmh4aC9kL2REYWozbzdRd0NiUzQ2Ri8yVEJZcEdB?=
 =?utf-8?B?cDBUUnYyVWFzbzNXZ1dhK0VPZkZYZUhzemVPWVVldCt3bTFCWFRHQmZPL3JU?=
 =?utf-8?B?a0V2NW5LN1pwVW5vcXlxZ1V3UXJrcnJueTNJZWZpM2ZuaGllVmNHb2xNVGhX?=
 =?utf-8?B?Z0UrazZQY2hnM29wUXlwbEY1cGtidXNkdGpwWUl2MGJFSUxJZ0dqdnpYSFZW?=
 =?utf-8?B?VFpEa0V0NURrdHJ2ZXFIWXRyMk4yTFJWTk5HdXRvN1owcVNSMFA2VkY0TXdG?=
 =?utf-8?B?Zk95enZkYnE1NnhVVFcyOW4rWW51Ly9uekNJUk9GRWdXdXBnb3BTaGVMTXRs?=
 =?utf-8?B?SExkb3BZc3lWRjlOeituZmhIblZHQnh2WVFmS25XQTNwdlJIam1sN0xOd0hP?=
 =?utf-8?B?TzRqcGJTV0hmeEJPcmUwQks5bFZPa0ovM2NKSmk5VUQ0anFqL2ExOTl2RzRC?=
 =?utf-8?B?eTVvSDREajJ5bjVmcHFCaXpjQ2IwUWJzdWx5NWxnYXUzNmM1VzJ1MGRyU0Vy?=
 =?utf-8?B?c1hONGtBZUZ3SFQ4eFprMDB1QTlISVMzSHBXdjdaRkJYSU9XeDdZWlZ6Ymlx?=
 =?utf-8?B?TmliL3hSSit5akVQUjNRR1BWM0xiWGhTSUVPR0NSSEwzNUlWY0ZrQVZrTmJu?=
 =?utf-8?B?S2Q2YzVRci9yZjdiZ2E4cGdPV1Rmd0VYd205NGkyaFY0SkJnSjJWdVloUHhG?=
 =?utf-8?B?MkdjaUNtNmQ3UkI4cWU0VjRldTY3VmYvNXFNMDU4WGdrVlp2am9hTEhSMEU2?=
 =?utf-8?B?Snh6aE5KSm9UTStUSHZWZEttZXdyK0hrYTVsSHIxSU5ZS0VBOCsxWkxmNElx?=
 =?utf-8?B?Y2NCUysxM0Q5ZzhVMndQTDhleENpKzBuNisyeStoQmlxOE44b3NCZjVUdlRP?=
 =?utf-8?B?UHpqM2hLekhwYnlPTllKNmpyZlcvS01STEZJc1RIYzUvbUU4cDFESjB6V1R1?=
 =?utf-8?Q?iP6UkKdba+5DLrgsNhSN/HlQA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35915faa-538f-4898-8f63-08dce822e672
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 05:26:17.4170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVQ4a2keqk9Tu8fQTAaGcmCmXY90Wwcl2sTknQQc8BI+HmOfV7uKe+hXO/JS3uILN0SLiDzg0GnvCm+dqQxbvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183

On 10/9/2024 4:50 AM, John Hubbard wrote:
> For clarity. It's increasingly hard to reason about the code, when KASLR
> is moving around the boundaries. In this case where KASLR is randomizing
> the location of the kernel image within physical memory, the maximum
> number of address bits for physical memory has not changed.
> 
> What has changed is the ending address of memory that is allowed to be
> directly mapped by the kernel.
> 
> Let's name the variable, and the associated macro accordingly.
> 
> Also, enhance the comment above the direct_map_physmem_end definition,
> to further clarify how this all works.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Jordan Niethe <jniethe@nvidia.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Seems reasonable to me.

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
> 
> David Hildenbrand, I recall you had an unanswered question in this
> vicinity [1] when tglx's recent kaslr fix was being reviewed. Maybe this
> will help with that.
> 
> 
> [1] https://lore.kernel.org/linux-mm/ee205448-5fdd-495e-9d7c-c8a2b59f9c9e@roeck-us.net/T/#mdf442f077c9023590e144dbed2b04a109793484d
> 
> thanks,
> John Hubbard
> 
> 
>   arch/arm64/include/asm/memory.h         |  2 +-
>   arch/x86/include/asm/page_64.h          |  2 +-
>   arch/x86/include/asm/pgtable_64_types.h |  2 +-
>   arch/x86/mm/init_64.c                   |  2 +-
>   arch/x86/mm/kaslr.c                     | 14 +++++++++-----
>   include/linux/mm.h                      |  6 +++---
>   kernel/resource.c                       |  4 ++--
>   mm/memory_hotplug.c                     |  2 +-
>   mm/sparse.c                             |  2 +-
>   9 files changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 0480c61dbb4f..73eaa8c2536a 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -110,7 +110,7 @@
>   #define PAGE_END		(_PAGE_END(VA_BITS_MIN))
>   #endif /* CONFIG_KASAN */
>   
> -#define PHYSMEM_END		__pa(PAGE_END - 1)
> +#define DIRECT_MAP_PHYSMEM_END	__pa(PAGE_END - 1)
>   
>   #define MIN_THREAD_SHIFT	(14 + KASAN_THREAD_SHIFT)
>   
> diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
> index f3d257c45225..d63576608ce7 100644
> --- a/arch/x86/include/asm/page_64.h
> +++ b/arch/x86/include/asm/page_64.h
> @@ -17,7 +17,7 @@ extern unsigned long phys_base;
>   extern unsigned long page_offset_base;
>   extern unsigned long vmalloc_base;
>   extern unsigned long vmemmap_base;
> -extern unsigned long physmem_end;
> +extern unsigned long direct_map_physmem_end;
>   
>   static __always_inline unsigned long __phys_addr_nodebug(unsigned long x)
>   {
> diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
> index a98e53491a4e..ec68f8369bdc 100644
> --- a/arch/x86/include/asm/pgtable_64_types.h
> +++ b/arch/x86/include/asm/pgtable_64_types.h
> @@ -141,7 +141,7 @@ extern unsigned int ptrs_per_p4d;
>   #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
>   
>   #ifdef CONFIG_RANDOMIZE_MEMORY
> -# define PHYSMEM_END		physmem_end
> +# define DIRECT_MAP_PHYSMEM_END	direct_map_physmem_end
>   #endif
>   
>   /*
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index ff253648706f..5a564130b9d0 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -961,7 +961,7 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
>   	unsigned long end = ((start_pfn + nr_pages) << PAGE_SHIFT) - 1;
>   	int ret;
>   
> -	if (WARN_ON_ONCE(end > PHYSMEM_END))
> +	if (WARN_ON_ONCE(end > DIRECT_MAP_PHYSMEM_END))
>   		return -ERANGE;
>   
>   	ret = __add_pages(nid, start_pfn, nr_pages, params);
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 230f1dee4f09..70d3353c92fa 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -52,7 +52,7 @@ static __initdata struct kaslr_memory_region {
>   } kaslr_regions[] = {
>   	{
>   		.base	= &page_offset_base,
> -		.end	= &physmem_end,
> +		.end	= &direct_map_physmem_end,
>   	},
>   	{
>   		.base	= &vmalloc_base,
> @@ -62,8 +62,12 @@ static __initdata struct kaslr_memory_region {
>   	},
>   };
>   
> -/* The end of the possible address space for physical memory */
> -unsigned long physmem_end __ro_after_init;
> +/*
> + * The end of the physical address space that can be mapped directly by the
> + * kernel. This starts out at (1<<MAX_PHYSMEM_BITS) - 1), but KASLR may reduce
> + * that in order to increase the available entropy for mapping other regions.
> + */
> +unsigned long direct_map_physmem_end __ro_after_init;
>   
>   /* Get size in bytes used by the memory region */
>   static inline unsigned long get_padding(struct kaslr_memory_region *region)
> @@ -94,7 +98,7 @@ void __init kernel_randomize_memory(void)
>   	BUILD_BUG_ON(vaddr_end > __START_KERNEL_map);
>   
>   	/* Preset the end of the possible address space for physical memory */
> -	physmem_end = ((1ULL << MAX_PHYSMEM_BITS) - 1);
> +	direct_map_physmem_end = ((1ULL << MAX_PHYSMEM_BITS) - 1);
>   	if (!kaslr_memory_enabled())
>   		return;
>   
> @@ -145,7 +149,7 @@ void __init kernel_randomize_memory(void)
>   		vaddr += get_padding(&kaslr_regions[i]);
>   		/*
>   		 * KASLR trims the maximum possible size of the
> -		 * direct-map. Update the physmem_end boundary.
> +		 * direct-map. Update the direct_map_physmem_end boundary.
>   		 * No rounding required as the region starts
>   		 * PUD aligned and size is in units of TB.
>   		 */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ecf63d2b0582..92c35fb60d18 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -97,11 +97,11 @@ extern const int mmap_rnd_compat_bits_max;
>   extern int mmap_rnd_compat_bits __read_mostly;
>   #endif
>   
> -#ifndef PHYSMEM_END
> +#ifndef DIRECT_MAP_PHYSMEM_END
>   # ifdef MAX_PHYSMEM_BITS
> -# define PHYSMEM_END	((1ULL << MAX_PHYSMEM_BITS) - 1)
> +# define DIRECT_MAP_PHYSMEM_END	((1ULL << MAX_PHYSMEM_BITS) - 1)
>   # else
> -# define PHYSMEM_END	(((phys_addr_t)-1)&~(1ULL<<63))
> +# define DIRECT_MAP_PHYSMEM_END	(((phys_addr_t)-1)&~(1ULL<<63))
>   # endif
>   #endif
>   
> diff --git a/kernel/resource.c b/kernel/resource.c
> index b730bd28b422..afa3ad09b834 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1871,7 +1871,7 @@ static resource_size_t gfr_start(struct resource *base, resource_size_t size,
>   	if (flags & GFR_DESCENDING) {
>   		resource_size_t end;
>   
> -		end = min_t(resource_size_t, base->end, PHYSMEM_END);
> +		end = min_t(resource_size_t, base->end, DIRECT_MAP_PHYSMEM_END);
>   		return end - size + 1;
>   	}
>   
> @@ -1888,7 +1888,7 @@ static bool gfr_continue(struct resource *base, resource_size_t addr,
>   	 * @size did not wrap 0.
>   	 */
>   	return addr > addr - size &&
> -	       addr <= min_t(resource_size_t, base->end, PHYSMEM_END);
> +	       addr <= min_t(resource_size_t, base->end, DIRECT_MAP_PHYSMEM_END);
>   }
>   
>   static resource_size_t gfr_next(resource_size_t addr, resource_size_t size,
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 621ae1015106..c43b4e7fb298 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1681,7 +1681,7 @@ struct range __weak arch_get_mappable_range(void)
>   
>   struct range mhp_get_pluggable_range(bool need_mapping)
>   {
> -	const u64 max_phys = PHYSMEM_END;
> +	const u64 max_phys = DIRECT_MAP_PHYSMEM_END;
>   	struct range mhp_range;
>   
>   	if (need_mapping) {
> diff --git a/mm/sparse.c b/mm/sparse.c
> index dc38539f8560..4cb9793f0b52 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -129,7 +129,7 @@ static inline int sparse_early_nid(struct mem_section *section)
>   static void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
>   						unsigned long *end_pfn)
>   {
> -	unsigned long max_sparsemem_pfn = (PHYSMEM_END + 1) >> PAGE_SHIFT;
> +	unsigned long max_sparsemem_pfn = (DIRECT_MAP_PHYSMEM_END + 1) >> PAGE_SHIFT;
>   
>   	/*
>   	 * Sanity checks - do not allow an architecture to pass


