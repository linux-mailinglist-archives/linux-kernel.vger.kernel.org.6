Return-Path: <linux-kernel+bounces-568463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C696A695D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D28465CBB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32421EFFA8;
	Wed, 19 Mar 2025 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fghB9o3t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CBD1E5B7B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403844; cv=fail; b=Z9qfmn+BJerxP7C8xwju71opE8scl9Z3z1HV8jdCtRnAUJNJB2ejeI0ypDzq0cZUzy2JbmOXCM7g2PHkqpqS0Wm8G12EmdXIJ1uOTxIjBB1e+3aUuHuwX919ii7e/rARJ92w5gfURx0cP6IJtDe1rjT04w2qo1hVlQ/DbXDsM5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403844; c=relaxed/simple;
	bh=BGRN5az5KyEUv/f75ZbdCjqPYU+W1ahbL9z+G4VRTbo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jD9kIYJlkEx3x0ODDY2ZG/J/t/WgMenkp+247CTb+/mYGRyMn2SsylOIakaDXjq3h1tdYk42P1CiCuqWPngmvKAJ+RKwenfGy9I+VWbmeOAO4k4xWVVT41dXHkXMlZJNSi/zgxkl2GhTBm20fVUp2qiUBqU5FWrVHcrfbIIh5cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fghB9o3t; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742403843; x=1773939843;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BGRN5az5KyEUv/f75ZbdCjqPYU+W1ahbL9z+G4VRTbo=;
  b=fghB9o3tBxd7qhQOscU3yoifBvPalQsOuCfvBSV/DxFIGj5bktxWrpYZ
   +3yZozWQMIGvFiONEleiylCQg2tlwejsHSQCt1LEt6zKAIm9FRvQRr/2o
   2XUpZtpn2B6W219leJsosw7SpjyvMcfTF2t/z4yiGQGEUH1/412grG7/J
   qbdq/00yvWcUBt3YqXM/oHfR9MaxSdwELBOxfmFNjRrfxR90x8Gj3Xt6h
   E7xJBW7UzCtHHjyrarH7PPUu6azxfOuuWrOF2lIObrjKa2m1XuT/Oz1lT
   cc3a6kZxHCxjaOu5us+5BskomQMoUDIhUCFePkLMBly4mlZCe9mW10s0J
   w==;
X-CSE-ConnectionGUID: G8u8Yf5lSliEguG0ve9rtw==
X-CSE-MsgGUID: BBzmC0oiQ02NvghbBohZ1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43739092"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43739092"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 10:04:02 -0700
X-CSE-ConnectionGUID: KwR8NSD2QCiUEu0vWJD1cg==
X-CSE-MsgGUID: blS/JkpiRD6rirJ/VPeiTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122708302"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 10:04:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 10:04:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 10:04:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 10:04:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aALSXQZEMzkN4UyEkV7WRWi9pB8n0WWxOE04UFk3PF4vNfcIzALxm3hIUH0Omy1tCAXcdX/xo2+pGmpojeoKEK5N0aKQKqrQBp5o3Brcs9IjKWV1UfE5GriGDfEGnJgOGCYYYpS+LVz86619C6NXWU3EpubLo4Y56NJphLoAUk+24aejpAGYaWAB933SpeYfge99Cbj1ztBl6QBrJNvRA5+bhj12mkf4V65top01MrOsM1myK4WYAFiyj+HkzwEjPutRN7Hs6P+t6XvKjpivNj0qYamwpA/kD8y9YNiLQWLb+OQM0bKExUV0Ctp/1On1cEJe825OKIb8QuIlFv+6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGRN5az5KyEUv/f75ZbdCjqPYU+W1ahbL9z+G4VRTbo=;
 b=aBueWskwfLzl66PREDiBi6vqrLoLhBLHVQDf5GQ5uk+Gon/Nk9tBxFeDy3NzGSVyvSMQ1EVPbZauNVnJikWn3jHQVLBlwxh+X1Z6rxOI7kUUD9E4AHTmz54gBOtYgqYDremzFQ7aH7C81w1IDsS39YW30u9EnUK31/9OQO4Dasjj688c7IiLITE8rm/K9jzjefQZjQL00T4aZeNDWOUJcTI+3X8MqV6x2hCRexfaPr50pdOGUhisZWpbmdfIT8ZwkV4pJthTSy8TBZaZbuXD5yBb1KFXSaQ7oT9PljmQpYJBCGGk6w19TvexKgDysqsmkplob0kF7rIyjOI4vrKKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 17:03:44 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 17:03:43 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>
CC: "Huang, Kai" <kai.huang@intel.com>, "ashish.kalra@amd.com"
	<ashish.kalra@amd.com>, "dyoung@redhat.com" <dyoung@redhat.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "sagis@google.com" <sagis@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "Williams, Dan J"
	<dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for bare-metal
 in stop_this_cpu()
Thread-Topic: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for
 bare-metal in stop_this_cpu()
Thread-Index: AQHbk0LE9xNDz/BUxUyAtvW7JgE+xLNxaCeAgAXoTYCAAJjQAIACy6sAgAAGQ4A=
Date: Wed, 19 Mar 2025 17:03:43 +0000
Message-ID: <a11ec309acdebd6149d7daf2be6de76a92308a0a.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
	 <e9ee3c7ffc3ba6feb97247faa40789684e39ffd0.1741778537.git.kai.huang@intel.com>
	 <e0d9a3d599025c92fce5e159e8acc1af32844912.camel@intel.com>
	 <gbxpvgmmzf354g3gccflrv5shtaque4rd3uklrgltlbnedip7y@hhwvyhxh46nk>
	 <c7cec9118a23220986c1894f18cafb3aa5b9fc1f.camel@intel.com>
	 <eb2e3b02-cf5e-4848-8f1d-9f3af8f9c96b@intel.com>
In-Reply-To: <eb2e3b02-cf5e-4848-8f1d-9f3af8f9c96b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB7765:EE_
x-ms-office365-filtering-correlation-id: c4770cde-7e91-4467-1c28-08dd6708017c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YjEzdDdyQjZzUjI1c3VxV3lKTlA3UEFqcnNGazJ5dkxLRTF2NzBUaDhOZXNF?=
 =?utf-8?B?RTNmUThmdUprOEExWVJOSHdhc3pPTDRsamlHVzFWc2ozQi9NSUg1QVVrZHQ1?=
 =?utf-8?B?dFdSN3JpaGJieVl6d3BOZ1FwbUVibVNIc3VHSWZoalpoajFlSFlGOWt4aGp5?=
 =?utf-8?B?eVE3REg1QXBkMmVPYnJ5UFAxK1hkcjNqUFJ1MUtKOWhlL3JCQmFKQjdtcjJo?=
 =?utf-8?B?eHE1NWVESDFYeWhUNUR6Ujh4TVp0RGVpcVZmVCtqWHBJTUVRYUgzYS9GSjl2?=
 =?utf-8?B?bDZJaFhJaGFzUW80Z2k4UWVFK3BFUDg2c3JyK05MQ2ZOTG91VTdSTmFudlNH?=
 =?utf-8?B?N24ySDlNQW9sMVlkdjFTRWQ3dzh5RHRxMGpQSXZlL05BczFTc0R5Qlh3Y1R4?=
 =?utf-8?B?MjE3OG9TQkJBS2w2S0diVm9Mc3BkYkV1dDJaWk5RUmtkZWhZSlp5L1Y0cWVm?=
 =?utf-8?B?ckE5VFphdE05UktWSDJ1ckJlN0dLZU5OWUxWK0hwcTBza1J5K0tMRC9xUWV3?=
 =?utf-8?B?NllDMHpkM1dDWTVQcVpxUE1PbXgwNU9EMFRBdVVJSWt0Q1BuZ2ZGc2JEKzBZ?=
 =?utf-8?B?TFBqWVVKYk1kb3hlVjRyVXErM0lMTkVVeWlTdVRpVGphN0cwallEMXFkSml1?=
 =?utf-8?B?NEN4dURoRmxETmxDdlRFNmJ3OUZTZ2RORUt4UTZiTGdhVmc1c3R3ekx1Ujly?=
 =?utf-8?B?cDlLczhDV0tXNE5YWW5lV2VXTmUyb2FmQWdXbUdHTW9zbEt3Z3BLOUxYQ2xT?=
 =?utf-8?B?Vk41bkFDRTUrTk1FL2NNYjEzak1ZdHNMYzduRFQ2ZnpreU54OFowbkQ5ak5k?=
 =?utf-8?B?QXczaFdVYm8reW9KOXdscFRSdk9JU3NFNm8wNkZMTVlMd21NQksvVG1FOFBt?=
 =?utf-8?B?MHZuRWdYQ09HNkYzaUFUK24vdnBPdVlIblVuWTlEOVBybkJKc0YwbVpRS2xO?=
 =?utf-8?B?aFU0dzVpU0RYTTFkTjZjRnIrd2hrcHAzbUN6WVpucnFxR2JJbk9ETVJUbWhm?=
 =?utf-8?B?dHZxSjY0SDF4K1RQQnhHOFRsYi91bTJ4TGE5VjB0MmE5Q2hkdkVwMGVQZ2Nq?=
 =?utf-8?B?bmgzdVF6VncxczJlVzR0MEQ1bnVnOGRDSHEvSnpKS21TbnljeXEzQWNEZzl0?=
 =?utf-8?B?OGtzYU15ZVVjcVJWU1MyaWRTQjhEcXY3RkZHekNUeTRPZjNEbjBkVFhoaTU3?=
 =?utf-8?B?RUdLZ2ZzaldlS2F3UjFwVXdiUndnTkVldStrUk1Iam1Sa3hkaDRBSXdTM0xl?=
 =?utf-8?B?VUMvUmlKVmJkRFFmaXFpVm9Pdk54ZjVpeUxmdzJNbVlLazRMN3hpYUJVTTE5?=
 =?utf-8?B?K2tvTVlHdlZmVWR5TXVmdFlqbkxmNHVVZDhCRWU1UEpHK3Z1SHp1WlZiRTBk?=
 =?utf-8?B?RjZWVXRpSXZrRmVwaXNCVCtRUXNlampvUzlPT255STZ3dzlnd3pySitRdTVm?=
 =?utf-8?B?TUpGeXhNUFR6NU1iczdWTm52dVkySy9Ea2J0MGFuRTVGTXZoT0VYNk5hRWQw?=
 =?utf-8?B?cWU0MHhkd1pmT3NRZllSTVhBcHlWVFlsc3hGWE4rcUF3YWMyeTZuZ3ZZTkFn?=
 =?utf-8?B?ZFRWZTFibVRhd3NSMU1lMnMyZU5lVGxmY3hlMDVXWUluZURmcVcvTUZYL0lt?=
 =?utf-8?B?U3E4ZFNSQ3VIL0JudnFlYlJqMFkzNHBDV1BBaVhTNTZ2S3RKOEd1b05KZ1R2?=
 =?utf-8?B?S1NZVFRpaUNVTStSeVl6VDdsT0pwMDdYY3o3VS9PUi84czhOd0F5NUg0Q1A2?=
 =?utf-8?B?WmUxV2h0RUJEQ0hHZ1NobUR5MGIreGd0RlI1NUdvVEZaS05RWlQyVmtIemJW?=
 =?utf-8?B?aHF6K0tveDNhTGJabGgxNmpBV1VUcVBGajRSeFo3VlZIb3BLWnFxelVJU3hT?=
 =?utf-8?B?WGtXdmZEV2pVdmMrQ1JrWk1HNnAyejdqNUE0N0cza0U0NzV0QXdPUTFacXVI?=
 =?utf-8?Q?K9rAEAeyvYCzc8gluMvatiEfNkZWKdrm?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emEzdzUrcVVUQXNQN0pzSGdZbVZBWnlMeVdyMllmLzEvcFIra0d1a1NjdmdP?=
 =?utf-8?B?UzBLdlpWR0xkRmphMzZtMCszN1l5bFZpbWdaUEdlbEV6Mk90YTFXMnJSaTJG?=
 =?utf-8?B?ajhDb3krWW9jQ3VMeFpCdWxmSzR6dHV1T0FiWVlLOXVEaGExQndqd2tTYWRt?=
 =?utf-8?B?bFFyUDFpM3hjWnZ2VTE5blJkTlVWRnlabGt5WnNGUGZMRWFOWm9aNTdRYkdv?=
 =?utf-8?B?Sk03Um9neTVVeDlJamU1a2tCQTlTL1ZjSUZHc1JXVG9UbVMyenMvVExzcjc5?=
 =?utf-8?B?MkdCSnB1MVlOVUJrQmJnNXU5SUl5WGF0dE9sR3Y4UFg4ZCtJS2VRdmR6MHM5?=
 =?utf-8?B?bFZFWENISVAxTkNwWWd1bUVsbWsxcjNGdW9hZVRST25Ib3ZhZGc0cDNqWFFp?=
 =?utf-8?B?dFNoQktFbjN2Y1h3RmdibVRhZUltNnhLd2NkK3kzUkpqd2VmQjBsdjJqVUFq?=
 =?utf-8?B?UkNtVndsSkpZK1A0WFBpd1VPemNnb3BaRDJBM3g5LzZldjIxWmF6dGZ6MUNC?=
 =?utf-8?B?V1h4dEw4U1pHV3BPQWdnQzkyc2U2RUt5cENnZ25qOVp5bnB3QXUyWG5PL3lh?=
 =?utf-8?B?MW5CL0NQN2xqa2Mwd3VzN2Q4UnNINUNrckdobTRORVhhdjR2QTFGZXhzRTMx?=
 =?utf-8?B?VTRBSFJkRW9US0RnU05mTythSTVtcFZ5Um4vendNNkw3UWFmREJPYW52RXhh?=
 =?utf-8?B?Vmw5WnVXNENVNTVOdnBxcnNvd2UrSVV2UXF6UHpJUlRWY0NRMndtNGlPUERY?=
 =?utf-8?B?RUNCQjVzd2JQZXo2SEpuUzU3UERveXRkRzhFZWYyRlcxakRiWG5KZGxWR0l6?=
 =?utf-8?B?TGZKWFpNbWtWSkFYL1M4QlZ5QWRrRUpjTmpudUE0aHJjdElWVTVnanNRZkRO?=
 =?utf-8?B?RWJIVTVjd3VQMlJ1cDJUVzI2NktaTHZFOE9QK0QwbXlmSjA5cWxidThNaUdu?=
 =?utf-8?B?b3JwYnl3aTRpUm1GVEZMZFZTWFI2MmFMeWZUR3V3bDRHNWgyc2tFZUZ1Y3pP?=
 =?utf-8?B?OTdPV1BqcmpCWnB1Tm1TUEpjWDhCUGlIRlozL0paZHlvREZMaGNPekU5a3p6?=
 =?utf-8?B?SW4vNE0rL1JNSFB3VDNmY1UzbXp6QUJMaUJwaDZnSTNRdUlUdFJtd0Zxbjd1?=
 =?utf-8?B?WldlYkxzN2pTbmR0RkljQnV1eUJhcjh0ZGJoSjNpSFgyY2JTN011NVhobVpC?=
 =?utf-8?B?YXRjLzFOQ0laVlNadWJpMnlLVi9tSmhnVTRzOUw4amVyY1NOZ1hiTDhYZ01t?=
 =?utf-8?B?VlNTRGZXSStOWEJJRW1TeGxlWFlWVzJ0ckhkYnM2RHF1UmRTSVJOdnpiNmg2?=
 =?utf-8?B?aHMxRFplTUFSSExQb2dLY0hGWlk2Tk5UNW9RVmptMkZRZnVUM040VEUzS0kx?=
 =?utf-8?B?cnRWcDBwbU5JeWpRU0JUVGlSMkxqRkQ4YXdPcUY1TlEwdWlTY2V6Z2VXMkNP?=
 =?utf-8?B?WmtiZk9TZmEvSHV6ZFBEVHBUZlNjOGpQWXExaFpZSWM2ZjhleDJBRDhKd0xW?=
 =?utf-8?B?Y0tBUkpSRVVkWjJoRi9PaGViZzhPZllIdzFGY1hENkFwZ3p5dDIwSDZDdDdh?=
 =?utf-8?B?V3Q4ZXFsVTRqb3Qxb0JWUU5pMG5TUHpyNEZNTm1aemZvMmFqTHE3b1hvSWFt?=
 =?utf-8?B?R2c3b3dJV0d4TVhIVUd6SGxkVktjQTBQcGlHRmZ6TDliNHJHc1p3Zi96Z3Yv?=
 =?utf-8?B?eElTeHBvS3lrNkloVFNmLzI0K0RDRkRUMXgxVEpySUk5U0RSNzl2LzJ6VGtt?=
 =?utf-8?B?bmpKcmp6bGgxLy8xOHZIQ0dDQ1VlZEVLcnRxL0kyd0JnMUlZa2RIQURGUGJC?=
 =?utf-8?B?cnFZcFRMYW0yUEFTdHNOQ2c1VjkvcmpqWmczQ0wyQ3lYUzQrVnFaUjJaaDRx?=
 =?utf-8?B?MlZjYnNxUm0ydXQ3SWxhc2QrenlabGNmRmdSZlFJM1Y3L1dBNGdLejJHZDFJ?=
 =?utf-8?B?eEQ0SzhoS0J3M0lHZVoxa2k3bGYxZVY5V2RuZ2ZNR0pabkpPRGVjaGxxeWhW?=
 =?utf-8?B?MHRZUDVvMzZPRDFKWE9lY1Mxei9VUTVhY2wrRmREM2p2aHZsTVJKeFFmNkQw?=
 =?utf-8?B?RzZLYnRNNThJcXNxblB4alpKTVM4b1ZoYjY5TjVSdzBuVVZOK2x6WFZXWm92?=
 =?utf-8?B?SksrS3krLzRNNG5HbmZCOW9yVCtzc1pWOEJValZxY00vNzZJWXZreVU2RU50?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9CF5E29EAA111469BBBEE730CCF0F92@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4770cde-7e91-4467-1c28-08dd6708017c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 17:03:43.8181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mN+fL6tcRtu1LRCN7yqDrWmf9cCdSPKTMmQphsTX1+m1qOcHhSCZYOdz7DG0eYcYrSwBq3pmVE+2WpwrLrHAWIUnp21qw7ET8+n2/Z1FfuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7765
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTAzLTE5IGF0IDA5OjQxIC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
VGhleSBfdGhlb3JldGljYWxseV8gbmVlZCBhIFdCSU5WRCBhdCBrZXhlYy4gQnV0IHRoZXJlDQo+
IG1pZ2h0IGJlIGVub3VnaCBvdGhlciB0aGluZ3MgaGFwcGVuaW5nIGR1cmluZyBrZXhlYyAoaW5j
bHVkaW5nIG90aGVyDQo+IFdCSU5WRCdzKSB0byBrZWVwIHVzIGZyb20gZ2V0dGluZyBiaXR0ZW4g
aW4gcHJhY3RpY2UuDQoNClRoYW5rcyBEYXZlLiBJdCBzZWVtcyB0aGVyZSBoYXZlIGJlZW4gYSBu
dW1iZXIgb2YgaXNzdWVzIGluIHRoaXMgc3RlcCwgc28ganVzdA0KdHJ5aW5nIHRvIG1ha2Ugc3Vy
ZSBJIHVuZGVyc3RhbmQgaG93IGl0IGlzIHN1cHBvc2VkIHRvIHdvcmsgYmVmb3JlIHdlIGNoYW5n
ZSBpdC4NCg==

