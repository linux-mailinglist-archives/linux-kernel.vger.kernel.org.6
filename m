Return-Path: <linux-kernel+bounces-572045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D676EA6C5CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF351B62D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF78233D65;
	Fri, 21 Mar 2025 22:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aeVyJNyJ"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A94236429
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595341; cv=fail; b=D7gt9awRjvB24fVcNm3SnScEWqHF4yQe8oSllqr4Srg8EAGfkJY1gO0oB2r2zZx1WpSHUJzQ2nmImzrJ5hXImSEcYHcwl5hV6ewNbSC1tctwO6I3bgTkyNfo4DdPSeTdEX/UinnBpvJakn6uUifse+LtEzqg46aZGgF9Dn4fzU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595341; c=relaxed/simple;
	bh=jKTxoAxrXvpBn7lWujg+NdqWN89RZk8i/am7nybMWNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j7GjA/MSjvP5t1Jfq9gqe0iDtiWNdBn31Ewv6YQxpc6pcwJiIXXySa58Az5+eyeZHf2kc8ZeeZqOdrCQu4PLK6j6IwErPGfXofLF8ept08shX3S4PjTWbYI8L1QaOVA+ANCvwd4ojnkoTy779gIRCtoa+9Z4QYLqSlqb5McEpUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aeVyJNyJ; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBwZAFoDY5+HjIcxenR4z1bGAdpuOyeBvzSaCqoMGWg/3IPI8m9GB5qAQiO1Sf+YEXDcr5cd1p7XmUGE/bd63X/acD9J0vICWVOYlSgGeWlGKGkaSnHmKVi7w+aHt72Ju96t8cqIeHfL91URYZ2krUOpxXU6OJfTkPmHI2WpGmFds6EdDRZFxX3iXGhbFFA39I+7IivPWtEGNY93cKAlqcgy9lXK5VATVu+r/kxLO6P50G+ov0SYFAILsnWLq9AtTtK9VjOHWcM8IoUAe8FfAgUgmIneRfAdMfupeC3Rm5Sx0hPub4u2KtmRhOVVekHXmYu2ISsfQH4YuTKZZsYroA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tz0xGZ8Vq/x5hanX4aF/qX4QQdX3n+4+blVCZDmYCeE=;
 b=HRRIYR/9XMuSIUWuGAvRtlm7ugxuma7CvnvQiD9jH3ZWftsIXp4vHEHEkiS+HDkHezfseqV9Bxg0aH4/F1mWAURUUCGSvCA8SrpPxGTAY+o+Gi/9zhhfaSvaBOu8J5xkDfzcfxQoXTYvdR0mWsqaC1tF6n4N9LD5VhOXB8szESqxUmbdCEj2rWlYpG1OYqRwKFCfJyF1B9JxpKnhFfSsNrsLWWe4Jwq44FwawUdWHtDC6rTbmOszyEUpqToo1C2pMWZkg+yh39s52RB1PCAxMNJxXQT5nwkM4EF9aVgqzGcQRtUGX4D9SIcH4BJX8PXHTh/LAcFrlMK3nQu0xeil4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tz0xGZ8Vq/x5hanX4aF/qX4QQdX3n+4+blVCZDmYCeE=;
 b=aeVyJNyJzStxXwZ8iVdNL2JxmwEvRzUHeSKJDn9VFP1er0CwxNkSBPn7o6gZ/lxCWFqiw656YB803I0Gg756Ob5A9sv5LYi/mkD7woFR9SIC/tqR/zenYL65pa5QmGITU23Gt1uNukDLSnLtf6NzHgYuZeLlWslYFldBgTpcnl0R7A0Y22QeBlGbQk+VFzSRdQRcz+0z6uucX2ZZWSW7BYUKgMwIK0ImqGeyrrq8ODnXGIdJpQgQQ7yZtneEtZW4IHy0lkxee7Ft+VewqlxiqpLII/reaxqiQGCl76zze2LLh21j5mBv0cXBtve4Lsk9wq+Gu8ubaGS1Ap/n7r2gCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 22:15:37 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 22:15:36 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] selftests/sched_ext: Add test for scx_bpf_select_cpu_and()
Date: Fri, 21 Mar 2025 23:10:51 +0100
Message-ID: <20250321221454.298202-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321221454.298202-1-arighi@nvidia.com>
References: <20250321221454.298202-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0016.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::29) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: a0af8211-3061-4130-b6b1-08dd68c5e803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zgMcOPscX2VgaNuR/IX075V793Sstsz6Hyecb1BXEkaXDsnsFTgX3VXFspXo?=
 =?us-ascii?Q?JmsVesbyNlVhoXWl5q0mHyNuON6Q1fbMcX6bohpLqW9C657ojj6atgvnN63+?=
 =?us-ascii?Q?FusIGeQXMkhtxvw+A6du9gQiNH8/PQfbWeXy3u/rTdjO3lpg0+fWtH+U+Yn+?=
 =?us-ascii?Q?CETgfNGhbn9FXluuSqJNkoBw3Fq5Lyhp0pS+q07NhRLGooSd+WKDWdYNMG3w?=
 =?us-ascii?Q?3jT67sxO1XfqRqBFVookA1YJAhHynzwpsatcu8VIXzh0CYa4895LjQipKka4?=
 =?us-ascii?Q?tz3TZK9JVFIQGr+68frf8Viq1pQDoynQ7+xw+RNfhJhu0ofET680Bce4mdP+?=
 =?us-ascii?Q?Cjdoj55lLm6kw7gwM0SJKKrYRwRzYA9zO1pSK4qdP4apsQbHM9237BIirx82?=
 =?us-ascii?Q?NgHvq20fTpAJnUk6VaEMtQEYff9ITmZp2V0YT6aiGEGiMTM2j35y2sCY3co2?=
 =?us-ascii?Q?+48qlGsMszMMgBO8wTuAl7KDAvzddFT9uAS5eMhsl+jpYLu63nihbp8KOmC8?=
 =?us-ascii?Q?zVbtKInjfjjYHY9WNx2sI/ZsnwE08E2iVSs/ssa23WuTIDkR7nghHcXJrmlm?=
 =?us-ascii?Q?ZE+i+s1s0NLSpOgDZCJc9dC49u8ctO0mG+U67WWoALiKTO/T7ssLNQaTSYWl?=
 =?us-ascii?Q?J3t0UUsXNiGS9sAdGQM9sdhJB7XgzLn51ZLFawaB5X7JREPGLugDzndaiPrK?=
 =?us-ascii?Q?hMWuexRDsRHu9hjUr5J4ztWPJvMrYtg86d1c9ydDsvrGNUzsUwPC1qgpA8rE?=
 =?us-ascii?Q?VvZLybmeBrYy+wJajWWllnnu5/S/TUNMIOIVtfKrIViCGoBidkplpedYQPkB?=
 =?us-ascii?Q?cKSWNmMPtdwiRNtCNSC0mrDsulbq8kw/R2wu6lLlj4ceK7U8Aubrv9ejyEKf?=
 =?us-ascii?Q?mHacGfEzt6pqy14b7CRUMPCg7Ku1U35oiF36Gqsp7F/4X+m36ikLm3OiWzE+?=
 =?us-ascii?Q?AI3O/drk5p7ZaANmHTu73GKGRAQ41xVkjtjfj6FJ6cNrG5xu7wI32BlNMQ8Z?=
 =?us-ascii?Q?bM6KWJkJNlOr0O/WyLflSqI18QsI7n+2/P37wPuUWjBX2tELZWsGsDmETsAH?=
 =?us-ascii?Q?NaKw87GmF4u5hJqxREFu3X8c2z4w0u4veW3+T8RXoRgVmFPxnO+pmHhtdNm7?=
 =?us-ascii?Q?n+u2N9tI5v79U0G/uBizN0fU2Z6qxxT+P0r6LDjPVvHM+CqBsz80xqrXSK7y?=
 =?us-ascii?Q?TI0cIkTMu5nA2+WbZK0zkvj1jnGPWlzyG2nMvFwTl6c/oDuwvjWEk3Te8pEy?=
 =?us-ascii?Q?C8o6467WxrPxwd6bTPBwTg9YCGDaiODOUiElt+3uBuZOXD1jpZEoev6/TiSF?=
 =?us-ascii?Q?fVhfBczkBefk2A3yexbH8PtfXFhki8cSm+EZ4NpIQ1h4qxQB4rjIgViCUlLy?=
 =?us-ascii?Q?pUY94RIisnUjBoRU/qK6bmX8lvMvz16Qamcpw+ICFc0Qpxlcexmtmpxklwfk?=
 =?us-ascii?Q?uzc2fGDHWhc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NhrE4vXs+guxtuMb68lVwVW6CFeSO+Kcpu7AIkqyDQP34ZhPChVH4d9WT0Kr?=
 =?us-ascii?Q?lbLIdi6tUo4CPIPWAK7LXZdRW9oshmuhIO5nxzLoWLJHMiQXQrJLaBCgxuiV?=
 =?us-ascii?Q?EmqtRkssiOpCha3JgIUt1S3Y4m5eRsw/BCFLkUtHkVGZptZiJGSH0N84uSRY?=
 =?us-ascii?Q?CbpQfGHnc8fEeNwL+3aYNSx9GrPvpDpVkTuWARTlf1inLbFWU1yyVnoDeGUZ?=
 =?us-ascii?Q?kIk0h6FAP6ybIcraCSIb6SyoRSItHwgpqz7ofinLh8GpqCArmSZJ7hl9YTz9?=
 =?us-ascii?Q?NfX126NiPzrT4rZnKIv/9Pp/DlSgHxvO7Df5H+ViCksauo0c+Uzf3W95rDiV?=
 =?us-ascii?Q?iAoqihUKeRJcnvHYJX/jy/6WlNDzXZ/qWHbZUti7OogOomF8uh3UNgZ3Pi5w?=
 =?us-ascii?Q?wgJXkeyryrzi4Dy0cjuTpWO4NEstSk/7QQ8s3FSR65CV/e8BkD0IJX1lKQX0?=
 =?us-ascii?Q?WyY+s/tKPxjGrqnCxUPnjv9HXy71W65N1BxmQVBp5UJKF7pWqqnq/jPjUM4e?=
 =?us-ascii?Q?ZTinDbFotrX0r+b5MeVpYWu9XKkmWtG8ZpMFYez+G58jA/DgjPnRMdwAGm52?=
 =?us-ascii?Q?HGVauxJBfh3XBE9uVbd/KQtCWtcyU4lMICx97XsBYo8THR/LrtIWbDqLBl3u?=
 =?us-ascii?Q?icj1VYnSSceGzcT+p/+HTHOHW9L4oQhc/nMuo1NeVhHwPRp6MKqXyHfda8xS?=
 =?us-ascii?Q?aOgUmVfvap22KOc6FK5bBdLpF3JjP6MIp7MoU4ad6zNoRbOuzU/f+aPFB/fS?=
 =?us-ascii?Q?SNZ9bRZqWOCOXxxa1Erlg1pG+Go5RnL2pFRUraD/LCFQYK1Hsw+yt3lIgvms?=
 =?us-ascii?Q?CLnWMdOdRHXZho+OSYhsLr/A0UL4jy4/0mStq7UhQkEbmmtmLHoQl27anjah?=
 =?us-ascii?Q?sYel6vI7h5tFJ+JnoX5ipFEVmlj57NfYFHjE/bOb4lfwlUUCLZoXQ4CF1Gqt?=
 =?us-ascii?Q?VuzjOL8p70qkpa5kq+mQdS7AwMo2/AiQP/PyGO5Cs+eWFM/tta3RgtDpybRF?=
 =?us-ascii?Q?CETFqSAEUS1PgNTOJDMK8TWHSe19g099dcu0tc8TejF9D0jQxguTJGdfAlnC?=
 =?us-ascii?Q?L/f4WJIbgPuXN00FTux+XNBl6bftU5Fu98pUtmwXQqKvvHTMO8GCLDu7ejgW?=
 =?us-ascii?Q?+Kfo3DzwuO5cHF2AH8UdVJHEIhFuk7bcTu6WzPiaHzYSgv1ZZKu6zCdVNx0X?=
 =?us-ascii?Q?idth9w24ouvg0tHsxJ1pAFaAyK2t+szvkdfHFtEojj+RIKWNTKVWNRWd03lc?=
 =?us-ascii?Q?T+6i68u4K6MddmNGr/S5VM7K+gswh7WNYC21MsrTtw0Zdp6zXjmYFI2473MG?=
 =?us-ascii?Q?FFRz84377zMpeaN+Vlx5/PAl46NXj9jHLmLSK45x1oEz9dhXfikfRNfdB7iO?=
 =?us-ascii?Q?VwVG+zJ2IChxlwI7xlEcx3W401sswjZA/d4Q25w3IF0lJeSDnuXH1wK7ffDe?=
 =?us-ascii?Q?oNJm3onr9UC3JWEfJVjsbpGIuzwVKLOiyZSJWrmxBIbKAmVwFtOVwjspHzJ5?=
 =?us-ascii?Q?LmvzYnmIab2yjMOCqGfVazMZz2KbqvoKLzjeeMowvKTBsOFLNBtNbhBIZeCO?=
 =?us-ascii?Q?9b6Ic7tc7fwaMwpZSDApre6skNBOGa9b/gys75W3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0af8211-3061-4130-b6b1-08dd68c5e803
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 22:15:36.7969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3FgGllAwuciBxFJtyLxZff8SrSdNQ8yv68ndJhK0yTMQZ7bczhL9leEiT912KAvcHhLXf01KhsVVz6VEHS25g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143

Add a selftest to validate the behavior of the built-in idle CPU
selection policy applied to a subset of allowed CPUs, using
scx_bpf_select_cpu_and().

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/allowed_cpus.bpf.c    | 121 ++++++++++++++++++
 .../selftests/sched_ext/allowed_cpus.c        |  57 +++++++++
 3 files changed, 179 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index f4531327b8e76..e9d5bc575f806 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -173,6 +173,7 @@ auto-test-targets :=			\
 	maybe_null			\
 	minimal				\
 	numa				\
+	allowed_cpus			\
 	prog_run			\
 	reload_loop			\
 	select_cpu_dfl			\
diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
new file mode 100644
index 0000000000000..39d57f7f74099
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that validates the behavior of scx_bpf_select_cpu_and() by
+ * selecting idle CPUs strictly within a subset of allowed CPUs.
+ *
+ * Copyright (c) 2025 Andrea Righi <arighi@nvidia.com>
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+private(PREF_CPUS) struct bpf_cpumask __kptr * allowed_cpumask;
+
+static void
+validate_idle_cpu(const struct task_struct *p, const struct cpumask *allowed, s32 cpu)
+{
+	if (scx_bpf_test_and_clear_cpu_idle(cpu))
+		scx_bpf_error("CPU %d should be marked as busy", cpu);
+
+	if (bpf_cpumask_subset(allowed, p->cpus_ptr) &&
+	    !bpf_cpumask_test_cpu(cpu, allowed))
+		scx_bpf_error("CPU %d not in the allowed domain for %d (%s)",
+			      cpu, p->pid, p->comm);
+}
+
+s32 BPF_STRUCT_OPS(allowed_cpus_select_cpu,
+		   struct task_struct *p, s32 prev_cpu, u64 wake_flags)
+{
+	const struct cpumask *allowed;
+	s32 cpu;
+
+	allowed = cast_mask(allowed_cpumask);
+	if (!allowed) {
+		scx_bpf_error("allowed domain not initialized");
+		return -EINVAL;
+	}
+
+	/*
+	 * Select an idle CPU strictly within the allowed domain.
+	 */
+	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, allowed, 0);
+	if (cpu >= 0) {
+		validate_idle_cpu(p, allowed, cpu);
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+
+		return cpu;
+	}
+
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(allowed_cpus_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	const struct cpumask *allowed;
+	s32 prev_cpu = scx_bpf_task_cpu(p), cpu;
+
+	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+
+	allowed = cast_mask(allowed_cpumask);
+	if (!allowed) {
+		scx_bpf_error("allowed domain not initialized");
+		return;
+	}
+
+	/*
+	 * Use scx_bpf_select_cpu_and() to proactively kick an idle CPU
+	 * within @allowed_cpumask, usable by @p.
+	 */
+	cpu = scx_bpf_select_cpu_and(p, prev_cpu, 0, allowed, 0);
+	if (cpu >= 0) {
+		validate_idle_cpu(p, allowed, cpu);
+		scx_bpf_kick_cpu(cpu, SCX_KICK_IDLE);
+	}
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(allowed_cpus_init)
+{
+	struct bpf_cpumask *mask;
+
+	mask = bpf_cpumask_create();
+	if (!mask)
+		return -ENOMEM;
+
+	mask = bpf_kptr_xchg(&allowed_cpumask, mask);
+	if (mask)
+		bpf_cpumask_release(mask);
+
+	bpf_rcu_read_lock();
+
+	/*
+	 * Assign the first online CPU to the allowed domain.
+	 */
+	mask = allowed_cpumask;
+	if (mask) {
+		const struct cpumask *online = scx_bpf_get_online_cpumask();
+
+		bpf_cpumask_set_cpu(bpf_cpumask_first(online), mask);
+		scx_bpf_put_cpumask(online);
+	}
+
+	bpf_rcu_read_unlock();
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(allowed_cpus_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops allowed_cpus_ops = {
+	.select_cpu		= (void *)allowed_cpus_select_cpu,
+	.enqueue		= (void *)allowed_cpus_enqueue,
+	.init			= (void *)allowed_cpus_init,
+	.exit			= (void *)allowed_cpus_exit,
+	.name			= "allowed_cpus",
+};
diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.c b/tools/testing/selftests/sched_ext/allowed_cpus.c
new file mode 100644
index 0000000000000..a001a3a0e9f1f
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/allowed_cpus.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Andrea Righi <arighi@nvidia.com>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "allowed_cpus.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct allowed_cpus *skel;
+
+	skel = allowed_cpus__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(allowed_cpus__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct allowed_cpus *skel = ctx;
+	struct bpf_link *link;
+
+	link = bpf_map__attach_struct_ops(skel->maps.allowed_cpus_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	/* Just sleeping is fine, plenty of scheduling events happening */
+	sleep(1);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct allowed_cpus *skel = ctx;
+
+	allowed_cpus__destroy(skel);
+}
+
+struct scx_test allowed_cpus = {
+	.name = "allowed_cpus",
+	.description = "Verify scx_bpf_select_cpu_and()",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&allowed_cpus)
-- 
2.48.1


