Return-Path: <linux-kernel+bounces-542513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FDCA4CA7E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7879D166F7C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80ED219A90;
	Mon,  3 Mar 2025 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H/OvmD5+"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F70E215079
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024328; cv=fail; b=W4eCH/TwEFChkZm7kKl6fJsXgHWNU0rQqoKs2Zw7v88cqkLXr1sSUMhq3SLsHdQ9yepa1A4hDqXFpjl7BaM6s1JDy9a0vKGlWoabUFaa3iFJJsiI/0xT6W6qmg14MKCcfAKGbTZr+KoB8s2sJrDWNo3KtnsnL0J++TbPi5R54J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024328; c=relaxed/simple;
	bh=/N3b7jkpHC3bWG1TjC2MtiWa5YE5MDjj03ouiidjtRI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mflYePUO6ZH4GsJBs7Xyr0LYse9aHf2Fc7rKXwYQaoqrNvI1WW1poFEisashBTfnlDmCLK/2ZL7uP/E+8jWu2qd2NZ4AmAVcTsV4ZczjL318FE10qzpE6snh5YIMTYU7shvAug/AguPoOEF5kLunOQalIIP7F8VUpfE3PgI7iQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H/OvmD5+; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0J1swYIr/r+axj/N5wq7WDDYnSIfMPI3EeOqsoyGzHcdYAQ+yQArjFKP7eaDHAaLvSk29lZzuC6nkEstNhsu1l6yoO7yVFSFTw09OXm/snKJNhBhP7FfTZZvU9/54nY/t/QdB7S6oIh6ywj/fnke/2+P5mX0twYsdcyH4vOMzwNXj35IvGfUTLbDOxIlJLy9jLFnSLMMuTzbqbAcz46rQM3aTaA7UM5GKSx/N7cjyvPpYMoDMifM90ML7LclNlDKp/7EgKk7znwIOoxFUbA1DA93v/Cghe0aX0m4jpOcJxets0JOMvg4prU47pHHIAprExedOnihP927x6Nlhw03A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1eHUU/HDiOP+w5W9SvmmFfWd3incbqsCL7AxtdXFMw=;
 b=U60zv59OZItG+l/BFEXu953wn95dV8fU/thWzyoKVbUkv8k5X0vGb4Hxdf3Y+SclgqEgQyUI7N5IqX5BlVA6DQDFPmKExRZNNZF1AcxLbzukx8+u3rk2vzdZYXYrirBuzXw6W4kuWOW1e+TtaIRlHvvTKG+qZawCfD2I16CUrlhZkOc+TVR/eNaZ51X48OZYduFbWQAuQg5aAhdBkOHlu17dbK5fypNOyyJC0KRVQKgeDPvWS2ZUXcYRivosX1yPyKXHRFEanamA3PMRIvMOqFdbVgn68muxRnRI9lygnVctJGfraugkt4v38r5cpv4aP+6JDb5qlZd/SUHi2WPrCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1eHUU/HDiOP+w5W9SvmmFfWd3incbqsCL7AxtdXFMw=;
 b=H/OvmD5+PJx9odLzRI6+mqXVJ4q2DDkWvtFrKIn+/9j7xg+1YhnE0FgiekdaE+kcP5E4dkHe5gEXHd3gY78kJi4mBAQjkkrEa57Bz3sEgKuK1ymlD6N9mIzCWQBzG7e37PwqcvMicx7QPk7O2vSGP91iphEGpvbP/o2/rM+HvxPJ6iETf6aidkMSiMzGbi8LBmKFLA67b+fb90Ye9ROWdgDOZ2FzrCyxqz97vRTVNzeFk81uR/T9uzRwwjCMmc23PFQfgFDvBBEQZN4lu7xHvi2bFZFCeD0Kwr08QQoIc5+vUrVQ+eM/o2hEHRVK+bkDBSRrSGgnJ37fkwNu/IOHbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 3 Mar
 2025 17:52:03 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 17:52:03 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched_ext: Validate prev_cpu in scx_bpf_select_cpu_dfl()
Date: Mon,  3 Mar 2025 18:51:59 +0100
Message-ID: <20250303175159.167804-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0488.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::7) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d5d26ca-9986-470f-b883-08dd5a7c1b2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vbeUQ/SK+yQ3c0ervamZsXmTe4/bAN5tl3uMDCYMnJFpe0ZfrR5pZKGmHNU1?=
 =?us-ascii?Q?m5mVHYT3vFMsLi/NsteyfjpiLuOc2uifwUAK3b2XFtINW/pO88SO3BPZCK03?=
 =?us-ascii?Q?YdwLZ1ctcY3NwSrnPUaszJ4HHchkjYkgjX7CktqZwBeG0ODsrOYGAYlKSmfi?=
 =?us-ascii?Q?q6PNFXC44t1TI7sh8Lq11m3T2s6KGuLXzwaFKrIx2Jjt5O+Ycn+4BpTnMp6e?=
 =?us-ascii?Q?MeBgHXEzsScl+0l501tUvuOeEgGZ+qpwPb+KzpfKcVfnajTNq+7C66PdraIc?=
 =?us-ascii?Q?84BeawE7MDxg7uhHJVApo5ggD8CcfQ/9ZgRF8mLs2Cj3uooNkgOyECvoH8DK?=
 =?us-ascii?Q?rEn3a5gJPUohTaLtD1fHF7yoW58K+Zso8QqWxrP9nNQpDQB7MnGpUyEzRccz?=
 =?us-ascii?Q?kvDheTcduUqpx6cs6pbZi6KmLSj09fHVej8HjQYK4rTcWt5Z2fzK+Sbj4qFO?=
 =?us-ascii?Q?angVSH73D/9Nf5wNYTL8/b/7jY5Fqt+Bf1/lEnIMmQVwXjuB1yQYMMGq7/QB?=
 =?us-ascii?Q?oKrzCt4tkf+vx/li8fttcfr3oya6FMUN7G5CL+fPgubYOj05bOkR+KEGNWXX?=
 =?us-ascii?Q?dS0BVBGc+lz2Ht8JQVx+9vmQoN2ruJj2YeAW7y7gptMmBmgbAbOjaaPzHHUs?=
 =?us-ascii?Q?EZhey8rcW3Rk7xr1GWdzm9w77jdLIZcfSpp3/H0X5D3T77QDPlqkuSoG6gNo?=
 =?us-ascii?Q?p65HE7mvJ5CLBidbTunduLxiIYGkNphleQ3bazhhr43HN/gEUlnqU9DL4Z+a?=
 =?us-ascii?Q?PPki7FbLrbeWOQ8Q7vInkRJWe8IvvoMi1MFAJ6ax7ERAATUT6TBY/nhax8DT?=
 =?us-ascii?Q?23Db7Sc2ZjKZbzJAt3HKz1t2pKC4Wk4/f8d/9VlyYJLFEL3hdhcq8Xy7nJWg?=
 =?us-ascii?Q?Is0/FddOP4SnuV8pwHGaTOJMu9x4wPaiBpOv76BuzhHSygZL5HYfS0psk64s?=
 =?us-ascii?Q?Fx89jsPm90h1i8G1M1ysoCGENGbUEU/rhQ/etCrHttLG4Cy7TMo0b+jcils8?=
 =?us-ascii?Q?z7wm4/rXtTAGY9vkO3YqOdY0cVYSSkkb2u6DOaJIeEpLWhLtKHLNl9Tg23F6?=
 =?us-ascii?Q?WN9sDvk841u3/BcEzTyeJKa4ZJzZR0/+QEJYnbwFFfHMAA0/6rwgjRhUGBoL?=
 =?us-ascii?Q?3Ov/MoHDVhD0K6ewHJT00NCheOhK6jdI0MZQB6Sf2jNg62cQRYJo+WliwiRA?=
 =?us-ascii?Q?oDM3vYoag32OMs4vCg1yzNlqMdv/edhiGuGnDEHR8OYaNQvEshGGxKSNSm5o?=
 =?us-ascii?Q?MM8DsxTRc0mw3dz4LNEiu4NnZOOC32ae5uRGXyTuvhSRk97CCjRD/061MEUp?=
 =?us-ascii?Q?M6ygp8by6HaplDw0QrqLF07svPQT89ulHmJKeZXio+EuTFEQcy3mU2qRboii?=
 =?us-ascii?Q?bZrzLNACkCJYJivC+5T9CdFdXeID?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3gpuOu69M6LpcahRCBuRAs22NpJVrDm1L0ZkmDV0xUlkRM2Rp9EftFZt8qi5?=
 =?us-ascii?Q?weuX/8JxWFMcd5fbc4TeIa1rLZyzeOzvr5saQWKMiYIKx9eCXU+080jzzPst?=
 =?us-ascii?Q?5c4ISBykK2jk3oRmSHrHvf5YXTazepHQ70G3NQs+pe1NRX9q8h2yZm5M9Wp7?=
 =?us-ascii?Q?hNXRRm6/sZ5pY4EUMpXS3uVmYwC3lwp4DdQ182runaM4Ei8ZMaf/e0Eg7Ixh?=
 =?us-ascii?Q?RDVfl9qDk1oRsPPh6tRU9ML/+Dbszh4ryozdLA9WkW6945bJXN0kSMFtR3zr?=
 =?us-ascii?Q?q1uyCiQdAG4OqRti3PHLMPLGd266Dl5iOmHromco98WImM5oXZ+Syh9V9Viy?=
 =?us-ascii?Q?7cS9MeUl3SJlb4oEaanfs4WXuGrr/yBm5cr1fhPiyVrkxFKqX22ZsyP7Oy5e?=
 =?us-ascii?Q?9bl303vDZkxVgTfQ5BWS6HeUb+kRN3fHIMwcc9Eu3CwzeHHjPP8B0uYjDBNq?=
 =?us-ascii?Q?nd8dH5zIjPYmT7iuk1DKODzkkZET/80BncXmGuhNYPrqWKVlWOFgJtM2Cjzl?=
 =?us-ascii?Q?Mhthp2tHv8pANVPBhQNoGNPK4MvK8ECbsYcYiFL0AY4PdcoGdAMryztyfsOo?=
 =?us-ascii?Q?Rc0y/+CGRUu8jLXmF4bSC7EmOa5acIIxvFmZS11LGGepYnWPDBgbFQW8Z5JB?=
 =?us-ascii?Q?vIYkRJ+eLQNxLEG+zMNEPrFx9KP6DJ6oaW0+alilz26H83IR4aPTyP8+sKog?=
 =?us-ascii?Q?hjxHvJHQqqfrQYKjNkVVxSgTzMck+IHc/l++AehSPKA5gyjF4/R45mxjU46m?=
 =?us-ascii?Q?mre7BU0g8wToP2q/3izK0dhMHj8sKhH16K7gwQAza52dsN7+VGIT4XUbuPAt?=
 =?us-ascii?Q?PfR/yqpGoA7uISDrCSd3C56+bAdlcbxc0xmucatCQf9HcyVFxscnG9RWkrNo?=
 =?us-ascii?Q?BsMubld02oQeuLNgGhNMoxvBvqbXnP3CzAQe3+m6Bv+7YBzCrkd8AWLKqnJk?=
 =?us-ascii?Q?7asLMy6MQ3GkuuwWcRNBOvG3wJZJae7FfWohfPyYGTbtqGd1+NrGlpthVIGi?=
 =?us-ascii?Q?WiK/iR3sox8/ls9x+lzzYC6EJJ9jb8kRNYTei7e7owD6tumGje8DyF5kCChK?=
 =?us-ascii?Q?5Olb1JY2ltLEf2UzkxWUuNjblAk6vZ5tfDG/hbnxQElUTsBGp31KhUfruFqz?=
 =?us-ascii?Q?AP42Yt+Gzi+iekuyDzgnrzVI4pykeozt2Y0KXHQOlJLRoHZL/nk/RMq6jtPS?=
 =?us-ascii?Q?waO47wyTbgZ99TyZttB+4yNa16Pe4gJJ+9vGBhYzSMO0RSSp5UgMNRAHQNtW?=
 =?us-ascii?Q?A6K6VjgXwF9lKzU7pgvZqZFt16+VH0OECq1SYE9AXNiLwA7lYvPBXO7jdeyc?=
 =?us-ascii?Q?EQ/lI/qavp/skGUulrl+dznftD2JXyDs8uPTxpkM9JTOr7k43a7Xr0R2wfm9?=
 =?us-ascii?Q?picICwtyGyNgfWJro/MDbSMZc4bGsek2pzP+Htn8XyJ9o8tbd5WhLPhcueTw?=
 =?us-ascii?Q?Kuoi63FjqkQs03ahriMvbI3nGbUmc7M0Q8SPWSS/TodiE4Wlxx/ATBZtZlYE?=
 =?us-ascii?Q?qdMiCy7cy4Rm5EbhWA0blU13EzlVG733Zc5LTeVcWuHm9FBxKVdfv+XI1F4g?=
 =?us-ascii?Q?3j3TB1+4ee3gMyC/Sug+LBpnKIcP0VQeGySoGNB4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5d26ca-9986-470f-b883-08dd5a7c1b2a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:52:03.6560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3GU5ekT+QQFnypjqYKh3zWIBXY4enNk6MCEcShD8TtHEAvRN0+0l5c1GoZQSexzxvC2wlEPUylZemvVhKxO1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285

If a BPF scheduler provides an invalid CPU (outside the nr_cpu_ids
range) as prev_cpu to scx_bpf_select_cpu_dfl() it can cause a kernel
crash.

To prevent this, validate prev_cpu in scx_bpf_select_cpu_dfl() and
trigger an scx error if an invalid CPU is specified.

Fixes: f0e1a0643a59b ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 3 +++
 1 file changed, 3 insertions(+)

ChangeLog v1 -> v2:
 - return prev_cpu instead of trying to find a valid cpu (since the
   scheduler is exiting anyway)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0f1da199cfc7c..7b9dfee858e79 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6422,6 +6422,9 @@ static bool check_builtin_idle_enabled(void)
 __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 				       u64 wake_flags, bool *is_idle)
 {
+	if (!ops_cpu_valid(prev_cpu, NULL))
+		goto prev_cpu;
+
 	if (!check_builtin_idle_enabled())
 		goto prev_cpu;
 
-- 
2.48.1


