Return-Path: <linux-kernel+bounces-560046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F87A5FCF8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DBDD420555
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCC1269CFD;
	Thu, 13 Mar 2025 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iyi88hbR"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6681B269812
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885415; cv=fail; b=HqmPbOtr1nSQsKUxAhW6SZ8zGFkKUsXyc2NL2tKlzZnAZWphobbfhobbKE2oBb9D8V58Op/o8XnO04xMnalXoDsejMq0RjyIRpibUf3C2Rp1VDlbkIR3PtF0QtTPaTp1Xbq8pMshd0EOeHV2rF4HacW+bdlO/URERkuJYFoh5xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885415; c=relaxed/simple;
	bh=8QNgwnFAPjCK0NL5iYuWVtrO8OosMgmIJLzUIbXeYi0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hOfjpGBrs8CaNjlmBq8Jd7yaHyCgA0fbq24V6l+F7zTDLCssAmxtESd0bDzCBw8Jf0iP+z7ClM1k038s21zBjoxTuBI96bebuB2SsPCAoriozz4Gq6enV55LcMo6qhUdHSvo1DudlA7Z2jDbXF3x/zkM9de4Raj87ngAdYbXZfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iyi88hbR; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gM3K69QD6jrdWIXpq5CIE0rs9YeUE0911KPH8hcRM4SYRLlk42dkW/tvSlQNOkvCoiiGXckSMUMRHqyTcPpcxfJdhg+LX/TiMqyAXne7GIVqIPeEwk7tgY/TCE4NYontSXnn5zF975ck80BUxBO3C7fmjRRIm2bb9E7zPLS973NcbBMgaUzyuvuV7Lb4TKznTqpRqBLFPmP6DTnHb0waSbguiWGP11x8wsnIO6LzWpy/Op1iRJ4J8xhBVhDcCVTKP+UZQrPC/Y4xseo8EG8yuvk6u/s6Ep4vqCl3Ge6DdpQObwJoau/Z/KvQZ9mLsG2XKzKyb8dKV0Jklm2WwBZOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFUhOQX012nZnPWwLSz5iisS/azNU2E/aL/wESWD4BE=;
 b=PRHYOze0ZfyxrGED/06PN1Fd0aBX8M851s3hwQ5lqDNVakDD9O8UQ9DeyTaDlfow4o8lY5ZQlpy99rcc9/he3CPHISz/NKIvK6BL7PGrTcYV87OwWzaAZCvpa5wBhal1R7BKFaCDPayZUZKtbrwwEhHj0H4KIkvPbxuWuGtkPQugiKqzugPruqD5RfjF2e6TlNn8En6H6SKpR5bE5RbFRK+pf6yPAfyk6rs1VL4PjecdRxQ9OWQ4SewN0ltjiioLTTkcpxwkz/6VBeEocGCehF+l5xWBIUQkBFZZgGesERDSU1PdU4q11V7ribZvLJeI1joPQ8GJsZbGXMmreK+Ewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFUhOQX012nZnPWwLSz5iisS/azNU2E/aL/wESWD4BE=;
 b=iyi88hbRbRKQ4qUxzIAzWOZXRFYwkFb9QlnQ90kpv9Yw8HrjK4RGcXPsZKn+W1qcTF9iYol/P+Nw/KvSEyBEEF2pVzSTKBPopTnQy9tVu8t4itF34rAN9tJdu5w58WGII6k93Z3ug1Wu5T+cSFV3Getv2GmRL6AMonfXvDttFJfBALazCi8auUEb0q4iyvjNZRUlsne/cIbGVj6KfbtTXDAP7pdeYvQQERPkCuQPB7feMgiGKKrTFQXcn6Sz+gazyWaT0LjWurBY9CFfT4zBnCPoIclVL0u85x9Eq3j4ySr8NWhraUP39Q8azjFI+gPxqGB4lHcVb3i1sfd5XC4X8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW3PR12MB4361.namprd12.prod.outlook.com (2603:10b6:303:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 17:03:31 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:03:31 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Skip per-CPU tasks in scx_bpf_reenqueue_local()
Date: Thu, 13 Mar 2025 18:03:21 +0100
Message-ID: <20250313170321.99510-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::9) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW3PR12MB4361:EE_
X-MS-Office365-Filtering-Correlation-Id: f513d33e-0dd4-4cb7-8390-08dd6250fb48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FE2gG+tyWL8GZnOdnfKr2O6/V5Kk1TYc4Mr4j5QBmyDWHfofeIS4ZSSb5KeZ?=
 =?us-ascii?Q?kISNsORc3X9dcIPG2MSUHG6i/8KxOU684AcNnVE2Dnm7E5JVZ734f+wwS+dd?=
 =?us-ascii?Q?VZP2Ej6BQ57O4Ci6j1z47ql13VSU9jX4gk1PZ6gm2Xfc0uJHYPnap48kywsD?=
 =?us-ascii?Q?W0fbfwNj/bGEOkkAm7/qvEN5ByLml/NegB43Hs9nK6XccKquFITUIhGwmfhC?=
 =?us-ascii?Q?44eUOldEP/7iEaJsXzqTlU3aIQbXeN59Cv7Wfee0J67xn+zyukay8QdcBT6q?=
 =?us-ascii?Q?iRF/tEfkrr07++5G5DTJfc1QT2B4QMgTfSSytzMWnkEIEYEyNHLTmY9m05+H?=
 =?us-ascii?Q?eknArLSGRMaSoIR3urat24zDRxGVtuKtq4TkhB2apauCaPIioVzibMV4QBGe?=
 =?us-ascii?Q?LU5MYlnlPMoDQYXkUDaHnujrTC74WtA1g4QidEwyaDKfY6i5Ezxu4V6/6p6z?=
 =?us-ascii?Q?He/wrpvsMf1qVK7UcTY5BD7R6aDXhEmSqDUHqjScxSqINOjl6tdJ05K2Kse0?=
 =?us-ascii?Q?2y6rgIh21+AKTyjBxLrd3SvU2FBKEatBaqEeCE/bk3HmSq0eBGlHLUyDYMqt?=
 =?us-ascii?Q?/dRBhxUZK04wt61xMjA/m5a6vgVp217l2N8oM7PSNHsy4w4B72sqTUESwcOD?=
 =?us-ascii?Q?n7ZwQELipihiBLleuSrorPZzrOsfCYT8P028h3/KF2FBp1IRzcPr5E68tzwd?=
 =?us-ascii?Q?rTosw4K1U77bgMee7/y2zXakbaky8rRhvCnXiDj1rb4mgH6KeTfwkoWrz17X?=
 =?us-ascii?Q?ETawYNzKiuU8TSPkPi8hbR2XopsgUuZ4gs+wiNyxGUwQgnyT+4tXS6Pi/fXu?=
 =?us-ascii?Q?qQuKq3+2PmZ4D9i3i+BofoMPZLla5uQdj2fCKIQMetX2qc/WBNtiJmu7JREU?=
 =?us-ascii?Q?TBBx6JJYt2dyXZpxCz/NuC0+iZbrbZPfOZwvPv9S4PUL8PsWb4I6AeyMsDWB?=
 =?us-ascii?Q?qKkL7bG0ABdkBi9BPcSx4lD5RFCUzvBliReAsUo7sYB/sgofKIczZy3s77VT?=
 =?us-ascii?Q?b/DTwuvLYCnN4AVhQ0st0E9Ta2HQe2Ki+EY6liraWKnATJvqeqsX1trSzpDE?=
 =?us-ascii?Q?j467QbaJtmmmLghKszOpJWUt6AEwEcJcIwWuUePdnsdpr1WC4zYnsVmrKHD7?=
 =?us-ascii?Q?Wro2A57OR/DOI9JveutFmCc1RhW4ORtX+o20vK5ryiJPx0Oq3GePCFH5jQ16?=
 =?us-ascii?Q?S3ztZt05aKU60NDF9lkTXCtEJZN8QsE2+U4/lbfK8P8Al/It45X9Am6eNkJ2?=
 =?us-ascii?Q?v480CXcAVLCwJrqsaZ1itv1l7DwQcL5EunXrtiQ74M5TBPdIOpFHJM1S3Lus?=
 =?us-ascii?Q?qTW/rFSlmQoyOQnZwhj58kuYvAxMT6bkElJJo/vchIiM9gl9rl2xI0YLQYz2?=
 =?us-ascii?Q?ZPQ6jzLgMtprvdMhwMHUHuF8V2X6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A2uZvs1roQN8LkGtAbm5SPNfSm3A9IQEUbkEhVDr07NC6t3Zyah0t1CB++eD?=
 =?us-ascii?Q?ymprnUvLN9RCz2cbIT0j6xEl4BY5VwgutBqoXLi74RZEI/Z3ePjsqIMGmG+a?=
 =?us-ascii?Q?AXXGxyGSK0AnBvK4B+CHrC14hIFWGnGgi2vCDUO9EX/vQ2nWKoktJE8w1rQI?=
 =?us-ascii?Q?2NWpEVG2jTBECikGpw8TB0yDLiUYQGMOdEtqm9TcFv3JWlEiiA8sjF74QV5l?=
 =?us-ascii?Q?O53x9x3xwMqkfVEyNRsjlijnflOn1WNit6rdZRgBtRTANkF5sx9/TfVow+0n?=
 =?us-ascii?Q?lXWNNxsM7FvjuAzdFb2MVuX6N8mj8H0jZ+r8pT4dXH0O5sBBULaLFMtUp1SV?=
 =?us-ascii?Q?8qqsSIJDIgn/Rb7HysFaSHLZ6TPL9QpbJKLNeKNeoFXbr6hq49A4q6QEUh++?=
 =?us-ascii?Q?ZEzcEbWE60bHr+kR6b07zfKmonFPrMzVnm2s/PZc0r3spakT6MFrXy+5Wzqc?=
 =?us-ascii?Q?miYFCR75aZNdnjJbnK5DAGOxLXN1e15736VW58unxaSvBFhCFaKgnFEiy13k?=
 =?us-ascii?Q?aVsqKktGTYp/OLNLlzFEliYXX6o73OHexgS4sLnDXkgJImYFlZeL7TyLDzTP?=
 =?us-ascii?Q?oWdc/Q9l1VdzcGEGnKOjkt/969YrbP2DrrRk2UJEEimuLLwQBRhA0LolJkIm?=
 =?us-ascii?Q?IoxIz+beiLIZ31fmkcLNg7iiudWRvKw4SPSnHE4xxpL4RNokMU9AeXxicIos?=
 =?us-ascii?Q?QnXa/HbF674kVEKxG7wamXp7yXzgBPiawZP3ORQCG20UeYfxfv1H5M+v7zWx?=
 =?us-ascii?Q?fZeKG/RPpi2CVtMoTjWmIMOcwu7wUe9gPm9Ck1oUo0vj6F1Vq4vHN9Ef8T0m?=
 =?us-ascii?Q?gEnOE36i4eg3jSsmLt4ZvOeQ99Zf7bWl4MdZA/wchwFOHSbLLJ3cEOeZs8jj?=
 =?us-ascii?Q?zlRII9P5/voCfIYsdJtKfFYUIla7GTQuMNYu3mOIC7A6Gi0ZAMUHpl8+ybZO?=
 =?us-ascii?Q?746Pb6g4Iuci21MtrocPrb34zRXCY9n0M+LMphYIuiTwP59JVKQ5/xvu508E?=
 =?us-ascii?Q?mx99bbOCwuIpP65Y6fXAhdbTLmAhhCZWx4zVkyftNGiO5moeHkhw7eagwiRa?=
 =?us-ascii?Q?a9ppkS+f1666kPItS9s+0Wh2owQyabHsmcwycl5FGAfZj+mT9Pzqi8GseX8X?=
 =?us-ascii?Q?StKf4z47HpRnHcoejFtTLs//d3zh91fxJnm7PQgKNNXRUCYoKAFJHNIMjUCW?=
 =?us-ascii?Q?q6pRH8tkwB+FiXo4Rv+1yfIVkymP0Z7DWZUUQoIfyIuIo+Vnhxl6XNlHcR/l?=
 =?us-ascii?Q?acE0k/aKrgCkiuTwfAC4Q9ZW4oInf3kDI0l4kUaKnOQ7WOL+UzNOcZetTUmG?=
 =?us-ascii?Q?+L4hwzTfW/ek8vp+CdoIGPLqmOmuoV2uJONWKM/9tjs+3fdM4BdFogw+pfiY?=
 =?us-ascii?Q?CIiG2xiJwnd7K8FCW1A3j2TTYt98FGTLganTbMtBnx2DIFq5AB9nvGL3WqOY?=
 =?us-ascii?Q?mdJ2i67oeU6+iQdmocChBDvJGebmH+HdW7zsKCY1P7nd4YIVmpIxKGl2DVx1?=
 =?us-ascii?Q?lJ4dK0DLhgLx7voaQ2WuMA+EuTwfSxQohb3CWXigCGqWQvy9dgYOSF3ADJ8O?=
 =?us-ascii?Q?Cpu6HyrxiR1oVGrkmnDir8sH098CMX9kBR8E1CU5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f513d33e-0dd4-4cb7-8390-08dd6250fb48
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:03:31.0579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdLX7RNKCC1l9g4Zd19VhVmMuThxnRBvNfuOlfA8hDeuVXWlcnBFdWKs9b8Fwx9b6Aa4Exw/m/9oCe16zQErLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4361

scx_bpf_reenqueue_local() can be invoked from ops.cpu_release() to give
tasks that are queued to the local DSQ a chance to migrate to other
CPUs, when a CPU is taken by a higher scheduling class.

However, there is no point re-enqueuing tasks that can only run on that
particular CPU, as they would simply be re-added to the same local DSQ
without any benefit.

Therefore, skip per-CPU tasks in scx_bpf_reenqueue_local().

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7b9dfee858e79..22f979f9acde2 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6972,8 +6972,12 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
 		 * CPUs disagree, they use %ENQUEUE_RESTORE which is bypassed to
 		 * the current local DSQ for running tasks and thus are not
 		 * visible to the BPF scheduler.
+		 *
+		 * Also skip re-enqueueing tasks that can only run on this
+		 * CPU, as they would just be re-added to the same local
+		 * DSQ without any benefit.
 		 */
-		if (p->migration_pending)
+		if (p->migration_pending || is_migration_disabled(p) || p->nr_cpus_allowed == 1)
 			continue;
 
 		dispatch_dequeue(rq, p);
-- 
2.48.1


