Return-Path: <linux-kernel+bounces-569257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B372CA6A097
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09E73A8B38
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB7020DD72;
	Thu, 20 Mar 2025 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LdTalVJp"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB47D15C0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456428; cv=fail; b=rirdx2iR/nVCX6uqpn1z+Ut/X1ajPQ0I3EIlYbxExIDBTqqXDZhGR1nUqNCjetObGRATpTv05ue0HVazlCXJyfN0ojrDwEbT0Ep8/ZuPwRGweUsX2Y5xm7kO6RW48Z75SODgnaUtmSu0h/DJwy+fijpCWlmEuxJd2y0KrZrOZRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456428; c=relaxed/simple;
	bh=1Ch/ZoErVs6fOakBfeUYSAYw2IrBb2QlsQ6pKQLGZSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PEemOSqD0mkd4eFL+oZW43Yj8ukPPgNbBs2HxcyLc9l9M0ZbYokWGpjs3ZKY3dG+Cz60CC/9ElveSUD4+ch9SU107WJDjdU3zMXOPBEmBeY9u+CcqhNFpufJ60R10yNoESpMpJl3a/6M98Qb4lEHVKcWZ/HcV4qo7zH/31lkRyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LdTalVJp; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xv0Te70OGUrpnpUegPqUt+GACkcP2kWCHmjV/PB/Hh7xr2jGBei9KtWOdyQSSiQQmBZpgRLI2p/z8h/xg8sLIe/kUOnLuxrh7JbQ1T5MIQ7Eyy19M4CbEX4kIju2tjaGovqJz/q0EJbAHZFPUghT3MLcntxq8N6QVKFlm/1oZthmF5fbjVPfdX+BXjY6uWjfFZk80NHd46ZeAPxtlttqec7fgkqAxmddCMvJylMMH0w1AJG2KRfw4fDFSeStY7HguZaUjkFP5SndAm8ym8CL5Ilq+mBJq6zcZKG+fZXon1INkthtDBRv9xUqcClWsOCy+8WEsW4lIzT4LL6j0dplVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XEnazbxqVE1UGjyTx6BVvDLYd5whNAOpc7TpFhaA2g=;
 b=KtHwUbgdHY0ifQutEF5W42TDPq5MfDUVq7RjjaxervORZN9LQ+FDlrBZxeQnn1rrWVBNV7b5AJXxbAPWgG1oHMTAtYQ+vkGEaeMgGQ9PDh7UgpJclnhMM31ZWRv3+9dE3vYWQD9Mq8c5AQrCtx6KUc2z1RxmevgiMYObCCvJ/HkVkwclXZF9/JzkDxWwdPDa3Ib5Z8F9g4V4qqcMeQaq30JM4kIisYhn4Dh+zGanEtuL9ttk/dn8XhigY/jMFbDectqHQAQwQ0DOC8ltajMb5Je07dp4CaPZFqwHCdukNzbUbmjzLCUivwzfx8lf/yBGcOSmmY54ohf+YrvAyunuHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XEnazbxqVE1UGjyTx6BVvDLYd5whNAOpc7TpFhaA2g=;
 b=LdTalVJpB5uxorBceG25uPzDuT6Bqpes8EJOVBMCjRCvj3x4NfLhbn1iqvKYdSZMA4+PxClWOul2IrolVbXAzs2QZJ1KgorHseOHb9x4qxf1At2V3kOdGqRv6hHB2qsVcutx/gVk6VP+ZpZlOLyG3aPhUobJVCVes/eIDIRGuEZIQwUpszW/gjRhwLTFnLOogJX0zdqJYySXpF1OdExs67AGvk5DFXuOYVxzcI4IPUnV/IbIB8I1zBByciBSdBamqvke0M8q582t0BQRVXH2TUEp2Fc5tSQlWO1Co4rZ+ANt6qr+KkriKat2/Tq02nttIhYeDrOtmCeY9G5Cz73FNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 07:40:23 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 07:40:23 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] sched_ext: idle: Deprecate scx_bpf_select_cpu_dfl()
Date: Thu, 20 Mar 2025 08:36:46 +0100
Message-ID: <20250320073927.216147-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320073927.216147-1-arighi@nvidia.com>
References: <20250320073927.216147-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0157.namprd05.prod.outlook.com
 (2603:10b6:a03:339::12) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbddbf2-ad95-45ab-b792-08dd67827926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2aERqfuroQ6qfZhpyzMiNrMoQ6eOxqPugsqMP26VPgJlFZGAw1Ssihs8S6A8?=
 =?us-ascii?Q?r1byBbazPPnHXIZvfNr8TwHmxF1doxwHmMsMqQEFtLXHj3s97yglS+XLoujf?=
 =?us-ascii?Q?c9lWinWiccEa4/fqwk6tciKVLYrm9TcaihZsSM9CQ1FLyFrohkQDvkfV0AXl?=
 =?us-ascii?Q?Rond5cJBgDbO7r82bvOO7SDJsQw678xAfKxN3602kU1Cnj43HGliR7X+XsKd?=
 =?us-ascii?Q?BEbmp0ZU8cISi3F7ZnjsuJLClkWpkA9dNjT/x/2p/s3qnsCcRbd8kTIInD3O?=
 =?us-ascii?Q?JWgDuj4S+cQWHaHB69rfD86AhSqPJ6XpzD2VWYgDl2vkD3GtelEVOakIQ9FZ?=
 =?us-ascii?Q?aNiIvDyMPjRNoBtK3TvTaUTICxzNHSO3toBTyxbhtaTotzGtZ/QRvNznwjXg?=
 =?us-ascii?Q?f5YrspO3EMef3ar5v6LGc1AJnjG2WsvCztdUDsiL3NSD0IMLvQskq+P3eh3V?=
 =?us-ascii?Q?gy9Q+x0iMR7HMEtuqqFldx7E6DvFkrGm32tkaZzabMUz2DArXEVHNumHgrOT?=
 =?us-ascii?Q?/GU0lOBLaGxooboHbuQFJwi9/i+Eo+r76M2Cx/L0h1gqynwv+wlJGx3Uz8aQ?=
 =?us-ascii?Q?fvaq4TAuAhR+D0EgkXTmBOFXgkAYt5kGyGGhqHqefDMOlM3AAlKCrSA467YF?=
 =?us-ascii?Q?aRE84KBzLD9UfumLXQtkEPK7tgtRPMAhCwgeb2Hj0n9oVhuk4p/oE0qPMKK4?=
 =?us-ascii?Q?GZs7G5TkiFFgWyvijjfkfQ1N3C+9b5K2GLBnOg2TwmLiIA6kwT6TJaL/NE3m?=
 =?us-ascii?Q?b/eejW/30Y9+LGEheSIQ47p+mtJlxTZl45C1GQyvmAVKevx9cvGUl9hee10d?=
 =?us-ascii?Q?2/aHYjuXGIQn+/kgJpf5/TjmzUa2QnsAgDewvBADI2XSs3lHDjTaEkmWJFUi?=
 =?us-ascii?Q?cvJ5fOkVi1X1rt14nnV2417/WSnfPi+9NG1AU/mQLLhe+wc4H+ZW5Yg1qaiv?=
 =?us-ascii?Q?X4SlVWICK5R5WvjkUSkor8ZciNl2vFxaIyRZri1la1xmmFemCDJg9FAecNUd?=
 =?us-ascii?Q?1g9bZWaQbx73cplb+4dFKmToUtYI5N/6cLss1k95g/d3M6Q5B7fYuCS0S3/t?=
 =?us-ascii?Q?KaKPm+fkdW0DOsjpmr1J6aDMyb54RdnargIyGeCfhHRvrSgETVSh+wdupgUR?=
 =?us-ascii?Q?JR3doaqGOpZOewKvxovyH8yv6s6TJc6QQgeXJt+Rvof+MiCRq52xUvIEH3Qr?=
 =?us-ascii?Q?Ivvm5ZLeH0LelxGRGNhvVLsDR7uRbHN8SmKS/7o5WIAdSZwyqgDlwPsVmDQN?=
 =?us-ascii?Q?atODggaARQlsIhpzdPzdb2h3jZQRUgNcIzahzOPPIuQwmLloE4fHoK62pbFy?=
 =?us-ascii?Q?c9QS4hOMNbRuCz+LAQTsdcu7DN/ZOWdCEV7I5Ap7kWebbrGI/YTKV06hmtHV?=
 =?us-ascii?Q?KkRFp7XaOXq9YZZPHVn/1Yol49r+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XKLYr7A79af4gLtffkGyZxjq2GXlLRvggOiXfKeUrjVND5esrmktXGRgPDlh?=
 =?us-ascii?Q?oKgvoa3AV+oASjGwKV86DcgIHPWNTtyN/g2yp1LBY5NI0nnTKjBtWDSWKVge?=
 =?us-ascii?Q?gLgkq+QBZ8aHrgUxgh2/bMJpMRiJijofgFZnjSKJDUHkvUbC9csNABO18oCW?=
 =?us-ascii?Q?vZqQF1d2Sa1+6uIMLT2zhN1RcxKXinboqP3ExkdZeHLPLrmlAsEzuebWwKrb?=
 =?us-ascii?Q?f4C7vxTem7fbww3FDke+ZX8pacgY7/cdWe09cdL9bTPPXrheEig0io+f/zrN?=
 =?us-ascii?Q?TDAdhuQVAKTXGnwy/4eC9SM+5Iz9Pm4wOO1PaPiyCqO8Brl8vvHZeW7YlfZn?=
 =?us-ascii?Q?5c1oExft3sHmgo8ujWQ6mFYItIghciUx3dpDXty8xbw05fCsNnAdrpPyqmoU?=
 =?us-ascii?Q?x/6ZFClEjJsIPIs2fijFUq+FOs28XPj3EErfJcYTe5DApav7gYqrA4+uH3UO?=
 =?us-ascii?Q?1fGeUk41Wu2SImy4LrGdlpC9aTSYHzPzTJR8b41dudStk9fsGV6luPZ/B766?=
 =?us-ascii?Q?O7D8bZ0I/cBIhC60yEI0RjMX8kvaxQ43SLCnYOh0AmV82i8FcsNHccnAGP0q?=
 =?us-ascii?Q?r/rG6+CHFJK1qaGSxVbKSCbauSiOny9D8YMU1QXu2PowZJZ+R+8Yy9w8MBUw?=
 =?us-ascii?Q?nAX7PWYsE1LvSabPDIJDQGhZfkHHlAoN6dOU9x7/qtdmcf6UsGUFo5s1PO9g?=
 =?us-ascii?Q?X92ux1pLXbCaooFbLN7XpLnGZpxaRE9zKMJjDNH9X1FApzx1i7XE1vX3dOas?=
 =?us-ascii?Q?qKXf7UECk0MxktzLVfSEGifHwN4FdctFuFbZkjAyuIWdSLimBsQrjRBhzoLC?=
 =?us-ascii?Q?MednJj7wkzo6y1afsdhPQphcC/1CO6uesWKEAUUOdGJNw4X1nuXQfivj3MOd?=
 =?us-ascii?Q?iPLx+4TI/z37t1th9BrJOoq6aiU0YEBDuwyNDxFueplSwujRP+e/JpfPAkjp?=
 =?us-ascii?Q?l1Yg8nfjBiuMVsme8k1Iy5imBSosyzaixQ3ELJP74nqN6fmosbWz0A7FsrF6?=
 =?us-ascii?Q?44brJWg6oGmuI8G8duvvTpB+HzhUjPLK5hRilQjldj7xVVgeB0ySQEaGY3jm?=
 =?us-ascii?Q?2lIZA1MNSEsqlPyZFCOpeI+SK37syeelqAr+zpcxEK309EaSrrf4uJtRn+Ai?=
 =?us-ascii?Q?FWZckFzjku70U+5s6X74sOnIMQxsqdVdwUVQyRbHyH0vHOy9/JYjggrMH8JP?=
 =?us-ascii?Q?plJcMGmd5nsjuTSW9RguTXnHIr4qtgwFwDdQiY1leMdQ8EIM0abSPA/TTTHV?=
 =?us-ascii?Q?Q0+BVr7MnwVd4keVmNGJMfTOZaFQMspMeLJEOEiY8/EBXrccYwJ71bEeqCzq?=
 =?us-ascii?Q?E7N1uzfx2vwZglxWAyzXDcjrLFC5BX+W647brnaVTuj+u/PhE5rRw1KGNac0?=
 =?us-ascii?Q?Sp6gmae5OzwYy46iTuRRyXbIlxEBLHELKJt7p3tksJTZeS0trRQuhtj2qD1q?=
 =?us-ascii?Q?MwzNffJtMvESLTo4lnITkyFvg2CTdZUVR+MsFctomKtqAJ3nPBO954ic+ZFR?=
 =?us-ascii?Q?7M9eMVNXnmjqSpL+hQSmCHRchh3wmWV5Wz5BCeR03gnzuXVrdkQGGnjJ8Dg8?=
 =?us-ascii?Q?gNeZY5vJzA/o5QcBMK7pPhCHAgafHGiDA+iQk+SJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbddbf2-ad95-45ab-b792-08dd67827926
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 07:40:23.3381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7jE5L+lTxrtmrFWctgjJBRNqeWqqkySRB+gdWF5dW6CGXmheGEt0m2lXY8eVWE8Z/l8gKoc2Hv+6eqLh3N9tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438

With the introduction of scx_bpf_select_cpu_and(), we can deprecate
scx_bpf_select_cpu_dfl(), as it offers only a subset of features and
it's also more consistent with other idle-related APIs (returning a
negative value when no idle CPU is found).

Therefore, mark scx_bpf_select_cpu_dfl() as deprecated (printing a
warning when it's used), update all the scheduler examples and
kselftests to adopt the new API, and ensure backward (source and binary)
compatibility by providing the necessary macros and hooks.

Support for scx_bpf_select_cpu_dfl() can be maintained until v6.17.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 Documentation/scheduler/sched-ext.rst         | 11 +++---
 kernel/sched/ext.c                            |  3 +-
 kernel/sched/ext_idle.c                       | 18 ++-------
 tools/sched_ext/include/scx/common.bpf.h      |  3 +-
 tools/sched_ext/include/scx/compat.bpf.h      | 37 +++++++++++++++++++
 tools/sched_ext/scx_flatcg.bpf.c              | 12 +++---
 tools/sched_ext/scx_simple.bpf.c              |  9 +++--
 .../sched_ext/enq_select_cpu_fails.bpf.c      | 12 +-----
 .../sched_ext/enq_select_cpu_fails.c          |  2 +-
 tools/testing/selftests/sched_ext/exit.bpf.c  |  6 ++-
 .../sched_ext/select_cpu_dfl_nodispatch.bpf.c | 13 +++----
 .../sched_ext/select_cpu_dfl_nodispatch.c     |  2 +-
 12 files changed, 73 insertions(+), 55 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 0993e41353db7..7f36f4fcf5f31 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -142,15 +142,14 @@ optional. The following modified excerpt is from
                        s32 prev_cpu, u64 wake_flags)
     {
             s32 cpu;
-            /* Need to initialize or the BPF verifier will reject the program */
-            bool direct = false;
 
-            cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &direct);
-
-            if (direct)
+            cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
+            if (cpu >= 0)
                     scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+                    return cpu;
+            }
 
-            return cpu;
+            return prev_cpu;
     }
 
     /*
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 343f066c1185d..d82e9d3cbc0dc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -464,13 +464,12 @@ struct sched_ext_ops {
 	 * state. By default, implementing this operation disables the built-in
 	 * idle CPU tracking and the following helpers become unavailable:
 	 *
-	 * - scx_bpf_select_cpu_dfl()
 	 * - scx_bpf_select_cpu_and()
 	 * - scx_bpf_test_and_clear_cpu_idle()
 	 * - scx_bpf_pick_idle_cpu()
 	 *
 	 * The user also must implement ops.select_cpu() as the default
-	 * implementation relies on scx_bpf_select_cpu_dfl().
+	 * implementation relies on scx_bpf_select_cpu_and().
 	 *
 	 * Specify the %SCX_OPS_KEEP_BUILTIN_IDLE flag to keep the built-in idle
 	 * tracking.
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 220e11cd0ab67..746fd36050045 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -872,26 +872,16 @@ __bpf_kfunc int scx_bpf_cpu_node(s32 cpu)
 #endif
 }
 
-/**
- * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu()
- * @p: task_struct to select a CPU for
- * @prev_cpu: CPU @p was on previously
- * @wake_flags: %SCX_WAKE_* flags
- * @is_idle: out parameter indicating whether the returned CPU is idle
- *
- * Can only be called from ops.select_cpu() if the built-in CPU selection is
- * enabled - ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDLE is set.
- * @p, @prev_cpu and @wake_flags match ops.select_cpu().
- *
- * Returns the picked CPU with *@is_idle indicating whether the picked CPU is
- * currently idle and thus a good candidate for direct dispatching.
- */
+/* Provided for backward binary compatibility, will be removed in v6.17. */
 __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 				       u64 wake_flags, bool *is_idle)
 {
 #ifdef CONFIG_SMP
 	s32 cpu;
 #endif
+	printk_deferred_once(KERN_WARNING
+			"sched_ext: scx_bpf_select_cpu_dfl() deprecated in favor of scx_bpf_select_cpu_and()");
+
 	if (!ops_cpu_valid(prev_cpu, NULL))
 		goto prev_cpu;
 
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 6f1da61cf7f17..1eb790eb90d40 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -47,7 +47,8 @@ static inline void ___vmlinux_h_sanity_check___(void)
 }
 
 s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
-s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
+s32 scx_bpf_select_cpu_dfl(struct task_struct *p,
+			   s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym __weak;
 s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 			   const struct cpumask *cpus_allowed, u64 flags) __ksym __weak;
 void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 9252e1a00556f..f9caa7baf356c 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -225,6 +225,43 @@ static inline bool __COMPAT_is_enq_cpu_selected(u64 enq_flags)
 	 scx_bpf_pick_any_cpu_node(cpus_allowed, node, flags) :			\
 	 scx_bpf_pick_any_cpu(cpus_allowed, flags))
 
+/**
+ * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu().
+ * We will preserve this compatible helper until v6.17.
+ *
+ * @p: task_struct to select a CPU for
+ * @prev_cpu: CPU @p was on previously
+ * @wake_flags: %SCX_WAKE_* flags
+ * @is_idle: out parameter indicating whether the returned CPU is idle
+ *
+ * Can only be called from ops.select_cpu() if the built-in CPU selection is
+ * enabled - ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDLE is set.
+ * @p, @prev_cpu and @wake_flags match ops.select_cpu().
+ *
+ * Returns the picked CPU with *@is_idle indicating whether the picked CPU is
+ * currently idle and thus a good candidate for direct dispatching.
+ */
+#define scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, is_idle)		\
+({										\
+	s32 __cpu;								\
+										\
+	if (bpf_ksym_exists(scx_bpf_select_cpu_and)) {				\
+		__cpu = scx_bpf_select_cpu_and((p), (prev_cpu), (wake_flags),	\
+					       (p)->cpus_ptr, 0);		\
+		if (__cpu >= 0) {						\
+			*(is_idle) = true;					\
+		} else {							\
+			*(is_idle) = false;					\
+			__cpu = (prev_cpu);					\
+		}								\
+	} else {								\
+		__cpu = scx_bpf_select_cpu_dfl((p), (prev_cpu),			\
+					       (wake_flags), (is_idle));	\
+	}									\
+										\
+	__cpu;									\
+})
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 2c720e3ecad59..0075bff928893 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -317,15 +317,12 @@ static void set_bypassed_at(struct task_struct *p, struct fcg_task_ctx *taskc)
 s32 BPF_STRUCT_OPS(fcg_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake_flags)
 {
 	struct fcg_task_ctx *taskc;
-	bool is_idle = false;
 	s32 cpu;
 
-	cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &is_idle);
-
 	taskc = bpf_task_storage_get(&task_ctx, p, 0, 0);
 	if (!taskc) {
 		scx_bpf_error("task_ctx lookup failed");
-		return cpu;
+		return prev_cpu;
 	}
 
 	/*
@@ -333,13 +330,16 @@ s32 BPF_STRUCT_OPS(fcg_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake
 	 * idle. Follow it and charge the cgroup later in fcg_stopping() after
 	 * the fact.
 	 */
-	if (is_idle) {
+	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
+	if (cpu >= 0) {
 		set_bypassed_at(p, taskc);
 		stat_inc(FCG_STAT_LOCAL);
 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+
+		return cpu;
 	}
 
-	return cpu;
+	return prev_cpu;
 }
 
 void BPF_STRUCT_OPS(fcg_enqueue, struct task_struct *p, u64 enq_flags)
diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
index e6de99dba7db6..0e48b2e46a683 100644
--- a/tools/sched_ext/scx_simple.bpf.c
+++ b/tools/sched_ext/scx_simple.bpf.c
@@ -54,16 +54,17 @@ static void stat_inc(u32 idx)
 
 s32 BPF_STRUCT_OPS(simple_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake_flags)
 {
-	bool is_idle = false;
 	s32 cpu;
 
-	cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &is_idle);
-	if (is_idle) {
+	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
+	if (cpu >= 0) {
 		stat_inc(0);	/* count local queueing */
 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+
+		return cpu;
 	}
 
-	return cpu;
+	return prev_cpu;
 }
 
 void BPF_STRUCT_OPS(simple_enqueue, struct task_struct *p, u64 enq_flags)
diff --git a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
index a7cf868d5e311..d3c0716aa79c9 100644
--- a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
+++ b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
@@ -9,10 +9,6 @@
 
 char _license[] SEC("license") = "GPL";
 
-/* Manually specify the signature until the kfunc is added to the scx repo. */
-s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
-			   bool *found) __ksym;
-
 s32 BPF_STRUCT_OPS(enq_select_cpu_fails_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
@@ -22,14 +18,8 @@ s32 BPF_STRUCT_OPS(enq_select_cpu_fails_select_cpu, struct task_struct *p,
 void BPF_STRUCT_OPS(enq_select_cpu_fails_enqueue, struct task_struct *p,
 		    u64 enq_flags)
 {
-	/*
-	 * Need to initialize the variable or the verifier will fail to load.
-	 * Improving these semantics is actively being worked on.
-	 */
-	bool found = false;
-
 	/* Can only call from ops.select_cpu() */
-	scx_bpf_select_cpu_dfl(p, 0, 0, &found);
+	scx_bpf_select_cpu_and(p, 0, 0, p->cpus_ptr, 0);
 
 	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
 }
diff --git a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
index a80e3a3b3698c..c964444998667 100644
--- a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
+++ b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
@@ -52,7 +52,7 @@ static void cleanup(void *ctx)
 
 struct scx_test enq_select_cpu_fails = {
 	.name = "enq_select_cpu_fails",
-	.description = "Verify we fail to call scx_bpf_select_cpu_dfl() "
+	.description = "Verify we fail to call scx_bpf_select_cpu_and() "
 		       "from ops.enqueue()",
 	.setup = setup,
 	.run = run,
diff --git a/tools/testing/selftests/sched_ext/exit.bpf.c b/tools/testing/selftests/sched_ext/exit.bpf.c
index 4bc36182d3ffc..8122421856c1b 100644
--- a/tools/testing/selftests/sched_ext/exit.bpf.c
+++ b/tools/testing/selftests/sched_ext/exit.bpf.c
@@ -20,12 +20,14 @@ UEI_DEFINE(uei);
 s32 BPF_STRUCT_OPS(exit_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
-	bool found;
+	s32 cpu;
 
 	if (exit_point == EXIT_SELECT_CPU)
 		EXIT_CLEANLY();
 
-	return scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &found);
+	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
+
+	return cpu >= 0 ? cpu : prev_cpu;
 }
 
 void BPF_STRUCT_OPS(exit_enqueue, struct task_struct *p, u64 enq_flags)
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
index 815f1d5d61ac4..4e1b698f710e7 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
@@ -27,10 +27,6 @@ struct {
 	__type(value, struct task_ctx);
 } task_ctx_stor SEC(".maps");
 
-/* Manually specify the signature until the kfunc is added to the scx repo. */
-s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
-			   bool *found) __ksym;
-
 s32 BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
@@ -43,10 +39,13 @@ s32 BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_select_cpu, struct task_struct *p,
 		return -ESRCH;
 	}
 
-	cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags,
-				     &tctx->force_local);
+	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
+	if (cpu >= 0) {
+		tctx->force_local = true;
+		return cpu;
+	}
 
-	return cpu;
+	return prev_cpu;
 }
 
 void BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_enqueue, struct task_struct *p,
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c
index 9b5d232efb7f6..2f450bb14e8d9 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c
@@ -66,7 +66,7 @@ static void cleanup(void *ctx)
 
 struct scx_test select_cpu_dfl_nodispatch = {
 	.name = "select_cpu_dfl_nodispatch",
-	.description = "Verify behavior of scx_bpf_select_cpu_dfl() in "
+	.description = "Verify behavior of scx_bpf_select_cpu_and() in "
 		       "ops.select_cpu()",
 	.setup = setup,
 	.run = run,
-- 
2.48.1


