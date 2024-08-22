Return-Path: <linux-kernel+bounces-297350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD4F95B692
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29599B26569
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3FA1CB332;
	Thu, 22 Aug 2024 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6znapNJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271F81CB321
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333228; cv=fail; b=fFhzDofW2RADoS6re4qelhrVMDXrZOzkV42xgMV0tODHSY+pv/ASGDewFFqg+oqhiglFEeYqdi9Bv5y6XakNvkdutbuFM5/P7tHCfgfiLG4qI0gxJEEUXTH/ca3AWXMSa/kBjIP5xY8OkEl/cTt0E4o+j/HQNBAF/vHzEVtDtOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333228; c=relaxed/simple;
	bh=qBp7GnfKdol1pXfeGZnyjz7VjvagYUpzgO2Z4+LI5QA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mcmu/UKbVQuTQyV+fCuiTJ2O2mSy5ouTXLc9+BJcofsSTeMJc458uAWQcZU0YI8q/g6ZX1iWvxYr7N+VlItsAad8rMv+d+1OEHz58PCLQLeM34y0Ix0eIQ+k+vvHf9bsBOKKy0xOxQOA+wK/SMCA+ollCESE4N1KkN+Z3UwmUw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B6znapNJ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724333226; x=1755869226;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qBp7GnfKdol1pXfeGZnyjz7VjvagYUpzgO2Z4+LI5QA=;
  b=B6znapNJF+1zQnIgn9WvMXSxtKOQZYcAr6WNXFpSS+UBmMkF+FUjoji7
   7XRCiSxzFUeL+V/B6z0WeH6Z7cTuRVw4B0G+las0ZaEB/YeAWjXNvVLxl
   4YwzGS6rq7jvI4DYIl+OODhMMVWe5qLyKPrV8Xnv3HcBj+c9d5yjoR8cq
   ZR66Xgt6mvT6ZPN5wZGNlA09FomGSKIUYTiez1+QSSKiTNjatAwolHyjn
   tO3Kksoig1OKPLXHpyQCTJtGwBL/xsBJ6yKeH28tlrpE2Sc7viiglLqLk
   idSD0UzM0iKRtb9/492prbaFCJubUuOKbc/ji446aGOO6UMAOTU7RSpKk
   Q==;
X-CSE-ConnectionGUID: XMxwBgGpSdaVSgshvguLAA==
X-CSE-MsgGUID: aOQP4Gu4TkCNgkh1LCekpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22614512"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="22614512"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 06:27:05 -0700
X-CSE-ConnectionGUID: 7ehX/8THQoqxJ3iHdCE4Cg==
X-CSE-MsgGUID: pmo6nGDMQbKMX73KND2DTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="92246883"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 06:27:05 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 06:27:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 06:27:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 06:27:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKJRN34BeEaZloYtuFV6zSIwMnk2k3pXovC5yPodgp/klwJPW55I1PjHan0+Nb8kTtaPw5AkPQXObsYn8nRbi4PDmVrvVQhnrgyw9r8j5IOkLWYiLGyYMM12cYlRdDBHpc1Ln0i+TGcSc8nYeT7VMGxoF9TOWh+msWR+vBF9hK2TLNJgy93oPBM+AD0GJIRNmuzJ6Fny0thK2ubYVLPpzcXjIWMshK/44pjqP8QdgaEMWIkYM6aAk3XFATg1fcH+UVlhYj7y4WSmRX/qTEjJs+FV1hJ6gJEVKQ233SaRYHAYt3m4VFflMfRdNWc+2JU2WjvS9JuXy/SH8YmS+0bLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNWjPSBh+NkTENCXSUEJbVrVuMcrugtHGFW41z1OOwk=;
 b=qwPBz+9gdSNZ96uGS4Qt7++y4Xmke94KPSVO2jzbm7zAjBUjD9BYDzYpF/aw4y5lFfSMasx0+DC9Xmseqr/HdfCu9Cow0cobGtaq+QPtFK1TldztGETL1cs6+bOODHExIkCGBWt0/FGY8trOBHYmRHcSuTHrYRdPr2pxgifuYEgACB/avACAKFnDMoi8LOaLGFBF5r4pSeS8lIaadEFo7y05UayZgYPBv3geEW7JQbc6zJEBag0MUvNpoE+cPXTVrlFOVzHKs3ryKqrhSa5KXxQff228bIxjPpUl/ULCbdjVUM0wyI0qB79kICAP1o5RWXMyvLedw6ulaBEHPEA1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 13:27:02 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 13:27:02 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Arnd Bergmann <arnd@arndb.de>, Rohit Agarwal <rohiagar@chromium.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lubart,
 Vitaly" <vitaly.lubart@intel.com>, "Usyskin, Alexander"
	<alexander.usyskin@intel.com>
Subject: RE: [RFC] Order 4 allocation failures in the MEI client driver
Thread-Topic: [RFC] Order 4 allocation failures in the MEI client driver
Thread-Index: AQHa7V087DCPK9soEEeGNq7wh9SvYLIumSEAgAKfx4CAAGPmAIAAAN0g
Date: Thu, 22 Aug 2024 13:27:02 +0000
Message-ID: <PH7PR11MB76050864E8DC9F7389314BF2E58F2@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240813084542.2921300-1-rohiagar@chromium.org>
 <75f758e5-a26f-4f41-8009-288ca2a4d182@app.fastmail.com>
 <4d6f3331-5a9c-46f2-8e27-3484ba6f6eab@chromium.org>
 <25e56199-7af1-4235-8973-cbc351325b8c@app.fastmail.com>
In-Reply-To: <25e56199-7af1-4235-8973-cbc351325b8c@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|PH7PR11MB6722:EE_
x-ms-office365-filtering-correlation-id: 571a6ab6-1540-46b3-9375-08dcc2ae1b85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GWFTh5UKAhurDTYUdwuIbRFmqE2ZnsohxKGHAOWy/dCRn3GsBqCLTUkpBIJ3?=
 =?us-ascii?Q?ggAe9PppJ0C3wGsDo29KWp6v3W69hBo+xgEJIZUruONRZVg5ARmKUtXw8bie?=
 =?us-ascii?Q?VNQlt0N07x/D9RSQSGHt0QpWU+K8yiD6mns3zDXepHv6RrHwaMUcn4Oxjrnb?=
 =?us-ascii?Q?GHHPU0DXao3/ABuRhZAiD4XTzuebgf+Pd9/h6XBnbEQv0mB1NgL1CEjmIKDE?=
 =?us-ascii?Q?6Ac1MGtLeJULDCrYdl7xx6dGIg+YW/H+U846uR8xGfHAkEqeqo4GmDfeXEOM?=
 =?us-ascii?Q?x8J2NKzvLcsG02i117MJRKOfT1J0/v5gMyUO1GC/wdHfd2ISacHYuIe/rm6W?=
 =?us-ascii?Q?oXIegwBPV8m/sX4jF1cOPMu8MbZVF7nCvcHsRjUIdrE71SfeZ0r6IP2mzfB7?=
 =?us-ascii?Q?fP6CbLyXPvkTzq0bGMEpz6qfWa0UUSghpvwoOWIlefUxU61RI5XjF4XYm4Ho?=
 =?us-ascii?Q?WCdyxuNr8TfLHJrNDJ1KoLLyj+sLqnKtC1rsXW7UhLhhPTR087XqHu2amqVI?=
 =?us-ascii?Q?y09n23P9mYUkr3pLJG/eGsdnTSrPmCrcDwzlRYoELPXizON198tdDujJ6AnP?=
 =?us-ascii?Q?qWfODIUVsY4fauqWy9ItvF6FSd71f7Y914Jq/BWHl2oxa9E8+qQ4HBJ2Ta/l?=
 =?us-ascii?Q?e0dYpRI2e0a+D3gOH5ruUieHq3lX3Xq+QI8u7H0J+QcF0B3W+4oav1JNH3Ke?=
 =?us-ascii?Q?hK57KTu8URw9x/W235yZrg3XpdTZzMX7sFDhECJTIDwQKqrfbXnTsDQbFWfN?=
 =?us-ascii?Q?bMaXmgb8sPOb+lbRGenF6vDktlIFA67Zb50g9M6WReH5zIIVIFrX9welsFls?=
 =?us-ascii?Q?0VHjUS2TMXP4pFIFUIoZzO7DFGCyiqszT+eroedTWfVKXeKsArbIa0GbOQtC?=
 =?us-ascii?Q?k3czhxnhs13PFN1XDBaY3kKyAV/jhW+hIYZ+9iW9ic4mHmObNwZDZxMnRO8f?=
 =?us-ascii?Q?NODjt5CtZE58Ce+FhpmNRmDen6E2BOluCm1lWhkN09aWTiiqajDiAeRwbTBu?=
 =?us-ascii?Q?NH2NGShw2j/DVcSSY4w6UziA4OOf/DxpsYZywqNz0pTRvevshUqHFyf/41Lf?=
 =?us-ascii?Q?miDF057t9wouIE4QydgLKqG4MYkBgGpLoSEMWo80n5vLqCFdbhhfJSqXIm+9?=
 =?us-ascii?Q?SyOMG5KSWSJGA3qLkrvph120ljcW2yzCT1NgIWfke7/dlGxfkPBviIywFkIB?=
 =?us-ascii?Q?z5fMXF1MXugufsChi6r/rCcygq+UxfZ+V0ggBRn19E9kIBJoH9k+9C1KY9jR?=
 =?us-ascii?Q?mxn6e50ptQ2KJvJI567tSmsrx6dFwBMl2KrdpZ+7Kls8tBiM+6WBHpYWmxx/?=
 =?us-ascii?Q?bg5/0gP7cjvLV22VAxcdws15WAJnJCkuFb/1duJOvhj7c4su/8FL6GVvJB9A?=
 =?us-ascii?Q?G0z74xM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?haYaSSSOaZo7l3jxCa3w8LmMZNCpZXMZ+gZpN6eZQ+au+NH3JX5BXlqODFfB?=
 =?us-ascii?Q?wWXuZIt9SkhUubXN5LTSO9j7reuArxMZmAFkDDb1Q+7rv0ryCueNLZwVE4Gj?=
 =?us-ascii?Q?iEX0iSJcsGFQzIcgKulktPYEc59p+17Rq8CLm70jSsngo01pkNJv/dZHuIhG?=
 =?us-ascii?Q?btijVJSk6lwgZxyRui86pUWEySIpSrbZzcL09TKfXI+eOcYVWbYZ1w1V/Awv?=
 =?us-ascii?Q?YowvuXVycEMysndZAmpKQL8xCnoQTWPqHpxo06IP/TuIbu77b7WCzEiNrQVe?=
 =?us-ascii?Q?uWFbUad9ZPABJqEjb+iFnPRLrh0cxw85ZX1qmuEeysz0NBlO5Yja8djvvH+x?=
 =?us-ascii?Q?I/GkjHVIwAnGcJ4XG8Nk+qZ+uUWQyGnUT+M0FBVSGcBiusEFmPc/L0xgcECg?=
 =?us-ascii?Q?caDV9il3vQAvO+Cz7Fp/S2pjJK4e9q36jvJRI3SCPC7Up0du+JSxQGnnIQ9D?=
 =?us-ascii?Q?ENxVLV/UCEadBnclIs6GrEK3CDJPpXrOGscovXx4y7T3Jy64OTo3TPxq39BN?=
 =?us-ascii?Q?7weiIgvwOQp6N7UU29RCBtjO1/qetkZ0dGKhJ+n8WVhMx77eBEoALn/E5mnK?=
 =?us-ascii?Q?hpHzad/JV5I3LiF0QgcXHQqVYRHy1HKluATFbC4KiSlV3lY2cBrgM6dBd1pn?=
 =?us-ascii?Q?vFCTyhBJhaShFiW6UQ720N1usT0xsQpMsHz7zyu9Sv/tHJV+YyjP+V5V2Ohh?=
 =?us-ascii?Q?rNK7W+owSwgWq1i+6sXv3x66m01mKSPwiVi8Tn8XIXPdQVRH8Wg56P4AOtjb?=
 =?us-ascii?Q?69KqjGdTegZD7MZOpQxFDHRWWfv+9xNrUvwguM098uXs404nB2UDxJO6pmXH?=
 =?us-ascii?Q?qXoQETZaKVvPKya3d8k71ZzojwsUK58RRadV/aSKBNRPSuxRKSvDIykayD6L?=
 =?us-ascii?Q?yM3O1A00+fxvm8bb0iutRhIgTvIAcx9RZoa7s/vd1slGrVjn6y3zJ4T2sRmZ?=
 =?us-ascii?Q?8RGZcDhWwRpn5JJt0Apeccdk3acI45G7occSKKdZzt/p6mOjWsDGvmcvGGf1?=
 =?us-ascii?Q?C1cj74pShIm6+pQZspfoe546yYKTPKQyF2u4xbhTM2YGIsgWqCqhdFpim+f+?=
 =?us-ascii?Q?DRuIzv+uVektob4LOvhg9YeDOnCXhWN2sw121L1laIXvbLlM8BRXcScxLdsZ?=
 =?us-ascii?Q?esU3sm0KepvqbtqtmKQ0SsUo5qlSeGPQeuXRWQEjW6yFKjQlOh1XUCQFYSai?=
 =?us-ascii?Q?nZZDxEc0xe3dbFCCqju7GhFwxOK+kw2mNc3dHWtAv+LN1UI8sdyZplsNSM5x?=
 =?us-ascii?Q?7ppBNlPYc8YkakhDwMhJ7/rC70xZOTjjXkrey7vpv+siKkXtXHUKmqBlfnja?=
 =?us-ascii?Q?XdmnRB7zPt2B5I+kAHdiB4v0VZINy7fRX8fANKH/e9rQALr5+7ygci+BfRVV?=
 =?us-ascii?Q?x1yse9pUApLPSXEIAZIxAHPpEhtNgWgRwcq5uQDUabtsvQ9STp2Ms6wU3hlo?=
 =?us-ascii?Q?drnypCiqDX5+k3pHfZuxP08XuHdA0mp3naAg5+UsZtUX6wywke1w5Lv27tOT?=
 =?us-ascii?Q?TPePUGyklpF8urxaSUcCJ29arwSecgOIdHajPFgBrZ2yxKAXZGu0/Gt6KEOu?=
 =?us-ascii?Q?6vVT02q5VGvAkmpzM2rklbm0ZWHrNtJn3pgRdQQx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571a6ab6-1540-46b3-9375-08dcc2ae1b85
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 13:27:02.1432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qW7Nmmz7lf6Yu7y43H3MgLS4yPdEnCpgFb7lNQqRFMcCyCCZ6DKfNLsHLzZVdexjnISy3omPOiXf+ZbjyfQ7uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6722
X-OriginatorOrg: intel.com

>=20
> On Wed, Aug 21, 2024, at 05:20, Rohit Agarwal wrote:
> > On 19/08/24 6:45 PM, Arnd Bergmann wrote:
> >> On Tue, Aug 13, 2024, at 10:45, Rohit Agarwal wrote:
> >>
> >> What is the call chain you see in the kernel messages? Is it always
> >> the same?
> > Yes the call stack is same everytime. This is the call stack
> >
> > <4>[ 2019.101352] dump_stack_lvl+0x69/0xa0 <4>[ 2019.101359]
> > warn_alloc+0x10d/0x180 <4>[ 2019.101363]
> > __alloc_pages_slowpath+0xe3d/0xe80
> > <4>[ 2019.101366] __alloc_pages+0x22f/0x2b0 <4>[ 2019.101369]
> > __kmalloc_large_node+0x9d/0x120 <4>[ 2019.101373] ?
> > mei_cl_alloc_cb+0x34/0xa0 <4>[ 2019.101377] ?
> > mei_cl_alloc_cb+0x74/0xa0 <4>[ 2019.101379] __kmalloc+0x86/0x130 <4>[
> > 2019.101382] mei_cl_alloc_cb+0x74/0xa0 <4>[ 2019.101385]
> > mei_cl_enqueue_ctrl_wr_cb+0x38/0x90
>=20
> Ok, so this might be a result of mei_cl_enqueue_ctrl_wr_cb() doing
>=20
>         /* for RX always allocate at least client's mtu */
>         if (length)
>                 length =3D max_t(size_t, length, mei_cl_mtu(cl));
>=20
> which was added in 3030dc056459 ("mei: add wrapper for queuing control
> commands."). All the callers seem to be passing a short "length" of just =
a few
> bytes, but this would always extend it to
> cl->me_cl->props.max_msg_length in mei_cl_mtu().
>=20
> Not sure where that part is set.

It's allocating maximum header for receiving buffer so it can accommodate a=
ny response.=20
Looks like this part can be optimized with pre allocated buffer pool.
>=20
> > <4>[ 2019.101388] mei_cl_read_start+0xb8/0x230 <4>[ 2019.101391]
> > __mei_cl_recv+0xd3/0x400 <4>[ 2019.101396] ?
> > __pfx_autoremove_wake_function+0x10/0x10
> > <4>[ 2019.101399] mei_pxp_receive_message+0x39/0x60 <4>[
> 2019.101402]
> > intel_pxp_tee_io_message+0x112/0x1e0
> > <4>[ 2019.101407] i915_pxp_ops_ioctl+0x536/0x6c0
>=20
> Curiously, I don't see any evidence of i915_pxp_ops_ioctl() ever making i=
t
> into mainline kernels, though I see some discussion about it on the maili=
ng
> lists [1]
>=20
> Do you see the same problem with a mainline kernel?
>=20
> The only reference I could find to the DRM_IOCTL_I915_PXP_OPS ioctl in
> userspace seems to be in
> https://chromium.googlesource.com/chromium/src/+/a4de986102a45e29c3
> ef596f22704bdca244c26c/media/gpu/vaapi/vaapi_wrapper.cc#2004

This is chrome only mei extension for DRM.=20
>=20
> >> Allocating 64KB of consecutive pages repeatedly is clearly a problem
> >> at runtime, but having a single allocation during probe time is not
> >> as bad.
> > What if the length of the message is greater than 64KB, wouldn't that
> > be an issue?
>=20
> That would make it an order-5 allocation.
>=20
>      Arnd
>=20
>=20
> [1] https://patchwork.kernel.org/project/intel-
> gfx/patch/20201114014537.25495-5-sean.z.huang@intel.com/#23762967

