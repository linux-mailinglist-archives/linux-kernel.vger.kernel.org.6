Return-Path: <linux-kernel+bounces-349207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AC298F27D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7067C1C210A8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8D31A0BDB;
	Thu,  3 Oct 2024 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDR4M3YY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2884419CC3C
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969173; cv=fail; b=hlc3A/8qv9133K/U2XKbjB+TIbQlAm3tPiePkt4KdyQPgDFP4ky+YrcnArt+84SRzR36zHts4SB2VG9D2Vj9qBfKvLRQRyCbm/hYpnorVgs36SUFzUguLK0KKT2xjEnkJjI3yVbQ6/7NP7EA/ItgKU4aSkYhExrv/1ZuCpqInNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969173; c=relaxed/simple;
	bh=txKkfyQBrh6fWZdwsibUWfgcgWQMSyWzTYtNbkVH9Ao=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EFGoCEnw+sfe0MhxfP0qGafNLPzZM9890mQfeNKM7upeMfBrTy8i3/9B5LShJAzIs2nWFWrleOtSQB25FE4RFqa/ts6Cdd9LWLC+Y4cu50hImtiAB6Ozt8/44N7eRhCl+e8BvoieTA0Npm7laI3gFNmYgdOW8X9zchalkTPjoAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDR4M3YY; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727969171; x=1759505171;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=txKkfyQBrh6fWZdwsibUWfgcgWQMSyWzTYtNbkVH9Ao=;
  b=cDR4M3YYFPReCAvYCS86j3ZQT3P54hfZJfnG+JBhywotu/0lf9SDjBdH
   1YQZSHvE4qdMrnQZaAqeDpDITtE/ajk6zrVCFpJx1GS/QGoiMFbd2psFd
   j4P13QwxfkB3K+r57ZbC/UeItN9YzsldwNIqxSzKvxERcpPNZM6hXrrMI
   J4JuX3gIGq9kXc1KFEx4URr72FvgyTEubBzJ/sl25jWZjG+LnZggQUkly
   Ll68qEGmJ2C/W7SKXhf3B5uU/mh0VgqkfYDItZs34mkW+F4n+vWmbsOQn
   /bIN+7MSO6Mvlj+iVubSBRiyc+mzKFPb5kWNvtB+siQdQwYJ3G750yELj
   g==;
X-CSE-ConnectionGUID: +iPvqrI5RjaG94DyvAepsg==
X-CSE-MsgGUID: 3atwGK6bRXKhIiuN1Ri4cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="30046413"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="30046413"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 08:26:10 -0700
X-CSE-ConnectionGUID: fqDlTMurQE2ujnIqpfO3ag==
X-CSE-MsgGUID: INRwp+eoSwe6ryZklJBlTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="78797052"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2024 08:26:10 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 08:26:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 08:26:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 08:26:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 3 Oct 2024 08:26:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 08:26:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpfoKDjhsp8T6YwyX4Fmf+Xlit9JtPpXTI/S1Rbm/P8xY86HwyTYV3/XTNWAWdIxUzdSRskchuA9IQzUzoPPYsn75EIdr6Ukra3y4q2TmgkYDi+d+QL0aPpu/MW2P8dUemPrW5c7U0Th2g5Dtb3rOkO66lLVXT05nIvUiJ4O6zKpz8SIjfUsUv+vD4Ih8yivX4KbsByWIJf/rOPW8MaCCxxW7J810TDpiIIIv9fCxfoRbOPu7803RzwtboBe+lkFQYa3Jpn6dpaWLbq8IKPKUhdkN+VLJg/YstkLnjR7/DTuE/Vopyl6nGRaesaBC1VFo7+tfoxd6i10+ZeXA6Fp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9xG4aVYvGFtEnATqSFKtejO27CeDxaY4BaZujapS4g=;
 b=CPLREanR8+IdRk3SYqnNfzgaR1jmNuo7/niVFHx4YbK6xoxoHD6efOFpUuAFFM9hbbLzY+J6D0rVsJiMiu6bx9Mh9PFrdgUCVcoTTPAfy5mkpeP9CAMk7XBQLODfXXuh69RrpSD47oy8SuLhXuoxXtWYDs+V1CnEVuagf0kzMCpZzgoMpOBBnZ5mzxpVEpaB2F70hyYG8lZTM9ZD2d9z8Vn847+F6ctnU4aP7xalP6qHk1Jwq3HWcp7YL7NI1mkhrpdKlNV2EJOqkPMZra5aS4jPjyaBf/DEDbxIonuaQICqjJOdFQLblashMQr3m8gHGAii0OyXcL34EknyhchPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by CH3PR11MB7203.namprd11.prod.outlook.com (2603:10b6:610:148::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 15:26:06 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%3]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 15:26:06 +0000
Date: Thu, 3 Oct 2024 23:25:58 +0800
From: Philip Li <philip.li@intel.com>
To: SeongJae Park <sj@kernel.org>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: mm/damon/reclaim.c:252:15: error: implicit declaration of
 function 'damon_commit_ctx'
Message-ID: <Zv63hjE1oT2A4tET@rli9-mobl>
References: <202410020227.oOh0SBIj-lkp@intel.com>
 <20241001221712.88016-1-sj@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241001221712.88016-1-sj@kernel.org>
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|CH3PR11MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe6a3f4-3e45-4859-eb71-08dce3bfb313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DW5aSDs6R54AZaM7cRN3ZYID9XXFa28sV6cAYGcfS0g4QbaqQZLwAIoPGoct?=
 =?us-ascii?Q?LQNajRf+06JYrJR8uZfvE/0St4zM/xhrx5CBVYNh1za7+51OzAoZbbSEemCr?=
 =?us-ascii?Q?CEA0nwNnIrtsj37clK5nN8X2y6gu3dnOVYu+WyQB2KUDNM7f4/o9N7fIMwyN?=
 =?us-ascii?Q?tQQsM8UhelVEkimo3Ik5SUkfA8XAkwRmMgFbl48lDAEhxdizaY0BS4LEAUka?=
 =?us-ascii?Q?0mMO9WZVfv+tZXj7CJwObNDAqo7eyTkdxtSBrxs8KWsnZNG+fufJFafhusyl?=
 =?us-ascii?Q?szw/fRmsemGh8ylYAbcBNN9dEL5460tSUfmTL3MU2mHCzdwLCv/WXuEb3hCc?=
 =?us-ascii?Q?U88gnx/ODVhHdOmp/npFNHSQGnd1VJd0yHgt36oH9gXBxIXuqrddO3g9mcRt?=
 =?us-ascii?Q?fpm0ktRjhihGcGBErGiEW7WvzxZF2w2lX/OFb0MxpkWEnDdEP8UHQgCCJMFG?=
 =?us-ascii?Q?kC91N4uOPt2Av+IDbyDSKyonADJhRWP7y0Hgp7aSFVyndY05mMpw6Ph4Uv0c?=
 =?us-ascii?Q?xR64zdeVdKqgaC0vH5R24+QbcpVIyVHVAi3m+2WEbLWUNFxThiq+1DS3Laqc?=
 =?us-ascii?Q?OXYgrmvEGqtohO2MVqIU0aGH9G97mi/4Uf2EuuOluwItGz1qdF3SyvKIXbI8?=
 =?us-ascii?Q?tnSCfBDsheT1WOJltGjj0dMW4i6hOlVpsyn1NjkogiJpJ4DRvG4lIOvj1ASq?=
 =?us-ascii?Q?soacO+YccTTdg1Y3JenU+DjqKFmgDMx9qNv1aw8WoTcKWALtcN+Wm+lXar9Y?=
 =?us-ascii?Q?pEa8HdiYWqQ2fPcCLiw14AVJTCpklBQ+hjH2zQkjcA4BNLw5436gE9maJVFj?=
 =?us-ascii?Q?XJQ8hrQ+OkxF0zo4mDjTdP/1tXm1CO0XGHBBwRpTHrxuXb9gyKOcksohQFrl?=
 =?us-ascii?Q?QJE6NVkFFr5YiOxkkPVWgHKGNyWgA7TGdj7JkzEKI/oKVSmC+jDPjDyOtRVb?=
 =?us-ascii?Q?HQzhncOfT7wyqMgPGXl51yL0x9M6N6rme+4hf+vURtMNUfDvCSw57czw7F51?=
 =?us-ascii?Q?S95cXeQOwTCKepeet7XRUxDHR9pQOkGAQF70WYrtqFBRGHwqeMcWBSRvFJYL?=
 =?us-ascii?Q?iLzk0G5DWS8vhPzEdkcMNw2MKMo03JD+umRr2PGQNtPF2FQZXL7GCo3V4jn1?=
 =?us-ascii?Q?sHRTaFE5meSpxW2bgH5tXP7GuubkXKOxwFrrPFjttWmha9TF2jyF/shLjgZ3?=
 =?us-ascii?Q?e3mbdN5DJ28QbUqMEzl8dul7+19KGERuPzm9fJtvvlgNhSj2QlRQMsVzOzA?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GNNAyNL1gPzMglFDMr03B25wbgPFdJta/ZA13C4RfpGU9FyqUhwFLS7beDN3?=
 =?us-ascii?Q?+2uPYPMfuUUgTZiW9JWCXhdT323TuwFe5VgE2u2t14GTcIWjmlMD+kRke3vq?=
 =?us-ascii?Q?85KYwS7fEEelP2ohr4ZlLG/Eado9UElJpwlSs7RGTfLniqLEFbCVZFhV30Of?=
 =?us-ascii?Q?t9aLFYumAK+wGgpKRbwYxmsycjYFYGxqQT/5NKroGab5Ffqhr+KIoToe25RQ?=
 =?us-ascii?Q?LUthAvQlo++4+z2PMUUb039IqrSDFNtFhoKnSpHU9dLeG/ye7NLQPynfV0rG?=
 =?us-ascii?Q?RHujNuvTfpK9hn7W4unI/bIHGVXe8UdsDTXRNViqzlzoqv0zyFB29dZ+N7HX?=
 =?us-ascii?Q?kHnnpPJhpkw4he0SiGL+B4Xkg+zwkM+NDIq3j1Rt+h/JWtG0a6jnapIRSMKs?=
 =?us-ascii?Q?Cy7qmEW9XpP5z/MGddZvEhBjuscpo+eHeJ85TW3MsdyLxRgMlWVcTezRjoSm?=
 =?us-ascii?Q?fm7Av/VaPTexPmKmfSdYMhPuhtTAVTpxLKT3R9LoIoeSVVIkYYoo0sYF6WZk?=
 =?us-ascii?Q?RcE9lLF5KLjIiJyQbYNazVSq6Cy9Lyg4NxkE+N6JXVo0cz3Oi+9x22oqhXOe?=
 =?us-ascii?Q?IF1NtTexJeVQilx5jBFApP1zGyhZkTi2l5UsZRUESCnSwtbwjcUT3WU2lOxU?=
 =?us-ascii?Q?mf5dRjVAhAFk5CHXn3ERVFfE/6gO0SWKwZTHUf0/8PTLE0mux7PmdcAR6+VH?=
 =?us-ascii?Q?UZ8bMStC6HIAMDCAz3xEUCMIkXArast7d3TSXlNAIn9aeR3vuLCYZqJxqKvw?=
 =?us-ascii?Q?VzK/08h+wTbiRjZNXrTTP2jRxgPu6PkrRHAc9teiekBuqoEgSG5G9qjzAnKx?=
 =?us-ascii?Q?onBoGip+2ntByTVwUkCTIWANNDNI2CqcjXzDGbr/tUgbfST4mUTD685N2B/5?=
 =?us-ascii?Q?9JJKlcktaQ8R7PGemcoqK2EA8aWC4v6akQG9+kXAvgezOqGAHJwCwIGt0X7a?=
 =?us-ascii?Q?xjwcbY59ycgckWSJpdSmgGxFUV3SGA2oLPRZnCM3r1vohdnTI1sNZe/RE2If?=
 =?us-ascii?Q?+YXzDII0ksY0U18vYkOLIyY9wjOQ4S+niz6jav/zdk1sDWhb0kIC6hFTdgxc?=
 =?us-ascii?Q?7AKWyVZOyk/1tGxbTlp5PYVVFLFxVwxrE4lzxuk3DHX1RHWV0rXWPNjAT8CV?=
 =?us-ascii?Q?9e4GlBeiBOSRZCTMmL/fpl8xAlv5RnqTxI122Awe4Q1dSNDJYrcWPe1K3RsH?=
 =?us-ascii?Q?Ri+ML1K1U6yHp1c7QoW715LMcp05k0x/G1gDyF0+1Lm5WOvE1fXXB5f+SKtK?=
 =?us-ascii?Q?pD3dM7RMtNMXpM9jZ/tXRurY8qK2sY2XbZGkl8CQfDcqAmOWBJq+N3jqO5Ot?=
 =?us-ascii?Q?9jAZ4ZPbw272E23+JI4w7h0sRo0ZfyDmMYcT6c8+5YZ8I4/NFp2aUP00EGkm?=
 =?us-ascii?Q?hwFlr+IlyaJPudZcbY2bRx7Fam0Sia+BFrCMIAa193NULiu/fNoB7iN6vW+E?=
 =?us-ascii?Q?qUcQGPyIlgTbfIr4BjC54mERpN6ZFwgwEcuXPlpciTkwD3GzJvM616q8wlIU?=
 =?us-ascii?Q?nwaNKa9R8YPDjJdRUneefT6KG3VDm0F31smh1ZzwMgHyyC9zRsVPyxaPKJVE?=
 =?us-ascii?Q?TDGiz7oVuk/uiv2w0OrBSNaikZ08WXNIbGULpWH1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe6a3f4-3e45-4859-eb71-08dce3bfb313
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 15:26:06.5385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xySkyS/2Jyz5NHqePzIuSj68J9a/nbQ/o8tRDH5dYgTDTbCnidJilfYPXervSClq9RSgeSFVOvFyjm9FD8Egog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7203
X-OriginatorOrg: intel.com

On Tue, Oct 01, 2024 at 03:17:12PM -0700, SeongJae Park wrote:
> From: sj@kernel.org
> 
> 
> Hi Robot,
> 
> On Wed, 2 Oct 2024 02:09:06 +0800 kernel test robot <lkp@intel.com> wrote:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
> > commit: 11ddcfc257a3e8d7b13b42148ee7e783f4876da4 mm/damon/reclaim: use damon_commit_ctx()
> > date:   3 months ago
> > config: x86_64-randconfig-001-20231120 (https://download.01.org/0day-ci/archive/20241002/202410020227.oOh0SBIj-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410020227.oOh0SBIj-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202410020227.oOh0SBIj-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> [...]
>     mm/damon/reclaim.c:247:15: error: implicit declaration of function 'damon_set_region_biggest_system_ram_default' [-Werror=implicit-function-declaration]
> >      247 |         err = damon_set_region_biggest_system_ram_default(param_target,
> >          |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >> mm/damon/reclaim.c:252:15: error: implicit declaration of function 'damon_commit_ctx' [-Werror=implicit-function-declaration]
> >      252 |         err = damon_commit_ctx(ctx, param_ctx);
> >          |               ^~~~~~~~~~~~~~~~
> > >> mm/damon/reclaim.c:254:9: error: implicit declaration of function 'damon_destroy_ctx'; did you mean 'mm_destroy_cid'? [-Werror=implicit-function-declaration]
> >      254 |         damon_destroy_ctx(param_ctx);
> >          |         ^~~~~~~~~~~~~~~~~
> >          |         mm_destroy_cid
> >    mm/damon/reclaim.c: In function 'damon_reclaim_turn':
> >    mm/damon/reclaim.c:263:23: error: implicit declaration of function 'damon_stop' [-Werror=implicit-function-declaration]
> >      263 |                 err = damon_stop(&ctx, 1);
> >          |                       ^~~~~~~~~~
> >    mm/damon/reclaim.c:273:15: error: implicit declaration of function 'damon_start' [-Werror=implicit-function-declaration]
> >      273 |         err = damon_start(&ctx, 1, true);
> >          |               ^~~~~~~~~~~
> >    cc1: some warnings being treated as errors
> 
> Thank you for reporting.  I tried to reproduce the issue following the kind
> reproducer, but I was unable to get the error.  Maybe something in testing
> setup is wrong?  Please let me know if I'm missing something.

Sorry SJ about the false report, kindly ignore this. The bot side will look
into the detail to resolve the issue asap.

> 
>     $ make W=1 O=../linux.out.kbuild/ ARCH=x86_64 SHELL=/bin/bash drivers/iio/accel/ drivers/iio/chemical/ drivers/iio/dac/ drivers/input/touchscreen/ drivers/mfd/ drivers/usb/host/ mm/damon/
>     [...]
>       CC      mm/damon/sysfs.o
>       CC      mm/damon/modules-common.o
>       CC      mm/damon/reclaim.o
>       CC      mm/damon/lru_sort.o
>       AR      mm/damon/built-in.a
>     [...]
> 
> 
> Thanks,
> SJ
> 
> [...]
> 

