Return-Path: <linux-kernel+bounces-359413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E894998B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31EC31C23FAA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9237E1CB301;
	Thu, 10 Oct 2024 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nunvLNIj"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466381C9ED0;
	Thu, 10 Oct 2024 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573156; cv=fail; b=CFpughNLDVjKrU+d9+yN457sQ85OscfUZzXHqBoZNwi5vrzjMlOnCVY2qT8OrAvdjDxVu+83wDB0qNNwzFrseJe9fUrbL6rtKK5XMDdgFv+dKLcL4os+v/sXwPYByspVjjLfXLY4R+TiqCMmLhQagz6Vq0dRZ3KB2Hr2Q1XRhP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573156; c=relaxed/simple;
	bh=c4+lFk9qHULXSE5EiPZ39WFJMnCRHDGP5TqKQcRk+dg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ERnSB6+I+iln6YBI67hahYv5Qu30bsHhvrpMw9hZnvs6Tdr9TLZp8UEw0+stKcu7817DgtAZCTwdubiSTxHsTE4rMp2XQn54RLBX+TSxlnN34eWjMYO3c/U5JXeKCifF8stjjvt4eq+bLV5DRolsTUOTTGhA3IzQXHQVH8y9oE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nunvLNIj; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAusFs0eOnedxsmRXyC7wjNYrtCU7pn+F3sbcKQ+2ghFM1xcU2LTzTKJ2Fm961D2tNzSqAo9zF6MVqMTnUFkcVmMo3oQfSwwMZMgDiQvUdEWCuC0XwQV1LMmAGlVYo42dG43ICk1h5ii7gKPMP2JZ4s9tg64NauQsVu3yYk1+qo9mbbmpZWPvWWT6KkNHMLUu6gzHbsIa/fv/6ae2xQ7huehR2dWoVmj2ZwbNOx9/Srld9sRqujwM/YG1yAe7GulYg8oG8Nwj4MTJMv8VE2Y1/j50xEdHfdsFW3Vnly6Lywl87mV16E6YuGMauAxSazaMUGyOTOTTCT92Sdjip3GFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwCC835bIj2a81DCnRrmD3CbOKRuBrh61y+Ltz+eYY0=;
 b=nHZiRYFc9eiS9cyS11Ykq3FPIgrQ0FEDXIn5/kZrduR72U6NbcpUR5BHERgQsa1u8OoxvxkqDq9yMTgziqnpQdNMe0cOjan/0O+56gpq8rC6iuOglAQVNklEw8NFpm5QooAPkA1C/5ze6bAAx0T6738bkPOLjIbQ1vCgR2WBour2ONGN4vIMAHcG2Alu46rQbFEOFV9T6FQX26B5pIDEXAbZurLN5EUecCdT/xp6bazOuD4uAO7xmiv+6HGAjrPbZ7iQhNtvzXCKyDWpp1oehMX54naXV4ajDi90Bd13pX5rie2VWyUFLjzRx+ec3WR4Cq2Qtpk8nHjnyIuOYaV+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwCC835bIj2a81DCnRrmD3CbOKRuBrh61y+Ltz+eYY0=;
 b=nunvLNIjaV4IK9ngspyjPp9Oihb5y6/6xMxUO41qjotedMEhhiouLe6GB85GbzcRP3IyjqiHmIN2bRAZE+raw3hV49DCU7mEpKFs07TYhwtbCwsgtQgr5ACyx8y8a1pX001E17AudBYwEebIBBUm3Vq5f8RkF77eBdfcAZLwwH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 15:12:32 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 15:12:31 +0000
Message-ID: <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
Date: Thu, 10 Oct 2024 10:12:27 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
To: Tony Luck <tony.luck@intel.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1728495588.git.babu.moger@amd.com>
 <c79fdf4196d974325df995eb334221463747689e.1728495588.git.babu.moger@amd.com>
 <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0155.namprd04.prod.outlook.com
 (2603:10b6:806:125::10) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e28951-917a-4a19-1684-08dce93df682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SW5KTk1xMi9zSkhoNGZVdThVV1h6M2FyMm9qUWFEOUxocCtsVnR4bk1vOWJE?=
 =?utf-8?B?MklwTi9mRmRYOEdrVmZVZVFZTTRoUmx1K2JmazJEaEdhTWdMVllDekJzU0F6?=
 =?utf-8?B?TTNJL2dqTnBxTjVzZkh0SWU5SHQrSWJnTmZwRFF2R3RKSi9QYVFKd09ObTV5?=
 =?utf-8?B?UXpGOTlYTTdWUnVDZnZwNnhPV0JLeXhCVEI0TzlZbzZuNkdWbE9oOGI3d1FX?=
 =?utf-8?B?aWp3d0lkRENKVjUzd0QvZFZUdis0VGpublp4dGZ0OE9DbU9NVW9Uc3VZNU5M?=
 =?utf-8?B?MU5QK2U5dnp5bUc4MkpIUnVGai93RFVvM1JFU0M2dHBiRDl6OFRYY21HUzNo?=
 =?utf-8?B?cTl5bkJLK3lncXk1elc2RXRPSWY5VHVlT2gzemFndWNYME8xblBHZm5ueWZk?=
 =?utf-8?B?dGdhSkl1TVEwWk5NbVFQTTRZTUVaUjgyTWlSbGpJTzBEYkt2SVJZQ0tVT2gv?=
 =?utf-8?B?ajVZYUVKYnR6bmVDS0lNVVQwalQ5aFk3bTFJNDkzM29LS0VoRXNrbTkyR1Nt?=
 =?utf-8?B?YXJsSzE0QUdCcVRmYkJPcm9jeUdBbE9xQ0hOclBiOUoyTk9tVGIxNzBSVFVC?=
 =?utf-8?B?eDVxelhURmlPTm01MTkxTGgwVWMyb1ZTY3k0YTJQRlRjRGY2RjR1b2liN0Jk?=
 =?utf-8?B?Z3FkaHR0Z3JJMVJqRFFFQ0xvUVNRVEFoQXhBRjRkSEZaTGljUzFFOEpieno5?=
 =?utf-8?B?bXJrZytVWFZpOXV2aUVsZVZaWWp1WUxHOWdrcDdEVnc0QnJjR1VmZHBQNnM1?=
 =?utf-8?B?NFRWcXE0RXhUZzlReUN2QUxwMDJjSkFWcE8rM0FtdWxTcEFnbm8yamRxU3hh?=
 =?utf-8?B?R3EyTEFFWDhOKzhqVk1lZnhCc3BESzhiUENHMi9TaGFtS0VzRWtVTmpDb0RU?=
 =?utf-8?B?RGp6cm1NeE8yYzVYdEZOUEZmTXNIUzBjSk50cDE4TmJlWENpQWJQN25QNFdC?=
 =?utf-8?B?Vjhxd3dtS1RwMlRhZXZ1aENMMTBCdnJrUzJTa09vbzEvTzNvelBMSUp0Y3pY?=
 =?utf-8?B?NmJBQWliSmFhaW1yQ3F6ZnEzYUZPUVJTMCtmV0pOQ2ptOHg5cWR0UnBWRkZ4?=
 =?utf-8?B?UGduVFNXelIzK1Nmd3hWSFRxUDU5V3R3eVpyU1Z5NlhHTUhoVGthdGtRaG8w?=
 =?utf-8?B?aVd4aG5KaVlDT1JpUklmVnozOVBkMVNOS2JraCswRlQyTGxEYS90cU1mQmVa?=
 =?utf-8?B?NTdYLzBXOEltR3FKVjVzMWxnL2djU0t6WXByYW9nS3RjVFo4T1lwb3d4cU5n?=
 =?utf-8?B?ZUxzZ2hnRTl2OThQcGcxOUpDMHdVMUFOU0dLSVFTc2syRXRtNWFyTU9pWlV5?=
 =?utf-8?B?MFlpN2JvSjFVaDlaSVAzUm9RQ201WndmaE5zKzBpbFlOaUcwQW1xZmk5NTBv?=
 =?utf-8?B?dEdKMDk2ZEU0TG1GakEyd2I0eXgyTFllN3NqL3d2R2lLdHJ1S0t1WG9MeEpo?=
 =?utf-8?B?d3huOWczVVRjN3RFcnJ0WmxDZkw4aExicVFGMGZSaWYzYUt2d0gyU29Sam83?=
 =?utf-8?B?V3BxOGpUZE5jTWV2YjVBWXdxSUdpL0U4RVJtVnUrOWNBMm0yZDF2blcwOW9Q?=
 =?utf-8?B?T0lnV0oxcUVUOXRhYytPMjBqVUI0VGlndmFYM3ZEL0pSQjBsUUw0MHR6T3R1?=
 =?utf-8?B?cHNra2xCUWF5M21jN2Z0UjNvZm9VekFGZGNWa2FiUHlDa1FmazNoc00xeGdV?=
 =?utf-8?B?am5ONGV3WTBVUVNMb1VscHpuV3l4NVFCOEtHMFNLL0dHeGI1c1AvS21nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXpFQm1HeVRtU2JvOU4vUzlEVzZOaEN0bWN0Y1FPN1EzRWhhWE1VemFKaUdF?=
 =?utf-8?B?OER2eHZQUFpXVzkrTnhLOE1SdXV1cm5MM1dRa1pLV1JjdHk0NWlaSndOWE1v?=
 =?utf-8?B?cEkwaDZDSVB2dzZYaEtwSEtmSlFxWU1jZGpiZHZRU2VHNGVSWU5rZzRwRXBu?=
 =?utf-8?B?UFFoTlNCMUppd2doN005ZEFQWW1jMy9XODU2NkVEV3VNSmVoa2lJNS80VENR?=
 =?utf-8?B?M0UvMit3b3IvcEZ4NEhUOGpCRDJvYlFOTkRDUXBabUdsY1VFcHRCQ3JmZzhL?=
 =?utf-8?B?Skxrc29xeUNiVFM3cGJtaGhodHdSdDhoYTJqUXJiZEV2Z3VaTGY0a3FoOCtz?=
 =?utf-8?B?RkJrQitIZjhVTzh0U2QwNmZ3VW5hQnhETEZhS3F1Sy9yRTlXOHl2aHRCSGx2?=
 =?utf-8?B?TldEb2QvdTRPYi9qZGh5VnowZFJXYStEQlhaMDhHa2drM3lpVWcwTjFIK3Vt?=
 =?utf-8?B?Um4vK1k1elB3MnBhMTBIK3NCTzBUWDgyaFJNdWw0ZDNiczlLMzV2eTNhVkUx?=
 =?utf-8?B?bGdPWVd2ZnZaSWJlejI4UEluZ1JFS1BWWmJqTUp4SElkdkZZaWdQazRFcVd0?=
 =?utf-8?B?b0ZNZE1sSW1GKzdEZjgzbFU2dDJZSEJCRTVNQ2JrZVViYmFidC9uY2NxU2dk?=
 =?utf-8?B?WEtBM0hLOEVSQkdseG8zOEM3WGh0UzFlNUVQZDdmSXdvK1Z5TWJ0Z3VTVTNv?=
 =?utf-8?B?cVE4R1hlY0k1WWNtVlBQakt6bU5zVTg0NXFmRzU0QVBZVStjVW5BdjNYVGVU?=
 =?utf-8?B?Z1FGL1pGMjVKdFh4SXVKRElRdG8xQWQvSWkrWmEycHFkK1NOb2JiS2lPUWdT?=
 =?utf-8?B?RWUrbFVVWGpudDlBVWFFSVdJa2UrZHR5YW41Zlc2VHFEamQraWIxRStMRGFW?=
 =?utf-8?B?MHg1d2o5WHBvNmRTRkdRemhjV01GWnVzRHBZWTIzNEp0Yk0rck95cTlCdkhQ?=
 =?utf-8?B?T2laV0YyTHVHd0xYenlaK2JRTlNHbVlWL3dmSXhGZ1hYc3ZrWXlvSitLcElE?=
 =?utf-8?B?elJjNDEyL3MvUmo3NDRJbXF1S3EvOFYwRzBOUSt3dU1LOExCRWlOVlU5ajdo?=
 =?utf-8?B?QzVBYVI4WXlUSS9KbEhOY2xiOVBFSXZweElnQ1drQXJqUG5kcmc2aDhYZ2JZ?=
 =?utf-8?B?YWUvNEVHNWpudTU3bktMU2RseUl1T21wRGZaYzZmTGRpeUd3eXdsRDlORndY?=
 =?utf-8?B?bDJTYzZscTNxL3I0alNDT21MOEZzTzc0bEExczVCU0VqbEw4SlREYitUTmlk?=
 =?utf-8?B?ZnBLVldRSG9aSlhpT2VNbHNSSGRlbGk1MXZHWGZKUFh2RWMvejZjREhiUkla?=
 =?utf-8?B?bWZJeDBtL2RKclNrWFFlUWV2eWloR3FXaGpNTEhtUVZxYUZoazZwVk51Vzls?=
 =?utf-8?B?OFNPS2dRS2tuS1RaclZhckxIWU5jMmxrRG1NN0p4eUs0U2F4cVF6RHJkL0Mr?=
 =?utf-8?B?Z00zYzBnTFNBRCt4VmprbjNHQnlUeXZhTUxEL2NQRm9ud01Yb0JtLzJNYVRB?=
 =?utf-8?B?NTZmUC9ZZFlKWjBUZGtUcWlJUDducklwWjh1Sk1lUlRzMXlJSGd0d0l4dW4z?=
 =?utf-8?B?c2VQajN2Y1RydTM1QUNQZ2ZKeDM5UStXZkNpOGRrUHZvNEJQZ3VOY3FsVDFV?=
 =?utf-8?B?K1hQRDhsYTRCZzM2ZWI2WVlIQ0c1QnpqeGI0eTh0UVpkNGYra2ZIQmU4ais2?=
 =?utf-8?B?V1FvZHREUEszSkZ2eWFlV2pxSFJTa2lSMjM2bit0Uk1qUExpOFczekZ5VmhY?=
 =?utf-8?B?TEZrSGo0T0ttTDRmQ21CbzR5bDNUTHZBRHdzYUhmbTVpNm1hM0pidC9tT1B3?=
 =?utf-8?B?WG9XbDZWcjY5SXRhNjdKV1FwMmxTSDlOL0lKVWpYTEw5NUZuNHA3VUxOc2Va?=
 =?utf-8?B?UEQzNG11MHJsdGNvV0REbVFUcW16Vko0ZFNtMEhIbUw3WnQ0VXcxK1lEbVZr?=
 =?utf-8?B?WFRHU0ZYbVFkQ21uVU1RY3Y1cVo0QjFqbnc2UlMvZGlJc0tVVmIrZExXR0Rl?=
 =?utf-8?B?U3FMbWR3TSsyNG5rVjlNNVh0UUtJWEFYWkFvTlZ1NW5Ld0wvcFh3bC9yaTlR?=
 =?utf-8?B?WENJZExpYmZEMkNnSXh0RDhBbDlXQlprRGRWTXpFRHhsaDNzblNDWDJvZkFh?=
 =?utf-8?Q?lCpg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e28951-917a-4a19-1684-08dce93df682
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 15:12:31.9108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glwBzuduiJvorqQEsH2MqolBQVB+E+ONVdX+/UBfbbiRCB1EdOdq2E0dqxeRDC3u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424

Hi Tony,

On 10/9/24 17:49, Tony Luck wrote:
> On Wed, Oct 09, 2024 at 12:39:33PM -0500, Babu Moger wrote:
>> +"num_mbm_cntrs":
>> +	The number of monitoring counters available for assignment when the
>> +	architecture supports mbm_cntr_assign mode.
> 
> It's not obvious (to me) how these counters work. When I create
> a group with both local and total monitoring enabled, does that
> use up two counters (even though I only used up one RMID)?

That is correct. One RMID can be associated with multiple h/w counters.

> 
> Are the counters multi-purpose. E.g. if I disable local counting
> on all groups, are the freed-up counters available for use to
> count total bandwidth on some additional groups?

Yes. That is correct.

With 32 counters you can enable both the events on up to 16 groups.

You can also enable only one event in up to 32 groups.

> 
>>From the examples it looks like if there are free counters
> available when user does mkdir, then they will be assigned
> to the new rdtgroup. If only one counter is free, does it
> get assigned to local or total?

Right now total event takes a priority.

All good points. How about this text:

"num_mbm_cntrs":
The number of monitoring counters available for assignment when the
architecture supports mbm_cntr_assign mode.

Resctrl subsystem provides the interface to count maximum of two memory
bandwidth events per group, from a combination of available total and
local events. Keeping the current interface, users can enable a maximum of
2 counters per group. User will also have the option to enable only one
counter to the group to maximize the number of groups monitored.


-- 
Thanks
Babu Moger

