Return-Path: <linux-kernel+bounces-201227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2580D8FBB3B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6237B22178
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA8214A0AD;
	Tue,  4 Jun 2024 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4IATsFe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3CD149006
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524438; cv=fail; b=lCacQfxsXbaQRU0L8rKIsiitz+S2uJGyTROjMUAEMW7EGrq7fSsqowogbMtd0RyG1sfkFAMb0LEIfgcNP2nvGn5rJD32cSUWLPnuiJVMr4wrCHIlCLnoYzAJAwQbxkllseYKWHfgQX1ulWsm003CXacY/XcCg7jZuJkMe+FpZVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524438; c=relaxed/simple;
	bh=A3LmQxNdPK70AlYLx7N9li3knNC4Psb5GiCl9roHDA0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hkb4twAcrSFRNV8zxH9Aa7rze4RIyqFhuRrv3gqmo1iS21MWgH+LX+iP7UcaTRXe6Eswvp0zpjdm+tc+Odb9tlyUBKHuwn3lDi+VtTPgEcCWOx0i/rLWfiqQ+TXei7XAKj75KcHMJXwzitfEPyufPIPsjwZEOvmPkvFna6r6lMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4IATsFe; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717524437; x=1749060437;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A3LmQxNdPK70AlYLx7N9li3knNC4Psb5GiCl9roHDA0=;
  b=i4IATsFeC0dK1l+DmwVYl9VtBDcQ8CUiDW9MaV1TL5gR31L7As89d2Ry
   DKXkDq28R3naPH/wUlayBjKrgwFcs1ttqoknKFOs3440iJDQXZOmlKAYa
   /WiA3fw0DHsqq20aw78JIwIo5ZGkhBhJJp4iTgPBTzKfiPeGxB0jMf4xX
   044TivMray6lW6hTX0CBLAm4h4Y8IxOfiI4PYe+p3uBUQglGbNBGgUeuo
   3a8n4vQWDcvYLKqb0Upl9mivj105gTpX5Lf0h3ziRW2m5IH2gzmffiZJR
   tzttX8WW6quVh1psHrgyvQ52J+n8K74dEZ/OkztxHbkkVYJilyQgJXHtH
   g==;
X-CSE-ConnectionGUID: NrS8PNeZQYGagRvYgcycwQ==
X-CSE-MsgGUID: KkVrZM/xQ6mxU/JaFvl5ag==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14249235"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="14249235"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 11:07:17 -0700
X-CSE-ConnectionGUID: EUbtak34Tb+1jcrkA1WHUQ==
X-CSE-MsgGUID: v6KR2SFsR2usuykKv9Xocg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="68136654"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 11:07:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 11:07:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 11:07:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 11:07:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I55esyOgp/jSrxxGpdjAjwyuckMCNr5wmDZR+iLdGz4yWUSONENgL2/sGCP61YPaRYsiPs3V2uHaouCeqwVmnLNAc76axumCzjLvvh19MO5Bc4brCTaynDsdxUtHpRJ9HsB4pBVontVBhWD5SXSOhIB7GiH0r0tTySxhE8p+LfEu2b6ZLsz/wM/3Z7jo1DkzUFPT3pGTQxrHDEpSQ7zEMGOl8M4bS8X6YYp3mTHw9KAYkq597Nz7g1/35M2elrepn2hkVsa+gvCCYouTamD2UeuVaf2Zi5NWxpWKXVSWRPtJHBC/71CYFM/wdzTRjxkNYw2lWWXg+trWQIWBalsqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/dKO+g1TqJdoSCLWTaES8InHkrkdvUeAi+aYRLmRmQ=;
 b=Wj47jdIWKw56ESocU550Ux+OnHOskPUEZfAz4Bj0MY1opUyc3E0aeRpCn/VbZ5z4uoINfO2t8QWbkky2nMcAyCnX4c/oM0vZiUDNpcNC2gtY8O8OWPz5daK5hu71Z/JWZyyJmOw5OLag9gOrDnqp+ard7Q4puFsKg/Xw2A56cknfdt7SZAQ50VP2ewc6/9E+otMKMSp4bz9eQ76xa1aJOB2KzOL4Q0MckQOYIrkAMTSxwjoAs98tBJevrcu7VPkUg7ttrvGxVhOAT061lg1UWzbq5T7LzeplI8qCPWqnF1LLRb6+Jn7tA6A++iZwfRMjglyjMbV106H9LKkwy87Adw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SN7PR11MB8041.namprd11.prod.outlook.com (2603:10b6:806:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 18:07:11 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%3]) with mapi id 15.20.7633.018; Tue, 4 Jun 2024
 18:07:09 +0000
Date: Tue, 4 Jun 2024 18:06:22 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
CC: <lucas.demarchi@intel.com>, <ogabbay@kernel.org>,
	<thomas.hellstrom@linux.intel.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/vm: Simplify if condition
Message-ID: <Zl9XnmJQMjeNDtko@DUT025-TGLU.fm.intel.com>
References: <20240603180005.191578-1-thorsten.blum@toblux.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240603180005.191578-1-thorsten.blum@toblux.com>
X-ClientProxiedBy: SJ0PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::22) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SN7PR11MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 38bed736-53dd-4b30-762f-08dc84c1267f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2UKlkcgOL1whPJrjLgA5SXPw0+XEYBaktDkUuF8EQiAaoMBL1pXYT+J6OkCX?=
 =?us-ascii?Q?hmLpT36F1AvPcRknmkMRkDv0Sx7dxdc5HsbrCLOVqn0WvBx3GD+XeFyLeB40?=
 =?us-ascii?Q?VODPPoocijZD6rqrIGU8Vue4Gv6eiEUOlHWTD3V87jIKITxR1n/peXOcM+in?=
 =?us-ascii?Q?MDAIhABJCHEy7n1+LJl7QFgIosEQ3cUCAKLjCySu9yIZRfUW1sf81jnAx49V?=
 =?us-ascii?Q?YSp7TvLQyJoJlfddCH/8stpfgFa0BJSJgqRBy9BxqgFVDMpJqN0UhtzIfb/E?=
 =?us-ascii?Q?KEenFfXIsN5lwYVYdt6uJQzTcuREp0TcmLM/sShMs210RvMYE8qjId6l3+cX?=
 =?us-ascii?Q?nzMMqk/x/jFWMSPteEaXo2POqUj2oxrFOXVRNdSb3VDzH+4AeuKFEb4e7Gt5?=
 =?us-ascii?Q?rCaeDYN+9zG31RQY48f0u4lnAiqmGku4N0rqVswE4gCpTiBnS4YPhXvtIRQQ?=
 =?us-ascii?Q?ifwjwJ++pmIoVvqZi5gotv2VFJRdwNTXFlNsq/T/Zantx2ZO6TuxkKJBe1Ia?=
 =?us-ascii?Q?fMFV6arqb8ee8bvLbL+kquOg79+zMUIPK9HrGE3aY265bijAqaGwS+GKkq81?=
 =?us-ascii?Q?OAsZq5eiVxOBUN3SFdCBaOrubWAzngPVDw/Co8onrLgzChnkhA/FotHPCCDi?=
 =?us-ascii?Q?1FtwLrqYcGptB1P+yjrKsPkn19MJQSKPRUZdwsB8fIMVtKTE2f5c6uEbKldK?=
 =?us-ascii?Q?3qosCoV2FzTaB09KOVx7lUsV/fxed70J2B2QJM1khXXZ0tlfRA0KOCm142G4?=
 =?us-ascii?Q?VvMiMfWFDyR+g1HW2VZh3064YslqrxI1Gtpqr//6tIrQbYIospebPcvQZ2xI?=
 =?us-ascii?Q?tAUyYasZSHk7CJJsNCXOU71V5msnh5fJHonSoucKoRYPj2FY7Owg1gr8DROI?=
 =?us-ascii?Q?xvp3RHBzVYdMernW9ehf/Ho+I3F+KwBl859zmDlIXFimp3Hbmeo3wO/TxZ7C?=
 =?us-ascii?Q?8Ll+o9NAQT1JVuXSxN6QqPuv5SPtDvnENmM+4uFpDObTNLAOpyC0z+9r6Jfb?=
 =?us-ascii?Q?sq/uMZoEefyXrhbo9AK9QbQx+qD9CKbyVETzoHN4ImiR5TtgY8IHCJuK01/j?=
 =?us-ascii?Q?2xV43R5YfgqlznsjH2JlHSAp5vhuAvw9S4Iq3dbFvF7mbgJSWGGiEOC14myi?=
 =?us-ascii?Q?dUURW2qfP816V+PK7clm8jhvRl1a8C8RIo4ksOnOXb3XrNK4Ch9xFbB6y+jg?=
 =?us-ascii?Q?OSCvbVVyALI6D6hI65S4T2pYfeZ7SU4+28L/P1JIDPJPv4w0gz48reRQLMj0?=
 =?us-ascii?Q?PZ9Upkq9ocbcP5ygV/6mmtMG85bnx2G/JLjLG5iJSA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Pibme7Ex4ivVFZXiHfodvIdwtNnxoGrLEXlQuh6VUsFXyJbHVpDOvyfc60b?=
 =?us-ascii?Q?NXbI/fIz33YZwtGUfTHxL2tY+kkOf+PQZkbErHVHn7taY971NbeZrIdvIjFh?=
 =?us-ascii?Q?1x2/WrdEXr4sa2aVO1Lt7G4SVMuD/jo/gdBGcoJKioFMb7GN7Vh2ebOHMPUH?=
 =?us-ascii?Q?NZpOfqHp+ALUMu9bDxuMS1xxUSnOPwS92gAZbjLRvtiau2wCMB11BLJvsdPp?=
 =?us-ascii?Q?R2fzB4TrUS79CaqUwHGILcWSLKGDRxr8cYIEfP8GTJY7pxk2yON4CvNvnJjE?=
 =?us-ascii?Q?rz9ZAFhMKjVcOeAQUKUF0Bs81uPcd8jJJTjhf5MWV8sDIXxmz8kRqgHN+B0r?=
 =?us-ascii?Q?saiX0cVUhC1MgqKE2e0ov0CfOKcNKJPjAMe0Er8BUsMKX8Ghkvindo3G/6pS?=
 =?us-ascii?Q?Vx/fMFUcZIj5newlCagWbiY1Mk4uMRKX6mmS9xcLjz15ckBJ09Vc8a6gBpiL?=
 =?us-ascii?Q?NGPvr1U0qw/rP2NkCXiZk2j1HpLwZwYb91OJeU7BstjSGBvX2ckFc5hNTWYy?=
 =?us-ascii?Q?RUligDDwo0JmRkl4okznSey6L+TPw5VYCDPRaWEfmfUfeB/ss2x6PztFRuii?=
 =?us-ascii?Q?a+jVFA0jobeAW+E/3ZeWLmaD4ooi+tbwpJduB32hkMPrgrdlZFA/+ynUzCUm?=
 =?us-ascii?Q?WG47J/ZtvyUVoP/aATNUQzHr0+QwDeocS+5w2UZMqgi7gTBzadoLsUtQBCOF?=
 =?us-ascii?Q?tpFna7+FOEh4ms8gB3QzT8npW8rcnA57wmnZe5T73Y+gvKBM/uK3npG2uEdA?=
 =?us-ascii?Q?+13DvT1hyYn0qjpV0NgQYciWvI0pv//H+cF6Kq30Ry7mMZB/71HQCYksYbjY?=
 =?us-ascii?Q?ooI6nfZHHFF97nzEXoyf5L0NJBm3hvdiJ0l/BiG0Fp+ABoONbMDBNc4emMF8?=
 =?us-ascii?Q?PRTss43vgKGoN2xCrYKFHElIjEjX5/JyMM47d46iJZYJImdzjF/LQgj0DKwJ?=
 =?us-ascii?Q?TjyEax1eoduCebp79WpSvGDwQ8AN2Bu6fNCX7nklSxoTerUmLYMEl8qWonwU?=
 =?us-ascii?Q?CYNBzPn+cf5kwF3uzlZrOgz/77FJEGYU3D6I+zEcHOG5adUmLQWePIcAkgtp?=
 =?us-ascii?Q?ndeNv+ic1OE1yeUCXmZ2Ei145NepdTx0zF4zLKSv/8zgLjQqwp+O/L0Bw1CU?=
 =?us-ascii?Q?nSnjpPPlwn+GjGJZz6bCShp6MmoHfZv0qrh/4jTC5N1+pCnDyBIlfMk7AcF/?=
 =?us-ascii?Q?EIaEW0maw2qCamfwiY7Q/KKRkmTJxbLXBDscmnvpyq16iaZWKJTGOyzr4JLn?=
 =?us-ascii?Q?Pe84/v99QlX0TnEVrmQcf+aZUaAZA/XxbSJi27bHxvlDTPcUOJhyCd3YrMmW?=
 =?us-ascii?Q?F6brO2KylnmDbi0l2jve9gb737FiMZ8kVdazq6fQnBW90hSzAD9RJGaNuju0?=
 =?us-ascii?Q?B4/wGp01nedp8LZZeICqD4sS0T7SyBHw51fPBq/j1p3zaexiXZSgZeoNigKs?=
 =?us-ascii?Q?ANk83EbS/8NvB3F5ZXw+bJkswqxOdc6BSM85q0jDGGXKu1MvYqJb8R0p9zEO?=
 =?us-ascii?Q?MiXLOJCt/kZM4U+vIbpDU2D1hbtBhAIhGbIGIx68HjIuD55+N0SXW1l51rTd?=
 =?us-ascii?Q?AS04SagCFgqswVjkrVV1/mCnU4XHYMDSzyTjDq3NYHqmOk5LtN+hgGIetS6L?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bed736-53dd-4b30-762f-08dc84c1267f
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 18:07:09.0585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ou/V4Q4rIIDJHJFlFHQ3u8l0GEUK+ya5yHl5607700FS3LG1qGRshWPCorr/6BfstCeLpXLj2otwZ0mzjJbDwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8041
X-OriginatorOrg: intel.com

On Mon, Jun 03, 2024 at 08:00:07PM +0200, Thorsten Blum wrote:
> The if condition !A || A && B can be simplified to !A || B.
> 
> Fixes the following Coccinelle/coccicheck warning reported by
> excluded_middle.cocci:
> 
> 	WARNING !A || A && B is equivalent to !A || B
> 
> Compile-tested only.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

Will get this merged once our CI system is working.

> ---
>  drivers/gpu/drm/xe/xe_vm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 4aa3943e6f29..3137cbbaabde 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -85,8 +85,8 @@ static bool preempt_fences_waiting(struct xe_vm *vm)
>  
>  	list_for_each_entry(q, &vm->preempt.exec_queues, compute.link) {
>  		if (!q->compute.pfence ||
> -		    (q->compute.pfence && test_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
> -						   &q->compute.pfence->flags))) {
> +		    test_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
> +			     &q->compute.pfence->flags)) {
>  			return true;
>  		}
>  	}
> -- 
> 2.39.2
> 

