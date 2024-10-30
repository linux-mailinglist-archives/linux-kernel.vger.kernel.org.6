Return-Path: <linux-kernel+bounces-388309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A399E9B5D80
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BE81F241E1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CC81E1051;
	Wed, 30 Oct 2024 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LlseMWfo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B17C1E0DAC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276346; cv=fail; b=VjqfNheqEiuSdc47SIKZ3aFD4au+a0VPDpSxmAj8odqWbwrAYRn8hHWS/krgQARVKqw/caHdRz0jui/UCrv+7GJ3EHIR1X3VtmolULxRKoU/TTC+MwrdMlOox3ft9kM/R2dcH4biFlng/pps29Q0DGgszDjYDxekR6Q1rKq3wk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276346; c=relaxed/simple;
	bh=zTQoo3QFOFKXp5QO7la37g2UX7rRaMznyEIPhztFOfA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fi+SkeIglUT7MUX3wFY5TIRUHRrVeSsNRCpE2aYRK2lA2nG7ialNY7MDVI54KUg7e0/67OFvkCMkT16KtRT2P2UnWO/8FWiQDJcasf0tYiHyMUKZNK5CX723T1t2yTx8CAoWNQUDFYNdkZjcjEfRiAI5FlZm1f8WdG72WFO/+Tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LlseMWfo; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730276342; x=1761812342;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=zTQoo3QFOFKXp5QO7la37g2UX7rRaMznyEIPhztFOfA=;
  b=LlseMWfo22N9BJlkiXeH7kB5FfWyl93NAqrjYBAp/Doy8I3kNwLHyj16
   sNFcbP1pwdRy6KCvKS8Sc+ozZogGcwksXCTSYZemTYlzUPF3RnIoEZzSv
   c7DIqHX4f4CnPTk0wzxKPXQJXih2oFvMvj4LcCI4KOGKETxoCH7olXXL/
   2oxlZW0vVlJu6yAZwnO2fniDU5YLnlA4s9V2KOTBdGdqez/bu+OCtBXwJ
   C55nC6e0J/ocNJURU1U4vZ7f7akxngiaXPCTDLQ8XgD9TfNhrrM/qVmfS
   LaN9SS1IlYjR30qfOeoH3JiUZwegHv04jlXyWTJCriZsbHE6H0FWIe0kq
   A==;
X-CSE-ConnectionGUID: KROAqkoiSBeF3SKSB+eQUw==
X-CSE-MsgGUID: IGIp238xTXyn8U2aNbqQeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33656801"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33656801"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 01:18:41 -0700
X-CSE-ConnectionGUID: 8vEDlrNRRtOMAKkSezG/YA==
X-CSE-MsgGUID: lUu5HeN8QeOdT0Dmnst0XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="119712771"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 01:18:41 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 01:18:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 01:18:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 01:18:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7bIZ2yA634L1ioXAdov06Xne36KAHsEWXcbSNCOwQVJzFdzOCXFnTm9o0DMymYEfa/PsQxrBiEjp4npwJOAI4VyCg7m1jy3ns6VetdJnucofKdqEzE5cG3HiwSKaFRYooGjhRfFnXjMKFqZnDWa26+IZI4/njpVkImVzZKtIQYwE4u2wtm6xDD+kQgkU2Wm0dZ+I+Ok3Tx752sZsoKjtpNUlUHiQ5/J6y2EdDMjXVvqY8G0jrFU09glYe3i2prRGpj2LV2BgJeSSt5D4AFZpXqdBQf6C81gBWY+1zi5DEVMrfZB8nWSKsuXpADYtFQMes1uHYA4aArImpsfz1wrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yABwcPneuZmDBWWZ0QblWMztMV+JIARipKrLc5aXHJw=;
 b=KccC7XdyEJ58N1bKhgURkir6n1JSF4I8o0pxq8n1LoLuAcbKkrTS5mzDpZ7huGmkISPg7OTHS1IwOqj5YXFuJlZrmbGNZIjIspn86VoO9H2nHTZla7H2bSHAHR7tbl9B31EpQ6RRw7ryTXM0rE8X03Y+/FnRJ9U9UUB9W2sypjbFGLxY99IKv1JsfKECaj+5U0/6Czw6OTHlvjTRk5do7h23JuWFA678NfeFND6+VOin7KHYXC/K7aBfff173nhf3UPJeW/ojWypiO6sSYpnBS1NA9rWIl8DijnLmReV5xOC/k0DU28ITv0cCt0+1WHttBJ/eQfyFrRm39omYjGjrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB7517.namprd11.prod.outlook.com (2603:10b6:a03:4cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 08:18:33 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.025; Wed, 30 Oct 2024
 08:18:33 +0000
Date: Wed, 30 Oct 2024 16:18:17 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Tianchen Ding <dtcccc@linux.alibaba.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tejun Heo
	<tj@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH] sched/eevdf: Force propagating min_slice of cfs_rq when
 a task changing slice
Message-ID: <202410301535.14e0855c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241028063313.8039-2-dtcccc@linux.alibaba.com>
X-ClientProxiedBy: SG2PR01CA0188.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 67cb78d4-de4f-4338-8c85-08dcf8bb7194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q2WLu+FUZnQXaJvd9jXnBd6rJTv7YiPESniQY2i+A5uXkBCXBlTBIb4ir9B5?=
 =?us-ascii?Q?yxbRP7nim0BEymqUra2DYiLhJ9U2TMT+s5/ZSgOoaSrH075SHMmGP8XN9WAc?=
 =?us-ascii?Q?tLRZ6z8BBVCchAeO9fIzJ7wQ9NavpWD0ee7fX0QOjvnPyt7xAepC99cQTbdv?=
 =?us-ascii?Q?l3a4vYVrr7q4BzC/uaR8n3gs3EmJQBey/uzxJ2GzFuOhUStiU0FmqNxJmqGc?=
 =?us-ascii?Q?EEImcMfR5OCmEHGPlQSLFd3eVx2Nnm2Jw7Wt/rC/fT0LnefghQJobvI4nxcU?=
 =?us-ascii?Q?uNeHtwacXofx5hxCJy/+gNr05wRbzM8DvUaJnVm5dNztbRi5rdEaMagBnqZ7?=
 =?us-ascii?Q?Zu6HPyxh/ES6JdJCJuYESq4+bLdQEoAMTinWs7KaVjHnb5hEzt4CD2WFzVN6?=
 =?us-ascii?Q?kdsxblGjaD6FyORKoPQxEUxlj20DiKY2vydmQdxjI+q4pJOF5NF57iuzhbmS?=
 =?us-ascii?Q?LL7TZEEy4o9DkgCmVmYXUbHGhlfUMJBnRiRCJQYAOtTWOK9xSEaTAnkarhVl?=
 =?us-ascii?Q?Lsg19JWm1cNiRk307UTxJ+FNVZoi8GFJZeNRwAHCvQzz5En8rB+7e0RgfpIv?=
 =?us-ascii?Q?hQmrQrBESrc+aIckV6OQmDPQmVHIYUneLVFXCCV8D+FVvfSYSXitkKEp9L8p?=
 =?us-ascii?Q?W//B+tIM7N77MLN0ojpRhAQPlZWsOa6mLAY1IVUT38jAXzL1Ar0TP3kHmhTh?=
 =?us-ascii?Q?rbmhFSrCJUkgrkZSqQWRyAOaehuIQmtAhGKZ5XKCgLOM1V20gSzCVFWJx+Lb?=
 =?us-ascii?Q?pm4+S/RVySchlUtPuuIt5AQHHx2hlOoYQnbJFMBrMt+PARIgwVxL9RSZsfqV?=
 =?us-ascii?Q?FGYV0C73KG8WyEHbjt51UnPYLa8fc7yX6y8wE6mUKQfr4rBIA3rvYxnBhwno?=
 =?us-ascii?Q?ZyFBZCZUBnqp06iNOFGGJjha3YJRXAERDi4WEJy8nqbPZGYO2pgx8kOcr0aC?=
 =?us-ascii?Q?vxlhd9oQmH6Y3hqlf4sY76o6TF4SlfR7msvwle+xJYuavYNIxkHkhrMs70FG?=
 =?us-ascii?Q?GzfGh5g0EXj+OyqUzkgpevwVOG8ZkFr6+9Ve2h81+5OVbmQGVWGOEmBnNbh3?=
 =?us-ascii?Q?AkxCDwPxW6VrL1+C8p5jVfOnX5wJK2i908JzfLvJtvnaBuVjwslRe6TDvat6?=
 =?us-ascii?Q?CBKcflBUb4E/2ZfxRlpBVu57sgaYdjooOjXLnse6EROAlo3P76kQToqptWG4?=
 =?us-ascii?Q?XiE0ZxGtIIj4isNCNjP0cP1Tx7b4GFCzy19ZEOxTCmxS+dW13jD97OAZVgmN?=
 =?us-ascii?Q?uLj9WBG2zRUYcmM+LmW8LlReEh4HWPtV3KDyt5GIWA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VsZ8bPfRHqG+EYcskWFuSNybtnD7K1nxiyfX/lhWia5eiWJlpoc/Gv8qHEZo?=
 =?us-ascii?Q?mKnQcx5xLeiOqWODbnKf0G3JeqzlQD3eNiKNBhVzly2FCKbO2FunDDXUv5vV?=
 =?us-ascii?Q?nOakxNqFfPdBBzTTScUTfHEiiDF0WJma2S9lyioU0u6ZdwCvHEl/y6pF+8sJ?=
 =?us-ascii?Q?xpP/QQYZK+3rEkiHW3ibe9/vje8XesRwn+cW2zctyeiqQTSBu35RHXfglCkN?=
 =?us-ascii?Q?AeUH5Zy7sH/PSGq6h83wv6pJ2aM5qQgOP1NCV36BMbdPyZ5yCVkv/kwXbLcE?=
 =?us-ascii?Q?YWlK3wMOFO3LjShTl+bHwjEjtxz4bzocwhM7SbS14OFvVdO+v9k7wCXAmwNx?=
 =?us-ascii?Q?n5DuXWWzwpiw/q4v0x9hv6nARJaypgRCwjSCa2zgy5ds3p3VaaZBaCvGflJR?=
 =?us-ascii?Q?7HQdYLt+/HwS9JGULgSpgHjmKNXF8+BzSHEq6FrPcegzgZ5Zkp9IwDq62g7R?=
 =?us-ascii?Q?YWGtR+PAYyGR5ZbxvIVPl8hNG62p1OS3NAhDlAqOBBJNkqrr5iC/rEZfUno3?=
 =?us-ascii?Q?M7/nmjElahda5K+dzbdYZkD/2ssE1rMGmxM16+ccNFVA1IpFdAdA1o0zcx4d?=
 =?us-ascii?Q?MbTsEzhgDaOURUNifToVcKnKBfoEtEIw2l9rAh1ACBuR+khh5pK22A80GcYI?=
 =?us-ascii?Q?E903nazYFf2n+tk/U5Rc2+6S+97ucZcKKAVhOCr56c4w19hX43QEX4e3X58V?=
 =?us-ascii?Q?UmCKTZv0gcdZIYMRGPUMo5FSfr7F1Wws036p6iLgU4Wy8Hq4514LD0+NyvwG?=
 =?us-ascii?Q?iuynirrxuST2P+L8uAR3bIZLj8cCY2k8Ws/mGlUuzm4eWf+b0mD81fJf+58x?=
 =?us-ascii?Q?MY4OFmGSDtVG89zgjvlyuccLZWFSj8dD5s/Z70FJRGSjURE0HaQosgm5B7jy?=
 =?us-ascii?Q?6qzKKXavv2gxqHEHcAxsvjPc56LggJA8+WFRjAfOtM6YmzJSS3a6pTXP7AoV?=
 =?us-ascii?Q?5zDQxtvd4fOVPhTaws9B70IfJduzzUzaESmNMVJqKEDkepebODVQnJiyy19l?=
 =?us-ascii?Q?39DMmA+EjjvyO3ZwsA3L2Vs7odvel49BERznKdqyj5hL7PFgEzOYv8u27MjE?=
 =?us-ascii?Q?gCFDoqu4y63uZmproyUDjsbudC/alpnLwrfSb+zcoiInOIVJt3uHjpbe8Hog?=
 =?us-ascii?Q?W4T8Xv/ds97ZekuoZ4+r0B8xyIyNBym9CZR8K4GDVjUyLEXkC8syitPsM1OH?=
 =?us-ascii?Q?1JNPPyzLcUOPzWdiYs7fR6yICZIiUln278lJ9YWeACUWVsiWt2vAtoaGVYP9?=
 =?us-ascii?Q?x6mRVIDmYL6I+bRZtK31dDWyB5+8Py2t5+QCJwz8Gyj6TxnD5JLjL4JfkTbe?=
 =?us-ascii?Q?KGBx+2BS75FGRbS+aDdBYl7bR1fsrZ6YUxZrFbBusD9c1pdjlt5zhl37u+He?=
 =?us-ascii?Q?riCRxpP5yBkW7wgcEEPUXPGPaGVznFJOOsKiSzWdkF8reNo4WGlifrAe3exE?=
 =?us-ascii?Q?XbnG3FLv/y0nvCwzel3k2pM4As0JqDzDgHM9oEIc3SLbFgZUYdGmvL22I5zU?=
 =?us-ascii?Q?bWRI2LaQzv0iTa8+CtcW8jlLX7r/7VX3QTA6xvUThcU6dW5u7odCtgG7Q/n7?=
 =?us-ascii?Q?ks5ponsG0FF+/1rX8xLwDD/5xK0u/0oTMudnj3mV86/yDDnsP3MUlsp4yKf/?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cb78d4-de4f-4338-8c85-08dcf8bb7194
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 08:18:33.1116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L25+8xljHH6UBk2hD10ehIS7hVRmxDysKr/h+LCFWiMLMCZkEOFQPO9sagoKSdthVHyKT25kty4m7QyNLjOdCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7517
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:slab-use-after-free_in_enqueue_task_fair" on:

commit: e9b718a38463470cc388aaa3ff50f12bbe8c4279 ("[PATCH] sched/eevdf: Force propagating min_slice of cfs_rq when a task changing slice")
url: https://github.com/intel-lab-lkp/linux/commits/Tianchen-Ding/sched-eevdf-Force-propagating-min_slice-of-cfs_rq-when-a-task-changing-slice/20241028-143410
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git d1fb8a78b2ff1fe4e9478c75b4fbec588a73c1b0
patch link: https://lore.kernel.org/all/20241028063313.8039-2-dtcccc@linux.alibaba.com/
patch subject: [PATCH] sched/eevdf: Force propagating min_slice of cfs_rq when a task changing slice

in testcase: trinity
version: trinity-x86_64-ba2360ed-1_20240923
with following parameters:

	runtime: 600s



config: x86_64-randconfig-014-20241028
compiler: clang-19
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------------------------------------+------------+------------+
|                                                                              | d1fb8a78b2 | e9b718a384 |
+------------------------------------------------------------------------------+------------+------------+
| BUG:KASAN:slab-use-after-free_in_enqueue_task_fair                           | 0          | 4          |
| BUG:KASAN:slab-use-after-free_in_dequeue_entities                            | 0          | 1          |
+------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410301535.14e0855c-lkp@intel.com


[ 117.822447][ T468] BUG: KASAN: slab-use-after-free in enqueue_task_fair (kernel/sched/fair.c:831 kernel/sched/fair.c:846 kernel/sched/fair.c:7020) 
[  117.825270][  T468] Read of size 8 at addr ffff8881678c1c30 by task trinity-main/468
[  117.826451][  T468]
[  117.826941][  T468] CPU: 0 UID: 65534 PID: 468 Comm: trinity-main Not tainted 6.12.0-rc4-00025-ge9b718a38463 #1
[  117.828330][  T468] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  117.829779][  T468] Call Trace:
[  117.830339][  T468]  <TASK>
[ 117.830865][ T468] dump_stack_lvl (lib/dump_stack.c:122) 
[ 117.831554][ T468] ? enqueue_task_fair (kernel/sched/fair.c:831 kernel/sched/fair.c:846 kernel/sched/fair.c:7020) 
[ 117.832327][ T468] print_report (mm/kasan/report.c:378) 
[ 117.833021][ T468] ? __virt_addr_valid (include/linux/rcupdate.h:337 include/linux/rcupdate.h:941 include/linux/mmzone.h:2043 arch/x86/mm/physaddr.c:65) 
[ 117.833768][ T468] ? __virt_addr_valid (arch/x86/include/asm/preempt.h:103 include/linux/rcupdate.h:964 include/linux/mmzone.h:2053 arch/x86/mm/physaddr.c:65) 
[ 117.834510][ T468] ? enqueue_task_fair (kernel/sched/fair.c:831 kernel/sched/fair.c:846 kernel/sched/fair.c:7020) 
[ 117.835304][ T468] ? kasan_complete_mode_report_info (mm/kasan/report_generic.c:179) 
[ 117.836192][ T468] ? enqueue_task_fair (kernel/sched/fair.c:831 kernel/sched/fair.c:846 kernel/sched/fair.c:7020) 
[ 117.836990][ T468] kasan_report (mm/kasan/report.c:603) 
[ 117.837670][ T468] ? enqueue_task_fair (kernel/sched/fair.c:831 kernel/sched/fair.c:846 kernel/sched/fair.c:7020) 
[ 117.838449][ T468] __asan_report_load8_noabort (mm/kasan/report_generic.c:381) 
[ 117.839276][ T468] enqueue_task_fair (kernel/sched/fair.c:831 kernel/sched/fair.c:846 kernel/sched/fair.c:7020) 
[ 117.840026][ T468] enqueue_task (kernel/sched/core.c:2027) 
[ 117.840701][ T468] activate_task (kernel/sched/core.c:2069) 
[ 117.841383][ T468] wake_up_new_task (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/sched.h:185 kernel/sched/core.c:4829) 
[ 117.842104][ T468] kernel_clone (kernel/fork.c:2818) 
[ 117.842786][ T468] __x64_sys_clone (kernel/fork.c:2927) 
[ 117.843490][ T468] x64_sys_call (kbuild/obj/consumer/x86_64-randconfig-014-20241028/./arch/x86/include/generated/asm/syscalls_64.h:161) 
[ 117.844198][ T468] do_syscall_64 (arch/x86/entry/common.c:?) 
[ 117.844861][ T468] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:467) 
[ 117.845742][ T468] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 117.846571][ T468] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 117.848374][ T468] ? irqentry_exit_to_user_mode (kernel/entry/common.c:234) 
[ 117.849183][ T468] ? irqentry_exit (kernel/entry/common.c:367) 
[ 117.849897][ T468] ? exc_page_fault (arch/x86/mm/fault.c:1543) 
[ 117.850589][ T468] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  117.851487][  T468] RIP: 0033:0x7f97dcccc293
[ 117.852155][ T468] Code: 00 00 00 00 00 66 90 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	00 66 90             	add    %ah,-0x70(%rsi)
   7:	64 48 8b 04 25 10 00 	mov    %fs:0x10,%rax
   e:	00 00 
  10:	45 31 c0             	xor    %r8d,%r8d
  13:	31 d2                	xor    %edx,%edx
  15:	31 f6                	xor    %esi,%esi
  17:	bf 11 00 20 01       	mov    $0x1200011,%edi
  1c:	4c 8d 90 d0 02 00 00 	lea    0x2d0(%rax),%r10
  23:	b8 38 00 00 00       	mov    $0x38,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 35                	ja     0x67
  32:	89 c2                	mov    %eax,%edx
  34:	85 c0                	test   %eax,%eax
  36:	75 2c                	jne    0x64
  38:	64                   	fs
  39:	48                   	rex.W
  3a:	8b                   	.byte 0x8b
  3b:	04 25                	add    $0x25,%al
  3d:	10 00                	adc    %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 35                	ja     0x3d
   8:	89 c2                	mov    %eax,%edx
   a:	85 c0                	test   %eax,%eax
   c:	75 2c                	jne    0x3a
   e:	64                   	fs
   f:	48                   	rex.W
  10:	8b                   	.byte 0x8b
  11:	04 25                	add    $0x25,%al
  13:	10 00                	adc    %al,(%rax)
	...
[  117.854567][  T468] RSP: 002b:00007fff02a6b648 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
[  117.855822][  T468] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f97dcccc293
[  117.856993][  T468] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
[  117.858049][  T468] RBP: 0000000000000000 R08: 0000000000000000 R09: 7fffffffffffffff
[  117.859328][  T468] R10: 00007f97dcbf5a10 R11: 0000000000000246 R12: 0000000000000001
[  117.860342][  T468] R13: 0000000000000002 R14: 0000000000000000 R15: 0000000000000000
[  117.861176][  T468]  </TASK>
[  117.861691][  T468]
[  117.862096][  T468] Allocated by task 902:
[ 117.862719][ T468] kasan_save_track (mm/kasan/common.c:48 mm/kasan/common.c:68) 
[ 117.863560][ T468] kasan_save_alloc_info (mm/kasan/generic.c:566) 
[ 117.864398][ T468] __kasan_kmalloc (mm/kasan/common.c:398) 
[ 117.865193][ T468] __kmalloc_cache_node_noprof (mm/slub.c:4308) 
[ 117.866038][ T468] alloc_fair_sched_group (include/linux/slab.h:? kernel/sched/fair.c:13312) 
[ 117.866871][ T468] sched_create_group (kernel/sched/core.c:8853) 
[ 117.867588][ T468] sched_autogroup_create_attach (include/linux/err.h:67 kernel/sched/autogroup.c:93 kernel/sched/autogroup.c:194) 
[ 117.868413][ T468] ksys_setsid (kernel/sys.c:?) 
[ 117.869079][ T468] __ia32_sys_setsid (kernel/sys.c:1269) 
[ 117.869767][ T468] x64_sys_call (kbuild/obj/consumer/x86_64-randconfig-014-20241028/./arch/x86/include/generated/asm/syscalls_64.h:161) 
[ 117.870453][ T468] do_syscall_64 (arch/x86/entry/common.c:?) 
[ 117.871156][ T468] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  117.872032][  T468]
[  117.872468][  T468] Freed by task 243:
[ 117.873823][ T468] kasan_save_track (mm/kasan/common.c:48 mm/kasan/common.c:68) 
[ 117.874518][ T468] kasan_save_free_info (mm/kasan/generic.c:582) 
[ 117.875278][ T468] __kasan_slab_free (mm/kasan/common.c:271) 
[ 117.875923][ T468] kfree (mm/slub.c:4579) 
[ 117.876526][ T468] free_fair_sched_group (kernel/sched/fair.c:13278) 
[ 117.877340][ T468] sched_free_group (kernel/sched/core.c:8823) 
[ 117.878034][ T468] sched_free_group_rcu (kernel/sched/core.c:8831) 
[ 117.878758][ T468] rcu_core (kernel/rcu/tree.c:?) 
[ 117.879467][ T468] rcu_core_si (kernel/rcu/tree.c:2841) 
[ 117.880104][ T468] handle_softirqs (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.c:555) 
[ 117.880824][ T468] __irq_exit_rcu (kernel/softirq.c:617 kernel/softirq.c:639) 
[ 117.881526][ T468] irq_exit_rcu (kernel/softirq.c:651) 
[ 117.882185][ T468] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1049) 
[ 117.883046][ T468] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[  117.883877][  T468]
[  117.884299][  T468] The buggy address belongs to the object at ffff8881678c1c00
[  117.884299][  T468]  which belongs to the cache kmalloc-rnd-07-1k of size 1024
[  117.886238][  T468] The buggy address is located 48 bytes inside of
[  117.886238][  T468]  freed 1024-byte region [ffff8881678c1c00, ffff8881678c2000)
[  117.888235][  T468]
[  117.888665][  T468] The buggy address belongs to the physical page:
[  117.889558][  T468] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1678c0
[  117.890880][  T468] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  117.892051][  T468] memcg:ffff88814cf29cc1
[  117.892690][  T468] flags: 0x8000000000000040(head|zone=2)
[  117.893467][  T468] page_type: f5(slab)
[  117.894072][  T468] raw: 8000000000000040 ffff888100059b40 ffffea000479e610 ffff88810005a828
[  117.896842][  T468] raw: 0000000000000000 00000000000a000a 00000001f5000000 ffff88814cf29cc1
[  117.898038][  T468] head: 8000000000000040 ffff888100059b40 ffffea000479e610 ffff88810005a828
[  117.899301][  T468] head: 0000000000000000 00000000000a000a 00000001f5000000 ffff88814cf29cc1
[  117.900519][  T468] head: 8000000000000003 ffffea00059e3001 ffffffffffffffff 0000000000000000
[  117.901731][  T468] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
[  117.903000][  T468] page dumped because: kasan: bad access detected
[  117.903859][  T468] page_owner tracks the page as allocated
[  117.904643][  T468] page last allocated via order 3, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 194, tgid 194 ((sh)), ts 46703728016, free_ts 0
[ 117.906952][ T468] post_alloc_hook (include/linux/page_owner.h:?) 
[ 117.907672][ T468] prep_new_page (mm/page_alloc.c:1547) 
[ 117.908338][ T468] get_page_from_freelist (mm/page_alloc.c:?) 
[ 117.909140][ T468] __alloc_pages_noprof (mm/page_alloc.c:4733) 
[ 117.909885][ T468] new_slab (mm/slub.c:?) 
[ 117.910539][ T468] ___slab_alloc (mm/slub.c:3819) 
[ 117.911291][ T468] __slab_alloc (mm/slub.c:3910) 
[ 117.911959][ T468] __kmalloc_cache_node_noprof (mm/slub.c:3961) 
[ 117.912775][ T468] alloc_fair_sched_group (include/linux/slab.h:? kernel/sched/fair.c:13312) 
[ 117.913582][ T468] sched_create_group (kernel/sched/core.c:8853) 
[ 117.914420][ T468] sched_autogroup_create_attach (include/linux/err.h:67 kernel/sched/autogroup.c:93 kernel/sched/autogroup.c:194) 
[ 117.915352][ T468] ksys_setsid (kernel/sys.c:?) 
[ 117.916031][ T468] __ia32_sys_setsid (kernel/sys.c:1269) 
[ 117.916779][ T468] x64_sys_call (kbuild/obj/consumer/x86_64-randconfig-014-20241028/./arch/x86/include/generated/asm/syscalls_64.h:161) 
[ 117.917631][ T468] do_syscall_64 (arch/x86/entry/common.c:?) 
[ 117.918407][ T468] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  117.919324][  T468] page_owner free stack trace missing
[  117.920090][  T468]
[  117.920515][  T468] Memory state around the buggy address:


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241030/202410301535.14e0855c-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


