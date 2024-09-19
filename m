Return-Path: <linux-kernel+bounces-333708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA4497CCAF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3A91C22811
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6201A0AFA;
	Thu, 19 Sep 2024 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSYTIzmh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D0B19FA86;
	Thu, 19 Sep 2024 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726764723; cv=fail; b=Uw+qFbvFq/LOG+VCNMB2A5n57BWhQDAE31uPUHwRJMFuigSSLEqpcdhpwLflGyc3jeYEE6Q5Gx+Sg7YxROaKYnPMbtvUnIaAYswLPKmyksF/c5eqix9JPL8dx9SKt4rVThSAA6KkuUEThmKPT8opc/kwqagkXwqG/OO1Fp21D4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726764723; c=relaxed/simple;
	bh=UbsrsMiORR1UhG2+2gAds7o6ObbXumODwJLn4Ir3NpY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QghWPUFFHmCzSKZXHMTSCYWEFOumep97vv9eJuhMMAOvSpfbhuyu3TGPrIi9RB5KGL0KGlbT34hh0LN5k1ImDL/rES8SGXQFspxm9zEhVe0nX/924waQ44UHd7Cec6yGDvYOiUyTT1zUpAsexfrjlDFZhOxTeH3CKMs+dLaffrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSYTIzmh; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726764721; x=1758300721;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UbsrsMiORR1UhG2+2gAds7o6ObbXumODwJLn4Ir3NpY=;
  b=PSYTIzmhZAWCbTRT07MdXEWrGw1mDnCLDsMrNZStO5VfosbQEoomFnPt
   7h3LHUlHWgnd1LQdHFyb2vdm2jDGRc1FaqNIOV5SaTVDAfkCJ5n5vwqNS
   ajp6bpTALkMW/B7B77dLlsBRYuzibruHrOuI1gD+5nmjcKc291HXcSNr/
   /MM0t7xkKrmDlhUFfnmCnzquPeiLVcooiVqwZRroTYUqm8ie9QHvzETQz
   4vH3pP76pll/3tifqQa4P2etDKM/t6fIBU6RyXkjONT2FLStauxO5HoHj
   oGLsVqJCdRqiOhqg4GrVewTVwWCZ9AOvsLLCqroKfki85f5a/xZEO50YQ
   A==;
X-CSE-ConnectionGUID: Yjke5QIZRBy79K7UeLMxJA==
X-CSE-MsgGUID: gXZKmwCqSmmbFN8qhK8t4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="13595958"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="13595958"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 09:52:00 -0700
X-CSE-ConnectionGUID: WE/u5Ul6QzCC/l3rT7qy6w==
X-CSE-MsgGUID: wL0H3/50R9uCCkWokOYlfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="100732111"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 09:52:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 09:51:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 09:51:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 09:51:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+BQPkx6GZfnVnLyZr1gkjE8VK8jZS0tVp6zJhtaAh9MbXW8SyeGLwNGYkI8Z74Yi3Fb/pldfqtIAlzE28CXb6BxW0dMaQ5HO6kcnfx5W1BZmHDgVHvZvcQIdcAt5taidjU75+FP2R1Nrth2mQFiYt+PAx+TJcUA25Bop2K+kSi6uflaNAsGkftHPEGLcYd8V5o+B53mz/0BPgc8htmv68FeA4lxnb+MyzNQLltM/rO/L8fm7FP+q7eOLOBpOQ/b/61Z9zq9Zy1nloMu6Ssh38XLicSGDf4mRLaASr9f9WJFy4W01UCPWRSWlaySNZWe1Vyrl8IKbEF5zJNyNCVMnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JHk05iqql49fl6A6hDV3ESzCEa1aHewEs4cWT9etyQ=;
 b=Lry83/5CKvbBiT7tukAM1ipMyWwQ9njLyappoHxKlB/XI141W76q6vCq3lKBpTtKxz2kTocalLPbEG/tufVdNvA5eaBBoMTWtFklQ5v4rBX+zWQOkVZwpYpcI5JJwyi3n6Yz4DnvcpylHmdvwyurf2s8LBdNBXNJdWR8Ol741k/FU2MLpiFnRzLoFawz5YEk92eRoKbQViDlZyscddwrj/NfpwY2WMVuVBqEQUUevt8T4T/FN2qbka/ObHWTxWAqGwo6AyHDyOxmcbpVvCRMbHXJxDNP79q8gEm/p2TYaQFpnjoXY2AumNlptJGp0mZcyAmK+iJOUXRc7LVJ8v2DGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA0PR11MB4624.namprd11.prod.outlook.com (2603:10b6:806:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 16:51:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 16:51:55 +0000
Message-ID: <612ea03c-b8b5-427d-a810-8c2c291ca062@intel.com>
Date: Thu, 19 Sep 2024 09:51:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/24] x86/resctrl: Introduce mbm_total_cfg and
 mbm_local_cfg in struct rdt_hw_mon_domain
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <3182fb783dafc73fefbd762d7d83ae790c25629d.1725488488.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <3182fb783dafc73fefbd762d7d83ae790c25629d.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0264.namprd04.prod.outlook.com
 (2603:10b6:303:88::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA0PR11MB4624:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a85ec57-c102-4e07-886b-08dcd8cb5e85
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGNsWXZXVlQzTEdsSXpnL24zS2xUbDRjV0x2OUVQQ25QRmF6ZEViY2p4Sld3?=
 =?utf-8?B?aXpBeUIwNEFSUm9Uc3JlMlU4YTdsQ2R6Y1F5QVcxL1JZZ0l1b3BQeG0xc2pa?=
 =?utf-8?B?QXl1NjR5b25QdDJMNFU4MG9VUUlOM3pWM2dLaWFWd0VpT1FtLzdqd3JLZjFP?=
 =?utf-8?B?WlVNVXFkcDZBcTdPeXV4YlI5MHl6RU96NDAxM3lnL3V0NFRRak1vR3FkcFFY?=
 =?utf-8?B?TUM3MVRiMm5QQ0tOS09FTkdaeEVFNi9acmJia05OSHBJcmpybDVDYkk4a2lp?=
 =?utf-8?B?Mkh1NE1GVWxMa0J0QVFNL28wMFlWT2tNdHFqcWhYT1IydXUrUGlIWU85YmU3?=
 =?utf-8?B?Skt1ZThqaFlIaUxBTjFRMXVUYm1nNHRpUldzc1dMZ0psQ1AwWU5YWCszRlZM?=
 =?utf-8?B?bmdKSmJCUEIxbW9iU3hBdWtXcVFDSzR3anV4bEVPWEgwMFpLQVRXY29lR2Ro?=
 =?utf-8?B?T2w4bXdTU3VxcmVzbHpwSC9EWFFVRENIdHQ2MVU4ZDZXZmtSSGJQRUM3eU43?=
 =?utf-8?B?VzNaUnVsRzExcWRaTXRGZ3poQkJ6dFhkNnFpc1Y5WUlhVlorVVFWRWxVQ1Zl?=
 =?utf-8?B?UnczMWZ1ODJIY2RscWRITHRuRXdHbDlTNUg5Mk5McisvNVBKMDF6QXROMUtZ?=
 =?utf-8?B?bDJhWThwY3B2eUhvdUtEaWVKOWI5ZTh4eHpUcHNoUnpRVW9sRTBFai8ya2dv?=
 =?utf-8?B?NWxWSjRwMnJBL01jOUlibGhldmVVVmlNcXRiSlpjbHBNcERhT1A2OWpqcFdv?=
 =?utf-8?B?KzREQ3Q1MytISDBtM0xYNlF3dHhsS0liS09HWFduS01IK3NrV3k1aTQvOXVE?=
 =?utf-8?B?SFlTc0JWK3pUVXoxbU50d3JPK2xFK1lnMitVWFo1TlhWNDUyWWZPb0NhazN2?=
 =?utf-8?B?cGFabHpNa0VXWE9IQW95dldOVy9XWHc4NGRmSjBnWjErTHBjRkdpSjBDVWRy?=
 =?utf-8?B?d2YrbERESW0vZVFVUUgrc0J3NktVRExNRVNCYlJwU1FpVExxd3B4TllZL3hH?=
 =?utf-8?B?NDBxUHByY0I5Y21WcDA5ODI0NndYSGlWODBaR0czdFEzNVZNNklraUdjRFl5?=
 =?utf-8?B?djRYcjE1cDcxQ2g3bVY5ckdKR0RUOFB2aGcyWkFyTEZmK0x5akhxSEZIMXQ2?=
 =?utf-8?B?RlJjTEh5dW1mbGNOd1V2Wk1lTjQyZVFUVEpwbjZoM2NSaTJHMk5nTWFkamVq?=
 =?utf-8?B?ZnZnVWtpK1JPRUtDbi9YK0JFc09iVUN2QnF0QnVBUzltQVpDMWlERmJBQ3c1?=
 =?utf-8?B?Q01mZ2g0L1M1elNaMktQQ3pwdi9La0V2V1RwNFpjMWs3TlZvT0NzOUJIdDBU?=
 =?utf-8?B?Y01vZ3I0VkEzNHZDenljRnJvZ3ZrQXluNDBZS1N0NElQYVhiV1lOMThGR3VP?=
 =?utf-8?B?YU5KeFhycVgwejIwekRjams0Qnl1ckpOaXRHRjhsOGs5T0ZYSExoSUdFdEdP?=
 =?utf-8?B?T3FrWUJOemtFWHF0dU9Oc1VpWU9YSUpKNHFuTFArZHpGaFhvaEZqeDd5dms0?=
 =?utf-8?B?eFZUbVVLZ05sRU5xdk1FOGVWRkVielJvc2ErbnZNMy9ETmU2TjVFSWVkNHFV?=
 =?utf-8?B?WXJITlhqeDdIOE5rb1FPekxZZTZyZEtibXgzQktldk9Uc1dFTXBDSUFpWDE3?=
 =?utf-8?B?WDhuQlJESW1uWWtxVkRQVys2UjFBc3dzRjJ4Z3BCL0hsOElvYUU4akc3cTJB?=
 =?utf-8?B?YklvdExXN25FU2RFczhrYTFFM3ZsbVg0ZGpMY3hqckRLY3MxcDFYcWJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnRtTTZFQ2dkdmNvT1YwU3oxd3FRVE1jaEQrdVJMVjVTbDFVRHZYN3FUL3hK?=
 =?utf-8?B?VWVoaXZRMzdzTWFMVHdQclVqRG84aWdNcTVkZnJvaER1YW55MHI5VkpKY1lt?=
 =?utf-8?B?UnBTOXVxcisrSVRCUFM2c3pLcTk3cGlTZkdrTDdMMXE1ZDI3ejkrYy9UdlZj?=
 =?utf-8?B?bXEyTlUxQ3ZjQ1pHdHZCemdLR2NuUkZyTjMwcEJEdlVVN3BKNWcrUDRmTk9p?=
 =?utf-8?B?NFgxbHYyZHY4aDBXRkp3cFB5bVVadXhFZEJScU5iM2pMSDYwbHN0dXpTa0tG?=
 =?utf-8?B?ak9BR1Z6eUg1Q0lUbGJNUERZODRoVnFGUXhsOFpOM3pNYm94SFIzaWN5RTVF?=
 =?utf-8?B?VnZNZFVTN0hKNVNxRnRMbHVCQ0FwOEhvMERmZ3FJNTk2alVzYmxzOTE0aG9n?=
 =?utf-8?B?ZDUyT3BWZFIyV3pNVnpIWC9vWlp0Q1g4OE9kRHJSQ1p6a1JCeTBNYm5sSzVt?=
 =?utf-8?B?eitCdGMxU3d2Njh0YVcxeGlML0ZSVlVFamV1L2JtT2NieTFLNUEzUU9FYWlK?=
 =?utf-8?B?MmFFN2RKdnRHVFZidUdrV2VZdllGcTAvRkZCV0ZYeHF0WmNqZnNYSWluR21R?=
 =?utf-8?B?WS9KYVZWVzd4TVgxeWVtcjhydFh6SEs3NS9DR3BrejZPT0FEQ1YvMjhtZTF1?=
 =?utf-8?B?YkgrV0VtczBSdTkzbXN5dm90THN1dUpWUzBIejJqcU9BNldqdVVPYTVoazMx?=
 =?utf-8?B?UW9lSVc0ZjZGY2Q4ZklDdytEOVVGUDNCKzJKT2xDbkJLc1F6SFQzQ3I5eThU?=
 =?utf-8?B?c0RBVDFnUXFHRHZTMWFickFGZDY2SFVYTGx0NGc2WXdKbUNBNlA5SHdQQ0hE?=
 =?utf-8?B?bktnQjdkSmF2MmQzbS9mL0pYQmo1TzV0OWpLV0JScmJRbVdGb29TR1lBZWlx?=
 =?utf-8?B?UzlTdzZ6YWkrU1pndFR0d1BjNURFcFV2VEUxTkZJYy9ySUxiZHpUbFpqY1NM?=
 =?utf-8?B?VGQ1Y29ORDJ0aldFUGhTSThDWW1jeUhPWUdkeUJ0VW9WdEVsUUZyR0kzNDVq?=
 =?utf-8?B?V2RWZ2had2pKUXNzUkNSZGhzRDN1V0owTGlyN0xsbTIyam9Udm03VzE5S0NK?=
 =?utf-8?B?UUFLL1Nyclo0NUF2TktHaFdNSmpwYTVPUWFCZ3luT3Fpekl3aURhK2M5QVFM?=
 =?utf-8?B?MGlHcFZTaXBqd3VoMm5qVkdhdmFBcmlZNDJNMFZtZzBPaGdZSDN3UU1pdVl0?=
 =?utf-8?B?TU5jdkY4djlBUERlbkpOMmxmOWIvN0FlTnhKa1hkdEpVUkUwRXhSc0hOK0pQ?=
 =?utf-8?B?ZW0yU2JWWkpOcFpRbDQ0aGJDWDloaFdsSUVodlRkb3hHQnRzQm90MFgvL2la?=
 =?utf-8?B?VnhkUGFSRUZibTZoUGlyWEpEd3luK3gxZ0VrbU0yc2pCWmh4SjJmRG8xK2hR?=
 =?utf-8?B?N2Y4OUxBdHNSK0RuWDZvdktxUnJsaWZvdjluMzBTOER3UkpueTBOYUR4NnQ1?=
 =?utf-8?B?b1lXUzhSTldxZUtxVGFzTXh0ekVxQU5lSDFHV1pxemJLblNmYlRLZTVRY3ZG?=
 =?utf-8?B?Z2hKLzZDWXBDa0t2KzVNYnpMWTA4cG01NG9QVTRhUDJXS2lDaTZPN0V1ZGFY?=
 =?utf-8?B?WTd3VVdqbFZKemVONmo0dmRpOTJTZGEyTkxWZlNLSTVkRlNmR3lmcXRET3Fn?=
 =?utf-8?B?d0FNMlBnWkZHUXpUVWxGalVSY0dZbExEY2dESjVoTTlqTEE5OUJMRUtrZEwx?=
 =?utf-8?B?a01LbTIyZDVtUWtRT3o4MSs0OG9xcWFpZDJLeHVQcGYxNFh4REkvbGw2ZkUv?=
 =?utf-8?B?Nnl6R1hxV1c4bENWMUZCd2ZqclU4cHB6UWZQWmh4eTBmUDh4ZmNLQUt4WUJT?=
 =?utf-8?B?MDIzRUxBS3djMC8xalc4clA3WEpwd0RnQkxOcml5amlhTGdqSFcvS3lTNmdm?=
 =?utf-8?B?RWpYOHFvclRHOHI4cDZTVEVlWkR3UUZiYzhPNVhVenpibExCdWE3N1M1MnU5?=
 =?utf-8?B?K1NXaXVvbjBLYUZkTlV2OGdxWE14cFJCci9pOTBCcDFGWkluQk8yOW9EK0xZ?=
 =?utf-8?B?dmZNK0k4a2RyWVl0Q1lnZnYzd1FKTXVWajE5c0lBS3RhcWxHNVZ1QXlOaUNX?=
 =?utf-8?B?cnZGamcwME5DeG4wSzdIR2tFMTRTRlVLeWdpaHhDQlJkK1U5T1VuZ1ZjV0Z3?=
 =?utf-8?B?WGNMSDJ2M0h4cFFzYTFBMklaeWZMWENhblFETW1oQTcvZFp1aTVLMi9xeGhC?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a85ec57-c102-4e07-886b-08dcd8cb5e85
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 16:51:55.6712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgfMJeYqy2ui7VDSqLHM/GGq8ZobIoq1rrA6q4/t73icPXn/2rj8/C6BZPKcO8Ym5+04M4d2zbIKsL+gKDPHt10SdL5vxqF0Zev1GKxII2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4624
X-OriginatorOrg: intel.com

Hi Babu,

On 9/4/24 3:21 PM, Babu Moger wrote:
> If the BMEC (Bandwidth Monitoring Event Configuration) feature is
> supported, the bandwidth events can be configured to track specific
> events. The event configuration is domain specific. ABMC (Assignable
> Bandwidth Monitoring Counters) feature needs event configuration
> information to assign hardware counter to an RMID. Event configurations

"to assign hardware counter" -> "to assign a hardware counter"?

> are not stored in resctrl but instead always read from or written to
> hardware directly when prompted by user space.
> 
> Read the event configuration from the hardware during the domain
> initialization. Save the configuration value in rdt_hw_mon_domain,

"rdt_hw_mon_domain" -> "struct rdt_hw_mon_domain"

> so it can be used for counter assignment.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v7: Fixed initializing INVALID_CONFIG_VALUE to mbm_local_cfg in case of error.
> 
> v6: Renamed resctrl_arch_mbm_evt_config -> resctrl_mbm_evt_config_init
>     Initialized value to INVALID_CONFIG_VALUE if it is not configurable.
>     Minor commit message update.
> 
> v5: Exported mon_event_config_index_get.
>     Renamed arch_domain_mbm_evt_config to resctrl_arch_mbm_evt_config.
> 
> v4: Read the configuration information from the hardware to initialize.
>     Added few commit messages.
>     Fixed the tab spaces.
> 
> v3: Minor changes related to rebase in mbm_config_write_domain.
> 
> v2: No changes.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
>  arch/x86/kernel/cpu/resctrl/internal.h |  9 +++++++++
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 26 ++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 +---
>  4 files changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 00ad00258df2..2a4be004a2df 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -632,6 +632,8 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
>  
>  	arch_mon_domain_online(r, d);
>  
> +	resctrl_mbm_evt_config_init(hw_dom);

Now that the arch and fs separate becomes clear I wonder if it may help to understand
this work if we start using clear namespaces to help this distinction. Surely the
arch code is very inconsistent in this regard (thus this function fits in), but
resctrl_ has to be the prefix for fs code.

Reinette

