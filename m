Return-Path: <linux-kernel+bounces-258510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FECB938903
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735021F214CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7288B182D8;
	Mon, 22 Jul 2024 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5b2OO6e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6924B1803D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721630695; cv=fail; b=cKk2gbxsAzYoXRk6sMFDASk0iFk7pzszy6tfLZDs0KEqUCilp+ti+zZdVN9oPjzDwMpbz2TCM7wUKW6k2qslLcPn6TZUANg1eJNYmfSPpxwqQttCNBxZzPAfl52HsY8IDWiV1naxNNOEa38mFlZgeNSXZy3+SWTxD4uL1aMX9iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721630695; c=relaxed/simple;
	bh=snV8WQb6g++ZBE/OljuSkUfDJsifhaiQl49CXI0spqQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Psg9Df8ZyI+FFZgdU/gHMhEx2HcVGMx1CWslWB5IxUajXIu9n2xNSiMur0FlcirA0eLAwUuB4wsaEm1KYTCpEGIxnYnfvyMFh/2LMZ432NHs4HGRwZ/nZMsDLc9vAOxpH3J5ii3fnqAiVAj1aFQT9ZiMQQMeo9VUw2grTlEjXSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5b2OO6e; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721630694; x=1753166694;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=snV8WQb6g++ZBE/OljuSkUfDJsifhaiQl49CXI0spqQ=;
  b=c5b2OO6eGRGPGOHMg2zby7htR3vpX1xOoa6CHp2VBMuCAoT7Mpmz5fuu
   VwsEdVolRFBPwMkPAZeixJO79MtFv1S1oYFnj7lDIy8DA7JDOtv2nAWvX
   S584oHeJe9/do1dCbyNjzi2DnSGzyyLRhhmn9GP3HUgWUn4AsFJ7HMrMT
   bEFfL63HycHXg07jyw2w7xcnM8XJORho3lZHQLJAZfPftZes9wf/VHefe
   FdSXwvcibbuODuuilB9/b+1j7oAg3oOgNJTHC0HtWD//dfUkVU8sxBbV/
   eBwg3Rjj+OfjaF86LJXL46V+Go6GU9cYqAROpRpFZLytIhiePh/pzM+WV
   Q==;
X-CSE-ConnectionGUID: bhxHLKPFQ5yq+ddobQpehg==
X-CSE-MsgGUID: 5FIL5N5nRfejhZRJAJoNrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="30606855"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="30606855"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2024 23:44:53 -0700
X-CSE-ConnectionGUID: /nh3ZEvGS+ets3c6kD8AZg==
X-CSE-MsgGUID: 8dsa0LzKS02cn6m1jQFuAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="56335261"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jul 2024 23:44:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 23:44:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 23:44:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 21 Jul 2024 23:44:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 21 Jul 2024 23:44:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bt0uB/8zLx442fckapXQiBnhRB51MwZ1NhqmBUHMiNrnCczkET7hzRzA331x8dZPJK/8t5uR6FujhX+7JRBAAPqeZaapKQcBFEHRl/XwR6Ipg3nVRa/iqf1Y84DqbauosQJa9x3iIv+rEHgeBebhw7D31dBemlTxVAOyQ7YYL9wmmzaDTcPo+9+E4i7cITECtxrWqY3OmKKZ5GRwwQkpAoc932CFXVzc6FPcq5upR+TcgIUdpCc+t2mEhFmQ+QFl5e4idG1cWxCAr93sS8KgVQ6PW+0f8N3A24H4pPJq8WGnWqI1sGgKqYFM18sQxpXSWiyYhq9+7zrESmOfIhIjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIw+e5qPsIFgprDJy8UXT3nwYOJPg1M77BoKTpgqVO8=;
 b=cW5d7xmbIjX/Aq7S/QiDAwmFSJpLnApVACczK23zFDs3Hyn+Rn3fQIEjTr1QrVwOAO3LleaRmvPldxtJJXg1zhMNT5urdEVMCQzScx3Huxs30TE0Ei0asObfstrC4OL+/xT1Lluh+kn8hSfkFwN3sAOKh1PnuzexJL2L0xt7EmCPVqy2531r+eTq6SX+7K/Fydcfau9SeYgM6edIRVbUEPuDlNZjBYOiP0COuGM45wQUklCON05gauSGc83c4c2bxZw3DBYFYck5y4UcWWKK/Z0+p1enXXNc9crVnFBhbu9i8HKNxuI3afT2OoImJI7lMbzbJQpIBheqi7P6d9tiUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DM6PR11MB4516.namprd11.prod.outlook.com (2603:10b6:5:2a5::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.18; Mon, 22 Jul 2024 06:44:49 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%2]) with mapi id 15.20.7784.013; Mon, 22 Jul 2024
 06:44:49 +0000
Date: Mon, 22 Jul 2024 14:43:17 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: David Hildenbrand <david@redhat.com>
CC: Peter Xu <peterx@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>, Alex Williamson
	<alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Al Viro
	<viro@zeniv.linux.org.uk>, Dave Hansen <dave.hansen@linux.intel.com>, "Andy
 Lutomirski" <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Kirill A . Shutemov" <kirill@shutemov.name>,
	"x86@kernel.org" <x86@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>, "Pei
 Li" <peili.dev@gmail.com>, David Wang <00107082@163.com>, Bert Karwatzki
	<spasswolf@web.de>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <Zp3/ha6IXL5AYA8r@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <ZpTLCscCFGtsrEjC@yzhao56-desk>
 <ZpUyZ9bH1-f5y5XG@x1n>
 <ZpY5uU2NyOoMVu5A@yzhao56-desk>
 <ZpbDnoQxGubegtu-@x1n>
 <Zpcgmk6wexTKVv2E@yzhao56-desk>
 <ZpfR_L9wtuXhtSGk@x1n>
 <Zph051h5BsSFMpR6@yzhao56-desk.sh.intel.com>
 <ZpkglfpbHH7lQSft@x1n>
 <Zpmi2JWirNDiJz+7@yzhao56-desk.sh.intel.com>
 <1a0884cb-39ed-455e-a505-7c1b2a0e5225@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1a0884cb-39ed-455e-a505-7c1b2a0e5225@redhat.com>
X-ClientProxiedBy: SG2PR06CA0228.apcprd06.prod.outlook.com
 (2603:1096:4:68::36) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DM6PR11MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4c02e5-c5aa-4dc4-347f-08dcaa19c83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f8/fu4J7WsB13TTtKcZiFL5pfHmqZMnZO/ymQEUGhARaj3o2ciAgy+2nHRLg?=
 =?us-ascii?Q?lInLar0EYCbw+JB9z12tbp3OT/Z9nhEVqNG1kv2DKEODRPySOmR1rUbTJ2CW?=
 =?us-ascii?Q?VeBmoCj6MLV7F9fJH+tmRJN7WDVGFHKns4Kb1+MaU+2RsPPPxtTIumB3WHDG?=
 =?us-ascii?Q?ucCeDiTqXBW0TainZW0E6hPbZXzCL2clnWYb1crXCH9uj6Jp+UImzQJcR9JJ?=
 =?us-ascii?Q?N//eE0Ge4sGmjzFJ+7WOLUMkLTxBXvQjR2jJua//97d9zmJgX+B1MO4pBOYN?=
 =?us-ascii?Q?qz3xVynej+gy+IVu7Wa6BuTPPiutm4neaqLxZiQ9Zzv6+mB4ywgQuT4zs51f?=
 =?us-ascii?Q?+pma1ixWz5Apphidx6zu0K1cLG1v2Kds4szD9/F6hokieIjszswTfX4sKlKQ?=
 =?us-ascii?Q?VXnXbdbgqbvSXXXf+U2iYwsSbl9NK8380ZU6RMl/7+VNjeewOJ8fPQCjXDVz?=
 =?us-ascii?Q?kAI2dqHTMigf/RHV+vF2wKx1DknFnqykjEpKyhEILeqn61U5kthwF6MDPDRA?=
 =?us-ascii?Q?NUIgZv3dvRgHNzDBMX/NaLRM08OE8o6LhBpqD2dmVKYW+IYbPHV2WDAZA9D5?=
 =?us-ascii?Q?HKmCBNdMf6buA76we6Xa97NjfTu5ElCpsDxEGu82hqYFkjzADUewBQh/1yx3?=
 =?us-ascii?Q?WnA7GJHZZ9hbEbeWcaakd9SuJIQnjyiPseb/CnUU631FNNpRISmc3fHnhIms?=
 =?us-ascii?Q?QSV5A1vKsKt3tnLvRyWwf0KC6Wwo0ntKnPHUCdNoBNpDX5M9IyVjU/KEnxfe?=
 =?us-ascii?Q?KSE4w7Sp0+0VEQNbeRNgiBWaBlsivtAlznGsP0OCEf7YDQ8zAyC7BoQ+viHQ?=
 =?us-ascii?Q?8WX+21H+o6/TQq+j/NK4qHwL87sqqjzDPIQVZ+hTOLISDRb/nxAGlWag3BRj?=
 =?us-ascii?Q?EmAO/mCjA4TZGgGEGeVHPhoMdJcFmPlag7otGJZ7EId8Ntn5TfDuzLmyWVDs?=
 =?us-ascii?Q?bvJyAy5nSDYNrk9WvXUf5nK+IgHSLdN75Vm9IJNLWzsp36o7bylT6H2g7ljp?=
 =?us-ascii?Q?4P15ShV5B3AHzKULhlomOek/F7QPpTw3B69StcfFWgqwzKo8mT0EjA15EeuD?=
 =?us-ascii?Q?YsrQ/i6m7bLbR0eXsG38GDMc290ylv1yhPUdaAAsBrF+3xiVk3lClwh8lVsY?=
 =?us-ascii?Q?x5jk0xwr6XmAIlEqlTAR1z+7A/gkPNtM47tJKLm9jOYRleIqi6ZcVo36oVSZ?=
 =?us-ascii?Q?JV5Vs/aCJIEc4pXuKz/EX7AVDCLJoCZuPRfMAzqPm7y3mnY++q7AlD+lrhHA?=
 =?us-ascii?Q?Ys/ODqDFtQBS7cWdXrO3ngUv5qTr3F/vLeaEBnYCOh4VqUGCZMdH/529tyg6?=
 =?us-ascii?Q?RaPJIdDV971E5sPWfJHh9PQQTXioB3JPmroibLofWL9LOg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MpO7tZ/AexvTTV72J/uUG+Qkk7045mxW/KI6YnRJPl5XlDZCCwfPd6LU1fu/?=
 =?us-ascii?Q?PBJEnPq3rFZ9FO2tSmgKXSJGkbbYFhDEMstkkKeg3QiodHIDU2oHAkbxT3yn?=
 =?us-ascii?Q?s/6IjQ/rVShJOha0L9u+66pr2SfQnpfrYUShzF8fEpbEpql9fXjA9IkgLOA1?=
 =?us-ascii?Q?+3uV1MG+m+iMWQBT5x872+aOGhCQ15Ahd4CtiewOLYTr42JFzmVu8hLvk7lV?=
 =?us-ascii?Q?FAaRwpJJ9VmjhDzyNzVl4Izlos2g+Nc3fHzXxe0ZwQLPW+7UQqbTVhlegiv3?=
 =?us-ascii?Q?738MjQ2GGN6iDo++X1War65V9xKPv6CMZS7AvXs3njnYAN6jdOii1mUG/mSP?=
 =?us-ascii?Q?Hj9uoKGuK7nUX02cDsG02V8ZhW6GtfV/eMf+DtPx1nzpaGMp/qoCXu0Uvqy9?=
 =?us-ascii?Q?FLYdrkBSDEjFDYXAIjNRVhUQk4iEb8vG0zVTQvkpyH0Oi9z7OEAUIGwvw1dh?=
 =?us-ascii?Q?A9PXpXkS6A/GzHHw9sA+gpw0ZJqSyBvPydEZKtvDZSU7OosdjqaWys6PtKjh?=
 =?us-ascii?Q?mGG/cxWv2SsTARcuF4+VDvR99gRsA104hCq4V1rZik6idHv+6u9Qt8oKhNga?=
 =?us-ascii?Q?e4Z2GGyplxVfgvn1sj+FpkiYxMNOyMvXk/olbcaYK5SxseWHBuq36DrbG4sx?=
 =?us-ascii?Q?3JuETuFFGsbqHxdmaJ2ljtGcAXXpjMmnv1NX3HEcLLNHI+3Hm2TsHd+04nB4?=
 =?us-ascii?Q?USG8ZrWVMuE+nYZm+QNgactzWRTE94vWl+C3mLXhfAedN3bYd+jQ+R+VViPB?=
 =?us-ascii?Q?8sioV7+/ham/Y6t/NEzvIbLAbnvNs9ScNz/ueBSiW6Cs82bs8+qhHDJqtSyD?=
 =?us-ascii?Q?D1YDqutPNkSOonmlKXy2KLm7yPX8cQCeqrLOdihgOn34MPOLWjoKmSKxwPhK?=
 =?us-ascii?Q?ffpmPS3s5JFDUvUUYiUc/L8eP1f3+kqJQUaHyhp8aouvUXfDe4qLZGLXx0Je?=
 =?us-ascii?Q?koltAacShOP7qCXvWlzIxSbNl5+EJi+x+/bXu8s3KjJZHAYBppD4vAK6SRt/?=
 =?us-ascii?Q?L+ecb1OEuAc7Rrzt6aNi9hU/R6N6/GcPlNAlbZbmTTfDNnR2wum8STWAPBoK?=
 =?us-ascii?Q?aNnX33SbRwTBsWlvkfS/31jehb4mZ8jcJ5JvjTGquOqMXwyA4sXjauA6qdBS?=
 =?us-ascii?Q?zzaYmVTHmn4gEOiaCPw5T6D3FzIsx+oMK2D6z5PCcX2nhSJvlAcm+cVOtTqw?=
 =?us-ascii?Q?nMmqYBrSi7DCBDI510OQDd+P6TifZiAfb2Dyn9TZsrPgstAYEjAg8kX5qNye?=
 =?us-ascii?Q?KXNHf1s5auVgRSesppdnqkFGpiRGXCUGlj8FiMKYzHnfotpeDGIF0MM7ZmdG?=
 =?us-ascii?Q?P+2OzM9y5Ww8/jO7Ipmt+U9PgAsh+/ZXKmd5E49A3a33oQzEgWDaWzUDOfNL?=
 =?us-ascii?Q?z7v8VPAohMOEExBSbAD3CjFrYWdRyjsJTbscmTPPhd1MPddmMubeamWu7FHg?=
 =?us-ascii?Q?GJI3SMJlhj6ZJPQNLGU/zVIiRW18FpTlJeTTTw7U7F4nYSMyBsqzJKm0bXfo?=
 =?us-ascii?Q?LctnmwXajQG/xw5xAl2ddemyDENFmDjVFOXHG5pGDL1PBfDPjQUMqthecsTW?=
 =?us-ascii?Q?Hcb85U75SegzCVoHz7d4IaolMORM4S+Icf1NOpoz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4c02e5-c5aa-4dc4-347f-08dcaa19c83b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 06:44:49.1348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rh2Yo5xcT7BkhkCNmV1fJk7DF+hnEz6orwH5xs31wlAOBcm9vgEUfKf2fmQDI1qdznhG+RSt93Xd9V49OrRD/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4516
X-OriginatorOrg: intel.com

On Fri, Jul 19, 2024 at 10:28:09AM +0200, David Hildenbrand wrote:
> On 19.07.24 01:18, Yan Zhao wrote:
> > On Thu, Jul 18, 2024 at 10:03:01AM -0400, Peter Xu wrote:
> > > On Thu, Jul 18, 2024 at 09:50:31AM +0800, Yan Zhao wrote:
> > > > Ok. Then if we have two sets of pfns, then we can
> > > > 1. Call remap_pfn_range() in mmap() for pfn set 1.
> > > 
> > > I don't think this will work..  At least from the current implementation,
> > > remap_pfn_range() will only reserve the memtype if the range covers the
> > > whole vma.
> > Hmm, by referring to pfn set 1 and pfn set 2, I mean that they're both
> > covering the entire vma, but at different times.
> > 
> > To make it more accurately:
> > 
> > Consider this hypothetical scenario (not the same as what's implemented in
> > vfio-pci, but seems plausible):
> > 
> > Suppose we have a vma covering only one page, then
> > (1) Initially, the vma is mapped to pfn1, with remap_pfn_range().
> > (2) Subsequently, unmap_single_vma() is invoked to unmap the entire VMA.
> > (3) The driver then maps the entire vma to pfn2 in fault handler
> > 
> > Given this context, my questions are:
> > 1. How can we reserve the memory type for pfn2? Should we call
> >     track_pfn_remap() in mmap() in advance?
> > 2. How do we untrack the memory type for pfn1 and pfn2, considering they
> >     belong to the same VMA but mutual exclusively and not concurrently?
> 
> Do we really have to support such changing PFNs in a VMA? Are there existing
> use cases that would rely on that?
I don't know. But it's not disallowed.

> Would it be a problem if we would merge the mmap+track_pfn_remap, such that
> such a special VMA can only ever belong to a single PFN range, that is
> fixed, but PFNs can be faulted in lazily?
If we allow a fixed PFN range to be faulted in lazily to different physical
PFNs, looks we can't rely on track_pfn_remap() in mmap() and untrack_pfn()
in unmap_vmas() to reserve/untrack memtypes.

