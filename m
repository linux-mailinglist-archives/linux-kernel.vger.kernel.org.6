Return-Path: <linux-kernel+bounces-522718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0B4A3CDBD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF11175C13
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00D525A340;
	Wed, 19 Feb 2025 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CygXiTGe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5657913DBB1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740008676; cv=fail; b=d3smu55yRWfnhoOlu4/yzDcaIPNnJ4+reLt1KNuwAaOqwj8ojFmFwC6CkH3GfE+gPDvbcfBywZATZNKu7cvypfrvGgfH2WqTB5IbLHafhJeqiwn1n6OEXmwhYNoQhqPj/O3V4wFYS3NVX/FTIj8HiYK6+68Wr5Wpk1ZsNbuJ6ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740008676; c=relaxed/simple;
	bh=NePuLIUF7MZZC7pyBjXtv98G2pbSx1A9ABf8I6tS3C8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hX/cRFhpKFH2zt+UjPBezyvPD5pNzBula7m1H+/Et8JDbUFAhcDVIWE+jUjD0UihPFbfPTgwMcIcauqhvRVgcc4DEwL1gxodsop+6TWCZ4JFQdDN/IhlosoDq6MqDk1te/eAQvNdLkpEdkE5QKvCzB9XiMwgtP2VEcCX2dXC1sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CygXiTGe; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740008674; x=1771544674;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NePuLIUF7MZZC7pyBjXtv98G2pbSx1A9ABf8I6tS3C8=;
  b=CygXiTGe+vxrGLlAou3nHLQ+oIrK3pH6CyjbwGYb8/QPVKjfkXWs4h74
   bQy6SdcF8lrqFTraH/IjHj2Lm9teOz6W7AmjFZiG+o2II2rhxIZTbSDL7
   cQ8tztryRpPb6UzE9pEcxJn9TGpSb4CJQpqcz3124JsQr3a+EP0sz215n
   Fdg+3lYvVdTpS+Iat/E71jW1oZUAhskKpDvQGlTc7z33uZEGTiTW8HCq1
   TCyO2F3mRZ+LdvgcfaC2I6FVWV6TzumbzskKf+Y3hzfT9dIbDchaQqDGj
   /TL00qxQ4yJe6omYZbqHEs24OvQJSa0Z6+IGfTa2/1MQCZZaNpk8OPsqU
   g==;
X-CSE-ConnectionGUID: wX2RrxKERf6xJt6V270WJg==
X-CSE-MsgGUID: omAR+WaYRwqf4Fd/Ijq18A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52203061"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52203061"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:44:34 -0800
X-CSE-ConnectionGUID: aaMfA/MKRkSEVD3csxuEKg==
X-CSE-MsgGUID: 2Re6gch3SgGlzmu4dY3eng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="114598628"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:44:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 19 Feb 2025 15:44:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Feb 2025 15:44:32 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 15:44:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHI1Fi9KhSy2EHhT0QKHhu1dQT6WGaRRtEbF+Yl4U60HdjXFu/f1mEULYHrgF7sQRuvPKXVwHlgQDSqUErRWWzTQKLb4XVggsRDD5yU2U+42kFtISTgeSAaicZJ/i9sDK7wakVV8B92LlEh4SgXAlb5xSBMDOJOo8eTR1CMU41UTpmkqTkXAUk91gsAtT38sLeaIAv7FwrOvWkApiZHrSDJntehtL8qAX73ENGRTlAp2r8hZEtmjqepzjSt9i6YRYRGOPqynCGFVgd/4Evs0fOQuOYEIRuTwX49M4OoR2F3ifzPEIcNOAwMC3uYxE37J72JGvSE/a/micFy2YAthvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSlOa2uRrspfiSc5/io1iSKvoxeBma6wrDLaXLO4DXw=;
 b=Ozoer8ERngGMdt0BhSRUEcAjMARYWTM586DP++j/rc9fU4iyB6HiTSDJI1PwtJX7BBIEZu0rhv+HZqQZOoa9maE09tYsD/DKI2cwqv54kFuHdetFVnrwbZ/Qr/nawgbMtzR2sC8+MGAgtwIKqA5Q6KJ6kWpvDW+8x0NqFleyj15u89clY5t1+1hB47FOeRBLKD27jiG7AKKKuybJAtg7YDs1R0r2sYzHCoHV7IlvNHOarugP2hYvngnC3TspRnmRwxzDllSc+UDucgsvbtL2jZytVcIVA1dfLJh/gmZ/Kh2zeckftN+rp/M9kwW89a1r3Iot1DTfSY0NHjluB1XvZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6096.namprd11.prod.outlook.com (2603:10b6:8:af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.21; Wed, 19 Feb
 2025 23:43:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 23:43:56 +0000
Message-ID: <4d4d3aa7-ee28-46cb-b865-debcfd882d61@intel.com>
Date: Wed, 19 Feb 2025 15:43:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/42] x86/resctrl: Move monitor init work to a resctrl
 init call
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-17-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20250207181823.6378-17-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0196.namprd04.prod.outlook.com
 (2603:10b6:303:86::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b17629d-c80b-47fd-43b9-08dd513f465f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVFVOWh3di9FR21TemhSRURONS9mMkxWZkZIckVSdVllM1hhVDJmT3NMbTU2?=
 =?utf-8?B?bTUxVUlzazA5YmdLOFN3Y09kQ09zT1BGQVpWRFlhVW5sZWROZkVCUzg4bjlC?=
 =?utf-8?B?OENVR28rcWFMZ1h3WFphQVZucGFIZlZzUi94blh2V0FQdHhhcUZPOGd0Nnd3?=
 =?utf-8?B?TE5pcXdTZEYzTDh6WmhGbGM2dHI4SDQrL1h4VGYwM0RXalUvU2NJbVNoTXFh?=
 =?utf-8?B?cmZWZk43ZmFwUUFpb25mNlpTbFlwbGdXZmZmUkhEVElsWld5cnF6QzFYMGkv?=
 =?utf-8?B?RlFTRmQvdmhHZ2xWMkJjSFhVWU5MUGl6NC9XV0ZYWElOR3c2alVlQ1o0eW9G?=
 =?utf-8?B?NWpWR3hZMVY5dG41cjVGN2s4cmdNbXVGcHBQY3FkeGZQU2sxSElnMmpPVkpE?=
 =?utf-8?B?TG1aL013RHE5Ui9vb0lzREFvTEdWSDE3b1NwT0lrbzhSRC93Y08rU1ZlZ1dl?=
 =?utf-8?B?blp0UkNrck5HZWlSQm8zbmF6UElmUzFkamFEaHM0NjV3cURxb0NCejBQSGhB?=
 =?utf-8?B?QmJkbHBvSVVRSjUxSjVmcU1GUDY2d1lyS3dJNXJ1SU5pNk1RakdLNGdLS0pJ?=
 =?utf-8?B?bzAzTmVUTFZwMHhnVCsraW0wM3Vqdy8zV0Jua3N6NkhhN3R0eW8xa3kxVEdS?=
 =?utf-8?B?bTVrMXVDT3ovaElVSEdHazJ2bnpRaGZ0Sll6OCtvR0FKNmtzcUlOK3NUcEpl?=
 =?utf-8?B?N0hUOWsrOE45dGNqUVQ5MWdWaTNPN2F4bUZJZGpjbjJPSjhab2N2alZHelcx?=
 =?utf-8?B?TlhxK0xodmNZUlhVNHd4cVM4TFpTSURwNHRTTEYrZHh2cFk5UVpYUTJHWUhK?=
 =?utf-8?B?S2dSa2FtSU12YVpxV0pWTWRpNUlMNmRZWVl0QnU0ZXVLRUhKa2pnYkVIdEZP?=
 =?utf-8?B?T0N3YUZFZXZTeERIN2tmcGtQaDVpWUNhbzFHb012UngvYWY0Mzc4M1o5SXEw?=
 =?utf-8?B?Y0EwZ0N2dWZWSnZ6L2FXTEhMU2xMZWYvMWJGYWZvZ28vd2JNaDR2MTlONjdX?=
 =?utf-8?B?aVhnb0JTWVZWemtOZ3Aza3RDUzIvWVdCZmJBaTkxNDNadkZrTkI5aWRxMllN?=
 =?utf-8?B?Ynl6aEZBbHo2ZFRoVUVsRWQ3dmoxZVZHdWFobit3dDA3b2ltSEsxLzFwTEwx?=
 =?utf-8?B?eVhRQ28wK1YrVDlaeC9RQTVaMWQ4aDBJbGpqZzgya2N4eUlYSjJhRUg5YzJ1?=
 =?utf-8?B?Sm1PRllSb29Pb1Z2Z0FyTUtTa1dsYU1heFRjWEcvb25UR08zWDdocFBTVG9a?=
 =?utf-8?B?V0g4YWNONnl5UEN5SUN6VXNWR3I0UVVUcFI4UTNaQjBCZnR3MkFDOW9WVmlH?=
 =?utf-8?B?Zno2ZTRLV3I1QUg2VnhrcnlXbmNYdlc3UTRVa2JoU3pCemh1UTd4TlpOWlJL?=
 =?utf-8?B?N2xQVjNYY1gxRWNOYWVmTDNOYnFSSFUwNHJzSUtQU0d2akpQdEtsTjAvdFdq?=
 =?utf-8?B?NXNSOENxNHdIS0wzdXZlMFZMOHNXY3h6V1FrVTM0Nms4RUxnYnpLUEM5QnRh?=
 =?utf-8?B?WXhscGZ5R3g4V1Q0MmR3RmE0T2V6eUpMVElWM3lYbjVYYVF3N1dubzFCeUJw?=
 =?utf-8?B?NEdIM0U3dkFTM25ld1Z2bXc0SjNrUStMSk9sRHc3MUMvYVF3N0p4R1lEUE43?=
 =?utf-8?B?anM4eVdBNDVNLzBEckVXUGtFeFI0Y29zV3d4YS9qcmY2a3FabCtYVzFnL3F2?=
 =?utf-8?B?cHB5Y2RHYlRsdHNWSVVxWEVSR3ltY2F5VWswTnZYRWhjRjhub2dpK3JvSGR4?=
 =?utf-8?B?RjdZTk9iNGpWelFGUlRIY2pPakNuWFBVUDc0R2ExUGNjaUprY0xDRkROSit5?=
 =?utf-8?B?WUd2T0MvdGxTVlozeDZxRHYyNUI1NFhvUFlKbUlJbFJGR1JOY3d4WHBpRUUw?=
 =?utf-8?Q?mwqUI3Hn+h1fS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDJqb0JJK3NOejhZTnFNbFZHV2owMVZvdmtRZ0I2RmMvVitpZElneHBSWFFO?=
 =?utf-8?B?M0dzcWxXOVRzVVpGRDN4a2F4OEdMS2pQbUw2S244NUxrZEpteG8waWtQZVI5?=
 =?utf-8?B?dmlWUksxOWZYUCtrc1cwdXhTTFIrbTVlV1c1MjBjUHJRZ1REUW1JRE1ZZTRa?=
 =?utf-8?B?K1JtZk1XVTlURXY1VkpQOVJwWHdURm1zWnpHb0JYV1doNEJrQWt0eXRwYVNu?=
 =?utf-8?B?NHJmS3lQWVdGdFRJRjEwZDhtU2VMTjRNOFNaZFIxQmo2UGVFVVh4THB3dFJr?=
 =?utf-8?B?a3RwbGw1d3hSQWlhM1RGZ2JWZ1VaMlFBYWc4UENnWFEzb0ozQ1czYkpXZ0dS?=
 =?utf-8?B?M3E3Q2szc09XSW5CU04wZGdyMHF1K3dxaVBzbUZhTENsblYraVlETGFTSG5Y?=
 =?utf-8?B?a3AxcjNBc29yTEs2eWFjSjdOdU9EblBMOFhwYzQ5Tm5ScEV2TEthYjh2eHpF?=
 =?utf-8?B?d25jZXUrRHBiWEJmQ1U2SDdXOG56Z1U0bVNuVEIvME8xQ2tEc3IyalFGMytF?=
 =?utf-8?B?V0pwVnY0c2hHREJmMnZqZEtYV29NUmkvd1pjUnY1cFNHOHkxWDhtT3ZodnVW?=
 =?utf-8?B?VDNjNmlJcFUyMmxiSTF3cDE2Vm1mUStMMGdXbGhPcEgydFFsZllaR2wwamh4?=
 =?utf-8?B?MjVsSVJYSHlXem1UMHdOc2ZFSDJlcVkwTnVWdytqbnZkRlZWZzVZQ0RVQUNl?=
 =?utf-8?B?aDdtVHkzd3B4OVVUeG9ydFpXdklkSGFUYStXMysxUm80QkVRNTRmRW0zZ2Yw?=
 =?utf-8?B?VmVIb0VNdGsrMDdvOWRZUmlZU0k4ck40czNxcWdGT1FlQktIMHFreTd6Zkxa?=
 =?utf-8?B?S2FyL09Hd3RXOExRTHRXUTg1UEMydFZTZThjTDg5NTBEV1gyNzNjeGxTM2k1?=
 =?utf-8?B?cUVRc1pUV1dTL2NMT202SUdRMHkxVVpwQzZDcTFRZzVWTTR3OGE1ckVPT3ZH?=
 =?utf-8?B?NFQvWm54bkZjU1luWXBqRDhZSEM3ckZ5MjRxYWZDNFY1elVwQ1o3VUFYRnBa?=
 =?utf-8?B?L2xLdFk5eUFSbHVlaWRyQ3RrMzUwL1JaOCtzVDNHRE1uUFUxQkVpNW15ZVdV?=
 =?utf-8?B?MHA4L3VvelgzV0ljaHhvR2tmS1oyRzBTM3VNdlhuTHZNOGpXUEdwbW80TUJK?=
 =?utf-8?B?VFZrLzB0d2RvNzZhTitVckRJYWNwTVg1bDBVSWJVdlJSV2k3QkFUdk9aRmtt?=
 =?utf-8?B?VUZwMlJNeHJIM3ZrUzFhOEM1U0Q3aHo0NUpCRjJsTTBnNnVYY0FnQ1VsY29t?=
 =?utf-8?B?TFhIRDMxekJ5djlzOFFBVnEzUFRBNmJ5STFMOFJ2c3E4cU90ZytFMHAwUGxS?=
 =?utf-8?B?SnNFVUcwazNjU01OS1NmeEFVQ3p3TXJlZXNoeEMrZHlwUnExd3lDSHBNL3Jq?=
 =?utf-8?B?alBRcDl5OEFvdGN1VkFmTHNMa2MvNFFNRFlpNUxOSmtYTVg3aEY3UDhPK0ZQ?=
 =?utf-8?B?eGN4VDB1L2JKZFc2dXE5Nm1yN0pQTUdjNUhDUEpEZUZKOWdqSWpQR2NqbkQy?=
 =?utf-8?B?bFVRZmlmOTJRRnBQVDVxYi9FdGdYL3hJdzMzOE9NeDFvbGNFb3NkQTVBUnpm?=
 =?utf-8?B?cUZ3TWhNVVByNWVkdXhwL2ZNT1pEaHZlUXdRMlptRjJ2Si9XNGovdE51TXB1?=
 =?utf-8?B?RnIxeFRkUnlzMldiZDlLUGlrazFkMlhBbEo4VEJOTkpiZDcvbTc0VTVXY2tF?=
 =?utf-8?B?RFFjeFB4eTM2TWJFR3JscFN4aHBkY09RNjJMVHlzU3g2b1JSTGNKZi9VaWQy?=
 =?utf-8?B?THJVZFNYd2Q2aURZSXFJU0dWSmp1V3J1eDVSZklMVWkwV3lYR3JHOU16cjBo?=
 =?utf-8?B?cnkyV3ZTL1RWUnNoMUtFakFCTjIxbXV5SkFjcFNQNnpDeFFJRjFCUHp2WlBN?=
 =?utf-8?B?NlU2USswVEhPRndlQng5TEZHdGxneEsrTmlmYURiUXZDQnRQUDVDR0xacEYz?=
 =?utf-8?B?SXZaWm9BWG9YS1NsQ0pRbXlEL04rb0s3Mlp0RzdJMWp3ZzhQdkZRaUVRVi83?=
 =?utf-8?B?YmFYb3NKcXh4QjhuY0ZUU2xvd044d1BsUUU4djhTSGRZdFdReWVIdWszMGcr?=
 =?utf-8?B?MzJpc09jK0c0OHl3L3p3RGp6RzFjVWhRYUN2QkhHdnRRM25CM2FMWW54MVht?=
 =?utf-8?B?L0EzcGcyYWZEWXk3OWVNTmQyRVhrVnM4aWsyRUpSZEJ3K0pBV2d3a2NvMXhQ?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b17629d-c80b-47fd-43b9-08dd513f465f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 23:43:56.4368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYEQWgpR4kmgFdVZD9pXI5OBI1Hgw36++bMYUvaq18lp9PwKnXacdh+JizvLZzaszwtBhQk9sY2IXUkYPZQveTA4b7d2Dju5PwuwM479rSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6096
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:17 AM, James Morse wrote:
> rdt_get_mon_l3_config() is called from the architecture's
> resctrl_arch_late_init(), and initialises both architecture specific
> fields, such as hw_res->mon_scale and resctrl filesystem fields
> by calling dom_data_init().
> 
> To separate the filesystem and architecture parts of resctrl, this
> function needs splitting up.
> 
> Add resctrl_mon_resource_init() to do the filesystem specific work,
> and call it from resctrl_init(). This runs later, but is still before
> the filesystem is mounted and the rmid_ptrs[] array can be used.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


