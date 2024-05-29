Return-Path: <linux-kernel+bounces-193675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC7C8D3062
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821DB28DBFD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C15E169AE6;
	Wed, 29 May 2024 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="itQqY/is"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1FD374F6
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969772; cv=fail; b=oWw/hjNHIlGkRJheePO/rQkCzt13/1tdfqYJb2kclySfS4X+xvW/eRB/P2jbdeoYjZbNveXDZsZ9YZPHRs0HT+c1N6SaB8Ge6Y4en0wbVSg/A8vPBsmOBTSqHw4IJKQVkhht/r3WePUNzM5H3iNK62wdMh9v5O1lbj6EaIqSJio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969772; c=relaxed/simple;
	bh=V+zdExX7Or1hCXXATkCJ3YZ0gQTWdUn7XoSZxaN3mAM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ePf70+5TzY+WgJItbHNHUftda8Bp84c+qGPjzrDsJAvmIyU3kUfKbRbne0BMpVPOXll3MwomkCakW8leMj8+QS4RK4komS+aaEm6ifpVY8K1vm6ECBzn16fHE9ZDRqeK72lWWIUk5OJGyWOtVRrgVOPLVnkDJRQ3Jdcz7HQuvUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=itQqY/is; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716969770; x=1748505770;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=V+zdExX7Or1hCXXATkCJ3YZ0gQTWdUn7XoSZxaN3mAM=;
  b=itQqY/isdXwFZUV9nTktitnzNRFGWkaScVtDRqdV8xxBZSnpESp/1ItH
   ZwcCSmk4ZtxaUQmGNs9du96JcDgq8NKORDBOKbpsh05fT8ldM68VCcp5J
   a7zDSjHmYAYp2MVMF8p3KFMti5i7NEiPQPNIrhburchWeEZL4DIa/My8l
   0KWeso5jVQ0f9t23nFAps2DbzfdU3sSlCjTBK+Dyi2WScpMz5jaPGrWE8
   myVHnFouFEHT7TAaYP2GfDelGeGfFhlijOkvBjgORjWCGnaydCnF71VRE
   mLFIDFS8nuKqDl5waS0Q6Aoy1OJzJ16hXRan5RU2dQOm5fGJyuPOkCcmY
   Q==;
X-CSE-ConnectionGUID: yovJtbdHSv2ZKlqW2Pig7A==
X-CSE-MsgGUID: 4Dbvm56iQfKhTqYnN/lGHA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="38742875"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="38742875"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 01:02:49 -0700
X-CSE-ConnectionGUID: 1tSS8nEfRbCS7S7e4RbKww==
X-CSE-MsgGUID: ldJ/PM5LTVqjX8oCnPw7OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="39781544"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 01:02:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 01:02:48 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 01:02:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 01:02:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 01:02:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQSUZ1w4rLnraZI4QShYP9psSdrZQmypQqkuGZFav/XM9yaRM4Dkc7CYJt2QIGE5FsLtUgJUUM28ydUHz82tNLgz69BUeY/UtCTYjIW5DZnjF/02/o2SC+f2R0fBv5GQjNNXtxu9oyS9B3T9jlYsxGWSXkEyDj/v4X8hW9J9oaAOdrcWRYCtzACb95uVdeOqLgdtuHytCoYHpNCeeSdiT+MfuTiyqo9ix5ECYDwjoQ0gw+iIriGybrcnIu5fY+1ztF0e8Hs45zv6H6/G1YyT5dseEb3yHNbdnjUR448kENm5PgtGvj4SNsiMRdl1VbMNq8tvYKlM6igZ9zZsXo5HZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47WB/P8cowdfWYTefWLVaw3DwSxz3orQYieSQY5rtao=;
 b=OASCboYXvSSJbCeiV6Y04JXPeGnLIPHKLXMUYTjNPptyKEY+lrUfT2idNXNDK+gKFi9eY1eG6UfNetYtk7S5pahbgNvKVBHoTYB5r/o1vfPy+2IlBDoBby4MZd8xqzxrd8kdEmrvy95GW17OVVTOJf9DGtNyO6EZwdt4+qVD3cMvr058yOmqFvN9Zc3KFI30cdaLVkwB1EVT3+qRI67nZd6Aw5slu1ckv8PvVWeFipACfgJyD6Dcav3X//FNceZujxuECy9Sc2Dxop321sOV5B+JtTCwEP6lueAduejiQYX5LY2NPlDjSQ8W6WYpoV37XCrDHnj+0ZOvR+tToM6vUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by CH0PR11MB8192.namprd11.prod.outlook.com (2603:10b6:610:191::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 08:02:42 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45%6]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 08:02:42 +0000
Date: Wed, 29 May 2024 15:54:26 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [paulmck-rcu:dev.2024.05.18a 44/51] update.c:undefined reference
 to `cmpxchg_emu_u8'
Message-ID: <ZlbfMhpMmeGU+4aH@yujie-X299>
References: <202405271352.XYjxKyUi-lkp@intel.com>
 <df54d8ab-514d-409f-8522-b0790a12b953@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <df54d8ab-514d-409f-8522-b0790a12b953@paulmck-laptop>
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|CH0PR11MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: d0412bf6-38e7-4325-b04e-08dc7fb5b768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1zjSi+RDGspXag6EvsYEllX2Obx0obQ9MO3tC8UefFICKKMxIaFXCNfEpo05?=
 =?us-ascii?Q?OFY2J3GlY1FCchUeIAC7+IkfQNbYztydj3AencI5jyrRnZhOiEslMl5vX+yj?=
 =?us-ascii?Q?vMhyYBojlR81ruRQUmfpS7P+Pm6NqguSwO0kSGhy1p4GSWjw2leQ+r1hkUmO?=
 =?us-ascii?Q?EU03NaAXcb8/gsOMCoKcYrBjV4lCeaNub8EMgJCL0IjlnhO7/ulewQjgvjbP?=
 =?us-ascii?Q?p+ZgxEo0xcZZrs8AwQbx8TJ1OlzwCxJq6m0C++wJU+iu5EdLDecCsyxN1mnH?=
 =?us-ascii?Q?OGKsPYQPSLN8krEK9qkW4jazeE6fB1Nb7VDSepb/RPXYAyuHWupb+heM1UY5?=
 =?us-ascii?Q?n5woskGD2KtLX2x7GQ4vLUxAsrnEzacKnHox9d5nkYlFr+KLz3UBmtS8DTAW?=
 =?us-ascii?Q?HhDyOLPO8BsvcrL733y1vhvWefIQ/tbuu0hW7RNuPbyVNaQvJY0bUEcVVd7P?=
 =?us-ascii?Q?GA7ltUzmmgqY04YMK0Gx8Br6vf9VOZSh9VwQEfej7rYCM2IhaGXs25Q/94Rg?=
 =?us-ascii?Q?PoeJTI5KxEYfOKg3WurCGx4N6VZ7CKkgeQmoagxtlNpY4NX7QMMFKaafVT5D?=
 =?us-ascii?Q?0ptZhyJpFrlvW5t01m8ho9Fb5rg3vFqNnGlAKSKfxcnt5HunfWlvNSU8+65u?=
 =?us-ascii?Q?tgEhqvgDGpCoRq87QtzS903giYT8lWKjmZpBDtbU8a2GLsM81mbHCPa5rqWt?=
 =?us-ascii?Q?xXOZ64Uwmuti2NkaxzvDYLKyALbKc/JL5rPNeS3lTNCXmJielUhaFTTNYOtv?=
 =?us-ascii?Q?wL931RcmUlorylFZZy0ZSk2moX+WIkJd2yokZs3JctNOnQ93cyqZtLWoroFS?=
 =?us-ascii?Q?7XKotUMmyDqijAyRazS5hZUywHgMgF5WPooL9drNKOdp6yds1TRkw5dBiWDH?=
 =?us-ascii?Q?G6sBDwNsFVkgMmcDoqDr/+CwGIxdiTTmJrrhneml6XlENoXXdDYhBV7E5ltU?=
 =?us-ascii?Q?9ltP//IAAAD5zcj66x4m8TWsoKl4OzIkzl4ZtaJszercyNdzeINpPUCU3E0Y?=
 =?us-ascii?Q?lY7sUVd9fmHhIt/H2hx/3GJEdzqBM3jmP15l53u67iL4NTapASqmarUXvuzO?=
 =?us-ascii?Q?KowO9J/8FSlneazngI0/9tBm0kNPhpH4avNYEOjc1ipOV832pLxjWxFFZkjE?=
 =?us-ascii?Q?cr+jICbZ5Mhpmvd9Xq8Dte3v8lU40EtB6WHwqWuRNeCjcA2hbSKEzKJpWiZ/?=
 =?us-ascii?Q?K9MQ8M5bthM2V6R3GHKPCzabyp8BYT2N0KdstSYUtCDZrUFTkbSoi7X1fSM?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n9C3wrLKXLuQHd8XHrIuo01TrGEW2WJkki9PacDuOY2uzWPc/xzV68z+nkic?=
 =?us-ascii?Q?jCo5rn6lSpQluW+5pAzyu9+tyIR6InVj6ErB+OJrb7u0+z3ibA3D0jJ2ivBN?=
 =?us-ascii?Q?LduK5UdBCNQD1deto6U8733lCrJF49IPzm3zMF8yrzOAAy3Pa0BJas5F/Vbi?=
 =?us-ascii?Q?wCgx9MRlF9JlY8QsJkEkXR0mnwqiiskM5R5CmDyyiQYaMvJQ/xuCy7n1kRxJ?=
 =?us-ascii?Q?/5DciriLtcdOLIkF/Wj3noZ9leAmktINpAm270zkuPm/Ozv+gH9bN0foVIBU?=
 =?us-ascii?Q?sChpILJm3PZpOdEcuToiEx4e4fAQUGZ8cHhBZ2Mny7XZiCB8FrxDXqUUJdtE?=
 =?us-ascii?Q?xmDqtPNe+l0B/bt5Na2eAT9TuHEWJ9Qehel5XuhNCw65dro+xBPg4rANh9vU?=
 =?us-ascii?Q?p8HBjU+ciorskyOWGGPUDLYfTOjz5KYYu/RKFi2O1OWveCMr7T1jMeLbE0hm?=
 =?us-ascii?Q?SqQCeSIB60yHhJZ9Go4lkFWHonBoXCjbpBOpD4cmlJHscZAWxTZEvq2y+Q06?=
 =?us-ascii?Q?8KkE1Ek06Y2vZ8nKCY/smz5FkhAniQ/7WYzHZIYbvaPLpDLWr4gJ9QA26K4H?=
 =?us-ascii?Q?AYeEZmrpFwXB4IyPmaFKpimRU/aOlzjuP7beGptq7br+gN/f8CzeUlUK+/aC?=
 =?us-ascii?Q?QTQz8ImAmV2Wz0nrJ/bZxmLV8JPrwh3Y/97pc2JXesDrveLM30ps/gq56wiW?=
 =?us-ascii?Q?zQqCuqpKI3a3W+VYUSixSFVn2bHxZfy2OW5r0cwGyaZB1wHMxKzy0rf5oGpB?=
 =?us-ascii?Q?G7Ie9zCzq4iJ841wTyiOxZmwYTQ6dKSa7KErsWR3sxK59kFIag2GQKXm8u1R?=
 =?us-ascii?Q?lFK5DiiAtJR7cD4CQMgRd3t/nAnlcoz/mnxvlMYTNxUHW23NuXlULMP/Ps8L?=
 =?us-ascii?Q?I3b6WvOQoEwYLh8T8HhaVOvDEjuR8IZICxy6Up6/vuCWD++5Y/n/CjyDedtj?=
 =?us-ascii?Q?YayHdzX0K/Cbo3OV2n60j9iS3k4OKH/R5W29BFaEH+g3NdzLRHjSqbchSXER?=
 =?us-ascii?Q?3oTPx7clSG63Pqqt3v7pj4ipbVskw+P2KZ+eX0DYPBh59L/Os41gDFNBJ2SP?=
 =?us-ascii?Q?PNnsliaIzRbY/7zwhaupoiMOwi6MUEvguSQyNLBQ3evY6j1ilVm8umha0ZLn?=
 =?us-ascii?Q?tc4U+ja6EMpciajPeMuJqIapdZLVRcqCPWNg4AKgv1tvAfBFniMtwE9dcmnm?=
 =?us-ascii?Q?ClmUxstBsiTIfotIR6uk8iO+NPm1YXyFUnm8pC4uFbK7sCVxnYvYjfoSbkJt?=
 =?us-ascii?Q?SR8/KLBvnB27CIrocF+mhvXww415vP25m8CgWDWunWZ0aAT9UuVvtYVpeBGs?=
 =?us-ascii?Q?cOakVQb5G9GAEoCRgPLZBgdzvkj6KKegPP0r6QU3Psga1+AyTuqppAsCK2aj?=
 =?us-ascii?Q?jmt0XQXtZ8SRozMDYcZl57y1SZ8G6SAtQMjerU3mmpWGT5pgpQWNTLj/gwea?=
 =?us-ascii?Q?YtsDUKbc5KpMKHYba289UGFPcqT4zA77/TKEy7O2EZgHj16fzRhQwuWgnM6N?=
 =?us-ascii?Q?rp9yBCbKMo561E9f3nM3ntsK4akw2LZJgBsX6YGp5n/l0I21BVILJ8fzifjI?=
 =?us-ascii?Q?jNTFYjf6fVNX/lOFwaIMEgYj7/Q+M1cqf32Qjat3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0412bf6-38e7-4325-b04e-08dc7fb5b768
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 08:02:42.3961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNwnvdGdzzQlxrtLP0BDgZvEdg0gfvFGbMMRSnEEpOKnUDXiG9DTq7zLOM3hS9rogt7SuEXbikbB2f9sh755GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8192
X-OriginatorOrg: intel.com

On Tue, May 28, 2024 at 12:26:43PM -0700, Paul E. McKenney wrote:
> On Mon, May 27, 2024 at 01:25:58PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.05.18a
> > head:   0e3eb8082184e066eb389f5e6f9c7b8c2d452d66
> > commit: c48887df74a95090e633a29ffbcef00b71cdab66 [44/51] rcu-tasks: Remove open-coded one-byte cmpxchg() emulation
> > config: um-allyesconfig (https://download.01.org/0day-ci/archive/20240527/202405271352.XYjxKyUi-lkp@intel.com/config)
> > compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240527/202405271352.XYjxKyUi-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202405271352.XYjxKyUi-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    /usr/bin/ld: kernel/rcu/update.o: in function `rcu_trc_cmpxchg_need_qs':
> > >> update.c:(.text+0x27d5): undefined reference to `cmpxchg_emu_u8'
> >    /usr/bin/ld: kernel/rcu/update.o: in function `trc_read_check_handler':
> >    update.c:(.text+0x2839): undefined reference to `cmpxchg_emu_u8'
> > >> /usr/bin/ld: update.c:(.text+0x2882): undefined reference to `cmpxchg_emu_u8'
> >    /usr/bin/ld: kernel/rcu/update.o: in function `trc_inspect_reader':
> >    update.c:(.text+0x52ce): undefined reference to `cmpxchg_emu_u8'
> >    /usr/bin/ld: update.c:(.text+0x5330): undefined reference to `cmpxchg_emu_u8'
> >    /usr/bin/ld: kernel/rcu/update.o:update.c:(.text+0x5933): more undefined references to `cmpxchg_emu_u8' follow
> > >> collect2: error: ld returned 1 exit status
> 
> Good catch!!!
> 
> Does the patch below clear this up?

The patch below will select ARCH_NEED_CMPXCHG_1_EMU by default on um
arch, so that cmpxchg-emu.o can be built, and it fixes the link error
for me.

Tested-by: Yujie Liu <yujie.liu@intel.com>

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 47450c70303a11da1bd650403844ad9e688f05a4
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue May 28 12:15:06 2024 -0700
> 
>     um: Emulate one-byte cmpxchg
>     
>     Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on um.
>     
>     Reported-by: kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/all/202405271352.XYjxKyUi-lkp@intel.com/
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Cc: Richard Weinberger <richard@nod.at>
>     Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>     Cc: Johannes Berg <johannes@sipsolutions.net>
>     Cc: <linux-um@lists.infradead.org>
> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 93a5a8999b07e..5fc55e1d71122 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -11,6 +11,7 @@ config UML
>  	select ARCH_HAS_KCOV
>  	select ARCH_HAS_STRNCPY_FROM_USER
>  	select ARCH_HAS_STRNLEN_USER
> +	select ARCH_NEED_CMPXCHG_1_EMU
>  	select ARCH_NO_PREEMPT
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_KASAN if X86_64
> 

