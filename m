Return-Path: <linux-kernel+bounces-322828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7270E972F93
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AA91F25AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17430189F52;
	Tue, 10 Sep 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jno4sABS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2439518A6B9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961975; cv=fail; b=duJ9tUbg6C3rTjcG39a/ynEBrhND9Jxjo6A9uQ5ZsQwBEaMFeaQBeZE3yqSCm2Pzvota6IxFRzZaF4oaYhwVRUSOHhRNzp+xZjuCQsnyGnFDNeFP7sMdjKKoIeFwvfNOQWy4up/X/uHSk+evcHJ5AtlYqVyIQZUYxNLAbKanxJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961975; c=relaxed/simple;
	bh=5R6gkKGGXakt+9mvwEXl+dntGCjcSMbbvCEoPKaqaeA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dN6XkSxhUcu02TjcsKKgK1SRQrgM67xqv39Ne+U8jBqCrmTHtzWI24Qmh25MH4bOKNqG0O86SdBX6tCnedw9zLV94dmh3J+VABH1rcEQqyV294Svo/HPpArpKkdF4Ad3T/dCtToEWPQQgEIvnQJEJtWmOrIvwVr+z2XQndrHWss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jno4sABS; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725961974; x=1757497974;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5R6gkKGGXakt+9mvwEXl+dntGCjcSMbbvCEoPKaqaeA=;
  b=Jno4sABSqNFN4zdTF1dUYfKRSPURuUjZy8uwWYqG2UpOy9wPjduoHiDb
   Q61C2yhbU8e/saucZep7/lSUQDZQWt+iA+Bxm6cAF/I7fNJ05JTTDhyuu
   mDAw7za4qa9CQWe0s+708Qxf9bk37Qpqp1x5XArp97eO2aZIY7+01Jc64
   6nXJRkTNyXVB0dXZTFuo/yVY+DP4WFZeE7EAKYPLsMoAQypEYuaDwR6xD
   xTLUL4pKoAevODJWzZ8fLsTkV1P4gzDZcSv5DRNkPhsrC4hbMrk7IJGtN
   UP4AE0SP7La8bbRdvucjAih2Bose3BxFNTD7yNfX3+QS4hulS99Kcoeva
   w==;
X-CSE-ConnectionGUID: c2xwHOmcRxWy2uIMZjanCA==
X-CSE-MsgGUID: Fn6cJ0KPQye4BmlDEu5fdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="35836660"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="35836660"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 02:52:53 -0700
X-CSE-ConnectionGUID: tZmoxGW3SmOCha+im4qlKA==
X-CSE-MsgGUID: XdNc44KoToSaJk6VblZcew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="67270533"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 02:52:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 02:52:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 02:52:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 02:52:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcIRnjZc4OvM+6Y7InSzetgw+WjEuC8ihqi/EQdFI5DBc7udW1JOaoHHcgTKv51BD4FHTRe4dSPzHDSPDYySavB15oY5RYDnPLyxYsAW6ClP+8dPRVQlR1nqiudKOjMIcQxvlICzW2Brk6QIvgcuEV5dxAwiMlq+b8Gz4tOWWrE8GJYrnRO/Fzk8X0h+woMA6al3rDFvJUCpcqHnMF9Qm8yWMAYK2qkad1OVWuvTgXVoKN+VGmzULnlYuE+7GDeuxEpe0wk+73bbFtdFuonVJtcuE3zVN7TnXiekpx4py7qDlNNj9gMje/OqjF8/OuKxV/DeUAADOr5suCwsyObXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5R6gkKGGXakt+9mvwEXl+dntGCjcSMbbvCEoPKaqaeA=;
 b=SjwySY7bBnmxPI3H9ZD41GuAEUMCnyk/NFwrGSiAeAnus31uIN0wATYmHiPv4UdqXAGi0CyuCY0xFv8bkn7R8TBALm8mJcQkiEkq3iGo8x0U23VW49wXka42JeiVXDONOyuwQMmKB7s8Wq//CjiX6gTE+lZGbO9h7NeSKJQMcaWdQjmChq2etnlssc4PNQfFu1gZkRE5CPy2Zx2Lfx0DPY9iz+VOsCy4Cz86dTJpSXYCKYhyJi3BmGxkl7V7/KdXlTttohyPbB2fBevbd5CcWo4PA3Wb5YyuW8h/Vw+IKS5NPPLq7fv7zKEYwMhzvZg9XOPRjpNZKqbkXtPhfCfQpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA0PR11MB4605.namprd11.prod.outlook.com (2603:10b6:806:95::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Tue, 10 Sep
 2024 09:52:49 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 09:52:49 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>, "dyoung@redhat.com"
	<dyoung@redhat.com>, "sagis@google.com" <sagis@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Williams, Dan
 J" <dan.j.williams@intel.com>, "Thomas.Lendacky@amd.com"
	<Thomas.Lendacky@amd.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Ashish.Kalra@amd.com" <Ashish.Kalra@amd.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "bhe@redhat.com" <bhe@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [PATCH v6 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
Thread-Topic: [PATCH v6 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
Thread-Index: AQHbAo6uh3R3WmWEjEq9f90lZT2RcrJPeu8AgADWEACAAAEPgIAAdzWA
Date: Tue, 10 Sep 2024 09:52:49 +0000
Message-ID: <8b9ddac38a612a7ecee7511c657ba0bf84660d3b.camel@intel.com>
References: <cover.1725868065.git.kai.huang@intel.com>
	 <79f0de36a2a4f33e6cea8f0bf6419a6dc09ba94c.1725868065.git.kai.huang@intel.com>
	 <LV3PR12MB9265B4512DE5F2D580DE3CF794992@LV3PR12MB9265.namprd12.prod.outlook.com>
	 <3f419ba5-7b95-45f0-adb3-d7397949c14e@intel.com>
	 <LV3PR12MB9265900A6564C22E9F6666ED949A2@LV3PR12MB9265.namprd12.prod.outlook.com>
In-Reply-To: <LV3PR12MB9265900A6564C22E9F6666ED949A2@LV3PR12MB9265.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA0PR11MB4605:EE_
x-ms-office365-filtering-correlation-id: b4083997-313d-4630-09ad-08dcd17e54c6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N3NtS29FMGVjYjhSem1uSUdzcm95dWlhSlNLN0hTaE12eXZJQ01PYXMxQ3U0?=
 =?utf-8?B?Y2dvelk1eW04UkFVUGQ5SXhtTTFBSFo3KzZ5ZFlzK05UZlhtbEh4ZEpvbm1w?=
 =?utf-8?B?ZkkrMkNMY0xoR2pKN05Tcmh0Z0VUdDA5akhTcGkvSzE0MmdCM1ozR1NPR2kr?=
 =?utf-8?B?c0xoakxtYWlTZWFSeXJGL29jbmw3ZCtIRU1nMXAxczdlcGFmV0xKQVpjV2Fz?=
 =?utf-8?B?QUhvNHBiUFp3YUdqNzdlc1dBNGdrWlFRVC9JMVMvUm50QkxvQ3EyOE53M0tX?=
 =?utf-8?B?b2Z3dUplUGlRSnhGU0QyRTVmVDJhUmIyVlFNYjZwaEwzbW1GVnBUbFZFc1pZ?=
 =?utf-8?B?diswajlhcFZiRUhJc3dYZEk3aUFVVG0yN0hjcTlXM3VSMHJVVklJbzEya2dH?=
 =?utf-8?B?dFcvM21STEdPMW5MMGVMUG9WNUJmNHlqTTdsTnFYdks5S0g4SDFTRUluMi9Q?=
 =?utf-8?B?OG9ERFNBTm5wSkxtZnAwY3FUaHFrRElFRlArdTZFMHZUOEEwckwvSFE2eEI2?=
 =?utf-8?B?TWo2WkNPdDZwOVlRTWk4UTFxb1ZlOGpmblVBYWhaUm56RzRaaEpGSXdDMzJq?=
 =?utf-8?B?V2hENnhPSGRzOVREdlVqc0EyelpjM3NtNzE3clNDZHJWRnZQZ2Z3eWNWSHow?=
 =?utf-8?B?c2RGZWxVVUlqT2pJYW51L2NjbXZNemQxQUROdHlMOTc5ZnkyOU9hUlNlVUQ3?=
 =?utf-8?B?MGw3OUlJT3RyQVpmNWhpQkdBYi9oUDZVRDQ5US9MelU4Ylo3U2cwbkF5OWJF?=
 =?utf-8?B?NE5rSmYzMGxuL0t0dnRoMWRhcHF4aEQ1QVlIY0hVSXE2Wk04SUFRVjBmUGVu?=
 =?utf-8?B?a1gxNnRXY3FQQXAwTys4Y2oxM0o2TC81cW14K1poMGFLaCtpdGpGeFBhSkZs?=
 =?utf-8?B?SmFTUDBvdFFmaTBUNGVPdzlPc2x6NFVmTGovN2pSUUlwbXBRcUpMYk1XSTgw?=
 =?utf-8?B?THNPMVFueUx1azFyODk5VGlEUDVuZGpiOWJoZHVyVUZ1Q2JRa3d1WUNkdEgx?=
 =?utf-8?B?Q1l1bkNBNHEybHJJQlh1b3F6U0w0eHFoR1VyNFBCMEhVam9iaXBUS295MWg4?=
 =?utf-8?B?T3VHbG4zMkxFd05RZE13cFNkektBTmZVWFRUVFZnT0N4b0VERGI5RkxNZGpr?=
 =?utf-8?B?VDloZFhyZUE5S2kvcS9yYTRZbmUvM2g5WXl2VHNRWEFNZHJnNFhuanpFRkJn?=
 =?utf-8?B?a00yOTdtZTFOd3NNTi9vRk9HOGUzeWlHUXNoSEt1ZTVWNGpZYlVCYlAyNWQ0?=
 =?utf-8?B?aHVBc1dzaXJCZ0d5OHY3OEVIbzV5VUVxR2pjQU1ENjJRWnh6c2JhK0srSTZw?=
 =?utf-8?B?NTlHTUNWY0p3UDBOeTlzWENhcjMrVzk0U0haNGNpNUVxMzhHOWR0dzZ6OTU3?=
 =?utf-8?B?K3dsWTZYUS9FbUxSZ2g1VktXd21MSFhRUHIzWURwZERPR1FzY0pIVkxrSE1V?=
 =?utf-8?B?N28yVE05d0xudGRkejc1QkZaa2xvTFhSSjZFSTRLL3ZjODBXdzVYYmN6S3Y5?=
 =?utf-8?B?VklYSzIvVWhGZlVpTkRjM3dScHAxR0RFWUlGdXdGSWJlOXBuS0NxUmFURFhZ?=
 =?utf-8?B?b29WTXN5WFRFQy9VQ1MxL2U5R1VGWHdLNFZnblZ3ck9lZ0ZQY3VIQ1NDYjZn?=
 =?utf-8?B?ZzdNSmdNdjZZWDRlNkI5N0NDN3E1N0VMaU44cmtvY2d5Nk5IaTNYNFBRRVF4?=
 =?utf-8?B?WmZLV2dkWkc3ZURlTUloSmU1S3RTR0NsZDZTcW1icUY5bk9iSUlveXdKVHZW?=
 =?utf-8?B?WUUwT3FPYkdhTVExYmRPSFh1NHIvYkdiak1GRnNtMVlicElsNGQ4RjJGNngv?=
 =?utf-8?B?SHRISUs0L1cvVW11c0wwQUg1aVd6MWhZbjlGRjFEbGljNEFqa0psejhYK3VQ?=
 =?utf-8?B?ZlF3emJ2eW8zTEQzaWc2ZXJNVlVoa1pCVlA3bDJvdElHd1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjFkMDZ2R1pNTGNIbVdmTDh0cTNGTUpOQzRkVlI3UnZJUDNSc3pKNTJreU9r?=
 =?utf-8?B?aSttSzBDc0g3cG8xbkJ3WWpLTHpQNFo3V3BjYlRHR202OHBPSkNoM3lXUmZC?=
 =?utf-8?B?VUVGTXZaRnVta1lUT1BDYllhaU92UUVGSExtSWJlT3pSR2RVMzVySXp2VEFQ?=
 =?utf-8?B?MW5IU01ScUFsb0p3dzZoTlhCNVFqN1lVWGh0eGxXMVJpdVU4R0d4NWpMY3NF?=
 =?utf-8?B?N0k0cEJHSVBvbHVsRVNTcGIwY3RxTnBsVzJJbENZaGh4enpvOTltak45dXdQ?=
 =?utf-8?B?alhNTlI4amE1YW9JWTRUQjczaHJVdXMyWG9VVjhFQk5sUmtpSWoyZ2sxWER4?=
 =?utf-8?B?QnhvY1RDT0dxV0JXNGw5OXZ0djdWUklQRE45MkdCUndGOVU5a1BnUTBmYktG?=
 =?utf-8?B?SjFTSkFDVHJVVitEbE1CVlkwTE4rQlIrMXVJT3EwZ2l3SVFidytQOHphZFA1?=
 =?utf-8?B?U3pMeHB1NzhjNXgyVDR5YVJJNFNPK2tFVmFrOEp1VFQwd1QyRFF1VDlhV2pD?=
 =?utf-8?B?VzJOOHRBWTNvRENJUS96MUNyME1ET2k3aStZb1lFNUNOOEtDa25wVnVpOWVM?=
 =?utf-8?B?M1o0bXl2ODhpNUpKblBoTUpOc0xQQy84REdvWXRGSXZ3b1NYVEx3dTRCdXE1?=
 =?utf-8?B?YnVMV1l0OVcrbEVZOU5JK1E5MGVKRFRDWThzeEdxaWpKSU95UjJNZkRQemp1?=
 =?utf-8?B?eGtqWndhbm92MkliUnBNUG4wTHYyY25ubUI2eXpoc0FxQXNCSHdGVmFsRXVZ?=
 =?utf-8?B?NkhuanVNcnQ1VTBrMXNBelRObHc1V25hWHNjdlIrL0c1NVE2RHg2cVhFZm80?=
 =?utf-8?B?akdNUXFCaHUvcU51aTZ0VHJOcU5uVzFqSytaTUhzTGZTM2NUdjdFNFpVcU1k?=
 =?utf-8?B?d3h1K2FHaVBWenl6bjlpTlBIWmZVY3owL2wzeGd4NENIVmZta05KRlpMSThl?=
 =?utf-8?B?N0FBTEZiNFk3a0ZxbXBNYWJncnhrV1JrR1kzNWdzZzBtSkhNZ3lNY091QVNW?=
 =?utf-8?B?aUppWm8ya0NKMGg5N0pwSzV4Y3grWTA0Rjg5TmM1NVB0WDFnUnhiU0NFZnhC?=
 =?utf-8?B?RlRqK3J1Q1RSdEJQMm5uTVo3b1lObnZhcEg4cE05ZHdaamVYRTBMTHI0ZlhL?=
 =?utf-8?B?Mk5jcFZQaURLUkd2QXk1SVBXTVplN2hINHlkWC9tclpoYkd0aWJ0dDVYN3FH?=
 =?utf-8?B?cU5NTGtHbGxTM01zZ2dwTWJORERTVGRNaFdvcmxEd1hqZzgrb3lldWp0T0pR?=
 =?utf-8?B?amc1OXk1T2VLbXUxelhJMGpmdnJDbGhFNjVLNVk4eFhFem9rdkpTMTE4cFJX?=
 =?utf-8?B?SHVRMlNwQUxWeFdnbkNOOGpsc09GeWpPNmw1RkFlU3daUHJuYllGT3BBQmU0?=
 =?utf-8?B?ZVk1ODN5OXJhS3J2dmNQMTFLOFgvUTYzQ0lydGRXaXBLTHVnb21EQW5TbmFN?=
 =?utf-8?B?MEFsYVpZRnRjbXZ3a0hLdVZtcldoQjN2U1BiNVRkV1Zsa0UvWWdNRUF6aERk?=
 =?utf-8?B?bFM1bjNRNDluMnoyWmJYVzdyNTRGd1dOOXBsSjJZb3dSSjdESFZRQnhjZCtz?=
 =?utf-8?B?c21UQS9SQlZFa2hpVGlCYWlMTWU3UDlGbWNHNmZaZDZFZjFvQ1NvRW0vQ0xH?=
 =?utf-8?B?VkpYV1JOMWlFZnQzVTM0RHVBMWZybWR1WndHT3pqMkI3WGRqUFhZR0JqdjBU?=
 =?utf-8?B?cU02ZHAyYWt1anhnRFU4OHdKWmRJU3Y1bDVtdG9rcTY4eExSQzA3bmQveDBU?=
 =?utf-8?B?WDdNTWVURXgrZm55YjZnMCtsZ0pId2RtL2V5MXByQ0VPaGJMYlBHWlc5b0c0?=
 =?utf-8?B?Uk9YTXhaV1FOelBoNGFKc09rdVpqSUlidHMxVWZvb2RZL3JUbVFNZmVLZ0x0?=
 =?utf-8?B?Y085Zjd0S2RMVUVoTTFvbkVvbjR3YU91WnBzT0hSdGRaZXJoOEc5d0tUb2Ru?=
 =?utf-8?B?YjFtZDZsVjQ5eUtkY1lVQWNTVGVyeUo2WWhSenVsT21tT09xUFlZbitwN1J3?=
 =?utf-8?B?MzNZdXNLenFWOVZqb1FpTXpGamRCbHdJUDl5M0JoRDRzMWgxWVkxNmNqQTJI?=
 =?utf-8?B?R3N0eUJjL2g3c0pUZ1JaZUxyNXAxL2lUUUszQ2hBbzZLUG90R2ZyTStxVlhG?=
 =?utf-8?Q?CmvbwLfCcr8NF6QHNS3BvPGKN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CA8FADFF409B948983021108F22EA14@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4083997-313d-4630-09ad-08dcd17e54c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 09:52:49.7753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nbHfm5x/gL0Pa7gOKQ4/w1B/iN4iR5fcVC8cvITtjA8MJdCFjJjgCXi9c4HuR5ZKry7iG4tusojWKxU2jnjHCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4605
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA5LTEwIGF0IDAyOjQ2ICswMDAwLCBLYXBsYW4sIERhdmlkIHdyb3RlOg0K
PiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5
XQ0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IEh1YW5nLCBL
YWkgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo+ID4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgOSwg
MjAyNCA5OjQyIFBNDQo+ID4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29t
PjsgSGFuc2VuLCBEYXZlDQo+ID4gPGRhdmUuaGFuc2VuQGludGVsLmNvbT47IGJwQGFsaWVuOC5k
ZTsgdGdseEBsaW51dHJvbml4LmRlOw0KPiA+IHBldGVyekBpbmZyYWRlYWQub3JnOyBtaW5nb0By
ZWRoYXQuY29tOyBocGFAenl0b3IuY29tOw0KPiA+IGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRl
bC5jb20NCj4gPiBDYzogeDg2QGtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IHBib256aW5pQHJlZGhhdC5jb207DQo+ID4gc2VhbmpjQGdvb2dsZS5jb207IFdpbGxpYW1z
LCBEYW4gSiA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPjsgTGVuZGFja3ksDQo+ID4gVGhvbWFz
IDxUaG9tYXMuTGVuZGFja3lAYW1kLmNvbT47IEVkZ2Vjb21iZSwgUmljayBQDQo+ID4gPHJpY2su
cC5lZGdlY29tYmVAaW50ZWwuY29tPjsgWWFtYWhhdGEsIElzYWt1DQo+ID4gPGlzYWt1LnlhbWFo
YXRhQGludGVsLmNvbT47IEthbHJhLCBBc2hpc2ggPEFzaGlzaC5LYWxyYUBhbWQuY29tPjsNCj4g
PiBiaGVAcmVkaGF0LmNvbTsgbmlrLmJvcmlzb3ZAc3VzZS5jb207IHNhZ2lzQGdvb2dsZS5jb207
IERhdmUgWW91bmcNCj4gPiA8ZHlvdW5nQHJlZGhhdC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2NiAyLzVdIHg4Ni9rZXhlYzogZG8gdW5jb25kaXRpb25hbCBXQklOVkQgZm9yIGJhcmUt
DQo+ID4gbWV0YWwgaW4gcmVsb2NhdGVfa2VybmVsKCkNCj4gPiANCj4gPiBDYXV0aW9uOiBUaGlz
IG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3Blcg0K
PiA+IGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3Ig
cmVzcG9uZGluZy4NCj4gPiANCj4gPiANCj4gPiA+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL21h
Y2hpbmVfa2V4ZWNfNjQuYw0KPiA+ID4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvbWFjaGluZV9r
ZXhlY182NC5jDQo+ID4gPiA+IEBAIC0zMjIsMTYgKzMyMiw5IEBAIHZvaWQgbWFjaGluZV9rZXhl
Y19jbGVhbnVwKHN0cnVjdCBraW1hZ2UNCj4gPiAqaW1hZ2UpDQo+ID4gPiA+IHZvaWQgbWFjaGlu
ZV9rZXhlYyhzdHJ1Y3Qga2ltYWdlICppbWFnZSkgIHsNCj4gPiA+ID4gICAgICAgICAgdW5zaWdu
ZWQgbG9uZyBwYWdlX2xpc3RbUEFHRVNfTlJdOw0KPiA+ID4gPiAtICAgICAgIHVuc2lnbmVkIGlu
dCBob3N0X21lbV9lbmNfYWN0aXZlOw0KPiA+ID4gPiAgICAgICAgICBpbnQgc2F2ZV9mdHJhY2Vf
ZW5hYmxlZDsNCj4gPiA+ID4gICAgICAgICAgdm9pZCAqY29udHJvbF9wYWdlOw0KPiA+ID4gPiAN
Cj4gPiA+ID4gLSAgICAgICAvKg0KPiA+ID4gPiAtICAgICAgICAqIFRoaXMgbXVzdCBiZSBkb25l
IGJlZm9yZSBsb2FkX3NlZ21lbnRzKCkgc2luY2UgaWYgY2FsbCBkZXB0aA0KPiA+IHRyYWNraW5n
DQo+ID4gPiA+IC0gICAgICAgICogaXMgdXNlZCB0aGVuIEdTIG11c3QgYmUgdmFsaWQgdG8gbWFr
ZSBhbnkgZnVuY3Rpb24gY2FsbHMuDQo+ID4gPiA+IC0gICAgICAgICovDQo+ID4gPiA+IC0gICAg
ICAgaG9zdF9tZW1fZW5jX2FjdGl2ZSA9DQo+ID4gPiA+IGNjX3BsYXRmb3JtX2hhcyhDQ19BVFRS
X0hPU1RfTUVNX0VOQ1JZUFQpOw0KPiA+ID4gPiAtDQo+ID4gPiANCj4gPiA+IEZ1bmN0aW9uYWxs
eSB0aGUgcGF0Y2ggbG9va3MgZmluZS4gIEkgd291bGQgc3VnZ2VzdCBrZWVwaW5nIHNvbWUgZm9y
bSBvZg0KPiA+IHRoaXMgY29tbWVudCB0aG91Z2gsIGJlY2F1c2UgdGhlIGxpbWl0YXRpb24gYWJv
dXQgbm90IGJlaW5nIGFibGUgdG8gbWFrZQ0KPiA+IGZ1bmN0aW9uIGNhbGxzIGFmdGVyIGxvYWRf
c2VnbWVudHMoKSBpcyBhcmd1YWJseSBub24tb2J2aW91cyBhbmQgdGhpcw0KPiA+IGNvbW1lbnQg
c2VydmVkIGFzIGEgd2FybmluZyBmb3IgZnV0dXJlIG1vZGlmaWNhdGlvbnMgaW4gdGhpcyBhcmVh
Lg0KPiA+IA0KPiA+IFllYWggdGhpcyBtYWtlcyBzZW5zZS4gIFRoYW5rcy4NCj4gPiANCj4gPiBJ
IHRoaW5rIHdlIGNhbiBhZGQgc29tZSB0ZXh0IHRvIHRoZSBleGlzdGluZyBjb21tZW50IG9mIGxv
YWRfc2VnbWVudHMoKSB0bw0KPiA+IGNhbGwgb3V0IHRoaXMuICBBbGxvdyBtZSB0byBkaWcgaW50
byBtb3JlIGFib3V0IGNhbGwgZGVwdGggdHJhY2tpbmcgdG8NCj4gPiB1bmRlcnN0YW5kIGl0IGJl
dHRlciAtLSByZWxvY2F0ZV9rZXJuZWwoKSBhZnRlciBsb2FkX3NlZ21lbnRzKCkgc2VlbXMgdG8g
YmUgYQ0KPiA+IHJlYWwgZnVuY3Rpb24gY2FsbCBhbmQgSSB3YW50IHRvIGtub3cgaG93IGRvZXMg
aXQgaW50ZXJhY3Qgd2l0aCBjYWxsIGRlcHRoDQo+ID4gdHJhY2tpbmcuDQo+IA0KPiBUaGF0IG9u
ZSBpcyBleHBsaWNpdGx5IGlnbm9yZWQsIHNlZSBza2lwX2FkZHIoKSBpbiBhcmNoL3g4Ni9rZXJu
ZWwvY2FsbHRodW5rcy5jDQo+IA0KDQpUaGF0IHdhcyBJIHRob3VnaHQgdG9vLiAgVGhhbmtzIGZv
ciBwb2ludGluZyBvdXQuDQoNCkhvdyBhYm91dCBiZWxvdz8NCg0KLS0tIGEvYXJjaC94ODYva2Vy
bmVsL21hY2hpbmVfa2V4ZWNfNjQuYw0KKysrIGIvYXJjaC94ODYva2VybmVsL21hY2hpbmVfa2V4
ZWNfNjQuYw0KQEAgLTM1MSw2ICszNTEsMTEgQEAgdm9pZCBtYWNoaW5lX2tleGVjKHN0cnVjdCBr
aW1hZ2UgKmltYWdlKQ0KICAgICAgICAgKg0KICAgICAgICAgKiBJIHRha2UgYWR2YW50YWdlIG9m
IHRoaXMgaGVyZSBieSBmb3JjZSBsb2FkaW5nIHRoZQ0KICAgICAgICAgKiBzZWdtZW50cywgYmVm
b3JlIEkgemFwIHRoZSBnZHQgd2l0aCBhbiBpbnZhbGlkIHZhbHVlLg0KKyAgICAgICAgKg0KKyAg
ICAgICAgKiBOb3RlIHRoaXMgcmVzZXRzIEdTIHRvIDAuICBEb24ndCBtYWtlIGFueSBmdW5jdGlv
biBjYWxsIGFmdGVyDQorICAgICAgICAqIGhlcmUgc2luY2UgY2FsbCBkZXB0aCB0cmFja2luZyB1
c2VzIHBlci1jcHUgdmFyaWFibGVzIHRvDQorICAgICAgICAqIG9wZXJhdGUgKHJlbG9jYXRlX2tl
cm5lbCBpcyBleHBsaWNpdGx5IGlnbm9yZWQgYnkgY2FsbCBkZXB0aA0KKyAgICAgICAgKiB0cmFj
a2luZykuDQogICAgICAgICAqLw0KDQpCdHcsIGl0IHdvdWxkIGJlIHZlcnkgaGVscGZ1bCBpZiB5
b3UgY2FuIGhlbHAgdG8gdmVyaWZ5IHRoaXMgcGF0Y2ggZG9lc24ndCBicmVhaw0KY2FsbCBkZXB0
aCB0cmFja2luZyBpbiB5b3VyIGVudmlyb25tZW50LiAgVGhhbmtzIQ0K

