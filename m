Return-Path: <linux-kernel+bounces-555265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90020A5ACCF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A333017330C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B98C2206B6;
	Mon, 10 Mar 2025 23:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ca4KO1xy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EE41D5AA0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 23:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741649082; cv=fail; b=e6tEfaKCw5PGa+c3ffp6nc/J4gYWeN1hpcZv39kFSdMNvKpdNoABkyj81lbtTUa2Fct6vNQVMlaR9zi1d8QG3lOachyLQxFUJPnBuaBHY48QJFTtgdh6fYSk6RKWMFzsYOZqmM3/TAaLaNIdc5qbLnIXQTODLz1YP5LyvAuxTTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741649082; c=relaxed/simple;
	bh=6yJ5tOEuUdeJDoaJL8Uq89JTq8UV2/ZzRWDm90Mj2fQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nnATrXkxex8E8Slmey6GQMhq1XVYf41KhsyV6OTBNm+eraRgFPM3VifoBEhWk/NXKPeiSIWGzuV3lwfKCAQDwLCgbZ7WJ2r9ilhB7LFjPXGMtPW0S03GhBbU3VmyoLJ9e0pDG3xMK+i5Ier4gym4Vp6OdO0BzP5Pl38/MjRiWn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ca4KO1xy; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741649081; x=1773185081;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6yJ5tOEuUdeJDoaJL8Uq89JTq8UV2/ZzRWDm90Mj2fQ=;
  b=Ca4KO1xybHlAsvfk0kEMyQfuvF+364yBgAabbAgOM2yVyZjr2KoTdX+h
   R2Q6UqzSLYc6CwHAX/MXGzwyioB3cqzNZnBdLg1LHRPtd7znqUPbM7yi4
   hmkLDnCkJ7EMhgug0fJyRu+MqCGR4FY/kYglnCF42YT44qqsIuveh9dkB
   3cJ3NUF8Jflw2CcajXkSyz7HxuD6Il/8T4Y9lnwJVO7d6ZJDeb3iFcD4N
   f+2inbwJRwEJTwYuFa8EvLyxQXBm3NZWTNVU5tEccBardWEfzaLbbLfcb
   f55r3vAu7ijWkpW/KD+7fPxWSvwLC6NsQO+EqUFnFyAJGjk2pKBaQF9Fa
   Q==;
X-CSE-ConnectionGUID: CyQtiCM3TbShzpBeLc9hOg==
X-CSE-MsgGUID: RjgrrQ90Tnmkxm0I7nTEiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="41912901"
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="41912901"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 16:24:40 -0700
X-CSE-ConnectionGUID: df53ulsITHCownfieYuQtw==
X-CSE-MsgGUID: nhkRJkdfS762a5naLKQN7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="143327730"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 16:24:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 16:24:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 16:24:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 16:24:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDWeWOYJhl4bGXtsFFukLk0Bgls2G5PeVani0SdhJGEFrODJGJRwiXmgFiABCW16vU1j+GLW7nZqVXokBD9jyOWBdvvXPcHey7lUCafM8IkktfGWrOe2oCpnV8sIRSJB7Vrs1khsdGFf3CMnKWmId7+7sWZIlKGB8LJogP5o+w83kRZTMGILnTfC4KcsvBTkSAF0zUkLdYY4SXrIvFOC1rYnG0U4+wkiCMhIR8sud5NtoHE9qUdnDutEFow6j9zN5LOCwZDNKo295oWYbcXhxmU0R5Dlk5ZmgZfdzUrbpR5MnTlqY3WVxQkhDbZSTwYa8chrSeu7ANeXOz9pgjcS9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svGcD6skHyVbd4EqwAa66mJ1X6e/kPZOnF7UQSNNUyA=;
 b=Ey/Fl2iXpSKfnGGcpWY57hVKU7/0143L+1STVcIZVSgKXENLP+GyYWOSTgGdODbexFvIy3egybbvjBmbMqRQ2vxf46ywz5evaB/zc9eQRMc3reZ2qSVnvZ7HG1dZUSjs9tq+P0FvOxFVmBuyvWft/9oGkB9VM+74W9h3j/34ODd3X+MQBjpHoItMixVBMSsypIdD3QP38i9DUkPAmyhXSfwHk82ec/i7d1KOU3/BmSepXEcsCy1dP8oI5Ln0nwNyvyYG8VaDMaBad9EZncPshAdbMY/u3S3f3zj7RHcskFns/luiSipNK4Vm31Dih6HCJuzlv452gdRVSdy+1LMXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SJ2PR11MB8566.namprd11.prod.outlook.com (2603:10b6:a03:56e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 23:24:15 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%5]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 23:24:15 +0000
Date: Mon, 10 Mar 2025 16:24:09 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Hillf Danton <hdanton@sina.com>, Byungchul Park <byungchul@sk.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<kernel_team@skhynix.com>, <conduct@kernel.org>
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <67cf7499597e9_1198729450@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250220052027.58847-1-byungchul@sk.com>
 <20250220103223.2360-1-hdanton@sina.com>
 <20250220114920.2383-1-hdanton@sina.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250220114920.2383-1-hdanton@sina.com>
X-ClientProxiedBy: MW4PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:303:16d::21) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SJ2PR11MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3f47ce-22a0-4875-c3a1-08dd602aaa1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R1VD09uWBYojLfOaiN0cDRdgaREkqpa4SKhqvPLwe1J36Ys3VIdcE8ElA3Pg?=
 =?us-ascii?Q?MIZFsPWXgX1ebJR7QojwazqMxtjT85AT6GsKARYxEO+nkpwSR2knyQmh0cF4?=
 =?us-ascii?Q?KWjY3tPaUCYhDk0VrquJnGqpTpsrQ6wvc+yVFXFd2dlgdXdZwiUqPzV/Lxu1?=
 =?us-ascii?Q?88qo8hLE3BEKS38+iOs2SsoyBm0WkKD6CZUgaDp+j8ofChUrE9cv/A/LMT7m?=
 =?us-ascii?Q?kPfxftV/LVGEzzuWfGLrqsCnPoQHs72HW4WJaPFOtsEfiYABQ3lx8VUg9YMz?=
 =?us-ascii?Q?cEKa5J/RZwNFt/pbH4U9fEe4bGXCn5yHa+jg2eeYLULIS2we5QfjkIFYCfmt?=
 =?us-ascii?Q?fxL9EI81VnGzmugeeggz84jqv6zbgNESDE6t1ig4+J7IqhMRN/CBWdJ3qSrw?=
 =?us-ascii?Q?F5MTwsKpqTGszVdeo6Rv7c9fGtrol04UGFFbLF4JPEHLMwSGV2QEXDMoVEn4?=
 =?us-ascii?Q?42ektF5twON4QOD7Rmbyv4ydsgtX9JDRNMhrE1S3IAsnmCgVYpBQE6x+XPxw?=
 =?us-ascii?Q?X8NczC3Ohrf7zDwKMaJKlwieVzva9erT77U17b8rFaQWYJNM8VNvkC5KaArp?=
 =?us-ascii?Q?mPVGPF8HzpsTZrQqt0as3frSiPaKPl9bX34N0t+b7dq1q8929NIAxiYPQEfW?=
 =?us-ascii?Q?AVoI5DyqX9+5YH9+4P2a7jaeaLKlNhxB0F32CtWFf09S0X6lUdsTbBM6FgrF?=
 =?us-ascii?Q?KfFfy30MyNJTWvXY7OSvJ331H2EUMh6RSgWBSueQLkKYRA4Z7MjEBw7jhPB4?=
 =?us-ascii?Q?F4ej9l+wiq3Q7vT1mlcevORV6cL3xWGxy9dVQQsB5prn48ynGCeohULqSDrI?=
 =?us-ascii?Q?oVH8+zOH86W5PB9+B29j/EZAGLH81TNcdpNloIZ475/riMX/6btzciaI6mv9?=
 =?us-ascii?Q?usNRFUUE2zjTRAmhjZ+WeBe/PtjRpsV/cT9lfZajL4c5sjkd3CTK/DHa6fgn?=
 =?us-ascii?Q?9+pbfvYnjO2A3eUp3RlRE1ZWA6SlIPXTMK5b3MKoP52f8Q1zWtQy8wI484hC?=
 =?us-ascii?Q?fl/pMD3wXK+e6AXgz2ddanMZ67g7W5sm0Oil7OIpqjbgPcEnJB5218xu4RyS?=
 =?us-ascii?Q?G3lgumVL4QgpFk/7hvhE2+irlkHltvtH4uzjjWmDESffSaR4/pZnOJJ9wthG?=
 =?us-ascii?Q?BS81fHaeagN9OTkoK9953ohi2FwEy72L9Odr7cP7AuTWpkoVISateHpscIlo?=
 =?us-ascii?Q?k4ATplkPre07LIXt0bOGXgMRnWytmb4LCWUXY8gMj+D8ePS6IEexJlB8rVld?=
 =?us-ascii?Q?2qWsvwU/cKn6HaeGJqLXk/EQ6hxDllihXLerTY/b3apBi8ZL63UEGph1onH/?=
 =?us-ascii?Q?owUgMt/jnmAncOY2nTvqmy14t0R7O0SxjVDkLyrs4o4pcjTxSzMzi/Q3HoHx?=
 =?us-ascii?Q?o7LZVMNVEcS10ZIj994Ogn1WVsNvTIo6CmhE+8PllU7MDzOPNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eCzbSyqx2p6JFhWhqkT8zvNsO1V4Dew5pOA63fb/+E05ZUurWXDn5rYPMpUp?=
 =?us-ascii?Q?gjxLoM8exkxLYXCtlqtaeW9Znq+OB00N0rxWi1S7R+BlP1SAi8spPOcK6SNo?=
 =?us-ascii?Q?XqMQ7GgaIl0tczGK7gbkjZlhnKNHt284z3k7yvTioUJCeflHs/O1nUX+O4cm?=
 =?us-ascii?Q?Epqx+9ToM8x4TLJJKN87CijFgvRWau97OLozU6MF8rIRgbecfrMrFZf+OxIu?=
 =?us-ascii?Q?d7bcsEKWXYMetdXZajP7x9LNEkMQFiuGdoDvLPD16UeGUxWOYv0OISTcWSpD?=
 =?us-ascii?Q?aVIlX+t1/IeKancBDJ3x4NYodSkOGl4MLDaV9CvHPbz3VSTn6dGniBYkmubW?=
 =?us-ascii?Q?sGP1XQMpbupvCfIDfusZg8RmQ+Py4I5ac44KSJeb77LBiquZx0UMSRdWn2W7?=
 =?us-ascii?Q?3mcHEshoD/kH/qzgTuaQYzHOp2JD1LFmp/1Kgr+psUXn4KQaT5cD9HA7Su0G?=
 =?us-ascii?Q?cAg6FE8VJpDarp4Rp73tlaloWmv7WoEeJgQVc5WNq/wpQQ+TlbIbOvfO4sbX?=
 =?us-ascii?Q?88JNVSFvP3rv1o2lMABRW+rU/J4LwciDJfb8rNQ35fpMHKPL7kRHdnKBnIAH?=
 =?us-ascii?Q?b2dhF92ZgdiOHe6BStuxcr0nsKtznEt8g/0lC55LJg9FYD+vZZSOdD3kEB+y?=
 =?us-ascii?Q?RMcSbi/J4YjDBx742G7UsYdg+E0h8jaQUrzySgUYP5Dij+KAFVMYmZHU0HRp?=
 =?us-ascii?Q?euw/Kk9mgiZK+Ugb9ylml+9pvnv98htLrApB8DeVmnXH2MIJU2gd6lZbkvnf?=
 =?us-ascii?Q?cO3u2R7kGRjO9uKV6MpkH/sr0LN6538oCNLN5b1TLRqDsPR+vkKblbiMgwAK?=
 =?us-ascii?Q?l1yCn60UfGksH7MFZqC5b7ltE60tqWvAKugLfdJBy1nUFoHS1OA4I/fFAdHk?=
 =?us-ascii?Q?ZRjykO5ZcYYXk8A0UIqO0sUKOVlBJn3oITR6a1X8cm+irrBFK/zxe2/ZKJko?=
 =?us-ascii?Q?Q37V0cQsZ/EIPn5OzEDCgCtJUfuDXWz2F7VN5jpb4dvTR/1+Sfn41FxZPqAx?=
 =?us-ascii?Q?gf8DIwLQswMEQJqlY/jOtzAqWdBak1/vIm9Gs0jboCjq5mkKeCbZ9/whfD7F?=
 =?us-ascii?Q?feMGGiUnKgppCcqCNdnqz1OG8ye5BYYnhZ3lLHYKESzcPV00rbAY3vSFbfpo?=
 =?us-ascii?Q?ETPrXujwIHFk4yUUOSSeXyHLJe0eDN9Nm6gjEuMvzPDKQMkMrh0DCo1x5gmf?=
 =?us-ascii?Q?TQFW1G32iCRxyPqp1O+cAep/ah6DcQ+KtEndHLEcN3yduNmh4LA7NpAB7plP?=
 =?us-ascii?Q?2yn8p9PKnHihFYFemmkIFMJpi+SaF/48sZEH/tbCi9vP872Krd8dYox7r1SW?=
 =?us-ascii?Q?94GtTjqDiGjSZfHnAQ37CiT/Xq+jz90arGQQETwePsOwemsIWoUemvJC18FB?=
 =?us-ascii?Q?xnSbD+d/tZLdd1ha+mi0gUsPtAdzO0xDWZ2JEdG/jqZFjGy2Dmhi6rvnlhZ1?=
 =?us-ascii?Q?gH3BkYv+knUuYglvENw4eMILb82yg5B+IwjbGRwUSzfvekgKaV6U6tYl4yMQ?=
 =?us-ascii?Q?lYb0evSmXEuq5SPnp0GCXCjUv6i/hs766VMTXWMQTbpnjln/vB6hH4GaE2bK?=
 =?us-ascii?Q?/7du09knJUz67/irb9PUhJGk/cTvS3Ug1NUiQX0EoFU86HaMo5sC6qOPSvKl?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3f47ce-22a0-4875-c3a1-08dd602aaa1b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 23:24:15.1552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EH75PpevyHRcIPVcNflNNkoqyEZfkMWthGoqXeWo0RLpGIPJtw9yeF7X11KlC4622o59swN+kMR1PqSeNQ6+u0K4rQPgRNqkva6dNarY+l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8566
X-OriginatorOrg: intel.com

Hillf Danton wrote:
> On Thu, 20 Feb 2025 20:09:35 +0900 Byungchul Park wrote:
> > On Thu, Feb 20, 2025 at 06:32:22PM +0800, Hillf Danton wrote:
> > > On Thu, 20 Feb 2025 14:20:01 +0900 Byungchul Park <byungchul@sk.com>
[..]

Hillf,

The Code of Conduct Committee received reports about your conduct in
this email discussion.

Link to email where the violation took place:

https://lore.kernel.org/lkml/20250220114920.2383-1-hdanton@sina.com/

Our community works on trust and respect and has agreed to abide by the
Code of Conduct:

Reference: https://docs.kernel.org/process/code-of-conduct.html

The Code of Conduct Committee has determined that your written abuse
of another community member required action on your part to repair the
damage to the individual and the community. You took insufficient action
to restore the community's faith in having otherwise productive technical
discussions without the fear of personal attacks.

Following the Code of Conduct Interpretation process the TAB has
approved the following recommendation:

-- Restrict Hillf Danton's participation in the kernel development
   process for 3 months.

       - Scope: Ban Hillf Danton from Linux kernel mailing lists for a
         period of 3 months.

