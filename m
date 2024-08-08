Return-Path: <linux-kernel+bounces-279219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ED194BAA2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96781F22589
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F276188016;
	Thu,  8 Aug 2024 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dIkODin9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DAF12F5B1
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112178; cv=fail; b=TvgwGVwOVjvMrVmw3II41sbhHuc3rWNEMcnJFVKsNPrLOQIPcQBinReOowoenhvULiRn5EwI2ZG2kJUE62a7dqhTAfv/5Hc27zynRYMiBJyYrmlVbFSmWs6sGClj0Oo5UYspjXrRrCHS3aVhrwqY24OenM2ZMQkorzY5iWTXR7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112178; c=relaxed/simple;
	bh=9WpEtLBj8mKnuyafM3aH0m0/8JK1YVyidfLAMCeifhA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jk6kSK3uZBKB1mcf8X+yJJgCgevUpb1ZQPQLkabLBCCJVi3N9qAmdSi1TVOY2/qsmSbPnBn2ocxA/29JBmNeGQiP+DjBw0pmPvGaLTXgg3iun7m0vMKfev50TQPZiQ743ZwFNVpdqOvEBjDpYOsMNpFTYhqIQC/s0Vje5HF48Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dIkODin9; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723112177; x=1754648177;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9WpEtLBj8mKnuyafM3aH0m0/8JK1YVyidfLAMCeifhA=;
  b=dIkODin9x6/MMNZamztr1v2U6rCaIQRXCG7hmIBHVU/PTsbYXZYRPquB
   xBVPBMQnavIuU9tWhfuyhQSBdA/dMk3bQHAIA8jCRR6uhou16ESpIi95E
   YjAg7YiEVuDagpffkLOCOpR55UWi6aZlyLuJ6f1s9jJQ72ev05Pj3paQg
   RzwsjI5JKQeguMzKxJtOLaZn2jZTRq9poEhvX5IPm83R686LdXqM+7TvD
   53xLroIz22A3YvmDHREI1AOrkf9RvaVlC/VhVJvZNvRGZ4FmmYYkdXWQc
   6XFm8ERNEfM1fVVJKuK68BeVnXcZOZZovnlr3lWq8uA9ohWcsQGhHsWlW
   w==;
X-CSE-ConnectionGUID: dh3vr+ESQIG+7L8CHqre5Q==
X-CSE-MsgGUID: Hi22TR/BQNyXPh0LwXDovQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21347125"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21347125"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 03:16:15 -0700
X-CSE-ConnectionGUID: oiVDTTVcQWy7D7m7TaFxCQ==
X-CSE-MsgGUID: 2Sttn0xST52K1crXMGB0ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="61271280"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 03:16:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 03:16:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 03:16:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 03:16:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 03:16:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSPu7M6ngy+b7k7Z7FzX45xaZks3GV2LknsxvQyfC6DI7hlR+ExIERFLzXs7jvVNCNRwgONrC3C1Q1KMxvZTAkyRJMhsNe7wXMpZVv5XyqQnr9+itPJGrgOIDXVy1PFEf8lh3xYE9h8CF0cSGbczHVO5DXl1iUBw+1DUx60McIzKeHt+XTVmt+shWPOdjpNqbnBNnArp0sCcSdK2uHtuV2/QSvprBxAPkdPz5Ck88y7y+q5zDH28kHV7AU0v/B4EflmuIbfvASKQkoVDjxTjPmP24mEhB0GWa+VTS2788gXayr0vBJqLdITNWQ1r4KcXj6TNnZT8abHPHmebJWxFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AeHjFdVMb9gq1VnduwhIflnf1eqri/W8RohwTzF3SA=;
 b=ap5JECcQMQtJz2eSyGTWWHKeiNr7uao8lLOdjxLPwtP0Q6f0SFnxyt7AL9o5YUytdZYHimV8mSyd0yJ6RirY3HYmfTnkY6dxetfKRX8zp4X/pFcDq9CZFnxzyvezgq4ZpQOvIo5dnxlNkkchtXkQbTXzh/GcKEoY8guvpCi4jT8knvZurSSk74V5vQf1QkJrHk84oCrw+yzs/0IyIev/pDaJn3OHtKvvUXaElw+bgDvsFWbg1YTw4gtDzWC8ShES+wDCpijL4u/ERVsXss1lvK5v1zOzkquT1zvBZPcrS92D9oVKLnj8czXu+tFEU6iMOngwxa4WZar6OWX0dTT5kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS7PR11MB6127.namprd11.prod.outlook.com (2603:10b6:8:9d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.27; Thu, 8 Aug 2024 10:16:06 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7828.024; Thu, 8 Aug 2024
 10:16:05 +0000
Date: Thu, 8 Aug 2024 18:15:50 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kprateek.nayak@amd.com>, <wuyun.abel@bytedance.com>,
	<youssefesmat@chromium.org>, <tglx@linutronix.de>, <efault@gmx.de>, "Mike
 Galbraith" <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH 21/24] sched/eevdf: Allow shorter slices to wakeup-preempt
Message-ID: <ZrSa1uxiL7G8PnWm@chenyu5-mobl2>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.735459544@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240727105030.735459544@infradead.org>
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS7PR11MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c3b0c5-47e8-4490-7a01-08dcb7931d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CuFxFzV3FQemZ+qVJL1DVvoO5cQ/lAYrIJvXWMwjYb2LbYEbJwnYL7zBqO/i?=
 =?us-ascii?Q?Um1DaploIdv8YsJH58kz/qxwSNdJ7xMyqNJ31iSiUaQdGje6lN6pACQsYqK0?=
 =?us-ascii?Q?I/2H33UKp8GWYVwIhSbW7jZ3ur1/TS0raNNB+H224HOR4i3JBJiY3LGT9epv?=
 =?us-ascii?Q?M0zB2NvjZdePb4xCl7fyU7uGd2GqGY9ouQhfVy8vK8TWeXAagleo1AUG3iqt?=
 =?us-ascii?Q?d+IzWbqDoV6DlvSdcOhtMNWrkGQbGofczXFr0dRB5vq1TzCZcuE/sZR7tblc?=
 =?us-ascii?Q?J4kfLrKtUgWN2Qt4ETZdD4jeI3UBkojw86veEGHNxWVkr1hyp5XmbRQKDa3r?=
 =?us-ascii?Q?e0JBjCcADP1a3pfs6LXYpsWT5FZes7DJWiM0+50hqI4dhg4hXWdY3nTQfYeG?=
 =?us-ascii?Q?pbAUGYpx2Fe8bXTYB2Uh0HhHlnplf6pLTUEDbzaLgFXBUVNOR4UjG5V7R2Du?=
 =?us-ascii?Q?yj0EHnP6+OOKu4OIufx0/Mt0Q1xNUCeVPDtJ2XT4lEAqCBAOlyiLHvEdORBA?=
 =?us-ascii?Q?c1V/FNrXISFuN8edo2SoUQ0+t1chceGj+410pMhpVrqP/qkSb2Le0Mhxx7eh?=
 =?us-ascii?Q?V39nwc0MXIjMcEHgf3qkAwafvmmvx6rTbmBXLbYWLezdZ8WwL36VCdnKNTHT?=
 =?us-ascii?Q?XQlrg4rff/ATn5smie4x30fTJzdZQWt5pT2agdn4gkd/MgKSiieLL+VVqxWD?=
 =?us-ascii?Q?lTVLx0FfLTmRoGyhAujLk3gwi+24OBTAvAurB6fDFjalnHARA5hr0+mci6fq?=
 =?us-ascii?Q?pKwzVLHHCTdoGuVffmzhrgasi4lG9ditntQdUj0ZaTq3OEQnkKs7uL8oeZ54?=
 =?us-ascii?Q?ITyKZ049jWVbV7lQlNHmdawdJOeL030WKcHxiMimmXh9iEIMoSTqctqtqA0X?=
 =?us-ascii?Q?j396zWPJJhkRjdK0rWw1mf0/dTRcf3jCvMORLlmhCDSIhf34QItq+ooLxpAN?=
 =?us-ascii?Q?0Wc7+QAMp1P2A7EwFPavvZ6rjH9myr/m+6DoMKs2NUBpBMpt+laRrofcXo+C?=
 =?us-ascii?Q?fm8Tx34o2Qv7fchF2RHgyjl7R+dBZ5Ge9d6TueEPHJs3MwKNEK+qt0z9ptxD?=
 =?us-ascii?Q?mmm5A4pFYrp6K3kL99Yu5OAC1TXWQZinepbQvCcACWaz4wjSn0ns9M2kwnhq?=
 =?us-ascii?Q?ezeQxE8CsqRo7EfTjEG9qj55WmXkP93OXUc3Y/Jbtqugr9Ap0XD2MGQCMRa4?=
 =?us-ascii?Q?I43Tujyv0ZutBVoEk6AnN0LKj8z1E7T0tjV9vxmLxaH6bPuMK9auPbLrfwXW?=
 =?us-ascii?Q?juqfSMYM1TQuF/y+Ap9/KKg9Jyaaz+Y56Go0hLU31W7Y6mE+Ub2MmVXFW59P?=
 =?us-ascii?Q?30I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KDOJVS2GFa+/q2KDbZM+VuKawLg0p0j9WSoZFV/ML9PsRuHoi8FJnKJvG3or?=
 =?us-ascii?Q?z6uySYexHyL9rAaZjPa7Ou5maPUqN7CYaehwthc4h6JKti6AFWcdOA2Jlbgl?=
 =?us-ascii?Q?t/r8JRCpfiNkNhlpIn7XXEAMRUgsRPPp2FkLoh1EuwAe5M+zyy078ny6u0P7?=
 =?us-ascii?Q?+/fjQdFaECXOzmW6H5cJN+tdJj4VEyuthn9mVaYU3URFQfzOnMZvg5VV0c6C?=
 =?us-ascii?Q?npzm6yq9Xw6gRHmJsy5GgOoGZ5A2uV4W/yG0hKUvkU9ihSWCKUEU5SbgoqFY?=
 =?us-ascii?Q?jPesynDEoz5yKaOnVAbgM+6B06/UER0Bc3piWYewsOf1yT3y5CNlP0cASIh8?=
 =?us-ascii?Q?QHZc28sGjQS/IIFvyuD1WUdS2doyNcBlIqChJml3tf74LE71gn9TdzY7yfsM?=
 =?us-ascii?Q?uRtq01qWFYfO+Ui8MoiDscxtupFdV7C7fmR18DzFdFClGtHielO6y1X2fTRF?=
 =?us-ascii?Q?QdWn5uH+Y92/q6rMJKtBMosIskKspMQAamvzntiIgFA2nugyd37jGnzHqXWz?=
 =?us-ascii?Q?R3Lrr74ODfpgRZL3Jr0h6sISqz7gYFZaA6AYs52/Dbw8NTjO3OWfzl4amnvH?=
 =?us-ascii?Q?E27bY7zsoH0QZn0TeRc+794jE2BjeOuo2TxGTH7GHekRZNwAqEwCVYirEp07?=
 =?us-ascii?Q?nQ3jzcNpj4BvgWqpGknUkIBNeEoUwcqkeIEEW37Xt8vdyWVGjRnFqyuEwYjT?=
 =?us-ascii?Q?H8xGBcAQZ90A7ZKBNXJn7quVm5PumuWp5s5np80dwA5HmQPZq8IeD++y1H6m?=
 =?us-ascii?Q?Rhza3PAzGEVTiBNOqYRGrOTEefynAC9dvlllbIkGUCZnOT5JnRqEJvu+XkRN?=
 =?us-ascii?Q?W1a0b79DTRzRbNJfW4+3Oo/65Yru/Nvn4nwzYRG/TGSbxv8rV76vdbCcCIh+?=
 =?us-ascii?Q?e5hm21K99jtlUhSWjaHB5fQs0mFJFBZUmqBptfsY2Mf9R4vhjAqVnxarjNTI?=
 =?us-ascii?Q?2O2OKu8/8MRffsyBpDkteI9MsEPWU7o3ZQcL7IhcLrt8Ak8zO+dgGoqQA/5q?=
 =?us-ascii?Q?TRp6VUCw1FiPkdagNiSj8TbtmgYKcrdgi3tVl2ob+sEDOfG/6PGU/fwuUAis?=
 =?us-ascii?Q?nt3gCY2/dNljFH7obreL5LS4Uacvx4k81Peh/bXZ8FJCNyTOlUU9UinPVZwP?=
 =?us-ascii?Q?b11G7bBZowt7SLxitsZxTHJFHpmiu8PeJavvKTmD1hyRpoRUkTtDWYLKrQfW?=
 =?us-ascii?Q?qNZ3UWBlQ8M4ej9EAAQT2gtE9FMNYo6xB1KP0h8fxhcsDus5jbodeiGsoB9o?=
 =?us-ascii?Q?BbXmMr3Fx/uJZ8l/7U0q+izOKhBi3ZlzLnkrd49SoLAK67NFdf7xlfDF1BMp?=
 =?us-ascii?Q?rdaTCZEXRtB6a2xBF0hyqklAr+pahcfnTYIoo+MRICDoN8/H4VvdwRv9fPwd?=
 =?us-ascii?Q?BcPpXtxxe0rTzNVUV9sA9AzpuFyumRsDHYE8FP3vAjTbZmGCvYI7elHSwSn1?=
 =?us-ascii?Q?lBvMultytjqNrtgDADOnLJzHMsnFaMP/QP28B9Y+x3tLAw3NcHQznfTJGsVQ?=
 =?us-ascii?Q?AbIVJJ1RZFpK8R9Q/yynPJmp/jA9DHUVcROE4jADdvcgX+C6P380jZlk83SL?=
 =?us-ascii?Q?zSqa+FN0aW1dn7bXSrg8Zc6l+F8goU1zU5m6rQBb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c3b0c5-47e8-4490-7a01-08dcb7931d34
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 10:16:05.9114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NJv+/KrtxqnDVGIjCkLUYB8OdaWUSC6xqV9fIEjMQrYO83hLl/EnueK+EmPPg47GtrWV2zr6ZaRwL1RJ6Xz1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6127
X-OriginatorOrg: intel.com

Hi Peter,

On 2024-07-27 at 12:27:53 +0200, Peter Zijlstra wrote:
> Part of the reason to have shorter slices is to improve
> responsiveness. Allow shorter slices to preempt longer slices on
> wakeup.
> 
>     Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Sum delay ms     |
> 
>   100ms massive_intr 500us cyclictest NO_PREEMPT_SHORT
> 
>   1 massive_intr:(5)      | 846018.956 ms |   779188 | avg:   0.273 ms | max:  58.337 ms | sum:212545.245 ms |
>   2 massive_intr:(5)      | 853450.693 ms |   792269 | avg:   0.275 ms | max:  71.193 ms | sum:218263.588 ms |
>   3 massive_intr:(5)      | 843888.920 ms |   771456 | avg:   0.277 ms | max:  92.405 ms | sum:213353.221 ms |
>   1 chromium-browse:(8)   |  53015.889 ms |   131766 | avg:   0.463 ms | max:  36.341 ms | sum:60959.230  ms |
>   2 chromium-browse:(8)   |  53864.088 ms |   136962 | avg:   0.480 ms | max:  27.091 ms | sum:65687.681  ms |
>   3 chromium-browse:(9)   |  53637.904 ms |   132637 | avg:   0.481 ms | max:  24.756 ms | sum:63781.673  ms |
>   1 cyclictest:(5)        |  12615.604 ms |   639689 | avg:   0.471 ms | max:  32.272 ms | sum:301351.094 ms |
>   2 cyclictest:(5)        |  12511.583 ms |   642578 | avg:   0.448 ms | max:  44.243 ms | sum:287632.830 ms |
>   3 cyclictest:(5)        |  12545.867 ms |   635953 | avg:   0.475 ms | max:  25.530 ms | sum:302374.658 ms |
> 
>   100ms massive_intr 500us cyclictest PREEMPT_SHORT
> 
>   1 massive_intr:(5)      | 839843.919 ms |   837384 | avg:   0.264 ms | max:  74.366 ms | sum:221476.885 ms |
>   2 massive_intr:(5)      | 852449.913 ms |   845086 | avg:   0.252 ms | max:  68.162 ms | sum:212595.968 ms |
>   3 massive_intr:(5)      | 839180.725 ms |   836883 | avg:   0.266 ms | max:  69.742 ms | sum:222812.038 ms |
>   1 chromium-browse:(11)  |  54591.481 ms |   138388 | avg:   0.458 ms | max:  35.427 ms | sum:63401.508  ms |
>   2 chromium-browse:(8)   |  52034.541 ms |   132276 | avg:   0.436 ms | max:  31.826 ms | sum:57732.958  ms |
>   3 chromium-browse:(8)   |  55231.771 ms |   141892 | avg:   0.469 ms | max:  27.607 ms | sum:66538.697  ms |
>   1 cyclictest:(5)        |  13156.391 ms |   667412 | avg:   0.373 ms | max:  38.247 ms | sum:249174.502 ms |
>   2 cyclictest:(5)        |  12688.939 ms |   665144 | avg:   0.374 ms | max:  33.548 ms | sum:248509.392 ms |
>   3 cyclictest:(5)        |  13475.623 ms |   669110 | avg:   0.370 ms | max:  37.819 ms | sum:247673.390 ms |
> 
> As per the numbers the, this makes cyclictest (short slice) it's
> max-delay more consistent and consistency drops the sum-delay. The
> trade-off is that the massive_intr (long slice) gets more context
> switches and a slight increase in sum-delay.
> 
> [mike: numbers]
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Mike Galbraith <umgwanakikbuti@gmail.com>

Besides this short preemption, it seems that an important patch is missing from
this patch set, that was originally from Prateek and you refined it to fix the
current task's false negative eligibility:
https://lore.kernel.org/lkml/20240424150721.GQ30852@noisy.programming.kicks-ass.net/

The RESPECT_SLICE is introduced to honor the current task's slice during wakeup preemption.
Without it we got reported that over-preemption and performance downgrading are observed
when running SPECjbb on servers.

echo RESPECT_SLICE > /sys/kernel/debug/sched/features

echo RUN_TO_PARITY > /sys/kernel/debug/sched/features
@task_duration_usecs_before_preempted: 
[2, 4)              8732 |@@@                                                 |
[4, 8)            109400 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@          |
[8, 16)            95815 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               |
[16, 32)          110647 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         |
[32, 64)          131298 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ |
[64, 128)         132566 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[128, 256)         82095 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                    |
[256, 512)         33771 |@@@@@@@@@@@@@                                       |
[512, 1K)          24180 |@@@@@@@@@                                           |
[1K, 2K)           31056 |@@@@@@@@@@@@                                        |
[2K, 4K)          117533 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
[4K, 8K)            4472 |@                                                   |
[8K, 16K)           1149 |                                                    |
[16K, 32K)           289 |                                                    |
[32K, 64K)           110 |                                                    |
[64K, 128K)           20 |                                                    |
[128K, 256K)           4 |                                                    |


echo NO_RUN_TO_PARITY > /sys/kernel/debug/sched/features
@task_duration_usecs_before_preempted: 
[4, 8)                 1 |                                                    |
[8, 16)               12 |                                                    |
[16, 32)              20 |                                                    |
[32, 64)              38 |                                                    |
[64, 128)             64 |                                                    |
[128, 256)            98 |                                                    |
[256, 512)           248 |                                                    |
[512, 1K)           1196 |                                                    |
[1K, 2K)            3456 |                                                    |
[2K, 4K)          417269 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[4K, 8K)           22893 |@@                                                  |
[8K, 16K)           7818 |                                                    |
[16K, 32K)          1471 |                                                    |
[32K, 64K)           373 |                                                    |
[64K, 128K)           96 |                                                    |
[128K, 256K)           3 |                                                    |

We can see that without the fix, the task will be preempted and can not reach
its time slice budget(we enlarge its slice).

May I know if we can put that patch into this series please?

thanks,
Chenyu

