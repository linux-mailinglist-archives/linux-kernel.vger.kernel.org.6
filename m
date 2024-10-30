Return-Path: <linux-kernel+bounces-389756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB2D9B70CF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2721C20CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7CF217657;
	Wed, 30 Oct 2024 23:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYaOQ7mv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404431E2835
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 23:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730332661; cv=fail; b=J4aqUxV22gJxYItwD85gO1NgEKwbDAfZ35r6uuo8ABS0VF1Z8O8YC4q+lB10/BJ3vPCZds+vtDp5HdqGEbfsks52funVIESE3Xw9JhRWlplWbotWJnEGgj2XtNvHeTlikn41Zbi1GJ+2CmZLa7CTJ8HSypJ92a+aXa9iMUMKtrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730332661; c=relaxed/simple;
	bh=ShFSf4pjkMALKjayRgYlPkdTc36DNZsssM/vtu2JoYw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TeZj+/PzpZCnFktC0nErqfdKBz4QlZt36lccN9ofCSVTAQsO1zf3V0feR47uuVQmfYoLYyc9Ui3JqEjP8FPRFEA0M794bSMQYBWTREEXK7R9gnytF5e47EACtiClt8QQQMXg0vyRj6tJFLMWWbCPY6Gh6vLQy2YtFTds7H+Lj9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYaOQ7mv; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730332660; x=1761868660;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ShFSf4pjkMALKjayRgYlPkdTc36DNZsssM/vtu2JoYw=;
  b=mYaOQ7mvifKy05lzASY2nisia1nTqkzjbpmFcW/72QcfEDCY//IzYX4W
   d9F3bQ5HksADitcFIq/uRdhIwDhthCM2utNOSJBO0bKQ6eGR4+vKGwaIq
   YzRkEm+MgfI7vOvq9NYd/P7njJ+dpdaODsUxDcNtVJX+QJkkFouSpLCrn
   dHZdbnQ4A6xsXHJMH4/lmDa5GNgF/N82NRpi/PknXI+wYUT3buZaHrKYh
   rjFK4aDUC5L7NolkcsaHrXtft370hQzAJHVKngUd/P9Ut7m75LLFZXhD6
   KQ9jmrrKwQ190rdDzJQt0MeUxeX0w9KRmxEgBpNwJRF+hSDvFFiRzJFfQ
   w==;
X-CSE-ConnectionGUID: KgKybhoxRD+m4J43tFP7Qg==
X-CSE-MsgGUID: pshTU2JSR8iz8WvFfx59sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="32897695"
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="32897695"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 16:57:38 -0700
X-CSE-ConnectionGUID: J9jzYtx3QRuBLIQ9FjPMFw==
X-CSE-MsgGUID: eHoe1eNLRni2ylQ/DX1MZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="82627265"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 16:57:38 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 16:57:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 16:57:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 16:57:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGaoiuTKfk9b5WZnrYG9YoB/f0xxoB0x69uwp5yHKy9rarzCum71cIwDw4lMHn31pQWVJUMi3o365oLUCISIXjFKEWjoETCtzNMAS50CVciLJiLmV49ntFQe50M2ubK4JcffkJ1CXhujRIEyHRxTL+0nSfKkOZ7Jm+fEkjAWGzzQ0RTwlfVohCk81pu7OKz9uUb4p8nxSQtaQfMsOgiAEPLJbA6nguaTfB3WtoblZfnusFxx+SN/BZmTLHj8YydBdTte3cRVWmUscyXn22GoPSeICLaHkhAgI9TPfzGGnngrxjqy0x7MGTqiwxSl4SXbB4VVSjT6frKtp1a/VDF7Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bsz8NdY2aGrS8FOgSGYFYz3WRK5cUdfvzSQ/J+vOdEs=;
 b=KuvGTFwGe5f7ygkROqPYBOn2c+BaopuGgXI5wwykziDz7DSfFsgOtciGVARl72vlzfVyqGF+PmzX4kJZBgZsbqL2vxfVv3IWoo9k3KBRFT/PBOugY3Rb6Wh2jm1F05MK0tOohT0gpXxJJa0W2PjDj3hUblgjxQ7PULUZJw6J1kiRt2jpljc/pbkVErL/4R/tGmnelGcconzK39Qdw6DTiwTM0sBo6ZzbMz5XI0CZU9SuTpEFSfYVlF38mfJKtQJaWZABRkatX0VCoMPgwxrbwl070wVs5JMXrwBLSPo2H5CNoi0lAWp8iWAr7Jt5QG9SEkFMBPY2EhH0snuIZUy5tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Wed, 30 Oct
 2024 23:57:35 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8093.024; Wed, 30 Oct 2024
 23:57:34 +0000
Message-ID: <b4fce5bc-833d-452e-bee6-625c88eaf484@intel.com>
Date: Wed, 30 Oct 2024 16:57:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/cpufeature: Add feature dependency checks
To: "Luck, Tony" <tony.luck@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H .
 Peter Anvin" <hpa@zytor.com>, Uros Bizjak <ubizjak@gmail.com>, Sandipan Das
	<sandipan.das@amd.com>, Sean Christopherson <seanjc@google.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Vegard Nossum <vegard.nossum@oracle.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Nikolay Borisov
	<nik.borisov@suse.com>, Eric Biggers <ebiggers@google.com>, "Li, Xin3"
	<xin3.li@intel.com>, "Shishkin, Alexander" <alexander.shishkin@intel.com>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241030233118.615493-1-sohil.mehta@intel.com>
 <SJ1PR11MB60836BD27B436E3E8B404AA2FC542@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <SJ1PR11MB60836BD27B436E3E8B404AA2FC542@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:254::30) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH0PR11MB5191:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0c977b-b0e9-44f6-6f59-08dcf93e9ff0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amFxQlhaWHJwRUoyWXVidVdPeFRxb1ZPR2cvbFNCY2puSm00SXdQZnl6UWFH?=
 =?utf-8?B?KzFKakgxcFphc0FoSG1Mc1l5b1hjQWd6TDE3NUx3ckFNNGowcldCRnlYaWx0?=
 =?utf-8?B?NEJyUDk0UW81T3ZxY1hNQURVRnVWd2dlWUxVTG5EWHFTb2g2djdyVHlzTlBG?=
 =?utf-8?B?SXNVRjk5TndzaDVOZWlaQmszSWw0WXlMQVJxZGtJMGJCWUNEYUJZT2dnVjVQ?=
 =?utf-8?B?VWdaSFdmdC9QU2VJRzJEN29QOEs2RjJ5S3FkVkg1cE9JY0N3UGowc3RhTHph?=
 =?utf-8?B?ZFZ4UjVWdzhXTWJmTkVBZm1ic3UzVC9YbWkrQVdLcDZGTGVXbHdVVEk0cklp?=
 =?utf-8?B?aTF3YmxrV0U0dVI1ajA4SkRQb2tmdWhtUkRta254ZUNkaFlLeWQ5S0MvdmI5?=
 =?utf-8?B?Q05FV1ZhRUNTaHdqamhKSitxV1dFWTByeURBUVJIT2gzdks2ME5Sb1c0cmtO?=
 =?utf-8?B?STBDUVZ6ZmZTTHJTQm0rQktMTDVVYkZTbmRLVVdoUmxPT2JyOFZNWkNFUzlS?=
 =?utf-8?B?S2x5ZVdqMFNpb0pSZ3BhWjUrVlF4ODlHZG1rTXNlMkd5aEQyb25sQ3F3U1NU?=
 =?utf-8?B?aG8wV3p3TnBORkhkTUZJSnR2VGI5RkQ5dXE4MFhPcEZYcUY4QS91V2U4R3pv?=
 =?utf-8?B?Sk5QRDEvbURaWDlSU01kQmdteFBRT3NtbXlrUjFrNnRDdDA1V0MyOENOREwy?=
 =?utf-8?B?MldwUlVPb0Q0TlRVYXZBZGFZc0gyTC8zcjBwemZhbElFeUxTWVV5aWZKQTE3?=
 =?utf-8?B?SmpiRjdNYUFmRXB4SVRRZjVOUVlXM0dMY2dSU3NnbGVHVnZsZmJzT3J4Um9x?=
 =?utf-8?B?dk9xK1VJYlRzbm9CR3NFY3hUbkNUbjRDR0xheDY1SUZPekNGOGdodEpOckta?=
 =?utf-8?B?cVA4S3QxdnlHaTZ5QStxMmJlZmJtbEl6V2Y1NG5ONEVsZ3NvMkNOM2orM2xz?=
 =?utf-8?B?c2U1TVE2VGdhdXVZQWFWRU03NHdjU0thdEtjTzlvdEVrWHN6SXhKY0ZZcWFp?=
 =?utf-8?B?RGw5dkdjVEV2L09PZ0ttaDY3Y2poRVF4dVNQakRLTW1MZlBQTGt1UnIvTTMz?=
 =?utf-8?B?YkhhQytHc0RKUTlqT1FqQ3hGbUhRa2RZaEUvUmVoR2h0VWU1UjdBeTVhbGlT?=
 =?utf-8?B?SnNiTU1aRVEwNDNJM2xNRERoMU5DYnppWTB6aEVIZFBJREZrdy9PbnNxMVZ6?=
 =?utf-8?B?WElJeTZRaExmdzljZ0ljSlg0ZnpVaXRXVktxbFZxeXQzelRVVGZmNTh1RGN4?=
 =?utf-8?B?aVZjbXMzRDc5WHdPVUVVZkFFQXJlT1d0Z1ZkTVIzSTF0TzMxbE40Tm13dDBU?=
 =?utf-8?B?R2JyMFdPajMyYk9vZFZWR3dET1h2cUJHSmFUV1RTRWFibFdNUmdCbE9jckcz?=
 =?utf-8?B?ZVJQbzVVOXFER3MxUmNwMmM4N0p1U3BURlN1WEd4ZmFaNTl2cjNialc4TEEx?=
 =?utf-8?B?SzMzd2h3ZGlTUGpUWTNKWm1uRjhQNnNab3dZN3hYSktkWGE1Z0tKdEduTVRo?=
 =?utf-8?B?NkFQdDdvT01kRDdtTk5pTmlrNU44NXgwWGM3RXM3M2JQcEVuamJmbkNYVFB4?=
 =?utf-8?B?dE9DRzZGWkZFYUFrcjhtdGsxU3hlcDZKeEgyOVNyc3V4UHM4TmdqWDdEWDdD?=
 =?utf-8?B?a1BBT3pIL1VYMDhza2FacG1MNkJtY1ZkVDhlMXZTVWQ4ck9CeVIxcW9wYlJs?=
 =?utf-8?B?VlpSTmY2TzRJcks0Y0UwNU9obFp3MlN2U1VCK2lVWnJ5ZjRiaVNaODI0cklM?=
 =?utf-8?Q?KqFZEeMSyrsCvkXih/ahrh3iNs84Ct+RtntR7nK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RENIYnorRjBnYmFHMmxSRlhiYVVOQjc3Sy9QdUM0a1VNbEh3NWhadytNQTda?=
 =?utf-8?B?UUltdXZlNWR4dFFBWE1lam05NEF1UWg0K3pLQ21nNVpKRW9HZ2ZIYlJTWW5G?=
 =?utf-8?B?Yit1R0FBcjhtWjhmQm5NM09PZ1RlTTMyZm1ld2lJbUhmbk1odmM4RndOZEd5?=
 =?utf-8?B?V1Jta003VnIxZjVxZnEzSHdyY2NFd3FHZXB2TTNRY3FrdzlQbmYrMXlXcHdN?=
 =?utf-8?B?QkhsQzRkVGxzVFc1bWR1cjhqRnB1Vk43d3p2MDVOM2tQb1BZSGxuU2VqV3Fa?=
 =?utf-8?B?Ly81NjdmVkJDamRWZVNOTmU0eHRrU1RLWnlLZXRYRDI5K3UvV2dZVjR5WTRm?=
 =?utf-8?B?TS9ucjBvOEZiYWRxNTBGbytNdlhiRStSREZxZGV4QmpoZlBtUkRBL0FjWnAz?=
 =?utf-8?B?N0dDRG00L0cxVVhXbng1T1IxTFFaN0psd0o3bTMwcGd0QVBqeHlyamtYODRs?=
 =?utf-8?B?U2lnMjUydkZkUlpnZTNNQmZnRGlleDBPazc1L0NNb2FCOUpFUGpyWTg1cWl0?=
 =?utf-8?B?TkRYd0t4RmxSS1JsUUluWFJlM2lyYWNscDhHYnhNRHZ4dkw4d2themNKK3Fn?=
 =?utf-8?B?ejdBUStkb0dXTjZZdHhFcVhTc0Y2NkZYekR2UXlYS00wUVYyeVRyQ1dWQUJX?=
 =?utf-8?B?Z0dDUm1FcDFxTUVFWjk5TEZaeHlBbWZGYnhsaUx6aDNUYTZ6aWpod2tCWm4v?=
 =?utf-8?B?Y2JtM2RUeDVSRk15bFNTZURBV2JHR2ZXeVd0azlhbHZwUFg5c09HdWdDWGxv?=
 =?utf-8?B?N0R4RVJEMGVpR2FhdmZwUG5aUEpGMDQwNXQrMk5PUXFGMWdmMldLQXRLMGNK?=
 =?utf-8?B?MmJJOGVJdG5wSkRuVzRWTGlWUEF1aUJ6bGdrUG0xUWhFSUh0cnlPSzZEcGxs?=
 =?utf-8?B?bEVobWswdURDZjJZUjhQUW1tT25GRXVDUW9POWxiTmFSZlVtN0ZmUTJOcUls?=
 =?utf-8?B?anF6OG5MT2VXTmpnT0F1VlVFU3YvUlcwZlRSTjNNdU5tandJY1c3cXd1R0lv?=
 =?utf-8?B?THlTNThXOVRyVUtRV1M5eW43V0lnWDhWUTBaY3djdEwyMloxVXlUZ0Jib0F5?=
 =?utf-8?B?UDUvdjdMWm4vWkg3YW43aDlKaGQ3eDRheGYxMGtYampKTlUvZUNGbU5BYkp5?=
 =?utf-8?B?Ti9taUp5UTQ4Z1JJU0NSOFpOUHBJdEpxdklYVTd1VnRlVmtjd2JCeDEvRGZG?=
 =?utf-8?B?U2FMY0pEbElxdUkrRXNveGlkRzZ3RXVta2ZOMmV5Y0haNDV0cnpQTm9SMkJ3?=
 =?utf-8?B?WEJGQTlRdGp6QmdNSDVzQUN5T3g2WW5mdVVHckxLMytsUkMwRlN5ckU3b3R6?=
 =?utf-8?B?Z2dKVkczQ3FVVHM5L3VBY2VGL2RPWkhLZUoyR1JSUDlBODhqc1ZLc0VsYStF?=
 =?utf-8?B?NWF0c0JLR0FoYXF2ZkVGRWxPNUd4dEZMR1QvMlY0R2dDekd3cEtqbjU5TVlD?=
 =?utf-8?B?U3BHSWYyZENiV0pjSnRQK1JIWHlzMXlkcFpaYWFReTBBMTdBTy9TZXRFWU1F?=
 =?utf-8?B?R2xVZE1wV0hlZ0o0THc5NzZ5QTNaeWFDRTVJa2xncWFadkxGV2V1VFBKSkJB?=
 =?utf-8?B?bVliRmxWU3JYdWpJdm9lU3VsL3dNMzlldzZqNmJxZmhlbmI4bHlKK25DS0FR?=
 =?utf-8?B?UXpDRlcrK0ZvUkZoNDNpL1pLMlpnU0Z4Zm0rZTZDRUZaSUpmUjAraHFJSnlQ?=
 =?utf-8?B?T0dOL0p6clFJRU9XTHhMQ055WFlnSzlyRjgrNUdLWDdyWk5SMUxZMFEydlZh?=
 =?utf-8?B?ZHZjSDN6cjlPYld1Nnc2a0NFNEhKZGpLdUd6bXJBQ04zOWQzcHN3SEFTWlI1?=
 =?utf-8?B?V0Z5bHNzYzBSZFRveE11RmNkQ084YWRTdyt6SVdxOHMvR0R2YTlpSnhHaU1L?=
 =?utf-8?B?Slk1bVpDbnA3TFVuaGtpMVQ1dUR3TWdXVC9KYUE5YkMyVnBkU2k2MmJ3cDRX?=
 =?utf-8?B?QkFWNWR4TXR6KzdRQ09qK3ppRm40WVhNNTZwMk05OWxLS2JxT0hpb05ROER1?=
 =?utf-8?B?TWVLRXpTT1dQWGNEUGRHVnlZR1FFUmhXNDhURVhTa1k5ZTFmangxZ1paQk5G?=
 =?utf-8?B?cklnb3dJRytRdE9aRk16OUxXdll5UkpoNkd5aUhHQktFR1pzWU9XbHlraGhz?=
 =?utf-8?Q?ZCpu/4LsxcTxNZwp+8QuEKR8h?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0c977b-b0e9-44f6-6f59-08dcf93e9ff0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 23:57:34.7909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaQd87GV/wqY17//iCWVOTqG3Z3IGzRNp1M9QIKrHsIdMhaOfLTjjqPc32NzUdkmv0olygBpkWvsZeinui3Vow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5191
X-OriginatorOrg: intel.com

On 10/30/2024 4:44 PM, Luck, Tony wrote:
>> +void filter_feature_dependencies(struct cpuinfo_x86 *c)
>> +{
>> +     const struct cpuid_dep *d;
>> +
>> +     for (d = cpuid_deps; d->feature; d++) {
>> +             if (cpu_has(c, d->feature) && !cpu_has(c, d->depends))
>> +                     do_clear_cpu_cap(c, d->feature);
>> +     }
>> +}
> 
> The dependency check found something very wrong. Should there be
> a pr_warn() to give some clue that Linux papered over this problem?
> 

Not sure if this necessitates a warning. A missing feature may not be a
problem for the user. I am treating a disabled feature due to the
original CPUID enumeration not being present vs due to a dependency not
being met as the same.

System and kernel developers would definitely care if an expected
feature is missing. Maybe a pr_debug()? Want to avoid unnecessary
escalations and bug reports.

Sohil


