Return-Path: <linux-kernel+bounces-250204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B1092F520
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69DB61C2238C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A03D18044;
	Fri, 12 Jul 2024 05:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LMwCIl9H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C818037
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720762954; cv=fail; b=lsARXs6QaotERQ8G5ugXleHw+IFLC605QWl7J1i4Wlrf/Rwl21LL1X+kXObHtZWXGwzt0o1t7L0070Z48xBn1NLXO9GyjJnSxGkIka87Ka/EZVDSeRNQqm391xAh2NvlrX6rXe6BR/jSXQgHgvWYIIB6Ffln8ihTxqisprDoK4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720762954; c=relaxed/simple;
	bh=tRsPbiFogiT8LnO3z1WsXc8MAT+0mfTIS6mohUuIRaE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u6E7rdmS+plfQReaQ40H+0nSx36sGZzJSzviFewvaEuBJMqLfd0EBqg2IkdmYdRycHEBISLFzo/Z8oGheVgktZIHNPPdZEYF7Gi446/hFgYi4WKSn3PvCDD5rCkUH4VbWe7ZMbyTPwqRbCE1CCDTLuIWGY+V1xIPw5CVUDmED2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LMwCIl9H; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720762953; x=1752298953;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=tRsPbiFogiT8LnO3z1WsXc8MAT+0mfTIS6mohUuIRaE=;
  b=LMwCIl9HJ/csWThjJDLziM0cg5JCpy3LF9wj0wW2it12jsGFrPjdi1jW
   7LZBXvEM9X5RbDdyObM6AUW6Y6TodZX6a4+VtH1tGzscHFuAp7I6o2Kay
   AbIDyWuQNZCu16K9k/OUEoAU+K7J3ECSr114bEjx6iuvOv8hzUYO8M19l
   hGcJ/n/43xl5XcPC+ZLyBdkO1lxNTOmEMF5Zy9vNRibjZujVJ6YrdPfVZ
   ykpPRLb6n1a44qWOeURSHmtt02dLLSmeDwOXxUweu8626wiaxhUZpGLRs
   xhG+F1IpOc7pUVj7+76o/B3kwefNSClATPjp4e+Vtvog1gn6/qIJxQpLX
   Q==;
X-CSE-ConnectionGUID: Ojfuy/5wSlC0IoqK0GAg3A==
X-CSE-MsgGUID: lMHdO3y4QXeQm02/0fIrLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="21096604"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="21096604"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 22:42:32 -0700
X-CSE-ConnectionGUID: MKZC6Mf8R5yY8vF+Z+091w==
X-CSE-MsgGUID: OtZxGiENRn6ROg2Jc8dgsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="49458872"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 22:42:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 22:42:31 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 22:42:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 22:42:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 22:42:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWPJba0RUjgEKIyYDQZeIo3G+16Bz0NKHmQbW4sHSnVIdMlyov3ua9XoxOpeLzLExhoM6Y8jClkKjxcGzGSwuMrAnZhYKmocSLK76OsLVXavwJdvyA3Y2f1v2GHJqqQXXS5QjNY/CAbcVwjvDvrOjy7BeOwQuTHsUjPPvPPOeRwjqmvETihWN/7GiOkSF4fyxbA5W4KD5URSjHJhCuh6KC6G3PkwRoA30ehD4zkjCG3NtcV/57fmE1DlfkLJyjKaMnbFYSVTVAjrIalJrWmVcYVbLsU8adrqIIGD+wWUaDyJAoEJZ2BEzO2v+V3298Tz+9DwryqKEk+3dKkevuEDTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frqS/Mc6nLEGr/Wj7bJ/z97RApAQKYynibZS6aBLM68=;
 b=xM4ahBTMXUUs1wgJyDcPnLwwG7Lzax/WvmabtgVjbIlPImc8CHY2PVZxw8QAaT+cP+r8Adgf6gkaohrZmjmB55vLAWG/jTMrDzg/ZaggIzYAY84448saMwu7fRB8OGrFGcdLTaguuvBUzZhw21bOtdCS2a/rHuZ60/TP2SgtBUFxz7/9knj+Twh1lQhgadE0h1Bcd6uyFA5WueJBk94mr0bSYdD+lpN4ei+jRPHg+782nYfPDFBzDn6IbtV9Vx2oOiUJiqC6LgoMxhypm8frYCqgTmB9XF+VxGNTEPkRFDh+nTcNNOfdguf5e1dBDEWJZ1FttNrAYrHjB8xy9Rx5Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by CH3PR11MB7867.namprd11.prod.outlook.com (2603:10b6:610:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Fri, 12 Jul
 2024 05:42:28 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525%6]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 05:42:27 +0000
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To: "jiangshan.ljs@antgroup.com" <jiangshan.ljs@antgroup.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Nikula,
 Jani" <jani.nikula@intel.com>, "Saarinen, Jani" <jani.saarinen@intel.com>,
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>
Subject: Regression on linux-next (next-20240709)
Thread-Topic: Regression on linux-next (next-20240709)
Thread-Index: AdrUGlgPzCjArjqLR6Ou8zsvlQzOkQ==
Date: Fri, 12 Jul 2024 05:42:27 +0000
Message-ID: <SJ1PR11MB612946A115B182F4C81692EDB9A62@SJ1PR11MB6129.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6129:EE_|CH3PR11MB7867:EE_
x-ms-office365-filtering-correlation-id: 80ca1b52-520b-45b4-fedc-08dca2356a2a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?0IZ/wu1KdB+UEAXAiKubjZjcGM7754sn5ZA8O79/sHk9Or2s68unk9NNKu?=
 =?iso-8859-1?Q?MyKTc/8wxDvbFUqcBj/4EejwaVCD1QlGvVKrVaQY6bdEOiH1WgWcGTqNna?=
 =?iso-8859-1?Q?kSbX7YvVSQGy7eEYUE+mWJpoLs6Kxt10K1r+0oPQAbQMMXE5NdRoRolCCa?=
 =?iso-8859-1?Q?hf7mZzRdVsMqExVYWs2i66o15CNfbZ/uTeuVaVJiF7h4TOmZCb22OQ0s1w?=
 =?iso-8859-1?Q?OC1LJ6stWgmaYGRodXPL8H3de9m5ESr0wkAxAoFG6b6jy4fcToyB05H/m8?=
 =?iso-8859-1?Q?v6egg+ndo+BiIX92ybQFfva7iCn7ZLgW6xunkJlX4ecZS4bm4N7wZOfv5J?=
 =?iso-8859-1?Q?SPcGdAoLLzJmzubHRN0vDfM8kDKo05s/+OfiLnoVhND9lz1ug8BN3rkCMn?=
 =?iso-8859-1?Q?N72prlgxvf38HQc/u8cR1VF+6C0yp5cgdSzeIMQCoCO0MnmYii0CZaeBY2?=
 =?iso-8859-1?Q?nUFN3UEVaKKqj1YYISjqbhe355z0Uo4qvgfchQpa/Kxu5BWuNlbph0flA8?=
 =?iso-8859-1?Q?3zcBPww5O4x5sT+c+mpBt2MAdFS51XJDVvM6NGt2AArCjWwOEK75BoM2V3?=
 =?iso-8859-1?Q?52K4WkxpKsSDCxu85ZyHue0EgtLvGCi2dTwcWk0u8fH3e2lGKVy6T0zeXf?=
 =?iso-8859-1?Q?sGhMe9IiOV7UhEIeoghqFCK4L3/8Zfd31iDm/pySTTq5/yqhLO2Dkpet+U?=
 =?iso-8859-1?Q?QY0MmcUk+shAmujNWZXlH/a+qd33+OrXLYpWGY7Orkws5fqgvVY9fSJ8sQ?=
 =?iso-8859-1?Q?+i+a94VcBfjdTbI7Mqg3AfcruM1T+vVQN7WrWPb4FxhHbvFStEMQhBEpDs?=
 =?iso-8859-1?Q?zrneNR2x5RWD/mjLkfNzoZaXrD7WM844jm3w1Y5dZtKUSB17vfT/UXp1w1?=
 =?iso-8859-1?Q?V8B0QaaoaR8kcOkYzumZbdIbcRfU6RUW/9ckUkMeoWh0UvgAAHEyhv2oSM?=
 =?iso-8859-1?Q?DFUsj+3LbvGotwGmbkJdzLB0BpXOFk1bzo+WbkFwMbji+0qV4ZhtUCn6SI?=
 =?iso-8859-1?Q?GWPjLn8NLYW+JH0+y9DkZ0scnne3WPKh/kFZVyBnRmC8zabnieuR6LCZO8?=
 =?iso-8859-1?Q?Ij4WQMEHr9XiY512PYFi4hGzDcxU78SZwyqkmJBVyYDTjJkHYk01x17VFA?=
 =?iso-8859-1?Q?X6ETd8hH+kYnhpyPlm7dMhvLVrpc3o2CX6jiIMEioHyCaOkjGtKamDv1EB?=
 =?iso-8859-1?Q?QOStSvY1xmL5xMIxtDCL6xlT4dwlWSJROSSCkNEYFkJFYRF7Iwdj3YYRxE?=
 =?iso-8859-1?Q?WzpRBlmYgJMbv9VnHFNd+r3/53i+t7/5fuPRqjO1yOz4sm4qvRFdzFUKf9?=
 =?iso-8859-1?Q?KGVJuBlhwNCFr7NhbiV5KvZPMO8vQ7fKfvmX+vfoka9WHXl0pyNfFMcyP8?=
 =?iso-8859-1?Q?vCKQf/et7FbaLMdTrYQZhvq86hOcmKAC+e96+w0Npi461mVuixjnk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WNJAy6qR5aM6QgQzILXP0BOofP+OdgdImUGYcnfoYRr+gApU8/V9/VzHxd?=
 =?iso-8859-1?Q?G0bZmnwSjkOeFfOtwyZZ8Acmtt27z77i2+Yglkcrp8GdojbwmkOKQe7J1B?=
 =?iso-8859-1?Q?gLVu6Kv+mB+1YqN1gc708/Lr87JIdXNRnNjyE3lf9Kv5NW3i5qat2ZCdgI?=
 =?iso-8859-1?Q?fIxsipuINoEFeehjQ77TcmkYP8BgAOtWuCrC3UaDQFm0I+d3Id1jLK3yhS?=
 =?iso-8859-1?Q?8B+7qrjLj/f8JzIJ0AQafg2vo2ES34pv3jnVNrgtJIHzvjzZxbfcYhR59Q?=
 =?iso-8859-1?Q?nTmB8hCNGcYFV8T0UhwSYeGRePW9VoL8PUug+tIoLQZLepbBNtNzdJKslX?=
 =?iso-8859-1?Q?wG8yiNuy3ZLOOu155g29LOYA6JLe4VJV15MsMndHeB71Mio/VRllZFy/DK?=
 =?iso-8859-1?Q?fa0duCZp8ohrpnZdvfnYQ8XzxQIoMond3b5mvLfAxe1k155CpNfSme7BZV?=
 =?iso-8859-1?Q?jJ5apz6o5ucNwZoUN8fm89ZsXOvtuH3QnTt8Dkck6bhrJvzYyKV+BWplwv?=
 =?iso-8859-1?Q?Ou8N0Hhav/hWz8p40SvP1yOXzy3CnyQS1MfgCDNTq59ySh//05g8/lImja?=
 =?iso-8859-1?Q?AkF3zTjpGC1aSBBY44mut0oXNKlvzTqDWEHkqcWXxxVFD7IQHbsAkTWnAl?=
 =?iso-8859-1?Q?ZjlOqASJn0l1eA0GgZ7RdOLZw1SVhp8TTHXPmlKNAj25PGfzO46KO/n8uU?=
 =?iso-8859-1?Q?HVsoBHYYN8WIblrZYgADItJS8/x3nYiVHMIqpR9IdGOVxaTAmVyLtBfWHi?=
 =?iso-8859-1?Q?SaZi7qYWlLpPeM5Wi/TkZ7MY44WvETRXt4TQZ+QtWtfPg/k5WQjMzl7tRX?=
 =?iso-8859-1?Q?vh+LtOhIujtHLMQg8oshTGSMfmF8ctdj5JH/cS/m0DWkF5U9Nyz1MAIQfE?=
 =?iso-8859-1?Q?3RynVtakATsjzY/y9NTQbgrs5wL4OsK1mWBzX0WFWPA+47sGwNzG55XLUr?=
 =?iso-8859-1?Q?BfjxUhqk6DXdIEqlhI/fA/fbPiDa4JYfLAmSvDxODb3xKhD+vot3Mav/Ck?=
 =?iso-8859-1?Q?wJXBkxsWQfpjIhXgza/u1yPJMYy+FTivesVOethrQ4RgdUuzFAxKSpWSW7?=
 =?iso-8859-1?Q?5JOND0462CLRUstvSZ7ONGTnrgVX2yiZxZiFbAYGlKKbAHC4jhmzPleG3V?=
 =?iso-8859-1?Q?UB2qLwdn/hgJXTJbsOaEZ/T3eCbnZJJWA0pz7X+T79j7CUAxGn2Y7SLyG8?=
 =?iso-8859-1?Q?tOQgoJsGpqlFu+/Cotxv7DFAEipUlgc1UXA7BnsdiAtPc/HQM0GimCP9BX?=
 =?iso-8859-1?Q?FQcg8ezx/diOpamZ/3W4JX6CZRQDO5BoRkg1Qze2VSgcez3qc4lLCA8NsC?=
 =?iso-8859-1?Q?hcU/oRbFfJAgOFZxaORYCKYO9QK1KpieEN9Fomxi+3LuQ/X3ItJ39Gl46B?=
 =?iso-8859-1?Q?uQFJ4wCXjGyhGdIcYtv+XwAC8sS5oqGgWP6ljYFxfwpCYhllVT6MFimlTZ?=
 =?iso-8859-1?Q?B3Hbhjo2ku4Wa12NuDVpd4bGc5LeSHNaC4yYNfzy7X2a5FRv/fMfORHph/?=
 =?iso-8859-1?Q?KKisHw1kGkEDHb7Pz1DQn+/NDxnVuHGU1bwZJ7k9GiBseas7O0ORc/hEVt?=
 =?iso-8859-1?Q?HWKEvCVICsYrmwWNGbKaLURGmNYowhWlcEFhfhzVo6madiIGgGPwVcSbY6?=
 =?iso-8859-1?Q?D45M9BndBdrksSf7BhESXSwmVvPte2aC33zH9eT2cb8pfHnw26DN2sPA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ca1b52-520b-45b4-fedc-08dca2356a2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 05:42:27.7740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7RDMryD14FhrEbYhZg0GSNQeVmEFXoyyzcycpE/AyeYhRPoPlFnxujXiy9DSKx1AkdvrRlt1WzArbFy4A9Z5+z0k5T2iVKnm+vPlgoYDHHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7867
X-OriginatorOrg: intel.com

Hello Jiangshan,

Hope you are doing well. I am Chaitanya from the linux graphics team in Int=
el.

This mail is regarding a regression we are seeing in our CI runs[1] on linu=
x-next repository.

Since the version next-20240709 [2], we are seeing the following regression=
 during boot up.

```````````````````````````````````````````````````````````````````````````=
``````
<4>[    0.813758] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<4>[    0.813758] WARNING: possible recursive locking detected
<4>[    0.813758] 6.10.0-rc7-next-20240709-next-20240709-g82d01fe6ee52+ #1 =
Not tainted
<4>[    0.813758] --------------------------------------------
<4>[    0.813758] swapper/0/1 is trying to acquire lock:
<4>[    0.813758] ffffffff8264adb0 (cpu_hotplug_lock){++++}-{0:0}, at: allo=
c_workqueue+0x31a/0x820
<4>[    0.813758]=20
                  but task is already holding lock:
<4>[    0.813758] ffffffff8264adb0 (cpu_hotplug_lock){++++}-{0:0}, at: pada=
ta_alloc+0x56/0x140
<4>[    0.813758]=20
                  other info that might help us debug this:
<4>[    0.813758]  Possible unsafe locking scenario:

<4>[    0.813758]        CPU0
<4>[    0.813758]        ----
<4>[    0.813758]   lock(cpu_hotplug_lock);
<4>[    0.813758]   lock(cpu_hotplug_lock);
<4>[    0.813758]=20
                   *** DEADLOCK ***

<4>[    0.813758]  May be due to missing lock nesting notation

<4>[    0.813758] 1 lock held by swapper/0/1:
<4>[    0.813758]  #0: ffffffff8264adb0 (cpu_hotplug_lock){++++}-{0:0}, at:=
 padata_alloc+0x56/0x140
<4>[    0.813758]=20
                  stack backtrace:
<4>[    0.813758] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.10.0-r=
c7-next-20240709-next-20240709-g82d01fe6ee52+ #1
<4>[    0.813758] Hardware name: ASUS System Product Name/PRIME Z790-P WIFI=
, BIOS 0812 02/24/2023
<4>[    0.813758] Call Trace:
<4>[    0.813758]  <TASK>
<4>[    0.813758]  dump_stack_lvl+0x82/0xd0
<4>[    0.813758]  print_deadlock_bug+0x259/0x390
<4>[    0.813758]  __lock_acquire+0x733/0x1f60
<4>[    0.813758]  lock_acquire+0xd1/0x2f0
<4>[    0.813758]  ? alloc_workqueue+0x31a/0x820
<4>[    0.813758]  cpus_read_lock+0x3b/0xe0
<4>[    0.813758]  ? alloc_workqueue+0x31a/0x820
<4>[    0.813758]  alloc_workqueue+0x31a/0x820
<4>[    0.813758]  ? __pfx_pcrypt_init+0x10/0x10
<4>[    0.813758]  padata_alloc+0x6f/0x140
<4>[    0.813758]  pcrypt_init_padata+0x12/0x80
<4>[    0.813758]  ? __pfx_pcrypt_init+0x10/0x10
<4>[    0.813758]  pcrypt_init+0x3a/0xa0
<4>[    0.813758]  do_one_initcall+0x5c/0x2b0
<4>[    0.813758]  kernel_init_freeable+0x18e/0x340
<4>[    0.813758]  ? __pfx_kernel_init+0x10/0x10
<4>[    0.813758]  kernel_init+0x15/0x130
<4>[    0.813758]  ret_from_fork+0x2c/0x50
<4>[    0.813758]  ? __pfx_kernel_init+0x10/0x10
<4>[    0.813758]  ret_from_fork_asm+0x1a/0x30
<4>[    0.813758]  </TASK>
```````````````````````````````````````````````````````````````````````````=
``````
Details log can be found in [3].

After bisecting the tree, the following patch [4] seems to be the first "ba=
d"
commit

```````````````````````````````````````````````````````````````````````````=
``````````````````````````````
commit 1726a17135905e2d2773f18d47bd4e17dd26e1ed
Author: Lai Jiangshan mailto:jiangshan.ljs@antgroup.com
Date:=A0=A0 Thu Jul 4 11:49:13 2024 +0800

=A0=A0=A0 workqueue: Put PWQ allocation and WQ enlistment in the same lock =
C.S.
```````````````````````````````````````````````````````````````````````````=
``````````````````````````````

We could not revert the patch because of merge conflict but resetting to th=
e parent of the commit seems to fix the issue

Could you please check why the patch causes this regression and provide a f=
ix if necessary?

Thank you.

Regards

Chaitanya

[1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20240709=20
[3] https://gfx-ci.igk.intel.com/tree/linux-next/next-20240709/bat-rpls-4/b=
oot0.txt
[4] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20240709&id=3D1726a17135905e2d2773f18d47bd4e17dd26e1ed


