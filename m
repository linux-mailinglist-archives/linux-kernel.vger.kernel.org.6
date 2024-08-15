Return-Path: <linux-kernel+bounces-288726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7D4953E07
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0FDB1C2140C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39E6155739;
	Thu, 15 Aug 2024 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7xHz/iz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18451AC898
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765527; cv=fail; b=W+8QHGQ/MhYaWjSYrtEu0Io9L9wsqZTtEDJvB82D7qntKKhpSx0rtGQkCGX6ij3jZOD3T9WxWJOMZzHBYagYAqhOO0Cl1P9FX6MecQ6TB0sDkCXJWswJCeo06ieR7pN0HTrEavDpbiw3TKVvKzQyIBNxVFS+ET1yjUrWTD+lUSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765527; c=relaxed/simple;
	bh=W6rEyrAlMaSA0bhIgjuSeQOYbaU8MfwndWAyft4eXRY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YJ3iPBM0rEJ4icXDthKfyrm7xskeDjpwQpoRBaCRPNXIrTTO8RdHa/9AIxDKHH5a/0gTODHEmXmmAfKSEProZKWd/AIWO81uq+EVsGLbYzNtqCF0e66c0kBFmn9V+GGZw38IpV7oGRD0QhVz1lS4J+Kyr9Z/QXInwFw4EWLSXAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7xHz/iz; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723765526; x=1755301526;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W6rEyrAlMaSA0bhIgjuSeQOYbaU8MfwndWAyft4eXRY=;
  b=B7xHz/iz7rvZ/upuSBSaGJEQ/jXUmYrobWPxwsuz/kXm2hjzZhGQC9uZ
   5CQxDgscGbTMO+fMZjHbgbfG/QiMsPtTfZ2mNGNGoCuFmD9sFKQDIfN2k
   SahQX9TQiKusEFLllhtV7RZtYO9P2KxZvEzJLRxbfOhta2CntLIzmMFln
   wxIKNlpKnyLmH4iAlLHts894KhIiT6L4Y/7OlcbteW8YiEJF1hIarpCCC
   m3A6smOeL9fLBW9ROdBWq3sEqxgSxPLoaRBWkWC7kOg3/AX1swKIefEqU
   UiILTIxUE7iBanDuLiLmcp3JhLcNW4NOV+LyY1VqQQVf/fSM2jlBv/kyp
   g==;
X-CSE-ConnectionGUID: tbSt+9tZQ1mp31wnGfUcXg==
X-CSE-MsgGUID: 3WsLQxfoR8S6uwJmk+y8kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22191745"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="22191745"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 16:45:21 -0700
X-CSE-ConnectionGUID: GCaKMtwVSlin8nVAIc0YFg==
X-CSE-MsgGUID: BsNq+z3OS/GwYu5RiC8ssw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="64357809"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 16:45:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 16:45:20 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 16:45:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 16:45:20 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 16:45:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkXLYpmAo3bmXqU1ShxvdiwPbWaNyibHx8CNxgpEd9lUybI6xebxdRraAucwYSYSu2MacjRkMw0Zb/sv/yT9pquYPol4ZuFwlJJFL+pDMR22c/2GclT+UIMa61v7C508lL80mFtkMl3iB0xh7P545zlDuqfG1OmxRn86WYAme/xSXP/60E6gt/G0x2QXTCZHBhsZcPs3+OMfTj6qfTYHVzizzksXX3mYA9tVedqezZQopyB3i3ssg+paH5Lpd+FGMvOH71Y7A3aH3vPauC9sJM/JrKN/2CvQMqKWeJDA4/KfsXXCTlrZhLKy/RDyustWz38u27bOUv6vGVBNs/4gkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6rEyrAlMaSA0bhIgjuSeQOYbaU8MfwndWAyft4eXRY=;
 b=c+lxr5vDmVhbQooAjrXHXGMbzHIsXCTkT/+zIt5Ao5PlRBAY2XcX6iWwjvh0y4aYhFg5v15nKZ+GoSmPa1riWKlD7wNla0gIm9+2LdZTVzJ2HtaE8R2wPVdo07rshm+jLz/s3XmaPefz5RkOCKqxajr6M9Pmc4Deb4/T1wMB70Eefe5kvGz1UYAwwjSvGYDJqe9F6WC4FkNK48uZe3JpYdn1Oh2k8eR7BxczJZNGVCnCUzvPU7yk+/Hj/BIqVF41BOs/wBQboCg3XXiv1Uonhd0dWp4z+0wXdN+JrIKuy/f72w6b4TMGqWXAiIOEaHv+MhFetdylrBpgKmv2LtnYyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MN2PR11MB4695.namprd11.prod.outlook.com (2603:10b6:208:260::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 23:45:17 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7875.018; Thu, 15 Aug 2024
 23:45:17 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "Hansen, Dave" <dave.hansen@intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>
CC: "hpa@zytor.com" <hpa@zytor.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"luto@kernel.org" <luto@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>
Subject: Re: [PATCH v5 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
Thread-Topic: [PATCH v5 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
Thread-Index: AQHa7wyYhUU6XO87fECf5A1v+fOkRLIo/EGA
Date: Thu, 15 Aug 2024 23:45:17 +0000
Message-ID: <3d7ec1cd218e835f730fca7cf9e3b4d300df6830.camel@intel.com>
References: <cover.1723723470.git.kai.huang@intel.com>
	 <47d9f1150a6852c9a403b9e25858f5658c50a51d.1723723470.git.kai.huang@intel.com>
In-Reply-To: <47d9f1150a6852c9a403b9e25858f5658c50a51d.1723723470.git.kai.huang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (3.52.3-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MN2PR11MB4695:EE_
x-ms-office365-filtering-correlation-id: 0123db88-d352-4b20-b4ab-08dcbd8450f2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VFptaFpYTVpnNjhEdlB0eFgzc3h1OGJZaWZJaGE0SVNQY3JNeDBXTmdINWdi?=
 =?utf-8?B?YzYrdXRQS3pvN0tHSVUycE84RVNRdnlRdUxMV3puUUxacFphaER1ZWt5bUt1?=
 =?utf-8?B?S3B3K1RCTEsvWldXYVFMQWZ0anpzR21HOVk1cEw1UW93NlZFbkRJU21WWDdK?=
 =?utf-8?B?RVJoMm5BWCtXdTlicVg0Y21wNGc2VHZSSnNRaU41S1VVSEZVYkY3U3ZZQmh2?=
 =?utf-8?B?bC9ZREh1QVo3eUpwbnBFYkcvajhlTkVkK3lMRDJ2N05UMi9oLzBNOUpMYkR0?=
 =?utf-8?B?SWo1dXMyQ2QxSVd0YWJTczdoNWlUb05laG9hVi9MaE5TYU9KN0NzakZ0b1pk?=
 =?utf-8?B?MTc2dk9nVDdqZW5jcVpTSWhaVzVlZkFkZjM5Um5DYWszMTBzc1hTSk4yNndO?=
 =?utf-8?B?a2E1TWQ3d0lnZk9IWXVXQ1FHT1JJV05VYm8zdnZjN1lvRDhXMURTb01nTldy?=
 =?utf-8?B?UVBvN3cwM01mTEVzcXVWRDkrbTV5bGZLWkViZHpmK0pZaXY2czV5MWYza3pZ?=
 =?utf-8?B?UmgvK2ltdUEwNUtBeFlzZUR3RkJsUEp1ajR3TTlOcDhtZ2g2Q1NpbnV6dStp?=
 =?utf-8?B?Mk9Pd0ZQajZucUgwck5UUk1FenpiYnZoQWkrTS9hOWduRHN0RjdTdUFScGpX?=
 =?utf-8?B?Wk9Fdk9icUlnNE5rVGZyTlljam04OE4rViszdkNTaXJFQ3JHY2pnNSsrREdO?=
 =?utf-8?B?Skthc0JjV3UvWDlxUlhvSVBiQ0JXaUYxMDBjNVhpcm5raVQyOUYvSHhXR2tz?=
 =?utf-8?B?Zm5VdkszQVY2SGJYQ1VNVEVIWlIvVU5IOHEwNm9saTBOTUprR1N2NS9XL2JU?=
 =?utf-8?B?Nm9lZTVjOSt3eUhzeFBhNW5JVkZPMmNZeWdJUEpxSC9IeWladjZWU2taQWRE?=
 =?utf-8?B?Tmd3S1d3SlZtbVAwU3oySjVQcGVmSHlEZWpsWVdqSTZ4ajlIaStFWXZ1RS9Y?=
 =?utf-8?B?anNmRGdXaHVySTEyMXBnV1lmYUdNSGFoV2hGWGJXN1RndDNoNFQ3ak44WFFl?=
 =?utf-8?B?SVl1SWt4V1FPNVN2NEVDUy9ITGNTNlljQUFva3JBVWN6cXFWQmY0T2swbFNO?=
 =?utf-8?B?V29RY2JkRDVWUDJUQWkrV2FIUzVEeXl4OWFyenRmS0wrb1BzT01UcDFtWVdh?=
 =?utf-8?B?RVFsRjVyUjlEcnZFd0J4dkhJMUwzM3VGMFpCdWtMalFFR1lvVGZwVGJvbHhr?=
 =?utf-8?B?SS9Ba2lpbEZucitHbDF0QzNPUWNMd1VXeGhNZlJRdzd0UVkzNkJ4czhQU0Ez?=
 =?utf-8?B?NDkzQjQzSmV2U0FWOXZBclNpcnpWZitJbHFEY2VyajBnUWFSUXlFVjBuSnZh?=
 =?utf-8?B?SUdtVm9hZWRLZ3h2R3dHR0F1a0VLRmRPV2orRDArNE9FMVNkdnQ3RlVoNXpS?=
 =?utf-8?B?bmVWRUlCTGlzak04YzQxSU5FVkhSWUV5a1NhMllxQkh1TWVkbTJlK2lWRE82?=
 =?utf-8?B?NXNHRExZN0lkUFpwdy9mK0V3Yk1mcDIwWTF6ZEN0OFIxbXpRbjZmRFJiSjhL?=
 =?utf-8?B?VHAwWUFYRjgxWTdFeFRFRHdCQnNSeE5ORFlEQnR3QjZRQlNFTW5OK1ZvbGFS?=
 =?utf-8?B?VE1yWE5lVFk4NGMxb3hmOVVTNGdrSzBGNnVMTVpLdWRtU1lua1A4YUIvSXZW?=
 =?utf-8?B?RlNhWHhqTUNsRlY2VHh3MEZQS005VWEwYWxKbTY1NEFNbHBueCtGeWphL0E3?=
 =?utf-8?B?clZ2NHVqVC82MUlSMGNhcHRCZzVsblNpcFFGbExzTjU5bXllT00vV2lGMXU5?=
 =?utf-8?B?SlhwUythLzQwKzZBZ3lBZjJjT2pGZmhFVktGaUtPeG5MbXptN1pwcGZtRU9s?=
 =?utf-8?B?NzVSSGMxV3AvcDRWejcrVzZHVkxMUGo2bGFSaUZueXhsWHo5SmlEZzl6NHpj?=
 =?utf-8?B?enRWMzFmd0ZYMmpBS25sVi81SjN6TXJuSk1od2N4OHJWeWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekZ0RVV6bzVUMTNaa0YyZHJ4bDZOblJBcGd4b3piVFM1ZkNEU3BFbjZxeW1S?=
 =?utf-8?B?eE5YOHNJV1dVYjE0UDlONlVWRFdSZzZpZm1IT0JQNVkza3RRc2FuWEZGQUZM?=
 =?utf-8?B?c0ZlNkNJMW5qQ3N3MmMrU2VKWDVOTHFLaGthQ05HbllhU1gvZlZwV3dtT3JV?=
 =?utf-8?B?SGpMUWpUbmJnWjdaTEo2VERxbE9xVEZPdjlMSWs1Y2xCMGhOY1Y4bnFvNG9X?=
 =?utf-8?B?UTRsN25nd2V2TnlPS3RjZXdIUTlJSmFZS3dKRWs3eE1HeHRvc2hSSy92MEto?=
 =?utf-8?B?akRPMnFyMUx0VWhCb1BNR0t4eGErb2hTTVRCKzBUanY5bEtnWUFoNjgyUWNN?=
 =?utf-8?B?bjdhdzc1UmE0ZUZsYW1UOWJ1Z3lteGFJdFNsc1Z6bUtsSnF5dURBeEZmK1BK?=
 =?utf-8?B?VFkxOWw2aE5TSjIzVkJIUEh6OFlnckhqMi8rbDFxSFRvYmN2bXV2YlVUMVlS?=
 =?utf-8?B?R3JDRG1wNVBOblNQeWZyWW43SGVDUUc5dzRha3hnc0VaemU5eTNMM3puWUpV?=
 =?utf-8?B?Z1ZRMHVIemtuejc0eVJ3VlFYK0gvamRMN1oyZ1NoSWRUZGFTUDVYSG1kOVQy?=
 =?utf-8?B?dDlYRUxCZVJFayt4c1FWdEw3QUovMDZJT29RdUp0ekEzcnFrYzVTMUQ4aFNm?=
 =?utf-8?B?L3FobjZhb3R6Mm5yMXJ5VTZrMUVwczh5ZGlGMzZkVUxNTnRHYkY3Qkk2WUw5?=
 =?utf-8?B?enR3WWM2K0xML2hZWENQSzg0NTRsek1qRkphTXZJL2EzMjlUSExycmJLbGJz?=
 =?utf-8?B?NUlzOTlJbmRTYzdsN0FTNElBMTlnTWV2M003SDQ0ZDUrcU9KOTJULzFsWnRh?=
 =?utf-8?B?OVdFRVJMTTlZZmtnak9tSTRIRVNxOEx0bjBBRW1CaU5sYmpJT3M2WHlUbVNO?=
 =?utf-8?B?dmkrSzNKTFZhMi9FM0RnQlJ6bzJ5UjRudElZdU1NZ0tUbzVEQnptMHpjUlV2?=
 =?utf-8?B?RnR1NFk3c3MvUEZ1bVpqRStJbVVDWHgzTUF4MDYyYk9KOTJpNFh2MXhDZ1ZB?=
 =?utf-8?B?ZGxSaVlLWG8xcktqdXJnTEFndzZwU3JUK1E0cW56OVpJb2FwazdndUxhTW9n?=
 =?utf-8?B?cVRVL01LcHFvUlV4RFNBS0lNZFAzYlZTMzVzZ28zcTdRV1JPdk01elc5eTFS?=
 =?utf-8?B?YXNJM1YwZzlZeWZSVHByTGJtdnM1cENBK3N0MUlvWGR6SE9qZmhRUS9wOUwy?=
 =?utf-8?B?Z3U1dU5LOWRiSWJ2NWhNZTJFeWxQSWw4dGZaKytQd3RsQTBsRmVGRUhjbVpL?=
 =?utf-8?B?dmRvcm5yOW5Vby9sYzE1UlY4ZmN5WU9MNGxJZWNrYkxlV2krR3RmTEJwZzBR?=
 =?utf-8?B?OVFaS1RwcXh5dERMOHB2ZWdrNHVvNU5sVll2Z1ppWC9UZmxXSW5McEZuMTlS?=
 =?utf-8?B?eFdZU3dvZStIZXRSNGRtdkR0aWdYRDZueVk1SDR4UVZXU2kwdVlmZExCK1Vj?=
 =?utf-8?B?ZHljMnk2YmlUK3h2Q0x4ZDBHbFFDckdEZnFsWlFGaG9qdlN4dUU3NzJHZVhm?=
 =?utf-8?B?cEJPN1Q4N2F3dUVacURMNFNDV3B0eHg1UEQ0YnJKc0k3R2JOUTJubThDRWFP?=
 =?utf-8?B?dHZyL1lPc1FjcURKUzNrblQ2WktsL0hvcXJWWkxMbmtpUXJ3NTVBdFlHUG51?=
 =?utf-8?B?RS9oWmhTc0hjSEpYcEp0Tmc5aTNXTWpqZkMyYmJqMTZHOThmQ2F0OGJGWVVz?=
 =?utf-8?B?NlgralNVM3RzdUFDQmsrUitCZTR1N3lScDluOFhEV3VpeGpwdEhaTy9zenA5?=
 =?utf-8?B?K2Z4aDFjNjdBQUZ1c3g2QlpUaGdjR3lWMFY2SDdCM2V4OXlXWVgzMC9oUWti?=
 =?utf-8?B?Q0V6WUN2eGJ4UmFXZ0pYMGREQ0UwV09wbGRGMzgySVV2eUVUYnJ1S0NZdFo1?=
 =?utf-8?B?OWJLTi9UMm1LaGdtc0NjM2M0MzBVb01TKzNNV016QXozTU8yVXNlS0dNOUdV?=
 =?utf-8?B?dTh0Y2FDNkpYS0hJVCtmK0RmVndXTzVyYWovaHIxTUpJR0c0bjVzTnpydDMy?=
 =?utf-8?B?L2ZJMXp6emZQTk8ySXU1dFFLMkV0bkJiUTN6WDJQNHBOTnpFUlZYN1Vmb2hx?=
 =?utf-8?B?TFl5d3VLb0VwZ0dlbDR3cjVEN3AvS25OM2MzcEpKT2g1ZW9LMlM2dURhWlZU?=
 =?utf-8?Q?Q8x6oNPOZeU9AhosPf2BgQXb0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48B318B385284F4BA29CD98BDD64FEC2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0123db88-d352-4b20-b4ab-08dcbd8450f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 23:45:17.0801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XpO3K3FR967/rc1VEdKhgwLvlR225E8E2blLr3+Vc8BkcOXKBkuwAm5nd37gHqEUrcl15uavIKg4DylLIm45/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4695
X-OriginatorOrg: intel.com

DQo+ICANCj4gICNkZWZpbmUgQVJDSF9IQVNfS0lNQUdFX0FSQ0gNCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMgYi9hcmNoL3g4Ni9rZXJuZWwvbWFjaGlu
ZV9rZXhlY182NC5jDQo+IGluZGV4IDljOWFjNjA2ODkzZS4uMDdjYTlkMzM2MWEzIDEwMDY0NA0K
PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5jDQo+ICsrKyBiL2FyY2gv
eDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMNCj4gQEAgLTM5Miw3ICszOTIsNyBAQCB2b2lk
IG1hY2hpbmVfa2V4ZWMoc3RydWN0IGtpbWFnZSAqaW1hZ2UpDQo+ICAJCQkJICAgICAgICh1bnNp
Z25lZCBsb25nKXBhZ2VfbGlzdCwNCj4gIAkJCQkgICAgICAgaW1hZ2UtPnN0YXJ0LA0KPiAgCQkJ
CSAgICAgICBpbWFnZS0+cHJlc2VydmVfY29udGV4dCwNCj4gLQkJCQkgICAgICAgaG9zdF9tZW1f
ZW5jX2FjdGl2ZSk7DQo+ICsJCQkJICAgICAgICFib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfSFlQ
RVJWSVNPUikpOw0KPiAgDQo+IA0KDQpMS1AgcmVwb3J0ZWQgYmVsb3cgd2FybmluZzoNCg0KQWxs
IHdhcm5pbmdzIChuZXcgb25lcyBwcmVmaXhlZCBieSA+Pik6DQoNCiAgIGFyY2gveDg2L2tlcm5l
bC9tYWNoaW5lX2tleGVjXzY0LmM6IEluIGZ1bmN0aW9uICdtYWNoaW5lX2tleGVjJzoNCj4+IGFy
Y2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmM6MzI1OjIyOiB3YXJuaW5nOiB2YXJpYWJs
ZQ0KJ2hvc3RfbWVtX2VuY19hY3RpdmUnIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1z
ZXQtdmFyaWFibGVdDQogICAgIDMyNSB8ICAgICAgICAgdW5zaWduZWQgaW50IGhvc3RfbWVtX2Vu
Y19hY3RpdmU7DQogICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+
fn5+fn4NCg0KVGhpcyBpcyBkdWUgdG8gd2hpbGUgcmViYXNpbmcgSSBkaWRuJ3QgcGF5IGVub3Vn
aCBhdHRlbnRpb24gdG8gdGhlIHJlY2VudCBjb2RlDQpmcm9tIGNvbW1pdCANCg0KICA5M2MxODAw
YjM3OTlmICgieDg2L2tleGVjOiBGaXggYnVnIHdpdGggY2FsbCBkZXB0aCB0cmFja2luZyIpDQoN
CndoaWNoIGludHJvZHVjZWQgdGhlIGhvc3RfbWVtX2VuY19hY3RpdmUgdmFyaWFibGUgaW4gb3Jk
ZXIgdG8gYXZvaWQNCmNjX3BsYXRmb3JtX2hhcygpIGZ1bmN0aW9uIGNhbGwgYWZ0ZXIgbG9hZF9z
ZWdtZW50cygpIHRvIHJlc29sdmUgYSBwcm9ibGVtDQp3aGVuIGNhbGwgZGVwdGggdHJhY2tpbmcg
aXMgb24uDQoNCkEgMTAwJSBzYWZlIHdheSBpcyB0byByZXBsYWNlIA0KDQoJaG9zdF9tZW1fZW5j
X2FjdGl2ZSA9IGNjX3BsYXRmb3JtX2hhcyhDQ19BVFRSX0hPU1RfTUVNX0VOQ1JZUFQpOw0KDQou
Li4gd2l0aA0KDQoJYmFyZV9tZXRhbCA9ICFib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfSFlQRVJW
SVNPUik7DQoNCmJ1dCBJIHRoaW5rIHdlIGNhbiBqdXN0IHJlbW92ZSB0aGF0IHZhcmlhYmxlIGFu
ZCBkaXJlY3RseSB1c2UNCg0KCSFib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfSFlQRVJWSVNPUikN
Cg0KYXMgdGhlIGxhc3QgYXJndW1lbnQgb2YgY2FsbGluZyB0aGUgcmVsb2NhdGVfa2VybmVsKCks
IGJlY2F1c2UgQUZBSUNUIHRoZQ0KYWJvdmUgWDg2X0ZFQVRVUkVfSFlQRVJWSVNPUiBiaXQgdGVz
dCB3aWxsIGFsd2F5cyBnZW5lcmF0ZSBpbmxpbmUgY29kZSB0aHVzDQp0aGVyZSB3aWxsIGJlIG5v
IGFkZGl0aW9uYWwgQ0FMTC9SRVQuDQoNClRoZSBpbmNyZW1lbnRhbCBkaWZmIHdpbGwgYmU6DQoN
Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMNCisrKyBiL2FyY2gveDg2
L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMNCkBAIC0zMzEsMTYgKzMzMSw5IEBAIHN0YXRpYyB2
b2lkIGtleGVjX3NhdmVfcHJvY2Vzc29yX3N0YXJ0KHN0cnVjdCBraW1hZ2UNCippbWFnZSkNCiB2
b2lkIG1hY2hpbmVfa2V4ZWMoc3RydWN0IGtpbWFnZSAqaW1hZ2UpDQogew0KICAgICAgICB1bnNp
Z25lZCBsb25nIHBhZ2VfbGlzdFtQQUdFU19OUl07DQotICAgICAgIHVuc2lnbmVkIGludCBob3N0
X21lbV9lbmNfYWN0aXZlOw0KICAgICAgICBpbnQgc2F2ZV9mdHJhY2VfZW5hYmxlZDsNCiAgICAg
ICAgdm9pZCAqY29udHJvbF9wYWdlOw0KIA0KLSAgICAgICAvKg0KLSAgICAgICAgKiBUaGlzIG11
c3QgYmUgZG9uZSBiZWZvcmUgbG9hZF9zZWdtZW50cygpIHNpbmNlIGlmIGNhbGwgZGVwdGgNCnRy
YWNraW5nDQotICAgICAgICAqIGlzIHVzZWQgdGhlbiBHUyBtdXN0IGJlIHZhbGlkIHRvIG1ha2Ug
YW55IGZ1bmN0aW9uIGNhbGxzLg0KLSAgICAgICAgKi8NCi0gICAgICAgaG9zdF9tZW1fZW5jX2Fj
dGl2ZSA9IGNjX3BsYXRmb3JtX2hhcyhDQ19BVFRSX0hPU1RfTUVNX0VOQ1JZUFQpOw0KLQ0KDQpB
bSBJIG1pc3NpbmcgYW55dGhpbmc/DQoNCkknbGwgc2VuZCBvdXQgYSBuZXcgdmVyc2lvbiB3aXRo
IHRoZSBhYm92ZSBhbmQgcHV0IHNvbWUgZXhwbGFuYXRpb24gdG8gdGhlDQpjaGFuZ2Vsb2cgaWYg
SSBkb24ndCBzZWUgYW55IG90aGVyIGZlZWRiYWNrIG9uIHRoZSByZXN0IFREWCBwYXRjaGVzIGlu
IHRoZQ0KY29taW5nIGRheXMuICBUaGFua3MhDQo=

