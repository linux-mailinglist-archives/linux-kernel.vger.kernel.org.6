Return-Path: <linux-kernel+bounces-299977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA9595DD2F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 11:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81901F22906
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 09:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972FC154C07;
	Sat, 24 Aug 2024 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MNsi9GaC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D5128DB3
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724491906; cv=fail; b=XH+gDkHmdTHHAW3ODdp0e8Q/rXdDACW0rK2CuPBWUFKlWDEpqgHOSRUmlytqvrUPQ0paCIhBcFRTIQLjV09n+Yz3U4OB9pmzuddU04zU6bnhV0Pz5mPir2/YSiwg/qAOb/Kzzag2A975+WmYm3AMKR44eU64aeaTa9Ql8NkdqeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724491906; c=relaxed/simple;
	bh=gDrXBRTZZLcaFIfKDt5WqVh9frwK2bxdR+Tbn3aRoWQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GkhIJaoHPNu7jm18ISjqciD691OOgOtW2lUPRr5emqi6GaLDEsM4qpepEjRAMNQNrcUnKSsJ1g2BY6ZGrQIeMtTWOloL7eOPMoMu4GlpBApcOUGti9lMBHUr5jUM7EgduKYQ10+4gQVXw6MoujSutchhIKNLMYYxuKKuv4Os0j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MNsi9GaC; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724491905; x=1756027905;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gDrXBRTZZLcaFIfKDt5WqVh9frwK2bxdR+Tbn3aRoWQ=;
  b=MNsi9GaC5/CS9iuVElJuvIUIdwtQ367WXli18WOmp5eYJ1pRkusc/XPN
   lKsk3v0mPtjGZEmwQAMT8x1WlqLbs49DOgX2m/za61TREyTSnZ4SNuK6P
   nHExJcEv5zU3L4e8ZgksLj0n4Wo6eMqGfh6KcunrjgvYZMc4i6H1gBPIk
   W39aCvsOFFeK4ztjZP0/pg2xHH3KrzOtuwHD7RT9ukYjPGq+CDwPFi+/N
   p44WiCj459yQJGtf4RLG2Ih7i6tZq0Gua4rHoci7TD6cSgU27Jv7uGfGa
   sgmq+Nf9JSUVpwMyTviuvQiTAyn9HXzBN7+Bc9ewDumy8r+fYEmeBdyFB
   w==;
X-CSE-ConnectionGUID: Q8iHptmQTtSNt1xe3meyaQ==
X-CSE-MsgGUID: BMTLQI/gQHWLPzrqm+HvMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="23152452"
X-IronPort-AV: E=Sophos;i="6.10,173,1719903600"; 
   d="scan'208";a="23152452"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 02:31:44 -0700
X-CSE-ConnectionGUID: Cc8yBI5TSqm1dYF39F9eFQ==
X-CSE-MsgGUID: NxR/vg/ES9mjkoslXv1S9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,173,1719903600"; 
   d="scan'208";a="66744224"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Aug 2024 02:31:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 24 Aug 2024 02:31:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 24 Aug 2024 02:31:21 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 24 Aug 2024 02:31:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3yyCRg+aBK4O5i/K+k+byDF8Moh8Gx31K47hRI5rPqFBeqDXvMozEbPAI/5CxtPk7Xw+kYaffZDFYgQpTQlnnyg5MQdi84J7PNZgjZDuwItrYE+lbOP+nbhxcDzjXHtyueMneu4fDvMCzgnZJ4tTif8SrlvFnAsRLKr/BJACVZ30EhEkF1S56oXi5GoeLETmQ85H6PwICPNsHCx2CvLoZY3vmise9OsbnefovvruymwkBLJpzqRQ25GuXtgh7YPb1bEiaNg0AM3J7MYkl97FadmsN25ia+i8f1PDP0T/1wo7VA+UXvBatoV5BTnj4XDn0gkPYpOcU4siXG6Ru1JkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDrXBRTZZLcaFIfKDt5WqVh9frwK2bxdR+Tbn3aRoWQ=;
 b=LrRZHkMVSt/oaYjbtGzNcLmKyNlBtgMyxCT+lcLrNKyLGlRDxkmtlUoX1s+p0JmcFuFgSrywfYglhfwnd8gSoz5MUKWoGkx3TiTGU+Ay3yUkHk4ro3Hww+SWA7Dzvhm0+rdjTeRe9m6GDWceqfz1ZTrfgrjk0o3NHYSMViyFClikRV8hTf1e1U8SWMPXZPqnz3n4gZkD6AZ+AXowx2cjFDaBs7s13/XsCTA4oBQsAwtrj6ptSGYkK2xCfe5rT2Zdvoju7xOKGNdbcdRGU2i9SWxLTjMRqEk9VdXUvqsXnk0xJa8cppnTacldYOWpL/608fJVk2ANmjeY4bosFjCLIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB6497.namprd11.prod.outlook.com (2603:10b6:510:1f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Sat, 24 Aug
 2024 09:31:19 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7897.021; Sat, 24 Aug 2024
 09:31:18 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "sagis@google.com" <sagis@google.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "luto@kernel.org"
	<luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org"
	<x86@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"seanjc@google.com" <seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] TDX host: kexec() support
Thread-Topic: [PATCH v5 0/5] TDX host: kexec() support
Thread-Index: AQHa7wyZqBebJJ2IWU+gCxNnCo4bK7IvHYkAgAAPJwCAAANdAIAABGSAgAXcvICAASF2AA==
Date: Sat, 24 Aug 2024 09:31:18 +0000
Message-ID: <47dbc3b5dd6bd7cc3fa94ffe770e22419daf1d01.camel@intel.com>
References: <cover.1723723470.git.kai.huang@intel.com>
	 <20240819212156.166703-1-sagis@google.com>
	 <29fba60b-b024-417c-86e2-d76a23aa4d6c@intel.com>
	 <CAAhR5DEEsFNqdxbd62tGh9Cj7ZQMQs6fEjAKs6djkZzgZALOfw@mail.gmail.com>
	 <f4b60d0e-bec7-45d0-bbdf-fb04362c863a@intel.com>
	 <CAAhR5DFrOaXDbndFOSWAfdu-79buSR2ki_AU=z68FcHmn9o4Ow@mail.gmail.com>
In-Reply-To: <CAAhR5DFrOaXDbndFOSWAfdu-79buSR2ki_AU=z68FcHmn9o4Ow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB6497:EE_
x-ms-office365-filtering-correlation-id: f6a2c294-73f2-4a49-56b9-08dcc41f8256
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VEU2TkNBbzFjOHM1bHAxZDZFOUdyeDFHb1NjbWRKMUlDVk9MaTRmU1JGQmVZ?=
 =?utf-8?B?VDJFL2RRUmlRZ0E0YjFrNEVCTTVxUmdsRlVGelNJWmJ0c0RDanRCOHBVOTBu?=
 =?utf-8?B?bUkzN0k4bHZ5Q3F6OUFvMGYzRUN0K3RrazVTRzVaRFFxQW5Cb3hIUXhBVCtq?=
 =?utf-8?B?a0I3QVh3NDR0U3cwUnZOejMzUVJvdVJkTFBHZ2NrbmtDakxFL003aVFJR3g2?=
 =?utf-8?B?T1dDL1UwZitpcklCUXdiVVBqeEY3bk9Fa1M1REtPdWtjdTcvaHRkTnVHSW9z?=
 =?utf-8?B?d3NMT2g4aHBKQW5BWDMySjFtb3A2ZkY2cUo4ZEtxdzFhT3lXcVRMaFB0SWw1?=
 =?utf-8?B?cktTOUxWTUpvd1NmNWpoQjdMOVZPVCtReXdadW9ROUh1K1lpQzJkTG0zL1BD?=
 =?utf-8?B?c21MOEFVa0wwL2x1bDRBNG9nOWpKRW5PQ2puSXQ4NEJMYU9wdVZabUdabU4y?=
 =?utf-8?B?QVVzUlEvSXIvL1IxMUR1Q1dCZXh2L3I2QnJGemtwNEQ1a1NaRjZUOFFkMU8x?=
 =?utf-8?B?MjhIUVV0REEwQksxMjZvM3ZXVFY4T210bTdsVTdnaHA1L2ZpMHJEcFpSV3Iz?=
 =?utf-8?B?eDY2RHk0NitXVWQ2eFRiUVBkOFp3WjFsSFMwQ3ZNSi9ObXJidFVIdlp0c3Zo?=
 =?utf-8?B?QndjbnBNSlUxb2FpQXJtdHFVNG51cldoZ1B2NHY2T0FVOEN3ZlVIZGg4ZXJB?=
 =?utf-8?B?Z0pLWUlIZGJIMzFKbHZab216SWxsa2VjN0hNSTBHemVudDl2d2NudHhoSFFp?=
 =?utf-8?B?WDVrRWpLVTF5d0xqd01zcnBnamVoZkhzYk4wMklWek91bGpkbERxbU1aQ1hR?=
 =?utf-8?B?aThxcnVHQkVZR2JYWlUwaXNuT01VREwyNzFKVDhtREk5a0ZhQWVydW5vL0xZ?=
 =?utf-8?B?ZHlYTm5UbGRQU05TM1pZdzlISGNjL2xYK1QzVGVrdkRQQUNCZTR0RjhXRWpm?=
 =?utf-8?B?WitkdDdZRmZocGxZZWlWUTdFMStHWUhock9aSFZYN01nQlIrWC9iMTVmRFZ6?=
 =?utf-8?B?eFRGY2RZck5UZjc3SGZCTUt0UW84ZmQ1NVcra2pIZC8vbm9DRkJ0a2gzOGh3?=
 =?utf-8?B?NXdnZjRTdEpGVURqclR1RnU2d3NPcFMwczB0ajhlWFhjcTFMZUdvRFJ3RmNv?=
 =?utf-8?B?TVZnWWE3bTBxemdDazg1RkJXZWhpQWZtYTQzcFFmdExKRXc0VVR2bnh2TkJ3?=
 =?utf-8?B?dk5BMXhjZE56K0ZmV0xnNWpCWEhQU05MMUJ2NncwNHZ4MHVhRFRwUXBxcGRT?=
 =?utf-8?B?NlhvQlRadzRaN1ZnY2N1SVR2RW5XU3lwd2V4V2Y0dWFXNVBmMWN4azdSRjVH?=
 =?utf-8?B?RFAwZzM0Vnd4T01VcWZ1SHAvN0lxL0pjbW1xd0JGcWY2WEhpZk93V0lnT2py?=
 =?utf-8?B?Skw0MzBGcmdEckF0WENBbVFRMjlzMmp5VVhiM0lhQWlKdEZ6cllJaDJ1cEFy?=
 =?utf-8?B?b21LekdnYUJFUytETTErRXhiVjMvWUVSb0lhdnJINFlyWCt5dUEzdlRiL1ZE?=
 =?utf-8?B?NDYxU2FNQVFRWVl5a0tnQTBJQy9abGFyZmxYdXZZU0x4MlJpMGh1SGJsOTNS?=
 =?utf-8?B?RDZTT0QzR2FZV2JVbGt6cXVoTnVKVERQYUZFU0htS2ltNkRKQmFKSmtRN2p1?=
 =?utf-8?B?d3lGN0J3N3BxaG1mdW5abEJRR2p1MDZYL1Fod1l6YWpKOGtKNEI2K1pQUkZH?=
 =?utf-8?B?QVBWR3dNeEordVlDQjQyVDlMTzVHNlk0MHRReC8xTmtuUDlmSkdoNEVhTE0w?=
 =?utf-8?B?ZU9ZQmNRZ1B0RDhvUTk0WTFIZVA2SmJvc2ZLTkthOVFWRHRoUDF3ZmdmMmNJ?=
 =?utf-8?B?ZGphRHUrMy9jMHZkcnhnVWlxT3hBVnc0RXdPRDNFK0t5SVdKWVhyWFQ1aHRz?=
 =?utf-8?B?VjdmWEsyR2Z0OFFWWGhrMDFqRVVKRllhcU1NL2dXNGlidHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3FIdXFSNXJScW9reHhqWWtoZVlMcGFhTWNtVFVQVWh1UENNeklLOElaajhW?=
 =?utf-8?B?a1dvdkdYKzMyMHNPK2czWGRFVTQrQmRMQklYVUtENjAzUVgwT1ozelFqWjM5?=
 =?utf-8?B?UzJaTTArN2h1bnl3UGpaMldqbGI5Y0lHdWNYTVhHbFU0VFcxMUd3ZGNnSG1U?=
 =?utf-8?B?ZGU2MWJDS2VvdGxUTFUycDdaS1RvYUw4UEYyVGRPTzJCWVhHNi92VEJaeWdK?=
 =?utf-8?B?d2EreTZJSWQ1YUpRczUrNXRrUkhjeWs2bTZDSVdOTUJRVlRnWElhUFFaL1lO?=
 =?utf-8?B?TWZpSllvdTVTQmNWcVQyeW1UWERQanJPS3V0OXIrRmJDQWUrUG90MU4zTzFN?=
 =?utf-8?B?a2gvam1DU29vckU3Si9jeHNqbk40ZEM1azYyeEU5c0FlQ3ZDbkNnYms1Vmw1?=
 =?utf-8?B?QU9FMndtZGRGZ3NBN2RzZmFjTEJCTnB3cFNkcUZiLzRUTitQWmlVakRZdXJP?=
 =?utf-8?B?ZW05TEMwL3V6bVV1Qmw0ZVpWRlJvaXh0Q1drWDRuN1h2U1UzNFFwQlA4UkJE?=
 =?utf-8?B?SEl4ZSswbTBxNnRkbmVsV0JJSy9XaC9OTW5qekFNZEcxamhMcmdBS0lBRzFi?=
 =?utf-8?B?cjhpaDR1dHJvU2NwcGwzSVY4SUgwT1ZMTUtwMG9CUmJoODhyN05SWnhSTjFM?=
 =?utf-8?B?dXZISVMvbmhHcG9Qc2dNRmZzcmJJVnlpV0NIeS9EeU5TR25JbTZCNFEwVFhw?=
 =?utf-8?B?RDJrRU00a1VLZUt1MEtWNlhaVklmSFlvL1Zrek51Rkc4LzhhcW4wM0t5Slk2?=
 =?utf-8?B?R1VKd0pFYjlwM1JWeVR1QlpqS3krWXdGYmpmYnduZURrc2FXc3JFL1ZDZlND?=
 =?utf-8?B?cEtMdWk2Q0N2QTk3TFdDYk00QThCaGxPUHRLZjZkVTV6VUhmeXJWT0pNS3RS?=
 =?utf-8?B?bW96MUVVSTNoYVhsUlFGbUtSOGpwd3JCZE15MWFOOXN6bFFXUnZGbElVVGlw?=
 =?utf-8?B?VUhmaDVGdUNCMno3N09IbnpsenpLRnYwMzZwc1FjM3o5SzB0VmtIYzVEUHZR?=
 =?utf-8?B?UXJMSCtlWEhsYTBlT2I0YXNHZDJwOXl6ZFpua0I3TzJ4dytIUGxDWjVpRWcx?=
 =?utf-8?B?SmZ1dThkM3gxellTNnViWDA3YkZISUFWZ1oxUjlUMmFuRlBUeTYyaE10aVp3?=
 =?utf-8?B?Zlo4QmhzT3V5WldsOXhHYmEzNlhHUnRaaGVqZWJOU2NxOUFRMUV0SXhTWktG?=
 =?utf-8?B?OVdOWDQvamhYT0hUeVhra3FvalM4L3ArQmRBdjRWT1EyMDFpbE1zZ2tneE9R?=
 =?utf-8?B?RjNlU255TWFLbUNjVHlJdWt0bXpNOElkZEh0dWcyd09UUlpuNERCOFVuZE1i?=
 =?utf-8?B?bk81S2I0Y0Z2Ky9ac1o5WWF4aSs1RkVzRFZuSGt2SkFTbU5qeU5wL1dZT2Jv?=
 =?utf-8?B?elNrN0ljRitCVHBZMm8rUUpHYWFaN3BtUFVYS0dGcmhTV2lRb2Z6UzA2RW9H?=
 =?utf-8?B?Q3g5SDFmajRBMG1LVWc3Tlc2a1NBVGpCNTVLWnpraFNCeGdKOFdmMk5FRHN6?=
 =?utf-8?B?RzQ4RktaS3FVTUY5ZTgzaG9oYW9xbEVyOXZvV1R6UFkweFNTdy9wWjVDMmVy?=
 =?utf-8?B?OEFCNEI1ejh2czIxWVRNMkZoVDBIZG9mdXpqME5iWWE2RXR0YW1zbFpCMnYz?=
 =?utf-8?B?b1dGV0tMcVNnak14NllndUhEbkxaMGtDOGJ6YXB1dzZiS09qaXJzbS80NlJL?=
 =?utf-8?B?NTg0UE84aE10eHlKcUNWeksyY3V6clE2SzJVZlNmR1UzVjZ3NVdFYjdQbFoz?=
 =?utf-8?B?bmwzRDVaUjc0VkFmN3l6bVoyVG5YWVJBNnp6RFk4d25mQmZTa01uZDlwaFV4?=
 =?utf-8?B?d0s2N1hyWFlsR2IySGNrR2h5ZmJTM1dadkV2bENIMktOcnVpZ01RV05nalRW?=
 =?utf-8?B?TWR5WjdQK1NIOXBkVmw0d2owNE11c1hhRFBtQzZOckNGRTJ4N1dvVUpFK2ZE?=
 =?utf-8?B?VXNIN3V1blc2R2xzcjZCeGt5TWRVRktaT3NKUlFxZkdyTTg3clE4RmRNamNH?=
 =?utf-8?B?ekJsZ0thaXJGRDlicGt2NlhVSHc2TXovM29LZVdjWGhoTU80QUZJZ0hvaCtL?=
 =?utf-8?B?UCtSOW9CWEhWa1ZFVFFFTnpQak9ZcGRkbHIvd08vTjVLQ2JGS3dzQmYwZTlh?=
 =?utf-8?Q?YypcFGJtcWYsUoiGRCOToq3tM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2689BEB27332104CA0A7D14EEC66E6F3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a2c294-73f2-4a49-56b9-08dcc41f8256
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2024 09:31:18.9070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SQ5Jm3meMNQzhYrahhFwOaLdmv+QRPmJSyZEIv+GSpHVPiihuT79FMMnK6MbGeputCTSaDSsBFZnm2/M44bTJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6497
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA4LTIzIGF0IDExOjE1IC0wNTAwLCBTYWdpIFNoYWhhciB3cm90ZToNCj4g
T24gTW9uLCBBdWcgMTksIDIwMjQgYXQgNTo0NOKAr1BNIEh1YW5nLCBLYWkgPGthaS5odWFuZ0Bp
bnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IA0KPiA+IA0KPiA+IE9uIDIwLzA4LzIwMjQgMTA6
MjggYW0sIFNhZ2kgU2hhaGFyIHdyb3RlOg0KPiA+ID4gT24gTW9uLCBBdWcgMTksIDIwMjQgYXQg
NToxNuKAr1BNIEh1YW5nLCBLYWkgPGthaS5odWFuZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4g
PiANCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBPbiAyMC8wOC8yMDI0IDk6MjEgYW0sIFNh
Z2kgU2hhaGFyIHdyb3RlOg0KPiA+ID4gPiA+ID4gQ3VycmVudGx5IGtleGVjKCkgc3VwcG9ydCBh
bmQgVERYIGhvc3QgYXJlIG11dHVyYWxseSBleGNsdXNpdmUgaW4gdGhlDQo+ID4gPiA+ID4gPiBL
Y29uZmlnLiAgVGhpcyBzZXJpZXMgYWRkcyB0aGUgVERYIGhvc3Qga2V4ZWMgc3VwcG9ydCBzbyB0
aGF0IHRoZXkgY2FuDQo+ID4gPiA+ID4gPiB3b3JrIHRvZ2V0aGVyIGFuZCBjYW4gYmUgZW5hYmxl
ZCBhdCB0aGUgc2FtZSB0aW1lIGluIHRoZSBLY29uZmlnLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
IEkgdHJpZWQgdGVzdGluZyB0aGUga2V4ZWMgZnVuY3Rpb25hbGl0eSBhbmQgbm90aWNlZCB0aGF0
IHRoZSBURFggbW9kdWxlDQo+ID4gPiA+ID4gZmFpbHMgaW5pdGlhbGl6YXRpb24gb24gdGhlIHNl
Y29uZCBrZXJuZWwgc28geW91IGNhbid0IGFjdHVhbGx5IGtleGVjDQo+ID4gPiA+ID4gYmV0d2Vl
biAyIGtlcm5lbHMgdGhhdCBlbmFibGUgVERYLiBJcyB0aGF0IHRoZSBleHBlY3RlZCBiZWhhdmlv
cj8gQXJlDQo+ID4gPiA+ID4gdGhlcmUgZnV0dXJlIHBhdGNoZXMgdG8gZW5hYmxlIHRoYXQgZnVu
Y3Rpb25hbGl0eT8NCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IFRoYW5rcyBmb3IgdGVz
dGluZyENCj4gPiA+ID4gDQo+ID4gPiA+IFllcyB0aGlzIGlzIHRoZSBleHBlY3RlZCBiZWhhdmlv
dXIuICBJZiB0aGUgZmlyc3Qga2VybmVsIGhhcyBlbmFibGVkDQo+ID4gPiA+IFREWCwgdGhlbiB0
aGUgc2Vjb25kIGtlcm5lbCB3aWxsIGZhaWwgdG8gaW5pdCBURFguICBUaGUgcmVhc29uIHRoZSBm
aXJzdA0KPiA+ID4gPiBTRUFNQ0FMTCB0byBpbml0aWFsaXplIFREWCBtb2R1bGUgaW4gdGhlIHNl
Y29uZCBrZXJuZWwgd2lsbCBmYWlsIGR1ZSB0bw0KPiA+ID4gPiBtb2R1bGUgaGF2aW5nIGJlZW4g
aW5pdGlhbGl6ZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBIb3dldmVyIGlmIHRoZSBmaXJzdCBrZXJu
ZWwgaGFzIG5vdCBlbmFibGVkIFREWCwgdGhlIHNlY29uZCBrZXJuZWwgaXMNCj4gPiA+ID4gYWJs
ZSB0byBlbmFibGUgaXQuDQo+ID4gPiANCj4gPiA+IEFyZSB0aGVyZSBhbnkgcGxhbnMgdG8gc3Vw
cG9ydCBib3RoIGtlcm5lbHMgYmVpbmcgYWJsZSB0byBlbmFibGUgVERYDQo+ID4gPiBpbiB0aGUg
ZnV0dXJlPyBFaXRoZXIgYnkgY2hhbmdlcyB0byBLVk0gb3IgdGhlIFREWCBtb2R1bGU/DQo+ID4g
DQo+ID4gQUZBSUNUIHdlIGhhdmVuJ3QgcmVjZWl2ZWQgc3VjaCByZXF1aXJlbWVudCBzbyBmYXIu
ICBMZXQgbWUgZG91YmxlIGNoZWNrDQo+ID4gaW50ZXJuYWxseSBhbmQgZ2V0IGJhY2sgaGVyZS4N
Cj4gPiANCj4gPiBCdHcsIGlmIHdlIHdhbnQgdG8gZG8gdGhpcyBwdXJlbHkgZnJvbSBzb2Z0d2Fy
ZSwgY2hhbmdpbmcgS1ZNIGlzbid0IHRoZQ0KPiA+IHJpZ2h0IHRoaW5nIHRvIGRvLiAgV2UgbmVl
ZCB0byBzb21laG93IHBhc3Mga2V5IGRhdGEgc3RydWN0dXJlcyBtYW5hZ2luZw0KPiA+IFREWCBt
b2R1bGUgdG8gdGhlIHNlY29uZCBrZXJuZWwsIGUuZy4sIG1vZHVsZSBzdGF0dXMsIGxvY2F0aW9u
cyBvZg0KPiA+IFBBTVRzLiAgQW5kIHRoZSBzZWNvbmQga2VybmVsIG5lZWRzIHRvIGJlIG1vZGlm
aWVkIHRvIHVuZGVyc3RhbmQgdGhvc2UsDQo+ID4gd2hpY2ggbWVhbnMgc29tZSBvbGQgKHNlY29u
ZCkga2VybmVscyB3aXRoIFREWCBzdXBwb3J0IG1heSBub3QgYmUgYWJsZQ0KPiA+IHRvIHN1cHBv
cnQgdGhpcyBldmVuIGlmIHdlIGFkZCB0aGlzIHRvIHRoZSBrZXJuZWwuDQo+IA0KPiBXb3VsZCBp
dCBiZSBwb3NzaWJsZSB0byB0ZWFyIGRvd24gdGhlIHRkeCBtb2R1bGUgYW5kIHJlLWluaXRpYWxp
emUgaXQNCj4gb24gdGhlIG5leHQga2VybmVsPyBJIGRvbid0IHRoaW5rIHRoZXJlJ3MgYSByZXF1
aXJlbWVudCBmb3IgdGhlIHRkeA0KPiBtb2R1bGUgZGF0YSBzdHJ1Y3R1cmVzIHRvIHJlbWFpbiBp
bnRhY3QgZHVyaW5nIGtleGVjIGJ1dCBpdCBjb3VsZCBiZQ0KPiB1c2VmdWwgaWYgdGR4IGNhbiBi
ZSBlbmFibGVkIG9uIHRoZSBuZXcga2VybmVsLg0KDQpXZSBkaXNjdXNzZWQgdGhpcyBpbnRlcm5h
bGx5LiAgVGhlIFREWCBtb2R1bGUgY2Fubm90IGJlIHJlLWluaXRpYWxpemVkIGFmdGVyDQp0b3Ju
IGRvd24uICBIb3dldmVyIHRoZSBuZXcga2VybmVsIGNhbiByZWxvYWQgdGhlIChzYW1lKSBURFgg
bW9kdWxlIGFuZCByZS0NCmluaXRpYWxpemUgaXQgKHRoZSBQLVNFQU1MRFIgc3VwcG9ydHMgcmVs
b2FkIG9yIHJ1bnRpbWUgdXBkYXRlIFREWCBtb2R1bGUpLg0KDQpIb3dldmVyIG91ciBwcmltYXJ5
IGZvY3VzIGlzIHRvIGVuYWJsZSBiYXNlbGluZSBURFggc3VwcG9ydCBpbiB1cHN0cmVhbS4gIEZv
cg0KVERYIGhvc3Qga2V4ZWMsIGF0IHRoaXMgc3RhZ2Ugd2UgZm9jdXMgb246IDEpIGVuYWJsZSBi
b3RoIFREWCBhbmQgS2V4ZWMgaW4gdGhlDQpLY29uZmlnOyAyKSBhbGxvdyBub3JtYWwga2V4ZWMg
YW5kIGtkdW1wIHRvIHdvcmsgd2hlbiBURFggaXMgZW5hYmxlZC4gIE1ha2luZw0KdGhlIHNlY29u
ZCBrZXJuZWwgYmUgYWJsZSB0byB1c2UgVERYIGlzIG5leHQtc3RlcCBwbGFuLg0KDQpNYXkgSSBh
c2sgaXMgdGhlcmUgYW55IHJlYWwgdXNlIGNhc2UgdGhhdCByZXF1aXJlcyB0aGUgc2Vjb25kIGtl
cm5lbCB0byBiZQ0KYWJsZSB0byB1c2UgVERYIGF0IHRoaXMgc3RhZ2U/DQo=

