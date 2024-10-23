Return-Path: <linux-kernel+bounces-377472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C719ABF5F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490411F24C92
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E4D14AD3F;
	Wed, 23 Oct 2024 06:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LV0HHX9g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A1B481B7
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666499; cv=fail; b=DWPE9i9JxbKba+8RO8Hn4jzvaUV3F+uCCHQYrCWjmT3vzZk3J+xr4+1sANvtxb7XUHlDlJZrJq5L/SlqlDhV2qhvlheYlXybgwxd2sivRRJSNLgjBxUVSqqto6eJFHofMbio1puJu/a5i2XAllog5DJe/o7enRGylLOaTHt+Ek4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666499; c=relaxed/simple;
	bh=HuvugJqdiGKbxWSzXBfeSWQGGXVC+xdZgR+3adXosjk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LBDfMD5euPRDgLvNWW58XxidMwMdTdY2xGAdhpkMr2mtQ3lvVYwZHhOoDKJzeogUca2G5MptAtYp5VpdYSuZcUyU667JyGz1MkioC8RieFBM2HQNdSb7vUqXVoKcLZH/XR4Xzf03GdEzo3YI24oYHAsG9rGGTIQ15+rIUlOiEZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LV0HHX9g; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729666498; x=1761202498;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=HuvugJqdiGKbxWSzXBfeSWQGGXVC+xdZgR+3adXosjk=;
  b=LV0HHX9gWGIiHmr8UcD5Y8UeoB5ZB7uDKeXFRXhmylN+MFNMSsBRE0Gz
   ZEgJo18uJb1HUQUOT0oRtMMxSwqKN4EJ05DN5FZ3y6S0BiK7tqCkUR9oh
   Saazh8rEKwaQjGp9R/SVVbWeNXCsgMQpc5Sj3QJ3BX8RVXSNQ2o357c8W
   vCeiEFG9OckPrAgYj3I+gIuxeJkcaiXUk6M9Urt6VW37T9OBFDkqbUTwJ
   jTCN92J0ck4pR9Q6ayu8N4iknLWneLIORfPDuS9G6uVq2NadhbCam1neZ
   US1gx/M1gR92GTwGFJ9C9lZd02gjkvw4oWZvMcTjBUTH10XupaPWcZlS/
   w==;
X-CSE-ConnectionGUID: YZqF5cVfQQ61CQEgUwCYdQ==
X-CSE-MsgGUID: G0JzAyKCRh+F+yIZ3S2xHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51777900"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51777900"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 23:54:57 -0700
X-CSE-ConnectionGUID: i4FQz5bORoqBKuablVkB0A==
X-CSE-MsgGUID: Ni1pRfS6S8qq79ZSQ7XVrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80039823"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 23:54:55 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 23:54:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 23:54:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 23:54:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5U/s/O4vYMNWH8ZqntSkLyXZJEhbE+EoBpY1f+6d2G+AvuReJAyxYbfIfTW5dUxEdTPXTSx28WlGVjpvUf04bxKTZk4Asylgs2ZbGVviVavSdCrb5OD/qAxPqwHZ2WgyR+V9rInvqYmdGn+cnKJoksZvEl49C5XpJZoE3XimvdT+Qb1VhKUgZbd1tMrHAr6RgAAM4ShQNmJxV5er1/3gvkIdKYjgm0kF4PVB4gKtEdczPqwKNVgO8BusXbbjQadbK1iKdbl4TXh8i8ai9nBMMptJGo42ywaQgPIugnl9pFsJnvpsG5cxuC0Ub4T3ZOQ+ALY2dBifESpx066TFcu5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfgDjHDXV/yvmGmKDyCi/ZLZOOe89C9fhaucQBzue38=;
 b=EJZYV3A6PF5XpPQpyagg1xF9Cakzg/ccdyMdhHSAA+9l6VP6vaafGDLeAxP/aL7fMG7I8CpPnHcsk9ojxdYGq4/TEKVovIJtY54k04xKIK5HcYwtzFYQqKeXOOe0VbR4ytNmqbdF0sCgJhRzmDNN5rvusjcDCjmWIHDUKNblQfaJVZpjPn3GHQMwve3+NlFQvpBk2GNLqdRVSg17KG07vSd1f4QRhiWJm5euu7DegXQROYst8smHklQ+YEyopNoJZhhfx/D5gMY8Mfzmi1xX97llF1xxRMQypH/dmwFDII0Is1TllR5WPY7mMGqPrpzka733XV/c8SMjdQ8t5Zorlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB6823.namprd11.prod.outlook.com (2603:10b6:806:2b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 06:54:52 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 06:54:51 +0000
Date: Wed, 23 Oct 2024 14:54:39 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <hughd@google.com>, <willy@infradead.org>,
	<mgorman@suse.de>, <muchun.song@linux.dev>, <vbabka@kernel.org>,
	<akpm@linux-foundation.org>, <zokeefe@google.com>, <rientjes@google.com>,
	<jannh@google.com>, <peterx@redhat.com>, <linux-mm@kvack.org>,
	<x86@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v1 7/7] x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64
Message-ID: <202410231429.b91daa36-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0f6e7fb7fb21431710f28df60738f8be98fe9dd9.1729157502.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f9ef5c2-e05b-4588-da28-08dcf32f97b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jFo7ZsJgAbxi1u268mPHzpXHK7lXOzZIvMGWyuidKszmOA2Ftv3pTkhDNm5W?=
 =?us-ascii?Q?USNsxG6BLrhWO0BsGBkHAeci2T9dUKZLpZmz8f3kFqXx3be2dw3MubCBjc/t?=
 =?us-ascii?Q?5X7cotxbigqybyvpFE7985LX4jQZ/HlKwOncErnHlZXzjzvOJYgMofY6R8uO?=
 =?us-ascii?Q?7zORaZzHvEPJpB1Bm7efv4RTy+Anx/FsbGPui+w8ilEqRSvoiTuOqD6yg/J4?=
 =?us-ascii?Q?nDxlGApvYL/DAXOUmeJXOG+ST8p3Gk9xiUiUf624eJlVm4IggYCobKNSpDMt?=
 =?us-ascii?Q?gjJDwg2nU/3xfCgE/bE1OzsduQ4WspZItIRTiPWkmBrrgL1esYSPHTLXWPlX?=
 =?us-ascii?Q?o8b4+HDo5Msq2s2DH2qdkCjHsQtG5w7Zeu3pI/8k900Psmajs/iXkJtsPX8T?=
 =?us-ascii?Q?S9gMPbuLgpPykpIWrNzM0MUJiIIarWQ9MLXBZALNB0VQxJwAYSLtHqP+z6TL?=
 =?us-ascii?Q?3hCMVizsIgm5K0YArYQvYr1WiHWOQu+4Z22KssWzITZg9GzIRyY1P8Rrx1RY?=
 =?us-ascii?Q?PabYE1JEaJm4scWEKE7+vZeRx8EWqJCu/kN4zJ+pYI+om/uYs+MZgRwo4fML?=
 =?us-ascii?Q?1ftciE1YUTfKO1O5+Ty/rK7RBBupPPbdsWzoydsL9fcmU3bTdBCspmXkOhBD?=
 =?us-ascii?Q?inX0nq0M0wPIpSfp6TYtm1TweZoRxk3pB9s9umzvse/w7NJKtt1tBR0s5v6h?=
 =?us-ascii?Q?bFI75o2lMPZgYsLW8zabtnv9qq8mzX5xm9dbLYr/WvfNAlhsWKpBu7kZfOGh?=
 =?us-ascii?Q?8y7QLggxfgvmTN8bgFlyN15lgtS+qeI/uX02JpHD8TkGTROkQmKV4NQUY+xH?=
 =?us-ascii?Q?D9GtFRI0prv0kOzoP6fchCccreMi6qfsuD7kEnySSNZgDX8ipKe0Ps84lIpf?=
 =?us-ascii?Q?GgvihJM5tibU6LB+nX+H/pmFXNQnpn8JwgEyOtGNVgp8yzie9zuEY5+UFeeE?=
 =?us-ascii?Q?MTNw6k4bUzte6nFSY2U2NdKT01MJiDGOw2spxPyO7rWK9BcuwAFZM80wnbQE?=
 =?us-ascii?Q?cahRMzGiUYzyAAFWsrNQ1qEwlK3iI/GIzpNbkqNeKC3beAAVGFbf1hW1kKGj?=
 =?us-ascii?Q?wG3WvJL/IY/ENtysHBCn3XO0yIlh2IEC4hwPiQBVwJfkhICLsg2jALy89FsK?=
 =?us-ascii?Q?PVIXpXtqlPaKqkOYc516D341ncM9nLujmtnybDTfKRy3lXSvE/Sm3LhB0AI5?=
 =?us-ascii?Q?N/AjDaSyETkcRJQOQCbFBm/qbuYo3oSzK4sohkc9r6/pjjzM3nol0lunl6HR?=
 =?us-ascii?Q?jwjTc/f1pG55xRQQXCDb95ttoSDkaAgvRtkqFn7VyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bDNUtsXaPJum0uE12nXS6p8kHO8dqrIjIg9aBDT6ihCpufNPrCntscI2wyyd?=
 =?us-ascii?Q?0EX8LV+nr6AEBhklVmh7ttYWWLwYa+FEAWP8Z/NXKQDDR+r38I7EGNsxUR+V?=
 =?us-ascii?Q?pE7/okC1HiiqkGOzSY2MQ5Yjqe2x8eG0SejtIa0KSIDutWY5aeaIDKckem/V?=
 =?us-ascii?Q?SMhc2SSOMnCz9YnNr+gZ1xt51mmR164oCSzmkZ5eFWgamg4Y8kOI1sei35+S?=
 =?us-ascii?Q?KG4WdqO7RFh2uDzxFVtDz9WjaqMIB5EGQaiyqVkRCvqjw3b6VhLT8Ku2/jMr?=
 =?us-ascii?Q?EsvM1rsPkFg+ko8MpyWpk/eJE+HbeyywFLUSuuF4SerJh6FKTbLULk3UN0gl?=
 =?us-ascii?Q?W4j47O1SNNPyTohn5TPojFvCT0/vvBbpAeVT7nRHdsEy1evIKXglfJH2C8Vl?=
 =?us-ascii?Q?tJcUjY6+UxKe73cz2V1QWJQBREzh3eF4HRCkHkMgK140HtOt+xgIU4eD1iUf?=
 =?us-ascii?Q?x8Ma8eDbikenEnxWOYR1gGoUw5PgjXHOEAS7pRV4Amuh/pQS9K6WJPjCQvGc?=
 =?us-ascii?Q?1HuOIQEx2ezU4qRb1QpOQD6lsUf7+tC4t2p7JnTLDxPkY3SW4wC1JHrUh9YV?=
 =?us-ascii?Q?+BnnvDdK5fwwQ3StSZaVOEBI5dMOFok1TABCaUehbq7kbBZjyDweHfrNR5Zt?=
 =?us-ascii?Q?08d3Zu6A2m+ipqi45hEbRWwOlEwFUOSL802kpO+mrYAJntPWwKlW8uOUhgZU?=
 =?us-ascii?Q?3EgIeKFHtUu+EMMCEH5cleAH0dIcbEZUwidEtBxSspZOrNvxtE8xL6tgQGOu?=
 =?us-ascii?Q?YBA1xUJPFJUF5wiKUegfkgTN5KIKRO2O4OXDQLtWnU3yKhSgENq6q0wtojkF?=
 =?us-ascii?Q?f+rU1wu3Xkc1tQE/c39Jk9uESMoykpSpreTjAFvesNGmvSd0Qt6mdUYw3GwQ?=
 =?us-ascii?Q?N0tmCnnq+DP7tB4LrEdIVgkF/i/J+IIIOOBZWaepADO5SagAmpfPEY9GFQda?=
 =?us-ascii?Q?YaDrnM3IGfKerfRaV0VXzel+MOy7UZBgK3AFWIc9dMIu12YdrRmjR4Cz64aK?=
 =?us-ascii?Q?Q/vlxEkL09rLX7zT5D6IA8CMC2YK9W2KII9cX4s8w+JtE32IKDDEKdBiKnaL?=
 =?us-ascii?Q?jdaNEDXFoyHcyF56pU8I89/+W/QUf5I8o10iFjcC9O5kQP0dNTPySyiwJlEN?=
 =?us-ascii?Q?OG1oomE2KN1VzfaCgInu/TkKBsHS9/kTguYjLicnBwUOvwngfVeE60+rw6hZ?=
 =?us-ascii?Q?gwWWRqf1NxG3Afu8irm1yKgnr6Bukk0xw2BWBQ0HVGPQAyAToAKP8Z04KaP5?=
 =?us-ascii?Q?1a6YaAedPCJ8VZewF89/jINMh01uvHJXVDDwPN2SQsx0CpexrygON83wqYWI?=
 =?us-ascii?Q?T+1+xM3YEw7K8Mg/BWzT0S5eWvXupfiaIMCMjjcpcYPYWeJgZGcf/Kw4lvNh?=
 =?us-ascii?Q?G+MH6UG5T+ajR/sj6ShWCCxm1v8I2Y1MRRL8Vvq/wvRJOoBACUTJKiPSZw8h?=
 =?us-ascii?Q?FDWoFJRkRD/lkB62dcggpCmIOYn3ksVktso9Unrmol07r1PIqFBORDVRy+nB?=
 =?us-ascii?Q?SAcvXCOLG7iW6S9LdWR92hF5/ArxArPw/PmQE5aytQ84fjIznn4nNpfe8EHa?=
 =?us-ascii?Q?nehYkUMD5iXBgm+EYlBa5gWSv1hZgfcHdLxl/Axr0+dA+3Ajktf4o9R4XEAm?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9ef5c2-e05b-4588-da28-08dcf32f97b2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 06:54:51.5892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19vexiSapInYrpQFwBcLFUu7IWnmqt+FMGW3Sj33e2gVeUFqLPqt5aHgxcDXXGG98C0MwWJWWft/3KYHrLUFPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6823
X-OriginatorOrg: intel.com


Hello,

by this commit, below two configs are enabled

--- /pkg/linux/x86_64-rhel-8.3/gcc-12/c9f9931196ccc64ec25268538edc327c3add08de/.config  2024-10-20 21:40:11.559320920 +0800
+++ /pkg/linux/x86_64-rhel-8.3/gcc-12/2e22ca3c1f2a6d64740f7b875d869d1f80f78ce8/.config  2024-10-20 06:02:46.008212911 +0800
@@ -1207,6 +1207,8 @@ CONFIG_IOMMU_MM_DATA=y
 CONFIG_EXECMEM=y
 CONFIG_NUMA_MEMBLKS=y
 CONFIG_NUMA_EMU=y
+CONFIG_ARCH_SUPPORTS_PT_RECLAIM=y
+CONFIG_PT_RECLAIM=y


then we noticed various issues which we don't observe on parent.


kernel test robot noticed "BUG:Bad_rss-counter_state_mm:#type:MM_FILEPAGES_val" on:

commit: 2e22ca3c1f2a6d64740f7b875d869d1f80f78ce8 ("[PATCH v1 7/7] x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64")
url: https://github.com/intel-lab-lkp/linux/commits/Qi-Zheng/mm-khugepaged-retract_page_tables-use-pte_offset_map_lock/20241017-174953
patch link: https://lore.kernel.org/all/0f6e7fb7fb21431710f28df60738f8be98fe9dd9.1729157502.git.zhengqi.arch@bytedance.com/
patch subject: [PATCH v1 7/7] x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64

in testcase: boot

config: x86_64-rhel-8.3
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------+------------+------------+
|                                                           | c9f9931196 | 2e22ca3c1f |
+-----------------------------------------------------------+------------+------------+
| boot_failures                                             | 0          | 6          |
| BUG:Bad_rss-counter_state_mm:#type:MM_FILEPAGES_val       | 0          | 5          |
| BUG:Bad_rss-counter_state_mm:#type:MM_ANONPAGES_val       | 0          | 6          |
| BUG:Bad_page_cache_in_process                             | 0          | 3          |
| segfault_at_ip_sp_error                                   | 0          | 5          |
| Kernel_panic-not_syncing:Attempted_to_kill_init!exitcode= | 0          | 4          |
+-----------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410231429.b91daa36-oliver.sang@intel.com


[    9.153217][    T1] BUG: Bad rss-counter state mm:000000006dcf9cdd type:MM_FILEPAGES val:40
[    9.153929][    T1] BUG: Bad rss-counter state mm:000000006dcf9cdd type:MM_ANONPAGES val:1

...

[    9.444419][  T214] systemd[214]: segfault at 0 ip 0000000000000000 sp 00000000f6b1c2ec error 14 likely on CPU 1 (core 1, socket 0)
[ 9.445388][ T214] Code: Unable to access opcode bytes at 0xffffffffffffffd6.

Code starting with the faulting instruction
===========================================
[  OK  ] Started LKP bootstrap.
[    9.453331][    T1] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    9.454023][    T1] CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.12.0-rc3-next-20241016-00007-g2e22ca3c1f2a #1
[    9.454818][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    9.455601][    T1] Call Trace:
[    9.455906][    T1]  <TASK>
[ 9.456184][ T1] panic (kernel/panic.c:354) 
[ 9.456522][ T1] do_exit (include/linux/audit.h:327 kernel/exit.c:920) 
[ 9.456884][ T1] do_group_exit (kernel/exit.c:1069) 
[ 9.457252][ T1] get_signal (kernel/signal.c:2917) 
[ 9.457615][ T1] arch_do_signal_or_restart (arch/x86/kernel/signal.c:337) 
[ 9.458053][ T1] syscall_exit_to_user_mode (kernel/entry/common.c:113 include/linux/entry-common.h:328 kernel/entry/common.c:207 kernel/entry/common.c:218) 
[ 9.458495][ T1] __do_fast_syscall_32 (arch/x86/entry/common.c:391) 
[ 9.458904][ T1] do_fast_syscall_32 (arch/x86/entry/common.c:411) 
[ 9.459299][ T1] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:127) 
[    9.459788][    T1] RIP: 0023:0xf7fbf589
[ 9.460130][ T1] Code: 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
All code
========
   0:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
  26:	0f 34                	sysenter 
  28:	cd 80                	int    $0x80
  2a:	5d                   	pop    %rbp
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq   
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	retq   
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   f:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
[    9.461528][    T1] RSP: 002b:00000000ff837680 EFLAGS: 00200206 ORIG_RAX: 0000000000000006
[    9.462212][    T1] RAX: 0000000000000000 RBX: 0000000000000038 RCX: 0000000000000002
[    9.462834][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000f731e6cc
[    9.463462][    T1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[    9.464083][    T1] R10: 0000000000000000 R11: 0000000000200206 R12: 0000000000000000
[    9.464714][    T1] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    9.465343][    T1]  </TASK>
[    9.465677][    T1] Kernel Offset: 0x4600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241023/202410231429.b91daa36-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


