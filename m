Return-Path: <linux-kernel+bounces-290334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8104595525B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A52B235F8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF96C1C6891;
	Fri, 16 Aug 2024 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pu5ry9MM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E7F1BF32F;
	Fri, 16 Aug 2024 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843753; cv=fail; b=LgEmDI9l44CqB0XAitzegd63erH1KME80LJwXYEmQjg24j/DMQt74VQA4msc/kbYvvUwqNupp0bg4/M2wVJl8mA3rqJI09Z7blyrswdThl6g1I0EbT5mXRgVS3Y8NHjwgP9Ih6mn7jukbBvK/JB0cq4Rhz5KpfZmUKYXV6ovpqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843753; c=relaxed/simple;
	bh=OjH9UjgSPxPiVwnxU48JUnHJPQs3OivX9msx2Js2/Dk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Km1GFwISdoQDa+fCkDvfjwxEdIQSXLF6inSt27oWCdZkiO/pFf3BcWxj3hT0eYRPs2oUVRl1MdZNCyAIAz7mO8LhRUKUKQaOY25vNfLFcDK+fj2bPZ4J0yrTwguon0QKvB30aXzwawHhdOvtqMPQOshJc6M1JtHRPU08HNqiUl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pu5ry9MM; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723843751; x=1755379751;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OjH9UjgSPxPiVwnxU48JUnHJPQs3OivX9msx2Js2/Dk=;
  b=Pu5ry9MM6d/ugnihfohYwaC+rriUsT6pks3E+nAjTDjxGQ3Te7t92PuD
   uKjRSLwuDf/iRxOXn7Ca3WtpsgZSTK81ZYHjyzdcR6AuJGOAO8BD+ODqp
   31YRRtdKrE38krftj9ve5Tjto6Gge8ECcIL4MEAxk+jOAq9tsvLOHqMvB
   4A6rNujYnoz0aSy3aDISgT6/Rz52/vCMgah+uFUHxYxSnp9CVlpxqEyTN
   9Qxmh+pmI3rl5EzEWC5OWOX56yB+WxR1JKeJ2tMKnwrL4wFkeaQvQpTH3
   FYnnflKGxIRNdZuMgHtftaTVrmugcjrjAn74edhqPQqVnn46g5fiVx9Dh
   A==;
X-CSE-ConnectionGUID: VctpMGq+SKyXsMs3l/JnkA==
X-CSE-MsgGUID: mL5i5M3VTfCJT8Y26r8aag==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="33564477"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="33564477"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 14:29:09 -0700
X-CSE-ConnectionGUID: iOklAPqTR/SBsFSkwQ9mEg==
X-CSE-MsgGUID: kTvgWb6QR4GjHrqsgq5e/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="64185745"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 14:29:08 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:29:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 14:29:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 14:29:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oO77VhmYI160yNrcxaKrfpb+kcnetDIrwCbRPposjNWHJ9CwykYv6f37h0JyTkLsmW62nJPwG4iNVkPC9L6tUp4t0za9KpemgqTDWu8t3rToVai1ApQNeZwEdM3hGx6pmVNdNtHMSK81y0xBpWgrQ/K1ouUZImoMpwBl2P2Hke3K81Gi2iJB0tcnntPYwXUfh8oGAAdqrTfcSS7jQcTAXqMxxB3MJ0a5gP5CorY0YHWFqqJHhWoUgJOmJaRVXzYvbeeiTpmJVz+J5yyqQGj8JYcCMLM/oj0rug8OqMnPRu3OtbU9l92YqDQgfmJbgSiIPSgI5uUlbxp7bj8osC9o2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fn2HkS3LyRQiBWDUxTB0xnNibQOZToscFDLezWNSzmo=;
 b=t0MTT8j8fpycAK+P3HIH5sDnyEv4BxfoPGuk2FO1O5ZY+krjJ5QpTD0mJugexrQvJJXVbXKOA1S76J9UFpRTWZA4927GaWtQmskf8HdPmUcFJfOpJqC1Rt740oMqDsAlwN7j9l8/jjJ6VzmejFBkGdNO05bqVG39LPdzFn0YFlWW9raYnr+QsTcf2NtbecyIOV8eaZ6pRaKCx5TNum1JNa/Z6f3GeJKl/JF1oqOBMmu1+ZnS+4CziCa7IZASDSihy0qxC9hmGHsA3zMvdxUYA/gf9Ztgb3BtQbPKwskQ0dANAMnhLqR4d9rC5kwjw875pupw0BrR+6qRnkO+oRFIGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8364.namprd11.prod.outlook.com (2603:10b6:610:174::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 21:29:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 21:29:03 +0000
Message-ID: <d093c0bc-dfd2-422a-9d23-2bde68dc6f73@intel.com>
Date: Fri, 16 Aug 2024 14:28:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/22] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
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
References: <cover.1722981659.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:303:16d::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: f616c3be-2108-40bd-6613-08dcbe3a7321
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnVTSHpFTnozUnRBamJDcUxvM0RxM04vUHdVQ05JYVZxOEFlMzJrSjRwN2Na?=
 =?utf-8?B?ZHlITnpaWEdoVEJKU2ZwNlhpNHRIandLbk44TGpkZVFkV1B2UUprQ1Uxd3d0?=
 =?utf-8?B?bDZKdGxvaW11WENhbk5aNGJYVzZacDJ3R1JmNzVFcEtTRDBEOFRVYlp6NFVX?=
 =?utf-8?B?MzNvbkEwUG9ZV2FGcU56N25PdnFORVJQSmo3a2JkNFBmQ2ZhVUx6OFpQUGZD?=
 =?utf-8?B?c3JjZlJabHhZUElFdXhKbUd1bloraVMxNG53Ykd4U3EvdXg4YmhuM1RRazhv?=
 =?utf-8?B?R3JkbUdDUjAxMFIvUG1yWUQ2bEthYUVFNXBXZi9KS1VpNTZlU29nM0NRSHN5?=
 =?utf-8?B?OE5QbVU0YXMySmt4dnl2Y0RaVzRoWVJIY0QvcjczbmVBRTBMckl1dm8wUStl?=
 =?utf-8?B?cVV5NHBQVWZIWmFqNW96aW5QWlNJNDdQTDIvL0lRM2J0N2xTOTI3OVRNYmtV?=
 =?utf-8?B?bnNRV0I2Qjd1U2NnSHFEMERlVEdiZjRPYms5UDJ2WnRnbDdIVm40NTNvb1FE?=
 =?utf-8?B?OFBtVHNqMHM1SE1XTjh1RFhLdXB6d3pweUxDbjdwZEErZG9KNzFtOVFkVEdl?=
 =?utf-8?B?b0M5Vy90aVhBTUcxZFZPbktUZDNZQkJLM2g4cWl6b0FmeUpxS2QwNmk1MzVF?=
 =?utf-8?B?RXh3RXQvRjdWaE44bDRqbkVNbHdNUGwwVVI5cGRyWSt2Q2RkZEk5bmVWamZh?=
 =?utf-8?B?S1A1NVJ4WFBvRCtZRVY1UUhtWjJJSVJyc21UYWhmRlk2eHRMUDZNOUNNNDZv?=
 =?utf-8?B?ZEZzUmZHRm41WVdiMHd6dHVSeWIxVkZTaC9Ma25nV001Y1hhNmtUN0hLRzd3?=
 =?utf-8?B?a2JNMTdMbVBSUVRTSGdoZ1NKQStjMkJURWNPY21PdmJGT09qYWtIZ2locHEy?=
 =?utf-8?B?OTlIOTlFZnFjZXRLRDVDZ1k4Y3JaNlA5bTRIdTU3OGx2K2dYV2ljVWRqMy93?=
 =?utf-8?B?b1RackpMMEZKNUdvUzMxY0VxcERGRFR6QkZpODBYUXcxTVRwZkRDc3V2NURO?=
 =?utf-8?B?anVpQUhIenViaktmUFRxTkNHM1M2MjEwd2hkTlVsbUFDTVNIaVlqQTdKSkhx?=
 =?utf-8?B?cFBOSjV1UTlUcnBmQjZVZjBSZEdzUHRMREVTamFMbGsrRmM2UFhRYVc4K2hj?=
 =?utf-8?B?UnRIdS9hRldrUHAvRXFKQUNVZWV5dU9DZGtzYklwVlJoeDhGWmJueFg0VXFY?=
 =?utf-8?B?RlRRaFVIQTVHVW5NUkJ6cHk5WEZLTG1SY0JZWDFvZ2FabHF6ck9oMlBhbnU2?=
 =?utf-8?B?djF6VnN2c1hsSUthMncxV2diM1BycFhvdW5vMlBlQlduY3ZGeVlZN085bXBU?=
 =?utf-8?B?SENCanA4cTZOWk1VeFk0WkVrQ0tnckpDQVk4Tno3ZGlrN3RPalRTbHg3Tkln?=
 =?utf-8?B?dTEzNnhiWUJPNnVvbW9kcjJGTEk5aUlXN095WExXWkxYa24vM1RBM0dXeGRm?=
 =?utf-8?B?UUlnajV6aGV0a01yQTRWQTQ5bjlQT0ZQYTBNdHpWaFBMSGV1dHJhVGhZM3M3?=
 =?utf-8?B?SjJYUUVJL2FVUWNqSnkrRVdDak8yWVAvSW5EUUFCYkZUa0l1WE4zalE0TXNF?=
 =?utf-8?B?ZEEweXI0cmRJdHMrbFZnZ0xCbUZCdnlmMUxHWDJtYlhEWWxzRzRMRTlpY29W?=
 =?utf-8?B?d05TNElDc0VBUytNWVN0dCtDS2FUTjBhWXJ5UTQzRmdqNWsxR3o3SXptQ05x?=
 =?utf-8?B?UnhSZVVhSHBZTkdwOUtxUnMzL2dPcFo3N2ZhZzJpL0g4Y1V1eG1UN015UXJ5?=
 =?utf-8?B?QllpUmR4QUNCT3J3QmcwQTV3eDRUY0NOWDRSQnh6Z3NxRURnNjlMVHMyaTdv?=
 =?utf-8?Q?y+rRzyk+XEKLjFXDldrLCkpiaSkkX46PlUOic=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlpwc1J6U1hXN2xGZ0NGZGx2aDdWOUFOdUpxcWg3cUZ1ZVNrOVZJLzdmRlBp?=
 =?utf-8?B?ZEpLUHpReVRmU2t0K1NKQ2lMKytwaDh1N21xbTRJbW1JaFM1QTVWS3ZSWHNt?=
 =?utf-8?B?TU9XWDFyRit0ZGEvVUpCQzdaenU2UEpQVnUyc2VsNHc4dVpwbUtnYjJDcmNC?=
 =?utf-8?B?UTJkVCtlQWY2aEpkankrdU05NnByNUdZRWlUSzNVRVREK25rQ3h1NzNWWGw4?=
 =?utf-8?B?SjRSTjFXTE8xWXJiSnRkMGhabGh5ZzlRWnZPbm0xZGNDQ29nWnYvNDhWVFhN?=
 =?utf-8?B?Y1d2WFVZNmU5OHc1VTZBS1dJL1RIdWYxaWY4bTZ0VGtYNlAwaW90R09OZ0U3?=
 =?utf-8?B?emxXZjk1TG42SWNxVUNWK2pRcDJqWHFEL0lUMVhwSnF6bDBUQzB6Q1RpakxB?=
 =?utf-8?B?SnA5V2dCZ2c5ak1ZNUkzVkZsVlZ6ZVV5QkwyeTc5RVBSVzRlT1pvcG1VamRn?=
 =?utf-8?B?OSsrVzhtQjYybFUxWHFiaEpodjFmN3IrR2ExemJ1ekxXYVduTjhXZVFtUlpZ?=
 =?utf-8?B?OG9Demp4ZWlPMU5NTVFMZDMvVDVUeGJKdUIrMHptOUM1aDlGVEROY2dsTzFm?=
 =?utf-8?B?YVdTYndNNzFVMDN3MnNSazBhYTJiTFZaQVNqRlpEdVFPRmh2UWtDVWdWNG56?=
 =?utf-8?B?d21wOE90aFpGWGRWcnRpUFE2d0RGUWRVYjF6eFJmUTd6S1NMazNvdGFGaFFz?=
 =?utf-8?B?UWFBVFk4ODQremdHbWhFM3h6czZtZ2VLU2lQeVQ4Y2hHT2czUFdsdEl2S3pj?=
 =?utf-8?B?bjlpUlpZVEMvdmRMWHJuZFNYV25TRVZ5MDI2MmFBb0F6eDAxWkhKU0NoVzBO?=
 =?utf-8?B?aUJ3SjVtRDJyTGRBREppbUxZaDlZQXJwYnJmVHJLSnE0Qm5ZYWFVL3JqdTgw?=
 =?utf-8?B?MGt0QzZvcVVoaWxpMzJJOWpuWUJnVGRWanAxOUQ1YTBJdW9ORGZBVDdyU3FU?=
 =?utf-8?B?WGlHaW5GbmxTZHNSS2RDYi91N3V5SzE0b3cxK0xGTWlwRXdjbk9tWGJvM3h3?=
 =?utf-8?B?VGJQVWpEVXJSejdJN3E5MzgybVZ1MGlCdlBWZEkzU0duSXJsRXh1ME0zZmh6?=
 =?utf-8?B?U3U1VWU2cUdpUW9CbVFjUEJCOHpHNS9jLzFleDdycDM5NmlUZWs1RUZlNUNy?=
 =?utf-8?B?Snd3bE9pamVKSHpJSUY0eFplR2lKZmpKZ0QwOVdYQVhOVWJTUDJLeHlDR3Fx?=
 =?utf-8?B?QmhDTXh3ODRWenJiYnRSS0tvNGxCMUJ5azFMK1RrQkdPamZhdWdPWi93by9n?=
 =?utf-8?B?cVE1TEpKVVFLbnRJZ3FqMnlqa3M5Y1lXZjd6SWpyVGNFSkNtb1I2WFBjbTd2?=
 =?utf-8?B?OW9NZHEvYkRMUjJZV1hvUEoyWmtvdC93YXlOWlV3UmVjSmU1NGYyZ1RYZFcz?=
 =?utf-8?B?djVTMUt0b3ZVb25mN1ZYUzF2QkpPc3lUa0ZHV1ZGN2ZrVG1IWXppamsvQXJw?=
 =?utf-8?B?WGJKM2NsbjBNUXBxYklLY2xKdDIwYks3NW91c3dDK3dmOGU0NThla25KOHZY?=
 =?utf-8?B?a1NzaFNSRG8wUzJHa1FmOGFuemVTbC9XYlZweklEd0FIRVdJRy9jdEJIMU9u?=
 =?utf-8?B?SjdQcmZrS1BHMlhmeis3SlkrMkk2WExFTFE3Yjd5TDJjeXNkZnc2dGJGOUpG?=
 =?utf-8?B?anZDQUNOTGF6dEVJMXNjdGFvQkZwMWhWd0pmMG0vaHVVNzk2NUZNdWs1TGxP?=
 =?utf-8?B?Z1MrcU5TZFZNeGs0ZSt3Yy9nR0JSWDArdlJUNEhOQWtPQmJKOC8vSE5jWUlL?=
 =?utf-8?B?T3FlSDRQZXpTQWZxeVBNdVh3c2hDSFBRK1Iza3k3blN0T2dlTUJkRUlvTnZN?=
 =?utf-8?B?bDRHQkF2d0Rub0M5aHovNzAwd2tHNlRKMDN0Yk45c0hvMG9oQzBpNVNhaExR?=
 =?utf-8?B?blpocmdlTk0yVjB5RW1kRklBSVJZb0dIUGtYNWlGaUlyZis2bFNDRER2cVgv?=
 =?utf-8?B?NEc1eXMrNmVtOGV1RlUyZFNSYWtVdTBYZHZxUWE5dzhaVDhkTXpBL21raHhW?=
 =?utf-8?B?Z2dIVnM0MGZZZHoxc05ZQXg4MTdwRWNSbzFCNTYwaWdCQmZ0K29oU0w1SmhV?=
 =?utf-8?B?b0pGOVhlblo4U1NEVTN0ZUdyUFRRaVdLQXEzbmFVdmpsY0VHYnVlQnpFY0Jj?=
 =?utf-8?B?aC9yVTYxM1ZMVTJJK2E4cGIydk5wZEhwd2U0WHd5SFZwK1d1OGVlSkEySWRh?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f616c3be-2108-40bd-6613-08dcbe3a7321
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 21:29:02.9786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /75wqXiff1DNtqAiIblj1gWnEtnTM+WxwzUcTc+39/YEJ5cZW1oNpuKOaekurT6Gx3QBX1ep3a9+oDPqgEOsVp6gW3q+sy6z0XL0i2rqj8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8364
X-OriginatorOrg: intel.com

Hi Babu,

On 8/6/24 3:00 PM, Babu Moger wrote:
> 
> Feature adds following interface files:
> 
> /sys/fs/resctrl/info/L3_MON/mbm_mode: Reports the list of assignable
> monitoring features supported. The enclosed brackets indicate which
> feature is enabled.

I've been considering this file as a generic file where all future "MBM modes"
can be captured, while this series treats it as specific to "assignable monitoring
features" (btw, should this be "assignable monitoring modes" to match the name?).
Looking closer at this implementation it does make things easier that "mbm_mode" is
specific to "assignable monitoring features" but when doing so I think it should have
a less generic name to avoid the obstacles we have with the existing "mon_features".
Apologies that this goes back to be close to what you had earlier ... maybe
"mbm_assign_mode"?

> 
> /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs: Reports the number of monitoring
> counters available for assignment.
> 
> /sys/fs/resctrl/info/L3_MON/mbm_control: Reports the resctrl group and monitor
> status of each group. Assignment state can be updated by writing to the
> interface.
> 
> # Examples
> 
> a. Check if ABMC support is available
> 	#mount -t resctrl resctrl /sys/fs/resctrl/
> 
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_mode
> 	[mbm_cntr_assign]
> 	legacy
> 
> 	ABMC feature is detected and it is enabled.
> 
> b. Check how many ABMC counters are available.
> 
> 	#cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
> 	32
> 
> c. Create few resctrl groups.
> 
> 	# mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
> 	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
> 	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp
> 
> 
> d. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_control
>     to list and modify the group's monitoring states. File provides single place
>     to list monitoring states of all the resctrl groups. It makes it easier for
>     user space to learn about the counters are used without needing to traverse

"to learn about the counters are used" -> "to learn the counters that are used" or
"to learn about the used counters" or ...?

>     all the groups thus reducing the number of file system calls.
> 
> 	The list follows the following format:
> 
> 	"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
> 
> 	Format for specific type of groups:
> 
> 	* Default CTRL_MON group:
> 	 "//<domain_id>=<flags>"
> 
>         * Non-default CTRL_MON group:
>                 "<CTRL_MON group>//<domain_id>=<flags>"
> 
>         * Child MON group of default CTRL_MON group:
>                 "/<MON group>/<domain_id>=<flags>"
> 
>         * Child MON group of non-default CTRL_MON group:
>                 "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
> 
>         Flags can be one of the following:
> 
>          t  MBM total event is enabled.
>          l  MBM local event is enabled.
>          tl Both total and local MBM events are enabled.
>          _  None of the MBM events are enabled
> 
> 	Examples:
> 
> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_control
> 	non_default_ctrl_mon_grp//0=tl;1=tl;
> 	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> 	//0=tl;1=tl;
> 	/child_default_mon_grp/0=tl;1=tl;
> 	
> 	There are four groups and all the groups have local and total
> 	event enabled on domain 0 and 1.
> 
> e. Update the group assignment states using the interface file /sys/fs/resctrl/info/L3_MON/mbm_control.
> 
>   	The write format is similar to the above list format with addition
> 	of opcode for the assignment operation.
>      	“<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>”
> 
> 	
> 	* Default CTRL_MON group:
> 	        "//<domain_id><opcode><flags>"
> 	
> 	* Non-default CTRL_MON group:
> 	        "<CTRL_MON group>//<domain_id><opcode><flags>"
> 	
> 	* Child MON group of default CTRL_MON group:
> 	        "/<MON group>/<domain_id><opcode><flags>"
> 	
> 	* Child MON group of non-default CTRL_MON group:
> 	        "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
> 	
> 	Opcode can be one of the following:
> 	
> 	= Update the assignment to match the flag.
> 	+ Assign a new event.
> 	- Unassign a new event.

Since user space can provide more than one flag the text could be more accurate
noting this. Eg. "Update the assignment to match the flag" -> "Update the assignment
to match the flags.".

> 
> 	Flags can be one of the following:
> 
>          t  MBM total event.
>          l  MBM local event.
>          tl Both total and local MBM events.
>          _  None of the MBM events. Only works with '=' opcode.

Please take care with the implementation that seems to support a variety of
combinations. If I understand correctly the implementation support flags like,
for example, "tttt", "llll", "ltlt" ... those may not be an issue but of most
concern is, for example, a pattern like "_lt" that (unexpectedly) appears to
result in set of total and local.

> 	
> 	Initial group status:
> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_control
> 	non_default_ctrl_mon_grp//0=tl;1=tl;
> 	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> 	//0=tl;1=tl;
> 	/child_default_mon_grp/0=tl;1=tl;
> 
> 	To update the default group to enable only total event on domain 0:
> 	# echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_control
> 
> 	Assignment status after the update:
> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_control
> 	non_default_ctrl_mon_grp//0=tl;1=tl;
> 	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> 	//0=t;1=tl;
> 	/child_default_mon_grp/0=tl;1=tl;
> 
> 	To update the MON group child_default_mon_grp to remove total event on domain 1:
> 	# echo "/child_default_mon_grp/1-t" > /sys/fs/resctrl/info/L3_MON/mbm_control
> 
> 	Assignment status after the update:
> 	$ cat /sys/fs/resctrl/info/L3_MON/mbm_control
> 	non_default_ctrl_mon_grp//0=tl;1=tl;
> 	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> 	//0=t;1=tl;
> 	/child_default_mon_grp/0=tl;1=l;
> 
> 	To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to
> 	remove both local and total events on domain 1:
> 	# echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
> 	       /sys/fs/resctrl/info/L3_MON/mbm_control
> 
> 	Assignment status after the update:
> 	non_default_ctrl_mon_grp//0=tl;1=tl;
> 	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> 	//0=t;1=tl;
> 	/child_default_mon_grp/0=tl;1=l;
> 
> 	To update the default group to add a local event domain 0.
> 	# echo "//0+l" > /sys/fs/resctrl/info/L3_MON/mbm_control
> 
> 	Assignment status after the update:
> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_control
> 	non_default_ctrl_mon_grp//0=tl;1=tl;
> 	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> 	//0=tl;1=tl;
> 	/child_default_mon_grp/0=tl;1=l;
> 
> 	To update the non default CTRL_MON group non_default_ctrl_mon_grp to unassign all
> 	the MBM events on all the domains.
> 	# echo "non_default_ctrl_mon_grp//*=_" > /sys/fs/resctrl/info/L3_MON/mbm_control
> 
> 	Assignment status after the update:
> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_control
> 	non_default_ctrl_mon_grp//0=_;1=_;
> 	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> 	//0=tl;1=tl;
> 	/child_default_mon_grp/0=tl;1=l;
> 
> 
> f. Read the event mbm_total_bytes and mbm_local_bytes of the default group.
>     There is no change in reading the events with ABMC. If the event is unassigned
>     when reading, then the read will come back as "Unassigned".
> 	
> 	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> 	779247936
> 	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> 	765207488
> 	
> g. Check the bandwidth configuration for the group. Note that bandwidth
>     configuration has a domain scope. Total event defaults to 0x7F (to
>     count all the events) and local event defaults to 0x15 (to count all
>     the local numa events). The event bitmap decoding is available at
>     https://www.kernel.org/doc/Documentation/x86/resctrl.rst
>     in section "mbm_total_bytes_config", "mbm_local_bytes_config":
> 	
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
> 	0=0x7f;1=0x7f
> 	
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
> 	0=0x15;1=0x15
> 	
> h. Change the bandwidth source for domain 0 for the total event to count only reads.
>     Note that this change effects total events on the domain 0.
> 	
> 	#echo 0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
> 	0=0x33;1=0x7F
> 	
> i. Now read the total event again. The first read will come back with "Unavailable"
>     status. The subsequent read of mbm_total_bytes will display only the read events.
> 	
> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> 	Unavailable
> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> 	314101
> 
> j. Users will have the option to go back to legacy mbm_mode if required.
>     This can be done using the following command. Note that switching the
>     mbm_mode will reset all the mbm counters of all resctrl groups.

"reset all the mbm counters" -> "reset all the MBM counters"

> 
> 	# echo "legacy" > /sys/fs/resctrl/info/L3_MON/mbm_mode
> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_mode
> 	mbm_cntr_assign
> 	[legacy]
> 
> 	
> k. Unmount the resctrl
> 	
> 	#umount /sys/fs/resctrl/
> ---
> v6:
>    We still need to finalize few interface details on mbm_mode and mbm_control
>    in case of ABMC and Soft-ABMC. We can continue the discussion with this series.

Could you please list the details that need to be finalized?

Thank you

Reinette

