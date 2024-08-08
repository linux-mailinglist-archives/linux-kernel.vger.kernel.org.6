Return-Path: <linux-kernel+bounces-280085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BC094C57F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1D0287400
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72018156C4B;
	Thu,  8 Aug 2024 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZKCw78c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798273398E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723147189; cv=fail; b=LlJHE2Ib63kMGiq1/9v8hkFkKq7KEWw7xq7/ejPhbMr1oMpHDBuNz1waE2YRULzPTAiFKFsn/UjzMN2I+IWG7gIjJiF3KV1yrncKa5ZhYgMCUjP+zKQknUUOKkfzc8pNyUfpAR+szrYjVSW9SY6UUuFHTDq2HNA7nJkXMebphNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723147189; c=relaxed/simple;
	bh=YwyvWS/gA8ZYjwU1x02IOIAnEffpfGjBYlLGiOoWeps=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RnuVWWbPLKeu66qsQUcw7AWYtEfdA9HmVkbwdR02wW3r2wStTRNk8imQUjdxDAAzueEIG39eNEnXUx2DiW6LNUfscb4bH+PQLNBe0LfaQnZVN2HdQg/iXE+B2LKQp3hx+3tGq0yDPpAhACLpQ1A8v+tJr0MVFAJBg0NQF0UraxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZKCw78c; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723147187; x=1754683187;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YwyvWS/gA8ZYjwU1x02IOIAnEffpfGjBYlLGiOoWeps=;
  b=AZKCw78ceNNF7a4eNU2vDQMGp5WQPvUX+ajz6Y5M+3URNI1+Rf8/mzrj
   O0SRYsV8Dfduzup6zBXCGcrUQGXONzipPMZChlNUNLdlsi/l38s5WD66Q
   KXHfHLYq81Qks5lg+Srt0ITz+GInXbkZYvM+0cB3484bfPgoej0dVX6k1
   MAmie61mqp7fFw5EkUKNisl1EOzCeIySKPfFZWzTLIcQWzz62D4twqKDB
   xIxCNRAlo9g4JsKZNwNvo5bHLiwta+HCknCZJmfe00uHA2eMG6lg8zl+t
   4CfeXyqJq+WX06SOjvERyxBJPjSAt2GKRUlemSNlAPzklPhDE0UfoRU7W
   g==;
X-CSE-ConnectionGUID: sW66TMhjSZSP8C+In5ZLKQ==
X-CSE-MsgGUID: zzhFPFJRTRqBuQn9RQNcvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38806913"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="38806913"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 12:59:46 -0700
X-CSE-ConnectionGUID: s3pS1UWuRTSUPtdJr5hFiQ==
X-CSE-MsgGUID: xhAso2ndSlany5BF402Fmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57298935"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 12:59:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 12:59:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 12:59:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 12:59:45 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 12:59:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGO1pSWS7797TJt8vAePTRqA/VxUAqjAY+XWP+h92VFslgTrjYxlBp/SNi25VIGyCmwR0Vdzl+23B9G79smpIc1ju/hKelOoiMmXvfO3GzUMPuurSpVLockmNUJN0KdeC+YCBp3Hlrzh64xn5QBShL+z2m0JXiFmeEMUiUP46e/5i6EzvBmW0V/8UkENFmFiT9skrTOhxZZTBCf67HcrQlObmbckIxVzXkJz6iCuXg1Tsovb0DzWhPi845Ay4R15QDMUnfkgQlh4KhwIw0QpBUSxH9USfpBfWS4Amza5l06w0HvyPG4EjIMDKLhKwxN7wf4N3q6jSioOXMEG4UZsDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZn0sBhAOb9jk8XZJ0JIVxy6dsvh50DOPUCJUPHN2MU=;
 b=dN9hXS3ueKQpVBO0cwZfjPxqEktYpNaen+CGdmSQNvXW8vEcYmLkxyrvnwlGowSZ99s+4DgC/VRCrRoHlkNR6NgtiiTzONDdY0xRysKL85a6oGUCv2LE87XlyxmK0WhXJ9fRB6NuhdOLv+OBshnqSPEV9j4XQQCi15nCv+VF4LtBWbI0jUkx8CZg8oLpcGQpxKj11dF5DFEGTYmmUklv3L4nJKHVA2p2mss0Yzuvh76S/DD9mG84c8kIkVg6iTuxQSWoN6o6Ge7W2CdRW3GPf061HtqbvYXRPDAeiMtMIwZ8X/cMtKTqROUBXJelNduxEcXLVDZ+9aZesSyWm/OLJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4933.namprd11.prod.outlook.com (2603:10b6:510:33::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 8 Aug
 2024 19:59:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Thu, 8 Aug 2024
 19:59:43 +0000
Date: Thu, 8 Aug 2024 12:59:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Dan Williams
	<dan.j.williams@intel.com>, Max Ramanouski <max8rr8@gmail.com>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>
CC: <max8rr8@gmail.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>, Dan
 Williams <dan.j.williams@intel.com>, <jhubbard@nvidia.com>,
	<apopple@nvidia.com>
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
Message-ID: <66b523ac448e2_c1448294ec@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230810100011.14552-1-max8rr8@gmail.com>
 <87le17yu5y.ffs@tglx>
 <66b4eb2a62f6_c1448294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <877ccryor7.ffs@tglx>
 <66b4f305eb227_c144829443@dwillia2-xfh.jf.intel.com.notmuch>
 <66b4f4a522508_c1448294f2@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpmyhvr.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87zfpmyhvr.ffs@tglx>
X-ClientProxiedBy: MW4PR04CA0160.namprd04.prod.outlook.com
 (2603:10b6:303:85::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4933:EE_
X-MS-Office365-Filtering-Correlation-Id: 545891a2-3090-4031-8a93-08dcb7e4a524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jaeyJcQ8Br7hMcWCEV3UY2WoDECbs7sO4fKQQSF/H0sYV4xLu/4+aG254+xu?=
 =?us-ascii?Q?fMcnkKFFD+Lx43uxkCgakZc9EdJAat8a8FdOEvNbtd8SAVcsxSzmcwk0W0Mm?=
 =?us-ascii?Q?0aA8hz3a57aCqp/vPZ9TZDxThKa36B5bxdHyBRHRu8z25IFRDlwTLjRnjhfB?=
 =?us-ascii?Q?uG2fTRq7Fdoo7uE/I+jLlSrMdpdBKlWD8fRuejFl+QLkcL/IdeLyb6dHUmsJ?=
 =?us-ascii?Q?F9JHnsyCeIr5NP1tUd+KF1olb+xIHIJSgUaBad+n6KepiDliuHC/ZF4qsFDJ?=
 =?us-ascii?Q?+9Ika6i0qFiu/muI/0OGWbuQDjxneFaByvA8/4/oyFeCBjmjgAno/bXeDOVo?=
 =?us-ascii?Q?3CmzjcyLmWWQscziYvGpF1DoXnSPaHn+KoMiiVc9z7V+gY1yODWkkkdX8LPu?=
 =?us-ascii?Q?FErzb+lVo2ImL9eYiDFyYFP+YaZ7wZowaEiF19CnAflh80XG2kME0RoFNf0+?=
 =?us-ascii?Q?ayJYCgEMez3EEMYMKA/GQ28SIf+TVjVsoD1suhxBO8UcCW2ix9FlHaV2qOAz?=
 =?us-ascii?Q?sVIvMuJFm6E2Tj6K3Q5pUUJBgN8jHxccHRjijW3j2JF4PqOrGR0XASttiq90?=
 =?us-ascii?Q?Hsh6n3TrQ6UIfY49PwEtK40SX90WtuotG92df8XzTxVj2nsqwWvk3mGCoRh2?=
 =?us-ascii?Q?zW30+d5bqOZ427sp0LkR7hJNwP1BWQezjwZ+ORQT1/M37qfwrcqNO30T0/HM?=
 =?us-ascii?Q?0mHZkjUiSn3DkF4LWl0NJWlfGptjxVe6NSQrC0prITQS8pw1ritBbwlfsBAZ?=
 =?us-ascii?Q?TvyrTEpaFN5G75xNNBDtLVYZ3iDz0ivRYcmjB5eDG0lAnnPsf40ZP+GA7EDA?=
 =?us-ascii?Q?06oghz0awxoUb3FeIFR4rz0jQUyQ60GDuRIcPqgQau9NJzzyIwFDIME4tLNF?=
 =?us-ascii?Q?AWZL7fjf43p6iA/BcRic+i8AY4myLKqzww2+w46S9zecj2hppkbS7tCw17Fq?=
 =?us-ascii?Q?NRTKhffR7aRpWYNPpkZqMGItmzC55NJf2PZ3f+KLVLIPEm4rsZommoU8INlu?=
 =?us-ascii?Q?VO2yyjZ/DXBmPuini5BnvzJFAqk17JW50nurMnzlGLeRGQ65pYxp/itKOF2z?=
 =?us-ascii?Q?1+28FVEm8t/deBcWS4AZUmatBeuAOYMslGglZghQOQrX0m4RZ3Sxz857GI3H?=
 =?us-ascii?Q?0dJsWhLoaJu1VnsYCjill+lX7bxwgtPu1wB9naHsburorNitDK2/ZeB2IUjt?=
 =?us-ascii?Q?ftdOfWRZrF7xdfNl0o08ytaNLgJghw2hnAULtcaUhe/MHyqHklN4DSYHwdlf?=
 =?us-ascii?Q?iek4v8pAXmWH7H/oSbtzAU8xtBQGIVCaJRJMzgy7UhRIdueUpTe6d+3lbV61?=
 =?us-ascii?Q?CiUusAWVCBTkmYTNL+IUd6DZ2a2ho1i0mfoDN9hjRViddA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LhxkUFOyha3VjoVlVeAsFv+v7AqBXnWpQtOTq1JLJ/8pM8p4b635se2G1f2W?=
 =?us-ascii?Q?g0CDEofdhPL7UxyLAwjod2SxslAwH/RhkImjJM7A9uqpWTQjRNbTEa8szpcO?=
 =?us-ascii?Q?UcIwLCMv1sNSOvHOIYHkNIZP3Z81Je4zuHwrhTJMwiN2zvIZiYIvY46Y/SAM?=
 =?us-ascii?Q?XpJFloYnvkGAgY4Vswp5Jc9GCSUl71L+R/QF2WyV2aNMdmRvp8tRYPz6zvNg?=
 =?us-ascii?Q?YaQwfHKACkoPgK/z5KCp9cgMRGlxIMg7wRZlGodV0vV4OeXaWPgb1tj0Iawu?=
 =?us-ascii?Q?MeYBIkGg3mYVAnFyIyzJaiSQdn6YpumjDr6a8Sf+ys9UNAVapamxXWJ7TPgP?=
 =?us-ascii?Q?gVktKaVfQQpwGLIzBaHzKaPKRV/76PRpfepLTrJypv8rvfLj0lRu4ID62DST?=
 =?us-ascii?Q?aVZIPj6zBaUf8zFD4819Xe9yFY7d1RFTYzVRMs3IEwKd3ncqtaupuY2N5RNo?=
 =?us-ascii?Q?BskXDGp74qis4vnjK0leMxODHO5/K/V83jvyeJgq2XH9FMjgiF4Vy0173DmX?=
 =?us-ascii?Q?6g5X2eRZO9/pfyAQ0LiYD+yLuM8Q8eklgVXL7zwXYRXa5tjkaQ2i21huDdlj?=
 =?us-ascii?Q?S0O1tnA3vzFxxmHdRnGJEaExMT6J/Ab9Z1F+0ANoD8ZkPkLly2YlJIPs1Mqk?=
 =?us-ascii?Q?hTknTis5/CPETfJduqXKVij5wOXFeIU589ULUBEfBGO9Bzy66I3v87kyNZ8I?=
 =?us-ascii?Q?+dRi1koGH3mc5bMYu2LxihNo+hLCar2K1+hQofUPgYGJ0Y6CCdJxm7KoWdSR?=
 =?us-ascii?Q?akMlliX89Y5blezU2CUbFwXx0eK9BNBZevXTBvWyBnQKreza6hB+zMzcVfZg?=
 =?us-ascii?Q?7SCbOEnAFsIFXFyGr/sDjqV2QSyar8SINO6T7AwE43SiJYyexLjiWT1N9CUo?=
 =?us-ascii?Q?+e4TuU4m2B0P2IhWpsOmnal4QSck2y9z8eehiR9JYEMSaM00ppntYV5YPKno?=
 =?us-ascii?Q?LK3oAx6quWg19BidorUJNgmR7leRPuAkRRHChIZj+8N8zzGvAis809jRf0Vt?=
 =?us-ascii?Q?Y3/ltnOby+j211QkTNjq8R9VQHOIEQdtP3DpFh3rwkYpDAaZDVKtQn3e+J9y?=
 =?us-ascii?Q?xp4L5DbDn/WxjgnE4Hsi/Mg4XTaJWe+PKxUuYQxs9qv1n48mQSmY00l9VmwX?=
 =?us-ascii?Q?Y7bIvqm4KexhwAH7275e0JlOCwcSPcrx++3tWoVKgNYyNb4VASo1qQ2Y/h6O?=
 =?us-ascii?Q?/YB4XwTwH1vuOeqGhcRu/iee5A8Ve2IgSJaiJWjZs2oAILz4ky9iQ88/+NyE?=
 =?us-ascii?Q?hDmU5aBUGvHeAb1R5hgA8e+pFpMfudjizX8yJBW7xcP2TKGeaLcVGzjIGK2G?=
 =?us-ascii?Q?rirKpcQAQZLV6hfJingR944xe3Epaq8xl9RnHADcWyvx37lhQX2Gpajxh7hb?=
 =?us-ascii?Q?M5o7cy9eS8P0Lgwwp41lyI/cGTAB8f+rqeOKBVYB/h+sNSCMnpbNmZ69y4PO?=
 =?us-ascii?Q?KhBSGJPV5ijuen0DrPhcoWnGg1cAtzfBFgIozz9oSxe/6ruMDf39jtaxgdsz?=
 =?us-ascii?Q?stNDxtm4YKBc770LmlZs/HvEZq0lHXbbi4D9y8Y6ZQy2f/3PMb/D4KU22qti?=
 =?us-ascii?Q?DEbZG6FtJtS5OBGFGqLbTyEMpUfWdppwzpuGdXM26lPHoGuelRv2KxtbGA1y?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 545891a2-3090-4031-8a93-08dcb7e4a524
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 19:59:43.2343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwPWU+4I53yh1w+HglczkKTDX4g35hDHkx34FDbYQbnzybpNPWY1B5YL4j6iP5buQXGid4nNGN1phGNfwrCrSj9pYo7P48eTNnJTvsQ57Ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4933
X-OriginatorOrg: intel.com

[ add Alistair and John ]

Thomas Gleixner wrote:
> On Thu, Aug 08 2024 at 09:39, Dan Williams wrote:
> > Dan Williams wrote:
> >> Apologies was trying to quickly reverse engineer how private memory
> >> might be different than typical memremap_pages(), but it is indeed the
> >> same in this aspect.
> >> 
> >> So the real difference is that the private memory case tries to
> >> allocate physical memory by searching for holes in the iomem_resource
> >> starting from U64_MAX. That might explain why only the private memory
> >> case is violating assumptions with respect to high_memory spilling into
> >> vmalloc space.
> >
> > Not U64_MAX, but it starts searching for free physical address space
> > starting at MAX_PHYSMEM_BITS, see gfr_start().
> 
> Wait. MAX_PHYSMEM_BITS is either 46 (4-level) or 52 (5-level), which is
> fully covered by the identity map space.
> 
> So even if the search starts from top of that space, how do we end up
> with high_memory > VMALLOC_START?
> 
> That does not make any sense at all

Max, or Alistair can you provide more details of how private memory spills over
into the VMALLOC space on these platforms?

I too would have thought that MAX_PHYSMEM_BITS protects against this?

