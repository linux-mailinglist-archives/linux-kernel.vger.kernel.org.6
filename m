Return-Path: <linux-kernel+bounces-526587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362E4A40098
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC75189390E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7F0253B66;
	Fri, 21 Feb 2025 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mW2H9cXw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFE02512D9;
	Fri, 21 Feb 2025 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169046; cv=fail; b=a12WsgcPqF/0ixqCRQZW0lo16M7ati8NhykCYEHUqoHUEB5vE1XUGos0V4KtcJhoLPuhFGwTpg65InQdShru4OyCAEvKQ9ZSKGNLW16/kkESPNX0QbEu38POsKOrkAdSkjz4D24JDeHcVBHVreVf736RL665KH6nJJhw8CwjWAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169046; c=relaxed/simple;
	bh=kIxN291kwrmah5OnglbeXj+e74q30edVlePH2b7R4Gg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mgTdF4gheW00Rc0OvXhFFRYezUicZCTLh92cmdjzrLFeBbL2rrPoMQvA8czWzmdhXLQRFSDIVTYRPNTS9ZCuOzvm+Ad/rltKF/GL5ED4iT3E9Ky7gMem6ZM6CHBsRjYVIk9+yyCPEqpi3Ivx1lk1Ci4zhU2bew+7pFQhFN/BZBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mW2H9cXw; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740169044; x=1771705044;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kIxN291kwrmah5OnglbeXj+e74q30edVlePH2b7R4Gg=;
  b=mW2H9cXwNnN5Y+247LwUN0Uzm3fTE6XBOf8JRDKUUMrfo6i+iln5J9gn
   habGD70Xd/8KVWR5j8VAEkVh1kByXFUFRVr0vhgEFod8xMeVkMBCrmnvL
   8z54FlkQundj2P8i0pyppnPpE1Xa2eOT0slwMSq8kKShpAAeSyQCA3KA7
   Hg7FaYViZkTO38fmn1H/lBw3GgpoazTjNfBp4eC14kOnB/EHXg5zbUbiA
   qqnkk1UNSzm4ew7GasmVm1+YqNv8+W0ASB2KAwzW6imrFX1PXuREhE/8K
   GoSjWk5rl2lvmGhtPYm0Dl442KWm81WD6d4xUAnIc7iyVcOBbd1IFNjQP
   A==;
X-CSE-ConnectionGUID: D1F00vL9TSucFGUieVehYA==
X-CSE-MsgGUID: 5z8drc1pS++GVGGmceAcGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="51626279"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="51626279"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 12:17:23 -0800
X-CSE-ConnectionGUID: Vt92J+7IRW6oz2dXotn2og==
X-CSE-MsgGUID: KEwSm/N3QHqCNpn7ZoROUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="120092459"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 12:17:23 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Feb 2025 12:17:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 12:17:21 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 12:17:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lkmp9urd6f1YS8K6cWMxayCgZQVqrJFZQ7F7iPgosHyuuj8JmtWji+shG03Vd80807ypndFtlDBVUpNZZEU/7yEdXGRqahkQ5JzLrI69LWhHFNf/eWwpyXoS2OaPMJ+Klg/r5bXLh0eld+98E6bf0VTI0MvyN9N9g9dq66oyNcd1gz/qOuVpchbh/Pe6P/XRIWiM8MAEwdkKnfog5PAoOR5yZZDakIrCQRjJEJD3San5OdtrPjBIbFL1buAo0WKerX7b/jgm+BFrvQbEs3REcI8xZqSDfzYikm3C7F94apAO5a7r9pKBKJtySRW+yZvR4q8m0kKyHtAlX0GbTCPjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6uI2ZeFDwyA1mJIQAhuIKtdmjvkCqqLdo9VScctQ7k=;
 b=HDmQicgzRdmNjkGGl0phKBfT9TYylmDdzobUGNSyKos97hcWevb4C0+C95dtt9SHfiELQo8Qhz/9rWCg1LqeedBQ6jEbIws1CGOtsekuFhYtdevslkiKcFih3BsHruTozMUiVh4S+m2iucaErc1RyiTqqubIxacjWZRbkbd4JE1V6pJyogfCeVpaKZOYrMaP7N1PHumGseHzKL7frvkALgcuWzHGGCVnhHDPWjoNswhc6dU/UiYcrHbT4QFiMCYp6c0H6xlrBwMtfVFH1J575Bl8Ms6f/vvCTYHqki8bQtsUTRy8qB8zwaTRAwonmvAlJp1bFhh0+PoW2QFl1mATDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5252.namprd11.prod.outlook.com (2603:10b6:610:e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 20:16:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 20:16:57 +0000
Message-ID: <0172ee7d-9a5c-44bf-8004-4d93c3d53cbe@intel.com>
Date: Fri, 21 Feb 2025 12:16:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 23/23] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: Dave Martin <Dave.Martin@arm.com>, "Moger, Babu" <babu.moger@amd.com>
CC: "Moger, Babu" <bmoger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<tony.luck@intel.com>, <peternewman@google.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <paulmck@kernel.org>, <akpm@linux-foundation.org>,
	<thuth@redhat.com>, <rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<xin3.li@intel.com>, <andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <fe1c0c4cebd353ccb3e588d7ea2fe9ef3dff0ef2.1737577229.git.babu.moger@amd.com>
 <Z7YBxNIWb7dqOnfi@e133380.arm.com>
 <1ccb907b-e8c9-4997-bc45-4a457ee84494@amd.com>
 <Z7dIfWAk+f4Gc54X@e133380.arm.com>
 <fdfe13ae-1fb1-417c-88f5-6b0973338c34@amd.com>
 <Z7ihOkYhQoymphB1@e133380.arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <Z7ihOkYhQoymphB1@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0234.namprd04.prod.outlook.com
 (2603:10b6:303:87::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5252:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0d99e0-5c3f-4342-b4c4-08dd52b4b0fa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWUxMHB5cVRFZG5OOWFVaGJsVkR2Q0lmNHA3RVFXcm5KZUVOemE2eEtaZHpu?=
 =?utf-8?B?TE5EWTZ0SFVGcW9hVHNvTW9NY1FvRzRGR2FxTmo1ZGl0dWdadHllTGVTcUwv?=
 =?utf-8?B?VjN3RnpHcjZqRWRDemo2TnRZVkdBMlNvcHFXUTJwbjJ3TERhWkpialJDRVE4?=
 =?utf-8?B?SDd4RVhKdTZGTDJJYnhpWDllbVBjZzlOZnRPNkY5aW8ycmVib1NZWXFsdmNP?=
 =?utf-8?B?UlpSYjR1aThpb2FFR1VsazlTeXQ1cit5U3BJcjUvcG5WbEFaVncxV0ZyRWRy?=
 =?utf-8?B?SEluSHg1WjhPWUxoZGoybXRRRHRvWGQzc1NjRW5MMm5IMCsvdzFiYUJoRlhn?=
 =?utf-8?B?ZndhbFg5cldhajU3SmJhMWFvTlQ5Z0xYTkplS1gvK3ZrOHNtVzNkSnNhRm9a?=
 =?utf-8?B?RTY2bXZWQ002THF4N3ovaUVKRHYyN2dKMlVKN2EwWFdDVlA1TjdnaTZKaERn?=
 =?utf-8?B?V3pUV3JwazFZS2cyMkQySXdybFhKRnFVSEJPdU5FQ2FPeTdlQkppV2l4YXE1?=
 =?utf-8?B?Y0g4Wm9QcThwSXRkbzhSK3RyOHVPbk5sZEk1YU94Z1FqZHFIOERjbWJnY1FO?=
 =?utf-8?B?bmR4MnlBa2pxd0V3UGhodHBFSTZsMFQvYlUzWm0yYjUvbm1FcGhhRlNVNmNJ?=
 =?utf-8?B?Q3ZnU1ZiaTlvejQzeWIzbCs0ZDhtdzQ2U1JNYTQrOUw3RkZBclAyNlZQQ004?=
 =?utf-8?B?YWFaNG8wZHJuRzJrc1hWbXFyNzVtTlFSQlRVcVg2U1lvWW1IdWxWMWNZUUp4?=
 =?utf-8?B?RlBTY2pENHY3cEptTXdmQkgyRUFwYmlEOWVEMGM5ZHZDQStwYjVKekFmOVcz?=
 =?utf-8?B?UllyV1hGa0NxeHEvUTZKOEFUd3lZUkhWNWhZSGE0dUJXNGtHeXYvcTNFcWNX?=
 =?utf-8?B?Tm5pRHg2eGFIV2lrMGRTaTBTSFhCQjRBQjJYdEtvZTBSSmk1bmdYbitxSHg5?=
 =?utf-8?B?QmNpVzNHa0thTFFRMURaZElYcU5JRE9VTnQ3YytkTWVvTmZXdkthWS9WcWQv?=
 =?utf-8?B?cEgwV0ZqZ1MrbFVzOHB6RnZLVEFQRTZjWDJldkd1My9kb2JyR0lvRWFDcUpD?=
 =?utf-8?B?U241R1ZnSkpWWTdUZFJKNGN1bk16azVSalNsTUZjVUFCcHBZSXdDZUZOVHdp?=
 =?utf-8?B?RjJ2Z2FlZ3QwK05VZDdqelJGaTF6b0VrbTRzOUVHOUJzSUdINUxWZ0hIb1lz?=
 =?utf-8?B?QTMva2hQVlBKSWxIai9iVDEyK2pSMGZTQjRBeWxZL0NyUmhUSEV2ejZLZVN0?=
 =?utf-8?B?L200dEs2dUlpQnl1UVZVVkk4STBrK0svM1VlN3NxcWhMZGVSSDNsK2M4RDdB?=
 =?utf-8?B?eDlhdGZQaVROSXRTNUk2QXJGS2xoOHMxSFdiUGhlZ09Mbk40K2o1eTBiSDZa?=
 =?utf-8?B?MlRtYld6c2NZSk1pNWVHajR3TkxZdzBhV2piMVZhU0Z4UDR3WktBVjUvOEZn?=
 =?utf-8?B?M1EzYzE1d2tXOVEwVGJuSHZBUzU4YldzL2JoemdpSXVJbG5pUkVWN1IrQ2s4?=
 =?utf-8?B?SGh0UENzS0hXNzVHQlB0TnBTSElZc3NEcnZJdW5Hc2t0S3FmTk5PRERwSnRv?=
 =?utf-8?B?ckpBaGJ4UUxIZzJQbEFUbWEwREFEbUxkU29NNnEreks0ci9vQU1NRVZZVG1x?=
 =?utf-8?B?MVFUOVZlMlJyOE9tWGRQQ2g5TXRaSnBxTWFOTEd2SjlBU1pQbmk1RjlDTEha?=
 =?utf-8?B?SEZrY1kza1FIekt1UEt4T2NJS2xrUXJRTVNIeUZleE9RSlNPOEI5SGpxMmpp?=
 =?utf-8?B?T05jL1ZYejVZbHJpS0pTcnMydS8zZDlvejhnbzB2M1JMOFRDWi9pYmU3SzhI?=
 =?utf-8?B?U2JIVUFmMW1hNUdXWlQ5dmRNcUx0alFLNk5hbXRvK1JHalM1SXJYV1JGbWdu?=
 =?utf-8?Q?232XlsMT90mC0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm8wNUoxSWNjTXNlK3NRNGtDUXNJb0lOLzVVQkhZUmdsSFJMWCs4a1UrU09j?=
 =?utf-8?B?aG1BbDIxdVRuVUJYTnVVOXQwL3YrbnJseDNwOXIvT3pmVTNEYitlOGRMYjA5?=
 =?utf-8?B?MktjWHgwQndrdXE2TXgwVVZwTlZFNDVldlAzUGZRUDM5NHUvM1lDMGFJd3pG?=
 =?utf-8?B?MVlLTlNOQ3dDR2tPSU1JVEJ4bEZIRjZrQWlpNTY4aCs3WkVuZlJqdUs2ZXZt?=
 =?utf-8?B?eVVudUhrRStyOFNtb3FoWHMwU2pJb2FJK3NmUk8zSXNJaklBTm5FK0dUSFVs?=
 =?utf-8?B?VjlLbWVZN2hkcWhjZlpMMzJ6RWhkdGcrQk1IaDNvdyswRVNOOURGMGliQ1NP?=
 =?utf-8?B?QmhWak9hOUQzTC9SV2FSdHhvVkMzenprTUFRS291RzNoUlkyNnYvSzJZbTRX?=
 =?utf-8?B?WkVhS3JXL2NlVkFVWDJTdGxBTkQ1Y2hlankxSGZGczRjMXR5YXd2UG5DWlp1?=
 =?utf-8?B?YUFUOFdZb1lMTGFrdkZFQU56RTRJVUQrNHVlQUZid1FRU3I0UUZJa0VnZVJa?=
 =?utf-8?B?K1grSnlEVWQ4TGoxTUtkbmNpaE5mL09PZTF6RnhhamRwQ3ZPdXNYZTFMZCtI?=
 =?utf-8?B?cWIvN3AzVlNyOWdrc3p1eHQvV3k3Mms3T1dZRXB1UTMwQWg4QUJFZEM5KzdJ?=
 =?utf-8?B?UVFpR3JEUGxrMVEwdWxpM2NZalZWMEphK0JZaVFCalpUOWYwQllRaWJURGh5?=
 =?utf-8?B?dU1MU2t0T3pkSFNrQ0xuVDlOWVdKWUQ3dEFHVVFIN3hwMWM1eDZ0S1JlRWJL?=
 =?utf-8?B?RkUxYVB4Ny9GOFBTUEl4NHA0WlNEeEdZcUZVLzhjS05TK2xXNmhRcTVRVEJs?=
 =?utf-8?B?K1FOR1hLTGtLVnhtZVViMXBRUmlYSkVJODJhSFRkeHBTQVhZRlh1YkNWemtN?=
 =?utf-8?B?VEZXYmpsb0hLWDNtam1ncGVzTTBuVUlPUHpFeEYycXJPWmZjRFpQZURsWmRE?=
 =?utf-8?B?VWNhaG5aK2NPcTBmd3lTMFlTRG93SHZCc1BPeGMwanRXTGFvVExoSDFOeGpt?=
 =?utf-8?B?eGpHTDdTbjVpdVE0cG9pSVFzMDcxMFNrems5MlU0OFpvcURVdDhOM0t1eUdQ?=
 =?utf-8?B?QWlpVmlMeG5Ua2VScGRHTjkzTXMzVTBaVkFiY1h1V1QyME1iQ0R1N3prK2ta?=
 =?utf-8?B?VjVlelVEem5CZXVnY3JXR0YrYVh2dnBrRzNMZVgxYnoxRGdsbDM3cGxoYzFR?=
 =?utf-8?B?czl2SFdOdWxoZlJrREgyWmZPMHF3Z3JkUy9RZnlZbEFwVDM1V0N2ckU2Rmxj?=
 =?utf-8?B?ZnhlSWt3Q3krWngzRnhRSklCbDQrMmIzeWlNY2ZQT3d3WGFCRWtiREFsekFH?=
 =?utf-8?B?b0VsMGpQWHQrU1cxMEZCVEIzRWQzVi9CNmV2Tk9XeFJWY1Y0STFtOEs5UWg1?=
 =?utf-8?B?NVdKZHRqWEFRTWxwaWRaaFg4R0Y1ZmtISEp6S3pmbCtYU3JvcjNrYS9sRjBK?=
 =?utf-8?B?bDlNbkpIaXlVUS9iS3p4ZXkyOXpUYnJ3bUd6TkRlOG1hOHM3WVkzcVA1OFF5?=
 =?utf-8?B?VzFVWjlOYmtGdVJ0UFQ1ZEhVZ3AzR3doalFBcng3UkNYdW9xblovZDFGTTVv?=
 =?utf-8?B?K0R2bzFxSkU3QzJ3UnMxeE82OEdBRnhJMGlCcjArNlBZWURCS29Fcll2RTBn?=
 =?utf-8?B?MStkYUVuakVEQ1RFaSs0YVhubFc2QjFWSDhGTUJnUk8yZFlEcURpZDIyUFQ3?=
 =?utf-8?B?VWhWZXF4Sy82LzhXanJUeDlDc2tCa2MyeTUwcTFIVFZSMmtmd293eFd6dDA5?=
 =?utf-8?B?M3hYMjFnZktYRHpYODNuTXpVSzBCendabXc4WDhXU3Q2Z1hzVExkc1lVYjhF?=
 =?utf-8?B?OVlkazUxbjdDWGF2U3RZVXlMbUZqMXZoa0p6cGN3c1BsUUd4RlQwTGlidHNR?=
 =?utf-8?B?WENMdFJhUlZNZ3o0VWMzdWRiT2gxRHBwVVhGaVZtZWw1TkhMSWxjMDNValF3?=
 =?utf-8?B?MDJDUW4waTRqRWFOZkFHT0tDUm56SWxZWmQyTEZLL0R3UytXK3pTc2E3MGJj?=
 =?utf-8?B?VDhFVGFCYk1kYkEzRWEwOXFYbVVRU3ZLSVVpSThVWjk4NktYVXZKMTUzTDda?=
 =?utf-8?B?VFQzUGZORjNucnpFd3pHM21paTJ1NEp3YXJjajZ4WStFUkFGYVN2S245T1dI?=
 =?utf-8?B?b0FaMzNpNXFKK1ZrSEQ0WFhSZkNFYVd2VTNnVzRSZitReVpQaURVNjJnNWNm?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0d99e0-5c3f-4342-b4c4-08dd52b4b0fa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 20:16:57.5330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ms258TRJrMZZMOJWqJej0klAnyz8wdRnCzpz8X3H0EjVljvh03vl/+4XYjNmtPfU2tlGtjWM8U5/ZBahIGIUFM/BzS9PFSilEbfzvl7l81M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5252
X-OriginatorOrg: intel.com

Hi Dave,

On 2/21/25 7:53 AM, Dave Martin wrote:
> Hi,
> 
> On Thu, Feb 20, 2025 at 02:57:31PM -0600, Moger, Babu wrote:
>> Hi Dave,
> 
> [...]
> 
>> Created the problem using this code using a "test" group.
>>
>> include <stdio.h>
>> #include <errno.h>
>> #include <string.h>
>>
>> int main()
>> {
>>         FILE *file;
>>         int n;
>>
>>         file = fopen("/sys/fs/resctrl/info/L3_MON/mbm_assign_control", "w");
>>
>>         if (file == NULL) {
>>                 printf("Error opening file!\n");
>>                 return 1;
>>         }
>>
>>         printf("File opened successfully.\n");
>>
>>         for (n = 0; n < 100; n++)
>>                 if
>> (fputs("test//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;9=tl;10=tl;11=tl\n", file) == EOF)
>>                         fprintf(stderr, "Failed on interation %d error
>> %s\n ", n, strerror(errno));
>>
>>         if (fclose(file) == 0) {
>>                 printf("File closed successfully.\n");
>>         } else {
>>                 printf("Error closing file!\n");
>>         }
>> }
> 
> Right.
> 
>> When the buffer overflow happens the newline will not be there. I have
>> added this error via rdt_last_cmd_puts. At least user knows there is an error.
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 484d6009869f..70a96976e3ab 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1250,8 +1252,10 @@ static ssize_t
>> resctrl_mbm_assign_control_write(struct kernfs_open_file *of,
>>         int ret;
>>
>>         /* Valid input requires a trailing newline */
>> -       if (nbytes == 0 || buf[nbytes - 1] != '\n')
>> +       if (nbytes == 0 || buf[nbytes - 1] != '\n') {
>> +               rdt_last_cmd_puts("mbm_cntr_assign: buffer invalid\n");
>>                 return -EINVAL;
>> +       }
>>
>>         buf[nbytes - 1] = '\0';
>>
>>
>>
>> I am open to other ideas to handle this case.
> 
> Reinette, what do you think about this as a stopgap approach?

This seems fair. I expect that we need to document somewhere that writes
"may" (to leave wiggle room for improvements) require page sized writes. 

> 
> The worst that happens is that userspace gets an unexpected failure in
> scenarios that seem unlikely in the near future (i.e., where there are
> a lot of RMIDs available, and at the same time groups have been given
> stupidly long names).
> 
> Since this is an implementation issue rather than an interface issue,
> we could fix it later on.
> 
> 
> Longer term, we may want to define some stuff along the lines of
> 
> 	struct rdtgroup_file {
> 		/* persistent data for an rdtgroup open file instance */
> 	};
> 
> 	static int rdtgroup_file_open(struct kernfs_open_file *of)
> 	{
> 		struct rdtgroup_file *rf;
> 
> 		rf = kzalloc(sizeof(*rf), GFP_KERNEL);
> 		if (!rf)
> 			return -ENOMEM;
> 
> 		of->priv;
> 	}
> 
> 	static void rdtgroup_file_release(struct kernfs_open_file *of)
> 	{
> 		/*
> 		 * Deal with dangling data and do cleanup appropriate
> 		 * for whatever kind of file this is, then:
> 		 */
> 		kfree(of->priv);
> 	}
> 
> 
> Then we'd have somewhere to stash data that needs to be carried over
> from one read/write call to the next.

Something like this seems needed for reading from this file. 

> 
> I tried to port my schemata buffering hack over, but the requirements
> are not exactly the same as for mbm_assign_control, so it wasn't
> trivial.  It feels do-able, but it might be better to stabilise this
> series before going down that road.
> 
> (I'm happy to spend some time trying to wire this up if it would be
> useful, though.)

I was hoping that we would not need to re-invent something here. This does
not seem like a new problem.

Reinette


