Return-Path: <linux-kernel+bounces-252544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B2D9314F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6362A1F22C89
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0C918C345;
	Mon, 15 Jul 2024 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xx946m2/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9748D18C330
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721047914; cv=fail; b=dyPCtE9X3Ak096v6c5WBeaWFxnb50HG9PZc53hS5BlQtWo/LgydRO4vfiBw8HJyHwicE83jL/htCrsLnZ1ibf1XRIVnS83rXQJ0f1ZztLAXzqqSqwFKNcOwYJCw9M10VkjxSghfRpY9a2eps9rMyrueynQHG4YHhAgBoQQYrSWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721047914; c=relaxed/simple;
	bh=7jmxS0mEfALQWA0BBSHJD0cnpxxDFAtnMd/thnt/DYU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=coNs7vrExM2yV2zHb8Oaut373669cq22X5+zcSWDupK5lXS3Z4rFXS+AViAHStLMyIqIwxA01+DCRC0uCDwmJOYKXRGqTjS+5y9H8QhWKBPNSC7zq/AyR5dcLxWKRr7wl+26gSPe84XsypgzY7a5odQ0JjhNGx3b8z7C9TFFPqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xx946m2/; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721047912; x=1752583912;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7jmxS0mEfALQWA0BBSHJD0cnpxxDFAtnMd/thnt/DYU=;
  b=Xx946m2/RzLhXPR8JxCD8zONonyoBNpul/HaJG5tzzRjYKqgUo4AqWbm
   IhCidbwvBVYIWYlZec82tlj/diLWMRSAwZpbAjeR2b6m6fCdaSScOZ3+m
   Gs56xLSmqSFLKkc9By9NAbmhVW4V5r2svhvmgXPqQCHU09FOgyHlfeQTG
   DHgiQ1SW79oQG1eYebBue8G5GIcTQy3zVDja1l+3gVUySHYWZLoXu+75x
   gPHIBeSv7i0sHdpJMwVG8HTpwtwN0qQLJ/iDoqpVBinRQK3cB0jxtxiub
   QIWGAZ9gr5ZYCQsuEwOJiu6RKmUGHRA1oWL5S0/4nm4GLttP+u/ejwEAG
   w==;
X-CSE-ConnectionGUID: xHauRADBSkOzp+dSvBFZUw==
X-CSE-MsgGUID: T5nA/OAnS7Wf/V1zAIJpvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="40950633"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="40950633"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 05:51:52 -0700
X-CSE-ConnectionGUID: CZAAGhavQbqMLCseSJvJHw==
X-CSE-MsgGUID: ycF7xso0SK+N3WNtgWfw4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="54147970"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 05:51:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 05:51:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 05:51:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 05:51:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 05:51:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCwXeQMn0Utz74tFF/v5lnc9E4uL8Bw7EAoNtbFX4AOS80tFVNjzk0KqPLUnF9RRv1pcADJcXdGg1N22UFcoo/ufpfdJv10ycJS/h0zTxJ72sgyDoxtgFk+zDZ8+XVLwIlupsIUlIYoXIGnofWqRuH0btUcZo1gy6/1zEpljnq9V/tBH+DzoYNZNPHeQDiI+gbLLMBjk8C7uMisQBuFwvPbarShqa1Ej+THqeBLzXVU8xTDMSWvWVcmWq9sbyKShrqKuRI9gpNhdjc3Jq1+rmvEOZLwBTooM3ZWevXdFiVEFoSs8a0F0hZXsvnwXFzawLZnweIBYPaFXD6yri6hBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aOKgbVL7M3GhQME9tjwZpVoeeupNOHkut9lKbtSJkI=;
 b=sbUBIENKVeUkLnzWxdqZ95F4AXbg8goKfTs8s9sQ+7DbxNTNe1XETxkx9QDrfhyFn9xG/SK6CGXghIDGCmd1Yqsi2gEvf6vvP65u44/oK2mIzPABgn/0/LtNMtjxuvFgypYZtjtiqOYjfgwv40hO6Y90rVKFGCCb1waiKYOwdewDJvPa3bZNexl8sBSrQT9s3Eeg+RPwMhgtpB3qE+w0dkRyt/DDCCW9RbnjRP4pUi7qkUarZHlofOi/AMEKdbYZP6DnSMaJy62BFnsTyAdAg2jx3qyYAy0wzxg+KOzBVqXRUgR4bJW+hYGWi2PUH8OTJS4C6+/hMPLGkgE5fDyR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH8PR11MB6659.namprd11.prod.outlook.com (2603:10b6:510:1c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 12:51:46 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 12:51:46 +0000
Date: Mon, 15 Jul 2024 20:51:32 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Mel Gorman
	<mgorman@techsingularity.net>
CC: Raghavendra K T <raghavendra.kt@amd.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Chen Yu <yu.chen.surf@gmail.com>, Tim Chen
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>, Xiaoping Zhou
	<xiaoping.zhou@intel.com>
Subject: Re: [PATCH] sched/numa: scan the vma if it has not been scanned for
 a while
Message-ID: <ZpUbVK/xgsrGuXUP@chenyu5-mobl2>
References: <20240630150032.533210-1-yujie.liu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240630150032.533210-1-yujie.liu@intel.com>
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH8PR11MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 9083c42d-bd5b-4c8a-bd44-08dca4cce2d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zQAt7k/fYKYgqlcDpqAkx2qdhxSi8lKTQtLAR66W+fJxxr6JshKrzEXeaf+H?=
 =?us-ascii?Q?u3XxrzbSOEjBO2VsuFztpr/xIsuek4tGoGeOKrPpBpCmvP7xk/BUs5TD9yb1?=
 =?us-ascii?Q?d2y7U/H6dISaBlVECpiSYK0Tueb+Nvj4wbz3P1MR65YwaVwMI1EQGknElwn5?=
 =?us-ascii?Q?sZ4NrcB1sAqPerAKilzsqRU7yQ2xHKy7YPbX15hxHMKqhxJd+NV8IN+1oC06?=
 =?us-ascii?Q?OS+KlnEFDak7V05M99ZaXYe/tK01n6qC4m4nitk8d4AsT9EqyHaT9vZJM9BQ?=
 =?us-ascii?Q?7kxz5bgmKqBScri/1CAX7dO6vXSq1U+Ni8eJS2wC8fu2WNfSMwLw7wJ/qbHJ?=
 =?us-ascii?Q?RToZQkRwrIRO+pblFJ+YzEqlPH3H72606i+u8VBiWw08kS67oxEtg788p/OS?=
 =?us-ascii?Q?mTrrWkD/MqfyNHcmzjI+GoEx7BIh8EHHOpyLuNTT3hGm0tAv/++fr4JpL57t?=
 =?us-ascii?Q?Y5C3tzrVMEJuBnlVXI4DzfbAE/clyEPDd3B8RELqsHOjnuYXrWxF9hPNr5JY?=
 =?us-ascii?Q?d9uwQ2x3Xx2U6rjWNsj469NalEpp26Y/NNttbrpPF9+wfBYIUKNWhfKp066o?=
 =?us-ascii?Q?KSCUPQjNy3oPdBpOfCAtZKQoJxh6lCk26EOB8RLjKN/y1i4Vqfm+8dqL1Pur?=
 =?us-ascii?Q?3oTF2uLez2nGeLu4UrtC4BVMt6gEws6IUAc5Dr8MzaOtMAzxVb8j1Qc4iI2x?=
 =?us-ascii?Q?SJDLaPCIUIbI8HdwpcS0xFVVshh8C85Q/32BDttGgOkqxGcz4iKwN7vWaFZg?=
 =?us-ascii?Q?4M/TV5WFmHqqgrY1CNrSv1qS8rIFf/0xNLDbshTh8/8WPulUiDRurOxIRbrn?=
 =?us-ascii?Q?C/bfEIonKbRzlzIShSrLsVz7YUFy2ynbvEI7WWqaczOBL5fYACz4LB2V6jh/?=
 =?us-ascii?Q?h4cSJ85ru1dODt01lNv75xTQy0GerFCbAjNZKEl4ijBOuAR3RJGVfyMjKK4e?=
 =?us-ascii?Q?zSNald2/NKr1/VSgCmxqLfutN8LRyGEtAOpHvR009v04K7tfABG1jHDgdSQ4?=
 =?us-ascii?Q?rNlLIVipa+XM5f/0TbW2HQxelnWtAVCZ2nA69qlpu9dHoYnYVIo/m/Q2+fYD?=
 =?us-ascii?Q?egH2LxR0c+X9G7V7EPFAvGl4c46G363wjBWs7q4FOv4prh2mlFU++wOHGApb?=
 =?us-ascii?Q?eAUdctO/pZd164TPiP0/z0b6ccjE+LPAVaf/yVsdmu/L/dygKt+3Mc6cd61b?=
 =?us-ascii?Q?CEJJF1/WiQUTa2+L/8lOLYEiISIcEQEOGZh3EpsZBgpWeCF69Rk93pt7kf88?=
 =?us-ascii?Q?BmxILMzOVSm6NM9GSmxDWR+T2cBj65EU2mS2B7Z8b8PiNWpE0Rs9UeN6LFU9?=
 =?us-ascii?Q?zKg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OGi0rAEEs37B6UcXvE9nqz1nQRJc3qdNyYt7VOmDFhLe10ZkBbF/vZ1Ts3Dk?=
 =?us-ascii?Q?5bCER1+pJQwd/Fap1Ik0TtXxqNIBp3F2qYjn+sPHyhG2dqQsbRYNs3LvB0gh?=
 =?us-ascii?Q?sLoCqwTyGKsTcT21OLVy+8nm57KU1+o5AfMbRD4mBxSLPTuM8zPvvEQpO9jM?=
 =?us-ascii?Q?9O3+6YmekQvs9PeFOuHzN8AkqMkNXR9f06cpbZPxp1H3F4wiLxkuvuMIx7a9?=
 =?us-ascii?Q?cl90lm9MBhsDdRjMRjCqDPTt9STKvUTjAmZ/hwoDoRG5USBU3XYF0xiFbVaW?=
 =?us-ascii?Q?xGb0ru6cY78Rqaw5Vvv6EDlMLNiX4MJ4a2nHIfhqU1qjcBMWfk7/PgmVPkCJ?=
 =?us-ascii?Q?DA5ZGvvqfch5zcTs8Sjgj2l5XV/upjVEq+gqbSNOCDBUj11iKAeT2wja56P6?=
 =?us-ascii?Q?xpqYSH4kYKFCSZK5HS2tYrlERHXA6BsQejVwVlspdpg/GSkol49cuYsBnz+f?=
 =?us-ascii?Q?eD/sHV3jJKGueftJohh9bN5VQ5y2HEruAJFG9jmOfGy3mElwOPClu4SLtwzS?=
 =?us-ascii?Q?GP5hmkE2S5wx3UWBV0Mh0VdXSqRNmVkE7qNRYii1VHxTXAdAUI6os/q1LLJv?=
 =?us-ascii?Q?9l1vDNKT95tkxErHxLPIk48vjc/qErKJfsq2l0JY7YgXy3rGlau/+IsqX4BX?=
 =?us-ascii?Q?D2MYRWZHIvgWa9+rrxAwvJaiJnwYPg1/aQ3Fy7teNKiIFfTWXc5B/0HAI9nd?=
 =?us-ascii?Q?wwdRUi1+5KY3l1WtaPINk9SjvASVz1djJ/n066pC61w9obNu+Rqnhyop5UfW?=
 =?us-ascii?Q?qxQBfYMfJX8itljv8xfrJMRX73NOmiHNJw6G5AhaQfetkJlTp89eXSKErMDH?=
 =?us-ascii?Q?+Mou9mCa6sWo2XeVJ/1Gzm7F3c5hrsluz3/9yQtwLzetFsz562Lv83M8BCXB?=
 =?us-ascii?Q?ViWhf5hycxbYQFtg9MOAA9JlJGtQ/EqvXUrCxmdIcH5C7u4wtjMF4RaeYRSJ?=
 =?us-ascii?Q?2qkMyc6ahjq+hvI0BE/sx9zML1+aC+fb9yQ8EOdteU34to51oY/2c+CLLaL9?=
 =?us-ascii?Q?DTkI1oOE7llJZfklwrBI69+AGd7f3P11FgHYfyaLdA3fj74Pd5nVqD7hY1CL?=
 =?us-ascii?Q?X0YEv4UrnUJUbYiqixicXUUWhbwlcawmApvC1TZ4I1RN/iiSQmTSW1G6CGDU?=
 =?us-ascii?Q?NfwOT2S51jYNLbAFl9UpPX767tM62mt4I7bcZOpRxXLvkNuDNRxtXN1QrUp6?=
 =?us-ascii?Q?qYXDYCVdqtzn37RUNx+km4aWvEcAnJQzbrKJD4sa2EtTtexEudPStdu4xjIZ?=
 =?us-ascii?Q?Z+pfsTeh0aPujloCYoqh2aP/Qy1RuZrb6egpRnGcQakj8Y09fYDQi69KS52s?=
 =?us-ascii?Q?nQmQyxzjuH1Krp6JZTAdgiWigjfWFT7KRoIdQsEqCuZymLxhnTB7zk9eN0DT?=
 =?us-ascii?Q?F+xKcV96kreP8bUCq+PA7LsodO/66F+ciHtQUZS7kdxlwldDU3H8yWGOkHGE?=
 =?us-ascii?Q?sNZn4zfD/bvcPR6xSiTXs+1Sc0XzES76y5DZN0nOmCVjREkhiM4/ughxJ6A6?=
 =?us-ascii?Q?+vT45Wdsn+CL/2kx2EZvVj8Klj+K6oF5kXSv7/IWnjOYiQ/bTAzMdA/ZxtLb?=
 =?us-ascii?Q?x6F1XAjbqnKZGNPA/sOI+TxI3+UdSQgdykMrq2+H?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9083c42d-bd5b-4c8a-bd44-08dca4cce2d3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 12:51:46.6757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKluvp+Jx5tTEhlWfPJ6CY/DQ2d/hOUtFQcwSJlp4aZoGSMQqnSUDljx72moRt6SFeBxiqUE2LH9SW46YuVwWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6659
X-OriginatorOrg: intel.com

On 2024-06-30 at 23:00:32 +0800, Yujie Liu wrote:
> Problem statement:
> Since commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic"), the
> Numa vma scan overhead has been reduced a lot. Meanwhile, it could be
> a double-sword that, the reducing of the vma scan might create less Numa
> page fault information. The insufficient information makes it harder for
> the Numa balancer to make decision. Later,
> commit b7a5b537c55c08 ("sched/numa: Complete scanning of partial VMAs
> regardless of PID activity") and commit 84db47ca7146d7 ("sched/numa: Fix
> mm numa_scan_seq based unconditional scan") are found to bring back part
> of the performance.
> 
> Recently when running SPECcpu omnetpp_r on a 320 CPUs/2 Sockets system,
> a long duration of remote Numa node read was observed by PMU events:
> A few cores having ~500MB/s remote memory access for ~20 seconds.
> It causes high core-to-core variance and performance penalty. After the
> investigation, it is found that many vmas are skipped due to the active
> PID check. According to the trace events, in most cases, vma_is_accessed()
> returns false because the history access info stored in pids_active
> array has been cleared.
> 
> Proposal:
> The main idea is to adjust vma_is_accessed() to let it return true easier.
> 
> solution 1 is to extend the pids_active[] from 2 to N, which was proposed
> by Raghavendra[1]. And it is under investigation how to choose the N.
> 
> solution 2 is to compare the diff between mm->numa_scan_seq and
> vma->numab_state->prev_scan_seq. If the diff has exceeded the threshold,
> scan the vma.
> 
> solution 2 can be used to especially help the cases where there are
> limited number of shared VMAs, the process-based SPECcpu eg. Without
> solution 2, it is possible that, if the single process access the vma
> at the beginning, then sleeps for a long time(the pid_active array
> been cleared), when this process is woken up, it will never get a
> chance to set prot_none anymore. Because only the first 2 times of
> access is regarded as accessed:
> (current->mm->numa_scan_seq) - vma->numab_state->start_scan_seq) < 2
> and no other threads within the task can help set the prot_none.
> 
> Raghavendra helped test current patch and got the positive result
> on AMD platform:
> 
> autonumabench NUMA01
>                             base                  patched
> Amean     syst-NUMA01      194.05 (   0.00%)      165.11 *  14.92%*
> Amean     elsp-NUMA01      324.86 (   0.00%)      315.58 *   2.86%*
> 
> Duration User      380345.36   368252.04
> Duration System      1358.89     1156.23
> Duration Elapsed     2277.45     2213.25
> 
> autonumabench NUMA02
> 
> Amean     syst-NUMA02        1.12 (   0.00%)        1.09 *   2.93%*
> Amean     elsp-NUMA02        3.50 (   0.00%)        3.56 *  -1.84%*
> 
> Duration User        1513.23     1575.48
> Duration System         8.33        8.13
> Duration Elapsed       28.59       29.71
> 
> kernbench
> 
> Amean     user-256    22935.42 (   0.00%)    22535.19 *   1.75%*
> Amean     syst-256     7284.16 (   0.00%)     7608.72 *  -4.46%*
> Amean     elsp-256      159.01 (   0.00%)      158.17 *   0.53%*
> 
> Duration User       68816.41    67615.74
> Duration System     21873.94    22848.08
> Duration Elapsed      506.66      504.55
> 
> 
> Intel 256 CPUs/2 Sockets:
> autonuma benchmark also shows some improvements:
> 
>                                                v6.10-rc5              v6.10-rc5
>                                                                          +patch
> Amean     syst-NUMA01                  245.85 (   0.00%)      230.84 *   6.11%*
> Amean     syst-NUMA01_THREADLOCAL      205.27 (   0.00%)      191.86 *   6.53%*
> Amean     syst-NUMA02                   18.57 (   0.00%)       18.09 *   2.58%*
> Amean     syst-NUMA02_SMT                2.63 (   0.00%)        2.54 *   3.47%*
> Amean     elsp-NUMA01                  517.17 (   0.00%)      526.34 *  -1.77%*
> Amean     elsp-NUMA01_THREADLOCAL       99.92 (   0.00%)      100.59 *  -0.67%*
> Amean     elsp-NUMA02                   15.81 (   0.00%)       15.72 *   0.59%*
> Amean     elsp-NUMA02_SMT               13.23 (   0.00%)       12.89 *   2.53%*
> 
>                    v6.10-rc5   v6.10-rc5
>                                   +patch
> Duration User     1064010.16  1075416.23
> Duration System      3307.64     3104.66
> Duration Elapsed     4537.54     4604.73
> 
> Link: https://lore.kernel.org/lkml/88d16815ef4cc2b6c08b4bb713b25421b5589bc7.1710829750.git.raghavendra.kt@amd.com/ #1
> Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
> Co-developed-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> Reviewed-and-Tested-by: Raghavendra K T <raghavendra.kt@amd.com>
> ---

Hi Peter, Mel,

May I know if this patch is in the right direction? It fixes
a SPECcpu performance regression found recently.

thanks,
Chenyu

