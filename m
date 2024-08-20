Return-Path: <linux-kernel+bounces-294693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A589995916D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F36BAB2229C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0461C9DC1;
	Tue, 20 Aug 2024 23:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVHRtKO5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE3D1C824D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198269; cv=fail; b=dd9uSxJJXE20BjuG/j/6rTzU2a+h/LD2Uedo53G/ylfZpLLABYpvg6V7rtsEHfhfPwcs3Gt6kCGRJzh21P0HUJfJXdRJzVcDBfopT8mYD1AbdOBodYRjUTubhzhTrK80lkb7dyZuychJDWyzss9CxuulUoNTx6epCEU0WqnXfXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198269; c=relaxed/simple;
	bh=FtRXExoW3UA/PwrFmUCnWEI3IXpXUrShaeOjYupJ12E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TAIZ/fhvuM8/31rq1AJdArb3ZxVEfOM9w3GsNJKeKn6JC1V116OQID1rDhc0jITWhxrTttw+1HislNe7GK2EWcrUhKJNhGV3piOwvZZd+OaZOloMSLIunChEfIdaIuUI+RRhSU17d2l05yCZZ7ftESfmQySpTe2F+K0OVbmSU2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVHRtKO5; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724198267; x=1755734267;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FtRXExoW3UA/PwrFmUCnWEI3IXpXUrShaeOjYupJ12E=;
  b=VVHRtKO5Wq14GAGPV2fqav7etClai1xoUHE4mY/E3cxkxukoBGJdNF+B
   sj8Zyqro4x3huXz62EubEkpgujgyh4ybXXDeRR8o0zvjHgn6xZJbKqEAO
   1jb7H/Wf1vBa05fWIuI7KD2bf0s3u9R3OVgfIdhaCuIZKMkb2wvK3acN1
   hNMS1P/Pijyi7Ehwa8/vXfwUni5U/iwDrLY0nb2v2D8V/mrUSr3fvMXXQ
   zuZddN6JeNr9mmBBKBYUmwhlc0Yqevhu8zUfQZ1/xDAQoc8bxt4lVP0RY
   5OeuIFymNMrOuZd+snYiiClUjOBCli8fGuFbTv48EDKS2UpPzEnOpSRDo
   Q==;
X-CSE-ConnectionGUID: nPhDfsAESjuzSzobo/rwaA==
X-CSE-MsgGUID: gu4mcxbuQneoUptW1SEkXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22697053"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="22697053"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 16:57:46 -0700
X-CSE-ConnectionGUID: MHRT6ITeSq+rsuVVcD3Hzg==
X-CSE-MsgGUID: OGLWf38ZQji5vuOJ1Da/2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="91683588"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 16:57:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 16:57:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 16:57:46 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 16:57:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7330e6rSsY2FwrKprxPIoh/K32+9n1gd/V/7sPX35XP/I9ysoJy2vaQkZdaHdn2xKWkuQYxUBx6YLgQBikVofSWT7/L3nzZh5bH1PMe2btGIbO61s2Oq2Fd5NL3jtoDPhCRYnlUS8wWI0DuI/WfXyR1LSrR3oHn6YZPg+UT2+Bm2XXTZ2vsVNBiB5OnfulmoFVniXmeFJag8XH56KqToSMRb2nrFc1UL5xBzz8yCOruB/GPW3QTzs8QCxt+zBBDPvcvEDEeR9R2NMH0OuHgogBsSzoWE/e4EPrMbhfcxDr2NGynrFevGXkv1G2WZXao+66IoFNmmb8uaSTZAGCC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5pxmUjwsUg9UfcRn7KI34MXFH36fzOu309E5H/aYIo=;
 b=rFuKh2jQ77/wJ9EuJsHQSuZIgZt2j7rhFSVzNA82q9kyKpNGtl3rX0mHKC1ekFCPuL0tLikdtVObzo27sjg+qVts5Ss3cc9qf3uQlsUInJBl2TP/XzvaSt1sMRB29DKo3XI7VkYS5oVMJUtfAlUVmtCnwMvlXuDInsAgg8EPzDG9NGNdSp9jgfrcMtrMp54ysEqUqsD6YuoT8RFOeXN+Byi5JHLpyD7W57LzX2pOJNl2KR6y1BOl2YCSzltlMiBukbAqAoo/h1H5ZZcSYQsM7dmc91K264euzcbfd4ZfoGY6Mb7u2zpOtpkXr3BAIhm6nwxpkBqv7HlaQl2aN1azSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH7PR11MB7429.namprd11.prod.outlook.com (2603:10b6:510:270::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 23:57:44 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.7875.018; Tue, 20 Aug 2024
 23:57:44 +0000
Date: Tue, 20 Aug 2024 23:56:42 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: fix null-ptr-deref on __alloc_workqueue()
 error
Message-ID: <ZsUtOnyDVJJ96bXZ@DUT025-TGLU.fm.intel.com>
References: <20240815070339.346160-1-senozhatsky@chromium.org>
 <20240815070900.GB12106@google.com>
 <20240815072427.GC12106@google.com>
 <Zr4lN63t25Og5/0G@DUT025-TGLU.fm.intel.com>
 <Zr4rosIiK2a0sGhc@DUT025-TGLU.fm.intel.com>
 <20240816023831.GD12106@google.com>
 <Zr69QOysEfYXkMwb@DUT025-TGLU.fm.intel.com>
 <ZsO1-gCkeGuskOnT@slm.duckdns.org>
 <20240820235412.GF12106@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240820235412.GF12106@google.com>
X-ClientProxiedBy: BY5PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::12) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH7PR11MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 48461736-f5fc-4c86-2525-08dcc173e263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nkf10lfgPop8SnKy0xctkeu0S77xIU566ec/VXDvwFNXKiLkuAM0XgbkaoLY?=
 =?us-ascii?Q?A8ekVB5XAVYjtrsIieixm6Gde1TVcyaj02wpreIgntr4RX6olQSAfVU3YmaK?=
 =?us-ascii?Q?zOLIrIuSD0xgb1GnwSWx2Vc0hRfpfa7tyXdpNOUF1CWsur4FlLZqboR+qK21?=
 =?us-ascii?Q?d4MJlZrN3FJPb8Mn4UmVON/QV9y7eQnJzSDYcB3lLeztvDqbopvkMghKptAa?=
 =?us-ascii?Q?La0lqhcVkJvpyBOE96iIWyw8To29MyjSp5ByU9sm3ETIwkfmDxLzTN5yC2Fk?=
 =?us-ascii?Q?kmV3HwEDa0CtGwkvhZLqYf6fmDqoR3OxnPL0cqZdykOixithrAYbUiuCWkmd?=
 =?us-ascii?Q?w6pc3pp68VwEQZUDDWJb302Av5v5VZqSua0CH9EJ1Qp+/9V9tR0FA1m6fFWf?=
 =?us-ascii?Q?SKKX2YW1CQsFJFsQ47DSTc1p0eZk7YEPoqz9x/GGoOmlrgqt0Mp7WVKaRnj2?=
 =?us-ascii?Q?92QL6gf7sBCv+zTQQlEM0iOmFZH1vWIBO0CU2+DSE4Dv+owqK77MOn0GEa08?=
 =?us-ascii?Q?NC0m3wPYAVUfFn0BnTKLqIqj519TMXlu6asc2zhoWsyYmt5QzKLCror19KUh?=
 =?us-ascii?Q?6o63XvGjvmUM8H5UG1F7rcAYSslQiYg1xF5wCXF1YP7Tdi5gyzRg6iuBzwA1?=
 =?us-ascii?Q?CnvT/lBSpad8WefDoyQxbOHRWS1UEBvpvNRAjEZEHskFk13C6FOdyugVt3Tv?=
 =?us-ascii?Q?wVts5EZ3wAaD6jHrKnfbwkIZpy4NnJ6XE+ck1sOp9KkSMAIp5KH2EEPngqIQ?=
 =?us-ascii?Q?ActKYu1u6g+qPwFpmnO72JrLBkRKrrl+8RAIVRxvV7RRtTZbPLqqnDsNR34/?=
 =?us-ascii?Q?xzHJuQwQkyGRaPqu4795yz4YWJ+vqzM+i+xLzUDjZe7Fr95JoS7ocu21Rimw?=
 =?us-ascii?Q?KzQpVPZrN7tStI/q8pthqpMi3Ci4f3r3HmPAbG+AnEzjtgmZsl+vP26PH1WV?=
 =?us-ascii?Q?nJxS6FFV7xRzdEsU4yNbdiXJLkTXFz3i67k5+87+EV7l6FeCo+6rds1w661f?=
 =?us-ascii?Q?lUCRNJB6qAl5/2sFI7wpf9eQkttZepP+x243w6990q+ZG0diiX6O1O2WUaI1?=
 =?us-ascii?Q?VPpr6Mz0/KJdWUp9lKnauCKQuYgqG54RPp35RR2W+p2NkG3eAm7BPzcxbd92?=
 =?us-ascii?Q?ur++TEqvAXCqQJvNa0r8eKBHf25qgS5Rn41S8kAc7BzU+pH38DyhvIvdZGXV?=
 =?us-ascii?Q?IKcvCqRDQLack0Pk/enwXfRvW+U4HvdrZA1VsIhsdGTvCBczIUn0HwojSQbv?=
 =?us-ascii?Q?wKiKqAj7ghQjcD78SgDWK9MwEuwaRSAGOeRZgDn7+fd3SSbWrzpg/8chKAIW?=
 =?us-ascii?Q?HuB++pBXsELQTFovC3099mNvWt+jGHf0X9h0cLTyW5TSbQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3f6ROCBzV0Waq0TMCsHM28C9+afuii3OJHvOLJzfoelunM/pEkBT3KmfO413?=
 =?us-ascii?Q?k4SYInDZut4HVlW4TxO9po/zrznVl3NPOWhfjJ/3dFK4C00et1TFw2nrYBR+?=
 =?us-ascii?Q?fQP7EZkofLWhPNZ6a6vYY10pb3ZHe0PVjglmxYDnOXrKLmDXcBTzVoGczCqv?=
 =?us-ascii?Q?fZ6u4FOeErP4aIvPqw3Zd6ry79h92ua0/R/bA2kbEMrG7ipRxcg2ADxK0kvA?=
 =?us-ascii?Q?cAUCz4qjKZgE8KEyuty4PGz2lqW2GRuCKQJfBCIMa0TBTt7dH0/qqWYgQcwb?=
 =?us-ascii?Q?DVmW4klIfzayoaRBuPvefyB/vpiGDOJCSnBQV4HgPCVsomzO/cbXyEOF/2P+?=
 =?us-ascii?Q?FoT3MWXtBrGWYQduX/NQHKNKSPy3aQX+PH3vK6wfhmRVQX7m+wLXHBCbV+Bb?=
 =?us-ascii?Q?9y5+pB1lQsY1KM80LyL8JO8L9Z1rdAbNZVAo9VXA6ma4IdQ175aHe0xwGPlq?=
 =?us-ascii?Q?Cs3F+n/qTO5d4qDahU3hFg/v6gqpNU5k9ufggxaOmOQE9mni4nnK+QAt/8CL?=
 =?us-ascii?Q?VL8WVVcqacvxUZ49gSe54qMrwT19EuvuZtqALq4QHS/3LnFR6Se62bgkURPg?=
 =?us-ascii?Q?j+D/ARQogSesaMFIneeQnFwIZ6b3KofXM4rZ09dn5KW8oJgEt6dk+raVr3+g?=
 =?us-ascii?Q?JYjv4A9bxMPAR/yzFPkZVyzyEuo6voHEjXyAlZBwnH3wcKqExyGPRAdGa87D?=
 =?us-ascii?Q?RoDsDAUbpg1H8G6SPUnZ72eZGHZtP9iPkoBqS8kSA9uP2aolmSnqrhVHA4M7?=
 =?us-ascii?Q?293I/094CEyTYV5UoaD3h3uzEhHMipv9JYlZm/V4U1f04C2momXsrnG4Zm2s?=
 =?us-ascii?Q?9W/WEGzP3C+UII/RZuOBo3QoduiPQrHBYC9Jbgu0otATdpZ5Bs+MuEEZZNAY?=
 =?us-ascii?Q?mfFm9/nh5pnQPw+2mtBzGP01PhI/kJOX78HE2STiel+WPyWPamETQNZYlVHN?=
 =?us-ascii?Q?gpTe+fVvsX3bPCSgEQ25D5uCpvyrTgJZknNEvbD5IgmeCgKjqbG5+/LPaNYM?=
 =?us-ascii?Q?a3LSRXdNDh4qLgNy4nTB2wqsSjdl/uiIxJ7Xxj6XAuVKIVli+e/9/sNZmtk5?=
 =?us-ascii?Q?C1wgzASrKnz2QvwuzXpEboIIzVAzJs2Ja+KmF4CouKRBAaOdCKGfV7cm62oz?=
 =?us-ascii?Q?TQJexBRbdU5OF6lYRlcDXu38IPZr9UjYbI6mSyDi1nhJa5nF+XgNQOkACt3e?=
 =?us-ascii?Q?IsuGUVtW3kuMBu1j5FxiTSqzG7MD4RAQTox5mhUUOiC9vrGW271sFenzw6jG?=
 =?us-ascii?Q?YasqLG0UQeImkRFNsPBrMka7oI28HxFtGaEn7C8K5OBA+ZZS+3DtCfp2b9+L?=
 =?us-ascii?Q?wabh4Vrtw12cBdkht3nS4Fl3x0p6+45uaRAdrW7y+EyRKQzYAoBYfpqQG1s1?=
 =?us-ascii?Q?07yKnGZLwtknJhUPGUaNqHFdMztn8bgPCzq+H4tzrlRkHZOWUx7vYGTxUteJ?=
 =?us-ascii?Q?diQ1C7xf+S7us0K4JK7aeYGHy8TBnto1QTuQpNGH4xNN/TsOpy0cBrdS2zzw?=
 =?us-ascii?Q?8BwoJZf6YZfZQ4ImZTVNLSmlT8B0suW7jyfbnu7+lr6T+WRlDwqfxIHme5ep?=
 =?us-ascii?Q?7SqAKZ9gZVc78iVYkOH/QtQux6VwJCOsK82VmMtrMAefdFYHzmlJhIv2pJlM?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48461736-f5fc-4c86-2525-08dcc173e263
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:57:44.4270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwIyPQ59mRelMoX9q60UP7DexFf62NFEaNHW6tDyn/xqKdBnY3Wv4+guvOuBsEhBpcnE9HRN1DPJY/yzxGIdaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7429
X-OriginatorOrg: intel.com

On Wed, Aug 21, 2024 at 08:54:12AM +0900, Sergey Senozhatsky wrote:
> On (24/08/19 11:15), Tejun Heo wrote:
> > Hello,
> > 
> > On Fri, Aug 16, 2024 at 02:45:20AM +0000, Matthew Brost wrote:
> > > > Tejun, how do you plan to handle this?  Would it be possible to
> > > > drop current series from your tree so that Matthew can send an
> > > > updated version (with all the fixes squashed)?
> > > 
> > > Tejun, yes let me know how to move forward with this as it is highly
> > > desired for Intel Xe team to get this into 6.12.
> > 
> > Can you just send a fixup patch?
> 
> Well, this will make the tree unbisectable (for a range of versions),
> because the errors in question break the boot.

Can the patches not just get squashed together in the 6.12 PR?

Matt

