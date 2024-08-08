Return-Path: <linux-kernel+bounces-279871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B4C94C2D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88FFB1F21536
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4891E190052;
	Thu,  8 Aug 2024 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMmksUAZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A904512FB0A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723135163; cv=fail; b=AITnVsklFKPh5A8bzx67EP63xs9XdCXXriB0Oy6qgd54jzQ7+LZbEHrOeoqt1hZMoOQQ0L7T77k8hFGaV3eoQZt49O3TLvBxHdpOGL7P5Vnhk7UukFVeLU8dHJYd3dKuXMV6QBUMk57/q0o1yR+R3jcwBBQC959EtDZjfwznWEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723135163; c=relaxed/simple;
	bh=T71JxXh0ZDVpcaMJnh5ZhV7Vc1TdrQfFoOmrm0cMyU0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ir8GHVpb3T8arCI7FiHsGS+nec6v88ysCTWdD1Z6UUdru+E3CzOKQG2D5wYDA7Puw4Fc1dhBM7+moJNc1NhnnEvlIzHNFOhEVTeHDlVdtQxv+hErgEV/ZU05DCGYV2MGK5Zi8hPH6BjlLKsV9tNzSwgEXnco4D89pMl/nkj/0uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMmksUAZ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723135162; x=1754671162;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=T71JxXh0ZDVpcaMJnh5ZhV7Vc1TdrQfFoOmrm0cMyU0=;
  b=RMmksUAZxvYtfvQyBKdhxns/0kqyaCWFEfLupwC+5EkLWdrzUsaOsQvT
   pAVWD2dOnju8lrBcxTQu2huLMjOEzO/9F7NR7ANVE9ZEF5ldANXosYpfS
   E3vmSywL5csEoO0Xk0VimV1GHwwNe33sIdCzH4g2PppPxgnHYaIXUJKoB
   Wq3VRAsLD5ChKcm+NWU17XVAALeWfwJj6k4X+/6wfBMkLsE+rKegVlLgA
   mS403KxsQazSGXo5qdi9fDn9gNK3HfOp5fhVRPlNK/Qpng6Dm0VJRBCv5
   takpVk/dHQ77vMEeUljSMI3cGTAJtoHYE/Qwhvtn83//YGuepKyt5FJmi
   Q==;
X-CSE-ConnectionGUID: 8QY8J5ZuRWSbZ429RhMXNA==
X-CSE-MsgGUID: K4CBxk/HTHmcaHW1DkmbWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25144100"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="25144100"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 09:39:09 -0700
X-CSE-ConnectionGUID: fAlB5aZ4Sn2Qf9KOW173CQ==
X-CSE-MsgGUID: XXdoANscSp2wtBn0Aqg2VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="57978317"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 09:39:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 09:39:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 09:39:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 09:39:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 09:39:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAxRpqkgrngUlvW0TFHQoiBmlrM8CrWIDVUoxvFn/wljgbr8EGfDdZJ3WpmttRxwRrrB1gx3x3uJRSw7fVTjL7ryQpIU8Tu9IXCtPzFVApWPkFzN2wkBjAWX4IeWwUOfNzdTII6nOsuZBQlNyGJqJTkgDFv4WI4KgkZjSJRWUE2G1Ga2OpIL0b9SLnq/T3jRq80g0Bg1JxA8mNdT0KOEHBKFwbM06k2IbRhefpF3j05wyJf3unRy9lG2cX3YuPBG2rsRkIpfIy2XTKmGQGb8gmPzWlKn0H59W111aUtOYe1C5XxLWFcYHxcZ38iA92sXLFLcsYnUsuVdeGG8tSgm5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaNdgwra1x+/WWKMQ7Q//cpzDHkd8kuXLvv72JQHcm8=;
 b=UzpIYj6MLQ+r4cmZqCKmPAblNUdOcm0EsaKtFTJKCvKU8f0TJZOMvZPLeO4MlcGnD8pqBOwoyuEsuqeUawVwqyULpZo5CmcIoOCQv2BHXOrPJOseixPI5g2g7G+c4oTIZrb0Q9FIWkEtlCOaiEWDKeDjs9b6MPOGVlb84nVE+7eQa7XpicOAPRgHC/BQro0c04Zu4g6MEPfsehOTs9DxCvvJY4hW7dTErXEibBMuIwhzs8/gH4IITxE710uQInU43hkFH91ZmEsK/ckI3miKgNqZtlKSIZyBe3z8WLk8k7RYeRkUDm+XPiBFIs5Hb54jJ/JNZKmvocI3b6P7B5eAsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6863.namprd11.prod.outlook.com (2603:10b6:303:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.32; Thu, 8 Aug
 2024 16:39:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Thu, 8 Aug 2024
 16:39:03 +0000
Date: Thu, 8 Aug 2024 09:39:01 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Max Ramanouski <max8rr8@gmail.com>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>
CC: <max8rr8@gmail.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>, Dan
 Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
Message-ID: <66b4f4a522508_c1448294f2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230810100011.14552-1-max8rr8@gmail.com>
 <87le17yu5y.ffs@tglx>
 <66b4eb2a62f6_c1448294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <877ccryor7.ffs@tglx>
 <66b4f305eb227_c144829443@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66b4f305eb227_c144829443@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:303:8e::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: c8cc2792-78c8-46bb-9f07-08dcb7c89cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hZ5ngXkLoakYKkg70g8KpZMQrxQmVxuoWia7LzZzGJJ3TReNHJ71BWOk7Rne?=
 =?us-ascii?Q?+DsGzHSy8j+UDOevPIExxKk+Uza52634iIr9671SAh2OxKxchXWNZMGcbvES?=
 =?us-ascii?Q?E9EbuXkP3nF2ale59pjjaGucdOtVDoHff1/JuLmNKYjpH+9qH/5/ZDuFRxg0?=
 =?us-ascii?Q?ULpw8I1gvqMo1iEkbk+N+u1Df5l+HYuDkUjjHtw5drzAqkp3dG3n0qydWA/e?=
 =?us-ascii?Q?52m7APFXwf817AjaDz8bNffzuByEKKfYcCD301q128IjA2NJNNKB5Tgj64E9?=
 =?us-ascii?Q?5UpH0/0KVfMwdbemd2U/HvOhc5w6ibTvvjeAU5T6q/Rp7R5pumi+C+IP+HCk?=
 =?us-ascii?Q?NnTM7E7q4bMK+w9Q1vMh0GMgzJc8nsu5Ao6lsOPOrRhJF86fuaIawfc9RBog?=
 =?us-ascii?Q?Osbt/PPSf8Zv5R8goj/QRdJLgZ+yQKNPgXguF0wrMoHhMw8g2rTiOg8bXjQT?=
 =?us-ascii?Q?YYpO5Lj6TNVCHvbV4Qlhi5gG3M56Guv0okt6/eKiCFqT7CjqPhMaSBGlKBb5?=
 =?us-ascii?Q?kx88u2KQZxutau8QnGpe8a48hnoW4hDDKSJ5TR0ADjq8U0D7H9IB0jqg4QYQ?=
 =?us-ascii?Q?feaaEJK1NV+xI4rKrXHxE6shu+QzXvHxpCjfvoROx8bWuEjjJ6osTt2Mj2xN?=
 =?us-ascii?Q?0ooI/UbD7c+io146+4gf6744Vc8MXWg5kFiDr5uW4OYwi1B7ZevMk6mlrmi3?=
 =?us-ascii?Q?qYSXrPTF1GoKoZc+FzbhvBmBUQpKwCMYJEcbwpyJnFKIh541DpNtJpCdl5if?=
 =?us-ascii?Q?3dK5nQb7RZ5Pxrv16HlSvFNH/jYiRQ+8KSQH2TsWAaeES+Cj7a98IUhAV9Vp?=
 =?us-ascii?Q?TYCKginPuQMOTLMCCsB9HZPKT9f7kWmBkGrDvGeFM5KO3B7SFov4KjOC9Hoh?=
 =?us-ascii?Q?4aHrTwWFGFW1xU8cqiS+XsH9wKBbLxWXFH3w5bywwzBXAa5A3Q/+x2lW8T4M?=
 =?us-ascii?Q?RXZQY8Ir/aC8mEwTKJH2u7C2MONA4+yY7+jtIM8g21LyQoJfIWiE5dso7YZG?=
 =?us-ascii?Q?/d3HdSkBZ2cpAIn/HOUAHK10Z+UQdgZAaDV7KHLlWZKXniO0VHd8LrFB/5cn?=
 =?us-ascii?Q?TXI4KdxNRq9XyxWBWMEsAyAQA+LjngZ/Jptmg49ty+az9We1y+zPrWXgoyOp?=
 =?us-ascii?Q?UKBgQSn6S2cthY5mSjYlepNvgtLzNXSuvL1f41l/5erAEP1zg5wz6aQqSt7E?=
 =?us-ascii?Q?MmUATbmOvWF0Tr905YVhR4ZUf9r3vzZgisc2qASaKzCY1ADlHz98Fqsk+0vu?=
 =?us-ascii?Q?GnpHvtQYZCj053kFKWwng7+U0uhJnlZuZtAm5ITCv/WOuaSUIP5h5B9/lNgM?=
 =?us-ascii?Q?uzcUiAbEbGGDc4upPBmdLg96sIP7H+TxjRpUhYhp0COteg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pg+7/62FJrtiW19yruNSeScMkx38FgBum/Wur7RK8H3yKV0fCH+cr+GQqUIE?=
 =?us-ascii?Q?HnLzQf0mg5kfZuQsQzUoMN6KpIL0GwnZ9tpo2jd09aDs4VX4u/QlgHNOc0J3?=
 =?us-ascii?Q?Lv/CueapnulYkevd9S13TcFt4ltYZ198tNPkgeCGPidlp1bwMAc3hkt8R2Oh?=
 =?us-ascii?Q?FvtcofxNc/P1AnuE7icve5GkXrgqV2epEw6ne1w/qrmsL/E0g+FQ6oGYyjSZ?=
 =?us-ascii?Q?X++g2/1fwVbEYJZxryadwRCo81nTQUoXR2VjfnVEtTt0SgZHLtN8YjcoanLX?=
 =?us-ascii?Q?ujtEn00+bBOZ5K3cJu8pP+s1ITXylt9gWLez/k0glaM6JWzhZ0QqVD0Dfps+?=
 =?us-ascii?Q?sS+KExZ1XsOUQte+oC5DHZJLeDt3F/pCS7qXDdc3iOfW54sn1ythewlzmFFE?=
 =?us-ascii?Q?AWgBktnRToiNTuYYeIP8qRguJ4/7Jc7K56h4O7vfb6Fy+u1Ug8fcwPxoHXDT?=
 =?us-ascii?Q?Uqa7ah6T4yLD8ps2IHZN2g+R0wfOptRuVoje2wwLkfAGRA5jgbRi1+CqeG6L?=
 =?us-ascii?Q?IzsY03hPxN4sZw0tjlV1xYG6QjwYoBfAzlyq2iy+U3dgtpWeB9tBG1ZE/xSw?=
 =?us-ascii?Q?0GdhXmcOSrxFMi/BZSRdVnpaf7QkTLWV4t59gHOddg5CVmI3wnJBvk6d1ZBs?=
 =?us-ascii?Q?6KrJGDD7ZEhd9c15DSygg/z/kovIVLabF09IDb6BYL77O2TDhWDtlvMg9RRS?=
 =?us-ascii?Q?pcTBccaGaF3IOz5c9qiq01Y9ChFpdShTYuuJACWnnJT/FjaOKUQA4ZZBZla9?=
 =?us-ascii?Q?fhiAzt8PYDKkkSAaxqJeXSeuxc891pSjUiilkvj7/mub0vYubO4LLeeyFJBx?=
 =?us-ascii?Q?qt+Ob23Dl3LeNQV/7yXp3Bp2s/jh7/YXB7mP/W11Nvm6SjRLXlr59H6/1Nwh?=
 =?us-ascii?Q?1IU1zjJDFP0HWpreO82i5EXsnYJLpID+PW8HzmvcU5IuKI28ko2byty1vRbM?=
 =?us-ascii?Q?MUMtw3p09eZ5fTBQDYhZiS3jJx6MvPJlEIzK3W8+XVv1QtoZvZy19p5FdffQ?=
 =?us-ascii?Q?mzrK19D6yyypYm1RcaPnjOC98YvgpFrl6eUP0y7qeaensRf6iU5S+zIqas+/?=
 =?us-ascii?Q?Vt5GBW71z76UhE48kYu8/P2w/0/InUH2epW2mjjXjxoSqyGGrMmjUYFRwDhG?=
 =?us-ascii?Q?Kr3xQiULZJcxTVjAt18tZYZkmhQy8JkB7Uy+3VwBJLtFX9pHAzS6nSi5FWYY?=
 =?us-ascii?Q?fadJbvrWQYoRJYvTEAR3q2N8ooI+bWyKz/JzsIA7RLxtOOciM2A/2KlQ/mS6?=
 =?us-ascii?Q?3BvsxBebgq0rBRQtVjqEt7ZRuWCAUWGmduNpHkVNR7xpwIUoWHGGy+weAPI1?=
 =?us-ascii?Q?DMrQr3cZ0lh+vjTsB+gEvh6qQb9H/dXld2+Fap4xkmtkSMeLlPz4cnQ6TB+B?=
 =?us-ascii?Q?80dTdrUqCJHwJYCmgKlkbzFqfmf6Q/00e4d0qFaZUsfPCazek4lYMCw6DnfO?=
 =?us-ascii?Q?c0dt/YJC22YMXRbJjUzepMuvzMSLX3MuZ1LJ+UwnUgZPxxmjniBBOK1Ffip6?=
 =?us-ascii?Q?gkhUk+aOR4tNp10vS4puZF0PReF1vFlO45mnLP+JGjfWorzpMxc3nwPMAh3g?=
 =?us-ascii?Q?cUP9BDMkjJLHtAaUMJuDGIPJqluZM6PQeFDHD5LgLuGMxp0Z7u6VHbX/2PVc?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cc2792-78c8-46bb-9f07-08dcb7c89cfb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 16:39:03.5973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/H6w08cXpJTsx6VSlMJMqRRC61Pddd3CcPDcQgbgT52mfJadBjmZbNZYYSSL1CcLCviTr0dkJvMiwp4fy6gMl7z7nXNdFQ6rV63yuPaByk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6863
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Thomas Gleixner wrote:
> > On Thu, Aug 08 2024 at 08:58, Dan Williams wrote:
> > > Thomas Gleixner wrote:
> > >> On Thu, Aug 10 2023 at 13:00, Max Ramanouski wrote:
> > >> 
> > >> > On systems that use HMM (most notably amdgpu driver)
> > >> > high_memory can jump over VMALLOC_START. That causes
> > >> > some iounmap to exit early. This in addition to leaking,
> > >> > causes problems with rebinding devices to vfio_pci from
> > >> > other drivers with error of conflicting memtypes,
> > >> > as they aren't freed in iounmap.
> > >> >
> > >> > Replace comparison against high_memory with is_vmalloc_addr to
> > >> > fix the issue and make x86 iounmap implementation more similar
> > >> > to generic one, it also uses is_vmalloc_addr to validate pointer.
> > >> 
> > >> So this lacks a Fixes tag and some deep analysis of similar potential
> > >> problems. While at it please use func() notation for functions. In the
> > >> middle of a sentence iounmap does not immediately stand out, but
> > >> iounmap() does. It's documented ...
> > >> 
> > >> This add_pages() hackery in pagemap_range() is really nasty as it ends
> > >> up violating historical assumptions about max_pfn and high_memory.
> > >> 
> > >> Dan, who did the analysis of this when the device private memory muck
> > >> was added?
> > >
> > > So that plain add_pages() usage originated here:
> > >
> > >     4ef589dc9b10 mm/hmm/devmem: device memory hotplug using ZONE_DEVICE
> > >
> > > The original memremap_pages() only ever used arch_add_memory()
> > >
> > >     41e94a851304 add devm_memremap_pages
> > >
> > > When HMM merged into memremap_pages() I indeed did not pick up on the
> > > nuance that HMM was wrong to use add_pages() instead of
> > > arch_add_memory() which updates the high_memory variable:
> > >
> > >     69324b8f4833 mm, devm_memremap_pages: add MEMORY_DEVICE_PRIVATE support
> > 
> > arch_add_memory() calls add_pages() ...
> 
> Apologies was trying to quickly reverse engineer how private memory
> might be different than typical memremap_pages(), but it is indeed the
> same in this aspect.
> 
> So the real difference is that the private memory case tries to
> allocate physical memory by searching for holes in the iomem_resource
> starting from U64_MAX. That might explain why only the private memory
> case is violating assumptions with respect to high_memory spilling into
> vmalloc space.

Not U64_MAX, but it starts searching for free physical address space
starting at MAX_PHYSMEM_BITS, see gfr_start(). That aspect of private
memory has always bothered me, but I am not sure that is the historical
assumption violation you are referring to above.

