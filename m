Return-Path: <linux-kernel+bounces-400625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 068239C102E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0476282F48
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B35C218D64;
	Thu,  7 Nov 2024 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wuz14k3w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180D2194C92
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013112; cv=fail; b=g+ukbuoli57ahGouu4mHwhrJprowsnwj6Aly4Uy70vrh4shH4sWRezn2Z8zwuP9ftnHKgY2SeYumClcT1wJ4gqXcMX06mf8utbJKAUbBwiaSIMDxELOxVOdtMZr5K1Jn2N15KrhW+Oa3+7mf+BL3pdKbx7r4/S4wfiH1HNuyBBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013112; c=relaxed/simple;
	bh=A83978vcUKzqnmEZRLmfWAVqoUNCTwVfYDp09shr4fQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S62TbzDrKgq7YVOXBdY5+EiMvOrcMZ2kjqWCvFht2Ks+5yGKL/Tk9sdaKCO0Q0GY3WeCW8S2zKbL9iCmsIVIc9dL5zIhRnhAgW0sVP/AU9vA14WAmGZ7C8urSAALVw4KtrFNl5ZpQJR+AcyUR9dBV1N0ZU3tShuJ8l0SG68GZc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wuz14k3w; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731013111; x=1762549111;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A83978vcUKzqnmEZRLmfWAVqoUNCTwVfYDp09shr4fQ=;
  b=Wuz14k3wUZC13kaUSUqGnJsgwWUslJT8ZWKqTITMUqE5LZfEp2pf3DFR
   F/tizTNRiAIXkYLp2okf6y5cHweo7JkmBvvT61iigtxWrSvgkGii3Grn7
   doq4B2uTF8Rl63oSGS94vkJcou62eI4B8nkccRclTasYiNH32QBRwJTL+
   IDPI0aCDWTGVoyXwgfAFJp9ipPQGo0OTjKEgCqouVlS7+AYXOSyEfaG4D
   obXqMSoQHXT5Ms337zWYMs2XIEEkHO8CORhoGB2RqnKfKbESZXqTfMFCI
   GkxIogdC7TE5jdtou6XP1HiButndKu6wVzhlNHEse7rZtzEQDX5Cu9OKc
   w==;
X-CSE-ConnectionGUID: pE7sJ0eoQ965iS1OaL4hFA==
X-CSE-MsgGUID: OSd6D7AnRUidPCJjGYLTyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34572781"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34572781"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:58:30 -0800
X-CSE-ConnectionGUID: XjHlyFZPRVqtC8hZdxiDSQ==
X-CSE-MsgGUID: b+ngHDCkTu2PmQ16GZkHfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="86031364"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 12:58:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 12:58:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 12:58:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 12:58:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIFsvFQ7tLpNceWLAl/Xop8o3OSiTkgfpOQDlXCJbX9L9Wv7NGM41mNbZnfSdQCBf0Mvz4BmjaaEE9C/W71FKJbeqSaUiaymAgY0qehq03jEmbzgJi4kPsAW7xGspaizReLc4Tsq63RReOJoB+SjZI8tmO3KQoO0iSmgi+2B4NeYnybp2o8HoFid22uXGHCsXwQQ6+EofnxcLUToVe7l4cBFvdlxtrrUuuNkIGts/dGum7RZ70jpAjw8vHmnFFtLGJffZSDi3sjYIZhZbwoq6fK/3V9BmMcoHbUeLJOtlqx8VZ91j6g8KCmzm8O4olURGQ4fMMoNKOfE9An5gngyew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A83978vcUKzqnmEZRLmfWAVqoUNCTwVfYDp09shr4fQ=;
 b=d2lFRQEF+EGMF114vT0TOnr1KKD6QFQrMJn3JDy/S95p+JqQADZaZGyeVOTDAkR+2Vp0TEf6dX1Nuvmmj2FgPLcTzPDfvfCRL83B9D0vLhmV2FtXomOojRxaSpqpz7NYAjCeIp6KRnDbaPh3lwbDn/w9XbIMWV8+noaPVMD5OeLLaGoxmq7K8X4uIWjjseMEDEG1cWQs3gdsZwPfv8HRz1x9KJ+pN7pEm4XRD+Q9dtJ1qeeYVAs5OsfLPSoVy88uxc/w7T8lNlu8vMTpEnisuEsRYEeRxKyY3wWG5W5o+MWhlc9iNuOkEkBSQOJ82zS4l5GjJDbNafh3pS5iKhdLkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6076.namprd11.prod.outlook.com (2603:10b6:208:3d4::11)
 by SN7PR11MB7708.namprd11.prod.outlook.com (2603:10b6:806:352::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 20:58:20 +0000
Received: from IA1PR11MB6076.namprd11.prod.outlook.com
 ([fe80::c5b9:d906:229:31e9]) by IA1PR11MB6076.namprd11.prod.outlook.com
 ([fe80::c5b9:d906:229:31e9%3]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 20:58:20 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, Peter Newman
	<peternewman@google.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, "babu.moger@amd.com"
	<babu.moger@amd.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Eranian,
 Stephane" <eranian@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"nert.pinx@gmail.com" <nert.pinx@gmail.com>, "tan.shaopeng@fujitsu.com"
	<tan.shaopeng@fujitsu.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 2/2] x86/resctrl: Don't workqueue local event counter
 reads
Thread-Topic: [PATCH v2 2/2] x86/resctrl: Don't workqueue local event counter
 reads
Thread-Index: AQHbMGKkDArILeDR9kmWcus3jnj4urKrAt0AgAClQQCAADkYgIAAUM1rgAAapWA=
Date: Thu, 7 Nov 2024 20:58:20 +0000
Message-ID: <IA1PR11MB6076F9F222A98125974C5CBCFC5C2@IA1PR11MB6076.namprd11.prod.outlook.com>
References: <20241106154306.2721688-1-peternewman@google.com>
 <20241106154306.2721688-2-peternewman@google.com>
 <f6b7dd9c-5ace-4816-842f-ac1265c0f9ee@intel.com>
 <CALPaoCioRrjwZPYDdkAApHAecqZVA_Z4rLctjmcpEaV04eq9Ag@mail.gmail.com>
 <CALPaoCgwCwUJHF7fCQrf98kFVdCjPyUTUiCOfYOi3XHJzvqiMw@mail.gmail.com>
 <ZyzxbhHQptbktfGH@agluck-desk3>
 <034d8377-6276-417a-983b-1af4617d60ca@intel.com>
In-Reply-To: <034d8377-6276-417a-983b-1af4617d60ca@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6076:EE_|SN7PR11MB7708:EE_
x-ms-office365-filtering-correlation-id: cb60d684-22a8-4e7b-5f19-08dcff6ee93e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZVpVYjVCVURCazlMV0RCV1IyV0ZiSngyOHNqM0FXczFSTnpOY2JLQVh3TElN?=
 =?utf-8?B?UU9ycWRqUHZlOEFoNVhreGR4d1ZSai81U1dQVVhXVmt3Yi9VOXk5cHBkRXk1?=
 =?utf-8?B?K0d2dXYrUmJzSGIxNk1lTlE5Vm9TSG9TdVh2aGVJZDArZjcwSXlqV1Y0Mmkz?=
 =?utf-8?B?eWpLaWJYbTlPbkpDemNHUHVJRjQwZnZJTnB3eFFCMGgrbW1BWFFod2ovQ01Q?=
 =?utf-8?B?ZWEyeGV6amJaZlFLU1dTYXc5YzJqY09RK01uWjVURjBaUVR5c1J1emJtckZU?=
 =?utf-8?B?eVV5ai80R2pLQ0V4WGFvQXBZYXNUQU1UVWcwQXd5Y0N5SFZrS2pRNFZ0bG81?=
 =?utf-8?B?ZDRpVkY1YkJPbUYxMjE1eVJYcDNZQ3p4c1UwS2RjSXN6N2dyZ1IxT0dDTXNr?=
 =?utf-8?B?b1pWREFzZnJ4SFZ4d01pUFZNdHBzVklSL3p6Um9QSE9Nbm9BVUpEa1dEZ2JL?=
 =?utf-8?B?cE14SkNJQWtxMyswc28xTkZHbnJ5OE15enNNbEpKWVZPTHo3eWhCMmVlMWo1?=
 =?utf-8?B?WGNaaUhBSHRVTFVwejR5aTlBMVJ6TFFRdlpmdkhzSCt5cGlTYi90eTZqSGh5?=
 =?utf-8?B?K1FsK2ZONGV4ZGxqc0ZwU1FlYUdjazVjNFRyckJVUzlHY213SWlQb2w0UDZU?=
 =?utf-8?B?c212b1p6WUJBd3dsMnZkUTRYUm1xcmo0aUZYYyszOFpLZjB3bHdhZExtU0Fh?=
 =?utf-8?B?V3Z4VEVzL0pFOGw4aTBxZW1iUTdGZnFJQ2kvZ2hZcHhFMlhlWmZXd1pVem9v?=
 =?utf-8?B?ZnlrTWF2eGFzNjhCU0JTcmswanpwNUowWVNObWxkVWpoSVBmclltQ3dZamtu?=
 =?utf-8?B?S25jV1JadEc0M0tLYXJEMzVTNTdFaVNLOGx6UmtxREFKS3ZWNDMxR2hKT09E?=
 =?utf-8?B?U0tHZCs5ZkRYazlCQzFUOTRyeW9kKy9saTFmWWVQbDZSd25PVDVyUHVYa1Bx?=
 =?utf-8?B?Yk9iTzByK1ZlbUU1QW5JTTFublZ5VE5Iek83SVZnVmtQVDFuUTZIOWpIcVFS?=
 =?utf-8?B?UkVyUGlxdDVSVU1qbHdFYjkxUklpL3JZam93U29oREFvbEZjekM4eFdzU0ZJ?=
 =?utf-8?B?NFk5VUczZ3RINFQzRHpmT0xsUHJGQVFleTgvMU9MZ2tZSjhHaUlydVJzTlpX?=
 =?utf-8?B?Z0hSdXB0aVUzbDR2RVRpSURwdWNwc0preEgyN0xpSnVRUEZQOVhTYTdOcGFO?=
 =?utf-8?B?R3M1V0IxdWhLcm94Qk42MW84RkJ6MkF4NmNLeEZxQlA0TXFEWUZvVjVHYmtq?=
 =?utf-8?B?RHZ4VzhJcTc2aXYxRkVISEQ2cHVWRFJIWHJwV01tMFF6MVJMNDZIT2Fnc01F?=
 =?utf-8?B?a1pJd3NiSktoNUFKRHp3YlpnVVNBUEkrTlVkTkliamszTWFNQUt5WGh5REtl?=
 =?utf-8?B?ZlVNV3NzM0ZFc1U2dENTS21IOUZrSEhFeFc2SDJ5N2l6dzBFeGx4d21xN3N2?=
 =?utf-8?B?Y2piSlh5TEI1T0MvejZqUlkxbTRMOXpRSnZWdFBiMUkwQU5LQ0h0N1piSFRh?=
 =?utf-8?B?aTg4ZENZUlpKSTh2aTZLYXhRdncwV1F6anNmb2kxemRrc2FlUUw4ZXZoWVY1?=
 =?utf-8?B?cEpiekE2WW1NYUJyaEFrZm1uOGpMVnpvSHdGTi9sTVIrcnh6aTJvV3duaTBl?=
 =?utf-8?B?OGlVMm53KzlBRS8vUEFzandvNjlTM0pZUkpyVXVZWC9ndnRCUG1nQkNhdHBh?=
 =?utf-8?B?MWlLRjF5a1NSeHJyWUxsNkR1YUwxZjNKdFEyR2pvYm02L3l4ejNDY2kzRThR?=
 =?utf-8?B?OXIyQ0VoUlBlZG9NRDNaQXN2ZUdhamZWOWZTNGQzUXljRHpEd1dEbkFtODRo?=
 =?utf-8?Q?Hgo2SzDOeZQoRVZmA/PKlGyShPw3C2DB277m0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6076.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1N6MHprcFJLNG9WTnRaREtXRERxTXVnc0h5aUxHUm9QNkc1VVUzSmhHRGMr?=
 =?utf-8?B?emVXRVp5MjJoRzBpY1FjMjdPMnNmL0s4TzJlYk9NUFBkazRNWUhYY1MyZ3JM?=
 =?utf-8?B?cEJWQ1pUUEVJQ21GTjZIdDhnL0VVUVZtQVloa3hUWlhDcXBIcGIvTWp4Q2Z6?=
 =?utf-8?B?Lzc1Zk9NeGFvQ3hIZXhSRXVTQXJRcUYwOUNvb1cyN3BBajJGVDNZKzVmZmQx?=
 =?utf-8?B?Qkg4T04vSk9HbzgrR1VEdFF4RzZjU0pnaVV2a0ZuY0xObHF4Z3Z2c3JCbWo3?=
 =?utf-8?B?emQwVm5pS01PdGpKckFGbWJJMDBMNmlVNGZ3VGJuTFRCTmRrclhjOUlqM3Z1?=
 =?utf-8?B?SERuRUwzalc0MXVYclMza0xlZmxzKzRSNEJveVdoeWpWcEwwRWw1dlVRcGdp?=
 =?utf-8?B?UHg2YmVyY2E5TTFzSGlmTU1UbTkvOXBOaDVlaEw4MHIwU0t3dzZHaXZNWkw5?=
 =?utf-8?B?b3dSMFZLcElzMTh2eGFoUGJBd0UxWUhKTlk5ZWI2OTc5R2lteEovYk91cUVu?=
 =?utf-8?B?U09oOU54RUhvSWxpQU53UVZpTElXQ0FTNW5RY3V1RDZjRk1FWEM5WGlCZXo0?=
 =?utf-8?B?T3NlQnZXcjZlM29lUUJOcTVZMXVEM2xGbHFtM1ZNeW9QblJpamlVTEpPdW4v?=
 =?utf-8?B?aWpFVHNNcUZvWVMrVUVnc1UyUmVTK1RVZnROMk8vSWxzM09jMlFNRTZNb0tr?=
 =?utf-8?B?ZngwNEdQREhMU3Y1MGNVOEZTTXRKbkFHYjNzTDhhRzc0YXB6Vnhaei9PS0s2?=
 =?utf-8?B?Rzhmd0d0TlRIZktiVlhvOGNoNXh6TG9mVUhKV2R1UkFnV2dXaTVlazViTFhi?=
 =?utf-8?B?TGxXZFMweklVTnorZTRENnNhNXRBSk5IWVFHcUZZd2N4MzdzUGJDYkphYWhv?=
 =?utf-8?B?M3gvTHp5QmkxVzZZU3hDbDlUMVBLSXNONEJDVEZFNnZTUTRQOW1RRUo2OWNz?=
 =?utf-8?B?VU9oaVRlb003RkdyY3BmWURKMzRqVXhFVzBHcy9PVFIwOCszWVd0MjNtWXFO?=
 =?utf-8?B?cUVvNGpXYTBjZnFZV0tvTEQyZDRXYXgyOUJwZkFSV1dmN2hWQTduWjN3V3Vs?=
 =?utf-8?B?WUViMWFBTTY1b0RkUUtQSmlVU0FWcm96WFNXSDFpUUROUzkyQzJGVkNndTQz?=
 =?utf-8?B?NmF2SHVyMXJRVUlpV2ZzWlF2MjJuc1RFZk1lWWxwb1JKODdSdCttY01LSmZ1?=
 =?utf-8?B?Y054RHBmTDlWSHJJNU44b2VORUYvbUhkNXNXYkJXLzhXcEtybXIrSDRTUVZo?=
 =?utf-8?B?UFRzUS9PNGRXQUFkVlBMdkVkdnR2Z0pyQVQ4bVNFWFg1bThtREowaTB1MG12?=
 =?utf-8?B?b0IrdjBOM2pSVG9pNUd0di9zbU5PQWpsWVFUS2ZEbTZJWkVpb1N4K0cxQmFv?=
 =?utf-8?B?UEZFdm9MdTY0Y3QxekxZaUMycDE0WXcyYjJPZUxKZnF1QWJCUE9oQzZySW1u?=
 =?utf-8?B?cXRKVGR4cmphNzc2c3pCR1N2SlRSdlVlNlBtU2IzV2FwdVBTOStQVXZYWXVX?=
 =?utf-8?B?QlFHSXFiUHJvWnB4cW1OOFo0czJ5cEM3azMwNE1vZkZHeGtWL0d1N29EK1dt?=
 =?utf-8?B?SEpBNGdtOXQ2WGcwZ0tEZUJ2b3dYQ25EbXc2OS9qNVlQQUZlVUEzVFRxZ1k4?=
 =?utf-8?B?My83d05aOTNLNi9aMlJlYld2L3dTSDFiaUUxUkVXTU9uSVphL0luMFRjd0xa?=
 =?utf-8?B?QkZWckNjbkVuZDFYN0xjeGFER0VCc3A1Rk8xM2ZDcDBHZmFUU1F6UXkwdExl?=
 =?utf-8?B?enZRWWV5ejFMd25IdU45ajNSRk14TFFzSUdrQ0xtSTd3QWE1SDVZUVlsYXdk?=
 =?utf-8?B?d3ZyY2k4bi8vRWlSb3VOeUZMZi9HbmdWL2ZPVDJGcGVVUUVTOHNRblU4WXBR?=
 =?utf-8?B?YU5XY3dRR1FpVHgvaEJ0bjg5eWlDaHpmU2tuRDFYQVZGWDc0dmdzZ0lOOWwr?=
 =?utf-8?B?S2xGeTVUUFR5R0Nia2E5QzBPTFJ4VzBmc2djS3lRalhDVSs4azFNdXpOYkxJ?=
 =?utf-8?B?MnZFd3JMTS9QY0JacjFXZ2c2VEhVdDhSSXFHdEtyOWthWEtVdy9GQnhFOVh0?=
 =?utf-8?B?MFZjQXU5Tk5MdGRGWmJ2ZnV6SDJWZGg5MEluQzA3TnBFc2pvU3h1YWgyNEZC?=
 =?utf-8?Q?R5Z+OJxTVVzRfEZhwJsuYpEgv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6076.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb60d684-22a8-4e7b-5f19-08dcff6ee93e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 20:58:20.4320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2fvaynvVo1wA0pzzXoS3vaSDm9+dov70cXKlLnAZ6Y7voCwPUxdl+vBzhxRcWa7VARHrpUmF78TAT9XAkdfEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7708
X-OriginatorOrg: intel.com

PiA+ICMgY2F0IC9zeXMvZnMvcmVzY3RybC9pbmZvL0wzX01PTi9tYm1fc25hcHNob3QvbWJtX3Rv
dGFsX2J5dGVzXzAxDQo+ID4gPHJkdGdyb3VwIG5hbWVBPiA8TUJNIHRvdGFsIGNvdW50PiA8dGlt
ZXN0YW1wPiA8Z2VuZXJhdGlvbj4NCj4gPiA8cmR0Z3JvdXAgbmFtZUI+IDxNQk0gdG90YWwgY291
bnQ+IDx0aW1lc3RhbXA+IDxnZW5lcmF0aW9uPg0KPiA+IC4uLg0KPiA+DQo+ID4gV2hlcmUgPHRp
bWVzdGFtcD4gdHJhY2tzIHdoZW4gdGhpcyBzYW1wbGUgd2FzIGNhcHR1cmVkLiBBbmQNCj4gPiA8
Z2VuZXJhdGlvbj4gaXMgYW4gaW50ZWdlciB0aGF0IGlzIGluY3JlbWVudGVkIHdoZW4gZGF0YQ0K
PiA+IGZvciB0aGlzIGV2ZW50IGlzIGxvc3QgKGUuZy4gZHVlIHRvIEFCTUMgY291bnRlciByZS1h
c3NpZ25tZW50KS4NCg0KTWFpbnRhaW5pbmcgc2VwYXJhdGUgdGltZXN0YW1wcyBmb3IgZWFjaCBn
cm91cCBtYXkgYmUgb3ZlcmtpbGwuDQpUaGUgb3ZlcmZsb3cgZnVuY3Rpb24gd2Fsa3MgdGhyb3Vn
aCB0aGVtIGFsbCBxdWl0ZSByYXBpZGx5LiBPbg0KSW50ZWwgSWNlbGFrZSB3aXRoIDEwMCBncm91
cHMgdGhlcmUgaXMgb25seSBhIDY3MCB1c2VjIGRlbHRhDQpiZXR3ZWVuIHRoZSBmaXJzdCBhbmQg
bGFzdC4NCg0KPiBJdCBpcyBub3Qgb2J2aW91cyB0byBtZSBob3cgcmVzY3RybCBjYW4gcHJvdmlk
ZSBhIHJlbGlhYmxlDQo+ICJnZW5lcmF0aW9uIiB2YWx1ZS4NCg0KS2VlcCBhIGdlbmVyYXRpb24g
Y291bnQgZm9yIGVhY2ggZXZlbnQgaW4gZWFjaCBncm91cC4gSW5jcmVtZW50DQp0aGUgY291bnQg
d2hlbiB0YWtpbmcgdGhlIGgvdyBjb3VudGVyIGF3YXkuDQoNCj4gPiBUaGVuIGEgbW9uaXRvciBh
cHBsaWNhdGlvbiBjYW4gY29tcHV0ZSBiYW5kd2lkdGggZm9yIGVhY2gNCj4gPiBncm91cCBieSBw
ZXJpb2RpYyBzYW1wbGluZyBhbmQgZm9yIGVhY2ggZ3JvdXA6DQo+ID4NCj4gPiAgICAgaWYgKHRo
aXNnZW5lcmF0aW9uID09IGxhc3RnZW5lcmF0aW9uKSB7DQo+ID4gICAgICAgICAgICAgYncgPSAo
dGhpc2NvdW50IC0gbGFzdGNvdW50KSAvICh0aGlzdGltZXN0YW5wIC0gbGFzdHRpbWVzdGFtcCk7
DQo+DQo+IElmIHVzZXIgc3BhY2UgbmVlZHMgdmlzaWJpbGl0eSBpbnRvIHRoZXNlIGludGVybmFs
cyB0aGVuIHdlIGNvdWxkIGFsc28NCj4gY29uc2lkZXIgYWRkaW5nIGEgdHJhY2UgZXZlbnQgdGhh
dCBsb2dzIHRoZSB0aW1lc3RhbXBlZCBkYXRhIHJpZ2h0IHdoZW4gaXQNCj4gaXMgcXVlcmllZCBi
eSB0aGUgb3ZlcmZsb3cgaGFuZGxlci4NCg0KVGhhdCB3b3VsZCBwcm92aWRlIGFjY3VyYXRlIGRh
dGEgYXQgbG93IG92ZXJoZWFkLCBhc3N1bWluZyB0aGF0DQp0aGUgdXNlciB3YW50cyBiYW5kd2lk
dGggZGF0YSBldmVyeSBzZWNvbmQuIElmIHRoZXkgb25seSBuZWVkDQpkYXRhIG92ZXIgbG9uZ2Vy
IHRpbWUgaW50ZXJ2YWxzIGFsbCB0aGUgZXh0cmEgdHJhY2UgZXZlbnRzIGFyZW4ndA0KbmVlZGVk
Lg0KDQotVG9ueQ0K

