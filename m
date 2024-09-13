Return-Path: <linux-kernel+bounces-328877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2049978A3C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37BA1B218CC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EFD148855;
	Fri, 13 Sep 2024 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VUTwEIOq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DDD6E61B;
	Fri, 13 Sep 2024 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726260703; cv=fail; b=ACzHwUpPNookeptl1W96z7PDyXQ8iULU3ygJPdIWzkad6kKJi4rBJ4chwPB/NtavsRTgk3kdeutbjsXPMccAmrHk4y12STZXtWCfadM7bBI9k5VKnALZyd8Z+45PVl0239CXcVGcpw04IrfkBE09faRTJseVtqadVJ5ReThsq4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726260703; c=relaxed/simple;
	bh=Uey1tw1sI7YPYO1wdIsSfrLMtQM6Q6lSzvzPmCYOkXM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PBrQSdnEQBNKVLUAO6fiVZ88ejmwqJ2zed+u0XEG7FJWMyenrVrohjJn1g1WmsiRYrFnfo+DM4xfPUJR9XoM7xm/aVnGpBxyOiDbuwO73rahe8f8luBwKm4AkA4NzoS08MsLNqwDlhokEj90JNWN5j721qnbzvw2yxjm88K70bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VUTwEIOq; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726260703; x=1757796703;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Uey1tw1sI7YPYO1wdIsSfrLMtQM6Q6lSzvzPmCYOkXM=;
  b=VUTwEIOq21l4nPcK73x8UBm9xl0wONpztG0twe98oDgFGqSE4f1KrXm0
   n4GVr/KP6bepi5R5w0DXi9FiQiGW+9FBxIf2/Oyf6+1ONvuWd/E2UdbQn
   cLXDFzeX3KhVy030+LX0jMUeOU6xjLXcpY8ZOni6A/GgqIL3HINE02Zdn
   rgEJLZq1MB5hbfFulOP9fHS5AFFn6ZPERO2jifVlPK0IJrOZKEWir+iOU
   mjWfC9BWd4NcyNn6n1tRDx0N2uHhxidUAxyfhF6e7Ri0qu6FbVsvz7DpH
   lT53XB3ULDFcCMQhhgdEvqO9JCuZ2QtUVU6jezW4wlDN8n7Gmkm0FnMwB
   w==;
X-CSE-ConnectionGUID: QWID6OSTT5q+ylj0f35TCA==
X-CSE-MsgGUID: YsHUVYqKQKG3K+Da0UnpIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="28921990"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="28921990"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 13:51:42 -0700
X-CSE-ConnectionGUID: 7c7wq6lsR8aNIlQel/yCqA==
X-CSE-MsgGUID: xJfhuKJ6Qzi3BenB+Od+HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="68055154"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 13:51:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 13:51:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 13:51:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 13:51:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQAAl14YGEV7kv1HsbKp83K7kgBHS87lZs/YMvUNlR7NAMn5hCtS5sUnThvaNU302dfDZVKQroEzQTgFztQtrlyaa3LVsvpYxNn7bTjH3zu28zGi0rkKY0eMku4TJtT7uCiaUiLsLN38grV4QxPFYN3QQKhKqfHeqLeCny/saXTBqe/4E8FQ36ypK81EYivDaKGzlHo+lGKfKICsiQ8aMvpVDR3apYsyT4OMih5HNxiT86+TTY0k5P2RZVQMNbmsll7AL2C7OPl6595srFWcYdQoH0/lpFeEWVb4qyK6zLjBey0yzGLZT3mbyt5aFSWX568EMsjkFMEc/ZO8KTp8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8Jk3x+usR0nAqOeALP+uufvhe7sX5prOOIrZSmvzzs=;
 b=PwWQ5uNhYlfYRQLStiTQ5gPllU+QMTm61lI3v6UWfUVQYOhmjU2UnmUHBkUzT9yNLU87Rb6tsXZaczaTwyBvwCHdIWtfCU27H32uuhNo39vyfk8BBMoFEH3rPlCdFceNmzJivQwhf6UGMQDFQI1C2cyV/b1MBPI1ke36p6qCerx3jtGIKaPOZkQmo/V0uljqq8cVmExgyp6C47Db5UoZVxUQf++B053Lp1SxRYo+ML1zAcR8H0St2e7MvI7rqL2vuEp6ai1IW+oyCnyyowEuQDaLOiWz04NJZe31Uqo78JeFpk88u8vZZxxbkkovF7VYM59xEV0117L8kZeXMG4Esg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8604.namprd11.prod.outlook.com (2603:10b6:408:1ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Fri, 13 Sep
 2024 20:51:37 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7939.022; Fri, 13 Sep 2024
 20:51:37 +0000
Message-ID: <cd0585f6-1d90-4ef1-9a10-7db50cb879ea@intel.com>
Date: Fri, 13 Sep 2024 13:51:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] x86/resctrl: Add interface to enable/disable SDCIAE
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
 <e43947374dd9124ef5a6c677d0ec3ab715b6a7e7.1723824984.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <e43947374dd9124ef5a6c677d0ec3ab715b6a7e7.1723824984.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV3PR11MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: f86ec910-c121-4b14-4571-08dcd435dbff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVI4N2VXa1lYNUlFQnJKQ21lWVlIWWxIcDdrRHkrSEtuaXA2clBXU1R1WTRJ?=
 =?utf-8?B?OWt5dmpyZHNYYk5kTnRELzBQVEtud0tKWU51UHlxV1gxUm9xY2N3cXdBVDFs?=
 =?utf-8?B?MS84bGtYMlBzS0Z6a1J2VVRkekdaUmxoOXVmN0hUL1ROd0NSbmRURXZUWkxN?=
 =?utf-8?B?TmU3ME1JQllpSlUrVkV3VEh2bFI5WTJVQXNyVE9qV1ZUMDh6V08vNEtFQThH?=
 =?utf-8?B?SlVnSHBDRTFCd0dhVUZLZXUyUEZLOU5zVVZsLzZOd1FLaVY0a3dxTEZsWmJW?=
 =?utf-8?B?ZE9zVlZqYUdtZXRZekxVcDRNMFNRODBrVTJEV2VNdis1QXdUMCtCai8wbWxn?=
 =?utf-8?B?RXh1S3IrYUVmOUZNcHFHa0RHVi9ZRmVjSjNhdUdiem5NRXk1d21zMFBIVGNp?=
 =?utf-8?B?WnBpSUE2UzZtd1ZxdEpKYmJmMkFDM24vYk1GSVNCLzBHZ1Jxdkl4aVVhNFBs?=
 =?utf-8?B?UkZuMHVSWU44M3NBMWVISWI5VWtrYytscDdNaEVBK3Q3TUdLWVhETVBFRS9V?=
 =?utf-8?B?UWtyRjViNUNvT3BJc0lWL0FySHZXcGdHa0tSSkpuUmlDNGVzUFhsRUg4QkdM?=
 =?utf-8?B?bUJDa0Mzc0wxNWpMZ1MxcjFaWVZPRXBzc3U0M3E5NklhVUpObmlFYkcvWGFv?=
 =?utf-8?B?bGRISWJ6Q0QrcThCMHJlbXVNWWtjdHF3b3ZuQ3ZUYUdDQUlhYytXZk5PbFdl?=
 =?utf-8?B?cEVlbGJhNEFMWE84VzZObEkzYzA2YmpJNWxabWxVWG5xYytIekRmTHdJMnQ4?=
 =?utf-8?B?VnJrN3lPc2E5SkpNRHVBWGFhTXZ3VnQwZ3gyMUJKS09aS2RsblQ3cWU5V2FH?=
 =?utf-8?B?dUd4blV0MnVucnlmT0ViSHpOSUZ4Snh2NmE5ZjhqTWxoQ1U0cmxqTEZ1eUhD?=
 =?utf-8?B?M1RDcTc5YXFqM01UQXhkbDlkOGdyVUhSdkhJVWE4TzFGdjdZRFJTVE43akdY?=
 =?utf-8?B?STNvRDZSc2NSNi9EK1lHcDFrNGVUK0JXOFBFamRHemltNHpDRHp2eWlpNEVB?=
 =?utf-8?B?b1kzOEYrWjVCM3NGZS91c3Z0TkpCbVRSY3BVZVBZcGR1Y1lrSUUrVTVGam5t?=
 =?utf-8?B?VUU0KzZIWXNJQkhpUHBINXRZTkMvTm01R1FLZ0VoRjhaaFFybFl4Sm1WMEd0?=
 =?utf-8?B?ZWdMTmdDR0N4YmE3YXBUYUljWVh0RkhPSDB3b2x6UmJCUVZPRUVWNEdPL1p3?=
 =?utf-8?B?Sk9wbjFqbWRSdmJRdFpvS0RpdUVqMnlCWXJ0VzFLU0U1TFV2QmQ1TzAzL1hz?=
 =?utf-8?B?YXprUktubmd5L3dTZ3FWWHlMN2xUV29BN2R2Zk1sNmxjZUlqYjlpNXMvTzFF?=
 =?utf-8?B?Yk45Y09KUzQwdysvRWxieStpZlh4NWVVM0ltODVDRVVGUmhtUjIwVmgxUXNU?=
 =?utf-8?B?T1dUKzFHV25wMERHbDBUcllET3dsNFEwRFVoNURHUEd0OGRKSzViNjJFZGpK?=
 =?utf-8?B?NlZ2d3A0MCtmcEVJdHNsOFZEREUxZnBocnVTczNmMFZNTjNrcHVJZkk4bzJT?=
 =?utf-8?B?aUNDV1VyaXlzODF3T2pBbWlJMGhvNWwxVjBZZmcwK1lsd0x5ajV4Z1cwVlN3?=
 =?utf-8?B?b21xRzBkZ1dDNXlRMU01blBTdjRYZjNFSE52WVZxMmxqQ3JYRlk1YXhBTVRY?=
 =?utf-8?B?SGJYaE93S3ZGK3dRUkl5ZG1YYkdENERjK2FpYXo0MjRPT2lMays4WEJ4WG9a?=
 =?utf-8?B?OC9iTUxJZGdiWDU2dE9OenZqZDF6WmUzdFMrV1JFWkMrZHVlS1UrNnNOVTZr?=
 =?utf-8?B?S2pwUGppcmJXdTBBVWQvT2hzWmE4ZUFnMDBjZDBZYVhneHB0U3ZrMzM2YVlP?=
 =?utf-8?B?UkhJSi9DeFpGK3ZLUG4rZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGRVeXFrM1pRYWIvYzlGUjlIREFlcmRlMjRzYmV5RktScE40Y1VhQnN2SlRU?=
 =?utf-8?B?NGMzRFdoNlVQQkhDVmdweE9XNldhdk52QjlEK3pzK3VTczFhcHBBVkExckQ5?=
 =?utf-8?B?dU03eEV0bVJ4VXlrbmhJdHZueWxNTkxjZVZ1bzZFV2RZdm1IaTZsbHlwNEYw?=
 =?utf-8?B?VVhxNnN6eHA2ZjhvSm9oLzFXMzFKM1JJeXdkYmRhVzIyMW01MGozclN4Y2lz?=
 =?utf-8?B?SGt4L0l1SGxTR3RXT3V2alMzaTNtbkF4aUtuV2xlUDhqcENZeU5WRGpwbnQ3?=
 =?utf-8?B?ZGdiNjJVWkVGWDZFNjlhWXpyQ2VKM2lJc3dlT25NZTRvUnJ0OE9HNHRXUm03?=
 =?utf-8?B?RktCdi9Vc2t2bzhGT2ZmV3VFR3RQRkE0R0RWd2UwcjdKNzJOczJ4a2I0NCtx?=
 =?utf-8?B?V1Bud05DNUthLzRtQWhuTGVXemFDWWhEa05JOUxpc3M2NHBsZzZWd2xVR0FD?=
 =?utf-8?B?YmFIZjM4emlxbDhUeDBxSXJiYzM5QnhzZ3d0bnNXR0JKT3dJNkZsckZsOGdS?=
 =?utf-8?B?REdWMEZRMWFKSzBzUVZIWG42RG1hSDJLcytjRWFVeVEvNGNMb2h4RThXY3pT?=
 =?utf-8?B?UHdMczFhcXpPQWM0M3NiVUE1MzQ5aWQvV0xXbW1qWi9sRFdnS2YwQzFQRmJE?=
 =?utf-8?B?aEV6a1BXUG54My92dUp0OG1HM1pESFpweXdiRSt3N1k3NnBBcjcrc3JtWWhC?=
 =?utf-8?B?dmJHZzJGeDRieExaYVFtNGRZbXRDWGJPUDg1WDdDc3dzRmxZY1ZrOXZiaENy?=
 =?utf-8?B?ZzllMDBmOUp3R2hYRXl5a05PU2k2UDZZRWxra1l5T2k4aEUrRDlDdElHaGxz?=
 =?utf-8?B?N1hyRFNWRmd3RnAxbUFoaWoyaGFPcmdDVU5qMkpjVzRvaGt6em5Nb1FLVnN4?=
 =?utf-8?B?bHJudHdZdEc2eldrOTZHMHZwelJhcUovcVZCYlNwUko4dHFFN1pUMFZ2VkNa?=
 =?utf-8?B?VGJSMDhCa2VCbFM2ZWZKNHlPYUF0cTRYSEdENE9iaHFyZzFKQWVBZFBkY0FL?=
 =?utf-8?B?Mk5zdllRblRRQ0xSVkk5bndFV1hEcEdWY083a3NxTFJXRWduNXQvMG0rMy9Y?=
 =?utf-8?B?R1A4U0tnT094VDVSK0FrRjZhT0gvQmk2N0hVc1Z6RVh5cE1OOTBRK1FHRVFB?=
 =?utf-8?B?ZlRoYUhKQ0NLOEFYLzdBNkdUZTBnVlFrY0p6ejZZODZZbXArSmNyeFA0cy9k?=
 =?utf-8?B?TzNiK0pzZWtxSnlEUUdDOFU0azJ0dFZlTXhwWVU5ZzBUS2ZXcHFYakdQdm5V?=
 =?utf-8?B?MkVwNmJZeEk3VEdSYUZhVGlRUUNCcmxTdUxWYXNvZmtuaisyRUY3dkpyUVFY?=
 =?utf-8?B?ZmlLNzhRMmhrZFhlY3VScEFpMEF1aTM5VmlBSUc3TDdYVWNOZ1Ftc0cwdmtT?=
 =?utf-8?B?UGtUY1J3aElOc0pzcUIwemJSc0QvYUp6cGtJMCtjWUVuOVJ1V3FXWmJGYXkv?=
 =?utf-8?B?d2w5ZTNSVlRvTGdsdm5WK3A3V0NDbHVLYmFJOURpdEFjMERQTjZSMWoxRDJF?=
 =?utf-8?B?eGhDZDhsZDN1c0xYK21pSitZY1ZQM2V3N1pYQWdCNTZPNGdoTXlOSWIvQnJz?=
 =?utf-8?B?SVArU3NoaFV4Z3dReFpYZmVYRW1zY0VWc2d6dWc1eDdycG14WjlWcU15My8r?=
 =?utf-8?B?L05TZTg2azB3cmg3VkJsUjZ4bEVMNThiSmtLTW02eTJ6TEJSWkdhQkV4UjUr?=
 =?utf-8?B?b1J5L3JHUkk3SU1oTXpFYUVyZURNbGNmM1N3MzF6VDVBdVFnQ0Jnc1JQK2RJ?=
 =?utf-8?B?ZnVGYzVoNTBTMFFZQ0ZXd2V3c2x2RVk3dUNsenZTTDZNcEcwaDl0VEZtQnps?=
 =?utf-8?B?bGR2TlNIRGhRL2lPYjJMc2RTN0p4bUZHbGxocXB3TWxtS2ZMRTBpVDRUbkNl?=
 =?utf-8?B?R3hWSkVITXdxK0V2cHh6cXhHQ1pEeTNGMCtWR3pscWpGS2JMUVF2VWJVNlNr?=
 =?utf-8?B?bmtCdWc2Vm5ET0xBNzFuQUx5ZmVYbTdjM0M1S3E4dHpXUW9hcHdZK2Y2RFBN?=
 =?utf-8?B?SVBxYlo3YmZQY2lCU2tvMTB0cm1HTnEzcjByQmxlbndzb0R5TTRZaUJ1Tmhr?=
 =?utf-8?B?aEtBbEU2V3BIQkVkOGhxdXYwU1BsaE9YU21aTVBxV3VSRVRBdHB0ZEVURnNm?=
 =?utf-8?B?dHZwQ0xFM3pHWXlPSEVBd3d2NEF6VVU0Y05kWllwM01rZHlRNFdWOFFPaTBF?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f86ec910-c121-4b14-4571-08dcd435dbff
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 20:51:37.0437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQF66hpYzoOU2K9OtiBE/q1s9jnX6JjO8NQHe31l6auK8ASbmeulo8Nrg5r+RLp35/w9wIGHDgV+pQ5eS1n5H/LZFrvg8EhAYMiNtulgvXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8604
X-OriginatorOrg: intel.com

Hi Babu,

On 8/16/24 9:16 AM, Babu Moger wrote:
> The SDCIAE (SDCI Allocation Enforcement) PQE feature allows system software
> to configure the portion of the L3 cache used for SDCI.
> 
> When enabled, SDCIAE forces all SDCI lines to be placed into the L3 cache
> partitions identified by the highest-supported L3_MASK_n register as
> reported by CPUID Fn0000_0010_EDX_x1.MAX_COS. For example, if MAX_COS=15,
> SDCI lines will be allocated into the L3 cache partitions determined by
> the bitmask in the L3_MASK_15 register.
> 
> Introduce interface to enable/disable SDCIAE feature on user input.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>   Documentation/arch/x86/resctrl.rst     | 22 +++++++
>   arch/x86/kernel/cpu/resctrl/core.c     |  1 +
>   arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 88 ++++++++++++++++++++++++++
>   4 files changed, 112 insertions(+)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index a824affd741d..cb1532dd843f 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -135,6 +135,28 @@ related to allocation:
>   			"1":
>   			      Non-contiguous 1s value in CBM is supported.
>   
> +"sdciae":
> +		Indicates if the system can support SDCIAE (L3 Smart Data Cache
> +		Injection Allocation Enforcement) feature.
> +
> +		Smart Data Cache Injection (SDCI) is a mechanism that enables
> +		direct insertion of data from I/O devices into the L3 cache.
> +		By directly caching data from I/O devices rather than first
> +		storing the I/O data in DRAM, SDCI reduces demands on DRAM
> +		bandwidth and reduces latency to the processor consuming the
> +		I/O data. The SDCIAE feature allows system software to configure
> +		limit the portion of the L3 cache used for SDCI.

Above needs to change to a generic resctrl fs feature.

> +
> +			"0":
> +			      Feature is not enabled.
> +			"1":
> +			      Feature is enabled.

What does "feature is enabled" and "feature is not enabled" mean to the user?
What can the user expect to happen after enabling/disabling this feature?

> +
> +		Feature can be enabled/disabled by writing to the interface.
> +		Example::
> +
> +			# echo 1 > /sys/fs/resctrl/info/L3/sdciae
> +
>   Memory bandwidth(MB) subdirectory contains the following files
>   with respect to allocation:
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index e4381e3feb75..6a9512008a4a 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -299,6 +299,7 @@ static void rdt_get_cdp_config(int level)
>   static void rdt_get_sdciae_alloc_cfg(struct rdt_resource *r)
>   {
>   	r->sdciae_capable = true;
> +	resctrl_sdciae_rftype_init();
>   }
>   
>   static void rdt_get_cdp_l3_config(void)
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index ceb0e8e1ed76..9a3da6d49144 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -662,6 +662,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>   void __init thread_throttle_mode_init(void);
>   void __init mbm_config_rftype_init(const char *config);
>   void rdt_staged_configs_clear(void);
> +void __init resctrl_sdciae_rftype_init(void);
>   bool closid_allocated(unsigned int closid);
>   int resctrl_find_cleanest_closid(void);
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index c62d6183bfe4..58e4df195207 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -171,6 +171,27 @@ void closid_free(int closid)
>   	__set_bit(closid, &closid_free_map);
>   }
>   
> +/*
> + * SDCIAE feature uses max CLOSID to route the SDCI traffic.
> + * Get the max CLOSID number
> + */
> +static u32 get_sdciae_closid(struct rdt_resource *r)
> +{
> +	return resctrl_arch_get_num_closid(r) - 1;
> +}
> +
> +static int closid_alloc_sdciae(struct rdt_resource *r)
> +{
> +	u32 sdciae_closid = get_sdciae_closid(r);
> +
> +	if (closid_free_map & (1 << sdciae_closid)) {
> +		closid_free_map &= ~(1 << sdciae_closid);
> +		return sdciae_closid;
> +	} else {
> +		return -ENOSPC;
> +	}
> +}

How does this interact with CDP? It seems to me that the above would
cause overflow on a CDP system since the closid_free_map is sized to
half of what the hardware supports. This also seems to still allow
creating resource groups that may end up using the CLOSID dedicated
to SDCIAE here since the (when CDP enabled) resource groups use
software closid and then hardware configuration is done with the
hardware closid. When CDP is enabled it seems possible to still
create a resource group and modify the CBM of what is then intended to
be sdciae allocations?

Also, please be consistent with function naming, note how the above
two functions differ wrt namespace and verb. resctrl is surely not
consistent in this regard but it really helps to have partner functions
look similar. For example, this could be "feature_closid_get()" and
"feature_closid_alloc()".

Also, there looks to be opportunity to use bitops here ... perhaps
__test_and_clear_bit()?


> +
>   /**
>    * closid_allocated - test if provided closid is in use
>    * @closid: closid to be tested
> @@ -1850,6 +1871,57 @@ int resctrl_arch_set_sdciae_enabled(enum resctrl_res_level l, bool enable)
>   	return 0;
>   }
>   
> +static int resctrl_sdciae_show(struct kernfs_open_file *of,
> +			       struct seq_file *seq, void *v)
> +{
> +	seq_printf(seq, "%x\n", resctrl_arch_get_sdciae_enabled(RDT_RESOURCE_L3));
> +	return 0;
> +}

This does not look right ... this file has flags "RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE"
which means that it will be created for all CAT resources. So, on a system that supports
L2 CAT, the "sdciae" file will be created for the L2 resource and it will show whether
"sdciae" is enabled on the *L3* resource?

> +
> +static ssize_t resctrl_sdciae_write(struct kernfs_open_file *of, char *buf,
> +				    size_t nbytes, loff_t off)
> +{
> +	struct resctrl_schema *s = of->kn->parent->priv;
> +	struct rdt_resource *r = s->res;
> +	unsigned int enable;
> +	u32 sdciae_closid;
> +	int ret;
> +
> +	if (!r->sdciae_capable)
> +		return -EINVAL;
> +
> +	ret = kstrtouint(buf, 0, &enable);

How about kstrtobool()? This will make things more consistent with
resctrl_arch_set_sdciae_enabled() expecting a bool. Or should we be looking ahead
at this file later possibly needing to support more integers to activate more capabilities
related to this feature? In that case this implementation needs to take care since instead
of supporting "0" and "1" it supports "0" and "anything but 0" that prevents any such
future enhancements.


> +	if (ret)
> +		return ret;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	/* Update the MSR only when there is a change */

The resctrl fs cannot make predictions on what arch code needs to do to enable feature.

> +	if (resctrl_arch_get_sdciae_enabled(RDT_RESOURCE_L3) != enable) {

(same issue with this file being present under L2 resource creating confusion)

> +		if (enable) {
> +			ret = closid_alloc_sdciae(r);
> +			if (ret < 0) {
> +				rdt_last_cmd_puts("SDCIAE CLOSID is not available\n");
> +				goto out_sdciae;
> +			}
> +		} else {
> +			sdciae_closid = get_sdciae_closid(r);
> +			closid_free(sdciae_closid);
> +		}


> +
> +		ret = resctrl_arch_set_sdciae_enabled(RDT_RESOURCE_L3, enable);

I assume that once SDCIAE is enabled the I/O traffic will start flowing to whatever
was the last CBM of the max CLOSID? Is this intended or should there be some default
CBM that this feature should start with?

> +	}
> +
> +out_sdciae:
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> +
>   /* rdtgroup information files for one cache resource. */
>   static struct rftype res_common_files[] = {
>   	{
> @@ -2002,6 +2074,13 @@ static struct rftype res_common_files[] = {
>   		.seq_show	= rdtgroup_schemata_show,
>   		.fflags		= RFTYPE_CTRL_BASE,
>   	},
> +	{
> +		.name		= "sdciae",
> +		.mode		= 0644,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= resctrl_sdciae_show,
> +		.write		= resctrl_sdciae_write,
> +	},
>   	{
>   		.name		= "mode",
>   		.mode		= 0644,
> @@ -2101,6 +2180,15 @@ void __init mbm_config_rftype_init(const char *config)
>   		rft->fflags = RFTYPE_MON_INFO | RFTYPE_RES_CACHE;
>   }
>   
> +void __init resctrl_sdciae_rftype_init(void)
> +{
> +	struct rftype *rft;
> +
> +	rft = rdtgroup_get_rftype_by_name("sdciae");
> +	if (rft)
> +		rft->fflags = RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE;
> +}
> +

Another instance of the pattern that is impacted by the ABMC and MPAM work.

>   /**
>    * rdtgroup_kn_mode_restrict - Restrict user access to named resctrl file
>    * @r: The resource group with which the file is associated.

Reinette

