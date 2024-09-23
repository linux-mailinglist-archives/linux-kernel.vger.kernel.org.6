Return-Path: <linux-kernel+bounces-335965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D9E97ED41
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B5A5B218FB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC0919CC35;
	Mon, 23 Sep 2024 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uKZqj+n6"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8973B433D6;
	Mon, 23 Sep 2024 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727102237; cv=fail; b=BTvAXMwqPzXD5QaHlRIwNNx9cgnXtfVHoms1vO9d2iRYeuOyhKYtnv5u+HUkjph1IfJwxKLLGVA3Ho/rYsubuqxgCqDKB4wa5sXSYgyTmmZ0BHr6u0oM7IsbTcw9X9dWPnABAmoVBNYXhFr0pJeoHvN8w9yXWDz2sPPcxqMwLUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727102237; c=relaxed/simple;
	bh=vXGmP0UEpd6Zppi6eW+y4j8mwTGKOMnyhQw1/+APXSE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pZlwIfYGoZouR7CkOgPf9KHahc2O3QzWoGgnhKiPKcuWuFrnVwir2SPaV/Lc0DrRL1XP5UJ7f+KNbGidXB6vlKsxmfkQK6jEjh//ckMfOwhJqsc2gdDAa3nkRoMXEw4jext0s6MCq9opTDojzHqx0olWzfg/ZBNfPEjtGUQK+vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uKZqj+n6; arc=fail smtp.client-ip=40.107.96.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImqrADIRx4wkOBXV6N3G83MBJuNWM6j4xmqC3mDoE2Ll+n/aYtWL/iKa0OyaXzmGeTQV8oQUYoyQNVBGZnJ/wGA3xjkHlo3rBs6sn4wRmEipFu9cm6yHQlbt6+IekG4wC71cQJZpNvGszJ5W9dHgGRfFNGCjgPfePhXMVYmLbwfJ1Jxlagz0SNl553+ffvqanNeN5UG7yrBb7FWfaLSjLhxJtdB8OmWmMDy40oCjrS28QFsUZTjPUGPBVEwQP7MgPzOU60IPQVzOkiZihvvvMVQjrp2NkZy1Jo7/fOYC/MlTiy++snGprQ0CcvFDNc7UFQQx4Ftw69JJrg/npW55/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdiUyh+PRlkHVEitKAniL5/BzKZmFbUVjG+eRXMdEZU=;
 b=LcJ/i4aY37eRdnycZw5bk3cwpw0g8S4P9B11zjPR4pGLBBeoKBVlSyAfofknGJ1QaES5LzQqMNNWT/qJt664SEzn98eTPoGtGyRZil803di3Df89nb2/LZKLlj8PmQUNcGJsp0Q56PR9aAp6CZq4gzQkCZuSeNUHCzsZzs0t3cJurv5DZhVAip2TzIzVvR8JoNjcI46/DbYc/gD0Dtt25w0/i+y59F3azvB86Ua3mi3Cuc7198w87xIx+wZXwrHOhg9r2hNMk29cyhKJXydY25MUhhQlvgotUyYbSVxLpN/HeQ0EZ8i374JZqPYpo9qAYwCEgUSh5XMupsmXPYXnDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdiUyh+PRlkHVEitKAniL5/BzKZmFbUVjG+eRXMdEZU=;
 b=uKZqj+n64NpcviJBwbC51dKPN+GvAherInSoLs3rhKupEVpUZTg38usqGURmnWxn5s4pzprkcADlugTB5dzXd9zyLU0j9zouf+O/ZB6HrAje6+ZRizfNFkdP/YZUTETb5nfZ1jh837NVEI8Ke0D/X4NOHqlw4IxOo3pxa835tK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL3PR12MB6524.namprd12.prod.outlook.com (2603:10b6:208:38c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Mon, 23 Sep
 2024 14:37:11 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 14:37:10 +0000
Message-ID: <3febc790-8d80-4029-b804-7428585cd4e4@amd.com>
Date: Mon, 23 Sep 2024 09:37:05 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 04/24] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <01aa73f659a24b5c54b5104f1c35c32dd06c3376.1725488488.git.babu.moger@amd.com>
 <62813c04-c247-44cd-a604-9b5f9a3e9453@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <62813c04-c247-44cd-a604-9b5f9a3e9453@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL3PR12MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: a24677d6-4c26-426e-7574-08dcdbdd350f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2NuVEplOC94YUhOSGhSbTU5T3dwS09ScUNqSmZZRjFVc1ZheERWR09nOW1W?=
 =?utf-8?B?UTlkMTlxalBQVlBzZXg2N09WY1RueGUyWURjNFlscjMxcVZ1MnVnK2ZzY0xh?=
 =?utf-8?B?ZGp0ZWhSOGFSZnl2QktueFI5UEc2d2RVUmhVbjdWaE9oQWhXQXVKWXY5dVUw?=
 =?utf-8?B?d1dUT3AvOXJqTjJ4VmtkaElRbk1ISm1ZelJVUWtLTnplSWVUaytQOVVMV1lS?=
 =?utf-8?B?ckNtRW1oYlR0VTg5STJ1U1RWUXNOZ2NvcFhCTzdpVG1sTGNaNUVORk85LzVl?=
 =?utf-8?B?NjUxQVdmaFlwS0h4NDFSN1NsZExEOGVnUHpwbUo2cjRiV2RTeGRsYVNhdkxy?=
 =?utf-8?B?a2I5bVd1UUU2cmplOFlDdDMzb1p0WUpjUGFqVnRxRUgxT3NBendSczZibDFr?=
 =?utf-8?B?UHlSV3ZEY1h5bHFINm5PaTRoMVBKMlViSzh0cTVMQXlxdjlpODlsMmRCT1h6?=
 =?utf-8?B?Nm1Id2d3MS9BekM0N2x5eCsrcW9IRjhxRCsyQzJSenZzY0NrcHErYUtvOEIv?=
 =?utf-8?B?SzlqbGN1VVE1YjNhV3J3djZmQzgxMVlOcFFlL0w2NW5mVGZxeFA4UlJHUms2?=
 =?utf-8?B?QllnWThTYXc3T0RmOGtlR21mLys2OVB3WnN2dFhycDhWRGtLdnMwbTBnZFVR?=
 =?utf-8?B?ZEQzOU9qOWJmc0kzY2N3RlBvS3lOVnN0cjZnM3pHNG9ZS2hyTE04NkJJaE5X?=
 =?utf-8?B?bUc5b0ZMWmdJZzl3QXY3c2hndkZEN2hYVVFYaWIvVXpPc1BCWlR5dlV3d3BU?=
 =?utf-8?B?SVNXMlZXU0pZZmc0QnZMNUdkUEZkcTA2YnFWbjlyTnJxdG1ISy9uUHdlS2Za?=
 =?utf-8?B?VnJaVmZqQjc5NVJXellBMmRCYXBsWWVoSXpWL1kyNEx3TjZQSXN6YWJsWjJB?=
 =?utf-8?B?bkV5TmxqenBycTNQQjNaOU1rOXloc2JpUTRpMmlIcGlFSXNLUHp2RXFiTlJi?=
 =?utf-8?B?VzlrK1kxZVkrVTd5bXVtSVRjekl2K3poaU1KbWNDdWRiSmZGdkNkTGpRZnl4?=
 =?utf-8?B?THkvaWdDQ0pDeUtMdXRQM2pLcGwwSWVnWXJBNDN3bGo0Qnh4aGJ3bXp2RnB1?=
 =?utf-8?B?dFNYc2JHN0RIaUpib2UxS3diaDRSM09pU3FoTmN0ZDdRb3ByaURBdURPdkFr?=
 =?utf-8?B?SVhRWWV3VnFpallaU3B3OTFlQkxPYVZCZDl1R3NVdjh1Qi9sZm5WdWNtOTdh?=
 =?utf-8?B?TWRic1VTVkQ3Rkg1QWJ1TElxZThJZ2JsM0NXai9RSWdmZmxMVHNDazdHQzVL?=
 =?utf-8?B?eUtlZEQ1UTNBTXh4cTJxOTlyUXdETjhXb2ZwRGk4RjQveFlZZGtHTWxkejM0?=
 =?utf-8?B?R2pxTG5LWHBGZ0dIZ1BtL1kzTzRYdG9xTFI3UDFycTIwK3lOZ0VKUGdvNTI2?=
 =?utf-8?B?dlZ6V0NRS0s1amNORUl1OTlnWGl2S1ppK09WOUtBOTgrQVBkUTFrZlVDSThZ?=
 =?utf-8?B?bjJOQlNDYjA2akFFMG5CVjM5bFErdmdBM3FmVUFOVUlBVEhyL1VlUVlZbUxN?=
 =?utf-8?B?QVJEN1dESTNGcXV2bGpLN1JYcW1wb29vWmxSZjhrWC9wa0JjRFduUmRLZTFQ?=
 =?utf-8?B?dWlkbU9QcWFjYk14anRGeHYrN1JrRXB0UWZheWlwQ2hOdEUxQUd0RkVnQ3RY?=
 =?utf-8?B?Q1hSY0Y0ejFPWlpqUkpTYWp2bHBUQTBFOTRFSXYrZFR0MFlzN2RsYTFsT0du?=
 =?utf-8?B?MStCVU5BVHhrTzVpOFo4NTY0bVlPNkdSY2RvQXNMZFRkMTQxLzMwWGh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L05yM3FmTVJta3I0ZXR3QmdXVHlESFljMDZzTklXaTVKMHNHaGJCaytIVTNz?=
 =?utf-8?B?SjQrenFNV0ZTYzJkSjJNNWJ5OXRuNmRnSkRkUFlBL3o2MWlBTWJzZzdZWWRp?=
 =?utf-8?B?RlpmVk9LdFkrR0huL0VRNGVkaUZCUlBVaS9hVFdiUEJuS3ZFZzJNdHZiZHZ2?=
 =?utf-8?B?bW52Mzg5UjFiQkpoWGY0Q0tZUWFZT1pjR2ZVc0p5SVEzZ1dyVnZpeW1OR0N5?=
 =?utf-8?B?V0lWeHIxQytjMEFOc0Nkb1RtZTBNdFlpdVNkeFU3SG9SRWdqSnFHOTlVaG9Q?=
 =?utf-8?B?dVFMcEZlcTlQU2dnYTk4amwvRG5sNjdsZThrell5Q2J0aFJnQUFoaCsyMko1?=
 =?utf-8?B?TEJlWSs1dUZzUnllWXl5Mnc4bU1FbG81R3BCcFVXQXE1YVB4OG41RlRrbyth?=
 =?utf-8?B?eEdJZVhwMVRDVStUaVlHdnBadmlQRXNOVVVhV0lMUi9lUFJ0WXVzKzU0ZktU?=
 =?utf-8?B?VGpVQ1A0eGRHQ0x0emJqMnVsSEZ2RDQwT3UyYUIvN1c1Zkt4cG5nMTczQnBB?=
 =?utf-8?B?MHFiTkZzOEJrZ0VLM1Eyc21nK3BrQkpXeWtScE1tZmk1TjJoR2ZiT2lqYlh4?=
 =?utf-8?B?RE9rOVI0bTNxSXNrRzlFdlFOdDNKaW1GamcxTDN2N3lUWFFac3JvaVBVV0NF?=
 =?utf-8?B?dFQ2eWhmbjlMcThoc3piTVhJRlJUU0oxM0U1SG1JNFF0UjUvNjM0bWRFaTR4?=
 =?utf-8?B?TFNlbDRMMDVoZTFsaEJTNVI0bUc5TCs5Zm5uQVMxbzhISXJ5VE43NzZOUEk0?=
 =?utf-8?B?ZTVrckNuOFRNaGk2bDhmVGkrR3RGN3BkVUZlamtRWDJvUVNhWCtSaER5Ukt2?=
 =?utf-8?B?UDNZdlNPdzRtUGNjUU9TR3FOci9FM2N6L1ROclZRak1FN3hyQUdFN3RxbEtO?=
 =?utf-8?B?TkQ2QWx5Q1phaFdzYTNQdllqdmh3RVB3cVhPakpvT1VIc2lxM284dVB3RGcy?=
 =?utf-8?B?Tm44V3BDVE4rVjM0S3A2WFZmbzE1OHMzN3g4c1YwN1hEeDNYcTJoZVBndFFn?=
 =?utf-8?B?ZXZyZDFSYkdDR2hZKzBoYkxGdkpzSXo0ZXhBQ1M1K2Fyb2FjQ0M4MDdyTnVq?=
 =?utf-8?B?ZndocytJRFJqSTB3SGdnK3Zzeit2QkVWTS9Pa0tHM1Njd2R0OWEyTDIwNzZ2?=
 =?utf-8?B?MzJvejZOTlZQZFdhWm4wWFZzZE1kL2pGdjJjWTNWRHZPVzkvY3J5WWtwRGJj?=
 =?utf-8?B?dFM2bFp6N05ka0E5c01taklaMEFzaWJDMkZ5TEhXWE9qVU43RGNyQWhyV293?=
 =?utf-8?B?Y1dZeGtaODRTMkx2d1RrWGppYzdCZ1M4U3ZmSU41Q3RyQlNqZ0ViY1JMZXM4?=
 =?utf-8?B?Wm1ueDFPS0hUbENvR2JXUDVwQ0hyNThBZ1FmL2U4VVdpVHQwUm5WRGxWK3Nk?=
 =?utf-8?B?RU8vWmhHYTdCWURKZ0krMndNeUo1ZC90YlFaZWsxeHRvODRYbFQrWFJ6NytY?=
 =?utf-8?B?UUpRY3psNjg3alNLS1dUWU1ucGM2OEF1OEdyQ0lhcDdNMVkreXVnMlVmaG9G?=
 =?utf-8?B?eTdlRjJVWDZ3M3cxdE1PRDZZamJMR05JejkxUmpPc0d0cTBnYk93bzVDSkR2?=
 =?utf-8?B?bWVRamlYY1pVSU5ISjFBWndSdGMrcytCaHR4TFBnWWpDNGxiMGpZUTZOWEs1?=
 =?utf-8?B?RlAraXhCelRlQnVzdkxXUS9TLzJNV2VYMEh4eXZYT2NHMnRSTlhCUjdMdWln?=
 =?utf-8?B?V1hDTmlYZHd6NXBBMHRnV2ZCS09yVC92dkNld1dydzFZOGRhM1NUT3U4Q0VK?=
 =?utf-8?B?R2c1dWJiU3RScmhBU3lsRldrNTNLeU5zUVo2UEkwdnYzUFE1NkpLR01WTUp5?=
 =?utf-8?B?QzNHaXVHLzc1ODEvUzNTNFVuMXhNY1BIQldDN2ljQ1FNTXk4cE9jODJ2amw1?=
 =?utf-8?B?QmNmenN5V1VoWjROd3QvMDFrYmJWakxDWFNaczBGRFBOUnlFVXNlMWs3WHhQ?=
 =?utf-8?B?UzRGRGV3ZnpzSGdGWFA1QlNnTXJYWmg3RVFlbWc5bFdVNTRCRlBEaGdzWGVp?=
 =?utf-8?B?dXF5by8zUHA3MjN5TlI0SFhCbWtRRkc2b3M4bm1jRldBSFVnSHhtaHZGOUdF?=
 =?utf-8?B?VzF4cW5La3dJT2RBcHpPY0t4T0F0ZkMvRzlwV2ovby90d0hCR2M0dkVudDNa?=
 =?utf-8?Q?658E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24677d6-4c26-426e-7574-08dcdbdd350f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 14:37:10.5725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyMc885Od+8XOzBh2/FAGsdzqbh2JBaJ4G3q5X5Uu38TvLskFG//mX2cjnNVRq46
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6524

Hi Reinette,

On 9/19/24 11:16, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/4/24 3:21 PM, Babu Moger wrote:
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 795fe91a8feb..6a792f06f5ce 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -1229,6 +1229,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>  			mbm_local_event.configurable = true;
>>  			mbm_config_rftype_init("mbm_local_bytes_config");
>>  		}
>> +
>> +		if (rdt_cpu_has(X86_FEATURE_ABMC)) {
>> +			r->mon.mbm_cntr_assignable = true;
>> +			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
>> +			r->mon.num_mbm_cntrs = (ebx & 0xFFFF) + 1;
> 
> This should use GENMASK()

Sure.
-- 
Thanks
Babu Moger

