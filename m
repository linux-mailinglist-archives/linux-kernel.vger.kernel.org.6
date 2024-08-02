Return-Path: <linux-kernel+bounces-272822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9203794619D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE5D1F21623
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9E71C2AD;
	Fri,  2 Aug 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rxC/YS3/"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0331A83D5;
	Fri,  2 Aug 2024 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615078; cv=fail; b=Iq2bEP6pUVKnTF0lzSj4vMJVKmN7XjlICu1SgGErkUZuKtYBfRobem4ygpzBIqja/Hmnn+aZU0+nwAz4M39w9evHbXM4B8r7FX+ucBv0SCEZSujNDe8R0M2vD+/8YxN8xS7woXHOjD75w17SPrpNMgssNIQRl/SV0EVMW0mDJGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615078; c=relaxed/simple;
	bh=P43neXVB7YMcwnbOsBaYoXQDm5Kl3osOsjj0gSeEv+U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jnxk8yY9nNbycWE2pAlOQU6alMqBfUOyN9mjxaU5boG9q+yNzJ6Sw/eDcWPWqG0K14RzU7s+R+36ChVeU1OO3lOygr4Ifz8mqkqE53JSrvkC+i9n7+Ru5ylXXlF3cL58kttDoc94hISlNseYBFBzHbwIFJs5mDlNXWmSo2CisCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rxC/YS3/; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWEMtvXjhs2aOOieSPjTG2+jeHo3efpnhX9UVlmpzEjb/bFgjrYHaMNFqDeO6oQU0JV6C0LbKFW09T6xkda4yui+h8ZK3Mh01XwlpvJKNRVDEnbrnfwLjk/tkvWb1qZwH28HcPXRAImhu/3TuZxPR+Pai5ZqeaxZEFVJRnCRjVIAHMatvF7aZnCVAb/tOxqceZpgdZXm/4NoUYoDrQldA2rTsUKqAK9IM+mlzGYbaGjjK+jGSmGLRn/I9nzzO1+raBm1uJY5clJJ+oI29LvSzrddgLoqvfWoFMIeKKKmJRFegpMnUZc1e+VYORnSTCgaMI7lsJfjczcfpLPjJEJ5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vRJY9vraFxyqdGXHu43NpjvVmPS8+a6fqaC71C2Bxg=;
 b=FsUUw5y8nvq2fKet0ImfBm6R0jK0dp+j+fRrAGxszMD5o9RruTxGzf/LPcPqAJjZs9UWYhaQGcwPZiB2sDTMfSCiHmoAp5NUml4Lralz7bfWNZzWRZp0LIvBWGiP9kMzYhpYbX/BdJKZe4LGLqEbMPc7qQtQrYfAYZYhx+6AAbuPit52Yxs0LM38LhBVI5dHQMtri0tpMaLTIkYCXwVHuE/1puywy283pwhnaNGNiyY89Qu8H83ODPP5DgrOtMoXJobydnZIqlxCCncoFVd179gOzq7aNUN/ReY2+vyrBoQjx08Mpfllvg5sNqqjUcyA5cSDuO2/kfUhnNpez4Jfcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vRJY9vraFxyqdGXHu43NpjvVmPS8+a6fqaC71C2Bxg=;
 b=rxC/YS3/Oi85YSLfOnNRGqcxtwkwZ10rY9AcHRz1zKVqQKcSKwrYznhKorBEaWTHGJGF6qZUq3L0PAFapvQwhgmXYzN44zaMtdDcLfp2luiMQIVsq3mhbr8v2HVxZM+fN5OyPzcZKkTBpDX4L0nNLd72dmU58YYwqZxQvvn6NFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB8781.namprd12.prod.outlook.com (2603:10b6:a03:4d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 16:10:54 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 16:10:54 +0000
Message-ID: <fa42b2bd-a20f-aad0-d4fc-8a21649b33a2@amd.com>
Date: Fri, 2 Aug 2024 11:10:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 19/20] x86/resctrl: Introduce interface to list monitor
 states of all the groups
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <3be66db2dbbe2d231fd5afbe6c7f092278b5a903.1720043311.git.babu.moger@amd.com>
 <710a83af-ed88-412f-8f7e-33678a8ed197@intel.com>
 <d7dd2585-9f39-4e66-b218-4815bf888a77@amd.com>
 <b4d33443-e7b8-4394-9ac5-dc16115c32f7@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <b4d33443-e7b8-4394-9ac5-dc16115c32f7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0161.namprd04.prod.outlook.com
 (2603:10b6:806:125::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: 6428ccd8-1635-4d04-5c99-08dcb30daf82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0RXb29HNDR6d3p3QkdoN3FYRGpyYXFQWWp4dFArQUhUUkkzSXVOYktwNGQv?=
 =?utf-8?B?RWJodCtDSTJsKytacmZvYzBaM3BUa21IakdBc2RrWlhyMkx1WHptSDlTZWNW?=
 =?utf-8?B?VmRsOHNNUGd6VytmRUlFRzF6QlU1Tm9Kc2wwc0xPUEhPUzhRQTh3cUZSclBN?=
 =?utf-8?B?QVBuNHkwcU05L2Z6SEs4TDdSQTQ0UWR3eE5PczJNU0hiWUJCUFBRdkJUL2s2?=
 =?utf-8?B?TnR4WmFzckl0aTlnVVFOVDA2SHpJREVNcmVqN1FNQUhPbVpBYzdocW5ZZ2xr?=
 =?utf-8?B?cHI4YXViYU1nUnBvUENpakxUVjVOcmg0NFcweGRRSGxqS3hCLzBDOVBzSHVN?=
 =?utf-8?B?VVN2bWFrdUs1VXNkUTFlZ3I2UDBTSTdLMTJjVFlzMERmYnlqZGhPZE90b21U?=
 =?utf-8?B?TkR4V2QyRFdWdHkwU1JPdHM3MnZUM3hQWGFKMS9Jam9iVnE4RjRVSU8yUVRj?=
 =?utf-8?B?aU9nSjdwdndSRG9ObWVkak5FRFIzTG13UDQ3MkpDWUIwUnRtdStyYzZIUEdw?=
 =?utf-8?B?WTcySDA5SURaRmNHdWs0V1BBVktFeFUwczhHRXRLc3ZXWStSdWxOR05wLy9Q?=
 =?utf-8?B?cmlSeEpzVzVlUG8ycVY0a3c2ODlaY1I2cW44OWY1ODFJY05vK1V0ZEhQZmV5?=
 =?utf-8?B?NU85UkVnU1hOaEpZTTMyekEwbnlRMmx3bTBhREg2eFJ2dGVPU2o4VDZDOWhW?=
 =?utf-8?B?L1NGZGlvMG9nS3VzdjY5Mk5XTkdhSTlxSkw4TmpoSjQrdkd6bFVMTFJobWdw?=
 =?utf-8?B?Y0h2N3hQYTNTTWs3Qkd0c0N6RG14dE9nNjE1Q2ozSDllTHduWms4am9Zd3p5?=
 =?utf-8?B?cE9NNHp0dnpuelBFSTZJMEtEQnI2aVEySlh1QjE5M2VxTS8rZDM1OWlHK1Rt?=
 =?utf-8?B?aHhPUDVxeHpQbjY5OERhRWtKVktMbkwzMWNVTEt3Sy9ERHdqV1VEQjY0SDRK?=
 =?utf-8?B?TVlHbmQwaTFjc1UzeDlSalNlbWllTGhtdDlTSkxrWWFkczRCUjM0NThoNnc4?=
 =?utf-8?B?MmlPOEQ1QTNYaWUzcmMxTFNtOFN4ZnRSbWcyMmd3Q29nRmM2M1dvUkxJNmhS?=
 =?utf-8?B?d2FxR2xBSktYbU90dEQyK2FPRGl0ak9obzYxVGY5Qk0zdmRYU3k3UUx6bFpw?=
 =?utf-8?B?N2Vsai9iMlBhVTdpSWF1MjQ4ZHJZc3NjZWlkMFZpZVA4M2NTVWduTzNWZDB4?=
 =?utf-8?B?a0NMT2tjWkJBZlFRcm9nN2MyN0psVVRObndyNithWWZoekdid3NWVG1CNTBG?=
 =?utf-8?B?czR3OFVYbk5XVWVkdFVkU055Z0V6UzBkQ3VOOWVRNVFWZ2dVeUwvNmlHWk1J?=
 =?utf-8?B?eUhvWjU1T09BQ3MxTHBWV1dLNVJ3K0xvYUNVK08xZ1p1M2ZNQndtR0RWb0xi?=
 =?utf-8?B?RUVTUlVrRDEwQUkwRjdnTnl3OVd1aXE3V2dEV2dKeWZidi9MdWEyd0F6YnY1?=
 =?utf-8?B?N0RrK3pubzBkWlRlVmRhRmJXUHRPbTl5bk1GN0haazdHL1E5bzVaQzgxb2lO?=
 =?utf-8?B?a0VnVXkrdEZRREFtWmkrNnQ5Yjl0U0srMjVTbW1yNWgrYXFIcmw0Y3J5bWg0?=
 =?utf-8?B?OUtiNU9WYVdweGhyU2hOc09pRkd3dTNrNDR1NWFITGpxNFp4M0lPcllFUXBK?=
 =?utf-8?B?Y21HTGhBY0Z4eXR0MUF5TUZJTEl0TDZ4aDg0akdCSitFVGhaMWMyQkhDSTEr?=
 =?utf-8?B?VHQxcnk4SUpTUHFEOW9xaURoQXNrbGd0NklVT256NE9nQ3ZnL2RaSzNkOHgx?=
 =?utf-8?B?SGhPMFYzcHgxS3o4b3YycVpZZTkwYUk5bFUzU09zV0pxZFIrR01KazduRnEy?=
 =?utf-8?B?cnRNM2tuejdDTEt1blRndz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGN5UURqN2kvSDVVNjlvSGhMOWZsVktmaHFhVVN6WlU4VDAvTVRaR1lOMGVH?=
 =?utf-8?B?bVAzQ3EvUERZZldYemd6M0xoTVVodXJKWHdnejhmU3FRY0dNaEpwdE1vUWVO?=
 =?utf-8?B?aHU1MEtFdGVuQ2plRmcycXR4L29PMVlvUmJOUTNBNDIrc0xvUjgvQ0tBNUxN?=
 =?utf-8?B?MXdmOG9OOElGOG9BTW1nb1FKRnV1M0hNNk1pRWlpZGJ0TjFzNWhZNUJXb3dU?=
 =?utf-8?B?U1UySjdXT0lIeitWT2dZVk9CaitiejlMa0lxczdrODQvSkk4VS9IMUtFQTl0?=
 =?utf-8?B?OFk0MVJPMzVRa1FlWWI1OGJ2Rm1uZnUybE5nMXRVWFVQeG95SUxSNkQwMnpU?=
 =?utf-8?B?cHdOcGVhOUNmeDFHUGVFY3NlaTlob0RCT0kzcUk1MDBiY29LYTUza0RycEhG?=
 =?utf-8?B?Nnl2NWpxZTdkYlFIRVVESVlRQlZsVXNIZ2c5TlAySG5pVEZONnBwZ1NmN21O?=
 =?utf-8?B?ZzBFUENOL1VOUHZuOWxhQVprdTAzcWo0VGU0VENhN2lRTGJpZ0hkbU1Sbndu?=
 =?utf-8?B?MWxQK0FTR0RKR1ltb3RDUnJvVWZ5YnNVMUE1WWYwYnNvL09tcStCbERXd0xB?=
 =?utf-8?B?NDZ3VzM2SFhuTnZTek4wMzQraGtRUXRXVW9sU255Snp4OWthbkZTQkFUb1lW?=
 =?utf-8?B?a0ZNQ2tNYWN4Sk9WejQ5Mnk0VjlUbHNIRkRya0dJbWFUWUdPb1lDS3lBTkJN?=
 =?utf-8?B?SXppOEw2T1dLZndwRjY5bVg2YXdISi80MTNHSzhNeXBVREU2VzhZc09ySGVR?=
 =?utf-8?B?NHFhUnkvcW5hNVFKaFlXSFN4ZmhOQ0R4SnpZMkpRRmZxb0h5cTVUU2NNNlJB?=
 =?utf-8?B?UExuL2cxMEQrSGpCTjcwOVppL3oxdEU2bk5jU28vZjNseGh0aG85MXJLRDlx?=
 =?utf-8?B?dHN6bXBBZ0t4clVWb0dKdDl5OVFuc2poK3Nla1EwSGppWWM5a2dpR0RacFJh?=
 =?utf-8?B?OFFDdWtqRnZadTloOXhyZGR5b3hWeTJPWktEYkRlSkFuSUhRZVQ5Nld6Yi9y?=
 =?utf-8?B?VVZGakdBS3dYaXYydDBnK2dldVd1YWRyVHdRWlRyMzZJRlZxc1FYTTBNVEZ3?=
 =?utf-8?B?d1laSkUwaWNPV0prZG1mVHJxQnczVzN2ZEpkbXFXY1JtM3ZaTEdpNzdLN1p2?=
 =?utf-8?B?L1FwT2hIblZrL2JQWmptTmFOdnBiWkdCWFFlaERQOGZBcGp2Sm5xQ3Zyblh6?=
 =?utf-8?B?Kyt4cTE5eFBMdittNEUrWURDc0U0blNzSnJsY0pxUHBXTEl6T0Z0TWZZUkIw?=
 =?utf-8?B?ekZSckdjTWVHMEdqeWo4V0duZTVVMlR2WXFWZHFCN3paa2U4VDUwb1F5VzRE?=
 =?utf-8?B?RTJkeS9XNnVML3YveWZSMTFpK04xWmd2dnFKT1puSlN2SUZSQ1gzZTJ6UkdW?=
 =?utf-8?B?bmhSbW0vT1pCSWVuS0dKQVVjbk45TjNUNSs0T3YzVGJLNmtDaDdWdnFXL2FT?=
 =?utf-8?B?c0tHZitmTDZxWkJ1NEhKN3Z2U0dmTHU0SjBNN25peHcwWTFZV3NtTWhYbDF4?=
 =?utf-8?B?dUNOWm4zSTBscVJYcWVoY1d0SVM2cGxPcVNRbDQ1QmlaUEZXQm5uTXZweFBl?=
 =?utf-8?B?bVZzMk9sS00vcW9VaDl6aG1XN3hxU202VWx6R1dEbEZycko0RmFueUpXVHFE?=
 =?utf-8?B?QTNURDVwWVFZR3dUSjFnSHdwSDVLM0dYTndOSHhqYklYbGRCZll1d2JBYmJ3?=
 =?utf-8?B?UERLMlE3NkVjTStlTXA1SWc5MkJiaHZ6czJPeFNvbktBbWwwUlFYVkNwYUdu?=
 =?utf-8?B?YkdibFRVK296bUY0RGFEUXI0dGF5WEtlQUpUK1hrTEl2bXhHTGc3UVZzZ215?=
 =?utf-8?B?aWY2MElUMjE2RC9WL05IYk54S2JSVVEyUWhldlJXUWtlcDBBVUZZeTNJbG92?=
 =?utf-8?B?cVR3SEg4b0dKRTRTNHZ0SFVURGYrTzJUUStkN0t3Z0pHU25NYmplckxUQ0JQ?=
 =?utf-8?B?Y1dTSWs1TjZHTGx0bHorWEcvVzBpKzIwQTNMUVdaWUhOVjB5ZllDMVd6dmN5?=
 =?utf-8?B?dFNhdGsxTHdVMnA4M3N4ZFZSNDh0VDcyRGhXVjlmM1JyUGpzUHlKK2JrVmY5?=
 =?utf-8?B?eTBaNjIrbnFKUHp5UEpjazZiOHM4WHN2STQvZXgrc0ZHalN3Y3lNUHgyL2JU?=
 =?utf-8?B?TThzd08vYU04TFozMHZabS83QXFvNkYwWVQ4OU5nNEtYaTdMVzFwSDRCSlJz?=
 =?utf-8?Q?+VrUGRY+Qsayb8gVATbwwhk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6428ccd8-1635-4d04-5c99-08dcb30daf82
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 16:10:54.2506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTGNpPvoxDTInPKAbSCsAgOV3JopaDmYKSwgXozPEndfz48e0oqHb0esV2RRmvkm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8781

Hi Reinette,

On 8/1/2024 4:37 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/17/24 8:22 AM, Moger, Babu wrote:
>> On 7/12/24 17:16, Reinette Chatre wrote:
>>> On 7/3/24 2:48 PM, Babu Moger wrote:
> 
>>>> +     */
>>>> +    if (rdtgrp->mon.cntr_id[0] != MON_CNTR_UNSET)
>>>> +        if (!rdtgroup_abmc_dom_state(d, rdtgrp->mon.cntr_id[0],
>>>> rdtgrp->mon.rmid))
>>>> +            dom_state |= ASSIGN_TOTAL;
>>>> +
>>>> +    if (rdtgrp->mon.cntr_id[1] != MON_CNTR_UNSET)
>>>> +        if (!rdtgroup_abmc_dom_state(d, rdtgrp->mon.cntr_id[1],
>>>> rdtgrp->mon.rmid))
>>>> +            dom_state |= ASSIGN_LOCAL;
>>>> +
>>>> +    switch (dom_state) {
>>>> +    case ASSIGN_NONE:
>>>> +        *tmp++ = '_';
>>>> +        break;
>>>> +    case (ASSIGN_TOTAL | ASSIGN_LOCAL):
>>>> +        *tmp++ = 't';
>>>> +        *tmp++ = 'l';
>>>> +        break;
>>>> +    case ASSIGN_TOTAL:
>>>> +        *tmp++ = 't';
>>>> +        break;
>>>> +    case ASSIGN_LOCAL:
>>>> +        *tmp++ = 'l';
>>>> +        break;
>>>> +    default:
>>>> +        break;
>>>> +    }
>>>
>>> This switch statement does not scale. Adding new flags will be painful.
>>> Can flags not
>>> just incrementally be printed as learned from hardware with "_" 
>>> printed as
>>> last resort?
>>> This would elimininate need for these "ASSIGN" flags.
>>
>> Let me try to understand this.
>>
>> You want to remove switch statement.
>>
>> if (rdtgrp->mon.cntr_id[0] != MON_CNTR_UNSET)
>>     if (!rdtgroup_abmc_dom_state(d, rdtgrp->mon.cntr_id[0], 
>> rdtgrp->mon.rmid))
>>      *tmp++ = 't';
>>
>> if (rdtgrp->mon.cntr_id[1] != MON_CNTR_UNSET)
>>     if (!rdtgroup_abmc_dom_state(d, rdtgrp->mon.cntr_id[1], 
>> rdtgrp->mon.rmid))
>>     *tmp++ = 'l';
>>
>> If none of these flags are available, then
>>     *tmp++ = '_';
>>
>> Is that the idea?
> 
> Indeed. Thank you. Can this be done without hard coding the counter index?

Yes. We can do that.

-- 
- Babu Moger

