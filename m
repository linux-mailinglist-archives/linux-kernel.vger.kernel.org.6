Return-Path: <linux-kernel+bounces-377933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A8C9AC8BB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9744B21DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4711A76A3;
	Wed, 23 Oct 2024 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cu0lD0CF"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EF81B813
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729682357; cv=fail; b=KLT/kZ2TSidm/BZ27GQQf50s6PHOFdTsW5ZCJfOe9lOWSjOH0xMpI0URquEruCbGP1eE9cpl7ZRKJxNcYGpvND9DS0OqxD+/QNb37T4I1q0VTPs3GDb6bGYfE9pFDUxHevmsAdL7JVZV/W4vw7KMbol1EUbFFO2FMBD7bVj4cME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729682357; c=relaxed/simple;
	bh=eAqVwf0aEBfP/LH4yZt2F8HttXZEakObnLK+Tf/gIQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LaO2o3yEu72XGNEKE0V6fg0By7QgqYhSg/Akrm2X8lDuaMz4mUkpkrg095bhngCzn+AmjI+HLn5fRH0M0kjYQbn3QP4uW1u3SoHpL0qCBr4oMds6H5YJ5pxlvwrFQ6fHEYAHhoZ9kdOUhg6HlEZnz8L5dqw1mSM2oKKzPhIBgC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cu0lD0CF; arc=fail smtp.client-ip=40.107.101.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEt7RPOJmInPf+1k7bulRwNIHsnCEr7yxwBMtKFMRKFYfGoEnhVlfXmm/Z+dbsiPFdF6Y5zTsh3P52kYmCnADg9i82Ons+q3pLIiovCNQKX0LAyrosP2h7AUcbCRtIXC+VgXKfrUxlGo41LdX5VvhZr0pACu9UO4aINPVitMvyAPXTBIrBX0Uk2nicoR1s5/qhRgXz/pD2Fla11P7zgUrO75e4xHfjUoQ1EpD6OAvVTzqtts+PVutWO7cMcm+eUroBAhbIw2d/vZohUtMSdbf0oFzRlxsz/yT9AtBDW8hVikK48g+MGsuQo4ERYjiVWdII4irW/pF94E+DNg6FLJbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26WzKfFZNnHOv0J5IZ70id3/VtSzHM7eBpg+YtcFCkg=;
 b=cO/K7E8yKK5q6Q1iAzgD6N5Z9tLjEXnuSTs6L+v7yOFIN2xHdTrEy5f1wf3ksqM70cp5MU0Ruqykm3p+5i6ulg23/oFkkG5Z5Rxv7RC6l/H7WlF1qZR0pt3a4gAKOzTWJGSKZAv/9gjfOjWm+T9PSMnoMmDLT6LRhQlir2v3sqS/6U1Lhaw79Bvo0Elp3JvPzmN5BOP91hb9DGmyISNSTPh0QVKK/MO47an06Vk7ZBrX0kGw3OwuyOFbKTdvJ80pBpQIVS1mqJX4KlIYUKxpDrx3qgVcorp2ywhmddG5t1uI56fMCdhFHBWrjhjv9MXcK4HEMxmjTNEJzjqSBr21ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26WzKfFZNnHOv0J5IZ70id3/VtSzHM7eBpg+YtcFCkg=;
 b=Cu0lD0CFUXA2GQmU0i3MXTQ8QEDMsb/b12wVVk0+v3H555uBOcig0fa+wQkkcZK9MBM2ZfIBsAfhFMmi535kJHC9ym/eUTNL44eXHc+T78tYQGE+EItkFGJ0asLOEYOiPmFD7/gwxpiJF4mKGHA/eUT52n0KH+V9ejcyvSQcIH3bcR+r7ptg4afi17+tDHEiNXD77+bRrnr3FBiZnLl/Gaun5bJo5W0vUy5M6TVQ7d/PiR2dAR7/c/Z9Gff7r5C22kGi9Ew+lnGVX4CroWtlyO5psYCqSrkMp1xE1E4Hqlwvvi2RxY+uVTByUKNsiPDuXA9nmJc9bHoXbxgTkkKYsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CH3PR12MB8356.namprd12.prod.outlook.com (2603:10b6:610:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 11:19:12 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 11:19:12 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Clarify ops.select_cpu() for single-CPU tasks
Date: Wed, 23 Oct 2024 13:19:07 +0200
Message-ID: <20241023111907.36172-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::8) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CH3PR12MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db78698-c801-4943-51fc-08dcf354858e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m1DPURdHQt0msi+OrS1BBMw/oRnmVnn36tZG0BpwaIa0OPmu8jYjBn1mOfE6?=
 =?us-ascii?Q?/z0u5CKc8NmXRVMCA9cdy2gsTyno7X2N79FUy3m2AWQ+tjeMRoox9QvytQgc?=
 =?us-ascii?Q?A61P/dF9egRS+KNDdr7z/04PhEVM5/TCs9PjhzdvoVPAWkzefjrMCzUqERxb?=
 =?us-ascii?Q?WTbelP1Ndrbd+1iTDD3e2bl6RsWx/Be/5iPKEa++so1Kn+i6GXu5SgfWHFL6?=
 =?us-ascii?Q?/BFY4x0WRlqSzpRQ1Fr+g5e6FMzcSejRjZmM8RafnWWHo/vtRnPrwouyhQTV?=
 =?us-ascii?Q?pFV0mDrxM3EEWX9ut1NmVVaqAlpDDIrlpIqNIGRwmMuS3IOJT774WNwieDYp?=
 =?us-ascii?Q?BgsqLc+boec1rKDy2YvgNHwfquD9h1Aka0pOdafO30Bit9s5x3VXv6IbwHEr?=
 =?us-ascii?Q?EpIhu1/QUdCweFSXfmzpVcBmROGn9sfK5lr1IQcZOqY/QgSH4mSO0Nbwj86X?=
 =?us-ascii?Q?2eStH54RjS9JNmAHXwMjKm/zYwQovy23Saek7YFRxgavDwdhH64DuX4lle9c?=
 =?us-ascii?Q?UzAyLpmQZ10IwyLAHf2XhUp56sPz+Ps++apJ/JAS69HO5X12MLjIsAZ2pB89?=
 =?us-ascii?Q?bTKpkfSLlVtubJ2II9d2rQYqTIGNB2rExbFDuXOMFwk1uY+/B+JixIowWhre?=
 =?us-ascii?Q?dcD/cBF9733s7SfBiJsekugSHafYuSm37p7miYnatCft5kialOj1W1Hwgbem?=
 =?us-ascii?Q?mLjEVc35m0jq6Q3Ousrh0iwxdy5d0SbQiEJ9sUppxGKYe+utxeCxMaoatG8K?=
 =?us-ascii?Q?lpxJxoPYVnepquvdakFkDQFKiYO++57iuFQZxJWW8+/mlrc31TuUrQYaZJUi?=
 =?us-ascii?Q?YFoMSu8gwWWoVpevLSa9LyCeW5ppA8JE9okkgpyY3o81wA88jbRUOMrai7rB?=
 =?us-ascii?Q?ridY5yCSOcGo+2tPb5dbQQH4KDz/9hhYPxNH7d2ezsQKYklmLU7zHUqTKQmC?=
 =?us-ascii?Q?1nSv66sL1CGVtV6JOsQ3qkjE08LobGHNp5QpS7o7O7NYbiGTbc+crwCJraMZ?=
 =?us-ascii?Q?IGJOyFUWt1cmCQOP58ssAl/IkEeBxBqPCGGzRyuwXZysSP1NclF8Icf3jqrz?=
 =?us-ascii?Q?wp+lMWhLayHMYIrgWnVgTOcfrt3hVbS++xSdKZPm4g4wQ5vQNBI0Gj0jZlfX?=
 =?us-ascii?Q?nXWhVK4hisFR87pRD0ERCIKEOBhizSLB3o8MrYo4UhmqzF2N6P6Aj5pR/MNF?=
 =?us-ascii?Q?pmwmiPNT9PZPJnEjdDsHYQlnaLo8uCCqnM19MMgH3UnnN2YKt77ll6ln0BAp?=
 =?us-ascii?Q?c9ntjdbP1D6tBsq53t6vQ3ytxSdORlGXP8H5K472Hjvy2RTqNPDLrsEOf1mF?=
 =?us-ascii?Q?QnWqRg7JVzxHjAMt1PcPclF+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0VgMjaaHlvYq6XnyMcGCsSxpurJbi9R34ynhMQD/MUtvuEwrhm/h78Iueb9d?=
 =?us-ascii?Q?nKnDrWXPg6Kp8uT6O56AMYLMuzBJIprXM/uWy3u0KYr0UOXXXv1V5GMOeX2U?=
 =?us-ascii?Q?qyjrUV8rUAz8aE0oaBLa6TpU0jcMXrny2lHSL9s20WeECb8qUj3Qe7OsYhjX?=
 =?us-ascii?Q?B9IZscVtSmuC2Ni9SvXDGaJJEkm5902d0uNUY6vfosoIgooEmf5XdArYvkb9?=
 =?us-ascii?Q?yJYzhmcV4c4W6wu9JACDVjVIopYy+0dkkRd0BJuzMdoNu1YvEHL799QyXEqg?=
 =?us-ascii?Q?9JMuMZVWbPWEHawkD4TYVqHMTxsTn3q63N4T8ep7nYgib3XkGzTm3cRer2fZ?=
 =?us-ascii?Q?h3v07grxpjCsDg9dueHSoHCYy6IZfqAXZg2ugEJVevGIHwIyl5WWIaldWafS?=
 =?us-ascii?Q?tpr7MiJKDWlLWoUHXINcm6GblxENxrBRFgP1YNwWD69Tod9qa3s3p2Uy+u+V?=
 =?us-ascii?Q?5Fb4pxAnDaUBu6eARXQFAOrNehiO+uW8H2WJmjJ3bwZSDVyDad9xf7JLaDLs?=
 =?us-ascii?Q?dsnIjCs+DtpZWVR2+H6ph0jKyZv2/2ewVgC/LmA6mxDFyLvHEmvZ1YuLKhZz?=
 =?us-ascii?Q?WG7mgJR7N7Osz37zzsqtzJLhIFIN8EoQ5exg1b4EvG3guoR58aln4jzDOgPY?=
 =?us-ascii?Q?/gg3oU9SVIgcQAH8waPXKcWMJ8PcXsZGIXPH4zoTBMRi19k2FWJaGJKzJUCF?=
 =?us-ascii?Q?valppNESh3ivOEjbRqq8nThB2X5CXWWbjUeZTZiyPWvD9wD5mlHGQsNIcXJQ?=
 =?us-ascii?Q?9/n30iWOwWjIj+dnYdbPJIMPhlT8mKZ218F/gHnJb9vAbnZxilLo0YYDce/Y?=
 =?us-ascii?Q?9pgDzFKX6vNWt09YT4opiaaEs6GEqETvTfdqu/M4nMjThGyLLeLmk2nL1KC9?=
 =?us-ascii?Q?ynVoHZ8h9rIiPq4ktMX/xbNKwj0kEM1mCe+kmS86PcWYBekruSfTL6giWqzK?=
 =?us-ascii?Q?dhEy0S5GmVz7ttYl1mefC35mokCgwvrGi8vZN8sOgb/+kRZSSn+v5cH1jIj3?=
 =?us-ascii?Q?LpTzdo8/gekvzjBlL+0xCyusWAH1xaVwr6I7b5oXAijQ7Imfrge82Oldzgiz?=
 =?us-ascii?Q?uqvYLLh8FMIbZrRDLgykQ3xoxp4C+ApZhXrnJ4WMcRUH3FLy5H5zvYhohgWo?=
 =?us-ascii?Q?lUx3d/potp1vLSzKF2nyFD5qiFhacIdzuf2Lv6wwsukQkNK5xfCzcd2OnLGq?=
 =?us-ascii?Q?nLMuqolHMyBuUigClGFSeSni0mrpgxFt/xnxFG2DxSkeuZ/wIM2HXPiEL7t1?=
 =?us-ascii?Q?zb6YsUhXHEwMsgizkewn7LzdYnMUCc5dC4zdv9lmpOp3c1IuIHxiOjXYKJpC?=
 =?us-ascii?Q?O7uNIWinzFAwgmJuWiF6/WDxoEB1Uywd2U1ecUPih/mw3cJe5DRx/QCBJgxd?=
 =?us-ascii?Q?NWwDvc4Coor1lQMV7JGaV1EGvskKk2Z/uplcfRcPy0uIb9Q80bytajDhnyWo?=
 =?us-ascii?Q?KYqBs6ioNp8+vCwTuBMUWpIHEFSZ0TKp4dOYrHAnhkA3m52GI0GygDmnX3KX?=
 =?us-ascii?Q?3EhHhv8JEdPtMxDKVk9BfbSZytiI5lP7x/6ODd9AVGmfQneEgAn3fZKLxhfS?=
 =?us-ascii?Q?VnrVAFVhNxFOSAmLTIGQjC8v7zFrJe09JVBbJYjf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db78698-c801-4943-51fc-08dcf354858e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 11:19:12.4300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfbVNDAAwHJ27SxEQDvxGJKDcUlSzeJRYkbnC54Vs/nIrSIU4AwkFbBuZAL1DkO1/oCRnYK6NeaCycoPnxZu4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8356

Update ops.select_cpu() documentation to clarify that this method is not
called for tasks that are restricted to run on a single CPU, as these
tasks do not have the option to select a different CPU.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 145677c6159c..b948fd96c29a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -222,6 +222,11 @@ struct sched_ext_ops {
 	 * is dispatched, the ops.enqueue() callback will be skipped. Finally,
 	 * if @p is dispatched to SCX_DSQ_LOCAL, it will be dispatched to the
 	 * local DSQ of whatever CPU is returned by this callback.
+	 *
+	 * Note that select_cpu() is never called for tasks that can only run
+	 * on a single CPU or tasks with migration disabled, as they don't have
+	 * the option to select a different CPU. See select_task_rq() for
+	 * details.
 	 */
 	s32 (*select_cpu)(struct task_struct *p, s32 prev_cpu, u64 wake_flags);
 
-- 
2.47.0


