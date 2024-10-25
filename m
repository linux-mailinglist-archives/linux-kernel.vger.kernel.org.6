Return-Path: <linux-kernel+bounces-381086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD4E9AFA2C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFD0282883
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D831A3AB9;
	Fri, 25 Oct 2024 06:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kLTnQO+2"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3182018F2F7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729838341; cv=fail; b=FtfHkTuGWu5yW6UTimAHSIZWca2v2wogKD9SjtPc6wz79NQwGvRd0FWMd+fTkFI+4tf3vXfnc4lC3XLjU0KaS79muyDZ+tWd/a74K9dqZNKHF25XubAEXrxA50zARRfgS/fVE6CjSbsNPR0c43aSC1GeHjoutoFsGq3bUgMHfIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729838341; c=relaxed/simple;
	bh=lJzzOdj0jriBPTcLgJaAhSVv5/32vz6qaO8Z5K+KbeY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g06g6WQ/SMqVY7AhNTIOBWkonM0zP97SLQACsrJmzPQPwEaNber622fpSRj66mWb2+C01cdE0nnU/9dzTQ4SsIIhDz/Xb62B/mu+C/l3UI3OMEvlKYbjOdd9xmnKy+yU1CID1txQs7tau9/5REszSoPN0o7wzKDc8IMQefNOKRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kLTnQO+2; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDK8PYKgUuVxcsiWft4Jo1dC8T4c0ZSAgen1r4FS/zMN3v30IXMiKiCE1vG+F0BN4zC5Hn5lnyKVKLM3XslybupScD8qwk3PTX/hheXhgXT+4bVhVenjxSzSBVUawJhxZHdqniSHrctWP6v718xdqnDcjTzd2bI2y7b0+oSUjiY9Xp00XgtfcAgdtg5TpXBWVr2q2oboFzDytHuFMc5fYaMSJyk9xb3RzNu+1pet46akBGP/M1+RGkhfUf2idVzSaov47kRjQZK8bT8iyDdken2TbhTAHAzDHG+i/KosIQLE1o4Ax/EKTNrOPr5Y/kJlt97v5yLOaRNsuf8gI5hwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kFtl8iC2PQgTTH07eD8Kfj+LQY/f/Zb7+I2l2lixbY=;
 b=yw++Ptt+syZRPEfb5L5BOe9PTKV8KJ1L6YE5a84VFfYVqsyavQrgVA4yZtLY1/M6LzNKSlLklZ6zYwQxn9zFAEDPSRF4g0bLUgHPt1HYF+pWE8/QkRwXQfKJQM42aZai+CCSOUHsnoH17sGWbW66ywxC75u3AkQhQWMK8cJhcNOx3KGK5g15gN6J82oGFsMYz509f1BrcFYwA4i+5XWe+yWUs+EgMDPxLVcKbnNt8LbJzKgMnTBJ0RRPutz+Ev2sfde0ttZTXP1QVNw5f3rSEvuZSaIA6caOXTq3UTHLYVtWuyLTPBWQJXESNEAN88p4qVWgWbnYktFLj6ofGCF0UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kFtl8iC2PQgTTH07eD8Kfj+LQY/f/Zb7+I2l2lixbY=;
 b=kLTnQO+22Q1eARzZQ5MkaLswDHW9To70lKa35lfSWk928oqpHmut0gm4wew+2/6r40EMvceCAWENyV2WBIW0fiyNN2i6Xh1qcXao0v4cLpC8pWsgpiUdy7iIPS/xO5td7JV5dNcAHhV4EDeuC+9WHg921TI7/fmsmjz24qsr15I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 SN7PR12MB7322.namprd12.prod.outlook.com (2603:10b6:806:299::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Fri, 25 Oct 2024 06:38:53 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec%4]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 06:38:53 +0000
Message-ID: <19381c3e-e2d3-9c99-f687-a4fe2d1096cf@amd.com>
Date: Fri, 25 Oct 2024 12:08:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 0/8] Provide support for RMPREAD and a segmented RMP
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <cover.1729708922.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::33) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|SN7PR12MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e5619c8-6057-4ffd-4638-08dcf4bfb13e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L091SjlHT0I0VU1id0ZISGQwRU1sRmdGR0xqNDhaQ0s3V0FaWjFiQkJPYzdM?=
 =?utf-8?B?Q3dGTWM5ZXFNVkc2aHpkTFFOcHdWczROSzIxV1JRY3U2ajJoUk43c2FjZkZ1?=
 =?utf-8?B?RGJJaXh4V3lPUUgxQW9WSWF1NFBPem1mcU1WOC9hdmNueVhYb3lRTGE3MUli?=
 =?utf-8?B?aEtibGk5NzVnM1hBaStqQllXekQ1THBybmxtcWJQVVN2QW9DbDdxUDhvL0w4?=
 =?utf-8?B?WDlkMmxsRFlGbk1EaTY1T0hhY1FlMFRWeUp4N1NPdm9rMnovdit5WkNJTW8w?=
 =?utf-8?B?Wm5lK28va0pDYjhXWndIMGJDQVI3YlRlSWtnYjQva0RDa2NLV0FMQkpibDRi?=
 =?utf-8?B?bjEvbGxuVGpucFRmQ1ZIVTlidU55ZjBlMk9EN05MQUcyNWxKYktZeHMxckV5?=
 =?utf-8?B?ck5MSk1UVitORUJOWE1SM2QxMXhVMGcxZkN0NzdaZHZoUTNWaEZndDFzNlRW?=
 =?utf-8?B?NE1UNUpRVGdRQVJQVS9NOEtDdm9DMEszdXBQNy94YlhvSlBiMTJ2Vk5vdCtu?=
 =?utf-8?B?QmtVa0x2YitZRmowWGVsMXZJUXhaYm43djVxUVI2NzRUNjVVbUptV0tDTGhL?=
 =?utf-8?B?Ty9zeGlkM0hLdUg5UVlpS25UWkZGZkFpbHBuWUZTRjRYbG0rUHA3OFB0eWhY?=
 =?utf-8?B?cnQwNlYyYUFzeFVKT2JMYURVd0dDbmhNeFRwbm04VEhKVkwxb0NIcjd1bmcy?=
 =?utf-8?B?WXhsVUFpQ0hXWnc3OWE0QjNHVGkxQkdrcDZmOWFyY25LdWdEVy95MG1taW9a?=
 =?utf-8?B?bk9PdjRYT21uYi9peXR1L094OFFyakpnaVhYMEs1eVU0SXY4ZXFyc1ViTmlD?=
 =?utf-8?B?RFowc29zSzdTT0NRdUUvbm93Vm9JSlF2ZU12MnlsOUZOUUZtdVNkQnJsbHpU?=
 =?utf-8?B?dXV4ZHYrSjd0c3p2SEYvNld6TDBBMU4wTGNUOVdNd3lxN1VnTEw5L0JVdTB2?=
 =?utf-8?B?a1NHY0dsRzhMN01Wand6ZmFYWkw3THJIa2U0djFkNDY5c1NZdzVuTlJKa2p5?=
 =?utf-8?B?S2owOThrR3Jhbjg2OURtaCtWMTBrYUF3aXViRVRnakF1WU1aSVVRMnI5NGZG?=
 =?utf-8?B?ZDlZdDhZRDRRYUJlb2h4YjkxUXRneWlqbzRUWFpXcGxFSFgrSkMwNkxNSlhU?=
 =?utf-8?B?UDd1cDY1L0J3T3BYUzRJMHIxSHlqbDYwSC9qc0tURHpOQ3oxM2xtcThLQVRV?=
 =?utf-8?B?cGpxbUtqMWxFNHJoWTVmemVtUE8zbzlKaGNHZ09SVk4wOTd3YU0yNldOYVcr?=
 =?utf-8?B?c0xTYmlCSGFwRXBhT0d6ZVJIMzZ5ekhtdlVvcTdvZkNSMVd0ekpEWHhIaGxC?=
 =?utf-8?B?QUprVHFTZTBEMXE2bUl3cElhYVRjNDJBMm5SbkZKQk14L21BZVZDUDZPMTlu?=
 =?utf-8?B?ZzAwTkRwemJzSytFaFd3Z1ZuV3JKMGR0T1p1VHdVYnlEVVYwMXhTTEYzZ00y?=
 =?utf-8?B?UjR5cWZUYTgzQlhHdWdSSlpuMDVmamZ3YkJLNXprL0JqU2xCNVNxalFmakhB?=
 =?utf-8?B?TWJZRWlBMytmZTA1N0E3K0REeWFGc0Y2VVhxSDZuVDdkOGJRV3Vkb2YrQUVj?=
 =?utf-8?B?QnZqaXRLSHhHUGZmY2duUllrN2lKZTgwYnlUUlEyQWQvaVlWa1hMU1IvVDVy?=
 =?utf-8?B?OWZJVUFyKzJpL25JYktlamFZQWo4UlVSeGVKblBoZm81TElCYmV0VVJtR053?=
 =?utf-8?B?aU1pS1luMGptRnFoQm55ampPdkM4NkZDQ1BLZWtaWUxlOUI1eU10V3JkVGEx?=
 =?utf-8?Q?MpKegZupO6lMO2dftSfNXITt5q60US6L4YsUfVh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3hWUUx4Z2w0TmJtOFQ3L1FTdml1ZEY1aVl4Yi9ISFJ4U0lJdjFJVXljemky?=
 =?utf-8?B?QUpCU3M2eVVrQmVyNnhoRFg3ZzAyMS9mY1Y3c3dsazcybjVwRUFXci9HRmhK?=
 =?utf-8?B?NGhMOThBRnN5VW1UbnczQXZmNnhoakJlcXdFTzN1cFhvZGpYL3pEdlBCMU5D?=
 =?utf-8?B?MFkyUFp1dzlPRFVqSG9xdmY1eTVkR3Bka1F1VE1pN3ZITHF0dm5Ga2dHS1NQ?=
 =?utf-8?B?eDMwRmhKdW52bEZ5RFdMYlltWE1ibVo4a24zRERSWENHbFdtZGNlbmNhRVFY?=
 =?utf-8?B?clRqWll1ODgzVVNXTkdQQmlQUXdwVU9IaVRGTG1VQVBHRk5QejZMNHhidzNk?=
 =?utf-8?B?eXB3MGo4L2VqUUNOdFJ5NFRYMmtiTXNYT1JmRjNpc1pocmtDbVdXMWFHSFdP?=
 =?utf-8?B?SnhZMitVRmFCa1JzR3BPNHZHUXoyK3F6dDh5aThBczZEZkU0eDNvNlZGY0Fo?=
 =?utf-8?B?T2ZoblZsWUFiblgzQ3F4bm02ZVJzaGozSGNoT01EQ2pJWi9NUCtPcVBXWlB2?=
 =?utf-8?B?U2FqNkdyRi9Sc0VCbzZQc2I2dTNhK0x6NTVUT2VHNVJvdXpZZDY2TVloRjBm?=
 =?utf-8?B?YzQ2bjZEYnlJOEl1Y0pSOFJzV0RxeEhiWGRHQkp0UG9KTHBSS3FMTUlRUzNB?=
 =?utf-8?B?aFNYbERqakJlRkZvS1RqTmwrc0xXU1JTOXRuODdIaXhpQXAwQW9DUm8yUDNU?=
 =?utf-8?B?MmxJWm9CVVpkanVWOWtiYi8zUUpOcGE0NFFMZkNzOG9xRHg2QWk3SmdocEM2?=
 =?utf-8?B?RkZCK2xhSFU2WFhQZ1pqOGk4RC9CaSsvNkZmMEI4cE5BLzZINlFBYTBnb2t5?=
 =?utf-8?B?ck9xWEc4RUZmWloxZlpPSGNBU0ZwNmtPS2s5YnVlUXdYa3pudWJQU3NEcSs0?=
 =?utf-8?B?R1VGbGNSalhEenBPNFFVOVJMdzlvZytzT3Z4aHYwUmJMMlJCbU11YW0ra0ky?=
 =?utf-8?B?bk55eVZ6N3NXdEp4VlpEbDlqNzVxQS8vRklnZjJoSzJ1SmN2YnZvalJXZ0Ft?=
 =?utf-8?B?VWVjYmF2cjVIbW9oUkpTT1pXVDl6WStOdFpuVGEzQzNHOHJlOVlBU1NheGsw?=
 =?utf-8?B?OEc0MnFJNFZraFRpNzVDU3crQ3VpVXZNek9WYkY0Zm16M2JUcXV5bFd0MzJh?=
 =?utf-8?B?Wk9EOWF4d09CMzJTR25pTkFBc2xTR3dNdmFvUUpPbEhKNGpCK1Eydzc1TWR0?=
 =?utf-8?B?TGJ2VWtMNHRQN0E1QUorbDZESG51UVJoNmJNaGRWaU12L2E1WUNDcEtOS25B?=
 =?utf-8?B?ZERubGk1a05jMkV1VjBYWUQxMm0zSGY2M2tocEZSMExaTldWOTVpc3dpTnJR?=
 =?utf-8?B?L1lpdGdjRHJvRFVDLzB3dmFubnpLak8vazFJZEpsNE1RcGtQQ3dXbXo0ZzlY?=
 =?utf-8?B?V29jcXhXUFhtOEFvY0ZvaS8vMEc1bzI3d01YSUcxUHNTRStPellSamo3QVdr?=
 =?utf-8?B?NGJIVS9rUU9WYi9jSmVCYXdDeVlERUFEZzhPSmZ0ZitqZDVrTEE5ZnpCcG91?=
 =?utf-8?B?VG9vSGFPNUc3NjVoTytMdUltbHNpT3BPanM2TGQydDkxSnVtOEpNcm8zUGpH?=
 =?utf-8?B?MUx6U3dqcjk4SG9HRXh5ZVY1UG8yckVWSDB6VHU1T0dlMUlkczF5MHVIQTE4?=
 =?utf-8?B?bGxielBrOUszbmJjMU9pMlRTSU9qTFV3aUtNcXRCalVDT3d1VDVrejlJSUtZ?=
 =?utf-8?B?UTVRdDZ3VDJiUzQzWmJGYzRmODZMQnpOaERYbXZydFRJc3JFOVVSN2NLa1VY?=
 =?utf-8?B?cU1rVS9Ba3pBRWdtUDNMM3NLQWxXRk00TGlsQUFHUkhPdnV5TWFCcVdqeVlF?=
 =?utf-8?B?VW5lNkM3OXNVQjRQZS90VW15c3JPdW56SmtWNkJrNDl5SXpSVytmOHUrNG9B?=
 =?utf-8?B?cGJsSmNVclMrdVphMjdZdHhzRXB5aGFyVjNJcmE1aEN2d2NySmhYUFk1ZEYr?=
 =?utf-8?B?T1lGb01lbnRWa2FMZGNieVFoaE1KRmxwamcrUjZYL25Vb1N5di9HSjRJWWNP?=
 =?utf-8?B?ZFBBM0N0UXRucFkyakR6MUpGcHA5cHBHcU9UYWtNYU13ZXdYWjAyaFZWWCts?=
 =?utf-8?B?cFMvTjRtQjJEKzE4bFM3aHQrNWpaK056cE5teUVTRFlpZXZRVjJWM3dGYjZI?=
 =?utf-8?Q?tX2TX2EEwVIVf05AtA/FQ9aWv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5619c8-6057-4ffd-4638-08dcf4bfb13e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 06:38:53.2853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tk5/uZDEzC4pPg5RmC1SYz9c3Ebo3VkjWg3U5P2GO+S9lzq2r3fec0EGmXR2Lpr/KOt97Phbvf1hRnzkPMdZWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7322



On 10/24/2024 12:11 AM, Tom Lendacky wrote:
> This series adds SEV-SNP support for a new instruction to read an RMP
> entry and for a segmented RMP table.
> 
> The RMPREAD instruction is used to return information related to an RMP
> entry in an architecturally defined format.
> 
> RMPREAD support is detected via CPUID 0x8000001f_EAX[21].
> 
> Segmented RMP support is a new way of representing the layout of an RMP
> table. Initial RMP table support required the RMP table to be contiguous
> in memory. RMP accesses from a NUMA node on which the RMP doesn't reside
> can take longer than accesses from a NUMA node on which the RMP resides.
> Segmented RMP support allows the RMP entries to be located on the same
> node as the memory the RMP is covering, potentially reducing latency
> associated with accessing an RMP entry associated with the memory. Each
> RMP segment covers a specific range of system physical addresses.
> 
> Segmented RMP support is detected and established via CPUID and MSRs.
> 
> CPUID:
>   - 0x8000001f_EAX[23]
>     - Indicates support for segmented RMP
> 
>   - 0x80000025_EAX
>     - [5:0]   : Minimum supported RMP segment size
>     - [11:6]  : Maximum supported RMP segment size
> 
>   - 0x80000025_EBX
>     - [9:0]   : Number of cacheable RMP segment definitions
>     - [10]    : Indicates if the number of cacheable RMP segments is
>                 a hard limit
> 
> MSR:
>   - 0xc0010132 (RMP_BASE)
>     - Is identical to current RMP support
> 
>   - 0xc0010133 (RMP_END)
>     - Should be in reset state if segmented RMP support is active
> 
>       For kernels that do not support segmented RMP, being in reset
>       state allows the kernel to disable SNP support if the non-segmented
>       RMP has not been allocated.
> 
>   - 0xc0010136 (RMP_CFG)
>     - [0]    : Indicates if segmented RMP is enabled
>     - [13:8] : Contains the size of memory covered by an RMP segment
>                (expressed as a power of 2)
> 
> The RMP segment size defined in the RMP_CFG MSR applies to all segments
> of the RMP. Therefore each RMP segment covers a specific range of system
> physical addresses. For example, if the RMP_CFG MSR value is 0x2401, then
> the RMP segment coverage value is 0x24 => 36, meaning the size of memory
> covered by an RMP segment is 64GB (1 << 36). So the first RMP segment
> covers physical addresses from 0 to 0xF_FFFF_FFFF, the second RMP segment
> covers physical addresses from 0x10_0000_0000 to 0x1F_FFFF_FFFF, etc.
> 
> When a segmented RMP is enabled, RMP_BASE points to the RMP bookkeeping
> area as it does today (16K in size). However, instead of RMP entries
> beginning immediately after the bookkeeping area, there is a 4K RMP
> segment table. Each entry in the table is 8-bytes in size:
> 
>   - [19:0]  : Mapped size (in GB)
>               The mapped size can be less than the defined segment size.
>               A value of zero, indicates that no RMP exists for the range
>               of system physical addresses associated with this segment.
>     [51:20] : Segment physical address
>               This address is left shift 20-bits (or just masked when
>               read) to form the physical address of the segment (1MB
>               alignment).
> 
> The series is based off of and tested against the tip tree:
>   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
> 
>   94559bac4d40 ("Merge branch into tip/master: 'x86/sev'")
> 
> ---
> 
> Changes in v4:
> - Change the structure name of the newly introduced RMPREAD state data
>   to rmpread, to avoid churn around the renaming of the old rmpentry
>   structure.
> - Change the fam19h check to be explicit ZEN3/ZEN4 checks
> - Unify the use of u64 for RMP-related values instead of using a mix of
>   u64 and unsigned long.
> - Fix the RMP segment end calculation in __snp_fixup_e820_tables().
> - Minor message cleanups and code simplifications.
> 
> Changes in v3:
> - Added RMP documentation
> 
> Changes in v2:
> - Remove the self-describing check. The SEV firmware will ensure that
>   all RMP segments are covered by RMP entries.
> - Do not include RMP segments above maximum detected RAM address (64-bit
>   MMIO) in the system RAM coverage check.
> - Adjust new CPUID feature entries to match the change to how they are
>   or are not presented to userspace.
> 
> 
> Tom Lendacky (8):
>   x86/sev: Prepare for using the RMPREAD instruction to access the RMP
>   x86/sev: Add support for the RMPREAD instruction
>   x86/sev: Require the RMPREAD instruction after Zen4
>   x86/sev: Move the SNP probe routine out of the way
>   x86/sev: Map only the RMP table entries instead of the full RMP range
>   x86/sev: Treat the contiguous RMP table as a single RMP segment
>   x86/sev: Add full support for a segmented RMP table
>   x86/sev/docs: Document the SNP Reverse Map Table (RMP)
> 
>  .../arch/x86/amd-memory-encryption.rst        | 118 ++++
>  arch/x86/include/asm/cpufeatures.h            |   2 +
>  arch/x86/include/asm/msr-index.h              |   8 +-
>  arch/x86/kernel/cpu/amd.c                     |   9 +-
>  arch/x86/virt/svm/sev.c                       | 632 +++++++++++++++---
>  5 files changed, 675 insertions(+), 94 deletions(-)
> 

For the series:

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>

Regards,
Nikunj

