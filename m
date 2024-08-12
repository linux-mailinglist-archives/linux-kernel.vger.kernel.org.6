Return-Path: <linux-kernel+bounces-282573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DB494E5F3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF64A1C2155A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 05:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6ED14A615;
	Mon, 12 Aug 2024 05:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9/CLAvv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF6013B5A1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723439232; cv=fail; b=FduSByQs4rO9E7peT4cmELAhC9KGklRPdYTHvLfYslKpJ33DJ/4j/Opl+b5xndpfgL+NJMQ1xXvoi/hXDxiTiffbWNbuh/nbmFkyDqbIXOCw3J8w9qXbO17b0H3El2axF47bx8bMVKM4KmfqcG3xJHQ091ww3bYp1HTovpEVL+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723439232; c=relaxed/simple;
	bh=3nLnpnTFT4ooGJ3UPczAENCsoZ2VzH/cIGRL8T5DOFc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=YW0P7bQrRoeJq/8cZ2/k8kDIJ9JUTaE0FN7SYomW5u/ilDYAUBFyVlMMtAzibzEnflqmFlvFc8+JkN4e19MxzWVbP8bO+moDq7RXeH5L71MebdbSd5f47akauvR4Ap9uguZklL2xM9T5phGETfA7ppmFizse1XidhkKjj7JyaHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9/CLAvv; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723439230; x=1754975230;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3nLnpnTFT4ooGJ3UPczAENCsoZ2VzH/cIGRL8T5DOFc=;
  b=P9/CLAvvpErP6IT0uZZei9mmdNXn5GPDouBLZVsDfK+IAgokheX941uF
   vqSnMGbhXGZ+VFTRzueRNN0RTlVsUjN5Zz2tre2T9eo5cAJA7v/cxHvM+
   u1E/j4W/DsX1paggtDIhdjxcE2Tp/wWmpJuj4hkMNf+3pp/ZMdQ6IUimy
   XBRxQrPw4+nPwKXWUSXSz4QQfUAzexKJSLH2MomtGvuvbHjrveogpPiCQ
   ZMl5wO6xXFSsMNYt88Af2MDHVNuGGE/pbbaJPDek5O1YlB3n5YYfSItXN
   NDqpDtjZFQ9cbISAl51zj4HMy8LRoQHStcwJAv2QLa0elf1LkjRBx8Sdm
   w==;
X-CSE-ConnectionGUID: AGSk6/V1TiuRRPAUsQ083g==
X-CSE-MsgGUID: sVVlaVcZSOWpx3B2vLgf3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21672801"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21672801"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 22:07:09 -0700
X-CSE-ConnectionGUID: ciAUc8oyTj679SLu56Po8g==
X-CSE-MsgGUID: yFaKZ1pQSJqWwHSPhuVNcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="62552821"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Aug 2024 22:07:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 11 Aug 2024 22:07:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 11 Aug 2024 22:07:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 11 Aug 2024 22:07:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUOVTfjer76ZGD0wp0IY/ESLVqLkk04vrm6SErax+9mwBP0jppWpgBMVpxZ+J1fi/6YeCQ5kbWeebD14YdID4SSsyLxhaBfoNGmzQ9EWB1yXehLFSnAP3umgLEq+rEzqeXwg2S84K3nFHg0Mf14r4/03xREPZLeL5w65PhVtx2UHN0rRh6HPbZ2NBNG+kfVtFl12hF2rLQj1Tq05SHe4ZSkEsbHPH9kCD4BTOaLxPF9WYtKgZVXgmgaLfILXWLt/BDQ9ZLOxYMS6WAeVtWpcRLrGEuWUev60bGRoueahW0SQmbvVbiB/SBY9COwMFwP/SUwTVLyWXXkZkbqe1GVRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aePXYgPvQguolKiTvGUIMZIfcir86XT59DdpZjYGDGw=;
 b=g+kHvo+f/wSu0esBltnFunoDsBoDK+LpnSHc0w6bwIYhWH0aRwssKomEvNTbZkRmmD/KHy+3XcYf8UfTDHxKZogxF758vaXLMJQGsTplq+fgk6QyWe2qfXjxR6rm9N5C/lLGGmDMGGrsV7G+0aB7C47CZuWoK1h+cQ2R+c1jzkc8aw4K+R8jgm+UmecGE7YUVFMd2w8sy1bTC0XbS9Maqh942e/aGYp6BNrKbT41BkR/xlKp4ICiJw53vBaifPbMnluuXVIs/BjQZan2bJoLjOJcmOQsY3lXca3r1os3AJCUlf1C6JFEgbhqOkQBs0lAPva2UR/yiEh8CcxBWO04jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB5042.namprd11.prod.outlook.com (2603:10b6:303:99::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Mon, 12 Aug
 2024 05:07:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Mon, 12 Aug 2024
 05:07:04 +0000
Date: Mon, 12 Aug 2024 13:06:55 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [x86/mm]  3db03fb499:
 WARNING:at_arch/x86/mm/pti.c:#pti_clone_pgtable
Message-ID: <202408121253.8a1d34f7-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0115.apcprd02.prod.outlook.com
 (2603:1096:4:92::31) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB5042:EE_
X-MS-Office365-Filtering-Correlation-Id: eb153f42-be6b-4df2-c61f-08dcba8c9b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7GHHvKCq5phOvc04sOgua6oi4RlMdNoahZ2AbGPwwhHASVG7z74/OAhrh1cL?=
 =?us-ascii?Q?K3Gwemolol60P8tlNYjjeoGbDmFdyVWodOw6HvrxcXkvLDkdwGeukEjB0S5k?=
 =?us-ascii?Q?HDYZtE9ycAt22aezbPy33f4U0Aen85Ipa2x/uPD7B5VNaP1vi5Ns6oorKVD8?=
 =?us-ascii?Q?Deopa+r6vngq4fFEo1+gxRAkMC7eqIgxISq8Z+4znmvfpq+P7dQ2LEbNqnDG?=
 =?us-ascii?Q?go5nvSR0HUiDey7ZLIyBYfwQwI6MEuJYWidPNYefqdDPHB9VQxBxWsrXq3DR?=
 =?us-ascii?Q?SbsuKDb0M+xrPvFoZf3OQ2kbJo147ci0BVYq2ENS4OXxs/P9e6hCGsWr9Eyl?=
 =?us-ascii?Q?e4SXywTyZFFIy52/3TjEYXMbbEWOM9Y3ZukOUpZVSUJ3e5epJ55H3uZ7WFvb?=
 =?us-ascii?Q?bDXhl2+j484/zMdKhRAK5HqvHpY5FTpQflALG2QpxgbQJ+mqi6Ntrffe5XXj?=
 =?us-ascii?Q?RCZp8fyJ9wbILOvTp0zy/ekJNayWXP//pgg2XNvKrtEWzdI3kJygpZJvDuiy?=
 =?us-ascii?Q?bM8m2IhxC37A8ile7bsL3oh1aikCQqw++zisp3xRGanH4486dgfQyC8jQQ5w?=
 =?us-ascii?Q?AUJYI9g6g+jHj1wJ61yBHEo9cCZ7IxPGVo5JL+KTbPZxZBsuiAMGFkocXAjf?=
 =?us-ascii?Q?Nei66xA4dJtKkNm3Nt5vBZM2VfdP+bp3YMSsjZEpQeQMVM9vny6qYOq6u2+m?=
 =?us-ascii?Q?+6mn8Cfbqbz36J5qcQA7R8bAJP4oBy3eLkOlpCzP8H6OCMRo5VYhzZuSdINN?=
 =?us-ascii?Q?/v48hdgXA48ymAaffXjlIyI7WAHExiiEMbCqmfRTMLDSmthn9GWzzoGNHPaq?=
 =?us-ascii?Q?dM1Q0tqXf/oMKC+lwWElj1mxHOepUx9n8StE4LiHY6sIs/0fKDM/GaI6IoNg?=
 =?us-ascii?Q?PXTfTw9wb26Hy+XyvxcG9QlkxQq4l+ymF5j5xWkDwzuA9MP8tyqn4SeWNslB?=
 =?us-ascii?Q?CwDVfPQmrrkd1vXAf8ZYx8i9aZ71x1dKyUtKGnvA2z558x5M4Sv5OuAD/Tyb?=
 =?us-ascii?Q?oiz008sVDRMbI8YETYQwir9+V+e2sXQcrFrZsMZolMCL+5/rMZXWRWlyNFfY?=
 =?us-ascii?Q?jtm4FCyo26BMPH+68+xX7SywSs2g1n2BpzVbxT0noR91lVr88J7NPdFYD3af?=
 =?us-ascii?Q?+6aC/ofAw459NVarN8BTT9g8eG8Dn+JJwvJvrg/Pz0JJAOHjJPBzHdamAWB2?=
 =?us-ascii?Q?aZBfCW4PSwDwsiu5eyMg6qnkAnUViaYrxLueE1j4mPtncFNAGLmSm3pOfvAr?=
 =?us-ascii?Q?OcQoz2Zgm3rDQn4sAj4csjmYuD+0+gc6gFQUETpdYwcgBpUKbmzue/mfSsZk?=
 =?us-ascii?Q?uRR1VyQEGZ1s4qTvNwYcdC0/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZbxGtNl5R+qqkCGzTurY/7nWVX2GuvfM9zkhk1VbcCO0IVKP1bDNjkojilfn?=
 =?us-ascii?Q?xtcRjev1rpLTaDSJV/4hUvBtuw8q7Zs95iyzaxpq59uF5tv0LbrFB0Rpbe/I?=
 =?us-ascii?Q?m9x14iy0ymvL0tzbaNVMgqaVOEe6koSutFQ3PHOOLPVU0asPbcFaJoQfEstx?=
 =?us-ascii?Q?EIWKCbQcO5EcRnx1Bc0CwQY04PwKmCpt+V9jo1X0F1NHWQCdLCUp/YRGseE6?=
 =?us-ascii?Q?vVcW5Ul0ENIlaMrhr8vYlmhaSdxGVByELxq6bwAYTg2xlCcxCBu4EdrYCVQt?=
 =?us-ascii?Q?Ts4HZzyCzc/USp0IcE517VW7fsL3qtTuZu/sf7xbEig8XVh50N9e1VoRtRkm?=
 =?us-ascii?Q?fM6G1HMnfS8EaW5OmTMcWWoT+RGMBtDX3hbWJ7Qeg1kD9AU3I4B8abm3Z+1T?=
 =?us-ascii?Q?FTgSBtV3q1BGnbWENDyQztW6u2EqiH6h41MTN3eJ50pVauObb2ZNSez8/7i9?=
 =?us-ascii?Q?2lrU5lwjL3az8viCL8Jd/g6LNZzE+qnB6NtkWUxfAfotBYi3KGWpBEQLfQ1t?=
 =?us-ascii?Q?etKFBMwff9EGYO5vpXS7Lx/8LcQR+G6xhXe1xSpZEqoupTSEFO4GoKtGivxK?=
 =?us-ascii?Q?JgiqZswUJnWBRtit3icRBVl2VT7NAYNbnI3FL5MB1KJo5isUbowBYpuqj8dr?=
 =?us-ascii?Q?NRNrwyCBaGPRJXiXcc28s8wxSBnhKP7YgK+bUcK0cFMPr+Mlq8zfEMKbreZ9?=
 =?us-ascii?Q?uO/Wvr6+3zb/JN+jlCSyilQijx88VkdngraRZf8QTeTwBuS0PmRKrBpqAWMq?=
 =?us-ascii?Q?VoWczRSFDuPzzuHoVYQZVfi+lTwNb04zENEeUlP0/cv/XcU3HDJ2b0jyyK/I?=
 =?us-ascii?Q?3KAjpriB+OomTckbaKACRZa4cUasbACUiBDooOYNwYw7lBsfhHB4YiyGzWlz?=
 =?us-ascii?Q?tOErXYJbQA/OZqOXIfj9X1EyoP0k3GfSyTv6N5Rn4DIxOE3/TTHEmM61qKKo?=
 =?us-ascii?Q?05P7T37ovjqxGNs84jb4FKluRPr7WIvOY84zSfU1Cf7G0Fcpm3e49sLWJitX?=
 =?us-ascii?Q?0xhuK0abwoFxcnU/BJ5GUp/zdB3FD8oKKNZdIx4uLs8SfZBcZukhl6oM3Fj5?=
 =?us-ascii?Q?p6c82XVYebihh/BB2qxieYlrI8gZI4Agi8Y7cJH08NLn5fTgQcMpseZeIdoJ?=
 =?us-ascii?Q?i2XZQSD99p0kIb+CABPutGkCZbRryuXnaKTnNB0mkuMu67ugtyEjdfdJy738?=
 =?us-ascii?Q?/cv6WC6sVIJjS5HBLOEyu9jU0eEMhI9JTdU+fjUsqKlFENISZ22j2wXjUUUI?=
 =?us-ascii?Q?Fly/vxKQCdyPWrkc5A7n3uvK6OErcrgu1VgS8i0KOvOMRQNqhajRzY2kDdfN?=
 =?us-ascii?Q?ceADrR5+RwF6KP9hqKGcD7yRJq1iI2YI0/usmudnZFVYIjJEfpOuevFk2la6?=
 =?us-ascii?Q?+MqproReht/Y0EzHNHp2bnHzHRJ09kv6B/WszSPFoPenv5tSYjiO0/HuPs9U?=
 =?us-ascii?Q?yZaSGQEVWmC802OLkbNcU8Q90fADBT+0ZNcyd+B4tqYFB9R9/UIPQqAzUOQf?=
 =?us-ascii?Q?pmc8wQ3DLu5qirwZKW3wspyDrIPqCFidFSewFwgIeSUDEt4WoCu5jp5rn4Xp?=
 =?us-ascii?Q?h5UW0LAZ4Dml4sV8YcV7vCFH2aJA5XNrTF/itVOd49o7d0VY7qy8dGij4VNW?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb153f42-be6b-4df2-c61f-08dcba8c9b70
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 05:07:04.7199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMms5jeRwyjAU0194OYA7hjlGvCjisQtYMjcTV/nnKZ6dLKfu0ysicGmO5kqhISA9FLsUX7LfOyRordj5+MY3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5042
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_arch/x86/mm/pti.c:#pti_clone_pgtable" on:

commit: 3db03fb4995ef85fc41e86262ead7b4852f4bcf0 ("x86/mm: Fix pti_clone_entry_text() for i386")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      b446a2dae984fa5bd56dd7c3a02a426f87e05813]
[test failed on linux-next/master 1e391b34f6aa043c7afa40a2103163a0ef06d179]

in testcase: boot

compiler: gcc-12
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------+------------+------------+
|                                                 | 41e71dbb0e | 3db03fb499 |
+-------------------------------------------------+------------+------------+
| WARNING:at_arch/x86/mm/pti.c:#pti_clone_pgtable | 0          | 12         |
| EIP:pti_clone_pgtable                           | 0          | 12         |
+-------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408121253.8a1d34f7-lkp@intel.com


[   11.814894][    T1] ------------[ cut here ]------------
[ 11.815370][ T1] WARNING: CPU: 1 PID: 1 at arch/x86/mm/pti.c:256 pti_clone_pgtable (arch/x86/mm/pti.c:256 arch/x86/mm/pti.c:393) 
[   11.816203][    T1] Modules linked in:
[   11.816557][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc1-00006-g3db03fb4995e #1 77da0921d99dee185d449e76648f3c514bb36724
[ 11.817684][ T1] EIP: pti_clone_pgtable (arch/x86/mm/pti.c:256 arch/x86/mm/pti.c:393) 
[ 11.818151][ T1] Code: 00 00 00 8b 10 b8 00 00 e0 ff 89 d1 81 e1 80 00 00 00 83 c9 00 75 05 b8 00 f0 ff ff f7 d0 21 d0 25 80 00 00 00 83 c8 00 74 04 <0f> 0b eb 71 83 e2 9f 83 ca 00 75 30 31 d2 b8 c0 0d 00 00 e8 3d b5
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 8b 10 b8 00 00    	add    %cl,0xb810(%rbx)
   8:	e0 ff                	loopne 0x9
   a:	89 d1                	mov    %edx,%ecx
   c:	81 e1 80 00 00 00    	and    $0x80,%ecx
  12:	83 c9 00             	or     $0x0,%ecx
  15:	75 05                	jne    0x1c
  17:	b8 00 f0 ff ff       	mov    $0xfffff000,%eax
  1c:	f7 d0                	not    %eax
  1e:	21 d0                	and    %edx,%eax
  20:	25 80 00 00 00       	and    $0x80,%eax
  25:	83 c8 00             	or     $0x0,%eax
  28:	74 04                	je     0x2e
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	eb 71                	jmp    0x9f
  2e:	83 e2 9f             	and    $0xffffff9f,%edx
  31:	83 ca 00             	or     $0x0,%edx
  34:	75 30                	jne    0x66
  36:	31 d2                	xor    %edx,%edx
  38:	b8 c0 0d 00 00       	mov    $0xdc0,%eax
  3d:	e8                   	.byte 0xe8
  3e:	3d                   	.byte 0x3d
  3f:	b5                   	.byte 0xb5

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	eb 71                	jmp    0x75
   4:	83 e2 9f             	and    $0xffffff9f,%edx
   7:	83 ca 00             	or     $0x0,%edx
   a:	75 30                	jne    0x3c
   c:	31 d2                	xor    %edx,%edx
   e:	b8 c0 0d 00 00       	mov    $0xdc0,%eax
  13:	e8                   	.byte 0xe8
  14:	3d                   	.byte 0x3d
  15:	b5                   	.byte 0xb5
[   11.819851][    T1] EAX: 00000080 EBX: d9e26618 ECX: 00000080 EDX: 186001e3
[   11.820470][    T1] ESI: c1014618 EDI: ed116398 EBP: c110df74 ESP: c110df48
[   11.821083][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010202
[   11.821767][    T1] CR0: 80050033 CR2: 00000000 CR3: 19e2a000 CR4: 000406f0
[   11.822373][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   11.823030][    T1] DR6: fffe0ff0 DR7: 00000400
[   11.823441][    T1] Call Trace:
[ 11.823770][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:479 arch/x86/kernel/dumpstack.c:465) 
[ 11.824143][ T1] ? pti_clone_pgtable (arch/x86/mm/pti.c:256 arch/x86/mm/pti.c:393) 
[ 11.824588][ T1] ? __warn (kernel/panic.c:735) 
[ 11.824933][ T1] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 11.825321][ T1] ? pti_clone_pgtable (arch/x86/mm/pti.c:256 arch/x86/mm/pti.c:393) 
[ 11.825759][ T1] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 11.826183][ T1] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 11.826563][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 11.826970][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1047) 
[ 11.827415][ T1] ? _raw_write_trylock (include/linux/rwlock_api_smp.h:136 kernel/locking/spinlock.c:292) 
[ 11.827844][ T1] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 11.828123][ T1] ? pti_clone_pgtable (arch/x86/mm/pti.c:256 arch/x86/mm/pti.c:393) 
[ 11.828434][ T1] ? _raw_write_trylock (include/linux/rwlock_api_smp.h:136 kernel/locking/spinlock.c:292) 
[ 11.828723][ T1] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 11.828984][ T1] ? pti_clone_pgtable (arch/x86/mm/pti.c:256 arch/x86/mm/pti.c:393) 
[ 11.829283][ T1] ? __SCT__tp_func_ma_write (??:?) 
[ 11.829613][ T1] ? __SCT__tp_func_ma_write (??:?) 
[ 11.829916][ T1] ? rest_init (init/main.c:1459) 
[ 11.830179][ T1] pti_finalize (arch/x86/mm/pti.c:524 arch/x86/mm/pti.c:564 arch/x86/mm/pti.c:663) 
[ 11.830418][ T1] kernel_init (init/main.c:1485) 
[ 11.830653][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 11.830899][ T1] ? rest_init (init/main.c:1459) 
[ 11.831144][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 11.831408][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[   11.832355][    T1] irq event stamp: 830689
[ 11.832597][ T1] hardirqs last enabled at (830697): console_unlock (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 kernel/printk/printk.c:341 kernel/printk/printk.c:2801 kernel/printk/printk.c:3120) 
[ 11.833089][ T1] hardirqs last disabled at (830706): console_unlock (kernel/printk/printk.c:339 kernel/printk/printk.c:2801 kernel/printk/printk.c:3120) 
[ 11.833556][ T1] softirqs last enabled at (830318): handle_softirqs (kernel/softirq.c:401 kernel/softirq.c:582) 
[ 11.834022][ T1] softirqs last disabled at (830303): __do_softirq (kernel/softirq.c:589) 
[   11.834455][    T1] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240812/202408121253.8a1d34f7-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


