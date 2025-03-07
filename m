Return-Path: <linux-kernel+bounces-550452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71800A55FC1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A0CE7A368C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010F613DDAE;
	Fri,  7 Mar 2025 05:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iA9htDDd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A088F664C6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 05:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741323846; cv=fail; b=g+mXbxzCGSPrOQ0z8V9e6owhJM5obPUybx/AB87vRLMLJ4xmrqcIHFRZ9H6YlQ0TG+nGheXUHBhfjDim+fVQuTMEbUbT0859cpPRK7jPB3SrXr1nHWZqSkyu2JqvRYoRJSvNL/ayWQ1cMU1On1UmgwoMQtMbrlzxHwT6Kpe5LCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741323846; c=relaxed/simple;
	bh=XFddWp2STuMYHUrH1cMH/oAHWrEggbB8HF+hsSiZzjg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YGDJ92z5o/PA9m5CJG9KZljwsDSAQN+XhEv85SabFh+MF8LddeI+/UNdQq8MKKNJqB+xW3yCHbi1Yvs7USw819t7gL/po3eD8nZmpxJj74GFhDZzbHSi+GhQtJBB4sNaz37knvCrR4lKON/TcJejiWThTUSjSqaYccglL2G2vL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iA9htDDd; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741323845; x=1772859845;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XFddWp2STuMYHUrH1cMH/oAHWrEggbB8HF+hsSiZzjg=;
  b=iA9htDDdca/AUAJr2CdQ6lKwLEbdouuzDo7cZsm46U62N3Z84gg5tvpi
   pcTK77C3LXnqvo7jHTUkeBI/6RY2H+mdsCG5ixXMcriEvZDD4nQfyN0So
   lFHOpiFOb9HcJ551nByDjEQHaV5JOqkN+Avhk/adw3iDtovr5px/UgEME
   PGbt+pZfmF/EQfNF39f6itIbq36Xp5cePOdgKXKpkThMb/377xhcWdV5T
   cE3eqCGXZJir4S14Oq3XwbayFrN37ElK7ROfW26ZKiUrIRYQr2mUZcGqt
   r8wQdRQda22N4twDeuG7iv6vi88jh83XkH3Tqk9aqzWVsabOfWLRssIdq
   Q==;
X-CSE-ConnectionGUID: qV15ZFmPS1S0cRF2XMUzLA==
X-CSE-MsgGUID: iy21GYPUSsKBsrnkrR5jUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="29944759"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="29944759"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 21:04:04 -0800
X-CSE-ConnectionGUID: qtmlJbKlT5CC9d8nwMws+g==
X-CSE-MsgGUID: /aO5FI9CSDOPrErgxVS1fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120141335"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 21:04:03 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 6 Mar 2025 21:04:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Mar 2025 21:04:03 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 21:04:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8wriLm2dTM1VPTyTdPU80jwoQNSUEOP5NfYGe3LKZ+FU51aMcZeDXvF39f6bVey7f3HXxAXizF4qwbeNBOYjYTi56+S0oZQyBJ2UTo3HZXIgRGyhVjs7s5aW22pzdUyPTNMn2RfMx8TRTIKUeMbigk4jF5qGWohZsMDYaD4zOSbmTRS4CI40vEZEoMTmB0v0pK+ysK6uCyaVBXaSPCIct9xW1WF3J7RwadArErXVrXPlb3ELJy3vsqsNqUxqlPjImTGfeHH9gfjlBbHGs++Ip6BEJS5LnFl4U8PQHRTDyKIQcghNP4KCTMDla81SLvA59eS+i+eXD6IMEer8zeNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBJiJKrcJo8UEbcsUJdmmGikD0cgUzy/kuKoRlo6jcc=;
 b=ldxZM3Iyc29/dKrbPVAnOFa1FqFJeoYV82KFU5rWp0Gk0gERCuJp0XhN+7jg5aDQnIHR/b5QDgCFG52QJD0R0GIApUorhPJphyT0LU3KbM5QxUBYaQcb1bi68ynZep6K0tLjbd+h5q/b/pSQOK1CwBQvYeS/PVq5tW32eECFACzroVF627gRdhnN5MqJRtfySuKVXN9qM6AUpnCyfkA2EFNAfcEOEi7ou1iNKngYYOX17N4TvMiUJicLAO6DZ9yZ3Rel4c2ty0BY5RLv+0vq8144pPPlZHAOxNMq/vLT3ZgnmqoMirkMHR+nYARM1bN0ivEc7TuOl/zmeRjqxCoIoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8381.namprd11.prod.outlook.com (2603:10b6:610:17b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 05:03:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 05:03:59 +0000
Message-ID: <e1816cbf-e2a7-44cf-92f9-bbd24d9e264b@intel.com>
Date: Thu, 6 Mar 2025 21:03:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 37/49] x86/resctrl: Expand the width of dom_id by
 replacing mon_data_bits
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
 Donthineni <sdonthineni@nvidia.com>, <fenghuay@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-38-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250228195913.24895-38-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8381:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0b2de2-5e4b-437f-e6c1-08dd5d35787c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnJoSGdnMXQ4Ymx5VFFpM1hMbVRLQ2Z5UWdqSHVQcnVHY25QeTRNQWRTcmFv?=
 =?utf-8?B?cVlWYlZRdzZSVThJZXQ3UHhXV0FHNWFhTjR6bjd5R2dRNnA4d2MyQW91U2NF?=
 =?utf-8?B?NkxHQWJDUHVUWmJtTmo1RElLREw3VmUxVkM4eCtUak4yZEp0YjlpWmRLOFI1?=
 =?utf-8?B?NElQVUExd1dxc2NQZVY5aElTYVlIdnpTTitSSk5LUFJKMzRFeURaeDU5TjdO?=
 =?utf-8?B?dlhFKyt2VW11Y3l3U01VSExkZURiVTZFTnNDbGlKNjN0cjNDQ2xMNlA0ZlhN?=
 =?utf-8?B?L0UxNVNQSXkzdXpuczZ6a292YU1oMUd1aGJReVJXTkRwaStlYzdTQkwxcXBt?=
 =?utf-8?B?UThBMHVqRC9Md3FKWElGMk5Hd3NnUVI0SDc4YUNXQUY3WTlYTmtMZlNxU3Iv?=
 =?utf-8?B?REtsWlR6WXdJaFh6RjJGTE1sK1gzclZZNU9xVnU0aUNrSlRnMC9LamRyVlFt?=
 =?utf-8?B?dW1GdzZ4cXZrRTFSRHg4OTJjb1BFMEp2UzBZUUU3UFg0ajRZdEdpUTMxZWk5?=
 =?utf-8?B?Q0FKZHhqMndvaHhyaExscFJvMHRRTlIrQ3dZZ1E4elJQL2kwRzlCVTRDeDFW?=
 =?utf-8?B?UEJCdURuNFJFa0FoUW9Hd1pWTVcrdGMzRCtnR3JVSy9YbXdpeTdpSitjYjRi?=
 =?utf-8?B?dG5ZeVk3enhxZmplZ0IzQ0h4TGk3MDY0OEkzMFVicisyUUZxTHVDN1hsQ1pp?=
 =?utf-8?B?MTg2S0pFT3IrcjNkOXdyMUV2a3k2Q0RqcC84WTZlN3RSQXVZTFNMaCtHNzRV?=
 =?utf-8?B?K0psVVM4L1hkakgvTksrTGprTmxIc3pBZzRGUGQ4T0Q3MGRuK0tHaXJLMGtO?=
 =?utf-8?B?NEFOMHpxZkdmYzZZaTNQdGFoeXM5VGo1OGF6T21IZDFqTzRCb05jUUxWdlRE?=
 =?utf-8?B?K1U4OHJVUEVMTXM4NS93UFN4dWsxQ2U1bXhBNSttVUQvMHdONFdKUE05SjMx?=
 =?utf-8?B?blhMNDV5aGIyajZWSE1nYlZsNzBOY0U0RHlpRHl4QzU2TlVaQ1Nsdy8wM2xx?=
 =?utf-8?B?R3FWeTRaMHJEcEYrdUVPeDkzRTkwYjRZUE16eVpiUjg3ZUMwRnFLQUlHWEpo?=
 =?utf-8?B?cmpicG10eHl5aGZWRWRFc1FMMHNVUWhvRGZaRWVoSzB1c1oyTkJZM2JETTlR?=
 =?utf-8?B?Q0NkQ1NTbkZLYTZoTTNFTEpxSlgzR1N0Zkg2NGRpb1FJRldqbVRhek5UZ0pm?=
 =?utf-8?B?ZGRUMk5tOGs3U1hCVmJ5bnQ5aWtVZkwyREdRNUpPTnBFWVp3Y0l0T2ZncjVy?=
 =?utf-8?B?NWJrZVZpaUpJbG1ndW1sTmRjMmYwYkRBOGhDcFE0ai9PemU0eEVBUDVJajhJ?=
 =?utf-8?B?QjZyWGpoaXUwS2JqS3g2aGtyNEdMTTlCQ1hDWWVocE1xb05NUG5idURlRUJa?=
 =?utf-8?B?NmZzZFBvaWtweEVKVFJkVVBjV2dNTVpSMVJNTjZLYzVLS3JzU09PZlJDNnNz?=
 =?utf-8?B?RkRWTmRtRVpRMWZic2JpV0pveTZNdTFQMFhoOTBHT2pPVm1kYW4zci93M1lO?=
 =?utf-8?B?UVVTQTcwN2ZmbjhLM0xwb2N3S21KakIrU1VWQ0xWajRXclNONGtIWWJsZGZV?=
 =?utf-8?B?YmE2VHV4RVVKanFXenRsZDQrMnFXSUdrTTNiU3lVek10czIwQVcrQ3laMis3?=
 =?utf-8?B?NU9WTGduV3R6RlFMSGpVb2U5aWVkZU9teUxFdzJFVWlXc3V0d01aUGRFQTFs?=
 =?utf-8?B?VVV5LzNkNUlOWmYvakF3Q25tdk9LWlFZczNFZTZ5emNmMWN3bmFFYnQzSitR?=
 =?utf-8?B?S0Y1dTk3eTVsQkRQWlBGbzM1M012OTV4cmt1UEtjRklia1hnSlBnVlprTGVW?=
 =?utf-8?B?OFJ1N25KU3BPUjYzQnRpbzhpRE12OUxLeWtzdjdJVzN4SyszT1BwVTEzNHBW?=
 =?utf-8?Q?jlw36Hs3I4tR3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUFuS24vU2NMVEFpUytjK3FBYTRrVmpRNjFSR0xQN0RHZGZGS3hZR3pEZjhB?=
 =?utf-8?B?TmpBNGFGL2NoRWFPb3ZWTnRDd001MGtiTVBYeXBMS3hKa0NNaTFGZGtsVnBV?=
 =?utf-8?B?L3RjOHNpK1hTSWY4VFpERDJBcVF0UHVQcE5CR3p1OHQzLzhLZysycFdoRzF1?=
 =?utf-8?B?RGQybGw5OWp2dVZ3dGhXVVZub3U0RzNRUVZlT0dmc0llb3FrTVp6cWVHMTVV?=
 =?utf-8?B?M0dwN3ZsWXJZMmE2MmpHakUvMUlySnRrMk92WWc2dDhKM21FbVY4djc1bDZv?=
 =?utf-8?B?Q0xXaVNTeEpxelFmYkkxbktqclJNMkVPQzF4UVh3Z3VJdVlZaldLWm5kQ2kx?=
 =?utf-8?B?WnRaNmFpRktBd0sxYS92WEExVDZ5K3F6ZWVVTkw5RkppallpbU9uUWdFYko1?=
 =?utf-8?B?ZlZySUVMU3JibWh4Z2pvS1RFN3hRc0FvRlRJWjNWTFZpK2xUU2RvNHdTU2FB?=
 =?utf-8?B?RU9Rak1MdUJwZ29NWVV2R3RUeTM5VXRRRjNnZmRlMFEvaWxKa0p6bkNXZXd5?=
 =?utf-8?B?a1J3SGJqNkJOdjBOQXZtQUJSdHRWb0xwM3VEditwbEhhUHZrWUdUOVhtV2pz?=
 =?utf-8?B?amp5QmlPVDZjNVB2OVljdG1hUTZYVzhPdENld0R4SmJVNVZNcUlqSFZrN1JM?=
 =?utf-8?B?bzFPRnVVdlpIM2NENFlUWlh5bXBGaFFLVWpzMVRYVTM0UXBJdGtsSmFpdjA0?=
 =?utf-8?B?dEJMQU4ydFZqbHlsaW5Oc3JZWW81RGppRm5vK2pOZi9acm1oWTdKeFRPVll0?=
 =?utf-8?B?aHRyUDF2ZFh4cDRmTWszTzgxOHgrQWV1REZRY2t6OWRVQTBNdG1wUEUxV2s1?=
 =?utf-8?B?cEdGek9Sc0o5STViQzUrZHdRdVZ1dTZkZ0dEOFB2RDJGSE9TczdyNXJGbGVt?=
 =?utf-8?B?ZGdERC9qWitqZ1pDVlQ4bzlnRFE1bHBSU21wSDFHUVFJQURvVzcxUm5UaTBR?=
 =?utf-8?B?THYrV0ZlMFB2VTRrbFFYd3hVR2ZHb0h5NXFKQytaNmd5ek1OaDN3S2d6Um5V?=
 =?utf-8?B?RURYY3pLNVYxTktvTmtaTlJLNjdaQmpBVitYUzgwQ1N3YjYvOTdieVZvRHJv?=
 =?utf-8?B?K0hMblY5WXAyRGdtWVR5empoRmJjRGIxanFJMHRzWnNLaVZzWmFMT01sV3Fh?=
 =?utf-8?B?aFc1R3ZsRElVR29HM3hxSk9zUnZMcnVRU1Q0OVRISE1INW1yMG1JYUkvdDBu?=
 =?utf-8?B?ZC9NQmFlNDBoajhrbkN2bFZ5Z0dpTy9qV1JlUkJaeWxWTzNxNGk4YVRVMkVm?=
 =?utf-8?B?M3kvOExibVo0K0FlbTIvdWdaWGhLQ1F3akJVNEFnVzZtb3RIUmNVeGs1dlNR?=
 =?utf-8?B?c24zS2RneGhnMWpQQ1N4RXRZa3pWMmJFbTZZS2NLaDJzUE5iTStvY212Mlll?=
 =?utf-8?B?Z3VneDFvQVVUUzRLQUhRL2xoSUhLRjE0eWRFdklETjByVlFTemMyblVuSTJI?=
 =?utf-8?B?NWM3NkcvWHhnOGpadFRFa0tKdEs2Y3ZBdGVLZFk4Y3BqMnA2Z2JidTVmMHZv?=
 =?utf-8?B?YXVmd0NWQ2o0VUYwVGxnMjFyWS8wS3c1ZTB2cng2SVB6TWRIWnhxU2g4S0FI?=
 =?utf-8?B?WEVBaktHb1JuRnVPMGFBSURhdHRNelpqMWtOM1ZvSEd0QzEvWXFBVWhwejdl?=
 =?utf-8?B?K3lreDZPYkpPVjBlYVJRT2ZOWkZ4bkNLaHNKUTZlUVA3SVpTQlZwd1hXSDk0?=
 =?utf-8?B?MStCMEY1eER6cGJhTW1vN2JMc0ZEaUtsUFMwdXZZbXpoK3Q4Z0tQOUw4Mi9H?=
 =?utf-8?B?T1NGK0luRS9QejhqaFlTWmdsdnZ2Sk14VTZMcjhpTktWaXV3dE5uaEYwQU5E?=
 =?utf-8?B?SkxWbXBCajZZTS8yZm5PZTJhS2d6RGFqcFprMi9XekNrRlZCVkZlWS9XRWdH?=
 =?utf-8?B?R0FNSUVkdFZlVERQelpEWjdJK0dsdThaakpjZjBiNGM0bStGYmRWbU5NMTJX?=
 =?utf-8?B?bEpQcjExWEQvdFRaTUxQcWFWcEowTFFDbGJkOTJCaldPMjN6MnM0Z1YwL2wz?=
 =?utf-8?B?WlFoQklsbmE4elhpaEh1TnZ3amxkU3dYSXdZQ29tdy91Q250YXpzUzFhdzFs?=
 =?utf-8?B?alZwSlk5YzJMUlJBME9TT2szaXBBVjNmSWdtVjZ0SXd6SldybnZFa0FOQ3Rt?=
 =?utf-8?B?TlUxYVBlWHJPOS9SN0ZXZ09jb0taSVFHQ04wcXUzL0V4SG9wM1dhL1FuckhH?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0b2de2-5e4b-437f-e6c1-08dd5d35787c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 05:03:59.3994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZ6iT02xoolT5zpst7SbAlq2EkrfpabR+3gNFMtbsZVWrPPNlx0sz9KPxZPGe7WngRdJpnsALTBBZYvtLF6ihEHT/fA31jg56LLGFP5LNSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8381
X-OriginatorOrg: intel.com

Hi James,

On 2/28/25 11:59 AM, James Morse wrote:
> MPAM platforms retrieve the cache-id property from the ACPI PPTT table.
> The cache-id field is 32 bits wide. Under resctrl, the cache-id becomes
> the domain-id, and is packed into the mon_data_bits union bitfield.
> The width of cache-id in this field is 14 bits.
> 
> Expanding the union would break 32bit x86 platforms as this union is
> stored as the kernfs kn->priv pointer. This saved allocating memory
> for the priv data storage.
> 
> The firmware on MPAM platforms have used the PPTT cache-id field to
> expose the interconnect's id for the cache, which is sparse and uses
> more than 14 bits. Use of this id is to enable PCIe direct cache
> injection hints. Using this feature with VFIO means the value provided
> by the ACPI table should be exposed to user-space.
> 
> To support cache-id values greater than 14 bits, convert the
> mon_data_bits union to a structure. This is allocated for the default
> control group when the kernfs event files are created, and free'd when
> the monitor directory is rmdir'd when the domain goes offline.
> All other control and monitor groups lookup the struct mon_data allocated
> for the default control group, and use this.
> This simplifies the lifecycle of this structure as the default control
> group cannot be rmdir()d by user-space, so only needs to consider
> domain-offline, which removes all the event files corresponding to a
> domain while holding rdtgroup_mutex - which prevents concurrent
> readers. mkdir_mondata_subdir_allrdtgrp() must special case the default
> control group to ensure it is created first.

This is novel.

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Previously the MPAM tree repainted the cache-id to compact them,
> argue-ing there was no other user. With VFIO use of this PCIe feature,
> this is no longer an option.
> 
> Changes since v6:
>  * Added the get/put helpers.
>  * Special case the creation of the mondata files for the default control
>    group.
>  * Removed wording about files living longer than expected, the corresponding
>    error handling is wrapped in WARN_ON_ONCE() as this indicates a bug.
> ---

...

> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index aecd3fa734cd..443635d195f0 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3114,6 +3114,110 @@ static struct file_system_type rdt_fs_type = {
>  	.kill_sb		= rdt_kill_sb,
>  };
>  
> +/**
> + * mon_get_default_kn_priv() - Get the mon_data priv data for this event from
> + *                             the default control group.

Since this involves monitoring this would technically be the default "monitoring"
group (throughout). 

> + * Called when monitor event files are created for a domain.
> + * When called with the default control group, the structure will be allocated.

A bit difficult to parse. Assuming there is a re-spin, how about something like:
"Allocate the structure when @rdtgrp is the default group."


> + * This happens at mount time, before other control or monitor groups are
> + * created.
> + * This simplifies the lifetime management for rmdir() versus domain-offline
> + * as the default control group lives forever, and only one group needs to be
> + * special cased.
> + *
> + * @r:      The resource for the event type being created.
> + * @d:	    The domain for the event type being created.

Stray tab makes for inconsisent spacing.

> + * @mevt:   The event type being created.
> + * @rdtgrp: The rdtgroup for which the monitor file is being created,
> + *          used to determine if this is the default control group.
> + * @do_sum: Whether the SNC sub-numa node monitors are being created.

do_sum can be true or false when it comes to the SNC files (more below). 

> + */
> +static struct mon_data *mon_get_default_kn_priv(struct rdt_resource *r,
> +						struct rdt_mon_domain *d,
> +						struct mon_evt *mevt,
> +						struct rdtgroup *rdtgrp,
> +						bool do_sum)
> +{
> +	struct kernfs_node *kn_dom, *kn_evt;
> +	struct mon_data *priv;
> +	bool snc_mode;
> +	char name[32];
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	snc_mode = r->mon_scope == RESCTRL_L3_NODE;
> +	if (!do_sum)
> +		sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d->hdr.id);

When in SNC mode the "mon_<resource name>_ files always use d->ci->id as the domain id.

> +	else
> +		sprintf(name, "mon_sub_%s_%02d", r->name, d->hdr.id);
> +


The mon_sub_<resource name>_ directories are always created when in SNC mode, they do
not exist on non SNC enabled systems. The mon_<resource name>_ directories exists on
both SNC enabled and non-SNC/SNC disabled systems. The mon_<resource name>_ directories
on SNC enabled system will have "do_sum" set. I think what you may be trying to do
here is something like:

	if (!snc_mode) { /* do_sum is not relevant */
		sprintf(name, "mon_%s_%02d", r->name, d->hdr.id);
	} else if (snc_mode && do_sum) {
		sprintf(name, "mon_%s_%02d", r->name, d->ci->id);
	} else { /* snc_mode && !do_sum */
		sprintf(name, "mon_sub_%s_%02d", r->name, d->hdr.id);
	}

> +	kn_dom = kernfs_find_and_get(kn_mondata, name);
> +	if (!kn_dom)
> +		return NULL;

It seems like this either assumes the directories are on the same level or assumes
kernfs_find_and_get() does a recursive find. As I understand kernfs_find_and_get()
does not do a recursive find.  On SNC enabled systems the mon_sub_<resource name>_
directories are subdirectories of the mon_<resource name>_ directories.
Example of how hierarchy may look is at:
https://lore.kernel.org/all/20240628215619.76401-9-tony.luck@intel.com/

With all of the above I do not think this will work on an SNC enabled
system ... to confirm this I tried it out and it is not possible to mount
resctrl on an SNC enabled system and the WARN_ON_ONCE() this patch adds to
mon_add_all_files() is hit.

> +
> +	kn_evt = kernfs_find_and_get(kn_dom, mevt->name);

Note the "...and_get..." in kernfs_find_and_get() that gets a reference to
the kn before returning it. I expect that this work will have symmetry when it
comes to get/put of references but I see four new calls to kernfs_find_and_get() but
no new matching kernfs_put() to release the new references. It looks like
kernfs_find_and_get() is just used to figure out what the kn is so the references
need not be kept around for long.

> +
> +	/* Is this the creation of the default groups monitor files? */
> +	if (!kn_evt && rdtgrp == &rdtgroup_default) {
> +		priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +		if (!priv)
> +			return NULL;
> +		priv->rid = r->rid;
> +		priv->domid = do_sum ? d->ci->id : d->hdr.id;
> +		priv->sum = do_sum;
> +		priv->evtid = mevt->evtid;
> +		return priv;
> +	}
> +
> +	if (!kn_evt)
> +		return NULL;
> +
> +	return kn_evt->priv;
> +}
> +
> +/**
> + * mon_put_default_kn_priv_all() - Potentially free the mon_data priv data for
> + *                                 all events from the default control group.
> + * Put the mon_data priv data for all events for a particular domain.
> + * When called with the default control group, the priv structure previously
> + * allocated will be kfree()d. This should only be done as part of taking a
> + * domain offline.
> + * Only a domain offline will 'rmdir' monitor files in the default control
> + * group. After domain offline releases rdtgrp_mutex, all references will
> + * have been removed.
> + *
> + * @rdtgrp:  The rdtgroup for which the monitor files are being removed,
> + *           used to determine if this is the default control group.
> + * @name:    The name of the domain or SNC sub-numa domain which is being
> + *           taken offline.

This is a bit confusing since domains do not have names. How about (please feel
free to improve):
"Name of directory containing monitoring files that is in process of being removed."

> + */
> +static void mon_put_default_kn_priv_all(struct rdtgroup *rdtgrp, char *name)
> +{
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> +	struct kernfs_node *kn_dom, *kn_evt;
> +	struct mon_evt *mevt;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (rdtgrp != &rdtgroup_default)
> +		return;
> +
> +	kn_dom = kernfs_find_and_get(kn_mondata, name);
> +	if (!kn_dom)
> +		return;

I expect this will always fail when @name is a mon_sub_* directory.

> +
> +	list_for_each_entry(mevt, &r->evt_list, list) {
> +		kn_evt = kernfs_find_and_get(kn_dom, mevt->name);
> +		if (!kn_evt)
> +			continue;
> +		if (!kn_evt->priv)
> +			continue;
> +
> +		kfree(kn_evt->priv);
> +		kn_evt->priv = NULL;
> +	}
> +}
> +
>  static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
>  		       void *priv)
>  {
> @@ -3135,19 +3239,25 @@ static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
>  	return ret;
>  }
>  
> -static void mon_rmdir_one_subdir(struct kernfs_node *pkn, char *name, char *subname)
> +static void mon_rmdir_one_subdir(struct rdtgroup *rdtgrp, char *name, char *subname)
>  {
> +	struct kernfs_node *pkn = rdtgrp->mon.mon_data_kn;
>  	struct kernfs_node *kn;
>  
>  	kn = kernfs_find_and_get(pkn, name);
>  	if (!kn)
>  		return;
> +
> +	mon_put_default_kn_priv_all(rdtgrp, name);
> +
>  	kernfs_put(kn);
>  
> -	if (kn->dir.subdirs <= 1)
> +	if (kn->dir.subdirs <= 1) {
>  		kernfs_remove(kn);
> -	else
> +	} else {
> +		mon_put_default_kn_priv_all(rdtgrp, subname);
>  		kernfs_remove_by_name(kn, subname);
> +	}
>  }
>  
>  /*
> @@ -3170,10 +3280,10 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
>  		sprintf(subname, "mon_sub_%s_%02d", r->name, d->hdr.id);
>  
>  	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> -		mon_rmdir_one_subdir(prgrp->mon.mon_data_kn, name, subname);
> +		mon_rmdir_one_subdir(prgrp, name, subname);
>  
>  		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
> -			mon_rmdir_one_subdir(crgrp->mon.mon_data_kn, name, subname);
> +			mon_rmdir_one_subdir(crgrp, name, subname);
>  	}
>  }
>  
> @@ -3182,19 +3292,19 @@ static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
>  			     bool do_sum)
>  {
>  	struct rmid_read rr = {0};
> -	union mon_data_bits priv;
> +	struct mon_data *priv;
>  	struct mon_evt *mevt;
>  	int ret;
>  
>  	if (WARN_ON(list_empty(&r->evt_list)))
>  		return -EPERM;
>  
> -	priv.u.rid = r->rid;
> -	priv.u.domid = do_sum ? d->ci->id : d->hdr.id;
> -	priv.u.sum = do_sum;
>  	list_for_each_entry(mevt, &r->evt_list, list) {
> -		priv.u.evtid = mevt->evtid;
> -		ret = mon_addfile(kn, mevt->name, priv.priv);
> +		priv = mon_get_default_kn_priv(r, d, mevt, prgrp, do_sum);
> +		if (WARN_ON_ONCE(!priv))
> +			return -EINVAL;
> +

This is the warning I hit on the SNC system.

> +		ret = mon_addfile(kn, mevt->name, priv);
>  		if (ret)
>  			return ret;
>  
> @@ -3274,9 +3384,17 @@ static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
>  	struct rdtgroup *prgrp, *crgrp;
>  	struct list_head *head;
>  
> +	/*
> +	 * During domain-online create the default control group first
> +	 * so that mon_get_default_kn_priv() can find the allocated structure
> +	 * on subsequent calls.
> +	 */
> +	mkdir_mondata_subdir(kn_mondata, d, r, &rdtgroup_default);
> +
>  	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
>  		parent_kn = prgrp->mon.mon_data_kn;
> -		mkdir_mondata_subdir(parent_kn, d, r, prgrp);
> +		if (prgrp != &rdtgroup_default)
> +			mkdir_mondata_subdir(parent_kn, d, r, prgrp);
>  
>  		head = &prgrp->mon.crdtgrp_list;
>  		list_for_each_entry(crgrp, head, mon.crdtgrp_list) {

Reinette

