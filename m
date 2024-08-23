Return-Path: <linux-kernel+bounces-299624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4FE95D7C5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2059B21D96
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A59E198823;
	Fri, 23 Aug 2024 20:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F99I+XUZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18A9193087;
	Fri, 23 Aug 2024 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444301; cv=fail; b=B0AkaUUVy6Voe/EN9VyDmCeug84yIY/ghv6VvY+4YYBYBGf+4krivguVcXW1LHs+z/Ib5QIGAOto8F5FDK0lztJArtaug1+qLmw9sURQaZw/xYM4Fouf+3oHRjsNF1UeeuDdra6T2uAAsYYMiusMvR+W8fQ9aFAAhm4eKVkvpk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444301; c=relaxed/simple;
	bh=/pbCFmM9KyU6/Ns54ZyvDwyjQ++WLJhzgV69fEjRtcs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XygBSNXm2QbDMAFAcOL0bo2wMp1E+vOPZaYtWd1A5N851Wx8sHtye1JHzvbd6MF8WsZmjLK0Nz09hE6fCxi50oMRefyGZ4AvBLtdbpLQzkqU+7hzxNgrvcsRZcwITgZwlTIWeuM3NhSBC3Uw10QIMMgwb2syDaIDMuEUkWYk9xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F99I+XUZ; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724444299; x=1755980299;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/pbCFmM9KyU6/Ns54ZyvDwyjQ++WLJhzgV69fEjRtcs=;
  b=F99I+XUZmXZ6bLbr34c2h5a6u+k+S/uy5qYMH3xL3N52AqzsaDEQlhru
   jASy9W/kQLYp4EXr2pvxIVce7hi6O1jIndV0Zg4jkwMmpN3j88q3w16p8
   oNjedHTfo+35w4L6hIfz/IFBIt69OHFme53VgEaseEGJ0186E0lYV3hoM
   1WyGNzA2e9srmwVZcnFG5JYxU82RPjPERCjhI74yUxwA963pC98U7Tl0F
   vvwCyXge1tzP+NFka+ZcYkQACyUjujZ6ZrJuuzcwKtbgfCnZQtQgyIoPo
   NPqXDYi13f9IEvvf0+/7GmoUxjgnjhxomOs57hlZxl/KSBw11m8H3w2BN
   A==;
X-CSE-ConnectionGUID: 7fI95MtRSGe7o43ccGwADA==
X-CSE-MsgGUID: 4/puOI9dTo6iP2aabmDBLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="34343150"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="34343150"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 13:18:17 -0700
X-CSE-ConnectionGUID: 8ua5eNKcRiCsAHTnpRYp1A==
X-CSE-MsgGUID: 2TCQqFRPSNS+5+8vKVLoiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="62624535"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 13:18:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 13:18:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 13:18:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 13:18:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 13:18:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U69jB4SHq3fjHbqB29l8RkxOa/PP1aDhEccDl01zShmwsI9t0EgwJ2wHM++nPfRiFXoWczu65mZEPoOWQQyN7TYdtASGiK3otgCU+gU+ofdeYZ12bRBY53JTnDPVk2YxBnTKlVfZvPOH1HadobHjoEe3NGeg/4+fCZ/gVt5Srj73Z5JGxFshAJWCeW+ORP9y02WCA0lJ62RmTs6YeCYirrcajg3VG143bUy30C3yUGzk7NSD8N9uovexSUrvspS/GO5dy10vOOpcLLXelO0bJPHQ0xO3cyqM7+XbhUZZSSlMOZAMbtbCaD9LUyu/VTDftW/aTmI6FHcBbDFQw1NAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B15oMDcHDWzq3qBfNgLzkA1I+X3/0SI838jcBeNDtH4=;
 b=qgZvrLJtj0t9INTr0PGt6n8pLTf7NNDfDsSTkobv/mcqnhfIOKvmiUDXbuUyjx/j0FyNU3YRRMklvUPQKFaFZzYB+pnQidUJxePrsZcUpAenXDRm15u5Otubbuln4y/H4/a7/MhJfzwM/VSaZld80+ynPGTmouUzu3zsNSPUkanpCgfxygkh1Z6oRV3iZ8fGEimPBqEF14rIuJM7hwKPu1tCN5Q3PmwO7nJx8F5fsn+2wcLD+RZc3NdO7LUgmxKkTBvFIB7Ase+0t8vt420dOEvbVWS+geJPlbtu0LSoZ6k92ZhgdLfhuYgAiBMQYMl8c0i4QE1e4B8qKiPCd8Q3Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.29; Fri, 23 Aug
 2024 20:18:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 20:18:12 +0000
Message-ID: <df257c05-ef8c-4e31-9ab8-0d396e1b40f7@intel.com>
Date: Fri, 23 Aug 2024 13:18:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 22/22] x86/resctrl: Introduce interface to modify
 assignment states of the groups
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <30a946c5ec042e66db675e9e57fe2cff971f570e.1722981659.git.babu.moger@amd.com>
 <d4873add-ac24-47dd-be45-28af3698c334@intel.com>
 <d8259097-3ccb-4989-aa1e-6b5c564240f5@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <d8259097-3ccb-4989-aa1e-6b5c564240f5@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0318.namprd04.prod.outlook.com
 (2603:10b6:303:82::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 46dd9bc9-29cf-4ae4-7253-08dcc3b0b669
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXV3K2xMNTVRN3Q3SXAveS9lSWNHNjVyWDdSYkVnTkdYV2JRaU81VkpKdnJ5?=
 =?utf-8?B?L0QvRGM5Ty9zZ1BWR0dqb29BUTRYTlJGc0FOZzYzOFNodVYrQVZudXNvRUtV?=
 =?utf-8?B?R3NMU1hGbGRTYnhLOUNEdXFnRUJadVRiTWQ1UzdyR1h2SDFYV1pKUVNONUlO?=
 =?utf-8?B?dVZsRHF4RXVFZTBwdlBORnZqeVJJeDRjMWp4anNSeUV1S0dPRHJpRGhXazdB?=
 =?utf-8?B?b1NpU0c2Q1R1ZDBnREZzajlhSzZ0SWE0bEl1QU05SzkwaU1tR2Juc0ROUEJh?=
 =?utf-8?B?ZEtJYk9TNjRZSVFKNFJBeHdkQ2ExSU9CZXJ5cFJqQm9FQWNLYUs5bnNlUU9L?=
 =?utf-8?B?K3Z0dzljS3YyNHFkUW5iTjRDaEVUY3hsak1KWktCODJNK3pndFNWdkErNk1y?=
 =?utf-8?B?dEEwVTNIdzl3QUNRMkgyckluQVlsd2Z4bG1oTzNXcTRsbjFOc3pVc0ZQam5s?=
 =?utf-8?B?NGVTQWN3SmJzbEhycmRDWnJCUGZOaGNybFZqZUhPY25jZnNrdkdnS29iR0g5?=
 =?utf-8?B?KzBnSUpXMEI5YTNVUkw2UkJBUDZaN3N2aGEzbjNDRmwvSHdMT1pTS3ZsQlNN?=
 =?utf-8?B?eGVUUlFVaTh4S1BGdEpRVCtRRjJQbEZNbHFWNncrQm50ZEpzamM2dG1UaUI5?=
 =?utf-8?B?M2h3Z2I0LzV0ZiswZDRSbnp4cmhNd3kyMWNoajcwQWFsSUNQVmc5THpoSUli?=
 =?utf-8?B?VllOWXFEOVppRUhmci82SkZDUmo4a3pRQmNFenBvWnVmUW1kdGo1YzJ1TS9G?=
 =?utf-8?B?YTgvbHdDN1pNSGhaK3ROaHBSZ1dNY0JrRWt5aHZnQkNtNC9rV3JDTkVia1dH?=
 =?utf-8?B?RUpJbjhYRElHSDBpYUtaSWJ2Q0FtcDh1eVNZSnAyaHJpRDROaStYMlk1cDlR?=
 =?utf-8?B?d3d1N2xNSkVmR28yZEVlYUN6cWlzN2EvNkhOekplcm96VWRyV1hIMFRCQjIx?=
 =?utf-8?B?K0tuM0lrQVI4SEV4UndGTHJUYm5TQmxjVXJxTmN2SzlKYVRTa1UyNjVYNmw0?=
 =?utf-8?B?VG40MUhaQlhpSGgwSFR0NXRTdHRHTVlzai83NDNDOFQ2TXJjRlRsYXg2ZzRD?=
 =?utf-8?B?cCs4Z2xYUmJITW1HSTRQWEsxM0ZJenRRb2RPRjZmVmRtUzNCWFluREJWbVhm?=
 =?utf-8?B?SzdHdUYrOXhUQWlTZjRlY1k1Z3NWeUt3dnZ0T2xOQytqL3hEdU1uc20zcTds?=
 =?utf-8?B?ZE1KcHc1VWdwekU3LzRJZ05qUHlwTTVsenFLUzR0K1k4UmlUZ1V1ZDZwRzdG?=
 =?utf-8?B?SlR0bG9LRGtaWndiaVh5b25Fc24rMEVpVng0TTNEU2ZObXBZMURwZ2NMQ3dK?=
 =?utf-8?B?VGpEL1ArcnZvNzZwRmUxV01rM2dJSGFBRTAvb1g0WG9MeDlXNW1LeU8vY1c5?=
 =?utf-8?B?NmE4RDl5cTVDMEVWdTVzNTNoNEFYR0NpL3YvUFk0blRTeThYZ3MramNEdHVo?=
 =?utf-8?B?SDBDNDVFaG8wa2hEbC9WVFdKWTRMOE93TTg5Y3FnYnZmeVdZV0FJaC9abldG?=
 =?utf-8?B?d2ZnQXdDcW8zRHRXL2pIYTlsWCtOazA2UkpuZzNxSkdKTGRPaGZSVmFxUEZN?=
 =?utf-8?B?ZUJWMVpTM2RVNG05cTg1L3QreGpIcnk1eU8wMVcyRGNCRDFwVnNGTFRtTHgv?=
 =?utf-8?B?N3gzcmRDMlBEeG4xZ3JhdThHd1lnaHVsK005WWlVU2JnckcwSWJQUVA2eWlU?=
 =?utf-8?B?UEt0UzQzeFJDZytoTDJWQVFyMkt3aTl4Z2plUUVXMmlpOHowRzFjUnRGcDRx?=
 =?utf-8?B?VjJLWFhSTVVmNFZENldBRTQycklydWJMVnhEOHJtb3JwK1M5WlRKMUFobE1w?=
 =?utf-8?B?b2NKNHduWHdlaUQvT2hTZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K092YjZuMCtoSGdnZ0cwR0JTTHhYQk9wMzNKUUJxRHNoekd2WW1KcHFNYkwr?=
 =?utf-8?B?SG5Ba3lSRE1QOTZYQ2tjQU4yK2UwaGxZSEpEYUZvWjVLdkdSTjZWbGdEK3Zk?=
 =?utf-8?B?UWRzWTVwZkJCYUFRS1VHOEtRVzFOU1Z2NVZ6NUZoc1hFSnVXY0s4aHZUbzNF?=
 =?utf-8?B?QW5kSURrUGJWeHVySWdNeGFYd3VQalIwWE93NDJiaU9YenNnZUlGL00wdndQ?=
 =?utf-8?B?ZDBOYU9RR0l6N3JmMDdvMS8zTC9rYSs5SFlsREtQRXNEQytIdDRQaGt4S09s?=
 =?utf-8?B?ZkM0MFQzK2YxRG85bTAycFNPVEYvMzJKaTVwMmtNQzZNbmg4QnpkNjhqZysw?=
 =?utf-8?B?OEQ4bTgxeWlOWXVFT0NlekZ1cng3dzdnaW5GcHpabEdYR1p6VW9PVWxVakta?=
 =?utf-8?B?UUloaFExRHNld3B3T3hISXZCS05aWGlHVGYwelVVZjBFZVBtYUw3SXNQQkRp?=
 =?utf-8?B?dDlLdUFNVjZXRjNnRmdlcHlEcmJDT09BbFdJQUt1N2FWMTh1S1V1NlVMekZL?=
 =?utf-8?B?ekRvZlRFd2N2bDJTa3ZVYk4zVnU4VkpuOStTa25Fd05hSzVWdlFTejlIWVBm?=
 =?utf-8?B?SEkrSGtjUkQ1L3kxQ3ZUYThvSVh1QWwxekM0MUxmcElOeit0am41L3N6ZzlN?=
 =?utf-8?B?bXZ0ZTJGSlVoR2gwTVVUbWprTzNCK0Rhd0FCd0hGdXB0UUpXYmIwem0zZWpR?=
 =?utf-8?B?WGE2WXJqTFBzVVB3NXJ0Mmk3eWRFSlBSRS84MktSV3FtUk5zVktwemlYcGJV?=
 =?utf-8?B?T1BKSjlFTlg4Q3Fkd0pncU1rR2dVRzUrZTVjUkd6UUQraTBoQ0RhNHBFNDVa?=
 =?utf-8?B?cDdtY2V1SHBBeXJUempzOU56cTZDV2dBOTZhRXhNNm5KVFFwOHZFME5FR1FI?=
 =?utf-8?B?SFFVejhCSUNYenViY2xOTStQZGU2TERIUGlEQittbzQreEN0T2lyVWlmbE43?=
 =?utf-8?B?MHFqeFEyYUVxbEtQczJwdERoSnk5dklTZzh1QWEwcUE4WXhBbTJwMVlvN1R4?=
 =?utf-8?B?QVlRcGVIQjFWcFlHeHFIVUdqbU4wYjhsRWFKem80VXBaM2QyeEFvT1g1N1hC?=
 =?utf-8?B?UmxnMkUwV0h4eExtaUw3a1hSeDY3RmR3V2dwc2MzejJtQXZLa0JFdlhnbnhz?=
 =?utf-8?B?RmFLRXUxY0lTdFprM28zZFBSNHIxWGl5NmJ3d1BHOXcwY1RBS0UxWmszN1kv?=
 =?utf-8?B?bng0QWw1N2RTWHgycXg1S09kVEx6NitITDIxT0J6K0JGcFpxbFd2OWRlekw0?=
 =?utf-8?B?SzFlREJRcmpXeEttbFZkcG1FZVEzK2pISERYTFJmZUhucWc3cjBqd1MrS2d1?=
 =?utf-8?B?VVFNQitxemtWYktlQUs0ZkFocnl6aS81eEVPMDFjRmxXKzNvWVlicjBqNTJw?=
 =?utf-8?B?aHVlMFdEcHRWc3Fqa09uRTg5WCs0YVhBUFdmRGVjNEZIOEZLbExwdW14dWZC?=
 =?utf-8?B?c0dLcHhjNWZOUTRvQ0cvSExVeklBSnlxWVZWeGFQbWx6a0t4Q0JzRE44MG44?=
 =?utf-8?B?RXdPZ2VxbzNnTDFPZTYvNm45TndObEQ2SUtWWVJCeTJDWnI0cGRaWGhIUjRh?=
 =?utf-8?B?eXc0djI3VXJUT01uVWF4QTJzVTdOUnlML3FFb0ZMLzB2OGJPN2N2VWhNMnhZ?=
 =?utf-8?B?K2ZVZnh3N0trUG96ZUtjZmU2Z09mQ01HYWNpTkp3VkVwc3BUdGlsUHZQbzBp?=
 =?utf-8?B?ektwLzkzK3dYMm5qVjBmNTV6QWdLT2U5K01SYnViWEZvbml1NFlLT3l0Q2ZQ?=
 =?utf-8?B?K29aQ2ZCSkFzRFd1NERScHNHbzNyT3dER21QRUdub2JkT1JkeDZTd2VyV0s3?=
 =?utf-8?B?RWdlb0U5WG5hYUNrT1ZBN0RzdEttMEhWR04wdFBzc3ZVbEE3Z044RVd1UzdM?=
 =?utf-8?B?bHFvbmtIaVVHMDNsVnJFR2huRVowRG8wbEg1VUVmRWpRUU9iRnJ6S3lXNlUr?=
 =?utf-8?B?aG1vRVdKZGZjWFU2RHdLRGVvbHlDWVNSOG0zVy9VaEpnUGVicFFrWUg4U0U3?=
 =?utf-8?B?dk9mRHQzd2QvQlFTL1lRL1BtWXZ3cVFuUGJwOHE4eCtCaUhMWHl1amZQWDRp?=
 =?utf-8?B?TFBiNTl2QVR4ZTNYdVhzVlYvS3VYdkZwQS8xUW01cmszY2pJU0luc29TNHhw?=
 =?utf-8?B?UE94L2ZVTlB1emNaYVRZdWFiYU5ZUmNJZGZZSERzeitqRlZwRDM1cmhudkM5?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46dd9bc9-29cf-4ae4-7253-08dcc3b0b669
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:18:12.2904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oa2jYlpBXPQht3T2DEVSdsVH5XNa7ucUFMFNMmm5hGoUZJ04F0sKoehymc1pHnEEIB2miqFQYNkzxyoS/pxvS+b9QSkoxI5r7lvPkxmLWHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
X-OriginatorOrg: intel.com

Hi Babu,

On 8/21/24 1:11 PM, Moger, Babu wrote:
> On 8/16/24 17:33, Reinette Chatre wrote:
>> On 8/6/24 3:00 PM, Babu Moger wrote:

...

>>> +
>>> +static int rdtgroup_str_to_mon_state(char *flag)
>>> +{
>>> +    int i, mon_state = 0;
>>> +
>>> +    for (i = 0; i < strlen(flag); i++) {
>>> +        switch (*(flag + i)) {
>>> +        case 't':
>>> +            mon_state |= ASSIGN_TOTAL;
>>> +            break;
>>> +        case 'l':
>>> +            mon_state |= ASSIGN_LOCAL;
>>> +            break;
>>> +        case '_':
>>> +            mon_state = ASSIGN_NONE;
>>> +            break;
>>
>> It looks like this supports flags like "_lt", treating it as assigning
>> both local and total. I expect this should remove all flags instead?
> 
> This is a cobination of flags.
> "_lt"  This will assign both local and total.
> "lt_"  This with remove both the flags.
> 
> It seems alright to me. Do you want me to change the bahaviour here?

This looks like undefined behavior to me. A request to set individual flags
and also clear all flags looks like a contradiction to me.

> 
> 
>>
>>> +        default:
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    return mon_state;
>>> +}
>>
>> hmmm ... so you removed assigning mon_state to ASSIGN_NONE from default,
>> but that did not change what this function returns since ASSIGN_NONE is 0
>> and mon_state is initialized to 0. Unknown flags should cause error so
>> that it is possible to add flags in the future. Above prevents us from
>> ever adding new flags.
> 
> May be I am missing something here. How about this?
> 
> enum {
>          ASSIGN_NONE = 0,
>          ASSIGN_TOTAL,
>          ASSIGN_LOCAL,
>          ASSIGN_INVALID,
> };
> 
> 
> static int rdtgroup_str_to_mon_state(char *flag)
> {
>          int i, mon_state = ASSIGN_NONE;
> 
>          for (i = 0; i < strlen(flag); i++) {
>                  switch (*(flag + i)) {
>                  case 't':
>                          mon_state |= ASSIGN_TOTAL;
>                          break;
>                  case 'l':
>                          mon_state |= ASSIGN_LOCAL;
>                          break;
>                  case '_':
>                          mon_state = ASSIGN_NONE;
>                          break;
>                  default:
> 			mon_state = ASSIGN_INVALID;
>                          goto out_done;
>                 }
>          }
> 
> :out_done:
>          return mon_state;
> }
> 
> Then handle the ASSIGN_INVALID from the caller.  Is that what you think?

Why not return an error?

> 
>>
>>> +
>>> +static struct rdtgroup *rdtgroup_find_grp(enum rdt_group_type rtype,
>>> char *p_grp, char *c_grp)
>>
>> rdtgroup_find_grp() -> rdtgroup_find_grp_by_name()?
>>
>>> +{
>>> +    struct rdtgroup *rdtg, *crg;
>>> +
>>> +    if (rtype == RDTCTRL_GROUP && *p_grp == '\0') {
>>> +        return &rdtgroup_default;
>>> +    } else if (rtype == RDTCTRL_GROUP) {
>>> +        list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list)
>>> +            if (!strcmp(p_grp, rdtg->kn->name))
>>> +                return rdtg;
>>> +    } else if (rtype == RDTMON_GROUP) {
>>> +        list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
>>> +            if (!strcmp(p_grp, rdtg->kn->name)) {
>>> +                list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
>>> +                            mon.crdtgrp_list) {
>>> +                    if (!strcmp(c_grp, crg->kn->name))
>>> +                        return crg;
>>> +                }
>>> +            }
>>> +        }
>>> +    }
>>> +
>>> +    return NULL;
>>> +}
>>> +
>>> +static int rdtgroup_process_flags(struct rdt_resource *r,
>>> +                  enum rdt_group_type rtype,
>>> +                  char *p_grp, char *c_grp, char *tok)
>>> +{
>>> +    int op, mon_state, assign_state, unassign_state;
>>> +    char *dom_str, *id_str, *op_str;
>>> +    struct rdt_mon_domain *d;
>>> +    struct rdtgroup *rdtgrp;
>>> +    unsigned long dom_id;
>>> +    int ret, found = 0;
>>> +
>>> +    rdtgrp = rdtgroup_find_grp(rtype, p_grp, c_grp);
>>> +
>>> +    if (!rdtgrp) {
>>> +        rdt_last_cmd_puts("Not a valid resctrl group\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +next:
>>> +    if (!tok || tok[0] == '\0')
>>> +        return 0;
>>> +
>>> +    /* Start processing the strings for each domain */
>>> +    dom_str = strim(strsep(&tok, ";"));
>>> +
>>> +    op_str = strpbrk(dom_str, "=+-");
>>> +
>>> +    if (op_str) {
>>> +        op = *op_str;
>>> +    } else {
>>> +        rdt_last_cmd_puts("Missing operation =, +, -, _ character\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    id_str = strsep(&dom_str, "=+-");
>>> +
>>> +    /* Check for domain id '*' which means all domains */
>>> +    if (id_str && *id_str == '*') {
>>> +        d = NULL;
>>> +        goto check_state;
>>> +    } else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
>>> +        rdt_last_cmd_puts("Missing domain id\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    /* Verify if the dom_id is valid */
>>> +    list_for_each_entry(d, &r->mon_domains, hdr.list) {
>>> +        if (d->hdr.id == dom_id) {
>>> +            found = 1;
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    if (!found) {
>>> +        rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +check_state:
>>> +    mon_state = rdtgroup_str_to_mon_state(dom_str);
>>
>> Function should return error and exit here.
> 
> No. This is case to skip checking for domain when '*' is passed to apply
> assignment to all the domains.

Using "*" for a domain still requires valid flags, no?

Reinette

