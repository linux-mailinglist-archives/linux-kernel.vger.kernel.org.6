Return-Path: <linux-kernel+bounces-408433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71D69C7ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4695F1F22F28
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC7B18C90F;
	Wed, 13 Nov 2024 23:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMCmBMd9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EEE15B97D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731540944; cv=fail; b=ib205swC4yMMKAw5uvCviDxlfdlEvYZLZ4gURpkZJDCSYP/9wxFDd6L45szy7rhwHe3q0zqGTgfqVXh2LgaBiqREq7h4cExwYOhnYwhAVUn/xCiY1u2Z6T85vz9Pkcza/J9IWPgndxSmBsX9W05oMRAc8ijCWEdrid054uByzAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731540944; c=relaxed/simple;
	bh=Ngx7metoc1G/hpdmca+DQQ/8PcmK3ychsPznzWeRV4o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NEC9vWtZPuyQLnwNH7Xm4f7Jy3QMUqfkiCIWyXNNNgUkxF67RJ9rChVq7/i/DnycQX7ZZVyVfk7SD3JEsJA05z6V0aQw3AtXOKbrj9KA2lHCKpoyWPHyPTeVt/VBJA1xJUaSuToxH2xx2afP0qCpdJzrv7pXLs/8VICMTu5raeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FMCmBMd9; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731540943; x=1763076943;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ngx7metoc1G/hpdmca+DQQ/8PcmK3ychsPznzWeRV4o=;
  b=FMCmBMd9bltSRUscczg7O9cktJVAvHCFGMDXo3Ms174Q6YhPWgnrqOoQ
   DptLF3ml4NtLGiIV1o0iLpKhehkB/KTVM0objGJZDo1pK9Fd7G8s3jhvm
   61X7u4GjSKS3d+CNBOBe1lsT/NCovfuT71qXnmlWDygY6d7/GYH5F2Zwb
   XUobA8mJ2+XR8+f4BUEsVX4nktDGZdYROt5HXeDf/WbCXiaAbP7hjPwyi
   krrG7+tSZN8bM1DQqc2klr7XNaVNeohOcDRR5dWM2GsyqzSD/VvM3q4/t
   UgU4qk1RXGL9+r2VcqOgP/BQA5UQBEYPfvOBFxMMrr1yR1wk3YQDXmNa2
   A==;
X-CSE-ConnectionGUID: nij4bWZUSb+COvs9+fRL9Q==
X-CSE-MsgGUID: Ijccs3atT0aU0heEW7XSgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="35168269"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="35168269"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 15:35:42 -0800
X-CSE-ConnectionGUID: 0CBO1nNiTAmZewk5IdpMhw==
X-CSE-MsgGUID: tEaaFQtySpWu+sJu/RgfFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="87782877"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 15:35:42 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 15:35:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 15:35:41 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 15:35:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b513RJDm/kOWdBLhVwA446tGSP7n6Y4AfHU2pRFSiu9Nf2P5KpXDuda0UM/Z0jOpHn2v4xybAhgsQAT9DfJWvq21Tz268hJ4Jaml+WOuVjpL4CdqW3Q21RQ5Wm0lkuXWoDkZePom4MH8Bmcz9D+ae201T+SyQXFChrKBJ+fXkUDt9GPYI0i84JyIk1wkozUJP1vyebO7eGFnFHc7TcRt5VCsitYKkyN8AFUKkvrcNnUjP3TncXUo/BCNcTRLpdVxU0/fl/i7p6F519pImomeScuIsds/uFcqZKGYgeaHuDzqQA7ARQKCjEyTpnp+Z9nCqemy9ievycK0WF+yGnsH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITAJ6E0tLbc9+rHNQl+bXrgnDKGW9cG+KEfQMNiYg9c=;
 b=dqj4d9xcMCzbL9Zl+K8mxpzGR5m+6v2oDKHIseVV7KM7Xc7T6aIEdUhKhbYkRraM/oxqEqNu0ANX42G5m6zHoyJoWtx8LnlWi4MT07uFJzxIFudSMJlvYQm3BXpt9T7IYHdLFSdSSjdmUyTl++pr9D/fPGzO2L4by9u2k7lmzbgeiFbnux3OiLi6PxCdHdNc4w21F0hyHc7raqy6UFfYN9ISA9cQ8In6+ZT3Lxc7Q8YABUzjpFKgbFWuag8LNpQcvuFGnysw+yBDQft7u56DEK269KVD1bUrcpV5xem/1pMk0ghWqWYRP0VS75hpZicbiX/TanNpEu39/ZHuCP1hXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH8PR11MB8260.namprd11.prod.outlook.com (2603:10b6:510:1c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 23:35:37 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 23:35:37 +0000
Message-ID: <0075eb07-c172-45d0-836e-b1d1a2abe56c@intel.com>
Date: Thu, 14 Nov 2024 12:35:30 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/9] TDX host: metadata reading tweaks and bug fixes
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Williams, Dan J" <dan.j.williams@intel.com>
CC: "nik.borisov@suse.com" <nik.borisov@suse.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Yamahata,
 Isaku" <isaku.yamahata@intel.com>
References: <cover.1731498635.git.kai.huang@intel.com>
 <1e00cac3164ea0f20ba2cd68e3f4790c6f1da091.camel@intel.com>
 <45a8ac0d-9f79-405a-80a4-40f5886c3bde@intel.com>
 <e5ebcab0d1104765ced1fafebf737b7c311593a3.camel@intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <e5ebcab0d1104765ced1fafebf737b7c311593a3.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::47) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|PH8PR11MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d145058-2b88-4829-fa77-08dd043be0b5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXMyTUlUaGs0T2VmSm1oZXFuSHY0SnV2VlphaWtSWWlHV29GZVR6eVVjL3dF?=
 =?utf-8?B?eUk3ZWJHc3htbXkxSkx2NEU2NG5aMERoOE1zUDdMSkZQdFVmS0FlcG43QmpQ?=
 =?utf-8?B?QUwrZWFheU9EMEMwdzQ2MytCSDQzaEVkSThVb0pLSm84b05meUhHeTRuYjJM?=
 =?utf-8?B?ZDJIM1RQR2UzNENoc0NyUWcycUtwNzhBRnNKN0lNaWFhajFzaWNIZ0p0ZStS?=
 =?utf-8?B?Zm1xNHd3VUVDcVV5a0Rmd3o4MXdNR2tkYWZPL2dPTmdFb01iUG1KNlJVUG1J?=
 =?utf-8?B?c21UME9CdGdxY0tKQi9YRnJ6V204QnhudDYzdGgzZWU4aWJuRjFWM2MxZDEy?=
 =?utf-8?B?cTNxWmRjdnN4WjU2K0c3QVhYaVUyU25CS2xuUGRTR0huRW9aT0s4VHZQc3Nz?=
 =?utf-8?B?aTlla0dML2pqelFNa0ZMS3E4MzJuN0ZzREdBOGVyeXpVeVBjcTNzamh5M0hs?=
 =?utf-8?B?MnJKUDI0NUswUit2VHJqbmUwNFZoRVZ3ZEw5YTE3akxNT0VUd21nZEF0T1lW?=
 =?utf-8?B?Y2xQaktleXQzRnVKc1ZjY3JTV0FsaUluTURienhDWG9ua1Erbm5ZblhiOTBT?=
 =?utf-8?B?eittK3RkTEE4eVNZVWZ0bUlUMFNWS1ZnRFpXdnhETVFmUytqS3JEMXZ3dU5u?=
 =?utf-8?B?ajhJNWxJTmJ0c1BwbXVNaVhNYUdtRkV0QjR0MUEyRVNqM3BLS0VHU1ZDaFR1?=
 =?utf-8?B?dGhPRXpoZ21HN0NyMWVHTFc1OTJIWUd5M3dxU3F4andXcFAvdHhzemtsSFJX?=
 =?utf-8?B?ZEc5SndtZVRFZTlPcGtrRHcxVnloRUk1UHdDWC9DSUc0dlQ4SWlkVVdxdWln?=
 =?utf-8?B?WmQ0a3lFRVMvRXMxN2t0M0FoaVZYcVM2eG9SMDFwUEhRKzZVQTV2Z2g1dTNP?=
 =?utf-8?B?L0Q2Z29qTjlrTWRWYTgvTGE0eWpPUXVuOGtwS2k4OVE4RWxqY0pTRzgzbGFG?=
 =?utf-8?B?Y0xnbjRHNU9VWmkvS3BVV0xLUmw5M2tFeGs0YlN2R0Npby9TVlMzRnpwUG4y?=
 =?utf-8?B?ajZRdTRJczBhTUt4UWJ1M0FBRUI5TmRYOC9YblNDU1hkV0NDSXNuM09ybml1?=
 =?utf-8?B?bDA3cGN1QlpySG1yMHF5UzdnU1E3dGk3aUJRZXFFSVYxcWhPWnhWckRTUjM2?=
 =?utf-8?B?YnhxbUw1NTlmTERVeVRiWC9IbHVaQUFIYTlHaHRBVkxDK3BneFdZUzdGWVVT?=
 =?utf-8?B?T25wM1BrMUROUXc5ejhwTkxZOUpONjdMRDNyY3RrblY3RDBJc3NqZUpnK1dB?=
 =?utf-8?B?TjBqRVBoYU5uRnNMZWFBZmF0SmpMYklQK2dFNmx1UVVYOW5sUitaeVhNUGJM?=
 =?utf-8?B?SVBOOUwxYkdoaUdMM0VMRkxvR1p5NnVoTzhYZHhZMWNBTXNCclVIdGwwZlpE?=
 =?utf-8?B?a2JxbW81MHZ5bWwrUW01Vm5iVzRQUTJHQUsxNUk4ejYvejhNWUhJMnZheVlv?=
 =?utf-8?B?am9aaEpEd3p0TTh1VmxjRnRGTFl2aEIxUXBuUUxZMEFQcDAzb3ZMS2lGVi9P?=
 =?utf-8?B?QnRxMXVIdFpoTDFlejhaSnhMcFZ3emdONXlDQ2RkS1JqOUNnU3Qrd2QyVGtU?=
 =?utf-8?B?R2xZbUt0Zk9OcXB2eUU3WWx6NEhmQ2RoOFlXSDBRNVpVdmNGNjR3NUs5SzJS?=
 =?utf-8?B?OWh1TVFIZDArbmNaajZnR1kyVnI2dDhuaW5GenhNQitGWXkwdVU1V3JiWkpv?=
 =?utf-8?B?Q0JtRE5sbXkzSlRUZlBBYVdQQVJ4VUg4bUtsSVN1dm5kNVdvSXI2dzYvSjNC?=
 =?utf-8?B?Qlp5djhjYTVya2Z1OHlJRG1LeVc0WDhMdERoZWVGNVlXdDNWQmg5TC91M3NC?=
 =?utf-8?Q?Ira9FnsSYz4G7xE7WibhZl/H1Tw7PmaaZc9NA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUI5N1orS1JHSSt5UHA4eHV6UlJTeFlHNnFpSXp3TWcwNmIxdjYzbzltK2lK?=
 =?utf-8?B?eGs1M29EaUkxTG45NkIvSU1BYTdoYU00MUZtbHVja1ozblhaaGNGeFdNcDlB?=
 =?utf-8?B?SGNwWHJhRTFsclZCRDYrNXdtWEVHVzVTY2k3Yzc2MG83SGw1SG9uTCtMRjhH?=
 =?utf-8?B?b1c5NC9VZkdZZFpGeWRNSEpQNFBEeEVxbHM3UGxONGZCdDJBTCtsY2xNOEpM?=
 =?utf-8?B?am1UVzVobXN6Q3J6LzVnTkFUN2NLTzl2MDZ3TkRpNTNwOGlUWWRDM252Nmh6?=
 =?utf-8?B?VU5oNXUxaWptMkhiQXhKazVBeHVGUnlleFlyNmp0ekl3b1hwTm8xRm1PU2VV?=
 =?utf-8?B?L2M4ZEcwemJXYnhZM1B4QUUzK2kvK1hxYWVYTTRYdGFseGl3ZnRmVzc5bG13?=
 =?utf-8?B?d1pTUTJON01HMXhCQndIbzZHU3VSWENaTFdlTWg0ZERxMFBCQUw0Q1FKNGE2?=
 =?utf-8?B?M1luZVJGWkp1eDRLdkw4OU9TcDJJQ0RLZTJsT3prNS93RTdjOUNWdG9vU2xI?=
 =?utf-8?B?QkxWU21vTG1DNTJMbkFBem1CWXlvTi9YQUNKYmVsemtZYWliK0NZSEZxMGNx?=
 =?utf-8?B?cEpnUVc1RFdPTVJ3QUYvMWs1SFAxdE5KNjhJWXJvZVFiSDNTSXNnVmFCU2xT?=
 =?utf-8?B?cDQ3MXYvNHBNQ2NyY2tHMTBtQk5mdTF3NDdGN1ZyeGR6ZW5yMXNadHQwdXRk?=
 =?utf-8?B?L0tQRzBnUzdPWkJXY2V6T3V1UlZYYkt4Nm5sNzRJYXl1NzhaUDFIdDhXa0gr?=
 =?utf-8?B?K3dVYW1aazNpbGVsVjI4ZitpbGJaTVUxc0pWbjZPUHhPbTNEQXBtcUlsRFg1?=
 =?utf-8?B?MG1zME9lcGZRZmIvdnc5WTY2V0ZWcDBZU0swbFhUZTFoQkR2WEF2VEM4TWd0?=
 =?utf-8?B?T2NyWTFGUkRzNzQ5VTV4ZGdUQnNvek1SelVOV3A5VnBCODN6WVVTQWVCMGNM?=
 =?utf-8?B?ZEFoSnAvSFBLeWRMc2tTWHV3eHNNMGpOa2NDL0VhRE5rUEN1M1NSRHNzSjBY?=
 =?utf-8?B?UERQM0pjT2drMzg1NVdaNmFvM0NFckFDQVU0NDNKaFhhcE5YMDlCRVVoSDlC?=
 =?utf-8?B?YTdXSkZLN0xDQVVvdFFqTFF1N0pmVjlweExvMDRPWmFXckJSQlJ3S3E5OTlQ?=
 =?utf-8?B?N0M3cytUdVpITlU2cldFSkhYK0Q0akl2ejJVeW1jalY1TG9wYXYxNzFmbk1X?=
 =?utf-8?B?QktBR0pqQmdvWjFneDMvRk5BdmJsL0EzOWpTV21lalQra1NBNEpCaWRvQmF6?=
 =?utf-8?B?QXZiQ3pCalNhemNHd3lXekVtN3Y3Sk84dmx6TjFPa2c4VE1pS05sZlVQa1dM?=
 =?utf-8?B?ZmdGcktiSC9OdS9FRnJGUDByMDdUVjAxVGdSaGFZazkvdnN6TTRwd2lZMTA1?=
 =?utf-8?B?dk40L3MyUWNnck5xWDdONW1acTBMUllHRXMxcFhobUl1SWdiWndJY29NS21O?=
 =?utf-8?B?V25rbityNFBPZStNRnc2N003THBqWE5wVStpZWxTU2hwSU5MRHZNRUxEeVZZ?=
 =?utf-8?B?MVlzNUlrMStMYUlXZzFQSmE3K1hSWStOOG5XSXJmc0RYMVpDV01QQW9ibmdD?=
 =?utf-8?B?aGRKK2dEU2NDZFZodWllNGwyTGszNGQvSTIxbXV2bzQ5QUsrNEtGaExDOEFD?=
 =?utf-8?B?REtuTGJOZ2UvQzQ2ZVlBdzR1M244QXFZM3I4WGk2d0FSN21mMDUrNFQyaWpJ?=
 =?utf-8?B?MTJEQUN2SWtFNy9xblBEYnkyQ0xWM2ZQUWV0TXhtWjZvaEl3ZFUvS2U5V01k?=
 =?utf-8?B?QWEzSUFjZGwxMzFTTThKbVcxYUxidmVlRStFSkpkY09YRWlMTnoyb0tCRy9Q?=
 =?utf-8?B?eFZ0VjJZZnZYZVFQbUZDekhicWF5VGJId1lXOFByTEU2NGU4VkxXYnBtaHo1?=
 =?utf-8?B?TC9DY3JFVjdPeWRYWXVQeVkvQTR0V29OdzVhQ0FNZnJvZkIrQytHVG9RWU1k?=
 =?utf-8?B?TWgwRnNyUjc3RkEyaitnbFREN2JPMUs1cVJzZEF6ZzhyU2s4Y1hlcTI3dnJz?=
 =?utf-8?B?dWtHWXZOYm9GWTFwVzBrbExnWi8yZVp3cHc3K2FsS2pmUmJLR1R1eG1FWWk1?=
 =?utf-8?B?d2NuVnFEWEFrVkdsK0Q2aVJYVmh6eWJwSW5MTmpjYVdSS3Z1ZVZTSW1KMzNS?=
 =?utf-8?Q?WzHnF9oInkbr+i4lZJ+yj8G/E?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d145058-2b88-4829-fa77-08dd043be0b5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 23:35:37.7854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1PGAf5Y/DM3+rca8kvsSr8fGqVTgQm09n93mf8ph+fZeBgWbY6sBOwil0F9VJQS86yeIQWpss/JGZ2hiqaz2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8260
X-OriginatorOrg: intel.com



On 14/11/2024 11:53 am, Edgecombe, Rick P wrote:
> On Thu, 2024-11-14 at 11:40 +1300, Huang, Kai wrote:
>>> So I think it is not part of the "bare minimum". I don't have any objection
>>> with
>>> it going upstream with rest of this series if it doesn't delay it. But I
>>> want to
>>> make sure we don't have any more confusion that will cause further delays.
>>
>> We have two issues that need to be addressed.  Addressing them could
>> bring the infrastructure that is needed for KVM TDX as well, so this is
>> the "minimal code" given the goal I want to achieve here.
> 
> I'm confused by this. "could bring the infrastructure"? What is the "goal I want
> to achieve"?

The goal is mentioned in beginning of the cover letter:

1) address two issues in the current TDX module initialization code, and
2) have an extendable infrastructure which is super easy to read more
    metadata and share with KVM for KVM TDX support (and other kernel
    components for TDX Connect in the future).

> 
> Let me ask it another way, if we drop patches 7 and 8 and pushed them in a later
> series. (say after TDX gets upstream for the sake of this question, but I'm not
> suggesting a schedule). Then what is the consequence to the goal of booting a TD
> on some HW?

The patch to fix the bug is not a dependency of KVM TDX, but it is a 
real issue.  Customers have reported this issue, requested the fix and 
integrated the fix to their environment while we are still in middle of 
upstreaming KVM TDX.

So I don't see anything wrong to include it here.  It also gives us an 
additional user of the new metadata infrastructure.

> 
> I'm not questioning that the patches are in order, or that they should be fixed
> urgently. I'm just trying to make sure we are clear to Dave on why this is all
> needed.

Yeah I'll certainly follow Dave's request.

