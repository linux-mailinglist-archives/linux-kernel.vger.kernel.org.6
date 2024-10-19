Return-Path: <linux-kernel+bounces-372594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B695A9A4ACE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 03:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3669AB208B8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739271991D7;
	Sat, 19 Oct 2024 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIeJoqZL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959231922E3
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 01:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729300277; cv=fail; b=hAQHMJs8X75eIZuRxLIyLY6axYN1gOSfPhOskMqh9um4/T2CTGeJDuAQ7Ldman5tAKvvC+I34FPJBr+K63g9aCVlPIAzIIo9KOJoPPUJTxX++RFNT/MZh9kaJhzWTx+8EAOGWyE70oUa6ZJ2vlZlX9CGtvrJoDaUfhU3olXafPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729300277; c=relaxed/simple;
	bh=s3qmyq2Jg4qWomKDN+7iZJCR1GA5w8JwxmVWYH7VjNU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=gVpOWW03rFnShPXvwf2mVOrj3c6IrB+NwJ2hUAs0fKd+MZX30T+hDF5YoYp2r1/uSTwhH9qrIsT4uC/Lf+QPrMCYa7BJpJ8PL8PMoMro5pjwZNDtQmcqkW3WjgUaTBvZCQDMPqqqeN2zm8jxJcJcM89L+6K1SXZvL4EdSw9JMxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIeJoqZL; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729300276; x=1760836276;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s3qmyq2Jg4qWomKDN+7iZJCR1GA5w8JwxmVWYH7VjNU=;
  b=GIeJoqZL9m+H7g4kYfYO7MU3zXlXET34E8z7GMZHd+w/qE6vtK0gUUDv
   x0RSYXduNw1xANdVS4/pGAIfijxunC6yu8Z3uLiwRYlqzqOH0Rn6B82er
   M3dwJHpUGBfPe9ZsmCkMbRf8kWSZZ84DGf7vSF1Lu+SLMWKay9AUcs1Zx
   Il9IyhBFPHHMXzK6Rg8mBRnyXdf3FpzftD3rhrsgjGIlaVjh1MTcR8Qw3
   CmKwm558MLSPQ0qhTMuVtBfDQR+dVdGgrI6tQ+fBA4xGnbzdXqowxJ2h0
   eSlALNhgnByFCINz7vw960K0ZaSCb6XzLxxlCeFYClMoFp7gu3bWYo0R/
   w==;
X-CSE-ConnectionGUID: 5cSIyuf9SqaRt38imj50kQ==
X-CSE-MsgGUID: f8c2tqs2QDCvlvuU7UgZyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39976056"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39976056"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 18:11:15 -0700
X-CSE-ConnectionGUID: ofQXkDbDSjaNynCfgCECXQ==
X-CSE-MsgGUID: x4xscWlVQcqXnwZQdK4r0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="109845698"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 18:11:16 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 18:11:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 18:11:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 18:11:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5phWiUnPgoqti7Lqlt4uImIgY7S6spuF/KbBsj1KOwM72qLmsdocj/zlwz1yvkNRteVrD6DnzDp7bVLhaEtEbpFyJkA3rGNOy3FxMOUxJ9G1IbxZ1fwTz50T6sCgd34dOuinR3nkxqXGwnD/stSRNico1gNiVYYySEpZhEv+mRKmMs1pZ5VFZ7Yx7IicdHQaQZ5497gX7hpDxTYf0pn49cIWaa1JESOZz8l/eZwCXw1AdvEw3MZmkV+H/yRehWU//mjwaZWeaiQ7TP6kkmU+wbFy73gndsJ8YeiYuqK4u4LlXcY5Hof5PxbZKt6QQ1ycEwCH2Xfx1uqil0Ypu526w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFe3TkkxcJyZUUKJLSD8um6C/fDQPa+gi0MStQG1yho=;
 b=P0Ovat7JPourFyQxbf3tLLDe0/t6bXjr1LsXxiqVvviZMeDXwTUlIgdc5Kohdzi/JlodhYnd7H7TLevk9Cp0yJFTMGLN+Zf3wmZzqYuX3utiNnJvyMm2j9fT5XWQwoBcTp+lLQkS3vyB05px58YEpVaAto3wdyuVlFlg0nNXzszdQNT3LR5d+VQgRQE5FzW1EpOwWeEAGnck3DdyuVFavSgy015Bxf1gHIJgHaMfqptxIkmoh2DFW99DTjMhoQmwLX3zUmb5av76gWHOn49cR+phHcG6bmLDDEp9dbtC+qbCzRM7G8193H8sRUMw7Zgs2uAXWvrKT27KipCtAad4lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by SA2PR11MB4938.namprd11.prod.outlook.com (2603:10b6:806:fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Sat, 19 Oct
 2024 01:11:12 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%3]) with mapi id 15.20.8069.020; Sat, 19 Oct 2024
 01:11:11 +0000
Date: Sat, 19 Oct 2024 09:11:03 +0800
From: kernel test robot <lkp@intel.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Rob
 Herring" <robh@kernel.org>, Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>
Subject: arch/mips/boot/dts/ingenic/ci20.dtb: efuse@d0: Unevaluated
 properties are not allowed ('eth-mac-addr@22' was unexpected)
Message-ID: <ZxMHJ0pMou5xSg3F@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|SA2PR11MB4938:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf7ab8e-5962-4baf-98f9-08dcefdaebc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|220923002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HAg5d74E1NtYAQHrBxZNdmrS+cHFHIEUAVln9CIhheIMpNM8bJsdonsZQ8fl?=
 =?us-ascii?Q?AKX2Hk6CqkDhP7DM0ZJ0jO8aY3KzzdbcjyrXDKJaC2GL1/yMvZxJ/vGoifh/?=
 =?us-ascii?Q?/1IpshM5BTV9SR+xWYV5pqSBPKgIGcbjVTzZSBWzEJ2sc9VcIudemvNMJA6X?=
 =?us-ascii?Q?cvOS1CqBShC1kmuRXmuyjQtct/vAPj3ZjNbUumee8iE6c3kiAhrTuXzdfycm?=
 =?us-ascii?Q?CF3m9jtduEv5j9ziLgAt5PwC+kdwva3mHkMGFwOgFY6yD4ecukdl8YRcGfdX?=
 =?us-ascii?Q?WMFOXhorKRUa9SSWlTkp21tsUD1b5BnoY4MitCaAicKqOtT4vG8MDpAWWqb1?=
 =?us-ascii?Q?f461dBA3VnFZWilGFuVFyFxFqG6ZjK5/XOJIPSk++hZW+Owei1z/VfwzuRGd?=
 =?us-ascii?Q?AhnZ0/SK/qfojf4hG7/Vy2OJDSyrXn4Tr+wfv0dzt1QbE/4Xtw+ns2713Ipc?=
 =?us-ascii?Q?qG7pIyvpZkIkr8IGBAUdZM8vyAZQGibOfbZ+4lBxD2Zdt6DUTpLZvfkAuCeo?=
 =?us-ascii?Q?uNyXP9bUgkM9WJP+LcUUzYPaLL9m8pLbQgRmG/vbM58D3B7SDsDIugcTq/wQ?=
 =?us-ascii?Q?n1GWyL9ezdABC7YLMwnUTPame3uiVrLaEO7jetqXIZMZDhu8TnL740r7Zie0?=
 =?us-ascii?Q?5Lp0bKwhAQiU3yWlwZbx/+wQcNd7dBELbJVD39gk/C2EW5nxORLATXOe7EXt?=
 =?us-ascii?Q?5Qb4Ibo08PLHwgLhQVSNQ9REn7NMSOjcRQhLqua6vTKoV5PkvkAG3+uHshVd?=
 =?us-ascii?Q?ld21kIs2+1AQgulxZEH712IFQns62ZpcuUvIJut0KrQRCN/BryiPYWwf9MIl?=
 =?us-ascii?Q?cYD0GJRiS3+J0zPzqio2QTpwIF8LJlj+Z6YDiU/uGiimn9VfVTvOqbU207ZM?=
 =?us-ascii?Q?Rupg4zg8ZfMCuyRxfQ9plGXzj+Chd1/OW+YBBBqozuMn91UFKY+oNNHpCRKj?=
 =?us-ascii?Q?D45OF1ns7OdVqvL42Qqe8tsN+HJwdSiUvN8L9sfw+R4OJT4lbGhfm3At5YSx?=
 =?us-ascii?Q?+pOxa4MQfuhl2u+DkgsaYBF8+Yee++p2n///28hEfJeodk4wKro64lWhCNgE?=
 =?us-ascii?Q?XOpSX4+pA0dIFYKGeF6dIoQgWSWDV2yGBH9kyYB3sVZMtSJm6GOuiGaOgaAh?=
 =?us-ascii?Q?U3hnK95bmyZMXhcJbFPIaEOio7WgXivd4GgGYtJTK63cMlh35rsqdipAo17L?=
 =?us-ascii?Q?HaOA651K9dxziWMHOcMVJe1z08kPizCC3gJAosmSFljSM7/aSuGKQu+ksKy9?=
 =?us-ascii?Q?krzGjFmJPufQKtuZTwM8p0ZN+u4VPa4gHyYJpG+uyUgEJSv8+uFZM4Qg7/q7?=
 =?us-ascii?Q?Mh4uOy9H2Xh5FNyYPTTGB6Gl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7cuuFnphRAs8yDrQpMArg46BDfnPAuWO5cwb+zvpj4ZngBt2IYn97BUvzV8a?=
 =?us-ascii?Q?sN/7461R4VoN5Pkz898ZBqBmes2o97KCRezZNy4y5pGILrH7fy9j4F6QoJBq?=
 =?us-ascii?Q?2KIcXeBbCbgWnkbzzwK7kuJnEHRwS0kMIQolk/kfBPWePXuO69lTRaDo+PBK?=
 =?us-ascii?Q?MiCQh1NjOIDnv88tlODkNf3WbiDzTdoZX6POILbzcGb2mYBlm0msvJDkMDI6?=
 =?us-ascii?Q?H9GLOMYteY3qr8xG+rBoNzJiVx/7n4lzivpDV+mC6hwK+fe5d6usszfFJUNo?=
 =?us-ascii?Q?yay5rDzLbZtr6nJXi1x7xNtNZ5V2VfkIjWhm6L0YyVJelCTUNluMc9xhrwE+?=
 =?us-ascii?Q?gXd3zggm0lzXHw39NBp9f1wm84Y12SFOpg1UkdAvsmWSCdRQxUiPw8a+VIn8?=
 =?us-ascii?Q?LHpt5+6WvTVbWlPt7DkWuwgyodm2S3R9tvALUh3AGUV9JKM/2AmGxN1mpr4v?=
 =?us-ascii?Q?GRE9WhP0wvfvBuuhEoGpUEwwCxEQc44LKu8xFY+lnEDLQ5DV9jJu45D1L5Uf?=
 =?us-ascii?Q?sGh9m7seZVwSt5MT8LtKmoeJp4llnhhT1n8/YMQKkAew+y5NhUaHDero5HGN?=
 =?us-ascii?Q?i2WvYRwEDPYJXuaJ+JaDgEpV5RzOJQZdhM1cvL5TULGAAXSjYIkBisIA7Sp9?=
 =?us-ascii?Q?nk/GPCz7qRjoltlpOKXquztQyeVv1V7Gfw7lY78dsbYNyo7JnvTVC+xS9J1k?=
 =?us-ascii?Q?evvFJTqJ9qi7yfOHxK8xEEIZwWhUC8Vwcvdyfc1pJewmeacE0Y0an7FDP/qZ?=
 =?us-ascii?Q?KBIQxvF74Z7XZJmPQwHzgDba9bTn5fspSk4t8I7cidfDnzvg2IV/JsQZuFWc?=
 =?us-ascii?Q?OAAdZuhOVEWWiNAD4U1BX837lPpVxg7NXm7DqIwM4sSbQjydgL8cdX8WwyXJ?=
 =?us-ascii?Q?iAHlDTdqPIsDBFFfqZktu8+LB5r3jBlkIjx9dvRuoiw/mcmQs5MARnCy8wos?=
 =?us-ascii?Q?ma1ZE9+dduz3XQWSxsq7wsUmEClxc0C1atJQ+g/quoSTTex+T+wwkBj8sui1?=
 =?us-ascii?Q?tHN4YSTOXhtc2CiKytqyN4GRusZVRPXXfNH2u4TPO/Q2wWSu1LO6qO93V7Yr?=
 =?us-ascii?Q?r4zRaoaBwiqVY5Sox5fbj9XvAedhVcbTnSpErRCTTtdnZGPT9iV2/09OJGQC?=
 =?us-ascii?Q?fzjd7MD3Rd19s5bZ6J+MR4Y30CpWrU4ror2eAKDBpAq5PkEViXuZsW3jpfm1?=
 =?us-ascii?Q?CqXakhrEeFEYMpoKZqu99SZs1dUiFsElJugG1duMrN5VO7MncCNvKwc8624K?=
 =?us-ascii?Q?XvFWm6mVbPd9qGKw3ACJG5m7GysJ5riksXeQk0pi5MnmWkuhnRJVrOZMxIgk?=
 =?us-ascii?Q?ejAt42ZbwEcgJ31pYPh9Et1oucI1VLF99TouGKQii5SYd7LlVYqFglPIVzFB?=
 =?us-ascii?Q?RPICwg6q4E8dZCZCQ+cjf0LCMTLxa4Xiq9IM08O9LMnM+MCxL+toJaFuFQja?=
 =?us-ascii?Q?rvh62XAp8ujyN7I4rhUvfP4iZP+EvBWBJVt9CExAvMbqpEEaBHbZYki1v9Vy?=
 =?us-ascii?Q?ybAP6aehtPK3NdHieY5mTrSXz44Pz3tQn9qv+Zit2386yy6pKUDvh7zkrnHk?=
 =?us-ascii?Q?hqjxM5EUW6Ho0oGBNic0NkdFma8VRhPOrr8EtkErw1IRiHYok3kwXLvDLS4o?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf7ab8e-5962-4baf-98f9-08dcefdaebc1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 01:11:11.8736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTirFIys8W1nUFFy+UxY8A0mQRBdTm6wfFkR0Cc36wrkWCqQU0m+ccCdaqQ/Hj/d4pnl5JWZ9PCZkY7+LH5P1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4938
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b04ae0f45168973edb658ac2385045ac13c5aca7
commit: c5330723d5a0c77299a38a46e5611a584e887b87 dt-bindings: nvmem: move deprecated cells binding to its own file
date:   12 months ago
:::::: branch date: 2 hours ago
:::::: commit date: 12 months ago
config: mips-randconfig-052-20241019 (https://download.01.org/0day-ci/archive/20241019/202410190447.ITm5JtPk-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bfe84f7085d82d06d61c632a7bad1e692fd159e4)
dtschema version: 2024.10.dev6+g12c3cd5
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241019/202410190447.ITm5JtPk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202410190447.ITm5JtPk-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   	from schema $id: http://devicetree.org/schemas/display/ingenic,lcd.yaml#
   arch/mips/boot/dts/ingenic/ci20.dtb: nemc@13410000: $nodename:0: 'nemc@13410000' does not match '^memory-controller@[0-9a-f]+$'
   	from schema $id: http://devicetree.org/schemas/memory-controllers/ingenic,nemc.yaml#
   arch/mips/boot/dts/ingenic/ci20.dtb: nemc@13410000: compatible: 'oneOf' conditional failed, one must be fixed:
   	['ingenic,jz4780-nemc', 'simple-mfd'] is too long
   	'ingenic,jz4725b-nemc' was expected
   	'ingenic,jz4740-nemc' was expected
   	from schema $id: http://devicetree.org/schemas/memory-controllers/ingenic,nemc.yaml#
   arch/mips/boot/dts/ingenic/ci20.dtb: nemc@13410000: 'efuse@d0' does not match any of the regexes: '.*@[0-9]+$', 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/memory-controllers/ingenic,nemc.yaml#
>> arch/mips/boot/dts/ingenic/ci20.dtb: efuse@d0: Unevaluated properties are not allowed ('eth-mac-addr@22' was unexpected)
   	from schema $id: http://devicetree.org/schemas/nvmem/ingenic,jz4780-efuse.yaml#
   arch/mips/boot/dts/ingenic/ci20.dtb: dm9000@6: $nodename:0: 'dm9000@6' does not match '^ethernet(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/net/davicom,dm9000.yaml#
   arch/mips/boot/dts/ingenic/ci20.dtb: dm9000@6: Unevaluated properties are not allowed ('nvmem-cell-names', 'nvmem-cells' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/davicom,dm9000.yaml#
   arch/mips/boot/dts/ingenic/ci20.dtb: dma@13420000: $nodename:0: 'dma@13420000' does not match '^dma-controller(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/dma/ingenic,dma.yaml#
   arch/mips/boot/dts/ingenic/ci20.dtb: /bch@134d0000: failed to match any schema with compatible: ['ingenic,jz4780-bch']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


