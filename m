Return-Path: <linux-kernel+bounces-438316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E85C79E9FA5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81E9163D86
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2EE19CC17;
	Mon,  9 Dec 2024 19:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JurdBjPP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A2A19992E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772546; cv=fail; b=cQ8jVFAMMQgdGFh6ARPTS61GgOdBqC1sa+DUT93EPQkWpywra47cUEdlZQCwAVbfQQZonzEPnJgABxHardjplhoEsIz5acb63xwQS+FrVrr34noYBODYGRQuI7OcTyJ8nnTiifvLJUX4KWryXeYgMH/Uye1ScJoo9oq6PwoDvek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772546; c=relaxed/simple;
	bh=kTwchHJzAIhU05skn+AGKloIk9BMShog+j2ct+14BGQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BUp4TTgeGWt9PTOSzZM/ayZvN7vJQsDuimgPnWhFFu6nDHkJrRNE1FSY6HU+K3rSfqqm8Zu45nx8yVsAyAw1XwE7N9xQf7DKvRVPaO1V89YDKy+ha2JY/InUZ6P7bTlxI5wtz3Yz/t6o3PnUv/ZCHhnkl8cTZs3Nrshjd95EEYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JurdBjPP; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733772545; x=1765308545;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kTwchHJzAIhU05skn+AGKloIk9BMShog+j2ct+14BGQ=;
  b=JurdBjPP2bbSp0rRPjx8MOkCklVr/JNV6GFIaB4LvjoZK9Jp6ePgqstk
   BzxUYXN64NFDg4JhbriD8zvE++Wl8Mjf3a1rwjsaOxuuosrHuQ618aIq0
   QNXX+hfS6LwHyiYpPXCJp+NSx1dtUS6/RBVhoboFEmmzEQz74lXS0fuT5
   1zxbqWEwIgx6QgzuoZMnLhw3C9Ws5pS/HvQI/pvHMC306DUt6B4JEPY/P
   vqKV+Y1sVqOAbOYtyeXTvH+m2pBk0X6B7UNL3aoEiS5Cmt+NQF9UxdEEF
   IdxzK5k+LKh9KGkf3P4/6Fi4hijp/PkmrYFGO1JLLW9TbVceoM7GoOXYO
   g==;
X-CSE-ConnectionGUID: hfmxLlUvQ42t8qLTXVem3w==
X-CSE-MsgGUID: Eth4lexPRRaSUjWP5lroPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34016297"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="34016297"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 11:29:04 -0800
X-CSE-ConnectionGUID: 7fLOG56zSpao6ia+04qRQw==
X-CSE-MsgGUID: n83PQ5JRQna3byy1Fwvl4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="132550992"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 11:29:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 11:29:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 11:29:03 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 11:29:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xulXIZGtQqo7Wz8MD2CP/2VsI0g3enAXahLfh6ILjBXmK97BDakvqp0Vb2t73iQEA98vsJ0AKU1QkRrjrcvVT0sWfB4Ce0GYBwWyor3ttzIwqrISHMWSv9mRSGetMbAUM+mMrOuHGljf4qAA+0L3NqjN6C8gHtQO4OMeYnkoy2G6oFbT4s6H4JMsnvJG+5NfiqJWy/QOhjshoFMtCIpfEfssPHodo30ybORqJ4OuxkRB/SYTGzrs+w1GbnV4gaaMDHtmdYxQPrbuhvXN2K5qQbAdRj2qulrVkIsM9vNoCbWyJ/9bk0LK7byFSrxrndgZbg39rgCQwZWI4qoyELXL4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csRZFu9Ftp85kpnNbJHK9jbWFKMbR5vNVPodkXI22Bg=;
 b=ClNG2xoT/YzWfbLOiyRN5MQoeaoljFXyy1vTagsDL6ZbDu98zLd4Va+2qgnS/xHUdDWGNvvzg2yF9ggx/luCgEv/eoqPjjyXlcqPN+6O6u/hEmi53ouIuLmrjCJYjIv7hyCvMjRyE3GNnkrrTBdSby6UTRns/JRwyiDIi0CtaNxtGskAidVuFKgdfjnXeQdVO/DjD8qMtB4+us+ZLQutYs/mdpAgMg8TVL8Uqx7o9PH+K4W8CDng4Znau8Qnh3YmDIYHkG5chAzSxBO0fomdAnyqWbjT6KbFGPOoiW/tQ643VvuPd0D4DLlIPv8PyhExd8US/p3Wz4f0MnqciqrlNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH7PR11MB5864.namprd11.prod.outlook.com (2603:10b6:510:136::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 19:29:01 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%3]) with mapi id 15.20.8207.020; Mon, 9 Dec 2024
 19:29:01 +0000
Message-ID: <2d9a60fb-1544-427f-9c73-d303bfe85773@intel.com>
Date: Mon, 9 Dec 2024 11:28:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] x86/cpufeature: Add a debug print for unmet
 dependencies
To: "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>, "Ahmed S . Darwish"
	<darwi@linutronix.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Uros Bizjak" <ubizjak@gmail.com>, Sandipan Das <sandipan.das@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Vegard Nossum <vegard.nossum@oracle.com>, Tony Luck <tony.luck@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Nikolay Borisov
	<nik.borisov@suse.com>, Eric Biggers <ebiggers@google.com>, Xin Li
	<xin3.li@intel.com>, Alexander Shishkin <alexander.shishkin@intel.com>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>
References: <20241207004126.2054658-1-sohil.mehta@intel.com>
 <20241207004126.2054658-2-sohil.mehta@intel.com>
 <A62E8AE8-A7C8-4223-A914-CF5130F77E68@zytor.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <A62E8AE8-A7C8-4223-A914-CF5130F77E68@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:217::33) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH7PR11MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 8344c14d-13ce-4f14-1cb8-08dd1887bbf1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SncyS2NnNUxuaXRYajgra1hMU3dDaGhlTnFucHUybE4zUHpzMjRnV0xFSTlq?=
 =?utf-8?B?VWRBUTNRQk8yNEVNVTJIMzgvSlNOMVdjSVczOVRhY05CRDJtVmxXUnB0M2lo?=
 =?utf-8?B?dnQ4bng5VTN5cmpZSUhxT3dTeTFYNXlabXkzckc0R1M4WWJQbWtrTTNOYXl0?=
 =?utf-8?B?bmFJMnlKYzRaWkFyNGdlM1F6Q0ZBd29TampqclJER040VzRXWG51T0R5MTd2?=
 =?utf-8?B?RDNuN2w5Tk14T1E0aFRHczlWZktKd1pReFdvSTROZHl4b3dJbnplWjNPeXlV?=
 =?utf-8?B?enRGN0lvSmUxZUFreUwxSU9CUk9JM2o2dzlJd2krTHp6bVRNcTRFbGFHOERu?=
 =?utf-8?B?VEFzNWFqbGhJYlZVYVRLTGpNdnJRT2RwaWR3a0U5REdCN2RLMmpKLzRIT3lh?=
 =?utf-8?B?NUVCczJkQzJmSmhZa2ZYWUp1VnFDTXNuc0Fva2FkZUJreFRhZkhqODVFRjcz?=
 =?utf-8?B?UXlSQXdVem1mV3VtRCtQcENEaDUyUVRuS3RYcGlOMk8xWDN2SXVJRHdtWTJE?=
 =?utf-8?B?dnIyTWhNdWJhS3FjdmJrRWEwMFRtU01NZUd2VElkeWdDelZLa3B1SUNDQ1JJ?=
 =?utf-8?B?VTA5dXd6MUVmQ3dEUFNDQlFhTTducUF2SElSY2RVclFlRWY3U3B3Q3lvbFBX?=
 =?utf-8?B?VzlnRjNJaTM1TFFuQjRtQW5JMVJCRnNrNXhyUjdvWGZtUTl1d3V1QVNPSXN2?=
 =?utf-8?B?WnVPcnB4NUxMUkI2K3hydmIrenZrOUtZZHUyWXJxcS84S3ZMSFArK3NqVjNh?=
 =?utf-8?B?Rm4wZWhBL2RFSzFFejIza2NWRTE3eWNBWVgwcmhEMmxPdml3c24rZHB3SkxF?=
 =?utf-8?B?WEJQelJ2THBXRzN6L2VIQUxOQUpJMzQzK3pHTFB2VkFjME55M0dvYnZDSE9C?=
 =?utf-8?B?a1o3akcvaFVZcW1GWnltdXV1YzU4MVVSaW11V1F5cytLUyszd0I1dmdoc1NX?=
 =?utf-8?B?QjFVeDltMUtSZzlkWGNzRVRlR0ZzUGlEMmlQQlVBcUFXTi84dGoxckVwNFFO?=
 =?utf-8?B?VExiSS9Sc1F1ZTJuWG5JWFZLZS91c3pQODBzRmZBQkdmbEdHSFJ1TkVPOGpE?=
 =?utf-8?B?L1hlQlRRT0p0NWhHanF2RGhLeHAvN0wxaGZSVDF6dnFZcXJXZE1mV1ZoRDE1?=
 =?utf-8?B?MnlwWlFrS21YVGpPRTl0N01LUmZobStZZ0ppUllZNHRhei82a3hrTldYbXho?=
 =?utf-8?B?MU5lUXltbVg3WHJPT1JwUmVJQ1RhMzZMd2dtUC9KalIrd0JPb0UrY0lFSWZ1?=
 =?utf-8?B?N3h4T3ZjVnRBaGFqL1poQmhCYjFnd0ZkY3A3ZkgzT3hCWWxkN29GSVV6OVpY?=
 =?utf-8?B?M2dsUm12aDlLUTYycXZzd2J5dXZWbVlkMGhGL213UzVDY21OOFRlTVFkNXdo?=
 =?utf-8?B?SU9BYlpXU2g4UmVOcnUxMmZFc0FkV2F0NG9LVkszRVlmQXBoR0w5dXYvZFBK?=
 =?utf-8?B?aXg2QWFtSnFMbVVaWkdkMEkvZDFjc08xWnZoK09vZFQrVW1kaDlMQnVDVjFs?=
 =?utf-8?B?d3lHYTI1RjM3Q1RPZVhJNWN4YklZdktTbVJIcEh0QjNzTkx1SllkRU1MR2t6?=
 =?utf-8?B?cVhBZTJ0ZXYwMWdIWDlSWnVHTGI0Kzc5cFQ1RSs2NXVMV3RyOVRYdFEzeWls?=
 =?utf-8?B?VkdhdUNnU3lRWkFaUVNkSHhrcFhLaHowL3QyVUgwaHY0Ri84bnJEUDBEUVFY?=
 =?utf-8?B?OHhaQ3prRXdOTXdnS0loT1BhR0xHcmE5SE1kNXc0aTJ5Q3RleXpPWjBZYXdQ?=
 =?utf-8?B?NlViMGQ2TnYvMDJiNTlnZnEyQXJNYmtxQm9KUTJxZjA0ZnUzdjEyclNRYTV6?=
 =?utf-8?B?RXQ4bk56Tm5sa2RiWStMQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWFzQlhxWHdHZ0JqWWtRUWY3TmYwUGxzZHlqVk0wVU5NQzI4Rk1KRDBnTmxl?=
 =?utf-8?B?cGVDYkpXbFIwSmc1cllRTjVnTW5YYklKdEJwSXlVYXdqbnlTWkQ5TG1aY3U2?=
 =?utf-8?B?N0Znc2V0WTFvQTl2elFQTHBrYU4ySTNPUW56Qkk1SWduZlB0RHliTWdLKy9i?=
 =?utf-8?B?cUNKZ0VYYSt4WFNoY0JINzUyZzgzczNCdHRlOHBSR2M1RzgxRWprWTljVWpF?=
 =?utf-8?B?TWR1TzRBOEI0OFNEM3R4WGtDNDNVelRrZ1pBQk1QdVBoWXdnNTdFZUw0K1pQ?=
 =?utf-8?B?YVZNandmQ0N2NWNIcmdDWkFKRHRzMWlaVlU4R1Z1ZVI4alNRTEpxY0JNWGhi?=
 =?utf-8?B?WThPbUpHZ1NhcS84N1N3YS9mY1ZzTG00bHE0UzlHbzc3M2hLWWd2REs0R0Ez?=
 =?utf-8?B?MDVxZjYrVlV4R20xbW5RVVRXQUUvWHRQQm8xdER2SXZuOS92TEJ1cm1sZTZx?=
 =?utf-8?B?SGJnQUJNQkxuOGh2WDE5L2FKOHB4UVlyN2o5NVNhcnpoTGJiK3E0eXg2bXpu?=
 =?utf-8?B?RVNtQS80cVNEWFhkNGd5Z0VIQU9VcnY1eEJHczNQRXlWU3MzRjJnd3dtck9r?=
 =?utf-8?B?QW1IdmgvVGJHdGdzSDh4VFpvaEI3V1doNjBQRXgva3AvaENkbmxjeTBkcG1u?=
 =?utf-8?B?MTlQZkJ6bURLRnJwZEQwQUxXZ3JHQzU5YUhPNVQ3RFJURCtqU3pHT3dXbmZq?=
 =?utf-8?B?ZHQ4SHNLSlhmU29HSVdHNWh6TlN0RWo1bnpzTkdHWmdwcFhaeFpRamtWTFdD?=
 =?utf-8?B?dVk0SC8yNERGTWpNSkxha0U4Uk9xdzFDb0ZUWHNCTk81bTdocmcrR3NLQlpH?=
 =?utf-8?B?bCtDdVdoSGpqUktpaWNHNTVGaktSQVJwSHZqNi8xZkRveE1jZFNzdVJUcnlW?=
 =?utf-8?B?Z2VjeWlTaTRROXZCQklsTVdZMnhCTjhCZ3V1N3M3WlYzMCtZdC9pN3RLOHpE?=
 =?utf-8?B?MlhIS2QvZkZ3VjdHdkg4MHp2ZUVHMFZBWFFzOWFNdGl6Sm1LWEVsRDRCQmxm?=
 =?utf-8?B?K2JuQmY2L0drQUU2TnptdFdXODRaWWUwRVR2VzJXOG9RRmFjM1ZnTGVqV3A2?=
 =?utf-8?B?SVg5NXRoNHR3a0tvL29IR3gvVS83ZXV4QU9kM3UwdG0ycWRBdzdBNldRK1c0?=
 =?utf-8?B?TGx4RTVldjJvT0FhandEbVkyMG9HL1RyNDZuUHJwOENXb2pRTHdoV3drNDRo?=
 =?utf-8?B?TWZBaHUrYWdLMGJoMG1IOFQ2cm1KR2JXR0JZTFJZVzJWRjdlMmJBK2hGQktT?=
 =?utf-8?B?L0oxQXVGNE9GVUFjNU1NZFFkbXdxSVM4RnRMRkJjd2lqZ1hSNGxyRzY0ejl5?=
 =?utf-8?B?ejVleWR0UWc1MDBpaklXV0NKMXZLNVJ5MnRSZ0hSbVRPUHNpZWt5UVJiUFR6?=
 =?utf-8?B?eFlBRzI0WG43d3NTVTJmMjZIWm1QVjNzVFRPSHNZUklUTDJPQkxDS3R0VmZp?=
 =?utf-8?B?OVQ4V2oyc3dkRDRNV3lNMG1vamdRSnFtb1BXbGpkSW15VmxYVGwyZ2FaVjB5?=
 =?utf-8?B?UDhQbHdxVVNuaklZRjQ4bE9JSTdMYlpWemZ0c0lJQ3RPUHkzTTZ6ZU9id0dM?=
 =?utf-8?B?ME9wMXN2dU1GTEZpeE51WUhXS3hoblFiSWdLMW9XVE5yL3RKR3djeUZkT3Z6?=
 =?utf-8?B?dkR4TTMvbXp4TFhsNy9TOVJIQldIVlRQdzNWckZLRFZPZzNEYUlFRWs4ZFBs?=
 =?utf-8?B?Q2toa0FZN0NLTThXbDdHV3VHUlhGUWlHWisvNEpSeXZqMDdyV1poa0dKRmxi?=
 =?utf-8?B?OUdtSWE0YUdIYjJTYWdtTkQ2REpRMWE2OFowOHcrRXZSeCt0dXVvUDV3d21t?=
 =?utf-8?B?ODMyb3ZaYVliMkV4MytwZ09MNUQwMkk4TkZNbFpSdVVZTDRNLzFTVHhjN0do?=
 =?utf-8?B?ZHd2VExOM1lyblBnTVZIWXgrNWxpbG5TSDVDWDdjM1FLV1NJOGpET0R3Qkpw?=
 =?utf-8?B?bnRyVFp3d0swekNwbDdCV25xKzEwcW42dDM2dDBoVFRycUU4K3NyQWx3QUEz?=
 =?utf-8?B?UWxVT0kvcXVrY3pnTEtPeTkydmhja1JMNkc4NDg5ODhhSzZYWWl3YnZnSER4?=
 =?utf-8?B?TVVTSEpyckwvY21QSmxkWVJoRnBKY01hZlR1Vk00ZkRrV1JhRFNlemsrQmdm?=
 =?utf-8?Q?F4mg0seWUVop8zsP1z3IBJ2GC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8344c14d-13ce-4f14-1cb8-08dd1887bbf1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 19:29:01.0796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvaSYOSGVD6RIsWj89iDVBRRDSKdgYrUvfqUrdylZF6YEhlAAaN9dxoB9556MlDFtMxPKDLosLID/gM5lGuiIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5864
X-OriginatorOrg: intel.com

On 12/7/2024 1:11 PM, H. Peter Anvin wrote:
> 
> Ok, I realize that the x86 maintainers **very legitimately** don't
> want more crap in /proc/cpuinfo, but perhaps we could include the
> strings for printing debug messages in cleartext? Add a bitmap for
> which entries should go into /proc/cpuinfo.
Could the cpuid-db project be helpful at some point in this regard? It
seems to have a name ("id") for each feature and a tracking of whether
each feature is exposed via cpuinfo and with what name.

> <bit20 len="1"  id="cet_ibt"                 desc="CET indirect branch tracking">
>   <linux        feature="true"               proc="true"            altid="ibt" />
> </bit20>


Though I am not sure if it only tracks the hardware originating features
represented in cpuid or the linux defined features as well?

