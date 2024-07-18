Return-Path: <linux-kernel+bounces-256607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BDF935106
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA1B1C20B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD00144306;
	Thu, 18 Jul 2024 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6Jybjn0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4E012FB13
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721322105; cv=fail; b=mkC4Z8rbyJAwyRsMBOOWegYSuh0hjcsHDulPC3sdZ5g79+iTJZ5SHMs6UtfTt2Is0qI/J6J+3p61+LN5fbHPZu7sc1HNpwubzw1DnJ4DUEY/8UjHn6UYiClTrMP/3hIjI2eRud23Y5L9VIyC91ihXiagi5V5aAAYAa4f9gmwlLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721322105; c=relaxed/simple;
	bh=GdMg/YwcJwZyhBC+xMMSFPkcvWLGP020AiLhOgX9hdg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dr8UjXSZNv0v/1LftsmxwmKnx2FX/2+4vsQU88rZ/2az/IRlfSxZOw7CVegMIe3Su6uQb5VaY/cCqnF0jEV0RfiGN/E4mJHvH0kZG3/lJ+kTQon4km+MLs+mo8vSeP2CeEth0yDOX7Ykj8QRA2W9Pc2h604KhdQiedtiA/KlMq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6Jybjn0; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721322104; x=1752858104;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GdMg/YwcJwZyhBC+xMMSFPkcvWLGP020AiLhOgX9hdg=;
  b=a6Jybjn01vVu0tRN7BI7jNnMfbbu7pzxPYEn/hIEZWFnMplf5RRwtEj/
   yRcKaTVxnRvJEsnjYXVYOy8uC5DJK2Ohuhk63RJb7+I3ttIp761+a/kZT
   fVoRFJoUI2XpypgVgHgQAQkalUlTw+AJu1EY0JvwNBGGOu8ZIWToAwffO
   kgu+44sIOTEaYozs959keTXWG9bcRNwszdP6NkyPsZftYBOl4Z3Q+A8Vm
   ZH0p8av8IG6sJLU6Efs6pEK2o6+h6JI76iQ9iTVYaKDovW3S2XP2qO/1z
   vVJho91s3XC7tMZsQ2V0QCY0RAnh/gFQuDTs/NsvEg/SzLnXrT0mu4wz2
   w==;
X-CSE-ConnectionGUID: ATUupAJ2QQ+W2hwhpYfqeQ==
X-CSE-MsgGUID: 2pyG683BSw6B5JiQ8ZZBOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="36342166"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="36342166"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 10:01:43 -0700
X-CSE-ConnectionGUID: 1UFaFZHeTWarV4LRAG9cyw==
X-CSE-MsgGUID: 4GatN8mtQUmNWWx0g0M/RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="50867221"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jul 2024 10:01:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 10:01:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 18 Jul 2024 10:01:42 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 10:01:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJHTd+oEQcT3n0e+YvBLwfahWXl6Wp7sgOCusLg74c+gYkaSMUpwfTr45BQ5da3fjbCBr8s5wMxIyWBsBOxgAyRXAAAHu3zmfw9+DUcgyrWjkbX91rI9RYsRLpwOsWiY2k6fs7hfMKpaB0egZKwKs8GLI7OPdRoIjrZIaPAa3k8TWSm9E4obZaGflecsZsiIh3pcbGqxvhp75j0QiPDPSmQqoZPcbHq3VuKP3w9snt97NZ7IQWpLcdjbO3F7Qs+iq20E6Vx+UQy/l++TN8jEm2BUttqWHeqdDA3zv8KnSIT4IfzJHGH6wfj96ou/Rj/+iaknq28w59Nn+/0Dkcl+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XT0tvQd6eLm7o3QErxtcBgtzCftiM/4HlufrfOOYr+E=;
 b=RUWjauUjuBI3euD7Y8Gk+3NjEAkJdVkWxUqjcfEX5LFfo9no2XGCxKrF4XoBENBFopME2U4R7j1No7OhUNViAHBpI3X6Ls/mlnrYm9KWb87ZqrjPQU2fj4KIb5rIE++4udYTUhoN7s8XExWosNBcVGSIvpZVuuoSp7mM9ZtSrluUswODlhHL8ucu6Any4X+zGT1QxVyHCjPkzx73atmQrTZ1JFaBhnJMeHVCXuesHjTODEYmBB5GO9NLayCWDxrfByYYvbsCHoxu9Q6DxvyARFFp+UJvlrr4oiscGDaMS9SIH9MxSC+yuqwm3t1ZK4bVssK6aoY22w4wqsOpmOY4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 IA1PR11MB6242.namprd11.prod.outlook.com (2603:10b6:208:3e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 18 Jul
 2024 17:01:39 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7784.013; Thu, 18 Jul 2024
 17:01:39 +0000
Date: Fri, 19 Jul 2024 01:01:25 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Peter Zijlstra <peterz@infradead.org>, Vincent Guittot
	<vincent.guittot@linaro.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
	<juri.lelli@redhat.com>, Tim Chen <tim.c.chen@intel.com>, Mel Gorman
	<mgorman@techsingularity.net>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Aaron Lu <aaron.lu@intel.com>,
	<linux-kernel@vger.kernel.org>, <void@manifault.com>, Matt Fleming
	<matt@readmodwrite.com>
Subject: Re: [RFC PATCH 0/7] Optimization to reduce the cost of newidle
 balance
Message-ID: <ZplKZQYpqILia+aW@chenyu5-mobl2>
References: <cover.1690273854.git.yu.c.chen@intel.com>
 <20240717121745.GF26750@noisy.programming.kicks-ass.net>
 <29172279-ac5e-4860-921f-2905639dd8bf@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <29172279-ac5e-4860-921f-2905639dd8bf@amd.com>
X-ClientProxiedBy: SGXP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::30)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|IA1PR11MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aee9fbc-44d3-49f0-395e-08dca74b4a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uaFLE09Z6/XM03GLDv/7O/2CyeoTZl9otm3I2KcK2q/FZSo/uk2HpXCtRJDA?=
 =?us-ascii?Q?jaaap9GpWY9RznQ0vV7rV6B8Q14MlRdikJoTJr6SkXWchl6MUeSneWXSwv8U?=
 =?us-ascii?Q?pAWtfZAw0vxkRwy44dKL0pSC2bVtl3yvoXwcE4q2CyhUiwwONvISs908yL7H?=
 =?us-ascii?Q?35UZ1j/1msDvEHECWhawtMapcQwkcSV4dBNuUC8yI4F+SoVofQizk6HSG5LP?=
 =?us-ascii?Q?EmfkT2xdkpI4sLfI8oxPXaBj/C3TA3etaTvxRZsfeifGuYknU4PDdONX2F1A?=
 =?us-ascii?Q?R6t8FGRLKesKrN9sP6h2MezgD+ABD3RP896Ky3FK+zS81Z0DqoX02U1IsXdI?=
 =?us-ascii?Q?Wly2R50nPtBXNN0t1nqoZaqG1EJV9SBqda+0LJZ2w5T95/Iuc1AW9R7WMdYE?=
 =?us-ascii?Q?gAJEb3eyqVMovtT6yw4/+eOf53SAAvzbvZk0Kdk5mzS0SQGpJVMx8qEf96qw?=
 =?us-ascii?Q?tqI7yuTysXS2xho6NZEJg2ek7hkFmGGNUxShdorbVOg78MRK45UTNyROR7ur?=
 =?us-ascii?Q?MhZqXPJDx6YsmwVC9xnM9N5yZw6JIttRJXC6KOKXsLjiqraUdPt5HsFQc2OJ?=
 =?us-ascii?Q?/h1IqSxAq23XTbsGoRGHaVl54XF0GgOpmgDvYIQt2AlG7fSNI6NZZg2AC8y1?=
 =?us-ascii?Q?OVEsNcOHCIeTCawyRO9slLzZYNEEasJURm5O2L6k97hOTlNAvnvt0zBp57MJ?=
 =?us-ascii?Q?zRBADzDBrnnDP7EMcqfzerJuygQH46ApLn9sqDDa6A15OyvTz96EGNq7UR3v?=
 =?us-ascii?Q?M/sK6sADW0k2ifvw1w0r+wH3t7STENSPJJ95lKxm3JveszdINcuIQWG+ZsuT?=
 =?us-ascii?Q?jjjitvlVcMSZnMOb766s6F5L3zmtY/EG2eiSVxGB0gVo/jvbE/eDKgsUum+1?=
 =?us-ascii?Q?WXey9SJtSZfT9iKNBWELvWHSoPZNq3IgLevzPL7oMarw1MICDE+8wBffxRd7?=
 =?us-ascii?Q?XG0jusfSKWT4cS1i8g/uTVq1q5L8S2boazf255EDt33AMVnIxt4GNgzAqN2W?=
 =?us-ascii?Q?SMPUVhAqluEKPvBBMUdV3kuhWCvD34s2mnc9fE4EyQ9FqNppm4Ioo8SByUFh?=
 =?us-ascii?Q?GPVUN3THG1I8fY6UXII0QTdwyfXHQbhIkmXiAvT52+Ldg+bul2T4/8AzvKDk?=
 =?us-ascii?Q?Fx5fcuokxpn3Lobix4vhL/RruNp5gOotjFs4hjcP0PmyyqNu8n680Z7WEIQU?=
 =?us-ascii?Q?is9W07HLHHkFfIh/hNmmHMY5uUSe2FWde7FAsoH9r28IiwB0Gje417aM32Bf?=
 =?us-ascii?Q?oY2/gK1xs5JtS7qYPnTIOfPyWPIdRs9ISQZ3xNunKl2WSrwuX90Su3eYCI8w?=
 =?us-ascii?Q?VHwggVcIXhHVM+QXZ9rp2sI4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XXwqV+0pVDwnYsS83y+Z03BiL0Qzfmkn41HsZHbHLQfhC8VmMlNKZwmultjP?=
 =?us-ascii?Q?C1pLTB+qHomIXIMxt9zVbgoiDRWmYAi4bzweg7jR0tVVt1ps9uHcxI7UMUuk?=
 =?us-ascii?Q?vmshvVnZ4M7BfminkPVJIMnWkIT23uh9zSj8+6YwdrYcuXf//YmiMmEeRXHu?=
 =?us-ascii?Q?fG7iseQMLM2Y8FgMTWOoM5xENdIhzuRn8BHRD0OdQ23KUer1KYOlYvDsR3Ke?=
 =?us-ascii?Q?XsIwokOT7AvIvO1rz3OcpNvQamJ5KnhQP3cyjam1PQYJpU2Gs1aGFng29Ynu?=
 =?us-ascii?Q?FQWY310ZX75gaqBPER9JoxnlgZzDRlTY0QKp6/YMpvHPiAjw5SdXfThJhaBg?=
 =?us-ascii?Q?9CHVc+7My9/0UM81w02sIiGv7XrueJhrsk1cYHI9HoxgEXuDz/cWjEwq8cI4?=
 =?us-ascii?Q?hY9PWaEl5o/AtxIgNsNkGPQfyE3FDdgKrZgD0O6wi9u7YgWcuBhJX1D6G55d?=
 =?us-ascii?Q?DuFsjWR2uuTTZR0+IHqrlHIWJuULBQaOob5qSouG+uaQK/15XGunJEtTzuEP?=
 =?us-ascii?Q?p12U5q7TJTk30o7Mi03O6IWAjSN4DQuWnEtGSY8DXlrjqeR6pCe/yD2l1voa?=
 =?us-ascii?Q?rmfoVvBQdEOU8moFdPBDjuNumVMTK0CdwNLhLe7/PKkUDEFvydOz08MuRwnI?=
 =?us-ascii?Q?TwraKflxibSiX2Fd8czkogKwh6RJMQTfVvMqs9qLUglSHZxbKygmneo2A/dj?=
 =?us-ascii?Q?PmYmSIHhG2ZyNfJMIc3gONSCTm1hKuC1oC0D9qNEiT8OnkvR/h3qoI/afzjS?=
 =?us-ascii?Q?wSCvt/tZJe9NLtGuTQwPR5ODwPvhnCQIZocrzvw6J2FRX2CkAkd2TVw/sd/G?=
 =?us-ascii?Q?5lTXjYLveiKTkUaodeJ53lznSbzFYdNwAy+vjLCw1165p9bJHV7ChxJ36yyy?=
 =?us-ascii?Q?usPrsIg3qoH2Qn9XVZotrWLrIniS85g2CMTY3idE6JhfQabY12ICKdTPP9pW?=
 =?us-ascii?Q?d+cSpxfngLr4OnZlvuyO4eTFMpC7XqD5OT8H5+tgINHBJfuOE95V33xzn9GY?=
 =?us-ascii?Q?K+5n1pTqOY2H7wqtoqb8CDeYxi4g+Ir/RigXZZEen5nye9Y1oPOW1IfKRUb3?=
 =?us-ascii?Q?rHOwVFEwTYVSeYxd2L4/Z4N5BDw6FKwJL8bBGZdbZlQPH4lLJlbuAMWr6iA6?=
 =?us-ascii?Q?xxD5wEJhEqcF0BYvh1h37Sqja9cW0vn8TCaxL4A61MiCJq1SYnqVMpzTAE7S?=
 =?us-ascii?Q?JLpVbVoVy+/URnmEM2kUfPuU9+IeRvt3/pxhUuqjiqjRXPMXqZ2CoaG3iuL9?=
 =?us-ascii?Q?nUeihbbeCUr6pLQJ4qpg7o32h5rdSUZzrCnwtnr1xmfoWhwsx1lZF88fU6SZ?=
 =?us-ascii?Q?or4CZiq9x1/tNL4A5sk1yDHpkipdvoRvFpL7L6Koog9A8Ubb3A4RjwOgEUKi?=
 =?us-ascii?Q?Qbp6R9PlZ5DnxRtBt+i+T8JvanU+XZIcbe7YmtV1uIW5LWhTMsS8cZF9gpNn?=
 =?us-ascii?Q?3huMLk+PjLYuPqnfJ8YyWWeiC8oe/APMU8gTKvalMwjLSYM6E5LT+djun4bs?=
 =?us-ascii?Q?AdNLHcNyr2SHmxFwHiDKU7S87lWdWjOJYR//5zHW21RrQbCdtBf7+uYHg4AR?=
 =?us-ascii?Q?p2+x27QKLFMYG0hr/Y5CJX3sMQCJu5z+Qu5F+pKL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aee9fbc-44d3-49f0-395e-08dca74b4a1f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 17:01:38.9000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYTr4jfJXNNh0Flb8kW9AeobqNSPhecdZLi4vQdf+hICTyDRNgZJnatdY46cTtnyf19WRVlHkzcqbSJxrCEr9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6242
X-OriginatorOrg: intel.com

Hi Prateek,

On 2024-07-18 at 14:58:30 +0530, K Prateek Nayak wrote:
> Hello Peter,
> 
> On 7/17/2024 5:47 PM, Peter Zijlstra wrote:
> > On Thu, Jul 27, 2023 at 10:33:58PM +0800, Chen Yu wrote:
> > > Hi,
> > > 
> > > This is the second version of the newidle balance optimization[1].
> > > It aims to reduce the cost of newidle balance which is found to
> > > occupy noticeable CPU cycles on some high-core count systems.
> > > 
> > > For example, when running sqlite on Intel Sapphire Rapids, which has
> > > 2 x 56C/112T = 224 CPUs:
> > > 
> > > 6.69%    0.09%  sqlite3     [kernel.kallsyms]   [k] newidle_balance
> > > 5.39%    4.71%  sqlite3     [kernel.kallsyms]   [k] update_sd_lb_stats
> > > 
> > > To mitigate this cost, the optimization is inspired by the question
> > > raised by Tim:
> > > Do we always have to find the busiest group and pull from it? Would
> > > a relatively busy group be enough?
> > 
> > So doesn't this basically boil down to recognising that new-idle might
> > not be the same as regular load-balancing -- we need any task, fast,
> > rather than we need to make equal load.
> > 
> > David's shared runqueue patches did the same, they re-imagined this very
> > path.
> > 
> > Now, David's thing went side-ways because of some regression that wasn't
> > further investigated.
> 
> In case of SHARED_RUNQ, I suspected frequent wakeup-sleep pattern of
> hackbench at lower utilization seemed to raise some contention somewhere
> but perf profile with IBS showed nothing specific and I left it there.
> 
> I revisited this again today and found this interesting data for perf
> bench sched messaging running with one group pinned to one LLC domain on
> my system:
> 
> - NO_SHARED_RUNQ
> 
>     $ time ./perf bench sched messaging -p -t -l 100000 -g 1
>     # Running 'sched/messaging' benchmark:
>     # 20 sender and receiver threads per group
>     # 1 groups == 40 threads run
>          Total time: 3.972 [sec] (*)
>     real    0m3.985s
>     user    0m6.203s	(*)
>     sys     1m20.087s	(*)
> 
>     $ sudo perf record -C 0-7,128-135 --off-cpu -- taskset -c 0-7,128-135 perf bench sched messaging -p -t -l 100000 -g 1
>     $ sudo perf report --no-children
> 
>     Samples: 128  of event 'offcpu-time', Event count (approx.): 96,216,883,498 (*)
>       Overhead  Command          Shared Object  Symbol
>     +   51.43%  sched-messaging  libc.so.6      [.] read
>     +   44.94%  sched-messaging  libc.so.6      [.] __GI___libc_write
>     +    3.60%  sched-messaging  libc.so.6      [.] __GI___futex_abstimed_wait_cancelable64
>          0.03%  sched-messaging  libc.so.6      [.] __poll
>          0.00%  sched-messaging  perf           [.] sender
> 
> 
> - SHARED_RUNQ
> 
>     $ time taskset -c 0-7,128-135 perf bench sched messaging -p -t -l 100000 -g 1
>     # Running 'sched/messaging' benchmark:
>     # 20 sender and receiver threads per group
>     # 1 groups == 40 threads run
>          Total time: 48.171 [sec] (*)
>     real    0m48.186s
>     user    0m5.409s	(*)
>     sys     0m41.185s	(*)
> 
>     $ sudo perf record -C 0-7,128-135 --off-cpu -- taskset -c 0-7,128-135 perf bench sched messaging -p -t -l 100000 -g 1
>     $ sudo perf report --no-children
> 
>     Samples: 157  of event 'offcpu-time', Event count (approx.): 5,882,929,338,882 (*)
>       Overhead  Command          Shared Object     Symbol
>     +   47.49%  sched-messaging  libc.so.6         [.] read
>     +   46.33%  sched-messaging  libc.so.6         [.] __GI___libc_write
>     +    2.40%  sched-messaging  libc.so.6         [.] __GI___futex_abstimed_wait_cancelable64
>     +    1.08%  snapd            snapd             [.] 0x000000000006caa3
>     +    1.02%  cron             libc.so.6         [.] clock_nanosleep@GLIBC_2.2.5
>     +    0.86%  containerd       containerd        [.] runtime.futex.abi0
>     +    0.82%  containerd       containerd        [.] runtime/internal/syscall.Syscall6
> 
> 
> (*) The runtime has bloated massively but both "user" and "sys" time
>     are down and the "offcpu-time" count goes up with SHARED_RUNQ.
> 
> There seems to be a corner case that is not accounted for but I'm not
> sure where it lies currently. P.S. I tested this on a v6.8-rc4 kernel
> since that is what I initially tested the series on but I can see the
> same behavior when I rebased the changed on the current v6.10-rc5 based
> tip:sched/core.
> 
> > 
> > But it occurs to me this might be the same thing that Prateek chased
> > down here:
> > 
> >    https://lkml.kernel.org/r/20240710090210.41856-1-kprateek.nayak@amd.com
> > 
> > Hmm ?
> 
> Without the nohz_csd_func fix and the SM_IDLE fast-path (Patch 1 and 2),
> currently, the scheduler depends on the newidle_balance to pull tasks to
> an idle CPU. Vincent had pointed it out on the first RCF to tackle the
> problem that tried to do what SM_IDLE does but for fair class alone:
> 
>     https://lore.kernel.org/all/CAKfTPtC446Lo9CATPp7PExdkLhHQFoBuY-JMGC7agOHY4hs-Pw@mail.gmail.com/
> 
> It shouldn't be too frequent but it could be the reason why
> newidle_balance() might jump up in traces, especially if it decides to
> scan a domain with large number of CPUs (NUMA1/NUMA2 in Matt's case,
> perhaps the PKG/NUMA in the case Chenyu was investigating initially).
>

Yes, this is my understanding too, I'll apply your patches and have a re-test.

thanks,
Chenyu

