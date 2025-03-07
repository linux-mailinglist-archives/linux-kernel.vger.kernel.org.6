Return-Path: <linux-kernel+bounces-551481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 638E3A56CFF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1B61795D6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BB52206BA;
	Fri,  7 Mar 2025 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLCDB6kx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C732206BC;
	Fri,  7 Mar 2025 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363280; cv=fail; b=BMUyPo8qOO7iLDGEmy3xer7KUpFqzPvsdlFTrwFD0SltyD+bTBR47mww2RZHbfvYmNMHXIMaf8jAfkM2T8UxkrKQfvc61lF+4uFxvVU1JH+YrU5FQFTrGZt65AY7EItA5Cg4BE2aqZxrNolyWwymkviOPAVef5vykF+QVOinpU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363280; c=relaxed/simple;
	bh=ruayrNmtZKztt8WbrfimcRJyJbC8yZAV4qYt7j2hMaM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mko02S4osTeA6cO7OAM2jZoO+S6cuBgD1mZrmo+g7xg/sNRrXE6cGpb0scMO5NzdFvVmj/86je9F0fFMc4zo0Y+2cQuN82by3aQrd8e1FeNHY+IDNgHPE9NE8q5MzbN6zb5h1YrbaFE3PG5opw+tqmeaMa1JDlxzL7TJD2lxtEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLCDB6kx; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741363279; x=1772899279;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ruayrNmtZKztt8WbrfimcRJyJbC8yZAV4qYt7j2hMaM=;
  b=PLCDB6kxs44B8aUDitevOL8CM5J8E13QaFaDJ9ELvcJFuLBGMsUz4IDf
   N3wf9402HpCE9SzXHmdacxr0naeVSyrOpH1pXPH8ht1qUptEdyqdmGW3+
   cO5SSYugdUxvTnvRyySaWozofa18kmfLaZr1dxYRIf1J80gBHm3ZD6zjA
   7r4Ht3z3M3EC54WhwszsEJIhhPa7Qukz/t+OlDSxe6DEOYwsmNA5jP9in
   p20iLta53hjbw5YqvLLnVPA2zOqKxVQPt8DPHI0iXFnvUmVvNm5NPDUfi
   eZ6kddbkU2sjIwDcSagbV5miiSp6npo1ClUqDHxO3Erhc5ay7vUdGkdnt
   A==;
X-CSE-ConnectionGUID: m7vRthkSRiGbWnlovIPDfg==
X-CSE-MsgGUID: DIrpP7X0SHWC6QTRPE2JyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53809509"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="53809509"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 08:01:19 -0800
X-CSE-ConnectionGUID: PQfhswNUSACM3hSJABUg8Q==
X-CSE-MsgGUID: UABhP4/LRpSBVcAChyyneQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="119185290"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 08:01:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 08:01:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 08:01:17 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 08:01:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmY92aSFIAG/dskDDJgr77GYJ/Bo7FgrHTO4JnhV3FKm9zpmmIE+RZJpg/HyBGbp+S2Tpff6HVkx0vnliNDAcDIcU+5gjpbUv4X2W82seqd4PawxaZVk/U0gFgQa2pOofoMnCrL/RTgtUczC+NoleUWKDGp1UxQpdUCqC3GxBn6klH/1yLPEaacuDDXQXsoCoKACoMJuuSrQLfxfZ5SlXRO3iKjjLfcB1hg9U6OvGUq8nGOT97Whwh3JS+1A1HpW3RNJkJEP4kw0EFRl28ry8898MpdIP7zDRKnvelMFLDl0vRY+jkPwnvjPuNJmxpqmmCckpsm0aZYCC02lIXiK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruayrNmtZKztt8WbrfimcRJyJbC8yZAV4qYt7j2hMaM=;
 b=VTe+oirFjzuUBeyumXRmrDgf1PT6rpM57x2MQRs+XO/BJ9LlSajAKYuu+xmbZlqGU1HsrFEb6adJez5xKuHtDTVv5X2bQPkr9VXEjHyWUFtvnFahRc3TnVyQYY6cS6DJiXO0Qrqpani+QLzBmaQZz/tglYGQl95sP1/j1VOuvMbNr9p7mCnj8vaYdfVdS2cV2Vfor6+vBtoKgFbgFKIRAIgQcsR5xXsoul32GTFGx8OUENYOFTDdpuJFcgD2kOz74lSBXrh18RlPgC6skGeL9Jhg+JgAcInbNSUGBIw9LGhFJx4AdxzuTx1wxy0yz/aWON/iz4FAUzunJppMmiwxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 16:00:45 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 16:00:45 +0000
From: "Ng, Boon Khai" <boon.khai.ng@intel.com>
To: Johan Hovold <johan@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Ang, Tien
 Sung" <tien.sung.ang@intel.com>, Tien Sung Ang <tien.sung.ang@altera.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>
Subject: RE: [PATCH v1] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Topic: [PATCH v1] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Index: AQHbdhhxthJ4AiCvMUCJLGSIXsfkL7NkyIeAgADAZHCAAH99AIAADRTwgAHxN2A=
Date: Fri, 7 Mar 2025 16:00:45 +0000
Message-ID: <DM8PR11MB57512E7ED48836F275E5BFB3C1D52@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20250203084822.18356-1-boon.khai.ng@intel.com>
 <Z8hetcRinFXXVAdy@hovoldconsulting.com>
 <DM8PR11MB5751D2151A9FAC30E8647389C1CA2@DM8PR11MB5751.namprd11.prod.outlook.com>
 <Z8lrCnCie923f0-_@hovoldconsulting.com>
 <DM8PR11MB5751B5E8FAD650C31AE12410C1CA2@DM8PR11MB5751.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB5751B5E8FAD650C31AE12410C1CA2@DM8PR11MB5751.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|PH0PR11MB7636:EE_
x-ms-office365-filtering-correlation-id: 062f022a-ed78-4d8d-55d1-08dd5d91387a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?PwOHvx8RX5OkLONCnCyZov1EbZYHT+G5u6Bln/bF9aWv8weI3WUlEVxsUW19?=
 =?us-ascii?Q?9LPTzMhJ48C4UIl7/q7LEDQvd5s3vmUT0/4hzgCog/uUTaF+/On8NFzLFkkU?=
 =?us-ascii?Q?6IS1BGRNKsGrXL8NxVrSNh/5w2g5nyhA2xUXxK6BAj2sjLuRJ3ZppCTCXFep?=
 =?us-ascii?Q?4LwOVPUY5boLFDQNtyobkpcqZ4viUqPqB58oiLAOzFXtKUIxDRMNKF7Is4PG?=
 =?us-ascii?Q?loYRJbPpJDi/Lc2ojMiiiaZ3UFE9I332ZWb9VRuZp0UGdM+5hhupDp6qn0h5?=
 =?us-ascii?Q?4jn01uAQ1PJUwngn8gaVMJX3V7bFfNNc86p6ztzWMLp7LCPbLZwAkSaHyfsf?=
 =?us-ascii?Q?uWLqdO5Qrh23/sjldqxmQLhRsKOASVqQBr3TVWhct9OKzIsuwzqIPZRsgDji?=
 =?us-ascii?Q?9Ey+hYucr8tC3auvj59uGrnXhFPqhUsR8rbUzKR77DMM4k7Hknsroxuno3sg?=
 =?us-ascii?Q?CIH2p3g47B67POqSmY/Xhpob/AmDsz1o11gum8KN8msV8ufFb9lvb5rs/+ZU?=
 =?us-ascii?Q?bgAjLV1l3ngYrj2qhe32CXjzxN5OQS3VQ9qPwZbRlWHD9kkIvs5OLQdvzZNe?=
 =?us-ascii?Q?14thLq1MlOLlgDwCOtOE0oIj5COhsiFxrWdjda5iY38gd3U4tWO+//28i+09?=
 =?us-ascii?Q?B85XIscdbyq5lZcQr/m1jn7FXxXTh+OZrN91CuyIg5Gpox5Cm7DE1F9tOKyR?=
 =?us-ascii?Q?7CsICmJU8+Sj8uBFn3opjqpGYNl4mAhafIqi0EnJJPONpFKvZKd/lS53uDhN?=
 =?us-ascii?Q?lH0zLmTg/daVBLf/uJa30G8aOrVRmlOHHdNd4k7gtmg2jZxEuiUF2mbu+zxz?=
 =?us-ascii?Q?oaYjUaJYUhH9caaAL9G76IQoQxtRsJBHeYfpM8JnJDhZ4JwT3HFIRiOx6FLe?=
 =?us-ascii?Q?rvrYroco+fDhuC0mz01gaBEye56gHwnNEe/VaKjjwDe6mZNU6wgkkrWFbJ8e?=
 =?us-ascii?Q?8npYl0F0bvsmCt99+PEIJmRd9bv1zaUz6j1He9njPyCZTCOvJ0wps7RWPkij?=
 =?us-ascii?Q?Qe8TVOodrMmAu2MZFktO98mRiMi4P6xeXM1faDroKUcwZZoKHkg8F9Hd6Cir?=
 =?us-ascii?Q?pkrMe3Xb1xeG5citgyy23DCmO55oT7W4eKaJktr8X9KEagy5//dbA9+TL4sO?=
 =?us-ascii?Q?1m6FawmnjBf3SoTVpz7YP2hVbjT8Qe98BzjNrTsudKrePGkDcSdU7H4lBC9w?=
 =?us-ascii?Q?TWN8NItY3ukJ4YQ7QkPD7XFCvT+mPpOG9NLpvkxrkDIzZsD2n0vlWhq66p2S?=
 =?us-ascii?Q?uPGu7uN7MY+ptqTwiyVeEYOZTs0AzVvdzimypQS7UV8lzSXrG4b9Fz1wo567?=
 =?us-ascii?Q?GNGG0u2zcNbuPLEXjiouP9QaMhhK7crvdV1AP9IJxRgTqXzLVDrRz32tLQiP?=
 =?us-ascii?Q?UIebRZpS4f4Veuc7VpV6mJmtW30GC6Tcx729Uc4Gx42tbJR9fU8stfykWbHw?=
 =?us-ascii?Q?FC6fT/XJy4AUHBSb6zUlHIqUeFklpZ/z?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TdCrGVLjZPSaCY8hweXERS7fFml4FIwCFg2NLWFLVfwT6EKoomfKNjVQTiWL?=
 =?us-ascii?Q?O38Ze7DqXwuQw515AGAdgdigytiD06pR8fdd2nFF70yQEp9QgBnn1w28XND4?=
 =?us-ascii?Q?5aasfQoPBJrzL7ukt78YRidt5ojt0YMC8HRWZqiC+6Wp8wH4fJi0ZBKmZ0d9?=
 =?us-ascii?Q?HDoSMa+eP7zc86h8RJi8ar99WksFORiKlUigKgBn25d4uFp4YP2uW4qGCMuO?=
 =?us-ascii?Q?htLW9H3sSGsRwFzhjj8rSl2r9SRbgeLJsfYf3WX2E9NcTlHYLpNKLgebKk8C?=
 =?us-ascii?Q?N7vXBZsQvAyMviej01bzQKVFVxQ4kMPiySYISAYKTkV8ZCL1jZF+NO4fW24k?=
 =?us-ascii?Q?OViEasp4SFSJYifB1FUe9sdrL46lSVsol3cDzNjLyXCJTTCIQKD09kUzNtRg?=
 =?us-ascii?Q?RTA5tfZfnI30gprwjdeiKgo/27lsb0B9S0tE4ldFDi7HWn1nflU6IbKs+MpP?=
 =?us-ascii?Q?I5o0//wsl7OflBoL/iqXn/a/VqAUlkEaStpkZdk8KI1CWeS5NA1HzTFQSp+z?=
 =?us-ascii?Q?iL28kh//UN3FJpe/Bv49MAQZNxYAWFu5Uko9D6QZzEFG0SocVsWHSYdaaskj?=
 =?us-ascii?Q?JZvoQ9qGAHU3l9M88FkdvdrbnUZ74tKayB3sTXe7fmSdjVJSCPoXXS71aT+s?=
 =?us-ascii?Q?GlenMTpxg05/v6ImHUViVhqEXfJ/tlxdfYkBTgsb+4hpxg7NR/2eSZ370kt1?=
 =?us-ascii?Q?XRJmHoTzS5DVTwsk+99D2s5V7bAoNd3UjX67N//0dxQRM3M8RH5nSNqXqTf2?=
 =?us-ascii?Q?gSJ84rN/EJlMQBO3iTcDAKYyt3DF5Dz/9XhrdkpJDuQh+EegYxQJ/2CaRdlt?=
 =?us-ascii?Q?lFCzRbWrXObXIeP2idKW11xJd0LMpllMuecM4fZxySgcehqAKntujzuW2/zC?=
 =?us-ascii?Q?BLri06dDmXyKgSZBlqNYE1M2ZoACpbjD9/C3sp28/MgtK9Q6XCFkJISopJj1?=
 =?us-ascii?Q?xbYcmqrbSgU6hzZzhGetDfQ64IpV9jNFZ5+UwgRRKK3fWRV/X2h8dm4ZJrCx?=
 =?us-ascii?Q?poTN1qquxf5vD0o7g56CbENz/fXcg9+gvyHSe/52zxilNDs6P2KCahGGKQVc?=
 =?us-ascii?Q?WqE2C5Uz/rxkPOOqqtHHC9kXTzHoRUnm1+ynW2jehBg6gGQJNAt1gD114Mwf?=
 =?us-ascii?Q?3Yk58xt99mxxfcJ59oEy5E0uY9fcycpPUwr/wggm2l8HpoNvRB4Sr956LJhn?=
 =?us-ascii?Q?HJ6VbPJVv4UwSx/LeVh3p0BQmyF/ywsp6AcFhzsHbrO35o1D5QHNlHy1nXOh?=
 =?us-ascii?Q?tR1NQy4KL+AS9APzWt9nsG7UGcXnA9kwiYq4H79RU3w1H5RYUG0XxRhz/s6l?=
 =?us-ascii?Q?aBi0aL/OZhjbrQGWonrLB4aNVJ3JJECaBuBtUDqzTjB2qZ5zempoapysBrVa?=
 =?us-ascii?Q?lKQoVE3lW4YrGYXxF+xfpkxTrQMLdeXwJmY2IAGv+jZKKA3i9fir0SW7JkbQ?=
 =?us-ascii?Q?vpbvXdaZWRp6YtU/7UkL99cZy6X/vTeECECj2nXob9Woul4IABe0LUj4nT7B?=
 =?us-ascii?Q?uTlXMP2RJK6Meozpb6nUSh7r8ZQe54wn0WLrQ/yzfHjsyl2ZX9zzX/CbbfBc?=
 =?us-ascii?Q?sFuRmGMHAEgHZZqxzEdYCsrG/XWMAUdjzrNz/san?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062f022a-ed78-4d8d-55d1-08dd5d91387a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 16:00:45.5067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C0Vx67bSncH4XpVAF/BWDV6kc0YYmRwW+oNh+PfW9avwA3q+ofZyB/wyNU9+xg/gD/XwKKKXNnnMiKQgRov1gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7636
X-OriginatorOrg: intel.com

Hi All,

Thank you for the kind review and for your patience in going through the pa=
tch.
Really appreciate the feedback, and based on the comments I have submitted
a v2 patch at the link below with the necessary improvements. Let me know i=
f=20
if there is anything else I should refine.=20
=20
https://patchwork.kernel.org/project/linux-usb/patch/20250307154355.30772-1=
-boon.khai.ng@intel.com/

Regards,
Boon Khai.

