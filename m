Return-Path: <linux-kernel+bounces-262942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4527E93CEEB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFCAEB22625
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F74176AA2;
	Fri, 26 Jul 2024 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQIx1k+n"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5776F3C30
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721979498; cv=fail; b=L4VIOsjD2zkITkCTINvq53yDxYKOR0I/kvl+RTy+HH/+mSkOupshD364gEWd2/FYH/DAOkojjs6h5CagfyetJvdxBo2P61hE60duvLIDmsD/YrbFgzd4mpmO1z0xihA6zNmF5+5IVd/3UVN3CHS90wZ47/zJKo809wgRyyj08C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721979498; c=relaxed/simple;
	bh=1rITMHk0zKWABZDiWxY23kYVXlEVm9fs1rZ/iV5TtXU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CC6qOHdY9zfI3Ekxtsw2m2Ck2z7PX7UcZSe57+Rat7EUftT4gOxge3xkiaaH7D62uketIzgdzFGt5mYHUJyLw1urU9WUFdhR4G1i37m0tR1fA9Anth1UqI06CjONAOVenKa1XSEd1axg06HNzsfosSck7CZX9jEJFeUBmD4rk/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQIx1k+n; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721979497; x=1753515497;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1rITMHk0zKWABZDiWxY23kYVXlEVm9fs1rZ/iV5TtXU=;
  b=KQIx1k+nmpyEOozSjnbuGd1JRgCRfXfIjill9hEywLgwe5Rc1erAQ1b2
   Kq8jNZq7Pc6g1UdaxiDnvT9/SomySFSOxtl0fli8//AioeERg/mEHCRNj
   DVgcMXhqZPejPF65qVbxH1h0AAqf8X4Zj8/1jBemOGiZcvGCQPDN2UeUR
   8Hg/qvEM18eH0xwCx4CWQnsWq21J8UqNlRy7HVH+FB0aBLKEkgZXVw+QJ
   luoTSTnX/F8iLdaqPJgmdpyMsPiUjkvDNpXxserLrppCveQCbhZDXwZ2G
   7W/PTeXhsXd2Mps1HADeN/Hpin/TMLDaI8HIDdH9t9aUAQk3MmesyMa4T
   Q==;
X-CSE-ConnectionGUID: Odc73MbqRCO+Uueh8NIeUw==
X-CSE-MsgGUID: bGjve7/qSgG6WQvi/t/O8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19899272"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="19899272"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 00:38:17 -0700
X-CSE-ConnectionGUID: nHdss4i2SSa2V8xn3FutFw==
X-CSE-MsgGUID: RPtk0oFqS3eOEvwEtZpQng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="53414908"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jul 2024 00:38:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 26 Jul 2024 00:38:16 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 26 Jul 2024 00:38:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 26 Jul 2024 00:38:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 26 Jul 2024 00:38:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8/KbpOXEyDVpUiCyOfGaiv7sm//iMXNmOKyDZSu66XcD8NWF8fIuKmDUEf34O7SNL1QUiyzswFYsPF/UKwJLFbkXiKNtYJwlioNyJmQr1Jz4cJwpcGmrD6m2I7W/4pW3aFmVVX5vHKshjbLd+m2vySpZuccgAM5EF5KzJgn7O2xsP1t+HEx5VT3uqb/S9Zlb2M/N3cb51d1/rsTudEjAmN+2/eX/GDFit5M19Z1VsrqACnjePlzRiq0btd9cFtZB+mC/EcDfrHgaRnpwdmcjfKXGh8fGPjXm1O/N/cWJfdgXtMYuUlycQXdmHPZHbTgJoIqD7mFsio0PmAUvzyNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26btzvbgL/AiB/w4fzjjfemVUexT29bxOzCavgkcuJs=;
 b=g7rAvmqE0XQrlvL2WfP+W0h5d3KgrDMvmbSec/AGvTVv/FL7v64lVPYdqacyexeMwgwH/W/VU7VFAyivtIWu3mzDSJiA11SqwjKRWBQMpyxy7RXFZMcVoMr/eqI5fdovVLvAbNMf/+5/cZlBkuz4rucmY5FDigSE7geEZwjaodpoMzZfxpSrgLH7h3TecKRL0KGZk1KApPPlh+QAIzFfTQfV6n8AcKBmJhj7RrFlBOnLfITnRyydrTWSs29hi3JPyJyMcGb/wbrg7vcuF6TjTN8JEK4whA6pBJlWkuaBleX3MnOjDB5idarS6GVOWK/14uuEvSeDcj3xoaCRp0oI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW6PR11MB8365.namprd11.prod.outlook.com (2603:10b6:303:240::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 26 Jul
 2024 07:38:13 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 07:38:13 +0000
Date: Fri, 26 Jul 2024 15:38:04 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Alex Shi <seakeel@gmail.com>
CC: Alex Shi <alexs@kernel.org>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [alexshi:mmunstable2] 934c05f8c5:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <ZqNSXJzsUFAsKkXh@xsang-OptiPlex-9020>
References: <202407221607.49138a71-oliver.sang@intel.com>
 <a634bf58-9195-4c6f-b3d8-468d47e71033@gmail.com>
 <Zp8h/ZZTQ0lwmcJa@xsang-OptiPlex-9020>
 <bd36db00-5464-4eb5-adb1-0ddfd3be1cfa@gmail.com>
 <ZqJZNqq74NSAI8vS@xsang-OptiPlex-9020>
 <6fd3684b-1b92-4a26-ae3b-98e5c1800d40@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6fd3684b-1b92-4a26-ae3b-98e5c1800d40@gmail.com>
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW6PR11MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce74843-8930-4ee6-33e9-08dcad45e7f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y0na7tjyAOI0fsvRC1d+mS9XnC4SjijEQJqTb6kfgtGS9lCybOHzoZTC7ztx?=
 =?us-ascii?Q?1ivDIrisBmV2wA1Qhjlf7cvM1kPm+5T2Ve2yhoq70EXAeRxmkv2Ng8rgxUXf?=
 =?us-ascii?Q?JDMe2V/bUHYc79eRa44Tjx8RLgn/Ihzkb07GQx1ajKyIy+Bcv/ofLMbY+GW/?=
 =?us-ascii?Q?ex3dXAzD38g5+VGagpxriTm4mhIQSoeWN+9YpgwMQ16Oewou7JykkQRsX4ww?=
 =?us-ascii?Q?iRgTP7Wr0T+VqeqgfKLSX5W32Wx8VT8JdJGP7dMUWyZCWeKjvFRmre7bVuU+?=
 =?us-ascii?Q?0qPzTW2Msagn2fDZm7X/WrSWT2Udu6AaTQBu3S/i38FbU0wEy6t+DeRrXUAG?=
 =?us-ascii?Q?iTm4AWS2CJfFnEIfZJZzsNAwnK+poz6iXcjfR+osyojLTwVwW9n1FjzN34uV?=
 =?us-ascii?Q?2nuTtEuFEAQeaCEWHzv9oQgR2lEZSQuANvrxwmjNolZwKZK1/eG/M/D2YYfO?=
 =?us-ascii?Q?UWHCLkR8Po1MJY5ypV9133ZioifHCSm3+GYbbKGQm0NkOHqKtsJTlpTz0/tj?=
 =?us-ascii?Q?Vnml3jY+3b2DCMnz5z3dXJGmsKIGuLPRM6eoTUgoKf4MYlHNh1Oig3LmN6FJ?=
 =?us-ascii?Q?OP9pOePgRrW7Zddn/U8kndVihmHtThD2hwzNbE0l/d82Vb/PISRuf7To9bwo?=
 =?us-ascii?Q?S08xMN9tmu8k3rft1HJVlDjXHAdZn1FTtEKSh/13/nmkDsL8Dek6v8l6OOiU?=
 =?us-ascii?Q?YGHNDr/0AOWeryFb1+QYlvDkM4s9p9WH7zacRsEBBztqiJAWgKIJNWX9fjCb?=
 =?us-ascii?Q?j1cv5rEBe5l55YkzSvnR/kln6353t31hC/5/Rt/16vfRWStXkfHuXOc0n+3S?=
 =?us-ascii?Q?fAQHwBH4XfwPulZNWX7c39i72jPAvidjnB5voOA5Xs/2oyoAyHi3DjKrMoSy?=
 =?us-ascii?Q?MXTwNXq8Ll8ZLPwXWikoXmcXYfm7va4YvrDl0Lw6Tl1M+9Ugsebco7TtxIa+?=
 =?us-ascii?Q?BElsutW6yNvqos9I/7O8lUUmPfKKB4kk6Lt+Rd61bZtrD5Ncc8U7grD5iSf4?=
 =?us-ascii?Q?iziI/unIv5goV3nYBouvAToT5ZI1BTSs3oiDsRlcJSz/XYkdtnY5yW8oGsN3?=
 =?us-ascii?Q?C2+EXJQL6qnta/NVM6gCay7B0CRRRv5DIjIjfaei5qsdOMcPkZdGheFw06f5?=
 =?us-ascii?Q?nglqWtyRhfjbVOvHm7KPx6EYjZJgI3zQEXyxU9a/NO09UXjLmEajOQ8D2tFo?=
 =?us-ascii?Q?+S4bKPCioulfFvlBwa52J9fHZRzxKm5kHOH1+HfyyjpvLWdnyvpomuFdIUnZ?=
 =?us-ascii?Q?7G0ooGZh7cdqSc0U9YiZkmm+mUHSXj/E0sIGl9o/KqUrAwKBIZGlKEaNzuee?=
 =?us-ascii?Q?MHw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zGGZ/lTHyerc9aOTehBlY8xXEPA9MocYbYnQSevqfcT4qk6Rq08hAQ40sBNu?=
 =?us-ascii?Q?3XNfPtMY5vgw4fYOSBe6zH85ZeRjam/mouRkXlhskHgyc3RCVggvAub30HVi?=
 =?us-ascii?Q?lriHzhN5mzzX0eEkSlLt15w98xyMECEwxxISSAyn1x5upE3myySw7wLT/bAZ?=
 =?us-ascii?Q?bUCBnGjbDfNHecKBUS/kK46fW8Ay+OaKfVmJh5vgtJL1m0XCZlCeqdeBdFEP?=
 =?us-ascii?Q?KbZfFGOB03lP1O+fXAJW8v/try3D2KLnmkppuUdUTevUcJfaHDk+ywICsEJg?=
 =?us-ascii?Q?3TphPAKZHGQ+/ajNlHYwIa0IvHvk6AmMjGlJT7Wto/JMb5HDri5POCfYQSFN?=
 =?us-ascii?Q?LJgmQFfmHoEamoe9XER70xTj7iClTvh+BQ6ScqFZTmPGegnQnERW5cJbVuYi?=
 =?us-ascii?Q?oS+LDkNVSFSRVJAw1K6K3Qp5Ccf/n5YLtXpyfSqqqGWQ8ZrEJzZ/VVmmQCY0?=
 =?us-ascii?Q?JVkseDmuxNIRffwCdnF47FEzSg4XFqpHyKQwaWAFxTW01t3tSTlYZDRmZzjJ?=
 =?us-ascii?Q?vwgT6lr0EbiwUjuDRZ/x4V+fksBOqG96slroelVQg8L1kZ9accJnkHu9Fe2s?=
 =?us-ascii?Q?lKp1GMLnaj+LXXQY9HipSACfsLmT0Xk9U8I6N1Ss2+nOZZep1XrKo8ZMCLqa?=
 =?us-ascii?Q?E8DyHB/NkF2Wtw9ABFRKipVbPlFJqrRteV1K+3zVR6reYwFGrAJQnqkppFPX?=
 =?us-ascii?Q?cdRbnT1g8+d9XwFOZ2gARzQluEhkoIAs6GELZxoU6kvfCwjobKniSBu42OP+?=
 =?us-ascii?Q?HN8ttP+nzLIg9PVHVCJPnE9pAmRqVMjVdTcCWruQhAuD9JzkxwtuOn3L4BfW?=
 =?us-ascii?Q?r83Bme78w2VW3o1ky0BHK+tJ/UEul7rMWQknzSt0wSj10MWVbazPtAhkO46S?=
 =?us-ascii?Q?WuazjUj4WfP7nsyuH410UWVmygF+Zr3B0VroUj9exSHw71bjBO1pYXjuC+Po?=
 =?us-ascii?Q?l9DtF5lpCS+/t5F3HhFqCDYdtrGlEAN1TeCpK5s7N65imFSTI41O5Jmwc0+l?=
 =?us-ascii?Q?cbOxS+tyQq4VaN3nPIvYyoRzDd37iHlejk2HMqqgGkP5zfZppzy6+Bqx76so?=
 =?us-ascii?Q?fHbuNzHUZ3tXrA53UJ0c6gSwgvJJdqFy1kYs6yTarwZPqxonS788gUYKJMNZ?=
 =?us-ascii?Q?fTj6e0DJQ0hhTentiMDA04OoWcKj5NN47Tg6qCiVTP/jh3rK6X5ovgfb7tiI?=
 =?us-ascii?Q?mjccD0hKgHbjNbwph14owoiVSTQV9XQ/Fo06jzmp4O+RTdF2EGNA6M+XQXxq?=
 =?us-ascii?Q?dUML52S9f3b4WXMXt66lP0082mUJkKEx30briC5OgaC627E8wkTNy90BiIHW?=
 =?us-ascii?Q?T1QcM/S/IVzqsY4cAyS2JdDsqjdvqOpBnz8tZ5r4jZ1Cuo9053/V2cey4HyD?=
 =?us-ascii?Q?dfbv8sfJ73micwsB5wdQRP0Nbcd7Ur2wmwMS1fhdXjAfkSJ/AJ7Qnl0efLGV?=
 =?us-ascii?Q?gIH+4LqiSr5wrPx4RT6gh8SIHAzm4ZL7NVEPM+6cDipO5dUzCNZhyVuJE9RB?=
 =?us-ascii?Q?xEmd5E0+rHSehw6MK1EIXq18/qvOGCgDgniOCrWfB+FILCV+ZNw+qAhm2q6k?=
 =?us-ascii?Q?6dTPNS7FjLZvEPXB2r0wh1fQdM2FVabo1jXIE9AM5+d6tPWBe0y5+jPXDkgz?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce74843-8930-4ee6-33e9-08dcad45e7f6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 07:38:13.6526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6xD4Y+jYi2SFSbCEwe5xBYkTAzy10kjIy70EFOpGTBpSp8eRZeW5laie5+UVAlczKdPji9hr/0HWRd5nSLtfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8365
X-OriginatorOrg: intel.com

hi, Alex,

On Fri, Jul 26, 2024 at 02:11:31PM +0800, Alex Shi wrote:
> 
> 
> On 7/25/24 9:55 PM, Oliver Sang wrote:
> > hi, Alex,
> > 
> > On Tue, Jul 23, 2024 at 04:23:00PM +0800, Alex Shi wrote:
> >>
> >>
> >> On 7/23/24 11:22 AM, Oliver Sang wrote:
> >>> hi, Alex,
> >>>
> >>> On Tue, Jul 23, 2024 at 09:58:25AM +0800, Alex Shi wrote:
> >>>>
> >>>> On 7/23/24 9:05 AM, kernel test robot wrote:
> >>>>> hi, Alex Shi,
> >>>>>
> >>>>> we noticed there is a mmunstable3 branch now, but there is no same title patch
> >>>>> there. not sure if this report is still useful, below report just FYI.
> >>>> Hi Oliver,
> >>>>
> >>>> Thanks a lot for your testing and founding on my unreleased code branch!
> >>>> The problem should be resolved on my latest code yesterday.
> >>>> But multiple archs maybe still are fragile in the branch. Are there bootable in virtual machine, like arm, s390, etc?
> >>> we did boot test in vm, but only for x86_64 or i386.
> >>>
> >>> you may notice we also send another report
> >>> "[alexshi:mmunstable3] [mm/memory]  f6ba7ce983: kernel_BUG_at_mm/page_alloc.c"
> >>
> >> this problem was fixed too. Anyway thanks a lot notice me of this.
> > 
> > thanks a lot for information! just was wondering which branch contains the fixes?
> > 
> > I ask this because we still have some bisect results pointing the commits in
> >   mmunstable
> >   mmunstable2
> >   mmunstable3
> > branches in https://github.com/alexshi/linux.git
> > 
> > are they still useful? if they are out-of-date branches, we won't send reports
> > to you upon them. thanks
> 
> Hi Olive,
> 
> Sorry for response late, I have some issue to deal with lately. 
> The mmunstable2/3 are removed a couple days ago.

got it. thanks a lot for information!
our 'gitmirror' mechanism is not so smart that we still have your branch snapshot
internally...

> 
> Thanks again for your great job!
> 
> Alex
> > 
> >>
> >>>
> >>> for both commit, we made some further check and cofirmed they cannot boot
> >>> successfully on both vm/bm, again, we only test x86_64/i386 for now.
> >>
> >> Thanks a lot for the info!
> >>
> >> Alex

