Return-Path: <linux-kernel+bounces-261833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F280193BCB9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E53282888
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996B816B389;
	Thu, 25 Jul 2024 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVtlw0zh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748CD339A8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 06:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721890183; cv=fail; b=FuHkHHlYr2UF4o11o9t/s09Yz0c9AN3AXkxhScqb98W3WHs3PB1wUf3CYqAqZFIYlyMDC+zG6pUmmeuw7Yx9/av9vYDgp5vi1pFQXgJJa1VX2HO7KjSxrWuRebAKV1aYrvcEYDnOij1Xb7Vo1fMlzYtpJhqZbiQNp+ByY4TV4aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721890183; c=relaxed/simple;
	bh=WqiiJMS73fmQv9F0AGn78LSV12gq07kWZG1ByL5nNAI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=AhFgwWpTo9mbivF1IdCLZgJl/vpOvFpA6mMiBCQvNmNwo3EAXi6phFCkVlwtc7tsj/Mrz/3BigXcB+o1apBqfG++OYV4zvHXC9Al1rJS48FTmPJTp0cdbyPt6xtu+wQrVq+66s/DT60CptMfMhAu/xchm4xSRhyWUBb312lOUxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CVtlw0zh; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721890181; x=1753426181;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WqiiJMS73fmQv9F0AGn78LSV12gq07kWZG1ByL5nNAI=;
  b=CVtlw0zhIOHNa156h4xejya7HKBbEsLISZzBorl9fRN9XFZCG4u31ZC9
   GlpDdfRt7Hx/sxwEH96EzL/DZi1c4Em0LWG42GXChEkm3kSwvsMv0A1u3
   +OaCGjlHcTzwWfXPAax6Olu4Zo12BF6M8Z9IkoNOFgE86WzqKBxgnBTYW
   W6KmZ/OcsNZdRZC/viotTikQQAEayQB1pD1C49kUwKTMZgHhmohMSdXWh
   qzT/qKvWzZyFmNp6H9iFfGTUlc9bPuC7BMSNgMF6R1RvbbHe8RcCRayVd
   d0t3S3gebOe9ErMTh9ptDZ6iavxQdPnTuRG1H4vxOSYEI4a4YnUhQiON/
   w==;
X-CSE-ConnectionGUID: pPDS4DjSStOdfcERytrv9Q==
X-CSE-MsgGUID: ord7N20KQSKsHdMByLGaMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19482847"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="19482847"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 23:49:41 -0700
X-CSE-ConnectionGUID: vtw++YquRRaYUqyGtImSpg==
X-CSE-MsgGUID: lflperAvTGCpmchSA/12Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="52697209"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 23:49:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 23:49:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 23:49:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 23:49:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/GFhdLG+bdQM8wU3od8tSjxWC9uOmwVqRWnTkVKISsvhu8j9tOcYvrykpVK1ob81g4CUggxLy84+2dvQMFLv43C5BsyuzXYi5R1Ih6J7YQQQcH7+3RZTbBNJa3xq406cZgP8UDxiopow1W/prVbd9MK7XwzEeQpevajTjlfVuuMJ56+Z8seC+F1s2Odl9KGkJSkQ4VvKwpZ3hXm17OLfCY0scUgdVN42BDbLNWFSGaghCOsvTdYbLtC3EDmxWBZF7pt2rUZeQRk3X5jQbU8IS+ZaPMKr9zjfQWCV/fKUtlN3oR7tl4kP6uRR6+uwyMvunJruv0yK51Koac7l78PtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rgr7i78bPQHNQWgz2rPg2CZqSYHLDD+m5bYXShHVuD0=;
 b=oXXTBOZfkdGamYFaH3ESBK9gppv5SJAmJByBGFwYn3MQboCJgOuTIpt0qzMhj5bnGJZXTJZTY9HtK60yl7G1fcI/7Y/4MCokieHqmylKn+h9HyucZhxMFTuRCTXulkOfBAUO2PC6FhRSCZBAvE88CUIB6U5NGmY/QUh++RDOhTenw5evNBBklWN7gkfYVoAZpd/IzFCuXfC4ZO4AyrVdA8olT08g81NPQMR9LO1kKpq1nwEBj/lDOe+pji3et1CxW3utXzrgab/XOT4xk5aDGGXONQel3V8bV6LM6DnbDT86WXANQBi6T8yghg11m6BJd4QAypXWnsyezNJCu3zrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH0PR11MB5252.namprd11.prod.outlook.com (2603:10b6:610:e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 06:49:37 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 06:49:37 +0000
Date: Thu, 25 Jul 2024 14:49:28 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [paulmck-rcu:dev.2024.07.17a] [EXP rcuscale] 9e146da3f3:
 WARNING:at_lib/alloc_tag.c:#alloc_tag_module_unload
Message-ID: <202407251351.f65c33a0-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH0PR11MB5252:EE_
X-MS-Office365-Filtering-Correlation-Id: 759a6283-a937-4ef1-cda7-08dcac75f335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qmHZQ0AIgJIdNpbEQc8U8MohuqUwdcX+8lq2iLfLQe1OQ34++QEc5iy6vAZd?=
 =?us-ascii?Q?3Vy+WdecAJcOvDAVV9ubdj7H4eaa5sPBY67yPDXkpm4pfASkotuxldQbqdi1?=
 =?us-ascii?Q?RUr3poly6UUHcB/MNRLYTfNReZsas9ZRcq/Y72WQAGYAOskQLQiKkOIPVFvN?=
 =?us-ascii?Q?Zsg+0XABDcnVjtnLhTUKSEHjhkrVS/po0OMko3m3L5hWbt1U/zhXgDs4ujMm?=
 =?us-ascii?Q?uTYTNRuC09AymkY/Eeli9NVtHbyKnYsCVY+elFOBj/P2xJWZZC27XJ4VtPCk?=
 =?us-ascii?Q?fT6A37zoPgQoLrzRn89odquiY6aVbN1YUutJYvZvY/1QFyuLAHhsTfCiYZiV?=
 =?us-ascii?Q?Zfnt9CMOPxDEb+wfa8Ju38k4CqCROOPSXewuXBthWB+9K4TgdvMKpBRT+pz8?=
 =?us-ascii?Q?ajS6aa43+LrajA6HjrbdR9wYh6s4tRm4SJxmfObfEn2HylPLco79HtsQYmM5?=
 =?us-ascii?Q?Fz81hu3913z6ERJS9SoAnqjtQeB1k+b1NHemU/mywFsNL9mAgUDNqPv0Ro09?=
 =?us-ascii?Q?6+QNKu7ss6P5DBmHcxCudNzxxQWNMubkc+2b8vx4kdCBW+e3yMJQ4Ka42hA+?=
 =?us-ascii?Q?41w+tAcO16ogDgjR+HzCmTaC72R9HhBMldYmf5oYKDLJT0JSEbGxJ+5reggN?=
 =?us-ascii?Q?kTcYisoX7seCtjMkpVzq+7yhZK6UNuyb5G2QAYwER85BJbN9nGWEpCB7WPmy?=
 =?us-ascii?Q?xqUXg5btRtbO021OmwYXxWcdutjcytpexYL+Jy8odV+6Omn2ADen4eLQjz2s?=
 =?us-ascii?Q?eVmGtKuntVBWZa61K6unNLb7jAlaDDx+eMXJmROInkhAgN2Osr+2553MMdHV?=
 =?us-ascii?Q?fbGwZpTAxySsF4OwvMCFYSMRwBBqZYqFAE9uMUn0I888xrCGN1FuIIUA97YD?=
 =?us-ascii?Q?Vn/3U4jauiIJRQUr6wgIDDlQ6FQy3m6twkOTM4/7WymuTBqF2iMYs1uUTNUx?=
 =?us-ascii?Q?ZdB6BDtr+m6s/nWOETZRy2L4vymaW7Hrc4p+i7vHP2CcMhoPqJT4gkU4i6Ow?=
 =?us-ascii?Q?a5hj5vfmnTJ7zeAQKme8qRODrHiEuE1r+imT9UIl1G+jLDCnprL5Pl0UP/Vl?=
 =?us-ascii?Q?FBvDfxP465WsEDQdJDws2nh+Uq1evzAry1VQtqjLM8ydIs2snUcAGFLsAD4Z?=
 =?us-ascii?Q?ls9zXyM3OHERJ5s7QyB8kZp4KFBTfFrS49Ld+Ho40aloUuBouHRpIsmM0vFq?=
 =?us-ascii?Q?NvfOq7LkpW9deAUWRjlIV3eTWL4O3OknXoBHPZ4K4rpKHlVRcTc9pkTjoc83?=
 =?us-ascii?Q?4SJMRwXi4ld8hBxkmm8dUCxBcJ1o1X5lgaIqGBvze4CWQ7yhEnVlTQTkFrUt?=
 =?us-ascii?Q?IHE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LzCcVd9TNoYEKzwLwS5CYElzo1m3WJy6vgP51Evi7QXpklPAJKl2hM1nLkCx?=
 =?us-ascii?Q?weqrAwkbTQwR2e/8RY3D0rZDmV5SRzisIsrmcP8WiJZxYFfbEp82wSiSYJ97?=
 =?us-ascii?Q?sKcpIpt1EHNla2ovs+sOXGI3NLJMa2YqJtGo6o8pQUPBRazwIUsRYHlRdMhE?=
 =?us-ascii?Q?beNQ3DXkouGk/jC3x3rsBkzbfNIBL3V4nxwHf35XYRzVmQ0CENkMOKq+k7jE?=
 =?us-ascii?Q?nuMyAz7yOCrsbDY6OAflEnXuODs25XK5KZPknoyvdHfDjWpAU6bYzx9fG7pF?=
 =?us-ascii?Q?r02CzB0xWH2rqGx3B3wdJRYu06broxIeDRtInje9I66muMPBT9kEmCVCwnIp?=
 =?us-ascii?Q?K2wfb6DT0uRNI3bN3/DOqkaDpQo38E6zetgIbA1y4Hx6cvgfrxxX02VxdvEI?=
 =?us-ascii?Q?qCVdKGmgXQ0I68lCYSjlpxaFLYh9uCOK345hNVjr9uj/f+uZbFy8JEdS2xqH?=
 =?us-ascii?Q?nilBPXvrLz0SUFqK4lOo5Kjmj1vSZVAdDqw3Cd65mg3x9HHbNps/UhGYLNl8?=
 =?us-ascii?Q?s2OElsdcJQCgWfw510YU8v8pe3yUuCdQyqA6sfciulTeaO8TSFhJFOPE/nfF?=
 =?us-ascii?Q?wSr3X+GnkAb7k7+n0p3TAaVnEcqonWIS1mggfexcr9q7EdysTY1hQP6vtb6C?=
 =?us-ascii?Q?DTiO1Qke2zQHUplg0/qFRmoQv/Fh2WpGPHXbbvVDxsV5f2l7RkDzzeg48d6n?=
 =?us-ascii?Q?RW4Lbx0seby+DYqQ0bxH7SCCIZW8ov1Zw/2/4S4EmmrwkhSKSm8soo4NcKi3?=
 =?us-ascii?Q?yzQgF4eE7KV0sK3ul456urtOM6Sbi0S9hgfNCM8haqO1ij6T3xv62Pmzpn8T?=
 =?us-ascii?Q?8MH4gsIA5mE/c0dXTxd80/iW9p7N+xHbqSm77EU1bKG68GmWoULaF19DQ5fB?=
 =?us-ascii?Q?b6hiYa/uti+islJg+iVN/4T1fZql3mVUKcUWJwR9UpgUnzU9I+uYpNpBeuKs?=
 =?us-ascii?Q?Z/EPam/VMaVSJFQg2D/s5rq/7+bXc3/vqB7zDMPYzWa/zwot0C0oxPq9VZiw?=
 =?us-ascii?Q?f+P1I0ocvHasHAztqWhhr1mDnV1RDHW5kgAV8TBevTDhywvxhx5vXGBn/4Uw?=
 =?us-ascii?Q?QkRkaJJnc9lnyFwApTSIXt331hWnUsgO6TZRPoC6kE70xK1mEi29qwdiqAIr?=
 =?us-ascii?Q?hptyXwkfot7bS7nclzrDHcB/GrL9P49dHxJTy3ZnY/ym7pi0t+8T9FYOBgkj?=
 =?us-ascii?Q?YwcWYezZw5SqbAXn/y7KYDbuFUJyYtPFq7OA2jT1qKVOjOGDSmhxg4Mo39l/?=
 =?us-ascii?Q?tRnMxoMEJtex5sTuitonCJN2GemRoYnw7cY1uDVGHJgwNJ95xqiLkMGR9e7b?=
 =?us-ascii?Q?4YmkEWgTe6M4dkKaWnF/50BFg5P0qsxQ9328oOqNWMWcq9BEXDb3PurnvJP3?=
 =?us-ascii?Q?dNULL6B1So5D12iFcbxqeBk1BVam6nI+fXNe9/VXnJ2hAOsKCfP6VQ+NIZih?=
 =?us-ascii?Q?ltC0NccHwHaHAgKDOMFnFZS+MRSTZwqRrMsVecucLvNkiAkb/QV+w3KBbN9J?=
 =?us-ascii?Q?gvuJOaSkH80KR1YL1Ut/2WfsnwNE1dOG5xKfvFV8t2ZZ3aKhNqMvhJTbVI1G?=
 =?us-ascii?Q?eSHjoIXA4slgzyJJY39bfjcItVzihqKTdr0XtrxFS9mSQ1tgJYcCt88Xu2OX?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 759a6283-a937-4ef1-cda7-08dcac75f335
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 06:49:37.2545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vU7WvAG046XT5RrE2RYQlIwgiOZTDjbFDf1rPSMXNlVBv4UGrhaPCeovOeabGks6+5LEIgh9fE0Dx3eiG6SXbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5252
X-OriginatorOrg: intel.com


hi, Paul E. McKenney,

we noticed in commit message "Not for mainline in its current form".

we saw below commits in the branch:
cdd5ddaa17fe fixup! EXP rcuscale: Dump debug info
4f60b8b679fd squash! EXP rcuscale: Dump debug info

but we still observed same issue on the branch tip:
fe09f037acf7 (dev.2024.07.17a) rcuscale: Make rcu_scale_writer() tolerate repeated GFP_KERNEL failure

at the same time, we noticed there is no same title commit in newer branch:
dev.2024.07.18a

just still made below formal report to you since we are not sure if it could
supply any useful information. if not, please just ignore. Thanks!



Hello,

kernel test robot noticed "WARNING:at_lib/alloc_tag.c:#alloc_tag_module_unload" on:

commit: 9e146da3f351c0eaf66756cc3a6c6a5845b81187 ("EXP rcuscale: Dump debug info")
https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2024.07.17a

in testcase: rcuscale
version: 
with following parameters:

	runtime: 300s
	scale_type: tasks-tracing



compiler: gcc-13
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------+------------+------------+
|                                                     | e136892a8e | 9e146da3f3 |
+-----------------------------------------------------+------------+------------+
| WARNING:at_lib/alloc_tag.c:#alloc_tag_module_unload | 0          | 12         |
| EIP:alloc_tag_module_unload                         | 0          | 12         |
+-----------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407251351.f65c33a0-lkp@intel.com


[  439.356638][ T1799] ------------[ cut here ]------------
[  439.357183][ T1799] kernel/rcu/rcuscale.c:1037 module rcuscale func:rcu_scale_init has 8 allocated at module unload
[ 439.357225][ T1799] WARNING: CPU: 0 PID: 1799 at lib/alloc_tag.c:168 alloc_tag_module_unload (lib/alloc_tag.c:168 (discriminator 1)) 
[  439.358903][ T1799] Modules linked in: rcuscale(-) torture [last unloaded: rcuscale]
[  439.359632][ T1799] CPU: 0 PID: 1799 Comm: rmmod Not tainted 6.10.0-rc5-00110-g9e146da3f351 #1 308a8ed8688556473cf6c28b678fa76bc00dc1d7
[  439.360679][ T1799] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 439.361546][ T1799] EIP: alloc_tag_module_unload (lib/alloc_tag.c:168 (discriminator 1)) 
[ 439.361993][ T1799] Code: 92 ff ff ff 8b 55 e8 8b 45 e4 85 d2 75 04 85 c0 74 21 52 50 ff 73 0c ff 73 08 ff 73 04 ff 73 10 68 d8 2f cb c2 e8 ec 39 9f ff <0f> 0b c6 45 d3 00 83 c4 1c 8d 45 d4 e8 2e fc ff ff 89 c3 eb b2 8a
All code
========
   0:	92                   	xchg   %eax,%edx
   1:	ff                   	(bad)
   2:	ff                   	(bad)
   3:	ff 8b 55 e8 8b 45    	decl   0x458be855(%rbx)
   9:	e4 85                	in     $0x85,%al
   b:	d2 75 04             	shlb   %cl,0x4(%rbp)
   e:	85 c0                	test   %eax,%eax
  10:	74 21                	je     0x33
  12:	52                   	push   %rdx
  13:	50                   	push   %rax
  14:	ff 73 0c             	push   0xc(%rbx)
  17:	ff 73 08             	push   0x8(%rbx)
  1a:	ff 73 04             	push   0x4(%rbx)
  1d:	ff 73 10             	push   0x10(%rbx)
  20:	68 d8 2f cb c2       	push   $0xffffffffc2cb2fd8
  25:	e8 ec 39 9f ff       	call   0xffffffffff9f3a16
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	c6 45 d3 00          	movb   $0x0,-0x2d(%rbp)
  30:	83 c4 1c             	add    $0x1c,%esp
  33:	8d 45 d4             	lea    -0x2c(%rbp),%eax
  36:	e8 2e fc ff ff       	call   0xfffffffffffffc69
  3b:	89 c3                	mov    %eax,%ebx
  3d:	eb b2                	jmp    0xfffffffffffffff1
  3f:	8a                   	.byte 0x8a

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	c6 45 d3 00          	movb   $0x0,-0x2d(%rbp)
   6:	83 c4 1c             	add    $0x1c,%esp
   9:	8d 45 d4             	lea    -0x2c(%rbp),%eax
   c:	e8 2e fc ff ff       	call   0xfffffffffffffc3f
  11:	89 c3                	mov    %eax,%ebx
  13:	eb b2                	jmp    0xffffffffffffffc7
  15:	8a                   	.byte 0x8a
[  439.363599][ T1799] EAX: 00000000 EBX: efbf9040 ECX: 00000000 EDX: 00000000
[  439.364218][ T1799] ESI: c4215290 EDI: ebdfdedc EBP: ebdfdee8 ESP: ebdfde9c
[  439.364818][ T1799] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00210246
[  439.365471][ T1799] CR0: 80050033 CR2: b71fd210 CR3: 04026300 CR4: 000406b0
[  439.366083][ T1799] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  439.366676][ T1799] DR6: fffe0ff0 DR7: 00000400
[  439.367170][ T1799] Call Trace:
[ 439.367451][ T1799] ? show_regs (arch/x86/kernel/dumpstack.c:479 arch/x86/kernel/dumpstack.c:465) 
[ 439.367803][ T1799] ? alloc_tag_module_unload (lib/alloc_tag.c:168 (discriminator 1)) 
[ 439.368264][ T1799] ? __warn (kernel/panic.c:693) 
[ 439.368604][ T1799] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 439.368992][ T1799] ? alloc_tag_module_unload (lib/alloc_tag.c:168 (discriminator 1)) 
[ 439.369435][ T1799] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 439.369807][ T1799] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 439.370162][ T1799] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 439.370549][ T1799] ? handle_exception (arch/x86/entry/entry_32.S:1047) 
[ 439.371024][ T1799] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 439.371397][ T1799] ? alloc_tag_module_unload (lib/alloc_tag.c:168 (discriminator 1)) 
[ 439.371843][ T1799] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 439.372238][ T1799] ? alloc_tag_module_unload (lib/alloc_tag.c:168 (discriminator 1)) 
[ 439.372693][ T1799] codetag_unload_module (lib/codetag.c:238 (discriminator 1)) 
[ 439.373112][ T1799] free_module (kernel/module/main.c:1266) 
[ 439.373470][ T1799] __do_sys_delete_module+0x1b9/0x206 
[ 439.373968][ T1799] __ia32_sys_delete_module (kernel/module/main.c:700) 
[ 439.374397][ T1799] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-061-20240719/./arch/x86/include/generated/asm/syscalls_32.h:130) 
[ 439.374780][ T1799] do_int80_syscall_32 (arch/x86/entry/common.c:165 (discriminator 1) arch/x86/entry/common.c:339 (discriminator 1)) 
[ 439.375225][ T1799] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[  439.375611][ T1799] EIP: 0xb7f79092
[ 439.375910][ T1799] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[  439.377475][ T1799] EAX: ffffffda EBX: 00e4333c ECX: 00000800 EDX: 00484939
[  439.378043][ T1799] ESI: 00e43300 EDI: 00e43300 EBP: bfbcdc46 ESP: bfbcccc4
[  439.378610][ T1799] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200202
[  439.379237][ T1799] irq event stamp: 5473
[ 439.379574][ T1799] hardirqs last enabled at (5483): console_unlock (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 kernel/printk/printk.c:341 kernel/printk/printk.c:2746 kernel/printk/printk.c:3065) 
[ 439.380336][ T1799] hardirqs last disabled at (5494): console_unlock (kernel/printk/printk.c:339 (discriminator 3) kernel/printk/printk.c:2746 (discriminator 3) kernel/printk/printk.c:3065 (discriminator 3)) 
[ 439.381023][ T1799] softirqs last enabled at (5142): handle_softirqs (kernel/softirq.c:401 (discriminator 2) kernel/softirq.c:582 (discriminator 2)) 
[ 439.381726][ T1799] softirqs last disabled at (5133): __do_softirq (kernel/softirq.c:589) 
[  439.382384][ T1799] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240725/202407251351.f65c33a0-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


