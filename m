Return-Path: <linux-kernel+bounces-555335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A3CA5B5D3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7213518953C2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 01:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8498B1DFE00;
	Tue, 11 Mar 2025 01:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPf9GRH0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5101DF725
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 01:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741656099; cv=fail; b=Apr1uegKR1Ut5SPxNavjrBgGdnoUsW1J1K8krCliL8I4/rvvujS7/uFjkJlNvjDBO8LeW8OdGKdXoCJcmidX+kzYYPp7bCGVkuE3lCT8gphIpG4jCl3Mlc+iVeVL7kHcfuGTE/b2smv6oA3+VBAJZupHpcu2dxJzL/VHijT7bVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741656099; c=relaxed/simple;
	bh=LpWkW1+CXiyMxx1OJo9mINONFHOOSuo7uuMxpvPv6lE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MbSw7CNsYrlty/6qksqaep/lzLHZ+hE3z8wGjNeUQ8M0N6wJyahKhST6N4B6oZ1pr0o0qpUTip+j97MAj3Gf0CXyrIvhm5A+p5KZmjZvb1pofRmZBzVOPWHA7CNcol74M6WfVbrMk04+kKz/YZSgBz8nYdZPzt1FORrRsZ3AMOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPf9GRH0; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741656095; x=1773192095;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LpWkW1+CXiyMxx1OJo9mINONFHOOSuo7uuMxpvPv6lE=;
  b=aPf9GRH05aqv5avrR8DrPZ5wa3LcF5t7ciY/IIpA/lFBEAF2kCVt2RwJ
   Hst2fpwB7v1pW7RL5cvfuvMH0P6S37UIxIBXzRe//bNEdwUgUuDBTrz35
   Skqmh7pIJdkaCSXY98j+3ISbjcd+Hlk31zF18mn9qZpaHvwWs78s5jfHn
   it1gdkodDnjreMYyPTZWj3whWl8FJZMWg9BYqSN8BYDHN5wccBOT4cUR7
   RRtE3VVJgUz1Nb71iRaArZ+pzAQiHTJY7nt5th+Ut84oErXLVLCfBiXg6
   Ae3gTI0nypiU24xRe1CHLx7Vnu9Y0JopByxd+S+LKQkiERrutSRqeIt4y
   Q==;
X-CSE-ConnectionGUID: 0JCuD5ZSQBeOlruJGfArAQ==
X-CSE-MsgGUID: lMJOUqeDTWiOUQtTGcxiVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42891439"
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="42891439"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 18:21:35 -0700
X-CSE-ConnectionGUID: gNJzv8NzQvOa3c/fY2Y24Q==
X-CSE-MsgGUID: vMJ1g+/1RyuXM1kctsDUaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="120000669"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 18:21:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 18:21:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 18:21:33 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 18:21:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gocQsfTH315Q/bj4dXrWc/hCj2v38hlB6A0swPLfdXpOOy13R2tQXbmKiBEzWX+r1grERFE1+/ndUKrhTp2tnnx40o6OXw8SCCMzfLGqQQ3DT7Y5Ozs+ui/j8wNr6qELD0csB4HfqU8psAGPRolsYrCkUqT2pFSSjRjo+WgN/8JNfLQ9k5kff/NM7hygn9gaAUom/vnj253hLY0iJZLzS+cMpqwD2d3QoOgJw9lQSATsDWSmvuJm5RM5AYgxgVmFLMl7spB0RdZNXTSVOtiAAqpfL3A17hbo+HJyxRtdejBN56hPVezwbrSn9+q+FMnRtzDAkxLoXXcNvmFTBVohkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcoeK4ZggIvPHUmv/18yiz+lY3X3utOep6e1e+qVTjw=;
 b=jsufx40uI8aeKWXmSrtbx70vS+bvILVC0MixTt3rvWCQ6ame0Z0ERv23fanZPxFPOasB6cPbduWvrPNHyuaVX87Q9V4eefS6fPoTdSQ7w2uBvcRw2nl3bU6XWH962dDmBys0Tyw+jea0x9tkQuZiZ5XuSUX4IJvFQYO5ryA9KAPvedqGKOx96/YDDd7ns2oKhl5cF3dpVTdSG0XpK52qkogLe1iCAQwQqSQM1qd7a2N0f7shjK+dHwrmHKW32PxAqTghewWCAbppR1FKEGPO3ZXsZY1b8/e33CSYSoRYA2zGPFl6XOHvHGkw9nk935+oorkn0KV81hxFUhQFx/xWEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB8012.namprd11.prod.outlook.com (2603:10b6:510:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Tue, 11 Mar
 2025 01:21:29 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 01:21:29 +0000
Date: Tue, 11 Mar 2025 09:21:20 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: James Morse <james.morse@arm.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck
	<tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [morse:mpam/move_to_fs/v7_bare] [x86/resctrl] 0021800a46:
 will-it-scale.per_process_ops 18.4% improvement
Message-ID: <Z8+QEEKmnlLK4E/+@xsang-OptiPlex-9020>
References: <202503102156.d70c4800-lkp@intel.com>
 <6cd8d37e-19bd-4fb8-8b91-e5b2c5f6f7e7@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6cd8d37e-19bd-4fb8-8b91-e5b2c5f6f7e7@intel.com>
X-ClientProxiedBy: KL1P15301CA0061.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b6c8cc-ebfe-485e-371f-08dd603b0caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xZ7yBoPpNfBWdrIhnYdoXTE8hmxq0j8FwGNNUyCM8BKIc0zFweiM1aLpItzW?=
 =?us-ascii?Q?1rswo20ORZdjYjDlt5Z4my11pLZADSb8AsEgbAtwKF3Mf62V/U937qmrx40G?=
 =?us-ascii?Q?vHNkqePU1ztp6/JRWYdQQjLcoBhO75l7/nMAEpge3OL8S7kErPw13KTgBCjW?=
 =?us-ascii?Q?+JRs8LS3VXTFd/qFbkjsbyyiG7bwvf1lymmQzJHZXzEgoRYY+/8tjPduBd7F?=
 =?us-ascii?Q?60H46Zo+/qaRJfyTjzWmzMc08NNHa3cxJ9FS3DYLMNHLdd/OWvORKEnCqKFe?=
 =?us-ascii?Q?1+m6AoY9IvdhO2vJlvoHnN9AAlVdUfRyvhP+jR8lTVEGV2ybSoUUa8MP+/BY?=
 =?us-ascii?Q?TajXuVfOS/lU8mB9pel7sVWQn8FD6xGh7yavEXP+ZaDtn6rGKosHu1GANKC8?=
 =?us-ascii?Q?oFz2j9nrFIEAQf7vNfVkpOOpUG9LEdKG2Vvjl6HRCdmBk6zNPNvKQ0KK1iKK?=
 =?us-ascii?Q?OxAHn4nlVqGb9WB+OU3Gp/mkJQX9zFGdPz4Q1HnoU9HRxrSJecMXaq7skOCz?=
 =?us-ascii?Q?OhCn0zzQXcoKcLVBUIp4/m5WEzE9k7odu1d5PbOAcqRN6SRf+a+Qh24UaYYH?=
 =?us-ascii?Q?dU8WJKvv4NWBtefRlJrX18E0hFunSKXguX5AHKI+xENhXzCEdM9pDDf+G258?=
 =?us-ascii?Q?djmQR8CKszK2TcGz7eBfvTam071iwd1CJh+UZ7+Gqato0Zs3BiniakzKWf5Y?=
 =?us-ascii?Q?heSrmIrB5AtXxmh+YlmzdJyYrOJ97Px9c/JoQKoF8iMX26adPAK99FeW5wYf?=
 =?us-ascii?Q?z6kzzoF+112DjsHAu+fx8zHBKuamCmNRZtcTR8JOyB9wCdD2KtwtOQ6TFEx4?=
 =?us-ascii?Q?+KDhWxS226mhGLV7xYZUcAQFMdIxUA9I3AMA8pwLVmWGaVTcNpqFkRiYjpm3?=
 =?us-ascii?Q?1lQnKr7ZUwltQlroxNxWLqW44TnOzFafsg6KySVPk+r+yW4hC7Rpks9u2dLm?=
 =?us-ascii?Q?PAoaWDL20RMEUFHLXw0iS/PKkNjyFqVgMB68z0YF6foUVuhWcT5tQxcKUmld?=
 =?us-ascii?Q?QLtWkO90WS9l/uDpisS52d9ToSkFJ1KItN9tpHh5P9bpiC+Y8stqZ/Ci96M+?=
 =?us-ascii?Q?16EZAykux/3SNsrqtrtAjey51AAuIaZgb0B+lU5JS+PUBA77D0NeUCHmcwn+?=
 =?us-ascii?Q?D5UaAR/srCfxXP2pBOONSsotJDHA7D0fIrNL8Q96Y2hOU++7F1M2wJXS4a+0?=
 =?us-ascii?Q?VTjg6n/4wEduLnNr7sBUOh8HOzBvW8R5xx5UzJQu86a390ruYWQZ3DRFyeVc?=
 =?us-ascii?Q?rncv8XSEXus9FVKtzd7fuJTq8Z0iCHPs7B5b1ZJGOGMEaN7IbV70DE0WBUJN?=
 =?us-ascii?Q?svmWBUE6qTd+Bu65l78aayjv8jWrgkELT2eJxLGjWbjsuA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FplTWSPpwOKftv95G1LM7BdJmOz3NmTQBas41YZxeSBlaRdW8MzAHF3hrhkp?=
 =?us-ascii?Q?VzPAPuYCbJHaw6T7/dtC+JQpJ/lB2Z1Z6VPxFqXKRpM5SCBdoYoe5dFk1AjI?=
 =?us-ascii?Q?8sfslBF9li/VgFLPCNjwXxUlL2HRzgKr215pO+xKCvwqbe01Up489NQJLxlq?=
 =?us-ascii?Q?qVB/gNio/4464gxyFMlqyJh8y40poOmQH+OrFBrplBW1e7BX/FLoTp21q3VI?=
 =?us-ascii?Q?6fUUS5dB4tk3/01tz7Y9lisxMxrgskefpMVhAp7V9C9Il5xbAki5mqzUdf6h?=
 =?us-ascii?Q?TJqVapa1YVpBmQEIRk5XadxL4cIS7hMZOyGUHmi2gz449towyZNFcVkUYy9d?=
 =?us-ascii?Q?HCNWdTBHCJmfUBssvTrcgXWsnkvxRrUZKuQSPhxYs8/ov13+dj4vxiGxCW23?=
 =?us-ascii?Q?AycQZDOF9cPn7M0xaYTRdmG1nzpUWNjVJGYSS0In3pALPnE7YB+ayjoEBex6?=
 =?us-ascii?Q?yu+Ro51DuHA0kWIf/N8g62fqdwJbyMttStvd4es4+lqElSpxzrD07LayJp6/?=
 =?us-ascii?Q?bfdQUWIk/wifmP+mqeOBqmhfkuxovqV0vRE4WBSdVHW2YYTmFDTol7pTyBWA?=
 =?us-ascii?Q?ZGhUz//qkY3V/zSAeTqB9A3EF9yehtzV5MD0RY33TEzKFjB0LVAhKq1d/Hgm?=
 =?us-ascii?Q?ZsL8QMkWb+vpPf1x5ib5Ypix31V45xzwc4WM+JmVoUjR0qVpp4cPWHs4EavZ?=
 =?us-ascii?Q?fcJ3XLUqFQQw4bYpdWEFBTrPftjXCcdc+SqBNg3FUoU1jpvVh6yg2aanFiZ0?=
 =?us-ascii?Q?VXm9hBhptA5gfbhAKdOngFtkTxKo1WFyQytXOdeR8oo47ecgAEtOu220jVTu?=
 =?us-ascii?Q?sRvYwthJHcApzEt4xLNtZSWbI+4+tkW/BKHIDUGIEEGgwcsxCTQXKI6fOP1I?=
 =?us-ascii?Q?wvaqjuI1Z5fb29F6OnUyTUSyAfx3/nZMQUUQwPxYpTjPRiz6yiZlnZHrU8w+?=
 =?us-ascii?Q?tO4vETr3y3cSiRL6cvGwfzJN3jM5Li2Sbe6WHMKLqiPSImfQSbk5m9MsiQmu?=
 =?us-ascii?Q?CciLV2KjDkTahq+VHrIIzDvxL/aKYNrljxgJVlf7w8TMbAm6kkZZjpLjd94f?=
 =?us-ascii?Q?j9xpr1K07+SJdNrJiF0+IV5wfyiMTxBqI+rfFWnyIrV0PpKmbgOKT0g0IehZ?=
 =?us-ascii?Q?a4rpAvS42eKTkgHSvatsLR4UPYkrDYVWYXKnHlotwqS1zALFsL1vYMPlkUum?=
 =?us-ascii?Q?uXuVjEc32qJUO27PanPEo0z6uubd8GdsqdlO4TzZVpWgMia75Ni8PMcwK6lE?=
 =?us-ascii?Q?rBDUr3RHRhzgL6DGY+GaLPw9n+JaqqA5JrMQGLSQnAqSdjDwYQqoctcKOrNd?=
 =?us-ascii?Q?vqK3snFmbGOh/2TPWcf33MNUQ5//cTETWzeN7eq/AHKfUy0dBnv1fmbV70XS?=
 =?us-ascii?Q?Zi7gjMCtajnYB5rjRXSRauik30hf+VIDZYX9ZQBJkuDtocw/GkadXUEmLH1L?=
 =?us-ascii?Q?v7S7YvOqwyovqpgbyqEmuTIvGTXNoK0cIYios/2I+rCc7VZHxa8x7Mhonvyy?=
 =?us-ascii?Q?wshP68OhEKgAFpWNhX/SsrN6FkTSlJPcS4chzjBKBQ7rZGfiDUaaTPx8EzWp?=
 =?us-ascii?Q?tbCaEv5cKiw/lkydbLnaPYEGx+X1SRb9+4mo1ZBHODRgvXwKV1vWtMyzBKfD?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b6c8cc-ebfe-485e-371f-08dd603b0caa
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 01:21:28.9637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gSa66ORKXdRyNW22S2/6O/dQkq2CThLoEBBTstJQy+9785AV1Lm88raEEga1L6ofSCqvDA0waiqqTE8iqdtAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8012
X-OriginatorOrg: intel.com

hi, Reinette,

On Mon, Mar 10, 2025 at 02:17:51PM -0700, Reinette Chatre wrote:
> Hi,
> 
> On 3/10/25 7:06 AM, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a 18.4% improvement of will-it-scale.per_process_ops on:
> > 
> > 
> > commit: 0021800a465d495a536265c52f8a031da43948ed ("x86/resctrl: Use schema type to determine the schema format string")
> > https://git.kernel.org/cgit/linux/kernel/git/morse/linux.git mpam/move_to_fs/v7_bare
> > 
> > testcase: will-it-scale
> > config: x86_64-rhel-9.4
> > compiler: gcc-12
> > test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
> > parameters:
> > 
> > 	nr_task: 100%
> > 	mode: process
> > 	test: signal1
> > 	cpufreq_governor: performance
> > 
> > 
> > In addition to that, the commit also has significant impact on the following tests:
> > 
> > +------------------+---------------------------------------------------------------------------------------------+
> > | testcase: change | stress-ng: stress-ng.usersyscall.ops_per_sec 18.0% improvement                              |
> > | test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory |
> > | test parameters  | cpufreq_governor=performance                                                                |
> > |                  | nr_threads=100%                                                                             |
> > |                  | test=usersyscall                                                                            |
> > |                  | testtime=60s                                                                                |
> > +------------------+---------------------------------------------------------------------------------------------+
> > 
> > 
> > 
> > 
> > Details are as below:
> > -------------------------------------------------------------------------------------------------->
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250310/202503102156.d70c4800-lkp@intel.com
> > 
> > =========================================================================================
> > compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
> >   gcc-12/performance/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/signal1/will-it-scale
> > 
> > commit: 
> >   a13ae432a6 ("x86/resctrl: Use schema type to determine how to parse schema values")
> >   0021800a46 ("x86/resctrl: Use schema type to determine the schema format string")
> > 
> 
> It is surprising to me that these commits make a difference in these workloads. I searched around for resctrl in
> https://github.com/intel/lkp-tests but is seems as though it runs the resctrl selftests only and do not
> use resctrl as part of any tests reported here. From what I understand, by not even mounting resctrl, these tests
> (a) do not exercise these code paths, and (b) do not use resctrl to control resources allocated for these workloads. 

thanks a lot for education! this could be an alignment issue.

since we found similar performanance impacts on different cases, so made out
the report FYI. seems a false positive. sorry about cost your time to check.

> 
> Reinette

