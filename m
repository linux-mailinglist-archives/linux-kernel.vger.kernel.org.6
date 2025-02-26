Return-Path: <linux-kernel+bounces-535011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35842A46DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0093A7F80
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E9925C701;
	Wed, 26 Feb 2025 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGJ4urdB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161FE25B669
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606220; cv=fail; b=PJ29gxhL/rv6udmcUyc6HaL7x49oUeYM7FQWU3B6PMUD9YuXom0J0u/1X2VWvGkH+XLzV94sw9EHD/cVxczpTiINWDXq6NUkaHTQRYefLQwU+KLyeH5eV5tMcgYzcuorpTyCxDAXlMMMYpbiaR+UxmZEM7vO+UfRsT6EyDldDeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606220; c=relaxed/simple;
	bh=b9GwO1BjP0BRA/umIeXIzMASHoNfEFUdGa4Xb8xLQVo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tsudaAjgTQBnyUg3NhTs6geM7oMmxAS6OiGjgOXIwvomWv8lqS8s+DPZzVSKwAg/O7appUdHGbC8GLJdcgN0t9udY4uZ/lJnWdApFCjlXfWwZAkl2BU4UnLc0E9/QO4lZMtlA4SL8X0gih6EvKqBqdT5jfp0OLWIb3GhvKZIBpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XGJ4urdB; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740606218; x=1772142218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b9GwO1BjP0BRA/umIeXIzMASHoNfEFUdGa4Xb8xLQVo=;
  b=XGJ4urdBxC2E8sU0+jEnwpksCRm8wp7C36ysIlXGoGNMIic6VdDBTlOg
   1xRG6QhZ/wbx3UrASW/krMbAeQDZ2KacvdKDPOKRspUp6w8ztAmCns614
   U3SR7iUKozHGsNwWyZvkzG1Y1udEMzZWoW3B0ULkJR6K/a1dQFeE2NErd
   qHBtlK0xd3QOHiSUbfbeKUAozFFSRBA1W/luMocXC2ML4rj4bYJqnm+Lm
   Cg0wki57bmCs27bA9eohISqGt3WPERVAOV3+7bMggdCZbGFkr66j7ATWn
   VNNX+K+0+BqE29ZZsiBUDTlInfEAdodW81qp54S8OhgbQITpHm1ZS6Km6
   g==;
X-CSE-ConnectionGUID: +cxS3jqKSf6kPyyiT9zkLw==
X-CSE-MsgGUID: 57a0WQ0IS7izQtgqlGEjNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41498150"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="41498150"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 13:43:37 -0800
X-CSE-ConnectionGUID: JsKGsGcTQMyy4VZQA8F2/g==
X-CSE-MsgGUID: 9cjFU+/VRV6HY9uD7CQ1BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120949226"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2025 13:43:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Feb 2025 13:43:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 13:43:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 13:43:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEFR1nBSCm2oUVWmNGUKge/iOEZ7QTtlhPXDexcEHtxENI446/DI1iVH1O8WL6uUwejSpB1SPSoTnigkcXip9v6ECVrKqNwaIFWP+6rKCzEnmVSw61NP0CU52eV82qzrtSh6JmuJYGaH0TMEvIiRx3HUSJfBsLpS7fd0+fjVnhTuqh/CgEqIewW9fHmnL20RLqxcql7X96loEEqsFBCMo0sJiQ6Ee1SgGyI7je3GTWmhyEnNum7VrhRz3mpLVBpPU/tuVt4n31Yj52u+iJOswdDFM3pqn+BQeQOFGzN+EvzsIt3raHWnoWMKtxuFOZL6J2o9kvjWxMahqQTIxUc02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9GwO1BjP0BRA/umIeXIzMASHoNfEFUdGa4Xb8xLQVo=;
 b=rMI8yRjDHlUuH0EVdHB5OcVzKFzTnaaCIyaPbwaQAOUssYkMrR4o0biPG7ZeWXGkadgrLOQhtpUQTW6pGOS4JZmcI4hpiJH9xSn/k54lFd0cWYA//G7Fj1L//MNbTpBYWt8anKZIlcLtwp3R72b+3Lind0ck9agmKOo8nBFVuFpMPsY5gJjRcM+mcX3kcdy0g4gezUcV64WIaAiuhZ1uHkdxI3wPNUFMePkkCSWgdaEx9gJwMXroKmI/wUePPVGMXpVp/HT4fhdFNLRkRSsRqdyxIQ7q7bd1GmkyfWhXpfgVEfeje0RCH4f5QIP1GMX8fQlHg5OLFeHEdnLh9301Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by DS0PR11MB7483.namprd11.prod.outlook.com (2603:10b6:8:147::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 21:43:04 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 21:43:04 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>,
	"ak@linux.intel.com" <ak@linux.intel.com>, "Eranian, Stephane"
	<eranian@google.com>
Subject: Re: [PATCH V3 0/5] Support auto counter reload
Thread-Topic: [PATCH V3 0/5] Support auto counter reload
Thread-Index: AQHbflyny140K0ik5UuJ8mlvko1LmbNaMhgA
Date: Wed, 26 Feb 2025 21:43:04 +0000
Message-ID: <41986677e1d2d20da80d3e7366034744b18a1e56.camel@intel.com>
References: <20250213211718.2406744-1-kan.liang@linux.intel.com>
In-Reply-To: <20250213211718.2406744-1-kan.liang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|DS0PR11MB7483:EE_
x-ms-office365-filtering-correlation-id: ccfce0a2-a880-47ba-0a1b-08dd56ae8cee
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bnRvMW9tbUQ3UkVtQTM5SlZKZWNNejFLS2ZFTVdFd3ljemZkZ0wveHpUU2s2?=
 =?utf-8?B?YWR3TFBqYjBTQ3lLZFpWaHFiNVNQZ2VrZkZGOUphZ0xTZTFkZE1wTGY0eEVD?=
 =?utf-8?B?b0U0cmxyR0t1K01HOXBtNSt3ZGp6OE56enlLOTBxS0xWZHNaYk9TT1lYM3Zw?=
 =?utf-8?B?VzNQMncxVXY0dFJqRE1GTTQ1Z3BLOEJucXRRV2NrcUw2T0ZoM2UwakFBY1Rx?=
 =?utf-8?B?Ujk5ZjJNUE5ZamZOKyt1SmswbDl2V1R0UXp6S2ZycXVTSzg2L29tWnNBMHpj?=
 =?utf-8?B?blQzUk41OXNIKzE4RC80ZWRtTyszMmhINkYvVCtwaHROeEh4OFI0cElJU1hu?=
 =?utf-8?B?WEc5YXZ5ZXVKOGlPS0NTTEplQkZ3ZjIyVlZDSG5KbmFjTVl2bjREaDVsbEF4?=
 =?utf-8?B?eFFJNGZsbTNjZVp0OEcxL2plcWRBdHhJYUVHRmtqbnhXWXpKZGo3QlU3Z1ln?=
 =?utf-8?B?RC9QYWpScHlNLzMyUU1oZXN2czcvTTZ6YUdjZjA1b3VUQmVNQ2JqL1RWcmo2?=
 =?utf-8?B?cUs4ZVNpTjQ5b3gyeFJDYlMvNWNGcERiM3NjcWYvdklkbytSL1BSNjdVWjBH?=
 =?utf-8?B?T3VZbnRQOEpvQ0I5OVI4dG04a3lwN2s0eHM4RTdkam95UVR2OS9sVUcvRjUy?=
 =?utf-8?B?SzRxbUtCa0FWc0VCS2lWM0VvSlE1ZW5WMm5ueFBTUzkzUUhQR3JXL0h4MFRO?=
 =?utf-8?B?anZsUEJ3RmJQcUNpdDhIQ0wzVElwNnhUT3hDZnFXUHpCZVFGcEZVTmQ5WW14?=
 =?utf-8?B?R2FFSzhVTFUwZXZYeWFJR1EvbEJ2NVkreWszWmYvVnEzV0xmbTRSLzJQS3RP?=
 =?utf-8?B?UTE0RDRYQmdNenNxRUlUU2hxUjRCVW1sUnZRMU14T3ZRb083TDh0bEZrVnRK?=
 =?utf-8?B?RGpncUtKdlBCRXZGTGxZSHZWazRwTnlQWjdFUnhuc29vVzFaYWMxYmF1S1l5?=
 =?utf-8?B?UVVlU2dJbWEzUjBqUk8yUjlKd1VoeTMwd3hBaDFXRkFFUDU5S0JOcTM4dU9H?=
 =?utf-8?B?Vi9BUXNneThSTCtPRG5POUlGRGlEWkJiVEt1anRNeTlpdUZCdDZGK05SWWI0?=
 =?utf-8?B?QVdpU0oxK2VpdSt3TjlVdEFqZG9kMzd3c3BIMVNKc3hRZkd1TEZTU3JyVmxk?=
 =?utf-8?B?UjRTQWFraE5QY0JlcGFxWUxLTjJ0WDdsTFNqa2pmdXp5MUJxZU5aNVRCVzRP?=
 =?utf-8?B?VlBWM25xNE04YzFmY0I2bkthTFQwMnVwUDJRWVY0SXpZbkZSVmd3ajNCRHZ5?=
 =?utf-8?B?aDlMckNURUZsa3RRZGo1QWNNSHdEYnc2K0hCWmFBUXZ3NGFnZ2xjR0RyN0tv?=
 =?utf-8?B?cy9PZU1NYTVqVHFqOU9BUUpzZFFhTEI2ZUNqZ0RMUTREc3l2VjNFMUVuV296?=
 =?utf-8?B?Q3R0RHNocXh1d3VVRU9LVGppYVVCcnhkeUs4d3gwVXFSOXE1VXVuVXU5TTZj?=
 =?utf-8?B?dTN4VUcwR0p3T3Yxd1BCSkZXK2N1amVXMDlndU5XdXpkMGY4dkdsVE5rTXNB?=
 =?utf-8?B?RXdJNTVLSnVtWSt2cGNWYWo2eWQ3SnM3L29RTUo2UWh0OWVTSkVSd1BEaE9w?=
 =?utf-8?B?VVVSK3dlcGp1N3M2VU1WenRURzhGb3JlcVRYbTk5K1hDNlB5Ylc5NUpSUUNC?=
 =?utf-8?B?cHpYM0FoWktuMTdVbDNWSlRXRzUrL0Y5bml1UTFDdkJCSnJxMTR5Y2VydHJJ?=
 =?utf-8?B?czY3NmdLeE43T3NhMkUrandOSU5tOGJYR0QzNFJ3aVpjZGVvV2NqTEtVdFJ3?=
 =?utf-8?B?Y2Vyc1NFZjkwUmFIbzQ5OWQraGxwOW9aMWF3QWpvQlRJOVg0MklORDJ5cmxO?=
 =?utf-8?B?QmhzVGtJTldUNzNpNHRwczJydktXWmxHenpXUVNEVnVUUENnQWFwQkxLSGFx?=
 =?utf-8?B?MThoTTVBL0lDWTVPd0h5clJwRVRjaVlyM0NMdDdiTjBiY2VrcFZoL3kvQUt1?=
 =?utf-8?B?cTFHSUo1cW1lVGtFWWljUHA1QVNpN2M2V2E4bmZPcTBncFlwRlJzOHNLTVBQ?=
 =?utf-8?B?K1dKWVlFL2N3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGx1QXBKV2VsR2lGZ1Y5ejJlajI0ZnFDcmxVRlRDUUQ0RGljRXVqcUUvQk9Z?=
 =?utf-8?B?SkJDMU92M09kT083azNLMUVPR1J1WFgzcXQvYmg3Mjk2RC9zRlNTeWpHQ1lC?=
 =?utf-8?B?UlhsbGJBSm14OEMweTVFUTRQMm9HcHFKdWpuSW5zbEdueUNsTzRTWVQwUW1i?=
 =?utf-8?B?bE01THc3TXg1TkN3S005Y2Mzd25PQXEyNEtBby9LSUFyL0JhWjBEOGNGcGpO?=
 =?utf-8?B?d2gwMFNyVlRDQUFIcFhKQzhHeDlRb3NvNUFOWUU2WGZtUmNLT1Vvd0MrMUho?=
 =?utf-8?B?dmVpRUppQm9JMzROcGRYWnRQcUU4QjFmMWJpSVA2NFVUNHE5elQ0M1dlR0Z2?=
 =?utf-8?B?TGNuMG1xaEIvU3dhNURDVVNCYXlQcUtiZEtwbG1rZmhZaXhrazF3S1hLU1dj?=
 =?utf-8?B?dVdqS25iOENSbkx0WFhKdE5ZcDRROVp3Z0U5OWNiR1p2RDBxVE9ZSmQ2N0l0?=
 =?utf-8?B?bnhEUHQza1JqdElTeDlXVC9lN2toSkU4T2JESGlWQUo5UXlHYnR5VjMrckw2?=
 =?utf-8?B?dWlGU2RpdHNNUWlsUWZLODZaQ1BwZllHRkdwTHQxK0dabm9Qa21IcWxYWHRZ?=
 =?utf-8?B?Mmt0cU1TWTNjU1VWczJ2alFhZG8yb1BxTUJCcnQwK1hyc0l1TnhEeE1GYjJr?=
 =?utf-8?B?WC9CVm4vMERsNmJmVE1OS0dyQVlaWGtHcnlvRGpPenJqUlZwUWJUbnhoemJP?=
 =?utf-8?B?ZmVRaUJWZ3dwLzUrNjlFSWhHeEdodkJvcmJrdHNTSG9yZSs1ekNRZW51YTJH?=
 =?utf-8?B?NWdDc2l0dm9VbUxiQm1CcUxmS1RaRG13cUpOQndaNlNnRVhQV1ZhRE5DR01l?=
 =?utf-8?B?eUxPYzVTalhDeDFsT0Ivcnd6YjZHQ3dIVEphZWpTaXRoMXpLTVZhc0lZYlhs?=
 =?utf-8?B?eDFGdnhBNjJuWjVPRDduNE9tTU80SExweERDeHloUWp0MVorejhtWldBNVFu?=
 =?utf-8?B?QlU4aUt1bVplRjVSM0NjR2hTTTM5ZjZjQ2k3SElYeEJUdW1oNnVKS1VPd3Q4?=
 =?utf-8?B?RGNwVnp6dU92Y3hMeXlxUU9wNklEZTFZTnRxaE1CV1NDSk1pSUpvNU9Sa3NO?=
 =?utf-8?B?eG5hWC9xR0IyUy91eDUxTmRLOERBa1lSendySlNHZS9CS2U1UHVzOEl3blFB?=
 =?utf-8?B?SDMyaXcxU1VsT1Bia3lza1RyVHdOenFPbCt6UDQycEgzSG8za2NmWlQxSEgx?=
 =?utf-8?B?MmtHVFRibXkvZCtNT21ERy92ZDUrUDY2VGk3NGhDRmxCdVc4OFVWTEhmQ2Y3?=
 =?utf-8?B?dklpeHFMeXdialFpOVlIZFdNY2gzV1dVZEpnR2NTSWxMUWlmcmhycVdtQnhw?=
 =?utf-8?B?dG9HblhyeHNROWpyR0FCOGtIc3cxUnFzQVVzdGpOZjVEd3EyYzcybnUvdFM4?=
 =?utf-8?B?dFBveThYdGNtRjBrV1djMytMOFNhSW53MjJXVXBKYWRaL2dBckdaVVhUV29E?=
 =?utf-8?B?YnJNTUo4YWJuWmYvN25OQk9IcUdadjE0UHhIdG41ZUNmRDdrVnBGRTVqemt4?=
 =?utf-8?B?YXM1dmtCWXhzTkoxL3ZDWUxMWTdaejFmV1NJYm5VSGdsS0pjQ0tYSGMyRHg4?=
 =?utf-8?B?b1FzQUU2azQxcDh1a0c3bVUyNG5CcVAycU41cDlkYno2WGNkQ3B4MFd1R2NC?=
 =?utf-8?B?RHBLNE9hc3d6MG9TZ3dDZzBDek5aUkhTWVR4Zlc3ZXZmN0M5NGpTa294eUZz?=
 =?utf-8?B?eFJXOWx0Q1M0RjVkRUw5QmtCOXZ2VVNkclJRY2lkTWJiZVp6akU3RitTeHZK?=
 =?utf-8?B?V2IreGdyRWo2ZW9TZzhIM3dEZ0hZNEh3Z21BQmFPMm1IRHdvdTBNU3RpZS96?=
 =?utf-8?B?cTkzSDdlL0tCWG00RFVabmVBeXdEVUsyUVU1SU9zYUp6ZzZkZEpDUmFsUGFX?=
 =?utf-8?B?WHBjVS9TemtUN29zcWNwSVNsNGdUVG9rTW9OczEzZnBVYitrWXkxRHBVZERW?=
 =?utf-8?B?V0c2a0J2aFpIZ2o3OWtsN0JRUjVLYnFHQzlVYUk3ZkZINjhVME9Ob2V3ZXZo?=
 =?utf-8?B?ZzJCV2FURXFjcXdSVTN6cFh0SUFPZkpsbmpuK0RLNkMwSThFRitTUDJmZXZH?=
 =?utf-8?B?MUUzc0RkTkFaUTNIeFJKelRPQnhTUzBRaXA4S1BzMSthTUNPL0h6M2t2azBw?=
 =?utf-8?B?eHBtYTR0a1IzWXZmTEo4Sm0rRTVHT3FKYmxsQTZiWUl3Y3RodW5ULzNlN3Yy?=
 =?utf-8?Q?pAjZPCuh+L9cKBSHfB8zyO0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDC85D5FA2BCF94DAF5DD7CCE340C102@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfce0a2-a880-47ba-0a1b-08dd56ae8cee
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 21:43:04.4882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iXCXZVbOqeLdrEExhZrRB+rLLs+tZWlyWYhZI3joLVN5fQ3iSqm7FWEhLbSqSIOlOiM/SsmyOemCsyojoNnkNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7483
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTAyLTEzIGF0IDEzOjE3IC0wODAwLCBrYW4ubGlhbmdAbGludXguaW50ZWwu
Y29tIHdyb3RlOgo+IEZyb206IEthbiBMaWFuZyA8a2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbT4K
PiAKPiBDaGFuZ2VzIHNpbmNlIFYyOgo+IC0gUmViYXNlIG9uIHRvcCBvZiBzZXZlcmFsIG5ldyBm
ZWF0dXJlcywgZS5nLiwgY291bnRlcnMgc25hcHNob3R0aW5nCj4gwqAgZmVhdHVyZS4gUmV3cml0
ZSB0aGUgY29kZSBmb3IgdGhlIEFDUiBDUFVJRC1lbnVtZXJhdGlvbiwKPiBjb25maWd1cmF0aW9u
Cj4gwqAgYW5kIGxhdGUgc2V0dXAuCj4gLSBQYXRjaCAxLTMgYXJlIG5ld2x5IGFkZGVkIGZvciBj
bGVhbiB1cC4KPiAKPiBDaGFuZ2VzIHNpbmNlIFYxOgo+IC0gQWRkIGEgY2hlY2sgdG8gdGhlIHJl
bG9hZCB2YWx1ZSB3aGljaCBjYW5ub3QgZXhjZWVkcyB0aGUgbWF4IHBlcmlvZAo+IC0gQXZvaWQg
aW52b2tpbmcgaW50ZWxfcG11X2VuYWJsZV9hY3IoKSBmb3IgdGhlIHBlcmYgbWV0cmljcyBldmVu
dC4KPiAtIFVwZGF0ZSBjb21tZW50cyBleHBsYWluIHRvIGNhc2Ugd2hpY2ggdGhlIGV2ZW50LT5h
dHRyLmNvbmZpZzIKPiBleGNlZWRzCj4gwqAgdGhlIGdyb3VwIHNpemUKPiAKPiBUaGUgcmVsYXRp
dmUgcmF0ZXMgYW1vbmcgdHdvIG9yIG1vcmUgZXZlbnRzIGFyZSB1c2VmdWwgZm9yCj4gcGVyZm9y
bWFuY2UKPiBhbmFseXNpcywgZS5nLiwgYSBoaWdoIGJyYW5jaCBtaXNzIHJhdGUgbWF5IGluZGlj
YXRlIGEgcGVyZm9ybWFuY2UKPiBpc3N1ZS4gVXN1YWxseSwgdGhlIHNhbXBsZXMgd2l0aCBhIHJl
bGF0aXZlIHJhdGUgdGhhdCBleGNlZWRzIHNvbWUKPiB0aHJlc2hvbGQgYXJlIG1vcmUgdXNlZnVs
LiBIb3dldmVyLCB0aGUgdHJhZGl0aW9uYWwgc2FtcGxpbmcgdGFrZXMKPiBzYW1wbGVzIG9mIGV2
ZW50cyBzZXBhcmF0ZWx5LiBUbyBnZXQgdGhlIHJlbGF0aXZlIHJhdGVzIGFtb25nIHR3byBvcgo+
IG1vcmUgZXZlbnRzLCBhIGhpZ2ggc2FtcGxlIHJhdGUgaXMgcmVxdWlyZWQsIHdoaWNoIGNhbiBi
cmluZyBoaWdoCj4gb3ZlcmhlYWQuIE1hbnkgc2FtcGxlcyB0YWtlbiBpbiB0aGUgbm9uLWhvdHNw
b3QgYXJlYSBhcmUgYWxzbyBkcm9wcGVkCj4gKHVzZWxlc3MpIGluIHRoZSBwb3N0LXByb2Nlc3Mu
Cj4gCj4gVGhlIGF1dG8gY291bnRlciByZWxvYWQgKEFDUikgZmVhdHVyZSB0YWtlcyBzYW1wbGVz
IHdoZW4gdGhlIHJlbGF0aXZlCj4gcmF0ZSBvZiB0d28gb3IgbW9yZSBldmVudHMgZXhjZWVkcyBz
b21lIHRocmVzaG9sZCwgd2hpY2ggcHJvdmlkZXMgdGhlCj4gZmluZS1ncmFpbmVkIGluZm9ybWF0
aW9uIGF0IGEgbG93IGNvc3QuCj4gVG8gc3VwcG9ydCB0aGUgZmVhdHVyZSwgdHdvIHNldHMgb2Yg
TVNScyBhcmUgaW50cm9kdWNlZC4gRm9yIGEgZ2l2ZW4KPiBjb3VudGVyIElBMzJfUE1DX0dQbl9D
VFIvSUEzMl9QTUNfRlhtX0NUUiwgYml0IGZpZWxkcyBpbiB0aGUKPiBJQTMyX1BNQ19HUG5fQ0ZH
X0IvSUEzMl9QTUNfRlhtX0NGR19CIE1TUiBpbmRpY2F0ZSB3aGljaCBjb3VudGVyKHMpCj4gY2Fu
IGNhdXNlIGEgcmVsb2FkIG9mIHRoYXQgY291bnRlci4gVGhlIHJlbG9hZCB2YWx1ZSBpcyBzdG9y
ZWQgaW4gdGhlCj4gSUEzMl9QTUNfR1BuX0NGR19DL0lBMzJfUE1DX0ZYbV9DRkdfQy4KPiBUaGUg
ZGV0YWlscyBjYW4gYmUgZm91bmQgYXQgSW50ZWwgU0RNICgwODUpLCBWb2x1bWUgMywgMjEuOS4x
MSBBdXRvCj4gQ291bnRlciBSZWxvYWQuCgpXb3JrcyBmb3IgbWUgb24gYW4gQ29yZSBVbHRyYSA5
IDI3NUhYLgoKVGVzdGVkLWJ5OiBUaG9tYXMgRmFsY29uIDx0aG9tYXMuZmFsY29uQGludGVsLmNv
bT4KClRvbQoKPiAKPiBFeGFtcGxlOgo+IAo+IEhlcmUgaXMgdGhlIHNuaXBwZXQgb2YgdGhlIG1p
c3ByZWRpY3QuYy4gU2luY2UgdGhlIGFycmF5IGhhcyBhIHJhbmRvbQo+IG51bWJlcnMsIGp1bXBz
IGFyZSByYW5kb20gYW5kIG9mdGVuIG1pc3ByZWRpY3RlZC4KPiBUaGUgbWlzcHJlZGljdGVkIHJh
dGUgZGVwZW5kcyBvbiB0aGUgY29tcGFyZWQgdmFsdWUuCj4gCj4gRm9yIHRoZSBMb29wMSwgfjEx
JSBvZiBhbGwgYnJhbmNoZXMgYXJlIG1pc3ByZWRpY3RlZC4KPiBGb3IgdGhlIExvb3AyLCB+MjEl
IG9mIGFsbCBicmFuY2hlcyBhcmUgbWlzcHJlZGljdGVkLgo+IAo+IG1haW4oKQo+IHsKPiAuLi4K
PiDCoMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgTjsgaSsrKQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBkYXRhW2ldID0gcmFuZCgpICUgMjU2Owo+IC4uLgo+IMKgwqDCoMKg
wqDCoMKgIC8qIExvb3AgMSAqLwo+IMKgwqDCoMKgwqDCoMKgIGZvciAoayA9IDA7IGsgPCA1MDsg
aysrKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgTjsg
aSsrKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KGRhdGFbaV0gPj0gNjQpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3VtICs9IGRhdGFbaV07Cj4gLi4uCj4gCj4gLi4uCj4g
wqDCoMKgwqDCoMKgwqAgLyogTG9vcCAyICovCj4gwqDCoMKgwqDCoMKgwqAgZm9yIChrID0gMDsg
ayA8IDUwOyBrKyspCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7
IGkgPCBOOyBpKyspCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAoZGF0YVtpXSA+PSAxMjgpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3VtICs9IGRhdGFbaV07Cj4gLi4uCj4g
fQo+IAo+IFVzdWFsbHksIGEgY29kZSB3aXRoIGEgaGlnaCBicmFuY2ggbWlzcyByYXRlIG1lYW5z
IGEgYmFkIHBlcmZvcm1hbmNlLgo+IFRvIHVuZGVyc3RhbmQgdGhlIGJyYW5jaCBtaXNzIHJhdGUg
b2YgdGhlIGNvZGVzLCB0aGUgdHJhZGl0aW9uYWwKPiBtZXRob2QKPiB1c3VhbGx5IHNhbXBsZXMg
Ym90aCBicmFuY2hlcyBhbmQgYnJhbmNoLW1pc3NlcyBldmVudHMuIEUuZy4sCj4gcGVyZiByZWNv
cmQgLWUgIntjcHVfYXRvbS9icmFuY2gtbWlzc2VzL3BwdSwgY3B1X2F0b20vYnJhbmNoLQo+IGlu
c3RydWN0aW9ucy91fSIKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC1jIDEwMDAwMDAg
LS0gLi9taXNwcmVkaWN0Cj4gCj4gWyBwZXJmIHJlY29yZDogV29rZW4gdXAgNCB0aW1lcyB0byB3
cml0ZSBkYXRhIF0KPiBbIHBlcmYgcmVjb3JkOiBDYXB0dXJlZCBhbmQgd3JvdGUgMC45MjUgTUIg
cGVyZi5kYXRhICg1MTA2IHNhbXBsZXMpIF0KPiBUaGUgNTEwNiBzYW1wbGVzIGFyZSBmcm9tIGJv
dGggZXZlbnRzIGFuZCBzcHJlYWQgaW4gYm90aCBMb29wcy4KPiBJbiB0aGUgcG9zdC1wcm9jZXNz
IHN0YWdlLCBhIHVzZXIgY2FuIGtub3cgdGhhdCB0aGUgTG9vcCAyIGhhcyBhIDIxJQo+IGJyYW5j
aCBtaXNzIHJhdGUuIFRoZW4gdGhleSBjYW4gZm9jdXMgb24gdGhlIHNhbXBsZXMgb2YgYnJhbmNo
LW1pc3Nlcwo+IGV2ZW50cyBmb3IgdGhlIExvb3AgMi4KPiAKPiBXaXRoIHRoaXMgcGF0Y2gsIHRo
ZSB1c2VyIGNhbiBnZW5lcmF0ZSB0aGUgc2FtcGxlcyBvbmx5IHdoZW4gdGhlCj4gYnJhbmNoCj4g
bWlzcyByYXRlID4gMjAlLiBGb3IgZXhhbXBsZSwKPiBwZXJmIHJlY29yZCAtZSAie2NwdV9hdG9t
L2JyYW5jaC0KPiBtaXNzZXMscGVyaW9kPTIwMDAwMCxhY3JfbWFzaz0weDIvcHB1LAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdV9hdG9tL2JyYW5jaC0KPiBpbnN0cnVjdGlv
bnMscGVyaW9kPTEwMDAwMDAsYWNyX21hc2s9MHgzL3V9Igo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAtLSAuL21pc3ByZWRpY3QKPiAKPiAoVHdvIGRpZmZlcmVudCBwZXJpb2RzIGFy
ZSBhcHBsaWVkIHRvIGJyYW5jaC1taXNzZXMgYW5kCj4gYnJhbmNoLWluc3RydWN0aW9ucy4gVGhl
IHJhdGlvIGlzIHNldCB0byAyMCUuCj4gSWYgdGhlIGJyYW5jaC1pbnN0cnVjdGlvbnMgaXMgb3Zl
cmZsb3dlZCBmaXJzdCwgdGhlIGJyYW5jaC1taXNzCj4gcmF0ZSA8IDIwJS4gTm8gc2FtcGxlcyBz
aG91bGQgYmUgZ2VuZXJhdGVkLiBBbGwgY291bnRlcnMgc2hvdWxkIGJlCj4gYXV0b21hdGljYWxs
eSByZWxvYWRlZC4KPiBJZiB0aGUgYnJhbmNoLW1pc3NlcyBpcyBvdmVyZmxvd2VkIGZpcnN0LCB0
aGUgYnJhbmNoLW1pc3MgcmF0ZSA+IDIwJS4KPiBBIHNhbXBsZSB0cmlnZ2VyZWQgYnkgdGhlIGJy
YW5jaC1taXNzZXMgZXZlbnQgc2hvdWxkIGJlCj4gZ2VuZXJhdGVkLiBKdXN0IHRoZSBjb3VudGVy
IG9mIHRoZSBicmFuY2gtaW5zdHJ1Y3Rpb25zIHNob3VsZCBiZQo+IGF1dG9tYXRpY2FsbHkgcmVs
b2FkZWQuCj4gCj4gVGhlIGJyYW5jaC1taXNzZXMgZXZlbnQgc2hvdWxkIG9ubHkgYmUgYXV0b21h
dGljYWxseSByZWxvYWRlZCB3aGVuCj4gdGhlIGJyYW5jaC1pbnN0cnVjdGlvbnMgaXMgb3ZlcmZs
b3dlZC4gU28gdGhlICJjYXVzZSIgZXZlbnQgaXMgdGhlCj4gYnJhbmNoLWluc3RydWN0aW9ucyBl
dmVudC4gVGhlIGFjcl9tYXNrIGlzIHNldCB0byAweDIsIHNpbmNlIHRoZQo+IGV2ZW50IGluZGV4
IG9mIGJyYW5jaC1pbnN0cnVjdGlvbnMgaXMgMS4KPiAKPiBUaGUgYnJhbmNoLWluc3RydWN0aW9u
cyBldmVudCBpcyBhdXRvbWF0aWNhbGx5IHJlbG9hZGVkIG5vIG1hdHRlcgo+IHdoaWNoCj4gZXZl
bnRzIGFyZSBvdmVyZmxvd2VkLiBTbyB0aGUgImNhdXNlIiBldmVudHMgYXJlIHRoZSBicmFuY2gt
bWlzc2VzCj4gYW5kIHRoZSBicmFuY2gtaW5zdHJ1Y3Rpb25zIGV2ZW50LiBUaGUgYWNyX21hc2sg
c2hvdWxkIGJlIHNldCB0bwo+IDB4My4pCj4gCj4gWyBwZXJmIHJlY29yZDogV29rZW4gdXAgMSB0
aW1lcyB0byB3cml0ZSBkYXRhIF0KPiBbIHBlcmYgcmVjb3JkOiBDYXB0dXJlZCBhbmQgd3JvdGUg
MC4wOTggTUIgcGVyZi5kYXRhICgyNDk4IHNhbXBsZXMpIF0KPiAKPiDCoCRwZXJmIHJlcG9ydAo+
IAo+IFBlcmNlbnTCoMKgwqDCoMKgwqAg4pSCMTU0OsKgwqAgbW92bMKgwqDCoCAkMHgwLC0weDE0
KCVyYnApCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg4pSCwqDCoMKgwqAg4oaTIGptcMKg
wqDCoMKgIDFhZgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIOKUgsKgwqDCoMKgIGZvciAo
aSA9IGo7IGkgPCBOOyBpKyspCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg4pSCMTVkOsKg
wqAgbW92wqDCoMKgwqAgLTB4MTAoJXJicCksJWVheAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIOKUgsKgwqDCoMKgwqDCoCBtb3bCoMKgwqDCoCAlZWF4LC0weDE4KCVyYnApCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAg4pSCwqDCoMKgwqAg4oaTIGptcMKgwqDCoMKgIDFhMgo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIOKUgsKgwqDCoMKgIGlmIChkYXRhW2ldID49IDEyOCkK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDilIIxNjU6wqDCoCBtb3bCoMKgwqDCoCAtMHgx
OCglcmJwKSwlZWF4Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg4pSCwqDCoMKgwqDCoMKg
IGNsdHEKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDilILCoMKgwqDCoMKgwqAgbGVhwqDC
oMKgwqAgMHgwKCwlcmF4LDQpLCVyZHgKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDilILC
oMKgwqDCoMKgwqAgbW92wqDCoMKgwqAgLTB4OCglcmJwKSwlcmF4Cj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAg4pSCwqDCoMKgwqDCoMKgIGFkZMKgwqDCoMKgICVyZHgsJXJheAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIOKUgsKgwqDCoMKgwqDCoCBtb3bCoMKgwqDCoCAoJXJheCks
JWVheAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIOKUgsKgwqDCoCDilIzilIDilIBjbXDC
oMKgwqDCoCAkMHg3ZiwlZWF4Cj4gMTAwLjAwwqDCoCAwLjAwIOKUgsKgwqDCoCDilJzilIDilIBq
bGXCoMKgwqDCoCAxOWUKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDilILCoMKgwqAg4pSC
c3VtICs9IGRhdGFbaV07Cj4gCj4gVGhlIDI0OTggc2FtcGxlcyBhcmUgYWxsIGZyb20gdGhlIGJy
YW5jaC1taXNzZXMgZXZlbnRzIGZvciB0aGUgTG9vcAo+IDIuCj4gCj4gVGhlIG51bWJlciBvZiBz
YW1wbGVzIGFuZCBvdmVyaGVhZCBpcyBzaWduaWZpY2FudGx5IHJlZHVjZWQgd2l0aG91dAo+IGxv
c2luZyBhbnkgaW5mb3JtYXRpb24uCj4gCj4gS2FuIExpYW5nICg1KToKPiDCoCBwZXJmL3g4Njog
QWRkIGR5bmFtaWMgY29uc3RyYWludAo+IMKgIHBlcmYveDg2L2ludGVsOiBUcmFjayB0aGUgbnVt
IG9mIGV2ZW50cyBuZWVkcyBsYXRlIHNldHVwCj4gwqAgcGVyZjogRXh0ZW5kIHRoZSBiaXQgd2lk
dGggb2YgdGhlIGFyY2gtc3BlY2lmaWMgZmxhZwo+IMKgIHBlcmYveDg2L2ludGVsOiBBZGQgQ1BV
SUQgZW51bWVyYXRpb24gZm9yIHRoZSBhdXRvIGNvdW50ZXIgcmVsb2FkCj4gwqAgcGVyZi94ODYv
aW50ZWw6IFN1cHBvcnQgYXV0byBjb3VudGVyIHJlbG9hZAo+IAo+IMKgYXJjaC94ODYvZXZlbnRz
L2NvcmUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAzICstCj4gwqBhcmNoL3g4Ni9l
dmVudHMvaW50ZWwvY29yZS5jwqDCoMKgwqDCoMKgIHwgMjYwCj4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0KPiDCoGFyY2gveDg2L2V2ZW50cy9pbnRlbC9kcy5jwqDCoMKgwqDCoMKgwqDC
oCB8wqDCoCAzICstCj4gwqBhcmNoL3g4Ni9ldmVudHMvaW50ZWwvbGJyLmPCoMKgwqDCoMKgwqDC
oCB8wqDCoCAyICstCj4gwqBhcmNoL3g4Ni9ldmVudHMvcGVyZl9ldmVudC5owqDCoMKgwqDCoMKg
IHzCoCAzMyArKysrCj4gwqBhcmNoL3g4Ni9ldmVudHMvcGVyZl9ldmVudF9mbGFncy5oIHzCoCA0
MSArKy0tLQo+IMKgYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLWluZGV4LmjCoMKgIHzCoMKgIDQg
Kwo+IMKgYXJjaC94ODYvaW5jbHVkZS9hc20vcGVyZl9ldmVudC5owqAgfMKgwqAgMSArCj4gwqBp
bmNsdWRlL2xpbnV4L3BlcmZfZXZlbnQuaMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNCArLQo+IMKg
OSBmaWxlcyBjaGFuZ2VkLCAzMjAgaW5zZXJ0aW9ucygrKSwgMzEgZGVsZXRpb25zKC0pCj4gCgo=

