Return-Path: <linux-kernel+bounces-364238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E1F99CE6F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141C8287751
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27B61AB6D4;
	Mon, 14 Oct 2024 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TcCkewzo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E221FE571
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917017; cv=fail; b=eA2eDmxkZrL6Weob1AOikIIklLw/oBY7QcEnJ2xhG1WHCmnJYq+u/4fWiEvUq1ru+Js2l2ePAF40TRFYwcBtElwtDYC/j6hm9j4GoJJf3dcc7ruHSKpTutMpQfg313TjoLUGSwXMvQDMc5jT4c8e/Yu0H2lY68fWxxtpdhomLTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917017; c=relaxed/simple;
	bh=LNf8jT7WbgvLPx9FOZYtwete6RdxGP/ysjcWpr07Gfc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EUIWKkl3a1jfRVF/FxsSyYVx7PEJ4Pf5FX/vS3S8BGSAIo+q2b9/ftgtH/cDg+OvWn9YsKdfQlCeg+GSjJjQAVHry//zdblqeLhIJkcElpMoNZ7V/U+5CSCdNt8jlsS5r4SgwupDDnoY1UACfwotPHF4GMZeRE/OwjNSJk5vSBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TcCkewzo; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728917016; x=1760453016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LNf8jT7WbgvLPx9FOZYtwete6RdxGP/ysjcWpr07Gfc=;
  b=TcCkewzoZ/11jYKYgAnvx5S3Vo0FZWcvo47203umsuiEPgO+B7NBlqN8
   WTLAF/w3w4z+65x1fz7X90ZSsQSiGSKhVnOi/vZE0eApD4UEekXDNfgX8
   2UrxyCKzg3tZGrdHAn2qGm/Tz/R/nR6Bron7oSdo7Q8l+h2Q7U/D4KIk/
   En1jS8hJVvsMo4VpDKk86oNM/VGCtX4I4BA9wbRZ4yAFRsK7+Rd++62B7
   HECtInEB7UKSDf4U4maKll5sUxtl1in2edk9StNZoyrMaJdXplIxABywL
   +Y/ObX2ZMQYgEX8SKqAUCZqYbO8yIOw8EOfgJDLvDCgkh2hqAD3SXiSUd
   Q==;
X-CSE-ConnectionGUID: MrJt6E5dQ5uOq4O5CS528g==
X-CSE-MsgGUID: 6TsYmK7+SuGP6W+81YggYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39393449"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39393449"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 07:43:36 -0700
X-CSE-ConnectionGUID: WCa/Otz8QWuS6tVlH3TVTA==
X-CSE-MsgGUID: iJcYox9QQSCeG4jeOjNVJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="100934537"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 07:43:35 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 07:43:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 07:43:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 07:43:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIafAcfoci8aSbLNNtG9gKrPHz8WJqIwyhxnaCfd9VwFjyfnELAgu0AbJnYkQT4Sc2LLP0slmWIbLhnsigwm6kU0KCGKRzhP+GADwf30pphPj/GGCGDu8Fuw9b6kC7leb4qzrNDhgnl2SuHvl6KHsOAo3qTlXhECrmSOjeXXuoeLA4+qER3Q7Kr1u0CDmYMi2jVI4CM3K/UG4zfBZpOyKaBnngC5+AnT+nZJTqNZKPzAg8cC+Mjlw6TAFZfxGcfz9T5+Ggl3MhU2KyfuE5/ydrCfKuQh22KQXqKZ1J9ITAmYJZvy56dZR+zHd6VXFXsxzuisCszk0+Tf+izWkhvXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNf8jT7WbgvLPx9FOZYtwete6RdxGP/ysjcWpr07Gfc=;
 b=VucMNl9hW4C3E87rrse3z8rEXfjP/q15Z1U4XFLXeN2NBiH1AMkTWAT0/M8o70BOwO0QUJXp5YlxpLU5AjTD3H24VxSd+FpLclhQpEXmfNBvXHtDZdrIPTy3zCvCSBA9lw6iAFeMIWSWLYSetgvnFqCTPXuhKWFpWLwl/FI3wSWr1Y9TAm3mx6DfpKsJo8ExaV8LR5sF+v7+Q5iEVAfsQ4WAwvGMGoxI1B/JT0M9Dmsx+Wm4LKldrhzVncfXbtTdsdjtFsNPj1EKkQHivRWIvLHeII3a/La6oC+6WwwcLkvyE1zsTcZWvj0+oiIt+9bsF2IpCnERNhyfMlH+HH+ExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6370.namprd11.prod.outlook.com (2603:10b6:208:3ae::8)
 by PH7PR11MB7661.namprd11.prod.outlook.com (2603:10b6:510:27b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 14:43:32 +0000
Received: from IA1PR11MB6370.namprd11.prod.outlook.com
 ([fe80::401f:1d9b:38a6:444d]) by IA1PR11MB6370.namprd11.prod.outlook.com
 ([fe80::401f:1d9b:38a6:444d%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 14:43:31 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Weil, Oren jer" <oren.jer.weil@intel.com>, Tomas Winkler
	<tomasw@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next] mei: use kvmalloc for read buffer
Thread-Topic: [char-misc-next] mei: use kvmalloc for read buffer
Thread-Index: AQHbHWhGw6lk2l+i/kCbXkW342aN97KEmAAAgAAeWGCAABIogIABauWAgAAKqICAABI2kA==
Date: Mon, 14 Oct 2024 14:43:31 +0000
Message-ID: <IA1PR11MB6370FC19D0985EF452C12156ED442@IA1PR11MB6370.namprd11.prod.outlook.com>
References: <20241013115314.1290051-1-alexander.usyskin@intel.com>
 <2024101343-proposal-gatherer-8c43@gregkh>
 <CY5PR11MB63665F42CE8EDCD3D48D2A27ED7B2@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2024101335-turbulent-smelting-00f2@gregkh>
 <CY5PR11MB636626DB1AB4507D847E21CEED442@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2024101439-vagrancy-cubicle-77e0@gregkh>
In-Reply-To: <2024101439-vagrancy-cubicle-77e0@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6370:EE_|PH7PR11MB7661:EE_
x-ms-office365-filtering-correlation-id: aca9c212-992f-4849-2959-08dcec5e9307
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eHUzV2E2ZHZIcGFqU0ZBeWRaaXlBOHJrSEtRMXNXYkM4VWFBWGkyeUp6SWtB?=
 =?utf-8?B?R3BrRE5mSC9rYnY4MUVpaHRrRGU4TktYQ0VHZTZrWHVQTk1RWkNQUXNrM29r?=
 =?utf-8?B?dHE1Mi9Jbm5YZFVCZ0pXT29nR0cvS2FqSFJReEgzRjhBR2ZVUG5lUnIzd3N1?=
 =?utf-8?B?NGt5dlJ2NlNMTU9ZOGdaQXJkV3p5NEZaMVVFWVR1dWsvekVXMVhwNU9KNUt6?=
 =?utf-8?B?NWNzZlFhbnFYOW9GWEJBWXZSSXlGeWtkU1F0bndQR1ZNUWxWWVU1VzRzSXpQ?=
 =?utf-8?B?cGtBbllma1k3em1RSmRIRVg2WG1XTDBNTXAwVEYrU2h3NE8xSVhEQmxldkdP?=
 =?utf-8?B?UUpJczBiQmpaUVpDOGtNMjR2TFZuUkcxWm9xT2xFR1NsWkJqakRCbkNQUW10?=
 =?utf-8?B?WW5IYTVlUUovNHNydXZqcVpQRXlGRXRKWlFMaEI1c3Buc2xodE9hMGh4cHZi?=
 =?utf-8?B?TU93Tk1YNW9GaVoydkEvN2lwQno2NzY4Smd2czh2dVlFM2F2M2R0M1hRNkdx?=
 =?utf-8?B?MjAzamNkTFRFTmdiLzVSekI5QXprZUZmVk9hd0ZWM3luTmJSTjQ4MVFLV3BW?=
 =?utf-8?B?aUs1clhLMTBCcXU5UXQwK0ZSb0VncnMvaWJMR2h5NHVoWmpZeUdvYndwMmZu?=
 =?utf-8?B?MjBaVTdZT0lTZzBzYThjQi9UT3F1aVgvd1pwc3FIUmQ2RkFES0NYVXhGVFFr?=
 =?utf-8?B?ekJvczBLSFdjVjQxWG1nWXlpajM0NkxESU4yNnhxSUlEcHRNditKeVFobGlv?=
 =?utf-8?B?d0d3Rm1zUXFwb2w3Z29JQ2pRTXdNV0VHeHJaS0NWdFFRbFJ3SHhIeUE3Rnow?=
 =?utf-8?B?ZzVFS2pCMzNjU2RFaGowVVFnKzlaOUxLWXVMNktOb0htRjMrWW9iYUJKYjU0?=
 =?utf-8?B?eEJHN2plVzEwWGw1WHJxUjl0TU8zbVJmYlNpYlJCWlRJZWYxVFc5bVFxeHhh?=
 =?utf-8?B?MGtqbVhub2tEK2JETFBaRXhkQUR0eVJySWd6YkJhVEFQWnE4Tk0reTE5L2Fz?=
 =?utf-8?B?VGhTVVVZZE5Oam1WazlqMlZHTEc1Vk94NUJtYmpmRjBET1E2dU1OejcrZG03?=
 =?utf-8?B?bUhCbUJZRFFNd25JTFdGNGNIelIxZDB0YzQwU3U4THNtNU9QcjN4aVpGclFM?=
 =?utf-8?B?TDVySWR6OGlTT3RqK2ZpNVF4QzQvOUVlY3ZaWDU0RVozMmlYM2R5bGhhWWF0?=
 =?utf-8?B?SjZxQUp6TkFsZHptQ0UyYld2QXBJMEl3MzVZYjVyL2NlRFRYT2ZhL2lEYlJL?=
 =?utf-8?B?ZTV3cGdZRkZ3c2lLWHBXOTJWL204TERQYXMwcVRnZFlwNTZaQnVPTlgvVlY3?=
 =?utf-8?B?UG45dzlrT29hN2RjcG11T2NWaFBqT1lwbWJ5RFZXUGdhZ3BiSElabUs4cFda?=
 =?utf-8?B?dzdCYlNQSzNQNUVORVZKc1E1eSt0dXIwbzUrYmRpWTZCZmR0R2w1cDh5T0J0?=
 =?utf-8?B?akxHYzMyNFkrUFRvdjAzOFFuNUx4QmhTMVhyKzZ6akR0TzJTWkgwa1lDYjlJ?=
 =?utf-8?B?bUFGRktCTmZKNnVGZGhHWVlTay95ZU1oMExGZjFmN3hzWTFmU0ZFYW0xQVBm?=
 =?utf-8?B?MlA1TTE5MWZyQzNIMVAvOUp5U3A1am5FYzE2MnhEdE45SDBlRGhsa1BTMXpz?=
 =?utf-8?B?WFVZTkpEWVg1OVZYTXdEQWFXejltc00raFpFV3Q5ODgwWmxYSmZjeVY4cVNv?=
 =?utf-8?B?MEhtUHFGZHRubGJXTVNXblRsVzUwL0NHWC82MWFjMGQzL1BuZ283V3hrNUIr?=
 =?utf-8?B?K2ZFOUgyTEQyTmNieU1zSnFIN2thT0tBczZSNGtqblZMcGNyYVplZXRHdHgr?=
 =?utf-8?B?TjFHY2FndFoveklobXhMZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTUyYzNtSXc1QzdqTE9xOGVRbzRFT2M1NXJWUUgxK1p0bU5QdVR1SUJPcU13?=
 =?utf-8?B?QS80SVFrUVExWU5EUEp3ZjNkeml0YjNvTjF1ZDMyZGx5MFlqa2FaWTdQS0ZW?=
 =?utf-8?B?L1MzVzE0eWk5WmFpOGt4MlNUZ2krRFRZOE9pL2IxUzJQU2hpOERNUGNXMnVS?=
 =?utf-8?B?Z3h5aG4rN3JSanRGeEFGZmJ6UUhtRlVmeGtkS0lNOWVZNWx1ak9POTRxbURh?=
 =?utf-8?B?ZVRlWTExVllXTWFIZDhPSlRoMGcxc1V3ZWEyWVJOVDlaV1cwOGlEbXErbVFQ?=
 =?utf-8?B?ZXEwQkNuVHNwYTFaQ3RYUjA2T085QnNCSHVmSlhJNGlCMlIwWGZNQUdCVUlL?=
 =?utf-8?B?MHpITy9uZWc4NnZFWDRpMmx0Y2d3Qnl3L2l5aGplWGY5dFhwdDNSMFUxaFFO?=
 =?utf-8?B?RnYzQ2VIVURrVmtKN0xWQ0VWVHVzcjhyZUgwdHpuMEhUYXVlc004YTdxa2kv?=
 =?utf-8?B?WDVhMDB1dmYwNFg0d0NNREpMYnIrM0JLczNRNTdMeHgydm5LNCtIcmVGTEdQ?=
 =?utf-8?B?Mzl6TUNyOUVrYUtZWmtYVmk4MWZjUmgrRVpsK2lFaHN1VGZ3bmJYTEJVd3RW?=
 =?utf-8?B?cjF1ZEVWaktBcTJIcGIrT3VTdmpvZ0RSRTBGWEYrRjBKdUJURDZEYjVlVlNW?=
 =?utf-8?B?UTJNS1QvSHUvUmE3NFpkVVN3VjFKMTlMZCtIVE1ubENlVUVITGhyZjJSQi96?=
 =?utf-8?B?SW9HMXpXbUp4WHJtUlRVRlEraXNmeGVEU2xTR1FNRXp5MHdIMEZNZVg5OHpS?=
 =?utf-8?B?a2ZsR0phQWVVUEpMOU5oQkZ4T2RtbXc0eGlSeENMckxCZmY2Y1NQRFhvWmVl?=
 =?utf-8?B?STFuczZtM1RoQ2xwNWs3YzVMK0xDN09DN1FheFJhek41WHV1MXBtaHBPa012?=
 =?utf-8?B?MU9lL1NaSHczQkl4RUJ2K0Rrd0swdEdUMTVGK0pMTEw5LzZpRk5WL21DQ2do?=
 =?utf-8?B?eHRZUEZ1MnpuRHczY0dyY1Bua2t2b29jUVVTV29FL1cxTW9HVGxrYmtFZGE2?=
 =?utf-8?B?dlZzT3NPeklPcVhoamFCbmxtSDF4ZytSaHY0MlFEWHV3TmxJZi9DRy8xWVl0?=
 =?utf-8?B?RlhSVlBUbzNYNGhjUDdqclI0OS9nb2x3QlkxT090V2ZrUVcvZjdNN2g2R2pK?=
 =?utf-8?B?NGFXTDNvbkNYQWJOeTRHUnlVNHZhbVVLK3RYUGRNeVhxTzF5UG1NRDNLb0tL?=
 =?utf-8?B?R0k0Vm1yNUJ5aWlqVE5COFdQQzhIeUtURllsNmVCM21yamJFTzVvKy82aGNu?=
 =?utf-8?B?a09FREdMRmhWRC9iMkVwWGw1S2tCcXN5Z0V2MFNNR01yRFErTU43U3J4RmlL?=
 =?utf-8?B?RmpYeXI1ODEzNTNGVWQzQ1ZmQ1JLK2hLbUVlRUNJVmY0bkJuYkFBb3YyN3dn?=
 =?utf-8?B?RkF3aCtWQUVZNytQazJ1dWY1c21LdVl0R3ZrWUxFRmFwRUl5RS9QeFYwWEFo?=
 =?utf-8?B?Z0d6enJndmQ3dVNmS3N0bS94b2M5MzZGNEc2UXJzMHJveVF4eDlXYXlFT0Fy?=
 =?utf-8?B?RHZkcWswYkJiNy80VktudVhZSzhWUlZXSHRUVGQ4MWFmL25wKzRLUHQwVk4x?=
 =?utf-8?B?UnpKTWp3V0Z5N2s1eDFzWUs2TmZPQ2x0Q0g0ZUcrZ1pQUEcrUCtGTEozWk41?=
 =?utf-8?B?K1gvUXRjMU9ualhZdW9BWE5KTlNKd2xMMExjK1FYRTJCZ09SOEpqMlh2dFRI?=
 =?utf-8?B?YytRL250SlZqSHhXWjFpYnc5aHFZYjVaNGI3K3JaVUNCcVI4cGI3R1E5Rk81?=
 =?utf-8?B?aEFQU1ZzdGRWU2pzUEszUExOdzlQU0pKdVdScmxQTzVyRHhHNk0zR0grOGxZ?=
 =?utf-8?B?YjNUTVB3dUUvcnNqYmNPRWc4ZnBVbERRbFpCdlFVUmp6TWxEV1A5VUltbmY3?=
 =?utf-8?B?bFNXcVRPVjFaaS9LOUg4elZqaDJmakJGK0RHSE1TTG55ZTJON2QwSDRqdVhH?=
 =?utf-8?B?N3VHR05XU1hBUEZDVjdWK0JFT2pmUmtiZ0FhZ1NJYWZpQ0x0Mkh3NUFQOUVi?=
 =?utf-8?B?NjhFc280NUM4eWVobVZnUXNSQmozV1hzT1orVHR2QnRUd2xUb3BZaTJ2WkI4?=
 =?utf-8?B?RWlJTGphTnAzTTl5dkF5b014WThTdkF0R20xUElud3JpUDRCMVdNK0tROXI3?=
 =?utf-8?B?RTBQQ0Z4U0E3eGlid2ZkYWlpM2xMdHU1SEFxeXMzakVmcm12MTRmcFJ3dTZG?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca9c212-992f-4849-2959-08dcec5e9307
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 14:43:31.6991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WM9GjJtrnL8/lAtxc5Mi7CLYEaREhmcwT3rBLfenuHRXm5Bj5T/Sb9kCwsK5h9ORbXLQ1+CTZiiRf+B6g99R6hBfF6T1/bN46GHjhDtk+Mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7661
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEdyZWcgS3JvYWgtSGFydG1h
biA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAx
NCwgMjAyNCA0OjI1IFBNDQo+IFRvOiBVc3lza2luLCBBbGV4YW5kZXIgPGFsZXhhbmRlci51c3lz
a2luQGludGVsLmNvbT4NCj4gQ2M6IFdlaWwsIE9yZW4gamVyIDxvcmVuLmplci53ZWlsQGludGVs
LmNvbT47IFRvbWFzIFdpbmtsZXINCj4gPHRvbWFzd0BnbWFpbC5jb20+OyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbY2hhci1taXNjLW5leHRdIG1laTogdXNl
IGt2bWFsbG9jIGZvciByZWFkIGJ1ZmZlcg0KPiANCj4gT24gTW9uLCBPY3QgMTQsIDIwMjQgYXQg
MDE6MTU6NDlQTSArMDAwMCwgVXN5c2tpbiwgQWxleGFuZGVyIHdyb3RlOg0KPiA+ID4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3Jl
Z2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+ID4gPiBTZW50OiBTdW5kYXksIE9jdG9iZXIgMTMs
IDIwMjQgNjowOCBQTQ0KPiA+ID4gVG86IFVzeXNraW4sIEFsZXhhbmRlciA8YWxleGFuZGVyLnVz
eXNraW5AaW50ZWwuY29tPg0KPiA+ID4gQ2M6IFdlaWwsIE9yZW4gamVyIDxvcmVuLmplci53ZWls
QGludGVsLmNvbT47IFRvbWFzIFdpbmtsZXINCj4gPiA+IDx0b21hc3dAZ21haWwuY29tPjsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDogUmU6IFtjaGFyLW1pc2Mt
bmV4dF0gbWVpOiB1c2Uga3ZtYWxsb2MgZm9yIHJlYWQgYnVmZmVyDQo+ID4gPg0KPiA+ID4gT24g
U3VuLCBPY3QgMTMsIDIwMjQgYXQgMDI6MjI6MjdQTSArMDAwMCwgVXN5c2tpbiwgQWxleGFuZGVy
IHdyb3RlOg0KPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4g
RnJvbTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4g
PiA+ID4gPiBTZW50OiBTdW5kYXksIE9jdG9iZXIgMTMsIDIwMjQgMzoxNCBQTQ0KPiA+ID4gPiA+
IFRvOiBVc3lza2luLCBBbGV4YW5kZXIgPGFsZXhhbmRlci51c3lza2luQGludGVsLmNvbT4NCj4g
PiA+ID4gPiBDYzogV2VpbCwgT3JlbiBqZXIgPG9yZW4uamVyLndlaWxAaW50ZWwuY29tPjsgVG9t
YXMgV2lua2xlcg0KPiA+ID4gPiA+IDx0b21hc3dAZ21haWwuY29tPjsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbY2hhci1taXNjLW5leHRdIG1l
aTogdXNlIGt2bWFsbG9jIGZvciByZWFkIGJ1ZmZlcg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24g
U3VuLCBPY3QgMTMsIDIwMjQgYXQgMDI6NTM6MTRQTSArMDMwMCwgQWxleGFuZGVyIFVzeXNraW4g
d3JvdGU6DQo+ID4gPiA+ID4gPiBSZWFkIGJ1ZmZlciBpcyBhbGxvY2F0ZWQgYWNjb3JkaW5nIHRv
IG1heCBtZXNzYWdlIHNpemUsDQo+ID4gPiA+ID4gPiByZXBvcnRlZCBieSB0aGUgZmlybXdhcmUg
YW5kIG1heSByZWFjaCA2NEsgaW4gc3lzdGVtcw0KPiA+ID4gPiA+ID4gd2l0aCBweHAgY2xpZW50
Lg0KPiA+ID4gPiA+ID4gQ29udGlndW91cyA2NGsgYWxsb2NhdGlvbiBtYXkgZmFpbCB1bmRlciBt
ZW1vcnkgcHJlc3N1cmUuDQo+ID4gPiA+ID4gPiBSZWFkIGJ1ZmZlciBpcyB1c2VkIGFzIGluLWRy
aXZlciBtZXNzYWdlIHN0b3JhZ2UgYW5kDQo+ID4gPiA+ID4gPiBub3QgcmVxdWlyZWQgdG8gYmUg
Y29udGlndW91cy4NCj4gPiA+ID4gPiA+IFVzZSBrdm1hbGxvYyB0byBhbGxvdyBrZXJuZWwgdG8g
YWxsb2NhdGUgbm9uLWNvbnRpZ3VvdXMNCj4gPiA+ID4gPiA+IG1lbW9yeSBpbiB0aGlzIGNhc2Uu
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIFVzeXNr
aW4gPGFsZXhhbmRlci51c3lza2luQGludGVsLmNvbT4NCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4g
PiA+ID4gIGRyaXZlcnMvbWlzYy9tZWkvY2xpZW50LmMgfCA0ICsrLS0NCj4gPiA+ID4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gV2hhdCBhYm91dCB0aGlzIHRocmVhZDoNCj4gPiA+ID4gPiAJaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwODEzMDg0NTQyLjI5MjEzMDAtMS0NCj4gPiA+ID4gPiBy
b2hpYWdhckBjaHJvbWl1bS5vcmcvDQo+ID4NCj4gPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYWxsLzIwMjQwODEzMDg0NTQyLjI5MjEzMDAtMS0NCj4gcm9oaWFnYXJAY2hyb21pdW0ub3Jn
Lw0KPiANCj4gWWVzLCBpdCdzIGEgcHJvYmxlbSwgSSBkb24ndCB1bmRlcnN0YW5kLg0KPiANCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IE5vIGF0dHJpYnV0aW9uIGZvciB0aGUgcmVwb3J0ZXI/ICBEb2Vz
IGl0IHNvbHZlIHRoZWlyIHByb2JsZW0/DQo+ID4gPiA+ID4NCj4gPiA+ID4gVGhpcyBwYXRjaCBp
cyBhIHJlc3VsdCBmcm9tIG5vbi1wdWJsaWMgYnVnIHJlcG9ydCBvbiBDaHJvbWVPUy4NCj4gPiA+
DQo+ID4gPiBUaGVuIG1ha2UgdGhhdCBidWcgcmVwb3J0IHB1YmxpYyBhcyBpdCB3YXMgZGlzY3Vz
c2VkIGluIHB1YmxpYyBhbHJlYWR5IDopDQo+ID4gPg0KPiA+IFVuZm9ydHVuYXRlbHksIGl0IGlz
IG5vdCBteSBjYWxsLg0KPiA+IEZvciBub3csIEknbGwgYW5jaG9yIHRoaXMgb24gWzFdDQo+ID4N
Cj4gPiA+ID4gPiBBbHNvLCB3aGVyZSBpcyB0aGlzIG1lbW9yeSBwcmVzc3VyZSBjb21pbmcgZnJv
bSwgd2hhdCBpcyB0aGUgcm9vdA0KPiBjYXVzZQ0KPiA+ID4gPiA+IGFuZCB3aGF0IGNvbW1pdCBk
b2VzIHRoaXMgZml4PyAgU3RhYmxlIGJhY2twb3J0cyBuZWVkZWQ/ICBBbnl0aGluZw0KPiBlbHNl
Pw0KPiA+ID4gPiA+DQo+ID4gPiA+IFRoZSBDaHJvbWVPUyBpcyBleHRyZW1lbHkgc2hvcnQgb24g
bWVtb3J5IGJ5IGRlc2lnbiBhbmQgY2FuIHRyaWdnZXINCj4gPiA+ID4gdGhpcyBzaXR1YXRpb24g
dmVyeSBlYXNpbHkuDQo+ID4gPg0KPiA+ID4gU28gbm9ybWFsIGFsbG9jYXRpb25zIGFyZSBmYWls
aW5nPyAgVGhhdCBmZWVscyB3cm9uZywgd2hhdCBjYXVzZWQgdGhpcz8NCj4gPg0KPiA+IDY0SyBp
cyBvcmRlciA0IGFsbG9jYXRpb24gYW5kIG1heSBmYWlsIGFjY29yZGluZyB0byBbMV0uDQo+IA0K
PiBBbmQgd2hhdCBjaGFuZ2VkIHRvIGNhdXNlIHRoaXMgdG8gc3VkZGVubHkgYmUgNjRrPyAgQW5k
IHdoeSBjYW4ndCB3ZQ0KPiBhbGxvY2F0ZSA2NGsgYXQgdGhpcyBwb2ludCBpbiB0aW1lIG5vdz8N
Cj4gDQo+ID4gPiA+IEkgZG8gbm90IHRoaW5rIHRoYXQgdGhpcyBwYXRjaCBmaXhlcyBhbnkgY29t
bWl0IC0gdGhlIHByb2JsZW1hdGljIGNvZGUNCj4gZXhpc3RzDQo+ID4gPiA+IGZyb20gdGhlIGVh
cmxpZXN0IHZlcnNpb25zIG9mIHRoaXMgZHJpdmVyLg0KPiA+ID4gPiBBcyB0aGlzIHByb2JsZW0g
cmVwcm9kdWNlZCBvbmx5IG9uIENocm9tZU9TIEkgYmVsaWV2ZSB0aGF0IG5vIG5lZWQNCj4gPiA+
ID4gaW4gd2lkZSBiYWNrcG9ydCwgdGhlIENocm9tZU9TIGNhbiBjaGVycnktcGljayB0aGUgcGF0
Y2guDQo+ID4gPiA+IEZyb20geW91ciBleHBlcmllbmNlLCBpcyB0aGlzIHRoZSByaWdodCBzdHJh
dGVneT8NCj4gPiA+DQo+ID4gPiBOby4NCj4gPg0KPiA+IFN1cmUsIEknbGwgdXNlDQo+ID4gRml4
ZXM6IDMwMzBkYzA1NjQ1OSAoIm1laTogYWRkIHdyYXBwZXIgZm9yIHF1ZXVpbmcgY29udHJvbCBj
b21tYW5kcy4iKQ0KPiA+IHdoZXJlIHRoZSBmaXJzdCB0aW1lIHN1Y2ggYnVmZmVyIGFsbG9jYXRl
ZCBhbmQgYWRkIHN0YWJsZSBoZXJlIGluIHYyLg0KPiANCj4gU28gdGhlIHByb2JsZW0gaGFzIGJl
ZW4gdGhlcmUgZm9yIHllYXJzPyAgV2h5IGlzIGl0IGp1c3Qgbm93IHNob3dpbmcgdXA/DQo+IA0K
DQpJIHN1cHBvc2UgaXQgaXMgdGhlIGNvbWJpbmF0aW9uIG9mIHNvbWUgZmFpcmx5IG5ldyBGVyB0
aGF0IHJlcXVlc3RzIDY0SyBidWZmZXINCmZvciBjb250ZW50LXByb3RlY3Rpb24gY2FzZSwgdW5k
ZXJwb3dlcmVkIENocm9tZUJvb2sgYW5kIENocm9tZU9TIHJ1bm5pbmcNCmNvbnRlbnQtcHJvdGVj
dGlvbiBmbG93Lg0KQWxsIHRocmVlIGNvbmRpdGlvbnMgc2hvdWxkIGJlIG1ldCB0byB0cmlnZ2Vy
IHRoaXMgZmFpbHVyZS4NCg0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0KDQotIC0gDQpUaGFu
a3MsDQpTYXNoYQ0KDQoNCg==

