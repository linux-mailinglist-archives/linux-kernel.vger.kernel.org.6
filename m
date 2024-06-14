Return-Path: <linux-kernel+bounces-214158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96825908053
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C616FB219FA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7764319D894;
	Fri, 14 Jun 2024 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQ+AqdUq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ACA17D2;
	Fri, 14 Jun 2024 00:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718326501; cv=fail; b=gKTNG1UzmG5jnkPE2OE84xmE4a0RN+mAY6p4ZEwR7To7k+HTUKtPVrstZuu4afGknRzCT9YewuFtmJD3W2s93SsfrrwCV0tt6owpUfeK82Vl1I4wcwEPpp8nyjWTKl35Bz4ZuV5Q9F87ATBNcrrn0qLQYd7FjuPavuM+/R5eMYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718326501; c=relaxed/simple;
	bh=+0+gC50wZH527UFxc3Hg5a/Zwg9BC2bHAzq5RgDPtAA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XtTBe2ZJWZlXdBn/UnidHpkGTOHOJ5h48mazDg47zAQWmNbtywiRYzkzBXTsKpJKftskraQDFIVzU3Qkyg3Da5OGGv3fF/dKzudOzQAqhHkLFdHGrwbyrEQKfAoIjH0dGqYT5eKyMz0ZCBX1b8JE+EkNs2ycyfrObLQ1eX1/63U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQ+AqdUq; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718326500; x=1749862500;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+0+gC50wZH527UFxc3Hg5a/Zwg9BC2bHAzq5RgDPtAA=;
  b=IQ+AqdUq6OIn3ZUQcxHcMbUIZ0cqXgqJAUc2yJm+QElfIvWcBhbAOxgA
   6LG+OJVoedgDTLqRNh7UTTXk20i5svzAVLXMQvoBjFfHszcMCfyd/7Xvq
   BjgbbUbD4EqSlUy/T8jWlNdSv+JfEndqjT+JzvikytEnWywczTZEdxkv1
   AAmpXI5xxGhIssm+1pHDJP5qlZvzVseo6efLXidldUOD48eLH9SY6a7+I
   xrHU9TFCES8CaHsdXzZfm53R2W2+a1p5ng0HgzDOuDlW5XjaUzFl3sdgM
   kJZSuTNvSw3Jnp/0/6aBzQJlCpgBlgQMygXmDJfrOeLS1c4eH9wDk4s3F
   A==;
X-CSE-ConnectionGUID: iBCpB8x5Re6X6B0Gjq9KQg==
X-CSE-MsgGUID: On5a+CB9StKaS64ncBD4qA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="37717069"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="37717069"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 17:54:59 -0700
X-CSE-ConnectionGUID: 9l9n6Nm9QluyK+RiHGBliw==
X-CSE-MsgGUID: bIgJk1vkTr6F7Lps6tnoxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40191130"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 17:54:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 17:54:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 17:54:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 17:54:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgSrO8ZW6qNWOMTU3luAtAc+pVPJsKbYjCtullBl1+4ZlDXaA6e/Z5IMoHPaYBTVKAJKXRFwKBXXUtu5bzF5QOR6HZZwaRm74h90svMjsYTasja1o71GlDxWuefO0B9V8Q0b9NTe7Yt5jrEfrTpzBYxR5Mr/IGXl42/nq0v/NQ0d2l5q55qPMgW5AAcRHW2o6bjYmRokra4lmIsep5GWsClI0cJqtbjdX3Hk+REihTcg1cEBhSro2Y+fLWc8KOicpheMZbq2rSLtaUL0jRTwspkYbrEx1IY4ZP1ijwGI4vgKlPJIl5adzAVuLc9HoVzXODncb+SmPqrpPgZKPpqaRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0+gC50wZH527UFxc3Hg5a/Zwg9BC2bHAzq5RgDPtAA=;
 b=Gmc9cOvV/pPol9oJmJL2gveewUvooSCIr2/ExrPLgZt64w7ELdshSw2SKwm5LrJJI0sdfuhaKIQEILnNmkiI11hDl811ETplqbtS09/f/NLAaafYc4gyn6k6Z9uMBfTRitM8OV7kTLxqvzrw+5I4EWfl2t0jeu5oYWKu/W/hjzeKhG7B+crMu4EY4nqOvlVe37gVvG9xd4AO9EM1ntLBMPCGQR9+wMEIhWDZMR/YsU528Pxacb7yEltTCGasbeKgTwaGNzUfXXbJ9a6/FyRE6ZfuDBXSniuPYfNgUZByOEjyzHrf+N9OBOX1aTQTB4bEPGGaXQac0pmdo9k3lf1S+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6861.namprd11.prod.outlook.com (2603:10b6:303:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 14 Jun
 2024 00:54:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 00:54:55 +0000
Message-ID: <6c1adfa8-8fb7-419f-9c52-79105cd673a4@intel.com>
Date: Thu, 13 Jun 2024 17:54:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/19] x86/resctrl: Add support for Assignable
 Bandwidth Monitoring Counters (ABMC)
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <38ecef15c453f5b70c8519ce1a5765f7ddd6a4cd.1716552602.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <38ecef15c453f5b70c8519ce1a5765f7ddd6a4cd.1716552602.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:303:b6::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: b57f3bf3-2800-4965-6650-08dc8c0c9b61
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUJHdFIvYWFzRXdjcmdhSS9IOVVMUnFRSHRsdHVNSGxSeGxmclgrc21KU2xi?=
 =?utf-8?B?N1d2N2h5ZlZmS1hXVlhWOHZTTUx4M0FLcHRlZ0JPcHFzaTdDdlVtMHdiMVVY?=
 =?utf-8?B?UjBGZkxUNzc4Z1dmeG15MytUcHN5SE5tdDJHK3UrWnhUOWQ3S01qL2NFRzFR?=
 =?utf-8?B?RjZpL0taaWM3TGIvUExLS0kzR2hTOFRUV2phdjBxbTVVOStiMGxEblRlWGFQ?=
 =?utf-8?B?TnF1RWdWb1dJaWR6Zkg3Z1JiMnFDSzRKNXhhUUpyMGFVR1NDT1l1dW05K3k4?=
 =?utf-8?B?OEtYUHVyMk9hTks5M2VkTkxEY0RHeG1lUzNBNU1vWkdaOUNyTlY3UzNkYk5E?=
 =?utf-8?B?U09VakxWWlZXNVpjRml5MHNWaEJPMDNWNm9pUFM0cFppWTIwcUh6TGZJRXV0?=
 =?utf-8?B?c210RHp5WmNxb2JZWHRvTFhSTU4wUHdSRm8rTDkxeUg0TjNDS3lray9BVVM2?=
 =?utf-8?B?NDJaQWczRHpOTjNlNVZjQ280dmdKUkNTenNrbUh4VGx5Yi9QUWhBYlRLa1hx?=
 =?utf-8?B?QUpIOUdxSFQ5aFhkVW05clZmeHVhTmRVQ1dJMEhLc3NxNGNHUXhXUFdGVHhn?=
 =?utf-8?B?OHpuWFYxWVV2blRGWXViYTBtTzZHWVpVRy9lUzYxOWxVeitzMGpWN2NxdDlQ?=
 =?utf-8?B?TDlneXd2cCtCKzgzdmxIc0YreXZLUmdFRVZsci81M2dYZ3JWU2x2ck50NE5O?=
 =?utf-8?B?cGM5cGE4R21hd0g0Z1E1VVJmMmxDMnR1MWJ3bEppeXJGcWtyZ1RiNEVsakcr?=
 =?utf-8?B?eVJuQkRLZHo2M0dPRUMrRTEvS1NlRzYzekRIVkZYWHdKendxdVdBV0ZJdURT?=
 =?utf-8?B?M080MXo2RWtERCt5ZEZDVFBQcFFrY3htbzVCQkVURjdUd3NFbnR4Ny96V3FZ?=
 =?utf-8?B?QkRLMzI3OEp0eG0zdFdZZnhzSG5wSnZkKzM0VXEzclJkVHJUcXlJMmtycXd3?=
 =?utf-8?B?L3B2MUZTWTZsenNGZGxib2dDZzZ6SjYrL0ZIdW9mYjNrNkVuZVJmWUk3MS9Y?=
 =?utf-8?B?UzBiYmNpOVpKcnc2eVZtRDN0S0c2QUVSd1Z5VnN1L1dwend1czBIL1dkQkdy?=
 =?utf-8?B?UCt5c2Zwd2FjVko1U0hPV0JGWXFIYXBVUm9HbTdKQVhIUWpIaTIzU1h4RHho?=
 =?utf-8?B?U21aWEhXWSt3WGxEUHFScERTeHFoQVltNUw1TUE4cXdQeFAvOVZqZUlFLzBz?=
 =?utf-8?B?Y0loV3V1S1Z3MzVmaDE2NlBYZjEydDYyckNMOE12ZGhyNmorVU5PT3NoVGcz?=
 =?utf-8?B?STNmcFU2RTF4a2o5T3BzV2ZHSm5aemV1VzhjUzFqaU5KK1lvYW83eURXLy9Y?=
 =?utf-8?B?Z01idzY2ZllNTDNpcFlTbmdNZTQ2cUE1VDBleTg1QmMrMHlhMjhISU9UVHhZ?=
 =?utf-8?B?Z1dOd0FSMm9IbmZGUGx0Q09KVEVtajVzaGYwdncwbldGaXpDc2hjWXh6TWN0?=
 =?utf-8?B?MzhLMURPQkVvWXpsZDFXbS9IZzRYWERlcU1xbWpvL3p1S3dKVFkrMnhDZ3A1?=
 =?utf-8?B?cktEVmdMakFzZisvdXVZdHo4c3NEYlJBYmxGMjlrVWFrbmpPdGVpS0p4d1lh?=
 =?utf-8?B?bkU4bGJydk82OXluT2JRU0xMVmNiMjNjTUkwMVV5QXJTQ2txelFvenluQUMx?=
 =?utf-8?B?L3dFVDdVT3YrdEh6WUxYSUg2b3lxZm9sN2ZleVJMRlVvRjZWQThERDNSTzFy?=
 =?utf-8?B?cEtzZyt5SmhrdjFLby9MU25sanU0eitBN1Q2aUhkdkZCamJpdG04WUhpT2l4?=
 =?utf-8?Q?9+0eS2T1iyntq1lhXpuB1O6yvFNdK3XnTVoCkFS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkY1NVlWUTVVN3hyc1BPZ25DQU5pc3EzZ3R0TXBnODc0OCtRWVIzR1UyMEZX?=
 =?utf-8?B?blpzbnBJSUxUN2NDV1VIYlRkTDNBY2Fvbm1wcUZRNHNnZERJNEFvbW9OVGxJ?=
 =?utf-8?B?K0RnZzByeHZiZ3lBc3JqbUt0WlVqaWZFVHVlNllIUkUvWUdKTzVWQi9sZ3A2?=
 =?utf-8?B?bGJGcXo2VzZITWgxc3FXeS9vUzRKL3RVcy93bnVRS3diRmt3a1Q4TE5yU2ZP?=
 =?utf-8?B?eDZ5TVJlZXluK1dHVXJqbXZ5NVhmeWFNKzMvVmE4REtYQ0JpM3RLVzVleDh3?=
 =?utf-8?B?UnJ3OEhJbXB2WkVYbzlGakV4M3R0UElPTUdzN0FHUHZCbDA2ZHN3U1o5cUhS?=
 =?utf-8?B?UlBYRk5BSVdQV0VIMS8vMyt4UldTZHAvWE1BVzV1Q2lBci9oRmgxbm8vellD?=
 =?utf-8?B?ZFVNQm05Z1laMEx3d3Z2ZEdKMEZ4Tnl2U0NuaHhOSHpuNG0rNHVKR3BvUGJZ?=
 =?utf-8?B?SThZSEJsYk4wTlpuWkRrWlI5Ujgrbnp5QlpaSzNwaXEwLytJQUNmTGRyN0FQ?=
 =?utf-8?B?VCtqVjI3Ym9RMzR5dUNoK1h4dkY0akFuaGtUTzR0SW0veksrN3VhRFVXakFM?=
 =?utf-8?B?cmZRVk1ma1JyUURJSjM2Tk5PT2NvL2VUWWVDQXZ2dkxtNitxSXFpcmhvVkhC?=
 =?utf-8?B?cmVaZ3Zrb2VweVRFNzJmWUlXRVM2bmJoRXFYYzNJTnBSdzg3VFNBQ1Z1Z0FW?=
 =?utf-8?B?ZHZWY1k2NXRoWS8yR2hjbkxQOWhxZ3A0MFBJZWJwdzA2QkF5STB2LzgxRW9I?=
 =?utf-8?B?eThyUmFMWFU4bHUvcjI5bFgxR3F2a1VlcEJqWWdSNi9MTnBqazF6YmE3Z0lV?=
 =?utf-8?B?bzFkbks1dU1rYWZtNURIS1FBcjhvaUdrWExRRUZyU2JMbDFqdTN5TDA1L0wy?=
 =?utf-8?B?ektkOE9jazU2aUVNdzI4T0phTmpxeDFuMjNRbmlEOWw0cldZbFhYeWUrcldi?=
 =?utf-8?B?MUtmOUJUNEJTV2NnNFN0b0xtSTRlNHlaeXZZYzAwNlExa2l1ZGczWnBkYWtj?=
 =?utf-8?B?dWJvS0c2YndBSmp2dXJrRndJTEhkbmk0MlMwRUZtVFBTYlQwOVRVdmFFNE5K?=
 =?utf-8?B?cmdOdWlybDhlNUlqMExzbUVWYnBXRWJNWTBKUVhSdzRZbUlPUHRmUk9IV25R?=
 =?utf-8?B?UFNPdEdERTd3dG9rb1dkTys2dUdOcWQzbFhpMTY0Wk5CVWtLUk1RMWJrTmEv?=
 =?utf-8?B?REpVem0rN0pITXNOMk9YeE9laUhlazQ5OTl6bWJNN05BVDVYaGxoTGxKcnFP?=
 =?utf-8?B?Z0YydEtRbVFsR2VqNEZIUEU0QmhQOFh2U3dnU21LdlROWmZMQ0N6OTc2REZX?=
 =?utf-8?B?MnU0N01xL0tCV0llNmlsSnA4MWZSOW1UeDhIRk5FOWFrTTh1VTR6N0FDRWdx?=
 =?utf-8?B?SEMzYnJISmhPeDV0M3RTeG9HSm5RcUY4b3pzNzI3Z2UyaGxROFRXVUp5WGJB?=
 =?utf-8?B?TzNTbUxZNElLUDFJaTJldS9hTHhtQndSQ1psTWZuRzJUSEMxZkx6ZW1Xc0NG?=
 =?utf-8?B?ZGZPTWNPanpLK3ludHZkNWNiT21XdjdyVUdjbk5MTVlUWDZ2eDJ4TVY1ZFY5?=
 =?utf-8?B?Rk1SckxYZk8zSk5lVVh1Ny9TSlhBQ09Rc2dyTXBZL3d5R2VBNi9sd2hyWVRp?=
 =?utf-8?B?YjJpZTZZZW9waHkvUGRXS2ZpUzNBbUdzNlhUSExIcWFXRWl3NHVIL0h4dXRo?=
 =?utf-8?B?dnVDMnl3OE15bTM5dk9xb1FuUDl6RXFXQ2NIM1dQSkpWYVRkV1NiZVY0dnhP?=
 =?utf-8?B?aGwwdmZTNm5HdHdlSXk2S0I4WWdPdzZ0a01MejdWdlNFbFZtbXVqOFd5Rysv?=
 =?utf-8?B?N2dhQlY1QWNUQVM0UnpIWi9LVmlVeUE3eEVEOWsyRWZLUHFvOHpPbVFpRWtV?=
 =?utf-8?B?ZFFlRHJRWnEwc0hoTWZ5bmZBU2NxeCt0ZlVJUDJqNVQzcEVISHh6QUVPczQr?=
 =?utf-8?B?RUlmZ2ZTSFB3Z1R4b2Q4OEhsVmEwZXQ2bXkzaUxBL082RGZSa3grOXJwUWY5?=
 =?utf-8?B?VEI4czl4RERKMENLNEJKRWJkeGExZGlSVUxPTUN0NTVQUzVSb0o4ZGtheHVs?=
 =?utf-8?B?TFZ1dGQyY1BkWWNnbHB6MEFUZkYrZnRLZkx6U002cTRjbmpFb01oTXBJUTFu?=
 =?utf-8?B?czljUTc4bmtyc1hUbndZVkFtTndEQVl2ZCtmSUlnc1NveVp0M3B6b0pXVUJN?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b57f3bf3-2800-4965-6650-08dc8c0c9b61
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 00:54:55.5438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +N75sX5e3TRMbcmDofWYSrYMd3f/lHB+ny+HU9ODHkrfKMwQ9yKxwaUgMnWU7fcfGpTGChae+zhuFV+6irXG+EjF7q2fLUOK7GO9Qas0RQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6861
X-OriginatorOrg: intel.com

Hi Babu,

Could you please change shortlog prefix to be "x86/cpufeatures:" to
make it obvious where this patch is headed?

Reinette


