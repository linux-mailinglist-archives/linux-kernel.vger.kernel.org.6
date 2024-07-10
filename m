Return-Path: <linux-kernel+bounces-247053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6E992CA56
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0272FB23767
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C01750A80;
	Wed, 10 Jul 2024 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kKn1tlhi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD953A47
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720591390; cv=fail; b=fFWVzLL3PIq2dX8e3am6wxwSJugEqUef7GMZP3DGHmCvyF9G3d6VtP2CARzUOjK+9fb6qZXCtDrtztCWGcjtcsD8PGr/v0SMALcRLz6OY8vmiGQ4t/0Vec4Pb5ii1hRabuoFcjLrBBKgzQoyWtchEJvczEzUBcg1pFShCTovuDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720591390; c=relaxed/simple;
	bh=GDu3ZL2ozJZPbymFxoVV/ixJykrnfgQxccWApQi5gNQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VDoaOjmiQss3bFH9YtZYhqwINWgEhcaXoKcbDPV5S/567W/Yn37elzff459/nqWFYj7m4kt5nTmWmWfL+f4jfum57/uDpQscIC1f7rKkGGL7x9zXWGQBsJqA5jhhykh4pn/r35BUAQsMxF72XwQDrUzWe7H+3W6zZSW32snxtcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kKn1tlhi; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720591388; x=1752127388;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GDu3ZL2ozJZPbymFxoVV/ixJykrnfgQxccWApQi5gNQ=;
  b=kKn1tlhi9pbuXwnjqcxTRRsIKuwgDQqR3D9pGnsFhjPn/3QAhNsWdqen
   RVzLqzRiifRrwap/P5tuh4BlS9JPlpn3cvp9F9BPf+CaXgiIE+hrpvVxJ
   /BAMMLEwZaHL6LcfDqaaYqoNG/JCnwi63p49itE3btabvJkREXrUB8VRx
   k52mm0FSLA6Hbl8z1IFmt0nwnzCAZHoY6AgP4rNQijimsst8p4Viyvxlh
   PZtcOX5SF0xul78UQwmnEVD5cMrqqFxFzOXCoWbyx4zCflppjOWmV+AXt
   xrfgj3b3QGGQyg4j0U6s32XzoZy1ES/GwRjXwIVUcn6m2qNiKwHFXrhWd
   w==;
X-CSE-ConnectionGUID: h4Ljh89eT1Suau5UugLpRA==
X-CSE-MsgGUID: K1rcuAsITmOJNqU+h7qeAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17996695"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="17996695"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 23:03:07 -0700
X-CSE-ConnectionGUID: tFNCLrlWTxSKbx/tj24Ijg==
X-CSE-MsgGUID: vEW03CpJTuC84pF3zvbuLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48832658"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 23:03:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 23:03:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 23:03:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 23:03:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUUxbZp5PSzXCqObntwdSV5EwqLKbFCp2aQhKJDaYooVRxsD8NdOjxn3cbk0PdARJvKrGiupbPTY+gWn/BZUkxBzJVBU04KzL2VUrQhViGfi1G9c/Z1lsjcUiTwkzs8baOuHyUlLpbXYDZov73TyaC92dd5nawd0NHydee4AsEnJSCC7ZTFwHI99jRvjNw2SnOBtGvLz8LMBQqix3N919ViVFB5uG4q1h3I5F5ZKA/w8fg+j5HdARmAYozzyztQ32OXWJAKWN9VysPQI5Lh6ieGnpSq4NdeKKkOPndUsOPqaq0x4XL1kHW+5HhhdOOYcJsyNvn6VXGdakw06f8Awkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDu3ZL2ozJZPbymFxoVV/ixJykrnfgQxccWApQi5gNQ=;
 b=hq+23bV9H/2/g8VQq7tDVNUnfmE+Sir/LL3lHPkfPpbYIcHEdaAdN5JJhN/xv3cfF6AiA6RNAP8YtgWXAoZ31GqIkImNc1tMAaaEKa0SkyDKwOJA3es/JtRvmP0PydjqDfsFOs+JObldg+qeM5GyqVtxuHYKY0XHHs6fMFnIZKxJjDLYF40L2rkbwGLT/8iaGd7OyUJY7Qc1T1GSDWV//O6aXOUciUBwgRdgRVF99hV6Oief0s1KxUd69XDWhXjSy3hJ2Hiasm/tYqw9HhV+dhiGtM8TylUVPj6sXIFvgcaKq/SEXXRl/HAaYBdGU9mKQE1iT5FsKgG8HPdfBAPfDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 SJ0PR11MB8294.namprd11.prod.outlook.com (2603:10b6:a03:478::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 06:03:03 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 06:03:03 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: Atish Patra <atishp@atishpatra.org>, Conor Dooley <conor@kernel.org>
CC: Charlie Jenkins <charlie@rivosinc.com>, Alexandre Ghiti
	<alexghiti@rivosinc.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "anup@brainfault.org"
	<anup@brainfault.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers/perf: riscv: Remove redundant macro check
Thread-Topic: [PATCH] drivers/perf: riscv: Remove redundant macro check
Thread-Index: AQHa0S7tf8iBQCUbAkm0qrBXIBdGobHswIyAgAIaiwCAAAQTgIAAA8WAgAAB/4CAAArQgIAAh6Tg
Date: Wed, 10 Jul 2024 06:03:02 +0000
Message-ID: <DM8PR11MB5751FE5DCB6AF3EB6AAB6EEAB8A42@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240708121224.1148154-1-xiao.w.wang@intel.com>
 <20240708-wildcard-denim-12de7fae795b@spud> <Zo2dtuv0quQ7FwtK@ghost>
 <20240709-unengaged-handgrip-56a5c7b3e1d1@spud> <Zo2kSxsJkdkBdBEW@ghost>
 <20240709-fame-uptown-c936014cd66a@spud>
 <CAOnJCULo2gwLYCPdMppwhZekbuLh7FydjO7T1ZvJ0C8VG559YQ@mail.gmail.com>
In-Reply-To: <CAOnJCULo2gwLYCPdMppwhZekbuLh7FydjO7T1ZvJ0C8VG559YQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|SJ0PR11MB8294:EE_
x-ms-office365-filtering-correlation-id: 29360819-d064-40cc-5d2b-08dca0a5f593
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QnhONFpZblE4RXAxbXdyckF1NHNWTzRBd2ppZEQ0QjR3NmFJSy96Z0Y2blRh?=
 =?utf-8?B?akl2Tzd4RnczTlM1MmlQOUdpUkdRN0IrTGFJVEhLSklXclB4ZlhpQVZyWjg5?=
 =?utf-8?B?TDBXM3gxbDNoSm84dGpkTVZTM3NZeVoxekxOajFHMVdpVElEM2lDa0s0dU1K?=
 =?utf-8?B?SEp5QTMrTndCSmdPcC9pcjdnRlVlZG5vU3FNWEs2V0tDMU95MlV1T0I5aW5F?=
 =?utf-8?B?UnU5eHlUcnVRelppNGJ1OXcxdlY4d3FmS1F1emF6RlJZRTIxNHNkZDR2d3cv?=
 =?utf-8?B?eS8zT3BHQklTSHJoWUNkclFRTkFjOW5ycDBPTE4xcTdmTEo1ZjFVSnk1MFdw?=
 =?utf-8?B?UDF6eHk5NklpY256TTgvNUlsbWt6bXVobzZ2UDhEeTlnVGFQRjYreHRPanc2?=
 =?utf-8?B?NzZEY3dqYmJPd0QzaHhKNVppUE54TEw2TXVhZXB4SzdvaVJSc2tvKythdTkx?=
 =?utf-8?B?dVp0Ti9kNEVDN0w3UVZkdjIydk5La3dZb3M4NEJlbUticVlJTm9JbjhSMHFG?=
 =?utf-8?B?VGZSWElFdTdoT2V1RVA5RFA4Njc4WUYvSmRtNHRYc2s1ZUxva1pLanM5eTNt?=
 =?utf-8?B?WEo3WExybjlOTkF3djJwMVhXRlF2TUNsajZ3ME96OWR0NG05OE8zMER0ZzZt?=
 =?utf-8?B?MWRnWnJDNzlIY0NTY1BrcTdpaVJ4VVdSMUQ1NkdWbVRHSUdiV2JIait1SmdQ?=
 =?utf-8?B?SDN0dDNmUW1tOUNFclFNTzN1b2JvQVdDMmgveXFXMHlBdHVyWnNTV3NqZ2Jk?=
 =?utf-8?B?S3QzN2NrZXlLK0hGN2xsaDNrZ3cvT3hpeWkwVGd1S1pvSDhOQUUwTTNBOXhV?=
 =?utf-8?B?L0JZZm5kU1J2MlNLeXdMN2swblhVUU1BUFFtbHNsKzN4a0dqc0Z5OXFmaVlW?=
 =?utf-8?B?OXJoRGw4QUdya0pKcmhOczA4L1dkZEV2NUJOaUlJWkt5M3pybGVkcjBKM0Vq?=
 =?utf-8?B?VHAvUzVmTUdJbWZBTExVL2xQZU9QMGhOZzVkb1A0cHowanVyNWhTSEJONUJD?=
 =?utf-8?B?QS9RZ01oK3ZtRm12eXBaYm9yUWVLTzBYUjNxK0J4MElSRG5SV1QzeWNLcmlU?=
 =?utf-8?B?QmpuUE9LL2VTY2RHelllUlo4SURoZDc3RXYvTUl5QUREQThGNEd5VkszdmhD?=
 =?utf-8?B?elFsWW9BY0UvQlB0MmZIM1JxdmkrVG5abEdTVlBOdkJkUVZwM214akFWc0lB?=
 =?utf-8?B?WDJZYVU3L09GWjFQeUxxMjJCWnlELzhTWWdpTjEzSmRHN0ZHM2JuZjdhSlVK?=
 =?utf-8?B?K1MzcjRSUndKWGovWVFQcFRRdVNRV3pGOVJOQ3RaTkxyTjVITTBEOHBSYlFn?=
 =?utf-8?B?cE16cWQvQlhRVXJvVWlZRGZhTTBsdnA1dHN2SnBla1lwZXRrdk9xUU9STFA3?=
 =?utf-8?B?TTdXT1ZmVFNHUWFKNy91aWI3Rm9ReEhsZEFsWExVUzdPMjV2dWJEZjhidmRE?=
 =?utf-8?B?ZmlDS0VQTG5BbGtnNmU0ZDJtSnpzU0hxdk5URVhTZ294eW8xOVVtVWRrTnMr?=
 =?utf-8?B?a1NWNnovZk5sSUxtUGVwcEFwVjlpN2s0THBmby9lbFZWN2tvZ1BjY2xRYXAz?=
 =?utf-8?B?cDZrOXJiWG92T0ZPNTVHay84Ni9XNkFlZHZwdHNTTGMwSWY2VmQ1ZVFMUHZ1?=
 =?utf-8?B?eTEyTDRjd0FQMGM1VzRBNVlkR1FwMyt5bFh0SFBEdTFaYnhGdnA1Q1FHNlBj?=
 =?utf-8?B?YmdXVnlJSVczYW9MTExKMXdZZ3RsbGtpcWpXdE1wcEdCbzYzall5RFZVSmlZ?=
 =?utf-8?B?Vkd2ZHEzQzA2aW8xemMxNkdzVFNoUkVON3ByeXA0aG1vL1c1ckNJNUoxY3FO?=
 =?utf-8?Q?DgPK4V0xqhwVl/6zVNV+pbYS7+d95U3f70EZk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXRjeVF4THhzc3RkY0hURVJ1VlhTNEpvK28rYjFTYVRhVS9tNHhxUjhJNTgv?=
 =?utf-8?B?NldQT1dVY3pqRkNpZEl2RjZObmF0L0Z1NnppRVdmZnloa2NYdHFpaGxFZDZ3?=
 =?utf-8?B?T0UyRFVCbzNTOXVJNERZS2ZQZUFBMEZ0MENmUjFUM1A4TVZYa1l2Nk5pSE9Z?=
 =?utf-8?B?V1UycTFnK3VHRUFpY1F0aFhKb3lDaTZPNklQTDh1VmUraC9jWE41Y3dzMFJN?=
 =?utf-8?B?Y0tsYU5IT3NMUEppSWtpWjVZL1U2RWJPd3NFaFdkd3Y0SkljeDdyTDcrd1No?=
 =?utf-8?B?Qkc0bW9MUzFsZEU2MmxSUnE0RGdxVC9KcFYvMWZHY2ZMQjZtZUxvMDR3R3d6?=
 =?utf-8?B?S0dwTTZJZ2JFSjBTVlJ4UkxHanNReCtJUTdNa0psSDZhOFFlUmEvR2FCK1lE?=
 =?utf-8?B?c1dURzhpUWRsbXJmSjRvQVR3c2F0VmpvSHQ1Y2FCV292dmUrYnhVZnRZQ3ZJ?=
 =?utf-8?B?Uk4zV3NhMHlOaWtITDljKzc4dENHVXRaM2dVOUlGd1AyVnhvcmhEcmx2eEVa?=
 =?utf-8?B?SlZqSkxxcjBHTEhVZE5wQVVub3pqaTlLUDJmV2R2cm5VUUtrcXMrSW1qVTg2?=
 =?utf-8?B?M1kwOVZUWmpLUlN6L1VXSUtOZ1JlbWhqZUZBWmtQa28xS2ZHQzhLNFBYMmc3?=
 =?utf-8?B?bS9venVEcTIrVi8wcFJuTitaRmU2ckFTdkZ4d011UHgwdGtlQU43RVpiQlN1?=
 =?utf-8?B?UjE1NzN4OHh6MnRiMS9EM3JPUEJKUENSaWRwdUpkN28zT2VWM0xtYlV1SjIy?=
 =?utf-8?B?Ym1CYTc3SEVEZVNSdmhSdERPQWwrTU9TdE1adEVoUngwdERFNUVmTjRNRE00?=
 =?utf-8?B?dVc2UEpwbEo1ZDJIVjJSdXJaeUovMlExZjhCYlpYV2N4ZG5zUGI1RVBqbnhi?=
 =?utf-8?B?alIzN0VGUlV0U3Z4WTF6eHhLK0dKNWlvS1hDcVBWaEpBQmZGWlhkQkkxSEF1?=
 =?utf-8?B?R3FtWmZjVVB6dFNQQk51Ym5MWlE0eDJhZzQ0cEg3OGhRbHQzN1N4TElNZFlP?=
 =?utf-8?B?Rkh0WjlGSzZPU2ZUNVFzSlFrbml1V2tINXR2czFiY0lnOVBXaEFML0lrT000?=
 =?utf-8?B?aDVZeGkrM0Y1THVSRVY3ZE1UbU82K0IvRGdMT3VUKyttUGhkUEpLVkVoWk9R?=
 =?utf-8?B?ZzNNVmxtMm4yV0x2MXR5MGwzZDR6U2dyRU5IeXNSMlFyMldkWlNrZGxpUkZ3?=
 =?utf-8?B?bE9FdzB2eEhkWFllWnpJYUU0TC9JL1R3K05uZnBaVjdUSk9SWDJuR3B1WGhm?=
 =?utf-8?B?Q2JvKzhLVXo0NmdQM2ozSGQyU2MyV1RveFEyVUFzWDV3U3B2WGJrQTZkSTY4?=
 =?utf-8?B?djlSSGNueExCUUxaR21vTndzRDJuVW54RmtCZk1aOEdhY2NQeVBYV0FHMEc1?=
 =?utf-8?B?S2xSRlpXMkVQb2FOSHBSWkRqYnlhdTdnNTZZTHZFUkQvZzJseVNnWGp5YmFC?=
 =?utf-8?B?blJyRWxyNHVvcUtjbSt2SHhtTm9oUHRCelFNcXlnWTNleXNZWXpTbFJ4Ulky?=
 =?utf-8?B?RGFidHhaUy9aMmZGYkRoeUdoT2UvOHg4K2VQN3RaSWlyWXMwTjZML2sxTUNU?=
 =?utf-8?B?eTBIcW1Sakk5V0FKZXl3NUErUjc5cjF5c0EyK3o3UXkwSjczTTFQYmgvMzl2?=
 =?utf-8?B?MnFyVUwxZktYdDZmaVlWZ25MU3VkSkdMZ09rSVlHYndVbjRNTXRYUVBWb0N6?=
 =?utf-8?B?cjVDYW1Zb295TjhFRGc5dWdicnA3Wm5HZHA1NUhWY0d4UGJSbkhZNHp5UXRj?=
 =?utf-8?B?TWFqRkJlOVYxTXYwWStuUDN2QjV5NUVPa1gxMC9xaVpXTGdUZi9KdVlodGVL?=
 =?utf-8?B?bDIyZm05aUtWWGt0RUxkLzcrNmRLYWxPSDhSNjFuT05oeHpKR1Z6SjZCNDBC?=
 =?utf-8?B?d2RLdmpnRHdmb1RHbmRac01YUW9icWZDRlRhYzBZOVVpejZzQnc1MmZuZWtp?=
 =?utf-8?B?UERUYTVvelZwN0VuaU1iRjZFV1VVN0hxL2EyYk5mWk5JbFRFSGVzbVd5WStj?=
 =?utf-8?B?TENINTBYN09IK2I1Q0h4bHNHSXdiVUtkY29YZVZkZUdzSTVZVzB3cUF5V1pZ?=
 =?utf-8?B?K214N09MRXU3bzdjMTBLQUdyZmRYaTRmRW1vMmNmU05kYVJ4UHF5MnBLQUhR?=
 =?utf-8?Q?2ozDB48MWbV5CFybLvH4QiKk9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29360819-d064-40cc-5d2b-08dca0a5f593
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 06:03:02.9757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BnAuDaWEeNVwt1J2QNt+qQMY0gTeg1apJO8qOoToLmDtWcrl/BiFmSg6WmORLKEkAHco3kbEpN8PbDm2iX3AeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8294
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXRpc2ggUGF0cmEgPGF0
aXNocEBhdGlzaHBhdHJhLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDEwLCAyMDI0IDU6
NDQgQU0NCj4gVG86IENvbm9yIERvb2xleSA8Y29ub3JAa2VybmVsLm9yZz4NCj4gQ2M6IENoYXJs
aWUgSmVua2lucyA8Y2hhcmxpZUByaXZvc2luYy5jb20+OyBXYW5nLCBYaWFvIFcNCj4gPHhpYW8u
dy53YW5nQGludGVsLmNvbT47IEFsZXhhbmRyZSBHaGl0aSA8YWxleGdoaXRpQHJpdm9zaW5jLmNv
bT47DQo+IHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbTsgcGFsbWVyQGRhYmJlbHQuY29tOyBhb3VA
ZWVjcy5iZXJrZWxleS5lZHU7DQo+IGFudXBAYnJhaW5mYXVsdC5vcmc7IGxpbnV4LXJpc2N2QGxp
c3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGRyaXZlcnMvcGVyZjogcmlzY3Y6IFJlbW92ZSByZWR1bmRhbnQg
bWFjcm8gY2hlY2sNCj4gDQo+IE9uIFR1ZSwgSnVsIDksIDIwMjQgYXQgMjowNeKAr1BNIENvbm9y
IERvb2xleSA8Y29ub3JAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUdWUsIEp1bCAw
OSwgMjAyNCBhdCAwMTo1Nzo0N1BNIC0wNzAwLCBDaGFybGllIEplbmtpbnMgd3JvdGU6DQo+ID4g
PiBPbiBUdWUsIEp1bCAwOSwgMjAyNCBhdCAwOTo0NDoxN1BNICswMTAwLCBDb25vciBEb29sZXkg
d3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwgSnVsIDA5LCAyMDI0IGF0IDAxOjI5OjQyUE0gLTA3MDAs
IENoYXJsaWUgSmVua2lucyB3cm90ZToNCj4gPiA+ID4gPiBPbiBNb24sIEp1bCAwOCwgMjAyNCBh
dCAwMToyMjoxMVBNICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBN
b24sIEp1bCAwOCwgMjAyNCBhdCAwODoxMjoyNFBNICswODAwLCBYaWFvIFdhbmcgd3JvdGU6DQo+
ID4gPiA+ID4gPiA+IFRoZSBtYWNybyBDT05GSUdfUklTQ1ZfUE1VIG11c3QgaGF2ZSBiZWVuIGRl
ZmluZWQgd2hlbg0KPiByaXNjdl9wbXUuYyBnZXRzDQo+ID4gPiA+ID4gPiA+IGNvbXBpbGVkLCBz
byB0aGlzIHBhdGNoIHJlbW92ZXMgdGhlIHJlZHVuZGFudCBjaGVjay4NCj4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiBEaWQgeW91IGludmVzdGlnYXRlIHdoeSB0aGlzIGRlZmluZSB3YXMgYWRkZWQ/
IFdoeSBkbyB5b3UgdGhpbmsNCj4gdGhhdCBpdA0KPiA+ID4gPiA+ID4gaXMgcmVkdW5kYW50LCBy
YXRoZXIgdGhhbiBjaGVja2luZyB0aGUgaW5jb3JyZWN0IGNvbmZpZyBvcHRpb24/DQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiBUaGlzIGZpbGUgaXMgb25seSBjb21waWxlZCB3aXRoIENPTkZJR19SSVND
Vl9QTVU6DQo+ID4gPiA+DQo+ID4gPiA+IEkgbWlnaHQgYmUgaWxsLCBidXQgSSBjYW4gc3RpbGwg
cmVhZC4gSSB3YXMgbm90IGRpc2FncmVlaW5nIHdpdGggWGlhbw0KPiA+ID4gPiB0aGF0IHRoZSBj
b25kaXRpb24gaXMgcmVkdW5kYW50IGFzIHdyaXR0ZW4gLSBJIHdhbnQgdG8ga25vdyB3aGV0aGVy
IHRoZXkNCj4gPiA+ID4gbWFkZSBzdXJlIHRoYXQgdGhpcyBjaGVjayB3YXMgaW50ZW50aW9uYWxs
eSB1c2luZyBDT05GSUdfUklTQ1ZfUE1VIGluDQo+IHRoZQ0KPiA+ID4gPiBmaXJzdCBwbGFjZSwg
b3IgaWYgYW5vdGhlciBvcHRpb24gc2hvdWxkIGhhdmUgYmVlbiBoZXJlIGluc3RlYWQuDQo+ID4g
Pg0KPiA+ID4gTWFrZXMgc2Vuc2UhIExvb2tpbmcgdGhyb3VnaCB0aGUgbGlzdHMgSSBzZWUgdGhp
cyBSRkMgZnJvbSBBdGlzaCB3aGVyZQ0KPiA+ID4gaGUgaW50cm9kdWNlZCBhIGRpZmZlcmVudCBj
b25maWcgb3B0aW9uIGZvciB0aGlzDQo+ID4gPiAiQ09ORklHX1JJU0NWX1BNVV9DT01NT04iWzFd
LiBJIHdvbmRlciBpZiBzb21ldGhpbmcgZ290DQo+IGNvbmZ1c2VkIGluIHRoZQ0KPiA+ID4gZGV2
ZWxvcG1lbnQgb2YgdGhlc2UgdHdvIHBhdGNoZXMuDQo+ID4NCj4gDQo+IE5vcGUuIFRoYXQncyBu
b3QgcmVsYXRlZCBhcyB0aGUgYWJvdmUgc2VyaWVzIGlzIGEgY29tcGxldGUgcmV2YW1wIG9mDQo+
IFBNVSBpbmZyYXN0cnVjdHVyZQ0KPiBhbmQgZmFyIGZyb20gYmVpbmcgbWVyZ2VkLg0KPiANCj4g
PiBQZXJoYXBzLi4gV2hhdCBJIHdhcyB3b3JyaWVkIGFib3V0IHdhcyB0aGUgd3Jvbmcgb3B0aW9u
IGJlaW5nIGhlcmUNCj4gPiAobWF5YmUgdGhhdCBpdCBzaG91bGQgaGF2ZSBiZWVuIFJJU0NWX1BN
VV9TQkkgb3Igc2ltaWxhcikgYW5kIGRlcGVuZGluZw0KPiA+IG9uIGhvdyB0aGUga2VybmVsIGlz
IGNvbmZpZ3VyZWQsIHVzZXJzcGFjZSB3b3VsZCBnZXQgdGhlIHdyb25nIGluZm8NCj4gPiBoZXJl
LiBCdXQgbWF5YmUgaXQgaXMgaW5ub2N1b3VzIHlvdXIgdGhlb3J5IHdvdWxkIHN1Z2dlc3QsIGFu
ZCB0aGVyZSdzDQo+ID4gbm90aGluZyB0byB3b3JyeSBhYm91dC4gQnV0IHRoYXQncyBmb3Igc29t
ZW9uZSB3aXRoIGEgZnVuY3Rpb25pbmcgYnJhaW4NCj4gPiB0byBmaWd1cmUgb3V0IDspDQo+ID4N
Cj4gVGhpcyBtYWNybyBoYXMgYmVlbiB0aGVyZSBzaW5jZSB2MyBvZiB0aGUgb3JpZ2luYWwgc2Vy
aWVzLg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMwODAyMDgwMzI4LjEyMTM5
MDUtOC0NCj4gYWxleGdoaXRpQHJpdm9zaW5jLmNvbS8NCj4gDQo+IElkZWFsbHksIHRoaXMgc2hv
dWxkIGhhdmUgYmVlbiBSSVNDVl9QTVVfU0JJIGFzIGN0cl9nZXRfd2lkdGggd2FzIG5vdA0KPiBk
ZWZpbmVkIGVhcmxpZXIgZm9yIGxlZ2FjeS4NCj4gSG93ZXZlciwgdGhhdCB3YXMgZml4ZWQgaGVy
ZQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjQwMjI3MTcwMDAyLjE4ODY3MS0z
LQ0KPiB2YWRpbS5zaGFraXJvdkBzeW50YWNvcmUuY29tLw0KPiANCj4gU28gd2UgY2FuIHJlbW92
ZSB0aGUgbWFjcm8gY2hlY2sgaGVyZS4NCj4gDQo+IFJldmlld2VkLWJ5OiBBdGlzaCBQYXRyYSA8
YXRpc2hwQHJpdm9zaW5jLmNvbT4NCj4gDQoNClRoYW5rcyBmb3IgYWxsIHRoZSBjb21tZW50cyBm
cm9tIENvbm9yLCBDaGFybGllIGFuZCBBdGlzaC4NCkZyb20gdXNlcnNwYWNlIHBlcnNwZWN0aXZl
IChlLmcuIHRvb2xzL2xpYi9wZXJmL21tYXAuYyksIGlmIGNhcF91c2VyX3JkcG1jIGlzIGVuYWJs
ZWQsDQp0aGVuIHBtY193aWR0aCBzaG91bGQgYmUgc2V0LiBJdCdzIGluZGVwZW5kZW50IG9mIGFy
Y2ggYW5kIGNvbmZpZyBvcHRpb25zLg0KDQpCUnMsDQpYaWFvDQoNCj4gPiBDaGVlcnMsDQo+ID4g
Q29ub3IuDQo+ID4NCj4gPiA+DQo+ID4gPiBMaW5rOg0KPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC8yMDI0MDIxNzAwNTczOC4zNzQ0MTIxLTEyLQ0KPiBhdGlzaHBAcml2b3NpbmMu
Y29tLw0KPiA+ID4gWzFdDQo+ID4gPg0KPiA+ID4gPiA+ICMgZHJpdmVycy9wZXJmL01ha2VmaWxl
DQo+ID4gPiA+ID4gb2JqLSQoQ09ORklHX1JJU0NWX1BNVSkgKz0gcmlzY3ZfcG11Lm8NCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IFNvIGhhdmluZyB0aGlzIGNoZWNrIGRvZXMgc2VlbSByZWR1bmRhbnQu
IEkgYW0gY29weWluZyBBbGV4IGFzIGl0IGxvb2tzDQo+ID4gPiA+ID4gbGlrZSBoZSB3cm90ZSB0
aGlzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IFhpYW8gV2FuZyA8eGlhby53LndhbmdAaW50ZWwuY29tPg0KPiA+ID4gPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvcGVyZi9yaXNjdl9wbXUuYyB8IDIgLS0NCj4gPiA+ID4g
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wZXJmL3Jpc2N2X3BtdS5jIGIvZHJpdmVy
cy9wZXJmL3Jpc2N2X3BtdS5jDQo+ID4gPiA+ID4gPiA+IGluZGV4IDBhMDJlODVhODk1MS4uNzY0
NDE0N2Q1MGI0IDEwMDY0NA0KPiA+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3BlcmYvcmlzY3Zf
cG11LmMNCj4gPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9wZXJmL3Jpc2N2X3BtdS5jDQo+ID4g
PiA+ID4gPiA+IEBAIC0zOSw3ICszOSw2IEBAIHZvaWQgYXJjaF9wZXJmX3VwZGF0ZV91c2VycGFn
ZShzdHJ1Y3QNCj4gcGVyZl9ldmVudCAqZXZlbnQsDQo+ID4gPiA+ID4gPiA+ICAgICAgIHVzZXJw
Zy0+Y2FwX3VzZXJfdGltZV9zaG9ydCA9IDA7DQo+ID4gPiA+ID4gPiA+ICAgICAgIHVzZXJwZy0+
Y2FwX3VzZXJfcmRwbWMgPSByaXNjdl9wZXJmX3VzZXJfYWNjZXNzKGV2ZW50KTsNCj4gPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+ID4gLSNpZmRlZiBDT05GSUdfUklTQ1ZfUE1VDQo+ID4gPiA+ID4g
PiA+ICAgICAgIC8qDQo+ID4gPiA+ID4gPiA+ICAgICAgICAqIFRoZSBjb3VudGVycyBhcmUgNjQt
Yml0IGJ1dCB0aGUgcHJpdiBzcGVjIGRvZXNuJ3QgbWFuZGF0ZSBhbGwNCj4gdGhlDQo+ID4gPiA+
ID4gPiA+ICAgICAgICAqIGJpdHMgdG8gYmUgaW1wbGVtZW50ZWQ6IHRoYXQncyB3aHksIGNvdW50
ZXIgd2lkdGggY2FuIHZhcnkNCj4gYmFzZWQgb24NCj4gPiA+ID4gPiA+ID4gQEAgLTQ3LDcgKzQ2
LDYgQEAgdm9pZCBhcmNoX3BlcmZfdXBkYXRlX3VzZXJwYWdlKHN0cnVjdA0KPiBwZXJmX2V2ZW50
ICpldmVudCwNCj4gPiA+ID4gPiA+ID4gICAgICAgICovDQo+ID4gPiA+ID4gPiA+ICAgICAgIGlm
ICh1c2VycGctPmNhcF91c2VyX3JkcG1jKQ0KPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgIHVz
ZXJwZy0+cG1jX3dpZHRoID0gdG9fcmlzY3ZfcG11KGV2ZW50LT5wbXUpLQ0KPiA+Y3RyX2dldF93
aWR0aChldmVudC0+aHcuaWR4KSArIDE7DQo+ID4gPiA+ID4gPiA+IC0jZW5kaWYNCj4gPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+ID4gICAgICAgZG8gew0KPiA+ID4gPiA+ID4gPiAgICAgICAgICAg
ICAgIHJkID0gc2NoZWRfY2xvY2tfcmVhZF9iZWdpbigmc2VxKTsNCj4gPiA+ID4gPiA+ID4gLS0N
Cj4gPiA+ID4gPiA+ID4gMi4yNS4xDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQo+ID4gPiA+ID4gPiA+IGxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdA0KPiA+ID4gPiA+ID4gPiBs
aW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4gPiA+ID4gPiA+IGh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YNCj4gPiA+ID4gPg0K
PiA+ID4NCj4gPiA+DQo+IA0KPiANCj4gDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IEF0aXNoDQo=

