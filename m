Return-Path: <linux-kernel+bounces-363234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1F099BF63
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A083D1F22A30
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 05:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF904C7E;
	Mon, 14 Oct 2024 05:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ap9vdhxv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501B4E1CA
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 05:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728883607; cv=fail; b=IZ/j5LDIDv45QGPGljx/NLIW8zp0148oW72p4CPcljKDRMWabsLQhKGXqKJIS3ldtyxBOMtATrsoKw+5HRFRTGRKU+82QvLRMTe4MtJDHsaAk1BXdRHP0AdrP7OpBDZJtjRONbjRyMVQmnugHjGHoDv57Dl6yCc9Vnhplec74iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728883607; c=relaxed/simple;
	bh=5zpsNEAJe2CtV242bI3rY25DRn3sOKOzZdJYzizoG0g=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E0z6MV4Lq9r5AieNY98A51lYTD8O/v2FpxygZ7yhmkuTVsPhN7SgtBGlU7tHjmqS1K5QaJINjobzeC162iSnEAekF4ZostpoLoXkiZT5lSSIrC05Smz344bqooYxypOn7GBmPX+9ECEJjN74EPjvshqDKwpRuLUK2z9BKwhscXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ap9vdhxv; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728883605; x=1760419605;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=5zpsNEAJe2CtV242bI3rY25DRn3sOKOzZdJYzizoG0g=;
  b=Ap9vdhxvFAFMgNVvoKuXKsCjsURY51IzrWisLxnshqA7DZI/7+alvnu/
   jtSDdQLay6+5YNM3ovJfQQrYuSMfboLnj3oxtZIZJpRhrQ4Mv6Z3H5iLs
   IWnAuc9JIIECzKSWJ63rYYiC6Vgk2QZd0zGqMraWmgKV9WKjdOOKARaU9
   ba/cYfgcWBjQrNzUUZWp3w9e6hCsnWTpMUkLbRInEm/23JMQCeMcfFRo6
   rv0HY2mNYSB15mhGgHR+/sm1BJlmIYBbrelY2QiBxpmc5aactXH3Mt2by
   9qiuNN9ngjksL4rsBxHfdzDvTWQGsaWc5fY7AAxvCNn247XEyTYB0Gant
   w==;
X-CSE-ConnectionGUID: rThLc+SoSYiO6+y+bfm+Ng==
X-CSE-MsgGUID: 8tuLQJ+uRcCdkmgJ/ortRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="38792959"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="38792959"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 22:26:44 -0700
X-CSE-ConnectionGUID: QC6vikEyRZqsGiUkkTJrYg==
X-CSE-MsgGUID: URtrhX7QRXyvzbDaM9p6ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="82245652"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2024 22:26:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 13 Oct 2024 22:26:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 13 Oct 2024 22:26:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 13 Oct 2024 22:26:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFxCrzVBAzsWw4UJ1b0ceCgjgRqMXXOEqp6PDNX2hs2Af6o7+hC9l6jKtz8fQnoAp3TebIy1wZUbOqLy3hPbhrbw2mH//L3bq4wFu9b4YOCPAdNeGd+lDZnRLvmhlCkhKTT0HLNLKjU4npJPNHHMwxUaIZCpiDNvL/GrELryNysfdu9QTAM0CJqdbnoQaAtjiqMV9LHSqnGj4x+FGvTz4oZxepI1gYh1c02WssK6Njd2QyJYb6IpSNK+z0k9KZ5NbRMDYP9mGYC7i3H17GyxtJT9hi4UHyuo3Za6uT/EncTVj/z6b9m029i2ugtV40mrPMDWuahb/BClfn8Nd2LsHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUd6YbCu8z81KAei4fDL/mbDOUCx6LGP6ZUCFeZX4lE=;
 b=Og4/TkpMj5dc9nAEykyPNSo0kS9dCKAm9NAuGxhxaFY9HcPBjV8Zbuq+nKGz0gaj4TO4T7liWZNcOfhXD8PncTNIHuo3TQOIRlb7G7ql7Z666uEykQXEcq5j93MdkeNZcJdwOJTcxYtuzCqNByAKrwfIfUp4Q/koUFU/qI5BTyoTLlT2Kdi11z5cDtbhcYMQ2kIQjL2DjFzVsIMEimVnkLe1l4ggR1zbT0G9GBeHBi4B6JKEWblK3cFB3XUYrgIJ1uFufHkqU4az10bQotbH8ki2Ivs97iveAlstlvYcdL6KS77D213SufUm+mAJXmW6ABEJIwPrw89NMC9HfKT43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB6267.namprd11.prod.outlook.com (2603:10b6:208:3e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 05:26:40 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 05:26:40 +0000
Date: Mon, 14 Oct 2024 13:26:27 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Pierre Gondois <pierre.gondois@arm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, Hongyan Xia
	<hongyan.xia2@arm.com>, Chritian Loehle <christian.loehle@arm.com>, "Pierre
 Gondois" <pierre.gondois@arm.com>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	"Vincent Guittot" <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH 1/1] sched/fair: Update blocked averages on tick
Message-ID: <202410141238.aa194a45-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241011123222.1282936-2-pierre.gondois@arm.com>
X-ClientProxiedBy: KL1PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:820::30) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd3a1d6-bc08-4ee3-a9d3-08dcec10c811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GdSFIlH3c3pnRxUMuuCpyGQ5j/VSkTZLksG7r1pR4Cs9vTZgtRxKYTUS6/wD?=
 =?us-ascii?Q?w0iPM5l4GO5ul2/DiNFQ2X/qJH7eM8SIjdj8UmrN3pN6YN26KsVZGDT3TfyX?=
 =?us-ascii?Q?RPSXmk8uCp1qHTSMqZ1HDJRxGtFceYO3qkqed9CLvnAqetjT2sQHr3jGg0xv?=
 =?us-ascii?Q?XYYw+frFtzIzbizscXicmp00yt9gNnEXxuE+jMmtN8eth/eE5bdIkzN7O6zd?=
 =?us-ascii?Q?oZa+8kV412ezQRKrlmrD5WFK32uf7agzocQTUsoZrlfp6jp+I4qsGUjI8Pej?=
 =?us-ascii?Q?JD0mzHFwKbVhYWDK8F1/Nf66/Fl6/H0HvELRxGdDPd0g/6LYosMeSi4EvTSm?=
 =?us-ascii?Q?lOBdkG6N+JTySXqQCvH6ehtMeUXsXL8FuGp45o9cfXlEHrfeb4uv1u1rUaNw?=
 =?us-ascii?Q?64ylY7qVfiDZSvXP1/oyO4XKodvwJzux5cbXtuegl3tNKPjkXhPKl00/n0fS?=
 =?us-ascii?Q?VjBQKRTcLzlKqlHzCK8hBYyA/t/Xcn9Nkn140Ln4Hz3+KDFQ3DMpY/Q69hYS?=
 =?us-ascii?Q?Z2lcWwuwjxdKMMkcBJ0qCreVBrFhdsp/D2tTWp3AhbRVbe6xPP+fKAGhaIqp?=
 =?us-ascii?Q?451wrBCgDUF3a5VXXuTCRExIRrb0SL5er2nBYCJEmEiBx1Qw2QEmlpQevHzN?=
 =?us-ascii?Q?fww71Gyu9jewHaoZaOblTct7YztX0XHJExRSA/bz3emudOOgb5GREu3Nwruh?=
 =?us-ascii?Q?rp/zBv62Glheppvq5wCnhU1dLqlScEkGOW1b+N32mLt5JNjj4ZgYWvrvaz7+?=
 =?us-ascii?Q?TBRW8ZC5nUVLk06sjmFNQIS92ehtv3a7bKPThXb8+vTCmOrYjDJqg1Kar5Zu?=
 =?us-ascii?Q?28TZXi9twpI2RpQDzHfC/HcqDbN6iYYevALoZ5gNatNX3ZlB6q5pYBHuTeTh?=
 =?us-ascii?Q?U0oTjtXCcjg70dcjOlz43STceGtjdqmf3pzJzQ8jrvF9I+sZyeaC9nBZvehU?=
 =?us-ascii?Q?ZD0zsGTzDiESUB5HlhahKUqOZdUreisk5raaYZHYw1lSVsyOq5Zu9h28829Q?=
 =?us-ascii?Q?UoQsItFI5xjWTWksSXa3CfvuEzxGfpqerYHH6ASguCIGqOnbvFNsXA7sndmj?=
 =?us-ascii?Q?w80xVq8PufxiSYUbPNfIk214AH9PMArQM3Q/zV/e5e8uuGXnbGLXTfdzo7AL?=
 =?us-ascii?Q?H0bnipJ3halZiWxhQq++GZRsF/WGfcEY3kX/+qM9xoVD5Rw1ToJL1sTXpncS?=
 =?us-ascii?Q?tfWnTT2n3kZmS9fSrWCAEYifr4OaEIShyqZbM4gWkvF27Bj+KfE/QUe176c?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zeOb9wA7cFPo+HQ218ZR9GBw3v3BTTq8vS9xAvQGYevRDypaiibgij8Bazj5?=
 =?us-ascii?Q?URc6KIPmoPLetBRpVndKD2cQY5UmtHymDOodQlSLx0lM6ZrRac9jrr+UbqQT?=
 =?us-ascii?Q?BtHxSSFCw6PHr5VoB1BeVi2+B1InNohoXncgNytmR0Yd1WCjFovvrej+zO59?=
 =?us-ascii?Q?AWwW7kuhm+d/rWfhAncjlt/G1z6rdbeKpdYjCg1CbYj+qA4APCSwQhZWF29+?=
 =?us-ascii?Q?bJa3bEJWuhqh9FCq3hwuD+aEtdIj9lkTzVDgt/wg1mBWQjYlDvFoNpGSxTWY?=
 =?us-ascii?Q?8EnUTCnmVsy5ckaQHt1uwzPb/p2eZgbISP+9RYYcK/pdFSBbnSZTinc1oeWY?=
 =?us-ascii?Q?mfbsh5q46BUSs0ePX1MdlBGtKs8e/mPLqr8PxtdbV84S0KZDHdr6HAf9TY8M?=
 =?us-ascii?Q?v2RaMCCsdlHonW/2swA8XMH654Sc/p2BMDmiyRqC93Grp4KFbih2FwPyU+07?=
 =?us-ascii?Q?FBK2mcLd+q6mDxFKfGLjcQXskGRxJQ7ObfW+JN36bDbtGE9Untbs5oWgjZod?=
 =?us-ascii?Q?B3OOCpYdSKDInyk6W/kDXEYig+EdQP/DkD0z/LxVWkJGHgCBNG3fwaDnDYYU?=
 =?us-ascii?Q?L1TC1T1kc9vW1Lcs3clgz0+maO0tqyrUnYkGzbB0J1NuiVLtQNn5tB30GglC?=
 =?us-ascii?Q?EIO34hBPmd2EFwb6bDScahfcSzxaiDnYuLle8MECxLrJ/ToGMocS7MBvL16f?=
 =?us-ascii?Q?7AuUtYO+NU4AAn0cajvhsjq8650JDAJLHQrwiHZ/6IjQuciUxIdNDi/Gx7mE?=
 =?us-ascii?Q?OUXVc9NhhajezFF9ohmOUE/i+aI5iMhoA8RDfMzinIWZdQ7CjAyWC4Ijjavo?=
 =?us-ascii?Q?qC3kgCoAfisUy4AKOgBQfQua9TzB0lRTxJ4bX7AKUUiW8xBUEp43EDf24w4b?=
 =?us-ascii?Q?wjRTlUq9P16VsfgxSO8i6DaGAVpPcSPXgEZfYE01n05icLdUedLc2Hr6PgKw?=
 =?us-ascii?Q?yB6A3KkhZNCxSMOSsiGon1h62NeRIm8E6J3wQAsbMblbgFKhNz2YNOZWXH37?=
 =?us-ascii?Q?pweNeWsEM+pC8fmmaTbvohHDEBP6b81jJ+36mV0Adm7eewVTZ1YIGANB/rU1?=
 =?us-ascii?Q?gnVn+nNwN2KoFd/wZFGcUO39l48unYpyg816uUOMNrk3b1PEj5PrT+uS2k8F?=
 =?us-ascii?Q?/HnRcMDb7Ix1ULzjjj89pSOtkUxA0SIWdCllyWEaLS7/kSNSDzNY43ajITHM?=
 =?us-ascii?Q?FTJewVfFdMPhZCofaDMLoBaMPQQrtsG4rQrl1mFk4zO+5lDmB71oSNCKifGN?=
 =?us-ascii?Q?/6tbD2WpJP7t4d8tKceH/4MS79ro7WYBgMFs8EvK4GNABaxdhGahuvXpT1ts?=
 =?us-ascii?Q?+pOZOxEYCA4Nt1oZfSq43g2hOxB1pdTZY73Ol7pOgWuulFHvGUpZe+nR1Bea?=
 =?us-ascii?Q?DWZj9CBl/HopeHsG2Rk1gpoY/L+5sigVo2EKGjl8v2BiJLAAn5MqfnfNK00Z?=
 =?us-ascii?Q?27in9seq9MA8l/emUNAHwy6h6psui7/Gi14Jlf8ROZiEYPgEYt+whIWeT8MC?=
 =?us-ascii?Q?BeMvg96vHhSsB2ZljBimhIU/6subRmCzXWR72l+NoMJTUizZCAvOuhqk137h?=
 =?us-ascii?Q?/QtCkZN5+U1ipic7cne5UAt33XwrtYI+Y/ZgDybRDwf1H7Awqz0U2GSd3ZAq?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd3a1d6-bc08-4ee3-a9d3-08dcec10c811
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 05:26:40.3404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Cj+wU/bvQFbbx/QJOggHqZv40w6+5CilPprT0889W0fRB3LM/1DXk7Xj228+ZrCbR+jkpAC+mVH+OuZRGxcXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6267
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/sched/sched.h:#update_rq_clock" on:

commit: 8250cf6004de715b0abbbd5bf837d5ac869f1641 ("[PATCH 1/1] sched/fair: Update blocked averages on tick")
url: https://github.com/intel-lab-lkp/linux/commits/Pierre-Gondois/sched-fair-Update-blocked-averages-on-tick/20241011-203402
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 7266f0a6d3bb73f42ea06656d3cc48c7d0386f71
patch link: https://lore.kernel.org/all/20241011123222.1282936-2-pierre.gondois@arm.com/
patch subject: [PATCH 1/1] sched/fair: Update blocked averages on tick

in testcase: boot

config: x86_64-randconfig-006-20241013
compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------+------------+------------+
|                                                             | 7266f0a6d3 | 8250cf6004 |
+-------------------------------------------------------------+------------+------------+
| boot_successes                                              | 18         | 0          |
| boot_failures                                               | 0          | 21         |
| WARNING:at_kernel/sched/sched.h:#update_rq_clock            | 0          | 21         |
| RIP:update_rq_clock                                         | 0          | 21         |
| RIP:default_idle                                            | 0          | 21         |
| WARNING:at_kernel/sched/sched.h:#_update_idle_rq_clock_pelt | 0          | 21         |
| RIP:_update_idle_rq_clock_pelt                              | 0          | 21         |
| WARNING:at_kernel/sched/sched.h:#update_other_load_avgs     | 0          | 21         |
| RIP:update_other_load_avgs                                  | 0          | 21         |
| WARNING:at_kernel/sched/sched.h:#update_blocked_averages    | 0          | 21         |
| RIP:update_blocked_averages                                 | 0          | 21         |
+-------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410141238.aa194a45-lkp@intel.com


[    2.078083][    C1] ------------[ cut here ]------------
[ 2.079049][ C1] WARNING: CPU: 1 PID: 0 at kernel/sched/sched.h:1496 update_rq_clock (kernel/sched/sched.h:1496) 
[    2.080428][    C1] Modules linked in:
[    2.081070][    C1] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.12.0-rc2-00014-g8250cf6004de #1 dfe5ae60b9ab8d21e49756916bb824f564f72e7b
[    2.081391][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 2.081391][ C1] RIP: 0010:update_rq_clock (kernel/sched/sched.h:1496) 
[ 2.081391][ C1] Code: 00 00 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 c7 38 41 00 4c 01 3b 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <0f> 0b e9 52 fd ff ff 48 89 df e8 fe 38 01 00 eb e0 48 c7 c1 3c 21
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	48 89 d8             	mov    %rbx,%rax
   5:	48 c1 e8 03          	shr    $0x3,%rax
   9:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
   e:	74 08                	je     0x18
  10:	48 89 df             	mov    %rbx,%rdi
  13:	e8 c7 38 41 00       	call   0x4138df
  18:	4c 01 3b             	add    %r15,(%rbx)
  1b:	48 83 c4 18          	add    $0x18,%rsp
  1f:	5b                   	pop    %rbx
  20:	41 5c                	pop    %r12
  22:	41 5d                	pop    %r13
  24:	41 5e                	pop    %r14
  26:	41 5f                	pop    %r15
  28:	5d                   	pop    %rbp
  29:	c3                   	ret
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 52 fd ff ff       	jmp    0xfffffffffffffd83
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 fe 38 01 00       	call   0x13937
  39:	eb e0                	jmp    0x1b
  3b:	48                   	rex.W
  3c:	c7                   	.byte 0xc7
  3d:	c1                   	.byte 0xc1
  3e:	3c 21                	cmp    $0x21,%al

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 52 fd ff ff       	jmp    0xfffffffffffffd59
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 fe 38 01 00       	call   0x1390d
   f:	eb e0                	jmp    0xfffffffffffffff1
  11:	48                   	rex.W
  12:	c7                   	.byte 0xc7
  13:	c1                   	.byte 0xc1
  14:	3c 21                	cmp    $0x21,%al
[    2.081391][    C1] RSP: 0000:ffffc900001e8df0 EFLAGS: 00010046
[    2.081391][    C1] RAX: 0000000000000000 RBX: ffff8883aeb396c0 RCX: dffffc0000000000
[    2.081391][    C1] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: ffff8883aeb396d8
[    2.081391][    C1] RBP: ffffc900001e8e30 R08: ffffffffb6af076f R09: 1ffffffff6d5e0ed
[    2.081391][    C1] R10: dffffc0000000000 R11: fffffbfff6d5e0ee R12: dffffc0000000000
[    2.081391][    C1] R13: dffffc0000000000 R14: ffff8883aeb3a158 R15: ffff8883aeb3a088
[    2.081391][    C1] FS:  0000000000000000(0000) GS:ffff8883aeb00000(0000) knlGS:0000000000000000
[    2.081391][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.081391][    C1] CR2: 0000000000000000 CR3: 0000000182a4c000 CR4: 00000000000406f0
[    2.081391][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    2.081391][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    2.081391][    C1] Call Trace:
[    2.081391][    C1]  <IRQ>
[ 2.081391][ C1] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 2.081391][ C1] ? __warn (kernel/panic.c:748) 
[ 2.081391][ C1] ? update_rq_clock (kernel/sched/sched.h:1496) 
[ 2.081391][ C1] ? report_bug (lib/bug.c:?) 
[ 2.081391][ C1] ? update_rq_clock (kernel/sched/sched.h:1496) 
[ 2.081391][ C1] ? handle_bug (arch/x86/kernel/traps.c:285) 
[ 2.081391][ C1] ? exc_invalid_op (arch/x86/kernel/traps.c:309) 
[ 2.081391][ C1] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 2.081391][ C1] ? update_rq_clock (kernel/sched/sched.h:1496) 
[ 2.081391][ C1] update_blocked_averages (kernel/sched/fair.c:9720 kernel/sched/fair.c:9845) 
[ 2.081391][ C1] sched_balance_trigger (kernel/sched/fair.c:12887) 
[ 2.081391][ C1] sched_tick (kernel/sched/core.c:5617) 
[ 2.081391][ C1] update_process_times (kernel/time/timer.c:2526) 
[ 2.081391][ C1] tick_periodic (kernel/time/tick-common.c:102) 
[ 2.081391][ C1] tick_handle_periodic (kernel/time/tick-common.c:120) 
[ 2.081391][ C1] __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1044) 
[ 2.081391][ C1] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1037) 
[    2.081391][    C1]  </IRQ>
[    2.081391][    C1]  <TASK>
[ 2.081391][ C1] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[ 2.081391][ C1] RIP: 0010:default_idle (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:92 arch/x86/kernel/process.c:743) 
[ 2.081391][ C1] Code: 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 72 ff ff ff cc cc cc cc 90 90 90 b8 0c 67 40 a5 eb 07 0f 00 2d 9f 89 47 00 55 48 89 e5 fb f4 <fa> 5d c3 66 0f 1f 44 00 00 90 90 90 b8 0c 67 40 a5 55 48 89 e5 e8
All code
========
   0:	00 4d 29             	add    %cl,0x29(%rbp)
   3:	c8 4c 01 c7          	enter  $0x14c,$0xc7
   7:	4c 29 c2             	sub    %r8,%rdx
   a:	e9 72 ff ff ff       	jmp    0xffffffffffffff81
   f:	cc                   	int3
  10:	cc                   	int3
  11:	cc                   	int3
  12:	cc                   	int3
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	b8 0c 67 40 a5       	mov    $0xa540670c,%eax
  1b:	eb 07                	jmp    0x24
  1d:	0f 00 2d 9f 89 47 00 	verw   0x47899f(%rip)        # 0x4789c3
  24:	55                   	push   %rbp
  25:	48 89 e5             	mov    %rsp,%rbp
  28:	fb                   	sti
  29:	f4                   	hlt
  2a:*	fa                   	cli		<-- trapping instruction
  2b:	5d                   	pop    %rbp
  2c:	c3                   	ret
  2d:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	b8 0c 67 40 a5       	mov    $0xa540670c,%eax
  3b:	55                   	push   %rbp
  3c:	48 89 e5             	mov    %rsp,%rbp
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	fa                   	cli
   1:	5d                   	pop    %rbp
   2:	c3                   	ret
   3:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	b8 0c 67 40 a5       	mov    $0xa540670c,%eax
  11:	55                   	push   %rbp
  12:	48 89 e5             	mov    %rsp,%rbp
  15:	e8                   	.byte 0xe8


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241014/202410141238.aa194a45-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


