Return-Path: <linux-kernel+bounces-565114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB33A66122
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1FE178274
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01511F9F7C;
	Mon, 17 Mar 2025 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NqItZziX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B34F1F584C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742248813; cv=fail; b=lpSOU/Q760r8bn+LYTLS3+ahjMem3rPveNqU9lf23Vyj2XJ1HcJhc560zRuJeV6DC4shOEpQxtJTTE2s84mroBzYw90q1KysXlLmLkyKAvh6vS6iIXsvSWc414ryaivdoicLklZZyRWZ5/BpjEZjYCniXFTPcWF6rreSq3c8u3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742248813; c=relaxed/simple;
	bh=bx6bFA6zJI4rYSREXsTd9fll0c9gB9ry+UBy8/EFuyM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LuM0o54BjULSxSxEUthEn5h6cB/nb7KfCKEdkAvJv6bTDeb5OY2aQHAISPs+7Ku6GVTzn1syRsUWPUbCsfmJJDl/ubUJ9q7fEZCDA9SqdHu1yAu1Gk99e2sKsplLGWuUq+3xST5psEA2dwX/w4+oIDQFMWsc54x0xNC1Sp5ejcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NqItZziX; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742248811; x=1773784811;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bx6bFA6zJI4rYSREXsTd9fll0c9gB9ry+UBy8/EFuyM=;
  b=NqItZziXFU3h5c8bWCQrOMPjvI7AUfdoOvsV1P2IC1kE8xnWu6Ql51gE
   ESEnMCeXplz+3iEjJtx8I0SLKBKXcy/ZV5qA72tkpl1IzLSWrdQg+TGEX
   3BBLsX4aG5QJlwfiRY6Oak92eh4XOoSCDQwFOsJj7ThTZraGNyJ5jCjV2
   KgWEgTpAywCKu+aGbKAMx2Vga5huyx4AHT0Vvuq67JnnNtvZNwEMcPPfA
   uEkAa/zduAKebZEbaHPwpoIFZd+Ey/V7FCmMa6zfbzowcHaQQj2h4iyVK
   ah7kLRA3uaffncuZTDqENsdGFJjipEoOEDrFsNttjLxkFEG4E6lXKYQB0
   w==;
X-CSE-ConnectionGUID: VTqLYTuDQ22pXdCsQtxnfw==
X-CSE-MsgGUID: sf1YefzTS0K2SK1rGYB5Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54753823"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="54753823"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 15:00:09 -0700
X-CSE-ConnectionGUID: Q7ObyI/wQp6WegYbOJgrTg==
X-CSE-MsgGUID: Z3fE7rQVSKGM5/M+NPgsew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="126260800"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Mar 2025 15:00:08 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Mar 2025 15:00:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 17 Mar 2025 15:00:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 15:00:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwVBqL1QjoNcj5z0JZf3Mr4u4Z9h5cUMM8jCwc7fsSO7o0zhFZEVsu5w7wOBldZH4hqOzgXbdk6Bd9UTFHLLoWeWpqBE8FhhfStC4C6bWVQBhon4JgwTX2TGytD6ntrz0F6tWSqmmkSFIt8VVWytEHI9XlB7tt7F8WHK5uWtZXVdsx+wSZJbbOresQ42KN+dyL4yAGlFOoN04jlyNApihNbHHzZdXch1JP6YZUd48Da0ZRh9PfLptwlfbjhhdpn/uWignlASfYEUAA6mLfo7/TC9gPFf0SrWN+DS55xm9d6dImVU8yWHcFY83bHUzhiM6BAZUw2vRgzjX5BQbm2+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bx6bFA6zJI4rYSREXsTd9fll0c9gB9ry+UBy8/EFuyM=;
 b=sFP6UCnYnpN1yL0gzGhlKuQPFDW5KxEF/Y3H7q95zt50hr9Jn/4cZoYr2B6EUJhwLlhf0yE03HZ946tUHvwMba5xEkkSKp3dx2pCw7VYU9BJwbz1oLUz02auIfDV6hef7YukemrirEA+CuVj3p1mLdq7Z3URccTtXhAwDM+hC/3DR9cn6yjjWKZ1EFine8OsWiZwg5rkXV9TYf+IwZZZJ08cBzs34yrzZ4IHBYWzbtNE3ZYOufSFIDgmIy/atF/KGsO/22TwiFQjgJq+8rE9aZ1eGXxjUD7DBURdqk1nXlAOeFvjz0ATt65+ISSrHniW6jbR/kuz1wYdT+52Dd159w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA2PR11MB5081.namprd11.prod.outlook.com (2603:10b6:806:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Mon, 17 Mar
 2025 21:59:51 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 21:59:50 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "Huang, Kai" <kai.huang@intel.com>, "ashish.kalra@amd.com"
	<ashish.kalra@amd.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"dyoung@redhat.com" <dyoung@redhat.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "bhe@redhat.com"
	<bhe@redhat.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "sagis@google.com" <sagis@google.com>, "bp@alien8.de"
	<bp@alien8.de>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "x86@kernel.org"
	<x86@kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for bare-metal
 in stop_this_cpu()
Thread-Topic: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for
 bare-metal in stop_this_cpu()
Thread-Index: AQHbk0LE9xNDz/BUxUyAtvW7JgE+xLNxaCeAgAXoTYCAAJjQAA==
Date: Mon, 17 Mar 2025 21:59:50 +0000
Message-ID: <c7cec9118a23220986c1894f18cafb3aa5b9fc1f.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
	 <e9ee3c7ffc3ba6feb97247faa40789684e39ffd0.1741778537.git.kai.huang@intel.com>
	 <e0d9a3d599025c92fce5e159e8acc1af32844912.camel@intel.com>
	 <gbxpvgmmzf354g3gccflrv5shtaque4rd3uklrgltlbnedip7y@hhwvyhxh46nk>
In-Reply-To: <gbxpvgmmzf354g3gccflrv5shtaque4rd3uklrgltlbnedip7y@hhwvyhxh46nk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA2PR11MB5081:EE_
x-ms-office365-filtering-correlation-id: be22c686-6975-4feb-52e6-08dd659f0aa8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dlJYYUVhYVBRWFY3TW10clJVR0MySU15azlZemFsZ2ExQXNZeFhnWHFud25z?=
 =?utf-8?B?VXFudzBFSTJkUzg1cjhVK1lpblZUbnVrUjBoSFVESS9UTVpWV216bVBrVVAy?=
 =?utf-8?B?SXJ6NGY5T1YwZVhPR2NkTFgwSXJTcHpOU3ZyVE16anVGdUs2anpXTDJteWxj?=
 =?utf-8?B?MS9aS3JzTGZhVDA0c0tJbXhSZEJGMzRnNTJUOFRRVlBkUEV1Y0EvOUluUTdn?=
 =?utf-8?B?SjJxUjJFenFvTHhUVWJ2U0o2dHdoV1c0d2dkNTZGRHBrd3ZRdjB0bnZWK1Ri?=
 =?utf-8?B?SDAzZnprV2prb1R4ekk4OXdZNDB5eUQ1V1hHT29pdENyb2ZORm9VWXdveUxh?=
 =?utf-8?B?U2V6a0tYNGZEK2VGOXpYVHJ5Z1NhZVFGckZ6a0ZBTHBsbkk2dDVtR1RIMzNn?=
 =?utf-8?B?Qy9IWEpKWUZaNHBqRktxbTBhb05nc0NYY0prazZEM1dRRmZWTVV4eXZKalhW?=
 =?utf-8?B?dkRTOHJsNkxvdEhHeEI3QUFpT01JNGpycG9GKzZPYzdCSUhYWUM2Q29xOVNO?=
 =?utf-8?B?cFFPcVBIU24xTWUxeWx2THJ6QTBJUURyMVM5K1NSSlZFc1B4K3lYQWxValFt?=
 =?utf-8?B?ZnFraGpFczYxV3FVcjRjQk4vdXNPYk92TkIyTFlsRU03dGQyOVF2ZlNSQUZP?=
 =?utf-8?B?cDF2ejdid1dCcWZ1bFB4QzdxVHY3QjZ3YzJzN3JBVUVvYTFVUHpxb0cyemFk?=
 =?utf-8?B?VHcxYm1UVUNMRVV3YnpTQ0l3NDdSRXpiQVRZT2tidWl6MHZnT1RLRURHWjRO?=
 =?utf-8?B?VDBoNTJOTE9tWTNBcHAySWoxUDNZTlFra3poZEVkNFN5b05Uc0FwSzJwWTJw?=
 =?utf-8?B?RTBvV1FvZkpMM3gyY08yRmJKN2R0UXNyVG5WVGFkTkg0dGRFd3BEcStRS3dL?=
 =?utf-8?B?cUNFRDRMRElSTjNGN1lpMFRVNzA0dXJNY0JJTWppaG90RythcmVycVpydmgx?=
 =?utf-8?B?aTJ2Mm9xY0MzNUxHTjVRVTBaN2F1Nlgvckw1amNaNFo1aXRIWlNZRHd1dWZI?=
 =?utf-8?B?cUswUnB2NzR3SXpaRWhDaUh4S3JhdG1LR3FCMjMxVkNlb1NQVXlZM0k3ZWF2?=
 =?utf-8?B?RGUyc1VnckJqQXFtek9BK2hTd3k2U05mN3Rqam9CZUxBUmpQcDNpQVdSV2sw?=
 =?utf-8?B?eXppUVlJL0JEM2ZEZWVlMm56RTcrSVlYVHZTcWlZRDVGZkZEMzZFOFFvdi9x?=
 =?utf-8?B?WXg2dHFkN2tmWThBTXFNSGpmc2cwNTloK2JwUm5DK1BhYU5Vc0VmMG9jQjl3?=
 =?utf-8?B?K1V5L20rWGRsZ2I2dkR0THlVc25xY1pPTGNwVFFsV0FEcnFaUG5DWTB4NElN?=
 =?utf-8?B?K1hHOE1oNWRHZlpsU1p4alo3SUN0L1hGalZlYThYSHVtaFNvZmJ3Tm9ScE5q?=
 =?utf-8?B?dVFXRjN0Q2EzLy9saGRUZmFvQVA3RUFMMm9LU1ZhVDR0SVZNZ0VkSFA5RjMw?=
 =?utf-8?B?MExZbHZvOERiZ2V1dWxxUWJmeUFmR2IvNTQ3NGF5T2Ivejk4ZXgrUlZMeGNs?=
 =?utf-8?B?Vlg1SFhUSTlPaHhUdGk3UGNzRTJ4a2NmRVlHV1lOQmVGL3diUUpsS2tXSWdn?=
 =?utf-8?B?Z3c1bTBrajlEYlFXVXE2N0tweGFJSGo2dmQ1NlNCSG11SU15aHErSFYyd0xG?=
 =?utf-8?B?a1BSMnQzbWNwZnhtZG9WWXRLK0hjdktBUldsa25welBUVERscjRNb1g1aVEv?=
 =?utf-8?B?MXZ6ejgveHRZOFN0elZucXlVWmt3RC9LS20xcHN4a2tnOTRScmlBdXAzcW9K?=
 =?utf-8?B?bkRvdlZSWTlZdmF4WlRHWTJFQ254V1dKQjFRaXNtRHlwV3VUY2c2ODZaMGpS?=
 =?utf-8?B?UWhiOUpTV0RsMXA1Sk05d1BybzQyOENESnlBeDF6WUtjWjViQnBwTDY2RGoy?=
 =?utf-8?B?d0o3and1ejF3NjZrdjhOU3liZVRaYmdySUFmMGcvcVYySWlOTkg3WENQUURF?=
 =?utf-8?Q?TGpSdP0Qk/r5MLCvvC1Hj46y9R83uWKQ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXQ2ZWdoQ3pXZ1RtYk5vbUxLV3FmM3BHVk5ia0c4Smd1aU1TdlJCWWh0SUUz?=
 =?utf-8?B?WGVnZE5sYjA3QUFRZnlxSUwwNzZSYjhqSmN3OEZQOUsvcUtnVjZWLzlRaks5?=
 =?utf-8?B?MGpRYW12RDJhZ2twb1publdqYmQwT2ZBYlI4NS9NanFVUDFPNVJacE1pTGYy?=
 =?utf-8?B?YWVzN3dqMmtPaGZJSkNCMUJiTDQ2RjZiS3hnUmZ2TEJ1ay9EZVVIZlBnbUN6?=
 =?utf-8?B?QWVGaTBndmg1ZU81R3Y3THRzYm5Wb3BsKzlVd2lRN3dmY3pFK1RBdG1tSHhh?=
 =?utf-8?B?OHF0UTNFcEEwQjBvOHhUV1ZtbFlFK244WitQOU9DRmE0YVd6bzl4S05ybWQr?=
 =?utf-8?B?TFdROVdBSlZVNFdURmxVSW83T1MwNmhiQTZxRzZSNUpyWXFrRmV3NHJRdW95?=
 =?utf-8?B?a05SZVFjajVtSmkyUjRCcnA2MmRpM2N2S3FYWS96V1VTUERGUWlvSnljbXBC?=
 =?utf-8?B?Q1Y5MmFwcVE2NE5CZTJkeE4ra1J2bm50eEdGZ1VaU2p6RUNjdWxDRGRlTDdz?=
 =?utf-8?B?YkZvSTlxcEJJbVovQ1B2cXpZNlRQd3Q0WVFCQmFKaWptempET0ZIalNqTU1k?=
 =?utf-8?B?TzBUb0RqRXVjNTdyKzM4WnpUUjE2alVGc3hDUXpOZm5QTk1VTlplT0FsU2pv?=
 =?utf-8?B?VUtucSttZWRlZ1pEK3c0cHBrVURZWHFncy9EaWZuQnAya3ZFVmcwbjc4TzFL?=
 =?utf-8?B?cXpjUFk3VE94WDVsbGJtSURMcFVlTy9nekR5dGUrT3lLbU5US29GTnVRN2Rm?=
 =?utf-8?B?dkFXVGI2V3hJUVdHQ3ZXSXNTRHVjTTB5MzZlQmNpM1ZpNUdNYy84QXZla0t2?=
 =?utf-8?B?WnpWeURnQXhseHlUbnhEa1NBdjFTSXA1bWNsMG1pb2ZNeGxNMUZTRnhGTDU3?=
 =?utf-8?B?S3JQWU9IekFnOUZDaEt2Y3ZnYjhncTlmNHk3UnVZRndPSTRacktCcWxMb01I?=
 =?utf-8?B?N28wdGdBOW0xaVF1L0h2bnhFa0VkODRsa2tkUUlKZGFIZ2JUc3BzOHNNYWdT?=
 =?utf-8?B?cVdwWjFoMVg0dzJLYW9FeDJ5am1POHJkV0cyd3FyNHpzbFdUbmRNdC91c0dX?=
 =?utf-8?B?aHRPZ0dHN054d2tvcDhLaFNEVXROM2F6cHFpSjRrMERLdDEwb1Q0eTVYaVNC?=
 =?utf-8?B?OVJ1NndpK2FCbUt4WmQyV3hoRUNYWERVcmpWRW12WjV0VWdtMThZMFFGNjUy?=
 =?utf-8?B?VG9DTlJ4akZTaG1ZM1gra2xWV3hUOU5JMnBUQ0gvQ2daeVRBQkN4dHlqczNu?=
 =?utf-8?B?N1NJMzg4b3Y5TVMxWkV5dWI2bUE0QnJRMTZGTlhDVXRoT0IvbWo0c1ZCbWg4?=
 =?utf-8?B?aWxyYjBETE0ydEhaOFFQaGRFSlFrSlh6dU1RQ3ZJMUFIanZJaFZFUExVNFJT?=
 =?utf-8?B?aFd4V1F4RzNSRkVVWVd2Y2lyVHVnNkR1d09heXhGSFNYWDFTUmxFOVZkckRs?=
 =?utf-8?B?bTR3cGowaVlSOW5aOElOL3Q4cXZwQVdlcndTL0d2SmFXVmRlMnA3SmplUldS?=
 =?utf-8?B?K1NMYWVNb1B0M3R1MGVLVkVKUy95cGhQUm9ncklDMmZoa3QwY3cvcnd4OW8v?=
 =?utf-8?B?R0s3ZHc5ZllhekZqb0xSZm1Pb3R1YWxrM1FaMm5ZMjVocjQyK25sNkxjbXV0?=
 =?utf-8?B?QUdoMUVUaUY5dzJPZWVycklVbkloK0l5SVJXUXlVWFp6QnZwMHVrNGdJQm1r?=
 =?utf-8?B?ZUNQWDVnR0kyMlY4TE5DamRsTWJqaVRQdVB4bnozT2MvTVhJYzRSUExuZnll?=
 =?utf-8?B?ZUZveTVwd3FETSsrbVVXN0JUcXM2M1BhM0xqd21RUGtxU0ZxUVdyd3lWUmdH?=
 =?utf-8?B?RXpYL0xLTi9pLzBRNlRuZXpGd3RLVVdLUlVUSjBHaGU1c0pDU21SMUdRYk9U?=
 =?utf-8?B?VHkvRmNYcU55VVRBQnpFM3VIbmg4Um9DeHJiM0orMTlQMFAwZjVMOElmRzlp?=
 =?utf-8?B?VnM3bWo2K3BMZzRXS0NUVUw1ek5QYTVhUW1GUVNQdnZFR0hRSHJzcjZFWWhW?=
 =?utf-8?B?dW5zQjZWeTVtL09Pb2pKR0RtTUJudHNpL2M1UWtWM2pGSUc0UUs2cGluWm9n?=
 =?utf-8?B?VkQ5NlN4NFdyRkVsc3RGOGhKaERFRWU0cUxoY2lidUJIK3d0a3RZdlVCSzVl?=
 =?utf-8?B?UkhrVVZteGlWZXpyeTVtc3Q5dGRJRzdSc25VMHZVbEZabFJKTTI3NXNZdXd1?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D74CD86D747DD4C9DB0699A8A849A08@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be22c686-6975-4feb-52e6-08dd659f0aa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 21:59:50.8958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4EuhhDVJgXDRToIs7EwOdLziQZCP+CVm8AKLEwhg/gsiXj1jKfuTlzqoMRw3hdCCK4QqX2EoiqKYIyqnmGlFPwgS3G+pZZSt6V3yT3hHVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5081
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTAzLTE3IGF0IDE0OjUyICswMjAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBUaHUsIE1hciAxMywgMjAyNSBhdCAwNjo0MDowOVBNICsw
MDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90ZToNCj4gPiA+IEN1cnJlbnRseSwgdGhlIGtlcm5l
bCBvbmx5IHBlcmZvcm1zIFdCSU5WRCBpbiBzdG9wX3RoaXNfY3B1KCkgd2hlbiBTTUUNCj4gPiA+
IGlzIHN1cHBvcnRlZCBieSBoYXJkd2FyZS7CoCBQZXJmb3JtIHVuY29uZGl0aW9uYWwgV0JJTlZE
IHRvIHN1cHBvcnQgVERYDQo+ID4gPiBpbnN0ZWFkIG9mIGFkZGluZyBvbmUgbW9yZSB2ZW5kb3It
c3BlY2lmaWMgY2hlY2suwqAgS2V4ZWMgaXMgYSBzbG93IHBhdGgsDQo+ID4gPiBhbmQgdGhlIGFk
ZGl0aW9uYWwgV0JJTlZEIGlzIGFjY2VwdGFibGUgZm9yIHRoZSBzYWtlIG9mIHNpbXBsaWNpdHkg
YW5kDQo+ID4gPiBtYWludGFpbmFiaWxpdHkuDQo+ID4gDQo+ID4gT3V0IG9mIGN1cmlvc2l0eSwg
ZG8geW91IGtub3cgd2h5IHRoaXMgd2FzIG5vdCBhbHJlYWR5IG5lZWRlZCBmb3Igbm9uLXNlbGYg
c25vb3ANCj4gPiBDUFVzPyBXaHkgY2FuJ3QgdGhlcmUgYmUgb3RoZXIgY2FjaGUgbW9kZXMgdGhh
dCBnZXQgd3JpdHRlbiBiYWNrIGFmdGVyIHRoZSBuZXcNCj4gPiBrZXJuZWwgc3RhcnRzIHVzaW5n
IHRoZSBtZW1vcnkgZm9yIHNvbWV0aGluZyBlbHNlPw0KPiANCj4gS2V5SUQgaXMgYSBoYWNrLiBN
ZW1vcnkgY29udHJvbGxlciBpcyBhd2FyZSBhYm91dCBLZXlJRCwgYnV0IG5vdCBjYWNoZS4NCj4g
Q2FjaGUgY29uc2lkZXJzIEtleUlEIGFzIHBhcnQgb2YgcGh5c2ljYWwgYWRkcmVzcy4gVHdvIGNh
Y2hlIGxpbmVzIGZvciB0aGUNCj4gc2FtZSBwaHlzaWNhbCBhZGRyZXNzIHdpdGggZGlmZmVyZW50
IEtleUlEIGFyZSBjb25zaWRlcmVkIHVucmVsYXRlZCBmcm9tDQo+IGNhY2hlIGNvaGVyZW5jeSBQ
b1YuDQoNClN1cmUsIGJ1dCBub24tc2VsZnNub29wIENQVXMgY2FuIGhhdmUgdHJvdWJsZSB3aGVu
IFBBVCBhbGlhc2VzIGNhY2hldHlwZXMsIEkNCmd1ZXNzLiBUaGlzIGNhbWUgdXAgaW4gS1ZNIHJl
Y2VudGx5Lg0KDQpTbyBpZiBuZXcga2VybmVsIG1hcHMgdGhlIHNhbWUgbWVtb3J5IHdpdGggYSBk
aWZmZXJlbnQgbWVtdHlwZSBJIHRob3VnaHQgaXQNCm1pZ2h0IGJlIGEgc2ltaWxhciBwcm9ibGVt
Lg0KDQpUaGVyZSBpcyBhIGxpdHRsZSBiaXQgaGVyZSwgYnV0IGl0IGRvZXNuJ3QgbWVudGlvbiBz
bm9vcGluZy4gTm90IGFuIGV4cGVydCBpbg0KdGhpcyBhcmVhLCBidHcuDQpodHRwczovL3d3dy5r
ZXJuZWwub3JnL2RvYy9Eb2N1bWVudGF0aW9uL3g4Ni9wYXQudHh0DQo=

