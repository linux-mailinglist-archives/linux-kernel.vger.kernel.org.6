Return-Path: <linux-kernel+bounces-293248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C519D957C80
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C58E284669
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CE4139CEE;
	Tue, 20 Aug 2024 04:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EJl9h8L3"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D48753E23
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724128735; cv=fail; b=hlPqEgNMt8jeV8WhIo2bhYCGBJBtca1h4yOiO/cLvfjgfDgLd0ztwfgNgDGSwUgDHMfaGW0Cf+OGQSVkw36S4GDs84851dmPnkx0pficqCdHH+rMWhwQ9ag195ULxhvaTRrBPoxwANKXH833yYbFuru4kG6QaVHB7tJuksDjkw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724128735; c=relaxed/simple;
	bh=BzEgB5SFkM1cLeWdaB7IfooYlU0v/BwUA98jPLyqJNo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eHe+iTGZaBVuubPuLcXmP0TNxyp24vIpIy5heoifc/Y9V1BS5i7q1MMpeY4kQsNo+QstUAfyyWf/GpqDVj2n16PDdqJnjQ7BWzHmfyBVPJQwBX/70c0qVI8Po9b62KhumPkHrvxl0hkbyrQDCmCmbg8TmLKlBcb00N3P8vuEwNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EJl9h8L3; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMHvTjq79I5TVnJJ4lUX1nB2AWW/LDv3kavmttTcgRdG+nqrMhwRucNNvbyJMvT50nvZlt7SylFiXHY3ZPClNguce9o1UY2G6c+LTvSeaOXAYP3gBKx7gwdnWUUHlt2wLvQbAOC/Y+VIR6lbbr0AKtbSkV4YwEM4Lcfu/AJLJoGW5nRAkQi3i6u4jRmboFWK+mJZYwreKvchoepXI8cb2BzkvooZe/SCC2kpVK7nGUz8CDYCcOQxwVO1vDdtZrS22v4uIftBKHRf0KdrK6Eub7FkW9E1N0txagI7AdWK4PRtkO63xicHPO6ynOelq16kapdd5HSb0Kc+uiHmCzEaeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KsS+uHvkLuRJy2NuBNNgkIO8BO35iCVbms3VKLYYcc=;
 b=fvBauZoEwhV7cmwX45AVqd8F26yUUM2QHnGOBM0tbM604PHq842FZmyYEa07GlM1QsJkkQmm6DpYlNnNx462KJoCLldY/v31p1EwChtDeoRtl4udk1JNB4rbfhtxC8gWHli8uhwzg2BpiQLY/280yL6z6QMT+zypvTdSnzGAG/cogyCQOutN1310q3gvZZbkBM5brL1N6aIVU+MijCt/yNzfl046IwhTa7sG8tcnn/obLr/Vr6Eqpy5aLQTZCCveMl7R+HMRTy/tOwrIw0+WRqeCCMicxm+NcfySssPjFSX1pIYPw3/Cee7XFtdW6Xr1bdbz8CewkzBbkIKePOrgmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KsS+uHvkLuRJy2NuBNNgkIO8BO35iCVbms3VKLYYcc=;
 b=EJl9h8L3EgoKs7W1ptYbnmE3Zx9VkCHEyfFddLweUgYWlwHYT4CSZ7mDQomzV1HKw1gkPNJfiS/U1AkXTLO2s6p2AO+a2uAoPieF2VqQQlPM2dyCVMzX7jJdlzsDN1B8obTjv/qDHhQTBLV6v6X8XfG+xNwWo8GNYuDLOVoffYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 04:38:48 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 04:38:48 +0000
Message-ID: <16573630-4cd5-4539-8f02-85cbbeb3866d@amd.com>
Date: Tue, 20 Aug 2024 10:08:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] mm: drop lruvec->lru_lock if contended when
 skipping folio
To: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org
Cc: yuzhao@google.com, david@redhat.com, leitao@debian.org,
 huangzhaoyang@gmail.com, willy@infradead.org, vbabka@suse.cz,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240819184648.2175883-1-usamaarif642@gmail.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <20240819184648.2175883-1-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::27) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|CH2PR12MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e111161-322b-486c-ed94-08dcc0d1fb45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RW4rRGxVTHlPeDkrTVFBcWJqVUFBVU1Cb1ZwcFRocWZMcVhuQkRWYWg1T245?=
 =?utf-8?B?djNiNmdlNjFrSTc1Y1ZUaWRSamFrOWxRZFN3WmtpemJQbU5pS2FDN2YvZzRF?=
 =?utf-8?B?S0xXTktCeUJSMm5FNUxiUCsxT3BlZlEvSWNoNUFyWHhES0dreWtrdzlRdkRZ?=
 =?utf-8?B?ZlYwYUsvT0w4UUJYMGorTWtDVWxadWdyaGdYaTNtSFBKZDRpaWpZZHVCcWxt?=
 =?utf-8?B?dkhUYjllSnJNOHR2MTc3UHFSQVRYYmhQMnlocSt6L0wvVkxjdHBmb1AxdjVn?=
 =?utf-8?B?bERIZGNlQjgvNFlMVjhoR1RIUXMxRC9wVG9YVy9zT2RqdDM5ckNpWDd5MGg3?=
 =?utf-8?B?N29ZV1hYb2ZTK2xkaDNkSC9nM2dTMWFuQkozeiswcUJOVDNueWU3aDlydTFG?=
 =?utf-8?B?MHZ5TzRDMzhzZjBSVnR5RGR2ZnJ4K3JZb2MwSkVwOVMzWTA0SDlaWmRnYitl?=
 =?utf-8?B?WjRtd3JuQ2xjUVZLcmpFa216dEJ1aE1LdjlCZEF5MFE1c3R6bFE3Zk8rQkpV?=
 =?utf-8?B?OGFDd0N2L3dCUm5QSGd0RXJ2S3I0cWFNeXo4KzRDczhiRzBJazN0akkvVWFM?=
 =?utf-8?B?dG9OL0dPSmNVejNPTVJzamRLMEx0ZTZTRUtUTFlvK05IWVJXeUcvRklqS1Ri?=
 =?utf-8?B?amp1QzY2U09hWmZpR2pRZ0FVd01ZdFNaOVFtSkFERXlYSmw2UTFiRFNENkNO?=
 =?utf-8?B?WWZ0SkVNdHd4NEFKRlpVWEgrd2Y1SEtndU81MDlFUDRjanJyczVDQTFLVU5z?=
 =?utf-8?B?S2Y5MkV1WUR6SDRqUjA4V2trOEd6eDJPYmJhZU5sOEVXajRLTSsrYTNRcytB?=
 =?utf-8?B?K1lCTExWWFRXc3VDc0IrTStCZE9qdzNJa21UV1BXc0NKSFJPenJXSVRKdFNX?=
 =?utf-8?B?QndXZmtwMmZmTHVIL1V6ZWF3cG9UYUpIZVdiVHU5R3NWWVcxS09PNmZIMWp3?=
 =?utf-8?B?UTByRHFLdUVyV1pnN0ZPNzVndFdyVlJTbHpPL0xKNVFab3p1SGV3a1lGR1By?=
 =?utf-8?B?RzB4S3M0eHg5aklBZmVaM0piSDVqT1Z5TGFsM1hERDN4Q1Y5M0JrMitHZkVo?=
 =?utf-8?B?aWRiamxaRzc5U0ZQZnRzZGZTc1RJeXYyeWJjV2tLYzBoQ0VNczkvSFRoSi8v?=
 =?utf-8?B?dkFNRDJCRWdnSjh4THplOWx5dm9Zb3BpWkh6TU55Q0RoSTNEcFZYbmZqclJM?=
 =?utf-8?B?SUJEdmFuSnJXaEJpSkMwQmdaNEpNSDRtVWs2RjJmdHpiWnoxUGRGZGdTNlQ0?=
 =?utf-8?B?b0J3TVg4Ulpteld0RFRVeThoSHdpZFJFVG9hSUNLTVM3S1V4SnhramFONzNw?=
 =?utf-8?B?YSt0SXZMVUtqSEdsRW9ycU91aUZFRHUrdEd6QmxZVDhrYkhMbmp2eUZKT2Va?=
 =?utf-8?B?b1VQVk9rSXFUajE2UTVFVGpTTWtVcVJoc2JLaTZDSUo1dXJrblBwcUFLblky?=
 =?utf-8?B?SHpSc0tqTWV2ODFsV2NVMXJiYWl1Yk5OekJ2eWVwV3J3VG5hbVlqRWNkcTR2?=
 =?utf-8?B?YnlVamw3QVdBYVVlRkpoZ1M5aDgzTVZZaEw0NUpYMnh2R0IvK0FuZ0NJS3Z3?=
 =?utf-8?B?MEdjeUhOL01SelBhNmx3VGNTK25rWmI0VDdneDFHWStxLzIvcEZiT0ZoTFdD?=
 =?utf-8?B?L28rSUlaZVBzNjFKeDFubkJ0TEJQVHd0cncza2J6U0pGUDdRMDBOWjlhZCta?=
 =?utf-8?B?Y2t5WnlQdzljZkdvNHg3VHhEUGsrSHZaaUJ0ZE1qZk1HQTUxWU11QUU4Y25D?=
 =?utf-8?Q?cLwaNfgiQ9XSm4Yo5A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHZ4eDNIbC92MWZMWTRHZG5uQ1JEL1JlMWs0azVkM0dFL25IczFPNjY4UElS?=
 =?utf-8?B?MVp3ekRubWt6dFYrRFY0eTFPK2RYWEs0N1A3VTZpQ3FjZ0VQdWRvR0NRQ2dE?=
 =?utf-8?B?a0tEYTZVL0lCSDhLR0t0YS8xY24vWjE3U21jV1FrdlAxTVpGdjVIUHBWSHhC?=
 =?utf-8?B?SWlzRXlPRnRTbEFUMDM3YnppcEUvK08vbTZWdm9FelhMQ0UwSmFSWlozcGpj?=
 =?utf-8?B?WVhRSythYVhPWmxBejd5Zk4rKzBVSEVqWmMxR1Fic3k2czg0Nng3eVloQ0Mx?=
 =?utf-8?B?MmtSUzc5d2k3RVhhM0daZmMzNGxldmpxckFwU0dIRFU2NU9mWXlhZ0ZaTWcx?=
 =?utf-8?B?ZE81NDJnM3BZT24xN2hQTXZmTitNb1hSRVBjd3FPWkgxUnlGOWg4dVZ3ZGti?=
 =?utf-8?B?NWpOY0NSd0ZrTkhOTFVOSDJrTWpGWjJxMU5vYTlPRE1YeGI0V21IL0EydHRX?=
 =?utf-8?B?Tks2dzJRWlM5Y211L0U4SU9WcUk4OU5EM09yc2xvNWVhY1BqaCttNEhaeUR0?=
 =?utf-8?B?c1Z3S01wd2NkYm1oM2cxWUNCdy9nanFBNGdTS1BuYXM4MGFIRFBkUzB1RWRD?=
 =?utf-8?B?bWhqdU9NdFIwd2RVMnFWUlNIQXM3MU5za29GWCs5MS9QWFhwZHg0ZEpCc1Yw?=
 =?utf-8?B?YlVQd01vUlBoMHV2dmpVdnh0OHFTSzdHY3c5OGFYYW9ZTjluajBuVTZjN1Jz?=
 =?utf-8?B?MmdycmFUOVorSUR0cjdNQlVjdFBwMWdYN3BDUDFJNXJ6SXI3MmJ5L3RiRTJN?=
 =?utf-8?B?ZHViNkY2alhKV1liMUI0Mmt5L25QRFU2dGNvZ2NKb2Y3bWdnWWMycEUvZm4y?=
 =?utf-8?B?WU9KRU9aYWE0L2pmTktIc1NTK21HcEpMZjZISFlzVm1xNHJ2Wmw1azkxc2NL?=
 =?utf-8?B?YnFucDlJZmNnVWNIM3dzSUpUSzRyMXNVZTNFRmRxRFlLNFh2RWFCU08rRHVo?=
 =?utf-8?B?ZWJiMmxleDB6cEtrU0NNc0FwRXAwaVFESmphalQ3aGsydkpES3JXUXpNNXZU?=
 =?utf-8?B?TFlYMytCN0NYNHdqWnRhRTQ4RWRORXZDNnJuNGMxR1poYXN3TG9WWGt2WW1V?=
 =?utf-8?B?UVNhL1I0REZuZzY5SmlDK2ZBTzNZUnQxWS9UZ3pITjVTTTN2UEJzWWRHbGp4?=
 =?utf-8?B?WGVMWHRLVXlyRTZCdHBYa3N3cllNUjFLc3RVNTVqcHl5bnlKUlRseStob3c4?=
 =?utf-8?B?OFBLbW92U0VBY3E5TVFxNVpOOVZzUXh5QmJPUldzL1dRL21FWHZIRk5oT21I?=
 =?utf-8?B?cDkrK0hrTnpvdFg4TS9RSGppZ0JQdEdhVW1ydU5NbndNSGk4Q2wydGZCeW1k?=
 =?utf-8?B?T1FFcHJrSTA5TUVhZCtmQnN4eWhlSDkwRlI2aTVDSnNxYlNNV25DQUtRbFA3?=
 =?utf-8?B?dUw1c1lqeTY0RkNhWThOdngyWm5JdEllWG9ZdDB1VFNBc3VQR3N6OUl3N1lj?=
 =?utf-8?B?MEJ0VXdGNUtITklONTFWUjkwZm1PNVpLYWdUREVJTGVYRDlNQzIraGNDMmtw?=
 =?utf-8?B?MFhxQnR3bVFJUDV2UW55ZWFldVlMdGY5a3FTK1Y1dmdzWEpJWlZYV2lPVENk?=
 =?utf-8?B?N1RmUVpVMWVPcHJlVXFRSXYyR1NVK2hxeEpadTdBa3pNVzhFYkEwODRYYTJQ?=
 =?utf-8?B?ekMxcllJN0ZhSFY2V1RIaCsvakhGMUROQnZXQlNnaTdxMnFBTndISEdkeE1h?=
 =?utf-8?B?alNPUlFOYlFFSkNXYXY4OStYQmg2TjRrckZRYjN4WW5TUUwyRjVOL3EzQmZh?=
 =?utf-8?B?TE1FWC9HQ3VZUEZsUHc4NytORGNETkNVNVFJRU9PMkZCb2xMcEU5ZnBXUDNk?=
 =?utf-8?B?VVUreUdrR0JpSkgvcW9RV0ZtVlVtUjBLT0FXbjArRnRFM05lVWliemMxV2Rn?=
 =?utf-8?B?K0dpZEZHa3QwaVA3Ym9vV3gwV3dLaytHWlBqZDEwWkxZSVg2cHY4NFJZbXBs?=
 =?utf-8?B?TGh6dnlESlpyaFNnUE5zK3RkeDRSNktnZmZMZWZ6R2JkL0EzcTRFeGc5SnA4?=
 =?utf-8?B?WWNzbUk1dlZZaWtxWjFuaXBWckJFWncxVTc0SEVFVklKNWl1cFhmVlNkYTFU?=
 =?utf-8?B?cmFpZmhOZFZtNGhZVlpBb3pOWEZmMjhqTm15WE9PeTlJaVdtRDNwRmlTc1Jw?=
 =?utf-8?Q?xlszM89gHpLEEMnYSI/i1uvpu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e111161-322b-486c-ed94-08dcc0d1fb45
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 04:38:47.9400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/pJcxoYBCLQNjpUHb8Th4qMMDqcEFE5e1v9cftnYwR+i0ZGG4YH+euaj4uHdsPujKCmwjrAnCAI+kfwDkS1qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151

On 20-Aug-24 12:16 AM, Usama Arif wrote:
> lruvec->lru_lock is highly contended and is held when calling
> isolate_lru_folios. If the lru has a large number of CMA folios
> consecutively, while the allocation type requested is not MIGRATE_MOVABLE,
> isolate_lru_folios can hold the lock for a very long time while it
> skips those. vmscan_lru_isolate tracepoint showed that skipped can go
> above 70k in production and lockstat shows that waittime-max is x1000
> higher without this patch.
> This can cause lockups [1] and high memory pressure for extended periods of
> time [2]. Hence release the lock if its contended when skipping a folio to
> give other tasks a chance to acquire it and not stall.
> 
> [1] https://lore.kernel.org/all/CAOUHufbkhMZYz20aM_3rHZ3OcK4m2puji2FGpUpn_-DevGk3Kg@mail.gmail.com/
> [2] https://lore.kernel.org/all/ZrssOrcJIDy8hacI@gmail.com/

Though the above link[2] mentions it, can you explicitly include the 
specific condition that we saw in the patch description?

"isolate_lru_folios() can end up scanning through a huge number of 
folios with lruvec spinlock held. For FIO workload, ~150million order=0 
folios were skipped to isolate a few ZONE_DMA folios."

Regards,
Bharata.

