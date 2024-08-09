Return-Path: <linux-kernel+bounces-280305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF1494C862
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 04:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871EF287630
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 02:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416D0125BA;
	Fri,  9 Aug 2024 02:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVMIYXpY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF96E10A1F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 02:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723169372; cv=fail; b=hpitXhPo43pd9H2t7KXGXggNytJy+SxYn0e4LIrKKFOkucIHyBGN3OYi3YgPOkCEEfPefXM4T818tk01CMKaI8Xjdh0zi3HHnt1BoCfJ+Mby5flLcbZ3whCIhLbbGfIw31/W4UQnYAD6QUZ3qXJs0Zrm2+ClhAU6Tks13LyAuXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723169372; c=relaxed/simple;
	bh=4Wqr4aFAJ9Lq18/tFz77thGTNu2Le/RlMwo+Kv0yIX0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kqF+IGd0WUCWY7SNR2j3XIzOcDacZ6Akjn6ugvQcDoI44PWDkp4lEw2E8CoW0H44oEjk9Bk+jKHnJ+7bdK6N34j1yIYtaWdtefJo5SohkTQ1jY/4VkcgzJMCz75kQtKTwMByp+HNye6m5sqNHu0/qqI2uibVwTglG2lgJhZZAOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVMIYXpY; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723169370; x=1754705370;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4Wqr4aFAJ9Lq18/tFz77thGTNu2Le/RlMwo+Kv0yIX0=;
  b=WVMIYXpYbLMdFPE2RFC4dbyVhBkV67Ck0+YswCaJAZyYFS8qmcVC934k
   b8+cI8YQfvXr4XqO79EElbw8wehBKWeJbeKDGVdznm69F2nGMiFFfKvFw
   7IzJYuLbEac0Qnap5oCPq1Ndg9k7se7iyk5am+NkjtI0kjjpGoUANe2ZC
   55SOWATTuumHNqqPHEh32H5kKnFKYni7Tj+l+jIryuNUuoRSMtTkLRwFa
   E6upCWs/HBJhavoRqtgv7nx0lGI4/erVsIzNJMs4NFKcXiYCHgiCQj26e
   0s789A/Bz1w8qDfKUbf7tu3HqH8MfIla4QrzCc3M6ezjQi70/AEMGWRG7
   Q==;
X-CSE-ConnectionGUID: RvSdiwRQQpac6xxdfwZ4Ew==
X-CSE-MsgGUID: /Vojno/LTI6fqANkX1nl7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25124037"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="25124037"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 19:09:29 -0700
X-CSE-ConnectionGUID: szi/PrZURJODE7AvF2h9vQ==
X-CSE-MsgGUID: NRRWKqr5SI+HUA7QuUXGtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="62257445"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 19:09:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 19:09:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 19:09:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 19:09:28 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 19:09:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHqHPhOs6/ol1CkPxkdah6vAyH7dMJcfloS+iNgAEq8HXz2XB/j2y36SFCQOZXJDozF+FD4wY1unSEXTdTzPgMjtjQT1uVb8V7PKmkmW/i6qxyeGLK1Q6+2Gb4iW3NbM5VgodGr0zUxszP2QSoDWB9qM002cefshVNltJg8YaVyCYcU6fVQqXWWpDqIc5Cp1GvZZVv5OwqA31wwwiAEMh5+7mTpV6cOLIS8vQuxZOH/TUAb103t5ao8V18BoDXS3DmIkhu3x0NCq+ts82t63um09BRhCUQFjSZ4DOdgON0+fORbcDe4btsgV+5W75n0dWQHjwpSU3A0n/2oRU9oJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSZgG+U1Vy/+o9P7fiuGDSuOmNQqHrmFGeoo3X5O2ag=;
 b=b0AT12jJ0DWmfcvuNuJXWvu+K1SIe+y1a3tq1/KGVy7BfI/zT9oxHixy5PmEoRWRRRvXNCdBhMFtikEZqMxyeGR7VurA0T1oteB3d02XQlPRdukrVlj9xZ9pWhT5TRi74oSkMcAbs5bRGuR7MunqO3hPZGPJfFlnyzrKV82ryaaEmxkMp0O9BJeNvtBnFglqmyCAx4Pom3cVO5SAYDhU2/2dz5xLDeQaPKaLp6eKGSUwcc6DJ+1hXPbvJrO1pTcnjOUafusMlyZflmWeG2JZMYuGEktNwwo9GMj1Nk2y7WpqM35dEWXsbHejbT+yfxRqCRgv/OKS/X1xvldWDL7yLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by SA1PR11MB7109.namprd11.prod.outlook.com (2603:10b6:806:2ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 9 Aug
 2024 02:09:25 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7828.029; Fri, 9 Aug 2024
 02:09:25 +0000
Date: Fri, 9 Aug 2024 10:09:17 +0800
From: Philip Li <philip.li@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
CC: kernel test robot <lkp@intel.com>, Kent Overstreet
	<kent.overstreet@linux.dev>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: ERROR: modpost: "__popcountsi2" [fs/bcachefs/bcachefs.ko]
 undefined!
Message-ID: <ZrV6TcK7jFTXR0cz@rli9-mobl>
References: <202408070432.X6n56VaY-lkp@intel.com>
 <20240807153616.GA2942016@thelio-3990X>
 <ZrQ7Vj4hf8Fbxa6j@rli9-mobl>
 <20240809003901.GA3870107@thelio-3990X>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240809003901.GA3870107@thelio-3990X>
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|SA1PR11MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a28a63c-c114-4677-2692-08dcb8184ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PLsi+dMlpxIbppRrTUzWxWD/uZ0Cgh+lj1cromcjul2vEtCQZPfqSIQM+WSt?=
 =?us-ascii?Q?4Rcxb1o3Lp6QuHOpqtQyr+EhHC5dRSwNC8SLdCQn7+w9Lc8JSfoqqO8Az5wR?=
 =?us-ascii?Q?vAyXeAM8hXo1De1xfNmSlIA3mBycgA61+OhMMuOyUvJfU85YN6vhEEZNVeWO?=
 =?us-ascii?Q?7CupZoKsvFBmJrJPgz7RGojkAyPndIHR7xEmCdy/Wo29oAalW3RhrxYOJBlZ?=
 =?us-ascii?Q?eAHnCHsAsrHwMskrhvvfwMZqEarlivi5aBHP6/Dx3VCogJO27NKgJS09JMsB?=
 =?us-ascii?Q?Rq06pi1c1GtNffRhpZAAysxTfQh+je/W4DJTnLT169WAtvLHqFVWQ/MXDv6E?=
 =?us-ascii?Q?59AK69sJ4ug8xkJ7ZqpdsBpG0qL5ZDmMgvfKweErbb5fxnTLoc8OGiyhRsXq?=
 =?us-ascii?Q?afbWvhIRaKDeujKubOHbNuuT0il9NN5pBZfbAayg1zf+XiREfwVYwJrFDdJP?=
 =?us-ascii?Q?OAA7MHt6VfZ3SsuCpJdi6QxJiyAHTwuBDx1n9N9MR0S0vLKsX7HNxSDHOsEq?=
 =?us-ascii?Q?gesFye2NNVAdeXwwAAsmRjXfOMN77WABNLAWBGgR7M7DwpSA8DCUIOwYWgVv?=
 =?us-ascii?Q?hSRUle93Rci8hq6F6G/dPKS5HrQ/JXvLajPaxFaQQn+AMAtbDGkomhVkDoyr?=
 =?us-ascii?Q?q4aIXKD+ElsFkjoUDK8BOubKvmNQIGoQpNAlzzcf2qjBkhyfB9jtNdfwqBuA?=
 =?us-ascii?Q?Na7R2ELU/YiMQgsFDOzSObkZXVAuzlMq0xeOF4L/tLEdxRWXGBSfsO+Mp9MQ?=
 =?us-ascii?Q?QBWfxGFQo9vgEwzW7uYCk5cNVqKsTGV5cfJ+V/lxIe67urudtyiv63/Yt1Ia?=
 =?us-ascii?Q?DkH0lcKuu7asnRU/hbJg21dKWXYDVt1BrztQz1Fv+nMhDd2CuKlK4cpZSdEb?=
 =?us-ascii?Q?7vymmbjtrkHOjVvkTh6twdA6bQ2kRz8LrYuXgHR0loR+MGXklzi6/EtRlOF7?=
 =?us-ascii?Q?nBtGp4+gxh528LsILltptZNUgoPiqyaceIb6ziUtp/nZ6//Gb/9mtJM+1Hz7?=
 =?us-ascii?Q?L8cSuBUJODmo5PkxuqWNiE0fcioLamXiIzJskDg82kymH9pE4QZlMLDN3Az+?=
 =?us-ascii?Q?T/U5xojsKBi1d3eDytu0o7i4u1pj76huCCTlTO9CABFGdQr4M6pnYw0+OCzS?=
 =?us-ascii?Q?92kCVdruGnjaUgWbjpTV8UmnqDQkdfjYs/snaLsN/Q5B0jD4cv1hNHvd6orq?=
 =?us-ascii?Q?Zx/gVI6vXSQLrEjvj2mo+OKOi+tYBkAp4w4aX4/FCj9uKacXpHvBk1Sp6tuc?=
 =?us-ascii?Q?cKEJMdPDRSJTPpmPjqz57ojrbnxtiqVhSDpbMlUuhMsdWVkzxK9CS7sM4Zoj?=
 =?us-ascii?Q?oOui1AjPpY/WufcSDzao9fuI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Sec7GMeqWo0Lx+Dq7fFFHR34raexItJAV1sRLwMv3lyLiHNKypjhPB0I52L?=
 =?us-ascii?Q?Przzkunf1vxncVHWV3d1aZHR853Gy9pbbSlYd6B3d/Use9FvUpSz4h3fK4/D?=
 =?us-ascii?Q?ROb/V9Q/w1YPB5Cpi6TP+wARoDYMP1f+32zCjQwSVkRXVEpG5BTeDcSyZ6Xo?=
 =?us-ascii?Q?MaqHEtG6AcCimG80GIP/rhywUkN4cCm9rhRBGGHNL5/6WMiinh1fuuP84I/w?=
 =?us-ascii?Q?19Xf9qpIBYLOnv+FLroYLSdMXvhLR1WWejEyEpu6gm9T71wfi8Z0l8doNtfZ?=
 =?us-ascii?Q?HodNTQYvnnz4TEAgQDmlH0HHNr76RUrxpEFZMqAlS3fne7wJDMYBLrFP8zPi?=
 =?us-ascii?Q?1lMb/1vEGRO4yVrKQLxZoLG8iXjkPTUZG96xBM+rWGnIc+HUYho/KvdnhBqH?=
 =?us-ascii?Q?KydLrWG9kjcM1s2Hl9rfdftHFJJrYSJBm9RRsvhg1FdbBc/POAdrU/JnoQ85?=
 =?us-ascii?Q?WAT/LqCmIt8zsPWgeGTYjuLKSVFoowUCh22XspL3xd8msnXz+Ojg3RFvvpP8?=
 =?us-ascii?Q?uI392oDJvxwCGLbu4+31vona/e8SUrk+EsG0sML8lVGdKL8A2ua9lMSMP0Zd?=
 =?us-ascii?Q?VE9jbmFNIr1N96uAFdiRKgZcvjbuF61a2dWYyxTWnTW9zPo70LbGR7kP7YfX?=
 =?us-ascii?Q?tRjiMha7s7rZqkQQfIxjDPMv8Xd2baOouedmZVfO9jfkuCwjEYaYWZ6EeMi9?=
 =?us-ascii?Q?UGu7bvQI3Az+hN7cF07Qd90ycVFj6UU9atr9PHD6QNmxB3LVFYVzM9W4FDD6?=
 =?us-ascii?Q?b0wFPqjfZFuWCrwPeyhLHG72r+WjybxFtl+v36u2kuSgF4pr2+f+ItYxHKzG?=
 =?us-ascii?Q?ohTyfV1BWrDZ3M3Pg5v3+VZ9wSRQIKUhg9JsS5pDZAzxJW1OoC5Lydy7D6cV?=
 =?us-ascii?Q?k/MhPG3P2Qatg7xmCucMIjYBojynI8Nr0JWwi2ZZxfC/7pFSJvTxnmXBAwA+?=
 =?us-ascii?Q?Es3n21c53nzb5rxJau3XL2HoOkla0K8PqU2gTHES59bl36Dpai8ti5UwS/C2?=
 =?us-ascii?Q?/fkA6lzTBtpGo3RH/5zLL0IBtBbdtqGOJlFmfgSoKbYJNB57IolB3TjOYuB+?=
 =?us-ascii?Q?ZR0XeX608f9sDwmT0RcZVLdfK4Em+ArOkNRHRz+OQCyW1GtoD/M9+Bh1zl2e?=
 =?us-ascii?Q?B0goYbm8sPuOVusdTFrm0z2gdJcRku89jORpgN0YnE/Y5jiplcZ06zfsboLY?=
 =?us-ascii?Q?EdZCtLff9GA6PPHuRHMmPfqYO4F9D7cUssI5sMSSwxClCys37QFWaEY0VKkH?=
 =?us-ascii?Q?mXsexaJy9LzW/KSuEf4VzALsUuYIzdlFZW/CzITFGiDzwXp5AyUY2Z0F8UvR?=
 =?us-ascii?Q?wg5nQrLiBJJOsaavbcO0T1RmpCt40wXHrDgC2xj3gJYVV7vJ7j5jKBSPLj9W?=
 =?us-ascii?Q?7zRQYhgNXsnfbUTA1sq7nvJBDLAfORVlvl587/2J1GpiXlOLRn4i36H9yuU3?=
 =?us-ascii?Q?F+RHj0++SqwpNmmn8Y4kpsMGNBNmmb1zL1PZhibEzet3/5HHiCfcjYv3eRLJ?=
 =?us-ascii?Q?MV0CXGdo6KJj51WCcUlufD33PEWDKIQ7O9DlyfVw7/subO9jeIzrP8p0AzG/?=
 =?us-ascii?Q?RcwRZ1xcPaqqaEseoOPDK2bT7CAyPqLtGmCdS2AZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a28a63c-c114-4677-2692-08dcb8184ad8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 02:09:25.6941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBWVXfO5pQpLl+M6FHfQJ0bidqHGBXhKZGOLji5rhKAryQYdIYCZ4QeKNu1sWiZ2lukEVGOa2bxriQEa5fbFiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7109
X-OriginatorOrg: intel.com

On Thu, Aug 08, 2024 at 05:39:01PM -0700, Nathan Chancellor wrote:
> On Thu, Aug 08, 2024 at 11:28:22AM +0800, Philip Li wrote:
> > On Wed, Aug 07, 2024 at 08:36:16AM -0700, Nathan Chancellor wrote:
> > > On Wed, Aug 07, 2024 at 04:43:13AM +0800, kernel test robot wrote:
> > > > Hi Kent,
> > > > 
> > > > First bad commit (maybe != root cause):
> > > > 
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > head:   eb5e56d1491297e0881c95824e2050b7c205f0d4
> > > > commit: 9ae82fe6ace1b267005758ccfb2347a4a6aa4398 bcachefs: Inline make_bfloat() into __build_ro_aux_tree()
> > > > date:   10 months ago
> > > > config: arm-randconfig-002-20240805 (https://download.01.org/0day-ci/archive/20240807/202408070432.X6n56VaY-lkp@intel.com/config)
> > > > compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
> > > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240807/202408070432.X6n56VaY-lkp@intel.com/reproduce)
> > > > 
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202408070432.X6n56VaY-lkp@intel.com/
> > > > 
> > > > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > > ...
> > > > ERROR: modpost: "__popcountsi2" [fs/ext4/ext4.ko] undefined!
> > > > ERROR: modpost: "__popcountsi2" [fs/fat/fat.ko] undefined!
> > > > ERROR: modpost: "__popcountsi2" [fs/hfsplus/hfsplus.ko] undefined!
> > > > ERROR: modpost: "__popcountsi2" [fs/xfs/xfs.ko] undefined!
> > > > ERROR: modpost: "__popcountsi2" [fs/gfs2/gfs2.ko] undefined!
> > > > >> ERROR: modpost: "__popcountsi2" [fs/bcachefs/bcachefs.ko] undefined!
> > > > ERROR: modpost: "__aeabi_uldivmod" [fs/bcachefs/bcachefs.ko] undefined!
> > > > ERROR: modpost: "__popcountsi2" [drivers/block/virtio_blk.ko] undefined!
> > > > ERROR: modpost: "__popcountsi2" [drivers/net/ipa/ipa.ko] undefined!
> > > > ERROR: modpost: "__popcountsi2" [drivers/memory/emif.ko] undefined!
> > > > WARNING: modpost: suppressed 5 unresolved symbol warnings because there were too many)
> > > 
> > > Intel folks, can you upgrade your build of Clang main to
> > > https://github.com/llvm/llvm-project/commit/4527fba9ad6bc682eceda603150bfaec65ec6916?
> > 
> > Got it, we will update clang to this version 4527fba9.
> 
> Thanks a lot! Is there a way to notice when a compiler upgrade causes a
> lot of similar reports to be generated? If so, would it be possible to

Sorry, this is not supported yet as an automatic approach. So far, we add
pattern to the configuration to indicate low confidence issue after getting
feedback or noticing abnormal pattern. Such issues will be only sent to
llvm@lists.linux.dev.

> send the reports that would be generated to only me and
> llvm@lists.linux.dev? We want to get notified when there would be a lot
> of reports generated after a compiler upgrade (because that usually
> points to a compiler regression) but kernel developers shouldn't get
> notified (since there is not anything for them to do).

Got it, we will think of this to reduce the impact.

> 
> > > The current revision is broken and unrelated changes are getting
> > > notified. There might be one more regression that I am looking into, so
> > > consider not going further than that revision.
> > 
> > Ok, we will keep at 4527fba9, and kindly let us know if we can move to
> > latest head.
> 
> You should be able to move to the latest whenever now, the regression I
> noticed was fixed with a revert (it has since been reapplied with a
> fix).

Thanks for the info.

> 
> Cheers,
> Nathan

