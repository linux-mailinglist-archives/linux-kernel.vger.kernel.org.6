Return-Path: <linux-kernel+bounces-261849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF7F93BCE4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD139B21260
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2216E16F0EC;
	Thu, 25 Jul 2024 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvxre5eb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACF916D9A4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721891502; cv=fail; b=l/T1g5uHgoy2RmYx31zDt0WVBEUCPtrOFHsK1DgvsFc+MDizDK+ZMvSAzVVXKVkBO9P5KsN8z409pbcyUdd/KjluhiKSE8kXp3OW8FOp62kvHg6dW9gbQGjPrsqQ+L0koArCkso0da8TRNrqe6WPiklUjetpmtCmMwikpSih6MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721891502; c=relaxed/simple;
	bh=tx4J1/5dvu8uQZa10jyo3N16I3NuHte6/E672CvN2co=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=o1Tmuo6MmCdz/jzoe3Bt1NGYtIhUS1YxdmKjbVdU9VmTIiY167012UMKSacKeoihCHp+mC4CZL/Z4xU62himtl9JeS9zKLoVKkFsJIz7pXQB1dLpTnXpGvIowVUoH/5NWcfEQ22NzLQivyNq0JI4jBfZCp52xJR8c5QBD+z29p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvxre5eb; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721891500; x=1753427500;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tx4J1/5dvu8uQZa10jyo3N16I3NuHte6/E672CvN2co=;
  b=nvxre5ebKSeQnClP5V434YCaph2jOlPTB38O4DA9Um04CEfQ6YjxwKP3
   Ow7CR6gbjvneZ/5zYr52Sqodp5XD6jgdrwI1Bp4mTDYjeC6XOAPEv5xcT
   yxqxqnJS3uv8HwhPhHPWmVG5n+DgMjWi9Ts4nqNw5RRmbI17P40bJjKFA
   i01CQFnmVzJAfQdVj0N9FiAtndKktBgIolhRdJS6QRmfuwnh1A4al75r3
   rBpmBd0RHcchcVzJ2MXEs2CNgBeI6/2ffsW171zjif1GxMivq0cRsp2Ml
   L6d/stgNAZUTj5vOx17ZQj+Qu6GoP7OBmULJxWaaXMTCv8wCVFGQAnjoa
   A==;
X-CSE-ConnectionGUID: 9f2sfwERSfukI1pvB76y8A==
X-CSE-MsgGUID: XtVPEU+QR5WDADKXUZxPsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19733620"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="19733620"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 00:11:40 -0700
X-CSE-ConnectionGUID: VUjH/SXBTX67XIs5Hwo8WA==
X-CSE-MsgGUID: tvsp/4KkS56fINHCf/NqCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="83846114"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jul 2024 00:11:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 00:11:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 00:11:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 25 Jul 2024 00:11:33 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 00:11:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iefrn5urTPF0pG2yaBGEtcbhtBKkNlqi2bBgSzBY+/mXmJv5Bsqm6SbScpzkg5Zv+LTkQivwJ86fW/q8KOtQWeE8HqE19HyAPtjXSNC0UQyWlhIU+Jt/wYqeC85KKf9Sfz2OV/jLIN9e2q1ggXrkwoSOVLdqhpbKIuCta8ZG9ykksm6taa9jKjwLgaE3hu6DfxoJHh2z38UvRYufvcCJ5MHKWZ4bN4Ztv30rKYJ/rYdMUR8EthoGGOR15CPIXz8llu23MdpgEcucgvagNvLBRw/QHw+3/QFBO9kTIX8BeWwFVk0Yb7SEqnqOGidKODuBpeURCbv+//yyfVC/TOnGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7r+JeUFjoyvAChxh7jm1hhlZHKpOr6t/VFGM+7eKpvo=;
 b=aN3zhbp3BoIItfDx0P73VGWGNsQJlAacUFidmUG4jXXt8/vvDM+foX7wHYavlhijMDuLxyCFpc34TTZ5F70He7fKlZBtBEPQH57iNhPvGeNFfL9qfyWHXwjRjvwZ4X6vlgGJJ9aVARW/QXRHE7e4EDUwK0k93Gdjgw1bJ/kET9YrDmJQMa3L7zgZih1Opuwwv+Kg+5IxVqIiBcUqTwhiod5VytvA4EL49XTYwqpb0NQvtl1X2ctalFebjBumeko2n5mIAmhTJzrw5IYdlq0+UQyrrdf7opboFtuP/uNr6yL1sCw9pbuTnxwnWtZypzLdr2toJqGiYLfHqCUBE26jPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7497.namprd11.prod.outlook.com (2603:10b6:510:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 07:11:25 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 07:11:24 +0000
Date: Thu, 25 Jul 2024 15:11:15 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [anna-maria-devel:timers/misc] [timers/migration] ee1ad08e03:
 WARNING:at_kernel/time/timer_migration.c:#tmigr_cpu_prepare
Message-ID: <202407251320.b449fbc6-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ee2f22-2a5c-40b3-c409-08dcac78fe7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LZdoQzPa2A/mBNgo7nZFz4IsDGDWFdkgYbc0qod0Zty2XAtUkGeV1sGd3tmB?=
 =?us-ascii?Q?OszWhljbpG9mpDFIo73/Kf1Z80mQjaNOj2aQQR45CEGjUmOvQtuKRdT88msk?=
 =?us-ascii?Q?YAHt35Y9mw17JkZdX0HE20/QwZy9abB/GvWsYdWm7CQGgpgr1PIgbgMvHJnc?=
 =?us-ascii?Q?yR5WnX2h7cOaB6oY7dqnKrnCjuxoL1HN2QhMKO0ZeU4CeJXvnRqqDkI0gU1+?=
 =?us-ascii?Q?vYgwBhRukFmkvTorQeOW+hMZlcAJMf9apaVcG2cuB3hN3PUSji1fE2V1JJcv?=
 =?us-ascii?Q?LfbPT68qZKj23v28/7ruQZOBIVvJWa8VfyL6P5O60qhFZiCpPIZDXWNUJF/L?=
 =?us-ascii?Q?ku1RtAm7601J02iYXJo8cKZdzMFohKBQ3TYg7wxph8nPZMvHVS3DZMToK7dl?=
 =?us-ascii?Q?sSeiSZ0Wb2tDGjGNYPPRANUsZGxoM2MmH9Xv8LMfrNpQEFKT5SP/ZfK2INJS?=
 =?us-ascii?Q?cJgzCnX3tE43PcJO9nAnXcWtrIMb5FosRFGZFXX6XvRG8635hLlIrmXV1Ux8?=
 =?us-ascii?Q?C5R7BYo+NXl1GW2UCddB7iclMpjqd5HPh0s5iORLqPb3AzgBoZEaw5M8KEpO?=
 =?us-ascii?Q?LbspojpzyQ+vE71Lbf8ng2Who6ETJCDC8X9XBob6jdqNRqruFbcORAfMzI2w?=
 =?us-ascii?Q?DMamtbBviZZB9KINhxMr0kQ/ScXWJXFjc5k1xur8lcUmQmScisyu+dii4BKQ?=
 =?us-ascii?Q?O8lbdKg+ngSDwTPqXQKPxnwcqOOT/Z21dEz6K/XSSHC0KtIDDVQ+2P0AcNBc?=
 =?us-ascii?Q?ge1tIcoNEZ1kIPDupLR0JGdW/D75EGHBEpFXSFBo98WAkqJ5yJbS7QC+/b7k?=
 =?us-ascii?Q?Pvh+0/ds3l2yeA2UjNuqWZaXmQubVOO+G7xmQMB+2OaNgM26hrZesK1abtg7?=
 =?us-ascii?Q?WffYk9HBLMOSvbVCtHQGhfQdvHR2wRm9IF/zoOs+hI7jWEzeoTHbAl6idbQ7?=
 =?us-ascii?Q?N9VGf17+VV+LrZNs9DFTeKMyQaf5mCtmrpaQBh0KgvhcoCJ4DHPN2RzVpOhX?=
 =?us-ascii?Q?HkDLzgZlozPMGtWGsfJpKuRUVZG48noVabcseQoKJAAf0JreE44xobBtIHlI?=
 =?us-ascii?Q?wBNKobHH8Ocyi0pPRRHcBIubxrw8QWDdd5OkiBjNktmZ3wp26Ows0Q9PGNxO?=
 =?us-ascii?Q?i56kNJkoNaHOehxfkDHnW9Cx/ZHnVmDxu1iw3IZyQ4ISPe/nWSCHaVStBVqG?=
 =?us-ascii?Q?8nZXdoZS1SPoarnnYeUp3xRh0LzjmshaybQMJHZBSR/aGPYmytNqsoAn4+sS?=
 =?us-ascii?Q?oPB8eGviVtYbyOZPl6vOyPQZs9zWnNehBB2uJWw38pnZEBIs4++1vYlYVbDU?=
 =?us-ascii?Q?M+IMs2zY77bXX7/lgPTM1IKy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zx5GIheoeN0pXgxFSBYBGc/G6F2OEkBrJFTj6S0/dvt15/LNaaV51Xmv1zWX?=
 =?us-ascii?Q?IXVuDtCNSZb5vskXmGJE/6b5GuniEwyOIKBHIto2Q8xq4jnDkcDJ851xSIpv?=
 =?us-ascii?Q?H6Zk+/PvINDBrKGoaejmdQ/+d0d+5eCsXTbL1Hs+DtpyzFqr6EBMJLlshqX5?=
 =?us-ascii?Q?JgiSNqiw1tgXt88hGqIWy1OZsHtfMYrZH0AMaV49SZqcNrysBTjQFPp/G7Ml?=
 =?us-ascii?Q?HDJ53+4RY6jZeb7/Nipu6pbLVOpGkL3IqQV9WRzoC4w67cpw267Ek2tJVdxw?=
 =?us-ascii?Q?P5ldSJnhnp5skiQihWl0HST99NIkiqAurlOfSk6UO8+C/y6er6YXafd/zRNA?=
 =?us-ascii?Q?j0zSiYlpzwJ+aKf2pNEFMtIzx+8+/TnOOEGwlQ/Qc36vXrMHD6iX7/t/7V2l?=
 =?us-ascii?Q?sDufS/CJqxRFIIXID5URLkFyVq99xxrV9pN4LWjWeoCHDOFjQR2D5MwyjaCy?=
 =?us-ascii?Q?/46AmqefkODyafRQF7bAv58Fvuq2YRkLSYzFZniUSgccp3yaC2ukPQOSxtZN?=
 =?us-ascii?Q?bkLFS5uN0qO7rt60u4jhpGpWh5QXmhhJbPNW/aMk6LWnQyJPTf0tGeJgQL8A?=
 =?us-ascii?Q?2s+D38fA28kuAVRRmMlaxF00EcPSeKSPTCFeKhyNAggzQXVgneiFfVCD0/7L?=
 =?us-ascii?Q?nn2F6JKu+nVWxF0F9z/Ps+sAMEMqIM7nHBO6YzGrDMdE+mwUMP4neJCY8y6/?=
 =?us-ascii?Q?Xfq+/v3plC3m5V82YiXaOuOeWr6Kl+iinVhn8gkGomiB0Vcm1FAdqRLoSt+s?=
 =?us-ascii?Q?WIj47gr4W0dZwKRb0mX+iAhyiHdzlph7ai7EvMxaZMVeFh/JhCQ6df/GPOTQ?=
 =?us-ascii?Q?yg+i/kmeTe5dWS4zL58oqMTTOGlg5SNO67ZjqTmeWt60sJSO4ckZpiZ4jQlU?=
 =?us-ascii?Q?tAyHNuzzChILrTMCXLdjIPxX4IBL2htK3mzOg1JSjzLEIZ3edKXjq6hQr5hW?=
 =?us-ascii?Q?Lw0ZaHevtLraLiqJ7wwTz3Qh4v6F3v9X+vCie85CewltyPfzSnwd6zmA9736?=
 =?us-ascii?Q?2Y2HZPsdCGzJZcixDGeuJMHS2/pYkAbxKKzIZQdVWn9TQnARnpilEtFpCVg5?=
 =?us-ascii?Q?yA35u5tytzODt80jXtpxpOMyaXQpQeJfJAZtoxMpkVJwE81zw/jfzbFn3OUt?=
 =?us-ascii?Q?Ze3C+YUVFeY4uS801Xq6EtdOy+ukp7jyHmzkg5iXeQGzU8zl2H7AbbUUJjhY?=
 =?us-ascii?Q?M/puoWblB57FdEs4YU8eoK1m7U/WOHIW2PIFvImF6Iv327CfIELTWwcpmtfY?=
 =?us-ascii?Q?t779HhVQ0j60i0SYLan+OcYbLg2tFxdsy6lAktnyj+hFDjeyCNyw1ord46Y4?=
 =?us-ascii?Q?XryThPnkxpr7ruC/TrJTc+d5uAAO7tjnIC41ZMs/+VpzxmpJE1Gw5byRo2TN?=
 =?us-ascii?Q?eqn/GXFFUYAoNSWo7lZBdBNM+r8fqta8JNx3vXGAPFAZh1PQZeydkXqqWVye?=
 =?us-ascii?Q?dUkrn3cvpNBhTeoxrg0TpnrNmC7HWvY70yAsWf5ASS+7H3ceKzrm9RDL6hYV?=
 =?us-ascii?Q?0TwcjSSQya+voKj8ktTF9OFetpw2pKX6jxiMF6a9XlnHY9cu1F3HKO1WT4xh?=
 =?us-ascii?Q?+mTjdqHHLCuRP+pqI6KZN28sAwNh5DzpxOBOUnPiKRr9lCI3GOFuWSZ3dbDr?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ee2f22-2a5c-40b3-c409-08dcac78fe7e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 07:11:24.8515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgwBtBFox9tA86/x8vEoErgxZ7k5hj5aCvlNtWRteEyHJpRGsF6vbEql/vNAOmYcSgVGQLAXVnd+/4IOJW2buA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7497
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/time/timer_migration.c:#tmigr_cpu_prepare" on:

commit: ee1ad08e0366fe66622aef140c22ebb380d959a7 ("timers/migration: Move hierarchy setup into cpuhotplug prepare callback")
https://git.kernel.org/cgit/linux/kernel/git/anna-maria/linux-devel.git timers/misc

in testcase: boot

compiler: clang-18
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------+------------+------------+
|                                                             | 9714ad78e6 | ee1ad08e03 |
+-------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/time/timer_migration.c:#tmigr_cpu_prepare | 0          | 6          |
| EIP:tmigr_cpu_prepare                                       | 0          | 6          |
+-------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407251320.b449fbc6-lkp@intel.com


[    0.525858][    T1] ------------[ cut here ]------------
[ 0.526356][ T1] WARNING: CPU: 0 PID: 1 at kernel/time/timer_migration.c:1742 tmigr_cpu_prepare (kernel/time/timer_migration.c:1742) 
[    0.527259][    T1] Modules linked in:
[    0.527605][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.10.0-00002-gee1ad08e0366 #1
[    0.527898][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 0.528831][ T1] EIP: tmigr_cpu_prepare (kernel/time/timer_migration.c:1742) 
[ 0.529299][ T1] Code: ff ff f6 05 47 9e 65 c2 01 0f 85 21 fe ff ff c6 05 47 9e 65 c2 01 68 43 d4 03 c2 e8 d8 d4 f2 ff 83 c4 04 0f 0b e9 06 fe ff ff <0f> 0b e9 e6 fa ff ff e8 ea 5d ac 00 eb aa 56 68 00 a2 52 c2 e8 15
All code
========
   0:	ff                   	(bad)
   1:	ff f6                	push   %rsi
   3:	05 47 9e 65 c2       	add    $0xc2659e47,%eax
   8:	01 0f                	add    %ecx,(%rdi)
   a:	85 21                	test   %esp,(%rcx)
   c:	fe                   	(bad)
   d:	ff                   	(bad)
   e:	ff c6                	inc    %esi
  10:	05 47 9e 65 c2       	add    $0xc2659e47,%eax
  15:	01 68 43             	add    %ebp,0x43(%rax)
  18:	d4                   	(bad)
  19:	03 c2                	add    %edx,%eax
  1b:	e8 d8 d4 f2 ff       	call   0xfffffffffff2d4f8
  20:	83 c4 04             	add    $0x4,%esp
  23:	0f 0b                	ud2
  25:	e9 06 fe ff ff       	jmp    0xfffffffffffffe30
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 e6 fa ff ff       	jmp    0xfffffffffffffb17
  31:	e8 ea 5d ac 00       	call   0xac5e20
  36:	eb aa                	jmp    0xffffffffffffffe2
  38:	56                   	push   %rsi
  39:	68 00 a2 52 c2       	push   $0xffffffffc252a200
  3e:	e8                   	.byte 0xe8
  3f:	15                   	.byte 0x15

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 e6 fa ff ff       	jmp    0xfffffffffffffaed
   7:	e8 ea 5d ac 00       	call   0xac5df6
   c:	eb aa                	jmp    0xffffffffffffffb8
   e:	56                   	push   %rsi
   f:	68 00 a2 52 c2       	push   $0xffffffffc252a200
  14:	e8                   	.byte 0xe8
  15:	15                   	.byte 0x15
[    0.531045][    T1] EAX: dbe85914 EBX: 00000000 ECX: 00000000 EDX: 00000040
[    0.531668][    T1] ESI: 00000000 EDI: 19714000 EBP: c315dbcc ESP: c315dba8
[    0.531853][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
[    0.532540][    T1] CR0: 80050033 CR2: ff9ff000 CR3: 02785000 CR4: 000406d0
[    0.533273][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    0.534229][    T1] DR6: fffe0ff0 DR7: 00000400
[    0.534600][    T1] Call Trace:
[ 0.534824][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:478) 
[ 0.535119][ T1] ? __warn (kernel/panic.c:239 kernel/panic.c:693) 
[ 0.535396][ T1] ? tmigr_cpu_prepare (kernel/time/timer_migration.c:1742) 
[ 0.535744][ T1] ? report_bug (lib/bug.c:199) 
[ 0.535811][ T1] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 0.536118][ T1] ? handle_bug (arch/x86/kernel/traps.c:?) 
[ 0.536411][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
[ 0.536728][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1054) 
[ 0.537072][ T1] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 0.537412][ T1] ? tmigr_cpu_prepare (kernel/time/timer_migration.c:1742) 
[ 0.537784][ T1] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 0.538089][ T1] ? tmigr_cpu_prepare (kernel/time/timer_migration.c:1742) 
[ 0.538433][ T1] ? __mutex_lock_common (kernel/locking/mutex.c:608) 
[ 0.538791][ T1] cpuhp_invoke_callback (kernel/cpu.c:194) 
[ 0.539149][ T1] ? tmigr_update_events (kernel/time/timer_migration.c:1732) 
[ 0.539505][ T1] cpuhp_issue_call (kernel/cpu.c:?) 
[ 0.539806][ T1] ? mutex_lock_nested (kernel/locking/mutex.c:752 kernel/locking/mutex.c:804) 
[ 0.540142][ T1] __cpuhp_setup_state_cpuslocked (kernel/cpu.c:2495) 
[ 0.540551][ T1] __cpuhp_setup_state (kernel/cpu.c:2524) 
[ 0.540886][ T1] ? tmigr_update_events (kernel/time/timer_migration.c:1732) 
[ 0.541242][ T1] tmigr_init (include/linux/cpuhotplug.h:276 kernel/time/timer_migration.c:1822) 
[ 0.541540][ T1] ? tmigr_update_events (kernel/time/timer_migration.c:1732) 
[ 0.541901][ T1] do_one_initcall (init/main.c:1267) 
[ 0.542224][ T1] ? skew_tick (kernel/time/timer_migration.c:1767) 
[ 0.542518][ T1] ? entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[ 0.542849][ T1] ? __kernel_text_address (kernel/extable.c:79) 
[ 0.543209][ T1] ? entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[ 0.543541][ T1] ? __kernel_text_address (kernel/extable.c:79) 
[ 0.543806][ T1] ? rcu_read_lock_any_held (kernel/rcu/update.c:386) 
[ 0.544174][ T1] ? __bfs (kernel/locking/lockdep.c:1799) 
[ 0.544456][ T1] ? check_path (kernel/locking/lockdep.c:1832 kernel/locking/lockdep.c:2143) 
[ 0.544751][ T1] ? check_path (kernel/locking/lockdep.c:2016) 
[ 0.545046][ T1] ? rcu_read_lock_any_held (kernel/rcu/update.c:386) 
[ 0.545980][ T1] ? __bfs (kernel/locking/lockdep.c:1799) 
[ 0.546266][ T1] ? __lock_acquire (kernel/locking/lockdep.c:1832 kernel/locking/lockdep.c:2321 kernel/locking/lockdep.c:2822 kernel/locking/lockdep.c:3138 kernel/locking/lockdep.c:3253 kernel/locking/lockdep.c:3869 kernel/locking/lockdep.c:5137) 
[ 0.546609][ T1] ? __lock_acquire (kernel/locking/lockdep.c:? kernel/locking/lockdep.c:3873 kernel/locking/lockdep.c:5137) 
[ 0.546964][ T1] ? lock_acquire (kernel/locking/lockdep.c:5754) 
[ 0.547276][ T1] ? debug_object_activate (lib/debugobjects.c:708) 
[ 0.547647][ T1] ? debug_object_activate (lib/debugobjects.c:?) 
[ 0.547809][ T1] ? __mod_timer (kernel/time/timer.c:?) 
[ 0.548131][ T1] ? rcu_lock_acquire (include/linux/rcupdate.h:338) 
[ 0.548469][ T1] ? call_rcu_tasks_generic (kernel/rcu/tasks.h:381) 
[ 0.548849][ T1] ? rest_init (init/main.c:1459) 
[ 0.549172][ T1] do_pre_smp_initcalls (init/main.c:1372) 
[ 0.549516][ T1] ? rest_init (init/main.c:1459) 
[ 0.549815][ T1] kernel_init_freeable (init/main.c:1568) 
[ 0.550155][ T1] kernel_init (init/main.c:1469) 
[ 0.550450][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 0.550752][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 0.551076][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[    0.551401][    T1] irq event stamp: 1333
[ 0.551685][ T1] hardirqs last enabled at (1341): console_unlock (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:341 kernel/printk/printk.c:2731 kernel/printk/printk.c:3050) 
[ 0.551805][ T1] hardirqs last disabled at (1350): console_unlock (kernel/printk/printk.c:339) 
[ 0.552387][ T1] softirqs last enabled at (882): __do_softirq (kernel/softirq.c:589) 
[ 0.552946][ T1] softirqs last disabled at (859): __do_softirq (kernel/softirq.c:589) 
[    0.553493][    T1] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240725/202407251320.b449fbc6-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


