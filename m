Return-Path: <linux-kernel+bounces-433268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8379E55C8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BF91883E08
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCCB218ABF;
	Thu,  5 Dec 2024 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MqzS0CvU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EC21D5CEA
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733402764; cv=fail; b=LdFp1zFEySdEtfA5fOtYUGFLVtErIdns9sG2UfN27tnMmOM+4Ub6iThdNB5JcQ7R4N9XrOoG6hiYEER2NjS1F1uoUKF/GiX2qgs4wGXG51TEZh3oAzPjSyZzE7x2pfsgLFTynoQow405NUoBX+2DsyC9m0HfXecZPR0yITJNHWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733402764; c=relaxed/simple;
	bh=uxhGCEDK6rAPgQruwOZ4b9L7uVPkKfMR4SzrX00Vrvk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FIebFefSZRHGeu83Dqx1UEktMKQBkoAVEvipwyxeOg8ZfzVvBmQ3Ar1yJUXi5aL3Tf10H2YSiKbhxn94OJKYxCTzps3qkIECntZAHU5Y1Bh8Mf+bubeKZRGfFKbALCmdHWGr/AYjWJKrx7zNZ8c2Zc3lw3zJihHjyM/HZe209+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MqzS0CvU; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733402761; x=1764938761;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uxhGCEDK6rAPgQruwOZ4b9L7uVPkKfMR4SzrX00Vrvk=;
  b=MqzS0CvUMf665klSVy4wVd5suTK9nbCuI2mxrW+bFrA11tBpfIerq3TT
   Hxb5F99WDo0sHAb4Ly0duAlvr1ghpfuyrfWKXIGyckaAkQ6CwVwV5pSYV
   cJXQus1UggkNNeb4pmlWjgv84nyM8hLVCGVFXEZt4Tm+TRgJsr2GoPuSp
   xZ3JhVtvkP3VRBXIcxmCxkgy/w54npKYNBU4wO7RyZjRLAa6CgWvI/tWp
   mG724bNdEmoxH6ZbWW/sddMoCMVIlNpf/ymMHtfY1S/heBKM+6/eGhiYB
   ytruQikeypvy43sTzo3ELRYznnTFqzi+LpCuzxQPONAOjD0FdDV2RKrSn
   g==;
X-CSE-ConnectionGUID: qCfoYlWjQRuA7KJ+f3l+3g==
X-CSE-MsgGUID: sCD7K515RgKs+cFrtdWXNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33065518"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="33065518"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 04:46:00 -0800
X-CSE-ConnectionGUID: JQLI/oLCR26mOJfLJ+bYTQ==
X-CSE-MsgGUID: TuXK52yfSPqfAvkWsk2Ngw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="94164475"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 04:46:00 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 04:46:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 04:46:00 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 04:45:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzFe0gKl4my6y7urNZjBJXV2FncoSuAbOVBMOg1YUeOsTC03G3NPeYJImLJY+He/76oI/aEk/w/SiIeSQcWKM/fe7vNMWLnzIjoq6BVed6DyDiF5i8QOeWbP7+Xur9YhRWevFy4hUkWLF+bbfmrMzuytIvcu0yaOjnfWGN1vUWIHrrME5Ubh0bUpqKVPj/CtMNJ/WBlpvu4BAeF84RsMcWnW7pX/bbMUCiaTzte6wwn5PH1BhpSp2368aS6Jhu7VCuPBBrpMcNhuKofbeB0B8wJGTBLKvvVe84XFibu1vgBP3pQCLCoePsCe9EWWngbmz6St9ZLIOpCGeIpNA1n9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxhGCEDK6rAPgQruwOZ4b9L7uVPkKfMR4SzrX00Vrvk=;
 b=TvYiy9XGoL6HraWKUJADbXCFEIDcISd29wNBy2GDu/9Up9srpg6s3s1XNuuw2vy6B/ssOnE6QrdmSC6JtvknURl0wIFzYvK433Fbg8dfIMk3dHmziHEFa6kClNu+mk4mfw3NiKN3QSVpj96VEQl+Hgvm9YwfpBJJcYHg8hZfts1AvBwcHleAY43300Xz3md07y8i02/EjiFAuba9VVu35IGm56PH8n1GAKT2ktrUzYO1uRN9RX3Vop91eKdxIQ8g/WOh0uYENafKos+AwX8GNU6qDQpO21fOLnVuxf6koeVjYF1SCciqR3RjA7Daa8jP9r3WtlktSsSaah1ias+e9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB5778.namprd11.prod.outlook.com (2603:10b6:806:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 12:45:52 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 12:45:51 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>
CC: "Yamahata, Isaku" <isaku.yamahata@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Edgecombe,
 Rick P" <rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v8 8/9] x86/virt/tdx: Reduce TDMR's reserved areas by
 using CMRs to find memory holes
Thread-Topic: [PATCH v8 8/9] x86/virt/tdx: Reduce TDMR's reserved areas by
 using CMRs to find memory holes
Thread-Index: AQHbNcNRlNQ0Lob1fE++s9mJJDFOE7LWRFWAgAF3WQA=
Date: Thu, 5 Dec 2024 12:45:51 +0000
Message-ID: <14ddb7fb218cd8ebcc9eca869a6f6b922212420b.camel@intel.com>
References: <cover.1731498635.git.kai.huang@intel.com>
		 <23bb421e9bf5443a823e163fb2d899760d9f14a3.1731498635.git.kai.huang@intel.com>
	 <5caabdaf1d7c92cc6cc5f4dc895615fccfa366cb.camel@intel.com>
In-Reply-To: <5caabdaf1d7c92cc6cc5f4dc895615fccfa366cb.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.2 (3.54.2-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB5778:EE_
x-ms-office365-filtering-correlation-id: 1f23f16b-baf1-4726-fb53-08dd152ac089
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?c1ZmOE5BVWhweWlxL3J2bFdKbUhqcjlSeVlrRGRiNU5ESlFIT05jV2RnQ0lJ?=
 =?utf-8?B?Mkg3eCtFRlI2R3orSnlvVHVXM0ZGTTFBakZYTmRiN082eDEyY0cxajVVM2kx?=
 =?utf-8?B?YmJpRzJkVW9OcndzTnVlVnJtYlVZYzY0cjdqK0FBektEbUZZOEZOR1JXYlFB?=
 =?utf-8?B?V0JHOTV1L2tPYmZFQ2xKOUFOdXh3aExhaWN3eCtCYlMwMXV0ek5tUHYxUFZj?=
 =?utf-8?B?THBaSXFmVkJQVUdMVVNldFMycXdpejdjcmxxRkM5UEhOVE1HV2V5a2MvZ3Qw?=
 =?utf-8?B?UGtFdFNQa2RHL3BRakpqNWZTbSt5aFJoSks4Qi9qWEF5TytXekxmZUF2dldF?=
 =?utf-8?B?N3NLdUE4Z281QzNEZEd5YXBXcTd5V2hMNHhPUzBHL1BSUWR4WkhqdWxhcTVl?=
 =?utf-8?B?R1dXVng1aFRvN0p6d0xEVmFZMEhPVkg2dnhleTBsVE9ocXFjanhXYnFuYlRG?=
 =?utf-8?B?RURNd1pVYUQ1cE5CcjY4K3JSMnpCSmFJVXo4T0dxaEVYQWxFckNKSGdPWFht?=
 =?utf-8?B?YTB0Uk9wOW5KdWNWbXk2N052SDVXcXRmVTk4aDJKYzNKc3c1QXB0WDZMMFB1?=
 =?utf-8?B?YWhlWTFJT2tkK0t0TGdOajc4VHlRQVI0di9IRmhGMWFGZnZNQlBmZTlWSER0?=
 =?utf-8?B?T1Znc3Q3U3ZmSmxDZDJleHZ6UkM0Y2ZBcmd1WnBzZjNUWWJxZ0tHdG5oQ3VC?=
 =?utf-8?B?dW1EMGplMllHZnY5dUNJTjVLd0ZEUXluN25meXUzU09MbDRWNDFKdENxQklT?=
 =?utf-8?B?UEYwQlN4Q09NYStUVmxpVHh0MS9JMnFnM1djZEFjTVQ5c0pwc2RDNnQ1R2FL?=
 =?utf-8?B?b0Z5WUtBbTdOWTQ0aUVkcVltcGdVTHMyNjNtciszYXhKRUNFck5TL0E5SW1r?=
 =?utf-8?B?OTk0SGpDV2RRcEJSRytLQjFlVDZUUjdDOGJoamU3cG10cDRhcm1nWWk1czJs?=
 =?utf-8?B?Ums0clJ4cVpmNWx5MDdqdFR6SUp0eXlqS2wxZ3UvR2FWMnVuT0RxSVI2dSsz?=
 =?utf-8?B?akFUSkJ1YWc0eHZoUU5JeDRMUEJHR0FMbDM4T2VIcXJ4cE5UTmlpSHFqQXlF?=
 =?utf-8?B?WXVLa3ZxNjdNblhmdC8rNy9GNDJxUFRBanNIQWZnNXM1anVTRGVLNis4T1ll?=
 =?utf-8?B?cno1WjYvSXlkWUIzU1VrcXhUL0ZMYW1sYnBGRWJ4cFdYVWRLTVRBVzNSY0ZQ?=
 =?utf-8?B?NHZsSFdsYzAzbnkyc28rWDBtdEFLUjNsM294T3o2ejA3RDkrK3Z6ajFxZkpy?=
 =?utf-8?B?VzdIVFJ2UFR6SVdhcHJkWndxVEx3NW1SU25Rck1yWmxkWWhDRXkzdFRSbFl4?=
 =?utf-8?B?RWd6NXlRd0ZmVEpmZUdlOXBKVCt1TS91d1V0MEk3QkhmQS9WdEVWeHZncStO?=
 =?utf-8?B?dGxqNEdaTk5VVzFYT294bDNUaVdoMVFRUE5VcnZBaDNLSG9VR1NFYWthUTVq?=
 =?utf-8?B?UmE2U1BTbWdjaElFd2ZHR0Z2M3dSSitOMFpyQ3J4ZGh4L3JrMnlXK1dBaTZU?=
 =?utf-8?B?dzkrMTBQZkI2MmJMMnRzWTRiTUIwd1lOQVJMQmNPU1RRRXhtVzQvRFJXWVJl?=
 =?utf-8?B?empuL2p3V2VEY2JnZHk2N3ZxVWRoZU9KanpXbEkzRUtzbVJwNjRxWmt6NzNj?=
 =?utf-8?B?ejVyMnEwRkx6MEhDVHZ0L1BCb1h6TVIxUVdZTFBDNzQ3Wmc0VkJZM1h3b0Jp?=
 =?utf-8?B?QW1PSm5ETFVpV0ExdVlWRncwVUpXeUZXMCtrRDVHQ29CWC95RW5KV3RreEVI?=
 =?utf-8?B?WkJQenNYUm0wSisxamJqTHVEN0djYXhTSXdZdFFQMkxmVEJIaFBVaWNHa0wz?=
 =?utf-8?B?R0p3QmxkK3N2d1k0byt1SWtRekNRS1RrQUUyR2h0TEpuRTI2U3p3QzBaYVRD?=
 =?utf-8?B?UEVpamEzWFZNUUZSTmEyZWw3K2FZQTgvQVFKblFMSng0bVFOTTVEMCtUOU1i?=
 =?utf-8?Q?Juij5+nslNY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVpqZXFDOEluTk93Q2Rnd2ZQeG9FYWI2eWdKaERYWkx0YXN1cU9wOEtmWDhw?=
 =?utf-8?B?bzZiNmpuOHFJeHc5cXZla2hkOUMrMHg1TjVUbGpXNEwxWk03TWZiMDhVYmlN?=
 =?utf-8?B?YU9zTnNBTkNLTGJNY2l3RGZGbStjQUNEalFmSUpvV0hjd2I3WXBrR3YySUdV?=
 =?utf-8?B?N2p0TVNZTGpoNGdIalJDdVVFa290dkI2THFJTnByYVZPQVpmbkhqQk1qWktk?=
 =?utf-8?B?bElISHZYcmh0RmZuWEw2Y3BsVExDRjNHVnJUQmlCN1ljYUYyLzAzZmZCbyt3?=
 =?utf-8?B?QkhsSFNPaDYzRWx6RmR1b01TUXlCbDR2YmxvK3ZMZUl6a1hJVDBqTUxsSGpG?=
 =?utf-8?B?UTc0ZmQva1JxK0I4ZmhicUlVa1lFa2NzRkxvZkl5K2tkTVJEREZTQlUwK2JX?=
 =?utf-8?B?cGo3MUhxZTF1cGNZd2poMWZVT3J6M09xNXRZQzdsZEE4T1orcldSSUZDazJo?=
 =?utf-8?B?THIzTlRYTXpWRytReVZyZE9aUy9zNWZHbVJHSmxVVWI5UlJuUjFCMkR4Mnpx?=
 =?utf-8?B?UGNYOEFUREZzUW9GZzNsZVllYjZTVXFLbmkvam81RWZheUtMSjR5WkJ3a3VZ?=
 =?utf-8?B?MldDajRGQ1hicXpUWEdQbFRlcG1lT1pXSHVLTExtbDM2TTRnYmpXaklHVnBL?=
 =?utf-8?B?WlRaKzBzOGMySERQOGU2bmlLdEtKSUh6L05iVzRreGxiZFQ0aHhQeVdyS0xh?=
 =?utf-8?B?cVBwRUI4VGZ3bGRQZnNFMmNEK0I1clNiWkJQMk0rb2xzTFYwM0ZDUUxNMDJR?=
 =?utf-8?B?V0ttYVRjRkJJQ25CbDRqemF0MXlraVdKVjdmZzFzRnRhRGNEdHkzam1YaUJm?=
 =?utf-8?B?SE8vK1RhcjZXUzZMNUtZSnh1clA5eVZXYk92MjJKd05tandPazVRZFA1TWNm?=
 =?utf-8?B?ZXYrazh0VDBIczE1YjlqeXhwQkk1R0doYUdJeEdvMENhVHJMS3ZVeHVwbHFY?=
 =?utf-8?B?dVNBQUo3VURLMTZpa2l5T0R1TXNhZDhlc1AvdFNzVC9ueEY0VVNDeW04Mm52?=
 =?utf-8?B?MTlpc1lqdjNYT2dkMTNYR2FRRHBsRG9xcUI1K2JKRlRqVzlVQzhXcXZZWFp0?=
 =?utf-8?B?K2ZCb1A0TWo1RHoxQnZoUEVtSlYrK25LQkVKcDJSTTRoME05Si82anRrdmcw?=
 =?utf-8?B?OFlpTXIyVEo0QnpsNTZwTzYreTdMOEVrRm9aZjhzRVhBa2g2OGVkWklzNDVn?=
 =?utf-8?B?dGNzajdLdkVFbnZPaExRbVZEdXJvWGZ4NEY5MmtnYjdVQnBtOHZEak4xSVV2?=
 =?utf-8?B?cE1SYTBSY0tySDExK21sVWZWSDNWd3REZVkwWXdySE1hN2VhR3JDcFRXWXJy?=
 =?utf-8?B?bEo3cUlBditZeWljTk9Bc3hsRXlPVmRRclA5eXpvTnN0OUVwakZ5cWhXcXR3?=
 =?utf-8?B?RDYycUhDWEtLbTMvZEVvcmxiMk0xN1hPWUtWSEo4NlNzYmNHdTlCRTZSRWsx?=
 =?utf-8?B?dVF3SEVEL2NPeENoWmtoZXZLOHBVc2ZqNHp1OXVUR2pEdlM1cEI2dmlPUkNF?=
 =?utf-8?B?a01tVFJWd2tWZTg2YlZoYnp1dUsycDZ0Y2VuRGtQZGczWDRPS2QrNVZOSFhy?=
 =?utf-8?B?bzNiTGt2NGFHRTlJa2tTMkRaTElmVmdDUFBsUTZkOWlBd2tPYmk1bVVvNnpq?=
 =?utf-8?B?ZnFKYnk3M1hLVXErWlNqbVV2S0g5WFlqQUNEalBrSHI2Um1zWEZvdHl0dHZ6?=
 =?utf-8?B?TmZ5bUVRNTlKNWZOL0dyL0NXc1MxOHZhV0xrMncxTUJ1cFgxNThBSklqaEtH?=
 =?utf-8?B?Y2FkVjBCaHY5eVpNeTFIc25KYVJ2aUpWcVZKQ21PblBKbjVZQ0ZhNVVCSmsw?=
 =?utf-8?B?QTNvcnF2RmFjd3VZRDZZcFF3QzRnb2FNcWVKSkVxNkM3MUZjY2NFTmYyNW52?=
 =?utf-8?B?V2FiNVpSelFRNnF4M3JONDRvMG92YWFsRURaZXR4dnpHTVlxZFdQRU55c1do?=
 =?utf-8?B?Mmx0Zng1cThwS0FjcGJnRzRoVVBtc09ka1Vqb0Rqdm5XVHVoblFGWExTWS82?=
 =?utf-8?B?dFgzZmlZcjZ4ekxlZWNRZVRMUDJodmRId0dkcFZCdVRhc2w5SllYU2pyVzll?=
 =?utf-8?B?UUYxeFl2dEJqY0V1cnE0RkwrNU50OXZNWW9vL1kvWU1VbDlSUzlCZ0pyR05y?=
 =?utf-8?Q?oqNh/Yk5egfEBdv+uY0qX56TY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B69EF160CE64B479AC89DA088B6B097@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f23f16b-baf1-4726-fb53-08dd152ac089
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 12:45:51.9281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ly932H05l/mkYRgoju7C8Vrh6JEvcH9Im4uPukl35TDUROZgfy1E7SyL43kmadatvLZ//9PzMfjxXO9sHvzTqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5778
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTEyLTA0IGF0IDE0OjIyICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBP
biBUaHUsIDIwMjQtMTEtMTQgYXQgMDA6NTcgKzEzMDAsIEthaSBIdWFuZyB3cm90ZToNCj4gPiBB
IFREWCBtb2R1bGUgaW5pdGlhbGl6YXRpb24gZmFpbHVyZSB3YXMgcmVwb3J0ZWQgb24gYSBFbWVy
YWxkIFJhcGlkcw0KPiA+IHBsYXRmb3JtIFsqXToNCj4gPiANCj4gPiAgIHZpcnQvdGR4OiBpbml0
aWFsaXphdGlvbiBmYWlsZWQ6IFRETVIgWzB4MCwgMHg4MDAwMDAwMCk6IHJlc2VydmVkIGFyZWFz
IGV4aGF1c3RlZC4NCj4gPiAgIHZpcnQvdGR4OiBtb2R1bGUgaW5pdGlhbGl6YXRpb24gZmFpbGVk
ICgtMjgpDQo+ID4gDQo+ID4gQXMgcGFydCBvZiBpbml0aWFsaXppbmcgdGhlIFREWCBtb2R1bGUs
IHRoZSBrZXJuZWwgaW5mb3JtcyB0aGUgVERYDQo+ID4gbW9kdWxlIG9mIGFsbCAiVERYLXVzYWJs
ZSBtZW1vcnkgcmVnaW9ucyIgdXNpbmcgYW4gYXJyYXkgb2YgVERYIGRlZmluZWQNCj4gPiBzdHJ1
Y3R1cmUgIlREIE1lbW9yeSBSZWdpb24iIChURE1SKS4gIEVhY2ggVERNUiBtdXN0IGJlIGluIDFH
QiBhbGlnbmVkDQo+ID4gYW5kIGluIDFHQiBncmFudWxhcml0eSwgYW5kIGFsbCAibm9uLVREWC11
c2FibGUgbWVtb3J5IGhvbGVzIiB3aXRoaW4gYQ0KPiA+IGdpdmVuIFRETVIgYXJlIG1hcmtlZCBh
cyAicmVzZXJ2ZWQgYXJlYXMiLiAgVGhlIFREWCBtb2R1bGUgcmVwb3J0cyBhDQo+ID4gbWF4aW11
bSBudW1iZXIgb2YgcmVzZXJ2ZWQgYXJlYXMgdGhhdCBjYW4gYmUgc3VwcG9ydGVkIHBlciBURE1S
ICgxNikuDQo+ID4gDQo+ID4gVGhlIGtlcm5lbCBidWlsZHMgdGhlICJURFgtdXNhYmxlIG1lbW9y
eSByZWdpb25zIiBiYXNlZCBvbiBtZW1ibG9ja3MNCj4gPiAod2hpY2ggcmVmbGVjdHMgZTgyMCks
IGFuZCB1c2VzIHRoaXMgbGlzdCB0byBmaW5kIGFsbCAicmVzZXJ2ZWQgYXJlYXMiDQo+ID4gZm9y
IGVhY2ggVERNUi4NCj4gPiANCj4gPiBJdCB0dXJucyBvdXQgdGhhdCB0aGUga2VybmVsJ3Mgdmll
dyBvZiBtZW1vcnkgaG9sZXMgaXMgdG9vIGZpbmUgZ3JhaW5lZA0KPiA+IGFuZCBzb21ldGltZXMg
ZXhjZWVkcyB0aGUgbnVtYmVyIG9mIGhvbGVzIHRoYXQgdGhlIFREWCBtb2R1bGUgY2FuIHRyYWNr
DQo+ID4gcGVyIFRETVIgWzFdLCByZXN1bHRpbmcgaW4gdGhlIGFib3ZlIGZhaWx1cmUuDQo+ID4g
DQo+ID4gVGhhbmtmdWxseSB0aGUgbW9kdWxlIGFsc28gbGlzdHMgbWVtb3J5IHRoYXQgaXMgcG90
ZW50aWFsbHkgY29udmVydGlibGUNCj4gPiBpbiBhIGxpc3Qgb2YgIkNvbnZlcnRpYmxlIE1lbW9y
eSBSZWdpb25zIiAoQ01ScykuICBUaGF0IGNvYXJzZXIgZ3JhaW5lZA0KPiA+IENNUiBsaXN0IHRl
bmRzIHRvIHRyYWNrIHVzYWJsZSBtZW1vcnkgaW4gdGhlIG1lbW9yeSBtYXAgZXZlbiBpZiBpdCBt
aWdodA0KPiA+IGJlIHJlc2VydmVkIGZvciBob3N0IHVzYWdlIGxpa2UgJ0FDUEkgZGF0YScgWzJd
Lg0KPiA+IA0KPiA+IFVzZSB0aGF0IGxpc3QgdG8gcmVsYXggd2hhdCB0aGUga2VybmVsIGNvbnNp
ZGVycyB1bnVzYWJsZSBtZW1vcnkuICBJZiBpdA0KPiA+IGZhbGxzIGluIGEgQ01SIG5vIG5lZWQg
dG8gaW5zdGFudGlhdGUgYSBob2xlLCBhbmQgcmVseSBvbiB0aGUgZmFjdCB0aGF0DQo+ID4ga2Vy
bmVsIHdpbGwga2VlcCB3aGF0IGl0IGNvbnNpZGVycyAncmVzZXJ2ZWQnIG91dCBvZiB0aGUgcGFn
ZSBhbGxvY2F0b3IuDQo+ID4gDQo+IA0KPiBIaSBEYXZlLA0KPiANCj4gSSByZWFsaXplZCB0aGVy
ZSdzIG9uZSBpc3N1ZSBpZiB3ZSBjaGFuZ2UgdG8gdXNlIENNUnMgdG8gZmlsbCB1cCByZXNlcnZl
ZCBhcmVhcw0KPiBmb3IgVERNUnMgYWZ0ZXIgc29tZSBpbnRlcm5hbCBkaXNjdXNzaW9uIHdpdGgg
RGFuOg0KPiANCj4gQ3VycmVudGx5IHdlIHJlcXVpcmVzIGFsbCBtZW1vcnkgcmVnaW9ucyBpbiBt
ZW1ibG9ja3MubWVtb3J5IHRvIGJlIFREWA0KPiBjb252ZXJ0aWJsZSBtZW1vcnkgYXQgdGhlIHRp
bWUgb2YgaW5pdGlhbGl6aW5nIHRoZSBURFggbW9kdWxlIHRvIG1ha2UgbW9kdWxlDQo+IGluaXRp
YWxpemF0aW9uIHN1Y2Nlc3NmdWwuICBXZSBidWlsZCBhIGxpc3Qgb2YgdGhvc2UgbWVtb3J5IHJl
Z2lvbnMgYXMgYSBsaXN0IG9mDQo+ICJURFggbWVtb3J5IGJsb2NrcyIsIGFuZCB1c2UgdGhlbSB0
byBjb25zdHJ1Y3QgdGhlIFRETVJzIHRvIGNvbmZpZ3VyZSB0aGUNCj4gbW9kdWxlLiAgQnV0IHdl
IGRvbid0IGV4cGxpY2l0bHkgY2hlY2sgdGhvc2UgbWVtb3J5IHJlZ2lvbnMgYWdhaW5zdCBDTVJz
IHRvIG1ha2UNCj4gc3VyZSB0aGV5IGFyZSB0cnVseSBURFggY29udmVydGlibGUsIGluc3RlYWQg
d2UgZGVwZW5kIG9uIFRESC5TWVMuQ09ORklHIHRvDQo+IGNhdGNoIGFueSBub24tQ01SIG1lbW9y
eSByZWdpb25zIHRoYXQgZW5kIHVwIHRvIHRoZSBURFggbWVtb3J5IGJsb2Nrcy4NCj4gDQo+IFRo
aXMgd29ya3MgZmluZSBiZWNhdXNlIGN1cnJlbnRseSB3ZSB1c2UgdGhvc2UgVERYIG1lbW9yeSBi
bG9ja3MgdG8gZmlsbCB1cCB0aGUNCj4gcmVzZXJ2ZWQgYXJlYXMgb2YgVERNUnMsIGkuZS4sIGFu
eSBub24tQ01SIHJlZ2lvbnMgaW4gVERYIG1lbW9yeSBibG9ja3Mgd2lsbCBlbmQNCj4gdXAgdG8g
Im5vbi1yZXNlcnZlZCBhcmVhcyIgaW4gVERNUihzKSwgYW5kIHRoaXMgd2lsbCBjYXVzZSBUREgu
U1lTLkNPTkZJRyB0bw0KPiBmYWlsLg0KPiANCj4gQWZ0ZXIgd2UgY2hhbmdlIHRvIHVzaW5nIENN
UnMgdG8gZmlsbCB1cCByZXNlcnZlZCBhcmVhcyBvZiBURE1ScywgdGhlbiBhbGwgbm9uLQ0KPiBD
TVIgcmVnaW9ucyB3aWxsIGJlIG1hcmtlZCBhcyAicmVzZXJ2ZWQgYXJlYXMiLCByZWdhcmRsZXNz
IHdoZXRoZXIgdGhlcmUgaXMgYW55DQo+IG5vbi1DTVIgbWVtb3J5IHJlZ2lvbiBpbiB0aGUgVERY
IG1lbW9yeSBibG9ja3MuICBUaGlzIHdpbGwgcmVzdWx0IGluIFREWCBtb2R1bGUNCj4gaW5pdGlh
bGl6YXRpb24gYmVpbmcgc3VjY2Vzc2Z1bCB3aGlsZSB0aGVyZSBhcmUgbm9uLUNNUiBwYWdlcyBn
b2luZyBpbnRvIHBhZ2UNCj4gYWxsb2NhdG9yLg0KPiANCj4gVG8gYXZvaWQgdGhpcywgd2UgbmVl
ZCB0byBleHBsaWNpdGx5IGNoZWNrIGFsbCB0aGUgVERYIG1lbW9yeSBibG9ja3MgYWdhaW5zdA0K
PiBDTVJzIHRvIG1ha2Ugc3VyZSB0aGV5IGFyZSBhY3R1YWxseSBURFggY29udmVydGlibGUsIGJl
Zm9yZSB1c2luZyBDTVJzIHRvIGZpbGwNCj4gdXAgcmVzZXJ2ZWQgYXJlYXMuDQo+IA0KPiBJIGVu
ZGVkIHVwIHdpdGggYmVsb3cgaW5jcmVtZW50YWwgZGlmZiB3aXRoIHNvbWUgYWRkaXRpb25hbCB0
ZXh0IGZvciB0aGUNCj4gY2hhbmdlbG9nLg0KPiANCj4gRG8geW91IGhhdmUgYW55IGNvbW1lbnRz
Pw0KPiANCg0KSGkgRGF2ZSwNCg0KSSBzZW50IG91dCB0aGUgdXBkYXRlZCBwYXRjaCBhcyAiUEFU
Q0ggdjggOC4xLzkiLiAgSSBhcHByZWNpYXRlIGlmIHlvdSBjYW4NCnJldmlldy4NCg0KSGkgRGFu
LA0KDQpJIGRpZG4ndCByZW1vdmUgeW91ciBSZXZpZXdlZC1ieSBiZWNhdXNlIEkgdGhpbmsgdGhl
IGFkZGl0aW9uYWwgY29kZSBhZGRlZA0Kc2hvdWxkIGJlIHN0cmFpZ2h0Zm9yd2FyZC4gIEJ1dCBw
bGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IGNvbmNlcm4uDQoNClRoYW5rcyENCg==

