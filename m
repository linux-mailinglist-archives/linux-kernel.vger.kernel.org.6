Return-Path: <linux-kernel+bounces-181200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 311F18C78F0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC65028170D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A465014BFAB;
	Thu, 16 May 2024 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SG8Z1FDr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5461459F3
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872054; cv=fail; b=FB4O1v/vMVpKKFuVzZeFyz1C7+xzoCwLgbhTLzJ26/GQWghPnxyhsQ3Fx3b1MyVU0KjbW/m3qgEb+Ielc3xdbonTSAQtZyDMgOyD90NXls3HqvPHsvoi639bpSL/ov/31xytCQXDvwA9gR1VaPTIFjd9sxgtCngOrOpvJi7M9Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872054; c=relaxed/simple;
	bh=9k98Bay7T6dN8dzUmfPD5cV0DvmIidKXazHU98ylBnE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ie26jupJkCmOdHYFTvGfZqpE4koZYucN/WnWE7UEM2KsJU2QepcUwLEG7tvoHIwSf3VNrAGhQovFCEPfEEdSZ4O1is/qEl83+4ibkPtTSAMX9It5H4Ucf85TQqsTBxY83kROMP9ruDXkdvnvejwRA3+pujx6n7OoCy65kBHFoO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SG8Z1FDr; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715872052; x=1747408052;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=9k98Bay7T6dN8dzUmfPD5cV0DvmIidKXazHU98ylBnE=;
  b=SG8Z1FDrAlMVnjfj4DnU7HTSqhYwYPdSkZ8K3ZriHOPXyzEIfTH9Q+Gf
   n2qZAi2zXmF4huKBYAduzVpPmVprV+sSWyxuFnmnZHvlq7zh5DobKZMcA
   W8Mkq3xc7GtUmE66Wly1mnpHL5mZxD34W8YBurhLGfGRiJ1AQeggIwZW/
   8EeiK58I51xRFBVtMWT+qWk457lstc9OwQhfSeuyUWLA9uBsB+OzUadGg
   4bXKjw0C1mJD9TcvUPu+KzJaD0gkjWJpLN60puU5spdF1pW+glqhCPcZF
   IuW9fG66FxR4+cMpqoxGttQyG6HK6XHG463FmTcxn3E0OdXfHTEfrkvL/
   g==;
X-CSE-ConnectionGUID: lQqqiDyeRYyhE+hJcURjJg==
X-CSE-MsgGUID: 4LEmrbGQTbyPg5TvJwkRsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="12176578"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="12176578"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 08:07:31 -0700
X-CSE-ConnectionGUID: 9hi8nGXFRRWO2StvVg06aQ==
X-CSE-MsgGUID: I6uQMJpYT3aCGetwjrRyLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="32054221"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 08:07:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 08:07:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 16 May 2024 08:07:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 08:07:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 08:07:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z64WY42n5c75otg/TuNGMGnm93SESecJHrrD2PApCRHhwTU4rB8a5ZWK+/fLdr/9+LQZ3o7V4XsqJOiHCt2D8by33w+sMVmApUhPgwJ9Amof7xGfeHY32bwLbDe8Rf+N11nrhGI9ramaC0KfS5cL/kYEMqNk+SEm66BU3KY2EKOghRgRyKpdyRRpp9fNs2zCTb02YmieE5Sf4lA6tYQ2C9JbB59gDMSgqO5bYc51vsV+PxR+6WYxaZU7nAHTMxDIkBvwAytLNzJZ2fpk9KHxTUuZMRphL44WYjXkFVoyOHM2PIi1SgXbBcaBFltXuJyXmuALZe8eAtCP85thW9fyOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up25y1lP/Omj4QT4xYvdG3TAT9aEYHH7ItE47jx4GH8=;
 b=DdHPErYx8gCrO3/wzF+zvD9Gf3mBjYwBCaljyiIhkutu8wjuCgT5ccsKCpjhRe1mjpA+c81uDVMipoVm1oLC7voxASRW1PN9c0ycaz240VtB5YxBoKWNQja4djDq2MvCJdB7WeKERCT1imrnTcYYB39Spfm6T3IbeIZ3Ec/sA5b4hh65DbmBpIPT2+Q1JgJTTcwbWeybt+GytRm9I1rYLDaX0l9q8uWMYvtQMVtww+26IfNq9ddzTp17E7v4blklEz2mIeQn+4Ftg8f1ePL/8XidFRB2Yai0ukY6R9GKYsH1bH6CAgt552sFKkwqHwewL/DuFL/YN64bZxI6xFA+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB4851.namprd11.prod.outlook.com (2603:10b6:303:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 15:07:10 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 15:07:10 +0000
Date: Thu, 16 May 2024 23:07:01 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<tglx@linutronix.de>, <ruanjinjie@huawei.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] genirq: Refactor the irq_chip_xxx_parent()
Message-ID: <202405162230.b806f460-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240514131910.2614027-1-ruanjinjie@huawei.com>
X-ClientProxiedBy: KL1PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::30) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB4851:EE_
X-MS-Office365-Filtering-Correlation-Id: 6955fbdb-cbef-48a4-728c-08dc75b9dbec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l+Gkw/h6QzxO0+gQ3ykixsuAw5vm+UH/YDT/TE+bl+ylQuocQh4yIBu7knAn?=
 =?us-ascii?Q?2IP2lMel/1vztBkuSsO4AHSuVshySBhJAEPwd6L0G/ZzNfoPc5y5YBXjghj0?=
 =?us-ascii?Q?7WTdeF2sfqSqFh/JI7ENsk7AUPp63g6yvTV7XyxWTcHk8wpDokCYEYgiIpMV?=
 =?us-ascii?Q?Sk0N4ywBujEUPNLxVlNkodPU519T1tdMTiIXI3mzUCWir+efS7mSObSoxWmj?=
 =?us-ascii?Q?xC7PUzsbCGgx4Mw6ePSwlQJcOYFg5j66N3+dyKGhV9YyGv+/MoFDyJzK9rRC?=
 =?us-ascii?Q?wtGqidxo5TyBJKpHEsth9XMz6pJvJ9VpKU5BjPlt0nxrqePrNsoZnadqrb0R?=
 =?us-ascii?Q?OdfZQz//pTd7xks46HB4DT040VdNQsXvUJVWSMrrmgnUYFyptHLBxJ/GOnBe?=
 =?us-ascii?Q?6yMNN/e2H+/oaG87DYYyt9dHxHHtO5LYQCMWDn+HVapZYzieZR9A3nlS06gH?=
 =?us-ascii?Q?zfTj/Ju64vfyIEBoQ0B/nM5csPaWvIf30WsF2aWVIKfpIhi1StuxMGOcrfC6?=
 =?us-ascii?Q?0RR7G9Sd2iNGFbYooR7FLlOENz1NanjA75Y4bRhbzUYeVkCpQa1lqS/VRyp/?=
 =?us-ascii?Q?QKNTqTTJvSuT1GnqCGzSoSEccAKf4c9wFii1uxJondt2bVx7KRifwaLLI02U?=
 =?us-ascii?Q?oeQCc5Y6/HERvgeRN/HcW4ieLzx2GABhxaLvThgB1ax01gzhNciEmU5SPQ25?=
 =?us-ascii?Q?sguJubP/U1Zwu9olbRXezTOQwbkK/nqzZZFpQt9trDkoz4GJLGh2Gy7vptaT?=
 =?us-ascii?Q?823/HaY/EEL+s2Tx7VqFrqAnb/m+fK2UZU+wuv7sW2NrBYvJxnYHmpLk8avN?=
 =?us-ascii?Q?8y1cF5T5tPtIj6kDME1GKld4nfk3D2dmJ5fGppa8tr2LJGds70qXeD7NqIge?=
 =?us-ascii?Q?X7UZAZteNIi7At7JZNucdH6BXIsLgq3A3pK2725ITquGYewpNi0nrsYQKKqF?=
 =?us-ascii?Q?ThOr4eeMryyHbSM6ZKfI4yeq89WCNsXFB52uRVgrctbGDTSxDg/LBGAmUvIw?=
 =?us-ascii?Q?QNdS8uIzvl91dofPVngAgWr+lHzFU3acJzyCQ0WBLfLF6ZjbtJGCcu7oZ9D1?=
 =?us-ascii?Q?/dKU8gtf85Ezz4SQ0zYsRLh6kYldYByT3VyAMqEVzXUgpxuNjAIp17GGXp+c?=
 =?us-ascii?Q?Dl3YzRGRzqy7sp2y49hUiZpzbPxh/xt69dA8sZtprYWmLbcP9o/Fh28keBTh?=
 =?us-ascii?Q?XXv9TOOwT3oKluyQ48H3KGxfZkQ+1hZ7OrjNVAgkqOVdflttnnVI9Jr/b6o?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wcnyM6rgNhqPIlhcGQhkKnKyJ7C0nlqXj4gfSXEkZQ5GQaV2heWSgzFzy0TH?=
 =?us-ascii?Q?oDyHBzsFibjxl6GtBLaSixImmH505OztZOb6j4FKcA/T3a6N6WRLh5zpIMKI?=
 =?us-ascii?Q?2C1lD1ETTWaucq0dnhC3B1+6AIkcBzloI+Kedp19msSLAEwZPcpHJUp6QppT?=
 =?us-ascii?Q?URlciPE1V+1oiB08xqEx/1b3zfhwsLqKuGbU7TszjzC2shDjq0w6T9NX6Zuw?=
 =?us-ascii?Q?hri81QJQOg+Cc08qfTpUYkeo6q5P+qbIiugeBWu6jpBb+3ZKNAUcebl8Qlzb?=
 =?us-ascii?Q?e24wwUjFbQBWvw7L8wjKr6/uo6UGFmLDaFiT1PzAm5pSGdg+4/RNWJkAHXdb?=
 =?us-ascii?Q?Rvgb0VbB2ANYl+7k6ESEV6bSuqW2+LZzcsroZ7uzmZpLMGWdO/uqmxwu8P/E?=
 =?us-ascii?Q?Aaj/qwtAe02b8brVLPoQXWZF6iwPz0qE4j+M8sjEFgXrPmK+2dTOQ8kt0jNX?=
 =?us-ascii?Q?iCZD+niaDSMhftIAI54G+2vDDWCnX9AzNeK/tXGvT1E4cLJmKZSUEhrJN3NI?=
 =?us-ascii?Q?SOlRJdaj5sYzkjXlxCESF9CRr0o/384lqIHuH9XwO3ibEr8fb25f5dHB9k1z?=
 =?us-ascii?Q?NaNO4Y72bBXAVQHc99p2Wy8TpfPKjTDamOgh4upU0DVueyawmG9uSMRxHUbB?=
 =?us-ascii?Q?XyvHfeMuLzEJahMkbpKt0QBIupY341XDSWNzh/j6qh0hroyyITcB/IbTukZl?=
 =?us-ascii?Q?tAD1/HXAN2pfenUzzL/hILjwvkkDd6wwPapWvfhp3X/LQ3DepkBLc6Rtjboa?=
 =?us-ascii?Q?oj5w5mks8dQIZLs550TiKmL4X9b7amjGTtVOsAXHWZ4xtI4rp6k2wmD08voQ?=
 =?us-ascii?Q?cOdt+cntVIR5MLl8C6VWoXhpOpDE8aCJG7cmDqaPq0wF+LfXja5vnd8Arjsj?=
 =?us-ascii?Q?ezOPj8S2w7q2cGt3IdbRT0pZSHAablGwoNd/BmhQDLYJ8PcM3pwGTsZoAGZK?=
 =?us-ascii?Q?xgfELSPHMZkHTNbTFti87melwYTnsgEA8cuSY1WvQUfe0qVrU4yJnGKfIRsA?=
 =?us-ascii?Q?l0yav3P3xhT4ljaH9qIKD3kHiYUgYPpMUuZOh6YjBRsBYxzV0Iopb8P3yBvt?=
 =?us-ascii?Q?rwpOENK7EzOONT4mjt4wzXkpavQPrUVIMaBmaHSXRc9SM1ahYhQSZ2pFupKo?=
 =?us-ascii?Q?P6k+XXW+0sEsVHHbh7wb4LGixxiVpTCErctGJ+EcvfpsYNbsH3XEhA6gxxqf?=
 =?us-ascii?Q?ZoJWenMBGJD253f7c1IN57CctGFhf0bsRqnaRDRNjDkKQ0ndS+Jkvp9bM+OT?=
 =?us-ascii?Q?VqWnPilTNt/6PxQDshTi7XKnvliK2/q1WZ8/kB5obG3nPzJoUmEFLhqzlR/y?=
 =?us-ascii?Q?oIuqVUPNtFNioQprjG+f5bun7F9D/jl5hE5j4WOhWFl49Yr5JFiSl8APAPlZ?=
 =?us-ascii?Q?qwn4NHYLOecaOY3BxqqIE/v9XQ0v95wdlyvpiIVhkgiKiXVF/GyhXh8s/yCC?=
 =?us-ascii?Q?9T62RjBaqEJZoZA4FR++oqQxESa92Q4qQDLs7DHY3v4Hs6OcylXZIZvhq1rl?=
 =?us-ascii?Q?bYqc/Rjm7b/Utw2ol00U9pscsOAni7+XDK2ud9h3QkYF9LP6PGEKiouLH6tp?=
 =?us-ascii?Q?p7urmNKM4SKbzwUTnlZIupOhpUa17rUXPZJojwMrsB8TyWv1SeJUyItACMIW?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6955fbdb-cbef-48a4-728c-08dc75b9dbec
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 15:07:10.2187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c15hpM5wGgGtTYjJC2+LANzZj2JOSQ+Bc1/hIUlZ+PLHccFz0DrFS9c0+ARRXBT6iExPhLQfyyGntr5ToKqnvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4851
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: d3e17411835053b9cd90e3ec2a3cff4e9eea55fa ("[PATCH] genirq: Refactor the irq_chip_xxx_parent()")
url: https://github.com/intel-lab-lkp/linux/commits/Jinjie-Ruan/genirq-Refactor-the-irq_chip_xxx_parent/20240514-213011
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 382d2ffe86efb1e2fa803d2cf17e5bfc34e574f3
patch link: https://lore.kernel.org/all/20240514131910.2614027-1-ruanjinjie@huawei.com/
patch subject: [PATCH] genirq: Refactor the irq_chip_xxx_parent()

in testcase: boot

compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------+------------+------------+
|                                                       | 382d2ffe86 | d3e1741183 |
+-------------------------------------------------------+------------+------------+
| boot_successes                                        | 18         | 0          |
| boot_failures                                         | 0          | 18         |
| BUG:kernel_NULL_pointer_dereference,address           | 0          | 18         |
| Oops:#[##]                                            | 0          | 18         |
| RIP:apic_ack_edge                                     | 0          | 18         |
| Kernel_panic-not_syncing:Fatal_exception_in_interrupt | 0          | 18         |
+-------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405162230.b806f460-oliver.sang@intel.com


[    0.414620][    C0] BUG: kernel NULL pointer dereference, address: 0000000000000030
[    0.414623][    C0] #PF: supervisor read access in kernel mode
[    0.414625][    C0] #PF: error_code(0x0000) - not-present page
[    0.414627][    C0] PGD 0 P4D 0
[    0.414630][    C0] Oops: 0000 [#1] SMP PTI
[    0.414633][    C0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.9.0-rc1-00052-gd3e174118350 #1
[    0.414637][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 0.414639][ C0] RIP: 0010:apic_ack_edge (arch/x86/kernel/apic/vector.c:1058 (discriminator 1) arch/x86/kernel/apic/vector.c:915 (discriminator 1)) 
[ 0.414646][ C0] Code: 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb 48 85 ff 74 4b 48 89 f8 48 89 c2 48 8b 40 28 48 85 c0 75 f4 48 8b 7a 30 <f6> 47 30 01 75 11 48 8b 43 10 8b 00 f6 c4 01 75 19 5b e9 04 12 01
All code
========
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	f3 0f 1e fa          	endbr64 
   9:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   e:	53                   	push   %rbx
   f:	48 89 fb             	mov    %rdi,%rbx
  12:	48 85 ff             	test   %rdi,%rdi
  15:	74 4b                	je     0x62
  17:	48 89 f8             	mov    %rdi,%rax
  1a:	48 89 c2             	mov    %rax,%rdx
  1d:	48 8b 40 28          	mov    0x28(%rax),%rax
  21:	48 85 c0             	test   %rax,%rax
  24:	75 f4                	jne    0x1a
  26:	48 8b 7a 30          	mov    0x30(%rdx),%rdi
  2a:*	f6 47 30 01          	testb  $0x1,0x30(%rdi)		<-- trapping instruction
  2e:	75 11                	jne    0x41
  30:	48 8b 43 10          	mov    0x10(%rbx),%rax
  34:	8b 00                	mov    (%rax),%eax
  36:	f6 c4 01             	test   $0x1,%ah
  39:	75 19                	jne    0x54
  3b:	5b                   	pop    %rbx
  3c:	e9                   	.byte 0xe9
  3d:	04 12                	add    $0x12,%al
  3f:	01                   	.byte 0x1

Code starting with the faulting instruction
===========================================
   0:	f6 47 30 01          	testb  $0x1,0x30(%rdi)
   4:	75 11                	jne    0x17
   6:	48 8b 43 10          	mov    0x10(%rbx),%rax
   a:	8b 00                	mov    (%rax),%eax
   c:	f6 c4 01             	test   $0x1,%ah
   f:	75 19                	jne    0x2a
  11:	5b                   	pop    %rbx
  12:	e9                   	.byte 0xe9
  13:	04 12                	add    $0x12,%al
  15:	01                   	.byte 0x1
[    0.414649][    C0] RSP: 0000:ffffa39080003fa8 EFLAGS: 00010046
[    0.414652][    C0] RAX: ffffffffb36738d0 RBX: 0000000000000000 RCX: 0000000046ebfda4
[    0.414655][    C0] RDX: 0000000000000000 RSI: 0000000000000030 RDI: 0000000000000000
[    0.414657][    C0] RBP: ffff961d001644a4 R08: 0000000000000001 R09: 0000000000000000
[    0.414658][    C0] R10: 0000000000000000 R11: ffffa39080003ff8 R12: ffff961d00164428
[    0.414660][    C0] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    0.414664][    C0] FS:  0000000000000000(0000) GS:ffff96202fc00000(0000) knlGS:0000000000000000
[    0.414667][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.414669][    C0] CR2: 0000000000000030 CR3: 00000001aba1c000 CR4: 00000000000000b0
[    0.414671][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.414672][    C0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.414674][    C0] Call Trace:
[    0.414688][    C0]  <IRQ>
[ 0.414690][ C0] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[ 0.414696][ C0] ? page_fault_oops (arch/x86/mm/fault.c:713) 
[ 0.414702][ C0] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1563) 
[ 0.414707][ C0] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[ 0.414712][ C0] ? __pfx_apic_ack_edge (arch/x86/kernel/apic/vector.c:914) 
[ 0.414715][ C0] ? apic_ack_edge (arch/x86/kernel/apic/vector.c:1058 (discriminator 1) arch/x86/kernel/apic/vector.c:915 (discriminator 1)) 
[ 0.414718][ C0] handle_edge_irq (kernel/irq/chip.c:812) 
[ 0.414724][ C0] __common_interrupt (include/asm-generic/irq_regs.h:29 (discriminator 5) arch/x86/kernel/irq.c:270 (discriminator 5)) 
[ 0.414730][ C0] common_interrupt (arch/x86/kernel/irq.c:247 (discriminator 35)) 
[    0.414735][    C0]  </IRQ>
[    0.414736][    C0]  <TASK>
[ 0.414737][ C0] asm_common_interrupt (arch/x86/include/asm/idtentry.h:693) 
[ 0.414740][ C0] RIP: 0010:console_flush_all (kernel/printk/printk.c:2979) 
[ 0.414744][ C0] Code: b5 88 54 24 07 e8 5c af 01 00 0f b6 54 24 07 41 88 14 24 e8 0e 1d 00 00 f7 c5 00 02 00 00 0f 84 da 00 00 00 fb 41 80 3c 24 00 <0f> 85 a3 00 00 00 49 8b 47 58 49 39 45 00 73 04 49 89 45 00 8b 05
All code
========
   0:	b5 88                	mov    $0x88,%ch
   2:	54                   	push   %rsp
   3:	24 07                	and    $0x7,%al
   5:	e8 5c af 01 00       	callq  0x1af66
   a:	0f b6 54 24 07       	movzbl 0x7(%rsp),%edx
   f:	41 88 14 24          	mov    %dl,(%r12)
  13:	e8 0e 1d 00 00       	callq  0x1d26
  18:	f7 c5 00 02 00 00    	test   $0x200,%ebp
  1e:	0f 84 da 00 00 00    	je     0xfe
  24:	fb                   	sti    
  25:	41 80 3c 24 00       	cmpb   $0x0,(%r12)
  2a:*	0f 85 a3 00 00 00    	jne    0xd3		<-- trapping instruction
  30:	49 8b 47 58          	mov    0x58(%r15),%rax
  34:	49 39 45 00          	cmp    %rax,0x0(%r13)
  38:	73 04                	jae    0x3e
  3a:	49 89 45 00          	mov    %rax,0x0(%r13)
  3e:	8b                   	.byte 0x8b
  3f:	05                   	.byte 0x5

Code starting with the faulting instruction
===========================================
   0:	0f 85 a3 00 00 00    	jne    0xa9
   6:	49 8b 47 58          	mov    0x58(%r15),%rax
   a:	49 39 45 00          	cmp    %rax,0x0(%r13)
   e:	73 04                	jae    0x14
  10:	49 89 45 00          	mov    %rax,0x0(%r13)
  14:	8b                   	.byte 0x8b
  15:	05                   	.byte 0x5
[    0.414747][    C0] RSP: 0000:ffffffffb5203d70 EFLAGS: 00000246
[    0.414749][    C0] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[    0.414750][    C0] RDX: 0000000000000000 RSI: 0000000000000046 RDI: ffffffffb6214958
[    0.414752][    C0] RBP: 0000000000000246 R08: 342e30202020205b R09: 205b5d3836303331
[    0.414754][    C0] R10: 5b5d383630333134 R11: 205d305420202020 R12: ffffffffb5203ddf
[    0.414756][    C0] R13: ffffffffb5203de0 R14: 0000000000000000 R15: ffffffffb56e53a0
[ 0.414761][ C0] console_unlock (kernel/printk/printk.c:3043) 
[ 0.414764][ C0] vprintk_emit (kernel/printk/printk.c:3900 (discriminator 1) kernel/printk/printk.c:3935 (discriminator 1) kernel/printk/printk.c:2349 (discriminator 1)) 
[ 0.414767][ C0] _printk (kernel/printk/printk.c:2371) 
[ 0.414773][ C0] __clocksource_register_scale (kernel/time/clocksource.c:1226) 
[ 0.414778][ C0] tsc_init (arch/x86/kernel/tsc.c:1079 arch/x86/kernel/tsc.c:1620) 
[ 0.414783][ C0] x86_late_time_init (arch/x86/include/asm/cpufeature.h:171 arch/x86/kernel/time.c:103) 
[ 0.414787][ C0] start_kernel (init/main.c:1037) 
[ 0.414792][ C0] x86_64_start_reservations (arch/x86/kernel/head64.c:495) 
[ 0.414795][ C0] x86_64_start_kernel (arch/x86/kernel/head64.c:437 (discriminator 5)) 
[ 0.414798][ C0] common_startup_64 (arch/x86/kernel/head_64.S:421) 
[    0.414805][    C0]  </TASK>
[    0.414806][    C0] Modules linked in:
[    0.414809][    C0] CR2: 0000000000000030
[    0.414810][    C0] ---[ end trace 0000000000000000 ]---
[ 0.414812][ C0] RIP: 0010:apic_ack_edge (arch/x86/kernel/apic/vector.c:1058 (discriminator 1) arch/x86/kernel/apic/vector.c:915 (discriminator 1)) 
[ 0.414815][ C0] Code: 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb 48 85 ff 74 4b 48 89 f8 48 89 c2 48 8b 40 28 48 85 c0 75 f4 48 8b 7a 30 <f6> 47 30 01 75 11 48 8b 43 10 8b 00 f6 c4 01 75 19 5b e9 04 12 01
All code
========
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	f3 0f 1e fa          	endbr64 
   9:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   e:	53                   	push   %rbx
   f:	48 89 fb             	mov    %rdi,%rbx
  12:	48 85 ff             	test   %rdi,%rdi
  15:	74 4b                	je     0x62
  17:	48 89 f8             	mov    %rdi,%rax
  1a:	48 89 c2             	mov    %rax,%rdx
  1d:	48 8b 40 28          	mov    0x28(%rax),%rax
  21:	48 85 c0             	test   %rax,%rax
  24:	75 f4                	jne    0x1a
  26:	48 8b 7a 30          	mov    0x30(%rdx),%rdi
  2a:*	f6 47 30 01          	testb  $0x1,0x30(%rdi)		<-- trapping instruction
  2e:	75 11                	jne    0x41


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240516/202405162230.b806f460-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


