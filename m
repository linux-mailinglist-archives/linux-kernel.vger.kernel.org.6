Return-Path: <linux-kernel+bounces-554383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8C7A5970F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97792188BF7A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B94822B8A1;
	Mon, 10 Mar 2025 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HsVNBkUd"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50A6229B1F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615639; cv=fail; b=O/S66M80oNmc2msso6j722HaWW4dYKwYOBvdahafrpwEjheAj7BLbIk76mO7CaCfNxv0WRoKI9r1va3ag3LJwGXDI3EcEAael+pFC7MpYQAE8nw3AjjHo6Q/NBmhiSKvufF2Ep1h/Qlbq1dD0Dfpk1DE/r4TUvt9m9ha/Nk2No4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615639; c=relaxed/simple;
	bh=a+wTGWuPaVg8GFGPJjvPDqnr2DlEi1KhvGWCUSvHzOY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K8LArW5xVKeuKUQRl31+Qu2PLYa8tKfUv2kCfXzPjCIFvrHrhRp/NEXW4cwMYP51FLGmXxddP1uoAAb9d3Z4m1bASfoo5xJlQqIfHIowLNsumpmlWcPsfuAuKlL/7v1oY4oY5MEifcOzoPuX+DbxCuZhwcLZaifVezsqSqkgxto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HsVNBkUd; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DN4uEQKou3IoxsV22j/qSlMoTWoyKreSPVIi7bKGZRcCUXIQnOJAdVNvaubbAzQmb8DP9x3e+PGDDLDSrk9rwu0tuiHAoJ/rfMgO/c7xhUlbp6mU+xlXQ1NpyBO3AXacg0N1aA3ym6FgvAYihTh+iPddmQIEhA5EThAqijYgg0Wc8tBfwCNKl6Fg+qC2JKLke/4qGPayVzntr9K1LmXnLpMCd6+Xb5ftstiTeF94zZpcBIcpazdEs6+pcE8C/9IKkLrY91rDIiUWqQG25hmr5YSmfdVfWyX2E8pzz6Zey27U9xszRv4J9ZhensQK9eh03WmdGzT0Qf0GB2kPssV4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phMm4kRpFefuFUmzWsJvPeE+MAsqvHdfJQzSzwM6QXE=;
 b=cwfQphdDy/ZrkTJAtN13dy5CrRSnAlTjvhsv2NqnLc2uHAL4qx29WuohxjhyunouXEsNfuQAx0cfxhSMkTzAFc8/ON0zfD6R0fag1KhM0qMuyOoa1Zi6/7BKRhTrRUggeSiBa0uvne0LBjsVswGtkowoni8CP29CnV8TShb5tz2eEjOUlRutCFm6ZEKcdEecDC/QPLbOumHOXVLd6Lp42L6JZcpol0IGm+MOudo4ULcNs/xD0GQQnsBlJog86d9hMDlHsUNE1TDB+88sBjJggYJdm75juqOli5peOE7TBS5V0K2fCK6gLQIAnMdjsURHZwK14z1LLFy2/alCpNnzTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phMm4kRpFefuFUmzWsJvPeE+MAsqvHdfJQzSzwM6QXE=;
 b=HsVNBkUdlhEGjPHt4X0o6cN99X850cC3HTUZykIm9gJTR0WQOiX8rxVF0lbxJKuGiIyfMAxIXqcyCZMSF3BMN5V8bZi15/cHl5evTD51ZDh/I+1a0QwJL56I9Q2F+zGoQAAS8lIeK4jaKSIyZBGmOOsFqX2YpNiNs9MZJnsWBNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 14:07:14 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 14:07:14 +0000
Message-ID: <7945ffca-6c2c-4baf-89e7-688681db29ca@amd.com>
Date: Mon, 10 Mar 2025 09:07:10 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 00/49] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com
References: <20250228195913.24895-1-james.morse@arm.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20250228195913.24895-1-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4d5b19-494d-46fa-e114-08dd5fdcdbea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmI2alltWVU5QXUrNDZOTUt3SUgxZ2p6QWE4QW9sNmhjUk9xc1oxemYxQUFI?=
 =?utf-8?B?ak5TODhFZlJYZTBMa2Q5TlFuSHBJcy9YbWI0M3pOQ1lRQThhbGMzV2hNQ1N0?=
 =?utf-8?B?dmtINGpSUEN4V2ljdXJ4QWkvd05PTU1VdkdSNDUrU0wvTHBveHVkc3l6dGlO?=
 =?utf-8?B?R3RHdUtxZlNEKzJIRzlWTW9WdXc3R2lPT3ROamNFamxYaVQ5aWJYRkhRb3JX?=
 =?utf-8?B?VEFWZzl1QVNvN3FlQmpmTlpUTVlUZW14dnYrWTRwYThyS29kbERwUGd5MERX?=
 =?utf-8?B?elVTZGJ1MEpXMkRQeEE5TFJBYytBaFJBejEzSzdTY0JLekd2NWJLYjdDTFVq?=
 =?utf-8?B?YzdVM00vM1NqV2NtdmxKT2JRSElEN1hHakRzYlQ3T2w0YlFMNmtUcUdpYVFJ?=
 =?utf-8?B?RHN1V0V3bXVoQmtYcHJLMXFpS0s5R2ZUUUFGR3l6bUYzaVB3R1R0VTg4SEdr?=
 =?utf-8?B?SDFmUkhWMFk5UnlROFBrOGN0dWtnbmV5cFUzbmVPL2dacG1zcjFvUUNrZmVN?=
 =?utf-8?B?VW10K204NWs2NzNwQlFWaVB5QWVDc3RKM0M2WHVhYmJMK1JSKzFSMEJ6c1I1?=
 =?utf-8?B?NSs1RDN5OS9VTmZQaGRkYUVNcllVSmVBVWRMN29xcmE2K1JTdVhrYko3NG5C?=
 =?utf-8?B?TENmWnB6dUFuSERMMXM2djU0a0o5MDd6M2lJVTVkL1hFeTNWRWFIYTZVczJ6?=
 =?utf-8?B?Q0xXNExQNzRydHB4WGE4bW9pT0RvM2FiWHlocldndnpnWGJIUHZEaHRoaU8r?=
 =?utf-8?B?WHNKaTRhcWZLV1ZBR0x1RTU4UkxCQ0lkZFBPdTd1YU1yY2R2c1hLb1A1OVRQ?=
 =?utf-8?B?VisvZkJJL0FYUFlybmJnN1ZySlZDZEV6RXp0OWo1SC9JNFRBTEdYV2pHMmEr?=
 =?utf-8?B?WkUxWG5zY0dLcFptRTRGVHZpUzZXelI5d00yVTdBUk42TFJXcU9pOWdGbDhm?=
 =?utf-8?B?V2U4dmY0RXlKQ1VaRUcwd1FENmhGVjYwbXBtNzF4SjhmSWsvR0JnRXdadjdE?=
 =?utf-8?B?THR3QjZZK1RYWisxTkJpTkZvQ3QzRHZ6UzlrNzRmcFAxeG5reFIzQ2RHK0Jz?=
 =?utf-8?B?Q3RlWHV5enIwT1ZPZkpKVWlaODVOd2V0TlZqOG94UTNFaVJIREI3VzQ0SkZa?=
 =?utf-8?B?QW1jemZiMUZkQkNYS3g0dlZ0bzd6b0tSWCtRQlZmZU8xMmZ0YmJjWUsrLytT?=
 =?utf-8?B?eU1aOS90bThVZDA1OUdYZFJQb3hpMjduYkRyS3dFc0N1MHlNc1V2bURXVkkr?=
 =?utf-8?B?SktnMTRxYWZaSzA5cG5vTTlSSUJkU2EwZlhISE5aS1JDdndaSkliTGl3cW15?=
 =?utf-8?B?NWppRFlRc3V1aFI3N2lITzZwN0ozYWdsRlFmc08yQ1FXaGZVblFpc0g3SWY0?=
 =?utf-8?B?WDdENDRrSmpQS0dXN0hWZmFBUGN4TVlmYnYrTjlpNWwyZjd5UzhVRXV6YlhM?=
 =?utf-8?B?Ty82L0RXR2o5V0VUVWYzblZCU0xybmhXQzBsU0VmQU40eWJwZ29UalNQWlpz?=
 =?utf-8?B?VHE4M0JObFVFdU9kdmVuRllnWjAxa0NxRXdsSlM0UTdQZkUyQWhDUnhLWElQ?=
 =?utf-8?B?RGsvb1BxbDhCUlFwNEN2SEpkOEk0Z3ZXR0JCeEp2KzRNeG0raGcxNTk0ZnNN?=
 =?utf-8?B?aHVHamhhSXN3TEFHaXlrSHp4QW9JWm9Qak1RN2JnSjRwa2JLYzhxQlhVcUdD?=
 =?utf-8?B?QzVSV2dvbGtydWJTb3dxaGkvcFhhQmlIeXJaRUlWb1pjU3JCaUNGbHRwSHQ5?=
 =?utf-8?B?Z1V3Z1Vac0lNTHFzVmdOMnBRZmo3NFJ6VThQbXFsc3dMVWJGTEpzd09ucURr?=
 =?utf-8?B?T29XeHBoQTJqR2ZVZUVsZTV0Tk02cTlYRGxEanB2S1paMmdtMXBTK0oyTEhF?=
 =?utf-8?B?MkI2REZ1MEl4M2tVS3MyRW1CWXJ3TW9laXZIUkV3OWZqL1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c05pQm4yM0hhUkFGODVOS3NWZXg2OVdHT0hhS2twTG1MRDZrdmkweFJzMFZs?=
 =?utf-8?B?QkpEenM5c1JOdnVoTi85bzRZb2lEOXk2VWYrM0NPbzZQeTFzZXlmVS9zaVJw?=
 =?utf-8?B?LzhFR3J0OEljUlozaFVadEh4a0QvbUxUS0VxSlUvelZKcElvZkNkZXZmTGFx?=
 =?utf-8?B?MUtRbC90cVZ4Y1VrWjdzeCt1MEVXL3ZqK1Jabk5ERWE5cktuWUZja3huUDdM?=
 =?utf-8?B?ZXI2MTZMNldyVTZGek80ZmdscUxFZlFHcEN5WXJSS1hDbFpXeDNEcWp1d3pN?=
 =?utf-8?B?NldQWmdjb2dEcUtTaHVSbUZ6dGZuSFNtMVdRUUZvRlhRRENXdlBNWlJ6V0Ja?=
 =?utf-8?B?bnk1MUpocENFVG9YVTJKcDVaV3c2eG1USDVLUDlVRWgxOVBlNXZGaXg2WUtW?=
 =?utf-8?B?d3JiZkJhTTd0SGJvVjc1cjNHOUhhbFBDbXZoMU93dTYrWGtadFF6Y0k1TzNy?=
 =?utf-8?B?b2x5RGZhUE9xYjhwOG1uWWQxM01zUWtoZWcybFhUemJTL3Q5THRWV2FqOGly?=
 =?utf-8?B?SDFaVlRuSS9jWTVza2JwYksxR0syMUpPQXBvRE5BczF4M3g1QngrdEJkc0F1?=
 =?utf-8?B?QTMyWVJ2bWhkUmNlcVJwTzRTQjJTZUlHUUtFZDE2dFFjRno0WU9rSnNKZU1Z?=
 =?utf-8?B?WkJzRXBscjk2N3dsb3NqemVraTBTWkN6bHo5dmFxMHMzN0RVeHUvdkpCd1M0?=
 =?utf-8?B?QXVvRnlnc1hVSlY0djFWbVlkTmdGUTIxM245WjVWb2ZMNnBIQ2NDZFYzNzNr?=
 =?utf-8?B?THlIekM3VFFoWHRlMDMrNHBDRjdBNWQ4dEFiOTNYVjFFNU5LK2I4RjlVWHV1?=
 =?utf-8?B?S1ltTXo5aXRGdVdPRDZnbk40Znd6d3I3LzRlYllBdnhnajJsdTQxN3FMREtw?=
 =?utf-8?B?ZXppL005V3BqOEhBb3lIa3dGbDhOMS8ramk4YVFZditocjRheFNFdWlMN3k2?=
 =?utf-8?B?SjBYYnlBTzJncFZNRHRkQVJxZEttNDh6MU45eGxhdnFSbUNTM0xCVHVnUjlV?=
 =?utf-8?B?b3g4VWM1WTdhYkJOQk14Snc4b2M1aks1aVRHaTE0TnlyOVJBVkVTWkFybitx?=
 =?utf-8?B?QXNPeExmNWg5U2Rzb2p6dUNZYVhJVTlZeVNxdkNCR2VpMi9HTzk1eGcwSUxQ?=
 =?utf-8?B?TWZPUzZqOTBzSUhXRHZpY1FwWW1uU0ZIL2JMZStKS3JCZW1USVh6RXBkYnpO?=
 =?utf-8?B?R2tJeWVxRmFDS0VaOVdCdHBOOGJqRG5YRG5WSlZ5Tmhjd0V0ekRrNkdoUWtn?=
 =?utf-8?B?UGJXemwvb1UwUUUreEJGNVZaekR5ZmlYdWRCQ0hpTjVuTmFNeCt0TVUzdTR0?=
 =?utf-8?B?ZkpZU0EyYVg3VVNnZjdrWnRvb2xycWx0WCtMbWtobVZzMkNHdFkzMmtURDlH?=
 =?utf-8?B?OXNFY2NjRkxWY2V4VTRGMTArekFSemM0bTBTME1wMmlEVWpPaHBpVGJQSjMr?=
 =?utf-8?B?MjAydUZYVGVneXdXR2t2UWtGL24rbDN4eXRyNTJ5c2hRcXB0ZWZqYm5HWWk4?=
 =?utf-8?B?bjBFNm9pMjJjMWRJZ0VqVzlqQml0aDM5ZW9vUEVFWUZ2STFOZHBNMXViUyt2?=
 =?utf-8?B?WkRNdHh3Q1FxeVJNQmVtM3duaHpFR2k0TEc5ZXNGM3VMT255MDcrQThQQmZQ?=
 =?utf-8?B?ZEpuYnRObVkyemRHTmVMUEZCMmZ5ZmpIa0cybElBOGQvc2VsLzk4VVJGQzZ3?=
 =?utf-8?B?U3lnWll1allyZWJHZ2dXdFg0SDkzZEF2dFhMc09XMDdXcTdHcjUrdWVyejFu?=
 =?utf-8?B?OStEck8wcUc5a2JPelFnMmoxZyt5dGsycnBSbDA4Sk92eDlFU3dNRVZHYlZC?=
 =?utf-8?B?N1VUWDh4TVY2ekRmNjdXb0QxalZESGloQUNGMjgyS1ZSdTdDM0dJT0RkRFRE?=
 =?utf-8?B?NzBMNHZRUzVoNDhDUll0c0VRcTRtbjlsUC9NNDFSRXpCZVpRL2l5VnBuMHRO?=
 =?utf-8?B?WmJJT1VPNis4ZE1mcm4vdHAxNmtoQ2VrTnM4UHVoREt5cW5lYmNIejFNdW1Y?=
 =?utf-8?B?QzdkUWhzUjlWRkZpMzJXYUVqb2NKcFVwWmhzSEFuN3RDWHVsR0VQRC9pbE5O?=
 =?utf-8?B?dndESW1Idk5nWVV4ZE1KRjFPM3hvRVEyRjl2Nkx6REVnU0Z6ekJERjIveUNB?=
 =?utf-8?Q?WLWg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4d5b19-494d-46fa-e114-08dd5fdcdbea
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 14:07:14.5662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9qZAdBG7A+/9b3M2CNNXwNHqf7ZeysMA7lvpOw3hINZUFTvvY7PDe0crvFDLnFi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210



On 2/28/25 13:58, James Morse wrote:
> Changes since v6?:
>  * All the excitement is in patch 37, turns out there are two rmdir() paths
>    that don't join up.
> The last eight patches are new:
>  * The python script has been replaced with the patch that it generates, see
>    the bare branch below if you want to regenerate it.
>  * There have been comments on the followup to the generated patch, those are
>    included here - I suggest they be squashed into the generated patch.
>  * This version includes some checkpatch linting from Dave.
> 
> ---
> This series renames functions and moves code around. With the
> exception of invalid configurations for the configurable-events, there should
> be no changes in behaviour caused by this series. It is now possible for
> throttle_mode to report 'undefined', but no known platform will do this.
> 
> The driving pattern is to make things like struct rdtgroup private to resctrl.
> Features like pseudo-lock aren't going to work on arm64, the ability to disable
> it at compile time is added.
> 
> After this, I can start posting the MPAM driver to make use of resctrl on arm64.
> (What's MPAM? See the cover letter of the first series. [1])
> 
> This series is based on v6.14-rc3 and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/move_to_fs/v7
> or for those who want to regnerate the patch that moves all the code:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/move_to_fs/v7_bare
> 
> 
> As ever - bugs welcome,
> Thanks,
> 
> James
> 
> [v6] https://lore.kernel.org/lkml/20250207181823.6378-1-james.morse@arm.com/
> [v5] https://lore.kernel.org/r/20241004180347.19985-1-james.morse@arm.com
> [v4] https://lore.kernel.org/all/20240802172853.22529-1-james.morse@arm.com/
> [v3] https://lore.kernel.org/r/20240614150033.10454-1-james.morse@arm.com
> [v2] https://lore.kernel.org/r/20240426150537.8094-1-Dave.Martin@arm.com
> [v1] https://lore.kernel.org/r/20240321165106.31602-1-james.morse@arm.com
> [1] https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/
> 
> Amit Singh Tomar (1):
>   x86/resctrl: Remove the limit on the number of CLOSID
> 
> Dave Martin (3):
>   x86/resctrl: Squelch whitespace anomalies in resctrl core code
>   x86/resctrl: Prefer alloc(sizeof(*foo)) idiom in rdt_init_fs_context()
>   x86/resctrl: Relax some asm #includes
> 
> James Morse (45):
>   x86/resctrl: Fix allocation of cleanest CLOSID on platforms with no
>     monitors
>   x86/resctrl: Add a helper to avoid reaching into the arch code
>     resource list
>   x86/resctrl: Remove fflags from struct rdt_resource
>   x86/resctrl: Use schema type to determine how to parse schema values
>   x86/resctrl: Use schema type to determine the schema format string
>   x86/resctrl: Remove data_width and the tabular format
>   x86/resctrl: Add max_bw to struct resctrl_membw
>   x86/resctrl: Generate default_ctrl instead of sharing it
>   x86/resctrl: Add helper for setting CPU default properties
>   x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()
>   x86/resctrl: Expose resctrl fs's init function to the rest of the
>     kernel
>   x86/resctrl: Move rdt_find_domain() to be visible to arch and fs code
>   x86/resctrl: Move resctrl types to a separate header
>   x86/resctrl: Add an arch helper to reset one resource
>   x86/resctrl: Move monitor exit work to a resctrl exit call
>   x86/resctrl: Move monitor init work to a resctrl init call
>   x86/resctrl: Rewrite and move the for_each_*_rdt_resource() walkers
>   x86/resctrl: Move the is_mbm_*_enabled() helpers to asm/resctrl.h
>   x86/resctrl: Add resctrl_arch_is_evt_configurable() to abstract BMEC
>   x86/resctrl: Change mon_event_config_{read,write}() to be arch helpers
>   x86/resctrl: Move mba_mbps_default_event init to filesystem code
>   x86/resctrl: Move mbm_cfg_mask to struct rdt_resource
>   x86/resctrl: Add resctrl_arch_ prefix to pseudo lock functions
>   x86/resctrl: Allow an architecture to disable pseudo lock
>   x86/resctrl: Make prefetch_disable_bits belong to the arch code
>   x86/resctrl: Make resctrl_arch_pseudo_lock_fn() take a plr
>   x86/resctrl: Move RFTYPE flags to be managed by resctrl
>   x86/resctrl: Handle throttle_mode for SMBA resources
>   x86/resctrl: Move get_config_index() to a header
>   x86/resctrl: Move get_{mon,ctrl}_domain_from_cpu() to live with their
>     callers
>   x86/resctrl: Rename resctrl_sched_in() to begin with "resctrl_arch_"
>   x86/resctrl: resctrl_exit() teardown resctrl but leave the mount point
>   x86/resctrl: Drop __init/__exit on assorted symbols
>   x86/resctrl: Move is_mba_sc() out of core.c
>   x86/resctrl: Add end-marker to the resctrl_event_id enum
>   x86/resctrl: Expand the width of dom_id by replacing mon_data_bits
>   x86/resctrl: Remove a newline to avoid confusing the code move script
>   x86/resctrl: Split trace.h
>   fs/resctrl: Add boiler plate for external resctrl code
>   x86/resctrl: Move the filesystem bits to headers visible to fs/resctrl
>   x86,fs/resctrl: Move the resctrl filesystem code to live in
>     /fs/resctrl
>   x86,fs/resctrl: Remove duplicated trace header files
>   fs/resctrl: Remove unnecessary includes
>   fs/resctrl: Change internal.h's header guard macros
>   x86,fs/resctrl: Move resctrl.rst to live under
>     Documentation/filesystems
> 
>  Documentation/arch/x86/index.rst              |    1 -
>  Documentation/filesystems/index.rst           |    1 +
>  .../{arch/x86 => filesystems}/resctrl.rst     |    0
>  MAINTAINERS                                   |    4 +-
>  arch/Kconfig                                  |    8 +
>  arch/x86/Kconfig                              |    6 +-
>  arch/x86/include/asm/resctrl.h                |   43 +-
>  arch/x86/kernel/cpu/resctrl/Makefile          |    8 +-
>  arch/x86/kernel/cpu/resctrl/core.c            |  214 +-
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  606 +--
>  arch/x86/kernel/cpu/resctrl/internal.h        |  504 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c         |  863 +---
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c     | 1120 +----
>  .../resctrl/{trace.h => pseudo_lock_trace.h}  |   26 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 4031 +--------------
>  arch/x86/kernel/process_32.c                  |    2 +-
>  arch/x86/kernel/process_64.c                  |    2 +-
>  fs/Kconfig                                    |    1 +
>  fs/Makefile                                   |    1 +
>  fs/resctrl/Kconfig                            |   39 +
>  fs/resctrl/Makefile                           |    6 +
>  fs/resctrl/ctrlmondata.c                      |  660 +++
>  fs/resctrl/internal.h                         |  435 ++
>  fs/resctrl/monitor.c                          |  933 ++++
>  fs/resctrl/monitor_trace.h                    |   33 +
>  fs/resctrl/pseudo_lock.c                      | 1104 +++++
>  fs/resctrl/rdtgroup.c                         | 4329 +++++++++++++++++
>  include/linux/resctrl.h                       |  216 +-
>  include/linux/resctrl_types.h                 |   59 +
>  29 files changed, 7992 insertions(+), 7263 deletions(-)
>  rename Documentation/{arch/x86 => filesystems}/resctrl.rst (100%)
>  rename arch/x86/kernel/cpu/resctrl/{trace.h => pseudo_lock_trace.h} (56%)
>  create mode 100644 fs/resctrl/Kconfig
>  create mode 100644 fs/resctrl/Makefile
>  create mode 100644 fs/resctrl/ctrlmondata.c
>  create mode 100644 fs/resctrl/internal.h
>  create mode 100644 fs/resctrl/monitor.c
>  create mode 100644 fs/resctrl/monitor_trace.h
>  create mode 100644 fs/resctrl/pseudo_lock.c
>  create mode 100644 fs/resctrl/rdtgroup.c
>  create mode 100644 include/linux/resctrl_types.h
> 

Ran tests on couple of AMD systems.  Everything looks good.

Tested-by: Babu Moger <babu.moger@amd.com>
-- 
Thanks
Babu Moger

