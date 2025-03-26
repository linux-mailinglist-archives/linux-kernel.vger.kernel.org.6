Return-Path: <linux-kernel+bounces-576592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512FDA7117C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC0F174631
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554FB19D884;
	Wed, 26 Mar 2025 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmQyVOT7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0374A19CC02
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742974608; cv=fail; b=hdrm4DNJJ74klun4bGpuuY912mT/DsvO5Gv6Gm1GzS6WWNM/Sdv4SD7WsegEI11aC/Ux5IQ/IhKZTtkyO9T7ScoBDijb37B9cEiTbw49TM7r7yx3PAAwu42mftg2ap4fNn9OQIn2vlwGtuNDSvJ9wo5MO6a31CSmvQMG/ZNwvpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742974608; c=relaxed/simple;
	bh=s6Exev+t723dEhV0sFHyCdK1JUeQujNu0954pm6MZzI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rSWZMpx1NDugqSdfdWQgrBmOFEJkxfNhcpu95zV+iTsYNBGLi7CBL6CKhZ8rgJBPQXC6f9HzxjJIx4m4vuwnFVBPil0oCUTtfwXIedWfrUcTJOhdcMA0cliCpe0c8WzLnMNcsT0WtdfLLY7tsftzDeJAaqCaEkahH9rEV6B2gZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmQyVOT7; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742974607; x=1774510607;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s6Exev+t723dEhV0sFHyCdK1JUeQujNu0954pm6MZzI=;
  b=MmQyVOT7RkdlNBW/L2QBxqoNejCuX9FsPvVtalFLGziEQ4Pz2ng05Vq7
   hFu5cjiXZO+REd0IkwW6HAiwgeKxvSub1pXgOlHrKKanFxjkBuZrzSnF+
   di0SsUGCg+jr5h4WQ4SqvpskXiLGz+/nsWKD+d3THwIRTYLZPgD2TpQSz
   7LvHj6s9dnwBXJqkOfrs48fTyw2qD3LXwrSjJWbpNZvpckbtlLMTqEwvI
   a0ntgxBDXeQkd+7wYICDoMUxTFUqLwGTB29loIfRQT073yKGPNXkREQxG
   0u9ggNJ+2Plt+eMmUtxwfpNAf/2E+PyaSj34FcXEWyLAq66Mp3BPZxGjj
   w==;
X-CSE-ConnectionGUID: LpA5uwH4TUy1muokJZDFzg==
X-CSE-MsgGUID: jN04sHYaQuaKLuuJMaXwHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="55615516"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="55615516"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 00:36:46 -0700
X-CSE-ConnectionGUID: YMLTCbHpQXGFpHkB+F5b6A==
X-CSE-MsgGUID: aRCNV8g4T/qxSOV1CJGL9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="125194095"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2025 00:36:45 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 00:36:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Mar 2025 00:36:45 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 00:36:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQVRZP0BYnYCVOUIfXnjR7kSG8ivI3dFgX7gQDUoudrRyj8KTPPDiDn6CQGMiuZqfz2xUnN8ooGdBjcztkoWEdAdyQeXjb5vQtoa9xo2fAfNwtxXiJnYt9tPYEwnSSBEn45qw7gC54RAL8NF9PnR2wSfNOokqvIjSBfvda7oQvOPAvKMTi1A4mh8k33LUAD+aDODeP09R8/QY+gwskDLdMVMUzKaxyNLWtQnStPJXTuHH1SQwIjIKC+ijlTP+o6fc4Nf9w1CFVIa4DBSOKVqjAtU0JfwRRE+N/InTL4wNMG/g6x+QINTkY8SKw3xwjWq2MTThV65PzVbW8jk4qf27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byskaXG9Q+BBhg8m2iFAg2h7SQfKdjlaFw0zxviFKzI=;
 b=Xg3kya3wmC5w4Fp+9Cueyt8W2bGCrJViEKfNkNyB/MVOEfUSG0IRlbIYKHdhqIoFXbAw+A8Ei2j54V48Wpwl0bSW/Qcm1guRWEhin7sbT/cwuTsITiJ09DnvYz8/XCRYpQipQa8NdeeicH2ZuUJGRYaJUBlua545qWM3Kc3hnUit94/GyqzohXKWFyB63f0/LllT45GQdS4CvmBEf2kHBPYaVOguFNn5JY6eYRBYUX+bZa4pGFpIIfgE0RvyKhQTOn8U8IT5/ND/GZFoYpCoOL1n0WdTu7dNsFUawQiVRuX1xD/yskTo4HZelEACsGSeo5OH7rc9B35s8isgK5cOqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CY5PR11MB6368.namprd11.prod.outlook.com (2603:10b6:930:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 07:35:40 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%5]) with mapi id 15.20.8534.042; Wed, 26 Mar 2025
 07:35:34 +0000
Date: Wed, 26 Mar 2025 15:35:25 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<colinmitchell@google.com>
Subject: Re: [PATCH v2a 3/6] x86/microcode/intel: Establish staging control
 logic
Message-ID: <Z+OuPbNGC6mOCHZ1@intel.com>
References: <20250320234104.8288-4-chang.seok.bae@intel.com>
 <20250321211853.13909-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250321211853.13909-1-chang.seok.bae@intel.com>
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CY5PR11MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b81cf7a-39e8-44c4-8302-08dd6c38cb92
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JhWzs7KCUXU/Brb1OV2PnF4QDaN544wKxhKC2neF0Ye5hiHApIvcjrsli9as?=
 =?us-ascii?Q?HkkArw0h4PcsxCoKciMTBP1v4Jfi4Vb+x76dnWjLeDz/gQsvAZj3tvvWHNFP?=
 =?us-ascii?Q?KJUAAg0JI0XLoMaOrH3OFry9BfJT/ECemN8BME7T31kebVWU44vhhE3RByEd?=
 =?us-ascii?Q?uOjxWv214z5bq4We4V0xkMHJeLInq70A4qcfHNLuuAArMCImQbafxCzpLb3q?=
 =?us-ascii?Q?5RR4WB5dmIJDzVjur14BLOoQmeLw7WlA2OG8wgYa2mnFl6E0JamJGTXTViUU?=
 =?us-ascii?Q?XtHWVatovVUahSMZbIA2by3BznNLpR8RloVnxzxJslYeeFyBgBLWyua8fkLV?=
 =?us-ascii?Q?6dhmXXjWOnoa6GGHJSFXiKRd8dofoV9J/1AG6FaLJ+jqp6qJnbIyVZHrJd72?=
 =?us-ascii?Q?H2lck7/Ou4LGKQ0KgBTsLMvGLl7GVIRrsJlSMRS3gWlwcXE6hQ8SbqklzCIA?=
 =?us-ascii?Q?uzJlq6zwU1nJAIkH+8CpK4DQFcLNpRgEXlP/0HKu7Awx7gprHmaJiRlrgWYD?=
 =?us-ascii?Q?aviS+/faBto18T3vb1CW11rGUpaDK+f5hpvzgStsj+v5iTT4HsjsJgcWFLAh?=
 =?us-ascii?Q?SVIpUCLlqiYMIfcxVI1oJ+GrllSqjclmD1gIgNENd2jqkvlA6f+N61nh1YdM?=
 =?us-ascii?Q?YIo3YHBd/dO/CIY4y+M+raPjRYtegbjS+ufI7aBbUGrxqevsng2DZzYnldNg?=
 =?us-ascii?Q?0+7Y6R5vs3YIXCQAXDMY56k5Ab20mwEoLEu6Yb838Je/WfFnorEOvJ/47Jf/?=
 =?us-ascii?Q?ccrXkHh/s0OZ8gQ7lGl21eT+eIpNStwQmhMq7Y6SO/MLLn1R2m4o+JgthV9P?=
 =?us-ascii?Q?+XlzxSeXQX7kwgQXTkC35jDWY3i7nbGu/D68boUX3IsxhmR/4fKU6i9IA0h/?=
 =?us-ascii?Q?KbEdmrTca/okpivVpZR0nWolcMSq1JqY4WxBrxYNdyTClxtldFI//n/ykvEd?=
 =?us-ascii?Q?c+Qa/4cXr+Q6NkHXvE/EL4EW2yUF2dtp4mEtvce08D+JiW7npVhbQXHjlaog?=
 =?us-ascii?Q?2AwuyI4deNxNU8swN/0gezLi3a4grv8YzN70VP92MVi0E9J3eghvcc/nhDN6?=
 =?us-ascii?Q?1W3tfHCKCTJSGO9eic3sI20SGUSp5f8817woANbw1hE8WlH/v1K4uCGUid1q?=
 =?us-ascii?Q?tlZfX1xsL0xdTvVS+E+Lv4cnbfqFTVxykxCbkQLiqn7Z+4CQiRnYcVYZ9oUt?=
 =?us-ascii?Q?XFocxX874DpHIgTzMGqzEHyvltvFeJm6j7UeEiBEu4AhqgwG4ICdDou+2zOk?=
 =?us-ascii?Q?TNG9syrvTyT7Wew+O3lV/O1eG+TP23dGHu8s2NeTXcQnyTD9b/4+ANIpFLLs?=
 =?us-ascii?Q?b69HIg+BISvKZj5gHvxRZyxd1TpqEyRtwwgWTybtDpxDMTIEZkMpfVLnLWyC?=
 =?us-ascii?Q?peYMQtEXB6hIhbI5z8CA4F37PuBs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dEG2cb6PnFE++say8KWtaFZMY7VYOC3qiniERQPfBbdzbyXnFMHgFThWYCHK?=
 =?us-ascii?Q?fR6yP+PDIfsxqWHP1A8GqpjjzqhpK3yS1azwx7OTRhIbTi3u5Cdx9MpCcT7/?=
 =?us-ascii?Q?eGOgMsLjmsIkNRwEhnYQNBh94h/9O7zLs4JFQ36OkxcXRO9uNnFRDdzlO8SX?=
 =?us-ascii?Q?SYdnX8ZyQ71PWhxtNFBWOm6QvV3UKHRaBYwMS85qcLo9D0Q++C6TtLnfSYaF?=
 =?us-ascii?Q?ldGGdahp9Le1x+5M9viFhcQby5uQFPz5edY3PZR/+RlokhV6L96+KpiJmQZQ?=
 =?us-ascii?Q?37nfJB/cy1GL3jCJvP9Y8Ocwu1OuNo/skulU7i9W+GxfE79xk79eAp3VW1YM?=
 =?us-ascii?Q?gOUVmhQDRIOuF2NVt3YDqad6C1aT5HUmjC97C28WJvONVie+Reobx1tNlQuO?=
 =?us-ascii?Q?GDECm16GB/Ehqg8yQhdbeZpzKthcV0P764Wkcu1lgmHRxOEcbwmnK5PWOli9?=
 =?us-ascii?Q?XyI+foJrX9ZcbNpkQn4lJPEZ6ZquuzkV+fenxfkGY7Njd9GZlu107Zb+NccI?=
 =?us-ascii?Q?UWzsmpH54j1UUi2P0REi/GEJJXlw5rHI/QNY1QnwwNgiTHiKDNKDxnobwXfP?=
 =?us-ascii?Q?F5TvTFmClvbcWsVnoozKwuKckvGMraEV9hU/X2IlHdpFcVDU5lRZ4qGvPjkz?=
 =?us-ascii?Q?layM/dJPDf6RyQz3O+8E9Thz4Lb4bFk8gZNlPTITqHlRB6dtw3OnoLPn9ZBf?=
 =?us-ascii?Q?xJH/g6nvSZhA3C8mvDtr44DEhEJYrPIO7yprRdaQbGLGRo8Vzde2Ufi2H+kU?=
 =?us-ascii?Q?rHz3xZmeX9yEYA8BFTTyroL0v8VVwHouGGnjP7v5PWo62t7XiP/I7kk5QgLk?=
 =?us-ascii?Q?RJqW4T0khCfoe5/BYeY0fsLK6zSR/+6ZfU7jbVvKtruNtYJGvAmKn4b2S2Sv?=
 =?us-ascii?Q?9L4qV7ZWkfk1b9pQ5ydn3eaj2OnLZ9eloSROBH0kM6hGdXChMSjFaOmw/IhE?=
 =?us-ascii?Q?KaQfFwkzrrYa/8+dotdArrhbcexO5aBOF/M9F1uYtwgIUDa6qCPZIOf0D7rN?=
 =?us-ascii?Q?vPkB3uS8r5V3Q2stP1IzQx3Fd16kRIm8qUP+67kIkjiTrY9JOZiM4wlNypcT?=
 =?us-ascii?Q?3MPyv8uyRdSpIZrcZRucc9fr71nq0VZi2fnjtPCNYJnemUpGpC8BAXdqY2hp?=
 =?us-ascii?Q?YD7KGW8NDFp3GpIpD00PAvrBFLyvoJ+wTM+i3bSai7nw82Is2eIE5hCTZV9U?=
 =?us-ascii?Q?Qpk8TUYXEhLIiRYLPfgQg253mOjDumVkww168i3tgOmU10wytmTgpX+Ude+N?=
 =?us-ascii?Q?vq8MmmJg+MoG5/qIdLVu9AIo2N3h7h8iHmedkqfDPLg//RcqGJG5lV6LG18r?=
 =?us-ascii?Q?oJ1N+Qlx1FzGQr/Fg/GRGYkbTAgkvA6pNMwRJcKACjxaTUu0zFQKy+umqEAk?=
 =?us-ascii?Q?oSZpi4HrkFziPxTqfyiefUycSYU6l2CnOM7uONehDJjrAvMBxUukOQIw4z/q?=
 =?us-ascii?Q?SIoqYguGAOHh3HPyFvgiyC2xQ5xvQ/q1kCReGJ7/EUs7PFMS8oBe2cRe4mYJ?=
 =?us-ascii?Q?TM/jUxgeZkzwR9uLh3Wr2vco05J1M5zX2E+/4p5pcdo5gyzv18YQq9ygf4tF?=
 =?us-ascii?Q?LExTxowUb8qTXVUVXEj5F1gcinP41TeAz6R9FvHQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b81cf7a-39e8-44c4-8302-08dd6c38cb92
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 07:35:34.7714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEZDKF35DQzLLq0OmpLyOjO3UB8ry3gnHWHVLPt2dS44UsV45MeL0ESp450TAcCwbFcjDu/JHTxeYLlUkzrj2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6368
X-OriginatorOrg: intel.com

>+static void stage_microcode(void)
>+{
>+	unsigned int pkg_id = UINT_MAX;
>+	enum ucode_state ret;
>+	u64 mmio_pa;
>+	int cpu;
>+
>+	if (!IS_ALIGNED(get_totalsize(&ucode_patch_late->hdr), sizeof(u32)))
>+		return;
>+
>+	lockdep_assert_cpus_held();
>+
>+	/*
>+	 * The MMIO address is unique per package, and all the SMT
>+	 * primary threads are online here. Find each MMIO space by
>+	 * their package ids to avoid duplicate staging.
>+	 */
>+	for_each_cpu(cpu, cpu_online_mask) {

for_each_online_cpu(cpu)?

>+		if (!topology_is_primary_thread(cpu) ||
>+		     topology_logical_package_id(cpu) == pkg_id)
>+			continue;

Documentation/arch/x86/topology.rst states:
  - topology_core_cpumask():

    The cpumask contains all online threads in the package to which a thread
    belongs.

    The number of online threads is also printed in /proc/cpuinfo "siblings."

So, how about:

		if (cpu != cpumask_first(topology_core_cpumask(cpu)))
			continue;

and dropping the pkg_id?

>+		pkg_id = topology_logical_package_id(cpu);
>+
>+		rdmsrl_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &mmio_pa);

Note rdmsrl_on_cpu() may return an error. please consider adding
error-handling. Is it possible that somehow one package doesn't support
this staging feature while others do?

>+
>+		ret = do_stage(mmio_pa);
>+		if (ret != UCODE_OK) {
>+			pr_err("Error: staging failed with %s for CPU%d at package %u.\n",
>+			       ret == UCODE_TIMEOUT ? "timeout" : "error state",
>+			       cpu, pkg_id);

Shall we print a message somewhere showing "Continuing updates without
staging"?

It could be confusing for users to see a success message following an error
message that states "Error: staging failed ..."

>+			return;
>+		}
>+	}
>+
>+	pr_info("Staging of patch revision 0x%x succeeded.\n",
>+		((struct microcode_header_intel *)ucode_patch_late)->rev);
>+}
>+
> static enum ucode_state __apply_microcode(struct ucode_cpu_info *uci,
> 					  struct microcode_intel *mc,
> 					  u32 *cur_rev)
>@@ -648,6 +696,7 @@ static struct microcode_ops microcode_intel_ops = {
> 	.collect_cpu_info	= collect_cpu_info,
> 	.apply_microcode	= apply_microcode_late,
> 	.finalize_late_load	= finalize_late_load,
>+	.stage_microcode	= stage_microcode,
> 	.use_nmi		= IS_ENABLED(CONFIG_X86_64),
> };
> 
>-- 
>2.45.2
>

