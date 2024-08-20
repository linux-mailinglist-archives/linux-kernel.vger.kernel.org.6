Return-Path: <linux-kernel+bounces-294543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A70E2958F00
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A8C1F235FB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EF4156F33;
	Tue, 20 Aug 2024 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fxqih3pW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B42B18E34A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724184220; cv=fail; b=OxoDO/Lcp9PAodofCrCeqT7EjtY1vaG+PKabf4Xknxm5T7TND0Ae3vtN9Eq9FKhkyyKRBa2zs45HfL5bYaV11zmq9I039YfbzOMb22mCQ9wALNjcGEmtVr9Zf6slBnt5zzMSfGMTM5WVImeYiJn9j2esNCaWNTaHM1sztvPiKSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724184220; c=relaxed/simple;
	bh=7bEVW1OiuMDgkKcyjXEpL64P89CbJC6HDSkYNtmbxKU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PJwSqPIHxUdzXTZKaIKFy8XkK90jPlTR8/kJA0kkwjL1pIJ+fedZOTdBWeegnv1O/XlP2qutbfbLgbaJ/23gQqMTf5RW4lVwJg5hNoLgSVUG2hvwB39pdYoA0HlX857YYgEdHkJpmDgDjn6ceA920oGrnqqrqVICk2qPsLDXq+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fxqih3pW; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724184218; x=1755720218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7bEVW1OiuMDgkKcyjXEpL64P89CbJC6HDSkYNtmbxKU=;
  b=fxqih3pWsTI1DZAXW6WpkzqB03bihALhzEc7nLVROIA77o0ItTHa8pYA
   Hb2KBSE3BMguSoTPthaW0Zfz1pLoWGZt5eXs5LTBttx3w+xisUqL0REnL
   7VzUoZstldILDvJf5Hy3TUTD74hW6VrECjoeF8xdnrX+x17/fqbbJLWxO
   3LMc/aEd4hDMdK6eK7Cvu4vg+21nja7yxZ0TSc8SwI/lKnPILSQrjA6sE
   ouYdjjJI+Ter1BttHY7y175rSZMnWCwBtLQwMUJcw+cNITAdyDrAS+E3P
   WLi74pkZxn/vKjHeAGZJqatIXfVgw4ZRkrQSYS50UeGXHQCLfFC7/wg2r
   A==;
X-CSE-ConnectionGUID: i8soPI7GQEatprbTau7M+A==
X-CSE-MsgGUID: MhpVRZ02RpWv5VXBIwUJUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22130395"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="22130395"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 13:03:17 -0700
X-CSE-ConnectionGUID: kGC6IeJVTVCifEthagTdeQ==
X-CSE-MsgGUID: imcpHJeASLeMkFT5XKi0Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="60547184"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 13:03:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 13:03:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 13:03:16 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 13:03:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKwVI8FYvACTSVGqIWSN8uNj1ve95WXvwNt5GpSyemDNhA8dHsnxzcKPPIbXb/yMuKWuxi6HhNsBblHrnF4CRmFOvmmJKkFXZGeNcgfs25v647ryYCwipiRUQM0c9J/B3dWWL+0JcXybjk6IRVOAU9hay8I4+w4K7nKkbnOtaoDgKGQTiR4+vEhp4W4aD7pMkXNI2b8DVYBIl6O08Qjj/OA4FZXjYTWUcnY9S76r02z3CyUAiqQqRkq7YO/GRFLl0DQCO4c0FJoMP7EsWFCcFeP3uuiXwwz4++Oza5ZryrR7+0XQrvYbmvbJZCwmOz/DVRf9jiOUrksytdmJk4ubfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uBZZjhuJE/hUy6MvoRycSBUIfUvNoghoZrmULWcKIY=;
 b=SAbK83s+7rbVb0XsSWGnA5UBER2gO31yZO45UxXlhPtBCoVuIHYwitwNoL1iKqjAuULOEL0YPVniRP76DVFBAPefr2w8MCcaIZnIInypwP0rm2Lt1WPapCWNfqPpLITcvjeMv7l42Z0dR5CDvWTQ0EG4dFaVR57ML0gpyGH6fRQPVDOHlyTEBLS0pKyxg8nQKWPw6+Pbf0usSRkp3HL5QTDcXN34Yn0g/xczVML9u57oAO/EOTsVvCz3GUQri/v47bbWS4RosYtOtN5p/OX9R5o1NU2jb2QJK4DR+jpKZF4OVjF2J4gRTKux1oiQOusZnUDeItgimzB1cFA8HCJ0og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 20:03:06 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 20:03:06 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
CC: "Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v4 2/4] mm: zswap: zswap_store() extended to handle mTHP
 folios.
Thread-Topic: [PATCH v4 2/4] mm: zswap: zswap_store() extended to handle mTHP
 folios.
Thread-Index: AQHa8d3OZYBmahCW/E+vBZT4yH+6b7Iwkp7g
Date: Tue, 20 Aug 2024 20:03:06 +0000
Message-ID: <SJ0PR11MB56783A35B58B15851C4AD32FC98D2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
 <20240819021621.29125-3-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240819021621.29125-3-kanchana.p.sridhar@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|CH3PR11MB7180:EE_
x-ms-office365-filtering-correlation-id: 288de791-bbff-482c-50a6-08dcc1531b72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cMyRAaOVXaDxNt0twGi8+ihi2toUXcUd28ymQ4Mqzb1ug/9dT8PwROtwLd3C?=
 =?us-ascii?Q?BP68aiFNlbd0/+BMPT1kE5PxjlooaQ6/p6UMOpH8VWXa+Vs/NyAftigCuxXZ?=
 =?us-ascii?Q?uW1YIvQpnnCR5VbYkgwYyojZ374EkAXbybhGs9XLrpKfv9QcK996WOqUjU3e?=
 =?us-ascii?Q?YkonuMchOuSPOC585Xw82kqRjupM74R0yxqi8yiAEcOEiMu1KhXEy47UGDR2?=
 =?us-ascii?Q?ErtFdeO0mk3rRuHr5fTYJg4wWHzfVwJu35rc40QTkkJotQh19nB0EV+0m94L?=
 =?us-ascii?Q?SD7P3wENWKyqCwPzDKPNQON4s6QKPaLy76XQ6F1O1myiCdWO3U+YlhyKmSzm?=
 =?us-ascii?Q?LisVqnFxbFvSlTUhG7qFxmMflt9jbPNJ4Y2cFL9g7x79YIT6QWirGo1ANx2l?=
 =?us-ascii?Q?sNko5oxb7fe7OOkUcZhFc9xMp6BEw0uKNmMUSl0Mowx42ZXy/TkM/SmQnzwm?=
 =?us-ascii?Q?yllixCMrJZB33V36aUdWP9W02w8xjzCy9vdvcmhYiAUZHZIF9edT697bNi/L?=
 =?us-ascii?Q?9CchUDbFlEBOkJSlKWq72UZgT3PI59/vNmzBtVv6JMkahF1dLMfeNHvMqd6P?=
 =?us-ascii?Q?D2JXH5GKKBqb3euOBQ3FbEXBu7TBEF40THT7lHCP7cnzqhRvmTSRwSmFfDs8?=
 =?us-ascii?Q?uwsPm9DgNxBuJctaYk2wf4j6PzOB+D1OUQivbsGL846RkvFWuwtSMsYy1DSO?=
 =?us-ascii?Q?kb0Bd4BmDh6X4Z0hyvZkeh+BQR3WRqKDx8RqUpgtpu4x/Zg+H1NkoQNTRQ0W?=
 =?us-ascii?Q?MqTa/pZakMfDFRkCCBQAz+NeZnywZ3rpcEgeytEX54sAl/sgTHo3EO79Lxid?=
 =?us-ascii?Q?nG3AIgUYV2vEsOKeA6jihVY58PL3l6w9axo2ukWfBvOfJH7nyCOIa6/CdTvQ?=
 =?us-ascii?Q?hnTPPfreV46UtqmDJz0tP8yNbnF5KfEG+J/kilPJxCJci8S4NPn4RnnP/9+o?=
 =?us-ascii?Q?xVBIPps7LO4CSQzuiEvhJIO6wROSl7jvtY71SzkyrOvzpSSCO/p4RjROciJi?=
 =?us-ascii?Q?7zVcRWH/C/rpe4l3Otq9FL20Ll8L0VAPgCqBsiNwekdnMPmrsMTghPWrZtAQ?=
 =?us-ascii?Q?nYLLFv1lD8WANyiVzVzoSGZLRjGtnGNs4Zj43DV1awP11m0TX/cFTwOjZw5N?=
 =?us-ascii?Q?JOUBtnXQigUP4FwgbEUejE/SLMZmWCTp3h+HerfWJChN3zqL0UNXYaSXuCM5?=
 =?us-ascii?Q?uznlmjOtwdb40DHrJWkoSMfYfBo/v0VlTAJbXISGUhEPMTwsjplrnOb0LkRc?=
 =?us-ascii?Q?hHiPXfN2ONGf7HPtDR4cC7Td613QNIZW4ZmD/crCBTjki9qNsWcSZ3X83DTm?=
 =?us-ascii?Q?Wa1kJsTnY1muu/dii2lUjinKaEousmErmYYUB3pl55h/kA7m+dUK7XwfV/Pk?=
 =?us-ascii?Q?a83ZJ/ZxLq4KDsbUNUKYanNCuC3O?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EmGtCypbpMiT8usRlcpwqjZkkm12R1CbWvUaSlroKAMrxsgdEDsJgoHn1Q4p?=
 =?us-ascii?Q?t2AaZHXELJvwa22KJPmfI9fEJHkFynMReWL/2c2FQdLZM5VsRGVqHdc9jsAE?=
 =?us-ascii?Q?L32gbzam1Z2SQqCC5fbbnX/pGIbrQCZVjmQeMpc8fER1GoGCC4pW3RsxSw6B?=
 =?us-ascii?Q?l6hrZhv6GFGzMio18MG1+kXARglhB9pNaMJy0kpsZkEHCyWNXoHZ4zXAymT0?=
 =?us-ascii?Q?OfSCG6g/Rif5/BDu7AzNgUPxC7kp8jK8cBhtsRPdnJ3QYweZjCbCDbm36n48?=
 =?us-ascii?Q?E8cGwgLbOeI60OXMStt83czktlXln3KbWMc6/q2UR6/Sz+ghDZ6JZQreAnV0?=
 =?us-ascii?Q?2Qe3gCmGlgD9JA40fMqfKiQCMv9PgFV5cnNc8xf41CQ3D6R0tOnz7GqQrEyp?=
 =?us-ascii?Q?I6sG1TyQRU7b+K3t2QzQ4fT2nwurPzJ8scy+Xs4T/KqnMUUjYv8xxa9R052L?=
 =?us-ascii?Q?K6Y089YehVQj/hW/YVlTmYNuqkD4h3w99GKNKbGfJ3NFCOfpl6qkJwibrs37?=
 =?us-ascii?Q?5+Fzp9lCnzonQFlmWZguvl/I63IuJEJybzsBoR7zvjwdliqUblYEabsMgUH3?=
 =?us-ascii?Q?IJp4WFpg61FoFxbKKe/3dRmJs3SbxlbOXTeJU2WybKtZy5KAY/QKc1cAQFbn?=
 =?us-ascii?Q?/b4798XFi3b5NWGPCot+AQxNxtiGuFB1wwrn0WNhNjSy2j7ygtjI/9bv5/x9?=
 =?us-ascii?Q?cZ6fJwMK8UbVJgWUTxxhAVqOvXn3grjPrjsDWRpJPLUnW1Lov+M7rkkr4HiX?=
 =?us-ascii?Q?oxzdkIymGWAfJkqCtpptjXjL64BfAJVAL38Y45gCTOO8WoTyBFIXm7ELq88x?=
 =?us-ascii?Q?/SoaUgbH7cLj3LqdrxO6hwCBEQeb2PKGGPPhk5LbfwusBQ0KjqK57NOkBOi8?=
 =?us-ascii?Q?yk3rt4V+PM2k0q9yrvrPfFvwoOE3QsWmgYYFisbg6VtmhmD/zigjxSohbWP2?=
 =?us-ascii?Q?6aYwcBTRDcJgTUfahpdaD3+Yrnf681VcEAzIX95eYMmMpPBBceMFuvlxTh0a?=
 =?us-ascii?Q?t86FFfz7tsm8n4NQL7sdYlcJQjpELyZq4yIhWzKQINGXUSWcY6wlwGgdkUr1?=
 =?us-ascii?Q?drgwxKoE2BzE36UEuJHdMyU7whvN2fBHvbYZXq2aROoJinJQaUxL5psr9cVu?=
 =?us-ascii?Q?mgfVfZxWHYYnkDIP+g0Mj5E5Al3DjL9iTIMcDg1t4zuoqHmvT9TpRm9VN1T8?=
 =?us-ascii?Q?y2TlrvCliO8YcvqexyMTQTmXIJ+yNBTjWIGPp7VQGl9K6rcQcEi+Vh6GxqG5?=
 =?us-ascii?Q?3+Nx3AtJ5b2/Im5T5YuJktLBFRSFuQYnzqxZISJMhZK0ORrDdgZ7g0jPNq6c?=
 =?us-ascii?Q?QN6Lzabk/gGwLHZnAlJSYPekZIYTaQZUbqdUptFQW5hSGFgUMz5mZ2nqJqT4?=
 =?us-ascii?Q?7cePHBYWwsewoKcp0lVNn4BUGEAFBdsoE4Uqryx4MoQta62Jk7P7vm+YyoCM?=
 =?us-ascii?Q?4nM1Q0ARutL6lrlh/mNEsLUVCPPFtZnAstUgkpBW1eT88GRrVoORGIpKfXId?=
 =?us-ascii?Q?nWfLExfm+fWHHNndS+orGB+lotD2S2lM6WYoyp49uOnOk/h5SBMh6FGRjrCY?=
 =?us-ascii?Q?ctCWmGNNckoj2E3FZMM+clwhU0zyakAlyUGgNS8KDJ5QzheMDQdRE8n4Gd4r?=
 =?us-ascii?Q?6A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 288de791-bbff-482c-50a6-08dcc1531b72
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 20:03:06.6291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6WbD7UfCxmT/J1zdG+s9yTofwhBxElD9w9dgVAHjmvBkgLYX7UgyCRpyuTDDU+AgTi0K2K97mgksTwf35TVwQmYbYgXxUxQ5qY3GlZYzrGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7180
X-OriginatorOrg: intel.com

The build error is fixed in the following patch implemented against the lat=
est mm-unstable:

https://patchwork.kernel.org/project/linux-mm/patch/20240820195005.5941-1-k=
anchana.p.sridhar@intel.com/

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408202320.trSaY2o4-lkp@int=
el.com/


> -----Original Message-----
> From: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Sent: Sunday, August 18, 2024 7:16 PM
> To: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> hannes@cmpxchg.org; yosryahmed@google.com; nphamcs@gmail.com;
> ryan.roberts@arm.com; Huang, Ying <ying.huang@intel.com>;
> 21cnbao@gmail.com; akpm@linux-foundation.org
> Cc: Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>;
> Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Subject: [PATCH v4 2/4] mm: zswap: zswap_store() extended to handle mTHP
> folios.
>=20
> zswap_store() will now process and store mTHP and PMD-size THP folios.
>=20
> This change reuses and adapts the functionality in Ryan Roberts' RFC
> patch [1]:
>=20
>   "[RFC,v1] mm: zswap: Store large folios without splitting"
>=20
>   [1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-
> ryan.roberts@arm.com/T/#u
>=20
> This patch provides a sequential implementation of storing an mTHP in
> zswap_store() by iterating through each page in the folio to compress
> and store it in the zswap zpool.
>=20
> Towards this goal, zswap_compress() is modified to take a page instead
> of a folio as input.
>=20
> Each page's swap offset is stored as a separate zswap entry.
>=20
> If an error is encountered during the store of any page in the mTHP,
> all previous pages/entries stored will be invalidated. Thus, an mTHP
> is either entirely stored in ZSWAP, or entirely not stored in ZSWAP.
>=20
> This forms the basis for building batching of pages during zswap store
> of large folios, by compressing batches of up to say, 8 pages in an
> mTHP in parallel in hardware, with the Intel In-Memory Analytics
> Accelerator (Intel IAA).
>=20
> Also, addressed some of the RFC comments from the discussion in [1].
>=20
> Co-developed-by: Ryan Roberts
> Signed-off-by:
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  mm/zswap.c | 234 +++++++++++++++++++++++++++++++++++++++----------
> ----
>  1 file changed, 172 insertions(+), 62 deletions(-)
>=20
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 6434e76a4ea3..9862a4cf0651 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -886,7 +886,7 @@ static int zswap_cpu_comp_dead(unsigned int cpu,
> struct hlist_node *node)
>  	return 0;
>  }
>=20
> -static bool zswap_compress(struct folio *folio, struct zswap_entry *entr=
y)
> +static bool zswap_compress(struct page *page, struct zswap_entry *entry)
>  {
>  	struct crypto_acomp_ctx *acomp_ctx;
>  	struct scatterlist input, output;
> @@ -904,7 +904,7 @@ static bool zswap_compress(struct folio *folio, struc=
t
> zswap_entry *entry)
>=20
>  	dst =3D acomp_ctx->buffer;
>  	sg_init_table(&input, 1);
> -	sg_set_folio(&input, folio, PAGE_SIZE, 0);
> +	sg_set_page(&input, page, PAGE_SIZE, 0);
>=20
>  	/*
>  	 * We need PAGE_SIZE * 2 here since there maybe over-compression
> case,
> @@ -1455,36 +1455,83 @@ static void zswap_fill_folio(struct folio *folio,
> unsigned long value)
>  /*********************************
>  * main API
>  **********************************/
> -bool zswap_store(struct folio *folio)
> +
> +/*
> + * Returns true if the entry was successfully
> + * stored in the xarray, and false otherwise.
> + */
> +static bool zswap_store_entry(struct xarray *tree,
> +			      struct zswap_entry *entry)
>  {
> -	swp_entry_t swp =3D folio->swap;
> -	pgoff_t offset =3D swp_offset(swp);
> -	struct xarray *tree =3D swap_zswap_tree(swp);
> -	struct zswap_entry *entry, *old;
> -	struct obj_cgroup *objcg =3D NULL;
> -	struct mem_cgroup *memcg =3D NULL;
> -	unsigned long value;
> +	struct zswap_entry *old;
> +	pgoff_t offset =3D swp_offset(entry->swpentry);
>=20
> -	VM_WARN_ON_ONCE(!folio_test_locked(folio));
> -	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> +	old =3D xa_store(tree, offset, entry, GFP_KERNEL);
>=20
> -	/* Large folios aren't supported */
> -	if (folio_test_large(folio))
> +	if (xa_is_err(old)) {
> +		int err =3D xa_err(old);
> +
> +		WARN_ONCE(err !=3D -ENOMEM, "unexpected xarray error:
> %d\n", err);
> +		zswap_reject_alloc_fail++;
>  		return false;
> +	}
>=20
> -	if (!zswap_enabled)
> -		goto check_old;
> +	/*
> +	 * We may have had an existing entry that became stale when
> +	 * the folio was redirtied and now the new version is being
> +	 * swapped out. Get rid of the old.
> +	 */
> +	if (old)
> +		zswap_entry_free(old);
>=20
> -	/* Check cgroup limits */
> -	objcg =3D get_obj_cgroup_from_folio(folio);
> -	if (objcg && !obj_cgroup_may_zswap(objcg)) {
> -		memcg =3D get_mem_cgroup_from_objcg(objcg);
> -		if (shrink_memcg(memcg)) {
> -			mem_cgroup_put(memcg);
> -			goto reject;
> -		}
> -		mem_cgroup_put(memcg);
> +	return true;
> +}
> +
> +/*
> + * If the zswap store fails or zswap is disabled, we must invalidate the
> + * possibly stale entries which were previously stored at the offsets
> + * corresponding to each page of the folio. Otherwise, writeback could
> + * overwrite the new data in the swapfile.
> + *
> + * This is called after the store of the i-th offset in a large folio ha=
s
> + * failed. All zswap entries in the folio must be deleted. This helps ma=
ke
> + * sure that a swapped-out mTHP is either entirely stored in zswap, or
> + * entirely not stored in zswap.
> + *
> + * This is also called if zswap_store() is invoked, but zswap is not ena=
bled.
> + * All offsets for the folio are deleted from zswap in this case.
> + */
> +static void zswap_delete_stored_offsets(struct xarray *tree,
> +					pgoff_t offset,
> +					long nr_pages)
> +{
> +	struct zswap_entry *entry;
> +	long i;
> +
> +	for (i =3D 0; i < nr_pages; ++i) {
> +		entry =3D xa_erase(tree, offset + i);
> +		if (entry)
> +			zswap_entry_free(entry);
>  	}
> +}
> +
> +/*
> + * Stores the page at specified "index" in a folio.
> + */
> +static bool zswap_store_page(struct folio *folio, long index,
> +			     struct obj_cgroup *objcg,
> +			     struct zswap_pool *pool)
> +{
> +	swp_entry_t swp =3D folio->swap;
> +	int type =3D swp_type(swp);
> +	pgoff_t offset =3D swp_offset(swp) + index;
> +	struct page *page =3D folio_page(folio, index);
> +	struct xarray *tree =3D swap_zswap_tree(swp);
> +	struct zswap_entry *entry;
> +	unsigned long value;
> +
> +	if (objcg)
> +		obj_cgroup_get(objcg);
>=20
>  	if (zswap_check_limits())
>  		goto reject;
> @@ -1496,7 +1543,7 @@ bool zswap_store(struct folio *folio)
>  		goto reject;
>  	}
>=20
> -	if (zswap_is_folio_same_filled(folio, 0, &value)) {
> +	if (zswap_is_folio_same_filled(folio, index, &value)) {
>  		entry->length =3D 0;
>  		entry->value =3D value;
>  		atomic_inc(&zswap_same_filled_pages);
> @@ -1504,43 +1551,21 @@ bool zswap_store(struct folio *folio)
>  	}
>=20
>  	/* if entry is successfully added, it keeps the reference */
> -	entry->pool =3D zswap_pool_current_get();
> -	if (!entry->pool)
> +	if (!zswap_pool_get(pool))
>  		goto freepage;
>=20
> -	if (objcg) {
> -		memcg =3D get_mem_cgroup_from_objcg(objcg);
> -		if (memcg_list_lru_alloc(memcg, &zswap_list_lru,
> GFP_KERNEL)) {
> -			mem_cgroup_put(memcg);
> -			goto put_pool;
> -		}
> -		mem_cgroup_put(memcg);
> -	}
> +	entry->pool =3D pool;
>=20
> -	if (!zswap_compress(folio, entry))
> +	if (!zswap_compress(page, entry))
>  		goto put_pool;
>=20
>  store_entry:
> -	entry->swpentry =3D swp;
> +	entry->swpentry =3D swp_entry(type, offset);
>  	entry->objcg =3D objcg;
>  	entry->referenced =3D true;
>=20
> -	old =3D xa_store(tree, offset, entry, GFP_KERNEL);
> -	if (xa_is_err(old)) {
> -		int err =3D xa_err(old);
> -
> -		WARN_ONCE(err !=3D -ENOMEM, "unexpected xarray error:
> %d\n", err);
> -		zswap_reject_alloc_fail++;
> +	if (!zswap_store_entry(tree, entry))
>  		goto store_failed;
> -	}
> -
> -	/*
> -	 * We may have had an existing entry that became stale when
> -	 * the folio was redirtied and now the new version is being
> -	 * swapped out. Get rid of the old.
> -	 */
> -	if (old)
> -		zswap_entry_free(old);
>=20
>  	if (objcg) {
>  		obj_cgroup_charge_zswap(objcg, entry->length);
> @@ -1574,7 +1599,7 @@ bool zswap_store(struct folio *folio)
>  	else {
>  		zpool_free(entry->pool->zpool, entry->handle);
>  put_pool:
> -		zswap_pool_put(entry->pool);
> +		zswap_pool_put(pool);
>  	}
>  freepage:
>  	zswap_entry_cache_free(entry);
> @@ -1582,16 +1607,101 @@ bool zswap_store(struct folio *folio)
>  	obj_cgroup_put(objcg);
>  	if (zswap_pool_reached_full)
>  		queue_work(shrink_wq, &zswap_shrink_work);
> -check_old:
> +
> +	return false;
> +}
> +
> +/*
> + * Modified to store mTHP folios. Each page in the mTHP will be compress=
ed
> + * and stored sequentially.
> + */
> +bool zswap_store(struct folio *folio)
> +{
> +	long nr_pages =3D folio_nr_pages(folio);
> +	swp_entry_t swp =3D folio->swap;
> +	pgoff_t offset =3D swp_offset(swp);
> +	struct xarray *tree =3D swap_zswap_tree(swp);
> +	struct obj_cgroup *objcg =3D NULL;
> +	struct mem_cgroup *memcg =3D NULL;
> +	struct zswap_pool *pool;
> +	bool ret =3D false;
> +	long index;
> +
> +	VM_WARN_ON_ONCE(!folio_test_locked(folio));
> +	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> +
> +	if (!zswap_enabled)
> +		goto reject;
> +
>  	/*
> -	 * If the zswap store fails or zswap is disabled, we must invalidate th=
e
> -	 * possibly stale entry which was previously stored at this offset.
> -	 * Otherwise, writeback could overwrite the new data in the swapfile.
> +	 * Check cgroup limits:
> +	 *
> +	 * The cgroup zswap limit check is done once at the beginning of an
> +	 * mTHP store, and not within zswap_store_page() for each page
> +	 * in the mTHP. We do however check the zswap pool limits at the
> +	 * start of zswap_store_page(). What this means is, the cgroup
> +	 * could go over the limits by at most (HPAGE_PMD_NR - 1) pages.
> +	 * However, the per-store-page zswap pool limits check should
> +	 * hopefully trigger the cgroup aware and zswap LRU aware global
> +	 * reclaim implemented in the shrinker. If this assumption holds,
> +	 * the cgroup exceeding the zswap limits could potentially be
> +	 * resolved before the next zswap_store, and if it is not, the next
> +	 * zswap_store would fail the cgroup zswap limit check at the start.
>  	 */
> -	entry =3D xa_erase(tree, offset);
> -	if (entry)
> -		zswap_entry_free(entry);
> -	return false;
> +	objcg =3D get_obj_cgroup_from_folio(folio);
> +	if (objcg && !obj_cgroup_may_zswap(objcg)) {
> +		memcg =3D get_mem_cgroup_from_objcg(objcg);
> +		if (shrink_memcg(memcg)) {
> +			mem_cgroup_put(memcg);
> +			goto put_objcg;
> +		}
> +		mem_cgroup_put(memcg);
> +	}
> +
> +	if (zswap_check_limits())
> +		goto put_objcg;
> +
> +	pool =3D zswap_pool_current_get();
> +	if (!pool)
> +		goto put_objcg;
> +
> +	if (objcg) {
> +		memcg =3D get_mem_cgroup_from_objcg(objcg);
> +		if (memcg_list_lru_alloc(memcg, &zswap_list_lru,
> GFP_KERNEL)) {
> +			mem_cgroup_put(memcg);
> +			goto put_pool;
> +		}
> +		mem_cgroup_put(memcg);
> +	}
> +
> +	/*
> +	 * Store each page of the folio as a separate entry. If we fail to stor=
e
> +	 * a page, unwind by removing all the previous pages we stored.
> +	 */
> +	for (index =3D 0; index < nr_pages; ++index) {
> +		if (!zswap_store_page(folio, index, objcg, pool))
> +			goto put_pool;
> +	}
> +
> +	ret =3D true;
> +
> +put_pool:
> +	zswap_pool_put(pool);
> +put_objcg:
> +	obj_cgroup_put(objcg);
> +	if (zswap_pool_reached_full)
> +		queue_work(shrink_wq, &zswap_shrink_work);
> +reject:
> +	/*
> +	 * If the zswap store fails or zswap is disabled, we must invalidate
> +	 * the possibly stale entries which were previously stored at the
> +	 * offsets corresponding to each page of the folio. Otherwise,
> +	 * writeback could overwrite the new data in the swapfile.
> +	 */
> +	if (!ret)
> +		zswap_delete_stored_offsets(tree, offset, nr_pages);
> +
> +	return ret;
>  }
>=20
>  bool zswap_load(struct folio *folio)
> --
> 2.27.0


