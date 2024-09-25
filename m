Return-Path: <linux-kernel+bounces-339535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C73098667F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8AE1C238BE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF4913D638;
	Wed, 25 Sep 2024 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgbXa4Mp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6D13A28B
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727289962; cv=fail; b=kmwPbftZ2sJ2F7njTwn5bn7RdQF3oNMVi5Agcw1aZpm8kf2VuNbfd9+6DQyhBYRhrHmOaN5UaaZbFkx/T15SZ8JS90BFrWY7Ix0RFrBQDK+DVhmrUQEUswyc+upoymcCGYVXjixejJjFJRLizcplrv7HvIyyolAh4x+zJz+rB3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727289962; c=relaxed/simple;
	bh=ZG1Qn2R05tszHxQ3uKYdmQscu3FXncfNa5e8E7szy6E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o0aVzxIZgi3a1jYee+Xv6/ic4shPXIaJtIHJt5/6FU1cavuOudPK0RjtvGJcUbKeKTV6OP+AEpSv/xE5FZxoyVJWbgUsCn4BmxILaVevKvgVDCvsqFPqX5P1ybm1SrA/vYeUr5Vp+9lsNMQlNPS1iT28qPfye2LAXjEEuJFavn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgbXa4Mp; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727289961; x=1758825961;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZG1Qn2R05tszHxQ3uKYdmQscu3FXncfNa5e8E7szy6E=;
  b=hgbXa4MpNIBIU5NPmo830BNdK4toJCWu8g6xs5DWOoaiyhR17fylA6gl
   k2bZJ/TU5CgNWkajCHfdqUJ/c8xMXjubjUhl4CHbCN5FgSJyNEMGPLslE
   9Sa6LUqqbnJjjEYIFGV/sL2ZXIkYesv5oPbilrEolkw40Jqax3w/iyc0G
   XPJC2NLvLqMOdwWWv+D8DJkIOwkaINXN8Ew24UTzFX9QnoHzztuy1Pygb
   a1nHg5a25EJivWEuSQqOB27p/RXC67oCss2yM/5g+cjxKfGQNxzYWXJ0h
   BHKcX9BWOLJSE0T13VqzI9HRn54gCY8ynepWu9yaSzwduvoUBnW9pBslD
   A==;
X-CSE-ConnectionGUID: ut3nc+0dTNqu+hchy4NYZQ==
X-CSE-MsgGUID: uvkjecvPQFWX4D7yjHyp3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="36940974"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="36940974"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 11:45:56 -0700
X-CSE-ConnectionGUID: fUxWzHtpQKC6zuZ5jvED3g==
X-CSE-MsgGUID: HynK7yw0QEWe0ezq5t5CcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="71879451"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 11:45:56 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 11:45:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 11:45:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 11:45:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 11:45:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 11:45:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykmjFxjeX9EuqqHJ3/hcXuuwKRAK3uzvROxNfS8eyTvVf0dGtNWfA7M/S6ZquN7cd0vHn8tlfXIRDeGBiELnY5Fi2/78KquBH5z0TS/lhe9KTFb0Bw4m9PmrNfGBVctnZr653dbmv9LcCD8vlF+XFsUil1bnlOnm1wz46/oAk1b6eDaemz8kT2q4Vhz0YWnkEKlEO8RoMJXSKt3zBXdhjWph3RgHPgEObdQE6lyHPJagLqxjP3EtsO1Ebtd7tGoLPtjCWCcP/Fls9DeHvhqPspgMA+DFqIEMf4FzPuCZ7dUYufY6UNX/F4rJ8W+eq4U2mvg2Y+vIh1kag1MU+CC1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1ohsB0nLcYiHrheilC36GfsbdYmzhRRayIA/f+u15c=;
 b=dz3ILJhY6ltle4sOmovQrdLF6+QmonM7Gj1902Yu1yYMLXalUfYL0242RiBcGOuiu6FgOJt8NGk3zZZoZTaxmtMg2feEn0kCQnk1iXqmpORuSAYpaAwGTQe7eVzWY9ELjdWulg736M+Rgc4EMw/COv0t1R//Qu+DKGca0byrvCpFlWpuqIXoiryh3Spw757fF9MPrAHFAJvTCnFbHNzJY5bEN5tRV9qhl/OVlaGYG3Znx2CmYAieck0sTCI2pdgPbFBSRUXVF3CuwrrRQw3WCMkAlGotFaGjjJw45neeTG2CRE1lcDIB3y25F7drYLBKHSy5njle2TaUb8e96HMtdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SA3PR11MB7555.namprd11.prod.outlook.com (2603:10b6:806:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 18:45:51 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 18:45:51 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "nphamcs@gmail.com"
	<nphamcs@gmail.com>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 4/8] mm: zswap: Refactor code to delete stored offsets
 in case of errors.
Thread-Topic: [PATCH v7 4/8] mm: zswap: Refactor code to delete stored offsets
 in case of errors.
Thread-Index: AQHbDh9/7v3nj1Rpsk6L/K4X0ZY53bJnUVKAgAAzI6CAACckAIAA4aYAgABMrXA=
Date: Wed, 25 Sep 2024 18:45:51 +0000
Message-ID: <SJ0PR11MB5678DAAAA98550A24099AEC8C9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-5-kanchana.p.sridhar@intel.com>
 <CAJD7tkbdRPKxOoVJMg5XdQuoByE1yuOjEENuM=wDnh_cOQZ7mA@mail.gmail.com>
 <SJ0PR11MB5678E588D9640C92E06AB0A8C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkbRewK-L07GPzX6YtBnw7zpA1NboBCEyszoT4=-PvpdYw@mail.gmail.com>
 <20240925141100.GC875661@cmpxchg.org>
In-Reply-To: <20240925141100.GC875661@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SA3PR11MB7555:EE_
x-ms-office365-filtering-correlation-id: 9476e3e6-13e8-4f15-822f-08dcdd92479d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?u6Ln/O07KZpkpfpB0gO3f0Rj0eN0p9IVWYI+L2bpZYE6pgm9+CXBl+A1kK5Q?=
 =?us-ascii?Q?nuuoGPoQIQ+rQkqruGyVyb3nTPG6FrtQ6CqpyWcvAio/LbZkukjC4Xw9xGhs?=
 =?us-ascii?Q?6Y8AK41PEZLlTQ4nJdLPwyc/qd/Fb38EhmH2ZWLwsmOsOf5VxqF8odCOorKb?=
 =?us-ascii?Q?xM4tW8E0phD/AgOe/quQLsNa+iBuPEZ6iq/P6ZzCq+PpMCk63/zKjUFPEpVK?=
 =?us-ascii?Q?N44LJpyx46gCBez67NSk6QWe52V8mgrIJY/O8hApCodWX9Cmty8LzH9I/5bA?=
 =?us-ascii?Q?2SBuhQpUFRYONb/bCBSnfbAVg+6LF0U8cbMh1shkuVElIJ2w9XVK2je1c6ok?=
 =?us-ascii?Q?FwPHaj7Q8yxiRGCqYGbDzVo5jIs3k+2PBe4rk1aFV0D/FBp7H+0EElbP5YZk?=
 =?us-ascii?Q?suvJE4N75DGySdeUu4KLVRNbYQ/+P/JkUzKxZvb1LuYBwL4XkUTDyU2rxYFZ?=
 =?us-ascii?Q?+mgylnpUCQJ9VENvqlO6NJQcCvSbrbSVkTcA7RUYOUivgZqWopeJ18Kmo7z2?=
 =?us-ascii?Q?NQCmSh6nYQsYxV2vgmcsGhKXN5exN7qMMgBtRaWTiEKS1j1hzvbzGHGNLjTv?=
 =?us-ascii?Q?VCwg3C5k1BFGI0XcrLolkAoWDFt6T8eltcVVdrIculakLX7qU6nfzy3qpKxk?=
 =?us-ascii?Q?OgYH9TrvmNQnWCpam0cBdgrh9d9Xdbq7Gp13nzvvsOwr/3Oexx3RQcx3ulqy?=
 =?us-ascii?Q?2EGP/b1nPoaui5dVw/RXOJlztLHxbi8gRx0wLm294XYyfiQf0Sd742SlyU39?=
 =?us-ascii?Q?hGHzFtpXHFNxOlYVdt2p01L4CVHMI1TfcPJCYVuBJHh/WvvdOBzPJqYN8zWK?=
 =?us-ascii?Q?dk2NtQ31WdUPkzLU/I/vs6WVkWR4Xr54gkmekVGx+Wkk4sI+Ukp0s0sUBJEf?=
 =?us-ascii?Q?NSy/VHQx+l5phihpb7Z8l+SkV7WiBhwcb+FJBTZPh2azZtpXV/+UangqaBb4?=
 =?us-ascii?Q?kB7xILh6FasihkEEAic9H0k3Hz8xenAhvHjxs658/10RB8mzFAYvZD/Wv0pT?=
 =?us-ascii?Q?zX/mBvGTLf787CvC30NiLqEjNHU/JX7jsGgUuD4Pa6faq95Ipw2YCKjyGaT/?=
 =?us-ascii?Q?jgVY09rrMlV8UdIYQ6AN5OIbkVV0w6VkwOEc6JXbHwhbOnrLRtcPaNxqfEcE?=
 =?us-ascii?Q?YR+zh3vApw22hmg3EoyUpeuc0R5RHgf5CdixSnno3rCL/cCrwtRYKy2HDVKj?=
 =?us-ascii?Q?T8N2klpmk2zHUk9aA93SO5sXT3k2H9VKPtHgScqSyM3dlLBsxh1VyQl/v6TA?=
 =?us-ascii?Q?+SEHLHObPoK/H6Cukbz0Dpkqo4DNFsFpdK2BluTuHprVDue7EKn/p5WECWp4?=
 =?us-ascii?Q?UvWAOaaS64LRv8bwDuCIAMclKwPhq3sn8EG3ImMYsgIpVeLdwKc/RjXDX7XG?=
 =?us-ascii?Q?URdjBBYAfxcMhJoiU38tSIMzs6HvSvHxe27zwl34aZIcm1OoIA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1HuvvdAyfIqVn5t4MCKyR7fqWZ9s20j1Hn5RjahpBCUau2yK0NP0LydNjDAf?=
 =?us-ascii?Q?MvMwboq7P5z9Q8bxy1//4kgwu490JmOSPXo7H1pqfX/b15b2vbC8EJziCa02?=
 =?us-ascii?Q?UWuEZr09IciDwQGHhXoy4XujH1cV6x51wKSFCbzFDK9Xej11w4ppHk5pJqwr?=
 =?us-ascii?Q?FuibpNStR6z6xLtuoSxPFMK+y7aVCu0b4fhSPx5M71YXyd/63XDzhDGjDZwc?=
 =?us-ascii?Q?+5/7f1JVub3Yt6FQ+z7w7o7t6CDQHVyNCwbKVX0j+9aY0n60v8CALKlquxpJ?=
 =?us-ascii?Q?7TRhjkjRR6pbNeuVUfPBVNCXw5bamxay5Uaae2vVnxWxzzNx0o4sTbk4lZkF?=
 =?us-ascii?Q?ly1/GwKN/K/Ho3ME93pd9rMeVRg4S3dh70x/DyHYQ28oYtOZBwrR0gkBBubw?=
 =?us-ascii?Q?DbntJ/QkEe0aFBA59kr0e3EnFbFpzQGnYy2ppHbGn5i/zrv5avzGXqCklXP8?=
 =?us-ascii?Q?ChzdV3iBHlcuHQ5pYXbEx/pG3a4NRUI0S2MWUDBwPMqI4LpHYsnEm9gJe2My?=
 =?us-ascii?Q?osfB8MS9R/ypOHN1tMkzWqdIW4Tm3+l4FR+Fic5KbJDIlhBJMKgPBLk2y3JI?=
 =?us-ascii?Q?6UF3GE4d6W81bNAUaJ1MxFO7AoHxwsKkqlLkEHW928yN6y45W7T3EEkuG0A2?=
 =?us-ascii?Q?mJIQPsGnER0o03qrQ7X9ZBEVsilply4jBZg7j4WKeBA21UvEnAePIbyuPjhI?=
 =?us-ascii?Q?QpOsa8HQ+GG7756aNu5SHtHZEsbo9tA52k981Z3G+rKKEMc/gq4yRx7nsgns?=
 =?us-ascii?Q?a44s1q0mLGc4Z7yd3lcI0XqRdgmSU7eU/lVaVRVaFggXitaeGy68dy0ojSH3?=
 =?us-ascii?Q?XdZMRjYpNn9s8bnGtHKArFBqSnsZLiyf+GEbk0xt2Ed6hUif2CUVCuJLVMIp?=
 =?us-ascii?Q?S24ItAJZQ0Bnozg9yVkekcJz/n2qM7vvZZF0vf/RofwJRZDbgIj2r5nToipJ?=
 =?us-ascii?Q?HfgZT3+qTkSfsXc3Er5TLk5E+Ln+3RPBxKs9/5pRjlg8LpeuNr8t158mU+CU?=
 =?us-ascii?Q?1OkF+hnq3XhK47B80g0bRc2WCr0kRdNI0lZI6FxcJBdQHw/4dSLYOKUV4m40?=
 =?us-ascii?Q?w0PZSvrK/F9XW95ZQd+cin3FoyeK0BWiETHB/rHN0JmqTEckfCMxuxoTbXPt?=
 =?us-ascii?Q?qGxXTFlVnAwGswOPC9Pa0qJkUUzW4+T9XxRY7RsKmyOR9cpZkOkKxpnd/kOP?=
 =?us-ascii?Q?i4dhljybwnx12IG5/nxebbR/EYmGYo9zWJfGNCAdkUbVJuDVV7mYPcSzFcdu?=
 =?us-ascii?Q?pHq3MFE8Lo5gGdLk5QxVtHgYbfhstwTEqDuCPTIyYgwy6HO9B4l5rqVSUTYg?=
 =?us-ascii?Q?L3dLMjINs+K+AfJXRdgZJV+/SH2DA5mWDgC6oQVyys/z3/rKfLQ3RqH6pp7f?=
 =?us-ascii?Q?SeUNm04HKTZgYIyBEydPU5QVOkeq/IAm6vbdczMeLKBBI4RVHxEG4be9RiRe?=
 =?us-ascii?Q?iZ/MT4IJshCqmeTDRYBjAHUpdi6rt2T0BX+5JZaTTaWzczL9nMLo+NhargE6?=
 =?us-ascii?Q?dFwWEPwX3AOtCtrmCG2WMs437etiJvSCfls2pngUvkLE0hp7qoJ8qd6tE2bJ?=
 =?us-ascii?Q?JIABDQ7Hvf+V44NVn4EckrFqHY17r2OWJ8DNjt//GCnVKvUM2CxOaTreJl+U?=
 =?us-ascii?Q?/A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9476e3e6-13e8-4f15-822f-08dcdd92479d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 18:45:51.6175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mEnVpbbdmLkTZludKWyWgtwIKwarEwKKQltoKg4L4F37uuVu7ynMrFU/wnZY7FkD4L6LADKXlNBcjTWFEFKzeSd0QKgwmsDTLRZH1r+kERI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7555
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Johannes Weiner <hannes@cmpxchg.org>
> Sent: Wednesday, September 25, 2024 7:11 AM
> To: Yosry Ahmed <yosryahmed@google.com>
> Cc: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>; linux-
> kernel@vger.kernel.org; linux-mm@kvack.org; nphamcs@gmail.com;
> chengming.zhou@linux.dev; usamaarif642@gmail.com;
> shakeel.butt@linux.dev; ryan.roberts@arm.com; Huang, Ying
> <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-foundation.org;
> Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> Subject: Re: [PATCH v7 4/8] mm: zswap: Refactor code to delete stored
> offsets in case of errors.
>=20
> On Tue, Sep 24, 2024 at 05:43:22PM -0700, Yosry Ahmed wrote:
> > What I meant is "zswap_tree_delete(struct xarray *tree, pgoff_t
> > offset)", and loop and call this  in zswap_store(). This would be
> > consistent on looping and calling zswap_store_page().
> >
> > But we can keep the helper as-is actually and just rename it to
> > zswap_tree_delete() and move the loop inside. No strong preference.
>=20
> Both helpers seem unnecesary.
>=20
> zswap_tree_store() is not called in a loop directly. It's called from
> zswap_store_page(), which is essentially what zswap_store() is now,
> and that was fine with the open-coded insert.
>=20
> zswap_tree_delete() just hides what's going on. zswap_store() has the
> for-loop to store the subpages, so it makes sense it has the for loop
> for unwinding on rejection as well. This makes it easier on the reader
> to match up attempt and unwind.
>=20
> Please just drop both.

Ok, sounds good.


