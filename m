Return-Path: <linux-kernel+bounces-400813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E82009C12B2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14CC51C22284
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB9D1F4FAC;
	Thu,  7 Nov 2024 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/5urKln"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4560E1EC019
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 23:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731023109; cv=fail; b=rm7gHGJX1kuOK9jiapCQXGDwMk3HMJBYJe4k6USTkc78QZFLqFJwhcK5AzsAyh5zrBlLgTejjcNsYc7Pwkjl9B4WHBDkAmSnesYkWob82GDOAD4inUozrrgmFxRoeZUdoWQmET11cSuYX++U7FdXp3Dtv+cOTB6sza3Oiiai39A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731023109; c=relaxed/simple;
	bh=XrMwdwCwSSbQF3ZIvvXhbC5rpZeTmWUyrwocnDfIPt4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YilNP2OG4OWCGtkQJAj6E0PMkTk6dIwO3aGApKlarqe56lnE7xNXPBmL7UimW9NQc41/Fhgu9i2TEw+ElYrFUT/w9QH2dqV4WDHy8KsR4FmncaPl9X+yXKaI+0EoiXclcxHLCe/DTsFUyqY0HbxNz+W0Wk5ZOfudwKsVnUziKOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/5urKln; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731023107; x=1762559107;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XrMwdwCwSSbQF3ZIvvXhbC5rpZeTmWUyrwocnDfIPt4=;
  b=U/5urKlnLK0I/caUAuZGyqMJELjVAK6MEmRRQLM1w+WxCh4pSncx8Mcw
   7OQGoalM/N+BcXsUIm5e1rFNVkfu03psMHrwsTrjEd0/XicbN+OiApWod
   mE5LnMWMPHqpxiJbRcvW01EbtDapoOQSSbpV33mZDb5PVBVt48vbLHXvK
   IAQ96Zv/07/0CazW9o4CoTFSlfopCDF/1GuyuQ0ztpOqLL3ZG5ZpHxWBX
   E0nawGpO25LgqNlMCXiER3M+WzMtplCqhaLRXtQXLamIc9HHjuk7f7qpT
   o8ALR0+igkWP6Jp93S0uBJfH+ACXO6WAkheQKQmpe+W83o40NBnsfgIdy
   Q==;
X-CSE-ConnectionGUID: oFuamZUFRB2Syt6aRwwXPg==
X-CSE-MsgGUID: gbfn8RYYRPuouGIomld1dQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30669153"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30669153"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 15:45:07 -0800
X-CSE-ConnectionGUID: CBL5qhn6RMC4mviYKe4cQA==
X-CSE-MsgGUID: WcLHsQ9zSp6S2kjen8LrTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="90151116"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 15:45:07 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 15:45:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 15:45:06 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 15:45:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSkY4rUsdbYhck8h5LZMnj3DvDm0rMcZZ0BQBXHswwqQY2E10OWxphS9uwtNMhG6Go7XXrd3IvcYV1wJ+iUa2Tr19K+72zmRntPReYHRCXMM4aUngLDAFPXbZbVq4D7YhQEkYowTa0zRkyirm7X/Y5O1G8/Cex+nidBrm6m+O94nouHJT1fjglfymK7ZTF1UJWVY3xMqPhhr4S12h0VoOTT3lopyHFSlQwNSXLh0puhKH7DC14Zy6OFrmIIZGCVxbVkF4t5y6HBH6xC8LdDVg/FbS3tT2XUwwme5s/xa8/xeVmDYqEIgVyrlj/t5QHxsKsiisfNBdN7Mq3Z+ArF3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWyG3WSXvDgY60uhZVe5mAY21AT3epw6rObiLPGlZGo=;
 b=NWXMMCDFBystrwalctWIsbM4vNiodzHwQ22H2ij30DDHPYTv4UKdPoWGbo6xosWSKZd62z6Lpi9sQaHX5j9TB802JnS9jSVNAXI/SUSi3kZoDXhPQ+vay2wPsXTUqzNkGTkiMQMWIOGjhWcFhMI9aUKR3mUru9iqZ1kuaaDBlpmdGvw/34jMxplhnOjAEJw7H3lGtoYx8bcq49EbEefk2ej0SgZL/K9w+osE6wNxsNTLrZ5BIY+lsxuCmwGSh/7/h7tvxrGWBRDiczsU2S/2BxYdy01F233ZOTr3WP0cMi+sA5eE+cseCs4Dg6JyzEtB0lJzvPSEOyD6hcqxnwYRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BL4PR11MB8824.namprd11.prod.outlook.com (2603:10b6:208:5a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 23:44:58 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8114.023; Thu, 7 Nov 2024
 23:44:57 +0000
Message-ID: <3492e85d-4aaa-4dd7-9e6a-c8fdc2aa2178@intel.com>
Date: Thu, 7 Nov 2024 15:44:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpufeatures: Free up unused feature bits
To: Dave Hansen <dave.hansen@intel.com>, <x86@kernel.org>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H .
 Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, "Tony
 Luck" <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>
References: <20241107233000.2742619-1-sohil.mehta@intel.com>
 <7ff32a10-1950-434b-8820-bb7c3b408544@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <7ff32a10-1950-434b-8820-bb7c3b408544@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::30) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|BL4PR11MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: a771d252-4073-4b8d-29ef-08dcff863017
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmthT3lLa3hXc3padENBRUNnV2kwSGR5NVE5RDFDQklERzJjSWV5VllKb0Ir?=
 =?utf-8?B?OWVlTTdMWGt1YUs1cStJbDZ6cFNuTDZWZDRWNWxZdy9xMUZoallxUk5PdURU?=
 =?utf-8?B?YXdIdWxnMm1MUlJDbEpWMEpHc0VLeHpQenI1MFdYTkp5M28yLzQ3QzhLT2Zr?=
 =?utf-8?B?K1RFWTdLOS9KYnMyc05aSkJSTjB1TkhLQVhad3VPd3FpdmpRMWkrNHRlVjA0?=
 =?utf-8?B?VEZtN0hCeXlsT1MrQmRUdjAzNEtYWWNVdlBCMjMzSUU5U0tjMTk5dTdkT3Y1?=
 =?utf-8?B?cGJWSnpJdVJBUlRmSmhNeGI5WDZZSzFldXpaejZ3M0tFckttbFpIQmZUZDVo?=
 =?utf-8?B?YVg3Y0VUYzdOMU82S1VOcC8rdEo0Z2xodG5MbnFpOW5UcU04V09tME16blQ2?=
 =?utf-8?B?SE9TanB0dkl6dW92Mi9mMUdsd29jT1o0bGhrb09YYjZseGt0Y0VtQXIxTWRM?=
 =?utf-8?B?OHV4UGM3b0ZQUVlielVENzVHOG1pNjQxUFplMkdlQlpxVWdMSG1PRmplTTBO?=
 =?utf-8?B?eTJ2QkM4ei8xVmpGTXhERHdHTDNud0VWRjUxdmNaVlJRZ3FGdVdoTSsyT25p?=
 =?utf-8?B?M1d1ak05TmJLMUs3b3ZYc2FtVEFSTEtwa2NkVnlCaEg4N1djUWxWL1FvMG5B?=
 =?utf-8?B?UGlvbzYrbFpHTGprdG0vNUVON2ZuZWptT3NWZzlVWE1PL2ZFYjJzM1RWY0FR?=
 =?utf-8?B?c2psTlNUWmt2eWpZbjZKdVVOek9zcGt0WXBNWVpERmNzaVFRdGhiNHVRUVFV?=
 =?utf-8?B?aG9hL21SQmp5RGFVU1lhQmZzR1M5REo0ckJnRzZyNGFtaWd5Q0hvTEdIay9W?=
 =?utf-8?B?eFpQNkhraXpaRll5akQ3QlpwTmRuQktWUWVkOEVhNGlFYXNla09GejVVUWw5?=
 =?utf-8?B?V3pyRUQ2aXcyZklpUEhHcm5UdFUraDVWZ2ExcCt2QVB2YVk4a3FYbmU2N2Mr?=
 =?utf-8?B?VlAyam9TSTYvbUJCMG9iREZXa25rVDVZSWltTW1VOGNwZG9LRTFzYjgwUG92?=
 =?utf-8?B?Y2pMR0cya09scFErRnVaZTJXMDZLMmNIM25Tb3NIbU9yeWpCN2lKTmt1cGFP?=
 =?utf-8?B?NjVMVnZUVEJxaStHY0pKdkozeDZOclNHVHZ0RkIxUjIrYm5EeHdWTXFwVXBr?=
 =?utf-8?B?Wm9xdXVkbW9WaGlHZWFQRUV3YVlreDdYdjdNY3U1U2NMWWVxTWlEcStCN2FZ?=
 =?utf-8?B?SmJKQURIaThnVUZpWHRENTVTV1lPUlYwWkJyNEpyWWs1RGxRNDFORi9weFQv?=
 =?utf-8?B?YUtGL0V5dlZQQThKdkJwN1M2VmlHR0xyQ3BXbmlYbHoyb3U1QnRlVzBCVUJa?=
 =?utf-8?B?ZU9FWit2Y05SbWJ0eUIyZDUvdnJjWldOTytkaHlPMk11dnJFZlB0YnBsL1dp?=
 =?utf-8?B?SnA4NHRPYWJGV3E4WUROTFJ3TjM3OTNxVGRmVzM5eXJCQmJES2RUcmhCNkVx?=
 =?utf-8?B?YllkWllIaE5xY0ZvSE1EQU9EaTdSRVJWTE5ETWs0S3NHMmpPWmZFUGZndnd6?=
 =?utf-8?B?cm9iQmdXWmg3OVQ1MktnLzFFc1dMTHhmV2x1azA1WU9wS3lJeWIxNGQrYk9n?=
 =?utf-8?B?R3kxZ29WWmdYdy9GdFd6TExWcUlGRGphYUJPemxIUlVSSXpiK3dUb3RoRS83?=
 =?utf-8?B?anYvWlo1YytNQzYwY25JdzdjY3FhMEVuV3EwQmsvUmhoRDVzd2xyRkRIVzA5?=
 =?utf-8?B?KzZlWCtUNmttYytaTFowSkdPY2tYUm80d3ZKSWtHZkdjbEFsd1prTGtQcWdB?=
 =?utf-8?Q?gWKVhug0cHyEGYIbD0JATiwBpAw+L1EKPLOoNgp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXZqYmJwdTEyMkxUblkxT0Z6ZGRHUXlZMTdvdk9UaXJyVWlOZWMrSFg4Z3JU?=
 =?utf-8?B?ekRmSnRDai9qeUZaTkcwT0RIMHBiazFRQ0dxWEd3cThPV3BCZmhzSHJtMGZI?=
 =?utf-8?B?TUtGU0RpMTRXUkc0dGhqY1FpdGt6RmNDTU5COENsNm4vQzBPU1JYOU5lMVd4?=
 =?utf-8?B?YUFXMHZGZWNQMWxMZXdSZk84TWwweVdkb1FuaWVjTWkyd1hJTnNSeVRUdmph?=
 =?utf-8?B?OFpDeEFFQWtGR1NZN1J5bStoeldFZmNyUWd5dlBjaFdiam1oZ0lUQXBBT2FM?=
 =?utf-8?B?eGt5c2hKQUtEYzNmVytPbEtPNFBEaDdMVWlRczZ0bzlXMWpQL1QyS3FvY2Uz?=
 =?utf-8?B?NGl0dUM5WkRoOXZyUUswbFBDS3pXSEl4b3I2OExUaVFNWmg5VVplOG52VXpV?=
 =?utf-8?B?OEh0SFRuKzd5ZnBmMDc0VjgwMHpWdXB4Z0M0MTZ4UXFhOVVTU0FhM1hCMXNS?=
 =?utf-8?B?cTFyY1lyV0pXR0JuNDFoNWQ0OW5SWW1vQ3RQRzdrd3M0eTh3dm9YL3pTT25D?=
 =?utf-8?B?dVhwdUMxQVUzc3NuS0ZEQno1ZmpmVU9Ec29aWXpwZ2haK1BjNURoYktnY0sv?=
 =?utf-8?B?eG04VE9LK1F0WHF1ZmRLNVJ4MXhEV0FCR2R6SWk3Qk8rMnFrOTlxREQ3Q1VR?=
 =?utf-8?B?UHY0Vk8vVzh2aTRid3VNelg4RU5mdmY1Ky9FVWE4c2o3eG1xYlZSZXNMNGtz?=
 =?utf-8?B?UGoxb3pIbGYvT1gyd2ZNcGpzQW5jdTBERlNzSVh4RHA5RWpwSno0dm1hM3Yw?=
 =?utf-8?B?SS9mYnNuUkYyVWZVWnY2UXhuc1lNN0xtVFVkdnJNSzZwYWNiem8wSGZxVDBn?=
 =?utf-8?B?eFhKS3dSZFdGWUhPMDM0WjFyc3N2VlowL29KSmZmNnpGUDB0STU4bnhHUzZH?=
 =?utf-8?B?YTVrRTRTc3U5RUpXZzFjd01kaTlMYmIwdjlVTlFTYk16VXllTVZMTE5laFMy?=
 =?utf-8?B?OFpSdUtMdlpMV1Nranl5MU12em94cUVrUnJ4bjNpUXFodGNUZnhUYUpLZm5k?=
 =?utf-8?B?b2VlSWp1WVN5ejRRb3lXYjNDMU0zNy9EQlJNV2dtdWNDclRnaGFxeTlmakhZ?=
 =?utf-8?B?T1B1c3RReXZXNnRzK0NQMVN4Qjl4TW55byt3Uk9BSTdicVMrUnhlT0ZHNEw3?=
 =?utf-8?B?dkJ0Q1hncHNka2hyS3VEWjFZT3l4UUdyMWtSdXNMdWhMenJIVWtXRWJ1QXNF?=
 =?utf-8?B?VjAwVXZteU5IZDF3NHpzSDQ1UkR0dGJLa3FqV2N5cVhUS3JuL1FWb0VrNkZr?=
 =?utf-8?B?QmUzYmVxYkYzMndHazZIK1dKZzdwRXV2ZUFpU0lTZnhuK1hxMDRqYi9IWlpr?=
 =?utf-8?B?QnltRUpkK1pzUnpPUGVSN1FvVlV0T05McjROS0oybTJyMUZWajNKRzhtNVZS?=
 =?utf-8?B?LzhpNXFIU0N0N3dvd3JhbU80WDJvN2x0MUMySGRyVXlqNnB2RjRLUjhJcXFi?=
 =?utf-8?B?VDVNT2IwQVlmQ0NjQ0QvTUlPanU4alRST3hIWTZyYVNyUUJvR2JFTkpTZFg5?=
 =?utf-8?B?UFdZWkdaU1BzcU12d0hUUGtnZ3BsN1BtU3J3cjhIYXdGdS90R0pUanJSRkZ2?=
 =?utf-8?B?R2lkSXJrSmVPTkp5NFN2eDBwdEJGMCtCZ1piV25UUzBaYlNYWmVlWFNGRGVi?=
 =?utf-8?B?KzhQbDRCVXFwNlh1SWk5a0orSjJNTVpPa3EveDZFSnJVNGtVbW04QUpFYjA2?=
 =?utf-8?B?R3dmUWs4VTFmZGRTYS82eWI5cjFWZjlBTzR4bktVemMra1Q2WWhIU1p0YVU3?=
 =?utf-8?B?NTZSWEZGc1VUWDRTTitmKzBPKzNTMUN3U3lmNkkrRWZlbGNRcG9LSFlBSWZw?=
 =?utf-8?B?aDcyNmdCejBDZlZqamxUWmJiVElDbkhPbGoxOVhLOGs3UGN3emoyM0VRUk5Q?=
 =?utf-8?B?dFVxN21BODNNZDlPanFsMWQ5RCt2dVk3TG5waml5M1ZPeDAvcjRFM251NEti?=
 =?utf-8?B?VkFUb0k5NUprcHAyeTdIbzQzTjdVL3dNQXZxWFVIR1FyMDEwOHVOdVFIV3JG?=
 =?utf-8?B?Y0wraFJaZWFPUXBSSTE5R0VHQ1JwcTd0bHEyOG1NcEFXSVVNTmxJYlFDWjFB?=
 =?utf-8?B?eVV6WURHL1QyeG13a21zWWR0blB5WTRrQmIrckJQVzJ6TlF3Q0xIbEMxWHM2?=
 =?utf-8?Q?uEtX6wN22IqYr9ThFZkKZj103?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a771d252-4073-4b8d-29ef-08dcff863017
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 23:44:57.8832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ze9hl2e+DwvscE3QqG0rRgDfZaECOqQXF3svZ8VNvW2/UvQotTC6wKPMIo7rxbAsv/gI1aH4K/ALdtBFuGMgUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8824
X-OriginatorOrg: intel.com

On 11/7/2024 3:36 PM, Dave Hansen wrote:
> On 11/7/24 15:30, Sohil Mehta wrote:
>> Linux defined feature bits X86_FEATURE_P3 and X86_FEATURE_P4 are not
>> used anywhere, neither are they visible to userspace.
>> commit f31d731e4467 ("x86: use X86_FEATURE_NOPL in alternatives") got
>> rid of the last usage. Remove the related mappings and code.
> 
> Hah, not referenced since 2008!  This one seems like a no-brainer.

Thankfully, it wasn't referenced anywhere. For a couple of minutes I was
wondering why all family 6 CPUs are marked as Pentium 3 on 32-bit.

> @@ -628,11 +628,6 @@ static void init_intel(struct cpuinfo_x86 *c)
>  		if (p)
>  			strcpy(c->x86_model_id, p);
>  	}

Here..

> -	if (c->x86 == 6)
> -		set_cpu_cap(c, X86_FEATURE_P3);


