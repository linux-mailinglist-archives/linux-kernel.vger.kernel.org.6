Return-Path: <linux-kernel+bounces-360033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D02F9993B6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2701F23351
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5CA1CF7B8;
	Thu, 10 Oct 2024 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vbv0H+OS"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A751CBEAB;
	Thu, 10 Oct 2024 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592341; cv=fail; b=EJNCXT8Ae/5d1BCv8K919INNk1I6+o0XJXhHeS7eRL4EoZIaWjVT0hjYwbWBQVt0EeGIok+otkm1H2O57Ew/53bL7KfsH/+xRS825NuMSIHcXrmcyeL2DNy6nhyuEzYZrWnQAZe3mHeJgxFPRmfO7QPM8S+lne6qq5iXziXxhKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592341; c=relaxed/simple;
	bh=B3t2n1G4S/cLEdWm8msLA5WjNLNn1MB1KaUKKiKDQz8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VvkgS5JeW2dZ/50fCE+ijniB32HPd7edwZRIod583TpjnxyyjPASxDwh2LqN/Sg9rLZpEVNXXDdu3f1z5d9Udxntz6mZ1koejY64KmnlscS5hpS5RaYXUDioi6yO5aPaoVFKkPyRcjPVkckay9n+6VrZwhvS4mGFjK6ShGjNVyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vbv0H+OS; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkthZo/YEcn1j0OaOjZbRjVXDGoA6AfrxuikwQkQiIKtMwKtPAOJjZwM+7S554lrfQ8VoqDqMxbAgFcCTS6mHyJS19wFxO0YxrqpWkeQRSv3GQoRHZw6/s4lNdNaCLlBMfzxbpaKKrpicHxtnM1gkcWdZ5kuM4IrGG4HMMQWwh/HiLXN6L0nmhCqlzIpjqe3xKsB4ErfEjnfaY86EwfXdIPX/TzkMHxYrU03VO8OjJ8tK2r2BsUpRWSLWXGIGBmOZigcnYjwKke0jXDx4FAKTafpADGkEpoxjD2Qh+yaxocfuwqU1oVk7gSIY1qrT8Y4cQxAVOFUSDMcxpIdGHZ0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbnG5X4wymU7Winji61aY+MJ35yI/D7kAwZRdE3XvZ4=;
 b=gF7WhnjeWwdM2oBjH6GURSM59XLD/OfO5wMzNF0APMr8MqJ8rPmIDNy6evCbPo14Wfa4lGTi+dS6EAVBunRrrEvp3wtwbfHB9X5iAGFqfAVJEyR2aJKZwVnOgJImhzqM4crdflmtlsgugYHwtTCKHzglTIv3aAix0oQJysvyOWWyyA/QhuhorMJPQNaB5YNBnE7UsKNfTSZDkplUBfGzl4t3/qzebn2l4ofltrCLn9SgkgYnTFxyFRkTplxIgrbJws/BEtn94WLkB+tTaqca4Hwokktq2xrYeEV0rGA0N06ocFRlQOMB/xZhP/ZCCgn3/gucXqo+yaPqf0Ik3hbFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbnG5X4wymU7Winji61aY+MJ35yI/D7kAwZRdE3XvZ4=;
 b=vbv0H+OSEHl0euWfHRX320+mczgoZus15VNLVuj9x0qo+zoPp9UJcgyOWZPsGUjTv01VTwzm4PdvrCXfSA6kTPMigt2iIJ8Mnp5WHhBnHI6MPTaVwgYG22fZOFwug2mQ9SIrEO6mN3udQh1uWDVTiwkx5Y9LBZ7vaTQ3MqHMADI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8259.namprd12.prod.outlook.com (2603:10b6:610:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 20:32:13 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 20:32:13 +0000
Message-ID: <1baa07f6-0ccc-4365-b7b8-09fe985963cd@amd.com>
Date: Thu, 10 Oct 2024 15:32:08 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <c79fdf4196d974325df995eb334221463747689e.1728495588.git.babu.moger@amd.com>
 <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <SJ1PR11MB608381B9DA3AE26749070BE8FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0fedcbd4-487c-4d55-8151-69dc34f41f1d@amd.com>
 <SJ1PR11MB6083FFA19F9387F21C058A09FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <d1986f3f-9db7-4ac9-9fea-56878548ad61@amd.com>
 <SJ1PR11MB608382EB9F40FBDC19DF71C4FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <SJ1PR11MB608382EB9F40FBDC19DF71C4FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:805:66::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 397c55ec-5c47-4c34-856f-08dce96a9f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2RzWjVRNXhsUDNoTEdiLzh3NnV1bDRiS05rRkRpMEZQZngwT25ySDBMNi9W?=
 =?utf-8?B?WkUySGxybHJuZHM3VHdRVE1zYlU5OXZKYVFuUi94VEtrQWw3bWVzU0QxVERG?=
 =?utf-8?B?MFdzenNQTTlYVW9JNGhaQ0hoeEdRWVF3Y2tGb3U1Z2FDTUVNTmJNQlpMdWNR?=
 =?utf-8?B?WFlZbjVnUEZlanhVR3JlRVBhckZvSXcxOHhsQ0R2WGZpQjhUYUxmMkJna0JX?=
 =?utf-8?B?Z3ZmZS9TY0E5VEw4YlFvQ1VoVWQ0L1Fqc2ZJa0NpRW9YMDZlczdiT2JGdS9S?=
 =?utf-8?B?c3A5dXFnZ2ZrbEpXVkFIQjkzb21XeGxUVjFsMXQraE0yTXphTEY3RmVIZ28x?=
 =?utf-8?B?SE5SODdFUnB0SUg3YTdUYXQ4WkRUU2VNdG5KR1BNbXNLSVIvb3h0VDZ6OW9J?=
 =?utf-8?B?WUd2M2FqcjRzZWJoTWJLK3ZuV1Jpd3pkb2dCckpaZW9CWSt1RzJ3QWI0UUN6?=
 =?utf-8?B?U2tKUmwvMTkyTTB2ZHIwRTJuNjJFdUIvbTh1L051QUtyMUdkeFRVMEloRDVn?=
 =?utf-8?B?SUNFVHB4cFJxSTNMNS91V2kwbjRnQjdmak1KV1FJaHJtYzRQTGV6SzRFcmd6?=
 =?utf-8?B?dVZXR1FXOURUeWlrMHpkc1FXNnVRemhBM0FMbFlwcFNMMnpseU90TFM5Q2Vy?=
 =?utf-8?B?cFVzODRhUC9QaWljWTJ4U3ZqSDVzMlE1TTRBQ25salVFOEZoa3RXVXhUM1h0?=
 =?utf-8?B?Y3h5TWUxQ0lXR1dZVkdubThBc3lTSytTdzhFOVNLYzBUUlRJSjNtdnV4cjNL?=
 =?utf-8?B?YXYyNUl5RFd3T0hwWDdCaE1HcllUTDMyZThqUHdDa1ZxL01rRnAxSjh2U25i?=
 =?utf-8?B?QTdLZGpjYnV6RGpuWFptVXJ3YjhwN0VqSnhFUW5aZE40RGhaN0NnNEMzRVhU?=
 =?utf-8?B?OThhdVFqcG1QZm0ydGlnaXRQa1dQNjV1V1FqMHFEcFpPbERWc2tCcllNbHVl?=
 =?utf-8?B?QzRwS0NmV2VHaE5PTVdFMlE4eUlGOWVkRkpyVUV0aGFTSnlPQmZJYW45M0xQ?=
 =?utf-8?B?aEhHekdBMitQUngvWnNuem12aFovVmdTL1JNRmdibTFLMnI5YjFVNCtCUk1v?=
 =?utf-8?B?YUdqNmhJZnVtWFJUK2VXTWdNdWFoby8zREowWVBralVpZ0FVd0tQT2xuUDln?=
 =?utf-8?B?VFVhcXJhNncyUFNGU2dzaldLbWdhYkt5M3pMZU5sUGdXcDdlZE5JSHMwTUNW?=
 =?utf-8?B?eHg2aUlBdE91WjNOdkhFcHhiV3BaZ2tJOHNYZ21WSkhwQW9EUDNnOE1tSTJq?=
 =?utf-8?B?MW9IN0g2K3F1NDlkTUpaNVVoYVgvZkRBY09yc1ZKNEN3VUVhekN0dUNMM0lZ?=
 =?utf-8?B?dFdGOUhmNHB2VUJyNEpyOThTOUtSejRZNVFlVVdaVDU4bWZxdUZmbXlmN05E?=
 =?utf-8?B?OGwrL2xiNzdkVGdMYTRrVUVJendPZjUvM2taOW1lQ1dVWnlJR1FVcWw4WURZ?=
 =?utf-8?B?T2wvMVZBc25LdzFrZDE3amY4TzhPYUZMRVpNb3ZsUXRlY2M4Uk95TWtIN0Y0?=
 =?utf-8?B?UjQyRldoa3psSU5pMnNFd0xITDVuSXcxTDRkMHFBK0dsdVVaWTgxSjZKaWs4?=
 =?utf-8?B?QS9VUCs4T3FkYkFWN0pSbFNPVlY1cFBkTG85WGgyb2RqUmd2bEZzYnAxQXJS?=
 =?utf-8?B?U2duS3ozRmgwNytoNG5CNytNR05MKzMwcktDRFhxVHQydDZsT3QzaE4rNnhk?=
 =?utf-8?B?NjVYa1F5bEp3U3ROK3JpWDkrM25KVE92dDZibUtJRTZqOGlWYXpFcXBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3J0a1dXMVNqM29yaklKbGNCdlF2SENWdmlPVURSalpBb3ZaSmJXdWhoMjhp?=
 =?utf-8?B?TGlpeW0vaDFPMk9Fb3F0OTc4VnI3WG54Y2RuWmh2Qzh2YVk0aVBzZW83bU9Q?=
 =?utf-8?B?TUJoN3pkUDBwYzdnQkxHamVHK1NSK1ZjSklYMHpSYlk1WVVXWURTU0tjNzQx?=
 =?utf-8?B?THJIM1ZLd3BhTnNxZGZSWUxkM0tiRDAzamhFcngvNGRRcUxaYjdHTEFOZVpi?=
 =?utf-8?B?cDhwdFRSYnBvZzlLZEpjdXViYXE1eUIvZTRaMXgxUmZOWVNsZXBLWjMvMHAv?=
 =?utf-8?B?Skk5UnlkdHFUYjNjMmRUcFhsZ2RrcmdKWlFNWElaQ09NZytqd0dYTDcvWk9w?=
 =?utf-8?B?b21UdTdhczUyOVJ4Rzg5QjlTYmI4STNERkFjRkozOXh0SDNmVnJ1V3ZtUHF4?=
 =?utf-8?B?YzV2OU44bndWWU45SkF5SkZKdE0xTFFZWkgwMXFwb0pBYU5GU0FwS3VtNlNQ?=
 =?utf-8?B?eGxuMEJaTHh0N2V2RThzUlBML0Nva1dpelBLN2h3c0hvUVBSZ0xRMUdjYXh6?=
 =?utf-8?B?U3NGSWdFVk81MXk5bTFGd1dzanNFUUVmbnpzU3NMcDVLVW5LeGF1NHlCa3J2?=
 =?utf-8?B?VXJuSzRubkZvQko1cHFidUROWTRleGNkZzV0OVJ3UHU1N1BMNnZvQnJFa3Z6?=
 =?utf-8?B?NXNrZlJxbm5RNXdmdk9EWFR2OFlQVDdWRm1taWFudklYV1k4bTNMUE1jWVhK?=
 =?utf-8?B?ckJXWTZ1QzB4R0lHUTdHVDkzeVRVaUIrNVd1MUVrYVkrbStnc0FrZGpnK0M5?=
 =?utf-8?B?SWZXT25uNWZ2eVJVbDVzdHBnVEhkYVQ5U1lDR2l2YkFuSWNheDNMQjN3MGdX?=
 =?utf-8?B?bjNOOGdSUGphYXh6Wnp2TG9XcGpYZytLY01odlRhSFJNMU9OeTlvNlAweDZM?=
 =?utf-8?B?dU9nRGh3N2lORlBuUXBDamRvbXJRbEVJWFFCb0tMQzlESWsrcFhzUXErd0FO?=
 =?utf-8?B?bWZXRTByRXlpOHZGZS9uZm0xVEgvZVNWZ0wzSVNjMUg0M0RXYUF3SEdWMTNL?=
 =?utf-8?B?eGRmano0OTJZWlNYNW9ZUU1RSEI5VXcrcE9ZOUNET052eWF1aGp4WThnY0F4?=
 =?utf-8?B?QUlSOHp6T2x6clVJck5aaVc1RXdUYWVTb1NNcDd1Szl1YTlKL1FnbU0xQXp0?=
 =?utf-8?B?Q3FzanpBVlhXLzVhU21UTHlCOWdNQTBTeEE4VnpucGdjMzZRaFNFOStpcUIz?=
 =?utf-8?B?Wkt4OHJMTkRwYXVUc3NteTlYQk9uSXFTQkRBNTNLV0NKcitjc0hJK0xJa1BX?=
 =?utf-8?B?Kytmd0NOa0ZEVnBCQ0VPS3JEUFhWTndDK3kzcFdBOXF5ZFRZTUR0Yms5SkdN?=
 =?utf-8?B?Y2pQblBqbUI0OVF5UTFVajA5V3dqV3VNV3FKWGY4bXVweTRGZWxZT1czelRP?=
 =?utf-8?B?cEV6QlRkN0NuTnphTms5REZKVVNuLzlUL2ZVMVRiaGNTV1N5VlNBT215aW8r?=
 =?utf-8?B?SlZTeDd4ZU1SZXFrMDJXK3FRdW9qYVJjK1IxMDh2TWxLd1lhWHViYWJVL0Qw?=
 =?utf-8?B?Z3AzOTBNMGhqcGxneTRHUlVZU0ZPNTVpVXROUUY4VXhnMHlrY2szQmVOZzRM?=
 =?utf-8?B?UGlXaHZLRVErcHZObHkreCtxQmFuWXhZVjlWSGJIOVJhbHFoTmY3WVVTK1ov?=
 =?utf-8?B?b1ZIYUdXakpKZTFCVktuQWdGZnBiV083VktwK21GaGM3N1BGbmphUFoyR2Er?=
 =?utf-8?B?cFlycHJ5dzE4alEyNDc1Mktub0VDWEVNOE1HUllvMHduRTRXdmNrY1BKUTh5?=
 =?utf-8?B?OGwyWXg5UmxSVnZkRUs2d2taQzZxckFacURBWFYzdVFlaTI3VUZkYi9xM1ps?=
 =?utf-8?B?R1lIYStFOWpEWDZYNXIrNTRENGsxV1RyaDFjRTBoSTUvS2xkMHhyWDNqUUI0?=
 =?utf-8?B?eWhKcGpFaEFCOFRCU3dXMklZQ2pWUFhoYU5WVWRUcXdRbzRicjRYY2tUdXdy?=
 =?utf-8?B?SEcyU1k3bU9xL2tDYVd3NjJ6b2tWT1YyalZsZVMzYVdGZGhGN3VHS3Mxd2R1?=
 =?utf-8?B?K3hmUU96U1JxWjc2VmM2S3B0ODRjTjF4REtGRlhWVFp4ak1vRFpVK0lhK2dL?=
 =?utf-8?B?bE12NXZiTlE0UkJGMld1WjFJZWdrNVlVb3lBTlFUbkRrTkd4UjBrRll3Z3BE?=
 =?utf-8?Q?G1yM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397c55ec-5c47-4c34-856f-08dce96a9f99
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 20:32:13.4587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2cI2ZltgM0vAKmJxrMX2YFhXbYOyWtY3Up2DffZ3JkK2zwN1tZkrsGfuGSlmNTH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8259

Hi Tony,

On 10/10/24 13:57, Luck, Tony wrote:
>>> Why have this complexity in mbm_assign_control syntax?
>>
>> Lets take an example:
>> $ cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
>> Total 32
>> Available 30
>>
>> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> //0=tl;1=tl;
>>
>> Here default group has taken two counters.
>>
>> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> //0=_;1=tl;
>>
>> Here default group has two counters.
>> Domain 0 does not have counters applied. So, you wont be able to read the
>> MBM values for domain 0.
>> Domain 1 has both the counters applied.
> 
> Is there some benefit from doing this? You are still using the same
> number of counters. You now can't read them from domain 0.
> 
> You said the counters are system-wide. Does that mean that in 
> this case:

Counter are system wide. We also keep track if the counters is applied to
specific domain or not. We have two bitmaps to keep track of this.

There is a cost to applying counter to the domain(IPI needs to be sent to
the domain).


> 
> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> //0=tl;1=tl;
> 
> there aren't separate counts from each of domain 0 and domain 1.

Yes. There is. Each domain has its own count. I am not sure about your config.

# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
 //0=_;1=tl;

# grep . /sys/fs/resctrl/mon_data/*/*total*
/sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes:Unassigned
/sys/fs/resctrl/mon_data/mon_L3_01/mbm_total_bytes:22976

> I.e. if I read both I'd see the same value (sum of traffic on both domains):
> 
> $ grep . /sys/fs/resctrl/mon_data/*/*total*
> /sys/fs/resctrl /mon_data/mon_L3_00/mbm_total_bytes:260039467008
> /sys/fs/resctrl /mon_data/mon_L3_01/mbm_total_bytes:260039467008
> 
> -Tony

-- 
Thanks
Babu Moger

