Return-Path: <linux-kernel+bounces-239671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509D89263C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753451C2233D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAAB17B401;
	Wed,  3 Jul 2024 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiUJpWf6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9464409;
	Wed,  3 Jul 2024 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018088; cv=fail; b=ZGsybrR9sQBC64rbgA6ylRFdNnzNI8SMrc4n+izCCXOUl2uX6vIr4q3ns3hEB8ji0Ug/yjexD4+78Oj43+INJUd4lBQ8rC7wZHC4EskQiap4H/+pHpMalNOaw2xD4Q/7BVEljWz+wLpDP1E+bsj8V8hYe1oF1ErwjrPwJQc1WT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018088; c=relaxed/simple;
	bh=XKVuLVYrv+WklAZfiJOVbLyaD+BsO6igoVK4ucmTPkM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pr9qTDN43bHTz8a3VT2a8RH4RfA2ZNzsGxpjCD96O0gHLSyJj6J8Rkp8hLUCydJ1EF9JOlE/g1tH3bJDBmQVrHZ53+TwOCTHpqlHM+Sm4pla7ADA+1/qY5rMFRyP1O5EcCC/UYLFCyrnOzeVBl3xx2UAPnn7MatxLEjPcP23bnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiUJpWf6; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720018087; x=1751554087;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XKVuLVYrv+WklAZfiJOVbLyaD+BsO6igoVK4ucmTPkM=;
  b=RiUJpWf6dYWH/KollXf//VeXa/ijcdak4xZr76Ja9Dq8yPUrwQgdAJAY
   A7rDOa67MkZHCrtXvAI5Uo7HS6j7ZfOWNUVyfxMworYQ5qR8CB4NUoxJ4
   ZYLU8nVrI8C8Kp47tCMw7KtK/tPLKzSMtWSCFM9i1XtQDL5sgPsY0yuXz
   utzOgBwvTmwkRqd744caPiDEQc95Sglf9x2JjAeWvDM1nbpm/N1JYbLCu
   fPGInpucegIK53WXdt8w+6q1By0VQZRkBDKtjGyHIA23fHBQnNnSCk0KM
   cLJ4AnyZajj/oiU72+fxxfVbyxzs+QyJBCUN0LH+saaXtxODM/EJNcDpG
   w==;
X-CSE-ConnectionGUID: yRp5theqTfqdAXzFZvtInQ==
X-CSE-MsgGUID: zaVjD1wdQ1eMLJ6Ak1Dz+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="21014075"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="21014075"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 07:48:07 -0700
X-CSE-ConnectionGUID: 9PRT0R7FQUKQS/TPHlTA4w==
X-CSE-MsgGUID: dP39mRyXTXqybDoN0QK90Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46055639"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 07:48:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 07:48:05 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 07:48:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 07:48:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/84k5BNOfG48FGj/CuRvmUUQRHs3XktRBrJrj7HlkqP7hrlRaVT9zjO0Bx/Mv9UPrvRsgaI5wl2QhSE4zzMUWlf6OXIcULPCKrI3hSWHQ4if7eubsL2DxW+9FpABgVQnI+t8sSheWFk/lv99ATsjgiCRI0jeHIsRlcVfWYVuis5hb1GQZ707Jmg6hK14Eo4+5oundTiknQ61CrrctkbJwdiYT8JeYGIpHHDoAnoJ6LCUFsZWNTooC0OlybypwFjXF7lKZ4R6naEndUAlR/ugURe2mvpCQ3uqOSmVdxmnTtjrhlDTkce9/jL3v6b7B4yxdY/ha2X+U3LgEzkuOcPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34TZAHUxkyPXf2/9MCVZ1k6kajZrnK3ScsAQrE5g6N0=;
 b=L+69R8Ru/rzXKNb9RuNjbkrxuwm8VJWc3CF5GXXpUimpHiFF8uR8AwZggx1Sv3+dyqQ3IYEj8nUsDnNI6ahT8U34mr5QgnoofrGXCdHqDprHGP/9SACNy4RvE7MaZcKlQ/UYLyXL4lKReCB+9NCCWRo5n5aV3Rl/w/mTA23q0xHkLUg1TU2jHKzdN4DY1q3KfjM3ibIKZX9ecvbGSG2U6F+4/AGrse+g7mXKgKiV0W3YDlZ9D0Ej2GsbxXZvo67+f7d+ltnpeJFQKto7SeLEyNP/HNhhScdY6PV3mrX97eXE6hVVs6qsm7PA1rqVouZ7HZWWer8rAxMHIfChOqyR3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by CY5PR11MB6306.namprd11.prod.outlook.com (2603:10b6:930:22::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 14:47:57 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1fe:535e:7c0e:1d67]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1fe:535e:7c0e:1d67%6]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 14:47:57 +0000
From: "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "giometti@enneenne.com"
	<giometti@enneenne.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"Dong, Eddie" <eddie.dong@intel.com>, "Hall, Christopher S"
	<christopher.s.hall@intel.com>, "N, Pandith" <pandith.n@intel.com>, "Mohan,
 Subramanian" <subramanian.mohan@intel.com>, "T R, Thejesh Reddy"
	<thejesh.reddy.t.r@intel.com>
Subject: RE: [PATCH v10 0/3] Add support for Intel PPS Generator
Thread-Topic: [PATCH v10 0/3] Add support for Intel PPS Generator
Thread-Index: AQHavHw3GFWISxsti0KTPKufinqZkbHlNmBw
Date: Wed, 3 Jul 2024 14:47:57 +0000
Message-ID: <CY8PR11MB736490B761DBA045513AF078C4DD2@CY8PR11MB7364.namprd11.prod.outlook.com>
References: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>
In-Reply-To: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7364:EE_|CY5PR11MB6306:EE_
x-ms-office365-filtering-correlation-id: 131152cc-012e-4a5f-5a14-08dc9b6f2107
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?aoXWnRSUD1esAu/s2YSNRNg/50pTnQ75lx7Gu6YuW5gW0N7fd6iG0VaI/9+2?=
 =?us-ascii?Q?0YoRYkrxglusshY3bwQs1vJAn/7zuwm0gReoZQ4qJv1oT41yH7JjAq/wHQRY?=
 =?us-ascii?Q?BcwMYTQO0I5PqAFqz8wt8AiqapOYoUsQU0bMxr+hhp8LLPmc7L6qLcmXs9oZ?=
 =?us-ascii?Q?yYsc2E5nQM2Z9T8pTxEN7WLzy1Rm0clGZ8MB/KU147A6hRSzRYt+SIVvnwNp?=
 =?us-ascii?Q?DJSYOu/vllmUiIN0l1wpanOzAGhWaitvfhqrMlE4D2/TrSjq5jbz6xM7CGGd?=
 =?us-ascii?Q?qXdrlF1d/n7I3QE4GwS3fFICgiAyTYsebtlunhR/9umkXnbRQYw7EqWfjDLn?=
 =?us-ascii?Q?xVpcLuRgMzC5fnu3WNnNZqHH3VXFCIX5fD23ZP7T/JKj3CP9LcWrCmHfgRdT?=
 =?us-ascii?Q?U07QcGjk0bhqnO74HJc5/yiFV2oz+H/vgkBCn74XI9CuxBluJf+Cmc9S0ytL?=
 =?us-ascii?Q?yisL5R1vygKJeGbFBtgfX1wTm7hTniHEWoHkNUBC1IoEkEAsYfiEQoSU47Fc?=
 =?us-ascii?Q?M8tBctshpWepmTXLICOufxpV4Lq9ZC0fMnpCEHBzCMrDmgSJ0z3i32EUBf54?=
 =?us-ascii?Q?i8B3LP639s8hl+pi4NnICjeMvUUV75UdJ1Nmm8OHdzS3I0GcRMX/txRgGm4s?=
 =?us-ascii?Q?zFEq4ZHfOUdpHxrp5JijJp4C2CDjzc5Hx7gWxatw8b15uA/al6MNwOhesv/g?=
 =?us-ascii?Q?mmeXn2de7g2elwbBb3ih2+3rpGDqcWwRAVuCgsWO1domHSMZb7uv9ytnK1s3?=
 =?us-ascii?Q?jAmxUsViyE6BqK1hn+VMmUe4bhdLadlX/60QQFGpGHWJifRWSSvJXUqudxYn?=
 =?us-ascii?Q?BJbm6IofKxn19vcBLUr1Qb+Gwyvp89uOJ0MGnsnzve86jsadnP8fZI6A4REL?=
 =?us-ascii?Q?djclYpolXMLSOYeol3HHp3EjqF+DHbgw3IeAnfloyIvz86pbo6ogSiu9KXMe?=
 =?us-ascii?Q?5Lc22D6wVfcPVD6Yh8ljc3DgNgfi3vIMh8ZhCb4YXWCsryIfkFIfbIIDrrfe?=
 =?us-ascii?Q?JmVlTCDJYgtuiX1wj6N5jUIZVDpABp4pCvuaQOw6WXN3K3oh8RdKBSkLZZip?=
 =?us-ascii?Q?7IH3AW63vWMsv3Udm+Vh2z0S7IcPQ/D+vhXJsnab8jprM2QF5Yv8ijMTKEcK?=
 =?us-ascii?Q?2nPCgh9Pkzk+hSDWPEWnEcRLlhy98fayWJYl/vvwqZfTA36fNv6zbfWFLXmL?=
 =?us-ascii?Q?MPKqgcHBXYwkWPYz12ZeJfsmF6VT7OsAnGdZcxy3QTMYVP64foGGDh3aFlv/?=
 =?us-ascii?Q?rYnLquEbFiv4U5AnULVppL1clQ1GnOSJlttQFY3kfRah0/cbZro5EmKrbeQl?=
 =?us-ascii?Q?sRbo1GqNxz16cjkPQj3J1O/WEo94Sc9oR+0jkH3Df2eTbh/bbPVAVuALIaNB?=
 =?us-ascii?Q?PP2k+TU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e30H/qct61k5+2bT5GjRhNFyeeVZVuZ1R7ssaFj8cVZt+X/rzYDnit7pNY/0?=
 =?us-ascii?Q?jNQ4KM8T0JZgzk8lEah/EWjEXkpSO4SkvXSic0OLWBNbkRS5NOfs9vEbOKOG?=
 =?us-ascii?Q?wZZ8up5uLOlEXZDmdMmh5i/5xIeYFS/RGmagjdEdBGrqnWY5kw/+oiZzql5l?=
 =?us-ascii?Q?w437wXvNuawbM+nNWJgT5QaULxRzTl4TvLuzV3jFSr7nofojEf1SWEpyJkNk?=
 =?us-ascii?Q?Q8jt/yvCApAiwYeaNkdHFi1bGZhQvZLsnxlq88XxDGr4lrQTHEw1jDITrLSY?=
 =?us-ascii?Q?eHvdqyUuYa4bAJzpHB/d8Ji4V2YoutCTidrfQjJwwtDeMrU9U8kdncf8fYWF?=
 =?us-ascii?Q?lYGwqe0mPk3zrTp3DyTtXTGosbfPmrm42o+JWwUA44uDSVY1Z2hnIeMwm91o?=
 =?us-ascii?Q?AZgsK+wZtL6+Z6utqyRkxwFFd39KCwAfkH2yjbViCHHDmtDYhPwgLbdqotyx?=
 =?us-ascii?Q?ew17PThfVB2LjwypoRXTJVF6rVwC/pUZIDpKv79iFVbKBhr7EhRhhIzZnXVt?=
 =?us-ascii?Q?5wTlUCtnzvJyhLdRqlTE71FEi74oeEQUfVhdZNn6ylhBmjG+JaVi2GxmWd/J?=
 =?us-ascii?Q?sQ75UTf2FGn786q+KN9kqZObjnl6a9oKPVCK91kQAxwDfOY0BbVgoCFKeR1o?=
 =?us-ascii?Q?JeGu3AvR638KADHIrwj+FhUk+YsyWT7xXKyi36Xu4pRf6GTW8QWwrgSlsDZn?=
 =?us-ascii?Q?slT2bNhZDPCXbERQA11gMq4yBW20OOLUgGBEYL1e9KrOAYjCBlQX7an027zs?=
 =?us-ascii?Q?c7khYTICmn0DB4Kt8gnO/XBYPRi9X3FyMCSi7CHsS9BGPd+co0Y6rpHg9a0x?=
 =?us-ascii?Q?Gavcrn+HWNdB7zpbP7NN5OBSSmj484N/7Stt8NU2/1/xvyUw7TiNUhHPnghx?=
 =?us-ascii?Q?i0FIfV8TaouqB5t99JVMRB4aq2+Yedm/ZsMHZqQkH14TwXJAopDDHgvzr4fL?=
 =?us-ascii?Q?A/CTG+wt6FDrzJyzH8gHOQMW6w7xJxgZzNwZ7oBtTOi4k/XzcmT+ckpBukz+?=
 =?us-ascii?Q?Bk0gB5GUiy/w8lpX5l9/UHFs8eAd4hX3GBPyJGu35RN2rBNZXYReEhjcpoTl?=
 =?us-ascii?Q?UjFb+IEwgblcoazbOffnfjIqgnZmx21m2zUBE0NfkfHfWw+l2Sd87JgVcFze?=
 =?us-ascii?Q?Uu5Zm7Mg03GMMj2tbEQuP0KLWPCEEquF9oBDWyuHZc+VkkVgiBYWnr4wkQOH?=
 =?us-ascii?Q?mQPlJDxR6kjrS+sSa2ftHD/hJUW1xiuc7067VFKPKs8I+BOlZjg4YRRLOGqX?=
 =?us-ascii?Q?+a+UQaQDMLiUkx2PBCcK0kDHUr3s2kbg1Jp3dkZUKGWZVIa+tNrjdt4ROUjW?=
 =?us-ascii?Q?s/VZBhiXv8TMe81Mp7VjynreJlBbiW/ZkuseBZRQAQwebqdEgi7gMkFCpgSP?=
 =?us-ascii?Q?2b6SPs6dcVpda0/2HRmFrEIgOITJ3nQcD3NUlsnSho2WYs4ZuoDbJigE8QpY?=
 =?us-ascii?Q?RWRSER0M99Uz30Q++UKlJ0/DsTlAZXSxcwDNdE3NJYhuxirsed+OHxmeP7aW?=
 =?us-ascii?Q?CKHt5BVS7dGy7q92yKixdanXD9+79tJ1ecvFewXGNOIHExU32LrgnE5pQisb?=
 =?us-ascii?Q?opsr9yFU1K22Hl+gRcX0epEeC4pmcqEVfDuooSF3chjF6e379P+EesuWZyBR?=
 =?us-ascii?Q?dQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131152cc-012e-4a5f-5a14-08dc9b6f2107
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 14:47:57.7030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MR0inorGM5Coi1jjP0SKlSnwsOZizMC9aMJ8VRSGn3qKbRb0cEGs0xWMdcLJVcMXwr7UGKjvihsWtzx/dH29diE7itYvfqEXeim8ybCPm5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6306
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: D, Lakshmi Sowjanya <lakshmi.sowjanya.d@intel.com>
> Sent: Wednesday, June 12, 2024 9:24 AM
> To: tglx@linutronix.de; giometti@enneenne.com; corbet@lwn.net; linux-
> kernel@vger.kernel.org; linux-doc@vger.kernel.org
> Cc: gregkh@linuxfoundation.org; andriy.shevchenko@linux.intel.com; Dong,
> Eddie <eddie.dong@intel.com>; Hall, Christopher S
> <christopher.s.hall@intel.com>; N, Pandith <pandith.n@intel.com>; Mohan,
> Subramanian <subramanian.mohan@intel.com>; T R, Thejesh Reddy
> <thejesh.reddy.t.r@intel.com>; D, Lakshmi Sowjanya
> <lakshmi.sowjanya.d@intel.com>
> Subject: [PATCH v10 0/3] Add support for Intel PPS Generator
>=20
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
>=20
> The goal of the PPS (Pulse Per Second) hardware/software is to generate a
> signal from the system on a wire so that some third-party hardware can ob=
serve
> that signal and judge how close the system's time is to another system or=
 piece
> of hardware.
>=20
> Existing methods (like parallel ports) require software to flip a bit at =
just the right
> time to create a PPS signal. Many things can prevent software from doing =
this
> precisely. This (Timed I/O) method is better because software only "arms"=
 the
> hardware in advance and then depends on the hardware to "fire" and flip t=
he
> signal at just the right time.
>=20
> To generate a PPS signal with this new hardware, the kernel wakes up twic=
e a
> second, once for 1->0 edge and other for the 0->1 edge. It does this shor=
tly
> (~10ms) before the actual change in the signal needs to be made. It compu=
tes
> the TSC value at which edge will happen, convert to a value hardware
> understands and program this value to Timed I/O hardware.
> The actual edge transition happens without any further action from the ke=
rnel.
>=20
> The result here is a signal coming out of the system that is roughly
> 1,000 times more accurate than the old methods. If the system is heavily =
loaded,
> the difference in accuracy is larger in old methods.
>=20
> Application Interface:
> The API to use Timed I/O is very simple. It is enabled and disabled by wr=
iting a '1'
> or '0' value to the sysfs enable attribute associated with the Timed I/O =
PPS
> device. Each Timed I/O pin is represented by a PPS device. When enabled, =
a
> pulse-per-second (PPS) synchronized with the system clock is continuously
> produced on the Timed I/O pin, otherwise it is pulled low.
>=20
> The Timed I/O signal on the motherboard is enabled in the BIOS setup.
> Intel Advanced Menu -> PCH IO Configuration -> Timed I/O <Enable>
>=20
> References:
> https://en.wikipedia.org/wiki/Pulse-per-second_signal
> https://drive.google.com/file/d/1vkBRRDuELmY8I3FlfOZaEBp-DxLW6t_V/view
> https://youtu.be/JLUTT-lrDqw
>=20
> Patch 1 adds the pps(pulse per second) generator tio driver to the pps
> subsystem.
> Patch 2 documentation and usage of the pps tio generator module.
> Patch 3 includes documentation for sysfs interface.
>=20
> These patches are based on the timers/core branch:
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/?h=3Dtime=
rs/core
> These changes are dependent on patches that are merged in [1].
>=20
> Please help to review the changes.
>=20
> Thanks in advance,
> Sowjanya
>=20
> Changes from v2:
>  - Split patch 1 to remove the functions in later stages.
>  - Include required headers in pps_gen_tio.
>=20
> Changes from v3:
>  - Corrections in Documentation.
>  - Introducing non-RFC version of the patch series.
>=20
> Changes from v4:
>  - Setting id in ice_ptp
>  - Modified conversion logic in convert_base_to_cs.
>  - Included the usage of the APIs in the commit message of 2nd patch.
>=20
> Changes from v5:
>  - Change nsecs variable to use_nsecs.
>  - Change order of 1&2 patches and modify the commit message.
>  - Add sysfs abi file entry in MAINTAINERS file.
>  - Add check to find if any event is missed and disable hardware
>    accordingly.
>=20
> Changes from v6:
>  - Split patch 1 into 1&2 patches.
>  - Add check for overflow in convert_ns_to_cs().
>  - Refine commit messages.
>=20
> Changes from v7:
>  - Split the if condition and return error if current time exceeds
>    expire time.
>  - Update kernel version and month in ABI file.
>=20
> Changes from v8:
>  - Add function to enable Timed I/O.
>  - Changed the updating of tio->enabled to a centralized place in
>    disable and enable functions.
>=20
> Changes from v9:
>  - use tio->enabled instead of reading ctrl register.
>  - change error code in enable_store to -ENODEV.
>=20
> Lakshmi Sowjanya D (3):
>   pps: generators: Add PPS Generator TIO Driver
>   Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
>   ABI: pps: Add ABI documentation for Intel TIO
>=20
>  .../ABI/testing/sysfs-platform-pps-tio        |   7 +
>  Documentation/driver-api/pps.rst              |  24 ++
>  MAINTAINERS                                   |   1 +
>  drivers/pps/generators/Kconfig                |  16 ++
>  drivers/pps/generators/Makefile               |   1 +
>  drivers/pps/generators/pps_gen_tio.c          | 264 ++++++++++++++++++
>  6 files changed, 313 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-pps-tio
>  create mode 100644 drivers/pps/generators/pps_gen_tio.c
>=20
> --
> 2.35.3

Hi,

A gentle reminder for the review of the pps patchset.

Regards
Sowjanya


