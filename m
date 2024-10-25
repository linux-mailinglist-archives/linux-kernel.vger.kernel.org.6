Return-Path: <linux-kernel+bounces-381172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 348989AFB89
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B913C1F214E9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A751B6D0A;
	Fri, 25 Oct 2024 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FConVnnR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B45193089
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842758; cv=fail; b=cjUAigwielL4jSsPqxEIj2T22L8ERBpYfNR0quU3mtxuRyUGs8JFtybm4saIHAhOGeOGdZoyclcGIefzq0IxS3iY/Bn+ZnaI3MwrQ9SlnVfEAJ07JG+UzC3lpvBD+3NcmJWYqvJrI34m/mWQ48BLgVJV/2duWaEnWUinRlZfIsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842758; c=relaxed/simple;
	bh=4JnATHeffiQdMZxt0a0fAQHZN6pC8KLlLOHa0scxbos=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=UWA2Levu9rzf0aQJwUhvzG0KQ96HRQEbgsoNh97YRI3X4xBvn9dXJRWUd1c5XJgjkw/Po+Lf5dlwV50xyIIW/r1idzQEL+XZAlBcTKariehaZMkO68CKmQ3JBFFmoi0DbinYxspGIR36DXeWrLHThkuu8/PTRck2sW3Qw/XASTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FConVnnR; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729842755; x=1761378755;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=4JnATHeffiQdMZxt0a0fAQHZN6pC8KLlLOHa0scxbos=;
  b=FConVnnRcgDEQ+AxJULhUmfGKHFOBtHubUv1Y2XRLKX985fZvyNzFIWV
   FZDsKOrgW6LYSM2HV1XE6cglE2BkHtkfOWvnYlX6f4OwtSNSXwy56vs8U
   fzVjc2vk9wYDATW/VGDle6AW43Wx46QIovFk7iMUe/qZ1GuhLSDcY0CDD
   /eYMEnfj3OE4fIs7EVisGEErapUIDxGxXN/mTiArGvenCxo9R/gy/VadQ
   VnIH1BsythMJk7dSzMk37+yMis7gxlStPauB1pF62Kat5wtFudaLsY3A+
   oMKtOLEWmJxq50qbF3qyejTfAr0qMlSzANN3d90jm0h6HM4oOnswMPtCm
   Q==;
X-CSE-ConnectionGUID: Fazo9g9ESoe5w3qBhAx6aA==
X-CSE-MsgGUID: Idu8zxcCTkaNerwOETBKQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29447827"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29447827"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 00:52:34 -0700
X-CSE-ConnectionGUID: 6rQfv1IzRw+2EfgMkGhsnQ==
X-CSE-MsgGUID: QTiZLa7RT42FUsqXdi1skA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80950295"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 00:52:34 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 00:52:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 00:52:20 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 00:52:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rqk7MfE1UrXVpBAcBZlZZenrKUY28TL3DwjFX+ZLGG0k+OCUaZotDQLTbhhVL2Xzac9YAfb07VUZxH7VxUZYyN6gagAVc0OPRY4+YOmpHMJn3fH0U1tzKX9IvxeSOAro09PZFrtHSmZ1YLdrnFzsWxQZDSJpRMFhoBGRAUrtfJAuDxIDpsNCGR+odppRXCalOBeTJwdCyWpFhsyavfF5RSq42pxF5O5TaydhyM9/HTY3nE3RPLwPfIWPn3A5QPk+h21MqrkrWpbbKld7agSG7oEB1kkCXUFTxjwU2Y8wZqg28yyIcXvoh7ppCsA3edCApEWZVawbwgyrc7XzJ3Y/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrMxvdUFQ90XbN2ldEF2t8gUH1X1Yi29ySmmFs6WEVk=;
 b=D/6rcvFUF5KTS3iRiKK5dFIx2/ORXrZ6eH1ASjm806KwkCrXjwPlOvV9Bl4zKnfYxLqfu8LAi8tTY6PQ8u+PtkmJlVVCLJVBQhdJh4+ylg4CqFbY8kI7IzK+h0Zd2YXsTsEuuL64HALLwbMo2VdOONZHy1IOrz22Y9BOeeMSJimff+TpNPdz9B/N2IvaaqqisWQc9qEkhtpkgJp4PPZQu995VRyXuXIODtlqogu5307qbsnRi69fMYVrf45K5qTATiVLRMPg6l14vQwAlEO90253hCHk8Vo9dc4g19l2AdKCsccnOLArq1MKbFwv0EvtExfM2IElqJnCS6zJUrK1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV1PR11MB8817.namprd11.prod.outlook.com (2603:10b6:408:2b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 07:52:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 07:52:18 +0000
Date: Fri, 25 Oct 2024 15:52:07 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Marco Elver
	<elver@google.com>, <linux-mm@kvack.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [tip:sched/core] [sched]  7e019dcc47:  stress-ng.sigtrap.ops_per_sec
 7.6% improvement
Message-ID: <202410251556.76e29ea8-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV1PR11MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: 94aca135-05f5-4946-6996-08dcf4c9f2c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?hJGS9GbmMrJiJFGLJEE6SBpxJLOmOk8plOmDIx4FeDfJu7DC8sO7e6Vfzd?=
 =?iso-8859-1?Q?OymMT5rwy9cGffhMiCzyiunIi1PvwcQgl1hbd/GDPNqlFH0M1+2diJczIk?=
 =?iso-8859-1?Q?Cw149xvriNkD33v+Fxx0gQnlzsxeSbmoUqbIRvNeLWbmkJz2eK6tTar6FC?=
 =?iso-8859-1?Q?x4D623d1hvnJv4vLfGmu3Xo/Mw9EJTr3WLaV/0TTV4+ij4iTNIf9m7+Xrj?=
 =?iso-8859-1?Q?7EPXgoYhvgQ8kcJU2DebctfqXw3/cGEAhMnvloGJY4lgcmFbFIuqMDzgb1?=
 =?iso-8859-1?Q?cmiRp/8TCM9JLm4D9dobmVQIqGMcNTAmf8aWTscPQ+fHCyH9LxUgHlJBE0?=
 =?iso-8859-1?Q?9Eo40fKj19qQgrIcwTkRW9dIemOYhwCtNwdvZCVJ9Xrm/6MCnOtvRZ0zS7?=
 =?iso-8859-1?Q?FHusyCpOQIpO0944dT70G8iQeFJq/KWGrI2uE2Qh8hcn9vzVL7tYUkPsAF?=
 =?iso-8859-1?Q?sBePywWBRurdQRvgtlpyn/gzdkmLzGPA0vpnE7q2KTiBUxDI8iNLirLp+h?=
 =?iso-8859-1?Q?Av15dra9jyOfVWA3GMuJzaadZ/yRM6A8IGhcv2I9yRmw/Pyfzqq+cGgcUj?=
 =?iso-8859-1?Q?OmkiLqZ0H0RNBKNvPy2lkQmcvJMMGmSVwBTTWluuL7AXUo2ZBKrtcj8ofx?=
 =?iso-8859-1?Q?95zUvGVyDvY9jE1+kKfNEkX4wQ2E3SkZILbvF3WfyouPymSNTrPYM0cy/4?=
 =?iso-8859-1?Q?F7NKGJ8P5Mdftq0Qqyoe5li7+8T4PPMFYeeFzkAlX3Q/SAY+d7jZWYsLn6?=
 =?iso-8859-1?Q?CobWVoBzcwhJTDtUw+h5Px6gS1hB7avN41jA4uQsw/STVa0UcnbSXP9c8q?=
 =?iso-8859-1?Q?BE82uVYha1uA2jD4rr7P4lDQJv71mEoX6OQDdI74Q6AVbpeUJXWzlT5Xk4?=
 =?iso-8859-1?Q?Ca5MxtgDBF6CqGaD0l01ic5ol8ogye8qfwxg3F33kjU9GpLrxKw3QUi5xp?=
 =?iso-8859-1?Q?k27KQQIPf2utq9OhwrbxQSOYhL2B4Oo8hfEY2o2c8e0ExGQiUUoZJw8rC/?=
 =?iso-8859-1?Q?hMtubDWMgUDZBIit46evHE80AmXNmjzBd+PNs4aVNQS8A1ut1/VjeL5Ine?=
 =?iso-8859-1?Q?qOPDfMKIjXd01SaUw6Gb7FxSB3ANIG6GYLszVX3jPXJyugGMwWGTELH/gR?=
 =?iso-8859-1?Q?yudrlg5Kfw7kE4y2kVOkkOM+LFOw26gjc2j7sPcpfRMX+LqR5S7DSP4xIt?=
 =?iso-8859-1?Q?18W8VhrKrZu/VNgNhZ05/v++aX/nMNnLs9ozeTUlMdCRxPuhYtadd3lcho?=
 =?iso-8859-1?Q?O+9Yptl4Rj3spufOB2Bi5OvXr/kR6axTDAbnW15CbAGW1t0Ye3C5Q7dK97?=
 =?iso-8859-1?Q?ktNDMVq/SCk5YkYYecSftrZXgg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yPIsPaLaKEcdiQSZOBmpnV9Gzw70+6jAFgn0NuICY86bynXwek9xOa0LHu?=
 =?iso-8859-1?Q?lRQcwRggoQwnzftA9shJdi+uf+35koLGr0gEmw6OFoeyScFGLHimMnO5Cp?=
 =?iso-8859-1?Q?uD6Q7lDDYaQAsNHMU1npoNDs/dg3LHdMUZMnEr/uWL/ON4L3YtSuARTnG4?=
 =?iso-8859-1?Q?dDnumzTeyKlY+XzpcOk84WSDgcVoCJ8k7nz4M5Dp8D/8LphMJf+hcXeXaW?=
 =?iso-8859-1?Q?xxbSCsT9t9XZWh8j2UJVYA68hiVTLH80wgE0at+mEAg2Ufv1yVmLDqlu8L?=
 =?iso-8859-1?Q?9ew9okMhdSSh0TaLSdiYeIlJnqfNq6fCguBHJi1e1w3O36ws7/g4rDO4rT?=
 =?iso-8859-1?Q?ljXqnFthRp34DLR83jd5rWev/KT5v2vSHy5xkRfJh61jihYBXoJljukuWP?=
 =?iso-8859-1?Q?QZnr//DEwLHihK7wE2H8Xq1V2l2ci3wOohUU2lFz0K/523AFD9NE/bQKaW?=
 =?iso-8859-1?Q?0vrD/vZ3l/KkBJHgxoq2q1ZpNscPoDXCp+IVYsZSd4F0H9kmD7GBzsJSq2?=
 =?iso-8859-1?Q?x4fsj5DWV1b/ruj+mFbUoYLePVBgwgQ+hdb8Hjazx9X033kVDGJzU5Aj6c?=
 =?iso-8859-1?Q?/XlE02SH5Ugosvo107rAdlDNt1Cm4VtAxNl8J1hm4mlGCxW14wkTQC+TUL?=
 =?iso-8859-1?Q?NlXUSSug5PbIRk6xKQTylKatAk+hB8MIRoN0Prp4IN5495g5/TRO3fkiKg?=
 =?iso-8859-1?Q?qvTx/iRjjynbmtkNkliwSPFj4Nj+eYds+qwdt0Q/nbGZx244tK4HaemNhU?=
 =?iso-8859-1?Q?pBdMARFEDkbOUwGxxzoD5nPCdoQ8Cb73FjNdwvuCM1VFsdyu/7uLs1dC+x?=
 =?iso-8859-1?Q?6q1zEOX62m0GUf2YIV3spbxKVJ6o+xWwhnFTkPBkKfpRPK/hX+3TjisSFV?=
 =?iso-8859-1?Q?xDgfNzT6mPR3Rp4zqnMxfVe3t77zFuIVF4/suqBeb1hHQgrBCiZbTg3LZm?=
 =?iso-8859-1?Q?NVTlYDbISb989XnDu+NKXxUmsMz+ecOe6Gv4a6/w4zLhemJRp1/iqhgNYs?=
 =?iso-8859-1?Q?G/34yVmU1Y0xXEpnRArBDWkorKRSfYbkGfcnPF8+wn0HbPqFgiXnS0iA+Z?=
 =?iso-8859-1?Q?3JYee1tVCussdlSiguWUYPpDMqqgRo4YQtzMF1KT94ab7+1ayIsVL8n/0I?=
 =?iso-8859-1?Q?rqSiFH9Tyuk97o9cPv5yubrpI0g0pqLCe7h28WMAJRSDFbWDD8pF5bS3lf?=
 =?iso-8859-1?Q?/QxHdlnCYdb5RKKkTdDfwoRgWjltIjZtoXc9cma35X+fL2zFVW/jjkt0Mi?=
 =?iso-8859-1?Q?PQJlLo/jgTPimbydhgjDzGqN6FO5wZ8CuHjp/9JAqP0Rx5ZyNVyn8Oi0r9?=
 =?iso-8859-1?Q?DAz/6XmBkWIyO47BWSHtLgeL0JZG+GHDKjVw7FU1L9lF6/WKUslRAMmXrY?=
 =?iso-8859-1?Q?3VyZxHbfuvEt1xWtuL2bY/SVP0498DaotgrBQ9s7OC8LzfxEyajsNu9mQ4?=
 =?iso-8859-1?Q?gVKwAFLuLFW9PkVfDQ1R8LMdagIN3Mhq6R6WcbFPLLT7AsgPY7K1IOkBvP?=
 =?iso-8859-1?Q?MnBkyiy86ZTJ6AfL6ISk96bsw9uSk7d95ng4aLE+u+U1QTt8B1DmyPT+94?=
 =?iso-8859-1?Q?mysY3DQxzchNTXEFSWSIVdu1ih//tEozfw0nimOcMqUjtX+2Tx6aG2H3sC?=
 =?iso-8859-1?Q?0YByGQz4s9cYFzCMkFTIoFLyCGhBGyJ73xLkZzln9+hPOgkqrZHAtBhA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94aca135-05f5-4946-6996-08dcf4c9f2c2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 07:52:18.1521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ci/JBYUenQBg9L48Uh6+NCLf/HujPWoLah6Vd7YKB9UzZaYqVSn0fJYNSdE/a9TpsB8w9m8tJZEMWHl29B95nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8817
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 7.6% improvement of stress-ng.sigtrap.ops_per_sec on:


commit: 7e019dcc470f27066c98697e43d930df8d54bd9c ("sched: Improve cache locality of RSEQ concurrency IDs for intermittent workloads")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core

testcase: stress-ng
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: sigtrap
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241025/202410251556.76e29ea8-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/sigtrap/stress-ng/60s

commit: 
  8e113df990 ("sched: idle: Optimize the generic idle loop by removing needless memory barrier")
  7e019dcc47 ("sched: Improve cache locality of RSEQ concurrency IDs for intermittent workloads")

8e113df990c9df70 7e019dcc470f27066c98697e43d 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    177050            -1.6%     174290        vmstat.system.in
     13575 ±  2%     -16.4%      11347 ± 12%  perf-c2c.DRAM.remote
      5367 ±  3%     -18.3%       4383 ± 12%  perf-c2c.HITM.remote
      0.22 ± 55%    +113.7%       0.48 ± 83%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1329 ± 33%     +48.0%       1967 ± 31%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      1329 ± 33%     +48.0%       1967 ± 31%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      5150            -8.7%       4701        stress-ng.sigtrap.nanosecs_to_handle_SIGTRAP
 6.481e+08            +7.6%  6.972e+08        stress-ng.sigtrap.ops
  10802071            +7.6%   11619474        stress-ng.sigtrap.ops_per_sec
    190.34           +11.9%     212.98        stress-ng.time.user_time
      0.40           -17.2%       0.33 ±  6%  perf-stat.i.MPKI
 1.037e+10            +6.0%  1.099e+10        perf-stat.i.branch-instructions
     26.84            -5.4       21.47 ±  5%  perf-stat.i.cache-miss-rate%
  19330364           -15.9%   16252491 ±  5%  perf-stat.i.cache-misses
  72296794            +4.7%   75664331        perf-stat.i.cache-references
      4.62            -7.5%       4.27        perf-stat.i.cpi
     11681           +17.4%      13708 ±  5%  perf-stat.i.cycles-between-cache-misses
 4.856e+10            +6.0%  5.147e+10        perf-stat.i.instructions
      0.23 ±  2%      +9.3%       0.25        perf-stat.i.ipc
      0.40           -20.7%       0.32 ±  5%  perf-stat.overall.MPKI
     26.67            -5.3       21.41 ±  5%  perf-stat.overall.cache-miss-rate%
      4.64            -6.8%       4.32        perf-stat.overall.cpi
     11645           +17.8%      13723 ±  5%  perf-stat.overall.cycles-between-cache-misses
      0.22            +7.3%       0.23        perf-stat.overall.ipc
  1.02e+10            +6.1%  1.082e+10        perf-stat.ps.branch-instructions
  19031830           -15.9%   15997328 ±  5%  perf-stat.ps.cache-misses
  71361498            +4.7%   74737173        perf-stat.ps.cache-references
 4.775e+10            +6.0%  5.064e+10        perf-stat.ps.instructions
 2.964e+12            +7.3%  3.179e+12        perf-stat.total.instructions
     13.02            -0.9       12.14        perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.30            -0.8       10.47        perf-profile.calltrace.cycles-pp.collect_signal.dequeue_signal.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
     11.23            -0.8       10.40        perf-profile.calltrace.cycles-pp.do_dec_rlimit_put_ucounts.collect_signal.dequeue_signal.get_signal.arch_do_signal_or_restart
     14.47            -0.8       13.65        perf-profile.calltrace.cycles-pp.do_send_sig_info.do_send_specific.__x64_sys_tgkill.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.05            -0.8       11.24        perf-profile.calltrace.cycles-pp.dequeue_signal.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
     11.34            -0.8       10.53        perf-profile.calltrace.cycles-pp.inc_rlimit_get_ucounts.__sigqueue_alloc.__send_signal_locked.do_send_sig_info.do_send_specific
     11.75            -0.8       10.97        perf-profile.calltrace.cycles-pp.__sigqueue_alloc.__send_signal_locked.do_send_sig_info.do_send_specific.__x64_sys_tgkill
     13.28            -0.8       12.52        perf-profile.calltrace.cycles-pp.__send_signal_locked.do_send_sig_info.do_send_specific.__x64_sys_tgkill.do_syscall_64
     11.20            -0.8       10.45        perf-profile.calltrace.cycles-pp.do_dec_rlimit_put_ucounts.get_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_int3
     13.46            -0.7       12.72        perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_int3.stress_sigtrap
     15.82            -0.6       15.18        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.97            -0.6       15.35        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.16            -0.5       15.66        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_int3.stress_sigtrap
     16.20            -0.5       15.71        perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_exc_int3.stress_sigtrap
      1.39 ±  2%      -0.3        1.12 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.set_current_blocked.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.05            -0.2        2.81 ±  2%  perf-profile.calltrace.cycles-pp.set_current_blocked.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.36            -0.2        1.16        perf-profile.calltrace.cycles-pp.signal_setup_done.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_int3.stress_sigtrap_handler
      2.45            -0.2        2.29        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_int3.stress_sigtrap_handler
      2.50            -0.2        2.34        perf-profile.calltrace.cycles-pp.asm_exc_int3.stress_sigtrap_handler
      2.49            -0.2        2.34        perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_exc_int3.stress_sigtrap_handler
      1.04            -0.1        0.91        perf-profile.calltrace.cycles-pp.signal_setup_done.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.83            -0.1        0.70        perf-profile.calltrace.cycles-pp.recalc_sigpending.signal_setup_done.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_int3
      1.88            -0.1        1.79        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sigtrap_handler
      1.93            -0.1        1.85        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sigtrap_handler
      1.92            -0.1        1.84        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sigtrap_handler
      1.93            -0.1        1.86        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.stress_sigtrap_handler
      0.98            -0.1        0.92 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.do_send_sig_info.do_send_specific.__x64_sys_tgkill.do_syscall_64
      0.98            +0.0        1.01        perf-profile.calltrace.cycles-pp.fpu__clear_user_states.handle_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_int3
      0.73            +0.0        0.76        perf-profile.calltrace.cycles-pp.fpu__clear_user_states.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      1.06            +0.0        1.10        perf-profile.calltrace.cycles-pp.handle_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_int3.stress_sigtrap_handler
      0.56            +0.0        0.61        perf-profile.calltrace.cycles-pp.__rseq_handle_notify_resume.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      0.52 ±  2%      +0.1        0.57        perf-profile.calltrace.cycles-pp.__get_user_nocheck_8.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.83            +0.1        0.89        perf-profile.calltrace.cycles-pp.__getpid
      0.54            +0.1        0.60        perf-profile.calltrace.cycles-pp.__rseq_handle_notify_resume.handle_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_int3
      0.80            +0.1        0.87        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_int3.stress_sigtrap
      0.64            +0.1        0.73        perf-profile.calltrace.cycles-pp.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.96            +0.1        2.06        perf-profile.calltrace.cycles-pp.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sigtrap
      1.98            +0.1        2.08        perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sigtrap
      1.58            +0.1        1.70        perf-profile.calltrace.cycles-pp.__restore_fpregs_from_user.restore_fpregs_from_user.__fpu_restore_sig.fpu__restore_sig.restore_sigcontext
      2.04            +0.1        2.16        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sigtrap
      2.04            +0.1        2.17        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.stress_sigtrap
      2.45            +0.1        2.58        perf-profile.calltrace.cycles-pp.restore_fpregs_from_user.__fpu_restore_sig.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn
      1.42            +0.1        1.55        perf-profile.calltrace.cycles-pp.clear_bhb_loop
      1.86            +0.1        2.00        perf-profile.calltrace.cycles-pp.copy_fpstate_to_sigframe.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart
      1.78            +0.1        1.92        perf-profile.calltrace.cycles-pp.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
      1.70            +0.1        1.85        perf-profile.calltrace.cycles-pp.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode
      2.63            +0.2        2.79        perf-profile.calltrace.cycles-pp.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.05            +0.2        2.22        perf-profile.calltrace.cycles-pp.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      1.96            +0.2        2.14        perf-profile.calltrace.cycles-pp.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_int3
      3.63            +0.2        3.83        perf-profile.calltrace.cycles-pp.__fpu_restore_sig.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64
      0.34 ± 70%      +0.2        0.54        perf-profile.calltrace.cycles-pp.asm_exc_int3
      3.74            +0.2        3.95        perf-profile.calltrace.cycles-pp.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.56            +0.2        2.79        perf-profile.calltrace.cycles-pp.handle_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_int3.stress_sigtrap
      3.48            +0.3        3.74        perf-profile.calltrace.cycles-pp.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.77 ± 32%      +0.3        1.10        perf-profile.calltrace.cycles-pp.save_xstate_epilog.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart
      2.49 ±  8%      +0.4        2.92 ± 10%  perf-profile.calltrace.cycles-pp.aa_may_signal.apparmor_task_kill.security_task_kill.do_send_specific.__x64_sys_tgkill
      8.09            +0.4        8.52 ±  2%  perf-profile.calltrace.cycles-pp.stress_sigtrap_handler
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp._copy_from_user.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
     26.54            -1.6       24.93        perf-profile.children.cycles-pp.get_signal
     22.44            -1.6       20.86        perf-profile.children.cycles-pp.do_dec_rlimit_put_ucounts
     36.34            -1.4       34.96        perf-profile.children.cycles-pp.arch_do_signal_or_restart
     22.95            -1.2       21.72        perf-profile.children.cycles-pp.inc_rlimit_get_ucounts
     23.82            -1.2       22.65        perf-profile.children.cycles-pp.__sigqueue_alloc
     26.16            -1.1       25.06        perf-profile.children.cycles-pp.__send_signal_locked
     11.31            -0.8       10.48        perf-profile.children.cycles-pp.collect_signal
     14.50            -0.8       13.68        perf-profile.children.cycles-pp.do_send_sig_info
     12.06            -0.8       11.25        perf-profile.children.cycles-pp.dequeue_signal
     34.64            -0.8       33.86        perf-profile.children.cycles-pp.asm_exc_int3
     18.01            -0.7       17.34        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     18.70            -0.6       18.06        perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      3.08            -0.4        2.64        perf-profile.children.cycles-pp._raw_spin_lock_irq
      2.42            -0.3        2.10        perf-profile.children.cycles-pp.signal_setup_done
      3.07            -0.2        2.83 ±  2%  perf-profile.children.cycles-pp.set_current_blocked
      4.10            -0.2        3.93        perf-profile.children.cycles-pp.recalc_sigpending
      1.54            -0.0        1.50        perf-profile.children.cycles-pp.fpregs_mark_activate
      0.07 ±  8%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.from_kuid_munged
      0.09            +0.0        0.10        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.08            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.raise
      0.12            +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.rep_stos_alternative
      0.09 ±  5%      +0.0        0.10        perf-profile.children.cycles-pp.check_kill_permission
      0.23 ±  2%      +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.send_signal_locked
      0.05            +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.generic_perform_write
      0.23 ±  4%      +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.stress_time_now
      0.05 ±  7%      +0.0        0.07 ± 11%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.26            +0.0        0.28        perf-profile.children.cycles-pp.__put_user_8
      0.31            +0.0        0.33 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
      0.06            +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.vfs_write
      0.52            +0.0        0.55 ±  3%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.07            +0.0        0.09 ± 11%  perf-profile.children.cycles-pp.ksys_write
      0.07            +0.0        0.09 ± 11%  perf-profile.children.cycles-pp.perf_mmap__push
      0.08            +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.__cmd_record
      0.08            +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.cmd_record
      0.07            +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.write
      0.07 ±  7%      +0.0        0.09 ±  9%  perf-profile.children.cycles-pp.writen
      0.38            +0.0        0.41        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.26            +0.0        0.29        perf-profile.children.cycles-pp.profile_signal_perm
      0.07            +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.08            +0.0        0.11 ± 10%  perf-profile.children.cycles-pp.handle_internal_command
      0.08            +0.0        0.11 ± 10%  perf-profile.children.cycles-pp.main
      0.08            +0.0        0.11 ± 10%  perf-profile.children.cycles-pp.run_builtin
      0.46 ±  2%      +0.0        0.50        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.46 ±  3%      +0.0        0.49 ±  3%  perf-profile.children.cycles-pp.get_task_cred
      0.40            +0.0        0.43        perf-profile.children.cycles-pp.rseq_update_cpu_node_id
      0.72            +0.0        0.76        perf-profile.children.cycles-pp.check_xstate_in_sigframe
      0.22 ±  6%      +0.0        0.27 ±  4%  perf-profile.children.cycles-pp.x64_sys_call
      0.57            +0.0        0.61        perf-profile.children.cycles-pp.__get_user_nocheck_4
      0.77            +0.0        0.82 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.57            +0.0        0.62        perf-profile.children.cycles-pp.__get_user_nocheck_8
      0.64            +0.1        0.69        perf-profile.children.cycles-pp.__put_user_nocheck_4
      0.71            +0.1        0.76        perf-profile.children.cycles-pp.kmem_cache_free
      0.96            +0.1        1.03        perf-profile.children.cycles-pp.__getpid
      0.42 ±  2%      +0.1        0.48 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.82            +0.1        0.89        perf-profile.children.cycles-pp.sync_regs
      0.24 ±  2%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.prepare_signal
      0.69            +0.1        0.76        perf-profile.children.cycles-pp.rseq_ip_fixup
      1.77            +0.1        1.85        perf-profile.children.cycles-pp.fpu__clear_user_states
      0.66            +0.1        0.76        perf-profile.children.cycles-pp.restore_altstack
      1.06            +0.1        1.15        perf-profile.children.cycles-pp.save_xstate_epilog
      0.97            +0.1        1.08        perf-profile.children.cycles-pp._copy_from_user
      1.60            +0.1        1.71        perf-profile.children.cycles-pp.__restore_fpregs_from_user
      1.12            +0.1        1.24        perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      2.49            +0.1        2.61        perf-profile.children.cycles-pp.restore_fpregs_from_user
      1.94            +0.1        2.09        perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      6.54            +0.1        6.69        perf-profile.children.cycles-pp.stress_sigtrap_handler
      1.76            +0.2        1.93        perf-profile.children.cycles-pp.clear_bhb_loop
      3.66            +0.2        3.86        perf-profile.children.cycles-pp.__fpu_restore_sig
      9.04            +0.2        9.23        perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
      3.76            +0.2        3.97        perf-profile.children.cycles-pp.fpu__restore_sig
      4.61            +0.3        4.87        perf-profile.children.cycles-pp.restore_sigcontext
      3.51            +0.3        3.81        perf-profile.children.cycles-pp.get_sigframe
      4.07            +0.3        4.40        perf-profile.children.cycles-pp.x64_setup_rt_frame
      2.36            +0.4        2.71 ±  3%  perf-profile.children.cycles-pp.native_irq_return_iret
      2.50 ±  7%      +0.4        2.94 ± 10%  perf-profile.children.cycles-pp.aa_may_signal
      7.14            +0.5        7.68        perf-profile.children.cycles-pp.handle_signal
     22.43            -1.6       20.85        perf-profile.self.cycles-pp.do_dec_rlimit_put_ucounts
     22.94            -1.2       21.71        perf-profile.self.cycles-pp.inc_rlimit_get_ucounts
      3.06            -0.5        2.60        perf-profile.self.cycles-pp._raw_spin_lock_irq
      4.08            -0.2        3.90        perf-profile.self.cycles-pp.recalc_sigpending
      1.47            -0.0        1.42        perf-profile.self.cycles-pp.fpregs_mark_activate
      0.07 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.do_send_specific
      0.10            +0.0        0.11        perf-profile.self.cycles-pp.rep_stos_alternative
      0.09            +0.0        0.10        perf-profile.self.cycles-pp.asm_exc_int3
      0.08            +0.0        0.09        perf-profile.self.cycles-pp.error_entry
      0.13 ±  3%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.send_signal_locked
      0.12            +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.signal_setup_done
      0.07            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.irqentry_exit_to_user_mode
      0.32 ±  2%      +0.0        0.34 ±  3%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.24 ±  2%      +0.0        0.26        perf-profile.self.cycles-pp.stress_sigtrap_handler
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__sigqueue_alloc
      0.15 ±  2%      +0.0        0.17 ±  4%  perf-profile.self.cycles-pp.handle_signal
      0.13            +0.0        0.15        perf-profile.self.cycles-pp.restore_fpregs_from_user
      0.25            +0.0        0.27        perf-profile.self.cycles-pp.__put_user_8
      0.30            +0.0        0.32        perf-profile.self.cycles-pp.mod_objcg_state
      0.24            +0.0        0.26        perf-profile.self.cycles-pp.kmem_cache_free
      0.35            +0.0        0.37        perf-profile.self.cycles-pp.restore_sigcontext
      0.24            +0.0        0.27        perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.26            +0.0        0.28        perf-profile.self.cycles-pp.arch_do_signal_or_restart
      0.37            +0.0        0.39        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.12            +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.rseq_ip_fixup
      0.29            +0.0        0.32        perf-profile.self.cycles-pp.do_syscall_64
      0.26 ±  2%      +0.0        0.29 ±  5%  perf-profile.self.cycles-pp.__send_signal_locked
      0.17 ±  3%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.__x64_sys_rt_sigreturn
      0.26            +0.0        0.28        perf-profile.self.cycles-pp.profile_signal_perm
      0.38            +0.0        0.41        perf-profile.self.cycles-pp.save_xstate_epilog
      0.39            +0.0        0.42        perf-profile.self.cycles-pp.rseq_update_cpu_node_id
      0.47            +0.0        0.50        perf-profile.self.cycles-pp.__fpu_restore_sig
      0.21 ±  2%      +0.0        0.25        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.20 ±  8%      +0.0        0.24 ±  3%  perf-profile.self.cycles-pp.x64_sys_call
      0.56            +0.0        0.60        perf-profile.self.cycles-pp.x64_setup_rt_frame
      0.55            +0.0        0.59        perf-profile.self.cycles-pp.__get_user_nocheck_4
      0.60            +0.0        0.65        perf-profile.self.cycles-pp.__put_user_nocheck_4
      0.55 ±  2%      +0.0        0.60        perf-profile.self.cycles-pp.__get_user_nocheck_8
      0.29 ±  2%      +0.1        0.35 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.46            +0.1        0.52        perf-profile.self.cycles-pp.get_sigframe
      0.82            +0.1        0.89        perf-profile.self.cycles-pp.sync_regs
      0.23            +0.1        0.30 ±  3%  perf-profile.self.cycles-pp.prepare_signal
      0.24            +0.1        0.31 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.20            +0.1        1.29        perf-profile.self.cycles-pp.stress_sigtrap
      0.96            +0.1        1.06        perf-profile.self.cycles-pp._copy_from_user
      1.02            +0.1        1.13        perf-profile.self.cycles-pp.fpu__clear_user_states
      1.49            +0.1        1.60        perf-profile.self.cycles-pp.copy_fpstate_to_sigframe
      1.59            +0.1        1.70        perf-profile.self.cycles-pp.__restore_fpregs_from_user
      1.75            +0.2        1.91        perf-profile.self.cycles-pp.clear_bhb_loop
      2.36            +0.4        2.71 ±  3%  perf-profile.self.cycles-pp.native_irq_return_iret




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


