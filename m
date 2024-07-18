Return-Path: <linux-kernel+bounces-255878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D22279345F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52ECA1F22738
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE8812E7F;
	Thu, 18 Jul 2024 01:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMchcth/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BD76138
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721267527; cv=fail; b=hcRZyee1aeIU7GRTBhFJMBPTYJ70ilwnOlVyQiwBlkv8Ee6jFgqFqhxTy1VOluYIzkpF595pLhjgvdPQcPx3fLzfMW4ERe3p4dHtsUi/wQR01Dr9T+Sd7i5Nw9ll1aPzmVPv+GFJYBhrdGHjBfStVyNkj8V/ID6io52rLkxg9ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721267527; c=relaxed/simple;
	bh=Bqnw9B/K7gbPNA7D8U7PqwSd0QArx+ybxEosXzVUkm8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ndpHF9VqzXgevjgW5nUfC3UqeKn1rCByJlPSlLMx3/vWOuT+16DqSs37gZAZwZs2D1wmiOG0Zw746AaVtsJIZmkiz+0WugtOFB+4o/c8xRPPTV7OaYAK0uoGRlU3QgmHdEtnyNIUhKUzs5XoaAOTn+F11D26I63qIExqUkK3mZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMchcth/; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721267525; x=1752803525;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=Bqnw9B/K7gbPNA7D8U7PqwSd0QArx+ybxEosXzVUkm8=;
  b=dMchcth/mMhDrcWMyR2JqJPps7BxPcGJXB6u69y+KpFKM2ybhtI93JyX
   Tgu5o6f4gOBxdOMn5WkbOjvoJIufsZQQCyfZcrFLBeuYQ7TLgnrDNUXA8
   c/d5SeKKgkuHB0P9o/O148bVA7MeG2QbbE9Ku9IguAjC6+NtE45jcSnqH
   MS72f9pSwfYM/z6VMep9hQ7FioPcC3UcdpjqaRo7xPKxs3owwxXjh0dPY
   KzFk8rY8mq6/aPmz1jEeq3wSqOBvFXiVxJM43+oqk9HzflfjcoMmjJumZ
   JTBc2k9Rjao1pTX9K0a4PCloXX0U6V12BG23zGXDId4uNZtpMq/LzUm5y
   Q==;
X-CSE-ConnectionGUID: mBLFtiBmTHG7bOdpvCF9gw==
X-CSE-MsgGUID: 9erZ2EOGQjeswF/ixclLjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="44231842"
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="44231842"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 18:52:04 -0700
X-CSE-ConnectionGUID: SPSVs3dwRlan8ZTB2fZQMA==
X-CSE-MsgGUID: AQ2KhjdtSEC+PBB1rxQAmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="50654474"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jul 2024 18:52:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 18:52:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 17 Jul 2024 18:52:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 18:52:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kg1WR+fWWKtLl/G0j18BirBF6jHC1EJCrtuYx+PoP+hzxM5Zo+YivfD/1i4RVu/FLOq5KRFP81yEa2yDn9UGiuIq7zFwkLN10yX5U71KXVT0ifGcKdxhYGUFciPpM9dytjPeF9H4yNY7/XfPgyV8zQs3TtG8UouplSzvDMDuvXjnKx6ljjtt33/t8rk3TfLXA5SgVjvv5dI1RgaV38pDH0iRW4fpI/TVHJs17jyWDg1r9yG6ToSTrT8t+gTCF6s07oQXLwlN733oXe793LIAMRbLjr2nxLuqiDiC56nZcJ4zGRp5RItw5unsXe9T8CQXSx7QLbdY0ZiEoXyVKhngZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY+DUhxYqj7s4VIfba1cTn7EHDoimkJXBdUjteGsCFY=;
 b=JuAVbs1+1Xqmb5IvRPAL4QZELZbkMAsh+jJKz4wGlizTJne7RA9R5ZlaYNs9dvzsnU7jrflSQza7sqMm2iHqqTNOe8sbqQfTWNy0eFOuErnP7cM4Lelhs5mIbMgWkMFpVjNZe8hMgGg0dnWm4SLGFHBNOG+dHMF9YV5kS2OKy4TjkSh3IRMQfm80oN22d0d44udzIwsan1d20di6qHiznLAGr6x6EKBmiBZY5BemV0HoaKq96VLjwupRlbfNxyRlKr3hoiD5tCkIe+qrva6FOOWbHMtghzWF8EIVde06J8MRVOFQXMCn/6n4M6DkXMDYwRBjZjffRXgpyzYWCmhaTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 IA0PR11MB7211.namprd11.prod.outlook.com (2603:10b6:208:43f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.29; Thu, 18 Jul 2024 01:52:00 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%2]) with mapi id 15.20.7784.013; Thu, 18 Jul 2024
 01:52:00 +0000
Date: Thu, 18 Jul 2024 09:50:31 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Andrew Morton
	<akpm@linux-foundation.org>, Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Kirill A .
 Shutemov" <kirill@shutemov.name>, "x86@kernel.org" <x86@kernel.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>, "David
 Hildenbrand" <david@redhat.com>, David Wang <00107082@163.com>, Bert
 Karwatzki <spasswolf@web.de>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <Zph051h5BsSFMpR6@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <ZpTLCscCFGtsrEjC@yzhao56-desk>
 <ZpUyZ9bH1-f5y5XG@x1n>
 <ZpY5uU2NyOoMVu5A@yzhao56-desk>
 <ZpbDnoQxGubegtu-@x1n>
 <Zpcgmk6wexTKVv2E@yzhao56-desk>
 <ZpfR_L9wtuXhtSGk@x1n>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZpfR_L9wtuXhtSGk@x1n>
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|IA0PR11MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c84fcf2-2197-49d4-331f-08dca6cc36ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TclsJA2XOVbuIMjAug5Lj9KLk1llXClb9HfWIHZpJA8VK+oYfELHit7jl+ub?=
 =?us-ascii?Q?Uu9yZCBS+7hCTBcWhtn241h3Sv1vGaSuOF9ZswPNxDHQJIK7tBROBk05X+Uo?=
 =?us-ascii?Q?1Y/RpejB2vOeg6m1OHxhRpwbLI1xuiLXWwGzCmIafldx+g9y8b+unhTfmSJJ?=
 =?us-ascii?Q?7cfCIs3RT7Qixlm9BFLx2R992JR03dEWFwnTDB9av1CHGJvHyvPu3BBf2MWg?=
 =?us-ascii?Q?TNh9oZ479waPJhR0/KR2AU4PEojXv4bv3kB6PVQRpeH7NKpfpBzgbXhk0v9Y?=
 =?us-ascii?Q?oDh/AI2CftvUBtjxe9G3PLaufypi2Q7CaFnEkav2ysoMQ8bLT4p7QlAzteZ9?=
 =?us-ascii?Q?M/nWmLOA7/xetGb8xUeA17n1Jl0hhN9Tya/W5+HxAgwQ2sbVqIxjCg6O1gNd?=
 =?us-ascii?Q?+EU2l+1wu3tRy+AMhn+S71jJTMZtgVAQF4Q6G1V3Q+3fc6S3mHppMkpx7jBk?=
 =?us-ascii?Q?bhlRpWfEefPU860arg0FFB3YA5Fx+3t7YDMYPritkCnyodbxg5BJbBpiyzbI?=
 =?us-ascii?Q?Tie13bhpZ+FrWrItdcDsiLM46rivSHmHH6wZN0ygsgYITAzCE6C30+DRbUZ/?=
 =?us-ascii?Q?0GuPNliUvjBKeS9vklyCTPCOvI5HrjOhX+K2WPidPHZGAXsieyAa0fU4lkb9?=
 =?us-ascii?Q?5BG+QrAsdeZjg8dZu8SNnRtLn9XqlwTuZPs7myuJan40If3BZ1EBXf4Dikbx?=
 =?us-ascii?Q?nKYfwoG+NJ6Vv86/MTMzzlqUJQMJY/LEpOKQ7UR5gJmrM+ZRBi6nm6k9cE1b?=
 =?us-ascii?Q?/3kJJtAG2JiBE2eWyeSe7sRinUhhygY/19t7/wVAC/B4im+r59ntPz8ekhHm?=
 =?us-ascii?Q?ikDxRGRYVKZ6nUr4Fiwuer1ziSg7bXBWmeV58kSNdzlZ5K33mFyLIJOm9MOv?=
 =?us-ascii?Q?Tdl/wlOIGVAQ9rfsvdQVBSddJ3K4boSEMWyTONLYgdw8uuQi1yYUds04vn29?=
 =?us-ascii?Q?SLG/9POWvHp69lJKSq3i29+GK21YjjLa5J+/IQBBPzyx1nVQDhIASc9peZrd?=
 =?us-ascii?Q?M+TTVNfagoT3QKqy6L80UdayX709ZnW5XBplsGKs1RC633SKWdfngaxJAxeY?=
 =?us-ascii?Q?tDV+y/2VxR+N036CgU/7F8PvPGWhbn9y9KY9sL1AgzuMHrQBtjBrmoEw6zDe?=
 =?us-ascii?Q?fS5NVnvbTszQFhzvIFKYMde+V3zAntxcMUe8WrXJBWoGhUFklL1f73PrglRv?=
 =?us-ascii?Q?dLBCPrQ+TnT+Ic37SUX5tFu4h67/K/94twiHPHSMy7GocF5z1ss3yZ5+FZi3?=
 =?us-ascii?Q?bWy4+Iw/0TV4ij/E35K9kKyS9WrA49zAr6ODo7DZTiDAnxpkTTmgDIMttpbo?=
 =?us-ascii?Q?tsdL1wtD1UGdyO43nJjQ/SUa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4jDAvr/G/HW5Rx5D6UEnpBNsyRjCoNwA3R2ijnmaXYvJWl5VlGAVCLCss5O/?=
 =?us-ascii?Q?r3EFNb1nngvznpPTr3GVVOUGEA1O924u9F1PdQcqi2U9B+EFfIgKy/e6uPF7?=
 =?us-ascii?Q?ZyhnHT72rUxjBw9+UcLdFCkTAJzO10O5/+6RBJtCZSU8HrBciQSHzNMz/kuW?=
 =?us-ascii?Q?SGLjyRgPxnlTSYgGt44vvs/uYdQ1ffNjYAWawFCCs1DhCGD2+TbkQB2BafEv?=
 =?us-ascii?Q?Y4sMuU/ivv2lJnc0kcIRe1eMeygQB3MGWfyqAT+3Us0x1YomPyu+fdaRY9O+?=
 =?us-ascii?Q?YROlm65Swfcgc6U2gugpAUHt/fv8ja6HCXq0Xrl36mVqiLz/qjxYY4aAZOGu?=
 =?us-ascii?Q?/azAa2WOY41n/2Fbd5nXRNFwsBs4hIE4QCy2lo9IIpighC8Te3AIx6MURy5n?=
 =?us-ascii?Q?ejrE09ftmmvUxZATvE7rR8J9oZoUwt6ElClfD12X/++bFaheaLxNcJRA2cTs?=
 =?us-ascii?Q?HLuRzrBc2bMOlhEqqBVd5mh0ateg5JYCmJ97gPv+sJEQjaQzNijDB/vSma8l?=
 =?us-ascii?Q?R0+PAc8VYprFoJAChcc1U0+k0gpgWEThNz57QEVPil97/CL+9JjUoRrCUZUg?=
 =?us-ascii?Q?q/H7+GDmd13e46IqEeup1xzT5LBTmHCr/4h2uAwtLxemnRJnNSlH1IvHkGzA?=
 =?us-ascii?Q?jKE3zQObls2CKGZuWzCMb2CdL9dk0r7h/rNAtMjFJrO4UtMpWOrfWnPMEDc6?=
 =?us-ascii?Q?u97V9KKQea39zfs2BvREhapiPpu3j3hZcgvevXSLc/MIBc4YHcXj+pS7FhaE?=
 =?us-ascii?Q?PMPP4hGpkR8CqPGP6RGLCTIW//7lxDoMGtfvhrT9gK5wWTdHlDWflUSh14TN?=
 =?us-ascii?Q?EF7XrbYibjPYya7j29aRcUFNa0/ifUBHAY0y3MCZLkqxxNRWXG6/t9ucaUgV?=
 =?us-ascii?Q?smxnca0LFUnGc9DIWY+NW2B31XLWqnbYdm0JbYMVl6jWtiEopfBSEfIrVbf2?=
 =?us-ascii?Q?HkmdbiKzGxQlMqdqXstaPlDGDVDVHvt02Rp4KonpjjLddR1Itsw9hhVNCbob?=
 =?us-ascii?Q?lDNaNiNsgP5SzWobg7truz3PWPHs5/Nl9kV6uSn6phRlmqM6U4GulE50NKTN?=
 =?us-ascii?Q?6PZgtudFWs/fSJZl0LRuqofZGXK1kZITbUphzhiDRSX8Ga23c91mUmZm8Jg1?=
 =?us-ascii?Q?cC0PAqRNCe8B63ZabY4NMXKX9RyXlmLQZPK56NHJy9sui1IAA01Io/cPe2q3?=
 =?us-ascii?Q?HYDerkQQ0SpnUfLAJ0hwCYSfNzvtCBPVAZSx7pA/4GVD7Lxf8F9YhQTFI64F?=
 =?us-ascii?Q?Zg0yqt2pbhUAVWPI8nQEOc7d9F8o+cWUfZNnXy8cUvxAXM+eKEDM4R5zW7Ti?=
 =?us-ascii?Q?5hMt1+UdE4HOqHrVnmlMeOaO9zfrPCOv0ZD4VPt41PEwy4xqNTKNtXz0kly2?=
 =?us-ascii?Q?BkEPKhBK+fk6cqsb0CqoX+5S3EB9H+j261EatgumrzNIYWLndU3yMnTc6lOL?=
 =?us-ascii?Q?AJBJheBP2MiXnPWC277q57A9srdXZRf13ZwVIaARyWDZKvbsAGC8Zv3SldG2?=
 =?us-ascii?Q?LWT9GNx352rFiFc/EtFtIboTG4LvdmZ5PGEaZPiiUFzqQuGmEpn8eTf19Xtj?=
 =?us-ascii?Q?IvcyKzgxI3D96vZiIDn1UttoS5dLv3wvdXp4TZ1p?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c84fcf2-2197-49d4-331f-08dca6cc36ac
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 01:52:00.2083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBwmTe4FizXBmUhU8/veETd6RINpLeavX/VySRxZACGUC6yLjYKNWNoES/aE2AH26GsOSQZ7t89BkC+GMFPnQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7211
X-OriginatorOrg: intel.com

On Wed, Jul 17, 2024 at 10:15:24PM +0800, Peter Xu wrote:
> On Wed, Jul 17, 2024 at 09:38:34AM +0800, Yan Zhao wrote:
> > On Tue, Jul 16, 2024 at 03:01:50PM -0400, Peter Xu wrote:
> > > On Tue, Jul 16, 2024 at 05:13:29PM +0800, Yan Zhao wrote:
> > > > On Mon, Jul 15, 2024 at 10:29:59PM +0800, Peter Xu wrote:
> > > > > On Mon, Jul 15, 2024 at 03:08:58PM +0800, Yan Zhao wrote:
> > > > > > On Fri, Jul 12, 2024 at 10:42:44AM -0400, Peter Xu wrote:
...
> > > > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > > > index 4bcd79619574..f57cc304b318 100644
> > > > > > > --- a/mm/memory.c
> > > > > > > +++ b/mm/memory.c
> > > > > > > @@ -1827,9 +1827,6 @@ static void unmap_single_vma(struct mmu_gather *tlb,
> > > > > > >  	if (vma->vm_file)
> > > > > > >  		uprobe_munmap(vma, start, end);
> > > > > > >  
> > > > > > > -	if (unlikely(vma->vm_flags & VM_PFNMAP))
> > > > > > > -		untrack_pfn(vma, 0, 0, mm_wr_locked);
> > > > > > > -
> > > > > > Specifically to VFIO's case, looks it doesn't matter if untrack_pfn() is
> > > > > > called here, since remap_pfn_range() is not called in mmap() and fault
> > > > > > handler, and therefore (vma->vm_flags & VM_PAT) is always 0.
> > > > > 
> > > > > Right when with current repo, but I'm thinking maybe we should have VM_PAT
> > > > > there..
> > > > Yes, I agree.
> > > > 
> > > > But, currently for VFIO, it cannot call io_remap_pfn_range() in the fault
> > > > handler since vm_flags_set() requires mmap lock held for write while
> > > > the fault handler can only hold mmap lock for read.
> > > > So, it relies on ioremap()/iounmap() to reserve/de-reserve memtypes,
> > > > without VM_PAT being set in vma.
> > > 
> > > Right, neither vm_flags_set() nor io_remap_pfn_range() should be called in
> > > a fault handler.  They should only be called in mmap() phase.
> > > 
> > > When you mentioned ioremap(), it's only for the VGA device, right?  I don't
> > > see it's used in the vfio-pci's fault handler.
> > Oh, it's pci_iomap() in the vfio-pci's fault handler, another version of
> > ioremap() :)
> 
> Right. If to be explicit, I think it's in mmap(), and looks like Alex has a
Yes, in mmap(). (The "fault handler" in the previous reply is a typo :))

> comment for that:
> 

> 	/*
> 	 * Even though we don't make use of the barmap for the mmap,
> 	 * we need to request the region and the barmap tracks that.
> 	 */
> 
> Maybe in 2012 that's a must?

I think ioremap/pci_iomap in mmap() is not a must. At least it's not there in
nvgrace_gpu_mmap().
But nvgrace_gpu_mmap() has remap_pfn_range() and Alex explained that
nvgrace-gpu "only exists on ARM platforms. memtype_reserve() only exists on
x86." [1].

[1] https://lore.kernel.org/all/20240529105012.39756143.alex.williamson@redhat.com/

> PS: when looking, that looks like a proper
> place to reuse vfio_pci_core_setup_barmap() also in the mmap() function.
Yes, look so.

> > 
> > > > 
> > > > > 
> > > > > See what reserve_pfn_range() does right now: it'll make sure only one owner
> > > > > reserve this area, e.g. memtype_reserve() will fail if it has already been
> > > > > reserved.  Then when succeeded as the first one to reserve the region,
> > > > > it'll make sure this mem type to also be synchronized to the kernel map
> > > > > (memtype_kernel_map_sync).
> > > > > 
> > > > > So I feel like when MMIO disabled for a VFIO card, we may need to call
> > > > > reserve_pfn_range(), telling the kernel the mem type VFIO uses, even if the
> > > > > pgtable will be empty, and even if currently it's always UC- for now:
> > > > > 
> > > > > vfio_pci_core_mmap():
> > > > > 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > > > > 
> > > > > Then the memtype will be reserved even if it cannot be used.  Otherwise I
> > > > > don't know whether there's side effects of kernel identity mapping where it
> > > > > mismatch later with what's mapped in the userspace via the vma, when MMIO
> > > > > got enabled again: pgtable started to be injected with a different memtype
> > > > > that specified only in the vma's pgprot.
> > > > Current VFIO relies on pci_iomap() to reserve MMIO pfns as UC-, thus
> > > > no VM_PAT in vmas.
> > > >  
> > > > Calling remap_pfn_range() in the mmap() will cause problem to support
> > > > dynamic faulting. Looks there's still a window even with an immediate
> > > > unmap after mmap().
> > > 
> > > It can be conditionally injected.  See Alex's commit (not yet posted
> > > anywhere, only used in our internal testing so far):
> > > 
> > > https://github.com/xzpeter/linux/commit/f432e0e46c34e493943034be4cb9d6eb638f57d1
> > >
> > I'm a bit confused by the code.
> > It looks that it will do the remap_pfn_range() in mmap() if hardware is ready,
> > and will just set vma flags if hardware is not ready.
> > 
> > But if the hardware is not ready in mmap(), which code in the fault handler
> > will reserve pfn memtypes?
> 
> I thought I answered that below.. :)  I think we should use track_pfn_remap().

Ok. Then if we have two sets of pfns, then we can
1. Call remap_pfn_range() in mmap() for pfn set 1.
2. Export track_pfn_remap() and call track_pfn_remap() in mmap() for pfn
   set 2.
3. Unmap and call vmf_insert_pfn() in the fault handler to map pfn set 2.

However, I'm not sure if we can properly untrack both pfn sets 1 and 2.

By exporting untrack_pfn() too? Or, you'll leave VFIO to use ioremap/iounmap()
(or the variants) to reserve memtype by itself?

> 
> > 
> > > > 
> > > > Also, calling remap_pfn_range() in mmap() may not meet the requirement of
> > > > drivers to dynamic switch backend resources, e.g. as what's in
> > > > cxl_mmap_fault(), since one remap_pfn_range() cannot reserve memtypes for
> > > > all backend resources at once.
> > > > 
> > > > So, is there any way for the driver to reserve memtypes and set VM_PAT in
> > > > fault handler?
> > > 
> > > I must confess I'm not familiar with memtype stuff, and just started
> > > looking recently.
> > > 
> > > Per my reading so far, we have these multiple ways of doing memtype
> > > reservations, and no matter which API we use (ioremap / track_pfn_remap /
> > > pci_iomap), the same memtype needs to be used otherwise the reservation
> > > will fail.  Here ioremap / pci_iomap will involve one more vmap so that the
> > > virtual mapping will present already after the API returns.
> > Right, I understand in the same way :)
> > 
> > > 
> > > Then here IMHO track_pfn_remap() is the one that we should still use in
> > > page-level mmap() controls, because so far we don't want to map any MMIO
> > > range yet, however we want to say "hey this VMA maps something special", by
> > > reserving these memtype and set VM_PAT.  We want the virtual mapping only
> > > later during a fault().
> > > 
> > > In short, it looks to me the right thing we should do is to manually invoke
> > > track_pfn_remap() in vfio-pci's mmap() hook.
> > > 
> > > 	if (!vdev->pm_runtime_engaged && __vfio_pci_memory_enabled(vdev))
> > > 		ret = remap_pfn_range(vma, vma->vm_start, pfn,
> > > 				      req_len, vma->vm_page_prot);
> > > 	else
> > >                 // TODO: manually invoke track_pfn_remap() here
> > > 		vm_flags_set(vma, VM_IO | VM_PFNMAP |
> > > 				  VM_DONTEXPAND | VM_DONTDUMP);
> > What if we have to remap another set of pfns in the "else" case?
> 
> Use vmf_insert_pfn*(): these helpers do not reserve memtype but looks them
> up only.
> 
> > 
> > > 
> > > Then the vma is registered, and untrack_pfn() should be automatically done
> > > when vma unmaps (and that relies on this patch to not do that too early).
> > Well, I'm concerned by one use case.
> > 
> > 1. The driver calls remap_pfn_range() to reserve memtype for pfn1 + add
> >    VM_PAT flag.
> > 2. Then unmap_single_vma() is called. With this patch, the pfn1 memtype is
> >    still reserved.
> > 3. The fault handler calls vmf_insert_pfn() for another pfn2.
> > 4. unmap_vmas() is called. However, untrack_pfn() will only find pfn2
> >    instead of prevous pfn1.
> 
> It depends on what's your exact question, if it's about pgtable: I don't
> think munmap() requires PFNMAP pgtables to always exist, and it'll simply
> skip none entries.
> 
> And if it's about PAT tracking: that is exactly what I'm talking about
> below..  where I think untracking shouldn't rely on pgtables.

> I'll copy you too if I'll prepare some patches for the latter.  With that
> patchset (plus this patch) it should fix David Wang's issue and similar,
> AFAICT.
Thank you!

> 
> > 
> > 
> > > From that POV, I still think this patch does the right thing and should be
> > > merged, even if we probably have one more issue to fix as David Wang
> > > reported..
> > > 
> > > I'll need to think about how to do that right, as I think that'll be needed
> > > as long as pfnmaps will support fault()s: it means when munmap() the
> > > pgtable may not present, and PAT cannot rely on walking the pgtable to know
> > > the base PFN anymore.
> > > 
> > > Thanks,
> > > 
> > > -- 
> > > Peter Xu
> > > 
> > 
> 
> -- 
> Peter Xu
> 
> 

