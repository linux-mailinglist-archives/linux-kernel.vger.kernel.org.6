Return-Path: <linux-kernel+bounces-298013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3619495C06D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 23:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B981F23986
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683BA1D1751;
	Thu, 22 Aug 2024 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XwnIadpG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9969A15443B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 21:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724363315; cv=fail; b=o6Qj1n9LogE5rtjqsUedQ4BOM8R5DHteTuXr/48K5wDs2F3gLLbKrjxSNu9Jqg1w+uxGfmwFLo1WcKwYvo26/ks2OHfRXzJY3AgMIZI7VJyyESmrj4YXcZ4PcJug00A13iEeuncjHEpFon+1gOfPSpWUwJuCFvXwCWj6vUEJepo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724363315; c=relaxed/simple;
	bh=6raKD6xNFtWjtJSdh0NORF7usT9HUKijGKShWIvKnYk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wu1w4zjhM+XKJQ/30uE3mEfb3xdj2l/QCzeSJ5kaLye8wz8/dddQIiAgjyt/caR7JG1OPAbGhqDxCUmtgpbNTTbBIvB3jU2NIYtOh+K1Gz8yiZaphglnUX+f1tQHbf0tE1yWi+SdkVAzPSFaloMYiv4Hs+owYZbm4RD6NZqlLRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XwnIadpG; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724363314; x=1755899314;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6raKD6xNFtWjtJSdh0NORF7usT9HUKijGKShWIvKnYk=;
  b=XwnIadpG84ktnRInpTLA31sbtvgo5mmBh0YGdk+2maPmHDfy0zfzVMqB
   VI9rQ3itrW8akumAj2+8dj9bOqnlhR5k3w9OLlTWoSq0aBC9xqzuqszEo
   uGulfex2DFoLUthHu97QOy7fj8uaRmDG9Zr44CbT5bvDqvoH0NlpRgXh7
   UqDITRqefoteQrLztQAfKsWJhevLq3JHbazXYtGRnNNrEoE4Yp3CpWqud
   QFDCZadWJgKiIg8JYnsQlJCcewXvfcxSNNVoXENjZve1uUb2fKgd16AIH
   PvvQC6Alwffa37lWAlLkoeuT5seksNFqmTSuMNghUpoKXnlZJM0Yvmmpy
   A==;
X-CSE-ConnectionGUID: oJeokDSXQSWZh1rB5YuU4A==
X-CSE-MsgGUID: gYRtHmaOR7yHI1mNExlJOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="26604934"
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="26604934"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 14:48:33 -0700
X-CSE-ConnectionGUID: KDhOizfRRN6uZY/59VYL1g==
X-CSE-MsgGUID: FljInevKRraMduTEKF5PDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="84773282"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 14:48:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 14:48:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 14:48:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 14:48:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 14:48:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJsarB4GCUAyC2KNsR+RcStgMBxIpKzVBzkbjWRn30VcbX7bRGIHfyXRSo6rpKFGAjrriV9BVSnX0eYGk+4aU6UZ/AbKHJkSAMKM3fSogBRUTN57gF8xLeCEyR/4nH6Lf/ubC1Y6P18Dru5rO5a/c6L+8NjUEYS8jE8QZUlEbIC+qyFHCBWb4ct6W+dMuzqeLzNGCXuGTsiC3ImU2jiGH9VE9pfBXFdWzOwOjcB8F5nk1WB/PYga3brObqqAUTGRzjojLi4MZKRcbEz3cugY4AxRjWWJyPKOAQP25QidYwvA+Tv1gdi+l1tJ81Jx3O/DxFjFS0xckPMs5UHGZ+7ObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yk6JnNglglHoYTUjbLhdRpTQTPuQqK6G1LNtTbOD74s=;
 b=Enp6rg2HNUqgMmcOERVBsU4vsTjaC39rQ63VnhP+HTsMf9uMQb3UD+fVkbCh+lkhz3O8hpZ1goApT62/FcmzjdI9c2CGKHWiK1OL/L1qlt5aeaFelIGmF5q9yFa1ig94mcajz8cBtgNWD5NC6q+c/21yNIO2pNc4j/rLr7GhAatxnQIwsMxHbfWXKaMJZGgESu7gIYBhNuMLljeR/y3aSH4EJwHdNbJ0FexcdrJxU/cPRsPdaQlEXppal07LMH/hQt2yOBnEuZfNGxpbS/cT8FwRIIRYx5qCKOmqUJUSfveRirj5XA7wCLxlUKS+YD2kSQh8/H4drSpLRuV3GgqxQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB7690.namprd11.prod.outlook.com (2603:10b6:8:e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 21:48:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 21:48:28 +0000
Message-ID: <96f40371-1b6d-4398-a384-78333e75847b@intel.com>
Date: Thu, 22 Aug 2024 14:48:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/resctrl: Fix arch_mbm_* array overrun on SNC
To: Peter Newman <peternewman@google.com>, Borislav Petkov <bp@alien8.de>
CC: <babu.moger@amd.com>, <dave.hansen@linux.intel.com>, <eranian@google.com>,
	<fenghua.yu@intel.com>, <hpa@zytor.com>, <irogers@google.com>,
	<james.morse@arm.com>, <linux-kernel@vger.kernel.org>,
	<maciej.wieczor-retman@intel.com>, <mingo@redhat.com>, <namhyung@google.com>,
	<tan.shaopeng@fujitsu.com>, <tglx@linutronix.de>, <tony.luck@intel.com>,
	<x86@kernel.org>
References: <20240822190212.1848788-1-peternewman@google.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240822190212.1848788-1-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:303:87::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5ee8a4-84b7-447d-c7f6-08dcc2f42856
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEpNaFBRUUVMT29vMTdraEFTMTZ1OWhDK2ZoMGlCS3VoMXpXc1dDa0M2YU0y?=
 =?utf-8?B?cFFMNWQ1SDBWWENHbEp5dlNNOHVncExLckkrR0FJZ0l3U00vUGRwRVlhRDUz?=
 =?utf-8?B?dkV0bk9tQkJrNjJCMWxtL2d4R1crK0EzU1hESmFzZEp6eEJ4VlJyYzZ6WFZN?=
 =?utf-8?B?RFI4ek5EU2tOVkVtWHlZclZSSTQvbm9qUVRUQ0NMUlNUalRHUk84RmZHZG1i?=
 =?utf-8?B?c1RQazVpdnY5Q0RUczFVdlFXb2cwUWV6YWs1NWMzOElneU43YkZabkNpWCtx?=
 =?utf-8?B?VEg5VVJqaDZ1MHh6QnVRaDlJU21EZXRCQzhpZk1ReUNRQTJlcU1oZ0hKYjk5?=
 =?utf-8?B?OUdUYitIZ2NXTGJJdEFLY2U2K1luNDByenF3ZWhuMVhOb21NendRaVg0WnQx?=
 =?utf-8?B?WGVqTW9YSGRCWTNpajhPakVycktrekIveGErdFdqWmtQUG12MnkrTFNQSEdX?=
 =?utf-8?B?QkJ3OXI3amJzQlpTYk5JdHlBNyt1c2hPNkZQTHVaTjNwOHJxUDBma1NtdWFY?=
 =?utf-8?B?V0xWWk5WWERvTW9MU0w4eXVyQkV0a2Z2N1h4dGN4ZU5VR3Njc1ZsN0MxKzNy?=
 =?utf-8?B?N2ZwdFFTK0hLcGJLOHFOVEhvN0JGLzJISXlrbG9ZVlpaNHdZYjlVQitRaHdT?=
 =?utf-8?B?KzB1ZU1hU3kwN0lydXhPVkJKaXNXVVgyTE5Da0lmTzN3MjhSMFc0RWFUTUdC?=
 =?utf-8?B?eXlnTDVRc3M0Q0lac2lpU1A5STBtU0kyWjA2NHZhU1NLTjBEUVJMMXpJMytM?=
 =?utf-8?B?WkY2bldLelNUSWJlS3Zzb1NXeituUTg0MFIwTFRaS3JLaktVaGJKZ1VFcU5K?=
 =?utf-8?B?NnZuMk1DWVBLayt1Y3hLeFg3dW5LR29BWTJodG5RekhmSG9US21KQnhad0ZT?=
 =?utf-8?B?dmh2YmlzNmUxMHVwM2d3b0xNR3MrUkE2QjUwSVY1OG9qRkl1a1ZoVzhwWkto?=
 =?utf-8?B?WTNSYkZvSzF6dlEwRklOUXR0c3FJRUV5azNTQUVXcFdLZUZZVVFwcjBRT3NF?=
 =?utf-8?B?WXhrUTVnQjR1UnFNbWVta2FBOFRmOVQ4cFhpbFRrclhQVFdLdVNCUVJhWWVa?=
 =?utf-8?B?MCtDdDlDRTVzMEpMMDBaZndMRkU4OTZzc1JXVmRjYmVmQmVYb2dHTVpQR3p4?=
 =?utf-8?B?ZE4rNUk0Y2wzTnFXbVA1bFlpZDNLOHAyYTZjVHVROFozME1JeGRzWEdTQ3NK?=
 =?utf-8?B?U3FVN3M4cCtXcG9LdW50SEdmenBQNGhDTU9kT3k5aXVLeVZ0M2FYTGF1R2pw?=
 =?utf-8?B?YmFpNFgxMzhqeUFrVytlZzgvQlFIeXJBRG1IcGNWQk9xc2RCMENtMFZWdXBU?=
 =?utf-8?B?THlNbGRqVVB5RzlqZXdrcGw1Z1RCS244L3IzY2hXYmgzTmsrc1JoM25icGNI?=
 =?utf-8?B?SDk0TFNWWjZTeXZDc2laekkycVRhWFRTcUJHMVVKTXZoSXFIdTBRcTl6a3Jn?=
 =?utf-8?B?KzUrOXA5allQWVVMUXFlTFNRR3A4QWJNSTI1ajV2Tzk0bWxaNzlHQnVnK2Nz?=
 =?utf-8?B?aWpEdWl2eDg3d0pTQUd2alZ6eDFKakJsSlgrWlNUZjVZVlNNQ2JBVk9WMHlF?=
 =?utf-8?B?UWZTTzZxcTJ2cGwrOWcxNTE0WGxCa0YrSFhkZ1YwVk1BVHVCRHhNcmY0QW1Y?=
 =?utf-8?B?TGM5SFFHS1pyZ1dIME5oM0E2WEV5SFhDZ2hlWGZldllzMHV5RDhrelhIcits?=
 =?utf-8?B?aHJDYjVDZUJSNW54RzhCZUFEak91Tkd6WGdjQjZ0dCtmQjVLN2JsRDIxbVlK?=
 =?utf-8?B?NEZlcy9zTUlCWVI2b0Q1VXE0RlpPRXVQdERQMFdMTmxEWWVuekVQSmt3OUJE?=
 =?utf-8?Q?KFsZKJvWfzeUxmYpcNab6fLED3pAR6QwYQ6D0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXhKVTlJY2NlZU1lY1NicHRoUEJwQnpZRnhJNXVLV2dtS0F5bDN3UURFdEFo?=
 =?utf-8?B?WUp1UjAxb3ZJYjQvM1pUT2pYbUc5MVVmOWcxc0lVM2xOd1pGbmd5SHFtbHls?=
 =?utf-8?B?bHJIc1lHVUFvcW1XRFY2TzlybjNxQjB2cEtGMTVNbUdqeWFUMTNEVFkwOHhp?=
 =?utf-8?B?dlp3WnJPb3AvT24rdGxGU3dWZXJhR3JVcHE1bk5FWENYQzhhc1lFS3FuNnR4?=
 =?utf-8?B?Vk5VQ0wxSTJlMWZJYWV4aEVqMkNTUEVFTXEvQjhjcVYwT21EcG5FckZvemIy?=
 =?utf-8?B?cEREWFRJZWEyd0NEQ1pxUkZWdVJWcmtNNmdCc3RiMjJnaW1pRHpUWkhmNWNV?=
 =?utf-8?B?eU5hNG1wSnIrbndFWjRTSnAzaGN1ck9EZHo1anZKU3RGc2xnb01Vd0FDNUZU?=
 =?utf-8?B?RHdEMVQ3c3pEZkdJV2NlOGhscWdDbzd6c1Q5OUVkbTErZVozMUNJeGlIU0Yx?=
 =?utf-8?B?bWErSGxOQ1dIUjRLWlJDRDc3Y2lUQUlJQVZNSkR2MURsSmxJaXV5SW9qeitw?=
 =?utf-8?B?R1gyZ3hPUmtwTjd3a2dSWjNUUnRjMmpTVEkzQ3NaN1RhdU9xVXdsNWxKYXNE?=
 =?utf-8?B?dzMzTDZjRzh0NUZuU09INXR3SmhWcndZcFBIR2cycGQ0VkVvaDMwY0oyS0tY?=
 =?utf-8?B?bkpUeW4wTmxmdjdoL2VMeHRXb1BkeHoxNVoyVk1xWWZNVDl0eU1xeDRoWlpO?=
 =?utf-8?B?QjY1ZGE0aUY2WUIyMU1odThQZTRyQjljT3BEVWduZEVLeFY0SFlMUStiVng0?=
 =?utf-8?B?eDdUZThsaHRINm9kVy8zYzNxb0NkTUlzMmZwU1YvKzhyUkpBc0h2NVZEZGp0?=
 =?utf-8?B?UHhON055SERlTUVuYk1RSjdLbDh4ampZTGJkZ1lwdE9KdVEzRS9VZXA5U3Rk?=
 =?utf-8?B?T1lJZGJXLzFFb2R0MnkyazZSc0dzYVVJaUZoUFBVNDRUQy8xKzlhTzVWS2ZB?=
 =?utf-8?B?QStXNGZoYm1OVGFVZ2FLTWRDL3BxblBtTEoxSDhpNkloR1AwbGh6U29rdU9u?=
 =?utf-8?B?akxNYk44bWpYQTlHdXl3a0xDaFJUSnUxMjlRaHltREFiMENFSitzNlA1V05Z?=
 =?utf-8?B?dVlZbE1aaUtXcE1CWmU3OTFOdEV5MUFoS3BnVFkzSG5DZTlNK3VNVXJlc2Yv?=
 =?utf-8?B?aGs5MDg5NzI2QzF0dHhKbTJocmFsM213MFNiNDdLMXlkdHkyd1JPRDF0UjdW?=
 =?utf-8?B?clZUdVhIU2Rkc3B4R1hSYTN0dlk3R28vQ1ZvM0ttUDk2RWVHNG9La1JCZU93?=
 =?utf-8?B?ZUNmMUtKUFlkdkxBOHpRZHB1K05ad3NDYnNiTktyMkRwcVJ3eG51NVZxTjVn?=
 =?utf-8?B?VmpQK0VQalVBNEZoYUtUZWVXZ0ZMUzh5MDBTaHFVTmk3TmtXYjJadVJWRHpY?=
 =?utf-8?B?QWhiU1M3bTBmVnFRZzRZMEd4ZEErZ0RxNHhtbEU5LzQranJpSjNFcktQNkhY?=
 =?utf-8?B?T2t5ZFNBZkdyT1l3TWZ1RnZydjY1MWR5dTlNR3RLbnYweVU1S0RRT2x5MG4v?=
 =?utf-8?B?YVcvRFUxazYxNkY2ZGtwdlBCT2xENGJLcThTVGhDeExpakJISW15d0tyYlJk?=
 =?utf-8?B?R09MR2VFVjNoVEFXc2xYSERCTlJoQzkyRXNLTjJXRS9LQXF2ejR3WmN4dzhi?=
 =?utf-8?B?YWN4dTM2QXBhOTJCbkRncUI5ZGlRRURmT2ZIVU05OURTanBlQlVXRXFXYWZj?=
 =?utf-8?B?SHJ3VUdoS3RXU3dvdXpaVVBsNEF1U1gxc2ZVbzM3S3ZtSXRLd2tlam9DOExp?=
 =?utf-8?B?eVhUT1k3WU5vSjBZUmtKR1JlTDFXcC8yVmR4L0o2VWpTVmFkUE1QMlBVTjJj?=
 =?utf-8?B?RDVaV3FjSXpHN2d2OUNJNlFaZ2JZVGJHaVhMemhXYWpOT0d2OGhsY2lkUFV1?=
 =?utf-8?B?Rnp6VzNYRDBEVWdwVHROVGFHYU9DWVZZWEhWR0NlY0hyaGNUTTdvTTZvR2Yv?=
 =?utf-8?B?UjdkNGRqL2RJcUZMUTM5Ty8wdEJxbzdkejdsRXRSLzRVeFVpVFJMaEFpTWs2?=
 =?utf-8?B?VWpnWjR6eGZtbnVFbk94RnpOUm9LQVFmUkwxY1FYTFgySStYSXpzZ2MwMDFI?=
 =?utf-8?B?TFBscEdQbWpGL09WTDF5NE8zQTlZMGdIcUtYTzUxNmRvZWdpdStHc0UwYVBv?=
 =?utf-8?B?NEVoN0NEK1UremFRZ1lINDJiSlpXeTZhL3ZJRHhOZWZ3OWFrTkxCeElCbXF4?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5ee8a4-84b7-447d-c7f6-08dcc2f42856
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 21:48:28.5524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeOSIwoEoM9XyJPZ670JH88lpdgWlDx1d0sECf57JKUud2jzot4+4PkyK5Bvwhp+LbiPiaDH1g1+yBj/bNg9+J/xAcL5y/udyav3F6YmdkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7690
X-OriginatorOrg: intel.com

Thank you very much Peter.

Boris, could you please consider this for inclusion?

Thank you

Reinette

On 8/22/24 12:02 PM, Peter Newman wrote:
> When using resctrl on systems with Sub-NUMA Clustering enabled,
> monitoring groups may be allocated RMID values which would overrun the
> arch_mbm_{local,total} arrays.
> 
> This is due to inconsistencies in whether the SNC-adjusted num_rmid
> value or the unadjusted value in resctrl_arch_system_num_rmid_idx() is
> used. The num_rmid value for the L3 resource is currently:
> 
>   resctrl_arch_system_num_rmid_idx() / snc_nodes_per_l3_cache
> 
> As a simple fix, make resctrl_arch_system_num_rmid_idx() return the
> SNC-adjusted, L3 num_rmid value on x86.
> 
> Fixes: e13db55b5a0d ("x86/resctrl: Introduce snc_nodes_per_l3_cache")
> Signed-off-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> v1->v2:
>   - Squashed blank lines added to linux/resctrl.h
>   - Reviewed-by Reinette
>   
> v1: https://lore.kernel.org/lkml/20240722204611.3549213-1-peternewman@google.com/
> 
>   arch/x86/include/asm/resctrl.h     | 6 ------
>   arch/x86/kernel/cpu/resctrl/core.c | 8 ++++++++
>   include/linux/resctrl.h            | 1 +
>   3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 12dbd2588ca7..8b1b6ce1e51b 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -156,12 +156,6 @@ static inline void resctrl_sched_in(struct task_struct *tsk)
>   		__resctrl_sched_in(tsk);
>   }
>   
> -static inline u32 resctrl_arch_system_num_rmid_idx(void)
> -{
> -	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
> -	return boot_cpu_data.x86_cache_max_rmid + 1;
> -}
> -
>   static inline void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
>   {
>   	*rmid = idx;
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 1930fce9dfe9..8591d53c144b 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -119,6 +119,14 @@ struct rdt_hw_resource rdt_resources_all[] = {
>   	},
>   };
>   
> +u32 resctrl_arch_system_num_rmid_idx(void)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +
> +	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
> +	return r->num_rmid;
> +}
> +
>   /*
>    * cache_alloc_hsw_probe() - Have to probe for Intel haswell server CPUs
>    * as they do not have CPUID enumeration support for Cache allocation.
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index b0875b99e811..d94abba1c716 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -248,6 +248,7 @@ struct resctrl_schema {
>   
>   /* The number of closid supported by this resource regardless of CDP */
>   u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
> +u32 resctrl_arch_system_num_rmid_idx(void);
>   int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
>   
>   /*
> 
> base-commit: 47ac09b91befbb6a235ab620c32af719f8208399

