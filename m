Return-Path: <linux-kernel+bounces-531682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EB7A4439A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29181888C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664F021ABC9;
	Tue, 25 Feb 2025 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dE1X8kXf"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D4D21ABA3;
	Tue, 25 Feb 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494991; cv=fail; b=JZOJa3YTvY0JztQYGsMdCzL3OQcOVFQC1ZXqjKMStijnstosFD7/PsamEOFKgrrf5Scdw2ZGu9DqW80JlPCDbC3x1j1qlqAdtb1MoJuxo64vGEOWdp/p0Y+NcNC5EoS9njT7sjQ7iqAfq3NSkcYwOOqDlnF4NNuCwfNPmsK3F4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494991; c=relaxed/simple;
	bh=bn2QOGz3+bkXEDQ7hTB0CqVr5NXD3TPOQ263jp99NJY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EyR9WkmwzNxzZ+EA3de4bZj33XrKbog4QrVhVSVH101gRhY4SW+zZ+PGCVkuNVS2IcDBiC8SZt/wM5+NQKcdwjaNAhrw3fU/jwkWu0xej5yOPDSpzWBvJXS/BerktFBazWdcaU4QNN7LU2StkrUid34x0oOaAolJ/jCTlxFMmso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dE1X8kXf; arc=fail smtp.client-ip=40.107.100.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGB8uO94NkLzMBf9foAGO3otpEWxOHGn4BSFFNN/g58bDudQBh10lQap9WPmI6a0f9drm4spbSP2zT+/LKILKSmeI4lKUjjR8sXL3gwTuSXpl9di/z5fNDDfLiD3PjSrgeotyISWerTNrYE7er8O1sdTqHSxLTU8rIWJcVAxBUqbsHTQ2VuTRp7HPvdg1zqeNZEsfPQMHfdoosFuWq6yDnMFH/LSr1OwqoW7tYmvSqQG49jmdZQYaSST1GOtGGDuVcXl3GG7Tdwy6GflIyVuy9rSTpWhG1e/bFq5SW2D+tIYy41aW/Qq6+AZiop9NlE6hHjrpxVvSG8WYufaNnSWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYPBiTZTzDPW2BZFi10K06ymkBIC5g82+54i8hM8ACg=;
 b=iZBfWYsKpVN1uEvA9RGnY3wajyzTcJo+YLAcTOg+/jz4hvdQIlF4GiMexfIabYymmJcq3oAoOQhZUoA0SEPa6qSj9euN/BTAaZBz0OzIHP2Pf5zbjSCBhon+lLs84I3ktAIG1H7dMh4R/58aNUgdq2nywqZ8ZuiMwuFE32/zKVIeHw3rRtNkHydh5BcASoTVMRH1enJVOObeTiZqkHFnNVGWxV/IRoBI2nFHdicIxsv2BFTNJiZzOe+58KiaZyScPTSApEU94Kzmrl/CHlosyWuwL952QncEjF33hc1rEdlGdnghE+UntQCEeWySNmOpaJ8pwqCF4Hxd+IdOCKKMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYPBiTZTzDPW2BZFi10K06ymkBIC5g82+54i8hM8ACg=;
 b=dE1X8kXfqyLqBUohY5zwSvdbpvu4wZhmKQ2ccEyH1y+jK7j/8ZgO0f74GPYLdI9jioGy85+U55yjMZATU7TIYh3lnuFBZumSaRPODGiCSc8vAgbrUEKgndTAMo49aLaidtSp0eoa3lcA/AnjWhmc1Wn+l1Xm0KYuHzlnh+dG76I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 14:49:45 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 14:49:45 +0000
Message-ID: <4612ead6-d76f-4a24-ab4e-f45b0178d70a@amd.com>
Date: Tue, 25 Feb 2025 06:49:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-wmi: change quiet to low-power
To: Antheas Kapenekakis <lkml@antheas.dev>, luke@ljones.dev
Cc: corentin.chary@gmail.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20250224223551.16918-1-luke@ljones.dev>
 <20250225142555.14005-1-lkml@antheas.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250225142555.14005-1-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f8baaf-67b9-4ab5-e63e-08dd55aba4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTZuS0V4Y0MvWHNWZ2hpN2hpZ1E0UnJ3M2xnOW04aUJSNzc4cVlUZEdLRGMx?=
 =?utf-8?B?c1ZEb1BUbzNqU1EyZlNQdWpUbGhBVDBGV05iTDlMcEV5UGkrV29Sd3laUEwv?=
 =?utf-8?B?QXRrUTUrTWJGek9RMllDd3Z5T05WYnB0UGczV1RTWS9EeDFzK1hGZGkvTjdM?=
 =?utf-8?B?Z25SOWMvTFkzWndOTW94eEJSRDd4Q1VVNmdhZFJOQlVRUzhacUtzalJuNEpU?=
 =?utf-8?B?NXAzakNFL3FVdWs4MVN0VmRZZGcrVTJyVjNaR0p1MmJyVysvbGVhbnExNFlM?=
 =?utf-8?B?eUpkNnduYnRlUHVCQjk4QTRqUGROZ2VnSFFKVGV4SkgxV3QvdWVYdmlMTTVh?=
 =?utf-8?B?UUlGaTMwbCtWTis1MGg5NnZOUjRGNi9FbUdIZmx2TElHblhoeHIzVGlVRlNi?=
 =?utf-8?B?c1BsRHk4Qkd2RnNFQVEyYzUxNm1VS3BrS0ZPdXlBTmhnWk9JNHlPSVZEalhF?=
 =?utf-8?B?Rml3U1VYUHJ2SnFLaVlSaE41b2VEK3kwd3Q2R2lyRDJwRFlnb1VURkFJcW40?=
 =?utf-8?B?cjhDV0M1S2tUUVpSN3BSOXcydDlnUnBSQVpBVkZXekhNN2pTY1RoL2R2Wnlm?=
 =?utf-8?B?U2ZKVkdOZEJwZXk3K3dOYmVyOVFUUEcwUGdVdldWd3A2RGdabHdSK2l0WHRL?=
 =?utf-8?B?MmlDN0ZQZWxoUlZyVGtMNkVKbFNKZnpqNm5JVmFqYVVHbVhWOEhWZUMxYVFE?=
 =?utf-8?B?b3JjMXl1cXMzL0pNaEsyZUNjVXNMaWJVMTBkTXBYaEovM0xBZFlYd1cvV2oz?=
 =?utf-8?B?OTBLT3BRQWJmQmxlUjdWaEc4UG9oVjR0V2hvR0RJMG5CYzdEZUhTMmxBRTZh?=
 =?utf-8?B?UnlMUHd6ZzM0bzF5amlrd2xVdUVyaGErRDRERmJ4VnJIeThxZHYvMHR3N3k1?=
 =?utf-8?B?Z0NZVldrZy9qc0dQK0hLMVlRYy9tMzZTTW9kVFpBdjhUbmJudDBMK3VQUVVZ?=
 =?utf-8?B?ZGpUdUhaTVBtL1plWTQ5cWxObU5aeGZzM1dFa3J5M0JKaTN4S3J1eU1mQ2Fn?=
 =?utf-8?B?YUpaRlRlNkRSU3RGUmtXTVdqNFVmRkZld2tHelp6Q21mandQSXJKTndWeWdx?=
 =?utf-8?B?MVhSMUptVmdZMXBJazJlTFdWZzZ2UGtMZUo0bzVHdjJlS0tnQklxeWd6Titj?=
 =?utf-8?B?L1pINlJzVENJM291VStaZXFiM25zaVY2QXdsdlpXeUxiV2V6OGdaZWtlYVl5?=
 =?utf-8?B?ODFjeXlDNGVzVGZlaDJYcjdLa2hlTTIrQVBGVjRmbVVERlBuU1dweEVPSnFH?=
 =?utf-8?B?dHFhclZDRVMvUkZCMW1pTFVuSEVBNWU0eWEvazFMaFplU0wxeWx5NEo2cWNp?=
 =?utf-8?B?S0RsbTNWa2ZrRmtLbHBQN0pnakl0UG1EeVEzRE4rallqYmVYeWV5VU1FNXpu?=
 =?utf-8?B?NzJCdnk0UEpsS1E1a2NXd2pvVThmVEljOWg3YzZQZ0hJenp6UlAwb003eWEr?=
 =?utf-8?B?TDFWYllSbFNia0NtRWVvZDk4dktmZm51VDhlbXhwTlRVWXFIOGNtL0lpSCtT?=
 =?utf-8?B?ekpielJBMVAzR09TQ1c1eTRnLzJXWjZKREJYQXpQS1lQNDBOcnhLVUtmZW1n?=
 =?utf-8?B?VkZGejhoSzZQajBZYWczdWxVUWNTeC9IVy9CUS9uaDBnMHRaTGcwb0NNb3pM?=
 =?utf-8?B?ODhkKzh6U2I3ZlRxa3cyVkE2NmQ3RnJRR1FhTHhBZUIybWZkTkcza1VMZUZv?=
 =?utf-8?B?UlphVGdjYVdjaEF5aEU2VVRYZkRYTElqbkFrYTZKL0ExNFpFaTBLV0FwNXJu?=
 =?utf-8?B?ZzNuMEcxOU5pUTV4Qnc4aWFkQlNwRW9FaWxPakptMXRiQmppREdKKzBNQS9n?=
 =?utf-8?B?ckJIeWxuUmFnZzRnZEVoa1RyNk9IWEU0WERubVRFQWo2NTVHTnhocDBNTFhz?=
 =?utf-8?Q?88JKvuoZ2w28b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDFWK2x4SmxldlM2bHkxbEpVUXkrL29zUEZlMDhrMms3alBDSm9uMUJzMy9m?=
 =?utf-8?B?RDNCSU9SeC9BdlZDZDV6N1hXU0Y0cUxyWi8vSGpoYUtNYitZV1R0S2VIM1hq?=
 =?utf-8?B?MTNrOUVPcFMwRjdFckFoRFpxTXJlVzF5SDYxVTV0VGU4SXZHZUM4MCt2TzZJ?=
 =?utf-8?B?RHhVcVVDdHk5bGo3SFBjTVdISG94VzRFc1VEa096RVMyRDdiMUFyQk45TTZl?=
 =?utf-8?B?Ty9xVWgzUUdubm5BVFM5a0FYV2kzZ1pzVjlIQ2taL3N2K0poUHkzK0hYaTd2?=
 =?utf-8?B?SExKUW9ocFQvUG1rbUFzU2RGbVBIWmdaaUpzY2FlVWk3aVpaMWYvWk9ud1VK?=
 =?utf-8?B?K01tbjExODRuanZTeWE4OFBjd1VsM1l0WXMrQ1VqS3hZNlErdTV4OEN4d3Vr?=
 =?utf-8?B?M3czbGlNcHZvOUN5cWFFV29ncVpvWHVjYnVsYmlkK3dxdW9KMDZmRlBQZUtR?=
 =?utf-8?B?VFllMGNrdkxMSFpVVURYUitybjBKM3F5SG5yOVI4VXFWRUQ5cUhsVTBTakZ3?=
 =?utf-8?B?ZzlOWEFwaHFmd0U3VzRjcUo4eFNadU95SGkrM3MxUHVCUXhyMTYzK29Lb3pB?=
 =?utf-8?B?dnhhdFA5M2d3VmtkS0xyanVzcGdETTJyemNEalYzUTd4anlUSDkwRCtJNksy?=
 =?utf-8?B?bnZvamJuSExYQ2tBNVAzZmZ0Zmh5dWZEK1RCUlExMHdCUWZSUWhoWWkxd05i?=
 =?utf-8?B?RDRCVTVrbHdmbUN3TVlhNDlvRFpDZnpkQTdYY1cxRW5wMFk2UFBza1BxZE9N?=
 =?utf-8?B?NHBnaUFOTEh5Z2ZHWlZsNVAwdzBTd1lZQ3JQTUg4VU15eWx6UzM0RVJZUkZ4?=
 =?utf-8?B?bk1wSVhDU0EweERWSENqazRJNTJBanRsdGNPYXZyZjZSc3RuTEFlQ25Hd2ZN?=
 =?utf-8?B?TkJOa3hDZnNySTgxT3YzVDRZbGhMYnRhMnBEQ3BuNnJBRHYzRjFMczk1S3lt?=
 =?utf-8?B?enZDVHhSRng0YlpxbHh0SUhLZnhxYVl1MkFtaEJNd3BleWlXVEFlSEZkMlB5?=
 =?utf-8?B?Z3M0ZDR6YU45NEZjTUtId2ttd25wQzduTXdQQ1FjSVNtUWdSTTB5V1IzcWll?=
 =?utf-8?B?RHZ1VmVwdFpvczdMc3lxd21WZ2ZYVmdUT3FJTUxQRXZPUVVjM0ZaU0kzS3Rp?=
 =?utf-8?B?WWM5cmpsdFRoSnhFZ1EzcjdmcHZNOExiSWx0ZGhjbERGZ3hmbzhiY3JnSmp1?=
 =?utf-8?B?TGtnVU5UNXdSbWhBQUJQcDE4eCtMTTZvMU9UNmVmbFhTcngvc3NadFZkNG9Q?=
 =?utf-8?B?Wmg1SWRUZzUxTDZSdEUrWVk2SVYyYzRJbEJteWZCbm14Qk5OcnlJMnFUWE5z?=
 =?utf-8?B?VGlFVmdNU3g5bC8xZjQzdFQycFY5Q3FSZUFBSzhvT2MwdHo5b3J3RkdQQ0xJ?=
 =?utf-8?B?MTRESEdaa1ltaTlpaXAzaXR4bGdiME56MlZvVmFseTQvZHp0RHZyR0VOVnZa?=
 =?utf-8?B?V3B1WCtPZldITWxhM1liait2czFWaERwOU0wWjFOLzB2NkM4VUtObkdqTmgz?=
 =?utf-8?B?SGt3dytmMXdWeXZZL3lGeHI5ZHhVMTlIY3ZMa1A5UjZvQ1hHcm14aDNnZWJS?=
 =?utf-8?B?dkJibnBDNm5BUDBtWU5SNUY5YlJqYkl5TWloRjBPS0NlZHA4Y2k1a0dQaUIz?=
 =?utf-8?B?NGdlVlBmNlE4dm15aXpzT2RPallmemFBTkVPQW02dEVGNFYwRzdkR0xKZTdw?=
 =?utf-8?B?U2ZyS2orYlRzRm5OeGNJdE02ZE5NRS9xN2FvSXNFUC9INzErbVNrMFNubkd1?=
 =?utf-8?B?NjdWOG1ZN3FGcExKMmFnZlJIb0diYkNSVUduWE80U1BpRk9IZ2JxbmNYaHFJ?=
 =?utf-8?B?QmFyM1Q1K2UwNVpld1p5VkQ0WUo2aG9WaFRMNDc1MXVLc1ZSSmVvcHgxN1p3?=
 =?utf-8?B?QVFqa0RIU3VRV3dzRnFTbzd1OVFPcU85Rno4THFBUTJVejV5SHNrSU9qcFJa?=
 =?utf-8?B?Mzc1UFR5ZEc0K09VWDJsTDRQV0cwODk5U0hySWxJS1h1S1VPeW4zdG5vS1FF?=
 =?utf-8?B?VE1VMS9xMlNTOUFjL3Y2cUNTMFRYTWZuNy92eExwNmtyQk1SY01zczNneVA4?=
 =?utf-8?B?eU9JVzVVWk5XUmQrT0NvdGN5eVpkRmhCbCtYL1VzN2FoUzE1MDM1RmxzRXEx?=
 =?utf-8?Q?Ccgq2LP4tKcvvswOnxF/zE7Gm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f8baaf-67b9-4ab5-e63e-08dd55aba4c5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 14:49:45.0375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUGN7kt0BT5qF/1NBxJuthtaW5UUCWLrwlJkmgen0N+7L3IyJFyIGGQtDcM9FmN92XcsGC89Zn/uVF6bG9TCLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787

On 2/25/2025 06:25, Antheas Kapenekakis wrote:
> Hi Luke,
> please add appropriate attribution.
> 
> Closes: https://lore.kernel.org/all/20250224195059.10185-1-lkml@antheas.dev/
> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>

Good call on adding these tags.

> 
> For me, this patch series plus the multi-platform profile one constitute
> a double ABI break. Not only does the legacy sysfs for platform profile
> regress when there is a second profile handler for a device, but all
> hardcoded scripts for Asus devices will have to be updated.

The documentation says to look at platform_profile_choices.  To 
determine what is supported.  FWIW this is exactly what 
power-profiles-daemon does.

> 
> While I would personally like to avoid this, I am ok with it, given
> appropriate attribution, since I did go through the effort of reporting it
> and providing a mitigation.
> 
> @Mario: you added Reviewed-by to a patch without proper attribution. Let's
> not rehash our discussion from few days ago. Please try to do better when
> it comes to attributions in the future.
> 
> Antheas

It's an oversight, no malice intended.  b4 (which most maintainers use) 
scans the whole thread for tags.  Adding them inline as a response is 
totally fine.

If Luke needs to spin a v2 for some reason before this is committed then 
he can add them as well to the v2.

