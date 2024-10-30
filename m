Return-Path: <linux-kernel+bounces-388165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FA39B5B77
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E80282BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4901D0BA5;
	Wed, 30 Oct 2024 05:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNGMUrIS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649721991DB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 05:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730267299; cv=fail; b=ZYW5Yi6Wr7wSq/bSp6lyuC475Y/IaFN8Ch3H4Cl/ycoORlj0KBdubEPnRhRwwscLkkEudNLBorp0T1b22Z6Cx1F5UUbEY4yMh0l0OKY65DOLUaVGmIfvrM4tN0h7B6dyoxFqjF1O3GNxiLk2F2qlO4UBfu8+t0px2ymzyfPe/Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730267299; c=relaxed/simple;
	bh=+yew7Rny07CZ32gPvn8l2QWh8OYG5Aw4k+rzQUwUSws=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ioQzk7D7Cg+NgFiWd/pA/RALwJQ99btK3W9DwFKSCDL2jHcvVj0uV809DNdICSlbcLDTWSwgzzb4G5GCEjeu9uPnB1Jp2XxdG6H1N0chsnyMhPZmFvSQ5DwlCcw33hTft9YQyUmPTefvDbtweINWOM9sd0F5hKuC78yCCr4P6TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNGMUrIS; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730267296; x=1761803296;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+yew7Rny07CZ32gPvn8l2QWh8OYG5Aw4k+rzQUwUSws=;
  b=lNGMUrIS1dw3C6q05vEC1jmpzdTuXFX0q2Eno6MsJZzMIpqqghnJ2e8f
   T43vTmNLovh+OBtlJ0GtcpzX6yaaFZ07vRONGUsyGI4PBgs1rbBgpkqO6
   edrtSU+idh+YlJqycqJu+BmYbGIEyFTYQdfYUbYAhs7GICnqclZeaR6WK
   jzrFhF9LuugMJh4D8xcnscIpYNYgHy60zZkeAJxV6W2IdVU45EStEC0F+
   pBciRf+suf3stu9iPHB10nGoUzH6AYB3drDBzAqNPNC1CW/pjvkSiyovk
   f3/0EOxpVLYIr+K0PVFGrgV6caC94ZhRLoUY/nKYZjz66i7v5uE40luRm
   Q==;
X-CSE-ConnectionGUID: ZytDVS8rR4OU6WqDJRN0tQ==
X-CSE-MsgGUID: /lhAiBAgRCaG2vHXrf3q7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29371442"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="29371442"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 22:48:06 -0700
X-CSE-ConnectionGUID: 0pi6QozETKSqmEkeVBeScA==
X-CSE-MsgGUID: ZG2vcbmrTFCGuC2FlPpH2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="82117355"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 22:48:06 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 22:48:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 22:48:06 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 22:48:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysu2/7Lffdb17lGEfprjxx/qjuebCRJcXLxYz0TGN9nwfSMmpFYAF1BON0RiUgPI5DRFlYBOuqJIL9ovWGkZbr4acErorqE63Yh3djX0Qr+fYww5y4xw811PGZMrKWUV4z/HUUI+BDYNbSYACEzHWbePKEqz9y7Cu8P99m4mVPB6hVuhqw2XGhfkuCrVrLacOThMgR0M/sVAHAnfP42GKoJpXXr/4qqhZ4G7NIeFVPPcjtg1QlhCZDLn6vuiSI98SM5XqrLMT6+PFdp+mgqfVElDGLogR5llK0Bu/jLb8VAI1VmnWWun3Bc1I0Q+KabN/a5hMeB+vzgtgxTs9Rog8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfNkjXpx57XXQDPn4DBoMMSkGQpZhGlmEsqFo0hgDME=;
 b=Gycn2Xrda+/MvaxtMwt6ZV6JNvBG+Jq/GbhmE8/q4Fkdib9dzBeKiTsSsamWR7+BuYDUKekeqESEE6qxPuMlzjzZsnHIXyFZLMmMVHSkk4QmMA6posReZfSCr4K087Lsu7b2WIV4fz01XYVupLC3oYnv3Zt1NFF0S1IkiLPTID472Z4OACASpz6bDD/SPVxU72kblfIW38Vm5vfUUG4BXbS8PhqgoYTwM+xBbuGeLCMLZaiOpSW1rfn+uTWAFeEX0j9Tfq0zbSX+ILN5rs8BFeoCLaPqoZ62WJN+DmN8CWBEAYvyi1OQnL33t1yqh1z1UFYHuvPwk0j4EPR3XpprXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 05:47:54 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.025; Wed, 30 Oct 2024
 05:47:54 +0000
Date: Wed, 30 Oct 2024 13:47:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, John Stultz
	<jstultz@google.com>, <oliver.sang@intel.com>
Subject: [tip:timers/core] [timekeeping]  5aa6c43eca:
 BUG:KCSAN:data-race_in_timekeeping_debug_get_ns/timekeeping_update_from_shadow
Message-ID: <202410301316.e51421de-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ffa76f-a152-4e94-1f01-08dcf8a6663b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vDXEFkvGiGoZxq/elbwqKXsYK4ni3VPZYSRTQBqivJ1gVxIIeefgN0VIWRLA?=
 =?us-ascii?Q?9MjI/rg8H7K5cza4jwzJXjGKdsplV7oBXpjxKZo8ykRp9c4xw2WwsEscs9Ef?=
 =?us-ascii?Q?Lu7Tnyc04ojn6D5bVZ9wQeqZTEvaeQTf/yJLraJFzY3E+XdO2gqabSW+vwGo?=
 =?us-ascii?Q?Ck9VsdnnYh7Qw1ZAazIkfCs8MpZuPjjERJpqYhpxIF5KzOsRhwmL9WMQngeJ?=
 =?us-ascii?Q?+wNKu6FFWhzRQjX0izYVoEHEqpRQS3tnwn6aZ2ys4cdDjOwqI86zD59RSirm?=
 =?us-ascii?Q?7GDyt/ReDpVg58gZSeNMConWx1EvcNyCF7RiAUcV5BfIW0W85RVYzjL8OeWy?=
 =?us-ascii?Q?gE+2+mT6ZMRErYYdHDHnoi/9hirvX1TUc6HeqMU3BsSsvPgGGvg0B4d3s6iO?=
 =?us-ascii?Q?gFWuFloW0hvJELwe/O1nq/bRm6r8XAH5dlV74cykzwjd5iYuaspNmgBtlRQm?=
 =?us-ascii?Q?PpWNVucDhUYdEG9rbdt7uo5v53WAX5BLkomsSZoIW60uWJDuoRTu+Iarfdh3?=
 =?us-ascii?Q?Mt8qn7s8PnmPxthAf8C1TKUJB1CdOtUSzn+zABi0UvIlu1Lou/wOcOosLBJh?=
 =?us-ascii?Q?J1yNjATgKFzmffO29cYuNs0xCoPyNVIrLgwx6KMLAl0FjxbimS47WIo+iPeQ?=
 =?us-ascii?Q?7VuVsakx/rCzzC/ZMrlduoEQdwMJSusUFDUidpNwD3QAbPAm8iupnEXnuRxj?=
 =?us-ascii?Q?f04Jz1ZtkOwhTjw0bzPoHlFGUwxkg6Sr/TNKNiOLLO+rnYvWkU+raGnc+vRU?=
 =?us-ascii?Q?Tvz1hnZBxCvnhyZ0ajIB8aTVr9CwwSoNTO7erxySMpgoevSJrm+bSscrmByA?=
 =?us-ascii?Q?qgkeKgjBl1D380bbGOOJoHjGrKy1ZSYxPwCfgnQNuNqb4H6XMHx7D460WPfC?=
 =?us-ascii?Q?H8C7RrSb1J3AmeMFu+NdD4XPZ5bY0QmYFY0ory3SNt+Cw69L4qkLYY2FoMqo?=
 =?us-ascii?Q?Xx/LlPgx7u2vCS7fAJ6JBtiP3/D0KXCZvbQpyz6Nc5U26+SasJzPBoVCWBM6?=
 =?us-ascii?Q?ML/rXqkv2Wy+akjsH30JGWlOvupkhjACK+FPiVWLG/gSInq37RXI4mG48Ue9?=
 =?us-ascii?Q?rd33jub/E/7YtkyOhNudQWfUr07aOKjOZcbyX2l7aL0Ea+PcZSGL3BoQPm+w?=
 =?us-ascii?Q?h3kXgPi2Goqi6v8y14ee1pqQ34eQqiyUb5a9WaYcv+68nSjeitNw4UlceLxw?=
 =?us-ascii?Q?NoPXMAoVqfw+9vorgspC23DOlQK0J7Jv1+tHoPIwFDdMgWj5DTYzo7gE/+tS?=
 =?us-ascii?Q?Bb8I4mG3iPEGKrKbH8JOSbE/Pga5yrSXrDYqCJ1AwA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7MbRDtU9Fjy46yDx4gLua/lB0BaEY1QfDE/aDdgpI9kpdOywgMvSEWCu1Sy9?=
 =?us-ascii?Q?n2zesRV9dIdhg3JPLvQaKKONinBhAGyilra5LggCF6C4BqPy+4Qd3N65+ihX?=
 =?us-ascii?Q?HhjQ7FdFiihtLXnBCZrFk8JdQxnMrKzlf6D1TxLyeimzOQsJnvp/DBk+E4NX?=
 =?us-ascii?Q?9Vp8jqWlFdD7VWaUyVLEFg3FFKU/0Dn7tQrf4pizTsqaYN1DlqHv3hCs8gWI?=
 =?us-ascii?Q?jE9eB3n4EQEdwbam9ZkKkcBrdoEdVOGO6Oa04AAOEq/js0ZL6Uj0TU7PAVSv?=
 =?us-ascii?Q?Lun8beAvQNvWFAXX9vjx4uLOMJTyjkc64QTfKljXggiYNei1TOE1FsnCC4XJ?=
 =?us-ascii?Q?bTgkqmZDuWCdM/5C2hIFFezFefY91mhes3AO/D0B+tHaGXYtTEzLXt+bqPgp?=
 =?us-ascii?Q?lhRx8nLFpU8h/bo3BL8i95p584iQdrDQPnEYlC6knT1oCNIsysKC4nv3csPE?=
 =?us-ascii?Q?809rqIhsBarkLLBBjIUk7CqKeAeD8s/sUKibjwuqElPZzGg6XXFXYo9Kobc2?=
 =?us-ascii?Q?Xy8RSXK70oPQFpF3+TrHsfADRkbeaakbHpYNFJPk8SiV6V50d8OY3DtE7x8v?=
 =?us-ascii?Q?GBrljJ6ahcQ7KsFky7yDpZL8dICoM5Jw3V7K6CMN98CiKWqWD/yOxBY/xI7M?=
 =?us-ascii?Q?PTrmmGuvx6bcwLZB+HFTnyQO+ijax1W2Q5lipS9haAMWQUKoEch90y8eVaWD?=
 =?us-ascii?Q?6yTVWo5FZgnHOVArKVoDUqIfynMbfsFAz7z5BRRCko7by11QUN3whJy+8tui?=
 =?us-ascii?Q?jxQ+dO4L3vuX701bcqNGAeK8B244S+6anDOvd8jLuaJrqyJ9lPAHjAPhG/wX?=
 =?us-ascii?Q?01Ios1PU3vfBJ0qVJCSruMn8JSdsNVto23Ve5C/VFxqM2DSLVIY6tSpFP11C?=
 =?us-ascii?Q?Y/+xN2y2MBWRdVs/MPOKsV9L+Oclm1H4k6fME7RnRInYj39umvsBruD1PyAp?=
 =?us-ascii?Q?EbQ4aSU8o7XGJfa0qUt0gGx3/UT1VimoHdTfI36+jsvlAgAyJ5TNlreK0KzH?=
 =?us-ascii?Q?a4aW/p2FiM4BeUcWMi8gc+rR8trOtQTzTKjph344yAIRtoHcyE9G3X8ZuZBB?=
 =?us-ascii?Q?mmIcI8fQhqR/s+Jzu+r5QPxd1a5Od9qvG3y3VNK8PRaGxUFT37xGm2a7noky?=
 =?us-ascii?Q?zAB/sOkktbfxlWy7TAc9bjzpquF+1FUYDHzyULfcDkVJNcs/85ejPfbZsMld?=
 =?us-ascii?Q?jbbBQ7exEpzeTsnJ4/uaosXAdccgQ8usdjTGPAGK/GkF2FeDvk4vvN8skpAG?=
 =?us-ascii?Q?ARWQO2SBsB5oECuEn7VQP74XvaVLHzZ/iyGsJZd5zuLJsflCGrGk+e3bn/eM?=
 =?us-ascii?Q?1RrXuM4xvkHECUuZtDavWd0VK+Y4d+l03rFSt7N7up62MJz7j8AKLDHdOUZ5?=
 =?us-ascii?Q?PEqI2I6A1tYIugB2jsyekR+MUkE/EbHepokUTTQTBVdOonZkWRTFKCnr2iNH?=
 =?us-ascii?Q?F7qMhg3Mtyh3Kig6FPvj108ELezXg/76aBUm/deoG3yCQ2B0e5YcwaB29dZy?=
 =?us-ascii?Q?LpHx1hK6ONsWU88JZfJl7XgkgmIbghpAtYb61HOqrOv4ZDye37PWin3ef3V0?=
 =?us-ascii?Q?8bWA5xmHDeNgsZXPYe4bnHUNNLQ0Dy/D2xEdh11zFYi3QxsAM3uT+uc/RAbP?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ffa76f-a152-4e94-1f01-08dcf8a6663b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 05:47:54.6594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXlCRQtxMm2+ezGrIqU9BfKRxnJsPZ5hiVHPafDfecXIyHkqMpbgIUfKGBoEwjObfygIypvyp11YieOUkN5GTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6311
X-OriginatorOrg: intel.com



Hello,


this is another report about BUG:KCSAN, the change does not introduce new KCSAN
issue, but causes stats changes as below.


1d72d7b5fd535923 5aa6c43eca21a929ace6a8e31ab
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          6:6          -83%            :6     dmesg.BUG:KCSAN:data-race_in_timekeeping_advance/timekeeping_debug_get_ns
           :6          100%           6:6     dmesg.BUG:KCSAN:data-race_in_timekeeping_debug_get_ns/timekeeping_update_from_shadow


again, this report is just FYI what's the possible issue in related code.
and if you need more tests or want us to test some patches, please let us know.

thanks!


kernel test robot noticed "BUG:KCSAN:data-race_in_timekeeping_debug_get_ns/timekeeping_update_from_shadow" on:

commit: 5aa6c43eca21a929ace6a8e31ab3520ddc50dfa9 ("timekeeping: Split out timekeeper update of timekeeping_advanced()")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git timers/core

[test failed on linux-next/master 6fb2fa9805c501d9ade047fc511961f3273cdcb5]

in testcase: boot

config: x86_64-randconfig-073-20241025
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410301316.e51421de-lkp@intel.com


[   70.265411][    C1] BUG: KCSAN: data-race in timekeeping_debug_get_ns / timekeeping_update_from_shadow
[   70.265430][    C1]
[   70.265433][    C1] write to 0xffffffff8483fef8 of 296 bytes by interrupt on cpu 0:
[ 70.265440][ C1] timekeeping_update_from_shadow+0x8e/0x140 
[ 70.265452][ C1] timekeeping_advance (kernel/time/timekeeping.c:2394) 
[ 70.265462][ C1] update_wall_time (kernel/time/timekeeping.c:2403) 
[ 70.265472][ C1] tick_do_update_jiffies64 (kernel/time/tick-sched.c:150) 
[ 70.265485][ C1] tick_nohz_lowres_handler (kernel/time/tick-sched.c:232 kernel/time/tick-sched.c:290 kernel/time/tick-sched.c:1486) 
[ 70.265498][ C1] __sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1044) 
[ 70.265515][ C1] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1037 arch/x86/kernel/apic/apic.c:1037) 
[ 70.265526][ C1] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[ 70.265539][ C1] __tsan_read8 (kernel/kcsan/core.c:280 kernel/kcsan/core.c:752 kernel/kcsan/core.c:1025) 
[ 70.265548][ C1] rcu_lockdep_current_cpu_online (kernel/rcu/tree.c:4740 kernel/rcu/tree.c:4781) 
[ 70.265562][ C1] rcu_read_lock_held (kernel/rcu/update.c:113 kernel/rcu/update.c:349) 
[ 70.265573][ C1] mtree_range_walk (lib/maple_tree.c:789 lib/maple_tree.c:2789) 
[ 70.265584][ C1] mas_walk (lib/maple_tree.c:265 lib/maple_tree.c:4949) 
[ 70.265594][ C1] lock_vma_under_rcu (mm/memory.c:6225) 
[ 70.265606][ C1] do_user_addr_fault (arch/x86/mm/fault.c:1330) 
[ 70.265617][ C1] exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
[ 70.265624][ C1] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[   70.265634][    C1]
[   70.265636][    C1] read to 0xffffffff8483ff18 of 8 bytes by interrupt on cpu 1:
[ 70.265642][ C1] timekeeping_debug_get_ns (kernel/time/timekeeping.c:415 kernel/time/timekeeping.c:399 kernel/time/timekeeping.c:307) 
[ 70.265653][ C1] ktime_get (kernel/time/timekeeping.c:431 (discriminator 4) kernel/time/timekeeping.c:897 (discriminator 4)) 
[ 70.265660][ C1] tick_nohz_lowres_handler (kernel/time/tick-sched.c:220 kernel/time/tick-sched.c:290 kernel/time/tick-sched.c:1486) 
[ 70.265671][ C1] __sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1044) 
[ 70.265683][ C1] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1037 arch/x86/kernel/apic/apic.c:1037) 
[ 70.265690][ C1] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[ 70.265701][ C1] __tsan_unaligned_write8 (arch/x86/include/asm/current.h:49 kernel/kcsan/core.c:206 kernel/kcsan/core.c:750 kernel/kcsan/core.c:1025) 
[ 70.265711][ C1] mntput_no_expire (fs/namespace.c:1396) 
[ 70.265719][ C1] mntput (fs/namespace.c:1471 (discriminator 3)) 
[ 70.265728][ C1] path_openat (fs/namei.c:3910) 
[ 70.265738][ C1] do_filp_open (fs/namei.c:3961) 
[ 70.265749][ C1] do_sys_openat2 (fs/open.c:1416) 
[ 70.265760][ C1] __ia32_compat_sys_openat (fs/open.c:1488) 
[ 70.265772][ C1] ia32_sys_call (arch/x86/entry/syscall_32.c:44) 
[ 70.265781][ C1] __do_fast_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:386) 
[ 70.265792][ C1] do_fast_syscall_32 (arch/x86/entry/common.c:411) 
[ 70.265803][ C1] do_SYSENTER_32 (arch/x86/entry/common.c:450) 
[ 70.265814][ C1] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:127) 
[   70.265827][    C1]
[   70.265829][    C1] value changed: 0x000bfafab0800000 -> 0x000c197f30800000
[   70.265834][    C1]
[   70.265837][    C1] Reported by Kernel Concurrency Sanitizer on:
[   70.265841][    C1] CPU: 1 UID: 0 PID: 135 Comm: systemd-udevd Not tainted 6.12.0-rc1-00057-g5aa6c43eca21 #1 dac0ad7371e68d11ebb5ff151a0b0e46d35a6ac0
[   70.265853][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   70.265858][    C1] ==================================================================
[  OK  ] Started Regular background program processing daemon.
[  OK  ] Started D-Bus System Message Bus.
Starting Helper to synchronize boot up for ifupdown...
Starting LSB: OpenIPMI Driver init script...
Starting System Logging Service...
Starting User Login Management...
[  OK  ] Finished Helper to synchronize boot up for ifupdown.
Starting Raise network interfaces...
Starting LSB: Load kernel image with kexec...
[   70.813962][  T196] IPMI message handler: version 39.2
[  OK  ] Finished Raise network interfaces.
[  OK  ] Reached target Network.
[   71.021971][  T208] ipmi_si: IPMI System Interface driver
Starting LKP bootstrap...
[   71.073697][  T208] ipmi_si: Unable to find any System Interface(s)
Starting /etc/rc.local Compatibility...
Starting OpenBSD Secure Shell server...
Starting Permit User Sessions...
[  OK  ] Started LSB: Load kernel image with kexec.
[  OK  ] Started User Login Management.
[   71.125252] rc.local[223]: PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/lkp/lkp/src/bin
[  OK  ] Started /etc/rc.local Compatibility.
[  OK  ] Finished Permit User Sessions.
LKP: ttyS0: 223: skip deploy intel ucode as no ucode is specified
[   71.266778] rc.local[223]: LKP: stdout: 223: skip deploy intel ucode as no ucode is specified
[  OK  ] Started Getty on tty1.
[  OK  ] Reached target Login Prompts.
[FAILED] Failed to start LSB: OpenIPMI Driver init script.
See 'systemctl status openipmi.service' for details.
[  OK  ] Started OpenBSD Secure Shell server.
LKP: ttyS0: 223: Kernel tests: Boot OK!
LKP: ttyS0: 223: HOSTNAME vm-snb, MAC 52:54:00:12:34:56, kernel 6.12.0-rc1-00057-g5aa6c43eca21 1
LKP: ttyS0: 223:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-meta-135/boot-1-debian-11.1-i386-20220923.cgz-x86_64-randconfig-073-20241025-5aa6c43eca21-20241030-925541-jrgvjy-5.yaml
[   80.243928][  T241] is_virt=true
[   80.243958][  T241]
[   80.596747][    C0] ==================================================================
[   80.597444][    C0] BUG: KCSAN: data-race in timekeeping_debug_get_ns / timekeeping_update_from_shadow
[   80.598259][    C0]
[   80.598445][    C0] write to 0xffffffff8483fef8 of 296 bytes by interrupt on cpu 1:
[ 80.599035][ C0] timekeeping_update_from_shadow+0x8e/0x140 
[ 80.599730][ C0] timekeeping_advance (kernel/time/timekeeping.c:2394) 
[ 80.600108][ C0] update_wall_time (kernel/time/timekeeping.c:2403) 
[ 80.600452][ C0] tick_do_update_jiffies64 (kernel/time/tick-sched.c:150) 
[ 80.600881][ C0] tick_nohz_lowres_handler (kernel/time/tick-sched.c:232 kernel/time/tick-sched.c:290 kernel/time/tick-sched.c:1486) 
[ 80.601309][ C0] __sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1044) 
[ 80.601767][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1037 arch/x86/kernel/apic/apic.c:1037) 
[ 80.602211][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[   80.602705][    C0]
[   80.602997][    C0] read to 0xffffffff8483ff18 of 8 bytes by interrupt on cpu 0:
[ 80.603583][ C0] timekeeping_debug_get_ns (kernel/time/timekeeping.c:415 kernel/time/timekeeping.c:399 kernel/time/timekeeping.c:307) 
[ 80.604050][ C0] ktime_get_update_offsets_now (kernel/time/timekeeping.c:2583 (discriminator 4)) 
[ 80.604545][ C0] hrtimer_run_queues (kernel/time/hrtimer.c:637 kernel/time/hrtimer.c:1904) 
[ 80.604974][ C0] update_process_times (kernel/time/timer.c:2465 kernel/time/timer.c:2517) 
[ 80.605404][ C0] tick_nohz_lowres_handler (kernel/time/tick-sched.c:277 kernel/time/tick-sched.c:297 kernel/time/tick-sched.c:1486) 
[ 80.605866][ C0] __sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1044) 
[ 80.606508][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1037 arch/x86/kernel/apic/apic.c:1037) 
[ 80.606958][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[   80.607450][    C0]
[   80.607656][    C0] value changed: 0x0015dff030800000 -> 0x0015fe74b0800000
[   80.608228][    C0]
[   80.608442][    C0] Reported by Kernel Concurrency Sanitizer on:
[   80.608945][    C0] CPU: 0 UID: 0 PID: 241 Comm: sed Not tainted 6.12.0-rc1-00057-g5aa6c43eca21 #1 dac0ad7371e68d11ebb5ff151a0b0e46d35a6ac0
[   80.610047][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   80.610868][    C0] ==================================================================



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241030/202410301316.e51421de-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


