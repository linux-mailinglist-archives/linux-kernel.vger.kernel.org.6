Return-Path: <linux-kernel+bounces-408410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5209C7E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C92A1F21513
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441BC18BB84;
	Wed, 13 Nov 2024 22:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYW5vrOj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA56B2AE84
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731538389; cv=fail; b=iTmtDt+Zkdo6o5futPPmFo6mgSLxOGAMHjZNBgxpM6XknCWYpxxi63vu2wnKCgqRbejbytC5cyYLhQHIIU0/Spqueyyg9C2RdWh7+ReI6+J9uPfcZnlDpHApzVl3156lSxIxUJZ2wCWaseloYOO8s889LqSMJjEQwnR53Zg6ScE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731538389; c=relaxed/simple;
	bh=bB4Jj0tBmj/nb1mDC2HQ3+w95hSrXgNHhS386BDJAWI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XEjISY/+jBBhO6386iTQHoQNz3QqNoAImrc9rP/HKVaa2zxlUb0zrWyZblO2aBKy9GFmAeU1d94F7TYgtjc02WPLff0OW/gEk12pByj1faLIgj1B2Z69L66AyZfutrxzL/3zB0n3PMwF52dQ/D3RE2MFwZqmnRdHvXrAZFyszPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYW5vrOj; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731538387; x=1763074387;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bB4Jj0tBmj/nb1mDC2HQ3+w95hSrXgNHhS386BDJAWI=;
  b=RYW5vrOjxfjB2EvsQJ/UN1udHsMN7mM7EqcYa9GGo4d7IKeGVUyOGOVd
   9rIPPMBWh7d4JIN62NyRrNnBkiodhYES4zSOqyWx8tV+n1IFSRnpyMTwg
   VyFcqyuOAmfP3Prr0QIIbb1Y9SkTQUgHhcZdJMYAVYYRlJ7Ys2cXMePjR
   k5QI/jq2amY9/i6qf3iVDSaryzJ/dv/HiFxMpA+OFuDxNykvZei4Edt36
   7LkLpkV0KhzNZjl/SgW60TR3aNerdVfttI0f+0DPvmVS7sbal/6dQybEa
   25bm5nM1fD/N29EoUtbtB7g98ptSFcUnnpBNM0GmdzIj5xQ5sF3I6gMCr
   w==;
X-CSE-ConnectionGUID: 064/bnqURcO80bRPlqOYZQ==
X-CSE-MsgGUID: +CO+unxMQtSTEuCT4NT7iQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="48960912"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="48960912"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 14:53:07 -0800
X-CSE-ConnectionGUID: GH5DOR8AS1eHZ+YCxhqboQ==
X-CSE-MsgGUID: 41CZTxOqR2OKFIJQIhjmHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="92057616"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 14:53:07 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 14:53:06 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 14:53:06 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 14:53:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqPbApd6yJjQweLB8I2eb3PuN+6evVRuSetCwaD5L+0TPQB4eOGed3k6uyIqph6DdfFojP0Z4maNJ/VL5se/bdJoY7aXLDQgheDYIgYYmcAYeVpgY0anP8pg0ocszB1rRJVUupISRgWO5DuXlMxYnjVSNHO4JXhcbdtlz0ispEhwBXSyBQ+UTQHtkJBB6WWOR/Ia+T4UqDDImqcy4ag6xNqel+Sccv8wRnOggklIiWxxAX/rohXGhwt7rKjP+K/Aq3WxWOOZ93aWF2rllnbqyV9bNFjXh9l2qFw5Cja5oaO6lX4UdoS8Jcro1QajRB2ZhHUPFZWvT2DFDy0dZEZNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bB4Jj0tBmj/nb1mDC2HQ3+w95hSrXgNHhS386BDJAWI=;
 b=zVdIv304uD6Qs69UrNSI0o/6um8iq0Zv4+jokRUekNVVIgRoBimsTZpdR6eJCxpYUGPi6C1MVdjEIdJlZOkA2hCTws0acNPSnNL7Ug7LBbSOVAuYORudBeU7t62RuTx4tX2lIQOdb5pLqMunhXMAtKKAhV7PUo5UbmfBaIOrTM4fdbFaadG7w8m8ipiI0pLWteDrMTEzxx2srmDtrwRktUd+ULCuT/erGjo6J32BKzsIPGKh3+Ixiu7nnFPN0Saurqzw6Ywyx3UIe8xPKX0VLyzQ2bYnm/4Koipi8oUlxKYzNK+oMB/UM6Vr+o5LK+hupiXFgjOFKpVwLJaCyIdRXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MN0PR11MB6253.namprd11.prod.outlook.com (2603:10b6:208:3c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 22:53:00 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.8158.017; Wed, 13 Nov 2024
 22:53:00 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>, "Huang, Kai"
	<kai.huang@intel.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Williams, Dan J" <dan.j.williams@intel.com>
CC: "nik.borisov@suse.com" <nik.borisov@suse.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Yamahata,
 Isaku" <isaku.yamahata@intel.com>
Subject: Re: [PATCH v8 0/9] TDX host: metadata reading tweaks and bug fixes
Thread-Topic: [PATCH v8 0/9] TDX host: metadata reading tweaks and bug fixes
Thread-Index: AQHbNcM89kfZg0E46kyQYYoXNl99bbK1ymUAgAAER4CAAANdgA==
Date: Wed, 13 Nov 2024 22:53:00 +0000
Message-ID: <e5ebcab0d1104765ced1fafebf737b7c311593a3.camel@intel.com>
References: <cover.1731498635.git.kai.huang@intel.com>
	 <1e00cac3164ea0f20ba2cd68e3f4790c6f1da091.camel@intel.com>
	 <45a8ac0d-9f79-405a-80a4-40f5886c3bde@intel.com>
In-Reply-To: <45a8ac0d-9f79-405a-80a4-40f5886c3bde@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MN0PR11MB6253:EE_
x-ms-office365-filtering-correlation-id: f84f1317-04d2-488b-7872-08dd0435ec83
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?OVRNeWxRQmNFTmNaS1B1dkRCMDM5V213Zm9FaGFFLzM3OUY5enlJdUhWL2FZ?=
 =?utf-8?B?N3lWVVB4SGQ4VXZuOWRZdmhORUhqbUhUQ0FLNnZidXRPUUV5OTFpSWlmNlJL?=
 =?utf-8?B?T2pMZTRiazJqN3k1dVRjck8yb1ZFOUsrcDZZdGdzZVR5MjMvVUdBLzczdlFK?=
 =?utf-8?B?YzlkTUtRdzVCSDFrZ1RLZlJzZzQwM1ZBSmh6bGVNRWR0UVJIOUlFU0l3QWxp?=
 =?utf-8?B?eFdtdklMSXF1TWdQR0QxQ285bFZkejZlM1FvQzdwQk44VWVKMTBSL2VFYUFO?=
 =?utf-8?B?aEVId2xPaGR4TnVqVnBnTHlJK0RDdkFCNkw2MVpaT2JhcDlZY1pPQkFTbERk?=
 =?utf-8?B?dHdzRFMzMWhTTkN2akZKNVQ2akdwMG1JQnFnVFlGZ0wwOU4wOE53M3h6Q2Vz?=
 =?utf-8?B?Mk80bEVNQWwvYjh1UVI0MksrZERsaFMyT2J5RDdCZXp6R0VQN1NmNmtFTWtB?=
 =?utf-8?B?NVFtcURpYUdwMERzN3JxVXpIcm9YWDdMWnRVeVBPUXRjQ3JZZ0V6QmVWRTRR?=
 =?utf-8?B?UllrWWFBSmN6ZVV0SXFqMk4wWmJqUmlsaEI0SUlMM2gwMmdlMGMrZEZOeW1y?=
 =?utf-8?B?TkFFVnlzODNzc1pVV0FPbXBkVXdLOGI4bUs5VkppeStqUjFOYS8zeXYxRHpW?=
 =?utf-8?B?cXc1b1BHMDFwWXNLOGI2MEt5WjVyRFBqYVVMdjc3Y3dYa1Q1clRnSFV5bVNG?=
 =?utf-8?B?MDZlOHduVDE5NmtmclhLWWF6YTVEdXpYN0xZT1ZEaVVSRm5ISFJEYzVDcGZk?=
 =?utf-8?B?K0V2T2QxMWkvSWtlS0RLRHRoR21NdlpNSHYrMWlNSURGV2RoT3BEVW1vUkcv?=
 =?utf-8?B?YVVVaHQ2NThDQTJKUjJURHVST2ZBalNqb0ZFYkYyVmltRVR2QjZ1TXo5Wlc4?=
 =?utf-8?B?VWRRRzh6K1dGMDVFZGEreExhOHpGeUxxcm5PT2RsaGZ4NFo3Vlh4NUJJbUZO?=
 =?utf-8?B?bTV5NzdHVEdnMjJMZEpGWUx3SXN4OVRtVUMzUGdFbTZGVGp6QUpGS1N0d0hs?=
 =?utf-8?B?VXdxQ1VCZGRhNXdGWlFKK2VaYXFQWTVRV210cVNQaEdxOVV3QXBSNWNibkxE?=
 =?utf-8?B?Uk9vQXFFc21TUjRXUEk5ck5ZZ003dG85NUl1aEtablRGNjVPSjJmVDM0dS9v?=
 =?utf-8?B?NEdjSmlLN052MkEzekNyaUN3RERyYkhUQkpEbERCOW9tcDB0VTVVL0J2L25v?=
 =?utf-8?B?cW9OckVqdnhtaVp0OHNKZ0x4cUhaV05qTnRZMjB4Q2sxRFdlTzNXUDF5SSt0?=
 =?utf-8?B?Lys5SmdnQ3pER3RNTkt6bUh3UDhXMzJ2M1czaFc0d3JpcFliRXVwTkEvazZN?=
 =?utf-8?B?bEVSL3dEMThhaEFoTE5mNThJeFBKZDc3NnRtdzE2M0lXc21LNWFsRExrRVVL?=
 =?utf-8?B?TSsyRVg1ZVhmdkZEVVE1dkJlVEcxTTdicnlKSnB1UjZoT0NJVERaQzRHZzF4?=
 =?utf-8?B?ZkdaRWljMFN2YTF0VVk5RlQrVDlZTGoxS2lWUW5wdk03TEQ5eG4zRW9lMnJu?=
 =?utf-8?B?VUIyMi9iOXI1UndEZ0NNU2NRZzlqcUhjT1N3U1pQc2tOQzlhUEF4SUhNQnZ1?=
 =?utf-8?B?eVlleGZiMzhpOFlHUVY3U2wzbHNnT09JWGxHRW1tM1F4MjM5amVINkEwdUhR?=
 =?utf-8?B?QVdHeENWN2xjeENLU1lMdml1c2xkS2ZxOWpvQkNpSlA0VXBtSVJzYUhFMFU4?=
 =?utf-8?B?aGROUWhwREJrRCtVc0k1YU90TlluV080VnBiR3ZZY0NLandMcnlNTUFlZVA1?=
 =?utf-8?B?QTlORHdHbUpiN3QzUi9NK3Q2OTY1ejRmTUNxREVQMEYrdDlIalBZd1VKcXg0?=
 =?utf-8?B?S1Y3TEJJdzdXMUEvMjFaZTRreDNnZTJtTmpXTkhkRmRJUDRieXB0T29HWG10?=
 =?utf-8?Q?Bdsj6rc2ke0YH?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1g2Tzdkd1BWckVHb3NqYVQ4ek12Ynd2TG5oRTFPYXFkdGx1cVcvRTY4Qmky?=
 =?utf-8?B?VkNJY29IakJsQUpEK250NWZ2c3lXSitWaFpIYXRkTDdaQmVkaWJRbTAybEho?=
 =?utf-8?B?VU10cllKWVI5YW9LK2pmT2ZacFQrZmphTGtzUmw0d2pVL1AyVjVLWkk0N1VI?=
 =?utf-8?B?aTUvZ1NZWnlVVklnSWVITU5ack1qV3BtanpjNlBwblV5NHIzV0VDNFpXcUhz?=
 =?utf-8?B?eU9COUpXNnRHc2NUWmU0RWlhcUc1SG5IeVlIdlJJK2Z6STBHQnhjWXord2hk?=
 =?utf-8?B?VVVGejNvQWF4eGM2MmhxdjFZUC9CNE44REhmSWFHTzYvZFZIbTdJdEM4YjhV?=
 =?utf-8?B?cDhvUUl5Q2F1MzNLNUdMMDdxZ1BaMXdqZU5VMHAyOFU1WGNoM0tpOHBpVFJG?=
 =?utf-8?B?TVRGTE1NdnkrdTVvZzI2ZW00WFlmVkRkMXpOcE92aTJyMVRDSjFuTE1WK3d1?=
 =?utf-8?B?bEJIVGx5MVZxZ1FObENXblVrTHJ2Q0dlRkY1aTdibmlWaEZoTUYxeC9NdGo5?=
 =?utf-8?B?bVFxVkpRM3hEOUJJdlZCendGOFZvLzVQSDhILzhFOHZpdVFKWHJRVTI0czRu?=
 =?utf-8?B?MGtxM1ZKNVVUVmxteTEyZjZaaTNnWWVhZjU2ZWFCVzR3RU9DSEg0cWUyb3BH?=
 =?utf-8?B?b2Jxak5yZXkvRHAwUUorVEh6RDdTR3h5eDhJUjhITEhnUExSeHFFWnJkbStK?=
 =?utf-8?B?SzNPTU5jRE5GQUVIUmtOeTIxbjhuMlFvMVAxR0ZTNGZPclhkeUxxQWQzbjdk?=
 =?utf-8?B?RjZ0ZHlRbHQ0ekNINngwMXFHUXBPQmpESWNiYnBZYk80TGt5bWpuUlAyWmxx?=
 =?utf-8?B?NEE0MHFzMVFhekc1NVlzQm5xaWdPVUtxWGQ1WGo2MERibTNldFZyQzF4eVBM?=
 =?utf-8?B?NXYzQnBLc2NhMUo2bDBRanFSa1VCK2E1dTBuM2dqalR6VlZ3YXM4T0hibjBC?=
 =?utf-8?B?ZUhwTW5tc2hGNmJjWmM1enhoZzNDcFAvVTRYcGVFaVBXSTRtZUZwQlo1VXFI?=
 =?utf-8?B?b01DeXduM1U3OXU0ZXlxMzdPQzZnRXVmODE4RXJXeUVPWHNRZWMrelZUdzMr?=
 =?utf-8?B?Qm1IWUdLTEJRWGdqVEU4ajdJY0h6VlhXeUZxVzNGOG82UmduK2NOZnNrU0Zn?=
 =?utf-8?B?Q21DMGtGQTZGOVJETlUxaEl5dHZoSWJDTlBRN0dQODNSRWZyVHUzWjE5QlNW?=
 =?utf-8?B?c0xhRmNDTDFRUFdKY2crMWphQnR3ZWFiUkhHSWpubVU3UllLbi9SZUdkVjhu?=
 =?utf-8?B?SDU3NGM5UFh3Mm1PQVpFZkFXUlE2ZjhBVkxUTUFZSjNQTXpRUWdDTDEvUExY?=
 =?utf-8?B?OEdHWlZwaVF3WVhSWTJjUGFqdDNOY2FJZkpyRnhWWU9pOHhnY0twN2RoRkh2?=
 =?utf-8?B?N2E2SklFYnZ0cmlZOFZhc1Bha21NTkQ1NnBjM3JqVnBGSlhkK2Zub1NqdUVH?=
 =?utf-8?B?Z0V4SU56RlE0ajdQWGpoRXlkSnEyeGxFaVVqOFFhalpaV1Y0QXpJTFBPQmhp?=
 =?utf-8?B?RkhJNEttbENBVkdEMmk0RGF4WFNWWDhVeFBtdkxoM1g0UEhrMmNOclNaUmQ0?=
 =?utf-8?B?SmR2dm1SdjZuUHhmVzJpZDVJdUt4QkhJZ244UFpPcnRualJTUWtCZU5qTWFB?=
 =?utf-8?B?SXV2Y3pySGpOREpGbi9pbU56clVUa3NUTXNsUzlkZTFscHIxSFA2ZXlmclls?=
 =?utf-8?B?Um9RKy9lLzVEb1RQckJXaTZWMEFqdzN5V2wrTC9OY3U3eW1ucEx3emZDZXho?=
 =?utf-8?B?U0ZZSHR4VDNTdHp3MmkwMjRLTEI0WHdxUGZxQUE5UlZMa3c5M2NrcFBveHNj?=
 =?utf-8?B?OHhXVGdQaGc5ZmxzZnhUQ2dSL3gzTjFTSGcvZUphS3VjbVFzZnpZc2Jyalhy?=
 =?utf-8?B?anFoRlNxRGo0VkFTMHNZdGErWmRkc29LR1hXOGl6RTh3TFRpUzFKZFljOEd3?=
 =?utf-8?B?ME1UUGtOK3ZqRXNndDFnaGJEdFplMzFFNGVmMXBkam42WDB3V1BtSWtEUmRK?=
 =?utf-8?B?dmZjZ2lUdlpxMHUveExJQitVaTdXVWZQMjg2cXFLZis3VUNDRDQ4cXZxbG8r?=
 =?utf-8?B?WlkwRVVwTWdYZkNjenRqK2xUTDI4MXNKUGpwR3RtU05IY0E2blVSSmMrcFFr?=
 =?utf-8?B?NGZqdnk5WjBpNno1S01hQ0NsNWhmZzBXZ0RIM0JZcjEvY1FIalRTME1ZOHNE?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31D22F2C6687D245B398225A157B0C02@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84f1317-04d2-488b-7872-08dd0435ec83
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 22:53:00.4031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T5CF970tPJIWmbekIMaOipikLpNKgvYTsQfMhvs0zOtJqVWT8NCKD8xZviOucU1ucEMJahZgo/NYLcgh/y9jP3AKi83YeQm28yrzVQaWJjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6253
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTExLTE0IGF0IDExOjQwICsxMzAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+
IFNvIEkgdGhpbmsgaXQgaXMgbm90IHBhcnQgb2YgdGhlICJiYXJlIG1pbmltdW0iLiBJIGRvbid0
IGhhdmUgYW55IG9iamVjdGlvbg0KPiA+IHdpdGgNCj4gPiBpdCBnb2luZyB1cHN0cmVhbSB3aXRo
IHJlc3Qgb2YgdGhpcyBzZXJpZXMgaWYgaXQgZG9lc24ndCBkZWxheSBpdC4gQnV0IEkNCj4gPiB3
YW50IHRvDQo+ID4gbWFrZSBzdXJlIHdlIGRvbid0IGhhdmUgYW55IG1vcmUgY29uZnVzaW9uIHRo
YXQgd2lsbCBjYXVzZSBmdXJ0aGVyIGRlbGF5cy4NCj4gDQo+IFdlIGhhdmUgdHdvIGlzc3VlcyB0
aGF0IG5lZWQgdG8gYmUgYWRkcmVzc2VkLiAgQWRkcmVzc2luZyB0aGVtIGNvdWxkIA0KPiBicmlu
ZyB0aGUgaW5mcmFzdHJ1Y3R1cmUgdGhhdCBpcyBuZWVkZWQgZm9yIEtWTSBURFggYXMgd2VsbCwg
c28gdGhpcyBpcyANCj4gdGhlICJtaW5pbWFsIGNvZGUiIGdpdmVuIHRoZSBnb2FsIEkgd2FudCB0
byBhY2hpZXZlIGhlcmUuDQoNCkknbSBjb25mdXNlZCBieSB0aGlzLiAiY291bGQgYnJpbmcgdGhl
IGluZnJhc3RydWN0dXJlIj8gV2hhdCBpcyB0aGUgImdvYWwgSSB3YW50DQp0byBhY2hpZXZlIj8N
Cg0KTGV0IG1lIGFzayBpdCBhbm90aGVyIHdheSwgaWYgd2UgZHJvcCBwYXRjaGVzIDcgYW5kIDgg
YW5kIHB1c2hlZCB0aGVtIGluIGEgbGF0ZXINCnNlcmllcy4gKHNheSBhZnRlciBURFggZ2V0cyB1
cHN0cmVhbSBmb3IgdGhlIHNha2Ugb2YgdGhpcyBxdWVzdGlvbiwgYnV0IEknbSBub3QNCnN1Z2dl
c3RpbmcgYSBzY2hlZHVsZSkuIFRoZW4gd2hhdCBpcyB0aGUgY29uc2VxdWVuY2UgdG8gdGhlIGdv
YWwgb2YgYm9vdGluZyBhIFREDQpvbiBzb21lIEhXPw0KDQpJJ20gbm90IHF1ZXN0aW9uaW5nIHRo
YXQgdGhlIHBhdGNoZXMgYXJlIGluIG9yZGVyLCBvciB0aGF0IHRoZXkgc2hvdWxkIGJlIGZpeGVk
DQp1cmdlbnRseS4gSSdtIGp1c3QgdHJ5aW5nIHRvIG1ha2Ugc3VyZSB3ZSBhcmUgY2xlYXIgdG8g
RGF2ZSBvbiB3aHkgdGhpcyBpcyBhbGwNCm5lZWRlZC4NCg0KPiANCj4gPiANCj4gPiA+IDIpIFNv
bWUgb2xkIG1vZHVsZXMgY2FuIGNsb2JiZXIgaG9zdCdzIFJCUCB3aGVuIGV4aXN0aW5nIGZyb20g
dGhlIFREWA0KPiA+ID4gwqDCoMKgIGd1ZXN0LCBhbmQgY3VycmVudGx5IHRoZXkgY2FuIGJlIGlu
aXRpYWxpemVkIHN1Y2Nlc3NmdWxseS7CoCBXZSBkb24ndA0KPiA+ID4gwqDCoMKgIHdhbnQgdG8g
dXNlIHN1Y2ggbW9kdWxlcyB0aHVzIHdlIHNob3VsZCBqdXN0IGZhaWwgdG8gaW5pdGlhbGl6ZSB0
aGVtDQo+ID4gPiDCoMKgwqAgdG8gYXZvaWQgbWVtb3J5L2NwdSBjeWNsZSBjb3N0IG9mIGluaXRp
YWxpemluZyBURFggbW9kdWxlIFsyXS4NCj4gPiANCj4gPiBJIHRoaW5rIHdlIG5lZWQgUkJQIE1P
RCBmb3IgYmFzaWMgc3VwcG9ydCwgb3IgaXQgbWF5IGNhdXNlIGNyYXNoZXMgd2hlbiB3ZQ0KPiA+
IHN0YXJ0DQo+ID4gYm9vdGluZyBURHMuDQo+ID4gDQo+ID4gRG9lcyBhbGwgdGhhdCBzZWVtIGNv
cnJlY3Q/DQo+IA0KPiBXZSB3aWxsIG5lZWQgYWRkaXRpb25hbCBwYXRjaCB0byBzYXZlL3Jlc3Rv
cmUgUkJQLiDCoA0KDQpJIHRoaW5rIHlvdSBhcmUgdGFsa2luZyBhYm91dCB0aGUgd29ya2Fyb3Vu
ZCBwYXRjaCB0aGF0IHdhcyBOQUtlZCBhbmQgd2UgaGF2ZQ0Kbm93IGRyb3BwZWQgZnJvbSB0aGUg
ZGV2IGJyYW5jaCBzaW5jZSB3ZSBjYW4gbm93IHJlbHkgb24gTk9fUkJQX01PRD8gU28gd2UNCipk
b24ndCogbmVlZCB0aGF0IHBhdGNoLi4uPw0KDQo+IFRoZSBtb3JlIGltcG9ydGFudCANCj4gdGhp
bmcgaXMgaXQncyBuYXR1cmFsbHkgYmFkLCBkdWUgdG8gdGhlIHRoaW5nIHRoYXQgSSBtZW50aW9u
ZWQgaW4gdGhhdCANCj4gcGF0Y2g6DQo+IA0KPiAiLi4uY2xvYmJlcmluZyBSQlAgY291bGQgcmVz
dWx0IGluIGJhZCB0aGluZ3MgbGlrZSBiZWluZyB1bmFibGUgdG8gDQo+IHVud2luZCB0aGUgc3Rh
Y2sgaWYgYW55IG5vbi1tYXNrYWJsZSBleGNlcHRpb25zIChOTUksICNNQyBldGMpIGhhcHBlbnMg
DQo+IGluIHRoYXQgZ2FwLiINCj4gDQo+IA0KDQpZZWEgSSB0aGluayBOT19SQlBfTU9EIGlzIHJl
cXVpcmVkLg0K

