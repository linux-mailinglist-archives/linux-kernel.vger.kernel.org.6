Return-Path: <linux-kernel+bounces-571984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4AEA6C505
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95F21B61ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964BC230D0F;
	Fri, 21 Mar 2025 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fm+j5sFo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C029230BF0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591978; cv=fail; b=UMhaMq4DWfBIGF/NNKuijcOEWJX6rmydDDSQwtQdlVmrp2HiRXBJ25GmcnovrAPA468lhMUIDJlLDajXgAqzgLTOdMkKy8bkjwUIdNTcKhVbiIKoN/OCykI9pXXPXboEyLuk1tsIZK/5GvE2QDnKbC0DLLEv48Ko/BxBi267sm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591978; c=relaxed/simple;
	bh=kptr555EP+pkn/GtzqV/U5uS45fvtC2+FcQGoWr3NH8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eOi4fz8m2Iwg4eZtW02M5C13pzKZZcXYWXC4bR7alexzoF1QOz4M8aqTf/Dt6Hhi3B4JA61Wg25T+YVeNAYpqziAG1FvOoN2Fz7UtDT7AWj0ciQnRAFK0JQM0aV6pPHJtnxYG1nbe/Pwr5lFx/2V6PP5po83I379fzWw5ohkB1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fm+j5sFo; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742591977; x=1774127977;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kptr555EP+pkn/GtzqV/U5uS45fvtC2+FcQGoWr3NH8=;
  b=fm+j5sFoVGCO52pueLYqy25bXvYow/lJjqasdKCWTJOFoK1/Nn3tk2tX
   X3rKYSNf07fMUcpZi1ekmxUTNnKJB0z0A6oFVtDv3w/KU3G1i1+rABJad
   2EhjmeCM5fF7oKWSZoKDXhWb2A5nlwVFTKQISSxrKUKq4+WFlzpa+HIJy
   b4OakXy/OjnaYZIeaCgVNPDDTHb/wzhjBsOQxmH+UukPZCMP7PLu2k852
   G8DcQiC35DHHw5sBb6NGV5RYVFWW3/q3OmYlr4/vSFdGd98o/CbuOaszf
   1cQgw+1CNgfTlCL0SiQBW+y8/BZM7RtS/j0EVafqH7RDQPa/QdIZYbhNs
   g==;
X-CSE-ConnectionGUID: 8t5CTr2nRQyZH++sAf6K9w==
X-CSE-MsgGUID: l3vzB7+xRj2+EtYxzTPoZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="61265730"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="61265730"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 14:19:34 -0700
X-CSE-ConnectionGUID: InKEietSQXypcMxf7nGqng==
X-CSE-MsgGUID: XBrfGKZVQ7iDsmT6GNP4UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="128568239"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 14:19:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Mar 2025 14:19:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Mar 2025 14:19:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Mar 2025 14:19:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIGy3su8nhiXtUp9+d/vniNJUz//ep0Ds3DBxbOR05tY5KbK+go9oFicW6RBr1Srhr6Gpw8fCvHnRd/NOYvMsIIseT7FeAlBjmyEq/uot+n+jOGjb9ZQq8Rer9CTQUZXu9POZbBQWTd2rX6ZrUjsxg962iEy40jJ9WNruDJNonnMktFHWrfLX2FsG+zTGRX4eXM1okAj0JFgwZuDkhrBm7o6wYg4lTJhJWo/yOGsk0osg4cTLRkc5x3CwIIsrhwCoTrcMOVgRWlmoo2dNHXanS/dYkQeetj9btxBOiR70nTrNam/8U7JRRtIhre4QQdTWR/GV3XXQxR3ZxmNqp0tvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKFD4o+2u0nThmwQoQdPy3RfZPo9MlOrAj+NTh2NgxI=;
 b=O+Kg+ALsyx/4u0oK4rkMYP4oQRU35RfNhvuSh/plvI+Cwk2ubarH7mIll1HMFE1IRIsz9Iaa/4tZJW/JKeYtZgrEPf6+mpENo9Dh3Dp/kdtOwTYTvWacfjU3vyqGGv5aa0s9xpnAZ3M/yc2AS6GAFjyaQf4Imgw/J75Dq4LnvK9mVXLAfz0Joermk7OZKERs3oBBFbRN0uFgFA8jM6w+1Wz0TaGqfa3f4Kru0w8Ic/v6B59q1oJqVjTprTaLD7w6zXboYADXSQ4d+5yFrEVuAjbX20n+TcDFYJ1mbJNv7PVxKeBYHhpwJFjT7XWbGYyXCfMsl6JeemJWMVqrHpljzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH7PR11MB8122.namprd11.prod.outlook.com (2603:10b6:510:235::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 21:19:29 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%6]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 21:19:29 +0000
Message-ID: <cf1e2b8e-2cb1-4477-8bf4-f8e0ff55b79f@intel.com>
Date: Fri, 21 Mar 2025 14:19:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] x86/microcode/intel: Implement staging handler
To: Dave Hansen <dave.hansen@intel.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <colinmitchell@google.com>
References: <20250320234104.8288-1-chang.seok.bae@intel.com>
 <20250320234104.8288-5-chang.seok.bae@intel.com>
 <b01224ee-c935-4b08-a76f-5dc49341182d@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <b01224ee-c935-4b08-a76f-5dc49341182d@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::47) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH7PR11MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 0acb382e-6e40-4e0f-6af6-08dd68be1100
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFQrQTd4QWNWYTlKR0VUeFNPanFhbTJ3TDY5T0tVRGtlblpsdUFpS3p6T2Nv?=
 =?utf-8?B?MUV6NGRDZlp5dThRZzFaSHFqeXFaRWRlUFV4YSs4WC9GTS9MSTAzd1pxaGV4?=
 =?utf-8?B?aklaajk5M1A4bEJEUUMraUc3L3JJZlJHbmNTZnJpY1JUOXZsSnNpZFJzYWkr?=
 =?utf-8?B?enhLbWdaaFdqdFVZWWJ1S2xZRWpmdThzNHZReGplT1JSSm5aSGc2Tkh2SGt5?=
 =?utf-8?B?L21pVWhOVjM5M09mczQzdW9nM0xnM1JQOUhSYktwNUdreXBUY05OeXR0eHFo?=
 =?utf-8?B?NGFYeldxdlRpMmZRZ05NZzNNcE9FWGY1VkU4RDVhSEJaTE9RVURvTit5SWJw?=
 =?utf-8?B?eCsvZTl0ZXRhSS9WckFuSjV4QXFlcDlzZDlEUDAyOVpSSTRLdFEvWHVaVVd3?=
 =?utf-8?B?eFRkeXNITEhGemtXc2V3VmI0UURaRkszU21VaUdjKzgweUtYdDdYR0liaDMr?=
 =?utf-8?B?OU9YSENRNS8zeHRSMGdzVnl6eFNJZG9wNFlySDQ1NTdzQjJvNjRQZGVZcERM?=
 =?utf-8?B?VFFnTE5BMThZTi9ucldERHZTTUp2T3lETVV3UHlhaXVNeFRqamErYlRncGhp?=
 =?utf-8?B?eWl2Ukl5MzdyL29NVnFaamFpbGdWTUhVNnNGQXZqUTQ3QWZNTjhDWUZFZnJG?=
 =?utf-8?B?eGwrL2JMd0gzeDZXOVZiMzhQVno5bEFLVWlJTnpzMEJjWDI1cXR5T0dqRk82?=
 =?utf-8?B?RVBWYTdPMUZiNGxJOHNJajZKTzY1d3M5cWRQa2hFcWJIek5sbGhTQmRkcXFk?=
 =?utf-8?B?bHhtS05aUmlqcTZ2Y0JLZHFXUWxtUWVYN2U3cVBjZ3ZYcnNFSGgyZ3RFRUZD?=
 =?utf-8?B?blJDaTh2cmJrQlp6Mk45STJ6QTBPTExJNkpNL3dMT3JmZXF5NWlEY1IrSkQz?=
 =?utf-8?B?b29vcXhWSlRHU2tCRGNLS2pheVppcXEvZFJDaVdrZjlFQW1HU090UlBEbkpj?=
 =?utf-8?B?WWxkcWFIQzJXNEVLdURqWmprUnYwSTU2YkZOb1g0WHJEZklIU0N1bndXK25j?=
 =?utf-8?B?QUpVcFZwU2lySU1IRndnalhGeW1HMTJ3UlJ6V0E3Y0tLUU51Skdhd2lWUzNX?=
 =?utf-8?B?Y1NzbUVPVGpXY1FwSVo1aU5CVmpIMFBaMG1haUEydlAwT2JEMXozcTFJVjJw?=
 =?utf-8?B?aVgreXZTeXZIU2lJTlBVc1M4Z2llYlV4Ukl6bXU1TDlFZ2xmY3padVNVaVYx?=
 =?utf-8?B?SzFiNEtja3kvVzlOU1d4bHVIK3BwQlBiaDY0S1I5b3Q2QnlVU3VERlB6Ym5J?=
 =?utf-8?B?dThJYjZVYUt6NUZtcXErYm5wU2wvaTEvK2hydkF5NTgrTlZvOGl2YXR4eGZt?=
 =?utf-8?B?RG9DNFhWdkJKc0xUbUtja0lPckN2RWdCcjJNNVc2a3k3aW5vRWJEWi9HWkNV?=
 =?utf-8?B?OTlmTW95WG1qbVJjYWRmeFRveGpkbXZsVG9ONlZLKzBOY1dqTlRPbFBNb2R5?=
 =?utf-8?B?TGEvZmp5UGZQUWZkSjlmYWdTOHZ4RkQ3M2JNdlB4YUQ5eGlIcWdJTVJ2NEta?=
 =?utf-8?B?Z3R6eFFRanhNRGIyOWE3bG1rYXVRazJ3clBUUXVZQnlvT0ZzQmlJRDQwdGFT?=
 =?utf-8?B?M0tZdEdQVlB5V29QL2xOQWRHUWQwZi8vdkFSWkJjVEZVNm1WSlFkKzgxTGVH?=
 =?utf-8?B?T2FRQ1hMRXpPdU9pOUpyWWl0U1JmaUk0czhESTkwcVpuMGp6WkEvRzhtWFBY?=
 =?utf-8?B?bEJ3NlBSSS9Pd1U4bC8zY2ZBaFRxQ1hDMXVHM2txNEpBWWNwT2x2ZjlmOEJ3?=
 =?utf-8?B?cWdrS3BtSjZDR2lyUzFvRS83eFVOVStVK1V1TDQzVEZTWVcwc0djVjhvWWdE?=
 =?utf-8?B?VU95TlFmQVZlOVZmRzd2REVLdnhMZjg3eFJ4azF3ejNSM2NVbjlpUUp0aHFq?=
 =?utf-8?Q?VmZEDC0PQ8laJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0tuZWRHMFBocEptanN3RDZtWDU4dTUvaXBCSERSSWpaTWxoMU1qWlBWR0JF?=
 =?utf-8?B?VktvQTVZZ0JFZU9UWkZLeWN1WTFscnhycTdsTUN6ZEkrVTdYMHdLN0Y0WGRt?=
 =?utf-8?B?SEJRTVNYR1pNRWRmc1RFOGpXUFNOVllFbzA5T0txUmIvSVZwRy9CY3NJK2lF?=
 =?utf-8?B?a245cWFQM1VVWjlqNXdJWnJIbk9YSUZ6SFZNQ1RNYjgyYmhwbHRVSGFkcFdV?=
 =?utf-8?B?cTI4S25US3VrVjdzZWFhZVBrWmFMT1RxS2lxY21DNmZDWXIzbXlxVVZ5ZWlU?=
 =?utf-8?B?Nmxkd09IU2x0NlRON3BTeE1hNDQ5RlUraENCKzhla2dvZ1ppc2FZNC80NUFw?=
 =?utf-8?B?Z2c5YmJ1ZHZVdzYzVUtCZHVwVFU1SXlZd1NGakpkRzJwOEQ1d1E0MHA0UWxw?=
 =?utf-8?B?Wm1GbUl1c2EwZUFsMllvTEFBRFdYbi8xSTVhMTEzZUFzVlZ1ZjJqL1hiNGJh?=
 =?utf-8?B?bkZmc3dvc2dFVC9zQXRJOFRuMEZCRzBIRGZRRGtucjlFUlVOazBDU0dvWHhx?=
 =?utf-8?B?UmtLY0QzTnBwKzJWQXlJUDBreUdDM0gwdC9JNzEyaHhSU1FxQjZVM25sem5i?=
 =?utf-8?B?b0l6cjhybVhQQ1V3b2Fqdm5jNjlCZlBEdVpGTFljNm5OVWhiSFJJQnhrYnNU?=
 =?utf-8?B?eW1ydFhQc3dsdGdkbml2a2p0dkJkV25KbFl4bGJIMXlVZkRlQW1Lb1pYRXNX?=
 =?utf-8?B?ZVA5akZ3VVVkeXM0UTRPUEduRzByUTUzaE00MEdkS1VsWWp4ZVFXZlVjd2RP?=
 =?utf-8?B?bG1RRUdxLzBKYjhPZ3M2UE1sSVBIUHBoQTR3cmxyaU9VcC83WUNxT05XVmF0?=
 =?utf-8?B?ZEIxU1V2ckloUmFHRkV2RDBFL3NzVGpzajE0OUYvbmM3N0c5cjZOa0p3aVFO?=
 =?utf-8?B?WkpOUW95clpHckdoZjZjaWE3WU8vbU1nR09CdG11OTZMTHd1MmxoRkF1TTlM?=
 =?utf-8?B?UDlrc2ZmYTMvQkhhZW4xd0IzcVZJWHloYlNhMW56Vy8wb0RyQm5qSG5zdFJD?=
 =?utf-8?B?bjNWUEZWTDNYbDdnVmtOMnFQTytKcmxGdFFuSXhXdWNnYjhvZThMbEJTZFlE?=
 =?utf-8?B?c05BeTZYNXVZRUZUejFnYWZvbVRiUVVZcVJYMDUxRDFoZ3d1YWUvL0dmd1dq?=
 =?utf-8?B?b2M4eS9YTitvdzVPNDFJQmprMW9JaVoyVUo0VzNmSG1YUDBadjBMb1JFaEFm?=
 =?utf-8?B?MWJ5ZGs5aVQ4OFlQTklQM0lJSHFoWFFrOVlHVnZXYVVJbnNuanoxOVhBNXZN?=
 =?utf-8?B?azIwdDRiVmdwSFp3Um5PNmxSc0N6R2JRcVV5SG9iRlBhMzlMNExERExSVkds?=
 =?utf-8?B?cUc0ZVdzemZjSzkzUG5DY2M4N3dkMkJ0SSs0MWxOa2NSMWZzaXBaZmhQampx?=
 =?utf-8?B?SXVFazRaa0tFd0Q1NGViTkdtd3JJTGJINUxZRldobjBxYzFwVkpvbEp4TjBL?=
 =?utf-8?B?cjIzU2VpaEFtazhLcXY0K3M4Uy9MQzFabDI3S0M3N0ZkZHVGY1p2UDlzVUla?=
 =?utf-8?B?RkxEWjh4SU1jdUY2a3pkdkhnVUh1eTNCRjdFM2g1ZzZJOUtsdWJadVZVdFR0?=
 =?utf-8?B?SVdrL0F3OXdzOW1sWm84NWpqbWpWdjBlQURPYlB2NEQ0ZkNvZ3U1NW02Q2JX?=
 =?utf-8?B?ZUdObzFyaGs3d2tIdTYwOWJJTmRRWWdhTW9XVEhwSXFqN2hLeU5UQ05pVGxJ?=
 =?utf-8?B?dU5sanZ2Q2s0REx2THV2aXJQbUM4L01KeTcwWDhBZEsvNXVuS1NZNW5xNStK?=
 =?utf-8?B?S25hdlV3WDJWWUZnaHRWU0xhL2dZbzc3UkYvZEtvbSsyV1JJZ3IySkRmTmIy?=
 =?utf-8?B?b2NkeGRVem92WE5NNzVJaVVGMDFYZVJybGd6L2JWVEx4elVXNVlKZkxuRC9a?=
 =?utf-8?B?UnpVZW5zU0hLUEtXVVFYVDhIeVRkZEZJT1E0QU5nU1lwdGlvL0FrVERpYW53?=
 =?utf-8?B?NCtIU2hzcW9GSE5jUE5Ub2NCMEhvQ1VuaGRnRi9QUVFsdUNEWHFEczA0WUFm?=
 =?utf-8?B?cG9vL1VlN0J0L1FwZDE4UWExRWxPUkdkYlhGamxqRGdsMnVDcVRndXJRbVRJ?=
 =?utf-8?B?NUR5SFVIbVlpTW5vclNjNFFaN0xRWkdoR2xJNFV1aGFqblRwQkhvV2xOOVNz?=
 =?utf-8?B?QkpCNnhQbUR0NTBGM25sdllpV0V0VmEva2JiOEZ6VlE4WTZtVzd1QjNVMVpK?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0acb382e-6e40-4e0f-6af6-08dd68be1100
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 21:19:29.8199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hs+1yTUa1VV1STW55jAEsYMjq1OUlIASP0YnWGXoBPVsXpE3PAy/1Twig0Bn69j8pEkhh0NNosmfRSUHTIgc5poFtXkz1Z1UDsHE/1IzwO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8122
X-OriginatorOrg: intel.com

On 3/20/2025 5:15 PM, Dave Hansen wrote:
> 
> Yeah, it means passing around _one_ function argument to a function
> that's not currently taking an argument. But it makes it a heck of a lot
> more clear what is going on. It also makes the lifetime and
> initialization state of 'staging' *MUCH* more obvious.

I see -- that seemed like a case of over-simplification.

I've updated the relevant patches after passing the staging test. I've 
also thought reordering patches (patch2 <-> patch3), perhaps when 
posting v3.

Thanks,
Chang

