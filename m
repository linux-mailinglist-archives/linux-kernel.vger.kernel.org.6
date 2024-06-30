Return-Path: <linux-kernel+bounces-235160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BD191D0E1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 11:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 564B2B212B6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 09:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FE612E1F1;
	Sun, 30 Jun 2024 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WydbFXFl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9798D374CC
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719740517; cv=fail; b=HMvq8FeAY9BW3ymlM5DAEkTZ5j9lymGsnY4vdup6bzDMhJWHUe8awBsegHV5vXeQG8DpBHlJfykLoBSRMRHpuI926J7Wt/L+gNQCwvg/lMfJLYUnU4pwHPEg4VsOVgXax8A3sbBYFdnSTPPtlLsEd74aZF/2dQRqZCmuGrPIeIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719740517; c=relaxed/simple;
	bh=kpJn2xVuQhrj0Ist34/3SBXbbZNdTI/xPC/0Tq5L6ew=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=nYw+NSHZLZvMym0MlKRC7GRfdSuNaDUxj7mxwzYu30MdagmEVoQS/f8NyfNoNQMU+u9TT+a0qqzMGB07bKUvIv/e3XRFnENxwzuFcSpYxIhTgqKAJrWzMx3MVo8zKOSr2RoZRuQsKadomcscQCzZmNdm+7/cvSGbxMPGXkuPk3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WydbFXFl; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719740514; x=1751276514;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kpJn2xVuQhrj0Ist34/3SBXbbZNdTI/xPC/0Tq5L6ew=;
  b=WydbFXFlwlIsPAIA06WH0Wnv5K43u9tndRw9Zqa2TWNn/2t2DxtgO1Qa
   jwB57rSresJ1bS7BuVDYKE6XpR7b1oFI1yWb8IeJNqsc2B7rnJkKlZsmg
   6h8ci06fuzDf6ITP5H4matjVQoeGKR/z9rppp+7XWoaTKCbuWsibVh6os
   3eGJKHzqVlSAP1aaSt006Q4le2a2z5Go5B7Wspbpggx7Zzp57JoJFFN90
   NcJNXMce7jN461r3cia9iGXYjX8fTAGQ67u+yvdWMdSAjIyGlaLxbFvef
   r/Aug6X+HMUCcMq888ztiBLlKUrxTGSIvtGwgzPAofyWl+21njC1F+Vql
   Q==;
X-CSE-ConnectionGUID: ZXiIQ7AvS2+P1sKoNGN0Qw==
X-CSE-MsgGUID: Y1NW1i7JQti07seEVSRREw==
X-IronPort-AV: E=McAfee;i="6700,10204,11118"; a="28000941"
X-IronPort-AV: E=Sophos;i="6.09,173,1716274800"; 
   d="scan'208";a="28000941"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 02:41:53 -0700
X-CSE-ConnectionGUID: PJGPi0OqQh27/IK7nG7pjQ==
X-CSE-MsgGUID: PNwykcfURYGR09vPw8fCOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,173,1716274800"; 
   d="scan'208";a="45617480"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jun 2024 02:41:53 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 30 Jun 2024 02:41:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 30 Jun 2024 02:41:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 30 Jun 2024 02:41:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXTzowJC71xeWkNZWW4fK61MPS7UbmTjbrlDivrHc98UdLbfirpqQIJ/HjCWCe2D5oArM7boFIX2u1KBaaBy7mh9Q/fpvvK46UJxu9N7B3JTzTfCshLX+sxwYrc5S/mPgr1vJ4V2h9NRTHZHk2yk2y/3toYnlIaELNqcjgqTK70nBzLnT6H7guS6xmtakJxokyrKGnPRr1oDEBtfTGmfV6qunvQtthJ7W3mHw/V4gSrQYi9h25D+neOcQinoveIC0i+UfBsgTQ07y0seOJjn95o1l1kX8vE2WAjjQyNoZv7QFHHqvUqnaBCKU3m29di9IMKoCujjS5Xu0FvW/mo0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWjtzmOBQYBFwMHtTs9Hy/QzRe6g3TGX3Ka8YXLLGIE=;
 b=E22GrhS3ku1e1X6wNMKhXY2dnjy42/zyT3BuRCRpzC6mj2uF2HOie+2sNrgLhqPlic71RCo5UTvtKlu/dz+P2HQVZzAw48Ge+a38TDiJJUM1nli+701gCo05Y9sU6unvILcYJiclNu5FClMFm9t14HsRhGoqqu3x+W+uE6y/I1B9Tb8EOMk6TBMQd7uwjWvUVfE76+JjrMCqEm0jRZulIW/Nz5/GpbFTMG/bT/Krz4cJXdZwUA9ubjDqvCAoVLXpNUjl1Kb1nO7bKydctzNMQMmLLSnHLdEsbqaZXSOaPAKVxUKY4PzfeiP29THg7wnq9HNcLMQs9K7C5R2b6Yiw7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB6915.namprd11.prod.outlook.com (2603:10b6:930:59::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Sun, 30 Jun
 2024 09:41:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 09:41:49 +0000
Date: Sun, 30 Jun 2024 17:41:36 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ingo Molnar <mingo@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski
	<luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Fenghua Yu
	<fenghua.yu@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
	<oliver.sang@intel.com>
Subject: [tip:WIP.x86/fpu] [x86/fpu]  8073335229:
 WARNING:at_mm/vmalloc.c:#remove_vm_area
Message-ID: <202406281539.7f1bd833-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: fa15364e-361e-47dc-7dd6-08dc98e8dd06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vhdgH/vKKyDkSOCsk5N/61QNkLkTiayMkgCaLFR2Cle5wfUPkvVQRQk7JJBr?=
 =?us-ascii?Q?FD9pYa9ID3kSES7WTc21fCVPvbX91fFDZ8B3CTyfOKZ27UWgCP7MGcQ4nO3C?=
 =?us-ascii?Q?Jwt3GPMKk/3MadYbNMG/9kqfWahABhDN82P4djqD9A0pHkOPF8L3MH48D4kI?=
 =?us-ascii?Q?K1BH1KF1Gi/y6reDIWH+ZD+lhrVV92q7BNoBduEseAgI7WmrlEm5dx9ej9zm?=
 =?us-ascii?Q?K16saYFtZbBSJDDRMizmQCBJwRW4aHLI7OPXAj1IbTvFkAm7MwkTItB7J2nu?=
 =?us-ascii?Q?d0AXvS3Q7P8gH0fpBFy/SBwOFJq+bgM5z6wowCdxl+FxMZ9iyHZu8EvGEn6v?=
 =?us-ascii?Q?FA/emq58nd6iht9NkROVGtLWuXLQyFPaelDtWubhMnC7VBex2ivsp7Etr9X4?=
 =?us-ascii?Q?LVkH/NR3zBHykV60ztnzb5T1QxWdyH3ifA6lkvKYazaY0O7Td99HlhEDT0mK?=
 =?us-ascii?Q?dXlHzc/uH+JZbUbM2DSedSNltiBXRYO2eYh67VJgCKrS6ZTBcagp8yRD2f0z?=
 =?us-ascii?Q?B4rqWb7Hw+zWLCr/Ro/o+As5Y+z/LgF5Sca1kSt2iqAQUQiHqpU4ltHBy+Wn?=
 =?us-ascii?Q?cP7yyP1DSnkqMPIyNsB53qWf8vgd8lVeYpb0ArpDOSMNq6+2MD/7zjG93W+v?=
 =?us-ascii?Q?yWVwHIkAk+LZt79bsZ5RoiArcTRmQx0XwqEuTfV0sDqVfLDuP28Cqgx0n+eV?=
 =?us-ascii?Q?oGFcfHLhVj6eMOn2csqSVYfaSkfs6UhExBDT0aAgEUFQ+oe0Rf1e6rhhmok5?=
 =?us-ascii?Q?2Qvrd+i4NxMaWtOoP6zgn9OBQIt7lAqFB8gH7Fu1xgFo6sEjPlk3v0S5mElt?=
 =?us-ascii?Q?d9BlrvBADeJ6jnqLNJBbCN+77jomUOfd2WL5qv5KsXjaJSqYGsHfVLsRybCr?=
 =?us-ascii?Q?isV3RL9HVTHOt7CqfZb1jDvk8vve8nL0lO/lnPKuGcJ+V+Os+JByur9ugaLu?=
 =?us-ascii?Q?GgxacjAzeUgJrw1Ct4992Cf60Sg/wG3k6akZXVhCqyLeUi2H3F42bJSLgi3I?=
 =?us-ascii?Q?Svklsdx7EVAf8JO3tNIwIzxYTlc82yiXCYTtQ0eEU9T22vHSi9k2Alzwgh07?=
 =?us-ascii?Q?9aIU8Ynl+Tjq54myziWhMJKtY92yLKF0mUgjCnKkq9u9o0wK3T5iKxCbchpp?=
 =?us-ascii?Q?KV8ck2N5LBt54GGzfIHG7Ze+0cbk75iu1bC5a93FCCa7YlYZejctryD5yI98?=
 =?us-ascii?Q?uxhcK6dQvm1NCYTd2dwdsorveceYHJORJZkhSHTpjRsD/Cpz46Hs21goImUK?=
 =?us-ascii?Q?/JVP7rfvyCV0RNY/Brz5JCipAi5XJamTG++OyNJuvr7DgCo1A7Qf3NpB85xx?=
 =?us-ascii?Q?Q5g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RUeM9+u3S6tYp5q/SVgrdJ5dXCifbGRCphuDUInWphjp0qw5GQXDHjWhMmAt?=
 =?us-ascii?Q?pzqgyHqEl3F5E9kz43JDxyim7DbYnVQw01uL1P1nFrhSAF255mtE/5rYK8ID?=
 =?us-ascii?Q?H0gmeMUzk1OYo3TvfCiM0K36BkXhtTwTcwVtc9tUt/E2vqNHg6B2fO5s+NYr?=
 =?us-ascii?Q?qFTM1Zv9pC6AFJRMGnN9cAwMkai6hxqVw+pFrUT840JRHPlTedflx+Wu6u64?=
 =?us-ascii?Q?4G/FWQfHHt52dBFi0zxAgd/VBLGMdEp1cPSEnA4Flrm+Z8aL2ckCl3C75mTa?=
 =?us-ascii?Q?mdo0HTwLJRBodtnslw2dpAzJOk2atOLFgcu7RGBKCAQtP/AaFOk5zQFFP3fw?=
 =?us-ascii?Q?7y6gxgq5gK/bj86eN360d43HliKj6s5YNlyHLvWIN3QL0Up8rDUPx/55NlmZ?=
 =?us-ascii?Q?Dh4nr3IwMG9BzYPg9eY/XMAYmbfsWB0hS4Nxq6qDnbWNaM0q5gsGm/0r8KIU?=
 =?us-ascii?Q?6w2X8uuM+Mbqwe2gXRD1JcmNVA6kytqvJR4BPIy0eLmdrLxiZqt0nhX1gOLB?=
 =?us-ascii?Q?RQIU/ZEgi0/ydk8OZ0E4AqB+saMq2FYH/UdcsBppu47AFBLit5VEcZYvSxOG?=
 =?us-ascii?Q?WEDAOYjePoCKxSYbxCsATcPT0Pbjg/4odSXf6obqMfcoXcqZOmYyt449fssd?=
 =?us-ascii?Q?KKvxlq1rY4k8IRnHbD7ue2o2tIu6zYNMo2+0Dx92cfLfgPkdmzfBgCeXoh22?=
 =?us-ascii?Q?aSQrdwvtk3/iIEbA8KrCYdN+gMzY1Lr0PALsGVWp5Su6kfrPuguKNUzgfWj6?=
 =?us-ascii?Q?Em5lCRQzkBQqBA7LO1LPi5WiVDrWPMOPPr5CW3sE3R+2pOmU9cr4F5nU1j3G?=
 =?us-ascii?Q?NcDyvjz7FgixjRh/aYs8Mh4SkFjri8SziO807LhqgDY5p4l7/OoqRMgsRADS?=
 =?us-ascii?Q?8+WxRXROlWDnUIolYsBSHdk183D8gsAUEJq5SEFhSO9D9f1wEdShSpX7XJZX?=
 =?us-ascii?Q?BmsdKAw7KfjT06qwxH56YSXGPgOelasEsdeU4UYQaHeSEvu7Aud6U1r7pWu5?=
 =?us-ascii?Q?tXuGPmwVojwwX1ylX7ThXIytEgMRHP34eRfFpl7mVjNsgDLpdDCLqfCvGzGE?=
 =?us-ascii?Q?2wFkz2WbmeAUT0wc8BkJR7axZs9KYYMUcqQfscMijn4ATwc9/lm6AApHhKDd?=
 =?us-ascii?Q?gpoEBp10+VlUkqfqMYMnzzrwy+MO5j60xwzZjWw8zJnXMexHjsegcwb/kKKg?=
 =?us-ascii?Q?s+7A5XxC0JOMD+KUTh3HbS2Le4+sGVtNYZDaLtHwWyYr7ZFY+PzfdtbJShqr?=
 =?us-ascii?Q?p+dUI/AvCon5vMuarJHEJHCytkwdUXqkOykh8+K3MQVj/w2f5ojy5vOD9Nyh?=
 =?us-ascii?Q?7QmofdV+CugBTEh0MYuPzxW0VT4/DP4RLe0SXSRqqv7YRNP/uKZZxIGUAouj?=
 =?us-ascii?Q?xM4/U4FHp1RFtAcyNMVY/JthU6wRacKOOOJVTs7A9HHrBe0V+u1s01crS8Dj?=
 =?us-ascii?Q?7nEVVuJRTOwPADKTvHdBqnjFUr3LeeNME+XhLlaI1zdg/L+2rrxdxSPAETuY?=
 =?us-ascii?Q?RhWr8Fi8EOQddhdW4vZcC94kTrOpNV3EMBv/Uw9IPrtx0fU5KYj6jlQoQROA?=
 =?us-ascii?Q?Xio4oke9C9ToucnAdUezEmEIafWNbZvmCrUAdEsViH8NzvHmWcsM84eaht5z?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa15364e-361e-47dc-7dd6-08dc98e8dd06
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 09:41:48.9308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itZo6QdSMxnzdRa9+D8yV0r7uvlE1DOstXFChyipBYhxgPghkn2Jhab0BleHlabM3GSmnSsYvh+JWWs1DKW5gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6915
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_mm/vmalloc.c:#remove_vm_area" on:

commit: 80733352295340ab492002bd023ea8a1db8025f5 ("x86/fpu: Remove the thread::fpu pointer")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git WIP.x86/fpu

[test failed on linux-next/master 62c97045b8f720c2eac807a5f38e26c9ed512371]

in testcase: stress-ng
version: stress-ng-x86_64-ecd3fe291-1_20240612
with following parameters:

	nr_threads: 100%
	testtime: 60s
	test: sysfs
	cpufreq_governor: performance



compiler: gcc-13
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406281539.7f1bd833-oliver.sang@intel.com


kern  :warn  : [  109.805527] ------------[ cut here ]------------
kern  :warn  : [  109.812194] Trying to vfree() bad address (00000000132062a9)
kern :warn : [  109.819933] WARNING: CPU: 84 PID: 1612 at mm/vmalloc.c:3195 remove_vm_area (mm/vmalloc.c:3195 (discriminator 1)) 
kern  :warn  : [  109.829916] Modules linked in: intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel btrfs kvm crct10dif_pclmul crc32_pclmul blake2b_generic ghash_clmulni_intel sd_mod sg sha512_ssse3 xor raid6_pq libcrc32c crc32c_intel rapl nvme nvme_core t10_pi intel_cstate ahci ast libahci ipmi_ssif mei_me i2c_i801 crc64_rocksoft_generic drm_shmem_helper crc64_rocksoft dax_hmem acpi_power_meter drm_kms_helper libata megaraid_sas mei wmi i2c_ismt crc64 i2c_smbus ipmi_si acpi_ipmi ipmi_devintf binfmt_misc ipmi_msghandler acpi_pad drm fuse loop dm_mod ip_tables
user  :notice: [  109.859859] stress-ng: metrc: [6575] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
kern  :warn  : [  109.888492] CPU: 84 PID: 1612 Comm: kworker/84:1 Not tainted 6.10.0-rc3-00004-g807333522953 #1

kern  :warn  : [  109.905370] Workqueue: events delayed_vfree_work
user  :notice: [  109.918106] stress-ng: metrc: [6575]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)

kern :warn : [  109.918484] RIP: 0010:remove_vm_area (mm/vmalloc.c:3195 (discriminator 1)) 

user  :notice: [  109.926459] stress-ng: metrc: [6575] sysfs            160196     60.00    120.35  12186.65      2669.78          13.02        91.56          1852
kern :warn : [ 109.940064] Code: 48 8b 70 08 e8 40 f2 ff ff 48 89 df e8 f8 ae ff ff 48 89 e8 5b 5d c3 cc cc cc cc 48 89 de 48 c7 c7 48 2c 99 82 e8 1f 74 d1 ff <0f> 0b 31 ed 5b 48 89 e8 5d c3 cc cc cc cc 90 90 90 90 90 90 90 90
All code
========
   0:	48 8b 70 08          	mov    0x8(%rax),%rsi
   4:	e8 40 f2 ff ff       	callq  0xfffffffffffff249
   9:	48 89 df             	mov    %rbx,%rdi
   c:	e8 f8 ae ff ff       	callq  0xffffffffffffaf09
  11:	48 89 e8             	mov    %rbp,%rax
  14:	5b                   	pop    %rbx
  15:	5d                   	pop    %rbp
  16:	c3                   	retq   
  17:	cc                   	int3   
  18:	cc                   	int3   
  19:	cc                   	int3   
  1a:	cc                   	int3   
  1b:	48 89 de             	mov    %rbx,%rsi
  1e:	48 c7 c7 48 2c 99 82 	mov    $0xffffffff82992c48,%rdi
  25:	e8 1f 74 d1 ff       	callq  0xffffffffffd17449
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	31 ed                	xor    %ebp,%ebp
  2e:	5b                   	pop    %rbx
  2f:	48 89 e8             	mov    %rbp,%rax
  32:	5d                   	pop    %rbp
  33:	c3                   	retq   
  34:	cc                   	int3   
  35:	cc                   	int3   
  36:	cc                   	int3   
  37:	cc                   	int3   
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	31 ed                	xor    %ebp,%ebp
   4:	5b                   	pop    %rbx
   5:	48 89 e8             	mov    %rbp,%rax
   8:	5d                   	pop    %rbp
   9:	c3                   	retq   
   a:	cc                   	int3   
   b:	cc                   	int3   
   c:	cc                   	int3   
   d:	cc                   	int3   
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop

user  :notice: [  109.943272] stress-ng: metrc: [6575] miscellaneous metrics:
kern  :warn  : [  109.948465] RSP: 0018:ffa00000118a7e20 EFLAGS: 00010286
kern  :warn  : [  109.948468] RAX: 0000000000000000 RBX: ff1100406ccdd340 RCX: 0000000000000000

user  :notice: [  109.952683] stress-ng: metrc: [6575] sysfs                188.37 sysfs files exercised per sec (harmonic mean of 224 instances)
kern  :warn  : [  109.966542] RDX: ff11003fc1a2e2c0 RSI: ff11003fc1a20b00 RDI: ff11003fc1a20b00

kern  :warn  : [  109.991046] RBP: ff1100406ccdd340 R08: 0000000000000000 R09: 0000000000000003
kern  :warn  : [  109.991048] R10: ffa00000118a7cb8 R11: ff1100407fcb7fe8 R12: ff1100208000fe00
kern  :warn  : [  109.991048] R13: ff11003fc1a33b00 R14: ff1100208000fe05 R15: ff110001000408c0
kern  :warn  : [  109.991049] FS:  0000000000000000(0000) GS:ff11003fc1a00000(0000) knlGS:0000000000000000
user  :notice: [  109.998850] stress-ng: info:  [6575] for a 60.09s run time:
kern  :warn  : [  110.004913] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

user  :notice: [  110.014575] stress-ng: info:  [6575]   13460.96s available CPU time
kern  :warn  : [  110.016332] CR2: 000055666f401650 CR3: 000000407de9a006 CR4: 0000000000f71ef0

user  :notice: [  110.030915] stress-ng: info:  [6575]     120.35s user time   (  0.89%)
kern  :warn  : [  110.038976] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000

user  :notice: [  110.042309] stress-ng: info:  [6575]   12186.82s system time ( 90.53%)
kern  :warn  : [  110.050427] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
kern  :warn  : [  110.050429] PKRU: 55555554
kern  :warn  : [  110.050430] Call Trace:
kern  :warn  : [  110.050432]  <TASK>

user  :notice: [  110.060100] stress-ng: info:  [6575]   12307.17s total time  ( 91.43%)
kern :warn : [  110.068193] ? __warn (kernel/panic.c:693) 

user  :notice: [  110.078927] stress-ng: info:  [6575] load average: 476.09 137.10 47.15
kern :warn : [  110.085280] ? remove_vm_area (mm/vmalloc.c:3195 (discriminator 1)) 

kern :warn : [  110.095131] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
user  :notice: [  110.103514] stress-ng: info:  [6575] skipped: 0
kern :warn : [  110.111930] ? handle_bug (arch/x86/kernel/traps.c:239) 

user  :notice: [  110.115126] stress-ng: info:  [6575] passed: 224: sysfs (224)
kern :warn : [  110.122694] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
kern :warn : [  110.122697] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 

user  :notice: [  110.132072] stress-ng: info:  [6575] failed: 0
kern :warn : [  110.134144] ? remove_vm_area (mm/vmalloc.c:3195 (discriminator 1)) 
kern :warn : [  110.134147] vfree (mm/vmalloc.c:3316 (discriminator 2)) 

user  :notice: [  110.143001] stress-ng: info:  [6575] metrics untrustworthy: 0
kern :warn : [  110.151243] delayed_vfree_work (mm/vmalloc.c:3266 (discriminator 1)) 
kern :warn : [  110.151246] process_one_work (kernel/workqueue.c:3231) 

user  :notice: [  110.156131] stress-ng: info:  [6575] successful run completed in 1 min, 0.09 secs
kern :warn : [  110.158797] worker_thread (kernel/workqueue.c:3306 (discriminator 2) kernel/workqueue.c:3393 (discriminator 2)) 

user  :notice: [  110.221173] /usr/bin/wget -q --timeout=3600 --tries=1 --local-encoding=UTF-8 http://10.239.97.5:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-spr-r02/stress-ng-performance-100%25-sysfs-60s-debian-12-x86_64-20240206.cgz-807333522953-20240625-54609-1oto9j9-13.yaml&job_state=post_run -O /dev/null
kern :warn : [  110.226000] ? __pfx_worker_thread (kernel/workqueue.c:3339) 

kern :warn : [  110.359162] ? __pfx_worker_thread (kernel/workqueue.c:3339) 
kern :warn : [  110.365216] kthread (kernel/kthread.c:389) 
kern :warn : [  110.369910] ? __pfx_kthread (kernel/kthread.c:342) 
kern :warn : [  110.375424] ret_from_fork (arch/x86/kernel/process.c:145) 
kern :warn : [  110.380820] ? __pfx_kthread (kernel/kthread.c:342) 
kern :warn : [  110.386304] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
kern  :warn  : [  110.391956]  </TASK>
kern  :warn  : [  110.395774] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240628/202406281539.7f1bd833-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


