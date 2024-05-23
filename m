Return-Path: <linux-kernel+bounces-187469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108658CD244
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8411C2138E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8831013E032;
	Thu, 23 May 2024 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCbtFCYW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450381411F5
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467210; cv=fail; b=Mbh5VcXr4Fhii3IUbRWHMePid/2SdZabF0O98gA3K/Pr97XOJYK7QBrONhyzDhQFeqxehvxtOiU89ULcBGafrPAan9NxtRdIstEsjQsqP0z5lrtwuGwIsj9sBuNRuNt/FNHcdGjhvIvoEJaa8KWD7NOrQssiI9Q/ACz5cnrW7Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467210; c=relaxed/simple;
	bh=dHg3DkVo5ZF/liLc0sm+wIeUfqgF2qMMsxtvkY9IZgE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sN0VBY9Kxg8ttpq1mhPvr6o6+pQD+F175GHf7JejSuXzjFDhGoOyI3d7+seAG7QhzgDErryK01QVcvFJQuwxm2/3jh86xI+OWr0infwuZ+NSi9R/s4a1begdDIzXNgbAjCiVjprc8higBy/fipG7ZipVVHQxEljWLAoV5OuBo3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCbtFCYW; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716467209; x=1748003209;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=dHg3DkVo5ZF/liLc0sm+wIeUfqgF2qMMsxtvkY9IZgE=;
  b=PCbtFCYWCQy3xox5UGCIpAjZeHr3kHs6UagN986cs/6H4UDHMKPJtBjN
   GgO7xjzhO9UwMqnHA24+trebPraVv3WFvN8mpyisdeQXV01D9cDXWLIwv
   Y7V21hcixK9TwVXdPkkvHKHpI5ByZ1sCHuWQ7ssxij0ZWKma4JPssGNB+
   EavUGz4JW5YTMqWfHKIqhU8sgv5NqJlsuK0mf3UqzeZRyQm/aoRkxAfVE
   I9IFi7C57FhcdbIHmoQLNt1yWk1WcNE2tWyX4+/UooowtEYHkcZj2jXoI
   76GoBfuYEqqf08opF4db83kQV6HAce1FQWc1tCpG67yQTGKfCG3Pftq6o
   g==;
X-CSE-ConnectionGUID: ivUzkwTASUKD0uFerMLUMw==
X-CSE-MsgGUID: sOPOLROMRs6SYNB3NnqqcA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12896379"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="diff'?scan'208";a="12896379"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 05:26:47 -0700
X-CSE-ConnectionGUID: Gvg6tRQaSBaDElFkeIVwXw==
X-CSE-MsgGUID: YV/aD8GORYqM02vf2bPJKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="diff'?scan'208";a="33635940"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 05:26:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 05:26:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 05:26:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 05:26:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 05:26:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhKtReNCqMORaue24kBpb/QGJJtc3jRd56MWAwnli9UHCAghxwgdOfQuWUzUyZIbJgoMf1EjIa5q700TnEDuKulRIMiQFee28fkC9oJe6dmMmqKcP/MNaA2L/gj3X47fWVzPkzn6mwYzt0y+vGvW+FFDBOiGe+WfJvNLQRqtmDOmSYQ+Xsm3jmig37g6UQebRe8PsljojWzcHMKagy5qjQD6jaiXN9OYPcnO2NooQ8M9WuGnYfXXDYb1TgESIEgBeOgrLtUSOTFvkHX1YF73z4gGwHA5z11piVhtHDRdky+yySV327JHs7CqcwfN/H4Eeu1/rrL8AlTFoXjTrIirMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Z/Tctf6c9Zw1fKOV4UOnMyXqHcyQ2WeMQQSrm8j3pE=;
 b=Q43ZtlVbk78jtezJSPw5npRcPXMmBWD0WOIpdpCwXMd7EIAHf9+S5rkgm1ACS6Dt57aOccTIC26tlePodr0cgFGDxinbnLT1liM3vi5Z6Z62S0iYryRosd978W8U4FSSTFZpLksSfy4V2vYwG8ZzmN95AW32x2fbr9hzUkIiV2+Vju2ZBHSVYc0K44GkrPRQwuGD0H/42zxPqOVokQhrKz15GZOwMYE8cuNlyzbLmsEnbfQWxPXN4iJduCC/tKq/MEZLcnHHicE+UgC6tohI+r7Tm3us9G0nGnjodE9Ya8R21jau6httsEbCCc/t7ncuL08APAEQyrHBUzAVccXjew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB6447.namprd11.prod.outlook.com (2603:10b6:8:c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 12:26:44 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 12:26:43 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"jgross@suse.com" <jgross@suse.com>, "Hansen, Dave" <dave.hansen@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
Thread-Topic: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
Thread-Index: AQHaqFPdLMzPjSCDnUWFW5WKWhmq5rGbczCAgAADa4CAAAjjgIAAAV6AgAAI3oCAAAMfgIAABI8AgAABLYCAAAEwAIAAAZCAgAAOJYCABGSsAIAEUyeAgABMcYCAACCHAA==
Date: Thu, 23 May 2024 12:26:43 +0000
Message-ID: <a9bbb31e6660343e95d3351febc6e3b9661a7944.camel@intel.com>
References: <20240517121450.20420-1-jgross@suse.com>
	 <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>
	 <f63e1217-3dbe-458d-8c14-7880811d30ba@suse.com>
	 <2a2guben2ysyeb43rzg6zelzpa57o24ufai3mi6ocewwvgu63l@c7dle47q7hzw>
	 <03d27b6a-be96-44d7-b4ea-aa00ccab4cc5@suse.com>
	 <fc0e8ab7-86d4-4428-be31-82e1ece6dd21@intel.com>
	 <c0067319-2653-4cbd-8fee-1ccf21b1e646@suse.com>
	 <6df4fb48-9947-46ec-af5a-66fa06d6a83b@intel.com>
	 <86ca805d-7ed7-47dd-8228-5e19fbade53f@suse.com>
	 <f7edef9c-5eb5-4664-a193-3bb063674742@intel.com>
	 <f02d9ebb-a2b3-4cb3-871b-34324d374d01@suse.com>
	 <4b3adb59-50ea-419e-ad02-e19e8ca20dee@intel.com>
	 <c7319c0614c9a644fa1f9b349bf654834b615543.camel@intel.com>
	 <e2d844ad-182a-4fc0-a06a-d609c9cbef74@suse.com>
	 <2e07ebc774bf176ebfab40e6ba8bc14ae6a94e0c.camel@intel.com>
In-Reply-To: <2e07ebc774bf176ebfab40e6ba8bc14ae6a94e0c.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB6447:EE_
x-ms-office365-filtering-correlation-id: f07a2532-8a09-4fb2-efbb-08dc7b239b0f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RnRLOStSUDJPUDdUbmM3NTFuNFh6MHM4bGh1YkEwNEp0OVRxSUJmNXNMSEty?=
 =?utf-8?B?OVBndUMvQk9zRkxVcmphMmd1VzFxY2ZXeDBVQ1FGMWZCWGJucHJpZis2ZTha?=
 =?utf-8?B?UW5ETlpSbkpaa0FzcXR2RXdkNS9oSk4vZnVpMk5qYTU0N0p5djBqUis3eElE?=
 =?utf-8?B?amhiYXltUVNKam1WemVUY0l4eXlGTHVEamVJN0J1bGlSMVFzK0ZqbjdhVDht?=
 =?utf-8?B?YU1tOUtrcWlpWkRZT3ErQ3VmTFBuZktpeEdocFpMc3dYMVFYS1EvVysvMTB0?=
 =?utf-8?B?MHMxOG1TRnBPZnUyUE9OSmxuYy8wbFF2TVJMalZVOGZLWTRST2dLa2oxOTN0?=
 =?utf-8?B?TUg5S2pNeC81N2w4RG9ZZTJJd1JaZEZXUm8rTmtRaVh1VTh0cElnaEE5cTJR?=
 =?utf-8?B?UFhHUlJmVHhVNlRyc080THBTeHJWdWtCbjk2S0xvdGpqT2kyK24vN01sZTdY?=
 =?utf-8?B?YXZGeW5vZVpPY3MvbFloU3FWbGU2UlJjY2NiVVNXSGpvWTZRYWlGMHplTS9k?=
 =?utf-8?B?dVNvSkQ1aVVIT1FnMTQ3R2NxUnluWlhyZStudVVta2VLL3IzdFhoR1VWUkFi?=
 =?utf-8?B?NVNTQUNHS0IvNi9CZlVLMzU2aC9KcCtYbnpTMjFDVlh4aFVkTjZlWTVGZ1hp?=
 =?utf-8?B?NEVXNDFJVnFHbzhNV2Frek1uL1JkTHBVY2lhRS91MW9DYlg0cHcxMmViZGJO?=
 =?utf-8?B?M3dzczZXaFhZNE52NWx0VlhJaDNpaTRhc3h6NkhLL1ZkOUlNTUl4M3J2NGZP?=
 =?utf-8?B?bFYyamZzbU9Ca1laMGplaGFsTUxGdTRxK3pVVk5ZL1hMUWxwaEV0cUNlU0lu?=
 =?utf-8?B?ekJOb3ZHM0QxK0RZMm9VRmJ6RDdETXhuRDJvSm1kelA0OFd4a25JSGNVQjZT?=
 =?utf-8?B?MGl3QXFXczl3R2ZBREp6TWxjdkhiUk1lQmtHU2ZWUkJxSFMvRnNjNjJxYUlt?=
 =?utf-8?B?Um40OTJyRjlyWnNpN1UzbVY5NUJvSlBVS3l5NHpQU0R3VUNoSjVhMXBxSHk3?=
 =?utf-8?B?NE5WL092ZEZ0bFAvZnhuRmpzeWJRVTllblZxTFNESkhwZWdwNENNb3lXSkpN?=
 =?utf-8?B?NGEyQU94cExNSWlhbmc3ZGJVU3AyTlBwQjBiM0p5TDE2cG5rZGxqNmhodkQw?=
 =?utf-8?B?RnJTSkVqWlZDQWFyYXBiQ1Z3YVlUeGtyWFBQVzdSalBLYVgyZzByY3VEb2Jk?=
 =?utf-8?B?MVhZU2VSZ2RnTHZVTlFUcU9qS2dMdk4zNURMMUhtN2VqaUUrdWRUZUQxQWpa?=
 =?utf-8?B?L05KNG93enJGZGN1M1R3bkxUb1p1NGxVb0ZabFhCNjNkZDUzWVQyN2diYUVR?=
 =?utf-8?B?UnVpS21idVR2d3lNQWNDaG5BRU1SalJaKy9SV3VEbWFDTW5halRjKzV5eU5t?=
 =?utf-8?B?RVRVdTRQbEZVbFBvUmk0aitCWlMwYkprUXBicVhNL0plTFlMeHl0YUg2NTRi?=
 =?utf-8?B?N1pyQld3dmZVbUFPMTM2RytpUC9QcDhrUHU2UmZqYTNBWUl6TzExUzJSZi9i?=
 =?utf-8?B?L2tUYU04RHdQOGNyR2JxVUFGbEloaXN2ZVJ0ZmtWMmpFN25zY3JSRWFsdkFj?=
 =?utf-8?B?S25nLzlqNHJPMDBFaXJJem1nSDdiQThOd1luVEpkMXcxZjdmTkJSd3l6RXVC?=
 =?utf-8?B?OTN2ZFJBUVdCLytnM3MzL0kydlZ2SEZqQm5MOG9aTWhtSUNSOXdlUkVYcHF6?=
 =?utf-8?B?Z1JmSzE4c05OeU9LUFJpT0gyUnFscHZ0K01HK1JPSGtvNk9wUnJFSWJ0SG0v?=
 =?utf-8?Q?SZYcLozTx6t3YqvWqs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTVLRmt4UVRTWmZjMnp0T1R3bC9lN2xTUnlGQVZOcDNmcTVxc3NSb0VBRkd0?=
 =?utf-8?B?V3pMY1ZqWlovQnNxUDNkTlFiL2lBa0NDT1JrdXdrMkt6WC9sQzVZRWNSSTly?=
 =?utf-8?B?Y05FOXl1V29QMnB5bzR0MC92bm1hQXF3SCtXQ3dBMlp4ejF5MjFjbHhqU2Zn?=
 =?utf-8?B?akcwdXRuOXluSVpsVVcrNUhQMHhBK3N5R0ZEb1lmNlJTUm1rbm9rZVJvUVBq?=
 =?utf-8?B?d2dTMnFsTnFrZk5ETE11UzhEeVFjbGJneCtBbHU5cnNOR0hkekpORk5jcTQ3?=
 =?utf-8?B?SlRMYmxDMWlrcklVOGlFdWpSTDB3dXpPWDNQUGxvU1R3bk5jQlVaNStMRmts?=
 =?utf-8?B?ckZ1L0Z6cFRienhGM0ZVMGRqTVNpd2ZyanBwaHdBbWNhUHloTm1UMWZNVmlv?=
 =?utf-8?B?SHU0TCtDV1FQMmtPTEJoY0FVTng3cEpsb1FscHQydUh6bUc2dGNJT21ybTZB?=
 =?utf-8?B?bHk4UENqd0V6THpSS3lReWxyNEVkQ1Q4eFN3RnBQWVd6TmNpWDFtNHRaWlM1?=
 =?utf-8?B?SHpkZTd0MUZOSmtEME9rd2xXUHhqdEdNb3piM0RjNlRrTDh6ZTM0YmdJOXhq?=
 =?utf-8?B?eGI0Vmp5bFUxWEJWZW9PVWVBWGlKYldHL3V3cFZaeXlXYVJsQ2c5ZWF2WUZ3?=
 =?utf-8?B?Zkllbmh6aWlEK0lKcEN3L21pRDB1SDNMbXhmWUpOalU3SjZDOVFwQ1Rvdzhv?=
 =?utf-8?B?bE9hb05aRkVTT2xDOTE1UGl5YTRqOUQ0dS9EY3Z0T0I1U2t1OXgva0x2NmlJ?=
 =?utf-8?B?VU1CaC8wQVJDOTQ0SjhBa08rUHk5YU0rMVdlTG5TbXBGQ3dpdDRxdnB4VEs4?=
 =?utf-8?B?eUFNWWwzU1AvV05nOEw3dldJMmRuK3poMndwRlQyaUkxM3JXY1JST1ozNEdL?=
 =?utf-8?B?MkdLLzJZY3FvUmJCNG1mOVdzZzVWVFo4ZFlQdHNQd2M0aWN0bWQzTUtETG5H?=
 =?utf-8?B?TE5SWTdIdG0zdnphY3RoSHJkR1hUTkQwaXJuQXlKd3JhVG1HaUpuSitDcXYr?=
 =?utf-8?B?V2puSnE0K0xvQTQxckc2K241TVd6b05KdW5rUGdnWDRCYXhMM1A3UzQxaXZs?=
 =?utf-8?B?ekgrMHBzK1RtcDh6WGp0TlhOaFd0YXdsaGtNNHhlcUYvamg0RGxqOGhaSFJT?=
 =?utf-8?B?QXpGWWJsYnZPSTBVZW9LaW44K0ltVzhmd216V0M3cHFGZEh1c2JBU0d0NDc2?=
 =?utf-8?B?TFozeUpiSXdMMENaVjRHWWd5OWlsSndha2JZQi9qOVlKQWgrenliaTR5NGxv?=
 =?utf-8?B?MzNHN2dtNjA5TEFIaENIYVoyMkNlb0ZzUnFrVTFJUjI1L0E5dTBwQ2Q5WFlQ?=
 =?utf-8?B?a0JBZ0xRTzl5R2dBU09BSnFLRW05NFN2QjJNbk1idlBCSlhmZE04cU52MWp0?=
 =?utf-8?B?ZUlqdU0va0dZVldIbCs5anBvWkIxQ0wyT0hQY3FCWXdjQXZGWU9hN3dCeXJw?=
 =?utf-8?B?OEw4QUdTQUQvay9lRzNTL0hMbnhPNmszeGdyQmhwQk82NTBaWTM1SjZqQUsy?=
 =?utf-8?B?TmZZMzVyWmVaS1VFcFhPcEhxL1RPc0IycUJEbEJPWDlQOXhkQkRlYUwxS3dR?=
 =?utf-8?B?cE1JanFQYXphRFRiMGk3RXIrRTR5VG5LMTdFcXc4ZHVVQzlPZDhadnFaTkk5?=
 =?utf-8?B?T2xiTUlxZWxvVTRjWWRLTE41aDB3R21INFRzcUpSNU92a211OWI1YWlrYnBl?=
 =?utf-8?B?dVU0WkQ3cnp3S2dIbDFKLzdwYzREZGJIQllEalF4UEQ3bmFualpKM2tUR2Uw?=
 =?utf-8?B?dmgrbTlJQktwcHdZTkRnU3YyTWxkbWo2QlErMGVsZ09BTlFreGtVZ09qUFdj?=
 =?utf-8?B?ckFLeFoyOUJXRDFTN1EyQStKV2xoQnpuK0xSVG1uV1VISHcrSTlaSFhKbHhV?=
 =?utf-8?B?em5kMHBOTlJCMGo1YWlDUkkzMUdsQUY2MmZHU3V1ZXVxckNmMTM4aGJoMUdv?=
 =?utf-8?B?MkVhYmV4VkNtUkNydDVmTlFmSk5XZTZaNEx1ZjhONklxSWVnUTF6TEJuWjJ5?=
 =?utf-8?B?R1I5Yk9zNU40NDJsMEIvcFlrbGFwQUhSV2tuRERYQWU3R3V0S1ZiVmhTZElM?=
 =?utf-8?B?WDFkM2lkN3BLYlJvekRvR2xIbTdEd2ppWi9vZEt2SCtvSGYxQ0YwS0Iyd0dI?=
 =?utf-8?B?TExIMFk3ZTg0d0NjYlRtZ0VpeWJmVlpUN2lmVzJNb0xEL05iN0pZd1ZTZER6?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: multipart/mixed;
	boundary="_002_a9bbb31e6660343e95d3351febc6e3b9661a7944camelintelcom_"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07a2532-8a09-4fb2-efbb-08dc7b239b0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 12:26:43.4881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1OTUqAkkR9AqKpuTtmsFQEeQ3BQLnpSaqHcehCg2cVKVF6sbBxX1aPbjXlS/RAhpkM3vAo3DzTxFlzUj/M6Qjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6447
X-OriginatorOrg: intel.com

--_002_a9bbb31e6660343e95d3351febc6e3b9661a7944camelintelcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <C42B16D9F441804BBD9D53262455643B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDI0LTA1LTIzIGF0IDEwOjMwICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBP
biBUaHUsIDIwMjQtMDUtMjMgYXQgMDc6NTYgKzAyMDAsIErDvHJnZW4gR3Jvw58gd3JvdGU6DQo+
ID4gT24gMjAuMDUuMjQgMTM6NTQsIEh1YW5nLCBLYWkgd3JvdGU6DQo+ID4gPiBPbiBGcmksIDIw
MjQtMDUtMTcgYXQgMDk6NDggLTA3MDAsIERhdmUgSGFuc2VuIHdyb3RlOg0KPiA+ID4gPiBPbiA1
LzE3LzI0IDA4OjU4LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPiA+ID4gPiA+IE9uIDE3LjA1LjI0
IDE3OjUyLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4gPiA+ID4gLi4NCj4gPiA+ID4gPiA+IE9uY2Ug
d2UgaGF2ZSB0aGUgc3BlY2lmaWMgVERYIG1vZHVsZSB2ZXJzaW9uLCB3ZSBjYW4gZ28gYXNrIHRo
ZSBmb2xrcw0KPiA+ID4gPiA+ID4gd2hvIHdyaXRlIGl0IGlmIHRoZXJlIHdlcmUgYW55IFJCUCBj
bG9iYmVyaW5nIGJ1Z3MuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gT2theSwgaG93IHRvIGdldCB0
aGUgVERYIG1vZHVsZSB2ZXJzaW9uPw0KPiA+ID4gPiANCj4gPiA+ID4gWW91IG5lZWQgc29tZXRo
aW5nIGxpa2UgdGhpczoNCj4gPiA+ID4gDQo+ID4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYWxsLzIwMjMxMDEyMTM0MTM2LjEzMTA2NTAtMS15aS5zdW5AaW50ZWwuY29tLw0KPiA+ID4g
DQo+ID4gPiBUaGlzIG9uZSBwcmludHMgVERYIHZlcnNpb24gaW5mbyBpbiB0aGUgVERYIGd1ZXN0
LCBidXQgbm90IGhvc3QuDQo+ID4gPiANCj4gPiA+IFRoZSBhdHRhY2hlZCBkaWZmIHByaW50cyB0
aGUgVERYIHZlcnNpb24gKHNvbWV0aGluZyBsaWtlIGJlbG93KSBkdXJpbmcNCj4gPiA+IG1vZHVs
ZSBpbml0aWFsaXphdGlvbiwgYW5kIHNob3VsZCBtZWV0IEp1ZXJnZW4ncyBuZWVkcyBmb3IgdGVt
cG9yYXJ5IHVzZToNCj4gPiA+IA0KPiA+ID4gWyAgMTEzLjU0MzUzOF0gdmlydC90ZHg6IG1vZHVs
ZSB2ZXJzb246IG1ham9yIDEsIG1pbm9yIDUsIGludGVybmFsIDANCj4gPiA+IA0KPiA+ID4gPiAN
Cj4gPiA+ID4gLi4gYW5kIHllYWgsIHRoaXMgbmVlZHMgdG8gYmUgdXBzdHJlYW0uDQo+ID4gPiA+
IA0KPiA+ID4gDQo+ID4gPiAgRnJvbSB0aGlzIHRocmVhZCBJIHRoaW5rIGl0IG1ha2VzIHNlbnNl
IHRvIGFkZCBjb2RlIHRvIHRoZSBURFggaG9zdCBjb2RlDQo+ID4gPiB0byBwcmludCB0aGUgVERY
IHZlcnNpb24gZHVyaW5nIG1vZHVsZSBpbml0aWFsaXphdGlvbi4gIEknbGwgc3RhcnQgdG8gd29y
aw0KPiA+ID4gb24gdGhpcy4NCj4gPiA+IA0KPiA+ID4gT25lIHRoaW5nIGlzIGZyb20gdGhlIHNw
ZWMgVERYIGhhcyAiNCB2ZXJzaW9ucyI6IG1ham9yLCBtaW5vciwgdXBkYXRlLA0KPiA+ID4gaW50
ZXJuYWwuICBUaGV5IGFyZSBhbGwgMTYtYml0LCBhbmQgdGhlIG92ZXJhbGwgdmVyc2lvbiBjYW4g
YmUgd3JpdHRlbiBpbjoNCj4gPiA+IA0KPiA+ID4gCTxNYWpvcj4uPE1pbm9yPi48VXBkYXRlPi48
SW50ZXJuYWw+LCBlLmcuLCAxLjUuMDUuMDENCj4gPiA+IA0KPiA+ID4gKHNlZSBURFggbW9kdWxl
IDEuNSBBUEkgc3BlYywgc2VjdGlvbiAzLjMuMiAiVERYIE1vZHVsZSBWZXJzaW9uIi4pDQo+ID4g
PiANCj4gPiA+IFRoZSBhdHRhY2hlZCBkaWZmIG9ubHkgcHJpbnRzIG1ham9yLCBtaW5vciBhbmQg
aW50ZXJuYWwsIGJ1dCBsZWF2ZXMgdGhlDQo+ID4gPiB1cGRhdGUgb3V0IGJlY2F1c2UgSSBiZWxp
ZXZlIGl0IGlzIGZvciBtb2R1bGUgcnVudGltZSB1cGRhdGUgKHlldCB0bw0KPiA+ID4gY29uZmly
bSkuDQo+ID4gPiANCj4gPiA+IEdpdmVuIHRoZXJlIGFyZSA0IHZlcnNpb25zLCBJIHRoaW5rIGl0
IG1ha2VzIHNlbnNlIHRvIGltcGxlbWVudCByZWFkaW5nDQo+ID4gPiB0aGVtIGJhc2VkIG9uIHRo
aXMgcGF0Y2hzZXQgLi4uDQo+ID4gPiANCj4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2
bS82OTQwYzMyNi1iZmNhLTRjNjctYmFkZi1hYjVjMDg2YmY0OTJAaW50ZWwuY29tL1QvDQo+ID4g
PiANCj4gPiA+IC4uLiB3aGljaCBleHRlbmRzIHRoZSBnbG9iYWwgbWV0YWRhdGEgcmVhZGluZyBj
b2RlIHRvIHN1cHBvcnQgYW55DQo+ID4gPiBhcmJpdHJhcnkgc3RydWN0IGFuZCBhbGwgZWxlbWVu
dCBzaXplcyAoYWx0aG91Z2ggYWxsIDQgdmVyc2lvbnMgYXJlIDE2LQ0KPiA+ID4gYml0KT8NCj4g
PiANCj4gPiBXaXRoIHRoYXQgSSBnb3Q6DQo+ID4gDQo+ID4gWyAgIDI5LjMyODQ4NF0gdmlydC90
ZHg6IG1vZHVsZSB2ZXJzb246IG1ham9yIDEsIG1pbm9yIDUsIGludGVybmFsIDANCj4gPiANCj4g
PiANCj4gDQo+IExldCBtZSBjaGVjayBURFggbW9kdWxlIGd1eXMgb24gdGhpcyBhbmQgZ2V0IGJh
Y2sgdG8geW91Lg0KDQpIaSBKdXJnZW4sDQoNCkkgd2FzIHRvbGQgdGhlIG1vZHVsZSBzdGFydGlu
ZyB3aXRoICIxLjUuMDYuIiBoYXMgTk9fUkJQX01PRCBzdXBwb3J0Lg0KDQpBbmQgSSB0aGluayBJ
IHdhcyB3cm9uZyBhYm91dCB0aGUgPHVwZGF0ZT4gcGFydCBvZiB0aGUgdmVyc2lvbiwgYW5kIHdl
DQpuZWVkIHRoYXQgdG8gZGV0ZXJtaW5lIHRoZSB0aGlyZCBwYXJ0IG9mIHRoZSBtb2R1bGUgdmVy
c2lvbi4NCg0KSSB3YXMgYWxzbyB0b2xkIHRoZSAxLjUuMDYgbW9kdWxlIGhhc24ndCBiZWVuIHJl
bGVhc2VkIHRvIHB1YmxpYyB5ZXQsIHNvIEkNCmd1ZXNzIHlvdXIgbW9kdWxlIGRvZXNuJ3Qgc3Vw
cG9ydCBpdC4NCg0KSSBkaWQgYW5vdGhlciBwYXRjaCAoYXR0YWNoZWQpIHRvIGNoZWNrIE5PX1JC
UF9NT0QgYW5kIHJlamVjdCBtb2R1bGUNCmluaXRpYWxpemF0aW9uIGlmIGl0IGlzIG5vdCBzdXBw
b3J0ZWQsIGFuZCBwcmludCBvdXQgbW9kdWxlIHZlcnNpb246DQoNClsgIDE0Ni41NjY2NDFdIHZp
cnQvdGR4OiBOT19SQlBfTU9EIGZlYXR1cmUgaXMgbm90IHN1cHBvcnRlZA0KWyAgMTQ2LjU3Mjc5
N10gdmlydC90ZHg6IG1vZHVsZSB2ZXJzb246IDEuNS4wLjANClsgIDE0Ni41Nzc3MzFdIHZpcnQv
dGR4OiBtb2R1bGUgaW5pdGlhbGl6YXRpb24gZmFpbGVkICgtMjIpDQoNCllvdSBjYW4gaGF2ZSBh
bm90aGVyIHRyeSB0byB2ZXJpZnkgYXQgeW91ciBzaWRlLCBpZiB0aGF0IGhlbHBzLg0KDQo=

--_002_a9bbb31e6660343e95d3351febc6e3b9661a7944camelintelcom_
Content-Type: text/x-patch; name="check_no_rbp_mod.diff"
Content-Description: check_no_rbp_mod.diff
Content-Disposition: attachment; filename="check_no_rbp_mod.diff"; size=2708;
	creation-date="Thu, 23 May 2024 12:26:43 GMT";
	modification-date="Thu, 23 May 2024 12:26:43 GMT"
Content-ID: <395DE6989EBB4D4681CAAC6869445BCA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

Y29tbWl0IGUzOTA3MjY5YjM0ZTRmNDg4Mjg0ZjM1NzE2ZjIzMWRhN2JjM2U2YjMKQXV0aG9yOiBL
YWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+CkRhdGU6ICAgVGh1IE1heSAyMyAyMzoxNzoy
OCAyMDI0ICsxMjAwCgogICAgeDg2L3ZpcnQvdGR4OiBjaGVjayBOT19SQlBfTU9EIGFuZCBwcmlu
dCBtb2R1bGUgdmVyc2lvbgogICAgCiAgICBTaWduZWQtb2ZmLWJ5OiBLYWkgSHVhbmcgPGthaS5o
dWFuZ0BpbnRlbC5jb20+CgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5j
IGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jCmluZGV4IDRkNjgyNmE3NmY3OC4uZmZjMWMy
N2I5MTM0IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMKKysrIGIvYXJj
aC94ODYvdmlydC92bXgvdGR4L3RkeC5jCkBAIC0xMDk3LDExICsxMDk3LDYwIEBAIHN0YXRpYyBp
bnQgaW5pdF90ZG1ycyhzdHJ1Y3QgdGRtcl9pbmZvX2xpc3QgKnRkbXJfbGlzdCkKIAlyZXR1cm4g
MDsKIH0KIAorc3RhdGljIGludCBjaGVja19tb2R1bGVfY29tcGF0aWJpbGl0eSh2b2lkKQorewor
CXU2NCB0ZHhfZmVhdHVyZXMwOworCWludCByZXQ7CisKKwlyZXQgPSByZWFkX3N5c19tZXRhZGF0
YV9maWVsZChNRF9GSUVMRF9JRF9URFhfRkVBVFVSRVMwLAorCQkJJnRkeF9mZWF0dXJlczApOwor
CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKworCWlmICghKHRkeF9mZWF0dXJlczAgJiBURFhf
RkVBVFVSRVMwX05PX1JCUF9NT0QpKSB7CisJCXByX2VycigiTk9fUkJQX01PRCBmZWF0dXJlIGlz
IG5vdCBzdXBwb3J0ZWRcbiIpOworCQlyZXR1cm4gLUVJTlZBTDsKKwl9CisKKwlyZXR1cm4gMDsK
K30KKworc3RhdGljIHZvaWQgcHJpbnRfdGR4X3ZlcnNpb24odm9pZCkKK3sKKwl1NjQgbWFqb3Is
IG1pbm9yLCB1cGRhdGUsIGludGVybmFsOworCWludCByZXQ7CisKKwlyZXQgPSByZWFkX3N5c19t
ZXRhZGF0YV9maWVsZChNRF9GSUVMRF9JRF9NQUpPUl9WRVJTSU9OLCAmbWFqb3IpOworCWlmIChy
ZXQpCisJCXJldHVybjsKKworCXJldCA9IHJlYWRfc3lzX21ldGFkYXRhX2ZpZWxkKE1EX0ZJRUxE
X0lEX01JTk9SX1ZFUlNJT04sICZtaW5vcik7CisJaWYgKHJldCkKKwkJcmV0dXJuOworCisJcmV0
ID0gcmVhZF9zeXNfbWV0YWRhdGFfZmllbGQoTURfRklFTERfSURfVVBEQVRFX1ZFUlNJT04sICZ1
cGRhdGUpOworCWlmIChyZXQpCisJCXJldHVybjsKKworCXJldCA9IHJlYWRfc3lzX21ldGFkYXRh
X2ZpZWxkKE1EX0ZJRUxEX0lEX0lOVEVSTkFMX1ZFUlNJT04sICZpbnRlcm5hbCk7CisJaWYgKHJl
dCkKKwkJcmV0dXJuOworCisJcHJfaW5mbygibW9kdWxlIHZlcnNvbjogJXUuJXUuJXUuJXVcbiIs
CisJCQkodTE2KW1ham9yLCAodTE2KW1pbm9yLCAodTE2KXVwZGF0ZSwgKHUxNilpbnRlcm5hbCk7
Cit9CisKIHN0YXRpYyBpbnQgaW5pdF90ZHhfbW9kdWxlKHZvaWQpCiB7CiAJc3RydWN0IHRkeF90
ZG1yX3N5c2luZm8gdGRtcl9zeXNpbmZvOwogCWludCByZXQ7CiAKKwkvKiBNYWtlIHN1cmUgVERY
IG1vZHVsZSBtZWV0cyBrZXJuZWwncyBleHBlY3RhdGlvbiAqLworCXJldCA9IGNoZWNrX21vZHVs
ZV9jb21wYXRpYmlsaXR5KCk7CisJaWYgKHJldCkKKwkJZ290byBvdXQ7CisKIAkvKgogCSAqIFRv
IGtlZXAgdGhpbmdzIHNpbXBsZSwgYXNzdW1lIHRoYXQgYWxsIFREWC1wcm90ZWN0ZWQgbWVtb3J5
CiAJICogd2lsbCBjb21lIGZyb20gdGhlIHBhZ2UgYWxsb2NhdG9yLiAgTWFrZSBzdXJlIGFsbCBw
YWdlcyBpbiB0aGUKQEAgLTExNTUsNiArMTIwNCwxMCBAQCBzdGF0aWMgaW50IGluaXRfdGR4X21v
ZHVsZSh2b2lkKQogCSAqIExvY2sgb3V0IG1lbW9yeSBob3RwbHVnIGNvZGUgd2hpbGUgYnVpbGRp
bmcgaXQuCiAJICovCiAJcHV0X29ubGluZV9tZW1zKCk7CisKK291dDoKKwlwcmludF90ZHhfdmVy
c2lvbigpOworCiAJcmV0dXJuIHJldDsKIAogZXJyX3Jlc2V0X3BhbXRzOgpkaWZmIC0tZ2l0IGEv
YXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5oIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5o
CmluZGV4IGI3MDFmNjk0ODVkMy4uMTNhZDUyMzUyZTM1IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni92
aXJ0L3ZteC90ZHgvdGR4LmgKKysrIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5oCkBAIC0z
Nyw2ICszNywxNCBAQAogI2RlZmluZSBNRF9GSUVMRF9JRF9QQU1UXzJNX0VOVFJZX1NJWkUJCTB4
OTEwMDAwMDEwMDAwMDAxMVVMTAogI2RlZmluZSBNRF9GSUVMRF9JRF9QQU1UXzFHX0VOVFJZX1NJ
WkUJCTB4OTEwMDAwMDEwMDAwMDAxMlVMTAogCisjZGVmaW5lIE1EX0ZJRUxEX0lEX1REWF9GRUFU
VVJFUzAJCTB4MEEwMDAwMDMwMDAwMDAwOFVMTAorI2RlZmluZSBURFhfRkVBVFVSRVMwX05PX1JC
UF9NT0QJCUJJVF9VTEwoMTgpCisKKyNkZWZpbmUgTURfRklFTERfSURfTUlOT1JfVkVSU0lPTgkJ
MHgwODAwMDAwMTAwMDAwMDAzVUxMCisjZGVmaW5lIE1EX0ZJRUxEX0lEX01BSk9SX1ZFUlNJT04J
CTB4MDgwMDAwMDEwMDAwMDAwNFVMTAorI2RlZmluZSBNRF9GSUVMRF9JRF9VUERBVEVfVkVSU0lP
TgkJMHgwODAwMDAwMTAwMDAwMDA1VUxMCisjZGVmaW5lIE1EX0ZJRUxEX0lEX0lOVEVSTkFMX1ZF
UlNJT04JCTB4MDgwMDAwMDEwMDAwMDAwNlVMTAorCiAvKgogICogU3ViLWZpZWxkIGRlZmluaXRp
b24gb2YgbWV0YWRhdGEgZmllbGQgSUQuCiAgKgo=

--_002_a9bbb31e6660343e95d3351febc6e3b9661a7944camelintelcom_--

