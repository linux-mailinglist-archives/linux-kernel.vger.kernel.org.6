Return-Path: <linux-kernel+bounces-381777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4BF9B0453
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A880A1F23F76
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B500E1DAC9C;
	Fri, 25 Oct 2024 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UZB+tdFT"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED3F1D8E10
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729863592; cv=fail; b=LjfG3i8L/rCDWLO/GSjhcjWfHcMaudcXQq8Yjgp99joxivX/nhpbDZNuqmkYdziJhQSeovUkPbLEb5646ZWg3/Mk94Lyd2AxuooMFK2/M5WM/4SAlN6KZ2p7L3NktjcBim6tmmxQS5hVTASZFMT8wl2058UVTVdCGdsEd7y08DE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729863592; c=relaxed/simple;
	bh=YxZhVF2cubavq7zrbIqMetJ9jOewb8zwUsgZ512/gqM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mGrax5ILUtxleJO/QN2w99gRORJFVa8HUpiMPd2ctQVDMDoD4lebEf4jWy+93446j6VZy8h+SWpCCE4hu8R8TJMT8XwDmw7yyNf8NmpFjIugPUAx0T+5LExyHAuhk3vySI66qDpYv7CSAbbx7Om/AY1UfLhAjNMO8EgO4S3flzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UZB+tdFT; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEDuD46HtxtTR3+EI3qUTFu/iLl8nGxqRyvfV1/x0TgarjvPkcxjvporW8xQnpuNRgoWSgo2NeiYiGWXP5ux3+51OoY1Iu/l2B0VGDBHxSXa3bnL6GhXJcb3uYjGDZjUbN+RMrrE+Ltcr0yphOe7WLvtnTnhg5V2i9oL3Y0Q9T6xAlD/p7QSjULF1u8+OB+ZrbjcmMxJVlggT8MN1GZ8bqyv5wiD/AzwqrbW907j6I5j+FKVRk96fZ/UtX4chus839C50efPrDJgLWvKE7p5rn8WdYR4XOjR9yqhiHftskgOuuJUsCRUkDK7t9ME0cTv9E7F+KBslHHuExmuHvUPpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUc6kIOylVcm7kcuhbdsQBEulj9+rRnGRYL/An40o4Y=;
 b=JoiSZ3Hc41/K0AiuCqn5rFl5vf6e8+v91liZABnHD82nkPzR/UlS2FJnKH0RdkeG223ZKXUdAhMKg/5hN8GdJKfznPMoaoO7qoWx/w76wB3sSRPAKpp+qWuhSDc+3iVK/6CFVPVCPvykJdT50P61lAj1SVL9G3TEKqHTqk8dvINofHKP/7wFjj1PIGSNtXr2aySwMjXpyqAYjyhsfpZUv/0oCXv3EUi4UWRf7h+FaBDMmH5rAYK8slXW3ztcbQbg7JHeidwabSBILMKREDxZIEeLkEBHoUXATUJ6chfoldIexikXpykzUza/NhUgbnv3A0rAqGddy0UL6MQ7WY4P1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUc6kIOylVcm7kcuhbdsQBEulj9+rRnGRYL/An40o4Y=;
 b=UZB+tdFTw1jdMjUFdF/OvQ8ZcZznNhuqQVgnwOGjJl6wnEsubZzNwCn+G4Vnpb/0JnFRMMfB1u8OCI/bcs2up3PgqntrbBc0cPu+gu/Qf65lEc4WtXZDGbcx+SHLOO/VQ096EfyS9LGFOXMSOpoww3WyIMOFwva7Py3l/NB+410=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DM4PR12MB7717.namprd12.prod.outlook.com (2603:10b6:8:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 13:39:47 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 13:39:47 +0000
Message-ID: <dab3e393-0e50-cf34-f187-1a6357ceacd2@amd.com>
Date: Fri, 25 Oct 2024 08:39:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/8] x86/sev: Prepare for using the RMPREAD instruction
 to access the RMP
To: "Kalra, Ashish" <ashish.kalra@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
 <5e8bbb786f0579b615a5b32bddbf552e0b2c29c8.1729708922.git.thomas.lendacky@amd.com>
 <9ce26117-27eb-4f3e-8ac5-a37ea5d15802@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <9ce26117-27eb-4f3e-8ac5-a37ea5d15802@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0041.namprd05.prod.outlook.com
 (2603:10b6:803:41::18) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DM4PR12MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: f4edddbe-7543-477e-4abc-08dcf4fa7df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFZ3MmlmWUxNT1BEaXhCczMxeTl6aThQOE5Kbm5uNEVYUjR1YlRrbWxWMGVU?=
 =?utf-8?B?Z0JkQitYaS96M25qRk9FV2xWQTkzS1NiUU9UWkpVT3ZVbkR2VXBJUE9Lb25U?=
 =?utf-8?B?Y3Evc01hT2g2TmJjcnB3TlM5N0RrSUk3VFJxWnovazZIYkU5LytxbjhENmpq?=
 =?utf-8?B?ZStyTDlhK0t1bUtmYzczRU11ZU5JTHlZdHZYTXVQZUczUE1aQ3l3T1kvTDIz?=
 =?utf-8?B?WGQrbzBrbXlwZGVTQ21vMG9FWHVLeGdab3dSN0IxaDN1MXhKWjcxU1hVVXZp?=
 =?utf-8?B?blk4V0l4UFprU3NrMi9TVk1FQWVPeW5yZFNuS1BQR3hYRnZtMWFqNElGOXRn?=
 =?utf-8?B?S0tOWEtJSWZRUTZRelBCeUdZREw1WmpnMi96cHo5VDBVRnV6ODVCcFJqNkUr?=
 =?utf-8?B?Zm11M0dMYTYrMzBINklDYVVxbk1FZWtHUysxZER1TXFROE1nY29nNUdSa0JF?=
 =?utf-8?B?WFV4YlRhVmxQSTRCcE9SRGJPQVR1ekZ1dXVGeGFLOW4rUm5rUmVScFZwQWgw?=
 =?utf-8?B?VjZJUFdnUVRpaGczUkdLU3JhNG1ZZlN4UWN3SFVWWEh6Zm9yMFVmcEQzUFcr?=
 =?utf-8?B?V0lsOEtDdXVKU0thS0dJcTVrdW96WHFiaU5FQldpeFFXdnNEeDZYN056VTlx?=
 =?utf-8?B?UzhoVVQ5RWVHMEpSN3dGelZvWmFxdlhqT1JPMmZnbk9DYzB6MHNiN1BHelhK?=
 =?utf-8?B?RUZ1UFBCOHRxN1ZMSnV6amhzQm0vNVBVQ3hPT3dBdnZqOUV0NUFuaGVkYk1r?=
 =?utf-8?B?NEFJd0ZubjV0Ui85MStEU2xBMmdBbHp6dlk5djR4dFpnTVl5cTNpVFV0amR0?=
 =?utf-8?B?OG85aW85Y1c4bjJ3SkdjZlVRdUhWbTJwK3RBMFN0SG1nZzYzYUFWenJ4blZo?=
 =?utf-8?B?VVlheTNyNTZWMFdPdnNMaSszSVJnNEtYOWhYM2JFM1ZuWkJBWHlFdFhzeUVI?=
 =?utf-8?B?RlVYc0tXd1YwV2w5UGkwQkMxK0N2Zk00YnRxZmJDQTlBc05QbTRIVVF2QUxI?=
 =?utf-8?B?UDRFQ3BGZFRWMU1lZG9qaTJuays4WGsrOEtxL2IzYjN0ek9Xdmh6TGhibFhx?=
 =?utf-8?B?c3lhUGMwK21OSTRYWHlSVUpUVE8xd0dqRFk4cUQ3SnFNSmVmV3Rxbll3Mm1F?=
 =?utf-8?B?SkpsL2J2bitBYStCWC8xMkV4SzFFd1BRZnNKU0FvL0p2WlRJWDhZRUpDam00?=
 =?utf-8?B?RDE3TXN1RlowTTJ6c2tkYUlMSEY5YmRrd2RVeWtwYVpnQnEwcWtLUHhGVVJX?=
 =?utf-8?B?ZWFzcjNFMFFscGFVbnJzc3BYeHlzTWVkWVRUUktmUVVsek9seUo4TklSTzVm?=
 =?utf-8?B?aFlYNXhGRDNZbDBvYmdURGtKWHNpUGxSakxzRDZ1dy92bGUxNjc1ODRlTUdq?=
 =?utf-8?B?aTArVk5mRVRTamlwSlg2c0JqQUZyUkhQaXR1dUlTa24xdDIvcXYwaEpab2sv?=
 =?utf-8?B?ZGU4VGUrNW5UWkg2bGtBWlZFNEZlL2pPNDJUNENIU1BDRU5saGtlUXBtZmU5?=
 =?utf-8?B?RjFuU1p5VUJUNW5MV01mcFViNGNndDlxSnZVRDI2Wm1LaWFadFBvUWpJQUFU?=
 =?utf-8?B?NWJBM0JiVGhHcTh5cThBeVBGNFdxWjREMXNydUVCSWpCYzN4bUlDNTN5bTBp?=
 =?utf-8?B?Z3BKSlNPWVVXWWwwUmJ3N0VEWDk5RXppMERidXNuNnhLOWdaWG84d25BNEhU?=
 =?utf-8?B?NTJzbjVHOSs3ZFNhdnMvZElUYk5DL202aTkvUDVSVFRCNjVtaFJlNjZNU1RL?=
 =?utf-8?Q?iBhA1/jSQHGtjcPc4uqZ1HQMxuv0Srin32+9eF7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnhTMVVkdEJYa1JzbStpRFlCVVNEdm1qOTdlc28xU3N2THVaTDdqL0VMYktw?=
 =?utf-8?B?eDNUaFdJdUY5aXZkdHNCQ3NJSDRQbmg5UVpGL3RCYlE2TDBOS1RqdGZNZkY2?=
 =?utf-8?B?dW5YUElKTHdkN2pjZ3pSZVFPemFjYm1EMHhKL083QWQxYW5kdmkrZTEyUHpt?=
 =?utf-8?B?VE90c3FOSW5GSWlZaGVLMWxFTzlQSlBiaE16R0h1Ny9XQ1FReHJKMVplZUVT?=
 =?utf-8?B?aTZPdHp6TEpPcjlkeGFhVVVKVTV1V2dlbVRnNFlFMkhIMXR4citFOGdYRkZP?=
 =?utf-8?B?WU90bkNHazI0SDd0R0hzcGdGTHZCNEdMQjFTWGtjeHkya3hQVTFDdDBja2J0?=
 =?utf-8?B?SDNEZlZpYU1LVzNDNU1hZHYrWXdDSExNUG1yTk5XVlRBbkFsRFo5K1ByNHN5?=
 =?utf-8?B?bXV2WkFyYnU1bXlubkpUaTFkNmFTZEV3a1h3OHdndEcxOEljYWVWNkVYUUlK?=
 =?utf-8?B?YzIyeU4veXhUdE51QSt4KzE0b3VKaFJOSXVVVmxWRUNPaERBOHJSM0FjUDN6?=
 =?utf-8?B?YzlZMEYvVHVWWXZQUWpJRy9VRFUxMERKTDRzUHFCYVlQaDRuRUJOUW94ZDhh?=
 =?utf-8?B?aG45T1hjV2wwc2NiV1RsL0ZyQnArMHByMkpRV0JhYVZTM0MwR2hyWGI4czhp?=
 =?utf-8?B?Z0JyOTZwZ0VXUlVUQlV1RTVraFN5RHg2R0w4VnF3dWNncGdqMThFQXdLa1Jr?=
 =?utf-8?B?SVEzRVhyY2FjUEMvemlnNnNPM3J3cVAvMEJoaUhCTlBySWRjT0V2MGdzUWVt?=
 =?utf-8?B?V2NMWXM2a1pMd2pwRHBUWW9yZ3ZMNUtPcHp2MFBrb2ZzNXcrM2xqOGkyaEpp?=
 =?utf-8?B?Z2V2MDltaHpmWnB0VTRrRWh3MGZYS0FSMGJVNXUrZ2NGMlpncWtKZ2tyRSta?=
 =?utf-8?B?a3Y1QThtaSs3WjA5dUI3Und4YUlUWW8xa1RYTHB1MHprKzdac1grTStRQ2pE?=
 =?utf-8?B?SHFqSWQxeGtXTzA1blBwREVCaGFzeGgyYzhmZCtZeDV2Y3VjcWVobUYycGxK?=
 =?utf-8?B?Wkx2SEhNS1RoWHN3V0VEZmRYc0tmc0lMdFFlKy9sUWRFRk1kWDhKWU45Yzk3?=
 =?utf-8?B?cVR2RXNnL2RLWERCVjM4NkpLY0hBb0ZxY29jZkF6bDd6UFNKV0xySEF3Y2FJ?=
 =?utf-8?B?bFc2QkVmZjcybTY1M25zamRjRU14K3hCYWhaQ2hManZXMXU2K1NYc0hXMXkx?=
 =?utf-8?B?MHg3Q3JYL0kwdXVIVDNOOW5zQ1NKc2xHOXJvdHlzc2wzSy9wWURNdUpKVzNV?=
 =?utf-8?B?cEtKOWVJeWFUczUwSDZ6M0IrcFZyaHlqMFNCSkhGanVBUllITGMrMjZBd0pS?=
 =?utf-8?B?TzUwdE9hL3N5WFpWaEFzV1BjSkRyTndXazlvV3AxMXNYT1hFQncyQkFDZk9W?=
 =?utf-8?B?Q2d0S0l6RjBWeHRwWGVVaDYralF3Q2pWM0hvR2JaUUMwMDBmQmFDQVVCbjl3?=
 =?utf-8?B?ZWt0RzAvVGtKTDhwc1h3WCtxZ1hDVllvN2JIcXNpRXpoT3hkZEszRW94dzA4?=
 =?utf-8?B?WSsxU0hXVFVPM3VVVEVLR2prME9SOFVkTzg2eXZJVjJOcG1xNmdBYTdXTi9x?=
 =?utf-8?B?cmtURHdiUTZMWVNUVzM3QnIzVXdqS3N0aUluQ1k4KzdvQmZQT1hqNDI0R1Z1?=
 =?utf-8?B?NGZKTFIwWHFPWlErakM4M29RVVFPZmpKY29VeE9KeWJ2WWNKWVZMOCsvWWFk?=
 =?utf-8?B?Rk5hQXJ4dFROUXZQMUZKUk43RGdtQmNXcGNiOXpsRVlraTBEbFhQZVZUKzNM?=
 =?utf-8?B?eGpqb1dKMWdxNGtlTENKbFZ6cWVPV05WZWU3dHd0dFMvajNnV2FNTGN0ZEVj?=
 =?utf-8?B?eUJNL1A3MlNRVW5YeGNkL1JGYkpQQktHcXI5UHo2VkdDeVBOZWdmTG11Tnpp?=
 =?utf-8?B?VGZjYWtCa1VrQXBqYnEwaHVRR052Q1J4RW43NUt0RDBoUDdJY1pMYUo4SkdN?=
 =?utf-8?B?UDBYcElkODdBRnpQYWRNZmxiajVCQ2FHeTdGajZuQTN2QmJYQTBldnBaZDFQ?=
 =?utf-8?B?c0lDVjRWaE52UXNhUW8wR1FQUjJGS01UcjVSSGVvMGZyRjFoVy9PcDV5cFA5?=
 =?utf-8?B?N0V4S3pLN2RvM21GRnE2WXhTUi9Hdnp3OEVySGtKTjlNMWNieTk4VXJIQ2sx?=
 =?utf-8?Q?sA85/P+kUoIFc62GkuAq29m+i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4edddbe-7543-477e-4abc-08dcf4fa7df9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 13:39:47.4597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kvkW0kQhWzwnFzLs9Ikds3MZNE4qAEl+CZQViLuG6H432kYCspGMitpO/R7g95MpykvdRGM50ve2o1IULYk4JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7717

On 10/25/24 04:00, Kalra, Ashish wrote:
> , 
> On 10/23/2024 1:41 PM, Tom Lendacky wrote:
>> The RMPREAD instruction returns an architecture defined format of an
>> RMP entry. This is the preferred method for examining RMP entries.
>>
>> In preparation for using the RMPREAD instruction, convert the existing
>> code that directly accesses the RMP to map the raw RMP information into
>> the architecture defined format.
>>
>> RMPREAD output returns a status bit for the 2MB region status. If the
>> input page address is 2MB aligned and any other pages within the 2MB
>> region are assigned, then 2MB region status will be set to 1. Otherwise,
>> the 2MB region status will be set to 0. For systems that do not support
>> RMPREAD, calculating this value would require looping over all of the RMP
>> table entries within that range until one is found with the assigned bit
>> set. Since this bit is not defined in the current format, and so not used
>> today, do not incur the overhead associated with calculating it.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  arch/x86/virt/svm/sev.c | 121 +++++++++++++++++++++++++++++-----------
>>  1 file changed, 87 insertions(+), 34 deletions(-)
>>
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index 0ce17766c0e5..4d095affdb4d 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c

>>  
>> -	entry = get_rmpentry(pfn);
>> -	if (IS_ERR(entry))
>> -		return entry;
>> +	if (unlikely(pfn > rmptable_max_pfn))
> 
> rmptable_max_pfn is initialized in patch#5, shouldn't this patch be moved after patch #5 ?
> 
>> +		return ERR_PTR(-EFAULT);
>> +
>> +	return rmptable + pfn;
> 
> Again, rmptable is initialized/setup in patch#5, similarly shouldn't this patch be moved
> after patch #5 ?

rmptable_max_pfn is initialized in snp_rmptable_init(), as is rmptable.

Thanks,
Tom

> 
> Thanks,
> Ashish
> 

