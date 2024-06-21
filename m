Return-Path: <linux-kernel+bounces-225081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C01912B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3812B1C25D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3661684BC;
	Fri, 21 Jun 2024 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Us/otgIR"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A111607A4;
	Fri, 21 Jun 2024 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988078; cv=fail; b=GMQQD4Tl0j63HrXhY7xCszipoinVE0TCb1cERAUIDJgrIMKc/8Z+D+BqPg5m2bPjtvrKePMC6L+HT8kRWylDY7CycY5IPZidHMwHNNBESPKGxV5wTeSg4292cet7YEbMTecUBeGYeHr8RArjA1EjT7//isjDe9uGzkk1t2awnI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988078; c=relaxed/simple;
	bh=dgqnR6t7mqDv4yPzEQ5N1+qw0EgBiq56Q0qTLS0Jmvc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TbgQ4csVaT1QHCqIOV11YezZL6T33u7UPZzUQibM/15ppN9RGg0pcVWECTgEF2fu19yPYrVmVfW1G8kTpiS+/ajxjvmUysxQ2x8Fwt7RXFhRhzIlwwfjRR1TAQeSTxx0uxCg/JT14jEKlFIJd1Jw4BzowsEdhxMo6fZDUJJaxtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Us/otgIR; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ti/DZgpRAbxz5TbG19Aoj9n2KC54TR/+qgl32m2YRCbgXjPzOjTFEeBlzFtfTogzxCZuS/i82ixi1JMhfepkpC/nx2YaVpGYVLey5I6YPfTlGuXzSLen3hkJHIo3SgAr648Pqi1MWwOGJXrmirH5kIjrkzuQi4P8v6UPHfl7QrPQLLdJ8MW9n0HsQNhqDLKSmWZ+56r7MwpDwgYpDKC/YgiZuk9Gl3yjYCvSxgpMdiimGxOzcKd59+/n0XcEWkaEGtnAJOShDsAC+j8th4M052UUFfSKcz8o7Mq6zCXRF6XFYH+7588VMc9oNUO5DGzW80YU8Y7M7MWHyMfs5tVtiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbjsMQtA/+EsK7CKpchU42LXn6UpKJv+bH4AJI0tHbQ=;
 b=bvasOVRO7pPWgMLvajPUbi7zUGFca3N+EK6YvVJoG8MsZWzPQaK9IcyJBk4ZtJN/DYe7aMHzfDAoOwHn8QAwA8ks5eXQ76JatMbKGRR79/pYznOzLerBz1jOgkssi6BebMH28XHuOpVMbST6A8eNlnmBLj1WlczHjPWzkXf+ZN2ZBUFMFhqlvqpLjgZR6fu63SArZRQmVC/hLCYCTSIeYDdTMr/1XgeHOjVuhST1NcvAecQDg1iErSi4zjLvrWfS84GFy1Q9zKUaFYsfZ3ey78p/2N1U/f6EGSVdQiFxbwWRj1xS120ub3eNKS7eXkPXxrL0kg7l8undnTDi0bbQCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbjsMQtA/+EsK7CKpchU42LXn6UpKJv+bH4AJI0tHbQ=;
 b=Us/otgIRrUN37AbsxZ29aow8gtvQkCluJEUlv+bzpaWMGaW6oxwtBH+tgGQTH5VM8JUPHHdiBcYJPB9qZ+WtJh+BcPe7z9E5wSINUFZJ6H552Y78nmEZMkuiO5pA0s6SbjN5UmTiczIOEk6hk2kOY5GLJiv+1z7ODGnIbYLRw8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB8040.namprd12.prod.outlook.com (2603:10b6:510:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 16:41:12 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 16:41:12 +0000
Message-ID: <d98087ff-8038-3f57-fc3b-df745d55141a@amd.com>
Date: Fri, 21 Jun 2024 11:41:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 00/19] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1716552602.git.babu.moger@amd.com>
 <2e488812-671e-4aa9-a292-c54b174f2dd7@intel.com>
 <6e297b6e-e39b-e358-7bb5-59add62f8b2b@amd.com>
 <622f93e6-14df-4718-abb2-33eaa5d160fe@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <622f93e6-14df-4718-abb2-33eaa5d160fe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:806:f2::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 9def4d56-985e-4392-0ade-08dc9210f617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzdMMys4ckRmdWFFTm85ci94eFg4U3J4c3lVNm9nOG54MHVFRGl2V29sQzhk?=
 =?utf-8?B?U1NWYllpdW9HaXdCQkZ1cGl6VzF0SytUMEhabU16Mm5meUhTVktsUEJJYjFt?=
 =?utf-8?B?aVNHMm1tZVFaUlJ2NVJhZEx4UWVUbWZ5NllQd093RmVGZnVnMlNqYVVCVUtM?=
 =?utf-8?B?TkkyQkR3SFh3bkgwNEg3bjV0NVNoWEhSb0tjSytJZEJUdEp4WHVobTFjd3BQ?=
 =?utf-8?B?Y2xYQnU3VkZ0ZGJtenVQM3puYnc4R0x0VklXY01rdzRsb3pqenB1TkYzaU04?=
 =?utf-8?B?aGNHUUYzVkNMbyszdnRUVnA3dFJqUFgvZU9STS9oR2ZFMmtWbU1zaGJiem94?=
 =?utf-8?B?Qi9FTzlGRVROT0o0eW10KzNieDV6ejVzM2Ixd2c5K0EwZEhqMHBRWjNVaWRz?=
 =?utf-8?B?cUx3aHZJYXhlN1BQN1pDZUowN2tkMWVWZ3VjaTNkNW5ZWXBOMkRXbW92R1hS?=
 =?utf-8?B?Z0ZZQm4vdmJLR3pNbkVRNHU2cjBjRXIyWU0wMHp2dng0aFQxTkxNbllWdkJ0?=
 =?utf-8?B?TmhvQVVmMTk5NmN4ZWRKWFFFaXJCNWJhR2FpSFBwR3B1ZWhNL0lxcTZ3bGRI?=
 =?utf-8?B?aGJQK2RWbXRoQTk0cjkreStHK3J1VUtzcG4zTFkwMHpGazFKdVdETGZ5aEU5?=
 =?utf-8?B?cEI0RDgrdi96VTRHOWhpcDZpMUNnbmlHNUdpbERDaFlIZHBFUXE0ZDI1MnVE?=
 =?utf-8?B?eVVxeDEyT3MrTGtGa1hBKyt0QXZOOU91MytKa1JXSktYNlkwYVFFRis3dWdF?=
 =?utf-8?B?NzNtZ2dzejJZaWRid1BLaFVLTlJkMytCVW1sUmJ6eDBkT1phNng4dElocGZy?=
 =?utf-8?B?UWRiNURzYnUvYTh2Q05ScUhBV2RBRjFNY011Y2xMcS8wUm5QL01kTXB3OWFr?=
 =?utf-8?B?dzF2OEVmdjZ4WGVGeEg0SnQwN04yM2lSbWw3U1U3blB6K0ZrcUJuZ2hqVTZJ?=
 =?utf-8?B?YVRjcnBqN1V6YnkxZkk5NzIyYTNHckFJVW1TWEpQZ20wZEFDY2tZVkxURXlu?=
 =?utf-8?B?cUpWT0tvMUN2cXZZRWcvU0ZKN0ZGa2RxajNnTzUvUndFZlJYNjJOdmFWbENC?=
 =?utf-8?B?Wk5aV1dBb2lLa1F4VHZVT28xQTIzNG9LWWpvZVovWHZxQkdJdndIcE5IbFFk?=
 =?utf-8?B?MnRLcXZRdm01azUzTVVTaGVBQ0FXcThodGtNek1yaytJNzFWVzQ1ZXdxZVU0?=
 =?utf-8?B?MXdMeU1iTStiOG1jQ3c0Y2VWa1JyMFcxTzZBc3N0MHlKMW9jUy9LVmNJZCt6?=
 =?utf-8?B?bVdHZ3JNM0NiQmEvRWlpOFU3VDdtSEJmQ2JHWmRiSXpvc0Jzbm5uT0VjV21v?=
 =?utf-8?B?eDgza2Uyek1aR0ZJZ1JNTnh2WjlVM3h0RnAxVjNlV2VhWkNWK2FldHNEWGZE?=
 =?utf-8?B?d0ZFTktQaVBuUFgxSGFXWmpiUGE2VVV3V041ODlGNGtPVmRJaVFBTXlVdWpk?=
 =?utf-8?B?SHEyR01wak9LNW10WG9PVVVJWWxSVGhvdlhtWThvRW9IeDYvTEhmWG90Z20x?=
 =?utf-8?B?dHZJUFpEeW1VNDNnMjMvTGpZajl6Ryt1VlFFUVpwUjRQMWJ2WjlZYmtTampJ?=
 =?utf-8?B?eWRqU1B2a0gyV05iV281VSsyamp5RTRuVGN5dzRuNEhreCt5L25JQWVFaFdY?=
 =?utf-8?B?cXBnYmFwKzZSZjFLVC9Qa2tWZ05EUkp3QTBDckd2QmpxU2ZVeGNEWmdUc2dN?=
 =?utf-8?B?YXZvdlJDc1NqVzF3QkxIVGljcE1TZ2dZZEk1SmFvT2E1akY2eUpQZG1nTmgz?=
 =?utf-8?Q?gp4Y/I9qN6TNvI12yFbqtIkDCxVo4zwtqtzJALW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTdML0pkZTFPZjMxdDBLQlFjeGhxcC9ydXhuRlFObm8wRFRUdnpuRkpEWFdk?=
 =?utf-8?B?emtWZ1JFK3lQOU9Lb0pwRVRKeVptZ1NnUit5eDBpNXJqMFZHYkVIU3hEOTNE?=
 =?utf-8?B?Ly9YUnhHSitmMDF3Vmx5a3dQdE9ueDdlSFlkdXU1T01qVkcvYnprZUljMjZP?=
 =?utf-8?B?UnNIOEtXTjY0S3VIOUlXWEcxaXNidVZRL3dFYWlyUHVvVDdQa3FoRUZ4VVpT?=
 =?utf-8?B?TGpLR25PTGtiNHFpdjNrcHpvcFhSNVgxdDhQZ3FZWWhkU01TVHZzWlpjWklT?=
 =?utf-8?B?WTZnMzZBMFN2aEJucFJxR2JhVnZSSnhhQnArNXFrMEpiNmlqWWtsLzMzemd4?=
 =?utf-8?B?dnA0LzA0dkpLb21kNkZzam9vK3dTVGpaZUZrNGhsNndJbGlMeW9YT29TM0pv?=
 =?utf-8?B?NFdNZ1ArWmo5S0E5SGlDRkxQM1A1QndaR3VmaHNkZlc2MmxDYkQ5aWx5ZUJF?=
 =?utf-8?B?enhjOHJ3eDBmTXJkVHFVb3A2S1pkc3JDK1VXZzBLUFVldFV3Rmg4RWFLREk2?=
 =?utf-8?B?d2l5djFKeDU1U2Q3ZURDZExCcXJkNDBGeDgyWkNLdUFRZmtxN2tQd3BnRGZh?=
 =?utf-8?B?U2ttT2dnK3ZiU01EL29WRjU3ejUvd1djTkxaRHVYMXR3VWREVmI4S3dmS09s?=
 =?utf-8?B?aG5sYWdsd05PQ1FpSi9yVXEzVDJOcnFCM0xveEI3OStFYWtjUzJ3aWxnRFVK?=
 =?utf-8?B?c1cyWW1oY0d6UWFDalBianRrdVdpTTFWVTNveEs1T2lVMWlJaTRWVVVnd2lL?=
 =?utf-8?B?L0JWQ0RBM1BrdVcyOHd3dDcrbWFnemxvZ1BYTEluNlY4WFVjOVlYSU9FUjNJ?=
 =?utf-8?B?Tlp2clc0NG5nU2RuNlZnbUtWbXNMcWc5dVp0SFBrbjJEbTNTTmIrbTM1OVN1?=
 =?utf-8?B?SlpPZWl0cGlmeElHTjdDVVNJcnNyMlNhQVdoY0ZibHBjVG5Rc1lHNy8yN05u?=
 =?utf-8?B?SXovUkRYWHFrcitoRjBqZTd2S2llUFYzUktYMzM5T1J3Unh0K3M0MnBMYXI3?=
 =?utf-8?B?TzhrOWk5aGw3NjREOFNOdnVKbUU3Um9GZWcyQmZzTzRYUy9ER25XYlNmY3dX?=
 =?utf-8?B?di9JWFlIVkR3ZGUydGxwWTNxcUc3cDBzM29RWDhVOCtMNitEWjNqbkd6MGdy?=
 =?utf-8?B?YlpJTjlxSXV1bmwyNDVIWnJPZDYrNDA5aHdJZXhHQU92RWVnWHJKd01oTlJW?=
 =?utf-8?B?NUhQVnFPMWpZVlNDY2MwQ1phOXE1MVFxMkdlVzJMQlVjd1VIdzJ4cTFzS0xU?=
 =?utf-8?B?WXlKOHRjbzl2U3kyeDdLc1gzOEtFOXdsYTVFcU9FanZlOUpDVFZnekpCSjlD?=
 =?utf-8?B?d2tXNDZHSWpMUSsxTWh5bFlVd016aXpSdFZxVXp5TDRtVnZ3VGpxUEx0QmtD?=
 =?utf-8?B?b05BeEdQb0tDekpabFlpMVdrdTE3bHkrcHk4UzdPWEZTZnJLdFJPVm1SeGxL?=
 =?utf-8?B?N2JYQ1VQUTZabHNqSXVJOWNLK05FWVhKK1J2VXBDZ2hNU1U0c0VWT1VPeE9s?=
 =?utf-8?B?cm11cUZjL2JVWnZqQ1JEa1pBRzRwQzVBb0tNRHI4TmxIaWlVemJxUDBubFF5?=
 =?utf-8?B?N01ZRTRhRStHaUZYYmxCMUhWbmZKN3VkQTlEamRuTUVqZjhCeGx6RmRYOTJ0?=
 =?utf-8?B?b3ZNWG0vVGhiemNmZUhlak1hNXZqWWNPVnBQMU9rbFFjQ1VUVTZHTXRqVHNK?=
 =?utf-8?B?alhDbTJOeFhScG1LeHNrL0gvVFdvb3FHVk1DL3ZvTUxDbVQ5d2txd01ZNGpl?=
 =?utf-8?B?OXh5N0ZhOXVpc3FNekdubkdaN3V4amxyS1EycWNNTmpJbVY0R1Z1WU12M2xo?=
 =?utf-8?B?V1RndnhrbXdDaytiN1VuRUJmTGY3RXArc0lRbmdseURoc083RFdFWFBxQ3oz?=
 =?utf-8?B?dEl3b3FPc3Q3WTY1ZS84TzdXMGZaNlo1YXY3eG0zckM1Qkt5RHRtNjd0TzNm?=
 =?utf-8?B?cUlrQTFIUkpyT2twL2VJS3BiNkdUTVpNSDFNRHNUYWdIY2hKVTVOUVJhNVFy?=
 =?utf-8?B?ZDFtN2duY1AwTjQ4S3hTUlJDUnZsYXZoWFA3VEVoQ2ZPTVYvSHFMMVdiaVVj?=
 =?utf-8?B?d2pIdWg4TU1JVmZJNWNsakhaUmo3UFFVZVRTa1lySkZSeG43Y2x2d3RybVNM?=
 =?utf-8?Q?zloY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9def4d56-985e-4392-0ade-08dc9210f617
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:41:12.7450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWm+r3b1DIL1n03vIDbWPxUKjeqvNdgSQOB72cmIEP3h2G9Znp2FMQZr6GA9JUDh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8040

Hi Reinette,

On 6/20/2024 5:49 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/18/24 2:02 PM, Moger, Babu wrote:
>> On 6/13/24 19:54, Reinette Chatre wrote:
>>> On 5/24/24 5:23 AM, Babu Moger wrote:
>>>
>>>>     when reading, then the read will come back as Unavailable.
>>>
>>> Should this not rather be "Unassigned"? According to the docs the 
>>> counters
>>> will return "Unavailable" right after reconfigure so it seems that there
>>> are scenarios where an "assigned" counter returns "Unavailable". It 
>>> seems
>>> more
>>> useful to return "Unassigned" that will have a new specific meaning that
>>> overloading existing "Unavailable" that has original meaning of "try
>>> again" ....
>>> but in this case trying again will be futile.
>>
>> Hardware returns "Unavailable" in both the cases. So, thought of 
>> reporting the same without any interpretation.
>>
> 
> I do not see these as the same. When a counter is assigned and its
> read returns "Unavailable" then the user reasonably expects that
> retry will work.
> When a counter is not assigned then no amount of retries will result
> in data. How is user space expected to distinguish between the two
> scenarios that return the same error with such significantly different
> meaning? rdtgroup_mondata_shows() can just peek into the monitor
> group state and see if a counter is assigned and immediately
> return "Unassigned" if no counter is assigned, no? I see no need
> for it to IPI another CPU and try to read a counter that it already knows
> will be futile. This seems unnecessary and the generic "Unavailable" is
> not helpful to user space.
> 

Sure. Will change it to report "Unassigned" in these cases.
Thanks
-- 
- Babu Moger

