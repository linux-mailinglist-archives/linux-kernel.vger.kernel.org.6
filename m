Return-Path: <linux-kernel+bounces-174751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DA18C147F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2F0282004
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B867770FA;
	Thu,  9 May 2024 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMXrWHCh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9181DFC5;
	Thu,  9 May 2024 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715278043; cv=fail; b=GqLYKvRuIpl6nOv2nU7vmLCkwTF4QLyPwUFw20+ROQkQBQKXzvVTru9yAZZ7W1E2iyvwKyEKLQHnDZb6TTGFay8c4F30LrfkkDhGGNguvWCf43WmuRkMrwFIfmtCGChP0bJr6HC/IGarmsibK+6P7MqM97X3AGKoDRq9qTRvPlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715278043; c=relaxed/simple;
	bh=w307gmO/m08nRdpi48rFz19W/ETl4qNGXd40qfwdLes=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xt5+u/EH2yF8WU+/w8Wu/SGE3+qcFS6u0Q/jw1mX9nx3DbBXSPE5l2Z84C8NJzhS/B4tCdDbFx76XghU/EuSi7kroF1Tc9cvPVC3NYuhJa5A/veo9gVTmMe2Mq9E5LwinyiBwXBTuc3j3g7NMBkaWC+xaQsU1wEcKEdWD+BP7sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMXrWHCh; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715278040; x=1746814040;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w307gmO/m08nRdpi48rFz19W/ETl4qNGXd40qfwdLes=;
  b=nMXrWHChmWXp8UlXS6UgxgMrZb5ZFZgC4H6ms0lYBgGoTnUOtGaLZiwp
   o6iVBYC/BgkVl/vild1y1a9SN7HmX3zXU44w3U6PzoaWUBc+ciuxcek1r
   jIL12CJdHNPKbPDdvzGr4l+n+3rP4GREKLUfe4Sl+PK4rsLsRpDGmVCD5
   9fVFQIvJEMVT95HpWyX+iU/cvt2+vX3tJjy3WO6dgMkNtDt/rXToi2UfF
   JhCoKWHZ6BelPUMK1XmtAxaPyTjxDtjQSzc+vKbImid/6Uuvqmc7WdzSK
   DZjOX2LntX8N9q4BVv/jG/RtIGMB5KLA5VRD8MNQkQeOotrM9/Dyg8Rh3
   Q==;
X-CSE-ConnectionGUID: h8BA4n0lSkyQqOlyEvXPXA==
X-CSE-MsgGUID: LQSbKCE0TTyxNcoRqk2ERw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11452233"
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="11452233"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 11:07:20 -0700
X-CSE-ConnectionGUID: zNMYRCaeRhulnTM2qj8ZiQ==
X-CSE-MsgGUID: iQEhMtUWTICuCQF7A+NurQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="33861784"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 11:07:19 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 11:07:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 11:07:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 11:07:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLAc7V+viksWJg/eFhNm8ladzpMBxO6DgQGOHexZgkjWRp/UdLcHMxbvnZYj2HpsDGJqFQL3x5bBA9Vwy6A/avEySYoXmWAU92RoPbyJPb61bH9e+eA+T6MKVvFrBMdaWBzDaRW3GQZ6FbyKcvOqUg4vNngP3dKogKDW9BBLZwSMDp1N8uauHW+I4h46BdDGGXIYLhahtTAcQPnLdhmyaiHZv3YhkAu/wV6h30Akyxuj74pj+jLzeXuABsmMAv5V1JIz0TJwn8oQ3Y/1VAzuwbjuVUKz2LbZbhUiWp0yI9udfwDa5vOG0ugC98Aiwvo44XC8RT/jrrVmsnLxmFAX/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+wmyQmJyxcQsILUyCASmX2vL4u9HqPHBr4mAGp8ju8=;
 b=j6rKSJ+f2vkKj5hcMA3uesGLXLxXEzLP4l9XMe6U9F9bHIfT9vJAw1qtfP1JMsfkVKPf8I5IYzJ4MfaKqwuBcwjX/TLnMnNdVS25aLTzkfFu/NgJolLmnDTtNFL8xZmnmMSwujA7uWizou34o3CQLJQjphnWlZiPonvCOjKVcMB0GJM6JH02mSJ1HooLG0QO0Q31fTvIt7C+cFERcGlBBq54/ki3eY9qBZhJ3NCOmWo9aR3E7aeZqKxxaYFJbDqVe5J9eZ5mnJ9mvGep7UPFPX6wLoWzJ+yLx69YDOUv2ouaMMjguxWYRUVYGLf63lJigtEsvfcxmXAemejvRl7G/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7575.namprd11.prod.outlook.com (2603:10b6:a03:4ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Thu, 9 May
 2024 18:07:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 18:07:16 +0000
Message-ID: <0d94849c-828c-4f10-a6f8-e26cc4554909@intel.com>
Date: Thu, 9 May 2024 11:07:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
References: <cover.1711674410.git.babu.moger@amd.com>
 <48b595cc-5ffe-4507-bffd-335a60fdaab9@intel.com>
 <2016b830-64c7-43bd-8116-bdfd239221e3@amd.com>
 <ea75801f-e56a-486d-85a4-85c57bce0c81@intel.com>
 <7e92200e-d68c-4dc4-85c3-7192a23f8cbc@amd.com>
 <b8a87fb1-838f-4337-8940-8eb1c5328a2b@intel.com>
 <379ba0ed-5c67-4fb8-9738-952289d2f699@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <379ba0ed-5c67-4fb8-9738-952289d2f699@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 132fed4d-95b3-47b3-6c13-08dc7052dc23
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzJra0lDSUxJY2E5UDBPVExEclV1VjRWVktnc2RWcUlvRU9TRFlVeVlVOWtK?=
 =?utf-8?B?cCtlNlpTTHd0NUJJWlo3YzF5Y3Q5T0R3elJwdXVOcGNHeGpuK3VwWEJGTHNs?=
 =?utf-8?B?VVd6RlF5cHFmL3BaUDVmRkVxamtqR1IyWjJLVmtMd1hnaTJTUnJCaXI5Ny9s?=
 =?utf-8?B?VHRtQkhuT1crR29zOEFMVjBYV3NQVDA0ZFZNc0U4cFBNN1ZqZkJCVzMyN2o0?=
 =?utf-8?B?cVZGT01jazBOdTZDRkJ2YVFNdGdIUlZYOFFaMXdNYmtNVDlBTGx5WnZtKzZF?=
 =?utf-8?B?dzZMMTBHNEFXbCtRK0w5ZnFNTFRTN1NuMWJxL00wZUdKbVJNOS9zcVlEVnQ2?=
 =?utf-8?B?ZFcwa25vNDJaN2xPVUpDZi82UGlhNEltMEJ2cXB6R0oyZlp1U01sL3ZXM016?=
 =?utf-8?B?OVcvMU1qU0puT1htRDQ1QUJjS2VlL3A0dEQ0YW9kV29iSkVtLy9RVERzTml3?=
 =?utf-8?B?aDZ0U0JVSDhPa29MR05qMDUxcEQ3MlAyeWVDM3VsbEFxdlNkczNoR21sQ0Yr?=
 =?utf-8?B?K3l6LzJjUXVLcEIzdEE5WFBDMmZWZ2RUTlJIQTloR3V3ZDdUN2dOM1B0WnEw?=
 =?utf-8?B?eTZNcStXNXkzeEE2bTFzUTF4T1lPOVFFNnZkRzV6cWNnMGt1eFJ5YStsSndr?=
 =?utf-8?B?ZzBuKzJmTHBBWkNtQ0gvYks2b1owYnNYdWIvRlBidktobUV6Y1htOXRYMFE3?=
 =?utf-8?B?czZhbjdOQjdIRHNtTk1wSHpSTDc4d3M0c3l1dHBsWjRTWE1xenVTSnpEZnI4?=
 =?utf-8?B?V0Zwd2tqOThlK0VlWXI5SGJPVzU1TDRDMmI0cnVMU3BZVk4raHhnMWdCYXVz?=
 =?utf-8?B?WWlTQ2Y2OGRmOWI2dWlQMit0Ri9NV3BmeGFESS80ZURVWXh6Q1AyYjM3V2V1?=
 =?utf-8?B?RUJITWhkNkkwN3Ryd3pQOWxUUDlhUzNCQkNwSmNEaVlQV2ZDbFBoTldDVVlH?=
 =?utf-8?B?MC95L0RGb2dpbnhNMU81YW1aY21YMFBGTXp6WmVlQTczSzJOb1lEZFVyZFd3?=
 =?utf-8?B?eHRNcFR4U0dKaTArdUF1QnB4dDJCWW5KUjVPcWhWcEVlMzA3ZE81dmdpV2cy?=
 =?utf-8?B?VlNjeHdlOWlXTThULzF6QStPNjAxRFN4YjdPUWpHa1d5WDFQejhYZ1R6anFn?=
 =?utf-8?B?dlM5cFgzSW9CQ3hOemxsM3p2UGNYV0EvdHZad0w1L3BnTFNiT0xZY05MUFQv?=
 =?utf-8?B?TzYreHlGbmVWWkFWOTJxaVppVEI1cytGZHFYRnZ2VTE5aEpIeXlNTEdjRTRs?=
 =?utf-8?B?bCthdjNGQnBpb29ld21LaWZMVUFld0FDYmE5em1uZWlvY1VoWVFNZU1uRXdQ?=
 =?utf-8?B?VFl6WFVDQ3d2TzYwZnd2NlR3N3JPR3FSWmVJTDVySFlHMSsvbFhncFRFQXhO?=
 =?utf-8?B?NzJwcG14MVNyT3l1MFJHYzZtV0szR3h5NW0rVHB1Z3ZRZTNtRjdKZmIybWNS?=
 =?utf-8?B?TXhPZEdPVVBlbnBTQXkzODJmd2NkcURNZDNRdnFuVFhOZUNKaE5lZzh0dzVD?=
 =?utf-8?B?cWZXUnFCWVZwNzNvVkFwZjliVTNxc2JkeWZ0NWRGbnhKelYvS3RHWXhwQ2V1?=
 =?utf-8?B?dXZsRE5Od0Q4WVYvR2VjTXRyUUcrNElZclF4VWUwMG5iWG11L1hKbDdkTE0v?=
 =?utf-8?Q?vnoGPSpfU4SpciezVYRttl0KgDgTj7MCwBgAxuUEbQBA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFF0ME5oaWhQMjl1azFlelkyWXRYRm55NVpEVk4xcGgvRC9DMWdBQTRNYVdG?=
 =?utf-8?B?MG56UGtCY3habFZKZzAzZzRJNjlhb0Y5OFZ5V3J0eTFoS2FhWGxUbVkvYnlT?=
 =?utf-8?B?RU1vL2VNV3dsT1NKMnlvcS9oUDlyQU0xVkxYd1ovNHVjSnk0SGEzUVFQNUFB?=
 =?utf-8?B?MjFCRmFaOElzOVFGby8yVjEvZXNUcGNlOEtjVkE4UG9RVVJUbXhwZnprRGZr?=
 =?utf-8?B?SFdXZE1rb1AxanNPaDArZFVJWHNaSGoyZHVGY3VmV3ZjMWJ0bzN0S3NVYXc3?=
 =?utf-8?B?enkvNnlQdFhXTVV3dUlMa0RuV3l6bmVFR1RoUWh1ZGc2S1JhYmdLdWFVdGsv?=
 =?utf-8?B?WDZWRUZYM2xYSHJTMk5ydEhuditCTFZqUkN5MytySmVUSnRvMU9vbzQwdDR4?=
 =?utf-8?B?SXlmNGRhUjBxMzNQRFExanYxRG5ud2Ira1JLN084Q0FCdGNJWnd2VmwrVlJo?=
 =?utf-8?B?dUdrNjNnaTMva1N6bXhramtyR0pXakZ3M1ppYVM0aHhkR2ozV3NrZVF5YXlL?=
 =?utf-8?B?V3NkdUNIUmQ4UkxVdnFFMlBXaHlDcVd1OFk5NWFaZWVHbHA1Sm9IcVhYQkZs?=
 =?utf-8?B?cDdWb25wZEZoU0pHeE5HWk9SR0pLRGQ5SHJOV2hRVWVDQXpwYVUrNjNqREgr?=
 =?utf-8?B?RjUxNXJDbnhRTURjR2ZYS3lzcGZHUlJjUXNhbVNiQVEwUXo2blVKWnZlandI?=
 =?utf-8?B?Ykh2TzdWMGdpZDZBMXI4V1RGUVZ3QU1qaVJJT0FadW9YMDJoalNFRnQ1TWMz?=
 =?utf-8?B?eU84emhMRUVsQmdHTkJZMUpGOU1xazgyVE5zc2ZaNytUTU0zQjk0ZEpYajdM?=
 =?utf-8?B?bm5vdk9vOHBJcUZMMENndFhxVXlnbG0yMnE5ek5WeDZNL2R0U2puV0M5QVdU?=
 =?utf-8?B?S1dLaXlqUlhsTjl0WWNLM0NMOHREWDdSMVh6Wk5GWDdkTjVtV3E2M0JFZG5l?=
 =?utf-8?B?VEgwbWp3dllxY0hEdFZ3cStBd1dBRGR4U0VGeWd1bXppL0N3L0pSdVMrQnlC?=
 =?utf-8?B?L2ZvdGJ5dzZzbkpKUERZU25uSEEwbmRRVzF4SVpVQWxrY3I5VzZSK1pFOWdD?=
 =?utf-8?B?VXpmMW5rUkR0OCtPbVpLQXp5NWxKZVh1TkNXVWZocTAvRytiYVBrbVJNVDls?=
 =?utf-8?B?ZFNNcGZhQnZYQzNoMUF2RWtiUFgvOWFtb3NBZm5OdXVwaUF1VUlRc3lKRUll?=
 =?utf-8?B?Q1U5b0t5eTgyYlpwU2U1b05tdnhsay9EYmJjSnU3NFhYMmJQb3d0VlppWlU4?=
 =?utf-8?B?NE9lM2xjQmsyc3hZK2JvV0licmpvaDYvM3M0bnlXVVdNVzB1eE9LVGR3c1VV?=
 =?utf-8?B?Y0JGeGVmd1RPVE15NS8wYjA4SzRVTFRzL1N3S2Nla3RCYlRWdmtRR3VxbUVh?=
 =?utf-8?B?N3grSVkwdTRpQnV5MVIrWGFyd2RMTXhMcUEwMHRlSjF5bTgxQjU5Y1dITE80?=
 =?utf-8?B?aHV5ampyWFJNQmFVcUlHdkdEYzZORTl5YmtLUFVSanRKVHE5OFJ0akpid3hP?=
 =?utf-8?B?L0txd3orNEtFN2dUdFBSL3hOdGZVblpLYWlUUUxiNWswQzFzd0RNSFc2ZkRJ?=
 =?utf-8?B?TWg0Vkt1WVJYM0VUUGZJcHJheVg5NGpOVXA2blcxc0crVkVJQzhkbFlJV0s0?=
 =?utf-8?B?eGVkRXVTU25JbmFnR1kwYXlGVVJKbXE1ZUU5aHhzY1JudWg5dWpKZkp3RFVN?=
 =?utf-8?B?cHBsUnNMTVhUUGUwV3Q0N21MWnp6U091UVd3Y3ZWZ0d1K3N5MFI3OVZ1VFZ3?=
 =?utf-8?B?SW1ZRFo4UnpnUE9mQlozZ2ZYdU00Y3VRWTNTa0NMUTlTZ1BSYWhpcEpaSjlO?=
 =?utf-8?B?SVVHRS8zYXNpQ1lxMUZkVkl2SFdMbUlBZmEvcDdsbldDOU50SFRGejZySW4y?=
 =?utf-8?B?U3FzQ3dPQ3p6Q1RaNDZFQVhjdVVoZkdNS01UaFBYdXZlQXVVOE5xMFdKdHV0?=
 =?utf-8?B?S25DV3F0VStSMWdFZVRuWC8vbmY5RStFNk4wQ3lMcWNmYSt6SytEdENWK2dY?=
 =?utf-8?B?ZzlIR1puR2dMaENaQVBYb3J4YWZ6R004OGRUWHBSdHRhOUd1ZTBVKzcvK21Q?=
 =?utf-8?B?ZUtsK0NLVy9tZHFxUWxvL3ZWeTlqSVU4ZnFvQW9EQ3lUV3dLZEdnY3NxVlhY?=
 =?utf-8?B?aEVsLzdhcURFQmd2Y2xlUXkxWVdQZlkwNFM3SFRkYkNvbEVRMHY3VlU0QzJP?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 132fed4d-95b3-47b3-6c13-08dc7052dc23
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 18:07:16.5052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9ghbVgYgYablu6lf9ScBgJyPsRcJAflgrqclMXXJAiYsmM6bcydEnoQJeWl2sDxBT10waZoK3GRkBZbzd1UAp/wSvI9AfqQx8/30ae7eFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7575
X-OriginatorOrg: intel.com

Hi Babu,

On 5/8/2024 4:29 PM, Moger, Babu wrote:
> On 5/8/24 15:41, Reinette Chatre wrote:
>> On 5/8/2024 1:07 PM, Moger, Babu wrote:
>>> On 5/7/24 15:26, Reinette Chatre wrote:
>>>> On 5/6/2024 10:18 AM, Moger, Babu wrote:
>>>>> On 5/3/24 18:24, Reinette Chatre wrote:
>>>>>> On 3/28/2024 6:06 PM, Babu Moger wrote:
>>>>>>
>>>>>>> a. Check if ABMC support is available
>>>>>>> 	#mount -t resctrl resctrl /sys/fs/resctrl/
>>>>>>>
>>>>>>> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>>>>>>> 	[abmc] 
>>>>>>> 	legacy_mbm
>>>>>>>
>>>>>>> 	Linux kernel detected ABMC feature and it is enabled.
>>>>>>
>>>>>> Please note that this adds the "abmc" feature to the resctrl
>>>>>> *filesystem* that supports more architectures than just AMD. Calling the
>>>>>> resctrl filesystem feature "abmc" means that (a) AMD needs to be ok with
>>>>>> other architectures calling their features that are
>>>>>> similar-but-maybe-not-identical-to-AMD-ABMC "abmc", or (b) this needs
>>>>>> a new generic name.
>>>>>
>>>>> It should not a problem if other architecture calling abmc for similar
>>>>> feature. But generic name is always better if there is a suggestion.
>>>>
>>>> "should not a problem" does not instill confidence that AMD is
>>>> actually ok with this.
>>>
>>> The feature "ABMC" has been used in the public document already to refer
>>> this feature.
>>> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24594.pdf
>>
>> It is clear to me that Assignable Bandwidth Monitoring Counters (ABMC) is the
>> name of the AMD feature. The question is whether users can use the 
>> same name to interact with "similar but maybe not identical" features from other
>> architectures, which is what this series enables.
>>
>>> If there comes a conflict then we can change it to amd_abmc. Didn't see
>>> any conflict at this pint.
>>
>> How do you envision this? The resctrl filesystem interface is intended to be
>> architecture neutral so it is not obvious to me how "amd_abmc" is expected
>> to look? Why would it be necessary to have different architecture specific names
>> for a similar feature from different architectures that users interact with in
>> the same way? Sounds to me as though this just needs a new non-AMD marketing name. 
> 
> I think I misunderstood it.
> It is not a concern to have a same name("abmc") for similar feature across
> the architectures.

Thank you for confirming. This joins BMEC and SMBA in this regard.

> ABMC is also kind of generic. I am open to other generic suggestions. I
> think we should have "assign" and "monitor" words in them.

One thing we can consider is to move to a simple "enable"/"disable"
interface for events. Users do not really need to know that hardware
needs to "assign a counter" to an event for it to measure. Yes,
user space can infer some of this by the number of events that
can be "enabled" at a time, but the concept of "assign a hardware counter"
is abstract and does not directly map to (as I understand) the soft-RMID
approach for other AMD hardware. Peter reminded us a while back [1] that
"assign" has a variety of meanings, even among AMD, so we should aim to
avoid any confusion. 

Reinette

[1] https://lore.kernel.org/lkml/CALPaoCjg-W3w8OKLHP_g6Evoo03fbgaOQZrGTLX6vdSLp70=SA@mail.gmail.com/


