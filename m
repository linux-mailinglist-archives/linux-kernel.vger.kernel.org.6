Return-Path: <linux-kernel+bounces-326882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF72976E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF10B21471
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598991BA27E;
	Thu, 12 Sep 2024 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMEo0v1L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386881B9B33
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155853; cv=fail; b=P6x5alJjRuvyMRcITLMBiEI9WwoNsj2/DPjgCV6/ghGo1Gexu0gdpaTfDJPkClvB/wPPEoGOlAtw5Ic0CwIpctD4jz+3L+ky3JbEBSwcie0betHeVYSOcfYJSJmhTFYQLdtstNpGx/ggxxLS6bYZxhgPkTmw7+lkxUo9K6unIas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155853; c=relaxed/simple;
	bh=TEHy6Hk93wCixmYRaCMIZKHoAXxOiD2C+r8po4tX9CM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=klMYx3tELHoa3coxILLx4AMFcuwXD783dGfhiiSjFFREkp5tDTBo1KhnvzSD6x7Fzi+2DIsjvOTsRmboFCALNuXR7JklOvSebGgyKwbYpWEbl61HIzDBXLD8c8y59h4bx0H8hG/WG4HZDpgCZePYYVrFqifHzV5KE+Rrq7IGFCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMEo0v1L; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726155851; x=1757691851;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TEHy6Hk93wCixmYRaCMIZKHoAXxOiD2C+r8po4tX9CM=;
  b=MMEo0v1Lzfmi+897FToeiYIkyZ1AdqwZH4DZ7fmON9uireH0CwkLS4Cf
   WXbr/FPRH+LlSvWPCD5Os8TDY5qNLIbK0AL+TncuuDU2hTe4wYn1xhaC3
   UvD+lOMApAitZXDrM/NYVQ3NJTGNvNS5zhgO3rc1GvUZmGr5UY3MDCxMR
   erbb6MRrR0QzLIET9hYDIwvQ/u/xzZWIu1Y8W5DaNfCQ1g/TIU/2GkCnM
   ZZrc0lPx1f++uf7M2kf4OJPSg27SIjAljc/RmlFiKXwnoQDcSPYv0A83M
   VQDap1HvJTbM7PtbdxQ0gDQMIyd9EaLgeK9lUs24/t+zfV0GiLVvDV+l5
   w==;
X-CSE-ConnectionGUID: m9nzJjyDTm2QNqaTLXdE+Q==
X-CSE-MsgGUID: El7ykXMmTZm8Zh0LopTQEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="28913898"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="28913898"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 08:43:44 -0700
X-CSE-ConnectionGUID: 3W8N4k58TouhVUDdJ4z2qQ==
X-CSE-MsgGUID: 0jik99zGTYOJ6LWS1KNedg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="68523270"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 08:43:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 08:43:40 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 08:43:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 08:43:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 08:43:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPcJkjeTfrC4bbbYHY2/Di14gm/HviiHwM3LKnTG4raequ5mgyfR61zLXsbV8w04Dia6fHrxulB24mo8ZOHHRlSUQPlTJ+2VqRir7VoJ0dBk5Wv0ToVmkIwGIhwJaP+5rRB1UGACnxp2etGeKpBzjSxJcmk7W1GNO5Aji1eGzEcKxoTWJqm2JdcJP/CP2y8QJzGoQgaMguExwHJ4FmPfieALm101QIFAkJq3tNUtp7I50SKEFwR0KjG3YInoYTvDvegTsgMHFlmw214+DpSlW0NZAJ5lNUwbGAHBekft9nEFkHrgvJ2RaQMQAk9y4RDzZaWVEJUGNadrs0Uw/7U0XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsW9S52LY4jfW3xizzJjxxUwVR/6hJFYp2CzjCM4lLA=;
 b=EqPgM/gtJpJk49UnCKSGfL6aAFnG8vHY4t6jvDt2PEIt4IFW7XMDe0mrlfxmjoMD0KruPCYlHFCNfpRj4s1SaI8lMMQIkD9qk9UgatameySEYh00qhS05u4iRZPxUqdzoh8wx5HJqzjlqCFD0JdxEaln0IIwbuX0npsvpkJYUeGFNKtNk4fxxPcMbEcJVLYawoWwfX/gRsBEn82iDD7n1w66HAzyCDZqgTty+tjj4zRJlgkNsodqDfvrwkB2QYqAIPojMy+kwBqVRs0Gasjb6RIud0QYzYuAsCt2x8xZyIGcoChB6FPJHc8rmN/CjdVrLJca4LFaIOavWHdJqPLCtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 DM4PR11MB6336.namprd11.prod.outlook.com (2603:10b6:8:b9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.25; Thu, 12 Sep 2024 15:43:37 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%4]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 15:43:37 +0000
Message-ID: <b9d3736a-836f-44cd-ae84-e6912ef22d15@intel.com>
Date: Thu, 12 Sep 2024 10:43:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
To: Alexander Graf <graf@amazon.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>
CC: Dan Williams <dan.j.williams@intel.com>, Samuel Ortiz
	<sameo@rivosinc.com>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, Lukas Wunner <lukas@wunner.de>,
	Dionna Amalie Glaze <dionnaglaze@google.com>, Qinkun Bao <qinkun@google.com>,
	Mikko Ylinen <mikko.ylinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <suzuki.poulose@arm.com>,
	<sami.mujawar@arm.com>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
 <20240910170959.GA213064@myrica>
 <f6b0a1d2-c730-4b20-a8f3-afd9a7cf822a@intel.com>
 <51c009c7-e2ee-4753-89c8-6157d2cd49fa@amazon.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <51c009c7-e2ee-4753-89c8-6157d2cd49fa@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|DM4PR11MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ef4989-0e30-4991-33d5-08dcd341aae7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yy8rdklsMUI0MDVPWmNybFhnVzJiMXpLVEMrZnNOSVdISDA4SzhFaXFPZmVr?=
 =?utf-8?B?VGZML2NrTnRjR2l1L0RYRHpObXRQVlJZSmthOTZqMVc2aXNwWUxmcWRWQ0Rx?=
 =?utf-8?B?T3c1VnpWOGYzVnBXL3lNVmRWK0lxYUt1SzU3Tm5sZnBVeUVuMmJiMmdEUklh?=
 =?utf-8?B?MjNtNUI2b0laT2s5VXg1bWhTbi9uL2xySGJOaVhaY2FpS3A3QXp6TUZzN1pB?=
 =?utf-8?B?dEdrN0loSnNiYzBERlN6MWNzaWJYZlZwK2pPczhnTnY4TjVYVkxLNE8rdU15?=
 =?utf-8?B?b1k4MlI4eGU3RGlwQVhmRFQ0UlBWU3k5TWJubjR3YzFDTDN0K2huRmlrekl0?=
 =?utf-8?B?YmE0NkNBSTgxeWtaeWl3V3dhN0FUcVE3ZVlqSEoxUXgxT1ZqcmluWm1Kb0sx?=
 =?utf-8?B?cWI5TTNGendVeUQvUHZnZ0tqNzd0RnNxUFZ3Y2pSbDdpWjR6NXlsMlp3MFo5?=
 =?utf-8?B?R2ZIWVR0SkZubk43OFpRdnFVL1FiVkNSUkphSk4xeG9VNm0valB2VHZveVlF?=
 =?utf-8?B?NUFqYjNkbkxWdGZmRjNWNC9RSDg0SlRCTG53bG1kMEp0dGVWTTgzOGhpcGpB?=
 =?utf-8?B?ZEVBZEF1bFZleXdiR20vNzlrcEJsMFNPYVdDakIxZjh5WTNLYWZoZGRZZU1Q?=
 =?utf-8?B?TzFQQ2JFZUtGMlE5MVdyQUZlQTVSUVd5ZExnMVFOdmo3QkZHK2ZxUkdPUWls?=
 =?utf-8?B?ZWJBeEFYZEJkNjlnNFpFY3UzMkk0ak1VQlRpT3RLbFh3emlPUEZOZUpMNTdl?=
 =?utf-8?B?N3ZFVXZwa05wSGRRTDMvZ3BCVjZ1SFcrSVYvSy9yNWQyOUF5SWluMnNkV1U0?=
 =?utf-8?B?aDIwY24xRkNyTzVNQTRTVWxuWlNmVVQxM043eHZhVEd1ZzYxQ0xJSXM3Vm93?=
 =?utf-8?B?K01ZazBLaGlKNG0zVlNEWkxqaHRQdm1JUUs0UUZuWUhNSXVUWlFQU0JtZ0hk?=
 =?utf-8?B?QmVWZEdWTGNUVUtOdjNhbkhvS1JKbElXQ3AvZ25vam9vN3lnL3U3UjEzU3JW?=
 =?utf-8?B?UHYvbnVDdEU5aCtsOVhIR1NsQXY2cldtSkRMZm5QNFA5YzFBZ2ZLbWZZNzVn?=
 =?utf-8?B?KzFwT0RGcDEveE43S08xZU5sdXRESW1kUzhTZjBETklnck80V0FEZ2gwaWx4?=
 =?utf-8?B?dElDZXhCMjJtTHkxMDJlY1BIYkswaXl3bXA4V2taTS9TRmMvbTJaVnJQdTQ0?=
 =?utf-8?B?UWg3anVKaDdDdHRVMXRyY1dwUXk5YWNKYk5vYmpqTm01RVdiaXJycEVsK2Jo?=
 =?utf-8?B?SzlJT0NRczhKRW15YUFoRnQxaDlWNlFibmYrN2diek1IUGRDWklqd3BXTmI3?=
 =?utf-8?B?cnYrU1BZZ3pmK1FQSlZEU2tQS242Q1B6VnVGNlRBWmVLeXZubzhWRDE2TSt0?=
 =?utf-8?B?VDJRL2ptbDhRYzFONC9qcnl2TklZNzV1SUZHY1ZQdHZtRGFZc1pNRkpLUGpx?=
 =?utf-8?B?UElpNU9mS3ZMdnhOdDhLZ0JwbVVjcTA2VkMyVVBzUGpYSWdPbkNRS3Vrb0lB?=
 =?utf-8?B?U01lT2VHOFpxa2gvUjdob1NnZmY1TDE5QzRKbk9XVy9yVE05TEZsVUhyYW5Y?=
 =?utf-8?B?dFNsOUFobk90VXBaNDlkdWc1RVVQRDZRZHMvQ2ttUW40ckdvSVkwWEdWelUz?=
 =?utf-8?B?alJFckdSR1BRVjl2anFydWdlWUJNVkJJVjBuY2VoTko4ME54TDFsODdydHVo?=
 =?utf-8?B?WmhValR2b3N4WVBMTU5Xa05teDcxTnB4dGwwaFFNQ3BRc3hQSnpEN29MQy8w?=
 =?utf-8?B?bkk5aE1DUlhDQ1VCcjhxU0lDTURzMC9RQk02RWFQc0E2MVBGNW9DZHNXMUk4?=
 =?utf-8?Q?2fR94ciPtkzcCW6TrGKNoqoETbpcb4Dgnj74g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkxQZ2N6eE5nQm1DeS80TnpaSzl1NVhwd0NTbUJNTThiekE4elVPcFgyQVpP?=
 =?utf-8?B?MVZLbjVDdG5lTGRDZlhaUnNYcGhwSncxZnoyMmRhRHI4eHFPU2xxT1QrU01k?=
 =?utf-8?B?Z0N1K0xIS1VYSTVBdFZjN2lCbzR5RWRiZ1pkODN1aVg2RlEwQjVIRlNia3JR?=
 =?utf-8?B?MG1JVlNyY215Q1M1QW04bys4SDNCZWRQNmhERExBcEFiV2lVV1NlWW9rRnRE?=
 =?utf-8?B?UEYySG41TFFTVnoxc1R6R0M5allNU29yai9WM1hwNGE0QUJlTDVCdjhxZmwx?=
 =?utf-8?B?b1BRVjlhc0hiclNTbGcyOVRONlpHaXhrbEJZNVg0ckw0cXNhbkRUUkV5WGtt?=
 =?utf-8?B?RVFrZVg4cTNod285Yk9FZU1YUUVqdnRXOCs0VlVQWkVvQWFmLzdvQk5Jam9i?=
 =?utf-8?B?cEl2SlVMY243VStLd1ZOaDh6QlBNTWNhQ0h1MnZoaVh2YlNRTEhQNHljTWVm?=
 =?utf-8?B?NFF4SUZzOU1kb2Zab3htNXpNa0g5bjFFZ3NTQ1JiT1dHUUc4YmRuRjZ0dzNT?=
 =?utf-8?B?ZUw2MTkrejQwY0FPcm81UjZLZnJYWXpjZ1Rxb3F2Sy9kVkFBb0lRME12ZVZH?=
 =?utf-8?B?OFRQVmFqUk1Gb2ZieDJrZDZlbnpjZVBEdi9KcWpDUWJMakNTaUp5K1RocTRK?=
 =?utf-8?B?aEFoeGNHK0FHZDcrK1ZWS1N2QUczN1dheTJMMFFPYWVScnNFR0tZQ3pLYTBn?=
 =?utf-8?B?b1B1M282ZGVmWTNPdkdDSVQ1WWRKS014NS9XaGFqVitxdlY2bkVwR25tODcr?=
 =?utf-8?B?cURWN0tpQzV2REM5VlozYWk4aldYQkUrQldGL0hWeVFoS1FSM1JnT2pRWHJM?=
 =?utf-8?B?QkxuQzJvNzlTQVlVMVRoaWFPR0Z4elZQZllWTXZFNTA5NlVsWHJadWJkLzl4?=
 =?utf-8?B?dTVuR0FNTDNHSi9xTjAxT3J0cGFFQ2hZNkZuRFF3MStZaS80SnJQWG9lNk1p?=
 =?utf-8?B?eXYreGwwYTk5WlBQcUFoNFZydW5KNTFSMmFueDlYY3V3cnZaVG5Nd0paOGxh?=
 =?utf-8?B?MlJEK3hhRzVZYW4rV2tkSytMeFlNWjBteWkweDlXTDFoM2YyNVdlUDdzNWtk?=
 =?utf-8?B?R0RTYWs5Qy91MFRCRXRmVFcyZjkzRG1uOGdXeHQ2S1JFQ3Jtc016Nkxta2ps?=
 =?utf-8?B?ZVRyUjdYUjNFalpvOUszY3h2RzViOWNpTXhNTXVXTk43U0h4R2lnemkwZmdE?=
 =?utf-8?B?RDNTdEF2YUsya0hKd1M4ZGQ3cWtHMkxleXZWZlB5MW12b0JvUjFhREkvTXhj?=
 =?utf-8?B?OFpGVitVMnZwdXR5T29nR0pxbDdrVXA5N2RmemszMFRxSGtwSVhtRExXTjJ4?=
 =?utf-8?B?SUxpKzFiVHRRRWNDQVl3MVppSUN1aVhheTV6OE14UGVLbVpQV0RPRWlpcFdn?=
 =?utf-8?B?UnhILzFXN3ZIa1F6aEFTdFJJUUdXMkN0ZlhlQytQaFhtcHFrNmVIWm5TMmRw?=
 =?utf-8?B?MTI1R3JtclphUlpKbk9GQ2VrTFVjOG9vRGpYNVJiME8vbnZCSnc3TDFKbE00?=
 =?utf-8?B?ZlBMa1VBVEFhN2N6dEtDWUJ6MTR3dlJKSjYvT1RKYlRDeFR6RERlVE53bExQ?=
 =?utf-8?B?endMaWIyVVhtZlFQU0ZBNjNHbDlLbTdFSVVsQTFZQktWV3dBcDJiOHdoUDMz?=
 =?utf-8?B?ZTlCVU9JRGdHS3ZLRGZiSHFVcEI1TExUS0I1MFFCWnBUWnRSelhOd2NITURH?=
 =?utf-8?B?YTVDNVozQ3RibVR1TWg0bHpXYTBuaTI1aitWN3pLTmpkcFNONVRsVWllRk1H?=
 =?utf-8?B?Rm93a1UxK3pIWVlzblpTdmhvZ2JoNDlYN3FkZTdTN1hOcDU3RGtDNDlBMThy?=
 =?utf-8?B?ZURHTllIZjR1aHo5L3dFaGhLVHlVbUpGNVVhN2JMSDVZd2E3anpYdmN6Wms2?=
 =?utf-8?B?azR2MWdweitCU2c3bjV1eFNGRTZCMG8rMXIxN0tqSGMwbnlFV1NobWFhVzhh?=
 =?utf-8?B?ajNsbTRKeTNhNzhzOEpUUkhOc0NIUDVjR1gyVGNTWUYvdG9GcUhCalIveUt5?=
 =?utf-8?B?VGVjTWUzMVFqS1NoaEpIMmpuT1BHQzdOdmwrQVJpckpqc1Y0TnFNZ3h5TFNr?=
 =?utf-8?B?Wk40MytnWVZSRFZRNm9NMFhrUXpLNFgvYzdPU0hBbVZGZ05vSHY0d2RYMGVm?=
 =?utf-8?Q?Yx9EouD08ngAdUpxg/GsTyOXb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ef4989-0e30-4991-33d5-08dcd341aae7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 15:43:37.5287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qygIaQ/aDdbPR6YxAQiUEMPoZ0vlAbzRBBhWFKyUiBAC9dYJd4Ta8EBZvM0KvWOHMwkgzpIncTn5SzIKn6EP6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6336
X-OriginatorOrg: intel.com

On 9/11/2024 1:56 AM, Alexander Graf wrote:
> 
> On 11.09.24 06:01, Xing, Cedric wrote:
>>
>> On 9/10/2024 12:09 PM, Jean-Philippe Brucker wrote:
>>> Hi Cedric,
>>>
>>> On Sat, Sep 07, 2024 at 11:56:18PM -0500, Cedric Xing wrote:
>>>> Patch 2 introduces event log support for RTMRs, addressing the fact 
>>>> that the
>>>> standalone values of RTMRs, which represent the cumulative digests of
>>>> sequential events, are not fully informative on their own.
>>>
>>> Would each event_log include the events that firmware wrote before 
>>> Linux?
>> No. The log format proposed here is textual and incompatible with TCG2
>> log format.
>>
>> The proposed log format is based on the CoCo event log -
>> https://github.com/confidential-containers/guest-components/issues/495.
>>
>>> I'm wondering how this coexists with /sys/firmware/acpi/tables/data/ 
>>> CCEL.
>> The proposed log will take over after booting to Linux. The `SYNC` line
>> in the log captures the RTMR value before it, which can be used to
>> verify CCEL left off by the virtual firmware.
>>
>>> Maybe something like: CCEL only contains pre-Linux events. The TSM 
>>> driver
>>> parses CCEL (using a format specific to the arch, for example TCG2),
>>> separates the events by MR and produces event_log files in
>>> /sys/kernel/tsm/, possibly in a different format like CEL-TLV. Is that
>>> what you envision for TDX?
>>>
>> CCEL will be pre-Linux only. Given the proposed format is incompatible
>> with TCG2 format, I don't think those 2 logs will be merged. But if we
>> get any success in this new log format, we may influence the UEFI/OVMF
>> community to adopt this new format in future.
>>
>> We have evaluated both TCG2 and CEL formats but arrived in this new
>> format because we'd like to support ALL applications. And the only sane
>> way I could figure out is to separate the log into 2 layers - an
>> application specific semantics layer (a contract between the application
>> and the verifier), and an application agnostic storage layer
>> (implemented by the kernel). The common problem of TCG2 and CEL is that
>> the event/content tag/type dictates which part of the event data/content
>> to hash, meaning the kernel must understand an event record before
>> hashing it. And that has prevented an application agnostic storage 
>> design.
>>
>> Anyway, this new log can be encapsulated in both CEL-JSON (like what
>> systemd is doing today) and TCG2 (using the EV_ACTION event type)
>> formats. Please see the CoCo issue (link given above) for more details.
>>
>>> I ask because I've been looking into this interface for Arm CCA, and
>>> having unified event logs available somewhere in /sys/kernel/confg/tsm
>>> would be very convenient for users (avoids having to parse and convert
>>> different /sys/firmware interfaces along with Linux event logs). I would
>>> have put a single event_log in /sys/kernel/config/tsm/report/ but
>>> splitting it by MR should work too.
>>>
>> We have considered one global log vs. per-MR logs. In fact, a global log
>> is equivalent to the concatenation of all per-MR logs. We've adopted the
>> per-MR approach to keep the log optional - i.e., an RTMR can be extended
>> directly (by writing to its `digest` attribute) without a log.
>>
>> With regard to the location of the MR tree, we picked sysfs because the
>> MRs (and associated logs) are global and fit more into the semantics of
>> sysfs than configfs. Dan W. and I are also considering moving both
>> report/ and measurement/ trees into securityfs. It'll be highly
>> appreciated if you (and Alex, and everyone) can share your insights.
>>
>>> As Alex I believe we need more similarity between the interfaces of 
>>> static
>>> and runtime measurements, because verifiers may benefit from an event 
>>> log
>>> of static measurements. For example Arm could have a configuration like
>>> this:
>>>
>>>    struct tsm_measurement_register arm_cca_mrs[] = {
>>>       { MR_(rim) | TSM_MR_F_R | TSM_MR_F_LOG, HA },
>>>       { MR_(rem0) | TSM_MR_F_R | TSM_MR_F_X | TSM_MR_F_LOG, HA },
>>>       ...
>>>       { MR_(rem3) | TSM_MR_F_R | TSM_MR_F_X | TSM_MR_F_LOG, HA },
>>>    };
>>>
>>> Here rim is a static measurement of the initial VM state, impossible to
>>> extend but could have an event log. rem0-3 are runtime measurements,
>>> extensible by firmware and then Linux. None of the digests can be 
>>> written
>>> directly, only extended and read with calls to the upper layer. The tree
>>> would be:
>>>
>>>    /sys/kernel/config/tsm/
>>>    ├── rim
>>>    │   ├── digest
>>>    │   ├── event_log
>>>    │   └── hash_algo
>>>    ├── rem0
>>>    │   ├── digest
>>>    │   ├── append_event
>>>    │   ├── event_log
>>>    │   └── hash_algo
>>>    ...
>>>    ├── rem3
>>>    │   ├── digest
>>>    │   ├── append_event
>>>    │   ├── event_log
>>>    │   └── hash_algo
>>>    └── report/$name
>>>        ├── inblob
>>>        └── outblob
>>>
>> I see. The desired/missing feature here I think is to allow a CC guest
>> driver to supply an "initial log". I can define a LOG bit, which if set,
>> will make the MR its own dir with `hash_algo` and `event_log`. And if X
>> is also set, then `append_event` will appear as well. Does this sound
>> like what Alex and you are looking for?
> 
> 
> I don't understand why we want to have 2 separate representations for a 
> "measurement object": flat file as well as directory. Could you please 
> elaborate on the rationale why you think it would be desirable to have a 
> non-directory representation at all? I feel like I'm missing something :)
> 
The intention is to make a cleaner user interface. Generally, the flat 
files contain information ready to be consumed by applications, while 
those in directories are less ready - e.g., the log may have to be 
parsed to extract the measurements of interest. In the case of TDX, 
MRCONFIGID, MROWNER, and MROWNERCONFIG are essentially 3 arbitrary 
48-byte values and would be more straightforward to be presented as 3 files.

The necessity for a log associated with any MR arises from the need to 
"share" the MR - i.e., there are more measurements than MRs and there's 
a need for those measurements to be assessed/processed individually. 
Rather than asking individual applications to parse a log, it'd be 
desirable for CC guest drivers to "unpack" the log into a set of 
"artificial" MRs consumable by applications. E.g., if a standardized 
method for conveying boot time configuration/policies to CVMs were 
established to be an array of "artificial" CCR0..CCRn (Cvm Config 
Register), a potential implementation could be to store the array within 
some static MR's log to be extracted then exposed by the CC guest driver 
as a set of flat files. This example of course doesn't mandate flat 
files. It simply showcases that there are both simple values and more 
complex data in the "measurement tree", and the idea here is to offer an 
option to differentiate them (wherever/whenever the CC guest driver sees 
fit), with the intention to simplify navigation for users and/or 
application developers.

> What if for example next-next-gen SEV-SNP suddenly gains event log 
> support for its launch digest? We would create needless churn on user 
> space to dynamically determine whether it should read things as 
> directory or as file. Or even worse: Newer kernels would simply always 
> set the LOG bit and we suddenly break the user space ABI for existing 
> environments that run on current-gen SEV-SNP.
> 
This is a great point! I'd say, if the log was on the product road map, 
the CC guest driver should opt for a directory on day 1. Otherwise, I'd 
expect an MR name change with such a semantic shift, and the CC guest 
driver could then extract the "old" digest from the log per the original 
semantics, and present it under its original name.

Finally, I don't mean to force flat files for static MRs (I once did, 
but Jean and you have me convinced :)). It will be just an option.

-Cedric

