Return-Path: <linux-kernel+bounces-214389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6304C90838C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12562854FF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 06:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F93F1482F8;
	Fri, 14 Jun 2024 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbbIN5bJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0FF19D895;
	Fri, 14 Jun 2024 06:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718345444; cv=fail; b=TwnEuvDDNOCz6llD35ebXkJLm6I2FFbS6krSoZfRexkEXWn0cZ5n5Ti78DQsIwa3TiiazIR5iSXEbt68lIK1swLd1Jx7Lhdod9LVDCyKsnn4ZPRNqeF5lhTAZy1FOyQwAjB0p3RippIjNeHlcTsfYNaj0E77pVKiT5Dz2vpK6Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718345444; c=relaxed/simple;
	bh=Yh+KZTLB5SczMU/SIM3fvDRpAjnvla1OsqR+ejDhRL8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ocrKxiXqhaS+fChiS7bHCp8V55XX17w70uCnhkOq8Os3DLAPfRZiyMbcSuldCc68GKOgiHzOfOsgpMSxoDttj5kBUUX/ZcijGIu1z4tl3+7rDwAN1mzIPv4VBatzjN5AX8nI3sBYwgRvXAFMQussD9lWfXslJVnsPapkPdywIpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbbIN5bJ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718345442; x=1749881442;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Yh+KZTLB5SczMU/SIM3fvDRpAjnvla1OsqR+ejDhRL8=;
  b=mbbIN5bJQANjRamDY1mWrLYSVO4LKRm0BELmNiQ3sPpLdzt7GfoWlOoh
   OAzY8/MtteU9biz6dV4mVvcqV3R9H6EYUMpddDIrQtX6rqNDGJcy1J/6P
   QZTtbtQFr3jY9Kj7R1lgivKHm+TFxS+VbXC/1T7tY7Ah38goVXqXPbbhQ
   8U8coFf8jgULgmmFNTg7TvgAZQ4dKQN623FYlUjaTNRrorLCh6Uh7znGz
   rG6J2GuvYU2EaQ2ejtXOaW+Ztth6X19n2DntiBpdU8hxMkZgD2TdL06TC
   vsqpcHz6O8ZM5aNucbWN16Lz+FmmdQL02G19O5jJSzFcjkrJuFdIfyAfq
   g==;
X-CSE-ConnectionGUID: m86qylaHRr6C2QPmlmiQUA==
X-CSE-MsgGUID: w1Cp/CZnTfOM1r1cpEG9BA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="18139357"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="18139357"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 23:10:41 -0700
X-CSE-ConnectionGUID: NhL5TKIdTiKShOgX8a7GWg==
X-CSE-MsgGUID: 0LrSAomiTGqQHCFjGiPC3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40324248"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 23:10:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 23:10:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 23:10:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 23:10:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 23:10:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4/Jnwa51avAubMa23huN8uRiGuSyEMzXUB5TNId5VfzncX8IPjp9TykyNwEQ/oC5nGpUFeVl4Suv+0tHqU70Ll3/hKF/d6gTHu6U7vWV5toPZjihXYg3Ti4zANmeJQGUHhnTQUQllKt0+j/OBizbxva0mkz6jxaFtYQlmDgZAbBef0Og1c823AR1fBLaySTu7ngfV3HbRs41Zi2IrNcUj1lSg+qKxvg2tgJRANYNM11BjkkkXqZq9ub0j6OboRM9kISQs5fgSdDmPPp1Z4TPhic5d2wUnSAyj5K2b9i3rMPvWcAwqjDOa6e+bNfCNScyPe6/oFus6rFygm5N1AyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7DtfcyZPImp5Y50tJ/3RZzZPMxDjZ2IwvCIpX9qaTo=;
 b=ANAHMwkSoydp7RlpiAbcf3wkvr1uB9kVR+JKoUtIVj2V900UoiALLCS/PakPwBoq/tm1wLGEyezDzzgfEUcltjG0iUMeJk2JV/WPlxI2D92dSAJ5T90Ul4huvJRBdWWWhg3fpuw5QrSzH6RVX7GDDeV75Cd/UpikJfMtvcDG1G3lESiX8KRXRX2A+7Itu9HwfYvS7Db196jAKho6ZCgz/b3qAy+kfpztWXgXh/6gw0nm7pdmd9HWCpj18Tfe/fSzJk7DYYjCjOT0Y6ppGz3r9AW8M7fVoHN4cmmG/ZNlhgejBsDCqzsYh/yzCGM7pIvn/pw36rNsus685PpMaj2xpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BN9PR11MB5244.namprd11.prod.outlook.com (2603:10b6:408:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 06:10:37 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.037; Fri, 14 Jun 2024
 06:10:37 +0000
Date: Fri, 14 Jun 2024 14:10:29 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Marcello Sylvester Bauer <sylv@sylv.io>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcello Sylvester Bauer
	<marcello.bauer@9elements.com>, Alan Stern <stern@rowland.harvard.edu>,
	<linux-usb@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [usb]  a7f3813e58: WARNING:inconsistent_lock_state
Message-ID: <202406141323.413a90d2-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BN9PR11MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: 18cd46a4-461f-43d7-0485-08dc8c38b5b2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1EpWWYSiIteANc4Qh6/K05V+bNWetyUKuh7/xqfS5HTByT7iV8mEUAd0WFLZ?=
 =?us-ascii?Q?Ya+K4V+9kJGDP5ceFMTzXH0hdWWVb8t72WqOSHVAeIEfS5CQ0z2M/8KhhBUf?=
 =?us-ascii?Q?4U9MwJZdLH5gB3ZCuHVQ7ZGJQyQREDe48gtEkrzhdfjN+WLYWHV+xyF7w8M6?=
 =?us-ascii?Q?NIWKaL9N13C0vafeq0NnaQ3s5xCyvqRXkiH0yQTO6zBWlxDSkSAVoxD6iCQ5?=
 =?us-ascii?Q?NlJxtIqwRNQYBWsW+W7o4Y1wSNfdOY8wZrSL7GbafzBelX4Kw1qlocxsA3sm?=
 =?us-ascii?Q?6mGbxp7YIcl0u2RgMY0Tgz3xk+Yz49storRAXVMmhm8Zl9c1ihGUDSc7+p3a?=
 =?us-ascii?Q?odj0K28FrkNviS9jNcaTESkVj4XM3T60u4EA1q+4xXIiUFyh3S27f68WLlg4?=
 =?us-ascii?Q?MmvJxUjXIerAVQTDveJWId7vz0cr6rS53tiZkycwwri3kFmPLUMHLws3glCu?=
 =?us-ascii?Q?DduyhTe4gym05b2T/xh4FJ9474RCFlcrukXTYllWjw/PLMd8GZnxkYrKQGmS?=
 =?us-ascii?Q?bpWxqo5wmIEXG1G4iE2Ln4/PpQeh7KxY4S7Kz1Omq5H7r26JQJY11L5ipkX2?=
 =?us-ascii?Q?kB87zHSIb8pWZHRR8vOrWxF4h8uZDs1tsN+GRdknKgHj2ZU52z88o5NhCLBp?=
 =?us-ascii?Q?U51oWaFajfIjxs31l87qBIhqMhpDcSzVUmZGrlB6TjL5L8GlpKp/9lSvxX/9?=
 =?us-ascii?Q?hjxnCD10q51O1xSRZoLfNk2bfYFhxLzBsSVbMVpLd6SI6RTXLec7vo6iIVNm?=
 =?us-ascii?Q?I3E04rjdlbQ9KIqunqqV3YzM7SW+CNOmUD+LOhNSl0FvZjEucNhwlJXWhOyP?=
 =?us-ascii?Q?IsMh6NCwuLcPUl8qjULrpOKhGb3QHYeOxCVVqRmiJgeZiYw9nde3NmK00F1G?=
 =?us-ascii?Q?sF0hbn2GXwZDV9SzDGXI2sHIGU88TQQ6SxirOkV4KxZW5K7UJl0SE8D/pvir?=
 =?us-ascii?Q?OnG9zfDaqiAAm9u97ax9wUVUyebZGi/ZRp8pzvo8OziEIsuLXgVFLYK55eAL?=
 =?us-ascii?Q?Uo//9kACX14O0HhqAxkcntcT2tfHihD0nbsd2i3y7LSZ4UavMTRIZAYmntN+?=
 =?us-ascii?Q?LblCJJY/WH+OB+ElbeLXFL0a9vyoOkEhNoTWt494LeL4f6cUpHGtlH5v0vIq?=
 =?us-ascii?Q?uON0rscrivBdxGMxrulK79nti6sDL8ME2JPKjdU88fvoe7DpGID+9QcgQOJM?=
 =?us-ascii?Q?vjZNyPQkbUFBtjxfPD9VQU1Cek9I8HBIAgqB/hlbxqF6vc0CurteVCZmLgDm?=
 =?us-ascii?Q?izE55aTvF3llDlBlBqj7KAVKzahwzKLy2f0k56eDMA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v5ga7ApDoX6UeymkhAM77sLOrKw6CfP3XGBzdvG19Aj9X74AAq5TLMXo4N6E?=
 =?us-ascii?Q?O6RQbXFAVuCV5TWc+BgbBBuWDMWpKT8FefNsbWAVFHOCfHysTkNWXXGomdng?=
 =?us-ascii?Q?O9Uxqknw5eQD1J/CDh6x8JhzJqs+tZfCOkopAAVhZ49+16KxuZVoo84Cl1+9?=
 =?us-ascii?Q?5SibtWrr/N2GIk50VRqd8n5Xpn7kkyLgFb5aS6E7HYZiCO4udrjyyWqg+KAi?=
 =?us-ascii?Q?ECAW2aXKkIg4t+POnKXo4Can49m3btcXaZvjh615syZaTCQjtH8Naq+CetQi?=
 =?us-ascii?Q?9Q/ZrMedglfhUKb1b085oaLd60pS/ou22ELaCbNp4ShdCY0tPd9jFn9SD7Zr?=
 =?us-ascii?Q?b2BJiZ0sVM5m95zeIqUaV04uamOox5HJvFJraPNjEX8l3KnpBdVW96xPla6Q?=
 =?us-ascii?Q?1SumAfATEMHG/8RYa3lU+YKnoLaCCrYnwPaGXVDRaTpDjiVGltltwxsKV7D3?=
 =?us-ascii?Q?asneIo/kRqOU5vthY1gWrCS7FhmEQz60E/WPLcm5u0EMkYSfJ3XcUSgO44mT?=
 =?us-ascii?Q?VatdiLioJ9/g1cQ56kpBrqn58zK/ENahxxvG+SaOJhdL2HwPS8Gz8pnaxeQs?=
 =?us-ascii?Q?upek+fA/2WUstIqUB40p537ew9jiWnWo8TUNP+TJqN7ClEDknipbKkuUsjBZ?=
 =?us-ascii?Q?/xJ4BqDvOiKDy6VHr/QCokp2pcamCO3dmbkczQL8qLYlR0pW2feggZHzcslK?=
 =?us-ascii?Q?2VF1coS7ZY4N5/Y8mkh8bsmTSeCgqTDTOowjf2FEYXe/Y/Nos5pQxQkcfmD+?=
 =?us-ascii?Q?BFK5uu/IXjzuEIimgFjydsbFrk7WEcYvaD3/dwl1KI/OENGAn7kwDJYCMHMx?=
 =?us-ascii?Q?K9fbBbzab1cBvyHjHBSi82hUNmP0/deScCBmn0+ypZ579drMPfmhIw7kZlZD?=
 =?us-ascii?Q?WwDSFgTLXvONjzObXQ7SGfR6gq6IH4p7sof8lOrTY6hC9/ke1qNZXpUSOP1s?=
 =?us-ascii?Q?nPlGoWWlAZ/GfpMe4cmv/mdMsoHQCEmZP8Dqz1pYxBQMq+82cOwVsQUoDmPJ?=
 =?us-ascii?Q?SHGZ+LfGqjG5gH3AC6pPkYV5cGONJOXg69UEYMyo80/SC3la5z8Kmr0VbL76?=
 =?us-ascii?Q?/DAisc2T9+qYQsVkTwoxtcNYqnThKevNmGscrimfo/PZNBgHDEI4XLHDjEMw?=
 =?us-ascii?Q?tDkTGMhD4L1OHHSJL2ZsczKinb+LAXU4VtVFv//urTzmzz4xdtDrwoZBjcI1?=
 =?us-ascii?Q?6725VvRt/G28CzD9+3c0bYASqFFWWP2eOM0HL7hpaMge/OOozTSRxj563a70?=
 =?us-ascii?Q?COrWNX7NRgrMKiptllEChZznfSUJzPWEgpzo5j7dHURScVgELY+rAV7KIuGB?=
 =?us-ascii?Q?9s5sZeAPZv/oR6rNFjFkb4mPghYtwrjjr2PaVkyHVEsH4VWDGJICXEIA1Ueg?=
 =?us-ascii?Q?sfoUbd4XwAmGxX7ItT/Rg02hQFBOPsrvtq+PJnyUo8YQdOm0Bs7S3jEc4vgm?=
 =?us-ascii?Q?IQhNQIK3yAMqWpfi0uSquv8BVFW4qcjSiSvnXUT2anTilEB5sirGC8/zXm5x?=
 =?us-ascii?Q?3uHk3ccPaYm7B9GS2egDSlIc+VQTr7gLdXwoEuyrUZdrET7v/DjckeqItgBI?=
 =?us-ascii?Q?G1yb4PlHT7pdluMp1ojerjUP/0Y/VjGXC7eisSdtyuihp7xXWTfL6xLk+BmU?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cd46a4-461f-43d7-0485-08dc8c38b5b2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 06:10:37.5709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbCw/OsMWiV4tcystnGciOhVr088kuqn8l9bKbdxx/Z8sfu/6RkFq9wwUjIVwxUvlhjcgU06K62xV+FUlSKl7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5244
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:inconsistent_lock_state" on:

commit: a7f3813e589fd8e2834720829a47b5eb914a9afe ("usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      d20f6b3d747c36889b7ce75ee369182af3decb6b]
[test failed on linux-next/master 6906a84c482f098d31486df8dc98cead21cce2d0]

in testcase: boot

compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------------+------------+------------+
|                                                   | 920e7522e3 | a7f3813e58 |
+---------------------------------------------------+------------+------------+
| WARNING:inconsistent_lock_state                   | 0          | 9          |
+---------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406141323.413a90d2-lkp@intel.com


[    9.059145][    C1] WARNING: inconsistent lock state
[    9.059806][    C1] 6.9.0-rc2-00079-ga7f3813e589f #1 Tainted: G        W
[    9.060791][    C1] --------------------------------
[    9.061452][    C1] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
[    9.062377][    C1] swapper/1/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
[ 9.063151][ C1] e7491784 (&syncp->seq#2){?...}-{0:0}, at: __usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1651) 
[    9.064334][    C1] {HARDIRQ-ON-W} state was registered at:
[ 9.065080][ C1] __lock_acquire (kernel/locking/lockdep.c:5091 (discriminator 1)) 
[ 9.065718][ C1] lock_acquire (kernel/locking/lockdep.c:467 (discriminator 4) kernel/locking/lockdep.c:5756 (discriminator 4) kernel/locking/lockdep.c:5719 (discriminator 4)) 
[ 9.066493][ C1] dsa_user_xmit (include/linux/seqlock.h:423 include/linux/seqlock.h:470 include/linux/seqlock.h:495 include/linux/u64_stats_sync.h:146 include/linux/u64_stats_sync.h:182 include/linux/netdevice.h:2763 net/dsa/user.c:928) 
[ 9.067097][ C1] dev_hard_start_xmit (include/linux/netdevice.h:4903 include/linux/netdevice.h:4917 net/core/dev.c:3531 net/core/dev.c:3547) 
[ 9.067783][ C1] __dev_queue_xmit (include/linux/netdevice.h:3287 (discriminator 25) net/core/dev.c:4336 (discriminator 25)) 
[ 9.068380][ C1] neigh_resolve_output (net/core/neighbour.c:1573) 
[ 9.068989][ C1] ip6_finish_output2 (include/net/neighbour.h:542 (discriminator 2) net/ipv6/ip6_output.c:137 (discriminator 2)) 
[ 9.069558][ C1] ip6_finish_output+0x88/0x334 
[ 9.070027][ C1] ip6_output (net/ipv6/ip6_output.c:247) 
[ 9.070340][ C1] mld_sendpack (net/ipv6/mcast.c:1822) 
[ 9.070679][ C1] mld_send_cr (net/ipv6/mcast.c:2120) 
[ 9.071008][ C1] mld_ifc_work (net/ipv6/mcast.c:2652) 
[ 9.071340][ C1] process_one_work (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 include/trace/events/workqueue.h:108 kernel/workqueue.c:3259) 
[ 9.071709][ C1] worker_thread (kernel/workqueue.c:3329 (discriminator 2) kernel/workqueue.c:3416 (discriminator 2)) 
[ 9.072097][ C1] kthread (kernel/kthread.c:388) 
[ 9.072390][ C1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 9.072726][ C1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 9.073080][ C1] restore_all_switch_stack (arch/x86/entry/entry_32.S:944) 
[    9.073490][    C1] irq event stamp: 9450
[ 9.073816][ C1] hardirqs last enabled at (9449): cpuidle_idle_call (kernel/sched/idle.c:192) 
[ 9.074473][ C1] hardirqs last disabled at (9450): sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043) 
[ 9.075191][ C1] softirqs last enabled at (9444): __do_softirq (kernel/softirq.c:401 (discriminator 2) kernel/softirq.c:583 (discriminator 2)) 
[ 9.075819][ C1] softirqs last disabled at (9439): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[    9.076487][    C1]
[    9.076487][    C1] other info that might help us debug this:
[    9.077082][    C1]  Possible unsafe locking scenario:
[    9.077082][    C1]
[    9.077627][    C1]        CPU0
[    9.077881][    C1]        ----
[    9.078119][    C1]   lock(&syncp->seq#2);
[    9.078439][    C1]   <Interrupt>
[    9.078691][    C1]     lock(&syncp->seq#2);
[    9.079016][    C1]
[    9.079016][    C1]  *** DEADLOCK ***
[    9.079016][    C1]
[    9.079612][    C1] no locks held by swapper/1/0.
[    9.079964][    C1]
[    9.079964][    C1] stack backtrace:
[    9.080391][    C1] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W          6.9.0-rc2-00079-ga7f3813e589f #1 f0ecba0cf7deeaf8786bb8219ff9a6fa3c51532b
[    9.081435][    C1] Call Trace:
[ 9.081686][ C1] dump_stack_lvl (lib/dump_stack.c:117) 
[ 9.082053][ C1] dump_stack (lib/dump_stack.c:124) 
[ 9.082359][ C1] print_usage_bug+0x208/0x2e0 
[ 9.082769][ C1] mark_lock_irq (kernel/locking/lockdep.c:3971 (discriminator 1) kernel/locking/lockdep.c:4013 (discriminator 1) kernel/locking/lockdep.c:4216 (discriminator 1)) 
[ 9.083119][ C1] mark_lock (kernel/locking/lockdep.c:4678) 
[ 9.083437][ C1] mark_usage (kernel/locking/lockdep.c:4564 (discriminator 1)) 
[ 9.083765][ C1] __lock_acquire (kernel/locking/lockdep.c:5091 (discriminator 1)) 
[ 9.084121][ C1] lock_acquire (kernel/locking/lockdep.c:467 (discriminator 4) kernel/locking/lockdep.c:5756 (discriminator 4) kernel/locking/lockdep.c:5719 (discriminator 4)) 
[ 9.084452][ C1] ? __usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1651) 
[ 9.084879][ C1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:267) 
[ 9.085237][ C1] ? local_clock_noinstr (kernel/sched/clock.c:301 (discriminator 1)) 
[ 9.085624][ C1] ? lock_acquire (kernel/locking/lockdep.c:467 (discriminator 4) kernel/locking/lockdep.c:5756 (discriminator 4) kernel/locking/lockdep.c:5719 (discriminator 4)) 
[ 9.085975][ C1] tx_complete (include/linux/skbuff.h:2228 (discriminator 2) include/linux/skbuff.h:2336 (discriminator 2) include/linux/skbuff.h:2369 (discriminator 2) drivers/net/usb/lan78xx.c:3334 (discriminator 2) drivers/net/usb/lan78xx.c:3385 (discriminator 2)) 
[ 9.086304][ C1] ? __usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1651) 
[ 9.086700][ C1] __usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1651) 
[ 9.087089][ C1] usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1752) 
[ 9.087462][ C1] dummy_timer (include/linux/spinlock.h:351 drivers/usb/gadget/udc/dummy_hcd.c:1986) 
[ 9.087807][ C1] __hrtimer_run_queues (kernel/time/hrtimer.c:1692 kernel/time/hrtimer.c:1756) 
[ 9.088197][ C1] ? transfer (drivers/usb/gadget/udc/dummy_hcd.c:1781) 
[ 9.088511][ C1] hrtimer_run_queues (kernel/time/hrtimer.c:1932) 
[ 9.088869][ C1] update_process_times (kernel/time/timer.c:2467 (discriminator 1) kernel/time/timer.c:2485 (discriminator 1)) 
[ 9.089230][ C1] tick_nohz_lowres_handler (kernel/time/tick-sched.c:274 kernel/time/tick-sched.c:294 kernel/time/tick-sched.c:1480) 
[ 9.089638][ C1] ? sysvec_call_function_single (arch/x86/kernel/apic/apic.c:1043) 
[ 9.090076][ C1] __sysvec_apic_timer_interrupt (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:260 include/linux/jump_label.h:270 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1050) 
[ 9.090509][ C1] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 (discriminator 3) arch/x86/kernel/apic/apic.c:1043 (discriminator 3)) 
[ 9.090949][ C1] handle_exception (arch/x86/entry/entry_32.S:1047) 
[ 9.091305][ C1] EIP: default_idle (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 arch/x86/kernel/process.c:743) 
[ 9.091654][ C1] Code: ff 89 da b8 fc a2 30 c3 e8 6f 7c 4f ff e9 e8 fa ff ff cc cc cc cc cc cc a1 a0 ea 65 c3 85 c0 7e 07 0f 00 2d f6 ed 17 c2 fb f4 <fa> c3 55 89 e5 53 64 8b 1d 00 32 64 c3 f0 80 4b 02 20 8b 03 a8 08
All code
========
   0:	ff 89 da b8 fc a2    	decl   -0x5d034726(%rcx)
   6:	30 c3                	xor    %al,%bl
   8:	e8 6f 7c 4f ff       	call   0xffffffffff4f7c7c
   d:	e9 e8 fa ff ff       	jmp    0xfffffffffffffafa
  12:	cc                   	int3
  13:	cc                   	int3
  14:	cc                   	int3
  15:	cc                   	int3
  16:	cc                   	int3
  17:	cc                   	int3
  18:	a1 a0 ea 65 c3 85 c0 	movabs 0x77ec085c365eaa0,%eax
  1f:	7e 07 
  21:	0f 00 2d f6 ed 17 c2 	verw   -0x3de8120a(%rip)        # 0xffffffffc217ee1e
  28:	fb                   	sti
  29:	f4                   	hlt
  2a:*	fa                   	cli		<-- trapping instruction
  2b:	c3                   	ret
  2c:	55                   	push   %rbp
  2d:	89 e5                	mov    %esp,%ebp
  2f:	53                   	push   %rbx
  30:	64 8b 1d 00 32 64 c3 	mov    %fs:-0x3c9bce00(%rip),%ebx        # 0xffffffffc3643237
  37:	f0 80 4b 02 20       	lock orb $0x20,0x2(%rbx)
  3c:	8b 03                	mov    (%rbx),%eax
  3e:	a8 08                	test   $0x8,%al

Code starting with the faulting instruction
===========================================
   0:	fa                   	cli
   1:	c3                   	ret
   2:	55                   	push   %rbp
   3:	89 e5                	mov    %esp,%ebp
   5:	53                   	push   %rbx
   6:	64 8b 1d 00 32 64 c3 	mov    %fs:-0x3c9bce00(%rip),%ebx        # 0xffffffffc364320d
   d:	f0 80 4b 02 20       	lock orb $0x20,0x2(%rbx)
  12:	8b 03                	mov    (%rbx),%eax
  14:	a8 08                	test   $0x8,%al


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240614/202406141323.413a90d2-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


