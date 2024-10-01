Return-Path: <linux-kernel+bounces-346394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2FE98C437
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F361F24E49
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576291CBEA3;
	Tue,  1 Oct 2024 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ucb4TMpR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ABB1CBEA2
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802555; cv=fail; b=p0ySoF8nYbqPQ7S29nH/kkGzlNbiTLaTCOTDE1h/TqxsR/nx64ND1R+dRvNgjR9mrZ+KVNu4GgUHRSvjR//mWTEmbGbVQWeNvPnyV2ziwaVUmMiRZ6g3McnBkCKSXq/3tkNHxS8jw6z56u4oweRCY4qMLgQ3l1Amc42Y3CeXz48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802555; c=relaxed/simple;
	bh=5YyLx2CpwqSNTfAtrF61krfS9j8QTdrzq9McOTu7vRY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CUDNgqmujBv0ciqMgLhxV8mlMxXXYCGFa+vVEQi1DsC0BwODNHAObWV3Qo1iIa+WXGp29Q7ZH0036AMwVb/G4hVhaTvk59lb+jMlqh7nt2d1WcOPeFdpPJfwZnCI5m1CogrZEWE6Wlpt91rfUS+mJg8Mg86BMJJydJB1R/QSxME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ucb4TMpR; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727802554; x=1759338554;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5YyLx2CpwqSNTfAtrF61krfS9j8QTdrzq9McOTu7vRY=;
  b=Ucb4TMpRnos9i8Y0t1WOFzi0sw79kAeV1rLwmu3/XsqAmhoygdtEVNWg
   sG5tM/Ek0CFCeW+hRNaR+8xrrsk0iSYopsjNqaCo/Q3o3epsO9ceWHX9E
   1EYOArBLocURG6uFygNoMyCalGVjvBZfELY5E09t6/A6x7eP3PQAQpvno
   y2Mzhmusi9hy53IBciaGtYGFigGaWEtfwSWRtdMVq3ER0mPCEyD66tW6b
   88kW1Pfk9JePnf8RhQx1XCo3ausPbm+xV3P2QhKx/SY4JBnP4WMxawq9S
   LgabEv9Zo5m7r8jDzYChYpSMJ1FjGv8DCC5saghrWpLtb75SX4AnPT3YU
   A==;
X-CSE-ConnectionGUID: nVAb+vxKQOO86uhBJzCNBg==
X-CSE-MsgGUID: wZUdfesKQIyaxIZzzVDnXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="26903998"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="26903998"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 10:09:13 -0700
X-CSE-ConnectionGUID: pNHijqUyRY66iIacYO34xw==
X-CSE-MsgGUID: OAXjJm/WQ3yjS3trU/V/bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="111200098"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 10:09:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 10:09:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 10:09:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 10:09:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 10:09:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xht0QFXLrxzKuSIiRWmhYHzIICmsKQ16uY+m6iUDAzhI56O55sfUSiEmovUIU5JjPew4JweqJVVAjJa0f/OZTVV8aHE7PB7cBc9w9Q0LL2MqGKOGr5Ivi6qchElIVWlwI3KTpyBHIe+5KUFkehhqY1sJ17c14TRl/qjy8xi5eL6KDYBqBNm8UQhthWPXTpZgjxc34HCDjpjx/uzj2z3VGI7W2jemkhGX0HYpcLK7S4GmnH8lMDoj21lx20ALWlEhKf8h8fASM3GSpSqekoVhQxMO44reNRDOme5KrFLDQp0XaYx7l0LzB8PFtyvytpsMop+KH6QOe0LP68Iyuz00Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YyLx2CpwqSNTfAtrF61krfS9j8QTdrzq9McOTu7vRY=;
 b=rSor5VtUA5ixonRs4OmO4xnxe4NlA8guPFX8xOAS4sC8YWEAB3525KfP8dxd8m9Sl1wm7ggUFGiak377IeAyLPy+hT+ZMok8/rgoJp4ATHVbxf720uXyJnD6zB0ParHydslBldowYH4CPAH1loexZ2wZGy4fGJM0OD00bjpdUiqD19F+NPXQ3Qzw5BDdNpp8TiWUqVk65q9pXYcFa4mUmL8XwbOg9eWsTGfAptBESRMiZa+aKqU5wwta3sFX2O24bnVYV/fLD2syoxsMCygXYpKpiITLb2YRI9FzQwJiOBj9LQfkoG/Q+ATwsxZoeA9vXSlySasqwUgXdUgn/1JQ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SJ0PR11MB5071.namprd11.prod.outlook.com (2603:10b6:a03:2d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 17:09:05 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 17:09:02 +0000
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
	"willy@infradead.org" <willy@infradead.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_store().
Thread-Topic: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_store().
Thread-Index: AQHbE4XaXdnmYogniUi9EO2aNKPUnLJw9HoAgAAUeVCAAF5igIAAt03ggAABbACAAAF8AA==
Date: Tue, 1 Oct 2024 17:09:02 +0000
Message-ID: <SJ0PR11MB56786A297C3D8DCADC2EF310C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
 <20240930221221.6981-7-kanchana.p.sridhar@intel.com>
 <CAJD7tkZh6ufHQef5HjXf_F5b5LC1EATexgseD=4WvrO+a6Ni6w@mail.gmail.com>
 <SJ0PR11MB567830D47190C55F14CE75AAC9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYF+Q2+f-=OK64C1dUqbnMVLLmWU1RDVrfJ9+rjBgqEbg@mail.gmail.com>
 <SJ0PR11MB567885FD8899DA83FB95DE61C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkZk=9Su3vtdFcghD0R+GqSchn5b1L91SgTvxcX79rmdOA@mail.gmail.com>
In-Reply-To: <CAJD7tkZk=9Su3vtdFcghD0R+GqSchn5b1L91SgTvxcX79rmdOA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SJ0PR11MB5071:EE_
x-ms-office365-filtering-correlation-id: 15374867-797a-4268-3e9d-08dce23bbf8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VHZuM1hpemg2V1V1cGhselJPRjVQd29ZWGhoU24zTDMxNDdjU1htcm5VZ1NX?=
 =?utf-8?B?aFFYSHY3YjAxR1UzM1dxSFZKZ1I1VTdXQTUwbkszRytDd3lPTTBZb1lYWmFK?=
 =?utf-8?B?dnRTcDJrZTltdjhlZVRjOGFBZXBPakEzNTVSOGV1WUU3My81djRCaUE0UWN0?=
 =?utf-8?B?VjFJdTl6SzNRQnZOYjhqeDRTME9uREhTQVJZNjZJbWl0ckt2T096NGdvR3lY?=
 =?utf-8?B?TkdzSk80ZzcxcHJTVS8rZXdPeExWZ1lwMnlUampHQnI3dVdwTUo5MkJwVy9V?=
 =?utf-8?B?bFFrd2lLYk5mdnpYd1FQZXBxUndWdzBWTDA4WXEwOFZNZktnVUhWSzh5S2Y2?=
 =?utf-8?B?VXZaYVBpOWhWaDZIT0JSajhlUXFLdkVoTy84bWlLdTU0ZXFTN3luczVPSVBP?=
 =?utf-8?B?bU5YNnArWTZKaDg4THVwUjNDV3NuQjNWUGZKTlJNTGplT2J3V210MkZnZXl1?=
 =?utf-8?B?WkNWVlYzcnp0c2dHQU9GV05oRHZIUmY2UmMvYlQzb1NWVHBudzFZUER1RG1v?=
 =?utf-8?B?VDNFVk1RQVcvZXlsQkNoOGkwakExb1ZKM0lXdnRBeFBzcEpKcklsZGQ5eXo5?=
 =?utf-8?B?dDRvV1AvZi9XWFg0ek9BNFBpT2lIV3Jrb01pUDNVaFhKUFRqeWNpRlZVZFhC?=
 =?utf-8?B?SHJ0QTA1TGs0STd5WmRKdzNheGlwMUJOMUlPTVpJYWFLdzFpVytSNFcySE55?=
 =?utf-8?B?anVlVGVJOUNUREc5bWl3TGJtUkRaemNJVDB0aVpSMzBrQUdTSS9FMEo5ZWZm?=
 =?utf-8?B?QUdCMytpL2RERVhhK1dUdEI3YzVzTmFwbHFMV2Q1V3dlS2o0YU9jWGtzbUhW?=
 =?utf-8?B?NHBPOHJPOGVUL1lpYmIwR21ZUEYzQzhqeU0zY1ZGdityK2t6enFIUDJ5VlJK?=
 =?utf-8?B?Q3AyazBYV0pXSjEzQmZWWlBNUmdscnY4V0hzYzVhOWNnbW0zN3dvdHRERXl0?=
 =?utf-8?B?TW1ycmt1dzlmd3NMQjBiUzBPbGtBMkdsbFRNMWtPSFFHelVncVRoTGVzOERD?=
 =?utf-8?B?YklYcmsvaTI3Q3ZRTmhsZHp1c2U5UEdvN3Y5bEUrbmh4Vjh6NEFMa3dXOTRw?=
 =?utf-8?B?UmUreG4yc0NaM1Y3YlR2WlVyYUQ0TTEvUGQwM01ISWVWb3g4RFhiZUo5UzJO?=
 =?utf-8?B?TmtmN3dXa2lDQXlTR0d1Z1JzeXZFVWVqM25pZmFUNWt2ZDhlV01IU2I1cHZR?=
 =?utf-8?B?NEs5M3p0RWN0am4zRlFvQ093ODRuamV5dWhKVC9TdkFpbVpBZUlmbXg2Ti9s?=
 =?utf-8?B?YU1ZQUVzUGluU0dJSHk2dTRYb1RYanNNKzZvMWtTZi9KcXl0OXRlQjFaeWtK?=
 =?utf-8?B?VlBlaWh1MG5ZbzFTSkRRYTVWd0NtRyt4WjhsWEw1TnFLQmsyTCt0c3JXQXRJ?=
 =?utf-8?B?SWdTZnlDSWEreU41em5Za3NhSmpTdXNDb3pmcWpZRTFFVEhtbXhjbjA4Q3RH?=
 =?utf-8?B?cThrOHlVL3NWSlRJOTZldy9HRzgwR1A2QUdsbjV2d2xDellQbGJhVjJORG8x?=
 =?utf-8?B?UEpOOXdTVlAyNVlrRnFTNFNOVkJvYjc5VnpTcU5ONUVheEtXbTNhMTFTZ3VW?=
 =?utf-8?B?WC9iOFY2RzhCeG9LODF6enRWTVBMYk9hclZkd1IrOElQdzFueUpYVTc0SXlS?=
 =?utf-8?B?KzVTREFaQXZ4RUtzUjJ4U3duREhMamJlamN3R2dzdGF0bkpHRVlEL0JHbXQ5?=
 =?utf-8?B?Z0xsZktKcU4ybEhZOE1jcjhzK1Z5cysvTnBwcXJib3VrcSs3eTFiV3paV0Fp?=
 =?utf-8?B?TC9XdW9TeTJmUExKdW4yeDgvTTZkQVVNOEpDZnptMTFiTjZvQnlueEYzWFIz?=
 =?utf-8?B?aFZGVDhxR2FCU1dLdDcwZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ym50Tk8vSmNocWR0WlVJb0FtUXhZckI3VnVlL1ZzMjdubncwREQvd2hBT1JQ?=
 =?utf-8?B?NlRjWXRWT3V0a1J0aXBSRjI5WTB4bS9peW9UNzlGNDlUTDl2ZHQza29hQ3Mx?=
 =?utf-8?B?eXhIdk84NlBFL29sU3BwcFk4OUN5UEpNSnNKbjd0akFVMlRSWHQ1enROdndS?=
 =?utf-8?B?SVJsWUw5YnB6ZjZaL3FxWWdBNk9QYWRtQ295Q3IzbVYzVWdMb2ZvdmhEaVEw?=
 =?utf-8?B?MlR4WnVKZ1ZxcWVldmRpWEpwUE04eTR2d1M5RURTM3paazcxNTdTaVFiMHY0?=
 =?utf-8?B?SDhJK2hOK0Z0T2U2YXRkRzZOSGRUUlQxK1pNb0sxQWNURW5CaW45SjFLOENE?=
 =?utf-8?B?eUU5ck9TbTNBVndaZkw0c0JFdjRKd0U2Z2liSlJyd09IRGErcTJBaVZ1N1dZ?=
 =?utf-8?B?S0JsK3NRbTYvbGRhYzRaRmdLZ01DQmpYMkRBVWx6TFNpaUZiMkF6dUhsQklE?=
 =?utf-8?B?eFhiVWNVbTd0MmxyVFoxM0hGTGs1eGNWc1AwN0VoQ1QrdnNxbXB0WDkweElH?=
 =?utf-8?B?K21kY3N1ZlZaK094eHJRUGppSWsyNXR3cldWYVl3NzZybzU1Z3N0VVgvNXk0?=
 =?utf-8?B?NGJFc1ZGUkNwWlFoeFI5UE1FUytlK1dHTG93M253eFVDcXpOM2FvOUFSWUNC?=
 =?utf-8?B?em1WeDFuSmt6Q2dqYWNXRmk2USsvSnQ2aXg5ZnZDRldHSGNRZ2tFU3kycFBj?=
 =?utf-8?B?L00zM05uU1VQRjg3MURTTWV6L3ZLS0hGQTRjUUtLcjFua3dvTEJuZTVWcHpP?=
 =?utf-8?B?SDFvRjFlcjc1ZVl4Rk9xeUVoeGlZVFEzelduUm9aMlpMSG9ZSXlaWGczSGI1?=
 =?utf-8?B?WGg2VXRmMUM5OXJGbmthaThWVmtWVUVLNWZ6YzJoREVJZ01NL0ZHaXBFNHcv?=
 =?utf-8?B?Y3QyTk5Rc0Z3Yml1b0Y2WER0bFoyMlNBSDdJa0tmMFdqWDk2OFJCR1docXBH?=
 =?utf-8?B?SUtoMEFBV0dwNHcvTEludS9xalJ3RDN2c0J3V1ZCcFpWdThCeFlnUnkwUjZ1?=
 =?utf-8?B?aXBkRFQ4ZDhhNzlFU2xLTXZVQkdabTE0SDd0YUVVUUVLT0hVNVRwelFCK3hn?=
 =?utf-8?B?Q0xUQkFPdHF5L1l6T3VlRGRKSHVVWUtVMW11U29oWFVGd0JjbGNsUWVSYk1T?=
 =?utf-8?B?UWc0Q3U1ekJodjRPblMwNkVZZE82SWdwZVdkaGltSlZYT3QzYzVqQlZZK090?=
 =?utf-8?B?Z3JPU28wKytlc2UxTWFZM3dNencxM0l6TjcvcDdSSUdmOWFKZkdIUWZkZkJJ?=
 =?utf-8?B?UnNueFZUZ1o0cEpHZ0RpbS9LT0MxTHpBbUpwbi80a3MrSlhJY3J0KzRlQXg3?=
 =?utf-8?B?a1FFbWZwQjJ4Wm82Sk1kODJlSmhRSTRBQkgvcEtNeFVaUVI2cUJ1dVhYbUZI?=
 =?utf-8?B?RWhoVHJKU2NZMU5nNnIzdnJVblprRHg2NXhER3FWbkFIakMxR2dBUlR6SEFk?=
 =?utf-8?B?TlMva00yRXBCbWtSNEZuUWJsQU9TZjAxdkpwMnp6UmhHSzZ0RjFRSkg2VHg5?=
 =?utf-8?B?OEsraTFNamdUdHN2d0lLRExTcklWVGlSVEdGaWRrZ0dJMjhtZWJEM1BKVElX?=
 =?utf-8?B?aFFmSDR3UE9uSkpXUUZJTU9aNExERDIwRENiVzdPb2dObVIyT1RTZ1RtbEMv?=
 =?utf-8?B?V0czcDZpV2E3V0dZSGpxOHVaMHhIMWRlUUVpZ2dYbmZ4bk9ndE9YUnJPZkIz?=
 =?utf-8?B?SzNKOEFRb0ZXWTJoREpBNTM3dUQ2YitQMDlZL0Y4NXZXNWs2bEJoSElPYVJa?=
 =?utf-8?B?WHFFbTkxSjJnR0xTcWpaWkVIVWNkVjkrMm1ocm5LWnMxaU5WRDVLUWJwM0pp?=
 =?utf-8?B?d1lVYTlMbE9vZVJHbFlPZE1nSVAxdzU3dG9jWjZERVFBZWV2ZkFKdStaaXcz?=
 =?utf-8?B?VmFVRDdJNkkzMVVzMTdRSUc2alBpc3VQKzlxTWtEY1dlSVZ5N0huNzJ4SUJy?=
 =?utf-8?B?eTFLeDlKN0tUTGc0ejJLTVhXb2FkSDZsQzErd3p1TVJEYXI3RTk1SVk0N2V5?=
 =?utf-8?B?anR4SGZzQ2w4Q2RVYkxJV0J4NU1UQ3U0QnI2TG1YNzh2TitZcXE3aTQ3cEVL?=
 =?utf-8?B?Rml3akN1bTBDUWV0RlY3a3VBQU54WlpGRGorazdyVDQ0WWQ0c0RPdG5xck5x?=
 =?utf-8?B?NFdrQ0JVQ080QXpZcTBxbEZ4eVBhWE93VUE2NkxaaUcrMGFrS3dJUkZjWjE1?=
 =?utf-8?B?Tmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 15374867-797a-4268-3e9d-08dce23bbf8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 17:09:02.4057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmXr3yr23wPMoPlu9/lLB1z7xjumGAvnVZCWcHvFLO6hxZDtzHXnuvWJiAzAIdeqBGUtMC6lx8p7DYXwa9RkysisZGF1OK0JnGOfu5RI/bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5071
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDEsIDIwMjQgMTA6MDEg
QU0NCj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5j
b20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5v
cmc7DQo+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgbnBoYW1jc0BnbWFpbC5jb207IGNoZW5nbWluZy56
aG91QGxpbnV4LmRldjsNCj4gdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsgc2hha2VlbC5idXR0QGxp
bnV4LmRldjsgcnlhbi5yb2JlcnRzQGFybS5jb207DQo+IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5n
QGludGVsLmNvbT47IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LQ0KPiBmb3VuZGF0aW9u
Lm9yZzsgd2lsbHlAaW5mcmFkZWFkLm9yZzsgWm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwu
Y29tPjsNCj4gRmVnaGFsaSwgV2FqZGkgSyA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdv
cGFsLCBWaW5vZGgNCj4gPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjkgNi83XSBtbTogenN3YXA6IFN1cHBvcnQgbGFyZ2UgZm9saW9zIGluIHpzd2FwX3N0
b3JlKCkuDQo+IA0KPiBPbiBUdWUsIE9jdCAxLCAyMDI0IGF0IDk6NTjigK9BTSBTcmlkaGFyLCBL
YW5jaGFuYSBQDQo+IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0K
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFlvc3J5IEFobWVk
IDx5b3NyeWFobWVkQGdvb2dsZS5jb20+DQo+ID4gPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAz
MCwgMjAyNCAxMTowMCBQTQ0KPiA+ID4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5h
LnAuc3JpZGhhckBpbnRlbC5jb20+DQo+ID4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOw0KPiA+ID4gaGFubmVzQGNtcHhjaGcub3JnOyBucGhh
bWNzQGdtYWlsLmNvbTsNCj4gY2hlbmdtaW5nLnpob3VAbGludXguZGV2Ow0KPiA+ID4gdXNhbWFh
cmlmNjQyQGdtYWlsLmNvbTsgc2hha2VlbC5idXR0QGxpbnV4LmRldjsNCj4gcnlhbi5yb2JlcnRz
QGFybS5jb207DQo+ID4gPiBIdWFuZywgWWluZyA8eWluZy5odWFuZ0BpbnRlbC5jb20+OyAyMWNu
YmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC0NCj4gPiA+IGZvdW5kYXRpb24ub3JnOyB3aWxseUBp
bmZyYWRlYWQub3JnOyBab3UsIE5hbmhhaQ0KPiA8bmFuaGFpLnpvdUBpbnRlbC5jb20+Ow0KPiA+
ID4gRmVnaGFsaSwgV2FqZGkgSyA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBW
aW5vZGgNCj4gPiA+IDx2aW5vZGguZ29wYWxAaW50ZWwuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6
IFtQQVRDSCB2OSA2LzddIG1tOiB6c3dhcDogU3VwcG9ydCBsYXJnZSBmb2xpb3MgaW4NCj4genN3
YXBfc3RvcmUoKS4NCj4gPiA+DQo+ID4gPiBbLi5dDQo+ID4gPiA+ID4gPiAgc3RvcmVfZmFpbGVk
Og0KPiA+ID4gPiA+ID4gICAgICAgICB6cG9vbF9mcmVlKGVudHJ5LT5wb29sLT56cG9vbCwgZW50
cnktPmhhbmRsZSk7DQo+ID4gPiA+ID4gPiAtcHV0X3Bvb2w6DQo+ID4gPiA+ID4gPiAtICAgICAg
IHpzd2FwX3Bvb2xfcHV0KGVudHJ5LT5wb29sKTsNCj4gPiA+ID4gPiA+IC1mcmVlcGFnZToNCj4g
PiA+ID4gPiA+ICtwdXRfcG9vbF9vYmpjZzoNCj4gPiA+ID4gPiA+ICsgICAgICAgenN3YXBfcG9v
bF9wdXQocG9vbCk7DQo+ID4gPiA+ID4gPiArICAgICAgIG9ial9jZ3JvdXBfcHV0KG9iamNnKTsN
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IEkgdGhpbmsgaWYgd2UgcmVvcmRlciB0aGUgZnVuY3Rpb24g
d2UgY2FuIGRyb3AgdGhlc2UgY2FsbHMsIG1ha2UgdGhlDQo+ID4gPiA+ID4gY29tbWVudHMgcG9z
aXRpb25lZCBhIGJpdCBiZXR0ZXIsIGFuZCBjZW50cmFsaXplIHRoZSBlbnRyeQ0KPiA+ID4gPiA+
IGluaXRpYWxpemF0aW9ucy4gSSBhbSBhbHNvIG5vdCBhIGZhbiBvZiBwYXNzaW5nIGEgc2VtaS1p
bml0aWFsaXplZA0KPiA+ID4gPiA+IGVudHJ5IHRvIHpzd2FwX2NvbXByZXNzKCkgdG8gZ2V0IHRo
ZSBwb29sIHBvaW50ZXIuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBEb2VzIHRoZSBmb2xsb3dpbmcg
ZGlmZiBpbXByb3ZlIHRoaW5ncyBvciBkaWQgSSBtaXNzIHNvbWV0aGluZz8NCj4gPiA+ID4NCj4g
PiA+ID4gV2Ugc2hvdWxkbuKAmXQgYmUgYWRkaW5nIHRoZSBlbnRyeSB0byB0aGUgeGFycmF5IGJl
Zm9yZSBpbml0aWFsaXppbmcgaXRzIHBvb2wNCj4gPiA+ID4gYW5kIG9iamNnLCByaWdodD8gUGxl
YXNlIGxldCBtZSBrbm93IGlmIEkgYW0gbWlzdW5kZXJzdGFuZGluZyB3aGF0DQo+IHlvdSdyZQ0K
PiA+ID4gPiBwcm9wb3NpbmcgaW4gdGhlIGRpZmYuDQo+ID4gPg0KPiA+ID4gSXQgc2hvdWxkIGJl
IHNhZmUuIFdlIGFscmVhZHkgaW5pdGlhbGl6ZSBlbnRyeS0+bHJ1IGFmdGVyIHdlIGluc2VydA0K
PiA+ID4gdGhlIGVudHJ5IGluIHRoZSB0cmVlLiBTZWUgdGhlIGNvbW1lbnQgYWJvdmUgdGhlIGNh
bGwgdG8NCj4gPiA+IHpzd2FwX2xydV9hZGQoKS4gQmFzaWNhbGx5IHdlIGFyZSBwcm90ZWN0ZWQg
YWdhaW5zdCBjb25jdXJyZW50DQo+ID4gPiBzdG9yZXMvbG9hZHMgdGhyb3VnaCB0aGUgZm9saW8g
bG9jaywgYW5kIGFyZSBwcm90ZWN0ZWQgYWdhaW5zdA0KPiA+ID4gd3JpdGViYWNrIGJlY2F1c2Ug
dGhlIGVudHJ5IGlzIG5vdCBvbiB0aGUgTFJVIHlldC4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgdGhl
IGNsYXJpZmljYXRpb24sIFlvc3J5LiBTaW5jZSB0aGlzIGlzIGEgY2hhbmdlIGluIHRoZSBlbnRy
eQ0KPiA+IGluaXRpYWxpemF0aW9uIHdydCB0aGUgbWFpbmxpbmUsIGlzIGl0IE9rIGlmIHRoaXMg
aXMgZG9uZSBpbiBhIGZvbGxvdy11cCBwYXRjaD8NCj4gDQo+IFN1cmUuIFdlIGNhbiBkaXNjdXNz
IGl0IHNlcGFyYXRlbHkuIERvIHlvdSB3YW50IG1lIHRvIHNlbmQgYSBwYXRjaCBvcg0KPiBkbyB5
b3UgaW50ZW5kIHRvPw0KDQpUaGFua3MgWW9zcnkhIEkgd2lsbCBzZW5kIHRoZSBwYXRjaCBzZXBh
cmF0ZWx5Lg0KDQo=

