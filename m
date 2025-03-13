Return-Path: <linux-kernel+bounces-560088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A24DCA5FD98
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C31619C41FC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F28172BB9;
	Thu, 13 Mar 2025 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IEje9Cnn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501DC16F8E9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886345; cv=fail; b=kIRjgZMNfKpnaQp1C3UNbaUHSP3wFvt8vTMflPM0APZst4lDGyEQply9h6ri2z8aRxfi7aAoaRuN2GWUw4L3PWzu4MU5VRCvwYrCKJNdgN2wo/FPef8gUNNucgLG2zq43do8vPktjly/+ZjSHk0QbUeFX50kdvWu/8SLsFKnuEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886345; c=relaxed/simple;
	bh=bZSGj+hArujtJVWaYLOUQ+AF961apWmj99VHFBV9sxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eRxTe7CiGTA5NaWRaJlRSmQALQBO/avcVoax4Q2iT6cS51pe06cQf5mhMYtWJe7b9XcfTzAE3DxD1X9MMG1Kmz3hjII99wG+M69pkijE1c+I6bdHSXTTjaaCMPMTcggU095cATVQ9FA1AIyDMIEs5p9qQlT2EdnTRlNVSmCnGPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IEje9Cnn; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741886344; x=1773422344;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bZSGj+hArujtJVWaYLOUQ+AF961apWmj99VHFBV9sxk=;
  b=IEje9CnnDTLJUWkgV3CiM29xLqTkECdJllOlQWGZotGtWjG+B6/4w58E
   Th2YqtRXdGNlSuDMo0eIJQAxzPKPM2V53YYqX/0Sno7Oys67RBN5mHANj
   We/etA5VzJA2z8nkiuyC6xEvomZ7SVdDXjs+R+K8C4J3ZvN264Ny143yJ
   f2NXjns7kpF2lE7Ji+/YA0RXRGQ75szBGe9YNWS07n4lKIWEIgZGwp864
   fx/EENM6Z0UIwox5JkFGXeSGUlFjt8tK9X013NjF5d38zd1zTmIDh6bx5
   xCrFX8lu4nI4IAnY8ZQXElEMYGav16/Gug0Gj5TirLU9OcdIoq7WE8jj3
   Q==;
X-CSE-ConnectionGUID: SZfterm7RmW+eCbAGH1+gw==
X-CSE-MsgGUID: 4VBt8WXXRdW4RkYFdHolTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53670862"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="53670862"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 10:19:03 -0700
X-CSE-ConnectionGUID: brvuTsiWRxaNttLrgFg29w==
X-CSE-MsgGUID: 05LZ6FAISY23aKOE/OV21w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="120979217"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 10:19:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 10:19:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 10:19:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 10:18:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXw3W68Fs/vr3VWQsw9ge66KQ/ky1umNRxE/Zw664mSbRUKdM+6mwguGywbuVY7nZw2/KsPFAqRqXN1z6/yadylrjfHYM2thB29ebjXgWwCvidntr7O/t2q0CUoFC3YZMKzGe61kVyyIPawuG9u9TBJrnXjdpua1v31nFCjF4S9QX0r5MgYpyxlijojRljUuxvHFk5YxBEp74J0GWZu7rzOwxgO1IJw0XPrmctfg0F+xQud33uyVyShjfmJgXR6wCSqdbuYYu8GblyKxXmc/2tnjcMAEBkcElxXtBchC4GkYQtspTjKf3ucihrM958dHwYeDxE+olptQs7QSwK1Iyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZSGj+hArujtJVWaYLOUQ+AF961apWmj99VHFBV9sxk=;
 b=htFsMP5R6mtMQgqebqEuVtBPm8JCtDZaVGM0VSWw2DkInP9ZjyxMNKO/yklFx/yase9pWw6i77SRK6YhZnlEg+dy14wL0KAO4HS2XWQVXha6I2H9xM51PDKv/IjaI8SllZJUtQyH4TQxwkVm0+m+YnkoLxIw2aPJzxSFO/dPR6yam43exQJaUbxU9J2Q2CEFS0gzwwbaS7AJWScNYkRFZLJPhyHk2OX3IkLAQsaO4cptAsC3LsUJ2dv1dzm2oZvDUCWc64EcHPI+T2EnLyb3+0A9irP11lJfLvH2Aw2UHshQ/VJkL8wMWpA2cxbTotrNtnU+HCRNs5ZUGJAoUh+9Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 17:18:26 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 17:18:26 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Huang, Kai" <kai.huang@intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "ashish.kalra@amd.com" <ashish.kalra@amd.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"x86@kernel.org" <x86@kernel.org>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "bhe@redhat.com" <bhe@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [RFC PATCH 3/5] x86/kexec: Disable kexec/kdump on platforms with
 TDX partial write erratum
Thread-Topic: [RFC PATCH 3/5] x86/kexec: Disable kexec/kdump on platforms with
 TDX partial write erratum
Thread-Index: AQHbk0LJuXFYy0Gh0U6rXIUsBiIijrNwJfcAgAAZYwCAARH4AA==
Date: Thu, 13 Mar 2025 17:18:26 +0000
Message-ID: <5e736c6d7794b8642d020350e302ead0d6ca13ae.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
	 <408103f145360dfa04a41bc836ca2c724f29deb0.1741778537.git.kai.huang@intel.com>
	 <4ac689506269e907774806a484e15171b04ffc63.camel@intel.com>
	 <e1b3da33446178861ca34e61675f184b439101e2.camel@intel.com>
In-Reply-To: <e1b3da33446178861ca34e61675f184b439101e2.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB6054:EE_
x-ms-office365-filtering-correlation-id: 7d10bd81-8bc3-4c7f-86c1-08dd6253111d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OS9Wdjk4Z0M5UUpCMlllSVk5VHMzeTFZNjRUMGcwWUV2Mjd4NWFnQVlFS3dK?=
 =?utf-8?B?cnpyVjk5SHBIVTNhN243dkFrNXJMOUh5M2R6RlVLaHVrUkRWcDhHS3UwUlNh?=
 =?utf-8?B?bXhuYUxnZkwxRGcvajVPUythMHhlQUw4TXFSUHJjOGlhZ3A4cXg5U2JlOFFp?=
 =?utf-8?B?OEVPK24xSHRFU3B2L1NGUi9EdWdTS0FrMDk4b0FMaytKYWQ2U1hOQUc4SEpr?=
 =?utf-8?B?VmhYanRnTXBqWUw4dnRTVUViK2loRnp0NlRlSlg2b1Z2RURLY2JSb3Fwa2dz?=
 =?utf-8?B?NDZXU2o0eldhclI5MTl2dUdVVnpUZkhRZHRTejRhTStOUHJkWFNhTTgvdXVP?=
 =?utf-8?B?RWQyV1p2ZjVuUHQ1eDB1QkN5aDdtYlRoQVI4anVrbmRyZngzSUJQSU13bk1Q?=
 =?utf-8?B?aW5UQVdMamNpaHJacEt3RU1DTG85b21PMFB5dEV5YkJhNFZFankxWFJ0YkxG?=
 =?utf-8?B?eXVURUtxVjRBaWUyVlphOWVrWDFBR253Y1lhV0V3N3BFSDg5YTlEZG9UN2oz?=
 =?utf-8?B?bnVUV2hZSGh1UHNPcXVOVE95YUFiVFRKVUpmTnFZbWZRL2hmWDA4OFNmL0tj?=
 =?utf-8?B?SWdLdGxWOC9yM054bVFBMlpRMXV3TlMwMngxS2dXVWU1NTN3c2dybzJYd1BN?=
 =?utf-8?B?ZWo1ZWErYm9nZTdXdUZabmEzSzk5VVdXNG85U3J5SmROL0JOcGRlYkgvWTRV?=
 =?utf-8?B?K1VPMDY4azFDajJKbWZNVVpFbGJFZURDRUtHdU92TkpsbkpZbElvdzVaNEN0?=
 =?utf-8?B?NzFoU0NCelAyVUkwOThaR253UUJ5OXNJMGhNUGYwRU1LWGE4Y3Q1V1E1VmRD?=
 =?utf-8?B?TCsvV3IzTW51R2NsWTY2QW94Q2FHT1YwY1l3MjRydjluSFNRbDlwM0w1WDFH?=
 =?utf-8?B?WUZsUkllL2JNVDZ2MFZVMnQxZW9MTlU5MGU2RmpFYU95UTZnRXVUL2I2cG9p?=
 =?utf-8?B?Vk1CYmNGTS85UUl4NWV4UzhHL0VTRmtJYXg1OEw3bjBHbStUYnpkQjNOZGFG?=
 =?utf-8?B?Sks3ejNOdDRiSWlZUW04RWtOYWJmRFNWcTBDeVZicEJPc2x2dUpPb253VVFw?=
 =?utf-8?B?Ykk0RWVTSDd4cGx3TUlucDRVVHBJL1RHWitKcVVYL3ZVL1daV3JKY2RXVm5r?=
 =?utf-8?B?S1FqRTFlUG1iK1R3VlhZVlFBQ1A1ZWlCQS82K2duSWRoWkJmZ01FVDA2Mm9T?=
 =?utf-8?B?SzRyQlZVZXFGUWpmb1FUTG9IMW00dWFyNWw2YWtxYTRRb1F3ZkJtVUhST3lF?=
 =?utf-8?B?dWdYRmJqZHNzaHZSTzVEQm5kTU9weHpVbGtDMmNBVWxJTG5wK01qL3dpdE1L?=
 =?utf-8?B?YW5rU3N2QkZMYjNxSjZUYnB6Wis0YTZna1hJZXJFMUNnSHJlTDM1cE5uRHJY?=
 =?utf-8?B?T0ZqZE51WmNSbTFmQUNaUFc3dC9KT2tBNGRFeldFQzA5M0oxbmRyVEN3OHl4?=
 =?utf-8?B?dHowVGlGT1Q5ejlpSjhjY1Y1Si9GdzZvRjF1TXVnR1djdmo3QWltZEJrOHJv?=
 =?utf-8?B?KzNGUE9LUGdSS0FleWE1QURYS29qa2hHWkk3VGFWeTJZZm9NWmNlbWNHMXMz?=
 =?utf-8?B?bHZqSjJnbStTdlRmZVpIQ0hYRnhpclgwZkQxTDNnYjNuWUdpcUV1NW11OTRO?=
 =?utf-8?B?TTM3VmIxQjdPWXFGZE9sMyt3Kzh0ZXNTdlFrUnVpcldEQ0RHNUozRWtmNW1K?=
 =?utf-8?B?anFMYTZYKzJSTkFyd3JGcnhUb2o1Y2lVeThlMjJJWkczQjJhSFFCNnlnK29G?=
 =?utf-8?B?QW5kcVAwZWQ1ZW1OcE1ZZUhBbytWUWkzaFZEZE5RUVdjTURoYy81WUt4bWxT?=
 =?utf-8?B?eklaSitjVHdIeTZnMW9iT0k1ODlKSldQcVBjZGlpdFowOHZLeS9iTnhYQnJM?=
 =?utf-8?B?WnRIcDB2d2V6MHROdFJtZEpZVU44cUFHNVZRUERlTlhrQlNlWTV5aFl1Q1hn?=
 =?utf-8?Q?mnqjRUTqmaXR5+lxGu417/7mir/0XXXn?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkY3WjRmeUVpd0tkMkd5eXlkcitHcC9QeDg1QWF0NUFQRk9XQ3lMRnpnZXZT?=
 =?utf-8?B?cS9MNlQ4YVUzcTZ5T1FGcFQ0Z3hraWFXYThkM0ZqcmpHYmNpWWcwVVNwZVFR?=
 =?utf-8?B?RWhFSEJyQlY3c3drWkVBTHMwMjNlUEQzMFNrZWVWMXNDM2xQQkJveDd0Q3J4?=
 =?utf-8?B?TnBKa2ljVnh1TG5GNUMzM2xSQ0R6OGhGK2wvU2dsb2FJRUJ3aW9PSzNHeGYy?=
 =?utf-8?B?R2NUTGpLeUNJbU9LZk1PVXYzZzNSc2ZGcytOYVAvMS9TTmV2L1FWLzBPNStN?=
 =?utf-8?B?OVNWODcrWWNIRFI4WEVVeGcrMG5zYTNLd05QMmdSOHpQSjg5V2F6N3pnZkVK?=
 =?utf-8?B?UnJxcFZRcmtzUlUyR2I4MEVuRk5YQTYrVk9Qa0N3WlZwaTRuZE8wTEx2bkJF?=
 =?utf-8?B?ZjRoc1lhWDFuT0FiVldCQWtkQSs3STRCb1o2c1Q3ZDB6NFZpeVEzUEF1RVh4?=
 =?utf-8?B?MHNhSzUrMUsyUlgwWlpHaW1ZSG1lUTNSMnR3Z1FXK1NSSHJGOHNFTWdnYnBa?=
 =?utf-8?B?eVpOYk1jeUtMT1NHbS9UMUk3SDFybjBSUkhBTlM1RmdRVnk0QnJQMjIzT1VI?=
 =?utf-8?B?SlNIVG5RaWJtL1VqdUZlKzdna211QUVFalN0WTU3SFVKYnZSWUFCTU1kV2RS?=
 =?utf-8?B?ZXhwYlBDSXFnLzNTdEk2NThuNWlYL2RFMzVXOWNhUnVEYUt1WTVSMUZaNk1r?=
 =?utf-8?B?TUVnS3B3TG1mTmFpQjhtWk1aY3hwOGt1UVZDamhucFE0alZNZ0N5OFVNNjhM?=
 =?utf-8?B?SGFsc3RiRFU1MjNHZWd0cjBPRmVibFdtQjJ4NGh1YnJIdnhuaVhrYnRlTDBF?=
 =?utf-8?B?UzFSSWlnN1FTMmVlV2xMTEpTZVVuNFlnOFVCUlRHcUhUTkkyRm5mcVNrMnow?=
 =?utf-8?B?SGNHUHRwQjdpTE5vQlZvay9rZzgwT1FPeFBVWTRqYjhIWXdVSEdTazUrNEUx?=
 =?utf-8?B?Q2ZMZyt3UzFldVQrREJTa0tTUFZoMmZsMUJBbXY1Q2dwMStvQ28ycnpZTGZI?=
 =?utf-8?B?NEY3aCtGZy81MitoREVIZy9LKytNQ3NibmVkYWdGUnZvUHBXRGQxVitDNVAx?=
 =?utf-8?B?eWJsemJFWGVPd2wvNHBMQ1JUT0o5UEZEZ1NWNGZKQkVsOE50cTFNVHE0S1lI?=
 =?utf-8?B?eUVXbklXQ0hJNS9GUGVkR25IQ2ZualhrS1VodG9Sdlk2M3BTY0E3aDJWclpw?=
 =?utf-8?B?TUVXd0RycGxKc1MwOW9IVFZ5aEpnejZJSGVQL2hzanpiY3ppYUFueHhQbVFU?=
 =?utf-8?B?TEtBdlF2cFNMRjllUHVjc0hZalJMQkhwMndDbCtLZ2s0OHFDb1U0RFAxT2Mx?=
 =?utf-8?B?SU15SFZ1WHNRWGJjdzhlK20zajBmL2RJanh3Q3BqbXhnNitjbHVmRFBRVVRq?=
 =?utf-8?B?cnhjVEVzTWExVm8zeGVpUmRHSUFpZXBxTlhaZ0w4N1ZtR3dRY0dYVzB2Mmd6?=
 =?utf-8?B?VWtvSUNGa0VxVVpQbnBLWkhqaGZpZnRjOVF0a1hEUFovUHB1MnNnakFkUGsx?=
 =?utf-8?B?ZFp3aGRYNHlranJRQTZSalNFT3owQzhrYTlSM3cyQ04venZieWovZms2RjBt?=
 =?utf-8?B?aW9lWlh3djlHb2NHSGNGRmlTc21Nd3FSdXlMS29HZG1jVFM3eXJVNmN5Vm9R?=
 =?utf-8?B?OXpmRVdiZ2NPM3F1K1Z6THgvZFBEY3VKQUZHMFNhZTZHVzZMQitsOXdRZW1a?=
 =?utf-8?B?VEkwTDI0ZFpjYkJIbC9uSDdUamN2SnJCZmp2a1VXUVptSFBOaG14V1V4b29L?=
 =?utf-8?B?Y1ZSSEZ2QXV4ZXp6aUc4R3B1emNDQ2ZjR3dyYk5xVEJZeDFROWpZcWJtZy8z?=
 =?utf-8?B?dUFLWncxdTIxQ3hkOCt0eXQ1emJEbTdEZUxySVAyeDFwOUhacExuV0lnVlpQ?=
 =?utf-8?B?b0F6aVBlV0Jma0x5NFI1Smhkejh2MUFNMkVHNVZqY0xCc0FOY2Q3ZHM4WS9T?=
 =?utf-8?B?UTNoWVZzUk1MaWRBQXZZQmFEMzhIRzBGWGt5NEJKQnZDai9xa3hCY204eWFW?=
 =?utf-8?B?dlZSOTFIVWJZM3NVVjZMY2JrcnZoSU93dm95WnU1Y25kS3V4dVBDUzVnL1Z2?=
 =?utf-8?B?Q1F5WFlpTndUNlNMVk5TUXh1YytnOE11Q052OVJsem5IVmd0Sk54akcvUGd2?=
 =?utf-8?B?ZUxOYzVoeEJrNzc1d0JCeHVETlM4Z0J3ei84VDRvSW1UL0x2Wm9nd3FaUHh4?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E466C573A7D2764DB197932DFBF93319@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d10bd81-8bc3-4c7f-86c1-08dd6253111d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 17:18:26.5234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trb/6mNg+5cGDxX1scdIPRuYOcQhkmSLKeD9QYBwZztXgwp/pkyCPIfSXIzq6UXYEY3H8KpF/ADZ1cRJlqo3B7NXqH8GTP1P0YxHhLNFToo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6054
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTAzLTEzIGF0IDAwOjU3ICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+
IENvbnRpbnVpbmcgYW4gaW50ZXJuYWwgZGlzY3Vzc2lvbi4uLiBBIHByb2JsZW0gd2l0aCB0aGUg
cGxhbiB0byBtb3JlIHNpbXBseQ0KPiA+IHN0YXJ0IHN1cHBvcnQgZm9yIGtleGVjIGJ5IG5vdCBz
dXBwb3J0aW5nIHRoZSBlcnJhdGEgcGxhdGZvcm1zIGlzIHRoYXQgd2hlbg0KPiA+IHRoZXNlIHBs
YXRmb3JtcyBjb25maWd1cmUgVERYIHRoZXkgd2lsbCBsb3NlIGtleGVjIGJ5IGRlZmF1bHQuDQo+
ID4gDQo+ID4gUHJvYmFibHkgYSBiZXR0ZXIgZGVmYXVsdCBmb3IgYSBsb3Qgb2Yga2VybmVscyB3
b3VsZCBiZSB0byBoYXZlIGtleGVjIHdvcmsNCj4gPiBieQ0KPiA+IGRlZmF1bHQsIGFuZCByZXF1
aXJlIG9wdC1pbiB0byB1c2UgVERYIChhbmQgbG9zZSBrZXhlYykuIE9uZSBpZGVhIHdhcyBhDQo+
ID4ga2VybmVsDQo+ID4gcGFyYW1ldGVyIGJlIHJlcXVpcmVkIHRvIGVuYWJsZSBURFggb24gdGhv
c2UgcGxhdGZvcm1zLiBCdXQgdGhlbiB3ZSBhcmUNCj4gPiBzdGFydGluZw0KPiA+IHRvIGFkZCBj
b21wbGV4aXR5IHRvIGF2b2lkIG90aGVyIGNvbXBsZXhpdHkgKHRoZSBlcnJhdGEgcGxhdGZvcm0g
a2V4ZWMNCj4gPiBzdXBwb3J0KS4NCj4gPiANCj4gPiBTdGlsbCwgaXQgbWF5IGJlIGEgbmV0IHdp
biBvbiBjb21wbGV4aXR5Lg0KPiANCj4gV2UgY2FuIGFkZCBhIGtlcm5lbCBwYXJhbWV0ZXIgJ3Rk
eF9ob3N0PXtvbnxvZmZ9JyBhbmQgc2tpcCBhbGwgVERYIGNvZGUgKHRodXMNCj4gbm8NCj4gZXJy
YXR1bSBkZXRlY3Rpb24pIHdoZW4gaXQgaXMgb2ZmLsKgIEkgc3VwcG9zZSBpdCB3aWxsIGJlIHVz
ZWZ1bCBpbiBnZW5lcmFsDQo+IGFueXdheSBldmVuIHcvbyB0aGUgY29udGV4dCBvZiBrZXhlYy4N
Cg0KV2hhdCBleGFjdGx5IGFyZSB5b3UgdGhpbmtpbmc/IEFkZCBhIHRkeF9ob3N0IHBhcmFtZXRl
ciwgYnV0IHdoYXQgaXMgdGhlIGRlZmF1bHQNCmJlaGF2aW9yPyBXaGVuIHRkeF9ob3N0PW9uIHdp
dGggdGhlIGVycmF0YSwga2V4ZWMgbXVzdCBzdGlsbCBiZSBkaXNhYmxlZCwgcmlnaHQ/DQpCZXR0
ZXIgdG8gcmV0dXJuIGFuIGVycm9yLCB0aGFuIHByb2NlZWQgYW5kIGNyYXNoLg0K

