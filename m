Return-Path: <linux-kernel+bounces-270514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C67994413A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCC19B20CC9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58606DDDC;
	Thu,  1 Aug 2024 01:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ff8qBcRp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8540D79E5
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 01:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722476916; cv=fail; b=HMiJ1bOqQA7e5npCKyP1qNwFMR0lMwKBwaFtFrMYZln23Gy49HsplougvxMy2UjiAqrsg9Ny9LD0Mxhzi/bfUSUzGw24Rouz2vbBqMiNmDlmhCGa2fq+qoB27BI3c/gXEbqYz5aZTygmvEPX9JtHMWnFGF+iwGVBvaOmXz3/lEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722476916; c=relaxed/simple;
	bh=MbLoYQF7gdkk0OiByPBZD8rmEn3H60QKQ6sA46opV4s=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=HAUtnwLLQrgK0AYQ2whINbY3RAxI700LgR/EpUlhKbw6wFBwyG+ddYBT92Jv32mHKlARXSi9st1pAnpjlEPS0wIs44e9vpR/NYfuDd6B4vN41qWbpLgg92bcTEa9LF7wbqrwHTkvBA1ZtmMItHgx4jmo0m5OUNPf+/+907cSVuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ff8qBcRp; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722476915; x=1754012915;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MbLoYQF7gdkk0OiByPBZD8rmEn3H60QKQ6sA46opV4s=;
  b=Ff8qBcRpVDnA4JeCaSnc5n1GOVR1MS/IF1tzzXq7suwxH6HEjU+Z/8TQ
   ylZrBnkSsA3jObQZhvOeQqYWU23GUw9GdVSgZUJQzw46MG2m402/ZHlil
   mwh5O5SWQGH3zcsplsrBt9Q1r7NOXgzkITo/oUOYbO/R7BfizDDU3m72a
   K65CR+fAeTNFZrKjL37eAQxWfiU8X2jxw4kZM+v/h4eWG4pDlopsRho4k
   6U/lVWqdDcBilWeGtMKuuzEm56C/cUncBxwQCV85fboK72th30dGcCMSp
   XhF3iFGdHyhbd7jHec58sAO+FuVIH5FCk8HVk75PmK1kgtVMHiWpcjzVq
   A==;
X-CSE-ConnectionGUID: WvayQLtWQV+ATfYSGEJaqA==
X-CSE-MsgGUID: VmR+UPbVQZWfeP9PPcMPTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20520942"
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="20520942"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 18:48:34 -0700
X-CSE-ConnectionGUID: NCqVfXsfQm+uLTFuUPZP4Q==
X-CSE-MsgGUID: l1VmMHzdQqKoKNcKgrvD0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="78149127"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jul 2024 18:48:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 18:48:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 18:48:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 31 Jul 2024 18:48:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 18:48:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTulkVfupKZ4/vWx6wfu9wjxKLdSIiCINcvlhVmdzLLINmXcuPgsWp1/GJKX/OEsDnBY1lnvyle7lOUhZ3nIlps/6pnd+TVBnwxtxCyOUHKP4pibLRwvrQof2EZA7DB5FkVi+Rh8WlNoHqg5wYLM1ImpfL+BSOe/D1HsIg0gi7NWjJbyEfMjKNTd7XchXu9YNoRf5ovbSP+fOM0QP3X8KkijUbImEbXLuljjQiP+PgC35sbTKpFa3WxXBmwyr3Xyixdb1BoRHljFPRTzTblRPL2hGLJo0hlSkrod2OFH/APoKnvjcD1op+cRMmQYHNEDwtkkClJhlrRksospkSqulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qfkfhid3VZEVf+dm42E38O1WGq9Kp5mGzTJB7piSFkw=;
 b=ZCmwiZqaE5H31yQnUXgzpC7f58Klrtk+1DvbdpCvViAF0W33Dj6HGQu1hhHH5a7gvzuwtDHBCfL9U5xE3YKFCdN9MNU603F43F3eq/7EvRMtqz1zRrHWZksDoPdaxKsesD1Bifz1RMogX5+7RjiYsCh6E0Yd0bZXquAdQlnr72ks04kPROifz3fovcpVjEFRCoZiDPFg7ovbR5AGxeR/1X8BdMM+Q8AApXw2X0M6fbogCV3lMEarg1i6Wd370mD7BxSgWNUnzNpi3pvTx2zolfuTw96vT3CCZKv3toLGmOx2Hm4QIztRY3uN2e1YN2iOLoBRqh3kctGpLxFbntcD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MW5PR11MB5884.namprd11.prod.outlook.com (2603:10b6:303:1a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 01:48:30 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%3]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 01:48:29 +0000
Date: Thu, 1 Aug 2024 09:49:20 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <tglx@linutronix.de>
CC: <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
	<pengfei.xu@intel.com>
Subject: [Syzkaller & bisect] There is kernel BUG in __jump_label_patch in
 v6.11-rc1
Message-ID: <ZqrpoHTJZBA7TeGO@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MW5PR11MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: 0670556b-7baa-40da-c8e2-08dcb1cc0af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5BPqU9M62qcd3rsBiGipL6l9gufDxGSOZbycifmTlm55weDgvG8IsSAezrEL?=
 =?us-ascii?Q?2lcAbLJLlqhuxg95m/3RoL4cwYVpsDTWFw3uNSv+Ddte8QaFeCJAdzVPGMkh?=
 =?us-ascii?Q?4vprTA2YGso5B5uB/Dk8e9rhUcuFG52zl4N4HNi8nFf1rllM6LrCz7Q+DwsU?=
 =?us-ascii?Q?N7TGGHqZhK0KAYE6AlxlQ9ElYfKfF1gVr5PuGU8TqhTqEeXZn7AZZxBSrtth?=
 =?us-ascii?Q?CvQ/AFgglHaqnnFZMQKZ+tTmLGIxCv3ZB6C1McORbMJdov08OA/gY42l872v?=
 =?us-ascii?Q?yHf74ekfppNkxoj6QhtecvkM4P5sEhLvTP68bUutoYNn35n7Kr5xRZ+StPBn?=
 =?us-ascii?Q?bDv/bCjpEx7900DFM5xfypeuySMthITpcnae/Jue6kwtBDXiKtLF32aO1wzh?=
 =?us-ascii?Q?4eFWaw/EN1VOE9lV4iETEApeQR938R8yOcCJiYYD6HyDpVN7vi6rZS0AGEC6?=
 =?us-ascii?Q?dOh1jW1TRzXrLz9LWQrCrxrFTJV0u2NFaCI/sp+lYxxtx0vYZy1MWEpcbYkM?=
 =?us-ascii?Q?nPUpx6/7Ij0qLS1OsoFyjqn+uUMonYbSUvptKAcy6iaL6sd18QzjqRYKQj/p?=
 =?us-ascii?Q?0vHvRi/VAq8DmMKo4gbUJXph/NEaG/xtiHpxHt0LNn2xdN1LjBPiKyKpotBd?=
 =?us-ascii?Q?yz8nFm3sfGfFJ27v5yCOA8/JJO9ROk4RlbB4YKSvdLxMx25edkpXei6hqJXu?=
 =?us-ascii?Q?qVRmlxXMALLdaGmDzv+/6xfecQQp4atjl4Z2uEGknR7pz/awxwqo+9+nYdjx?=
 =?us-ascii?Q?abBoPePW8nmKLuuTyACKzbYvgFyyBT/TljmYJtWpUEnVJs0Vymb+jOZ5tMbT?=
 =?us-ascii?Q?VAyzgxLtzLW2g8kqV1hSC5q5p8FycA6AA06/lb/AK88UuukKls9u4zwWCzv+?=
 =?us-ascii?Q?auDQRm9ZttHBl7VWR5Tt+zhw2+Wi/cwyfyGAZ7mPL5ixLuAa2v5TCLxgTn7C?=
 =?us-ascii?Q?zhn/WqX55lZug+UxSeigCzOSL5EsLYARyFZcGe/vCMjlDX11mn+WPtQ+oIVu?=
 =?us-ascii?Q?PsM0uBgFaOSO3kOqIMFSx3KUQRuIXfAdAWwEPOAffTtFRIv/OnB58E5YbjdO?=
 =?us-ascii?Q?dSDGI2Wxjixy8O9CjGQGEvBXEk3ii/UBog7vHmZWWY4IpMYWy0Kt3C7Q0hvE?=
 =?us-ascii?Q?0m8oJjLpgCuFTu2QffouHCtPVmJ8YhmexKcFMYgvya0SqibkCwn1nQF7llNJ?=
 =?us-ascii?Q?Xoe7ImYCQFtlIy0U/+Utt7OTl4R5vrEBuXgy8AybQUkRyX/uNalrdid2S2g3?=
 =?us-ascii?Q?iC0f0Wvf//U2z4W27aPjvOlc/YViHw2dvF3Q7kQ9xLwiOi+xgkv6ndhCKJgu?=
 =?us-ascii?Q?yX8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dbo9o9NnpU8zy3HxY6ks9c6iHwYR2uKtZO9td6MPdJd5De4bjpxcNOQLJPmD?=
 =?us-ascii?Q?KJfETteYOh5SZ8suDDi50jpD+GtqvLaQ9bLwm7DoR8ujRJ/ZmPKe5kNtqV7/?=
 =?us-ascii?Q?oCbTVQ6k+t8XI836AQlLoy9E7iG4Rp7TJUXvnuHDWASE5/EcArAIK52BBbkm?=
 =?us-ascii?Q?IeL2cc6rztvE1Q7QkfJwc8x60wkKNJSfZL9+4z7n6unP6KEagQOc+KT0kNqB?=
 =?us-ascii?Q?VYqp7lFnri2IhcpuLmkM/Ui+RJhSRMwIri7AH27qRPrLs62SUQ4ERZ2nKfwd?=
 =?us-ascii?Q?owv76VgpUw/ZoG2TCT3gUIGXEOx9QC3ek/cPoNkgd7yiw60NCNVXn369MMAe?=
 =?us-ascii?Q?no4XBVxQEjnc6ljfjxIJQ+HQcqFG0QFsPiFDBRevCshtpO7/fJL/F2chh8GH?=
 =?us-ascii?Q?7o5ZoB3dvC9Y/bbuDNQ65x25g4J3Bk5OfR7RhPcNmUo6SE/C4FcXj/1tZqEC?=
 =?us-ascii?Q?DK+fL0tAwNRwVW/CNgHb7BOw1iJ2seqtfnq4WpT1c2wLJWWvQFfouRGncJz2?=
 =?us-ascii?Q?i+1o5t494L5egO3gg3EV9KnPUqLfIW1PlO8TqCj0wDIT/jPCTe/98bwO3Tol?=
 =?us-ascii?Q?WnhiJ13o2cL9xVKkr96DrcIUtsYg/vgbGiEF16lmBQWwhPRnA50SX+UmFTxV?=
 =?us-ascii?Q?em8t36PGUKNN3raaU0gogmm021545r/987lmr+Y8GFL0Qqktkl11E+BhakCp?=
 =?us-ascii?Q?ZrJUw6ky4LHpUHmdAkT73cbVW1q0fI2FB3Y3BGHVQSe6w0IYsUrs+Bi6igip?=
 =?us-ascii?Q?N2BSF78HuMS/O4DuKxq1r+onO5K/zRqk3LHRKBsiG39j9VDWnLSIgBOZ3tyu?=
 =?us-ascii?Q?05hu9jYdTRCMUmJjYC8gbd846/z31KVX6Jw1cFLYObk9RxNycoaOBiFnbb5n?=
 =?us-ascii?Q?LoJ6x0okdE8Qp3xS3kHG8rRR/eUESzaZyPVtG/PuD2uW2jgCK0SXAqrLxaWm?=
 =?us-ascii?Q?I4+cU6YN0dc9TVY7FF+ze0dQnI7rOJUyLJf/6EPXHZB1V8LnJ6xvlMWNYYR3?=
 =?us-ascii?Q?aOxCnM9MFLE9K1010gUOAvqEvZRGwxtqJFoMF/EZ3VIwq2LJL0S9fXpcxvod?=
 =?us-ascii?Q?z7ofZO6o3/vwAMCiWs1e9feu/1UiaWVfd5mWPIuMadNzJ6QVUNXKv9T/+rnm?=
 =?us-ascii?Q?ZJ9PaY3HX7hUnYr8ot5UqcpoPlaP1kj3pADJ4UTv5RadnZvo2qd3cKCxQkbl?=
 =?us-ascii?Q?6RY5qcaOMLi25zw330AtsnSZQw0lygE4d8p8Bhrwc87QAwI5U19w/4etEB3P?=
 =?us-ascii?Q?50srr99ilQiBC2TxN9BM+S57w73Yfz/AGWXjL0hGMyu7k6/efJ60N/UnjU60?=
 =?us-ascii?Q?uh36tVMPVKpdp1OmKjcz7ueByttVxth2NOgp0Lo9zj6ANJ6uZ1Ki4ziSjArj?=
 =?us-ascii?Q?RAYSy0O4TnG8+IKPNk7/skv+RgfcjFbZLYQ6RZLawuk5DDQHJjnKb9oFbyPF?=
 =?us-ascii?Q?4DW5gAcywkdrrtwDqJMVUitebzFePreMv242ZbqbJdjV9+2McJvyA+GuwZ9H?=
 =?us-ascii?Q?isj9Pp3ngtoUPSOMC3KYd0drg5CZhuGl7Jmy+kWj/FtSHla5jXewGWppxADG?=
 =?us-ascii?Q?9VLXCoLMmZGv4SRStcX20X2eBJcuZyF+rKkFDSql?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0670556b-7baa-40da-c8e2-08dcb1cc0af6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 01:48:29.8051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKU5cvqMdu1R58Ajhb1Ln4ELyDH9pVyYAhtAFOKxiCtKL2Wne5IP6ge4mkwwUMOz2z3Ez1Ke3q4rHCl7V2tyuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5884
X-OriginatorOrg: intel.com

Hi Thomas,

Greetings!

There is kernel BUG in __jump_label_patch in v6.11-rc1.
Found the first bad commit is:
83ab38ef0a0b jump_label: Fix concurrency issues in static_key_slow_dec()

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240731_164621___jump_label_patch
Syzkaller repro code: https://github.com/xupengfe/syzkaller_logs/blob/main/240731_164621___jump_label_patch/repro.c
Syzkaller syscall repro steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240731_164621___jump_label_patch/repro.prog
Syzkaller analysis report: https://github.com/xupengfe/syzkaller_logs/blob/main/240731_164621___jump_label_patch/repro.report
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240731_164621___jump_label_patch/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240731_164621___jump_label_patch/bisect_info.log
v6.11-rc1 bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240731_164621___jump_label_patch/bzImage_8400291e289ee6b2bf9779ff1c83a291501f017b.tar.gz
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240731_164621___jump_label_patch/8400291e289ee6b2bf9779ff1c83a291501f017b_dmesg.log

"
[   26.685632] jump_label: Fatal kernel bug, unexpected op at udp_destroy_sock+0xc8/0x280 [00000000ca56fe49] (eb 35 e8 c1 73 != 66 90 0f 1f 00)) size:2 type:1
[   26.686361] ------------[ cut here ]------------
[   26.686558] kernel BUG at arch/x86/kernel/jump_label.c:73!
[   26.686805] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
[   26.687086] CPU: 1 UID: 0 PID: 2414 Comm: repro Tainted: G        W          6.11.0-rc1-8400291e289e #1
[   26.687477] Tainted: [W]=WARN
[   26.687610] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   26.688074] RIP: 0010:__jump_label_patch+0x38f/0x400
[   26.688327] Code: 0b 48 c7 c3 00 69 97 88 e8 7e bb 56 00 45 89 e1 49 89 d8 4c 89 f1 41 55 4c 89 f2 4c 89 f6 48 c7 c7 40 b9 a2 85 e8 31 e8 35 00 <0f> 0b be 04 00 00 00 48 89 45 c8 e8 91 f7 bb 00 48 8b 45 c8 e9 f7
[   26.689095] RSP: 0018:ffff88800fab79f8 EFLAGS: 00010286
[   26.689326] RAX: 000000000000008f RBX: ffffffff85a2fb01 RCX: ffffffff814521c6
[   26.689634] RDX: 0000000000000000 RSI: ffffffff8145d208 RDI: 0000000000000005
[   26.689942] RBP: ffff88800fab7a40 R08: 0000000000000001 R09: ffffed1001f56ef0
[   26.690247] R10: 0000000080000000 R11: 0000000000000001 R12: 0000000000000002
[   26.690544] R13: 0000000000000001 R14: ffffffff85167688 R15: 0000000000000085
[   26.690837] FS:  0000000000000000(0000) GS:ffff88806c700000(0000) knlGS:0000000000000000
[   26.691169] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.691412] CR2: 00007ffd56dda4d8 CR3: 0000000013efc004 CR4: 0000000000770ef0
[   26.691706] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   26.692002] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   26.692299] PKRU: 55555554
[   26.692428] Call Trace:
[   26.692555]  <TASK>
[   26.692662]  ? show_regs+0xa8/0xc0
[   26.692836]  ? die+0x42/0xc0
[   26.692994]  ? do_trap+0x230/0x410
[   26.693161]  ? do_error_trap+0xf2/0x210
[   26.693338]  ? __jump_label_patch+0x38f/0x400
[   26.693533]  ? handle_invalid_op+0x39/0x50
[   26.693714]  ? __jump_label_patch+0x38f/0x400
[   26.693907]  ? exc_invalid_op+0x63/0x80
[   26.694082]  ? asm_exc_invalid_op+0x1f/0x30
[   26.694269]  ? udp_destroy_sock+0xc8/0x280
[   26.694455]  ? __wake_up_klogd.part.0+0xa6/0x110
[   26.694659]  ? vprintk+0xd8/0x170
[   26.694810]  ? __jump_label_patch+0x38f/0x400
[   26.695008]  ? __jump_label_patch+0x38f/0x400
[   26.695203]  arch_jump_label_transform_queue+0x80/0x120
[   26.695432]  __jump_label_update+0x13a/0x430
[   26.695626]  jump_label_update+0x34a/0x440
[   26.695807]  ? __pfx_udpv6_destroy_sock+0x10/0x10
[   26.696014]  __static_key_slow_dec_cpuslocked.part.0+0x5f/0xb0
[   26.696266]  static_key_slow_dec+0x86/0xd0
[   26.696446]  udp_encap_disable+0x1e/0x30
[   26.696621]  udpv6_destroy_sock+0x16b/0x250
[   26.696806]  sk_common_release+0x74/0x460
[   26.696985]  udp_lib_close+0x1a/0x30
[   26.697149]  inet_release+0x14c/0x290
[   26.697315]  inet6_release+0x5c/0x80
[   26.697474]  __sock_release+0xb6/0x280
[   26.697642]  ? __pfx_sock_close+0x10/0x10
[   26.697819]  sock_close+0x27/0x40
[   26.697969]  __fput+0x426/0xbc0
[   26.698117]  ____fput+0x1f/0x30
[   26.698263]  task_work_run+0x19c/0x2b0
[   26.698433]  ? __pfx_task_work_run+0x10/0x10
[   26.698622]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   26.698853]  ? switch_task_namespaces+0xd8/0x130
[   26.699058]  do_exit+0xafa/0x29f0
[   26.699210]  ? lock_release+0x441/0x870
[   26.699384]  ? __pfx_do_exit+0x10/0x10
[   26.699552]  ? __this_cpu_preempt_check+0x21/0x30
[   26.699757]  ? _raw_spin_unlock_irq+0x2c/0x60
[   26.699948]  ? lockdep_hardirqs_on+0x89/0x110
[   26.700140]  do_group_exit+0xe4/0x2c0
[   26.700307]  __x64_sys_exit_group+0x4d/0x60
[   26.700491]  x64_sys_call+0x20c4/0x20d0
[   26.700660]  do_syscall_64+0x6d/0x140
[   26.700822]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   26.701044] RIP: 0033:0x7fb60ab18a4d
[   26.701208] Code: Unable to access opcode bytes at 0x7fb60ab18a23.
[   26.701472] RSP: 002b:00007ffd56dda568 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   26.701785] RAX: ffffffffffffffda RBX: 00007fb60abf69e0 RCX: 00007fb60ab18a4d
[   26.702078] RDX: 00000000000000e7 RSI: fffffffffffffeb0 RDI: 0000000000000000
[   26.702371] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000020
[   26.702664] R10: 00007ffd56dda410 R11: 0000000000000246 R12: 00007fb60abf69e0
[   26.702958] R13: 00007fb60abfbf00 R14: 0000000000000001 R15: 00007fb60abfbee8
[   26.703258]  </TASK>
[   26.703356] Modules linked in:
[   26.703525] ---[ end trace 0000000000000000 ]---
[   26.703818] RIP: 0010:__jump_label_patch+0x38f/0x400
[   26.704070] Code: 0b 48 c7 c3 00 69 97 88 e8 7e bb 56 00 45 89 e1 49 89 d8 4c 89 f1 41 55 4c 89 f2 4c 89 f6 48 c7 c7 40 b9 a2 85 e8 31 e8 35 00 <0f> 0b be 04 00 00 00 48 89 45 c8 e8 91 f7 bb 00 48 8b 45 c8 e9 f7
[   26.704876] RSP: 0018:ffff88800fab79f8 EFLAGS: 00010286
[   26.705100] RAX: 000000000000008f RBX: ffffffff85a2fb01 RCX: ffffffff814521c6
[   26.705399] RDX: 0000000000000000 RSI: ffffffff8145d208 RDI: 0000000000000005
[   26.705695] RBP: ffff88800fab7a40 R08: 0000000000000001 R09: ffffed1001f56ef0
[   26.705990] R10: 0000000080000000 R11: 0000000000000001 R12: 0000000000000002
[   26.706295] R13: 0000000000000001 R14: ffffffff85167688 R15: 0000000000000085
[   26.706601] FS:  0000000000000000(0000) GS:ffff88806c700000(0000) knlGS:0000000000000000
[   26.706938] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.707181] CR2: 00007ffd56dda4d8 CR3: 0000000013efc004 CR4: 0000000000770ef0
[   26.707481] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   26.707872] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   26.708172] PKRU: 55555554
[   26.708296] Fixing recursive fault but reboot is needed!
[   26.708517] BUG: using smp_processor_id() in preemptible [00000000] code: repro/2414
[   26.708838] caller is debug_smp_processor_id+0x20/0x30
[   26.709061] CPU: 1 UID: 0 PID: 2414 Comm: repro Tainted: G      D W          6.11.0-rc1-8400291e289e #1
[   26.709451] Tainted: [D]=DIE, [W]=WARN
[   26.709613] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   26.710075] Call Trace:
[   26.710198]  <TASK>
[   26.710325]  dump_stack_lvl+0x121/0x150
[   26.710509]  dump_stack+0x19/0x20
[   26.710680]  check_preemption_disabled+0x168/0x180
[   26.710908]  debug_smp_processor_id+0x20/0x30
[   26.711103]  __schedule+0x9a/0x2eb0
[   26.711263]  ? rcu_is_watching+0x19/0xc0
[   26.711439]  ? lock_release+0x592/0x870
[   26.711614]  ? __pfx___schedule+0x10/0x10
[   26.711795]  ? debug_smp_processor_id+0x20/0x30
[   26.712001]  ? rcu_is_watching+0x19/0xc0
[   26.712183]  ? trace_irq_enable+0xe1/0x120
[   26.712373]  ? do_task_dead+0x4a/0x110
[   26.712541]  do_task_dead+0xe0/0x110
[   26.712702]  make_task_dead+0x384/0x3c0
[   26.712876]  rewind_stack_and_make_dead+0x16/0x20
[   26.713082] RIP: 0033:0x7fb60ab18a4d
[   26.713238] Code: Unable to access opcode bytes at 0x7fb60ab18a23.
[   26.713495] RSP: 002b:00007ffd56dda568 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   26.713808] RAX: ffffffffffffffda RBX: 00007fb60abf69e0 RCX: 00007fb60ab18a4d
[   26.714103] RDX: 00000000000000e7 RSI: fffffffffffffeb0 RDI: 0000000000000000
[   26.714399] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000020
[   26.714698] R10: 00007ffd56dda410 R11: 0000000000000246 R12: 00007fb60abf69e0
[   26.715005] R13: 00007fb60abfbf00 R14: 0000000000000001 R15: 00007fb60abfbee8
[   26.715309]  </TASK>
[   26.715476] BUG: scheduling while atomic: repro/2414/0x00000000
[   26.715787] INFO: lockdep is turned off.
[   26.715959] Modules linked in:
[   26.716107] Preemption disabled at:
[   26.716110] [<ffffffff81354268>] do_task_dead+0x28/0x110
[   26.716529] CPU: 1 UID: 0 PID: 2414 Comm: repro Tainted: G      D W          6.11.0-rc1-8400291e289e #1
[   26.716943] Tainted: [D]=DIE, [W]=WARN
[   26.717108] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   26.717572] Call Trace:
[   26.717684]  <TASK>
[   26.717986]  dump_stack_lvl+0x121/0x150
[   26.718159]  ? do_task_dead+0x28/0x110
[   26.718328]  dump_stack+0x19/0x20
[   26.718480]  __schedule_bug+0x12d/0x180
[   26.718654]  __schedule+0x210c/0x2eb0
[   26.718821]  ? rcu_is_watching+0x19/0xc0
[   26.718995]  ? lock_release+0x592/0x870
[   26.719167]  ? __pfx___schedule+0x10/0x10
[   26.719350]  ? debug_smp_processor_id+0x20/0x30
[   26.719550]  ? rcu_is_watching+0x19/0xc0
[   26.719723]  ? trace_irq_enable+0xe1/0x120
[   26.719903]  ? do_task_dead+0x4a/0x110
[   26.720068]  do_task_dead+0xe0/0x110
[   26.720227]  make_task_dead+0x384/0x3c0
[   26.720401]  rewind_stack_and_make_dead+0x16/0x20
[   26.720605] RIP: 0033:0x7fb60ab18a4d
[   26.720761] Code: Unable to access opcode bytes at 0x7fb60ab18a23.
[   26.721016] RSP: 002b:00007ffd56dda568 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   26.721333] RAX: ffffffffffffffda RBX: 00007fb60abf69e0 RCX: 00007fb60ab18a4d
[   26.721628] RDX: 00000000000000e7 RSI: fffffffffffffeb0 RDI: 0000000000000000
[   26.721923] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000020
[   26.722219] R10: 00007ffd56dda410 R11: 0000000000000246 R12: 00007fb60abf69e0
[   26.722517] R13: 00007fb60abfbf00 R14: 0000000000000001 R15: 00007fb60abfbee8
[   26.722818]  </TASK>
"

I hope it's helpful.

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!

