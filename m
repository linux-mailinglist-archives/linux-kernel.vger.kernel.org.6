Return-Path: <linux-kernel+bounces-364631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E26699D737
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83971F253E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3451CACF9;
	Mon, 14 Oct 2024 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ds6Jv13O"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B449153BF8;
	Mon, 14 Oct 2024 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933672; cv=fail; b=K8NSTzAtcDJXsItDPelnZ+NMvF2GVIEM/fMefrQnoQvKgfKuKuSjeCESUK/EhslxxqSIz6OBVxZuP8jn2XWndreKkvvKOY373SphA/v7phaMHDm1KUjsevI5RXi5I9J/y3yLa1JPeoHN/4/S6XGWY1FfsvUmBpk2k9HWdc0pJnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933672; c=relaxed/simple;
	bh=IZwF+eO7j0r4kSHoNw/9ViP9bH186rtHH7WE5m+eDB0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d1PC3pUEzbPQn09KSoNU9oubxrhmhhYjluoP3klX+0TnIoTmYAUaNSHh7QWW2gYvlOjV3Pw/F4FPS0gfyAG0PRSW/2pyXaYVKC06ovd8fhJpNA7+6P0g9dZWu5iMiL6RlgNhOCUfPBsj5VBuqS+ARocLIAFm/dZTigN7GEhXCSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ds6Jv13O; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6XEApynAe++MOwNnnB2N+8xje2bGuxfw8YQbdSU9fQiBO24Ao0ju3Bxq0ReddsFSfbU/qSDyzk8Reozltk6nccAMryUtfiyEGUqQcS1ZVv1jBvo+JcZd2lIC2s2SmBrMGIMunQGFm8f82/SgFoneQaClV6/cYQm2Y6k47WSxzqvBVtxmKLYylrAjGodrwvXIoHbmnwRmU65qRvrMnnLH5GreS2n7eMdWTk5mtv0FQGjBE5Z9YpdhQMDQ0a+5Hc/BNZopdVIOmk6fGa6fQ23MMq0fci5a1k5jn8bhTkIczNUygvS9jElXOqx6UQvTyUKd2Z/ljUmPDFOcUjC4VzIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74UsUlvC0kG5ky9ByqD58TyDHJNa5Y2DSMg8LtN1Rf0=;
 b=Mzro3/Un7QsPLyxq2H1dgpcIJtfuSOKbTr5SsasB9m3F3bgAWTOFUj3KrwAhblWu2by4p0EWfN/HVcMPNzLW79esBKTdlFZdsa/sWSDIbD0lQIbvpQWONDuya2D0QeVLzyJfkGAyhC5jySq/XVgKqVfALbpXCgD3OaQ9a9p5G1GCgu+mtB0XfUgZpIzU2Ipoac8mHPY9OstMqXcGcCCRX5Hcbom9PSbC36BRsKf2Aimgo+2ZMoZiDik3CxCuPIwAvfgtrBqFyqogD1kqU6X6gmzLU/9bxRG5n36LAiYHqAIw41K8mOQRxIjAV0oHj9CSNCM+fKT44gbUGB4gSzIqWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74UsUlvC0kG5ky9ByqD58TyDHJNa5Y2DSMg8LtN1Rf0=;
 b=ds6Jv13OmQfwznPNmhbTexkBT/RKkG8z8qkzM3s7Gwv867q7VY1Wayzt3smztOTkHt0lQeTIXtms22q3Qb834RveBC6WUbKiqQmBqv3s5iWDBl5RiU9QXrM6TNQGQIJCNqg+4rsKxcwH3XxsnZlHWI42oL96yeHHc01BC2o+yN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA3PR12MB9180.namprd12.prod.outlook.com (2603:10b6:806:39b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 19:21:08 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 19:21:07 +0000
Message-ID: <23b5a3d2-91ac-4467-9db0-3de483cfacf9@amd.com>
Date: Mon, 14 Oct 2024 14:21:03 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
Reply-To: babu.moger@amd.com
To: "Luck, Tony" <tony.luck@intel.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "tj@kernel.org" <tj@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "yanjiewtw@gmail.com" <yanjiewtw@gmail.com>,
 "kim.phillips@amd.com" <kim.phillips@amd.com>,
 "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "jmattson@google.com" <jmattson@google.com>,
 "leitao@debian.org" <leitao@debian.org>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "Joseph, Jithu" <jithu.joseph@intel.com>, "Huang, Kai"
 <kai.huang@intel.com>, "kan.liang@linux.intel.com"
 <kan.liang@linux.intel.com>,
 "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "peternewman@google.com" <peternewman@google.com>,
 "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Eranian, Stephane" <eranian@google.com>,
 "james.morse@arm.com" <james.morse@arm.com>
References: <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <SJ1PR11MB608381B9DA3AE26749070BE8FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0fedcbd4-487c-4d55-8151-69dc34f41f1d@amd.com>
 <SJ1PR11MB6083FFA19F9387F21C058A09FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <d1986f3f-9db7-4ac9-9fea-56878548ad61@amd.com>
 <SJ1PR11MB608382EB9F40FBDC19DF71C4FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <1baa07f6-0ccc-4365-b7b8-09fe985963cd@amd.com>
 <Zwlj5TQxZphcuDSR@agluck-desk3.sc.intel.com>
 <8af0ce3a-1327-3ffc-ac5c-e495f9cdf5d0@amd.com>
 <ZwmadFbK--Qb8qWP@agluck-desk3.sc.intel.com>
 <ee7771e4-3768-456c-9990-fcd59b4f74af@intel.com>
 <0ee2e67d-c1dd-489e-beef-1f255c5629d6@amd.com>
 <SJ1PR11MB60833A1571413763DE36B538FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <SJ1PR11MB60833A1571413763DE36B538FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:806:f3::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA3PR12MB9180:EE_
X-MS-Office365-Filtering-Correlation-Id: bd507185-3ebc-47ed-cdff-08dcec855ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1FBUjlLOE90a2VOK0lMQm9UYjRKYmVMNU5mc2t4VXVmaGJ2a3o5S3hqbTJu?=
 =?utf-8?B?MndxNlh6RjYyNEFpNnNRVmZHZXRHbnNjUzRJZmtXdjlNTDZjZyszeTVudTZx?=
 =?utf-8?B?UFhvOElJNzNCQWJoL2VxaldFb1FPRmhLTTI0Znh2bVpxcE5RV1FSb014M2Y4?=
 =?utf-8?B?Tkd1ME81Ti9aWlBwQ3J1VXJOZ01vVkVyMmdVNU1iam9MekNLenB4WkIrRWoy?=
 =?utf-8?B?bTJUQWlMRldmUzRGVllYZ3pCMDM1R1ZHMkJWckNkQm5zb21QK24rM2xXclFq?=
 =?utf-8?B?OUF1czNpWWVORks3bGxkczIxbEhGNGFGVEZUN3BNZnVoWno4eU5vTFhTRlQ0?=
 =?utf-8?B?NWFFNHJMbFU0U3llYjlpK1dLWTlCczNKS1NFS2RKTlhTZVBxNUR5NjY3UVkw?=
 =?utf-8?B?eldrYjh1V3pqUWNhVXhsN3lneUpDMnIxdHNWdk5vWlh0aTVEWGdELzBCSC9w?=
 =?utf-8?B?MmdHWXRJbTJKOHJwOCt1eXN2ZzNKZmVjdllCTEthZ1ByOGRXdTJtTG9HM3VD?=
 =?utf-8?B?N0VuQU9ETzFDa2UrV3dFZjRUNkhhM3pzK3orR3psYVlockJ6NUlRTUwzNXJw?=
 =?utf-8?B?SExLekEyTmU1djE3bUdEaTRXdCs2cko4bGZUQ2ZsbnRDRkVmSHh5ejkybXJ1?=
 =?utf-8?B?U1BpRWNXMU5TemNVWU8wTmRmb2N4UjJMS0phMS9yWEJKenNhczU0Vm00cnN3?=
 =?utf-8?B?QXlpUTNDK0NTeFlZemtEdVJvVXJiNzFBRGhsYlIrWG5xUldFeGtIZFJ5MjMr?=
 =?utf-8?B?UUpVVW9SaEJ6eDZib2l1TEQ2L3c0KzJZZ1hHam85aENjQlV4MUd1MndmU3Yw?=
 =?utf-8?B?S3NLSmZoR3F4dGlaUzFta0Jib2VKN1lZTElnRkJQSHNDT3RRbVd6QzM5UkM5?=
 =?utf-8?B?cjVzN1JnS2QrdWNpV0E0VnlXTGQ1L2x3V0tFQmcvTzBQYUZqTFVBeWxzM2Zy?=
 =?utf-8?B?NkJLRkR2TlVOQlBqMjhqRHJxWTM4T3kvbnRnTy82Ly80MktzSS9jQnA5cEU0?=
 =?utf-8?B?RFZGTWNFNm9IbUJYOE5YL0pIbm5tN2FHbVVCWDFOaXY1b1BBU3lXNW43TGZB?=
 =?utf-8?B?eVozT1c2ZHhHTEdYNDUyenFTRHR2NW1PVTFUdnVWR3ZMUWN1RUt1VDNlZzNI?=
 =?utf-8?B?NTBjbGM4Q2VHQUQxekI0UUxZcU1OZGg2aE0rdm5hZFVHZXUwTllZL20yT0p5?=
 =?utf-8?B?T0l4OWRIY3NWaGUrSzFxRFNIanFuUGZhWE1Mcm5ZL1lRU2hoWUlxM1lwZCtv?=
 =?utf-8?B?WExWQkFSM3FGU2UwL1lYczZYVStFUHVtTDZyTUUrTE5HelIyaWRQbjRKOHdz?=
 =?utf-8?B?dSttaGYrY3ZIS0VMb0Zkakk4TzNaRndGYmFqTVJLQXpENWVUSDQrek1uaTEx?=
 =?utf-8?B?amJYc2lWVXFyc0REbDIrZ2lxNjhZbEVHcDl4alZPN1pCb0hRRFRuWkh2bWlt?=
 =?utf-8?B?UTFZMHFqTWExcEF5ampMczZKY3hjWmlLOXBVL21DTE1TTVd5MTFqZGRCTzdE?=
 =?utf-8?B?aFdBK09saUl0Q3RsUGtURXZ5U2pXYWFxajBKUWJENEVGZFc3cGJXa2NmSEEy?=
 =?utf-8?B?QzQ3eGhrM0F1YlIwT1ZSdndZMHpwajd2NFRTTjUyL21JTXJISlQvTXdOL1ZH?=
 =?utf-8?B?WWhydElmaW9aUDVPcDFYeFVHYzFha2pDSjN0MEhtN2I5K1JWVzdwY2VGUnM5?=
 =?utf-8?B?MUtaR2YwVDZmYzRCcW1PWm85bHJCRTFBZTB1cWhKQ2orUjQyekdrNW9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDEwVnVoc29sT1VzODlDNjRNY01jaHFncm5VUnk0YkhURWlLMXUvbE5KQ0ZK?=
 =?utf-8?B?am1OZlVXYk4wK05BQ2liRHI4QW1zZjFZUTluOHBUWEhqTyt6YUJtcy9EZXB1?=
 =?utf-8?B?UzIyZVdXK1drZ2N6WkhpRE52Qm02dEYyNU5CbUYrVklkd0k0QjR6V2tCcGdm?=
 =?utf-8?B?Y3R3bHR6a2lveUhkV1BRc1h2OXd1LzJNZmpvRXN3bGxiK3ZsbXdUYXRaTjgy?=
 =?utf-8?B?M09Xb0YxeHRkV3A1ZDl0MUpYRzFPaVdrdCtkd1JLbDdsSTVsT1loeXM2RkZ0?=
 =?utf-8?B?M1J5SFR4UldoRVV6eVAwcGFlMklBclZ3b0diemFIbC8rNTEzbW50TUVnUmxm?=
 =?utf-8?B?ZHFJVGVmNlh3RmdRMU5uSlJKUjZyUTlOa09sRjhSYWZxc2VSSzhpeG1RMzdu?=
 =?utf-8?B?Ylp5L3RTTHRhcWREUjdRMDFNemNqQzNzdUpwSFlpaUl3UWFzMmk5RzJOb08x?=
 =?utf-8?B?Ukdabkh2bXo3VFNYeU9tOUtjSzgzajFJeG5Va3VWaEVNOTRheHYvTzJYTXNx?=
 =?utf-8?B?WFBoSTJTelRJRHgxbGZDbDJ2OUlDajlReE9wOTVjRWNsTTB5emJ3SHU1RzNr?=
 =?utf-8?B?U0FMOHVnN2drS3BQRFNSYVlmcG9TNlB3R2p0QkY1TGhhU2t3NkxEaEhmYm9v?=
 =?utf-8?B?YlRJeWtaQytLZUowcU8xblBUb3BkZW5ad1BraEpkTnk0aVNMc0FiZlViTk1G?=
 =?utf-8?B?bFpSQm93NVl2YkpqdWUyNEt0ZlBOZTgyWXA1RlpqMW5wUmk3ejMxTEVLLzlY?=
 =?utf-8?B?M2tnMWExUVd0a2JhZDdWQ0RFRCtRWUVMY0xvc1IyM09mZUNoc3hUeXc3R2FO?=
 =?utf-8?B?VC9VL0J0RVRLOUNURnFEYmlOcW50OHNJd1MxZTVqMkd5eWl2MGRKN3dTWi8y?=
 =?utf-8?B?QzdodE5EZGkwTFZsZ2Y3U1N2c2g3cDkweStXYXZTNzV2TWVqZDB0cEp4U1NQ?=
 =?utf-8?B?WUhMSTB0QkhjMGJFVzJBRFkxTkFzWGhleGNzSUROd01sUUxOTm1IWForMEJy?=
 =?utf-8?B?Um9VSU11Snp2SzRDdm1HYWN2TWlWbTlWSVg0VXo2UFI2ZmtJUldSd0dUTzJ1?=
 =?utf-8?B?MTEwUE8xRVZPVDczdlF6THR4UnRFRWhGbkdDY01wQllJZjN5S2FQeGI5YVlF?=
 =?utf-8?B?SDNnTHJqZGQwc0xRSk1TVEw0L1V6cEhHOC94R0NkallWeFF4cDRjVEhmWklV?=
 =?utf-8?B?cHBid1BvTEwxdjNBMzhKeUpXWWFHOE1vd0pKenR5STlneWZZZnZGcnJBa0dL?=
 =?utf-8?B?bHcvQ0J1STRXZVUzZk5XODlEd2FzQXRjVjhJVkJyZ3UrM0htb3Jhd0ZJM1gy?=
 =?utf-8?B?QnJIZmFvZ041alVOMHpYeEdrbDFtRkdxWGk3OSs5SU9JbU93c3dqdkVoaStq?=
 =?utf-8?B?V0ZzYmp0aTBoY2xHMENwbURzcUg5V1drcW1XNlNYTXRncUNUMkhCNFB4Rk0y?=
 =?utf-8?B?aFdER2U1c2ZHbW52WWVWTWsrQ05pZkdjWmNsYktleXc1ZGsrcFpEVXZjS1Rl?=
 =?utf-8?B?QTJUeFJIUUd5a0l0SnpWR25ZVHdHSnZzSWFOdVE2NXdxVXB2R0trdFNBYUox?=
 =?utf-8?B?c0VxWTRCQzB6SUJ2UHdvWlBCTkJBMDgvcW9kcit4WXI5R2oyYlU3clhCSEIw?=
 =?utf-8?B?UnVZZ2JSVklwUXFBS0s1Y0ZjOHV0akN6Sk5RK3NoVWh0eXZGMzh1aVZrMkZv?=
 =?utf-8?B?dEEwbHFoaEw0RlQ2clBZeW03SmtEbTJNYXVzbzFOY3hZT1VyUUN3VHR2UzZT?=
 =?utf-8?B?RzdPdUZQWXpkOWpZNGhiTFF5cS96YnRhUzdRZFBRZ3F6cHJhVjdJRUZmU0J3?=
 =?utf-8?B?VW9zZ3BYaTBhM1VRa2hXRDlnRDI4UGVMMlA1WTNFakwyc2JlWjZHbHdsc0RU?=
 =?utf-8?B?Y016dGVjVkJGTDNHSFFKN3F0OSt5cWU2aTc0SGJTN2RNRVBXbXBWTzRaRVhP?=
 =?utf-8?B?azdmQVBPdDU4ekJrQUtLTklXVE1oR1I2R2tIM2RRNVNoR01tMUR1MkxJam51?=
 =?utf-8?B?Um9sUEx0VHVkNkJBSW9xMlRQWWJ1VDl6RjNpK2VhaWoxZjF4MVR1QTNBbHhv?=
 =?utf-8?B?Tm1RaVYvTno1bERpNEhVS1hKYmlXL2dseG0vUFY4UTNZc3RUR085WUIyUkpF?=
 =?utf-8?Q?rEFk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd507185-3ebc-47ed-cdff-08dcec855ac5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 19:21:07.8360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSTTEL/09pOxLYQtaYH10kuf+phR7TahYIvEFwOx3VSkjk0ZZ0iN2xDvXKa1wgrk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9180

Hi Tony,

On 10/14/24 12:49, Luck, Tony wrote:
>>>> I.e. the user who chose this simply gave up being able to
>>>> read total bandwidth on domain 1, but didn't get an extra
>>>> counter in exchange for this sacrifice. That doesn't seem
>>>> like a good deal.
>>>
>>> As Babu mentioned earlier, this seems equivalent to the existing
>>> CLOSid management. For example, if a user assigns only CPUs
>>> from one domain to a resource group, it does not free up the
>>> CLOSID to create a new resource group dedicated to other domain(s).
> 
> I hadn't considered the case where a user is assigning CPUs to resctrl
> groups instead of assigning tasks. With that context this makes sense
> to me now.  Thanks.
> 
> 
>> Thanks for the confirmation here.
>>
>> I was wondering if this works differently on Intel. I was trying to figure
>> out on 2 socket intel system if we can create two separate resctrl groups
>> sharing the same CLOSID (one group using CLOSID 1 on socket 0 and another
>> group CLOSID 1 socket 1). No. We cannot do that.
>>
>> Even though hardware supports separate allocation for each domain, resctrl
>> design does not support that.
> 
> So CLOSIDs and counters are blanket assigned across all domains. I understand
> that now.
> 
> Back to my question of why complicate code and resctrl files by providing a
> mechanism to enable event counters differently per-domain.
> 
> "0=tl;1=_" requires allocation of the same counters as "0=tl;1=tl" or
> "0=t;1=l"

Yes. That is correct.

> 
> What advantage does it have over skipping the per-domain list and
> just providing a single value for all domains? You clearly expect this
> will be a common user request since you implemented the "*" means
> apply to all domains.
> 

We started with a global assignment by applying assignment across all the
domains initially.

But we wanted give a generic approach which allows both the options(domain
specific assignment and global assignment with '*"). It is also matches
with other managements (RMID/CLOSID management) we are doing in resctrl
right now. Also, there is an extra IPI for each domain if user is only
interested in on domain.

Some of the discussions are here.
https://lore.kernel.org/lkml/f7dac996d87b4144e4c786178a7fd3d218eaebe8.1711674410.git.babu.moger@amd.com/#r

Thanks
Babu Moger

