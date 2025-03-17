Return-Path: <linux-kernel+bounces-563226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3B8A63A01
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2AC188E2D9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 01:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAC54EB38;
	Mon, 17 Mar 2025 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="byxmmYCc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A49475
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 01:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742174408; cv=fail; b=jIUw2tsufuLFvVklAoJk/7SjTJb/CYt1jJQWj8XD0dtc7kxhEij0YPGhcnqwuFlQZu3aNFj1C4QyiqStY9BmJZRe4xt7iy5E21MvU2RZvHpX63/HTpNu9+IeCvNw2GMHZjCXdQ27nxVjboOuzE5eqC6wJSETPA5kDG/ydXLsWPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742174408; c=relaxed/simple;
	bh=vN2f4WhnLYiNqIHididqhpe7lklVZkUU5qPDUEoatdo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cgqMNvfRgwnm3wSaomD1mzsja/sFCIDLnQx4+VoSBqvOVenXLgpHJDJfyGZUQ69vPJL48q39bXKnL0x+yU8Zd5q3AFCi/lNwWUI1FWaaqf486kOmzU+cAKO2/sXjZXXtx2+QXRM4viCSD99OTTkxrc9uT7iVty/w5LnEQtOVehA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=byxmmYCc; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742174406; x=1773710406;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vN2f4WhnLYiNqIHididqhpe7lklVZkUU5qPDUEoatdo=;
  b=byxmmYCcwne7hrl7mFbxnLg1739ch7TUJ6caCmiYK+GbJuY9NyxSfBGt
   ky0J+r/GelBbvWSOitYOJylk7CkS5LTgiTpw11R8z9fxZOuF/dCqIM+Sb
   8vcwIkN+ZHLd/gK28//1S66Xb3E3siT0C+ihvoOdjkhpnqL/QBBENntrp
   0SXlKcpuCq0kPoAKkfV1rjMlEv5zx5GeWIpRw/xmgtMBATqpn39FNVFvI
   jqGU8uhCNEMEFAjT9GnSxiqC/2d00siL+T0xgTG/fcUtiPLiMo0ytr5TT
   hk8EVkZDUzwHpPbt4XbzjwR9vmNBBZoSTkaXcLxQ20HUfCD4hxgzuK6F+
   Q==;
X-CSE-ConnectionGUID: 9qKV9XbuSrKHMeB3McM4JA==
X-CSE-MsgGUID: UzTjv+6aTE+jbK1f806tRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="60649564"
X-IronPort-AV: E=Sophos;i="6.14,252,1736841600"; 
   d="scan'208";a="60649564"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2025 18:20:01 -0700
X-CSE-ConnectionGUID: s0ic/RVaSb+yLSYNltKA/w==
X-CSE-MsgGUID: Qg5oXQ2ESv6yGNGatOlA+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,252,1736841600"; 
   d="scan'208";a="126877641"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Mar 2025 18:20:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 16 Mar 2025 18:20:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 16 Mar 2025 18:20:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 16 Mar 2025 18:19:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRIUnRmMUqURdIPVubzYlbH8+EPGCe7bcbuto+BVZ+uBkVQPnwh7eWxaPawl9NZioylX3x35m8KunHTFhix4JBev/v4q015uXdmSGX76fuvDkOE7860vGdjpofB2AjAZT+RKDnJA4gck5qictwDqEsKx5LjsVNb/94gJhpbnMRkUDEZcbzFNhnne/k9mqWl3sIN3t99L3qoObJkTnhcXU21jjDU4dNWbqw6mrl7VRuRmxY2juz0v/FZgo6SWyWqJ3x0IOKz92hnHXxdI60tRx2gKwGeWlNXMyWfxF0CchKQGHrzhtGcyO87WBf/MYrpW+MQdgL/gz3pHSdm1vJWX5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vN2f4WhnLYiNqIHididqhpe7lklVZkUU5qPDUEoatdo=;
 b=hZp/HH1+AZO00cifY4qhGJ9dhZ/uxogaGWuFqmT688O1YAESi6lM9UzK87AubpPj0YOyCaBxXqNgfVjL6o7Tv9QPKiGet6oj26z7crhYWmBfl6ecIAflH4GnfRwpf4WOOs+uVoo20mJYYKHB4u00JcRZBiO+4e6kQ6iPLoGW2kfkm6w3y3OJVDmoaE6cNcIYM/Y0dhYmwetYyumdIKT1KlwRe4iBCXf9brs9hwNLc+EJ0/eMnWqMXaR7Oc7CXEGK8Nz/5dmKLc1Ea7OZQJwbqQAtNatScfVSjCo+PLFALxVDYNpESqdgfzHEf40RxaV0fbN17/hPKM3jm8D17hfPVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB7513.namprd11.prod.outlook.com (2603:10b6:510:270::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 01:19:57 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 01:19:57 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"x86@kernel.org" <x86@kernel.org>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "bhe@redhat.com"
	<bhe@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "ashish.kalra@amd.com"
	<ashish.kalra@amd.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>
Subject: Re: [RFC PATCH 3/5] x86/kexec: Disable kexec/kdump on platforms with
 TDX partial write erratum
Thread-Topic: [RFC PATCH 3/5] x86/kexec: Disable kexec/kdump on platforms with
 TDX partial write erratum
Thread-Index: AQHbk0Li0j4hIZraA0O6rldQIQB4e7NwJfwAgAAZWQCAARIBAIAAV9SAgAAEJwCAABOXgIABQD0AgAONsYA=
Date: Mon, 17 Mar 2025 01:19:57 +0000
Message-ID: <912df0c6bd8f42d92ccc11d9fdda1e108576a5e5.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
		 <408103f145360dfa04a41bc836ca2c724f29deb0.1741778537.git.kai.huang@intel.com>
		 <4ac689506269e907774806a484e15171b04ffc63.camel@intel.com>
		 <e1b3da33446178861ca34e61675f184b439101e2.camel@intel.com>
		 <5e736c6d7794b8642d020350e302ead0d6ca13ae.camel@intel.com>
		 <da02e1d5a489526770ec737eac41237226cdb5cd.camel@intel.com>
		 <e7b259b0a986f3cf1578b000f9113933ef80a324.camel@intel.com>
		 <1a6b44f3fb23d0a35bb3c24d755fb2ae6f74b1bb.camel@intel.com>
	 <a6b3a87eba30fdb79423306da538b9c8bb7b8634.camel@intel.com>
In-Reply-To: <a6b3a87eba30fdb79423306da538b9c8bb7b8634.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB7513:EE_
x-ms-office365-filtering-correlation-id: 180a5d01-2458-4e43-86ef-08dd64f1d4cc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cnJURWRyOGE3WjlPaVV0USt1ajB0Vm45bjFXUVZOTE9RNGpJTVFJTHhnUmNk?=
 =?utf-8?B?R3RBUUJ2VGZPazhBZkMxV0NncVBzdXFBSVRkOXYxYTFhVDh0R05PVHozbDly?=
 =?utf-8?B?L1F1cTJsYmRDQXVPYVpUdThPVHdXc2FTOVk2a2RRaTB6dlZhbzVyYjJ2cTJB?=
 =?utf-8?B?UzRHUjRtUkY5WnZpWTNMNm5uNDRObVlsSFlyVDJzR2VGNGZmSkFkWGFzQnQw?=
 =?utf-8?B?N1ZQeXVYTXZ0Q056MUZraTNGRVJub1dRRjZoS2wzMEE0Z1VZblVSVzBQZXpx?=
 =?utf-8?B?UlFSVncxNDE3VytwT3VzNmhuSjJwOTB2R3V5akZOdFIrZE1hejNxSDRzTmRL?=
 =?utf-8?B?emFOM0pCVDhrT3JwbndDZWZvWlR0dEhmNmF1a2oyN1FUR1orZ2w4cXpLdzhW?=
 =?utf-8?B?d25RL08rb2JBZUsrTEUwWDRWdi9UdXdZMzJKbmNIUHdUN0hOZ0I3M2w2djJ1?=
 =?utf-8?B?OVVBbGJUWUp3UDdROTZCbXNQL1lNWlE3RWY3Ris0dC9NcStNN25CNjNNL21D?=
 =?utf-8?B?alNFVVBNYm1NN0R4RmpScXJueE94TmhxbkErcWFZazkwYnR2SENnekx5bDBB?=
 =?utf-8?B?ZThybXBaNWV6N1B2aTgwL2pKL0o5N0tJc1FMQmJlNXJ6QjdHckNKWFpMUERn?=
 =?utf-8?B?UFVEWk9Ka1BaZkNsOVdiSGYvVDRGT0hNTExWOUhERHBWT3hZRlpsSWVhNFpD?=
 =?utf-8?B?dVJWYmZrU3BZalZOb0hnVTB0N2p5RUU2QkJETVBVczY2YzBDNDlncVc3Qm1X?=
 =?utf-8?B?V0NZVW5xL21udjVOZ0ZJYVVkdGlOOEF1YkV1RUF5RzJoeGVTUE9ub1BGZGVO?=
 =?utf-8?B?cUI3QzlyazlROGVobVBuTTI0TzZYeStpTG9VWlJ6aGNRRTJDSStmdUlvRW8w?=
 =?utf-8?B?YXVFYjV1UnBrK1BrUytKSGsyUUNOVS9POGJsZCtMb1RWWklFbkRPK2NGSTdT?=
 =?utf-8?B?SFJDdmw4OW5sdGtYa0JhRjBFWWhzVlRXZWt2dnJoN1NaRTVYd2I2SnhORzlw?=
 =?utf-8?B?c1BneTVRNkphU09WaUNWVDlqeUp3dmFlTHpzd1hwL0U1WkJiaU4wQWRhdVNl?=
 =?utf-8?B?cWJkcmU2WU5MSUVkSHlueXFvOVlqaHovK0ZyUVIyR0lKL0FtblZyMlRzZHhs?=
 =?utf-8?B?SW1rbFNSTFpaTGdlYy9Oajdhc2s4c0dyNnNQTzJid014akhONitUaDBpc3Ry?=
 =?utf-8?B?clJ0VGgyOE9ldmF5cTRqcHhZSGV4dGFXeGJrZ0ZNRno2N29mRWIvQ0FOVUpT?=
 =?utf-8?B?Q3JmbDVBQXIxOGlINytzSEk0dSs2Q05oMnFKL0svOStncStzYnFNTU9JQXJh?=
 =?utf-8?B?K2t0aGNDU21zNTlZNmlPOG8xbndObGlCdSs1cENGZ285WE9lU0x5dmYrUXcx?=
 =?utf-8?B?UEV2Zkg1NS96U3lPb1pIUUFxd2NiM3Z3M2x6NzhkdWVZNWpCRHcrODhGZUtS?=
 =?utf-8?B?U2RwTWlDcVVwN1lsRHdhZXpreGQzR0RSaFovMjNwRkovV2ZRVXdhWVB4UExW?=
 =?utf-8?B?Qi9RMnhMV1VTclJDWmNSc01kK1NBSUFCRHcrMENwd1hRWW9oNzlXVzRYSGx3?=
 =?utf-8?B?clIySmowb0VwUnE3eW1weFE5bUU3bktkR3FHL0dORGNrci90aXFoaUk5QkUr?=
 =?utf-8?B?U21tRlNJcTRYUW9uMDRnZnRzQWZhamhTN0NrSFd4WVFTTFd5YVBzRXRQTXFS?=
 =?utf-8?B?eU1YWm1XWnJkdTVLZGFnRXRvY0UvYVdKa1VONStndWFiQmdtM1hnZ2JWZWho?=
 =?utf-8?B?aWJjU1ZwUXJ0WUdDUzJzYkpLNEdlZ1g4c3dwVlYxaWRGbjcza3RUc2drZWdu?=
 =?utf-8?B?SWlQTlJDSU1zY1g5VWlJTEZpY0FUMGxkVFdZNFlnajAwbExURmo5ekgweHdS?=
 =?utf-8?B?UWI4bGMxSU5jaVkrVEE4MzNUQzNpVEhPd29zdGs2TnFlM2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TndNK25kckNaajgxUU9vandqbmxZRWRiUWNLRmtFc0x2WEhBdG1PZkROTm1I?=
 =?utf-8?B?a0I0UjgyZGp5ejcya2tmbDZyWWpsZkx6SGNIMjdoeFpoSVdKTXovcGEzWUhi?=
 =?utf-8?B?ZitWZVZueXdqQ04zZWVrRlpBMnBWZkh6UzUwSU92d1F6TVl3MGdNZUttNTZj?=
 =?utf-8?B?Rjh5K3JyMzVtT2hEd0hrVXFkVHMwYUlLWit5RDU1ck5qU0tYVXM0Y0l5ZG0r?=
 =?utf-8?B?MWVGWXFiWWpZbWN1VVpGbHFVQnRRT1hsQTV5MStXS040cVY2bVJici9FaVZZ?=
 =?utf-8?B?VzFyL2pvV1cyMlZUQkdoZHpKSU9VRHFpUGxhWE12YkRvMkZ3WWhPS1NjL2tz?=
 =?utf-8?B?SVpTK0JGdGp0M3ZJWVNWbkVvOW5QNHhMY0FySTIvSVhEaWp1bVllRGgvcW1U?=
 =?utf-8?B?VEFGd3d1R1JYaVBGcUJpSkN3S0g5LzJFdnRpMDZ2Q1RWSDREMWlFQStybUQx?=
 =?utf-8?B?NFlqOHIyS1lWS0J3UDd0K1AvZUhqTGpBM3dKWXQ0WXpZME5sOXhkd1ZYR1Jz?=
 =?utf-8?B?VWpDK0wvSG5VSjBvWjE4L2xMclNtUWx6Ym92Q3c5cGRYaVJEVkUrbHJoOGxx?=
 =?utf-8?B?MFB1OEhtNU1jdzB1WHZ2UyswMndUNmRadGxZc2EyRzM4SlV2L3l2SHU3K2dR?=
 =?utf-8?B?Y2JmM0RlL0xkM0RrZFcyK0F5MWxZaDZ1Z0x1Z3dxcmZZcmRaUEU5MjBJcXU2?=
 =?utf-8?B?NXFtckRRYy9FL2lKVWhRMTlmRm5sK3kyRDVPSHFPQ1hjdDBMemtKZTA1WWlw?=
 =?utf-8?B?TGExWEFLTEgwWXNqbEpYTmN3MkE5UGwyOFR1RzlJTlFsKzFnalFYU2h1VU9o?=
 =?utf-8?B?N0UxTERTOHowU3dteVc2VlZBcHBiWkVIN1pSMm4rQVV2QjhiZGRTWmhDR2kz?=
 =?utf-8?B?cFFwaUVwclBFd3YxRGJNamhXN1FtTGo2a3dkY0VsNEMvNjZNem1DOGhEME14?=
 =?utf-8?B?d2RlMFFHUjFnTFp1RU55S09TNEhCR0EyQURBczFiQjZZZ0pLZkMzQ3ZGeWFG?=
 =?utf-8?B?OEZTem5rVG0zWGU1MERvZi9mbzI3c3NkVGhQcWcvRGxoemQ1cXJrcWxZOXcw?=
 =?utf-8?B?REhjdkJsQlpiRlh6Vml4T1YyQitUMXRZNWZuaDBYQ0hhS2FReXBBUUNuL2hM?=
 =?utf-8?B?R0pOcUUrMG90c0IwZzAveXJITW5tVVJOMmtRS1Q4aFk0VElaRnFJZGJTM0R0?=
 =?utf-8?B?RmJGYzExcit0MjY0MkJhZVBlU2pDQmhPa2gvN0FLYmRXK21TcnRPSGxnZUo3?=
 =?utf-8?B?RGFxdWlxTUF0NTg3b2ttSVE4YU40ekxSaVFGSmlnMTRRaUFWbzRCOTZHK2Z3?=
 =?utf-8?B?ZzNjbndkMit4OExBWmp6LzdhR3ZLRG1BcTl6N2hwY2tyYitxMVZmMnNsTHBC?=
 =?utf-8?B?TEM0MmFvYjBLSUJqT2xKSGgwK0t0Nnc3UEtXVUt4STZOSmlGSVplRXVrRjRp?=
 =?utf-8?B?U1k0ZG12dkNDS3FuV0F6eVl6Q1JuQmhFZkJOVTRWV0JxQ0pxbVBmTzJNRlV4?=
 =?utf-8?B?dHk0dlFhcENLVlJycVNRSXJMaCtNTlBqenpkT0JTR0JFeEZMOTU4MkljZU1Z?=
 =?utf-8?B?ZlFTSWxKNFVLRkl4SFlvWTVwN3pUS2crdU1Kd01aZDk4d0EvTVRkL2JyWDJv?=
 =?utf-8?B?NHB4cVpscVhhbkg2aUtOQlE4OWNrZVZiZTR1TGF5NkdaNWtOSmhyVjM5RVR1?=
 =?utf-8?B?QjNSc3NJck12cExsR3JOS3E1NGFzb0RwSmcxOUIvZVBWT291NjluNEh4T2Fi?=
 =?utf-8?B?OWFsNm9OU01zMkEvZlJHTm92RXk5T0xqRjZTUjlDRmJ3REtIaTAySHJHVjg0?=
 =?utf-8?B?QkdtZ0t4bmhpYlNUdHVCTDl6QUtFWUNQNzdDQ2FPbXJDWGh1U0wyQkdYZk5L?=
 =?utf-8?B?N2RBeDI5U0s1Y3ZhWG1EdkhLR3I1dWVkUUkzQndTOXZpalRnTnJlU0FWZXRx?=
 =?utf-8?B?Tzg1a3JPTDUyc2taWFNPNGxKOExFeUtmVWdQSFIrOUNZVXlueUl2SGdYUkE4?=
 =?utf-8?B?NTZkbG9MZkVOczJaQjNHVVE3dzdSMEo5aTIxUkMvUzVpWkMvVEdFTGtaQmlB?=
 =?utf-8?B?b2pwQmpFOXE1K3ZuZytCek1EQjZzaEtrUmtDMDlac3hZVjc2aDdMQ1BWY3Rj?=
 =?utf-8?Q?8SDfakKgPz0WFvR9o2uG8UnbF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB87C322BD385742B58503D86F08A547@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180a5d01-2458-4e43-86ef-08dd64f1d4cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 01:19:57.6121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0Z24XEpUOPSYwzaH4frIWaiFzPrvQXiGzj8TxGQEtU2DfcYV2bC4Fb+lB4h+PDoKKt13x/OvUWuAzDD7uGpQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7513
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTAzLTE0IGF0IDE5OjAzICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gT24gVGh1LCAyMDI1LTAzLTEzIGF0IDIzOjU3ICswMDAwLCBIdWFuZywgS2FpIHdyb3Rl
Og0KPiA+ID4gU28gdGhpcyB3aWxsIHN3aXRjaCBhbGwgb2YgVERYIHRvIGJlIGRlZmF1bHQgb2Zm
IHRoZW4sIHVubGVzcyB0aGUga2VybmVsDQo+ID4gPiBnZXRzIGENCj4gPiA+IHBhcmFtZXRlciBz
ZXQuwqANCj4gPiA+IA0KPiA+IA0KPiA+IEN1cnJlbnRseSBpbiBLVk0gVERYIGlzIGFsc28gZGVm
YXVsdCBvZmYuDQo+IA0KPiBHb29kIHBvaW50LiBJdCBiZWdzIHRoZSBxdWVzdGlvbiBvZiBob3cg
bWFueSBjb21tYW5kIGxpbmUgb3B0aW9ucyB0aGUgdXNlcg0KPiBzaG91bGQgaGF2ZSB0byBwYXNz
IHRvIGVuYWJsZSBURFguDQo+IA0KPiA+IA0KPiA+ID4gSW4gd2hpY2ggY2FzZSB3ZSBjb3VsZCBh
bHNvIGp1c3QgdW5sb2NrIHRoZSBLY29uZmlnIHdpdGgganVzdCBvbmUNCj4gPiA+IHNtYWxsIGNo
YW5nZS4gVERYIGFuZCBrZXhlYyB3b3VsZCBzdGlsbCBtdXR1YWxseSBleGNsdXNpdmUsIGJ1dCBq
dXN0IGF0DQo+ID4gPiBydW50aW1lLg0KPiA+IA0KPiA+IFllYWggSSBhbSB0aGlua2luZyB0aGlz
IHRvbywgZ2l2ZW4gdGhlICJrZXlJRCAwIGludGVncml0eSIgdGhpbmcgYXJlIHN0aWxsIG9uLQ0K
PiA+IGdvaW5nLg0KPiANCj4gWW91IG1lbnRpb25lZCBvZmZsaW5lIHRoYXQgdGhlcmUgdXNlZCB0
byBiZSBhIGNvbW1hbmQgbGluZSBvcHRpb24sIGJ1dCBpdCB3YXMNCj4gcmVtb3ZlZCBhZnRlciBk
aXNjdXNzaW9uIHdpdGggRGF2ZS4gSSB3ZW50IHRvIGxvb2sgZm9yIGl0IGFuZCBvbmx5IGZvdW5k
IHRoaXM6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvN2U2MzkxMmEtODk1Zi1kM2Iz
LTMxNzMtMzM2YmVhYTg2ZDA4QGludGVsLmNvbS8NCj4gDQo+IC4uLndoZXJlIERhdmUganVzdCBh
c2tzIHdoeSBpdCdzIG5lZWRlZC4gSW4gdGhlIG5leHQgdmVyc2lvbiBpdCdzIGRyb3BwZWQuDQo+
IFVubGVzcyB0aGVyZSBpcyBhbnl0aGluZyBtb3JlLCBpdCBkb2Vzbid0IHNlZW0gbGlrZSB0aGVy
ZSB3YXMgcmVhbGx5IGFueQ0KPiBvYmplY3Rpb24uDQoNClRoYW5rcyBmb3IgZGlnZ2luZy4gOi0p
DQoNCkkgY291bGRuJ3QgZmluZCBhbnkgc29saWQgcmVhc29uIHRvIGFyZ3VlIGFnYWluc3QgRGF2
ZSBzbyBJIGp1c3QgZHJvcHBlZCBpdC4gIEkNCmNvdWxkIGFyZ3VlIHRoYXQgInRoaXMgYWxsb3dz
IHBlb3BsZSB0byBkaXNhYmxlIFREWCBvbmNlIGZvciBhbGwiIGJ1dCBpdCB3YXMgbm90DQpzb21l
dGhpbmcgbWFuZGF0b3J5IGF0IHRoYXQgdGltZS4NCg0KPiANCj4gPiANCj4gPiA+IFdlIHNob3Vs
ZCB0cnkgdG8gZmxhZyBQYW9sbyBhbmQgc2VlIHdoYXQgaGUgdGhpbmtzLg0KPiA+IA0KPiA+IEkg
YXBwcmVjaWF0ZSBpZiB5b3UgY291bGQgaGVscCB0byBkby4NCj4gPiANCj4gPiA+IA0KPiA+ID4g
T3IgaXMgdGhlIHByb3Bvc2FsIHRvIG9ubHkgYmUgZGVmYXVsdCB0ZHhfaG9zdD1vZmYgb24gdGhl
IGVycmF0YSBwbGF0Zm9ybXM/DQo+ID4gPiBBbmQNCj4gPiA+IHRkeF9ob3N0PW9uIG90aGVyd2lz
ZT8NCj4gPiANCj4gPiBUaGUgdHJpY2t5IHRoaW5nIGlzLCBuYXR1cmFsbHksIHdlIHdhbnQgdG8g
c2tpcCBhbGwgdGhlIGNvZGUgaW4gdGR4X2luaXQoKSBpZg0KPiA+IHRkeF9ob3N0PW9mZiwgYmVj
YXVzZSB0aGVyZSdzIG5vIHJlYXNvbiB0byBkbyB0aG9zZSBkZXRlY3Rpb24vaW5pdGlhbGl6YXRp
b24NCj4gPiBpZg0KPiA+IHdlIGFyZSBub3QgZ29pbmcgdG8gdXNlIFREWCwgZS5nLiwgd2UgZG9u
J3QgbmVlZCB0byB0aGlzIG9uZToNCj4gPiANCj4gPiAJcmVnaXN0ZXJfbWVtb3J5X25vdGlmaWVy
KCZ0ZHhfbWVtb3J5X25iKTsNCj4gPiANCj4gPiAuLiB0aGF0IG1lYW5zIHRoZSBjb2RlIG9mIGRl
dGVjdGluZyBlcnJhdHVtIHdpbGwgYmUgc2tpcHBlZCB0b28uDQo+ID4gDQo+ID4gSWYgd2Ugb25s
eSB0byBvbmx5IG1ha2UgdGR4X2hvc3Q9b2ZmIGFzIGRlZmF1bHQgZm9yIGVycmF0dW0gcGxhdGZv
cm1zLCB0aGVuIHdlDQo+ID4gbmVlZCB0byBkbyBjbGVhbnVwIChlLmcuLCB0byB1bnJlZ2lzdGVy
IHRoZSBhYm92ZSBtZW1vcnkgbm90aWZpZXIpLg0KPiANCj4gVGhpcyBpcyBhIHN0cmFuZ2UgcG9p
bnQuIFRoZSBlcnJhdGEgZGV0ZWN0aW9uIGlzIG5vdCBkZXBlbmRlbnQgb24gdGhlIGVhcmxpZXIN
Cj4gY29kZSBpbiBURFggaW5pdC4gSXQgY291bGRuJ3QganVzdCBiZSBtb3ZlZD8NCg0KU29ycnkg
SSBkb24ndCBxdWl0ZSBmb2xsb3cgeW91ciBwb2ludCwgYnV0IHNlZW1zIHlvdSBhZ3JlZWQgaXQn
cyBub3QgYSBnb29kDQppZGVhLg0KDQo+IA0KPiA+IA0KPiA+IFRoaXMgaXNuJ3QgbmljZSBhbmQg
c2VlbXMgaGFja3kuDQo+ID4gDQo+ID4gSSBkb24ndCBzZWUgbWFraW5nIHRkeF9ob3N0PW9mZiBh
cyBkZWZhdWx0IGhhcyBwcm9ibGVtLCBhbnl3YXksIGFzIG1lbnRpb25lZA0KPiA+IGFib3ZlIFRE
WCBpcyBvZmYgYnkgZGVmYXVsdCBpbiBLVk0uDQo+IA0KPiBZZWEsIHRkeF9ob3N0PSFlcnJhdGEg
YXMgYSBkZWZhdWx0IHZhbHVlIG1ha2VzIGl0IG1vcmUgY29tcGxpY2F0ZWQuDQoNClllcy4NCg0K
PiANCj4gDQo+IFNvIEkgdGhpbmsgdGhlIHNpdHVhdGlvbiBpcyB3ZSBuZWVkIGF0IG9uZSBrZXJu
ZWwgcGFyYW1ldGVyLiBXZSBhbHJlYWR5IGhhdmUgb25lDQo+IGZvciBLVk0sIHdoaWNoIGNvbnRy
b2xzIHRoZSBsYXRlIGluaXRpYWxpemF0aW9uIHBhcnRzIG9mIFREWCB0aGF0IHdlIGNhcmUgYWJv
dXQNCj4gaGVyZS4gU28gd2hhdCBhYm91dCBqdXN0IHVzaW5nIHRoZSBleGlzdGluZyBvbmU/IEkg
dGhpbmsgd2UgZG9uJ3Qgd2FudCB0d28uDQoNCkxvZ2ljYWxseSwgS1ZNIGlzIG9uZSB1c2VyIG9m
IFREWC4gIEkgdGhpbmsgd2hldGhlciBLVk0gaGFzIGEgcGFyYW1ldGVyIHNob3VsZA0Kbm90IGlt
cGFjdCB3aGV0aGVyIHdlIHNob3VsZCBpbnRyb2R1Y2Ugb25lIGtlcm5lbCBwYXJhbWV0ZXIgZm9y
IFREWCBob3N0IGNvcmUtDQprZXJuZWwuDQoNCkRhbiBhbHNvIG1hZGUgYSBwb2ludCB0aGF0IGlu
IHRoZSBjb250ZXh0IG9mIFREWCBDb25uZWN0LCB0aGVyZSdzIHJlcXVpcmVtZW50IHRvDQptYWtl
IFNFQU1DQUxMcyBldmVuIEtWTSBpcyBub3QgZ29pbmcgdG8gcnVuIGFueSBURFggZ3Vlc3Q6DQoN
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS9jb3Zlci4xNzMwMTIwODgxLmdpdC5rYWkuaHVh
bmdAaW50ZWwuY29tL1QvI202OTI4ZjU1MTlkZTI1ZGVmOTdkNDdmYzZiYmI3N2Y1YzNlOTU4Zjdi
DQoNClNvIEkgYWdyZWUgaWRlYWxseSB3ZSBkb24ndCB3YW50IHR3bywgYnV0IEkgdGhpbmsgaXQg
aXMgYWxzbyBPSyBpZiB0aGVyZSdzIGdvb2QNCnJlYXNvbiB0byBkbyBzby4NCg0KPiANCj4gSWYg
S1ZNIGhhcyBub3QgaW5pdGlhbGl6ZWQgVERYIChiYXNlZCBvbiBpdHMgb3duIFREWCBwYXJhbWV0
ZXIpLCB0aGVuIGtleGVjIGlzDQo+IGZpbmUuwqANCj4gDQoNCkZvciBub3cuICBJbiB0aGUgZnV0
dXJlIFREWCBtb2R1bGUgY291bGQgYmUgaW5pdGlhbGl6ZWQgYnkgb3RoZXIga2VybmVsDQpjb21w
b25lbnRzLg0KDQo+IEl0IGNvdWxkIHdvcmsgYnkgZXhwb3NpbmcgYW4gaW50ZXJmYWNlIGZvciBm
ZWF0dXJlcyB0byBiZSBleGNsdXNpdmUgd2l0aA0KPiBURFguwqBTaW5jZSByZWFsIFREWCBtb2R1
bGUgaW5pdGlhbGl6YXRpb24gaGFwcGVucyBsYXRlIGFueXdheS4gSSBkb24ndCBrbm93IGlmDQo+
IGl0J3MgYmV0dGVyIHRoYW4gYSBrZXJuZWwgb25lLCBidXQgSSBkb24ndCBzZWUgYWRkaW5nIGEg
c2Vjb25kIG9uZSBnb2luZyB3ZWxsLg0KPiANCj4gDQo+IFZlcnksIHZlcnkgcm91Z2g6DQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL21hY2hpbmVfa2V4ZWNfNjQuYw0KPiBiL2Fy
Y2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMNCj4gaW5kZXggYTY4ZjVhMGE5ZjM3Li5i
ZmVhNGU3OGM1NzcgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVj
XzY0LmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL21hY2hpbmVfa2V4ZWNfNjQuYw0KPiBAQCAt
MzE1LDYgKzMxNSwxMiBAQCBpbnQgbWFjaGluZV9rZXhlY19wcmVwYXJlKHN0cnVjdCBraW1hZ2Ug
KmltYWdlKQ0KPiAgICAgICAgIHJlc3VsdCA9IGluaXRfcGd0YWJsZShpbWFnZSwgX19wYShjb250
cm9sX3BhZ2UpKTsNCj4gICAgICAgICBpZiAocmVzdWx0KQ0KPiAgICAgICAgICAgICAgICAgcmV0
dXJuIHJlc3VsdDsNCj4gKw0KPiArICAgICAgIGlmICh0ZHhfZXhjbHVkZV9mZWF0dXJlKCkpIHsN
Cj4gKyAgICAgICAgICAgICAgIHByX2luZm9fb25jZSgiTm90IGFsbG93ZWQgb25jZSBURFggaGFz
IGJlZW4gdXNlZC5cbiIpOw0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOw0K
PiArICAgICAgIH0NCj4gKw0KPiAgICAgICAgIGtleGVjX3ZhX2NvbnRyb2xfcGFnZSA9ICh1bnNp
Z25lZCBsb25nKWNvbnRyb2xfcGFnZTsNCj4gICAgICAgICBrZXhlY19wYV90YWJsZV9wYWdlID0g
KHVuc2lnbmVkIGxvbmcpX19wYShpbWFnZS0+YXJjaC5wZ2QpOw0KPiAgDQo+IGRpZmYgLS1naXQg
YS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4
LmMNCj4gaW5kZXggZjVlMmE5MzdjMWU3Li45YjFmNDJhMTA1OWMgMTAwNjQ0DQo+IC0tLSBhL2Fy
Y2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYw0KPiArKysgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgv
dGR4LmMNCj4gQEAgLTEyMTUsNiArMTIxNSwyMSBAQCBpbnQgdGR4X2VuYWJsZSh2b2lkKQ0KPiAg
fQ0KPiAgRVhQT1JUX1NZTUJPTF9HUEwodGR4X2VuYWJsZSk7DQo+ICANCj4gK2Jvb2wgdGR4X2V4
Y2x1ZGVfZmVhdHVyZSh2b2lkKQ0KPiArew0KPiArICAgICAgIGJvb2wgcmV0ID0gZmFsc2U7DQo+
ICsNCj4gKyAgICAgICBtdXRleF9sb2NrKCZ0ZHhfbW9kdWxlX2xvY2spOw0KPiArICAgICAgIGlm
ICh0ZHhfbW9kdWxlX3N0YXR1cyA9PSBURFhfTU9EVUxFX0lOSVRJQUxJWkVEKQ0KPiArICAgICAg
ICAgICAgICAgcmV0ID0gdHJ1ZTsNCj4gKyAgICAgICBlbHNlDQo+ICsgICAgICAgICAgICAgICB0
ZHhfbW9kdWxlX3N0YXR1cyA9IFREWF9NT0RVTEVfRVhDTFVERUQ7DQo+ICsgICAgICAgbXV0ZXhf
bG9jaygmdGR4X21vZHVsZV9sb2NrKTsNCj4gKw0KPiArICAgICAgIHJldHVybiByZXQ7DQo+ICt9
DQoNCkFzc3VtaW5nIHNldHRpbmcgbW9kdWxlIHN0YXR1cyB0byAiZXhjbHVkZWQiIG1lYW5zIHdl
IGFyZSBub3QgYWJsZSB0byBpbml0aWFsaXplDQpURFggbW9kdWxlIGZvciBldmVyLg0KDQpUaGUg
dGhpbmcgaXMgS2V4ZWMgaGFzIHR3byBwaGFzZXM6IDEpIGxvYWRpbmcga2VybmVsIGltYWdlLCBh
bmQgMikgYWN0dWFsbHkgZG8NCmtleGVjLiAgWW91ciBhcHByb2FjaCBiYXNpY2FsbHkgbWFya3Mg
VERYIHVudXNhYmxlIGZvciBldmVyIHdoZW4gYSB1c2VyIHRyaWVzIHRvDQpsb2FkIGEga3hlYyBr
ZXJuZWwgaW1hZ2UsIGJ1dCB0aGlzIGlzIGEgbGl0dGxlIGJpdCBuYXN0eSBiZWNhdXNlIGxvYWRp
bmcga2V4ZWMNCmtlcm5lbCBpbWFnZSBzdWNjZXNzZnVsbHkgZG9lc24ndCBtZWFuIHlvdSBoYXZl
IHRvIGFjdHVhbGx5IGRvIHRoZSBrZXhlYywgaS5lLiwNCnlvdSBjYW4gdW5sb2FkIHRoZSBpbWFn
ZSBhbmQgbW92ZSBvbi4NCg0KSSBhbSBub3Qgc2F5aW5nIHRoaXMgZG9lc24ndCB3b3JrLCBidXQg
SU1ITyBpdCBpcyBtb3JlIHN0cmFpZ2h0Zm9yd2FyZCB0byBqdXN0DQpsZXQgdXNlciBtYWtlIGRl
Y2lzaW9uIHZpYSBrZXJuZWwgcGFyYW1ldGVyLg0K

