Return-Path: <linux-kernel+bounces-302723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B8C96028D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3006B21325
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8517C148302;
	Tue, 27 Aug 2024 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I64p/6DL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9793A1C4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741767; cv=fail; b=WjfBH3R/Y5PUKjVekBpu7KwkXsDDH4irJQ6JjSXafQ3DvOPp5/t9nOwqNbRgx8YzZhUNomxei1hgzhVq3VsliZaKNxiwtH6BuNf7TYtYwxwZ5b5jO4qUfmla174hFqqGuyzJwZtnUegTfqracS5Bbntt6U3dG0R0KGI3ww/zGuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741767; c=relaxed/simple;
	bh=7m0ZlyX2HjanZhPCLj4zXdT+zBKBw3+idwIExVJLUiY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=NEAwQ/XIwf7AIyM+kmgyFoAgPVrgbFOgZwuBlli3fN/NJ7Lw9/3Qw7SmKhurBVvl48Rrt1u4m9e0lMY50nDNftTX9q/kfOuGL+cqDwjwcrD+oDPNQ1S/3OEj6/WHWfREVa5Q885UuH8vY8N6xIX9Wmkr3GAP129dBA7rHDms5Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I64p/6DL; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724741766; x=1756277766;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7m0ZlyX2HjanZhPCLj4zXdT+zBKBw3+idwIExVJLUiY=;
  b=I64p/6DLa5+30XWge9HFaWrjNA6nI27Z8dFHeDpXiaTfMaqcvifJrTIN
   jA5hDdQ758zhJ4SoqWOZnG2NhT6dtBjIMa1rhxUWWqFjoSkYC0+7N7NUm
   8nU8/EgYLYCE0+Njc6t0Tehuare8OMB6r1Vk2sGWFKwX69ZpbFZ/Aq/fF
   HX29DENhgol+Cy68PbHbETXFw1UCTHrVG63/3x5CjfaF5k7bVRraHR9+N
   1NPp9J0XyGp+EPEra+Da8VrB7AuhVh4F9incW5jCHzUk1cWlU4e5idRvO
   ixKVsdY1dT9pbS80hF3SrmWKSCnvdqSxdD4Q9oMYNQcY3fNEeEdNYbm5g
   w==;
X-CSE-ConnectionGUID: g4Wiic2tQjyuD7cYhYXtKg==
X-CSE-MsgGUID: YdJaCJYrTQORb3Z5V7sp9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="26966429"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="26966429"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 23:56:03 -0700
X-CSE-ConnectionGUID: a5vVPgDsSgyb71GSWLefhg==
X-CSE-MsgGUID: bbjF7FwPS4mj8IiidcVJ/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="62927003"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Aug 2024 23:56:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 23:56:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 23:56:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 23:56:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 23:56:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFfUCX7iwBf3wrOQwKfNJLo4qL2He2GENz0ZAZXzoY2SQ0D/FWVIqlGSr8NPTEPEwvj6BNN3K3gdlQ/M1M32ZoGaBXIyXxUZcmMSNEpUG5UnOe75pJe6Yocabg2P8vqt73WiDQAZmGitbB7LaYgGVviCfifoAE/8D+tLjblrKURhRDuMQVgQOpq6hIIVA4Cpcso7V+v7XAPc3lWnjdI5eoruudv84mUQdMmqh7TRfooOWhO8ASUgM5xf3SteLfXk1s/YsfUlpHHKp13TOgMb6maEeLz8lrRVvERmxCa6yJmjlBwbtY7KOviH/feo13LGL0gKLklj/TQPuvQC+N/oag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFSKvzGNSIV2JVAxnXNmgsnUOYwFYqyeRrLqH2vkfx4=;
 b=WvgSTdjyyVADvAN25bGro72phXutZf3OXnhk7/j4TCluacuukKon6vcsbD5zTXneuTGWkBn40klpXCZ30MLOFh0XNuWEqNsO0N29wzsAA6AbsisSrjjxC8xW3XAt6B1qExPNjK873A/01FBv1T6oOcVJHWuXvga/mj02G5EkECPiwELifvcDL7X6JHpHgNzwM0apcMElQi66d6hyWbYR5QPy8lhL5sSflgmVb+n+WP1T73aoo+G6CEo3PARQ5D269XHFJK55Rf9GLqzrKebjcHUOtOiE/vQFLCjPoS958g4lbq/yhmp/kH8hofvQOj2VmrxHi8T7q7k2gTLEWmEVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB8593.namprd11.prod.outlook.com (2603:10b6:806:3ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 06:55:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:55:58 +0000
Date: Tue, 27 Aug 2024 14:55:45 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "Bert
 Karwatzki" <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, Kees Cook
	<kees@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, "Lorenzo
 Stoakes" <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, Paul Moore <paul@paul-moore.com>, "Sidhartha
 Kumar" <sidhartha.kumar@oracle.com>, Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [mm]  a0f2295a60:
 WARNING:at_mm/vma.c:#vma_merge_new_range
Message-ID: <202408271452.c842a71d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e6fa1d-b453-409e-ce86-08dcc6654e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+fcWCoGZWKIr1jeJPlPEHzpqfx70wAGdBtCpwvwY4icSVohQrfnMbPygfJWs?=
 =?us-ascii?Q?jVYYTcawGb8ZZnV7z2xto0zhlHX4KHH1Ese+o7EKbpNu3DVS4/oqcd0bcJ33?=
 =?us-ascii?Q?rmvFSbsFU7faFknMnm7U4HjGhjbw0BwTjrTqAg1+2PLjsxva+0FgoHDHS3K2?=
 =?us-ascii?Q?x7pM93D34ou7inMjhhCQMhXQ+gyednwtp8c34AWT3HiwWdmxQBpKFmtRoWUD?=
 =?us-ascii?Q?Bfa9atvO8oOqM2sf0fOxXUwrE0IcnKjDjk8BnfvoxUf6vITpEqlMnpsLik+T?=
 =?us-ascii?Q?xNw0VEK36WBH0sOoTkkvcm7/5ZqYe6bshCgXmrYeelAnPgopUyqzvqqoEJUO?=
 =?us-ascii?Q?k4LENLS2LYJAiTF5ib9yt0hO17s/5qEhiHR2rmjQC+fMeaF2qh940YIYgpRW?=
 =?us-ascii?Q?EsZAeAmpG2aQMzGGmMk+vMFUDhBLKB0YyolCB/s1GQNUUTpkbmVQrsNRpNUq?=
 =?us-ascii?Q?WNkfgUXKrLyaToblfYAtoxgaqAF7qf5UbdZ64bRINMu9IG/efV87TXrxdfo3?=
 =?us-ascii?Q?k3nalxWovkRahAJ8Ox6Twa8HBlFCvXNuibifoCUo0AO2Rjo+yQxGT05hJHSz?=
 =?us-ascii?Q?D4wbJxpmOTWuq4tYgyNoq9t1EX9fHCCypmG7F2bsMJVE1TJAI1SsWkPICax7?=
 =?us-ascii?Q?GuX8Oqh71m7d+QGT4/73OnLIsnekMIDunS2KNxDHMkfMD0F2Qy5o0QNh9KHm?=
 =?us-ascii?Q?m9RA+I4QYg5VVT90Xh479L8hlf/qwimZUJa1uZ2+dO9STCRoLoqQop7v+U65?=
 =?us-ascii?Q?Vm1aI1uuJbUiATBnBbLsv3dUAEgxjU9wm/mBkridogrS0HDFcwtQPnnJi7h+?=
 =?us-ascii?Q?OfAliHW1eNb+CT5HV8hwzzirFc54kH8N+66vB1FDNqX/nsGwSc75n9GrSO49?=
 =?us-ascii?Q?1RRrQ2Udi1xvzHw/iccJak0BkA9umtaWuTYeVPaXgjzqvaYg0NdoUv5+HGBh?=
 =?us-ascii?Q?DxObZyX2OMUI5shrqPoL2spaEdS2cCTiUrMdrFw+JV5lz3rKxHwEpoxUJhxB?=
 =?us-ascii?Q?ljm1DEaVz+uop/zpxZhZMnxmclsCtjHugpyu3wiYFnh1BTJMw14rKqOo+9ag?=
 =?us-ascii?Q?NA3UiJnYAM/p3DspV0rwGBInTumGGE2oeQgzwY+rNFwsqIwRh0Dk0OqH+ygA?=
 =?us-ascii?Q?gOutBHiz1esvdAFeYb0mrQhDJTHo6nOPoqD+vM5PYIOBuH+PGY7tNrAyCWg6?=
 =?us-ascii?Q?eCrlmTXn48Q5V4qoamAbpapXvjlZhA51EInP4yzZRLUcpg26voMk9ijiTRFb?=
 =?us-ascii?Q?95BBj8GRrDrZ6c4npP1ESDWad5jlRr6vrhMQRzvFpfBxjRmLBf5zTHlKHDs0?=
 =?us-ascii?Q?VHuWMFL+VoTffmWD1ZMQLSBY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T4Gw2AokhpUBiCR8fbBtldAwTo9dOwHhkygoPR9TaY0vofAFEa61YSOQxq9b?=
 =?us-ascii?Q?9SSh2sodtml94kV5xABGOxAFIkBhPeko2hGQuWWpLPTPZEiHQAGXH+1QaxGN?=
 =?us-ascii?Q?5E6bfZ41BHjNxcTyx2nP+B7xHG6o4G6bezTV2lTzh4KJY2Faamq6kKyW8fsF?=
 =?us-ascii?Q?WffHQdYbxR2BbVHTPIlrKF3ILimf7OVmBCSGtU26ZBDwdjT5U0kKST8NS6TV?=
 =?us-ascii?Q?2Nhnh/NemOdsFRyoG+4aG2F3i2+et6FTGmXz7PT8bRKMwcFlFba36uxVaGEx?=
 =?us-ascii?Q?YkFCJ6j7mqNbPPmVI0kum5z3xLndC6nEsckrVqvsjcvu83GKwnaRWcZbTICQ?=
 =?us-ascii?Q?2j2PjmfTvpUoX36ThANBs29Qfgooojp+Bh/v0bpn57NEO9o9js14ZB159xuu?=
 =?us-ascii?Q?Fsgy4VTGOpxLEP1e4/nxWCSbDAdNPaGEWBmnPz0xhddWthXV36HIEfP37a43?=
 =?us-ascii?Q?tsQZGnDgnw858/2oZ5Zrv/vgDzdrEsC0hgq40P1uzmHto0Jyh4EXK2WXTrMF?=
 =?us-ascii?Q?DFoqH5w3hziOMK8j4dKV2YKwOfprkfGx0mRj3Rz38NRzrEUqS+LuCO/1ASZJ?=
 =?us-ascii?Q?3IiUfz9IPyO1pRzlYYABmI84TOig3+c79MA8dwYDwL3iG2GTwYDHful4cWg9?=
 =?us-ascii?Q?oP2kTvyXThXtcgnM/vOEOJ5h4E6RI1rU9s2zDlylLUf2CwcG/gYV+3e8Cb/I?=
 =?us-ascii?Q?Gg1PyWbm3eBH4jomvW4GytzttRk75Z6MbxTemjvfIaXkF4CgLidv5FzhsuwR?=
 =?us-ascii?Q?8+4laHb3+FEn42WzZofBAU2pOzLxtLUwmM+v+0UkHy+OB2/+1OAeCQC31jNJ?=
 =?us-ascii?Q?P4oYpx9gqFH2cdYClAKNCIiA1UWxRYA3PyDiLqdq+4SLZdTnDaMshyX3rFtA?=
 =?us-ascii?Q?2MgBTYSemzBWx/E+fR93uRlnZAhp9Czn77VauHsfDXfX8YJJYhXsxM/83d4M?=
 =?us-ascii?Q?vNEN6EBE2rf7aFJBhHnutfjGKwDK+4t81CN8fWw/sytYjRfmlKlrdaq4biU+?=
 =?us-ascii?Q?Mn4RmrUUyXNUCXyqmjgAF98+oAVznuAmLFD2NlknjZNyeN4ulyM4EIyCMm3j?=
 =?us-ascii?Q?G7xTjlGB6E3Xg1fJbZkxXysm19ZJr7V/a3UYF5zElO35MXlQ9N7DE/tODk0W?=
 =?us-ascii?Q?2gcAt/GPYj34ktbYDEEuiTsv6agx04VAcxSn5ype8pP2d93GW3HuDHMPtnsR?=
 =?us-ascii?Q?OVC4cHQwu2U2WN329TT9iMpx4TpjDuEyXvEtfg8Q0GvKmHOLth4ijHTxJZ+q?=
 =?us-ascii?Q?V7bd/BhoAXQyPRs9hwbrXv+DOFCcxXlZ4hfaUmsObtDzaR/9mIM8igRzig30?=
 =?us-ascii?Q?U4rAfgOOIbYRp19fohDOMTzZAsApLMvEcYiGcj64RUu31jbLc+cfFI1c+pWy?=
 =?us-ascii?Q?HM0t2dwxZJ1vuHLZioX2iVOdM07vC4spSFJJQD7zfFRAf1IH8Q1qeN0EvWrM?=
 =?us-ascii?Q?tJubAj2Zk3rrferZeZo1cRbHCaKPbC/i4vX20xHNSZAHNb/NQSCA6iiuKkwI?=
 =?us-ascii?Q?RcJ4Uuxg7bH6UeuQMWaatyotP1Ff522PbyJAiaUb88ZVY7NLzYjKhPZ6cw8d?=
 =?us-ascii?Q?f1jGS5TsDdT7AJqa5DSqLd+uate0AiD5DsFR1gfe+yKpEhX07Vk8S3brolvS?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e6fa1d-b453-409e-ce86-08dcc6654e0f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 06:55:58.6541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9pzhQnWXNUCCWgE10zlnB/SZQQk19zbDmUC9vABUaI1aM8n/YPuFwqC8jqF0vVTQ4EE9gJYq+gPtiUKjxOc6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8593
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_mm/vma.c:#vma_merge_new_range" on:

commit: a0f2295a607c0e8a64893593432562444a58a70b ("mm: avoid using vma_merge() for new VMAs")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 600s



compiler: gcc-12
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------+------------+------------+
|                                          | dfe2897d43 | a0f2295a60 |
+------------------------------------------+------------+------------+
| WARNING:at_mm/rmap.c:#unlink_anon_vmas   | 6          | 6          |
| EIP:unlink_anon_vmas                     | 6          | 6          |
| WARNING:at_mm/vma.c:#vma_merge_new_range | 0          | 6          |
| EIP:vma_merge_new_range                  | 0          | 6          |
+------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408271452.c842a71d-lkp@intel.com


[   28.048325][  T765] ------------[ cut here ]------------
[ 28.048597][ T765] WARNING: CPU: 0 PID: 765 at mm/vma.c:524 vma_merge_new_range (mm/vma.c:524 (discriminator 1)) 
[   28.048976][  T765] Modules linked in: mousedev input_leds evbug led_class aesni_intel rapl psmouse pcspkr evdev i2c_piix4 qemu_fw_cfg i2c_smbus i2c_core button
[   28.049662][  T765] CPU: 0 UID: 65534 PID: 765 Comm: trinity-c4 Tainted: G        W          6.11.0-rc4-00372-ga0f2295a607c #2
[   28.050163][  T765] Tainted: [W]=WARN
[   28.050339][  T765] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 28.050789][ T765] EIP: vma_merge_new_range (mm/vma.c:524 (discriminator 1)) 
[ 28.051028][ T765] Code: 8b 53 14 85 d2 0f 84 51 ff ff ff 8d b4 26 00 00 00 00 0f 0b 8b 4b 04 8b 45 f0 3b 41 04 0f 83 48 ff ff ff 8d b4 26 00 00 00 00 <0f> 0b e9 3a ff ff ff 8d b4 26 00 00 00 00 66 90 84 c0 0f 85 b6 00
All code
========
   0:	8b 53 14             	mov    0x14(%rbx),%edx
   3:	85 d2                	test   %edx,%edx
   5:	0f 84 51 ff ff ff    	je     0xffffffffffffff5c
   b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  12:	0f 0b                	ud2
  14:	8b 4b 04             	mov    0x4(%rbx),%ecx
  17:	8b 45 f0             	mov    -0x10(%rbp),%eax
  1a:	3b 41 04             	cmp    0x4(%rcx),%eax
  1d:	0f 83 48 ff ff ff    	jae    0xffffffffffffff6b
  23:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 3a ff ff ff       	jmp    0xffffffffffffff6b
  31:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  38:	66 90                	xchg   %ax,%ax
  3a:	84 c0                	test   %al,%al
  3c:	0f                   	.byte 0xf
  3d:	85                   	.byte 0x85
  3e:	b6 00                	mov    $0x0,%dh

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 3a ff ff ff       	jmp    0xffffffffffffff41
   7:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   e:	66 90                	xchg   %ax,%ax
  10:	84 c0                	test   %al,%al
  12:	0f                   	.byte 0xf
  13:	85                   	.byte 0x85
  14:	b6 00                	mov    $0x0,%dh
[   28.052072][  T765] EAX: 00400000 EBX: ed937b48 ECX: ed937b20 EDX: 00000000
[   28.052420][  T765] ESI: 00000000 EDI: ecb925a0 EBP: ed937b00 ESP: ed937ad8
[   28.052728][  T765] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010287
[   28.053082][  T765] CR0: 80050033 CR2: b76e3580 CR3: 2db75bc0 CR4: 000406b0
[   28.058945][  T765] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   28.059252][  T765] DR6: fffe0ff0 DR7: 00000400
[   28.059459][  T765] Call Trace:
[ 28.059606][ T765] ? show_regs (arch/x86/kernel/dumpstack.c:479 arch/x86/kernel/dumpstack.c:465) 
[ 28.059796][ T765] ? vma_merge_new_range (mm/vma.c:524 (discriminator 1)) 
[ 28.060030][ T765] ? __warn (kernel/panic.c:735) 
[ 28.060210][ T765] ? vma_merge_new_range (mm/vma.c:524 (discriminator 1)) 
[ 28.060446][ T765] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 28.060651][ T765] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 28.060899][ T765] ? handle_bug (arch/x86/kernel/traps.c:218) 
[ 28.063802][ T765] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 28.064013][ T765] ? handle_exception (arch/x86/entry/entry_32.S:1054) 
[ 28.064231][ T765] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 28.064432][ T765] ? vma_merge_new_range (mm/vma.c:524 (discriminator 1)) 
[ 28.064666][ T765] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 28.064870][ T765] ? vma_merge_new_range (mm/vma.c:524 (discriminator 1)) 
[ 28.065124][ T765] copy_vma (mm/vma.c:1563) 
[ 28.065326][ T765] move_vma+0x121/0x4d8 
[ 28.065557][ T765] ? mm_get_unmapped_area (mm/mmap.c:930) 
[ 28.065792][ T765] mremap_to+0x138/0x1b0 
[ 28.066054][ T765] __do_sys_mremap (mm/mremap.c:1176) 
[ 28.066270][ T765] ? __lock_release+0x55/0x150 
[ 28.066509][ T765] __ia32_sys_mremap (mm/mremap.c:980) 
[ 28.066720][ T765] ia32_sys_call (arch/x86/entry/syscall_32.c:44) 
[ 28.066923][ T765] __do_fast_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:386) 
[ 28.067146][ T765] ? __lock_acquire (kernel/locking/lockdep.c:5142) 
[ 28.067365][ T765] ? find_held_lock (kernel/locking/lockdep.c:5249) 
[ 28.067575][ T765] ? __lock_release+0x55/0x150 
[ 28.067812][ T765] ? __do_fast_syscall_32 (arch/x86/entry/common.c:391) 
[ 28.068041][ T765] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 28.068282][ T765] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4420) 
[ 28.068511][ T765] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 28.068763][ T765] ? __do_fast_syscall_32 (arch/x86/entry/common.c:391) 
[ 28.069004][ T765] ? do_pte_missing (mm/memory.c:5056 mm/memory.c:5195 mm/memory.c:3955) 
[ 28.069236][ T765] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 28.069477][ T765] ? handle_pte_fault (mm/memory.c:5530) 
[ 28.069701][ T765] ? mt_find (include/linux/rcupdate.h:336 include/linux/rcupdate.h:869 lib/maple_tree.c:6960) 
[ 28.069889][ T765] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 28.077572][ T765] ? __perf_sw_event (kernel/events/internal.h:227 kernel/events/core.c:9996 kernel/events/core.c:10021) 
[ 28.078055][ T765] ? __up_read (kernel/locking/rwsem.c:1354) 
[ 28.078245][ T765] ? __up_read (kernel/locking/rwsem.c:1354) 
[ 28.078435][ T765] ? debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 28.078670][ T765] ? __up_read (kernel/locking/rwsem.c:1354) 
[ 28.078859][ T765] ? __up_read (kernel/locking/rwsem.c:1354) 
[ 28.079050][ T765] ? trace_preempt_on (kernel/trace/trace_preemptirq.c:105) 
[ 28.079265][ T765] ? __up_read (kernel/locking/rwsem.c:1354) 
[ 28.079456][ T765] ? preempt_count_sub (kernel/sched/core.c:5672 kernel/sched/core.c:5668 kernel/sched/core.c:5690) 
[ 28.079677][ T765] ? irqentry_exit (kernel/entry/common.c:367) 
[ 28.079881][ T765] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 28.080126][ T765] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4420) 
[ 28.080356][ T765] ? irqentry_exit_to_user_mode (kernel/entry/common.c:234) 
[ 28.080612][ T765] do_fast_syscall_32 (arch/x86/entry/common.c:411) 
[ 28.080827][ T765] do_SYSENTER_32 (arch/x86/entry/common.c:450) 
[ 28.081065][ T765] entry_SYSENTER_32 (arch/x86/entry/entry_32.S:836) 
[   28.081284][  T765] EIP: 0xb7f41579
[ 28.081446][ T765] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
All code
========
   0:	b8 01 10 06 03       	mov    $0x3061001,%eax
   5:	74 b4                	je     0xffffffffffffffbb
   7:	01 10                	add    %edx,(%rax)
   9:	07                   	(bad)
   a:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   e:	10 08                	adc    %cl,(%rax)
  10:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
  2a:	5d                   	pop    %rbp
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d 76 00             	lea    0x0(%rsi),%esi
  35:	58                   	pop    %rax
  36:	b8 77 00 00 00       	mov    $0x77,%eax
  3b:	cd 80                	int    $0x80
  3d:	90                   	nop
  3e:	8d                   	.byte 0x8d
  3f:	76                   	.byte 0x76

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	8d 76 00             	lea    0x0(%rsi),%esi
   b:	58                   	pop    %rax
   c:	b8 77 00 00 00       	mov    $0x77,%eax
  11:	cd 80                	int    $0x80
  13:	90                   	nop
  14:	8d                   	.byte 0x8d
  15:	76                   	.byte 0x76


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240827/202408271452.c842a71d-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


