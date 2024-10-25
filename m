Return-Path: <linux-kernel+bounces-380886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC829AF74B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 04:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6B21C216FC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36417E792;
	Fri, 25 Oct 2024 02:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4VPC8MG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B7B4409
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729822402; cv=fail; b=FEiXkzBuoIQZRk0CEjArGj9KNOF1I3TycaV+4cuqjSGR08mQEfxLPpGl8hgf/8L/GJesec00HZv8Qep0mBIkr+gO86U7whill7SXA7HbnaGza9Oa8xHDNfqaHrpi89FE6RY+zB2N2a6oZplgKm6XeK0HCHDJaplxmwvsmTy5npo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729822402; c=relaxed/simple;
	bh=3gD4NdKLr4b5D6NF69+f27H5rHnRcPKghEhWyjs4fVo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rfDacGJT2jAoiODVDnily2YRV2DFtX5kYm4Bzqctxg9cH5yMm0w9D6DuaHiwIK1ASkmdfEwMwmQRXmvqlzzPzr3WERc3PX7Ld1r6+tIbzKCpzceOBDUkDmbiVY//Ea5Q9uc3n0RcgQP7B3EnM8/xKZeE18R5NAiTx+rwa1q3cD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4VPC8MG; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729822400; x=1761358400;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=3gD4NdKLr4b5D6NF69+f27H5rHnRcPKghEhWyjs4fVo=;
  b=L4VPC8MG7Dayy3eQxQPxJt1oKltdnmryTs5y4ZsQmxcMTC9gcBd2umj1
   FaWQWsgDHBUy1eRQSI2AKOFMwp/LYqSdpzsu4vcPoqcEg3U2VLk8EdfUP
   gMZKnS65d6wfoHsSltuFmx5s/kaFy9x4OTxotbndiKeg+UupwsGOFvSUq
   oHsYmkUpQ8APofLIeDed8xrpWfYTCKxjaKTFACJsj/lWVniH5zyIZIo7m
   TOU7IJ68grgVum5cu/Jhcaj18IFF0n1w4HbdLqx/HFKgwavCpqLfRnkDn
   9zi2nw5XqshuPd20S+L+or63GDTjCqzqpqeFe81V9QCAhAMomxhBIJVe6
   w==;
X-CSE-ConnectionGUID: qW125WKCTd2bPG+ZlLFiSg==
X-CSE-MsgGUID: oZpzBDrySB2g8/C30yhEgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46966080"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="46966080"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 19:13:20 -0700
X-CSE-ConnectionGUID: QOk8f6caTlKLtFmY7aZcbw==
X-CSE-MsgGUID: 7CrodPTbQLOWAZcukJDw/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="85368746"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 19:13:18 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 19:13:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 19:13:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 19:13:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIBCEoIWeGB2Z9nq2tcoOCuBiFupR62HMr08QlU4Uy74teKFDuozh5OWwHY7GPDlbYXDPCXn2dSNLuCzGJgL2lVtasmLNGEef0WR+PNhCVv361Brs6MQ+VMaGdBHSnrm/OGZFLiQIgHdYEL3Fb+27YbY+Pke3cjnT6NCTMxcsytdJ9Sj3CtkZHno+V6GE6IjWOZj0AoauO5faK6VtnsmjTxUf8Iwhe9pzOuo1i5062nR6b/NjWfsc1esa+/kO5nRZl3Wo5zMK3IolJuWpOPFoxJRij+x9lTezsMg1tFtjR5xmHTYA3xfoqpOAFrgcmEmTVS0VMv0aVl1YEP8jq0IVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjwcZkNh2xPF6Mf7Dy8AL4rW+0wFpDThveuQpDm/d7g=;
 b=jLcyY0nW3m3VDMF86x3fPzFhDhBbuhnh9x/lwpF4LNgT7F92ZLF+MVMBUk3nXIUM2391XCwjWJdUUSmi5b49P5VL+NlwUNDDZjjFyTfjMbtfvWalrOM0V3naaHBdf1g3nHrb1wwprI3Twpb2pXbgeJzylMVqtYJPpdgX9h5dqBe1iE8SdhkySpmKOGNRIEyJ0pmXz8JfKas83Lh3h0rxGn3lTAGl6sBCYsraX8f8/pCZFiiZDP5tvJXYQXzTWUyL7Tk5UG3yRHQFdyFgwB6GoSfGmQq+7gPwqWYLsETWv+qkIh95QIWg2wDK58bSGSgz5z+SNDhvgo5nbtvNV+CKWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6216.namprd11.prod.outlook.com (2603:10b6:8:a8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.18; Fri, 25 Oct 2024 02:13:15 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 02:13:15 +0000
Date: Fri, 25 Oct 2024 10:13:05 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Hua Su <suhua.tanke@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>,
	<rppt@kernel.org>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, Hua Su <suhua.tanke@gmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] memblock: uniformly initialize all reserved pages to
 MIGRATE_MOVABLE
Message-ID: <202410251024.eb4a89f1-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241021051151.4664-1-suhua.tanke@gmail.com>
X-ClientProxiedBy: SG2PR03CA0131.apcprd03.prod.outlook.com
 (2603:1096:4:91::35) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: 90594c54-b973-49ec-dc51-08dcf49a959d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V8b3GdgvOTZEVGQwjcT3DrvILzOuo6M899BNo95OrAhHIxV+a0s7XIc4Ae0C?=
 =?us-ascii?Q?OAQSmOsOZVTfxQTQhsWlVMiGCA/nFtptVRx9eut+X0PRDsNZwXMCY7JwONss?=
 =?us-ascii?Q?yBEkZo/WwWVe0Cl0b9zCiuf+8Q9NRIM4K/eRAJ7VHi/7ZRY0d/CFE1JNqSTO?=
 =?us-ascii?Q?WZBizEui+6oqwGFTSzeczXXz4914Hila5LUeN7Un3dgI+AUmqOZZkU913rmr?=
 =?us-ascii?Q?ZoK4HOX+TWz9+GDd+5odeafvq0Kn8X3oR+lTVAVGZn1NyqmgNOxtQfw9l/QR?=
 =?us-ascii?Q?tMpM/+yy60z6kGJj7r8ljG1dF0PcvNV9y+tdvy87+iXJWneuwV+Igpa/Kzj6?=
 =?us-ascii?Q?IR6uaZ8UlQT0oqp9UCPpK6pCvWsMOCrJMtmL1xvPhxbhbCBAdJrMpbaJs0X7?=
 =?us-ascii?Q?ouY2Ft2I/TsqWmD3D1YN4jkpFwqkORmk5J3FZWBTx8oy35oTRY85kC5a14NS?=
 =?us-ascii?Q?QoI+gCSjFvnNuYiYQ8KHvcW2NM6yEyLaPCfdzJFTUsdhaowNJbkJxHviUVsQ?=
 =?us-ascii?Q?+Q2hgPYATLKRcaATzFS32tnihWhgD1QHIaJgIpCjNoTYXaGvl6D04Zs0Xu6E?=
 =?us-ascii?Q?RrCRzWoyeW90vYzCmxbU0bZRhDHd+TrfBhxXfdevooO1RV4zKysmPp0XSmlC?=
 =?us-ascii?Q?1hsVwB/MuBsmKiFOjf0MzzzCzQwqMocLjMZzD1MvX/j9wSg2/bNaIoyoz1/w?=
 =?us-ascii?Q?MtFsJT+LVk+g76SsIcxnEd0Zg6jQstRaCkVE2OmEJhFKQP2H6xQNxfpa/lSc?=
 =?us-ascii?Q?UE56WWmPDZTB6gTEzj5UkQhkPftaYvbmUtWzQBKj7DKPBW5J919EE1gyJyhU?=
 =?us-ascii?Q?ZUIC0r5R9sGa4ch7+gXHEeuCDXEuh8tBiaKRsHAMpgaDm/TJhgxT+vQEXVgC?=
 =?us-ascii?Q?DvbGfdNVXVBCcTUgzXv0O7dZWAyeH5cPPL94yjxHZa8IavDR0kZ2Mp13v9TL?=
 =?us-ascii?Q?kMZs022r2Mw3dWU3lUeGV2Cl2WRWGrS5oEkM7PqpDtdJc08XQdb7N4SwUU7c?=
 =?us-ascii?Q?AocryO91dDua2/W7wDP10F789VgAc2CZS8CXlPhZKsojIdMw0tPASnC8D4LT?=
 =?us-ascii?Q?vG/0vvLVvXCZ2L5D6fWZDKn9IQ9cKzgIctOpceIARFMFED9e1BFu4v+vS+6l?=
 =?us-ascii?Q?BlFccn8SxXAnZ8nuG3OuHuhvrJvXB1sz0bQoYkJ9uPdE6PLCIjgszAPVDCyX?=
 =?us-ascii?Q?vdQmsraETdDAJg3duAUSg+DKbV8y0v8WdBaGmRQhRYTaQbKEnDF3iRNbV9op?=
 =?us-ascii?Q?Z2Qoc14fwrPkEe0Itdp2+bb2Is9CVdMP0nu1BqgqsQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LIwC3eV9j3NH6Y9fpgXT4CZuHT98unETXElBydtnlNKCDKBkzR5RmueG4n/n?=
 =?us-ascii?Q?Fu64Uz+CgJ5m4b9bFW6gcYaNFykzVLOoYRPv/qSokaqs241tB0x2cLmm3b4n?=
 =?us-ascii?Q?Pb5SI4zZINoFecll+YJFEdCb7+7k5MSWPHLHhTgA9mmXP53RcJRkuY5ORrOI?=
 =?us-ascii?Q?xwlPoq1AX+oDnFaQAhja9JDrwIfZpOn0OmA+32T9rg9FUcVsRu+2c20Sg+WT?=
 =?us-ascii?Q?Plw/5E9IO9UrzX73vcOV37AFVKvf6cp9QAu+xOEZqbV0GD7f4csE6V4hYsQp?=
 =?us-ascii?Q?qCnWuLB0aJlLblpvDyWuMIV8vSpmtfQUS8r6qQ395M/7GI4zNjEEo+vThp1Q?=
 =?us-ascii?Q?SSgqFaEyx7ApcJou7czFsWjI6Ub/F+ST52CxL+bSDD/pt1JxN1cn5t4d+lnI?=
 =?us-ascii?Q?ZRl6+azkTjooCJSIgSnR62oviGBLaW4p6OlJ0AnLn8UXnjz759b/MfCFyRMB?=
 =?us-ascii?Q?9/UsRtIdNC7ANcEOKZYRPZ4eiT+NzR25086KvxzKDF4NcFd2ffzo8f1vzqfD?=
 =?us-ascii?Q?GAlR7ogsXIhF2GpUi4ymOJ7CpoFknG4mG0pMLaCqhC7OTWn7YGF91kk7jgko?=
 =?us-ascii?Q?oJ9IcdjjcnauORhRgms5uLPibKgciEhSqqBzfdPm/Zx2DCdwJ0JVIB9FCafR?=
 =?us-ascii?Q?aRfLgVHIcC8Rj3Zqasws+1AefvONgkXQYaLzl9aedxQTJG7WdG5nU6ir2rX3?=
 =?us-ascii?Q?PXZTRTCMVWqBchEObxZ1We2D+Shnmv6EJ5DU9yxidz7GETTy+kLvrfJEnm3X?=
 =?us-ascii?Q?u6jADG9srKqzan0R7wcUqBzOXmUzo9Wz+pjJBSYO0eZYbivRGlxwTdoK6Xuw?=
 =?us-ascii?Q?cqc0I++fat3xTGRE0MW4dh/iq5P7KcpuThGIEIn8hGEwBlgHTgmbqz2BcRqR?=
 =?us-ascii?Q?DmDoDDSFVTwVHIU0C497QQo20hN/vvKRKUK345pmNIrqL5No2nonG0kWCmEH?=
 =?us-ascii?Q?E6Vgf64ISSuDXNBEEQAizKvhUXGV7FCC4Kj62J/FPwwyLOfm1F2SR02ka51S?=
 =?us-ascii?Q?roSVgSAsLRN0XkOnyOqkQuzbvgs+uOZgcFi0hcbEPhHLSYN074m+8aJa1Zet?=
 =?us-ascii?Q?3aLA1qFSxyHM148x+tSvYGp6lZxRzKtZi5ePJMLYx+LZ6DOjncDRGK9sh8AP?=
 =?us-ascii?Q?tSYQ5qiYiZycmgrW2ZwI5zqJ2FZofsueIYEquGTj+xgJ3C1m/6aHM+e0Tl6H?=
 =?us-ascii?Q?wla13pItDYKPX2n4QmrqP6t1zNAPmR54/L3VSqNf1x34BC7Qq6T6HbKakXMt?=
 =?us-ascii?Q?pQtk3MLhkHmVwcLyJDMdecrfSynRwmV0P6dbubN5OpQbkJVV2Ui5oJzPJH/B?=
 =?us-ascii?Q?zC/LZSpA+SXxoaRlRSR9NGQKqkcLNgJEctXx27jj4vlYc8t50zAlyyBzjwkC?=
 =?us-ascii?Q?PhJBIYPdkv1dWFJevU9rnXNCJkGorQKfbYYd+8BP2c47XtMzDmuJlDZVysXU?=
 =?us-ascii?Q?m8HiaBu3+8KXSIC1zVhymOi/t+62xfXp7A+BYZPnTeZAajFXZ3YaEQFDCD71?=
 =?us-ascii?Q?3KkWmPhACyB+62VITIa5iSRIln2J0VxHjaZ64r3dV73uTJRexoKX5dv4Tw7i?=
 =?us-ascii?Q?hkSqGyrBMpCU1Axht8VA19VNOIQ+fEqV3FbCR+PR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90594c54-b973-49ec-dc51-08dcf49a959d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:13:15.5587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0WOei/7SkDjeDFkDujnVn4HRmNKBhyanh7fHtNgMouEKu1MH4h+LH0uitq6WspIckSXEikuk5xlF3ygJ3Yi/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6216
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_include/linux/mm.h" on:

commit: 0a19e28247d042d639e5a46c3698adeda268a7a2 ("[PATCH] memblock: uniformly initialize all reserved pages to MIGRATE_MOVABLE")
url: https://github.com/intel-lab-lkp/linux/commits/Hua-Su/memblock-uniformly-initialize-all-reserved-pages-to-MIGRATE_MOVABLE/20241021-131358
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20241021051151.4664-1-suhua.tanke@gmail.com/
patch subject: [PATCH] memblock: uniformly initialize all reserved pages to MIGRATE_MOVABLE

in testcase: boot

config: x86_64-randconfig-012-20241023
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------+------------+------------+
|                                          | a8883372ec | 0a19e28247 |
+------------------------------------------+------------+------------+
| boot_successes                           | 18         | 0          |
| boot_failures                            | 0          | 18         |
| kernel_BUG_at_include/linux/mm.h         | 0          | 18         |
| Oops:invalid_opcode:#[##]SMP_PTI         | 0          | 18         |
| RIP:page_zone                            | 0          | 18         |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 18         |
+------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410251024.eb4a89f1-oliver.sang@intel.com


[    0.262363][    T0] ------------[ cut here ]------------
[    0.262921][    T0] kernel BUG at include/linux/mm.h:1637!
[    0.263532][    T0] Oops: invalid opcode: 0000 [#1] SMP PTI
[    0.264140][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G                T  6.12.0-rc3-00235-g0a19e28247d0 #1
[    0.265300][    T0] Tainted: [T]=RANDSTRUCT
[ 0.265762][ T0] RIP: 0010:page_zone (include/linux/mm.h:1858) 
[ 0.266284][ T0] Code: 43 08 89 ee 48 89 df 31 d2 5b 5d 41 5c 41 5d 41 5e e9 f1 08 02 00 48 8b 07 48 ff c0 75 0e 48 c7 c6 27 2e 99 ac e8 42 73 fd ff <0f> 0b 48 8b 07 48 c1 e8 3e 48 69 c0 40 06 00 00 48 05 c0 63 6c ad
All code
========
   0:	43 08 89 ee 48 89 df 	rex.XB or %cl,-0x2076b712(%r9)
   7:	31 d2                	xor    %edx,%edx
   9:	5b                   	pop    %rbx
   a:	5d                   	pop    %rbp
   b:	41 5c                	pop    %r12
   d:	41 5d                	pop    %r13
   f:	41 5e                	pop    %r14
  11:	e9 f1 08 02 00       	jmpq   0x20907
  16:	48 8b 07             	mov    (%rdi),%rax
  19:	48 ff c0             	inc    %rax
  1c:	75 0e                	jne    0x2c
  1e:	48 c7 c6 27 2e 99 ac 	mov    $0xffffffffac992e27,%rsi
  25:	e8 42 73 fd ff       	callq  0xfffffffffffd736c
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	48 8b 07             	mov    (%rdi),%rax
  2f:	48 c1 e8 3e          	shr    $0x3e,%rax
  33:	48 69 c0 40 06 00 00 	imul   $0x640,%rax,%rax
  3a:	48 05 c0 63 6c ad    	add    $0xffffffffad6c63c0,%rax

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	48 8b 07             	mov    (%rdi),%rax
   5:	48 c1 e8 3e          	shr    $0x3e,%rax
   9:	48 69 c0 40 06 00 00 	imul   $0x640,%rax,%rax
  10:	48 05 c0 63 6c ad    	add    $0xffffffffad6c63c0,%rax
[    0.268346][    T0] RSP: 0000:fffffffface03dc0 EFLAGS: 00010046
[    0.268988][    T0] RAX: 0000000000000000 RBX: 0000000000000007 RCX: 0000000000000000
[    0.269844][    T0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    0.270685][    T0] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[    0.271486][    T0] R10: 0000000000000000 R11: 6d75642065676170 R12: 0000000000000001
[    0.272336][    T0] R13: 0000000000159400 R14: fffff7bb05650000 R15: ffff9bfa1ffff178
[    0.273172][    T0] FS:  0000000000000000(0000) GS:ffff9bfcefa00000(0000) knlGS:0000000000000000
[    0.274145][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.274817][    T0] CR2: ffff9bfcfffff000 CR3: 000000015c2b2000 CR4: 00000000000000b0
[    0.275658][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.276502][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.277343][    T0] Call Trace:
[    0.277691][    T0]  <TASK>
[ 0.277992][ T0] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 0.278448][ T0] ? die (arch/x86/kernel/dumpstack.c:449) 
[ 0.278838][ T0] ? do_trap (arch/x86/kernel/traps.c:156 arch/x86/kernel/traps.c:197) 
[ 0.279276][ T0] ? page_zone (include/linux/mm.h:1858) 
[ 0.279720][ T0] ? page_zone (include/linux/mm.h:1858) 
[ 0.280170][ T0] ? do_error_trap (arch/x86/kernel/traps.c:218) 
[ 0.280648][ T0] ? page_zone (include/linux/mm.h:1858) 
[ 0.281095][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:316) 
[ 0.281597][ T0] ? page_zone (include/linux/mm.h:1858) 
[ 0.282041][ T0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 0.282582][ T0] ? page_zone (include/linux/mm.h:1858) 
[ 0.283027][ T0] set_pfnblock_flags_mask (mm/page_alloc.c:408) 
[ 0.283583][ T0] reserve_bootmem_region (mm/mm_init.c:729 mm/mm_init.c:765) 
[ 0.284142][ T0] free_low_memory_core_early (mm/memblock.c:2192 mm/memblock.c:2205) 
[ 0.284736][ T0] ? swiotlb_init_io_tlb_pool+0x86/0x133 
[ 0.285419][ T0] memblock_free_all (mm/memblock.c:2252) 
[ 0.285925][ T0] mem_init (arch/x86/mm/init_64.c:1360) 
[ 0.286332][ T0] mm_core_init (mm/mm_init.c:2658) 
[ 0.286790][ T0] start_kernel (init/main.c:965) 
[ 0.287272][ T0] x86_64_start_reservations (arch/x86/kernel/head64.c:381) 
[ 0.287850][ T0] x86_64_start_kernel (arch/x86/kernel/ebda.c:57) 
[ 0.288377][ T0] common_startup_64 (arch/x86/kernel/head_64.S:414) 
[    0.288899][    T0]  </TASK>
[    0.289213][    T0] Modules linked in:
[    0.289626][    T0] ---[ end trace 0000000000000000 ]---
[ 0.290175][ T0] RIP: 0010:page_zone (include/linux/mm.h:1858) 
[ 0.290680][ T0] Code: 43 08 89 ee 48 89 df 31 d2 5b 5d 41 5c 41 5d 41 5e e9 f1 08 02 00 48 8b 07 48 ff c0 75 0e 48 c7 c6 27 2e 99 ac e8 42 73 fd ff <0f> 0b 48 8b 07 48 c1 e8 3e 48 69 c0 40 06 00 00 48 05 c0 63 6c ad
All code
========
   0:	43 08 89 ee 48 89 df 	rex.XB or %cl,-0x2076b712(%r9)
   7:	31 d2                	xor    %edx,%edx
   9:	5b                   	pop    %rbx
   a:	5d                   	pop    %rbp
   b:	41 5c                	pop    %r12
   d:	41 5d                	pop    %r13
   f:	41 5e                	pop    %r14
  11:	e9 f1 08 02 00       	jmpq   0x20907
  16:	48 8b 07             	mov    (%rdi),%rax
  19:	48 ff c0             	inc    %rax
  1c:	75 0e                	jne    0x2c
  1e:	48 c7 c6 27 2e 99 ac 	mov    $0xffffffffac992e27,%rsi
  25:	e8 42 73 fd ff       	callq  0xfffffffffffd736c
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	48 8b 07             	mov    (%rdi),%rax
  2f:	48 c1 e8 3e          	shr    $0x3e,%rax
  33:	48 69 c0 40 06 00 00 	imul   $0x640,%rax,%rax
  3a:	48 05 c0 63 6c ad    	add    $0xffffffffad6c63c0,%rax

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	48 8b 07             	mov    (%rdi),%rax
   5:	48 c1 e8 3e          	shr    $0x3e,%rax
   9:	48 69 c0 40 06 00 00 	imul   $0x640,%rax,%rax
  10:	48 05 c0 63 6c ad    	add    $0xffffffffad6c63c0,%rax


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241025/202410251024.eb4a89f1-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


