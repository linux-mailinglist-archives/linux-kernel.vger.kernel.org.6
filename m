Return-Path: <linux-kernel+bounces-240728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BC79271BC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8A5283930
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D0218F2CE;
	Thu,  4 Jul 2024 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNHkY5DX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2E04431
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720081856; cv=fail; b=dI7wYsb4/y+xFsdXQ0fH1vHw3WohB3T1koo4eixb1VivFR4/pjm/1CIwa2L4IS8xcFEuvGaedPS+l+m+ajRYlyqxQdJsIVhhzc/9lMcdrBDRPFlQX5m1YmWkOMUgvq/3hrzESdPgWkn3I9OwRzD3A/+SIY55e77eTnLUfYfaxk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720081856; c=relaxed/simple;
	bh=+CuJ5oMjgbdwZ1GI8ctdbdwoDBf4/Sns3qj4NvcPIj0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gc1+2dlE4GhGU721dbOC2/GkanG4z0EKsjEK5ez7+nYmWU7S9PQ+Bkp/KTRfvac1/WTiwvym5eYZj5DR59WMxKa92A9VWKEBJZGRdgO6jxXKL5xzeZqNVbGYIeBUwA8VbZV0WnUF5I0Mp1UPXPetcZ6IuRg56aol7FpSimVRLGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNHkY5DX; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720081854; x=1751617854;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=+CuJ5oMjgbdwZ1GI8ctdbdwoDBf4/Sns3qj4NvcPIj0=;
  b=nNHkY5DXilV59sEDvplcfLulI45oC8uVwnRYFbcNhgRlyeI1Bzbn14QH
   4Z0RV1mmnpzQsssAHCNKPuij9qGNGl5zMOQ4b8LO+zoyH+/wWuMRL5AB2
   QuLX0x0TjTclimtbxKyPeMzI75GWSo992e0OSqj5bMvvA7p6/tgzHRa1e
   1XNr5glSSNARRc7+cqiF0F5/x0vGIy+0adT1FpHulKc1MWxrP9pqdOFas
   32YlS6rFelIiYLwVsclvN3rKN/lqC2WeH/9XRPXgznduKDv01rzW0aHs8
   fUWkKTHxtda+JaV1deeokubGRnqgUowjs1YtyQ1HeJ3SQvgoE10YepoMC
   Q==;
X-CSE-ConnectionGUID: NVadw2SNS6izaqn1XxfGzg==
X-CSE-MsgGUID: ANEKVtKbSTm9ZGrXbxF0Pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17488890"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17488890"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 01:30:51 -0700
X-CSE-ConnectionGUID: XH8GBEGhS0yNnd/CFzQwlA==
X-CSE-MsgGUID: aFWwgkz6SPyvH2SyccIRlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46464252"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 01:30:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 01:30:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 01:30:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 01:30:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahHlnfLiK1ZkAOOX+Bzd4/6Tec3SbjUPL578sdjpTGoCH9UZglQi6CPE+2D03sPBKI4jH6yfs8EkPmNPbgEUhV4KuZIs6WrRW0NCvZJ2b7kia8BlOgMOJbj4Vu0Xjlg6C0dQcZeq3UoqjKwRcuUxGdz3ANR1gtM99ZQ9n+Rc2ybhJDU8lSnLHWFPRNQaNLM/GBoPrPp0ZSFxkB8oZyjJeeue/zhstOklyTFx1KXCBo2Yl8TFqy3dAic7BcuqT5Zt8uPQFlrLMUrgvov4oKe88gkZQ8+NUP1eSm3AI97jViz5Tm8aCc7m/pvxXKZnwYk/qiJz8TG2A/dc4aVG7ypHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0juZLwKJgDkDxCoc/2+t55Sdme8VAb9Myd6AvTq6soU=;
 b=QAWG+RwaaAqCYUX+sY/06aHVuVlBDKmjEZ8hJot5ZVBJWUbIjUF7lzJtyURHdC2xbOVL36cPzb+DH7zIAXN3TdpSASBlaxZ/6DwwC2fk/olTn6ZmjQ2xjwaL9rtCxs4OGtiX9PdDO+P3fBmAcyMTEPLlwTVSfFQpU2x/mgEFzOh3HdINPo7VFmokWtvZ+5PnaB3RYinly1MmaO6l4CoMdqqs3MmUAZSD9ft3ABqwSU5KhvBzWc7Qfnlf6lzzK9LhDWtZx1kDpn8eNIoPSb8ZG8m/BsAcP2dkMVceJzVagFHS6jXWCDgMyXhHRRshxZhCAu7uv4Tsvj+NtVxm7x6tHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB5794.namprd11.prod.outlook.com (2603:10b6:510:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Thu, 4 Jul
 2024 08:30:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.7741.025; Thu, 4 Jul 2024
 08:30:45 +0000
Date: Thu, 4 Jul 2024 16:30:34 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Xavier <xavier_qy@163.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, Xavier <xavier_qy@163.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH-RT sched v2 1/2] RT SCHED: Optimize the enqueue and
 dequeue operations for rt_se
Message-ID: <202407041644.de55c25-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240629112812.243691-2-xavier_qy@163.com>
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5c103f-93d4-47a0-6698-08dc9c0399a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m8oY/PUsoDoop52Xfe9X6dXhBM89BVdpEiA4FyeHBl8WyrZBGTVeO44wTerJ?=
 =?us-ascii?Q?NE6Q2XV70ear2ZApy3/uo7beP4eD9se3gqfjpLnPp5woje/1oAbONVLHK+Wy?=
 =?us-ascii?Q?gNhuf1S86VDnOGi3ohmqfWbnFqHxOfXFgdUT4kqH0toHCBarGSdjmB/Fk/S+?=
 =?us-ascii?Q?B01Ew6s1vCKze818vRw++/62htOBQ29Q6xkxqN06UuuAv+ikHRgMH9iZwKtE?=
 =?us-ascii?Q?mWLQel3dxfoYi5Hz3ULF/hde6tqC+DSzuSKft6hZoagdF5thqyfqsEsif09T?=
 =?us-ascii?Q?0NLQjS9l5C4x0pNll4tip6VrmQHTm/bCA+ZXch4rF29IKSHuVk7CjDAxCnQn?=
 =?us-ascii?Q?QlL5C6xNHufXj657gv930IKOyEV5o9GR4Dc9Fzw7Hg4SVYsAwBRrSa1xI2Qa?=
 =?us-ascii?Q?vMGVyA+QADQbxC+3ybxKdfpEp5w6s6ymxmUSaJ7bfI7aqGnOlagfoE31gxk3?=
 =?us-ascii?Q?qBylEdKeMVhza6nrvFjRuLx1YygU0i/o7CuMNF4ZcRxUoYnG5Htuo47HI2GF?=
 =?us-ascii?Q?ud88EM/W98vZU8qrjfe2chYzuMGOE2GXoSnf0JSfDUn55y1w2tA1PBQ/RZgc?=
 =?us-ascii?Q?hAvNmV0nLZ0yDSnLBVlUIZ1omOOu7RPAmSCy/Dfwi7stmLsXKfEpJf6yIVOh?=
 =?us-ascii?Q?yP7eiyzdZO/AGUxx4uEXujY/liQnnaI6oKM34g4KRrC1SYesr5HIEOlr4Z1i?=
 =?us-ascii?Q?6uVgYU5OlFgqJEZUVkrVppAbV6aJVAkBxFKOJEYm5Ic+Rx/KhmavkQywleEK?=
 =?us-ascii?Q?H4ZYE99OfV1Cy6LjftuoNXtILW1awckBpxF5YXpElOkhoCmY7KWtjbcEN6Qs?=
 =?us-ascii?Q?pPg9H/dhsq/+VwNH3n6ZHTT1Xq6Fnmikj3j2vDgGroFzjWJ0cOzFu3YEWckR?=
 =?us-ascii?Q?dGkzzQZc9r5uq/s/HVdpHeQMrYgnaCBa4VabQOO2oLcCPQBHnxGIyT6r8v0z?=
 =?us-ascii?Q?/yE+oUrhZZfhqtWSNbx4V628jcpCZaLEO7tj8V7u/D7/VQWgSgT2RhFOxYnK?=
 =?us-ascii?Q?92bARiGXiOstahRQ5iBG5sST4M+yDkbCzZVHiQpWxg22gwg1Zk6zTRhsS8S/?=
 =?us-ascii?Q?2kPZt0YjpDa4rM4k/KidXtdyxTmoZ+v74dIxYDTlFq/FJSV59Gkjv9+H4laN?=
 =?us-ascii?Q?DMJEZLfUh2scmM8jBH9PE98qvsGilI1nmm65lBgTVthb/eyLalZszSa58EAC?=
 =?us-ascii?Q?wu7C9Lpo9nc7clNSo4EG5q17jr/c3qM0ByGY/PdgsBWbh7uW/mXvq3+6RpN/?=
 =?us-ascii?Q?XJw/JyfZu/kTlwbXbvkmch8wFDcUxXJ9+44e38Qgl0LYvkWugRo+swSeAcU4?=
 =?us-ascii?Q?V/o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TT0gNO4Vhv5o7iqrYxE5OGYv9bt0ged0ImD1q92TAmf9MReFt9mTkVyQ+Djv?=
 =?us-ascii?Q?hvPPlZCFnkaBT+sXVkovrxxv525DLqkTK/y0Dl/X/U/rVQvOjyKSgUBvLJB8?=
 =?us-ascii?Q?Edhg8HuiOXbPV8IUOjYrDe8TRLkfvyLahVlwv9UE1qK9jqYbi1UB1Rs+en9k?=
 =?us-ascii?Q?SUi+89zm6dxOGKe9G8J8vAwjyXAlj3q8o+FBse7fXkqZgMA9qb7XQfpWWTgi?=
 =?us-ascii?Q?qqwJ1XtAtGMo51YpBRIvYB0Owcrr/lls0vCNIrobrXOpcFUkTtEWgel+L+7l?=
 =?us-ascii?Q?hflo1HYICzoiHVQ0uossX8o+82+qjT1UfvYX/m6WXIz+u3CmbUAFoo6EBLlv?=
 =?us-ascii?Q?9vizsykcoCLW37es5/XlOEd4o+sJO7aeJjNLSC0hKh+5xJa9cRnfUIT3ZMZe?=
 =?us-ascii?Q?lB6vORQwd2m/8+GX/DfKEnwRpZ2KbN+Q5n47rVP/86noDjjUuMnCMJaIRhej?=
 =?us-ascii?Q?4hVN0bCbDinagArBSC+TOlerDCnTYs125Eve98u7GkOoZLw4CBR4nZnU99hA?=
 =?us-ascii?Q?IA/FkPfAJLeMlFVQ3W4f1ZJ67Wl5oriH8q9jtxq/PXDnRYSDnS7hfpOcLqPT?=
 =?us-ascii?Q?X6AIUwO/mhTehKFX7XYkod+JQ6/pDW/y3UqD6nKWEIofzx/0cNNFqdePr71t?=
 =?us-ascii?Q?6XPES8SIuA4k7b2w2hLi5AcXU0vC4vyU710GprPNDXozWo5+AE3EAnlYn9/O?=
 =?us-ascii?Q?arwqr88M3MJqVj2oUaVtb53YtBspHr6/O+Vwz89yqDwGxCLWoQu9n2cW26uX?=
 =?us-ascii?Q?5BeAaLQOOTylHjAbtCLTrL+LjpgEIpwP9bU5x+VP+WDdrUQw30CZ2sT5bFyw?=
 =?us-ascii?Q?TeaHHermpIISUkftCs8x/yuFV8brnyHwlfSjNtlJ9ReAgXWqyrN0pMEF2QDA?=
 =?us-ascii?Q?KvqrhSmNSs0R5qLp2ula8lUMdqUneuZfwK3nz9HUncIsyLHToNGpjXlID4AV?=
 =?us-ascii?Q?CETzkTsQmlzUY+trIjBULRwA6KSJmsxjFy55mKZ7YOLjPga0QPEjTk4v2req?=
 =?us-ascii?Q?9N3c5N3yFD1gSBG6cusiKwVDV8ZDKvCcBFVYDtXeSQxfqdKMnrNl7FSwlt6b?=
 =?us-ascii?Q?t96RYDOFMzmIeUieVvIM7a74B2UMEKZf82vVI1M3M/yBdUpZI4Sgk3D7L39q?=
 =?us-ascii?Q?xWTil7TFR3ls4hvVDFYgKn0ySprnyM8ShjcPwzoe+Or1K166cGZCjTqeK9F4?=
 =?us-ascii?Q?c/1CdjM3EROVUxOjz9QZdD33lIrzdC5Mu2jzN9CVx8B5Embtdb5UP5VOJcd5?=
 =?us-ascii?Q?83Wq+BsUL0Jt7kZqQ7gjPdpATsWS2FlETmOeUL2CIG4M0PXhkjixd4ZTVLk0?=
 =?us-ascii?Q?0LcSgKdSSjBZCFwxi4XvC51CBcPWy7NodfGiiTKkP/fUZ5buuua3D5eUJ64e?=
 =?us-ascii?Q?Uwn0zpgXAOSmRGZYv6Yzam+lct8EvlNrhJru0iC5i0NxIvm9dsD7ASj/s4eO?=
 =?us-ascii?Q?OyZAE31Wz7Nxs1Oq1I2h0hEc+ONw+8GzqFDOKmjXvnAgdHpUsq5stIfD9SNQ?=
 =?us-ascii?Q?97ST0TBSv7cGaAVX3PvozT30CS2MOczfT+/AHZlfjH0l1bprqKPvDQwGIgU9?=
 =?us-ascii?Q?3NA0BgnieWCTZbFjb8Lks5eU9mKiAU2xTul8MyhDbSK2VFxtikKMwI+7Lx7u?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5c103f-93d4-47a0-6698-08dc9c0399a4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 08:30:45.7794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuIfRL+eL1PB6/QsPvKeIGXMS6/a/DBYtrdr4Lu+HX7EjyhWvF9ghUruq02gpg5aUpvtTmJrRt49crkv0SRfVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5794
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/sched/rt.c:#__enqueue_rt_entity" on:

commit: ed0ed14c2b47993c00c4b3cdceabef535bcef32b ("[PATCH-RT sched v2 1/2] RT SCHED: Optimize the enqueue and dequeue operations for rt_se")
url: https://github.com/intel-lab-lkp/linux/commits/Xavier/RT-SCHED-Optimize-the-enqueue-and-dequeue-operations-for-rt_se/20240630-173825
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git c793a62823d1ce8f70d9cfc7803e3ea436277cda
patch link: https://lore.kernel.org/all/20240629112812.243691-2-xavier_qy@163.com/
patch subject: [PATCH-RT sched v2 1/2] RT SCHED: Optimize the enqueue and dequeue operations for rt_se

in testcase: blktests
version: blktests-x86_64-775a058-1_20240702
with following parameters:

	disk: 1SSD
	test: block-group-01



compiler: gcc-13
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407041644.de55c25-oliver.sang@intel.com


[   54.093440][    C2] ------------[ cut here ]------------
[   54.094193][  T705] list_add double add: new=ffff888802a8abc0, prev=ffff888802a8abc0, next=ffff8887892c4dd0.
[ 54.098261][ C2] WARNING: CPU: 2 PID: 53 at kernel/sched/rt.c:1415 __enqueue_rt_entity (kernel/sched/rt.c:1415 (discriminator 1)) 
[   54.103613][  T705] ------------[ cut here ]------------
[   54.113477][    C2] Modules linked in: dm_multipath
[   54.122743][  T705] kernel BUG at lib/list_debug.c:35!
[   54.128080][    C2]  btrfs blake2b_generic
[   54.132987][  T705] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
[   54.138148][    C2]  xor zstd_compress
[   54.142266][  T705] CPU: 3 PID: 705 Comm: multipathd Tainted: G S                 6.10.0-rc1-00010-ged0ed14c2b47 #1
[   54.149087][    C2]  raid6_pq libcrc32c
[   54.152852][  T705] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
[   54.163339][    C2]  ipmi_devintf ipmi_msghandler
[ 54.167192][ T705] RIP: 0010:__list_add_valid_or_report (lib/list_debug.c:35 (discriminator 1)) 
[   54.175322][    C2]  intel_rapl_msr intel_rapl_common
[ 54.180049][ T705] Code: 0b 48 89 f1 48 c7 c7 00 fa 26 84 48 89 de e8 d6 75 f2 fe 0f 0b 48 89 f2 48 89 d9 48 89 ee 48 c7 c7 80 fa 26 84 e8 bf 75 f2 fe <0f> 0b 48 89 f7 48 89 34 24 e8 11 cc 61 ff 48 8b 34 24 e9 71 ff ff
All code
========
   0:	0b 48 89             	or     -0x77(%rax),%ecx
   3:	f1                   	icebp  
   4:	48 c7 c7 00 fa 26 84 	mov    $0xffffffff8426fa00,%rdi
   b:	48 89 de             	mov    %rbx,%rsi
   e:	e8 d6 75 f2 fe       	callq  0xfffffffffef275e9
  13:	0f 0b                	ud2    
  15:	48 89 f2             	mov    %rsi,%rdx
  18:	48 89 d9             	mov    %rbx,%rcx
  1b:	48 89 ee             	mov    %rbp,%rsi
  1e:	48 c7 c7 80 fa 26 84 	mov    $0xffffffff8426fa80,%rdi
  25:	e8 bf 75 f2 fe       	callq  0xfffffffffef275e9
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	48 89 f7             	mov    %rsi,%rdi
  2f:	48 89 34 24          	mov    %rsi,(%rsp)
  33:	e8 11 cc 61 ff       	callq  0xffffffffff61cc49
  38:	48 8b 34 24          	mov    (%rsp),%rsi
  3c:	e9                   	.byte 0xe9
  3d:	71 ff                	jno    0x3e
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	48 89 f7             	mov    %rsi,%rdi
   5:	48 89 34 24          	mov    %rsi,(%rsp)
   9:	e8 11 cc 61 ff       	callq  0xffffffffff61cc1f
   e:	48 8b 34 24          	mov    (%rsp),%rsi
  12:	e9                   	.byte 0xe9
  13:	71 ff                	jno    0x14
  15:	ff                   	.byte 0xff
[   54.186345][    C2]  sd_mod t10_pi
[   54.191424][  T705] RSP: 0018:ffffc90000327b38 EFLAGS: 00010046
[   54.211022][    C2]  x86_pkg_temp_thermal
[   54.214447][  T705]
[   54.220405][    C2]  crc64_rocksoft_generic crc64_rocksoft
[   54.224435][  T705] RAX: 0000000000000058 RBX: ffff8887892c4dd0 RCX: ffffffff82424f4e
[   54.226632][    C2]  intel_powerclamp crc64
[   54.232145][  T705] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8887893b5380
[   54.240012][    C2]  coretemp sg
[   54.244217][  T705] RBP: ffff888802a8abc0 R08: 0000000000000001 R09: fffff52000064f22
[   54.252087][    C2]  kvm_intel i915
[   54.255330][  T705] R10: ffffc90000327917 R11: 205d324320202020 R12: ffff888802a8abc0
[   54.263200][    C2]  kvm crct10dif_pclmul
[   54.266705][  T705] R13: ffff8887892c4dd0 R14: ffff888802a8ac00 R15: ffff8887892c4dd8
[   54.274572][    C2]  crc32_pclmul crc32c_intel
[   54.278599][  T705] FS:  00007f1b015ee680(0000) GS:ffff888789380000(0000) knlGS:0000000000000000
[   54.286469][    C2]  drm_buddy ghash_clmulni_intel
[   54.290934][  T705] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.299764][    C2]  intel_gtt sha512_ssse3
[   54.304580][  T705] CR2: 000055e6a99e25f8 CR3: 000000080473e006 CR4: 00000000003706f0
[   54.311054][    C2]  drm_display_helper
[   54.315255][  T705] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   54.323124][    C2]  rapl ttm
[   54.326976][  T705] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   54.334845][    C2]  drm_kms_helper
[   54.337825][  T705] Call Trace:
[   54.345696][    C2]  ahci mei_wdt
[   54.349201][  T705]  <TASK>
[   54.352357][    C2]  intel_cstate wmi_bmof
[ 54.355687][ T705] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
[   54.358493][    C2]  intel_uncore
[ 54.362610][ T705] ? do_trap (arch/x86/kernel/traps.c:114 arch/x86/kernel/traps.c:155) 
[   54.366202][    C2]  binfmt_misc video
[ 54.369533][ T705] ? __list_add_valid_or_report (lib/list_debug.c:35 (discriminator 1)) 
[   54.373650][    C2]  libahci mei_me
[ 54.377418][ T705] ? do_error_trap (arch/x86/include/asm/traps.h:58 arch/x86/kernel/traps.c:176) 
[   54.383104][    C2]  i2c_i801 wmi
[ 54.386607][ T705] ? __list_add_valid_or_report (lib/list_debug.c:35 (discriminator 1)) 
[   54.391070][    C2]  intel_pch_thermal i2c_smbus
[ 54.394400][ T705] ? handle_invalid_op (arch/x86/kernel/traps.c:214) 
[   54.400087][    C2]  mei libata
[ 54.404727][ T705] ? __list_add_valid_or_report (lib/list_debug.c:35 (discriminator 1)) 
[   54.409540][    C2]  acpi_pad fuse
[ 54.412697][ T705] ? exc_invalid_op (arch/x86/kernel/traps.c:267) 
[   54.418385][    C2]  loop drm
[ 54.421803][ T705] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[   54.426355][    C2]  dm_mod ip_tables
[ 54.429337][ T705] ? llist_add_batch (lib/llist.c:33 (discriminator 14)) 
[   54.434240][    C2]
[ 54.437928][ T705] ? __list_add_valid_or_report (lib/list_debug.c:35 (discriminator 1)) 
[   54.442661][    C2] CPU: 2 PID: 53 Comm: khugepaged Tainted: G S                 6.10.0-rc1-00010-ged0ed14c2b47 #1
[ 54.444859][ T705] ? __list_add_valid_or_report (lib/list_debug.c:35 (discriminator 1)) 
[   54.450557][    C2] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
[ 54.460974][ T705] __enqueue_rt_entity (include/linux/list.h:150 (discriminator 1) include/linux/list.h:183 (discriminator 1) kernel/sched/rt.c:1419 (discriminator 1)) 
[ 54.466661][ C2] RIP: 0010:__enqueue_rt_entity (kernel/sched/rt.c:1415 (discriminator 1)) 
[ 54.474792][ T705] enqueue_rt_entity (kernel/sched/rt.c:1616) 
[ 54.479778][ C2] Code: fa 48 c1 ea 03 80 3c 02 00 0f 85 1f 03 00 00 49 8b bf 40 0a 00 00 44 89 ea 48 81 c7 b8 00 00 00 e8 15 72 05 00 e9 23 fa ff ff <0f> 0b e9 9b f6 ff ff 48 89 ee 48 89 df e8 8e d1 ff ff e9 f6 f5 ff
All code
========
   0:	fa                   	cli    
   1:	48 c1 ea 03          	shr    $0x3,%rdx
   5:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   9:	0f 85 1f 03 00 00    	jne    0x32e
   f:	49 8b bf 40 0a 00 00 	mov    0xa40(%r15),%rdi
  16:	44 89 ea             	mov    %r13d,%edx
  19:	48 81 c7 b8 00 00 00 	add    $0xb8,%rdi
  20:	e8 15 72 05 00       	callq  0x5723a
  25:	e9 23 fa ff ff       	jmpq   0xfffffffffffffa4d
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 9b f6 ff ff       	jmpq   0xfffffffffffff6cc
  31:	48 89 ee             	mov    %rbp,%rsi
  34:	48 89 df             	mov    %rbx,%rdi
  37:	e8 8e d1 ff ff       	callq  0xffffffffffffd1ca
  3c:	e9                   	.byte 0xe9
  3d:	f6 f5                	div    %ch
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 9b f6 ff ff       	jmpq   0xfffffffffffff6a2
   7:	48 89 ee             	mov    %rbp,%rsi
   a:	48 89 df             	mov    %rbx,%rdi
   d:	e8 8e d1 ff ff       	callq  0xffffffffffffd1a0
  12:	e9                   	.byte 0xe9
  13:	f6 f5                	div    %ch
  15:	ff                   	.byte 0xff


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240704/202407041644.de55c25-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


