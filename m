Return-Path: <linux-kernel+bounces-169973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8498BD000
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6B12844B6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E2213D2B1;
	Mon,  6 May 2024 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SoSOt3LO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCAB13CFA7
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005153; cv=fail; b=t8xCiChGRp9XgsexkeNBLg7i7iKdsfIhnuehgYlLLEE0n0O6yVcTz3NdmhlSO39espQ7RLJ/9whoWEpP6YNMaoSyn87bIV1OF1o2vIStJc1E0CUxXVXlbdV8N/rEQrBdD+pIeij0Oda2FByOym54oqVnxh5h6f9jgLKONnW3eF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005153; c=relaxed/simple;
	bh=WOTtMDMh+a2DhjvnskyhgWGoJDEXWg3uEtScpNkscF4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h48RkcubCW6PcirSHvDJX0sCszLPg1B18hbenVKnhhsGlXdZSqIfSCcKrO6YpD124MdeLAaqSLU5hoGF/0gvYb4lHBAUbkJMlLhG9vifhEUbVEhex+wxm/rdFc74y91CC9PZhWZp8yQVlQ4ZtZhN6quOQyggjsYsOiZ6d6+faME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SoSOt3LO; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715005151; x=1746541151;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WOTtMDMh+a2DhjvnskyhgWGoJDEXWg3uEtScpNkscF4=;
  b=SoSOt3LOeIb9Tu4saYplG6guMTuOws4QlhXi8rOcuW3KH45cMs5xR/+N
   I1Lc5cew1uDyZQ/hbBRWwyLRRmrOy0zOUQJCJ/g6uUUupSa3jlaj/R8wE
   gIa6bmXCR2lxsIxdWkMH86ml2BqFRi79OKDLNM3f3oaR2IiVAQR7cdKrj
   Kt+ZoCy5ua1Mj3QN1XUCEMcmZwY3IfrusZwZqHnt1eqjVhB5w4PQll4ey
   FLAPMhH7nb3Ls4fDWz72+AAmG8bdu5xiox3eBtXy91DQi5uJSFMKAJK8v
   x0BsNqCxsKFQlMK8H2fjVQ5spS4opQmNNfShmYUYX/xUyxZGEK3EyyWa2
   Q==;
X-CSE-ConnectionGUID: TPjokEGcSuW/L1TzSwk/lw==
X-CSE-MsgGUID: hLX8kNptRC+FXzGQIsY2Cw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="13699377"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="13699377"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:19:11 -0700
X-CSE-ConnectionGUID: R8YD0AraRUOucI+GEgGgdA==
X-CSE-MsgGUID: jBK4ZMzPTfu3OfaNqwU1Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="28266413"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 May 2024 07:19:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 07:19:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 07:19:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 07:19:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSVDmIO/xQSHe6C4QYBpnwfZ2K2SJMoN8sSEo1wcDDNC3Dx31zP6lRY/Ky1rrVVwemwKqEsea52okFF3iQuG8WrZlp2CJrC3qWr9m10udDNPGpyv8cChKduLRtou3AVhHVR+WNHCDKSU0isYe00MwVuuW+UA8RJW1N/nYKA3xub/hxI6+gu1j/5vMe84a921XQmC7EIc1+OvqS0dbLgUi1BGLQqmJW72Vjz+3CrzWOnrknFY/o68qAdijKL272ck+qy7y66ip3UyFQk9V5KOPcK2BDRykwKl8cYJor9oB8BlIOzx2nyZR2tblIfmlquCFOeANKxxmzavFUy4KkjKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=za10a0HHNAT8KToXtoGGAJdWfNA+zvU8JoBEk6vPAmU=;
 b=XJpoS0Z30fpFOt58VxgfsST0lW5qczS4uuE6uvOMpxPUtmEEUQ/bbNjKrqKKG8plXxsiLdFYGuk5P/f+lROGBI/nqxKZARKFs4YJv50RBVIS2mSfN6RjR6QI0O4GQwispYFp4Zbx8zPaT9anxuPJzXqaHGdWpIlhZ7QGFNQUyWL+yjuZO7cb8+uiwSwF3u4dqI6S/wmX79MkvkfQlXn2E1Ohb2S5L3Lsyc/pXvqbQzo+04CAkIKLyP29mLQ3wZj3xXm6z/SukQkZzg9xnxK2WQC6QiH9y5WWYnIaSnSYLFZ/hELxyHGopoOaHOsMlbzJUpAH1yY09F/G2z9HBMSIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CH3PR11MB8155.namprd11.prod.outlook.com (2603:10b6:610:164::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 14:19:07 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 14:19:07 +0000
Date: Mon, 6 May 2024 09:19:03 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Julia Lawall <julia.lawall@inria.fr>
CC: Matt Roper <matthew.d.roper@intel.com>, <linux-kernel@vger.kernel.org>,
	<oe-kbuild-all@lists.linux.dev>
Subject: Re: drivers/gpu/drm/xe/xe_guc_ads.c:103:21-27: WARNING use
 flexible-array member instead
 (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
 (fwd)
Message-ID: <mh2gsbjvntxyiyqle2popu65535l7jjlc7nu23dzhbjizitmpv@xfjshq6lrh6s>
References: <alpine.DEB.2.22.394.2405051317090.3397@hadrien>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2405051317090.3397@hadrien>
X-ClientProxiedBy: MW4PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:303:b6::32) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CH3PR11MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: b2cbd843-7b94-4ce7-40d9-08dc6dd77d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mJ5oKBec5WClX3C/426l+iPcppLeNi1ruFfafvXn0nRQ+NmovwHI95puMmf5?=
 =?us-ascii?Q?20pyA6zF3Vesx8ZjBcnGLLd4DrpEQlVboNlfZxX3UMOjgdnBhwyNQlCHbW9X?=
 =?us-ascii?Q?s4Hfx6k6ak7jRraYBLWL9TekrcL5vxwlrug1dllaIdAAuvT+0Pq5W2+jB3Wh?=
 =?us-ascii?Q?GnMolLTJ+QsAO6LJaWyCYGyMNK/RzUf5qlv1kKKsiXAXfF5Ripo19IHJTrEt?=
 =?us-ascii?Q?uzL2ccfnt9dt8vInSIb55M56aF8DtdygtSi3mVl736Wu//v/3o2ZZYrfaN2M?=
 =?us-ascii?Q?vy7/9luTxQNbBEgL/zH9v1NA/MnRlQUj7iC57KLWxCaaIcOEkafEsumYST2r?=
 =?us-ascii?Q?9eqlY2/iPFEfPEYiOOy7BExlgamNarrZE/g31/ckypJ2smhoO3M/GEzDE15Q?=
 =?us-ascii?Q?GidhaYI0NRYqkGkHVrGDhccqkhvL1M/Jkokrbp8QLN+FbmkPCE9/uewvJE/b?=
 =?us-ascii?Q?ewDWIZwT37SHOwvq9oOG09NIwZWwg8OVzivPoIbdpvhtsMeoPguE8DtPN9BC?=
 =?us-ascii?Q?RBpPms3HSvAwcxJGGInxUkFBMb1yrSZ7qSDfBTJtqt0Qctwoyafw+o17fn7/?=
 =?us-ascii?Q?OxkZwmJF3tbwO8IwJJBtaxzf69w3VgR8iwYgIUU9dTwXw3XYTAUtEbblDgxo?=
 =?us-ascii?Q?KJEgAdJkWCrHU9rdwDyZG3/Pf4M9m1hnGL2lOXzcX8w14SeyghW+kZ2MsBDc?=
 =?us-ascii?Q?HyjBgWswHiAI8SxfoIP6evEr9j1VuSjMyPDoK27/Y3ocKHXjWy8vJmEaEFmX?=
 =?us-ascii?Q?Kjyb7x7rcVJ2Xy07GbE302CpRfdpLcnWV7vxHbwYbq7F53KywOo6IjbPA4Qi?=
 =?us-ascii?Q?Jx6tc9+49O2Cbd+5AGgtpgBH45GCo3NMvqkkn4zaFQ0bQvOPsPOfIYaz5t9C?=
 =?us-ascii?Q?pFKyX64zz732PQC2KdzZhF8L/AZ89vNrjIzkecR5q/ltVWTK2576m14cHvfW?=
 =?us-ascii?Q?rWASna9qO4NyBWdduAJg7YOYyI2yyRZCfQDK1fwDs9907KUux530wrr6+jk6?=
 =?us-ascii?Q?C45DXbpjTrgmHj7XglR5ayx8kKeunZpFlwj04O3pudj09+8zFtredubaXHuU?=
 =?us-ascii?Q?AF4+MWTiZ/b0FJXOItlL2bZbZhBGpeSayLYct8f8a5Ojcd2qpU2w/EiRpBT/?=
 =?us-ascii?Q?+J7oEPRQzGSYuVNV7e7F0qVfmoCjzaYhh3KFUwBbYiqPViQZf9j7XCa0w4sN?=
 =?us-ascii?Q?45+qjY+kOuysVk5ZkuOYcTv6msz0UEruuRpJuuB5//MOGZkLZXToxLLIDGE?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?emfGfKjBzL3nCz5S3lLx23KzRIcttVUBh23//MgYm2bBGLNdNgAFk/VNOmb0?=
 =?us-ascii?Q?IfBrrZGh6kWoFclZyxLPP+Ss/O8ch/tjSogg909wKGW/vixbtHhqMkfRcCLn?=
 =?us-ascii?Q?pCRWfzMhjIC3rIdxcJjivATr0Abto2q8q8VunaopjmNOq+oqA2UFt9lXLwxI?=
 =?us-ascii?Q?tY1eYshRRz0PGlPs0UJ3kglRfO05miNIVbhRFCsYa7qBS5xpOaYVa8+N+lJc?=
 =?us-ascii?Q?dTkD0s+O3n5S8rV+fLVfr5VJLmI7Gjj7/lror07c+JPXJ7M716CemPgWzn9J?=
 =?us-ascii?Q?3Yo+2WD3NU2uXYKb1xorXwXzMb8TnBdk1T0eSCVvJzvwpUD3ygsDcLCyMbit?=
 =?us-ascii?Q?vT0ne+UDU9S8t4QEKzw+7mTBFnB/kGLpdRhWanGd02t7/DmC5HCcv7OyFB2r?=
 =?us-ascii?Q?D8T/NDLB6B+JZJWKcyaAmtgiZoAovlNwdpLCuKl3VUVhyW7ZhZaKRqh3U/TP?=
 =?us-ascii?Q?vRq+MvwNwchCBZkPSvGn2esNzSPnb73wDP6AtDzsmIUyCHFO9kwl0zTHX9LB?=
 =?us-ascii?Q?zKLcLVcxFKvHwbxFfZcEwb+ldchyO+RcRQRMNYpT8vzenmyKG61VnO/WnMaz?=
 =?us-ascii?Q?kLa8StNFjuaHvEtBZIkDT0D3ojvKVMzLrw5jox3LVlLMYbPP8Fqw+K1fqu5E?=
 =?us-ascii?Q?g6C0iqTkkP8JQEOSvVcCfrNphOW77WVnKrvrq2PFUgGVsff4ACFl4brRdV4b?=
 =?us-ascii?Q?ovpcRKOob4oeSbcRi6bbKjUjMcJO3BXoEkLOPPlDqhJkhDRxdYGFtrbUUb0m?=
 =?us-ascii?Q?h+hDGEYVO//YJ+/akIH5rC++qPkDQxHl4xcbQ5XrGsB8Y5MJbzVmWFI+wFQk?=
 =?us-ascii?Q?kiJ+NI0K9Iu6F7nkySFrMb9n8wFfthk8PxC1W5sGvp4DuLduvXHMrECZKB/Q?=
 =?us-ascii?Q?GzgbIBDcICXnMlawcUe5/KF7UIbg6MlMc58FhbOdgwm4d/F7HcBL6M878yDi?=
 =?us-ascii?Q?4dzKeWTmowzaC0Q/XXEML1cuA5nBxrPKzZOcPe6XZXHPRVgJ6CSVkW3yfl9T?=
 =?us-ascii?Q?7YXgjtlkDrHvJJM3XdFypD7HIxFI0P4QUiZ8NwHuEN3oCyUu9bya06a//tzK?=
 =?us-ascii?Q?JslFGw8Ir2gbAGEKUU5U8tkcFoac30imbA7IkocdIuFVTeXi0z0AXgT6q/H6?=
 =?us-ascii?Q?AVRJPM1JTv29E0A0Wyc5NRXXCiNC1ky3kS3/UHXbqW2WZCD4zQlTiXDs4ApZ?=
 =?us-ascii?Q?W7CLJr6sHHsP90+tUY0+Lq9/F6E0s2IkvsJoSMcwbYNyCzoLt2/0hOLqssek?=
 =?us-ascii?Q?6ShD5EgmCc7XHWK4503HBHpq/eg7XialWyP94/9hlUbtJXGat6WATdFj1Du8?=
 =?us-ascii?Q?oi/AB1fFmx9rKuFU+RXV3bnXxfjV+cGH7Rd2SHKMy8XHXvCaHWphanVrp3vC?=
 =?us-ascii?Q?EjE4+nU2RysXE0IrmzwMrsag/ssHp9MS/bvJMzpLW7WW8H9ZWXNBzPhZVpDk?=
 =?us-ascii?Q?yCXfe6tfh3jZ15WG/4eYp7g9NxDBtvXd3YAoJKFBBcdAerfpirTXlsnzMwN8?=
 =?us-ascii?Q?Tl+X4dSTmoGRL7960yXzjyJvld+RGJa9ZU3mPBe2XwOV40I3Rloca87VLEBI?=
 =?us-ascii?Q?2KFxsxaqBPygU8Pyid7CvZ1OopqxJ4TRlkEbhMWq9TNnsO7h73jAf8xrK5bD?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cbd843-7b94-4ce7-40d9-08dc6dd77d71
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 14:19:07.1495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7jlj8tfZ3FwG7vImopX5tb9PFzti1wWNZ7Vs/x+XrjTeXKIVGkNwnYvYD04sJh7goD4EMrq+m5zTXif8vWx6ekq1k9GAisZK5Zuu0ZQ3EQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8155
X-OriginatorOrg: intel.com

On Sun, May 05, 2024 at 01:17:59PM GMT, Julia Lawall wrote:
>Can a flexible array be used at the end of this structure?

yes, we should. Just submitted a fix. Thanks

Lucas De Marchi

>
>julia
>
>---------- Forwarded message ----------
>Date: Sun, 5 May 2024 19:06:22 +0800
>From: kernel test robot <lkp@intel.com>
>To: oe-kbuild@lists.linux.dev
>Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
>Subject: drivers/gpu/drm/xe/xe_guc_ads.c:103:21-27: WARNING use flexible-array
>    member instead
>    (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-
>    and-one-element-arrays)
>
>BCC: lkp@intel.com
>CC: oe-kbuild-all@lists.linux.dev
>CC: linux-kernel@vger.kernel.org
>TO: Lucas De Marchi <lucas.demarchi@intel.com>
>CC: Matt Roper <matthew.d.roper@intel.com>
>
>tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>head:   7367539ad4b0f8f9b396baf02110962333719a48
>commit: 237412e45390805e14a6936fb998d756c4eac9d8 drm/xe: Enable 32bits build
>date:   3 months ago
>:::::: branch date: 2 days ago
>:::::: commit date: 3 months ago
>config: i386-randconfig-054-20240505 (https://download.01.org/0day-ci/archive/20240505/202405051824.AmjAI5Pg-lkp@intel.com/config)
>compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)
>
>If you fix the issue in a separate patch/commit (i.e. not just a new version of
>the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Reported-by: Julia Lawall <julia.lawall@inria.fr>
>| Closes: https://lore.kernel.org/r/202405051824.AmjAI5Pg-lkp@intel.com/
>
>cocci warnings: (new ones prefixed by >>)
>>> drivers/gpu/drm/xe/xe_guc_ads.c:103:21-27: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
>
>vim +103 drivers/gpu/drm/xe/xe_guc_ads.c
>
>dd08ebf6c3525a Matthew Brost 2023-03-30   53
>dd08ebf6c3525a Matthew Brost 2023-03-30   54  /*
>dd08ebf6c3525a Matthew Brost 2023-03-30   55   * The Additional Data Struct (ADS) has pointers for different buffers used by
>dd08ebf6c3525a Matthew Brost 2023-03-30   56   * the GuC. One single gem object contains the ADS struct itself (guc_ads) and
>dd08ebf6c3525a Matthew Brost 2023-03-30   57   * all the extra buffers indirectly linked via the ADS struct's entries.
>dd08ebf6c3525a Matthew Brost 2023-03-30   58   *
>dd08ebf6c3525a Matthew Brost 2023-03-30   59   * Layout of the ADS blob allocated for the GuC:
>dd08ebf6c3525a Matthew Brost 2023-03-30   60   *
>dd08ebf6c3525a Matthew Brost 2023-03-30   61   *      +---------------------------------------+ <== base
>dd08ebf6c3525a Matthew Brost 2023-03-30   62   *      | guc_ads                               |
>dd08ebf6c3525a Matthew Brost 2023-03-30   63   *      +---------------------------------------+
>dd08ebf6c3525a Matthew Brost 2023-03-30   64   *      | guc_policies                          |
>dd08ebf6c3525a Matthew Brost 2023-03-30   65   *      +---------------------------------------+
>dd08ebf6c3525a Matthew Brost 2023-03-30   66   *      | guc_gt_system_info                    |
>dd08ebf6c3525a Matthew Brost 2023-03-30   67   *      +---------------------------------------+
>dd08ebf6c3525a Matthew Brost 2023-03-30   68   *      | guc_engine_usage                      |
>dd08ebf6c3525a Matthew Brost 2023-03-30   69   *      +---------------------------------------+
>dd08ebf6c3525a Matthew Brost 2023-03-30   70   *      | guc_um_init_params                    |
>dd08ebf6c3525a Matthew Brost 2023-03-30   71   *      +---------------------------------------+ <== static
>dd08ebf6c3525a Matthew Brost 2023-03-30   72   *      | guc_mmio_reg[countA] (engine 0.0)     |
>dd08ebf6c3525a Matthew Brost 2023-03-30   73   *      | guc_mmio_reg[countB] (engine 0.1)     |
>dd08ebf6c3525a Matthew Brost 2023-03-30   74   *      | guc_mmio_reg[countC] (engine 1.0)     |
>dd08ebf6c3525a Matthew Brost 2023-03-30   75   *      |   ...                                 |
>dd08ebf6c3525a Matthew Brost 2023-03-30   76   *      +---------------------------------------+ <== dynamic
>dd08ebf6c3525a Matthew Brost 2023-03-30   77   *      | padding                               |
>dd08ebf6c3525a Matthew Brost 2023-03-30   78   *      +---------------------------------------+ <== 4K aligned
>dd08ebf6c3525a Matthew Brost 2023-03-30   79   *      | golden contexts                       |
>dd08ebf6c3525a Matthew Brost 2023-03-30   80   *      +---------------------------------------+
>dd08ebf6c3525a Matthew Brost 2023-03-30   81   *      | padding                               |
>dd08ebf6c3525a Matthew Brost 2023-03-30   82   *      +---------------------------------------+ <== 4K aligned
>dd08ebf6c3525a Matthew Brost 2023-03-30   83   *      | capture lists                         |
>dd08ebf6c3525a Matthew Brost 2023-03-30   84   *      +---------------------------------------+
>dd08ebf6c3525a Matthew Brost 2023-03-30   85   *      | padding                               |
>dd08ebf6c3525a Matthew Brost 2023-03-30   86   *      +---------------------------------------+ <== 4K aligned
>dd08ebf6c3525a Matthew Brost 2023-03-30   87   *      | UM queues                             |
>dd08ebf6c3525a Matthew Brost 2023-03-30   88   *      +---------------------------------------+
>dd08ebf6c3525a Matthew Brost 2023-03-30   89   *      | padding                               |
>dd08ebf6c3525a Matthew Brost 2023-03-30   90   *      +---------------------------------------+ <== 4K aligned
>dd08ebf6c3525a Matthew Brost 2023-03-30   91   *      | private data                          |
>dd08ebf6c3525a Matthew Brost 2023-03-30   92   *      +---------------------------------------+
>dd08ebf6c3525a Matthew Brost 2023-03-30   93   *      | padding                               |
>dd08ebf6c3525a Matthew Brost 2023-03-30   94   *      +---------------------------------------+ <== 4K aligned
>dd08ebf6c3525a Matthew Brost 2023-03-30   95   */
>dd08ebf6c3525a Matthew Brost 2023-03-30   96  struct __guc_ads_blob {
>dd08ebf6c3525a Matthew Brost 2023-03-30   97  	struct guc_ads ads;
>dd08ebf6c3525a Matthew Brost 2023-03-30   98  	struct guc_policies policies;
>dd08ebf6c3525a Matthew Brost 2023-03-30   99  	struct guc_gt_system_info system_info;
>dd08ebf6c3525a Matthew Brost 2023-03-30  100  	struct guc_engine_usage engine_usage;
>dd08ebf6c3525a Matthew Brost 2023-03-30  101  	struct guc_um_init_params um_init_params;
>dd08ebf6c3525a Matthew Brost 2023-03-30  102  	/* From here on, location is dynamic! Refer to above diagram. */
>dd08ebf6c3525a Matthew Brost 2023-03-30 @103  	struct guc_mmio_reg regset[0];
>dd08ebf6c3525a Matthew Brost 2023-03-30  104  } __packed;
>dd08ebf6c3525a Matthew Brost 2023-03-30  105
>
>:::::: The code at line 103 was first introduced by commit
>:::::: dd08ebf6c3525a7ea2186e636df064ea47281987 drm/xe: Introduce a new DRM driver for Intel GPUs
>
>:::::: TO: Matthew Brost <matthew.brost@intel.com>
>:::::: CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
>
>-- 
>0-DAY CI Kernel Test Service
>https://github.com/intel/lkp-tests/wiki

