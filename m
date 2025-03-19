Return-Path: <linux-kernel+bounces-567681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8075AA688EC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5971889C4C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173C62505D6;
	Wed, 19 Mar 2025 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fyXw+jRl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB4124EF61
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742378254; cv=fail; b=hUJ1VUY2MoMRxJndm7skh9BjKqkXMP8iWAKCaTWu18PbmiVoVDp3x+gVQAc1rZl4QzotpmleJjWZd0U1aOez5vFUDX8Vg+qPaCuYfgWvjaZu5xiZPLPG+mJM1eeX9ugLdbz2VJxXmMk0NR7BHV/ktWRmS1ReiqjBAi0rzaiOkhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742378254; c=relaxed/simple;
	bh=fhse3sJG8q/dCewROK6/lQ4Tk2ofl4M1hJaa+JMgFks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K46s6Ymw2Si26jkOa84HgcS8EHBhrsh5I7wd9/a2SFj0Vf7+wKrFAbOS3sfZslgXWApiKNBNxv0xYFVxq69LpVPMx8aeh73DTC7UwVwjmjVXjngTRFDoryX6eR12MSuNjAhuIAiCx6mehUGR7G1f8R0j2krSqi3GuVn2MmuOF8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fyXw+jRl; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742378252; x=1773914252;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fhse3sJG8q/dCewROK6/lQ4Tk2ofl4M1hJaa+JMgFks=;
  b=fyXw+jRlzqZ98aJTAGdmi/nTPQztOeTxNo1C3VEhApKmWsYpwn7hPvfD
   vJLpirbZ7sBxXm3tKAhTOLN3r3oUfv72O+4k1at9k6p0WklAVjzhvxTBH
   4yE2S4u3wBFE9vc/iiCuHXCpyBRNWmY1smSZf5F6Oyo3Xei5suPCyLamg
   vAS0WxirHvLdueOmZzZwNmwVgYp99BQYr8w9CQLwjoMxZW9zRP8nL3klY
   qcJ3hnV4UDXBKeo/EuKpvMlX+OAIjQMpbhSD18ecisili/PPdzq5fN+1o
   uz1z/h6iGxV5IGwstqa4K6ngKwNmP0MgxvgBNFoIHRZb2ldeivKgg2xd1
   g==;
X-CSE-ConnectionGUID: +gAZuDbHRBCMS9nadqOidQ==
X-CSE-MsgGUID: QOKeVcweQ8CwhRUjAKgX3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43574122"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43574122"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 02:57:31 -0700
X-CSE-ConnectionGUID: Le2YTQ+KS+Oc30u+rZlvYw==
X-CSE-MsgGUID: TQMsLnmrRdaCk+617vw4VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="127368826"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2025 02:57:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Mar 2025 02:57:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 02:57:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 02:57:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3PjCn6XX9yEtZgYRMRp3uluVa3XBLk0s5M0KfNim4BHylCkswxGG82npQPQQxGTxc7y3mfUgkfOy7gevvT7z6CYlhh8G4XynORsBczbsdaywu3BE2CLsqd/TJaoHKCC9RYG54AUKOkNKW/ZVeeU7A225hCXhNP8AmARXIY7gLqCXGqfkxyBieyFS08zqcMOwR2w1ZrG4WzXLSntfVKf9zKJbwNXvUUAo2m4jdIVsHndwK4OLaRGJlFgpEDtsrc5AZazQWi3A/xk1ayl+rwqJXcjW/6eWe/MKMcuh8JTUSDVgTX/Fo3os/DBUaaDs1kRNvrRbnmF5NUSF1YPMF5bWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhse3sJG8q/dCewROK6/lQ4Tk2ofl4M1hJaa+JMgFks=;
 b=lcc8g/bGlRfOCboQMLw9+bHaVQwDZNy1TxO4WjBnMtoLppQNGTePWn3YifiAaP+/CLsfnUdcw9FpwTGSAUctsdhe0oT0eOK4gLlDvlOBHEH3cHuhKZbbQ+rQNW6N22Ip+nmSxKzTSYTo8TozNRZASfdCvgLEDw0h/HjI6huJrTn7xywIX94iMcsbe8eTNZYHOaTWEhQHDg3QhXUUMwbfVK1Uni9pHRb/G2VM0SwOcZ9K6a66xhZ17O/yIyXt958ySV7khhVCUPjp4/l3TEX4M+XMG8o3RW+YjBKtF3FN/mrjqb28gJMp75gHHU3jSqBKvznXzIjErNqzhon3/D0Gfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH8PR11MB8063.namprd11.prod.outlook.com (2603:10b6:510:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 09:57:15 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 09:57:14 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "kirill.shutemov@linux.intel.com"
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
Thread-Index: AQHbk0LVFxyjNnYqNkeu66oD/Vuva7NxtaGAgACvUICABeeFAIAB95YA
Date: Wed, 19 Mar 2025 09:57:14 +0000
Message-ID: <a0e5d74162354028b80912ab4fcdd0b35692090b.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
		 <ebe4c0e8fe1b78c014bbc18832ae0eec8fef419d.1741778537.git.kai.huang@intel.com>
		 <1050a84caa9036e3ddb580fb510e634a216e692c.camel@intel.com>
		 <40b14084af8a35af4e07fbd394821f92d0973d32.camel@intel.com>
	 <15521a8142a83acfd2f41712e4cd93a3d1a8a28d.camel@intel.com>
In-Reply-To: <15521a8142a83acfd2f41712e4cd93a3d1a8a28d.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH8PR11MB8063:EE_
x-ms-office365-filtering-correlation-id: dd49b049-e5f0-4e00-ae82-08dd66cc6d35
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TnFLUWx3SHdSbnE3a0dWN0Vwc3Z1OGJqekdKY1hEYVYrdjZWdlZ2UG5MWUF0?=
 =?utf-8?B?VUN4R05hZ01aSlZpV215MkFFNVR0UUdXdFRhMFhSN2lwUWZ0WlUwc2plOHVJ?=
 =?utf-8?B?YUhkNkNPMkZsUmhNdmQ0K2lhZTVFV21FVUhnNjVrNzNManpoOHA3ejNnR2U4?=
 =?utf-8?B?bGhmRVJNZlR6dFJGcHUvakFpR29YTnhzUmlQV1lFaXhRTDdqeUhDRU1peUdS?=
 =?utf-8?B?Y0hUTUdMYW5XQWlZYkVYU2FVM2JhWXpkSXhhK1NINmYyZWhsOXoxMklJeTlE?=
 =?utf-8?B?cDZkc0lDV3g3ZFVjQVJjWm5hZ2c3Z29SY2gzQllqTWt5a1c1RXRTU0hWMHFu?=
 =?utf-8?B?N1V5cE1YclRnUGV5ckdXVm01VGxpZVpLSDcwUnlEUmFTZEh5elRZaHlCWnE1?=
 =?utf-8?B?RTlhd1Y3K0Z4K1ZjTUhPM2dQN2s5NDdJbEgzVWdKM2RUUnRYNHg2K3RlS3dn?=
 =?utf-8?B?YncyY0lFb1VnSG9DTjBRSDFoL21xeWdqN3U2OG4rai9mV0ZDYXV0R2RiTHlw?=
 =?utf-8?B?RGh3QVJiZFE1MnRmajN2S1pqWmkrZTFHdnpCRWRxK0JRLy94RllIWm1tNUZs?=
 =?utf-8?B?OHh6Y1JGZ2NaRnp3VkxxQlVCbFRhaG9udE5Da0hYN0htKzUzbHBuUDZUOVRy?=
 =?utf-8?B?SVpSYjlKa0x2MUhsd2x2eEJXWkxKd2FFcDRmeVNjK0NIWkxvYmJOWHlGOGhz?=
 =?utf-8?B?YzB3SUtaTUNWdkpVTkh0cGFtamVmUmtmcmszZ3F6aUFvK2xrV3lnUjQ0TnlT?=
 =?utf-8?B?enc1Skk2dk1rQlE4dGFUOVFZS0RiOUV4czRGNXFHQk1od2txRHpZbzhBeUVS?=
 =?utf-8?B?emxJdXBSYXNBdXFsWUExb0Zpdks5UEZhUDdkT01JaXFEY3RaWFN3T2ZObG83?=
 =?utf-8?B?dzB4NkJXZ1g5RW5lMkhEZGF2R1BNUCs2MTkrYzc3aGlNdTh5UVFIdU02ZWdV?=
 =?utf-8?B?K3JhUmtvNEtGZXRlUEpWeWRHb2svT3N3MTB5dWRDajRzRURDT0tsNE1LbDVa?=
 =?utf-8?B?em1jWHdrVk5RV2RaUnRCaHZnUmFKY3JDS3FyL2FtZlB2bnl5S3orQklaMmlE?=
 =?utf-8?B?RHZXNmp2aVVUUTJFQnZjaTRoM2F4QmhYazRnRWducExCaVhteHljR0ZvWmdv?=
 =?utf-8?B?Q21TZEhySm5sV3Y5S2k3bGxNdWY3eExXdzNmQ0s0MU4wOE8xT0VvZnVQQ2N6?=
 =?utf-8?B?YkJxTnE1UGZsZ2dwVnhDdm5Ca3ZnLzAydy9QaHozVG5XNnBVM1NJbXhpaVEv?=
 =?utf-8?B?eWpUdWhqcUthajZ1d201cnlLemVHamdUcUduTVJsMzFnYTg4OENaajBpQnQw?=
 =?utf-8?B?N3lyaWgyVmZVSHd2WFlXM2RGSDR2VDlnN1loaEFtSXRGakl5N2hQTEhJSXlm?=
 =?utf-8?B?SVE0UEhnSmZQcUVENThqL0FVeTd0enNCQzl2TXN2bVJIUkVVaEN6ZmUydUlO?=
 =?utf-8?B?UkdxbjRBODhNV2Z0QVhJUWNIQUFYZ3ppWmJMRVFrbzZxR0dmQjdIcWtieFFU?=
 =?utf-8?B?TXVtaWI0dVNVN1B4eUV4NGlOTW9MVUtHWXVpNFdjQmtFRUpZODZYMlZBeld4?=
 =?utf-8?B?OUh6Z2ZDYlRYVTBNdFo5Ui85aHU4M0psMlF1QkxLeHFkMkhjamg5Ri9mYUE2?=
 =?utf-8?B?SWZLaktQUkdNb0FFOVhMMUlPcys1NGpJOHhibTk5cWw5UUhVSncySUV1Umhn?=
 =?utf-8?B?KzN5WTVGQWhUOE5Ib1o1dEYvQzBKMWFqQVBoWjRJNTh1ZTN1eHRJeHJLK0FC?=
 =?utf-8?B?MHc5ZHVuNmxsbjlQM0xrMmt2S2FPTnhMZm5pSHdnek5FQStCTDJYQlhlWjR5?=
 =?utf-8?B?NVJLemx6dzFvUE5vV2xtbnowNXhrcW5BaVQ2cXhOU2NqNDFSaTNFaDhYT2l2?=
 =?utf-8?B?NXhQRkhjamFUcFlnUUdsdkpVNExPeE52K0RsODNaU1Jpbk1JV3F1TWMrbHRU?=
 =?utf-8?Q?D0dBumV6+TqtiuoWcrLVE+yVOje1r2Hq?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnAyYlB6ZFdrZnQzYmMxRkxFYkxlZ0Fnd3lFQlplUFV6ZUhnbWl1MzNUcjNX?=
 =?utf-8?B?bU5idVlKbEplVFBTMkdqNEdOb045SjBoa3FwNnoyK1MwZW0wcVh0bDZ2UU9C?=
 =?utf-8?B?bkYxRmliaExmdHJna0dEWWVLMFVqVkJKOXI3eE5xVnhxZ2lnSFgvVkRhdFNK?=
 =?utf-8?B?a0t5TUxUZFl4S2F1UjFLSzQzT05yaTY1dVZKNVVMbFpFTU9VVUFqdjFOUXRV?=
 =?utf-8?B?b0VPRUlYVGQxMjNYNjlHK3dLWThoVFFrTVVLSW1BNVc0S0FGNXBETzBQWDQ4?=
 =?utf-8?B?cVlEdUZOZmlpNURCdVY0YnVJMmFOcVI5VEkxODRDdXlpTlh4aDcramUreHpx?=
 =?utf-8?B?aUJ3cmV4ZXI4enU0UzkvY0VnWDZyOVNJbmUyalBsY2c4ZExxMUJ6OVJnaFpw?=
 =?utf-8?B?ZHRxOFNNN09lYlJkWTRCeXhLc1hQbzBxdEkyWnZDMnNIeThLZTZvdVgyV1lU?=
 =?utf-8?B?RTVXNHF0blR4MG1MRDVlaHR1ZlBFcWx4UWx4Q0lBRWZZcUxSTWhGaFlzSHpW?=
 =?utf-8?B?SUZTc3Y0MWQzUVFjNldYclkyRzVwRG5UQVQvaEpUWnRZVWtwaS9Vd2wrVmEr?=
 =?utf-8?B?VVpQM29Jd0hrc0FVSmt1Wm1QbThBRExCM0lVSVB3K0pHM3Q3MnQ1UFpnVTh0?=
 =?utf-8?B?T1BwUUMrL05qZ25lSHRGMCtvdUVtSEJLZmUzV0RjWFplSkJKUTNnOVNWMmRQ?=
 =?utf-8?B?Ny8wZU5jQ1V6RmJ2V08vc3Fva2hlM3JzMXRhN0ZyMEN5SzdOcUJyRGsyckl3?=
 =?utf-8?B?Q1FNY1dtS2N1K0xFaDkrUHZvVHBpaE1uaWtNK2srWWJJYzZmL3J4TWxOR01y?=
 =?utf-8?B?YTVGcWx1bWFUSFRRSVNaQkl1N29id2VXTDExeFZiWUxaY0NUNHZOUDNKU1FE?=
 =?utf-8?B?U2IvT0s4WG5PbVl4UW82QjNySndpSjJOamNHbTZXa2JWVUJGZHNRVzd5QzBn?=
 =?utf-8?B?VENZWm9oa2sxK3JwcDZPRUFJSzZwcW1PdlI1ZmdtYnRJQVpDWUJBQ0pGbmtF?=
 =?utf-8?B?VUlFWXlTTUNhMlhPSFRmQVFIY0F6UXJ0amlTVU12dVNXKy80Tlo4NFBXQkZa?=
 =?utf-8?B?NXdOK2laYk00Nk9IaEdFQkRPSFZnRERwOEJJT1MwdjVVb3EyU0pYSWliTWVs?=
 =?utf-8?B?aTYwSkIva2p0N1IvMFYwM1VTMUdEK1dOOEtTVUxNZWt4NEttNFRMbDZFVTQz?=
 =?utf-8?B?dE1aT3gxVGhCQmJSbjliSkNUODNtMnBGc3dSZHljRDNjdDdDTHNYOG4wZlJr?=
 =?utf-8?B?b202NXZUWmZoUXEwdzNlUmFpSmtUQkZIdHIramJMT0V5UHZCS1BIUFNHT1c0?=
 =?utf-8?B?MnA2b1FEM0t4MFNBNC85VGl6WTZMcEdWbFV0L2RZRm1HUGZNOEdSVjJtVDFS?=
 =?utf-8?B?eVNLVkxBU3QzNi82NTk0RXA0cHBFM0FSczhFbkU1eVZIWnZnY2l2anR2WXEy?=
 =?utf-8?B?VHN0VkF6UTkzcGY5SllTVDJFMUpaeGNtSW96ZW80RWMyUURqQ2dnNytBVUtt?=
 =?utf-8?B?VVRhNDNmM2FVWmdFZDJwdUNiWUZkZ01xMjN3eGZpVjdLdEVRTVk3aUp4QnZw?=
 =?utf-8?B?NWkzTi9XbGdMTzJLVFh6dTVZSmVUWlpJQ1JTYmptUTl6RHRyb2JlRFNNR0ZV?=
 =?utf-8?B?WVlKWVA4S1hZbkI5SlN0Y0tzU0lrRlp1Tkd6OGlwVno0Q3lidDQzdmZraHRJ?=
 =?utf-8?B?QTlEODBWNlh5amFRUGlldEhYc0ZyZnhpUC9CL1RsQjZ2ZDF6dHZGcHcwaVVR?=
 =?utf-8?B?bmwxdXVwS0RsSlJvY1p4bzhGazFoZFlrRThQcGtMN3hERnlFMzZhOENMQW44?=
 =?utf-8?B?YjZUcGZEMk03cVZaZGIrVDgxUGlkbVBBVE1xT1dXK2JRZk9nTkNmK3piUTJL?=
 =?utf-8?B?eTJSRnh6U3BUUkJleGJlTWtVMTAxQldOWTU5ZVlQNWowQzJ4MnoycXZSV2V2?=
 =?utf-8?B?R0hxRytOVXZKSXhvcEdvZkNuVTV1OFFoSi9yTWQza3JQMjlDdllGa3pXYW5w?=
 =?utf-8?B?ZUJlYWdWOVVVaUlyOW5ZeWpyT1hJOW1uNHJUd28rYi9wL2hzTSs3a0lVSExB?=
 =?utf-8?B?N0piL2NzbjJHbU5iNG40dGkyMWhkQ1ZINWxiMmdkVlpYNUx5ODlLSlU3Tk5D?=
 =?utf-8?Q?sslMp+ps/gYIdRBvmR14JZnLi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46792BD1EA2FA7439DDE07767B080CAD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd49b049-e5f0-4e00-ae82-08dd66cc6d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 09:57:14.7915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5HSon8k9zE1ZlIjLJ3JNCw2Q89ZYdjAZ8Bd12Wz1fm8dGLBlS6BYTZeVMuQdGcONTDD/7MMbwYUTH2dYoQ+l2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8063
X-OriginatorOrg: intel.com

PiA+IA0KPiA+ID4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5jDQo+
ID4gPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMNCj4gPiA+ID4g
QEAgLTM0NiwxNiArMzQ2LDkgQEAgdm9pZCBfX25vY2ZpIG1hY2hpbmVfa2V4ZWMoc3RydWN0IGtp
bWFnZSAqaW1hZ2UpDQo+ID4gPiA+ICB7DQo+ID4gPiA+ICAJdW5zaWduZWQgbG9uZyByZWxvY19z
dGFydCA9ICh1bnNpZ25lZCBsb25nKV9fcmVsb2NhdGVfa2VybmVsX3N0YXJ0Ow0KPiA+ID4gPiAg
CXJlbG9jYXRlX2tlcm5lbF9mbiAqcmVsb2NhdGVfa2VybmVsX3B0cjsNCj4gPiA+ID4gLQl1bnNp
Z25lZCBpbnQgaG9zdF9tZW1fZW5jX2FjdGl2ZTsNCj4gPiA+ID4gIAlpbnQgc2F2ZV9mdHJhY2Vf
ZW5hYmxlZDsNCj4gPiA+ID4gIAl2b2lkICpjb250cm9sX3BhZ2U7DQo+ID4gPiA+ICANCj4gPiA+
ID4gLQkvKg0KPiA+ID4gPiAtCSAqIFRoaXMgbXVzdCBiZSBkb25lIGJlZm9yZSBsb2FkX3NlZ21l
bnRzKCkgc2luY2UgaWYgY2FsbCBkZXB0aCB0cmFja2luZw0KPiA+ID4gPiAtCSAqIGlzIHVzZWQg
dGhlbiBHUyBtdXN0IGJlIHZhbGlkIHRvIG1ha2UgYW55IGZ1bmN0aW9uIGNhbGxzLg0KPiA+ID4g
PiAtCSAqLw0KPiA+ID4gPiAtCWhvc3RfbWVtX2VuY19hY3RpdmUgPSBjY19wbGF0Zm9ybV9oYXMo
Q0NfQVRUUl9IT1NUX01FTV9FTkNSWVBUKTsNCj4gPiA+ID4gLQ0KPiA+ID4gPiAgI2lmZGVmIENP
TkZJR19LRVhFQ19KVU1QDQo+ID4gPiA+ICAJaWYgKGltYWdlLT5wcmVzZXJ2ZV9jb250ZXh0KQ0K
PiA+ID4gPiAgCQlzYXZlX3Byb2Nlc3Nvcl9zdGF0ZSgpOw0KPiA+ID4gPiBAQCAtMzk4LDYgKzM5
MSwxMSBAQCB2b2lkIF9fbm9jZmkgbWFjaGluZV9rZXhlYyhzdHJ1Y3Qga2ltYWdlICppbWFnZSkN
Cj4gPiA+ID4gIAkgKg0KPiA+ID4gPiAgCSAqIEkgdGFrZSBhZHZhbnRhZ2Ugb2YgdGhpcyBoZXJl
IGJ5IGZvcmNlIGxvYWRpbmcgdGhlDQo+ID4gPiA+ICAJICogc2VnbWVudHMsIGJlZm9yZSBJIHph
cCB0aGUgZ2R0IHdpdGggYW4gaW52YWxpZCB2YWx1ZS4NCj4gPiA+ID4gKwkgKg0KPiA+ID4gPiAr
CSAqIGxvYWRfc2VnbWVudHMoKSByZXNldHMgR1MgdG8gMC4gIERvbid0IG1ha2UgYW55IGZ1bmN0
aW9uIGNhbGwNCj4gPiA+ID4gKwkgKiBhZnRlciBoZXJlIHNpbmNlIGNhbGwgZGVwdGggdHJhY2tp
bmcgdXNlcyBwZXItQ1BVIHZhcmlhYmxlcyB0bw0KPiA+ID4gPiArCSAqIG9wZXJhdGUgKHJlbG9j
YXRlX2tlcm5lbCgpIGlzIGV4cGxpY2l0bHkgaWdub3JlZCBieSBjYWxsIGRlcHRoDQo+ID4gPiA+
ICsJICogdHJhY2tpbmcpLg0KPiA+ID4gDQo+ID4gPiBJIHRoaW5rIEkgc3VnZ2VzdGVkIHlvdSBz
aG91bGQgY2FsbCBvdXQgdGhlIG9wcG9ydHVuaXN0aWMgY2hhbmdlIGhlcmUgaW4gdGhlDQo+ID4g
PiBsb2cuIERpZCB5b3UgZGlzYWdyZWU/DQo+ID4gDQo+ID4gSSByZXBsaWVkIHRoaXMgd2FzIHN1
Z2dlc3RlZCBieSBEYXZpZCBLYXBsYW4sIGJ1dCBJIGd1ZXNzIEkgZm9yZ290IHRvIHJlcGx5IHRo
ZQ0KPiA+ICJvcHBvcnR1bmlzdGljIiBwYXJ0Lg0KPiA+IA0KPiA+IEkgZG9uJ3QgdGhpbmsgdGhp
cyBpcyBvcHBvcnR1bmlzdGljIGNoYW5nZS4gIEl0J3MgYSB2YWxpZCBjb21tZW50IGFmdGVyIHRo
ZSANCj4gPiAnaG9zdF9tZW1fZW5jX2FjdGl2ZScgdmFyaWFibGUgYW5kIHRoZSBjb21tZW50IGFy
b3VuZCBpdCB3ZXJlIHJlbW92ZWQuDQo+IA0KPiBJdCdzIHZhbGlkIGJlZm9yZSB0b28uIFNvIGl0
J3MgYSBzZXBhcmF0ZSBjaGFuZ2UuwqANCj4gDQoNCkkgdHJpZWQgdG8gdW5kZXJzdGFuZCB3aGF0
IHlvdSBtZWFuIGhlcmUsIGJ1dCBJIGFtIG5vdCBzdXJlIEkgYW0gZm9sbG93aW5nLiAgTXkNCnRo
aW5raW5nOg0KDQpCZWZvcmUgdGhpcyBjb2RlIGNoYW5nZSwgaW4gdGhlIGV4aXN0aW5nIGNvZGUg
dGhlcmUncyBhIGNvbW1lbnQgcmlnaHQgYmVmb3JlIHRoZQ0KJ2hvc3RfbWVtX2VuY19hY3RpdmUn
IHZhcmlhYmxlIHRvIGV4cGxhaW4gd2h5IHRoaXMgdmFyaWFibGUgaXMgbmVlZGVkICh3aGljaCBp
cw0KYmVjYXVzZSBvZiBkZXB0aCB0cmFja2luZykuDQoNCkFmdGVyIHdlIHJlbW92ZSAnaG9zdF9t
ZW1fZW5jX2FjdGl2ZScgYW5kIHRoZSBjb21tZW50IGJlZm9yZSBpdCwgdGhlcmUncyBubw0KY29t
bWVudCB0byBtZW50aW9uIGFueXRoaW5nIGFib3V0IGRlcHRoIHRyYWNraW5nIGhlcmUuICBTbyBj
b21wYXJpbmcgdG8gdGhlDQpleGlzdGluZyBjb2RlLCB3ZSBsb3N0IGluZm9ybWF0aW9uIHdoaWNo
IGlzIGFjdHVhbGx5IGhlbHBmdWwuDQoNClRvIHN0aWxsIGtlZXAgdGhlIGhlbHBmdWwgaW5mb3Jt
YXRpb24gYWJvdXQgdGhlIGRlcHRoIHRyYWNraW5nLCBhIG5ldyBjb21tZW50IGlzDQphZGRlZCBi
ZWZvcmUgbG9hZF9zZWdtZW50cygpLg0KDQpDb3VsZCB5b3UgZXhwbGFpbiB3aHkgdGhpcyBpcyBh
IHNlcGFyYXRlL2V4dHJhIGNoYW5nZT8NCg0KTmV2ZXJ0aGVsZXNzLCBhcmUgeW91IGxvb2tpbmcg
Zm9yIHNvbWV0aGluZyBsaWtlIGJlbG93IGluIHRoZSBjaGFuZ2Vsb2c/DQoNCiAgV2l0aCB0aGUg
J2hvc3RfbWVtX2VuY19hY3RpdmUnIGFuZCB0aGUgY29tbWVudCBhcm91bmQgaXQgcmVtb3ZlZCwN
CiAgdGhlwqBpbmZvcm1hdGlvbiBhYm91dCBkZXB0aCB0cmFja2luZyBubyBsb25nZXIgZXhpc3Rz
LiAgRXhwYW5kIHRoZcKgDQogIGNvbW1lbnTCoGFyb3VuZCBsb2FkX3NlZ21lbnRzKCkgdG8gbWVu
dGlvbiB0aGF0IGR1ZSB0byBkZXB0aCB0cmFja2luZw0KICBub8KgZnVuY3Rpb24gY2FsbCBjYW4g
YmUgbWFkZSBhZnRlciBsb2FkX3NlZ21lbnRzKCkuDQo=

