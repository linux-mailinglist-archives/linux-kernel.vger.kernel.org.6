Return-Path: <linux-kernel+bounces-572069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6974A6C624
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 997B17A6430
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F14722D79A;
	Fri, 21 Mar 2025 22:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XixhF0Lx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78C51EF092;
	Fri, 21 Mar 2025 22:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742597894; cv=fail; b=IEWdudN2Pd2bBUONLQqwDu6Aq7VGdjETJ+n1Jeer7dtHFqkokAoH/jddOLEgXjgMwntU0nS6RF71qXjMDfR2JkUmCmo1+CBjgb/ZS7qaiFLOaIGiS3YFAksenlHZtSOPBKtc9HtPMqrLIxxvoCzgkhTRg5fMIULaKPkNWv/CB/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742597894; c=relaxed/simple;
	bh=dzpF8P5UhK+JFR89yX/KL7XsGCx7lI9gJpZqJ+RwC6U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hqu7KE9XdFae831AXqSSEI0pArNIT8lZnH77gKJ5l9Yq4Peeqb7fem8Qeo1pyFIi4gXLLW1fyCl2Bsq/rizypQWxEj/at3lYvROxck/VrDBTNbSfhkkgHcoM1p8fTS8VTmOL54HMT7cBO6EFJCGgAY2Wu9JG0Z1UHXTDXIbAMaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XixhF0Lx; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742597893; x=1774133893;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dzpF8P5UhK+JFR89yX/KL7XsGCx7lI9gJpZqJ+RwC6U=;
  b=XixhF0LxhPkgRGoPKwJGOzg5/4u9ezhvfCWgaMqR3zV+gjoqyVPMj7JC
   0PkTJUpEWfZ9gdA8ESye5mfrtEm2lUfXDz3sIFWUNtpMqJB/znxjWcU11
   XGoVirAahdSNjKBvB7+WQ4TGtiKrYQ7V+yqkIzVcVBOKv66XqG9OuXRic
   MrPWVq5s+nijCWCJU2CEypeV0+NTGD8kDIWeLBmjSXL9S1JkAfgVBqkB/
   ZMCtsagDyJT2C1byeGYVpFktk/XVVy3/zmrNMow2DWiXF/djz7x6jGT8x
   j0ckg3E2p0Z4VYJZuViWDVNmiNKbHSL8dlC+djArbKMml/KoEHDzmC0dS
   g==;
X-CSE-ConnectionGUID: OhzsY3fSTrG732xRmSdtHQ==
X-CSE-MsgGUID: 8cJ4fIzHSg6T+TORWTcOPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43804919"
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="43804919"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 15:58:12 -0700
X-CSE-ConnectionGUID: q1vivID2TdiYCYsBDr3aNg==
X-CSE-MsgGUID: 0t14OYDSSp2HhrzemADD6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="123477004"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 15:58:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Mar 2025 15:58:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Mar 2025 15:58:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Mar 2025 15:58:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdFwZY6QjUJNBZZCqnsQn1+d/eQ68iNNc6B75Y0IQXTaLQM7EXdR1b/FNF0hSYwsILzZhB2Zw+K0Afx7WPEtfIXPvh0+OxhY45dw444x5U/fgl+HEL38bMpObHrVysjo6Bdq5cdcnvcUYKOea0/128EJ/ryuZIYiRPJnhSOAQld+D7brNa+ivbOp8k85eIKjEVJE2DfmoNl5WMv0jzwGaCYIwL5InSeybl+ap/9SGjfSkBbjRKjQXOkaORe3VvI5m/mNSQBrq1fVRkZJkkpQN3gTVzkhsXNvdUGdqf75lmqTkKSCWTY8e50Et4z110OxlZKXgdyVaPSN6chGJYMFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmjjmFFcpieNIt3DRUuP6xP70nVJiFAlyb4MZAdc2jQ=;
 b=I9Xhh65b59VKGOp4E5GHxVURpJQanhZSMQbbdzPX9J0KVprtmQBdq4XNfFDVWOrebpwIbMHbbzhbf8TY6oZ+iJlq2SdxRVQjhTHx6zxvNHH5FVpQ4g62l2qNzxRGfHKZhA+gX8EFZvm8V/d3G1N52CkfSv4syVwsIivbbJHtM4oZgPLZxL04NoVBGvIDlr+c22vfAzOrx0MOMvFY3VYEBofpZAPfbV7P20yQ/qJ4RJdncMM7zJ92TUKvcg8NOSZIjke4b3wqg8WOiTOrad3ui2M4LYR7TyZ9Kr36Gtq6IGogBmVnPgvW8/vUBufVwfsTQnxtIMEqWIVXFGohDeJqaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7647.namprd11.prod.outlook.com (2603:10b6:a03:4c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 22:58:09 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 22:58:08 +0000
Message-ID: <143ff530-ed4c-47c2-abb7-80ddf2adc0de@intel.com>
Date: Fri, 21 Mar 2025 15:58:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] x86/resctrl: Add interface to enable/disable
 io_alloc feature
To: Babu Moger <babu.moger@amd.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <thuth@redhat.com>, <rostedt@goodmis.org>,
	<xiongwei.song@windriver.com>, <pawan.kumar.gupta@linux.intel.com>,
	<jpoimboe@kernel.org>, <daniel.sneddon@linux.intel.com>,
	<thomas.lendacky@amd.com>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <seanjc@google.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <andrew.cooper3@citrix.com>,
	<mario.limonciello@amd.com>, <tan.shaopeng@fujitsu.com>,
	<james.morse@arm.com>, <tony.luck@intel.com>, <peternewman@google.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <corbet@lwn.net>
References: <cover.1738272037.git.babu.moger@amd.com>
 <aa0898d0e6514568086a87fce83969cd55d5a731.1738272037.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aa0898d0e6514568086a87fce83969cd55d5a731.1738272037.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0270.namprd04.prod.outlook.com
 (2603:10b6:303:88::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a7fe66-bf25-48a0-21e9-08dd68cbd90c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXRMUkZack8xMnk5SFZaOGZXSTJ4OEJCdHJNbDVWQkZzMVJxMWZlV1dQSW9X?=
 =?utf-8?B?ajlldHFRaUZicXFRb09ReE9iL242N01aYWZHWmlXUDhtTE55bXhBYVdQa0ZD?=
 =?utf-8?B?K043Y1c1dXRJNlk1c1hJSHJTamZYQzJOdDJqRkdTeE02SlF1TUhHa0RFREt1?=
 =?utf-8?B?cGdMaGRJUVpCZDhud3NsdDNVSDJQc0pGdmNaLzVGbTZsSWYySy8xTU5qNlNX?=
 =?utf-8?B?dE1rZlROQ3dsKzNNZkp3ODBUUzllcjhtWG92cmRFQzFnRy9NMkJFcGhGUVh6?=
 =?utf-8?B?b1lWRTF5ZnFMSTJnaUY3T0llOTJyaG1XTVppRlZlV3dOL2lQR1NLK3JXNzNH?=
 =?utf-8?B?UTZQWm5sMjMwV1BKNktBRnU0YTZVcEtuMGV0TFNuU2E5SGUyNnJnNis0ZGgz?=
 =?utf-8?B?UUR0Y1JnOVZxUUl2d2F0bVZRUWZqVzM2K1FCdVJOTHQrK0hzSzZPaU9oSkcv?=
 =?utf-8?B?NElSakdzVW1lekJWN2xvdDRGMzVXbVlORWJnK3o2YlhxcnFocVJiYUxHMU9L?=
 =?utf-8?B?NGVJQ2pDckdqQm9ZL2ljVnpjbFBrSHV2V0FML1lzZWhNRVFSWXpUYlIzVDJm?=
 =?utf-8?B?aW9TVVlnek1JcE1YTTZPbnBVNUJteEJlblIza0YwQWw4RWYwaTI0Rm1TSVlD?=
 =?utf-8?B?S2REaGhMQjQzcVJIdkpSTXd5Nk55SEMzMm1qcy8rOHZGSi80TUpzYm1TU2l6?=
 =?utf-8?B?WVZ2dzNUVXNaajl6QTdOWE5UYzgzYXA2U2N6KzhITE9OZUpUSmlwUHRBZWJD?=
 =?utf-8?B?OW9yMTF1VS9tMzB0RUI1aVl0ZHZ3NEo1cDVicFJDRzRwUDU3OTVJREZzNFdn?=
 =?utf-8?B?Z3htU1FuRUNEVm5NRXJ0T1Z2RGh5MUJXY3FXS1ZRd0ovWVVCZ3lwNDFlSVBa?=
 =?utf-8?B?SlNQZXF5aUJTUkhOdlVQTE1MYU5ONHlJYlFGVGhHSmhlbGFwWWFObmtaNmFQ?=
 =?utf-8?B?ZkUxbjN5Wnl4bE0vd0NWTnZVcit3dWp5eFRNL3BFQndKRUFTN2hoVzdrRWIr?=
 =?utf-8?B?T0tLSWlpaXFicmsrNWtXN1Q5anNVczB0WWlaZm40dHpaTGpYbWpyZjhFNHZu?=
 =?utf-8?B?akZ6eGxRSDFzL2VEYmNVbkVVQUF4TEVFOG1qOG8yeExWS0F5d2kyOCtPZVBW?=
 =?utf-8?B?SEpsaE5QYUlKQXJ1TEpIdVNzaG90bEVrTGFkbHVlNGw2U0VhM2ZBY1d3eW9H?=
 =?utf-8?B?RWU1TUl2NE9jZkFpek4yWTlXN01OYnlscWNRaUNZZERTaHJGN0h4c3U3SDNB?=
 =?utf-8?B?UkVvQmR2NW1DUjNLMXpWbGxtbXRyNXE2NTRoTmhyVURWdUs0TWs5cEVxc3FF?=
 =?utf-8?B?NEJVd01RWElDKzRhL3lzQUNWbkdxUFQ2R05JQ0gyYzM5TjZOSHYwZXZTeUsx?=
 =?utf-8?B?Vlo4T1luVUtNWEQ4R3MyaHF2ZlcySU5HbjVVSkdDSkJuMllDRTE1REZIaHps?=
 =?utf-8?B?bnF1SFcvcUY5cC81WERnNEQyZXhUalp1M3RaVGxtSFByK0QvQ3FrWndkemxB?=
 =?utf-8?B?c3FjQ1JMR2F6Z0dJb0lzYkxyaWhDNU9hR0g0VlJyYzRLMFdSQVk4d2tncVly?=
 =?utf-8?B?ckZtS2UwWFlySTlaUmZta3AwZzJPY3BlU3B1Yjc3YUk3dUl1YWg1Yk5qZHNm?=
 =?utf-8?B?WWJGMGdRbkFHS1o2WWtIL01ZVXZ2aHh3RHc3M1BGR0kwck5Ic2c1L09lWXVU?=
 =?utf-8?B?SEg2RW5uL2hYMGpxNExrZEROZ1hxa1NUZ2xZK29PZVJSZXd3UFpoSHZkWE9J?=
 =?utf-8?B?NjNNbDVPMFEwcWp1WVJrMHptRGwxUXVGYjkxcFpsWDA0ZUoxR21QTEdwQjNW?=
 =?utf-8?B?SHJabG5tNjJ1QjFxR2RQUE55YVdBdytxS1pqMDdwcWNDczJBUW82cFNrUkMx?=
 =?utf-8?Q?o7FBw9nMTyu9r?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WElCMnVtNjJhck5EL2E4dXNNdUlZSkZFeVdhYitNUjdGMWl4QWhvLzhWMWVU?=
 =?utf-8?B?aDF4UUcxbklIbUoxL3Jvek9JNVlBWGFlRGt6VitXNjY2RndoRk8xZnBQVG5P?=
 =?utf-8?B?SDdwODg3dzFoWFozUVI0MXozbXJkbG9LQU5OMnlmTll6SE9FREpEckc2Mm9t?=
 =?utf-8?B?YXU0ZmdwblVsd1gycGtXVWI3aFFRbVNpclZMVk8yWmVvVGZmT1E2TUxIOTZz?=
 =?utf-8?B?YVp6dXJXdVlTMTZGWWFGNUNoZjA3eGF2RFQ3MHFMamVFdlUrWWRjUU9KUmxR?=
 =?utf-8?B?SGJyRE9WZFNMUFVOTVV1Z28zc0xLaFZpSHBYbFFZWk1ORkNOMEo5L2lDQ3hJ?=
 =?utf-8?B?WDlxbm4xSGUwSHduQmdrcmRFRkdJV0k4RGdrRHBjUUVnNk9wMjRGbzFka3N5?=
 =?utf-8?B?NmN2elJpcGJuODQ4Y3AreUVYUFI5S2dXUmhQenpnN1NFQktjSmpFNFkyY3A4?=
 =?utf-8?B?MDVkMGxKeVhKczB3NVZFYUZ5VUZWODF2T0crdlB5Yk1ySUJkMVNod3k0SjQ2?=
 =?utf-8?B?T01NSHFUOUtlSVgrQ3RNekRjMFBvRmd1dVJ0aHorZEFXNHVqbXpvRnhKMnow?=
 =?utf-8?B?aXppd3psWG9PRUtmRGtPOVdtKzJHNU1FNzRZNGhnL2swK2JjeWRpSXJ3ejdL?=
 =?utf-8?B?eVVPSDNmR1JFWUx1emJnbEl4N1UxNVYzNlpQZ0RRbkt6WS9jditLaElxNmEy?=
 =?utf-8?B?cGVjajdkclB0a01qam96bHkwKzZlcDVpbk9kN0MxTDNDZFlkd1dkajFCQlhw?=
 =?utf-8?B?UG0va216VnlnSkp4Um1OVlZhVFAvOFdqWTF2QzZVYVdVb1VaSEZDTEhwTTJW?=
 =?utf-8?B?RGtoZEJEV2thRGl1UlFteVdUaW9YR2o3aDNSa3VvQ1AxUEtndTNabzhBcTJR?=
 =?utf-8?B?czJzVjlnaHpwNXVNTDdFMmRkRmJVaDRQTG5uS2lEYkZPdE5vMGFsUmJ6TVBU?=
 =?utf-8?B?SE1CSy81Wm8zZ0lja2gwOUhrSW12ZWdaMFV5anFDaW9vcVBwTGI2bVZJb0Rv?=
 =?utf-8?B?MVh1NEc2MlBUeFZxVm04WGhhZHVkT3FYUGtqaHpRNktnbVNxRjZJc0FYcGxr?=
 =?utf-8?B?QWFvR1hiL1hiUkJDcFdyUXJ1bEZXVFFzdkpDSXd2QmRpQnZlVWpONnVNVWJJ?=
 =?utf-8?B?emFnL1hmNEtGK1BKc0R2QnhoU2NLVWsvS3NzOWllS1grRmltb3ZTSExyWmFQ?=
 =?utf-8?B?RWVuMEhrMlFmRmxsZzBVMU4zZGN5OGtPck9rSGdEay94dVpXMG5seGRTelNE?=
 =?utf-8?B?bnJTTlBTWEw0cHVaL0tlK0RuMWhzcUtOVHljR2Zrb1ZubzBFeUxFa3FxZDFC?=
 =?utf-8?B?d2FJNVc3a3FvWXR4NVVqQVBwM2tNMkM5MXJBSGdaekJ2dUZWYVNNSXppVzc3?=
 =?utf-8?B?b1A2WmZybmx1aWtXVkNCTFJjYStyT1NXSlhva29oSWpYbldjMWVXeG54QTND?=
 =?utf-8?B?OEZRQUIzVW0xT3I2YjFYOW9DWjI2YUJJS1pzdUZCSFhWeUVFQVFWdmo2MXJK?=
 =?utf-8?B?QW8zMFB3SkwrUGRGUkNuRTNwZXVDRWZlNnhndmxhLzNuZ2R2SFROd25qajFS?=
 =?utf-8?B?V3dXRk5nQUptZG43empZSTBQYUxrWTIvMGRMcU80SUVTQitXbGlCVWR0ek5N?=
 =?utf-8?B?VmVuOENUeWg2eUpuRVlZV3Y3cTU0V1FkNUJ4Q0oyMFk0QXR4SnpxYU9EZzF5?=
 =?utf-8?B?RGtuZ1VodVF1d3VVTkxzcHZMVVZReHNLalNjeURCbTlIMDlQMFRmYlQ2RzBa?=
 =?utf-8?B?YVh1UWJ1VEJvM2pxb0ZmdjA2VytoSW5kZ1JrZGpXM0oxVFJlbWtKSi9pRTBB?=
 =?utf-8?B?OXVEME5kcVpQNGhDOGxUTEUwcFh6blNIajBsZ0w1U3psLzcxMytlekFObjRC?=
 =?utf-8?B?M1VmazRQYjBJUmhoWUxGMjk5Mk8zdldLL3NncDBFendwYTFzaFIwV2JNVjAx?=
 =?utf-8?B?bUxXeE83Q25MdDBFamIyalY5T1dkUXVIb0JBLzB1bXRZYkVpc0k0K2lFdHhG?=
 =?utf-8?B?TG9oKzFSR2hoYmFYOVJ4dkVESEhWZkkwMHRSbkxLQVZEay9DV3g0VjlYV3c0?=
 =?utf-8?B?OHYxL2lNYTMzNmtxbTkwOTZnZE1MTU5hT0JFeUJjU3VFT0YrdndoVXNoU2NS?=
 =?utf-8?B?RzlhZUUzMWw1VHpUWGdVUXJtRmcycllCK3IrdlVIdTFYVTNodXVuT0dHRGNs?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a7fe66-bf25-48a0-21e9-08dd68cbd90c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 22:58:08.6918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYPXjlSUkUn5AiNs8VHKwuopsHaJfokxyOe/olHQ4B3OBpTL8cHRAvw2Z06MYDogaAeoq0LgQzWHoHHM8of0pppSNLEo7RxzNQarV4gFKIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7647
X-OriginatorOrg: intel.com

Hi Babu,

On 1/30/25 1:20 PM, Babu Moger wrote:
> The io_alloc feature in resctrl is a mechanism that enables direct
> insertion of data from I/O devices into the L3 cache.
> 
> On AMD systems, io_alloc feature is backed by SDCIAE (L3 Smart Data Cache
> Injection Allocation Enforcement). When enabled, SDCIAE forces all SDCI
> lines to be placed into the L3 cache partitions identified by the
> highest-supported L3_MASK_n register as reported by CPUID
> Fn0000_0010_EDX_x1.MAX_COS. For example, if MAX_COS=15, SDCI lines will
> be allocated into the L3 cache partitions determined by the bitmask in
> the L3_MASK_15 register.
> 
> When CDP is enabled, io_alloc routes I/O traffic using the highest CLOSID
> allocated for the instruction cache.

You can append a "L3CODE" to the above to help provide context on what resource
is referred to as "instruction cache".

> 
> Introduce interface to enable/disable "io_alloc" feature on user input.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v3: Rewrote the change to make it generic.
>     Rewrote the documentation in resctrl.rst to be generic and added
>     AMD feature details in the end.
>     Added the check to verify if MAX CLOSID availability on the system.
>     Added CDP check to make sure io_alloc is configured in CDP_CODE.
>     Added resctrl_io_alloc_closid_free() to free the io_alloc CLOSID.
>     Added errors in few cases when CLOSID allocation fails.
>     Fixes splat reported when info/L3/bit_usage is accesed when io_alloc
>     is enabled.
>     https://lore.kernel.org/lkml/SJ1PR11MB60837B532254E7B23BC27E84FC052@SJ1PR11MB6083.namprd11.prod.outlook.com/
> 
> v2: Renamed the feature to "io_alloc".
>     Added generic texts for the feature in commit log and resctrl.rst doc.
>     Added resctrl_io_alloc_init_cat() to initialize io_alloc to default
>     values when enabled.
>     Fixed io_alloc show functinality to display only on L3 resource.
> ---
>  Documentation/arch/x86/resctrl.rst     |  34 ++++++
>  arch/x86/kernel/cpu/resctrl/core.c     |   2 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 144 +++++++++++++++++++++++++
>  3 files changed, 180 insertions(+)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 6768fc1fad16..1b67e31d626c 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -135,6 +135,40 @@ related to allocation:
>  			"1":
>  			      Non-contiguous 1s value in CBM is supported.
>  
> +"io_alloc":
> +		The "io_alloc" feature in resctrl enables system software to

Since this is already resctrl documentation "feature in resctrl" could be dropped to
be just:
		"io_alloc" enables system software ...
	

> +		configure the portion of the L3 cache allocated for I/O traffic.
> +		By directly caching data from I/O devices rather than first storing
> +		the I/O data in DRAM, reduces the demands on DRAM bandwidth and
> +		reduces latency to the processor consuming the I/O data.

hmmm ... looks like "SDCIAE" was deleted from earlier used (marketing?) text and
resulting text left as-is without re-checking if resulting text is still coherent.
I do not think it is needed to motivate/market the feature here, perhaps last
sentence can just be dropped?

> +
> +		The feature routes the I/O traffic via specific CLOSID reserved
> +		for io_alloc feature. By configuring the CBM (Capacity Bit Mask)
> +		for the CLOSID users can control the L3 portions available for
> +		I/O traffic. When enabled, CLOSID reserved for the io_alloc will
> +		not be available to the resctrl group.

Although the above reflects how SDCIAE is implemented it may not be true for how
another architecture may support this. hmmm ... this sounds familiar and looking back it
is the same thing I mentioned in V2 feedback, actually, in V2 I pointed to V1 feedback
that said this also.
If you insist on this text then please change the tone that indicates the
behavior is optional. For example, "An architecture may support io_alloc by reserving
a CLOSID to configure the ..."

> +		::
> +
> +		  # cat /sys/fs/resctrl/info/L3/io_alloc
> +		  0

Please refer to cover-letter about proposal to use enabled/disabled/not supported instead.

> +
> +		  "0":
> +		      io_alloc feature is not enabled.
> +		  "1":
> +		      io_alloc feature is enabled, allowing users to manage
> +		      the portions of the L3 cache allocated for the I/O device.
> +
> +		Feature can be enabled/disabled by writing to the interface.
> +		Example::
> +
> +			# echo 1 > /sys/fs/resctrl/info/L3/io_alloc
> +
> +		On AMD systems, the io_alloc feature is supported by the L3 Smart
> +		Data Cache Injection Allocation Enforcement (SDCIAE). The CLOSID for
> +		io_alloc is determined by the highest CLOSID supported by the resource.
> +		When CDP is enabled, io_alloc routes I/O traffic using the highest
> +		CLOSID allocated for the instruction cache.
> +
>  Memory bandwidth(MB) subdirectory contains the following files
>  with respect to allocation:
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 1ebdb2dcc009..88bc95c14ea8 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -309,6 +309,8 @@ static void rdt_get_cdp_config(int level)
>  static void rdt_set_io_alloc_capable(struct rdt_resource *r)
>  {
>  	r->cache.io_alloc_capable = true;
> +	resctrl_file_fflags_init("io_alloc",
> +				 RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE);
>  }

Some MPAM changes landed since you created this work. After the fs/arch split the
architecture code should have no insight into the resctrl file flags. Please refer to
the MPAM changes on how this can be managed. You can refer to thread_throttle_mode_init()
and similar to that resctrl can use the io_alloc_capable flag to make the files visible.

>  
>  static void rdt_get_cdp_l3_config(void)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index c5a0a31c3a85..37295dd14abe 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -62,6 +62,7 @@ static char last_cmd_status_buf[512];
>  
>  static int rdtgroup_setup_root(struct rdt_fs_context *ctx);
>  static void rdtgroup_destroy_root(void);
> +static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid);
>  
>  struct dentry *debugfs_resctrl;
>  
> @@ -180,6 +181,19 @@ void closid_free(int closid)
>  	__set_bit(closid, &closid_free_map);
>  }
>  
> +static int resctrl_io_alloc_closid_alloc(u32 io_alloc_closid)
> +{
> +	if (__test_and_clear_bit(io_alloc_closid, &closid_free_map))
> +		return io_alloc_closid;
> +	else
> +		return -ENOSPC;
> +}
> +
> +static void resctrl_io_alloc_closid_free(u32 io_alloc_closid)
> +{
> +	closid_free(io_alloc_closid);
> +}
> +
>  /**
>   * closid_allocated - test if provided closid is in use
>   * @closid: closid to be tested
> @@ -995,6 +1009,33 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +/*
> + * io_alloc feature uses max CLOSID to route the IO traffic.
> + * Get the max CLOSID and verify if the CLOSID is available.
> + */
> +static int resctrl_io_alloc_closid_get(struct rdt_resource *r,
> +				       struct resctrl_schema *s)
> +{
> +	int num_closids = resctrl_arch_get_num_closid(r);
> +
> +	/*
> +	 * The number of CLOSIDs is determined based on the minimum
> +	 * supported across all resources (in closid_init). It is stored

closid_init -> closid_init()

> +	 * in s->num_closids. Also, if CDP is enabled number of CLOSIDs
> +	 * are halved. To enable io_alloc feature, the number of CLOSIDs
> +	 * must match the maximum CLOSID supported by the resource.
> +	 */
> +	if (resctrl_arch_get_cdp_enabled(r->rid))
> +		num_closids /= 2;
> +
> +	if (s->num_closid != num_closids) {

Considering from schemata_list_add():
	s->num_closid = resctrl_arch_get_num_closid(r);

... the above "if (s->num_closid != num_closids)" just compares the value to itself, no?

This function does not actually take all resources into account with the above
comparison. I think what you may need here is a comparison with closid_free_map_len?

As I understand it is still possible to use io_alloc when the resource's max CLOSID
is not within closid_free_map, this is just not done simplify implementation.

> +		rdt_last_cmd_puts("Max CLOSID to support io_alloc is not available\n");
> +		return -ENOSPC;
> +	}
> +
> +	return num_closids - 1;
> +}
> +
>  /*
>   * rdt_bit_usage_show - Display current usage of resources
>   *
> @@ -1038,6 +1079,14 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>  		for (i = 0; i < closids_supported(); i++) {
>  			if (!closid_allocated(i))
>  				continue;
> +			/*
> +			 * If io_alloc is enabled, the CLOSID will be
> +			 * allocated but will not be associated with any
> +			 * groups. Skip in that case.

This defeats the purpose of "bit_usage" that gives insight to user space
on how the cache is allocated. Instead of ignoring portions of cache
used for I/O this should display to the user that these portions are
used by/shared with hardware.

> +			 */
> +			if (i == resctrl_io_alloc_closid_get(r, s) &&
> +			    resctrl_arch_get_io_alloc_enabled(r))
> +				continue;
>  			ctrl_val = resctrl_arch_get_config(r, dom, i,
>  							   s->conf_type);
>  			mode = rdtgroup_mode_by_closid(i);
> @@ -1830,6 +1879,94 @@ int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable)
>  	return 0;
>  }
>  
> +static int resctrl_io_alloc_show(struct kernfs_open_file *of,
> +				 struct seq_file *seq, void *v)
> +{
> +	struct resctrl_schema *s = of->kn->parent->priv;
> +	struct rdt_resource *r = s->res;
> +
> +	seq_printf(seq, "%x\n", resctrl_arch_get_io_alloc_enabled(r));
> +	return 0;
> +}
> +
> +/*
> + * Initialize io_alloc CLOSID cache resource with default CBM values.
> + */
> +static int resctrl_io_alloc_init_cat(struct rdt_resource *r,
> +				     struct resctrl_schema *s, u32 closid)
> +{
> +	int ret;
> +
> +	rdt_staged_configs_clear();
> +
> +	ret = rdtgroup_init_cat(s, closid);
> +	if (ret < 0)
> +		goto out_init_cat;
> +
> +	ret = resctrl_arch_update_domains(r, closid);
> +
> +out_init_cat:
> +	rdt_staged_configs_clear();
> +	return ret;
> +}
> +
> +static ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
> +				      size_t nbytes, loff_t off)
> +{
> +	struct resctrl_schema *s = of->kn->parent->priv;
> +	struct rdt_resource *r = s->res;
> +	u32 io_alloc_closid;
> +	bool enable;
> +	int ret;
> +
> +	if (!r->cache.io_alloc_capable || s->conf_type == CDP_DATA) {
> +		rdt_last_cmd_puts("io_alloc feature is not supported on the resource\n");

rdt_last_cmd_puts() starts with lockdep_assert_held(&rdtgroup_mutex), also expect
rdt_last_cmd_clear() before first use.


> +		return -EINVAL;

Could ENODEV be used instead?

> +	}
> +
> +	ret = kstrtobool(buf, &enable);
> +	if (ret)
> +		return ret;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	io_alloc_closid = resctrl_io_alloc_closid_get(r, s);
> +	if (io_alloc_closid < 0) {

Could you please add an informative message in last_cmd_status? It may be
possible for user to remedy this and retry.

> +		ret = -EINVAL;
> +		goto out_io_alloc;
> +	}
> +
> +	if (resctrl_arch_get_io_alloc_enabled(r) != enable) {
> +		if (enable) {
> +			ret = resctrl_io_alloc_closid_alloc(io_alloc_closid);
> +			if (ret < 0) {
> +				rdt_last_cmd_puts("CLOSID for io_alloc is not available\n");

If the CLOSID is not available then it may be possible for the user to remedy this by
removing a resource group and retry this operation. Since CLOSID is not useful to user space
(and x86 architecture specific) this could  be improved to give guidance to user
space about which resource group (by name, not CLOSID) is preventing this from succeeding.

(this sounded familiar, looks like I provided the same feedback to V2, to which you
responded "Yes. We can do that.")

> +				goto out_io_alloc;
> +			}
> +			ret = resctrl_io_alloc_init_cat(r, s, io_alloc_closid);
> +			if (ret) {
> +				rdt_last_cmd_puts("Failed to initialize io_alloc allocations\n");
> +				resctrl_io_alloc_closid_free(io_alloc_closid);
> +				goto out_io_alloc;
> +			}
> +
> +		} else {
> +			resctrl_io_alloc_closid_free(io_alloc_closid);
> +		}
> +
> +		ret = resctrl_arch_io_alloc_enable(r, enable);
> +	}
> +
> +out_io_alloc:
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> +
>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{
> @@ -1982,6 +2119,13 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= rdtgroup_schemata_show,
>  		.fflags		= RFTYPE_CTRL_BASE,
>  	},
> +	{
> +		.name		= "io_alloc",
> +		.mode		= 0644,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= resctrl_io_alloc_show,
> +		.write		= resctrl_io_alloc_write,
> +	},
>  	{
>  		.name		= "mba_MBps_event",
>  		.mode		= 0644,

Reinette

