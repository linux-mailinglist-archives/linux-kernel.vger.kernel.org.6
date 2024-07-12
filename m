Return-Path: <linux-kernel+bounces-251192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE1D9301ED
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FA41F22C50
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F83555E49;
	Fri, 12 Jul 2024 22:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Btqe5uIV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12674964D;
	Fri, 12 Jul 2024 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720821911; cv=fail; b=uhNNmoyfj2Suu+JcJEwB+aTlzdEOHIACG6K3K7Sz/ol7T031vFl8GaKog/GBtChHVGK0FSSxnKe4+pZ+OZyOtXeVzZ0RpJ0LLsdu7hTJmKk+4kpZwnwA4S7rY+gvb7m+1I6dq5Q4Ny9GFN+s+e8+CvIM+kmkDYLeoFjAy22zAH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720821911; c=relaxed/simple;
	bh=F+HoWIVWR633w/7brnJgcImnRDhx0S1UrmPvhvnFFyE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YAvxOqXZa+KMKhyG20pm5QAQrr/J2inoJzXYg8H40ziCjBLWyPc4Ys5H6t3tTbBBUB0dUB0RXLcREfiRwgEwDgWuZqv6GE7Um3BGTSu2E6SmGtMW05EltVYmsmmRABMhy1n13A8KNIOzE2RUjDeuowAWQAJUKRpv5XZrA8EIjbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Btqe5uIV; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720821910; x=1752357910;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F+HoWIVWR633w/7brnJgcImnRDhx0S1UrmPvhvnFFyE=;
  b=Btqe5uIVmBrLmShWDVhqhAqomfrezIjwp4IexB1frXMXl83/8EzM1Z/v
   2Md40OinEgG2N9Ma3pSXJq1/bL63dTv+c4B5wV2T7xW2uLmVmqjnR8t43
   4WaCqUDxmJhcdHKUHk9dCqZRqOq5d+Wj2yK2OmvS2h32/bbWWWWbfhhad
   z2xyNIEQF8mmH+1yA59yeOSch9lvl/8Z6q6MqjW8Umjki9fL8puFkL6/j
   E4wWM850AzWkVG7Za7Acc5DktdkB1EFHVAEMdDDu36JIcUNg5QvQ48ojg
   5zJSpSuZXeLrAjdTpJkJk1jegmSI0P8RvJMlpEp5wHdrNcflBq2awlaS3
   Q==;
X-CSE-ConnectionGUID: AhBuEbSNThqQjG7WmmSfhw==
X-CSE-MsgGUID: etAgyovFT0G8sXhdTvM0Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="35822944"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="35822944"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 15:05:05 -0700
X-CSE-ConnectionGUID: GIB6QtWURxaigHAQ58UrXQ==
X-CSE-MsgGUID: AcLWFXBGRz+1kVo5wcPkAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="53403509"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 15:04:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:04:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:04:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 15:04:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 15:04:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qp0oDw84kWMHuuPInN5Sd8RgbOHgz9ANFhMqIxtJUf9IcRoT7ZKKL5y3ThVODA2lup/8dXd8QXz/lsQhtV8b6nvcRDUzQJbdHyF+yXKNsL9sYXrYBxBCPGgRH8bO1vVXFMOq2QhVrev2MhwWFXD+eSirq6LeKt3ullxayRsasCa2AEb/9UvzQBoN9ulKiLmh/kzKhFnCmP5rwRWEQ9pZNtrAVRZvMxkq+t0dcd8veAAOsvGQ0vmEyrtiJor93UGdv6QcMQnXaaVLZaZwH/Wf+g6Bur6gLtB0xvqZkoSemmmYbvMnjelKEtSwuMpjadtNBEPZXXeWyeoGZ2CTwpxdGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws33RXleUmDduTDgviCaJnzHr5hnb0Hwz4w20Lsc2GY=;
 b=v2w4jRwjR1m5e1AA+Ffo52JZu7dwgjeQzm7cnru8Zw3TyYSKLQLo8RvoQZydrfpo9Wn9orK3SORP6hNs/4qkSENc6azMypM81v+jzkXNcXZ6ZwlAh6gBlQ+m7FnH2pr5k0IN5o8ywtBgYrbEnYURhqclLLOEaoTKBWw6Xq00s5RvYt3FoJcWo30QfgO/vS9HFNcS3eQkGFAZFnYdzRUTl8/qWTxP9j1fJlgegJQhrMUIK0FxfW3ONnT5KPPI8KoY3Inb1YBQe+Arpnq+4Vg3PsaUfAO5ADw7EqlDdxE/9tvcZucQbjvGBT33KwyBOwK7xvDPYfUa7c9GeRFIkakUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7599.namprd11.prod.outlook.com (2603:10b6:a03:4c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Fri, 12 Jul
 2024 22:04:45 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 22:04:45 +0000
Message-ID: <c304fc0e-63bf-490e-980e-960520a3ecfc@intel.com>
Date: Fri, 12 Jul 2024 15:04:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/20] x86/resctrl: Introduce
 resctrl_file_fflags_init() to initialize fflags
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <9176ca716368fb433c956ae72d70f0f16278248a.1720043311.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <9176ca716368fb433c956ae72d70f0f16278248a.1720043311.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c891c5-fcee-4fde-a764-08dca2bea3c5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmd5NS9NVHJjV0FwSUVQOGZ3TmcrMkJsWWdoUE52bEpuVHQ5SnRJbmp3Vit3?=
 =?utf-8?B?cStXVkJ6L24xbEptdjRVNVlQOXArcFl1L1h5b3YzTTJiajN2RlJ0UzZrMXZr?=
 =?utf-8?B?QldLYkduQU1LNTZPNTladGR1UEVNeU5jYjI0bVBiUUY0bFliS1lZKy83dGlR?=
 =?utf-8?B?V3h5WHppTUt6SGh4MUdwRStxRzBjenBiNGJKYVQzSHVBUlp0Q2RENVdmUTBh?=
 =?utf-8?B?V1Awc2d3M0xXR3V5dll2RVZ0YW1DY1ltNDNqSnZXOXJubzhGQjFCdmQzWEhF?=
 =?utf-8?B?dC95blErT3NqOTRtaXBTalZZSUdRSHo3Q2JuWWtQUG91RjNZaGt3OHFEUEd4?=
 =?utf-8?B?SE04TFZxdWZZRExLc3BuWjAxM2pjYXpvQUNYMGhIdW04QlI5eVVva1BOKzha?=
 =?utf-8?B?Yk9jOUgwS1ZaajFXS1hoWmZITnRTWkVCeCt5R05rNVJrdWtrRHhZdGFZY1Ny?=
 =?utf-8?B?R0hjcU9aMVRmd2duNWNLWm14VkVwUUZla2ZtV0JKVEZCWVpOSUlrZnBscklF?=
 =?utf-8?B?LzhYYkFweEd1N3haN3BwRFR3QjNybTBsaWZKWG8ySE91RzlURG5yWlVDb1Rl?=
 =?utf-8?B?Sit1UDdMVUp6aWc0SlRsRmdWMHRoaWk1eHQ3Z2JZdjhSbjVBbWJlVHVXUXJ5?=
 =?utf-8?B?MzdoTHNzZGNoSmdFY1dpVjZOUkpQSUdtTndPVGM2bjVySGlLc2dIbUlEQzgz?=
 =?utf-8?B?NHBIVnJuK1QrejZaYURwcjYxWUFsdituN21xaU9sVjBreEhTKzVFUklkKysy?=
 =?utf-8?B?ZnVWYWpxUnczS1R4aW5RbWE5OHk1NDFOZnkrcm1tRElMSFpLTUxkVmZQbUZu?=
 =?utf-8?B?bnNqZC82SFJYcDI5d0hubVVtREttREhXUytzN28zTUJDUWQwTGZDMUMweHlI?=
 =?utf-8?B?T1V2Y2JoUGt3bWNNRnpLNFN5a1NJSVFOZTNSTGU3NmN6OEcydUVjZW1WMEN2?=
 =?utf-8?B?VkhKM1NFOEZEMm9XeGtHWWw5Y2Q1NTMrdVhhbC85UUFVS0t1ZE5VS1ppc1Nh?=
 =?utf-8?B?emRPbnZWWlRlZUdpWWxZUGJPYXRPK2RCSkJmbEp5NWw2L3VCOStqdnpxSGgr?=
 =?utf-8?B?Qlh6bmdrV3BOTFp4YytiRFRlSUhvZ2RGTE5aeXdHQjNHV3VobjhWN2ZhVU92?=
 =?utf-8?B?VGJIR1NuYTdLZ3QzV3Y5NjdFU05KZmxRK0psd1VDTUNrN00vZisvcXVDU3p2?=
 =?utf-8?B?UnFkNGxQeEZFMnpCVDJxRnJmMVo4ZVZzVkZaaERxS29ydFZ5Q2lOTjV1SEkx?=
 =?utf-8?B?emtXYm05NkRuWmhTSXFLUmVzZUxTSGJEZU9RZVlBZlE0ckVlaFJmOU9QaUJn?=
 =?utf-8?B?QmxBOXdkSU5XZUs3NEJTdE5yelZVY0hVTEk1c2FjaCtXR1QrNVJGV2QyVzRI?=
 =?utf-8?B?bFJ1STMrSGdWOVF2UHQybEdZUmFuTGhYUkM3ZlJ4aHl0cElQUnM2aTBxdjQ0?=
 =?utf-8?B?bjNHb2dZbUJQMzUwODFBZG1HRzlPZngrZ1R1MGUwOXcvSmVQQWJiR05vbWpN?=
 =?utf-8?B?U1JhOWtxRjNNRDhCczh4TEE4djMwdXdiOXNRVWpXZEZHWCsyOWh3WkYxdVpx?=
 =?utf-8?B?ZXMxZE5pUWlBU3Fha2VwRU83eGlkdGFIUzUybmpEbDZ2bldOZjRwZnlLcEFG?=
 =?utf-8?B?MCtaci8wQ2RmTkRlOGNpUHZBdlBpU1NRUG9pSlNTaWw5YnZJZzdJc0FnMXlS?=
 =?utf-8?B?aENMa3JteUxtWnA1QWx1MUJFR3YrR2hFRnZJbUxSc0tDejdWdUpoVlFaY1dw?=
 =?utf-8?B?Wkw3dFdRUXhJVG5uSW5ud2pmMmhIR041V0huOG9USEIwUTJvTnRCVktUZFl3?=
 =?utf-8?B?bjVlWXJUc2dCWnhwSHRHdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDF0anlqem5JbnFvSGhtbTJDUEJJN0NteGpWbWJKZUhwc2NLS2JvSG9TTy92?=
 =?utf-8?B?am9yZjZoSmhiMkM3Q0Vjb2tvTTNveE1LUnBVNGxMYVM4bzhIUnhTWHhDYlEr?=
 =?utf-8?B?cE1leHZlWldqRWhXSDVkZzRDTVRmVUMyTzQ2bFVmc2pQZW5LUUJGa3VKV2J6?=
 =?utf-8?B?Mkcwalh1WmszSmNEVitrZzdlWFE2MFdXRmdXOXQ1aW12YllVc0I4ZFM4MFVK?=
 =?utf-8?B?akJHMFJZUWEwbHFCd1F2U0R5dS96SVFYOVBUTlRhcDBFcXh6Z2I0U01NbklV?=
 =?utf-8?B?MlhKekpEM3hhaVVLTERLaUYvK3JNN1hvR0hPZ3RjNVVsZUxORisrcEovb2cw?=
 =?utf-8?B?RXBUeGNQQ21ld0xoRWVkTE54SXF3ZUJrVy9hSFF3NTE1NGJycjRJbmhVa3Ro?=
 =?utf-8?B?UzBXYTZaRUtqMG9YdkxzcVVMN2JaRkVRV21qMUF6QnVpM1htWkVteUhXTjJV?=
 =?utf-8?B?ZUF6a1I3YUQ1a3FBN2tjczZIK2JTWnM5MklCeGpra1B0enJmZTQ0bUxGc1I1?=
 =?utf-8?B?V2hvSHNiWnNzVFpjVUErVzIyaEV1VU1OV3Jhd2pmQWVBR2J3L3lxeGlLRkpa?=
 =?utf-8?B?ZnJzV0ZjeW84K2V1YXBUR1lzbFBDTUhlV2JYaVl3Z1VGNEloc2kyWEt1dDhZ?=
 =?utf-8?B?QThQT2Q5N0NZTnhWSHA5cGtoazFOYVlwUHJ5KzlTZllCMHZSWHA4VVJRRWNo?=
 =?utf-8?B?WUpIbU9Wd21LcnVLMlhXZVA0K1VadXdBZytXOG4ydU1NT0dDY1Z3aTZBRnhx?=
 =?utf-8?B?ZDVVYzUzZnB4RndLbUs2R096RWtjWWFaTDlsT1V2czk2aWtOQWxxMkJDQTNN?=
 =?utf-8?B?YXV6cHo3QVE1RFI3dk8vcGxWd1ZEdUtuM08zWGF1R2h1U2xkZ203N3pxWFdZ?=
 =?utf-8?B?bTRPeGVJeFFITGJZUjNNMnBQbGE5ODNhSC9XRXM3VWhZaFlKdGJLZEI0cWdT?=
 =?utf-8?B?RVk1c3c1RExpLzNvZjAwaGhhMHI1Tzd0SXpYayt2OWtRVjBYbWxwdCtnQTQw?=
 =?utf-8?B?Y0lNbjV6aVpWOE1pQVhEbWtyaGU5SjliSzhaTTJVWjZ2enVEZkphUXcrV0Rk?=
 =?utf-8?B?SU5hTHB2elJZRVhJMzMrdWp6MEFlNkxmcVMyMC9qQkpmamY1YnBteFBrUXlZ?=
 =?utf-8?B?L2xyMkROVUxYV0c4RGloU2tHQlE2d1VFV1MrOFdPaWl3VjZaOHZ3azRROU9X?=
 =?utf-8?B?cEtZVGhVS3d0WXIvenVGZFZlS0RqUDdrTkJ4UXd6UURSYmpxVTZuQnoxdndO?=
 =?utf-8?B?WE1rQ3N2eGw1OEtRelVlaXFnSWFtK2xiWG0xSG1KT0VINCtjbTQySnF5YUFS?=
 =?utf-8?B?T2ZueHBUQ1Z5M2taVVAxRzlhWmVvWHVMTWNzTjlHRVJLMGcraVNqeDZYTmUr?=
 =?utf-8?B?Rituek1lUi9nQVJGME1mTXhKdi9NUmVyb2Z5U2F5ejR1R2kzdEwvRC9QSnl4?=
 =?utf-8?B?S0dlUS9lNFY2T0FlRExiM3Y5YkFZMnhEWEF2VUErS3RRS2sxREU1NTYyTWtG?=
 =?utf-8?B?VEt4M01OVUMrSGY3M1dMUThLTE8wclU4VzVwMC9pcFp6aHVWOFpLVFdmRjBU?=
 =?utf-8?B?Z1kxS0JKM25kU2lyZjRjQXBzRUw5UU53c09pZG0rTS8xS05CUXFDOGpyeXFO?=
 =?utf-8?B?MWhZaXlyNlNMUWw2aEZFUnFpYTk0RmNoa3RFMHNtR1hJMlhVWXJHd1ZRdlpF?=
 =?utf-8?B?Q3NiWXVNbUh6aEFFekduMm5ZNVhzNG1JQVkrTmZMRENaOHJHUzY3ZWM2UzBm?=
 =?utf-8?B?eDgzc0ppZVJSbVpncFdGWlNCUlN6bTNYdHNZKy9lbFlyNDJHcnQwTysybUlj?=
 =?utf-8?B?MDNsMDRFZVBVckMzaC9lVURLaDJGVVdNRkZYR3JnOEQySGRnTGp1V3NVVkQr?=
 =?utf-8?B?WGJMUlBSbkUyUmtFV01DZmlzL0hQbldpMGs0WkRYMlRlMzBQUi9DUVlMV0c2?=
 =?utf-8?B?T2dodTljNSt4TnY4T2RZdllFOE1LN2pZSlVKWWp4TGRUOHFTV0FmSWVhL3Vk?=
 =?utf-8?B?WVQyZTdNb3Y3YkhSV3E1VlE4VFdyZS9yN3cwdjBDSmtsS0pKWXZhY3FWMW1H?=
 =?utf-8?B?MTlBOHBYR0Q5SE5wS3FDY29ndVhnMWoxSHFQZXIxVlRMZXhJS0dnejVFMGVk?=
 =?utf-8?B?cnAyT2ZKeWI1MUFHZmpyMmRwU3pva25SUjdTRVhrVFJLRng2M0kyUitiWk9G?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c891c5-fcee-4fde-a764-08dca2bea3c5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 22:04:45.6171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q59yyb5AJqbA69GpBwPeAVcZlRW95XlqrRuC+zO67w8URdNQa4nkTq9HgT/mjmpoGBu+QkaF/DVWOLOHsEAssMTa6HrsIKRq9fO6EPerzUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7599
X-OriginatorOrg: intel.com

Hi Babu,

On 7/3/24 2:48 PM, Babu Moger wrote:
> thread_throttle_mode_init() and mbm_config_rftype_init() both initialize
> fflags for resctrl files.
> 
> Adding new files will involve adding another function to initialize
> the fflags. This can be simplified by adding a new function
> resctrl_file_fflags_init() and passing the file name and flags
> to be initialized.
> 
> Consolidate fflags initialization into resctrl_file_fflags_init() and
> remove thread_throttle_mode_init() and mbm_config_rftype_init().
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

