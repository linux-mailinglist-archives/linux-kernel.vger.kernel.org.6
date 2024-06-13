Return-Path: <linux-kernel+bounces-213307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 040FA907393
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEF01C23E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC6D143895;
	Thu, 13 Jun 2024 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ci/MJ8ce"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6761448EA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285005; cv=fail; b=VcimXlSwksCkt/HWElSPh7YZcOK4zhHu/cPyjJHXy/yNUvoWiR1LYFPy1KlaFhn6Kxw24STxFo81nCVGPU9B8gCCvAw4BfscqO1XE3CfQisCmFh8DEoosco13bE60oWTVemJVXAdG/rayGfemNd6CLpwkD1LMcf76ElY2ghGwkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285005; c=relaxed/simple;
	bh=nfaLJOzT/iF4Om7h7ZW8BN5XZvYA5lWU4eBQ8BocybU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G7dqkEiWnRjq7oHaenOz0RhfpVyO8Sgsy+2Mn21c55sDcpLjEYJTznq560kWPUHsAL65QI29fsGgFv9BqLCWgF0VxZNtBaqhSrkzdEozunNBAxhWAs+cDMznC0IVNoRnmsELT3EMioA+17UXZ9iffflnBRZCCRD/nJGJZTyQ7VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ci/MJ8ce; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718285004; x=1749821004;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nfaLJOzT/iF4Om7h7ZW8BN5XZvYA5lWU4eBQ8BocybU=;
  b=ci/MJ8ceYHi/uEFaH0JqdKN2B2Vn3e54+GhMHrkXP7Ey5x/wsOsZwYEx
   4IDe9sDwaqNqbpbUKDL5KLEpzZ/9DrYbrbzwgC/fhgPzROG/f5IVo7evd
   XhV8mb4tlAX3+bNQ5g6PcboF5xZhs8tulN9HFZ3XKRN+66eR0xaV8IxAc
   /qJLUEHbn0Z1Z7cMAgaw/JZAjRHcWfJv8CEJmThDTIshpdYSSHRiUih+z
   fGgMRxpQbAwe8xbt7RgAz8aC8ezl898EUsuSKq08LbKRJPA6RLyYHO/FH
   rLrALoPC0mi5V3S7UlWGLZhAU7SxKPBUb5F0Nfn9ui0Ch30DpYo1mRBKF
   Q==;
X-CSE-ConnectionGUID: 0Mq2FlPxSEuN/cDaQXZmqg==
X-CSE-MsgGUID: QQYf2YRxQY6lCgYopqvNUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="37621971"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="37621971"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 06:23:24 -0700
X-CSE-ConnectionGUID: iBob1BG9TzCNfKQg2Exqqg==
X-CSE-MsgGUID: 9pgM860lQdaExnPZX3SjjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="40015231"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 06:23:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 06:23:23 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 06:23:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 06:23:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 06:23:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwHwR17TsI6bWP/O5HE7Dxt8w5FXdj/yM8ZgNZlc4NSfe15bWVfureHZy0wuiDMi8bMfcXYxnIzSnFElgyPwCTAT0Vn9n6IsgiuH/KkWegkeojDfbZClXABzuyj+Bmy+ZeHfhO6ukJJs+XlutMXNgzBKLHRVReNj2AQ/LrHvZZbav8sIQ1qn+11i1R+GOF1FpLxYw2UFp1Atv5sK58wjnB0ivHo4TPbKwt36VX0CPyNGdWBYMczlqWPFl19pT+moplyhzUnwuN9i7S2hqdNUM+Y7okGRvq3dZV90mL1ZSAiyRTaTZ3HXzVZmmRvQ3KtgcNiyZHPHCUopuelaY8GWGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/z/ILFZpqJ5cL1wOq1gdSO7RIHeI7uV1JiJEnxP9lM=;
 b=b8KdVZImX+GjzVSx+MrUW4FM14NYF9gb4SEuou4dDASYxaPMMA2Do84IX1kk9rUqkIUXusZ0oDyG0qYT/9cHKW4j4HKzAt3xlCfNCQApy3TxHk72mSIxf9c+nLmnTq0jb7cdvVJM+5gbzLsW4dCJ6uzmPQ9VQx7Ei5EMDb5VDf6RC23BkDKy8l4bpk+AMQCu5JCq5MPvwKAr7v1k/cwZFqqkI7vgczfru9oArxQWHR5/GRYdXtuc+N4pDHAnH2p2rrdiIuvK3ZHJ/cHlJ6fV75yDDOTOK8Od24ZOcI91zzs7UODuN9IH8i9pdbid5bFOEbUEIWDdj0tMcMENf3Ri2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH8PR11MB7021.namprd11.prod.outlook.com (2603:10b6:510:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 13:23:17 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 13:23:17 +0000
Date: Thu, 13 Jun 2024 21:23:04 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Chunxin Zang <spring.cxz@gmail.com>
CC: Honglei Wang <jameshongleiwang@126.com>, <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, Mike Galbraith <efault@gmx.de>,
	K Prateek Nayak <kprateek.nayak@amd.com>, <linux-kernel@vger.kernel.org>,
	<yangchen11@lixiang.com>, Jerry Zhou <zhouchunhua@lixiang.com>, Chunxin Zang
	<zangchunxin@lixiang.com>
Subject: Re: [PATCH v2] sched/fair: Reschedule the cfs_rq when current is
 ineligible
Message-ID: <ZmryuDqw2fEhHNni@chenyu5-mobl2>
References: <20240529141806.16029-1-spring.cxz@gmail.com>
 <ZmKVjmuC4kGrUH5V@chenyu5-mobl2>
 <2E6EB0D6-D913-4205-B7DD-35EF4FA25667@gmail.com>
 <Zmrd2hwqHB8RQjqB@chenyu5-mobl2>
 <112FECA8-5D21-406F-814C-ACBE63351CBB@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <112FECA8-5D21-406F-814C-ACBE63351CBB@gmail.com>
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH8PR11MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e0346c-5b76-4a34-8932-08dc8babfc75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EOE6t/k0SIS4392wjHmOl998pkN0ZLm6fFnsp2zN56dV/SHERZbEfqwiirw1?=
 =?us-ascii?Q?uxaURU6eG+UPyl4p0RKjj1mEf4pQt2YZG8h52JGWPFUzXcvmZ5mb+pJWCnJ/?=
 =?us-ascii?Q?KFEm9hqlSaa2NsApO8qN0TeICCGZv6ICcyXsjQQS5UVdksik7rqofMcsd+h5?=
 =?us-ascii?Q?wdP7iG41fvEId6Ia8XSzX4nwy8cXHKZ5Wj0UbMFPOofG6JO88y+kq6CGbrQo?=
 =?us-ascii?Q?X8DO7KpwFaxwaLrVaeIcfMBXTQ2EivNV/H+7pi7sOIG8Vp99czJ0ISY5LbVo?=
 =?us-ascii?Q?IFjRz1UVSpqpRzQvhOAfJk84eqmd017FqED1eivV8WgipraQlAeyhPxmJNaG?=
 =?us-ascii?Q?vvi9d/VHCmjsktjutC0XRpoyMdgCbzxNwDmgWaqG2XVbDhyKKhabrljvwSqb?=
 =?us-ascii?Q?ffq8yk//fwl/HG8hkHAep7bGhFo1KTzNOAFPOI9UX/fDMrt1FM7YRCXNyczl?=
 =?us-ascii?Q?fdjeKdpra+k8+xbi+7fCC09jsQu63VGcRI+dEI5qpUOdBpGPg6HrdNEjhJ4E?=
 =?us-ascii?Q?pduMxAfqqS7OGEoW98K8I8EBG9BHZRZCZr6vcUElI8/VZ7IjbFcnd5/JpsUY?=
 =?us-ascii?Q?P3kBUCwihWxuYY8yuuYWbHr3TjgCCArz1Vm+3bkGteUo8KPO7NZBGDgOtR+2?=
 =?us-ascii?Q?1qTjx8Spk8neRUyDsKJ8Th+hZ3oKqEvyYWy/1g0X72UZqiEM6r9avc0xcAM3?=
 =?us-ascii?Q?ZHiqvTxHOPgrLJhJcjlwPXz7Zd2XCDLA4CRuq01/K9yjgByM6ygjOGZYl4Gp?=
 =?us-ascii?Q?CRnmDZKFp+QNr0TvYbZAo6/d0/OQXYClvuq14uv2ATUALIftIIKgBeqBSdTT?=
 =?us-ascii?Q?QM3Fd/S7QUA7qIJQw0PzkVnQ/Desr6W34Zi4ziyu1wqQa5NiF0R4Ko8mAszM?=
 =?us-ascii?Q?rLDdsqOgiTCkUS7r1AW1gE7EMtlCh52QVCei4i7Os77fY4ywU3SbQFPdKjmB?=
 =?us-ascii?Q?mYlwD7LOlNTlL8TZiJAU2pOqMWyBl1F+dkA0NDffN9W8F8t9EvYjE6w4BHpu?=
 =?us-ascii?Q?UHZqFev41BT47KTN8UlLE5AQDpYVQzqIMJxnjmZDpbOH0S95eDZCk40NZn73?=
 =?us-ascii?Q?VmJpfetNyz9bcCUUPMS79U9hSUnaJlhqj50LjT0qg9gUANbBoEe+J/GTFvwQ?=
 =?us-ascii?Q?5rTHkG61nEZhUVSUDi0ubRPGMmhjiZhAPOgjFvBaCImcUxJ0b5P7sSbNejJA?=
 =?us-ascii?Q?fs4QgECQ3Lc59oPlumvGPaA5+J/YKh4OnpEQvMirN+OwJlW1updo6+0RPj4V?=
 =?us-ascii?Q?nw1tlnYNhmK7vuXeyBneTfahSLlduHECyeekLbwKlfXz+xJyubPD+JlolxPk?=
 =?us-ascii?Q?dMzLWAiUoF0Dx9ubKpVrQxfd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BwNIgEnFfDi8rPGgH7BCyCTObSRHWuohsVQrewPBu0zD2tnyT7xWxXO4f4hM?=
 =?us-ascii?Q?e9CyrHf59nvBrJQTh/8hh3SV8jLln9r2jWTaVYuBD63i3V/ri2d6MiCvxoMU?=
 =?us-ascii?Q?uJufzf3QxniOsY4ME7fg3F92dzOafjl28kOX/TLaJf2qIrorrPzYUGgcGzOL?=
 =?us-ascii?Q?6kS1DDOVRe6Tg+oSG/nCU0rmXkm/OzdtOG6X50O7qRIYLOacHaG44lobWJIf?=
 =?us-ascii?Q?XC+IbEc+NBbsbBhhjnO9ON61/V0WM7uSN2fwth+zSmk90xyEm1ukMtkFQg1X?=
 =?us-ascii?Q?nSXobaC/R01kZgRVHQj8i0QuesCPbewfW0ojliH693i/lOaKJH0Y8OBhgUQV?=
 =?us-ascii?Q?j6PmTbUtTTaED1SsF+sRdbFQ5i0sZ0/ml39+tOut/WI//eIbDMZc3TRsPo57?=
 =?us-ascii?Q?gHndoaeo5hmH9zOy/Ayn/kCXxoZSOoLZfkXxrievoWEbHav3ptA1DWfnsSC/?=
 =?us-ascii?Q?iTXYVJuxXDHn9MAjKA+l14H1J8iOrmKjgVbYIS8xqdIw9bW+t10dNDSuBXO3?=
 =?us-ascii?Q?B0Q7eMNQ4GVYfhAhxIqRdF047Dd5lI/ci3Gi3wkpfc6iNjm6ISokTS3X21aF?=
 =?us-ascii?Q?GWRHl8kpd0taR3VRqnBPM2oyoP621Ns0YQRq49MiwivCqfMZxOZrNqtWmlcK?=
 =?us-ascii?Q?8waQj/VqHWnjlZKeR8dxXpj4OMCnxK7TXSh1azVS/Fq6lfnxT9QsmYVlcHyb?=
 =?us-ascii?Q?4cTlHWEIrzYsIqHTnmMyzsu5wiWFFJgMkPNCLQu8aa9SvmN5shPweLNX207b?=
 =?us-ascii?Q?n3FbtbkXsnJYc8csjxuIuPKQOBckGaGXfUJwsPB1ulomj1Awi+oAVEDKK1oQ?=
 =?us-ascii?Q?rSA7VKmMXJE9TUqXBg8MxHmCy5oiJ/bK+MYo83EwLK1Vt96q8PsJprRXvsAO?=
 =?us-ascii?Q?Sv8ELRMUlUMiH67V6NlNMb8LyyfqT4T5zyh7tPuv+gkG+Brjf8+eCCcUsCsK?=
 =?us-ascii?Q?7iz+tZFc3oXw0Dng1jcSb7J4GBBYVQIL2bc+ktms4ndOsgH5ZfRcK/cv9CI5?=
 =?us-ascii?Q?d+TAsYwcrB4bivKdGCgVo0pip580TAZ9Ia3U5yQrqvoGFamVvCQB9H4IQQQE?=
 =?us-ascii?Q?v0W4ejmf5+lEInpJ+Uz3U4Q5XWoeUg3jVSAnuMq2mgAk9NxapZRNTvx/1nXd?=
 =?us-ascii?Q?el5AA1GRn6Hko+M1Dh/AnojnoKJU+W9KaxgGBQorjGRGkPNSdL/7zsdF6pxH?=
 =?us-ascii?Q?1GVASknuf3pH2c0WeanFDyX8soJX2gMt1jeoftdoFPs7GGaEgfG9Fhm22AB9?=
 =?us-ascii?Q?PEdzN17XTvIde9rqoxPGSZNXoYwBUe6YEz4NJQ76EXMIXOU1GG6hJlbRE5QV?=
 =?us-ascii?Q?zRpyq5S86wSFqxNuJEWfXRNzPJfmgBTpBM8ZtiWVfCbsa2XMGm4rK9kT2f2d?=
 =?us-ascii?Q?wuptbLYoVH31C3obS0V/4/PUpU3jlDKXiMzDEVDJsbPfKEx7BBYw8zWzCCBJ?=
 =?us-ascii?Q?t0ZC4qwaKPUKRgcP+lkoIA/hndjPvrDyv3iQJtoBSvz/SG/MV7+FDY8DSTRm?=
 =?us-ascii?Q?r6Mi5u25hNgaARusMUOsIWB+YFWVgaqbTu0ibagzgieCCUUxEqXfchJgKiQi?=
 =?us-ascii?Q?26iFbozqUZII62IZlnWVAxgfyDRENEzTRx0qlIR1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e0346c-5b76-4a34-8932-08dc8babfc75
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 13:23:17.2312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WLl0T141MM+Yop5ngxs/uZqAFDFX0PwMCzQnsCZA9XQ7StH77VNJJij1K+Q324siLPF62a6mYxfa+MCcBsjDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7021
X-OriginatorOrg: intel.com

On 2024-06-13 at 20:02:37 +0800, Chunxin Zang wrote:
> 
> 
> > On Jun 13, 2024, at 19:54, Chen Yu <yu.c.chen@intel.com> wrote:
> > 
> > On 2024-06-12 at 18:39:11 +0800, Chunxin Zang wrote:
> >> 
> >> 
> >>> On Jun 7, 2024, at 13:07, Chen Yu <yu.c.chen@intel.com> wrote:
> >>> 
> >>> On 2024-05-29 at 22:18:06 +0800, Chunxin Zang wrote:
> >> The purpose of the modification is to increase preemption opportunities without breaking the
> >> RUN_TO_PARITY rule. However, it clearly introduces some additional preemptions, or perhaps
> >> there should be a check for the eligibility of the se. Also, to avoid overwriting the scheduling
> >> strategy in entity_tick, would a modification like the following be more appropriate?
> >> 
> > 
> > I wonder if we can only take care of the NO_RUN_TO_PARITY case? Something like this,
> > 
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 03be0d1330a6..5e49a15bbdd3 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -745,6 +745,21 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >>        return vruntime_eligible(cfs_rq, se->vruntime);
> >> }
> >> 
> >> +static bool check_entity_need_preempt(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >> +{
> > if (sched_feat(RUN_TO_PARITY) || cfs_rq->nr_running <= 1 ||
> >     !entity_eligible(cfs_rq, se))
> > return false;
> > 
> > return true;
> > 
> > Thoughts?
> > 
> 
> This does indeed look better. In that case, do I need to make the changes this way and send
> out a version 3?

If you mean the following changes, maybe we can continue the discussion here.
This is just my 2 cents, not sure what others think of it. Anyway, I can launch some tests.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae0aa55..c0fdb25f0695 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -744,6 +744,15 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	return vruntime_eligible(cfs_rq, se->vruntime);
 }
 
+static bool check_curr_preempt(struct cfs_rq *cfs_rq, struct sched_entity *curr)
+{
+	if (sched_feat(RUN_TO_PARITY) || cfs_rq->nr_running <= 1 ||
+	    !entity_eligible(cfs_rq, curr))
+		return false;
+
+	return true;
+}
+
 static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
 {
 	u64 min_vruntime = cfs_rq->min_vruntime;
@@ -5536,6 +5545,9 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
 		return;
 #endif
+
+	if (check_curr_preempt(cfs_rq, curr))
+		resched_curr(rq_of(cfs_rq));
 }
 
 
@@ -8415,7 +8427,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	/*
 	 * XXX pick_eevdf(cfs_rq) != se ?
 	 */
-	if (pick_eevdf(cfs_rq) == pse)
+	if (check_curr_preempt(cfs_rq, se) || pick_eevdf(cfs_rq) == pse)
 		goto preempt;
 
 	return;
-- 
2.25.1




