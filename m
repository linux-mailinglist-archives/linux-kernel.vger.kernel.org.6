Return-Path: <linux-kernel+bounces-409845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3B29C926E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AEC1284182
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170DE14389F;
	Thu, 14 Nov 2024 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="46yj73YE"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B995842AA3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731612624; cv=fail; b=q1XyEPlhNLt095je3upeT3APLQc70vclhRSAVQebXH9aiu4WpYslPmcsEE2gfPpcA7Js/sqiiI2l6VocZWcLlSvxJFpM2hsn6tm2iWaTdHcE2Hxs4YlMPNQVDxRvYHDi8y94UberWTQCVitrKecgmWruRuKPQS0NtvfWvWpYv4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731612624; c=relaxed/simple;
	bh=WsD0iUjLkCmz7EV5g3Uexey1yqm2VAhCzvUBTEYkGNc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qd7Ii0fC5zKY9HhDGQk/613FRrcapBP58vI916ba6jNzqHO6Y378UvHrw95skJN2O6qXvcYcAQW5pZSUU4gchSHwdjKoRBdSYcdGdISRAryveFunSbYWhkSUWe99bvasWfoDxpCOzHdeCzQBF17RgU7aSenpYKQnhVrSVUGRHko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=46yj73YE; arc=fail smtp.client-ip=40.107.212.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdeIEVGVzcKYWi6T8J7wf2ynH5xfzDb7dpaKHfHbKvG8tXyTGM3eUJMtzULE3Twygj35VIBe6xErZFJ2D8DQsFBG+wUwFurGYVtOsjOFxuXvq6FwhDi0QVKXfwFdJ46FTie3XxLML14bRaQARYFbo1cpzmFuf3Gv9uqAs4smDeYFhV2p9W+ctCNs+/ErGZxlprd3l4o/8BmFJFxkPAjXKGGc18xRAqF3IsuQHl2+FAYPk3iCtO5jKYe8bITgAZyyOT7lZ9PpX9NoJbXQvimgCOBIC82PHI58YV88lM6Hoa+GLxd6xKsCJfKY+n2igvB2BChuhjMzAtW0JiC7bkwWTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNDLRbMV6wFcqhyKGvZ0os9lmoggG8FJXGyUZAFmciM=;
 b=BV6cJu/n4tN4Ond6gnsmybXAYxpFO3/feMrVa7adYqy5ygCO3WrSzanZeEPlUDrbv5kD8xpLuB463DRatW6slNHDvZcKL015OF+DSqvrXzE7/Tj1n+qTMwV8ZLZx5q3vBbeWk79oENQmGMAulfUJCEXCJWRcmHp3XyLGZRWMAQOW/uP46fGfn4C5mhfwV6+5Si1677uCocZCbwKYxMMC25xUoPsTANaoO2gfwJA3Lvjioek2F1boPWA06ENOWvObFcB8vvKpJndiE9b8kMw07rspXng0HXmOSlaVoDTaJkk7goVdleHRqGTSQ62l2Ba+q5QXd7FGGQxpiToqPQoQGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNDLRbMV6wFcqhyKGvZ0os9lmoggG8FJXGyUZAFmciM=;
 b=46yj73YEnF8RYZATe09KOVLIQnu/sLbZLY6Y7yO6Z4QUr688hgrLNKgaZvo04cdMLZ2x31NPNFEFY494KWp/Via0ICmREuw7VBUm55QiZOiUv+IvDFF7wMjvkXzti1ZbiE9d0FlCQItITEQ0nQAX7RI0bcIl41H6Azbhv2s94wk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SN7PR12MB6983.namprd12.prod.outlook.com (2603:10b6:806:261::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 19:30:19 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 19:30:19 +0000
Message-ID: <6cffe226-928f-360f-20ae-bcf27a8d2c73@amd.com>
Date: Thu, 14 Nov 2024 13:30:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 3/8] firmware_loader: Move module refcounts to allow
 unloading
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 Russ Weight <russ.weight@linux.dev>
Cc: Dionna Glaze <dionnaglaze@google.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 Danilo Krummrich <dakr@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Tianfei zhang <tianfei.zhang@intel.com>, linux-coco@lists.linux.dev,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Ashish Kalra <ashish.kalra@amd.com>, John Allen <john.allen@amd.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Michael Roth
 <michael.roth@amd.com>, Alexey Kardashevskiy <aik@amd.com>,
 Russ Weight <russell.h.weight@intel.com>
References: <20241112232253.3379178-1-dionnaglaze@google.com>
 <20241112232253.3379178-4-dionnaglaze@google.com>
 <6734119c1c9a7_10bb729471@dwillia2-xfh.jf.intel.com.notmuch>
 <20241114163546.ermxem4bgjzeaxzc@4VRSMR2-DT.corp.robot.car>
 <67363ecf8a693_214c294dd@dwillia2-xfh.jf.intel.com.notmuch>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <67363ecf8a693_214c294dd@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::28) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SN7PR12MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d57cb65-4ca4-484e-ff6d-08dd04e2c60d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2l1NlpWa3I5eEZjRm9yRmdXNjAvY1c5aVVyYWNZVmtYUSsyWVgzZk5oMDg1?=
 =?utf-8?B?TG0xY3NXV0lUTkR3N2UydXhsZnlybWZoN00yRkJoM0xOaGhwYVFERno5SE1J?=
 =?utf-8?B?bTAzVERqcHp3ODlodzVFVzJzekxzTis3TG50K043QXR3aUxrS3ZTdjUxOWpY?=
 =?utf-8?B?cFdkUHAxWm1KZDQvUnJkdW8zaGdDazA2ZnpOcDdCZEZlVjJ3elBSaElLcVRh?=
 =?utf-8?B?dDRDdzBEWlB0VkJXUUJtQVJOUnZxdFJSanF3QXdnVkI3RkFnUHRkVUZYWEUz?=
 =?utf-8?B?YkZwbFFNTGV2cW9YTGpMaHZmblZUb3ExS096T1JPc1M0bVY4QUFZTkxVMWdK?=
 =?utf-8?B?OWtrNVBsZlNKNmwxaWRrWjNCUHVQeWFLTmFaaGJrdnUzRVdFZDRXWWNHNXNp?=
 =?utf-8?B?NGx6Z1hlVko1MlQwanJ4Q1BGWE9sMVZ1VnZSTlBDbzZMSm1ra1VlU0kyL0p5?=
 =?utf-8?B?cGJ2dm1qcDFvMnA0RjQ2NWdRMW9hUVpBY2VISW9scUZPeWFGYkhKNjl1RWJF?=
 =?utf-8?B?clNUNDFOMXNBOTRlVGRjem9wejlFcDZ6UERiODc4bW9KaENUZGJMdkpQUW5J?=
 =?utf-8?B?YnE2SFJCZlFDb0V4NDJvdHd5N0RDdDY2NnlDTnRFdnptZVNLS0pGTVl2NE5z?=
 =?utf-8?B?VytJaWhnM3JrMUhLeDZiVGdZTS9ySXVPcXR1eVp5RU83Qlh2UFc2R09FVEtX?=
 =?utf-8?B?OTVhQmttaUgvck5yZTh4M085SndRMVVTV0Q2SVZLQ1Z0SzliZmZ3RDZGdDFU?=
 =?utf-8?B?ZzNPUHpOU1NLZVFDQXAyM3NnbzNJZ2dSejVkVER3aUV0VFVoV1NPOVd0SElm?=
 =?utf-8?B?Y1U0eUxSOHdCWHlHZGJGRUEyL2k3QTJuYmRTM3E5eTZhaVB6dEJUSzNjelpa?=
 =?utf-8?B?R2VjZnJNcU96ZGRaeGpnWUZqUEY5dFBBL2l2aFU5MmhDbVpVaW9zTmE2eUdF?=
 =?utf-8?B?T1loT0hoalFNV0hxR3dyUDJ3Zk1GaTVvNzQvaDMyUVBhRHNNQW9wYzF0SW9V?=
 =?utf-8?B?U1NmelpkSmRxWTZSd2FKdWJ3V2pLVjdiZFgvcFpjNzY1UnFVMXNpVEQraHNF?=
 =?utf-8?B?QzdjejlRQ3Y1T3BRTjIvS21jVCtybHhOV080ZXlsY2RDelVpcGZaVnV4UERD?=
 =?utf-8?B?eFlXbDR0Zm1GRm5ZRmJTK3RtR09Lb3U0T0pxMnFXeGJSdDcvYWd1NUZsV2M0?=
 =?utf-8?B?aUZVdnRjTUR1KyttQlRUZDZsZ1dzb2JTc0RzcmdqUmM3Y3JERlp0TUxtRklv?=
 =?utf-8?B?bWNlc1FHVmluQVhKZFdLZ2xVWmttbXpPNGZ1M0VyV1FKZ1dnK3dKRXp6cGNV?=
 =?utf-8?B?bjgraXZkM2YrK0dVa3FGMDRlQUsvZVlvdDRjQ3A0MUFCRmNwM0h3Qi8rVDRo?=
 =?utf-8?B?Q05sNXlXbkk0eFByRi90OVVKdTdxL2ZmRVBHRlRPV3Z1d3cwWS9KOVgxRU9C?=
 =?utf-8?B?WjBrU1ZLbG1sQXh3N2oyZGVXd2dNMzl5bEl4cXZRdjlhaTlWdC8vN0lseTgw?=
 =?utf-8?B?T2hpVitGV2Z6OGgrT2pRakc2Ryt2REVYckR0L2p0b2RZMWY0eDFMd01YRnRR?=
 =?utf-8?B?V1BiZmpDMi84S0lsbi96UlpveEl1SitEcC9VVDgrZWdCWi9lNVJtam9KdFVK?=
 =?utf-8?B?NnM3d1gxcEhhRWluSmFjLzlTWm8zZWtUUmlieWtLOGxGUFZLVXlBTmZWbjI2?=
 =?utf-8?B?c1RVSStobW1YZGhHUmxqeHQ0d0prWVZzK3NySWtaRlovSDhEVERubllkVEdX?=
 =?utf-8?Q?OoZoRxW5EQgtoyqgTgiUIzCfdJKpqeVrqkYzqJL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnpxZmNuOXVHYm5JWUVzTGVIbUJpamdxQmg5OElJcjIrTmxZdEp4QkVmTUp4?=
 =?utf-8?B?cXZHbmZBOUNiSEZGYUJEZTNGRlZZNVBoV0NDc2o4VW9ZekhpQ1ozQlJLK20z?=
 =?utf-8?B?ZmJvY3FiOC9tenRSOEdMZVJWYW5YUHpqSW9yZzFyUUxXRENRS2FJWFlSc3NO?=
 =?utf-8?B?eDJObWhCU2pQRUJWQ2k5Y0twN0ZpMjVRa3NFam5GamVCSjlBVzU0ZDgrV3pT?=
 =?utf-8?B?d05hbW5HSy85cVBJSllRdGFCSnVEbU82NllUSDhGU2JSOENtWTNYanhvbERs?=
 =?utf-8?B?QUFqaHFqVldPYmlpRkdhWE9veUswMFd1eHBYOXB6S2hEanNxTDVHeU1CaVR5?=
 =?utf-8?B?S0JlcXc0OWc5Zk9YVWExY3JSaHBSMkZ2dVhrNW5ZK2NldFdlNmcyZ3RsTkZY?=
 =?utf-8?B?bERhbGRqUGxjaGw3Nm5hblB0MnJ1M3U1NkxCZjVIdUdxR0lmdlYxZVFBM1gx?=
 =?utf-8?B?Mi9yRHhGdE9CaG5JSHN3V0RyKzFtU0xtb2p3aStTbThQdWYxQ1NWRmh5bm4w?=
 =?utf-8?B?N0E1dzk2OFNld01QSVFTbHcwaFN2VmwzYkdZT0ZUdTRGS3R2RXFCcGZLa05U?=
 =?utf-8?B?TmsxSGpHaEdhRlFOUjQzbjh4ZFRhMlhLU1hBTTQxcEdEYjJ0eHArS1JKcDVu?=
 =?utf-8?B?dFVzcXl6ZjZRajJWOHMxQ2tuZEtjV0dZRUVFME1oSGtiY2FSRmxSeVFpS1pY?=
 =?utf-8?B?UU54OGo4elplWU01eEwvNzVrcXlHRlFjV3B4YjBqcGt0bTlGbzNRelliQVlN?=
 =?utf-8?B?b2ZhMU9XakVwOFRUc2dKYnFDQmIzcTdGWHNyNXFsdE9vcXdwbXcvQlpRSEdq?=
 =?utf-8?B?Nmo5Ym1ISEJaV1d0bHViUW51S2c5ZUozN1FwYmsvakJrYmZmRWJGcXhrUGFV?=
 =?utf-8?B?QW1CUmo3UTVXS3MrR0Z3L3VCeUlDN2VrVWpoOWd0TUJVQk01NE94bHEvWWNo?=
 =?utf-8?B?SCthUTN5ZitHbDREYlhoYk1kSzhBUjNHbjI1RnlKVUpTMmc2WVBtblVmWWV0?=
 =?utf-8?B?VndJY3k3b3FONyt0QW1FL2VrZ1kwR1BXRzl4VGV1R0MzNHh6Q2xnYmVYb3Fs?=
 =?utf-8?B?UnF1WUtpeG9mVnVBMmEwUmRxcjhvVmhJSU9id05SSG5vcFMybkUzcFVqMDVW?=
 =?utf-8?B?MExXcWxEQW1VNkRVekFORHRrRys2Y3lQUzdPMDYyU2NWN1E2eFlUYzFKU254?=
 =?utf-8?B?aWE0Tk9lOVQxenpIZEgrZDZ6VjRVMTl3S21ZK1duNkVUTnpNM2xIYVBkMVlj?=
 =?utf-8?B?OFJqdHJDcGk5MWQxTnl0amZxUUJzVEJhdkxHeVl5ai9va3FGRGdxbUg5M3l4?=
 =?utf-8?B?SGhXZkEzejZtbHJtaWRIbzRNZTFCUWttTHM4S1UvRUJxWHRUVEx3cS81cWpU?=
 =?utf-8?B?NHUxV2ROSWtSZjVJYmxIeGJjZWErZUViaWRnZ0Fxa2dLUklvL281TG1MY3Vn?=
 =?utf-8?B?VTJjaVNoY2JwbnUzRzN1MThxNUVyZ3F6cW90azV6QmRJOVQ5a0JPTkFQcWkv?=
 =?utf-8?B?OVEzY0sySGx4TkJaejF1R1dDYTFuUFNHRXFiSXVHamNJWEFmOTZtaTUrUUZR?=
 =?utf-8?B?MVRzSjZvdGdMbUJqMWQvWngzNW92ZlFSYStJNy9uMEJqaWpPeE5OazQ0NTQz?=
 =?utf-8?B?eGRHWlJMcEVrYzhWMGp2eUhNVFVuVWFWVUxHOU5UYkZSTWxtS0E4NXVndmR4?=
 =?utf-8?B?UjRzT1EraDZzVytkRllxc3BWQkhjTm1mZ25BZS9mKzIvRjRUVWVwbjFaVlVS?=
 =?utf-8?B?QnI3VE1xQkRTUTdUNHZTcVpVcUdOTDcxVG1hUDZ0QnIyaVJpNDhZRGthMmVr?=
 =?utf-8?B?Yzd6aVc5SkxRUWxweFpacTdyMFh5dE01NFV4U29JUFl1c3RxQWJDL1g3WHNP?=
 =?utf-8?B?dUNGb093OFgwWW5vNVhqV3R2OGFXUUw1SFVmdjJFUldjZHFRc1kzQ0VINVFp?=
 =?utf-8?B?alh2d24wVWNkNGlzRHNwQ3VhNG50MURzRUZxU09hUFFrd0x3VTJZY2JiVlFx?=
 =?utf-8?B?NEw1YXVYVU1wL0hwOWltNmw1Z3RtKzNhKy9RN0gzakxZbHlpam10TEdKQk91?=
 =?utf-8?B?OGxrUjNyODlZRVVsMG5LRThMblFBdTRTUTVTc2Zqa3VRL3lQV2ozVlpJaTBz?=
 =?utf-8?Q?ceMdQ/i6lkqW/CH8+4289dFqJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d57cb65-4ca4-484e-ff6d-08dd04e2c60d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 19:30:18.9901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pI6yIpgM7GBL+UKQS88COZ6n7pA8WnOu/0fMDb/NZIZhoHOk9Rq/ypTh3MUxiuwKW/bAmQwu1M7mNgmuoYlsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6983

On 11/14/24 12:17, Dan Williams wrote:
> Russ Weight wrote:
> [..]
>> Clearly this would be an unexpected/unusual case. Someone with root
>> access would have to remove the device driver. I'm not sure how much
>> effort should be expended in preventing it - but this is the reasoning
>> behind the incrementing/decrementing of the module reference counts.
> 
> The module reference needs to be held only if the producer of those
> symbols can be removed without triggering some coordinated removal with
> action consumer. A driver that fails to call
> firmware_upload_unregister() in its module removal path is simply a driver
> with a memory-leak and use-after-free bug, not something the firmware
> upload core needs to worry about.
> 
> So, the prevention mechanism is "thou shalt use
> firmware_upload_unregister() correctly", and when that is in place
> explicit module references are not only redundant, but trying to
> implement them causes circular dependency loops.

I believe that is how other similar services, like debugfs, work, the
module is responsible for cleaning up.

Thanks,
Tom

