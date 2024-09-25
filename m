Return-Path: <linux-kernel+bounces-337898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F619850D0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59849285296
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5A63770C;
	Wed, 25 Sep 2024 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0pCHZh4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E6C1EEE9
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 02:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727229800; cv=fail; b=pnwW7ozB0NeT7eB9qYvw0/4QjgaEjv7lOqxA7qtPIQ/NtPV7KkiOiQR+sRKsfg8SIyq/Opc7tE9HT5T4cToVAlkvNKAMPUkML05GPYg7t9dlW1vmpmWR1Thr8VEGdl1U46FcdZf7YawRQlRY0Y4ZzL8H9lLpIVwu28oAKjJSLZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727229800; c=relaxed/simple;
	bh=0fdIGxV9g3qwoank4rYVUBRMWj+wNy08q2VBxOaL4vA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Plm8aNaeNAHNfqI9E6OumFdERLSD24IPobRrEoUGe4WMnEYL2PYKkFIu3VI57Fmk7g8egII5jG83oDafT2LFbqVF1k83B7StwFoFse5BR8NOQji3PD4AA61GAYbLFfhU7rhwP6Zr7RJ7HcHGXBt58fOq2TBj8JKEzdS2benG0u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0pCHZh4; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727229799; x=1758765799;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0fdIGxV9g3qwoank4rYVUBRMWj+wNy08q2VBxOaL4vA=;
  b=V0pCHZh4syMxPSZTDO3k/omoZQ+OuoBIaPZWpOe34lbb35Nbe/FZhCra
   5C2XfwuI9hRLsOHiFNhDSLTzQeD2XEblYnJSS472hhto4RTU/g1P4kYJK
   Vhaaj4HDyhLNbctQ4GAFS9sy8hbNAINQdBHgTO922xutZOdrImtqqZdyr
   Jr0QJMK2icVjM9998Id1+oQNL+3ZSAQvyJKNNvcqwfwTgTskB06QnbcIR
   tf/IfYhdx8zWNdxfcaWfMJd8V+3ck3HBcrtTCn4q1WYPr2QIYW8H1zkBP
   mciM/8vRtgQICre7Svx6OjcpTBgiZdNCRqDnjALEH96ed6IEtqa/xcxmx
   w==;
X-CSE-ConnectionGUID: jwG3gHRnR3mNQSliOAxozg==
X-CSE-MsgGUID: fAGz9c9RT2yeKsEeaVTFKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="48788390"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="48788390"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 19:03:18 -0700
X-CSE-ConnectionGUID: CWGekTbvT1CAMBeLjHfxCA==
X-CSE-MsgGUID: dAeo2oyzTxKlUztGVkVhcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="71904538"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 18:49:12 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 18:49:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 18:49:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 18:49:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 18:49:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 18:49:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtFo2F2D0ZQXF+wCSU0cuymNfy87AoA5e3gMHMLshIBhKSRr0UiPt6CnHl5eThVfeFHPaBx4WrQHHW7cRiyCKJCJ5Tt+DEi517UxFoZeIcHFATY9KaXzzilaF9rZVn1hnQa9MQp3bcH8utUW63oYtTlF+JcTWWvmelRNRwDqpxakFLzFdiM0pZ2eW9hXkuN2JuHkSBholTborpVR/Aoh0QDLsgHBXzrE6O0bCrnjyBJDt64UNz6fqjuvRcJogUmIg3ufB6sNinvAwXzPE39SNTXNd0wcNbMjo/J8NSP4asFX3HqHwbU8p04H7j1bn5tMPh+osso4H5AUFy55vtxH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fdIGxV9g3qwoank4rYVUBRMWj+wNy08q2VBxOaL4vA=;
 b=aQhanhgN3sK4QjgpLs+9bELdWYL8ExG1LL3OaIrY1cxLrXZWL2lQweE4XskWXEg4ScKjmUBvmoOT/Edl1cdgzY91J815ficZooOVj7z+liNvWYKUM2FWR7kpSn6d8GI4CU3lRqefZ7ONm0F2AErx/jqG7VegBd5yF/rBMlbXuE83zuughJR/9cf9dOzwfu+HRFNOHKRI7EXhJqWA3RIrwEGDm2PFHri5FDVFiwbAbf6kp5MT42P8xzpk3O37PDfGbMnRvG1Yv897R3vy3pcxyn+/E8Zrf869K084CPM9o2nTDuVAmtmSMSMHXxrmUV6yBwstms5WLNLtL5M+iwjVsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by CH0PR11MB8143.namprd11.prod.outlook.com (2603:10b6:610:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 01:49:03 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 01:49:03 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 5/8] mm: zswap: Compress and store a specific page in a
 folio.
Thread-Topic: [PATCH v7 5/8] mm: zswap: Compress and store a specific page in
 a folio.
Thread-Index: AQHbDh+BiNTld7AyzkaqOvKNL8+CcrJnU8CAgAAzUCCAACWmgIAACLYg
Date: Wed, 25 Sep 2024 01:49:03 +0000
Message-ID: <SJ0PR11MB5678EA6E0A41B0C83CB7F8F3C9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-6-kanchana.p.sridhar@intel.com>
 <CAJD7tkacF3hCXiZHy7_+E7xmdojnsUewDeP=BsamcZReHxCTtg@mail.gmail.com>
 <SJ0PR11MB567887AF292EC178BEF1CF43C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkbCB9iqRc1Y0287rZjQnJaV41DxN+GzZJFkqxM1FM8R4w@mail.gmail.com>
In-Reply-To: <CAJD7tkbCB9iqRc1Y0287rZjQnJaV41DxN+GzZJFkqxM1FM8R4w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|CH0PR11MB8143:EE_
x-ms-office365-filtering-correlation-id: c1ba2943-abaa-40f6-0c2c-08dcdd043bf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a1F2VU1MeTg1V3FKb3VPS0VuTGZ3U2FLa2Z1eHVoSEZrbytQRjFsQzJUUlFL?=
 =?utf-8?B?c2p2NVVqWUM2ekZtakVySzFmZ09xZHJ4NldSN3pSM2VNY1E1U2xWWE5VV3lZ?=
 =?utf-8?B?U0lLekxFQnBLdmY4enhKK0YyK2JGM0wvOVA4LzY0OUxsTlZIZnNMQWg5eVRF?=
 =?utf-8?B?RTRzOWpNMHdGQkhNRnU2RXBwRTY0cGh2NkpYNER6aGlNU3orQjY3WG1YeVBX?=
 =?utf-8?B?Ykg1d0ZvVW84VGQwVllzZzJpTkw5V3RyMVhzUU5CUUhzdVdFVlZPelplTitN?=
 =?utf-8?B?YS8rR0VZME9zdnBHTWY5U2FOcGxyeUdiRjRWOVkvZkc2R3VsdkhTK2dwbTc0?=
 =?utf-8?B?UkR2MFNybjlKVGhWK1dSTm9lWkZKQ1ZUY0lzSmhBUDJMU3VjNGt2SlMveEhm?=
 =?utf-8?B?SUVTSUFibzZRamhCTnVmS1NhZ0tXa1M2QU5yNHRCSzZkVmQ4d0pWMDdMRE1Z?=
 =?utf-8?B?NXlvSnlpeWdaVE9HYklNSjFxN2dKWEYzbXozT0pNMUg5UFE4MXBRcGVJOTBp?=
 =?utf-8?B?Y3BsaktHZjlCdXVxZ01JcGFBTHpYV2NHR1AzRlY1cWJhbmtpY0ZaSTJxVlc3?=
 =?utf-8?B?bkdFUSttRHhDNHJWc0NENU1Ba0tnTDYwRjB5akNYUjkyMGpxRVI2d1diMk01?=
 =?utf-8?B?am5LY054a0NPNFVmYzBYZnpFWTUweU5yMUdsTnErdlNnOVdaUzdicWRIQTFi?=
 =?utf-8?B?MDV3ZHZzTUVaaDRFb1RxNEtac3E2Q25TODJHbE5NS1ZZbWRtK1VtcCtFMFVi?=
 =?utf-8?B?eFFrajRCK2dGWXNoNWdjYlBvbFcyR1l1MlVqOGJIOVBhM1hQRzlrWlNCdDBr?=
 =?utf-8?B?TWp3dzRISGNKa09JZlVoVEJzdFJRNDUxTnhiWUNOaEVjUXFmVU9xYkFzSVFy?=
 =?utf-8?B?U2wrY3ZNR0tQdHVIVW9TTTN0TTQwUm5kOWQ3M2srNzNXTk1UaC9OVjNaUkhC?=
 =?utf-8?B?b3pHZitaTjlKaUpqZysxcmxWSE5vdmhhUW5EazBkUmZsaTdybWRaWG1jck5n?=
 =?utf-8?B?bVNLOVFFc0IrRWN3SitGc2U3MjJES2xvNzBYMnFiT3l6TFV3OWR5VVBDQ3lx?=
 =?utf-8?B?Nm9FWHBpcVdsaCtFbHdlbHNOV2ZqWlEzTCtiWTFZWXhaTjc3UGJpZ2FLWnFO?=
 =?utf-8?B?eXl4bnM0ZFVZS1hjY2x0dXNMMDNSKzBPQ0QyRUtNTC9ob0lCeFpSU3dyaDRo?=
 =?utf-8?B?N3ZZOXZXY2wwcmRvQjBiOFIrTEpwdy9YWWwram1TUFVrQ052L0lTWkc4RkFY?=
 =?utf-8?B?VWxPNnlNOTZiS0xtQkFiRUZBaHhPaENYdXAyd2FBOGJGUGN1OEpUWVVFM1ZY?=
 =?utf-8?B?d0xCQlJXK2R0TVRJSkh3MFZIUGErdXFJRitMR1dMNDhlQW51SHlibkY3MWhV?=
 =?utf-8?B?SlltUld6eGVzN0dMMnRPbFhlN2YySzJ6NUFDd0JtUjZzU3ozNGZJcVJwTTNG?=
 =?utf-8?B?MU80a2lBYXVuQ1ZzTVdsajRMSFdHVmF4RlBqZnlsNmdXcDFQaVR0dFptUC80?=
 =?utf-8?B?aGVVcHRkQkNWRG1ZTHNoc2VXRkNVV3lHZUJjQXMrNFhDanlIRzV2UmRmbk1x?=
 =?utf-8?B?QWo4VTB0aWh0WVFtN051OEtTTHVTUFQwNWdaMEp0T0JqUzk1TmRCcTI2UUZC?=
 =?utf-8?B?bnRUMkRzK3Z5R2tsYWd1NEtidjJIeCs5TE1FanlaUzdrSnhaU0VncHRUR1dh?=
 =?utf-8?B?NlJ2NytWL01BU1dYM20zd2sxOGpzME42bFdZc3RUdGF3aDcyeE0zSGUrR1hz?=
 =?utf-8?B?TUs5aVJRUlBVSmg3L2NTUWxCYnBxME5veTBGWlJHWG85U2F5TnloaW12c20w?=
 =?utf-8?B?YjZjQk12aFg4aUZxWnNEbWZyWEVUWmRkWW95V0dGSksrL1l1V2w2aU5pN09Z?=
 =?utf-8?B?V1VSWGtHS1RPV0NsZmJySkJnZElRWVB2bENPNWJmSE5ueGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVBVN1c3dzRQU01Nd1VVMmtrZmxSUVFKWmJveDRCOTQ1RXppT3JhelFrUmhq?=
 =?utf-8?B?dGhPTkY3cXlxSUVTM1k5NXB3SUZaUk5FeVJDV2ZSeUJBSmYzczI4OS9Fa1V0?=
 =?utf-8?B?aUROdWVJbUVwcWYweTJQNFZHSzU4eWlZd2lpR1lhK2FRb0ZvZzBJQk56TkNv?=
 =?utf-8?B?Rll3NkdjS0ZyUk40LzNxMzY3Q3NRcDBZV2pVV1Y1WWRlaE5tV0ZLa1orWEd1?=
 =?utf-8?B?VjBnbUlVaDM2QVo4TUp0Z1dzRDhzem56T3NTYTJHeHEza21XZ2xybi9XS2lz?=
 =?utf-8?B?UU1mSDJIM28wQmRNWWQ5Y3FFV2ptREEzZlFVRURjaFVoQjNkbGJjZEpnOGcw?=
 =?utf-8?B?N284V1NGRUpRaDRtUTByMFI0RWdkcWZMTzFUcU5Qc0Fham5HR1JJdmdWanlj?=
 =?utf-8?B?ZXl5SlcrdmViY0pzZDJSeDdibmd6cUdtN3pZV2F4bGprQWRhOTNUU213eDkw?=
 =?utf-8?B?VENxZExkWW44WUFXRE10WjhkdDhLb0RGZjFxN2tmcnVxb1RzV3lrVEJBR29Z?=
 =?utf-8?B?MVJkUnZUZE9Vc3dNTVlVaE1TM1dpQnhPTjVxaEVqb2VNeXZ3OVdmWThtUVRN?=
 =?utf-8?B?U3dPK0Zkb2NSeTk4b2s1SXdPMUd2eDdJWWVxK2QydFVCZ1JPaE9xOXNJczZN?=
 =?utf-8?B?MXNoQllrOTdxT2FVWElOa3hpQ1hJNUFqRFJEZWtwS0xVWnRTeEt2UmpnMG1Z?=
 =?utf-8?B?UGJzTEk1N1pBMDliUTZ2R2JLME1kc3FwTkNNRmI5blJOZVcrQkJLNmtCOXdp?=
 =?utf-8?B?aHdISXlBa3Vnbm0vQi9FZ1l6NDh6NEZoTzJ5YTN3cHZUYzNoTkJNVVUzNE1P?=
 =?utf-8?B?U2Y3bytTbFJJRDZOcXFpenpSaXBQdWdBZmRtV1dlcEZZUXZUYklLbWVDbHJo?=
 =?utf-8?B?a29QQVNvb1pOSWtxNjN3Q2xmanBYaDlWMGcva29iZm5vUktTMnVwbHo0dzAz?=
 =?utf-8?B?SnRRSDF3dDRQd3BoNmRMdlo0eWh5VjlsaldtWTRwSUJSMnZxZkozQVppNkU3?=
 =?utf-8?B?dytwZGJhK1c0SHBCSkFCMHByQzJ2Rnp3RFZ2VjNnaDUzdndObC9jUERnTDlx?=
 =?utf-8?B?eHcyQkdmeTA4YjB4b0hsZFh0Q2VnMVYyc3BpcDVSZ1kweGo3MXd4SXVvK1Bj?=
 =?utf-8?B?ajM2dTVod1ZSNnpoeUpoUTVUOUIyUlJoQktNaldHdDhNMERkT09BOE90SXdX?=
 =?utf-8?B?WWhTcGM2S3F5ZHZTYnoxZHp5YjNzZkhpR3o4Nkd5KzdpdWcveXg1Zi9ETTBB?=
 =?utf-8?B?N2NZa2UrUGNSMGRtTFRKRnBJdmwrRkZ0RldmbHpJNWRKeW9mc3VCa3lvb1hn?=
 =?utf-8?B?L1l0WDBNUEZxMXNOZGdaZFRnb1NaUXpQN2t3TGNPTW0yL2xOcFBVU09QbHlC?=
 =?utf-8?B?cmwyQmdEMlN0SFh5WE4yTjZ6OS9BdVZvNWUxQkhxcU9VUU9GeHBqSHZ2LzVN?=
 =?utf-8?B?d2QxR0JWQ2Z3TE1YWGJOMHVXYUxGeVN5emRIZjRwdkFPLytNNWt4WWhOM0Nn?=
 =?utf-8?B?S0RuWEVaYlBKZlJiQ1k2TVhEeE5zV2xBZzlEeExQNWxJSUdlaFVEcTFEb0F2?=
 =?utf-8?B?NDFyS2FRd2NPQ0tvbnZKaVFvQnRjSWorL2s3cmJ1c1BPNHZTMW8rem11b3lw?=
 =?utf-8?B?L3BhUTJsc1FReEo1YUQ0Q3RsckRmUk1BRTN6dTc5UFRQYmErVUZFenA5TzY2?=
 =?utf-8?B?V2pmU3dkVHo3T2FkVy9IUlZuSzBZTmR0OFl2QkhBN3JiN1FDUVRHNzFMTks1?=
 =?utf-8?B?bDR1QmpUS1JPOXJHaDUxV1FKT1FwZUNRS0VsTnBJeFVNampZWEJXN0gvTElG?=
 =?utf-8?B?VEtRai9aZTVDblMwL2hHMThFRDRsbzcxcDJCNXFBaEVGTEF0Q0VSWVVnY2JW?=
 =?utf-8?B?bmNkeHV2QSt1V0FVZzVSWnZrU0NrUklhUi83K05Xc0lFSzJaRFpPOGkvRmRt?=
 =?utf-8?B?WGZUeHFoa0g4TFhlZ2RJUmtTZk1ySGNzbm9GMTdPdWpGb3YwYmlOUVVvbWRZ?=
 =?utf-8?B?TS9pWWZEZm15eHhpaDZjNTZPK0hsVDJLMUFCUHoxeDZTdzl0c2d5UEVFODJa?=
 =?utf-8?B?T2I5dHVBQXk5WGtRTjZScVBLZi9ET3BmdHBLd0J4NUJheTNsSTc3Uk1lUmF5?=
 =?utf-8?B?QjdqUUpPalRxZ0V6T21Eeis4REd1enJzdlV1VjFvNzNkaDkrZDJxaVp6ajRY?=
 =?utf-8?B?d0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ba2943-abaa-40f6-0c2c-08dcdd043bf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 01:49:03.5180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8CS2bVgHfxOIx22rrtfDLBZN83Q6AVnAdx6cx5Elr+WrXoqxTqNTeb8iqNyhKTCJY/cfkDZUnw9OA1cCxe82FHBhK5KtTFBICwU0FuxCA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8143
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjQsIDIwMjQgNTo0
NyBQTQ0KPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVs
LmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNr
Lm9yZzsNCj4gaGFubmVzQGNtcHhjaGcub3JnOyBucGhhbWNzQGdtYWlsLmNvbTsgY2hlbmdtaW5n
Lnpob3VAbGludXguZGV2Ow0KPiB1c2FtYWFyaWY2NDJAZ21haWwuY29tOyBzaGFrZWVsLmJ1dHRA
bGludXguZGV2OyByeWFuLnJvYmVydHNAYXJtLmNvbTsNCj4gSHVhbmcsIFlpbmcgPHlpbmcuaHVh
bmdAaW50ZWwuY29tPjsgMjFjbmJhb0BnbWFpbC5jb207IGFrcG1AbGludXgtDQo+IGZvdW5kYXRp
b24ub3JnOyBab3UsIE5hbmhhaSA8bmFuaGFpLnpvdUBpbnRlbC5jb20+OyBGZWdoYWxpLCBXYWpk
aSBLDQo+IDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaCA8dmlub2Ro
LmdvcGFsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyA1LzhdIG1tOiB6c3dh
cDogQ29tcHJlc3MgYW5kIHN0b3JlIGEgc3BlY2lmaWMgcGFnZQ0KPiBpbiBhIGZvbGlvLg0KPiAN
Cj4gWy4uXQ0KPiA+ID4NCj4gPiA+ID4gK3sNCj4gPiA+ID4gKyAgICAgICBzd3BfZW50cnlfdCBz
d3AgPSBmb2xpby0+c3dhcDsNCj4gPiA+ID4gKyAgICAgICBpbnQgdHlwZSA9IHN3cF90eXBlKHN3
cCk7DQo+ID4gPiA+ICsgICAgICAgcGdvZmZfdCBvZmZzZXQgPSBzd3Bfb2Zmc2V0KHN3cCkgKyBp
bmRleDsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgcGFnZSAqcGFnZSA9IGZvbGlvX3BhZ2UoZm9s
aW8sIGluZGV4KTsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgeGFycmF5ICp0cmVlID0gc3dhcF96
c3dhcF90cmVlKHN3cCk7DQo+ID4gPiA+ICsgICAgICAgc3RydWN0IHpzd2FwX2VudHJ5ICplbnRy
eTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIGlmIChvYmpjZykNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgIG9ial9jZ3JvdXBfZ2V0KG9iamNnKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAg
ICAgIGlmICh6c3dhcF9jaGVja19saW1pdHMoKSkNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGdv
dG8gcmVqZWN0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgLyogYWxsb2NhdGUgZW50cnkg
Ki8NCj4gPiA+ID4gKyAgICAgICBlbnRyeSA9IHpzd2FwX2VudHJ5X2NhY2hlX2FsbG9jKEdGUF9L
RVJORUwsIGZvbGlvX25pZChmb2xpbykpOw0KPiA+ID4gPiArICAgICAgIGlmICghZW50cnkpIHsN
Cj4gPiA+ID4gKyAgICAgICAgICAgICAgIHpzd2FwX3JlamVjdF9rbWVtY2FjaGVfZmFpbCsrOw0K
PiA+ID4gPiArICAgICAgICAgICAgICAgZ290byByZWplY3Q7DQo+ID4gPiA+ICsgICAgICAgfQ0K
PiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgLyogaWYgZW50cnkgaXMgc3VjY2Vzc2Z1bGx5IGFk
ZGVkLCBpdCBrZWVwcyB0aGUgcmVmZXJlbmNlICovDQo+ID4gPiA+ICsgICAgICAgaWYgKCF6c3dh
cF9wb29sX2dldChwb29sKSkNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGdvdG8gZnJlZXBhZ2U7
DQo+ID4gPg0KPiA+ID4gSSB0aGluayB3ZSBjYW4gYmF0Y2ggdGhpcyBmb3IgYWxsIHBhZ2VzIGlu
IHpzd2FwX3N0b3JlKCksIG1heWJlIGZpcnN0DQo+ID4gPiBhZGQgenN3YXBfcG9vbF9nZXRfbWFu
eSgpLg0KPiA+ID4NCj4gPiA+IEkgYW0gYWxzbyB3b25kZXJpbmcgaWYgaXQgd291bGQgYmUgYmV0
dGVyIHRvIGJhdGNoIHRoZSBsaW1pdCBjaGVja2luZw0KPiA+ID4gYW5kIGFsbG9jYXRpbmcgdGhl
IGVudHJpZXMsIHRvIGZyb250IGxvYWQgYW55IGZhaWx1cmVzIGJlZm9yZSB3ZSBzdGFydA0KPiA+
ID4gY29tcHJlc3Npb24uIE5vdCBzdXJlIGlmIHRoYXQncyBvdmVyYWxsIGJldHRlciB0aG91Z2gu
DQo+ID4gPg0KPiA+ID4gVG8gYmF0Y2ggYWxsb2NhdGUgZW50cmllcyB3ZSB3aWxsIGhhdmUgdG8g
YWxzbyBhbGxvY2F0ZSBhbiBhcnJheSB0bw0KPiA+ID4gaG9sZCB0aGVtLiBUbyBiYXRjaCB0aGUg
bGltaXQgY2hlY2tpbmcgd2Ugd2lsbCBoYXZlIHRvIGVpdGhlciBhbGxvdw0KPiA+ID4gZ29pbmcg
ZnVydGhlciBvdmVyIGxpbWl0IGZvciBtVEhQcywgb3IgY2hlY2sgaWYgdGhlcmUgaXMgZW5vdWdo
DQo+ID4gPiBjbGVhcmFuY2UgdG8gYWxsb3cgZm9yIGNvbXByZXNzaW5nIGFsbCB0aGUgcGFnZXMu
IFVzaW5nIHRoZQ0KPiA+ID4gdW5jb21wcmVzc2VkIHNpemUgd2lsbCBsZWFkIHRvIGZhbHNlIG5l
Z2F0aXZlcyB0aG91Z2gsIHNvIG1heWJlIHdlIGNhbg0KPiA+ID4gc3RhcnQgdHJhY2tpbmcgdGhl
IGF2ZXJhZ2UgY29tcHJlc3Npb24gcmF0aW8gZm9yIGJldHRlciBsaW1pdA0KPiA+ID4gY2hlY2tp
bmcuDQo+ID4gPg0KPiA+ID4gTmhhdCwgSm9oYW5uZXMsIGFueSB0aG91Z2h0cyBoZXJlPyBJIG5l
ZWQgc29tZW9uZSB0byB0ZWxsIG1lIGlmIEkgYW0NCj4gPiA+IG92ZXJ0aGlua2luZyB0aGlzIDop
DQo+ID4NCj4gPiBUaGVzZSBhcmUgYWxsIGdvb2QgcG9pbnRzLiBJIHN1cHBvc2UgSSB3YXMgdGhp
bmtpbmcgYWxvbmcgdGhlIHNhbWUgbGluZXMNCj4gPiBvZiB3aGF0IE5oYXQgbWVudGlvbmVkIGlu
IGFuIGVhcmxpZXIgY29tbWVudC4gSSB3YXMgdHJ5aW5nIHRoZQ0KPiA+IGluY3JlbWVudGFsIHpz
d2FwX3Bvb2xfZ2V0KCkgYW5kIGxpbWl0IGNoZWNrcyBhbmQgc2hyaW5rZXIgaW52b2NhdGlvbnMN
Cj4gPiBpbiBjYXNlIG9mIChhbGwpIGVycm9yIGNvbmRpdGlvbnMgdG8gYWxsb3cgZGlmZmVyZW50
IGNvbmN1cnJlbnQgc3RvcmVzIHRvIG1ha2UNCj4gPiBwcm9ncmVzcywgd2l0aG91dCBmYXZvcmlu
ZyBvbmx5IG9uZSBwcm9jZXNzJ3MgbVRIUCBzdG9yZS4gSSB3YXMgdGhpbmtpbmcNCj4gPiB0aGlz
IHdvdWxkIGhhdmUgbWluaW1hbCBpbXBhY3Qgb24gdGhlIHByb2Nlc3MoZXMpIHRoYXQgc2VlIHRo
ZSB6c3dhcA0KPiA+IGxpbWl0IGJlaW5nIGV4Y2VlZGVkLCBhbmQgdGhhdCB0aGlzIHdvdWxkIGJl
IGJldHRlciB0aGFuIHByZWVtcHRpdmVseQ0KPiA+IGNoZWNraW5nIGZvciB0aGUgZW50aXJlIG1U
SFAgYW5kIGZhaWxpbmcgKHRoaXMgY291bGQgYWxzbyBjb21wbGljYXRlIHRoaW5ncw0KPiA+IHdo
ZXJlIG5vIG9uZSBtYWtlcyBwcm9ncmVzcyBiZWNhdXNlIG11bHRpcGxlIHByb2Nlc3NlcyBydW4g
dGhlIGJhdGNoDQo+ID4gY2hlY2tzIGFuZCBmYWlsLCB3aGVuIHJlYWxpc3RpY2FsbHkgb25lL21h
bnkgY291bGQgaGF2ZSB0cmlnZ2VyZWQNCj4gPiB0aGUgc2hyaW5rZXIgYmVmb3JlIGVycm9yaW5n
IG91dCwgYW5kIGF0IGxlYXN0IG9uZSBjb3VsZCBoYXZlIG1hZGUNCj4gPiBwcm9ncmVzcykuDQo+
IA0KPiBPbiB0aGUgb3RoZXIgaGFuZCwgaWYgd2UgYWxsb3cgY29uY3VycmVudCBtVEhQIHN3YXBv
dXRzIHRvIGRvIGxpbWl0DQo+IGNoZWNrcyBpbmNyZW1lbnRhbGx5LCB0aGV5IG1heSBhbGwgZmFp
bCBhdCB0aGUgbGFzdCBwYWdlLiBXaGlsZSBpZg0KPiB0aGV5IGFsbCBkbyBsaW1pdCBjaGVja3Mg
YmVmb3JlaGFuZCwgb25lIG9mIHRoZW0gY2FuIHByb2NlZWQuDQoNClllcywgdGhpcyBpcyBwb3Nz
aWJsZSB0b28uIEFsdGhvdWdoLCBnaXZlbiB0aGUgZHluYW1pYyBuYXR1cmUgb2YgdGhlIHVzYWdl
LA0KZXZlbiB3aXRoIGEgY2hlY2stYmVmb3JlLXN0b3JlIHN0cmF0ZWd5IGZvciBtVEhQIHdlIGNv
dWxkIGVuZCB1cCBpbiBhDQpzaW1pbGFyIHNpdHVhdGlvbiBhcyB0aGUgb3B0aW1pc3RpYyBhcHBy
b2FjaCBpbiB3aGljaCB3ZSBhbGxvd2VkIHByb2dyZXNzDQp1bnRpbCB0aGVyZSByZWFsbHkgd2Fz
IGEgcmVhc29uIHRvIGZhaWwuIA0KDQo+IA0KPiBJIHRoaW5rIHdlIG5lZWQgdG8gYWdyZWUgb24g
YSBoaWdoZXItbGV2ZWwgc3RyYXRlZ3kgZm9yIGxpbWl0DQo+IGNoZWNraW5nLCBib3RoIGdsb2Jh
bCBhbmQgcGVyLW1lbWNnLiBUaGUgcGVyLW1lbWNnIGxpbWl0IHNob3VsZCBiZQ0KPiBzdHJpY3Rl
ciB0aG91Z2gsIHNvIHdlIG1heSBlbmQgdXAgaGF2aW5nIGRpZmZlcmVudCBwb2xpY2llcy4NCg0K
U3VyZSwgdGhpcyBtYWtlcyBzZW5zZS4gT25lIHBvc3NpYmlsaXR5IGlzIHdlIGNvdWxkIGFsbG93
IHpzd2FwIHRvDQpmb2xsb3cgdGhlICJvcHRpbWlzdGljIGFwcHJvYWNoIiB1c2VkIGN1cnJlbnRs
eSwgd2hpbGUgd2UgbWFuYWdlDQp0aGUgbGltaXRzIGNoZWNraW5nIGF0IHRoZSBtZW1jZyBsZXZl
bD8gU29tZXRoaW5nIGFsb25nIHRoZSBsaW5lcw0Kb2YgbWVtX2Nncm91cF9oYW5kbGVfb3Zlcl9o
aWdoKCkgdGhhdCBnZXRzIGNhbGxlZCBldmVyeSB0aW1lIGFmdGVyDQphIHBhZ2UtZmF1bHQgaXMg
aGFuZGxlZDsgaW5zdGVhZCBjaGVja3MgdGhlIGNncm91cCdzIHpzd2FwIHVzYWdlIGFuZA0KdHJp
Z2dlcnMgd3JpdGViYWNrPyBUaGlzIHNlZW1zIGxpa2Ugb25lIHdheSBvZiBub3QgYWRkaW5nIG92
ZXJoZWFkIHRvDQp0aGUgcmVjbGFpbSBwYXRoICh6c3dhcCB3aWxsIHN0b3JlIG1USFAgdW50aWwg
dGhlIGxpbWl0IGNoZWNraW5nIGNhdXNlcw0KZXJyb3IgYW5kIHVud2luZGluZyBzdGF0ZSksIHdo
aWxlIHRyaWdnZXJpbmcgenN3YXAtTFJVIGJhc2VkIHdyaXRlYmFjaw0KYXQgYSBoaWdoZXIgbGV2
ZWwgdG8gbWFuYWdlIHRoZSBsaW1pdC4NCg0KPiANCj4gPg0KPiA+IFdvdWxkIGFwcHJlY2lhdGUg
eW91ciBwZXJzcGVjdGl2ZXMgb24gaG93IHRoaXMgc2hvdWxkIGJlIGhhbmRsZWQsDQo+ID4gYW5k
IHdpbGwgaW1wbGVtZW50IGEgc29sdXRpb24gaW4gdjggYWNjb3JkaW5nbHkuDQo+ID4NCj4gPiBU
aGFua3MsDQo+ID4gS2FuY2hhbmENCj4gPg0KPiA+ID4NCj4gPiA+ID4gKw0KPiA+ID4gPiArICAg
ICAgIGVudHJ5LT5wb29sID0gcG9vbDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIGlmICgh
enN3YXBfY29tcHJlc3MocGFnZSwgZW50cnkpKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgZ290
byBwdXRfcG9vbDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIGVudHJ5LT5zd3BlbnRyeSA9
IHN3cF9lbnRyeSh0eXBlLCBvZmZzZXQpOw0KPiA+ID4gPiArICAgICAgIGVudHJ5LT5vYmpjZyA9
IG9iamNnOw0KPiA+ID4gPiArICAgICAgIGVudHJ5LT5yZWZlcmVuY2VkID0gdHJ1ZTsNCj4gPiA+
ID4gKw0KPiA+ID4gPiArICAgICAgIGlmICghenN3YXBfc3RvcmVfZW50cnkodHJlZSwgZW50cnkp
KQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgZ290byBzdG9yZV9mYWlsZWQ7DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKyAgICAgICBpZiAob2JqY2cpIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIG9i
al9jZ3JvdXBfY2hhcmdlX3pzd2FwKG9iamNnLCBlbnRyeS0+bGVuZ3RoKTsNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgIGNvdW50X29iamNnX2V2ZW50KG9iamNnLCBaU1dQT1VUKTsNCj4gPiA+ID4g
KyAgICAgICB9DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICAvKg0KPiA+ID4gPiArICAgICAg
ICAqIFdlIGZpbmlzaCBpbml0aWFsaXppbmcgdGhlIGVudHJ5IHdoaWxlIGl0J3MgYWxyZWFkeSBp
biB4YXJyYXkuDQo+ID4gPiA+ICsgICAgICAgICogVGhpcyBpcyBzYWZlIGJlY2F1c2U6DQo+ID4g
PiA+ICsgICAgICAgICoNCj4gPiA+ID4gKyAgICAgICAgKiAxLiBDb25jdXJyZW50IHN0b3JlcyBh
bmQgaW52YWxpZGF0aW9ucyBhcmUgZXhjbHVkZWQgYnkgZm9saW8gbG9jay4NCj4gPiA+ID4gKyAg
ICAgICAgKg0KPiA+ID4gPiArICAgICAgICAqIDIuIFdyaXRlYmFjayBpcyBleGNsdWRlZCBieSB0
aGUgZW50cnkgbm90IGJlaW5nIG9uIHRoZSBMUlUgeWV0Lg0KPiA+ID4gPiArICAgICAgICAqICAg
IFRoZSBwdWJsaXNoaW5nIG9yZGVyIG1hdHRlcnMgdG8gcHJldmVudCB3cml0ZWJhY2sgZnJvbSBz
ZWVpbmcNCj4gPiA+ID4gKyAgICAgICAgKiAgICBhbiBpbmNvaGVyZW50IGVudHJ5Lg0KPiA+ID4g
PiArICAgICAgICAqLw0KPiA+ID4gPiArICAgICAgIGlmIChlbnRyeS0+bGVuZ3RoKSB7DQo+ID4g
PiA+ICsgICAgICAgICAgICAgICBJTklUX0xJU1RfSEVBRCgmZW50cnktPmxydSk7DQo+ID4gPiA+
ICsgICAgICAgICAgICAgICB6c3dhcF9scnVfYWRkKCZ6c3dhcF9saXN0X2xydSwgZW50cnkpOw0K
PiA+ID4gPiArICAgICAgIH0NCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIC8qIHVwZGF0ZSBz
dGF0cyAqLw0KPiA+ID4gPiArICAgICAgIGF0b21pY19pbmMoJnpzd2FwX3N0b3JlZF9wYWdlcyk7
DQo+ID4gPiA+ICsgICAgICAgY291bnRfdm1fZXZlbnQoWlNXUE9VVCk7DQo+ID4gPg0KPiA+ID4g
V2Ugc2hvdWxkIHByb2JhYmx5IGFsc28gYmF0Y2ggdXBkYXRpbmcgdGhlIHN0YXRzLiBJdCBhY3R1
YWxseSBzZWVtcw0KPiA+ID4gbGlrZSBub3cgd2UgZG9uJ3QgaGFuZGxlIHJvbGxpbmcgdGhlbSBi
YWNrIHVwb24gZmFpbHVyZS4NCj4gPg0KPiA+IEdvb2QgcG9pbnQhIEkgYXNzdW1lIHlvdSBhcmUg
cmVmZXJyaW5nIG9ubHkgdG8gdGhlICJaU1dQT1VUIiB2bSBldmVudA0KPiBzdGF0cw0KPiA+IHVw
ZGF0ZXMgYW5kIG5vdCB0aGUgInpzd2FwX3N0b3JlZF9wYWdlcyIgKHNpbmNlIGxhdHRlciBpcyB1
c2VkIGluIGxpbWl0DQo+IGNoZWNraW5nKT8NCj4gDQo+IEkgYWN0dWFsbHkgbWVhbnQgYm90aC4g
RG8gd2Ugcm9sbGJhY2sgY2hhbmdlcyB0byB6c3dhcF9zdG9yZWRfcGFnZXMNCj4gd2hlbiBzb21l
IHN0b3JlcyBzdWNjZWVkIGFuZCBzb21lIG9mIHRoZW0gZmFpbD8NCg0KWWVzIHdlIGRvLiB6c3dh
cF90cmVlX2RlbGV0ZSgpIGNhbGxzIHpzd2FwX2VudHJ5X2ZyZWUoKSB3aGljaCB3aWxsDQpkZWNy
ZW1lbnQgenN3YXBfc3RvcmVkX3BhZ2VzLiBUaGUgb25seSBzdGF0IHRoYXQgaXMgbGVmdCBpbiBh
biBpbmNvcnJlY3QNCnN0YXRlIGluIHRoaXMgY2FzZSBpcyB0aGUgdm1zdGF0ICd6c3dwb3V0Jy4N
Cg0KPiANCj4gSSB0aGluayBpdCdzIG1vcmUgY29ycmVjdCBhbmQgZWZmaWNpZW50IHRvIHVwZGF0
ZSB0aGUgYXRvbWljIG9uY2UNCj4gYWZ0ZXIgYWxsIHRoZSBwYWdlcyBhcmUgc3VjY2Vzc2Z1bGx5
IGNvbXByZXNzZWQgYW5kIHN0b3JlZC4NCg0KQWN0dWFsbHkgdGhpcyB3b3VsZCBuZWVkIHRvIGNv
LXJlbGF0ZSB3aXRoIHRoZSBsaW1pdHMgY2hlY2tpbmcgc3RyYXRlZ3ksDQpiZWNhdXNlIHRoZSBh
dG9taWMgaXMgdXNlZCB0aGVyZSBhbmQgbmVlZHMgdG8gYmUgYXMgYWNjdXJhdGUgYXMgcG9zc2li
bGUuDQoNCkFzIGZhciBhcyB0aGUgdm1zdGF0ICd6c3dwb3V0JywgdGhlIHJlYXNvbiBJIGxlZnQg
aXQgYXMtaXMgaW4gbXkgcGF0Y2hzZXQNCndhcyB0byBiZSBtb3JlIGluZGljYXRpdmUgb2YgdGhl
IGFjdHVhbCB6c3dwb3V0IGNvbXB1dGUgZXZlbnRzIHRoYXQNCm9jY3VycmVkIChmb3IgdGhpbmdz
IGxpa2UgZ2V0dGluZyB0aGUgY29tcHJlc3Npb25zIGNvdW50KSwgcmVnYXJkbGVzcw0Kb2Ygd2hl
dGhlciBvciBub3QgdGhlIG92ZXJhbGwgbVRIUCBzdG9yZSB3YXMgc3VjY2Vzc2Z1bC4gSWYgdGhp
cyB2bXN0YXQNCm5lZWRzIHRvIHJlZmxlY3Qgb25seSBzdWNjZXNzZnVsIHpzd3BvdXQgZXZlbnRz
IChpLmUuLCByZXByZXNlbnQgdGhlIHpzd2FwDQp1c2FnZSksIEkgY2FuIGZpeCBpdCBieSB1cGRh
dGluZyBpdCBvbmNlIG9ubHkgaWYgdGhlIG1USFAgaXMgc3RvcmVkIHN1Y2Nlc3NmdWxseS4NCg0K
VGhhbmtzLA0KS2FuY2hhbmENCg==

