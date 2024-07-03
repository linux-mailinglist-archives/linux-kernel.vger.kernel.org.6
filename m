Return-Path: <linux-kernel+bounces-240155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C0A9269B9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5387BB21795
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F69318FDCC;
	Wed,  3 Jul 2024 20:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRzmlE5k"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA16E17BA9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720039858; cv=fail; b=UTh3vrzpsd/0uXComcD9EdTW2EobIeXDBSE9oMJpVlr2ECR3iDRz7MgmfB4fSlhN3e3xNs7gAcXOJOQAsGkkzca3P8A/oJxTK1cLoX1aPALelXIhbDl2vXOfCz/hc1KNVtInsn/lYAyHEtIIRxrNru3LmyH03UMSftkJiXZNjSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720039858; c=relaxed/simple;
	bh=uWXyz4miDTm/0k4oHCFMb5yRjmhMFio9QWB11sX0JTM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ot6dZAlblh2/+5rBrCBIV7WjCDLLSHtaawSm/xWZpXCLeZ15JuG5pqPTvmiEAsN4nH27Sd61fFKjHxLBxuHsgE6tHIlMaalDwvuFMCNTPdrfbzWc/CZU8TuUw4OiI77gw9KmzX4vUD3PSqKA/tGHGbbwK5AjuXyrxRPYXO3NnWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRzmlE5k; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720039856; x=1751575856;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uWXyz4miDTm/0k4oHCFMb5yRjmhMFio9QWB11sX0JTM=;
  b=VRzmlE5kcjuoTPGUps7FxmnaQUvjuiihj+6cAmnus5w+IixwlR4n6r4l
   rdpichtVUUI9/xJcVRuBx5IVTkx55cLWSg919wl5kvdazI5cCSoC9+H/q
   p+gELRTiEE2EJyNPZFQirl662OstFyX/CAYrJaa9BfJ/ujJ2EN1+/MjLn
   4D9ieZ/RrBiW7lC0oYendOOVGJ39NXbih0OJbmtOzYMitS95vA5TTm6th
   yJ4NLEYvJc/gl3IWmQr/MxjHZwucJZY7a/anYHbcZ9lnibKi63GtnalG9
   H5M21h84x+kZZSGeB1RZtIlFYTDTSNP1W+XHw0vIbXIrgFpnt0dY71N4Y
   A==;
X-CSE-ConnectionGUID: RdRHY7U+S8WwB6mxrFjfjA==
X-CSE-MsgGUID: vZ91/gNhQDycO2PUwu+IvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17133249"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17133249"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 13:50:55 -0700
X-CSE-ConnectionGUID: +k8M+T9oSUKKKunjrSJU+A==
X-CSE-MsgGUID: wXXzXXZzTQuNzx/l5Dmyhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="50826081"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 13:50:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 13:50:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 13:50:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 13:50:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbMoOeTjM5ZtaUDmdL5pF8V4ISYoNKDdsurx7mVZ1WwPUQ4UyNOgB+Rf+YIAOV0yDs/QO94dkoDGuktAkiSEBck6gyJs7b2AjLfhU3jsNPfrqCeIk5wSVDtc7jxo/wCP9xpw66wccJ1g5zVY6IfypUzY6f46lsHUmcuFTWG+9xW2nXG5kyYo1a7owla2b+UO68bJt0OpOta7G7CQ6it3ODwrnNOSpuKvPTmTL0b048Y5xROwG+RnfKkmP50JfVaDGSJDrRbsa4lqPDvB4YIeMSXZId6wPqrZxEkkG3Ae5a+5UPs1QH0fu/aZCDK8xDw29MsyIGiiIQgSOxV8ITbkXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0tk1ULg9DH2YhxweVnW9hctG7PqWAccCxZeJUWPJqQ=;
 b=XCzSPVFPz5Dh8LMoN68Kiij1aicnCq4tGyge/iGp9TyroLRplLIk3fv+J2/9POsZf+Exk9mTs8KCEJpwuzbG2C/TTogGXMLHbpo7aVPBY4mgDLwSvPip40rWLML+H7U+tZOnrs9+pYPT69okkhaIhpYDYy2/hmo9X/OPuFyw69Zw1Kj3DVN27Z8a7eptVC925k8GdYtJga/I9KuRPOl709IwJC8sy90JpUFneSx2xalpFusR+o5NRt3PbH5ZR8LSsm58pj5DzyQVbbRBclchh1LK3tNJUUuWKv9zo2GUk8i238w3aPiXZWgWaH9B0it8/J2/eBkYq85D4lapOHFdFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10)
 by CY8PR11MB7033.namprd11.prod.outlook.com (2603:10b6:930:53::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 20:50:51 +0000
Received: from DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::19d3:28f4:c53f:8431]) by DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::19d3:28f4:c53f:8431%4]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 20:50:50 +0000
Date: Wed, 3 Jul 2024 13:50:37 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: "Chang S. Bae" <chang.seok.bae@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <tony.luck@intel.com>, Yan Hua Wu
	<yanhua1.wu@intel.com>, William Xie <william.xie@intel.com>, Ashok Raj
	<ashok.raj@intel.com>
Subject: Re: [PATCH 1/1] arch/x86/microcode/intel: Remove unnecessary cache
 writeback and invalidation
Message-ID: <ZoWZG75hFpfK6kkv@a4bf019067fa.jf.intel.com>
References: <20240701212012.21499-1-chang.seok.bae@intel.com>
 <20240701212012.21499-2-chang.seok.bae@intel.com>
 <0aa05063-c9ed-465d-a7d2-e5fa0bc6379a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0aa05063-c9ed-465d-a7d2-e5fa0bc6379a@intel.com>
X-ClientProxiedBy: SJ0PR05CA0180.namprd05.prod.outlook.com
 (2603:10b6:a03:339::35) To DM4PR11MB5262.namprd11.prod.outlook.com
 (2603:10b6:5:389::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5262:EE_|CY8PR11MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ff7841-10de-40fd-7953-08dc9ba1d295
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hfqhoJR1YTulhHmZ6aODGjWYC5p5krXL7cejj1BNldv5KiP1zrZE9KD8I2zD?=
 =?us-ascii?Q?LPBT+ysBhEOvJw77QkRJky0qXlStr1RJx6OT49MjClZfNvgYQEfOjezsWSSK?=
 =?us-ascii?Q?tME9yuYjUFM/+4I73dw61Fd4ftc3pd4qbWuS03vD4ESS/x9nBlMyNuepHdk0?=
 =?us-ascii?Q?Q4kwHEP3eaysr2gbPmnwxMcCdOl0uOa+AKD70IxLk2QwBskdAwsz+sMzg/sg?=
 =?us-ascii?Q?NNZb0cUoMYHxCYYdTNdOOKCFVENPHL1zRaO3vxfiitsAz+6KFPaNnWEeqCBK?=
 =?us-ascii?Q?uUo0EuhoQ8i0POfOF/++43XMy/t3FYkfw547DsVRvs/s+/1n0FVj2rBCzht7?=
 =?us-ascii?Q?8LpYA43z/pS3HLHW5VeDJSI8i84/QyIT0cCbJoc4Tgx+0x8uctLvIH7tKXWd?=
 =?us-ascii?Q?mL3/Npnv+kXbF1TOCzF+bThHoCdSmeG7RzNdOLmf9Lhp66Or+j36CwXtiDyI?=
 =?us-ascii?Q?qSmM2vQhXT3z4C5xj3lsbJxRQxINoKdzpSxjzOeQq9SkFkPYU6lrsBEVGFXF?=
 =?us-ascii?Q?9vlPuu+V/YqsPJgsQ1ZD9wqpiXcbe5Y2PkPl4uhjJNIzv5DqaH0CGRf2f7wd?=
 =?us-ascii?Q?nqN08P3HOPsoOvhsXw9Cn2VphRKimyVlQbasXG5WJLojsrsgiNE7ainwQoKs?=
 =?us-ascii?Q?DVqx1687f0Oz1OUAN/E1Ya//zqxNMnw8/m+HVhvwjKMQXpQI2qgs0xrD/uDZ?=
 =?us-ascii?Q?o45myAqIA2XRD7yHIBPJwY+CyHygLy5XJ9PmDLsVHSwUh1kLvLy2zRKsBFU2?=
 =?us-ascii?Q?ldXrvP1UxImF07gZQK14aYIbrMuSmSEnPBVcsvy8yqpQbkmQa+d0N4UkAwcN?=
 =?us-ascii?Q?jm3ra3vG1Ew6yaYNW9S0zhArEqLAkGBYSIAL/SRQL/Twqi6S/nNq5Q6p6KiZ?=
 =?us-ascii?Q?AMyxIS76Uy/asO5jxGWGJ2cS2xGb6qLqPp2AIcIhWfTp4+FflIeHOQMWzctT?=
 =?us-ascii?Q?/VLC1A+c50QQjgVWUdKK05e70y8hTw1dCVwz0U/IBVeIKYOuxHSO6zkj5fFP?=
 =?us-ascii?Q?KJxjAx04PPIRlSEyqWPv6Uhg9wguFL2IgZ86dyjYq+N3PB9xJ+xat3XqL55s?=
 =?us-ascii?Q?o/E/9mZvbeizo9WMfxF8FtN5Gr/z1rAIXq1vXhCNtJSiCYV/Ff4XSCsFZHmS?=
 =?us-ascii?Q?cTTI34Uc6ZP7JiOFVO0bxOACecuC3vWh6MzeZtsIF67tufCfu9edVz1B5FZK?=
 =?us-ascii?Q?4AscFQuy29fSu17nzMkBZq0nOebyezP//JwmliPRKbHxH3MdCawAKk/IOyAv?=
 =?us-ascii?Q?g8OlYk9h1Uor2qJ/XihUK/swr3pWxYD/b6QGfylkfW3/+/daRn5EklHyBu+w?=
 =?us-ascii?Q?4ns=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5262.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cM14oBiWnSPb8OVmHH+UQswc6YcoPx4BKAMgUEIDKGElmKe/IYbvlmgmCLsZ?=
 =?us-ascii?Q?nPLpTfwZYy5+XDQoK9fBnfFKhIhVGicnOFykDlm5pogepnO1JrjCqDWneNxZ?=
 =?us-ascii?Q?RDnzbngCeWhZ8iu8DizpwYqeZkcF/uWJTMqTbLjVZliNiOrSNgow2FXFnmAf?=
 =?us-ascii?Q?XpXAFxa0dBQrPq4Kzw7raB5BfKQCs4G8jpfBQQyEvDAWpAwga8K+66ASpKr3?=
 =?us-ascii?Q?WKp0BG/eKoyMwE+xpyOzEyXbscQ3r4y19ufEx4dN40n1vmi0FEEnEYYRXvBP?=
 =?us-ascii?Q?10eFjNJ4lKTKO2T2Vuoq6LflPSHGj5ZqL5j8sjnhTNkjXPP4qx6Xw5Cc6HoR?=
 =?us-ascii?Q?H8XzegcLboczTHEh0kVJHE6P07PVkfJ9K/4qJgvtxlh5d/G4/sZ80y/UjBPF?=
 =?us-ascii?Q?4xqHQe7qPjfh7ZvReutE3TlVPhouAz6fEilak37VDmfWei3MaAUjQva7f1cF?=
 =?us-ascii?Q?y0QY2h550pKGLk/GMjg6KNLKG/XuwQdpUWwtDjj+ReVg2k/BkVSUoT2Z3fIV?=
 =?us-ascii?Q?cuBDSPpVGsHvQO7cQji2CmXKO6YTAwv/aqC3E6SnURVy0qkrV8aZC5e8LoJU?=
 =?us-ascii?Q?oX3xRqkeo6sk8Vpx8HFjyjC4WlUrS3MDwbqcAwYPAYyU3rod6p2uh7Ous56j?=
 =?us-ascii?Q?TqfBaHUApJeObZhZlYHTx7JE55cWx5bDyjUiuzFu1A7Z94hZSr0C601Yr5LU?=
 =?us-ascii?Q?ETsEacrFr6Xz8h7hHH1NyyfhwKq9V2t7g5yWjdBZUK/QQ+17ch9CINNs6qFw?=
 =?us-ascii?Q?XA012IzpkWpy+8smwWVmnlEPYEkloHeR2KqVmChGO1xgISTy7jX1BHJp+ySs?=
 =?us-ascii?Q?QEz4BxzkdYUqSerf2iNZhhmHDYuvx7e9CAdueCG44pY5szRAicCwOA8rFF/I?=
 =?us-ascii?Q?Brek5AqzQnL8pLATaqHikRqvLU7SW2KNVYa46Oxcq4JPmWLwrw68vXGOP84c?=
 =?us-ascii?Q?zU1YnWWs0s0DoKCOukvkVgUO+vS4C4ieryeQEyq0zG9ETfQWaoN/bxF67tU2?=
 =?us-ascii?Q?UMwod3G8rQpXEbzg+8tPUPAmXDgfUE3tbEzYWBCry0OPhcz6nU5DgvbG6P3d?=
 =?us-ascii?Q?9Lyhair9EpsbcRccPpIeebLyZJb+zusol2UXwL4zyd9jjnNHSABOmr9rci68?=
 =?us-ascii?Q?xpnFz/whQTMncPcqp5tvgERObwOXK15yw6/bb11S4jqXe/LAta65cBsMx8Jr?=
 =?us-ascii?Q?sDzUGQUaURQu0/ATjP7dl9hYcM9ncyvWUIw/ne6P+nhyRDY0IA8Dn4FERG4v?=
 =?us-ascii?Q?ey8ynYiI04UL52Inxbd6KYdb2gQ1yoCSx2VBK7EBs2fF60Dq+hBNc8pnyKdR?=
 =?us-ascii?Q?CY65pUrk4bdfK1XF/+DKyHtXOOV0I+QW7MiAR2EFsSmZFZMBoRxm/wQUGLHR?=
 =?us-ascii?Q?6oPshNkhhkF96940D+dWmfC+cHAEve3GZnLffB7w/+4BoLtHHnXzIRqlY/Bc?=
 =?us-ascii?Q?8ZjMajmIacOd65AU0mkfBY/1cIkFcdP90yQgNKqt94RWtytOGf2LpOfqtGuF?=
 =?us-ascii?Q?dOvNA8ZUx3kEBhfxIiDDmZhzGXiK5mG6gxKb+009hRw6kwrPAUIX6qS7DL1c?=
 =?us-ascii?Q?fmtP8PyJrBvsvEdNqJC580wjbdxAqbrJu6YTBAHf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ff7841-10de-40fd-7953-08dc9ba1d295
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5262.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 20:50:50.6097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvYcnHsRLKelVDsoDYWJmdH3Na73+dZPZha47etzqmKo9wRx92DMd74K4Hgc3MWzWU4uXfGbYQ0pgM195+Tgqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7033
X-OriginatorOrg: intel.com

On Mon, Jul 01, 2024 at 03:56:20PM -0700, Dave Hansen wrote:
> On 7/1/24 14:20, Chang S. Bae wrote:
> ...> Remove native_wbinvd() and update the erratum name to align with the
> > latest errata documentation.
> 
> I'm all for simplifying this code and also for removing any WBINVDs that
> we possibly can.  But it also makes me a wee bit nervous that this could
> have been hiding any _new_ issues (like the Broadwell one) had they
> crept in.
> 
> I'm tentatively in favor of this, but it's definitely the kind of thing
> we want to apply early and get maximum testing on.
> 
> I'd also appreciate an ack from Ashok on this one.

Thanks Dave. At the time when wbinvd() was added, there was no
confirmation that we didn't have any other products that slipped. This was
also during the meltdown timeframe, so big hammer was choosen for safety.

We attempted to remove them during the minrev rework.

https://lore.kernel.org/lkml/20230130213955.6046-9-ashok.raj@intel.com/

Agree that we must get wider testing. Only caveat is that you should find a
newer microcode to apply, which might be difficult for all products. Unless
there is a debug option to reload force the same rev in case you don't have
a newer ucode to test. Its good to get this in to reduce the big hammer
effect.

Acked by: Ashok Raj <ashok.raj@intel.com>

-- 
Cheers,
Ashok

