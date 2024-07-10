Return-Path: <linux-kernel+bounces-247012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9BB92C9F4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD378286D62
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 04:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67C13C092;
	Wed, 10 Jul 2024 04:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJinzbJM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D5E171C9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 04:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720586524; cv=fail; b=aPZENtXRzLe66gi77xYQJg1dHMErj7CVjD642OPss6nHxA1M+ajc6xk1WCwe3krkc1R/623PcwWPfAyaPsA4ECqptmERa4+82zeGyyYGihonM3TrLTLuFhoGercreLGeMXngOqvi8eqW/juXSPIHyeUoSE08C4luu2rwhDfF5JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720586524; c=relaxed/simple;
	bh=wdz7dkc02pOgH/qmKhkYZ0GVV2J7hlX4T7Fx4GxO1XQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QBQ0E/RjeM+/Lm5G4q57pz++UGOGcF/OutnNF2U2KSc9ZFPH7eJfJWQ2/dWFq5E1jSZgSHP4pKnhsYkztM27vGHwp9CoKdeB+3nOTb0fj+2Z7+evXnl5OerJwWwC+3yADW2KUm9flr1kLR6pNroUnyB9bm7pZBQEDOt4OKDd5yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJinzbJM; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720586523; x=1752122523;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wdz7dkc02pOgH/qmKhkYZ0GVV2J7hlX4T7Fx4GxO1XQ=;
  b=PJinzbJMw4duU5CsQ8DN+DFfcwZ80fVsT/UFNL3z1p1zIt9DsQ5TemOs
   PZ/vkErXCeu+6GbUQJohHlZddyiagIgY3ajxVtoqvf5qNqUoyeLmOseoz
   1fgLdsMD/DPzh8+k991C5bMYKxBgk480mmCLPRiKdcR6cuW5xWpP+45yp
   A2kBBm1o5qv5H5Y2COs3IB0/vkEycN4sHbg7NzSophYvtV0vq9rpX+ySG
   vZaS5wqNXX1bKtq3ZBs1IrW4Pm/KbFpHvUD/1yxH4+ggBIOVunzmyT+yS
   FK+kWRaY+5f3iD1EmMDzb+3fDQUJpUABjvAKgmGTRLLp1J2G8X67SuAKx
   w==;
X-CSE-ConnectionGUID: vnHkkxM7TpCUCB+xEHgvGw==
X-CSE-MsgGUID: b2lC1fX2SvmLAhG1zdbxLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17748352"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="17748352"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 21:42:03 -0700
X-CSE-ConnectionGUID: 1ZxFtloGQMqYB0xspMW9Rw==
X-CSE-MsgGUID: JvmAzPW6QTq3UA6saDleuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="85600163"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 21:42:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 21:42:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 21:42:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 21:42:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 21:42:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKLZPYNV52ue2kdDspoOS1GhsGmgoyV2XxYuRZsObndoygcMH8yxqeO9JffsCqgohsXxAdI8zTsxpAz8RBsll8WOtWy3eSz68w3dxUuY6/c5ThVXlkqmAxyojHiFraOyu1YakfMduOqwn8GOqFF2iyy0FSYWo5H1TfEKorNlgfgZppf4h5Qk1Fw/r3R5OuDX25x31I0TxlSnoxDALVO3aM7V24dSghGUy3PkmXNYUtAO9Dh59v/Jt2FML825an2Jxzj+sEM6doJESACoaMLYaSAEndzcID9dTdCYxBejEaH4/g9XfNqc4ZmNuhQ40XSBEQu/b20qQ0PltfD45d1JpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPN8h1W+I2M9IwaEw3trtB/0lZBz0gqutlfQ76xHJ0w=;
 b=OePSeJdgGyl/0cAQMXPLIedvr01gJgEJiB30WdRrY3kUVhG7/wzxH0n8ph8j2Dyt4ijKt+FWd8fJrD7ttsg/RD6b3RXkalOi9pq5JcPyPIGZCCSrmh8S/jgOGZvwOBs7PgVUIrSB0eoC8WlQ3OFpbP+8raFWAXYJtLxicFjKUno2gLsMemEuJMDp8sHUMebYvEF47xVeOTcqOvbIxDWqvE8soDb79Od+z8FgFei+pcD2dUgdt7mrLGLufSkjI3tkAQTIdRPrI7Xmz15RlyFc7LWjk+g6SyHxKXU+PjWoPhm3foPsYZfcy5LyMH6e76m+n0Z3Mmtn6qB+AZyNwJt+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 DM6PR11MB4754.namprd11.prod.outlook.com (2603:10b6:5:2ad::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.20; Wed, 10 Jul 2024 04:41:59 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 04:41:59 +0000
Date: Wed, 10 Jul 2024 12:41:51 +0800
From: Philip Li <philip.li@intel.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC: kernel test robot <lkp@intel.com>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [gustavoars:testing/WFAMNAE-next20240621-CbC] BUILD SUCCESS
 5625a19d70e0d4b59a776586e73f0dfd0c944e88
Message-ID: <Zo4RD0G7grElWKg3@rli9-mobl>
References: <202407100452.c6mf75Rk-lkp@intel.com>
 <9fb08146-766d-4d0f-b664-2548d70d21c0@embeddedor.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9fb08146-766d-4d0f-b664-2548d70d21c0@embeddedor.com>
X-ClientProxiedBy: SG2PR04CA0162.apcprd04.prod.outlook.com (2603:1096:4::24)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|DM6PR11MB4754:EE_
X-MS-Office365-Filtering-Correlation-Id: 67391e13-d7e0-4357-83ff-08dca09aa2c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1DJF8QPD3rZrpJAgkh5waFOLns6XIXpQE14t3yu/5dfzy38pK0CGlmldy+92?=
 =?us-ascii?Q?T0BACCrA/Jc88DKXHPu6pebhh1cA2nNviy3EaJbsJAKX38ptKqENNpa57Smx?=
 =?us-ascii?Q?Q+Ha3B7pU5zU6MfqINVU08DnYZnA0LET3f1cMgCPIKiAqGorcs58oY8n2iD8?=
 =?us-ascii?Q?tX0Wnv6sSeYw572vcMa22CgSjm65iIToIWDneil/2gRZQxG6rhLT5Lv1ZffN?=
 =?us-ascii?Q?NKQLCnNMx675aBt4pf/Qv/+csjFZtHrOPhWzwKc+imF1FMHkFBFgkhj9UBW7?=
 =?us-ascii?Q?wxoLqPtK33/naDc+UgqcVgP5cFfVTgEw8pxkcI6ZE0nBVBn971+X1RFWi/py?=
 =?us-ascii?Q?M/WBKRZbYPsyJNRS9C8fD2Vmklc346kN0TY7v72dxsKLdGsPcNRb9Z635hBU?=
 =?us-ascii?Q?fQYtuRWTbEIc+b+fiEivI858pgzlBRBxcDwsc88IBEiY8sSOq+7/+SWNM+DX?=
 =?us-ascii?Q?wQr26D3PzVXZJVCcowGxrdG20hlDHw0QopaMAZ2m15DzhvK2bSCHzIEu8yRN?=
 =?us-ascii?Q?V6M6CkBq4cKGjmhEgulw4eeJAORJgdJHCJO0+oIQv+yBA92853/Vk1RQlXXD?=
 =?us-ascii?Q?J1tHNv0v/7jqTC+SU/juxred+FIXDsxEf2Fq7Zl1hM78Qlsk8+rg/z582py8?=
 =?us-ascii?Q?gOkXq6uZUfDJeVTY4BofVvrTj3+g0Cup/2qCfqy05asSU/CCQIQcx0JhEk/P?=
 =?us-ascii?Q?5MQFOhoGZqzUAULSyeLmp2yKtpVBVBLyogrACEdwelOWDIORIl4/byeqZcaK?=
 =?us-ascii?Q?hMmFBfBqOTERmQEv0U94QcTynPgXoBwHpU19/y+kHhBaze4dZL+pRYjON8aw?=
 =?us-ascii?Q?QlnFXnjkZKOvHIf0rallJxpMFpiujoYxYVL8oesn4vEar09jYdC/GInjig9J?=
 =?us-ascii?Q?+OqSz09bQaIaxsKcfHsRa3Rqln+lr4t+wegV6JJDiP29la75qwiEBTl/IWkb?=
 =?us-ascii?Q?JNttzdn4SQw+Wa6413SkXurdZSadpRBEG1fvlD90v4NDSI7fUvtcRsCx9z5C?=
 =?us-ascii?Q?JqtWsu4q7kdiDrdv1SeSAsDTJndpq3ijTK1Rjzrp/cfkuFwTZES4zq8cPTX3?=
 =?us-ascii?Q?mvxJXzLFTB9FY9OV+9F9XZ5xTk38a87FYSziOCjgLEFXuaOttFQg1uWlajrq?=
 =?us-ascii?Q?BpR3igetXvs8QMzm44ZbCtRnET/z1/+hRQb2fwwG+KELCHyj3b0eNLfuvjTW?=
 =?us-ascii?Q?XWxdwNYZPRRmSaOEDDVL6wjh3z990TZl0HVPXffAl6ok/cDsn2VaXZ7Iqnyw?=
 =?us-ascii?Q?5xMcmtUoS8a4fcPaiXHVB6SgGXAgPDIFybX9BScutD04w9oJCIAqCDEnLkyL?=
 =?us-ascii?Q?tjA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BvW//9TfMqq/UOFk907esnlgRISGN1WRSfOOKpDD5QphCX6dy1gkrQf5I3yR?=
 =?us-ascii?Q?T8hBpRlZWS2HG2atwVhRAuTngerfzTpVj0PkqbzLg5jOh549G51iR/dD9WJK?=
 =?us-ascii?Q?sbc1fQ8Dv3wJEi0IUEZYggWFtMgrkpyyIb+TMk+nX5EdPMHiYx8wKMGPQW1s?=
 =?us-ascii?Q?iU/7qXKIe8fz1/BOljmxHAOWQm1F9r+/xSUtZEScCIUx/5dJC5aJcJ5jzaYC?=
 =?us-ascii?Q?9YPnytzKPLIOBYh31QVcNr0Dt/CBpClr4xnW7qYRa0JkMINcpCsqRMTwdbxs?=
 =?us-ascii?Q?XNdaR6qkkXK66Tr2JFoZ+KR4g5CciGFhvFnPFy4Qieet+OgpqGggAqT5whlL?=
 =?us-ascii?Q?TP9NIAv9864dU63G/iKfoXzgrq3E1ZAzI2BOYUSq+hJTNQ1jt1XodHlfzACU?=
 =?us-ascii?Q?+JwxUoqZ41Y8tvRNLwsR4rr7ACYjimAS/Qa65YRUo6CguL0QDKvEcVphhWlM?=
 =?us-ascii?Q?JnKvTwmwpgUrzXAFjDN5c3Uxcu2+09sPapS0IR6GpMz4gLXYF3YK8g55GAgH?=
 =?us-ascii?Q?Ra65PkMHtyS2ZehyVzMT7stgjd7hlmo3S3oZJg7iRsIQY/1BZccSsZSNutyP?=
 =?us-ascii?Q?vwoIOtyA+8yaFrfvqlFV2PFyCLGVmu+rnEHC73riXd/pKJpH4fe4pnxxFDK7?=
 =?us-ascii?Q?2E+E9/PAfWW8xV9hJpyTB1PC95kNi+zw9/C+eL93oqHfvmRQQAO7bSz8pEsJ?=
 =?us-ascii?Q?p1WIOUewqn0xxl0aHSGnMkF7cE3rHAPkayvdJhCmesqbF80uTAylPaig/JPY?=
 =?us-ascii?Q?Z+Qsn91Kd27dFM5S5RAEV+E1m5mJBbJlKbVDuS3PfZladcr6ciG/30ZrtCW5?=
 =?us-ascii?Q?VOxGe6hREPpsy6uaVlJ1KaJEDajY25Bq1URv9KPUb+Ip3v6I2OZhtFrDHm3k?=
 =?us-ascii?Q?2Jp/rey7Ctmdkw7i27Cq0hXlNFJaa0x6OTSvKuUdAaqImud7ynO0AebIaENy?=
 =?us-ascii?Q?ETbgTMDi5tgYMqkik+D7Y4F70sMx6CAfu+RqzQV38QSKbgmEHH7N0aM+0BDd?=
 =?us-ascii?Q?q/gwDmGqf55sO16ctsR044cO4jliW75/mqCV2LcPeCx65u8Aqx9o80RftbcY?=
 =?us-ascii?Q?tiZdW0Vuhwl1laS7sdUoL96EGKtcsbW99vVjX+raH+QrjN6rNtlIkNUUrKU3?=
 =?us-ascii?Q?ZGLm757GGdXL+ZWM9ljXBQvT1yx0aa27IOzyXNdyG6JI9sJzJlTJD9R3grKv?=
 =?us-ascii?Q?dKZztLOnSH8O5xY5wUsfosZaytB+aFLQsz9WylYh41GTeiDhEZlyq45JGvnT?=
 =?us-ascii?Q?i5H/GI/+mPVIvcc9SyhYfU7r/53KSEC1ZCaJLzEkfn/nW3YmNfKRNjttMo5a?=
 =?us-ascii?Q?fwYnuwQ941B1utPlhWO0ijQ9Ps01wI52TvtZNEOFfMNTNNBCW6bVVNWVGdPr?=
 =?us-ascii?Q?A+/8wQoZflG0GoX3G1bWU3O40ZyPTSEvWc6Ee2BJXpzYlDL7sjbFwW8s+GHI?=
 =?us-ascii?Q?3/5th01hfb0FnBH35RJKecPJtXkMwBl1XHl/tdxskX3XoL8aVo7RWifK/ePZ?=
 =?us-ascii?Q?GDQ/4jqhXmnHtLjoMhkuR2cg73g7H5kKDDxxVcdrr/R/d3mljwcKxc8WB6uz?=
 =?us-ascii?Q?A2i808CEmyZDbrSK9TcR8hcmiGXmOtd2JZ0GLwsX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67391e13-d7e0-4357-83ff-08dca09aa2c8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 04:41:59.8994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdQyX94Ev7SgtD6hS5adm82a9A81VWxeYrNJ3MYPoe1GFfMhEi6+9ILt4tCwE+cLn75VodrQXGW7ZJYv7piURQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4754
X-OriginatorOrg: intel.com

On Tue, Jul 09, 2024 at 03:04:57PM -0600, Gustavo A. R. Silva wrote:
> On 09/07/24 14:55, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240621-CbC
> > branch HEAD: 5625a19d70e0d4b59a776586e73f0dfd0c944e88  perf: Avoid -Wflex-array-member-not-at-end warnings
> > 
> > elapsed time: 1308m
> > 
> > configs tested: 156
> > configs skipped: 2
> > 
> > The following configs have been built successfully.
> > More configs may be tested in the coming days.
> > 
> > tested configs:
> > alpha                             allnoconfig   gcc-13.2.0
> > alpha                            allyesconfig   gcc-13.2.0
> > alpha                               defconfig   gcc-13.2.0
> 
> [..]
> 
> Hi there!
> 
> It'd be great if you can run your builds with the new GCC-14.

thanks for the suggestion, we will upgrade the compiler to include gcc-14.

> 
> It comes with new compiler options like -Wflex-array-member-not-at-end, which
> is one I'm currently trying to enable in the kernel.
> 
> Thanks in advance!
> --
> Gustavo

