Return-Path: <linux-kernel+bounces-428569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C47C9E10B3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D803D281BC0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26322225A8;
	Tue,  3 Dec 2024 01:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFdHpRcK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863FA2500D9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 01:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733188552; cv=fail; b=fzTM2EZSC/CSDVAh0OrrzJMLFoV63EmnnQoxCrL6dkbD73GXPbztCKskJUUCyHxeisrcYo6nZYZJADjFwFo3lb8vaz1dpA92lq1c1gSBgs35EQgXdRCECFiasR2LsvnN0Y8tpfsTZ9j7bTtVdkZsNY03h/hkusC+uLO3TAvewBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733188552; c=relaxed/simple;
	bh=75umgxFmiliVYK9meJyCO5em8JTsnJJi1sdNSfq+Bj8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=byernbpbthMq+GM5PH2+IPEKXmRBJgrQM3+llFFmKxrpotHKvkwRIDlFGQWRbeem5XyXQQvaBA4s1PLriTG3QxdkFiOQjZm445pS3LgrA1ijfoISqzGbzAo5typxisNZOc9FljnHtRB//sqg8e0c33mr97hQAggI3wJXl2AOi1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFdHpRcK; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733188551; x=1764724551;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=75umgxFmiliVYK9meJyCO5em8JTsnJJi1sdNSfq+Bj8=;
  b=NFdHpRcKrxgZ/kzmEePaYNSr33ibdSc9YmkyVGzp8PcrXGvugddKj8kU
   Qj30xsKmyLiKZnDlQB7gW26MZmt1wJt6Rj60UDTnDnpMmJGFeJXmv6ag4
   PAW0y8vcD+Lm7jvtXfZbZIx0Jp+6KBvnRmye+AXAdWCs3ijP9dAbkaLLB
   SSN6w7Hkjq/xtdekmX/UJINmhP86i7sPYntEyzJvdehY0hVXLQClwHC/j
   lebQxrC7WHL+L0eyww97UbU6Ue4vqtaIDxiEIOvcK4xQQHRtBADU1gLRT
   jj6W8G9vUDaTHFBzGImQtcGN03Lw7ywHngyJ5kVVAuzHnVR09OQmPoCOg
   Q==;
X-CSE-ConnectionGUID: CpYHomVNRbmhiilXKhYh8g==
X-CSE-MsgGUID: D9Yd6y8zRWiDUBPio5iKAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44769079"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="44769079"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 17:15:50 -0800
X-CSE-ConnectionGUID: pe6lptv1ShSMqFHv9b0l0w==
X-CSE-MsgGUID: 2BLCoKUURFu9S2uYc2qrvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="98360554"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 17:15:50 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 17:15:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 17:15:48 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 17:15:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDgAPINfr3z7GPaQay2iIdCFCX/joDZnjJIkBfJHMHk6U1UNSQ1Z5GKftBSDO9kVNbTkrmBtrweXl/9yFUwdW6s6/wkFFzE1XZuOOMhzaL9IQCphchgWPSz56f0Eu1Z40Vj/jam5hDzsHvxsRJS7NguCrC9dpmb75QWsYVEDvVeaDW2g+/X7sx+DwjPMfXpExs0sxfAdSb3PA6Nmi8mTfOVjCPQ4kisMip+5qCESt2375qzSHxLRFyD4n9aKNToBP4B1TkmmnEdqvV/lgoheA4yYLbkfNS4PcXmxGrRho6/E30BrwfdHdBjTFouuR2CCY/q+lMAk6IvxqlT2Rct7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75umgxFmiliVYK9meJyCO5em8JTsnJJi1sdNSfq+Bj8=;
 b=ak5N8UJS/pKMFI1x5L7VT45YIITqcHfoDNrZY2yqM8eC0AwT51ILCI/CjLq4oIp96O+QeNJeg17fNKaqFr0fffcAA2VFfoXtKih+XPJna4KJRiYV2vJRDAEUegIFwRIKkADsoZ/ouY8VLmYuDjFVQ5MDdGCg/658h8CeqnjZ5xadRDU0siRBZaUd5bAHBDjUgxuHmfwr9G63Ahyaf+XVExxcabVI8+rug5t/xBovAve1GHonyZ05g7/6kVid/c8bTgET6P6MatcWcpEsRh7dfVXbjlsfy4O0GSpmDY1XmVXK3hW1clpxCYTHkeXjEfolkmFcnPBXorGr8XOZ87mSeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 01:15:42 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 01:15:42 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1 2/2] mm: zswap: zswap_store_pages() simplifications for
 batching.
Thread-Topic: [PATCH v1 2/2] mm: zswap: zswap_store_pages() simplifications
 for batching.
Thread-Index: AQHbQR8zjJv99UT6akiirMMuSrWTzbLMRDGAgAdrCoCAAA/HUA==
Date: Tue, 3 Dec 2024 01:15:42 +0000
Message-ID: <SJ0PR11MB5678F859FC683F09FF8EC958C9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241127225324.6770-1-kanchana.p.sridhar@intel.com>
 <20241127225324.6770-3-kanchana.p.sridhar@intel.com>
 <c9a0f00b-3aeb-467a-8771-a4ebb57fbba0@linux.dev>
 <CAKEwX=Oxa6Ov25ef6uj598jpZY=pFC2pcFrHSD626zuhokhrrQ@mail.gmail.com>
In-Reply-To: <CAKEwX=Oxa6Ov25ef6uj598jpZY=pFC2pcFrHSD626zuhokhrrQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SN7PR11MB7590:EE_
x-ms-office365-filtering-correlation-id: 4391fa0e-bc7e-45d1-119c-08dd133801b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QXdZSk9HZkU5Z2Q0ME5PV3NXdDQwdEtMS2I4a2lmQ1AwelVpREFkbW1aTlR1?=
 =?utf-8?B?elBOM0Q1aW5rZnQvOFFDQmRJa0JkenVDcm1YeWlHbUhLbWZRT0EyVzF0YTZ3?=
 =?utf-8?B?VmRwZ1EvTHJoYTBiVC9MY2VlNXluY2sxbWwzY1ZPZWRDUWVUMytqSExMUHFo?=
 =?utf-8?B?d3Y4WE5SRHVObERSVFVnVy82RXJZUXkxUk1iaXA2bndWSTBBT2RuVjdJaXox?=
 =?utf-8?B?U2JQR0tVUWM4d2xwY2lXdUowR3BKOWtjRXJRS3N6N2VzdXV3WGNPeXJTMUhi?=
 =?utf-8?B?MWlzWWU3RjZMUkZ5SzZCUnhaYWpxSUtWVlhLaDFISllEL3AwSlN5OFFVSWU1?=
 =?utf-8?B?M1dXVXpVZDc2QXBRV1dqODlMRGxrcmJMbWkwdDFEbmdZSFQ1Sy96YkVLcTZ6?=
 =?utf-8?B?WnpDM1MxQnNoZk9GWkpVdXNzbktYcFJiWkRQelRCWmJUMjZVeVczSDFiUUo5?=
 =?utf-8?B?K3BQTHRLeEpXUkdWb09QSUVkcTg3VXdWQ1Q1ell4T0JsMUZqem9KL2RmZ1BP?=
 =?utf-8?B?NklrQ3ZsNnJITldQTVRlbmFPakFxUEJPa3p1TUtOU3ArNXBwU2ZubzVNQmds?=
 =?utf-8?B?amZvclFUOXhXeDVjYUVaMmdQSUNlWFdTczRUWFU2bnlOT2pNdmVQaFIvWUFU?=
 =?utf-8?B?b1N6OG5xaS9mdHdWVjlUT1dFMDlaT052bEhCdXJ0WkNNamUyeHJNSDQ5RENH?=
 =?utf-8?B?Y3VFZ0tkMmZsYWZVM2VDcjR0VFlPNXhhRE9QOERuU3l2a2lsNGhjakREZ2xB?=
 =?utf-8?B?d3l6MnZySWxieTRqK3ZQdzZyWjJxNjVJTHArVHNtbmRrTzYrc2xGMlR4U3l0?=
 =?utf-8?B?ckJpenFaNTczTjFjT3R2WGt2Wi9RbGxuTWl2djJ4eHZUYWc4WjcwcEttRXdy?=
 =?utf-8?B?Yjg0d1ludnNlN2JaR3U1UitYdXVITmZVZlVrK2hiVVNNZ0V6cVM5WkQ4bHpm?=
 =?utf-8?B?OURPdmdrL2JiNlE4T0hBSk5VWnUrVGxDUHJQTVhrc0pUU0V1MkRDVnplaXFn?=
 =?utf-8?B?dzY5NWV6bjF4UzU5Y3N6Uno0NDdVMk9US0JybWd1c1lZMkNRMUtjd1g4dUpK?=
 =?utf-8?B?d1ZoSG5SY1Nxd0JVR2FlRkl1OTlqSEoyZ21NN0N5a3VLcUJobFlOSFh3OGE2?=
 =?utf-8?B?eGcyTVlGM0xRSFNQRCtVc0t3UU9NaEowTGNuRWlRTjVaVTUwU214WmdDZ1Y2?=
 =?utf-8?B?TkRmcHJwQmpiSTF3Z1QrWFlWL2dlMmRrc3Y4NUEwbE83aTg2VmkwSnRPVHlO?=
 =?utf-8?B?NzZ5NVJrNm5HTVh6aWVhQm5VOEVvaDYwbk1EaXVpUGFaYzlvTThHdTFyOUJJ?=
 =?utf-8?B?Y3pNNmJNd25OVm82UVBLV21XVXNBUnhweC9EUjJCbm8vU09IbkVrRjQrbEor?=
 =?utf-8?B?M0FGdDdEaVJMRlVFMHNRcGF0ejBEUVZQUW82OUhTanRTdnNTNU9kUUp0ZDlB?=
 =?utf-8?B?VkNvdXZhcjh6MllPUlNmRW9DQjNmdGZaUWVISVd3WU1MMXUxWHg3eG12Y0NF?=
 =?utf-8?B?NXFkSkZuUnZ3VW82aTdiNkRldFcwWVVabjI2ZjBqajMyMFE5UTNBZ25KOCsw?=
 =?utf-8?B?SmpSbVpIOE5iYWovMzZxUURocEcyNHM2Y25RSjBUZU1haWJVZ2dGQ3AvT2tI?=
 =?utf-8?B?azhPbGNkMXl0SnFiSkx6NGNtSjZUUi8rczJDa0s4SFVqWFhDdzJ4R3p0QWZz?=
 =?utf-8?B?SmlkLzNtYk9NR3ZWT0EyTkhvYldLb0hObDF6NUVQS2NHVDIzQm1nYjBneHpE?=
 =?utf-8?B?STl3ZFlPbk5nbzVzZWRaUDZPVmcwQ2hjaDRWaHlJbzNtK1MyWU1ubVNPd3FB?=
 =?utf-8?B?ZDIvWngrTENsYXF2eDd3S2Z0UjlCajFscWh5Zi9uNno4NXdiTUh3dE5oWkpL?=
 =?utf-8?B?L2s0d21UaHltcEJCYVc0ZDBvYmp4VUNXU0RoS0VUbVd6elE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEJoL2paVFpycDM1TWJlMXhTWmUxVTNZY0ZidmtCN0dydWtFQzdhQzBMS1ho?=
 =?utf-8?B?Wi9TTytDS1dpVGZwd0g2dUFjQ3pzUTRiK0N2eXRJL1N3bUUxcU1oUExtN0Zr?=
 =?utf-8?B?ZDVHNmNCKzBaRVVmMkFEQzNOWG5qUVNLWjBmcnF3S1VyMVJJWk9xSUZ2ZXd4?=
 =?utf-8?B?SUtndGVhWVpmdFZXVTUzSklidE5xVFhjU2RNdyt0ZlBnWEliYnVFaHVsVGRi?=
 =?utf-8?B?akttNjcyMkZIbjdiYU9wK2ZXMVp0L2F1K3M4eDR6ZWRYM2ZYaldZY05rQUtZ?=
 =?utf-8?B?RnR0R0VsL3c2cjFncnpLNWV0ZmMxMzJReXFIeDd2eXAzdWpjZ2VsVkdpcmxT?=
 =?utf-8?B?b3pLNTZvRkVmem1QblloZUVHeEZoVm9kYkYwbHBZZzNUUXdpOHoxQ3hHQWtM?=
 =?utf-8?B?dTY3a09sTmg1eENTMDB3ZC9sNy81WWsvUGE5N2lkQTlTT2ZBVTl2eitic09F?=
 =?utf-8?B?MDFjR291aXAwVUtKS0x4dW5VcEt3bHNyN3RUaHhiTDluakRUdVpmeHhxYTl0?=
 =?utf-8?B?b05EdUpjSXVhcDZRVmFTa2x6cllSTzltZ2Nua0h1UytOQ1VQbStLNXN5YVFY?=
 =?utf-8?B?RmRUeHdwVUczNEdiWkNQN2lDM1M1UHhuUmhZam5EalM4MXdqdEp0K29xd1Y1?=
 =?utf-8?B?WDJseHpQS1drY0tXNHVwSnUvdkhMZitYVERRMWp5RGxMRmp2VlNuRmJpWFdF?=
 =?utf-8?B?RmFNZTBmR00wTDVPVHFhdnJncXp2ODMwUUJZUEZMNGNpRWFxb1k0NjBIeno2?=
 =?utf-8?B?ZXFPSStkVlNKaXRxN0RRZ0M1UU84elpJb2tXVEFuellqVTlzUzhQTzZhSzZY?=
 =?utf-8?B?dnhsL1VkVXhZbUJMSWpwNzU0aUJzUzBKd2tZWk1YY2RYTnNaOHZSc2QybTNl?=
 =?utf-8?B?anNRMWl4WExXNUNnYUUzdUU2UGhiRU0rNU9nNkpsaFV3YUdhWFhIMXl4ZGJp?=
 =?utf-8?B?QlQ0ZkovcWRZR20rZDhRZk9QSHY2QjFnVDd4T1I0eWRBRlFBSjIvQ2d1anZi?=
 =?utf-8?B?Vi9vVXVINFdJYnlEZUxiazRhRUxnUmZpdys5ZEpCSGlQbmVIOGdVR01IdXZN?=
 =?utf-8?B?V0JBeU1XeUh0a2hOdEtDaTloSEtoVk4zVVJSUnFHQSt2N29waThSN2h6dkRw?=
 =?utf-8?B?bjk5UlpLVnZwLy9ja0QxTHg3SjhQeG1LSmM1TWxNeGJac1hkTXhYaFB1a0FQ?=
 =?utf-8?B?V3drSUxQK1MxTFJKdkhyeUlKcTdyOXJtRjd2cGRZNDRjb3M0dGRpbjlOZVlr?=
 =?utf-8?B?T290NGlxZkJlSmFscTVzVWZ5Q084cWozNUw3K1NmNTBUSmFkREYrbndnMXRR?=
 =?utf-8?B?dVROOUdRbWZEVGtxZzI3TWVtRXlpZFF2S0NKNUV1QmRKem01MXFsWldFeG1o?=
 =?utf-8?B?eXhKUzd4ZE4rekpLV0RUcTBUdm1aZU9ZQVJoVVkxbVU0ck9hdzFGRTh6SDI4?=
 =?utf-8?B?c2c4VEdzNmJXdUVmeFR2YUludlZ0RHEwT1FZZmdGV1JPL2p5MnhWcWIvTDZ5?=
 =?utf-8?B?RXVmMi90M2QzUUs1MnBmUzJoYnlKdi8vM3RXdXcyMFlDaFdoRG9meTRTb05J?=
 =?utf-8?B?dDUzeFRTUnVxMjR2eUNVU3BQSjZxR2VQaml2dGNwckNscGo3VkQrd2p2ZmVC?=
 =?utf-8?B?SjFUM2psajZLcExqWU9qTEY1dnVYWDVSckRWd09yd1VwZ09qZklwTUlvRHJF?=
 =?utf-8?B?clo1c1dCUG1wbjBxdGhYRy9lQjJuT1J6cUlJQ2NGeUY0aThMcWxsSXdlVVhJ?=
 =?utf-8?B?TVlObFFyeFVkZkdhdkdicHVRanI5TEFYQXJHbW5hTWtkdElPVDlMSTlHREFV?=
 =?utf-8?B?aExCM3NmTGZjVHN2VDZnekpzSGFyR0NCUFJreXJWNzQ3clRDcnVyT2Mvbllo?=
 =?utf-8?B?RTNqZ01GNklDTnIrcFhMN2R0OUtuZEZtZC9EZDF6UDlNM0xBeFRkSlNYZDRZ?=
 =?utf-8?B?SUpSbTdwcUNWMkFHcnNkbXkyYkh4MkhpS1Fld1k0REVzaytUaVlBUzVMYzdG?=
 =?utf-8?B?QmZFRi9tQTcyT1AxRFF5UDJuaktpRWpGTndQMENpc293SG41bXYzR0psMWww?=
 =?utf-8?B?b3lNU3JVcElaRmlYaFRSUFdQRmJ3My91a2VSajFtdkt6TUdpM0pHUkllNEdk?=
 =?utf-8?B?VnVtRkhlcjZvYWlsanpWT2NYVU1JMVhSNWExMXJTd09BdTM4U285Qyt3bnh1?=
 =?utf-8?B?SmtsbXRRR05JSm1oSGFRa284cXdHV3BNcy9lU2JSdzlROGd6UFpDVVUvcFZo?=
 =?utf-8?B?NHJxNzdYYlg1Z085TzlKallhakJRPT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4391fa0e-bc7e-45d1-119c-08dd133801b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 01:15:42.4050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DcJwVlYh1t533x9BLECztZZH5RPjxeC0OPxpeu47wMPDHOt4Q9QlfvPjfCyOGm9Y6V/cYiEdLXRwnMNFX//PNAIkKB7DHNLIHNM5W88AV3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7590
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5oYXQgUGhhbSA8bnBoYW1j
c0BnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMiwgMjAyNCA0OjE3IFBNDQo+
IFRvOiBDaGVuZ21pbmcgWmhvdSA8Y2hlbmdtaW5nLnpob3VAbGludXguZGV2Pg0KPiBDYzogU3Jp
ZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT47IGxpbnV4LQ0K
PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IGhhbm5lc0BjbXB4
Y2hnLm9yZzsNCj4geW9zcnlhaG1lZEBnb29nbGUuY29tOyB1c2FtYWFyaWY2NDJAZ21haWwuY29t
Ow0KPiByeWFuLnJvYmVydHNAYXJtLmNvbTsgMjFjbmJhb0BnbWFpbC5jb207IGFrcG1AbGludXgt
Zm91bmRhdGlvbi5vcmc7DQo+IEZlZ2hhbGksIFdhamRpIEsgPHdhamRpLmsuZmVnaGFsaUBpbnRl
bC5jb20+OyBHb3BhbCwgVmlub2RoDQo+IDx2aW5vZGguZ29wYWxAaW50ZWwuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYxIDIvMl0gbW06IHpzd2FwOiB6c3dhcF9zdG9yZV9wYWdlcygpIHNp
bXBsaWZpY2F0aW9ucw0KPiBmb3IgYmF0Y2hpbmcuDQo+IA0KPiBPbiBXZWQsIE5vdiAyNywgMjAy
NCBhdCAxMTowMOKAr1BNIENoZW5nbWluZyBaaG91DQo+IDxjaGVuZ21pbmcuemhvdUBsaW51eC5k
ZXY+IHdyb3RlOg0KPiA+DQo+ID4gSG93IGFib3V0IGludHJvZHVjaW5nIGEgYHpzd2FwX2NvbXBy
ZXNzX2ZvbGlvKClgIGludGVyZmFjZSB3aGljaA0KPiA+IGNhbiBiZSB1c2VkIGJ5IGB6c3dhcF9z
dG9yZSgpYD8NCj4gPiBgYGANCj4gPiB6c3dhcF9zdG9yZSgpDQo+ID4gICAgICAgICBucl9wYWdl
cyA9IGZvbGlvX25yX3BhZ2VzKGZvbGlvKQ0KPiA+DQo+ID4gICAgICAgICBlbnRyaWVzID0genN3
YXBfYWxsb2NfZW50cmllcyhucl9wYWdlcykNCj4gPg0KPiA+ICAgICAgICAgcmV0ID0genN3YXBf
Y29tcHJlc3NfZm9saW8oZm9saW8sIGVudHJpZXMsIHBvb2wpDQo+ID4NCj4gPiAgICAgICAgIC8v
IHN0b3JlIGVudHJpZXMgaW50byB4YXJyYXkgYW5kIExSVSBsaXN0DQo+ID4gYGBgDQo+ID4NCj4g
PiBBbmQgdGhpcyB2ZXJzaW9uIGB6c3dhcF9jb21wcmVzc19mb2xpbygpYCBpcyB2ZXJ5IHNpbXBs
ZSBmb3Igbm93Og0KPiA+IGBgYA0KPiA+IHpzd2FwX2NvbXByZXNzX2ZvbGlvKCkNCj4gPiAgICAg
ICAgIG5yX3BhZ2VzID0gZm9saW9fbnJfcGFnZXMoZm9saW8pDQo+ID4NCj4gPiAgICAgICAgIGZv
ciAoaW5kZXggPSAwOyBpbmRleCA8IG5yX3BhZ2VzOyArK2luZGV4KSB7DQo+ID4gICAgICAgICAg
ICAgICAgIHN0cnVjdCBwYWdlICpwYWdlID0gZm9saW9fcGFnZShmb2xpbywgaW5kZXgpOw0KPiA+
DQo+ID4gICAgICAgICAgICAgICAgIGlmICghenN3YXBfY29tcHJlc3MocGFnZSwgJmVudHJpZXNb
aW5kZXhdLCBwb29sKSkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7
DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAgICAgICAgIHJldHVybiB0cnVlOw0KPiA+IGBgYA0K
PiA+IFRoaXMgY2FuIGJlIGVhc2lseSBleHRlbmRlZCB0byBzdXBwb3J0IHlvdXIgImJhdGNoZWQi
IHZlcnNpb24uDQo+ID4NCj4gPiBUaGVuIHRoZSBvbGQgYHpzd2FwX3N0b3JlX3BhZ2UoKWAgY291
bGQgYmUgcmVtb3ZlZC4NCj4gPg0KPiA+IFRoZSBnb29kIHBvaW50IGlzIHNpbXBsaWNpdHksIHRo
YXQgd2UgZG9uJ3QgbmVlZCB0byBzbGljZSBmb2xpbw0KPiA+IGludG8gbXVsdGlwbGUgYmF0Y2hl
cywgdGhlbiByZXBlYXQgdGhlIGNvbW1vbiBvcGVyYXRpb25zIGZvciBlYWNoDQo+ID4gYmF0Y2gs
IGxpa2UgcHJlcGFyaW5nIGVudHJpZXMsIHN0b3JpbmcgaW50byB4YXJyYXkgYW5kIExSVSBsaXN0
Li4uDQo+ID4NCj4gDQo+ICsxLg0KDQpUaGFua3MgTmhhdC4gSSByZXBsaWVkIHdpdGggc29tZSBw
b3RlbnRpYWwgY29uc2lkZXJhdGlvbnMgaW4gbXkgcmVwbHkNCnRvIENoZW5nbWluZydzIGFuZCBZ
b3NyeSdzIGNvbW1lbnRzLiBXb3VsZCBhcHByZWNpYXRlIGl0IGlmIHlvdSBjYW4NCmFkZCBmb2xs
b3ctdXAgc3VnZ2VzdGlvbnMgdG8gdGhhdCByZXBseS4NCg0KVGhhbmtzLA0KS2FuY2hhbmENCg==

