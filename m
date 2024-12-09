Return-Path: <linux-kernel+bounces-436859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E979E8BBD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2939F281274
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CFA21481D;
	Mon,  9 Dec 2024 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUgMEV46"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B233D1D555
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733727466; cv=fail; b=R5GW6vc1Ije6cqXI96y445B2sPpKLodxeFek7TMl+ykj4w86EvkojW4qJFwTW2oMNoU7qobqS6VHbsNTIJwqRziloKDNUY2jBJbfN8il/blOK5aCdGhopi9hXdmlp2WULw4LfEg6043zIh4r3W+1Riaj1Fx2CKlXESsI8J95pTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733727466; c=relaxed/simple;
	bh=8Nn7K5D2+X9oUYKmYyWEJ6cX4Vrsi1G0cO2B4Vfsouk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EbRQCvMgkfbYCj9fY58zSfNjJqdDXLbLsTELf1+yVcWLt8ovssEKrirAubJcCsFsrFTTam5YQoT6nqWV3IkYwj1jd20F1XFAoDKOjU+sCGlvOa51KNa+tUQOuBVUV/rBo7EWhAGLgHRO6nYWdRETQMZyCZFtfR572Xa1/p8Yp9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUgMEV46; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733727465; x=1765263465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8Nn7K5D2+X9oUYKmYyWEJ6cX4Vrsi1G0cO2B4Vfsouk=;
  b=mUgMEV46IUuoKbnC0ttkP32CTQZ0bz1GWtSrFTeM22HOFUkSMNPRn2hB
   BHZrNmwKjZSaKG0iNIHBFT8kL1MlsaRRQG45ljRkym1JBjEOWM/51PPb7
   Ek3G8+OVKHEQTiXGFVVYkGfdDZOVWQpR7USfMBY7mv50/miganmaqBBk3
   c/X3FNgkOYuPkCbe+CIh3wS+DrNq1VxK3HlMxkw4gqhYJ2BKHPnulHVrT
   w9/ZLzT65ow4lobIvhw/MldQp//jcZWeOiZmgXaDyB2QUiQ1NWy8sFjX/
   5gprs1ubtSVlnVxWd/ht0ytulCfzY+yCydpTb3vq9UJsyqFSAIFrSZPw/
   A==;
X-CSE-ConnectionGUID: 6kuIOTWeTnW9hQNcuCePWA==
X-CSE-MsgGUID: uz4uN6ODQJilzR/0I344kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="21600921"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="21600921"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 22:57:44 -0800
X-CSE-ConnectionGUID: FqpHeuiVTF2eeF4jo22nFg==
X-CSE-MsgGUID: jXhoLy8IQiaqzYruFSxS+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="95321176"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2024 22:57:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Dec 2024 22:57:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 8 Dec 2024 22:57:42 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 8 Dec 2024 22:57:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bw2yO9k9D9Kisg7gzlYW5MigxvafDKJ8R4F4kX3giS49m6/PFgXuFTtl90DGzk+oYD7iN12FB+Oj36wRUVWvr4KtKXVxVt2Fo3S26lzRif1gVkXkwgXLAchTIMR1e5h4TdvikYq1DmWEBRMtMnC56kHxFoUYMTIlDakXp7AqIBJgpDH8C0IYbAwfJWd4gaEChdZP2wApYemARuJfN+oAfs8osyvWqeC6kFD9gZu3t9sfX1agQb6dDw1R+Pb3yCpRN+qnyrNDpTQIDaq0N7i4/i+Ni5FpFVJB8T5V8/KZANS37LIS3TO6dVy6PTXaHH7MyTCpThkR2gRCLHbpe0XXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Nn7K5D2+X9oUYKmYyWEJ6cX4Vrsi1G0cO2B4Vfsouk=;
 b=ALOB4a71rSUu31PBGfGUMXbJOeV3ZcgFuHFmTAkTVu9k/RsszUut5PW+N4X/Sz1ICsIKU4RFDiWnL9txj750PEhYfHghKkeHE/rmcYx6cOknBB1v/ptxe6cMHMUEuz+2KuM20maooOjNiXbvzDMwimmwABMBdbmwl40UjIE7koCsk8n0YjmzICXiX/pQi5NDJ1VcOaLM/37Sn5mftMKkwOgn1oZntI9gR6iyXJY8gQIf+lwUXEQwhjn3LYK+VkOtJcVtxDj2A91Gonf81CDm4KWOu2yDGnjH3M5SuB8oPhQ/vrpnLArKd/jhg1zV5ejuodYZ8bF4d4lNEa40a4Vrjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB7495.namprd11.prod.outlook.com (2603:10b6:510:289::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 06:57:39 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.8207.017; Mon, 9 Dec 2024
 06:57:38 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>
CC: "nik.borisov@suse.com" <nik.borisov@suse.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>, "Yamahata,
 Isaku" <isaku.yamahata@intel.com>
Subject: Re: [PATCH v8 8.1/9] x86/virt/tdx: Reduce TDMR's reserved areas by
 using CMRs to find memory holes
Thread-Topic: [PATCH v8 8.1/9] x86/virt/tdx: Reduce TDMR's reserved areas by
 using CMRs to find memory holes
Thread-Index: AQHbRxLpcyNtIOXDR0KvQ+0YSsApfLLX87IAgAWNaIA=
Date: Mon, 9 Dec 2024 06:57:38 +0000
Message-ID: <626ac144649dd183bc9a9f9b021db3c841a70fec.camel@intel.com>
References: <23bb421e9bf5443a823e163fb2d899760d9f14a3.1731498635.git.kai.huang@intel.com>
	 <20241205124005.92615-1-kai.huang@intel.com>
	 <0efe8492-e0da-4d97-8a6c-9cfe718f2d63@intel.com>
In-Reply-To: <0efe8492-e0da-4d97-8a6c-9cfe718f2d63@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.2 (3.54.2-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB7495:EE_
x-ms-office365-filtering-correlation-id: 8f9dc689-b332-46cc-0b16-08dd181ec4fd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K1pFVkN6ZzlNaHpoL090UXN3Njc2NVVwd3FLaXI4N3lPdWpXSzNrV2Zsemxq?=
 =?utf-8?B?RnJzQ3Uvb09jbzhjQWp0blJ6Q3lRL0hXY05NNk5ON0pqWG8vT0FVOXRvV1pY?=
 =?utf-8?B?QW5JVGdkdEZqb2kyZHdwcVVnSHpsQk9XRTBPK0ZOcjJpYmcvR1NROVBxcXlj?=
 =?utf-8?B?VUxhUnJNR1BidmdnTXRPWGpXa2FUdlN5UmN1czRTaXBOYU9ITC91akR2bXNx?=
 =?utf-8?B?RTRFRlQzeEVkc1hKc3BacGNxWUplVk01MW1zdE95bXJqT2NKQlozMmFGamV1?=
 =?utf-8?B?ZTU4YUM2RXFtVktUR0xUSDVUaVAxNDlwTEMraHhDNjdndlVHSGlQMmpJMDlx?=
 =?utf-8?B?OXlzSHlaWVNzNC84RWVtUVRzOVA2OW13bjJGZVpVeTY4NnNkaCtRRFg0ZnNX?=
 =?utf-8?B?WVREZmdDUTJBTHRkY3FPbktXc2svcHNTdC96VDJJaGdjYWJrZWR3b2NVWHk4?=
 =?utf-8?B?YW9mSEpmK3YxaXZtejhlczJ3Z3NVaXdBY0VNK2ZoMUJxNHdvdGkzQlp4NTh0?=
 =?utf-8?B?NTlTSzRxOXBMNlVKRGxQb0pjZ1FqU2ppZWFydndEQkk5RE5zQ0RQQ09kZXNo?=
 =?utf-8?B?WXlrQWpCRUhnd0VGbGRIcFVadTBhaWE1UXdaSzNQNHpkY0lnOXd4eHRZaXRE?=
 =?utf-8?B?ajE1RGtQM1lCMGtRWXBWV1lveVI2OTl4WnpScHRRV0hYdnU0bEQreHd1Zjh1?=
 =?utf-8?B?R3ZWZFdGbU43MzVjeCsrOHF3UmR4cFpTZ1JIYzFsOXExaklvUkxudFVPQVpZ?=
 =?utf-8?B?dmUxOThlL3BNenJCR2VPSENGbG9FUlNyd3hsRW1wdVZRRlJSSzh1b0JyTWlD?=
 =?utf-8?B?VDBNdVpLamJERmJMUmZsUDFLKzhjUEZOdjFFWG5PdVh4NEFnY1NwYTMyZ1Vk?=
 =?utf-8?B?VW40QjEyVHU3QTFLQmpqMjl5amJkL0lwWVV1M1d5KzBaTHh6dmdHRTlXS01J?=
 =?utf-8?B?Mzh5aWhvZVlzbXFUbElqVUtmcFh6djNzT280V003OTdoSXBIMlZXVkJGVEdI?=
 =?utf-8?B?bG5FT1BvOW02UTFxVXE2amZiUjRjSzZBb1dwTEVFZC9QNkIwU2JnK1BzMjJP?=
 =?utf-8?B?aE1rZE1zTzc3dlRWRXVZSUFyeDlQQmQvRnNYQkFOVG9zV0IrUFJwR2drdU5U?=
 =?utf-8?B?ZmZFTzg0Rk1RSVFKMDhKS3pCcG9jeDF0dXV6cjBiWnlRcmZHd2RBOGFUVWJ2?=
 =?utf-8?B?d3l0OTM0WWpacHI0U2IyL1daK25BU0xFUk1PT1I4cHB6RlBhVWt2VFNzVGR5?=
 =?utf-8?B?cGc3NFVScGRQUDVEV21TcmZ1SnpTY0IyWE90K0oyUERKMVFYSG9Ra21HRU5C?=
 =?utf-8?B?SmIyN0N0eTU5Y2plbS9MTFk3dDlvT21iaGcxOCt0anZ3QWdnKzdWbEFGQmxO?=
 =?utf-8?B?d0ZtL3FYYlZMVWpBbWNiMmdySjkxdWZHWGF1c1NxMXVlejNKb2pUdXNlZFVy?=
 =?utf-8?B?dWFQSFhrWDJUN1lOdE8yMkNDblQ4c2FGMlZGeTVRMWdoN1ZJQmgvZVhJaFVZ?=
 =?utf-8?B?NE5TaGxGTWMzNG1VbERwVmd4amZkTU5OSi84NEdsbU1SL2xFdjV0UzFua0Mw?=
 =?utf-8?B?OGladjJNcm5rdjN3djNwdTZJUE4yZ254WVJYTVB6NXNCcVFyMXljYWY0cmhM?=
 =?utf-8?B?NnRPNXlkUDF0Y015MGtOK3Bsdm9EYUFscFRMK0tyS3ZEYklmb0U2Rmh0akZh?=
 =?utf-8?B?U0NMQmhvZEFWSWN6Z0g0bFVybWpOSitHNTRaSXFaVDlRZjA1dExGMGI2VktP?=
 =?utf-8?B?QkxEMWQ1WXZPcE4vN1doNmhiQ0JhbUJuODkySkhTQUcxenJBVVhjMkUxSUZp?=
 =?utf-8?B?WFVLTWZCa3VTRUlGdWswS3krcFFiS1IvQ2g2Y0VWK0dsMkJEd0V1SnM3bVp0?=
 =?utf-8?B?RHpSUDJxUjBwbW9Takk4cG00MzBXdlE0Yk1IQklWUXFFN2NFdnd2Y3BoVzVM?=
 =?utf-8?Q?pOpfDcdlkKE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alY5c0xMbmRDNlpKUU5Oc2NSRW4zamlQcWc5akFsY3FZYkJCSyt1S3lPc3RM?=
 =?utf-8?B?by9McnFxUlQyQnNNb3lJN3dReGF5U2luRDAwNnhGK0s3UDYvaTM1THRoZHV2?=
 =?utf-8?B?dHBybk9TU3E4MFk2WWNHRTFoa3NkOEpUSkwrVHBEYms5QXBNaGMvaFM4U1BG?=
 =?utf-8?B?bFNBbWk0NEZ5RHRGZE9DTHNLV3hYcG9xcm1NWmtpUWxxVTY5WnBpOFMxejZF?=
 =?utf-8?B?QTEvdWRQdFNPbzlKMUUxWlZPSEEzNDl6UEpQRVQ0bmNLd2ZMa2pDV293c0ls?=
 =?utf-8?B?eE5FWFMyblNhdjA3Vit3aVp3STQzc0pzeERjMmV6VStGSGNFTk1NOFBtb3VS?=
 =?utf-8?B?VG9pMWFWNFdjaGhCNndCeXRpUy9vcHZGWXNsdnozRDkyZnVla1lnNzdBa1JC?=
 =?utf-8?B?NnNWbGFjY3VwSVdHUU52SlVXelpIOW1zclpnck9WcmRYK0JiQTVaMlEzeGty?=
 =?utf-8?B?SWVUL0xxVk5UOXVjeXY2cDJTZ3grek4zN0c0Ym85aDA1aTExQ3RTemlXaEUx?=
 =?utf-8?B?K001MGkxNnp3TGF2Y0YveWNGU3N2anE0aDZ6dGpRYWdUejdXZTVYd010L1hl?=
 =?utf-8?B?MCtMM1lhb3NOL3E3bzhUcVFlNUVKOU11N3FvOFJBMkZuYndqYTZyZ2ZnNVRO?=
 =?utf-8?B?bVNKUVBvdnVIbHJVQUVXMmlmcWw2OFlobG1iQmxOaW9aWDdCS0pLbXY0ZHlr?=
 =?utf-8?B?cHhaeWhPS0xnY1RNVEZZc0dYTFVWMUY1eEJiK0ZUS1FNZmRsVXJoWXJtSFlm?=
 =?utf-8?B?T1RUTmt3ellqd2tlSnVWM042TWphT1JFLytjMHR0dmpOeTRTczlXVW1yNVBN?=
 =?utf-8?B?Tm1vSnZYeXhtMTVTelhZUjhMb1RaS1NVNkJkS3AzVGxCRFlvZ0locVdwb1BT?=
 =?utf-8?B?cENxQjhmWk8ralo3T1NuSkRrMlMwQ3BHamc1dXh1WUJXci9jVno2YkdBN2Rp?=
 =?utf-8?B?V2xSUnRqL3hGWEtQdDB2d1JhTmVBUXpIek4vVlZGcFhRVHRCVm5UZkxTUGRD?=
 =?utf-8?B?azVPT0tDbXI4UVhzbHg1MWxsMG12R2ljMHRObEFIZ2V1UDZ1S1kyUFRHbmdT?=
 =?utf-8?B?NUhPVXBLTnRBbnBTRHpSamp2ZE1iUkNoUFVOZzRZamtEeDFaY1d5N0JwWWFE?=
 =?utf-8?B?MytObWRybGRxL1UxLzROdFZPQ2ppQ3FTRko2SUR6N24ySUJxdmRjdG9iQ0Fx?=
 =?utf-8?B?Mm9mMGh3VHNUakxLZm9kY2hVUG56NjZqWHJHN2JwY0dIM2p4SmEzVFN2aTBu?=
 =?utf-8?B?ejh0Sy81ekM3NFcxZG9xRjE2OTU0UnpzTnJHYzQ1czYyRHlVKy9sbXpWUWlV?=
 =?utf-8?B?ckxYaXhvUnZ1Ti9mSVVMbys3ODhMVDBETHRkYUtTRW40VThNSkxpQWhVZ2Vr?=
 =?utf-8?B?L3ZHL3pqUkw1WDA2SGRnOFRGRVk4NHlIWGdvT00yTndWVnBHWCtveTZUUy9H?=
 =?utf-8?B?VHpLZHFoOVlUbStJYmw2YUdwYnluZGtqTmcvZnNFZkpJS0w1Q0cxN3NpRW9T?=
 =?utf-8?B?MXl3ejUrZkZFY0xIQ1cwYlVOdzZKUVBzcHAwVlUyMGU4N3hnZlJ3YW9peWx1?=
 =?utf-8?B?b0Q5SXIydmsrQXlYRGp1RURIbVBiR05GZzdORWxQUnVnaG5UdkpsSDRMbmRl?=
 =?utf-8?B?VStIQjlPekxDMFlMQXMxRUw1KzR5eGg4MUlBUkZBbVVUSVZSdHQxNGIwTk51?=
 =?utf-8?B?N1RFMTBiZnI0bzBmZG1lYjhNMGFzRXYvRDRtTDgxS1RUTkQ4SlNLa3hIcisv?=
 =?utf-8?B?a0ZOV1dMODZ6Z0x6czY4MWJ0U3JhTkdvVUV6SUVYRElyQ1VpeWUzeDFVU0Ju?=
 =?utf-8?B?czBYRzkwSmxQT3ZzODkzRzQ5TC9QS1VEVW9sMEtUZXZKWStyWE96UWpUUWlw?=
 =?utf-8?B?K2NWd0VQYXZBc2NMSDZZTzBReDN2OWpIaFhYMUFpMmlVdTc0Q3lLamIwdnVU?=
 =?utf-8?B?cWxYaFl5YlpEOTdtOFA4SHZuV3dEdHFoRnA1RW95eVlpbFFQWklrdWN4WUxh?=
 =?utf-8?B?a2dpYmpFTFV6bldZSGpxVSsxWFBWWlg3emZaZjhBU085M05tQm02RlI0c0hF?=
 =?utf-8?B?TStGNjVrZ1JiZUVOdGFVNzliTGVKTWpvK3FtQVRiY0NibG44MWM3NldIU1lq?=
 =?utf-8?Q?qpS6ensIfSoyEdhix8VR6i+9d?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DFCCBDC67C97B4FBA70FB568C66819E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9dc689-b332-46cc-0b16-08dd181ec4fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 06:57:38.9338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1GGHhMJDUEAQUIeg7N4NZEY72kZ0jYASd16hgUNAxdIdn+IHGq8TTaBuUXbsAko6oPw52BlJGHb2ns5GLSYE6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7495
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTEyLTA1IGF0IDEwOjEwIC0wODAwLCBIYW5zZW4sIERhdmUgd3JvdGU6DQo+
IE9uIDEyLzUvMjQgMDQ6NDAsIEthaSBIdWFuZyB3cm90ZToNCj4gPiBBIFREWCBtb2R1bGUgaW5p
dGlhbGl6YXRpb24gZmFpbHVyZSB3YXMgcmVwb3J0ZWQgb24gYSBFbWVyYWxkIFJhcGlkcw0KPiA+
IHBsYXRmb3JtIFsqXToNCj4gPiANCj4gPiAgIHZpcnQvdGR4OiBpbml0aWFsaXphdGlvbiBmYWls
ZWQ6IFRETVIgWzB4MCwgMHg4MDAwMDAwMCk6IHJlc2VydmVkIGFyZWFzIGV4aGF1c3RlZC4NCj4g
PiAgIHZpcnQvdGR4OiBtb2R1bGUgaW5pdGlhbGl6YXRpb24gZmFpbGVkICgtMjgpDQo+IA0KPiBU
aGVyZSdzIGEgKkxPVCogb2YgY2hhbmdlbG9nIGhlcmUsIGJ1dCBJJ20gbm90IHN1cmUgaG93IG11
Y2ggb2YgaXQgaXMNCj4gYWN0dWFsbHkgcmVsZXZhbnQgdG8gdGhlIHByb2JsZW0gYXQgaGFuZC4g
SSBhbHNvIHRoaW5rIGl0J3Mgd3JvbmcgdG8gdG8NCj4gcHJlc2VudCB0aGUgcHJvYmxlbSBhcyBv
bmUgb2YgYmVpbmcgdG9vIGZpbmUtZ3JhaW5lZC4NCj4gDQo+IENvdWxkIHlvdSBwbGVhc2UgcmV3
b3JrIHRoZSBjaGFuZ2Vsb2cgYW5kIHRoZSBjb21tZW50cyB0byBtYWtlIHRoaXMgbW9yZQ0KPiBz
dWNjaW5jdD8NCg0KSGkgRGF2ZSwNCg0KSSBzZW50IG91dCB0aGUgIlBBVENIIHY4IDguMi85Ii4g
IEkgdHJpbW1lZCBkb3duIHRoZSBjaGFuZ2Vsb2cgdG8ga2VlcCBpdA0Kc3VjY2luY3QuICBJIGFs
c28gdHJpbW1lZCB0aGUgY29tbWVudHMgYXJvdW5kIHRoZSBpc19jbXJfc3ViX3JlZ2lvbigpIGlu
DQpidWlsZF90ZHhfbWVtb3J5KCkgYW5kIHRoZSB0ZG1yc19wb3B1bGF0ZV9yc3ZkX2FyZWFzX2Fs
bCgpIGluIGNvbnN0cnVjdF90ZG1ycygpDQp0byBleHBsYWluIHRoZSBjb2RlIGNoYW5nZS4NCg0K
QXBwcmVjaWF0ZSB5b3VyIHJldmlldy4NCg==

