Return-Path: <linux-kernel+bounces-328867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCB8978A24
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D184E1F23457
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29E014B97E;
	Fri, 13 Sep 2024 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diPNKoqG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B8512C470;
	Fri, 13 Sep 2024 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726260266; cv=fail; b=is7YE2xYgJIpUyCWHK/fjtHr4HxmCbeNo0nKp6KyENIvgkEMwnEIqFlYIPCJLoZVowLsBzZ0cVOSz6WFIqpihPTUAJ1TwIZDiAH7ejVemNlQTdWal7wB/eveEhXZ2VdkiDh2+kERdqMh9/6xvJ8ifXdD7Dlrb+8bWNh14twvIVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726260266; c=relaxed/simple;
	bh=Y/mPrN8QjONFEjGF59sUGAmyG7TKFQtOCIq3I/0Be+4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ifcdP1zBAvjJNaxUOjcPXLUBDy0fcKWqyCDoDZnRQbTDT/SFVZubMJxup4GhqBk+ib+snzI8N9ZReY2vzV1NprDqNFvMxowhu5aQux6Ney7M8Tbc4uMo/HF62dX3s/JpjVqeXmoLlKDbUymFc+A9iJayvlbm0H78b82iVQnnbjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diPNKoqG; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726260265; x=1757796265;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y/mPrN8QjONFEjGF59sUGAmyG7TKFQtOCIq3I/0Be+4=;
  b=diPNKoqG9J5N5AsqLgLImc95VkPQGE1xvBPTnEW+mQuEkVH/SFjHMj18
   SIt7jz7HM1+WHgZgGvmbbJXe/eNjlbls42We6kmk9WHXqwPxw/1BlkdJq
   XbvLefZppmitP3PRJwQX37dU4eCwugcSKgAGVY+OopQN4p/CRMCGgX5wK
   h1+imSeJBrL3yyfq46dF/2l3k9x5pL6iTK9qlx7Ll/S3/f/4hqFmtygQW
   QeDiGvMspm64/52CIRfyvlOdZ6cnX0WQoEdlMjFh82lpsiuKTc+n4TKp+
   8DIFIVM2bV1DoPwvBaiey8751LVifN85WEGd03vFP90MswL7iOi9/ymEm
   A==;
X-CSE-ConnectionGUID: Se/+eswbSOmKW91MgZoc5Q==
X-CSE-MsgGUID: D2x+NM61SLCTGBRGeRKULg==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="28921490"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="28921490"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 13:44:24 -0700
X-CSE-ConnectionGUID: uHQ5DTp1RfO4t9tSLgVzZg==
X-CSE-MsgGUID: KUBn9xSTShKpEMKDdJiPFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="68052252"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 13:44:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 13:44:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 13:44:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 13:44:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 13:44:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMpDmA/W1/EELHCloOCm/+tJe1amM6ol4GWaWzP0sfyVmAIvNxl/9vd52sKAS7K/FdLjW1Th7RjODXWYtZZv7+/vFenA+DH8iajkIwNqP/8nChgS1wFTFkVAtPd4kbpzyTNN2WDNaqhzUUuooJlr1iT4+WDlvMKSEleNdW+p6J2+v55PSAOw/qKe+M5s2YUVZwHDGyT2/fAj1pe8Zry+kkhf3hewp8o4o7Nxooj8Iji2wTkJeU9vRcV5lNTxRBF2kbw/N3FocVXLia3oAoBaJRUXFbL4e1HjBM8O4nHRbqJC5/mpjvV2kY4gVKssrJOZpsG2ZN4qzXKGACK04bvyCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX7sutQkrkOjj1/bEsWT+RHrhlt80gtdgGPkzdqXWrg=;
 b=C6gSwtSi++1O+dCSPsklufMO4W40Sww1xccp632M4F4RRP43NBDF0j0LS1iwbuulb9Jxlqpy7c/6RS02YWwomvefdqvH/6x7tjMagfh9KOseeBHslE+kDmhsY6Sjm/PnObovdd4lguqbCa9zpkJE2g+VoJPsbIZ4xQzsfMx2NOOE0QpXCJLVLzkO0F6WEMBYHCJfESPRuhtxP71gwVPNpT/Cqv2K3vjopuDPcYjxWlODE+T7tZ51a+A6B5HVa/X5k8xkFdWtsW+Uq+QHSIDpKAvF2sc2Deu6Q6SRBFG3YDm8SG+xlyF+pkg3/iV6Ez2X5JaCF6FGvD/67kgX4Qzg6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7293.namprd11.prod.outlook.com (2603:10b6:208:42a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 20:44:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7939.022; Fri, 13 Sep 2024
 20:44:19 +0000
Message-ID: <902dbdb5-25c8-4330-a983-f76ae98f7493@intel.com>
Date: Fri, 13 Sep 2024 13:44:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] x86/resctrl : Support L3 Smart Data Cache Injection
 Allocation Enforcement (SDCIAE)
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <fenghua.yu@intel.com>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<thuth@redhat.com>, <xiongwei.song@windriver.com>, <ardb@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <peterz@infradead.org>,
	<kan.liang@linux.intel.com>, <pbonzini@redhat.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <alexandre.chartre@oracle.com>, <perry.yuan@amd.com>,
	<tan.shaopeng@fujitsu.com>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<eranian@google.com>
References: <cover.1723824984.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1723824984.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0313.namprd03.prod.outlook.com
 (2603:10b6:303:dd::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a563c4-fd94-4101-5e71-08dcd434d6dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWlZbGxveVFFVGxzQWVyZTFpSGRBYWVXQjlOYmpEOVl3UGUwUGJpY25Gd1Rh?=
 =?utf-8?B?RXVWd3E3dTJvS0RnK3RpbzM0bTlYTFVNTVhVSmhUNTg2T3dhOUFoNm9rNU1u?=
 =?utf-8?B?RFJ6MTBuTjhOZFBjOStlYlVscVZsQS9wOW5ZT0tvQnNhZEdPN0FnQWN2cDlK?=
 =?utf-8?B?cXBsSDFiek01SGIxMWhpYkFQSkd5M1VYN1BEa2kyZlF3R3hxUk9FN3d3SnBD?=
 =?utf-8?B?eU5ldDduUUkrQ3VGUllyS1Q1NnZhbmpTSWsrekVGMS91UHlnMytOK0F0TDZY?=
 =?utf-8?B?b21NZ1BSVk5WRFk1YlNEaGJueXJmcUpVaVRKM2p2cU1URkJQYWdVTGlMMHl1?=
 =?utf-8?B?eVlJcFplOXZFZnp6L1BtZ3hQV2puL3VyQjB6ZnlzR2lVTWlZLzJMbHBhdTFu?=
 =?utf-8?B?YkR4WTlLeFA5OUdSK0xQa3VLczZYb1N4VTdTL1YzbDhpRDd3U1NMZDFBWk1H?=
 =?utf-8?B?UU9ab3dJaFhyM2svZVMvQTBXSk5ZcjlsK2NpbGpRSHpnbzZReEhBYUY3M2Mv?=
 =?utf-8?B?LzNSNGlWUHhhY2ZQeS9hd2dlRzRURVVTV2c2dEtlYm9oVkJJWkdXQW82b3hL?=
 =?utf-8?B?WFNqK0I2a28wTVJxSlZEbXkvSzNScjFHRUtOV0ZaWmszc0QvUk00NnZENzNy?=
 =?utf-8?B?SDlMOGIxcGhTY0dmOEt2Y3RlUHp0ajFJYTJveWxUOVk2Skt4akR5R1ROV0Fs?=
 =?utf-8?B?eFJ3MGdNMzBJVnJWWUcrSjBmSGZCT3Z3L0lqb0xrdFA4ZU9HZDVKNUdIclpa?=
 =?utf-8?B?V2tXSVN4L0JYOHdpZVN2Q2lzWld6UWx6c3FHWldGV0ZNT1NpV29iN0JwWWNN?=
 =?utf-8?B?dHFDZ25BcVprVGhQT3BOakZoOFM2Sk5DQ2drQ0FmQVBodG1ueDk4ZnhEbGtv?=
 =?utf-8?B?MG5rUjFZT2g2U0xsdTVPMzAwYUNUVC9ubmdSK09ZSERCOGV4Y0FpY1Fkd0Q4?=
 =?utf-8?B?bEFLWFdHb29RU1BwRGN1V3RJbjZ6TlVuZHkwMWZRTGIvK3czWW1MS1JXbTc5?=
 =?utf-8?B?S2hoN1ByalZ6NUtucnVwdTBMck1pV3ZYbHZ1dkZuMWYxbzNhakZkVEdvWTdm?=
 =?utf-8?B?VERYdjVyNWdoY2Q1dS9PTzVIdUQ2bHdlNEpHMlF0cGlpM2RwVlBLanRiRzZI?=
 =?utf-8?B?Ty82clRINkJsTU9PdXBSakFpdkkrVUN1cjVEaEJiSmt4RnBSWGdsb1RQMEF5?=
 =?utf-8?B?dnVQZGE1d2Y1TTk5VFV4cldWTmhmZ1hCMXNkM2Y3c2ZUQ3Q3c0dyaFNUSUh0?=
 =?utf-8?B?V0dtV3g0MkJ6dkdtTEdnWXBydE9jMzhlQUpVYTM0Q2FEdVdQWWdrT3pZWEdw?=
 =?utf-8?B?SEhBc1I0eXJCY3g0c3hxMHh5OWxJcXA5VmtOVUZTdjlnVWRPRFF4VVRmS3M1?=
 =?utf-8?B?RzNKZnd1SzFQMkViL2pOUmNRbVQ3OG84TTh4OTQwWEZXNHgwV0Q3RU1pOFlO?=
 =?utf-8?B?RkNwaVlIVU5MK0FqZC8zaU4rb09OMkVDRW1uSHNoZUVDTVVPbllrby9KYktJ?=
 =?utf-8?B?WGNsTVltVFNqZ1k1dUhYOExSbEx2ZmJSbjQrVmxncjJIQ3p2UkVQTFRweVk5?=
 =?utf-8?B?OTF1VkZVMjVsWlZVWDNrS1kvZ3p4NTIzTUg5dXdkNVNteXdtNVFYWVhTWE8y?=
 =?utf-8?B?dkdRUHVuNnBvZC9YbllIdDNOSXNUWnRSekMwVjBVQWlHREk1SXhsV2tyL1dq?=
 =?utf-8?B?U01WQ1BpYWZNOVNqZDlrSWZQZjFuam9peFhSNkJvWFo1TE1oazgzVWVpenNJ?=
 =?utf-8?B?eWgrK3gyNVBENGJQVWZFQ1p6QUxETVd3NVlPd3JxRzhJdko2ZkV4a2k3dmN1?=
 =?utf-8?Q?92BZMfRxleZqO7mWm5nGjp/PKOIFxCiZJVTfQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFQxbVdBNUg0Z1ZEOThOcUxkZXgvZmJyS2ZtMm00OTIxRjNvaklmQVZMTVgz?=
 =?utf-8?B?K1dJc2oxUXZkSHBrMTB6WmVOZktKdkU2VTNrcVlsWnBwT0FrNTY5VXMxUzVI?=
 =?utf-8?B?RDdqRHJOa0xickVvSWIzdTQweDJkdHJDaGFZTmY3SzAxQlhSNWhWczdFZmxw?=
 =?utf-8?B?Vmx0eWhKc3cxTUFwcXQrUUl5Ty9hVTlqN29NUVFqTlJTWEVoek4weWRsejYw?=
 =?utf-8?B?eUdjQW1Ucnh4YTdFQVVaVTcvWDVhUlFRdncvbTU3QUwxUWlPTlpoNmh5S2pD?=
 =?utf-8?B?SVRqQUdxb3FSUWVTTnJGYk5hdjdGZWNkN2JqVnJaMUVYbVRXa296WVoxeVl3?=
 =?utf-8?B?eU9sWnVPV1I1ZStiY05KbjYxdFFNNk1iSG1WcnJpdnByQjF6MWxaZzU5REN0?=
 =?utf-8?B?d2N4ZEdqa0UySGVjbmZuMGJTK3lHbXRwTXFJanFleUhBdjJwYjBhaUpoNnZr?=
 =?utf-8?B?QjdCT3ZhNGlCd2pmWFhUdWJCYTR2ZFpvcWxSNUcveEZxdForU3hqcWJHME1a?=
 =?utf-8?B?b0hPZi9EcXdiSVBnYlJ0bFhIdDJocThZNGZTREZsUWpWNW5XM2I5b0QzMjV1?=
 =?utf-8?B?MytCNUVxUjVDTG5VdVBQT3B1bXJpNk1iZ1BPaDU1eEJOZ0Jrb21aT1hWTFpv?=
 =?utf-8?B?TDFkNzlwbXlZTGhSNEE4YzBCVkNnL09MY0pNbllPNXRmK0FQbWlEakgxZ2k5?=
 =?utf-8?B?SEhrSGFxUFZsb0htVVVkcHFocmQrdERhL1pSZTJDUlFqUXM3Q3paUlplYUtm?=
 =?utf-8?B?T1BTV29xNmxWZ1hOaG1kUzdxZkVjRFB3UEc2NUs5S2xySlVwbVBSTisranc5?=
 =?utf-8?B?T3daNUJmWVFjM1dkaWlFWHVsVTIyeisyWjdqd3VIVWZBVEN2czh1WFVkUDlj?=
 =?utf-8?B?TDg1NjRKSERBSjNwUk44T3orcTZHSlFzZzFjckI4ZkdQLzlvVHlBZDBhbDI4?=
 =?utf-8?B?NEd6MHdERnJWTFZhSEZ3Nyt5b0NpWm0xNEVoUjNDRUtiQ3NSNUcwMkRtT052?=
 =?utf-8?B?VW1ZR0lON0w4L3BzSWtpbGw2MzMwb2RsaTVPNU1Yd2htUFpYK0tueXN5dGlh?=
 =?utf-8?B?S0xobzNIWjFGb284eTRXRHlCY1FBTWRUOFRHNG0raGFzL0c3c2tWbmZhSk1F?=
 =?utf-8?B?WXgvZHhNbGRMUVlISUozMlBwbllQcFh0a3o4bkFrclVnVWlBU3dXQmpvK1N5?=
 =?utf-8?B?MHhYanljRkFERS85eHVQMnhnR3lqS0VpSkNDQjBNenUxaUp6WmJCbTR2MU54?=
 =?utf-8?B?SkFWTVlIOEsxd1g0SlAyTmpmcXFkT2RTVm92akRyRlljSVUxTy9yYVJlOGVz?=
 =?utf-8?B?QjlQTkQ3N3FjQXB3Wml4R1hsblY0c3R5TmNwcDZPQlRDaDFPZjdxTU1WYkps?=
 =?utf-8?B?OEpVTXVGank2L0JZVnpwOC95VzNnemQ2allxNmxzdmxtSE1XYkdLTjAvNmhk?=
 =?utf-8?B?Q0dtRzZ1NE9ZUzdvMzU2b3ZGblhaa1RhajFDUTFTRzBFZFhRazVmenZTMmk0?=
 =?utf-8?B?RCtQZE1CbjZrVXF1MzY3bTVxRzc3aTU0TWoranRwZ2h1VDQzTURXMS9RY3o2?=
 =?utf-8?B?cTZUcU9wbVNTWFVwQ1FtOG55WGRTZWpGZjd3c1NFZkJzam1EazNmd3UyQUlp?=
 =?utf-8?B?R2JjbDFUZTNOcHBvMkhmdGpNdDFuNkwyejNSYVd5cjRmb2t0aW5uRHA3SU5B?=
 =?utf-8?B?Y2JqZGt1WFdqT1V2c2ptL2htNzJsWmdEby9maUpyalFLalE1QUF2QUhYQjNB?=
 =?utf-8?B?dklVcEI3c2c2TVFTTGRNT3VzSWQ2M0Q0UFhwajhSd1N6bmZwTFZKb3ZRZGI3?=
 =?utf-8?B?SFVTaFYwdlJSZ295TXlyMTY5SzNhRC9ubGRwTWNIWW9mdzd5Y0JVMVlCNU5O?=
 =?utf-8?B?VzlaM1ZSL29XNVpWK2w3MXNIUXJrdm02OEhKcEplYW5xUEtjQlBBazA1VlBG?=
 =?utf-8?B?Q2QvQUxkTWhjbWJUV3I4TXFZWk1BS293VHlpdHFEeXNWb0RXZUZaUFJWdnFh?=
 =?utf-8?B?NHFQSGdyMUorK3BYYkI3Nyt2RG0wZmFIVXhBSVR2RUhPYkVyQnRmZk9ZNkxv?=
 =?utf-8?B?NWJzV1ZvYVpNaDFaR2EvajV0NHI2SGNYdm51S1dweTZ4Y3ZOQjJSNEZ4MnRk?=
 =?utf-8?B?WWpIOEtjUThILzRvUDA5YlRHcytySjR1WHpMK2k0UzhiMmc5d0RKOFNjL0h5?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a563c4-fd94-4101-5e71-08dcd434d6dc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 20:44:18.9576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJLtauIxY42Fd53W+K09DCPjnAffdQqMWvMVSdjerSSWvCv7ZvrJMoNLf2p1hLGoPmDCo1j8XKVqJTE4/z4h54x+bLCgxnxhgA/DfiN1RSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7293
X-OriginatorOrg: intel.com

Hi Babu,

On 8/16/24 9:16 AM, Babu Moger wrote:
> 
> This series adds the support for L3 Smart Data Cache Injection Allocation
> Enforcement (SDCIAE) to resctrl infrastructure.
> 
> Upcoming AMD hardware implements Smart Data Cache Injection (SDCI).
> Smart Data Cache Injection (SDCI) is a mechanism that enables direct
> insertion of data from I/O devices into the L3 cache. By directly caching
> data from I/O devices rather than first storing the I/O data in DRAM, SDCI
> reduces demands on DRAM bandwidth and reduces latency to the processor
> consuming the I/O data. The SDCIAE (SDCI Allocation Enforcement) PQE
> feature allows system software to limit the portion of the L3 cache used
> for SDCI.
> 

This series introduces new user interface. Could you please describe the
new user interface in the cover letter and how users are expected to interact
with this interface to be able to use this new feature? Please also describe
the impact on existing resctrl interfaces related to cache allocation from
I/O hardware, for example "shareable_bits", "bit_usage", etc. These existing
interfaces are used to communicate to user space how portions of cache are
used by I/O hardware but I cannot tell from this series how this work builds on
this.

How does this feature work with the existing "L3 Cache Allocation Sharing Mask"
that is enumerated as part of CAT feature?

> The feature details are documented in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
> Injection Allocation Enforcement (SDCIAE)
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> 
> The feature requires linux support of TPH (TLP Processing Hints).
> The support is ongoing and patches are currently under review.
> https://lore.kernel.org/lkml/20240717205511.2541693-2-wei.huang2@amd.com/

Please note that the cover letter [1] of that series mentions "Cache Injection
allows PCIe endpoints to inject I/O Coherent DMA writes directly into an L2 ..."
while this series implements and refers to L3 only.

> 
> The patches are based on top of commit
> ad1b4b6ed19f (tip/master) Merge branch into tip/master: 'x86/timers'
> 

Reinette

[1] https://lore.kernel.org/lkml/20240717205511.2541693-1-wei.huang2@amd.com/

