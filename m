Return-Path: <linux-kernel+bounces-279542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD694BEB8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7821F22248
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C66918DF99;
	Thu,  8 Aug 2024 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJuwNG0N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92033148307
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124746; cv=fail; b=R9ulhvpyb2xlPysDVtyoFkHAQWGLZQ5ZVEjA3lg3B1wNX9Q0R/bGgNPWtDnProSgc8/wfXCcMcrxAY3zhDuBKoDXxPp0NJX3lPnAe/WLUAprWnct1yrLypAUPWKiVVEj4TUwyPxE7nvd+UFADxIhTYo2iic/rQK5jc2Bn7gbTtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124746; c=relaxed/simple;
	bh=pJbF30zBl4N4MNyKjpAZVX/4MZEfQ0ViSAMBLb2iC/o=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=LUoiEtw0sMMFSKOgawYjgDG7vT9fl4rEXad03ZquBMCqK2P6Iz9vwkyCx8W5OojTf0wX7r+zEZsIbUAqCDdwD4+8fptbi3mdNgVKiW6jRU97y0OUw9OiadyGvnoXQ1q6Gha2yEG8mRPwAvNJo0KO2OERmNacxXvH3NNoqumUHlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJuwNG0N; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723124742; x=1754660742;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=pJbF30zBl4N4MNyKjpAZVX/4MZEfQ0ViSAMBLb2iC/o=;
  b=MJuwNG0NIYSOlFcHsUdHaMPiIfTszc7j56i9efIqkpaRiie2ilBF98YE
   AEeK/veuk0CUYeLA4GHtjOotd0QiaQOcuc/AelWD1hhoouWByqoAGlQK3
   UAiiNuFEuKaVDvLp1HimgugAVw49dePY6ENbLnpQ/1pqTIURDOj5Rh0kR
   gTZV8AS949ZE7130Oit2dFDP95IyHhE3gS11cXr4DDDMlRPq91hPeLT2A
   Tlu4BTRlPYR6z3MjlUDEYYT1h/3PQCCz38QV0hhGfq0n1gXRDUHdkEVSn
   QAMhHJ3Z2p2Dht2FrIpVuwzGJdK/yLvmnF4Hd5Na7LqcojmOJLzHZj9mw
   A==;
X-CSE-ConnectionGUID: V/A4B7X1SjatG3HIlQ8QjQ==
X-CSE-MsgGUID: v3XvFZJAQGKhyT+draRhcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="24158950"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="24158950"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 06:45:41 -0700
X-CSE-ConnectionGUID: 1ZtFhXE5RSWRMC7vp6/rEQ==
X-CSE-MsgGUID: OY3bO26ORjyh1G7kcU/fqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="62080783"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 06:45:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 06:45:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 06:45:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 06:45:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbb7PbPdVJdsQXdOAhuCJ0HkCX9gp2jYXcD94wh5CZpt8XE+uTD5+t44oD5qXMa0zyfvMNs6bQoo3pSR6x88arkFqG6S7ezXpXMMAZAabINbAhQUcixdGleUmvseTmCul43pbt/FIUPjU87wiWwCjxzrg7H83YSiiI6L3rWuwAvZY+BE9cd2/3WXyr3FYnCPWu9XdyiVGAihhyxSSIKbbtF2YZr96NozJaBhOcxsY2mJD3/Ppwl19dRAZ7aRCvtMan+a/++1LYzpv1v8jlHtJJZJ08oBSjuKbTmw2g5EnecopHnMf6eoBXFS9Hb5srYuou2MdysXof9iYZrT8vVjyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4c/Qz437/dulakJ0bxnUXigWHo57Ory4h5myNdE7S/U=;
 b=l/Aw/T1Jvgx8BxSXEwf4tMd1khXnrbMeOqUqFrN/XzuKEmXtXQ+7ItTauvQaKku16VdX1KgpNlPuCtYT8KWSoklVgvAPboDYTwSx7TBrZxDpJTKPlY4anv5Az43JI5y6fgCTsJ6H04F1jZpHmPEz4+gr2M6GBY/jHrE8Us9nWBCXKsxwGhqtUpIYUD3DcrFVeA9QHkvo3vtKuJhxYwQ/9rcddLshuMV8/dcxKSL0/anpycrVCj4y9XQ2eikIXMbdqMAU8O+g5+o2ix3OEddBDIZhLq9A8W5Kw57znL8ln0AQRgrmcm2JPBqxkfUurDXLVtTqjrmzELu8KBD0dskLMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB6914.namprd11.prod.outlook.com (2603:10b6:930:5a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 8 Aug
 2024 13:45:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 13:45:30 +0000
Date: Thu, 8 Aug 2024 21:45:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Lorenzo Stoakes <lstoakes@gmail.com>, "Vlastimil
 Babka" <vbabka@suse.cz>, <linux-mm@kvack.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <pan.deng@intel.com>,
	<yu.ma@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [mm]  3577dbb192:  unixbench.throughput 11.1%
 improvement
Message-ID: <202408081619.d7b43303-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: fca50170-99ed-4413-35f9-08dcb7b05e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?8CaM4aDBhDR08fMLGbhdNvQFn7uA9B3DvjhmkgVVhvE4Q8ZnOp3pCsJQZc?=
 =?iso-8859-1?Q?VrKoASI2Y2bHH7c0A23Gbs/igrO5JSSCIgIOQ8O0tt+ruFemVDE4fN09nc?=
 =?iso-8859-1?Q?OH+iUSXVGnqpkPzAVRu4rZDAJxuv/571dN5xcRm6ccy8jgrgLzxFUYQenf?=
 =?iso-8859-1?Q?cdjFX3mXjD+OEsYRuW9HzIQS9PmeE9dnVIIaRd/7/142XEQELdQqx4sD2S?=
 =?iso-8859-1?Q?YIIQuQRm5niyzvEtpiuL0c65Uis530zr+OQvkijivRnb7KNvrx2TbSHJxB?=
 =?iso-8859-1?Q?cPnojY6uIsZ5g83QquUjNFcFvE8Doxj7QRLk44eZNAT3o7EU09Tfdpuhkq?=
 =?iso-8859-1?Q?Gar0czhaCtMwgCeMIgvzmREVTTJNHiP3dOhEAtnlZJ9tK6scvmEQyDDOiJ?=
 =?iso-8859-1?Q?j3mr9NGMkuCIZED30Egc9sAFdxoEXXP6kPbz/G3vy8O7dn60h49Z7DDlpY?=
 =?iso-8859-1?Q?AU0VgNigtZpwxNxvzrC7EVgEC2PgrU+u+emUdeymyT9CsNqWHVSR/+bhUE?=
 =?iso-8859-1?Q?5hascSOcAbLH8rAvU25pX1hcqSeRMpFS2zwygsHohq3derZZ20kzaAcbS/?=
 =?iso-8859-1?Q?0BXC7GLbhTpj1pmg7r8Wds5P7tKmAsvzdM/LTiN1zMQqz3v6t3GPz7tCtH?=
 =?iso-8859-1?Q?LkgAS/7O9p8I18P+dM90owZiEK6/EUbvqaVH3+TaHAs78oUycWSELvTIwH?=
 =?iso-8859-1?Q?m0nnd/Z0F1kLDVY2SbpSeBtRPYhHdP6HmLUENBucVr95424fb63CtRcHhs?=
 =?iso-8859-1?Q?u4kEIguF1x9H++I38QNRYBq0ltrTftH5nQzW1lN++/AbQLHHqoMehO5DTy?=
 =?iso-8859-1?Q?g4lclBmegzPLBWR7rekwqsVoecjWPgE6xejb8ms7PY/ATAWr7aT5fEcOko?=
 =?iso-8859-1?Q?wzuXY547oBga8PEseZZzTYu3Ak1YVwp1BcXMp6wqRywV+I1jZjfIslziQS?=
 =?iso-8859-1?Q?m7P/spNdkLM9iireoVQ0ERunKc2ffDpKiwQuiuW3UpVaM7i9P6YVYffKEJ?=
 =?iso-8859-1?Q?iOK+yGwAXVrqBp6GgIhRYIuPN5YuAUppEbatMmAhZeuXzgvi4R3rRPw/YI?=
 =?iso-8859-1?Q?/mwi9ViIcBeYN9/4pIVE0pPrIKvQFZijvqXmJlhuWVvZRrSouKO0l12uhi?=
 =?iso-8859-1?Q?XgK6t6RNX5NiBQ9DffYTtWYzoFwITQIcmcBgbPCKIerdvyXoywVRphU5+4?=
 =?iso-8859-1?Q?vu0eUi2tXe24pyoNW/Zd+n7vAlObIDXI9DGdzPRiqzRU+ROAyp9Vep1Bv7?=
 =?iso-8859-1?Q?hfi4Ow3vo0s1BqZBwzz0Ms2Jf96vhbHTIBv+6Z0hzeX0s6eGAi9y1DRwMn?=
 =?iso-8859-1?Q?6AmqJ4jh+7YAhnUigyINkuS19GaySEeeFpyeUv70g0OgN0qXYFQ0O2peG/?=
 =?iso-8859-1?Q?qmc0jqStMp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qQMEMe2ZJQtDlh/xnnVD71RtXjqoBzwRNaES6iseyGJUXsX82KznSWqqe+?=
 =?iso-8859-1?Q?pL8t8IM4YOecpv2x1Q1s7VNnri/ZX3F7I1b85PN8/ooqUgCsW9yezpK1lx?=
 =?iso-8859-1?Q?DMX3tOdNtuUTJRo7bpU4sIZwvVfGCkR4r7rSl1OQIUuimCuFTYgLl6LdYs?=
 =?iso-8859-1?Q?g1T1jGZdeTsstEUaY2EJR62ZvzfhHbq8fJPjiQWhNYy2LG71Q4QAlrRsv6?=
 =?iso-8859-1?Q?AdjDd/9bbx9JIxrgf8vFHiAfRUC16U1rXtIwYv+DcdmgAeAxHuq0YzG0YI?=
 =?iso-8859-1?Q?xHy/HVWRo5XWAf25VRCcIRqKUy5Ll3QiDVSr62Tx6Bbw5uI326tdlQms9+?=
 =?iso-8859-1?Q?kduUQdzl34AJVPPHBuePVpYvv7v8sU3DGhNKH6vD4j3+1/qbXIJoVemMeU?=
 =?iso-8859-1?Q?R9pF4uPr3bZUP++mcDICi7AAmPnqgeSX2PoXYpAlNelYbwDyv9/XZTehX4?=
 =?iso-8859-1?Q?5V+zE0ptQy/u6rJBLDRkpadhhvDca0sjWQecYszU6l7/rEXdhxZDdt/Owh?=
 =?iso-8859-1?Q?SD2p2NTKUDiQZEA+sOuD3gvIxR1cv4rVN2ZTr1qSBU6m0Q8m8ElbiR1IYS?=
 =?iso-8859-1?Q?dTcFxvYaY/mXnrwKePmlQkFebP/sxW0cJ2IKnIh6shy5tdqvwvlxPYaPmF?=
 =?iso-8859-1?Q?JrTrup6NKJtJvnQgXyoUBpC84fYJftaviaN5jA18zXK7mmHjNVDPuOLc9L?=
 =?iso-8859-1?Q?oshCWADy9duuSwmJvlNmzqZsj5Vhp9Z9O3AVoU0Tpu/WWxCOFaj804pf4C?=
 =?iso-8859-1?Q?4Y+mh6mtBxgCqJbz9dJYryd3hmPt7jdcdK/PEkKoTM/MX16/ONhP2VDk1F?=
 =?iso-8859-1?Q?BysBQ41asjHfR36j+8rXOvoeHYSk+jpw5LievOkwChKQwyG0KKdqvLhYRI?=
 =?iso-8859-1?Q?7lU2e40XwoEAzP63iPBcDFPSboXugZYL0oDlcVrAO5Ba61Ee4ZvBeGrEYw?=
 =?iso-8859-1?Q?TppSM81eoPmvRJneUL7ZS4TKZHGnGxtpDurZk4Bs3k1AqpTp3HNOPvhxk3?=
 =?iso-8859-1?Q?jSCGvihT3mU5J5II4FoET63BoQAvLNAtTP9WuIxbdnTzPVC4DMfnq0TBD0?=
 =?iso-8859-1?Q?3fAK80qj9yEtXoPIRFz1q6CXdEJHHBanfY1THY/d9x9NiNjyW4ClcQKtFH?=
 =?iso-8859-1?Q?0ESlVcvuTZfx/d0ynbP8exu0vqOvxga8D252uJ2rWRAJXgYD4b1WGIM/lk?=
 =?iso-8859-1?Q?v5o5BILWk8VAYEK2J8UJgvKwBw5mH/n40UIl8vn29fevnE8OnBCA2e+cb9?=
 =?iso-8859-1?Q?jLw6GrD1H1pGQ+/I4KSdxws5sS7uuI9ABTIXsuwe1RdnDNM55+NynT4vSB?=
 =?iso-8859-1?Q?ni4z+VyYP+Yeek8IpunhJc67hHyXH4+L6Mpaf+53ZX7t3WurVnV/t9THBJ?=
 =?iso-8859-1?Q?RIoeXguY80Yl3b2kg2TmQn+yZw/Jy4tfJGrBtY7ZVEvj6sxC2vUFwBYMYB?=
 =?iso-8859-1?Q?Jo87ZC7jUCroIckQfC2DADeF0D7dSZCFEkWxE7amiupFqOHKi5bpOMq7N3?=
 =?iso-8859-1?Q?/+utObFFlw+fglXZnsSKqCLQSF70VTUxNdNwrY8xWVBkipWKwLgoWVeELv?=
 =?iso-8859-1?Q?oelQZseAf/fynqF270hD4gvWt03/99NUyUtzDmjaAw2kL5Iz3M5N8MiD1Q?=
 =?iso-8859-1?Q?e3qc5fiwFfN5v5wTsMy/yNGGycnhEplbfu6bl2Qi5oNRnPAwnugGFirA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fca50170-99ed-4413-35f9-08dcb7b05e08
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 13:45:30.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSHZtX5JHkwRPYSEpMJTlOwB+kl728svNdhkj9umpGUrjP4FOTsiyODFkL6NAwOHrEVlKxZy5Z+gY+9tx6QYHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6914
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 11.1% improvement of unixbench.throughput on:


commit: 3577dbb192419e37b6f54aced8777b6c81cd03d4 ("mm: batch unlink_file_vma calls in free_pgd_range")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: unixbench
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
parameters:

	runtime: 300s
	nr_task: 100%
	test: sysexec
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.throughput 10.8% improvement                                                  |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory          |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | nr_task=100%                                                                                       |
|                  | runtime=300s                                                                                       |
|                  | test=sysexec                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.throughput 11.6% improvement                                                  |
| test machine     | 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | nr_task=100%                                                                                       |
|                  | runtime=300s                                                                                       |
|                  | test=sysexec                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240808/202408081619.d7b43303-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/300s/lkp-spr-2sp4/sysexec/unixbench

commit: 
  1a3798dece ("mm/memory-failure: send SIGBUS in the event of thp split fail")
  3577dbb192 ("mm: batch unlink_file_vma calls in free_pgd_range")

1a3798dececa8cb2 3577dbb192419e37b6f54aced87 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  25147579 ±  4%     +31.8%   33150147 ±  2%  cpuidle..usage
    115.00 ± 16%    +507.7%     698.83 ± 95%  perf-c2c.DRAM.local
    152873 ±  4%     +22.2%     186752 ±  2%  vmstat.system.cs
   1546545 ±  2%     +10.5%    1708309 ±  3%  meminfo.Inactive
   1546333 ±  2%     +10.5%    1708097 ±  3%  meminfo.Inactive(anon)
    733215 ±  3%     +15.9%     849955 ±  6%  meminfo.Mapped
      0.21 ±  2%      +0.0        0.23 ±  4%  mpstat.cpu.all.soft%
      0.94 ±  2%      +0.1        1.05 ±  3%  mpstat.cpu.all.usr%
    306.00 ± 13%     -52.5%     145.50 ± 28%  mpstat.max_utilization.seconds
    231736 ±  4%     +12.0%     259598 ±  8%  numa-meminfo.node0.Mapped
    958526 ± 23%     +30.2%    1248449 ± 13%  numa-meminfo.node1.Inactive
    958384 ± 23%     +30.3%    1248414 ± 13%  numa-meminfo.node1.Inactive(anon)
    497042 ±  4%     +18.2%     587616 ±  6%  numa-meminfo.node1.Mapped
 1.897e+08 ±  2%     +10.9%  2.103e+08 ±  2%  numa-numastat.node0.local_node
 1.898e+08 ±  2%     +10.9%  2.104e+08 ±  2%  numa-numastat.node0.numa_hit
  1.73e+08 ±  2%     +11.4%  1.927e+08 ±  2%  numa-numastat.node1.local_node
 1.731e+08 ±  2%     +11.4%  1.928e+08 ±  2%  numa-numastat.node1.numa_hit
    807626 ± 17%     +34.0%    1082534 ±  9%  sched_debug.cfs_rq:/.load.max
     64598 ± 17%     +33.6%      86296 ±  8%  sched_debug.cfs_rq:/.load.stddev
    125054 ±  3%     +20.3%     150482        sched_debug.cpu.nr_switches.avg
    150657 ±  4%     +17.4%     176804 ±  4%  sched_debug.cpu.nr_switches.max
    101190 ±  4%     +24.2%     125637 ±  3%  sched_debug.cpu.nr_switches.min
    615.79 ± 19%     -34.7%     402.02 ± 27%  sched_debug.cpu.nr_uninterruptible.max
     58153 ±  4%     +12.0%      65129 ±  8%  numa-vmstat.node0.nr_mapped
 1.898e+08 ±  2%     +10.9%  2.104e+08 ±  2%  numa-vmstat.node0.numa_hit
 1.897e+08 ±  2%     +10.9%  2.103e+08 ±  2%  numa-vmstat.node0.numa_local
    239255 ± 23%     +30.5%     312314 ± 13%  numa-vmstat.node1.nr_inactive_anon
    124669 ±  4%     +18.1%     147191 ±  6%  numa-vmstat.node1.nr_mapped
    239254 ± 23%     +30.5%     312313 ± 13%  numa-vmstat.node1.nr_zone_inactive_anon
 1.731e+08 ±  2%     +11.4%  1.928e+08 ±  2%  numa-vmstat.node1.numa_hit
  1.73e+08 ±  2%     +11.4%  1.927e+08 ±  2%  numa-vmstat.node1.numa_local
      7400 ±  2%     +11.1%       8225 ±  2%  unixbench.score
     18501 ±  2%     +11.1%      20564 ±  2%  unixbench.throughput
   1922280 ±  3%     +17.4%    2257247 ±  3%  unixbench.time.involuntary_context_switches
    136805 ±  3%     +29.0%     176526 ±  4%  unixbench.time.major_page_faults
 4.074e+08 ±  2%     +11.1%  4.526e+08 ±  2%  unixbench.time.minor_page_faults
     14803            -3.4%      14297        unixbench.time.percent_of_cpu_this_job_got
     58951            -3.4%      56959        unixbench.time.system_time
    620.67 ±  2%     +14.0%     707.50 ±  2%  unixbench.time.user_time
  25453277 ±  4%     +21.1%   30818519        unixbench.time.voluntary_context_switches
   7394432 ±  2%     +11.3%    8232470 ±  2%  unixbench.workload
    228239            +3.2%     235513        proc-vmstat.nr_anon_pages
   1357037            +2.3%    1388899        proc-vmstat.nr_file_pages
    386323           +10.5%     427012 ±  4%  proc-vmstat.nr_inactive_anon
    182697 ±  3%     +16.2%     212276 ±  6%  proc-vmstat.nr_mapped
    573280            +5.6%     605145        proc-vmstat.nr_shmem
    386323           +10.5%     427012 ±  4%  proc-vmstat.nr_zone_inactive_anon
 3.629e+08 ±  2%     +11.1%  4.032e+08 ±  2%  proc-vmstat.numa_hit
 3.627e+08 ±  2%     +11.1%   4.03e+08 ±  2%  proc-vmstat.numa_local
    614351            +7.2%     658759 ±  2%  proc-vmstat.pgactivate
 3.773e+08 ±  2%     +11.1%  4.191e+08 ±  2%  proc-vmstat.pgalloc_normal
   4.1e+08 ±  2%     +11.1%  4.553e+08 ±  2%  proc-vmstat.pgfault
 3.764e+08 ±  2%     +11.1%  4.182e+08 ±  2%  proc-vmstat.pgfree
  18004347 ±  2%     +10.0%   19807198 ±  2%  proc-vmstat.pgreuse
      0.93 ±  3%      +0.0        0.97        perf-stat.i.branch-miss-rate%
 1.109e+08 ±  3%     +12.2%  1.244e+08 ±  3%  perf-stat.i.branch-misses
 1.054e+08 ±  2%      +9.4%  1.153e+08 ±  3%  perf-stat.i.cache-misses
 4.238e+08 ±  2%     +11.2%  4.713e+08 ±  3%  perf-stat.i.cache-references
    148311 ±  4%     +22.6%     181871 ±  2%  perf-stat.i.context-switches
     18388 ±  2%     +14.0%      20969 ±  3%  perf-stat.i.cpu-migrations
    320.97 ±  4%     +30.3%     418.10 ±  5%  perf-stat.i.major-faults
      8.37 ±  2%     +20.3%      10.06 ±  3%  perf-stat.i.metric.K/sec
    940838 ±  2%     +12.0%    1053793 ±  3%  perf-stat.i.minor-faults
    941159 ±  2%     +12.0%    1054212 ±  3%  perf-stat.i.page-faults
     24.54            -4.4       20.19 ± 44%  perf-stat.overall.cache-miss-rate%
      3.66           -18.3%       2.99 ± 44%  perf-stat.overall.cpi
      3999 ±  2%     -25.5%       2977 ± 44%  perf-stat.overall.cycles-between-cache-misses
   6539365 ±  2%     -25.7%    4856493 ± 44%  perf-stat.overall.path-length
 4.357e+11           -18.8%  3.537e+11 ± 44%  perf-stat.ps.cpu-cycles
     42.44           -42.4        0.00        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables
     42.19           -42.2        0.00        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma
     30.12           -30.1        0.00        perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.exit_mmap.__mmput
     30.10           -30.1        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables.exit_mmap
     15.50           -15.5        0.00        perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exit_mm
     14.69           -14.7        0.00        perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exec_mmap
     12.48           -12.5        0.00        perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap
     12.47           -12.5        0.00        perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_munmap
     12.46           -12.5        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables.unmap_region
     15.64           -11.3        4.32        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
     16.09           -11.2        4.84        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     16.08           -11.2        4.84        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
     16.07           -11.2        4.83        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
     16.35           -11.2        5.14        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.35           -11.2        5.15        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.35           -11.2        5.15        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.86           -10.7        4.18        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exec_mmap.begin_new_exec
     15.18           -10.6        4.53        perf-profile.calltrace.cycles-pp.__mmput.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler
     15.17           -10.6        4.53        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exec_mmap.begin_new_exec.load_elf_binary
     15.34           -10.6        4.72        perf-profile.calltrace.cycles-pp.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm
     15.37           -10.6        4.75        perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
     16.19           -10.6        5.64        perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
     16.19           -10.6        5.64        perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
     16.17           -10.6        5.62        perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
     16.35           -10.5        5.83        perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.81           -10.4        6.36        perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.82           -10.4        6.38        perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
     97.46            -0.3       97.14        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     97.46            -0.3       97.14        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.60 ±  2%      +0.1        0.69 ±  3%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.62 ±  2%      +0.1        0.72 ±  3%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.72 ±  2%      +0.1        0.83 ±  3%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      0.71 ±  2%      +0.1        0.82 ±  3%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.80 ±  2%      +0.1        0.92 ±  3%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      0.67 ±  6%      +0.2        0.83 ±  3%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat
      0.74 ±  8%      +0.2        0.94 ±  9%  perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_openat
      0.89 ±  7%      +0.2        1.10 ±  3%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
      0.89 ±  7%      +0.2        1.10 ±  3%  perf-profile.calltrace.cycles-pp.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.89 ±  7%      +0.2        1.10 ±  3%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat
      0.91 ±  7%      +0.2        1.12 ±  3%  perf-profile.calltrace.cycles-pp.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.92 ±  6%      +0.2        1.13 ±  3%  perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.78 ±  8%      +0.2        0.99 ±  8%  perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.link_path_walk.path_openat.do_filp_open
      0.47 ± 45%      +0.2        0.68 ±  4%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_lookupat.filename_lookup.vfs_statx
      0.35 ± 71%      +0.3        0.64 ± 10%  perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
      0.35 ± 71%      +0.3        0.64 ±  9%  perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.36 ± 71%      +0.3        0.65 ±  9%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
      1.33 ±  8%      +0.4        1.69 ±  8%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.27 ±100%      +0.4        0.63 ± 10%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      1.76 ±  8%      +0.5        2.23 ±  8%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.09 ±223%      +0.5        0.57 ± 10%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_openat
      0.09 ±223%      +0.5        0.58 ± 10%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
      0.09 ±223%      +0.5        0.58 ±  9%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.walk_component.link_path_walk
      0.09 ±223%      +0.5        0.58 ± 10%  perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow.walk_component
      0.09 ±223%      +0.5        0.58 ± 10%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_openat
      2.51 ±  8%      +0.7        3.17 ±  8%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.50 ±  8%      +0.7        3.17 ±  8%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      2.57 ±  8%      +0.7        3.25 ±  8%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.57 ±  8%      +0.7        3.25 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.14            +1.0        4.18        perf-profile.calltrace.cycles-pp.down_write.vma_prepare.__split_vma.vma_modify.mprotect_fixup
      3.14            +1.0        4.18        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma.vma_modify
      3.19            +1.0        4.24        perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey
      3.11            +1.1        4.16        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare.vma_expand
      3.16            +1.1        4.21        perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      3.12            +1.1        4.18        perf-profile.calltrace.cycles-pp.vma_prepare.vma_expand.mmap_region.do_mmap.vm_mmap_pgoff
      3.12            +1.1        4.18        perf-profile.calltrace.cycles-pp.down_write.vma_prepare.vma_expand.mmap_region.do_mmap
      3.12            +1.1        4.17        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.vma_expand.mmap_region
      3.18            +1.1        4.24        perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.28            +1.1        4.34        perf-profile.calltrace.cycles-pp.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      3.19            +1.1        4.25        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.20            +1.1        4.26        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.16            +1.1        4.22        perf-profile.calltrace.cycles-pp.vma_expand.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      3.28            +1.1        4.34        perf-profile.calltrace.cycles-pp.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      3.30            +1.1        4.36        perf-profile.calltrace.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.32            +1.1        4.39        perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.32            +1.1        4.39        perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.16            +3.1       12.28        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.mmap_region
      9.21            +3.1       12.35        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.mmap_region.do_mmap
      9.23            +3.2       12.39        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      9.24            +3.2       12.40        perf-profile.calltrace.cycles-pp.down_write.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.00            +4.0        4.04        perf-profile.calltrace.cycles-pp.unlink_file_vma_batch_add.free_pgtables.exit_mmap.__mmput.exec_mmap
      0.00            +4.2        4.20        perf-profile.calltrace.cycles-pp.unlink_file_vma_batch_add.free_pgtables.exit_mmap.__mmput.exit_mm
     12.54            +4.2       16.76        perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region
     12.57            +4.2       16.80        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
     15.53            +5.3       20.81        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma.do_vmi_align_munmap
     15.54            +5.3       20.82        perf-profile.calltrace.cycles-pp.down_write.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap
     15.02            +5.3       20.31        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.dup_mmap
     15.63            +5.3       20.92        perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
     15.12            +5.3       20.45        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm
     15.78            +5.3       21.10        perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
     15.16            +5.3       20.50        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm.copy_process
     15.19            +5.3       20.53        perf-profile.calltrace.cycles-pp.down_write.dup_mmap.dup_mm.copy_process.kernel_clone
     15.54            +5.4       20.94        perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
     15.80            +5.4       21.24        perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
     15.95            +5.5       21.42        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.11            +5.5       21.61        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.11            +5.5       21.61        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.62            +6.3       24.92        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma
     21.62            +7.3       28.92        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare
      0.00            +8.1        8.11        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_add
      0.00            +8.2        8.15        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_add.free_pgtables
      0.00            +8.2        8.18        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_add.free_pgtables.exit_mmap
      0.00            +8.2        8.18        perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma_batch_add.free_pgtables.exit_mmap.__mmput
     25.21            +8.5       33.72        perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
     28.36            +9.6       37.92        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff
     37.78           +12.8       50.53        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     37.79           +12.8       50.54        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     37.78           +12.8       50.54        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     37.77           +12.8       50.52        perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.00           +16.5       16.53        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_final
      0.00           +16.6       16.61        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_final.free_pgtables
      0.00           +16.7       16.67        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_final.free_pgtables.unmap_region
      0.00           +16.7       16.68        perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma_batch_final.free_pgtables.unmap_region.do_vmi_align_munmap
      0.00           +16.8       16.76        perf-profile.calltrace.cycles-pp.unlink_file_vma_batch_final.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap
     42.75           -42.7        0.00        perf-profile.children.cycles-pp.unlink_file_vma
     31.25           -21.9        9.36        perf-profile.children.cycles-pp.exit_mmap
     31.26           -21.9        9.37        perf-profile.children.cycles-pp.__mmput
     43.11           -17.8       25.34        perf-profile.children.cycles-pp.free_pgtables
     16.09           -11.2        4.84        perf-profile.children.cycles-pp.exit_mm
     16.37           -11.2        5.17        perf-profile.children.cycles-pp.do_exit
     16.37           -11.2        5.17        perf-profile.children.cycles-pp.__x64_sys_exit_group
     16.37           -11.2        5.17        perf-profile.children.cycles-pp.do_group_exit
     15.35           -10.6        4.72        perf-profile.children.cycles-pp.exec_mmap
     15.38           -10.6        4.75        perf-profile.children.cycles-pp.begin_new_exec
     16.18           -10.6        5.62        perf-profile.children.cycles-pp.load_elf_binary
     16.20           -10.6        5.64        perf-profile.children.cycles-pp.search_binary_handler
     16.20           -10.6        5.64        perf-profile.children.cycles-pp.exec_binprm
     16.37           -10.5        5.85        perf-profile.children.cycles-pp.bprm_execve
     16.82           -10.5        6.37        perf-profile.children.cycles-pp.do_execveat_common
     16.83           -10.5        6.38        perf-profile.children.cycles-pp.__x64_sys_execve
     88.19            -1.8       86.34        perf-profile.children.cycles-pp.osq_lock
     88.74            -1.8       86.90        perf-profile.children.cycles-pp.rwsem_optimistic_spin
     88.98            -1.8       87.16        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     89.12            -1.8       87.30        perf-profile.children.cycles-pp.down_write
     97.64            -0.3       97.31        perf-profile.children.cycles-pp.do_syscall_64
     97.64            -0.3       97.32        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.46 ±  3%      -0.1        0.38 ±  5%  perf-profile.children.cycles-pp.up_write
      0.32 ±  5%      -0.1        0.26 ±  5%  perf-profile.children.cycles-pp.rwsem_wake
      0.18 ±  5%      -0.0        0.15 ±  7%  perf-profile.children.cycles-pp.wake_up_q
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.__x64_sys_munmap
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.cpu_util
      0.08            +0.0        0.09        perf-profile.children.cycles-pp.mas_store_prealloc
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.mas_wr_store_entry
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.simple_lookup
      0.06 ±  9%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.fput
      0.11 ±  4%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
      0.09 ±  5%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap
      0.07 ±  5%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.06            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.09 ±  6%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp._compound_head
      0.10 ±  5%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.alloc_empty_file
      0.09 ±  4%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.lockref_put_return
      0.09 ±  4%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.11            +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.copy_strings
      0.07            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.schedule_idle
      0.13 ±  2%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.do_task_dead
      0.15 ±  4%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.10 ±  3%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.copy_page_range
      0.15 ±  4%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.14 ±  5%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.11 ±  4%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.06 ±  7%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.intel_idle
      0.03 ± 70%      +0.0        0.06        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.16 ±  4%      +0.0        0.19 ±  4%  perf-profile.children.cycles-pp.finish_task_switch
      0.16 ±  3%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.wake_up_new_task
      0.14 ±  5%      +0.0        0.17 ±  5%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.18 ±  4%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.folios_put_refs
      0.16 ±  3%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.kthread
      0.14 ±  3%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.sched_exec
      0.20 ±  2%      +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.23            +0.0        0.26 ±  4%  perf-profile.children.cycles-pp.rcu_do_batch
      0.27            +0.0        0.30 ±  3%  perf-profile.children.cycles-pp.rcu_core
      0.23 ±  3%      +0.0        0.27 ±  3%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.23 ±  3%      +0.0        0.27 ±  3%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.24 ±  2%      +0.0        0.27 ±  4%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.24 ±  2%      +0.0        0.27 ±  4%  perf-profile.children.cycles-pp.kernel_wait4
      0.24 ±  2%      +0.0        0.27 ±  3%  perf-profile.children.cycles-pp.do_wait
      0.21 ±  3%      +0.0        0.25 ±  4%  perf-profile.children.cycles-pp.__percpu_counter_init_many
      0.26 ±  4%      +0.0        0.30 ±  3%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.23 ±  2%      +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.24 ±  2%      +0.0        0.29 ±  3%  perf-profile.children.cycles-pp.sched_balance_find_dst_group
      0.24            +0.0        0.28 ±  3%  perf-profile.children.cycles-pp.ret_from_fork
      0.28 ±  3%      +0.0        0.33 ±  3%  perf-profile.children.cycles-pp.alloc_bprm
      0.25 ±  3%      +0.0        0.29 ±  3%  perf-profile.children.cycles-pp.vma_complete
      0.30 ±  4%      +0.0        0.35 ±  3%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.26 ±  2%      +0.0        0.31 ±  3%  perf-profile.children.cycles-pp.sched_balance_find_dst_cpu
      0.00            +0.1        0.05        perf-profile.children.cycles-pp._find_next_and_bit
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.anon_vma_clone
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.enqueue_task_fair
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.mas_wr_node_store
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.26 ±  2%      +0.1        0.31 ±  4%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.29 ±  3%      +0.1        0.34 ±  3%  perf-profile.children.cycles-pp.zap_present_ptes
      0.30            +0.1        0.35 ±  5%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.33            +0.1        0.38 ±  4%  perf-profile.children.cycles-pp.handle_softirqs
      0.36 ±  3%      +0.1        0.42 ±  4%  perf-profile.children.cycles-pp.unmap_page_range
      0.29 ±  2%      +0.1        0.35 ±  3%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.31 ±  2%      +0.1        0.36 ±  3%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.34 ±  4%      +0.1        0.40 ±  4%  perf-profile.children.cycles-pp.zap_pte_range
      0.34 ±  3%      +0.1        0.40 ±  4%  perf-profile.children.cycles-pp.zap_pmd_range
      0.32 ±  3%      +0.1        0.38 ±  4%  perf-profile.children.cycles-pp.__memset
      0.33 ±  2%      +0.1        0.39 ±  4%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.40 ±  2%      +0.1        0.46 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.36 ±  2%      +0.1        0.42 ±  3%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.36 ±  2%      +0.1        0.42 ±  3%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.38 ±  4%      +0.1        0.46 ±  3%  perf-profile.children.cycles-pp.unmap_vmas
      0.41 ±  3%      +0.1        0.48 ±  3%  perf-profile.children.cycles-pp.pcpu_alloc_noprof
      0.42 ±  2%      +0.1        0.49 ±  4%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.41 ±  2%      +0.1        0.48 ±  3%  perf-profile.children.cycles-pp.sched_balance_rq
      0.42 ±  2%      +0.1        0.49 ±  3%  perf-profile.children.cycles-pp.schedule
      0.20 ±  4%      +0.1        0.27 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter
      0.20 ±  4%      +0.1        0.27 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.48 ±  3%      +0.1        0.55 ±  2%  perf-profile.children.cycles-pp.filemap_map_pages
      0.22 ±  4%      +0.1        0.30 ±  4%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.49 ±  3%      +0.1        0.57 ±  3%  perf-profile.children.cycles-pp.do_read_fault
      0.51 ±  3%      +0.1        0.59 ±  3%  perf-profile.children.cycles-pp.mm_init
      0.56 ±  3%      +0.1        0.65 ±  3%  perf-profile.children.cycles-pp.do_fault
      1.34 ±  2%      +0.1        1.44 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.31 ±  2%      +0.1        1.42 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.32 ±  3%      +0.1        0.43 ±  3%  perf-profile.children.cycles-pp.start_secondary
      0.63 ±  2%      +0.1        0.75 ±  3%  perf-profile.children.cycles-pp.__schedule
      0.32 ±  4%      +0.1        0.44 ±  3%  perf-profile.children.cycles-pp.common_startup_64
      0.32 ±  4%      +0.1        0.44 ±  3%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.32 ±  4%      +0.1        0.44 ±  3%  perf-profile.children.cycles-pp.do_idle
      0.84 ±  2%      +0.1        0.97 ±  2%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.55 ±  7%      +0.1        0.68 ±  7%  perf-profile.children.cycles-pp.step_into
      0.88 ±  2%      +0.1        1.02 ±  3%  perf-profile.children.cycles-pp.handle_mm_fault
      0.96 ±  2%      +0.1        1.11 ±  3%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.96 ±  3%      +0.2        1.11 ±  3%  perf-profile.children.cycles-pp.exc_page_fault
      1.09 ±  2%      +0.2        1.26 ±  3%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.64 ±  9%      +0.2        0.81 ±  8%  perf-profile.children.cycles-pp.__legitimize_path
      0.64 ±  9%      +0.2        0.82 ±  8%  perf-profile.children.cycles-pp.try_to_unlazy
      0.68 ±  8%      +0.2        0.86 ±  8%  perf-profile.children.cycles-pp.__dentry_kill
      0.68 ±  9%      +0.2        0.86 ±  7%  perf-profile.children.cycles-pp.terminate_walk
      0.71 ±  8%      +0.2        0.90 ±  8%  perf-profile.children.cycles-pp.d_alloc
      0.69 ±  8%      +0.2        0.87 ±  8%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.74 ±  8%      +0.2        0.94 ±  7%  perf-profile.children.cycles-pp.lookup_fast
      0.89 ±  7%      +0.2        1.10 ±  3%  perf-profile.children.cycles-pp.vfs_statx
      0.91 ±  6%      +0.2        1.12 ±  3%  perf-profile.children.cycles-pp.path_lookupat
      0.91 ±  7%      +0.2        1.12 ±  3%  perf-profile.children.cycles-pp.vfs_fstatat
      0.92 ±  6%      +0.2        1.13 ±  3%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      0.91 ±  6%      +0.2        1.12 ±  3%  perf-profile.children.cycles-pp.filename_lookup
      1.15 ±  7%      +0.3        1.44 ±  7%  perf-profile.children.cycles-pp.__lookup_slow
      1.11 ±  7%      +0.3        1.41 ±  7%  perf-profile.children.cycles-pp.d_alloc_parallel
      1.42 ±  8%      +0.4        1.80 ±  8%  perf-profile.children.cycles-pp.dput
      1.93 ±  7%      +0.5        2.42 ±  7%  perf-profile.children.cycles-pp.walk_component
      2.44 ±  7%      +0.6        3.06 ±  7%  perf-profile.children.cycles-pp.link_path_walk
      2.49 ±  9%      +0.6        3.12 ±  9%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      2.54 ±  8%      +0.7        3.21 ±  8%  perf-profile.children.cycles-pp.path_openat
      2.55 ±  8%      +0.7        3.22 ±  8%  perf-profile.children.cycles-pp.do_filp_open
      2.57 ±  8%      +0.7        3.25 ±  8%  perf-profile.children.cycles-pp.__x64_sys_openat
      2.57 ±  8%      +0.7        3.25 ±  8%  perf-profile.children.cycles-pp.do_sys_openat2
      2.69 ±  9%      +0.7        3.42 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock
      3.28            +1.1        4.34        perf-profile.children.cycles-pp.vma_modify
      3.16            +1.1        4.22        perf-profile.children.cycles-pp.vma_expand
      3.30            +1.1        4.36        perf-profile.children.cycles-pp.mprotect_fixup
      3.32            +1.1        4.39        perf-profile.children.cycles-pp.__x64_sys_mprotect
      3.32            +1.1        4.39        perf-profile.children.cycles-pp.do_mprotect_pkey
     12.67            +4.2       16.91        perf-profile.children.cycles-pp.unmap_region
     15.55            +5.4       20.95        perf-profile.children.cycles-pp.dup_mmap
     15.80            +5.4       21.25        perf-profile.children.cycles-pp.dup_mm
     15.96            +5.5       21.43        perf-profile.children.cycles-pp.copy_process
     16.12            +5.5       21.62        perf-profile.children.cycles-pp.__do_sys_clone
     16.12            +5.5       21.62        perf-profile.children.cycles-pp.kernel_clone
     19.15            +6.4       25.54        perf-profile.children.cycles-pp.__split_vma
     22.00            +7.4       29.40        perf-profile.children.cycles-pp.vma_prepare
      0.00            +8.2        8.24        perf-profile.children.cycles-pp.unlink_file_vma_batch_add
     28.58            +9.6       38.16        perf-profile.children.cycles-pp.do_vmi_align_munmap
     28.60            +9.6       38.18        perf-profile.children.cycles-pp.do_vmi_munmap
     37.79           +12.8       50.54        perf-profile.children.cycles-pp.ksys_mmap_pgoff
     41.31           +13.8       55.14        perf-profile.children.cycles-pp.mmap_region
     41.34           +13.8       55.16        perf-profile.children.cycles-pp.do_mmap
     41.36           +13.8       55.19        perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.00           +16.9       16.92        perf-profile.children.cycles-pp.unlink_file_vma_batch_final
     87.11            -1.9       85.23        perf-profile.self.cycles-pp.osq_lock
      0.15 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.up_write
      0.10            +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.filemap_map_pages
      0.10 ±  3%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.d_alloc_parallel
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.lockref_put_return
      0.12 ±  5%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.06 ±  7%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.intel_idle
      0.14 ±  5%      +0.0        0.16 ±  4%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.19 ±  2%      +0.0        0.23 ±  4%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.13 ±  5%      +0.0        0.16 ±  7%  perf-profile.self.cycles-pp.__memset
      0.24            +0.0        0.28 ±  3%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.28 ±  3%      +0.0        0.33 ±  3%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.30 ±  3%      +0.1        0.36 ±  2%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.37 ±  3%      +0.1        0.43 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      2.46 ±  9%      +0.6        3.08 ±  9%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


***************************************************************************************************
lkp-icl-2sp9: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp9/sysexec/unixbench

commit: 
  1a3798dece ("mm/memory-failure: send SIGBUS in the event of thp split fail")
  3577dbb192 ("mm: batch unlink_file_vma calls in free_pgd_range")

1a3798dececa8cb2 3577dbb192419e37b6f54aced87 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  15138189 ±  7%     +19.9%   18145566 ±  6%  cpuidle..usage
      0.00 ± 37%      +0.0        0.00 ± 29%  mpstat.cpu.all.iowait%
    147493 ±  6%     +16.1%     171200 ±  5%  vmstat.system.cs
    117941 ±  4%      +9.0%     128498 ±  3%  vmstat.system.in
  2.96e+08           +10.2%  3.263e+08 ±  2%  numa-numastat.node0.local_node
 2.961e+08           +10.2%  3.264e+08 ±  2%  numa-numastat.node0.numa_hit
 2.889e+08           +11.3%  3.214e+08 ±  2%  numa-numastat.node1.local_node
 2.889e+08           +11.2%  3.214e+08 ±  2%  numa-numastat.node1.numa_hit
 2.961e+08           +10.3%  3.264e+08 ±  2%  numa-vmstat.node0.numa_hit
  2.96e+08           +10.2%  3.263e+08 ±  2%  numa-vmstat.node0.numa_local
 2.889e+08           +11.3%  3.214e+08 ±  2%  numa-vmstat.node1.numa_hit
 2.888e+08           +11.3%  3.214e+08 ±  2%  numa-vmstat.node1.numa_local
    439795            -8.9%     400833 ±  2%  sched_debug.cpu.avg_idle.avg
   2307807 ±  2%     -28.5%    1649740 ±  6%  sched_debug.cpu.curr->pid.max
    536042 ± 15%     -33.2%     357851 ± 13%  sched_debug.cpu.curr->pid.stddev
    416384 ±  6%     +16.0%     482849 ±  5%  sched_debug.cpu.nr_switches.avg
    440776 ±  5%     +15.1%     507220 ±  4%  sched_debug.cpu.nr_switches.max
    397510 ±  5%     +15.0%     457024 ±  4%  sched_debug.cpu.nr_switches.min
     12095           +10.8%      13396 ±  2%  unixbench.score
     30238           +10.8%      33490 ±  2%  unixbench.throughput
   2931551           +14.6%    3360657        unixbench.time.involuntary_context_switches
    355311 ±  2%     +29.5%     460283 ±  5%  unixbench.time.major_page_faults
 6.605e+08           +11.0%  7.333e+08 ±  2%  unixbench.time.minor_page_faults
    619.59            +7.8%     667.75 ±  2%  unixbench.time.user_time
  26219903 ±  5%     +14.8%   30109206 ±  4%  unixbench.time.voluntary_context_switches
  11823155           +10.8%   13094596 ±  2%  unixbench.workload
    294480            +5.2%     309885        proc-vmstat.nr_active_anon
   1099668            +1.5%    1116366        proc-vmstat.nr_file_pages
    193085            +1.3%     195658        proc-vmstat.nr_inactive_anon
     22508            +5.3%      23704        proc-vmstat.nr_mapped
    315878            +5.3%     332613        proc-vmstat.nr_shmem
    294480            +5.2%     309885        proc-vmstat.nr_zone_active_anon
    193085            +1.3%     195658        proc-vmstat.nr_zone_inactive_anon
  5.85e+08           +10.7%  6.478e+08 ±  2%  proc-vmstat.numa_hit
 5.849e+08           +10.7%  6.477e+08 ±  2%  proc-vmstat.numa_local
 6.078e+08           +10.7%  6.731e+08 ±  2%  proc-vmstat.pgalloc_normal
 6.622e+08           +11.0%  7.351e+08 ±  2%  proc-vmstat.pgfault
 6.073e+08           +10.7%  6.726e+08 ±  2%  proc-vmstat.pgfree
  27949436           +10.6%   30908858 ±  2%  proc-vmstat.pgreuse
      2.46            +5.6%       2.60        perf-stat.i.MPKI
 1.117e+10            +2.8%  1.148e+10        perf-stat.i.branch-instructions
 1.388e+08            +7.7%  1.495e+08 ±  2%  perf-stat.i.branch-misses
 1.431e+08            +8.5%  1.554e+08        perf-stat.i.cache-misses
  6.58e+08            +9.8%  7.223e+08        perf-stat.i.cache-references
    147433 ±  6%     +16.4%     171562 ±  5%  perf-stat.i.context-switches
      2.70            -2.2%       2.64        perf-stat.i.cpi
     24732           +14.5%      28322        perf-stat.i.cpu-migrations
 5.514e+10            +2.6%  5.658e+10        perf-stat.i.instructions
    892.93 ±  2%     +29.9%       1160 ±  5%  perf-stat.i.major-faults
     52.83           +11.5%      58.91 ±  2%  perf-stat.i.metric.K/sec
   1618496           +11.3%    1800710 ±  2%  perf-stat.i.minor-faults
   1619388           +11.3%    1801870 ±  2%  perf-stat.i.page-faults
      2.59            +5.8%       2.74        perf-stat.overall.MPKI
      1.24            +0.1        1.30        perf-stat.overall.branch-miss-rate%
      3.00            -2.7%       2.92        perf-stat.overall.cpi
      1158            -8.0%       1065        perf-stat.overall.cycles-between-cache-misses
      0.33            +2.7%       0.34        perf-stat.overall.ipc
   1846860            -7.5%    1709157        perf-stat.overall.path-length
 1.122e+10            +2.7%  1.152e+10        perf-stat.ps.branch-instructions
 1.396e+08            +7.6%  1.502e+08 ±  2%  perf-stat.ps.branch-misses
 1.435e+08            +8.4%  1.556e+08        perf-stat.ps.cache-misses
 6.621e+08            +9.6%  7.257e+08        perf-stat.ps.cache-references
    147944 ±  6%     +16.2%     171892 ±  5%  perf-stat.ps.context-switches
     24775           +14.4%      28338        perf-stat.ps.cpu-migrations
 5.539e+10            +2.5%  5.677e+10        perf-stat.ps.instructions
    900.37 ±  2%     +29.6%       1167 ±  4%  perf-stat.ps.major-faults
   1630652           +11.1%    1811377 ±  2%  perf-stat.ps.minor-faults
   1631552           +11.1%    1812544 ±  2%  perf-stat.ps.page-faults
 2.183e+13            +2.5%  2.237e+13        perf-stat.total.instructions
     21.33 ±  3%     -21.3        0.00        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables
     20.54 ±  3%     -20.5        0.00        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma
     14.93 ±  2%     -14.9        0.00        perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.exit_mmap.__mmput
     14.80 ±  3%     -14.8        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables.exit_mmap
      8.83 ±  2%      -8.8        0.00        perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exit_mm
      6.78 ±  3%      -6.8        0.00        perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      6.73 ±  4%      -6.7        0.00        perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_munmap
      6.70 ±  4%      -6.7        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables.unmap_region
      9.26            -6.7        2.59 ±  5%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
     11.54            -6.4        5.09        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     11.51            -6.4        5.06        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
     11.52            -6.4        5.08        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      6.39 ±  4%      -6.4        0.00        perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exec_mmap
     12.55            -6.3        6.25        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.55            -6.3        6.25        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.55            -6.3        6.25        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.93 ±  3%      -5.0        1.90 ±  6%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exec_mmap.begin_new_exec
     14.04 ±  2%      -4.7        9.39 ±  3%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
     14.11 ±  2%      -4.6        9.46 ±  3%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
     14.12 ±  2%      -4.6        9.47 ±  3%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
     14.39 ±  2%      -4.6        9.78 ±  3%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.46 ±  3%      -4.5        3.93 ±  2%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exec_mmap.begin_new_exec.load_elf_binary
      8.48 ±  3%      -4.5        3.95 ±  2%  perf-profile.calltrace.cycles-pp.__mmput.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler
      8.77 ±  2%      -4.5        4.27        perf-profile.calltrace.cycles-pp.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm
      8.90 ±  2%      -4.5        4.40        perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
     13.46 ±  2%      -3.8        9.68 ±  2%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.51 ±  2%      -3.8        9.74 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.12            -0.7        1.42 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      2.12            -0.7        1.42 ±  6%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      2.12            -0.7        1.42 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      2.12            -0.7        1.42 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      2.12            -0.7        1.42 ±  6%  perf-profile.calltrace.cycles-pp.execve
     88.10            -0.6       87.47        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     88.12            -0.6       87.50        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.58 ±  2%      +0.1        0.62 ±  3%  perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.58 ±  2%      +0.1        0.63 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.56 ±  2%      +0.1        0.62 ±  3%  perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.55            +0.1        0.62 ±  3%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exec_mmap
      0.56            +0.1        0.63 ±  3%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.61            +0.1        0.69 ±  3%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.64            +0.1        0.73 ±  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.57 ±  4%      +0.1        0.68 ±  3%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.58 ±  4%      +0.1        0.68 ±  3%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      0.58 ±  4%      +0.1        0.68 ±  3%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      0.58 ±  4%      +0.1        0.69 ±  3%  perf-profile.calltrace.cycles-pp.common_startup_64
      0.83            +0.1        0.94 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      0.93 ±  2%      +0.1        1.05 ±  4%  perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.92            +0.1        1.04 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      1.13 ±  2%      +0.1        1.27 ±  4%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      0.42 ± 44%      +0.1        0.57 ±  2%  perf-profile.calltrace.cycles-pp.copy_strings.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.19 ±  2%      +0.2        1.34 ±  4%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      0.87 ±  4%      +0.2        1.02 ±  4%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_lookupat
      1.86 ±  3%      +0.2        2.03 ±  6%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.__split_vma.vma_modify.mprotect_fixup
      0.94 ±  4%      +0.2        1.11 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_lookupat
      1.83 ±  3%      +0.2        2.00 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma.vma_modify
      0.96 ±  4%      +0.2        1.14 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_lookupat.filename_lookup
      2.03 ±  3%      +0.2        2.20 ±  5%  perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey
      1.14 ±  3%      +0.2        1.32 ±  5%  perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      1.09 ±  4%      +0.2        1.28 ±  4%  perf-profile.calltrace.cycles-pp.terminate_walk.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat
      1.08 ±  4%      +0.2        1.27 ±  4%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_lookupat.filename_lookup.vfs_statx
      1.08 ±  3%      +0.2        1.27 ±  4%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_lookupat.filename_lookup
      1.63            +0.2        1.84 ±  4%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      2.37 ±  2%      +0.2        2.59 ±  4%  perf-profile.calltrace.cycles-pp.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      1.64 ±  3%      +0.2        1.86 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare.vma_expand
      1.76 ±  4%      +0.2        1.98 ±  7%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      1.64 ±  4%      +0.2        1.87 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.vma_expand.mmap_region
      1.65 ±  4%      +0.2        1.88 ±  8%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.vma_expand.mmap_region.do_mmap
      2.39 ±  2%      +0.2        2.62 ±  4%  perf-profile.calltrace.cycles-pp.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      1.68 ±  3%      +0.2        1.90 ±  8%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_expand.mmap_region.do_mmap.vm_mmap_pgoff
      1.66            +0.2        1.89 ±  3%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      1.66            +0.2        1.89 ±  3%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      1.66            +0.2        1.89 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      1.66            +0.2        1.89 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
      1.76 ±  3%      +0.2        1.99 ±  7%  perf-profile.calltrace.cycles-pp.vma_expand.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      2.50 ±  2%      +0.2        2.74 ±  4%  perf-profile.calltrace.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.74            +0.2        1.98 ±  2%  perf-profile.calltrace.cycles-pp._Fork
      1.92 ±  3%      +0.2        2.17 ±  6%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.97 ±  3%      +0.2        2.22 ±  6%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.61 ±  2%      +0.3        2.86 ±  3%  perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.61 ±  2%      +0.3        2.86 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.98 ±  3%      +0.3        2.23 ±  6%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.88 ±  2%      +0.3        2.16 ±  3%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.51 ± 12%      +0.3        1.80 ±  4%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      1.96 ±  2%      +0.3        2.25 ±  3%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      2.04 ±  2%      +0.3        2.34 ±  5%  perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_lookupat
      2.10 ±  2%      +0.3        2.41 ±  4%  perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.link_path_walk.path_lookupat.filename_lookup
      2.17 ±  2%      +0.3        2.50 ±  3%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      3.05 ±  2%      +0.4        3.47 ±  3%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      5.75            +0.4        6.18 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.mmap_region.do_mmap
      5.80            +0.4        6.23 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      3.22 ±  2%      +0.4        3.67 ±  3%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      3.64 ±  2%      +0.5        4.14 ±  3%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      3.24 ±  2%      +0.5        3.75 ±  4%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_lookupat.filename_lookup.vfs_statx
      3.67 ±  2%      +0.5        4.17 ±  3%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      4.04 ±  2%      +0.5        4.58 ±  3%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      3.67 ±  2%      +0.6        4.22 ±  4%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat
      4.83 ±  3%      +0.8        5.59 ±  8%  perf-profile.calltrace.cycles-pp.down_write.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      5.00 ±  3%      +0.8        5.77 ±  4%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
      4.98 ±  3%      +0.8        5.75 ±  4%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat
      5.00 ±  3%      +0.8        5.78 ±  4%  perf-profile.calltrace.cycles-pp.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.11 ±  3%      +0.8        5.90 ±  4%  perf-profile.calltrace.cycles-pp.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.16 ±  3%      +0.8        5.96 ±  4%  perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.87 ±  4%      +0.9        7.82 ±  7%  perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      7.02 ±  3%      +1.0        7.99 ±  7%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      7.34 ±  3%      +1.2        8.49 ±  8%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.dup_mmap
      8.41 ±  4%      +1.2        9.65 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma.do_vmi_align_munmap
      8.44 ±  4%      +1.2        9.69 ±  8%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      7.62 ±  3%      +1.3        8.88 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm
      7.69 ±  3%      +1.3        8.96 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm.copy_process
      7.83 ±  3%      +1.3        9.12 ±  8%  perf-profile.calltrace.cycles-pp.down_write.dup_mmap.dup_mm.copy_process.kernel_clone
      8.69 ±  4%      +1.3        9.98 ±  8%  perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      0.00            +1.3        1.33 ± 11%  perf-profile.calltrace.cycles-pp.unlink_file_vma_batch_add.free_pgtables.exit_mmap.__mmput.exec_mmap
      9.11 ±  3%      +1.4       10.46 ±  7%  perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
     10.17 ±  4%      +1.4       11.56 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma
      9.06 ±  2%      +1.4       10.50 ±  5%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.06 ±  2%      +1.4       10.50 ±  5%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.24 ±  2%      +1.5       10.69 ±  6%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
     11.46 ±  4%      +1.5       12.95 ±  8%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare
      9.56 ±  2%      +1.5       11.05 ±  6%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
     10.40 ±  2%      +1.6       12.04 ±  5%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.9        1.89 ±  9%  perf-profile.calltrace.cycles-pp.unlink_file_vma_batch_add.free_pgtables.exit_mmap.__mmput.exit_mm
     14.48 ±  3%      +2.1       16.61 ±  7%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
     16.20 ±  3%      +2.3       18.54 ±  7%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff
      0.00            +2.9        2.92 ± 10%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_add
      0.00            +3.0        3.03 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_add.free_pgtables
      0.00            +3.1        3.05 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_add.free_pgtables.exit_mmap
      0.00            +3.1        3.07 ± 10%  perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma_batch_add.free_pgtables.exit_mmap.__mmput
     21.65 ±  3%      +3.2       24.86 ±  7%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
     21.69 ±  3%      +3.2       24.91 ±  7%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.73 ±  3%      +3.2       24.96 ±  7%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.74 ±  3%      +3.2       24.97 ±  7%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +7.3        7.33 ±  8%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_final
      0.00            +7.6        7.56 ±  7%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_final.free_pgtables
      0.00            +7.6        7.62 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_final.free_pgtables.unmap_region
      0.00            +7.6        7.64 ±  7%  perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma_batch_final.free_pgtables.unmap_region.do_vmi_align_munmap
      0.00            +7.8        7.81 ±  7%  perf-profile.calltrace.cycles-pp.unlink_file_vma_batch_final.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap
     22.50 ±  2%     -22.5        0.00        perf-profile.children.cycles-pp.unlink_file_vma
     19.98           -11.0        9.00 ±  2%  perf-profile.children.cycles-pp.exit_mmap
     20.01           -11.0        9.04 ±  2%  perf-profile.children.cycles-pp.__mmput
     23.59 ±  2%     -10.5       13.12 ±  6%  perf-profile.children.cycles-pp.free_pgtables
     48.94 ±  2%      -7.1       41.85 ±  7%  perf-profile.children.cycles-pp.down_write
     48.30 ±  2%      -7.0       41.26 ±  7%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     47.92 ±  2%      -7.0       40.89 ±  7%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
     46.06 ±  2%      -7.0       39.04 ±  7%  perf-profile.children.cycles-pp.osq_lock
     11.55            -6.4        5.10        perf-profile.children.cycles-pp.exit_mm
     12.64            -6.3        6.36        perf-profile.children.cycles-pp.do_group_exit
     12.65            -6.3        6.36        perf-profile.children.cycles-pp.__x64_sys_exit_group
     12.64            -6.3        6.35        perf-profile.children.cycles-pp.do_exit
     14.08 ±  2%      -4.6        9.43 ±  3%  perf-profile.children.cycles-pp.load_elf_binary
     14.17 ±  2%      -4.6        9.52 ±  3%  perf-profile.children.cycles-pp.exec_binprm
     14.16 ±  2%      -4.6        9.52 ±  3%  perf-profile.children.cycles-pp.search_binary_handler
     14.52 ±  2%      -4.6        9.94 ±  3%  perf-profile.children.cycles-pp.bprm_execve
      8.78 ±  2%      -4.5        4.27        perf-profile.children.cycles-pp.exec_mmap
      8.90 ±  2%      -4.5        4.42        perf-profile.children.cycles-pp.begin_new_exec
     15.88 ±  2%      -4.4       11.44 ±  3%  perf-profile.children.cycles-pp.do_execveat_common
     15.94 ±  2%      -4.4       11.52 ±  3%  perf-profile.children.cycles-pp.__x64_sys_execve
     92.50            -1.0       91.48        perf-profile.children.cycles-pp.do_syscall_64
     92.53            -1.0       91.52        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.44            -0.7        1.78 ±  6%  perf-profile.children.cycles-pp.execve
      1.09 ±  3%      -0.1        0.95 ±  2%  perf-profile.children.cycles-pp.up_write
      0.24 ± 20%      -0.1        0.17 ±  9%  perf-profile.children.cycles-pp.osq_unlock
      0.40 ±  9%      -0.1        0.33 ±  6%  perf-profile.children.cycles-pp.rwsem_wake
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.find_mergeable_anon_vma
      0.08            +0.0        0.09        perf-profile.children.cycles-pp.free_unref_page_commit
      0.08            +0.0        0.09        perf-profile.children.cycles-pp.mas_wr_walk
      0.14            +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.strnlen
      0.10 ±  4%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__install_special_mapping
      0.12            +0.0        0.13 ±  3%  perf-profile.children.cycles-pp._copy_from_user
      0.13 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp._find_next_bit
      0.08 ±  5%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.d_path
      0.12 ±  4%      +0.0        0.13        perf-profile.children.cycles-pp.dequeue_entity
      0.15 ±  2%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__anon_vma_prepare
      0.13            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__pud_alloc
      0.13 ±  2%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.rmqueue
      0.10 ±  3%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.11            +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.enqueue_entity
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.free_p4d_range
      0.17 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.memcg_account_kmem
      0.14 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.mas_next_slot
      0.11 ±  3%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.move_page_tables
      0.11 ±  6%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.open_exec
      0.15 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__get_user_8
      0.14 ±  3%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__pmd_alloc
      0.10 ±  3%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp._exit
      0.11 ±  4%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.do_faccessat
      0.10 ±  3%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.user_path_at_empty
      0.23 ±  2%      +0.0        0.25 ±  2%  perf-profile.children.cycles-pp.__call_rcu_common
      0.13 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__memcpy
      0.15 ±  2%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.09 ±  4%      +0.0        0.11        perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.15 ±  3%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.16 ±  4%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.16 ±  2%      +0.0        0.18        perf-profile.children.cycles-pp.vmf_anon_prepare
      0.24 ±  3%      +0.0        0.26 ±  3%  perf-profile.children.cycles-pp.__d_add
      0.10 ±  8%      +0.0        0.12 ±  8%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.12            +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.15 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__pte_alloc
      0.21 ±  4%      +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.19 ±  3%      +0.0        0.21 ±  5%  perf-profile.children.cycles-pp.copy_string_kernel
      0.24 ±  3%      +0.0        0.26 ±  3%  perf-profile.children.cycles-pp.simple_lookup
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.map_vdso
      0.14 ±  4%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.10 ±  7%      +0.0        0.12 ±  9%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.22 ±  2%      +0.0        0.24 ±  3%  perf-profile.children.cycles-pp.update_load_avg
      0.20 ±  2%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.alloc_anon_folio
      0.17 ±  4%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.up_read
      0.19 ±  3%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.14 ±  6%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.schedule_idle
      0.12 ±  3%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.18 ±  3%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.__check_object_size
      0.26 ±  3%      +0.0        0.28 ±  3%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.21            +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.__perf_sw_event
      0.25 ±  2%      +0.0        0.28 ±  4%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.22            +0.0        0.24 ±  3%  perf-profile.children.cycles-pp.shift_arg_pages
      0.22 ±  2%      +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.22 ±  2%      +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.schedule_tail
      0.24 ±  2%      +0.0        0.27 ±  3%  perf-profile.children.cycles-pp.__get_user_pages
      0.20 ±  2%      +0.0        0.22 ±  4%  perf-profile.children.cycles-pp.do_open_execat
      0.21 ±  2%      +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.memset_orig
      0.19 ±  2%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.__put_user_8
      0.15            +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.activate_task
      0.20            +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.clear_bhb_loop
      0.26 ±  2%      +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.20 ±  3%      +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.13 ±  3%      +0.0        0.16 ±  5%  perf-profile.children.cycles-pp.__do_fault
      0.21 ±  2%      +0.0        0.24 ±  4%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.21 ±  2%      +0.0        0.24 ±  3%  perf-profile.children.cycles-pp.mas_walk
      0.20 ±  2%      +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.pte_alloc_one
      0.24            +0.0        0.27 ±  3%  perf-profile.children.cycles-pp.anon_vma_fork
      0.22 ±  3%      +0.0        0.25 ±  2%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.22 ±  4%      +0.0        0.25 ±  4%  perf-profile.children.cycles-pp.folio_add_file_rmap_ptes
      0.19            +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.___perf_sw_event
      0.30 ±  2%      +0.0        0.33 ±  3%  perf-profile.children.cycles-pp.wake_up_new_task
      0.24            +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.sched_exec
      0.24 ±  2%      +0.0        0.27 ±  3%  perf-profile.children.cycles-pp.strncpy_from_user
      0.23            +0.0        0.26 ±  4%  perf-profile.children.cycles-pp.vm_area_alloc
      0.23 ±  2%      +0.0        0.26 ±  4%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.26            +0.0        0.30 ±  3%  perf-profile.children.cycles-pp.mas_find
      0.29 ±  2%      +0.0        0.32 ±  3%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.32 ±  2%      +0.0        0.35 ±  3%  perf-profile.children.cycles-pp.rep_stos_alternative
      0.31 ±  2%      +0.0        0.35 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      1.07            +0.0        1.11        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.27            +0.0        0.31 ±  3%  perf-profile.children.cycles-pp.clear_page_erms
      0.30            +0.0        0.34 ±  3%  perf-profile.children.cycles-pp.get_arg_page
      0.34 ±  2%      +0.0        0.37 ±  3%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.29 ±  2%      +0.0        0.33 ±  3%  perf-profile.children.cycles-pp.create_elf_tables
      0.33            +0.0        0.37 ±  3%  perf-profile.children.cycles-pp.sync_regs
      1.04            +0.0        1.08        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.24 ±  3%      +0.0        0.28 ±  4%  perf-profile.children.cycles-pp.lru_add_drain
      0.29 ±  2%      +0.0        0.33 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.33 ±  2%      +0.0        0.37 ±  3%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.40 ±  2%      +0.0        0.44 ±  3%  perf-profile.children.cycles-pp.do_anonymous_page
      0.24 ±  3%      +0.0        0.28 ±  4%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.57            +0.0        0.61 ±  2%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.32 ±  3%      +0.0        0.36 ±  3%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.32            +0.0        0.36 ±  3%  perf-profile.children.cycles-pp.strnlen_user
      0.22 ±  2%      +0.0        0.27 ± 14%  perf-profile.children.cycles-pp.dup_task_struct
      0.36            +0.0        0.40 ±  3%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.34 ±  2%      +0.0        0.38 ±  4%  perf-profile.children.cycles-pp.__libc_early_init
      0.38            +0.0        0.42 ±  2%  perf-profile.children.cycles-pp.lockref_put_return
      0.42 ±  2%      +0.0        0.47 ±  2%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.39 ±  2%      +0.0        0.44 ±  3%  perf-profile.children.cycles-pp.sched_balance_find_dst_group
      0.46 ±  3%      +0.0        0.50 ±  3%  perf-profile.children.cycles-pp.__mmdrop
      0.34 ±  3%      +0.0        0.38 ±  3%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.36 ±  2%      +0.0        0.41 ±  4%  perf-profile.children.cycles-pp.set_pte_range
      0.32            +0.0        0.36 ±  3%  perf-profile.children.cycles-pp.finish_task_switch
      0.37 ±  2%      +0.0        0.42 ±  4%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.49            +0.0        0.54 ±  3%  perf-profile.children.cycles-pp.__slab_free
      0.46 ±  2%      +0.0        0.51 ±  3%  perf-profile.children.cycles-pp.alloc_bprm
      0.44 ±  2%      +0.0        0.49 ±  3%  perf-profile.children.cycles-pp.copy_p4d_range
      0.39 ±  2%      +0.0        0.44 ±  3%  perf-profile.children.cycles-pp.vm_area_dup
      0.46 ±  2%      +0.0        0.51 ±  3%  perf-profile.children.cycles-pp.copy_page_range
      0.43 ±  2%      +0.0        0.48 ±  3%  perf-profile.children.cycles-pp.sched_balance_find_dst_cpu
      0.21 ±  5%      +0.1        0.26 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.38            +0.1        0.43 ±  3%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.33 ±  3%      +0.1        0.38 ±  2%  perf-profile.children.cycles-pp.getname_flags
      0.44            +0.1        0.50 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.43 ±  3%      +0.1        0.49 ±  3%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.49            +0.1        0.55 ±  3%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.49 ±  2%      +0.1        0.54 ±  4%  perf-profile.children.cycles-pp.mod_objcg_state
      0.20 ±  6%      +0.1        0.26 ± 13%  perf-profile.children.cycles-pp.copy_fs_struct
      0.47            +0.1        0.52 ±  4%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.67 ±  2%      +0.1        0.72 ±  3%  perf-profile.children.cycles-pp.do_wait
      0.49            +0.1        0.54 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap
      0.55 ±  2%      +0.1        0.61 ±  3%  perf-profile.children.cycles-pp.wp_page_copy
      0.52            +0.1        0.59 ±  2%  perf-profile.children.cycles-pp.sched_balance_rq
      0.61 ±  2%      +0.1        0.67 ±  3%  perf-profile.children.cycles-pp.mm_init
      0.20 ± 17%      +0.1        0.27 ± 12%  perf-profile.children.cycles-pp.path_put
      0.68 ±  2%      +0.1        0.74 ±  3%  perf-profile.children.cycles-pp.kernel_wait4
      0.34 ±  5%      +0.1        0.40 ±  4%  perf-profile.children.cycles-pp.acpi_idle_enter
      0.33 ±  4%      +0.1        0.40 ±  3%  perf-profile.children.cycles-pp.acpi_safe_halt
      0.36 ±  4%      +0.1        0.42 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.21 ± 19%      +0.1        0.27 ± 11%  perf-profile.children.cycles-pp.exit_fs
      0.36 ±  4%      +0.1        0.42 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter
      0.58            +0.1        0.65 ±  2%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.56            +0.1        0.63 ±  3%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.63 ±  3%      +0.1        0.70 ±  6%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.61            +0.1        0.68 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.61            +0.1        0.68 ±  3%  perf-profile.children.cycles-pp.copy_strings
      0.41 ±  4%      +0.1        0.48 ±  4%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.72            +0.1        0.80 ±  2%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.64            +0.1        0.73 ±  2%  perf-profile.children.cycles-pp.kthread
      0.86            +0.1        0.95 ±  3%  perf-profile.children.cycles-pp.rcu_do_batch
      0.71            +0.1        0.79 ±  2%  perf-profile.children.cycles-pp.schedule
      0.78            +0.1        0.86 ±  2%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.90            +0.1        0.99 ±  3%  perf-profile.children.cycles-pp.rcu_core
      0.75 ±  2%      +0.1        0.84 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.68            +0.1        0.77 ±  3%  perf-profile.children.cycles-pp.__d_lookup_rcu
      1.00            +0.1        1.09 ±  3%  perf-profile.children.cycles-pp.handle_softirqs
      0.58 ±  4%      +0.1        0.69 ±  3%  perf-profile.children.cycles-pp.do_idle
      0.58 ±  4%      +0.1        0.68 ±  3%  perf-profile.children.cycles-pp.start_secondary
      0.70            +0.1        0.80        perf-profile.children.cycles-pp.vma_complete
      0.58 ±  4%      +0.1        0.69 ±  3%  perf-profile.children.cycles-pp.common_startup_64
      0.58 ±  4%      +0.1        0.69 ±  3%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.86            +0.1        0.98 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
      0.97            +0.1        1.10 ±  2%  perf-profile.children.cycles-pp.ret_from_fork_asm
      1.48            +0.1        1.61 ±  3%  perf-profile.children.cycles-pp.kmem_cache_free
      0.91 ±  2%      +0.1        1.04        perf-profile.children.cycles-pp.vma_interval_tree_insert
      1.15            +0.1        1.30        perf-profile.children.cycles-pp.__schedule
      1.10 ±  2%      +0.2        1.25 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      1.52 ±  2%      +0.2        1.72 ±  4%  perf-profile.children.cycles-pp.zap_present_ptes
      1.50 ±  3%      +0.2        1.72 ±  5%  perf-profile.children.cycles-pp.next_uptodate_folio
      2.39 ±  2%      +0.2        2.62 ±  4%  perf-profile.children.cycles-pp.vma_modify
      1.79            +0.2        2.02 ±  4%  perf-profile.children.cycles-pp.zap_pte_range
      1.83            +0.2        2.06 ±  4%  perf-profile.children.cycles-pp.zap_pmd_range
      1.90            +0.2        2.14 ±  4%  perf-profile.children.cycles-pp.unmap_page_range
      2.50 ±  2%      +0.2        2.74 ±  4%  perf-profile.children.cycles-pp.mprotect_fixup
      1.78 ±  3%      +0.2        2.02 ±  7%  perf-profile.children.cycles-pp.vma_expand
      1.75            +0.2        1.99 ±  2%  perf-profile.children.cycles-pp._Fork
      2.61 ±  2%      +0.3        2.86 ±  3%  perf-profile.children.cycles-pp.do_mprotect_pkey
      2.61 ±  2%      +0.3        2.86 ±  3%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      2.04            +0.3        2.30 ±  4%  perf-profile.children.cycles-pp.unmap_vmas
      2.48 ±  2%      +0.3        2.82 ±  4%  perf-profile.children.cycles-pp.filemap_map_pages
      2.54 ±  3%      +0.4        2.90 ±  3%  perf-profile.children.cycles-pp.do_read_fault
      2.92 ±  2%      +0.4        3.34 ±  3%  perf-profile.children.cycles-pp.do_fault
      4.33 ±  2%      +0.6        4.90 ±  3%  perf-profile.children.cycles-pp.__handle_mm_fault
      4.58 ±  2%      +0.6        5.18 ±  3%  perf-profile.children.cycles-pp.handle_mm_fault
      4.97 ±  2%      +0.7        5.63 ±  3%  perf-profile.children.cycles-pp.do_user_addr_fault
      5.00 ±  2%      +0.7        5.66 ±  3%  perf-profile.children.cycles-pp.exc_page_fault
      5.59 ±  2%      +0.7        6.32 ±  3%  perf-profile.children.cycles-pp.asm_exc_page_fault
      5.00 ±  3%      +0.8        5.78 ±  4%  perf-profile.children.cycles-pp.vfs_statx
      5.07 ±  3%      +0.8        5.86 ±  4%  perf-profile.children.cycles-pp.path_lookupat
      5.09 ±  3%      +0.8        5.88 ±  4%  perf-profile.children.cycles-pp.filename_lookup
      5.12 ±  3%      +0.8        5.91 ±  4%  perf-profile.children.cycles-pp.vfs_fstatat
      5.16 ±  3%      +0.8        5.96 ±  4%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      7.76 ±  2%      +1.0        8.71 ±  6%  perf-profile.children.cycles-pp.unmap_region
      9.24 ±  2%      +1.5       10.70 ±  6%  perf-profile.children.cycles-pp.dup_mmap
      9.56 ±  2%      +1.5       11.05 ±  6%  perf-profile.children.cycles-pp.dup_mm
     12.13 ±  2%      +1.5       13.66 ±  6%  perf-profile.children.cycles-pp.__split_vma
     12.87 ±  3%      +1.6       14.50 ±  7%  perf-profile.children.cycles-pp.vma_prepare
     10.40 ±  2%      +1.6       12.04 ±  5%  perf-profile.children.cycles-pp.copy_process
     10.72 ±  2%      +1.7       12.39 ±  4%  perf-profile.children.cycles-pp.__do_sys_clone
     10.72 ±  2%      +1.7       12.39 ±  4%  perf-profile.children.cycles-pp.kernel_clone
     17.68 ±  2%      +2.3       19.96 ±  6%  perf-profile.children.cycles-pp.do_vmi_align_munmap
     17.78 ±  2%      +2.3       20.07 ±  6%  perf-profile.children.cycles-pp.do_vmi_munmap
     26.12 ±  2%      +3.2       29.34 ±  6%  perf-profile.children.cycles-pp.mmap_region
     21.74 ±  3%      +3.2       24.98 ±  7%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
     26.24 ±  2%      +3.2       29.49 ±  6%  perf-profile.children.cycles-pp.do_mmap
     26.36 ±  2%      +3.3       29.62 ±  6%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.00            +3.5        3.46 ±  9%  perf-profile.children.cycles-pp.unlink_file_vma_batch_add
      0.00            +8.9        8.88 ±  5%  perf-profile.children.cycles-pp.unlink_file_vma_batch_final
     45.61 ±  2%      -7.0       38.63 ±  7%  perf-profile.self.cycles-pp.osq_lock
      0.68            -0.1        0.60 ±  2%  perf-profile.self.cycles-pp.up_write
      0.24 ± 20%      -0.1        0.17 ±  9%  perf-profile.self.cycles-pp.osq_unlock
      0.20 ±  2%      -0.0        0.17 ±  3%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.x64_sys_call
      0.11            +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.update_load_avg
      0.12 ±  3%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.mas_next_slot
      0.11 ±  3%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__rb_erase_color
      0.09 ±  5%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.link_path_walk
      0.15 ±  4%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.__cond_resched
      0.14 ±  4%      +0.0        0.16 ±  4%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.14 ±  3%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.12 ±  4%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__memcpy
      0.13 ±  2%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.__dentry_kill
      0.16 ±  4%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.up_read
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.14            +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.d_alloc
      0.13 ±  2%      +0.0        0.15 ±  4%  perf-profile.self.cycles-pp.fput
      0.16 ±  2%      +0.0        0.18 ±  3%  perf-profile.self.cycles-pp.___perf_sw_event
      0.20 ±  2%      +0.0        0.22 ±  3%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.20 ±  2%      +0.0        0.23 ±  3%  perf-profile.self.cycles-pp.mas_walk
      0.21 ±  2%      +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.memset_orig
      0.26            +0.0        0.29 ±  3%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.29            +0.0        0.32 ±  3%  perf-profile.self.cycles-pp.kmem_cache_free
      0.20 ±  3%      +0.0        0.23 ±  4%  perf-profile.self.cycles-pp.folio_add_file_rmap_ptes
      0.20 ±  2%      +0.0        0.22 ±  3%  perf-profile.self.cycles-pp.clear_bhb_loop
      0.31 ±  2%      +0.0        0.34 ±  3%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.27            +0.0        0.30 ±  2%  perf-profile.self.cycles-pp.clear_page_erms
      0.34 ±  2%      +0.0        0.37 ±  3%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.34 ±  2%      +0.0        0.38 ±  4%  perf-profile.self.cycles-pp.mod_objcg_state
      0.32            +0.0        0.35 ±  3%  perf-profile.self.cycles-pp.strnlen_user
      0.34 ±  2%      +0.0        0.38 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.19 ±  4%      +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.acpi_safe_halt
      0.33            +0.0        0.37 ±  3%  perf-profile.self.cycles-pp.sync_regs
      0.37            +0.0        0.41 ±  2%  perf-profile.self.cycles-pp.lockref_put_return
      0.48            +0.0        0.52 ±  3%  perf-profile.self.cycles-pp.__slab_free
      0.41 ±  3%      +0.0        0.46 ±  3%  perf-profile.self.cycles-pp.d_alloc_parallel
      0.40 ±  2%      +0.0        0.45 ±  3%  perf-profile.self.cycles-pp.zap_present_ptes
      0.32 ±  2%      +0.0        0.37 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.do_syscall_64
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.free_pgtables
      0.38            +0.1        0.43 ±  3%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.57 ±  3%      +0.1        0.64 ±  6%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.66 ±  2%      +0.1        0.75 ±  3%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.90 ±  2%      +0.1        1.03        perf-profile.self.cycles-pp.vma_interval_tree_insert
      1.16            +0.2        1.32 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock



***************************************************************************************************
lkp-cpl-4sp2: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/300s/lkp-cpl-4sp2/sysexec/unixbench

commit: 
  1a3798dece ("mm/memory-failure: send SIGBUS in the event of thp split fail")
  3577dbb192 ("mm: batch unlink_file_vma calls in free_pgd_range")

1a3798dececa8cb2 3577dbb192419e37b6f54aced87 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  20421803 ±  7%     +28.7%   26288969 ±  7%  cpuidle..usage
      0.19            +0.0        0.22 ±  2%  mpstat.cpu.all.soft%
    132908 ±  7%     +19.2%     158382 ±  4%  vmstat.system.cs
    254524 ±  2%      +4.8%     266734        vmstat.system.in
    652.83 ±  8%     +20.1%     784.17 ±  8%  perf-c2c.DRAM.local
      7420 ±  8%     +26.8%       9408 ±  7%  perf-c2c.DRAM.remote
      2812 ±  8%     +31.6%       3700 ±  8%  perf-c2c.HITM.local
      4380 ±  8%     +27.8%       5599 ±  6%  perf-c2c.HITM.remote
      7192 ±  8%     +29.3%       9299 ±  7%  perf-c2c.HITM.total
    382696 ±  4%      -7.2%     355044 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.stddev
    382696 ±  4%      -7.2%     355044 ±  4%  sched_debug.cfs_rq:/.min_vruntime.stddev
    107936 ±  7%     +18.4%     127764 ±  3%  sched_debug.cpu.nr_switches.avg
    129113 ±  7%     +17.8%     152065 ±  6%  sched_debug.cpu.nr_switches.max
     97271 ±  5%     +15.9%     112757 ±  5%  sched_debug.cpu.nr_switches.min
  76519703 ±  2%     +11.2%   85084248 ±  2%  numa-numastat.node0.local_node
  76609959 ±  2%     +11.2%   85161677 ±  2%  numa-numastat.node0.numa_hit
  76613462           +11.6%   85473061 ±  2%  numa-numastat.node1.local_node
  76705226           +11.6%   85567058 ±  2%  numa-numastat.node1.numa_hit
  76773693           +11.2%   85356488 ±  2%  numa-numastat.node2.local_node
  76880789           +11.2%   85472177 ±  2%  numa-numastat.node2.numa_hit
  74525464 ±  2%     +11.4%   83021290 ±  2%  numa-numastat.node3.local_node
  74605408 ±  2%     +11.4%   83108021 ±  2%  numa-numastat.node3.numa_hit
  76619017 ±  2%     +11.1%   85160903 ±  2%  numa-vmstat.node0.numa_hit
  76528760 ±  2%     +11.2%   85083473 ±  2%  numa-vmstat.node0.numa_local
  76716210           +11.5%   85565084 ±  2%  numa-vmstat.node1.numa_hit
  76624446           +11.5%   85471086 ±  2%  numa-vmstat.node1.numa_local
  76889965           +11.2%   85471615 ±  2%  numa-vmstat.node2.numa_hit
  76782869           +11.2%   85355925 ±  2%  numa-vmstat.node2.numa_local
  74616881 ±  2%     +11.4%   83107325 ±  2%  numa-vmstat.node3.numa_hit
  74536936 ±  2%     +11.4%   83020594 ±  2%  numa-vmstat.node3.numa_local
      6569 ±  2%     +11.6%       7329 ±  2%  unixbench.score
     16423 ±  2%     +11.6%      18322 ±  2%  unixbench.throughput
   2020959 ±  3%     +11.9%    2262216 ±  2%  unixbench.time.involuntary_context_switches
    135061 ±  4%     +20.9%     163338 ±  3%  unixbench.time.major_page_faults
  3.64e+08 ±  2%     +11.4%  4.053e+08 ±  2%  unixbench.time.minor_page_faults
     15249            -2.8%      14823        unixbench.time.percent_of_cpu_this_job_got
     60779            -2.5%      59252        unixbench.time.system_time
    330.25           +12.9%     372.86 ±  2%  unixbench.time.user_time
  21486863 ±  9%     +20.3%   25853090 ±  5%  unixbench.time.voluntary_context_switches
   6577511           +11.8%    7350379 ±  2%  unixbench.workload
    362183            +5.0%     380386        proc-vmstat.nr_active_anon
    231451            +3.2%     238774        proc-vmstat.nr_anon_pages
   1279811            +2.4%    1310514        proc-vmstat.nr_file_pages
    361068            +4.2%     376170        proc-vmstat.nr_inactive_anon
    496006            +6.2%     526702        proc-vmstat.nr_shmem
    362183            +5.0%     380386        proc-vmstat.nr_zone_active_anon
    361068            +4.2%     376170        proc-vmstat.nr_zone_inactive_anon
 3.048e+08           +11.3%  3.393e+08 ±  2%  proc-vmstat.numa_hit
 3.045e+08           +11.3%  3.389e+08 ±  2%  proc-vmstat.numa_local
    619769            +4.3%     646401        proc-vmstat.pgactivate
  3.17e+08           +11.3%  3.528e+08 ±  2%  proc-vmstat.pgalloc_normal
 3.666e+08           +11.3%  4.081e+08 ±  2%  proc-vmstat.pgfault
 3.162e+08           +11.3%   3.52e+08 ±  2%  proc-vmstat.pgfree
  16254528           +10.5%   17955885 ±  2%  proc-vmstat.pgreuse
      1.23            +0.1        1.31        perf-stat.i.branch-miss-rate%
 1.257e+08           +10.4%  1.387e+08 ±  2%  perf-stat.i.branch-misses
     28.08            -0.9       27.15        perf-stat.i.cache-miss-rate%
 1.347e+08 ±  2%      +9.1%   1.47e+08        perf-stat.i.cache-misses
 4.738e+08 ±  2%     +12.7%  5.338e+08        perf-stat.i.cache-references
    127625 ±  7%     +19.3%     152228 ±  4%  perf-stat.i.context-switches
      7.68            -4.1%       7.37        perf-stat.i.cpi
 5.641e+11            -2.6%  5.497e+11        perf-stat.i.cpu-cycles
     17384 ±  2%     +11.4%      19370 ±  2%  perf-stat.i.cpu-migrations
      3478 ±  2%     -10.1%       3126 ±  2%  perf-stat.i.cycles-between-cache-misses
    320.74 ±  4%     +20.6%     386.77 ±  3%  perf-stat.i.major-faults
      7.53 ±  2%     +12.2%       8.45        perf-stat.i.metric.K/sec
    850564 ±  2%     +10.9%     943469 ±  2%  perf-stat.i.minor-faults
    850884 ±  2%     +10.9%     943856 ±  2%  perf-stat.i.page-faults
      2.11 ±  2%      +8.0%       2.28        perf-stat.overall.MPKI
      0.98            +0.1        1.07        perf-stat.overall.branch-miss-rate%
     28.33            -0.9       27.44        perf-stat.overall.cache-miss-rate%
      8.86            -3.6%       8.54        perf-stat.overall.cpi
      4200 ±  2%     -10.8%       3747        perf-stat.overall.cycles-between-cache-misses
      0.11            +3.7%       0.12        perf-stat.overall.ipc
   4060016            -9.2%    3684947        perf-stat.overall.path-length
 1.306e+08           +10.5%  1.443e+08 ±  2%  perf-stat.ps.branch-misses
 1.403e+08 ±  3%      +9.2%  1.532e+08        perf-stat.ps.cache-misses
  4.95e+08 ±  2%     +12.7%  5.581e+08        perf-stat.ps.cache-references
    133066 ±  7%     +19.3%     158768 ±  4%  perf-stat.ps.context-switches
 5.888e+11            -2.6%  5.737e+11        perf-stat.ps.cpu-cycles
     18155 ±  2%     +11.4%      20232 ±  2%  perf-stat.ps.cpu-migrations
    335.92 ±  4%     +20.6%     405.07 ±  3%  perf-stat.ps.major-faults
    885043 ±  2%     +11.0%     982193 ±  2%  perf-stat.ps.minor-faults
    885379 ±  2%     +11.0%     982598 ±  2%  perf-stat.ps.page-faults
     41.95           -41.9        0.00        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables
     41.70           -41.7        0.00        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma
     29.74           -29.7        0.00        perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.exit_mmap.__mmput
     29.72           -29.7        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables.exit_mmap
     15.18           -15.2        0.00        perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exit_mm
     14.63           -14.6        0.00        perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exec_mmap
     12.33           -12.3        0.00        perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap
     12.31           -12.3        0.00        perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_munmap
     12.31           -12.3        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma.free_pgtables.unmap_region
     15.30           -11.1        4.20        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
     15.69           -11.1        4.64        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     15.68           -11.1        4.63        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
     15.68           -11.0        4.63        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
     15.95           -11.0        4.92        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.95           -11.0        4.92        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.95           -11.0        4.92        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.78           -10.7        4.08        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exec_mmap.begin_new_exec
     15.05           -10.7        4.38        perf-profile.calltrace.cycles-pp.__mmput.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler
     15.05           -10.7        4.38        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exec_mmap.begin_new_exec.load_elf_binary
     15.27           -10.7        4.61        perf-profile.calltrace.cycles-pp.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm
     15.30           -10.7        4.64        perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
     16.02           -10.6        5.40 ±  2%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
     16.01           -10.6        5.38 ±  2%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
     16.03           -10.6        5.40 ±  2%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
     16.15           -10.6        5.55 ±  2%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.54           -10.6        5.99 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.54           -10.6        5.98 ±  2%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
     94.66            -1.3       93.38        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     94.67            -1.3       93.38        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.56 ±  2%      +0.1        0.63 ±  2%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.59 ±  2%      +0.1        0.66 ±  2%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.66 ±  2%      +0.1        0.74 ±  2%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.66 ±  2%      +0.1        0.74 ±  2%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      0.70 ±  2%      +0.1        0.78 ±  2%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      1.50            +0.1        1.65        perf-profile.calltrace.cycles-pp.asm_sysvec_reschedule_ipi.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.48 ± 46%      +0.2        0.73 ±  9%  perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_openat
      0.80 ± 15%      +0.3        1.05 ±  2%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
      0.80 ± 15%      +0.3        1.05 ±  2%  perf-profile.calltrace.cycles-pp.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.80 ± 15%      +0.3        1.05        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat
      0.81 ± 14%      +0.3        1.07        perf-profile.calltrace.cycles-pp.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.82 ± 14%      +0.3        1.08        perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.52 ± 45%      +0.3        0.78 ±  9%  perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.link_path_walk.path_openat.do_filp_open
      0.53 ± 46%      +0.3        0.81        perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat
      1.00 ± 14%      +0.3        1.31 ±  9%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      1.28 ± 13%      +0.4        1.66 ± 10%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.30 ±100%      +0.4        0.69 ±  2%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_lookupat.filename_lookup.vfs_statx
      1.82 ± 12%      +0.5        2.34 ± 10%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      1.83 ± 12%      +0.5        2.35 ± 10%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.88 ± 12%      +0.5        2.41 ± 10%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.88 ± 11%      +0.5        2.41 ± 10%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.22 ±  2%      +0.6        2.85        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      3.50 ±  5%      +0.9        4.41 ±  4%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      3.50 ±  5%      +0.9        4.42 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      3.50 ±  5%      +0.9        4.42 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      3.52 ±  5%      +0.9        4.44 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      3.57 ±  4%      +0.9        4.50 ±  4%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      3.57 ±  4%      +0.9        4.50 ±  4%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      3.57 ±  4%      +0.9        4.50 ±  4%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      3.58 ±  4%      +0.9        4.52 ±  4%  perf-profile.calltrace.cycles-pp.common_startup_64
      3.06            +1.0        4.07        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma.vma_modify
      3.10            +1.0        4.11        perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      3.07            +1.0        4.08        perf-profile.calltrace.cycles-pp.down_write.vma_prepare.__split_vma.vma_modify.mprotect_fixup
      3.12            +1.0        4.13        perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey
      3.14            +1.0        4.16        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.13            +1.0        4.15        perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.07            +1.0        4.10        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.vma_expand.mmap_region
      3.07            +1.0        4.10        perf-profile.calltrace.cycles-pp.down_write.vma_prepare.vma_expand.mmap_region.do_mmap
      3.14            +1.0        4.16        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.06            +1.0        4.09        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare.vma_expand
      3.08            +1.0        4.10        perf-profile.calltrace.cycles-pp.vma_prepare.vma_expand.mmap_region.do_mmap.vm_mmap_pgoff
      3.20            +1.0        4.22        perf-profile.calltrace.cycles-pp.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      3.20            +1.0        4.23        perf-profile.calltrace.cycles-pp.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      3.22            +1.0        4.26        perf-profile.calltrace.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.10            +1.0        4.14        perf-profile.calltrace.cycles-pp.vma_expand.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      3.24            +1.0        4.28        perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.24            +1.0        4.28        perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.15 ±  9%      +1.0        4.20 ±  7%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      9.09            +2.9       12.03        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.mmap_region
      9.14            +3.0       12.09        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.mmap_region.do_mmap
      9.16            +3.0       12.12        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      9.16            +3.0       12.13        perf-profile.calltrace.cycles-pp.down_write.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.00            +4.0        3.97        perf-profile.calltrace.cycles-pp.unlink_file_vma_batch_add.free_pgtables.exit_mmap.__mmput.exec_mmap
     12.37            +4.1       16.44        perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region
     12.40            +4.1       16.46        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      0.00            +4.1        4.08        perf-profile.calltrace.cycles-pp.unlink_file_vma_batch_add.free_pgtables.exit_mmap.__mmput.exit_mm
     14.47            +5.1       19.58        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.dup_mmap
     15.38            +5.1       20.49        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.38            +5.1       20.49        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.56            +5.1       19.70        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm
     14.60            +5.2       19.76        perf-profile.calltrace.cycles-pp.down_write.dup_mmap.dup_mm.copy_process.kernel_clone
     14.58            +5.2       19.74        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm.copy_process
     15.34            +5.2       20.52        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma.do_vmi_align_munmap
     15.35            +5.2       20.53        perf-profile.calltrace.cycles-pp.down_write.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap
     15.44            +5.2       20.62        perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
     14.91            +5.2       20.11        perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
     15.10            +5.2       20.31        perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
     15.58            +5.2       20.79        perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
     15.23            +5.2       20.46        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.37            +6.2       24.55        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma
     21.33            +7.1       28.48        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare
      0.00            +7.9        7.95        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_add
      0.00            +8.0        7.99        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_add.free_pgtables
      0.00            +8.0        8.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_add.free_pgtables.exit_mmap
      0.00            +8.0        8.00        perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma_batch_add.free_pgtables.exit_mmap.__mmput
     24.91            +8.3       33.18        perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
     27.99            +9.3       37.28        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff
     37.34           +12.3       49.63        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     37.33           +12.3       49.62        perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
     37.35           +12.3       49.64        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     37.35           +12.3       49.64        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +16.2       16.24        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_final
      0.00           +16.3       16.33        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_final.free_pgtables
      0.00           +16.4       16.37        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_final.free_pgtables.unmap_region
      0.00           +16.4       16.37        perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma_batch_final.free_pgtables.unmap_region.do_vmi_align_munmap
      0.00           +16.4       16.44        perf-profile.calltrace.cycles-pp.unlink_file_vma_batch_final.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap
     42.21           -42.2        0.00        perf-profile.children.cycles-pp.unlink_file_vma
     30.74           -21.7        9.04        perf-profile.children.cycles-pp.__mmput
     30.74           -21.7        9.04        perf-profile.children.cycles-pp.exit_mmap
     42.51           -17.7       24.80        perf-profile.children.cycles-pp.free_pgtables
     15.70           -11.1        4.64        perf-profile.children.cycles-pp.exit_mm
     15.96           -11.0        4.94        perf-profile.children.cycles-pp.do_exit
     15.96           -11.0        4.94        perf-profile.children.cycles-pp.__x64_sys_exit_group
     15.96           -11.0        4.94        perf-profile.children.cycles-pp.do_group_exit
     15.31           -10.6        4.67        perf-profile.children.cycles-pp.begin_new_exec
     15.28           -10.6        4.64        perf-profile.children.cycles-pp.exec_mmap
     16.02           -10.6        5.42        perf-profile.children.cycles-pp.load_elf_binary
     16.04           -10.6        5.44        perf-profile.children.cycles-pp.exec_binprm
     16.03           -10.6        5.44        perf-profile.children.cycles-pp.search_binary_handler
     16.17           -10.6        5.60        perf-profile.children.cycles-pp.bprm_execve
     16.55           -10.5        6.04        perf-profile.children.cycles-pp.__x64_sys_execve
     16.54           -10.5        6.03        perf-profile.children.cycles-pp.do_execveat_common
     87.55            -2.3       85.26        perf-profile.children.cycles-pp.down_write
     86.74            -2.3       84.44        perf-profile.children.cycles-pp.osq_lock
     87.27            -2.3       84.98        perf-profile.children.cycles-pp.rwsem_optimistic_spin
     87.43            -2.3       85.14        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     94.85            -1.1       93.75        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     94.84            -1.1       93.74        perf-profile.children.cycles-pp.do_syscall_64
      0.34 ±  2%      -0.1        0.28        perf-profile.children.cycles-pp.up_write
      0.22 ±  3%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.rwsem_wake
      0.18 ±  4%      -0.0        0.15 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.12 ±  3%      -0.0        0.10        perf-profile.children.cycles-pp.wake_up_q
      0.15 ±  3%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.try_to_wake_up
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.__wp_page_copy_user
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.getname_flags
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.pte_alloc_one
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.mas_wr_store_entry
      0.05            +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.07 ±  6%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.09            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.copy_page_range
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.alloc_empty_file
      0.14            +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.16 ±  5%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.09 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.copy_p4d_range
      0.08 ±  4%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.copy_strings
      0.08 ±  6%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.10            +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.11            +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.sched_exec
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.put_cred_rcu
      0.10            +0.0        0.12        perf-profile.children.cycles-pp.perf_event_mmap
      0.14 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.wake_up_new_task
      0.19 ±  3%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.21 ±  3%      +0.0        0.23 ±  4%  perf-profile.children.cycles-pp.do_wait
      0.21 ±  5%      +0.0        0.24 ±  4%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.15 ±  4%      +0.0        0.18 ±  7%  perf-profile.children.cycles-pp.finish_task_switch
      0.21 ±  4%      +0.0        0.24 ±  5%  perf-profile.children.cycles-pp.kernel_wait4
      0.22 ±  5%      +0.0        0.25 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
      0.20 ±  2%      +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.sched_balance_find_dst_group
      0.19 ±  2%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.28            +0.0        0.32 ±  3%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.14 ± 10%      +0.0        0.17 ±  3%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.30            +0.0        0.34 ±  2%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.28 ±  2%      +0.0        0.32 ±  3%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.34 ±  2%      +0.0        0.37 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.35            +0.0        0.38 ±  2%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.23            +0.0        0.27        perf-profile.children.cycles-pp.vma_complete
      0.24 ±  5%      +0.0        0.27 ±  4%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.21 ±  3%      +0.0        0.25        perf-profile.children.cycles-pp.sched_balance_find_dst_cpu
      0.30            +0.0        0.34 ±  2%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.35            +0.0        0.38 ±  2%  perf-profile.children.cycles-pp.sched_balance_rq
      0.24            +0.0        0.27        perf-profile.children.cycles-pp.select_task_rq_fair
      0.25 ±  4%      +0.0        0.29 ±  3%  perf-profile.children.cycles-pp.rcu_do_batch
      0.30 ±  2%      +0.0        0.34 ±  2%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.27 ±  5%      +0.0        0.32 ±  4%  perf-profile.children.cycles-pp.rcu_core
      0.34            +0.0        0.38 ±  2%  perf-profile.children.cycles-pp.schedule
      0.28 ±  3%      +0.0        0.33 ±  5%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.schedule_idle
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.set_pte_range
      0.31 ±  4%      +0.1        0.36 ±  4%  perf-profile.children.cycles-pp.handle_softirqs
      0.26 ±  8%      +0.1        0.32 ±  5%  perf-profile.children.cycles-pp.zap_present_ptes
      0.41            +0.1        0.47        perf-profile.children.cycles-pp.filemap_map_pages
      0.43 ±  2%      +0.1        0.48        perf-profile.children.cycles-pp.do_read_fault
      0.30 ±  6%      +0.1        0.36 ±  5%  perf-profile.children.cycles-pp.zap_pte_range
      0.32 ±  7%      +0.1        0.38 ±  5%  perf-profile.children.cycles-pp.unmap_page_range
      0.51            +0.1        0.57        perf-profile.children.cycles-pp.do_fault
      0.34 ±  6%      +0.1        0.41 ±  5%  perf-profile.children.cycles-pp.unmap_vmas
      0.53            +0.1        0.60 ±  3%  perf-profile.children.cycles-pp.__schedule
      0.76            +0.1        0.83        perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.80            +0.1        0.89        perf-profile.children.cycles-pp.__handle_mm_fault
      0.83            +0.1        0.93        perf-profile.children.cycles-pp.handle_mm_fault
      0.90 ±  2%      +0.1        1.01        perf-profile.children.cycles-pp.exc_page_fault
      0.89 ±  2%      +0.1        1.00        perf-profile.children.cycles-pp.do_user_addr_fault
      0.96 ±  2%      +0.1        1.08        perf-profile.children.cycles-pp.asm_exc_page_fault
      0.46 ± 12%      +0.1        0.60 ±  9%  perf-profile.children.cycles-pp.__legitimize_path
      0.47 ± 12%      +0.1        0.61 ±  9%  perf-profile.children.cycles-pp.try_to_unlazy
      0.49 ± 12%      +0.2        0.64 ±  8%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.47 ± 12%      +0.2        0.62 ±  9%  perf-profile.children.cycles-pp.__dentry_kill
      0.47 ± 14%      +0.2        0.62 ±  8%  perf-profile.children.cycles-pp.terminate_walk
      0.51 ± 13%      +0.2        0.67 ±  8%  perf-profile.children.cycles-pp.d_alloc
      0.59 ± 14%      +0.2        0.77 ±  7%  perf-profile.children.cycles-pp.lookup_fast
      0.87 ± 13%      +0.3        1.13        perf-profile.children.cycles-pp.path_lookupat
      0.89 ± 13%      +0.3        1.15        perf-profile.children.cycles-pp.vfs_fstatat
      0.86 ± 13%      +0.3        1.12        perf-profile.children.cycles-pp.vfs_statx
      0.88 ± 13%      +0.3        1.14        perf-profile.children.cycles-pp.filename_lookup
      0.90 ± 13%      +0.3        1.16        perf-profile.children.cycles-pp.__do_sys_newfstatat
      0.89 ± 15%      +0.3        1.18 ±  6%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.95 ± 15%      +0.3        1.25 ±  6%  perf-profile.children.cycles-pp.__lookup_slow
      1.14 ±  2%      +0.3        1.46        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      1.00 ± 13%      +0.3        1.32 ±  8%  perf-profile.children.cycles-pp.dput
      1.58 ± 14%      +0.5        2.07 ±  6%  perf-profile.children.cycles-pp.walk_component
      1.87 ± 12%      +0.5        2.39 ± 10%  perf-profile.children.cycles-pp.do_filp_open
      1.86 ± 12%      +0.5        2.39 ± 10%  perf-profile.children.cycles-pp.path_openat
      1.88 ± 12%      +0.5        2.41 ± 10%  perf-profile.children.cycles-pp.__x64_sys_openat
      1.88 ± 12%      +0.5        2.41 ± 10%  perf-profile.children.cycles-pp.do_sys_openat2
      1.61 ± 15%      +0.5        2.14 ± 10%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      2.85 ±  5%      +0.6        3.42 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.94 ± 12%      +0.6        2.51 ±  7%  perf-profile.children.cycles-pp.link_path_walk
      1.78 ± 14%      +0.6        2.38 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock
      3.51 ±  5%      +0.9        4.43 ±  4%  perf-profile.children.cycles-pp.acpi_safe_halt
      3.51 ±  5%      +0.9        4.43 ±  4%  perf-profile.children.cycles-pp.acpi_idle_enter
      3.52 ±  4%      +0.9        4.44 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter_state
      3.52 ±  5%      +0.9        4.44 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter
      3.53 ±  5%      +0.9        4.46 ±  4%  perf-profile.children.cycles-pp.cpuidle_idle_call
      3.57 ±  4%      +0.9        4.50 ±  4%  perf-profile.children.cycles-pp.start_secondary
      3.58 ±  4%      +0.9        4.52 ±  4%  perf-profile.children.cycles-pp.common_startup_64
      3.58 ±  4%      +0.9        4.52 ±  4%  perf-profile.children.cycles-pp.cpu_startup_entry
      3.58 ±  4%      +0.9        4.52 ±  4%  perf-profile.children.cycles-pp.do_idle
      3.11            +1.0        4.14        perf-profile.children.cycles-pp.vma_expand
      3.20            +1.0        4.23        perf-profile.children.cycles-pp.vma_modify
      3.22            +1.0        4.26        perf-profile.children.cycles-pp.mprotect_fixup
      3.24            +1.0        4.28        perf-profile.children.cycles-pp.__x64_sys_mprotect
      3.24            +1.0        4.28        perf-profile.children.cycles-pp.do_mprotect_pkey
     12.49            +4.1       16.57        perf-profile.children.cycles-pp.unmap_region
     14.92            +5.2       20.12        perf-profile.children.cycles-pp.dup_mmap
     15.11            +5.2       20.32        perf-profile.children.cycles-pp.dup_mm
     15.24            +5.2       20.46        perf-profile.children.cycles-pp.copy_process
     15.39            +5.2       20.64        perf-profile.children.cycles-pp.__do_sys_clone
     15.39            +5.2       20.64        perf-profile.children.cycles-pp.kernel_clone
     18.86            +6.2       25.10        perf-profile.children.cycles-pp.__split_vma
     21.68            +7.2       28.90        perf-profile.children.cycles-pp.vma_prepare
      0.00            +8.1        8.08        perf-profile.children.cycles-pp.unlink_file_vma_batch_add
     28.18            +9.3       37.49        perf-profile.children.cycles-pp.do_vmi_align_munmap
     28.20            +9.3       37.51        perf-profile.children.cycles-pp.do_vmi_munmap
     37.35           +12.3       49.64        perf-profile.children.cycles-pp.ksys_mmap_pgoff
     40.76           +13.3       54.08        perf-profile.children.cycles-pp.mmap_region
     40.79           +13.3       54.12        perf-profile.children.cycles-pp.do_mmap
     40.81           +13.3       54.14        perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.00           +16.6       16.57        perf-profile.children.cycles-pp.unlink_file_vma_batch_final
     85.63            -2.3       83.31        perf-profile.self.cycles-pp.osq_lock
      0.06            -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.11 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.up_write
      0.06 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.09            +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.filemap_map_pages
      0.10 ±  3%      +0.0        0.11        perf-profile.self.cycles-pp.update_load_avg
      0.24            +0.0        0.26 ±  3%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.10 ± 13%      +0.0        0.13 ±  6%  perf-profile.self.cycles-pp.d_alloc_parallel
      0.17 ±  2%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.14 ± 10%      +0.0        0.17 ±  3%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.30            +0.0        0.33 ±  2%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.26 ±  3%      +0.0        0.30 ±  2%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.27 ±  5%      +0.0        0.31 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      1.59 ± 15%      +0.5        2.11 ± 10%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      3.41 ±  5%      +0.9        4.32 ±  4%  perf-profile.self.cycles-pp.acpi_safe_halt



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


