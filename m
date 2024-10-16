Return-Path: <linux-kernel+bounces-367182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9594C99FF8D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E53F7B260A5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0885C189B95;
	Wed, 16 Oct 2024 03:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TTl/xkz/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB4A1885AF;
	Wed, 16 Oct 2024 03:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729049470; cv=fail; b=mdxku5mpKEWnvTkpTp2jT9XVKmFhbw3JJkd6E8XaIDBIVetL6ycj2nRwwAO/wWIFQhTwb9c+dVOe/u7oQWrlKqE6fh3hamE1tlVeYRT5OxcTZEKIkCK07mM5tMUfPLj4U65Gg3c/DQjRkSK09xAx71FXeImD0hrmCIn9kULsX0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729049470; c=relaxed/simple;
	bh=QNnxIeOaH1lHww0ZgJJyZUgreY7lxmz+sl6EgcGTeJI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dWiKpzxx7itRsNL3JRe94NwKqBiReX+x9ZuPgRnYUeLv8UNdg+q3xmIHJvoiTNL/ofmz+bd6UrlF4JEBN2HVx3gsc13ZgtTPdTfuXfVBKQ/9dY71EjxoNPzB6BBGVPBm6IwhWpY05HkB0bfObvn8KlFDbb3JEjGqhmb3dMlRM5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TTl/xkz/; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729049468; x=1760585468;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QNnxIeOaH1lHww0ZgJJyZUgreY7lxmz+sl6EgcGTeJI=;
  b=TTl/xkz/ZpKaQpP0F80kDPKynKtJsbGRnhuTLPOebqMT/6uEBsJ1teXF
   ucMHO0i5wb82MDux3khsTYw83z4X1MFUUDZQNwbnDVnRSapVnAqrm6Eu8
   Ye51nXNFamoE5Ss8XvHzw1A3dk1k6vsfJE30ev6buV9JjGpCFleIH8BqW
   LRFO50mBOiXxcJS57Aqr/ArY0z5X4j+LoRzX7cZlRUSwaEzv3DS3o5ZeH
   MqBu3TLp4/qSyVVdRDHkbJW6TjJfQiaW38VHneucBSadsEJ/hPnxRNwWh
   sgdHOkcmZCUOadPMjk2JieQz/Avcops3wcOyeWbvdQRMOWRTChMia8j1x
   w==;
X-CSE-ConnectionGUID: 2NWd2On8R7+6oOlx3qtmfw==
X-CSE-MsgGUID: 9bHv1bMlQT+kWPqW1UPJ9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28611424"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="28611424"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:31:08 -0700
X-CSE-ConnectionGUID: EfXPky80R02LyaVp8AEdPQ==
X-CSE-MsgGUID: UEDJNpV/Sr6JNAFUEN+QUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78268901"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:31:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:31:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:31:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:31:06 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:31:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/LTGjIKBBOdijdPMC9c9pREO6qbzRhWKA6w9q77s2V6AyJB+uIPJeZKV0kaJ4Pa+5EHhuiyrroIxLH/NxMztTJV/Kvl5wlJtjykxT0VGyDyd9upX60AOkjZ1X9FKBHZ7IWgqCF5dEqcYYG/L4w7SJZwAH1HfjIxjXZ0KYxWWisQDMOcIZItgPKxkw/LhuMCVuo/zd2rrWJR19shWoSl0vfORI16rLXR3BS4g+HfFWGPsoEu9Y7NjSLlozif+qXs4ZP5Y4cd0bWQL/INRb8tJeOIFwPUWZ9PhC+7WbdoTo5DaZWKlR5LbGLhbc1DEHBF5gbc1tHKfC16LQ7J+WGz9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toRQrw57zzj4TdUOzAeBmEte+OGnwNBM06zEJdKd/UI=;
 b=S9RHYnysfCdOr7cSEVOQAslI6qUIPcP2fPPGsAbWWbRbt7ddb4R+iZpXC2OATNkAT+vzKIWxo4lQNtxUkpunnxWBfaI88VVVpZxKzb1RqC5byisplbu5F0rjz7SP4eHDXeTdh5/VZgbCgQaSiq82MbPwMFiVRdT1jumm/OD3/6Gn+nGLdyX2yBjKzAWWaoOu8F+Ncmcds9F2/lrFJa5AMbgyRytH3qimjK9rU5UWObpaQbqY0FWDPd2UQw3miIHIsz9mfEBCesvaNshodUqDbGXvK5cok/wLKR+BHGUrzUrIVAqzoduu1mAG69OPQTB537XrF1d+cqMGLyA+B0iFQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 03:31:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:31:03 +0000
Message-ID: <115efb93-9d5e-4e03-9aab-a08afa003359@intel.com>
Date: Tue, 15 Oct 2024 20:31:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 20/25] x86/resctrl: Report "Unassigned" for MBM events
 in mbm_cntr_assign mode
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <50a4e993098422eece96d08edc337856a52cadd1.1728495588.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <50a4e993098422eece96d08edc337856a52cadd1.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:303:2b::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4723:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7f8ab0-35b5-4f04-1187-08dced92f671
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnllcUpHK2ZkalI0bm5YQ0gvY01WT0RhN1pIK1JaZVpqZlVCSnBERmUySkpx?=
 =?utf-8?B?NHl5UW1CWW1QVWgvRTRpd1k0WjJlMnNGcWRSTWJjNDRFcmg3S1VuUGh4UXdi?=
 =?utf-8?B?aDFQK0dtNVZTTnhHSm5pK3I5TUdHcnBFdXV5YWFyTjlaL2FFalRRMFJuN2tw?=
 =?utf-8?B?SUpJVVlnZyt1a0s5LzJLWm5IbTEvcjQ0d2ZOcUc4ZVlGYW00Yk5vS3YwRGtJ?=
 =?utf-8?B?Z21IOFRySDRJT0g3UXNIQUg1b3VYN0dpbXBGaVZEVTd4Z1IxQUVaTUR2SGFn?=
 =?utf-8?B?K0hTeVNzQi9rM1FFdHA4WmJNQ0dOczFtNkJaTUloT2UrdStBTDRVK04xSkZh?=
 =?utf-8?B?amplYkdvNVR5dnVjZ2dsdVhCZ2JnTWZHN3lodnN6VFN5eUFsSWNNd2hKbG94?=
 =?utf-8?B?V3JVUHJSSUlpMkpWL0lPQnFCckowcW9nODFaV1VrdXE5ZUVtRkJ4MlNSUVkx?=
 =?utf-8?B?NndlS0RQSW9yWWxxM0pHTzR1V1BOWjl2S3pIZVQwczA0RXVxZ0xmNGU0eWJH?=
 =?utf-8?B?VzBZUTFDQXAza2N6anBJNFArUzZIaWdma0hYMjVacHYrbFEweVFXY3RtS0hI?=
 =?utf-8?B?aXNYS2RKVXFxdGRPcllNS3dEeWNRTXdyeDdpeWpYMWFUaC9kUUNFUW5CM3dj?=
 =?utf-8?B?bUd3SFFLRGJsUnRuNEYxWGVHMWhwdVlHUTRrVnh5SVN3cVNldS9xVGthUDhC?=
 =?utf-8?B?cVZiWVA1SUs2MklSdkNBd3ZUc2VTVi9qdHRFeFA4M3ErT2RFTUZFcVFralNJ?=
 =?utf-8?B?cUM4bC9sTW9YL2pIeGp3dmZWM3dYcUM0RkVMUTk1MUxPRERoeUtKNlk5RzVu?=
 =?utf-8?B?a2RMUEFzR0o3aUpjcVEvMUEzalR1d25Tc2VwV0ZYSmNsbTM5T0V4R0J0ZHB2?=
 =?utf-8?B?VDlvWjBESVYvS0JzL0pTbE9MWmx5a1NkcHZ5aXBBOVhXOFVHTHBQK1IzeXdu?=
 =?utf-8?B?cUVHeWNYNkM5b3FNeDh2eWR1MThMUElmamMzYlZGQks3YUVwNmtqdHphMWlz?=
 =?utf-8?B?cEkvUlpsRDYrVVdUNGhTVmh4M3hiY3hvbHFOZTNsZmNIdHVBcnJDbjA5aDdY?=
 =?utf-8?B?dTZYbGZpWjBkVVRpL1RBUEJiWURzZHhoMDRJakVIcWFycnN0djlsanF5NmtV?=
 =?utf-8?B?bUsvYXVVVnJTR0VvcUFsOXVZbUFWWWF5SU03SFQ3SFlOSHFuL3dURGlHcHlY?=
 =?utf-8?B?Y0Nid3RmRzVxY0pMbnlaWXdQMDN2Vy9PaVB6N1JHd2ZML2VVeElZSGJ2eG5X?=
 =?utf-8?B?akhhZWZaN2ZWdjRucVpEeERaTVFoQjF0Zzd1YVBzOEpXcjRyWmpwZnR0NEtK?=
 =?utf-8?B?TFRXSERlT0VpVkM4SXN1NnF2THZrQWNRYTA3RVMyNzNjYnpFSGliSlB5aHpL?=
 =?utf-8?B?NXBLQ0Y4dmVweWE3SGVUMjdWRmR4cUFob0dhdnh4L0x1MnQrSm9nT2l5V1lP?=
 =?utf-8?B?aExINVdmaElVQVJORW5oVW1xc3Q4TGVmc3JKZkluaEs2UFk2ZDhpbkJCSmR6?=
 =?utf-8?B?OHZxUVNFQVA1VUoxd2lDb1ZqeVQyUFlrZUNLZGFuL3hGZkRKMC9HeUdBTk4x?=
 =?utf-8?B?KzZTUXJmajlaek1lckxUS2xvaDJIaU54bHFRM0UxbEVmSzNlUkFybDlqd2FU?=
 =?utf-8?B?VXFaLy9iWjBzNFZTakZ0WStjeC8wc0Rkd0ZrV1h1WXJmcy8vTW0yaDB0QStH?=
 =?utf-8?B?UzBxMFZiOE0xSlhmT29UYmhQNktKb2UxcTJQNWpodms1OW1IcXlReUlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjVHR0JzNlVkMWtXZktwZXNaK0NRdlhNVkxZSlJaWHMrMzJ3ZUI3aEhEWDlQ?=
 =?utf-8?B?U2Z1WFFQeDZYK3FJdCt0Z0M0bG43MHN1Rk90a0FRV1pRZ1l4MUZJcVhkbUdv?=
 =?utf-8?B?anN3eGZQNndRUjhhSWpXNHc4bWpUczFPd2JZQkxka0hYcWVTelh0aWdGQVZz?=
 =?utf-8?B?ODBYMkRLWitlTFVkcUNYTzRkRnZjNTBsNVBhK1l1aDV3QTd3WDhFbURMTk9T?=
 =?utf-8?B?eEtlZDAzcFNzanBWVEVTMWRhek9ZZzhXK3IzZmVKSjFPRUkyOS9BdGlGbVhC?=
 =?utf-8?B?YVpoOVB0KzlPcXN5OHdoaTV5Q216K29xYmVKN3NTRXkzdWd4UVphL2t2bFlM?=
 =?utf-8?B?NWZVWTRsUWpjRTRZMWpoTFJxNHVYblg1a1RQTUNVOGtmemJkcEZ3SHNhU1Ns?=
 =?utf-8?B?UTcwT0t1bXNYZGpUM0tPZHBKT3FTL1lBenBqTmJ5MHh5SUVGRTAzKzhRMFJF?=
 =?utf-8?B?TVZWVEFwbThJdmlqOHY0eEwrWHMwaUREaFRISm5hZmk2MTZBV0VpYThsSFRn?=
 =?utf-8?B?YnJ0SW5mZ3NveStBeEJZYng4WnhWSlVWbFZaMVhqczREQUFvNUFZcVBnUjRo?=
 =?utf-8?B?MnI5VElyRjgxM25uUlNITHZ4emFpUjI5cWFsOWZ2OFByUGZ2ZzdBL2Y1YmtI?=
 =?utf-8?B?K28rdW83T1FoSTRwcEJkRDRtbitkSjJkODZTMWFxV0NPa3BZWDdpdnhIbTl3?=
 =?utf-8?B?ZjZWVGlqM0E2clhFVnF6NzdyV0YvMHI2c0R3QjZnSFFIa011cjBseW4rVjBi?=
 =?utf-8?B?Mlk4d0FiWmtSeW4vWDQzb1dwKzVOc3daRVRGUkdiNThSS0NqMGJGNWE3SXo1?=
 =?utf-8?B?MVU3MC9LUnRWL21IeEw2N1F2bHpXeWNsTUdmYlhoVkV0OTlvczV5ZTdXZXNk?=
 =?utf-8?B?dmRJbWJIQVFVQ010akZ6Uk1LWjZSTDdEeHB5S3dzYzZ0MjdLVXg5NWtoYWZl?=
 =?utf-8?B?UG54VlJvbkxzSmh6RHhrSysrRWNySkNlTERWaHQ0dGlDd3NVbVFsMWZVMlFT?=
 =?utf-8?B?STY2SmVXTVBPY3BrWkRxcjRHTGZXb1ZnQ3diaTJYUXYzZ1VoVHB0aWFkU0Vh?=
 =?utf-8?B?cnRHUHdaWmUrODVuaEY2dzlXL3VSd1dFQ3BuWHk5SlVZTXVmOHpxNGo1dG9N?=
 =?utf-8?B?cXU4b2xaYm4zbXJnWUJOV29JMSsxTFhoTnNvcVBoU1BodTBpZSszTkFadlNS?=
 =?utf-8?B?OHlkL0ZHVzc3T1F5YTJ1S3JCQVFUcm8yWFBBUXlvelpFcW5BS1c5dllEeWNJ?=
 =?utf-8?B?eStJVXlQcWo4LzRhWGIxdnBPdko3dStzcTBMTC82SnhOUEw0OVhlKzI1NWVB?=
 =?utf-8?B?SGFTQ3hDL1l0di9oK2pwYy9hU3J2M0xISFkvNXRiRVY1V1dtbTNGeTFURGlD?=
 =?utf-8?B?NEJSUXpyZ25yOE9ZRnpWTWQxbitFOGZkVE9xZWFWM0N4bUZGNUV1R0FwdWsw?=
 =?utf-8?B?a0FZckVLd3RLZEg2TzZVSlE5SnF1L2QyMGlFSlRWbFlpc2ZDZDVSckZzNXBT?=
 =?utf-8?B?Z21ObW5OQ1FSRjNwTTVxRVcyMWh5SVlPdkhMQlhiN1pEb0V0UWhWaFliNWdh?=
 =?utf-8?B?K3hpZlo3bk1wcC90aytsZXFGQUZsVlM5YlBZekVmbWdVSitwN1lXaE4yV25W?=
 =?utf-8?B?c25QS0p5WE9sTUdTcTZUWk45Z0FIWnlKUCtFTzIyNlZSRktwRWw1L1g2RndV?=
 =?utf-8?B?M3Q2YlVvR1QxWXZxdjZWbmxEL3hHekFubjB3UUwwdmxyeEx5d2Q2Y0xkYm9v?=
 =?utf-8?B?WUdKRDVSbUMwSnlOZ0oxMk50cWFKMW9qNm1uMjJBWEJqWW9XY2pYNnJuZjB2?=
 =?utf-8?B?b3IyWGk1Q2drQzh5WEpBd3NRNTFIenhaSnVaNlJIVUhERWQwbnFFTUUvQTJF?=
 =?utf-8?B?Y3dvaHlZazdRRFU0VWl1bXU4WmFFRGRwa2tBZVBFaUdXMDM1VkJVVzEwTjd3?=
 =?utf-8?B?aHZDWEptMDFZemloc2l6UUhhS0puVEtOVkRnV3doM1o3cGFaWVRSb21UM09Y?=
 =?utf-8?B?UGJuemFSaENMVjZVRUVQTFNERlZGM20yb1JPSU9WdXpWeWhIUXFqcTBUNS9k?=
 =?utf-8?B?V3hzYkJUcUw0c2NmaUh4Qll1bXRTem1nK0xGRlBnOW9XTWpGTHBoa04zR0Q0?=
 =?utf-8?B?YmNFYnJDNGEwc2toeStWWEEweE1qeUNDeUdpOGVtRmc3QythbzczYmVQRjI3?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7f8ab0-35b5-4f04-1187-08dced92f671
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:31:03.6443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjEVAQBvU2n2qKX12DHyUCH5Yoja3CYJItfuqC2wv9MGXyowxp+PxbO8MFDrTHiWMWiRjSeEsrS41teCYACnkB7/QYxsT6yPg/uRBktBaxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> In mbm_cntr_assign mode, the hardware counter should be assigned to read
> the MBM events.
> 
> Report "Unassigned" in case the user attempts to read the events without
> assigning the counter.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v8: Used MBM_EVENT_ARRAY_INDEX to get the index for the MBM event.
>     Documentation update to make the text generic.
> 
> v7: Moved the documentation under "mon_data".
>     Updated the text little bit.
> 
> v6: Added more explaination in the resctrl.rst
>     Added checks to detect "Unassigned" before reading RMID.
> 
> v5: New patch.
> ---
>  Documentation/arch/x86/resctrl.rst        | 10 ++++++++++
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 13 ++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 1b5c05a35793..99ee9c87952b 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -419,6 +419,16 @@ When monitoring is enabled all MON groups will also contain:
>  	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
>  	where "YY" is the node number.
>  
> +	When supported the 'mbm_cntr_assign' mode allows users to assign a
> +	counter to mon_hw_id, event pair enabling bandwidth monitoring for
> +	as long as the counter remains assigned. The hardware will continue
> +	tracking the assigned mon_hw_id until the user manually unassigns
> +	it, ensuring that counters are not reset during this period. With
> +	a limited number of counters, the system may run out of assignable
> +	counters at some point. In that case, MBM event counters will return

nit: "at some point" can be dropped for clarity.

> +	"Unassigned" when the event is read. Users must manually assign a
> +	counter to read the events.
> +
>  "mon_hw_id":
>  	Available only with debug option. The identifier used by hardware
>  	for the monitor group. On x86 this is the RMID.
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 50fa1fe9a073..5a9d15b2c319 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -562,7 +562,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>  	struct rdtgroup *rdtgrp;
>  	struct rdt_resource *r;
>  	union mon_data_bits md;
> -	int ret = 0;
> +	int ret = 0, index;
>  
>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>  	if (!rdtgrp) {
> @@ -576,6 +576,15 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>  	evtid = md.u.evtid;
>  	r = &rdt_resources_all[resid].r_resctrl;
>  
> +	if (resctrl_arch_mbm_cntr_assign_enabled(r) && evtid != QOS_L3_OCCUP_EVENT_ID) {
> +		index = MBM_EVENT_ARRAY_INDEX(evtid);
> +		if (index != INVALID_CONFIG_INDEX &&
> +		    rdtgrp->mon.cntr_id[index] == MON_CNTR_UNSET) {
> +			rr.err = -ENOENT;
> +			goto checkresult;
> +		}
> +	}
> +
>  	if (md.u.sum) {
>  		/*
>  		 * This file requires summing across all domains that share
> @@ -613,6 +622,8 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>  		seq_puts(m, "Error\n");
>  	else if (rr.err == -EINVAL)
>  		seq_puts(m, "Unavailable\n");
> +	else if (rr.err == -ENOENT)
> +		seq_puts(m, "Unassigned\n");
>  	else
>  		seq_printf(m, "%llu\n", rr.val);
>  

Reinette

