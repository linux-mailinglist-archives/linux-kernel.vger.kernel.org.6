Return-Path: <linux-kernel+bounces-333920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 576EE97CFE0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 04:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801B61C223A9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 02:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037E8B676;
	Fri, 20 Sep 2024 02:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E3IQ2Di5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286B3AD5B
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726798947; cv=fail; b=XardsNM5laXCZzPI9JVh3tkzaG8spKkdrua6XZUVtlq1ak9TIeC6o20bG+bvEdqWhNr9MwYfm0iG748Ty8Iuy8KMwsBtDtU4kOAD/2pPjcsNkNJHh15Kva593KGqkHB2NWZSgQ5gEBtLYgKbs387xaYO7iZDhfJ8NcfeRqt30T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726798947; c=relaxed/simple;
	bh=hqa0sm1QUgdo+b0TQfCNPOMCTxN7JoQaJerfn7oo/BY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uSaRWTuqih9GDLFKcXVbikgW6+V8l1xwV41JRfoexqkUwIYpWCeT70Eh6siFyQmzHboDowd0pHa23TEXluaN6YR/E8tjhF2rjymMGCPFKLLRXQHvtwp0Bt1HMIDs8ZK4uEiZwAL0v7RKoMqoQloTJ0Qqh8eLY7JygLZuPBTxnsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E3IQ2Di5; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726798945; x=1758334945;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hqa0sm1QUgdo+b0TQfCNPOMCTxN7JoQaJerfn7oo/BY=;
  b=E3IQ2Di5b78zRb9by49n6JhtiKGDI+XMW/yuiRMAbALzRjDpD0ZLB409
   5Bt1ll6qxZpssKcM7V3N7qFkpMM1/kRTYlbr3FK3/Y1lLdajQKmfxyWVt
   gNsymGUqiqjQjjol+HHfpyydvAGSBBHB8y3PAHr5p3ljN+nNFNfIf4gWN
   1K/qEMnzPTQOzANozNu7mr+nkvFplo3+8CViF/lbfPxjAocw32AxON6dM
   4ho4j77IqWxwj0ixjNp4m1En0lsILkCFxWnXig7mXgaCKThuPc/s+eAzg
   Itn/9KemSQAY3pudB2Y2+hty+zmK/GMSPYKkxrlXz9w0n6rwDkYcEYrY0
   g==;
X-CSE-ConnectionGUID: Pb+qgWDiR4enP8qt9Enmgw==
X-CSE-MsgGUID: TNguFoXZRumC6CQFZD7uFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25890131"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="25890131"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 19:22:24 -0700
X-CSE-ConnectionGUID: PPOR1JAtS/mg5l39HZe1eg==
X-CSE-MsgGUID: 7Lb2G9AxRo+xlH0SRgripw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="70446453"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 19:22:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 19:22:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 19:22:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 19:22:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCdKKNfiSHOYX/revVptPWFEPad3K4tD3/ETkLQzE0dr6UjpFuPAelW+lKaI92ZYiQan2TJVXjkG9z2AlPPx1PcyndS1ReN3+zG+aOffX6hPGlR2K/IVZfyHMSvyIqC9dLaRu/do0W5BGdbJvlHmv2OZHzuTXevfR+uD+Cq5h8dlnwMRutAjAat89hRd1ZxY0QyemgdAZ1iN/50KvoSRg651Nyd8//CSQnSzss0/HJasOAbb6Admh1decD28AWEz5fOtBcT5b2BcwFrML6tXWp2cR/igRcbCfxVNoRhhsVKhPNFFNxJ3KCNUjADd8BVf/djQvNihsF9fzAzIPCsaSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqa0sm1QUgdo+b0TQfCNPOMCTxN7JoQaJerfn7oo/BY=;
 b=KAoykyj2YO0oPFrWKpBukyLiFowxPF0lQj5ijoKMV+gIKvk3nsPMt600Y4p1sLkBldUuwdTiuaK540rdXJC0gxbls7JtMfuKhju8B7q9lGtHFOyfyuz/n+Ykp5H/tvqF0NyuwkiorDOQaN99roqJVHmhpe1IhU5LmcLKhjJ+gNvj6b+d3Y3zEM3AEt/81spABk2Mxs77dL7cIwpvda7c365srtsUsFMwrG6izvjYp9sv+3RjIzilHdWqN7r2zuLwp9g/q8ajSOAdjOZH4WKoURVKEUjmDVkQQHLbzw5RBi/d7hfFjXDpjbVt3TbDnqv2CpV7/lsEsuM4Pbmch3sp5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by DM4PR11MB6408.namprd11.prod.outlook.com (2603:10b6:8:b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Fri, 20 Sep
 2024 02:22:20 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 02:22:20 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali,
 Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa+lo8ysIDIejPvUy4b6yFKhIRqLI+1o8AgAAPzYCAAAKegIAhKVrw
Date: Fri, 20 Sep 2024 02:22:20 +0000
Message-ID: <SJ0PR11MB567819D1B7D112512778D0D6C96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkaqp_3YbK_qsq+v2=Q0r4xwTG9PbbPYjQdpTBu_Z7K5_A@mail.gmail.com>
 <CAKEwX=PXvLZ0GBgBbxSX5qvB-5dYuQ=5Z88UN3oGmNxFMnMtrg@mail.gmail.com>
 <CAJD7tkbYufUeWWLh=WU1xgeVLMaoafPz+SHgtf+JtYWN+6PbHg@mail.gmail.com>
In-Reply-To: <CAJD7tkbYufUeWWLh=WU1xgeVLMaoafPz+SHgtf+JtYWN+6PbHg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|DM4PR11MB6408:EE_
x-ms-office365-filtering-correlation-id: 151ac4a6-9b2c-4cfb-c4af-08dcd91b0e3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YTBOR094aGRQdFdQeVZ5Y1d1SlVuQWpqNEdkRzVwdDcyYUR2UFhzUVRhMlJN?=
 =?utf-8?B?THU2dDVxU1krVE9FYzNYcGlBNzhVYTNYK0dvUFRDTHNhRzZoY3NEK3ZPQWlZ?=
 =?utf-8?B?QzU5RkgvaFBVclNjVGhWdmtXaTdxc2VML09MWUY2OWRBQzd3aXVYeWtsUlZo?=
 =?utf-8?B?SkFGUHRPVG5SRnIvRVRzcnZIYlpnV2M3by80VUpoU05rRGRqYUlvQ3JzNFB5?=
 =?utf-8?B?ejJ5ajBuTlJWTWVJcjdCTlZRbjlRc0pBM2hUc093SGNVbjFoL0RZTzhZNis0?=
 =?utf-8?B?UjlyZVpJQy9HN3lKOHdONmE5QWhoRVl3ZUJERVlVVmFzdGZqSjJ4bVJvNFFO?=
 =?utf-8?B?NTVUcmFEcFB1U0J0bVZESDlxSTFNVTN5cTdKT1ZZbDB5SEFiY291R1BTLyty?=
 =?utf-8?B?SmFWQmM1NGgvRmszOFNycEN5TWF0UUJzd095YlZnMGtHaWRpelAzREJVYWNy?=
 =?utf-8?B?WG03bi9yRmMzTDJHMXgySjlaejUrV1BFRmV6QTd4REcrU2Y2eDVibXZwQkVj?=
 =?utf-8?B?UTNYdmh1UXBneHZHVEplTkZucmptUVlCdEN3cmZadWNnYzcrRGJGNXpqdlZj?=
 =?utf-8?B?bCtvbU5hZUkydDNMc0tCVnpIWkpkZGRQc1RkQnhjdW01dUhWWXdSYkc5TkZh?=
 =?utf-8?B?alZ0NU8yanhaK3ZjV2luWWJOWElVR1hiRnpCWkF5R1lhYzRMK1dXMFBha0I4?=
 =?utf-8?B?M2xGVU1WajZ3Rlp4dW9BdlY0dmNWV3IvUkJqU3JvSjkwMzJwK2R0TXlvUmFX?=
 =?utf-8?B?S0ZtSWpualg2Q1QzNWFUNkdOYktYQVpjRkZUTlhDbVcvRktETUEwVGduME9q?=
 =?utf-8?B?RmRwcmxGS1BTMVhPR0hRbUJGUTNRc3hXUnlqczlEVS9oTmRwY2dVQ3pGTEU5?=
 =?utf-8?B?ZnJtK2EwTlMyOVVndjN0b1BGaTVpcWRSSmVxQjZaaTBZWlNXb1ZMcWZjNXEr?=
 =?utf-8?B?UmIveWNwUXRkUmJDRWNGN1ZwbXJmS082WnZ4OVpNSGtTNWNJRUdUWTJBaUdE?=
 =?utf-8?B?Q2EyWE1hMzRreGM5MTdHeTQraCtMRlVmaEFXUnIwamgwelZnTms5QWRld3pz?=
 =?utf-8?B?dVpYWE4xaU93Z3NPTDE2Yk1KZWtRV1lMUTE0aFBSWVI3SUgvWEd4OFRNR0ZM?=
 =?utf-8?B?K3h0UGJudk93Y1ByZi9yREJYc1BaWVFlM2xlcXhaa1BEZTU4SjB1T0pMOVU2?=
 =?utf-8?B?eGFxazI0VFR2aEZUaWhodm1JZGh2Ykc1dnJmaXN0YkxSTkdqcFZ4bCtrOWRa?=
 =?utf-8?B?d1h1emUxTTF0WHZMM2dKSk1jQU15dGpJeTBybGJLMXQ4d1kxQnhuajhFUWg1?=
 =?utf-8?B?WUxOcnRnOTQ1Nk1KSGZYVGRIWlNmUzV1QWwwRVhMS3FvNHAwV1Rha0MzWkJZ?=
 =?utf-8?B?YjFiMmxYOGZuaG1IRW9sQVBEYmRSZkJ1aUkra3NjdEFtMzd6NUxCZGU3MEtl?=
 =?utf-8?B?YklnSG9TZldNQUdCR3Bka3cxWXBIcis1bU9KZGRmSUZIOXhsWS85S3NqRVQv?=
 =?utf-8?B?UmdwYVhXaXpjTzJWWFVCV210dVNHWlErakgyOVBWTm5VV01WODc4OHUzMy9i?=
 =?utf-8?B?WE15SVVPT3dOVEU5MGVjdFdqV3IzenlzZ0ZOb2NMOTBpZ3IrYzNmUnZpVUc3?=
 =?utf-8?B?T25WcXpYS3hwSFk3YnVLaTJKSXFHU1NiVDFlNDh0RTFXeU0wR2lRd2pKd2dm?=
 =?utf-8?B?V1huOGZuL2JDc2dJZUF2bXpUY0thck5DMmZxeDMxMUNBNllqVE9YSTdwZTc5?=
 =?utf-8?B?M3RmdXA4QlZibFlMd2krMjc3TURpVkFPTkkwWEh5TmdPbThrUGc0aFNZeWVL?=
 =?utf-8?B?T1RjQnNjQ2szNEt3NmhDeUxZWjhhTVFzZFVnc3E5YmV6RkNCWEkwa2JmNGRw?=
 =?utf-8?B?MHZhSnR2ZDdvY0RnckNhYWVGTjd3dXYrTXU0VFJXczE3WVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUVmNFo3VnBpc0xVLzkzZXFtV0tONy9kdzNUcGZKaksrT0hEVDVIcXZ3V1FC?=
 =?utf-8?B?czdMSkZqWndDZWxCR1NRNDl0VWxpVHdPaUJwVFNJSEQxbUlyeFozcVZvQ1ox?=
 =?utf-8?B?U1lpMXdCUm9ERGhkZHRKNnVjOWV4ektBWEo1NmZXT3hxK1pKV0hHS3dzelZj?=
 =?utf-8?B?Z0dRMll6KzhUOGpkUjBhRlYvTzdnVkhTdDllUjhOajFlRjhtOGxWOVZ1YVhi?=
 =?utf-8?B?SUswU2xCOXBDNVlmNVRESE5HSTRMMnUwcGJFZlR3WjdObkd2MGpyVm5FMmcx?=
 =?utf-8?B?ZVQ1cTdzWVU3aW5mWGVwY3J2Wi84SHo3ZFJtdHd2dmdkeXFvRDFLNTI3MGxq?=
 =?utf-8?B?NEZoTzBzN2lBL0ord2NkalhnM1ZkYWRqZ2tlQ0ZTbmxnUDJTWHEwcDdhTXBJ?=
 =?utf-8?B?RktiK1IxK1FwanpubDFhdzU1dVVzZTlMbDl2ejNkbFhKaWx2RHd2UHJ2SXlv?=
 =?utf-8?B?ajZqcFczMHRpR3hFRUkrMnFlY3h4QllnQU41ZzBUWC84dGxSU2ZRVnI2dUpZ?=
 =?utf-8?B?VUZLeklBejdBL1piZzRyRUl3TnRnTFZnTzYxUS9iZEwrQlgwMkFnb0w2NmlH?=
 =?utf-8?B?L2VRZnRIWmVSNXlSTG50QmdRTG5BR0tLSTN0cUNjUXY0YnRZcldkQXJhRmN0?=
 =?utf-8?B?b1hidzI2a2tuU3lxR242M2h4SU0xWGRRb3J2ZjI5YzQ0TW1Vd0Y4c0MrcXhy?=
 =?utf-8?B?ZHdjTmdja1pUc3Y0TitmVHlQc1pyRDJ2M1phd3ErbzRpRjZDYzdxdWcvUXBV?=
 =?utf-8?B?MS90cVg5U0JXWDhCZElvaGh1WjFiYm1hYk9ud254VGM0aVVaZXNXRzJwTHpE?=
 =?utf-8?B?VlYzTWEvakFrNWFzNS9odTV4YkgvWUk4OEZGK1AzSytKUHJpK2hDUVdlYm84?=
 =?utf-8?B?QWR1WUlUNkhKRDFrcWo4WjFSTlRNOW10N1VPbFY1QjF6Kzh1QmlUU3VOeEo3?=
 =?utf-8?B?RlpSMisza1Fvd0M1NjVNQU9iMnRFQkl5N0c2OVh6eEJ5Y255QlhwNkU5M3RY?=
 =?utf-8?B?b0RCYmQzSE5CaWN1UXErUXlHMWxSU2VMNjVRRHFoVmdXQzgzMmpiWGxxZ0tj?=
 =?utf-8?B?V1FlMlhLL3NGRll2N2h6RjNPRVpxWVFJS3BmUkZyc0lYb3lxcFNCZXhQU0pI?=
 =?utf-8?B?Sll5MUJBM3p6bTVUejY1dEszVmIzKzYxYWZSWGxYSkpOVlNWRkd5cjdMbUoy?=
 =?utf-8?B?cjNyWlFRT3NHY1Q4RC9mY2g5cUtjRGdZdlpUQ1kzdDRlMkFIRWkvL04ydTJ5?=
 =?utf-8?B?dGs4ZzlJOW9HL0Ewd3Vkd2QrK1cwSndPS1EvMVdzdVFGdU90TlRmOS8rWU95?=
 =?utf-8?B?c2hHWmk3M25SSXoyL05oTWpXc2l1R29TUGt5WDBqMGRjWExKYVo5U2RaS2Ru?=
 =?utf-8?B?Yys2Yjdzb0g5cy9WUGhlOVFXMXlDTTA3bmtUR0hIMkpveGczWEpZMzcvL09L?=
 =?utf-8?B?NkEyS3g0dG5BdEJQVFNpOHJhU0xGUW56bjRNZ21WandCby96SXEzY24yZFBD?=
 =?utf-8?B?Q0xMT0MvMXZhOENoU1h4V3pjeGVES3AyTTE3UDU4Q0tLRXdaVWt2Y3kxVDB2?=
 =?utf-8?B?UnlkODFuNXJEMnQxRElyVXA4MlVtNmt0S01wWnAxMm5EN3BlWlZoOWJwdGlE?=
 =?utf-8?B?aHlHOFg3a1A1STRCbjVWUDI4QkpVRFlMdG5ON2YvS0hlblY2Z1p4NTErN2V3?=
 =?utf-8?B?OFpzOHpWQ0FyZ3RIL1QzVkVHYkRqcTdOSVY0NmQ3ZVJWQlF2Z20ycXZRalFo?=
 =?utf-8?B?bkNIOFRoVnptelRva0dBVGNxYmppL2pVWjVicnIxcVBoTUZhV2djZ2xZU3V3?=
 =?utf-8?B?ZjlXWXh5M0IrdThTbGJmQmdzbkxnVklPaHVIYm90UFlsRFVEVEo4MTIvdDJC?=
 =?utf-8?B?N2h4azM1elhreDRrRWc3TFl0SDRWaHZmWXdET0VvUk44RmtvOXc0SjNmc1pD?=
 =?utf-8?B?RWs2MWw1Zzkwd05BL1IwMU15dGdTcFY1QTc1ZmdrVitoVHBobmo2SGhDMkJa?=
 =?utf-8?B?aGJJZEVFMEMzdHR6ejU5SGNFc0dyMFFHcDZzMFZiSzNRK2l2SU0ycjRHNDdi?=
 =?utf-8?B?dVRpT3VpdTRLdzdVY2JZbXNhOWVkYXZOaG1wMDJKTFIrTHVOMjNkdXFCQ2lE?=
 =?utf-8?B?S1czVmVWNFJDakxGWDdPcFUrY25EWlBYeEljalZ3SXNYUmtaekFJeittU0Jv?=
 =?utf-8?B?SUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 151ac4a6-9b2c-4cfb-c4af-08dcd91b0e3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 02:22:20.5424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HJQotNqtIuP5NZH/6rUld4ePkuzra62cSzlXIiDNqOaRQLXBA3X0VykDKF2+ZH9vpx6rtKfxUXHMIoJfuxCf7/7XZwT1Q4HkThMmulpq2/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6408
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlvc3J5IEFobWVkIDx5b3Ny
eWFobWVkQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMjksIDIwMjQgNDo1
NSBQTQ0KPiBUbzogTmhhdCBQaGFtIDxucGhhbWNzQGdtYWlsLmNvbT4NCj4gQ2M6IFNyaWRoYXIs
IEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+OyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBoYW5uZXNAY21weGNoZy5v
cmc7DQo+IGNoZW5nbWluZy56aG91QGxpbnV4LmRldjsgdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsN
Cj4gcnlhbi5yb2JlcnRzQGFybS5jb207IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNv
bT47DQo+IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBab3Us
IE5hbmhhaQ0KPiA8bmFuaGFpLnpvdUBpbnRlbC5jb20+OyBGZWdoYWxpLCBXYWpkaSBLIDx3YWpk
aS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsNCj4gR29wYWwsIFZpbm9kaCA8dmlub2RoLmdvcGFsQGlu
dGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAwLzNdIG1tOiBaU1dBUCBzd2FwLW91
dCBvZiBtVEhQIGZvbGlvcw0KPiANCj4gT24gVGh1LCBBdWcgMjksIDIwMjQgYXQgNDo0NeKAr1BN
IE5oYXQgUGhhbSA8bnBoYW1jc0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gVGh1LCBB
dWcgMjksIDIwMjQgYXQgMzo0OeKAr1BNIFlvc3J5IEFobWVkIDx5b3NyeWFobWVkQGdvb2dsZS5j
b20+DQo+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIFRodSwgQXVnIDI5LCAyMDI0IGF0IDI6Mjfi
gK9QTSBLYW5jaGFuYSBQIFNyaWRoYXINCj4gPiA+DQo+ID4gPiBXZSBhcmUgYmFzaWNhbGx5IGNv
bXBhcmluZyB6cmFtIHdpdGggenN3YXAgaW4gdGhpcyBjYXNlLCBhbmQgaXQncyBub3QNCj4gPiA+
IGZhaXIgYmVjYXVzZSwgYXMgeW91IG1lbnRpb25lZCwgdGhlIHpzd2FwIGNvbXByZXNzZWQgZGF0
YSBpcyBiZWluZw0KPiA+ID4gYWNjb3VudGVkIGZvciB3aGlsZSB0aGUgenJhbSBjb21wcmVzc2Vk
IGRhdGEgaXNuJ3QuIEkgYW0gbm90IHJlYWxseQ0KPiA+ID4gc3VyZSBob3cgdmFsdWFibGUgdGhl
c2UgdGVzdCByZXN1bHRzIGFyZS4gRXZlbiBpZiB3ZSByZW1vdmUgdGhlIGNncm91cA0KPiA+ID4g
YWNjb3VudGluZyBmcm9tIHpzd2FwLCB3ZSB3b24ndCBzZWUgYW4gaW1wcm92ZW1lbnQsIHdlIHNo
b3VsZCBleHBlY3QNCj4gYQ0KPiA+ID4gc2ltaWxhciBwZXJmb3JtYW5jZSB0byB6cmFtLg0KPiA+
ID4NCj4gPiA+IEkgdGhpbmsgdGhlIHRlc3QgcmVzdWx0cyB0aGF0IGFyZSByZWFsbHkgdmFsdWFi
bGUgYXJlIGNhc2UgMSwgd2hlcmUNCj4gPiA+IHpzd2FwIHVzZXJzIGFyZSBjdXJyZW50bHkgZGlz
YWJsaW5nIENPTkZJR19USFBfU1dBUCwgYW5kIGdldCB0byBlbmFibGUNCj4gPiA+IGl0IGFmdGVy
IHRoaXMgc2VyaWVzLg0KPiA+DQo+ID4gQWgsIHRoaXMgaXMgYSBnb29kIHBvaW50Lg0KPiA+DQo+
ID4gSSB0aGluayB0aGUgcG9pbnQgb2YgY29tcGFyaW5nIG1USFAgenN3YXAgdi5zIG1USFAgKFNT
RClzd2FwIGlzIG1vcmUNCj4gPiBvZiBhIHNhbml0eSBjaGVjay4gSU9XLCBpZiBtVEhQIHN3YXAg
b3V0cGVyZm9ybXMgbVRIUCB6c3dhcCwgdGhlbg0KPiA+IHNvbWV0aGluZyBpcyB3cm9uZyAob3Ro
ZXJ3aXNlIHdoeSB3b3VsZCBlbmFibGUgenN3YXAgLSBtaWdodCBhcyB3ZWxsDQo+ID4ganVzdCB1
c2Ugc3dhcCwgc2luY2UgU1NEIHN3YXAgd2l0aCBtVEhQID4+PiB6c3dhcCB3aXRoIG1USFAgPj4+
IHpzd2FwDQo+ID4gd2l0aG91dCBtVEhQKS4NCj4gDQo+IFllYWgsIGdvb2QgcG9pbnQsIGJ1dCBh
cyB5b3UgbWVudGlvbiBiZWxvdy4uDQo+IA0KPiA+DQo+ID4gVGhhdCBzYWlkLCBJIGRvbid0IHRo
aW5rIHRoaXMgYmVuY2htYXJrIGNhbiBzaG93IGl0IGFueXdheS4gVGhlIGFjY2Vzcw0KPiA+IHBh
dHRlcm4gaGVyZSBpcyBzdWNoIHRoYXQgYWxsIHRoZSBhbGxvY2F0ZWQgbWVtb3JpZXMgYXJlIHJl
YWxseSBjb2xkLA0KPiA+IHNvIHN3YXAgdG8gZGlzayAob3IgdG8genJhbSwgd2hpY2ggZG9lcyBu
b3QgYWNjb3VudCBtZW1vcnkgdXNhZ2UNCj4gPiB0b3dhcmRzIGNncm91cCkgaXMgYmV0dGVyIGJ5
IGRlZmluaXRpb24uLi4gQW5kIEthbmNoYW5hIGRvZXMgbm90IHNlZW0NCj4gPiB0byBoYXZlIGFj
Y2VzcyB0byBzZXR1cCB3aXRoIGxhcmdlciBTU0Qgc3dhcGZpbGVzPyA6KQ0KPiANCj4gSSB0aGlu
ayBpdCdzIGFsc28gdGhlIGZhY3QgdGhhdCB0aGUgcHJvY2Vzc2VzIGV4aXQgcmlnaHQgYWZ0ZXIg
dGhleQ0KPiBhcmUgZG9uZSBhbGxvY2F0aW5nIHRoZSBtZW1vcnkuIFNvIEkgdGhpbmsgaW4gdGhl
IGNhc2Ugb2YgU1NELCB3aGVuIHdlDQo+IHN0YWxsIHdhaXRpbmcgZm9yIElPIHNvbWUgcHJvY2Vz
c2VzIGdldCB0byBleGl0IGFuZCBmcmVlIHVwIG1lbW9yeSwgc28NCj4gd2UgbmVlZCB0byBkbyBs
ZXNzIHN3YXBwaW5nIG91dCBpbiBnZW5lcmFsIGJlY2F1c2UgdGhlIHByb2Nlc3NlcyBhcmUNCj4g
bW9yZSBzZXJpYWxpemVkLiBXaXRoIHpzd2FwLCBhbGwgcHJvY2Vzc2VzIHRyeSB0byBhY2Nlc3Mg
bWVtb3J5IGF0IHRoZQ0KPiBzYW1lIHRpbWUgc28gdGhlIHJlcXVpcmVkIGFtb3VudCBvZiBtZW1v
cnkgYXQgYW55IGdpdmVuIHBvaW50IGlzDQo+IGhpZ2hlciwgbGVhZGluZyB0byBtb3JlIHRocmFz
aGluZy4NCj4gDQo+IEkgc3VnZ2VzdGVkIGtlZXBpbmcgdGhlIG1lbW9yeSBhbGxvY2F0ZWQgZm9y
IGEgbG9uZyB0aW1lIHRvIGV2ZW4gdGhlDQo+IHBsYXlpbmcgZmllbGQsIG9yIHdlIGNhbiBtYWtl
IHRoZSBwcm9jZXNzZXMga2VlcCBsb29waW5nIGFuZCBhY2Nlc3NpbmcNCj4gdGhlIG1lbW9yeSAo
b3IgcGFydCBvZiBpdCkgZm9yIGEgd2hpbGUuDQoNClRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24s
IFlvc3J5LiBJIGhhdmUgc2hhcmVkIHRoZSBkYXRhIGluIG15IGVhcmxpZXINCnJlc3BvbnNlIHRv
ZGF5LCB0aGF0IHNlZW1zIHRvIGNvbmZpcm0geW91ciBoeXBvdGhlc2lzLiBQbGVhc2UgZG8gbGV0
DQptZSBrbm93IGlmIHlvdSBoYXZlIGFueSBvdGhlciBzdWdnZXN0aW9ucy4NCg0KV2UgZ2VuZXJh
bGx5IHNlZSBiZXR0ZXIgdGhyb3VnaHB1dCBvZiB1c2VtZW0gd2l0aCB6c3dhcC1tVEhQDQphcyBj
b21wYXJlZCB0byBTU0QtbVRIUC4NCg0KVGhhbmtzLA0KS2FuY2hhbmENCg0KPiANCj4gVGhhdCBi
ZWluZyBzYWlkLCBJIHRoaW5rIHRoaXMgbWF5IGJlIGEgc2lnbmFsIHRoYXQgdGhlIG1lbW9yeS5o
aWdoDQo+IHRocm90dGxpbmcgaXMgbm90IHBlcmZvcm1pbmcgYXMgZXhwZWN0ZWQgaW4gdGhlIHpz
d2FwIGNhc2UuIE5vdCBzdXJlDQo+IHRiaCwgYnV0IEkgZG9uJ3QgdGhpbmsgU1NEIHN3YXAgc2hv
dWxkIHBlcmZvcm0gYmV0dGVyIHRoYW4genN3YXAgaW4NCj4gdGhhdCBjYXNlLg0K

