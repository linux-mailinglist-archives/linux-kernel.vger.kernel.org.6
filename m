Return-Path: <linux-kernel+bounces-326582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 026B5976A64
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271121C2387C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2031A76BC;
	Thu, 12 Sep 2024 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hU7QghCE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC4185B60
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147242; cv=fail; b=siwXOjosGHBn2+PwKHEQ5H1W1jkfODZaM/N8rT0XyXl+bXl3u0k9c99BFS5izzlgmlS77o7pUS1DxP2heI38TY4n21TT99JDZEjYi9vnwz+2ff8Yh9b0DVVk8bzE5eUTRIOI5cF3Z3kaxsgvcAdfR7Qa4Z9pLUBu3IVr5Us+eew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147242; c=relaxed/simple;
	bh=YUIK2s1SQbpwt0KLn2YGAeeUTrLaZHLPMI7QTxyvaFw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iFi38DEO2EU3ZhtXygInskUkWacRo8tSpWVec+bmUTmxyeqdaoNnfpIeN2cL2rewplaMXiPK/djfeBtAFNpZvwYkowyqv9oqr8BgWWG+j9HBGQXWL7BlkBgO3fYJeUqi7XU9DUs8dwsO4NEQ7EeWDEc+7mPa0WRBAepayrAc+PY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hU7QghCE; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726147240; x=1757683240;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YUIK2s1SQbpwt0KLn2YGAeeUTrLaZHLPMI7QTxyvaFw=;
  b=hU7QghCEN9yaNif1tPY9YvDKnLjXotCjsjTiacGqB+ENaJpIaP+es9U3
   plpKThSipn4YF2gP/shUMgzMBt0b6/BVbF3MEZ3vlaVRv/aIXDdRapT+C
   8ChJc47UWKyrxYkuUlkUm11vGSaIwIgU2G4zBbwOAp7kodslOhEWc7X0e
   YrsN6KwNEqtsNIeK9ErgtlCZ47J/LnF+b1gm2OanJNUMy7bDEJIcHPlxn
   Kzhpp8XOTEHbBr/1e6nV4vyw9thCg2T8JZGcZnRs8HyCZWK+C9a/V+4z7
   xXLv/LCpuj9fIuMwM0Esf2zfQ1+5b0JCklYI1Qar+8X+ZNLrfn2eivDKW
   A==;
X-CSE-ConnectionGUID: bNxffYo3Tiy3tJiFhzRpIg==
X-CSE-MsgGUID: ejnlvmAXQGq6wZdhjYfd4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="36136111"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="36136111"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:20:40 -0700
X-CSE-ConnectionGUID: 4C5jWEKQSZ+UvPmjKZ7YPA==
X-CSE-MsgGUID: cD0rIz/OQymk+fElw3lBVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67419963"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 06:20:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 06:20:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 06:20:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 06:20:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpBPi7Qjs+wGXI2uOJjE8hCxiRRYtbakDMaK2WFrq6u7VlTVp7f5fBt22Z+lP3KkFZ2vDGAKgf+Eng8X08u4onIXUGTZv4GhTUoNl/3aEo6Yu320P/iRhuX1y0H4X+sR3jR8b3MRE49A4+yuP8fHwjSFv5RIZp4hLIwM2K2EHYGaT4/3xLX/fCyaw7uK7P0/mHiKwVxc9fKs7+qhOkqqwghvM6HGxWtqvuC4jlfExrSviv2sKpFP8flLAUZZ8gBu+VL1YmAobDCDIvh0QW8UugHfEWjnJF7VjhDPx9Zs0klaJGbY7pUP0RM73hEKa/rtvB2/3EjRrazcOxcrOyi6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9DQax7XZRIev66RvKk5dcFiM4PluTAO2x1HdYvMITc=;
 b=GafZfws658z/nEEwukpfj6ZN6rAzhZOI/3zBPlqFAiPkBqmGztWzwwhH9VLCLhL5fvAOOwGad1TlvcSBjkY3UHTUQeooug7no2mKVNW5XhIubkvwLEsFc84bd/YwvKz+7OdBTEGc1bdFILL2iYs4ahvwycC8IqRjy7HnDKXZUCmq8MSzI3dV3y/OYHFcxmXOGEAc/jV/DzBr025IzXI6hgS1L711A9E3QFHPhOxPEY7nAnJdw/g3u/rXX+EwgtWxTmrvA+ArR1j+8okz4MdF4M/tVEmokLjuXZCIzGCLOQ8SYk4XdKiYefPM0nBsj93RlCeyEcn2PxbasPdlJOginQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by IA1PR11MB8248.namprd11.prod.outlook.com (2603:10b6:208:447::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 12 Sep
 2024 13:20:36 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 13:20:35 +0000
Date: Thu, 12 Sep 2024 21:20:26 +0800
From: Philip Li <philip.li@intel.com>
To: kernel test robot <lkp@intel.com>
CC: Matthew Wilcox <willy@infradead.org>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: drivers/pinctrl/pinctrl-at91-pio4.c:136: warning: Function
 parameter or member 'pm_suspend_backup.imr' not described in 'atmel_pioctrl'
Message-ID: <ZuLqmqTPZtgomI9e@rli9-mobl>
References: <202409122134.crk22zBA-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202409122134.crk22zBA-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|IA1PR11MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 24be80bb-01f9-45f0-d2a7-08dcd32daf66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4xzKDQ4vr67NUlUccuHCGWeKIYtYciwfFTCO7YkkpzlY1f92g0Cke4PUzJPv?=
 =?us-ascii?Q?zuToTo3ROj1CwN+vsflmazng4INUnPsYFY2rxyz83s0Wjig97NpGuFn9CjmB?=
 =?us-ascii?Q?y5i4I00wnQlioAbDPm7Tb1STzxZmcRZw/ZlnsfNBqiIrKXvjEZE0jT+1sWrc?=
 =?us-ascii?Q?17RMpv894LX+0r82+XhdNpyr/IPtsFQp9WgMe6zDNKaJpS0UWaVio4spkE0w?=
 =?us-ascii?Q?G5w+7tU8f3CIUHKw3EdAUDQq3C/sd2EKZLk+qrweE1Xukkuva0FdlWcZ8S6q?=
 =?us-ascii?Q?rNkpLdqxYONqNcIM1bJozNXz4T4gl4/D0K0EDDrT8oWJylmpuZNITXP03k2J?=
 =?us-ascii?Q?vy+IRx0qrKr4xVzlFOhAj3mHRJdlTbjc3SPzyCX9VSPaKvpE1wO6LNm/MzHK?=
 =?us-ascii?Q?9MtPG3tOidNAxk1cu3y/XMFbh+U2O+oZpj0OtBbIEsgoVbVzUlkKUswppOUq?=
 =?us-ascii?Q?V6by6nahRBjHCT7hSbplH5mT/DlAP9cSIinh/PRGvBOZ29K2erqkSDxlLbhY?=
 =?us-ascii?Q?XR/VjBqJQ3JgVO/Sgr2UGNa2Ym/EC7nuAgMpimJIOy7MbUqyBDoKSjUwINfB?=
 =?us-ascii?Q?bAqpy53LQqvzDHuL1foCQxesWGL5ZJ5E9EqEbIt0KTwmf6AL+1JxIfYbqxEO?=
 =?us-ascii?Q?VI4uvIra2YGRlduOxTnZAS4iTlUmVnjGt8hY1Akek7pztlegUHiJ+3BaTNtS?=
 =?us-ascii?Q?Aa8WIXr84ug2qGUID897/KTakIeaRc8O1R9QXZFXE4VO81tNCadWhwcYHVBh?=
 =?us-ascii?Q?M8z26WOj5ZnSzGmhTAI+W30n2Hunu3sHkET7uKsq1Y2+ONuG2ld5/ijqJW1Z?=
 =?us-ascii?Q?oioqBzWR4pS0D3Eyr2K8Udd9T0raBDELKglynwJwaihEb7wtONJFtrc4T3lD?=
 =?us-ascii?Q?5kTHa7xDOyRb0JY+dst9V1uzIL/8+DbcTrecNF0Ex3asJeloo7fjM3ZS4AYR?=
 =?us-ascii?Q?wBCIkRYJowsWEQJY8/zqpBLsOp+/XNbEf2RI+eTn+KhyaPHm6EXmw4jCZ/Al?=
 =?us-ascii?Q?hqU+6YIlfGcVQmcoBIFZ5x5WPCPWns8kGCDfpLgiWDmkC8j8qM6e8FYsS1E7?=
 =?us-ascii?Q?Oo3Yw482gABWQq6ouWESSTAkr9pzWjS+bBHDSpHq0T68RuWL77wsGTCv4J2E?=
 =?us-ascii?Q?JA1gFAPiK6FjzeEeo5/ynDgfyW+3rNRZZsz9B67XIYdHEDZHiLHxHVPnhn54?=
 =?us-ascii?Q?H0CxLvHr919ym+ZK7u/bf/7lOuqZMztAXClTkMqLUsqzT2qfk5tQ71ZBTSsW?=
 =?us-ascii?Q?2BJHQdvJ381RsdoSIoMszGATHRy9VMZ9Fi/rgqSF/NhWeJR4eFXbsndM4BT0?=
 =?us-ascii?Q?JDqSiU7lxZdM78rPQor2ecrXa2DR7y5xM5Ot66w+PukXhamftPIjrYFDoEfr?=
 =?us-ascii?Q?WQue1Jo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W1yJOeFfMQAW3yTcGPSJ5ARoppF7vn65923ARI1I52cl/dngGWpZMKA2Ktg3?=
 =?us-ascii?Q?KkFbD34LmbWwMLMNEyuTAr/yN5GrbasbOlYMkk1DYyD1eF/B8lSUKfglStfF?=
 =?us-ascii?Q?237IKY+iwm4nhYrJMAsT4u+PzrLrii64TaJwj0hrxYoJWJ0JJ9dua1tcynZy?=
 =?us-ascii?Q?KGQ6xxLsxQDNC3F45ybFMcBUI2/ri6BsCM11ocIvWfd0MTJbvIxGNoFKOu0Z?=
 =?us-ascii?Q?wYrlGm2jsI/iDB9fCnLulb59+kswFrGZTQJYQq/AFjr59Jr9Sx3eNxmwYJHD?=
 =?us-ascii?Q?QtnS1LgWWN9boleOR2JtlmH/VhCed6d8iUVfTXjQPCg0DR2MpvcTfdbrqZ64?=
 =?us-ascii?Q?rmSY9OIkTe7KXUAfpGKLdCJZgIVud0LKGFvG3Z4zGFSHedjMlzxSCk583QOn?=
 =?us-ascii?Q?tmv3yZR0Y2w2xduIi1OZ0VaN7PAa7Qw2eS4exEoDbWpZBiqnt+T1Oj50WxtI?=
 =?us-ascii?Q?NMneaXYPlE7V/FP7WPB8HzPBX3O3vKLwgfnxSgQ4xmYfcJfl5IM43Q68O2Ei?=
 =?us-ascii?Q?Q0j944he09S/EwurxEeGse87oW89adxE2G57WKNFrgF6c/zP5w3aqbIxkTxV?=
 =?us-ascii?Q?i+TO7fjtAXIRe8SOEnJfQ3cTO3qHUvnEFmRdcgqN+PIrUSBEBsZvPheqkaBO?=
 =?us-ascii?Q?H1dJekl55T4jY3lFLh1r9R1g7xZQMlUqrJzD/uiWE8hSkKXyEJNH7GOcJmTa?=
 =?us-ascii?Q?bE/K9pzYmIFTjJZ45AfL9G363QO6Z87KV4bQmmpZ/lZES+LMG00SQGUcYPs/?=
 =?us-ascii?Q?H2jUDK5KQorOT6iEGsnYrxsTWmkB/oFrB9TqbyAxbAOhMmJqsblkwM9baPcx?=
 =?us-ascii?Q?hk20KAS+Nh8Xdg4Em30lRAgdEEdnFIUwtsztrd8GffM0Ltn4dGYlHYHjbWlN?=
 =?us-ascii?Q?sUWtas6nHigOfhT5Qa0VKnRBdF+MhoIj1RK2NYu2JO+X49qsCNcqnTbgTQv3?=
 =?us-ascii?Q?t0ilyyeNmPW1jknhBP9F1EkDTvmttObnld7aGS5QfGZEEaqKy1wnFVKkGfoK?=
 =?us-ascii?Q?Y5dNkM1sVJyTARgqOSe4IcobJyvLJfdJn3aL3Z4qmf+q/Z5sUM1m8EggtCTE?=
 =?us-ascii?Q?pPFDwUiBE9pyD45FEqHYNoxyE2NLORx75bSUS1FN8svvXbVrPUDgwJldt/Pt?=
 =?us-ascii?Q?36N834UP7CoDBXZylPSu+9dhBusuCqNhXYAEUuvbMDAgm6bLqQYdEb/5kI9b?=
 =?us-ascii?Q?z8dOz0H/Z0REROyx3Q466eZsbtbomqVuuE0bn8idHPu9ZZOy412SkE0L0ulJ?=
 =?us-ascii?Q?Juzp7+vG/HFtR7o+XvENPeVB3BWTZUZR/pYpN69TInmRiZ+3YEdccZ/D3/9G?=
 =?us-ascii?Q?nurU3gnt3NIsc0v81WGaEXWzm/mccejXFQWxCelf906OP6CzX2d+KkkjTBkS?=
 =?us-ascii?Q?pl6RPWiGIwFfvLyZKy5nTkselTBVazfcW7f092geabM7pUZxP7yzKHJZDOFb?=
 =?us-ascii?Q?za965+iaNUAHs7vPFjITfByfbiAcRO8T5YdAZPG+mofSAqEqHRKsZFC42Ttl?=
 =?us-ascii?Q?ByhBjW6Y6WCmSw7jzf5m8wva9TLmKtzc7zEuVOsqsl5yXyk7jQyWIC5SiJ7Y?=
 =?us-ascii?Q?94PMW/akDzm9kj3i61JezAuLEbYQTlJLKE4OjcHR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24be80bb-01f9-45f0-d2a7-08dcd32daf66
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 13:20:35.2520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFHeQ+pdgzyO8y4j2vBBu5aIrTBSvyCGe4kNjBG8emsdSxmMtC1BssUs3HlYAslVyMo3/M1pw5s4iEcAXqYdlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8248
X-OriginatorOrg: intel.com

On Thu, Sep 12, 2024 at 09:05:49PM +0800, kernel test robot wrote:
> Hi Matthew,
> 
> FYI, the error/warning still remains.

Sorry, kindly ignore this report, the commit is not the root cause
of issue.

> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   77f587896757708780a7e8792efe62939f25a5ab
> commit: 3a025e1d1c2ea42fa497c9c6b21c284e0f69e28b Add optional check for bad kernel-doc comments
> date:   7 years ago
> config: arm-randconfig-002-20240912 (https://download.01.org/0day-ci/archive/20240912/202409122134.crk22zBA-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240912/202409122134.crk22zBA-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409122134.crk22zBA-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/pinctrl/pinctrl-at91-pio4.c:136: warning: Function parameter or member 'pm_wakeup_sources' not described in 'atmel_pioctrl'
>    drivers/pinctrl/pinctrl-at91-pio4.c:136: warning: Function parameter or member 'pm_suspend_backup' not described in 'atmel_pioctrl'
> >> drivers/pinctrl/pinctrl-at91-pio4.c:136: warning: Function parameter or member 'pm_suspend_backup.imr' not described in 'atmel_pioctrl'
> >> drivers/pinctrl/pinctrl-at91-pio4.c:136: warning: Function parameter or member 'pm_suspend_backup.odsr' not described in 'atmel_pioctrl'
> >> drivers/pinctrl/pinctrl-at91-pio4.c:136: warning: Function parameter or member 'pm_suspend_backup.cfgr' not described in 'atmel_pioctrl'
> 
> 
> vim +136 drivers/pinctrl/pinctrl-at91-pio4.c
> 
> 776180848b574c Ludovic Desroches 2015-09-16   95  
> 776180848b574c Ludovic Desroches 2015-09-16   96  /**
> 776180848b574c Ludovic Desroches 2015-09-16   97   * struct atmel_pioctrl - Atmel PIO controller (pinmux + gpio)
> 776180848b574c Ludovic Desroches 2015-09-16   98   * @reg_base: base address of the controller.
> 776180848b574c Ludovic Desroches 2015-09-16   99   * @clk: clock of the controller.
> 776180848b574c Ludovic Desroches 2015-09-16  100   * @nbanks: number of PIO groups, it can vary depending on the SoC.
> 776180848b574c Ludovic Desroches 2015-09-16  101   * @pinctrl_dev: pinctrl device registered.
> 776180848b574c Ludovic Desroches 2015-09-16  102   * @groups: groups table to provide group name and pin in the group to pinctrl.
> 776180848b574c Ludovic Desroches 2015-09-16  103   * @group_names: group names table to provide all the group/pin names to
> 776180848b574c Ludovic Desroches 2015-09-16  104   *     pinctrl or gpio.
> 776180848b574c Ludovic Desroches 2015-09-16  105   * @pins: pins table used for both pinctrl and gpio. pin_id, bank and line
> 776180848b574c Ludovic Desroches 2015-09-16  106   *     fields are set at probe time. Other ones are set when parsing dt
> 776180848b574c Ludovic Desroches 2015-09-16  107   *     pinctrl.
> 776180848b574c Ludovic Desroches 2015-09-16  108   * @npins: number of pins.
> 776180848b574c Ludovic Desroches 2015-09-16  109   * @gpio_chip: gpio chip registered.
> 776180848b574c Ludovic Desroches 2015-09-16  110   * @irq_domain: irq domain for the gpio controller.
> 776180848b574c Ludovic Desroches 2015-09-16  111   * @irqs: table containing the hw irq number of the bank. The index of the
> 776180848b574c Ludovic Desroches 2015-09-16  112   *     table is the bank id.
> 776180848b574c Ludovic Desroches 2015-09-16  113   * @dev: device entry for the Atmel PIO controller.
> 776180848b574c Ludovic Desroches 2015-09-16  114   * @node: node of the Atmel PIO controller.
> 776180848b574c Ludovic Desroches 2015-09-16  115   */
> 776180848b574c Ludovic Desroches 2015-09-16  116  struct atmel_pioctrl {
> 776180848b574c Ludovic Desroches 2015-09-16  117  	void __iomem		*reg_base;
> 776180848b574c Ludovic Desroches 2015-09-16  118  	struct clk		*clk;
> 776180848b574c Ludovic Desroches 2015-09-16  119  	unsigned		nbanks;
> 776180848b574c Ludovic Desroches 2015-09-16  120  	struct pinctrl_dev	*pinctrl_dev;
> 776180848b574c Ludovic Desroches 2015-09-16  121  	struct atmel_group	*groups;
> 776180848b574c Ludovic Desroches 2015-09-16  122  	const char * const	*group_names;
> 776180848b574c Ludovic Desroches 2015-09-16  123  	struct atmel_pin	**pins;
> 776180848b574c Ludovic Desroches 2015-09-16  124  	unsigned		npins;
> 776180848b574c Ludovic Desroches 2015-09-16  125  	struct gpio_chip	*gpio_chip;
> 776180848b574c Ludovic Desroches 2015-09-16  126  	struct irq_domain	*irq_domain;
> 776180848b574c Ludovic Desroches 2015-09-16  127  	int			*irqs;
> de4e882f3fbef5 Ludovic Desroches 2015-09-25  128  	unsigned		*pm_wakeup_sources;
> ba9e7f2794d815 Alexandre Belloni 2017-04-06  129  	struct {
> ba9e7f2794d815 Alexandre Belloni 2017-04-06  130  		u32		imr;
> ba9e7f2794d815 Alexandre Belloni 2017-04-06  131  		u32		odsr;
> ba9e7f2794d815 Alexandre Belloni 2017-04-06  132  		u32		cfgr[ATMEL_PIO_NPINS_PER_BANK];
> ba9e7f2794d815 Alexandre Belloni 2017-04-06  133  	} *pm_suspend_backup;
> 776180848b574c Ludovic Desroches 2015-09-16  134  	struct device		*dev;
> 776180848b574c Ludovic Desroches 2015-09-16  135  	struct device_node	*node;
> 776180848b574c Ludovic Desroches 2015-09-16 @136  };
> 776180848b574c Ludovic Desroches 2015-09-16  137  
> 
> :::::: The code at line 136 was first introduced by commit
> :::::: 776180848b574c9c01217fa958f10843ffce584f pinctrl: introduce driver for Atmel PIO4 controller
> 
> :::::: TO: Ludovic Desroches <ludovic.desroches@atmel.com>
> :::::: CC: Linus Walleij <linus.walleij@linaro.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

