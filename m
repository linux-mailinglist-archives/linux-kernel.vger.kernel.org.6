Return-Path: <linux-kernel+bounces-563811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC56EA64911
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E7A3A7909
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0755D22ACEE;
	Mon, 17 Mar 2025 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ytqe53Cj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDE514A0A8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206312; cv=fail; b=jnd35zR/34SOxmF6fwOIFtQMDKc80KrmPrJZ/LCNhLxhyN5AVgi0g3xYCXKLhAmEf4/HnKLhLxWHGDxsmU95UehtwN8UMHxUvgC6whg511zTHJubMVhmmqiyekcM/9pWXAN8m6gvZHzWPTd/DyABlhI0/tFTcAuMNJxuW9LPft0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206312; c=relaxed/simple;
	bh=oZVtJ0w7UOWSkMZ9ps1rRiGbQtUHH5ePl/ZI3jk3oyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c+h7+fbZ/BWrGrRxMDBBZO1ROSipf2pr1DhP/rpWg6d3HhuzsyCDarBq0TotDIiQ9Ej7a7QNnWdNZ6KgBf5+2BLNxC4jLPwkhB+d40SoNjttOdvYP+GxChn19cAP6Cx0xgjMWFc5g3PUoklSy2QRcobyjsZldiIyJdoz52KnUco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ytqe53Cj; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742206311; x=1773742311;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oZVtJ0w7UOWSkMZ9ps1rRiGbQtUHH5ePl/ZI3jk3oyA=;
  b=Ytqe53Cj9uSWe48bWh30gkWaVpQ6GuPqFb6WRj8v6KLJCqQzqD8iFcmd
   EgnD2aa/KNxvocpgqiNKvlt8CEekbC+uQiGjFUcuBTogqqoAxpVrgKQQd
   p+OnZQtWuzfb1iSKFbsNRzn+KrqlbdTWtM8XTKUuzWMGAFv7gM1UaU4h4
   D+ildSBsz9jO2H1MCrD4aEEs1WDdsd4EMbJUuWhzRqLMR9HsXPWJu/kvH
   c6Ss961grw5isIcklxmpAltviOm06TNsgcAb70/mpBBY7L6v8X7hH+jp0
   8xQex9jfaH2TZ+PeGv1waRcEvTnK7aI2/Dx/mjfVw/4RgIkOVu5iZo27U
   Q==;
X-CSE-ConnectionGUID: WPhCTtGjQJOV+qq6LvHLog==
X-CSE-MsgGUID: nifpnIiATuigUZiOkCndlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="42538417"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="42538417"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 03:11:49 -0700
X-CSE-ConnectionGUID: NBIgXoFYRVuL0EEI40RNrA==
X-CSE-MsgGUID: gzhfGBRHTBqz+VpizjVRDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="159051388"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 03:11:50 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 17 Mar 2025 03:11:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 17 Mar 2025 03:11:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 03:11:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YILf+Gu3FiEOHbO4USLrZS3+4b8j6YfWRXLJ0NZ6aeKWakaTdSfrP/N5x0sfjXbzFnWFFD62cdFj2cnV4WwGCOTXRoP+oMxD2KEIt38EuFbBaAmoiGG6SYvFHfTrBr3EqgQidipzsZhe0Q+mUzZwlq8pss6eYcBqZ1t6h0XFw6vFmTjxbygpiNvDsYlMk7UlDwUBoxwJ5kD22wyGdwqBQzgETRuT2cGJ0lZlohfQhpFH145PFmTbf+vb+nqvXOpNN4NBFLYkTDKy9dH5g/78VVntu94h6pVTeDYgFN7pq8L/+o1qgTpvhs0IHN5Ls4vF8ltXpDM7hY/+RyQhE1Pb6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZVtJ0w7UOWSkMZ9ps1rRiGbQtUHH5ePl/ZI3jk3oyA=;
 b=tpb+5DOhH+5fIHErJo6+E3UqXtykC4nq12h/d7L4NOfuUCMSGW4oRCVtFXUYXvoBApE2SyhiefQ1k7MSEtN1vE6AhWaaYQ5JnRI5+nXsg8RXNT12XeJcnPKD0j5xXSLoqgHP9l096KF5ajGR7bW3D7BW6h+xJbePfXabXJGYFWuTqnVWRaaM19h0y8CTHN9J5E24Yc4dsEzHudNMjcKDLEAXciVNjjWnp27tPBfu8a5ZDE/4m0+E/3X5bdz8HhrL8UkpJN/qLP81O/JWUbzDTW7R6lVg7hDH5GiH6LdwQiUqMTUwTHGtHHSL6PDrMng0aIVC4/sIwYRF+ECQHrXvgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB7385.namprd11.prod.outlook.com (2603:10b6:208:423::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 10:11:46 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 10:11:46 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "dyoung@redhat.com"
	<dyoung@redhat.com>, "seanjc@google.com" <seanjc@google.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "bhe@redhat.com" <bhe@redhat.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "ashish.kalra@amd.com"
	<ashish.kalra@amd.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>
Subject: Re: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for bare-metal
 in stop_this_cpu()
Thread-Topic: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for
 bare-metal in stop_this_cpu()
Thread-Index: AQHbk0Lbd/o5JJJNyk6v5kYhZVWKCrNxaCuAgAW7Q4A=
Date: Mon, 17 Mar 2025 10:11:46 +0000
Message-ID: <324a342417a1455633d4646b4be199aa6d85509d.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
			 <e9ee3c7ffc3ba6feb97247faa40789684e39ffd0.1741778537.git.kai.huang@intel.com>
		 <e0d9a3d599025c92fce5e159e8acc1af32844912.camel@intel.com>
In-Reply-To: <e0d9a3d599025c92fce5e159e8acc1af32844912.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA1PR11MB7385:EE_
x-ms-office365-filtering-correlation-id: 38d4d98f-cf69-49ef-3516-08dd653c1fd5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OElxbXl1TGY0bUVxR1RZRStPWkhRNVBUZDlHS3pRSUtpbFVMNmpwK0o4akIz?=
 =?utf-8?B?S3lIQ2lCOEorZWdKbEVoNGY2QWhYWndTV2tmVGI3ZGhhVVM3eWdDNGRVWlBU?=
 =?utf-8?B?QjZiZVFFcUlITHNJbFRTRmNYMnJaYy9sTXZCbUJUVVlUYzg4ZDN3NGV5MXBJ?=
 =?utf-8?B?b2RKdDNPWHoyWTNYYzRxOUZYb3c2UUxmQklVczFaSjRudDVGQ2ZoQWhmWTNs?=
 =?utf-8?B?N29FSDY0dXd1ZDBEUkRJblEvZk5hejdQTzRCWjVkV2NIVWZKRHlid2gyeFhI?=
 =?utf-8?B?bjhJd09Odi9xT2NjREdGU0JlS3NaYVVGZnF0MXpyNFdabDdlOE4xanFGZXFR?=
 =?utf-8?B?Ym1xc090QnFYeS81Z2lHdjl0enI3MFFUTEJBanAvTElBWFdtaUp4LzNFWGlF?=
 =?utf-8?B?UjdqbS92TGVlbWl4K3ZubjhNTzZuWnZhQ0dzeWlIVGJWeUIxYzZvU1YwdXVW?=
 =?utf-8?B?Q2R1eEU2eGwwSTlRYVdSSWthcFlETzNDU3dVZFN3T2I2djl3OEtYZjZ3cDFj?=
 =?utf-8?B?QllVMnpHSW9TR29hdkx1T1lHYThwU2FwN2FDWTlMcnlseGdKQUdVR0dRTlRm?=
 =?utf-8?B?YjJTTHdnejBLRkZPWE5oeVIyMXpVRWdTN1daUGxRRi9CVlNMcG5pWGRudzVR?=
 =?utf-8?B?bXlJV3hiaTc4TzRxVlRKbitMZnk5Qkl6RnFURi9HRE5rM08zZmxVWTgvUSs3?=
 =?utf-8?B?NnNMd3VYam9tbXpHWUl2cnVjNDhDSHZhWUxxTzl2TFVvYU1vMDhza2N0OHNa?=
 =?utf-8?B?VjNzbSsvVTI3Znduczh2dExxemlpc2Z1TTNwNE1sSWw4d05qVVBlS0JFTlBG?=
 =?utf-8?B?YmswZ0JpL3lJTTZqTjltTXNob3VVL2hVSzJRSTcvSGw1TnRHeEZIeWVpb29E?=
 =?utf-8?B?SVQ1YWRIVHByVkVoTUV6UWNaTTZ4TndjQUdGdms0STEvTWVPZWtKRHFENTF5?=
 =?utf-8?B?akJYL3BTVWtvL2xLY2xaR054alVkOWt4NEhGQWpKMzk5TkV3Y1VPWkpVRjNl?=
 =?utf-8?B?N1NFTitXZk82ZW5qbTRpUTFFcG8rR09rMDMyOVRVbFQ2WXdhZmNqUGNRRWFn?=
 =?utf-8?B?aERBekRvbS9nVmJuUlViNlpjRlhyVUc5Q2JCdEt5VGhFMTRYc1NIYk5wUG1v?=
 =?utf-8?B?RCtWQVlJYkJaU0lTZHA5UnBCN2I4a0wxRkxBWFFkUnlwcVBKVWtJWkFGKyt3?=
 =?utf-8?B?QS9CZkZxTFpQTjlCTHNOTk9sVEFQbUIxNmg2bkRWUDM1UVhxeFpmOG16TlJm?=
 =?utf-8?B?Z3NMYjYvL1JVdSszeHovdytORmJmb0lrTS9jQyt4RVltaDB3MmNTQW1mTTlC?=
 =?utf-8?B?dnB0N2NKUjV0aDlpYllmZUdzUmlockJQd1cweDRmeFhCQjFRemt5bElZMzNn?=
 =?utf-8?B?dk5STGZ4MVI2bU9JbTI2QTJ1R1Z3SFRScHNjMDZQRmxZSkJOeE5iL01kT0k5?=
 =?utf-8?B?blNVd3lOM1doSS9jSmNnV1BtYUxtVHRMcXNBVUdLejhlaHNyWVFtT0lwUUFO?=
 =?utf-8?B?TWtoNWdlbFA0emZvaks0a3hIOGU0eHZLdFg2M1lldERobUFtbzJLSTBxT1BB?=
 =?utf-8?B?NSs3R1lLdWpJOVl0SWROMlpoTmgxRkZPejhReSt1WVIyYndQalFmMEtFTTZL?=
 =?utf-8?B?UGx2eTVnaDJEc2tnbndrSTNXV2hPemdWU1o4WFJIaFFzK0p3aTFkV2h1OUNq?=
 =?utf-8?B?SmxvZ3hwSGwxQTArb3IyQWJlRWt4M0ZHeGFaNEpENmpobUlxQ1JVTVlVekVJ?=
 =?utf-8?B?MDNoQU5KRkFSUGpHblRxaGtlV3JiMGc5emF5d0x5ZmdUSFJrdVNpdWdvQm9h?=
 =?utf-8?B?czV2S0Z2eDNCQ0ZkQ01PK0F5cHpSaDRCSU94Qy9mUktiU2R5MWcrUFI0S1VW?=
 =?utf-8?B?cStxL3dWaDZDZkh6cEZ6TmJwOThyODlOWTdPd0c0UFhaY3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDA3NW92VFVsU25PN2RDVzdZRHNJLzBiZWY0VEpqdVFzeGpzRWxWcUJ3blpE?=
 =?utf-8?B?bFhMVzdVaTluRGo0SUVaYlk1c28xS2JtVjVaOHJYNDlkT0dodXFOdTRCWnYr?=
 =?utf-8?B?bUpDVVhUbWtZRGlPWG9pV3ZLMzZPK2tTcTBqVXpiMU0xM3lxRGNGTnRLYUlj?=
 =?utf-8?B?Sll0ei9TRThlUy9HcnFaMFV6TmdTZ1FGZEZkNUdNazZBR3Q0Rll3OWdNMnNG?=
 =?utf-8?B?ZWdUbWwzM0lOZ1Vvb295bW9HZ0dFRVc5aGVrN2lZMVNGNTNQbnJJbm00dGdq?=
 =?utf-8?B?UjMvd0hMcGJBemM5eGh3RTh2b2JvUzBQMGZhTUtyZWN0d2NMVk9MbjBpZEdJ?=
 =?utf-8?B?MUEza2VWdmRrK08vY1ZqakROYjdnUmJhYWx0Ylgrb240LzNoU3Q3aER3N2xm?=
 =?utf-8?B?c2NKYmlwZDhDYUlPOFAwSzI3YW5zVTBTVjcyeHNsRnRydUZoU1g1NExMcVM1?=
 =?utf-8?B?a1QyOHl5WlY5MnYzOVp5SldqT2tBZi9XejNabWcra2hMdVdubUZGQ1JyN3pu?=
 =?utf-8?B?TERibUtYOWxSUG90WGhwUyttNWV1cXY3dzJCd1FTMGtpSTBtc3diRE9mYWFz?=
 =?utf-8?B?ckJkZW9ydzJCdC9IMDlXV29kbG1IZmxzVTMvdE01ZE1sZWM5dCtSU1IxakY4?=
 =?utf-8?B?b1NHTFV6L3FWaVViRHc2amZ6ZVFWdTA1Z0Q5M1p5K3A3VFNBRElTdHZ2ZGRr?=
 =?utf-8?B?aDRJNEprWGp5eUx2cFJNSGJCQW0vU0w5clloQThoZWNLTlNpTGFsbnI2L25W?=
 =?utf-8?B?a0cvcmpaUld4TDdwcU81WGtOR1Z1N1RsdWRkV3BUTFdocFVmTkJ2eTJEZW01?=
 =?utf-8?B?Mmdnb1ZvTHE5Wk01UncxM0FwRS9QVDFnWWRjd3VpWDBsTWMrdXFjcGlBVW4x?=
 =?utf-8?B?REE3bFJKU1U0YjN4SkM2eU9YN0pYODB1aHFUdmExVHd6c280SjltN1JqTC9o?=
 =?utf-8?B?RjJmMHZkSllaQWRaR29oUmtlWjlsWDJmQUNpcCtxVEYybmg5OTVuaTkxTmg2?=
 =?utf-8?B?TmpsVGg1Y0dhNHV4RTV2aXE1MUNoZ1ozNUtJd1U5UGlqdXczSVlhVlByYml2?=
 =?utf-8?B?QmI0QjVPZldqM2hiQ2ZieHgrSmRLb2F0aFFlRUZKWXRhS3laWTVxc1lEQlp2?=
 =?utf-8?B?ckpOcTVVQmJMeHV6UmJNa3dhaXdiSkNSdWlRaGNNVHErVy9ydXpXVVoreEsw?=
 =?utf-8?B?VVZVbjF1eW9iaGx4WHBPbXJ1U0R6YXlZdER5clQzelpIZDg1M2xhM2VjdkVy?=
 =?utf-8?B?a0dLZHRNajVZNUt3cTVJaVV0em5abXBTcjNhTlF5bDRPcDNMZjhzYVBTL2Zt?=
 =?utf-8?B?MFlROTdmQmRIZDNJWXhrZGtlZlUrZkIxeUQwd044S1hnNnBiUUEvcWVuWjVO?=
 =?utf-8?B?K0hxQy9PQWpjNVBwQ3c4QmhwNWJ4SVNINStiZU85aEdLU2FlUVRCWEhsQzBn?=
 =?utf-8?B?ZkhHMWhtY0hBczMzcU5JaVBrZXdRVHp6QkxqN3ZwZW9Fek1kbCt0RU12SVhs?=
 =?utf-8?B?QTJqVmU5Tlkzb1p5TDY0L3g0V3JRUFBoTzB3MWpMSVJLRnJIeUgxelQ4cmtR?=
 =?utf-8?B?SFRqRnNWSnZEV2VpY0d1ek5KekxhSHI5VUJ1b2toNlZxRDFTZHBqWDBvUGNU?=
 =?utf-8?B?Z2hpOTYxQVZKWERVVWJBcHZrQTdtVzhFQ2dvMkpOZzBiSzdvNlZ3VFp4VXZG?=
 =?utf-8?B?VExZSTNOVVgvZVZ5YUN0cEl1eUlFcFdwY0NyNm4vSmV2ejdPdjMwYUE3dm5J?=
 =?utf-8?B?UGpTamplanFFdHJCdm41SzdHZmpTcVRRSGxGQ3RkTWdmajdvU2xLSWVLT0F5?=
 =?utf-8?B?V2lJd29ZdDRPNHZ3UDZJbTM5bHVJQVpoR0N5RnoxejJFK2VaZSt6QWIvd0NP?=
 =?utf-8?B?ZzBwOXhPbzdVekJYWVkzTHVmVzVaVGcvZlZFejZseXBVdGZETHBnVElOcXJ2?=
 =?utf-8?B?bitPSHRCMUtxZG9OYlBkbG05dnNjQ0dyZ2Q3RnpZR3pVS0ZuV2VCV2o0UFlO?=
 =?utf-8?B?bWlxRWlWd1Q4T1RIQ252N0ExaTVMYUNSNmJ4dDJNRHRHdWVaWnVKQUVxSTZG?=
 =?utf-8?B?VkdmNXRRQ3Bmd2l3eDR3NnZUYUR6YnlNYkZJQjBWeS9Rd1ZCWnpodTJha3p1?=
 =?utf-8?Q?LuQswiW7J1LraZnC1xkpYPhwj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D62FD1314F17C946A5A5D9BF1D0D36A6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d4d98f-cf69-49ef-3516-08dd653c1fd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 10:11:46.2753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dr8PlOI4UJGZV9tqrAHTzlXqJPzeRVmfr+ITFI+25pvGcp1OFZJqQJHwqQ6nwvk4F7+Syqtjk6nOlS3z4pBbqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7385
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTAzLTEzIGF0IDE4OjQwICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gT24gVGh1LCAyMDI1LTAzLTEzIGF0IDAwOjM0ICsxMzAwLCBLYWkgSHVhbmcgd3JvdGU6
DQo+ID4gVEw7RFI6DQo+ID4gDQo+ID4gQ2hhbmdlIHRvIGRvIHVuY29uZGl0aW9uYWwgV0JJTlZE
IGluIHN0b3BfdGhpc19jcHUoKSBmb3IgYmFyZSBtZXRhbCB0bw0KPiA+IGNvdmVyIGtleGVjIHN1
cHBvcnQgZm9yIGJvdGggQU1EIFNNRSBhbmQgSW50ZWwgVERYLiAgUHJldmlvdXNseSB0aGVyZQ0K
PiA+IF93YXNfIHNvbWUgaXNzdWUgcHJldmVudGluZyBmcm9tIGRvaW5nIHNvIGJ1dCBub3cgaXQg
aGFzIGJlZW4gZml4ZWQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXiBBZGRpbmcg
InRoZSBrZXJuZWwiIGhlcmUgd291bGQgcmVhZCBhIGxpdHRsZQ0KPiBjbGVhbmVyIHRvIG1lLg0K
DQpPSy4NCg0KPiANCj4gDQo+IFdoZW4gSSByZWFkICJzb21lIGlzc3VlIiBJIHN0YXJ0IGFzc3Vt
aW5nIGl0IHdhc24ndCBmdWxseSBkZWJ1Z2dlZCBhbmQgaXQgaXMNCj4gInNvbWUgaXNzdWUiIHRo
YXQgbm8gb25lIGtub3dzLiBCdXQgYmVsb3cgaXQgc291bmRzIGxpa2UgaXQgd2FzIHJvb3QgY2F1
c2VkLg0KDQpJIGFtIG5vdCBzdXJlIHdoYXQncyB3cm9uZyB3aXRoICJzb21lIGlzc3VlIi4gIEkg
dXNlZCAiX3dhc18iIHRvIGNvbnZleSB0aGlzDQppc3N1ZSB3YXMgZml4ZWQgKHRodXMgcm9vdCBj
YXVzZWQpLiAgUGVyaGFwcyB0aGUgInJvb3QgY2F1c2VkIiBwYXJ0IGlzbid0IGNsZWFyPw0KSSBj
YW4gZXhwbGljaXRseSBjYWxsIGl0IG91dC4NCg0KICBQcmV2aW91c2x5IHRoZXJlIF93YXNfIHNv
bWUgaXNzdWUgcHJldmVudGluZyB0aGUga2VybmVsIGZyb20gZG9pbmcgc28gYnV0wqANCiAgbm93
wqBpdCBoYXMgYmVlbiByb290IGNhdXNlZCBhbmQgZml4ZWQuIA0KDQo+IA0KPiA+IExvbmcgdmVy
c2lvbjoNCj4gDQo+IEl0IG1pZ2h0IG1ha2UgdGhpcyBlYXNpZXIgdG8gZGlnZXN0IHRoaXMgbG9u
ZyB2ZXJzaW9uIGlmIGl0IHN0YXJ0IHdpdGggYSAidGVsbA0KPiB0aGVtIHdoYXQgeW91IGFyZSBn
b2luZyB0byB0ZWxsIHRoZW0iIHBhcmFncmFwaC4NCj4gDQo+ID4gDQo+ID4gQU1EIFNNRSB1c2Vz
IHRoZSBDLWJpdCB0byBkZXRlcm1pbmUgd2hldGhlciB0byBlbmNyeXB0IHRoZSBtZW1vcnkgb3IN
Cj4gPiBub3QuICBGb3IgdGhlIHNhbWUgcGh5c2ljYWwgbWVtb3J5IGFkZHJlc3MsIGRpcnR5IGNh
Y2hlbGluZXMgd2l0aCBhbmQNCj4gPiB3aXRob3V0IHRoZSBDLWJpdCBjYW4gY29leGlzdCBhbmQg
dGhlIENQVSBjYW4gZmx1c2ggdGhlbSBiYWNrIHRvIG1lbW9yeQ0KPiA+IGluIHJhbmRvbSBvcmRl
ci4gIFRvIHN1cHBvcnQga2V4ZWMgZm9yIFNNRSwgdGhlIG9sZCBrZXJuZWwgdXNlcyBXQklOVkQN
Cj4gPiB0byBmbHVzaCBjYWNoZSBiZWZvcmUgYm9vdGluZyB0byB0aGUgbmV3IGtlcm5lbCBzbyB0
aGF0IG5vIHN0YWxlIGRpcnR5DQo+ID4gY2FjaGVsaW5lIGFyZSBsZWZ0IG92ZXIgYnkgdGhlIG9s
ZCBrZXJuZWwgd2hpY2ggY291bGQgb3RoZXJ3aXNlIGNvcnJ1cHQNCj4gPiB0aGUgbmV3IGtlcm5l
bCdzIG1lbW9yeS4NCj4gPiANCj4gPiBURFggdXNlcyAnS2V5SUQnIGJpdHMgaW4gdGhlIHBoeXNp
Y2FsIGFkZHJlc3MgZm9yIG1lbW9yeSBlbmNyeXB0aW9uIGFuZA0KPiA+IGhhcyB0aGUgc2FtZSBy
ZXF1aXJlbWVudC4gIFRvIHN1cHBvcnQga2V4ZWMgZm9yIFREWCwgdGhlIG9sZCBrZXJuZWwNCj4g
PiBuZWVkcyB0byBmbHVzaCBjYWNoZSBvZiBURFggcHJpdmF0ZSBtZW1vcnkuDQo+IA0KPiBUaGlz
IHBhcmFncmFwaCBpcyBhIGxpdHRsZSBqYXJyaW5nIGJlY2F1c2UgaXQncyBub3QgY2xlYXIgaG93
IGl0IGZvbGxvd3MgZnJvbQ0KPiB0aGUgZmlyc3QgcGFyYWdyYXBoLiBJdCBoZWxwcyB0aGUgcmVh
ZGVyIHRvIGdpdmUgc29tZSBoaW50cyBvbiBob3cgdGhleSBzaG91bGQNCj4gb3JnYW5pemUgdGhl
IGluZm9ybWF0aW9uIGFzIHRoZXkgZ28gYWxvbmcuIElmIGl0J3MgdG9vIG11Y2ggb2YgYW4gaW5m
byBkdW1wLCBpdA0KPiBwdXRzIGFuIGV4dHJhIGJ1cmRlbi4gVGhleSBoYXZlIHRvIHRyeSB0byBo
b2xkIGFsbCBvZiB0aGUgZmFjdHMgaW4gdGhlaXIgaGVhZA0KPiB1bnRpbCB0aGV5IGNhbiBwdXQg
dG9nZXRoZXIgdGhlIGJpZ2dlciBwaWN0dXJlIHRoZW1zZWx2ZXMuDQo+IA0KPiBUaGUgZXh0cmEg
aW5mbyBhYm91dCBURFggdXNpbmcgS2V5SUQgYWxzbyBzZWVtcyB1bm5lY2Vzc2FyeSB0byB0aGUg
cG9pbnQgKElJVUMpLg0KDQpJIGFkZGVkIHRoZSBhYm92ZSB0d28gcGFyYWdyYXBocyB0byBtYWlu
bHkgYWRkcmVzcyBSZWluZXR0ZSdzIGNvbmNlcm4gcmVnYXJkaW5nDQoiY2FjaGUgY2FuIGJlIGlu
IGNvaGVyZW50IHN0YXR1cyBkdWUgdG8gbWVtb3J5IGVuY3J5cHRpb24iIGJlaW5nIHRvbyB2YWd1
ZS4NCg0KSSBhbHNvIHRoaW5rIHRoZXkgYXJlIHRvbyB2ZXJib3NlLiAgSG93IGFib3V0IHBsYWNp
bmcgdGhlIGZpcnN0IHR3byBwYXJhZ3JhcGhzDQp3aXRoIHdoYXQgSSBoYXZlIChhZnRlciBhZGRy
ZXNzaW5nIHlvdXIgY29tbWVudHMpIGluIHRoZSBwYXRjaCAyOg0KDQogRm9yIFNNRSBhbmQgVERY
LCBkaXJ0eSBjYWNoZWxpbmVzIHdpdGggYW5kIHdpdGhvdXQgZW5jcnlwdGlvbiBiaXQocykgb2Yg
DQogdGhlIHNhbWUgbWVtb3J5IGNhbiBjb2V4aXN0LCBhbmQgdGhlIENQVSBjYW4gZmx1c2ggdGhl
bSBiYWNrIHRvIG1lbW9yeSANCiBpbiByYW5kb20gb3JkZXIuDQoNCj8NCg0KPiANCj4gPiANCj4g
PiBDdXJyZW50bHksIHRoZSBrZXJuZWwgb25seSBwZXJmb3JtcyBXQklOVkQgaW4gc3RvcF90aGlz
X2NwdSgpIHdoZW4gU01FDQo+ID4gaXMgc3VwcG9ydGVkIGJ5IGhhcmR3YXJlLiAgUGVyZm9ybSB1
bmNvbmRpdGlvbmFsIFdCSU5WRCB0byBzdXBwb3J0IFREWA0KPiA+IGluc3RlYWQgb2YgYWRkaW5n
IG9uZSBtb3JlIHZlbmRvci1zcGVjaWZpYyBjaGVjay4gIEtleGVjIGlzIGEgc2xvdyBwYXRoLA0K
PiA+IGFuZCB0aGUgYWRkaXRpb25hbCBXQklOVkQgaXMgYWNjZXB0YWJsZSBmb3IgdGhlIHNha2Ug
b2Ygc2ltcGxpY2l0eSBhbmQNCj4gPiBtYWludGFpbmFiaWxpdHkuDQo+IA0KPiBPdXQgb2YgY3Vy
aW9zaXR5LCBkbyB5b3Uga25vdyB3aHkgdGhpcyB3YXMgbm90IGFscmVhZHkgbmVlZGVkIGZvciBu
b24tc2VsZiBzbm9vcA0KPiBDUFVzP8KgDQo+IA0KDQpTZWxmIHNub29waW5nIG9ubHkgZGVhbHMg
d2l0aCBkaWZmZXJlbnQgbWVtb3J5IHR5cGVzIChVQywgV0IgZXRjKSBidXQgZG9lc24ndA0KaGFu
ZGxlIG1lbW9yeSBlbmNyeXB0aW9uIHdoaWNoIHdpdGggYWRkaXRpb25hbCBiaXQocykgdGFnZ2Vk
IGludG8gdGhlIHBoeXNpY2FsDQphZGRyZXNzLiANCg0KPiBXaHkgY2FuJ3QgdGhlcmUgYmUgb3Ro
ZXIgY2FjaGUgbW9kZXMgdGhhdCBnZXQgd3JpdHRlbiBiYWNrIGFmdGVyIHRoZSBuZXcNCj4ga2Vy
bmVsIHN0YXJ0cyB1c2luZyB0aGUgbWVtb3J5IGZvciBzb21ldGhpbmcgZWxzZT8NCg0KSSBhc3N1
bWUgdGVhY2hpbmcgY2FjaGUgY29oZXJlbnQgcHJvdG9jb2wgdG8gdW5kZXJzdGFuZCB0aGUgYWRk
aXRpb25hbA0KZW5jcnlwdGlvbiBiaXQocykgaXNuJ3Qgc29tZXRoaW5nIHRoYXQgY2FuIGJlIHN1
cHBvcnRlZCBlYXNpbHkgZm9yIGFsbCB2ZW5kb3JzLg0KDQo+IA0KPiA+IA0KPiA+IE9ubHkgZG8g
V0JJTlZEIG9uIGJhcmUtbWV0YWwuICBEb2luZyBXQklOVkQgaW4gZ3Vlc3QgdHJpZ2dlcnMgdW5l
eHBlY3RlZA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBedGhlDQoNCk9LLg0KDQo+ID4gZXhjZXB0aW9uICgjVkUgb3IgI1ZDKSBmb3IgVERYIGFuZCBT
RVYtRVMvU0VWLVNOUCBndWVzdHMgYW5kIHRoZSBndWVzdA0KPiA+IG1heSBub3QgYmUgYWJsZSB0
byBoYW5kbGUgc3VjaCBleGNlcHRpb24gKGUuZy4sIFREWCBndWVzdHMgcGFuaWNzIGlmIGl0DQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBecGFuaWMNCg0KQWggZ29vZCBjYXRjaC4NCg0KPiA+IHNlZXMgc3VjaCAjVkUpLg0KPiAN
Cj4gSXQncyBhIHNtYWxsIHRoaW5nLCBidXQgSSB0aGluayB5b3UgY291bGQgc2tpcCB0aGUgI1ZF
IG9yICNWQyBpbmZvIGluIGhlcmUuIEFsbA0KPiB0aGV5IG5lZWQgdG8ga25vdyB0byB1bmRlcnN0
YW5kIHRoaXMgcGF0Y2ggaXMgdGhhdCBURFggYW5kIHNvbWUgU0VWIGtlcm5lbHMNCj4gY2Fubm90
IGhhbmRsZSBXQklOVkQuIEFuZCBURFggcGFuaWNzLiAoZG9lcyBTRVYgbm90PykNCg0KSSBjYW4g
cmVtb3ZlICIoI1ZFIG9yICNWQykiLCB1bmxlc3MgS2lyaWxsL1RvbSBvYmplY3QuDQoNClNFViBk
b2VzIG5vdCBwYW5pYyBoZXJlIGluIHN0b3BfdGhpc19jcHUoKSwgYnV0IGl0IGRvZXMgcGFuaWMg
bGF0ZXIgaW4NCnJlbG9jYXRlX2tlcm5lbCgpOg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9s
a21sL2UxZDM3ZWZiODk1MWViMWQzODQ5MzY4N2IxMGEyMWIyMzM1M2UzNWEuMTcxMDgxMTYxMC5n
aXQua2FpLmh1YW5nQGludGVsLmNvbS90LyNtMTNlMzhjNTBmOTNhZmJmMWMxNWY1MDZlOTY4MTdi
MmE3ODQ0NGIxZA0KDQo+IA0KPiA+IA0KPiA+IEhpc3Rvcnkgb2YgU01FIGFuZCBrZXhlYyBXQklO
VkQ6DQo+ID4gDQo+ID4gVGhlcmUgX3dhc18gYW4gaXNzdWUgcHJldmVudGluZyBkb2luZyB1bmNv
bmRpdGlvbmFsIFdCSU5WRCBidXQgdGhhdCBoYXMNCj4gPiBiZWVuIGZpeGVkLg0KPiA+IA0KPiA+
IEluaXRpYWwgU01FIGtleGVjIHN1cHBvcnQgYWRkZWQgYW4gdW5jb25kaXRpb25hbCBXQklOVkQg
aW4gY29tbWl0DQo+ID4gDQo+ID4gICBiYmE0ZWQwMTFhNTI6ICgieDg2L21tLCBrZXhlYzogQWxs
b3cga2V4ZWMgdG8gYmUgdXNlZCB3aXRoIFNNRSIpDQo+ID4gDQo+ID4gVGhpcyBjb21taXQgY2F1
c2VkIGRpZmZlcmVudCBJbnRlbCBzeXN0ZW1zIHRvIGhhbmcgb3IgcmVzZXQuDQo+ID4gDQo+ID4g
V2l0aG91dCBhIGNsZWFyIHJvb3QgY2F1c2UsIGEgbGF0ZXIgY29tbWl0DQo+ID4gDQo+ID4gICBm
MjNkNzRmNmM2NmM6ICgieDg2L21tOiBSZXdvcmsgd2JpbnZkLCBobHQgb3BlcmF0aW9uIGluIHN0
b3BfdGhpc19jcHUoKSIpDQo+ID4gDQo+ID4gZml4ZWQgdGhlIEludGVsIHN5c3RlbSBoYW5nIGlz
c3VlcyBieSBvbmx5IGRvaW5nIFdCSU5WRCB3aGVuIGhhcmR3YXJlDQo+ID4gc3VwcG9ydHMgU01F
Lg0KPiA+IA0KPiA+IEEgY29ybmVyIGNhc2UgWypdIHJldmVhbGVkIHRoZSByb290IGNhdXNlIG9m
IHRoZSBzeXN0ZW0gaGFuZyBpc3N1ZXMgYW5kDQo+ID4gd2FzIGZpeGVkIGJ5IGNvbW1pdA0KPiA+
IA0KPiA+ICAgMWY1ZTdlYjc4NjhlOiAoIng4Ni9zbXA6IE1ha2Ugc3RvcF9vdGhlcl9jcHVzKCkg
bW9yZSByb2J1c3QiKQ0KPiA+IA0KPiA+IFNlZSBbMV1bMl0gZm9yIG1vcmUgaW5mb3JtYXRpb24u
DQo+ID4gDQo+ID4gRnVydGhlciB0ZXN0aW5nIG9mIGRvaW5nIHVuY29uZGl0aW9uYWwgV0JJTlZE
IGJhc2VkIG9uIHRoZSBhYm92ZSBmaXggb24NCj4gPiB0aGUgcHJvYmxlbWF0aWMgbWFjaGluZXMg
KHRoYXQgaXNzdWVzIHdlcmUgb3JpZ2luYWxseSByZXBvcnRlZCkNCj4gPiBjb25maXJtZWQgdGhl
IGlzc3VlcyBjb3VsZG4ndCBiZSByZXByb2R1Y2VkLg0KPiA+IA0KPiA+IFNlZSBbM11bNF0gZm9y
IG1vcmUgaW5mb3JtYXRpb24uDQo+ID4gDQo+ID4gVGhlcmVmb3JlLCBpdCBpcyBzYWZlIHRvIGRv
IHVuY29uZGl0aW9uYWwgV0JJTlZEIGZvciBiYXJlLW1ldGFsIG5vdy4NCj4gDQo+IEluc3RlYWQg
b2YgYSBwbGF5LWJ5LXBsYXksIGl0IG1pZ2h0IGJlIG1vcmUgaW5mb3JtYXRpdmUgdG8gc3VtbWFy
aXplIHRoZSBlZGdlcw0KPiBjb3ZlcmVkIGluIHRoaXMgaGlzdG9yeToNCg0KSSB0aGluayB0aGUg
YWJvdmUgaXMgYWxzbyBpbmZvcm1hdGl2ZS4gIEJvcmlzIHN1Z2dlc3RlZCB0byBrZWVwIHRoZSBk
aXNjdXNzaW9uDQphcm91bmQgdGhvc2UgcmVsZXZhbnQgY29tbWl0cyBpbiB0aGUgY2hhbmdlbG9n
Og0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1rZXJuZWwvMjAyNDAyMjgxMTAyMDcu
R0NaZDhTcjhtWEhBMktUaUx6QGZhdF9jcmF0ZS5sb2NhbC8NCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LWtlcm5lbC8yMDI0MDQxNTE3NTkxMi5HQVpoMXE4R2dwWTN0cEpqNWFAZmF0X2Ny
YXRlLmxvY2FsLw0KDQo+ICAtIERvbid0IGRvIGFueXRoaW5nIHRoYXQgd3JpdGVzIG1lbW9yeSBi
ZXR3ZWVuIHdiaW52ZCBhbmQgbmF0aXZlX2hhbHQoKS4gVGhpcw0KPiBpbmNsdWRlcyBmdW5jdGlv
biBjYWxscyB0aGF0IHRvdWNoIHRoZSBzdGFjay4NCg0KVGhpcyBpcyBhIHJlcXVpcmVtZW50IHRv
IFNNRSwgYnV0IGNoYW5naW5nIHRvIHVuY29uZGl0aW9uYWwgV0JJTlZEIG9uIGJhcmUtbWV0YWwN
CmRvZXNuJ3QgY2hhbmdlIHRoaXMgYmVoYXZpb3VyLiAgV2hhdCdzIHRoZSBwdXJwb3NlIG9mIG1l
bnRpb25pbmcgaGVyZT8NCg0KPiAgLSBBdm9pZCBpc3N1aW5nIHdiaW52ZCBvbiBtdWx0aXBsZSBD
UFVzIGF0IHRoZSBzYW1lIHRpbWUuIEFzIHRnbHggaW1wbGllcyBpdCBpcw0KPiB0b28gZXhwZW5z
aXZlLg0KDQpCb3JpcyBzdWdnZXN0ZWQgdG8gZG8gdW5jb25kaXRpb25hbCBXQklOVkQuICBUaGUg
dGVzdCBieSBEYXZlIFlvdW5nIGFsc28NCmNvbmZpcm1zIHRoZXJlIHdhcyBubyBpc3N1ZSBvbiB0
aGUgb25jZS1wcm9ibGVtYXRpYyBwbGF0Zm9ybXM6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xrbWwvQ0FMdStBb1Naa3Exa3oteGp2SGtrdUozQzcxZDBTTTVpYkVKdXJkZ21rWnFadk5wMmRR
QG1haWwuZ21haWwuY29tLw0KDQo+ICAtIERvbid0IHJhY2UgcmVib290IGJ5IHdhdGNoaW5nIGNw
dW1hc2sgaW5zdGVhZCBvZiBudW1fb25saW5lX2NwdXMoKS4gQnV0IHRoZXJlDQo+IGlzIGEgcmFj
ZSBzdGlsbC4NCj4gDQo+IEhtbSwgb24gdGhlIGxhc3Qgb25lIHRnbHggc2F5czoNCj4gICAgIFRo
ZSBjcHVtYXNrIGNhbm5vdCBwbHVnIGFsbCBob2xlcyBlaXRoZXIsIGJ1dCBpdCdzIGJldHRlciB0
aGFuIGEgcmF3DQo+ICAgICBjb3VudGVyIGFuZCBhbGxvd3MgdG8gcmVzdHJpY3QgdGhlIE5NSSBm
YWxsYmFjayBJUEkgdG8gYmUgc2VudCBvbmx5IHRoZQ0KPiAgICAgQ1BVcyB3aGljaCBoYXZlIG5v
dCByZXBvcnRlZCB3aXRoaW4gdGhlIHRpbWVvdXQgd2luZG93DQo+IA0KPiBBcmUgd2Ugb3Blbmlu
ZyB1cCBtb3JlIHBsYXRmb3JtcyB0byBhIHJhY2UgYnkgdW5jb25kaXRpb25hbGx5IGRvaW5nIHRo
ZSB3YmludmQ/DQo+IENhbiB3ZSBiZSBjbGFyaWZ5IHRoYXQgbm90aGluZyBiYWQgaGFwcGVucyBp
ZiB3ZSBsb3NlIHRoZSByYWNlPyAoYW5kIGlzIGl0DQo+IHRydWU/KQ0KDQpJSVVDIGluIG1vc3Qg
Y2FzZXMgdGhlIFJFQk9PVCB2ZWN0b3Igd2lsbCBqdXN0IGRvIHRoZSBqb2IsIHN0b3Bfb3RoZXJf
Y3B1cygpDQp3b24ndCBuZWVkIHRvIHNlbmQgTk1JcyB0aHVzIEkgYmVsaWV2ZSBpbiBtb3N0IGNh
c2VzIHRoaXMgc2hvdWxkbid0IGluY3JlYXNlDQpyYWNlLiDCoA0KDQpJIGRvbid0IGtub3cgd2hh
dCBraW5kYSBwbGF0Zm9ybSB3aWxsIG5lZWQgTk1JIHRvIHN0b3AgcmVtb3RlIENQVXMuICBGb3IN
Cmluc3RhbmNlLCBBRkFJQ1QgbXkgU1BSIG1hY2hpbmUgd2l0aCAxOTIgQ1BVcyBuZXZlciBuZWVk
ZWQgdG8gc2VuZCBOTUkgaW4gbXkNCnRlc3RpbmdzLg0KDQpEYXZlIFlvbmcgdGVzdGVkIG9uIHRo
b3NlIG9uY2UtcHJvYmxlbWF0aWMgcGxhdGZvcm1zIGFuZCBkb2luZyB1bmNvbmRpdGlvbmFsDQp3
YmludmQgd2FzIGZpbmUuICBUaGlzIHBhdGNoc2V0IChhbGJlaXQgbm90IHVwc3RyZWFtZWQpIGhh
cyBhbHNvIGJlZW4gdGVzdGVkIGJ5DQpjdXN0b21lcnMgaW4gdGhlaXIgZW52aXJvbm1lbnQuICBJ
IGJlbGlldmUgZG9pbmcgdW5jb25kaXRpb25hbCBXQklOVkQgaXMgZmluZS4NCg==

