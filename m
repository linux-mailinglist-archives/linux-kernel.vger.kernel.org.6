Return-Path: <linux-kernel+bounces-370497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF1E9A2DA6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707A1B22D32
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B85B21D2AF;
	Thu, 17 Oct 2024 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SjgUOzYn"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D4316C854;
	Thu, 17 Oct 2024 19:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192788; cv=fail; b=r2RXmvMCeOv8o4Kf/BWlennvUVgxVTMC9vi5i5uD2Bd8xh+u20VvuqiRwgOpf1piMjdgaBp0J4OIAoKEXOhiv2ey1ChG5YYDoJlxy1daWT6rdmIWf6+24t2m9d6HGQzxaInB7dJMXZfSWKv2o3Owjrn1LJlcYnJhzrc1ru4RB8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192788; c=relaxed/simple;
	bh=bO/1tCsXyDzuwib4QvKoM3RemfsT9XRg8nC+nFYPzQ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i65JgL1xx8mg0gVpCbr2X3glFxurP3XyeJWmuyFnz/fuAseJvrAxHrOy851cLWTg/7SQS15AoPupvIWqWTLkRR1xR6LYWJMfli6MGNFThVjg2F/ThdJPRrvZfPQLurXABIxjeiv+OLkeCIvQP94H4eEkNnJCnuie0PTbr1jtn/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SjgUOzYn; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtOsOicBrPisG7CzzT84EzBSM70+xaaCh1ywurnYBlbCV30BwMk/De9giItvE4UPlwDceJa9EzicjAbiv6DAZNB3sFSBd71f94psnIsWA+JFlKGOw1hXF6Ty/M10QCtE8IGGqpOzIPJKMehoOk44OyBB0onHxa4ZnXqD1APqH9wolz7iFlFwt352vVWxk6n01X8zhDtw06or8AQZ4on9OV5tcer6SrWSRE2mLB9Q4HrSKH0rcoQL8pbYs15HjHzl5kE//eu0dXctqmdUpgi4ugUhyVeVu/lhjN7VQeZL6S7LwcLFnbXyv/Acgbd6wZWtqpXADBr6BgexxEccqRPxGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=di+PeHSFTR8IHoOe8ULeg9TtTua58+u0zGNmMUl6W5E=;
 b=bPk4Ol7lhKbeBuGovYGyScERvMxz8FyQXtOYr3r+ml+fQwoQO9nA0nGBxVS7ezDPMlZMV/qkWp+BcXj3P8X7iuLbE9sXbxUESMLXVMO7sxPJxaZykI5W8rCeKo58rDexqKwqwEwiJFrK8EpdTbaeSHseam1TZiXuzyVNf4lJqyeFElnlh08RAnre3i5erftxKiO33SGqCdyngabv3eRDQdogoPG6aQkegOz22wiL17rgYnLpY6emieLtL60BHhY5fXqsVKFdDwvC/OjmC+ywZFGRNXmxuePYb0BdqyPwW30N/Zerb5dQFM4fw8824cqhN6abvZHl4gDViOTeHQerrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=di+PeHSFTR8IHoOe8ULeg9TtTua58+u0zGNmMUl6W5E=;
 b=SjgUOzYnJWUcsATJk7uILnVLXVW1Q6CBUnF/rPELyhqigT4vejc8TKZ2r8DmJUfeT0P4E+RkCQYPPTz8Mi3wVEH3KujK1bT0aEqCjoiHtFBwzfMvOyQOv8lMBWX5wW1X8HKnTyFzc/v3EoCeON58IQQyiXFBBjb/ty0za89VgFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ1PR12MB6028.namprd12.prod.outlook.com (2603:10b6:a03:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 19:19:39 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 19:19:39 +0000
Message-ID: <6c5c4907-0892-4f37-8d9c-7ebef3ddb314@amd.com>
Date: Thu, 17 Oct 2024 14:19:35 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 15/25] x86/resctrl: Introduce cntr_id in mongroup for
 assignments
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1728495588.git.babu.moger@amd.com>
 <0af9b74cc32cbdd26fb0d9adda40c359e8bf1bb9.1728495588.git.babu.moger@amd.com>
 <dc8d11f2-38ae-4745-ba19-82cf8a6c4dde@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <dc8d11f2-38ae-4745-ba19-82cf8a6c4dde@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0124.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::12) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ1PR12MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: 18668279-e34a-45f4-3bc0-08dceee0a525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qk1SMUYzM1VZckpSQ2NpQzlLOVJreWZVVDFOS05EZTV3MXBKNVo5SnZ4Nnp4?=
 =?utf-8?B?WkZVWk5LMUdENnR2ZFptYS8wT01ibVJaRHdwZmlSeXlhKzRrRTNIZU1uQmVs?=
 =?utf-8?B?NVFHQTAwR2o4dHRHTXA4ZlVwL2JrczBuS09vY0o5Rlh0YzlrVXNBRk1DbkNp?=
 =?utf-8?B?QUQzT3BlZ21ocUhBTGlyazlJdUducGRtWmVGVWlOSzhHNVVXbGNlWEIwVnNr?=
 =?utf-8?B?UCtuVVdZdkJIZHNEc1BuSDllSkNLcy9IYkNXUmREV1hSY3hUcGFSMWM5Z1lu?=
 =?utf-8?B?a21kL0Y4cEVENE9HbEh6VEJaVDNwTStHdVRndUphQmdlSnd5Z0tIbiswbTNV?=
 =?utf-8?B?a0FvL2hxY3lxblU0MnphVW5CK3RCeXdZRmhOcUV6YjJhTUx6V1o1SEx2UkRL?=
 =?utf-8?B?TlZhVFpNdnVhN2sxdEY4MXZwWDJnbFFYOVNxdERXWXJjMHpZRHhoamV6bnRS?=
 =?utf-8?B?a0hsdzNjNzYrZ05kZ2c0WittTjBzRElDUnlHYW9CdFFubHVOUG83RW54ejdw?=
 =?utf-8?B?eEk1UlF5OEFJN0p5RUNaM2FpTVY5Y2tzdkJZNUc4NktIVlZianNaZktEdFhG?=
 =?utf-8?B?TnB6WVF0c2piUlJlcFZldGZWMmR3d1Z2cXluRHBhV2FlWlM2MUdKc3Q3Um0v?=
 =?utf-8?B?b003dG1TUnF6Y3NmOSt1dFVMQlRhTjRBR0dtanoxMitjbklKUGJzM3RVL3pt?=
 =?utf-8?B?aUVlamhhWjZoL290N0NMZmRGTkF1bHdsUURBY3RSRGRwWWw0blpVYVdGcWUw?=
 =?utf-8?B?QjBrTTlncjNhQ0h5c0hNT3FqeHVJMTEvSzBEVVpKNFdwMHU1Z3RQbDA1ckll?=
 =?utf-8?B?aCtmUk04MkpJdkhqeGozZlJjY2o4SXJpY01UNm1PRVU4QlAwbGZCYmVQWXZE?=
 =?utf-8?B?OXZaUURNRkQ0ZUYzTWFoVUFPRlpCZG9WcmtjR0xlSDUzOHdXV2JMUC9KMmx4?=
 =?utf-8?B?UVpEMGhjNk12NlNSNWxYQXZhVThvN2d0aS9tR2dFbkxCUlY0T0trVnEwMXB0?=
 =?utf-8?B?bVk2dWFRbWZtTndyQUhZU1EwNWhYMWZ3OGxSdS9GNWJmckJCTmRPa0h0MjhU?=
 =?utf-8?B?RkZBSGdTL1VMQWphSkNFYnhvMjVPU25KUzkzN0x5Rm9Yc1d6SkRnY1NVYXJu?=
 =?utf-8?B?Nml0T0Q3Y09yYTZML3h6U0JkWCthMFFmd0FTY254K1hzeVRZMVNJTTZEelBl?=
 =?utf-8?B?eVJNMVBHTnhuNU8rTlMzbThhd3p0ZWRXSy93eHh6dTFMVXd2R2dPZEVpdVdY?=
 =?utf-8?B?TUtEOEozM0k2V080cEFLdVdWVUh5Yk1ZVG81RytBbGljTFd3emJEN0VwTXI1?=
 =?utf-8?B?SVdXVjJnSzBZVllwNTFuY3Fjd1ZYdzQ5U1JGVVJOWlp2NGRQSGJIbk1YTnJL?=
 =?utf-8?B?WTZXY2ZUaFpLQ21tWVkrZi9wcDdHQms4czVhcHBnZnBKRU1VN2hNNCtnMWtL?=
 =?utf-8?B?dVlNNGFNODB0MTFFN2VOSjdCMktpcVQ5RTVOM0dycjJvMG1lVDg2MDRWOWEw?=
 =?utf-8?B?ZjZtd0lOUGRIUVhSTGNCMDNWRG1kS1IvWlZOSFlmSHo5bWVnbW85cUhOcVB1?=
 =?utf-8?B?VUxUSUZFbUIxTWUwN29wRTk1cWVvTkZnd2lPcFN3a2pMRzBjaUw0ZUZRSHcv?=
 =?utf-8?B?Y0liMWkvZTNkMnZBUGZ6a2VtTlRKUktYWkJTZ3JXQnREakNGZHBYNStVakJr?=
 =?utf-8?B?VzFHQnZpOXVaRkRER21qTy9ram1PZkxzMnZsdkRWUkF6dmFSeEJmdGVHRFBO?=
 =?utf-8?Q?X9nwPaKhcUURd6l2LviEDVQGloWNUc2mAomSzi6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWVlaWQrOWlUandqLzdsNHRXOEN5bjFmQ2J5dVVkeHBDQ01XV2NiZStjSmt0?=
 =?utf-8?B?SEZHMzBtODBJVG5abCtjaVEvckJjNG1mTXZGeDA2eG9VT29sUUtvM0FIWDZQ?=
 =?utf-8?B?ZlprNmw3Z1pJeXMzYXlHVWhpbjdWSTArUjZZZHpOSXJqclo5VkowM1RpNi9j?=
 =?utf-8?B?MzlkaE5CdE9OY09VRVovWGVHSEhzNTBWa0ZwUHlkTmlkSUFkUzdOUmVrSC9z?=
 =?utf-8?B?RFFYWlNMUmNtRGJXTk03Wm1UaUhoVXcybisrT3pjU3hlVkgzdmZnbHlYTTNm?=
 =?utf-8?B?ZjBycldUL2d6bVF1S01kZytXaXFaa3FxeitUMTNiTW14S0IrVExlZk05cTVF?=
 =?utf-8?B?alJKdVIzOTVRQW56SkNpNXVzL29oR0h1SGpCN0NTKy9CUnRiNEVRQ0d4bmRH?=
 =?utf-8?B?cGc2TkdDd1BtbTdUNHFXd0xOMzMvWnFoSXlHTkJrRmZIT3pQVy9BZWg1WkNH?=
 =?utf-8?B?Q3AzbThEWDZPbFJUYUYwUHdQNDl3RjVZVHhNMjVjUVpySkdsOWVNRHFJUTBI?=
 =?utf-8?B?QTdRbDExWDNTQ0JMZVhBOEVndlBwc2NZYzI2R3YvWG5raSs2RVFBVERpSUts?=
 =?utf-8?B?Kyt6Ly8xc1h6K2pyVW5sdWEvUDJRYXhVeEhtOU9VV1ZKbXRtR3VFbnBMNTNa?=
 =?utf-8?B?QWdLem1EMzk1YndQL0FBeG1ncktVN3hybXNUcFArM1B1RXI4TTMvSjBFNVcz?=
 =?utf-8?B?emdOSXo4T0IyZEc3UVRaa0NDcm1FUlRQd1dMSXZiSW5WQ29tUmNzbXg3SUFW?=
 =?utf-8?B?MGdsYTBZZHRnYzl1cVpEaHpYVmdwekNjaVdqQnlhbE4yL3c5QXQ1VXd6ZVk4?=
 =?utf-8?B?R0VaMVBmSUVyY2VaeGRhM3BLWkRveEtrcXVJemtYOHpVVGZkZG04MDcvcWJR?=
 =?utf-8?B?aDhYVFNaWDJVZStSWm5VSVo0M1g0QkJlSFVHODJoYXJPanlOZitrTUZydmVJ?=
 =?utf-8?B?QkhZWkswL2ozUUdOaDRlRldBSWxsTkl5NzFya25YYWRob2hyeXpvcmhHeS8r?=
 =?utf-8?B?bDRiSzZxRk9hcHRFdXc5eCswdEhPNUs0LzlpMUxmSmRlM3F4ZFJOWUdBNG1Q?=
 =?utf-8?B?bFF0cEIvQXNGUVBKRmhHaDFRUVlCcWNxcXhPQ3dIZFBLNDNlcmdNUmh4cnBR?=
 =?utf-8?B?Y1daRWw3UU1uUktJckJYVzJ2MFNvVVBvSWZZVmNaN0tQQ1VwQjR4WHU2N1hn?=
 =?utf-8?B?M08yTTRYdkpWd01wTFlCUlJiR0NXV2lTdThNcWZhQWxvUG1GQVA5ZjlzdXo4?=
 =?utf-8?B?eVBoZU9kZDYvbDRvdUs2QzJhUmtrTXdNUmhvV2NwVFZtaHdpekhmRUdxWVY0?=
 =?utf-8?B?WmhMT1JIWG9pek94TTFmSFc5WlFIRkIxM0lLdFQxN3gralBvODFNVjNWNWND?=
 =?utf-8?B?YWxDT2dib21hYVhWYWhONWZzUTF6SGpZS3l4bG13Qkw3NTVQcmp5MC96dWZu?=
 =?utf-8?B?UnYvU3BvMmJDdjVZd2c1OXpqalhZQms0QktSSGZHQzJUcnV0c083WEhzTkJP?=
 =?utf-8?B?V0VIOFR0d1QyM3FGQ1pVYTZmcnJwQVM1VktkaldrME1SZTN1K3o5TFNLNFRF?=
 =?utf-8?B?MHZwTkFNU0JvcDBnZDYwekt5SWlZdDZIcHZleDdNRVZJNW8rZHJtZVRtN3Nk?=
 =?utf-8?B?aGpOTFlxYXlsNnZVbWhvV1lzZEVjTDZPTFhLWUNVVUFGOHdqL3lubjBaMjNq?=
 =?utf-8?B?UGZJV2dHc212Q1JLQUtaUDNKVm9PUkdoRnpyZEJyT2FQS3lZTGlyWWdDYVo0?=
 =?utf-8?B?eCtoejJEWFBkQytlRzB4UmR2RGR5SXZQeThIUFhZMWpFNW5ZQXFmcW9VOUlH?=
 =?utf-8?B?UEZjYjJGOUorNkh1TEFqZVpPUWtpVkI1dTM5WFlqM3g2c2hQUlJRL3NaQ0N2?=
 =?utf-8?B?MXFHVTVjanJDbzdTQldEeDB3NkFJak95UXpabTdzb1NXcjRjVUNEaDdZbGlB?=
 =?utf-8?B?SnBMbDh3SDhRRGZSaktzZmZpd0FCWHhGcW11NkJBN0wvOVdEbEpVWjJXOFF2?=
 =?utf-8?B?SXhIOVA4WTFCSXBZV3pEMzFZZXYxdzNGZ291c0twSmM5TWNkaGlWeFpHYTRn?=
 =?utf-8?B?RU9NUTZ4WHdiZ25WYUhEWVE0MHloQ1hCOVNkVys0Z3NZSUpRTVJIbk1UdEIv?=
 =?utf-8?Q?//gI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18668279-e34a-45f4-3bc0-08dceee0a525
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 19:19:39.2306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DDhCxPAqwwujhqyuv3NZ14bJNXbfDJ8uvUVhJfH51Hs3CJf8YD8WrgNYjTcYt0j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6028

Hi Reinette,

On 10/15/24 22:22, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/9/24 10:39 AM, Babu Moger wrote:
>> mbm_cntr_assign feature provides an option to the user to assign a counter
>> to an RMID, event pair and monitor the bandwidth as long as the counter is
>> assigned. There can be two counters per monitor group, one for MBM total
>> event and another for MBM local event.
>>
>> Introduce cntr_id to manage the assignments.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v8: Minor commit message update.
>>
>> v7: Minor comment update for cntr_id.
>>
>> v6: New patch.
>>     Separated FS and arch bits.
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h | 7 +++++++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 ++++++
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index de397468b945..58298db9034f 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -62,6 +62,11 @@
>>  /* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
>>  #define ABMC_ENABLE_BIT			0
>>  
>> +/* Maximum assignable counters per resctrl group */
>> +#define MAX_CNTRS			2
>> +
>> +#define MON_CNTR_UNSET			U32_MAX
>> +
>>  /**
>>   * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
>>   *			        aren't marked nohz_full
>> @@ -231,12 +236,14 @@ enum rdtgrp_mode {
>>   * @parent:			parent rdtgrp
>>   * @crdtgrp_list:		child rdtgroup node list
>>   * @rmid:			rmid for this rdtgroup
>> + * @cntr_id:			IDs of hardware counters assigned to monitor group
>>   */
>>  struct mongroup {
>>  	struct kernfs_node	*mon_data_kn;
>>  	struct rdtgroup		*parent;
>>  	struct list_head	crdtgrp_list;
>>  	u32			rmid;
>> +	u32			cntr_id[MAX_CNTRS];
>>  };
>>  
>>  /**
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 610eae64b13a..03b670b95c49 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -3530,6 +3530,9 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
>>  	}
>>  	rdtgrp->mon.rmid = ret;
>>  
>> +	rdtgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
>> +	rdtgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
>> +
>>  	ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
>>  	if (ret) {
>>  		rdt_last_cmd_puts("kernfs subdir error\n");
>> @@ -4084,6 +4087,9 @@ static void __init rdtgroup_setup_default(void)
>>  	rdtgroup_default.closid = RESCTRL_RESERVED_CLOSID;
>>  	rdtgroup_default.mon.rmid = RESCTRL_RESERVED_RMID;
>>  	rdtgroup_default.type = RDTCTRL_GROUP;
>> +	rdtgroup_default.mon.cntr_id[0] = MON_CNTR_UNSET;
>> +	rdtgroup_default.mon.cntr_id[1] = MON_CNTR_UNSET;
>> +
> 
> Could these magic constants be avoided by introducing MBM_EVENT_ARRAY_INDEX here
> and using it for the array index instead of "0" and "1"?

Sure. Will do.

> 
>>  	INIT_LIST_HEAD(&rdtgroup_default.mon.crdtgrp_list);
>>  
>>  	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
> 
> Reinette
> 
> 
> 

-- 
Thanks
Babu Moger

