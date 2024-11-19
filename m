Return-Path: <linux-kernel+bounces-414893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 799AE9D2EF0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C04B24DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7871D14F3;
	Tue, 19 Nov 2024 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFccnsVL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FBC14831D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045362; cv=fail; b=lKYUi9HuMyVT7/9gSr1BMhbah16BYy+qdttLR2L6r63408kKid83lO45jIAGpE72S73baeXuvRD2RWGCV0DXehF/umAEn7ylu1B+VoljwZ3DqPmCZbm6QC1XWAnCzC+AAnfogY7UVpPGTnna0XRJ+V7Ezf47gizMePyRGsfncVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045362; c=relaxed/simple;
	bh=EZ4M12flvJ/2/quhrIG/vroqAO4Kj6vJgnITBxvJKao=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GvCdU8x2KLkBhx2HRHfo/HkydqpcdRm47GFIAIrAjSNf9wrEtPjYBVSMWb39ybzXjMTTiyoQCqRgjZJwZmpmOZUA9a8c19KoN1gbldecBl8yvmdW0FyPst4R042hl0VEkq1iLD4GUEotDjwtu+khSzTdl/XHsWpjcgUhAmu1xXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fFccnsVL; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732045360; x=1763581360;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EZ4M12flvJ/2/quhrIG/vroqAO4Kj6vJgnITBxvJKao=;
  b=fFccnsVL1BM6I17w27qc9Nff7V6cwSucWAkbTQwvrfBg3zrffac1ttwP
   gDewTi14ghQHx0yXpHQHDCCPP9Zq80BPygF/RSdp2j222ZlTtamQoYYlB
   qXmu011zzjDYu7kV76eweiVijSS+Xu6h6LOUA7NVc2kpQ+4OoSnxD6qfP
   id2Ep8D7Ic8JdNJiUyARa+/wdKfUnGYnbQvfOU6a7YHKd+xIjATSIgDr1
   VLlav0EXiw5tuCJEBJlt8T1SwrXgHSexjmUFn61vZjN/JGdri33gN9zQx
   dZk2lB7dm7W6iJfA6qQKg8zyGBhSNEO4Bd6RftIaaI9lRdo9+cW3hpQEM
   Q==;
X-CSE-ConnectionGUID: 1SrPjBjoQg6isEQvuFLkgQ==
X-CSE-MsgGUID: 4MaBMGVKQoilMypQzOW8ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="32010096"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="32010096"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 11:42:40 -0800
X-CSE-ConnectionGUID: P+ucKlwGRT6sqsw+5gC4Og==
X-CSE-MsgGUID: NqgrK+q4SGS4aHjndE2+Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="90073926"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2024 11:42:39 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 11:42:38 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 19 Nov 2024 11:42:38 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 11:41:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpNyt08wAKuV80BXRwpCf4c+d+S6yQYjl2oopwDKmFthevr62kG5keEjPLQWlr5yNUKadb5RzC2DbWuTw8s3mmQ6n+Te1Zs4VnOY+yR5mC1g7H/mtDHul7CycQ0eZeh6QX2Ik65hQ50HFbnGWCbklGVvMft6R69efE8zjCAWXZccAAWkxKPq1nBGvBNOTR7gPEyCY9CVo+NADote0xYOvE24grjpFsOwDNejffnkBdP87yJRZ/ydyvsbb/7Sad8kL3CJTZubOZikFjIBkeChVAJLDj+N06k7hoBRxKmXNzJhe9nfliX/duxmJwAJwexxwKMSjqtymb9dbBqWWsI6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ4M12flvJ/2/quhrIG/vroqAO4Kj6vJgnITBxvJKao=;
 b=YULPEHfIch1g54ZGo3sf9Y1uijy5dx1QnOc/vQNepcGPILwfQlUPpag4ajlmLmethUcNekMlj+jCnLm4hSKwsheyXE1BvmHubAj0phKJ3bNBWPFifVSgu1iJixYt/xMLUtHRkSkkJArBJnZ3ihmpJioeLQwaVYoCLZTo8gzxBkAusLV/k7j+WeB4+DaGHRJwy3Fb8g5WYkFa0XUBF0B99qBKIv8wkmZVntrkHEU2S+KJk6JlkAeVCJxuh/ejusdWkVE9MzkcYc5xfMOSoMtIiabOahYZqMmI+268DPMZ0FfJNqAKwjYxBB9WzhpZ4waJfp7I4CfdElp8MknVOIJIfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by DM4PR11MB8129.namprd11.prod.outlook.com (2603:10b6:8:183::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Tue, 19 Nov
 2024 19:41:46 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 19:41:46 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: Chengming Zhou <chengming.zhou@linux.dev>, Johannes Weiner
	<hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Topic: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Index: AQHbNYxgo97ShYNp0k+eAlG8E2BdYbK0sGWAgAAC9UCAAAo2gIAAydcggAAz64CAAATjwIAALQAAgAAWEyCAADkJgIAAFDJAgAAQz4CAAnAwsIAAE8aAgAYeOFCAAANpAIAAAiqQ
Date: Tue, 19 Nov 2024 19:41:46 +0000
Message-ID: <SJ0PR11MB5678A7DF494C3FCB687D620EC9202@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
 <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkbLtjQqR-uf8EBoFCWbkYOLHsVh6vJoMZUj+z4eN0GKAQ@mail.gmail.com>
 <SJ0PR11MB56781940E69ABE93FF9076F6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20241113213007.GB1564047@cmpxchg.org>
 <SJ0PR11MB5678C24CDF6AA4FED306FC71C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=P6mxZ+-5UcunRHeoAVwtZD=UMfKqCGUeun-krJeT8ekg@mail.gmail.com>
 <SJ0PR11MB56785F052557B685054AF74AC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20241114051149.GC1564047@cmpxchg.org>
 <SJ0PR11MB56780DD2A8EB343627FE94FCC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <9a807484-6693-4e2a-a087-97bbc5ee4ed9@linux.dev>
 <SJ0PR11MB567847C73338BC325FE49D11C9242@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkZ+OM2uiHgHHeNqBeSaptfXw4MG=E280-5PKpeybB=8dQ@mail.gmail.com>
 <SJ0PR11MB5678C6C693444F64E38CE2EBC9202@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkaMMoPjrR7mLNMiFD7nOhUoLBJ22BNQYEPvfPww5d2jTg@mail.gmail.com>
In-Reply-To: <CAJD7tkaMMoPjrR7mLNMiFD7nOhUoLBJ22BNQYEPvfPww5d2jTg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|DM4PR11MB8129:EE_
x-ms-office365-filtering-correlation-id: 7d70c7f6-4df7-45d0-2caf-08dd08d23401
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TFVWYlhFdDRZSWEyaml3RHQvZnVpbHU0S1dYVmdHWkhrOFJ4b3dRMHJUMk1z?=
 =?utf-8?B?ZEdaRGZ3bTlQY0YwWlFDOEM1S1BPZlljMU5SK0ZaVEdmMmloOGFXQ094TDdw?=
 =?utf-8?B?VFhoUEFyRDBCdnpJMmt3L1kxbHVsaXg3M25mQ1dRSzRVc3VUZmlwYnN1cmtn?=
 =?utf-8?B?Ukk1Q0hLK2ZqemNya3A2dFI1Z0xPa2dJczMxMzVrczEvVlMxcHhsbUV1NTVC?=
 =?utf-8?B?cXBKUjJabmU2Q0tDQlRPNEQrTGFIWFgzd1MzeVdoVHZvQy9pc0Y1Sm5CN29k?=
 =?utf-8?B?MjZUaEVpOE1kUXhWVk1UVlQrRVc0cGhHcktGeFhGT3JoRngyWUtwLzREdWJG?=
 =?utf-8?B?T0xFYUh2Rm1rWjBwVjRoUzc1TTR5WnAxbDhJeHBMRWF2WjAyMS8vTVRVUDBC?=
 =?utf-8?B?c1Y5R2hkL0FncEt2eVIyZk9mTm12bGVsS0xRVnJOUm0wMnYzU3V4RFZGN3pZ?=
 =?utf-8?B?ZkpscTdmRVJlUExVNCtPb29tRGZPUThsNjJDdHMxL0dtWk1walQydUFhOUk4?=
 =?utf-8?B?cFN0Y2ZvTDZCSWV5RVNlVFZuODkzT005YUlzSEtvcG9peklKdTl2SXdHVXVo?=
 =?utf-8?B?RzhlbFNoUnNMN1kxMlEvVlBDcTZaMlhaTVU3dVEwdWRQVDlOSDUrTlM1WHQz?=
 =?utf-8?B?a0RtSFRxbVN0V2hxUFFQY296MFBjTDIvRi9FRWM1clNURkJVVllFQytaYjZJ?=
 =?utf-8?B?WTAvRDdVUytuWjQ5MkNaT3FHek11MnpwblZDSmVaTUFwODNoUHlGU3ZvVmdp?=
 =?utf-8?B?eUtHeDdsV2h5OThNdk80VjBMYkFtSStnTkVua1dEdVcyNGp0eGlIWkJIRUY3?=
 =?utf-8?B?eWFSVFc1MHBhbmMyUXVYY2dYRGt5THlyNGVacXNYWWxpd0s1UGxJNWsvZ0NW?=
 =?utf-8?B?Q2pxZS9ZdSswcFRjaWxoSjZFeUM0UDlCOVlTQ09qM2RJd3NEN3V2MWJKcERV?=
 =?utf-8?B?SGZrd2VqRndoaDEwY1hOQVhhejRvNG9yRlhvVm5FVEo0cXg1NU1SajBIdHV1?=
 =?utf-8?B?c3BNTUlKYktmQkVxVEtxN2ZWWEphdE1wczYxMVZlL1IvYVYrTUtIVzAzOUE2?=
 =?utf-8?B?TXpacGZZODBjdW12a3c2b3pmYWUrRTFMcGhoQi9talJKK1RLd2JlSGh2aGpa?=
 =?utf-8?B?TnVlb25XNTB5R05lQkt6SXFSMEVWNGZ0Umd2Y2hFeEhGU3BUZlNZWFAveXYw?=
 =?utf-8?B?TDhDbzlNK2IyVUNpQ3BZek9DTHZPaENRQ1RTeUllNUpZOHhDR3ZPOHpUM3JB?=
 =?utf-8?B?ZzBYTzJacUNWZmJmNEhUR0ttWGI1em02U09XUEVBc09CRDk2cHNiSlNqNFd6?=
 =?utf-8?B?VE1uWHZoZGVNZTMyZ2dRWXdxOC9IQldFV0tIbGNwODRpbXRhMExGa2N0RG54?=
 =?utf-8?B?V0MvTjVZbVRVZ0tXeEh5YlRqWjVyaXprZkVXSm1ScDhKM0tyTTNMWnhob0NF?=
 =?utf-8?B?U1Fab0JhRG9JMzArR0FwOVJVSVhaaWMrTGJQQ3JURTRGaWxIWkpVSkdYR2tY?=
 =?utf-8?B?NEluUURYNlo3aHlGczFhZ1VnY29LUnJRNlM2YkN1RUhIRUxFNkM1L2xKU3hH?=
 =?utf-8?B?dTlMVGpWS1ArUXFUTktyUFdMQkY1ZGU2NlpGMnFpRlFOaThBZWRDbkU2T3Fm?=
 =?utf-8?B?aFhDRzhzNjhvWHd2VkNDRXE4QWZNL2RBQTRLTnc2d3pVQlkyNWVETDE5T2Mv?=
 =?utf-8?B?SDRybWhYOGRxcGt6Mi9Eck9PMldGRy85RExEaXVmZTVqT1JnbE1KakhNclNP?=
 =?utf-8?B?L0tqRU5JWkpOZ3RUVFJOeitYaTlWbDkvZmsrZkN3OHdsa3JFMm0wQXl0Z1BX?=
 =?utf-8?Q?LUiC3hms8ia89WChcVdzKKPThZ/bjm1LYzpz4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2VETDJ2Ymh0NWF0V25BQU5MRWY2QmxYcVh6NHdzVVdmYlZHNm9reUVIRUFh?=
 =?utf-8?B?V3V0NDFEQ2JVVjduMUF2RlFwTUgvbnVldkIxb25OYXZEanFUbTJTcFlnbVgy?=
 =?utf-8?B?aVQ4MERpVVBXZnp6N3Z4dUxOV0FGT2JpUTY1MTU3RnBkeitqUWFxWWg3dTMx?=
 =?utf-8?B?U05OcXhRS1JQLzY4VnNSbEEwK3l6L3lQeENBcXVYUVdBa1BkMFJ2bWNzL1c1?=
 =?utf-8?B?Ry9vUXBubE1ramhLTkhpZ01JVGUrUWtWMFpSUGc0aWdMMHJEQW9NdldzWi9F?=
 =?utf-8?B?NVNOYU5iZjBZcjVYZjdKNDY0NnVLSXlFdUNqOU9XcjBmOHh1VWx1RW9EVlRx?=
 =?utf-8?B?ZjhvRlpwWVVuQ2VCZ2YwNnNRVHNrK3F5WXJKNFNBMGhMbVFldTJMNEYya3JN?=
 =?utf-8?B?SlFxRS8rM3ZXQ0VKR2JDNUxPV1UvUm1kd0xsUU5mUDhKRklqRy95TytrMksr?=
 =?utf-8?B?NnZ4ZTROTVFvRnRsbGp4WkJUZXRJVUdIOVJlaXlyRXAzaWE0L1prR1V1UEhu?=
 =?utf-8?B?VnUzcWp6aTBGTFc1VlNrNjc0VTFZU2llYzlTVkNHVjJJZHorMFFoMFFPamh5?=
 =?utf-8?B?ZWFQWERMdWJYcUFTRlpRYnh1RWVWdjBPWEFETU5DeVpJUFhCQit3YmRNa1dp?=
 =?utf-8?B?bmNQeTZrWlF6ODVlc3VLdFdUNmRVMDd6WVpkSGhUQzNlMjAzSEdhQnpsS0x6?=
 =?utf-8?B?UUo4bG94ZFpyL0dZNzdFdWZsc1hHcHd6ajFld3BYN0ZVT2RaakxuRHd0NDJz?=
 =?utf-8?B?K1lQRnM3enMwa3FuYXFxTTkwV3I5bUVCMEFQMm9sYjl4dWFnbWZIa1p2aTJF?=
 =?utf-8?B?amJ4UEorL2JyRjdxZ01OL29waGR3M3FKU25ZQzNaS3lsa0ZLMHRkYU9wd2tS?=
 =?utf-8?B?VzI5bTdxNlFjTCt6emVVbFBGenU4TjdJZTRhc1pENStUMmpEMFFwdHdSN0xq?=
 =?utf-8?B?RlM2eTZXOEJEaHFTc3NLM0xFcnp2Z2lzLzl5dWxYS1V0VHk3RmRia081UmUr?=
 =?utf-8?B?OFd5RlIrR2s5Vmh0UTNETjExSW5ISDU3c0h2OE9EVXBiRlZ4N3RCdUxVUzF2?=
 =?utf-8?B?SzBaUE1CbStOcVFSU1Y5L3dNd04rV0RrR2EvQUhrQ2F2OVMzWVR0M3EyQk45?=
 =?utf-8?B?ak4zckVXZDdYNFNuSTUxR3Bicld0ZTg5b3BETm5WL2JOaG5kYXZNdmIrSkpl?=
 =?utf-8?B?UjdSQUtNaitzcmtoYnUrZWxoT0xmaDhCT0JoZWxsYVlydzYxdmJ4d3ZBNFBH?=
 =?utf-8?B?MUpiYm11T2F2WFdNM2xPMU50ZGVkTlNyemg1SXRJUVd2UmhNWUN6WTFEM0NT?=
 =?utf-8?B?eGREbzNJanRBbVREbXkwN055SEQ1RHRlVFdTUGkxTzl5WGpqS1diVSsxMDUz?=
 =?utf-8?B?cndWcnZ4L0R4RG5USDlOLzZQbGJ5UndUVWFnS2ZQLzB2RGNEWDFlNklqYlpn?=
 =?utf-8?B?N3FBMHlIK1J1cG0rTnIvV1drdTM3WUtGd0hhRS9Ya1Axazg2d0U5M0hML3Jx?=
 =?utf-8?B?RFRDSTd0cVRPQzJoeU51SFlBNXFmM3REVCtVd1liakRLVjA3U1VWM3hxZ0Y0?=
 =?utf-8?B?aUFBbXpPSTZrdmZBU3dveklwc0kwdGZZaGJCbWFnNnErL1ZOaVJZWUg2aXo4?=
 =?utf-8?B?SXRwbDREVWlENGh1OGUyd1YzZVpncmFqeDlja1lRUlVQQU00a0lSbE1nb2NI?=
 =?utf-8?B?SWJQRkxoK3YvSzU1eGhxcUNzVGNmdmp6dHpyS011eUdtcHIyb0UxekVjeU1q?=
 =?utf-8?B?TVlrRlU2cG5ENGNrNWFWWDc1ZzJtaEpHZmxxYnJaRDA5MkNyNXFaS2Rveksr?=
 =?utf-8?B?YkVkaWEwMmNRdHBTbmRnTFYrbGx0cUNZYW5PbnBaTW16OXZFNUQySGlGYUxr?=
 =?utf-8?B?dTdocXdodWVVKzJDKytvUFdkeCt1THdoK0lRTnFTa2hTOWxoQXM5RS94eEJT?=
 =?utf-8?B?aEpOTUc3UXc3dDJLZ0RVbUhDMm5nU3R4NlMwYVlLenJOV0MrRHduZWgza3Zj?=
 =?utf-8?B?UEhGTkZHcUJ3cG1hekhSSHZ3ZlJFUHZSdHRhZXZ4ek8zdm9NMkNCaW9UZVM0?=
 =?utf-8?B?VllZUWFsWTM5UnI0bmFzQmVqbVVRbXBUZEoxeThrdXV6blUwbmgrTDZ6Nzhx?=
 =?utf-8?B?WHdyczllUnJUSUFJU3hGaTh1NnZSbUtaVUI4M1JrTW9Ja09hWW5lV3hTa3Zv?=
 =?utf-8?B?MHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d70c7f6-4df7-45d0-2caf-08dd08d23401
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 19:41:46.4745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2U3IOoegEHkr10QG82fNwEryEgHyfsXNZnAEz89VD8XQlEhJm6XvGYJ5ViQSYFZHZrjjsm7DHzxI2eGaMwNpnS+9kbP+5XcgJfL9dlblxSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8129
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlvc3J5IEFobWVkIDx5b3Ny
eWFobWVkQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDE5LCAyMDI0IDEx
OjI3IEFNDQo+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50
ZWwuY29tPg0KPiBDYzogQ2hlbmdtaW5nIFpob3UgPGNoZW5nbWluZy56aG91QGxpbnV4LmRldj47
IEpvaGFubmVzIFdlaW5lcg0KPiA8aGFubmVzQGNtcHhjaGcub3JnPjsgTmhhdCBQaGFtIDxucGhh
bWNzQGdtYWlsLmNvbT47IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1t
bUBrdmFjay5vcmc7IHVzYW1hYXJpZjY0MkBnbWFpbC5jb207DQo+IHJ5YW4ucm9iZXJ0c0Bhcm0u
Y29tOyBIdWFuZywgWWluZyA8eWluZy5odWFuZ0BpbnRlbC5jb20+Ow0KPiAyMWNuYmFvQGdtYWls
LmNvbTsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgRmVnaGFsaSwgV2FqZGkgSw0KPiA8d2Fq
ZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZpbm9kaC5nb3BhbEBpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIG1tOiB6c3dhcDogRml4IGEgcG90ZW50
aWFsIG1lbW9yeSBsZWFrIGluDQo+IHpzd2FwX2RlY29tcHJlc3MoKS4NCj4gDQo+IE9uIFR1ZSwg
Tm92IDE5LCAyMDI0IGF0IDExOjIy4oCvQU0gU3JpZGhhciwgS2FuY2hhbmEgUA0KPiA8a2FuY2hh
bmEucC5zcmlkaGFyQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFlvc3J5IEFobWVkIDx5b3NyeWFobWVkQGdv
b2dsZS5jb20+DQo+ID4gPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDE1LCAyMDI0IDE6NDkgUE0N
Cj4gPiA+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwu
Y29tPg0KPiA+ID4gQ2M6IENoZW5nbWluZyBaaG91IDxjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY+
OyBKb2hhbm5lcyBXZWluZXINCj4gPiA+IDxoYW5uZXNAY21weGNoZy5vcmc+OyBOaGF0IFBoYW0g
PG5waGFtY3NAZ21haWwuY29tPjsgbGludXgtDQo+ID4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1tbUBrdmFjay5vcmc7IHVzYW1hYXJpZjY0MkBnbWFpbC5jb207DQo+ID4gPiByeWFu
LnJvYmVydHNAYXJtLmNvbTsgSHVhbmcsIFlpbmcgPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsNCj4g
PiA+IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBGZWdoYWxp
LCBXYWpkaSBLDQo+ID4gPiA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5v
ZGggPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYx
XSBtbTogenN3YXA6IEZpeCBhIHBvdGVudGlhbCBtZW1vcnkgbGVhayBpbg0KPiA+ID4genN3YXBf
ZGVjb21wcmVzcygpLg0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgTm92IDE1LCAyMDI0IGF0IDE6MTTi
gK9QTSBTcmlkaGFyLCBLYW5jaGFuYSBQDQo+ID4gPiA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVs
LmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IEhpIENoZW5nbWluZywNCj4gPiA+ID4NCj4g
PiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+IEZyb206IENoZW5n
bWluZyBaaG91IDxjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY+DQo+ID4gPiA+ID4gU2VudDogV2Vk
bmVzZGF5LCBOb3ZlbWJlciAxMywgMjAyNCAxMToyNCBQTQ0KPiA+ID4gPiA+IFRvOiBTcmlkaGFy
LCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPjsgSm9oYW5uZXMNCj4g
PiA+IFdlaW5lcg0KPiA+ID4gPiA+IDxoYW5uZXNAY21weGNoZy5vcmc+DQo+ID4gPiA+ID4gQ2M6
IE5oYXQgUGhhbSA8bnBoYW1jc0BnbWFpbC5jb20+OyBZb3NyeSBBaG1lZA0KPiA+ID4gPiA+IDx5
b3NyeWFobWVkQGdvb2dsZS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC0NCj4gPiA+ID4gPiBtbUBrdmFjay5vcmc7IHVzYW1hYXJpZjY0MkBnbWFpbC5jb207IHJ5YW4u
cm9iZXJ0c0Bhcm0uY29tOw0KPiA+ID4gSHVhbmcsDQo+ID4gPiA+ID4gWWluZyA8eWluZy5odWFu
Z0BpbnRlbC5jb20+OyAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC0NCj4gPiA+ID4gPiBm
b3VuZGF0aW9uLm9yZzsgRmVnaGFsaSwgV2FqZGkgSyA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNv
bT47IEdvcGFsLA0KPiA+ID4gVmlub2RoDQo+ID4gPiA+ID4gPHZpbm9kaC5nb3BhbEBpbnRlbC5j
b20+DQo+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gbW06IHpzd2FwOiBGaXggYSBw
b3RlbnRpYWwgbWVtb3J5IGxlYWsgaW4NCj4gPiA+ID4gPiB6c3dhcF9kZWNvbXByZXNzKCkuDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBIZWxsbywNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9uIDIwMjQv
MTEvMTQgMTQ6MzcsIFNyaWRoYXIsIEthbmNoYW5hIFAgd3JvdGU6DQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gPj4gRnJvbTog
Sm9oYW5uZXMgV2VpbmVyIDxoYW5uZXNAY21weGNoZy5vcmc+DQo+ID4gPiA+ID4gPj4gU2VudDog
V2VkbmVzZGF5LCBOb3ZlbWJlciAxMywgMjAyNCA5OjEyIFBNDQo+ID4gPiA+ID4gPj4gVG86IFNy
aWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+DQo+ID4gPiA+
ID4gPj4gQ2M6IE5oYXQgUGhhbSA8bnBoYW1jc0BnbWFpbC5jb20+OyBZb3NyeSBBaG1lZA0KPiA+
ID4gPiA+ID4+IDx5b3NyeWFobWVkQGdvb2dsZS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4gPiA+ID4gPiA+PiBtbUBrdmFjay5vcmc7IGNoZW5nbWluZy56aG91
QGxpbnV4LmRldjsNCj4gPiA+IHVzYW1hYXJpZjY0MkBnbWFpbC5jb207DQo+ID4gPiA+ID4gPj4g
cnlhbi5yb2JlcnRzQGFybS5jb207IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNvbT47
DQo+ID4gPiA+ID4gPj4gMjFjbmJhb0BnbWFpbC5jb207IGFrcG1AbGludXgtZm91bmRhdGlvbi5v
cmc7IEZlZ2hhbGksIFdhamRpIEsNCj4gPiA+ID4gPiA+PiA8d2FqZGkuay5mZWdoYWxpQGludGVs
LmNvbT47IEdvcGFsLCBWaW5vZGgNCj4gPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+ID4gPiA+
ID4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gbW06IHpzd2FwOiBGaXggYSBwb3RlbnRpYWwg
bWVtb3J5IGxlYWsgaW4NCj4gPiA+ID4gPiA+PiB6c3dhcF9kZWNvbXByZXNzKCkuDQo+ID4gPiA+
ID4gPj4NCj4gPiA+ID4gPiA+PiBPbiBUaHUsIE5vdiAxNCwgMjAyNCBhdCAwMTo1NjoxNkFNICsw
MDAwLCBTcmlkaGFyLCBLYW5jaGFuYSBQDQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+Pj4gU28g
bXkgcXVlc3Rpb24gd2FzLCBjYW4gd2UgcHJldmVudCB0aGUgbWlncmF0aW9uIHRvIGEgZGlmZmVy
ZW50DQo+IGNwdQ0KPiA+ID4gPiA+ID4+PiBieSByZWxpbnF1aXNoaW5nIHRoZSBtdXRleCBsb2Nr
IGFmdGVyIHRoaXMgY29uZGl0aW9uYWwNCj4gPiA+ID4gPiA+Pg0KPiA+ID4gPiA+ID4+IEhvbGRp
bmcgdGhlIG11dGV4IGRvZXNuJ3QgcHJldmVudCBwcmVlbXB0aW9uL21pZ3JhdGlvbi4NCj4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiBTdXJlLCBob3dldmVyLCBpcyB0aGlzIGFsc28gYXBwbGljYWJs
ZSB0byBob2xkaW5nIHRoZSBtdXRleCBvZiBhIHBlci0NCj4gY3B1DQo+ID4gPiA+ID4gPiBzdHJ1
Y3R1cmUgb2J0YWluZWQgdmlhIHJhd19jcHVfcHRyKCk/DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBZ
ZXMsIHVubGVzcyB5b3UgdXNlIG1pZ3JhdGlvbl9kaXNhYmxlKCkgb3IgY3B1c19yZWFkX2xvY2so
KSB0byBwcm90ZWN0DQo+ID4gPiA+ID4gdGhpcyBzZWN0aW9uLg0KPiA+ID4gPg0KPiA+ID4gPiBP
ay4NCj4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFdvdWxkIGhv
bGRpbmcgdGhlIG11dGV4IHByZXZlbnQgdGhlIGFjb21wX2N0eCBvZiB0aGUgY3B1IHByaW9yIHRv
DQo+ID4gPiA+ID4gPiB0aGUgbWlncmF0aW9uIChpbiB0aGUgVUFGIHNjZW5hcmlvIHlvdSBkZXNj
cmliZWQpIGZyb20gYmVpbmcNCj4gZGVsZXRlZD8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE5vLCBj
cHUgb2ZmbGluZSBjYW4ga2ljayBpbiBhbnl0aW1lIHRvIGZyZWUgdGhlIGFjb21wX2N0eC0+YnVm
ZmVyLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gSWYgaG9sZGluZyB0aGUg
cGVyLWNwdSBhY29tcF9jdHgncyBtdXRleCBpc24ndCBzdWZmaWNpZW50IHRvIHByZXZlbnQNCj4g
dGhlDQo+ID4gPiA+ID4gPiBVQUYsIEkgYWdyZWUsIHdlIG1pZ2h0IG5lZWQgYSB3YXkgdG8gcHJl
dmVudCB0aGUgYWNvbXBfY3R4IGZyb20NCj4gYmVpbmcNCj4gPiA+ID4gPiA+IGRlbGV0ZWQsIGUu
Zy4gd2l0aCByZWZjb3VudHMgYXMgeW91J3ZlIHN1Z2dlc3RlZCwgb3IgdG8gbm90IHVzZSB0aGUN
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IFJpZ2h0LCByZWZjb3VudCBzb2x1dGlvbiBmcm9tIEpvaGFu
bmVzIGlzIHZlcnkgZ29vZCBJTUhPLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBhY29tcF9jdHgg
YXQgYWxsIGZvciB0aGUgY2hlY2ssIGluc3RlYWQgdXNlIGEgYm9vbGVhbi4NCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IEJ1dCB0aGlzIGlzIG5vdCBlbm91Z2ggdG8ganVzdCBhdm9pZCB1c2luZyBhY29t
cF9jdHggZm9yIHRoZSBjaGVjaywNCj4gPiA+ID4gPiB0aGUgdXNhZ2Ugb2YgYWNvbXBfY3R4IGlu
c2lkZSB0aGUgbXV0ZXggaXMgYWxzbyBVQUYsIHNpbmNlIGNwdSBvZmZsaW5lDQo+ID4gPiA+ID4g
Y2FuIGtpY2sgaW4gYW55dGltZSB0byBmcmVlIHRoZSBhY29tcF9jdHgtPmJ1ZmZlci4NCj4gPiA+
ID4NCj4gPiA+ID4gSSBzZWUuIEhvdyB3b3VsZCB0aGUgcmVmY291bnRzIHdvcms/IFdvdWxkIHRo
aXMgYWRkIGxhdGVuY3kgdG8genN3YXANCj4gPiA+ID4gb3BzPyBJbiBsb3cgbWVtb3J5IHNpdHVh
dGlvbnMsIGNvdWxkIHRoZSBjcHUgb2ZmbGluaW5nIGNvZGUgb3Zlci1yaWRlDQo+ID4gPiA+IHRo
ZSByZWZjb3VudHM/DQo+ID4gPg0KPiA+ID4gSSB0aGluayB3aGF0IEpvaGFubmVzIG1lYW50IGlz
IHRoYXQgdGhlIHpzd2FwIGNvbXByZXNzL2RlY29tcHJlc3MNCj4gPiA+IHBhdGhzIGdyYWIgYSBy
ZWYgb24gdGhlIGFjb21wX2N0eCBiZWZvcmUgdXNpbmcgaXQsIGFuZCB0aGUgQ1BVDQo+ID4gPiBv
ZmZsaW5pbmcgY29kZSBvbmx5IGRyb3BzIHRoZSBpbml0aWFsIHJlZiwgYW5kIGRvZXMgbm90IGZy
ZWUgdGhlDQo+ID4gPiBidWZmZXIgZGlyZWN0bHkuIFRoZSBidWZmZXIgaXMgb25seSBmcmVlZCB3
aGVuIHRoZSByZWYgZHJvcHMgdG8gemVyby4NCj4gPiA+DQo+ID4gPiBJIGFtIG5vdCBmYW1pbGlh
ciB3aXRoIENQVSBob3RwbHVnLCB3b3VsZCBpdCBiZSBzaW1wbGVyIGlmIHdlIGhhdmUgYQ0KPiA+
ID4gd3JhcHBlciBsaWtlIGdldF9hY29tcF9jdHgoKSB0aGF0IGRpc2FibGVzIG1pZ3JhdGlvbiBv
ciBjYWxscw0KPiA+ID4gY3B1c19yZWFkX2xvY2soKSBiZWZvcmUgZ3JhYmJpbmcgdGhlIHBlci1D
UFUgYWNvbXBfY3R4PyBBIHNpbWlsYXINCj4gPiA+IHdyYXBwZXIsIHB1dF9hY29tcHRfY3R4KCkg
d2lsbCBiZSB1c2VkIGFmdGVyIHdlIGFyZSBkb25lIHVzaW5nIHRoZQ0KPiA+ID4gYWNvbXBfY3R4
Lg0KPiA+DQo+ID4gV291bGQgaXQgYmUgc3VmZmljaWVudCB0byBhZGQgYSBjaGVjayBmb3IgbXV0
ZXhfaXNfbG9ja2VkKCkgaW4NCj4gPiB6c3dhcF9jcHVfY29tcF9kZWFkKCkgYW5kIGlmIHRoaXMg
cmV0dXJucyB0cnVlLCB0byBleGl0IHdpdGhvdXQgZGVsZXRpbmcNCj4gPiB0aGUgYWNvbXA/DQo+
IA0KPiBJIGRvbid0IHRoaW5rIHRoaXMgd29ya3MuIEZpcnN0IG9mIGFsbCwgaXQncyByYWN5LiBJ
dCdzIHBvc3NpYmxlIHRoZQ0KPiBtdXRleCBnZXRzIGxvY2tlZCBhZnRlciB3ZSBjaGVjayBtdXRl
eF9pc19sb2NrZWQoKSBidXQgYmVmb3JlIHdlDQo+IGRlbGV0ZSB0aGUgYWNvbXBfY3R4LiBBbHNv
LCBpZiB3ZSBmaW5kIHRoYXQgdGhlIG11dGV4IGlzIGxvY2tlZCwgdGhlbg0KPiB3ZSBkbyBub3Ro
aW5nIGFuZCBlc3NlbnRpYWxseSBsZWFrIHRoZSBtZW1vcnkuDQoNClllcywgdGhpcyB3b3VsZCBh
c3N1bWUgdGhlIGNwdSBvZmZsaW5pbmcgY29kZSByZXRyaWVzIGF0IHNvbWUgaW50ZXJ2YWwsDQp3
aGljaCBjb3VsZCBwcmV2ZW50IHRoZSBtZW1vcnkgbGVhay4NCg0KPiANCj4gU2Vjb25kLCBhbmQg
cHJvYmFibHkgbW9yZSBpbXBvcnRhbnQsIHRoaXMgb25seSBjaGVja3MgaWYgYW55b25lIGlzDQo+
IGN1cnJlbnRseSBob2xkaW5nIHRoZSBtdXRleC4gV2hhdCBhYm91dCB0YXNrcyB0aGF0IG1heSBi
ZSBzbGVlcGluZw0KPiB3YWl0aW5nIGZvciB0aGUgbXV0ZXggdG8gYmUgdW5sb2NrZWQ/IFRoZSBt
dXRleCB3aWxsIGJlIGRlbGV0ZWQgZnJvbQ0KPiB1bmRlciB0aGVtIGFzIHdlbGwuDQoNCldvdWxk
bid0IHRoaXMgYW5kIHRoZSByYWNlIGRlc2NyaWJlZCBhYm92ZSwgYWxzbyBiZSBpc3N1ZXMgZm9y
IHRoZQ0KcmVmY291bnQgYmFzZWQgYXBwcm9hY2g/DQoNCkFsc28sIEkgYW0gd29uZGVyaW5nIGlm
IHRoZSBtdXRleCBkZXNpZ24gYWxyZWFkeSBoYW5kbGVzIGNhc2VzIHdoZXJlDQp0YXNrcyBhcmUg
c2xlZXBpbmcsIHdhaXRpbmcgZm9yIGEgbXV0ZXggdGhhdCBkaXNhcHBlYXJzPw0KDQpUaGFua3Ms
DQpLYW5jaGFuYQ0KDQo+IA0KPiA+IElmIHRoaXMgaXMgYW4gYWNjZXB0YWJsZSBzb2x1dGlvbiwg
aXQgd291bGQgYWxzbyByZXF1aXJlIHVzDQo+ID4gdG8gbW92ZSB0aGUgbXV0ZXhfdW5sb2NrKCkg
dG8gb2NjdXIgYWZ0ZXIgdGhlICJpZiAoc3JjICE9IGFjb21wX2N0eC0NCj4gPmJ1ZmZlcikiDQo+
ID4gaW4genN3YXBfZGVjb21wcmVzcygpLiBUaGlzIHdvdWxkIGVuc3VyZSBhbGwgZXhpc3Rpbmcg
enN3YXAgY29kZSB0aGF0J3MNCj4gPiB3aXRoaW4gdGhlIG11dGV4X2xvY2soKS1tdXRleF91bmxv
Y2soKSB3aWxsIHdvcmsgY29ycmVjdGx5IHdpdGhvdXQNCj4gPiB3b3JyeWluZyBhYm91dCB0aGUg
YWNvbXBfY3R4IGJlaW5nIGRlbGV0ZWQgYnkgY3B1IG9mZmxpbmluZy4NCj4gPg0KPiA+IE5vdCBz
dXJlIGlmIHRoaXMgd291bGQgYmUgYSBjb21wcmVoZW5zaXZlIHNvbHV0aW9uLCBvciBpZiBpdCB3
b3VsZCBoYXZlDQo+ID4gdW5pbnRlbmRlZCBjb25zZXF1ZW5jZXMgdG8gdGhlIGNwdSBvZmZsaW5p
bmcgY29kZS4gV291bGQgYXBwcmVjaWF0ZQ0KPiA+IGNvbW1lbnRzLg0KPiA+DQo+ID4gVGhhbmtz
LA0KPiA+IEthbmNoYW5hDQo=

