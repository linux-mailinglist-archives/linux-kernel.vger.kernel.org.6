Return-Path: <linux-kernel+bounces-514098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A59BA3525C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 00:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0FC17A1A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D02D1C8603;
	Thu, 13 Feb 2025 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5sjOAwo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF5D275419
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 23:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739490733; cv=fail; b=pHzZ5FZnK4IT1k5Qu+nUWstVaJIsfKwp5FYoT8w3qyy3lOX9kfOhnHhCtlTymegUBIQ9ZS61nk3c8WcqOv5tCfu3Bmgg61rp/GaqaU++OerCPBnjC1AP2HLklqF6IFJ4F4K0DE19vGL/CMXxe4lvKFWyFaAgHr+aGbeKmo9cNQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739490733; c=relaxed/simple;
	bh=4fsCZKO4EosiNdm2wjnZ9hpXYN0caTHT5qTVR6BgBBI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fK3VMYAjwMHvSbxlremq4XiZPtrbizIIuod3i/tAWUMfLYTgfBaPVnQ/qhz9KQ2fLL8zzUDWV8OdlSj+UH2IwYZosAPPeT4ttt7YSnz1VXH9ZFpAQfydGIEU1kLedTnz0bpTQ6lXnn7FRCE6lftywOJrTZyD5iRm2q3whfarJqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5sjOAwo; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739490730; x=1771026730;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4fsCZKO4EosiNdm2wjnZ9hpXYN0caTHT5qTVR6BgBBI=;
  b=c5sjOAwoftmCtb8vZTNre+Hxa3qhyrhZYBlWtFS9aCj7TCZ0pkbLpJ+9
   9g13GVOGzBoF2i51kO2BwLdM05ZA3K3IITfyR85Fjp3ZUIBLWACmMB+g8
   U+RuW+1Rz60ZPjK2LSItF32Sm2hU+8Jd/urQA5alxgFCqe0MJQbEB1dEQ
   VZT0oYG7VLyWRDoLtPXIiLpYz5CO8MSkBMgHiLX+CniGUTkxcS4NZ20GA
   66IQa5J95eExYeBhibFz/KDRtadpLmniuzTTTaTqBsUsPERFJQgz0iP68
   FOLhf3Go244liqW44KMGoq0SUkIzo685CsbyUt/eDyHNd7C2XAueG6ndY
   w==;
X-CSE-ConnectionGUID: //5V99kgTKGhHFhHAbrHyA==
X-CSE-MsgGUID: o/WoqGHATOm3CrQBmnvgnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40345652"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40345652"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 15:52:09 -0800
X-CSE-ConnectionGUID: ls7aWgM5Ri6h/yo0p/X+Vg==
X-CSE-MsgGUID: jKe+JHfLSx6FYgWC2cjiHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117915652"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 15:52:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Feb 2025 15:52:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 15:52:08 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 15:52:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0shm9Z/HdcZmTBpPRq2QcJAdph833osJFjP8ZMXrQcy2JzQGBqr89lkTnavrXdFZuoCMKJRWk8HG7/G6q7SWydMYNN3AX0AuVXQYQRpT4BQbLuInBvN9iQvKfGR0DOoqn2Dbvwl+sRq4ugvQdZAiMWjUo7YjByrRkfeVT3EHvUR948t2EUY+wYZjKIZ5PI2owF0dmOKTni8FoF2KFryJpsOT4u/rw5uhuOqpmlQFNd0GiXqO3WiVc5gD/dNBC+AWDErzMrUNHo//OMn6PSygkaTVJ4JQI0p6vajQh8l91ZV3GTKAV9TUXSr35B8VbCkmKQ5Uh6sO7EsQ2qMOUWKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+Qisgltyn09XMThUL5UEiI9f+6/ycY5t/Bkd0jD2/A=;
 b=ujBE7L8Y1PgEpusgCpsaOR/7KRmYVwik5RXHmGcVxNkcOjwG6Me7F5JddHo7BY1qXwP4fSXNjtPAOoonG7+8aXnJyzds/vwlRN/HHRGvr/wb0A6rqmQgt/+Mav2lbNi1cVuRyZqEoBji9zorKrXOxIVwJD9cIr+j6G0zqPBFbVhwoLRTqqJygbdbVqRillBWTrpXKaVvy3tvRt3n/TQcLHpYzPSEAIJ0MOeJkNlBGaYY296nqAiqo4cMNf4+5u8jVXw9fKHluQTmd94ikZzfkvhXHiJ9+lJbW1aErVVW9wLKDPxu9a7cpKdvnEV/cFZ1GQ5GqlebEvSJvAM+oyGDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Thu, 13 Feb
 2025 23:52:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 23:52:05 +0000
Message-ID: <04d1d72d-dd03-494e-b1b1-04ecddb94f80@intel.com>
Date: Thu, 13 Feb 2025 15:52:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/40] x86/resctrl: Add a resctrl helper to reset all
 the resources
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-15-james.morse@arm.com>
 <a0ed3b9b-c035-440b-8244-7e6a5c4009c9@intel.com>
 <55dc287f-1277-40fa-9d68-baf6393beb3c@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <55dc287f-1277-40fa-9d68-baf6393beb3c@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0363.namprd04.prod.outlook.com
 (2603:10b6:303:81::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5c31bf-9d9d-41c7-964f-08dd4c896b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTFSeEpiSVE0UW50VEw2OVl5MmxIVUt5RFR2SXE1TmRvUmFEYldmbjhuRGN5?=
 =?utf-8?B?TlI4cENRREpGbEptTU5TT2liM3p1R0hmeXFyTjVEeHhFQnVSWWxBMTNSRmJi?=
 =?utf-8?B?QWx2bjhlanI2eXlXcjhaYXdGZXhUTDZMa3A4M0MyREQ5Z052V3BBQUQyZDll?=
 =?utf-8?B?VVlWbGpCNVdXNThoUFA3SCt2dk1NbERNUWE0NUt4WGNKUHFkNVZtbWZ5MU4w?=
 =?utf-8?B?Y0t2a1E3OVJqdUdhb0VzZXFEQjNreGF4THZnNEpXQmJFNVY0Zkp4cEJwY3h4?=
 =?utf-8?B?cWQzNlpvR1U0aUVxQXFaeVpGZlJJaG01b1VPZTJTOHRLejdrNlJTV3FRYW5m?=
 =?utf-8?B?ejJXVlBDd01yMlVObnRDSGdhVWtNbHNvcUxiWlB5WmwwZ3RubUo3ZFJBYkZv?=
 =?utf-8?B?eGhqN0xYRHlxY1pmNncrckVXSnFaZk1KTjNRZjB4VXgrc3FXNlpIWkVhZVN5?=
 =?utf-8?B?cjJ5V2E4K3lsalZnM3V3K2tETVVkN2VwSk9NQjNRb2NlS1JzcHVrK2w3NzBF?=
 =?utf-8?B?TnJqTUpTWTVRY2c4N0ZiWVZoQm9tUmlVdjF6a1F6M2ljaGpKRjVLekFKc2ZI?=
 =?utf-8?B?eG1nWVkwaFhDSDNzZzVEd0tCNUxYMEFYZml1U3YxWlJBcG9jSWp4UjI1QVVw?=
 =?utf-8?B?bGliTkZtNEhiaU1aWjJQazFMZFBKQnZDWUNmRUhmMElNZC9YMHhrcE85M2U2?=
 =?utf-8?B?UlFoVlRWem85YS83UER3cUFUY2s1Y1JpVVhoTW9NbmpYV3lVWUdkZjhUdkxp?=
 =?utf-8?B?a0NMdDZXSG9QS1ROZ2JaUDRzcTFOOWRWRUFPRTJhUkFib2NTUU1Cb042Z0xU?=
 =?utf-8?B?bDJlVlJsR2cyUzBkZWJWd3NzR091bG0raTB6d0pVODBZdmRYS3VTbEp0NkFl?=
 =?utf-8?B?d3lGUFlLeUJ0MU16WWQxclkzeTByVTRua0E5d2NjWXdLZ0NhVzRvZ2QwR2RN?=
 =?utf-8?B?TWZ4QzNBbmlqNzg2UUhpbWpIVzBodXlqVWY4a0ZidnVBNjBEekZUTnRBYlI1?=
 =?utf-8?B?VTRvNE83VURCRXBJT0R0VXJuSDdLVXIrejk4bmFwdGZ5bU5vK2dES1g1ZS9O?=
 =?utf-8?B?ZXZSWlE5TlN6Q2hVRUJUMjhETWc4QVNlQ2pyY29QMXBPM055RDFxaXpYQnZY?=
 =?utf-8?B?RzNUMldmMEROM0dzNFZTNWFjV1RmclZ5M1ppdVNpOHFGMkM1QUJVdWhLNkIy?=
 =?utf-8?B?SnhxSHRJYmx1ZWx4VWh3dkp4WlduVDZ6WDZZaE5nZkV3UzJQSDJqampXdkdq?=
 =?utf-8?B?eXhuTXVxbWJEeVB6ZGJHcG1xclVTbkJKcnpMZWdZcUZTSEJscVA4Y2ltUnNH?=
 =?utf-8?B?eHNmME5WN3NmTyt1dU1tK3NvZDZzYTRUMXh5a25zZE9EdnhIWnJEMHhpRTA3?=
 =?utf-8?B?VWRydStEeDR4d01yaXo5V2xkUjBZQU5EdkN3cUl5clVTS3VibWUwSVhic0JS?=
 =?utf-8?B?c0psekd3bEdiejhwSHFRMUJMSUtPcTFqZEdJL1pHYTNxVEZSdUttUFBnMEh1?=
 =?utf-8?B?aWZPemc2VTdSMldBZVZZL0k2QTlrcTF5N2xKbXk3T3U5bXBzc1JYWDVwMmlH?=
 =?utf-8?B?WVUxL3FGSUlNY0FtYjY0WEhIQVh2ZU1wUEdEbHBmR2RjZkVYS1FKYVRHQ3FQ?=
 =?utf-8?B?K0RMNmorT0VvMjN6Z3gzazdRZlJvcUxzWSs3bmxHSHBpRFlUQy9TMU5ScFJu?=
 =?utf-8?B?ZUx6Q0pLRC9MM0Y5L1pweTlPNzIvd3U4aWpSc3JWSXg0M1dlNDdUSzFoV3Vr?=
 =?utf-8?B?SEZ4S2xVRnBVdHMyTXBneHhtVkpXQmhraldGSDdqRStVQkRjQ1FhVlV6WnVk?=
 =?utf-8?B?QkkzaThuVkduNGFIcStJTExZK3JpUVEvbDlKRE5QOXI2MWZqamFqUWUvVm43?=
 =?utf-8?Q?a7CvNTiMgn49k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDNnQzloWEdxUk5FOU51Q0ZqWW80M1kvelNWRmh2eWFrVUdnUHBPZUtmMzhx?=
 =?utf-8?B?QUJyRkZFd0hSUjRVd2ZHRGNsMndYSkJVVllMSlErZ2ZjeEVPbXZzb01qQkpR?=
 =?utf-8?B?eU1SNUx4N1ZVWmFSMi9vZVJSdXJnRXRMeTBMQk0zZlR3MkZjSXhIRTVZMGpM?=
 =?utf-8?B?VkQ2Ykk5QmZRSG1xS2duVDNjdXdjUnAzb2Zsb3lvU21INWt1RmV1KzRtT1FH?=
 =?utf-8?B?YW9yTlN1UGo2NlNVbmdnTHEyN1hVdFNmRUMyVDZUMkYveTVwYytYSzFydzFP?=
 =?utf-8?B?aHlSUDFOOGJOTmdEWml1WXUzZElscitwS245U3ZQT1RPbnY1bDE0YWMvNGNT?=
 =?utf-8?B?bWFLYmk1dFdMSi9wckVmVk5taTdjTndBRFZ6cktTdzlqMjlIaHlNeDFHYU9T?=
 =?utf-8?B?M2R1T0w1c21oTk9pMjFqOFZ4VXFmTStJdHhzeWpvRHlNLy9GQVZDOVdFV0Fo?=
 =?utf-8?B?ZitOb0lYYVM4RXNDVE8yR0g5MTBzTUl5NFFGbzBEMGo4ZnhrZjM1eDMzUlBJ?=
 =?utf-8?B?MGh5Q1RtNndvR3hYSnEzcG42Z28reGtmKzNtVXZTZVdWdUlneE9WdUxUWWhL?=
 =?utf-8?B?bFJueGZDeXFZR1FMRjFHeHNhbkRiOVlUaGhwK3NvYkttUWljRnlNN3N4aktO?=
 =?utf-8?B?QkdBUWpTNnBCSU9JZWdSVzlVVC9zMTFJUStGUDlidUxQS3NGaUQ1RjNCcCtQ?=
 =?utf-8?B?WWc5OStJUUNxVWVaQUlSSlA3UVdJMjUwa2lkUkZCdmRwS2ZkMzdBMGRrTjg0?=
 =?utf-8?B?amp2cE9yaHhlU2RVQTR5UWlzQmJtY245S0NPNEE3T1YxMlQ3UVlkdTU4bHl5?=
 =?utf-8?B?TzJoeXBLcm5Ia2RkNHNVd1VDL3l2TzF0clFoUDV4QUFrUnlaV25LNVB2TGow?=
 =?utf-8?B?eHkyaWVNMFBJekNrbmJFc2RmR09FbHlnZklqZ3B1YTZ3Q3JQVVdPRm9QblBm?=
 =?utf-8?B?dWpYVCtDVmVaSVJVb1Z1TS9EUUJxYjZ0aFliYzBTREJYTmZraENOOG5mRi9i?=
 =?utf-8?B?bjB5RmdlcUJVL29GcVNaK2ZuZ1pKWm40ODhtaDRYQjVUWnpaYnJCcE1PN1RI?=
 =?utf-8?B?L3ZaYnhTbU5JTWZpMHRCZEk0YjJRV1RES0tJNWpZaFFTQmNCUkJ6aVVqd0hN?=
 =?utf-8?B?ZldDTFpDSCsrRDNFYytLOXNSVzhaZndUUElORFFqb21IZDNvZUpjNFVKTUNJ?=
 =?utf-8?B?ekhYQ21MVHdBMW5FWVcxVEN1bTNFUlNUSStjZ3k5MlJvU1JSV3FyZ0Zqb09m?=
 =?utf-8?B?MWUzY0F5bEN1WDcrczBOZmdncEI0aWEyWDI0R3ZUdndPNGlPM29Kc2xvaXlO?=
 =?utf-8?B?eXZPUy9PMEt4a05LbUdQRkRKbXZnRnFua0NuZ3B2UURZTWtlYW1tYnFOU0Jo?=
 =?utf-8?B?NXFESDRsd0ZLS2ZrZXIxa0hobDNnZStWK240U0l1d2xiL3c1dEYxcENkb0Yr?=
 =?utf-8?B?NVVzUGlRcnE2WC9hMTA4NjBJelpLTllKZCtXLzJLZno0cVJOTkgxbVgwNm1s?=
 =?utf-8?B?UWZEOTU3ZldGUko0WmNybzBxeDRjemVsK1lqQjFQd3Z6UU9LMUozNEFmekcy?=
 =?utf-8?B?bEF2MGZjK0RTdWljeHhqOW9Yb0tBN2gwbTdZdzRuaXQ4UkNTSXB5SHJYMTN2?=
 =?utf-8?B?NFljb0V3akR0blJVb1N0WEVzeEg0MlNOeDJMYy9nVHhxamtDSUJrNVBUMFNP?=
 =?utf-8?B?Z3VCaDdQWGFNdlRsZ0F5REhHMmc3K1poQzFsWEEzUE5nQVQvdi8xYVpzTGxo?=
 =?utf-8?B?ZVd0dHg0cHlxNWlDRHY5TlJNbzBRTnhLQVEyNTh2WVp3d29VTTUwcVNjTE14?=
 =?utf-8?B?Vk1jYnh5cjd1QXM2c3JJZm1OeHo1WnlSQ09zRSsyd0ZIbDUwS25YM0RQa0dq?=
 =?utf-8?B?TVJudEpiUEZVOUtyQm9rZGpWTnRibWo5Q1lVcW5Tb2ZBdXkzL1I0cHAwK3hN?=
 =?utf-8?B?amh4R2o0WmJRZDZHbnJRcWg2enRUL0lzSUFQOEZPSm9FdFRTZ1hLd0t0T21n?=
 =?utf-8?B?eFRwQ0VwL1ZMRDQwT2FZT1BqWkpWM3VDa0NVcWNuc3R5cWdwVjFjUzhXM3Ju?=
 =?utf-8?B?bUJ5eEFUNlY0dFg4SU8rVVZzQkJFZm4xY0NkNlQ3YlFNNkhRUHBXWkpMOTJX?=
 =?utf-8?B?YVpCOGxxTThtczFiTTFvM1VNQlZLY2JkdnM1c2svODZnT0FpS0JxOEFLU2Zu?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5c31bf-9d9d-41c7-964f-08dd4c896b96
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 23:52:05.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Be+Z4raEWhtqev27qyMGTXcc/W3jWCM2kb/vY3JLHPw3+jeLiEl49cMQknkInOpP/79WFN1LpW9fdtIzOqy0p6oGZ8jBHvATw60H0Z8fKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5192
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 7:43 AM, James Morse wrote:
> Hi Reinette,
> 
> On 23/10/2024 22:32, Reinette Chatre wrote:
>> On 10/4/24 11:03 AM, James Morse wrote:
>>> On umount(), resctrl resets each resource back to its default
>>> configuration. It only ever does this for all resources in one go.
>>>
>>> reset_all_ctrls() is architecture specific as it works with struct
>>> rdt_hw_resource.
>>>
>>> Add an architecture helper to reset all resources.
> 
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 61c8add103fe..a15198f90b29 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -2883,6 +2883,14 @@ static int reset_all_ctrls(struct rdt_resource *r)
>>>  	return 0;
>>>  }
>>>  
>>> +void resctrl_arch_reset_resources(void)
>>> +{
>>> +	struct rdt_resource *r;
>>> +
>>> +	for_each_alloc_capable_rdt_resource(r)
>>> +		reset_all_ctrls(r);
>>> +}
> 
>> Wouldn't this require all archs to have a duplicate helper as above with
>> only the resctrl_all_ctrls() actually being arch specific? 
> 
> I was hoping to be able to save a few IPI by doing the per-core work once, instead of
> per-resource-per-core ... but its only done on umount, so I doubt anyone will complain!

This is very reasonable but that is not what the code does today and the
helper is added to today's code without providing insight into future optimizations. It
sounds as though MPAM was planning something differently (better) for which the helper in this
version would be appropriate and I expect that x86 could also benefit from that. I
understand that this is not a "fast" path but it raises the question of how optimizations
across archs should be handled. Ideally we should look across archs for ideal helpers
and not force one arch to adapt to what works for another. I am not advocating for a
change to what you submitted in v6 but instead would like to share that I think by not
having a discussion before switching to new helper there was a missed opportunity for
both archs.

Reinette

