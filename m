Return-Path: <linux-kernel+bounces-518981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74966A396AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11896188D8AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4329922DFBD;
	Tue, 18 Feb 2025 09:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5aIrmU+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AF122F3B0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870053; cv=fail; b=KCyOCS0Pn7WjCnGmAghya8sI0/ChAcWB6Cts6p/RYczwweU3BMX6QCZcQy9mj8IlQ2a30zNvovg9TcBIOzRl/uOTkhS34M8Vu2pQzA8BrvirZKq+SjWjLc2sO4YfjqRJTYAwr63jOUwCAy4tGzeXUO1faXCN6Tc4+HghnA/VhxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870053; c=relaxed/simple;
	bh=boZn4dqDrmtbBQoo4pzQu3Ob2UEApQ4JqS3M66JTHPc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tnkj970XZb5co552EXg2fWfM2n7eMR8YSFyjUeTJeMA/RhoPXQdNSi4cqoCjBDHYjiAxqkWLolj0l4B43yQnIpmvnCAMmmKtfPECEAEn5jKGfp3IQXcY2ShBm2s57TJA2LhOYinRf6voa//hTsiDNon0yv1EAwrCW6Si63F5BqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5aIrmU+; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739870048; x=1771406048;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=boZn4dqDrmtbBQoo4pzQu3Ob2UEApQ4JqS3M66JTHPc=;
  b=A5aIrmU+NhIjR8OSVDpEuJbjZ6ahepCHyuwzzFpHf0o30+XGVXYZaFin
   FcTiItFx5Dq6QvTcIzFR0kAsPeDsdXBMfEc5x3ZfL28KabeIfR9W3a06x
   AsOFitrOFxaOobIHWd/1qPiILuWv4RZzXspzQZ18o37bVKErC7pUdEVei
   qTYdJb6p2PhWrQ7ay3nDwzz27pJLvIt7hx4IO5jgvd3qb2RUAsidYzVxe
   HQ1B3DZ81lWz082GvgGsTF2RcBjQZZd3tSKMCRkh/e1h55HMx80aUrOj+
   WyoKPpQO+JOboPwWx0dEo5/Hz77UcARAGMtFxsmlPhIArXYcgNFqi/gLt
   Q==;
X-CSE-ConnectionGUID: etpWWpCZQOG2QfL6w1uMrw==
X-CSE-MsgGUID: T/RDSAEiSqyhMZILyD3SHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40745290"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40745290"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 01:14:07 -0800
X-CSE-ConnectionGUID: Iwlr9HitS+2/LjhlqEaXiQ==
X-CSE-MsgGUID: xkGo+Z6fQXCNG8pQwKmgsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118463744"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 01:14:06 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 01:14:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 01:14:05 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 01:14:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fpy2AwTBqZrAIBhbV+Ipwpew3O0auEtpAZKzevywSWEz/HcmzXEJBjAIhPUzFgNfls2fg2C9qjw2sUquj89HgB3qK3mQMGr7RpSx/offGSw7Yk+m1x8TmCAxwsdaZc1kCOJqdZyCrOmtjNkPqfnWRGAnOTrkK9IPj8An+SHJpzRz14eBhSp66MhYxLDxa/5WXkbJdN/pFRmQ9MjbfDI/gpKNLSZGc+aD0ddty/VrY2qJvi4EiVOLGc8YvFISKg/VWyzQOpmkyDRMUOoLjYmzi3132YSvXZ1TPgDmuX1iAaucOejIexE2c0krqMkSkJyJQNW/4twrL/8cxFQZafETGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boZn4dqDrmtbBQoo4pzQu3Ob2UEApQ4JqS3M66JTHPc=;
 b=t7zsQ4sUjeiLLdBLinDg4JCnxaVs6AWD5BowDBLbgTT/iuptg3wL/LBim7GfgZyXC96ReTCAj+ldzDnniVeheaC5WAAZjXemImAjDNpq3WYgis3IycGqRD1zxSun0n+vwMOBGRn5GC/nOXCYgmd/5k/YGzDQi4HMLoNy4/4D0Iu4EKR/jrtAspmbY1fdsPKFNWQnV0GrjKKyFdBoGjirx4IYc9e8zIZhBsb06yFfMSyQrQ3iNOQzgI7DVlbYX2zlfEXFbz7CRtmctrelwPT06sYcukHPSP8XRyzqnYyfFV4L4E5gqgstwkcKdk/ejRtXDFGS31Hq838gQKCGEFBfog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB7734.namprd11.prod.outlook.com (2603:10b6:8:df::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.19; Tue, 18 Feb 2025 09:14:02 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 09:14:01 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "Xing, Cedric" <cedric.xing@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] tsm: Add TVM Measurement Register support
Thread-Topic: [PATCH 1/4] tsm: Add TVM Measurement Register support
Thread-Index: AQHbfb5LZmaygLxduk2rGgH+KWhmWLNKpziAgAFaRoCAAM3nAA==
Date: Tue, 18 Feb 2025 09:14:01 +0000
Message-ID: <261614c2ae52b79028469f2b50e1b69df1882137.camel@intel.com>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
	 <20250212-tdx-rtmr-v1-1-9795dc49e132@intel.com>
	 <828df2dd-a099-4146-96fe-0915cfa2e4b5@intel.com>
	 <10ab62c7-d2fc-4014-a235-700bef017a3e@intel.com>
In-Reply-To: <10ab62c7-d2fc-4014-a235-700bef017a3e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB7734:EE_
x-ms-office365-filtering-correlation-id: 9f09c88d-27f6-4318-b6bf-08dd4ffc9554
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eEVZdUF4OWVaYXlYVTg3NTI0bnYzTlNwOHNhYjlSUjRSZEpvWTE3RXo2NDZt?=
 =?utf-8?B?QWc1Z3p3NHpXOStsaWpUSnB1WFdMRUFGWFM0djl5QmxBVFByWjBCc1lnaCs0?=
 =?utf-8?B?a29FZ205U2NCZmpqTFVWQkxiY0p1YTJyVFlnM2ZrVWZMTWpWTUs1Zmptdm10?=
 =?utf-8?B?QlIzQnlFZS9yMnkxZHlzbjJuNmtESnFhSVIwUTlrVWlMbXBrY3JMYjJ1dVA4?=
 =?utf-8?B?V0E3am93UHh2OVZmeUtPeFIvSUNYZmpGVFFQRE1mSDk1YWtTWnk3SHFnYzVw?=
 =?utf-8?B?MHY3VHQ0YW0yOFhvVy9wQnlWdXJMZDFpUTU4cUNVVGMwdlQvNm1FaEIzaVgw?=
 =?utf-8?B?VE1GWVZobUcrRHo5bzlBZWMxTkloRHNIQzgxZXo5ZFpOOFMwNS9GeStpVk1M?=
 =?utf-8?B?WE51bXpyMHEya3BVeXhZM1lnTk1pNFdlTGh6VS9pWjJKb2I0aVhXcTVpa2VN?=
 =?utf-8?B?NHR0OXNZOWQ4bVNHSjQzT3ZnQVhYWjBPQndGanRYcTZTbFZtcis5RkRzUVVr?=
 =?utf-8?B?em9sMFVYMHc0M3ZLdWw4RVRiSmtzSnZnazU1cTNPTTNYUngzWkhhTzd5UGdK?=
 =?utf-8?B?THB3WjQzd2dnQ1Jlb1lrL3F3YndSeEpoOEE1Y2NhaVkySmxUMisrNWRoWSs5?=
 =?utf-8?B?aG4xSEJvc3VVb2VzYXhBL2FoR2RwaEJMZUdGNVl6NEFMNGtJRFFWcFg3VzR3?=
 =?utf-8?B?K2pvZ0JzNFQ5dGNLMkdqT0RCVTdVRVo4bThyVVdteXpyUDdnYTBMU3dSUzBn?=
 =?utf-8?B?MWFBUzVVUWJXdGFWWkJ2SjA0MUdQZEo0bThWQTMwalpOVmF6VUVkZXowZ0pw?=
 =?utf-8?B?eERxck9iQW5UVWsrU0JucG5aSVBEdWlnV2xOTk9sZ3ZmMk1aNlJpMm4wT2hH?=
 =?utf-8?B?TzB4SW93UzRLN2hwS2pKTXV2TVNkVi9PUG9xakwvcCsrRXBoaitiWk1mUTc0?=
 =?utf-8?B?MEI3S0VpS3NDWmJmQW1mY1lMWHBVY0pmOTVpRERJcC9OOW9nZ3drTy9GeVhm?=
 =?utf-8?B?L25xMDNVZjZacnFFa0hOQnZScjlhYWFpVE9yREZ3S0VhdWtyenpkSEFLUGdQ?=
 =?utf-8?B?NXpWazgzRDZvRkJHV0Rsb3dzU28zdEMwYWwyT3JUMy9JV2hHR3pQQXAxZnJV?=
 =?utf-8?B?cm5SQi9GeldDeTZsYlRzakxMRDNoUHpHV3F2WWdkR1VlWUVxQ2Rua0MwOTFy?=
 =?utf-8?B?Q3F0QzBObVQvQzBEbWw3Vjl1MlZ4WVp4dVRUWENtam9CMnEyeGVDVGhxU1lM?=
 =?utf-8?B?b2Nja2N1dHVnbXhWWHNpdVA4aDBkOURWRnM3TTgxTjFFYXRhY3EzdXh3bit6?=
 =?utf-8?B?aVV4U1pmbW5hUTZMbTVicmJiY1plMXJ6OXI2MXpOZTkvNE9xemx5WmRONGZU?=
 =?utf-8?B?RW10RCt2TVBVYndNUEZYdkxvMy91ZVVMSWtlSU9OSDB6U1ZueXVOaDdmTlp1?=
 =?utf-8?B?L05CL0xwTHQ5WVVsVW94dHNYUFMxYm9xSVZJODRIZVVRZXRJNWhUcGJxaUlD?=
 =?utf-8?B?aW1WYUs2ZFlWZlVOSXI2aTRIMTN4eVRCMVlmL1VZNFpXL24zYlJhK0ZPb29F?=
 =?utf-8?B?U1ByRFhleWZsOElDY2hZNERiUlFNZ0VZY2U3SzNYSzAvdTJsUk1jaWtSb1cx?=
 =?utf-8?B?Z05ZRkNBZ2FEN2sxb2xiTnA0R08zL3I2akVnT0FJY3FBcDVudWplYmhSdEdL?=
 =?utf-8?B?NHRFZ0d6WVZXOTU3Yzl5RUZVSFRoS0x2aUhwMkxyZkpEN2ZlU1RkWjZqZlpW?=
 =?utf-8?B?czJ6SWNBWkxmNk1oaEN2QmVtT1hibDdjazhsbkc0NWl4ODBWK201RzdFUzdh?=
 =?utf-8?B?dDdhNTdwVWYyKzNiQXROb3I0cWh2U3pTT2Z5VURvZVBIS2VrVm5LYlJ5UnhH?=
 =?utf-8?B?VktVaHhlblVMOG1STWFDRkV2ZnY3eEFRQy9xTkY1RGNmT3l1OTFSMUtVbCtV?=
 =?utf-8?B?V0Z2RHV5ZTBGSnRQK2dhaWdhQVR5TXN6djlmNnBOVERaSnhjenJyTmoxV1or?=
 =?utf-8?B?V3FjYlQ2dk5nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWZ4US9HaWZoVjBUQmFQUlUyT1JoQk9Kc0xqUC9VUlZGb3NNM2o0TFY3NHN3?=
 =?utf-8?B?ZDg1cGdOYnlzZkZ5REsvT0dVdDFSbmVoTUhFMnVPVGI0eU1Hb3JlK3E2eCs0?=
 =?utf-8?B?M2pZVGp1RUhPR0FvTEJQNHoyL2lIVEVKQ0p4WXllNC91TGlRQnpRTDVmVlhu?=
 =?utf-8?B?SFRITE9VOW9CTzVXcXhmNlp5aXBVNE16OHFSRE5PcjRrYm12MmY4RDJRVVVS?=
 =?utf-8?B?ZlRIOU5wdzBKT0ZqQXpSNitDSEljOC8zU09PSUQ0QWViZXlDRjJrUUFveERi?=
 =?utf-8?B?VWVuWEZYSTQ2dWlTaG5rai9oZlpWQXp3eVhPNWZXNHBjK0F2OFRtUlVpZWxZ?=
 =?utf-8?B?N0hka2hJK2ZaUG85a0tmRG1tejBJeTNmb2k4eWhHV3RQVTIvTmFqWlkyN3Jj?=
 =?utf-8?B?WXIwRlF1SjdOSWljU05SdkJsOG9Jb0JJc2xTeGVDT0JnbE1sRVlKcVBsVWVq?=
 =?utf-8?B?YmMyQjU4bU80cVUzUVdSQXdHQ3h0OFYzT3JUNVVSNUEvZlVIQ3NQTkVRYlRQ?=
 =?utf-8?B?OG1XcVpoVzlIekZ1NkRjWlUvNWxpK1hvT0RTdXQvVS9ZR3hYVGdtaFBFaGxR?=
 =?utf-8?B?SW1DNG1sejAxQnlPSG5YdXMzVVBJa2hOQW9jcUNCRUZDQndSaUNNR0MzTzUv?=
 =?utf-8?B?bTJBcTVYVkpNcFdXVlhXTUx6emo3QjdkRkcrVStmVUI2dFNUemdWRkU1MWlK?=
 =?utf-8?B?aTlENHFad2c3RExoU3NIS05jd20vdHNKNlZLR0xCQzlRQUMza3N0U1VNNFdW?=
 =?utf-8?B?RVBEbllaOVhZeGZzZGdLUFY2a2pUeFhaa21NYWZiUjJKRlNIV1AvRWFUb09h?=
 =?utf-8?B?Z2dNM3NENnFBcjJlNEJvWVhZVkdMOGdPaWJXY2NnK2VSSWRjVERSeDk0Nkxv?=
 =?utf-8?B?blRJM2FGVHdrTkJ0RmZiTjI2MDR6V0VXQmM2V2MvZ3lXV2IwMUxvQVdiaCt0?=
 =?utf-8?B?RkNkS0kyeld0OXVkNWRpbUFwbUJuZDZjWG02eTZSTFBkenoydU9DbTRZOUhZ?=
 =?utf-8?B?ZGwrY3loc1EzaEp6VlJSYURTM0NUVS9JTUVwNktPZTNnRm51ZzFvN1JsRHhn?=
 =?utf-8?B?MDlQdVBqY3lKc0hNZ0hHL1Y5MXpTMklORjBaVHFEY0cxT25jQnhGSEVWOGlW?=
 =?utf-8?B?aUwzc2x4bE1nN3NZdU55aGpXRDNTYUZKaHhNWk8rYmV6d2oxQ2ZRYUJPeTYz?=
 =?utf-8?B?aFZDWEZ3TkNKQmlldlh3MnBNUDU4SlNCckZxV3IvS0h2bDNZemtsS2lXeXlD?=
 =?utf-8?B?c0E2RE5aV3RIRWJpczdOektDODB2dHJDb2ZkVzhYdklkb1dzaXgzdTdXTE1L?=
 =?utf-8?B?VWdaU2cwZjlpL1R0bEdFS0FsZzgyejMwUHBMSy9pZTByYk53M080bmg1N0Na?=
 =?utf-8?B?UEZJQmJlaXJUZzk5WXVZNWlOTG9WL1NBUC9Gb2VpQ01rY1MwMElNUTJBeUw4?=
 =?utf-8?B?ZXNWUkpVNHh5SzQ4MGZ5VU5MYUxaNEJaWFM2OXVScjQ1M3c0STYzdU1HRXBC?=
 =?utf-8?B?RVNtQlM4Nk1JR09aQXNEOTZsckE2WFJpOWhUeWJQaG9rNmVDaXE5OFpxU0FH?=
 =?utf-8?B?ZWc0Q1JjbXVnMEQ4VXp6ZjZVajhHVXdkNUROR2JFQzE1MjRYMjZ3amhSNUtE?=
 =?utf-8?B?Unlvc211OHZhNFplWjFGbGh5WHVSSE1KN24yd1AxZFJMNnVuSVRtZjQ5THM5?=
 =?utf-8?B?MTFKbHdVR3BmR3g1T2ZEODJKZEJwQ1NiZlJ3QWNNWlNVdzgrejc2Q2dVMHZs?=
 =?utf-8?B?Z0hnN0xBdjBzZEhMai92OG1ZOUR4UnNzYk1WRHB3MGtqT3EvUHE3TWFDa0p5?=
 =?utf-8?B?NzVjOHNrRnNRcU55bTNIZUVyVGNwUlg2U2xNS1JHVXpJYzl5Z1lhVkFzQk04?=
 =?utf-8?B?RUdWWWlRS243NXNubXRoNU1Jc2JxTUlTei9mMGh1dW9aMVZqNjFLWDJwNEVQ?=
 =?utf-8?B?ckFUK3lLRHkxTHAwNDJ4R2VFcGpBNXdialdCVWg4Lzk5MHpnQStURHVwcWRq?=
 =?utf-8?B?WWNLNThtU28wSlh0bWxqVXA0Q3lkTFR0L0VPUExYVUNScU9mejZvNjZCK2I0?=
 =?utf-8?B?MDk3VW1oM0NqV0pueHJ6MTZjeUNqeTQ4eGs4THNYVmQ5VzBaZHg4NnVPVVFV?=
 =?utf-8?Q?uHL95onTXyeHv1D5jaSOeTpzp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A452738E8EB6C14DB78DBD06F833AEAB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f09c88d-27f6-4318-b6bf-08dd4ffc9554
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 09:14:01.1979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PTAUalLo8SWfI9u6APDh5+slo5WXODEvFYjGj3CTLpgj+pFYKBKdANOae45OkeHlGcl0YoV1L+wEeHgSLtDz6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7734
X-OriginatorOrg: intel.com

DQo+ID4gPiArLyoqDQo+ID4gPiArICogZW51bSB0c21fbWVhc3VyZW1lbnRfcmVnaXN0ZXJfZmxh
ZyAtIHByb3BlcnRpZXMgb2YgYW4gTVINCj4gPiA+ICsgKiBAVFNNX01SX0ZfWDogdGhpcyBNUiBz
dXBwb3J0cyB0aGUgZXh0ZW5zaW9uIHNlbWFudGljcyBvbiB3cml0ZQ0KPiA+ID4gKyAqIEBUU01f
TVJfRl9XOiB0aGlzIE1SIGlzIHdyaXRhYmxlDQo+ID4gDQo+ID4gV2h5IGEgTVIgY2FuIGJlIHdy
aXR0ZW4gdy9vIGJlaW5nIGV4dGVuZGVkP8KgIFdoYXQgaXMgdGhlIHVzZSBjYXNlIG9mIHRoaXM/
DQo+ID4gDQo+IA0KPiBUaGlzIGlzIGJlY2F1c2UgIndyaXRlIiBtYXkgbm90IGJlIHRoZSBvbmx5
IHdheSB0byBleHRlbmQgYW4gUlRNUi4gRm9yIA0KPiBleGFtcGxlLCB0aGUgY3VycmVudCBBQkkg
cHJvcG9zZWQgYnkgdGhpcyBwYXRjaCBjYW4gYmUgY29uc2lkZXJlZCAiTVIgDQo+IGNlbnRyaWMi
LCBtZWFuaW5nIGl0J3MgdGhlIGFwcGxpY2F0aW9uIHRoYXQgdGFrZXMgY2FyZSBvZiB3aGF0IHRv
IGhhc2gsIA0KPiB1c2luZyB3aGF0IGFsZ29yaXRobSwgYW5kIHdoaWNoIFJUTVIgdG8gZXh0ZW5k
LsKgDQo+IA0KDQpbLi4uXQ0KDQo+IEhvd2V2ZXIsIHRoZW9yZXRpY2FsbHksIA0KPiBhcHBsaWNh
dGlvbnMgc2hvdWxkIG9ubHkgYmUgY29uY2VybmVkIHRoZSBpbnRlZ3JpdHkgb2Ygc29tZSBzZXF1
ZW5jZSBvZiANCj4gZXZlbnRzICh0aGUgZXZlbnQgbG9nKS7CoFRoZXJlZm9yZSwgdGhlcmUgY291
bGQgYmUgYSAibG9nIGNlbnRyaWMiIEFCSSANCj4gdGhhdCBhbGxvd3MgYXBwbGljYXRpb25zIHRv
IGludGVncml0eS1wcm90ZWN0IGl0cyBsb2dzIGluIGEgQ0MtYXJjaCANCj4gYWdub3N0aWMgbWFu
bmVyLsKgDQo+IA0KDQpJIGFncmVlICJsb2cgY2VudHJpYyIgQUJJIGNvdWxkIGJlIHVzZWZ1bC4g
IEkgZG9uJ3Qga25vdyBhIGxvdCBvZiB0aGUgZm9ybWF0IG9mDQoiZXZlbnQgbG9nIiwgYnV0IEkg
YW0gdGhpbmtpbmcgdGhhdCBtYWtpbmcgc3VyZSAiaW50ZWdyaXR5IG9mIHNvbWUgc2VxdWVuY2Ug
b2YNCmV2ZW50cyIgbWF5IG5vdCBiZSBnb29kIGVub3VnaCAtLSB3ZSBhY3R1YWxseSBuZWVkIHRv
IG1ha2Ugc3VyZSAiaW50ZWdyaXR5IG9mDQplYWNoIGNvbXBvbmVudCIgdGhhdCBnZXQgaW52b2x2
ZWQgaW4gdGhvc2UgZXZlbnRzLg0KDQpFLmcuLCBhIGd1ZXN0IHdhbnRzIHRvIGxvYWQgc29tZSBw
YXJ0aWN1bGFyIGtlcm5lbCBtb2R1bGUgZHVyaW5nIGJvb3QgYW5kIHdhbnRzDQp0byBtYWtlIHN1
cmUgdGhlIGNvcnJlY3Qgb25lIGdldHMgbG9hZGVkLiAgVXNlcnNwYWNlIGNhbiB0cmlnZ2VyIGFu
IGV2ZW50IG9mDQoibG9hZGluZyB0aGF0IG1vZHVsZSIgYW5kIGdldCB0aGlzICpldmVudCBsb2cq
IHZlcmlmaWVkLiAgQnV0IHcvbyBnZXR0aW5nIHRoZQ0Ka2VybmVsIG1vZHVsZSBiaW5hcnkgaXRz
ZWxmIG1lYXN1cmVkIGFzIHBhcnQgb2YgdGhpcyBzdGVwLCB3ZSBjYW5ub3QgcmVhbGx5IGJlDQpz
dXJlIHdoZXRoZXIgdGhpcyBzdGVwIGlzIGNvbXByb21pc2VkIG9yIG5vdC4gIEluIHRoaXMgY2Fz
ZSwgdGhlIHVzZXJzcGFjZSBtYXkNCnN0aWxsIG5lZWQgdG8gKHdyaXRlIGFuZCkgZXh0ZW5kIHRo
ZSBNUihzKS4NCg0KPiBBbmQgaWYgdGhhdCdzIHRoZSBjYXNlLCBSVE1ScyBtYXkgYmUgbWFya2Vk
IFJPICgiWCB3L28gDQo+IFciKSB0byBwcmV2ZW50IGRpcmVjdCBleHRlbnNpb24uDQoNClNvcnJ5
IEkgZG9uJ3QgcXVpdGUgZm9sbG93IHdoeSBSTyBpcyBlbm91Z2ggZm9yICJsb2cgY2VudHJpYyIg
QUJJLiAgQ291bGQgeW91DQplbGFib3JhdGUgYSBiaXQ/DQoNCj4gDQo+IFRoZSB1c2Ugb2YgIlcg
dy9vIFgiIGlzIHRvIHN1cHBvcnQgcHNldWRvLU1Scy4gRm9yIGV4YW1wbGUsIGByZXBvcnRkYXRh
YCANCj4gaXMgc3VjaCBhIHBzZXVkby1NUiB0aGF0IGlzIFcgYnV0IG5vdCBYLiBTbyBhbiBhcHBs
aWNhdGlvbiBjYW4gcmVxdWVzdCBhIA0KPiBURFJFUE9SVCBieSBhIHdyaXRlIHRvIGByZXBvcnRk
YXRhYCBmb2xsb3dlZCBieSBhIHJlYWQgZnJvbSBgcmVwb3J0MGAuDQoNCkkgYW0gYSBsaXR0bGUg
Yml0IGNvbmZ1c2VkLiAgVGhpcyBzZXJpZXMgaXMgYWJvdXQgZXhwb3NpbmcgIm1lYXN1cmVtZW50
DQpyZWdpc3RlcnMiIHRvIHVzZXJzcGFjZSwgc28gSSB0aG91Z2h0IHRoZXJlIHNob3VsZCBiZSBh
dCBsZWFzdCBzb21lDQoibWVhc3VyZW1lbnQiIGdldCBpbnZvbHZlZCBmb3IgYW55IGVudHJ5IHRo
YXQgaXMgcmVwb3J0IHRvIHVzZXJzcGFjZS4NCg0KJ3JlcG9ydGRhdGEnIGlzIG1vcmUgbGlrZSB0
aGUgbm9uY2UgZW1iZWRkZWQgdG8gdGhlIGF0dGVzdGF0aW9uIHJlcG9ydCwgYW5kIGl0DQpkb2Vz
bid0IGludm9sdmUgYW55IG1lYXN1cmVtZW50Lg0KDQpJIGNhbiBzZWUgd2h5IHlvdSB3YW50IHRv
IGV4cG9zZSAncmVwb3J0ZGF0YScgdG8gdXNlcnNwYWNlLCBidXQgY2FsbGluZw0KJ3JlcG9ydGRh
dGEnIGFzIG1lYXN1cmVtZW50IHJlZ2lzdGVyIHNlZW1zIHVuZml0Lg0KDQo+IA0KPiA+ID4gKyAq
IEBUU01fTVJfRl9SOiB0aGlzIE1SIGlzIHJlYWRhYmxlLiBUaGlzIHNob3VsZCB0eXBpY2FsbHkg
YmUgc2V0DQo+ID4gPiArICogQFRTTV9NUl9GX0w6IHRoaXMgTVIgaXMgbGl2ZSAtIHdyaXRlcyB0
byBvdGhlciBNUnMgbWF5IGNoYW5nZSB0aGlzIE1SDQo+ID4gDQo+ID4gV2h5IG9uZSBNUiBjYW4g
YmUgY2hhbmdlZCBieSB3cml0aW5nIHRvIG90aGVyIE1Scz8NCj4gPiANCj4gDQo+IEdvb2QgY2F0
Y2ghIEknbGwgZml4IHRoZSBjb21tZW50Lg0KPiANCj4gPiA+ICsgKiBAVFNNX01SX0ZfRjogcHJl
c2VudCB0aGlzIE1SIGFzIGEgZmlsZSAoaW5zdGVhZCBvZiBhIGRpcmVjdG9yeSkNCj4gPiA+ICsg
KiBAVFNNX01SX0ZfTElWRTogc2hvcnRoYW5kIGZvciBMIChsaXZlKSBhbmQgUiAocmVhZGFibGUp
DQo+ID4gPiArICogQFRTTV9NUl9GX1JUTVI6IHNob3J0aGFuZCBmb3IgTElWRSBhbmQgWCAoZXh0
ZW5zaWJsZSkNCj4gPiA+ICsgKi8NCj4gPiA+ICtlbnVtIHRzbV9tZWFzdXJlbWVudF9yZWdpc3Rl
cl9mbGFnIHsNCj4gPiA+ICvCoMKgwqAgVFNNX01SX0ZfWCA9IDEsDQo+ID4gPiArwqDCoMKgIFRT
TV9NUl9GX1cgPSAyLA0KPiA+ID4gK8KgwqDCoCBUU01fTVJfRl9SID0gNCwNCj4gPiA+ICvCoMKg
wqAgVFNNX01SX0ZfTCA9IDgsDQo+ID4gPiArwqDCoMKgIFRTTV9NUl9GX0YgPSAxNiwNCj4gPiA+
ICvCoMKgwqAgVFNNX01SX0ZfTElWRSA9IFRTTV9NUl9GX0wgfCBUU01fTVJfRl9SLA0KPiA+ID4g
K8KgwqDCoCBUU01fTVJfRl9SVE1SID0gVFNNX01SX0ZfTElWRSB8IFRTTV9NUl9GX1gsDQo+ID4g
PiArfTsNCj4gPiANCj4gPiBJIGFtIG5vdCBzdXJlIHdoZXRoZXIgd2UgbmVlZCBzbyBtYW55IGZs
YWdzLsKgIFRvIG1lIHNlZW1zIGxpa2Ugd2Ugb25seSANCj4gPiBuZWVkOg0KPiA+IA0KPiA+ICDC
oC0gVFNNX01SX0VOQUJMRUQ6wqAgVGhlIE1SIGhhcyBiZWVuIGluaXRpYWxpemVkIHdpdGggYSBj
ZXJ0YWluIGFsZ28uDQo+ID4gIMKgLSBUU01fTVJfVU5MT0NLRUQ6IFRoZSBNUiBpcyB3cml0YWJs
ZSBhbmQgYW55IHdyaXRlIHdpbGwgZXh0ZW5kIGl0Lg0KPiA+ICDCoC0gVFNNX01SX0xPQ0tFRDrC
oMKgIFRoZSBNUiBpcyBsb2NrZWQgYW5kIGZpbmFsaXplZC4NCj4gPiANCj4gDQo+IFcvWCBhcmUg
aW5kZXBlbmRlbnQgYW5kIGJvdGggbmVjZXNzYXJ5IChzZWUgbXkgcHJldmlvdXMgZXhwbGFuYXRp
b24gb24gDQo+ICJYIHcvbyBXIiBhbmQgIlcgdy9vIFgiKS4NCj4gDQo+IEknbSBub3Qgc3VyZSBp
ZiB0aGVyZSBhcmUgbm9uLXJlYWRhYmxlIE1Scy4gQnV0IHRoZW9yZXRpY2FsbHksIA0KPiBhcHBs
aWNhdGlvbnMgaW5zaWRlIGEgVFZNIChDQyBndWVzdCkgbWF5IG5vdCBuZWVkIHRvIHJlYWQgYW55
IE1SIHZhbHVlcy4gDQo+IFRoZXJlZm9yZSwgdGhlcmUgY291bGQgYmUgQ0MgYXJjaHMgKGluIGZ1
dHVyZSkgdGhhdCBkbyBub3Qgc3VwcG9ydCANCj4gcmVhZGluZyBhbGwgTVJzIHdpdGhpbiBhIGd1
ZXN0LiBBbmQgYmVjYXVzZSBvZiB0aGF0LCBJIGRlY2lkZWQgdG8ga2VlcCBSIA0KPiBhcyBhbiBp
bmRlcGVuZGVudCBiaXQuDQoNClsuLi5dDQoNCj4gDQo+IEwgaXMgdG8gaW5kaWNhdGUgYW4gTVIn
cyB2YWx1ZSBtYXkgbm90IG1hdGNoIGl0cyBsYXN0IHdyaXRlLg0KDQoiTCIgZG9lc24ndCBzZWVt
IHRvIGJlIGFibGUgdG8gcmVmbGVjdCB0aGUgTVIgdmFsdWUgaXMgb3V0LW9mLXN5bmMuIDotKQ0K
DQpXaGF0IGRvZXMgaXQgc3RhbmQgZm9yPw0KDQo+IA0KPiBGIGlzIGZvciBDQyBndWVzdCB0byBl
eHBvc2UgKHBzZXVkbykgTVJzIHRoYXQgbWF5IG5vdCBoYXZlIGFuIGFzc29jaWF0ZWQgDQo+IGhh
c2ggYWxnb3JpdGhtIChlLmcuLCBgcmVwb3J0MGAgb24gVERYKS4NCg0KT0suICBCdXQgbXkgdGhp
bmtpbmcgaXMgc3VjaCBNUiBhY3R1YWxseSBpc24ndCBNUiBhdCBhbGwuDQoNCj4gDQo+IExPQ0tF
RC9VTkxPQ0tFRCwgZnJvbSBhdHRlc3RhdGlvbiBwZXJzcGVjdGl2ZSwgaXMgTk9UIGEgZnVuY3Rp
b25hbCBidXQgYSANCj4gdmVyaWZpYWJsZSBzZWN1cml0eSBwcm9wZXJ0eSwgd2hpY2ggaXMgdXN1
YWxseSBpbXBsZW1lbnRlZCBieSBleHRlbmRpbmcgDQo+IGEgc3BlY2lhbCB0b2tlbiB0byB0aGUg
UlRNUi4NCj4gDQo+ID4gVGhlIFRTTV9NUl9FTkFCTEVEIG1heSBub3QgYmUgbmVlZGVkIGVpdGhl
ciwgYnV0IEkgdGhpbmsgaXQncyBiZXR0ZXIgdG8gDQo+ID4gaGF2ZSBpdCBzbyB0aGF0IHRoZSBr
ZXJuZWwgY2FuIHJlamVjdCBib3RoIHJlYWQvd3JpdGUgZnJvbSB1c2Vyc3BhY2UuDQo+ID4gDQo+
IEknbSBub3Qgc3VyZSB3aGF0IGEgImRpc2FibGVkIiBNUiBpcyBhbmQgaXRzIGltcGxpY2F0aW9u
IGZyb20gDQo+IGF0dGVzdGF0aW9uIHBlcnNwZWN0aXZlLg0KDQpJIHdhcyB0aGlua2luZyBmcm9t
IHRoZSBwZXJzcGVjdGl2ZSB0aGF0IHVzZXJzcGFjZSBtYXkgb25seSBiZSBpbnRlcmVzdGVkIGlu
IG9uZQ0KcGFydGljdWxhciBNUi4gIElmIHRoYXQgTVIgaXMgbm90IHVzZWQsIEkgc3VwcG9zZSBp
dCBzaG91bGQgaGF2ZSBkZWZhdWx0IHZhbHVlDQowLiAgQnV0IEkgd2FzIHRoaW5raW5nIHRoYXQg
InJlZnVzaW5nIHVzZXJzcGFjZSB0byByZWFkIiBtYXkgYmUgYmV0dGVyIHRoYW4NCiJyZXR1cm5p
bmcgMCB0byB1c2Vyc3BhY2UiIGZvciBhIHBhcnRpY3VsYXIgTVIsIGlmIGl0IGlzIG5vdCB1c2Vk
Lg0KDQpCdXQgZnJvbSBhdHRlc3RhdGlvbidzIHBlcnNwZWN0aXZlLCBJIHRlbmQgdG8gYWdyZWUg
d2l0aCB5b3UgdGhhdCAiZGlzYWJsZWQgTVIiDQptYXkgbm90IGJlIGhlbHBmdWwuICBXZSBuZWVk
IHRvIHNlbmQgdGhlIHdob2xlIGF0dGVzdGF0aW9uIHJlcG9ydCB0byB0aGUNCnZlcmlmaWVyIGFu
eXdheSBhbmQgdGhlIHZlcmlmaWVyIHNob3VsZCBvbmx5IGNhcmUgYWJvdXQgd2hldGhlciB0aGUg
TVIgdmFsdWVzIGluDQp0aGUgcmVwb3J0IG1hdGNoZXMgd2hhdCB0aGUgdmVyaWZpZXIga25vd3Mu
DQoNCj4gDQo+ID4gPiArDQo+ID4gPiArI2RlZmluZSBUU01fTVJfKG1yLCANCj4gPiA+IGhhc2gp
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgXA0KPiA+ID4gK8KgwqDCoCAubXJfbmFtZSA9ICNtciwgLm1yX3NpemUgPSBoYXNoIyNfRElH
RVNUX1NJWkUsIC5tcl9oYXNoID0gDQo+ID4gPiBIQVNIX0FMR09fIyNoYXNoLCBcDQo+ID4gPiAr
wqDCoMKgIC5tcl9mbGFncyA9IFRTTV9NUl9GX1INCj4gPiA+ICsNCj4gPiA+ICsvKioNCj4gPiA+
ICsgKiBzdHJ1Y3QgdHNtX21lYXN1cmVtZW50IC0gZGVmaW5lIENDIHNwZWNpZmljIE1ScyBhbmQg
bWV0aG9kcyBmb3IgDQo+ID4gPiB1cGRhdGluZyB0aGVtDQo+ID4gPiArICogQG5hbWU6IG5hbWUg
b2YgdGhlIG1lYXN1cmVtZW50IHByb3ZpZGVyDQo+ID4gPiArICogQG1yczogYXJyYXkgb2YgTVIg
ZGVmaW5pdGlvbnMgZW5kaW5nIHdpdGggbXJfbmFtZSBzZXQgdG8gJU5VTEwNCj4gPiA+ICsgKiBA
cmVmcmVzaDogaW52b2tlZCB0byB1cGRhdGUgdGhlIHNwZWNpZmllZCBNUg0KPiA+ID4gKyAqIEBl
eHRlbmQ6IGludm9rZWQgdG8gZXh0ZW5kIHRoZSBzcGVjaWZpZWQgTVIgd2l0aCBtcl9zaXplIGJ5
dGVzDQo+ID4gPiArICovDQo+ID4gPiArc3RydWN0IHRzbV9tZWFzdXJlbWVudCB7DQo+ID4gPiAr
wqDCoMKgIGNvbnN0IGNoYXIgKm5hbWU7DQo+ID4gPiArwqDCoMKgIGNvbnN0IHN0cnVjdCB0c21f
bWVhc3VyZW1lbnRfcmVnaXN0ZXIgKm1yczsNCj4gPiA+ICvCoMKgwqAgaW50ICgqcmVmcmVzaCko
c3RydWN0IHRzbV9tZWFzdXJlbWVudCAqdG1yLCBjb25zdCBzdHJ1Y3QgDQo+ID4gPiB0c21fbWVh
c3VyZW1lbnRfcmVnaXN0ZXIgKm1yKTsNCj4gPiA+ICvCoMKgwqAgaW50ICgqZXh0ZW5kKShzdHJ1
Y3QgdHNtX21lYXN1cmVtZW50ICp0bXIsIGNvbnN0IHN0cnVjdCANCj4gPiA+IHRzbV9tZWFzdXJl
bWVudF9yZWdpc3RlciAqbXIsDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29u
c3QgdTggKmRhdGEpOw0KPiA+ID4gK307DQo+ID4gDQo+ID4gIEZyb20gdGhlIGRlc2NyaXB0aW9u
IGFib3ZlLCBJIGRvbid0IHF1aXRlIGZvbGxvdyB3aGF0IGRvZXMgLT5yZWZyZXNoKCkgDQo+ID4g
ZG8gZXhhY3RseS7CoCBDb3VsZCB5b3UgY2xhcmlmeSB3aHkgd2UgbmVlZCBpdD8NCj4gDQo+IEkn
bGwgZml4IHRoZSBjb21tZW50Lg0KDQpUaGFua3MuDQoNCj4gDQo+IEJhc2ljYWxseSwgcmVmcmVz
aCgpIGJyaW5ncyBhbGwgY2FjaGVkIE1SIHZhbHVlcyB1cCB0byBkYXRlLiBUaGUgDQo+IHBhcmFt
ZXRlciBgbXJgIGluZGljYXRlIHdoaWNoIE1SIHRoYXQgaGFzIHRyaWdnZXJlZCB0aGUgcmVmcmVz
aC4gT24gVERYLCANCj4gdGhlIDFzdCByZWFkIGFmdGVyIGEgd3JpdGUgdG8gYW55IFJUTVIgd2ls
bCB0cmlnZ2VyIHJlZnJlc2goKSB0byByZXJlYWQgDQo+IGFsbCBNUnMgYnkgVERHLk1SLlJFUE9S
VCwgd2hpbGUgc3Vic2VxdWVudCByZWFkcyB3aWxsIHNpbXBseSByZXR1cm4gdGhlIA0KPiBjYWNo
ZWQgdmFsdWVzIHVudGlsIHRoZSBuZXh0IHdyaXRlIHRvIGFueSBSVE1Scy4NCg0KWWVhaC4gIEkg
YWxzbyB0aGluayBhZGRpbmcgc29tZSBjb21tZW50cyBhcm91bmQgdGhlIGNvZGUgdXNpbmcgcHZk
LT5pbl9zeW5jDQp3b3VsZCBiZSBoZWxwZnVsLCBhcyBJIG1lbnRpb25lZCBpbiBhbm90aGVyIHJl
cGx5Lg0KDQo=

