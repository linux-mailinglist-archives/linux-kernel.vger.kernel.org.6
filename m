Return-Path: <linux-kernel+bounces-549949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00690A558E5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF4D188A200
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C2A208981;
	Thu,  6 Mar 2025 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X9ljrWB+"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06B3151990
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297015; cv=fail; b=m9j6o83z8RmxOYfo3Uhf3TK31gpK/DWe9x/K22M3wF0Xt5m+Bzh0YFpvggaxuz+ID9iTxfNBYdz3V35Y4tUCLtsYKEUCeireyDvIF5mNYJGnCJAyP/TQH7bvFNvfeyJN5NOKBQWMOqXYOMVbUhg7BNFbvlvjJ711hcRMJxZ+WTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297015; c=relaxed/simple;
	bh=C72r/Az2qrDAK2tRfyFMi0eHDRwv6/WUm83PTyCDXmM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yd9tcSmbFOmb38EzNWOwslfblzOGa7wdFBZdeJPvjNy7b8LRnJiMPyqpnA2xvR5qeO+XmxlwEV/NOCrUf/Trxd6emku89ac3/2aq7sCpU1MfW2gD5qwFa1dm1YLoHsVd8H4xjFsHYf7EBUoaKKEXaTstLXE/PYIznMThhVtr/FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X9ljrWB+; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qe1HthA+ju6itjMst+LOsjdbPB1zoORzZyuvw74cBRPNtYvvnjUp/xzkU0/dyxdcglaKFY2IRNl+cAgWx+q9FhELntREfBzSCxREhxAvXTmIYoYpY3dQuzVOpO3IY/Cx0gRUiABU+p+1oEnl5Hj/GplJduBy0CDC3ETT13mrjCrne47vi9Vdq42mPqCQs+rr+h/OExWQbu8rdKbWc+AgzO+TpTZXkreT3YT1zH0FGTmJ87NJzEeO3/ycJnaBl4XNaWxurkNiCEPLRJ3mOHR1EZ+5czDKSOe87im6oJ9z2kuRnxUtPegYMYl3y6mpWwWwQJ9WoB/8U1ACGtk3FKTsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C72r/Az2qrDAK2tRfyFMi0eHDRwv6/WUm83PTyCDXmM=;
 b=bTpy8l7nIcU8gaHx0lnjRVwcbToPXILncWTuKPT4JK4Z9i/MheI2CqKdUl2yBL5cRYO6rH2MAW39GIlS3OhGfRBFyDpvKeOSgdN2WxKRp1QTGDlLActF2ESZFn1alyErn+V/tyXawL3DofPupuKda+fzwltAoiGA64VJcpM7va754fdxZ8WL3jZx4OScIKmez3vNIDZbWZiFC//oAMsrnW70tZYRiV33k++4TbGOjG231cUranguTnx6bCG1cNHmziafzEWA0CV4k5dd+hSOLK928nfMmIBJxYzo1OFcFPv9BP2ISfuP+sczfe3jYCbbdEU4bwy3ViYPiwVDi0jnwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C72r/Az2qrDAK2tRfyFMi0eHDRwv6/WUm83PTyCDXmM=;
 b=X9ljrWB+TUBYCzNJC6dW407ZTeXO/bIg5l40/yvuqdwvXi1/6m43jcLMVb9/fcLDuQNeUEKK+k8ET4C4KyiewSSpe/5wRnCXgjQGr0KyFgVYyGaKhyWmDrtqqMHyOiBHMeJG5hLILYHorPR2uPmd1gImZBQV3kWt7ucKyfC2+zcn5E4WQ17KUEzq1ODXK5YdUHmnyUrNqPKPfxEWhw9LayWOcbOgf2knz98+JY7bk+5tODgUMsCbqaG+6LNG7OpJdMTrUuWDFU1dc9+H2hxCMe3RJs1iUwIByJdCh0u/zk1sa7SYs1VR2myHACpX6ye+YPcKYckzlRNUYelWVdGqdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:36:49 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:36:49 +0000
Message-ID: <79191107-8361-4b29-bf42-584773847bd4@nvidia.com>
Date: Thu, 6 Mar 2025 13:36:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 26/49] x86/resctrl: Make resctrl_arch_pseudo_lock_fn()
 take a plr
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-27-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-27-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::10) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: e77824e8-79b9-4901-3dd3-08dd5cf70083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGNTQzN2UUlGcFNqNFN4SFZJSmlPVlEwWjRoN3dCbzhOSk1obUFlZ3piN2hJ?=
 =?utf-8?B?ZmVFRUVYRVRUU2Nhc0dXNnExWStWSWh3NWFUQVFlR054RE5nUG8zVlkvM256?=
 =?utf-8?B?YnlLNU1GcmVGaW84Ui9ET0p4L25RT2VjMm5IV1h6STFqN0p3TmVVZWZMVGxG?=
 =?utf-8?B?ejQ0QUt0dW05T3NlWllSTytDZ3JXdmJKUCtIaVQ4YnRWcGpvbFhPOW5JbnpI?=
 =?utf-8?B?MzBOem80S3VpZ2JRK0ZMVmllVlZJcnB0b1BOTXF5Vk5rRW1nbSsreUVTakJ1?=
 =?utf-8?B?NzNEeGZnSHQyeEhBNERwWVNrV09OdUNkcUhrQlZDT3dLVDFNTzQ2b2kzNzJ0?=
 =?utf-8?B?ZHJXZ3czc3JmNzByaXdGUEFucG5kUkUwRk1tRzdVRGhSNHJnYnRqTEpqdzVG?=
 =?utf-8?B?ZEQwUE1EUlJYcmlrdDMrQ3RUWnJNTXVuQUxLTnRqaEVVUGQxbUthcmVFYlBo?=
 =?utf-8?B?bnZQaEJ4V3hOSDR1VDNMZ0xnUDljTVBPZ2tGeEhPdXdZUFk2eXhmQm0zb2pT?=
 =?utf-8?B?dWpHbjYyYVFPcmM5SXNmbU1LQitHZVM1Q0hZeWcrRlpGMjUrWWpmMDRrRzND?=
 =?utf-8?B?SFlVQUhTYVdDVEhoZEx5WHFNK1hIVFg0c1grY1N2UlJXL3VZM0ViZVNUN0NM?=
 =?utf-8?B?Rkd3L3cveXE3cFh4YUo5MlltNmtDamtCaUtxeXJsWXlac2U4YURTeGFMMk9i?=
 =?utf-8?B?U25RWWJRQjZJemRrQ0hvYXNLNUNJV29LZTNqczkxU2IwU0VkL0l2MitPNm5O?=
 =?utf-8?B?NmRkZzdvQUJLRHJXcVJzTGNmOHdzT2VpMWNRYm1NYzRLNmJ1TGJJUWJRL05D?=
 =?utf-8?B?bEl5MzRWWWZGcCs3NUNDZEZFNStIZTY3c1lhdjJya2RLZEZwak1qRHMyUHFZ?=
 =?utf-8?B?c3daT1NXSzJiWnhLMUlPaHpoMFllM1ZhSENNUS9EbzgzVnErM1B2ajdhZ3VW?=
 =?utf-8?B?cjZEZDJ3YVhTaEUzQ0d4OFRWSHY5eWFydVJ2RlRkTTllczhidWpDTG9SaStO?=
 =?utf-8?B?MXdlN1ZnNys1RmdiRzdiMUtaSUQzMEhBNy9HdWJmMGFXK3lOcDZkMy9QcTNM?=
 =?utf-8?B?bnBOakVGWmhKSDZMM0w4SE1FR2hFUlJlMXlpMGJIY2thT05CTVYzak95ZjVI?=
 =?utf-8?B?TVQ4WjNGdzM4c2pES3Uxa3haWGVCb08wSkVybVNHd0hnNFc2QjB5WGIzaVg3?=
 =?utf-8?B?Qkh6V3lkM3JROC9nQ0NCaWFYNENKdmtoaWVLSHJzbHVoaE13UGdMWnFhODI4?=
 =?utf-8?B?bDBhWHYyZ2NwQTdoeUVZdTg0RlVQSjl5bm5LRzVnTFhZejN5alJrblNIbjN5?=
 =?utf-8?B?dU9QQmRHY3U4b21EWmpEZ2lBdndFL2tBNWVRZkpxZmhyQjFpTFkxSkZSQk5M?=
 =?utf-8?B?MzNTdWp6dnp6aHQzWVM1cndDVGVmdXRRZEZqUlY0QmU4ZnpVaEpBR091TjA3?=
 =?utf-8?B?S0Z1OHU0RjZpRWpESXNRWU9MNFFrYkp5eHYxVThnWnROM1RnMXEvYnkvNUdo?=
 =?utf-8?B?Y1g0QTZLaWZ6TUNLTHc4cDl1b1hkeGw0ejlwYmRBRWVrUWsxeWg1Nlc5M3Jw?=
 =?utf-8?B?Q1JXbWltdUVZV2hPTXhzZG1QL0xQamJFaDlCaS9VOEFtMUtPeXZZQ1FVcllr?=
 =?utf-8?B?ZzJXZFlKUTVicm9FTWlBR1ZwK0djSXNRUzFKSlRyZWduNGp0M0FsdmVrV1NS?=
 =?utf-8?B?V1NjYjdLZDNZYlhRWmNWdFJoY2NCTmxaYmcxdXRqS2VKOThZZWJBOTlmTitW?=
 =?utf-8?B?Qk5NeHVNMHNTL2s4cUE0d3NrbEN5eVhQdXJCREhHUzJwdVpFcDJUY1Z0d29s?=
 =?utf-8?B?MW4rcG83NFhlMDJTamsrRlI5V28rTE5pcjd1VFZWYXJwOC9hYmNKTExtTjdv?=
 =?utf-8?Q?kneujf3ge6HJd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1VLck1HS1FqOHZKV1l6ajZJMkF5U0dtV2JmNk5EUFBjNnUwVUVUcm1kUEd3?=
 =?utf-8?B?OGNNOVFZczI2STlGQUdSNVpzTUs0RFVyOGorYzBLWXlwR25CTTVGOXl6V291?=
 =?utf-8?B?QWlUWGVIMUJTOUFZaDUrRUI3VWYrdlBDQW8zTFBUWTY1UzAya1NsN2JwV0VB?=
 =?utf-8?B?VmZZeWg1NzhpdXZrdVJuNG1TRC9pOHh4UEVXNWMxUEdydW04ckY5QnlXZmQ5?=
 =?utf-8?B?R21YZGNlNlU5Z2R0K3ZJNmt1NmlpK1N1YUtPNHMwQ2hGcEMwTkUxN2I1L09l?=
 =?utf-8?B?UitQakRJRjhHUnprOUdZZTY3WmZpNmkrMURtZ1RLVUk4WWFmWUNRZEFJSXJV?=
 =?utf-8?B?R3gxcUlWY3ZrMnJmK2ljaHNWVlRhZzQ1Z1M4NVZtTzBNTUp1Si9XNzYxc1B0?=
 =?utf-8?B?bXVjZGk2d0JWb1M1akxCRWFseHhTdHRxT1B4MUkzdGtVUmM2dm5LTG9rdUg4?=
 =?utf-8?B?cnpJTnVXZzVjTHBRSUdQdEI2YmxoYTRGQWs5QzNsNXFxNktrRUt0Q3M3NjJJ?=
 =?utf-8?B?K2J3Y1Z2aUJ1WDc1SlRXVytJZC9HWlJXME5EWmFielBscndmbmRoS0dVYVhW?=
 =?utf-8?B?THJ2RmltRGR4UWpsMEdESlBheVZ2dWxzS3dtM2xPSkx1djIwdU9MUVlrVXBT?=
 =?utf-8?B?VmZYNWxoSXFyeElqVlZ4c2dYeUUxQ3RBeis1czhwQ3ZyWWJ0MTBCWTNvYWYw?=
 =?utf-8?B?bHJpRkdjdG9neVY1UG1HRVExZHIyZzRTQkQ3Ri9DaXFCZjBwcHBvdDY4aGhy?=
 =?utf-8?B?NWpVRk5rOXF4QVZnUmtPd2kzWVRnNExGVmNPNTJHZlZlKzF3bjFWenBzaEtt?=
 =?utf-8?B?TzZqMTQ5cWozOHlyVlI2b2R0d1gyNTlid29uOHd5Ujk2V2dkNnBBcUZRelZr?=
 =?utf-8?B?NkR4Ty93SWNJRkI5TmxCa0psbFl2WkZDLzNoV1dLTkRLOExzNlpPMHFUUkNi?=
 =?utf-8?B?WVZpdVRwNm91TVZZVitEOTc0Yktqb1BldHZuTGt3NXdTMWRDcG5mamdsNXVU?=
 =?utf-8?B?NEg2Y2dZczBLN2NGVmRZaHZOR0E4YkdzN3NmTmduTTY3UTVwVHp2WVZvVHRH?=
 =?utf-8?B?RytRdlpCMytxOS9iaXFlM2JGM3dHUlVxV1VLL1NwYmtOaGozcHlkZER1KzVm?=
 =?utf-8?B?OFFULzdJNktoOFdQN3EvWDRpUDU1dDJxQURwRE0yQ21PdERXQ29FVEg3UzNZ?=
 =?utf-8?B?ZlE0SS85S056QVdOL004ZmYrOFd5S3VjZ1RVWVdYZXRCY3ZwN1J5dHNCQm43?=
 =?utf-8?B?U1VjY1ZXWGtWeHVBNnJzckNzcWRyQ1ZrKzlST1RpdUNIdFRORlQ0Wk1UdHJI?=
 =?utf-8?B?YzlPT0NEaUJYU3hySFFWVnl0TzNxNGVBdFVFbDFFR1BobkIvcWFJOXV6VjNv?=
 =?utf-8?B?VE5OaXVreXFIVjZ2ZVpSK0FvZEZRVTZ6d0VYcURiZFA4NmZ4ZnA1bVdNZ1Yv?=
 =?utf-8?B?ZjVNZmFENFRnMllKNmQzeEZRMG14V3Q3WjVXNUpxWmtOeUt0TU9UZ2pSVFJQ?=
 =?utf-8?B?dFpQbFNYdEJudnpXSmxvdWpyOE1BeE9EVWJCUDNDS1pvZmNyMVNoWXpId1k3?=
 =?utf-8?B?MXdvTGcrVWhVOUhEVWRpRDVwUk5pSTVjUXJpOWQzV0tyREtYMWRJMGk5UmZz?=
 =?utf-8?B?UWdCWmZDeW9wQzBMMHB2SU1zVnI3Q002MzlmSFZvVDZoTDZzdko2anUzeEdy?=
 =?utf-8?B?NDdhcVJzK2FNZkxuZDFBK1BoM21rYllBQUxyNm9hbUFjWXQzL2hzK0twSnFr?=
 =?utf-8?B?cFVod3d5MW9OQkdUdm10RWROd2E4dEt3M3dvWlpRdWZNSy93SWo4a3VVY2VB?=
 =?utf-8?B?WC9zYjZYSmdROXFEYW9xRE9SanhSV20wRWVQMU10WUcrZlVTclFpK0JKREFa?=
 =?utf-8?B?L3NmV2tDQng3RFNOcUs4ZjlDZGVhNWdRVTNNbTRqWi9uZkxaVjhHdkdPY1lr?=
 =?utf-8?B?cmVTbXR2L29lRHlOd3RKZ2xTbUp3ckF1WDZHOE5qejdtMldWbVpPYWJ6VW5M?=
 =?utf-8?B?RFZ5bHc0T1I1eDIraGMvT253Ni91SnExVUZXTGhBZ1hGWWY4M2FjRkx6b0pu?=
 =?utf-8?B?K282TEN3T1VmcitmYVhjZjEraXlBdytFQS9SZVhyS2ZIWTlQcU5hTE5Ka2hP?=
 =?utf-8?Q?aAFiWLM/Ql1ARqI0mmg7ilqgn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77824e8-79b9-4901-3dd3-08dd5cf70083
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:36:49.3234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R83bmXQ5NipbhkVwBociikUfirknfHtgM+t26+zp7behXjGlKAY9l/seD7iBN3ngWnQMAvMhae7x+BvNVDi//Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961


On 2/28/25 11:58, James Morse wrote:
> resctrl_arch_pseudo_lock_fn() has architecture specific behaviour,
> and takes a struct rdtgroup as an argument.
>
> After the filesystem code moves to /fs/, the definition of struct
> rdtgroup will not be available to the architecture code.
>
> The only reason resctrl_arch_pseudo_lock_fn() wants the rdtgroup is
> for the CLOSID. Embed that in the pseudo_lock_region as a closid,
> and move the definition of struct pseudo_lock_region to resctrl.h.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


