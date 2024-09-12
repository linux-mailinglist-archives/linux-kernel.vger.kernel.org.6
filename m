Return-Path: <linux-kernel+bounces-326339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382BB9766C0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02E1281240
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0851A0BD6;
	Thu, 12 Sep 2024 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gbwXSkvL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7435519F409
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726137526; cv=fail; b=sK29p2dVGqEWoomn09GToXcg1WrwKrngCI/2S+k/B+lT0hjpbudQfh0ScxRpO+Qmkb1p3w2rrn0MXxFR+T0MnmRfbxx2pboVFDsvYtkcGRB1Rr7NLdNmX7gtWH9kKMvFlEnKyuW/Se7dR3+f9o87HPUYK5G8ISCxMCfR7bZbx24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726137526; c=relaxed/simple;
	bh=idpNa+dUdQ05MZ2RwiHmBt8vucnxUMSIvXfERco9F14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DIl64jC7E7cl0ug98Rb/8mKzXcMVxuyROGTO2DensfQY2kM7Ibs6Y0BC2V3d8CzHVL5923wykCOSKfY0ZA3PtclC06RevgTcBF7YavQd2zV7SOXfwxlfW7Cf2mbGS0mzjZ7MGiwfqpJZqhYaeqZcTusfES0Ft7MGVZ3zCWt0ELQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gbwXSkvL; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726137524; x=1757673524;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=idpNa+dUdQ05MZ2RwiHmBt8vucnxUMSIvXfERco9F14=;
  b=gbwXSkvLF9fN9H0RM63an85oHMjaEvXsnNiZNRLK3odjbJMXSRJozsMr
   PU47Iw8Om/UIrMDh1dxx0C+z6fpSX888ClfcESHpOykIj9yVrqurgaAO9
   iDZ5akQnXPIuKhpKZTtGjOyrvattEnFkvb6htGv+nRfwJcuLUFIRAXK7l
   Z5S4ZCMlge/rln0H4MIocuI+LEZ0aATQW85IYTf3MkOnB4UplWmzboh0t
   Gw1QPUewTZG2tOlSZs53mgit3DtIfMpp39KCGXVw+Nd9uCvLXyADgMzUf
   yWQ8H9VH9MDGTxxYg9vrtzunkd8fqnziVjUJ4cE8Cc0lqTOluSf53bzru
   A==;
X-CSE-ConnectionGUID: PiM/aCfUSPKBZSidMcWqCA==
X-CSE-MsgGUID: 8ZA453+eQgiwJQVhDSOlHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24804063"
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="24804063"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 03:38:44 -0700
X-CSE-ConnectionGUID: oq1ot/VHSgqys/OaAijM/w==
X-CSE-MsgGUID: WIS9u83cTP+/vNURxKy6Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="72661748"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 03:38:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 03:38:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 03:38:43 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 03:38:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Khntu/TpG4tusu8tg1upHPlJ7zuAad8EPtD5vDgCWeS4gknRJ4Ax3Zlz8DHDE4hSGnOzU+XezRK/FqHImVHAuSIzSGxZpLSBA6DC893fDKpiFMle0X0ZylGXnxS3DSnNZbon9Z6TaTfpSvsU4qZRr+mJuqcKvCGlcu+ZukfUCLavMs/xZ/ELeooRTsh32WMxxDGeXpOIO++2Kkz8ccP95PEwu89RUyXSq0mt2lvzJ/xNY0uhwIYJSERBC37gOBI9fgDkkYaesO3/wADOzpd6EdmBaFYYipUY++KWW98PgM2kkKyCxJ+i4TMvhf3z6iU74v7C+dmBDggeSBWwGWAcWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idpNa+dUdQ05MZ2RwiHmBt8vucnxUMSIvXfERco9F14=;
 b=veKK/l1la1EzSIwqV2qfw9qY26Zv/hmhal40DLW7naIQBQ6KUduPP5WmISTYkfioGzFMQa6hYOIOvuIi3dx4saqmmj0J2GE/ZncvwagUfqE8GYhjX14K+i3tPtByr0kfzI1I9EyaatOLzK2qCAv/qq5rAQ4Gw/P2EAsd3ejyHzFyC4eZZEPlLjzJX6ubLyQcS+c89+i94s1HYBeEur1p+uU3UzIA17YSTkCkbhE4Dewsi2ePt9nKWB404x/JWUxGQco62iHBK2vqxdn4jdNPqboO2GMDbELbtAapQo4i517cPD+Bt0pLXnyLH5f7n5JVXJp4cYcR9sLVJ4BwvCqnnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB8708.namprd11.prod.outlook.com (2603:10b6:610:1be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 10:38:41 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 10:38:40 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Kaplan, David" <David.Kaplan@amd.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>, "dyoung@redhat.com"
	<dyoung@redhat.com>, "sagis@google.com" <sagis@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Williams, Dan
 J" <dan.j.williams@intel.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Kalra, Ashish"
	<Ashish.Kalra@amd.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>
Subject: RE: [PATCH v6 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
Thread-Topic: [PATCH v6 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
Thread-Index: AQHbAo6uh3R3WmWEjEq9f90lZT2RcrJPeu8AgADWEACAAAEPgIAAdzWAgAKmiYCAAIq3QA==
Date: Thu, 12 Sep 2024 10:38:40 +0000
Message-ID: <BL1PR11MB5978255591A6AE65D617DC5EF7642@BL1PR11MB5978.namprd11.prod.outlook.com>
References: <cover.1725868065.git.kai.huang@intel.com>
	 <79f0de36a2a4f33e6cea8f0bf6419a6dc09ba94c.1725868065.git.kai.huang@intel.com>
	 <LV3PR12MB9265B4512DE5F2D580DE3CF794992@LV3PR12MB9265.namprd12.prod.outlook.com>
	 <3f419ba5-7b95-45f0-adb3-d7397949c14e@intel.com>
	 <LV3PR12MB9265900A6564C22E9F6666ED949A2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <8b9ddac38a612a7ecee7511c657ba0bf84660d3b.camel@intel.com>
 <LV3PR12MB92651EFF193770C82CDCD36094642@LV3PR12MB9265.namprd12.prod.outlook.com>
In-Reply-To: <LV3PR12MB92651EFF193770C82CDCD36094642@LV3PR12MB9265.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=21508881-f956-4f2a-bedb-bd8d1576aee9;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-12T02:19:52Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH3PR11MB8708:EE_
x-ms-office365-filtering-correlation-id: 822b48db-acf6-48d1-ac76-08dcd3171151
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?dW9XTUlqelliYWpaVVU3aXY2U0Z3U01sa04xTHY4d2tQV0VHSjdFa2tYTEVP?=
 =?utf-8?B?NTllclBTRmVSaS90bnJwaTE2Q2g4c002aXk5SE9sTTE3ZFZGczc5RVNjejd1?=
 =?utf-8?B?RnJNU3RvcHp2TmgrOWI1dFBSVExtZXJ5M2p1bjV5Z3Rsb1hiTGNvMmhBSnkz?=
 =?utf-8?B?b0hIRkJIdlVCUkRiYmoyaEtUS1JqNkhwcWp5b3ZweitIeGp5NU1BVEUvcGJl?=
 =?utf-8?B?NURsWUZpV2dZdmsvTXZTZHpWb1dTRldNSElyNmJEemtPazRCMXNobzhxK1lI?=
 =?utf-8?B?QjVidVFLMjNrdmY5NU8zZi9NOWRKMWhzN3V1WjloSy8xck8vTW5DWDN6aVJZ?=
 =?utf-8?B?WWEreEN1SUlzVkhYeXFWRzZmWFAra3M1dnB0YVpaNjJIQlJ2Rzg2UjJGZDV6?=
 =?utf-8?B?T1EycVZVV1JmY0U4MnptV3VjYmNQT25WQmtWWTc2cFVnUEJLcU15SFFoZHBT?=
 =?utf-8?B?NEd4U3gyYUlKazBhZzIyb09XZUp1cnplY0l6Qis5dDhDeTQzMzB0dUN4bVVk?=
 =?utf-8?B?KzJyelFkVGRVSVk5TjJXMStiMjh0aEIwa2ZqVUZrOU83VVl4bFlUQks2MUhV?=
 =?utf-8?B?UGRhTnNpeExsYXVVQ2xDMVMrQkV1WG94VGkrVjhTcFUrS01NVUZtTHpTa1Vy?=
 =?utf-8?B?UkdyT3dTTm5md1JNNk5Sdnd4eFJZc05ES201SWdrRklFeVp3RGZyQUxvVGJD?=
 =?utf-8?B?c09nSXZuSVNvZnl0QXhlbG9TU0RIK2t3M28wQUNCYU1WUVNXUHJneUdjWm85?=
 =?utf-8?B?QkQzRFVUZVJjK0tVdWpSUHZCNE8raUZJSzcvVzNNMVBVRnRkZFlGNHFQbThH?=
 =?utf-8?B?Y3Yxd3QvaUNQeHhCWGF2aGdpMGZZSCtYVEVEbWJONGRsQkVmck5WSmk0YnU0?=
 =?utf-8?B?N0NSN1loSU83aFlGaDh2YW12Q3dpWTEvekNGaFNwcE1yZEN0K1dMNlBkSy9D?=
 =?utf-8?B?ZjJKbHY4V0U1MWhkbVBsVXpSMTJ3ak1QRStXY3V1UnFkRjMraGZBZzFxQkhF?=
 =?utf-8?B?eVgvMDNnRnZGT0hQOVV1YU9tdlpzY2NrT3YxNUR3N3R0RTVWcElpTXEyWVMv?=
 =?utf-8?B?bXl1b29TSUt1UEc1b3NISEJrejA0cGk3ZmhkemtUNUlLblVoRlk4bjlwWDVo?=
 =?utf-8?B?R0FQb1luYjlobFdCM1FZcW96RUt4QWFXRVpCWmt1QmlpMVFyRlpzcEVhSXZH?=
 =?utf-8?B?RVdhNUtBR0hvTUNXYk9aekU0V3ZHb3gyQUhxZHhRT2ZnaUZJZmhKN01weFJa?=
 =?utf-8?B?Yk1waUtoWDZ4K2R4U09MVXFqVSt3bEpaSXdyQlBZblZBaVh2djZkMXZRbXRh?=
 =?utf-8?B?cE5tdDFBOThaRWJiU1J2TjV2RDhOTjcyZmQ1S09zVW1pMG5rQVJOMWhGR040?=
 =?utf-8?B?NFFrY0ZWcWdGU2hLd3NzZFo5ZHVvRnRBbWsvbG5tZ3d4VFhFU2N6K2syVUR6?=
 =?utf-8?B?anFKWit4VG5NUjdVQ001SXplTjNTeVJmUlhHVjNiUkZPYnJKRWhtUmdkNkJ2?=
 =?utf-8?B?VG9XaXJOK3RMMmt0aVp3V2FreVFvRERjNTVES0RUSm16cjR1ZklvOEZLaW5N?=
 =?utf-8?B?OGVIcFVHQTlqS0h6WkRwalg1bm1LaWIyNEJRWEFTM1d1RTdoM1c1ZkZaZTZp?=
 =?utf-8?B?QUdIbEtsMmZIYXAycWcxV3dVQXExcjhFMWUxbGFIZUpMY0hta0h0ekpwOHdJ?=
 =?utf-8?B?SXAyRUJjeG1BT29Ta0JKQkdjN3YzOVJNQXFWRUtqWWdjWGhwNjhqMEZwSnhZ?=
 =?utf-8?B?SlF2L2tZeG9mQXZSbkpRZGxUN0ZpcEZXcWxtd1krQ2cyS1o5RURQL1U0cHJT?=
 =?utf-8?B?SWhYN01yRmRtTTJoOTYrZUErWUluU1ZzdmdwOFVmdFdlSWF4WW5ndHZtYU0x?=
 =?utf-8?B?ZTNrOUsyK09Td3pXbDB1dnZYTTQwaDZxblJXYmdER1NTSzFmV2gyTnl2ekRa?=
 =?utf-8?Q?td/FVEeWY98=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3ZhODVxUExHbmhwYUo4SW9LeUpsRlI4Tk92ZkZtSmdHdlJzNXZmL2tZcloz?=
 =?utf-8?B?RkVEWFNVb3VrcVBVb1h0eXp2STlrejBZbkE5NFhYNUZXZ2ErOHlRbzNoMTRJ?=
 =?utf-8?B?RWpaV1lFUEtwM0pXTTJSUTlNRDArc3Y4Zk9BSHpVTmZOVXRPZDZMSmE0Rm1t?=
 =?utf-8?B?OEFGcjg3R3ROQWJZZHdNR3d6akVGTmZBSE01ZDMwQWxMbWhRTDJDYkc5OVVr?=
 =?utf-8?B?ZUhIbXlsS0h3V3dCdDMxc0MxWHlGV2o3L09GL0JKcXRFM2g2aFF4ejRhRndY?=
 =?utf-8?B?TVlBQ1FCL3VoRk1NOUFNb3NBUUhwN2EveWZSay82R3Z6QnZ0TlVRcS9mcktv?=
 =?utf-8?B?L3IrZzdlYVFRNnhSRTRwMkFPcE0yVkdVeEhKUjFnaFZMWFdXZmd1SkREalJJ?=
 =?utf-8?B?cTI3dzNydVpqTzVMTVlQMHlkR1ZrY1U1U3o1YWRTOFVMeHJiVUQveXlBbHVI?=
 =?utf-8?B?L1krWU1pMVh6VTF3K1FvbkV6RzIrWHZlVnhBNG5XaTBQdXZ6d2czdDNqaE9p?=
 =?utf-8?B?WVdVc3pMclFkbG9ZOVhiMkNGUWIzUThER20wWXFYTTYzYURCalZlWS9Hb0lW?=
 =?utf-8?B?MTI0emRNcjlxVk1GaHRBdExyaWZjUk9vd1YvYjB1d1NTYS96YWUzZWZtVllI?=
 =?utf-8?B?ZWN4M2V2YmlrNG1CQUl3UjR3eFlsVmhkczRVN2JiL0E4MkhiMFBqd2hCYnVu?=
 =?utf-8?B?TVBRK0xLeFArWWg0OE9EV2MzSmVmMUtIc09salNucFF0VlNtUDB5U3p5RG1Z?=
 =?utf-8?B?Ny9LL3JwY1plN3YvVFZLalM1Q0V0UUlNTUpXWDU4Qk9wN1p5UVNNOU5Sdm5L?=
 =?utf-8?B?Z0FFOHMwNysyYVc4di9aaEZnK1ExUWZwTWV1TGRwWnNBaHVnU3BCOUZlT3gr?=
 =?utf-8?B?a3ExM3R6OUFKdGYzZkxqK2t1K0o3TGxvejNpVTA4RjZQb3l3U1crUk9UdzR0?=
 =?utf-8?B?OHNvcENRZjl5MjZGOXN4aFQ5UzVlMGptRTh6WXcyS2hYbEZNTUNNK0I5cE1P?=
 =?utf-8?B?MzlSekFoZ1A1Sis5dVpGUlEvMmQwVVA2enVoSTdLZCt6OVg0RmJGdG1rTFhr?=
 =?utf-8?B?dThOQzI5bWNFVW5NeldLcjVZYkJBakY5d2tUTDAzcEk3Q3RwUXIzY3I4KzJs?=
 =?utf-8?B?eFUrNE9KYy90T2RBbTg5b1RHUnM3L0dUWWdEMENMWGg2eWpaVkRJQ1VmUWpV?=
 =?utf-8?B?dXZDb2xWYnZKb3RUUEdqcnk1SDhodm01NnAwY3drbDBOVmhTaDU2Sldnci9n?=
 =?utf-8?B?V3lLVzlNUTlLK0huSHYyZHE3MWlFTENtR0RRSWt6VkluUjljdmxIa0IzY0Fq?=
 =?utf-8?B?NVZYY0NBUVIybDFrUmc1cGpKblY0ektudTdqeEJGb2tUZ216enErWTdSWWlq?=
 =?utf-8?B?N3psQTNGNzEwWFlTNjEwU1Zmb2M1eDZuZENBOGpXclBoMFBWNE9aY0FQM1JS?=
 =?utf-8?B?RjdxSkRFT2NMUHpHTVdaUkM0TFMxZmVtMkFBbXdXYjZpZ0tCbWFsaFVTSFdH?=
 =?utf-8?B?ZTFrLzM1ZCtiNkl6eUxteEJma0s4TzFyQ0Qxd3VacFd4RncrMDlqblorUy96?=
 =?utf-8?B?aDlLeDJ2TkQrSVEvamdWZUdZOHBUTUxDYzJ6Z1VPMnJUR29hV2loM2FTTWpE?=
 =?utf-8?B?K3I5c2piVnE0Z2J2ZGNQeExxRnFrRUV6L0JkSlQ4d2oyV1VKUTVsWGd6WXA4?=
 =?utf-8?B?NTNqWFRwcUhHTE1tVXdBdnRtNUpNQlhIb1h4dGpYdHBSb0pPdEhvdEdvSzlY?=
 =?utf-8?B?dmUrdkJNTGkvN1JPS3NJT1Q2YmRxeW5NZkErSXkxZXl2Nm1lQjMxbDdBd1VB?=
 =?utf-8?B?UW9OclkzTGYrc3ZJeEZTMHlFRytlZ05ZZWtaMUw0QmR1UjJPYmJ1b3hVVC9W?=
 =?utf-8?B?N1lTRlZwczFlMjBxdmRpVGJ6NlU2ZEhScWo4OERkZHloMmtVb2xseWlGcmpX?=
 =?utf-8?B?NVVzeTBveWxuR2JSUk1LMGNtL2JXWHZEY1lGNWV1Q21YeE1CcTV6MUN3SUNh?=
 =?utf-8?B?OHYzM0NlRUZ1dVZxc3BNbU50T2dEVlNtdnBNdFRtaVl3YmNLcCtxY3lsazBk?=
 =?utf-8?B?WGxoWFhBRnJ1eEpvTjBad05nZHVFRXUzbEFZRUJRMVVoQVRkVUsvWmJiNDhz?=
 =?utf-8?Q?2nvw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822b48db-acf6-48d1-ac76-08dcd3171151
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 10:38:40.7680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+KK7ChdfLiV2yu/vDvqPYI68Kt94qIvIYaxo7k75aSwN7OfC+JkIXa17d4KKX82+Oyue5SgfRhGqjgQxntNLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8708
X-OriginatorOrg: intel.com

PiA+IEhvdyBhYm91dCBiZWxvdz8NCj4gPg0KPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9tYWNo
aW5lX2tleGVjXzY0LmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182
NC5jDQo+ID4gQEAgLTM1MSw2ICszNTEsMTEgQEAgdm9pZCBtYWNoaW5lX2tleGVjKHN0cnVjdCBr
aW1hZ2UgKmltYWdlKQ0KPiA+ICAgICAgICAgICoNCj4gPiAgICAgICAgICAqIEkgdGFrZSBhZHZh
bnRhZ2Ugb2YgdGhpcyBoZXJlIGJ5IGZvcmNlIGxvYWRpbmcgdGhlDQo+ID4gICAgICAgICAgKiBz
ZWdtZW50cywgYmVmb3JlIEkgemFwIHRoZSBnZHQgd2l0aCBhbiBpbnZhbGlkIHZhbHVlLg0KPiA+
ICsgICAgICAgICoNCj4gPiArICAgICAgICAqIE5vdGUgdGhpcyByZXNldHMgR1MgdG8gMC4gIERv
bid0IG1ha2UgYW55IGZ1bmN0aW9uIGNhbGwgYWZ0ZXINCj4gPiArICAgICAgICAqIGhlcmUgc2lu
Y2UgY2FsbCBkZXB0aCB0cmFja2luZyB1c2VzIHBlci1jcHUgdmFyaWFibGVzIHRvDQo+ID4gKyAg
ICAgICAgKiBvcGVyYXRlIChyZWxvY2F0ZV9rZXJuZWwgaXMgZXhwbGljaXRseSBpZ25vcmVkIGJ5
IGNhbGwgZGVwdGgNCj4gPiArICAgICAgICAqIHRyYWNraW5nKS4NCj4gPiAgICAgICAgICAqLw0K
PiANCj4gTG9va3MgZ29vZCwgdGhhbmtzIQ0KPiANCj4gPg0KPiA+IEJ0dywgaXQgd291bGQgYmUg
dmVyeSBoZWxwZnVsIGlmIHlvdSBjYW4gaGVscCB0byB2ZXJpZnkgdGhpcyBwYXRjaA0KPiA+IGRv
ZXNuJ3QgYnJlYWsgY2FsbCBkZXB0aCB0cmFja2luZyBpbiB5b3VyIGVudmlyb25tZW50LiAgVGhh
bmtzIQ0KPiANCj4gVGVzdGVkIGl0IGFuZCBpdCBzZWVtZWQgZmluZSAoa2V4ZWMgd29ya2VkIGFu
ZCBkaXNhc3NlbWJseSBkaWQgbm90IHNob3cgYW55DQo+IGNhbGxzIGFmdGVyIEdTIGlzIGNsZWFy
ZWQsIGFzIGV4cGVjdGVkKS4NCj4gDQoNClRoYW5rcyEgIFNob3VsZCBJIGFkZCB5b3VyIFRlc3Rl
ZC1ieT8NCg==

