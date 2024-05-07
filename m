Return-Path: <linux-kernel+bounces-172145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDAE8BEE13
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2511F26891
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A7918733B;
	Tue,  7 May 2024 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AgBDC9Cv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B092714B972;
	Tue,  7 May 2024 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715113638; cv=fail; b=ZVBCQv/nCnglM2HtWhRwIHVJPH4rHPk3ghjm675Hh+0NcAG+QKd7dhMYercpmxyMVAqdjDlfcc6AjH7riPnrdtHJR3kMiv6WLUy1rLEMDoiFo6J7SHqzcUqvRfYqC7a5JlypFXRNR4hmSPSx0XqV2G8GwdsNoCuldqT7VvEFEQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715113638; c=relaxed/simple;
	bh=tD2/7aQ8KrzhbjYL2A2wkiQutSEHuhIsHbpeDs13Tag=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HdTgWdySIAmg4HtadenS64/v6GJGcfkhIK6bUUy2JhTjnYIYI8vC00nYUTQ4xmRsRFiQzCpXXz/QPjedg8lHW+PpWg/0R2UCBssIofMchAexuupj/Eq84p0rFZhzdvzm1IwwURX0nST70OMUaT2n/KGomo/qFnuIXCRoDcibVCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AgBDC9Cv; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715113629; x=1746649629;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tD2/7aQ8KrzhbjYL2A2wkiQutSEHuhIsHbpeDs13Tag=;
  b=AgBDC9Cve3a3ydojPjlHI7JdIWmvJgbjeG4c5n6Im5yTLe+aeKggw/u1
   NptrT5xkV7DhcGE+s23n8w4F+L/RNqKy8t0ZDenK3OOWIwDYCXJicXd0J
   axX1vRy4uikvyr8o7kr7zeLg2/WTB+Zzn0T+bKtapU4GiD9jvJ4S/bgkD
   5VtUZVWxKTn7RkNud5hQLRURBx7f/flizkA16dOImIIK1dqUyFdOeLWdS
   /599CxAcyZI1ff4QsdJ3g+5OPXmPFuXNTblslNJ+CZvCcc2pBVxqR/gKe
   O330b/SdRxENDMKo/BdhjwRpwYdFmUFTuwhEUFRumAyBeHLCmBCGc/IwC
   A==;
X-CSE-ConnectionGUID: NhAEDaP5SLOI3GZdt2p5sA==
X-CSE-MsgGUID: 6+yidc5xTPmJI8vZwZYLfg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22351634"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="22351634"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 13:27:08 -0700
X-CSE-ConnectionGUID: 2Z+PxKqpTva7CYVUISDBaw==
X-CSE-MsgGUID: KewFF44/Qo2T5rVtxuvmxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="33204486"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 13:27:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 13:27:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 13:27:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 13:27:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWb1REhcMIW7WCpEuZdvRZbDkcr/VnYSrky684d5q7Q4hXc7blZGtbaMDHMaksbvNB69XDPE5BOFY8aywC02Ki5HgQvdyfNsxP9E+CrHENtyzBcDIIa5BP10KztUwVZCfeTKgShSLS1QNALwKkoRCO4PVhK/oHXFeolsxzylPX4wxE9sBTSOjDrZCICG6lb8dVqd2dfg0vUty2q43CS4PPR9Vvi6/L3Zq4BNuXmrsk1M1jMqMDTyTa4QmHtEQXG29Bhnj4HqLisWBtboDo/vpMZKZPK6MUnHHw38XY4FBFvGJvxJJkP/1PMxRgsJiBqGoFkd9iBkvCqTCz53rWCwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oB+iAiU+PpNReapDvQh1we49tmK2Uvl2ws68OoCaW8=;
 b=TJLIKBHbz+cSFOFwrTqbKKpyTTbfGUREmeEx3XjQIZUs9cwLFiD5mhAHjmhamYnGrUdKOL7P8BkLUE/tOTRPm03SArCQ+fMbWx1xYXrtQVmVj2UuBQAyJ5NvC16ND8cpzIPsziz9jM3FmHZeEht2JK/Z06LRZIcJpNV7D2wnbWstStMhN3e8A/JuWoDbxct7BClaclcGdBfeUWHvLV8W/vtpldkDfXnPwRkzYJ1Bsdtb06L12DAXvx234TKjySDKor4oePlmzCyqUp6uLbxCAVY6eRK9XdjmzQR8fiF+QkCK5KwcsqF8nlpenvfARo9JXWNYuOAKMIZI+BF0S0gEvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 20:27:04 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Tue, 7 May 2024
 20:27:04 +0000
Message-ID: <753844b6-b68d-4b05-89b0-3ac36e1c8564@intel.com>
Date: Tue, 7 May 2024 13:27:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 03/17] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
 <63134ddf18208bbd11bcec0ec75c33ef6e5635b2.1711674410.git.babu.moger@amd.com>
 <ac22b96d-c4bb-42d9-bac8-22b9e032b59e@intel.com>
 <80b33bc6-7b70-4853-92a0-718c2d8728d3@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <80b33bc6-7b70-4853-92a0-718c2d8728d3@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:303:dd::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b968bd-7002-4b85-7c3b-08dc6ed40eaa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUV1Y1IwQXptSGhQWXBxYmRMZ3hLYkd1bjhUNDZ2RU1xM3RHNzlOUUw3OG15?=
 =?utf-8?B?YVFadmU0b0NyZVN3b2dhMTlFM00rL3BscFBpUys1d2ZOQ2VKMzNDRVhKa042?=
 =?utf-8?B?YnJqRzhJUzBYck9SWFJsRG92K1h6VGVZSmo1MDBwWCtNYklZd1NXZldZNkxN?=
 =?utf-8?B?NGM5clU5Z1VrTkFZa2d5Vms2ZXhiYW4vUEhzL290RksvUnlXbGZTK3E2aTBt?=
 =?utf-8?B?empBN0swYmlJZmo3MjF6WEVFaEs0K2tjWC84M0NQWi8xNFFZWTlIV2hOY1dk?=
 =?utf-8?B?VEtaeXVEUnRuSXloWlFjWC9mQzh1N0s0WERhUVNsd0dLYmlxWFBPTkp4N2Z2?=
 =?utf-8?B?dU5kL1dVNzVNMmVXaVIyRkZDYUUzaHl6c2lNV3RuVnFFeFhFcWRDcWRWYzVy?=
 =?utf-8?B?MmppS2xzTVpNdjBnS2M2MnpJOXdtazJ1cU1pYzJBczhLYmxpM3hBbmMvWWhL?=
 =?utf-8?B?THdvdEkvQytobWVBWlp0UytTQ2NyUXh0MDJyMU0wMjUrTXdFMkZtUzdudFZn?=
 =?utf-8?B?dk5xNlgzOUJwRVYxR2E1SENHTjc0WGk0QjhROCtFNzNrZ0hRdFVLbzN5NHlz?=
 =?utf-8?B?Y3F0WERGNE04by9GbW1WTHQ0UVh0YmdSY1AzTVJqU0s5OEpaaXBRMU8veE5D?=
 =?utf-8?B?Nm5BUDBYVW9ZRmJsNVBrSmZKeU5LZnJkTEdOdU81VUpneWJEbVFBamxqN2lj?=
 =?utf-8?B?VENlWXBHeFg2Y1JtRG41U0JzNk1xMGRqcnlKaWFBMWd1elU4bkNCU2dEdVZw?=
 =?utf-8?B?Z2dkOTZ0V3dQNEtVaWRoNkpXZU96elg5L2J4NnVxUGdIOHo4dEtYWDkvZjVI?=
 =?utf-8?B?eS81MFN1UXlkNHA3aEQvOUZYZUVHMlVYU2pIdy95WXRKVVF2aXY2bnp0MmtN?=
 =?utf-8?B?a1dXYVVTZ3VuK2FKLytPVnN1ODI2L0R4RmFuUWRNRGtVbEx5U1lBTW02Unpk?=
 =?utf-8?B?cTh5MGJydHE4NWxSNnhxMVFrZmI1WjRTbWNPbWR1YlRWNWxWelV0MXZhTHVs?=
 =?utf-8?B?NWgxNHdTQVFZQWJUOEZVYVUxWWxKVmFHay9EUGdoZUFKRnJHdWFXZUFNYUFw?=
 =?utf-8?B?am5rYlFWZW9Wd0ZXQll4RVRNK3QxSUtzTU5qbE0xL3kzRlNhK3owR2kxTjRw?=
 =?utf-8?B?dVI1ZkV4QzdvUXBEV3RtWStHVWdiVVFmeUY3aWdpY05PSDYvQUtvMzJCeDJq?=
 =?utf-8?B?NHBrbklDL0t6UUs5VThzNmU1bi9hTVVKNjlpL1BiK00xMFN1Ujh2RlZnYWpV?=
 =?utf-8?B?dXVCQU9GY0tTakZacmFJVmM3aWxDZlgvcTVUa3RkMGVOK3ZabHdMcmEyRjY3?=
 =?utf-8?B?ZlhqakFNNm9kUjNaZHN1SHVUbEJBdUZHUEV0ZEJXb0ZtM1RhMzdiTVROWC9J?=
 =?utf-8?B?azVwR2ZmNVNkZ1R1MFlneHgwdDAvNElaNmpGakVyN2hrbHVZVCtwSWo3Z3Vr?=
 =?utf-8?B?ekxsaHV5N1RJN0xFS0F2dGxIRUV2VFYrWFJONlg5VGVLSmZPbU9nK291ZzlM?=
 =?utf-8?B?NGNVNFRnMTBOYWR2cHA5V0VoNS9KS01MOTNjUERkMlJjaHB1dUxsMjI0aDZl?=
 =?utf-8?B?bUp6enZ2dCt4MG53Nk1XYkdXKzFsV1Z1NWdSeGhDaWVZMHhFMTdNRHZiUThU?=
 =?utf-8?B?ME5RT1VGRzMxRDdlbjJLcWl0Z012VEFPQ1Nzb1BWWEdNd1FNZjk1cnFVRXhh?=
 =?utf-8?B?UXBEM2VBVlJsZ0ROOHlIVlU4TXdPdjdxZFZ6c0VwNjlQNEhsR05mMER3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXJZZEN4SDZHUkhGYjhHWjZKT3RYMGUzb3lrdHphd0lOV0Y3TDZGak5MY3Iw?=
 =?utf-8?B?a2ZCUnlwdUFqWnVDVWpkdTdsS3NRU21hdHd5azVOZ1hSNitYWFgyeFcxbzcx?=
 =?utf-8?B?RjduK1RRaURLNVV6RTRrcTJEa0U1aHpST0lMK1FYcTZDcmVBZDlNdk5FR2FL?=
 =?utf-8?B?YU1mTXhKTDByM3NiWmQwMjR5OGI3RFl1M1BwanRtRHZsdjJSamVCbnk2bEd1?=
 =?utf-8?B?ZjhkeEpkUDhKOXQ2NGx6TTN2ZVFDMXcvdmxGZ2IwbjR4T0o5Vkk2azhVbkJT?=
 =?utf-8?B?NWR3S29pUjNRV0tGb0NDT0h2VmtGaWtQeTZqaFRhbmN0SHU1ZzlEenlDV0FT?=
 =?utf-8?B?MDEraVNjeHVvelRickxVQkZ5dkovSUVhWThVbVBab0VFMEZtTXppNWFETDVB?=
 =?utf-8?B?YU04VW10WXZ3L1Y2TnRYSlNlaE5VWDM5dVlFYTNJMS8vdGZSTG02RDZienhT?=
 =?utf-8?B?N2Z1VTVKU29KRytzVm1HeldEU0x1S2t2cXA1U1lKTXpSaG9UT3E2Zlc0NHpY?=
 =?utf-8?B?OElLS1pKWU1YRjhoYWsvUDNUWmZwR0pGMXU4QlcwWUMvKy9MVGFpSzh3b1Ur?=
 =?utf-8?B?Z3ZCZXVaQzhMOHhSS2U0RFJKMHJ0N0cvYWwzNjFFWHVnZUNCNzIrUjRtRHpr?=
 =?utf-8?B?UVE4YmdpMnhkRVhXbEswRStFUmNEeTZ0TnVFeHVEVXFkR2dRL1lkWWZRMnZs?=
 =?utf-8?B?WDV2VVJmMDZ1Q0FuY0lGbk01eHhJSlRCN3poeTYrcnNTNS9yRlJQa3NaZVhL?=
 =?utf-8?B?d3d2anVCTEJUVktGbitiU3RZZGdabUdkU0R0QjBGMDRqM1JBem9NenN6Nk80?=
 =?utf-8?B?Wml0Nm04eUVFdGMzNkVWUHdITUFMQS9RVFdHVklZTjdxRU5Xc2lYclVBUUhV?=
 =?utf-8?B?VC9mMlhEMlFlTk85dUNhRk1EYTY5UXMvR2lrTWpjOVlFbzFuK0ZDNFlHUGov?=
 =?utf-8?B?QTdjNkhXTGoxQ1RiOC9ZZ2luUTNLN1d6Qjh3MjdOanJtRTJPS1dxaFUya0dp?=
 =?utf-8?B?cEZvSTJoVWtZeExnRDdGK0M5MHRrb003ZE04L2NpZmRVVHZsL2t1NHJCbHJh?=
 =?utf-8?B?cTBXaW5HYWZWZ0xSMVFRRkJJK05vNnNERDhaSHZqdW90ZkFVWCt4YjBTMmty?=
 =?utf-8?B?WUdIUlpDY1NhTlB2WTlXNmlPVzFxRzhEVnNDUlVqZllrQVh0NXliYUJiLzlL?=
 =?utf-8?B?ZmwzWkNJWFdmS0E5ZGFtR2MzRi9leStkdVNlQ1NjSjZtNktzOFZUTkhmVjdL?=
 =?utf-8?B?SXVXcXZSSEMrY3ZOVTlTdW1JUGowdVJGRGhHRGRqa2RCeWIzM1g2Q3VDMHJq?=
 =?utf-8?B?bGh6b1JDVnVpRGR5cXRZNWYxZ3U3TTRqVjVUVCswRW1hMjBha3hNbkM2OG96?=
 =?utf-8?B?UFlNZG83eSs5RCtFR3ZYTUJyL0hUbGxJVWxLRDVxQmorazlWVmt3RzBTdE5z?=
 =?utf-8?B?aS9Vckd6bkxURVpvZlBidmxsUXZCQk4zb1RyNGdyVnU4azNpQjhpOVY3VHRD?=
 =?utf-8?B?Wmt1VWdMM0cxdCtydEw1eXgvSzVpclRqTHFub0ZOVFZwd3JHeStyUnYwRTNk?=
 =?utf-8?B?RVl0TlVmYkhpZEVtQWtNcmJRV1NUb1QrUVdZVlU3UGdxbkVzK1dhM2xFZ284?=
 =?utf-8?B?cFZTNjd5ek44Tm9wbnpONUdZWHh2NHNsMndqUlBYcEhLbjllWTJENTc5RGl3?=
 =?utf-8?B?bXZHU2lIL2xnSDhZTTdRYlMrMTJRWWRIblhIeWUvUEVsTTZPaHR2Q0ZhVnhr?=
 =?utf-8?B?VXVWbHZtbXZTMTJrNEptUWp5bmFYdmNVaGV0ZGpRU1g1RGlxK0tQTW9NMHBB?=
 =?utf-8?B?a0JKOXZwNk9PbTRUS2hMcVJUcFVSV0VQUG1FVmNOT2pXUkhKS2VrRTJaU003?=
 =?utf-8?B?Y2FPeTJQeHE1dG03RU05a3d2dUJIT3RMNnNzbml5Rnl4dldwd1NsYzc0UWdR?=
 =?utf-8?B?TEZmRlFLbGhuaFNHeEEwbmVKUVJtcFd4ZXh1bUpYWHd4QmhLUDRuWDZ1QlFO?=
 =?utf-8?B?YXQxWUc4bUoxcEZZVXNIOHF4RTJKWHNIbXBIMkdFZ25jZ3lqbVJ5UkJYSTg2?=
 =?utf-8?B?a3hKWmgvcXJOM1pIeld6ODZBRjVZWUNaS2FEWFVROGJqaUxmbXJkSHNmaUdD?=
 =?utf-8?B?QjFab2JxYlFCRkxlQWkyd1dGdnc5c3RmR2ZqbjBuM3dlMXhoMlBtZFBmK25u?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b968bd-7002-4b85-7c3b-08dc6ed40eaa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 20:27:03.9728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOrqG/3Tzew2QJvO84EsNQfwAvChEq3tOALBv2awZB/8/UUVIhN1/KbDGCeGmHqNX90EC09VOe24ynBhKmsA8qTGlrtSKeVgQdv7kHDeWaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5902
X-OriginatorOrg: intel.com

Hi Babu,

On 5/6/2024 12:09 PM, Moger, Babu wrote:
> On 5/3/24 18:26, Reinette Chatre wrote:
>> On 3/28/2024 6:06 PM, Babu Moger wrote:

..

>>> + * @mbm_assign_cntrs:	Maximum number of assignable counters
>>>   */
>>>  struct rdt_resource {
>>>  	int			rid;
>>> @@ -188,6 +198,8 @@ struct rdt_resource {
>>>  	struct list_head	evt_list;
>>>  	unsigned long		fflags;
>>>  	bool			cdp_capable;
>>> +	bool			mbm_assign_capable;
>>> +	u32                     mbm_assign_cntrs;
>>>  };
>>
>> Please check tabs vs spaces (in this whole series please).
> 
> Sure. Will do.
> 
>>
>> I'm thinking that a new "MBM specific" struct within
>> struct rdt_resource will be helpful to clearly separate the MBM related
>> data. This will be similar to struct resctrl_cache for 
>> cache allocation and struct resctrl_membw for memory bandwidth
>> allocation.
> 
> Did you mean to move all the fields for monitoring to move to new struct?
> 
> Struct resctrl_mbm {
>           int                     num_rmid;
>           bool                    mbm_assign_capable;
>           u32                     mbm_assign_cntrs;
> }:
> 

Indeed, so not actually MBM specific but monitoring specific as you state (with
appropriate naming?). This is purely to help organize data within struct rdt_resource
and (similar to struct resctrl_cache and struct resctrl_membw) not a new
structure expected to be passed around. I think evt_list can also be a member.

Reinette

