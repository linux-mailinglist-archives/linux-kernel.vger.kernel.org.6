Return-Path: <linux-kernel+bounces-550877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648F3A5653B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D471755F4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0407420F090;
	Fri,  7 Mar 2025 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="FdbTE0w9"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC73A20DD71
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343326; cv=fail; b=kwsBSdFmiPAHwpSTYK4BKOICNFUnwbq6o/27e8ZJFkc9P9TV40NB4g9hwtl33qGzfgIrWHYuOpZJuIUqDrqeOnYE6kT/vTOi/y4OCnjZxqekLg+JM8hanIJ4UMWm14b+K7yi/vChrUlJ0QViw1n01Cl2R8o4Wvtx8APOvoE6YAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343326; c=relaxed/simple;
	bh=BzdEyxeqVuJGvc3/cbxiEYbTtT/Jmyl7LNFCdxjJ4NY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=MGAuZoLmY2IsWFnMhDD8EvSPWtT57WEhguajvkxyO0GwQwthtbKweqMSZxcYe9S5PrAuxChmejA8haNKlBHppHVgy2Mmwyyi5ESI5GwtpoKO8ZsLCzT/l1hxagSwqfLEZPhKF1llaU4IW5AcC5VCeIrQadfZMesx2rrboEcQo8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=FdbTE0w9 reason="signature verification failed"; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5279ExQp026066;
	Fri, 7 Mar 2025 02:27:41 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 457x0cg3pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 02:27:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krTPBdhJ9UihMDCceoz7swY+gauk63vZE7jBSAQ22Nq1Q75Lu1FN7fEucgAN6flpMw5pjcSCVRdPHmac88V2vTd/3wc3ODq2Drf8taI2jmJAR1dVs6LxmpnMSAHJmec0fOUHup0/CLaNOx+tivY36sVAXJS59R2acNF5CfRFBY5uaeCc9ZGTIN3JfHuFJj6vXzXIez4Ot8bMqHUq/iyovbuDNyltDDWr+pKmiOX+UT+F/Axor91nlCHQWODF3xyuaBqhn32kx8qFjES1dTUXqOthynQD2wts1tS9qPTQSJj8aN7DahkfqMEicu8uBwOAkTHWDdXAcWERT7DREPMHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHuYzokZUNEKlq3ntWf1AGvfs1IU4S52rOxtnw9t43k=;
 b=Pyh5EtgHGriI/sQRCnl+R84rFB1w0Drj+1Prbt8yYfzHVPdzrUev2+wMq2no6HMMaAFkqKJY/LxpSjCWJuH85GXZwMNSSgbZWWRbLdH4DMuXd38Jj6x3u2gm+hSs1WSjHpksZKblUmv5ShxhGDwlKnThKWKh0LLSsHTGQhhT0o+ZipXoCexHP/paY9ipuAJY308LSBJ/cWG4alOVB04xHdOy/eJydihs2q5Js7aysLmosGNfEdnq0XYOwfnjo5gZ5InKJgxxLEMiiJD13YOS1fMwIPI3DC4qGuPRcxujrwFpgXNEFyH3mnyRKPvpmni7WgTcDGF0G3L6Qw6gtyLcTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHuYzokZUNEKlq3ntWf1AGvfs1IU4S52rOxtnw9t43k=;
 b=FdbTE0w95OFb2qq3Ma80eaYBWI+SkQd3XfF6n9XkY9s+6OWd3KUtmL8+9XSCaHUC4lqtlH4a2Thmv9dO4sVkstX00YcKCsSRPqybYsossYU3jdFdLeSChAJGMHBIDYZ/Rey4cTTI/Bj+AfKhdPmetmwi9DXagfuPvM+bjKvNcLU=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by MN2PR18MB3558.namprd18.prod.outlook.com (2603:10b6:208:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 10:27:36 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 10:27:36 +0000
Message-ID: <5436632b-cdc8-4a55-8766-0cc2aec0b807@marvell.com>
Date: Fri, 7 Mar 2025 15:57:25 +0530
User-Agent: Mozilla Thunderbird
Subject: [PATCH v7 00/49] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
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
        dfustini@baylibre.com, David Hildenbrand <david@redhat.com>,
        Rex Nie <rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>,
        Koba Ko <kobak@nvidia.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com
References: <20250228195913.24895-1-james.morse@arm.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20250228195913.24895-1-james.morse@arm.com>
X-ClientProxiedBy: PN3PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::21) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|MN2PR18MB3558:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f1567c-2dec-4672-65ec-08dd5d62adff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTlLMG9yOW9WQ3oxRVFsS210TWNkd1JvZU9ibEtpbEtDc2pnSEFTVURKcHBm?=
 =?utf-8?B?aFNwM01JaGxXVEtaTlllZVdMSVdOTmx6ZFBDWjF6NEpjT3ovOHY1SXFzd0Rr?=
 =?utf-8?B?c3drSmxMaHdEK3FkS1VJL2pMamxTNnljZ2N1MWlxSkJlU3BJbkhNaHp6SVZi?=
 =?utf-8?B?SW1ZRkpOYUdSLzRyZE1CVFdzYmVSaGptTHh1NkMySm9OQXgyT0lWMHVzU3J1?=
 =?utf-8?B?aCtjdVlZVEFFalZ1LytqZ1RyRVNQbFpwVlhPRjdjd2dIT01ycFJia0Jxanlt?=
 =?utf-8?B?eldIQ1pSaGZML2FNRWdxRTg5ZmtRWHdmZnUrQ2U5TGt1MUF6Z2hKV055NnBZ?=
 =?utf-8?B?d1Urb25Hemo2aGYxZUhFcWVkWlVXaSs4MGlEUkJlSjd5YWRzakhMU0dZN0lW?=
 =?utf-8?B?ZnRHMkZWQ0Fvb2RCUkdhREwyNU8yek9vN3lsUnNVckJDNTRnVS9Wa2lCcW9n?=
 =?utf-8?B?TzZMVzhGZUxZYTFrc0FDL3ROckNJcE1heHNCUm9JU1JGL1BrUVpwMVBETEh0?=
 =?utf-8?B?N2E5UWVOZVBxVnlIQ2w5R1NTRVV1eWJGUU41dHVHbnpyQ3FZdGJoSHY1blhw?=
 =?utf-8?B?ZUJML0cyUjhWTDI2K0QyR1hGV0VaTWVHK1dlVklFUDJqZmVGVWpycG1YVkhT?=
 =?utf-8?B?NTlHbWw3MWwrRUFpTzc1TFptT2FKRDF6dStsZFhwQ0Z6QnZyWTNYWnRnQncr?=
 =?utf-8?B?VXVOVHQ5RFZaSW8rWVdqSXJVRnVOUjliMHltMGVkUEpscWprK001M2FBNGdK?=
 =?utf-8?B?UDV6eVVPekorWHoyR1pGYSs5cTllTzNybmZHalJEeUxJUDVyWllNSm1sZ2c3?=
 =?utf-8?B?dDc1dXpSaTF1WE9ENytVR21XNEFFWUd1eTRwQU5HRXVScXNDajJHUDRQU1Ba?=
 =?utf-8?B?SG81amZiTWd6eUh6aElrM2FIamZmczJJUXVCNWFqK1k3SHRLVlh2eHFlTWtt?=
 =?utf-8?B?NHdUVlN5RTVoYWl1S25MaW5BUm1XZ3B1cmtDRktDaDBaM1o4a3dlRHdZSGlo?=
 =?utf-8?B?K2tpMThOYVE2ajA3VDFUVDkvTkxJNGRjWkRuN2hmNk0xaTkwVDJXV2J4Z1Rv?=
 =?utf-8?B?VGROWXRsMHBRQTU0cHRKcWhKeVdxb01NVktxUmJKaC9aUWJ0dklpa0lMN1lu?=
 =?utf-8?B?SGlvQlZpVGFPNXNNSVJXRVhScEJYWFdLaXF4Umt6Z2ozRXRVQ2lScE10eUw3?=
 =?utf-8?B?MDVyd2VCN1dJRjh5WTZvbDJWNGZMeEpzTDd5dlE5Zm9Zd0VOZXQ2OWlWaytn?=
 =?utf-8?B?U1pMYXpYajVyV3YwSi9oYk5xMng5TDBtK0N0YVBEaENvSndHZ3d0ajlCTEc4?=
 =?utf-8?B?eHNXeEJLRm1VRlVJZVEvVlpnZ2pJNjlGNEQ5RnpkQ3FiR1NvTytKOGRUUElh?=
 =?utf-8?B?VXFlOENXbFNOZ2dJenFPcTQ2Q1FEUzdBSnZYZXB3WmxvNUh6cnRHWkl6NjZs?=
 =?utf-8?B?d3A4a0ZHNWhRWDgxMzk5SUNUV2RncVhwb3gvQ2JvbG9MSEZLOEZsejUxY2Fr?=
 =?utf-8?B?aHVrK2I4UkJNVDQ0UFhxZTdXY1ZQZHRxOVJuT1RYZlIrN3FnL2hkWVd1OUhq?=
 =?utf-8?B?YnFWS3NxMkFUMXlMWjBPZ3lxV2RYeDI3NUlUaWVYZkpDcnFyajdZTzQ2aUdv?=
 =?utf-8?B?RDZaTVlwUHgzZWZFcUFuNHBxRmt6TVg3eHZNS3oxSHVoNWNvOTMxdkVIVng2?=
 =?utf-8?B?ZFFlaiszOXpOR2tRbWlCMW4yU3J4NkxpYVVzNGlad2YzSDI4SjY5UzlLZVZa?=
 =?utf-8?B?M2dKL0VmZzRvWGxieDZ2eDA2Y2Z1NFAxMWVQdjlvZUp4NmRNdDhnaGkrUklV?=
 =?utf-8?B?RHVVbHJuZllVSmFSbXZEWFg0R2FBSEpWa3BlRHZiMVRCcERrUWowMk5XRkxU?=
 =?utf-8?B?RGcyZzhzRVFDZ3p4ZXdHd3Q2NXRaK3BTdVpYTHNvdnVXZkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHpHRDZIWjZDSmZOWjR6LzJ5U2c3S1JuS0llU2pzZWNydER5VkU0dDRndlA4?=
 =?utf-8?B?YzVqbHZRS0ZES1d4K3dsWVNSQVN2UWdyTkZVaU00dUVsRzJyUTFkWWw1NzJX?=
 =?utf-8?B?ZWlRdkJHdG41NTNGeEo1M3d1WGJ6U0VhNW1rd29aM1NMVC9zWnBSWnVNRklm?=
 =?utf-8?B?azFUMTYyc3BaWUFSZEMwVUd5bHpwSXlaVFEzTEJyaEZWbmtNTWd4c3lyOUJa?=
 =?utf-8?B?Q2lPaWJYNHlNbUg2aDdPcTZEL2hTeGkwdWx2YVpCUnRrZHJPbHVTdmlhVXdZ?=
 =?utf-8?B?ZHhKbkJsTGc3YVhGK0U3OHZUcS9nK1ZOODlKeG9jc3RBc2xYRi83WFFWQlRS?=
 =?utf-8?B?amwzTWFSekcxTE1VVWRtY1kxUjR6eVpsNVVDOG0rWVQ4NEozZHZmK1IxS3BE?=
 =?utf-8?B?U1FtaDh6MG54RTZYcUVJWGZxRTc3RjU2eVN4c0pOdzJ2UTRmb214UUc5YTdQ?=
 =?utf-8?B?Ty82RUI4TC9JaWpyL1RaTUNqNVB1d0hibUdMc2lRbWlmOFMyeXkrckVFVmRX?=
 =?utf-8?B?c0xlSEZDN3UvWEVKUWlFaDdoV0ZMaDRmRXZBbGg0c2ZHWFFyYURoL0FSWFZp?=
 =?utf-8?B?VWJGSVZnMi9zMjFPd3RJUHUvM2t1bU15WlVBenAvRUk3ZG1BdldFTWhaYWNB?=
 =?utf-8?B?U2RwR2hMMjAxbEFrRHJJT3BNaVZ1RzM0TW1nbDRjM2kzVHRoYnlxRkx3alpk?=
 =?utf-8?B?OW9VbktMSG1Ba1Q5OGVwVVhVL2lxUmRaNkNUNXNXcHFObWc1aGhpQWV4eTQx?=
 =?utf-8?B?dzV6SkRkVGVEZE40ZFArTHZmWDh1NE5wYkxqUW1xS0hOZzRQV1JYUlNaVjkx?=
 =?utf-8?B?UmpBbUpGWm1JNnJqVmNoQlJnamVobWU1WVdMUU5ZNXZCSkRaVWVOWlNGd3l3?=
 =?utf-8?B?NFI4Vm5uc2c2RHl2alFESnEweHNmQWNlR0I1MWk2dUlWVHNaWG94UExsazhx?=
 =?utf-8?B?VFlNTlVGVDhiWi8wL3V6aUYrTWJ6M0c2YzhHR0E0NXRNTEZWaU5Ta1dDU20x?=
 =?utf-8?B?RXQvRHFWUTZ3UkNzZktWNDJnUU8vTTRTUTdTcWVHTVM1SUM3N09kRU80eUtN?=
 =?utf-8?B?eGRlcjhQV1NXamxrME14Z0doK3VDOHdBdmF2WXZWNytGREV2NmVkMXN1MUZF?=
 =?utf-8?B?K1ZJYnlEckdGVjRseE1pR1dEY2czWnE2eTRvVzkvR2k2NEYrTGxXOTJ1dnBs?=
 =?utf-8?B?cTI3SzY2eW9UQTlZYllONEtNYnVzTVBwdENxYW00aW9GMlZvdEt3RXR5Z3F1?=
 =?utf-8?B?Y1A5cHNVTjZLTXR1N29SbXpmOEtyT1Z4cFZLdmQxaTU4czFMTjZDeENJK2VY?=
 =?utf-8?B?b1lDd05XdnE2d0ZvOFh6NkRCVkZobEwvOE5icFF6MGIwWmxHMmdCNWZxVzlw?=
 =?utf-8?B?Y083dTgxVFN1ZXNWcXZWeUd2SlR4dWlHRlY4ZUUvK24zMFdReG9HaUJaWStW?=
 =?utf-8?B?d0dWRGJDc3pGUmFhbW5vcXNldVhvU2dhMXJ0TEsvdnEyU0RiTFgvd3h1czI4?=
 =?utf-8?B?S0hkMDdtZUVTaFNmR2dpR1FvMmNJbmoyeHdvOTZtWWR2cUh5TWhwMnU2U0l1?=
 =?utf-8?B?dEtYTnVwSi9WVWRtUmZ3RjBuaTJCLzBySmx4NWpOUEgzbHRDb1p1WE1pa3B5?=
 =?utf-8?B?Z2Z1YXlTOTBySWhIWlVWa0VkRVVRbFJWQisvQ2J1VHZ6U3lGMFhScS8xVzhS?=
 =?utf-8?B?VGpqakRabkVybFEvY1BrQzlKSnYzeEtJOGlFNVpOdHRXc0ptV3h1Z2VPb1Ev?=
 =?utf-8?B?ZVk5MXFJQ0lGVjQ0ZFJVaU8rWi9NdFo1c2g5UU5YdTVWVzg0VGxaaXBnYUtt?=
 =?utf-8?B?SXcxSDAzbGVnaUZUeTVXUTFiQ3BtWGhlRktTeldjajJJbUNJQ2tBSi81VjdX?=
 =?utf-8?B?clBrWEk1QmpXRndzSnJrdE40S1B1aTdVZzF5YTBlL2pFYlRmclNMdlBXRFVs?=
 =?utf-8?B?a05aVmdacFl4UmJaSStWOVlSUmhOeWJPUFNKQWMvakl4OGRPc2JtRC9oUzJZ?=
 =?utf-8?B?dzBGWFREd3VIbWkwbGJOTnkwU2FaRi9KWWIvblFYUXU3NSs0NTZTb1ZUTVF1?=
 =?utf-8?B?ZWNFWUtVWEtBL1JxcVM2WTE0NXJQeUJsVUZiVzdlUEM4Sk1DbUloMTAxMWxp?=
 =?utf-8?Q?1qc9+7rA9mv0ldXh/NbX3smFj?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f1567c-2dec-4672-65ec-08dd5d62adff
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 10:27:36.7726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGJHGAJZzNGrow5G2HU575ViDvGDA0fUOF9DVGqWRi++045v76yHu23kl5CYacvvErh8uiuqPjK5nUA67L/oQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3558
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 7FM926smpFvDNAW5mOwVLQ0NeXXOcoPn
X-Proofpoint-ORIG-GUID: 7FM926smpFvDNAW5mOwVLQ0NeXXOcoPn
X-Authority-Analysis: v=2.4 cv=PKr1+eqC c=1 sm=1 tr=0 ts=67caca1d cx=c_pps a=MPHjzrODTC1L994aNYq1fw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=RpNjiQI2AAAA:8 a=M5GUcnROAAAA:8 a=8c-_TDe7bBhtr1Z1T3MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_04,2025-03-06_04,2024-11-22_01

Hi James,

Changes since v6?:

>   * All the excitement is in patch 37, turns out there are two rmdir() pa=
ths
>     that don't join up.
> The last eight patches are new:
>   * The python script has been replaced with the patch that it generates,=
 see
>     the bare branch below if you want to regenerate it.
>   * There have been comments on the followup to the generated patch, thos=
e are
>     included here - I suggest they be squashed into the generated patch.
>   * This version includes some checkpatch linting from Dave.
>
> ---
> This series renames functions and moves code around. With the
> exception of invalid configurations for the configurable-events, there sh=
ould
> be no changes in behaviour caused by this series. It is now possible for
> throttle_mode to report 'undefined', but no known platform will do this.
>
> The driving pattern is to make things like struct rdtgroup private to res=
ctrl.
> Features like pseudo-lock aren't going to work on arm64, the ability to d=
isable
> it at compile time is added.
>
> After this, I can start posting the MPAM driver to make use of resctrl on=
 arm64.
> (What's MPAM? See the cover letter of the first series. [1])
>
> This series is based on v6.14-rc3 and can be retrieved from:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_pub=
_scm_linux_kernel_git_morse_linux.git&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ=
&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25s=
kE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D34Q-cAJD41LWUgU21FvoSkXHOM-u=
SrOs2a1vEwaxrNE&e=3D <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A=
__git.kernel.org_pub_scm_linux_kernel_git_morse_linux.git&d=3DDwIDAg&c=3DnK=
jWec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnu=
wqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D34Q-cAJD=
41LWUgU21FvoSkXHOM-uSrOs2a1vEwaxrNE&e=3D> mpam/move_to_fs/v7
> or for those who want to regnerate the patch that moves all the code:

After rebasing mpam/snapshot/v6.14-rc1 on top of this series, Tested a=20
few MPAM controls, including Cache Portion Partitioning and Memory=20
Bandwidth Partitioning, on Marvell CN10K ARM64 platform, and It looks good.

For this patch-set:
Tested-by: amitsinght@marvell.com

> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_pub=
_scm_linux_kernel_git_morse_linux.git&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ=
&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25s=
kE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D34Q-cAJD41LWUgU21FvoSkXHOM-u=
SrOs2a1vEwaxrNE&e=3D <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A=
__git.kernel.org_pub_scm_linux_kernel_git_morse_linux.git&d=3DDwIDAg&c=3DnK=
jWec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnu=
wqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D34Q-cAJD=
41LWUgU21FvoSkXHOM-uSrOs2a1vEwaxrNE&e=3D> mpam/move_to_fs/v7_bare
>
>
> As ever - bugs welcome,
> Thanks,
>
> James
>
> [v6]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.or=
g_lkml_20250207181823.6378-2D1-2Djames.morse-40arm.com_&d=3DDwIDAg&c=3DnKjW=
ec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwq=
irfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DGiw7Cw-bCK=
cY06OE4h_CYGNmKoeW3Rnf9Ph433fTflg&e=3D <https://urldefense.proofpoint.com/v=
2/url?u=3Dhttps-3A__lore.kernel.org_lkml_20250207181823.6378-2D1-2Djames.mo=
rse-40arm.com_&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txm=
gDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSU=
BYHutdqE6Gakd1Z3I8H&s=3DGiw7Cw-bCKcY06OE4h_CYGNmKoeW3Rnf9Ph433fTflg&e=3D>
> [v5]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.or=
g_r_20241004180347.19985-2D1-2Djames.morse-40arm.com&d=3DDwIDAg&c=3DnKjWec2=
b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwqirf=
Pj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DNuPo6XsrzJWgo=
Wgnhpf5PxXdFEozS_Zgk_XBTnhAn6k&e=3D <https://urldefense.proofpoint.com/v2/u=
rl?u=3Dhttps-3A__lore.kernel.org_r_20241004180347.19985-2D1-2Djames.morse-4=
0arm.com&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-M=
bUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutd=
qE6Gakd1Z3I8H&s=3DNuPo6XsrzJWgoWgnhpf5PxXdFEozS_Zgk_XBTnhAn6k&e=3D>
> [v4]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.or=
g_all_20240802172853.22529-2D1-2Djames.morse-40arm.com_&d=3DDwIDAg&c=3DnKjW=
ec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwq=
irfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3Dx0enrBNorL=
UBSyhg_SOJl9itXA4Ht_65SifVAOpMEO4&e=3D <https://urldefense.proofpoint.com/v=
2/url?u=3Dhttps-3A__lore.kernel.org_all_20240802172853.22529-2D1-2Djames.mo=
rse-40arm.com_&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txm=
gDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSU=
BYHutdqE6Gakd1Z3I8H&s=3Dx0enrBNorLUBSyhg_SOJl9itXA4Ht_65SifVAOpMEO4&e=3D>
> [v3]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.or=
g_r_20240614150033.10454-2D1-2Djames.morse-40arm.com&d=3DDwIDAg&c=3DnKjWec2=
b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwqirf=
Pj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DFPG_ZTHC69sPw=
7sz4QOvpKZ76X7VQSTuO2yN67LY4VI&e=3D <https://urldefense.proofpoint.com/v2/u=
rl?u=3Dhttps-3A__lore.kernel.org_r_20240614150033.10454-2D1-2Djames.morse-4=
0arm.com&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-M=
bUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutd=
qE6Gakd1Z3I8H&s=3DFPG_ZTHC69sPw7sz4QOvpKZ76X7VQSTuO2yN67LY4VI&e=3D>
> [v2]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.or=
g_r_20240426150537.8094-2D1-2DDave.Martin-40arm.com&d=3DDwIDAg&c=3DnKjWec2b=
6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfP=
j-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DC--gCozXx-zNwx=
631Snz1h6SShLrm546dr0_ISKSC9A&e=3D <https://urldefense.proofpoint.com/v2/ur=
l?u=3Dhttps-3A__lore.kernel.org_r_20240426150537.8094-2D1-2DDave.Martin-40a=
rm.com&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbU=
ihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE=
6Gakd1Z3I8H&s=3DC--gCozXx-zNwx631Snz1h6SShLrm546dr0_ISKSC9A&e=3D>
> [v1]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.or=
g_r_20240321165106.31602-2D1-2Djames.morse-40arm.com&d=3DDwIDAg&c=3DnKjWec2=
b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwqirf=
Pj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D0PJ7kJsoRhwOq=
CcYwUYrJwbRM9zTssWuhqkgaqXdPNY&e=3D <https://urldefense.proofpoint.com/v2/u=
rl?u=3Dhttps-3A__lore.kernel.org_r_20240321165106.31602-2D1-2Djames.morse-4=
0arm.com&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-M=
bUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutd=
qE6Gakd1Z3I8H&s=3D0PJ7kJsoRhwOqCcYwUYrJwbRM9zTssWuhqkgaqXdPNY&e=3D>
> [1]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org=
_lkml_20201030161120.227225-2D1-2Djames.morse-40arm.com_&d=3DDwIDAg&c=3DnKj=
Wec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuw=
qirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DsYrXz5z6d=
OOGmy5Xjm0lsmdUCAN25SnhDjyq_hUSYi4&e=3D <https://urldefense.proofpoint.com/=
v2/url?u=3Dhttps-3A__lore.kernel.org_lkml_20201030161120.227225-2D1-2Djames=
.morse-40arm.com_&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6=
txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUIC=
nSUBYHutdqE6Gakd1Z3I8H&s=3DsYrXz5z6dOOGmy5Xjm0lsmdUCAN25SnhDjyq_hUSYi4&e=3D>
>
> Amit Singh Tomar (1):
>    x86/resctrl: Remove the limit on the number of CLOSID
>
> Dave Martin (3):
>    x86/resctrl: Squelch whitespace anomalies in resctrl core code
>    x86/resctrl: Prefer alloc(sizeof(*foo)) idiom in rdt_init_fs_context()
>    x86/resctrl: Relax some asm #includes
>
> James Morse (45):
>    x86/resctrl: Fix allocation of cleanest CLOSID on platforms with no
>      monitors
>    x86/resctrl: Add a helper to avoid reaching into the arch code
>      resource list
>    x86/resctrl: Remove fflags from struct rdt_resource
>    x86/resctrl: Use schema type to determine how to parse schema values
>    x86/resctrl: Use schema type to determine the schema format string
>    x86/resctrl: Remove data_width and the tabular format
>    x86/resctrl: Add max_bw to struct resctrl_membw
>    x86/resctrl: Generate default_ctrl instead of sharing it
>    x86/resctrl: Add helper for setting CPU default properties
>    x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()
>    x86/resctrl: Expose resctrl fs's init function to the rest of the
>      kernel
>    x86/resctrl: Move rdt_find_domain() to be visible to arch and fs code
>    x86/resctrl: Move resctrl types to a separate header
>    x86/resctrl: Add an arch helper to reset one resource
>    x86/resctrl: Move monitor exit work to a resctrl exit call
>    x86/resctrl: Move monitor init work to a resctrl init call
>    x86/resctrl: Rewrite and move the for_each_*_rdt_resource() walkers
>    x86/resctrl: Move the is_mbm_*_enabled() helpers to asm/resctrl.h
>    x86/resctrl: Add resctrl_arch_is_evt_configurable() to abstract BMEC
>    x86/resctrl: Change mon_event_config_{read,write}() to be arch helpers
>    x86/resctrl: Move mba_mbps_default_event init to filesystem code
>    x86/resctrl: Move mbm_cfg_mask to struct rdt_resource
>    x86/resctrl: Add resctrl_arch_ prefix to pseudo lock functions
>    x86/resctrl: Allow an architecture to disable pseudo lock
>    x86/resctrl: Make prefetch_disable_bits belong to the arch code
>    x86/resctrl: Make resctrl_arch_pseudo_lock_fn() take a plr
>    x86/resctrl: Move RFTYPE flags to be managed by resctrl
>    x86/resctrl: Handle throttle_mode for SMBA resources
>    x86/resctrl: Move get_config_index() to a header
>    x86/resctrl: Move get_{mon,ctrl}_domain_from_cpu() to live with their
>      callers
>    x86/resctrl: Rename resctrl_sched_in() to begin with "resctrl_arch_"
>    x86/resctrl: resctrl_exit() teardown resctrl but leave the mount point
>    x86/resctrl: Drop __init/__exit on assorted symbols
>    x86/resctrl: Move is_mba_sc() out of core.c
>    x86/resctrl: Add end-marker to the resctrl_event_id enum
>    x86/resctrl: Expand the width of dom_id by replacing mon_data_bits
>    x86/resctrl: Remove a newline to avoid confusing the code move script
>    x86/resctrl: Split trace.h
>    fs/resctrl: Add boiler plate for external resctrl code
>    x86/resctrl: Move the filesystem bits to headers visible to fs/resctrl
>    x86,fs/resctrl: Move the resctrl filesystem code to live in
>      /fs/resctrl
>    x86,fs/resctrl: Remove duplicated trace header files
>    fs/resctrl: Remove unnecessary includes
>    fs/resctrl: Change internal.h's header guard macros
>    x86,fs/resctrl: Move resctrl.rst to live under
>      Documentation/filesystems
>
>   Documentation/arch/x86/index.rst              |    1 -
>   Documentation/filesystems/index.rst           |    1 +
>   .../{arch/x86 =3D> filesystems}/resctrl.rst     |    0
>   MAINTAINERS                                   |    4 +-
>   arch/Kconfig                                  |    8 +
>   arch/x86/Kconfig                              |    6 +-
>   arch/x86/include/asm/resctrl.h                |   43 +-
>   arch/x86/kernel/cpu/resctrl/Makefile          |    8 +-
>   arch/x86/kernel/cpu/resctrl/core.c            |  214 +-
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  606 +--
>   arch/x86/kernel/cpu/resctrl/internal.h        |  504 +-
>   arch/x86/kernel/cpu/resctrl/monitor.c         |  863 +---
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c     | 1120 +----
>   .../resctrl/{trace.h =3D> pseudo_lock_trace.h}  |   26 +-
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 4031 +--------------
>   arch/x86/kernel/process_32.c                  |    2 +-
>   arch/x86/kernel/process_64.c                  |    2 +-
>   fs/Kconfig                                    |    1 +
>   fs/Makefile                                   |    1 +
>   fs/resctrl/Kconfig                            |   39 +
>   fs/resctrl/Makefile                           |    6 +
>   fs/resctrl/ctrlmondata.c                      |  660 +++
>   fs/resctrl/internal.h                         |  435 ++
>   fs/resctrl/monitor.c                          |  933 ++++
>   fs/resctrl/monitor_trace.h                    |   33 +
>   fs/resctrl/pseudo_lock.c                      | 1104 +++++
>   fs/resctrl/rdtgroup.c                         | 4329 +++++++++++++++++
>   include/linux/resctrl.h                       |  216 +-
>   include/linux/resctrl_types.h                 |   59 +
>   29 files changed, 7992 insertions(+), 7263 deletions(-)
>   rename Documentation/{arch/x86 =3D> filesystems}/resctrl.rst (100%)
>   rename arch/x86/kernel/cpu/resctrl/{trace.h =3D> pseudo_lock_trace.h} (=
56%)
>   create mode 100644 fs/resctrl/Kconfig
>   create mode 100644 fs/resctrl/Makefile
>   create mode 100644 fs/resctrl/ctrlmondata.c
>   create mode 100644 fs/resctrl/internal.h
>   create mode 100644 fs/resctrl/monitor.c
>   create mode 100644 fs/resctrl/monitor_trace.h
>   create mode 100644 fs/resctrl/pseudo_lock.c
>   create mode 100644 fs/resctrl/rdtgroup.c
>   create mode 100644 include/linux/resctrl_types.h
>
> --=20
> 2.39.5
>

On 3/1/2025 1:28 AM, James Morse wrote:
> Changes since v6?: * All the excitement is in patch 37, turns out=20
> there are two rmdir() paths that don't join up. The last eight patches=20
> are new: * The python script has been replaced with the patch that it=20
> generates, see the bare branch below
>=20
> Changes since v6?:
>   * All the excitement is in patch 37, turns out there are two rmdir() pa=
ths
>     that don't join up.
> The last eight patches are new:
>   * The python script has been replaced with the patch that it generates,=
 see
>     the bare branch below if you want to regenerate it.
>   * There have been comments on the followup to the generated patch, thos=
e are
>     included here - I suggest they be squashed into the generated patch.
>   * This version includes some checkpatch linting from Dave.
>
> ---
> This series renames functions and moves code around. With the
> exception of invalid configurations for the configurable-events, there sh=
ould
> be no changes in behaviour caused by this series. It is now possible for
> throttle_mode to report 'undefined', but no known platform will do this.
>
> The driving pattern is to make things like struct rdtgroup private to res=
ctrl.
> Features like pseudo-lock aren't going to work on arm64, the ability to d=
isable
> it at compile time is added.
>
> After this, I can start posting the MPAM driver to make use of resctrl on=
 arm64.
> (What's MPAM? See the cover letter of the first series. [1])
>
> This series is based on v6.14-rc3 and can be retrieved from:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_pub=
_scm_linux_kernel_git_morse_linux.git&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ=
&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25s=
kE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D34Q-cAJD41LWUgU21FvoSkXHOM-u=
SrOs2a1vEwaxrNE&e=3D <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A=
__git.kernel.org_pub_scm_linux_kernel_git_morse_linux.git&d=3DDwIDAg&c=3DnK=
jWec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnu=
wqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D34Q-cAJD=
41LWUgU21FvoSkXHOM-uSrOs2a1vEwaxrNE&e=3D> mpam/move_to_fs/v7
> or for those who want to regnerate the patch that moves all the code:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_pub=
_scm_linux_kernel_git_morse_linux.git&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ=
&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25s=
kE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D34Q-cAJD41LWUgU21FvoSkXHOM-u=
SrOs2a1vEwaxrNE&e=3D <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A=
__git.kernel.org_pub_scm_linux_kernel_git_morse_linux.git&d=3DDwIDAg&c=3DnK=
jWec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnu=
wqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D34Q-cAJD=
41LWUgU21FvoSkXHOM-uSrOs2a1vEwaxrNE&e=3D> mpam/move_to_fs/v7_bare
>
>
> As ever - bugs welcome,
> Thanks,
>
> James
>
> [v6]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.or=
g_lkml_20250207181823.6378-2D1-2Djames.morse-40arm.com_&d=3DDwIDAg&c=3DnKjW=
ec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwq=
irfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DGiw7Cw-bCK=
cY06OE4h_CYGNmKoeW3Rnf9Ph433fTflg&e=3D <https://urldefense.proofpoint.com/v=
2/url?u=3Dhttps-3A__lore.kernel.org_lkml_20250207181823.6378-2D1-2Djames.mo=
rse-40arm.com_&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txm=
gDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSU=
BYHutdqE6Gakd1Z3I8H&s=3DGiw7Cw-bCKcY06OE4h_CYGNmKoeW3Rnf9Ph433fTflg&e=3D>
> [v5]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.or=
g_r_20241004180347.19985-2D1-2Djames.morse-40arm.com&d=3DDwIDAg&c=3DnKjWec2=
b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwqirf=
Pj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DNuPo6XsrzJWgo=
Wgnhpf5PxXdFEozS_Zgk_XBTnhAn6k&e=3D <https://urldefense.proofpoint.com/v2/u=
rl?u=3Dhttps-3A__lore.kernel.org_r_20241004180347.19985-2D1-2Djames.morse-4=
0arm.com&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-M=
bUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutd=
qE6Gakd1Z3I8H&s=3DNuPo6XsrzJWgoWgnhpf5PxXdFEozS_Zgk_XBTnhAn6k&e=3D>
> [v4]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.or=
g_all_20240802172853.22529-2D1-2Djames.morse-40arm.com_&d=3DDwIDAg&c=3DnKjW=
ec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwq=
irfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3Dx0enrBNorL=
UBSyhg_SOJl9itXA4Ht_65SifVAOpMEO4&e=3D <https://urldefense.proofpoint.com/v=
2/url?u=3Dhttps-3A__lore.kernel.org_all_20240802172853.22529-2D1-2Djames.mo=
rse-40arm.com_&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txm=
gDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSU=
BYHutdqE6Gakd1Z3I8H&s=3Dx0enrBNorLUBSyhg_SOJl9itXA4Ht_65SifVAOpMEO4&e=3D>
> [v3]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.or=
g_r_20240614150033.10454-2D1-2Djames.morse-40arm.com&d=3DDwIDAg&c=3DnKjWec2=
b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwqirf=
Pj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DFPG_ZTHC69sPw=
7sz4QOvpKZ76X7VQSTuO2yN67LY4VI&e=3D <https://urldefense.proofpoint.com/v2/u=
rl?u=3Dhttps-3A__lore.kernel.org_r_20240614150033.10454-2D1-2Djames.morse-4=
0arm.com&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-M=
bUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutd=
qE6Gakd1Z3I8H&s=3DFPG_ZTHC69sPw7sz4QOvpKZ76X7VQSTuO2yN67LY4VI&e=3D>
> [v2]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.or=
g_r_20240426150537.8094-2D1-2DDave.Martin-40arm.com&d=3DDwIDAg&c=3DnKjWec2b=
6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfP=
j-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DC--gCozXx-zNwx=
631Snz1h6SShLrm546dr0_ISKSC9A&e=3D <https://urldefense.proofpoint.com/v2/ur=
l?u=3Dhttps-3A__lore.kernel.org_r_20240426150537.8094-2D1-2DDave.Martin-40a=
rm.com&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbU=
ihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE=
6Gakd1Z3I8H&s=3DC--gCozXx-zNwx631Snz1h6SShLrm546dr0_ISKSC9A&e=3D>
> [v1]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.or=
g_r_20240321165106.31602-2D1-2Djames.morse-40arm.com&d=3DDwIDAg&c=3DnKjWec2=
b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwqirf=
Pj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D0PJ7kJsoRhwOq=
CcYwUYrJwbRM9zTssWuhqkgaqXdPNY&e=3D <https://urldefense.proofpoint.com/v2/u=
rl?u=3Dhttps-3A__lore.kernel.org_r_20240321165106.31602-2D1-2Djames.morse-4=
0arm.com&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-M=
bUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutd=
qE6Gakd1Z3I8H&s=3D0PJ7kJsoRhwOqCcYwUYrJwbRM9zTssWuhqkgaqXdPNY&e=3D>
> [1]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org=
_lkml_20201030161120.227225-2D1-2Djames.morse-40arm.com_&d=3DDwIDAg&c=3DnKj=
Wec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuw=
qirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DsYrXz5z6d=
OOGmy5Xjm0lsmdUCAN25SnhDjyq_hUSYi4&e=3D <https://urldefense.proofpoint.com/=
v2/url?u=3Dhttps-3A__lore.kernel.org_lkml_20201030161120.227225-2D1-2Djames=
.morse-40arm.com_&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6=
txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUIC=
nSUBYHutdqE6Gakd1Z3I8H&s=3DsYrXz5z6dOOGmy5Xjm0lsmdUCAN25SnhDjyq_hUSYi4&e=3D>
>
> Amit Singh Tomar (1):
>    x86/resctrl: Remove the limit on the number of CLOSID
>
> Dave Martin (3):
>    x86/resctrl: Squelch whitespace anomalies in resctrl core code
>    x86/resctrl: Prefer alloc(sizeof(*foo)) idiom in rdt_init_fs_context()
>    x86/resctrl: Relax some asm #includes
>
> James Morse (45):
>    x86/resctrl: Fix allocation of cleanest CLOSID on platforms with no
>      monitors
>    x86/resctrl: Add a helper to avoid reaching into the arch code
>      resource list
>    x86/resctrl: Remove fflags from struct rdt_resource
>    x86/resctrl: Use schema type to determine how to parse schema values
>    x86/resctrl: Use schema type to determine the schema format string
>    x86/resctrl: Remove data_width and the tabular format
>    x86/resctrl: Add max_bw to struct resctrl_membw
>    x86/resctrl: Generate default_ctrl instead of sharing it
>    x86/resctrl: Add helper for setting CPU default properties
>    x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()
>    x86/resctrl: Expose resctrl fs's init function to the rest of the
>      kernel
>    x86/resctrl: Move rdt_find_domain() to be visible to arch and fs code
>    x86/resctrl: Move resctrl types to a separate header
>    x86/resctrl: Add an arch helper to reset one resource
>    x86/resctrl: Move monitor exit work to a resctrl exit call
>    x86/resctrl: Move monitor init work to a resctrl init call
>    x86/resctrl: Rewrite and move the for_each_*_rdt_resource() walkers
>    x86/resctrl: Move the is_mbm_*_enabled() helpers to asm/resctrl.h
>    x86/resctrl: Add resctrl_arch_is_evt_configurable() to abstract BMEC
>    x86/resctrl: Change mon_event_config_{read,write}() to be arch helpers
>    x86/resctrl: Move mba_mbps_default_event init to filesystem code
>    x86/resctrl: Move mbm_cfg_mask to struct rdt_resource
>    x86/resctrl: Add resctrl_arch_ prefix to pseudo lock functions
>    x86/resctrl: Allow an architecture to disable pseudo lock
>    x86/resctrl: Make prefetch_disable_bits belong to the arch code
>    x86/resctrl: Make resctrl_arch_pseudo_lock_fn() take a plr
>    x86/resctrl: Move RFTYPE flags to be managed by resctrl
>    x86/resctrl: Handle throttle_mode for SMBA resources
>    x86/resctrl: Move get_config_index() to a header
>    x86/resctrl: Move get_{mon,ctrl}_domain_from_cpu() to live with their
>      callers
>    x86/resctrl: Rename resctrl_sched_in() to begin with "resctrl_arch_"
>    x86/resctrl: resctrl_exit() teardown resctrl but leave the mount point
>    x86/resctrl: Drop __init/__exit on assorted symbols
>    x86/resctrl: Move is_mba_sc() out of core.c
>    x86/resctrl: Add end-marker to the resctrl_event_id enum
>    x86/resctrl: Expand the width of dom_id by replacing mon_data_bits
>    x86/resctrl: Remove a newline to avoid confusing the code move script
>    x86/resctrl: Split trace.h
>    fs/resctrl: Add boiler plate for external resctrl code
>    x86/resctrl: Move the filesystem bits to headers visible to fs/resctrl
>    x86,fs/resctrl: Move the resctrl filesystem code to live in
>      /fs/resctrl
>    x86,fs/resctrl: Remove duplicated trace header files
>    fs/resctrl: Remove unnecessary includes
>    fs/resctrl: Change internal.h's header guard macros
>    x86,fs/resctrl: Move resctrl.rst to live under
>      Documentation/filesystems
>
>   Documentation/arch/x86/index.rst              |    1 -
>   Documentation/filesystems/index.rst           |    1 +
>   .../{arch/x86 =3D> filesystems}/resctrl.rst     |    0
>   MAINTAINERS                                   |    4 +-
>   arch/Kconfig                                  |    8 +
>   arch/x86/Kconfig                              |    6 +-
>   arch/x86/include/asm/resctrl.h                |   43 +-
>   arch/x86/kernel/cpu/resctrl/Makefile          |    8 +-
>   arch/x86/kernel/cpu/resctrl/core.c            |  214 +-
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  606 +--
>   arch/x86/kernel/cpu/resctrl/internal.h        |  504 +-
>   arch/x86/kernel/cpu/resctrl/monitor.c         |  863 +---
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c     | 1120 +----
>   .../resctrl/{trace.h =3D> pseudo_lock_trace.h}  |   26 +-
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 4031 +--------------
>   arch/x86/kernel/process_32.c                  |    2 +-
>   arch/x86/kernel/process_64.c                  |    2 +-
>   fs/Kconfig                                    |    1 +
>   fs/Makefile                                   |    1 +
>   fs/resctrl/Kconfig                            |   39 +
>   fs/resctrl/Makefile                           |    6 +
>   fs/resctrl/ctrlmondata.c                      |  660 +++
>   fs/resctrl/internal.h                         |  435 ++
>   fs/resctrl/monitor.c                          |  933 ++++
>   fs/resctrl/monitor_trace.h                    |   33 +
>   fs/resctrl/pseudo_lock.c                      | 1104 +++++
>   fs/resctrl/rdtgroup.c                         | 4329 +++++++++++++++++
>   include/linux/resctrl.h                       |  216 +-
>   include/linux/resctrl_types.h                 |   59 +
>   29 files changed, 7992 insertions(+), 7263 deletions(-)
>   rename Documentation/{arch/x86 =3D> filesystems}/resctrl.rst (100%)
>   rename arch/x86/kernel/cpu/resctrl/{trace.h =3D> pseudo_lock_trace.h} (=
56%)
>   create mode 100644 fs/resctrl/Kconfig
>   create mode 100644 fs/resctrl/Makefile
>   create mode 100644 fs/resctrl/ctrlmondata.c
>   create mode 100644 fs/resctrl/internal.h
>   create mode 100644 fs/resctrl/monitor.c
>   create mode 100644 fs/resctrl/monitor_trace.h
>   create mode 100644 fs/resctrl/pseudo_lock.c
>   create mode 100644 fs/resctrl/rdtgroup.c
>   create mode 100644 include/linux/resctrl_types.h
>
> --=20
> 2.39.5
>

