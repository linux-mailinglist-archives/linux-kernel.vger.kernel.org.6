Return-Path: <linux-kernel+bounces-305557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDB8963075
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A1A28235F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257581AAE04;
	Wed, 28 Aug 2024 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6Nn0W2Q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A0B157E82
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724871052; cv=fail; b=PEvH77ew+wHWNSthiqVKoHv/hZ5eDUf2Tw1vL+SH4eqeDiFiLEYQbQgzciiW7lbPXLek8T9kVaeRIB2HhehAONt2+ESb6RWimfMlj06WyRThbdPRTvWngCDhcJzITJXjpmEKC3XKRawzZGOsVUzWQT+NUAM9dZ8kUkYv+PRXBIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724871052; c=relaxed/simple;
	bh=Nq2AOHzaU6nFhzO11crGNv/DqKYT7ESX5d/Wuy5+Fyg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ejbhY9lO+LWMjXV4Q+EwnGDPta8pGnv16wyrqDgg2P9uBeJsvaS1g2ZbA/BPxjUYWqkAAaIbA9/azPl1+pGfwE728fR+RTB1dIOyFFvOtkD4gd+nqrtR9CO7zmMCMlx/p6PWsKDeHn+LG6ijaPj0ydYC/Dn4syjh1SSkcq5c8eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6Nn0W2Q; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724871051; x=1756407051;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Nq2AOHzaU6nFhzO11crGNv/DqKYT7ESX5d/Wuy5+Fyg=;
  b=j6Nn0W2QrjKJ31w0Ftb6Id3pJvq9EfhmRBOAHQQCuvo1tI3EwzwVBz5z
   2OE2zYPxMLlElc4Ml/6vB3lQy+b0G6DMpf/ylOBOkNOnKsPvMOAbrAkeO
   DQBPPHbiQIAStk+sGf0rN1qd8xsgu4va8MGEtQF7Ihi23hur4qGkAMeBx
   uIhwIxehtCNx6uZVALuiKovMCHEj+1PGrXHlaCcdXsLTHO6F7bb21cAF0
   9IMGrnrtNRSwxR03VMtykikbxarIu1d7wjqa772TrY9+5kNPc1rWQ6yU2
   ADKRwDU6Y2XNigSVUTsuA4mSvGjV/8vA/EE9Q/Q9LFOR+1j8JmgCFUKGQ
   Q==;
X-CSE-ConnectionGUID: vtbLTidJT7mBq2Pae+1mLA==
X-CSE-MsgGUID: 2E89ExytQeOtWe8+jPY21w==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23005211"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="23005211"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 11:50:50 -0700
X-CSE-ConnectionGUID: ijWUHFkzQrCTxxekYDWr+g==
X-CSE-MsgGUID: LZHsMRdXQKqBz2eZj0llkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="100822168"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 11:50:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 11:50:49 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 11:50:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 11:50:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 11:50:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHLTN4iyfiheD5TntOEJozyPXVQ3Ea4BpCCE3dzwCzgajx7AjFG2sBGebqMg82d5Nh2T8Z84cFBuBEnZtnf4zBcwRQE1ZrMEMunCly1CMXQgaIB0hTsvK8RGrEl4nMxqHSE/yF6ET6sqk9zpfVFhKqXVu8wcXDy9Py1BMHZE9Hpi3WvPi9OADMXNfxBTOLh4z1XUlKHgiOEdLjMnx1ZimpWnf6VqQAbyMmjPCs0bbrOuID2RA13WYozqHJsKGANH15e4PkzzYAuRWchXdegZewVv2Iuk/Lx0vMv1nBbfPOP/sbKPOm1IScjg0RkhuSABdbkeL2MCbTC4vJRrUFM90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nq2AOHzaU6nFhzO11crGNv/DqKYT7ESX5d/Wuy5+Fyg=;
 b=G6MB0DMR6fSfpGwtf25MDpKydoItfyvoG1bvx51WBTKN1iD3w9+VEhZehgdKL2IatY0AvFiWlb7m7dG050lzVe7nhvZEXl3kV+0O+01P9UlNUWRU8e5P27GPEce4jxhGiFpvGHNl2qsqDYSxNV6SmsIEW9INDr7tigdQjW2iDCMNRXtbllBJ3UL3nzeY3DU2noMvAs7mQC4cbfPg9D5XliauDbcfEhDoPp7Ie0HF+x+cgTvr31F/4Hrc8Vv+/aHcw+s5pIFJI5giV6waNvce+Cau9jduzr6ImYkPN13pBBto8wrbZR8VjvnxfCUZ7od5XgJ8411rR4nJvKB8oQMWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 18:50:46 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 18:50:46 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: Nhat Pham <nphamcs@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali,
 Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa8d3OD+uOh/WK5kyI6A6kVnXGhrIxzReAgABJIZCAA+ChsIADqWIAgABIr/CAAV2VgIAALnjAgADdOKCAAAYagIAApBhg
Date: Wed, 28 Aug 2024 18:50:46 +0000
Message-ID: <SJ0PR11MB56788C517A01B83174591A45C9952@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=OO6frFa+S3xjtoabB2dY1Y5RN5qjMsVUsgKDK_QuOFzg@mail.gmail.com>
 <SJ0PR11MB5678288EE890E8CB882839CDC98E2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <SJ0PR11MB567801EE747E2810EF183C73C9892@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=PYv4Cn_a7WSnbUyhwSBO61xoDPSexXxS0uwwxu5P6XLw@mail.gmail.com>
 <SJ0PR11MB5678E44062CADBE8BAB546F3C9942@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=ORuJabxQSehU5E0QNG=Gx6QkyTCb1vek3AOcQuvF54Xg@mail.gmail.com>
 <DM8PR11MB5671D72CED6850CDBB62B95FC9942@DM8PR11MB5671.namprd11.prod.outlook.com>
 <SJ0PR11MB567807116A760D785F9822EBC9952@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkb0Lnq+mrFtpba80ck76BF2Hnc9Rn8OVs_7dqmE2Hww2w@mail.gmail.com>
In-Reply-To: <CAJD7tkb0Lnq+mrFtpba80ck76BF2Hnc9Rn8OVs_7dqmE2Hww2w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|DS0PR11MB7880:EE_
x-ms-office365-filtering-correlation-id: 80894f33-261e-4356-4351-08dcc79253f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TVd6OFlKVTRndTU4Y2Y3aTVjR3Z0eGp3QUhtYnQyTTNzUG5oMG1oc291eCth?=
 =?utf-8?B?ZGFhdC94OFplYlRIZFlVNjEvdXVYYUpaNFBOS1RNeHNVYVoxUGtUV3lZMXVq?=
 =?utf-8?B?WnJ4Ny9zQnBmZklEWFN2enkvRDdVOTQyY1V2R3QwbDBBL001cXNSN3Vtb0Vt?=
 =?utf-8?B?TUxyWTZXMWxmQmRVNkt1amw1UmZXekw0dmE5ZHBRaU9SMHRwQkd1YTBaV1RV?=
 =?utf-8?B?OFlTZ0lHejhNdWs3VFdXZUtNU2EzOEhJalZ6NkNxVzgvRk56alRRbHZQK2VW?=
 =?utf-8?B?WGU4RUkycDd4aEx5SDdZM0VmMUI1NHZlcGpYNVZ4TkRNR1RMLzlNZ3M1bnNF?=
 =?utf-8?B?WGFZWWprQUsycWQ5OElMQnc2RUh0UFBlN0RNMjlmUVdLUTlZVkZoWStmVXdl?=
 =?utf-8?B?b0VFSGx5RWo0a2ppdlVpWHZEaXVQNHFTK0J3WGFMblRURVZyc0YvQU1ubmNH?=
 =?utf-8?B?NVdZOGpwTEZWRGljNCtJVVhNVVRmL3ZZT1dhckg2TDEvR3lZZ0g5bldTWUFH?=
 =?utf-8?B?aVh3ZEdwR1cyYndKUmNncm5zSGcwVmtGTDhRNjU4aUZmU3FPM2tUUDF5Y2p4?=
 =?utf-8?B?ZUlkeVF6UFZ5ZThBWmFEVGYwaW9YYXhiVkRlL3o0TEFFcVFJUWx2YTY0eTNH?=
 =?utf-8?B?NGowYkUrZGlnMEZWamk3WVBWTVZISjl1dFRTNURCZUtncHZ2MWJIVUd6ZXhF?=
 =?utf-8?B?c0Z5T3d3SThrdTBadHdxeko3ZzBZT2pia2hieVRQSzZxYzR1eHlYR2hVc0ha?=
 =?utf-8?B?U1JQRHQ5bU83bG5Sb2dUaFV6eVFHeldvUmU5MWo3R3JZeWhjTVMvVDFaUXVD?=
 =?utf-8?B?cTA0dFdEK095U3VIV1NSWTExMWVjOE1GeGI3R0k2QUhNUzJzalBEMGlkVE9S?=
 =?utf-8?B?cC9jdlZGc2czZjB4WldjMDcvZUVLUGNXSHNVZEIrYWdqNktNcHRsTWk0UlRP?=
 =?utf-8?B?RGRFTkUxY25uSmNMVFA0VWlPUFM4T2k3K0NJV1FaVHI0RzMyYVpxNFJuMExo?=
 =?utf-8?B?V3JwdGVJeXpuQjBNTHZjYXBFNXp2eGQxNGZtNFljMmsxbEgyRzlXVHlwbnNs?=
 =?utf-8?B?cmRZZExBRFNhMjdBNTR1SnFKUHdKTFNvNUpwOTBjdnB0dzJ2SUxxc3JPelNU?=
 =?utf-8?B?a2g1V29QUkdjMnZvREhYSFNaVGx6R0hoKzZFOVlrdldvckkyWE1DSDdRL0RU?=
 =?utf-8?B?VkpsUm5DUW5TWTNkTDQ5ZkIzVWFKTitiOS9iUGQyUXBxNGR1Y3RPQkppNkFx?=
 =?utf-8?B?KzlRQ2EwOFB5RDFuQmNZamlwVWdUMGZyYW5kcHVIejJDb2x6cUVUKzlDRTNt?=
 =?utf-8?B?a2dNMFRFM3lTcEx6S29XbkdhN2w0enkwSDJuNTB5UnhIaWZFTEZaaFVZTHRQ?=
 =?utf-8?B?RllJbG1nM3dEeWYyai9DVWdiWjV3cGczNUFBZ2RyNlB5dmdLZ0VzNkRLQWlx?=
 =?utf-8?B?OXhpTmJVWER4T1Jvd2dKWnY3TUhoL2lNMmtxdEFiWEJvb3dFRkhnZkNjdGdE?=
 =?utf-8?B?emhZVHlxWVYxTVdKb1pxRVBXY1BkbHhnem9rYVlEUlN2TzdyUW9HV0xKOHZy?=
 =?utf-8?B?a3lWdFA1UlM2QVo5UDYwZUc0S0pRLzdDeXlKV1RDZDBVdlI4dEplUjlrRUcx?=
 =?utf-8?B?WWRwdmFOaG9yY2VHVm1lMUV6YTVETVBCMUZWeldKc3BaUGlHK1Z5dTFRZlJw?=
 =?utf-8?B?cENEcSs4QXJFTnM1a0U3N3p5UEJyZVppQ0FBR2N1clhXa0NhQ09tRzlpa0lD?=
 =?utf-8?B?MXRFckhjYnhSa0krRnFWcTkzaTNNZ3B3MU43NldSQndCM3g4djg3dDlaNVVw?=
 =?utf-8?B?KzIyMjRobnQvQit1ZFAxbTlIeFFIcVRoK1F0Um9Ka0c5a3V0U1ZlcmRuSVNB?=
 =?utf-8?B?d0o2dmNCbFU1ZmFVaTdMRnlLZEZjSVQrQyt5TjZQUzlwenc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmVuRmtoZnNDMGo3cElCS2JCWmplSnlFSEc0S2JIY3diRy9VN0NZYW9xRCti?=
 =?utf-8?B?WFNidjNqQ3YxUUdoNWEwV1lvL3h4dnJkZHE1dkxmelpoS01tc1ZKRTFZcExJ?=
 =?utf-8?B?N2FaZVorVWxIaStEUWhXVEs2cTdxaXZWaEpnbXBzbm1wRmYvT2hWL1VDZXFy?=
 =?utf-8?B?UjdHK3k5WFdDWHYwNllUOGRTWnd4RzJ3NDBJZ2ZqMWdqNHFXd3I2Tmx3dHJU?=
 =?utf-8?B?VGFXWVJvVXVuemJHaGF3R3l2QW1LN215Ym9sVkVQdHNiaXE5cTY3YzQ5UXNr?=
 =?utf-8?B?aTg1STNReXBxbVVpRFdDb1FuT2NaY1R2Mm5qMmtmdmw4a2tKRTJzTVBhTy8r?=
 =?utf-8?B?SHU1MEs2c0ZKenJnT1A3dVVQN2JEK04vekR2bjNKbjBsenkzaXdjVkx3OFBu?=
 =?utf-8?B?VmhzbWJrSTlSWVdOZk1YbDBRemEzNUZiUGRPVkx1SjdiakRlQnVuQkdwbXhJ?=
 =?utf-8?B?aEZWNS9qL0ZidlVUODhKK3dCTXBXWDZNamVyaWxYaXQyTUQyZjRGZ3ErR2d1?=
 =?utf-8?B?ME9oaXZiNmJ2WTRmSkpyektqbkxMRWl0U280WG1BZlNZajYrbjh1TXNTMmIy?=
 =?utf-8?B?L2xDaGpLN0IvSHpqM3NhSkNXR0xRK1MrQThMRnV5Z0QzdnVVS0gwSGMrOWpJ?=
 =?utf-8?B?SHdmc2JNQkJaUkNaTFpwZmZXVTJlVW9FbnpoNk1rTmZOZlZFWVBUZW8xWm56?=
 =?utf-8?B?TjdTRWdHbmEzUWZjcE9BQWUwL2ZPQmg1UzBhSE1IQzBHVXJ4Z3ZZSW1LOElB?=
 =?utf-8?B?SkFITWQ2Y1FlMit4Z0JoR2JvVklkR25WNCswcXNaci83OU05dWdKalZoTE1H?=
 =?utf-8?B?bXZ4NEZMU2ZCYnNxZSt3MmpmTERtVDk0cGpyeFkzK2xHZG5Pd29XcEN3Q0xX?=
 =?utf-8?B?d0JXWUQ4RGw2T21FTkZlbHV6QWtYVjByb3dmVGdzNk9zcWkzQUw2Wkx6azNt?=
 =?utf-8?B?WGt2UUw1U0pkVmtXZGo2b240MVcxcHlTVkppdnp1L0paRzNCdDhJbGs1bk1Z?=
 =?utf-8?B?UFptdEZPek02bWs1MTNuQTdwSGZwTTNMUHZpTDFPSnA2T0N2Qm9acXFPQkh1?=
 =?utf-8?B?M2xhdXNyVGtzckJXSFhhMGZ4Z0NTYk1va3N5cTdUR1VyYUZLa1Bra0FybHZY?=
 =?utf-8?B?QVlJUFA5VjcvV0F6WkQrSVRQSVBtbk5Kc2J6aXN1bXN4THFOa1VPdnh2eW1k?=
 =?utf-8?B?dDNyOU5HbmdXVm52ODV2bHhOQUFRNW9BVVg0b2p3OUxVNnhhVjhCZmhHVVFh?=
 =?utf-8?B?WDF5QlBWckp2UG03T1I3WVFRbUxVOXFrYmZ6c2E3VzlhRU04RkpsaFZPSGMx?=
 =?utf-8?B?Z2dpTkFoNy9VSUtaL0dxNE5sSnU0QzdFM1VuVlVYeXZMR1dpNi9Fc3ZaOFR4?=
 =?utf-8?B?S2hDUENnOGZvdVJvQW9XQU1nLzVDZHdlMS8zNGhZSTkwaitkQXJHMWpVdUFK?=
 =?utf-8?B?UUF1NWpVNURLL1RvNDZYZGdSd3dqNS9KcVhUMXkwQWt0MmdLYmNaT1BOcFZw?=
 =?utf-8?B?TjlhRGpybmlNNGtmbTN6dUhTUFZMc2RpZllhQXRDcmhYMEpmcUtzbERIeDd6?=
 =?utf-8?B?YVF2MENkMEZvdytVUnpDTktxaEtmK0xmY2pSYmJYUjduQjJhZ1ZPOXJobFFN?=
 =?utf-8?B?aHlWbDRVRHFGZXFGVEVJVUtrdmJUTnJUTW5rMTU4YXRvN21MOG1IZjBtRjBG?=
 =?utf-8?B?bldGNHFBYXhyL1BUa1lnNWZObGthYXZiWVlyWFdRQVNsUXQzWEVPY3JUR3dB?=
 =?utf-8?B?NExWUWRPNHMrUGgyeU9MMEVKeG1kRFEzTHJQbDJQVGNCWGllazlhaFB1UU13?=
 =?utf-8?B?ZGhpWC90U1FjT1VQbkRkVVVnRHZEZTN0S2poV1pmaERZMjhHcFZmcXpYd3J3?=
 =?utf-8?B?cFhkSDNhVEgvZnl1dlhBRTk0aTkrRHp2Y05zV3BTcFNUTUVjYjY5TGp6NXFG?=
 =?utf-8?B?cG9FZWMyNUxNVWw0VzhWcGVCZ3BDWmJiaVl5eWhadGNzR1lWUkxkczlBWDZ0?=
 =?utf-8?B?ZWxIMGNjYlBlTHVpUGhmUE1VR05BSTNlYkI2Q0FLdkIxaC9UcVZPQ096TUxs?=
 =?utf-8?B?YmppVGVqN2p4K25rbENxa3J1M3V5cUtIbm5tc05zcmRIUXdzNUlGalRFb1Iy?=
 =?utf-8?B?MGV3S2FvYm1wb1JwYzJoaGE3N1RCRVZHYWpoWkd4cUxrLzc5bHFHQmpjL1Q4?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80894f33-261e-4356-4351-08dcc79253f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 18:50:46.7215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qPoC7Dmgt4gpBVM8swHUG0UK/8U0D7HsFtHBloN9copM1nRKhpqqstQQKM7xpb82p4c9+m0rtSHIXf9TjhnpaRLhO18gYOWRHjxbjdP8PoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7880
X-OriginatorOrg: intel.com

SGkgWW9zcnksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWW9zcnkg
QWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3Qg
MjgsIDIwMjQgMTI6NDQgQU0NCj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAu
c3JpZGhhckBpbnRlbC5jb20+DQo+IENjOiBOaGF0IFBoYW0gPG5waGFtY3NAZ21haWwuY29tPjsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IG1tQGt2YWNrLm9yZzsgaGFu
bmVzQGNtcHhjaGcub3JnOyByeWFuLnJvYmVydHNAYXJtLmNvbTsgSHVhbmcsIFlpbmcNCj4gPHlp
bmcuaHVhbmdAaW50ZWwuY29tPjsgMjFjbmJhb0BnbWFpbC5jb207IGFrcG1AbGludXgtZm91bmRh
dGlvbi5vcmc7DQo+IFpvdSwgTmFuaGFpIDxuYW5oYWkuem91QGludGVsLmNvbT47IEZlZ2hhbGks
IFdhamRpIEsNCj4gPHdhamRpLmsuZmVnaGFsaUBpbnRlbC5jb20+OyBHb3BhbCwgVmlub2RoIDx2
aW5vZGguZ29wYWxAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAvNF0gbW06
IFpTV0FQIHN3YXAtb3V0IG9mIG1USFAgZm9saW9zDQo+IA0KPiBbLi5dDQo+ID4NCj4gPiBUaGlz
IHNob3dzIHRoYXQgaW4gYWxsIGNhc2VzLCByZWNsYWltX2hpZ2goKSBpcyBjYWxsZWQgb25seSBm
cm9tIHRoZSByZXR1cm4NCj4gPiBwYXRoIHRvIHVzZXIgbW9kZSBhZnRlciBoYW5kbGluZyBhIHBh
Z2UtZmF1bHQuDQo+IA0KPiBJIGFtIHNvcnJ5IEkgaGF2ZW4ndCBiZWVuIGtlZXBpbmcgdXAgd2l0
aCB0aGlzIHRocmVhZCwgSSBkb24ndCBoYXZlIGENCj4gbG90IG9mIGNhcGFjaXR5IHJpZ2h0IG5v
dy4NCj4gDQo+IElmIG15IHVuZGVyc3RhbmRpbmcgaXMgY29ycmVjdCwgdGhlIHN1bW1hcnkgb2Yg
dGhlIHByb2JsZW0gd2UgYXJlDQo+IG9ic2VydmluZyBoZXJlIGlzIHRoYXQgd2l0aCBoaWdoIGNv
bmN1cnJlbmN5ICg3MCBwcm9jZXNzZXMpLCB3ZQ0KPiBvYnNlcnZlIHdvcnNlIHN5c3RlbSB0aW1l
LCB3b3JzZSB0aHJvdWdocHV0LCBhbmQgaGlnaGVyIG1lbW9yeV9oaWdoDQo+IGV2ZW50cyB3aXRo
IHpzd2FwIHRoYW4gU1NEIHN3YXAuIFRoaXMgaXMgdHJ1ZSAod2l0aCB2YXJ5aW5nIGRlZ3JlZXMp
DQo+IGZvciA0SyBvciBtVEhQLCBhbmQgd2l0aCBvciB3aXRob3V0IGNoYXJnaW5nIHpzd2FwIGNv
bXByZXNzZWQgbWVtb3J5Lg0KPiANCj4gRGlkIEkgZ2V0IHRoYXQgcmlnaHQ/DQoNClRoYW5rcyBm
b3IgeW91ciByZXZpZXcgYW5kIGNvbW1lbnRzISBZZXMsIHRoaXMgaXMgY29ycmVjdC4NCg0KPiAN
Cj4gSSBzYXcgeW91IGFsc28gbWVudGlvbmVkIHRoYXQgcmVjbGFpbSBsYXRlbmN5IGlzIGRpcmVj
dGx5IGNvcnJlbGF0ZWQNCj4gdG8gaGlnaGVyIG1lbW9yeV9oaWdoIGV2ZW50cy4NCg0KVGhhdCB3
YXMgbXkgb2JzZXJ2YXRpb24gYmFzZWQgb24gdGhlIHN3YXAtY29uc3RyYWluZWQgZXhwZXJpbWVu
dHMgd2l0aCA0RyBTU0QuDQpXaXRoIGEgZmFzdGVyIGNvbXByZXNzb3IsIHdlIGFsbG93IGFsbG9j
YXRpb25zIHRvIHByb2NlZWQgcXVpY2tseSwgYW5kIGlmIHRoZSBwYWdlcw0KYXJlIG5vdCBiZWlu
ZyBmYXVsdGVkIGluLCB3ZSBuZWVkIG1vcmUgc3dhcCBzbG90cy4gVGhpcyBpbmNyZWFzZXMgdGhl
IHByb2JhYmlsaXR5IG9mDQpydW5uaW5nIG91dCBvZiBzd2FwIHNsb3RzIHdpdGggdGhlIDRHIFNT
RCBiYWNraW5nIGRldmljZSwgd2hpY2gsIGFzIHRoZSBkYXRhIGluIHY0DQpzaG93cywgY2F1c2Vz
IG1lbWNnX3N3YXBfZmFpbCBldmVudHMsIHRoYXQgZHJpdmUgZm9saW9zIHRvIGJlIHJlc2lkZW50
IGluIG1lbW9yeQ0KKHRyaWdnZXJpbmcgbWVtY2dfaGlnaCBicmVhY2hlcyBhcyBhbGxvY2F0aW9u
cyBwcm9jZWVkIGV2ZW4gd2l0aG91dCB6c3dhcCBjZ3JvdXANCmNoYXJnaW5nKS4NCg0KVGhpbmdz
IGNoYW5nZSB3aGVuIHRoZSBleHBlcmltZW50cyBhcmUgcnVuIGluIGEgc2l0dWF0aW9uIHdoZXJl
IHRoZXJlIGlzIGFidW5kYW50DQpzd2FwIHNwYWNlIGFuZCB3aGVuIHRoZSBkZWZhdWx0IGJlaGF2
aW9yIG9mIHpzd2FwIGNvbXByZXNzZWQgZGF0YSBiZWluZyBjaGFyZ2VkDQp0byB0aGUgY2dyb3Vw
IGlzIGVuYWJsZWQsIGFzIGluIHRoZSBkYXRhIHdpdGggMTc2R2lCIFpSQU0gYXMgWlNXQVAncyBi
YWNraW5nDQpzd2FwZmlsZSBwb3N0ZWQgaW4gdjUuIE5vdywgdGhlIGNyaXRpY2FsIHBhdGggdG8g
d29ya2xvYWQgcGVyZm9ybWFuY2UgY2hhbmdlcyB0bw0KY29uY3VycmVudCByZWNsYWltcyBpbiBy
ZXNwb25zZSB0byBtZW1jZ19oaWdoIGV2ZW50cyBkdWUgdG8gYWxsb2NhdGlvbiBhbmQgenN3YXAN
CnVzYWdlLiBXZSBzZWUgYSBsZXNzZXIgaW5jcmVhc2UgaW4gc3dhcG91dCBhY3Rpdml0eSAoYXMg
Y29tcGFyZWQgdG8gdGhlIHN3YXAtY29uc3RyYWluZWQNCmV4cGVyaW1lbnRzIGluIHY0KSwgYW5k
IGNvbXByZXNzIGxhdGVuY3kgc2VlbXMgdG8gYmVjb21lIHRoZSBib3R0bGVuZWNrLiBFYWNoDQpp
bmRpdmlkdWFsIHByb2Nlc3MncyB0aHJvdWdocHV0L3N5cyB0aW1lIGRlZ3JhZGVzIG1haW5seSBh
cyBhIGZ1bmN0aW9uIG9mIGNvbXByZXNzDQpsYXRlbmN5LiBBbnl3YXksIHRoZXNlIHdlcmUgc29t
ZSBvZiBteSBsZWFybmluZ3MgZnJvbSB0aGVzZSBleHBlcmltZW50cy4gUGxlYXNlDQpkbyBsZXQg
bWUga25vdyBpZiB0aGVyZSBhcmUgb3RoZXIgaW5zaWdodHMvYW5hbHlzaXMgSSBjb3VsZCBiZSBt
aXNzaW5nLg0KDQo+IA0KPiBJcyBpdCBwb3NzaWJsZSB0aGF0IHdpdGggU1NEIHN3YXAsIGJlY2F1
c2Ugd2Ugd2FpdCBmb3IgSU8gZHVyaW5nDQo+IHJlY2xhaW0sIHRoaXMgZ2l2ZXMgYSBjaGFuY2Ug
Zm9yIG90aGVyIHByb2Nlc3NlcyB0byBhbGxvY2F0ZSBhbmQgZnJlZQ0KPiB0aGUgbWVtb3J5IHRo
ZXkgbmVlZC4gV2hpbGUgd2l0aCB6c3dhcCBiZWNhdXNlIGV2ZXJ5dGhpbmcgaXMNCj4gc3luY2hy
b25vdXMsIGFsbCBwcm9jZXNzZXMgYXJlIHRyeWluZyB0byBhbGxvY2F0ZSB0aGVpciBtZW1vcnkg
YXQgdGhlDQo+IHNhbWUgdGltZSByZXN1bHRpbmcgaW4gaGlnaGVyIHJlY2xhaW0gcmF0ZXM/DQo+
IA0KPiBJT1csIG1heWJlIHdpdGggenN3YXAgYWxsIHRoZSBwcm9jZXNzZXMgdHJ5IHRvIGFsbG9j
YXRlIHRoZWlyIG1lbW9yeQ0KPiBhdCB0aGUgc2FtZSB0aW1lLCBzbyB0aGUgdG90YWwgYW1vdW50
IG9mIG1lbW9yeSBuZWVkZWQgYXQgYW55IGdpdmVuDQo+IGluc3RhbmNlIGlzIG11Y2ggaGlnaGVy
IHRoYW4gbWVtb3J5LmhpZ2gsIHNvIHdlIGtlZXAgcHJvZHVjaW5nDQo+IG1lbW9yeV9oaWdoIGV2
ZW50cyBhbmQgcmVjbGFpbWluZy4gSWYgNzAgcHJvY2Vzc2VzIGFsbCByZXF1aXJlIDFHIGF0DQo+
IHRoZSBzYW1lIHRpbWUsIHRoZW4gd2UgbmVlZCA3MEcgb2YgbWVtb3J5IGF0IG9uY2UsIHdlIHdp
bGwga2VlcA0KPiB0aHJhc2hpbmcgcGFnZXMgaW4vb3V0IG9mIHpzd2FwLg0KPiANCj4gV2hpbGUg
d2l0aCBTU0Qgc3dhcCwgZHVlIHRvIHRoZSB3YWl0cyBpbXBvc2VkIGJ5IElPLCB0aGUgYWxsb2Nh
dGlvbnMNCj4gYXJlIG1vcmUgc3ByZWFkIG91dCBhbmQgbW9yZSBzZXJpYWxpemVkLCBhbmQgdGhl
IGFtb3VudCBvZiBtZW1vcnkNCj4gbmVlZGVkIGF0IGFueSBnaXZlbiBpbnN0YW5jZSBpcyBsb3dl
cjsgcmVzdWx0aW5nIGluIGxlc3MgcmVjbGFpbQ0KPiBhY3Rpdml0eSBhbmQgdWx0aW1hdGVseSBm
YXN0ZXIgb3ZlcmFsbCBleGVjdXRpb24/DQoNClRoaXMgaXMgYSB2ZXJ5IGludGVyZXN0aW5nIGh5
cG90aGVzaXMsIHRoYXQgaXMgYWxvbmcgdGhlIGxpbmVzIG9mIHRoZQ0KInNsb3dlciBjb21wcmVz
c29yIiBlc3NlbnRpYWxseSBjYXVzaW5nIGFsbG9jYXRpb24gc3RhbGxzIChhbmQgYnVmZmVyaW5n
IHVzIGZyb20NCnRoZSBzd2FwIHNsb3RzIHVuYXZhaWxhYmlsaXR5IGVmZmVjdCkgb2JzZXJ2YXRp
b24gSSBnYXRoZXJlZCBmcm9tIHRoZSA0RyBTU0QNCmV4cGVyaW1lbnRzLiBJIHRoaW5rIHRoaXMg
aXMgYSBwb3NzaWJpbGl0eS4NCg0KPiANCj4gQ291bGQgeW91IHBsZWFzZSBkZXNjcmliZSB3aGF0
IHRoZSBwcm9jZXNzZXMgYXJlIGRvaW5nPyBBcmUgdGhleQ0KPiBhbGxvY2F0aW5nIG1lbW9yeSBh
bmQgaG9sZGluZyBvbiB0byBpdCwgb3IgaW1tZWRpYXRlbHkgZnJlZWluZyBpdD8NCg0KSSBoYXZl
IGJlZW4gdXNpbmcgdGhlIHZtLXNjYWxhYmlsaXR5IHVzZW1lbSB3b3JrbG9hZCBmb3IgdGhlc2Ug
ZXhwZXJpbWVudHMuDQpUaGFua3MgWWluZyBmb3Igc3VnZ2VzdGluZyBJIHVzZSB0aGlzIHdvcmts
b2FkIQ0KDQpJIGFtIHJ1bm5pbmcgdXNlbWVtIHdpdGggdGhlc2UgY29uZmlnIG9wdGlvbnM6IHVz
ZW1lbSAtLWluaXQtdGltZSAtdyAtTyAtbiA3MCAxZy4NClRoaXMgZm9ya3MgNzAgcHJvY2Vzc2Vz
LCBlYWNoIG9mIHdoaWNoIGRvZXMgdGhlIGZvbGxvd2luZzoNCg0KMSkgQWxsb2NhdGVzIDFHIG1t
YXAgdmlydHVhbCBtZW1vcnkgd2l0aCBNQVBfQU5PTllNT1VTLCByZWFkL3dyaXRlIHBlcm1pc3Np
b25zLg0KMikgU3RlcHMgdGhyb3VnaCBhbmQgYWNjZXNzZXMgZWFjaCA4IGJ5dGVzIGNodW5rIG9m
IG1lbW9yeSBpbiB0aGUgbW1hcC1lZCByZWdpb24sIGFuZDoNCiAgICAyLmEpIFdyaXRlcyB0aGUg
aW5kZXggb2YgdGhhdCBjaHVuayB0byB0aGUgKHVuc2lnbmVkIGxvbmcgKikgbWVtb3J5IGF0IHRo
YXQgaW5kZXguDQozKSBHZW5lcmF0ZXMgc3RhdGlzdGljcyBvbiB0aHJvdWdocHV0Lg0KDQpUaGVy
ZSBpcyBhbiAibXVubWFwKCkiIGFmdGVyIHN0ZXAgKDIuYSkgdGhhdCBJIGhhdmUgY29tbWVudGVk
IG91dCBiZWNhdXNlIEkgd2FudGVkIHRvDQpzZWUgaG93IG11Y2ggY29sZCBtZW1vcnkgcmVzaWRl
cyBpbiB0aGUgenN3YXAgenBvb2wgYWZ0ZXIgdGhlIHdvcmtsb2FkIGV4aXRzLiBJbnRlcmVzdGlu
Z2x5LA0KdGhpcyB3YXMgMCBmb3IgNjRLIG1USFAsIGJ1dCBvZiB0aGUgb3JkZXIgb2Ygc2V2ZXJh
bCBodW5kcmVkcyBvZiBNQiBmb3IgMk0gVEhQLg0KDQo+IA0KPiBEbyB5b3UgaGF2ZSB2aXNpYmls
aXR5IGludG8gd2hlbiBlYWNoIHByb2Nlc3MgYWxsb2NhdGVzIGFuZCBmcmVlcyBtZW1vcnk/DQoN
Clllcy4gSG9wZWZ1bGx5IHRoZSBhYm92ZSBvZmZlcnMgc29tZSBjbGFyaWZpY2F0aW9ucy4NCg0K
VGhhbmtzLA0KS2FuY2hhbmENCg==

