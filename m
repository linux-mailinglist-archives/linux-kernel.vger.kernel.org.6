Return-Path: <linux-kernel+bounces-560534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4AFA60648
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB92F1766A5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB06B1F4630;
	Thu, 13 Mar 2025 23:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5ik9pYj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4240F5CB8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741910287; cv=fail; b=oDzOXw1KxtMfDTbAvXgZ4JtnIG5a10lybPkr5FofWT3qANUUdmrGX927qSwlFiKoBQ5ftQm/gEC+mSZdzYr8fb4fjBPzyOxiuxhcyOBIPEygyge+ER56lZbf7QPmNsaBpGMnfN8+AfdvMP/057wncObytLhq7mXjZWTuYCDduy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741910287; c=relaxed/simple;
	bh=qlhE0e283XbzC0cxgoxLJuvjg4B3SZYcwEFs4H6U1yo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tRx5kpvZfIfsqKkk14G510875l/UYmhbwbPFD+JMjaytv9du4IGNFoEyNbmTVBI7XBfjH5n+AMtFa+d35xKU02k9g46U6QojCmtfBoGD8oKl3optuz/dKHKYeJJCR1jIxSSSZulqyqiHRwLDaaZZ9d38nCe0DcNSgF9yamahnZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5ik9pYj; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741910286; x=1773446286;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qlhE0e283XbzC0cxgoxLJuvjg4B3SZYcwEFs4H6U1yo=;
  b=C5ik9pYjjFynGM3JIc1aNqLIwvI2/TPM6gyRwzK2JwoXTQUMnAopLXzM
   5Tt2CR9nBI/XwLFxNTgOjqFSw5qn6sAuLuXIznngklZK01BI3yFtW+div
   snNo27NjKqG6agLVgZp2zaepcV+fKkyv0d6MssB7ETOqI7VG2O5axuCrP
   4ZKi3l4tTFIVCCF47zTAp2nVVM2Awngqs+bHFBwcB/gUxV4e4RpiaGvqV
   m0Yx5F7YCJpWndkE5xRxGMO1xJdpExQTmEHIrV5uoaLGTUXrie2kTDYMr
   NStzxP70k69O+ZUDVCDLZ93bbNK8igVd5I9+tbZeCZIjYrRDNUn7yA8F2
   A==;
X-CSE-ConnectionGUID: gJl27Nk2R2yHCbbU1e8WiQ==
X-CSE-MsgGUID: 2YU9z2QWQDmoQ3ixnE1vUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43260602"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43260602"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 16:58:06 -0700
X-CSE-ConnectionGUID: +NB5XteDQwSbvyPy90MAeQ==
X-CSE-MsgGUID: ItR94dtLQWOF5bLGgRDZcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="126301120"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 16:58:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 16:58:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 16:58:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 16:57:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXiFnKvFvqLalc4syYS/guFKfvxsRLfEjl3B3o20u3pvCxKa/HUN/RF7/ob9rk4vEYoavKnnGbF0di5Kiw4k45WN9LzlxLBduhqrpt1zoJmyFHWRmJ2VjWO5985AN6b7gEMKGSkAH9xWTUGz0foE5uLXTLDn6GOPGw5k/tDquSDNJcSV9F3UgM4Ra8IXK9jfP/j3FGWTbynvR8y6dA4P4Q7BuE2M4Ib62EpUfmEk/mziP8CBMgyDsYyGrIwCcny9GXU6fQlJfg77TCC+9svVMczYSJEJcOMNtixyqUL6H4MIuiZ7XOM1/9PUmcLLX16umw+wX69C9XZjMgUqueJCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlhE0e283XbzC0cxgoxLJuvjg4B3SZYcwEFs4H6U1yo=;
 b=fdEB//JGFcefNAO4na9UYTEb/b9lx2vM7vPMTWZNalimnObs7BN0U9mRrLhNlEGn7kMAEC9uu7OJ8JYkL/OzfJgn+LWYDAPAn9dsRYTirNacO5CuTX/KmqqbOBYT9bY22cSMnI8Xn3r4eAgMF6cZEkQSJb5mwUpPz6Ye+ltUCHLJ4Fl2G+I9Ma2JpOVAXf7LAlymLiKU+M0ib06ivIagmJ7hRnmxcoKkn8xQk4YlG9gUhcDIQs3Ex9thSxP7sxQumUztcOeRP2QKUT+q7WOsdVBj9w41u7qdEEm8tBXi73Qq1Pb0VC2sFRrAZqJMAhckqkZM230KEN8Ov0VVojnQ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB7389.namprd11.prod.outlook.com (2603:10b6:610:14d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 23:57:50 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 23:57:50 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"x86@kernel.org" <x86@kernel.org>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "bhe@redhat.com" <bhe@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [RFC PATCH 3/5] x86/kexec: Disable kexec/kdump on platforms with
 TDX partial write erratum
Thread-Topic: [RFC PATCH 3/5] x86/kexec: Disable kexec/kdump on platforms with
 TDX partial write erratum
Thread-Index: AQHbk0Li0j4hIZraA0O6rldQIQB4e7NwJfwAgAAZWQCAARIBAIAAV9SAgAAEJwCAABOXgA==
Date: Thu, 13 Mar 2025 23:57:50 +0000
Message-ID: <1a6b44f3fb23d0a35bb3c24d755fb2ae6f74b1bb.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
		 <408103f145360dfa04a41bc836ca2c724f29deb0.1741778537.git.kai.huang@intel.com>
		 <4ac689506269e907774806a484e15171b04ffc63.camel@intel.com>
		 <e1b3da33446178861ca34e61675f184b439101e2.camel@intel.com>
		 <5e736c6d7794b8642d020350e302ead0d6ca13ae.camel@intel.com>
		 <da02e1d5a489526770ec737eac41237226cdb5cd.camel@intel.com>
	 <e7b259b0a986f3cf1578b000f9113933ef80a324.camel@intel.com>
In-Reply-To: <e7b259b0a986f3cf1578b000f9113933ef80a324.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH3PR11MB7389:EE_
x-ms-office365-filtering-correlation-id: b6cab53c-9975-4cc2-651e-08dd628adc9c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d2hrQWR2bVU2dTdhbGVXVkRnKzNpRmFRdmFDalVETjE5QXZsSktLUHFCZno1?=
 =?utf-8?B?bkNHbGxXZkQ1TlJTcmlEYjJlcC92R1BIdk80d0NSeVM3SkFpNDNmTWZENEUr?=
 =?utf-8?B?V1FtYWcyUktPNGZMTUhRRnJVZzkxSmhqMm05YklJVW15emhWRWNON2FoMDln?=
 =?utf-8?B?bDBrbEdDQ0hoS1c0ak1qVy90WXFHYWM1aUpGNE5hUmovMkJBUTNqbXF2WGdM?=
 =?utf-8?B?bjBXTTQ1V3RiYjIyTHhtbUowQXF1eGU1eXhLZlEweWd0VHI2L3E5ZGdTdVB4?=
 =?utf-8?B?alRvVHdQOXdPbElPSEl2MGlNWUEwQklWTm5uOHoxMHlJeXluOEg2V1liYTR5?=
 =?utf-8?B?Q0NvaHJreEVMZS9MRjFaTUwyOGNVT2JiSENLalNvNXlvWFhoNGppV25zRS96?=
 =?utf-8?B?cUhvVnhlNHpNTmRSZmpkM0dlZGJnZGVteEhieS9HalpHOC9yVGMyT2ZDZEV0?=
 =?utf-8?B?aHI4YTRkMUFTaXlnbEZwVlZhcFZ3bk5CaFBkL1NxeGdiL0dxbnFVYTQ3SDBT?=
 =?utf-8?B?TnhmOXJpeUs1U1VYdTJ0NXBNVEI0UitnUUVUekhvcHVVS3ZrVGxJZ0MwWDFi?=
 =?utf-8?B?QkNHVEh2b3o1UzJwbE9JZTRZY1ZNYy9qRUZPb29GNzZiUXFoNjltNHVaMW9o?=
 =?utf-8?B?Z3BmaExWSThXSHpCZ0VEdk1Gd0xPQWl3MXRCdkRaVXl0L3BQUWdkZTRjSVRU?=
 =?utf-8?B?UjlXVkpZSFg1MFRQV1R0MWNadkJub0dPVmtYbFc4Um91NnNyRDV1UWNzVG1r?=
 =?utf-8?B?d1NNM2JZR3M3TUlGTW1ZMllDN2oyeVlYR2d4VXFaR3BwdmRFdEZoakdnbGtm?=
 =?utf-8?B?YnRZaXRRV1dhYzFZUEVHZ3l0WWVibXRCeG5nZzhGcW9RV2F1SWh4MTZMYVVw?=
 =?utf-8?B?aWVtUzZTbEtTcHNYMkxxbDFxeG1TVHdKdWZRQTR2RG5TY25Yd3dxaDI5WXlD?=
 =?utf-8?B?K2xDT1JETExQTXNDSHZjejVHeWlITk1hMi9QT0oyNG1CNUg0SmJiWitmbmEz?=
 =?utf-8?B?VUtOdkhjQWtJS3pQYjNuNEFkU2dhNHhwQ1ZwOHpmS0NjRlFFcm5DUHBMVHNj?=
 =?utf-8?B?eFl6UmdITWJCOGUvTHhyQ2hGVDQvdXVqaEgwbS8xZ2thbWFIT1JDZUxzZGNR?=
 =?utf-8?B?enh6V0o1cmE5OE5aKzIzUlJUVlpDOWh0NS9XZ00wUWV2WE9CUmlHUEZ6NFJU?=
 =?utf-8?B?amtYN1lHSWhjOUdUaWpoVExzLzdZWGhZMGNtZzAvRHhxcUwyZmdob3B5MUN1?=
 =?utf-8?B?Tk1qdXdzaC9jdjIwUmhYRmk4M3dPU1pCQUpNdTNtb0E3WFRrMnZxcTlXTFg4?=
 =?utf-8?B?emExNDJ0TVZWT0h1SExKYnZLb2NqcjV6ZXE3YUR3aGYxN2ZzdjFEMm1JblNt?=
 =?utf-8?B?UjdwNnZ5V1U0SFg2M1FnL01BUy9TRm1rdmFPWFNKTy9uK3BBTW9mdHE5VHZR?=
 =?utf-8?B?MDB6RVpMblV5dWZBSWFobHpkcW1kVlBONEFGdEE2VGI4RHFYR0xvMVRlVFo0?=
 =?utf-8?B?emZ3cXRrOVdjYXE2NXMzUmJCaDA0UlhwU1NEYVhrV1ZzTklNV2Z6cUpQQ3VJ?=
 =?utf-8?B?VGozQVJEQWJmQ3lZdDVNUktQODRFSnV4M1pVUGlsWTIwNW0zMHF6d2FDcGd6?=
 =?utf-8?B?RUZ2Q24xZ0lXUkRmMk5yeFlBQk1SVTRXdFkyZWdQZ2RTOHdHa2ozc3R1WHpC?=
 =?utf-8?B?RWxYTzl3aGh5M2RKZ0Vva25ORmxvWWo1TGg0djFtN1cxUE1HUVYzdzNWZTZj?=
 =?utf-8?B?RDVOQVk5SnFFeHNyckE0NC9KRWxKNnprY2Rham1JcDFqem9pZWhKdWcxN2or?=
 =?utf-8?B?QWJsNDNlb2gxVitGTStNWEhoMDgvK1ZCejJ0d2RLUFN6V0Qxb2ZadHhiaHVs?=
 =?utf-8?B?NXNhV3NoUkI4S3EyZnZMVWhVR3BMTkNXN1ZuVlpTd3ZQZ0pIQUVnWDgyYU1J?=
 =?utf-8?Q?6EE3y9P3RNcazDqM3+4Bytds16WzNRJJ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmFZdlA5UzRiemhvdHI0TkhHbFVUeWVldzdNcER1bjhZTzNBME5XTlBDK1lT?=
 =?utf-8?B?ZkE5NVB4U2hNUUJ4N2FmbTFWejRCY003bXF2R1Y5ZjU4T1d2QlZlak9MMmFQ?=
 =?utf-8?B?bGJtd3VsWWZueWxFb055S2J5bFJZK3ZnSzdLZDUxK1AwZ2QwMFp1K1hMT0hT?=
 =?utf-8?B?ZkFkdjM2Y1BUNXpSanpFS3hkS2cvdks4QkRTUk1OQ3JaQXF1Tk5acHlzUGM1?=
 =?utf-8?B?RkN2NDFaMFRFMU1OQTRMM2VJWVduYmQwUldrd0VZeGpNL2RMRVlnd2VUcU9B?=
 =?utf-8?B?eGUyRU9tZ3dhaFF1YllCazU0UUl6ajd2bFF4TG4xYmQ4ZVVUNFRkMWwzZGI4?=
 =?utf-8?B?bjB3bmgvajNCQmNGN2RhMnM2bmRmWHNrNHFTUjU4dTJGOHV0bXY3WDdSSy93?=
 =?utf-8?B?Rjh0eWtHbDBBVllVU29sdUdWa212VnB5a0N6MHhpM1hrRDdrZTF5RFYrZ1R6?=
 =?utf-8?B?MkxCRUtvdXkxZ0U5eG1teUFBTUV0RTREV1pFSjI5b1pnWW14MmFrbENCTzIz?=
 =?utf-8?B?Ti9rV1c2MzJ0WXNPRThSSTFaV1Q0eFFYL0h2NnNrUWRQeHNpUWUxbkZUa3RX?=
 =?utf-8?B?K2s3TjQ1YjB4djJ0NUFoY2FEQ1NXMFlCSVc5aER4V2t0YmNiU3FOTnhFS0hl?=
 =?utf-8?B?TkcxS0QxWTYxajhjR3hIalJybkFZNlhRYVNTVTBaQU9GeFhLZm5UalVwMTRI?=
 =?utf-8?B?Y1dGK09rSTN5UjlwTUVtaFRIWXFKZDdjM3g0Um1sTm40V3MwYlduSCtBNWJD?=
 =?utf-8?B?UWtQMGdQUU5RbHVMVGlrRXFLV2s1emZSZSs3YU9uVTlxRkc1NW1uaHBjNjFW?=
 =?utf-8?B?U0N3enYrcWFRL3loTUM1Ym1OVmFvNVBaQXdKNkIzRVJPM0JSZURxd3d1bDFZ?=
 =?utf-8?B?d3BJUU5MYVg2MFNFYUJhRXVNRnhjbmF6TC9oQXZjcExIeUEyYk5DTUtMTHBW?=
 =?utf-8?B?dEJ3VnBBbUpwaTRVbk5zTEpRR3Y0b0JGMTV1aTJaOWFDczQ2M3lla1B0Vkpk?=
 =?utf-8?B?TC9EV0hOOWx2cis4VWRWS0VIUGw1Y0I5VFhZeGNNMExCTHd6dldiRUJpUG1j?=
 =?utf-8?B?WXFNT3k3SmRsNXp3WnpOMEhPaGd2L3EwSnRsTG5MQllzNGNlOGFBV0lobzB2?=
 =?utf-8?B?alBuUTdqbkpuSzgrdi9lYXFXdUV0OHB6aUhCNENpcnZrNDJZeVAwV29GUDZt?=
 =?utf-8?B?ODVmZ01zaXQrUmhsdUg4bWxOYWRiMkNnRTcyWkhNV3RDMk9PVTl1c3Ztcmtz?=
 =?utf-8?B?TGlUU084anBqTzh2Rmo5aGltSHREdTNLRkprbVN0TDVCZUc3YnlEZ2MwY2JR?=
 =?utf-8?B?TmllQnBNUHlJN3g5T1ZEOXo2Q1VPclNCZWxOUzBRSXdadFdFY3ZhK1MzdC90?=
 =?utf-8?B?Zkg1elA2VGNTRGNrUGtORVhvcUFoTlFKYnJHS01lMFVvaHlrMGhoOXBIS2JQ?=
 =?utf-8?B?Vy9rbURQdGtDeHlxMnFOUUxKS1BXUGtEcTQ5Yzl5aTJkSC92cUQyaUNWLzJj?=
 =?utf-8?B?dWt2cldhc2RFRnI4YitDTGRMOFNZNWxnWHBDNThvOGFsUUtUZHlWbzJ4L1FG?=
 =?utf-8?B?MkNZckRBSytZSk91Q203UUxVNmpzeUdLVUNKQlByd25FOG4rNTl3b2RGRDk4?=
 =?utf-8?B?K1JZcENWTnZrYkpNMERjYUw2blpTNEdsNFdrVFY5MStHenRNZUkyODhIeWYv?=
 =?utf-8?B?ak9BTUJqQ0R6YitTeHZtNTgwelR5L0l3ME5nZHhGVVFPTFFIajNkQncvUUhr?=
 =?utf-8?B?VXZjV21qY2t0bWcwbWh0bXJWM3ZnbTQzeW9Md1FXeUhadEdvc0NPV0gzd2tD?=
 =?utf-8?B?d0hadXFmOE5QY08zcGJzNGhCR29KdVAzSXhIQVlyalNQRWNPVFd5aUx6d3RP?=
 =?utf-8?B?YkxldlozQ01kSUp0c3pSOGVEbmQvM0VwTjR4Q2d6N2laMk9DamNHdVVDQlRO?=
 =?utf-8?B?R05kTWZJV3phejQ5MDh1VjNWcjNNZDR5Y3BTM3duWkdtRjFRNFVITWtCM1JL?=
 =?utf-8?B?N2tJVEpqMmFVajJzeE1WalNnbC80YjhpSFp2RU1jb08xaDVxNW9idXkyd2pO?=
 =?utf-8?B?RnZndFdMRXhGUFdvZlFtVDB2Y0ZqMHcrTmQxVjZDb1VZam1YV1NWNVlxTTY2?=
 =?utf-8?Q?AEgw0XAsY9vIQCK2Awx5wip4Z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <881E5AFA0942C645924C7CBF652B6A6E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cab53c-9975-4cc2-651e-08dd628adc9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 23:57:50.2250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i4G/KUrGQWUpVtcOVbmqZvXf8Q6v/60nY76+UAZri4P+ECrKW8hG0rwQX45/JGYB/agk3JUVpQ11G0q3NvNguw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7389
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTAzLTEzIGF0IDIyOjQ3ICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gT24gVGh1LCAyMDI1LTAzLTEzIGF0IDIyOjMyICswMDAwLCBIdWFuZywgS2FpIHdyb3Rl
Og0KPiA+ID4gPiANCj4gPiA+ID4gV2UgY2FuIGFkZCBhIGtlcm5lbCBwYXJhbWV0ZXIgJ3RkeF9o
b3N0PXtvbnxvZmZ9JyBhbmQgc2tpcCBhbGwgVERYIGNvZGUNCj4gPiA+ID4gKHRodXMNCj4gPiA+
ID4gbm8NCj4gPiA+ID4gZXJyYXR1bSBkZXRlY3Rpb24pIHdoZW4gaXQgaXMgb2ZmLsKgIEkgc3Vw
cG9zZSBpdCB3aWxsIGJlIHVzZWZ1bCBpbiBnZW5lcmFsDQo+ID4gPiA+IGFueXdheSBldmVuIHcv
byB0aGUgY29udGV4dCBvZiBrZXhlYy4NCj4gPiA+IA0KPiA+ID4gV2hhdCBleGFjdGx5IGFyZSB5
b3UgdGhpbmtpbmc/IEFkZCBhIHRkeF9ob3N0IHBhcmFtZXRlciwgYnV0IHdoYXQgaXMgdGhlDQo+
ID4gPiBkZWZhdWx0DQo+ID4gPiBiZWhhdmlvcj8gV2hlbiB0ZHhfaG9zdD1vbiB3aXRoIHRoZSBl
cnJhdGEsIGtleGVjIG11c3Qgc3RpbGwgYmUgZGlzYWJsZWQsDQo+ID4gPiByaWdodD8NCj4gPiA+
IEJldHRlciB0byByZXR1cm4gYW4gZXJyb3IsIHRoYW4gcHJvY2VlZCBhbmQgY3Jhc2guDQo+ID4g
DQo+ID4gVGhlIGRlZmF1bHQgYmVoYXZpb3VyIGlzIHRkeF9ob3N0PW9mZiBpbiBvcmRlciB0byBu
b3QgZGlzcnVwdCBrZXhlYy9rZHVtcA0KPiA+IGJlaGF2aW91ciBvbiB0aGUgVERYIHBsYXRmb3Jt
cyB3aXRoIGVycmF0dW0uwqAgVGhlIGRpc3Ryb3Mgd2lsbCBiZSBhYmxlIHRvIHNoaXANCj4gPiBr
ZXJuZWxzIHdpdGggYm90aCBDT05GSUdfS0VYRUNfQ09SRSBhbmQgQ09ORklHX0lOVEVMX1REWF9I
T1NUIG9uLCBhbmQgbm8NCj4gPiB2aXNpYmxlDQo+ID4gaW1wYWN0IHRvIHRoZSB1c2VyIHdobyBk
b2Vzbid0IGNhcmUgYWJvdXQgVERYLg0KPiA+IA0KPiA+IElmIHRoZSB1c2VyIGlzIGludGVyZXN0
ZWQgaW4gVERYLCB0ZHhfaG9zdD1vbiBtdXN0IGJlIHNldCBpbiB0aGUga2VybmVsDQo+ID4gY29t
bWFuZA0KPiA+IGxpbmUsIGJ1dCBpbiB0aGlzIGNhc2UgdXNlciBpcyBleHBlY3RlZCB0byBrbm93
IGtleGVjL2tkdW1wIGNhbiBvbmx5IHdvcmsNCj4gPiBub3JtYWxseSBpZiB0aGUgVERYIHBsYXRm
b3JtIGRvZXNuJ3QgaGF2ZSB0aGUgZXJyYXR1bSAtLSBrZXhlYy9rZHVtcCBhcmUNCj4gPiBkaXNh
YmxlZCBpZiB0aGUgcGxhdGZvcm0gaGFzIHRoZSBlcnJhdHVtLg0KPiANCj4gU28gdGhpcyB3aWxs
IHN3aXRjaCBhbGwgb2YgVERYIHRvIGJlIGRlZmF1bHQgb2ZmIHRoZW4sIHVubGVzcyB0aGUga2Vy
bmVsIGdldHMgYQ0KPiBwYXJhbWV0ZXIgc2V0LsKgDQo+IA0KDQpDdXJyZW50bHkgaW4gS1ZNIFRE
WCBpcyBhbHNvIGRlZmF1bHQgb2ZmLg0KDQo+IEluIHdoaWNoIGNhc2Ugd2UgY291bGQgYWxzbyBq
dXN0IHVubG9jayB0aGUgS2NvbmZpZyB3aXRoIGp1c3Qgb25lDQo+IHNtYWxsIGNoYW5nZS4gVERY
IGFuZCBrZXhlYyB3b3VsZCBzdGlsbCBtdXR1YWxseSBleGNsdXNpdmUsIGJ1dCBqdXN0IGF0IHJ1
bnRpbWUuDQoNClllYWggSSBhbSB0aGlua2luZyB0aGlzIHRvbywgZ2l2ZW4gdGhlICJrZXlJRCAw
IGludGVncml0eSIgdGhpbmcgYXJlIHN0aWxsIG9uLQ0KZ29pbmcuDQoNCj4gV2Ugc2hvdWxkIHRy
eSB0byBmbGFnIFBhb2xvIGFuZCBzZWUgd2hhdCBoZSB0aGlua3MuDQoNCkkgYXBwcmVjaWF0ZSBp
ZiB5b3UgY291bGQgaGVscCB0byBkby4NCg0KPiANCj4gT3IgaXMgdGhlIHByb3Bvc2FsIHRvIG9u
bHkgYmUgZGVmYXVsdCB0ZHhfaG9zdD1vZmYgb24gdGhlIGVycmF0YSBwbGF0Zm9ybXM/IEFuZA0K
PiB0ZHhfaG9zdD1vbiBvdGhlcndpc2U/DQoNClRoZSB0cmlja3kgdGhpbmcgaXMsIG5hdHVyYWxs
eSwgd2Ugd2FudCB0byBza2lwIGFsbCB0aGUgY29kZSBpbiB0ZHhfaW5pdCgpIGlmDQp0ZHhfaG9z
dD1vZmYsIGJlY2F1c2UgdGhlcmUncyBubyByZWFzb24gdG8gZG8gdGhvc2UgZGV0ZWN0aW9uL2lu
aXRpYWxpemF0aW9uIGlmDQp3ZSBhcmUgbm90IGdvaW5nIHRvIHVzZSBURFgsIGUuZy4sIHdlIGRv
bid0IG5lZWQgdG8gdGhpcyBvbmU6DQoNCglyZWdpc3Rlcl9tZW1vcnlfbm90aWZpZXIoJnRkeF9t
ZW1vcnlfbmIpOw0KDQouLiB0aGF0IG1lYW5zIHRoZSBjb2RlIG9mIGRldGVjdGluZyBlcnJhdHVt
IHdpbGwgYmUgc2tpcHBlZCB0b28uDQoNCklmIHdlIG9ubHkgdG8gb25seSBtYWtlIHRkeF9ob3N0
PW9mZiBhcyBkZWZhdWx0IGZvciBlcnJhdHVtIHBsYXRmb3JtcywgdGhlbiB3ZQ0KbmVlZCB0byBk
byBjbGVhbnVwIChlLmcuLCB0byB1bnJlZ2lzdGVyIHRoZSBhYm92ZSBtZW1vcnkgbm90aWZpZXIp
Lg0KDQpUaGlzIGlzbid0IG5pY2UgYW5kIHNlZW1zIGhhY2t5Lg0KDQpJIGRvbid0IHNlZSBtYWtp
bmcgdGR4X2hvc3Q9b2ZmIGFzIGRlZmF1bHQgaGFzIHByb2JsZW0sIGFueXdheSwgYXMgbWVudGlv
bmVkDQphYm92ZSBURFggaXMgb2ZmIGJ5IGRlZmF1bHQgaW4gS1ZNLg0KDQo=

