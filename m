Return-Path: <linux-kernel+bounces-567898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D7AA68BB8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED42A1892193
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961D81E1E11;
	Wed, 19 Mar 2025 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UFYuuIbT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6018E2248AF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383744; cv=fail; b=Q2vjmywyrZK56xLjiALn6sfnx1HY4b6RfV/4dleR3ZS+9I6YPteq4QLljkW93SYfOPr69PirDa2azizMEZuNWXNfisT5+lSzWB49qjovS7+0eyj8pPNS2hbCFukmpW7BlVUJ0kvyxRiYTEWOq1FxYjxnwbTahZRn9/m2hzF9hFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383744; c=relaxed/simple;
	bh=+DIwbmCUzc/dlcj7o4pERSKkE3BzGulb6q5paXTX9sM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mAzp0UbSRznOzdvY/no6K6g7bQtIkoaw3iaEj6MOgr10u0IqiFdmxSJLNBbHG1/bKa6OrzDLfPCtjYsaMYCD94K3U3Go8+A56vkMSh2vUO56ty2yXENnvyLsdzF8nGmO2Lqy4143zWldzB4347yotlfLMcRM9STJ3482Qy6fDV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UFYuuIbT; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742383742; x=1773919742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+DIwbmCUzc/dlcj7o4pERSKkE3BzGulb6q5paXTX9sM=;
  b=UFYuuIbT26mMxewbl8gWO1HUpKxhvifuuwASqbDRw6Fam7h4mIU8cEjU
   0sY7GB9uHOyML2qBEVl4PibBgWvg1wQKmQ5SbFPXIC1oUAv/bI5CRx7sA
   n3CysMib06bNPVoSjhWxPgnuavJyTB9300wTwNjG6PeCLxCgcL7s+YuSc
   T+jEAqALiraC6qo2woTBD+I/QzXjT97AHvSGoO5i1WhCr10k8IKr5Mt5w
   zwuBKGK/iN0INZDWvi62B6CRla8n6J5hP4RGR1YYYVOHVAmsyLHUN4Yjx
   pvfXJGvaQ3k/1fn1eSjxwCPiaqhHgn/Y9aJtK1RR6OTZ/gS2I1DFEVyqV
   g==;
X-CSE-ConnectionGUID: zl5IIsjKQTK56Qt5aVT0RQ==
X-CSE-MsgGUID: AYBxwNThQ7u/ipFKw8elqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43700178"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43700178"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 04:29:01 -0700
X-CSE-ConnectionGUID: IFN1EL5sRrODJvifGsNq3Q==
X-CSE-MsgGUID: C/Ea7op5TcmnOnwIwnJ9nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="159746138"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2025 04:29:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Mar 2025 04:29:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 04:29:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 04:29:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jf4Cd9Amlx/k/YJhOfJa6DEt75X2Q1TcBDLXq6pWcwb6lpZNwk3Z02hsu0KPQ5alISE89Ug8wSYZpyqiCAlcOVsBH/eHKXvLdubKvaL0xWNPSXfUFIeeGkDtLf4m4+NxWRDx0gkU+l2Kyirf48SyG3jAuZYSjMBEJUnPdrM+9iQ83x7OBy78ywU2USefqEMlbYiwtWuor+FLzKrdSjd9OmhXsZe3I1iHVBKa5+vSWIpIkpUHORH2rQp9hZ+b2PTjcDy5Vxm0OLcaIntgHlYWpp/8ZLVYVW1jNJIfMiiCaO1fd1f5TH89LV9dAVXP3FeMgBXVfad0iK2GSYHIyRO0Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DIwbmCUzc/dlcj7o4pERSKkE3BzGulb6q5paXTX9sM=;
 b=fqE1RrdTKh+E3iK1ZF99EVYbbYNIvQyAat2Yrh2R9DResgTJtwU9MxkaJJ3HtzLHj7dabrQpImMGKuFDNlqdMJkFPfWevQF9R5fmXRwnPI6gylLJ43RiyvGBRPq6tCAhTen+/W3EIk3TFEsayg10v5PsAvuXn7MpRx9HR+8zQAXub7JUhWWL5jas6nNRb6HXhaZNsOT7rF9bXwjUVW6375ubfU18RtbD3N+4jiP0FlIwmF3mE4nlGekhw7ujDnqPu6DcxOj5y82C8+BPCbKadGSoAqmnj7YtKTTHXJPS1ta4/I0UHGF/w+30fl4e1qOntyc+0zyY4vMdW3dOGs0hew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB7849.namprd11.prod.outlook.com (2603:10b6:8:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 11:28:12 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 11:28:11 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "Xing, Cedric" <cedric.xing@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "dionnaglaze@google.com"
	<dionnaglaze@google.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "dan.middleton@linux.intel.com"
	<dan.middleton@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mikko.ylinen@linux.intel.com"
	<mikko.ylinen@linux.intel.com>, "James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v2 1/4] tsm: Add TVM Measurement Register support
Thread-Topic: [PATCH v2 1/4] tsm: Add TVM Measurement Register support
Thread-Index: AQHbhmtS+wnlBv+r+0+BoP5y9+oL1bNlXyIAgAqMnICAAE+yAIAH1WsAgAJmSAA=
Date: Wed, 19 Mar 2025 11:28:11 +0000
Message-ID: <b2d10ed8780689a8c2a6168c8f4e4e9ba9baea89.camel@intel.com>
References: <20250223-tdx-rtmr-v2-0-f2d85b0a5f94@intel.com>
	 <20250223-tdx-rtmr-v2-1-f2d85b0a5f94@intel.com>
	 <8e3736c1a0b650179dab177feafdef1a596f81c7.camel@intel.com>
	 <aa492474-e975-4121-8e0f-54414a7f5e65@intel.com>
	 <f031cf8e34ef82649e32c8060ef4a42a2e185783.camel@intel.com>
	 <95a490b3-49ad-4bb1-8894-9fedd18b8ab5@intel.com>
In-Reply-To: <95a490b3-49ad-4bb1-8894-9fedd18b8ab5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB7849:EE_
x-ms-office365-filtering-correlation-id: 08217c44-6abb-4df8-4509-08dd66d921e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?VHF2UENQejJmcHpsc01lcGxxYjJCb0VSM0xIcVZjMDlJUnFnYXlnYVRlYXNm?=
 =?utf-8?B?a0tWUDFreUVtMjZJbmhsdFpUc1dwUjFkcVlrN0hEeEdmcTBVd2hvR0xDQjVH?=
 =?utf-8?B?YUpqU1BIT2JDdlpUUmpIYWJaRG9iRmpUSlMzV1F1aXNvM0dHcmJQNEg0aVFp?=
 =?utf-8?B?ZXBBODdyQ0JkMFNvcGxNUnFCdnNhMkd2N2IrZHFOc2FiYVVUV3FMVGNlcW1R?=
 =?utf-8?B?QjBtMy9MTWxGN0RpTno1OXh4bC83cXMxdXZKWnJUM2pkRXdnVkc4Zk53TXp3?=
 =?utf-8?B?eXBlZGpiZ3JvSzhNdXhYUTNWMythRXJGWXRpMTNsamRFUFhGd2FJcFVBSm9B?=
 =?utf-8?B?QUlEZ2d4MjQ0Sk1FbGNweWRuUmFWNHM2d0hpVlFwT0VkYXFzNndHWTBRbkVL?=
 =?utf-8?B?RGJSTm5oWmt6NHEzMVI5OEFVM0dqTHNyK09zSmpzbTAzMklPWmZFK2xZTHhO?=
 =?utf-8?B?UUpGcHRQVi84cHZ6QUVIZUZWSGNxSkJBOEFid2RHdGlXQnlNbjVLZDArbTRk?=
 =?utf-8?B?aEFzU3NyOGZ0T1hyblZnc1pvWXJlc0xMWnp1dUQzdnVqMnpibjJNc3V2eU5S?=
 =?utf-8?B?NUQ3RnpKWXdyN3NCZVFPcVJnZ3hYaWxURndqaDNBUTgxY2VFM0lZdDE0cGZm?=
 =?utf-8?B?ckR4OU1VMk1iSGVkcEJRdUN0S2NGdEgreWdaQWdUbHRVWXdWSWpCQ3VkM28y?=
 =?utf-8?B?YWF1NmhIV25ySnpLdmhpaEhCN1FLT0pJWDhLNGR6c0JqT2dXaFVzRkp1ZGtW?=
 =?utf-8?B?aWFxUXRXU0dDNkhGNHNQSVZsVGVYYndyc3pmQ05LY1IvNzFMNVFsZVp2bFNM?=
 =?utf-8?B?QW9sRmF0dHozVVlIS0JJd2d4QXFDUlpEYnEyRUNIa2tST2o3eE5JcWxHSXB6?=
 =?utf-8?B?aXErZlA5SndiZFdsMkpJSldNdnBMYk9EaGhwZC9CVmFPOEU3WG9oSGV6N2JV?=
 =?utf-8?B?MUswck11cTBmbW96ejEwSGRXVnRmazRBa2JzZ1BONUV1YW1BZ1RQQnRwc3Qy?=
 =?utf-8?B?RnZqR0crdXhjNjBQMXcrUmtBeHpXMlI1d3FkM28xWmxMaUNWWFcxREsvWDNU?=
 =?utf-8?B?RzJxN1N3akhRam9UWElpcFFDYzUwa2hodi9ldy9wQ2dSdmM2T0tnQVc1bEVL?=
 =?utf-8?B?aTBxZ3Z5SW9YdGJ2dlcrOEwzclFkU2tabmIrK0xodVUyenc2cHREVitTYzhW?=
 =?utf-8?B?MFhZU0Rub2xpbnpNaGxiTzlLSzdTOVR6RC9BVG4rNlpaakdROTQrMWJTa01X?=
 =?utf-8?B?WEwvQXFaYzRqbVhFMiswcVV1UFJmUkI1QVdQSEU5dVQ5UGJLRDRHNmc0dk1N?=
 =?utf-8?B?QXdCVmgrMXFrZDZTRS8ydkFDazc0R0UzZ0Z1VlRaakV5Y0t4bUk5V3N3Z1E5?=
 =?utf-8?B?MnowT1VBMW9xcTJ3blBvWDA0Qlh5dThWNGVqMjJJN09yeUd1c2IzZUpCR2pK?=
 =?utf-8?B?cVZRa0pkc1JaQ2JlUW14THJ6UitlcEUvRTlZQlNKMHVnUkVUZEpmKzNQRVdM?=
 =?utf-8?B?OCswSGp4ckZRWFFjMGR3NS9MNGZOV1ZHMnJRM0ZiWXIxdFdTTTMyNm55azFx?=
 =?utf-8?B?NVV0V0ZjN0FyemlwU0plSlBQdi82YlptTmM4MC9FV25nT1FDOS9QVGJZbnNO?=
 =?utf-8?B?VzluSkhVRUNmZmk3VGhwQWwxcGd1NWdjZmtYL2R2bDR5dUV1KzdUNmJlTm1i?=
 =?utf-8?B?Q1pQRnNSdGtKVS9zNzdtSmtUOUVJME1XdVErWWVsN24yNGZyUnZTMzhFbVc1?=
 =?utf-8?B?NG80VzU5UUFvbHd1bGVDT0RUZWM4ZlhFUG1acEdnbE9rNlc2anpDTWNhNGJI?=
 =?utf-8?B?ZkZwaUhXUDhRbjIrcGxQMnZLTzJxa1BHd1BZYWdYeVh3c291am81QlJEdkY2?=
 =?utf-8?B?ZFBESEcxam1jV2w3aklKU3FDbm1ONGxRMFdEMGRMaXhWWFc5WWtHNDhhcTdh?=
 =?utf-8?B?dFRqazE2TTcrcXV0dU1OdUhRT1BZL1paNWxiS3FUcDl3OG5jZEdNVmV5VEFl?=
 =?utf-8?B?T2s2NEozcE1BPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1RoQkdOdXJ1bzMwRjZ3M1RnaTVuTzYwSTdid00rQTE0a0lPZHNUbllvN0pO?=
 =?utf-8?B?aW1qb3k1elgxb3NoMkt2TWNDRWxpWG9VN05tRktVQjBUTDdCUFJNbUxsc3ps?=
 =?utf-8?B?Tit4eXFBcVlVSWdCcERpalNza1NBaUJ0bWRrYThMbEdnRmtaL0s5QmVjWGlO?=
 =?utf-8?B?WjhRMkVKWTR6REpxblpTcGViZndqWTgvK2FZa3V0TEFwY0g2aVlPTDJmUkl4?=
 =?utf-8?B?cGZKWHBmK0ZNRXZUN0lxL3l3ZzlXNVJORGp4UTFiMEhHWDRLaVpzbHFvYXVO?=
 =?utf-8?B?SzRHRC9sUjVvRGUwZ1prcVd5aytnRlNmRFN6SkZuMXVOQjNUUlVURWNXd2pX?=
 =?utf-8?B?Q0N6aGpoY29WVkQ5dFNpUGtPM1F2ZjU4N2tEa2RyOGV3M25DQzR5Q1dZOFZn?=
 =?utf-8?B?MUFBTnUxQUpiN1VBd1FXTWRaV3NXSVpaMXAxMnBWeDNpNUF2ZDg1c1JyeEl4?=
 =?utf-8?B?Z2k4VStPRmp3K05pb1h3OXR4N1JqWHdRUUV6M0hkbElaMDlUQnJBRHNrbFh2?=
 =?utf-8?B?RlBETUxmbWxLY2FMcU1jZWlUTzZrQ2RCcjYvb1dUdVAwOHN2d3k2YnMvaGk1?=
 =?utf-8?B?R0JDaVNzajBsWEJYMXZpNXk3V09iSlhHRXJNWnA5M21qOHlhcnNCSE8rMm12?=
 =?utf-8?B?Y0xEcGNxU0pMbXEvbEFJTmt6clg4QzNGSzZqV0JNOFluRmNhUEFUdUMvU0dz?=
 =?utf-8?B?dG8wL0txT0dJUlZJM0xtWEthKzFPYkVDNGNSM29IUGs2eFBISmVXTlNjUFhy?=
 =?utf-8?B?MUFPUWtkSUg4Wmc5NzMvMXI0WG1HZkM0REcrKyt5VDdCRkVmRENTdUNnN0RQ?=
 =?utf-8?B?NlVvTlZyOXVMRVRCRWMwTkNHRVp3d3Z3amdnU3JOcDhUN1FZS3FtVFhSQjM2?=
 =?utf-8?B?aDgrcjRPNXZ1VmttMkMyMHRTcTFOd3pvUUlGZzVobzJyM2tMN1FqTDZ0WEsv?=
 =?utf-8?B?eTFKekpEQ08zMWg0d0owVlJVZVExMUxPWmFBeG03RHdxZlI1STZXRHYxaVpp?=
 =?utf-8?B?d1dBVGpUUTlMVzdvWnBDYU9zMUFMWDM2U2xCZ2lqWW5IQ3RxdmxEYVF1b0xO?=
 =?utf-8?B?SUh6M0FsOE5uRlloNWhvUDdCalNVQ0ZydkdjcmRQVVVDUDZZSXJEVUUyY1Vs?=
 =?utf-8?B?NmJ1UGN2dTdtbkpKQWJPbHhxd25IMXBsOEhKYVdKRk93Zi96QVRRZk9RdVlN?=
 =?utf-8?B?THNaa3piNHFUM2hQcjIySFljZC95Ymh6TGJjdTlZN3pOUm5KdXBRVytjcTFx?=
 =?utf-8?B?L21HRklnalQ4Wi9hVUtKaHE1MTdSMGN1QlFGaFlYTk1ZT3FNWndOeCs4WmRE?=
 =?utf-8?B?enVSU2NMZXZYOCswTG41RG95SHh0OFdHbjYxbzdnQS82THc3QVpIKzNlZlFv?=
 =?utf-8?B?eU1yU21pcTJ6QXZDbFlDVmNXeFV0L3pKY3d6MzNkdGV6SHkwdldQNkFZajVD?=
 =?utf-8?B?c0FkaDYraXpuK0dBZjdwdGhVQi9YaWU1NUdvOHorSW93YzFOeHNhRWFJNnpD?=
 =?utf-8?B?Z2d1dlJGa09iUFQyVnAyNTlHVTUzdUNPdnZqZVZLUkhlUEVVbnpkOG5IYlVu?=
 =?utf-8?B?bFQvVEpmZEQ0TlF2UzZSWDJIeXk1WDh4dlNwbC9XalpZT093VUp2UkJkWEJq?=
 =?utf-8?B?dlZHNk01L0llRERGb1U3RDJXcm9Oc1lzblJXaS9jYW4zdmlZdHlxSFRnRi9X?=
 =?utf-8?B?MzhyaUN1V1lSWmdCdE5wVkk0bUI0UEs2OWFXSkpzR0IvZGpDSVpxOGdNVzF3?=
 =?utf-8?B?MTl1YlludnQ2OXNmSTNUUjc2bXNtVW9BZFBwb2QyYU9BWExSaVNlNTZLN1k5?=
 =?utf-8?B?TGVEK0xVV3JIMG5OMGFOS2ZXMTcrTTlSVW5NVE92SzFnZElYVUtvc0l0MUwv?=
 =?utf-8?B?bVZMUlljdlRZZGlLcG1YZzU5Tnk0TU05dHo2Y3N2c3JXNlhGcEk3NGtKVFll?=
 =?utf-8?B?SVVzY25ySzlwMVR4TmZ4VDNYSHV0dzB3bUs0Z3pYTXJ5dGVJdG1DSTJNQjdH?=
 =?utf-8?B?aHh2VVp3dmdMU2hIMmZ3RFBFSE4vK0gxa2JtdjBLcnU1bzRxWURNcDBSVjNU?=
 =?utf-8?B?MlNLVERtTUk3TnhQem1udEdreXRJM0w3RDQyaHVHUms2OHJJb2w5QjdpY041?=
 =?utf-8?Q?JnXmXFu+p0xv+eejMBectKGtp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCFEFAE5D4E82D498600B6F7E2FB4BFF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08217c44-6abb-4df8-4509-08dd66d921e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 11:28:11.8557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /+E2fTbVxNZG1/8YRoIhwlr47PSaW8XImq0SRxvH7Gza7nlRZwo+Hpf6RcQj2osNXmeI7S8l/fekhpLh1V7dBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7849
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTAzLTE3IGF0IDE3OjQ5IC0wNTAwLCBYaW5nLCBDZWRyaWMgd3JvdGU6DQo+
IE9uIDMvMTIvMjAyNSA2OjExIFBNLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBbLi4uXQkNCj4gPiA+
IFRoZSBrZXkgZGlmZmVyZW5jZSBiZXR3ZWVuIE1ScyBhbmQgcmVwb3J0cy9xdW90ZXMgaXMgdGhl
IGxhY2sgb2YNCj4gPiA+IGNvbnRleHQuIFJlcG9ydHMvcXVvdGVzIGJlbmVmaXQgZnJvbSBoYXZp
bmcgYSBzZXBhcmF0ZSBjb250ZXh0IGZvciBlYWNoDQo+ID4gPiBjb250YWluZXIsIGVuc3VyaW5n
IHRoZXkgZG9uJ3QgaW50ZXJmZXJlIHdpdGggZWFjaCBvdGhlci4gSG93ZXZlciwgTVJzDQo+ID4g
PiBhcmUgZ2xvYmFsLCBhbmQgY3JlYXRpbmcgc2VwYXJhdGUgY29udGV4dHMgd291bGQgYmUgY29u
ZnVzaW5nIHNpbmNlDQo+ID4gPiBjaGFuZ2VzL2V4dGVuc2lvbnMgdG8gTVJzIGJ5IG9uZSBjb250
YWluZXIgd2lsbCBhbHdheXMgYmUgdmlzaWJsZSB0byBvdGhlcnMuDQo+ID4gDQo+ID4gVGhpcyBt
YWtlcyBzZW5zZS4gIENvdWxkIHlvdSBwdXQgdGhvc2UgaW50byB0aGUgY2hhbmdlbG9nPw0KPiA+
IA0KPiBNUnMgaGF2ZSBiZWVuIHVuZGVyIHN5c2ZzIHNpbmNlIHRoZSBmaXJzdCB2ZXJzaW9uIG9m
IHRoZSBSRkMgcGF0Y2guIEknbSANCj4gbm90IHN1cmUgd2hpY2ggY2hhbmdlbG9nIHRvIHB1dCBp
dCBpbi4NCg0KSSB3YXMgdGhpbmtpbmcgdG8gcHV0IHRoZSByZWFzb24ocykgb2YgY2hvb3Npbmcg
c3lzZnMgb3ZlciBjb25maWdmcy10c20gdG8gdGhlDQpjaGFuZ2Vsb2cgb2YgdGhpcyBwYXRjaCwg
YXMgSSBoYWQgaW1wcmVzc2lvbiB0aGUgQUJJIHRvIGV4cG9zZSBNUnMgaXMgYWxzbyBmb3INCmF0
dGVzdGF0aW9uIG9yIGF0IGxlYXN0IGF0dGVzdGF0aW9uIHJlbGF0ZWQuDQoNClsuLi5dDQoNCj4g
PiBJIHRoaW5rIGl0IGlzIHN0aWxsIHZhbGlkIHF1ZXN0aW9uIHRoYXQgd2hldGhlciB3ZSBuZWVk
IHRvIG1ha2UgdGhvc2UgTVJzDQo+ID4gY29uc2lzdGVudCBmb3IgYWxsIHZlbmRvcnMgZm9yIHRo
ZSBwdXJwb3NlIG9mIHByb3ZpZGluZyBhIHVuaWZpZWQgQUJJIHRvDQo+ID4gdXNlcnNwYWNlLg0K
PiA+IA0KPiA+IElJVUMsIERhbiBoYXMgYmVlbiB3YW50aW5nIHVuaWZpZWQgQUJJcyBhcm91bmQg
YXR0ZXN0YXRpb24uICBJdCB3b3VsZCBiZSBncmVhdA0KPiA+IGlmIERhbiBjYW4gcHJvdmlkZSBn
dWlkYW5jZSBoZXJlLg0KPiA+IA0KPiBZZXMsIERhbiBhbmQgSSBoYWQgZGlzY3Vzc2VkIHRoaXMg
bG9uZyBhZ28uIEp1c3QgYSBiaXQgY2xhcmlmaWNhdGlvbiANCj4gaGVyZSwgdGhpcyBBQkkgaXMg
bWFpbmx5IG1lYXN1cmVtZW50IGJ1dCBub3QgZm9yIGF0dGVzdGF0aW9uLg0KPiANCj4gR2l2ZW4g
dGhlIGxhY2sgb2YgdW5pZmllZCBIVyBmcm9tIGRpZmZlcmVudCB2ZW5kb3JzLCB0aGVyZSBjYW5u
b3QgYmUgYSANCj4gbG93IGxldmVsIHVuaWZpZWQgQUJJLsKgDQo+IA0KDQpPayBhcyBsb25nIGFz
IERhbiBpcyBmaW5lLg0KDQo+IEEgaGlnaGVyIGxldmVsIEFCSSAod2l0aCBIVyBzcGVjaWZpY3Mg
YWJzdHJhY3RlZCANCj4gYXdheSkgd2FzIG9uY2UgcHJvcG9zZWQgLSBpLmUuLCB0aGUgbG9nIG9y
aWVudGVkIEFCSS4gQnV0IGl0IHR1cm5lZCBvdXQgDQo+IGRpZmZpY3VsdCB0byBhZ3JlZSB1cG9u
IGEgbG9nIGZvcm1hdC4gQW55d2F5LCB0aGUgYWJzdHJhY3Rpb24gZG9lc24ndCANCj4gaGF2ZSB0
byBiZSBkb25lIGluIGtlcm5lbCBtb2RlLCBhcyBsb25nIGFzIE1ScyBhcmUgbWFkZSBhY2Nlc3Np
YmxlIHRvIA0KPiB1c2VyIG1vZGUuIFRoaXMgcGF0Y2ggaXMgbGF5aW5nIHRoZSBncm91bmR3b3Jr
IGZvciB0aGF0Lg0KDQpUaGFua3MgZm9yIHRoZSBpbmZvLg0KDQpNYXliZSBpdCdzIGFsc28gd29y
dGggdG8gcHV0IHRoaXMgaW50byB0aGUgY2hhbmdlbG9nIG9mIHRoaXMgcGF0Y2ggdG9vLCBzbyB0
aGF0DQpyZWFkZXJzIGNhbiBhdCBsZWFzdCBrbm93IHdoeSB3ZSBkaWRuJ3QgY2hvb3NlIHRvIHVu
aWZ5IHRoZSBBQkkuDQoNCj4gDQo+IFsuLi5dDQo+ID4gPiA+IFBsZWFzZSBjb3JyZWN0IG1lIGlm
IEkgYW0gd3Jvbmc6IGluIG15IHVuZGVyc3RhbmRpbmcsIHRoZSBwdXJwb3NlIGlzIHRvIHByb3Zp
ZGUNCj4gPiA+ID4gYSAidW5pZmllZCBBQkkgZm9yIHVzcnNwYWNlIiBmb3IgTVJzLCBidXQgbm90
IGp1c3Qgc29tZSBjb21tb24gaW5mcmFzdHJ1Y3R1cmUgaW4NCj4gPiA+ID4gdGhlIGtlcm5lbCB0
byBzdXBwb3J0IGV4cG9zaW5nIE1ScywgcmlnaHQ/DQo+ID4gPiA+IA0KPiA+ID4gPiBDb25maWdm
cy10c20gcHJvdmlkZXMgY29uc2lzdGVudCBuYW1lcyBmb3IgYWxsIGF0dHJpYnV0ZXMgZm9yIGFs
bCB2ZW5kb3JzOg0KPiA+ID4gPiAnaW5ibG9iJywgJ291dGJsb2InLCAnZ2VuZXJhdGlvbicsICdw
cm92aWRlcicgZXRjLCBzbyBpdCBwcm92aWRlcyBhIHVuaWZpZWQgQUJJDQo+ID4gPiA+IGZvciB1
c2Vyc3BhY2UuDQo+ID4gPiA+IA0KPiA+ID4gImF0dGVzdGF0aW9uIHJlcG9ydHMiIGluIHRoaXMg
Y29uZmlnZnMgY29udGV4dCByZWZlcnMgdG8gb3BhcXVlIGJsb2JzDQo+ID4gPiBjb25zdW1lZCBi
eSBleHRlcm5hbCBwYXJ0aWVzLCB3aGlsZSB0aGUgZ3Vlc3QgYWN0cyBhcyB0aGUgIndpcmUiIGZv
cg0KPiA+ID4gdHJhbnNwb3J0aW5nIHRoZSByZXBvcnRzLg0KPiA+IA0KPiA+IEkgaW50ZXJwcmV0
IHRoaXMgYXMgdGhlcmUncyBubyByZXF1aXJlbWVudCBmb3IgY29udGFpbmVycyB0byAqcmVhZCog
dGhvc2UgTVJzDQo+ID4gaW5kZXBlbmRlbnRseSB2aWEgY29uZmlnZnMtdHNtLiA6LSkNCj4gPiAN
Cj4gWWVzIGFuZCBuby4gQ29udGFpbmVycyBoYXZlIHRoZSBuZWVkIHRvIHJlYWQgTVJzLCBidXQg
ZG9lc24ndCBoYXZlICh0aGUgDQo+IG5lZWQpIHRvIHZlcmlmeSB0aGVtIChhbmQgdGhlIGNyZWRl
bnRpYWxzIGJhY2tpbmcgdGhlbSkuIEl0IGlzIGEgDQo+IHNlcGFyYXRlIHF1ZXN0aW9uIHdoZXRo
ZXIgdG8gcmVhZCBNUnMgdmlhIHN5c2ZzIG9yIGNvbmZpZ2ZzLiBUaGUgDQo+IHN0cnVjdHVyZSBv
ZiBjb25maWdmcy10c20gaXMgb3B0aW1pemVkIGZvciB1c2FnZXMgdGhhdCBkb2Vzbid0IHJlcXVp
cmUgDQo+IHBhcnNpbmcvaW50ZXJwcmV0aW5nIHRoZSBxdW90ZXMgZnJvbSB3aXRoaW4gdGhlIGd1
ZXN0LCB3aGlsZSBUaGUgDQo+IHN0cnVjdHVyZSBvZiBzeXNmcy10c20gaXMgb3B0aW1pemVkIGZv
ciB0aGUgb3Bwb3NpdGUuDQoNCkkgdGhpbmsgd2UgY2FuIGFsc28gcGFyc2UgdGhlIHF1b3RlIGZy
b20gdGhlIGNvbmZpZ2ZzLXRzbSBpZiBhcHBzIHdhbnQsIG9yIHdlDQpjYW4gYWxzbyBpbnRyb2R1
Y2UgbmV3IGNvbmZpZ2ZzLXRzbSBhdHRyaWJ1dGVzIGZvciBpbmRpdmlkdWFsIE1ScyBpZiBuZWVk
ZWQuIA0KQnV0IEkgdGhpbmsgdGhlIGtleSByZWFzb24gd2UgY2hvb3NlIHN5c2ZzIGZvciBNUnMg
aXMgdGhleSBhcmUgcGxhdGZvcm0gZ2xvYmFsDQp3aGlsZSBjb25maWdmcy10c20gZml0cyBwZXIt
YXBwbGljYXRpb24gbW9yZS4NCg0KPiANCj4gUGxlYXNlIG5vdGUgdGhhdCwgYXQgbGVhc3QgaW4g
dGhlIGNhc2Ugb2YgVERYLCBxdW90ZXMgaGF2ZSBhIGxvdCBiaWdnZXIgDQo+IFRDQiB0aGFuIFRE
UkVQT1JUcywgc28gc2hvdWxkbid0IGJlIHVzZWQgdW5sZXNzIFREUkVQT1JUcyBjYW5ub3Qgc2Vy
dmUgDQo+IHRoZSBzYW1lIHB1cnBvc2UuDQoNCkkgdGhpbmsgYW5vdGhlciBjb25jZXJuIGlzIHRo
ZSBRdW90ZSBmb3JtYXQgbWF5IG5vdCBiZSBzdGFibGUgKGUuZy4sIGZvciB0aG9zZQ0Kc2lnbmVk
IGJ5IGRpZmZlcmVudCBRRXMpLCBpLmUuLCB0aGUgbG9jYXRpb24gb2YgdGhlIFREUkVQT1JUIGlu
IHRoZSBRdW90ZSBtYXkgYmUNCmRpZmZlcmVudC4gIFJpZ2h0Pw0KDQo+IA0KPiA+ID4gDQo+ID4g
PiA+IEJ1dCBoZXJlIGFjdHVhbGx5IGVhY2ggdmVuZG9yIHdpbGwgaGF2ZSBpdHMgb3duIGRpcmVj
dG9yeS4gIEUuZy4sIGZvciBURFggd2UNCj4gPiA+ID4gaGF2ZToNCj4gPiA+ID4gDQo+ID4gPiA+
IAkvc3lzL2tlcm5lbC90c20vdGR4Ly4uLg0KPiA+ID4gPiANCj4gPiA+ID4gQW5kIHRoZSBhY3R1
YWwgTVJzIHVuZGVyIHRoZSB2ZW5kb3Itc3BlY2lmaWMgZGlyZWN0b3J5IGFyZSBjb21wbGV0ZWx5
IHZlbmRvci0NCj4gPiA+ID4gc3BlY2lmaWMuICBFLmcuLCBhcyBzaG93biBpbiB0aGUgbGFzdCBw
YXRjaCwgZm9yIFREWCB3ZSBoYXZlOiBtcmNvbmZpZ2lkLA0KPiA+ID4gPiBtcm93bmVyIGV0Yy4g
IEFuZCBmb3Igb3RoZXIgdmVuZG9ycyB0aGV5IGFyZSBmcmVlIHRvIHJlZ2lzdGVyIE1ScyBvbiB0
aGVpciBvd24uDQo+ID4gPiA+IA0KPiA+ID4gSW4gY29udHJhc3QsIE1ScyAoZXNwZWNpYWxseSBl
eHRlbnNpYmxlL1JUIE1ScykgYXJlIGNvbnN1bWVkIGJ5IHRoZQ0KPiA+ID4gZ3Vlc3QgaXRzZWxm
Lg0KPiA+ID4gDQo+ID4gDQo+ID4gWWVhaCBhZ3JlZWQuICBCdXQgZXZlbnR1YWxseSB0aGV5IGFy
ZSBmb3IgYXR0ZXN0YXRpb24sIHJpZ2h0Pw0KPiA+IA0KPiBOby4gRnJvbSB0aGUgcGVyc3BlY3Rp
dmUgb2YgdGhpcyBBQkksIE1ScyBhcmUgIm1haW5seSIgZm9yIG1lYXN1cmVtZW50LiANCj4gQnkg
Im1haW5seSIsIEkgbWVhbiB0aGVyZSBhcmUgTVJzIGxpa2UgTVJDT05GSUdJRCBvbiBURFggYW5k
IEhPU1REQVRBIG9uIA0KPiBTRVYsIHRoYXQgYXJlIHNpbXBseSBpbW11dGFibGUgc3RvcmFnZS7C
oA0KPiANCg0KSSB3aXNoIHdlIGNhbiBoYXZlIGEgbW9yZSBjb21tb24gbmFtZSByYXRoZXIgdGhh
biAiTWVhc3VyZW1lbnQgUmVnaXN0ZXJzIiwgYnV0DQp3ZSBhcmUgYWxyZWFkeSBoZXJlLiA6LSkN
Cg0KPiBUaGV5IGFyZSBuZWVkZWQgYnkgYXBwbGljYXRpb25zIA0KPiBmb3IgdmVyaWZ5aW5nLCBm
b3IgZXhhbXBsZSwgc2VjdXJpdHkgcG9saWNpZXMgdGhhdCBtdXN0IGJlIGVuZm9yY2VkLsKgDQo+
IA0KDQpJIGFwcHJlY2lhdGUgaWYgeW91eSBjb3VsZCBlbGFib3JhdGUgYSBsaXR0bGUgYml0PyAg
RS5nLiwgcmVhZGluZyBNUkNOT0ZJR0lEDQpjb3VsZCBiZSB1c2VkIGZvciBlbmZvcmNpbmcgd2hh
dCBraW5kYSBzZWN1cml0eSBwb2xpY3k/DQoNCj4gRG8gDQo+IHlvdSBzZWUgdGhlIG5lZWQgZm9y
IHJlYWRpbmcgdGhlbSBub3c/DQoNCk5vLg0KDQo+IA0KPiA+ID4gVGhleSBhcmUgdmVuZG9yIHNw
ZWNpZmljIGJlY2F1c2UgdGhleSBhcmUgX2luZGVlZF8gdmVuZG9yDQo+ID4gPiBzcGVjaWZpYy4g
VGhlIGludGVudGlvbiBpcyB0byB1bmxvY2sgYWNjZXNzIHRvIGFsbCBvZiB0aGVtIGZvciB1c2Vy
DQo+ID4gPiBtb2RlLg0KPiA+ID4gDQo+ID4gDQo+ID4gQWdyZWVkLg0KPiA+IA0KPiA+ID4gVGhl
IHNlbWFudGljcyAoaS5lLiwgd2hpY2ggTVIgc3RvcmVzIHdoYXQgbWVhc3VyZW1lbnQpIGlzDQo+
ID4gPiBhcHBsaWNhdGlvbiBzcGVjaWZpYyBhbmQgd2lsbCBiZSBhc3NpZ25lZCBieSB0aGUgYXBw
bGljYXRpb24uDQo+ID4gDQo+ID4gVGhpcyBkb2Vzbid0IG1lYW4gdGhlIGtlcm5lbCBzaG91bGRu
J3QgcHJvdmlkZSBhIHVuaWZpZWQgQUJJIHRvIHVzZXJzcGFjZQ0KPiA+IEFGQUlDVC4NCj4gPiAN
Cj4gQSBsb2cgb3JpZW50ZWQgQUJJIHdhcyBvbmNlIHByb3Bvc2VkLCBidXQgd2UgZmFpbGVkIHRv
IHJlYWNoIGFuIA0KPiBhZ3JlZW1lbnQgb24gdGhlIGxvZyBmb3JtYXQuIE1vcmVvdmVyLCB0aGlz
IG1heSBiZSBhIHByb2JsZW0gYmV0dGVyIA0KPiBzb2x2ZWQgaW4gdXNlciBzcGFjZS4NCj4gDQo+
ID4gPiANCj4gPiA+ID4gQ291bGQgeW91IGVsYWJvcmF0ZSBob3cgdXNlcnNwYWNlIGlzIHN1cHBv
c2VkIHRvIHVzZSB0aG9zZSBNUnMgaW4gYSBjb21tb24gd2F5Pw0KPiA+ID4gPiAgICANCj4gPiA+
ID4gT3IgdGhpcyBpcyBub3QgdGhlIHB1cnBvc2U/DQo+ID4gPiA+IA0KPiA+ID4gU3VyZS4gRm9y
IGV4YW1wbGUsIENvQ28gbWF5IHJlcXVpcmUgc3RvcmluZyBjb250YWluZXIgbWVhc3VyZW1lbnRz
IGludG8NCj4gPiA+IGFuIFJUTVIuIFRoZW4sIGEgcG90ZW50aWFsIGltcGxlbWVudGF0aW9uIGNv
dWxkIGV4dGVuZCB0aG9zZQ0KPiA+ID4gbWVhc3VyZW1lbnRzIHRvIGFuICJSVE1SIGZpbGUiIG5h
bWVkICJjb250YWluZXJfbXIiLCB3aGljaCBjb3VsZCBiZSBhDQo+ID4gPiBzeW1saW5rIHBvaW50
aW5nIHRvIGRpZmZlcmVudCBSVE1ScyBvbiBkaWZmZXJlbnQgYXJjaHMuDQo+ID4gDQo+ID4gT0su
DQo+ID4gDQo+ID4gPiANCj4gPiA+IE9mIGNvdXJzZSwgd2UgYXJlIGhhbmQtd2FpdmluZyB0aGUg
cG90ZW50aWFsIGRpZmZlcmVuY2UgaW4gdGhlDQo+ID4gPiBudW1iZXIvbmFtaW5nIG9mIHRoZSBN
UnMgYW5kIHRoZSBoYXNoIGFsZ29yaXRobXMgdGhleSB1c2UgaW4gdGhlIGV4YW1wbGUNCj4gPiA+
IGFib3ZlLg0KPiA+IA0KPiA+IEkgdGhpbmsgdGhlIG51bWJlciBpcyBmaW5lLiAgRS5nLiwgaW4g
dGhlIGFib3ZlIGNhc2UsIHRoZSBhcHBsaWNhdGlvbiBjb3VsZCBoYXZlDQo+ID4gYSBwb2xpY3kg
dG8gbWFwIGEgZ2l2ZW4gY29udGFpbmVyIG1lYXN1cmVtZW50IHRvIG9uZSBSVE1SIChlLmcuLCBj
b250YWluZXIwIC0+DQo+ID4gcnRtcjAgYW5kIHNvIG9uKS4NCj4gPiANCj4gPiBBbmQgSSBhbSBu
b3Qgc3VyZSB3aHkgaGFzaCBhbGdvcml0aG0gbWF0dGVycz8gIElmIG5lZWRlZCwgdGhlcmUgY291
bGQgYmUgYQ0KPiA+IHBvbGljeSB0byBxdWVyeSB0aGUgaGFzaCBhbGdvcml0aG0gZm9yIGEgZ2l2
ZW4gUlRNUiBhbmQgZmVlZCBleHRlbmRlZCBkYXRhIGJhc2VkDQo+ID4gb24gdGhlIGFsZ28gaW4g
ZWFjaCBsb29wLg0KPiA+IA0KPiBUaGUgZXhpc3RlbmNlIG9mIGEgIm1hcHBpbmcgcG9saWN5IiBp
bXBsaWVzIHRoZSBhcHBsaWNhdGlvbiBpcyBhd2FyZSBvZiANCj4gdGhlIHVuZGVybHlpbmcgSFcs
IG1lYW5pbmcgdGhlIGFwcGxpY2F0aW9uIGNhbm5vdCB3b3JrIG9uIG5ldyBIVyANCj4gcmVsZWFz
ZWQgYWZ0ZXIgdGhlIGFwcGxpY2F0aW9uLg0KPiANCj4gIlF1ZXJ5aW5nIGhhc2ggYWxnb3JpdGht
IiB3aWxsIHdvcmsgb25seSBpZiB0aGUgYXBwbGljYXRpb24gaXMgYXdhcmUgDQo+IChhbmQgY2Fy
cmllcyB0aGUgaW1wbGVtZW50YXRpb24pIG9mIHRoZSBoYXNoLiBUaGlzIHdhcyBob3cgY3J5cHRv
IA0KPiBhZ2lsaXR5IGdvdCBpbnRyb2R1Y2VkIGludG8gVFBNMi4wLCBhcyBvbGQgYXBwbGljYXRp
b25zIGNhbid0IHVuZGVyc3RhbmQgDQo+IG5ldyBoYXNoIGFsZ29zLg0KPiANCj4gSU1ITywgd2hh
dCdzIHJlYWxseSByZXF1aXJlZCBieSBhcHBsaWNhdGlvbnMvYXR0ZXN0ZXJzIGlzIHRoZSBhYmls
aXR5IHRvIA0KPiBsb2cgImV2ZW50cyIgKGUuZy4sIGEgY29udGFpbmVyIHNpZ25lZCBieSBhIHNw
ZWNpZmljIGF1dGhvcml0eSBoYXMgYmVlbiANCj4gbG9hZGVkL3N0YXJ0ZWQpLCB3aGlsZSB3aGF0
J3MgcmVxdWlyZWQgYnkgdmVyaWZpZXJzL2FwcHJhaXNlcnMgaXMgdGhlIA0KPiBhYmlsaXR5IHRv
IHZlcmlmeSB0aG9zZSAiZXZlbnRzIi4gTmVpdGhlciBwYXJ0eSBoYXMgdGhlIG5lZWQgdG8gDQo+
IHVuZGVyc3RhbmQgdGhlIEhXIHNwZWNpZmljcyAobnVtYmVyL25hbWVzIG9mIE1ScyBhbmQgaGFz
aCBhbGdvcykuIA0KPiBUaGVyZWZvcmUsIGFuIGlkZWFsIHNvbHV0aW9uIHNob3VsZCBiZSBsb2cg
b3JpZW50ZWQ6IEFwcGxpY2F0aW9ucyBhcHBlbmQgDQo+ICJldmVudHMiIHRvIGxvZ3Mgd2hpbGUg
dmVyaWZpZXJzIGV4dHJhY3QgImV2ZW50cyIgZnJvbSBsb2dzLCB3aXRoIHRoZSBIVyANCj4gc3Bl
Y2lmaWNzIGVuY2Fwc3VsYXRlZCBpbiBhIHNlcGFyYXRlICJib3R0b20gbGF5ZXIiLiBUaGlzIEFC
SSBpcyBwYXJ0IG9mIA0KPiB0aGF0ICJib3R0b20gbGF5ZXIiLCB1cG9uIHdoaWNoIHRoZSByZXN0
IG9mIHRoZSBzdGFjayBjYW4gYmUgYnVpbHQgb3V0IA0KPiBpbiB1c2VyIHNwYWNlLg0KDQpZZWFo
IHRoYW5rcyBmb3IgdGhlIGV4cGxhbmF0aW9uLiAgQXMgbG9uZyBhcyBEYW4gaXMgZmluZSB3aXRo
IHRoaXMgImJvdHRvbQ0KbGF5ZXIiIGFsbCBnb29kIDotKQ0KDQpUaGFua3MgYWdhaW4gZm9yIHRo
ZSBkZXRhaWxlZCByZXBseSENCg0K

