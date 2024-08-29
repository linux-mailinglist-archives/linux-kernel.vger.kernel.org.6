Return-Path: <linux-kernel+bounces-306106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EECB96392D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01FB1F22AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B186A33A;
	Thu, 29 Aug 2024 03:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Anw7A947"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919554CB36
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724903967; cv=fail; b=hdyuc3ayzRaXGD13qJcec6kRQHNQ8xDp84yUUAgcWfZN9qyiWL5rsvSKA6aaVxLll5P/nIXMxP2PSsRSWs7JGs4rj8F/KGygSxkiHZzkaN6My6Ns+kZ5qA6IhzkpbtcsCglzzfV32IeDWf7IFrFO7UZ7Dw9yTvYOLTRAZAX9Hto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724903967; c=relaxed/simple;
	bh=6anVVJskYwmFLo7NMLVFl2pcgNYe0dSlh+UQ37x6xsM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ulu5yzZcdKV/MKyKtPei6D+iqcCruq4WuVueI3Yf6qTA7QlSbILroY5AfYD5Gz32+owjB6UHgKGxEgZ2fIz5+PtA664PgGNR3hTSE0qCCEu+yrjOOSci6xRRQDo/6Cbvv1KfoCx8r5wY0EG/SK02bq1g5KGnWAZR2tTTQpAiQSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Anw7A947; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724903966; x=1756439966;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6anVVJskYwmFLo7NMLVFl2pcgNYe0dSlh+UQ37x6xsM=;
  b=Anw7A947IY6v4Dj2F7itB6kgJeJvJkrGlkkNfzsmN6XV7466eXb7nZD6
   gvyyM6yUJG3lj1SznTj2BgzK0a1kxv+g0wAxZSQ3DFy0scoWCYi7um1r9
   nMRMGMYXEY3g5UkOjBUO4vRG9qkmH7i4bUA9hdKN5ZruV8XlDGOMHxW4V
   wvq7J6vyvMAM43KqxdRcwbFbAEF+cZtKjA2Rrh1aFpzpMwo1S03yTXQSM
   kV3NITMW3G/WgtAEbFRA1QpYQWZ+Iu/gZXC+zk9gxW7dVSG5PqlZD6wyU
   x3J/2wWh44oHDvUpVQNpP1f5l3sQGqWF5IvUj0PY4tZ6YKALlki2UQxb+
   A==;
X-CSE-ConnectionGUID: RoAJ3cVsRUyA6Pk0s69Zbw==
X-CSE-MsgGUID: gLMYVj6yQjm1IM7T6GSu7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="26373125"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="26373125"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 20:59:24 -0700
X-CSE-ConnectionGUID: IQWTcqesTMCmLKaDktp9lQ==
X-CSE-MsgGUID: VfkQC0cMSoq+WWSp78nqtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="100956249"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 20:59:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 20:59:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 20:59:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 20:59:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0p9LgoWOQ2dEY5HO1P2A+qCuxCmEGS0KsUhDgxNGbLcpUqGhuj/F3AjnwZnBc1r+YoSikWZUTGazUiXfj/wvYGz9AFRLRmgQBWqkX+rWqCkjCmAu7LNH3N9lBjB6xaMXpw+cxFnGsPfAcHBhqcwcz5XQPNbD4z4SFxa8RU8/UzujjfnsmdeMwBH2zFq3vqDe1RhONIvqpMFPjydfE6G17Sui0Y43g431qLghfpljy3pu5l8/cFbQOB2pDB9VqpZc/MBSquq7R5xrvzfzmKPXJELXfF6r4y/OoCmQovuKWkddlaDvM2rPpjKAj4FJKLG1s7yGSkJALOe6t2z9XIuOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6anVVJskYwmFLo7NMLVFl2pcgNYe0dSlh+UQ37x6xsM=;
 b=qZUzltiBKR/FhrASguEKMOvbXh+0ufAFcY3G8V3L9ihkueVV4vHrkKOrVpqhsRN1MnkKGMk6PXf3k6I8Rf1D1zypiPXnnY5pLBu7si5kYcflU4u5VppB1Eei7z6gcPAvt4tawHD/sWscmHu4WHoxsExqUQYRvNA7DTD9/lM3MIKuokGoAmIvwKdigd7XtcPekZePQeFaSCBqDpU6bFlNuqQhfU5J566zSHWlWEGURdD5pDF7lLZRyNEU2mWazRSDH3UsBvMmnGwQSBoSJs6DDQDkRthkFSNWDjo8BLkMQrCCAbkeUAfC3gfjpPaeznpKeZojK3mVdso9il4FfcJlRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SA1PR11MB8349.namprd11.prod.outlook.com (2603:10b6:806:383::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 03:59:21 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7875.019; Thu, 29 Aug 2024
 03:59:20 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying"
	<ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa+S2hY1M67nGQo0+E71Bgb79m17I9MgEAgABqysA=
Date: Thu, 29 Aug 2024 03:59:20 +0000
Message-ID: <SJ0PR11MB567876ECDEF81A793A2BF397C9962@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=Pqm3pjOO-ErOTGnNYKwMas4fdiN0bdUcrPHzfKf-Qryw@mail.gmail.com>
In-Reply-To: <CAKEwX=Pqm3pjOO-ErOTGnNYKwMas4fdiN0bdUcrPHzfKf-Qryw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SA1PR11MB8349:EE_
x-ms-office365-filtering-correlation-id: ab8749e6-a391-40f0-a75a-08dcc7def659
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NTh6ZC90RFBWUHF6c0NXK1NjcWZsRFNaSHZUME5IczZGcFhZNlQybVlKMXhQ?=
 =?utf-8?B?UytoNElwVXh2UVJWL09VcjFraEtNaFRHL3V5aDZpNFE1blhCUWpLTTl6Nm43?=
 =?utf-8?B?MnJWT2h2QXlMQTZiZUhJTUJocVcyRWpETFVVYittYTk1RzdGQ014amRLQXBa?=
 =?utf-8?B?TTJJa05DalZVZ0RQaGNDdEVlMnQ4YUZWYWhUelRzaFB0ZmY1cVhSbS9DR0xh?=
 =?utf-8?B?aG1zOG5LcU1IckVkRzg1cXgzT1FTeWRTRGJpdWVXOWNCL25udXBBQXl1TkQz?=
 =?utf-8?B?VXFqZTQ3SDFYd1NEQmM0NHhsNE93ZFRLN2VkcnFOa2Q4WGRFdVN1L29kSVR0?=
 =?utf-8?B?VE4wWnVVRDBFSWlkUCtCampLZHVHb0RxbHA0eEtMcmNlNm9tdkk4NXZnT1Fo?=
 =?utf-8?B?Z0dNUDZlb1JXNXRFbXhBV2poemhXS21WWWphakJTMWs1clh4VUZ6ZGpoYUJR?=
 =?utf-8?B?aW1xQnVicXp2ZmFBSmZoSTQzdFl3VlNueCtwUlNhSjhOS0pOcnRXdGpQcE9C?=
 =?utf-8?B?anp3Rm9UUTN5RW1sZkloc0ZJME83N1Q5R2pJcFZvZU1XeW1VaSsyYVQ2YXVK?=
 =?utf-8?B?RTFCTDNVYThXOGpIZVBab1hiVjZjTGNJTERoYllQR051SlVnOUdjT2RGOGpT?=
 =?utf-8?B?QTkwYkhMemkzNVlwUVRZQklYQkZsb1pvelBxLzNDNkhvZ2xQYlR4dkI4R05o?=
 =?utf-8?B?RlhWNWFRZFVVQUd6QXhNSnlZTGxabzRSVjcweEt6OUtucm02dlhITzk5RVNQ?=
 =?utf-8?B?ZzA5RmYwVWlTOGlqZGt0M29xcEp2VDJHeE9WN0N3TU5aV1F1VlZTQllMcXpi?=
 =?utf-8?B?TzNJT1JRNnpnTU1xZ0l6MHJ6OTcveno3ekZEdm5vN1hPblRyMWVLMlVyeUdD?=
 =?utf-8?B?V1grZXlSaTBhNDZVMzBPK3FZZmViRXBSZjJuVUFaTUhyTHZSUTVPWG1NcnJH?=
 =?utf-8?B?eHBnR3Zhc0RtS1ZWc1h5RlBXNEJxaGIya21FMkhoRmt6OFhlZVZDV3UxSXR4?=
 =?utf-8?B?TkJ2NTJYM0dJTC9JZzd2by9ucU1WQ1FYcmhFQ0pObEEyRmVPcFNsYlBuVTda?=
 =?utf-8?B?WkN6YXN0NFJ0ZHRuRUwrU3RuL2VwMzZ1ZGQ5UzNHU2lManNxdVp2aVdtY3Nw?=
 =?utf-8?B?RlFPSXJEYytJcFVtM2wwWGU3RVRVZFphczhUQzRDRjNEMG9mQ0VhUDdRYnVB?=
 =?utf-8?B?SFJHQzJKTitqYWQweHdwTTBwTm4yVUZmVmVNMzVkeDNYUkpKR2J3VTdybjlJ?=
 =?utf-8?B?SHlQeHFVVHdWbDVwaXVUMGE4dUY2SGovSGczQThwK245MFRlYmNvaVl6MGda?=
 =?utf-8?B?RWhrSHMyd0VMTG1qNzVtUndqcTNhTmpJeithaFRUYUt4a1Y2eDNlclg5Yi8y?=
 =?utf-8?B?TUl5VU5jZVF3Q1d4TWUxY3c2b1ljS3ljSjlNUFFPRTcvb0tsSUJFOFpIc2U0?=
 =?utf-8?B?dlNYRFVxS2NYVzI3SGxHSG9tVDNEOGpkRGsvL1NvaXFQRHVUSWs4VnhDNG1E?=
 =?utf-8?B?eXNRejdqVkxFU0Jac2UxOXBLVEQvQUN2c3E5dzh4Mm5TbWhZbHJKMzd0aHBG?=
 =?utf-8?B?cklnZytZbGRaUkNGaitpYnM2Rm1yakpET1dCMVQ0YWVBTEJWeEF3OTZZb2li?=
 =?utf-8?B?Nkgrc2J4NGx2aFJiNGYzRkJGNU1Od0x5aHlsK01BeWhxRnpzZzh0YmZFbnc5?=
 =?utf-8?B?aWFjQ0NGMGxGdmdyMUhTcDhxbTdaV0djU3dZWHgzUlQwT0hyTExQemtCemln?=
 =?utf-8?B?dmo5OWJFdXMxL2FGa0VyYm5pa2R5WnNVSkNmaEZQSGhXZXY0dkVKMC9iOGJp?=
 =?utf-8?B?dHR5ZEpISGorMmhVd0VQZW9lZCtmWHJnNkcwaHdLZUxBMnNPT3dpcW9NaVg3?=
 =?utf-8?B?QnZZd0E5YTZERmI5QnFsVWp6Kzh5d0hZbCswZDNGcEtyNnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnRYemQzbDQrdjVHVjZPTThkeWZCbzFLNlZlNXZXWFlJTTJrcTZpWFZzY20w?=
 =?utf-8?B?ZlVoeGtnbCtQQkV4bVRTSEUxTkVCZzBta21hUWZZa1hsK3k3WGVSK3hBY1hC?=
 =?utf-8?B?WTVZbnRpQmZmK1hLTmQ3NW9QNzdLemVLdFQrZWQxMXVld0JmWCtkYisvSXM5?=
 =?utf-8?B?WWRDVStPNllwSTRpUTBVeENucXVBa1hSdktQZExRblVHSERIN1BwUHBySGZl?=
 =?utf-8?B?SWZpV20xNFdYOVFuT2ZLSVRLRE5iMisyM283SFpPY3g0QlJ6bnhUdnF1bGly?=
 =?utf-8?B?WENzSCs5ZzdTWldUM0dVek9UNVZTd2pIN2FaUXJNUkNrUWNOSnRMajM2ZUlI?=
 =?utf-8?B?ME5tRHd1TUVwb05JTWtxenNRNjFvMzNsQXkxd0hLNUFScGxYZ2dQL0ZQMzJU?=
 =?utf-8?B?S2g4TThOZ3k1WkgvVmRvWXcxUFpUVW5zWHFHOTdVOEtzSHJpR3JaUTExeFZk?=
 =?utf-8?B?NWltd2dBb3JXMUN3VkhDcmdubjlFRmJza2kzWnNzdi9iT09SVHM4WFhwSVdE?=
 =?utf-8?B?MDRyVGpoQWtDUk5aQ0t3NDN6U0hMSjVhbFJGWWdEcHloQWZlVzQ5SkFudEdJ?=
 =?utf-8?B?S0ZQNSt2WkZhdlpmOTVXazI3NVRoUXhTeXQ5dGJVNnNoazFDNVU0ckJPcUdR?=
 =?utf-8?B?L2VoWCtsMDRCZlJqMTlMSkUzZVE5QWQ4Tmk0RTlRa3FiWHQxS2VaWDhiTGhk?=
 =?utf-8?B?dkc5Z1ZIbmpVWlFGZDBtalNneU9WejlsWWpzK3dPUGNZZFhMa0JTS25BMHVq?=
 =?utf-8?B?Z0ZoSERaYnJGZU4wbkEwR1hXMUNBTjZyb0pHSzhTb1l2UzRHT2xqV2F2R3Za?=
 =?utf-8?B?VXJzTU1CYlQ1U3RGMXRWWEMyb3VCUjZrTUphSzhyYnQ0azVkamNjTXhOZHpv?=
 =?utf-8?B?VmlVSmYrSnJ4c2FSa1JIMG9COXkyUks1SVRXVXV4eVVNT0x3d0hBNWdBcXdn?=
 =?utf-8?B?RVVremVZcHNzanppZlBXVTZvSklXeTBrQWhSOFZnLzNOeGltbTNMS3MzUHFj?=
 =?utf-8?B?L1ZPTnY1ZXkyZEc3US9GUlk5OFhjQVJ1eDIwNStOK0tZaVk3OGRIemRPRmJh?=
 =?utf-8?B?NnpSbU9acEp6bHFGRTdsbzBOMW9rSXNyaHdvNjluUHB5ME0ycS9YWW5nMGhT?=
 =?utf-8?B?enEzVnFNa3Q0OCtjWUdSUWN1bTRPa0VoS0tPbHVzcU1HdmFHV24xaXhpMHZv?=
 =?utf-8?B?ZzhheG92UmJzMmV0U2grd2QvRXlLODlnUW1seUMzaWFPT2R2bGduMTc1cDhs?=
 =?utf-8?B?ZWJtUE1vdTd6cnpkN1NKTk5oTzhKdnlqK3hpRnppL3dxSXJ0TWhienA1Slgy?=
 =?utf-8?B?Vysva0phcTlhSS9hS0tZaVhFSG91K1NPa1N0UE9ZOFZ1VXcxcHQrVHBVTCta?=
 =?utf-8?B?Q3ZXMHRFOHNpbWZOOExFY0FoT08xU0RNNVRJRCtaaHprT0V1NHUxTUlXRkJr?=
 =?utf-8?B?TzJnVURHMlhzdkQveXdTUlo3K1YyYTVsUXF5bGE4djhsOHRpUnFpVUlQMVI4?=
 =?utf-8?B?U3FkaGUvUW1sVUVXR2IvVVFGdkFxSlhOd284dzl6bkViMjlKeEEvdzlWcWdE?=
 =?utf-8?B?cFF5TUt4ZVZ1cDFyTjM5aUszbVNMRjJjdDV4R3U3SmF5YzlteE1sRmdhVjNY?=
 =?utf-8?B?aGJPeU1RNHM0SExjWEs2QWdKeXBpanVPK3ZuazJ5UUswelpNQTI1RWUxMGRG?=
 =?utf-8?B?TzlJWFhzbCtlaXEyK2JBQ29MNHA2cE91WitpSjQ3bE1MdHRBd3FtVndEa1Bw?=
 =?utf-8?B?anJSYVBTWjFnOERBVUZydUJBK0VDQ2JleHRYN2tqRUN6UmlDUFl6SFJWOGpy?=
 =?utf-8?B?dU1hbFdxcFVZTWFrMklJQzUxR1VQemdudmJZcWc3Y1JEVm0yQ0JWOTVXVHFM?=
 =?utf-8?B?eXdpT0VHSkxYdjBUbXh6SjIwZnNMUnoxMEszeEZBMGpEN09Ka1pTMDM0TmVo?=
 =?utf-8?B?b3NYNVp3YnNsUW82OFRnQlVUazE0eGI4QlF3QjZvbnBscHJFOXVNdStvMUJJ?=
 =?utf-8?B?MVAyMmFNZkFwUEsvbFV3SXo3QXE0a1YxR3dIeGFnYjU2T3V3TEkzKzdJQXpI?=
 =?utf-8?B?SExZNUR5UzBxR2FaT3BlUEZoaXVHeDd3U2FOT1I2R2hqWWR2QlZTN3RSTTlC?=
 =?utf-8?B?YXNMQ3ZNUGpFUDVqUVhKaUkwWW4rR3pOQ3k4RHVsN3Ntalcya3BHOXozcFJX?=
 =?utf-8?B?QWc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8749e6-a391-40f0-a75a-08dcc7def659
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 03:59:20.9206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: exV0KzjBYzq5aHuTSjKoJkI8vuOKf8ZytcixZ8sr0U9DtL3ehcvRbNp0we5qtUNxYYIGmccRI2N4cYuK08GuR2RvY69oZBSxRIwGRY7Hotk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8349
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5oYXQgUGhhbSA8bnBoYW1j
c0BnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDI4LCAyMDI0IDI6MzUgUE0N
Cj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+
DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7
DQo+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgeW9zcnlhaG1lZEBnb29nbGUuY29tOyByeWFuLnJvYmVy
dHNAYXJtLmNvbTsNCj4gSHVhbmcsIFlpbmcgPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsgMjFjbmJh
b0BnbWFpbC5jb207IGFrcG1AbGludXgtDQo+IGZvdW5kYXRpb24ub3JnOyBab3UsIE5hbmhhaSA8
bmFuaGFpLnpvdUBpbnRlbC5jb20+OyBGZWdoYWxpLCBXYWpkaSBLDQo+IDx3YWpkaS5rLmZlZ2hh
bGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2NSAwLzNdIG1tOiBaU1dBUCBzd2FwLW91dCBvZiBtVEhQIGZv
bGlvcw0KPiANCj4gT24gV2VkLCBBdWcgMjgsIDIwMjQgYXQgMjozNeKAr0FNIEthbmNoYW5hIFAg
U3JpZGhhcg0KPiA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4gd3JvdGU6DQoNCltzbmlw
XQ0KDQo+IE15IHVuZGVyc3RhbmRpbmcgaXMgZnJvbSB6c3dhcCdzIHBlcnNwZWN0aXZlLCB0aGUg
bGFyZ2UgZm9saW8gaXMNCj4gYnJva2VuIGFwYXJ0IGludG8gaW5kZXBlbmRlbnQgc3VicGFnZXMs
IGNvcnJlY3Q/IFdoYXQgaGFwcGVucyB3aGVuIHdlDQoNClllcywgdGhpcyBpcyBjb3JyZWN0Lg0K
DQo+IGhhdmUgcGFydGlhbGx5IHdyaXR0ZW4gYmFjayBtVEhQIChpLmUgc29tZSBzdWJwYWdlcyBh
cmUgaW4genN3YXANCj4gc3RpbGwsIHdoZXJlYXMgb3RoZXJzIGFyZSB3cml0dGVuIGJhY2sgdG8g
c3dhcCkuIFdvdWxkIHRoaXMNCj4gYXV0b21hdGljYWxseSBwcmV2ZW50IG1USFAgc3dhcGluPw0K

