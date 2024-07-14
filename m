Return-Path: <linux-kernel+bounces-251775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6205893099A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 12:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CE11F214E8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 10:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9C34C61B;
	Sun, 14 Jul 2024 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XvQkWm7F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D963D282FA
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720954761; cv=fail; b=eRod/A0IyZfBbpVt8EytFQ92shQ5rEr7SdfIDAgU96uktsLLBtyonq0wnot8jsfk17BhR2fp9bDp5ZE7JqixYzUdCz1u4NEbRRy9sJkGLFr/XQWGpuKErjlPM0ZnxmbL3eSfP91AWSwME0d0NyIFmKTrEbpio+w4NTSHvPR7b38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720954761; c=relaxed/simple;
	bh=r2khAoGR+XyWvupuRYqI03ojpSA37ARSWNPBkE8zXrE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=RyB+ysVuYXPHpRbmSNWQpq/1fMfxt2xlPnx/vdMmPolewnxitlNj/YxLyFaqPNBcIIYTiVjIY4xMUZzRKB/STbabCJyW3W04eHtNEH320bkEYZkeP31lGvYETssLvtPPqGTUKdsvpWeBG0OGSrCQ4UQUlpgiJ7LbAHJVk7+3Pu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XvQkWm7F; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720954759; x=1752490759;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r2khAoGR+XyWvupuRYqI03ojpSA37ARSWNPBkE8zXrE=;
  b=XvQkWm7FP5D7sXvafhd9Soe7vWpBo28uUm1JWX1CcsyZw7ejmMhp55mA
   GFBRJnHQ61D9eIV8KKo3VGFSDS4QZBsnGWoKXeN76OyCM0fs28bWAOokH
   l1uBAmuf+32jtRDTI1Wss27UJSJNNfAMcdfekmvk/8s58Fvd0dVgzXN+h
   uy7SNBHwFfYFLGsmMxIgZBFXsIA1IHLRX+ycJGwDfCChFL+n+noWbJfTK
   GRdNuZ21txMaxCQ3oF/GnCZ+TTQY1gEX9Kr8w99H368ifDUefA3Ty13ik
   aUVGX3AY1TPukEWieMsDAsstTtJ2K5Td1TS9yJIY5w6fi2f/hwTbIGnnu
   g==;
X-CSE-ConnectionGUID: i+RDifHcQMa22wTIos+i1g==
X-CSE-MsgGUID: A1rtycuJS0GC9poYi4z9rA==
X-IronPort-AV: E=McAfee;i="6700,10204,11132"; a="22107945"
X-IronPort-AV: E=Sophos;i="6.09,208,1716274800"; 
   d="scan'208";a="22107945"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2024 03:59:19 -0700
X-CSE-ConnectionGUID: LQ9m478YS9ecMUFXK8yAyg==
X-CSE-MsgGUID: Wfsmuo8vTVOiLOphSlXHCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,208,1716274800"; 
   d="scan'208";a="49328505"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jul 2024 03:59:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 14 Jul 2024 03:59:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 14 Jul 2024 03:59:17 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 14 Jul 2024 03:59:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnmV6hEHeXhXGeidGCcf3pqPSfeziWxEvI19IlgsoeyIY7S17Vhlj2qZe1wkx0PGPfiDbeQpD4M5VN6P/bFD2golwdEgCDFw1w5VG7ko2XaO5jqQ8Jc9N41EBR7NScrqRaDsH/NKq5paIUfp1F8mq+1sgaCUfmvjew8wPIDZt/khJOzMyz1llWaHy3z90sZeBE/vm/XohMgAWKxJbhfMxWrpwztNrGgx2WppxavEH/34MF5BCmAsMPrSuXSfXxBX2wg65YG9TwX2jw6DtXpRUtviYQW+eGTt110b/czSkWzWJ1kqJHoPS59e2tFiizg1qolqamFxLfrlHcBQGv9W5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wclpg7Fee1hw0EtBeslDEhsC+Ev21jIlTTlaZ3RBkzA=;
 b=Tnc1YtUvZ4K/77uIaV6eNTX0VwlaD88bHVfhBRynlnc4Y/mRZ4277j58Rf9qZAhwMa0EAKPCqfaUOc0ckCSiklv+O0+G+oicy8pR5Cxtsn0ZtxdEh+lsY30wRmY/4WF6+OsAVZNSd49+ZW5EAK+rmVdYty9CN73rTRMRV2JA9XW58QbMuu3QwioQApkS/fW92Z0VM8Zt/t55LZjKkUNMoITuJpvlnvwa4GO7QE39RcVTNNUAntS/TzO4/wTcMvZ9Tuf5OZWWq5w5sSi5gymcFYPzYNCG6/MzmfrICvxRL5kS1PwyqhfaAbW7b6aTLUA+qpQtJ6JMKhBMa/znFzfYOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by SN7PR11MB6701.namprd11.prod.outlook.com (2603:10b6:806:26b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Sun, 14 Jul
 2024 10:59:14 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%6]) with mapi id 15.20.7762.025; Sun, 14 Jul 2024
 10:59:14 +0000
Date: Sun, 14 Jul 2024 18:59:04 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Lai Jiangshan <jiangshan.ljs@antgroup.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Tejun Heo <tj@kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [workqueue]  19af457573:
 WARNING:at_kernel/cpu.c:#lockdep_assert_cpus_held
Message-ID: <202407141846.665c0446-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0173.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::29) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|SN7PR11MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: f62156fe-2c44-433b-e8a7-08dca3f3ffae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?StH/LvCrT49HczuqFi1a/K85KO8E9oBA9Dy25+7TZY7SjrbrTBq4FfUtjwXh?=
 =?us-ascii?Q?klIQ8yOfEVqhC+8jJSHn2U1PSqe83RbyV2Gd7DFDWLfY4fSsqxqSrWsmwsjz?=
 =?us-ascii?Q?WjSK1u/3r2YsetBapIhOr1eXDgwm7hwAy5KvHOCrbQYRSUXakBl0qPz7eoOJ?=
 =?us-ascii?Q?QUIwJ5Tgo1CGLs4mo3jEY/tve5xsXWBrSHjo1yID3d67d0f7xwu9uVAkJwsq?=
 =?us-ascii?Q?VS5WRyD8YzuDAnUwrYMiy7lWVdIpI41xiQYUMOW5VRod6kUbQHwxua3AXMo/?=
 =?us-ascii?Q?dDQPmN3oTdIy1KS1PXc5N1xLTLy6pTxhUPsUVLU0Af4fNhYLF5V0cvJhFeLE?=
 =?us-ascii?Q?KnUEWWxCrpesPMXPtRKwbUB6vFrEHBW1AD35SpNhf9nzOB8KU7dMsG0313DJ?=
 =?us-ascii?Q?xXq2SJ/PFZKBenAwIRgM70pbX+jw7fDkrHRnKgjAqE5kLKYVFgU12l0Xs0uZ?=
 =?us-ascii?Q?DM91yomL9s+XhyIwsNLZrvMhv3NzkChwNiLxcEEbHDOOKd2DxAbJ+daspvPf?=
 =?us-ascii?Q?o+VwJpz8wwJ/Tifb6eEcC8atE/vtHtZowd2s75JRBrfsuf8WMyjo7TFO3XxT?=
 =?us-ascii?Q?cW2qysDm9T6t9MVWgmgGyt8Xqegvie+4JIbJzCiTM918MxaRGRA4GIxKOjgi?=
 =?us-ascii?Q?yvWDzDBje3sbIDeKVBo7TvBAOV/2Vgbxfun1E3L/NCpV/MZh7RFOZqAWNXjI?=
 =?us-ascii?Q?3ZIYG8mdyTWAzMzRLOkcXnI8uZGVQlr0aZ7LxHsHNrttguG5vydJQVmpvpOf?=
 =?us-ascii?Q?ye261HpIYDXlzhmXyIfwDbLRdTsBmP6D9LJOdKstM3UYnbbYW50Xn9OruqC1?=
 =?us-ascii?Q?VIvHcu2uXjVvxBvRZPbRzsQ8sQcTHid6ber8K7C7QsUUdCxJ218utwiDn16p?=
 =?us-ascii?Q?gBH4CTu8eyqNQhOjvXVy3DvCLQjCdFnvIcpy9aCsHQiMnHFKENAJKkpqE1at?=
 =?us-ascii?Q?+YFaqflM94lolwZlTfpBqZF5lSKcBsRIkOoSRYN0Qov7dxapMlezY8ZQ1Zua?=
 =?us-ascii?Q?yUMMc4yrBiqxgRNjwcXgbPxKlS3zrjIhK9/NjUGx6GE1BZL3b6iCOQ2TivRM?=
 =?us-ascii?Q?dzFqM09dQ90KNwCL9cjR9X8H/avPAq6CH7V8WeI+4+y5mH4NcF0ahb99MEn1?=
 =?us-ascii?Q?qnozy6tKbz3ni70Yf3by9jlm6/CrvqZ90Xi9ool/QgBy8sP98R6n3SSfXVld?=
 =?us-ascii?Q?S9j0U7Ig+b/fyqZennAkh/6wkO7RHht4m/mkTpbpfMHKM/jLmWWoK93RhQlS?=
 =?us-ascii?Q?9A4G87qnZ1crkY5Wbm0uC6t0PIwW2Jl3DvuuMK79PKonWg2qGKF8DB7+1jCb?=
 =?us-ascii?Q?ZI+uOMQjt2HtPdaiPoSVi1T6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U5GsvdLBrSFf2SsK8ZRItVFEb57rakBcHZWsr6wNk6PO1CjhPoYFJnRNKQTp?=
 =?us-ascii?Q?+/jtM8j8jWZZyOBocShPOwpoi359WQgZaX0jR5bnlKY/rpVw6KVm+Kjoj/TT?=
 =?us-ascii?Q?9bveqE2p7BbF7aCPIXgrfmft99wFG2ULuokDZgOE2M286ZAz0hxXPKd+uUoM?=
 =?us-ascii?Q?T7FoB0+NMUEzw+Pw83zYlNBjHHFNYhClKIq9+Izo2ruJd3kur7fPWED9w2wH?=
 =?us-ascii?Q?0vQ7t+NGK7KPdKZl2agkkCOok1FMnI3gLuStd45CfQBzCereWK2j8ePRauQk?=
 =?us-ascii?Q?HxuS8da+KSklcaBrseWRfDIr8G+TYB4c0PVKqWjkOHXRIZ26HbgyAkLyffn2?=
 =?us-ascii?Q?pmaW4VwGAvmjmh66pNWGQt6jQEyN2RUY1GaSaG64cxWBPuheKZAD+EJWjCYT?=
 =?us-ascii?Q?vsZR7T76K1ZrH4VpAO14mYc49U1m4do5SVAlYr24WR1QbLFfHEWDYBG3hSdY?=
 =?us-ascii?Q?+IF7gGuMt5DToBM1eG+E0xtz66XzlfxcdFN6b5zIuQig57+IHZ+AFLkAqo6/?=
 =?us-ascii?Q?e9m3XDbaPDwMDKE54VwASQI5lHDKCcwc8kUqMl/EnFpwFQDf6U/pX2wD7g3r?=
 =?us-ascii?Q?r5PIw+yvUI7ywVDk0zSicfADlBI5zPwJF6vYil4pK497GkoH1VftdpxSOvg/?=
 =?us-ascii?Q?jcoT7LRW2UqNJSzzS0UcXEHHbskPqBEFehbEaDInZ+lmjyDch234stU7HsIR?=
 =?us-ascii?Q?xEiTJdFD6oKITkSWMbDGKQBlGDXeS69Rn3rPDY2y6Mk9AAKwDa+kh4vjO50k?=
 =?us-ascii?Q?DYawqJKHawmZt/T2l0yM7mp3NzENdkI54072WEAK1uUCRgwqWxhM0Hl7v+9V?=
 =?us-ascii?Q?Q0g1Zl9yEVln1Cy+cXMKT7RhlgguN21Y4LNL7c1Lj/9iQDYJW9zJOlmf9nzY?=
 =?us-ascii?Q?eO0O3QCXo78UZ+C54VRQvHR3vzIRCf4NfE9M4WLzfWUal36kABTzXXReC1ic?=
 =?us-ascii?Q?Ik3UXWDswwr1u7U2MEAElO6SJNJyUjSEfd9RwVU8AVKv0w8o98hiLtbsthwm?=
 =?us-ascii?Q?nTS+CsknhHHchqnXxU3uDuGzpqi0jdjO47coVoUAWYnsgzmb5lVyjgmdY+p3?=
 =?us-ascii?Q?dO+JPearV/vbYyqNpVf42vBdxtlIufBp0IacpsBI1Qkpb79ddJfThcIES/qp?=
 =?us-ascii?Q?kLqRP4QzhXK4qJTK9mtSzzZ7rZ5EN1wRZeJvWs8uNLbPLreW+bJMFbukJP7T?=
 =?us-ascii?Q?byGZu/Yf5PVsClli8gCkAr9MwJex1cchFG2avUUUhqgzzLzjwX8bfJMG0X2B?=
 =?us-ascii?Q?CuE/IJfV6UbW+fDdRefVxLG/IkZrZ5Z9KLyr5MkyqoxwgnDvEKOwRmjUuFJo?=
 =?us-ascii?Q?Ujub3Y0bUdCZOpJFFysMON0uwBjbhme1MXFc2NSD29VAfjNjpodcK2enghy+?=
 =?us-ascii?Q?P6zKgJdlaglAqKCaC9zAof3c67hwDOoFEd5r029FNQ1IUBDBlz+1mvKQ0ZEa?=
 =?us-ascii?Q?iKBo1KiTkL/WZTFI6Brj1PomhJWZ1nv+JNTPyPkvkoTecNSDYhjcvcla08h0?=
 =?us-ascii?Q?nU5Ruz64MbZDiG+O73X4T4lB9KO61iEHlO2pIaGwqoysnOQIJsIgUHS6Q1X7?=
 =?us-ascii?Q?tRYqDsh9ATRe7IaWf3mH5ggvdIbZKFurQYy8adWDKkIOoO/+X22IMaYmNMn3?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f62156fe-2c44-433b-e8a7-08dca3f3ffae
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2024 10:59:14.7366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xQr3ESS0vsMcwdYZZMjPsWLXj3whVR8X1XLAtCjpTBOgsxtfl0UQkjl1lscG8ah9fQ3WnNIW/pva6uF8lKjRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6701
X-OriginatorOrg: intel.com


hi, Lai Jiangshan,

we noticed this commit is a fix for our report [1], and we really observed the
issue in [1] is fixed as below (a)

fbb3d4c15dc0fe8a 19af457573838785290d27dd09a
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     dmesg.EIP:lockdep_assert_cpus_held
           :6          100%           6:6     dmesg.WARNING:at_kernel/cpu.c:#lockdep_assert_cpus_held
          6:6         -100%            :6     dmesg.WARNING:possible_recursive_locking_detected   <---- (a)


however, now we noticed a WARNING:at_kernel/cpu.c:#lockdep_assert_cpus_held.
not sure if it could supply a hint for some other problems?


[1] http://lkml.kernel.org/r/202407081521.83b627c1-lkp@intel.com


Hello,

kernel test robot noticed "WARNING:at_kernel/cpu.c:#lockdep_assert_cpus_held" on:

commit: 19af457573838785290d27dd09a59140f541d1d8 ("workqueue: Remove cpus_read_lock() from apply_wqattrs_lock()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 3fe121b622825ff8cc995a1e6b026181c48188db]

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: default
	torture_type: trivial



compiler: clang-18
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407141846.665c0446-lkp@intel.com


[   15.726567][  T131] ------------[ cut here ]------------
[ 15.728117][ T131] WARNING: CPU: 1 PID: 131 at kernel/cpu.c:525 lockdep_assert_cpus_held (kernel/cpu.c:525) 
[   15.731191][  T131] Modules linked in: floppy(+) parport_pc(+) parport qemu_fw_cfg rtc_cmos
[   15.733423][  T131] CPU: 1 PID: 131 Comm: systemd-udevd Tainted: G                T  6.10.0-rc2-00254-g19af45757383 #1 df6f039f42e8818bf9a534449362ebad1aad32e2
[   15.737011][  T131] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 15.739760][ T131] EIP: lockdep_assert_cpus_held (kernel/cpu.c:525) 
[ 15.741326][ T131] Code: 97 c2 03 72 20 83 3d f4 73 97 c2 00 74 17 55 89 e5 b8 fc bd 4d c2 ba ff ff ff ff e8 e4 57 d1 00 85 c0 74 06 5d 31 c0 31 d2 c3 <0f> 0b eb f6 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 89 e5 b8
All code
========
   0:	97                   	xchg   %eax,%edi
   1:	c2 03 72             	ret    $0x7203
   4:	20 83 3d f4 73 97    	and    %al,-0x688c0bc3(%rbx)
   a:	c2 00 74             	ret    $0x7400
   d:	17                   	(bad)
   e:	55                   	push   %rbp
   f:	89 e5                	mov    %esp,%ebp
  11:	b8 fc bd 4d c2       	mov    $0xc24dbdfc,%eax
  16:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  1b:	e8 e4 57 d1 00       	call   0xd15804
  20:	85 c0                	test   %eax,%eax
  22:	74 06                	je     0x2a
  24:	5d                   	pop    %rbp
  25:	31 c0                	xor    %eax,%eax
  27:	31 d2                	xor    %edx,%edx
  29:	c3                   	ret
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	eb f6                	jmp    0x24
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	55                   	push   %rbp
  3d:	89 e5                	mov    %esp,%ebp
  3f:	b8                   	.byte 0xb8

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	eb f6                	jmp    0xfffffffffffffffa
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	55                   	push   %rbp
  13:	89 e5                	mov    %esp,%ebp
  15:	b8                   	.byte 0xb8
[   15.745390][  T131] EAX: 00000000 EBX: c376d200 ECX: 00000000 EDX: 00000000
[   15.746576][  T131] ESI: c4de9180 EDI: 00020002 EBP: ecf3bb10 ESP: ecf3bb10
[   15.747773][  T131] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210246
[   15.749161][  T131] CR0: 80050033 CR2: 00a9c93c CR3: 2cf6c000 CR4: 00040690
[   15.750384][  T131] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   15.751570][  T131] DR6: fffe0ff0 DR7: 00000400
[   15.752427][  T131] Call Trace:
[ 15.753063][ T131] ? show_regs (arch/x86/kernel/dumpstack.c:478) 
[ 15.753830][ T131] ? lockdep_assert_cpus_held (kernel/cpu.c:525) 
[ 15.754779][ T131] ? __warn (kernel/panic.c:239 kernel/panic.c:693) 
[ 15.755533][ T131] ? lockdep_assert_cpus_held (kernel/cpu.c:525) 
[ 15.756503][ T131] ? lockdep_assert_cpus_held (kernel/cpu.c:525) 
[ 15.757508][ T131] ? report_bug (lib/bug.c:199) 
[ 15.758300][ T131] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 15.759113][ T131] ? handle_bug (arch/x86/kernel/traps.c:?) 
[ 15.763110][ T131] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
[ 15.763989][ T131] ? handle_exception (arch/x86/entry/entry_32.S:1047) 
[ 15.764913][ T131] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 15.765754][ T131] ? lockdep_assert_cpus_held (kernel/cpu.c:525) 
[ 15.766706][ T131] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 15.767516][ T131] ? lockdep_assert_cpus_held (kernel/cpu.c:525) 
[ 15.768498][ T131] alloc_workqueue (kernel/workqueue.c:5430) 
[ 15.769398][ T131] do_floppy_init (??:?) floppy
[ 15.770976][ T131] init_module (??:?) floppy
[ 15.772499][ T131] do_one_initcall (init/main.c:1267) 
[   15.773357][  T131]  ? 0xef561000
[ 15.774006][ T131] ? lock_acquire (kernel/locking/lockdep.c:5754) 
[ 15.774790][ T131] ? kill_kprobe (include/linux/rcupdate.h:328) 
[ 15.775617][ T131] ? try_to_wake_up (kernel/sched/core.c:2255) 
[ 15.776509][ T131] ? radix_tree_iter_tag_clear (lib/radix-tree.c:1063) 
[ 15.777501][ T131] ? rcu_lock_acquire (include/linux/rcupdate.h:338) 
[ 15.778326][ T131] ? rcu_lock_release (include/linux/rcupdate.h:340) 
[ 15.779215][ T131] ? __lock_acquire (kernel/locking/lockdep.c:4599) 
[ 15.780074][ T131] ? __kernel_text_address (kernel/extable.c:79) 
[ 15.781064][ T131] ? stack_trace_snprint (kernel/stacktrace.c:?) 
[ 15.781969][ T131] ? stack_depot_save_flags (lib/stackdepot.c:609) 
[ 15.782876][ T131] ? stack_trace_save (kernel/stacktrace.c:122) 
[ 15.783739][ T131] ? lock_acquire (kernel/locking/lockdep.c:5754) 
[ 15.784548][ T131] ? kmalloc_trace_noprof (include/linux/sched/mm.h:335 mm/slub.c:3890 mm/slub.c:3980 mm/slub.c:4147) 
[ 15.785452][ T131] ? __might_sleep (kernel/sched/core.c:10126) 
[ 15.786219][ T131] ? kmalloc_trace_noprof (include/trace/events/kmem.h:54) 
[ 15.787105][ T131] ? do_init_module (kernel/module/main.c:2530) 
[ 15.787949][ T131] do_init_module (kernel/module/main.c:2541) 
[ 15.789008][ T131] load_module (kernel/module/main.c:3006) 
[ 15.790187][ T131] __ia32_sys_finit_module (kernel/module/main.c:3173 kernel/module/main.c:3191 kernel/module/main.c:3211 kernel/module/main.c:3194 kernel/module/main.c:3194) 
[ 15.791578][ T131] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20240712/./arch/x86/include/generated/asm/syscalls_32.h:?) 
[ 15.792834][ T131] do_int80_syscall_32 (arch/x86/entry/common.c:?) 
[ 15.794066][ T131] ? exc_page_fault (arch/x86/mm/fault.c:1543) 
[ 15.795255][ T131] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[   15.796583][  T131] EIP: 0xb7f60092
[ 15.797596][ T131] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240714/202407141846.665c0446-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


