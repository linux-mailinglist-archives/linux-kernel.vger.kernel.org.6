Return-Path: <linux-kernel+bounces-279813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4094794C224
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82F21F2990C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA4618FDDD;
	Thu,  8 Aug 2024 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+PipM6j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D62A18FC99
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132722; cv=fail; b=Vuu+PLBw0nb6bIy87EEwXEGjRWCvgV1ejKvNDswW8rqKgZeJ6Aif617Pyu8RpJFavXEyt/kw/Xn4EHXJDNy91rtfR+ZqHm/9xKhJoBK6joJmLBLKg/Y6KflNQR1M4ykG5lCWK2qDeC5Qy/4DgYJRYoIj6hXGYV0Nrnq9DLY1taw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132722; c=relaxed/simple;
	bh=xiRmcSyZRK+KY6ldEPSYA/a9/uVZfecpjC4ReS3y8wg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aZib84nJSCsnwaCWUBIpmTFdGcjM6EmLKFkCSLGae5qOO6eF2gxdzJpxhDNYZwHzVe+bAnoDgZdTir7i4q5UkgUoi/wKbo3ubUjd/9m3wd7K1iQdt6vrCxg07EIlE1/ZjVpEdKH6QzNKcWmYNAh2on3NeWn240DWOByDemBNxUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+PipM6j; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723132721; x=1754668721;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xiRmcSyZRK+KY6ldEPSYA/a9/uVZfecpjC4ReS3y8wg=;
  b=L+PipM6jXBtoT++zgXaimgAmeFWw8RJAVjGsFgNEaXhuXN5umGouHy/s
   XpU6kXh5dsb5AJ4n9u/XYcq4GEx2ALmYSFMw1X7ps/PsI5MckiYkMkgSa
   oLuzc4rJw9kL+I6lrsxsVtS213Uw6zpUW5m9a1UBcxeMCcejMM3PFVptI
   9aeqXUoD2pszEUqlLbkna77NeXRq3ogDjDL8nOOIremsQOprP5bxsADkr
   C93Q+X2hX9t2wLLDxNCDFjU2/Hkgv4qZ0d3CRTgxGgBfLq/PbUNwoB0q2
   lZp028qimVLoc+qeXtAig4vmqd4tCjqtlGuwMefq+l3DPO86dKz/vG1Tc
   A==;
X-CSE-ConnectionGUID: 8xioUg+FTAC9zcjVXzSj+A==
X-CSE-MsgGUID: gbmVxm80RU22EqrFp4bQkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="46674606"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="46674606"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 08:58:40 -0700
X-CSE-ConnectionGUID: 2EAnueETTLavvpw6/MvSLw==
X-CSE-MsgGUID: tlN9Dq7gSmehEfbqT8RCBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="57499310"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 08:58:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 08:58:39 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 08:58:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 08:58:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 08:58:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5H/ba5MWkveeykuvF/fsCVOMjcbcJdMPyaYgyhaSFA4h8DkwwzHF1VtJZ8i/AWweNrQgDQ9tBpw1S9tcxNeit2xLAWQ6VWDW9IEcoTjW+/uJlpqgfrazyyjUwTf+PDSWKe31ymCSkLHGvBwVCITjyTk00FmFgpNSGFSvD4w/eDs0rXUt0e1c7cLEAm+4FRfbe2hJ/50Q9FMhvg8EJ9oB0Vwo0NeJnYx6k5ND/HRkyhAIQoNb/wdsWn7lvvSPt6L0SdqyId7saPTBiFHdtPoUTbtxpEi4jH/d+Wx7mf9nCTbpyUBmlUI6g7pBHVv6SBRJl59Kz9ewhgX2Bge/1bB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoDlVG2PLSpOcUDApGeqGQdXAAmWXXt1IrBObMlndj8=;
 b=J+XrcBgPsHl7jTqvfSeB9HRFR5x8UJu627GH2IEkfhBECdKxnMC2wEg1stwURBbZbY+jLZ5RiD8N0qFvp6fq3rl2CkJQ95+/36KTwshioOYgcCFkdBrGgaqC9xWd0/LQBp/Y2hH2wRWB1K0mq4nsQrXk1vqa+YR9a91If8Q+vCZMNArUI6F/TIeZ/YJtafa6fzLOnlTujKKTfUruR/6js3xvFwp3uhV4Abjggg3S93/sDMYZEQVFWEQzyiosQ70cGGdBKL9rqYhFOKxen9MaKJz55E6hs4K4Za119lzjH/JtwdURyXemlEj+xq5PkSDZVEVPebX+HjnWm1QyuwM+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6873.namprd11.prod.outlook.com (2603:10b6:806:2a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30; Thu, 8 Aug
 2024 15:58:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Thu, 8 Aug 2024
 15:58:36 +0000
Date: Thu, 8 Aug 2024 08:58:34 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Max Ramanouski <max8rr8@gmail.com>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>
CC: <max8rr8@gmail.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>, Dan
 Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
Message-ID: <66b4eb2a62f6_c1448294b0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230810100011.14552-1-max8rr8@gmail.com>
 <87le17yu5y.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87le17yu5y.ffs@tglx>
X-ClientProxiedBy: MW4PR03CA0313.namprd03.prod.outlook.com
 (2603:10b6:303:dd::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4ca221-e9dc-4fa8-f5f9-08dcb7c2f657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O/6QLE9yAWGNehnw4bSdwmbpC3138UQTJyqBZwDiSzmuW3IN3imzASPXoh3f?=
 =?us-ascii?Q?CXlkr3y6RLiX3cgOH7H+3BFcBHeukzClkUAWZEBj2cqZJmUrSsxFVsO5jV/q?=
 =?us-ascii?Q?4cZ8uQ6irfAp+mNcb+hwv7gS1xv03tLwoh/x9xMrROtj01KnbzG0+LFfVyWx?=
 =?us-ascii?Q?nMjDXWpHkqe7Y28ID5jt2o48jHaatvwFLUL1Yrt5vDXZhvSTRCKGrTQCbLRz?=
 =?us-ascii?Q?atHVVKv5m3jFjHL2Q0r0vTnC/UpADKoAbMuEBKVKCXE7Gy6Ds7TjWZkozyWF?=
 =?us-ascii?Q?w1KgOKEY3pe0ayjS9/ByKMU2or19v8FpUdHsZXHF58o5YqYR05KLiWiTtCPb?=
 =?us-ascii?Q?6UG5V+P5oPR1KdF4VGMcjHGGwGuh9N3pCBwUDzVpUz7JDEDdFAo95i4Vt57Z?=
 =?us-ascii?Q?iT6mBZSLuXyldYEuvjAOXUtPPvS5ad6yVlMpIMn49RpBIICojGl5yEjgoAfr?=
 =?us-ascii?Q?ocTgwyx1Uy6p2adS7IHvjo6GyalK9WDH1UvCEq8gn2nXpOV+DKpZSJ/Jo5CL?=
 =?us-ascii?Q?zxIj1A10WuAwKlF8jnNoY1Kgg6XXuHcCoFwkI7xHmDO1TwJRlHx7YLvv6Guq?=
 =?us-ascii?Q?Nm3wt6maNJEjK9Pa6Zm42FCHbPQjFclgiyMoUIfwkkxQBTeXI7amFc6aXKt9?=
 =?us-ascii?Q?OJqrL7nJCRbH50k3/Ark/PhBiwuz5UMEwAkheemH6z6+k5IISvfOopDC/l21?=
 =?us-ascii?Q?j84XRtjH8fp5DkLeampnV13210gAqcsYMZXise67oSEmTwe4GnAq2XMaHaPC?=
 =?us-ascii?Q?htoRIW2KhHQND2CZwn37XrGAtqUqYEGfnn7yAi5JEaqPY7gs9WgTj5QbRWeF?=
 =?us-ascii?Q?lzgjBKzxjSO0Ty/+wyEojiMrsGaTlmTGbGrUOBTr4ug0KgYf9JMs2uyvpqam?=
 =?us-ascii?Q?y84ykco6FykNBa903hPph/A4us6xYIyK3AZX5dF09Vg3meJ4qN2saC+7jcCg?=
 =?us-ascii?Q?yntTfquEA8vu2n61XA8v5hoZ84I9CZNSBYHwB6bPD6q72T7+SWElEG88nT3d?=
 =?us-ascii?Q?Fd2itu6jrVzPHlCxojzqGjQKm4UgLynFT3Im0nbitDqj3/dBjepSJW6DXacj?=
 =?us-ascii?Q?jKWk6BminJPEqGkICJRKuHwcVlgAdKpBKBwHoaBsYXVrP/DVwzn4EvHspnsj?=
 =?us-ascii?Q?xy6PV2oi1ax4MHwE8oclwaN0uOZ8ynHu8LgUizqvm97VpfebEH/lLUfBWPhR?=
 =?us-ascii?Q?oM3bUqqIGZ88i144GIz91AckPQypCzc5RHC/JMLrOgkWUUdvlnF6VdSnZ/B0?=
 =?us-ascii?Q?ivRaN1OASo7N/fdztNWqNpRYzGX2t6pjLLj8dwHI9X03OYhEnQ9xEHB3g/m6?=
 =?us-ascii?Q?3MAsAg4CrV5q52aX+d62ujZoRNiwqrItY0GG7n+BIVMP6w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bS1ChX+bDcAOA84Dht3+NzSIq6pndJL9BcWbb9y0Me99RzLcIdXy7H4wG6N4?=
 =?us-ascii?Q?RJRNRA4J1ZGtQx5Egvp8ADOnwDzMxiZ2Uo1hyCHTjQp118EZCFobz2k4ZU0H?=
 =?us-ascii?Q?qvkKObxirvBB8+0DKRV3jlp5P2q0qvh0R+G3l2xNIwmlyo7omIsYkMSm83dr?=
 =?us-ascii?Q?UIIO3zfL2UBQxtcdqrpYyIv5wnbtJrk1cBtKWwVEO6jJHNUq3Fcqbfg6K2gJ?=
 =?us-ascii?Q?gXu/Dmfjs5bHGVb71NfNZ8rkZp7+to7V3VReaLZCGq9EF5llyK/VG7bFZiTy?=
 =?us-ascii?Q?b4JUcbjS9x4NFOBsGoLZR6BKCOGeQyVN6awSpkrIZjYnNkVPWiuLMiXWVRMu?=
 =?us-ascii?Q?ut726bDZcIQ05h0vRNQ7YpU728N3Kt7p2nMQax1tIyU7Zjh3tVs85CCZeYUL?=
 =?us-ascii?Q?MAOR8Nk65loCR7UUdmfM2MULQCqI3VBhGj6k6HA0qeVJKC6BTFzOSF9C1n3+?=
 =?us-ascii?Q?Bo7cwkHayxHJGdgMrsUJPvTdx+81dhZS3l/pdZvGyHNhOtabERfQas12C8bU?=
 =?us-ascii?Q?YHKenRl37k2+8sE/g0wNAnTID0vZ13dhfByAhOAjjEynWzFetEAEyOAlUgKG?=
 =?us-ascii?Q?SB+Ttn9guGCSk0pYVhsgVpGvko/cQAVQJGgblTM5bTKppye6Zmoy3wmokUbm?=
 =?us-ascii?Q?4UGmziSUhJIRNiw11LAO5l8zf63X+0dwjDmqijHQdF6kwGwzejulujhJehkr?=
 =?us-ascii?Q?ZPtDpVIYWeVIOB5M4msCTi/U6kZU1CmdZhdBDJrlJWW6Hkk8NeVnCi3HK9G1?=
 =?us-ascii?Q?Wm4mY64AxkNrBI2IIg0+Wg+1PlvPUebtXhd6UKkWXNUpiQQ0i/sfuhOiHiDL?=
 =?us-ascii?Q?Vz7R8A2N9MvljzTaqjnb6x82k74okrpI/XQf0pTJyueTfQUNr3ZwnSKZvuVQ?=
 =?us-ascii?Q?oRoIxarmDg9BS3rFIwDfyDzVitR0lpVuhg/oDcTaZrYvKwSRSGXYj4WzOMsC?=
 =?us-ascii?Q?NJP0ZKAQ0G3keoPSxw8yNV1Eddz1lD/xaoKAxdpDIsz32VhPOgqeXnbeXumV?=
 =?us-ascii?Q?7oCHNFyYpjP/HLAzWrNA2SG6zeuLhn3+oVf0zpi0RWzmDDGH85wAzlOBPK0C?=
 =?us-ascii?Q?T66OxFccHaGDteuJbCw7nHq5H4KxdZxiHmj+hiI7aGHRF/18wYg5ccC9ujJp?=
 =?us-ascii?Q?FRKxmWU9fXHI16inLVaYOKRN9NYZUwDk4GAhm6E/N1bpgjn0lgr77WkpvltN?=
 =?us-ascii?Q?THBNpiu1D/t6TFRzIg9cbL0qVmfK3s8r8p1ngidLEGzPQvIh/8K5qxOf4wEQ?=
 =?us-ascii?Q?CaLaIUPvP6LSXLaOaVoKMdCLcIGMT/lm8YCaxoos8mhPIatND9isihMnBKds?=
 =?us-ascii?Q?3GrtzQXWFHAOLzdcm8UwzdbQocekzDticx9eHYbDHQov4c5VBz/52gvGRPzZ?=
 =?us-ascii?Q?NMMf3v+OZ/WlRdsrHAFwBrCbLyyQFJ7r1y9jV5OWTybVHbLW+fDQ7g6yu0Jf?=
 =?us-ascii?Q?6JQPFD+482PL7GuyexCfVqcSNzohQVabRyA0cwaddNHLO/9l06V5OVdtq18K?=
 =?us-ascii?Q?BdYFx5aA1bpWDTZgXAyafDVQEPEVpRHnlG5wu2atiUEZo5t5LOPiZ9H//twn?=
 =?us-ascii?Q?pQ2WzmI+DaIwf0+7zbaZAD8Q44HiCp/d9YurfHhMEi1R9z7dkL0xRsyGQy0O?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4ca221-e9dc-4fa8-f5f9-08dcb7c2f657
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 15:58:36.5639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+u519ymjlz6afse172tcUACQTJSLZz62+TNYcbRBZE/LS6SbhQ7sFRN1+VR6sOBS/n+o5tZS3s1alp6x1ngC3WiRi88S3ah5zxUgAq1vpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6873
X-OriginatorOrg: intel.com

Thomas Gleixner wrote:
> On Thu, Aug 10 2023 at 13:00, Max Ramanouski wrote:
> 
> > On systems that use HMM (most notably amdgpu driver)
> > high_memory can jump over VMALLOC_START. That causes
> > some iounmap to exit early. This in addition to leaking,
> > causes problems with rebinding devices to vfio_pci from
> > other drivers with error of conflicting memtypes,
> > as they aren't freed in iounmap.
> >
> > Replace comparison against high_memory with is_vmalloc_addr to
> > fix the issue and make x86 iounmap implementation more similar
> > to generic one, it also uses is_vmalloc_addr to validate pointer.
> 
> So this lacks a Fixes tag and some deep analysis of similar potential
> problems. While at it please use func() notation for functions. In the
> middle of a sentence iounmap does not immediately stand out, but
> iounmap() does. It's documented ...
> 
> This add_pages() hackery in pagemap_range() is really nasty as it ends
> up violating historical assumptions about max_pfn and high_memory.
> 
> Dan, who did the analysis of this when the device private memory muck
> was added?

So that plain add_pages() usage originated here:

    4ef589dc9b10 mm/hmm/devmem: device memory hotplug using ZONE_DEVICE

The original memremap_pages() only ever used arch_add_memory()

    41e94a851304 add devm_memremap_pages

When HMM merged into memremap_pages() I indeed did not pick up on the
nuance that HMM was wrong to use add_pages() instead of
arch_add_memory() which updates the high_memory variable:

    69324b8f4833 mm, devm_memremap_pages: add MEMORY_DEVICE_PRIVATE support

