Return-Path: <linux-kernel+bounces-183321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3580C8C97A7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 03:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5917E1C20DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 01:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF22525D;
	Mon, 20 May 2024 01:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EeDRy1SE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEBEC8DE
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716168281; cv=fail; b=tm1o9FboEIPRjX5qrDBR5arl0PIPfnHtftp3F8R8dhDN8RjaCtgBbgj4nNf1Om4u94+kJa0K2LJhPsyaOMIyjB1s/tPp7lCHd6ctcJ7jS8PuoOlF65QK9kH+VQQ72Tsfm8wVTe3jW3Udwtuwsv+xrM2yAUOn6yodUQDvL3oLImw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716168281; c=relaxed/simple;
	bh=NFKhIgAZvax21Jot8/HNcQeyKTWVXn4uQ1zl2ClHrok=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=prJCQ84EoSlKHS5dEpi+HwFbyB1dyy1WqbCJgs3JPSCthT4AN9neBzS7CvaReDQgoeMT2tYvqMIUAiGEK1hYWn7VFQHLLrfkaTF7vky/AOIdOK83CMOrt2L9BFNn/N04DSYsPGIvNCePYcftD3fBYXJy7xqSGqXQqmdCAR32sng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EeDRy1SE; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716168278; x=1747704278;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NFKhIgAZvax21Jot8/HNcQeyKTWVXn4uQ1zl2ClHrok=;
  b=EeDRy1SE0O8YCBkmRWowalJ7ed0w0SjZl89nvM4kAwJW7zJG07sKDfSu
   3yqRPDyZPxGT42jA/UHLciYxqjpMOKkbSa0OCNrlSfNSC6+oZcPGMxm5A
   Xut4AG4IdtUQuWoKOqJz8ekd34jZXeJbwVxgVtU92jV102eZF3GHzjBlA
   12/R49JnkF+54Mc3HWytOgktHbamYyb6z/1rXKP6ObHemT+R7pxvqmnd+
   6hxAaHnWbQPJJDWyCrUBycssAponuMCQ4NUgmCgM9A1KS4wnGImSASceV
   RmMtjIC5JIyfsZ6DTgjw0asD9JhPTl8FYjp+w7WFDURYLrDlmXXvhLbDO
   A==;
X-CSE-ConnectionGUID: jZDvZztyR064dZoeEJEQiw==
X-CSE-MsgGUID: 0lfJPGXyQ2ukQsjArejIFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12388103"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12388103"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 18:24:37 -0700
X-CSE-ConnectionGUID: /pgZfLWeRNCvph7rtg/t3w==
X-CSE-MsgGUID: fZCKcwvkRTiMRQkZWJXm4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32389423"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 May 2024 18:24:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 18:24:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 19 May 2024 18:24:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 19 May 2024 18:24:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOEfa2kCvPHyVg8Iivjmv1FUYEy38mCR5XTv9oJVAk9knmwJ/cfJfs91cBU80JroHVc5Fw6LqS7JDBRGCLZMJddCdfuSAij4rltkxHQNMKlTaP3s8zbnzaW728T4Hg4Ep0XcH/UwZBufDiEcrjZvvDgMdmHUnxC+PDlY5YgRVgPeSuXv3Ny7PtH1bR5NU79HXvivz5vH3YLaUrlbvlR2G6dB11GwQz2H/I0AdqBcNPE+sjA0IXEzBS0Dl2jtTW9JOX+GQYzVC5nekmB8FBS/8iED56PKLbZ47+Csgtnol+CC1VF7fLiUhg5375B4mqjWR9bymFz+GnTPh+Bm3Cdmaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDX7JHjo7hrt2NBQyN1/KnyJmNSitugEJ6wakaiF314=;
 b=g5ejCeheO8HrKIHT6Inhz3Bq4jY702CNNs/wD7Tl/loqV0xrJKhMUMX2YQesHfJ4BB2wApnILMavhy3uzS3qElkrOnQUhUYJoQLA/IRtRBMSO4QIfiTacZrk9+k5qrKc+2UQzxZD3KOJwrgI/B+AYOHFhZWoFjDF9eKF+hVXFKtBGBm0P2lMQ9JBkPorzlnJ2ZjU0iiabEPeQ46AGyJ0njfBIdFsUsjzM8/DtMGIiuNtQAc7G0/gGbErEHSd9v2moVsqFKnZWkb37h75wlELEbQWB/l8wwGdPYtMGOg5miGimwDe+azT1mP/EpQWjEUtC8U3gUC4XMy/9vbkg0PRyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by SA1PR11MB8328.namprd11.prod.outlook.com (2603:10b6:806:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Mon, 20 May
 2024 01:24:34 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45%6]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 01:24:34 +0000
Date: Mon, 20 May 2024 09:24:35 +0800
From: kernel test robot <yujie.liu@intel.com>
To: Edward Liaw <edliaw@google.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Tejun Heo
	<tj@kernel.org>
Subject: cgroup_util.c:410:58: error: use of undeclared identifier 'O_PATH'
Message-ID: <202405181620.zh4EErMk-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KU1PR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:802:18::20) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|SA1PR11MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b94ca9-8fbf-4b44-f40a-08dc786b9b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XPkhOM5QvbLDOS0G2zBuE5PZO1RjEPsVIjf2nxwlcT5qSvBoSQYGsxJzibfJ?=
 =?us-ascii?Q?iJYwt86BA93YHW5xiWdOTNz8VeRDDdh9ZAQ66QwdPt9n2+jxq+TlZvM3q5Ft?=
 =?us-ascii?Q?iusRy0rNWS7te9fPrXGzXs4kXDRGQeS4uzeiGR/c3eEmKx4v0nspWHDCnCN6?=
 =?us-ascii?Q?0slFLRsT94ozc0HwYhNYYyVUYLt37H8w2sSBlMINpOAnYleyMN3qTt9MZ/US?=
 =?us-ascii?Q?ralaMRifSHuI9LRFcFoYOxVLZ8m/ZqgbvQ01JvtpXo02sYwvGRipyYAaUTrL?=
 =?us-ascii?Q?SNVDizAM8A7b7KSlUIhGb4GcDZbr9ab62o/LYEF/8X3Ml44Rah0w6kEJ2ggy?=
 =?us-ascii?Q?OfQWBc3P+WFCppDZKpNuVIK6OiAx12NiRyl3tp0G+dfjzBzW4j7KC5Rcm5eF?=
 =?us-ascii?Q?lBVaSuR1bgZiF205ceE1/c1wnxioIWPAmk0WxZXNrZWyXfpExkxy7uHs+cCX?=
 =?us-ascii?Q?1lsLFcfLx275QYUBZvvDDtdmjbuPnSxBZJPWIrEfzwwe+mglOOIT1HdcPjno?=
 =?us-ascii?Q?nicDGovelBIFqRCqzb9ge5XGM2d2XA9iaRtq/hHjCpdk0W7ZjuVf81NcAv8x?=
 =?us-ascii?Q?C8rhAv+h30MRa7QI8hKaw9KBlGOC2zEkCqnAoELllYg4siw2FqYTqKpTvEBX?=
 =?us-ascii?Q?ViHqGpn1gqlevsA/QZfQHuKTnO20BmXAS1B5q+7zeh21r/GXJL3sJpE/5fTl?=
 =?us-ascii?Q?UnEpH9x8AlJycUHQRHmHJoHP4udLoKPxsdsrHQ7/8kwUoMUB9l4EVBnA4iEg?=
 =?us-ascii?Q?d2DP8p8wvVRm/drOfL5yrw91Uu1q6eqBTmOP3FbHEoKONp5IVGvubgkCq2Go?=
 =?us-ascii?Q?zNRzvweugIk44B/poKmkUv41UGMKwdGEHRKM2Zw1MXj+QIw+ph7Lt9xhupfl?=
 =?us-ascii?Q?U7hGWVBltard3LbV6M5MxLMD3oYFN5jdHgUvAxNMtYADKrnG6i4mB0lVdTq+?=
 =?us-ascii?Q?LClXgOzbm7YT9qcIFzKmpT7yF+b0TdOT/89UmxL+gESrrdABbvimz3LVMAOo?=
 =?us-ascii?Q?LNjTh9T0Rnn6YZvi1Ni9VAiVDuxu1BcSi2GSg3YtlT9mf7WOCYCNL05e9W5F?=
 =?us-ascii?Q?shPfLC1jhUns8FSpO4w0cJ0M/O1OCJmRO+dPwXNW/TTGCA+UmMSG3gKzi7mb?=
 =?us-ascii?Q?ff/xYo1YifOYAF1OcdtsmdfRORc/yBZ1IF+wZ6F//w8RTQ2Fwp6bzSdpEgIP?=
 =?us-ascii?Q?idUQh9P1xuC1XW5rTh8jHjoKiCke76kLywbn1JfemoSDzjEbkKnwFUDiECk?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mrZYUDu4M4FXc1YRs5IPEdqp8nRDu1S/ouhgwZjUsoKFVjyvR3zN2590OVaJ?=
 =?us-ascii?Q?KRW1dT8ZhMTOy0RorbmLkxCb58U4MdqeFlRziJzwDVVD2VWUzzHfjmALGrQw?=
 =?us-ascii?Q?5RHEaoS58eIYrp1+bXfYagwaHjgjtPjmvSoipQbTWunEGshD31TI9fnomNhb?=
 =?us-ascii?Q?Xqa6bCo2OC4tS3z0XaLUxX75Ibvad2oWopMyclJNjZf5CpBf1eO2wA0MqOH7?=
 =?us-ascii?Q?znmcLpSlSrxnJpYyymTcloO9CZFolOtc0GDz+NqWhHJPCL0/CSqY5VaSu7mt?=
 =?us-ascii?Q?l9+7aS4XVMkocqOAvQ2IpuafEy1wD1uVof2m40V2CPuTd5Py3xgN1BNTbLlF?=
 =?us-ascii?Q?0pyrIEo0X8Ay1kRU+HuhH6/pqhsOYHKmp/6t2iMzdVLbMlNsVAlmb4YX49p6?=
 =?us-ascii?Q?JvlWEeYqf4DcjdhrHfBfw7DVoR7RdpU7T0EKAG2S5yFRiNdrx8Xk0FwXSjmX?=
 =?us-ascii?Q?8zED7zjZpma+czIPMIPYJ5SDaWHSVsKjDA9zkG8oqGRsLL2NXE8Iml3CSkFS?=
 =?us-ascii?Q?9L5l4Rasp1TC7D3tsXgfX0d80zYHtrTTkLMKPeYGrVf/hx7SZm021bfzV/Sa?=
 =?us-ascii?Q?eYJJzcSMR9OP7ZrNtdr7xtqQVx9LWuE3jhNnHHYTqDbkSSVOnm/UGXx2NsXR?=
 =?us-ascii?Q?tuDzXapc08RgiolgjCjoweS4j8bdFoAgxgOUrr1FQkqVnTyZyN3U6awv4ni+?=
 =?us-ascii?Q?V+oo+Y+x6CCt/MnBlFxp8lCklHcbYduXvNJaKxw5wSeIBq720WN1FQ/cPvEa?=
 =?us-ascii?Q?ee7+uPcjtJ4pXnrMmLmgSuepYTaeHW9Rg5CBP32xNzvZ4VRjS02INdkEfyrL?=
 =?us-ascii?Q?/gKp8JCYVaaln+QvllNMgaZr0z1se1JJ/fAHzeijn3VY9uwdE/TfH6UMaL6H?=
 =?us-ascii?Q?ik07jh0jrsT3sUiy8lpGxk0okpPTIahzYLc/4o1N0/YgP/tsCWbrn2pWVxgP?=
 =?us-ascii?Q?W/eJGQDp9LJ2NpVu+2FFBHfMsNYb+38qKkV+E5xzuFRwOhwnKU81fLasyUUM?=
 =?us-ascii?Q?2ly063P/le8JlOfVFT4NUEb7zEy2snUzGgtdZ6BT+bcTiBOf8ImdO0iMV4x3?=
 =?us-ascii?Q?zLBqkaRdb5nHnKzNmmJ7sE8buITfH/6nq5/OBT7D+GihnrBrNH4kyD9QXZut?=
 =?us-ascii?Q?t6xzSpW0Nn3xHtgGpaqLOI5ji21VyqpuFmY7ZCDe7BfVQgjjc3gRWBwqSJqM?=
 =?us-ascii?Q?p2Isaug3qftj2CE9SR1kTvL666t2zqKE/GxCbnmv/lf4KGZlGDouW8MIpUcR?=
 =?us-ascii?Q?yzCkJVfwq7IaGYv7fmnE1uxv5RhKwD9YcHVP4hlfDNl3uZRUjoRgQHEmWJI3?=
 =?us-ascii?Q?ZoiinnuZD+cYyCDZiOShYNU8iDwnHyNqXUzrVN1zZNWtYSHDBEKZn04TnIGE?=
 =?us-ascii?Q?kM2UC9YTEkpVqMEnvM+Y4RxQIMGlm5HcKXaRAQQSnHwu/BhumJX/YzIwN87u?=
 =?us-ascii?Q?BMV3OuA065oCzGDwPfHrDkFkzqxP+11+GCIzfsj+hdNDW/yo+QBGtLcR3XtJ?=
 =?us-ascii?Q?fzTsOkd1cFQWZnKf73G8dZS4EGBECPA3TiGGT4hZyo7BuyjdEFkwMvts5F1a?=
 =?us-ascii?Q?MvJn4/A620YyXFgrKmW4fcPoam2R6hlV2vNhbe3U?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b94ca9-8fbf-4b44-f40a-08dc786b9b8e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 01:24:34.7876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdcH2Ui0pB+akA6fGmImr7CPSSaYI7zU/7BlknLX0EFXpxQsWvCFi0KPOOoMqjcOR6T87VnVpwia/wBIFH12wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8328
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4b377b4868ef17b040065bd468668c707d2477a5
commit: c1457d9aad5ee2feafcf85aa9a58ab50500159d2 selftests/cgroup: Drop define _GNU_SOURCE
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce: linux/tools/testing/selftests/cgroup$ make

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202405181620.zh4EErMk-lkp@intel.com/

All errors (new ones prefixed by >>):

>> cgroup_util.c:410:58: error: use of undeclared identifier 'O_PATH'
     410 |         return open(dir, O_DIRECTORY | O_CLOEXEC | O_NOFOLLOW | O_PATH);
         |                                                                 ^
>> cgroup_util.c:468:19: error: use of undeclared identifier 'O_TMPFILE'
     468 |         return open(".", O_TMPFILE | O_RDWR | O_EXCL);
         |                          ^
   2 errors generated.
--
>> test_core.c:804:8: error: call to undeclared function 'clone'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     804 |         pid = clone(lesser_ns_open_thread_fn, stack + sizeof(stack),
         |               ^
   test_core.c:804:8: note: did you mean 'close'?
   /usr/include/unistd.h:358:12: note: 'close' declared here
     358 | extern int close (int __fd);
         |            ^
   1 error generated.
>> cgroup_util.c:410:58: error: use of undeclared identifier 'O_PATH'
     410 |         return open(dir, O_DIRECTORY | O_CLOEXEC | O_NOFOLLOW | O_PATH);
         |                                                                 ^
>> cgroup_util.c:468:19: error: use of undeclared identifier 'O_TMPFILE'
     468 |         return open(".", O_TMPFILE | O_RDWR | O_EXCL);
         |                          ^
   2 errors generated.


vim +/O_PATH +410 tools/testing/selftests/cgroup/cgroup_util.c

9bd5910d7f3db2 Christian Brauner 2020-02-05  407  
9bd5910d7f3db2 Christian Brauner 2020-02-05  408  int dirfd_open_opath(const char *dir)
9bd5910d7f3db2 Christian Brauner 2020-02-05  409  {
9bd5910d7f3db2 Christian Brauner 2020-02-05 @410  	return open(dir, O_DIRECTORY | O_CLOEXEC | O_NOFOLLOW | O_PATH);
9bd5910d7f3db2 Christian Brauner 2020-02-05  411  }
9bd5910d7f3db2 Christian Brauner 2020-02-05  412  

:::::: The code at line 410 was first introduced by commit
:::::: 9bd5910d7f3db2f65be139d2679dd9daa4a3419a selftests/cgroup: add tests for cloning into cgroups

:::::: TO: Christian Brauner <christian.brauner@ubuntu.com>
:::::: CC: Tejun Heo <tj@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


