Return-Path: <linux-kernel+bounces-253248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B42931EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F8B1F2206C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B7063D0;
	Tue, 16 Jul 2024 02:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dd86tUOj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABC417C2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721095262; cv=fail; b=G07ErZ2tVj2oN2G6I8UQMFBSuV5PO8AK2Q9xdmNqH8C9Psqw2c6V7FKjW6UDnnzn+uFYz3UZsG0HKPnaXMVoydF9kV0AKuNpWjbPKgzFak3AW8MiaDA9DeWncTHBHnfIOzHDSIltWNwgH0XlwhSoqXRcLNtFIb/n6eQZnGQDxQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721095262; c=relaxed/simple;
	bh=jUf3COK/LJ0ewrOW7WC6D4s1FC32LSprqYlLK+9TImg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=okWhUTZJJ7Y48XvuAzZMmoGpq/FVQgjfgxPrr7p5nrrspPSNNPv6n794TPJE0fdLH3Dvr58IqjaZKppDmFsCiELKYSXYN3V4KwwpK++HohLrRbJvDbbA3TSwybJZDZnV3fBZoPWeJrL8K2MpU7btJfunDQsfof040pU5tncfR94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dd86tUOj; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721095261; x=1752631261;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jUf3COK/LJ0ewrOW7WC6D4s1FC32LSprqYlLK+9TImg=;
  b=dd86tUOja7lcDmkurVNH0cGrRO4DjQcfSopImr3XmAOpWIKE/UTlcRlr
   ESBXnoTjC8kJaGY13l50myj+8BXnsFy/lLp0KyOsDK4Uk9/JOUPKVCDBt
   LbYupDjDjQ6rDo4pPkCEnXB1a6yLNTR0FB06Idq7Br5SZO4hijrKLexgT
   P0ukKcbv4MTmcraEsS5iRZTAiU302c5esmolrptl5TnGxVm3uG6fhUawN
   Q3QT2CLt7Dd2H2RhbgDR++iQ4I/oKM7vG7FDBufrYQhuwFg/UYYMHKlbN
   W7KNg9wOcZb5Xc6MmHZjbIXBoty6ZdhPgmmzwNPqANlpIO+NwPQQfPbOI
   Q==;
X-CSE-ConnectionGUID: qEh8N2fTSqWjZ2KEJwcxGg==
X-CSE-MsgGUID: ALMLSZeHS46HB+k4Bt7+Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="35941707"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="35941707"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 19:01:00 -0700
X-CSE-ConnectionGUID: f/tjenrxTsyz8BaDYHSXtQ==
X-CSE-MsgGUID: oq6VT2zFSqyXkEyCVVhWIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="54377526"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 19:01:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 19:00:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 19:00:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 19:00:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cR33cWH70HIzxlsv8AxIp70LPWzWuh0sFiUowXos2DCj4sFtcHm1tg45Wx1xOHhKsgSU+c8qCo/nALtcqAoN5jhPja2MW6RviRccQCN1TixPJeNbFixMKBm7hZRN3aCS+qbRiCCZNqWMDh0Df+z19dZ5bxfk7SOJde7bZwha2tuaKpevQxxUKDvEQpyqcpVjpAU32XT3yRURA7f+T4tEWYb5LmnIO52cwnEJSeveSc9HyONiLErU3kM1OZu74oVShPN5fzV941VLTwAZ7FEljcONh16ukeSwo7fWZ6WxJw+c6wt7W5HRh3qQr1VrZAxQ62qydt3zwmqhc1pD8te9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GC7RiCQna9tu1R/s4IUT9Eyi2zoOEoPRkx5pws4b8Q=;
 b=AsXgrbDA0sZI5exQjZbqLQ8NX5gpm+NDTdUWvN4jVTOgjEoGGNgfCzEwc5y/l9WKAmOH0ogGLULwOSb9HBUA7BhbUuNZ/qDD8tXrAMTUccBSISmOlRJhoLjYt1cT6xiPyTpSLpyB1nnQ2DXS48iyNLJ6zpsu69pT+Q40Fw1aosESDDX2J1CMFHHbWonlzTFiHva1tjuoG+Ur1n3TjSrC+8+6R08ai4iJs7mCVjTwYb68YGoXhSl7iNBt1BqVasCXW98+ONo6ykYw8mI1Vm/pZXbiKl1rlpLMd6ytDsdQXZKTDEqg+VT5tPzDGFNVSGLxcuk2YY9Rw3R4CkyIjZDfNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DM4PR11MB6550.namprd11.prod.outlook.com (2603:10b6:8:b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 02:00:56 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%3]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 02:00:55 +0000
Date: Tue, 16 Jul 2024 10:01:39 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
CC: <linux-kernel@vger.kernel.org>, Lai Jiangshan
	<jiangshan.ljs@antgroup.com>, Tejun Heo <tj@kernel.org>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH 3/7] workqueue: Remove cpus_read_lock() from
 apply_wqattrs_lock()
Message-ID: <ZpXUg/HNSSX9ix/6@xpf.sh.intel.com>
References: <20240711083547.3981-1-jiangshanlai@gmail.com>
 <20240711083547.3981-4-jiangshanlai@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240711083547.3981-4-jiangshanlai@gmail.com>
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DM4PR11MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: ade7870e-234f-42f4-14e6-08dca53b2112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8RnJP0yvRKhc5lOh2L1wICFeEdWx7IM+9ehzL3VmyXiPBySITI9RcSMIIaco?=
 =?us-ascii?Q?ESpMjhlH3vTubqVmBFJzt2+lH2EmmWT8ZqMiwqUJ6e7RBjDS/xlzmQc2neWb?=
 =?us-ascii?Q?ZMBeujtmhle2ARpOcLRjBJDc9JHzlGuiGXsPKvSNnhqPWX9Dg+hdoTKWKqW3?=
 =?us-ascii?Q?6az+u9CADFZOARrOGOFHOhWb3WxlvCZUm5l/sLqv4ydMlUbB3TIqrJQedQPs?=
 =?us-ascii?Q?YlOdVUDyheeegsI2gwZWMKWt+HXSXNVpleGD+gdkEvA8EY+7S6UB7ts6+/Xb?=
 =?us-ascii?Q?Gvt1ND1WBZ4j6Ws/BYarSIjVU5oUyB0eWe8awOPYBPTbsjAv6oj30i8maH7R?=
 =?us-ascii?Q?vAs5p1G8a6RsSWfdMLAD6UWLB1I3TaGGaztAb2P9iXqxFXZ3Co8sQqZclw0Z?=
 =?us-ascii?Q?pZlF3reK5FRxFlB8hVAQJk53nJj0S1/jLjLzHpTtwD+4gsYkgRpYRni0zw5a?=
 =?us-ascii?Q?96UNafdHVv/6p69OsGc8vLgRbXi8P3ODH/btvKXh+jmszbrDnGWdLEaYvOjC?=
 =?us-ascii?Q?7ueetTVokgTwJyW4xUMr1AG86m9u5hg7wqi4Sitsu+7VH4rBTkA7OxntWgWP?=
 =?us-ascii?Q?oip95KfuvnnqawjADuuyRZZdBZTe2ax/OHMjAwiOM4sS84msbRrsbrtDeimB?=
 =?us-ascii?Q?4D1KGaMpF3cUZ+qKVFC6IYys/TWcJCqLhIT4E68oIzOmkw1MxdkqV1pVfwxb?=
 =?us-ascii?Q?rE3fTaRy+4rAJseNvnzY3qqy+qzOiKWhcMayV1k52g2i/bfff+p85/EVl6eV?=
 =?us-ascii?Q?lfe2UFVaqtqLRWCoC/S0s7LJuxCpOFTpLAlnj1D8/hm7tb74LhCkpe1r7LOs?=
 =?us-ascii?Q?rpgxtqNk1Lyn8Z1uAJlu8sDuekHY85DUjjYCiIrHLG2V8DeeCt02yLq+RlZc?=
 =?us-ascii?Q?0fxJbZq69Pw8DxFOwSZh5cnLE0BshVKmjTmyk6AjCTID1BTnU3rPOqZ8ifE1?=
 =?us-ascii?Q?DdOo5xXeoWedzd+Ssb03MSM5isAaaC37iNLqMKr09mI95uap2z3RBNa0Oz0x?=
 =?us-ascii?Q?UE5h7+bdqjcggPnijV+t65pBwmYB0NRjHis17M5B8j7XBUHg95baYlYIXVpA?=
 =?us-ascii?Q?1cacDxhY/n4X2XMvSOrwLai1AFqayuGliNx+DlzoI6mdl6aPIXi6Aq+EBPxo?=
 =?us-ascii?Q?M8SpksWLwhTsUMl/+hod/Ys17FBR4iPTsdZMsvN834KjqqvYZMFd6lWdPPR6?=
 =?us-ascii?Q?zy1F6QqZ/exJK0FaQFtHxjZCZ7vhRq+cBrwNFkut4yEY8V8XiI54fehcCGhU?=
 =?us-ascii?Q?boaJLjmuzcGjz1pgW2lwJUWrhtmbN0Y7o7DpwZ4jBBV5uVZfqMVxA/VzSV5T?=
 =?us-ascii?Q?8Bs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3mNoAImHRlzCiflO+QLvAOrZ2EkkIPzVYPwiGJz0Biip6YZiXhlT2I3Cz2po?=
 =?us-ascii?Q?Gg18ni0+dd3wmYPcUirwZ7C4mtn9tpZz2WgwQNeZzh9kaeHyHGvGwvUraATb?=
 =?us-ascii?Q?4nzvdjmoYwYvwAFwjLPzkerhO3leYw5sgbFfIQzOblRJ8tduDMnJlYpx2i03?=
 =?us-ascii?Q?dzE5p5cCg1QH49K4wzUMOJ17e/DUYc280/wBULfobe/4b/WSRMYmxvVsxYua?=
 =?us-ascii?Q?RFh15vbrI6dNehPWGKNsnTWDdZwMFmnfAqBSBddpQUZtFU+zQtvNsjiCFKtE?=
 =?us-ascii?Q?QyQDQHvQmUn4B5upmY1Qc66PVzFG/FdQdZe4zdEGvgzc5dlWVyUJWIZqdPqx?=
 =?us-ascii?Q?LYzyuUvEfta5tpnG+GSD65ySZllAFQHG3ggA1Hy+TZ5HkLh0TisXYKWsOmwC?=
 =?us-ascii?Q?Mw102gabcQUjElckdhR5L/DY/XHvuUOLJNjTS5GFn6EKwq1wrsLYIIFR1rOa?=
 =?us-ascii?Q?WeqaRrgeRm3ZDfrROLE/p+IRSxfyo3QMRnI7UfPCWRacNyZpEVu5LKmbExka?=
 =?us-ascii?Q?pLKR98xctQJ0ggFGzeisPdot+qc4yDKcSHT2z5AXaWfL8R04oNzxI7ob4ILE?=
 =?us-ascii?Q?7tXC7EXJvBREDzo4Bb4qRxZVWzop3wI9f1Rq45Qufh5fdxiVNo4IOQkkyIHG?=
 =?us-ascii?Q?RqhVR+E2fmpRL9Dwo9K3JI51xDOKHIEWpE4y4+yI3x/041hOCQWQaC0+5/O6?=
 =?us-ascii?Q?yZ/pHcFO0VKrTAZwKSX6/r5tFaJHo6jlp9ch1WsPdsrNKGlv1leRacpddyRu?=
 =?us-ascii?Q?xFLHXPLOkm6JAtaJOY1dEMJ0cBiCHSVk5uiZnEFcf+5p5j0YGTZaseKsu++H?=
 =?us-ascii?Q?Na1sYVi1Nm7CkmRe3lVY0/32SIfRylqs3t8VUdSuEyxW6OeX0nMr7Tyephqh?=
 =?us-ascii?Q?wXiXm+dKobVOPncwqtMs7KvoAnQudpZwqgjTbXqbf+gZgi1hBalCUFtoRlyz?=
 =?us-ascii?Q?/DpR5w3tf+AgST/2ObhL4eiL+2ct6nLsm5apurB6VTRSEbVstZyOu1R/wOEF?=
 =?us-ascii?Q?7ajHLa7+EUiQJIZ0DW3pFZns0emgelny1lMigDL5y+b0wPh0kJSiksgPrIn+?=
 =?us-ascii?Q?o6jDy863UlC+GmKuPE6YXfeKMhRdM6xwhNH/eqPuOggwsqLr8Ui29fjqALuZ?=
 =?us-ascii?Q?P4ZXOV/gn4mQBtwh/0VE2GION1LXBxT5L5GpZSdfskkY7yBOYuK+2teXG+qu?=
 =?us-ascii?Q?ksDm+Uc0Nn8n3sKAD4QpIxxH2g9DZ7mjUtD9rNAnTqW2kQUBOJS4CwqwGRyT?=
 =?us-ascii?Q?1K8zvzjpy+rdufvfLtW+EQ6yTVR8sP7+lzM0VkVXRyHEncHgQRKo/g+/J9BC?=
 =?us-ascii?Q?unDOwXxH7DfIi12Dgn+/uo4uJ/Leo4nk8mFIpfPjZHGferwBl/aF/9sd8UZN?=
 =?us-ascii?Q?NMIfRBkCBwfpjqRW3c8QLAhqSfE29NshwxwAS2017/7u0ZklEbHQBA78B+Fg?=
 =?us-ascii?Q?mHLVKxDngIrYzFLPyJhYxMXwDsXcQMTsEO8PD6pauUDar861oqnchP95l2pO?=
 =?us-ascii?Q?4OXkWJpr8BtA6l7s1qXyQKRjrI2t9CIPo1Kp5uhg2iMjxRIixdfUR2VpeLTK?=
 =?us-ascii?Q?hCDBNhjruAd/qg4tz43P///O79c73pWEayRpLGci?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ade7870e-234f-42f4-14e6-08dca53b2112
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 02:00:55.8818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzapSwVKdNJ9yzYYqmnIHYFiP4CmKZ2F29nBUekS5xJv9rQhTaDFmkF8Pql1kmW7ZuvU3SQDuTsr3ITAaYc2Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6550
X-OriginatorOrg: intel.com

Hi Jiangshan and all,

Greetings!

I found the WARNING in alloc_workqueue in "next-20240715" tag by local
syzkaller:

Found the first bad commit:
19af45757383 workqueue: Remove cpus_read_lock() from apply_wqattrs_lock()
Reverted this commit and this issue was gone.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240715_174449_alloc_workqueue
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240715_174449_alloc_workqueue/repro.c
Syzkaller repro syscall:https://github.com/xupengfe/syzkaller_logs/blob/main/240715_174449_alloc_workqueue/repro.prog
Mount image: https://github.com/xupengfe/syzkaller_logs/raw/main/240715_174449_alloc_workqueue/mount_0.gz
Kconfig(make olddefconfig):https://github.com/xupengfe/syzkaller_logs/blob/main/240715_174449_alloc_workqueue/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240715_174449_alloc_workqueue/bisect_info.log
bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240715_174449_alloc_workqueue/bzImage_91e3b24eb7d297d9d99030800ed96944b8652eaf.tar.gz
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240715_174449_alloc_workqueue/91e3b24eb7d297d9d99030800ed96944b8652eaf_dmesg.log

"
[   30.328518] ------------[ cut here ]------------
[   30.329306] WARNING: CPU: 1 PID: 733 at kernel/cpu.c:527 lockdep_assert_cpus_held+0xd3/0x100
[   30.329339] Modules linked in:
[   30.329347] CPU: 1 UID: 0 PID: 733 Comm: repro Not tainted 6.10.0-next-20240715-91e3b24eb7d2-dirty #1
[   30.329364] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   30.329372] RIP: 0010:lockdep_assert_cpus_held+0xd3/0x100
[   30.329391] Code: e8 02 cc 3e 00 be ff ff ff ff 48 c7 c7 d0 67 f0 86 e8 31 65 56 04 31 ff 89 c3 89 c6 e8 26 c7 3e 00 85 db 75 cc e8 dd cb 3e 00 <0f> 0b eb c3 48 c7 c7 44 ed c0 87 e8 bd 58 a4 00 e9 59 ff ff ff 48
[   30.329404] RSP: 0018:ffff8880142cf8d0 EFLAGS: 00010293
[   30.329415] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81275c6a
[   30.329424] RDX: ffff888010a70000 RSI: ffffffff81275c73 RDI: 0000000000000005
[   30.329432] RBP: ffff8880142cf8d8 R08: 0000000000000000 R09: fffffbfff0f82dbc
[   30.329440] R10: 0000000000000000 R11: 0000000000000001 R12: ffff88800e54f9d8
[   30.329448] R13: ffff88800e54f820 R14: ffff88801349fc00 R15: ffff88800e54f800
[   30.329456] FS:  00007fa859b71740(0000) GS:ffff88806c500000(0000) knlGS:0000000000000000
[   30.329467] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.329476] CR2: 00007fa85143f000 CR3: 000000001f226005 CR4: 0000000000770ef0
[   30.329488] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   30.329497] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   30.329505] PKRU: 55555554
[   30.329509] Call Trace:
[   30.329513]  <TASK>
[   30.329520]  ? show_regs+0xa8/0xc0
[   30.329544]  ? __warn+0xf3/0x380
[   30.329562]  ? report_bug+0x25e/0x4b0
[   30.329590]  ? lockdep_assert_cpus_held+0xd3/0x100
[   30.329611]  ? report_bug+0x2cb/0x4b0
[   30.329627]  ? alloc_workqueue+0x920/0x1940
[   30.329645]  ? lockdep_assert_cpus_held+0xd3/0x100
[   30.329665]  ? handle_bug+0xa2/0x130
[   30.329689]  ? exc_invalid_op+0x3c/0x80
[   30.329713]  ? asm_exc_invalid_op+0x1f/0x30
[   30.329741]  ? lockdep_assert_cpus_held+0xca/0x100
[   30.329770]  ? lockdep_assert_cpus_held+0xd3/0x100
[   30.329790]  ? lockdep_assert_cpus_held+0xd3/0x100
[   30.329813]  alloc_workqueue+0x9b0/0x1940
[   30.329847]  ? __pfx_alloc_workqueue+0x10/0x10
[   30.329871]  ? __fget_files+0x253/0x4c0
[   30.329890]  ? __sanitizer_cov_trace_switch+0x58/0xa0
[   30.329922]  loop_configure+0xbb2/0x11f0
[   30.329960]  lo_ioctl+0x930/0x1aa0
[   30.329982]  ? __pfx_mark_lock.part.0+0x10/0x10
[   30.329997]  ? __lock_acquire+0xd87/0x5c90
[   30.330020]  ? __pfx_lo_ioctl+0x10/0x10
[   30.330053]  ? __pfx___lock_acquire+0x10/0x10
[   30.330074]  ? __kasan_check_read+0x15/0x20
[   30.330091]  ? __lock_acquire+0x1b0f/0x5c90
[   30.330116]  ? __sanitizer_cov_trace_switch+0x58/0xa0
[   30.330195]  ? __this_cpu_preempt_check+0x21/0x30
[   30.330216]  ? __pfx_lo_ioctl+0x10/0x10
[   30.330239]  blkdev_ioctl+0x2a9/0x6b0
[   30.330255]  ? __pfx_blkdev_ioctl+0x10/0x10
[   30.330271]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   30.330290]  ? security_file_ioctl+0x9d/0xd0
[   30.330360]  ? __pfx_blkdev_ioctl+0x10/0x10
[   30.330376]  __x64_sys_ioctl+0x1b9/0x230
[   30.330397]  x64_sys_call+0x1227/0x2140
[   30.330414]  do_syscall_64+0x6d/0x140
[   30.330434]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   30.330450] RIP: 0033:0x7fa85983ec6b
[   30.330462] Code: 73 01 c3 48 8b 0d b5 b1 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 85 b1 1b 00 f7 d8 64 89 01 48
[   30.330474] RSP: 002b:00007fff65352a38 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
[   30.330487] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa85983ec6b
[   30.330495] RDX: 0000000000000003 RSI: 0000000000004c00 RDI: 0000000000000004
[   30.330503] RBP: 00007fff65352a70 R08: 00000000ffffffff R09: 0000000000000000
[   30.330511] R10: 0000000000000000 R11: 0000000000000217 R12: 00007fff65352dc8
[   30.330519] R13: 0000000000402cea R14: 0000000000404e08 R15: 00007fa859bbc000
[   30.330553]  </TASK>
[   30.330558] irq event stamp: 1577
[   30.330562] hardirqs last  enabled at (1579): [<ffffffff81457403>] vprintk_store+0x413/0xa90
[   30.330586] hardirqs last disabled at (1580): [<ffffffff8145778a>] vprintk_store+0x79a/0xa90
[   30.330608] softirqs last  enabled at (730): [<ffffffff81289719>] __irq_exit_rcu+0xa9/0x120
[   30.330624] softirqs last disabled at (715): [<ffffffff81289719>] __irq_exit_rcu+0xa9/0x120
[   30.330639] ---[ end trace 0000000000000000 ]---
"

I hope it's helpful.

Thank you!

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


On 2024-07-11 at 16:35:43 +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> The pwq creations and installations have been reworked based on
> wq_online_cpumask rather than cpu_online_mask.
> 
> So cpus_read_lock() is unneeded during wqattrs changes.
> 
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>  kernel/workqueue.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 9f454a9c04c8..64876d391e7c 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -5123,15 +5123,12 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
>  
>  static void apply_wqattrs_lock(void)
>  {
> -	/* CPUs should stay stable across pwq creations and installations */
> -	cpus_read_lock();
>  	mutex_lock(&wq_pool_mutex);
>  }
>  
>  static void apply_wqattrs_unlock(void)
>  {
>  	mutex_unlock(&wq_pool_mutex);
> -	cpus_read_unlock();
>  }
>  
>  /**
> -- 
> 2.19.1.6.gb485710b
> 

