Return-Path: <linux-kernel+bounces-416945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E249D4CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEC44B2417A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E146B1D174C;
	Thu, 21 Nov 2024 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k2obz8BG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42441369AA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732191571; cv=fail; b=d5uziS9WRfSi3I6KYHNjT79s/RemJQ6JMbBQEsZJrNSsFJXKdxyxnsx30f2m5v9LyWxRJupKINPOd+ycDxY5FIWH4TwYDlTivEj6754J+aymy15H3Kn3LMET/Ca7ajkCnrOgKshN3SLusstPWNBupBHLejbK3olqyNGkAfC+IoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732191571; c=relaxed/simple;
	bh=lXwRDh9fFJ+2gYo517SE4vauGVx93rYNt3tikXi1PGU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hFltsv27+Lcf6Pq7LPl+b8RRRQLQHLN3mZ5I1rjY1AguohqeFsX9KZHVxhxz33X7xfypliMYoU5XpAIBk7VXmJYHQ7RsnV4bmWnCYxpr0viXlMKIZ2FXQQ9/q0VLcjncXzMTo9uULqIX34KYC0mSlXPcsU0kSlya66b4kR/qo6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k2obz8BG; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732191569; x=1763727569;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lXwRDh9fFJ+2gYo517SE4vauGVx93rYNt3tikXi1PGU=;
  b=k2obz8BGgqT0ol9Ilc7k3IUyhDQa05yKGpC4syS4OBc8tvM/f0Bn6aNm
   BbBOzAdLw2s4NsXN9sDyC2dU7sgOCc/kN07OOvcEXCRsDPdGIpRnFiMq4
   oHiEX1q0pAuyP49QYaPmdGWRRRWrIuh9WelW73wmC7r1TNEAGe7UnPybY
   tnUtyjCZGhF1YY0FtdrT4Y723OclwuXqOFNr+N4M94mSgn8z+Ye/CQbTz
   KY3TcMGYiyl6PXIblVZyn6cV1hqAhux/p3l/TOCPmnHd7MipzUbwk6Sac
   ATXWpdLN3pfx8I12ZVeatMSf+9m0kZpTW/rc8g79tnsWocMaKUcvhiXc7
   w==;
X-CSE-ConnectionGUID: 26nsfzQVTmimFnhvt0yRHw==
X-CSE-MsgGUID: vCUMqsbhTvKxt9dOIUb+RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="36081817"
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="36081817"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 04:19:28 -0800
X-CSE-ConnectionGUID: vRPpIkV5TKqzqe7rbEOcjA==
X-CSE-MsgGUID: pAsYbqv3Rm2H4YWL3lApgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="113510803"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2024 04:19:28 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 21 Nov 2024 04:19:28 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 21 Nov 2024 04:19:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 04:19:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XttRRHZQfid+bOT7/YeWseC7otam2mCiZDxf5AxvGSl2E5B4LSWHn7eFbyCgK39y+XmI93X2zOfr+mXaw+kYQ21f/MgddUmdNiVcJxrvlHXE7eEQVafV7IV5M5N0mOAa7opfCroH9/aKGn4WMoG5hUT0PYvY6CupDUj9cSFFc4x1krkY7I0vQVyr+0P1GF96N8GeV/9TMP9V8utKAYMl9uv6wsiu0pYdIUhyBmRPoUHwsIxML9PyJccHcMLzK1Z/jAu/gFrmbtYUieHBbk05oVrDG6NVOSV18gU05Sbajf9G9dpWyTuffjgLO+jcuzgj4JXUgLeoTLuchBTBKoT5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UMy9TcSL9UhytAfai/Ti1sMHCE7A82b52Jd2XGQrQs=;
 b=mx8z/IhS8yIYUoPcYn6e6gDMrbvVI2pIlb1wWVswX7nlKwZ/h0WcqwLIWV8LndWG8s+rel0n3Gu1a6dpT8RRrZMbvg6btUuEI0IDA952oAaPNabIMYL9veJbtFUzz/IyfS2JN4JblHdOizPWAvrYiv0NIe9W++kKwINzshCV/qd3QPBCgO3UyboMiuOEPijda0EQKtdu2cLOF46Jm6Jk6LM2La0Oryc9daCY+V0h5v+Tp7EtD3MEhKDhCPt75DcxlcMwS1TdqOYYSoFGsXkcUOLLf71JQMnp6kD36b0rsWlV4GatsNc9ohI5pduAD3aoPPOZl86MDsFN5jtx7xEXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by MW5PR11MB5929.namprd11.prod.outlook.com (2603:10b6:303:194::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Thu, 21 Nov
 2024 12:19:19 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%7]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 12:19:19 +0000
Date: Thu, 21 Nov 2024 20:19:11 +0800
From: Philip Li <philip.li@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <Zz8lPx3T2ZDVxlld@rli9-mobl>
References: <202411201356.pXoYlKFB-lkp@intel.com>
 <20241120100526.26705a95@gandalf.local.home>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241120100526.26705a95@gandalf.local.home>
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|MW5PR11MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab8b43b-f364-48b5-e7be-08dd0a26b97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3mDChL5lFv6VPl674oCU9bKYoUCKFyfrEpHssinsBOBG00bda3Ywzn+DKSPd?=
 =?us-ascii?Q?q+cxkLDxXj+fxaeHq4SSdC7cmByGX7MQN3LOInHUnUP0mXS1RkX1RSIG6mYi?=
 =?us-ascii?Q?p/wKypULgaBHiWoK/Pg2l9uhQXs5kPMi0XbxoFDpJ9VnJDR//KU2rO6a6zXS?=
 =?us-ascii?Q?Ga3+C8/3zatYpndHjMmJsEjVneYV+u3Fj9xGvDpJN2tUMOiuOVJcPXW66T4P?=
 =?us-ascii?Q?VpJWS6AtqmzVZJR93j1fAmNh/VYPjPKV6zGornZ3Z/NMRsvPDByEtNInsRoq?=
 =?us-ascii?Q?uYx1SbGSlTHdUDUJAlEwKN1/PkYOzqC2Gxg5mb9+KoXT8wwlQas2bUujCg/g?=
 =?us-ascii?Q?+FCq0YGEkGCyNVNJNu33TqAuxZ5tCM1CSvVn6qS8l2qQ/w7J9+URVt8CJ3ec?=
 =?us-ascii?Q?kurgCdtmAoIVhTThjMhlxxVhx5KFKGzeKg29aLMAyHmKvKoZhwyUWgksimbj?=
 =?us-ascii?Q?JxJPCSipFQBQ6RmF/Hlsde+c0h7egt7aXW87fBc/MbWISt8SyX36vdrXk7to?=
 =?us-ascii?Q?ImSG3z1MrcwnaC1rAtfxJSHZzIY7jHkK+a/FAf3y+fWgKjA3si4lJWpGFVlt?=
 =?us-ascii?Q?dE1Id7iU3d/bNALuR5a8rGdDleR9N/USiJrTZ5q11Wm6E45irewStDs6UpcV?=
 =?us-ascii?Q?3t8mFTO9tDuqczJNclGTTuQHo0K7jTKdr6HLiczlWUV81CbU8WNZP5cJ01g0?=
 =?us-ascii?Q?76nuUSyWJ4LwKU1MY1OAoIBz8+X86aoP1YTDXe0b6BSiLAaXZvZbzeoovB7C?=
 =?us-ascii?Q?JLFURRSMOPpjsQhOmcIUpy0REhpwOmvSQPOS/WzcYd1m4wIZNBKDJkQoqUxz?=
 =?us-ascii?Q?ZpUoU8hb1Jr24OGZT/0ymdlCpWS+01ntwMNxhYHOk21JJJjenucZXJkVLQ7Z?=
 =?us-ascii?Q?aqyS4HOK95Tj84k4uJj+XGymYwnjGuqCsbHNyEkis1jjkaNCGEIAH+c37wq+?=
 =?us-ascii?Q?qDASthIXBgMOEE/Rm4LkrU6mlobwQBGroInFSjXi0I81oBDI7SZYjmpuZPOH?=
 =?us-ascii?Q?PgNne9W4kowL0HsnEz2Un5A4EK1z3g2wUWWsOyUK8KlyRE0BR3wd4pEmUgE9?=
 =?us-ascii?Q?NNjFRQIXif/GrD6WHSV0M55Y5jAVRbKUYk2GAp86Y4p6as62LYUpIxx9Eteq?=
 =?us-ascii?Q?CFTNa/DDadeSNwOm0hyIAcF7D+NEDS65BiAwP4XK0kL7hL+X8PfLJWqX/2tg?=
 =?us-ascii?Q?9hfWhyddEpT9dfY4eU2G5eBfAsP9G4NqXxQdcY7ZAV+a49HV8gceu9Cv0vSR?=
 =?us-ascii?Q?W1kVequwHabb/nof1LYDXVEol+G6NL9V+10lXPj6cg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZcZrpjrXqwN634ah8xgYznToof2GeyXa3TMuvuFZ+wKSr5wjy3xBB8azYxsz?=
 =?us-ascii?Q?Df2o1ijqRFGO8c/sGmtGNaLLaElyqmX4zwTNk7eNFMD3eY8s9DpqacTbmsTV?=
 =?us-ascii?Q?SowQCwfvpyg9tn1CMmnecPdSvTHO8EIx0bYVjEdhlQEOn96gy1nmlQarLO2K?=
 =?us-ascii?Q?hdnaTP1Ma8OGziIqyEyKaol8c1hl2kBswbHzM0pYSt00waVwcCQV4/ssWtaP?=
 =?us-ascii?Q?18Shz10oY/tBcMIBMakOr5Vu3Y0TX+KaqaCKMjpmOf643KW5gdPguA44x50/?=
 =?us-ascii?Q?QJB+CpRhwqYFVe4HIMjuHWcRVLlg7ozQvbCk5uFkoGYsQEiUR2ghmPjWEGgV?=
 =?us-ascii?Q?re4wfUM2FFkoZZE1n35E9zLXhWCRLTYTDHYH4cd7/W6X5/iqAR1/9Fi9EEsF?=
 =?us-ascii?Q?n7sWnWrggSzLqhhmyb7wtcg/KfCMsjzOc+ZpQbd5q1zfopiH4C/BE2FQ/cEZ?=
 =?us-ascii?Q?oNYwoR5zx+XYpIKpZoK7sV8F333ggxUnLuo4rLJOOyE/d1mzdTth61NoTSRm?=
 =?us-ascii?Q?x8i2Ly0M0MY0tMOH90vGZ4KnlwO9cVPRj8svCKHAxcCpFpjAM02AzW8CD9Fn?=
 =?us-ascii?Q?8E0yADSsPlUCpIxHTQ3jLiTKJwkZS90oGjerHp2QlmOIRNUS+73Ja/Z6oGUy?=
 =?us-ascii?Q?qNnBl+E30APhXWVA61/FjX2kM4FCABwNYf/ChT2YxnXW3piNtqRdCV4O25nt?=
 =?us-ascii?Q?fPBpGjX3SvsASbx92BRw54Tfx96DV0QnES0yC4wWOtBEYXRdSND50bJ7ykz9?=
 =?us-ascii?Q?oDkdHE6X43NJ/5O4EHiASIT0YAF9aunK9m8AE0LlVy9RVDQc7jQDE5Ch9CJd?=
 =?us-ascii?Q?dSjt1U9tQBv2YhwGMPzfB8U71VEpbvqZ3P8sNDAgomSe8ZTtdx+5nq0DcL0N?=
 =?us-ascii?Q?sLvoLicDKhfgw+Q3x1VSsZDeVjwHDz6iyF1zYehRjctnFA6M7yEl/Sak1Etc?=
 =?us-ascii?Q?X5RNO0kU11CYQVODkHzKoaekquzHsZYsTb7vUV9n227nbmL+d2b3F7gpiedz?=
 =?us-ascii?Q?Yqtm4HUKilZZjuvjSUpjWfg701gVnoNtUEatJiEJD0v6OZYOYK/8JNkH6V9D?=
 =?us-ascii?Q?oPoa6YrxXKkMNEsAT4Y3vvjT8XdRTGICJs61fmzYKAA1jTtl6DRB/hlDfZK7?=
 =?us-ascii?Q?4EHtcOJ/Jm0+fdBygldAgkXdWs/rF4kvLYgBAnGN+46rmnumm29A9uwLOPs9?=
 =?us-ascii?Q?no4ainvjTAN3NqDHPeSElQ3jrU0QzoI+imi+vZGqvJkLMW3AAhNJsLLENJ8m?=
 =?us-ascii?Q?lUpNLNPnjSRtIa0+xHHqKQ1rOnUG4WGrTSA1UUZOZkvB5BJkwoAfMSLD87sS?=
 =?us-ascii?Q?V/rBHLKq0i9TWKkduCdLjVvO0tuvxS1cSAuGhhg3afsZe5QEEgPwPlHpeFMc?=
 =?us-ascii?Q?XEqIcs5OG13LIA5tIrZ1N23NmD186f57kJTW/ERBJkkVNWi0+VDcz36gTdHb?=
 =?us-ascii?Q?h35WIvIEtDxv8oqpFFqPInYKFbZJ1yfyTLEw1vNkcUUqPwwwkBrVe9RlpJ/m?=
 =?us-ascii?Q?okvno6pVqhYoWW5Cze9Cc4zggO10vfGY5w0Zlq6kT+tLA32fF/FNRSKAPdbG?=
 =?us-ascii?Q?H1cMKuFaKjs9P3b8wpx9KocZi8fx31m+2y/LPMD1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab8b43b-f364-48b5-e7be-08dd0a26b97a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 12:19:19.6386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQ6Hh0TmVJXMC647aCCycTgZhG1bt8eTvFynamPIfrdiKnUhPEFgKCTYFFNeljlgdZAOO/99oNs1bW3sPc7FLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5929
X-OriginatorOrg: intel.com

On Wed, Nov 20, 2024 at 10:05:26AM -0500, Steven Rostedt wrote:
> On Wed, 20 Nov 2024 13:59:39 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> > Hi Steven,
> > 
> > First bad commit (maybe != root cause):
> 
> Does not look to be root cause.

thanks for info, we will ignore this commit to avoid report this issue
against it.

> 
> -- Steve
> 
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   bf9aa14fc523d2763fc9a10672a709224e8fcaf4
> > commit: 59cbd4eea48fdbc68fc17a29ad71188fea74b28b KVM: Remove HIGH_RES_TIMERS dependency
> > date:   3 months ago
> > config: x86_64-randconfig-r133-20241119 (https://download.01.org/0day-ci/archive/20241120/202411201356.pXoYlKFB-lkp@intel.com/config)
> > compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241120/202411201356.pXoYlKFB-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202411201356.pXoYlKFB-lkp@intel.com/
> > 
> > sparse warnings: (new ones prefixed by >>)
> > >> arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected int [assigned] ret @@     got restricted vm_fault_t @@  
> >    arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse:     expected int [assigned] ret
> >    arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse:     got restricted vm_fault_t
> > >> arch/x86/kernel/cpu/sgx/virt.c:60:20: sparse: sparse: restricted vm_fault_t degrades to integer
> > >> arch/x86/kernel/cpu/sgx/virt.c:354:36: sparse: sparse: cast removes address space '__user' of expression  
> >    arch/x86/kernel/cpu/sgx/virt.c:385:24: sparse: sparse: cast removes address space '__user' of expression
> >    arch/x86/kernel/cpu/sgx/virt.c:385:43: sparse: sparse: cast removes address space '__user' of expression
> >    arch/x86/kernel/cpu/sgx/virt.c:385:58: sparse: sparse: cast removes address space '__user' of expression
> >    arch/x86/kernel/cpu/sgx/virt.c: note: in included file (through include/linux/miscdevice.h):
> >    include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
> >    include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
> > 
> > vim +59 arch/x86/kernel/cpu/sgx/virt.c
> > 
> > 540745ddbc70eab Sean Christopherson 2021-03-19  32  
> > 540745ddbc70eab Sean Christopherson 2021-03-19  33  static int __sgx_vepc_fault(struct sgx_vepc *vepc,
> > 540745ddbc70eab Sean Christopherson 2021-03-19  34  			    struct vm_area_struct *vma, unsigned long addr)
> > 540745ddbc70eab Sean Christopherson 2021-03-19  35  {
> > 540745ddbc70eab Sean Christopherson 2021-03-19  36  	struct sgx_epc_page *epc_page;
> > 540745ddbc70eab Sean Christopherson 2021-03-19  37  	unsigned long index, pfn;
> > 540745ddbc70eab Sean Christopherson 2021-03-19  38  	int ret;
> > 540745ddbc70eab Sean Christopherson 2021-03-19  39  
> > 540745ddbc70eab Sean Christopherson 2021-03-19  40  	WARN_ON(!mutex_is_locked(&vepc->lock));
> > 540745ddbc70eab Sean Christopherson 2021-03-19  41  
> > 540745ddbc70eab Sean Christopherson 2021-03-19  42  	/* Calculate index of EPC page in virtual EPC's page_array */
> > 540745ddbc70eab Sean Christopherson 2021-03-19  43  	index = vma->vm_pgoff + PFN_DOWN(addr - vma->vm_start);
> > 540745ddbc70eab Sean Christopherson 2021-03-19  44  
> > 540745ddbc70eab Sean Christopherson 2021-03-19  45  	epc_page = xa_load(&vepc->page_array, index);
> > 540745ddbc70eab Sean Christopherson 2021-03-19  46  	if (epc_page)
> > 540745ddbc70eab Sean Christopherson 2021-03-19  47  		return 0;
> > 540745ddbc70eab Sean Christopherson 2021-03-19  48  
> > 540745ddbc70eab Sean Christopherson 2021-03-19  49  	epc_page = sgx_alloc_epc_page(vepc, false);
> > 540745ddbc70eab Sean Christopherson 2021-03-19  50  	if (IS_ERR(epc_page))
> > 540745ddbc70eab Sean Christopherson 2021-03-19  51  		return PTR_ERR(epc_page);
> > 540745ddbc70eab Sean Christopherson 2021-03-19  52  
> > 540745ddbc70eab Sean Christopherson 2021-03-19  53  	ret = xa_err(xa_store(&vepc->page_array, index, epc_page, GFP_KERNEL));
> > 540745ddbc70eab Sean Christopherson 2021-03-19  54  	if (ret)
> > 540745ddbc70eab Sean Christopherson 2021-03-19  55  		goto err_free;
> > 540745ddbc70eab Sean Christopherson 2021-03-19  56  
> > 540745ddbc70eab Sean Christopherson 2021-03-19  57  	pfn = PFN_DOWN(sgx_get_epc_phys_addr(epc_page));
> > 540745ddbc70eab Sean Christopherson 2021-03-19  58  
> > 540745ddbc70eab Sean Christopherson 2021-03-19 @59  	ret = vmf_insert_pfn(vma, addr, pfn);
> > 540745ddbc70eab Sean Christopherson 2021-03-19 @60  	if (ret != VM_FAULT_NOPAGE) {
> > 540745ddbc70eab Sean Christopherson 2021-03-19  61  		ret = -EFAULT;
> > 540745ddbc70eab Sean Christopherson 2021-03-19  62  		goto err_delete;
> > 540745ddbc70eab Sean Christopherson 2021-03-19  63  	}
> > 540745ddbc70eab Sean Christopherson 2021-03-19  64  
> > 540745ddbc70eab Sean Christopherson 2021-03-19  65  	return 0;
> > 540745ddbc70eab Sean Christopherson 2021-03-19  66  
> > 540745ddbc70eab Sean Christopherson 2021-03-19  67  err_delete:
> > 540745ddbc70eab Sean Christopherson 2021-03-19  68  	xa_erase(&vepc->page_array, index);
> > 540745ddbc70eab Sean Christopherson 2021-03-19  69  err_free:
> > 540745ddbc70eab Sean Christopherson 2021-03-19  70  	sgx_free_epc_page(epc_page);
> > 540745ddbc70eab Sean Christopherson 2021-03-19  71  	return ret;
> > 540745ddbc70eab Sean Christopherson 2021-03-19  72  }
> > 540745ddbc70eab Sean Christopherson 2021-03-19  73  
> > 
> > :::::: The code at line 59 was first introduced by commit
> > :::::: 540745ddbc70eabdc7dbd3fcc00fe4fb17cd59ba x86/sgx: Introduce virtual EPC for use by KVM guests
> > 
> > :::::: TO: Sean Christopherson <sean.j.christopherson@intel.com>
> > :::::: CC: Borislav Petkov <bp@suse.de>
> > 
> 
> 

