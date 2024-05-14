Return-Path: <linux-kernel+bounces-178590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F11B08C5201
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 13:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AECD28296A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 11:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EDD1272AE;
	Tue, 14 May 2024 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y++PrCAI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F195A7174F
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685324; cv=fail; b=fSiC7jFjhl3jzqsX18z++dR3OGb4jVu+0yAnQwgTBXNc8Ijlhf92ktDMhHn3PFT7Rv4Tq1WVJebyeX35i/PobTaHSyV0G5LA5G0OiBuSI1lE97pZmZrpyxC6dCJUZQCvW78dOz39Eag1mVblHkZT+9UDlBvAvSOMUl1P5NuxcJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685324; c=relaxed/simple;
	bh=YKjtDShw1uyiod7MM7RWIUxdHKooop6rtzaw1TzIKDQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=buXXbY710VVVShhbnUq+nSFOFN6zOWJPeLd1gqBBP3asYVFg1OmZRxyxtNOwcEV10SHhRKuCGlvp+VLBdyxKfIpf5eO5M4Jd22GSVF83fp1Q2zIxE19xBjD/q6EOxfN4DcHcYzGgsYwdT2kYDMg/HpUNpt8OfUX/v0x0tl4Y/rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y++PrCAI; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715685323; x=1747221323;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YKjtDShw1uyiod7MM7RWIUxdHKooop6rtzaw1TzIKDQ=;
  b=Y++PrCAIGGvpggNhd785fhBgLTG/rap3ykwQLG3/QbFTsJ2rw/5fQH0/
   JMiYHTuNltLYptCtz+f51MqLQHVUJV5KH0chNm6rkQvCpZx1RTJE0Lz0M
   dccEWLqq9it3I9xyjUb6pg8GIvo2UfPH60ba4NQX6Uuh8RwqhQ1mkIZPL
   UT+0idBHuOzbqoWrn4iB3L/8Xe+vjlcY89w4qGe2uxrynuc/fpLzVzygU
   ent8/ti+RHHBfuYevfzBfu+dns6zED4jwC2EzaotQkrusQN/R3r7Yw+i+
   3tMA4ee9lwFbDcV/0zBbUM9XvEqZeCxErP9fIpQKfJaOwIy9wgc5deQcX
   w==;
X-CSE-ConnectionGUID: GWedc5uGR/KaKb7MLpISng==
X-CSE-MsgGUID: ydIUGN1jTMiruauXTwgdAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11826042"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11826042"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 04:15:22 -0700
X-CSE-ConnectionGUID: YlL1Vf6FSMyzaP/IsM944Q==
X-CSE-MsgGUID: ttHX3rZ0TsKd/fz+o8i4bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35542788"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 04:15:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 04:15:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 04:15:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 04:15:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DX5EInigE9UuaLIDXiKnejcVMN5i8Ser/RhAMuDJhaDSfyos/E1f3dsJN5t3UZLsiVXQKg1mLzPT4/pwGVXC5LdotGdxt1U33Ej09tqiYRlt0jHQ6HJvsIyFrTOlvZpXmp6P/0FlGCtct4jg/vnDFimIVG8wOOJFf1HzkAgn/uiuGS9ci2eW9WcGteWambGq3PRtKMfeF1KbiyF9KuH699M2LzZmOaOCwRaqq2H6mpVY2QHoKSZtYnXsZFN23AhArnVK91oCH/PcBwBF6cUhAP76BbKrOs97muMDS6plUk1zucpN6py5sT7jHMmTR2gA4PIZ2dtphHKEaHGytSFJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5FzGOyrIo9L3UMD/ONfZ8xc2Yvn4b349jLMlbIvVeM=;
 b=LWHLWDF+YO17LJaCPynoZrhgz4yXpFiQvxgq+KlZaMy29LFL4yf5UfInI86ZfJy5GzDyjoUb4dnxN+6KAzHIAu7GqyKvGR7TN3/Wdl2UNBVqBrZ6wv7BG2kk4y5+KW6qrc1Dv8U1gZHFLq9NqvaWw1mG0NxfBBLZ57MGvnWmllKJAFBilnAfGJMbAhXuQfrdqkvBHG3aeMiixjbOHqJNwWxF+KxCFc0j9TVxeXEMW6vEZBizTPu6or4fmB2Y3Wdfouq+ZeZi6D9bRd0yn11oQNtz/DVHEAQSAb1lB7ZuPs1W0RXrT+Jy5Y4XFcmuyqjTphwnWWyoTuqNmSZDmFBKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA0PR11MB4701.namprd11.prod.outlook.com (2603:10b6:806:9a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Tue, 14 May 2024 11:15:19 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 11:15:18 +0000
Date: Tue, 14 May 2024 19:14:58 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
CC: <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
	<peterz@infradead.org>, <torvalds@linux-foundation.org>,
	<juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<vincent.guittot@linaro.org>, <gautham.shenoy@amd.com>,
	<sshegde@linux.ibm.com>, <kprateek.nayak@amd.com>
Subject: Re: [RESEND][PATCH v3 1/1] sched: Report the different kinds of
 imbalances in /proc/schedstat
Message-ID: <ZkNHshuGhY6nBGmJ@chenyu5-mobl2>
References: <20240514044445.1409976-1-swapnil.sapkal@amd.com>
 <20240514044445.1409976-2-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240514044445.1409976-2-swapnil.sapkal@amd.com>
X-ClientProxiedBy: KU1PR03CA0035.apcprd03.prod.outlook.com
 (2603:1096:802:19::23) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA0PR11MB4701:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb363b6-b21a-466b-45b7-08dc7407235d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rfXv8/a7rBQcQ80bsdBOyyB+7hla1n+DHxGSrzQWbswiRu4JSwDyzN+/7NK4?=
 =?us-ascii?Q?jYT0O43nhFttvEm12puKrggHoTzA6AionOppT2U53wTh7DjVX6nVk8rsuwie?=
 =?us-ascii?Q?1S5tEekqP1ILoMrgIfd+zTX6etCFbGR0puVZiHDwp6rSEErALHx8f7yC4Dxd?=
 =?us-ascii?Q?lML/TxHRaHH7i2RLovV9Af4k5FvsoDnzajllMBI2lFE2F8h349A61VUJJBQW?=
 =?us-ascii?Q?Q4bq67nsMKBAB7os3V9hfCQmJ9SKwUxjfFGqRENQ8N0bA9c7wB3S0JvkbGYG?=
 =?us-ascii?Q?7lnN2AMORIMCXFU75tzysKKFLEfi+mVg+EaukrbtmG+s0EWhskJEZZdL827M?=
 =?us-ascii?Q?tmcwxLRow0y82HiQn+3Kxv+/LxArRDOrZIZ7UYV1wdcxhGI8YFrZkCOXyuJ6?=
 =?us-ascii?Q?4KWAuLWntP9hf3WpiwYj4jrYYUmPAWBT/KuQw1fQPtcaAoia+xEO/ta8l6Qt?=
 =?us-ascii?Q?MoiKeW+NsD99qpVQ/mB00VnCDl3DAC3Re5sSuvmmVcGpvtHri7tHQ+Fur7zZ?=
 =?us-ascii?Q?9tMahKtsAdwvRxOb3XvOn7nTvVqPSe4md12nnbma58oO+qCKpY6+WZR5owp7?=
 =?us-ascii?Q?HqVm3vIc1lHPYAcgJVp41DaLrvWVZWfAydk25XQARXhIHYa7wSdVqHnPtQqN?=
 =?us-ascii?Q?VPAJ9t2RFG3rgB0H0c2vZEXyTU+7I8LoKAnx9D5V00OX9uGus9rA4LjGOZty?=
 =?us-ascii?Q?AdpV8V40w+cjn27lLJMHNr6dMwtwaTtTXYcpfsLIhwjYzOkkcCpY7sqQ9uYw?=
 =?us-ascii?Q?Ddj4YgLLwuhn+lCufh/zVla3FoxHMM8lwv68KV+/tj1boKzl30hx+wWrDRfc?=
 =?us-ascii?Q?X8IOuT46hptl9exzuU0EmUR4pkIAJXm8HRToMNFL2JkDLAa9n/oCdBNfsUI9?=
 =?us-ascii?Q?n8Mn90MCqh2M9Xwzm+4ecYqMYFAYFckIqHqWa9Niu/3C3SjZmKNfpwlj1isQ?=
 =?us-ascii?Q?q4FCpndsGlu+T6zeLLmo0Rbb7Wj8Z8UeNlzM92/cyFF9JutDCRPj5O1798oy?=
 =?us-ascii?Q?lqmlabJH7yCF1CKiw5fXG8Glx4rbelxDSGBKdYIFHwls80EWEDt3kAk0QBAL?=
 =?us-ascii?Q?0RDkMbqlJSkEablXjvrHcdOROcZXEamTosT3Im8U/i4/F+nwnGuxP6pyxY11?=
 =?us-ascii?Q?RAvPLw/Uzo/Tgu6tW57iOBeL8nSFDTuPTqrcFmKAItpRb+/Wncd1HIHdW21g?=
 =?us-ascii?Q?Wvxjb3L/FsLIyO5uAr/WJmVhiwwtrVpzYz6XjQPUEPomZXPJOwS+FE5fk+MR?=
 =?us-ascii?Q?zrQWjAg9Vx2hx0lAsWryPOdL6k8XrezMLFmToG7xWw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nmKR00iYCPY0oiF1Pf6aSQ3gOfdZo2pu5HYVQMFRTm7tPc+hgmBAaFR18C1F?=
 =?us-ascii?Q?s1Cuy6mx404B6j9EMbXpqaKDmERXL+RuaFySVRPcnAoRh7NFRw/bmlXxSLs0?=
 =?us-ascii?Q?S0BN0bjIg8PFSTfsU9dpDyoefz36enq3j0B9OrnSoUZ71aG6zc+D/eoVL0c1?=
 =?us-ascii?Q?4pscVZcoRSTmlvlsA4MKY9iohlZ7zdKlvvmTSA0evZJT0dK97+ymnThu9o+H?=
 =?us-ascii?Q?o7PUoSri60QY9hQgyAWatMzo7Ms9De8HSWcqYRF3iFJ3iJB4Kb9jzYBkyHNs?=
 =?us-ascii?Q?eFoBO6267UkBJpuKgMvtgCXmNyAcrUmEvVye62SC0fXefkWWBL73cis8mR6N?=
 =?us-ascii?Q?pQ28uGuEiDjpLQJWKeod9W1xVh6oYStL209QI8lgQSGdz+hrNv6vTZdrkssh?=
 =?us-ascii?Q?/MqsT6mRCK6P52Cmzzh02BZJQamElq1hyCeqqdQ0oThMExqj+f8PUZoy7dPK?=
 =?us-ascii?Q?OVM3wsbt3dsK46n5QzqsJ/BB1GUcYURUgYVoF6wI9FEOPvZcwvyFwUfdVqtL?=
 =?us-ascii?Q?EOUBDSmjuTSLr5arX/y4hq4byGf8yDoYIJT3sr4NbyOkws2CfNP092aRSErI?=
 =?us-ascii?Q?uemCLplMs84sw5bMDR2tI9KSUDg2wK4WdVk12auV7Q+DeoHxE+2kfglHggc3?=
 =?us-ascii?Q?yiNXU1PojZtbkVsB94XTZ8ggbBOhhCZdiJh09aywMqtU8bv8W1SYFFk2cORL?=
 =?us-ascii?Q?A4YFCRIQifIKWlwM2GPAwaNncJa4kQL21XNuf8nnWYRRj56X0jTFYsYB5jqE?=
 =?us-ascii?Q?OofNeaI5zglYBlW7c+G1K+U3aeBVbzYEjLbqmQv+crTj1lJf8kJOtkRpG5IX?=
 =?us-ascii?Q?5PlvB3S7WGBItJ/M/GBDr4USQq3zC9Deknp1aaSFibTwS7zhnsWAwtRdJMG/?=
 =?us-ascii?Q?Sz0mV/pHSLv0g+j/qooNeaGKK03phRIlrg26azvnnIYcDTjLTw8Dli47wDwe?=
 =?us-ascii?Q?qjcrCIQ2O5Ayvwd1eOW292+VYCll7pK3P7r4Lqf/EdJVH6cjcUjVzwGKQBzf?=
 =?us-ascii?Q?2c9lGe1jZksZUMdgtS29mj7OWlrJrsrGqv6tJCCsMsX3ICO0Fps42KZ/XnXo?=
 =?us-ascii?Q?AeAuUbYjFzI7oVNBu1rYdP/AEpITv+Dv6tdBcVTm13jU1eDzU2hN+RInCA5W?=
 =?us-ascii?Q?oV/b7DDLllbQs8eFG+o6hX/cbIMwsaxb8w9GRpGWgndLzLbZFgflw1OozZw8?=
 =?us-ascii?Q?rkNRhsCTUic4E35MPJx6MI8huZoqLW3tEV+M0xvMN9xb5shzhSLTMRfPhdpU?=
 =?us-ascii?Q?jkxBa0jI/TBR1bqKqPO+9mBAKb+1Fg3LF1kdszvWL8wCmyEtGhwH/+faXvH+?=
 =?us-ascii?Q?HHM094xh4j3iO8XCVDiyyK4ciAv29uGnNWyvC7NKDIqLV9FasbM9um3dpQ3m?=
 =?us-ascii?Q?Yccp9UnS0qUd+Ny1Zwf+JEHCJm6H5CYaBDLtNGmdzLG8kZFXu9miiC2IjNZt?=
 =?us-ascii?Q?FfPoktCPw1Beuie2kYrjt+wSSLnCBTTwV4SF9N1weVs+N/KToEyt5igct1lF?=
 =?us-ascii?Q?SfkzBq+LOhA3zvKHOb6qHob8vuzGgyHB0RDaUkB9hfIZ673CytwpcCIGawYD?=
 =?us-ascii?Q?D3eb7g9XD0GYoR8EsRw/tIr93QOmgQzW/Z9npLej?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb363b6-b21a-466b-45b7-08dc7407235d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 11:15:18.8305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvUSsY2PZvnnPhkcJXXMKvtRqWNlovNYIAgABSc9NTY3O+zgEu5By8ik3DVGAV5X9HhVkXZGBijAOkMiPfmr4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4701
X-OriginatorOrg: intel.com

On 2024-05-14 at 04:44:45 +0000, Swapnil Sapkal wrote:
> In /proc/schedstat, lb_imbalance reports the sum of imbalances
> discovered in sched domains with each call to sched_balance_rq(), which is
> not very useful because lb_imbalance does not mention whether the imbalance
> is due to load, utilization, nr_tasks or misfit_tasks. Remove this field
> from /proc/schedstat.
> 
> Currently there is no field in /proc/schedstat to report different types
> of imbalances. Introduce new fields in /proc/schedstat to report the
> total imbalances in load, utilization, nr_tasks or misfit_tasks.
> 
> Added fields to /proc/schedstat:
>  	- lb_imbalance_load: Total imbalance due to load.
> 	- lb_imbalance_util: Total imbalance due to utilization.
> 	- lb_imbalance_task: Total imbalance due to number of tasks.
> 	- lb_imbalance_misfit: Total imbalance due to misfit tasks.
> 
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> ---
>  Documentation/scheduler/sched-stats.rst | 121 ++++++++++++++----------
>  include/linux/sched/topology.h          |   5 +-
>  kernel/sched/fair.c                     |  21 +++-
>  kernel/sched/stats.c                    |   7 +-
>  4 files changed, 99 insertions(+), 55 deletions(-)

[...]

> diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
> index 78e48f5426ee..a02bc9db2f1c 100644
> --- a/kernel/sched/stats.c
> +++ b/kernel/sched/stats.c
> @@ -151,11 +151,14 @@ static int show_schedstat(struct seq_file *seq, void *v)
>  			seq_printf(seq, "domain%d %*pb", dcount++,
>  				   cpumask_pr_args(sched_domain_span(sd)));
>  			for (itype = 0; itype < CPU_MAX_IDLE_TYPES; itype++) {
> -				seq_printf(seq, " %u %u %u %u %u %u %u %u",
> +				seq_printf(seq, " %u %u %u %u %u %u %u %u %u %u %u",
>  				    sd->lb_count[itype],
>  				    sd->lb_balanced[itype],
>  				    sd->lb_failed[itype],
> -				    sd->lb_imbalance[itype],
> +				    sd->lb_imbalance_load[itype],
> +				    sd->lb_imbalance_util[itype],
> +				    sd->lb_imbalance_task[itype],
> +				    sd->lb_imbalance_misfit[itype],
>  				    sd->lb_gained[itype],
>  				    sd->lb_hot_gained[itype],
>  				    sd->lb_nobusyq[itype],

Do we need to increase SCHEDSTAT_VERSION to 16?

thanks,
Chenyu

