Return-Path: <linux-kernel+bounces-568390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 357E1A694B1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D61462A39
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE32C1DE4FF;
	Wed, 19 Mar 2025 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P3qPvqqY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5438E1DE3C8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401278; cv=fail; b=okjSQnlTJML3b/Xk+4CkgJejBikDXW8ERkS4R+N6ep2aDo5BwbWoFMpIiBaBVdzvTPK8HIR+74QvUh7qmmle/uYNtqynDAfvPh3j9ePFaOsDpdrTfvRjAIjkh+AEeHEEMW4xQ5eqCV5K/NBMwLHf9qO5PL6OnjVAw0lbb4VDegc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401278; c=relaxed/simple;
	bh=uRpcFcLbVnaz/BRwNcwnktAUZ0sFjzKU4hoRZpeV6/M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qwtm29iNlvOdnlDanqWk9FVQal+T6CQ4TDk5Q/8mw5iEoOxnPh1rfNQ2jIV0+G1xhBhbJcawEIg2SeZ+xUvajorHNXaJk+n2ua61G+4k4tdXxqYgPazOdeX5HNULOBbgT3u97M+G9wGN+AaN9lLjYIviN33In1LsEhUV5ktybm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P3qPvqqY; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742401277; x=1773937277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uRpcFcLbVnaz/BRwNcwnktAUZ0sFjzKU4hoRZpeV6/M=;
  b=P3qPvqqYzdMunabfGVq/skthag8R0z6VMTHvVEzHcRFSiqYLdUc/m/rQ
   UGyT9Zb05xDpN5dvNPhyLaypciKZgD8qagsb22COhePuSXXOVBjz79TG+
   ZgJkAjNC+5y0p42Y1PcKKPrEPMs90Ew6/WmEcCHWTz6SAWw0x6TrRTTzy
   W95fTUeDfN48hnXKhLmQhPJAikdjZ2hUB8jU5xRWRA2PWfc0+/1SWcXH5
   JKQZFRwdoM/JrADnwHgrmLcsW4EocoPfnAITnNkiRUU+5QLBXx9ViP7yp
   16FIDdHtk9ayYz/ioJndrDePTti7W41UGZb3tMfersl0B2+6YxxJvJEc9
   g==;
X-CSE-ConnectionGUID: EL2sIqyRRbKpoinzWbt2CQ==
X-CSE-MsgGUID: ixfOEIWcQ/O6Jv8TII3DfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="47485781"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="47485781"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:21:14 -0700
X-CSE-ConnectionGUID: ximpOuRRQiKXM+rVqW4bbA==
X-CSE-MsgGUID: vgYETErVTsiUYGrPyNNYDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122865211"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:21:14 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 19 Mar 2025 09:21:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Mar 2025 09:21:13 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 09:21:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZNGIz4ISQQVtdrQ08JEPEO/D1T5hTw14ILgamB/v2CiNVTIJJM3vb5yNb/Y2I09AvARd1E5CPVUl/eoaJSgEQebwnM/3lu7ourrLu93wMUf+0Bh4E1ldwKN9kvoYF2cRPUGghQFwPDQTK9dSsKnWMxKpyXhLoB0vyZdg1Bn4BL2JwXRGwhjAADb1t9hVhJGZNLofnFCOue9rsyqLJE3UDOQa6eutcW7KE1yjVXrBlaIooBxj2H3+NdvPuZe/q9cu85SYKx6KDXjL8WdlpbEauxmcpWAX+XxaP2uRnA8tx1eLcjMgy8HYyptrBglwReqWNpQ1QN2IA5Pbh+U5NtyHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRpcFcLbVnaz/BRwNcwnktAUZ0sFjzKU4hoRZpeV6/M=;
 b=Xc1qnhO6F1DOgG83q75S7aB4TG7gxHasT/toOPd19a+Xe/uozlCocNEyE6T+EicUZXg1gRQizIYDT4K297SRyVPxds9aFv+GSQOgrkeDewlIjeoPwgeWpbQ5EJQoprhTKHg6t8zzED/MJBi0jzeMJ6cKjN48cKcAedQt7897Ztxe1l8iLOwn1E1QO5FaZQlDzIFkeY1yIAcyg/T6ZWrEiclTnPbytb7sbhD30IIRmjtAJSX81prwa7rFHL8ZruohkB66e4/V1OCo0OnbGh8LPwtG2TufrktlIHDwdK7KPej01/QyI8CYMHGEePj8H1x3NKJ0j04nSIWNLDFEw8Wq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ0PR11MB8270.namprd11.prod.outlook.com (2603:10b6:a03:479::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 16:20:57 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 16:20:56 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Huang, Kai" <kai.huang@intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "ashish.kalra@amd.com" <ashish.kalra@amd.com>, "dyoung@redhat.com"
	<dyoung@redhat.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "sagis@google.com" <sagis@google.com>,
	"david.kaplan@amd.com" <david.kaplan@amd.com>, "x86@kernel.org"
	<x86@kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 2/5] x86/kexec: Do unconditional WBINVD for bare-metal
 in relocate_kernel()
Thread-Topic: [RFC PATCH 2/5] x86/kexec: Do unconditional WBINVD for
 bare-metal in relocate_kernel()
Thread-Index: AQHbk0LH0f/Ie6UWpUSQoMR8xfb+F7NxtZyAgACvV4CABed/AIAB95wAgABrMAA=
Date: Wed, 19 Mar 2025 16:20:56 +0000
Message-ID: <0c95413047ec3e394d21bc56027bde74f817b423.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
	 <ebe4c0e8fe1b78c014bbc18832ae0eec8fef419d.1741778537.git.kai.huang@intel.com>
	 <1050a84caa9036e3ddb580fb510e634a216e692c.camel@intel.com>
	 <40b14084af8a35af4e07fbd394821f92d0973d32.camel@intel.com>
	 <15521a8142a83acfd2f41712e4cd93a3d1a8a28d.camel@intel.com>
	 <a0e5d74162354028b80912ab4fcdd0b35692090b.camel@intel.com>
In-Reply-To: <a0e5d74162354028b80912ab4fcdd0b35692090b.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ0PR11MB8270:EE_
x-ms-office365-filtering-correlation-id: 1333e0fd-f7be-4414-bdbc-08dd6702076c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UnZlL2xTb0doSVN6a1RhZEwxajBsem5qK01OV21kNFgxaCtIeUpTQmcrZFpU?=
 =?utf-8?B?V3Vpd2xMckY0RmluNm4yUkVmMGZCL1gwTGFCaGlQclI4L2RidlE0bC93MFdT?=
 =?utf-8?B?bk54eDNjMko5WEpYNDdQUmVTSGhkSmRQZVBLUDgzeDBVQThCYVRqR1JaK3FG?=
 =?utf-8?B?M2tqOFNrWStmNFpxaVlaMzdjNVBYbWJoWG1PVENpczBiMVRVVjlVNWFZT0hj?=
 =?utf-8?B?dzFSREtzNVBSZmdRVG5TUklXdTAvYXp0cEFRV2NiMzByajZRWUYza0ZNbS9w?=
 =?utf-8?B?LzBFWXR4Z3BTcTVWdWtOWkVKa29YTUIyaW16U0lYNG5QYWIvT1FUeHpCcXV2?=
 =?utf-8?B?VHVhY1BoU2VtWExiaFN2R25ySEdiYS9PTjZ1YWJxM2FKeG45MThBUTVjdGJq?=
 =?utf-8?B?NzlGQjF6eDAvaTFYVlNUWEdzYTJkV2l0cDc0d0s3QkF2aFBOSTlmUjFOZ2Q1?=
 =?utf-8?B?UDhQTE54ai81RmpGNXZZK0ljaEJmbU9PaHBlYUxCMVJLVS9QZURHM2JXWmdF?=
 =?utf-8?B?M3ZjWnExakp6R1ZRalNWeWMyamFHWFNkSlVzbEx2dXlWdWFjT2ZwVVJiTUwv?=
 =?utf-8?B?a2N2UGxPSWZpNEM4VWxRS01ZQ29EaWQxb3dKaEdXWXNoV1l0emhHK3NGTzdN?=
 =?utf-8?B?WGNkM1pFYkgxQUwyclQwWjFSMnpOQkZmS2EvQ21HRGJENloyOU5rc1ZNT3kv?=
 =?utf-8?B?dHNlZEk4bVFPdGFXMFJTT2l0UzU3d0ZkbTNzbElPZTJMMWNxdHBQQVczTWt6?=
 =?utf-8?B?UHRrTVYwWHZvNjU0YWEyTExyS3FXZG5McytjSyt5dHI5REdGeU1OM3ZFUWhS?=
 =?utf-8?B?RGJTNFNxYm9wcGc3K0lMeU5DWVJOSTMzQ0U5a0ExRTgwbkJ4dzlWaEkwRk1p?=
 =?utf-8?B?S0NnNEpoRXBvTTBKdzVVczVkeGlaKzFMYlN5MFpNQk5YQStublJCeW1YN3ht?=
 =?utf-8?B?aEdRMVdFNmdHUlNQMWpRSWl3SHY2alFRMXlkOGUxZGJLK2w3SGlvV0FpalZC?=
 =?utf-8?B?VzROMnJRaXdZSk8yMEg1K3JQV2J6K1JBeDhiUWJVSDNJODlwN2ZsMGN6THJX?=
 =?utf-8?B?VzJnRUxPaXBPdFVaOXNuM2xPbWlyWklVUnNlazFYZExhcEp2RWFRSitKMWFQ?=
 =?utf-8?B?WUxva1RRWlRxU0xLUnJFL3JYRTFTRmJObFhlWmZGTTN3Nkg0Ti9XcW9EYzh1?=
 =?utf-8?B?UzNOWnh4TmhkNUcyTVhnYW5oWHhFVmUxWUpCa3d1KzRMZlc2bzRFQlVBS1Bl?=
 =?utf-8?B?RkVUZ3d5VVd4d2V1bXR6clNaSkZQU2QzbEQ5cGFqT1pGVHBOV1pmN21KUGtS?=
 =?utf-8?B?cG5xSW5NclhzOW5mL21iVWlib2tNM3EzYnZGenJhT2N1Kzl6cHMwOGRzNHpx?=
 =?utf-8?B?RmZGZjRzZG0yeWJ5QVp2NVpOTEVuSXBQVlBEcmRWaGtMUHRISGVPci9Kam15?=
 =?utf-8?B?Umt3VEJMRWc2WlJDcHRyU09IMkt2OEhnaG1WV2dxc2cxSzBVK1FmUnRFSU51?=
 =?utf-8?B?dkRrVDhiTndrUXVuUndJa3RhTS9yMXgrZzhqbDlYY04zWHRzNWNMb3lnaEhh?=
 =?utf-8?B?WGFDblVhLzI0SkxxNGJEbGozaHBHUW9RNjIxa1VWVFlXR29Sdkxmek1aL3Nu?=
 =?utf-8?B?dStFN3lNN3dtRDNvb3VEWFNBTlpJUVlGaEhjV0dndWg2N0pDZ2ptZGV0ZGVS?=
 =?utf-8?B?eEVkU01GRXVEb0N1NC9EcXdBMkQ0UDhZWXg4L2dULzJMV0c3bXY0ejIvNGU5?=
 =?utf-8?B?Sjc4S2x6aUovQUtGOUxhNExsUlFUSEdrRmF3RlFFTWp2UUNKOHRQNzYzaGNX?=
 =?utf-8?B?ZzlQWnZidEV5aHEvUEh6TS9zeG5PN1RFTzl3QzFGcmJFNUl5OURDQTZWY0dM?=
 =?utf-8?B?eVRVakVPRGFzVER2RjZhNXJ2QmoxNmtBK3ZSRFJWUHB2MDc1RUtadTcrbTdI?=
 =?utf-8?Q?vSzwfVV7Wdb+iMHzSSWPe8kcxziHNQ5K?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVluSTRURUc1T1BkL0tIVnhkYlZsWXhtY0RtbHo2MU1vdnlYSlNidTlnbWxB?=
 =?utf-8?B?R202LzgwVWhYd1A0aXZpQkRURWk5RGVpYi9pcWMzY1lEQUo0dzB2dkdLQjNB?=
 =?utf-8?B?QW9HMmJ4VEw2OW1iVU41Z3JGeS9BR1ByNVJ1amg3dWY3THBDNXJVbjhHL00x?=
 =?utf-8?B?dkpnclZRUjRxV1BsMWRYUGpQaUoxOVNSeURsZUR3MDJ4R3Jhb00rMWhnUlpq?=
 =?utf-8?B?cDhJeEFLZU1TV2ZyOHZ2MHlEOEFrTnVRT25LcWxJdnkyS20rclBFTzRCRmE5?=
 =?utf-8?B?Q0ViYTdLL3lJeDQ4Mmk5SW9QQnh1UlB4ZnJFeVdWdkNsMWRZMzdqOFpJTmhP?=
 =?utf-8?B?bmFBRWxXenJ6RzZmNnhFMzZ1YWx5QXQ2T1QzUFdvbGszRUFPZ0xiblI0MmJv?=
 =?utf-8?B?VUVOckhRWnFpbEkvNFllWE9XdEhONG5rV3doTjlrQTduQXJBOGpxRkFmeHV4?=
 =?utf-8?B?VFZsWHFrUytCOG1yY2JDVGlFMllxbm40RXhZTDJBNndLWjN6aTNRUFBJOVNZ?=
 =?utf-8?B?U2lEaXdZelIvZHIvY2pNS3lwMTk1RDYrbTQ2QjZOSXJuK2Zzc3JKZDBjVDBP?=
 =?utf-8?B?ZGxGWk9VaFlUcWJlcGp3OHZKRktrRTF4TmhQSm1WYkJ4TkVsbVFVRU1FTHVE?=
 =?utf-8?B?VC9pVUpiS1RLUEV5ZFhZU3RLSzhqc0RnUTJBTkI3S2RXM09pTVM1aHFDMlZV?=
 =?utf-8?B?a0htd1hiVXQ3Wk1NRk9PQXVMNXVPYkc2ZGFrQ2RIZjQzZm13eXJIcE5Yei9B?=
 =?utf-8?B?NERGcW9mcjNvZXlzWGVHYUI3RjMvVUc2MGJKVkNWL2FXeDMvY0huRjNRWXNp?=
 =?utf-8?B?aDUwY3VkcU4ybDA1NU9JRGRFaG8wT0hGbUlyTEgwRjM1N3R4Ui9WTTRaclIz?=
 =?utf-8?B?bS9ibDZ4NjJVQVo3eTA2YUlSbEpxYVRHM3p0ZENZQzFLdmtJTldCdlQwTjdQ?=
 =?utf-8?B?clg0L09JQWlJS2dHUS80Q29NZWJxRnE1OVdQZWxtVWVXbzl5czNZYUlvUy9i?=
 =?utf-8?B?K3kwc0xKZHlNVVBhU0RGREt6UlFldGFDZkpnRG95QWpJaUlhVElhaEVHZmly?=
 =?utf-8?B?WWgyQkZjenU2dS9CTjRZblMxSitnVVpGc0NIbnR5bjRObExla3p0M3VxWmUx?=
 =?utf-8?B?UjAwNE1ZY0tObkRNVldmOFlYajJWU0dtTTBxc1hZdTBjZW8rSUVxbFAzNTlp?=
 =?utf-8?B?MTQ5aXBJcHpOQWRMNkNBV3ZYOFJ4eXUvWHk5NjVoSWJaTWFCUis3VnZONFB2?=
 =?utf-8?B?SHVNVi9tUVNNME5hTlNtNkthRVhYMmZud2UyUE9xSzNGRHl2WlFMRitmTC93?=
 =?utf-8?B?VjNmMFY2bTZCTnl1TzFnWFZvMXozSHpjVDZmUnVjaHZ5bUZaUlppYmUyOSsy?=
 =?utf-8?B?b29XRmplZ2toNmFHK3JQc3gzbnZ1VzBoUXBodk9uR1d6OU5PQ09OZERFekND?=
 =?utf-8?B?U2ZkbGpGaDUvbGsyd2lnWDhlY0RnZ25hZTUwQU5GTkszdytvYjNWcHVUVHgv?=
 =?utf-8?B?VFVpVW5RWElVOTlmMFk0VlJqcUxFMUlLdVd3RHloTUNWMUZLb2lVRXE0WkM3?=
 =?utf-8?B?bS8ya2dTWm1nMEtPQzJiNkZOQTdTUjZnZXY1ZFY1Q2I1S2tCM214ZGpXemha?=
 =?utf-8?B?WU8wMDVwL0djMVpNK2pwS3VHelM1eHNmWXdHSzU4a1RYdTIwMHFsSGIzakR5?=
 =?utf-8?B?RjJoVnh4ajEzVmdZQzNXdkVJMkROVG5qRzNVQ0RwbVZGY1czbFVJTDZaSVJC?=
 =?utf-8?B?YUc3bk00aUQzK2t4enFCeFAwQmlwckx3dnNhbytRdkFLdVdDblFkaFBMUzBK?=
 =?utf-8?B?bkUzeUVjUkdqMnc1NFlkdUxSTWFhVCtZRVVRWDBEMTYvOG42eXhIalFOa0VF?=
 =?utf-8?B?SkpUaHNNZUlCUzFrMTQ2V1IrbnpPMTVZaHB0b24wUk9KVG1LK2NHNHRVNEJN?=
 =?utf-8?B?NzVSUlcyM3VQQzBlRGxMY0ErcEdwdlppa2dSb05kUmZDNG0vV0djZGlxTjJ1?=
 =?utf-8?B?NDVzSmtia0xvZ3NsNmFzb1pHL2E0R3JIZmxKUXFScUMweHdFSUFVTUVDS3FB?=
 =?utf-8?B?R2EzaU9OS3JmcHdCYXkySitYeDBxbXI2VDJ1dEdJZVFsN1BCeTFmVmJlVjdJ?=
 =?utf-8?B?TnEyMGp0QzVvdmVUNnVFNWxFc0h2dUVTSE13UElGblQwN3BaZFNSWlFUTEFU?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC713D68B1878642AA71D76A7BF2878F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1333e0fd-f7be-4414-bdbc-08dd6702076c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 16:20:56.8202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Feel5DTMvVR2wqbGjurt8leH8p0gUSwV9cjZsP1FQ5N+Z7tDIFLyjOLwewW2Aydv5HEBF2GBVy/Jpc7bJaRz3UfpUFhqhxDWF4Tf/i9rb+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8270
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTAzLTE5IGF0IDA5OjU3ICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBO
ZXZlcnRoZWxlc3MsIGFyZSB5b3UgbG9va2luZyBmb3Igc29tZXRoaW5nIGxpa2UgYmVsb3cgaW4g
dGhlIGNoYW5nZWxvZz8NCj4gDQo+IMKgIFdpdGggdGhlICdob3N0X21lbV9lbmNfYWN0aXZlJyBh
bmQgdGhlIGNvbW1lbnQgYXJvdW5kIGl0IHJlbW92ZWQsDQo+IMKgIHRoZcKgaW5mb3JtYXRpb24g
YWJvdXQgZGVwdGggdHJhY2tpbmcgbm8gbG9uZ2VyIGV4aXN0cy7CoCBFeHBhbmQgdGhlwqANCj4g
wqAgY29tbWVudMKgYXJvdW5kIGxvYWRfc2VnbWVudHMoKSB0byBtZW50aW9uIHRoYXQgZHVlIHRv
IGRlcHRoIHRyYWNraW5nDQo+IMKgIG5vwqBmdW5jdGlvbiBjYWxsIGNhbiBiZSBtYWRlIGFmdGVy
IGxvYWRfc2VnbWVudHMoKS4NCg0KTG9va3MgZ29vZCB0byBtZS4NCg==

