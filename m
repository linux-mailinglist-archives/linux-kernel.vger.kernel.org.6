Return-Path: <linux-kernel+bounces-275632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAF39487C9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 05:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C3F1F240FA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0B257CBA;
	Tue,  6 Aug 2024 03:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cpgnv6mQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024773BBC9
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 03:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722913332; cv=fail; b=CgTlYID195MXc6t2pAIB1T/xgC0QpVlFEHYGbFpcw8rWwctbKkI4BUUc90VHNJIG8d8Lf/WA6ikgqcmJg7WXvloCNH9v/7xg6h//qVbU0E4fPCZyYNGF/t4CvKEScSqcvKNw/EHcw0AEhgOACeUMRs/x7MegVvX6tNvLzvXuUaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722913332; c=relaxed/simple;
	bh=wBDrbwcbai5d+6ZobxNfkiVyzH7mDzfsnHP2q2FyzQw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JCzNlb6iYcC6p9UAAxQhGUBijFHf68NY4h5QKqcijd0bPKOXL72TxoFZ5MiskoYlwp0l7ZaaufsWkMpsBjK/DSClRRuqFXCZoHL1zXqHckXOBdNL8yObtpvarK8RZRJplGfYmvfGOJxt7WJ7O8k+EDIud1Cmcf7runhmOaNEQVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cpgnv6mQ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722913330; x=1754449330;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=wBDrbwcbai5d+6ZobxNfkiVyzH7mDzfsnHP2q2FyzQw=;
  b=cpgnv6mQD/j7GCTcYbL8hX4ahwOecEaSQpfYe1Ne/vC9MY9PhOP39Clm
   B9DLG4NRa8LxS6xv40Bl8r8U0Rx0YYMKxlUHG9JnPgp3ca0KdWqGnsoBo
   +53oW/i0NRI80WRNqae7zVsaBW2tKwlcYGlF9ys3uEm2hsO7tjSrQc1qG
   LuA8HbovkwgqbwrrR0X9zIu0hEDWVtQZ7uEeaB3rs5bMsZDFFiKnNP4vV
   2kXIc9XOvxGh3lJ8b6dAUUXJDTdtCOP5GCC79o06XNrKJ2C6YF8pnOZnZ
   q30osKGeIjpTyp3g+0C3a6wXAwqA2WR7+48whQPTtmD6hs/hA31J5j+wZ
   w==;
X-CSE-ConnectionGUID: WqO23fu7SFW857IS/sEnGg==
X-CSE-MsgGUID: cedxYrGxRc6+/ZTe6ueLrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="43432723"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="43432723"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 20:02:09 -0700
X-CSE-ConnectionGUID: ZkoPXySmSPCUnXor0jP5nQ==
X-CSE-MsgGUID: HrgzP/DZSbKhQV8BaADuzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="60996329"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 20:02:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 20:02:08 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 20:02:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 20:02:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 20:02:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Va0SlPn8tH1fLxd2aPzyGc8o5s7NI72mMF6sYpRiPzBqca70/qj7SgV3QYcrPaVuV0ytK0iklaFGXGwCSvP1KPDRFQx4Y+Fs8XvNOyeNieTrrUlVuEZYZzehCISWSYdMFEG6QCQgJGG/807dHtvg6+qg76ZDdnFbnnmYNv9EPe0a+Ni/nCkXv+rtAO8x/hBQNnuldolAuOTewwIV4AGTYpjSa4m6qvws70QH6tE9dTja2IQNfu1vTkC7JXsmidxZepzPw+5CAYn7acIJrDFgIZybT2WJ7LUrQVwqRz8nz6ncWM2OkMryFvf4YWiZyFwKlgJiqrrO6LvpLNAbkaR5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETwTs5lN3ZAykMCoV0H/KtKa64wBgedW/6IGcXXoZMU=;
 b=rUyEsC58KOA1vRZHHf63LsFR6PKBXwmlHhGsgWJ7LRaaPfhJB83OtelBROezV6aS2fUM8+bRRI/SvQPbqUHpMnbBorK6nf6f2JCR2/QnsWluxkc3Ab9fScPKJ6yOo9bJe7iep2KrWi3fvMm5rdlWMEkOL7SJ2plr4F2ovRn9NTR5gkl2DeJAa+lCnQ5X0crmJ6Q+Ajcw8oy/5Kpve4hbGh3NkBsALA589hA52FZKY9lR8tQPj1le+0giMAuPIHUZHh6oIPojCR9Aw8HqDA2FkAY2Cyo3LOq5pXNLDEq0aagpah3J304N4vKFY7OBaoZeudpNgMpr/35Tqd2nEerJdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6403.namprd11.prod.outlook.com (2603:10b6:510:1f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 03:01:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 03:01:59 +0000
Date: Tue, 6 Aug 2024 11:01:44 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Yu Zhao <yuzhao@google.com>
CC: Muchun Song <muchun.song@linux.dev>, Janosch Frank
	<frankja@linux.ibm.com>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>, "Linux
 Memory Management List" <linux-mm@kvack.org>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, "Frank van
 der Linden" <fvdl@google.com>, Matthew Wilcox <willy@infradead.org>, Peter Xu
	<peterx@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
	<linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, "Marc
 Hartmayer" <mhartmay@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
	Yosry Ahmed <yosryahmed@google.com>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [mm/hugetlb_vmemmap] 875fa64577:
 vm-scalability.throughput -34.3% regression
Message-ID: <ZrGSGIxpsEoBG2iu@xsang-OptiPlex-9020>
References: <202407091001.1250ad4a-oliver.sang@intel.com>
 <3acefad9-96e5-4681-8014-827d6be71c7a@linux.ibm.com>
 <CAOUHufYvCeiGGa+3PbPDfFx__aV2XxyS7TMHMicws4aNTg4qmQ@mail.gmail.com>
 <CAOUHufaO-hxdEJZtdN-5EHEs-wOJoGQ1pVGeHaa89L7hSz8grQ@mail.gmail.com>
 <ZponC7ewZeq62UzS@xsang-OptiPlex-9020>
 <CAOUHufb1qteTQ+rLHBgu5yVQNYPBVrv7wCfEYC85y_pjQQ3EfQ@mail.gmail.com>
 <CAOUHufb7_sbDG7Cs_n63gySe-c5syNUPz6kYmxQvgcFim9JZ=w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufb7_sbDG7Cs_n63gySe-c5syNUPz6kYmxQvgcFim9JZ=w@mail.gmail.com>
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: 278153e6-a59c-46a1-216b-08dcb5c42337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1Foem55aDEvd2g3NkwvdDhJYWFEMG5QTFVody9kbmlsRjlrQnFhWnJTSHhk?=
 =?utf-8?B?N1ExRTEyZERZUEJPS1J4TkdUOTlCbDBKUS82blkrSVk3S2RVc0pTZ0NkM2du?=
 =?utf-8?B?c1ZNWEZKNzY2R2drR3U1TlZlMCs1RzdpZi9mZ1ZPRWwvcFA4MnRxbEdMTWZK?=
 =?utf-8?B?MEtDVU43ZjdxaTZlVElBaVk1akdIWmx3SG5kTDNpRWV4OHE0clh0SlJJSU9r?=
 =?utf-8?B?ZWtjZHlFemx0dFUzMTR2M0V1aEtaZlRkS3V5MmRHVDMyZ25CSFJidmJheW8z?=
 =?utf-8?B?N2s1V0l6ZHl4b2IwSzhrclpRRnlrWjhKZXIrUHZTWnhNN0c0N0hUcmw4MDZo?=
 =?utf-8?B?SnFWbXQ0c0poU0dQVzZPZElibDNzb1BIakg5L2FhS01Xek96dWhrdGc1ZE00?=
 =?utf-8?B?dGF4dHg1VW9OVVcrTkRxL3k4OWNFZURhSi9iUWFpZ2tDMmN6VnZIcitYcDZa?=
 =?utf-8?B?S2RUVkZiN3YrcitCblloRDNQRTJzRmFBbkhSVHBwR3lBbmdicWxRVGtYcW1t?=
 =?utf-8?B?WmJKQm1MZmtSTytmRnc5NUpPaUNjMjJZanVpc0ZXQ0Z5ZFFVbS91RFFYOE5H?=
 =?utf-8?B?RVlZSEFtWWdmOGU0bkNQRFhMbTBHYUI2NDM4NjhURnpOeXA2WExpai8wL3Vx?=
 =?utf-8?B?MlUweC8za3ptTTY1azdjaHkxLzVxMlNpaXgwa3FscTg0azBlVXhUazV2VG84?=
 =?utf-8?B?MHExVUJNQTRjb3hOM29vVWVzOWZCM1R6dHM5c0lBQXVrSWdJdHRYMzlTN1Y2?=
 =?utf-8?B?a09mUFBBVUFhQzdFL2E3VlIyQXYyWms2M2N6OEdsZkREbUhZa1NQam9yMjdM?=
 =?utf-8?B?SXpmZXJ1R2w2a3dpTWlDcE1aVUIrQWVYYTZRelFtSUZ1bmkrdkpteVF3MzZ1?=
 =?utf-8?B?Qm8vTkgxRXpIU2w4empmV2RKZEpFZlE4YzkwSElkZWJiQTdaNFRPVVRqSjZR?=
 =?utf-8?B?VkZSR0sreDdYUWVWWExDZzAwVVp0RXV6Zm10ZEIxejgvdEkxb3U1ODFldXZn?=
 =?utf-8?B?a3hRc096NUJJQnIzb2ZTL0hzbGtqVHpsMVdqYWJhUFh6WitQc3V1UEVxeFUv?=
 =?utf-8?B?Vmt0ZXYxYUZFelJwSkRnUEZXK2lFT0d2VGI5L3JyYmpEVk1Mb2U4amhCWGpv?=
 =?utf-8?B?TXh0OHVzVzk0Q3o0UGhxYXo1bWhxMEs0SlJxencwR0I1NEY3cmpSRkFFV0hm?=
 =?utf-8?B?cWJGMnMydnNoZUF2UVJmdmFLbjJDU2VxY01IZTlqR2dvSVZtUFprVElLQ1Br?=
 =?utf-8?B?NVE5Y2VZVmNDUjhHL0wyZSs0Q2RPdy9LNTg1U0RUMkwzaEkybmxvalN4QW5u?=
 =?utf-8?B?UEZJVDUxM21Jc21ySlpIVXUyRFBUS0t4ZFp1WHdrY2FhOGszbzJ6aGMxWHRI?=
 =?utf-8?B?dFJrL1BBUnZQaC9ZSCtSLzMySlhKLzlJS3g3NUhTdkFkMmJsYjBNV09JUEFO?=
 =?utf-8?B?M2VzZkozZ29WaW12WmtqbnJaU2dYYmMrOVNBZGhIb0ZpWjRWN21ESVhUbHpB?=
 =?utf-8?B?T01rejNrdXJSKzJwWUVTTHdwK1Mrem83bnB3OGJFSkUvRkNVVVhzNzBFbUp5?=
 =?utf-8?B?R29qcHRmT09xbjA3THdHL3loZ0k2NXlUZGY0R3htNEtzNnFkS0RsTTdNa0gv?=
 =?utf-8?B?WE5ZeUQrY2NJcGVIcTYyWE1vMC9pbG1XNmpDMEJ0alkwQjFFdDlLVzc1V1ZU?=
 =?utf-8?B?WWloU2hOMHV6Uit5WlZPZ25RZzd0LzdjNU5kL09oVEJ6NFpOdUZWWUhXVHU1?=
 =?utf-8?B?cDJ5b3ZUSjRFbWY3dnhsRE1TbWFBS1h3V2hZaFFwamYxM0ZwdEZ6TkozZUdk?=
 =?utf-8?Q?83ym6ihZtrdZwvuqNVH1DB1FbR9Dkx7B9Jx5s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmpqMjU3WlAwREZyaTFNazVPcUlTV1o2S2xiN3FlS3RpMFpibStwU3J5Q2VD?=
 =?utf-8?B?UG1LbGh2R3A2MGlzWUl4ak5aOWo0c2NWVXpSOG5xL0VYd3pFU3ViVndVK3Q4?=
 =?utf-8?B?UkVZaEJBSzZlUVVvMDVIOFNNYVFIMHN5N001MXFjTC9Pb0lMenQvZVlTOTlh?=
 =?utf-8?B?SmJHTWpKTzhpbjYzcTlmbWZ1NkJObW1NM2p1K1hxUko5WDRpNmpHT2hiWVYr?=
 =?utf-8?B?VTQ2SERXY2IvVzczL2x6SVJOWnhXSlVSMllsSy9ZOU5CdjR4VW9qQnY2TWlO?=
 =?utf-8?B?K0tLV1Y3NUtKUVhyRldvOUF1N3BMUnZjdlNTVUoreWNXZThVUnVjWkpnd0hm?=
 =?utf-8?B?QlpMQVdlWkFoeWJYNEMwVm5ZSkl5SVM2cVNZbTFoSEJuN2psamNicmtBZVBI?=
 =?utf-8?B?YnovOWpsQmlGRmo4TGJNamgrTlNJcVlrZkV0M2RGd3V1SmtoTEFQQkxuMGs5?=
 =?utf-8?B?QVd1b1gvRW5tN2lxUEt0MUVrYk51V1cyb3BmckVrdkZ4MmVBSzhiRVVDWTV0?=
 =?utf-8?B?RmcrYnRmeURQMURjaFNRSEFsZDl2YU1sZUpLbXR2TUkzUjErdTlPK21iOHdJ?=
 =?utf-8?B?YjByRmRhZm1OZlRrdDlDUTQ2VlVaUGFxdXA1dU9oUEQ1RXZVOFpCSkM4TnR2?=
 =?utf-8?B?Z1l5YTV5MzhlVXB2Qmc5aWR1OG1jeTg3Q3lkU1YwQ2ovMU9ROWFNdUUrVVVB?=
 =?utf-8?B?NERTOGtsZUYzTjV4anRwQkcvVHY5U2xGOFgvZzhDeTVTOUNIOExwVS9vUjA2?=
 =?utf-8?B?SGJOM2lRZ3g3aEQ5aUYxM2RsM1ZlWS9IWDRNMzdkbFBHWGYweHozNTQzZWRj?=
 =?utf-8?B?TndGUitVOGUzb0RoMDVWaUlveXM4ZHNTY1JSZllCdVo2WjVMWlhldEVkYURD?=
 =?utf-8?B?eCtLRGpYRnVkbFhhUERNZW51cDVNTG5UMWZCeFBycjZlUUZFQ2NESWpSNFBV?=
 =?utf-8?B?YnpyTlVWRWxPRHQ3SHdKNU0yR0FPQ25SM0FSeXltRDdlWFQyMWROam52N1R4?=
 =?utf-8?B?cXNCRFZRUDU1eFJCRDJwQXB3YlQxM2ltSG8vOWFac3hjbUJaUVBDZ2h0bnZu?=
 =?utf-8?B?ek9UUEZzdTA5WldqdjFJbkhmUmZ4NWNSODhWYnJtdUNBZWYxUkpXZW5weVAv?=
 =?utf-8?B?OGY1UHFxZno4d0k3WFlVdHgxQ1VoSVJqWTJJK01nV0RJdmVyMTV1QlA3SEJC?=
 =?utf-8?B?WnVHUXJ0aUp2eUVJN2dTWGVzR3IrQVArR0VYMytQeTJna1N2dzFNMXNjdVBH?=
 =?utf-8?B?Mjc2TG1ocFMyMFY4V011NDBaWW1iYXI2ZEw5NmZ6NlFjRGptQVltRThOOXNH?=
 =?utf-8?B?WEtRRWpCOE5yUEhtN0pWYXFsaUlEVU1aY2lxdUVIY1FmSUFlWkZ5cWlNZ0U2?=
 =?utf-8?B?L2pISzdKdWV4ajFkRytZbUtQeDB3elBubThaMEZnV2c0MjljS2dmSkwxUkJN?=
 =?utf-8?B?NDhCSzVteWN3bFdMYTcrSHozcHlYLzF3Z2JEd3hzWERkUmZlMzdzK3l0N2gv?=
 =?utf-8?B?WVo2Z2swYVh2VjUxei9rMnBqVDJyUy9yNlltbDBBYnZ4b2FrQ3RQT2lDQXJk?=
 =?utf-8?B?OHk3K3k1eGdQVEUwb0svUy9ndmpmWjNHcCt0RUw5TXZ2djFXUTdmK0YvSkxR?=
 =?utf-8?B?YjQ3SXk1bnpocVBoZnB0Y3E3T0I5L0MvcThIcEV0ZFdRN3FrY0FHWHZaNWJO?=
 =?utf-8?B?amFVMmlWRW9rYVoyWU1wT3BPTUlxZWJzbHBKVTdUdG1uWWNMUmo5WTBEQWN1?=
 =?utf-8?B?MkNVQVNOdG85TXVRWmc1NXRJand0YmE2YXJ5Rkl3SzFvSUpXVjlDMTRPeU1Q?=
 =?utf-8?B?eHl1TWladXNGUnFEOGw4YnpuVDVwQWJIWVFuVkJmMEVHYzUvaGMrR0x6blBY?=
 =?utf-8?B?S3RmWFBwbUpzdHdvNkJIbFdTWGpzTTlPbVpOZ3NFaWJld2pBK3Jmbzdxc04r?=
 =?utf-8?B?V3hxTERHdnJMTE4zVGZpNXAybjJRelBuZ0NieU52U2RUUUpDdlIyL2hEOTZy?=
 =?utf-8?B?YlV3UnhQb1NSZmI0ZFE0clE5emZGWUJzWkNjN0NnU051WWk2NTFIMVNnVzV2?=
 =?utf-8?B?MHJpQUk4WkpIaDAralRQUTMzYXdvTDF6eUk4MGd5ellTR0FuTElJdEVTbXBl?=
 =?utf-8?B?UHNQcytCRUtEb2VjVCszcGNEcEpjZ0xlaVpIeSs1QVNLZUZ4T21wbzdsd2d3?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 278153e6-a59c-46a1-216b-08dcb5c42337
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 03:01:59.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AvhbEIrve2Bzvk7SzBZVDL6W/8iCIGEieDBR7gLQMaVyGfGeHRtgnzw8MxUl9eOsFQ/1TlJB5AsNhgcvcwbig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6403
X-OriginatorOrg: intel.com

hi, Yu Zhao,

On Sat, Aug 03, 2024 at 04:07:55PM -0600, Yu Zhao wrote:
> Hi Oliver,
> 
> On Fri, Jul 19, 2024 at 10:06 AM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Fri, Jul 19, 2024 at 2:44 AM Oliver Sang <oliver.sang@intel.com> wrote:
> > >
> > > hi, Yu Zhao,
> > >
> > > On Wed, Jul 17, 2024 at 09:44:33AM -0600, Yu Zhao wrote:
> > > > On Wed, Jul 17, 2024 at 2:36 AM Yu Zhao <yuzhao@google.com> wrote:
> > > > >
> > > > > Hi Janosch and Oliver,
> > > > >
> > > > > On Wed, Jul 17, 2024 at 1:57 AM Janosch Frank <frankja@linux.ibm.com> wrote:
> > > > > >
> > > > > > On 7/9/24 07:11, kernel test robot wrote:
> > > > > > > Hello,
> > > > > > >
> > > > > > > kernel test robot noticed a -34.3% regression of vm-scalability.throughput on:
> > > > > > >
> > > > > > >
> > > > > > > commit: 875fa64577da9bc8e9963ee14fef8433f20653e7 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")
> > > > > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > > > > >
> > > > > > > [still regression on linux-next/master 0b58e108042b0ed28a71cd7edf5175999955b233]
> > > > > > >
> > > > > > This has hit s390 huge page backed KVM guests as well.
> > > > > > Our simple start/stop test case went from ~5 to over 50 seconds of runtime.
> > > > >
> > > > > Could you try the attached patch please? Thank you.
> > > >
> > > > Thanks, Yosry, for spotting the following typo:
> > > >   flags &= VMEMMAP_SYNCHRONIZE_RCU;
> > > > It's supposed to be:
> > > >   flags &= ~VMEMMAP_SYNCHRONIZE_RCU;
> > > >
> > > > Reattaching v2 with the above typo fixed. Please let me know, Janosch & Oliver.
> > >
> > > since the commit is in mainline now, I directly apply your v2 patch upon
> > > bd225530a4c71 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")
> > >
> > > in our tests, your v2 patch not only recovers the performance regression,
> >
> > Thanks for verifying the fix!
> >
> > > it even has +13.7% performance improvement than 5a4d8944d6b1e (parent of
> > > bd225530a4c71)
> >
> > Glad to hear!
> >
> > (The original patch improved and regressed the performance at the same
> > time, but the regression is bigger. The fix removed the regression and
> > surfaced the improvement.)
> 
> Can you please run the benchmark again with the attached patch on top
> of the last fix?

last time, I applied your last fix (1)  directly upon mainline commit (2)

9a5b87b521401 fix for 875fa64577 (then bd225530a4 in main)               <--- (1)
bd225530a4c71 mm/hugetlb_vmemmap: fix race with speculative PFN walkers  <--- (2)

but I failed to apply your patch this time upon (1)

then I found I can apply above (1) upon mainline commit (3), as below (4).
your patch this time can be applied upon (4) successfully, as below (5)

e2b8dff50992a new hugetlb-20240805.patch                                       <--- (5)
b5af188232e56 v2 fix for bd225530a4 but apply on mainline tip 17712b7ea0756    <--- (4)
17712b7ea0756 Merge tag 'io_uring-6.11-20240802' of git://git.kernel.dk/linux  <--- (3)

I tested (3)(4)(5) and compared them with bd225530a4c71 and its parent. detail
as below [1]

you may notice the data for bd225530a4c71 and its parent are different with
previous data. this is due to we found some problem for gcc-13, we convert
to use gcc-12 now, our config is also changed.

we have below observations.
* bd225530a4c71 still has a similar -36.6% regression compare to its parent
* 17712b7ea0756 has similar data as bd225530a4c71 (a little worse, so -39.2%
  comparing to 5a4d8944d6b1e who is parent of bd225530a4c71)
* your last fix still do the work to recover the regression, but is not better
  than 5a4d8944d6b1e
* your patch this time seems not impact performance data a lot


[1]

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/300s/512G/lkp-icl-2sp2/anon-cow-rand-hugetlb/vm-scalability

commit:
  5a4d8944d6b1e ("cachestat: do not flush stats in recency check")
  bd225530a4c71 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")
  17712b7ea0756 ("Merge tag 'io_uring-6.11-20240802' of git://git.kernel.dk/linux")
  b5af188232e56  <--- apply your last fix upon 17712b7ea0756
  e2b8dff50992a  <--- then apply your patch this time upon b5af188232e56

5a4d8944d6b1e1aa bd225530a4c717714722c373144 17712b7ea0756799635ba159cc7 b5af188232e564d17fc3c1784f7 e2b8dff50992a56c67308f905bd
---------------- --------------------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \          |                \
 3.312e+09 ± 34%    +472.2%  1.895e+10 ±  3%    +487.2%  1.945e+10 ±  7%      -4.4%  3.167e+09 ± 29%     -15.6%  2.795e+09 ± 29%  cpuidle..time
    684985 ±  5%   +1112.3%    8304355 ±  2%   +1099.5%    8216278            -2.4%     668573 ±  5%      -5.2%     649406 ±  2%  cpuidle..usage
    231.53 ±  3%     +40.7%     325.70 ±  2%     +45.1%     335.98 ±  5%      +1.4%     234.78 ±  4%      +0.2%     231.94 ±  3%  uptime.boot
     10015 ± 10%    +156.8%      25723 ±  4%    +156.8%      25724 ±  7%      +4.3%      10447 ± 12%      -0.7%       9945 ± 13%  uptime.idle
    577860 ±  7%     +18.1%     682388 ±  8%     +12.1%     647808 ±  6%      +9.9%     635341 ±  6%      -0.3%     576189 ±  5%  numa-numastat.node0.local_node
    624764 ±  5%     +16.1%     725128 ±  4%     +18.0%     736975 ±  2%     +10.2%     688399 ±  2%      +3.0%     643587 ±  5%  numa-numastat.node0.numa_hit
    647823 ±  5%     +11.3%     721266 ±  9%     +15.7%     749411 ±  6%     -10.0%     583278 ±  5%      -1.0%     641117 ±  3%  numa-numastat.node1.local_node
    733550 ±  4%     +10.6%     811157 ±  4%      +8.4%     795091 ±  3%      -9.0%     667814 ±  3%      -3.4%     708807 ±  3%  numa-numastat.node1.numa_hit
      6.17 ±108%   +1521.6%     100.00 ± 38%  +26137.8%       1618 ±172%     -74.1%       1.60 ± 84%     +27.0%       7.83 ±114%  perf-c2c.DRAM.local
     46.17 ± 43%   +2759.6%       1320 ± 26%  +12099.6%       5632 ±112%     +18.3%      54.60 ± 56%     +48.7%      68.67 ± 42%  perf-c2c.DRAM.remote
     36.50 ± 52%   +1526.5%     593.67 ± 26%   +1305.5%     513.00 ± 53%      +2.5%      37.40 ± 46%     +62.6%      59.33 ± 66%  perf-c2c.HITM.local
     15.33 ± 74%   +2658.7%     423.00 ± 36%   +2275.0%     364.17 ± 67%     +48.7%      22.80 ± 75%    +122.8%      34.17 ± 58%  perf-c2c.HITM.remote
     15.34 ± 27%    +265.8%      56.12          +256.0%      54.63            -2.5%      14.96 ± 23%     -12.7%      13.39 ± 23%  vmstat.cpu.id
     73.93 ±  5%     -41.4%      43.30 ±  2%     -39.3%      44.85 ±  2%      +0.5%      74.27 ±  4%      +2.4%      75.72 ±  3%  vmstat.cpu.us
    110.76 ±  4%     -47.2%      58.47 ±  2%     -45.7%      60.14 ±  2%      +0.1%     110.90 ±  4%      +1.9%     112.84 ±  3%  vmstat.procs.r
      2729 ±  3%    +167.3%       7294 ±  2%    +155.7%       6979 ±  4%      +0.2%       2734            -1.3%       2692 ±  5%  vmstat.system.cs
    150274 ±  5%     -23.2%     115398 ±  6%     -27.2%     109377 ± 13%      +0.6%     151130 ±  4%      +0.9%     151666 ±  3%  vmstat.system.in
     14.31 ± 29%     +41.4       55.74           +40.0       54.31            -0.5       13.85 ± 25%      -1.9       12.42 ± 24%  mpstat.cpu.all.idle%
      0.34 ±  5%      -0.1        0.21 ±  2%      -0.1        0.21 ±  2%      -0.0        0.34 ±  4%      +0.0        0.35 ±  4%  mpstat.cpu.all.irq%
      0.02 ±  4%      +0.0        0.03            +0.0        0.03 ±  4%      -0.0        0.02 ±  2%      -0.0        0.02 ±  2%  mpstat.cpu.all.soft%
     10.63 ±  4%     -10.2        0.43 ±  4%     -10.3        0.35 ± 29%      +0.1       10.71 ±  2%      +0.2       10.79 ±  4%  mpstat.cpu.all.sys%
     74.69 ±  5%     -31.1       43.59 ±  2%     -29.6       45.10 ±  2%      +0.4       75.08 ±  4%      +1.7       76.42 ±  3%  mpstat.cpu.all.usr%
      6.83 ± 15%    +380.5%      32.83 ± 45%    +217.1%      21.67 ±  5%     +40.5%       9.60 ± 41%      -7.3%       6.33 ±  7%  mpstat.max_utilization.seconds
      0.71 ± 55%      +0.4        1.14 ±  3%      +0.2        0.96 ± 44%      +0.4        1.09 ±  4%      +0.2        0.91 ± 30%  perf-profile.calltrace.cycles-pp.lrand48_r
     65.57 ± 10%      +3.5       69.09            -7.3       58.23 ± 45%      +2.4       67.94            +7.2       72.76        perf-profile.calltrace.cycles-pp.do_rw_once
      0.06 ±  7%      -0.0        0.05 ± 46%      +0.0        0.11 ± 48%      +0.0        0.07 ± 16%      +0.0        0.08 ± 16%  perf-profile.children.cycles-pp.get_jiffies_update
      0.28 ± 10%      +0.0        0.29 ±  8%      +0.3        0.58 ± 74%      +0.0        0.30 ± 13%      +0.0        0.32 ± 12%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.24 ± 10%      +0.0        0.25 ± 10%      +0.2        0.46 ± 66%      +0.0        0.26 ± 13%      +0.0        0.28 ± 12%  perf-profile.children.cycles-pp.update_process_times
      0.06 ±  7%      -0.0        0.05 ± 46%      +0.0        0.11 ± 48%      +0.0        0.07 ± 16%      +0.0        0.08 ± 16%  perf-profile.self.cycles-pp.get_jiffies_update
      0.50 ±  7%      +0.1        0.56 ±  3%      -0.0        0.46 ± 44%      +0.0        0.53 ±  3%      +0.0        0.52 ±  6%  perf-profile.self.cycles-pp.lrand48_r@plt
     26722 ±  4%     -33.8%      17690 ± 15%     -40.0%      16038 ± 29%      +6.9%      28560 ±  3%      +9.0%      29116 ±  3%  numa-meminfo.node0.HugePages_Surp
     26722 ±  4%     -33.8%      17690 ± 15%     -40.0%      16038 ± 29%      +6.9%      28560 ±  3%      +9.0%      29116 ±  3%  numa-meminfo.node0.HugePages_Total
  74013758 ±  3%     +24.7%   92302659 ±  5%     +30.0%   96190384 ±  9%      -5.6%   69852204 ±  2%      -6.0%   69592735 ±  3%  numa-meminfo.node0.MemFree
  57671194 ±  4%     -31.7%   39382292 ± 12%     -38.5%   35494567 ± 26%      +7.2%   61832747 ±  3%      +7.7%   62092216 ±  3%  numa-meminfo.node0.MemUsed
     84822 ± 19%     +57.1%     133225 ± 17%     +13.5%      96280 ± 39%      -4.4%      81114 ±  9%      -6.0%      79743 ± 11%  numa-meminfo.node1.Active
     84781 ± 19%     +57.1%     133211 ± 17%     +13.5%      96254 ± 39%      -4.4%      81091 ±  9%      -6.0%      79729 ± 11%  numa-meminfo.node1.Active(anon)
  78416592 ±  7%     +13.3%   88860070 ±  5%      +6.7%   83660976 ± 11%      +4.5%   81951764 ±  4%      +2.4%   80309519 ±  3%  numa-meminfo.node1.MemFree
  53641607 ± 11%     -19.5%   43198129 ± 11%      -9.8%   48397199 ± 19%      -6.6%   50106411 ±  7%      -3.5%   51748656 ±  4%  numa-meminfo.node1.MemUsed
  18516537 ±  3%     +24.7%   23084190 ±  5%     +29.9%   24053750 ±  9%      -5.6%   17484374 ±  3%      -6.1%   17387753 ±  2%  numa-vmstat.node0.nr_free_pages
    624065 ±  5%     +16.0%     724171 ±  4%     +18.0%     736399 ±  2%     +10.1%     687335 ±  2%      +3.0%     642802 ±  5%  numa-vmstat.node0.numa_hit
    577161 ±  8%     +18.1%     681431 ±  8%     +12.1%     647232 ±  6%      +9.9%     634277 ±  6%      -0.3%     575404 ±  5%  numa-vmstat.node0.numa_local
     21141 ± 19%     +57.4%      33269 ± 17%     +13.7%      24027 ± 39%      -4.2%      20242 ±  9%      -5.6%      19967 ± 11%  numa-vmstat.node1.nr_active_anon
  19586357 ±  7%     +13.5%   22224344 ±  5%      +6.8%   20914089 ± 11%      +4.6%   20487157 ±  4%      +2.6%   20087311 ±  3%  numa-vmstat.node1.nr_free_pages
     21141 ± 19%     +57.4%      33269 ± 17%     +13.7%      24027 ± 39%      -4.2%      20242 ±  9%      -5.6%      19967 ± 11%  numa-vmstat.node1.nr_zone_active_anon
    732629 ±  4%     +10.5%     809596 ±  4%      +8.4%     793911 ±  3%      -9.0%     666417 ±  3%      -3.5%     707191 ±  3%  numa-vmstat.node1.numa_hit
    646902 ±  5%     +11.3%     719705 ±  9%     +15.7%     748231 ±  6%     -10.1%     581882 ±  5%      -1.1%     639501 ±  3%  numa-vmstat.node1.numa_local
    167.87 ±  2%     +56.6%     262.93           +65.3%     277.49 ±  3%      -1.9%     164.74            -1.8%     164.84        time.elapsed_time
    167.87 ±  2%     +56.6%     262.93           +65.3%     277.49 ±  3%      -1.9%     164.74            -1.8%     164.84        time.elapsed_time.max
    140035 ±  6%     -50.5%      69271 ±  5%     -50.8%      68889 ±  4%      -5.9%     131759 ±  3%      -1.2%     138362 ±  8%  time.involuntary_context_switches
    163.67 ± 10%     +63.7%     268.00 ±  5%     +76.5%     288.83 ±  5%     +13.0%     185.00 ±  8%     +22.4%     200.33 ±  4%  time.major_page_faults
     11308 ±  2%     -48.4%       5830           -47.0%       5995            +1.8%      11514            +2.5%      11591        time.percent_of_cpu_this_job_got
      2347           -94.0%     139.98 ±  3%     -95.0%     117.34 ± 21%      +0.3%       2354            -0.0%       2347        time.system_time
     16627            -8.6%      15191            -0.6%      16529 ±  5%      -0.1%      16616            +0.8%      16759 ±  2%  time.user_time
     12158 ±  2%   +5329.5%     660155         +5325.1%     659615            -1.0%      12037 ±  3%      -1.4%      11985 ±  3%  time.voluntary_context_switches
     59662           -37.0%      37607           -40.5%      35489 ±  4%      +0.5%      59969            -0.1%      59610        vm-scalability.median
      2.19 ± 20%      +1.7        3.91 ± 30%      +3.3        5.51 ± 30%      +0.6        2.82 ± 23%      +1.5        3.72 ± 25%  vm-scalability.median_stddev%
      2.92 ± 22%      +0.6        3.49 ± 32%      +1.5        4.45 ± 19%      +0.4        3.35 ± 17%      +1.5        4.39 ± 16%  vm-scalability.stddev%
   7821791           -36.6%    4961402           -39.2%    4758850 ±  2%      -0.2%    7809010            -0.7%    7769662        vm-scalability.throughput
    167.87 ±  2%     +56.6%     262.93           +65.3%     277.49 ±  3%      -1.9%     164.74            -1.8%     164.84        vm-scalability.time.elapsed_time
    167.87 ±  2%     +56.6%     262.93           +65.3%     277.49 ±  3%      -1.9%     164.74            -1.8%     164.84        vm-scalability.time.elapsed_time.max
    140035 ±  6%     -50.5%      69271 ±  5%     -50.8%      68889 ±  4%      -5.9%     131759 ±  3%      -1.2%     138362 ±  8%  vm-scalability.time.involuntary_context_switches
     11308 ±  2%     -48.4%       5830           -47.0%       5995            +1.8%      11514            +2.5%      11591        vm-scalability.time.percent_of_cpu_this_job_got
      2347           -94.0%     139.98 ±  3%     -95.0%     117.34 ± 21%      +0.3%       2354            -0.0%       2347        vm-scalability.time.system_time
     16627            -8.6%      15191            -0.6%      16529 ±  5%      -0.1%      16616            +0.8%      16759 ±  2%  vm-scalability.time.user_time
     12158 ±  2%   +5329.5%     660155         +5325.1%     659615            -1.0%      12037 ±  3%      -1.4%      11985 ±  3%  vm-scalability.time.voluntary_context_switches
     88841 ± 18%     +56.6%     139142 ± 16%     +18.6%     105352 ± 34%      -3.1%      86098 ±  9%      -6.8%      82770 ± 11%  meminfo.Active
     88726 ± 18%     +56.7%     139024 ± 16%     +18.6%     105233 ± 34%      -3.1%      85984 ±  9%      -6.8%      82654 ± 11%  meminfo.Active(anon)
  79226777 ±  3%     +18.1%   93562456           +17.2%   92853282            -0.3%   78961619 ±  2%      -1.5%   78023229 ±  2%  meminfo.CommitLimit
     51410 ±  5%     -27.2%      37411 ±  2%     -25.9%      38103 ±  2%      +0.5%      51669 ±  4%      +2.3%      52586 ±  3%  meminfo.HugePages_Surp
     51410 ±  5%     -27.2%      37411 ±  2%     -25.9%      38103 ±  2%      +0.5%      51669 ±  4%      +2.3%      52586 ±  3%  meminfo.HugePages_Total
 1.053e+08 ±  5%     -27.2%   76618243 ±  2%     -25.9%   78036556 ±  2%      +0.5%  1.058e+08 ±  4%      +2.3%  1.077e+08 ±  3%  meminfo.Hugetlb
     59378 ±  9%     -27.2%      43256 ±  9%     -29.4%      41897 ± 15%      -3.0%      57584 ±  9%      -1.5%      58465 ±  8%  meminfo.Mapped
 1.513e+08 ±  3%     +19.0%  1.801e+08           +18.1%  1.787e+08            -0.3%  1.508e+08 ±  3%      -1.6%  1.489e+08 ±  2%  meminfo.MemAvailable
 1.523e+08 ±  3%     +18.9%  1.811e+08           +18.0%  1.798e+08            -0.3%  1.518e+08 ±  3%      -1.6%  1.499e+08 ±  2%  meminfo.MemFree
 1.114e+08 ±  4%     -25.8%   82607720 ±  2%     -24.6%   83956777 ±  2%      +0.5%  1.119e+08 ±  4%      +2.2%  1.138e+08 ±  3%  meminfo.Memused
     10914 ±  2%      -9.3%       9894            -9.0%       9935            +0.8%      10999 ±  2%      +1.3%      11059        meminfo.PageTables
    235415 ±  4%     +17.2%     275883 ±  9%      +2.4%     241001 ± 17%      -1.9%     230929 ±  2%      -2.2%     230261 ±  4%  meminfo.Shmem
     22170 ± 18%     +57.0%      34801 ± 17%     +18.9%      26361 ± 34%      -2.6%      21594 ±  9%      -6.6%      20698 ± 11%  proc-vmstat.nr_active_anon
   3774988 ±  3%     +19.0%    4493004           +18.2%    4461258            -0.3%    3762775 ±  2%      -1.7%    3712537 ±  2%  proc-vmstat.nr_dirty_background_threshold
   7559208 ±  3%     +19.0%    8996995           +18.2%    8933426            -0.3%    7534750 ±  2%      -1.7%    7434153 ±  2%  proc-vmstat.nr_dirty_threshold
    824427            +1.2%     834568            +0.3%     826777            -0.0%     824269            -0.0%     824023        proc-vmstat.nr_file_pages
  38091344 ±  3%     +18.9%   45280310           +18.0%   44962412            -0.3%   37969040 ±  2%      -1.6%   37466065 ±  2%  proc-vmstat.nr_free_pages
     25681            -1.7%      25241            -1.6%      25268            +0.9%      25908            -0.1%      25665        proc-vmstat.nr_kernel_stack
     15161 ±  9%     -28.5%      10841 ±  9%     -30.3%      10565 ± 14%      -3.4%      14641 ±  9%      -2.1%      14849 ±  7%  proc-vmstat.nr_mapped
      2729 ±  2%      -9.4%       2473            -9.1%       2480            +0.7%       2748 ±  2%      +1.2%       2762        proc-vmstat.nr_page_table_pages
     58775 ±  4%     +17.3%      68926 ±  9%      +2.5%      60274 ± 18%      -1.8%      57736 ±  2%      -2.1%      57526 ±  4%  proc-vmstat.nr_shmem
     22170 ± 18%     +57.0%      34801 ± 17%     +18.9%      26361 ± 34%      -2.6%      21594 ±  9%      -6.6%      20698 ± 11%  proc-vmstat.nr_zone_active_anon
   1360860           +13.0%    1537181           +12.7%    1533834            -0.2%    1357949            -0.5%    1354233        proc-vmstat.numa_hit
   1228230           +14.4%    1404550           +13.9%    1398987            -0.6%    1220355            -0.7%    1219146        proc-vmstat.numa_local
    132626            +0.0%     132681            +1.7%     134822            +3.7%     137582 ±  4%      +1.9%     135086        proc-vmstat.numa_other
   1186558           +18.1%    1400807           +19.5%    1417837            -0.3%    1182763            -0.5%    1180560        proc-vmstat.pgfault
     31861 ±  3%     +28.2%      40847           +31.7%      41945 ±  5%      -3.1%      30881 ±  3%      -1.7%      31316 ±  4%  proc-vmstat.pgreuse
     17.18 ±  3%    +337.2%      75.11 ±  2%    +318.3%      71.87 ±  5%      -1.3%      16.96 ±  4%      -0.0%      17.18 ±  3%  perf-stat.i.MPKI
 1.727e+10 ±  5%     -37.8%  1.073e+10 ±  2%     -41.2%  1.015e+10 ±  6%      +0.7%  1.738e+10 ±  3%      +1.7%  1.757e+10 ±  4%  perf-stat.i.branch-instructions
      0.12 ± 36%      +0.6        0.73 ±  5%      +0.7        0.79 ±  6%      +0.0        0.12 ± 27%      -0.0        0.11 ± 32%  perf-stat.i.branch-miss-rate%
  10351997 ± 16%     -28.0%    7451909 ± 13%     -29.7%    7276965 ± 16%     -10.0%    9315546 ± 22%      -7.3%    9592438 ± 25%  perf-stat.i.branch-misses
     94.27 ±  3%     -20.3       73.99 ±  2%     -19.2       75.03            -0.8       93.49 ±  3%      +0.3       94.60 ±  3%  perf-stat.i.cache-miss-rate%
   9.7e+08 ±  5%     -39.6%  5.859e+08 ±  2%     -42.8%  5.552e+08 ±  5%      +0.6%  9.759e+08 ±  3%      +1.6%  9.854e+08 ±  4%  perf-stat.i.cache-misses
 9.936e+08 ±  5%     -35.3%  6.431e+08 ±  2%     -38.8%  6.084e+08 ±  5%      +0.5%   9.99e+08 ±  3%      +1.5%  1.008e+09 ±  4%  perf-stat.i.cache-references
      2640 ±  3%    +180.7%       7410 ±  2%    +168.8%       7097 ±  4%      -0.0%       2640            -1.5%       2601 ±  5%  perf-stat.i.context-switches
      4.60 ±  2%     +22.2%       5.62           +18.1%       5.44 ±  5%      -1.0%       4.56 ±  2%      +0.5%       4.62        perf-stat.i.cpi
 2.888e+11 ±  5%     -47.9%  1.503e+11 ±  2%     -46.8%  1.538e+11 ±  2%      +0.6%  2.907e+11 ±  4%      +2.4%  2.956e+11 ±  3%  perf-stat.i.cpu-cycles
    214.97 ±  3%     +48.6%     319.40 ±  2%     +50.3%     323.15            +0.3%     215.56            +0.9%     216.91        perf-stat.i.cpu-migrations
   7.4e+10 ±  5%     -37.6%  4.618e+10 ±  2%     -41.0%  4.369e+10 ±  6%      +0.7%  7.449e+10 ±  3%      +1.7%  7.529e+10 ±  4%  perf-stat.i.instructions
      0.28 ±  7%     +33.6%       0.38 ±  3%     +31.5%       0.37 ±  2%      +0.0%       0.28 ±  6%      -2.7%       0.27 ±  5%  perf-stat.i.ipc
      6413 ±  4%     -21.5%       5037           -24.5%       4839 ±  5%      -0.2%       6397 ±  4%      +0.8%       6464 ±  2%  perf-stat.i.minor-faults
      6414 ±  4%     -21.5%       5038           -24.5%       4840 ±  5%      -0.3%       6398 ±  4%      +0.8%       6465 ±  2%  perf-stat.i.page-faults
     13.16            -4.0%      12.64            -3.9%      12.64            +0.0%      13.17            +0.1%      13.17        perf-stat.overall.MPKI
     97.57            -6.3       91.24            -6.1       91.44            +0.1       97.64            +0.1       97.67        perf-stat.overall.cache-miss-rate%
      3.91           -16.9%       3.25            -9.8%       3.53 ±  5%      -0.0%       3.91            +0.7%       3.94        perf-stat.overall.cpi
    296.89           -13.4%     257.07            -6.1%     278.90 ±  5%      -0.1%     296.69            +0.7%     298.84        perf-stat.overall.cycles-between-cache-misses
      0.26           +20.3%       0.31           +11.1%       0.28 ±  5%      +0.0%       0.26            -0.7%       0.25        perf-stat.overall.ipc
     10770            -2.2%      10537            -2.3%      10523            +0.2%      10788            +0.1%      10784        perf-stat.overall.path-length
   1.7e+10 ±  4%     -36.8%  1.074e+10 ±  2%     -39.8%  1.023e+10 ±  5%      +0.6%  1.711e+10 ±  3%      +1.6%  1.727e+10 ±  4%  perf-stat.ps.branch-instructions
  10207074 ± 15%     -27.2%    7428222 ± 13%     -29.6%    7182646 ± 16%      -9.7%    9221719 ± 22%      -6.6%    9530095 ± 25%  perf-stat.ps.branch-misses
 9.588e+08 ±  4%     -39.1%  5.838e+08           -42.0%  5.566e+08 ±  5%      +0.7%  9.651e+08 ±  3%      +1.6%  9.744e+08 ±  4%  perf-stat.ps.cache-misses
 9.826e+08 ±  4%     -34.9%  6.398e+08           -38.1%  6.087e+08 ±  5%      +0.6%  9.884e+08 ±  3%      +1.5%  9.975e+08 ±  4%  perf-stat.ps.cache-references
      2628 ±  3%    +176.7%       7271 ±  2%    +164.7%       6956 ±  4%      +0.3%       2635            -1.0%       2600 ±  5%  perf-stat.ps.context-switches
 2.847e+11 ±  4%     -47.3%  1.501e+11 ±  2%     -45.6%  1.548e+11 ±  2%      +0.6%  2.864e+11 ±  4%      +2.3%  2.911e+11 ±  3%  perf-stat.ps.cpu-cycles
    213.42 ±  3%     +47.5%     314.87 ±  2%     +49.2%     318.34            +0.5%     214.42            +1.3%     216.10        perf-stat.ps.cpu-migrations
 7.284e+10 ±  4%     -36.6%   4.62e+10 ±  2%     -39.6%  4.402e+10 ±  5%      +0.6%   7.33e+10 ±  3%      +1.6%  7.398e+10 ±  4%  perf-stat.ps.instructions
      6416 ±  3%     -22.4%       4976           -25.6%       4772 ±  5%      +0.2%       6426 ±  3%      +1.6%       6516 ±  2%  perf-stat.ps.minor-faults
      6417 ±  3%     -22.4%       4977           -25.6%       4774 ±  5%      +0.2%       6428 ±  3%      +1.6%       6517 ±  2%  perf-stat.ps.page-faults
 1.268e+13            -2.2%  1.241e+13            -2.3%  1.239e+13            +0.2%   1.27e+13            +0.1%   1.27e+13        perf-stat.total.instructions
   7783325 ± 13%     -22.8%    6008522 ± 10%     -20.8%    6163644 ± 20%     -13.8%    6708575 ± 22%      -4.5%    7429947 ± 26%  sched_debug.cfs_rq:/.avg_vruntime.avg
   8109328 ± 13%     -18.8%    6584206 ± 10%     -15.3%    6872509 ± 19%     -14.2%    6957983 ± 22%      -5.4%    7673718 ± 26%  sched_debug.cfs_rq:/.avg_vruntime.max
    244161 ± 30%     +28.2%     313090 ± 22%     +76.6%     431126 ± 21%     -23.5%     186903 ± 26%     -28.7%     173977 ± 29%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.66 ± 11%     -22.0%       0.52 ± 21%     -41.3%       0.39 ± 29%      -0.1%       0.66 ±  8%      -3.5%       0.64 ± 16%  sched_debug.cfs_rq:/.h_nr_running.avg
    495.88 ± 33%     -44.7%     274.12 ±  3%     -11.5%     438.85 ± 32%     -11.2%     440.30 ± 18%     -12.2%     435.24 ± 27%  sched_debug.cfs_rq:/.load_avg.max
     81.79 ± 28%     -33.2%      54.62 ± 16%     -15.5%      69.10 ± 26%      +7.2%      87.66 ± 23%      -8.4%      74.91 ± 38%  sched_debug.cfs_rq:/.load_avg.stddev
   7783325 ± 13%     -22.8%    6008522 ± 10%     -20.8%    6163644 ± 20%     -13.8%    6708575 ± 22%      -4.5%    7429947 ± 26%  sched_debug.cfs_rq:/.min_vruntime.avg
   8109328 ± 13%     -18.8%    6584206 ± 10%     -15.3%    6872509 ± 19%     -14.2%    6957983 ± 22%      -5.4%    7673718 ± 26%  sched_debug.cfs_rq:/.min_vruntime.max
    244161 ± 30%     +28.2%     313090 ± 22%     +76.6%     431126 ± 21%     -23.5%     186902 ± 26%     -28.7%     173977 ± 29%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.66 ± 11%     -22.3%       0.51 ± 21%     -41.5%       0.38 ± 29%      -0.4%       0.66 ±  8%      -3.8%       0.63 ± 16%  sched_debug.cfs_rq:/.nr_running.avg
    382.00 ± 36%     -44.2%     213.33 ±  8%     -23.3%     292.98 ± 42%      -2.3%     373.40 ± 18%      +4.0%     397.33 ± 20%  sched_debug.cfs_rq:/.removed.load_avg.max
    194.86 ± 36%     -44.3%     108.59 ±  8%     -24.0%     148.18 ± 40%      -2.4%     190.23 ± 18%      +3.7%     202.10 ± 20%  sched_debug.cfs_rq:/.removed.runnable_avg.max
    194.86 ± 36%     -44.3%     108.59 ±  8%     -24.0%     148.18 ± 40%      -2.4%     190.23 ± 18%      +3.7%     202.10 ± 20%  sched_debug.cfs_rq:/.removed.util_avg.max
    713.50 ± 11%     -22.6%     552.00 ± 20%     -39.7%     430.54 ± 26%      -0.2%     712.27 ±  7%      -3.0%     691.86 ± 14%  sched_debug.cfs_rq:/.runnable_avg.avg
      1348 ± 10%     -15.9%       1133 ± 15%     -20.9%       1067 ± 12%      +2.4%       1380 ±  8%      +5.1%       1417 ± 18%  sched_debug.cfs_rq:/.runnable_avg.max
    708.60 ± 11%     -22.6%     548.41 ± 20%     -39.6%     427.82 ± 26%      -0.1%     707.59 ±  7%      -3.1%     686.34 ± 14%  sched_debug.cfs_rq:/.util_avg.avg
      1119 ±  5%     -16.3%     937.08 ± 11%     -18.6%     910.83 ± 11%      +2.0%       1141 ±  6%      -0.1%       1117 ±  8%  sched_debug.cfs_rq:/.util_avg.max
    633.71 ± 11%     -95.7%      27.38 ± 17%     -96.7%      21.00 ± 19%      -0.6%     630.15 ± 10%      -3.6%     610.78 ± 17%  sched_debug.cfs_rq:/.util_est.avg
      1102 ± 18%     -63.9%     397.88 ± 15%     -67.5%     358.19 ±  8%      +6.1%       1169 ± 14%      +6.6%       1174 ± 24%  sched_debug.cfs_rq:/.util_est.max
    119.77 ± 55%     -64.5%      42.46 ± 12%     -67.8%      38.59 ± 12%      -3.2%     115.93 ± 51%     -12.3%     105.01 ± 70%  sched_debug.cfs_rq:/.util_est.stddev
    145182 ± 12%     -37.6%      90551 ± 11%     -29.5%     102317 ± 18%      -7.3%     134528 ± 10%     -17.2%     120251 ± 18%  sched_debug.cpu.avg_idle.stddev
    122256 ±  8%     +41.4%     172906 ±  7%     +38.2%     168929 ± 14%      -5.4%     115642 ±  6%      -1.3%     120639 ± 14%  sched_debug.cpu.clock.avg
    122268 ±  8%     +41.4%     172920 ±  7%     +38.2%     168942 ± 14%      -5.4%     115657 ±  6%      -1.3%     120655 ± 14%  sched_debug.cpu.clock.max
    122242 ±  8%     +41.4%     172892 ±  7%     +38.2%     168914 ± 14%      -5.4%     115627 ±  6%      -1.3%     120621 ± 14%  sched_debug.cpu.clock.min
    121865 ±  8%     +41.5%     172490 ±  7%     +38.3%     168517 ± 14%      -5.4%     115298 ±  6%      -1.3%     120268 ± 14%  sched_debug.cpu.clock_task.avg
    122030 ±  8%     +41.5%     172681 ±  7%     +38.3%     168714 ± 14%      -5.4%     115451 ±  6%      -1.3%     120421 ± 14%  sched_debug.cpu.clock_task.max
    112808 ±  8%     +44.2%     162675 ±  7%     +41.0%     159006 ± 15%      -5.5%     106630 ±  7%      -1.1%     111604 ± 15%  sched_debug.cpu.clock_task.min
      5671 ±  6%     +24.6%       7069 ±  4%     +24.0%       7034 ±  8%      -7.2%       5261 ±  7%      -3.5%       5471 ± 10%  sched_debug.cpu.curr->pid.max
      0.00 ± 12%     +22.5%       0.00 ± 50%     +17.7%       0.00 ± 42%     +71.0%       0.00 ± 35%     +59.0%       0.00 ± 43%  sched_debug.cpu.next_balance.stddev
      0.66 ± 11%     -22.0%       0.51 ± 21%     -41.4%       0.39 ± 29%      -0.3%       0.66 ±  8%      -3.6%       0.64 ± 16%  sched_debug.cpu.nr_running.avg
      2659 ± 12%    +208.6%       8204 ±  7%    +192.0%       7763 ± 14%     -10.1%       2391 ± 11%      -6.2%       2493 ± 15%  sched_debug.cpu.nr_switches.avg
    679.31 ± 10%    +516.8%       4189 ± 14%    +401.6%       3407 ± 24%     -14.7%     579.50 ± 19%      -6.8%     633.18 ± 25%  sched_debug.cpu.nr_switches.min
      0.00 ±  9%  +12202.6%       0.31 ± 42%  +12627.8%       0.32 ± 37%     +67.0%       0.00 ± 50%     -34.8%       0.00 ± 72%  sched_debug.cpu.nr_uninterruptible.avg
    122243 ±  8%     +41.4%     172893 ±  7%     +38.2%     168916 ± 14%      -5.4%     115628 ±  6%      -1.3%     120623 ± 14%  sched_debug.cpu_clk
    120996 ±  8%     +41.9%     171660 ±  7%     +38.6%     167751 ± 15%      -5.4%     114462 ±  6%      -1.3%     119457 ± 14%  sched_debug.ktime
    123137 ±  8%     +41.1%     173805 ±  7%     +37.9%     169767 ± 14%      -5.4%     116479 ±  6%      -1.4%     121452 ± 13%  sched_debug.sched_clk


> 
> I spotted something else worth optimizing last time, and with the
> patch attached, I was able to measure some significant improvements in
> 1GB hugeTLB allocation and free time, e.g., when allocating and free
> 700 1GB hugeTLB pages:
> 
> Before:
>   # time echo 700 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>   real  0m13.500s
>   user  0m0.000s
>   sys   0m13.311s
> 
>   # time echo 0 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>   real  0m11.269s
>   user  0m0.000s
>   sys   0m11.187s
> 
> 
> After:
>   # time echo 700 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>   real  0m10.643s
>   user  0m0.001s
>   sys   0m10.487s
> 
>   # time echo 0 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>   real  0m1.541s
>   user  0m0.000s
>   sys   0m1.528s
> 
> Thanks!



