Return-Path: <linux-kernel+bounces-522952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A887CA3D081
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0DC189A8AF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C571E0E15;
	Thu, 20 Feb 2025 04:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maI6UNOb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280AF1DF97A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740026304; cv=fail; b=JwWKwPasywICEKv8bdBaK05NQcxQoGOMu5i9wSPSJVsjItS14q4boPZXxKULThe1APxg5PSozdwkVPBeWwKC/+MZFkdcERqcF75MIGJ17W2xgXUP/V8mqCnaw+IIpBc0sEwxYv15fo9qFOeLef+KPBNg5AZDy0+DonJMZybo/Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740026304; c=relaxed/simple;
	bh=twVUXd4H0GjVE1DQ4o+ktgBuONXyp1GGPcf2OxCfgIg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qMc3v7Q+h/Sd46jvExjLZDRVS8bxpbOdsO8pUPAls3rvHa+KHsSL/VHWMWWV9YspP3ZnUHt0sIkCsqMv+iflIlZUiaeVWlq6fEviq31FWtSVqIIVrm0sRNo6s2oXhvIYyswPglC4cLaHpmgLXHphgKllNIxXdJ7fkcEIf+GSAFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maI6UNOb; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740026302; x=1771562302;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=twVUXd4H0GjVE1DQ4o+ktgBuONXyp1GGPcf2OxCfgIg=;
  b=maI6UNObCaNvFONsfakYA/XNSvlajlKdNbi9F0oSAbFh/OORgB/FPRD+
   Pi6axdlsmGTAqPRzde4bdsbjetCylHhzj26aV43f0GiZlhJ2Rug5+hL04
   n28vJqiviSky5lD3ttHSXStbA8aWQoWzLLXHNyCYriapR8RQVxIb3Ba/p
   fJpuAMWTLXFDLucG/JGEaNanHmUAxE3AGeJSu8O8ZJeadYF1hX7YAsmd4
   14WLlNJqS/laqY4FizTQViEc5GH0sn/r4M7wHb8TjibksawPjqkR3bBMh
   3Ei9CHZxf1K9uGbpe602WBw6nU9365VQRSV18HOcHpDdlxYiLkaRBiSUW
   g==;
X-CSE-ConnectionGUID: XxDHlVDXRSCWLE0dgVz4dw==
X-CSE-MsgGUID: dW5hJhYZRniD/8A4YCE4lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="63268318"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="63268318"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 20:38:21 -0800
X-CSE-ConnectionGUID: a0n+YSIrQo2vbvl1T0Y8Iw==
X-CSE-MsgGUID: nJnEQjLBRFq8U4qnslFRaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114776062"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 20:38:22 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 20:38:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 20:38:20 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 20:38:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2goOMB0CTjwX6nKeWbRVC0lZY55NMO8wn5SpIYIwCUgfu8+XzeMR/ISj/7p796v/8gXXtnG2zehFkHdhJI4bqz9DT7u5uyMf8tdLZwbKqI2t/LL1bJ+EycLxBwyv/Br2PW4mePpEIab0uh2Wemiw65NBHAGeKT4Uw52fyuY1YzJ/fXklXGt7RzOA08aHs+6RtnewcDYZZhxVKTiXczMaG/41UTKZ40vbU+DP8Zi2ScS1E12fJwZK6pn1EHENXZoDP3wmHqq+doSGn2kNPARVTh6c9w+110qpNNP9gP4GVOrCd0D1JXe4BQCFzFSXQ+1TAnrEYYMfHbZ24bDzNvL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/P6HID/iq6M36DkNvQnc/3NHDGeu37eC7kgpBdGYB8=;
 b=jh2qdQkjZnlcdTukjCnyJ9prGUqE7+0A+zL8EvB3jOboqvAXniZgVM6lKRgasGCaQwU77JFjXr8W1Gq6h1krOXxN2t1l92GFBSncRrDCydqzEL9mcoVRAWN0Bw5de6d17uyaVbI6qWkOBgqm9a1Eh0CKe3OeOPcN2n9YgJjV8njwxJnkj8XSKjyprbxs/ZrA4dK1Yy4jJYiHQH7Oze+BUAbsy5ONrEcZ1u7cnVilz6CtrmyuGvqJdI5ZXhPdH/CTuTC6Cb3qlu3WPs7uERLzR9kXTUiNQiUXaAfpMOxMdhtXyT03NemDX4N8jxgRA88rqcBi0lqNzMJ7txXWpSG4Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 PH0PR11MB4919.namprd11.prod.outlook.com (2603:10b6:510:34::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.15; Thu, 20 Feb 2025 04:38:04 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%3]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 04:38:03 +0000
Message-ID: <b2bed5a9-9b1b-4205-9730-ef6e91b9cdd5@intel.com>
Date: Wed, 19 Feb 2025 22:37:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tsm: Unified Measurement Register ABI for TVMs
To: "Huang, Kai" <kai.huang@intel.com>, "mikko.ylinen@linux.intel.com"
	<mikko.ylinen@linux.intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
 <15c69d57-4ffb-4ea1-8cbc-0ba6d3d7b14f@intel.com>
 <be7e3c9d-208a-4bda-b8cf-9119f3e0c4ce@intel.com>
 <015cdddb-7f74-4205-af8a-b15cad7ddc22@intel.com>
 <d8f3eb33-d902-4391-adc7-005e4895b471@intel.com>
 <Z7Sd6FuDDMgExEna@himmelriiki>
 <465d712c-b638-4884-88c8-1a88c506efdf@intel.com>
 <3ac005e3b72f51199742e0202cb289726ac4c1da.camel@intel.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <3ac005e3b72f51199742e0202cb289726ac4c1da.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0184.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::9) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|PH0PR11MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: 653f8e87-8ab1-4a1b-0df1-08dd51685cec
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTh1aFJ2b01kZ0R1U2lvbklvemYySEN4VDhJcjRFVlAyeFBXSUN3U2pBRkFp?=
 =?utf-8?B?WHJ3V2pja2ZzbERXdDRUV3dWaVdZOWJOdDYzdWtMVWhRM2VCMWF6dnlLSVo3?=
 =?utf-8?B?SHh3S1BvaHZ1aGRwbWZYOEppaDhtdkM0YXFiWEo3RW92K3FyYkUrQThSSUF4?=
 =?utf-8?B?Q2V3QWNXdDVleEg5MGwvSkpYTEJQMHdud1VOQWVrNEVtTnpyd1FWS2dpOUxY?=
 =?utf-8?B?bnh4UlBlUHlKaVdyWmlRMUFnY3UxVzZzd3NobUJMSnVxNlpxcWJDOG1qTzE3?=
 =?utf-8?B?UDFBVTRMVStya0pCWWJsZ0VHOFdWb1RzUzczR210MWhpcHg5NzQzZGtteUZI?=
 =?utf-8?B?c1ZmK0h4ZjliR3FOTHhQdnNyakVBZGdlK0dRNFBXRklQanE5dG90QnIxc0FT?=
 =?utf-8?B?L2dvUm5RN2NjQkIyQTg4ZThudTJ1Q0MxNysrOXhSVlNBMUJPdGFPamVybkRY?=
 =?utf-8?B?WTBLcWZQd0g3Z3IwdXEyb0V0L0w1ZmRvWGxaZzFVRmdLR2E2Tk5vUVhJOUpy?=
 =?utf-8?B?ZWRDZjJOa2lOcnMrREZUNTlJRGl2Vi9KbmJveGp2T2QzQ2tXL0wwRlFNYjR4?=
 =?utf-8?B?TFNNeHZheDh2clFzSkprMVZ3S21uQmpBRGNuZ2QvQi8reWRtY3pyQkFMUmpQ?=
 =?utf-8?B?aXpEYzErRzM2KzBJSkswcFdYQTkzVnlwNjUyT2lGdEtlMFQvdDhwZ2h5elRt?=
 =?utf-8?B?R3RDWXh6cnk3bEZUSVdVSzEyVmg2eDZqUlFOMjI0aktHb1N4L0JNbEFOMW1B?=
 =?utf-8?B?dUQwblRBUFNPdjc4SXFhTWJLS0J0RVpzV29Mc0gvQkRPRHlNVFhURTJSZ3NT?=
 =?utf-8?B?bEtMMGhaa24xSWxvakZqaFl1ek1NSHhlWU1jQ1huNW9EZ1UxT1JBcytNdGUv?=
 =?utf-8?B?VEs5dXdVWFI5azRlbnhNOStWdjVPTUNmYmdxRWd3bXY5a0l4UWsrbHVMOGZJ?=
 =?utf-8?B?SnBIWXRZeHlZb1FoMWhUMDdyeG1KVWEyVnNYL0ppdVViUlBITTVXa3pHQ1FJ?=
 =?utf-8?B?bURWU0dRY1Y5QXFXcHVkU1hVUGtSZDJZTkpER3AvdHoyeEpxcHdMTEd4V3FV?=
 =?utf-8?B?L01lMXRxd0JPT21aekFIM2xRN2Y3NVFOYU81bmo3eG04ZDhIYWo1YmdJZEZS?=
 =?utf-8?B?YlF3K3k0UUZxTVFaZFhMNWNMQk8zQU9RaGdSRDl0US94WmF1c3dTNHZQRnd3?=
 =?utf-8?B?RGJIbWVUYkZyTEpWRGE1ckRGaEt0bXc0RkdZSFJuNzBDVXdNOWxCYUpPejJP?=
 =?utf-8?B?UFdjMzRBY2hHNlhtMnJlcVR5Lzk1SE9QR0Y3T01mRGRjMjZQRU9wYit5MWtL?=
 =?utf-8?B?ai9od1RWVEh0QW83bG94Z25SWmsyajlURHdLTHV6VHdGRE9FbGNOanU3NER2?=
 =?utf-8?B?TENES212TnN2Mzlhb3pLNTNvQkNvNXpMcURodVl1dDl1UDJ1NUlseWxMMi9C?=
 =?utf-8?B?bmNWenlkeDRyK2x1a204dzc2Y1ZsTW5oSjd5R2lockFHMVhERUFCenJXbEJu?=
 =?utf-8?B?cms4ZDZrUlVhOU9jbEtlSHl3SFFaVCtQZUtiWWdQUmxTR2dSaHh1YXZmbllX?=
 =?utf-8?B?QzFNZjVsU1FKTG01b3JUa01wWTMyN0ZBTVprU3VvNkFPaCt6eUtTc2Y4ZHcx?=
 =?utf-8?B?UGpyZUZubTVuZEVCczkxUlJoTytBWDViN3ZWWEp5OE1iRnR3NW1iVGNpOHRZ?=
 =?utf-8?B?QkVNSnBtbmp6dmQyMnh3UWhUN0RFQlYxOGxUM3UzblRJaEdiOUM4TnFibXM2?=
 =?utf-8?B?REp3ZGZyUkVJMTJmei9JS29OVG1YVFRzWXF4UHVmR0Vwa01JTkY3SElLaFZN?=
 =?utf-8?B?Wmg4RjcrTWlwN0c5V04vWFREK3dqVDhNcnJSL29uSHBlVHgwYitEeTFZZUtI?=
 =?utf-8?Q?fWdCxokStm+k5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmhjbzNsUkRhM0JtNUx0NThyaHdaeXZlNE5YdEZNdVhGM28rbDYrYUVyVVh0?=
 =?utf-8?B?dWtIM3dHNEowV1NSNlhlSTZpRFpLbkxOQzRySGVNK083dGZIVlhzeXpaanRq?=
 =?utf-8?B?MGtHTktQSlVMRXNDRSs0d3d5bTZrSWRXNlVnZ2ZWN2EvWjdtWFlMbmVld0lR?=
 =?utf-8?B?bmFxa3ZRN3FiQ2xjVFBXTnVpM1R0bTBQM2lvSXJqdlA1bENzRk5GNGtFWkZL?=
 =?utf-8?B?Tm5zYjdMZ0tNYVNsWVJiZHZqd1dhdlRHajZiTE1Wb0lyZjZUN1J1WVdtWmo5?=
 =?utf-8?B?RTVneHlxUWpSekJxelNZTEwvTDk0K2FOMHBZOGpFemo3cC9Va2ZoSlZtQ3g4?=
 =?utf-8?B?TU9GcE9KWHgydGR6RnYrK0Jjb2NTNldvVUlBQ2JNZkFRQXhuL3RzcHIrbmUx?=
 =?utf-8?B?WDlPM3Z0RGRjbDR2a0RPMGNKT1Q3THhsUmo5a0lFb2sxSS9TK2RaR0dJZEpz?=
 =?utf-8?B?NUhqTmxHUm4vTGIwbEtOYU5qM2VjOFRKUUxZSng1L09wUkthenhVZWtocXdE?=
 =?utf-8?B?RkdkQlVsTmxuU3EyUHNCem9vS2dza1lWLzhYR2dFMHVmRnZlVlMvZnoxVjF3?=
 =?utf-8?B?aXZCWWplRGMwSWhSa29aaHBleU5ON3J2VFBTdHY3WDBFeDh2VllMaWJTSG1v?=
 =?utf-8?B?cGdwZ0J3NDdFQzBhUkdmWUtJdnA1OVBQOEJQLzJKQUxIallBYlNjWEtYc2Vt?=
 =?utf-8?B?Z2M3OGZXRkdvTkpQNFBXcnFkaFM3dlJWM0JCakFleHluR1NGeEFLM1F3R3Mz?=
 =?utf-8?B?aHUxSUJLU0lMRTRDVlJKZE0vQnRZZ2VWbC9XTXFmYzV5S3JSYTNVN0kwVnY2?=
 =?utf-8?B?QkNpOVRuME0rKzNxZDROUEdBRkZOT1BoNXNaeFdDNm1rZmRVbGZoN3BTYWpk?=
 =?utf-8?B?UGpvdVU4Rzh1ZFR6SFdsZkIxekFncUcxSmxYN0ttczRIWU5HdUNtaCtzMERQ?=
 =?utf-8?B?M1RPK2R0UWo2VXdnK1Z4eWpoUjIyTS9CdG1rRjRIZnVKSVNNdFo5YlVTNGd6?=
 =?utf-8?B?Nk5wM3lJQS8zMndYNnh4dHJEcmFEbUhpc3RxdVlHSm5MOG5FdTdGaHVPa3RF?=
 =?utf-8?B?Vzkvcy9NbXFqakJtbVFNNXhxSnBqUXBERGtOOW5ObXBmcnhlK0N1S0dTaTJ1?=
 =?utf-8?B?S0V4M21NWDhLVkhEemlDcTZkUXhrSmZ2VW51WDVLZW9rcWlOVTdtWGk2OXhT?=
 =?utf-8?B?VVhwSTJjTmpMWks1UzFWbEZYYktXZlpUMXhhTDVsb1IvbHNDS2Mrb25SLyti?=
 =?utf-8?B?ejNDWTZtWnMzWFl0clpWc3IwM1N0VDllV01mVml1c3hGaktzaWV6MEJhdktU?=
 =?utf-8?B?WHR0V01qMDRHQzB3eml4bmZlVy8yTFhicEU1U204SlN1S0hENHd4NUVTY01L?=
 =?utf-8?B?b0FLdFBhTG1kOTVVN2VZb1NmdWJnL25PSmsxeU43MGRWZ0JKNi9jTHZMY2tw?=
 =?utf-8?B?NUdLaUF2RUNBZ2xISkEzc2RJREY1YXR6TXo1K2hMU1pUaytxYzV1dlN3b0I1?=
 =?utf-8?B?ak5NelJNakFaa2VTV0IrMWV3empya3prWHVJd2dwYnVwYXp3OXFiUmFWVS9B?=
 =?utf-8?B?Y3MzL2hma1EvZGM1eDh6aWdJSitCVlUwTEYybmdFWHhhZHNlNHVWUm83a1FJ?=
 =?utf-8?B?dGxRNHBlYkZGd1pyZnRzU1VMcGthWE5TdjUrbC8vNWM3QldIMXhHN0Y3cjBz?=
 =?utf-8?B?YkhicGp6b0h6TGhLcGhQVEZ1dlBLYjlweUNVbDVpbVc4UHAzZVp0MkRYNlBu?=
 =?utf-8?B?WklLYnJwNG9rTFovZFZyVEJFV2oxUmtuVU1rWFh5eXFBTUl2aEdsUk14bEZN?=
 =?utf-8?B?b2UzK0pRcXc3WllIUThwNDI5OURwek0waFhuamVOekpvQmxYYzB1TEtwVzF4?=
 =?utf-8?B?ampVTzdUSG9EN1hDQTBjRFJ4RlhGbVlYTWUyc29seGNYM01LR0VhWWxVMmpy?=
 =?utf-8?B?TzdUSmdQcStSSmE4NXFCdzBQQUFkU2ZKYU5NRHkxTG5zMzl3SDRPbjkxNjFR?=
 =?utf-8?B?NGxwamN5WGNBcXpSVkN5RS9ld2UvVzVFMGhSWTUrM2Vyd014ZnM4U2EyWDJj?=
 =?utf-8?B?Z2xoYnF4S2dpNDUvMmJ3N3pCMjNlcE1sRTlWWlQ3TEpQL0xIU1N3U0g2NHhj?=
 =?utf-8?Q?GcokJuTQC/YodMoqwH4nC8uh+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 653f8e87-8ab1-4a1b-0df1-08dd51685cec
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 04:38:03.5771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIyQlgjJbZhqxeTWU3K/mTg8dTyfJE5YYigF3qnHNxdMczT4K/vbATtnlQhSj+boE+rn8PRYpKbtOHjhi28jtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4919
X-OriginatorOrg: intel.com

On 2/19/2025 5:31 AM, Huang, Kai wrote:
> On Tue, 2025-02-18 at 22:04 -0600, Xing, Cedric wrote:
>> On 2/18/2025 8:49 AM, Mikko Ylinen wrote:
>>> On Thu, Feb 13, 2025 at 03:50:19PM -0600, Xing, Cedric wrote:
>>>> On 2/13/2025 10:58 AM, Dave Hansen wrote:
>>>>> On 2/13/25 08:21, Xing, Cedric wrote:
>>>>>> On 2/12/2025 10:50 PM, Dave Hansen wrote:
>>>>>>> On 2/12/25 18:23, Cedric Xing wrote:
>>>>>>>> NOTE: This patch series introduces the Measurement Register (MR) ABI,
>>>>>>>> and
>>>>>>>> is a continuation of the RFC series on the same topic [1].
>>>>>>>
>>>>>>> Could you please explain how the benefits of this series are helpful to
>>>>>>> end users?
>>>>>>
>>>>>> This series exposes MRs as sysfs attributes, allowing end users to
>>>>>> access them effortlessly without needing to write any code. This
>>>>>> simplifies the process of debugging and diagnosing measurement-related
>>>>>> issues. Additionally, it makes the CC architecture more intuitive for
>>>>>> newcomers.
>>>>>
>>>>> Wait a sec, so there's already ABI for manipulating these? This just
>>>>> adds a parallel sysfs interface to the existing ABI?
>>>>>
>>>> No, this is new. There's no existing ABI for accessing measurement registers
>>>> from within a TVM (TEE VM). Currently, on TDX for example, reading TDX
>>>> measurement registers (MRs) must be done by getting a TD quote. And there's
>>>> no way to extend any RTMRs. Therefore, it would be much easier end users to
>>>
>>> TD reports *are* available through the tdx_guest ioctl so there's overlap
>>> with the suggested reportdata/report0 entries at least. Since configfs-tsm
>>> provides the generic transport for TVM reports, the best option to make report0
>>> available is through configfs-tsm reports.
>>>
>> Given the purpose of TSM, I once thought this TDX_CMD_GET_REPORT0 ioctl
>> of /dev/tdx_guest had been deprecated but I was wrong.
>>
>> However, unlocked_ioctl is the only fops remaining on /dev/tdx_guest and
>> TDX_CMD_GET_REPORT0 is the only command supported. It might soon be time
>> to deprecate this interface.
> 
> I agree.
> 
>>
>>> The use case on MRCONFIGID mentioned later in this thread does not depend
>>> on this series. It's easy for the user-space to interprete the full report
>>> to find MRCONFIGID or any other register value (the same is true for HOSTDATA
>>> on SNP).
>>>
>> Yes, parsing the full report will always be an option. But reading
>> static MRs like MRCONDFIGID or HOSTDATA from sysfs attributes will be
>> way more convenient.
> 
> But, theoretically, you cannot really trust what your read from the kernel for
> such *single field*, because to truly get verified you will need to get the full
> report anyway.
> 
Not exactly. Whatever the kernel extracts from a report deemed 
trustworthy by the kernel itself is implicitly trusted by any 
application having the kernel in its TCB. And in fact, every application 
has the kernel in its TCB. Therefore, MRCONFIGID or HOSTDATA read from 
sysfs can be trusted/used directly by any applications.

>>
>> Additionally, this sysfs interface is more friendly to newcomers, as
>> everyone can tell what MRs are available from the directory tree
>> structure, rather than studying processor manuals.
>>
>>> The question here is whether there's any real benefit for the kernel to
>>> expose the provider specific report details through sysfs or could we focus on
>>> the RTMR extend capability only.
>>>
>> Again, parsing the full report is always an alternative for reading any
>> MRs from the underlying arch. But it's much more convenient to read them
>> from files, which I believe is a REAL benefit.
>>
>> Or can we flip the question around and ask: is there any real benefit
>> NOT to allow reading MRs as files and force users and applications to go
>> through an arch specific IOCTL interface?
>>
> 
> As above, I am not convinced that *reading* MRs alone is that useful.  What you
> need is a unified way to *extend* those MRs.
> 
See my response above.

> And yeah I agree extending arch-specific IOCTL to support extending any runtime
> MR isn't a good idea.
> 

