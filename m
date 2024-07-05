Return-Path: <linux-kernel+bounces-241879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D789592809F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 04:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065921C22E47
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DFE1CA85;
	Fri,  5 Jul 2024 02:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FjT299E4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22F64776F;
	Fri,  5 Jul 2024 02:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720147968; cv=fail; b=NuFGnLZX1D7GMwscbq5DQrkDLt8jxYbsv91Sn/w4VoPDW9BQgkq62wXbjhoiH9Q5wTkWsvYjkt0noQGNWS2FjXldTcHrFCnkaBPpp9ZRQ2ESb50mwBkmFIy9y8xSkk+INO5mZXzmvJtblRbFwttkKh6Wc2odIvep0vnJEFGL48Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720147968; c=relaxed/simple;
	bh=T7gIcbnMVodB45pdiFrbRQCeee1ugOCnSIyShw2+q3E=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DZX2gPwG2gDkMviu34fORlJmywDRHWAcqhRaSogojzbtMoaNT0Yrh1K4XPbRj8lcqBDXIqTC4H1+7rjr+dl0v0f1ilt2qD2b3ZflPpD6eM3xKpc3VBsBfhniuBbOdYvYgIbId5vDJCv3thw2ZZk3Lc1xJsCiEpynQz7fyeaJLoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FjT299E4; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720147965; x=1751683965;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=T7gIcbnMVodB45pdiFrbRQCeee1ugOCnSIyShw2+q3E=;
  b=FjT299E4uTRc7plHi5e83l2DUOND9siqa/4Lw+HcrdX1iWCZxbq0wk07
   QQnh72eULMk/iy9fGrCLtCtRtWVthMV4s/ce9HfLDDGgpQh5YlYZImsMp
   RtjweWTBbDXmbnEdJAyyqzj54LyiHrcYikHx93vxqFGyWp80w5o2DoTVx
   tUmAus6dQOKoleNFduwZzs4GeA8qDDjcjIR173sSathme0wEewHDvcH/q
   MhimiRsxMK7L/mKsGM36gk+5cXXWMwChha0Ph9Koa6F9HuyKOZv89UapR
   kXGae2hLHpzWrGuz/2CT+r5HHTmgriZbRxanCZ6H3iZ80jPwnSqatdvXT
   Q==;
X-CSE-ConnectionGUID: 8HB9ic10S2Oyv1gw5TOxzA==
X-CSE-MsgGUID: ZeJG53MfRUCKbEXmpklMPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="42855267"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="42855267"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 19:52:44 -0700
X-CSE-ConnectionGUID: R2PUidqpQDCkjh4wSonpsQ==
X-CSE-MsgGUID: c3UJcfoBTVG4Sxh+6Lhkfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="47396738"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 19:52:44 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 19:52:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 19:52:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 19:52:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 19:52:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lU1tWiuPRGGBIEp8EmcS9CCSAO+tpvlB0THDs1l63eZ/iXBCKnLGjbNxdYbbebxjeXF9+BkwIXoIWOQl2rBIi7hfrTVRihvaK38Z4fNvN3qFPzmDsP6yh/v9pPD63EAHfzK9UpbVMMmdYfYrdmtAnt0adFkWx1/N5gJUbhvbxE/1XrnN2ZttzJYQJgGikgnm7y7MqNH9c274VelnjUARmZtoLfiNtIZDDzgPQXP0n1f8yIyWo83eeGSrNTobbZiRCMGCIF1oTzQMkbnN5I9vA433Kv7VT2vFxLr3KBD4CLPMQ2qzhTuLQ6cXWfoRxXkNgpeZ6axb06VVUTiDKc1Rsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVxjThWVCG4Hn86SrtnHSlixNETy7W6FBmcV5jOT7Lo=;
 b=Q+/qsjpfLHZWsl8uy6jwtE6mlXcnB7ncFENslhEF50EvzxOdY+Odpj/GE9M7nzkAlDRXomOGSujvwk8zBmUyMJUALnNGgGXMuRRpyTvOjJUiJORSCCVIUNa7j9iA3zE6pguK3vJ6bQt0TQ5zhLwDQCWjWEc9ZXSqp7JC97BM0f9KjWJ+SB0lQFmwBJKy9DzTY/2/wzytVjWtz6+0Xnb5CzvVKhIEd6z6trEYAYTCzWPSxnt+skTF0CzM4p4Jjn+rZijb+B13zInI8aYBBoinE71PVlfcM01Rekio95nvUu0pWnOlqZ+00epDV07cnlQ5ZzBux/ZiJdr5qwVG+681AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB4685.namprd11.prod.outlook.com (2603:10b6:806:9e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 02:52:40 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 02:52:40 +0000
Date: Fri, 5 Jul 2024 10:52:26 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Maxwell Bland <mbland@motorola.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, "Ard
 Biesheuvel" <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, Maxwell Bland
	<mbland@motorola.com>, Alexandre Ghiti <alexghiti@rivosinc.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v5 1/6] mm: add ARCH_SUPPORTS_NON_LEAF_PTDUMP
Message-ID: <202407051002.96bf438-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <yrgrhwfbl7rnmgekiolmojutaqf24x5zphyrwijakzma5pjhre@3yncjv5tqvar>
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB4685:EE_
X-MS-Office365-Filtering-Correlation-Id: c3088936-d94f-460b-7457-08dc9c9d88bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5SVXjvLyq+ALdl1D9Xyy2YTFzhl4lDmLdmrCSIu85IBRIyF4lX3QWfhij/M0?=
 =?us-ascii?Q?FMUqMJZK56cNKmfY1w3QPVo2nUWQf/JoNo/jlu9GtyEPpiCOe0jTKSHLPLAz?=
 =?us-ascii?Q?wipElL0xiR6mdRzW7tCdy5D2AUjNRjtCVdkVx0IVmbeMLLG978TQ0VIWO7oW?=
 =?us-ascii?Q?RPB2WmXBOqi4Ee6JZ4jByT+yCeSk42IZ+CwreFhN7zX5tGNwHHynvXNdHb48?=
 =?us-ascii?Q?EqWMIYI4wzGDRQev/KYXiKPESVBOm2fbY9tIwIDXEaKLs6co2ypoWPV+6Z1t?=
 =?us-ascii?Q?5jIKeRs9JrJcpyV0nzOS7rI/DSU1fHe79G/EoZFNUKJ7bd0Y3VJXjMXcSSAG?=
 =?us-ascii?Q?FrKRyNIRwJCLSNC9+6WBlvqznfS/cW7Jn6EalJ7ZHGPqsdBbiejFV2Ps4QEJ?=
 =?us-ascii?Q?BvZbqy6iFMZWu/PBp5Q1zL4ehYEtdkfmEAQ0b7YTK2SKLEPFyo44Kqy4XXB6?=
 =?us-ascii?Q?mS352QKIGNYK2MECumUc7agFguF8t0tghg3rysCl6Sd3MOSjWWP3tV//LYIl?=
 =?us-ascii?Q?5P6ts/TYMI1QJKfDVuZxXF61WDXr3Hxun/CgIy0EqFApnbJjhogOM/T/nJdk?=
 =?us-ascii?Q?wZTZx9WLBtRMW/aiQ6dUuBGe1IkbdsPmTugj0UYQuX/ndMipRSvQigTFKddn?=
 =?us-ascii?Q?mefKcgSUcXBGsRyNbcC2kMdfzqTcoabPMiAY0Xu2GicG0c9hXqbsEs5+F81P?=
 =?us-ascii?Q?5xm1uqln7xVTMCRr+gsZI8ChCjiE+hHmJxttYEadoDiiAwTURHyuG21Lj+DM?=
 =?us-ascii?Q?6bqXNoPCldRFhLBIN1oH0cDBulCUwKC7mmeXeO8JEHH9e6nVWKni2O70pDR2?=
 =?us-ascii?Q?YzME/kBRkW57RSIUHEDXAhJXGjwWMDVcIPjShqwc562f82bZVs3lSdxDrRqc?=
 =?us-ascii?Q?rk7N2QR38xjWZoiBabW7YBUp4yr9Pw7WYpq4HxkkFWShq7Rcp3CNgWEYUwZ7?=
 =?us-ascii?Q?2q6wtLh0sBe/6IyZ2ZmdP9T+MhCUL1mGgryd5TZHyPn3sJduQye+1oaF8LVt?=
 =?us-ascii?Q?20Roz0d0Lo9o88PrXf3wQw1xodzZk14YQovHcC8wCR9JvnU0GdVSzQ7O8SCX?=
 =?us-ascii?Q?50wo43R5EN6l1XEjGsjZczEefqaJdrysUtNAK7PUXjDjr86zYAhUi43PVvSi?=
 =?us-ascii?Q?vVhRMzlGXqXt4mfgS7hiR8MV19Y6w3XgYyLoaeF/qEbEtd6QWLvLeiTSh+d5?=
 =?us-ascii?Q?g/1qg3jSYe6PYNAHcbJbyGu4cXgd4MPX+K7OrqUzizWc0VonKOd+E2hMVpMm?=
 =?us-ascii?Q?g0AOyaK/3aaL5ymYJL2zUtLyt/VEXNwqWh3J5W6jQqbaQCRddvVoQxRIRVHd?=
 =?us-ascii?Q?Gh5Pvc8jiGzoNDXEhSPZTnyq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pAu5vsRiegwVueGYQM3jksa5eNVbKCtdVdI1KfcoAELGAGdp3yrrMp8ewIeb?=
 =?us-ascii?Q?RENjuyC9Ob589TcDJi86g0TFL7C0OeMKa9mozPp2OuLv0fqu6ktrpGBzvt8u?=
 =?us-ascii?Q?jWK/5Z+5FA3VR+rga5JX6glCiBgPeXoI1wAYUjRVFF30fsHorza+bg7EbL27?=
 =?us-ascii?Q?DGRwcz8zV35vzrP/I6PQgqwnkt0ysASFxOCb/hSfJDWHZFb39vALXEnN6O29?=
 =?us-ascii?Q?vH/bU+9k2TPVS5CS+elsEp/jE56q4S5ldewNwPnf84JpiWaanhBhCbg8tz7U?=
 =?us-ascii?Q?6DINtIvY4D0Ia/XqwYdCCESFx89CpWu4YEBn752dGNHbfeZbxTK0mQO33VsC?=
 =?us-ascii?Q?pCZW83Eht5uy2/BNbdzjqoz+aJ1oobxLjc983Hh/CJZ41AQ6Ver4fSMqAHik?=
 =?us-ascii?Q?RHbo9QOZT96juReGumviO0p3OSYls7SUmf7gXjGBF6PeHQf9DYt6u4ACph1U?=
 =?us-ascii?Q?Od0KMs9wc8ejzulVPw5v22QKDtf6HIDxxZkU/XJKsb8bsISFeMAfQQXvL/8y?=
 =?us-ascii?Q?E4KM3veM8Kq0bgMc4uikp1Et0UGQiI6nh4N+0Vx3Dz+EN8MNaRJJeKrlhgGl?=
 =?us-ascii?Q?TF1QanNwDxH0B0sQ0FDpHl7W0wCVXApVGn9D3fieMPdbyxuoNkUMETcrOLkr?=
 =?us-ascii?Q?oXr32qYcRKgITsZcQsPnKzQf+wzm9HIdRxoOabehgQ954gqwUY6UiDOvLh1u?=
 =?us-ascii?Q?CSNFacSMlF4i09mnh5es56sE+BTFsrDL6du4MHhr3vGsSdxHf3lLpl9gj/cQ?=
 =?us-ascii?Q?FsC71anTIFR0K6MCOGEfCDVCJr87jGGw2nywAYYCz+VPKK/yRcmLlMiaLQw2?=
 =?us-ascii?Q?U4KmFm8hCg6jqYF7Bg8YPnZeY8NdjS3xx4uVha8kTdwNeOYFm7qQSphka8G+?=
 =?us-ascii?Q?dxAV58/YcHloCkTlHp42CS6E/SOsfsDjnGm39Cn8VWTNDcyNFw7CAUcqsyAR?=
 =?us-ascii?Q?An0dZLNxvmlrCYcUoApwucwIfVoDFl1ATWkDcFH5SfkdayQcEMzEh6Q/ur2v?=
 =?us-ascii?Q?VIBJ0+zqpbdFvMIB7kpamOKOoxH6JCd3VzfJKOt4PgzqhVByOfogkB2NZVVM?=
 =?us-ascii?Q?fNClxY5lu7EmnjFGMO07WceCY/mZ/dbSdGJHFwVZ3IjVwBKq5YRwtAobn0Zs?=
 =?us-ascii?Q?AqnaKQuMita24czL7WvbCj03cejfNiq/mp/OLRLV5iO6qMlztxkxeQPWuRC5?=
 =?us-ascii?Q?XD31D0dkKVwwOKTdatyWlDNBUmiulC7afJeURgXurlRBxMT9gdVXwjxCepks?=
 =?us-ascii?Q?OBXnPYlicaBe5/VLuTa32ohLg47nE0ZUVpMHN8DoV/m1dwBvVkX31pyciI4P?=
 =?us-ascii?Q?iil6hHHpIa+D75YISWI56X8XIHm2GzmfxRBxjnT/Eyw9uxybTVJXoy1ozDbb?=
 =?us-ascii?Q?NLlqIRlX7M6B1pBtOU7shYurTKuFd56xqNR2raTqrhi9Aq/lfVkFpgJ/SL1z?=
 =?us-ascii?Q?iEA1a+o2UjHrMKzgG8tBpWFzcDSttUJqydqmPNL+EK5OHN7TyMJKbv25Mskv?=
 =?us-ascii?Q?5k1n48qg0qMzZBpxylUx6FDt7REwT9AFnRoux7YeKMlaWj+5PSFk1lMGw+HQ?=
 =?us-ascii?Q?rYzMOKBuTiQYi+9QKDCQzVdKl6vjHf3KPWcAAjDByqi0MtN5uO+Lg+7gTur1?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3088936-d94f-460b-7457-08dc9c9d88bb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 02:52:40.1112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSDjQLNMJmYIDhrehrHNhAfXWckVUDSaUzDh20gCwNK39BAaLkB3Ekwu6ERwkCIOnHOc3uK+8r399F1shmzu6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4685
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_arch/x86/mm/dump_pagetables.c:#note_page" on:

commit: 14095f3901f4e6cf7be49ce2b0b6477bcc9613b8 ("[PATCH v5 1/6] mm: add ARCH_SUPPORTS_NON_LEAF_PTDUMP")
url: https://github.com/intel-lab-lkp/linux/commits/Maxwell-Bland/mm-add-ARCH_SUPPORTS_NON_LEAF_PTDUMP/20240626-022827
base: https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git for-next/core
patch link: https://lore.kernel.org/all/yrgrhwfbl7rnmgekiolmojutaqf24x5zphyrwijakzma5pjhre@3yncjv5tqvar/
patch subject: [PATCH v5 1/6] mm: add ARCH_SUPPORTS_NON_LEAF_PTDUMP

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: srcu



compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------+------------+------------+
|                                                     | 39b9075172 | 14095f3901 |
+-----------------------------------------------------+------------+------------+
| WARNING:at_arch/x86/mm/dump_pagetables.c:#note_page | 0          | 12         |
| RIP:note_page                                       | 0          | 12         |
+-----------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407051002.96bf438-oliver.sang@intel.com


[   12.539216][    T1] ------------[ cut here ]------------
[   12.539661][    T1] x86/mm: Found insecure W+X mapping at address 0xffff8a0000000000
[ 12.540267][ T1] WARNING: CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:248 note_page (arch/x86/mm/dump_pagetables.c:246) 
[   12.540995][    T1] Modules linked in:
[   12.541300][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 6.10.0-rc3-00027-g14095f3901f4 #1
[ 12.541987][ T1] RIP: 0010:note_page (arch/x86/mm/dump_pagetables.c:246) 
[ 12.542465][ T1] Code: 0d ba e8 2a 28 0a 01 e9 78 fe ff ff e8 a0 17 1a 00 c6 05 e5 bc 72 02 01 90 48 8b 73 58 48 c7 c7 00 91 16 ba e8 08 d2 08 00 90 <0f> 0b 90 90 e9 5f f7 ff ff e8 79 17 1a 00 89 ee 48 c7 c7 f0 34 46
All code
========
   0:	0d ba e8 2a 28       	or     $0x282ae8ba,%eax
   5:	0a 01                	or     (%rcx),%al
   7:	e9 78 fe ff ff       	jmp    0xfffffffffffffe84
   c:	e8 a0 17 1a 00       	call   0x1a17b1
  11:	c6 05 e5 bc 72 02 01 	movb   $0x1,0x272bce5(%rip)        # 0x272bcfd
  18:	90                   	nop
  19:	48 8b 73 58          	mov    0x58(%rbx),%rsi
  1d:	48 c7 c7 00 91 16 ba 	mov    $0xffffffffba169100,%rdi
  24:	e8 08 d2 08 00       	call   0x8d231
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	e9 5f f7 ff ff       	jmp    0xfffffffffffff792
  33:	e8 79 17 1a 00       	call   0x1a17b1
  38:	89 ee                	mov    %ebp,%esi
  3a:	48                   	rex.W
  3b:	c7                   	.byte 0xc7
  3c:	c7                   	(bad)
  3d:	f0 34 46             	lock xor $0x46,%al

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	90                   	nop
   3:	90                   	nop
   4:	e9 5f f7 ff ff       	jmp    0xfffffffffffff768
   9:	e8 79 17 1a 00       	call   0x1a1787
   e:	89 ee                	mov    %ebp,%esi
  10:	48                   	rex.W
  11:	c7                   	.byte 0xc7
  12:	c7                   	(bad)
  13:	f0 34 46             	lock xor $0x46,%al
[   12.544127][    T1] RSP: 0000:ffffab0600013c40 EFLAGS: 00010293
[   12.548776][    T1] RAX: ffffffffb85090a7 RBX: ffffab0600013e38 RCX: ffff8a1f806b8000
[   12.549432][    T1] RDX: 0000000000000000 RSI: 00000000ffff7fff RDI: ffffffffba63a550
[   12.550073][    T1] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
[   12.550737][    T1] R10: 0000000000000000 R11: ffffffffb8ca1100 R12: 0000000000000000
[   12.551383][    T1] R13: ffff8a0000000000 R14: 0000000000000067 R15: 0000000000000067
[   12.552048][    T1] FS:  0000000000000000(0000) GS:ffffffffba45f000(0000) knlGS:0000000000000000
[   12.552780][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.553335][    T1] CR2: ffff8a22bffff000 CR3: 0000000102c30000 CR4: 00000000000406b0
[   12.553993][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   12.554730][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   12.555398][    T1] Call Trace:
[   12.555676][    T1]  <TASK>
[ 12.555924][ T1] ? __warn (kernel/panic.c:239) 
[ 12.556257][ T1] ? note_page (arch/x86/mm/dump_pagetables.c:246) 
[ 12.556625][ T1] ? report_bug (lib/bug.c:?) 
[ 12.557009][ T1] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 12.557371][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
[ 12.557760][ T1] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 12.558171][ T1] ? io_serial_in (arch/x86/kernel/early_printk.c:121) 
[ 12.558591][ T1] ? __warn_printk (include/linux/context_tracking.h:155) 
[ 12.559010][ T1] ? note_page (arch/x86/mm/dump_pagetables.c:246) 
[ 12.559384][ T1] ? note_page (arch/x86/mm/dump_pagetables.c:252) 
[ 12.559751][ T1] ptdump_p4d_entry (mm/ptdump.c:79) 
[ 12.560149][ T1] walk_pgd_range (mm/pagewalk.c:250) 
[ 12.560567][ T1] ? lock_acquire (kernel/locking/lockdep.c:5754) 
[ 12.560941][ T1] walk_page_range_novma (mm/pagewalk.c:589) 
[ 12.561367][ T1] ptdump_walk_pgd (mm/ptdump.c:167) 
[ 12.561761][ T1] ? rest_init (init/main.c:1459) 
[ 12.562131][ T1] ptdump_walk_pgd_level_checkwx (arch/x86/mm/dump_pagetables.c:395 arch/x86/mm/dump_pagetables.c:444) 
[ 12.562636][ T1] ? ptdump_walk_pgd_level_core (arch/x86/mm/dump_pagetables.c:276) 
[ 12.563115][ T1] ? note_page (arch/x86/mm/dump_pagetables.c:252) 
[ 12.563477][ T1] ? rest_init (init/main.c:1459) 
[ 12.563839][ T1] kernel_init (init/main.c:1483) 
[ 12.564187][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 12.564550][ T1] ? rest_init (init/main.c:1459) 
[ 12.564897][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:254) 
[   12.565276][    T1]  </TASK>
[   12.565526][    T1] irq event stamp: 789373
[ 12.565883][ T1] hardirqs last enabled at (789381): console_unlock (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:341 kernel/printk/printk.c:2746 kernel/printk/printk.c:3065) 
[ 12.566712][ T1] hardirqs last disabled at (789390): console_unlock (kernel/printk/printk.c:339) 
[ 12.567498][ T1] softirqs last enabled at (789142): __irq_exit_rcu (include/linux/sched.h:2189 kernel/softirq.c:620 kernel/softirq.c:639) 
[ 12.568260][ T1] softirqs last disabled at (789131): __irq_exit_rcu (include/linux/sched.h:2189 kernel/softirq.c:620 kernel/softirq.c:639) 
[   12.569027][    T1] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240705/202407051002.96bf438-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


