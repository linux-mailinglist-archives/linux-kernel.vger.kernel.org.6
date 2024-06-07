Return-Path: <linux-kernel+bounces-205231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2269A8FF9BA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 03:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6571C22371
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBE7134B2;
	Fri,  7 Jun 2024 01:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R1j98dXf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C58710799;
	Fri,  7 Jun 2024 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717724893; cv=fail; b=qhxl2Y6/TZBFw5l3koI3O3Ov8OvPercgADhwSEcMccoSN3Wl/fu+SxAh1YzcSlH1fGzuldvLbEEa6FouuL5yP+6eAiIkad29xM1FMGHfRzy70qrq0Lv9U189QF3+LnCIeM5YBeh4Lz40+5b38gLxMUuh2U20MADUpUIDM8w6yHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717724893; c=relaxed/simple;
	bh=GmQQC1QA0O+xNU2qjgb/EngWpUFiuUZXIUpy3ixNWkA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dnX/3OlP3oQsdvEm0xxTrvP+jgtfiB6/1R20jKSC1pN+d2z8Q7UYNnDZkC7307KegYHAFLotpFj9R3lg/uQVRxCGmFswQ1BLGNtDuGIFQqzRB8+iBfwmWK78zRPif1XEPkJD4EYgzCkVmobl9Gi5vAh0oY8zolGs11J1QztoU9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R1j98dXf; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717724891; x=1749260891;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=GmQQC1QA0O+xNU2qjgb/EngWpUFiuUZXIUpy3ixNWkA=;
  b=R1j98dXfAM618rc4e+2iMPldEpXMhbuK0BdGWNmzAkDgbHospJXr7CS7
   g1DmzgoqSW+KxNDeA5imVmfci/5oqo6ZH9vOzW5oqE6G/KqKbt5f9uCSq
   SlU1bjz+lE5GVqWaecdzCgqt6iWRGtECLXvD8H15H8fN7kLgt6POxsQh4
   tU/ZSx8ffS6+EsCvhFCbvKMI0u9JJjDPY7AJoo2tZWCLdCmW00fu2lzMV
   Rc9ciSYXeEEWii398UG/E3SSfnYEvK+Vyjd90c14aUpBAYpQ+rOeqqUeJ
   /Yt20qK63/C9BSE/Uoh6SfUBKGBPKCriVEhtp3Clqwm4ddthRRSCMHyWV
   A==;
X-CSE-ConnectionGUID: lueU2Vv1R2Ck2N7IE9RDjA==
X-CSE-MsgGUID: cTEnfFp7SIeewhn/y8tA+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25083114"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="25083114"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 18:48:10 -0700
X-CSE-ConnectionGUID: 4+VqanNJRsm0/qaQ05NFlg==
X-CSE-MsgGUID: oz76Kw1aTuiKzqXDLOD26g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="61372307"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jun 2024 18:48:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 18:48:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 6 Jun 2024 18:48:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 18:48:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0Ydg6esXPx/0DKHjguF4P2OnDobHaoVXPp8CX6vfzqeWI6D4f/YZHfQjdVevtHQaZEDTMFzFW5ciA/rzXCOCmGt74tx/+7YHposLt7MQQ0bWBTZrtjZVA0kj7q10v6+80eJLfluS//X+cEPgpC91Y6gQWO2AhPyzakPGOGcnmAwcoQPpJXFVaWAcv/dbAYku/ZbddekiIzloa2vHfzNLjT3s0+jvzqErBnQcgQze0JsfNL7b2Map45YObMH2JbBl68I7FOoojqIfk/wah71ayymhv+7o81H8ax26t6X+dvEyhOFdduYps6LeuBuUrnr+1g/WX2novofBxJTxAWgaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJTDcVmUQbrn57AArZ1I5GJcbBGpJiT6+X1DlKoBvQk=;
 b=Fj7ZGjlksFL8k+rEGed/q2anvbALJVum9qR8ul7STyX6gOROeN/UASNBKr6FODu1gB3XkkTb0lrAz4EcNWfTk0BNf63V+a3daGXfospkH9OGnsKAs63ukoxpwDoy8GFZglDIdgPQRO0HF5xf+XtmpHwa1UGsn93VKTj/grNHxaxuvUN+hik5tmdaRIT/ukccIPy2hmgB49sDqrBDKb/omx+eQF/+smE6VR74yGm11c2sAaBJhEygpYeJPLd2VODdnMI6iHmSuBhlWL5fvdEDyuyeHbi7bs0wxFrjNxCyjMMv6irV4GQNXI4eRPQACOL3wUItMgzaNlTlsYhogmmckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
 by PH7PR11MB7662.namprd11.prod.outlook.com (2603:10b6:510:27d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 7 Jun
 2024 01:48:02 +0000
Received: from SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::c2dd:7cf8:6008:b690]) by SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::c2dd:7cf8:6008:b690%5]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 01:48:02 +0000
Date: Fri, 7 Jun 2024 09:47:52 +0800
From: kernel test robot <lkp@intel.com>
To: Artur Weber <aweber.kernel@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
	<rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
CC: <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>, "Broadcom
 internal kernel review list" <bcm-kernel-feedback-list@broadcom.com>,
	Stanislav Jakubek <stano.jakubek@gmail.com>,
	<~postmarketos/upstreaming@lists.sr.ht>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Artur Weber <aweber.kernel@gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: bcm-mobile: Split out nodes used by both
 BCM21664 and BCM23550
Message-ID: <ZmJmyJdrVx/+XSOi@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240605-bcm21664-common-v1-2-6386e9141eb6@gmail.com>
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3230:EE_|PH7PR11MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 7acff915-c389-4a0c-27e5-08dc8693dda5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mYr1XadjeWFH7UYlU42/6HltAoZ3a18z/9edgChZw4cEAEC7Vri39gU3ROk1?=
 =?us-ascii?Q?7K+qaHXvUrip243YhqwhTiDiy29s+tgA8Hfhakgc2CHhcFW4gMFbivVZ2xIm?=
 =?us-ascii?Q?5dsffGbcnR3tIcTNXDjcn1h+r3FLiMN4jjmrxpflZ6RSGYHVLg7GPxvYuSJi?=
 =?us-ascii?Q?iU8hJ5ovQrbceD1KfEnktZUJNKdyDjSRopfW2PPB0zDC9Y+t+tbjWJIrnMJ9?=
 =?us-ascii?Q?8DP6F9TnktnylcHqWfNv7zynx3W2rke5/vXxBsdnuL/OmtddGeUQsdtqldRW?=
 =?us-ascii?Q?/hWD6pgRfBsF977fX+4SCOAfWXNMI6OBHpzGDKOkAF3ppyy58AwOPGp5ch3x?=
 =?us-ascii?Q?/eXZt92UD05LB900pcAsswR0ua3hj2yECoxMTaFzA/HbGVp91QjRe/pNbVGG?=
 =?us-ascii?Q?Nx53XexbOC2VRAv2VPSnm9xMBF6uQ212TNlNvdl/DKONxBaCFA7I7T9+zmHp?=
 =?us-ascii?Q?Cqn4v7UUmjIfzXMTv1VaokeEqED+dT8w13zU9iLRWKb++xqL4zVNACDvSwFG?=
 =?us-ascii?Q?dtSafqWErIpIHOXcyx0eYQnJiK2moj4SLpVvOSA3m9qBVkVmM7+FqRA3khsL?=
 =?us-ascii?Q?qbWVADj1jp+a3fp8U8cCH/MJXC9PxyRIkOgwSRvXJSG4o2cl9jGEPXit8rIj?=
 =?us-ascii?Q?myieqI7i6FsM1o3qPutSN1Ne8mzvBvVooi49+qz3IHZvWqq2tkik81ONfB6O?=
 =?us-ascii?Q?Lm5PLfmiPVha9nt6EYSvHYJf2cInEQhJvWGWPfdbBXSCpUwIV20rwHimpzTW?=
 =?us-ascii?Q?T0xxr6e3c6tk6dKHc6+HrFl3+n7t4tDl7b8MF4QBL5K30f7Zr6NGydBSTKdO?=
 =?us-ascii?Q?yGOu5LGBKda34SHAiERaqcn2OdSbXn0Zmqe3zd8laCBbiXSf0xQo0a+ZJEY1?=
 =?us-ascii?Q?vHlXgTq8fP+sUkln6i8l75Nv9+TYIZXLdf3EFsFpX+B6C6ysYtT8tE7ZqaJG?=
 =?us-ascii?Q?POKZxXMmuGzzd6JHDQ3L6HhkJZm3SVVfs+hjwfYerNKIX3ktBGlKt33b2T1+?=
 =?us-ascii?Q?WobShqYO+xR0V4NHhKT+z+7DiX5DSMZbeLEyMg3j/y2WaoNpEvN9bdpjWpKW?=
 =?us-ascii?Q?s59r8t+cdqbJoDkZQ/ekH2/lTjtiT3+z1K79SWNdbDqgcB/i/+a9XJxiqQvL?=
 =?us-ascii?Q?Zw9CkB2jzCiH4pFpUFHMZohnaD0q4dkvdfaHFQBzvMCMffO63IkwSFr854BX?=
 =?us-ascii?Q?yr3FVseJ0V7eNUlUkawkFNUIh6RgO5FowGq0XI++yPsj4bXhJTM/wKxccf1J?=
 =?us-ascii?Q?IT2smsW+SjU4/3NSKSDHWYHeAA8an1LEJojDNtc70w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gQ6YTS9JDxIuYyC2jScnpJyv0nQFyKZeqsKuuumajCmvDADpSz5Y7kwaS4Xn?=
 =?us-ascii?Q?F6lOv1lsWManBw4jF6H9QvRxmBJBCv/tjj3ss8QmVqzllA8WB+2ycDbOJBcr?=
 =?us-ascii?Q?2box1YFM4y76emnmau3TqzPjcgscZSTCo2P6nsdigHR4TSN7UV341QvwSiQQ?=
 =?us-ascii?Q?kLU63wszzkDsTLsrpvHEGGTFLzkd/bPnb39jpCEva9/CGxN+0nWGbW3uM8qV?=
 =?us-ascii?Q?BVEqmLBlA/sTB7WKpeNgMjspCpiWmHX6SZUGb907W0Z3fwkG9Bn7bt8E8avi?=
 =?us-ascii?Q?9Wveu6ztDOmkb/gG6XSywSHiSi3L6EuoSzRFkGuKrVamCGUfBSe7VmguRlQH?=
 =?us-ascii?Q?bhB/wKY1IDhve2kVmgDaa07C4ZYXKBIlfYkQs4S+PRm98EMdgwYCzNwullO/?=
 =?us-ascii?Q?vWYm5jU58TdG7IoOkocqFNHIUqO+ijhavS9uLZoGOidXYSpabs4cvcCyC3n9?=
 =?us-ascii?Q?xD5ZL5H1A3/8UYI0oCJ/C9ilPxEg6GKtwyj8WOb0g3AU0hdehWKGE5b7pN5O?=
 =?us-ascii?Q?r1di3GE6jsISDhH3fZVnUX8d+4A2Kd6UyLAkV+IiErBCkHtHOqmuCVouieG2?=
 =?us-ascii?Q?Jl6daTPMyQZCIjVJV9aBpgKIh/CB+wTWaKCfw8JUSMeowazYlkh0/q+V9D2B?=
 =?us-ascii?Q?/wdSR5sK2wzVhPxsdTpgDd1CC2SEa0o8eJFMYtfcHHwJYI5V0wUibZ8HYQ0X?=
 =?us-ascii?Q?xDIvl8BEOyhcCpSBfxOghEu1jcviHknXEFICXoo9w1hU8Mi7HEPL+RAXYJTq?=
 =?us-ascii?Q?k/cBEWclWMv2t1dG5nOOjTZPWqULzD0IRiS67Y7W9shG4p5YgQgPdTpYrF1d?=
 =?us-ascii?Q?TjmSsC0vTsXsFHwU3YSzBqAxQel5bs2m7P4FOiejprBprIuLyN2M17G0po3a?=
 =?us-ascii?Q?ni3eN1SS4Sv6UeqawuFOzEMFPYY5KWHo9s8DvQQy3rLrNriJt6eGJAXI2YKo?=
 =?us-ascii?Q?osc1qE5sHYlvi7RG0FiwcW5n/2+xK2iWj9mpwvpiWP1fyGpxwfJuJr8luisS?=
 =?us-ascii?Q?A+dMezAPlY09tUAl4EOxx93CnY1dY6p8q3XkDwI4GhplCVjeUfc5PeWrCuSr?=
 =?us-ascii?Q?AZcjoHGNYlA/0qQpf8PO3SyxXReDBsK3jOdl3SurS4/rkuJESKzhEvsJdMvT?=
 =?us-ascii?Q?GIhFDtmKBo5fjH8aoq9m2570dtB1Owm6+xkOUg8wDADsvpoldghufizNUP6n?=
 =?us-ascii?Q?7V4ettRDK+9fdF/mhUJxGDKytYpr3y5V8m9XeucvPNKMvSyNxClk9d11G0uK?=
 =?us-ascii?Q?y7VKWNfopAgkAjC6FKm5w7wKL06Uh0v6kZuFRvzfMw9hDl0Q8/cAY9OEHls9?=
 =?us-ascii?Q?KIBvrr9DorYvIuo3vYXO1sEo3wB0EhXeX7iyO82myNU8G2zNx0j/gUdpNTLP?=
 =?us-ascii?Q?L/kByJTnzhG58hOkU79x5xB9O1dsE6RRWYfoQxqX8vzZnGDK3BajLuPXSDkK?=
 =?us-ascii?Q?IjmzZ6YN3ybfkYwY+HdtXAAW6Lzq6Atc2nCZXiC9p6CRtnf+wcI8sFwhprUk?=
 =?us-ascii?Q?cO9N4WVFwOp9128OU1RoPXX/NstDR3o3vt1rklNAoljB8mlKuJwE4Z0fFLId?=
 =?us-ascii?Q?xTJJM3MV04neBr09mb7D+ftEAhovKkTP0I5H5yoQ7hvaQuZ+EW7B7AwWPMO6?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acff915-c389-4a0c-27e5-08dc8693dda5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 01:48:01.9847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VO4cVKlm+hJpPH++yfxKyRjYn37x7k59wb1yNAim1PHSTbN8ktdR9S8nZwP2+y5xTaRLXNwIA0y37I3wTBBALQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7662
X-OriginatorOrg: intel.com

Hi Artur,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6]

url:    https://github.com/intel-lab-lkp/linux/commits/Artur-Weber/ARM-dts-broadcom-bcm21664-Move-chosen-node-into-bcm21664-garnet-DTS/20240605-144250
base:   a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
patch link:    https://lore.kernel.org/r/20240605-bcm21664-common-v1-2-6386e9141eb6%40gmail.com
patch subject: [PATCH 2/2] ARM: dts: bcm-mobile: Split out nodes used by both BCM21664 and BCM23550
:::::: branch date: 2 days ago
:::::: commit date: 2 days ago
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406070221.achg575g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202406070221.achg575g-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm/boot/dts/broadcom/bcm21664.dtsi:31.37-38.5: Warning (simple_bus_reg): /apps-bus@3e300000/interrupt-controller@1c00100: simple-bus unit address format error, expected "1c01000"

vim +/1c01000 +31 arch/arm/boot/dts/broadcom/bcm21664.dtsi

2eba905e860f8a arch/arm/boot/dts/bcm21664.dtsi          Markus Mayer 2014-03-06   5  
2eba905e860f8a arch/arm/boot/dts/bcm21664.dtsi          Markus Mayer 2014-03-06   6  / {
2eba905e860f8a arch/arm/boot/dts/bcm21664.dtsi          Markus Mayer 2014-03-06   7  	model = "BCM21664 SoC";
2eba905e860f8a arch/arm/boot/dts/bcm21664.dtsi          Markus Mayer 2014-03-06   8  	compatible = "brcm,bcm21664";
2eba905e860f8a arch/arm/boot/dts/bcm21664.dtsi          Markus Mayer 2014-03-06   9  	interrupt-parent = <&gic>;
2eba905e860f8a arch/arm/boot/dts/bcm21664.dtsi          Markus Mayer 2014-03-06  10  
1d3138b75e3af4 arch/arm/boot/dts/bcm21664.dtsi          Alex Elder   2014-06-30  11  	cpus {
1d3138b75e3af4 arch/arm/boot/dts/bcm21664.dtsi          Alex Elder   2014-06-30  12  		#address-cells = <1>;
1d3138b75e3af4 arch/arm/boot/dts/bcm21664.dtsi          Alex Elder   2014-06-30  13  		#size-cells = <0>;
1d3138b75e3af4 arch/arm/boot/dts/bcm21664.dtsi          Alex Elder   2014-06-30  14  
1d3138b75e3af4 arch/arm/boot/dts/bcm21664.dtsi          Alex Elder   2014-06-30  15  		cpu0: cpu@0 {
1d3138b75e3af4 arch/arm/boot/dts/bcm21664.dtsi          Alex Elder   2014-06-30  16  			device_type = "cpu";
1d3138b75e3af4 arch/arm/boot/dts/bcm21664.dtsi          Alex Elder   2014-06-30  17  			compatible = "arm,cortex-a9";
1d3138b75e3af4 arch/arm/boot/dts/bcm21664.dtsi          Alex Elder   2014-06-30  18  			reg = <0>;
1d3138b75e3af4 arch/arm/boot/dts/bcm21664.dtsi          Alex Elder   2014-06-30  19  		};
1d3138b75e3af4 arch/arm/boot/dts/bcm21664.dtsi          Alex Elder   2014-06-30  20  
1d3138b75e3af4 arch/arm/boot/dts/bcm21664.dtsi          Alex Elder   2014-06-30  21  		cpu1: cpu@1 {
1d3138b75e3af4 arch/arm/boot/dts/bcm21664.dtsi          Alex Elder   2014-06-30  22  			device_type = "cpu";
1d3138b75e3af4 arch/arm/boot/dts/bcm21664.dtsi          Alex Elder   2014-06-30  23  			compatible = "arm,cortex-a9";
f302b57ab0e5ff arch/arm/boot/dts/bcm21664.dtsi          Chris Brand  2016-04-28  24  			enable-method = "brcm,bcm11351-cpu-method";
84320e1a635fcf arch/arm/boot/dts/bcm21664.dtsi          Kapil Hali   2015-12-01  25  			secondary-boot-reg = <0x35004178>;
1d3138b75e3af4 arch/arm/boot/dts/bcm21664.dtsi          Alex Elder   2014-06-30  26  			reg = <1>;
1d3138b75e3af4 arch/arm/boot/dts/bcm21664.dtsi          Alex Elder   2014-06-30  27  		};
1d3138b75e3af4 arch/arm/boot/dts/bcm21664.dtsi          Alex Elder   2014-06-30  28  	};
1d3138b75e3af4 arch/arm/boot/dts/bcm21664.dtsi          Alex Elder   2014-06-30  29  
6a24a6d8543d0b arch/arm/boot/dts/broadcom/bcm21664.dtsi Artur Weber  2024-06-05  30  	apps: apps-bus@3e300000 {
6a24a6d8543d0b arch/arm/boot/dts/broadcom/bcm21664.dtsi Artur Weber  2024-06-05 @31  		gic: interrupt-controller@1c00100 {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


