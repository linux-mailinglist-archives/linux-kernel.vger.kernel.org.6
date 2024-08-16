Return-Path: <linux-kernel+bounces-288813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCEE953F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81CFB1F24494
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBE12868D;
	Fri, 16 Aug 2024 01:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPtqRH/y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB231D69E;
	Fri, 16 Aug 2024 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772764; cv=fail; b=rUa42lxc8dqBkqobpYqL0OdB0xKmM5wV4BcKLp+GxfbNIm0p178Hf+4ckPsXEOUHCyoscI9kBFApilut/gap+4f+zqON1+Y8YdX7J8aly3e0dVwJq1yhDCshddJnaBjuG3vXJgylmAYOnAHo6INZPGsK8qtwqpJ5xMroslYZ5DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772764; c=relaxed/simple;
	bh=C9VTDuVZLNA0aFEco4SCO3WvqzC95e7vZ60Al0PKFj0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hsa/l/Wedqz5utHO/kZJn8YgmLqlI9gtzyY8tzsc1P9b0YiU97Eg+y7j610u+AcoPefYGDJ5tt4SK60wOc+uqBno/KWMBtMNdNfEaXKKRHWCNGaxRiCKCFPv0LrWjLCsz1NSFkdFLPTcms2L23Z3BFO4nCVdZ7XBS83IH61B22s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPtqRH/y; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723772762; x=1755308762;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C9VTDuVZLNA0aFEco4SCO3WvqzC95e7vZ60Al0PKFj0=;
  b=mPtqRH/ywZ6npBJNNN05rRY0L4MENhI8Pw13qkKS6NvLC16Z8ZUPPMvl
   SGSrn9r7ZG87qBM7diOAjIF6aOz2j1hbXe1+evfzmM/M2P2oRihhZaOKp
   RnIUHuGWg6jSG5/5vHiwFLnZrxMOYmPSc/uZV0pykkYmQHzUB/i7qi7a/
   zhTdYhnvejBrdk9/DMhWvE0Oofw2LqOEX/9kRzHBSE1D7dTVFQ7/VBoub
   DcH0Fu90I4VXGao6zWcIHlYxdFpUkTisGuqOP99Rd5vTU8IBRSxQBD97c
   EROdUyVimrRj+Mjpi/WXD3pIcb4nFHOCjFvmaqcCes0E1GHrN/Zh3YyCd
   A==;
X-CSE-ConnectionGUID: b/rUwQb2TxKaVuV0GIFTyw==
X-CSE-MsgGUID: FwsbciIJTtG6OzwoRblQhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="32697717"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="32697717"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 18:45:59 -0700
X-CSE-ConnectionGUID: ++g5k0W+SHqkd/kjlS/BUw==
X-CSE-MsgGUID: bFjtkE3zQqayEzShI3jK2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="59370047"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 18:45:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 18:45:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 18:45:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 18:45:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 18:45:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdA8ungkXvY6FjZJDOon4L7ulVWntx1jC8DQvvzCUm+RSnq10oaVvV4Eigf1BaBVPs+GjekmhpYK/eVk0aiDopi/2qL2VhYkNhPF3Rwm8aebJk5LOFt+E3Hztszec2EUup+2IIGedUPhK78PJIbhY3lHgjzl+VkYs86eT5o2dADldgit4Kzke+gl8SlJBlYV9XccUU71dy+tMHcjgFls1qLrrJviP/w+q2Te3W7dwIGAhPk2rgS2HlxgXE9vy2iiscPe2N7C9X4u8sFnnUpY6xO1Tp+Aegewyp9rpU1J2euA0wzGADcwTkwT3so81qMaUnm4vs7FILgHy2/9hULj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdGYPaUIJ5bM1IOA8baY7r/Cm2c6cMROJLqRq8hi9ys=;
 b=PL28reXZjLg2JXyjovXV3NGWM2+wFhyFQrJfRyyh9dEtwefphT9ctS41ui+6krxm9VGexmcSYwkGKiK8UhFhwS14gKIg9P459AXSNCzwlrlpMf0RO3VDEwiXGWXsnFA/aZptA7MHeA78J5/DxlCPGpCu/ZlMm2izldfqs8qRSY+/DZOx0aG18JC0osDm2Kog5zq1kaWTfL9BVu95kzrX0HxLED4hDXlX6VLak00EBNk1P6FwFlsVrN/pJeKTXKe6RZTcvxC6ykIf7ERgYoIEooyLxKO7jf3NM9nBbmBAwJdzcGiGJoBk5l2R9I0WYlYZYIIiuTAycQsvpNcAKc/Fzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6749.namprd11.prod.outlook.com (2603:10b6:806:267::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 01:45:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 01:45:54 +0000
Message-ID: <37766706-b4ea-4aa3-9686-191411eb480c@intel.com>
Date: Thu, 15 Aug 2024 18:45:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/20] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Peter Newman <peternewman@google.com>
CC: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <rdunlap@infradead.org>, <tj@kernel.org>,
	<peterz@infradead.org>, <yanjiewtw@gmail.com>, <kim.phillips@amd.com>,
	<lukas.bulwahn@gmail.com>, <seanjc@google.com>, <jmattson@google.com>,
	<leitao@debian.org>, <jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>, <james.morse@arm.com>
References: <cover.1720043311.git.babu.moger@amd.com>
 <e04b721a-b5cb-4089-a3ad-125a6247e5b8@intel.com>
 <1c50b589-a738-4ae6-8362-bd1ce0d0dc98@amd.com>
 <05b4e345-ad14-4ea9-a13f-2c9b3a6eb422@intel.com>
 <CALPaoCi_TBZnULHQpYns+H+30jODZvyQpUHJRDHNwjQzajrD=A@mail.gmail.com>
 <b3babdac-da08-4dfd-9544-47db31d574f5@intel.com>
 <CALPaoCi1CwLy_HbFNOxPfdReEJstd3c+DvOMJHb5P9jBP+iatw@mail.gmail.com>
 <b9e48e8f-3035-4a7e-a983-ce829bd9215a@intel.com>
 <CALPaoCg3KpF94g2MEmfP_Ro2mQZYFA8sKVkmb+7isotKNgdY9A@mail.gmail.com>
 <a19d96ac-f83a-4f5a-98ce-c5554e12afc5@intel.com>
 <CALPaoCiV-xTKn9N+oP4mqgRwsWxPUfutKDF==1h-8K9b7YfE0g@mail.gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <CALPaoCiV-xTKn9N+oP4mqgRwsWxPUfutKDF==1h-8K9b7YfE0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0389.namprd04.prod.outlook.com
 (2603:10b6:303:81::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5e6beb-6a5a-4095-d09e-08dcbd952ae8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGdQU1d1cTVwcmJPTFJPZlUxZ0xLWTdVYUNSYzRtZ2ZVbnNkL0w4QVRkWG1W?=
 =?utf-8?B?ejY2MzNtWlhCRU9tWWFVd0QwYVR1R1BNcVpJNjVJc2FPbEdHZlpLMmxWc1d5?=
 =?utf-8?B?RDd0TGFxNFQ0SkY4THc3TmxIa3I5VlR0aE91anpQY2prcTBWTzRRYmlQSVhD?=
 =?utf-8?B?VENzNnFDZGtBVnJpWmg2YVNXc2JxOFpIKzlKeXdCTFpaUXVjV3NWdW5zT2RG?=
 =?utf-8?B?WjZuN1JlWHBKL3ZpUkNsdTAyL0JCbnl3WW5nLzgxRnVUUmRyNGJnYXl2R2dm?=
 =?utf-8?B?cWp0WWpJMTBuUDl6U1JPTDZuU2g3WE9FRGNaVld0STEvdE5FVnRLK2E4V2dG?=
 =?utf-8?B?VHowTm5Xa2YyMlZUQ3VvZ0c1QnI5TzBsQytTL3k4VmtGazd0Vk5NK1hCbFF6?=
 =?utf-8?B?TUw2UmtpeHBpZWZSRGVCQ09FVnFNY2hTcGVvbjJqWkRmK1YrWTBoTXRRdlBn?=
 =?utf-8?B?TTlyLzRsREFxN2VpaFVPUWtleXFrL2ZieTNORjA5Tmt5L1NoK1YvQ3IzS25o?=
 =?utf-8?B?V0hFdVhMd0huaDByVW9VZzN5TDEvZ1ArRUg5OUcvdHlXNERRc1BIcGVaSXlx?=
 =?utf-8?B?bGVrRDBaQXZCZWIvdWRTbGxBdFBQN2FsOFhhSmxjdStzYkFwKzduREV5QWVi?=
 =?utf-8?B?UVNXWUVoUDlkenNOZm9EWDFSNWRFNyttOHdaRnV5MXpWanVQaG5DSjZCOURU?=
 =?utf-8?B?ZkN4UDZYcGd0WHFlZEdObmxJdzBqU0FiVmpqRWxCdnB2NE80L2xJYUgycjVt?=
 =?utf-8?B?MlNISnJ2UFEzMTNLVVVjdXdlSnJNUFptTHVtMGFwcWpvcjNoT2YyYS9VNm9m?=
 =?utf-8?B?ZFF0dDRIUTFCWkp4V2cxczBzZEdGQjJ2Q0lMaEhlVGNPVGdidjl0eHZMaWFu?=
 =?utf-8?B?Uy9zWXRMR3hJRHJhM054M25Fd0FpZ28xMFZrMWRKenF0ZzQ5UkxEVUlOSTFS?=
 =?utf-8?B?ajVDSWl6aFF3RFN1N3JuZXJuYUJFbVZOaEp1bXZFdGtyUGxveE1mT1BhUWd3?=
 =?utf-8?B?MjMwK3luZCttSE05V2ZFOFV0TnpIVWhrRFV3NjBvTDZOL2taYnZuaWowYjRV?=
 =?utf-8?B?dXRpN1F5VDFKci96bU10R0E1bDFQVW5tK2ZTYXZrUUhwc2ppWU5URGprOGV1?=
 =?utf-8?B?ZWUxUFUyRG5USVJ1dHZLc25IWkdObnBjTUJnSnREVXF6RDBYb09tM3M1TjY3?=
 =?utf-8?B?V3IvRTZpdXRCYi9UTVJhZHR5WC9LQnF6UVJCS3FMTnJzUC8vWXdTTGNFbFlp?=
 =?utf-8?B?dGQ1d0IyV2pyemFQaWwzbjE1Z3ZHcU9wNE5FQmJjUUZadC9rNFdhWVFDMU9T?=
 =?utf-8?B?OWhoNjZFR1RBQThNelNQVTFnMjZPa1Q5cUEzQjdLUHFDNnIrMkcxOHBva3Ju?=
 =?utf-8?B?R0YybXlETVBQbmVuUitsMlhvTG9MY0t5YzM0N0doZ2FNd1pWdENySnpxSVBJ?=
 =?utf-8?B?cnNIS3ZQR205eGozR3pPSjVGK1JMT2hwWUppdXM0TlIxK3U3dnJXeGlmQy9q?=
 =?utf-8?B?RStJSnRXakpPRlA2VXljMG5OUytOVWs1cGYzNjBBbkV1RmdzZ2thajR1aDlW?=
 =?utf-8?B?UXAwZGZ1VTNpZk16VWlFcmlOT1dKd0NxUWRndnZ6djdhMldvZWtaeG5WU1Rj?=
 =?utf-8?B?eVB4K1YyQmtFVXBvNGtjcmFhWUFVRUZKczZDdU9wYzVzeDNrcmFCdUpjZkll?=
 =?utf-8?B?WEdzWEE3dVNwMlUxZjh3UlIzNE8yRTV5K0xWaTQweUZGdnh0VWVwbVc2SGdl?=
 =?utf-8?B?RnZHU0dWWWVBYUlMN0ExazFVcWRzUWlDK3g4NjFnMDZoa1phYnVwQmhNTmhR?=
 =?utf-8?B?R3MxZTBkVWNuY2ZoTFNiQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OStOOE4vZTNhK1hLT3dZMHIyd2ZxWHI3NERBTGhHYmFqamVPT3BlbTQ1eS9W?=
 =?utf-8?B?SWJhRmJVemYxT0NocTNhYnV1ckpXY01CUVRmWm1EaXZncElWc2VaUFJxcG1o?=
 =?utf-8?B?Y3ZhQ0tiS3B1Tlo4U3FKSDlVRUNqU0hVQ21hUDhBdEkxbnBJYmM0Sm1QQm9s?=
 =?utf-8?B?YThZbWx4M3RjVzIwOWJLVHIyY2pORVI2VHlOWkoxdngvZTVkYWVFR0lzRjYv?=
 =?utf-8?B?a1htUjdyYjNvNVJOcDMyRVYrR0hOTFBnN2ZSQ0NXalVHdHc1c1hCenJPSEJ1?=
 =?utf-8?B?MzIwRGJpa3ZyeXRTUk5rd245WjhOUU1jVVZTbmQzeGk3cGZlbTJobktxd1M1?=
 =?utf-8?B?aEppOEthZWZyWDZ0eE1hTTdZNmZDbHpveTlFV25reUdxdHAvem5NdmFmWHE0?=
 =?utf-8?B?bmlwdXhCYXdPZWRqcnc3ZVRaR1RPS05qa25uUFFqTzg2WTJFWmdRdzNhdno2?=
 =?utf-8?B?UURjQ2I2Q1cwYjk2TDVnd3NSU044N2dOUzhtbGxYUUZBQlAzbDB2QVoxQXJu?=
 =?utf-8?B?MmJ0NDFkeHRMS3ZPbWY0QzM2K3hhdDlBTzFETW82Vm1RNHRWLzBDTDQvU1lB?=
 =?utf-8?B?K0ZXL2U2MjhjY3JqVHg1SmxTM21SaHBseTBQODlDYXdueFNzNU9HUm51T0NC?=
 =?utf-8?B?TXRoT0hrWWdQWG9vN09MbXV5aGlmUjFMOWZ2V0dHem9lL3ZQSHZmTzdnSC9k?=
 =?utf-8?B?NU54amZlQ2FTZmJQbU95SHlUbnViNEZTazRtZ0xCUTdKdTBkcjMyTDhCdmpI?=
 =?utf-8?B?K3pYbGJyUXNHVy9Za2NxYXByc1pQTXE3b2NjNFQ0VHYyRTUvbzVHaHJXNTlU?=
 =?utf-8?B?ZkxwSmdZSzFFS2w5S0U4bWhyYmtldmdud1M0SkdKN244c1l6aGFha0NkODFY?=
 =?utf-8?B?NHhmbnVWaEg1dWFGbFF5Z3d1U20xcGx0SGE3RU5nOVduVWp4ME05VWR0RnpU?=
 =?utf-8?B?T1dhVENkT01MWGxldjVzMmlraGFQdisydmp1SWVLQlB0NVFpVmpwTTI5SHIv?=
 =?utf-8?B?di8xUEdHVldCSDh4ano2R1h1RGZjeTNtR1lKcDBBd1FhcUhrYWtDR1Q2NmFo?=
 =?utf-8?B?NEdNcWxvTlpwWXMwT3ZreDZMTlA4YTVHZUttYzNBbVd1TjdHQTliakhDTTVj?=
 =?utf-8?B?U3FhbGVDOWJ3OGFFUTdsdmtlZ25FQnRjREhOZFBoVkJPaGllSFlSK2NublYy?=
 =?utf-8?B?NVlTUU8wYnhRNndZNHArMlNCS0Nta1lIbFVOekJRYnR5bGtlL2lOY0FjQTVj?=
 =?utf-8?B?K2c1ejRsWFpWVGxPQTZuZytjcDhvb0JNNmVsR1Y1NWhYK0I1TlQ2M21OSHRy?=
 =?utf-8?B?SkNIbWw1VmVkL0ZxYXRDc2ZXRU12ZDFIKytUbjBzUU1KUElmNnBtOSt4QzJB?=
 =?utf-8?B?dFp0MVVPMTNvVE1mUnNsbENtSzZVV2VWR1dDSHp6Y29OWVRxVlhtMlVGSFdw?=
 =?utf-8?B?VlNQcjhzSDhrd0x3Vis1QnErMGtNRDAvS21COGVWeHNTeTFPRitobEFvZ3BZ?=
 =?utf-8?B?NUpSWEhGVTBReUZlVldsWUhNcnlmQnM2WTNraE0ybm54a1JDRlJWcDBTbmRP?=
 =?utf-8?B?cTJTSjNwRUpnaDlWRkRjenp3N1VpZEI0Y1g1Rm1Ici9ZU3FCRkdZQmZWZE1B?=
 =?utf-8?B?dk84Nm5QU05hY2JCTVhIMUQrOERrNjU3NUFjNVUzc3RoT0NQREE1R3c4UUFl?=
 =?utf-8?B?b1BtcG1VZ1hOTFRxbkovTEEzRmg4bTdxMzdiMG1qakRCWnRkcTFkR2lxMnQ2?=
 =?utf-8?B?OHludzN0UllnVWNZeFBDSWtUbU5uMmRtdENWaE4zTnZReXV5RXlXS0RGbEo5?=
 =?utf-8?B?Wm51YUZ0NzRTQlAxLytKWTErd1FVNVRUVEtBK1FFalk3K0RFOVlRUFpJVzZB?=
 =?utf-8?B?dmJEcjVDckhjaS8xdGpNVUczQVZJcytZR2FnN3RSZVFoaDdBRTBMcytHTkIw?=
 =?utf-8?B?N2JjQXJ2Wm8rQjF2bmRhSDFOVWUrdHY0NHd5REFIOThUYjR5S0JsendHOUhG?=
 =?utf-8?B?U1RMcEVOTUo2ZTJQdG9UMHRWOTVCc1ZnL1AzZUJFU2VYTlFoMnRqemo0T0tt?=
 =?utf-8?B?dElwRjlqLzVJSGY2S0x5OFJ0bXNUQTVvYW9EWHVDM2xVcWh6cmRUNGU3aE1p?=
 =?utf-8?B?KzYvdFp5eS9KSWJMT0dKNUwzSTBmZ3NYcGlSRjVHcUZhNUlCeEZJWUxxSnRF?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5e6beb-6a5a-4095-d09e-08dcbd952ae8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 01:45:54.8841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZBch/tCMxmrxq8f7veP5mnXMRHEbcGjRfulsP5i8NDNvTp0yySJ4o7VNMKomg43awP6QcGINbFaVlTIChGXkgUZKReayoLmoQy26M1hc4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6749
X-OriginatorOrg: intel.com

Hi Peter,

On 8/15/24 4:06 PM, Peter Newman wrote:
> On Wed, Aug 14, 2024 at 10:37 AM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> Hi Peter,
>>
>> On 8/2/24 3:50 PM, Peter Newman wrote:
>>> On Fri, Aug 2, 2024 at 1:55 PM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
>>>> On 8/2/24 11:49 AM, Peter Newman wrote:
>>>>> On Fri, Aug 2, 2024 at 9:14 AM Reinette Chatre
>>>>>> I am of course not familiar with details of the software implementation
>>>>>> - could there be benefits to using it even if hardware counters are
>>>>>> supported?
>>>>>
>>>>> I can't see any situation where the user would want to choose software
>>>>> over hardware counters. The number of groups which can be monitored by
>>>>> software assignable counters will always be less than with hardware,
>>>>> due to the need for consuming one RMID (and the counters automatically
>>>>> allocated to it by the AMD hardware) for all unassigned groups.
>>>>
>>>> Thank you for clarifying. This seems specific to this software implementation,
>>>> and I missed that there was a shift from soft-RMIDs to soft-ABMC. If I remember
>>>> correctly this depends on undocumented hardware specific knowledge.
>>>
>>> For the benefit of anyone else who needs to monitor bandwidth on a
>>> large number of monitoring groups on pre-ABMC AMD implementations,
>>> hopefully a future AMD publication will clarify, at least on some
>>> existing, pre-ABMC models, exactly when the QM_CTR.U bit is set.
>>>
>>>
>>>>>
>>>>> The behavior as I've implemented today is:
>>>>>
>>>>> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_events
>>>>> 0
>>>>>
>>>>> # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>>>>> test//0=_;1=_;
>>>>> //0=_;1=_;
>>>>>
>>>>> # echo "test//1+l" > /sys/fs/resctrl/info/L3_MON/mbm_control
>>>>> # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>>>>> test//0=_;1=tl;
>>>>> //0=_;1=_;
>>>>>
>>>>> # echo "test//1-t" > /sys/fs/resctrl/info/L3_MON/mbm_control
>>>>> # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>>>>> test//0=_;1=_;
>>>>> //0=_;1=_;
>>>>>
>>>>>
>>>>
>>>> This highlights how there cannot be a generic/consistent interface between hardware
>>>> and software implementation. If resctrl implements something like above without any
>>>> other hints to user space then it will push complexity to user space since user space
>>>> would not know if setting one flag results in setting more than that flag, which may
>>>> force a user space implementation to always follow a write with a read that
>>>> needs to confirm what actually resulted from the write. Similarly, that removing a
>>>> flag impacts other flags needs to be clear without user space needing to "try and
>>>> see what happens".
>>>
>>> I'll return to this topic in the context of MPAM below...
>>>
>>>> It is not clear to me how to interpret the above example when it comes to the
>>>> RMID management though. If the RMID assignment is per group then I expected all
>>>> the domains of a group to have the same flag(s)?
>>>
>>> The group RMIDs are never programmed into any MSRs and the RMID space
>>> is independent in each domain, so it is still possible to do
>>> per-domain assignment. (and like with soft RMIDs, this enables us to
>>> create unlimited groups, but we've never been limited by the size of
>>> the RMID space)
>>>
>>> However, in our use cases, jobs are not confined to any domain, so
>>> bandwidth measurements must be done simultaneously in all domains, so
>>> we have no current use for per-domain assignment. But if any Google
>>> users did begin to see value in confining jobs to domains, this could
>>> change.
>>>
>>>>
>>>>>>
>>>>>>> However, If we don't expect to see these semantics in any other
>>>>>>> implementation, these semantics could be implicit in the definition of
>>>>>>> a SW assignable counter.
>>>>>>
>>>>>> It is not clear to me how implementation differences between hardware
>>>>>> and software assignment can be hidden from user space. It is possible
>>>>>> to let user space enable individual events and then silently upgrade it
>>>>>> to all events. I see two options here, either "mbm_control" needs to
>>>>>> explicitly show this "silent upgrade" so that user space knows which
>>>>>> events are actually enabled, or "mbm_control" only shows flags/events enabled
>>>>>> from user space perspective. In the former scenario, this needs more
>>>>>> user space support since a generic user space cannot be confident which
>>>>>> flags are set after writing to "mbm_control". In the latter scenario,
>>>>>> meaning of "num_mbm_cntrs" becomes unclear since user space is expected
>>>>>> to rely on it to know which events can be enabled and if some are
>>>>>> actually "silently enabled" when user space still thinks it needs to be
>>>>>> enabled the number of available counters becomes vague.
>>>>>>
>>>>>> It is not clear to me how to present hardware and software assignable
>>>>>> counters with a single consistent interface. Actually, what if the
>>>>>> "mbm_mode" is what distinguishes how counters are assigned instead of how
>>>>>> it is backed (hw vs sw)? What if, instead of "mbm_cntr_assignable" and
>>>>>> "mbm_cntr_sw_assignable" MBM modes the terms "mbm_cntr_event_assignable"
>>>>>> and "mbm_cntr_group_assignable" is used? Could that replace a
>>>>>> potential "mbm_assign_events" while also supporting user space in
>>>>>> interactions with "mbm_control"?
>>>>>
>>>>> If I understand this correctly, is this a preference that the info
>>>>> node be named differently if its value will have different units,
>>>>> rather than a second node to indicate what the value of num_mbm_cntrs
>>>>> actually means? This sounds reasonable to me.
>>>>
>>>> Indeed. As you highlighted, user space may not need to know if
>>>> counters are backed by hardware or software, but user space needs to
>>>> know what to expect from (how to interact with) interface.
>>>>
>>>>> I think it's also important to note that in MPAM, the MBWU (memory
>>>>> bandwidth usage) monitors don't have a concept of local versus total
>>>>> bandwidth, so event assignment would likely not apply there either.
>>>>> What the counted bandwidth actually represents is more implicit in the
>>>>> monitor's position in the memory system in the particular
>>>>> implementation. On a theoretical multi-socket system, resctrl would
>>>>> require knowledge about the system's architecture to stitch together
>>>>> the counts from different types of monitors to produce a local and
>>>>> total value. I don't know if we'd program this SoC-specific knowledge
>>>>> into the kernel to produce a unified MBM resource like we're
>>>>> accustomed to now or if we'd present multiple MBM resources, each only
>>>>> providing an mbm_total_bytes event. In this case, the counters would
>>>>> have to be assigned separately in each MBM resource, especially if the
>>>>> different MBM resources support a different number of counters.
>>>>>
>>>>
>>>> "total" and "local" bandwidth is already in grey area after the
>>>> introduction of mbm_total_bytes_config/mbm_local_bytes_config where
>>>> user space could set values reported to not be constrained by the
>>>> "total" and "local" terms. We keep sticking with it though, even in
>>>> this implementation that uses the "t" and "l" flags, knowing that
>>>> what is actually monitored when "l" is set is just what the user
>>>> configured via mbm_local_bytes_config, which theoretically
>>>> can be "total" bandwidth.
>>>
>>> If it makes sense to support a separate, group-assignment interface at
>>> least for MPAM, this would be a better fit for soft-ABMC, even if it
>>> does have to stay downstream.
>>
>> (apologies for the delay)
>>
>> Could we please take a step back and confirm/agree what is meant with "group-
>> assignment"? In a previous message [1] I latched onto the statement
>> "the implementation is assigning RMIDs to groups, assignment results in all
>> events being counted.". In this I understood "groups" to be resctrl groups
>> and I understood this to mean that when a (soft-ABMC) counter is assigned
>> it applies to the entire resctrl group (all domains, all events). The
>> subsequent example in [2] was thus unexpected to me when the interface
>> was used to assign a (soft-ABMC) counter to the group but not all domains
>> were impacted.
>>
>> Considering this, could you please elaborate what is meant with
>> "group assignment"?
> 
> By "group assignment", I just mean assigning counters to individual
> MBM events is not possible, or that assignment results in counters
> being assigned to all MBM events for a group in a domain.

Thank you for clarifying. I still think it is possible to use an entry
in "mbm_mode" to indicate to user space what to expect from the mbm_control
interface but I withdraw my original naming suggestions since it would create
confusion about what is meant by "group".

> 
> I only omitted per-domain assignment in soft-ABMC before because
> Google doesn't have a use-case for it. I started the prototype before
> Babu's proposed interface required domain-scoped assignments[1]. Now
> that some sort of domain selector is required, I'm reconsidering.

Could you please elaborate what you mean with the required "domain selector"?
The latest ABMC version (v6) added support for assigning all domains using '*'.

Reinette

