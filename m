Return-Path: <linux-kernel+bounces-561990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41918A619F3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C10847A929D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89EA204C14;
	Fri, 14 Mar 2025 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lU2+fvgj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04642046BB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741978635; cv=fail; b=F0IpHWPEo6bnxvvw56/7Mbl8kwgtxbCaDPBXUzGNZX8qxMxgho55DNoY/9JAQGsu7JHX/XXcBb4Vc0all9mVKcTkIixBTnoxLjqq7HjO4grdKI/hK63UJ+fsGuhn8s7gQwqiIGSsJVA+u97c2A+MgUzTo3BZTRdl8gKH97V/C6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741978635; c=relaxed/simple;
	bh=6ZoUdtW3u0N7IkQ2K6TAYBgKJiolgJ4cJPlQJKpr4vE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BZekAPUV3BOUrFT/0f/rmy8svVCbcPnWP73/AzWzF4afjB3A0zyteGnnokXIYjQd5b7Mys+UpVDHLrNyhv/1XEhHHoSyCDHbnvbm1oHTcTpuUrisDJo3CCoi6kLG9Cq7mIo4R53RxfTSVm5QjlSvmXhe23VUMgEXia7gJJsykqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lU2+fvgj; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741978634; x=1773514634;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6ZoUdtW3u0N7IkQ2K6TAYBgKJiolgJ4cJPlQJKpr4vE=;
  b=lU2+fvgj1mpuGF9U04b9j3wy3kOPswiEHGVvQygjwYsrKvsKR0Tcty6i
   lm/XZesigyHHYAWvyKjdxCbC4P3u1vTt7yD/otJOxie9jGVCt8rxIKOFr
   mByy4zQMWXPW0H+NQ7JVtVjfrqd5/IUmcobmyiaq1299fJswi7E36Si1U
   yNFP2tlg1U3Ou1vDgCc5BE8nrLCG8ZTWQEq+GBc6I6Y3nNXTrBBnLyebG
   MlrU7bBetApGfba5PNgc5JCU5QcWDNpr4RoyPuwptgVisBydS/Ccf0qVf
   l07SzcIiaVd6yLsF6aGPWzZn+H4YjJZlQcdOxYL29wjIGTyCxZqXxmw+0
   A==;
X-CSE-ConnectionGUID: OjQUTiZZQ5CErYTiwOQDDA==
X-CSE-MsgGUID: dN4BipeKRRe510M1QaJVzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43320790"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43320790"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 11:57:10 -0700
X-CSE-ConnectionGUID: wskj6zqETZWdPOdUoJ6LCQ==
X-CSE-MsgGUID: L5EKNcJJTBe5vanocrA3DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121354274"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 11:57:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 11:57:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 11:57:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 11:57:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ieZ4X93ID1PkblCfV2vOhQemKKC+wDa8I+X1g9W5sa9Lm2R42+VO1R3mvbHp5aO/FGWmcy6NmICUQy0l+9fTnl26T3Zig3y7UJQ2WZg1r5H2VIw0/0R2O84QyrLMcIlLGR5aEbXEjNzVDrK0HNd4pRUFC+AiJcZwZ+7sLHdVUZnvTXmP304laZnUppLSHEK0sTNqHzx7XntespfvSgwu8CCMaEiXVQ52j+BPGoNJhab/x1Enqqop5kZtJZJiz5Y8YfWCBMyJjBvMdO4unrGZs+8IciULiJ6/9KHg3oJS8zVDP/oq1e++NVLCaqsNuwzLSWfbkOkitv+P9JqWcR/Mcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZoUdtW3u0N7IkQ2K6TAYBgKJiolgJ4cJPlQJKpr4vE=;
 b=Pfye63Fp+UiDc+6nPlGcR3Q5VUuDaIgZmTGYH7EVIb1drD28lr7YU/xU0pK3Ly7N+lcomXQhd8napKI7Q58uF5S8DtCPO+uvppku8lwyaBghTS8KAVi2vqgjbRKtNRDuhyImk4ufEOydWeQBl1RBEIudTtOgj1jT1p1K1MhBQIVj2Ou+SVXOJoDevHFsINqqOvv82gYkWj4c94nX1JZMsxS+WkzXdpHGi/OfH5p7YYLEmepEbiLHX5WIdz27s+BquhGpbz8VMsrlmMsMMwhcWjVJrGDw6koheWakfoBX7cR5fSLcalts3e8gHKRWUVXwIAgzqv3GPrCUeZLSvvBOBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH8PR11MB6829.namprd11.prod.outlook.com (2603:10b6:510:22f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.29; Fri, 14 Mar
 2025 18:57:06 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 18:57:06 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "Huang, Kai"
	<kai.huang@intel.com>, "bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "dyoung@redhat.com"
	<dyoung@redhat.com>, "seanjc@google.com" <seanjc@google.com>,
	"x86@kernel.org" <x86@kernel.org>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>
Subject: Re: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for bare-metal
 in stop_this_cpu()
Thread-Topic: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for
 bare-metal in stop_this_cpu()
Thread-Index: AQHbk0LE9xNDz/BUxUyAtvW7JgE+xLNxaCeAgAFYMICAABVLAIAAHssAgAAKywA=
Date: Fri, 14 Mar 2025 18:57:06 +0000
Message-ID: <2a949eff1971c57f447ab9250eb034a009c144bd.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
	 <e9ee3c7ffc3ba6feb97247faa40789684e39ffd0.1741778537.git.kai.huang@intel.com>
	 <e0d9a3d599025c92fce5e159e8acc1af32844912.camel@intel.com>
	 <e7adcb16-ff6c-d901-155b-866be4de2d40@amd.com>
	 <d7805e17b7f09b08384406168571d1bfd019b77b.camel@intel.com>
	 <8828599d-e251-7b8d-c6d5-31383d8b5b9f@amd.com>
In-Reply-To: <8828599d-e251-7b8d-c6d5-31383d8b5b9f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH8PR11MB6829:EE_
x-ms-office365-filtering-correlation-id: 72fd1acb-62f8-4dd9-bca5-08dd632a03ed
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YnJaUmRDUytYaTNjYUg1Y25DQlVHMnd0UGpjOVowYVZ0d3lzeElGQkdoV2FI?=
 =?utf-8?B?V3U3WHBQZG5yT2F0WFd2NFYxSmpaY21aS2IvUG5JSzhGR0pycDB6ejJJaUhx?=
 =?utf-8?B?VlJEb1kzbHV5anFTNWJxNmMrRmV5c1ZFcWd5WDkrV3EvZXYzV3psdTR2Q0hB?=
 =?utf-8?B?NGxFek1nNm5xbXplanJKRVBKNGM5NjI0dThGcFFVMlN4bmp1bWFzRGpTY2Ji?=
 =?utf-8?B?MnN0aXhVVUNFcy96SmxWdlNxdUNSV2ZhSDUwTC9oYnFTeE01czB0SDRwOXdn?=
 =?utf-8?B?QURFMVJBUjZiOFFpeEozN2NKT1ptMHZ4aW9pSHVWSHZ0cjRzRjFIRis1OEcr?=
 =?utf-8?B?b0VFQ3NncExOa0xvK3F3ekVDRFVuNWdwUHNIYU0wRDJCazF0S21lYTNwdTNi?=
 =?utf-8?B?aEpFRmwwdGJmbUNEeUVKdHpHNU5OWEpaWmMzTVZTaitWdUVhb0NGbkk0NVFz?=
 =?utf-8?B?cnBzREFEWEJ6aU42SUYreWVOZlFJVk9mQmpkUlVBWkRPNFMrYnhzZlJvWGt5?=
 =?utf-8?B?SWZjdnFlYWh6Qi9mMzNndHFBQ1ZEQUxKMEI4dDVSUXIxelFkQmJ4OWU0MldY?=
 =?utf-8?B?RThOTEYyWlZnS24xZlBxT1Q5d09PWEJtUTd4Uk9jaGExKzI5d2kvWW5wb2Qx?=
 =?utf-8?B?REVEMnYraThkMGhHMUE2SjJFTWNWOUJWSEhJNmsvVjJ3OEQyK21GSkVFcjBW?=
 =?utf-8?B?bEc1U0FCL3FCZDR5TTFRU3BHaGJCOGpLc2s2dUFOYWpyd3hSNHhocFVocWZB?=
 =?utf-8?B?cFBLYndKVmpKN2ZxcGc4UEQ1Nlp0RmIwZlpHVmdOVG81cTZLUUVmMUdJMVpY?=
 =?utf-8?B?aFNDbFVtUzV3TFBUZE80SVdGaXJoT2o5d0M0WjFJWTAyQUNINFE0aU5EZXdp?=
 =?utf-8?B?VzYxcmFFa2Y1KytIcnlGa2lOZkppWngvQStUK0FqNmdkdG44R1BPazY5MmIr?=
 =?utf-8?B?NVduR01admVJL1hLckJjVmZtRGc1cWdOYWRNWXBxTDVaRExDVkdMcE1NT0tF?=
 =?utf-8?B?TzBUWm9MRXJtdlFYeXhpWUk0T04yNUZtYTc4aVRJMHBNWWdoNVg0eDdhVHhE?=
 =?utf-8?B?alJDSkZVNnhUbi83czlveXJ3eVNSaDVSakVYWjdSVjQ1N21BYzd6Zk9NZVdF?=
 =?utf-8?B?Y3o0a2IvSHp1T2k1NmF0K2VaRExUd2hraU4xbTZ2aFJ3RG0vZmFTams2R2Rw?=
 =?utf-8?B?Q3JsbzgrVGlEemY1d2cvQVFSUGs5UzZxY0hkWHFjc0thN3hqbloza2kzMmVX?=
 =?utf-8?B?N1AwNzhRUXZqbnZxZnFJMExTdWUyMHdyQWo0bFN3bDl3ZjN2Y2w5K1J0MEto?=
 =?utf-8?B?RXlpZS8xbjUwTWg4L044NUtBaWFNV05MMk1rMzAwazhodmErSlRTTStWRUdP?=
 =?utf-8?B?SVVFNmYzd29EY3I3UFRQeDZvSXlGWW1iWkxWeGk0Rjc0S2dRQ2kvWFd6WUFE?=
 =?utf-8?B?aU0yUVlubTlyVGVZckpRK0pIeU9lWEtGWnEzWEtLWlllay9GRkVkakRFaFRp?=
 =?utf-8?B?Zm40UlZlZzUxOEJhMzBPYlBlOXVYakNKZWk5b2Ixd1Z1UUhyNTZ3WHFmcVFY?=
 =?utf-8?B?bFBzYkxGRm1TZWI3clh6eWJ3bjkvZ0NCS3Y2MFpwMUpvVVJhT0JWUHhDTkFw?=
 =?utf-8?B?NXl2TFpaVTZPeVZzNzE0YTNIMkk4ZGQzZ096cUkvbksvcll1VHh4aUVTbUZR?=
 =?utf-8?B?L2huWUFHb1l6UVdiTFM0aldVL2E1VXhmQmNOYkFSaDZieFMzcS9wMlV4bXhN?=
 =?utf-8?B?cEkvT0xOR004V3A1R0F6blFaN1l6ZGhRSXZ5eVBZell6TlB6OUNiWGdVaTdp?=
 =?utf-8?B?SUdMSkpBOFlzMmxxWElmSTk3WXlOOVhTRjRscS9ibmlta3k0cXg0cnc1UVhx?=
 =?utf-8?B?czhpMnpVRkxaTW9KM1BCaWtCS2MwUHliRXRhQmxwdUtuSnk0dXBVWjlVeWJ4?=
 =?utf-8?B?ZEZmTVVxL3ovM0pqZmNXSFVPYWJpdzNGanhPMlNiQnZ0YlVkSjNoWmVaSk5w?=
 =?utf-8?B?eDBmNHcxRmdBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGlESjdmRzc2NE9aVjBLbVpDRUxmdjJ3VlFtSWdGUGo2aXpBQ0plbUthS2hq?=
 =?utf-8?B?N0NhZU1MTHlPV3RzK2lMTGVFV3BMN1RyMnFhM0FuT0hjYlNFNWNEU3VNYVR1?=
 =?utf-8?B?ZVEvcDhYTWdHdWZmeCtadDB5cGNLTDJrK0ViRzVmYVRBS3lHUmh5MXFsd1ZG?=
 =?utf-8?B?VElZODZhZHVMbnBkYnZWdHFvR0Y0b3ZNZ1I1N3IzTyt6NHVtaE9BbHpUVENQ?=
 =?utf-8?B?dUpESC81UW9JanJ2VTloRG5vWDRTZ1JpazFzajM1MTZBbENiRjduUDc3RjNY?=
 =?utf-8?B?VmdzOVdHR0NBZ0tkWWQ5ZWpGYWNray9kWUxaRmUvdW0xbHUwQnhvcTBGV3Jk?=
 =?utf-8?B?T2tHN0J5Yk9QZXdOL29zWXZDWGNLVGUzdDNVaEh5ejBKczVwUU1LVVc1djVw?=
 =?utf-8?B?MTJkM0JNSStQTVVuOXJET3lURGhsMWd2bW82eDVON1lCNUJpSzM5Q05hWUpH?=
 =?utf-8?B?eXV3RHBNdW1aSnR4ckJ3YmpBbHFrSzNpQXJxV09xbG9yVXd5N0d2b3kyVUlB?=
 =?utf-8?B?UGc2OCsrTGYxcnNsU3BHS3MyN2Nab1I2Vk5ZQmZ0RVVZbnVlQkVaMXNrL09Q?=
 =?utf-8?B?cTdkSzVCS3VTdzg3SWhvNWpKVlJocjUyN3k1dXczNWhlUW1qd2hTYXBRNDVz?=
 =?utf-8?B?RmdjcE5PcTBnYkc1VTBLYnIvWVFjcmgybTFEeG8vR2pJcDZhQkR6cTRQUTIx?=
 =?utf-8?B?NmhYekpiYytsWmlYRjluN2FZTjlKcSt2V0x3YWVKRlRGRHRUM0tpMzgvc1RQ?=
 =?utf-8?B?YkxoSHg4WlprN2hMOUlFaXVqT0p2RGJUNE1JeE5lMW5SMzlOUVl4VXYyWTdZ?=
 =?utf-8?B?Z3V2ZTZlWXUvMjdtcVl2UHdid21kSU9IRE5hVXFKOFQvOU9YdEJwaktCbDlU?=
 =?utf-8?B?VjhqVVFuSFdYQm8yMnpocUl3VXV5ZWQxcUtTNFlqd0FCREtrZFV1OHo1ZGNq?=
 =?utf-8?B?VXRFcDhaeW8xSmJJeUFwRmp3R0h3cHpPdFlsdnJjRU5FWVY1YTlpRjA3YkFT?=
 =?utf-8?B?bjFYUnVVQ2M2eFZaZmpibkZ6cEZveTNxMUYwaTNNam5yT0t4SmRVYUxaNCtx?=
 =?utf-8?B?WnFLSnhRUkpiTDVIMlFtRXJUQVpma0RvMUVRVVBZLzJRZjdzNmNnOHBVS3di?=
 =?utf-8?B?TVRreDJmMUI0V0lVaVlaVUlYQWZQNUo4bTcvbng1VHBIak11dXE0dEZRenpZ?=
 =?utf-8?B?N014d0NoWnVLQ2RtZjc0cXdtTEsvenA3bW0wejQ3cjdUL1pSSDlrNC9zNFdi?=
 =?utf-8?B?VThzcE1seVBDZFdjTkczTUdJNmZtdGZRN0NCaFFxMkw1UnJ3QzRnT1IrOUl2?=
 =?utf-8?B?MzBMdmJBMjdOMDJrR3BTejJUNC8rQmxXVG9HU1BwQ2JDdjRtQlZGQ1dGWTVR?=
 =?utf-8?B?azQyQWIxcUlEckdSUlJSQVl3NFJRWVFLNGNWdllLVkJtdVVxNEI2clRkVGx5?=
 =?utf-8?B?eUY1MmV3Y3MwQ0IxZytyMks2ZmpHSm04TlphbjB0NUh0UlpoLytIZWNiVWJS?=
 =?utf-8?B?emVkaGNsaEpiUERvSXNSRkIvMG5zUnE4UFRmMnlqYmVxK1FmQWg0QlQwRXdM?=
 =?utf-8?B?MXpiZWFHOE5vWDZxc0p5allRaStDTVFuQjl2cjdCRFhKSDVJZUpaTUNtMWlT?=
 =?utf-8?B?RkR3MHI3SVFiWVlneUxaNjdxTTZNZStHOWpsdDVjaDVHZ3U4WWtYYzBpTkh6?=
 =?utf-8?B?UWJ1WEIxb2Zsb0hLeG96cHVlZjZXckdiazZoYStCTmYyUDc4TzhEL0RHN2w4?=
 =?utf-8?B?SjF5K0lVQ0dkSFdVbG95MFM2OHJDbnhWN1lxb3FKNWpJWkQxaUdFSG5hSFI4?=
 =?utf-8?B?M0pRdE1LNXE5bEZlcndyK012bE9XVUlNemlFRWJUeUkrOGFXOFl0Y0xleG13?=
 =?utf-8?B?ZW83VWFQSThEc1l1c1ZrQ3ZYcEp3RlJvdXBaTElkVlcyZXBTL29RSWdTUjRj?=
 =?utf-8?B?WXNOOFJCRGNXdzBQZVpyRGQzbzQ2Mms1OVcrRHhUSDhnYTNZM3llaXhBbWVC?=
 =?utf-8?B?Rlh4dHNsaEJpSWd3OFI4YW84dzBlNjFWWjk5R1o2VVhrWnRoY0wyWXB0ckp4?=
 =?utf-8?B?QVpEbktWWkFSWjhnMXEzUkVEY1JVY2traVJRd3o2c3JIMGdkUmZ6UXkrTDZQ?=
 =?utf-8?B?TWF0bVV0dGdwNzgxMS9KVzc0UmNZTzNNOTlMYytmTWlGdmVQZWF2MXFaV29B?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF03157D0B1DB04FB50D299494F3921D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fd1acb-62f8-4dd9-bca5-08dd632a03ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 18:57:06.1617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VTVuv8hSR8GvhWc01zznloYZNUzB7ukylXA0n3ycd06XHN0A7YKm9nVFATXftoC8dZQ1Is3L7lJpTyiefA6ViS8yMUwaBZv4FPY4Xzdr1oE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6829
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTAzLTE0IGF0IDEzOjE4IC0wNTAwLCBUb20gTGVuZGFja3kgd3JvdGU6DQo+
ID4gRG9lcyB0aGUgc3RvcF90aGlzX2NwdSgpIHBhcnQgbmV2ZXIgY29tZSBpbnRvIHBsYXkgZm9y
IFNNRSBlaXRoZXI/IEl0IGxvb2tzDQo+ID4gbGlrZQ0KPiA+IGl0IHdhcyBhZGRlZCBmb3IgVERY
IGd1ZXN0IGtleGVjLCBidXQgaXMgYSBnZW5lcmFsIEFDUEkgdGhpbmcuDQo+IA0KPiBJdCBpcyBh
IGdlbmVyYWwgQUNQSSB0aGluZywgYnV0IEkgZG9uJ3Qga25vdyBvZiBpdCBiZWluZyB1c2VkIGJ5
IG91ciBNQURUDQo+IHRhYmxlcy4NCj4gDQo+ID4gDQo+ID4gUmVnYXJkaW5nIHRoZSBrYXNhbiB0
aGluZywgSSB3YXMgbG9va2luZyBhdCB0aGlzIHRvbzoNCj4gPiB3YmludmQoKQ0KPiA+IGNwdW1h
c2tfY2xlYXJfY3B1KCkNCj4gPiDCoMKgIGNsZWFyX2JpdCgpDQo+ID4gwqDCoMKgwqAgaW5zdHJ1
bWVudF9hdG9taWNfd3JpdGUoKQ0KPiA+IMKgwqDCoMKgwqDCoCBrYXNhbl9jaGVja193cml0ZSgp
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoCBfX2thc2FuX2NoZWNrX3dyaXRlKCkgPC0gbm9uLWlubGlu
ZQ0KPiANCj4gWWVzLCB0aGlzIGRvZXMgbG9vayB3b3JyaXNvbWUuIFRvbyBiYWQgdGhlcmUgaXNu
J3QgYSB3YXkgdG8gdHVybiBvZmYgS0FTQU4NCj4gZm9yIGEgc2luZ2xlIGZ1bmN0aW9uLg0KDQpJ
IHdvbmRlciB3aHkgdGhhdCBvbmUgaGFzIGFuIGV4cGxpY2l0IGNhbGwsIGNvbXBhcmVkIHRvIGNv
bXBpbGVyIGdlbmVyYXRlZA0Kc3R1ZmYuIEl0IG1ha2VzIG1lIHdvbmRlciBpZiB0aGVyZSBpcyBq
dXN0IHNvbWUgS0FTQU4gc2tpcHBpbmcgYml0LXdpc2UNCm9wZXJhdGlvbnMgdGhhdCBjb3VsZCBi
ZSBkb25lIHRvIGZpeCBpdC4NCg0KRm9yIHN0b3BfdGhpc19jcHUoKSwgbm90IHN1cmUgaG93IHRv
IGF2b2lkIGl0LiBNYXliZSBqdXN0IGEgcmF3IGp1bXAgdG8gdGhlDQpmdW5jdGlvbiBwb2ludGVy
IG9yIHNvbWV0aGluZy4gSXQncyBub3Qgc3VwcG9zZWQgdG8gcmV0dXJuLiBJZiBpdCBpcyBhY3R1
YWxseQ0Kbm90IGFuIGlzc3VlIGR1ZSBmb3Jlc2VlYWJsZSBsYWNrIG9mIHJlYWwgd29ybGQgSFcv
ZmlybXdhcmUsIGEgY29tbWVudCB3b3VsZCBiZQ0KbmljZSB0b3VjaC4NCg0KT2ssIHdlbGwgYmFz
ZWQgb24geW91ciBlYXJsaWVyIHBvaW50LCB0aGUgbmV3IGNvZGUgYWN0dWFsbHkgZG9lc24ndCBt
YWtlIHRoaW5ncw0Kd29yc2UgZm9yIFNNRS4gRm9yIFREWCB0aGUgbGF0ZSBmdW5jdGlvbiBjYWxs
cyBhcmUgbm90IGEgcHJvYmxlbS4gU28gd2UnbGwgbGVhdmUNCml0IHRvIHlvdSBndXlzLg0KDQpU
aGFua3MgZm9yIHJlc3BvbmRpbmcgc28gcXVpY2tseS4NCg==

