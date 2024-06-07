Return-Path: <linux-kernel+bounces-205412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FD68FFB2C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17ADF287671
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 05:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7ED1805A;
	Fri,  7 Jun 2024 05:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBPMGZbz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67E63D6B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 05:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717736869; cv=fail; b=AiX2y9+NytCpCFWlGCQSmgT1vverRVJZ8P4ew09zqlu15r7Gz7m9lL+a8B2MS+2/rau1w7bHr1hBVunhIG9/FpUMipc0mLi8+Z0bGMZqTA7zZleDGjomNIbML3xzgCXTjXQ1LOThCeG6E46SfbBCkehFbRQFqM0feg04vdw/Jng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717736869; c=relaxed/simple;
	bh=4gST6swVMGx9WTIYhh0qVHKEjKBSvUvI/XuaaXMvsR8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UOIrPt6x3B2Wy/haYalf7Kx+jc17tpehZNkb4CyJUlIPjrI1WZPk0QCAzX57OWMtT2EsIPJGhYDmB2y4SwaS5+1z9oUDjxxt/Xxusjm9mJYWRf/qF7Yx9zQkSdc5cIsFqpe6n39kLuFlsV0pObLaj/DSRmVD5/maTfO6e/JGoLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBPMGZbz; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717736867; x=1749272867;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4gST6swVMGx9WTIYhh0qVHKEjKBSvUvI/XuaaXMvsR8=;
  b=eBPMGZbzKfLynQmUvSxguovCpFSLr0LWw3T+5MgCUFkdt2vne7NxpBom
   x/WBD4S7iEZ4Po4mJF6zlKZFw6yP2WDn1eK6PwCvw+uK34LeFlrD2vTUd
   z1HXdXcugpGN7kRBqC8aovdWbzIMIHaIL/LgU2zsIpynfFdHfJvGx3K2a
   hrOZnTY8DmCDul1aFIpL5y9y3RQPjyWi/UfZ2+yDQZxtoQK2JeTFSjxJr
   nTPH36Hpv2cCbRjCs3zjxQNcCq+5mhWdXMH9rNx00H5oKukKuW3F7SS0h
   cfR+oWTOhsuc0568/MbkP8R9QoMPl/e/nLONbp2HFKefVg+OZA7XfKYOy
   g==;
X-CSE-ConnectionGUID: 7Umcm9l8Rb2rcStCLkm9WA==
X-CSE-MsgGUID: +W2r9K57T6qt6ph8gnd/IA==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14283464"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="14283464"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 22:07:47 -0700
X-CSE-ConnectionGUID: Nv5tvChrTNqGSqiCfVIrPw==
X-CSE-MsgGUID: 5KKQb1YzQ4mNpBf6A8hZGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="38128678"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jun 2024 22:07:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 22:07:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 6 Jun 2024 22:07:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 22:07:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8taYAi4BCYihnRavgQuwGMpUP46gK1lEVQGSaP9H50/eFxcg9qyU5HumILNbwQ7+bX43sKRdXiXeYHjSYFoJ/SglVJEmicqEWouwZLjHvM2i7fR2ymHelaB08dXXoPAx2GVqjzovuvKMypukzdpcBmB6IBNG+CvANlUgXy0bo31hvsvZNN45bqD1mk3oqvkW0QQrg1dvEmhNcml6fsODAtOspLgUrOnw2z7lhXAMxCuWXNitMPHHxMIV0Kpf6fvlkqdL7ZhdlTzw0mZVkEVXl+QW/BYuMgBeDNuH4cISUhnU0BM60IU7/VBvZOVe8J/expQfrGQ98lfoRW77Wyshw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0q3/IAQ9ZA9ahhGglXa0OFodasqBIl3WlRRAXOb2Uvc=;
 b=Z68tc7HaA1POKxRDqZLj5Y9We+wEGTKUZZujl7AZMVPhTdRqGF3GNkCP7InHfcM7UUsNYIS0+NwllWP5R7EzGThxMJ1X0uQLVaHB4gj75PRNWeNHE9NpFszb6tTe6nM1DUt8hrH+hmZccYe0npIW8Uoyujcf03gWyOQz2nkdIBFd2Hj7L9kQi/smpA+dftzqmilZ27JD17l8QHIqHSqil0rElNWgpXUBwH7+NtpHsBIRSSdC7i0zexGwZ6aPUICc0WxECOFX4Url9To6P7mgF9T60YA0ysY+iVny2MUtAFhAxPg4ZE+fW/H1IlrYbewSSv/KGn/VN91FQNQPKNRl5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH0PR11MB4887.namprd11.prod.outlook.com (2603:10b6:510:30::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.34; Fri, 7 Jun 2024 05:07:41 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 05:07:41 +0000
Date: Fri, 7 Jun 2024 13:07:26 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Chunxin Zang <spring.cxz@gmail.com>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <jameshongleiwang@126.com>,
	<efault@gmx.de>, <kprateek.nayak@amd.com>, <linux-kernel@vger.kernel.org>,
	<yangchen11@lixiang.com>, <zhouchunhua@lixiang.com>,
	<zangchunxin@lixiang.com>
Subject: Re: [PATCH v2] sched/fair: Reschedule the cfs_rq when current is
 ineligible
Message-ID: <ZmKVjmuC4kGrUH5V@chenyu5-mobl2>
References: <20240529141806.16029-1-spring.cxz@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240529141806.16029-1-spring.cxz@gmail.com>
X-ClientProxiedBy: SG2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::14)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH0PR11MB4887:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8fb83f-efb3-4436-b595-08dc86afc1e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HPoEunOX/35/Lpsb7Ggns3rNIw+1lpCBVq35MnOK7Mlac8uihlsdNJ9echu/?=
 =?us-ascii?Q?vdv2sSeummto//9PaCbgspKlyn7RQYessaBZF21SnfTF1cr0mGbzbU8XYMD3?=
 =?us-ascii?Q?Dxej7diXNlqz2M6PNfqnEKXjAi5jKdQvCk/Lq6z2X5Q9tqZTT7aygqo9UU57?=
 =?us-ascii?Q?500KkUEGAGpu3KbgESDpX+zaKHIEK9Dl/g7TEUc7VVr5H0apTAo9J18rfIht?=
 =?us-ascii?Q?ErFfnLIbkZLwfLHjtiN39mNx/qoQ7HXo2RmYY0GiLzol7qjSROIeRwn/tb8v?=
 =?us-ascii?Q?anrJ1wx7rQnRd6To1rnMyly5Zx+nerFvTSWsbiz7nNJHn/YXAkYAnP7ESZgr?=
 =?us-ascii?Q?b/KTskjh0yDYLa6sf2zywkEVZ8xHtEryxVCOqClvnk4rxLxtsEtb/HFme57G?=
 =?us-ascii?Q?2NQN7VTZlx4pryodkHmx0f1pxJLqQAkvFQbFfg87Xxfa/Wf2f1x5C36UuCu1?=
 =?us-ascii?Q?gaCe6iVWMSveFAJHSiXwERL4fvGkf8srA1OhLRy8MN1IM56EJYzho1cmp2KW?=
 =?us-ascii?Q?MejQHkn4It3GC/6lzVQaKNoqQ8yQ0Jyh89hEBa8YYavkFJ1YcIvB0mvPnKR6?=
 =?us-ascii?Q?nFAqGEyGLfkpOhsWNuPT8S9e3qEz06ldSRC2ckxvbbwfrCvuFiNLQY1ZoMLH?=
 =?us-ascii?Q?xzoPyedk/+6cos9i+uu3PsAYnMe7cG1nbUXeBi2A12y8q7H7K7BaAZ6qBt3+?=
 =?us-ascii?Q?v8SppVQvBra0/NlZc/E44dfBLK5FwElOvv0omgCVEgLpRlPiDHc/WykKmarf?=
 =?us-ascii?Q?KKXqw8d4o85540mt9EMZ6G+uacCO3VjG8Tom4ocJWpahYeK/w8NaRbC7FmGS?=
 =?us-ascii?Q?H91B8K+siR0nm3DB8xtNHLWTbZh86uvk0FyCdMtSsR7PcSGQyRlwuPF8I4hK?=
 =?us-ascii?Q?w/cR/Es5aexPHUi3ESTRDLV5HGLCFOBOi4XmrBFSd6wQQfVuaZJCp2uKHILM?=
 =?us-ascii?Q?VWcxP5JClFM6Em+tdAK4o4NcSyCduw8dl+haygVQZaTlMnQANWhYnaCtmv6W?=
 =?us-ascii?Q?bGKYKxFf1lEwrtS7qwwH2NqBr2GVkr1+uALjT17KqqAC9bGjAsR9Ke16uzsc?=
 =?us-ascii?Q?rsJZLex70myY1/kQvzvUaB1i1Qby9UgQWlJXmIUz5DPmf+a/mvNAnhE3TZmf?=
 =?us-ascii?Q?AOC4+qLmtbrkBr9LlEtpgY/cTL1dooWbXnZvmDVFDpT0guVYKaqTVxNX76KZ?=
 =?us-ascii?Q?ukazeA6Y6H5+Mg0bdsWMf0a3+OLTlooL0iYw9DFp+iEeikPCVwVkwSo/zEzO?=
 =?us-ascii?Q?8YCmC894uqoLrk+8dTob?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pB4vbJseY1Fjzg3zLg/HPxKrb+oTx/2B8zfDBj0muape19iYNuG6gWlkIB0K?=
 =?us-ascii?Q?zSvhgmYZE0ksxGPIjPLnMbVFbDVZurvYm5846do+5b1iUQRebfs90HaxNazH?=
 =?us-ascii?Q?Z6uTU4TTBJ9WW5AzhlJSIgQCDhRm1yUy0pTqasYOFBw78s9ePDwpmFZdSr73?=
 =?us-ascii?Q?JvzCGfMd1Q0yVZt9tgeU12Yd39hgRJlfiBnolEqJo7zS2uC9Iistq8/KrwML?=
 =?us-ascii?Q?6AzfvZ6ZY8ts+5M4vdYV3BTry/VB6YNIGthONlXtSOJnylnQmSKX6+NGCmsL?=
 =?us-ascii?Q?fsfawYDA7O479TDTzwDudNq6CnTQdc5QLww9FitubAf4GhqKORX3HHSMmLzU?=
 =?us-ascii?Q?MqBC3zdAXgcNMXdW+mzCHmHgbzIVF4/qoGyp7k1S9P4tnSCnrtiy87Md6kTk?=
 =?us-ascii?Q?ChoF1mG3Hb4k9YluP6+aCiisPdt7pEbprvwCzeMEm0bbh60i73qqGaKK9vGz?=
 =?us-ascii?Q?0ftQIs1r50k11lzPoam2WMOHrTPa/1RlPp45hgceApKWffyvzrg0qE+WZ37f?=
 =?us-ascii?Q?GEiglkiVcfROYmuiy/eNx/4dhEYaTZgIu/VTV9kKP0hAjVK+Ft0PYQJ5eEm6?=
 =?us-ascii?Q?BrcFYtwd0RfNkx3CwJjjHnZyA5m1tyQJ9lNTqVc7WsEutvHKZQPU49pfAPBv?=
 =?us-ascii?Q?BJ1K8V2hZGksN3mId4WTeKajEI3aYuswLKHuMMD2sED8uFp/5htZTt8AnNEK?=
 =?us-ascii?Q?PIRlNzJdNxzOOGo0EdvS1sIFn9KXuybqYGDI5QuaVHpbfdUa6S5HHFAdAl42?=
 =?us-ascii?Q?E8RS9ceHp3Ho4ZdGVRXLnapBKfpCRUZikz50DEjq7fzEZRHQIcxJIFs1NjuV?=
 =?us-ascii?Q?mvaMbdcFacTY3kUDyysQxne6CLDCVDs+zlpEf16FfiO7+GFjLHfCWSrqqRPN?=
 =?us-ascii?Q?3nwF3mOkVISEi86ZiqmClS+otsCQE0vgAYKphklQ4LJDb1gBOtmXZ5ZKIQDQ?=
 =?us-ascii?Q?4mZdRKiwleERGDNbuwmKKCF2m7ubXMOqH1ogqAL2MjdcmHjdUWpCEWCoo+mJ?=
 =?us-ascii?Q?kJREIeE2dtAoW/R7/Q9ZyRJTJ165hq6TpVW8HXJah9opDvMt91xl0I5bK1yn?=
 =?us-ascii?Q?UO5nvO7azlZevS1ojP2w/gF+g+sbIeFE98MiCyB9hg0CKzYg/80hgMmNK8Lm?=
 =?us-ascii?Q?qVbAjuE9z0u/Rqqq8Kx3vonKP05BLLRg8IDgV9YFVb3E6gQRtcmuFezP+xwZ?=
 =?us-ascii?Q?tblqNLPSFMMCeN0+GmbmHZ6KzJKGHAgmYTHHAhgRur6O2pDnQRlJfYUDR2JH?=
 =?us-ascii?Q?5zRcG9BI39llDHsHE8AXMLMYtEJKuKPRlqfkBVWlUbVK/Y1dBQ5mresDybdM?=
 =?us-ascii?Q?S70tZssSphYsnSTlVEOiYMHE8rWrM3wNPnf0SqNLKORu8TcqLigloruwVGI7?=
 =?us-ascii?Q?pDy1SCmdFpFl0yaXCh9zorL6N3ORn+Pc7TxaDNZtE+9MLzTj/Y4rAxwQ8oOj?=
 =?us-ascii?Q?g2RVN4nVuiCvkQ1o9vxb/NAaFfLyeW70V3gVJJ40LlaIMgcnt5ZCCs/2DuAm?=
 =?us-ascii?Q?TjlMFc8gEmAh9CLQmv0XNcjiDJUtViXDCvz4R2YW05ZZulpRCwQR4lcejkXG?=
 =?us-ascii?Q?/BTfY2H2Q2CYsHRhS7xAAti0TR73b0repIlv6jJy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8fb83f-efb3-4436-b595-08dc86afc1e2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 05:07:41.1129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kL0oSyOWTA4FzV18cPtFygsqGBYakpuWzDAGFWFloMfDuA6W3lc9Y7FHKIkdpbvKw9L+wInErPzxmZS7QFMbTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4887
X-OriginatorOrg: intel.com

On 2024-05-29 at 22:18:06 +0800, Chunxin Zang wrote:
> I found that some tasks have been running for a long enough time and
> have become illegal, but they are still not releasing the CPU. This
> will increase the scheduling delay of other processes. Therefore, I
> tried checking the current process in wakeup_preempt and entity_tick,
> and if it is illegal, reschedule that cfs queue.
> 
> When RUN_TO_PARITY is enabled, its behavior essentially remains
> consistent with the original process. When NO_RUN_TO_PARITY is enabled,
> some additional preemptions will be introduced, but not too many.
> 
> I have pasted some test results below.
> I isolated four cores for testing and ran hackbench in the background,
> and observed the test results of cyclictest.
> 
> hackbench -g 4 -l 100000000 &
> cyclictest --mlockall -D 5m -q
> 
>                                  EEVDF      PATCH  EEVDF-NO_PARITY  PATCH-NO_PARITY
> 
>                 # Min Latencies: 00006      00006      00006      00006
>   LNICE(-19)    # Avg Latencies: 00191      00133      00089      00066
>                 # Max Latencies: 15442      08466      14133      07713
> 
>                 # Min Latencies: 00006      00010      00006      00006
>   LNICE(0)      # Avg Latencies: 00466      00326      00289      00257
>                 # Max Latencies: 38917      13945      32665      17710
> 
>                 # Min Latencies: 00019      00053      00010      00013
>   LNICE(19)     # Avg Latencies: 37151      25852      18293      23035
>                 # Max Latencies: 2688299    4643635    426196     425708
> 
> I captured and compared the number of preempt occurrences in wakeup_preempt
> to see if it introduced any additional overhead.
> 
> Similarly, hackbench is used to stress the utilization of four cores to
> 100%, and the method for capturing the number of PREEMPT occurrences is
> referenced from [1].
> 
> schedstats                          EEVDF       PATCH   EEVDF-NO_PARITY  PATCH-NO_PARITY  CFS(6.5)
> .stats.check_preempt_count          5053054     5045388    5018589    5029585
> .stats.patch_preempt_count          -------     0020495    -------    0700670    -------
> .stats.need_preempt_count           0570520     0458947    3380513    3116966    1140821
> 
> From the above test results, there is a slight increase in the number of
> preempt occurrences in wakeup_preempt. However, the results vary with each
> test, and sometimes the difference is not that significant.
> 
> [1]: https://lore.kernel.org/all/20230816134059.GC982867@hirez.programming.kicks-ass.net/T/#m52057282ceb6203318be1ce9f835363de3bef5cb
> 
> Signed-off-by: Chunxin Zang <zangchunxin@lixiang.com>
> Reviewed-by: Chen Yang <yangchen11@lixiang.com>
> 
> ------
> Changes in v2:
> - Make the logic that determines the current process as ineligible and
>   triggers preemption effective only when NO_RUN_TO_PARITY is enabled.
> - Update the commit message
> ---
>  kernel/sched/fair.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 03be0d1330a6..fa2c512139e5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -745,6 +745,17 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  	return vruntime_eligible(cfs_rq, se->vruntime);
>  }
>  
> +static bool check_entity_need_preempt(struct cfs_rq *cfs_rq, struct sched_entity *se)
> +{
> +	if (sched_feat(RUN_TO_PARITY) && se->vlag != se->deadline)
> +		return true;

If I understand correctly, here it intends to check if the current se
has consumed its 1st slice after been picked at set_next_entity(), and if yes do a reschedule.
check_entity_need_preempt() is added at the end of entity_tick(), which could overwrite
the police to reschedule current: (entity_tick()->update_curr()->update_deadline()), only there
are more than 1 runnable tasks will the current be preempted, even if it has expired the 1st
requested slice.

> +
> +	if (!sched_feat(RUN_TO_PARITY) && !entity_eligible(cfs_rq, se))
> +		return true;
> +
> +	return false;
> +}
> +
>  static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
>  {
>  	u64 min_vruntime = cfs_rq->min_vruntime;
> @@ -5523,6 +5534,9 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
>  			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
>  		return;
>  #endif
> +
> +	if (check_entity_need_preempt(cfs_rq, curr))
> +		resched_curr(rq_of(cfs_rq));
>  }
>  
>  
> @@ -8343,6 +8357,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	cfs_rq = cfs_rq_of(se);
>  	update_curr(cfs_rq);
>  
> +	if (check_entity_need_preempt(cfs_rq, se))
> +		goto preempt;
> +

As we changes the preemption policy for current in two places, the tick preemption and wakeup preemption,
do you have statistics that shows which one brings the most benefit?

thanks,
Chenyu

