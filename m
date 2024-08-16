Return-Path: <linux-kernel+bounces-290170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969E195503F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 19:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196B01F27C48
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5011C2326;
	Fri, 16 Aug 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CeB1qqFY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCB11AC8BE
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830632; cv=fail; b=a2kWAOPK0uyJdMi9AIzwJ9xI/U+jD77e2rpAlfMMOuj56LwnuR6s1vZuTli5KD3KxCYWzgC+KgCasg8bkqgjdPGnsi08rC3RUjc5t4Zfkfb1K65nA1oxCpv1x6Kk4AIwDpWoZ8GG6D/y3cpjA7LOmkjwtTMZ3DONV7zQ2thKA40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830632; c=relaxed/simple;
	bh=i42+RFq0NxrWJ52ILItW0r2OJk/p0wtvJy54WOL7EYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ugZL7Llw93klXbRqIeaJC+uI9/BJpCEP4U4tW8g2uReXAUapblMz/lt/aH2F6T/340X8H8YsHFivib2+UNO2zSEmBOcdUPTdh9HsWiiOU6dKNns3eEc8ue/qI14ux2dx0eF2+5eBQnKu+OylicUcgbV3cwOytu8CevAqO4SYjEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CeB1qqFY; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723830630; x=1755366630;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i42+RFq0NxrWJ52ILItW0r2OJk/p0wtvJy54WOL7EYk=;
  b=CeB1qqFYU8pLuR3dRMSVVCu1cZMtx9MFKVaqItKgoAUA9eSdFykzN9yE
   IiRBnqGi7eRgGjrHcU/qnR8kheLIRPFT8VfR7SBr1XMaAJsu44h1ZcKf7
   MUiLlsa1J3E29fZcmhBxJtG1sj+bE498cfYX8MDjPJEaWGuF8gEtxGsPu
   A01QTQT+6Z3tdcl4QWxs50uQHGDsaxVRADmPim9ZetImfme3zy6jTGrb7
   v/IxxmN7pNERSnSJz9NcjSqBP1ZsKjqmmeITftX4UUg7fMAY3ov8Mni5E
   R3uzhzxs+vYj3wMHeK+Q2fRDLl4HsecuCwPrqnUHpI37jPbj2h/Q9/GZR
   A==;
X-CSE-ConnectionGUID: SdSjBVaRR7i1vTdaX8xZ7w==
X-CSE-MsgGUID: 5tATgIQlT1yfcjLve495bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="32708770"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="32708770"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 10:50:30 -0700
X-CSE-ConnectionGUID: kEm3XCV0Qr+iNnAfRPQjxw==
X-CSE-MsgGUID: jiDQfTj+SImejujteBeRLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="90474667"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 10:50:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 10:50:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 10:50:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 10:50:28 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 10:50:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsjgK4EfGbric9Iqt7kbTDP0NbtY/LV4fsij/fOpOHFFg3Nf0yoEQHL/lfnoL9KD41Y7qFIOh3HZ+fG+eJKMR121QzdiwcaQyAPKqbWIt1LAufGUSMdkamcPjQgcuR5tz8X+e90V1HallLwb7LGMjkbToZoPzjL8phLsf8GgB/1AHqevIa2xlIeBrjwzA2Dn0Y9lboAopZTIOPidaGRkMTVaLKCWlEokM2UIGnR0g91H5gNtWekxzBCcCfLs9SdGjQhPlMrsaGKWd2PGf3pW6umhKft1nnfby2CEbDk3mjEEdLSZ4JMjQBWqE95AV2BzjPhd3hLyqHqs8zez97tFfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AB/4W5KZ7HVO5+UdnI3yiAfdOLiSSbdLDb1rvrAhrtI=;
 b=Bxb5YhidpJ9p/TN9+PJDQKFNnhe9eccUD6vlBBJJyURgQKQdoxwEODJ36yKbvufywmuW5NlD6s1sX7xZfXJNj1byiIEd4vrER2s3IRt6AFa1Km47DPG0ZXIHru+1Z6r6i6oq2B2lJVhD2SRW7gk9Do+f3divX3JLyGW9C86uJTOBBJiF9QwxkzvQ614l4GuwcAKHmxHnNF8Z24fr+fDDgoo/o2qvxKAW8zOa6rl1YOX9zsR4jqnYniMgAHz0Qxt+nt23SxMSBETAuODYCPxBpb0iQ9nlDiaZbNpAE/A/f2aKrQ7QQO5qLTC8NrU9cbDvyaRP1DWNRsiAhkaZcuf/lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by PH7PR11MB7569.namprd11.prod.outlook.com (2603:10b6:510:273::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 17:50:25 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 17:50:25 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v2 0/4] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v2 0/4] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa75/gkh13vSwe20SvwzfhstERuLIpl9+8gACQpWA=
Date: Fri, 16 Aug 2024 17:50:25 +0000
Message-ID: <SJ0PR11MB5678CB95FA021718B184CFF4C9812@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240816054805.5201-1-kanchana.p.sridhar@intel.com>
 <87ttfkj0wn.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87ttfkj0wn.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|PH7PR11MB7569:EE_
x-ms-office365-filtering-correlation-id: 4e8ad3a8-8cc4-4028-8a20-08dcbe1be8a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?qNFPgzX5KqZZ/b72tUct0OS0NjMg2/Q7el4qWb8BJE1Mb6ec+GQduUvlS51H?=
 =?us-ascii?Q?EQajZFUbHQHXmz3c45hupyY8YE5VF1pJoVzUnqCy7rh/OSCfvURLx++1r/du?=
 =?us-ascii?Q?U5DP9vYzqETu4OUvwhwv3ACjVl2deMLy9H3VA6oy0GHjU6hUa64m9jX6KQX9?=
 =?us-ascii?Q?rjlKmLJVvHxVWxLiaq+a/uiK/gAiXz8gbIM4vZicFH8EGJex3b8vTvqrD+wV?=
 =?us-ascii?Q?yjbQL1vXWzmo2mfuoGeZ4dU/dFvZY/CptoqlVhd9PPiKmumUAC2olts+03iq?=
 =?us-ascii?Q?dxlszWlZxqOp9pvv/ApphW5sZgMisg3u35Hx36LckMOPBHtj5TiMFc/9cHFj?=
 =?us-ascii?Q?Jz4QDNIX4vew+UrR7yE6EZhGWyPdMblMC80XggpUwnMrMMwFUWbMMcSvYN9e?=
 =?us-ascii?Q?b4VtnrZEI54KdQyGhA0TjP8RuO0yor926dYW/ttVkU82riqwtWQPAqRwDY4Q?=
 =?us-ascii?Q?9JVvjqIQ3Tw5M73A7UkbgEf4sZ+ezw7GQW/dEMbtXEMNXRqsPUBuCndPvsDs?=
 =?us-ascii?Q?/2o/EZYSBAuRCowXZtUGz2Lgoe0XGnIvYQ9SRNKiHLBn7sDmV2N8AgwmmrxU?=
 =?us-ascii?Q?6Tb+tyxKfHoOHFO/TcCcazlBaVzr+tQ0OP+Ycf1XN8C3bxf0Q7kgNgNr55ye?=
 =?us-ascii?Q?plCEGvZX3VmvNMMYrso2v3UQgam6vWfO9vx+bA8i0hQPkXhLrfMfZ3QFXTro?=
 =?us-ascii?Q?I4r0q/KaN0ANiqw5ZTm5TFZtFU6A0sEuxyWBi3CrYj+e2QBbwjk2cjt3rkBr?=
 =?us-ascii?Q?ejTB+WV91EvZLyzg9rdtW+Kg5VacWChDgnhJDuSn9KDH6AoxhbmmPcVPtjwd?=
 =?us-ascii?Q?5wdyEaWAIUlDckNrJ0+nVbO1BABhFQuRsmz4Jf9u9UEnF0EJiUpI2iwg8LNu?=
 =?us-ascii?Q?ePio5vMRRiq+Mb+D7RJpM4opND13gHD+QyMqISuktSxoY1PfEeb+7eHKTFBs?=
 =?us-ascii?Q?dP3vrq9Kyrjcet0o+kkDVXB41hS0OimO3/5HfNGeg2AUQjxJN26Gc/axk8D3?=
 =?us-ascii?Q?CFkmBgnuJu1sDE9cd7kQ+Z3NQM7zOW7a2lD3dhBtChV233qSlnh4AovnIJoR?=
 =?us-ascii?Q?kOSRjfQTKjOKWVD2blyp4eaBjqaimUawVGXqSTB+2XcNDzKK9zOE/DMAdSqE?=
 =?us-ascii?Q?CLDRK9BbWZOeB64tBQ/y+0dLSXdhPdwe5KTqyDxAnZoxomRUCL02TekzPm2U?=
 =?us-ascii?Q?Bbp36k9paCa1499hicvIBcGsbO5GuFJaXcAeGL3KXxNCIOeZn5gm2VrkzZ1z?=
 =?us-ascii?Q?oUlKVbu0Nv7Bc0v1xidAFlmTKd5FOZ+OZ5NBbrERFsWtd1rpJpdkl3Ce8liN?=
 =?us-ascii?Q?RFbxuGTlXkf1V1rtVhsOI5oY1h5MdiESctZ6yEX50BdcqjPX99IbUcuU/75e?=
 =?us-ascii?Q?KkV8eNA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6QPPepPQ/wx0lgP0U1smEEJvdOW6Q6zj/Vsd2KrXePEqc1k8m/+89eYMes9L?=
 =?us-ascii?Q?CW8TvBQNpN+1ocx00mXat7XB0Mg7c1KtPI2vIpdn9+Lh82LGm7F/9GcIEs/O?=
 =?us-ascii?Q?7O62YNuiMWcBKFLOyTOVHMj6gvlII+YG8dXqWdzNjDviQnpiNEYJIM6DR+LF?=
 =?us-ascii?Q?+jmluyHxiTHbFG16NHhg3Ltp3mBiShqPZMFRiASJ+RTKqnV/GgA5bh6FjA9I?=
 =?us-ascii?Q?3f0zbg1IH7mwO0F7PWN1OLPalT9yIXxH/6pFQ8mgQgFmDuUVuN85ywFp8VlU?=
 =?us-ascii?Q?2UmRKxCM64su3FcmpKWTRxbv/XPAFYNXBC2bDC6KvJAXa09InB6QpmNMrqzt?=
 =?us-ascii?Q?KaOGHWnLfySKW5bTSLs0HPVWikFfU4Q+3rTOIJuLyHROiA0Yv/H4IbOuZad0?=
 =?us-ascii?Q?g8teZShzsZ7y9GU4zr/hjfjSuSQ2Bt8mPzNUzaS3ksHfEpvOppZJk8s2RhCO?=
 =?us-ascii?Q?/UJP3kKD1nJvP2F3F6brG5gBrq5/sHrYkBGDQkRdVxC7nbKSwVa/005cifeP?=
 =?us-ascii?Q?c3QBOtsBYqFJmaK1E+9cB20zTPRGhqJ0boli6f7DtIuH1sMlzgKNkGgSuBCr?=
 =?us-ascii?Q?WKVI/6MIr/FKPtmTEy+fAtQw9E9dk74NQKOaIWhAFUH3RiGhDV3NZQEwOxas?=
 =?us-ascii?Q?RJloteLggAN3JhXkOlOExF/noCreK98DV8KSXZcrCDrDgSRf2Cz5ZqPn1QQm?=
 =?us-ascii?Q?othN2Es6lKp1EEOQQr75m2aCSsGQaKGruxSd6T+grspISJ9LIH1vPOSh3tcD?=
 =?us-ascii?Q?X5PqOsAL2nPqTQRN8hBe7opRk5Tg61tVnEXHLFqCgs+vEowIaBHciQneZtGp?=
 =?us-ascii?Q?fEhV1+jZvrVZ2cmDlOout5Qt/2JFqeuXfgW+2YrI3R8S3QrvcxujmxYSSoAL?=
 =?us-ascii?Q?SZI9TbRB/Jmin2L6w5LDNROU6OIgvVf5DOlbe13VyyWIWbG5gCoJ0tPVXLk9?=
 =?us-ascii?Q?Ls9SL1e8hrsy9b0BSqmWA80rzwb8J+pzzeknI0MSmIcFW0i718CH0J7B+kQP?=
 =?us-ascii?Q?yH6yKKAAUORo85JR08bbzYToCSFD4ZSRSP/VUh+bz9mnEzOf3sMqNsWvOSvx?=
 =?us-ascii?Q?uHlZs0d3miQPo7OXD/b3pNf6Q9f6o+fglX0p/7SmH59Vwl+aWnvmq3BkPpva?=
 =?us-ascii?Q?M3WNDMgGcERGrRvImXucrw0f62HgdqM0PK3QIIhVkc2CqrP8FdJdadCcYkYP?=
 =?us-ascii?Q?XMZi67rAU0ju8IqWTTYUBXvzqf2TO/RJkQuEvzgokVQSibzdCEIdeM1ycSJ7?=
 =?us-ascii?Q?vRpZF3f/e0ovhErrYHzV+C92dwiUUOTdlFW6v3rWfK1/PTfO72mE9atzGVA9?=
 =?us-ascii?Q?1PtegdEWZ48dCywwgzieqY+K1NDRgUkytgwDmaRzoAHByzB3gwGcqrtuUC1X?=
 =?us-ascii?Q?nyiFgIVGGFdh+0kAVIph2EYrROgjc3Pxn4AMs1mJykEsdjgu464Q2ER7Ubra?=
 =?us-ascii?Q?OxyyU+2n/cE3QWw8AoKkMUE6wotS/oU2zriE8Z3SGG7Ernk4tswwcI2JSkOH?=
 =?us-ascii?Q?wkBCHvrF6DDwMIlW2ylr9Sl7Rtq/akMZwd+Ts3wjmXGgkwwPu0TtAFjkfpZS?=
 =?us-ascii?Q?88Rm2VAcaSS4pfVUjHN9ZKQXaHUckJ77BTwp7TU4PGZCNLUt7ci8hy/qCSys?=
 =?us-ascii?Q?aQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8ad3a8-8cc4-4028-8a20-08dcbe1be8a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 17:50:25.6262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jc35PLUfoOd3F6E6OzN9ZLUnkVP2OAaHU72cTwtdia9EG0K4EuIArMbZpoMWYQufgtlQQBKsJ9Faik/00PRoNQomGdLDC9PR0o22C9RqQ5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7569
X-OriginatorOrg: intel.com

Hi Ying,

> -----Original Message-----
> From: Huang, Ying <ying.huang@intel.com>
> Sent: Friday, August 16, 2024 2:03 AM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> hannes@cmpxchg.org; yosryahmed@google.com; nphamcs@gmail.com;
> ryan.roberts@arm.com; 21cnbao@gmail.com; akpm@linux-foundation.org;
> Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> Subject: Re: [PATCH v2 0/4] mm: ZSWAP swap-out of mTHP folios
>=20
> Kanchana P Sridhar <kanchana.p.sridhar@intel.com> writes:
>=20
> > Hi All,
> >
> > This patch-series enables zswap_store() to accept and store mTHP
> > folios. The most significant contribution in this series is from the
> > earlier RFC submitted by Ryan Roberts [1]. Ryan's original RFC has been
> > migrated to v6.11-rc3 in patch 2/4 of this series.
> >
> > [1]: [RFC PATCH v1] mm: zswap: Store large folios without splitting
> >      https://lore.kernel.org/linux-mm/20231019110543.3284654-1-
> ryan.roberts@arm.com/T/#u
> >
> > Additionally, there is an attempt to modularize some of the functionali=
ty
> > in zswap_store(), to make it more amenable to supporting any-order
> > mTHPs.
> >
> > For instance, the determination of whether a folio is same-filled is
> > based on mapping an index into the folio to derive the page. Likewise,
> > there is a function "zswap_store_entry" added to store a zswap_entry in
> > the xarray.
> >
> > For accounting purposes, the patch-series adds per-order mTHP sysfs
> > "zswpout" counters that get incremented upon successful zswap_store of
> > an mTHP folio:
> >
> > /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/zswpout
> >
> > This patch-series is a precursor to ZSWAP compress batching of mTHP
> > swap-out and decompress batching of swap-ins based on
> swapin_readahead(),
> > using Intel IAA hardware acceleration, which we would like to submit in
> > subsequent RFC patch-series, with performance improvement data.
> >
> > Thanks to Ying Huang for pre-posting review feedback and suggestions!
> >
> > Changes since RFC v1:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > 1) Use sysfs for zswpout mTHP stats, as per Barry Song's suggestion.
> >    Thanks Barry!
> > 2) Addressed some of the code review comments that Nhat Pham provided
> in
> >    Ryan's initial RFC [1]:
> >    - Added a comment about the cgroup zswap limit checks occuring once
> per
> >      folio at the beginning of zswap_store().
> >      Nhat, Ryan, please do let me know if the comments convey the summa=
ry
> >      from the RFC discussion. Thanks!
> >    - Posted data on running the cgroup suite's zswap kselftest.
> > 3) Rebased to v6.11-rc3.
> > 4) Gathered performance data with usemem and the rebased patch-series.
> >
> > Performance Testing:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Testing of this patch-series was done with the v6.11-rc3 mainline, with=
out
> > and with this patch-series, on an Intel Sapphire Rapids server,
> > dual-socket 56 cores per socket, 4 IAA devices per socket.
> >
> > The system has 503 GiB RAM, 176 GiB swap/ZSWAP with ZRAM as the
> backing
> > swap device. Core frequency was fixed at 2500MHz.
>=20
> I don't think that this is a reasonable test configuration, there's no
> benefit to use ZSWAP+ZRAM.  We should use a normal SSD as backing swap
> device.

Thanks for this suggestion. Sure, I will gather data using SSD instead of Z=
RAM
as the backing swap device.

>=20
> > The vm-scalability "usemem" test was run in a cgroup whose memory.high
> > was fixed at 40G. Following a similar methodology as in Ryan Roberts'
> > "Swap-out mTHP without splitting" series [2], 70 usemem processes were
> > run, each allocating and writing 1G of memory:
> >
> >     usemem --init-time -w -O -n 70 1g
> >
> > Other kernel configuration parameters:
> >
> >     ZSWAP Compressor  : LZ4, DEFLATE-IAA
> >     ZSWAP Allocator   : ZSMALLOC
> >     ZRAM Compressor   : LZO-RLE
> >     SWAP page-cluster : 2
> >
> > In the experiments where "deflate-iaa" is used as the ZSWAP compressor,
> > IAA "compression verification" is enabled. Hence each IAA compression
> > will be decompressed internally by the "iaa_crypto" driver, the crc-s
> > returned by the hardware will be compared and errors reported in case o=
f
> > mismatches. Thus "deflate-iaa" helps ensure better data integrity as
> > compared to the software compressors.
> >
> > Throughput reported by usemem and perf sys time for running the test
> > are as follows:
> >
> >  64KB mTHP:
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   ------------------------------------------------------------------
> >  |                    |                   |            |            |
> >  |Kernel              | mTHP SWAP-OUT     | Throughput | Improvement|
> >  |                    |                   |       KB/s |            |
> >  |--------------------|-------------------|------------|------------|
> >  |v6.11-rc3 mainline  | ZRAM lzo-rle      |    118,928 |   Baseline |
> >  |zswap-mTHP-Store    | ZSWAP lz4         |     82,665 |       -30% |
>=20
> Because the test configuration isn't reasonable, the performance drop
> isn't reasonable too.  We should compare between zswap+SSD w/o mTHP
> zswap and zswap+SSD w/ mTHP zswap.  I think that there should be
> performance improvement for that.

Sure, I will gather and post the data with these two configurations.

Thanks,
Kanchana

>=20
> >  |zswap-mTHP-Store    | ZSWAP deflate-iaa |    176,210 |        48% |
> >  |------------------------------------------------------------------|
> >  |                    |                   |            |            |
> >  |Kernel              | mTHP SWAP-OUT     |   Sys time | Improvement|
> >  |                    |                   |        sec |            |
> >  |--------------------|-------------------|------------|------------|
> >  |v6.11-rc3 mainline  | ZRAM lzo-rle      |   1,032.20 |   Baseline |
> >  |zswap-mTHP=3DStore    | ZSWAP lz4         |   1,854.51 |       -80% |
> >  |zswap-mTHP-Store    | ZSWAP deflate-iaa |     582.71 |        44% |
> >   ------------------------------------------------------------------
> >
> >   ---------------------------------------------------------------------=
--
> >  | VMSTATS, mTHP ZSWAP stats,   |  v6.11-rc3 |  zswap-mTHP |  zswap-
> mTHP |
> >  | mTHP ZRAM stats:             |   mainline |       Store |       Stor=
e |
> >  |                              |            |         lz4 | deflate-ia=
a |
> >  |---------------------------------------------------------------------=
--|
> >  | pswpin                       |         16 |           0 |           =
0 |
> >  | pswpout                      |  7,770,720 |           0 |           =
0 |
> >  | zswpin                       |        547 |         695 |         57=
9 |
> >  | zswpout                      |      1,394 |  15,462,778 |   7,284,55=
4 |
> >  |---------------------------------------------------------------------=
--|
> >  | thp_swpout                   |          0 |           0 |           =
0 |
> >  | thp_swpout_fallback          |          0 |           0 |           =
0 |
> >  | pgmajfault                   |      3,786 |       3,541 |       3,36=
7 |
> >  |---------------------------------------------------------------------=
--|
> >  | hugepages-64kB/stats/zswpout |            |     966,328 |     455,19=
6 |
> >  |---------------------------------------------------------------------=
--|
> >  | hugepages-64kB/stats/swpout  |    485,670 |           0 |           =
0 |
> >   ---------------------------------------------------------------------=
--
> >
> >
> >  2MB PMD-THP/2048K mTHP:
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   ------------------------------------------------------------------
> >  |                    |                   |            |            |
> >  |Kernel              | mTHP SWAP-OUT     | Throughput | Improvement|
> >  |                    |                   |       KB/s |            |
> >  |--------------------|-------------------|------------|------------|
> >  |v6.11-rc3 mainline  | ZRAM lzo-rle      |    177,340 |   Baseline |
> >  |zswap-mTHP-Store    | ZSWAP lz4         |     84,030 |       -53% |
> >  |zswap-mTHP-Store    | ZSWAP deflate-iaa |    185,691 |         5% |
> >  |------------------------------------------------------------------|
> >  |                    |                   |            |            |
> >  |Kernel              | mTHP SWAP-OUT     |   Sys time | Improvement|
> >  |                    |                   |        sec |            |
> >  |--------------------|-------------------|------------|------------|
> >  |v6.11-rc3 mainline  | ZRAM lzo-rle      |     876.29 |   Baseline |
> >  |zswap-mTHP-Store    | ZSWAP lz4         |   1,740.55 |       -99% |
> >  |zswap-mTHP-Store    | ZSWAP deflate-iaa |     650.33 |        26% |
> >   ------------------------------------------------------------------
> >
> >   ---------------------------------------------------------------------=
----
> >  | VMSTATS, mTHP ZSWAP stats,     |  v6.11-rc3 |  zswap-mTHP |  zswap-
> mTHP |
> >  | mTHP ZRAM stats:               |   mainline |       Store |       St=
ore |
> >  |                                |            |         lz4 | deflate-=
iaa |
> >  |---------------------------------------------------------------------=
----|
> >  | pswpin                         |          0 |           0 |         =
  0 |
> >  | pswpout                        |  8,628,224 |           0 |         =
  0 |
> >  | zswpin                         |        678 |      22,733 |       1,=
641 |
> >  | zswpout                        |      1,481 |  14,828,597 |   9,404,=
937 |
> >  |---------------------------------------------------------------------=
----|
> >  | thp_swpout                     |     16,852 |           0 |         =
  0 |
> >  | thp_swpout_fallback            |          0 |           0 |         =
  0 |
> >  | pgmajfault                     |      3,467 |      25,550 |       4,=
800 |
> >  |---------------------------------------------------------------------=
----|
> >  | hugepages-2048kB/stats/zswpout |            |      28,924 |      18,=
366 |
> >  |---------------------------------------------------------------------=
----|
> >  | hugepages-2048kB/stats/swpout  |     16,852 |           0 |         =
  0 |
> >   ---------------------------------------------------------------------=
----
> >
> > As expected, in the "Before" experiment, there are relatively fewer
> > swapouts because ZRAM utilization is not accounted in the cgroup.
> >
> > With the introduction of zswap_store mTHP, the "After" data reflects th=
e
> > higher swapout activity, and consequent throughput/sys time degradation
> > when LZ4 is used as the zswap compressor. However, we observe
> considerable
> > throughput and sys time improvement in the "After" data when DEFLATE-
> IAA
> > is the zswap compressor. This observation holds for 64K mTHP and 2MB TH=
P
> > experiments. IAA's higher compression ratio and better compress latency
> > can be attributed to fewer swap-outs and major page-faults, that result
> > in better throughput and sys time.
> >
> > Our goal is to improve ZSWAP mTHP store performance using batching. Wit=
h
> > Intel IAA compress/decompress batching used in ZSWAP (to be submitted a=
s
> > additional RFC series), we are able to demonstrate significant
> > performance improvements and memory savings with IAA as compared to
> > software compressors.
> >
> > cgroup zswap kselftest:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > "Before":
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   Test run with v6.11-rc3 and no code changes:
> >     mTHP 64K set to 'always'
> >     zswap compressor set to 'lz4'
> >     page-cluster =3D 3
> >
> >   zswap shrinker_enabled =3D N:
> >   ---------------------------
> >   ok 1 test_zswap_usage
> >   ok 2 test_swapin_nozswap
> >   # at least 24MB should be brought back from zswap
> >   not ok 3 test_zswapin
> >   # zswpwb_after is 0 while wb is enablednot ok 4
> test_zswap_writeback_enabled
> >   # Failed to reclaim all of the requested memory
> >   not ok 5 test_zswap_writeback_disabled
> >   ok 6 # SKIP test_no_kmem_bypass
> >   ok 7 test_no_invasive_cgroup_shrink
> >
> >   zswap shrinker_enabled =3D Y:
> >   ---------------------------
> >   ok 1 test_zswap_usage
> >   ok 2 test_swapin_nozswap
> >   # at least 24MB should be brought back from zswap
> >   not ok 3 test_zswapin
> >   # zswpwb_after is 0 while wb is enablednot ok 4
> test_zswap_writeback_enabled
> >   # Failed to reclaim all of the requested memory
> >   not ok 5 test_zswap_writeback_disabled
> >   ok 6 # SKIP test_no_kmem_bypass
> >   not ok 7 test_no_invasive_cgroup_shrink
> >
> > "After":
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >   Test run with this patch-series and v6.11-rc3:
> >     mTHP 64K set to 'always'
> >     zswap compressor set to 'deflate-iaa'
> >     page-cluster =3D 3
> >
> >   zswap shrinker_enabled =3D N:
> >   ---------------------------
> >   ok 1 test_zswap_usage
> >   ok 2 test_swapin_nozswap
> >   ok 3 test_zswapin
> >   ok 4 test_zswap_writeback_enabled
> >   ok 5 test_zswap_writeback_disabled
> >   ok 6 # SKIP test_no_kmem_bypass
> >   ok 7 test_no_invasive_cgroup_shrink
> >
> >   zswap shrinker_enabled =3D Y:
> >   ---------------------------
> >   ok 1 test_zswap_usage
> >   ok 2 test_swapin_nozswap
> >   # at least 24MB should be brought back from zswap
> >   not ok 3 test_zswapin
> >   ok 4 test_zswap_writeback_enabled
> >   ok 5 test_zswap_writeback_disabled
> >   ok 6 # SKIP test_no_kmem_bypass
> >   not ok 7 test_no_invasive_cgroup_shrink
> >
> > I haven't taken an in-depth look into the cgroup zswap tests, but it
> > looks like the results with the patch-series are no worse than without,
> > and in some cases better (not exactly sure why, this needs more
> > analysis).
> >
> > I would greatly appreciate your code review comments and suggestions!
> >
> > Thanks,
> > Kanchana
> >
> > [2] https://lore.kernel.org/linux-mm/20240408183946.2991168-1-
> ryan.roberts@arm.com/
> >
> >
> > Kanchana P Sridhar (4):
> >   mm: zswap: zswap_is_folio_same_filled() takes an index in the folio.
> >   mm: zswap: zswap_store() extended to handle mTHP folios.
> >   mm: Add MTHP_STAT_ZSWPOUT to sysfs per-order mthp stats.
> >   mm: swap: Count successful mTHP ZSWAP stores in sysfs mTHP stats.
> >
> >  include/linux/huge_mm.h |   1 +
> >  mm/huge_memory.c        |   2 +
> >  mm/page_io.c            |   7 ++
> >  mm/zswap.c              | 238 +++++++++++++++++++++++++++++-----------
> >  4 files changed, 184 insertions(+), 64 deletions(-)
>=20
> --
> Best Regards,
> Huang, Ying

