Return-Path: <linux-kernel+bounces-337613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC24D984C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6F51C2031A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FF813BAD5;
	Tue, 24 Sep 2024 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/5rH17j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64A880043
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727211151; cv=fail; b=S4zXmFYMgNJV1hG9GUwCyCK68APwt8cteRNk7eE7h7Ai7WXlqPwxdj4qFbTKP8vRunSq1bgVfxvBMuqX96i1kQE+saJRz4hUfP7FXpnhtj2FvsV6RaN+X0vax7ImioaKxDRwZXEMiCsFqYQVx4pwlGhcl1SIqobJRyRXka8gioM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727211151; c=relaxed/simple;
	bh=vOygyLBxZY8v5RB3uyTX3nrzFSVxgyEqUwkvVE9D6L0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J/LEOAONx6uBjfb9eOeLJaCtKCi0tWY8wn2Qr4iNXWpn2SA9pQ+Vt+E3vKY13pbjQ1rPn1PwxqUmF2EzaxhIH+DHAqrggR8RpowBWi1lyozmXCfZQ1X7o0kO8U9sVkaNFP2FbKlQU66yPGjnzV6q5bj/VbiYlOGmFjleKr0Dji4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C/5rH17j; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727211150; x=1758747150;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vOygyLBxZY8v5RB3uyTX3nrzFSVxgyEqUwkvVE9D6L0=;
  b=C/5rH17jWALQpq09En5ds7UYpcF9CCa0RQ17sCHsLhh1PwT376eCHCeg
   a9VdvpHvTf1WXVhTSCx3TebtUkoXhLPNFvMEBUaWVHAGsHFw6DSnZ5atV
   yUs/ag0LcCDLbu5CYv+z6c8HxQwLvptJn9SelKcZ8WFlsRQxEmiKaAzYJ
   iRHMpDFaXyYd2Z3aRH+/D6BpZi+xzFKS04odqSLnTzSYmAbA2eMlO2ZQh
   MX54mNpLXwCvMlTysF6dhhp7rGzfnyoNucOU/HlPpnoM/dus9uOr9dAdo
   ufrPbZfdhmJ68WnjC6RPDsPLZFVBCI96l/JCuycGXkw8F0X7FRRf6pvtb
   Q==;
X-CSE-ConnectionGUID: b+rHAJPJQLOEc6/Fr5NbYg==
X-CSE-MsgGUID: p/2xBdDcQHGTuMFpDWup9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="51649697"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="51649697"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 13:52:29 -0700
X-CSE-ConnectionGUID: A9zO4yDtT5CbJtiv8jJcMg==
X-CSE-MsgGUID: JG5ZxwGmSFqQCa6g1a1+Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="71638751"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 13:52:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 13:52:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 13:52:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 13:52:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ga1Epl+6Dviu0qy7h2i0oFm3hR6PQyxi/vfUAhZzIlLuXezTRhAg8tZCuBKbn/tt2ioSXVOXDbCwrH9aA4a7X616/jgNQ6x3sV1Jsn+SUieKAJuLI7W4jeizvIyDG9j7kqYZ4Bijgzs2uZNqL85htxdNZuVzVDY1pdLhTNd+W8nQ1vzZvzoJnaWvoumOTfNUXWwNqLuMt1knrA159TY5u+81VvdFvB4LzyDrlQYKYPbxHZtvTxIxo9fPIUqDse35s2ztQv/Bl5/OgcJPPq8QzBBJ3SgE9J6EY+BY44epQUi7KdSh7EmcmdPVZCmLL9EFLsd1NgT/1ydlROqvNgl3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOygyLBxZY8v5RB3uyTX3nrzFSVxgyEqUwkvVE9D6L0=;
 b=pFsJneqhiElNIIMjaSBnpg+aC7cMNN60eZiSqfsxglAgC4loJUl6HJZc1gNwlD0GKeHVgomQuf4JhpdOrnp13QQR0u5FJSqn2F5OLjjTbe/pUn2m7yaoGwsl3qD3ydC75AcShBTk65vXlPh5DMV5nY4IX6GlBrw/DgMSR5s9v6+NOjGlrWQPbYWwJ07tditNo5zMsoeioIJ4FzkRx+n0SA1ueK3fNnSXKjmTgzSg6J799BeF1OkQ/7kq1YZMwXQfT0JkP0is6Qq0hNvOMkzs5xppAbGOv1m9EwWBgLluNaPkhuA6H7g9vFWiB/dRs0qUIrL9aiw7vf+eSbZAXc01Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Tue, 24 Sep
 2024 20:52:26 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 20:52:26 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 8/8] mm: Document the newly added mTHP zswpout stats,
 clarify swpout semantics.
Thread-Topic: [PATCH v7 8/8] mm: Document the newly added mTHP zswpout stats,
 clarify swpout semantics.
Thread-Index: AQHbDh+DKWatCAUr002lz5xXuj85PLJnNGeAgAA2bZA=
Date: Tue, 24 Sep 2024 20:52:26 +0000
Message-ID: <SJ0PR11MB5678B5BE38EBC23C81A3466EC9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-9-kanchana.p.sridhar@intel.com>
 <CAKEwX=Og85V4YHZXSxZTqCr2dXNgZLOXG76RBfwGr2tF7xEbOw@mail.gmail.com>
In-Reply-To: <CAKEwX=Og85V4YHZXSxZTqCr2dXNgZLOXG76RBfwGr2tF7xEbOw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|PH0PR11MB7472:EE_
x-ms-office365-filtering-correlation-id: 4f4c2f26-5087-48a4-1ef2-08dcdcdacbfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OHFld1lGNkpJMnJBWmErVk55MGZNdUtjTTN2a3BFTXBCUitkdWxTR2JtcFJm?=
 =?utf-8?B?WkxnZTJWVWl3cUFYMnJaVFY3dUJ5Y1lNeitBaTcyVmQyZEI0dldscEp0QnNP?=
 =?utf-8?B?NUswN3lZYk5BNTB2Z0dxUUxnTWdKQWxLVDhkOXVOQ2N0U3IwcjVXQXJpOEd2?=
 =?utf-8?B?TjNIM2xKYTNUSzdsL2t3V2l2UzVJejM5WWgrZlFPa1B0MjFxWlZGUzM3SXFv?=
 =?utf-8?B?RUxWWlNKQlFFYXZ5VXUrTkRMUGZWaGcwSUNtTkFCN2ZuYXhkMFk5emNBd0F4?=
 =?utf-8?B?TFpkOTBlN2FIT3pZRTBJeVozZG9pWG53dWw2VVh5QlhIeENYYS80d3RkcFBI?=
 =?utf-8?B?Zk95UEtjeEs1WUgzVURxbzRueEpBanhhSVhYdWtPS0RtU3hBOXR1NXJGeW8v?=
 =?utf-8?B?eHlxVTJSQnl0NTEvUWxHRWNseEd5cm4vTTlqQU9hRDBKZUlEeWlmaEFObjZT?=
 =?utf-8?B?MlFXRkNLcURsa3BPSWlYeHB5SjJDZ0VqUjh6NUxlVXRhYnQzZXFRNnBORzJB?=
 =?utf-8?B?bmlsVEtjZ3Q2MXdzU01kYUdQZmpuRzRNTGNDcnFEZ1YySjJGUWhYUTdENkZw?=
 =?utf-8?B?UEpLYWpJS3UydVBPdkVVS1RrcTVjSlJxdDBFQW5tRS9xMzYrMy9BQ2tpTjdY?=
 =?utf-8?B?YzFCMUM2UzBEcDRZS04yY0pGY3ZXaGtiSkRrWkFVbnc0NytlMjNLcTRscVVl?=
 =?utf-8?B?NVRjV00rbWZRdHNtZGFjYy9VeE5GVnhJYXpyb3pwQXVmUHlNVy9WTHNSY3RQ?=
 =?utf-8?B?UFg3UHkydjcwUlhXbmo1VkJGdnB5b3FkZ1cwL0J0RjRYdm5TNmJ6U2o2dVJY?=
 =?utf-8?B?bjJoU0dqcUcwb1hSSDg5eHBaYWp3cXV6czhpVE1OSi9JYmphSDNiRVIyV3pT?=
 =?utf-8?B?Q2ZFelRaY2Vmbnh3aW5ySllSdzhJQjdvc25PNTNKaE91MnFrNXdXUWFaYzJR?=
 =?utf-8?B?bmRsSk5HVDZNUzh6Y2p3WHhQRHdlV081VzdUMHVTUFRJZkdSYU1zaFQzUDk3?=
 =?utf-8?B?RlBraFpvWnJaMksvb2c4WldtTEFzUGpBZklVUFBhNUFsWXBsYTJCMFR1S2Vu?=
 =?utf-8?B?alVLZUNQbHNCSVVTU3U0RkJWQkxWbDdsZHVXc2tTM0Z3V1dsbUIzZDFmOFVv?=
 =?utf-8?B?c0ZTajFsOHkzQmM1WDRtVzVLd0hmTTkzTWRPWDhDTlRBbzFzMGdGS2tvN2NL?=
 =?utf-8?B?ZnMyczlGd2Fab0F5Yi9iK0ZTbWlTVzRkZ3Y5cktxblFBVGlrcFNTTEM3K0ZZ?=
 =?utf-8?B?MnhmeGtzaUwrY1VQSDQxWE8zempxVkNRdFRxOVByQTBnejcvY0c1Y2JkcDJ2?=
 =?utf-8?B?RThJbHVKYWJTanhxSnl1MWd0VmZBa2NQbHZPblhKVTBERlJlSlJsVy9sVlpz?=
 =?utf-8?B?dXVUNWVxeHJlQ3hYdTV4d21oTWpFSm9pYlprYk5oYlczUnBEWCtNNVFmWk9L?=
 =?utf-8?B?dFd5eHVHaWRxTkQvNDZFVjV5d0VlYnB5Q1FOYnBaSFpzMlVzL0cvMWxxVXpt?=
 =?utf-8?B?MGJMY0k1ano2dUZXK3QzWnNzK0NwY2JWU3VIT2xZZDFvWmFpRXU4WFRtclVw?=
 =?utf-8?B?V3JuZnplMHVoeUNOVzc3cmNuUDhKazgvN1R2N0dZZCsyUDFkalRzUGt0Qmd2?=
 =?utf-8?B?WGdrTGhOWC9QQ0hwZ3NBYVFlaGVMTUZxUXdQWlBYMVRaWU00Zjd6ZWRoK1Er?=
 =?utf-8?B?eHdkaFdabUdVZHdGZS9qUWFpQ1pERU5SODRQQmFoY2Y2c09lY0F6bUtnSE1C?=
 =?utf-8?B?d1dHNjJBdklWZklJZE9GTWc1Vlp1UWo2RE1TU0dFbytpN1VDMHlKZnFCNlhs?=
 =?utf-8?B?VFp3V1BXbFNETUhpSkVBOU43ZjR1WjNJVFM3YjdjK0VuT2NxOXgwSkZ2MXlG?=
 =?utf-8?B?SHU5YnZ3ekVuVkhyalV1WUQ3emxNTTJIKy9heXVxcHN1Z3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REhNWmpUMUlqZHFyMTZQVG5xc0NNRTBsS0FVL0FwbGlDYm5GdFJWK1JhZFc0?=
 =?utf-8?B?QlNnbGRHVkxid2MwV3pWNFl5bEw2ZUwrMnpjb1dLTSs4TWI3MFlKRWk1Nm5L?=
 =?utf-8?B?cVhWUVREeEZwM0g0WHRXK2RYVTZSSFNWYnMzdFlnNU9IaGc0c3dTR0tqZWxr?=
 =?utf-8?B?aU5kdmpnRzEyT295RWQyNEdYNUpJMXJQaVM4OURFSkxyR0tjWXlGRVg4TFd6?=
 =?utf-8?B?SmNMcS9DM3AyOWNuTU41V2Nka2FFK0NQdmlRZzJWYVRmdjRjeEVJQlk2Mzlj?=
 =?utf-8?B?cUEvVUNyWWE5VzVRRlZjbndFOEZXWWZ0ZUJVc1FoUXpzcDJuMjdhdElpTFd2?=
 =?utf-8?B?VmF0aldkOEsxVmkzaUFmQ1IrWkE3Uk5DZ0YrMWRHNTVzSjI5WWlIRXRXWThC?=
 =?utf-8?B?aXorS0pVODdIVVcyaGZPQkpnc1drYWd4Z0VzSUtWRjE4QTQ3Y1dwbGZoSW5i?=
 =?utf-8?B?NWxBMkZ4Q3RCOVpKdS8zc1BPalM5b1JWZjgzTlVoTlI0WEQzQ2s1R2gzQktY?=
 =?utf-8?B?VCtFTGdDZ3ArUDNESVhjN2lESEpWUzJVMjNub0NPQ015T1hsdjhGdEJOSkZj?=
 =?utf-8?B?MW9NWWFwZU5DVC9iNTRrSHdUdXdIdG05c2RwVWRUVXZjYW4wd0s5cm5TRjdG?=
 =?utf-8?B?RjNRcE1MS2VLV2VzaEE2eVlvZ215T29hZzhiUkY2N2xUTnRuSWVUMWlFazhi?=
 =?utf-8?B?TS9MOGtYanFTNUI2K05jcXYzcG9WeGZPWm1YR0UzekpoSHFvSjdXWEhzcXEx?=
 =?utf-8?B?QWxBOHlaYkw5ZzdqKzdGRkdQRi83LzdGNnNNd1Y1Q2IrVzY2a05xY0N4bzJJ?=
 =?utf-8?B?U0hCQ1FIdmdUZzkzc3R0Q0RGTXgzc0dueHNUeUxzd0srVFZHNjVhSUJvWHp2?=
 =?utf-8?B?bGp6ck5JMXlRRldONUNnb0E5b1lMb3RJTGdDeWRIbXRsdVorUzVremhtQWpt?=
 =?utf-8?B?VTN0MTRLOW1FZDAvSmpZRmFoU1E0VGZwY1dwSEdXZ1Zyc1QyTTc1MzN0VnJF?=
 =?utf-8?B?Y0YxWE41TUc1QjhiUGtxS3VPeURKTWRiRytPQWx1VlF3Q0k5TTFiMnJLWWxy?=
 =?utf-8?B?Q2Uwc2hVWFlVSXd4M0lCNDVVUDRwRnh0T051TDFEWExCQk1rZ1FSNEJsNnZY?=
 =?utf-8?B?cFpWVU5jbG9icURMd0VBcVErb3FPeFFEZXZveTMveFhlKzlIcm1Ib0hSMkFS?=
 =?utf-8?B?Qi9vU2tuSnJJRGd2U05lZkxLR3AxcTlxZWpURUsyRzN6bko3NUdGZ0JqZ3FE?=
 =?utf-8?B?U2xCQjAzT1JLMEQzM2ZlcHNjUkVDUC8vYXRNL0U3VWRRcm10bGJmRG96RDhl?=
 =?utf-8?B?TDJyTzZhV3doL1dtclE3aHlxVXgwZnBsRTl1YVJPUFV0cEZKM1piRTRrYUhM?=
 =?utf-8?B?UWg2eDhSU2lkTGRjRHVzNGVtWSt5YnZ3S29CcTRLYytLWS9VaDhFcDhVRjA1?=
 =?utf-8?B?M3VOU0wrMThmWFlKb0FFTm04akJGMkRsZ2ptYUM3OGhHTkwreTlhL2xmYzhK?=
 =?utf-8?B?Z0ZhL0p3NzJHRnYyVFViVGFxMjQ4ZWJVamZZVGpZMEF5aXpxb1JleXU4NktL?=
 =?utf-8?B?ZlpMQ05CUlEyVW5BTE9NSDRnbGdwQk1IRG91aisxSldFQjcxUVVqTGRyMCs1?=
 =?utf-8?B?NjN6bG5XTEFwanRYUG8rdUQ2MFl4SnliaVhzUStnb0NWSWFZU1hsanFHRmhJ?=
 =?utf-8?B?ZlYzSVhpb0lGeXBqWDltbHZBeDVoQ2s1SXpHMFE0Z01VVFhwS3lrZnNRZk4y?=
 =?utf-8?B?Rm1yRThDVXI1Y3pTZkZVQkQwdzAzMUVPdFBTSVV4MHRmSjIxMDBHL2hzeEpL?=
 =?utf-8?B?S0VmbnM1djc5VDlCSDVzWHdJZkY5TUxNVzhrL3grRzByc3FzR3M4Z2FhYVd3?=
 =?utf-8?B?cHFnNUZ6UUFSSkdHbzZTU0lqMGlHc0xGdDNHbEx1QW1nMzQ4QklVWkp2TnRO?=
 =?utf-8?B?WWxlcGs1ZVI1bk9OQm1IcDdTazZaSTFNZUVreHBvQTRJY3lMNm4vbmZiRVVC?=
 =?utf-8?B?VG5aNG4zbHRoOExzd0dsanpuYi9sbXNnOStYRFM5amhuYlhtdlJiRlFlWVdH?=
 =?utf-8?B?MEdNK3JYNjdHeVlFRUtBSThVNmxXak91QW1teFBzY2dmbGZ2ZGdSL2NGUEQ5?=
 =?utf-8?B?QnlEa3hiNzdaQWZIWjI3cmRhYTBuMExLR1BnMU1xQUlBZDIvUnY0Y2p4REVM?=
 =?utf-8?B?ZUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4c2f26-5087-48a4-1ef2-08dcdcdacbfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 20:52:26.2578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLJn8YD4wK/3h/LqpMXpPuas5M1rmv3KoGDrqtn6d9HXraPGceS48LOVUIjEkGCiTJ8WhTRSUVxKznR+8dp5ZHg/WF7dLsobMiIwQEm2zjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7472
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaGF0IFBoYW0gPG5waGFtY3NA
Z21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjQsIDIwMjQgMTA6MzcgQU0N
Cj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+
DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7
DQo+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgeW9zcnlhaG1lZEBnb29nbGUuY29tOw0KPiBjaGVuZ21p
bmcuemhvdUBsaW51eC5kZXY7IHVzYW1hYXJpZjY0MkBnbWFpbC5jb207DQo+IHNoYWtlZWwuYnV0
dEBsaW51eC5kZXY7IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOyBIdWFuZywgWWluZw0KPiA8eWluZy5o
dWFuZ0BpbnRlbC5jb20+OyAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC1mb3VuZGF0aW9u
Lm9yZzsNCj4gWm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2Fq
ZGkgSw0KPiA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZpbm9k
aC5nb3BhbEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgOC84XSBtbTogRG9j
dW1lbnQgdGhlIG5ld2x5IGFkZGVkIG1USFAgenN3cG91dA0KPiBzdGF0cywgY2xhcmlmeSBzd3Bv
dXQgc2VtYW50aWNzLg0KPiANCj4gT24gTW9uLCBTZXAgMjMsIDIwMjQgYXQgNjoxN+KAr1BNIEth
bmNoYW5hIFAgU3JpZGhhcg0KPiA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4gd3JvdGU6
DQo+ID4NCj4gPiBBZGRlZCBkb2N1bWVudGF0aW9uIGZvciB0aGUgbmV3bHkgYWRkZWQgc3lzZnMg
bVRIUCAienN3cG91dCIgc3RhdHMuDQo+ID4NCj4gPiBDbGFyaWZpZWQgdGhhdCBvbmx5IG5vbi1a
U1dBUCBtVEhQIHN3YXBvdXRzIHdpbGwgYmUgYWNjb3VudGVkIGluIHRoZQ0KPiBtVEhQDQo+ID4g
InN3cG91dCIgc3RhdHMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLYW5jaGFuYSBQIFNyaWRo
YXIgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50
YXRpb24vYWRtaW4tZ3VpZGUvbW0vdHJhbnNodWdlLnJzdCB8IDggKysrKysrLS0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL21tL3RyYW5zaHVnZS5yc3QNCj4g
Yi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL21tL3RyYW5zaHVnZS5yc3QNCj4gPiBpbmRleCBj
ZmRkMTZhNTJlMzkuLmE2NWY5MDVlOWNhNyAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2FkbWluLWd1aWRlL21tL3RyYW5zaHVnZS5yc3QNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2Fk
bWluLWd1aWRlL21tL3RyYW5zaHVnZS5yc3QNCj4gPiBAQCAtNTMwLDEwICs1MzAsMTQgQEAgYW5v
bl9mYXVsdF9mYWxsYmFja19jaGFyZ2UNCj4gPiAgICAgICAgIGluc3RlYWQgZmFsbHMgYmFjayB0
byB1c2luZyBodWdlIHBhZ2VzIHdpdGggbG93ZXIgb3JkZXJzIG9yDQo+ID4gICAgICAgICBzbWFs
bCBwYWdlcyBldmVuIHRob3VnaCB0aGUgYWxsb2NhdGlvbiB3YXMgc3VjY2Vzc2Z1bC4NCj4gPg0K
PiA+IC1zd3BvdXQNCj4gPiAtICAgICAgIGlzIGluY3JlbWVudGVkIGV2ZXJ5IHRpbWUgYSBodWdl
IHBhZ2UgaXMgc3dhcHBlZCBvdXQgaW4gb25lDQo+ID4gK3pzd3BvdXQNCj4gPiArICAgICAgIGlz
IGluY3JlbWVudGVkIGV2ZXJ5IHRpbWUgYSBodWdlIHBhZ2UgaXMgc3dhcHBlZCBvdXQgdG8gWlNX
QVAgaW4NCj4gb25lDQo+ID4gICAgICAgICBwaWVjZSB3aXRob3V0IHNwbGl0dGluZy4NCj4gDQo+
IG5pdDogYSBiaXQgd2VpcmQgdG8gY2FwaXRhbGl6ZSBaU1dBUCBubz8gOikNCg0KTm8gcHJvYmxl
bSA6KS4gV2lsbCBmaXggaW4gdjguDQoNCj4gDQo+ID4NCj4gPiArc3dwb3V0DQo+ID4gKyAgICAg
ICBpcyBpbmNyZW1lbnRlZCBldmVyeSB0aW1lIGEgaHVnZSBwYWdlIGlzIHN3YXBwZWQgb3V0IHRv
IGEgbm9uLVpTV0FQDQo+ID4gKyAgICAgICBzd2FwIGVudGl0eSBpbiBvbmUgcGllY2Ugd2l0aG91
dCBzcGxpdHRpbmcuDQo+ID4gKw0KPiANCj4gbml0OiAibm9uLXpzd2FwIHN3YXAgZW50aXR5IiBp
cyBhIGJpdCBhd2t3YXJkLiBNYXliZSBzd2FwcGVkIG91dCB0byBhDQo+IG5vbi16c3dhcCBzd2Fw
IGRldmljZT8NCg0KU3VyZSwgd2lsbCBtYWtlIHRoaXMgY2hhbmdlIGluIHY4LiBUaGFua3MgTmhh
dCENCg0K

