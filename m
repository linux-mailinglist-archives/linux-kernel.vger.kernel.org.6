Return-Path: <linux-kernel+bounces-512368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E6BA3383E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849CF16598B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E23207A3E;
	Thu, 13 Feb 2025 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKIHkBzk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3E12063E3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739429586; cv=fail; b=HaDzLI3uic0/xHUigVjJySN0qjmv/7I3dSgzDUVk9pU2vRGlv+6HNbYYzjknFtwjN3NsF+joY0yQM3qz5UC/LiLbGZU+uM3qftGrtpcgpnEyph44FK7I/LynPD3CiXv6itsDIlQc/ZDLEMCNAK+9S8MQ2Q+Bt/i0uW+ogzBjupA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739429586; c=relaxed/simple;
	bh=svZ9qpABAKMwTZmtNMfqvNxbGELnyQtukbDB53QnQmU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cFARUJ6JV/g1YtPQT4ALQ581X1Rtau6Yo+glgbXvKcM2OSPm0uNyGt3GAlecq/VetG9y2m/1Uar7gKIvLWAA/jqy2UJzygd+H0E7bEWCjro+6dCFS1CeXpPeQk9Cqi+tlivaZbxGN/+65c5E5r/xR0qhRU2ZM8HucOHVhecfd1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKIHkBzk; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739429584; x=1770965584;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=svZ9qpABAKMwTZmtNMfqvNxbGELnyQtukbDB53QnQmU=;
  b=eKIHkBzkzRkGx1Y8dIyAg9607pPoDSdJ1sqoNBqqs3UdldcyLdwWalsu
   IweLIDxYsOP6c2w+30Bq7sc5L/seWicof5NscebktExr8xmupB0BuAbA0
   75hhfefmVqMqSWXVQnKUJCZUsxd/oIPy/mGjgse4H+vQp0Ru8Napwf/U+
   LvkjReBdl5ofNIRKxnTnCYmx5GHFNleEiM664S9GW3GuSI1m50dTBGcCn
   nAAEDIIOoGTBOpC+VOKCfqoD7S3Rnr4WiCjhWXpOpEuSINZpTBw7ZmIfS
   +mwV24AX5lQ2dEt9oP9ai38YCO5vCvgfSM8TfySWsGTiCjHsZqB96ZvJi
   Q==;
X-CSE-ConnectionGUID: DNnjYTiQQVCY8pro3lT7Ow==
X-CSE-MsgGUID: +CRSc3GAQd+a2X0T1lI3YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40233308"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40233308"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 22:53:03 -0800
X-CSE-ConnectionGUID: r3hm1vgQSnywtsozJxxIKw==
X-CSE-MsgGUID: sq7GBPqmRlisS4c1kg2PFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143997138"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 22:53:02 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Feb 2025 22:53:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Feb 2025 22:53:01 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 22:53:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEl5VIZXknuLmoPchmvyBdQvODtGkKhhlxFcgU151Etk8Srn5t94b3YoyZdhA85fNJYpjBOWZkSTJcgDuyrVUTIYIiQdPKRmcHD+zDkhOz38TAT2AaqW/iuy1piMTLJAKOryDx+Zp6oPeSHXCCQfbKzdldqTmAZa+JxKBSmkXLhjIhARG+BzL4flDcv4wgm7EOig0DvL8RB6ZBdYspHBdxJIv+6Z80XQtsCwXSgGEsyy6TOvgRX5f1MFHOZ70gfnWAxGIFWccnYE7Y1+P5gKH8wJb7d+Dy58Hez8qVkWQHFb+sf7FCYMeoErAVDY+jRe2VgiWrdX7e5q45TPmwNdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBBaVMgVAp4FU2X7wNi/wu1hjgQX8kbPOdbIRVzefOY=;
 b=Q3T53gLHAIN6t+hn22gyPx5+YnrXOqmgTHmBM4ZCsJmLQAV7NCq4FXLxNfx7tzTyyNtoyIGhi2xTWiLJavK3uRVyHfDT4nwyznuPzE8Op0BEMyhvFROAD2MWkLtiaF1LrWfLQIV6o8XcFuJwbUhBe2qnLErWl6SvtwOcoNOju32YwmEEbOYNtwQSKkfZ5cOmmeLwy6M1bivN4nqM4+hDRtSZFQzSOImtsYC45vJPZk030A4tnMvr+lalZSfMDZr0K45l7ZzaThqVi/4ikXPRtwPOAXrEqgahEHi10M/UYwuBt4xdWx2cCGSLfB3HyxjlxoAS14GZsP2N094V0r74Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 06:52:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 06:52:45 +0000
Date: Thu, 13 Feb 2025 14:52:34 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Gabriele Monaco <gmonaco@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Gabriele Monaco
	<gmonaco@redhat.com>, Ingo Molnar <mingo@kernel.org>, "Paul E. McKenney"
	<paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v6 2/3] sched: Move task_mm_cid_work to mm delayed work
Message-ID: <202502131405.1ba0803f-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250210153253.460471-3-gmonaco@redhat.com>
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d74e90f-9385-4485-1f07-08dd4bfb0532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JIXRV8n5dwmYHVX47OgSYTj/32hGhJi/0XHlOcsca7b6iCbOiTGUAWhJ0de+?=
 =?us-ascii?Q?0f9h4FFYk+hphtZ/TDGwZlBTgmhDO/KBQubV7Z7ClUWWD998m9IUqd9sFo3N?=
 =?us-ascii?Q?8bcEpO83SLXkMyMitTMlH9W7Yih25cIlOdpmpDPubK+vjYfW9SozWJgcF7OZ?=
 =?us-ascii?Q?k83PVh7JsEPV5bd7enALaCFLokgomcMMKRFyG+/50wmGbtCdO3cnI6pePDPQ?=
 =?us-ascii?Q?S34f/RLsttzdBXhZOyaKNOuMKU6nHKLH4pdzM3+5irmXOPzqVR65anPsCWHK?=
 =?us-ascii?Q?2LKTZyO81IyV/oj6vNqOYdgPf/4DKxcydYtOonSKOk89xZVLRFDa87bnvXuY?=
 =?us-ascii?Q?J665N1LYcao37U+z0sH+SIFp9Ue3lx3CblS0muGbuiYCLJe5jepU5jG9G3LG?=
 =?us-ascii?Q?oRgXvxP0cYuwdMlSj2xL7YQO6sccaIG+GKNvCmoZn2VhHDIsOQvzFp6GYaJd?=
 =?us-ascii?Q?Y9YO1GoCaDycx18KNpUw4yGpAXj50bRGTueFHFl0f908QmKwfMX5Ba27VD9G?=
 =?us-ascii?Q?/iT4mgsWfghV9g6g+eo6EZxghP66K5eTFiYaOYHz8VjjAMZBCJYIIPn4LtC5?=
 =?us-ascii?Q?oxqcJKErhLjGWuy3O/uPfay9QtbUF/4CswdLQwzkyrfDH22yD66FV2b0vXW+?=
 =?us-ascii?Q?b8oI4+SCZnM19pFyAYA73b6SkUJ2XAUzj2FI2ABqyIniRaZzH3mk9WCkaDRU?=
 =?us-ascii?Q?MUUNke3soHUNg+BfvbWzsL7O4dR9eO5rypbr+HcTNrmuHmdYwItlnJ5Je5WW?=
 =?us-ascii?Q?/bJ1EDGGj+jeRJymcn5uvIiDoER2lUGioT2MUPGkOSXHSU5Lys1e1Afz3eJu?=
 =?us-ascii?Q?WvEUmsxRMZsgMJUZP8IhT1EiuzlR6u8tQ0MmspHI/hMJCDLH/8XLyFlV31kK?=
 =?us-ascii?Q?AxGV5+wUqtYWd1Hpw1kQUKWDauhy82uUwZc0+nUl9XOIvAdAFhqnXAszZAvf?=
 =?us-ascii?Q?+ACFy5iaW+S7kcc4BOenwx4oNYJlhlrtNDRrnbpwJgFs5b0MG1q7Y0l/Jn7v?=
 =?us-ascii?Q?Zfri1ux7WXpHRVb1N35sp0X6RzLJyRzirA2Jn7YDVu1EH8H9Yfk+bZ26jB5a?=
 =?us-ascii?Q?3WvsdYOwz7eFlCXc/4YFRgK0ccS8B4V9GidDF90rOlnGTISNz9IBVO2QxvZX?=
 =?us-ascii?Q?i6rmuOBUIf7xNHHzifM7tLC30+YdJ2KWe2XhJGt3dxj3g+BtMEuJssy6k2BY?=
 =?us-ascii?Q?IKDTAkvAewNQvm6VEFqgNFf5nLWENGTnawoj/UZqgf7Z6WPWRDs7Uxa0ooJi?=
 =?us-ascii?Q?eY9Ryvkho+xWkSsRcbXGjcbgUO6s6z8varXWwyM7kCjCqpCCofoiYu994b4w?=
 =?us-ascii?Q?wU7bTVvyYAp0fkkbItYlymiB8doFiWPIdKu6SRi9vsGInA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M0mpPccQ8Gtd5RoeFxKpUzgrbJZLY2ZO6RnXoTH2FapkQzr1B9W4Y0+/5cb+?=
 =?us-ascii?Q?QoaE5596r7zbFALG0Hi8uxIE25ChnyUj7dSz3g2iXAfEE/XfU1JbI32YDKo2?=
 =?us-ascii?Q?zgFDLw/JkV/CumabGxBNtEaCuH0PazGr/BuEMfNq/j7VIRZdUy4fZiqwHpmo?=
 =?us-ascii?Q?dLJs2gLyyg4l3/Y3DN+3CoV1ZczeDTzEKUwzeSMkb2k5BAbUIJZDJlEOEc/H?=
 =?us-ascii?Q?+xN5wg5YCtvvWMdeiGOttHztQi8eDlD95IWAbX/wKCXn/JLZFVvHmjXn3d+N?=
 =?us-ascii?Q?51V2wJ2xDwpC99nDk5o8mNvgb3Q4/S5jFti9buclnWULIx0nz2PkLlJn3SB/?=
 =?us-ascii?Q?xXzyFisKc3+XAP+sisOPJaVFVvSyf26wCDsSkmiVJzuj+Oq0puIOMLKZVQsX?=
 =?us-ascii?Q?DyZKbWuiXhgN1Wnf0uhxZOfIJrfpKunjXSQXD8uA0eElKAMvXzKwJ1levh3h?=
 =?us-ascii?Q?XsHWRRCMq/5xw0+Y+kN+oNTM3p2pL4rjqCFklu+txuH9phogjB7vjQCoG+aJ?=
 =?us-ascii?Q?5nEMXH8f1Eub11cFLYyGmqhUBkH2+UJEpwjLjDTgtD6WNk1bCkHxWM8D/6RC?=
 =?us-ascii?Q?bg5vAUmJO2d1/q9s+40WxlCRjboGKliwIa7RBnzVoFVJ17LD273VcJVqFHqD?=
 =?us-ascii?Q?zAGCbvxpnaKDDjjj06en52jikT6yOGwlsLtLp2SZQBDGsCxSr5IpQRVn+r7F?=
 =?us-ascii?Q?zlxg0+VM4wnrGvdBFgpaKY7/+fRcspXQovjTB9ARnJEMzQIwz6Nj5CYWYRMH?=
 =?us-ascii?Q?iBpxGQJCVi14pkW/Q1g4woQWGNBSAh6wxNYRLX9rt71GLz6nW/1QhcPzyUUp?=
 =?us-ascii?Q?eDZbj5bPlPwWcI2G+d74Q2jtWMWvhiv3nkbZPxh+QIoXzvKOKmnWV0SAa6q+?=
 =?us-ascii?Q?T9AKTVjCMpCR0jDp2ToGKttZsaMc2kpdXS0FqiS8BICTG0EtYLgLNKULLNYW?=
 =?us-ascii?Q?+XiK7lp4KEOy6iahnSxH9WJZ8E0UBcH8CayoKboB8Wal4Pn02/WaVCcpv41r?=
 =?us-ascii?Q?Ulho18MSqT3vcuHWv4yJoRG1x6fb57NXn7SN4X53owGu7zFJIUIcVWlCs/Xe?=
 =?us-ascii?Q?IrzqU2IJNr+MP4NqXIE9cU2uaN07/JNdVMIsH/EFcehXcVFPIgDcYZ6nprbm?=
 =?us-ascii?Q?PZBogYzD4YGl1vZ0BxitYhWyyvJoBguve1nCO6gyxl91GWOb1rFoD3RrQgIG?=
 =?us-ascii?Q?5iQP64gEv6kNmDdq5OAtmv5+m8FNOKMnrSf0dpIte6u0b/6y/lLpHqA3HatN?=
 =?us-ascii?Q?Llx+HV6vbGYzHjj3zKfJkXPZJyxbW8+wsCxq/OytNufra4/xq5uLm6fthI+I?=
 =?us-ascii?Q?UaV8Uv9VPLpHMLzR1vIyVE30bBTzCrTH/rNp6wXE0R68qdbeePNpkwQzRiSE?=
 =?us-ascii?Q?lZ/oL3I33KtKLiU8NRhl1ArpOEs9eB9qYz+iNzjyTwKTv249tKah5FW59svT?=
 =?us-ascii?Q?MpX4uMJUF5Mc14Vl4kEwKqwF0b9OIeX4FHOcJZD2KEt/CnO2Ncp5VXSGT4Qc?=
 =?us-ascii?Q?F2QTSoCymKV/ESzCu3/HOR9+j+Y4GshoXcCgqyQR+jLJYwM+7exafS9fVwER?=
 =?us-ascii?Q?BjC/5MyFo2QZednFXnAVYv6pcVUNhdHmN+9IsvrMs79qXjd0lLFTQeW0RCTr?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d74e90f-9385-4485-1f07-08dd4bfb0532
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 06:52:45.3933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMxEp92JtZz9hJIZPGDF/FXqr3hr6r9/7mEqI70qWpuUOtCItcLFGIuhBYX1aISVLMDUJmj48NHEZ8dImYovMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7012
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/workqueue.c:#__queue_delayed_work" on:

commit: 287adf9e9c1fa8a0e2b50ab1a1de3e4572a8ccd2 ("[PATCH v6 2/3] sched: Move task_mm_cid_work to mm delayed work")
url: https://github.com/intel-lab-lkp/linux/commits/Gabriele-Monaco/sched-Compact-RSEQ-concurrency-IDs-with-reduced-threads-and-affinity/20250210-233547
patch link: https://lore.kernel.org/all/20250210153253.460471-3-gmonaco@redhat.com/
patch subject: [PATCH v6 2/3] sched: Move task_mm_cid_work to mm delayed work

in testcase: boot

config: x86_64-randconfig-004-20250211
compiler: clang-19
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502131405.1ba0803f-lkp@intel.com


[    2.640924][    T0] ------------[ cut here ]------------
[ 2.641646][ T0] WARNING: CPU: 0 PID: 0 at kernel/workqueue.c:2495 __queue_delayed_work (kernel/workqueue.c:2495 (discriminator 9)) 
[    2.642874][    T0] Modules linked in:
[    2.643381][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-rc2-00002-g287adf9e9c1f #1
[    2.644582][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 2.645943][ T0] RIP: 0010:__queue_delayed_work (kernel/workqueue.c:2495 (discriminator 9)) 
[ 2.646755][ T0] Code: 44 89 fe 4c 89 33 e8 6d 24 19 00 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 31 c9 31 ff 31 d2 31 f6 c3 e8 7f 87 25 00 90 <0f> 0b 90 e9 58 fd ff ff e8 71 87 25 00 90 0f 0b 90 e9 80 fd ff ff
All code
========
   0:	44 89 fe             	mov    %r15d,%esi
   3:	4c 89 33             	mov    %r14,(%rbx)
   6:	e8 6d 24 19 00       	call   0x192478
   b:	48 83 c4 08          	add    $0x8,%rsp
   f:	5b                   	pop    %rbx
  10:	41 5c                	pop    %r12
  12:	41 5d                	pop    %r13
  14:	41 5e                	pop    %r14
  16:	41 5f                	pop    %r15
  18:	5d                   	pop    %rbp
  19:	31 c0                	xor    %eax,%eax
  1b:	31 c9                	xor    %ecx,%ecx
  1d:	31 ff                	xor    %edi,%edi
  1f:	31 d2                	xor    %edx,%edx
  21:	31 f6                	xor    %esi,%esi
  23:	c3                   	ret
  24:	e8 7f 87 25 00       	call   0x2587a8
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	90                   	nop
  2d:	e9 58 fd ff ff       	jmp    0xfffffffffffffd8a
  32:	e8 71 87 25 00       	call   0x2587a8
  37:	90                   	nop
  38:	0f 0b                	ud2
  3a:	90                   	nop
  3b:	e9 80 fd ff ff       	jmp    0xfffffffffffffdc0

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	90                   	nop
   3:	e9 58 fd ff ff       	jmp    0xfffffffffffffd60
   8:	e8 71 87 25 00       	call   0x25877e
   d:	90                   	nop
   e:	0f 0b                	ud2
  10:	90                   	nop
  11:	e9 80 fd ff ff       	jmp    0xfffffffffffffd96
[    2.649301][    T0] RSP: 0000:ffffffffab007d80 EFLAGS: 00010046
[    2.650081][    T0] RAX: 0000000000000000 RBX: ffff888100090b98 RCX: 0000000000000000
[    2.651084][    T0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    2.652078][    T0] RBP: ffffffffab007db0 R08: 0000000000000000 R09: 0000000000000000
[    2.653077][    T0] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[    2.654101][    T0] R13: 0000000000000040 R14: 0000000000000019 R15: 0000000000000040
[    2.655112][    T0] FS:  0000000000000000(0000) GS:ffff8883af200000(0000) knlGS:0000000000000000
[    2.656263][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.657103][    T0] CR2: ffff88843ffff000 CR3: 00000001d3617000 CR4: 00000000000000b0
[    2.658128][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    2.659147][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    2.660143][    T0] Call Trace:
[    2.660553][    T0]  <TASK>
[ 2.660934][ T0] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 2.661524][ T0] ? __warn (kernel/panic.c:748) 
[ 2.662065][ T0] ? __queue_delayed_work (kernel/workqueue.c:2495 (discriminator 9)) 
[ 2.662796][ T0] ? __queue_delayed_work (kernel/workqueue.c:2495 (discriminator 9)) 
[ 2.663535][ T0] ? report_bug (lib/bug.c:?) 
[ 2.664119][ T0] ? __queue_delayed_work (kernel/workqueue.c:2495 (discriminator 9)) 
[ 2.664836][ T0] ? handle_bug (arch/x86/kernel/traps.c:285) 
[ 2.665404][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator 1)) 
[ 2.665848][ T0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 2.666292][ T0] ? __queue_delayed_work (kernel/workqueue.c:2495 (discriminator 9)) 
[ 2.666762][ T0] queue_delayed_work_on (kernel/workqueue.c:?) 
[ 2.667215][ T0] mm_init (include/linux/workqueue.h:? include/linux/workqueue.h:817 include/linux/mm_types.h:1261 kernel/fork.c:1310) 
[ 2.667575][ T0] mm_alloc (kernel/fork.c:?) 
[ 2.667916][ T0] ? x86_64_start_reservations (usercopy_64.c:?) 
[ 2.668400][ T0] poking_init (arch/x86/mm/init.c:822) 
[ 2.668777][ T0] ? x86_64_start_reservations (usercopy_64.c:?) 
[ 2.669266][ T0] start_kernel (init/main.c:959) 
[ 2.669671][ T0] x86_64_start_reservations (usercopy_64.c:?) 
[ 2.670140][ T0] x86_64_start_kernel (arch/x86/kernel/head64.c:445 (discriminator 2)) 
[ 2.670574][ T0] common_startup_64 (arch/x86/kernel/head_64.S:421) 
[    2.671018][    T0]  </TASK>
[    2.671271][    T0] irq event stamp: 0
[ 2.671595][ T0] hardirqs last enabled at (0): 0x0 
[ 2.672192][ T0] hardirqs last disabled at (0): 0x0 
[ 2.672789][ T0] softirqs last enabled at (0): 0x0 
[ 2.673386][ T0] softirqs last disabled at (0): 0x0 
[    2.674005][    T0] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250213/202502131405.1ba0803f-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


