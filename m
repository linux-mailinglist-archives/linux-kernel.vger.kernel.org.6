Return-Path: <linux-kernel+bounces-353591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F6A99300C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BDDE288079
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9302A1DA618;
	Mon,  7 Oct 2024 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5K7M//l"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12C41DA313;
	Mon,  7 Oct 2024 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312650; cv=fail; b=QMHXKfNPXkHclMDQQq1MynZU20WL0+Em3UcWC8AOrBuCA2yLDK8Q9wpnBsX46CBNRGvSuj5N0h5ZA4y3vuFoLmG5xpI4ELD+dIzUzv9IgQ1mtpE5Q+9iCigxNmnpWd1ZMkp9fJsvHBa3JdIAq3H1aHMMaC6A1tm4hHzynHnAy/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312650; c=relaxed/simple;
	bh=3A9YSKL7htku69uXhnHVjUX4lNvCF4E9FP+ksbeWfHU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uxnJ43gE2/1Z96sWJVKx+Vh9Xx9YiXg1UrVkZxPSSbC+uCL3AtUnIU+OsAKMSUe6KdPwAur/pa/gInt1dW2x0R4aJ+7MH27uv49L2Bku2kGswHHIRuDGlxwR2jBBIuFSNeu/eOhFb9BZ54EtOXKEPMvWD2Tk9ZoqU4bxNL6M66w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5K7M//l; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728312649; x=1759848649;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=3A9YSKL7htku69uXhnHVjUX4lNvCF4E9FP+ksbeWfHU=;
  b=V5K7M//lAR9Ppnf+2d16/7W32KZlVspY93I3bwKFIWgD3Unso68xigjJ
   EaxpC8HYqnXLkGa/UnhTh5IQFEzxyilT0TgP8Ksowro5VAi8pP+dyiEcl
   Dui6l0UFWt8UemkhiVb2jRRKn86wPcsYzWfW8JVELj77lG5lPb9GKJvw2
   QR7AGkC3rHJJtbYVjJdV9zNM06jCH/OSZLyUXjn2pEV0e/IZjvtk81OEE
   atNGBTn7BU/zjR6riIuNBcg/NvU8tkVrWnb+/kCIrkDayIH1KoMi16jNy
   nsYBVlam0UOZ39It4cBLWRU50Qyxi8I7zDmSUPOnPHaEia0WvbuV1UJFJ
   w==;
X-CSE-ConnectionGUID: nWKBYH4IQFu5hAxado8tgw==
X-CSE-MsgGUID: bBH+SN4tSbWPSCvblKP5gA==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27405547"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27405547"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 07:50:48 -0700
X-CSE-ConnectionGUID: O7fOJzwKQ46UA09kW3t4JA==
X-CSE-MsgGUID: Sg05UiHZR4O0bWG00VCvBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75613655"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 07:50:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 07:50:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 07:50:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 07:50:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 07:50:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQTnhIF4dqZE4aWBZsStoUiDOKfRF5uB6SljL3oJ1QW0as0g1WG1hL760a0W2ClgBzGleinQC+X80XHpzj77zF9vmg7Y8V9ltu8DUMtvrhZs8oflohGrMtzqq82c0zhBtgYncwBZE3pV7qZFQbTnyc1wvWz/+F8YwVLD3fCEM/OQewwPz6OB+6eQ943AwSOQBNbiXVCzrl7EZF2v4n8YlDP6xsd9fku8eEsGFARdJ4Df6xOCkfhIp2hpzZoSoq4I2SQpS03KPlbm5I39NmKJjU+FHxmbhKp2RlOjFZ/d1LNOuMk4K0XHVrDRpXivBYsxZoAN9s4DBccinugiXCwXRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDGkHWDDs45O+xh37RsWNxN1qd0aPGLeaRzDIacSw94=;
 b=j9iJlOcYKjAINlHN4BjC/o63I7HC6ZP/yRcsu5zPJHO+8l597jY/imHWnNB8zpgnBeWqoi6vN6OzUpnS8WeBkHDXHlDMtgUPj7laLnyvtd+RlNKt0uAq3Ay62MumA8mT7JUg/u5b8mDQNtfFo97CjbeDp8VZ9U+O+idk1pX9VcBPwmmICjTh3jT1MhZAYKdAqjsJQWv//CAj4tZ0dZQnsisoQ2u7LRQISh3nIj1yL5kaaf0NQZWVjqFHOhTD67DLcf4Ti8Y+npRKihqwikiVrvE+upl4quxlDdojDgiakhpFTWmtOktVbssgNscNFpNmKZW6K8HpB8qArEjGWxE5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8443.namprd11.prod.outlook.com (2603:10b6:610:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 14:50:41 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 14:50:41 +0000
Date: Mon, 7 Oct 2024 22:50:23 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Nicholas Piggin
	<npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, Will Deacon
	<will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng
	<boqun.feng@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, John Stultz
	<jstultz@google.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Andrew Morton
	<akpm@linux-foundation.org>, Frederic Weisbecker <frederic@kernel.org>, "Joel
 Fernandes" <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, "Mark
 Rutland" <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>, "Jonas
 Oberhauser" <jonas.oberhauser@huaweicloud.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-mm@kvack.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	<maged.michael@gmail.com>, <rcu@vger.kernel.org>, <lkmm@lists.linux.dev>,
	<oliver.sang@intel.com>
Subject: Re: [RFC PATCH v2 4/4] sched+mm: Use hazard pointers to track lazy
 active mm existence
Message-ID: <202410072229.18756716-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241004182734.1761555-5-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c6ed8b-5c6b-408f-e4e5-08dce6df6a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sRsm/F66TRQ8G5+5L+7FCRrl1NA6rzW4SLqrK6m80LLzqX6ui3IXZ10QBL6C?=
 =?us-ascii?Q?Wnx03Dl12smPs36saG8c0UBzoKjfTeAlaKu06kM9ruj4GH4Ru/rXlvU3CTFn?=
 =?us-ascii?Q?ew57VpHHvqL+jqP4Pb8n6SmFj1fZQcYxDtRFQpdSEhvIYm9B+D82w5twXeoL?=
 =?us-ascii?Q?VJiiUeD10FS0zgqJR09JOHYMOj23GZo3ulpjay6V47Nk8v7jBMmkRM7VolgW?=
 =?us-ascii?Q?JluFXCzks2T1X4BiIC8fhWUqTnFz9sVyr+i0eUCIu/GnboVpZ0I6wAuTi8J5?=
 =?us-ascii?Q?POt1VpeU2IPrDnHqs+GyrckTZCHyCb7gVyvhUQgblQw/QMIkvjO1dx2N4Ibq?=
 =?us-ascii?Q?0nVbqVhEBVXo81tVij6/W2/r5i4zjGGm+mTZFTNb4BDxmeA2wftFz0VlU15Z?=
 =?us-ascii?Q?BaFmKDJKrIaPWGwXEmNboTeYe0IHDHMjlIdlXlA6bQcWyM1tg9ctJWHCYLlb?=
 =?us-ascii?Q?9IMVVmZDQFC7iYeVZAm9It6otbtT0uXumNisUceN1ENbGa/TI0RBMSzRNUJD?=
 =?us-ascii?Q?Oa5xUQep1Fe76x7LvQp/TDtAi2adHPypSc+xkaHzdTE017N3CGa/kEhNE0Z0?=
 =?us-ascii?Q?2pgz6nnvzntqr07/njgzN+CafjIuG87Xqo7vJfUNakkbiTV075u/7x8qkxha?=
 =?us-ascii?Q?YarII+g5084tqvKuoQqX6QyE4STAWLBvFrtrcmK0tleGblE4FNYe18ciq6+U?=
 =?us-ascii?Q?DgkNbc76+s1WAfAheSNV0MwMwvHuR6PQofXMGlHgAYniRABNK7BT6/4ZXW5B?=
 =?us-ascii?Q?h5mJt03LQrWtYbuRBiOcRrhvT0dkU258nMgOq+wKIwX3LQWYjcL13AkWlSgX?=
 =?us-ascii?Q?ry6haFyWb78dkaMFaRFdtfVniexV0v6l8SuI+/e3SLRhsLaaAaAR2TZypxNy?=
 =?us-ascii?Q?3w5YF+w/95WFqLuVn/odXsFVsaWORucyiRoKlKuZVCqMjQNZxnuFGxFlnT2Y?=
 =?us-ascii?Q?+GJHC6HyM/fwmtrwyD3tFMYWHh6wtV74KkDGA4/q9t24FgyOpH3ZjS3awuc+?=
 =?us-ascii?Q?wLPe7Y4LsTdvdLpZCH9vhTYAdi/ykNqdlOdSM2LpIS9p7pLWibCGqzTin6yw?=
 =?us-ascii?Q?06N3q8glUYUc+91j8k3Yfni/P//NIMOr/xrRievt0qAxs75MKtD5aGp3//14?=
 =?us-ascii?Q?2Kw5kZvcnntoU7uSReDcWFBt3J6kue+YxH/Ng0VP7KvXqP3aqUvPXx5h21rH?=
 =?us-ascii?Q?T4HVALQcl+cz6kWyKNN5hIL9s0mawfIS3u1C1gry6peRSFJgqJ/owqqLFyQ?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iSidgc5pCRc0Pl/K5VPGQzIHgvz9Q/zEL57Nfjs8+sUvsgH2K1Qb4M+4tUH3?=
 =?us-ascii?Q?MOJHZcogjOEH18sdoWkzWTS8dPBufo1eD3BQufzw57hVxzL4DsIKkSmxPW4z?=
 =?us-ascii?Q?1oSGcbhKY03JUlxPSqvs289Ci5VFB7vvsT0mCIi349A1UO5dbk5Huj2fSFC8?=
 =?us-ascii?Q?EOXEUfDvYsZ8KMnyip1FgGddBb1v1mQY4uLEWYOJ/QtYqWLKB79PF8d88VhG?=
 =?us-ascii?Q?tbQRiZNcih4ik5ZMTsHm47thB16CqPVSMSMb90MdHg9d9kQMkYjkDCmUT3xt?=
 =?us-ascii?Q?9JX3ov0hytQgOALfQDhfwI6sK2fA5JhvRLhq11pJ4y4EQydYxsbHd37lYN7T?=
 =?us-ascii?Q?QTmVzb6V6YBgrMWXJYUHuFI5yvW7yNFFWgLUuwKtBBmU7cOeCKutYUc3x3bD?=
 =?us-ascii?Q?V7+nDpMZvkuBMmfSyfziAQcNWVdzvpKdJGEeXp0qkmTGe0g3htjxdQ22jXIR?=
 =?us-ascii?Q?UPmIPBnyyoZBApP6lL2XUdE7hhDsqpWV1s1612K/4j6fYvSMZRjRMHCfrjVA?=
 =?us-ascii?Q?a8fybkS5D6rts6G16NuGDtjSxQJQTrG7bWGr0BLiyst80btnxA15AIh5qcUR?=
 =?us-ascii?Q?6TAgtNYW2JbwhQ1WGdT5+wj1vfXIESLbX8lPUZxm43Vwl6vaITMg0SFbBYup?=
 =?us-ascii?Q?KxFYueWyMfrU5Mu61xXDjiOzlJjb4FGVyfM+prFcanPZ8EJJpxL15AY0q9ua?=
 =?us-ascii?Q?0TVlOXQRKK0i/vwkmwWZkrk93GpkQD2jt0/wmp3GVH6irnf7hexexBZlvWxK?=
 =?us-ascii?Q?cvB7tdsmNh3u3i41emZ9Rz2cg+ogEOwW2/8rS//OW/jp9BQrNOQv6FyG7xKc?=
 =?us-ascii?Q?QxoHORzGLFlqQTNQUijvd0+rJ3MM6iHDWS9lVu/OKbLBchDjmDx4aOHN0wDx?=
 =?us-ascii?Q?XdpNsKSt6BJruWoCkPoL7gcFlhG6LmAm+5GoQ6GBG27zgpD9hNe2J3UkO4gH?=
 =?us-ascii?Q?sBtbKcuP0Jvz84laY7xfEXiaeLiIKguv8yFXYsxQCbzS7fgSFTlaT6LfNVlI?=
 =?us-ascii?Q?JYa+cH3UTaSWoq3SyCTXMQM3mfktpZG9c30twzdZn/+WLAhwk5M8ZMjsru9B?=
 =?us-ascii?Q?QqE5JW9151SJ/uZQ/HQ7f35tF6fqt9am2PhznIljKnx7vr0bZmeBxsxBobzp?=
 =?us-ascii?Q?/+Hd/8DYHSr88TfFbRDELGKUi9TyM9Nf8o1ePMpsIxRegL4yxNWLduvPaGAg?=
 =?us-ascii?Q?+BMro3NvfoLoHLDZp0hN8c0H3x7++bmBI+q+Q599E6foemtSrJXDukOxD/Tv?=
 =?us-ascii?Q?4np77ItvUsxQd3Cui77SDOjYMZ5kxMB8RaYB8HEcFK4JhGc+JnGkCqNKGpg7?=
 =?us-ascii?Q?ILMEjG/7Y8H9QLiG4N49eM8vzHJydYhRPmvOIPmU4hRTzy8+9os2FwGX8EBn?=
 =?us-ascii?Q?q+RAIclkouSIwY7+zX60ydi0rqGLK5B9WGGDWm0aN+LhAdoHna5xsmPGTY4H?=
 =?us-ascii?Q?6sg/CPLPo9/shsn5tG/zYDywzXlkVt1zBJjnw6XmgXEdGikqUIp6uWnXTu7g?=
 =?us-ascii?Q?x8irWb91SVHMAO/jkH02yLr1ql7qUkbkAE7CZ30wi+11zthJRcsmxDyTrAJx?=
 =?us-ascii?Q?vZJVSoNPnL6w7oPe8qcR+ddzIOq8zuQtQpWOX8pqpS4N/KlRBQ7WpjzSd+T1?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c6ed8b-5c6b-408f-e4e5-08dce6df6a2e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 14:50:41.6780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3LQK6N6/vE0WmWzU1vg1s8z3LunDVskiexYrHEtpiwDvUfuxf+Yd9TqzIJDKK9ZFbvcZyhmIQmSDie2g0MkKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8443
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:using_smp_processor_id()in_preemptible" on:

commit: efef4da3b19cadf4beb45079a05643a77821de79 ("[RFC PATCH v2 4/4] sched+mm: Use hazard pointers to track lazy active mm existence")
url: https://github.com/intel-lab-lkp/linux/commits/Mathieu-Desnoyers/compiler-h-Introduce-ptr_eq-to-preserve-address-dependency/20241005-023027
base: https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git next
patch link: https://lore.kernel.org/all/20241004182734.1761555-5-mathieu.desnoyers@efficios.com/
patch subject: [RFC PATCH v2 4/4] sched+mm: Use hazard pointers to track lazy active mm existence

in testcase: boot

compiler: gcc-12
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------+------------+------------+
|                                            | 75b478bf10 | efef4da3b1 |
+--------------------------------------------+------------+------------+
| BUG:using_smp_processor_id()in_preemptible | 0          | 12         |
+--------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410072229.18756716-oliver.sang@intel.com


[    6.336856][   T48] BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u10:1/48
[ 6.338102][ T48] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[    6.338809][   T48] CPU: 0 UID: 0 PID: 48 Comm: kworker/u10:1 Not tainted 6.12.0-rc1-00004-gefef4da3b19c #5
[    6.339929][   T48] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    6.341119][   T48] Call Trace:
[ 6.341504][ T48] dump_stack_lvl (lib/dump_stack.c:123) 
[ 6.342057][ T48] dump_stack (lib/dump_stack.c:130) 
[ 6.342065][ T48] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 lib/smp_processor_id.c:53) 
[ 6.342065][ T48] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 6.342065][ T48] exec_mmap (include/linux/sched/mm.h:91 fs/exec.c:1017) 
[ 6.342065][ T48] ? would_dump (fs/exec.c:1409) 
[ 6.342065][ T48] begin_new_exec (fs/exec.c:1280) 
[ 6.342065][ T48] ? load_elf_phdrs (fs/binfmt_elf.c:534) 
[ 6.342065][ T48] load_elf_binary (fs/binfmt_elf.c:996) 
[ 6.342065][ T48] ? get_lock_stats (kernel/locking/lockdep.c:339) 
[ 6.342065][ T48] ? search_binary_handler (fs/exec.c:1752) 
[ 6.342065][ T48] search_binary_handler (fs/exec.c:1752) 
[ 6.342065][ T48] exec_binprm (fs/exec.c:1795) 
[ 6.342065][ T48] bprm_execve (fs/exec.c:1846 fs/exec.c:1821) 
[ 6.342065][ T48] kernel_execve (fs/exec.c:2012) 
[ 6.342065][ T48] call_usermodehelper_exec_async (kernel/umh.c:110) 
[ 6.342065][ T48] ? umh_complete (kernel/umh.c:65) 
[ 6.342065][ T48] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 6.342065][ T48] ? umh_complete (kernel/umh.c:65) 
[ 6.342065][ T48] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 6.342065][ T48] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[    6.352140][    T1] ppdev: user-space parallel port driver
[    6.353841][    T1] HSI/SSI char device loaded
[    6.354238][    T1] e1000: Intel(R) PRO/1000 Network Driver
[    6.354673][    T1] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    6.650009][    T1] ACPI: _SB_.LNKC: Enabled at IRQ 11
[    6.968868][    T1] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    6.969500][    T1] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    6.970506][   T49] BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u10:1/49
[ 6.971191][ T49] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[    6.971650][   T49] CPU: 0 UID: 0 PID: 49 Comm: kworker/u10:1 Not tainted 6.12.0-rc1-00004-gefef4da3b19c #5
[    6.972365][   T49] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    6.973115][   T49] Call Trace:
[ 6.973356][ T49] dump_stack_lvl (lib/dump_stack.c:123) 
[ 6.973686][ T49] dump_stack (lib/dump_stack.c:130) 
[ 6.973983][ T49] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 lib/smp_processor_id.c:53) 
[ 6.974328][ T49] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 6.974328][ T49] exec_mmap (include/linux/sched/mm.h:91 fs/exec.c:1017) 
[ 6.974328][ T49] ? would_dump (fs/exec.c:1409) 
[ 6.974328][ T49] begin_new_exec (fs/exec.c:1280) 
[ 6.974328][ T49] ? load_elf_phdrs (fs/binfmt_elf.c:534) 
[ 6.974328][ T49] load_elf_binary (fs/binfmt_elf.c:996) 
[ 6.974328][ T49] ? get_lock_stats (kernel/locking/lockdep.c:339) 
[ 6.974328][ T49] ? search_binary_handler (fs/exec.c:1752) 
[ 6.974328][ T49] search_binary_handler (fs/exec.c:1752) 
[ 6.974328][ T49] exec_binprm (fs/exec.c:1795) 
[ 6.974328][ T49] bprm_execve (fs/exec.c:1846 fs/exec.c:1821) 
[ 6.974328][ T49] kernel_execve (fs/exec.c:2012) 
[ 6.974328][ T49] call_usermodehelper_exec_async (kernel/umh.c:110) 
[ 6.974328][ T49] ? umh_complete (kernel/umh.c:65) 
[ 6.974328][ T49] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 6.974328][ T49] ? umh_complete (kernel/umh.c:65) 
[ 6.974328][ T49] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 6.974328][ T49] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241007/202410072229.18756716-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


