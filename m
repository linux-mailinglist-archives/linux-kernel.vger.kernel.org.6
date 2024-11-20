Return-Path: <linux-kernel+bounces-415784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98E69D3C41
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D40428843C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8907C1A725C;
	Wed, 20 Nov 2024 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I8KmthfN"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAEE1A2C0B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732108030; cv=fail; b=A6kNPWyNLNUnvGKzjOaPs/RnpYLsfz82ARZzN5z3Ecl1JfZ6P5as+CnlAxQT0kYGeev3ZuFksren1YxePlwL8yIoeE7ZZymxgm1wmSg3bDnPFoWd69rmqVDG2WfQrvkfNq5N4sTK9DARfhBTUVvJ6VEsnAKvXahoV/qXp5Cnwj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732108030; c=relaxed/simple;
	bh=7W3J1BRnSaz0hk3k1+i8veVefi7uvzABIMbDzblaZlc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rsOP+ToMQnqDai110Dzna9BuW4uc1O0xTVyLXdaIJc1BsfPj9jDX8OCOWKb6buzRTcNpCxjhwxBOL5YxBxPkQ4i7O/ZwX+z7CFMAFFlD/lWpAndjblxABnFH00BEJMDFE9cZLEyUpVDAoeyEqTe1WmnUeKBeJcpqSzJXoQlMGcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I8KmthfN; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiv3C2flCzNyeDIr1tUEm3d88Bi3V+r25qrn8MSQDxzZhBI/ICbeyE1iruHQtFacVx+ACfAKsghyNxD0OT8hE9HBNLVbkkSZDOwlMPDDCHqTTrNCwGaqzTrgrzYjx/r9WD4xPx2CE+HPANeYDkTFvHxXnWALu5tUWvTq6Q5htG3usydO6RnzH6S1jpfDaaM9bG8l/dkvJMsug5hiFTdIU0heiWFK8E5lR5bv8HERxPIQv35tjNEHr5eV7UtIgKUSo2+qMfSKW1nZoQEBwDhlgTUuAfGYOt/bC/51IYEYTpTrdZAJzZzLL9lySQeIIFuRnOHfexw/lSOyBl8eo/3pPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/x0ynnS4nz4j4Wt1DOPHMO0u9sor6K6tZRXwNCBJszU=;
 b=O6Dkc7r0VfspKhMFvPlyeTI+FjICmEelCuWMtrypnsl7/1WwDVOFcQayRGewenOc4ykuB6OptWcCKUyKGAUwFfGyVFtpGz4xAYmc0oB37UebceFEBDbfrncoAuPsLAoNX4FwjbOzSkg895cWG4ym/uMt2pIdTrKH39IvG2v21ikGrLf7ZDEpaMewEnydIfYUktXXzxmVXJ7um4+EeCoeRv0ENjRVnmaWjDpJ3FbkkN/pxTftj8oROU+37jJpKp+X3A3K4eiWTVuTW0bKnyiOBYNvOSLBFhtvccXX/8zVDYNSh2OGH1h97+aIFPBw7zLFN1Wnp6YWSeeNsemrc6e5Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/x0ynnS4nz4j4Wt1DOPHMO0u9sor6K6tZRXwNCBJszU=;
 b=I8KmthfNXV+22l6AvpOEPT64twOoiFZXYK7J7k3GAdlofhb3Z6nxY0VtgrBt5eq5x34VZ2A4XYHBl2BuOIXZzf31DPovDRd8lXIyM7R50VKKnvL3D9dyn2jFeHGbc0bGCwCHNM7Qn06JjWaeFbGKrayFPy76uGI0q9AH61GUDyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 13:07:05 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%4]) with mapi id 15.20.8158.019; Wed, 20 Nov 2024
 13:07:05 +0000
Message-ID: <d64ebfba-49db-4b04-9a84-b9ecd26e6c76@amd.com>
Date: Wed, 20 Nov 2024 18:36:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] perf: Simplify perf_pmu_register()
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
 willy@infradead.org, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20241104133909.669111662@infradead.org>
 <20241104135518.198937277@infradead.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20241104135518.198937277@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::9) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MW4PR12MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b2c78d-3e74-4d28-3801-08dd09643ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3ZPQTZ5YzZNZkhSZWZvUHhZdlNTcXF4djRHZ0pIeExBczNZamFUeEtnZ1NY?=
 =?utf-8?B?VHhWd0V1Nm1kUFhxRUJtSGNlMCtra3h0UFhRS3h2VzNYNWVHMkd6enhhdWR0?=
 =?utf-8?B?WXBpbXRlQWRINWF3ZEo4UHgrdW9iQ0MxeUlDYmcvU2ZCYlhOMFgxc2lhV05j?=
 =?utf-8?B?SmdrUFRkZXdIeWlENnhjdFVKeUlTcG1sME0rV0xCcnVTSHlidXozb0lUMEtt?=
 =?utf-8?B?STBTNThtZVhrTHoyWmhqcDZVb1VuMER3MDA4NGxlTkduNGFERDFaY0I3Ykwz?=
 =?utf-8?B?dXhWRHFwbjh2UDZ6WXBpZlg2UWlubGRoNVRFSFlrY0ExY1ExOGx5VWtNenpz?=
 =?utf-8?B?aGF5VGNLZ2RGZkE1bEl3bGZMSjRHc3hrODB1bEtSR2tNVWROU09GM3NoaWt4?=
 =?utf-8?B?RkR3NGE4K3JGOG1DcDBtQUlVaVRFcCs1dmIxOTIwQVZwNW9Xby90M280a0xl?=
 =?utf-8?B?bFM3eFFrWFZUQ2dzUVRldzVsNUdqakE3UUJJUEtMdVJBZGY3bWs3R1ZiSHQx?=
 =?utf-8?B?LzNJYW01VUxyT0RFTHhNZHQxWWMzYVVaNDBaUFFPMlhzQXBQWUdHU0dxc1Zp?=
 =?utf-8?B?WTRCTk1YTW1oRlJXS3VRR0pXaW93SnpWanQ2bkJHdUQrcFV6Qk12SVRFa2k2?=
 =?utf-8?B?YUJjZm1NcGpmYXBVNXRFUytwRlBtZUFuYXgzeU53YlZuWEtobWQvNWZqSWxW?=
 =?utf-8?B?WkQxcHc3RVJaYVJ3TWtEWmpINnJQbjBQR3VtWjNxU0Q1TmFSL3NHRmljK3Nt?=
 =?utf-8?B?b2UwbEt3S0dWem84Vyt1em5hWkZWRXJQWUthYzdwVnRmYnZ2ZFR1bUUrS0Jt?=
 =?utf-8?B?K1lGSWxaejVSam5JRXBrNGtZdm1Ld21rQXlyUE9PYndxVWhxcFpkb1BjV3Y5?=
 =?utf-8?B?dWd3VlRTWGtmU1lLR0E1Q0lwbGI1UEZydzNZM3JzR2xJS3doWVJWRjB3ZHZ5?=
 =?utf-8?B?dlp2VUVpT0xFVC8yQXdncE5IY2l3eDdESWE3Z203bUt6V25zTDJLUFJyY0dz?=
 =?utf-8?B?eG1DYVhzcFl6NE5YNG5xaUlCVFlXZXFmZzZ5UG56WW1xcHZ0Y1FyblgybE1J?=
 =?utf-8?B?SVRPd21ralZkZVhjeEROKzVrajdGb2NsUTJxdy9zUURPcEsyUU5NbjJZUmZm?=
 =?utf-8?B?UFNRanc0VVhwWWRlUEx4Vy9JM29YUnBvTEFYRlVpd2hXOGkxc3gvck02MTdE?=
 =?utf-8?B?WlRNZktPbklHWm40ZElwcFdkYjNxNEtSOEV3b0ZvQllnWnprTUVlcjh3SWRJ?=
 =?utf-8?B?ZlNwbXZIMVBGaStiYitQZWtmZUdNaElCdkgrMzUyRnBlVTIvZkhZK2dveis1?=
 =?utf-8?B?azZQbUFjYmZLeENWQ3NNWkY3eUJJTFRKcU9mZFByMzltSWttTlU1NVpZeWJ6?=
 =?utf-8?B?Ty9CNWU4eTdUcURPRFFLa2NpWXZ2Y3FIWDdQTlBWWWd3OTc4N0RCR2F3eHIw?=
 =?utf-8?B?VzdxRWNiM054Z3RBbFB5VmV2YW1rVEMrR1d1cjllRzNMSDV1bkNoelhzNE1X?=
 =?utf-8?B?emtTU3dINDVOeW01UW01YTFDdGxYenQyN2hCQy8xTy9pZFltOTFKZ3RIMVJs?=
 =?utf-8?B?VW4vdFExdXVKUVVBckNzU0ZMS2l5QnBtTVF5WXRPalZ1UFhzK0NyV1RlZzRQ?=
 =?utf-8?B?VlNwMzRNNFFuTkJIMHlzNXZOb2FtZlY5ekFNbjJaWHB4Q2t0eTRPWHh5L0VJ?=
 =?utf-8?B?SHpTQVU0a2R0UkF6VEM5N2lVWkJJOTVONUpuMzRzZDA2ejk0c1p6OE1mQ0s0?=
 =?utf-8?Q?WfyDe/XCHqs4bf+WHvINlM/X3INDzbSf/LKuiu0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1djVzU3MXpJRUp0M2xOUlhmOU1MN1hZRzJPaGpIZnFOVmJTaHlFeVJCbWt4?=
 =?utf-8?B?YzU2NVIrTm9iVnI2N1hFRTB5VmRPL2pTaEdiOXZ2RUpieDg4L213T0JjQWdO?=
 =?utf-8?B?ZVVWclArVnNsbDd0NjhvYzQ0anp4clA1R1g5N0lYMkJ1aXhUMSs5RGN6TWpu?=
 =?utf-8?B?VE9ra1NQRnlnclNnL0t2RXplM04venVYMkVnV1Z5a2R4Y3o4TVluUWFrclpB?=
 =?utf-8?B?OWUrVzExMXNrbWtiYVBSNFdLbDhBUGZiL1ZJbkxYM3pzalZ4c2NZQzFFZzRB?=
 =?utf-8?B?S3pmZzkrUnY0eVFXK2VMQi9JWTErRVNmZGVNMXJqM0NrRXZybUFvSGUvd0t2?=
 =?utf-8?B?RHprMGpUNm5QYVU3TkNhVjdLQnp3aStrNVB3TithZ0NnSER0ZFphdnFReVpW?=
 =?utf-8?B?V1paOGRNSHA0YmlyTEhacXBVemU5dWJBRHB1TDBGVkk2K3ExeVpnd292aEMr?=
 =?utf-8?B?NzVRMzJ0a0Z6RkFJVitVaERTRnhvZG04VXZXb1FxU2lGeGhnRmNnd1MyTEZV?=
 =?utf-8?B?eE5KZGFYTEJiRm1tRWxuUmFMMWpyZXZHTVdOQ3NYa1hkaXdNSDVFVzQ3Z0Zj?=
 =?utf-8?B?ckdFQWxpYlRycHBkemt0ektQQ3ZUaTVYNXNNSVFFYi9aWWkxUXRrWUx3RDAz?=
 =?utf-8?B?VnVxNkkvTFJzNnEwWW04MXRxNjQ2cjNmbWdiYzFERitZQzNXUHZEMGdaalNt?=
 =?utf-8?B?Vjg4MFliay9oU2tvTklid0c5ZklZZmtBYnhQM0wyWDNBZlpOaHdDTUl3VmxW?=
 =?utf-8?B?bTF6TXpLWW5PSGZiYnhsd0Z3cW1uLzlPU040aVJJUVlSQmNYM1lWb002V09x?=
 =?utf-8?B?TU84OVc1aUdGcnM5VzJQT3p5dDV4bEJXSDRpeXU5bENDZTExYk9nWDR4dXdC?=
 =?utf-8?B?U3Y2WFZ6THlhN09KR1g2Wm1nekYrKzhsOERISUxhK0I3VmNTeEsxS0JlblZo?=
 =?utf-8?B?bnlRRjc3TnlXQi92OTBKczZORnhFamsrY1FhUGlyV0hRWWd1T1NzMHA1dmdI?=
 =?utf-8?B?cWZlSFVTVExOYTJFS3NUWGZhaTljN2dRbmVKMWUxREhLd1YrTFRSdlNFTU5D?=
 =?utf-8?B?d2dUVzQ0SGZVeVBZbDQ4bEJQYUR1TndRdjlVOThiU3FzTk40OElrZGQ3TmdO?=
 =?utf-8?B?WW4wcWdGUWxoWmdoMFRLRGJxOXZYZjh3aDBRYis0OHJKb3V3am1ORTJEYXlS?=
 =?utf-8?B?QjhVaEppTkxhUysxNHltNzBNaTBzT2NQRzl6SWFjNzMwV0xMc1hET0g3TEdy?=
 =?utf-8?B?Lys4WjJQSzNKdVpHeDAvN0ViUFpzQVBZbkhaN3VPdnNURnVKZ3RPZGYvdGJj?=
 =?utf-8?B?c1RxT3llNmFPRS9yR3ZFMVVPWXRGZVRBSGp0OG9qTnlRd0JhNm8yaXRwWWR3?=
 =?utf-8?B?M2N5Ulh1STZUckpSczdhSkpHYjhObFM1d2dadERTUVVmOEY2blYzNzVYVnRG?=
 =?utf-8?B?cDdnMWk5czlTU2pQZTk4S3JqMW5samNpb3ZrbjlzSjdZRS9yTjdNOFN0VHN1?=
 =?utf-8?B?TmxWa3VGd2VXRjFNZUtQQ0hibEFycTVhS1NaRVlsaWVhNTkzM3VidDJQTGY2?=
 =?utf-8?B?Z1dFWEtoOWxUV2tFK0hQTjNydHVxQ0VFS25kMFFucWJvRitJdVlYYUYrTTZM?=
 =?utf-8?B?VHU0NFgyVjhONkl0clQwUXVpYUN1YkJhNFJGYnNndXZ1R0tYTGpFT0U2UERp?=
 =?utf-8?B?dnhWTHRXYXRPMnBLMHFkME9qU0hhaGR2WUE1K1FQakRudmJhWjRES2Q5WTdo?=
 =?utf-8?B?Rk4yRVBQV2I5R2xuOGFwT1c1MEZ5MG8zMW1VSU4wRjJ0Mm1Sby9YWmc1NXZL?=
 =?utf-8?B?Zk9qTGQySlBISTRmVmFqWnF6M0M4cW5DTGNJMkVFTDdjYkRwSnRQMUd4bXhR?=
 =?utf-8?B?MlJyQ0YxdEluTVFsQ25DQWh3cENTUEZxOXVBaXBLOWR6RGxOclRIc3ZKUzAx?=
 =?utf-8?B?YXZ0Z0JrRE1jbmhYU2FKQTRPRU45WFFqdnNCOCtsQVVzSFFRWEdnR0o4Qm9P?=
 =?utf-8?B?bi9Fa29OaElndVFaSzBkSkZjK0pIR1dGTlpDQ3dHWFoybWNMQWQ2OVVkcUMw?=
 =?utf-8?B?UlVvK0gyR0YzSDVPaTB4MUVnUkJ6N3M1TUZjVGZsM2F6eVdTc0FIR2lrZnZT?=
 =?utf-8?Q?EHcEU+eUf/QeAsO3ZhN0DQAk7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b2c78d-3e74-4d28-3801-08dd09643ae1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 13:07:04.9439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UKX72GxYG8MU1kOjaJHGPK6YhXush2ssUjEZYrbYkhAaxHq9HZGfO47Ls8NFUKCjqZQdao6Qda1vaShvoy5OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334

Hi Peter,

> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11778,52 +11778,49 @@ static void perf_pmu_free(struct pmu *pm
>  	free_percpu(pmu->cpu_pmu_context);
>  }
>  
> -int perf_pmu_register(struct pmu *pmu, const char *name, int type)
> +DEFINE_FREE(pmu_unregister, struct pmu *, if (_T) perf_pmu_free(_T))
> +
> +int perf_pmu_register(struct pmu *_pmu, const char *name, int type)
>  {
> -	int cpu, ret, max = PERF_TYPE_MAX;
> +	int cpu, max = PERF_TYPE_MAX;
>  
> -	pmu->type = -1;
> +	struct pmu *pmu __free(pmu_unregister) = _pmu;
> +	guard(mutex)(&pmus_lock);
>  
> -	mutex_lock(&pmus_lock);
> -	ret = -ENOMEM;
>  	pmu->pmu_disable_count = alloc_percpu(int);
>  	if (!pmu->pmu_disable_count)
> -		goto unlock;
> +		return -ENOMEM;
>  
> -	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n")) {
> -		ret = -EINVAL;
> -		goto free;
> -	}
> +	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n"))
> +		return -EINVAL;
>  
> -	if (WARN_ONCE(pmu->scope >= PERF_PMU_MAX_SCOPE, "Can not register a pmu with an invalid scope.\n")) {
> -		ret = -EINVAL;
> -		goto free;
> -	}
> +	if (WARN_ONCE(pmu->scope >= PERF_PMU_MAX_SCOPE,
> +		      "Can not register a pmu with an invalid scope.\n"))
> +		return -EINVAL;
>  
>  	pmu->name = name;
>  
>  	if (type >= 0)
>  		max = type;
>  
> -	ret = idr_alloc(&pmu_idr, NULL, max, 0, GFP_KERNEL);
> -	if (ret < 0)
> -		goto free;
> +	CLASS(idr_alloc, pmu_type)(&pmu_idr, NULL, max, 0, GFP_KERNEL);
> +	if (pmu_type.id < 0)
> +		return pmu_type.id;
>  
> -	WARN_ON(type >= 0 && ret != type);
> +	WARN_ON(type >= 0 && pmu_type.id != type);
>  
> -	pmu->type = ret;
> +	pmu->type = pmu_type.id;
>  	atomic_set(&pmu->exclusive_cnt, 0);
>  
>  	if (pmu_bus_running && !pmu->dev) {
> -		ret = pmu_dev_alloc(pmu);
> +		int ret = pmu_dev_alloc(pmu);
>  		if (ret)
> -			goto free;
> +			return ret;

pmu_dev_alloc() can fail before or in device_add(). perf_pmu_free() should
not call device_del() for such cases. No?

Thanks,
Ravi

