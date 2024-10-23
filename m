Return-Path: <linux-kernel+bounces-377535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB0C9AC02B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B240B244F9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17957154C04;
	Wed, 23 Oct 2024 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fhp4JKnf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC94153835
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729668456; cv=fail; b=B36uCtfSKmYduH/8krL+FNx1BU9DIIaUAslvQznZSRZyOkzDb0qR/VpKfwMv41E83v+8goX9sInMhdIVb6FT4msjUpwnFJxH3D32uwajFaSV8RggW3OC+7WLYNLr8dfRCQDkwfhwZ7fDa1in2lL4sAybCddDvTkrlqOowGIRjBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729668456; c=relaxed/simple;
	bh=4pj3V0ffonwUCQ7QSBvl7pR5QxRSZftlMBPrGaWZRx8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ub3fJCJEtYmkN8fl1oeHeZB763OXQHpInGbIFEnBHur0t9yqoJ/b7h/JEjwPfbwqR2rqg5MrFHOxNTxBhS+G6p6FNuMwwiU4iNwiae7DDuMawy0DwmpfnEk/Sei4lrmsiBdUOFPOjVyJUjo4yY5PUXU3rnqG0R2Ei21l2ZtaMVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fhp4JKnf; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729668454; x=1761204454;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=4pj3V0ffonwUCQ7QSBvl7pR5QxRSZftlMBPrGaWZRx8=;
  b=fhp4JKnfrz3H3Y0KawGhBVGnz++3Rzl72Bdo2dLjzYf4svB+3g5QHwDn
   aSCC9SzRWXu8rHjyMMjGweBIZ5UHRNXgIFsoUA5zdKzYmkUt3CdRe5Iuy
   kOxu+/tL/hnEr4ch8BZ5OaAJ8gidQjO4iWhOc6jCMpkeLGiY6GjrEnLiy
   meBv1WvqfmK3HuCtDQwpByyABODnobraIxuzeSbwnBflF8NrVm1CGdGw6
   zbcCceVPH0FiyRSvjRFzu37YmZCyzWfBxYZZkgWmK/c7KAHDzGmBu5H/W
   iup4RlVGDv3ZNdbY2Ec/KJ5Tr1Bqs8Gj5LyUM8lrxCW3JQkh5c+kKOR8G
   w==;
X-CSE-ConnectionGUID: i/WSiVK5TyOlhKHfNNBv7A==
X-CSE-MsgGUID: gmozGVp2ReKYDTn7IuMt+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="28683563"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="28683563"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 00:27:34 -0700
X-CSE-ConnectionGUID: 318mpbnUTPKfx8L0LhwlVg==
X-CSE-MsgGUID: rn7aO2PkQeC0Au+/I2B5UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="84082844"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 00:27:33 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 00:27:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 00:27:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 00:27:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qn8fnNZVlPjCozGKmI5w4dhVU7HdLHD2+3FW4BY89b4m1s5OPIyCgW3A186pTu6vNfvAJwNe4s7gLo7ZDYuFLk2lvnUj0l/xWy+vIKa2kd2gDRmt0BnDqlt8LTx3iL8HcseLZe2dPPUmw3jq9EjjF8iz93ls7N4FhN07yKayiJZGmRm4lE0jU1fcPS1ZY009YPyPkMs87CUn3wKhc4cpQ+JQt6yxo8ZGf9SUpKc2wuy4dMjN7DfehjyC6m0NltKfxmGEV7r5EtdmhnyVvxZz70JoIAHOUokbg9H+j3xrOV+8aKZVmxI2VlUv+owYY54xs40oi9NBKHWSnJGu6B2Xpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZ4j6o6tJtndCUG9H+aAUo4891sMy+5EekQZj2A7WHk=;
 b=RTT3w5w0O1mnpSjnAgENmeZM+2J2fNJJ3RjdgotcLmKvrfQp0FX3V+lWGGpU+Y9q/Sg9Pr5v5QL3jxfer4OlEiiRyI1QXmBC8yIBDxDUiStr7ev0X/Zr5IehfMiKcmdspBSU3zYVkUze7ZRp+N6ukWnBtMRo4WjYlXuq9FQg0Pn5/llFLFNzfMVVvGYLv6yxx+z9MNtHmhQcuQBytl1tlAqRKAubcxkGHpAhlhigh86xqK2OTk2plIaR00zyj+iMHGFNzWVOIZTZZo0SKZqTYgm0hmlaIHLsOn5/BQVd/OVHxr7lHDgDT04jeyoci6V9eFY3Ax9g9EPZaPY9E30IIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 07:27:29 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 07:27:29 +0000
Date: Wed, 23 Oct 2024 15:27:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: <lizhe.67@bytedance.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
	<longman@redhat.com>, <boqun.feng@gmail.com>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, <lizhe.67@bytedance.com>,
	<oliver.sang@intel.com>
Subject: Re: [RFC 2/2] khugepaged: use upgrade_read() to optimize
 collapse_huge_page
Message-ID: <202410231434.e98a7287-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241016043600.35139-3-lizhe.67@bytedance.com>
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f76fc4-cdc5-4195-a97a-08dcf334267b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uJ+ReM2QO9mc1WyL09S/oXpDt8VX/ErL/sHDsuouhLTg8ezdz4oHZRq/z8I4?=
 =?us-ascii?Q?KnTjvJVu45xGm9zQFpvhjBwZ8Wr0yvR3FTjLUHnSm/utSF+nZJu5fF+TH1Jf?=
 =?us-ascii?Q?+Qsrn323POocVdL5Ge9U+jzpXoiVqPGMveKzneceoKBkk0BhZXD4JDOht6vZ?=
 =?us-ascii?Q?6d0MHIPQwFJwYI3UIPKdC5UzLaGox1GljpBDs+e84J/TgbdKnwHVwFFhOQ3m?=
 =?us-ascii?Q?8kSNDIqfQpDCa3XL4ELp+TA0oitjGjbDHgRHz1zgxjd7KfiovYEAXUlQ9+mN?=
 =?us-ascii?Q?QgiD8AZEuOAr+fqwVv0jG0RMTp94XqCCdgU/jq/CiNsl5Qw/hafZ+FEXg0fE?=
 =?us-ascii?Q?lS9LSgKJUN2MXNrSRIcG1raOX6pmbQ3IAbr+gnWfHG+MmDLoiEDrLr0orZya?=
 =?us-ascii?Q?qWLspsaZtpLsOedakgaj+61BWKVbNwM84OSrUZhlA/hD1Pb93EuP2IgNcol8?=
 =?us-ascii?Q?bnENgV/8cT/Lrx5wyo+ZlAWbbuQIiwHFsY1lMofvaovBQ5HsAU0PgJSyweUR?=
 =?us-ascii?Q?NXxXedQ8E8dDTUWXEnao031dXsL5RFaldEpMRhF+ZSrhFR8ysjB3MXcXWQfA?=
 =?us-ascii?Q?Z3GZDrNYClXZjUo0k+dIX9pTfmS24C/iPPUnrkdKjYQBQwQn2aEWcB5d9bQ9?=
 =?us-ascii?Q?RgS4ZYaFTq+XkvA1eOXHl6ExaEojUe/fy1bNNuxO1XDSclbpR2zTuAmPWcXt?=
 =?us-ascii?Q?7qv9h1bsh6sTpI/3OE021iBV1YFVBmbTtWi7eFueNoEkIYpUOK+sQHpniK1j?=
 =?us-ascii?Q?yWAbuuctHzgcx2gn0HW4D5KJjH+lqRchV0WBSTWBtA4LVj9MyK4/aVT7P7LU?=
 =?us-ascii?Q?qs9SqeOxNFq0IPV+blFRk7TU3ezpvVW9tF3pU99pr2gK0lfjOqFCPXDKi9UU?=
 =?us-ascii?Q?/OfBCu34PneplTWcwo63D1ipReMRZpX+JUn+nDFC6vRo+1fGP+hIbkxZYDKy?=
 =?us-ascii?Q?n3rF+aSPBxPcRrxOpw70fJ2TfJ1o/1MJxJUwbguoOqYMipUgTFHU9OR+urdG?=
 =?us-ascii?Q?ZaL+rAeUNui+ZiXlr51nxJ9JKYQJgFXZlWpPd5W7nictdpfFM16QmNiyPow8?=
 =?us-ascii?Q?dj9TI/tG1qbuJiVDAgvC6W3Opd3n8Dx2WbTqKUgS8n5HbKPlG4eeEq5y9mmG?=
 =?us-ascii?Q?wowvbFhGm/2MIeCScbsW7ZlmpWNKrU6r97zewGU4arNh7KMgnDBxAUEdT5KX?=
 =?us-ascii?Q?s2dTteM23SirA0fjt3x1GzfsanOT5NmrG0Awrb8LFh02YS8eWTpgjfAy72+/?=
 =?us-ascii?Q?PanzII1udNI5cjcC1SA01pY+UYgEeUMDUqkI5SqpTQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f5u6WFMWIDTIU667HtvFvLEKcw2Ty7QadK3FtZflIIV1HXgdk0/Kb4adDf1t?=
 =?us-ascii?Q?gXaO6KMVGHHgQW4hI9Daw5z+sSPaRI3DjXrFsxwo6WX0CjK5SME24YQmyfWL?=
 =?us-ascii?Q?bNIz8c3/WIS3W4M1PDgo0yOE/4Qo4DlHMchFJD8x3p07+xkYRhBxSem+rZEX?=
 =?us-ascii?Q?Vwe3z1v8Q02Py46PrOZCsHlFLYHui5tdwmTR1x/TmhJQrJnEPVmRVUPSSm09?=
 =?us-ascii?Q?FF5XBBBv8V+23hdq4hzgsM2TVCZE8GdBN52NOEn04Hc8oQpitG4EUmsyyRja?=
 =?us-ascii?Q?+pmtGXq+0Y7zr9LOrRKlUrU2wE3+MpQV3mAcypSnB3PwLCsy+KknpEx7lhtO?=
 =?us-ascii?Q?/GENI84sXk/rXgNVsWPEIVgTCZkRDU31Sb1MghCx6AvjFN3r4XZCR975nvPm?=
 =?us-ascii?Q?ZKsUQ1hM5eMPUkkTwIKP2cmoWqfzsJNS6zaeMewCtvZDEhqr9q+JvwUinAZp?=
 =?us-ascii?Q?5z0R4bm9PlCFGNbnhT+tCp/wWibqi1dnUek08dcXgG+DfWZuNNRNq3uRbQIw?=
 =?us-ascii?Q?udF4lGUD6JIwSVl94yks77HIfsakQ0rV/ZeW6CpzPfVQ4x/tP38zmGEqKTag?=
 =?us-ascii?Q?i43ynuSUUesndYcYi/5iSUoSYmo66dRmrZu2LCFguEIjqYOn2GILSMmna99C?=
 =?us-ascii?Q?KKj6nsWVRKybHfGVuQgrgq7vd+fNRk8S9Bl3Gd8Z1wB0juc4xgGSYYaam+UG?=
 =?us-ascii?Q?Myu01b+2y9oEu+Wp8fkcq0yHuWC+0UHygC9MyKfu506NRhWb9TdwfZdRFulT?=
 =?us-ascii?Q?vH/fABpo3Z7GFmP7GTo5Ww/u/VYGwft7Y7U2vw7Ko8HpDzCequDhPa3Jpfz0?=
 =?us-ascii?Q?HmTRvwuLS9su5OYX9UowuxMIHGdwVZsLTaPE7+4Dqfv5E1SubMHx6XtDKZQ7?=
 =?us-ascii?Q?tMRmQQ3ryT3Fqk8Ak04780n/1+ck1xYSbBXeJTKsmZnzsaWmJpxN8ERZjzAp?=
 =?us-ascii?Q?fUJILyg9baWRSGVugHbBqQy4S2Ikpe+PhJT4umwRFK+fpJslD7GKNaMIUhEN?=
 =?us-ascii?Q?4VUsTyBz4qOzk9NoKKecSNZ4ZJfYf6eAcqLk/v0A56NTfuBTUBYjxd12vP69?=
 =?us-ascii?Q?ikDu5BSKeC+29q4/px5bRKLwIasznLDqhLu3IaIdMW2wv3C2AWG7YLle7igz?=
 =?us-ascii?Q?swgt2KB+L93nxBbSmUbLBhRNxIz/uS+C2g8FuOMbCgTUr5rEdwABRnXUEufT?=
 =?us-ascii?Q?OQFxZ9wiPeCkoEU+jBD/c44bhx7FSje5TlAVwT8M/JyrMmbWexMCxd/VE3OE?=
 =?us-ascii?Q?Sk8dImTI1gu7eiqzV2S3xLsczcXB9Rs8/i7a/nVpdZP3UDLiB+nY6d/Ff7G+?=
 =?us-ascii?Q?mXuIZrnp9ah1DLwinOgix1gs9GiLDmJOhiscNGcCvQg/Mp9J1d/1yl8D219K?=
 =?us-ascii?Q?Y13XNGrQD8oD/Fo00X8HKVwfNS6HHZepXsMhYgEw/D4SxuLltrbbxK9CKbIZ?=
 =?us-ascii?Q?MtlAhttzsrh5Zd43qQwlZqnvZtb2U5AORAnczGMljx8akRuV+f+MswzU5DSS?=
 =?us-ascii?Q?U9OtOIyvrOKAhfil1tPMHZK4GIrxJv8rgSuwUJR7bdFwJgVaXnhaunVELBFR?=
 =?us-ascii?Q?L8uKdeIJKrr7Pl7QEcGt8hgG4mzIlg+tBS80bpE3CaNSPgxcYYthYUZM9NW2?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f76fc4-cdc5-4195-a97a-08dcf334267b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 07:27:29.1149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pY9TCBa8mHWBEaBu1NOqpWmRtcscD+KNbYlwgj6ZO1eIK9Fwsi82Ev3NjiCmJvvvLMF9yRNxZ6fWaJnsO8qxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8230
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_include/linux/rwsem.h:#collapse_huge_page" on:

commit: 6604438065fc95d188ffcde12f687dfc319ef2cc ("[RFC 2/2] khugepaged: use upgrade_read() to optimize collapse_huge_page")
url: https://github.com/intel-lab-lkp/linux/commits/lizhe-67-bytedance-com/rwsem-introduce-upgrade_read-interface/20241016-123810
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 823a566221a5639f6c69424897218e5d6431a970
patch link: https://lore.kernel.org/all/20241016043600.35139-3-lizhe.67@bytedance.com/
patch subject: [RFC 2/2] khugepaged: use upgrade_read() to optimize collapse_huge_page

in testcase: boot

config: x86_64-rhel-8.3-kselftests
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------------+------------+------------+
|                                                      | 6a6ad5e040 | 6604438065 |
+------------------------------------------------------+------------+------------+
| WARNING:at_include/linux/rwsem.h:#collapse_huge_page | 0          | 18         |
| RIP:collapse_huge_page                               | 0          | 18         |
+------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410231434.e98a7287-oliver.sang@intel.com


[   19.879799][   T39] ------------[ cut here ]------------
[ 19.880779][ T39] WARNING: CPU: 0 PID: 39 at include/linux/rwsem.h:203 collapse_huge_page (include/linux/rwsem.h:203 include/linux/mmap_lock.h:70 include/linux/mm.h:735 include/linux/mm.h:754 mm/khugepaged.c:1165) 
[   19.881951][   T39] Modules linked in: sch_fq_codel
[   19.882624][   T39] CPU: 0 UID: 0 PID: 39 Comm: khugepaged Not tainted 6.12.0-rc2-00004-g6604438065fc #1
[   19.883821][   T39] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 19.885086][ T39] RIP: 0010:collapse_huge_page (include/linux/rwsem.h:203 include/linux/mmap_lock.h:70 include/linux/mm.h:735 include/linux/mm.h:754 mm/khugepaged.c:1165) 
[ 19.885835][ T39] Code: 0f 85 7f f9 ff ff 48 c7 c2 00 e0 59 84 be 6e 03 00 00 48 c7 c7 60 e0 59 84 c6 05 fd 58 49 04 01 e8 88 4e 7e ff e9 5b f9 ff ff <0f> 0b 48 b8 00 00 00 00 00 fc ff df 4c 89 c2 48 c1 ea 03 80 3c 02
All code
========
   0:	0f 85 7f f9 ff ff    	jne    0xfffffffffffff985
   6:	48 c7 c2 00 e0 59 84 	mov    $0xffffffff8459e000,%rdx
   d:	be 6e 03 00 00       	mov    $0x36e,%esi
  12:	48 c7 c7 60 e0 59 84 	mov    $0xffffffff8459e060,%rdi
  19:	c6 05 fd 58 49 04 01 	movb   $0x1,0x44958fd(%rip)        # 0x449591d
  20:	e8 88 4e 7e ff       	callq  0xffffffffff7e4ead
  25:	e9 5b f9 ff ff       	jmpq   0xfffffffffffff985
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  33:	fc ff df 
  36:	4c 89 c2             	mov    %r8,%rdx
  39:	48 c1 ea 03          	shr    $0x3,%rdx
  3d:	80                   	.byte 0x80
  3e:	3c 02                	cmp    $0x2,%al

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   9:	fc ff df 
   c:	4c 89 c2             	mov    %r8,%rdx
   f:	48 c1 ea 03          	shr    $0x3,%rdx
  13:	80                   	.byte 0x80
  14:	3c 02                	cmp    $0x2,%al
[   19.888059][   T39] RSP: 0000:ffffc90000297998 EFLAGS: 00010246
[   19.888832][   T39] RAX: 0000000000000000 RBX: 1ffff92000052f39 RCX: 0000000000000000
[   19.889839][   T39] RDX: 0000000000000000 RSI: ffff88813394afd8 RDI: ffff88810625c320
[   19.890860][   T39] RBP: ffff8882e908a6c8 R08: ffff8882e908a6d8 R09: ffffed10267295ee
[   19.891844][   T39] R10: ffff88813394af77 R11: ffff8882ea258440 R12: ffff88813394ae40
[   19.892865][   T39] R13: ffffffff859ef180 R14: ffffc90000297ab8 R15: ffff88813394af68
[   19.893868][   T39] FS:  0000000000000000(0000) GS:ffff8883aee00000(0000) knlGS:0000000000000000
[   19.894985][   T39] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.895775][   T39] CR2: 0000000028a5b608 CR3: 0000000133892000 CR4: 00000000000406f0
[   19.896782][   T39] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   19.897783][   T39] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   19.898793][   T39] Call Trace:
[   19.902237][   T39]  <TASK>
[ 19.902820][ T39] ? collapse_huge_page (include/linux/rwsem.h:203 include/linux/mmap_lock.h:70 include/linux/mm.h:735 include/linux/mm.h:754 mm/khugepaged.c:1165) 
[ 19.903524][ T39] ? __warn (kernel/panic.c:748) 
[ 19.904099][ T39] ? collapse_huge_page (include/linux/rwsem.h:203 include/linux/mmap_lock.h:70 include/linux/mm.h:735 include/linux/mm.h:754 mm/khugepaged.c:1165) 
[ 19.904863][ T39] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 19.905477][ T39] ? handle_bug (arch/x86/kernel/traps.c:285) 
[ 19.906057][ T39] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator 1)) 
[ 19.906674][ T39] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 19.907345][ T39] ? collapse_huge_page (include/linux/rwsem.h:203 include/linux/mmap_lock.h:70 include/linux/mm.h:735 include/linux/mm.h:754 mm/khugepaged.c:1165) 
[ 19.908036][ T39] ? collapse_huge_page (include/linux/rwsem.h:203 include/linux/mmap_lock.h:70 include/linux/mm.h:735 include/linux/mm.h:754 mm/khugepaged.c:1165) 
[ 19.908739][ T39] ? __pte_offset_map_lock (include/linux/pgtable.h:324 include/linux/pgtable.h:594 mm/pgtable-generic.c:376) 
[ 19.909447][ T39] ? __pfx_collapse_huge_page (mm/khugepaged.c:1095) 
[ 19.910150][ T39] ? __pfx_lock_acquire (kernel/locking/lockdep.c:5793) 
[ 19.910817][ T39] ? __lock_acquire (kernel/locking/lockdep.c:5202) 
[ 19.911460][ T39] ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 kernel/locking/spinlock_debug.c:116) 
[ 19.912111][ T39] ? find_held_lock (kernel/locking/lockdep.c:5315) 
[ 19.912753][ T39] ? find_held_lock (kernel/locking/lockdep.c:5315) 
[ 19.913389][ T39] ? hpage_collapse_scan_pmd (include/linux/rcupdate.h:347 include/linux/rcupdate.h:880 include/linux/pgtable.h:115 mm/khugepaged.c:1422) 
[ 19.914118][ T39] ? __lock_release+0x10b/0x440 
[ 19.914823][ T39] ? hpage_collapse_scan_pmd (include/linux/rcupdate.h:347 include/linux/rcupdate.h:880 include/linux/pgtable.h:115 mm/khugepaged.c:1422) 
[ 19.915528][ T39] ? hpage_collapse_scan_pmd (include/linux/rcupdate.h:347 include/linux/rcupdate.h:880 include/linux/pgtable.h:115 mm/khugepaged.c:1422) 
[ 19.916202][ T39] hpage_collapse_scan_pmd (mm/khugepaged.c:1427) 
[ 19.916915][ T39] ? __pfx_hpage_collapse_scan_pmd (mm/khugepaged.c:1261) 
[ 19.917678][ T39] ? __thp_vma_allowable_orders (arch/x86/include/asm/bitops.h:206 (discriminator 1) arch/x86/include/asm/bitops.h:238 (discriminator 1) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 1) mm/huge_memory.c:118 (discriminator 1)) 
[ 19.918441][ T39] ? __pfx___might_resched (kernel/sched/core.c:8586) 
[ 19.919187][ T39] khugepaged_scan_mm_slot+0x8bd/0xd90 
[ 19.920082][ T39] ? __pfx_khugepaged_scan_mm_slot+0x10/0x10 
[ 19.921041][ T39] ? __pfx_lock_acquire (kernel/locking/lockdep.c:5793) 
[ 19.921756][ T39] ? __pfx_do_raw_spin_lock (kernel/locking/spinlock_debug.c:114) 
[ 19.922464][ T39] ? __pfx___might_resched (kernel/sched/core.c:8586) 
[ 19.923200][ T39] khugepaged (include/linux/spinlock.h:391 mm/khugepaged.c:2521 mm/khugepaged.c:2573) 
[ 19.923801][ T39] ? __pfx_khugepaged (mm/khugepaged.c:2566) 
[ 19.924471][ T39] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4347 kernel/locking/lockdep.c:4406) 
[ 19.925235][ T39] ? __kthread_parkme (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/kthread.c:280) 
[ 19.925865][ T39] ? __pfx_khugepaged (mm/khugepaged.c:2566) 
[ 19.926499][ T39] kthread (kernel/kthread.c:389) 
[ 19.927083][ T39] ? __pfx_kthread (kernel/kthread.c:342) 
[ 19.927775][ T39] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 19.928395][ T39] ? __pfx_kthread (kernel/kthread.c:342) 
[ 19.929026][ T39] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   19.929685][   T39]  </TASK>
[   19.930123][   T39] irq event stamp: 951
[ 19.930689][ T39] hardirqs last enabled at (965): __up_console_sem (arch/x86/include/asm/irqflags.h:42 (discriminator 1) arch/x86/include/asm/irqflags.h:97 (discriminator 1) arch/x86/include/asm/irqflags.h:155 (discriminator 1) kernel/printk/printk.c:344 (discriminator 1)) 
[ 19.931960][ T39] hardirqs last disabled at (978): __up_console_sem (kernel/printk/printk.c:342 (discriminator 1)) 
[ 19.933120][ T39] softirqs last enabled at (892): handle_softirqs (arch/x86/include/asm/preempt.h:26 kernel/softirq.c:401 kernel/softirq.c:582) 
[ 19.934254][ T39] softirqs last disabled at (885): __irq_exit_rcu (kernel/softirq.c:589 kernel/softirq.c:428 kernel/softirq.c:637) 
[   19.935397][   T39] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241023/202410231434.e98a7287-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


