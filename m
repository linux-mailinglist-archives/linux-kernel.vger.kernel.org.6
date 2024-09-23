Return-Path: <linux-kernel+bounces-336347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C23A9839FB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526211F21666
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6C48563E;
	Mon, 23 Sep 2024 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlD7N3Zx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0841D8172D;
	Mon, 23 Sep 2024 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130585; cv=fail; b=IVt2VtO11Qk0Wasc5jqz6U1/zG7hh9RlmgYHEqKZb3Bre1HkRR90K+gYASpAu1wLaaJduJiJtIDBSOapuSJiPrXouNJAolWpLZIeFj15Nlgj76TROgdNaTPVJShKvghinycXRFZfgueRlyT4GgdWhkPTxcnRQHGVI+vQeBFDFp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130585; c=relaxed/simple;
	bh=pdFvqYfGffUQTZzRiWVhzksAbbNtwVbB5MBYMrYN1jg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ottRx4tdo7LEX1JdSrRVQXfp8HyvD4UL5TB99rIg/hWIKqslvV0jRc2s4fuRpCp1oT05HwbH2dfq21pexPB7Igin2vFQQJrKiTvIc0D85QDKFSeJiRnX6C7uLNDt4/HW8lNuFpwB2anLawc3asVvJ7sgEhz7qUAqy0/dGy0m/xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlD7N3Zx; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727130584; x=1758666584;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pdFvqYfGffUQTZzRiWVhzksAbbNtwVbB5MBYMrYN1jg=;
  b=TlD7N3Zxg7dslZoYV/lStFece70up4P5Py0UnLQ7gbkkhfn95qs/MeeB
   jHePUnrQ/HK6CkOz+pf8qtxyS8fFe+ZsPWiPGlG6MW4QoZRVFb0vvRhcV
   BVPwvHZSIliHDDC73sOhTRBzKZbeV6qjT7REG4puX2tz4eQPzjif7FIvl
   IlrwQWgo9SczZKJLKY93O6oDzBH06g2xQxqIMrk1aeWvLHwd/2u935wHX
   7Jwr49g2k6T7HMiBBqAuM8OKl7Lty5mgWkUvoExyZ5xWyMzbAU2StbLtq
   s8n4umZJKKi1fxcpWvwPufW7q+lSyQwGrHQQiRzSITvdtaA2CmLGj++yq
   A==;
X-CSE-ConnectionGUID: /xRHncXITvCNn3VJWvunkQ==
X-CSE-MsgGUID: 2G1jQFQHTgy3FaNyDN60dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26292200"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="26292200"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 15:29:43 -0700
X-CSE-ConnectionGUID: Vm6/jP8iQXKEGNs7aAB1OQ==
X-CSE-MsgGUID: +PsG7J+8Qtq3+L7r6hrkxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="71526328"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Sep 2024 15:29:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 15:29:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 15:29:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 15:29:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 15:29:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sky+rp8Gk/cv9d4kRoHZw2sIVVlQ5SBRuqL2+YvwTB9X7qaZ31qnNpCDY8EyLUYkAaPbotqwaT8kwO/yA9DFSpzmo9gSksKX6xBjml0za2u+OlfWBfWvCCN2vrsni1d1uh04OgWKADv243u29R8VQ5w+i7FeT861fewdVfcUX3sdXe0VOBdZNXF6q9gwew+6V4kqF1Axzd87eUy7Snczj4Q6d13GM1G+SWC/KWvj3VjvJ8mKfxdALcevyK3a3p8gnRU9IXrFIbtZxwZd+SLx6i49J9ShfIju8fbOyfWOZqwp0J67fqGdF56uuUpn8yB3oih9uoawgVZIRJjtvbkMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TkiiOv77JajRj/ZruX/rO+/EXjNiZiBEB9WtNWRwPw=;
 b=o+h7tOAxiV4dLWDcIFzfitxGPWgqQPKg/0Wx+GLHkdjk6vdQxOA6SJOEzGRLt/+0BOQjHEsV6BBT4SsvDfBwxAMKeyQxJq5XOJ5WVvYa1TG5jjr92WFV+q24r/4s2adAJfZzE6wcEnpVyNucM4Z2ua6+xz1ZHdWwmuWWlC0j921OsAt+rDI/5valjoJPrUXgKDr51DNhpOoi+i8CV7JPJymz0mbp52UqNMnidqHVBjPslQuqieIaTZU1mZ2S6KnwCcW5Wjr4BsHJa2AVtYOU8YVFd6cWJGYiuQRYJHOrpdqboO29pIb6K5+4d24N5biqYw/UWzPHVKf0HrN93ZAsbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB5277.namprd11.prod.outlook.com (2603:10b6:5:388::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 22:29:37 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 22:29:36 +0000
Message-ID: <d6f2b7e1-21f1-4698-8c56-cb8e46374688@intel.com>
Date: Mon, 23 Sep 2024 15:29:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 15/24] x86/resctrl: Implement resctrl_arch_assign_cntr
 to assign a counter with ABMC
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <2796f9514d9763d40dffbbfe651541d28bd4d995.1725488488.git.babu.moger@amd.com>
 <710c3d2c-ef18-4534-982c-a62761a09f96@intel.com>
 <666aa4ae-141f-4625-909a-d905e8f1c66d@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <666aa4ae-141f-4625-909a-d905e8f1c66d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0236.namprd04.prod.outlook.com
 (2603:10b6:303:87::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB5277:EE_
X-MS-Office365-Filtering-Correlation-Id: 355e0a76-fe2f-4d5a-e6cf-08dcdc1f34cf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkVMeGc3d0xCZGI0bFp0aDNlWjczdERHODFZSkFzNUY4QW5XOGRXRVlNK2F2?=
 =?utf-8?B?VVl3M1Q3bTRzNDk5ZnRVQUs4Zlhzdms3ZDVCMnFvUE43Z1dEUDNyOEdBVGY3?=
 =?utf-8?B?aHQvVks3d3kzV2d0ajV0NjRTbUd1YXJaMHZsMjA1SlZVcTdudHk1WjMzNjJ0?=
 =?utf-8?B?YVBJMG5GTmZGTjRWcFgxcTJhb2FzdmpnaXZ4Tjc0OVRPcFA3UDExVzR0dE9I?=
 =?utf-8?B?cmRuNEFoUmFGbmpabG44MEhsWmE2NlpKOW9QOVpIRlRCZEN6Q3JPQUIydG45?=
 =?utf-8?B?eGl4L0dpU3MxWmRWL2pLa3YrQXo1K0M1eFZndHRGRFJWN1RWUWloTkYycTZT?=
 =?utf-8?B?ZitDU1BQa1l2LzdCOXAvRVRpNVpOQktBNHNlS2l1UTUwZktZMFc3d3lLb0E5?=
 =?utf-8?B?T1RTNTdianB0UTZySmJHWDBLVnEvNXJPeHpMN1ZhMFZqcWlUV0NXOVlKZXI2?=
 =?utf-8?B?Z05sY25VV1FvNUJKaTZxWmxoaUw2bVBSb0ZJQnhuSWV4cUQxblB1VElLSHJV?=
 =?utf-8?B?VmNhc3c4aVV6b00zL1RmRW1za3I0eWlLczZHblA2ek1OOXZJYkNjZ1krVnMx?=
 =?utf-8?B?MC8wNjlDSldnamZLNEppemd1Q2IydHp6SFhBcjZPVmpmRFhabzVjclRJLzB6?=
 =?utf-8?B?TXd4QnNKc3JKUCt2RXNLQy9GQVAyK01ydnVlV3FmUmljdnhoTUwzS1NkdmYy?=
 =?utf-8?B?cjQ5azRGZ1VLN2NkS3VwRkVvVjlJSnMvWGU3WEpLYW1vdUlMQjlpNW43czc2?=
 =?utf-8?B?SnY5MTd2cXJQSXpkSXhXRUtmdE5Ub201SVZ0Y09qZk9MZU5NamtUeUN4VDI0?=
 =?utf-8?B?NkI2VG5rakZTcVEzdFFyN25jdUx0NnJSdkpqYUdTOW8xenZDWVdBQ2hxWmU4?=
 =?utf-8?B?MDlTeE53NUNOSG96Qlo2bkY1N1pnZDQzWU1PbEJ0dXR3UzgyYkdoSmo1L2Nm?=
 =?utf-8?B?VG43Q3hQM1NYbEFOdjBsaE9PTEltM3JCWmRPUWNzajB6UVZQMnJnNm5hMDJr?=
 =?utf-8?B?cXdnSjM3VGZTSVJtaVMwbjI5N1VCWW96QlBDV2kyUGRVbmRoRDE0MStVRjVG?=
 =?utf-8?B?bUVKTnhhREQ5czFEd3dORVZJQlA2WjdpMzJLT2k4MHNyZVRWS0hzb3BOWXNv?=
 =?utf-8?B?Zm5zSkRJYnNaQWg4V2p0c3lvam1JalFZdFovU3hKN29NaXZ4NVg3QWZrcEJo?=
 =?utf-8?B?Uys4eGxNZjd1SUQ2U1J1cVhlcG9raXNneUZYMEQwMzBrQyt2bG1TNFlTdXB0?=
 =?utf-8?B?YVdsL1FWbng4cVRLN0NIemVNVEF3MTRSdGQvOTl3dENuVDJKem5UQW1QQUVK?=
 =?utf-8?B?Q2E1U1ZnRG5hN2s5NkkxT2F1NFJZL2tWM3U1ZEFGaWVWZlRFL3lEdHNaUEo5?=
 =?utf-8?B?Y2swQy93N2RzRjR6NnJNK3FvVGk1bnhGV0dzZW1Ib2VVb0FweUQ0TE80SERq?=
 =?utf-8?B?dEdWWDAxVy9zYmRhcmc2R2Q3aEIrZm9CWWZyMExXVkhxRmVnQ2J3amZUREtH?=
 =?utf-8?B?bkFXZ0I3UmlRb3NJU01sSm9NTXNlakVtR1JuMVNLSnRDSU1sbFo1UjNSMmQ1?=
 =?utf-8?B?cFlRUnRqblFQSXV2RExyZW1aakR2dHRhMlBiS3pWMndmMjloZ2NWdHFlUENN?=
 =?utf-8?B?Sm01MGxJMmJOOFN5TFp1UTNiMk5PVWRWTy85ODZMZmo5TTdmbWowNkhXeEJW?=
 =?utf-8?B?a2lxWEVEckxpTjF0RGdzdXZOUWpqNG9SMlJyR3NvSHUvdktoZk9xY2VoemdV?=
 =?utf-8?B?WmhYR2lDQ0Z1Wjk2bU44TVNycnJGRkFnZ1JOZHRIQzkyU0w5eHBoR3M5dWZn?=
 =?utf-8?B?dHVwNStjNUwrSGFkZ2YxUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmlpQ1hxTEdMVjhSczRzVVI0TjFmME9UOFQxTHJtbFljM0ZrbjBGU2xRa0t3?=
 =?utf-8?B?UGR2bU9LRTMrb1EyR1hZL0FoeFYxdko0cVBXMjZPRlRLNFNHeGc0a3hoWldy?=
 =?utf-8?B?MFQ3QWhWMmt4WWdBcGdsdXJUdE00WjVENFRXU21wS1BmbGRkSkkyd0Jud3JE?=
 =?utf-8?B?Z2FXL0VNc1JtTXpmcWF6NHJlcWhTeG94alhjSFU0aWNjeldSMVBLTGFpSUxv?=
 =?utf-8?B?K2JOYXFuQk94RVhpVXNrNnE5Z2Zkckl1cm9rMkhKR1NJcFMyVVlmeFRBaWZh?=
 =?utf-8?B?Z3hUcnpMVW5EU0FFdVJqbzE0bzRrK01zRDJEaEd1K2FsREoreUU5dEZqeE9C?=
 =?utf-8?B?WDBubDFHZUFlTFhsNnA4emdQbzhFT1dSMUJaVjRseCtQVWJSQU5DR0lJSEd0?=
 =?utf-8?B?eDRQOThZaHpnUncyQ1FVOUQ0RGdaVU0zOEdOR1ZUaDh5YytxcnVvU2d1TnFx?=
 =?utf-8?B?aWUxQmJoSmZuVXc5UXdJTk9FblJ1aGhzWmRISVF5ODN1elpzdlJQL1BWNkRM?=
 =?utf-8?B?RElYM1VKUUFjSzV6UENKSjZNTk94YkNyVmE4dVY5eWhOYlNFdGhBUDZxMkZK?=
 =?utf-8?B?ZjMrM2tic0daN3pxR05jaW1KOXFOVDhydWxrUE8wbmJ1VXdNbnpiZU9zNEhC?=
 =?utf-8?B?Wnp5UFUrWVZQVTJxeGtzUHJMR2RnblNXUkpFT3hvUFNZUm5PQ2tOTWkrcW9T?=
 =?utf-8?B?SWJ4dVA3QkpKSmZpNURvalpHLy80ajNYdmptL3MzMjh1MVVITGxqZERSMkpY?=
 =?utf-8?B?K0Nqd2w2TlRYYUMybXovMVFuMlNLclJZb3dsUTJpbm5vZEM2SEk3WnJrS1RE?=
 =?utf-8?B?bVJ3RSs3NlJ1a2kwUkFVYTluY21rYlJOWFR5SFJSMjFhc3FudGIveG1VKzZQ?=
 =?utf-8?B?S2RtZHN5RHdveEQxd044Tm4rVTlWNkQvUXFHNjZkL3A1MXc5bmZBWmRoV3p5?=
 =?utf-8?B?OTZ5MXFZUW5Id25pSm5xVjZ1MXF6WWF3N3UvdWR5V256MGVWaHM2R3ZPeURa?=
 =?utf-8?B?WXlFelp5aklYemNUWnIxOHpCRnBuNzhtK1AyUkVMdTIxSWsxQzBodFNxL1l5?=
 =?utf-8?B?NkZPcFlFbTdvNTFSaHVWUXh1Z3F0SDNoUTVmMkhTNlhSWG5Ya2dHZExscWNC?=
 =?utf-8?B?cms1b24xM3lOWk54bWFpRGpKV0NwMDZoN3BpQzNJTFB2Q0pEc0QwSmpWNG9W?=
 =?utf-8?B?Q1NKT0k5d3BxaEFLTGZ0b25zQlFkM3pYZ3dYZm85WFhzWWpCckZEWVpTYjI0?=
 =?utf-8?B?UDVMK0lMdUwvRmhpQ2ZPWmF2MXZwaFhjU21ta25CMHFPdEV6a0p5Vk9MNU01?=
 =?utf-8?B?ZFMrVDhla1Z6SGFMWHM1VmtMSnd1RTNFVDNHaTkyVHhHTFNOYk9CVEZxWG43?=
 =?utf-8?B?UjdtYWtPUWZyU2FpalJQUlh6UDFjc3NuTWpLVENxUWNzaGg3WXpDNFVwcFpJ?=
 =?utf-8?B?bjBNTEJvbjN6Zk01QmIzdXZMbFczMURPWU4xNFluNytxb3hCZkVRM1dPOGdZ?=
 =?utf-8?B?M1NNRFNIYzV0VFdTemxBa3ZyVmxXbWVNVTBWcEJHN1M2N3Y5aVdNZTc3ZFRD?=
 =?utf-8?B?a2RiL05hdm5Fa2dYQmkwS1ZCdkc3c1NXVS9KYkgrUUFqSDA0dHl5OXAzRzM0?=
 =?utf-8?B?Mk56QThtUTF1bGU1d1c2akdQT1RJM3dHOHBKVEg5dXZhVWo2NW4yOUpUUlJX?=
 =?utf-8?B?cXpxVVkrQTNiRy9RVUI1c2E5Sm5uTlJrUjIrdzVFV3MwUk81emNOT2lwN2lr?=
 =?utf-8?B?WEh5dkNObHY3cVVhRzZteVJ3ck44ckRQRFhsbjZEaXAzR1ZSN3VZTjBVTWUy?=
 =?utf-8?B?bGhVRS9HbTZITXFCL1NISEowSFI0UzBIMGdkV3lJb2lZYXlYZGNERTJabFZ0?=
 =?utf-8?B?S2QzaVBMT00va3BxZDBhZDdkcTNqUGFPdmZxY1QxVE1GOE5UUFlCcDhwNWNk?=
 =?utf-8?B?MUhlc0MrNmlkQy9OTmlLV2FZbVY4ejE2OW9ocjhvOXJCVTBaRTlJYUxsWURP?=
 =?utf-8?B?VDU4WmxlQnZNTC8rODhBMXE3YlAxSzhiaUUwRC9SakpnZ0JsRFh6NG1wNmRu?=
 =?utf-8?B?Tk5GQi9VNWx6TGpyQ3NGTTlicncyOEZERy9WWkdPSldBOUlTQ3UvNnhjYkI4?=
 =?utf-8?B?MnhncnROd3dhSzB5NS9OVjFlWDNoUmtWdDU5OE9ERitaS3Bnem1PY0VFaEV5?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 355e0a76-fe2f-4d5a-e6cf-08dcdc1f34cf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 22:29:36.8846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLCWq2L57Gxjx3Dl1PUYA4xAuv3nV1z9ixDmj0ZNAvoEOwi3mXpKOgTAIXCfR3qtWEL2KEijaIXgivVhhmXUIdHIWOrZ1sifqn0lJYe+yDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5277
X-OriginatorOrg: intel.com

Hi Babu,

On 9/23/24 2:03 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 9/19/24 12:13, Reinette Chatre wrote:
>> Hi Babu,
>>
>> In subject, please use "()" for a function.
> 
> Sure.
> 
>>
>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>> +/*
>>> + * Send an IPI to the domain to assign the counter to RMID, event pair.
>>> + */
>>> +int resctrl_arch_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>> +			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
>>> +			     u32 cntr_id, bool assign)
>>
>> Looking ahead this is also called when config of existing assigned counter is
>> changed. Should this thus perhaps be resctrl_arch_config_cntr()? 
> 
> We have a matching resctrl_arch_assign_cntr() and
> resctrl_arch_unassign_cntr() pair.

hmmm ... resctrl_arch_unassign_cntr() does not exist in this version of the series.

> 
> If we change resctrl_arch_config_cntr() then we need to change
> resctrl_arch_unassign_cntr to resctrl_arch_unconfig_cntr().
> 
> Should we change both?
> 
> 
>>
>>> +{
>>> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
>>> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
>>> +	struct arch_mbm_state *arch_mbm;
>>> +
>>> +	abmc_cfg.split.cfg_en = 1;
>>
>> Just to confirm ... a counter remains "configured" from the hardware side whether it
>> is assigned from resctrl perspective or not? It seems to me that once a counter is
>> "unassigned" from resctrl perspective it needs no more context about that
>> counter, yet it remains configured from hardware side?
> 
> That is correct.
> When unassigned, we are setting cntr_en = 0, so there is no counting. But
> in hardware perspective it is still configured.

I think I misunderstood the "configured in hardware" to equate to "assigned by
OS" when in fact it is just a bit to indicate when hardware makes changes
requested by MSR write.

Reinette 


