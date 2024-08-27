Return-Path: <linux-kernel+bounces-304085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 181049619F1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 00:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 683C7B22E12
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 22:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD22C1BF7E7;
	Tue, 27 Aug 2024 22:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IRqp752F"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FEE1465AC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 22:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724796969; cv=fail; b=nwxIWp6OzS5yuyVFOlUKu0qdNwpl1PcQ6nfxLprYUzuzUEXNTw28wV2HJ3cvHestwT0LTmzxVutHkclB49PyCNzpPPmcvJf9IYbpgvDrZUkS/0ZnTJxKL9MeP0edR/XFngqw3kPb35LOXjixob3Ysjortju/cMqpCGhxETPnbZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724796969; c=relaxed/simple;
	bh=DW8IHnzhbLS3FZMP20bzsV8Teef7avEHJ/qd7gihh7c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mULvmrSN14be6Dlqtw8fULeWdXiTAAyxVIAZcgu6iDB2JYfe9/MNVMRHwhJFNIsQl/yoMDEI/R4DA0CSdrSJh8CSUqYbetHwXfgbCmBt6fWR0cHHw+zmY6YUfQVhpKRS/HTORqSSMhJP0qkIPAtKb9X9XIUSlujchj3F7MVCVQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IRqp752F; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcmvdYXzoWyFqs68YaBQ0vku/jtg24yLeCOk4aBqnVMyGoYk6oB1urNFCPXhV4GenwBZCvgpDYAzRsA2PnllAfO9qBqiDMB7gSedhqufePoqB54RAsPjLX/rrh9XpEuROhBSlLbdSRURTvliddJvxHyKE9AFt9YrVORJoZHL9gzA+Meqdv5Sde+ln2l02Z+c6xSHjrpc6If3Ts2eEgfWjPXlLDQEdl68lfAGGpSBb0vM9J+SdNUxgea91aekFIXn1BXCrgQ+WHGgnQ+2CxD4zbKHHk7BQQQfYmgcvMZ57sEQ9TwuxQODbAmrnEmA99o/ZawBxR2rGR7ECxHLGPwzfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MT2knByDaQLLRyho5lVXaSjxxPjgTfO7MW2iP+yhysc=;
 b=bh9/ncE2S6WWc+QQjGghKsvBSYHkc7sCXYTtfp5xBZhEQWysSOs5DGx0iU0gPFNxZPbF9EzWh8rKlFHw9Tu0FLDALNhKKBsUnUKppQ9XperXrVmAkWbCl1nHsVRZDSeb4xAkHnztgtXD+iJ1dGDr7WUt0BjJAz/rO0NZ7M0q4QUobiYZH8//fqsA5IcWYLnKIBMBLirEiHapRrBl7pw3RayxpTZGb1NS9jJr4R8aedEEww6+0kYiNEkcaj2ZBUCEWzWmWFOYURxYaTZt6DnH12mhjlDUFir6gtSFI5idPd9Sun1sryEWg+bJwzR6VTbw6b9zssSlap4EeHdAcUSeaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MT2knByDaQLLRyho5lVXaSjxxPjgTfO7MW2iP+yhysc=;
 b=IRqp752F4u7V5DsgeUTJUE103BH1CzsL818mx2V/hyB9KmIO0lFRN9cmMqLkPkHZ3yQu7A5YuAz/xAP/bXbiBA423Gq1Y53ht5X+dNH+J2U0hmfsO1pkmQe/TAj2JohMQ5jYAUoqN8tNTSJkJR7VjKKN/UqA910IjiAul+Ah4ZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by IA1PR12MB7615.namprd12.prod.outlook.com (2603:10b6:208:428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 22:16:01 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%6]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 22:16:01 +0000
Message-ID: <02949473-328f-4dae-b778-d939dc9bba6c@amd.com>
Date: Tue, 27 Aug 2024 17:15:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tdx: Fix crash on kexec with CONFIG_EISA
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Kevin Loughlin <kevinloughlin@google.com>, linux-kernel@vger.kernel.org,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>
References: <20240822095122.736522-1-kirill.shutemov@linux.intel.com>
 <alpine.DEB.2.21.2408240952080.30766@angie.orcam.me.uk>
 <g3tswlyhrnuzfqf2upq6h23manyrzhnxttnay66nycy2moi4es@5n4oblzpzcjc>
 <c2ef105b-c42c-e0f4-6bf3-761dafc8e92e@amd.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <c2ef105b-c42c-e0f4-6bf3-761dafc8e92e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:a03:117::25) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|IA1PR12MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b4d6dd-5796-4d8e-9c6d-08dcc6e5d54d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFJQUld6alBydE5SSG43ZHFFczB5Qk1lc1djUWxrc1dxbmx2djhwUUx1RHdV?=
 =?utf-8?B?Y1JlVXNVWHRmVlBtdkQxUFFFT3ZQUThlV2FHcGFCOWI4UDM0cm12UnkvdjRV?=
 =?utf-8?B?S1UvYm5uSnN1SlZDODZKaE16Q3owaDdxaWlBMmNERVhLZnlCKzl1RzBWcUM5?=
 =?utf-8?B?UWw5dVk0TldBSUdHaXVUSVVLVllBQzViOTgxc3pZelN4RlNkREJOaVN3SlN2?=
 =?utf-8?B?ckRtRkk4WThONHBKUzR5aU9seDFQQXNmRVh5bk5CQVplRk9wSmJWeURWTnFB?=
 =?utf-8?B?dm9YM29GcENFNWtXNXFPNHR2RXQ2WFVJMm9NdVpqeDkyL2FpQ21TZk5KK2o2?=
 =?utf-8?B?WWtML3ZHa0VMUGxZanZ2Qi8wdWUzUTBKaDBLK1VKKzNlUXlGQzd0eUd0MU5x?=
 =?utf-8?B?STZWaVhEZGFoRXNTUVVCcmwyek4zelB5WkZYa3d5T2JDYkljUVBGUlMxRGxp?=
 =?utf-8?B?cFRiRlBtdTRVR1NWeGtiY09ManVWTHNnMllHUEhkYzJOY3ZJZEthZThyQXdi?=
 =?utf-8?B?UWl2dldGRUdhS0lVcU15VzZmWFFJQWFHWDVWZ1dFNjliOFhTck9USUpjUW9I?=
 =?utf-8?B?N2syeXdCK0lTSmVLY2M1SGNIYUtxMWNoZFdIZkNweDladUhVbENwejhnQjNZ?=
 =?utf-8?B?VHFEZ0oyK2UzdGVoNHdpQ29XNG9ORURlb3lJZy9xd2w1MWdpcVpnYjFzWTI2?=
 =?utf-8?B?N3Q2Uk11N3Nqa0p3OWRlU0Y5N09MWUM3c3BVMHRhUTVydEx5ZEFYYkVVMERX?=
 =?utf-8?B?WUNhTzd2eFdJTkhSUXBsd0g0aUZxbmtDV3A3cW52V0ZTTHgxeVZ1ZVFHeDRP?=
 =?utf-8?B?WjdwR0ZsN05mZ1g2VHFkdS8veUVTRDlTOHVhelFveVErY2ZSMmRhaDczQkc2?=
 =?utf-8?B?WnhsK1p4YmdUUjVXU0RGMXFBVEVmYWdYODVhTUNuRk9oRVVtMlNwV3JJcm9F?=
 =?utf-8?B?UFpZanhTV3Q4UE5SSjBzVUE4bHpqTDFNVlRLRVFGdnZyMDEvZnI3K05kZTMr?=
 =?utf-8?B?WHoyVTdtNU5pemUwU2lZejdPbjRXQWtZV2dDTjhJOFNEcUlCY25mM1Y5OUhk?=
 =?utf-8?B?OU5aTkVrcTJBbHB4MDNlSU5aZ0NvTXVwSVkzT1d6dlFaY0luQ2piNG1FYmEz?=
 =?utf-8?B?R1psOFhOd3pKcUFLVWlaa1UyWlhkR3FzLzBObHlPeHRNNElTZE9oMUpRZlN2?=
 =?utf-8?B?SWZEcVpSV0h2ZWxMcHltQzFseGptNVdFV1d0aEl2QnhWVzl3TUk0QTk1QVJu?=
 =?utf-8?B?ZWxyN213bGpabXVMWHpFSXJaTWZ4TlJWOU85TEtSZXo0czdiczJqSFRzUmVa?=
 =?utf-8?B?NHEzVWFOc2tsV2VBZmttSG9YOGNUZkdLODRjNVkvNjJGTFZMWEVMdFlPaTRs?=
 =?utf-8?B?SkJ5bUZFN2l2LzlRVXlrTHFHdVRHaTFEbHc0M3ZXd21VcVpHY1VtQXhSTWFQ?=
 =?utf-8?B?Vi9US2s0WHlGdVk2NjV6NUxSak4xVU1SelNlcnRtRUozdzBvTm03RzNMbEpX?=
 =?utf-8?B?aEViQjIxUFVxZDZLUFYvYjFZSUVEZm9JOFZJMzNvR0Eyc3I5eldkbHVVclJ2?=
 =?utf-8?B?d1ZDaExrUUg1N2NWVklLTHlaa2VuOEFXZ3E5TGJwUnAxR3lnaHorSGZQWlVC?=
 =?utf-8?B?L2JlMDh0VURDRkliMEpnczJxYnBZYVl1ME9IQyt1S3c2VmZjQ2tHZXQwYWFv?=
 =?utf-8?B?SmNDVHlva2VadXhIMEFRVytxWkJYS2xUV2s4V0FIY0c4dGR1MGpRY3RyRHVo?=
 =?utf-8?Q?lydpPa2W5RiBlp1wL0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjZKSGxseVhxOFFaSDIzMjMzWlNVbmE3Yzg5ZVUvSVdmb2hMVlBuRE5kNHdM?=
 =?utf-8?B?TndLelIxaTJHREYrMzRSUDVqVHFwa2NoMm4wVGJ3dzFlVkRXRVF3RVFGZ3lr?=
 =?utf-8?B?ZktwRUwyN0xzSndhcnlPeXA2aGxFeXIvc1J3S21xTXFNY2E4bW5nR1RKdzZy?=
 =?utf-8?B?M2lJZy8vV0xhWm9YeC95Q1h0MWEyMmtIMkdYMjlkRzlUOUxqL0FVSkw1SFZi?=
 =?utf-8?B?SUdTWitVVHJBZjBKSURpNWZGQnpFdW1nc1Uzendvc1JKbytmVTRhL0w4a20z?=
 =?utf-8?B?eUpDU3RuYlNsTi9RZXVPYmVrSzNJc214Wnljb29BQ25md09xazBHV0hVYW9O?=
 =?utf-8?B?NzNNSEtaRGxtcUVUYkppeTVmMkFMUkQ5WUF6SjU1aGw5ei81dTVsZTVEbDBB?=
 =?utf-8?B?clpEOHMyQ0l4WUNGUVRBZlYwbnJLWlI4WTlMMjUxYUFoeE9yQm9UQzRUdks1?=
 =?utf-8?B?M1RZMDhOQTN1Y2R1NjBTUWlhZGI3SG1XZnFaNzRiOE9CSU02eW1zMGxHa3hX?=
 =?utf-8?B?ODUzcHRvRlZ3ekxqSkNqb2M5RjRjZGRrSG1YblAwRUNZNjgxbS95dkJZTGYw?=
 =?utf-8?B?NTh2dXRqZXQ5OHhuZ0ZuMEpXSVRYOXpSTHNYU0JvRmFqd3kwSmZBUVJQMWZW?=
 =?utf-8?B?Tk54V1dEV3o2SmNydEpRQ25QVi9jSlNab3NwMXdZWmpDbkdXTHJIdEIwUTRw?=
 =?utf-8?B?MUpZeVJqMXVGWWRFUVNIMksraDJCVkRWelQzZFdpOGlRS3p0YUdFb1FneXNN?=
 =?utf-8?B?MHNsSXROWUcyQWZmK0ZSV2htU3JKTk9aVzA4SXlTZGxtSDdKWkNpVkpWeC80?=
 =?utf-8?B?SThmclhvWDVwV0psUnhPSU5xR2NhaW81Rkk3QjlTTlV2N3ViMEluNmxUcEdG?=
 =?utf-8?B?M3hQYjkyd1g1b0c2aDZiUmprQk1FbE1hMXNKRitvNmFLL1RXeGUrczM5Sm12?=
 =?utf-8?B?UkdISjc5bUxEamRWTkY5OEhiaXVtc0RzNHpSbEhSZmsyY1BGdjFSLzFDbzZQ?=
 =?utf-8?B?Z01PZS9yWS9ERk8zU1Vsb0VjckxvdWh6bGIybHRsUXJYL2xmdnBGbDhDaG5h?=
 =?utf-8?B?MGhML1ZxNEpCOXcrVGVQWXFTTkN1WWtkRG90Q1pUS1V1elZFc084V1VxRUda?=
 =?utf-8?B?cG5BSnhVRFFhSlZHTjh3N1d2SElJekxBY1duYTAzZWRXdlZyNVRJRWJpR3dJ?=
 =?utf-8?B?a09UdGhXTzRJUE1MQjdlQVNUMzduNlEyMk1md0VDTlJZSlFjMDM1VWRxaXho?=
 =?utf-8?B?THo5Rm1tRW9GUHQ4M2djWWZ4QUE1Sy84K1YzaG1Ya1RMcmV1UGJCSzdlUWlU?=
 =?utf-8?B?SU03cHBaVGRCZUNsdXd5eU1udFp6K0tHbS9GeFU5WjNaMk1zQVYrN1VJZ0cz?=
 =?utf-8?B?MURrTjhTb3BJL1IvUk1hZUYyVnRIQzNOc1FydUs3VjNqd2IwRkMzOEJzTEdQ?=
 =?utf-8?B?YXRkWlBCeTdLMXpuZ1doUGJqbjBPL3VyY0VETlkvTzNFVG1hT0poVEtvOGVq?=
 =?utf-8?B?QmlveUZYSlQrYVE4VTdFdEpKUG5IRE9JdGNzZ0lHeFJzWko0eGN2UHRvQmo2?=
 =?utf-8?B?eHZTWkZnY3hvUEtHQjF0UFUrdGNvSWZpd1JBamdBZG5zWFhIcGpaVWFWOEs3?=
 =?utf-8?B?bkVJMCtvR242bEhPSWpIYlg0akxsS3FEMDY3aTFjSkZHeWN5N0tpQmloa1Na?=
 =?utf-8?B?eXphRnlDbWIrOFJ0ZmdIY3IwanIzQ2lOMGpGZmhBRVlPZGxMcU9VK0dIMVFR?=
 =?utf-8?B?cERublIvRllzMy94djVPeWhHSXBVL2ZGVWRvL3E4dUJIY2pnWTl4NHcwb1Fx?=
 =?utf-8?B?NDFDa2xMRE1WTHVzbENFUExtalVocW5EMXhUVUw5SjFxS0dkdkpYOGVTVzky?=
 =?utf-8?B?eEdFNlJJdGlKL2pSaUszUmp2YllEVFBJbjVNZE53OFFOQ1VYb3Uxb1ZIbjYr?=
 =?utf-8?B?QW9JK05aZGJRMnVRWmtocVBIRWhwbkc0YXlocVg5L0tzM0trNlhCOXFsMEpZ?=
 =?utf-8?B?eCsralI1OWxDRG5URUJZMDN3ZGlsSkFCRElEWEJ3YlgraG1OcWZ4R213SDRZ?=
 =?utf-8?B?Nmlmb3ZNeEZOZTdKb3pCc25pNXNPaS9iS2RhZWlUOHRpMktzVkJoNnVubzRz?=
 =?utf-8?Q?Pz/IsymECKNGXKATdEpthPVfr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b4d6dd-5796-4d8e-9c6d-08dcc6e5d54d
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 22:16:01.0392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAUBQUw6WqTb9MevC3IzmL/mASD9TWzD165Jin37nkhszDvZ3oR+VNPVHsbI+SW64p/It+CuUQiMSHGFm90QbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7615

Hello Kirill,

On 8/26/2024 10:52 AM, Tom Lendacky wrote:
> On 8/26/24 07:25, Kirill A. Shutemov wrote:
>> On Sat, Aug 24, 2024 at 11:29:39PM +0100, Maciej W. Rozycki wrote:
>>> On Thu, 22 Aug 2024, Kirill A. Shutemov wrote:
>>>
>>>> This issue causes real problems:
>>>>
>>>> 1. If the kernel is compiled with EISA support, it will attempt to probe
>>>>    EISA by reading 4 bytes from the 0x0FFFD9 address (see eisa_bus_probe()).
>>>>    The kernel treats this read as MMIO and accesses this memory via
>>>>    shared mapping as we do for MMIO.
>>>>
>>>>    KVM converts memory to shared upon such access.
>>>>
>>>> 2. The same memory range (0xF0000-0x100000) is scanned to look for the MP
>>>>    table (see mpparse_find_mptable()). However, this is not MMIO and it
>>>>    is accessed via private mapping.
>>>>
>>>>    This will cause a crash if the memory is not private.
>>>>
>>>> During normal boot, the kernel scans for SMP information before probing
>>>> for EISA, and it boots fine. However, the memory becomes shared and causes
>>>> issues on kexec when the second kernel attempts to scan for SMP information.
>>>  ISTM that `eisa_bus_probe' has to be updated to `memremap' analogously to 
>>> `mpparse_find_mptable', complementing changes such as commit f7750a795687 
>>> ("x86, mpparse, x86/acpi, x86/PCI, x86/dmi, SFI: Use memremap() for RAM 
>>> mappings") or commit 5997efb96756 ("x86/boot: Use memremap() to map the 
>>> MPF and MPC data").  Both just access BIOS memory.
>>>
>>>  Can you please try and verify if my proposed change at: 
>>> <https://lore.kernel.org/r/alpine.DEB.2.21.2408242025210.30766@angie.orcam.me.uk> 
>>> has fixed the problem for you?
>> I like the direction your patch took. I hate sprinkling
>> X86_FEATURE_TDX_GUEST checks over the kernel.
>>
>> Unfortunately, it is not enough to fix the issue. memremap() in this case
>> will still boil down to ioremap() that would set shared bit:
>>
>> memremap()
>>   arch_memremap_wb()
>>     ioremap_cache()
>>       __ioremap_caller(.encrytped = false)
>>
>> I think arch_memremap_wb() should be mapped ioremap_encrypted() in x86
>> case. See the patch below.
>>
>> It seems to be working fine on TDX, but I am not sure about SEV.
>>
>> Tom, any comments?
> I haven't dug through the code that thoroughly, but I don't think making
> arch_memremap_wb() be ioremap_encrypted() will work for SME, where some
> data, e.g. setup data, is unencrypted and needs to be mapped shared.
>
> Let me add @Ashish to the thread and have him investigate this since he
> has been working on the kexec support under SNP. Can someone provide the
> specific kernel options that need to be in place?

As Tom asked for, please provide the specific kernel options to test with this configuration.

Thanks, Ashish

>
> Thanks,
> Tom
>
>> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
>> index 1d60427379c9..ef79cbef1ef8 100644
>> --- a/arch/x86/include/asm/io.h
>> +++ b/arch/x86/include/asm/io.h
>> @@ -180,6 +180,8 @@ extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size, un
>>  extern void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size);
>>  #define ioremap_encrypted ioremap_encrypted
>>  
>> +#define arch_memremap_wb ioremap_encrypted
>> +
>>  /**
>>   * ioremap     -   map bus memory into CPU space
>>   * @offset:    bus address of the memory

