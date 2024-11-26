Return-Path: <linux-kernel+bounces-422153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6339D953F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62078281EB5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B2F1C07EA;
	Tue, 26 Nov 2024 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sda1R4vZ"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26911B4F0C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732615994; cv=fail; b=kzziM+HS1V4L9I3D9uM+siUz/C6LxmioYc1htGd1NebuS9LdwQp75EQNGep2GixeDSzOQ1JHD0VhZeNuDrSqtZ7WN708wFJvrkC4w/XyMUWAfPyh/dXdgEcZ8Vvvgtjrad/OC5RKNj22f5Yzxt1ha2kmWV4ogLw+bEwKLb1f13w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732615994; c=relaxed/simple;
	bh=UVW0k2Vb6nSst2wf/aD99iOf70WQA72JCH4M9XZabwE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qPZ1I67MOMWnbGPclnoPu9Ipy3hyePIKQrUu9eHWdjMQbC/+x+GhyCxLQlZal04oGH7cs298rNG9CNgVK2C2voP3kzfZKL8kZoOWn+/vuc2rqHr/mVaKUOdYZmXF4urQLHgirO485ZUukMsG4YN/T+FYkWjqD6Gx1Q6KnNqMny8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sda1R4vZ; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISzsbi7omKSOycZSCTMiOEtzympiczLbCl75BMaCWq0Q932BESx2Hlc/b/Po3ekcqXRqWw4oAF2VXlG9EnVwR7hzQnMV2dq/VZBFUJSHK8NZPYagBITMydn/XCI9Y6NO12Lj4eWm2QXewRSaloSevu1uKefgJPjCOXq8B8V8Xn7vQuN8BHvim0z9D4K3KMI3YY/5yTVo7HVgnIELH/wjEBN97ZYVLjjCnPRj7XgiFFvhmVneRavS+DhUNfAhmYbuaxh6tzCGjtTcuj3FjQuQKAThcPmtbKqKHUxoxFl4IQ5RVESK8y2yM3UJMms4wcd5a23JTYDstQde2XiXNbN46g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZA0yvCGfowiU7ivXl56hVoFy2g1pyyLF9T5RP+Ahmo=;
 b=FcWws+mpLQCw8K2LSdmOq1yrUePjyp5qOjfNKHl5lZfe9ZlyJ8rmGosXIKnjf2wsVJfmpZbkdCflLzKe1Tjgo8VE403Qp3S2Mam3pWfDf91VqO+JWwBCPdJkp8u0B1Q/rFQg7sBxT5kemC1OEr1UmZDhuWJNQ9wbpSEM9FtzvtburiALnsAJ+Oy/iCAfp3eEMDSlFIXjshRapLrLvLEXrujDVzpADglVQbFriYiteH4qkY0DOAHHKAW/xNARhxuW8Ir3qhoXUE72A1xUUUW1FO8gG34typKLt14iNdGkqzYaIqrxsDevs9nMA0RhAB+nHFHtaQpy3pnwhQObDxXPdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZA0yvCGfowiU7ivXl56hVoFy2g1pyyLF9T5RP+Ahmo=;
 b=sda1R4vZ4zh5RrsrTMmXN0mGWpxA3ujVhtch7RLeaocB3/UdPa1eS/nrgxcFLOowsNGrPPXq2Suhxof2+ZMR40uO4b//ZkbSD+ddwXky6H/Z1POMg24meP3cFdlK1DfBJ5D41gFtnuivN+66uGCl8RrdJ52QYcoJvSoROCdDLm+GcPVaD+lH7E1XC3QaxvW/p0AYjdtIE8Gxhv1zLEoeFUB7nMyqFWy8vTh0+MD0xDrEoohyapuhYFnYZ/WLFtEWgelXuzoR8HFhQs/07nbiqHiCsejjpwYlzASCfBy3/fjNmVpONujpEH0hTC5FNlGRIJEjrhwTXYrGz/rdCRS42g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 10:13:10 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 10:13:10 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET sched_ext/for-6.13] sched_ext: split global idle cpumask into per-NUMA cpumasks
Date: Tue, 26 Nov 2024 10:56:38 +0100
Message-ID: <20241126101259.52077-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0318.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::18) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: 952cd74a-e2dd-4ebe-ad52-08dd0e02edd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fuCt1UtmTfw5pxsYuRnjAyrpdm8H2fEF9o00Na+1LBXdBNiSlEDrrkaNnp89?=
 =?us-ascii?Q?nVdHkxB7T6cxEcV9iWAOCxGISlRsUiSlut78vWl98hAmRh25Iq7OLJeE9o29?=
 =?us-ascii?Q?za8rl7ZI+3LVQp+iFKx7BvgAIC24yVO5wi7UJtTZXzelwgFjgzjBFhT2nOIk?=
 =?us-ascii?Q?B/K96SIwAaXt1exKVUYfT72nNJcxnbBgReDV7Z4PdahdpofFv9mxRq99Fy75?=
 =?us-ascii?Q?Kjv79dlYqFub1VBUjvYDpLz/S5VzheZ2niT/8oF6c1pkLbxK+oWdDDN+a1zo?=
 =?us-ascii?Q?ThrO9s5rQWUUdeeXv3CQbzXKaOmu6xz+PXZDKL0hGQykJcrFc0RE0PJY4QwT?=
 =?us-ascii?Q?ssY2QGVncAqU8twoB0TPFugWYRYdERTP7pAY2/zmg2SfqdcDXsnCG7SsfsMP?=
 =?us-ascii?Q?n2moquv2cMC81O3bmk9JtfjIsRg2Fy4kPRX38wU+RE8PQ0desXLwq9tQrNuP?=
 =?us-ascii?Q?OzprUSTtG/om5TKPLmFvDzHgRhkawy7ahFXVLU+e/Z2YZHy07GnBIeNBwKQB?=
 =?us-ascii?Q?HQWL1fbi7IDZ2Dc/a5JsS5CmTYyg9JmYaXlJZX7KsD0gQMo+ERSLNTgi8+oW?=
 =?us-ascii?Q?znd2JBJU5wJ5OdJfa3KjCCM2LxKMY4YH3JmrDxmduizYka55iNDWf/99gpXI?=
 =?us-ascii?Q?vfsY76LAODIQ+x3VoOYaH7lVvy7fmU7buw8Y8p/bS60ibAzG2qJVTRKMSXGy?=
 =?us-ascii?Q?8EOP/ZvrWH3HY31ei4CUj3HFnRfJy2PgfoAQQJWc2P9ElhFpFP5waBkqbEZZ?=
 =?us-ascii?Q?ZwXLbPnkq0elIgpwawII6getjIzkSS1wY8zt7cVg8HGxYPLXYLvlrppAslCK?=
 =?us-ascii?Q?Dr+wxBEUp7+zCUB8OspcLL5SS3r5veH9o4Szpg4OA1BxseUf60Wj6DMucVfE?=
 =?us-ascii?Q?72VmK67+vWeZg6rmdxUi4gfYqLWanyEWPUp7br8wK83sIo5al9izOG7sjw0l?=
 =?us-ascii?Q?5J7piqDd192AjM1PgMZrYR3a+rNGJV/ovbB6iRElFKiwRPpKjMG/QG9ldIO1?=
 =?us-ascii?Q?SwcZ1ODzHR/41H3qp8eNDFHpyI2cSxNVgq3OC9kXt+uUrcsCGcSIlOElBGI/?=
 =?us-ascii?Q?pEMEa8ZsMX2X01w4SMPygxSlUSdio4kKgvIK2uVm3TRn7yQ5F65zPhuJy/Fc?=
 =?us-ascii?Q?M2IYyk6xKtNtdig2c1kIsSlTJ5D4gZ2VUz0HECPTmVXlJMncQTRg+4CXn1le?=
 =?us-ascii?Q?QQIXpeALUhR1v4YH5ppbQhnugWiJrNA73wxI5OIbwu8hEz08yXQxZKCmn/Dq?=
 =?us-ascii?Q?ckYl6Y4JXYlGE7PYrS8A7jykZsTfEaCFE2D63EVwP8Hhqo3XuJHVuUtq6Qin?=
 =?us-ascii?Q?DIWw+hc8K/9wP5uCCV+99WuSCuILzXDMyD2Y+wxYW51zDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5TbuFny8TKoPypU9nAygPCIhJZuu4xwojC1K1d9LJ1FzI4rgvJg7Yx1CsWsB?=
 =?us-ascii?Q?GtCmeOSIuQN1muvaDmW7VfJJL1ofiD9hy7mDC1V9nV8KiGnjnpHAMso+ffp9?=
 =?us-ascii?Q?hwLSVaf5E697y8DcEuQc602Nq6b0uYHR8ips/VIlLA/s7rVw08cLYLsC0Whj?=
 =?us-ascii?Q?u850wp0yTE70jEiKi65neCXB+LARmxS99JBK60keH/fSXED1EbLj97lE2kJt?=
 =?us-ascii?Q?Rrzs9AL6pAFlVpkh7sg+bKv6t4Ixwr92sb20dzzllYEcM93of5t9Pf+77ai9?=
 =?us-ascii?Q?77Ub2ww/5nz4mHba30HTKc8yR2slzoWw5pLhu/j2nSE0B1Qfl+vdcnWXDFGC?=
 =?us-ascii?Q?RGwlsm0P2d9HyoajVH9J41wZyyM045M1GQj6e0T26dhB6HDF7LvqNGHfDp/b?=
 =?us-ascii?Q?PTKWru5IARTW412VcDFtKY6Ad7IDaYawCljFwJyR+yjTjbgx0fKug2qOdcBi?=
 =?us-ascii?Q?XGFNKvb/OXAfaba/NKphlfc8smH2tPHQcvrnGtdNBpN3FXgqmYMEPEiTlpHv?=
 =?us-ascii?Q?Y4qRhPRWXDqCGqfpWR4MSmM11+nYPOrK9XlNY0L6blm8u65T7sTdkNyM5snp?=
 =?us-ascii?Q?QpF70MoTJl8Bqi9VT+xKDgcR3dqkLM1MqJnmEu0OgvKBKk/oEiAZoRaA04Wv?=
 =?us-ascii?Q?mH+tmXkV9TKI98TiO2Qf2tSGKi4Nn2fSbnOUc/DRHjIngdK3Ji53QBoaBcaV?=
 =?us-ascii?Q?O5daXgV2rhmL/TeRSuzHDiY8bSYe9Fvv3wrV2XyS7vBJOk8N30qADu0H8EfZ?=
 =?us-ascii?Q?J+5Y9ZZsS7TUhaJxXiSNZxczrP7kDodd9n1hNn5gpO7S+CXxT10VUdrulw5Z?=
 =?us-ascii?Q?PXv9nAyWPAabhaEUNU20fLJEA4S0DkAGCldlctZx7P+4psuHo+x9Q322feYz?=
 =?us-ascii?Q?sJbBmrrjJceXbT1BRKuI8kf++svr4l3fznQrk+C9s6kk99QwWhyeuxHpq3Sc?=
 =?us-ascii?Q?K6UFjQYtpftFB87RK+2AhV6MYYVqborSj5GnK4ZaJNGNUEFoWP2596z5n8JQ?=
 =?us-ascii?Q?b6BpcC0mKD7gNqQ/6Itc9VFxEwMgbwptL3Rb87O4W0jAIp8Mf90LkHgbyr2Z?=
 =?us-ascii?Q?5sce7+rnqwgqHDHEtKdupk93vwLzlhPUTgSpmBeDQPaRaBGxq30PzFMSpYAZ?=
 =?us-ascii?Q?HXB3ha+vDBDNT+cDogcxl1qPLU7x7RJOW6GN08tza/5y8YJPbbmrfQCGESjS?=
 =?us-ascii?Q?zOGrwnirr9xzIfO/3yzztTJjJxN3Y04eal1n11qx/80Pu5+MXLT4C78TyKI6?=
 =?us-ascii?Q?bQPCT9554a440NEVt3ZtYqczqWXwYwo/ctMBQ+NOULWXmY6YCwpn4DjYq8TP?=
 =?us-ascii?Q?W7xZazDgafKImn/hNsQIBtvoD6rSZoVk0tkmRPpA7e/CrECsSaRIT9xB2qDY?=
 =?us-ascii?Q?l4fBuI54lQTB6Fo4hQg9Ow0mUx76WKKdbPZWH3Sy7J1quRzq1rY71kHEyAmo?=
 =?us-ascii?Q?N3OVkdTvj1CpCS2wnMJT/hQS5i//JjGlgLbcVWyff0CDVplvHVpt2X2FFozE?=
 =?us-ascii?Q?JcIHro4B1e4lfsJ999xKDj39BMGTgOh6sS6iEeVBDyT28N3op35kJRq8W8i5?=
 =?us-ascii?Q?JrzvQuRvmEo2bN0TImWtmbQYHKMUGd34EXf1lRqE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952cd74a-e2dd-4ebe-ad52-08dd0e02edd7
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 10:13:10.0397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERFK2N7aTuE0M7PaHws6xUMUCNJXut2YVeaX7eATwI2xOsn7FbQLPmH4+OL7Jal6C3NxXrwkcJrLqx32DHDA7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888

As discussed during the sched_ext office hours, using a global cpumask
to keep track of the idle CPUs can be inefficient and it may not scale
really well on large NUMA systems.

Therefore, split the idle cpumask into multiple per-NUMA node cpumasks
to improve scalability and performance on such large systems.

----------------------------------------------------------------
Andrea Righi (2):
      nodemask: Introduce for_each_node_mask_from/for_each_node_state_from()
      sched_ext: Introduce per-NUMA idle cpumasks

 include/linux/nodemask.h |  18 ++++++++
 kernel/sched/ext.c       | 110 +++++++++++++++++++++++++++++++++--------------
 2 files changed, 96 insertions(+), 32 deletions(-)

