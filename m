Return-Path: <linux-kernel+bounces-292542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C499570AC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60651F236CD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9AA175D5D;
	Mon, 19 Aug 2024 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnsjS7ap"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56744965B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086019; cv=fail; b=ha+D7K576hZ8CU1srhihCt+M+Ygw6k8cLC0RiNG7hO8RSRQbUZrDV88pvQoBdKw+hLy75nezkqiM1ao2ivgFANzluP0M3dvt/Q8EIZVTJltdqiOvFiYB5iwduYPybfEMwLxI1TMaDhvyM5gHqC7VCX/RuMMcMaGQWs3iIaHZel8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086019; c=relaxed/simple;
	bh=rOgDI9pc7JpMe95IpItvVwMfEz/RlS8tIPC6/KXAM5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LtlYQpIz8k9Xef2JD7F8AwJgxnqHKdyvzqMqfZeYFfUp5pnCdH4ejBam3eOUREWZHXrA7bEHnaZSw8nr7jxJh8sTK0uMSGHA8+8u0brWLG33xRUkz9XBiZx6YprDBdWG+3ZFa/gY+Yt9KtnxGuoqnVFIwLMBu9a1Y6D4TXQi+RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnsjS7ap; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724086018; x=1755622018;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rOgDI9pc7JpMe95IpItvVwMfEz/RlS8tIPC6/KXAM5I=;
  b=LnsjS7ap1Tap6eeAuYsOWndJKvDQ3X8naXbTsEUrOTqoRaTuBu4MtT/L
   J7HkUos8uJkkrzUpnUQO6Tpnmzcu67mHznoyc3n8KjNz52jciZsoEXhb2
   qBdTeFPt4BmKRKgFRtf2BJJOgfjiQU1lo+KFpv0AsIUVMPwu54uMBaimf
   XxhjAUauil4KPR+gtW6D+slS5YNnNNKr70JH80RE4F63e1jatGEeP01mh
   NT+HTfEufO/RV/dNFa/AzMx617N3gfZZaU2CAbl4481NRrJUYRuLm6TWM
   aM/BNZ1EodrtEaP+twOVsyj7CycLg+WY/yLXcSpm2UguxencxWIarG1Yw
   g==;
X-CSE-ConnectionGUID: 5QUzAcFqSwm0FQXdTVt3tA==
X-CSE-MsgGUID: 7PepsrFeQS+CDpLXOeD3tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="32918769"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="32918769"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 09:46:57 -0700
X-CSE-ConnectionGUID: esYlsFhARaCSEOFMHoGL+w==
X-CSE-MsgGUID: C2BSW901STKNNyErYPhTwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60090590"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 09:46:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 09:46:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 09:46:56 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 09:46:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U39hkhRpvFT+aAKGr1PeerMxdkQBPloeaO3q0jslo6cVTfKJ0zaPJwpNJwfeYEwvK/upufRAao1314EvWayJYVppYKQhLv4e1G6020YbOxODeRpXPwZ690+ni4xUfEbNlVMbrX4UY8veAyLInCu+7X501A0oBIUtjM8snKSgch5CMrCurghhoh2qKp7noXPyfyIAlCkD61nAjf3z1Pn6bJhQ5o4GMlakc1y8SoU2P3xi+VyYaBwlh5GVHMInpER+EAt8tKZQzpJuEcze6KRBnvsK3Pr0f0s/4txFIRs5imWMjGA0WkXsBTLaUeD5dKtloe7XKHq3akuuMhq/5XcVdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOgDI9pc7JpMe95IpItvVwMfEz/RlS8tIPC6/KXAM5I=;
 b=axx1o7bDu29GiFueZzErQnrLidZBNglXnO6ByMxirykSAm9QX1YBZfpCNIdmL4LTl+DVfelgLFOE9S0N8RAQ6zHWL0FVRtRniMwRZv9LUg30QOZxxYZ2SFjXoBeP9JYNL1/XUpzGrCc18XyAzKdxmOz3n8aIsA6oH6VMH9E1VN7tDoLsihQ4vFD9B4QnJERyyBD06ocQGpntVeMkcJsmktgKtKKKxC1fzi7ENMJiMdnH12+B1tmT27UzjgAuAaCtvDApblPcP2R7t/S+zWXS1p577ylfsiZe91ksjyA5AUIhynHeJqHo3reKRvdedbBuU/J0Y7q2hCBsZRIWPWqbwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by CO1PR11MB5201.namprd11.prod.outlook.com (2603:10b6:303:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 16:46:52 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 16:46:52 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Arnd Bergmann <arnd@arndb.de>, Rohit Agarwal <rohiagar@chromium.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Usyskin,
 Alexander" <alexander.usyskin@intel.com>, "Lubart, Vitaly"
	<vitaly.lubart@intel.com>
Subject: RE: [RFC] Order 4 allocation failures in the MEI client driver
Thread-Topic: [RFC] Order 4 allocation failures in the MEI client driver
Thread-Index: AQHa7V087DCPK9soEEeGNq7wh9SvYLIumSEAgAA6aKA=
Date: Mon, 19 Aug 2024 16:46:52 +0000
Message-ID: <PH7PR11MB7605E466FDE32774B0F2E426E58C2@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240813084542.2921300-1-rohiagar@chromium.org>
 <75f758e5-a26f-4f41-8009-288ca2a4d182@app.fastmail.com>
In-Reply-To: <75f758e5-a26f-4f41-8009-288ca2a4d182@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|CO1PR11MB5201:EE_
x-ms-office365-filtering-correlation-id: 0c0ba6a7-b21d-497d-0f4c-08dcc06e86f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?aYi/vjPFSzF5KGaiEOpoh9/T3hAOq62ovLKHMMLqljL33ulCKTddwwqt5Wv/?=
 =?us-ascii?Q?AHrSR9hu12fZl2Jl/eE9CE8vzkwgML05OUVDZ7ij7iilFG+DIZ8Nlwq+LeK0?=
 =?us-ascii?Q?NaZDCIxp/IazKY2RzS7HIl5MwTzb9yjSE+deN2z6NAO9T3YLBRA/WYXlwIXc?=
 =?us-ascii?Q?vUEuQblGigOAycGMDeknTKv2pIqCwODmLbGaA1VLFJATzxtNk6Ge6Y5mjNHP?=
 =?us-ascii?Q?yYOmvflu4Uu7DP1h+l7j4NGXs6XQpad8Lxv3idJPdjQf2V/OJ5mercSKXytI?=
 =?us-ascii?Q?6xoeRNcKUGKZPXb1Z489gjNyWsGi+SYp6EPg5tIcCfwd3QNw2MbWBlX65HyO?=
 =?us-ascii?Q?X6QapqVA+zOlccjE1CO6x8Y+2xuKky7CSWD3O0DEMuy+WPrMbi0Zgoz9wALX?=
 =?us-ascii?Q?c9CFYgM/u+IOPL0j2QsIvB11KoX4fIxgIdvzu0a0NnFiR8eLDepwdEUCp4O8?=
 =?us-ascii?Q?Tk6TZfzPbHJeIg+XZb8KJi9z/Ve7EyummDcQXw1tY3iph9pj8h4aESgWu5CM?=
 =?us-ascii?Q?SXx+aOEdmwcV5wTuytCJoQDZdrIhvIIqyGPmRR9BWX57pnxLABm8gX87z5dG?=
 =?us-ascii?Q?4YOs2dAlgiZ6JTBe4zeawzojyul/1dBLN6fct3St0Og3pWpm4axW+UU6MUFB?=
 =?us-ascii?Q?vcE5sYxJroe3yA10NDwc/OAms38u845F6/A2sXugWtYnAA0yopCEONheYwsR?=
 =?us-ascii?Q?Zscr1koXnDQmYz2eMeBc4Ta//fm0ixQsMdmi24nv7TbmgD3WuTxKqtinHUT0?=
 =?us-ascii?Q?K5p4NqGjKixKk8YSMykmecRbOP+BuVgcfNNMXle5rJIktv2XGNk3W//080dS?=
 =?us-ascii?Q?8BhtnPuc6SBI9dGD91uu4o7LNCc7eBGGFPUYqIzZcbjiKk+7dgsw5sehDQti?=
 =?us-ascii?Q?jtqEo0naq39DuSc2M9WqWCGak5MVcq0t5XlJdMvKEMEy/tx46PSqJ3meed/O?=
 =?us-ascii?Q?EdyWguwrlRCF5cIw43AqXrr6YGUwjSYhKspPNIV3OA0jgiryBPI1Yf11yfvj?=
 =?us-ascii?Q?ulp0Ku1wgJXb6FNLhIxawiDfC3Cx2WDjmoKyKy3lxjtzbKegD8M3sfBaSPdG?=
 =?us-ascii?Q?IiAcY78ZUurD8ZTDU3Aghcq6YLUfkyV7f9qOB/Yz//pldE1XKFwncacjYyPY?=
 =?us-ascii?Q?JEB38+hjbP74+fkUMNV/5VQBN9J0vnlgvntBmcLtVWI09xJesIxR4yAYMoc1?=
 =?us-ascii?Q?FfoDnY27XSe3sKzGWfGIFmxGn1SqzqF//3zQLPhYPDhsf3qg09S+qWllqjVB?=
 =?us-ascii?Q?RsOWxG4HZsf11EsCNjVBIIjaaEe3cKy1espTip2X5q9lljI9aJ8ZQ/4h5yxG?=
 =?us-ascii?Q?VF68Il8L2lg4yHJbfucFs+/R/GbKE5wswEzzsqF64HEOJjkkk2GHAdpN0hVX?=
 =?us-ascii?Q?Pa7cKse6FHxtZc42GOnU73poZEtAz3KR6NrrXg9+TArM0Lc6zA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fzgj2ofe5AI7XtizuY/EHrP4lwgn1/9rnAhCweKY754ZmNJf1jzPNHeDsRgM?=
 =?us-ascii?Q?UXB1MJvqTuxaaSuK7QvSwB80/dfgZ8yTlY9LaMhwgTcsFoU1KvIFjeCdrwxA?=
 =?us-ascii?Q?6lnSxVib6qwE8D2F/AjD31UitY6mHVdVNDzGx9wsQj3E7b4brl+6IzOCIlMv?=
 =?us-ascii?Q?IBf6lUbNNX61b0lFaZSGIxsG2gN9/E8bcLn+LO7u7jnGuajr7uPHYpUMqRAL?=
 =?us-ascii?Q?jUk9HzZiVqOJtWN1Gu347kRGx4bKMg23SQIwJL+2XuMLx8yIloRCCCAdqMGY?=
 =?us-ascii?Q?KH/wTnuywhH0vXb/h6wLUw4sfWKHpeXrZZ0h45WwP1CfBIvidBSlwxBEl2+t?=
 =?us-ascii?Q?0saVSisMwbXkp0UJzXvFW1w0mKBnxaeuVcs8X53Q/MoiX23KCnyrbnu4JVLF?=
 =?us-ascii?Q?bAocpSSreN6E06b3pWlo9+knOT9gBM8jaulFQDylO0QtuUP8laCKBgMbmFdM?=
 =?us-ascii?Q?cI7m0PcnyR0h/HzZ43QhdPPTmEebGz2bdD9l3MrJyLKhPDBRDVO68MWslYJj?=
 =?us-ascii?Q?QhJ6rxiHU7eQr4lW8JNGVFn0FEAwbxXvWmQ5GYjcEryte/KbYcikVCVRc59X?=
 =?us-ascii?Q?oCCwoHg9jnsZmr5ykhvEx0tsjYZRdVN1sndfy6vGjAYA3vf2KtrzWttFR7Gc?=
 =?us-ascii?Q?NGOLbLNb+EI9xnr09G16wG6T/W6wHhJZD/esdqJBeb+w8y7qBUSzrMw0yjPO?=
 =?us-ascii?Q?QVWKuHWephgko7fsA6tdIzZrjdvNNV9I5xesoH3MP7T8he2lXkznfjYlbLlU?=
 =?us-ascii?Q?t2LJDBCaYscWBayJmxfcXH6LsMY5mSr/gb+cFQSAa6BwJr3bm4wjRVw4hz/N?=
 =?us-ascii?Q?iV8D8vQnRUCCyx+rT/9rDLrS0KABdMDgv9whRYz4Jv06P3QwnaEqffWuEpG4?=
 =?us-ascii?Q?hfbFIZkJJAWLrmWqzQ87z9H7SXdBNV2NLENQhHey3PWW2xfIBrk1OYMuAIv0?=
 =?us-ascii?Q?3MRw+OyQ17cdm6Cs0kMb8jmx0YwjLxB5O+nHidQW6k+0rikW5T/SGi8/h7ax?=
 =?us-ascii?Q?9uDrtKPfZYgmDFKw3vz8aqR21umRMMDwrp3BGO5GJnX621JRt5XfDavataCz?=
 =?us-ascii?Q?U0JixCI07i8+ogRz/8GiaF70NPu/ZDZgmS7X9DJattz0hxvo4dzPEVgaTzmH?=
 =?us-ascii?Q?RhXr2XLdVaLUGOjPaU1rTjV/eJ4oCQAxoaHIpnqfP3FeXv30Dc5k7ZDB+cP/?=
 =?us-ascii?Q?/7zdh8SaBg39z1GaMolsjR1shMyJ6Z3oFyL96kifRht2vqwoDo0AaTH4FuZ2?=
 =?us-ascii?Q?o2YaYM2VMX9UYXZWrxtvCA7Z2YYAsKauFbgD/Wtm24ooO+5X2ZXOESZjFgFa?=
 =?us-ascii?Q?MVbvx7RZ9rGNxI1F27dN3XWhacRTTdjM8HCTZNz3moBpt4PZDBQdZzHVqoGS?=
 =?us-ascii?Q?q/3sNynjBgYoqIk8D6SV4LmxBHLbs/KpuveTaoLUQ8dW++Evo/WFg3J1UNWZ?=
 =?us-ascii?Q?1itjJ+dvNtNwEFLfupUyoMbumyWAwAhkC43gKODNCccWWgyJ0o0RHfYklpBY?=
 =?us-ascii?Q?aVkTX3gYWRMwX+fOpNoR/SSccWI0/biLXIVjM63agKk0lCIEmYJ821eRypOo?=
 =?us-ascii?Q?QU/MdGvaRH32+6b9HWVZiinvAPjUelctO4VK2yUz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0ba6a7-b21d-497d-0f4c-08dcc06e86f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 16:46:52.2459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hLAVMaA6hzkyMBNqDUfomHft8YDllHZbQATt97B7+e9JwjfsFidT4XV4vxsYT1EBi3V6CxBrAVD+ey6b9a/BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5201
X-OriginatorOrg: intel.com

> On Tue, Aug 13, 2024, at 10:45, Rohit Agarwal wrote:
> > Hi All,
> >
> > I am seeing an inconsistent allocation (kmalloc) failure in the mei
> > client driver [1] in chromebooks. The crash indicates the driver is
> > requesting for an order 4 allocation that is unavailable at that
> > particular snapshot of the system.
> >
> > I am new to this and do not know the history behind the roundup to
> > order
> > 4 [2]. According to the sources, order 4 allocations are not
> > guaranteed and should be avoided most of the time. And considering the
> > chromebooks limited memory, this may become an expected behavior.
>=20
> I don't see how that commit is related to the failure in mei_cl_alloc_cb(=
), that
> one only rounds the size up to a multiple of four bytes.
>=20
> What is the call chain you see in the kernel messages? Is it always the s=
ame?

>=20
> > Can we have more details on this as to why order 4 allocation is
> > required? Or can we have a lower order allocation request that can be
> > helpful for low memory platforms?

Do we have an log messages for that? Is that during video playback?

> >
> > Some solutions that I explored and weren't applicable/helpful here:
> > 1. using a vmalloc/kvmalloc instead of kmalloc (Due to DMA usage).
> > 2. using a scatter gather list (Would require a lot of rework in the
> > driver and still not sure if that would work as it would require
> > changes in the underlying layer as well) 3. retry mechanism (would
> > help in few instances only).
> > 4. allocating from the DMA pool?
>=20
> Those (1, 2 and 4) would have been my suggestions as well ;-) I don't thi=
nk 4
> helps on x86 machines though, since there is no CMA area (and there shoul=
d
> not need to be either).
>=20
> If this happens during runtime (after the system is alredy fully booted),
> another idea would be to move the allocation to boot time where it is ver=
y
> likely to succeed and just never free it again. Whether that works or not
> depends on the exact call chain.
>=20
> Allocating 64KB of consecutive pages repeatedly is clearly a problem at
> runtime, but having a single allocation during probe time is not as bad.

Would really helpful if some logs are available.

Thanks
Tomas



