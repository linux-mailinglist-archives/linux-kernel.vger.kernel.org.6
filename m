Return-Path: <linux-kernel+bounces-417616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA8F9D56B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B02E283367
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F914A08;
	Fri, 22 Nov 2024 00:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZPW85emD"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E322115A8;
	Fri, 22 Nov 2024 00:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732235192; cv=fail; b=Y+DSX+nRXVrRMn45cfqnx3oPj2tiEUdy6RAj4Jq6OHGzEL9VEGenT7oi3vZPbS/gTfoArMWEi8d7UEivTX9SW04bypBZE55M3p8xV8gC3W18+AhqtzqcMVt1/imJUk0wNTG7aQugOGXv2NW2Eco/tbbGvWoV29jFfz1hMCfsf0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732235192; c=relaxed/simple;
	bh=t666rcpcdg7cWtu7u3cea6C7wVtWVfxw2CYt5n/XPRs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CIL7nzg+DqPfyrbdWuhSONwsmGBEOUgy1L+AnBjh7164JHaHdtndwve2cStI6U0EB9nq+lDL+M+SrBEsAuztX0jt6onjhMn1b9ulbHlcLRsDWrh2BzDa3g7UDUi/RurweP77FNHeNQBAsS9bh8Q7EkNu+TIDs0xNWmURkE2KzXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZPW85emD; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftA6oPUndC8z+rwvQJNlyb+NipKKPvA2uHnH/bSf4fUUO4vm1DJmLOJBmNQsS+UBsFFmJSNkNYBnwX9maxClaMpzJiLIevI7L5+J72g4cxVosJrbeZzMp5twipF4eqGPQi2C8fY3P8vm0kPoyfEg2ayciZ67blLvtnK6zXngvb20lpgTr38hJt/iXKKGeMcf7V07VpAiNJNWq9dxJ6HILQLHjPGd3MW3VzWXw9DTgMeGh+5c1DZ1s8YMh+5+PUIfNgqX5eptfvLGs3RxD2+Br246x7y/9O52EW8qNvjqTBYP7MEcQT1j2CAExgaVRt0xGCL9aJPC+/T8KEOPgvLVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT1SlPbKDAJUWQ9Iq5TdCb/9fyyHRfS1k1v4SnOiUH0=;
 b=f+P0PpXAXzi5cPy6G8mzdaoMa+SOoigkt1dALE7NybAxUYVtDpibnZE97K7tbQLODEfM2YQZCmTr1dR4SZpQ+mDFHeKg2XTa9j5ncG646JAz8WyTo32TT12bPZOEhp83KPPJ4TULK/BwOa0MTAhq6882a365kxEriIZIOsN1Yq4UmuF8vltdFM2oUDq5bhXDyrnr3RdXYtpTyAZh+iK5Gi5gNMvPtdd9V0udabfGGInZgURmgZlZQiLSgB9E4843+1dC0ROSUn+GkeRookqcjjkZrP5iinvyAp7FQboTjfhYrDeDOh3xPI5RbQTjHTW+T8OfXFXqIEMrIKpmlUhjGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT1SlPbKDAJUWQ9Iq5TdCb/9fyyHRfS1k1v4SnOiUH0=;
 b=ZPW85emDzKKGmTLy3qoxm/+4nBzE/eLzje20xr8J1avxzAKluCY6DKlwIdNLipSVHOEP9hhTk8oGiS9nkCvZUdN7vx8DVV8Dh8RFR2vZbOOgEu5qomPi4h1AJGsGMmnZYCoFtAP8ZLjXzGwOVg6Zee7slplukAixvb5h0oD8bi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 00:26:26 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.024; Fri, 22 Nov 2024
 00:26:26 +0000
Message-ID: <d9571277-5d1b-39f2-696b-27000cd8fd3e@amd.com>
Date: Thu, 21 Nov 2024 18:26:21 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 20/26] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com,
 paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com,
 ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com,
 james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peternewman@google.com, maciej.wieczor-retman@intel.com, eranian@google.com,
 jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <4ec00fe60cd42c1f22c98c9f5c2f5d3ceb9f8d58.1730244116.git.babu.moger@amd.com>
 <79b8049a-b213-4d86-a021-cfd9f7389f5b@intel.com>
 <3d32c528-24fb-e701-a70b-331d1a04493a@amd.com>
In-Reply-To: <3d32c528-24fb-e701-a70b-331d1a04493a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0046.namprd12.prod.outlook.com
 (2603:10b6:802:20::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aedc729-487d-42d9-d564-08dd0a8c4d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEJicnAzZzBXZlN1R2M2cEV2YmVkWWZwMGdjWmp1Z1pHd1UvNEg5c0tPcWZX?=
 =?utf-8?B?d2VyeWJjNThCZ3MrbEtYdUtKVTcrd2NRTm5JbEFRdEZFZTg4dTA5MnNiZmJL?=
 =?utf-8?B?d1FiV3lQbTE2WDcyK1M2elhNOXdUSnBrbVJZNXhMVDlKTGVjMmRUVjhhWjVw?=
 =?utf-8?B?cnlBWkFjaUxaVFVtM1FsMzlZQkpZMEdXMW0xV1MyTFlTZGJSSjl2Q1hLZlRp?=
 =?utf-8?B?dEx0SnlvMlVBRGJZa3VwcDQrWnZMdm80K1JyT2x3NUVSSmc0VzFwaHNQZHdz?=
 =?utf-8?B?dGU0eDNROEVaYWdQdjFDbUkyS3VHVVh3MU5FcGJoVUJocXNMN095eER6TDlm?=
 =?utf-8?B?aTVjZ0QxNnY2L3VidkdIbEJxOE5lNms2VmUrTHkvcjUyM1pUM2J5K3Mxbk9N?=
 =?utf-8?B?N3V3M3ZST3hPSkYzSnRuZS9YT1ZmTVFKRzFYSkNiYlJ0cEJodG5UVjlYQkpm?=
 =?utf-8?B?WmFzUk5NU0FJOWZxQUhrOUgvTVo2RENVVDViYTU3MEViZ2d1cUtTeERkelFB?=
 =?utf-8?B?b09kdk1sc0JveTdMWVozdng4dUZHcnpRUjJDS2E3THVxMjZQY1NZSDdnZkRT?=
 =?utf-8?B?Q21DWjdiVVpqSExNUWVOWU5Nd1QvVit5blhHejlyMU1QOG1TNXhUd21GU05Y?=
 =?utf-8?B?ZDVHY2wwSG40SEtqdEVLdWhJYzI4eVYwRHg5NFRzNzdNK0ZXK0dEOFdiUm5x?=
 =?utf-8?B?bVlMNHZOY1l4SU5tbm5YZ0JvOVUxNTF2eTNGa3pndFd5RXFBWHNmZkVsNzVy?=
 =?utf-8?B?RktIcGd6K0pSZXg2eHBJRVRhUUdkejRqbWlXNFZKOUF4R0poSHhZTXg1SmZH?=
 =?utf-8?B?UFl5cDlmdGxHYkM1dWpKU3F5WUkwcjRaUzlRSngydVJSZTB0dDRZRDlBeDVG?=
 =?utf-8?B?UVlFVTE5T0lScDlHMDBnVElRcVU2bWs0ekN4VE1lVWVvQmZqOUYyYy8velFM?=
 =?utf-8?B?TUl5bUR5am10VzJqK05SbkdZQnpvcm0wbEo5ai9sRkp4UStQMkprQTVUekJj?=
 =?utf-8?B?WjFPaUhKcnpRRlJ5S09zZUFyUHFiM1Uvdm1FbmIrQzRKZnltZ05jM1pwQTd3?=
 =?utf-8?B?bDY0dkMwVS9vRmNseUdSeC9vaEtrQUNmTEMyYktpcWVFZjA3OVFHUkdoTFpJ?=
 =?utf-8?B?VU1iNWM1L0gvMGV6bjBuMms2dmdwUVFmNUlLbmhjb2c0dU1zdEZ1SVdMRXlr?=
 =?utf-8?B?a0VmVUNLY1dxK0dLQkRjNVJOTzUxL1pUM3hYMXVvai8wQk5iY1E1citrRWdq?=
 =?utf-8?B?TTJFTEhqTTNqRlZWQ1FWVG5WdFZWaWtMbnA0QWVBeW12ZGJVMXJ6elhXRDQ2?=
 =?utf-8?B?c0FYd2U4Z3RBN0p5QTFxdGtkTzVpNmVXMm01MzZoRnUwUlEwU3REL0RSOENF?=
 =?utf-8?B?aEZTR043T0x1WEU5S3BqQXdEUm9XR2xEN2RTWCsxN0Rtb1RBand5VFM1L09t?=
 =?utf-8?B?K1RzMlMzMjUwV0Z6WmhiVW44MHFYZHpRR3F4bTFjQllJMGMvRlFPeXFFYWpB?=
 =?utf-8?B?TTVxaDNsblFoVzI2VXhvVnZkOCtWd1RNbGRzQVBkNHcrN3RLbjBPSkJURFBw?=
 =?utf-8?B?aGRYNGFhMnV0R0I0Q3NoSUhySS9DU2RwSE9ZOVNNTGIvRE52VDRrR2Y2b3dQ?=
 =?utf-8?B?eEVYTWtybkhKOGpsQmtEMGdtU3JLWnJOTmJ1Uy9QWjhSK0pvUExsWlVYT0hx?=
 =?utf-8?B?dmJXeW5vQ2FRVTAwMG9LaTBrYlJuOTUwN1A4NDdJSW9CcmZQckg1dDFUazRY?=
 =?utf-8?Q?1PWNcHIVn+UJpcWAoTFgsqP7Pb/6aBzqCvRxSnI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2pQNFpCbFZrVm8yZVlFTnBIdzIzL2Q3L0lOMXdDeHlYaG1icVl1T0ZwYnRV?=
 =?utf-8?B?SGNDRWpDMHIyeXN2UEdyckMvckhrUHRXeGYwdThpOTF4cDhoOExNT1dUNE1a?=
 =?utf-8?B?c3d3bWU2N0ZYQzFlaVlicERoN254bzM2VzdJNG85RVFBemZMczFWRmF3Ty9K?=
 =?utf-8?B?ZXgwekxFMGpQV3gveW1rVkRaWmltdkNjMGhUdkYyS2t1UkREQmtyMklXQk5X?=
 =?utf-8?B?b1E3M2JlTGs1NE1MN2xXcTRMT0RPampnTjRSdHNyTjJyU2NaQmo2bjZhajFW?=
 =?utf-8?B?ZHB1VDRpLzhWc1B6VVRhUWIzM0lJVnh0d0RHYmtrakNqSi9zQUwyZFJSK2VN?=
 =?utf-8?B?SXVOQTNaNEJzYmJuakpBaTdpeGxtbk85U3VEdnppa0tXTXo4UmVHWEtFWHQ4?=
 =?utf-8?B?c21DOU1Jc3pnTWhrOG9vTjhKYnJmcmgxb0RETG8rL3d5eXhHYWgzR3hWSWln?=
 =?utf-8?B?SW1pbGxxYm1KbFpza1JWTE5sY2wvVTd6SGxvcXZFcnpIdUxzaXViOHpma0VR?=
 =?utf-8?B?TnlVSHhEWU54TytTUktBWXYxN1FZN1c2M000SkNrVG9LZTdUb2pGUTVNZ0hz?=
 =?utf-8?B?aWFGVDRIUmIwblEweDRWYTNPQUJJeWM5bk12L0tiOFNicEkybm5USTZyYWFq?=
 =?utf-8?B?SmwxWXJVbWJTeDA4SzlRK21IKytwTmhkQThTcnhobDFZNFdxU0M0dXdMSW5j?=
 =?utf-8?B?WGU1QjZVN2FycW1FME4vcWVCSXpQbDFVQVBkZ2JwUDVlSm1ZRG01azEwLys1?=
 =?utf-8?B?d2lYZkdZYTlLNndvMFlYczBUTHphYm5XZzhSZGZOcC9BamJ4WjZMY0o3QUNI?=
 =?utf-8?B?WCt5YlRWRUpiWHFoNUpESE0rOU56bGpwbkxUTmFzakd3cFljMlJEUlM1b0wy?=
 =?utf-8?B?Qm41K0QwSTRHcDdQRGlwbnNZU1JjVGZBdXhqWGdjMS82TEwvZXFTVjRpR2NR?=
 =?utf-8?B?d2hId0poQ0k0blExU3dWbngxRXJLbUZEbWlRcVpYYjdLVUZienFzNndpdkNF?=
 =?utf-8?B?MGZmcWNGYmk0eDBKYmJxcjduYU9zM2RVMmNGVDREOHpKU3dEUVBsV013QTBT?=
 =?utf-8?B?dS9Yd25LSWlwVDJ5c2xSaS9QMytjTzNkMDVBRXBEcDBkaDgwbm9EUWxsQXFh?=
 =?utf-8?B?aWlidlJiOUVEWFg3ZmdlbjBsZitKWXNPSGxKNVFCMjBiOGFlRGwxZWxrUHpn?=
 =?utf-8?B?a0RscWtVZUQzRHJubXlOSzVTTGR5K0duSjF5TjhaOG9RR0JwUTZiVUJwcTVn?=
 =?utf-8?B?cm96QWFPb0hCdnVzOUovMjFnaFBuNXRla1hza3hQT2h6OTljQU44K2l0M0Jm?=
 =?utf-8?B?QThqSjloZ1Z4ZXovclBKRmh3ZisxZGh6aTRHbWFjRDZRbWkzL3dRblNrRkZN?=
 =?utf-8?B?bDQxZGtIOHF3eDhMSWtqbzZGTGVhZ0czQlNaRDJUcy9PU3ZoUGtKa05JcFRa?=
 =?utf-8?B?RjNlb1BVdU1POUwweENKcHFUNGl6Ky9IaEFsdy9qMmlIM2xDSjk3QjJwRXlM?=
 =?utf-8?B?ODE5SitNMXVncGxaMzJKUVdVZjM2U2RTWkZDZlcwemE2c3hINStCN1RyZWc5?=
 =?utf-8?B?T1FieDVEU0QvREt5RzR5Z0pzVlB2MUIzVldGRStaQXZSQXdoa21wOUhZODQv?=
 =?utf-8?B?MHcyMVhsTVdjd1hVVEFCbFYwZTZFUGJEZ3ozSUdVcWFtQ2RhS3MvTEJzdjZp?=
 =?utf-8?B?NEJjTU5CZ04wMnNxVHUxLzgvRzNkYTIyRUpFWUxJNWRaZzczZldhOGtSZXVy?=
 =?utf-8?B?YVFsTjh4Z2RSTWtMSnJ0eDRiYXVCemFtRXBONUNJSHBRUlRNV1JUR1d4SjQ4?=
 =?utf-8?B?UmdsWUI3aDNROUE0aXZ1TEVhQ0JMcDE5MklOVUg5Myt3QjhTZ0R3dEtvemNW?=
 =?utf-8?B?UG5LVmpFbjU3OTBGVmxJdGQ2bXF3eWpJZHIyK1NndTdGS2ZlaWg2YkVzRWFn?=
 =?utf-8?B?OHIyUEdjSGJKMmsvL09iUnU3bU5KejV2SVJGR2FKd1RWMnZvOHNEZmFvWUJK?=
 =?utf-8?B?Qm5JSHF6b3BVNjJhZW9LeThSanZqNzlJSDE5SGJlVC9jeEpaVEZRSmpobVM1?=
 =?utf-8?B?bW1vRXhqV3J4RG1kTm01cmJOamQvRXFSWWxvUmJMWTVsaWRXbi9zbnpteGdz?=
 =?utf-8?Q?FZq0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aedc729-487d-42d9-d564-08dd0a8c4d37
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 00:26:26.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVhyhf2Mui15erY88izC2IJk4NEoa+HyC7MUVNPGpr822rv1dFUGCQC3ya+DdsjK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712



On 11/21/2024 6:22 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 11/18/2024 11:18 AM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>> Assign/unassign counters on resctrl group creation/deletion. Two 
>>> counters
>>> are required per group, one for MBM total event and one for MBM local
>>> event.
>>>
>>> There are a limited number of counters available for assignment. If 
>>> these
>>> counters are exhausted, the kernel will display the error message: 
>>> "Out of
>>> MBM assignable counters". However, it is not necessary to fail the
>>> creation of a group due to assignment failures. Users have the 
>>> flexibility
>>> to modify the assignments at a later time.
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>> v9: Changed rdtgroup_assign_cntrs() and rdtgroup_unassign_cntrs() to 
>>> return void.
>>>      Updated couple of rdtgroup_unassign_cntrs() calls properly.
>>>      Updated function comments.
>>>
>>> v8: Renamed rdtgroup_assign_grp to rdtgroup_assign_cntrs.
>>>      Renamed rdtgroup_unassign_grp to rdtgroup_unassign_cntrs.
>>>      Fixed the problem with unassigning the child MON groups of 
>>> CTRL_MON group.
>>>
>>> v7: Reworded the commit message.
>>>      Removed the reference of ABMC with mbm_cntr_assign.
>>>      Renamed the function rdtgroup_assign_cntrs to rdtgroup_assign_grp.
>>>
>>> v6: Removed the redundant comments on all the calls of
>>>      rdtgroup_assign_cntrs. Updated the commit message.
>>>      Dropped printing error message on every call of 
>>> rdtgroup_assign_cntrs.
>>>
>>> v5: Removed the code to enable/disable ABMC during the mount.
>>>      That will be another patch.
>>>      Added arch callers to get the arch specific data.
>>>      Renamed fuctions to match the other abmc function.
>>>      Added code comments for assignment failures.
>>>
>>> v4: Few name changes based on the upstream discussion.
>>>      Commit message update.
>>>
>>> v3: This is a new patch. Patch addresses the upstream comment to enable
>>>      ABMC feature by default if the feature is available.
>>> ---
>>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 61 +++++++++++++++++++++++++-
>>>   1 file changed, 60 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c 
>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index b0cce3dfd062..a8d21b0b2054 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -2932,6 +2932,46 @@ static void schemata_list_destroy(void)
>>>       }
>>>   }
>>> +/*
>>> + * Called when a new group is created. If "mbm_cntr_assign" mode is 
>>> enabled,
>>> + * counters are automatically assigned. Each group can accommodate 
>>> two counters:
>>> + * one for the total event and one for the local event. Assignments 
>>> may fail
>>> + * due to the limited number of counters. However, it is not 
>>> necessary to fail
>>> + * the group creation and thus no failure is returned. Users have 
>>> the option
>>> + * to modify the counter assignments after the group has been created.
>>> + */
>>> +static void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
>>> +{
>>> +    struct rdt_resource *r = 
>>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>> +
>>> +    if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>>> +        return;
>>> +
>>> +    if (is_mbm_total_enabled())
>>> +        rdtgroup_assign_cntr_event(r, rdtgrp, NULL, 
>>> QOS_L3_MBM_TOTAL_EVENT_ID);
>>> +
>>> +    if (is_mbm_local_enabled())
>>> +        rdtgroup_assign_cntr_event(r, rdtgrp, NULL, 
>>> QOS_L3_MBM_LOCAL_EVENT_ID);
>>> +}
>>> +
>>> +/*
>>> + * Called when a group is deleted. Counters are unassigned if it was in
>>> + * assigned state.
>>> + */
>>> +static void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
>>> +{
>>> +    struct rdt_resource *r = 
>>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>> +
>>> +    if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>>> +        return;
>>> +
>>> +    if (is_mbm_total_enabled())
>>> +        rdtgroup_unassign_cntr_event(r, rdtgrp, NULL, 
>>> QOS_L3_MBM_TOTAL_EVENT_ID);
>>> +
>>> +    if (is_mbm_local_enabled())
>>> +        rdtgroup_unassign_cntr_event(r, rdtgrp, NULL, 
>>> QOS_L3_MBM_LOCAL_EVENT_ID);
>>> +}
>>> +
>>>   static int rdt_get_tree(struct fs_context *fc)
>>>   {
>>>       struct rdt_fs_context *ctx = rdt_fc2context(fc);
>>> @@ -2991,6 +3031,8 @@ static int rdt_get_tree(struct fs_context *fc)
>>>           if (ret < 0)
>>>               goto out_mongrp;
>>>           rdtgroup_default.mon.mon_data_kn = kn_mondata;
>>> +
>>> +        rdtgroup_assign_cntrs(&rdtgroup_default);
>>
>> I think counters should be assigned *before* the files exposing them
>> are added to resctrl.
> 
> Sure.
> 
>>
>>>       }
>>>       ret = rdt_pseudo_lock_init();
>>> @@ -3021,8 +3063,10 @@ static int rdt_get_tree(struct fs_context *fc)
>>>   out_psl:
>>>       rdt_pseudo_lock_release();
>>>   out_mondata:
>>> -    if (resctrl_arch_mon_capable())
>>> +    if (resctrl_arch_mon_capable()) {
>>> +        rdtgroup_unassign_cntrs(&rdtgroup_default);
>>>           kernfs_remove(kn_mondata);
>>
>> ... and here remove the files before taking away the data exposed by 
>> them.
> 
> Sure.
> 
>>
>>> +    }
>>>   out_mongrp:
>>>       if (resctrl_arch_mon_capable())
>>>           kernfs_remove(kn_mongrp);
>>> @@ -3201,6 +3245,7 @@ static void free_all_child_rdtgrp(struct 
>>> rdtgroup *rdtgrp)
>>>       head = &rdtgrp->mon.crdtgrp_list;
>>>       list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
>>> +        rdtgroup_unassign_cntrs(sentry);
>>>           free_rmid(sentry->closid, sentry->mon.rmid);
>>>           list_del(&sentry->mon.crdtgrp_list);
>>> @@ -3241,6 +3286,8 @@ static void rmdir_all_sub(void)
>>>           cpumask_or(&rdtgroup_default.cpu_mask,
>>>                  &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
>>> +        rdtgroup_unassign_cntrs(rdtgrp);
>>> +
>>>           free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>>           kernfs_remove(rdtgrp->kn);
>>> @@ -3272,6 +3319,7 @@ static void rdt_kill_sb(struct super_block *sb)
>>>       for_each_alloc_capable_rdt_resource(r)
>>>           reset_all_ctrls(r);
>>>       rmdir_all_sub();
>>> +    rdtgroup_unassign_cntrs(&rdtgroup_default);
>>>       rdt_pseudo_lock_release();
>>>       rdtgroup_default.mode = RDT_MODE_SHAREABLE;
>>>       schemata_list_destroy();
>>> @@ -3280,6 +3328,7 @@ static void rdt_kill_sb(struct super_block *sb)
>>>           resctrl_arch_disable_alloc();
>>>       if (resctrl_arch_mon_capable())
>>>           resctrl_arch_disable_mon();
>>> +
>>>       resctrl_mounted = false;
>>>       kernfs_kill_sb(sb);
>>>       mutex_unlock(&rdtgroup_mutex);
>>
>> Unnecessary hunk.
> 
> ok
> 
>>
>>> @@ -3871,6 +3920,8 @@ static int rdtgroup_mkdir_mon(struct 
>>> kernfs_node *parent_kn,
>>>           goto out_unlock;
>>>       }
>>> +    rdtgroup_assign_cntrs(rdtgrp);
>>> +
>>>       kernfs_activate(rdtgrp->kn);
>>>       /*
>>> @@ -3915,6 +3966,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct 
>>> kernfs_node *parent_kn,
>>>       if (ret)
>>>           goto out_closid_free;
>>> +    rdtgroup_assign_cntrs(rdtgrp);
>>> +
>>>       kernfs_activate(rdtgrp->kn);
>>>       ret = rdtgroup_init_alloc(rdtgrp);
>>
>> Please compare the above two hunks with earlier "x86/resctrl: 
>> Introduce cntr_id in mongroup for assignments".
>> Earlier patch initializes the counters within 
>> mkdir_rdt_prepare_rmid_alloc() while the above
>> hunk assigns the counters after mkdir_rdt_prepare_rmid_alloc() is 
>> called. Could this fragmentation be avoided
>> with init done once within mkdir_rdt_prepare_rmid_alloc()?
> 
> It seems more appropriate to call rdtgroup_cntr_id_init() inside 
> mkdir_rdt_prepare(). This will initialize the cntr_id to MON_CNTR_UNSET.
> 
> And then call rdtgroup_assign_cntrs() inside 
> mkdir_rdt_prepare_rmid_alloc().
> 
> what do you think?
> 
> 
>>
>>> @@ -3940,6 +3993,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct 
>>> kernfs_node *parent_kn,
>>>   out_del_list:
>>>       list_del(&rdtgrp->rdtgroup_list);
>>>   out_rmid_free:
>>> +    rdtgroup_unassign_cntrs(rdtgrp);
>>>       mkdir_rdt_prepare_rmid_free(rdtgrp);
>>>   out_closid_free:
>>>       closid_free(closid);
>>> @@ -4010,6 +4064,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup 
>>> *rdtgrp, cpumask_var_t tmpmask)
>>>       update_closid_rmid(tmpmask, NULL);
>>>       rdtgrp->flags = RDT_DELETED;
>>> +
>>> +    rdtgroup_unassign_cntrs(rdtgrp);
>>> +
>>>       free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>>       /*
>>> @@ -4056,6 +4113,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup 
>>> *rdtgrp, cpumask_var_t tmpmask)
>>>       cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
>>>       update_closid_rmid(tmpmask, NULL);
>>> +    rdtgroup_unassign_cntrs(rdtgrp);
>>> +
>>>       free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>>       closid_free(rdtgrp->closid);
>>
>> There is a potential problem here. rdtgroup_unassign_cntrs() attempts 
>> to remove counter from
>> all domains associated with the resource group. This may fail in any 
>> of the domains that results
>> in the counter not being marked as free in the global map and not 
>> reset the counter in the
>> resource group ... but the resource group is removed right after 
>> calling rdtgroup_unassign_cntrs().
>> In this scenario there is thus a counter that is considered to be in 
>> use but not assigned to any
>> resource group.
>>
>>>> From what I can tell there is a difference here between default 
>>>> resource group and the others:
>> on remount of resctrl the default resource group will maintain 
>> knowledge of the counter that could
>> not be unassigned. This means that unmount/remount of resctrl does not 
>> provide a real "clean slate"
>> when it comes to counter assignment. Is this intended?
>>
> 
> Yes. Agree. It is not intended.
> 
> How about adding bitmap_zero() inside rdt_get_tree() to address this 
> problem? Also need to reset the cntr_id in rdt_kill_sb().

I meant reset the cntr_id for the default group in rdt_kill_sb().
-- 
- Babu Moger

