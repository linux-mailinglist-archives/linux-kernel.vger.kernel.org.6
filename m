Return-Path: <linux-kernel+bounces-255061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01C9933B25
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E329B1C2120D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD4E14AD20;
	Wed, 17 Jul 2024 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fSE7a85q"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B3F1C36
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721212280; cv=fail; b=svHuIFXPHdvUjCnTlo8TnmBFE7aB9lhkDPCVivooYdwYNJFYOIKBWrVuhv/Rxzh+D9tCBKjH8R0H0bAiUOa9xsMQATJ5XNsmjGal/d6XzmDs6mnTn3koDvhmq9x8IashAJYOlotpNsbXjt937hxmYAta2zL6v9KQi4vil5E6lPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721212280; c=relaxed/simple;
	bh=ZbSR3T3hDMienNzaoVnrIosADk1k1ynyF3i9PzUmXBw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mFzEEUAjmgHP3t4U5Zo6OC1znruYWoioCxMwUJp4lQpz4Z3yGzKKMa5YehV5KompIquaLTmD/koZVj9RDz/C/IBLx+1vVvnNNhwWhwrgV+3AZNJmIUkTyMew0NdUHmfD2QWte51PBV19OUq1dDsIQztiXsZcrikFnZKVjIuDlP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fSE7a85q; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fd8f8fkavQPQem+WyWsTi4gb0zpv1fQVTpyliJC9x8HWXg0nmk9d0GaNF+r7WftRB9oSQ/mnNNOy36y7dcnU349ySqk3pwZ9X+vC0fAP6Erl3t5AO7d2c7d0r5916V5FS1yYJHaNd1hz7YaaNesYQfVmp1trREQQyWO+CGtq8SsOINg6Fq6LxqQ3uyR/pe+DLXWRRj0ArT7RtZ57qeU0PFak3XIDojAWrZXgZ8IZ51uauGCNTCwp2o3GDn0NoPpqEPrJLm/VLPX+GOdy8AEWmLgWJiEVpLr55EphuRi2pjLqB2TnKsvOFCGxrQaSUVSh/1FbIoPaD78SXDD5ZWPGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hehbd0jXiTF29YA/Couh5GxYYXmEOHOMsFTUqQ7vW0=;
 b=apyf+5Nh0z6szb2z9YGE9mAW0zr0VLlFe0qBoVe7q3TQmeP3U6vXKroZyYdQ5Xtn+8qJ7K47uq/aFbDo7jFMzFNNaeuffrpo9i16A/CqyA+uyPJxiI3hu+TTruEkDY8KdBETA3P0JQfgrCvChTJFxBmCbfR+tTjWWCMzOGSLF6+x4ocsSOo0irG2jp/dgW0ylQ+ww30muBiomHZwCdMHc1dUfBzgJ6PEIJWEtMyZ7E6yPGTWz75usG1CHTB4svqtQ7dE0vcbh7vI7l0KA+bxe7RekouXZoCVGz5wlJab4+Vob0is4SyYRFiHHNoIjLM89ETnmZzAKQorHwN2MQLtxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hehbd0jXiTF29YA/Couh5GxYYXmEOHOMsFTUqQ7vW0=;
 b=fSE7a85q9S3xyOAUE6knsWTn5QqpaFMTfuc6Cy+lOdr2XN6+FJJn2Ibuk/zuH8DZ4kwybfx0Fyb7Er8MiA2pGqLOSIFkcPqdHs172SRREqLL0WK6X/pZFLUxgrHe3rpvkcF8PkEWgO5GufhNavXYhXphxhuHRYJsRx0co1zX9eo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 10:31:14 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 10:31:14 +0000
Message-ID: <ca9b925f-4f14-4749-8f28-83fd21f8ce6a@amd.com>
Date: Wed, 17 Jul 2024 16:01:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, nikunj@amd.com,
 "Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, willy@infradead.org,
 yuzhao@google.com, kinseyho@google.com, Mel Gorman <mgorman@suse.de>,
 Mateusz Guzik <mjguzik@gmail.com>
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com>
 <3128c3c0-ede2-4930-a841-a1da56e797d7@suse.cz>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <3128c3c0-ede2-4930-a841-a1da56e797d7@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0135.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::6) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: 24cbf99e-b0c1-460f-6781-08dca64b95bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkgwVUhUL1BQcUlQS2pwY1JkVkFVYWUxZ2U3b05oUEl6NGRhNERoam1xOHho?=
 =?utf-8?B?ckZNbjRqSkg0UFY1NHZXM0JpSm9GdjNqN1RjbkkwdFNBMVhwcHVXQmFWWmRq?=
 =?utf-8?B?RmtWQmlZWk0rZ2VQMkhTWFJybER4alYyOXowbUU4ZUhRU2hFQVRHUzVLcW9X?=
 =?utf-8?B?Szk5MlQzRXJ3RkVzQzB5SERibEdkeHhhTjg3MHRJZzQ0NWZ5WFl6L3pTSDBH?=
 =?utf-8?B?SDdOUVZrMTV4WllFaGJyUEhzOXZXMHpDOUVMa1pQK2lOdHRqQmszR1BYK0pL?=
 =?utf-8?B?RHJpUTYrTEtBbjh4b0RuR1lyRU9PT2xObkFLVERicE9HV2xRakUweFh3RTNa?=
 =?utf-8?B?RWQ5N2lBTzNzWDE3VU93YW4zOFdYM1RFM20vc3FHVU8zZ1QzeVB1d3AxU0Nu?=
 =?utf-8?B?WVg5MFdGTXhyVVVFWXltLzRZVVJ1ZHZDWXVUUW9zTFkwTVBhcy8xUXdoVFlN?=
 =?utf-8?B?WDlLNFJrTElCSWgrUWhTZmIvV2w4VTFzT0tHOXNma2VmWGNvZS9BSHpBRDlR?=
 =?utf-8?B?dU81aklXWUxCcVFDM1dWN21TcnFsRWMyYTI5SFdyT2ZBNEVOMjlzV2EwV3RP?=
 =?utf-8?B?R00zVGIvQUZmTEk5NXlFQVlVemlnNjZsNm41d3dWOHlIell2aGJzVGVaTHBV?=
 =?utf-8?B?SEttdklRVFhwUlJsSHpSQkpUVENac1BpYWN2aGtYb1ViUlJCUXFUak1PRGg2?=
 =?utf-8?B?anc5TUVFbGttZHBuN0k5a3dpR2hrOUtnMFVHTzQ0Z1pzVG1oNU95NU5WM3pr?=
 =?utf-8?B?MHoxSE81c2VQeitZUlJpMWxNK1AyV3M0elZneDN4ODRaZDRSd1ZlRU1vMGdE?=
 =?utf-8?B?ZVYzVGxKbkYvbWwrZ3BuMW9ScUhQc0hGTDE4UU05b09sMzZkUWJSdlZRczdu?=
 =?utf-8?B?ZGUyZUxlQ1Y3bnNhNmo1eUdFcUNBS0k3VEg2NjU4TThZTE5IZWRldGJRd1Qw?=
 =?utf-8?B?a1dvZ0N6UWZJWERQaGx2aWtYS1lrckYrUjNveWY2dUxFUW5VblkzdTdTNElm?=
 =?utf-8?B?b3BReDFPVGZ2Mmo2ODF2ZU9sT1JGVXlxMGl5TFVIS1pYRmpnNHgxTDRpSTdj?=
 =?utf-8?B?YkN6WE5HVHBvaUl3SmRIWFJ6aUREeURsR3dacG0yRVczcE1oOEF1aHdGWGh5?=
 =?utf-8?B?ZHJhTWNXdlMwVy8yUDZrdFJvVEZQaWExMlZGTDBsWHZpY2tRZ0ZBaUwwODM4?=
 =?utf-8?B?YmwvMWttYXQ5emsvVEZmZjZaeDBCQzlZcVRjSjlRdkE5NmZyakFaRUFGR3dw?=
 =?utf-8?B?VGJZbEVDY3FXQ0hkbExQZ2pCWVNJb1RCTWNOd0RzN3RNSU5rWTJzZC9mREpr?=
 =?utf-8?B?WkpVbVpUaDZ1enJldEhselJLUVRFSGprVTI3TjZIeXEwSUxFaStZWi8vM2Nm?=
 =?utf-8?B?VVZiNCtOc3ZLZjQxMmhNRVNHUEljVTVkblBFZVF1ZGgzTVhBaFFpMlZIZmpC?=
 =?utf-8?B?SGZqVDJSU1I0enZlYklYaFhKS09mR3I0b2lSayt5TjhQZkhDS3V5UHhrVWpL?=
 =?utf-8?B?ajI1THZicHlkbXhxYVBhZVNETFFLcE1WU0ZNVjJMWGFFdEQxWW9ndWQ2VkFB?=
 =?utf-8?B?bEFENVNNMkkrSmhQODdGTkx6MmF1ZzdscEQ4QkVuZ1RXZXRSQ2ZMc2R6WU9P?=
 =?utf-8?B?Tjhodm5FV3RCMThqRUpKSWQxdXVOcTFDU0xDWlNreDU4ZExZRkoyNVVieVI2?=
 =?utf-8?B?a1lzaGRCYmZrWG1SVGhrUkt6MC9SZlN0RC85c01sSEpVcXprdlp4WnRHWjVl?=
 =?utf-8?Q?qR3Qh2392YxaqS4s48=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE9ZSXl1SHpjN2FCVDB0enRHdS9NUHVzK2ZhNnNVQml3Q3JudWxEVENaZXRm?=
 =?utf-8?B?YVFlREpCVWpnOFFDQ2Rxa2ZWU3A3YmQ2N3F3L05MM0E0MXFLTG1wZFhRQ2x6?=
 =?utf-8?B?WGwxOHp4SEZJYkxMWEQvUjVTV0Z1VDB4ZGNuNGtES2U3cDVQNlJYVXovVUVZ?=
 =?utf-8?B?M1FrNEMrTC81ZXVGdi84T1pTQ2hITFN1ZnNTUTFRbUhJdWIxb25VSTJNZTdx?=
 =?utf-8?B?Y1BvemdWcEdPbDllQldPR21Pc096N0w3T3hlWnVoejVwZER2cmc1MWlUbnc0?=
 =?utf-8?B?M0ZJTEJFQ0xYWXpTeHNNVU1uQ25PYTVsZnBVTmhjNlNKZmhJb3FscnpKRFp2?=
 =?utf-8?B?U2FGWldpVFJPenRLeU02Z2d3QVlDek9tSEI0aGtLOXhqRFBNL0VYbVZNZjJL?=
 =?utf-8?B?R0ZIVlo2ZVpxelpxd3lJSUp0L09HUkxvN1hpN0x2d2FsR0FsY2lzLzdkeU14?=
 =?utf-8?B?NW9HQ3FFQ3pYcUh5SDdMYzZhL05NbDBjdzNpZXRDcThremNReW4xK0Y3ZUJw?=
 =?utf-8?B?b2ROOGxmc21ZNm52ZEV0blVVWUtuelpvOWNDeWhUNHBUMXBqWFBlVE9BOFU5?=
 =?utf-8?B?NkwrTXF5V1FQZ0NLNUJKdXhoY2k3TG9MUS9DU1RNQnZjSzVGb2wyQmd2eGtB?=
 =?utf-8?B?UXVxN2VoQXBXK3BjbFpoaEtzMCtXeDlndUh1VjZxSnFsMmdvc1RBNEJSU2xU?=
 =?utf-8?B?TlFZRmFzWjA3d09sbjZhQlorakJ6TmpUQzhEc0p0MW1WMzR4ZFVQbXNWenNY?=
 =?utf-8?B?RUdON2JMRkZBelpwVUZCQ2N2ZUR1UUE2dWhaazZRSEowVStSL0VZY1F6c2xo?=
 =?utf-8?B?bmszbU9ac3dtRWRWSm43VU5xS2hjUlJIam9vTFEwblN2dm41bXRkV3hIZW5t?=
 =?utf-8?B?TzVMUER5ZE9CSXU4NkhSN3MrRElUVlZJNk9LRWZDT1lpOVRHVmZ5bm5Eb2pS?=
 =?utf-8?B?MUZsT29iSG9sdW9SNktnVEN1UlZTay9LNE02QVEyZG9uODNlWVZiL0Fua05I?=
 =?utf-8?B?dnRaSkYrMldRZnBYc2lQd2ZFWW9McUQrZDFzcnF0bnJMOWpweFhWcVkwS1Fp?=
 =?utf-8?B?M0VXdTZjS2ZKRi9oVkttQ3FtZzJPTEZuSDVUeEFwRm9qc1pnVnpGYWE5WG5n?=
 =?utf-8?B?VUZydVE3RytSU1JPWFMxOU1uM0Z0TU9NMndLWFVKVC90ano0Ni8reHlMVGpS?=
 =?utf-8?B?SXo5c1I3emdobE96cTNvQjhJUGV1ak9YZnh0R1ZHejR3NE5tYTN3MjBQd0ZY?=
 =?utf-8?B?dGk2dDhoRS9QM05kdmFOV2VKSmVYb2J3NWE1eTg0NDRtQzBPcmovd0FibjAy?=
 =?utf-8?B?TnE1dXNpWkdpNXRwQ0x4UHYvRDlDRXFwZlZrMWRYSmgrRWFMTWdlM3d2ZSs2?=
 =?utf-8?B?a0JVNWxvaFozUC9JdFlkd051dk1zWEh0bmZPZU1qeC8vTGZ5UVJuRTRaNXR5?=
 =?utf-8?B?NUFTWjNpY3BjYWQzS3l6M2NTa044WWpLeXhKZEsvdGpZVXdjZS9pN2ZvYnlz?=
 =?utf-8?B?bFd4Ny8yQTRkTC8yNFkwdFBudjlYQzRzYkc2Q0M0UUJSanVPcVhXdFRKbk5F?=
 =?utf-8?B?OGpQamU5TFQwSGwzQmhRUExDUXFUSEtvSEFueUx3Y3YwZTZaUE5kVTZEWmYr?=
 =?utf-8?B?T2o2d1B0TXYzRXhpNnR3akZYK2FtRE81V0JkblJ0d1dQVkNMMHhpQk01ZDVS?=
 =?utf-8?B?TU5qNE9UZzhBMlhhVnpmc01ZZmVaQzVGK05oZ2Q0R3BPUVpMekdsU0VzNmVa?=
 =?utf-8?B?alBQcVpWYTd4QStKc0YwQStHSEZ2VW5RVk52Q0Z2VkF3VVNvSnAxRjVJUXNi?=
 =?utf-8?B?VnpCb3l6NTZlQkFjNzFKSFowUlZMQXd4WTNiL3o3VzRJTFQrOEZTT0FUeTdR?=
 =?utf-8?B?OWgrREZ6REJ3UDZoTUZpMkR1bW45UkNYV000NGptVGY5dDZDK1NESXlCRWxK?=
 =?utf-8?B?dnM3alZJdkloTlF4TVh5Uy94bGdyRlI5OTUzVldkMG1Mc1N2KzhBa3FXL0tN?=
 =?utf-8?B?ak1hZ3RjYWowUjh2ZzBSYml1UmlUUThTQUFyUDJuSXkzNjViV1lPZVJXdE5X?=
 =?utf-8?B?ekxyVWVtaWxaM0Q0RXJkRTJ3MHRTT1RQbWJ1V0tZb2F1ZVJuWjQ2YUNNNWo3?=
 =?utf-8?Q?bCHY+gOoHTlE4qF0CS0UWvepv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cbf99e-b0c1-460f-6781-08dca64b95bd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 10:31:14.8127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07X93XIWtUUOGCi8i0sGpxb3lGONVc9sRAF2DMx4lZhXbSQhYdUuTbxk0u5wlzfPvc75cfWMyY1EfW3S5yraVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193

On 17-Jul-24 3:12 PM, Vlastimil Babka wrote:
> On 7/3/24 5:11 PM, Bharata B Rao wrote:
>> Many soft and hard lockups are seen with upstream kernel when running a
>> bunch of tests that include FIO and LTP filesystem test on 10 NVME
>> disks. The lockups can appear anywhere between 2 to 48 hours. Originally
>> this was reported on a large customer VM instance with passthrough NVME
>> disks on older kernels(v5.4 based). However, similar problems were
>> reproduced when running the tests on bare metal with latest upstream
>> kernel (v6.10-rc3). Other lockups with different signatures are seen but
>> in this report, only those related to MM area are being discussed.
>> Also note that the subsequent description is related to the lockups in
>> bare metal upstream (and not VM).
>>
>> The general observation is that the problem usually surfaces when the
>> system free memory goes very low and page cache/buffer consumption hits
>> the ceiling. Most of the times the two contended locks are lruvec and
>> inode->i_lock spinlocks.
>>
>> - Could this be a scalability issue in LRU list handling and/or page
>> cache invalidation typical to a large system configuration?
> 
> Seems to me it could be (except that ZONE_DMA corner case) a general
> scalability issue in that you tweak some part of the kernel and the
> contention moves elsewhere. At least in MM we have per-node locks so this
> means 256 CPUs per lock? It used to be that there were not that many
> (cores/threads) per a physical CPU and its NUMA node, so many cpus would
> mean also more NUMA nodes where the locks contention would distribute among
> them. I think you could try fakenuma to create these nodes artificially and
> see if it helps for the MM part. But if the contention moves to e.g. an
> inode lock, I'm not sure what to do about that then.

See below...

> 
<SNIP>
>>
>> 3) AMD has a BIOS setting called NPS (Nodes per socket), using which a
>> socket can be further partitioned into smaller NUMA nodes. With NPS=4,
>> there will be four NUMA nodes in one socket, and hence 8 NUMA nodes in
>> the system. This was done to check if having more number of kswapd
>> threads working on lesser number of folios per node would make a
>> difference. However here too, multiple  soft lockups were seen (in
>> clear_shadow_entry() as seen in MGLRU case). No hard lockups were observed.

These are some softlockups seen with NPS4 mode.

watchdog: BUG: soft lockup - CPU#315 stuck for 11s! [kworker/315:1H:5153]
CPU: 315 PID: 5153 Comm: kworker/315:1H Kdump: loaded Not tainted 
6.10.0-rc3-enbprftw #12
Workqueue: kblockd blk_mq_run_work_fn
RIP: 0010:handle_softirqs+0x70/0x2f0
Call Trace:
   <IRQ>
   __irq_exit_rcu+0x68/0x90
   irq_exit_rcu+0x12/0x20
   sysvec_apic_timer_interrupt+0x85/0xb0
   </IRQ>
   <TASK>
   asm_sysvec_apic_timer_interrupt+0x1f/0x30
RIP: 0010:iommu_dma_map_page+0xca/0x2c0
   dma_map_page_attrs+0x20d/0x2a0
   nvme_prep_rq.part.0+0x63d/0x940 [nvme]
   nvme_queue_rq+0x82/0x210 [nvme]
   blk_mq_dispatch_rq_list+0x289/0x6d0
   __blk_mq_sched_dispatch_requests+0x142/0x5f0
   blk_mq_sched_dispatch_requests+0x36/0x70
   blk_mq_run_work_fn+0x73/0x90
   process_one_work+0x185/0x3d0
   worker_thread+0x2ce/0x3e0
   kthread+0xe5/0x120
   ret_from_fork+0x3d/0x60
   ret_from_fork_asm+0x1a/0x30


watchdog: BUG: soft lockup - CPU#0 stuck for 11s! [fio:19820]
CPU: 0 PID: 19820 Comm: fio Kdump: loaded Tainted: G             L 
6.10.0-rc3-enbprftw #12
RIP: 0010:native_queued_spin_lock_slowpath+0x2b8/0x300
Call Trace:
   <IRQ>
   </IRQ>
   <TASK>
   _raw_spin_lock+0x2d/0x40
   clear_shadow_entry+0x3d/0x100
   mapping_try_invalidate+0x11b/0x1e0
   invalidate_mapping_pages+0x14/0x20
   invalidate_bdev+0x40/0x50
   blkdev_common_ioctl+0x5f7/0xa90
   blkdev_ioctl+0x10d/0x270
   __x64_sys_ioctl+0x99/0xd0
   x64_sys_call+0x1219/0x20d0
   do_syscall_64+0x51/0x120
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fc92fc3ec6b
   </TASK>

The above one (clear_shadow_entry) has since been fixed by Yu Zhao and 
fix is in mm tree.

We had seen a couple of scenarios with zone lock contention from page 
free and slab free code paths, as reported here: 
https://lore.kernel.org/linux-mm/b68e43d4-91f2-4481-80a9-d166c0a43584@amd.com/

Would you have any insights on these?

Regards,
Bharata.



