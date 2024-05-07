Return-Path: <linux-kernel+bounces-172151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D028BEE25
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2488FB20CD2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A578B663;
	Tue,  7 May 2024 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="idgWoAOp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C607E8;
	Tue,  7 May 2024 20:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715113938; cv=fail; b=h1Y2rfL3GxqoJ8Q27uaY+uBM/J7Jm7YaeSIR+Ec9QaebzCrY/ZnS62NshNux7fWeA+sJxe0a654kH+1qBS8lBuXlXb4BQZJ0xrUW529hFzrDsPJaQbq6KgqA52v5HeJP+yHh7nyhXpcwv/tjNuF09jElqNG6BKBo+p22m5ErbnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715113938; c=relaxed/simple;
	bh=9Fu/KXu0zSu/SywzJI710JMSR6J943O2WzaUUNNdqn8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gz+uKjESVCzhRsX71T1cAPZReBK1utbv9npAQF9sB3RBHT3w++nXxpmgvn8jrI4U/2LoZM6rBpZUoR3GrBZipqrVW7OQGP25SPrkP5cVrX/eWojC5b2njYHMkuAYQvEIdHXawmuj0mQ8ZozBvxcMHt0fdN4Lp3r29SYbelKEp7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=idgWoAOp; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715113937; x=1746649937;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9Fu/KXu0zSu/SywzJI710JMSR6J943O2WzaUUNNdqn8=;
  b=idgWoAOphWmROhXSxKsnjyVgZHPPRRhlO4mAW5xF8VAA0KHEK49cnyHg
   IrZjr9DpWwi5N+RQCm+96ICGtafGzYVmt8hjUw/wR8IjykeNHSmakY8WC
   6hxSk0Vd+o4Vom/FeNTqG318RSjpOKEcuUvWOma1gp011bUnl94OG7uEv
   15Omlpw2lj99Lak/D+O1LHEfVDGhQeSCdA9vKtLyGCQKlJUhZYJJBO72Q
   OmhPUTxgi5jzG7mqu5OgZT9E8wVkjHQ/MaXnTWLtDbh2waWxglpLR1TO/
   MNpkxBJ6Mh6HjpQHvcwLJoqcPFZylcYnMmw6f7yoBZIijwTJqnHS67SKt
   g==;
X-CSE-ConnectionGUID: We76DEUAQDiEuU7iplO6jQ==
X-CSE-MsgGUID: 7xiR7JLYQrOo6cTxibQE5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="14729589"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="14729589"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 13:32:16 -0700
X-CSE-ConnectionGUID: CrZq8GwYRiuQayVQb0Dy4Q==
X-CSE-MsgGUID: pm2IeMBcTKGpTVdqK9h0nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="59804674"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 13:32:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 13:32:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 13:32:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 13:32:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 13:32:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzn+sI+GChE9tmIwktRgedXrIlY5XdV58THtuWHHu+2x/tMovVi3ipbK5m2e0uDp3qJVSiBvSerWTiv1BQVwTACf6oqvT9gWuMGaX52tdHilh9kxUxgmfurjlFAhJeVj0sU7wyNSRdO2+tZKYW/8qFXPf1e6lg+HiuHE9iarnaQFciIZJYd5Hv6xUBgM1iHoScMXRyLU+QkGZ0LtdZYa5kmEl67ATcZWtydsYRXv32ahq7V6YFaK6bR7kN82R6si2BY+EMWXjBs94wH+nIldnrJxobcdzxZjdnXJ244erbcdEMVPd0dYuQVIcSVTcqxnAD4jPL88yhHyUZ3bXfWW9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xzk2tK8al0XwaEPOf9foHfCdzfuhNBRoPZOaPtSL6h8=;
 b=A4pL55Vv+MEb94dtnFhor/W8TknQZEL7mbk75dBanpJ0GP38u0/FpVQ3/ktRdj7D9WPQKJl9l9PkQtR2BWbjRqgAYM7xIvKOxWdicM81Xh9+lS4sKqh9rW6RIGrclsd7F7XllfDMg6ebqoMPxwlJerm4viLanySYABlpHgXQtr7GNFvJ0PdFeoRwJLQF4Y8AmM1sNi7Npq26rrew2WCO+Tq/Q/wAoNo3BN0Kdtk4w2Fbvro73oITUyP+tAz625Tlvhqh/fXkwKVtog3CQFjt6dJbNOmK1c5ydd7EGwdbpDsDd6rKM5UPzAaCETWUz4X3EbER1hW+A9WtqHuMgAth/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW3PR11MB4618.namprd11.prod.outlook.com (2603:10b6:303:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 20:32:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Tue, 7 May 2024
 20:32:12 +0000
Message-ID: <4bcb0c46-458a-4ce9-a184-d3054a6ee26e@intel.com>
Date: Tue, 7 May 2024 13:32:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/17] x86/resctrl: Introduce the interface to
 display the assignment state
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
 <e50e1e55c2ef4f5e1609960e573b30a125a59e5c.1711674410.git.babu.moger@amd.com>
 <9fd1c700-fa24-4290-aa77-a6eda9758ace@intel.com>
 <086a6c59-f617-4714-b91a-2b1deae8e33e@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <086a6c59-f617-4714-b91a-2b1deae8e33e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0068.namprd16.prod.outlook.com
 (2603:10b6:907:1::45) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW3PR11MB4618:EE_
X-MS-Office365-Filtering-Correlation-Id: 4577021e-c460-4e88-6d9a-08dc6ed4c654
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bU5CZllGNERUWUsydUNSUE9qajEwQ1JNQS9vRmxtaXA2RW9iNUk3UnYxdkdP?=
 =?utf-8?B?aFJpN2kxWE1FUXFubG44QXRMMkRnRldTUkpHUGxxWHp0K04vVzBndWxrK29B?=
 =?utf-8?B?bk1WaHl5WDlYay9lSDFYWk1QM0xPbFlWQlZySnkwK1J5bGQ5SmovTERXcHcr?=
 =?utf-8?B?MVNyaU8wUlVRRUlRZFNmbGZoT3o2Z3VITDNZdndPdmhiRitzUlByVVkxYWU0?=
 =?utf-8?B?QmU3am40T2p3R3J2Y2g2YkZuL0JqNkxuT0lKWDI2WVhsK29FM2tJVEVtZDV1?=
 =?utf-8?B?UHJMRXU3Q0xsTTZVRkhHOXF0VEFUNGVZZWNETWNkRXJ1MEEvRTh6aGJTZGdS?=
 =?utf-8?B?VW11aHZiSnppbzhPd1FONkE0T3hXd3VhUmhpWWRDbG9pVDJPamZvOUgxVGt2?=
 =?utf-8?B?QzFRbDlqQTRKUXpGTFkvbWhwcFlsbXE1RndjY1FtaytZc3F2VWQ4aFRwNEh3?=
 =?utf-8?B?czJmc2NzNzU3bzJTN29CdFVQbnc1T2ZJQTZ2cVNaVUl3YVplRzRlMGx1N1JC?=
 =?utf-8?B?UE1sSEhiQmtFdC9xVXpJN1prYWVuMmdOVW8vZGtDZFI1cTRqNzJWUHhjeS9O?=
 =?utf-8?B?NFlZT3U5UnhoQlcrWDk4cFkrK3U0Y3RqNTMxTjE4MHV4V2VjOWNBbE1ZR290?=
 =?utf-8?B?c042Znp4cWJMU3VWZ2hlM08vWjBHVTJ3d2xtako4NkN4Zy9GT1h3VTRHN21R?=
 =?utf-8?B?aCtFeUJmS3BWVDFZWkUxWVhEZ3hPOWNrdEpBcXVsN1BUZUx5NDY5Vm1xNEZt?=
 =?utf-8?B?NkZKVEhCbVBRMWhVRkY1ZjNrcThSWS92U1pMb0kzRE0zRjlkRVMrVGw1d0Vw?=
 =?utf-8?B?TGl0Q3RYZFdSOVBqWCsvMlE5aUFWNTlOQlZFQ0h0eklmNEw3blhJc01QWUVX?=
 =?utf-8?B?dzdYS3pDcldCNmhheVFabVBSNW1XcHVwWkZOTGVTa0VGQWpXWGI1aFZIcHo3?=
 =?utf-8?B?MWtLR2Q0a0NDcEdQUzdSMGdlbkhPVGwzeEVFZkxjYm1rRnArak5rVEU2Zkdh?=
 =?utf-8?B?TkN4R1R4MVdTTnFNUDZLU1pwWUp5RVVEc3c3TTUrL3NjclJvK1RjQnRBWjdw?=
 =?utf-8?B?cythOVpMOHJtNzQyaUFaeHo4YXlWRGREQkRqZ3NITWNmTXFHVndrbDlveTVW?=
 =?utf-8?B?WUlVVjE0a1dzcUVtNzlBd2EwdVY0dktjTFJ0MEpZWnd0VnVHNU1TVnM4OXpG?=
 =?utf-8?B?V0ZHNXNHd0t2Rk5kbjZaaUlqRnZ5d0NTRWJQRE1sMG5iOURxKzJjTEM4Zktn?=
 =?utf-8?B?UG84cEEwLzh6S1VuaXlNYVAyTHdQZ0FoUG8zNDJOSlJ0U2NSNEJQNkJHUXd1?=
 =?utf-8?B?VlpQQVhtdmpSY3k1WXc2TG4yeWZVUkNrQmFXVjErYnRDUkJmNGFraml2Q3pK?=
 =?utf-8?B?NXoyU1VSUGY3eHoxT3Zqcm1PNzhuWUVyTXREL0N4b015QUc5bHZMVlFRUE1Y?=
 =?utf-8?B?T1ZnK2RCcmNGQ0I4YTNBakhYOW5kSUZ6Y3l2Q0lhYzZoOENQQm82VmtQMUtN?=
 =?utf-8?B?eVRUODJ2b3Z0UXUyblIwdmtvdHJkcXVMQ2VZRlVDU1BJSVBxU0ptVG84cENp?=
 =?utf-8?B?QnJZT2FYbzV1VERsQk82OHR4S0RPVUM2YnptazJWZ1lFaVVaZS9SNmlNL0oz?=
 =?utf-8?Q?cyeMN1Zu8lvH+SeUhs+8Uiva6KrO87LRfMFG/9mTxJCY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1FiT0VPVlROQ05RSUNJbUEvUHVrUnJHSmlhcDJZV1NwMTh5dTgyT1hnVkdt?=
 =?utf-8?B?KytyeXhQdTdqbTVTWFBoYmRmbXJVaVliS0VVSHluczFRbm9wNFJwcFRNQVNq?=
 =?utf-8?B?ZStmaXVyb3BEZisxbHd0QUtOUW9YaENMVVg1cWxnUUpqb2VZaGE5bHFDYnFX?=
 =?utf-8?B?ajl2cnBDd084NE5XSVdFN2JUOW9JSlkwSlhqVlRZc1h6TFZiM1dWQVhsR0lI?=
 =?utf-8?B?VHUyM0NLemw0UFdTaS9VV3NTZ3FmMzVYdzRCK1Z2YktYWHZPUE1vNk1KK0x1?=
 =?utf-8?B?UDVrd3dibCtGYmlHNjdCUUJYVi9US0lVU1JxWk12WkpTMXNiTUQxZ09pdE1L?=
 =?utf-8?B?YjFwaUh1SU9SeFF2SjR4QmRUTUpVbmpVZzcxMU1mUDR4b0NtUzFSc2taNUdz?=
 =?utf-8?B?SU5URERJL05DSUd6RW9aS3BHQVJmMHg4N1ZwMGlab0ZJYjk4cmt0K1k3dmcr?=
 =?utf-8?B?d0xNcGNGQUl4UDNZTE5EQitOWDFUSUxoK29QS2RONWNKcXpxM0cwb2F1dGR2?=
 =?utf-8?B?dGVPVkVJTWZYZVFXcWxEcnpnZnhsYTZzQnoranlPL2VUajZwOVVrTDFJOXBq?=
 =?utf-8?B?cjBGOUpOZkpGWklaYzBKNVZORlY3WmZQTEZzYUpFeG40MXU2ek1uZUpsNVJJ?=
 =?utf-8?B?cCtQS1hSUW1WV3E0MGI3Z1J5bFdQZUpCQ2Z5UHFuRWZzMnRGMVRudFNqSlBT?=
 =?utf-8?B?QWlQa0tGMnFRMnNwQWRZakVrTmdjL09seTZVZWJLcWZldFV2NEZpT1A5QWVQ?=
 =?utf-8?B?VHM0VDNsUU9nK3l2dDFBRlovYVgzM2ZUSUlLUmI5UFpIYjM0dEsyeFVpOXBN?=
 =?utf-8?B?RWJmcjNRNUl2eDhhaUowNzcrSkRTTUFKck8wRCs4UFpic3RaU2RuQ0w1RzJG?=
 =?utf-8?B?Tmd3THBXeGZ1VVZvM0gzZGh1ZElMVTlqRkJ4ek16emQxWlh6VUxnNDVGVWF6?=
 =?utf-8?B?S3kyUG5UTmEwNjd1SEN1b1I3YlM0U3JkQVZnVU0rTy9LMlhvMFVxTVo5My9C?=
 =?utf-8?B?RS9ZUjFtOFVYMll0cjRUTjhSdk5NUWo4SFN3VXdQczAxSS8vQUVabUlFcCtp?=
 =?utf-8?B?SU1hWFJtSWMzVDArNXBnTlp6Ri9qcXorOTVWTW9KNU1FSi9OMWVGYzFvUjBp?=
 =?utf-8?B?Uis5M05ENHZMc2p6VTJxY09GNGJjN3pidTZ5ZnJEanpBQ0xNcEZ2L1pvUTg5?=
 =?utf-8?B?MkVvSTVNclVmM21ZTysyR3dsbjdTYU5OMFRycG5jN3NLeEJBMjhVUkJTdTlp?=
 =?utf-8?B?aVE5VkNmQXgzTHNRNXVCUnkyaCtVQkI0bkdtdTRQV2lCcmtjY3hteWxxazlW?=
 =?utf-8?B?VW1Xc3FGdnpCR0JqekFIaGZ2dTRoZmF1OExrWmlxSUVINlVXSjJjVC9QM2pU?=
 =?utf-8?B?R1FUNHYwblNhakIzNno1R0Z5MnpQdk4yS0RkUHBuRGFKQ01hd1laVk9qMExs?=
 =?utf-8?B?SUlQa3lKeGFlVGo3ZUhFdHlxcVpaTTNoM3pwY0NoQmtHb1g0aGZoN0gveXRX?=
 =?utf-8?B?YjZraURXbTZ3eW5jZEVGelpWVWVZb3NZdWhnSnNtZ0lUK2NEcE96S05QeW5v?=
 =?utf-8?B?NytNOW9RWnhmMGpoRU5ZVTFPc2FwT3hRNG10VFNnSy82clN2WnBlUUVEajN1?=
 =?utf-8?B?RDhzN1dHTnBxVEwxUG5pU2V3QmRVekV4ODR3aldMNU1zNVRESGsvUENaUzcr?=
 =?utf-8?B?OG9taXcxYzlnVVl4SFRKUnZXWlFOWmxHQ0tDUmdLNS93WVZRbWxnTlpwNTlO?=
 =?utf-8?B?MGZIK21jNWZQaURiNFk3azA5K25Pa01rT2F6TmNoRmlZU3NXdmMxTWFTSmEw?=
 =?utf-8?B?QlRiMmMzUDRtUWhzaGpBbmYySmRBQ1RpN3dHcWFQNEN0anRkTXdxWWZmK21o?=
 =?utf-8?B?VHBjSGYwQW54NFpDa3RYRWR3ZFVQTHk0ZWF2TmZmSmZtekNKeGpGWFdhdkM5?=
 =?utf-8?B?TXJFQXVYakx1ZVI5VXkzSDV4Yzd4WkxYS1JibysrQWE1bXU3NEp0T2QrV0NK?=
 =?utf-8?B?ckJ1Ny9RK1dXQlNSUzBUL1FsMW53cHV4ckk2ajd2VzJJdGVJSjJYU2dmbjRz?=
 =?utf-8?B?K2E2Z3ZNWEJLc2Nab0VYNTE1cmx6b0Mrdk9tYytsNmtWdStBbjlhQ3dOb2NQ?=
 =?utf-8?B?MWJHRmVvOGtPN1VrbEw1VzkxNTc2ZkViZWxHWEpuUTVnRFdaN3FCcWNuQzNk?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4577021e-c460-4e88-6d9a-08dc6ed4c654
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 20:32:12.0576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EsJ16WjVtj7plVqvx2nqzoL/Xsd5xTGFqm6fYH4G4pMajNvgILnS7QpQe7PasBNyjqxkZDhKTi9dcOrXmJ37B1tqtSEth/qYDNr4UeKciTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4618
X-OriginatorOrg: intel.com

Hi Babu,

On 5/7/2024 9:28 AM, Moger, Babu wrote:
> On 5/3/24 18:28, Reinette Chatre wrote:
>> On 3/28/2024 6:06 PM, Babu Moger wrote:

>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> index 735b449039c1..48d1957ea5a3 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> @@ -1058,8 +1058,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>>  						 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
>>>  		}
>>>  
>>> -		if (resctrl_arch_has_abmc(r))
>>> +		if (resctrl_arch_has_abmc(r)) {
>>>  			r->mbm_assign_capable = ABMC_ASSIGN;
>>> +			resctrl_file_fflags_init("mbm_assign", RFTYPE_MON_INFO);
>>
>> I think this will need some more thought when considering the fs/arch split.
>> The architecture can be expected to set r->mbm_assign_capable as above but
>> having the architecture meddle with the fs flags does not seem like the right
>> thing to do. I think that RFTYPE_MON_INFO may not be accessible to arch code
>> anyway.
> 
> It is accessible to both arch and fs code per latest code.
> https://lore.kernel.org/lkml/20240426150904.8854-33-Dave.Martin@arm.com/

v2 of MPAM was posted without completing discussion of v1 nor addressing
all feedback.

Please read discussions surrounding #3 and #30 of v1. Note in particular suggestion
in [1] to keep RF flags internal to FS code. 

If MPAM chooses to submit new versions without completing discussions then
I have no problem letting ABMC proceed to build on what is resctrl at this time
and adding this to the pile of things MPAM needs to address during fs/arch split.

Reinette

[1] https://lore.kernel.org/lkml/b2595743-c7dc-4946-884f-ff159bc4865e@intel.com/


