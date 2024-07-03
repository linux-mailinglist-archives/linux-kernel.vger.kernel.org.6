Return-Path: <linux-kernel+bounces-240217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3DE926A56
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6351C226FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2B0191F8A;
	Wed,  3 Jul 2024 21:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfAR0GDS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A061891B6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042450; cv=fail; b=hgwirlyRclJeppBMIgF5hRghBT9o1TmzCIp4t/Xikg6LvJBwdCT637RWeZlbbczVkJicqbu3HK3S6Xa2quEyBCfeFdJ2JLIUi91f0RLjw9CjFQB3JwR1aYJ8j3dAz3EIsE7kcrve6wGSOmfb3zF8oqgD3HYRt9x7nMrpwScsDHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042450; c=relaxed/simple;
	bh=t8VsE5wlYJ9gRU8LaNj+aZo0cbxfUIpW4cAtlbDVkKs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FQmuRnnaJNyhGb2Y2KIUKJI4KgV68ca/FYTkIw+x9F550OtqxkRTOOmh+KvBmVk8PCV586al+TBSk8vyNTdOZnjG3ORKu6XfOjrT5eupuPRtNJViYwTOgfgI1w8Aqq+07cC6g0e/6ayzXa6bevM7/mDBnDS1ddsPW+jaYDApFOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfAR0GDS; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720042448; x=1751578448;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t8VsE5wlYJ9gRU8LaNj+aZo0cbxfUIpW4cAtlbDVkKs=;
  b=bfAR0GDSvdbM70JiRRrY4jyKi0MNgE9AtGn+t8Blm22VsA57AqwSSFhf
   3oS7+hcPfphei9ll+7jJmRTOIiWJ+oS6BeQxMpZy3uwmHJWeEcPZqzucn
   ZY7EZfCvRlhefmzm14UbFHVa8Jn/lgm8kPwSkD0Se6SrX0QF7atxAlxcq
   WBGrCtYN2cZ8nP9nrV+9+f39Wcg/D4jkPF0lkREH+DxMNFhEOD23tVqqN
   Di+DZARydVY6QfCxViRgoDBYqs+dTfd9sevCqBY1rL7o7YZPTqG1+Qm7l
   VsUCJ8aPrgAwI7fkOlnk3D6iAgExXYD1DGguq9qJrob6rAoXtIgwIBtJP
   g==;
X-CSE-ConnectionGUID: gvr/sAthRraN9BgcuNR8gQ==
X-CSE-MsgGUID: wzEAXfzXS4eUAsk5rDunmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17166653"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17166653"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 14:34:07 -0700
X-CSE-ConnectionGUID: K4yQHAf2Q5WeFonmfdShVQ==
X-CSE-MsgGUID: 8aFrV8fsSCGF8Y/S2vwGuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46328596"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 14:34:07 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 14:34:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 14:34:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 14:34:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij7OjZxhvcSq4biSwL9KPJvSTdetrIknmQr2JGlxeDal2alsaHx+2ZH+Wpg0e9RSUpo/fMtPjTdyD/hrGcsQLpoOCvX0S8igjftEUOc3CIfQyENNyAeFKlJJnO0tRPvZzkG7OXTpEh9DHd9QW0xSclUdaY8NNvTniF3jiFAN6YP19Jl08s1qwMjYHKuvCku6DB9y/D5ZqTe7vqN6Wl2vN1y4/sA4O2Vb8mTMYbv9FOXxj++mvDKtg5ebEgZXNrCl4H+hsVvWsLreiT9smbIBtdoyWYN7Nqz43oACGQC20u+I9X1jY0FcLHO2Egp1yjoPwN080GvRNHKJR74lQyHqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SJ3z49ynCiEXrlm3eaLyGsGs0yZTPPojYsdFES7Ztk=;
 b=a0o2lvR/+3LLwv+pm2Ux6fdwo5sOdFYAX6vL4jggtgfkE4q5/ryHnTeCjYiysq3GOdJRBYEtIA/slpFwDeQGPJBSKhZ4pQBODgJVnp0LJoU/pn+l/CD6Dceoh7lKKWhv5x+wVENe6/FDxm2pV4vZZx52FwZyzh7vEIkw4Tbs/2mvPo8EocRFHTCX8ReE2o4o1ZVzFTXmUv2clthCHYDqPW6++uF0Ous1Yd0gXyDkitp6LYk0vzXE0sZQcRdK1zv3mLKcUk8hBw0Zn0nRgCaYdGfw8f8fnt6RsNYk+Gi/ohfE4S0esKXdAGCAt3NmNrSEp5YNdZF+ECXEWD8GkWbcLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10)
 by CY8PR11MB7847.namprd11.prod.outlook.com (2603:10b6:930:7c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 21:34:04 +0000
Received: from DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::19d3:28f4:c53f:8431]) by DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::19d3:28f4:c53f:8431%4]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 21:34:04 +0000
Date: Wed, 3 Jul 2024 14:33:58 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: "Chang S. Bae" <chang.seok.bae@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <tony.luck@intel.com>, Yan Hua Wu
	<yanhua1.wu@intel.com>, William Xie <william.xie@intel.com>, Ashok Raj
	<ashok.raj@intel.com>
Subject: Re: [PATCH 1/1] arch/x86/microcode/intel: Remove unnecessary cache
 writeback and invalidation
Message-ID: <ZoXDxldNlTYRo-0h@a4bf019067fa.jf.intel.com>
References: <20240701212012.21499-1-chang.seok.bae@intel.com>
 <20240701212012.21499-2-chang.seok.bae@intel.com>
 <0aa05063-c9ed-465d-a7d2-e5fa0bc6379a@intel.com>
 <ZoWZG75hFpfK6kkv@a4bf019067fa.jf.intel.com>
 <6332f158-005b-4c3c-8709-350dbee23f7a@intel.com>
 <ZoW8kYwp2GeM64oy@a4bf019067fa.jf.intel.com>
 <bd0b19e8-ff72-4a6b-9f7f-400ddafddacd@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bd0b19e8-ff72-4a6b-9f7f-400ddafddacd@intel.com>
X-ClientProxiedBy: BYAPR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::23) To DM4PR11MB5262.namprd11.prod.outlook.com
 (2603:10b6:5:389::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5262:EE_|CY8PR11MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b72ffe-31c7-4823-be0f-08dc9ba7dca6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jiG+aYEBgHkqQvtROQjjrSWptGz4z9Yo6RFd2t44tlWe+L/wOpv/iJPMu3gG?=
 =?us-ascii?Q?BINdQAbmLh/nCDRruNu9A18HV8jOMFYn7asXmvi45xeKWjdDXuUz2qVZfj5Z?=
 =?us-ascii?Q?fCDNcisO4GGs5S3Hf97OoV13CrQP/JESsyL37A13gDpQ1x3+cvT2GeqtHmC1?=
 =?us-ascii?Q?Q49MoP43le51f3fl4dMdFENwDF4OrISVTJDpp8InHC8/qiNnW0y0SUSlkHhe?=
 =?us-ascii?Q?0lY57XwJxaZ7rHtxv2/REuf03xeEqrs5lcmrp2isMwv88p9aWjesyKw+AIfh?=
 =?us-ascii?Q?qcMziAPkHkxNaV0gvzEuPRv4De2lCkx0jElfIxMwT2sa/2i0IuRs666McyoR?=
 =?us-ascii?Q?sxo1ik7QrHJd5s79aKmRbJy78Y8WWp6u7jCIz14DKa05eTq8Xlezdtim0LCw?=
 =?us-ascii?Q?k+46mVEasws4yyKrCCkiAGKBZ439DuWLRkDD6J2lKeq3IAtuaLlPx4oHlKEV?=
 =?us-ascii?Q?tSpWk3zhhGjgwu6LIn4EfildnaHm8Ki+kD1N9PdWHIYSGTCWtWIEB6hy9K8a?=
 =?us-ascii?Q?4hlOme5eTj6EbJ0qBUM5Bp7nT05g8GMA0hJ43h7SJytDY1rkquA82JJNKjKV?=
 =?us-ascii?Q?jWJYBKFI04nhnGNCPSxHEaSKLCLDUpqQzaYGsysQgXOze1FT8R8UZ4tm7hyS?=
 =?us-ascii?Q?chJDuWuiUnJ4rvkdSKm2gM7QdxWjf/KgUj/zTbPffpXdbRUGNI5B9wgBDHKH?=
 =?us-ascii?Q?KKziTaH1jfeCTeFDoQs8ZwrQMQHNNSfvnl0HGa12leLLH0hfCPkgPtn6fNiG?=
 =?us-ascii?Q?lI003Bwja2Ci59SNXD4BE/0xTS6mM6aqDovfz4+4tIA+Wd79snHVjmSwlEPc?=
 =?us-ascii?Q?8GksFnfHLIhPtaNP/8XvUMPjykDHuU0BUQoTj/x1nZ3fobINGXDC2Vot7JR4?=
 =?us-ascii?Q?1mSKMp25XKGWFfHG0gVFYti4zoTWxk721URHtjSOv10Qtihu9DyTrht8LKuM?=
 =?us-ascii?Q?WOUuyT7hLrECuEipQaVjXyxZ40A78fI1Vzq2bJlmCrjufUBW+dr5avBRFz7r?=
 =?us-ascii?Q?tcsnmAPeRsyz9lMxdjylghTChiKzu1G3qAqtKUm9PhyPvg3JVij/bA9v17rY?=
 =?us-ascii?Q?0+yKP3J3MVhSdM7Whc29av+DOSC8BSapnpvVIk/suen6mIDjGP5aAm3J0sqe?=
 =?us-ascii?Q?MnaRm/JLmLLtI/xmjDo2G0GLOPCNVAlxHQmpM/s9q0eIDelBr85h1J42Pzt9?=
 =?us-ascii?Q?EKuGh6HWmFZ6Hr9wV6evhD+Myddn36ubQOmKN+wYoA4RDLrFcgy/QCMEJeDJ?=
 =?us-ascii?Q?+H9a/gdYgIDY/84fhC0y0d47likD2n51B4x5vCVxNglOG3YiM+JGQ8RG4c0/?=
 =?us-ascii?Q?+v7KiZ4DcNUUDKb5jf3bXcwT98vfgaWfr5A8J930cVppBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5262.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GX9s0fBDg6C79pA7SliR588DDmUuqZ3qhYp/vl8U5XvQq/6Pf8U35q8n+qod?=
 =?us-ascii?Q?o5fQumMjgXtfh6L40u435QUoGTVA40zukLGoJL/CBDhATpQDjL+GDgNitdT2?=
 =?us-ascii?Q?iJDMAz/YgOfnICPtm5SOOzLEAffGXhK0CauLjzkNzFC+6ebc/JDm6ZZTTSYp?=
 =?us-ascii?Q?8Nhioo4ENEqFGPgyOEPy9NYDtI5T2OVQLTbd3+pn7bTl5LLBmivNn0FnlL44?=
 =?us-ascii?Q?muMBZYGK5losPSawh/sFAtPmAEQPz0T54Qc1dBriBInTT3s+S+CED2pW8p2C?=
 =?us-ascii?Q?lanS1CL6TTV/iHaQXYwvDtqcv4EWE/CaCQ86jN6Ur5VqCXBpCwG77BPEdhmW?=
 =?us-ascii?Q?dz70S4qYPSrKx6UvkSnyYtfGskJqr+fztDt+4dkwruJ9/9EYuofJnSEfBXyX?=
 =?us-ascii?Q?8lWzMFOJgL158FjdqRMHUXbG/viYEOtJ7HiO3dNnyywbOtCGzEY4OOdDXHME?=
 =?us-ascii?Q?e6Eof1pFY9HRixF3/8KIExPTon3X2D3g+yx/QxRodC5fjc9r2ti2fpnN4lv0?=
 =?us-ascii?Q?O+LmIY4qiRW18CTky4q4uL7E9L63sfceA7f8m9R86cnROl5ydIhn6Ab8Hsr3?=
 =?us-ascii?Q?UvP3dyzBDB1RY8kdY7uwcdH1TnOeGxJfUHdXvKN3Ugbv8pWgJ14YWKyingdv?=
 =?us-ascii?Q?eKwGGZWPrhHW7kfLIk5Wf0+THpTIxrZ+m9pHqDmsyFD68jVclGHNzpY3DCXy?=
 =?us-ascii?Q?kOhNkDjEqsEwmJtzdGw29KQvaPtyXU9m7bDwmIOl9rdft+iv1IUVCOBDtGSj?=
 =?us-ascii?Q?X2ckOqRKWxlzgX1srjhpMHX6PDk6gGk3KqvZiTuBn0l+n6cLvtyfG+VOQlqB?=
 =?us-ascii?Q?UQw/cbCw/rKiF4e9tnlu0lsyn9+bZdFHcptNU+goK7h8h2eDKeliWH65mlHO?=
 =?us-ascii?Q?jcycEqwKe5PrDyAVCNw9ISEF097z3DxtjnDgAEduDqIreZG/yH3rfJpaGx4k?=
 =?us-ascii?Q?XeXym307q+Jz0k9i+ALGE2sgzPj+mLGLYbFPFcwOyAiIkbVkf0rgNKmZBeVc?=
 =?us-ascii?Q?mGjqhGf32PTMlqTGVpvLq8F4hoGMo1f7krr2L973nqPsDaRw7mC8xf1leBgU?=
 =?us-ascii?Q?/JWPbJQsUyzooNX2J2zFh81fHQjUvvqX4HQILBY4p/7OzUg6LH48hD+UlQUm?=
 =?us-ascii?Q?4610y/ef3di52kw18vJCClIRsXTs8TWrB7NFD1igJVhTqhtuqC+N7l5fTvYs?=
 =?us-ascii?Q?FzfePZ5fI8IpfNJurcqVZC4IDsBVjc+GI0tGpgBFvein71oO0+chATBo94zN?=
 =?us-ascii?Q?T7kIdThmpyvG28ut9kZiEzky2khtxA0pXuJ+vRGugWbFCSB+0UgvFbvUS1P4?=
 =?us-ascii?Q?A+3FgIs3uGe2a5Ui0dZcj4ugiOV1KFgyrj2Jk18PDXfoSAISB4EIldy6ahzv?=
 =?us-ascii?Q?JMzXEtkhpFXxYiKAMYfbC/dJ7iIFg2ezH2Q6BcdRSRn0bycUzxd4s3C8CPQC?=
 =?us-ascii?Q?K2Y7QFXn/Y4Oj5hkiLrMO63N9OGtrtH24zhXQ4tyccaXPyDlTFUk8NtKspwD?=
 =?us-ascii?Q?N7BTOvytL2WSFY3wKwV0L643cSKTiAUodgpfwR2RIb4rk5AGqKoOmSeFRBGm?=
 =?us-ascii?Q?7cZYj54p2X/qXFYDSkiuBsq7ijw3NRR2zUL3Wg2X?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b72ffe-31c7-4823-be0f-08dc9ba7dca6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5262.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:34:04.4351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHs9RU1JKMbwtMWWnBalaJHL5350zQ1JhpmuH8VkN9Rw2ogCNFsdV3IGn4QMWxWL32FkvaVjQKgSAYUYjzb1Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7847
X-OriginatorOrg: intel.com

On Wed, Jul 03, 2024 at 02:11:34PM -0700, Dave Hansen wrote:
> On 7/3/24 14:03, Ashok Raj wrote:
> > On Wed, Jul 03, 2024 at 01:55:19PM -0700, Dave Hansen wrote:
> >> On 7/3/24 13:50, Ashok Raj wrote:
> >>> Agree that we must get wider testing. Only caveat is that you should find a
> >>> newer microcode to apply, which might be difficult for all products. Unless
> >>> there is a debug option to reload force the same rev in case you don't have
> >>> a newer ucode to test. Its good to get this in to reduce the big hammer
> >>> effect.
> >>
> >> Why is it hard to find a newer microcode to apply?  Just because the
> >> BIOS-provided one is more likely to be the last update the other the CPU?
> > 
> > Yes, sometimes that, or an earlier update has already been applied via
> > early loading (which seems most of the case). Someone needs to do some
> > extra work to remove it from initramfs copy, reboot and redo the test.
> 
> This patch touches __apply_microcode(), which looks like it's used in
> both early and late loading.

In the old days we had a separate function for early and separate for late
loading. tglx consolidated them, so they all look pretty now. 

When wbinvd() was introduced I do believe we added to both early and late.
Although I don't recall entirely.

> 
> But it sounds like you're thinking that the WBINVD is (or was) primarily
> useful during late loading.  Why is that?
> 
> Or am I totally misreading the code again? :)

-- 
Cheers,
Ashok

