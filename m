Return-Path: <linux-kernel+bounces-532525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8B4A44EED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51E877A498A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FB020F08F;
	Tue, 25 Feb 2025 21:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b0g+M5YM"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10BD19CD16;
	Tue, 25 Feb 2025 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519110; cv=fail; b=sLmEwCb0PzE/2WocNiUXaXl99k3A85yJnbXiTJ/ULYZ0KRxmbBNwOUZudkgNQ6BhGSG7gfs37o2Wh9kyhwLISjQIkqmaF7LF9g3zOaAnbZXfQh+d6kWZhn0SpnRtKLKoPW9k16K9ZphUCkqamS67VbuWq7uChgcFfueI67+zSqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519110; c=relaxed/simple;
	bh=1NgEppEgrZjUdsTAdmWHsumaIDKezpf4eBbFfH0jaOc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VJHveue3DUDeyBEAbwmYsetTCNkObonIajVUJMpMIP28jT1v2HJJFFzE6mJxVCMIgabpxwmA91rMNCfo2VBpAPuaBnBGxRobpZQSAgu7ywHiGW8oA8w3JLL68JTeJ2IS03x0mlgymIG9JHgkHiAOHERvM1S4tcuSFcUy8dZ67QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b0g+M5YM; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgmMqTZypc1A7I1z1VCEqRoL25D6QcxE+Eqw7xs3xkwxZXIoQdR3v1wHcYU1lEptRhRP+p2TbOQ6dngvpGBhy8xno1h6y5KlAtJuNLTvmWePglJOgdioFQ51pR7l7XDABk1vnYQ4AmMahb+iWRO8uaeQSF2773W2Io00ijMqgI6kqGoj3q/++H0mo0Thdd5rvKXFhWgJUCIe9cxdSpy9sfZMxMunDDOnEmZdQDky/V4wlkfbaZ9foK7A7TqTtKncxjAO2LK+smpttNlw2J9eG1BKwD7OFtXJiZuT8k0dYJjSKnecoT6RdWtPPv7dqifA5050+acm2m1jrVGfyRBd7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORgBba5qM6IVM8wixN4DYUf6dy7SiDiMJpoH1P9XXjU=;
 b=kNNnDheNQDONQxYsdjTfjSm4qzcnRCZKCLmgZhf8eruY6O0FhF0nWWCbCCtXNobbZ6k1FuIqmhp0N7TQ87TYEBtRF5+136xXQnb18xtZrpUqojK4DScs1phDj6WuC0FE5jYzKMrGkubIpJ0cT+zTrejVBbhZMTgX5US6B7+ZIAep6KM1pG2V6awx30GEqzhSXp6Vut/dJJJJz0peKclq9Vxb5N7+EFL6eDUf109hSPrBv+lkFMEkC1BWM/QqiBgetnnkJloHGV/hDWA+oKJOL/c7sStU62Q+7FlA+aSdiO2xnD6Gd9xrlTFloADzwFWJADGJnQcd8N8v6P4K6MSX9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORgBba5qM6IVM8wixN4DYUf6dy7SiDiMJpoH1P9XXjU=;
 b=b0g+M5YMZ+4IejeoqAKwOhuIuyri1UQnSCPMq74xdxRN9Q1ZbDntaxIFzaGsSdR29VQOlgJqlj3tC79ltwzJGSmC8J8q7/5Ml0nY22k6xkLNtbgE7ufYbtvSbVgotKN4/qFbq1fgK1jCsXLuW333UFb9XLLFyGNwmQIIPu8wQp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 21:31:43 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Tue, 25 Feb 2025
 21:31:43 +0000
Message-ID: <a9078e7d-9ce6-4096-a2da-b2c6aae1e3ed@amd.com>
Date: Tue, 25 Feb 2025 15:31:38 -0600
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Reply-To: babu.moger@amd.com
To: Peter Newman <peternewman@google.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: "Moger, Babu" <bmoger@amd.com>, Dave Martin <Dave.Martin@arm.com>,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, tony.luck@intel.com, x86@kernel.org,
 hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
 thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <ccd9c5d7-0266-4054-879e-e084b6972ad5@intel.com>
 <CALPaoCj1TH+GN6+dFnt5xuN406u=tB-8mj+UuMRSm5KWPJW2wg@mail.gmail.com>
 <2b5a11e3-ee19-47ba-b47e-b7de2818f237@intel.com>
 <CALPaoChXvLNMg240C7RyBvg0SxXfGf_ozKC6X7Qe4OxyEcL2tw@mail.gmail.com>
 <a3b46f6f-a844-4648-905e-53d662e5715f@intel.com>
 <CALPaoCi0mFZ9TycyNs+SCR+2tuRJovQ2809jYMun4HtC64hJmA@mail.gmail.com>
 <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
 <CALPaoCg97cLVVAcacnarp+880xjsedEWGJPXhYpy4P7=ky4MZw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALPaoCg97cLVVAcacnarp+880xjsedEWGJPXhYpy4P7=ky4MZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0178.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a460bb-c13e-45a1-7183-08dd55e3cc79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzZZV0ZTNVg2c21yRzQyTEE0VElMbHB4eS8wTHMvMms3SUd2NlZQa1NISnF6?=
 =?utf-8?B?aHQ0bkFRSGh6MmJUQ2c4WjVtenlvcnFFTHdlZGdrU2VFWmpNOUY1cmJ5NHRJ?=
 =?utf-8?B?MW9CUHFSbzROYUJVenhYcTJ4ZlByc0NtdEZ0NTdlaWduVUVxS1EzK2lKM2xy?=
 =?utf-8?B?UENGdTlxR1l4cTRVK2NKU3AxSDZTaWdGVVJJNmQ1aldpQW9NUm0zYU1rS2g1?=
 =?utf-8?B?R3d4UU0xSG5XSjM4c01sSklvdnpMQXBBWjE3RFJCdlpyakQybDludnNaWC95?=
 =?utf-8?B?TWlNZWgyNlVMdmhGQjlsWDUwY00wZG03bStOQ3Q4R0p1UEJPS0MwSFRESkZL?=
 =?utf-8?B?dkpLN0xuRk44SlA3NG4yTitOb2tjZEtXTHF5bVBXVUxxYW1VTm81b0MrK3ZU?=
 =?utf-8?B?dEFjSzl3bTBtbDB3amRsVXBOVUZEbDgrdXpzVytocmRKU2FDRHRCUlQ2V3py?=
 =?utf-8?B?ZmRXU3plVSt5djJoSXZpcnozNWJJTnpNbk56OHk3QTc5N3dNU0ZCVVE1SXdx?=
 =?utf-8?B?Tzl4NGxucXV1cWVEVXZwcGg0ZXpSc1lsYkloOGlONWplZUg2OTduZERVWGZz?=
 =?utf-8?B?d2xvTUJJb1gvWDFOY05XOHZwRFlyNFEyc0VXZTJMdmxaTXp1RHU5UGwrUUs5?=
 =?utf-8?B?MG5oMnlUUldEdXkvWXZqWS8zVEFxcS9za0FPOWlPaGZXbDZad2JWamZTRjBu?=
 =?utf-8?B?L3ZpbnQvZ05wME1xdWZwcGhLNitQeHpFOVk1QzR1SmFsWW5jVmhVTnNweDFW?=
 =?utf-8?B?em5mTDlYZEoxVUpwU2xqZEZJVm5kak1oQ3dxOTFQbzFYdTY3c0x5UTZ3cnpR?=
 =?utf-8?B?RXVOVHZMTDJWemZUWmJCVDFEUzNUd2xsK0pJcWxUc2RsT1lBZnBoK3Y2YWdJ?=
 =?utf-8?B?aGlCdmdIVnRBdmpjOCtYZTBSWCtVQ0dXRHFWN2VLR3BuYXMwQ25Ja1ZnMjBR?=
 =?utf-8?B?cllOQ1A4d3dDdkJKOW14YzZtdElQaStEcnY2cGVjV2IwNE5icnJrVm5ESHdW?=
 =?utf-8?B?K0VBajVQOXB3K1g5N0hkaXRyOHpsSWtjTHJOS0ZUblZMMWNUNjNCKzlJN2tO?=
 =?utf-8?B?UU4xYnFucGg2ajlmMTBoWjhLeTVEamY2bVpZUmIxN0pzOWR4R1JPaU5mVFE1?=
 =?utf-8?B?ckREM0s2ZmJ0QWJKUVZ6cnNZU0libXBYSXE4ekhON1NlRTZlQkVHek52cmNB?=
 =?utf-8?B?N0xKd0hzbytXZllDa0hQWjV0S3pYWlRJVTZYS1pHeGd0SVQwZEY3bVIxUnNS?=
 =?utf-8?B?bTlZbmtUL2xjV3VxVmhDaTVkSmpWdEMwT0lHekFPcUVJai9RWmo4cFhGbjZV?=
 =?utf-8?B?TmQyKy9oaFBHQUtqSDBlWlEycjdoRnJzeTFzeFNFbVhUZ1ZBOXR3eENuYWxQ?=
 =?utf-8?B?VUpnaGw0OTFZQWh3RW95aEhZZzBteWJaTjh5eGw5OGQ3YXRzbUwxa3hURTVq?=
 =?utf-8?B?ZThnanA4K3lOdmxUY2ZjMmF6SXYvTitwRnVOdVF3bXV2TVE1T25MdzRBWnM4?=
 =?utf-8?B?ckF2cXUwSnNWemxMZ3Z0U2Y4bHpCM2FHQzk5NjBwZEpCTWwxa0FZZzRYbWZQ?=
 =?utf-8?B?SWVYRzB2WnJnc2FqOWVoRk9qRGdUekJEWVROV1VFMlZ2cTN6RE5nNDg2dGtr?=
 =?utf-8?B?bTJvcExOMVpsRXhNR2NTdkhYM2wrUnhBWEM1eFdGTENJcXhLREk0SXJNaTk1?=
 =?utf-8?B?RnlCdVN5RWZYYlpqQmFsYk82cGVUZzlBZzlINnQ1TjJyZlBVMnAwT0UxMlUr?=
 =?utf-8?B?RWJvaFA1U09pdDVGemJlZE1iRU1xN2xEd1N6aXhCbnM2Y0EyNnljSFczdWZC?=
 =?utf-8?B?RU01Nnd1U2oxZllMRDRTdkppWDI2OHJMdm54cFc1bVM3dFVYZ3Jldllqa1Mr?=
 =?utf-8?Q?+AABhpOtcZPoe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejZZYlVKckxpTTlDaXIydmRVSkdOT3hFNEZGNEJBTWRDdzY2YnpvWnVlN0Mw?=
 =?utf-8?B?eGFrcC8vTTBPaC9WTXJJS1RJNjIvdDZ0TDBWRmR4TXdRdmhXUWhncEQrNGxO?=
 =?utf-8?B?K3JzZ0llV2JDOEVrZnpCd2NIbUFFSnhOclhBRmErN256dVptOElNcDFnYVN4?=
 =?utf-8?B?MlljUXhmUkRpTHBMMWpwd3lvQTY3Z24rYkdHRnNsUmU5MnJJVGpFYitibnc3?=
 =?utf-8?B?NTc5L0pRMUpnOUMzTmNMdVRob2NCZURPaTVBbHFyL1pQTk5TMWVxUFJmcVI5?=
 =?utf-8?B?L2w5dmo3TmJFdWRGaU5qMkcwSTR6OWpSVm9Pcno1MUs0UjJoQmxqT3R2bitj?=
 =?utf-8?B?U2FZaDQyOUVBZnJoZ1NqMG5EL1dtT3M0azRPbktBQ1psWjJBN1VhazV4SGFF?=
 =?utf-8?B?N1IwWFhKV29YQ0dSL0JVT1BYSitXa3Y4cm4vN2xnWENUUlFIczBocUhKMTd6?=
 =?utf-8?B?SllnSVZLa1FLOFh1TDU1MXVwWVZhL05SczlnTXo4M1hUamU2Z1FmalR4WUZ0?=
 =?utf-8?B?REc4b3RUUktkd1dPb0RkY3gyVjJ3UXVaQ2J1YXliWGI5NkpDZ2dVeENNcklI?=
 =?utf-8?B?WHFNcld0RXIvdEI5T0RLSFZXcGZvRUJFZSt4UVF1R1BYakNwWFJ5SGZmcnI3?=
 =?utf-8?B?WDM2YUV3blpJaENkRC9wQnJKNlVKSE5LNzBHbVc0Q2hFZzZ2K2J4N2MzempE?=
 =?utf-8?B?NkxqaVNBSzVoMlM1SHNiZnN0c1VJOG13a2ZEdTJPaWJ5dXFIeDdMYUo0S1Bv?=
 =?utf-8?B?SW5TR0g2RkVmdUE2N0dlVCs0Nm51NlF2UUluVEdFMVcwV1hGdmwwaXZXSUZh?=
 =?utf-8?B?NCtrMzNtdjFTbWI4WVdPeDBRQlFHWlUzY1pWR3dta3hWeVlSZHFJdjEzSVJE?=
 =?utf-8?B?b0ZjbjRaZmNFanNGVmFXVzhoWkoxWHIrNTE4bGdxZTNnTHZDT2x1K3lLR003?=
 =?utf-8?B?MUhSNlFNZlNxcVFsVTlZN1ZjdTBwbnltaU5qWXl6SUR6RkxHbGlocy91Nm9p?=
 =?utf-8?B?WVJPSENiQ09pR01ERnVDcDVCUWJHYTNHYkhhUEJuZUpiYWhhejdGY3NLSEJ3?=
 =?utf-8?B?QnVPT0RqRzI1K0FkRENSWnRjTm9IRlNEMm05Z0VyRWxaMXlTTHBaTVA3SXl1?=
 =?utf-8?B?NExwbXo2WFhlNmRSdzhlN2hsUFA1Sy82S2d1aFlYMFBYZkN1azZIYWE0TE9z?=
 =?utf-8?B?WUdPRURUVE1kalJEemM3ZWFXOGJRa3BRRk1VclpGOUh4cWVMRHJoMEN1WVp6?=
 =?utf-8?B?Q1RYRW1GNURUY2hwVkJzWUVBeFhrTlk1VWFxbUo3RVhOYVN4S2N6ZTJHVlA5?=
 =?utf-8?B?dEsrbFAzY25TdGZUdjhQYjBmck9GMWg2bFczWVkvSCthVklrU2NiUStkQ1Iy?=
 =?utf-8?B?L2ZPTDZHZGxsUWZEVjdsSXdZcVZNa1E5ZHcraldpTEswa1FMU0ZuUHo4L2Jh?=
 =?utf-8?B?QjRuTC9vdVJ0b0FXWUNMMVRMM0FlaUxLRmxKT3l0Q1NMZUFSM0hQNG9McmZD?=
 =?utf-8?B?WVFGZmlsVDRnN2xUWkxuSE9vU1R3UkRDbTdHbTcvMGhBMDV4cVdyWjFZUThr?=
 =?utf-8?B?TWlWM3liYXRWVkdESi85VUh4Qm1jNEQyVGFJODVpWjZHWnQyQ0FwM2xFdVdp?=
 =?utf-8?B?S3ZqUFdqZFJ1QjJHWWZlcXUwbjFOTlJrNmRGZFdvMmZaWXNrYUhYSFluczF4?=
 =?utf-8?B?QWdBTEZoQUtXalJVVWJ5WUJqcGVWZmR6TExKSVNZT1pFeXg0bXdkR2tLVUpZ?=
 =?utf-8?B?SkduUkh1bkxIQktUUFNwZEtzVVVrTlRFeHpjR3ZlTi95dGY1V3NPamIyUVZw?=
 =?utf-8?B?cUUxOS8rK1Q5VHd6OUU2S2JQQWdtN0FEd0pzZzB3a0JBdE5aYXVoNHBWSXFw?=
 =?utf-8?B?aDlGako4OC9JUGtCV1l0K3poekM0dHpoOVVsTndVUkhEc2lpd0NDQlNxem9P?=
 =?utf-8?B?TFEzcHQxRlFXa2Vpd3VPOTdhREE0WFN5WUVkajNBcENITkJBZHkvcWc0SG42?=
 =?utf-8?B?cmswaGNUTDdPTVNPRFAvWmtqWm81Rk5walgyYVhOUlNjT0QwaC9PenY2Z0hi?=
 =?utf-8?B?Z3F5YjdGbjdWMXpEK0hRelQ3bnIwK2dHTmF0S2VoVXVKK2VxY0o5c2Vrcm8w?=
 =?utf-8?Q?eraU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a460bb-c13e-45a1-7183-08dd55e3cc79
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 21:31:43.4963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1EMCBi9U42kcDsgNivEveIw8g97OhIfq5O2hfe9h155tZ+sjhsfqZIsWEwNQ1My
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553

Hi Peter,

On 2/25/25 11:11, Peter Newman wrote:
> Hi Reinette,
> 
> On Fri, Feb 21, 2025 at 11:43 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> Hi Peter,
>>
>> On 2/21/25 5:12 AM, Peter Newman wrote:
>>> On Thu, Feb 20, 2025 at 7:36 PM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
>>>> On 2/20/25 6:53 AM, Peter Newman wrote:
>>>>> On Wed, Feb 19, 2025 at 7:21 PM Reinette Chatre
>>>>> <reinette.chatre@intel.com> wrote:
>>>>>> On 2/19/25 3:28 AM, Peter Newman wrote:
>>>>>>> On Tue, Feb 18, 2025 at 6:50 PM Reinette Chatre
>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>> On 2/17/25 2:26 AM, Peter Newman wrote:
>>>>>>>>> On Fri, Feb 14, 2025 at 8:18 PM Reinette Chatre
>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>> On 2/14/25 10:31 AM, Moger, Babu wrote:
>>>>>>>>>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
>>>>>>>>>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
>>>>>>>>>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
>>>>>>>>>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
>>>>>>>>>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>>>>>>>>>
>>>>>>>>>> (quoting relevant parts with goal to focus discussion on new possible syntax)
>>>>>>>>>>
>>>>>>>>>>>>>> I see the support for MPAM events distinct from the support of assignable counters.
>>>>>>>>>>>>>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
>>>>>>>>>>>>>> Please help me understand if you see it differently.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Doing so would need to come up with alphabetical letters for these events,
>>>>>>>>>>>>>> which seems to be needed for your proposal also? If we use possible flags of:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> mbm_local_read_bytes a
>>>>>>>>>>>>>> mbm_local_write_bytes b
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Then mbm_assign_control can be used as:
>>>>>>>>>>>>>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
>>>>>>>>>>>>>> <value>
>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>>>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
>>>>>>>>>>>>>> assuming that upper case would be used for "shared" counters (unless this interface is defined
>>>>>>>>>>>>>> differently and only few uppercase letters used for it). Would this be too low of a limit?
>>>>>>>>>>
>>>>>>>>>> As mentioned above, one possible issue with existing interface is that
>>>>>>>>>> it is limited to 26 events (assuming only lower case letters are used). The limit
>>>>>>>>>> is low enough to be of concern.
>>>>>>>>>
>>>>>>>>> The events which can be monitored by a single counter on ABMC and MPAM
>>>>>>>>> so far are combinable, so 26 counters per group today means it limits
>>>>>>>>> breaking down MBM traffic for each group 26 ways. If a user complained
>>>>>>>>> that a 26-way breakdown of a group's MBM traffic was limiting their
>>>>>>>>> investigation, I would question whether they know what they're looking
>>>>>>>>> for.
>>>>>>>>
>>>>>>>> The key here is "so far" as well as the focus on MBM only.
>>>>>>>>
>>>>>>>> It is impossible for me to predict what we will see in a couple of years
>>>>>>>> from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on resctrl interface
>>>>>>>> to support their users. Just looking at the Intel RDT spec the event register
>>>>>>>> has space for 32 events for each "CPU agent" resource. That does not take into
>>>>>>>> account the "non-CPU agents" that are enumerated via ACPI. Tony already mentioned
>>>>>>>> that he is working on patches [1] that will add new events and shared the idea
>>>>>>>> that we may be trending to support "perf" like events associated with RMID. I
>>>>>>>> expect AMD PQoS and Arm MPAM to provide related enhancements to support their
>>>>>>>> customers.
>>>>>>>> This all makes me think that resctrl should be ready to support more events than 26.
>>>>>>>
>>>>>>> I was thinking of the letters as representing a reusable, user-defined
>>>>>>> event-set for applying to a single counter rather than as individual
>>>>>>> events, since MPAM and ABMC allow us to choose the set of events each
>>>>>>> one counts. Wherever we define the letters, we could use more symbolic
>>>>>>> event names.
>>>>>>
>>>>>> Thank you for clarifying.
>>>>>>
>>>>>>>
>>>>>>> In the letters as events model, choosing the events assigned to a
>>>>>>> group wouldn't be enough information, since we would want to control
>>>>>>> which events should share a counter and which should be counted by
>>>>>>> separate counters. I think the amount of information that would need
>>>>>>> to be encoded into mbm_assign_control to represent the level of
>>>>>>> configurability supported by hardware would quickly get out of hand.
>>>>>>>
>>>>>>> Maybe as an example, one counter for all reads, one counter for all
>>>>>>> writes in ABMC would look like...
>>>>>>>
>>>>>>> (L3_QOS_ABMC_CFG.BwType field names below)
>>>>>>>
>>>>>>> (per domain)
>>>>>>> group 0:
>>>>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>> group 1:
>>>>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>> ...
>>>>>>>
>>>>>>
>>>>>> I think this may also be what Dave was heading towards in [2] but in that
>>>>>> example and above the counter configuration appears to be global. You do mention
>>>>>> "configurability supported by hardware" so I wonder if per-domain counter
>>>>>> configuration is a requirement?
>>>>>
>>>>> If it's global and we want a particular group to be watched by more
>>>>> counters, I wouldn't want this to result in allocating more counters
>>>>> for that group in all domains, or allocating counters in domains where
>>>>> they're not needed. I want to encourage my users to avoid allocating
>>>>> monitoring resources in domains where a job is not allowed to run so
>>>>> there's less pressure on the counters.
>>>>>
>>>>> In Dave's proposal it looks like global configuration means
>>>>> globally-defined "named counter configurations", which works because
>>>>> it's really per-domain assignment of the configurations to however
>>>>> many counters the group needs in each domain.
>>>>
>>>> I think I am becoming lost. Would a global configuration not break your
>>>> view of "event-set applied to a single counter"? If a counter is configured
>>>> globally then it would not make it possible to support the full configurability
>>>> of the hardware.
>>>> Before I add more confusion, let me try with an example that builds on your
>>>> earlier example copied below:
>>>>
>>>>>>> (per domain)
>>>>>>> group 0:
>>>>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>> group 1:
>>>>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>> ...
>>>>
>>>> Since the above states "per domain" I rewrite the example to highlight that as
>>>> I understand it:
>>>>
>>>> group 0:
>>>>  domain 0:
>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>  domain 1:
>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>> group 1:
>>>>  domain 0:
>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>  domain 1:
>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>
>>>> You mention that you do not want counters to be allocated in domains that they
>>>> are not needed in. So, let's say group 0 does not need counter 0 and counter 1
>>>> in domain 1, resulting in:
>>>>
>>>> group 0:
>>>>  domain 0:
>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>> group 1:
>>>>  domain 0:
>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>  domain 1:
>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>
>>>> With counter 0 and counter 1 available in domain 1, these counters could
>>>> theoretically be configured to give group 1 more data in domain 1:
>>>>
>>>> group 0:
>>>>  domain 0:
>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>> group 1:
>>>>  domain 0:
>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>  domain 1:
>>>>   counter 0: LclFill,RmtFill
>>>>   counter 1: LclNTWr,RmtNTWr
>>>>   counter 2: LclSlowFill,RmtSlowFill
>>>>   counter 3: VictimBW
>>>>
>>>> The counters are shown with different per-domain configurations that seems to
>>>> match with earlier goals of (a) choose events counted by each counter and
>>>> (b) do not allocate counters in domains where they are not needed. As I
>>>> understand the above does contradict global counter configuration though.
>>>> Or do you mean that only the *name* of the counter is global and then
>>>> that it is reconfigured as part of every assignment?
>>>
>>> Yes, I meant only the *name* is global. I assume based on a particular
>>> system configuration, the user will settle on a handful of useful
>>> groupings to count.
>>>
>>> Perhaps mbm_assign_control syntax is the clearest way to express an example...
>>>
>>>  # define global configurations (in ABMC terms), not necessarily in this
>>>  # syntax and probably not in the mbm_assign_control file.
>>>
>>>  r=LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>  w=VictimBW,LclNTWr,RmtNTWr
>>>
>>>  # legacy "total" configuration, effectively r+w
>>>  t=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>
>>>  /group0/0=t;1=t
>>>  /group1/0=t;1=t
>>>  /group2/0=_;1=t
>>>  /group3/0=rw;1=_
>>>
>>> - group2 is restricted to domain 0
>>> - group3 is restricted to domain 1
>>> - the rest are unrestricted
>>> - In group3, we decided we need to separate read and write traffic
>>>
>>> This consumes 4 counters in domain 0 and 3 counters in domain 1.
>>>
>>
>> I see. Thank you for the example.
>>
>> resctrl supports per-domain configurations with the following possible when
>> using mbm_total_bytes_config and mbm_local_bytes_config:
>>
>> t(domain 0)=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>> t(domain 1)=LclFill,RmtFill,VictimBW,LclNTWr,RmtNTWr
>>
>>    /group0/0=t;1=t
>>    /group1/0=t;1=t
>>
>> Even though the flags are identical in all domains, the assigned counters will
>> be configured differently in each domain.
>>
>> With this supported by hardware and currently also supported by resctrl it seems
>> reasonable to carry this forward to what will be supported next.
> 
> The hardware supports both a per-domain mode, where all groups in a
> domain use the same configurations and are limited to two events per
> group and a per-group mode where every group can be configured and
> assigned freely. This series is using the legacy counter access mode
> where only counters whose BwType matches an instance of QOS_EVT_CFG_n
> in the domain can be read. If we chose to read the assigned counter
> directly (QM_EVTSEL[ExtendedEvtID]=1, QM_EVTSEL[EvtID]=L3CacheABMC)
> rather than asking the hardware to find the counter by RMID, we would
> not be limited to 2 counters per group/domain and the hardware would
> have the same flexibility as on MPAM.

In extended mode, the contents of a specific counter can be read by
setting the following fields in QM_EVTSEL: [ExtendedEvtID]=1,
[EvtID]=L3CacheABMC and setting [RMID] to the desired counter ID. Reading
QM_CTR will then return the contents of the specified counter.

It is documented below.
https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
 Section: 19.3.3.3 Assignable Bandwidth Monitoring (ABMC)

We previously discussed this with you (off the public list) and I
initially proposed the extended assignment mode.

Yes, the extended mode allows greater flexibility by enabling multiple
counters to be assigned to the same group, rather than being limited to
just two.

However, the challenge is that we currently lack the necessary interfaces
to configure multiple events per group. Without these interfaces, the
extended mode is not practical at this time.

Therefore, we ultimately agreed to use the legacy mode, as it does not
require modifications to the existing interface, allowing us to continue
using it as is.

> 
> (I might have said something confusing in my last messages because I
> had forgotten that I switched to the extended assignment mode when
> prototyping with soft-ABMC and MPAM.)
> 
> Forcing all groups on a domain to share the same 2 counter
> configurations would not be acceptable for us, as the example I gave
> earlier is one I've already been asked about.

I don’t see this as a blocker. It should be considered an extension to the
current ABMC series. We can easily build on top of this series once we
finalize how to configure the multiple event interface for each group.

> 
> I'm worried about requiring support for domain-level
> mbm_total_bytes_config and mbm_local_bytes_config files to be carried
> forward, because this conflicts with the configuration being per
> group/domain. (i.e., what would be read back from the domain files if
> per-group customizations have already been applied?)
> 
>>
>>>>
>>>>>> Until now I viewed counter configuration separate from counter assignment,
>>>>>> similar to how AMD's counters can be configured via mbm_total_bytes_config and
>>>>>> mbm_local_bytes_config before they are assigned. That is still per-domain
>>>>>> counter configuration though, not per-counter.
>>>>>>
>>>>>>> I assume packing all of this info for a group's desired counter
>>>>>>> configuration into a single line (with 32 domains per line on many
>>>>>>> dual-socket AMD configurations I see) would be difficult to look at,
>>>>>>> even if we could settle on a single letter to represent each
>>>>>>> universally.
>>>>>>>
>>>>>>>>
>>>>>>>> My goal is for resctrl to have a user interface that can as much as possible
>>>>>>>> be ready for whatever may be required from it years down the line. Of course,
>>>>>>>> I may be wrong and resctrl would never need to support more than 26 events per
>>>>>>>> resource (*). The risk is that resctrl *may* need to support more than 26 events
>>>>>>>> and how could resctrl support that?
>>>>>>>>
>>>>>>>> What is the risk of supporting more than 26 events? As I highlighted earlier
>>>>>>>> the interface I used as demonstration may become unwieldy to parse on a system
>>>>>>>> with many domains that supports many events. This is a concern for me. Any suggestions
>>>>>>>> will be appreciated, especially from you since I know that you are very familiar with
>>>>>>>> issues related to large scale use of resctrl interfaces.
>>>>>>>
>>>>>>> It's mainly just the unwieldiness of all the information in one file.
>>>>>>> It's already at the limit of what I can visually look through.
>>>>>>
>>>>>> I agree.
>>>>>>
>>>>>>>
>>>>>>> I believe that shared assignments will take care of all the
>>>>>>> high-frequency and performance-intensive batch configuration updates I
>>>>>>> was originally concerned about, so I no longer see much benefit in
>>>>>>> finding ways to textually encode all this information in a single file
>>>>>>> when it would be more manageable to distribute it around the
>>>>>>> filesystem hierarchy.
>>>>>>
>>>>>> This is significant. The motivation for the single file was to support
>>>>>> the "high-frequency and performance-intensive" usage. Would "shared assignments"
>>>>>> not also depend on the same files that, if distributed, will require many
>>>>>> filesystem operations?
>>>>>> Having the files distributed will be significantly simpler while also
>>>>>> avoiding the file size issue that Dave Martin exposed.
>>>>>
>>>>> The remaining filesystem operations will be assigning or removing
>>>>> shared counter assignments in the applicable domains, which would
>>>>> normally correspond to mkdir/rmdir of groups or changing their CPU
>>>>> affinity. The shared assignments are more "program and forget", while
>>>>> the exclusive assignment approach requires updates for every counter
>>>>> (in every domain) every few seconds to cover a large number of groups.
>>>>>
>>>>> When they want to pay extra attention to a particular group, I expect
>>>>> they'll ask for exclusive counters and leave them assigned for a while
>>>>> as they collect extra data.
>>>>
>>>> The single file approach is already unwieldy. The demands that will be
>>>> placed on it to support the usages currently being discussed would make this
>>>> interface even harder to use and manage. If the single file is not required
>>>> then I think we should go back to smaller files distributed in resctrl.
>>>> This may not even be an either/or argument. One way to view mbm_assign_control
>>>> could be as a way for user to interact with the distributed counter
>>>> related files with a single file system operation. Although, without
>>>> knowing how counter configuration is expected to work this remains unclear.
>>>
>>> If we do both interfaces and the multi-file model gives us more
>>> capability to express configurations, we could find situations where
>>> there are configurations we cannot represent when reading back from
>>> mbm_assign_control, or updates through mbm_assign_control have
>>> ambiguous effects on existing configurations which were created with
>>> other files.
>>
>> Right. My assumption was that the syntax would be identical.
>>
>>>
>>> However, the example I gave above seems to be adequately represented
>>> by a minor extension to mbm_assign_control and we all seem to
>>
>> To confirm what you mean with "minor extension to mbm_assign_control",
>> is this where the flags are associated with counter configurations? At this
>> time this is done separately from mbm_assign_control with the hardcoded "t"
>> and "l" flags configured via mbm_total_bytes_config and mbm_local_bytes
>> respectively. I think it would be simpler to keep these configurations
>> separate from mbm_assign_control. How it would look without better
>> understanding of MPAM is not clear to me at this time, unless if the
>> requirement is to enhance support for ABMC and BMEC. I do see that
>> this can be added later to build on what is supported by mbm_assign_control
>> with the syntax in this version.
> 
> As I explained above, I was looking at this from the perspective of
> the extended event assignment mode.
> 
> Thanks,
> -Peter
> 

-- 
Thanks
Babu Moger

