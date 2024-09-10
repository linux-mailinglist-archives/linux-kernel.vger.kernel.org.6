Return-Path: <linux-kernel+bounces-322320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D10597274D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED2C28568B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F04149DFD;
	Tue, 10 Sep 2024 02:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/XUlKZq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A33A6A022
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725936165; cv=fail; b=mKC3xFGDYA2GI/sa+gLq6pCFChaZrgMlFZR9AaOG+hkH7cJIXDVINIZTYDGiLCio40wfjlAhdJT9gCImn5ytVE/jhoFOqWsgjTPkWyZCPCXUZJXc5qRpQCuTdtDsxMw+oMW4AkeCbEYwHbba1Co9pPuOr8/Y2lJ/Ze0j7GFa28Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725936165; c=relaxed/simple;
	bh=HEnLg6t2hss8pwob9i4qq1olx85IsKi/9jFqOA9Lcfc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aDZ6BjCGliCiU/i3hXwxFoJLoh4DPVB7kdywAg6FTurRb5f9ggq+Sc9AUfH3Zm3vEQX9PhHpzR+g5rexWYNRWbESagx9SJtUoQIZRzGGgOvmZeO9XJY9jQtog1n/Be2KAXYIhUjKtnLlW8E4b/Y1JxB7BMrUcNhNpK2lteSUWWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/XUlKZq; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725936160; x=1757472160;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HEnLg6t2hss8pwob9i4qq1olx85IsKi/9jFqOA9Lcfc=;
  b=M/XUlKZqjAiJmtq905ZVqVhYVubIl5m5/DpJnuTjw3iJXLUNGU0Csjmh
   v075WnyI4dUeaOl/DgD57mMme5s2Uump0seG+6pTFlrdOkNvDAWWyE0sV
   WcT8J/1oPGtqof8quNQq3D3VbcYjQelj6RWZk4+rhziDeHzmAiCEMAzdn
   SzfDtay1sTFmPPZDMiop9HMteEjf+POtHXORE1+80D67Vk/X+RVIvfHru
   aX5nQ9HL1w7J3WGR2bKCd2LH0MqEY7OXsFlsmnLQpKgxhg4iRWbUoqxBH
   KyY9FxRtOrNC2AhlIbTwq3JHfHjmjMEDz8uC/YtitgYWdNXqXrjK7Kw8k
   g==;
X-CSE-ConnectionGUID: z8JJI6lWQpqgWj7+q0T+Ww==
X-CSE-MsgGUID: rsJhtHn4T3y+s5jko0MvAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24208682"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="24208682"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 19:42:39 -0700
X-CSE-ConnectionGUID: /0uE9f6xR7q2MbqzfJyfEw==
X-CSE-MsgGUID: pj6bUadjRr+v5lsB094aTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="71659586"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 19:42:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 19:42:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 19:42:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 19:42:38 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 19:42:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcRwoehsNeG5pt7ZKxi8lVqIA1ow/hiY+HsZ0VwJ+9cmr6bQI3089+OYrMV/3w1w8B3bp2J707Y+Z26xep5jgOn1GhKsCRSuw93LqJPiknlypSPO+T32wE4WrDY1G5uINFyRUh4e5/hUtTUlcMCkd1zp8PSim1if/Vi9pTbdyf7RzAvkq2bNcodPqhCvw/HalMfO7lktEp3Er5SZkCmre48yCcO8nAgCw83J0x8ULd1J9yCz6Lun6FN9gnLMlZClA9Mnt0BZAS/cNYZ5ra9mj9/NyRIcXs/GL2zpAiZOVM+Ql0GfF++gZTZi3lK4QKtJQQe2v2awwTH9CknJ2rVhkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqPjSck0P8cSiLiAhbZMO6/HrYio7Vc15+9/ulbdZpY=;
 b=iaQLoNdXRs8YadKP5/o+eHh5geo/d6eQkWsOlIh9ZyTJ6ZzPjiq2GMsSTAPH1QxjZPhAQscMpSsJxROOT79Ul8sXRYn3iLwn3vkcx/7c+b/XsFzfkJd81Zxh6xbWQLk9Gu4oxEblTkYd0w3kviQGZKo80CL4IbPxLvaO1+JL0rG1UtTEGulywA65Px9hBWseSoWb5Z5/8rKn0nGXGXV4vSmMksyeSLxDDl7HMu6YoUyNyi7Hpf/4k2jlM+E7FXeA2YByRQkjfcj2CUN05rj5wVBPMhPUJLoGHnZ9/8G5owEDBPLhBjaF+9jiusqBXnLYNP4z/f0Dh6tcLZa+CR9fuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB6670.namprd11.prod.outlook.com (2603:10b6:a03:44a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 10 Sep
 2024 02:42:31 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 02:42:31 +0000
Message-ID: <3f419ba5-7b95-45f0-adb3-d7397949c14e@intel.com>
Date: Tue, 10 Sep 2024 14:42:20 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
To: "Kaplan, David" <David.Kaplan@amd.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "peterz@infradead.org" <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"seanjc@google.com" <seanjc@google.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "Kalra, Ashish" <Ashish.Kalra@amd.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "sagis@google.com" <sagis@google.com>, Dave Young
	<dyoung@redhat.com>
References: <cover.1725868065.git.kai.huang@intel.com>
 <79f0de36a2a4f33e6cea8f0bf6419a6dc09ba94c.1725868065.git.kai.huang@intel.com>
 <LV3PR12MB9265B4512DE5F2D580DE3CF794992@LV3PR12MB9265.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <LV3PR12MB9265B4512DE5F2D580DE3CF794992@LV3PR12MB9265.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0064.namprd02.prod.outlook.com
 (2603:10b6:a03:54::41) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|SJ0PR11MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a5b9ff5-7965-4b02-8d08-08dcd142377d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVpzU05QTXB1UGZ0a3lFbFBtSlI2cXF1cU5meHhFQWR5aDYxWXFNMXJUdFJS?=
 =?utf-8?B?Sm9wOWI2T3JBU3FEemdsSXdsR3dsanR3RWFQRnJtVG5TRzNldGFoMkJVZ1kv?=
 =?utf-8?B?dFhzcERuWlRMd0NWR0czUmxaS1B2UHQzL1lnSjJFME1HTFBmQ2NzQ0Y0cS9N?=
 =?utf-8?B?T1loUitkVE5iVDRyOVRKN2tiY3BrdmlBL0JvTkphWDR6VTVxSlVmOFpaQjVJ?=
 =?utf-8?B?SWt0VzFsWFVHK2xreXlsWmd5clExbTBNejdPM1l2L2ZnYXpzUmtQbG1YUE5V?=
 =?utf-8?B?NlVnam84YWpMMEo0V0lrSzJONnY3TlV6ekUwOTUwYUJ5TWdvcXNkY0pTYUxF?=
 =?utf-8?B?aHJ3dFRIdjBERUlSNjM4M1hudytCVElCVEo0SktIVmRCcE13dk81Vk1OaXBM?=
 =?utf-8?B?RkxrZmNBY2tnU3NXQWwvbzB4WVBBV1RjbXZKM3JLWGhnVE9ucHY4emh6blhF?=
 =?utf-8?B?RUlZRjY2Z3JYVHNsTjFoR3ZXMVNxZEhtL0gwUzhoUkl4TnFZNkZGc21teWE5?=
 =?utf-8?B?Szl0cjJQcFpQenhNNjAyRCtybWJFdlU5NkNScm9qUmtVS0pGQnl2b3JRMUo5?=
 =?utf-8?B?czd6eEY4dlE4RE9UNi9kb2xHV1hjZ1BmYW9Ra2huQyt1cGorNE5BL1R2dzc4?=
 =?utf-8?B?ZFdiSEFJdmlFVTFjWTUwYVovcjhXU1lyY1hqVUkyaTNMUEFleXljTk5YQ1Jk?=
 =?utf-8?B?Wi9DbkFvUXZFbFpLN0tYSDREdFpTajhaZTFnUktkL0ltZDJJek10dUNGcHNh?=
 =?utf-8?B?RjFjTllVUUk4K1ltZURpOHNLMmptZlJMVkNrNnJXdVE4V09xMFYyeHdsSHEr?=
 =?utf-8?B?U1hGQ0pEWE0vODNzYWEvYUcwNWxMbW9VT1ZhNlljUzNoNDhLU3RrWUpORkJS?=
 =?utf-8?B?T2lOSkJlc3FjMjdwcjdjR2dlVWVGQWdwTHMyWEZxR01jcE5FQldFY2g2TW5I?=
 =?utf-8?B?MXhhSTdWSGFEdjZBMGNNdlNSTVVaQllNbmpSNXJDbi9IMkRRWk81akJSSVI5?=
 =?utf-8?B?L0V6UGFndWlpcDRTQ0RHejNDL0R0SGZmZGNMSWpuQ1Jkc0dWN2diNUlpajBa?=
 =?utf-8?B?OWt4NHpFRWRFQk5CcU94ZlVYSmtwUnh0bS9CVzJicXlaZmV1SmFGV1NrWlhZ?=
 =?utf-8?B?V2lPUDZESHBYUEFiVnI3NzE2SFRxeE5UVXovRWwvalFWUFVVdlEycFhrM20y?=
 =?utf-8?B?N2RxL3NsMEdVVU80QUJDZERVdEdEZDBvUlpCbFM2T0ZrS2lnaEJPVTM0cEpR?=
 =?utf-8?B?dEw0Mm15VjlOK3NQeW1BYnpmNFhLelBsRExmUUw4eDlaaWNzR0pESTMxVzFo?=
 =?utf-8?B?M0FVanQzK1RrS2dWSlNpTU5IcnNLeERWdkpEWXdGRENjekU1MWNjREhRMWFP?=
 =?utf-8?B?YjlQZWV3dU1tcGZTOFQyVloyRHJRR1Yya3JZQzZhNExzTXJ6TTFPVXFUd29R?=
 =?utf-8?B?b256N0lMaEowQnBEbGR1V1NNQUEwMzdXWG8reXM0OWpnMFFTQmJ2OTVhQkVW?=
 =?utf-8?B?N1ZuaXZCRXA0WWFNMDlzek13TnpGR1ByOVlLWGswNmNiajZMaFlJN1ZNSklU?=
 =?utf-8?B?TXF4bVFGcWNmR0RuRStXblhFamluc01JcGxnemlOdW92WExqSVVBRk9RL2FB?=
 =?utf-8?B?anpVVTV4d2VGM2N2ekJ0YW9QTGV3NDBDUFpKTjdHenVMazlwbTBGRExFRVE4?=
 =?utf-8?B?cWpQMGxtSHB5Yzluc2hCZnJXYVB6K3IvbmZiem1jMzhSTndUMTQxUFRVS3pQ?=
 =?utf-8?B?MUlqaDZlZnlHT1Ywdy9xcnNMbnVaZklMNVlLd3pKUWNvQjlNMGIzZFg1UFNR?=
 =?utf-8?B?VGxEZWp4Z1ZPNFdMbklzaVQ3NCtROVY4MkQwQzRRV2Q3NkZ4MkNYWDlzOG4y?=
 =?utf-8?Q?DT4zm/zyhAp8W?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0huU1FCMmc3SjBhUzE0T1IrMnpTdEVjYkkwSHJFWmZzYmhVQUNvVmdBVjFG?=
 =?utf-8?B?VU41c0ttYUQ3bGg5eEJjdnNoYjgxTDdTRnJsUkEzVlFXaGJ1R29PVTFXdDJG?=
 =?utf-8?B?V3RpREFHZWlCUkoxaDR5UUE1QVZyamtJQ3l2ekhVdGdhd3I0VTJtNlg3bDE0?=
 =?utf-8?B?a1BpSU5PUVNPWlYvbjVUT0hGUGtIeEdiQ2UxbnZudW5PVmo3RHIramZOeThQ?=
 =?utf-8?B?ZjhPUjA2NWt6K2REaWJHamtlNC8zcUtKaFZlSEtQU3lWdUV6TjN4aDZ0eFo2?=
 =?utf-8?B?S3ZuaVVLdlg2dWJRVDl2OTZlRklIek5pQkV0VWVHTnphbVYzVUdGTWx0bWFK?=
 =?utf-8?B?c09FUUNvclhYTEV2Um16dnA4dXhGRjN0QndXaU5ZL3Zhck54OTl4cFlBejc4?=
 =?utf-8?B?Vmd6TmtJdm0zcUp4QWxZcDg3akM1Tkt0R3k4UERXMEgyWk4ySkFQWDBXNjlx?=
 =?utf-8?B?WDJTT0RhV1l0V3MydnFOMHFSdUE1eGlRQ0FsS0tjQ25mMHU2YkRhV1FNREU1?=
 =?utf-8?B?K3NWTHV2Z09UUjdSNWFpZGU1MHMydC9CUXBFakthODhvc3lkSDNFeFcyNGxo?=
 =?utf-8?B?RDk4WmhVd2l5aEMxR2NIRG56SGgzeWdKTk1DeVJUMC85a3ZWZEo2YjVNK1c0?=
 =?utf-8?B?b3o3cXBNT0hSUFdXNEV0YzZSQmZNczJSdHl2THhPSzRnVzZNdkhDeWszSzR5?=
 =?utf-8?B?VStlWGpGa3hSUXRwclpqd3BpN0pBb28xWnVCYktYQit1RzhRcGtuSEhES09Y?=
 =?utf-8?B?MFVTRGRYV1ZSK2JLTEkwbVVaWmdpSVZPUlNHOEJiVWFZWi9pYWkxRDVDU1Ey?=
 =?utf-8?B?R2JobUZnMkwzUGdVU2JIRmNoUGQ5VXVmTGdTV2NXbXZnOVhIaFBzOWVWSHR2?=
 =?utf-8?B?Q1pzbTlGNmtYenlwODNuM2ZyeGJWeGNDdmVrQUVUOGtZeWtuT210SlpRQ0VY?=
 =?utf-8?B?SllHVUMwbW9DREJVWGRycEFTR3QrbU9DRWY3ZmZlTVZCek1MeW1iRkd6NE93?=
 =?utf-8?B?c3U5QlVUd0RyS1hUdTNwTFJRN3pPcVJHTXRzMUNjNmNPQml3WCtpODY0R0Zw?=
 =?utf-8?B?MmE0ZFQwNmVqdS94YlVIRkN3VENwZnhkd2E4RmVBbTE5eENYYkx5dUp2bFo1?=
 =?utf-8?B?UUFDSlM2SXBSOGV4MHJRTjdvdEc4Q0J0akp1L2pRVXdLRVVVdTh3UzA3U0Iz?=
 =?utf-8?B?OGg5d05SNnYzQkdrM1J3ZVhwaHV5QTFOd0dTKzNZMGJQUFl6QnZ3c0wwc1Mz?=
 =?utf-8?B?RWlWRW5vdmtaU3hQSEp0OW9nZ256VW9QRmI0RjhnRW5vb1NuaW5kVkxTaVJp?=
 =?utf-8?B?WFFMNnlzS3B5UEtkRkRqaGxxZVdZY1VLWVVrUmJjZVVDY3BrVXhsRW5oRVBO?=
 =?utf-8?B?SmpvTFRrckJnZTYwNWVpVW5oTk9LTTVYa3hrUERXNTNwamQxa1ZJcUszcWhw?=
 =?utf-8?B?aTFzSWN4ZTFyTmlqTkttcWpOTExzWTVXbkV5VFBqM0w4MzZ5aWZydU9SQ2VH?=
 =?utf-8?B?RGs4Z0NjakNCTDRtb2tQaDNsb25KSUtKYUJQMlJzajRxMUN0VlRHd21ZMSsr?=
 =?utf-8?B?emJWTjU1OXB4Z1VWWWh3WlJVTk5iOXNVZFZqcWlYbkE5MldzZnpubGl6Nkt1?=
 =?utf-8?B?OTFjRnlSOWJYbHlSYjFqRkh4L0UxczRyazdneVl6YUdUZlVvbWdabkhQM051?=
 =?utf-8?B?VTdvN0pRRC95RFlWMjRicjNkWTVZc2kyWUlsNDByQ3g3bDhYVkQrK3ZjR1lW?=
 =?utf-8?B?TG1jekFsYjFSZTIxcFNUc0ZOVjZYSUxlVE83eEVHcjVjUnByS25HWHRvMGtG?=
 =?utf-8?B?bFUrMCtHTGJJdnFlRGxDaWhZeitPSWNoYUVydGFXMzhZRE5aODdkQ25ISEVk?=
 =?utf-8?B?eWN6MXRZTVppVU1IdTVMNUVCRVcvTm0wMFAyZTkzcHJWdjZna3lTdDA4RTV4?=
 =?utf-8?B?UDF2K25NdERwK0J6OHo4U0NqR3E1S0hpeHlwRys3cTg4cWgrVk5ZN3l5bysr?=
 =?utf-8?B?RkNxSWJyb05HOVRYcVUxMkNKQUgrWWg4MlNqeWFEOStxMVFhN1k1MGpJYktR?=
 =?utf-8?B?N05HSG5zNzVZMEhYdGxqQXJpY1lwTG5DaDJxakpTdXVpRnBIL3lOSUtlaUFo?=
 =?utf-8?Q?lGgojltziGYlpToOc7yrPlqE2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5b9ff5-7965-4b02-8d08-08dcd142377d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 02:42:30.9937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dys/QqsYWoqvu2KeoJfAjY1oj2W3KJMjIS6IwVuifYPgUOGUBwyWeA3YY7UITJWlm/GGHcLzG0C/pI2lZJOvRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6670
X-OriginatorOrg: intel.com


>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -322,16 +322,9 @@ void machine_kexec_cleanup(struct kimage *image)
>> void machine_kexec(struct kimage *image)  {
>>          unsigned long page_list[PAGES_NR];
>> -       unsigned int host_mem_enc_active;
>>          int save_ftrace_enabled;
>>          void *control_page;
>>
>> -       /*
>> -        * This must be done before load_segments() since if call depth tracking
>> -        * is used then GS must be valid to make any function calls.
>> -        */
>> -       host_mem_enc_active =
>> cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT);
>> -
> 
> Functionally the patch looks fine.  I would suggest keeping some form of this comment though, because the limitation about not being able to make function calls after load_segments() is arguably non-obvious and this comment served as a warning for future modifications in this area.

Yeah this makes sense.  Thanks.

I think we can add some text to the existing comment of load_segments() 
to call out this.  Allow me to dig into more about call depth tracking 
to understand it better -- relocate_kernel() after load_segments() seems 
to be a real function call and I want to know how does it interact with 
call depth tracking.

