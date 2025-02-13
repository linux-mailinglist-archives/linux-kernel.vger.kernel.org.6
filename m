Return-Path: <linux-kernel+bounces-513414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 350E4A349FC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6CF1750A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC86221541;
	Thu, 13 Feb 2025 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B5zWVvwt"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBDC200105;
	Thu, 13 Feb 2025 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463577; cv=fail; b=AOweQ3EfdO9lh6o3OOIOGwc2U34VraJk52zEok+sbMnTHfnNkTP922maav5BO+IWQQFrhOj1qX9mWy/jizCWmCrOgQDIGkBJXD46iJizSqBLIuwCAelEnvbVcXUAtmZM/AI2FWXG64SgOO+Rh0mYETv9iXwEMJeZn41fj4fYV04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463577; c=relaxed/simple;
	bh=vz3u19nZDw9vngkkWlA4NxxZ+h0wnO4ce6ZPxjkVuJY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NL+qpNvZM4H2RRQYLy3HyBv0ivEKD7aGdP634UkZSf+0hSN5cviOf0todFijK3y1otvhjIgZVHZKrUIpw4N/x0o8o5Ud/c5sdy3KZdRO794A8/dvD4xdFA2Q6K+SJiA71auCIGy1xIDV4BwZHyMZlE0MzaMf4hT7njvxrQQyVuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B5zWVvwt; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYdWpFiJVFxUshWPfILvi4kye6ve2rdzWVnZClpqQRiA8dLheNY/Q8gRZX89XJ+20ZptVbXXUG4nI35qA6QAdszkHy7okkiXo3dyGiMSQguPXMafefqAtkPAKYF0/7KmJZ4Rb06krVKjypTHjrfA6KB0Hn5b4FbU7EfL2EvkZ5JUWkaylGwIrWnzWqhpkT/6rRG5OBfmBGa1UsMUgx2DSG91hpXoLstumpZ8DWHnMMRKICeF9RZ7BjV64SUugLTUviw9/oqEflo1hn4v2iPsYiqW4/1OJQnOXbdXE1P/0nd0zvlA7Yyyc0wvDlDg2w8+4p0XFagCTS9dPQHgXC9VsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJm+EstFihzGRaj9wdsIc53ZMmVRciwrWqe7lpJrFec=;
 b=wxvMWL9VAflMbQ5mAC+W3UfKRXpuY0Ge/MrzJps7uQWhhrFTpaezr3EUtXYJhjg9i1xARnie+122vx37uZpGVNeun56Qxl4YMnUjDKdbqYJEz5CI1KXFkW1YaAEzE9ndlAly55v1dVEME1bnvBr0K+8n+ZQkXkWD9HKqs+tfcHpmblVTzZTnxcnHl9iRa1DKgkQWmfGi22pFrRIeAxM1EwB/nWRKW6iq7LHYDnEFAPiyvTE8gxsOPfVNP10fZTgxD8TEHVcfb+bcOPsPFW5++DugXp9WLI7uYdHC5O893f1XpN0x09uRcJhmuLeDz0X8DUCeFHM4qvboZVV5GnPJGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJm+EstFihzGRaj9wdsIc53ZMmVRciwrWqe7lpJrFec=;
 b=B5zWVvwtQ6vN/rcBL46LqFFhknTDkR7Q0CcmRAEm91M37TFNBvqppCsD1BXFC7Vhgg80pASTKR43xxeZebtc92qRAs8DTAbzydYRAfcoC76iW/xuKbHE6YRuKjgmixHMVuDpqoHeaLSFOlwe09bam259L9ZlhwewDtyobrIFW9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 16:19:33 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 16:19:33 +0000
Message-ID: <5e9a5b3e-793c-4873-a1d2-33b62614ec31@amd.com>
Date: Thu, 13 Feb 2025 10:19:29 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Dave Martin <Dave.Martin@arm.com>, peternewman@google.com
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 tony.luck@intel.com, x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, jpoimboe@kernel.org, perry.yuan@amd.com,
 sandipan.das@amd.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 seanjc@google.com, xin3.li@intel.com, andrew.cooper3@citrix.com,
 ebiggers@google.com, mario.limonciello@amd.com, james.morse@arm.com,
 tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
 eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <Z6zeXby8ajh0ax6i@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0068.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW3PR12MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e890b1-51e7-4f67-7295-08dd4c4a337f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTlDQXBBMFgwK1dEa2gzVXFvdFZ6b3RtOEFLSVI1ZFVKSWpFWktudjhNM1pr?=
 =?utf-8?B?Vi9adFprbmpCam5FTXkwQlpreHF6UmExWDRrQ2dxM1g4R0g0WGVoNEpNU09u?=
 =?utf-8?B?eDhmMHd6RmhMc2RnNnhkUkdnazZiK1B3UjFnZVVLZEc2endmbDQwVzRIRGVn?=
 =?utf-8?B?cmhvNUpjV2FUbWN6ZXBwb2k2dHRJK2luZFRwZHU4aUV1bVNjVkdrYXA5RG9x?=
 =?utf-8?B?YU9VRmRRUXY0QXZVbkM2OXN4V2NFU2M5Ny9sb1c5aTFYT3orTVIwNmJVbXUr?=
 =?utf-8?B?ZlZ1SVlOUmhqWlhMblVJeEhzZUdjS1Q5NWxMcHdJaVh2SEFkYm11ZlRiaFI2?=
 =?utf-8?B?VDNONVR0SkJoeTNEVVhBWHJWM1hFMXNEaEpYeUpZWVM4VmZPR0kzdjZnMHJZ?=
 =?utf-8?B?THJQeVlLbmJ3YkRjcXFXUkJFQm1GWkN1YThrb0I1VW9KVG02UEwwa0tEeHRV?=
 =?utf-8?B?KzJHMXBMQmU0MWNpbXNVaVM4R0x5UTJrK29RZjdlQUwrQzhYUiszQ2xoSDlQ?=
 =?utf-8?B?MUxteEsyUVFyS2Y5Y2tRNGI1OVJVM1UybDlOZElTZTZ2OHFxN2VCV0x2bEZ6?=
 =?utf-8?B?MkdVUkZMUFJXZW5Xdy90dzZOVXBYZlR1dXprUXhoRVNacnpMVDllMXZKQ0Mw?=
 =?utf-8?B?YjdaUkhkenZsWWFQNzd1d2RUbzZjYnpxR2pJdFoyWi8rWVhSV0dPZlVaOHcr?=
 =?utf-8?B?Y1JhNUt4VkZGQzdybTBFQUNvOE9qUFpDekdqWU1mYUkrRGxwVCtNNlVkLzRH?=
 =?utf-8?B?MWQwNnlSTkFyWVd4ZzliNFMrZnFJN1BORjc0TVIrdlAxTjlsc2lwcmcrdmFQ?=
 =?utf-8?B?eVFNYnlpUmQzNHpFUEhMSjdxVzRBM0dPME9BTjU5a0Z5SGpIOE1zRWZKQlpa?=
 =?utf-8?B?TW02WTA1Uk1WTVB2a2xnb3dsZ3hwcGNZSENMT2RKT3ZnVlJyYjhUNEFUeXBu?=
 =?utf-8?B?b1VCT3BwcWlyZDQ2MkJlbmEzVFpZeW0xZEgrZUVaVU9RTUMrNllWTVpQMU5z?=
 =?utf-8?B?cUg3ZXVMSnl1cUl4cldFYzMzTS94Z1JGaDd0SHZkZ3YvYmFwbG1oS1IyMnNY?=
 =?utf-8?B?dTZueXVqZENZRnBGYWU5YW5jczZPL2Y5MDc1MmtZdmpBZHdkak5YZjMxQ3p6?=
 =?utf-8?B?NU5PcyswOXl3VTZJY1VFSmdka0ZwMWRVYTQxZjByQzB1OGpUS3owSnpYL0xC?=
 =?utf-8?B?MXdmZDM5K0VHb1RtN1Q1MEJJbTg4Zm83ZVBTMytWUTFyWThnT1RYWTB4ZHZt?=
 =?utf-8?B?ek9kT2Y0cGhOUkVlb2lNL0Q5Yi83Z1dBbklPWTFIaUgwYUhNVStIVXNKWHR3?=
 =?utf-8?B?a2dNUk4yQUVpWFQ2STRmYmFaZnBXTGFSaEZSaFpTRTNxNG5qTFlRZEJDOHM2?=
 =?utf-8?B?R1NzYUxwRld6YklXak9EdjlwdU1BaG52WktreWVhZ01DSnlrN0JMeE4rejBx?=
 =?utf-8?B?REFKRHA0bC9aK1JwUkxmeTJyM3RWN3JjanNkTktvU0N6T0o3YjRDdTk2ZmR6?=
 =?utf-8?B?dll1cWpSSjl5QndmNzNzWU90eTFqeXFiWkgzU2RiWlYyL1EwZ1hNUWlLMGpL?=
 =?utf-8?B?eTBGcFpBQVNia0JRV2xBWkJ3S2tOZEVjbnpKaG1hT1NSZ0l5NjNyUTZmNWw0?=
 =?utf-8?B?OXQvSFFtUGlzWTRXNGR6dnE1N3lpMmhUUmxxUU96RndIY3U3NUc3NnkvYkww?=
 =?utf-8?B?M1dHekVjbXdpdzlVQ3NTKytnR1o2UnJuVWxNTU5CUnNBYjVSUDdKc09zcDFj?=
 =?utf-8?B?NXVCcGVhK2x4THVhL3lUMVdNMDluOUt0c3BpRE1Vc2ROK2JkZ01pWmI0NllG?=
 =?utf-8?B?T2prQnJOUGJXRVVpK0ZiZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0hiZ25xcGtTZWNUWVphajdqMmNYSFJRNUVwVGpVanJPNkJ1ZU5NcnJkM0dV?=
 =?utf-8?B?QW56bmJOZDJLMGZVYkE1eGF4bEFuVHU3UDkzMWRzQ3BjU2RHYVA5MkJOQUJy?=
 =?utf-8?B?akdoNUpaNTRucUVVekVxS1N4QlczSXRJSy9UdmlrUnhmWm5oL0t2UWR2TjNr?=
 =?utf-8?B?VTJBcElYT2NxdDM4Z1JBc3VJRGFGcEY2NzUvblZDSjg5ZHVIMUROSVc5U0la?=
 =?utf-8?B?R2drcFBrd1BmQ3JFV3pTcXpsdTFvaUVRc0Rxd0x4YmtNbHJMM1B4RW9HZ01S?=
 =?utf-8?B?RWhtem9nTk1VQTRWVEhwcnd5dEQzb3NFYUpZcjR3WTJERWhUWExNb1haOGkv?=
 =?utf-8?B?TlFWOCtjamEvb2Q2bW5SeDRhdys1S2lUOUpieEJxM0JycTIzcVZnUEd1aWVW?=
 =?utf-8?B?RjlCbnBZQXg4bDZDYmlUQXVlTVR5aVBFVEVCVUV0aXdlY0k0dlMxWjFTZVY0?=
 =?utf-8?B?a3YxMmd3d3pKay9jSHFuWXJmM3c2eU5FYjFicW1aNlNQdTR6T29iUUJRMkZS?=
 =?utf-8?B?MldLY3R6ZDY5OWtneUlQOTl2aG1vMjNiaVVENjF5TlVCcnd6bDZoajdLUHg2?=
 =?utf-8?B?akM1cmxDSFpOQTU2eE5aU1FRenBEbUViZzIwdzFQNy9VMVlMdkQvbi9CQitP?=
 =?utf-8?B?dmdQc1pVOHYrL0hOemtkczNpRE5MSThITldpZlcydW5TbmZ2NDBmWjFzS2s2?=
 =?utf-8?B?Y3djZ2c2UkJhOEp2YStkT3ZuYmhVeVRnY1M4aUQyWjl6QkpxRERqZFRtTEpv?=
 =?utf-8?B?dDhOZDQ4WnR1ZXV5bWJHODFjMDM0TDBNbG5LalN5b2RtcGpmN2tUaWlpODN6?=
 =?utf-8?B?cHp3UzIwK3FFVGFReTlxWTNycEFIMm5jSDdJOVA2REtpMUtMQVA3aEJJL2lu?=
 =?utf-8?B?aWFwajVJNStsV016K0FPQmo4SDZ5UisrQnByaHpFbC9MbWJxUzBjUEVPZXhH?=
 =?utf-8?B?SDE5Z0c5QmFWZFY5VmdtQVFQTFlSTmc0QXBIMVArL1E5RXJCditjUThnQXJz?=
 =?utf-8?B?QXlCR1V6aWM5ZGFlK09LSmNDcUd4TGtsenA1QnpIR3hzL25OS1hLcjBtQjBi?=
 =?utf-8?B?VlpuNklKWWloWVNIQjBrL0RiVW8yTTJqV2tEaEhVR1QzalFaSjlrSkx6Wmlr?=
 =?utf-8?B?UzVwN2xHWjZ2ZDFqUzB3cFk3cUR6WnlBdFJwMHBVWWdjQzdZbmVlTGlkTGNN?=
 =?utf-8?B?MnVjME9ZM0R6TkwxNnhESzR0RzFXanVCT0tUbzNYYTNFMW93UEJzOEpWK0pU?=
 =?utf-8?B?and1cWdSNmpOUnhsejY5NzNuazZ5b0ZCMWdVQ0Z2eEZkYXh0MjROV0JHV3gy?=
 =?utf-8?B?dEltSitibEZjbi8rYUJ4UjNwUkdoU3pDVDVWU29DdG82TmRyZjB0Y2lJbGpP?=
 =?utf-8?B?ZzVMcXpCZ0FlZWVFaHU3ZEpXRGJmMnVBM2gzZkVuRWlZSEpGalJJQWh0WnJ5?=
 =?utf-8?B?S085alYwcjQyeXNaS2RPaU0ySDkrN1R5RmdTSC9uSHg1Ykk0N29QWmFSMzdE?=
 =?utf-8?B?Q0tMY3hubFFpN2F6bmp1bFNDdFRMeWNDbmVyWm1mZ2xpZmFlT0dVVWxjZlR4?=
 =?utf-8?B?bFBiZzBFK2lPOWZvVEtYNHlmV1kwUWpuS05INFdYUlkrYWVJaUN6OHF6SnFN?=
 =?utf-8?B?V1lXd29PL0Z3dUtYQ2NXN0lpczhKSDZSdVJlNElEZ0pyelVyRWFMVmV3eTFT?=
 =?utf-8?B?OS9wWjVGZFhrM0xjbGkzU1puZXc1V1krL2k4eHNNWFhkYzBVdy9jdkg4NzVm?=
 =?utf-8?B?R3YwTmFUekQzdGhnNFN4bXRTclkrSWdyM0todGlxYSthTkM5NjlYdmtPdWha?=
 =?utf-8?B?WDdYM3pEZWRPaUpweHQvOUJuUTdCYlZWc0tPTEpoeEVnMjBVajBBaFdweUFH?=
 =?utf-8?B?OGJkZGxmRE91Wm1ld0dGcEJHbXhaTTdubTdibFpZRSt5dFF1L1RDa21DMmZh?=
 =?utf-8?B?NUF2VTBra2pQNUUyNlpyWG4yQ285dVFob0NKYzloT0Z6TU52NTh2a3ZuNEhK?=
 =?utf-8?B?NzdDU1ZhZGI1NnNHMVdkaklHRkFLcHB4Q3haVDZ6QTlXOHVCTmxLQ3Awdktv?=
 =?utf-8?B?Vnk2STIxMTV0Rmo3UElXZVcxVklhQ3NER3RyTnVteThXaUwySllLOG1BWnB0?=
 =?utf-8?Q?5VFs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e890b1-51e7-4f67-7295-08dd4c4a337f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:19:33.3472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TX9Tt9QRW6esmN0jGi87zCABbkGYKS5DPJ+vocnD13Jy+ZpYOsT4ywqL58vq99Tn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378

Hi Dave,

Thanks for your help. Reinette has asked few questions already. I have few
more questions on top of that.

On 2/12/25 11:46, Dave Martin wrote:
> Hi there,
> 
> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>
>> This series adds the support for Assignable Bandwidth Monitoring Counters
>> (ABMC). It is also called QoS RMID Pinning feature
>>
>> Series is written such that it is easier to support other assignable
>> features supported from different vendors.
>>
>> The feature details are documented in the  APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC). The documentation is available at
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>
>> The patches are based on top of commit
>> d361b84d51bfe (tip/master) Merge branch into tip/master: 'x86/tdx'
>>
>> # Introduction
> 
> [...]
> 
>> # Examples
>>
>> a. Check if ABMC support is available
>> 	#mount -t resctrl resctrl /sys/fs/resctrl/
>>
>> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> 	[mbm_cntr_assign]
>> 	default
> 
> (Nit: can this be called "mbm_counter_assign"?  The name is already
> long, so I wonder whether anything is gained by using a cryptic
> abbreviation for "counter".  Same with all the "cntrs" elsewhere.
> This is purely cosmetic, though -- the interface works either way.)

Yes. We can do that.

> 
>> 	ABMC feature is detected and it is enabled.
>>
>> b. Check how many ABMC counters are available. 
>>
>> 	# cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs 
>> 	32
> 
> Is this file needed?
> 
> With MPAM, it is more difficult to promise that the same number of
> counters will be available everywhere.
> 
> Rather than lie, or report a "safe" value here that may waste some
> counters, can we just allow the number of counters to be be discovered
> per domain via available_mbm_cntrs?

As  Reinette suggested below we can display per domain supported counters
here.
https://lore.kernel.org/lkml/9e849476-7c4b-478b-bd2a-185024def3a3@intel.com/

> 
> num_closids and num_rmids are already problematic for MPAM, so it would
> be good to avoid any more parameters of this sort from being reported
> to userspace unless there is a clear understanding of why they are
> needed.
> 
> Reporting number of counters per monitoring domain is a more natural
> fit for MPAM, as below:
> 
>> c. Check how many ABMC counters are available in each domain.
>>
>> 	# cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs 
>> 	0=30;1=30
> 
> For MPAM, this seems supportable.  Each monitoring domain will have
> some counters, and a well-defined number of them will be available for
> allocation at any one time.
> 
>> d. Create few resctrl groups.
>>
>> 	# mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
>> 	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
>> 	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp
>>
>> e. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>    to list and modify any group's monitoring states. File provides single place
>>    to list monitoring states of all the resctrl groups. It makes it easier for
>>    user space to learn about the used counters without needing to traverse all
>>    the groups thus reducing the number of file system calls.
>>
>> 	The list follows the following format:
>>
>> 	"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>>
>> 	Format for specific type of groups:
>>
>> 	* Default CTRL_MON group:
>> 	 "//<domain_id>=<flags>"
> 
> [...]
> 
>>        Flags can be one of the following:
>>
>>         t  MBM total event is enabled.
>>         l  MBM local event is enabled.
>>         tl Both total and local MBM events are enabled.
>>         _  None of the MBM events are enabled
>>
>> 	Examples:
> 
> [...]
> 
> I think that this basically works for MPAM.
> 
> The local/total distinction doesn't map in a consistent way onto MPAM,
> but this problem is not specific to ABMC.  It feels sensible for ABMC
> to be built around the same concepts that resctrl already has elsewhere
> in the interface.  MPAM will do its best to fit (as already).
> 
> Regarding Peter's use case of assiging multiple counters to a
> monitoring group [1], I feel that it's probably good enough to make
> sure that the ABMC interface can be extended in future in a backwards
> compatible way so as to support this, without trying to support it
> immediately.
> 
> [1] https://lore.kernel.org/lkml/CALPaoCjY-3f2tWvBjuaQPfoPhxveWxxCxHqQMn4BEaeBXBa0bA@mail.gmail.com/
> 
> 
> For example, if we added new generic "letters" -- say, "0" to "9",
> combined with new counter files in resctrlfs, that feels like a
> possible approach.  ABMC (as in this series) should just reject such
> such assignments, and the new counter files wouldn't exist.

What is "combined with new counter files"? Does MPAM going to add new
files to support counter assignment in ARM?

Also what is  "0" to "9"? Is this counter ids?


> 
> Availability of this feature could also be reported as a distinct mode
> in mbm_assign_mode, say "mbm_cntr_generic", or whatever.

Yes. That should be fine.

> 
> 
> A _sketch_ of this follows.  This is NOT a proposal -- the key
> question is whether we are confident that we can extend the interface
> in this way in the future without breaking anything.
> 
> If "yes", then the ABMC interface (as proposed by this series) works as
> a foundation to build on.
> 
> --8<--
> 
> [artists's impression]
> 
> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>  	mbm_cntr_generic
>  	[mbm_cntr_assign]
>  	default

Yes. This looks good.


> # echo mbm_cntr_generic >/sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> # echo '//0=01;1=23' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control

Looks like you are assigning counter ids to domains here. That is
different than ABMC. In ABMC, we assign events (local or total) to the
domain. We internally handle the counter ids based on the availability.

Can MPAM follow the same concept?  It is possible?


> # echo t >/sys/fs/resctrl/info/L3_MON/mbm_counter0_bytes_type 
> # echo l >/sys/fs/resctrl/info/L3_MON/mbm_counter1_bytes_type 
> # echo t >/sys/fs/resctrl/info/L3_MON/mbm_counter2_bytes_type 
> # echo l >/sys/fs/resctrl/info/L3_MON/mbm_counter3_bytes_type 

This also looks different that we are have right now in resctrl fs.

Are you creating separate file for each counter id in
/sys/fs/resctrl/info/L3_MON/?


> 
> ...
> 
> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_counter1_bytes
> 
> etc.
> 
> -->8--
> 
> Any thoughts on this, Peter?
> 
> [...]
> 
> Cheers
> ---Dave
> 

-- 
Thanks
Babu Moger

