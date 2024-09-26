Return-Path: <linux-kernel+bounces-339863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5833986B81
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49773B218B9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02898176AA0;
	Thu, 26 Sep 2024 03:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ed3K1/xv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9FE15921D
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727322503; cv=fail; b=YTPoN1xR6k2rN9lQ29uIpolAl5fVc9c15RN4IoE3VQ7KWBw/frGufnI9VpqLWKmTIINGFq/hoVkccAcuhvxBSkdAbxSKMq/y5afFbtTCcTBrROuIIfZG5l2m8hXck+65eOVcIwsRRCZHbPu8W4Qj40Nx+kTmsnKYxknxxn0yQ1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727322503; c=relaxed/simple;
	bh=hJb2m0tjhoUMQWjEl5MQXjGkSaJW9udpd/5H0qFvx44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D0DxGEAPiAvfZ8AwIQ/XnyMdAruC4xnMGo4uCxCW/VTASd3X6xP2dfLS+Lcl+W7ijmRvjKGT8peVnysw67gTp8+KB8Y9lRXH8d/xQEjsXDrfzOske8/MaWemHLmQl0uj6Dl6x2ArhrEylInGQFr5/6n4lScsgXXizN4UCf4kRWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ed3K1/xv; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727322501; x=1758858501;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hJb2m0tjhoUMQWjEl5MQXjGkSaJW9udpd/5H0qFvx44=;
  b=ed3K1/xvx+28SjaCkMxsBtv3jKMdXlxOY6bZP8Gtrwo2taWMKIXUn72V
   JuZvLDNrGzvzoUDoKkSDbSxa4+TkeTD/0qZRlEXQALyRrQ2OxAgKemvGK
   3A+cUcIr9h2gyzrAuLnTLgVlpPAgXNZMxU48HVkvc7x1ta3OMiCo3J5XN
   sb19Tty44SKvkeQJM4rrW/+rIcJAFfP0bvu3HzmgXpqdj5gQw8kKqw914
   fi3JGB6s0ziDVBwaO5x+6OTFMlvWnz84vGBi6hYDqIQ8T9uowJH2F84PL
   ih+o77iIhYNh9EjLOOWXOkOlPpJP8QPZS7YTzjxmYi0NHdLGFmwflojAr
   g==;
X-CSE-ConnectionGUID: p+WSPVWSQw+6ke6+z9jDmw==
X-CSE-MsgGUID: TkFtkTlFQUaG2e9IkVZEog==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="37071042"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="37071042"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 20:48:18 -0700
X-CSE-ConnectionGUID: XFejLWpjTauGbo9Wv48dIQ==
X-CSE-MsgGUID: MKe5K+jNQKe89Zx9hJgxww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="71660572"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 20:48:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 20:48:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 20:48:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 20:48:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pl8Fv17Kkk7u4bHtt37RaCaBAMxWkftTcknat1zrCWdflJeEXxPlihBgd1p2kogBkliGA4js1SMcbb15LnSUHuLpFUULTSehTwVyuGzYawYMq4Ygl5oytPL0b6q8VB0fs5xuqcV/5rp0iJNCZJWNruzj5RO2kxMWK6aXbuOfTdSOTts+TuNH0kDhabNUzoWjbu8+QO+uxcwTzbsiFI0P/14hkfbdV09WGl14B4IJbqQlKMtZD2wPNTf7lkBLAhokRPcxA/ioDG5vzcmA5W7dDi4gaNdR0EBpa7nV/kOpQ1WcR0Op0L6xl3cP2XTgGqhwjbM+cNSusRw4dsBY7GmieA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWFv69c12OCqRKMD/Fv/HPNCDJFeD0IVMhXP3ZTp+4I=;
 b=TIVS6tgigCkZZNUcRAxoelrTDf4muP0zAuCsQ7iQg1IGuRtT5RLXQGn7ehKE8c+ksDhIXgXaY8pCi2d4zcSW2edLReGwJeHKQI8qQlQ4gTti99a7XacIRXrymD7kdRRwE6S5MddUtL8GYDt4Y8U+IbsMFdJZ6YnXmz54OC4v70roFUAkk26nRDllQrKWFWvlo2V0/Bq4S88q/3elqPz+cd6u4Y37qX1hRgongDgHYi9O0yVOgs/hfxd5RyP1m34Shz43vA4iwpKDnytSvvGzk6APuLgzMHMDlj8PtOWr/2KjS1KoqD+KVOruCuHug+QuVP4bZNz3HOIXSsG77Gxj9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 03:48:05 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 03:48:05 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 0/8] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v7 0/8] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHbDh9+WG1/kyAOWku1xyL3C5nTY7JoDu73gACtkACAAILSn4AALdHg
Date: Thu, 26 Sep 2024 03:48:05 +0000
Message-ID: <SJ0PR11MB5678899F41B3F243E54C59D2C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
	<87v7yks0kd.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<SJ0PR11MB5678BC6BBF8A4D7694EDDFDAC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <877cazs0p7.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <877cazs0p7.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SJ0PR11MB5866:EE_
x-ms-office365-filtering-correlation-id: b9e4cb03-a6c3-442d-af2c-08dcddde071e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?FsRK5krVmnEE0Yw9EJXDddG74l1YJpgWbia/hoOZSOL3xQnxcB8JTbW+9WGi?=
 =?us-ascii?Q?1Kw7sD/So4gN58I2510CfO0+NjNETgFWbWCrCOHUbvGVVhveqyMKf/kE72d1?=
 =?us-ascii?Q?un6Su0w/mFrVE6Ttz9RftZt5yyG3zo7MxTZpt+rT7zto39FwONAyFHtfT61I?=
 =?us-ascii?Q?gIfTZ6caOWiZPU/SWeUB62fOlVFyzKxq1MHfABKFx0Z5s0c3iGN1B0Q4FNP+?=
 =?us-ascii?Q?3SRsZAeoP9J56UsKPP5BhqhgfwzN1HWBSNGkM1TbgQwlrx04uh8MhNj1eVfg?=
 =?us-ascii?Q?NDb8ZdVMk4WlBB+aks9TIL5ruBQUNElZxwvWnyT9vVpDgdqKFEBsLoHWI1gD?=
 =?us-ascii?Q?23oI2F7NFCdZlPS2BHQctg97YojUXEMGgyO80z0anx4fLPf9c8W8OSRrlYpM?=
 =?us-ascii?Q?HdNdH1xNZM9eOSO3Y2L88uCG/g3fNDMjeNCvqL5VoLidcM1SefXk+vpLygSA?=
 =?us-ascii?Q?HwDSBlMlQGxlNCw7YAe42RQtyGAcHqTTf+oQRuXXm0dpx72KKyUo4VtxHtMf?=
 =?us-ascii?Q?PE4FI2kajp5eMiANm/p0tdFAzZTzm212GhqlESDdHGT7e2USa1XBKlq71ID5?=
 =?us-ascii?Q?HhMKklrRT3bWHnwzPH4nvRuizQtz/P2CWUGKb/gCkqEz9DPOkcXgqKmr3Q7V?=
 =?us-ascii?Q?P+yP/S6HQ1/3yAzNJXOgyyixbTiLg9DoE7IjfzEb8IcT5nSWfcLtoS087uDR?=
 =?us-ascii?Q?PyqZy5GSxEMl0QrES7FvwRzmSXCoqeZkzRcXbw+vVRjpQONTa3a9ZfKaIOHw?=
 =?us-ascii?Q?GOLQTNWc99s4DEC9l0kvr4qAjbBW/AVdVD7ITDfX2+LOKHL5GELVBqqcdVmR?=
 =?us-ascii?Q?VTbhCAI98oeZg40Ni+g0G/Pa9cNiAi4vVKIXOoNAv/TDPY1+cu/gbhoUUz7u?=
 =?us-ascii?Q?lm8+0IM0gQCvKdPr7kFDqeI3fkW4dnZnG8RHTwO00O/lFfV4th8/hRXuvE3A?=
 =?us-ascii?Q?Kf8yl0A1mk+laxFZRYmp1OUR7fVuWnEncJJ/d4gpsrPkBIAYeTmThHmJmzgK?=
 =?us-ascii?Q?7nNR9RKctEHwv81vqaLRjZXICwBfaGdHN+KnY8VkfSPdk37WphqRDXjz1g9C?=
 =?us-ascii?Q?MdhixVxhkx8QpGgMweLyoJgJdyX8Dh6T9YkW9UssUfVF9fnGgfd+3MZOgd/c?=
 =?us-ascii?Q?58C0H/emYTBenm/qd2lTnTAugkX2bnDq3jjAbuNVhb/yTZeVSNG62uWScfS+?=
 =?us-ascii?Q?6tg1SuRpOAOshzOm78+986HjXSAE72XAffS1IYD4dA7UT+atd3kDAzv7qjZa?=
 =?us-ascii?Q?kPvC7X+AL9r5VdW8p3ymlpjw4u3ZfGG88oRbvdpO06LMygaXOt2FS2by7VHE?=
 =?us-ascii?Q?K5aZ6SoLree0In57KL9ia3bp4DElHHPqWgeAZeoicXNSpg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?InIe/ep6iObhAtcycQRmNVFzohhp0c+2ZZVlI+8wfgmKDPSED5THWyqXXob2?=
 =?us-ascii?Q?BHzFtSCheM5dDIWlP+sFZXtFrQT7fNxO+wd6DWuwcxwTzZTyU/8pXazU5WzS?=
 =?us-ascii?Q?XAZdZJg6D0QBDMc7LrTKoMjB+vYnUNlHdCe2YGkZY1tne2KrsO85s1dUgkRd?=
 =?us-ascii?Q?CN7ORq2hhRM7n21D77+krnUeZlJgYFsDG1Obs+vX9FbS8P2fv7V9jAOd23fs?=
 =?us-ascii?Q?4s5oSewFdxQg+hkIo/e4Xp0E+Fpl3VKs9OqZTi30LF65CMU7lAfpCrgbbL7q?=
 =?us-ascii?Q?dS7tuIKGVpEIuhPZsUC9iY7QNomFG3t9YB1ykkUJ9gzDlJGooEOi/ycE/tuK?=
 =?us-ascii?Q?he1S9MYKjRyut11MUx7loeNNOdTYgAQZab2zexk5IKFjfhkhpCUkSsiT1nf6?=
 =?us-ascii?Q?MO50N4n0xJoMa/oyW+xoDMqh4bbTrpYJYJW02Jo/3q2OKauqgi3zUlDapcvK?=
 =?us-ascii?Q?bGnlA5SZBCtVIH8aHIa+Gs33w9yYvMJeZROfkZYZypwhZYG8JulHCWWESVvh?=
 =?us-ascii?Q?cp7SZxra8KGBD1h+B5jLxnQS9tpFj4UGd/IZ4qg9wqRwVQefJIpX8XZ/8puI?=
 =?us-ascii?Q?wpsYEdCRq6OTCCLFFeB3WOWXVF5MLWU3mvJDVnl0bsd7KiuKlQdPOJA1n7nz?=
 =?us-ascii?Q?EhmZr1/UV0oHAlHKTsi+tVKJd817sKG/2LomaUjBdmJQnlKizcE0rqB5QRob?=
 =?us-ascii?Q?z1Hu4bBGXrE9dVADtOpNIP18WIaXodhkxfPKJ6Y9sazUXjjTRuxkE9nouyjI?=
 =?us-ascii?Q?CfRiIuFtJ0y/YPO2f/FTFZnUXENKRhZPn5TEsm/SSBFKs/HdZ3/htFPSEkU6?=
 =?us-ascii?Q?JCxP1qr8gXI98oe6jZnDhWb7+gKo5drn/BCk5Rcc41DbMPiwMqUnBn8k5bfQ?=
 =?us-ascii?Q?z6l1RO1AnGgpfYisSfANZZshFmzDMHpjEfPdu3gQLyMF7bks4fBKgtfDYESf?=
 =?us-ascii?Q?gZeflZm/Y+X6XnzqvWvDJA5vIc/zie7H+4u8vBaAh4NU/Q3gtjd6nU69gUrq?=
 =?us-ascii?Q?Dis60svPcv6phcnhSvAM4UR82+lupAaT9qe5wMQsrpAx6SMIhVKMuFi7+kG/?=
 =?us-ascii?Q?cQRZeGExez9HLDC+gzzXqluRwqzKkCkvHoGblVPtmvw+Vqil5qPnEIwnTyYG?=
 =?us-ascii?Q?YMHoLVZ1T/mvaZQJQ66Lx4lHz/MmokswjXK4TeE8EqAAcIpV2714ogQxw0sF?=
 =?us-ascii?Q?h0rxG8xBjmvYv6/qCDHSndfI7WGivZDfbtDujhODZV/huJqk5Z+4u8A1gF/p?=
 =?us-ascii?Q?p+NTb3B1a6GMe9zfmt19uQhEmr6Ax3KwPLB+L9eQDBVpZphG9qksNWuWouG9?=
 =?us-ascii?Q?Tao6PfCooJkYwileKaG/N3ct7MZ/kch8y7Me66KskT+Els+AMAiWvMG+0L+C?=
 =?us-ascii?Q?gWkQmI7VRzMZsvUCNWkg7zd/jPVbxo05bgPkEBQVHNdhZYQo0Cg78xcXzD+z?=
 =?us-ascii?Q?OJlWlArUp0Duso0vIi7WYwq9555bzkbDoxNIymG7gYz4vFp56679y/7E5O3x?=
 =?us-ascii?Q?PP2II4yY4mew5bFMP/BcbBVuR8fYIC7eGd1SF/B9v8J7Dmo1bU2IPKT6shnS?=
 =?us-ascii?Q?7xypbAdrAPf5zKUQMwmzSBXf+co92ozN8aEF1DCMMxgoBTZ0skUYO7VQCZJy?=
 =?us-ascii?Q?pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e4cb03-a6c3-442d-af2c-08dcddde071e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 03:48:05.1331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAeVX3l3YaZZSDyRFMjEKZ2vIQ9Wygq346MQukaWGhkw4HVDsTgeT4cFcr/4/YWTtnKl9QZHPO+UJKmtWyVP4JzCWvtSsxelDod4FWKpuGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5866
X-OriginatorOrg: intel.com

Hi Ying,

> -----Original Message-----
> From: Huang, Ying <ying.huang@intel.com>
> Sent: Wednesday, September 25, 2024 5:45 PM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> hannes@cmpxchg.org; yosryahmed@google.com; nphamcs@gmail.com;
> chengming.zhou@linux.dev; usamaarif642@gmail.com;
> shakeel.butt@linux.dev; ryan.roberts@arm.com; 21cnbao@gmail.com;
> akpm@linux-foundation.org; Zou, Nanhai <nanhai.zou@intel.com>; Feghali,
> Wajdi K <wajdi.k.feghali@intel.com>; Gopal, Vinodh
> <vinodh.gopal@intel.com>
> Subject: Re: [PATCH v7 0/8] mm: ZSWAP swap-out of mTHP folios
>=20
> "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com> writes:
>=20
> >> -----Original Message-----
> >> From: Huang, Ying <ying.huang@intel.com>
> >> Sent: Tuesday, September 24, 2024 11:35 PM
> >> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> >> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> >> hannes@cmpxchg.org; yosryahmed@google.com; nphamcs@gmail.com;
> >> chengming.zhou@linux.dev; usamaarif642@gmail.com;
> >> shakeel.butt@linux.dev; ryan.roberts@arm.com; 21cnbao@gmail.com;
> >> akpm@linux-foundation.org; Zou, Nanhai <nanhai.zou@intel.com>;
> Feghali,
> >> Wajdi K <wajdi.k.feghali@intel.com>; Gopal, Vinodh
> >> <vinodh.gopal@intel.com>
> >> Subject: Re: [PATCH v7 0/8] mm: ZSWAP swap-out of mTHP folios
> >>
> >> Kanchana P Sridhar <kanchana.p.sridhar@intel.com> writes:
> >>
> >> [snip]
> >>
> >> >
> >> > Case 1: Comparing zswap 4K vs. zswap mTHP
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >
> >> > In this scenario, the "before" is CONFIG_THP_SWAP set to off, that
> results in
> >> > 64K/2M (m)THP to be split into 4K folios that get processed by zswap=
.
> >> >
> >> > The "after" is CONFIG_THP_SWAP set to on, and this patch-series, tha=
t
> >> results
> >> > in 64K/2M (m)THP to not be split, and processed by zswap.
> >> >
> >> >  64KB mTHP (cgroup memory.high set to 40G):
> >> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >
> >> >  -------------------------------------------------------------------=
------------
> >> >                     mm-unstable 9-23-2024              zswap-mTHP   =
  Change wrt
> >> >                         CONFIG_THP_SWAP=3DN       CONFIG_THP_SWAP=3D=
Y
> Baseline
> >> >                                  Baseline
> >> >  -------------------------------------------------------------------=
------------
> >> >  ZSWAP compressor       zstd     deflate-        zstd    deflate-  z=
std deflate-
> >> >                                       iaa                     iaa   =
         iaa
> >> >  -------------------------------------------------------------------=
------------
> >> >  Throughput (KB/s)   143,323      125,485     153,550     129,609   =
 7%
> 3%
> >> >  elapsed time (sec)    24.97        25.42       23.90       25.19   =
 4%       1%
> >> >  sys time (sec)       822.72       750.96      757.70      731.13   =
 8%       3%
> >> >  memcg_high          132,743      169,825     148,075     192,744
> >> >  memcg_swap_fail     639,067      841,553       2,204       2,215
> >> >  pswpin                    0            0           0           0
> >> >  pswpout                   0            0           0           0
> >> >  zswpin                  795          873         760         902
> >> >  zswpout          10,011,266   13,195,137  10,010,017  13,193,554
> >> >  thp_swpout                0            0           0           0
> >> >  thp_swpout_               0            0           0           0
> >> >   fallback
> >> >  64kB-mthp_          639,065      841,553       2,204       2,215
> >> >   swpout_fallback
> >> >  pgmajfault            2,861        2,924       3,054       3,259
> >> >  ZSWPOUT-64kB            n/a          n/a     623,451     822,268
> >> >  SWPOUT-64kB               0            0           0           0
> >> >  -------------------------------------------------------------------=
------------
> >> >
> >>
> >> IIUC, the throughput is the sum of throughput of all usemem processes?
> >>
> >> One possible issue of usemem test case is the "imbalance" issue.  That
> >> is, some usemem processes may swap-out/swap-in less, so the score is
> >> very high; while some other processes may swap-out/swap-in more, so th=
e
> >> score is very low.  Sometimes, the total score decreases, but the scor=
es
> >> of usemem processes are more balanced, so that the performance should
> be
> >> considered better.  And, in general, we should make usemem score
> >> balanced among processes via say longer test time.  Can you check this
> >> in your test results?
> >
> > Actually, the throughput data listed in the cover-letter is the average=
 of
> > all the usemem processes. Your observation about the "imbalance" issue =
is
> > right. Some processes see a higher throughput than others. I have notic=
ed
> > that the throughputs progressively reduce as the individual processes e=
xit
> > and print their stats.
> >
> > Listed below are the stats from two runs of usemem70: sleep 10 and slee=
p
> 30.
> > Both are run with a cgroup mem-limit of 40G. Data is with v7, 64K folio=
s are
> > enabled, zswap uses zstd.
> >
> >
> > -----------------------------------------------
> >                sleep 10           sleep 30
> >       Throughput (KB/s)  Throughput (KB/s)
> >  -----------------------------------------------
> >                 181,540            191,686
> >                 179,651            191,459
> >                 179,068            188,834
> >                 177,244            187,568
> >                 177,215            186,703
> >                 176,565            185,584
> >                 176,546            185,370
> >                 176,470            185,021
> >                 176,214            184,303
> >                 176,128            184,040
> >                 175,279            183,932
> >                 174,745            180,831
> >                 173,935            179,418
> >                 161,546            168,014
> >                 160,332            167,540
> >                 160,122            167,364
> >                 159,613            167,020
> >                 159,546            166,590
> >                 159,021            166,483
> >                 158,845            166,418
> >                 158,426            166,264
> >                 158,396            166,066
> >                 158,371            165,944
> >                 158,298            165,866
> >                 158,250            165,884
> >                 158,057            165,533
> >                 158,011            165,532
> >                 157,899            165,457
> >                 157,894            165,424
> >                 157,839            165,410
> >                 157,731            165,407
> >                 157,629            165,273
> >                 157,626            164,867
> >                 157,581            164,636
> >                 157,471            164,266
> >                 157,430            164,225
> >                 157,287            163,290
> >                 156,289            153,597
> >                 153,970            147,494
> >                 148,244            147,102
> >                 142,907            146,111
> >                 142,811            145,789
> >                 139,171            141,168
> >                 136,314            140,714
> >                 133,616            140,111
> >                 132,881            139,636
> >                 132,729            136,943
> >                 132,680            136,844
> >                 132,248            135,726
> >                 132,027            135,384
> >                 131,929            135,270
> >                 131,766            134,748
> >                 131,667            134,733
> >                 131,576            134,582
> >                 131,396            134,302
> >                 131,351            134,160
> >                 131,135            134,102
> >                 130,885            134,097
> >                 130,854            134,058
> >                 130,767            134,006
> >                 130,666            133,960
> >                 130,647            133,894
> >                 130,152            133,837
> >                 130,006            133,747
> >                 129,921            133,679
> >                 129,856            133,666
> >                 129,377            133,564
> >                 128,366            133,331
> >                 127,988            132,938
> >                 126,903            132,746
> >  -----------------------------------------------
> >       sum    10,526,916         10,919,561
> >   average       150,385            155,994
> >    stddev        17,551             19,633
> >  -----------------------------------------------
> >     elapsed       24.40              43.66
> >  time (sec)
> >    sys time      806.25             766.05
> >       (sec)
> >     zswpout  10,008,713         10,008,407
> >   64K folio     623,463            623,629
> >      swpout
> >  -----------------------------------------------
>=20
> Although there are some imbalance, I don't find it's too much.  So, I
> think the test result is reasonable.  Please pay attention to the
> imbalance issue in the future tests.

Sure, will do so.

>=20
> > As we increase the time for which allocations are maintained,
> > there seems to be a slight improvement in throughput, but the
> > variance increases as well. The processes with lower throughput
> > could be the ones that handle the memcg being over limit by
> > doing reclaim, possibly before they can allocate.
> >
> > Interestingly, the longer test time does seem to reduce the amount
> > of reclaim (hence lower sys time), but more 64K large folios seem to
> > be reclaimed. Could this mean that with longer test time (sleep 30),
> > more cold memory residing in large folios is getting reclaimed, as
> > against memory just relinquished by the exiting processes?
>=20
> I don't think longer sleep time in test helps much to balance.  Can you
> try with less process, and larger memory size per process?  I guess that
> this will improve balance.

I tried this, and the data is listed below:

  usemem options:
  ---------------
  30 processes allocate 10G each
  cgroup memory limit =3D 150G
  sleep 10
  525Gi SSD disk swap partition
  64K large folios enabled     =20

  Throughput (KB/s) of each of the 30 processes:
 ---------------------------------------------------------------
                      mm-unstable    zswap_store of large folios
                        9-25-2024                v7
 zswap compressor:           zstd         zstd  deflate-iaa
 ---------------------------------------------------------------
                           38,393      234,485      374,427
                           37,283      215,528      314,225
                           37,156      214,942      304,413
                           37,143      213,073      304,146
                           36,814      212,904      290,186
                           36,277      212,304      288,212
                           36,104      212,207      285,682
                           36,000      210,173      270,661
                           35,994      208,487      256,960
                           35,979      207,788      248,313
                           35,967      207,714      235,338
                           35,966      207,703      229,335
                           35,835      207,690      221,697
                           35,793      207,418      221,600
                           35,692      206,160      219,346
                           35,682      206,128      219,162
                           35,681      205,817      219,155
                           35,678      205,546      214,862
                           35,678      205,523      214,710
                           35,677      204,951      214,282
                           35,677      204,283      213,441
                           35,677      203,348      213,011
                           35,675      203,028      212,923
                           35,673      201,922      212,492
                           35,672      201,660      212,225
                           35,672      200,724      211,808
                           35,672      200,324      211,420
                           35,671      199,686      211,413
                           35,667      198,858      211,346
                           35,667      197,590      211,209
 ---------------------------------------------------------------
 sum                     1,081,515    6,217,964    7,268,000
 average                    36,051      207,265      242,267
 stddev                        655        7,010       42,234
 elapsed time (sec)         343.70       107.40        84.34
 sys time (sec)             269.30     2,520.13     1,696.20
 memcg.high breaches       443,672      475,074      623,333
 zswpout                    22,605   48,931,249   54,777,100
 pswpout                40,004,528            0            0
 hugepages-64K zswpout           0    3,057,090    3,421,855
 hugepages-64K swpout    2,500,283            0            0
 ---------------------------------------------------------------

As you can see, this is quite a memory-constrained scenario, where we
are giving a 50% of total memory required, as the memory limit for the
cgroup in which the 30 processes are run. This causes significantly more
reclaim activity than the setup I was using thus far (70 processes, 1G,
40G limit).

The variance or "imbalance" reduces somewhat for zstd, but not for IAA.

IAA shows really good throughput (17%) and elapsed time (21%) and
sys time (33%) improvement wrt zstd with zswap_store of large folios.
These are the memory-constrained scenarios in which IAA typically
does really well. IAA verify_compress is enabled, so this is an added
data integrity checks benefit we get with IAA.

I would like to get your and the maintainers' feedback on whether
I should switch to this "usemem30-10G" setup for v8?

Thanks,
Kanchana

>=20
> --
> Best Regards,
> Huang, Ying

