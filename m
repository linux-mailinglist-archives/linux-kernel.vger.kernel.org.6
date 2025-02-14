Return-Path: <linux-kernel+bounces-514235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D04AA35472
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458423AC23D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5DC17BEBF;
	Fri, 14 Feb 2025 02:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKEkIx3v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977E17084F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 02:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498621; cv=fail; b=dc8nYD8WimXKlyb4HN1iREbo5TfuFJe1WZAKxVkuI13rlmFtXDxECdIlxYgDFA8cUB2/LQz0JcQlfQhmC0cytWfMpt9+8tA/Dj7o0wCtwfczMZhQY4Q1fRxdftDRPAQg0vmgGuuJAT2uMllpAmEI8G6sw0grTWP6umU03oH0pJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498621; c=relaxed/simple;
	bh=Ah0JZuSqKLOf1yxCCAFBbbOcO5C40QN0DHDQ4HHG7xk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=MyKzYoR2P/nh8xWfZ6/HExQIU4YPq6p2GY3aWFt+RKft+FtNbqDOpydAAhlXLr3h4jq9Ygzvu89BsTIUeA6dsp2ltNjo8fIBoOUcz9GqdXvD/vw3GNI9jFOwrjuPOkRYKk+hVlZYU3P1QTk0LjCoy8O3r+b8MZJmeQ8KaVjgcV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKEkIx3v; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739498620; x=1771034620;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ah0JZuSqKLOf1yxCCAFBbbOcO5C40QN0DHDQ4HHG7xk=;
  b=VKEkIx3vWcIeuAszyiVNNBN0/dfVt4wrIY6WzrRoEbuN9JWGS2vE96Oq
   WvfVBIxuqRAfs3w/+waCea98Nfadpmchj06M9gFEW9dziAk/jHOLmt8X3
   El0thHeW0witqsKfRfgcKbV4rYbQeAJ/+FDUT8wKezRbxdnf0b0jVKeWn
   PnJU9VBalzBYZTqVobnujNFRYC/RN9kRQaxcYDbyFfZMZet5ZXZFwquY6
   SmqXvqn+klcECMLBtL/rP6QGUafKPZCMslKTzDxmrnJ9b7j2Aod/CtAbx
   H7bApd4gJoMkhm7YI/4OyaR46hebnBN7VVYsL8sNjzSpADQlYTnjLlMgR
   A==;
X-CSE-ConnectionGUID: addY2bUFRz+5CxiudzqJ+Q==
X-CSE-MsgGUID: pPNlQvJgQdKATTmXaKHT9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="43066581"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="43066581"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 18:03:37 -0800
X-CSE-ConnectionGUID: S5gfjq+gRRyiycPDUl2sHA==
X-CSE-MsgGUID: H8CWBdypRES49NughiSgkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118530386"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 18:03:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 18:03:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 18:03:36 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 18:03:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLhTjsHmTlfuwIDfY2TRrbE2pBKFa6uQQy+u7U8r1347NiuhHzeNtFs4tPSdnveSflBtRzJyfUpWGkjwkFmHk8+M8lWS4IHo02hEV5qA7UISRs4oKHspHg8vknl+bbffGXVBglvQikCW0sNhjUCPHVX7xB71b0iO0oCqJwB80bTBAbxfC5qMfoQHs0NUSiDIEg6QsMLtsZWP616dlhzBOilehGozKpVuTSSnUPLm/LNRHbuAranM54aZnVPM9mHOON3QAWmqahBDhgxB0ClZz5xCv049liM4W6amw7uRTRP8eDaEVV1Mq+ReLpO+twwcL6vNotxAnMjb0pCd5LqZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAHx6/uO07jhgbLXdIQN09ebqxconFpR5WOJ+HXH20M=;
 b=oQJdv2g0efY2KeR8f9NaB0Kd3PUjUjzF99xQv0NkTcEAZE1c4LHyeKbG8lD/MT/KREMrkuj+e3w85c04GfIF77QbbhAyJC43HiZmjuSOx4B6dIGRFFxKl2hOXhEwtPpgwYdugCAb2aeI7/NXSKLoka/6f/AD//ee65OGrlVAV0zc4zN01k803lkQKhHkG7paTZqvlbJREkKw0JwTXQXXS/4VVWYe7xvOkZU2BT0zyGPJRzs4kxkOSD/WoQ5otX2P7prpV61KPmishlLHhkuOlIgyfXK/cdgF0RgeyhCKKKs4Yj+i7IEh6TMtY+j7h8RHEoH7Y+fUoDBEsRzeLVlg1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6875.namprd11.prod.outlook.com (2603:10b6:806:2a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 02:03:29 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 02:03:29 +0000
Date: Fri, 14 Feb 2025 10:03:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Petr Pavlu
	<petr.pavlu@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [x86]  66fbf67705:
 kernel-selftests.kvm.hardware_disable_test.fail
Message-ID: <202502140800.ebac2328-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: c57e42a0-c4be-43a0-5ae4-08dd4c9bc690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DnNmdjODu7CMyp95Zm0WACpm9EMu/UaW8H+60OiFhRRepNCNaDyY0Mpbbyxf?=
 =?us-ascii?Q?XS84GWjzdW7vAESKQGXjQtqrr1eXd1KY27ZwB+m+rhnjD4ljj7/fEolgbU3k?=
 =?us-ascii?Q?S89Ew1IkuI/2OKtkV4wsD5ReAgtcDxXeUT4DrtjQdPl5uNvIZ6B/o968FA79?=
 =?us-ascii?Q?PiIhNN1aKwyOLpg9owR/VcAQmKCMlm0cgedp+850BVknBgAM88xcrEWoETp6?=
 =?us-ascii?Q?pVekudf6Rd604lB83b7kBLyGQaB2rOMTtAzifoqHHHxnMRIOJFZPR09YFqqY?=
 =?us-ascii?Q?4gk6Fl+V3cVPYlPgO2QhYgK/As3RPeecrfr/bCH5AW0cacACij8K06esqpb1?=
 =?us-ascii?Q?EshkHxAe1Pd36cHfbQYwrMZFmg9Whw0BWyQw2J8zC14QMNvxYx07yqkEQ48+?=
 =?us-ascii?Q?EWp0Gn4YxqPlYhCoJwAo+KWEwgP43gjtXC15ZuzePn5WqYPuul4PTTEnO8Y0?=
 =?us-ascii?Q?lwLhTUBOYWp/cttkwHEZLascpexY2ktUPWC9ja6gtInsbllVW1p06pK+smCx?=
 =?us-ascii?Q?9/afJip4ljS8EDSDLE8Bn7rpywHNpkoYil7ws/D6xyfg/yEFuciQdTBu3vQg?=
 =?us-ascii?Q?Fp2Z93TzU9dK2nYOXGRnacYU1zXQgrUUpx3Vu0GcQO96olWsL9r6+1NPdhwf?=
 =?us-ascii?Q?VrIOOYxqk6ZKnHgPcKaBEMuWscb49g0hoMV2L6mUJXCyt+XeiNLYlO/Dsdhe?=
 =?us-ascii?Q?PKIAnWVWP1sY0rUbLwkBq5fKCv+k3gnWyLj0UmEX5HLI3PamKo7vYlRqsWhi?=
 =?us-ascii?Q?QlV5BGbK/pqYKF/SOrgJytyFnvdXz31hZgjplVsIt/t8FK9OR+nWTXoYKyKv?=
 =?us-ascii?Q?325mNmqsXUOnh+9DbMHOsdzeHuuEwl70fsOcmapBCVs2iH1PXdlX0hvJgbF7?=
 =?us-ascii?Q?d5ShiMLrHHfXGP6Z3/0SXeU+T+sHUUBE49Ziy6IRwCgmS6cRIpO6G/ZpQyrk?=
 =?us-ascii?Q?nlzwGH7Cn/mvZ/92coT66JwYNLBsIFXH++abjKKpWbe5WmEFGlrJ/PgdzvQ7?=
 =?us-ascii?Q?l4ymtcpvxFilKP/2/+qG56+/0VQf6T/ULNXGkpvIK+tNoFCbJ/zWDEbB9+H4?=
 =?us-ascii?Q?tDl/TU10i5ArdY+3fnyct/1ZDAwS8W8K8hW6Tr5WTakSiwMoZpJtSZ8IwpUX?=
 =?us-ascii?Q?UP8q27etLbvgMTZB9VUWBYUgtaxHqqbAn4jjz1MHP5fgxn+93U+Nev51UX11?=
 =?us-ascii?Q?kIMiWJBdwBu5FWtjXHWuKJxvyim9jhsHwXRfBwGQFq7JlAe+x3mZGeXHbYPb?=
 =?us-ascii?Q?nSh2xIU5d3ClKgeLu91V5+2JLaD2N4WTIDBaD95JdVkWOPyR5g3aDdIpa2Qw?=
 =?us-ascii?Q?z9DJahTZwu6JaxA+v6C/aPuvbnmqyNnWLry5PT4TE1GpfA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pwsT37PGTqUmmQah+76yYm9rj66C20hTUKCOA7+8b4QoAF0KixeNwa4H7jmO?=
 =?us-ascii?Q?p6CveIAqzQMgvxJHkIw4LuK3aS5zS0G3lfeTMOXUceWGpuOpBz7w3g6DmHlD?=
 =?us-ascii?Q?wrbBjA/nBukMN1f/SyKKPZvUcdkybfm9N7bNuTwmXkj3SY7SiEzhbvzeDCIQ?=
 =?us-ascii?Q?CjjMcIPDLPD5a1BaAqZSyMscKvFzcCaFi4ScyYe6tv/K/CzcblEyCubXJhEx?=
 =?us-ascii?Q?XERQi+KnK5F0j4/1uZKWg44wKz/CbjijzNd6kbHxKcWMYvAU8lB/Gxd4d+0U?=
 =?us-ascii?Q?bO0kC+F2aPIyiRaXQJMTDWQfzMffH0gYHlo7YE4vvzlqff+VusQPuzPgKP4l?=
 =?us-ascii?Q?LKdLCTAhL4UlCyYGOCcFPvC+/53PvHg3V4GXIJKhzNX4M3zVOgv7j2F4mRq6?=
 =?us-ascii?Q?IopL/9uPa4IEpXaSrRnu4NQB2di6VRj4cMwnBYDtlevueYmJA0wkytujLXhQ?=
 =?us-ascii?Q?Kd3wtj5KQfXWUM67ICj3VhKKTdXJaNUbGKrZZcc4kd/KO6A8xQcyNgNs2yqj?=
 =?us-ascii?Q?HnSS37b1uTiUgjWHKVntqzA7CMJcz6xKkDA0hXnfEstQ3fFInxsxMHx1+nZl?=
 =?us-ascii?Q?nHzoAuILmR22pIlEKLozTvv9lZsXrYZO2xIcpOgf6FktbXPZgqVJsUV40KUG?=
 =?us-ascii?Q?2hldefFrsHAbTFCyhvAzAOuiZTgw3MyiRqLxhNCRizxk7/BcOAr5AU8m8tnA?=
 =?us-ascii?Q?8i8HuulFV8gJKWRnV3m9e2DEE/VqgHt37X90nvFWi2FbXoQDxOZBXPF0eSHI?=
 =?us-ascii?Q?dxbodPUkmO2PsDfQCKvIIGrl2a5GzIGkZQDxNHFz8hR76mhtnU2hLPvJkM6E?=
 =?us-ascii?Q?PW3H2DyttGRRJVBBFCs2ArZXTb0ivxpgjXRQLtkkPvCfwJp6li9rCXBhZBs7?=
 =?us-ascii?Q?VNx00JPdA0U3mdKxEkyJKFGzQPictqq51f6noZjZVRWIMSDEcIuLLBRwvcO9?=
 =?us-ascii?Q?1cM5rS6hqm1pnxcy0JWHQ4fQa0iTDvDY5vi6DqTJIejaQAuyhGAhLepjYD/i?=
 =?us-ascii?Q?MxgQy0da1YLwAZBQvZUcSAwVBPkNH9LIVHcnV42FvW9SvK5N/qixYG61VQJe?=
 =?us-ascii?Q?HID4xYpsqIn0xOuEARQxhkpBYX6D1X7I9HfVQvcJtg6UztVLCeNHeUyJNp1r?=
 =?us-ascii?Q?2HQxvypAkC0GQ8biKBHiWc4F3BdhWqUw+CE/c7byubkFGd4WQyeIQW9nPMhh?=
 =?us-ascii?Q?nBJuLbQbA2WwzpV9SelIkTy/y990PGdefk/VOhkAlXhfuJDh5Un3FTI+MvgR?=
 =?us-ascii?Q?k+bjIO+0RAbJtlQe9UIgrs1pt8va50JyFILXP6/Ct68KxmvbZjQ5UEiNGhoV?=
 =?us-ascii?Q?ZjkVZIA9IPmnbwUrRATK7tJid3vD88m//2ACGDk9MFyFyh56j6BQEWiz1NYG?=
 =?us-ascii?Q?jA0FgHFwxIzXENDEgeQVD7C46ns58pcFvp0vINY4KvA6yxFBp0zlkzYHmvTB?=
 =?us-ascii?Q?wJaHQpCYc/YpnYYLcCSwuAVriuq+tKatHXjviNTNPsLQtdMKZKpTZKjMGadp?=
 =?us-ascii?Q?t2fOd5bdBn3LHq5Uf1NB0ETpi9PgopwiZCMUPX0KhhmOGMK9OhT9E56gbSXM?=
 =?us-ascii?Q?STeGvcRdU6h3wVhwVss3L6LGqvSZJjQSjrl3HwFujZaHwjAmhn93ZW2UmXhb?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c57e42a0-c4be-43a0-5ae4-08dd4c9bc690
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 02:03:29.2427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AqnyGisI2vewd4XBY++V3O/zH5j5RemnQxG+bB1bsAXRCow20EW1Wc6R2V8tkHBlk1e0m86/rowmqN/R4ySNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6875
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.kvm.hardware_disable_test.fail" on:

commit: 66fbf677051818b9b5339fa8bfeac1b2e288efa5 ("x86: Use RCU in all users of __module_address().")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master df5d6180169ae06a2eac57e33b077ad6f6252440]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-7503345ac5f5-1_20241208
with following parameters:

	group: kvm



config: x86_64-rhel-9.4-kselftests
compiler: gcc-12
test machine: 4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502140800.ebac2328-lkp@intel.com


# timeout set to 120
# selftests: kvm: hardware_disable_test
# Random seed: 0x6b8b4567
#
not ok 73 selftests: kvm: hardware_disable_test # TIMEOUT 120 seconds


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250214/202502140800.ebac2328-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


