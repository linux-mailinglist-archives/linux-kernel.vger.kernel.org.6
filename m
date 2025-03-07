Return-Path: <linux-kernel+bounces-550443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F03A55F9C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD593B3AD6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1549518DB25;
	Fri,  7 Mar 2025 04:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SL+/Yq5+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C54014830A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 04:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741322918; cv=fail; b=bvKCLBKKvV/rZmzBdUsXoUrHz9CEoFscWFNJCE+SdTCNe5LVSDZGz1bxeYuTJPkO4ge9OjZ0LryVOGaWN/7nzNC7dceVM6ijB7Bd/xqN+/HQZe2uHH5XITzMTYy3Ts87wThDign7KYjjDaHzzJFevuvUtyC1AwUCQ04zzPxLnZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741322918; c=relaxed/simple;
	bh=rWrMoazg4liKyCb/mOieOkBTtNerjh4t3bb48d2DgSA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FILiNIRuxBPApMJMaSm3mphM8uP4zhMGAXJExCGmRz1G8cDpZVfB2vQVGCX3jvT9oHccLfpRsd4PiEmm53W7lTDiH0bryTcr4OV3the8ocwm/+5WZFcCID9Owml3n5WrHkPYyOdrBGu4r9jge51nuoomnajhij5M2hBHHNxo/uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SL+/Yq5+; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741322916; x=1772858916;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rWrMoazg4liKyCb/mOieOkBTtNerjh4t3bb48d2DgSA=;
  b=SL+/Yq5+ICIoU5OjEAWhZMgXf5LTiGj4VtEOnST2huuP5UW/p4I43Ayc
   3OmLiIZTqdLsVxvHQb7RiAT+AIZL9lwIKjMXn0Mng1xn06CRNykPwSTp+
   kRONR+8kX4dB1TzOwdQyqMoR3gqhSCREwyAA3+6Zv3oJm0gJ+D5N5gYif
   jGtfDd8PvuAXNB2o0t6BdWbzwPm47PNSm/lv88dIz13glXN0wLrD+u4H5
   M0vCUq56VH8bcMwFccqhIXTZ1u6tWWz+8Kanr509QoyoJkBMzgd1Tmv1y
   DmPnVvF657cPIgSwkn0O06zx2S84r5ShdC55r5K7ZmbTpnKyxx6vsP7SB
   g==;
X-CSE-ConnectionGUID: DYKZd/Y5RUCZhc2fXlz3bQ==
X-CSE-MsgGUID: GKyPReBITCi5o1Mi7erh1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42503339"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="42503339"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 20:47:40 -0800
X-CSE-ConnectionGUID: ZEbYfDqRTXSm9SXTmD0P0Q==
X-CSE-MsgGUID: ogCngVC/TO+QN+uReJfznw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="124252798"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 20:47:39 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 20:47:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 20:47:39 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 20:47:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFB47eTd0+iXJ5PFXTX+nnsI4U/je69JfO1MdWVBeWuOSxzGHHE/O+o/QcTqdHHIews49w9QsNRuXCsUTMMcobiKefpHNg3KPUBfCgLPe8bt1CADkteueCdEmjAjmHtS3XBcx+JdMW+zZuYO8rP3LgDM9qUGc8czxCzWPPhmxKwtO3RuwtugiB6bEi9p9JO7DbwG9kisYM9fq1oS1QUr+LTQ7esJuR9KU0NdqHQKikNdnrHNEM8d/qE/0yKW9cDSBkBqxEqrGSEe8hObW22BSUksw67ziubMOON5WOziXaz+s1F9Hwh6dJjvyq29ydMGmuuogpBdgVEvw0mi1tec6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rk/rJjLiMeQzpUDb+XBy+xgQ14ZL6leHuWYTfIIVVk=;
 b=TfCjEpA2LEocSjLorZaewc/x5HGN79PtMLkGRSt5iua+g2OLrqsrTELcE7YXJ2RPOKhIixSQ7Ys4v8MDHtLpy2flDgQX9KSQs897UGy9x7P3LXMU0m6mhWplwdP3SucejbdhKHN/+qA0yN1AiDIRuScjXTnutqJAfGL+15Vhw8F50w+bCoGi4Wp1jZpfhQ2yRuuIMjsjqRI5Sqt1s0+rUNDMVkaWsIXlGf4Jfvyy4DXwcU3sUGmGVtfyOTyTJHSH8kXlk/AMWNjS6Z/6eJ4IQHiEuG3iJQ87UDBZSNItOWyGnotVlfXls16MZxT3L1r3JcQ5hWldzg7xWiNdMVg6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB5961.namprd11.prod.outlook.com (2603:10b6:208:381::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 04:47:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 04:47:20 +0000
Message-ID: <ee396edd-9b53-471b-a6a2-ac589f1aeb73@intel.com>
Date: Thu, 6 Mar 2025 20:47:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 33/42] x86/resctrl: resctrl_exit() teardown resctrl but
 leave the mount point
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
 <20250207181823.6378-34-james.morse@arm.com>
 <91026839-2f2e-4562-aa77-6901148c89ad@intel.com>
 <b3317010-b8bf-46f8-a176-28f810fd9920@arm.com>
 <c7e9f509-404b-48c5-bda3-ecff80f95242@intel.com>
 <0b2c17fe-3998-4def-81eb-a910d79fbc0f@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <0b2c17fe-3998-4def-81eb-a910d79fbc0f@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:303:b5::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bbe8043-1c62-411c-0242-08dd5d332547
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODUvOEdpWForVWZqSjhqOWQ0Z1NYWXBKRTA4SkUvbE9ZeXJzSFlSYzBMK3ds?=
 =?utf-8?B?UnNybjFaKy9zUmtiNlpQeWJZeHJOcWJlZnJKa2h1NnlSZnpCNVBXYk5iN3U2?=
 =?utf-8?B?aWVERk8zSnZURzJSYnF3OVBXMi9Vemp6SWtiZ0xHclhBK0tjeVlHd2pJRXJD?=
 =?utf-8?B?MzQvNHRVOEd5YXFlZjBubFNCUFpwQUhRdWVwNEh6bkdTcDhyU3VHSWM2Q1Jh?=
 =?utf-8?B?aHNENjBMcG82Z2E5bytPajNkR2xaa2ViV3BzTS9JZlh5emRDQ2p2Mi8zSTZu?=
 =?utf-8?B?TW5RL3YvN21oZXBhbVpkY3Ywejl5R3dtTXk4QWdVb2lmZ0RKbjRWU3VDUk90?=
 =?utf-8?B?ZGFqajlOUkNYY1hRb1l1bzcrdVJscHdWc2lFdnFoMWd5dDIrazc3Sll4YXNi?=
 =?utf-8?B?bFM2N1NURTc1azcrTnZsVVgyOGk1RWFURllsNWZTck8yRU9mc2k1aWF1bXAw?=
 =?utf-8?B?K1Y2L1RqMWpuZjZSNjR4VExDZzJkcGtIQW82c1A3bDdhbkdFVXArUmJZT0hk?=
 =?utf-8?B?VkFzUGgwZlVsRjNOZW5IOVZLSVBoZldzbGwvKy9xQkx1aStCWVFzTmtQL3hx?=
 =?utf-8?B?MnQxVUVQWnQ3QU9jZWlXMDUvbnFkVTdFTXFpL3dOV0JyeHUwRE5YVVA2Qjhq?=
 =?utf-8?B?Y3lHTzNVNDZUQTlFdDRiTngweUNzMDFQWnROL2dQdWFBL3NlU2JZUml0a3Bn?=
 =?utf-8?B?N0ovemM3NzZQZmIzemVRQTlDZGZ0eW52MG4rajRMQ2Qzc0QzU0Zwd3d5b2x2?=
 =?utf-8?B?NjlCNTNqUGpscm8rM2FxZXdZTyt1VVR2bWRESVhvRjlLd3ZLMmRmQmIvTitN?=
 =?utf-8?B?TzA2K05KclZWTk9pQTlsNVZBKzdOTU5kVWpzVks1S3NldWllWDZ2T25GZHRW?=
 =?utf-8?B?REY3Y0tHTUxiUFMvZ2dRdTNnNHhEMndvUFF1bHhjR3pIbUx6dU9SNnFBYWZR?=
 =?utf-8?B?d2hhQUJEOTBEVmlwZFNxeUt1aGdhNTJ5cGtzYno0aVo1S0tZV1BVUjBpak4r?=
 =?utf-8?B?bEdzWkV0UEduNGdkL3ZYUVUrc1p6L0dKZEIrYTFSQ1RucVRsR01WMEttTGNR?=
 =?utf-8?B?a0VRUEI0RExjeDdCUldzOUFYTUQ2RUxuTFRIVTd1c1VZVngrZ2oyakxTMHBK?=
 =?utf-8?B?TkFIQi93a25NNzhkdE93dnNUU0VVYjQ5YnNhblRDdUJldEpXQ09DUlI3UFI4?=
 =?utf-8?B?Y0VNWEFVUnVSd2toc0hmOXRyaXdBWGpNckNReHp1b2YzNFR4NktXNEFGR09s?=
 =?utf-8?B?b05VdVBMdmlzREZzdENHRzNRK08zTHdQQml4cERzem55SjVzdGRBcGNYNW45?=
 =?utf-8?B?MnZPRWdUMHFnODBXOS9ScE1MOS9KNmg1eW5INWZCbWFmSGM0dXNZa3RuM0di?=
 =?utf-8?B?SWtVOU5zRi9nSE9ZWmE4ekxjcmtBRXVaaFB4V3JYODM3b1JnVHhETmJPN05O?=
 =?utf-8?B?bG50VWYzRkh6ZXlQODY5TjFEOU13MW1wZWRSMTh1aWRJOVJ5QTNiRWRUeDJX?=
 =?utf-8?B?aEpCa0xLZGtYeldPN1BtcHRTcGJVai92WDI2dHU5Q2hpVXBlQWxmWEpWR29n?=
 =?utf-8?B?WmRORitueVo2QTQrVmhXak5GK2NPZmxTOTd0a3F6cmhHL0NJTUhIenZIcWFC?=
 =?utf-8?B?anVSVE5VNENuemNBNHM1ZGlweVJGc1lLUXlTK3hKN1U4R2w5SmczalkrOERl?=
 =?utf-8?B?blFGU0RQRjNMemJRMWRxSndrQm9sVm5HNktOY0lhclplQmcvZjhKb1ZrRGtt?=
 =?utf-8?B?TkplemFYYTlpaVgzeWZrTzRTTWRlUEp0OWlYWXJnMURCT3Y2WEhDODFUM2hI?=
 =?utf-8?B?UERYQzB1SUt4MStXdzgvbjVhY0o5ODdoTTRvWEU4Q05WZkd0Y1g4R1VLNXl0?=
 =?utf-8?B?eEN0ejFTQk9VK1cyanUyZS82OE9wTXM0ZnJKK1lYVlQ0amc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0crU0JpejNCOGpHTXZKN1c5WUtiN1dJMDJQc2hYc2x2OElEeWpIZFpZT3FZ?=
 =?utf-8?B?TlZzaUd2aEkyaGF3WWlTdzNFUHRNdmVaVTlzZkNxdnQrOHlJd3FYdHFSRWNB?=
 =?utf-8?B?V01NMU5OK3diOEVGM2tJOVFyN2VHVldoMDBBc0lyajRFczFzZW5FNDNoWmlF?=
 =?utf-8?B?UU51VjVYQUFyTUJOSDBaRTlMdjNnTGtYOVJDcjJ5VGUxaXNrWHA5TTZXTUg3?=
 =?utf-8?B?V0dkM0s2VFhlNU43WXY0ZmUrdU5rYldZVmpXWmZuZ3ZsNmlNSlc2R2pydmFm?=
 =?utf-8?B?dXRWSzVoM2V3ZDM5WWZjU1ZGcjc4QjNyRVVyMDJiTGlVZ2dnbm5sK3JMMEc4?=
 =?utf-8?B?LzY3ODlCbklMZTVuUEdFdjAwM1g5Z3kxb0FHdlpTNUhVNUduM21KR2J2TnlF?=
 =?utf-8?B?VFlSZGpDVk1oUHBWdExvSFFab3ZTOGNGM1RwSnJvbkR5WEc5OEtMVHE5ZWF4?=
 =?utf-8?B?b25ybzU5Q2doUlkyKzhySlA1eXJCQ3REdWNIYWxLaFgyQVM5WGRxcnBBS1Fo?=
 =?utf-8?B?M2Zub2tTaTE2ZTRRTk0vMzJUNkhiM2VqSEMreGFyRHVsbTdpK0VlVVRaRG9L?=
 =?utf-8?B?VXhnWmFjM0lUbHZxaStuL1NlQWFITitGYUFscVI0VzY4cUl0MENMeUFTZWla?=
 =?utf-8?B?eU9zU2tTOGhTRUpuTlhuUkk4OGtkdStINWtvUTUyS3lHQlp3SStEYkpMWXVq?=
 =?utf-8?B?eTVmUWZGbXB5em5VdkNtNG1kWTdxWkNQRUcrTWRYT3UxMHJadTJ6L3Y1bEJz?=
 =?utf-8?B?SnZXK3NYd2J3ak0vOVh6a3dzbzZPQjc5Z2VWNlN2NE5ZZDdRdklZQ3hOWkRV?=
 =?utf-8?B?eG55c0xXdUdTaGloVjZBYzdKU3VGV3BSQ2ZoWDJGWm9kQzdrd2dnVnkzbkQv?=
 =?utf-8?B?d0FHRHRDU2tqMjFONU9jQUtKcXpIMFRJaVhnRTdKZzAzd09pQ3hmOFlqMWxh?=
 =?utf-8?B?anNkc1lpcGhuWEF1ZTAvYXMyV1VEMzJ6c0tuellLM3IrYlNGM2VlLzNORWMz?=
 =?utf-8?B?T1RzYk9jZG9QdXI1RG1MYTRWNmF1UWhXWmdvMjZDbGtOandLeE0rZEdPNHZO?=
 =?utf-8?B?RE5oTkRqck9ZUUpxaktmNHpzdm90Skh2RDlCNjVmWkZnZ3lubUlsWXI5SE41?=
 =?utf-8?B?NnJDY1RENTB3eFZzSXV5R2ZnNmhlN0lBTDQ5bE1WL1MydW1hclZJUWVtSVYr?=
 =?utf-8?B?NWNsTmw3SmNBbjczT0RtQ2Y2ZEs5dUdWNmtmd0lWUlR4Wlh1OUhNa1psS0wx?=
 =?utf-8?B?aDFFdzlSU2ZqU2o0VEVURWZaZGJVcUxLWnZCbWhKL0puRTNUU1Z4ZFNLY21s?=
 =?utf-8?B?R2U2c1h3TTVSSCtybTNaYW5ycDRxZXdYeDlBa1BSUjlHZHFHS29IMG5aUWVP?=
 =?utf-8?B?aWtackU1TnF3V0R2R2RHTGpVR1dCeW45NWFBRG9yZk83ekFDdEJwRVQ5QXVD?=
 =?utf-8?B?Z2V5U2pFZFM3U29ZNkd6U3FRTmo5dC9XZ3lKeU1oTUpsY3c3c0ZFdW4xMi80?=
 =?utf-8?B?Wk9EbXN4MkhYNGI5YjhTMWszNDJkV3B2YytVUGx4QkVBaUdPQ0puL1BVMGVw?=
 =?utf-8?B?QWk4cW1uWlZVWEtaYkdLd3NNVU13bDhyZ0hLdDVTazV4WXAzcDdaS2p2VGVz?=
 =?utf-8?B?dDdMMnZSSE91UVNRY002eWhsOUhOQ051VVM0aUd3UW0wWmFDVVZncUQ4QWd2?=
 =?utf-8?B?ZElKdmYySTNDdmx0U1JuZGIwWUdKRDk5VGVGMStDbnhUdUZxSjErK3RQbjk3?=
 =?utf-8?B?TER5U2xxK1duVFVpSFJmbC9rZ0UrZTZxZlg0SHV6Ym1ZMFQ3R0U0RDIvQnZ6?=
 =?utf-8?B?RGdIcG5zVC8raWd6L3dsb1J1alk4VU9VNEhlZXFBZ25iYTdZbldJVE1ZQmFp?=
 =?utf-8?B?Q3Q1Q0VLYkZHRE9oTEw3OEFTL2VKcVhCLytiYTU0K3FyZUtsU0ZiV3hyaTNF?=
 =?utf-8?B?aTVTYW5RNDdFdlQwRVFWNU9md3VwL2w5WEg2aUZwdGYwKzJVdVFwWkJUTFJm?=
 =?utf-8?B?WEdKbGRUZXNDTmUxS1dqckpHK2FlVGlBc2dxOWFlVzRVYWNoOEVKYUQ4NTdh?=
 =?utf-8?B?c3dNWUpqZjM2aFVwcDloL0EwakpYWVplMkY2UkczNXNGeUxJZFcvZUQwaDJI?=
 =?utf-8?B?N3FDUFZKT3JJY294dDhmTW1UWDRsbFZFcGdWUEJ5a1RTT3hQZHF0TTZNRDRP?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbe8043-1c62-411c-0242-08dd5d332547
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 04:47:20.8078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDFcFB6rIl3hCyZcopbIwUEeSs5ivbWqSQmoUAN4hFajfCIuCueUr0GSv5UDcWMkkgtZEk+lGV0Uz6jdiOYOmYpbF4hSVpaWu0ApP4ZHpd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5961
X-OriginatorOrg: intel.com

Hi James,

On 3/6/25 11:28 AM, James Morse wrote:
> Hi Reinette,
> 
> On 01/03/2025 02:35, Reinette Chatre wrote:
>> On 2/28/25 11:54 AM, James Morse wrote:
>>> On 20/02/2025 04:42, Reinette Chatre wrote:
>>>> On 2/7/25 10:18 AM, James Morse wrote:
>>>>> resctrl_exit() was intended for use when the 'resctrl' module was unloaded.
>>>>> resctrl can't be built as a module, and the kernfs helpers are not exported
>>>>> so this is unlikely to change. MPAM has an error interrupt which indicates
>>>>> the MPAM driver has gone haywire. Should this occur tasks could run with
>>>>> the wrong control values, leading to bad performance for important tasks.
>>>>> The MPAM driver needs a way to tell resctrl that no further configuration
>>>>> should be attempted.
>>>>>
>>>>> Using resctrl_exit() for this leaves the system in a funny state as
>>>>> resctrl is still mounted, but cannot be un-mounted because the sysfs
>>>>> directory that is typically used has been removed. Dave Martin suggests
>>>>> this may cause systemd trouble in the future as not all filesystems
>>>>> can be unmounted.
>>>>>
>>>>> Add calls to remove all the files and directories in resctrl, and
>>>>> remove the sysfs_remove_mount_point() call that leaves the system
>>>>> in a funny state. When triggered, this causes all the resctrl files
>>>>> to disappear. resctrl can be unmounted, but not mounted again.
>>>
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> index 6e30283358d4..424622d2f959 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> @@ -4371,9 +4375,12 @@ int __init resctrl_init(void)
>>>>>  
>>>>
>>>> Could you please add the kerneldoc you proposed in
>>>> https://lore.kernel.org/lkml/f2ecb501-bc65-49a9-903d-80ba1737845f@arm.com/ ?
>>>
>>> Huh. The way that is indented means I copied it out the file - I'm not sure went wrong
>>> there. Thanks for fishing out the link!
>>>
>>>
>>>>>  void __exit resctrl_exit(void)
>>>>>  {
>>>>> +	mutex_lock(&rdtgroup_mutex);
>>>>> +	rdtgroup_destroy_root();
>>>>> +	mutex_unlock(&rdtgroup_mutex);
>>>>> +
>>>>>  	debugfs_remove_recursive(debugfs_resctrl);
>>>>>  	unregister_filesystem(&rdt_fs_type);
>>>>> -	sysfs_remove_mount_point(fs_kobj, "resctrl");
>>>>>  
>>>>>  	resctrl_mon_resource_exit();
>>>>>  }
>>>>
>>>> It is difficult for me to follow the kernfs reference counting required
>>>> to make this work. Specifically, the root kn is "destroyed" here but it
>>>> is required to stick around until unmount when the rest of the files
>>>> are removed.
>>>
>>> This drops resctrl's reference to all of the files, which would make the files disappear.
>>> unmount is what calls kernfs_kill_sb(), which gets rid of the root of the filesystem.
>>
>> My concern is mostly with the kernfs_remove() calls in the rdt_kill_sb()->rmdir_all_sub()
>> flow. For example:
>> 	kernfs_remove(kn_info);
>> 	kernfs_remove(kn_mongrp);
>> 	kernfs_remove(kn_mondata);
>>
>> As I understand the above require the destroyed root to still be around.
> 
> Right - because rdt_get_tree() has these global pointers into the hierarchy, but doesn't
> take a reference. rmdir_all_sub() relies on always being called before
> rdtgroup_destroy_root().
> 
> The point hack would be for rdtgroup_destroy_root() to NULL out those global pointers, (I
> note they are left dangling) - that would make a subsequent call to rmdir_all_sub() harmless.
> 
> A better fix would be to pull out all the filesystem relevant parts from rdt_kill_sb(),
> make that safe for multiple calls and get resctrl_exit() to call that.
> A call to rdt_kill_sb() after resctrl_exit() would just cleanup the super-block.
> This will leave things in a more predictable state.
> 
> 

Since V7 has been posted already I try to keep things coherent by copying this
exchange and responded to you there [1].

Reinette

[1] https://lore.kernel.org/lkml/053d8a62-022b-4bf8-8e47-651e7c3a2d59@intel.com/

