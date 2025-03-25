Return-Path: <linux-kernel+bounces-575486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DE5A70327
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5FA17247E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B662580D3;
	Tue, 25 Mar 2025 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jiUKavpx"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177AC1EE7AD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911241; cv=fail; b=eKwQtpXpKYBe5ZNbdmuN1Di6UaXkpuvUXLo3ryhW6mQWdCpsVv/bBFvBkni9fCxAdglkufdramxhnkAVV0Cdt/44bELACD2V/eKlX9K14RmlFiat2Zb20upFyyIf2zB6g/E+Eqqv7xLv6V80MfidTxm9FHY3R53gDggoBqHaWIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911241; c=relaxed/simple;
	bh=ycuBIxuu4rrTiAfNXD4iMswENsOgWRumwaANJbG8B3k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ltX4Lnmbrt6siyQPF3cB4jL2uwIcFEw42+e7oiiR8XVI/4qDAIdL4tpmdIR8bo0YjPSj8EEKg4SSW6sIUzmemCcg2TIKlRqVt0aITftOtbumV4D++SAFoHSgZD7xu4+0f2ExO/0qCVlGzrVUjFtS5LVIiGsuv6kffyxlUl/ZkNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jiUKavpx; arc=fail smtp.client-ip=40.107.102.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3naTZYNXsJqZDGelYyh74RkF7Hxr7AIIVEpyYoEwOUdgnDQ7Mh/qpOx+wL5c/U9DWrtXQZ10oVDUeOF2SYlyovNwrlhrL9ubonpdqYkuyMnF8m+x8lOCTA0AGRksaWjwWw2afq21gvoqUvWjJquQ7rHE5//aUzAVNQ/DApGjhSfvQQcWBANjTJuFChl95Y1YCUAHk+qlj1ouNMaISnp6Pyj5q0zLiJn9UC/KbnYELj+YUfdScnsuE8IU0UcCQglDPDCNj0DmzztMPrAAV9CPPE6uScuh+qvJMZL9+dVLcu8nF9WitfW2F0N5mk0+oRFuyQG7ANqpseH5KzBAWm0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB2AD+cBTdlrp18vWQ5Gu+IthkM3gW1zeLrpf5yIPgs=;
 b=H6bZjC3jlcr2D3bNuIMyERznQ7bzO0RUjkDxmgGRzYm43ZuKJ7/rqfc35eo7Vfu9TrFP9p2NuhqMyskA984d5AULF1whVFBWaebvYhGgZGiDfgl1twJgeNKxl2gxpbpwaPgZUdyfRqFU+M4OpsNVmIJV4Vva88f3UBk1CfGy9mdlf5P6ASFdDtL4p2vCkBpU+F1WjObznGk5dQJdmkPTgdy3FzSAu2LkMDZmJAcSHThjM70ccCrKcSSVuQm8SpE5ko16aODqVHUt+4cOKmeUmBAZxAb3ZWsgR4xJ9vgVsMMQLXyU2LaTrlDUpE/rOmS/dPL9gaRShsUpcaoy+9PoXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cB2AD+cBTdlrp18vWQ5Gu+IthkM3gW1zeLrpf5yIPgs=;
 b=jiUKavpxzmDIh9JEaQWQEemjealKaZ2kKbnrIvVddgdtNWiyWjLNacIkSoDi2EU2oebH99e3waAPR1TKRZFU4JVwtXFlIjGy5UM1CZD4caEcyC3MhoxrzVONJ35lPEluu/Ctgy4n/DaR2N4LdLDz7nNFlVYRB/lLa5aq42bGwKLtBqWu3QOFieRFh4fzBoR6Ryp5wKkTlxwYOi9TqUyz1j32wCMdLNvfHoaSbVLpkHh9FYcl9SsBkQsiJd/ZUdva7IIG8Dt6IapFJoItMFTBgnGKW00EmmBEaguk9fLMQs+SXUs7YDBoQ5ibNCk998PNCqjqfs1PjCGnXU2SS1yYlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 14:00:36 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 14:00:35 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Fix missing rq lock in scx_bpf_cpuperf_set()
Date: Tue, 25 Mar 2025 15:00:21 +0100
Message-ID: <20250325140021.73570-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0038.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::7) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da8b713-8627-4d10-c8f8-08dd6ba56a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eSqOBfMHypuR6lwz0oknbrOwX60YdZvnIfhOInRJaNHFEf77rFdxMS06SkJ2?=
 =?us-ascii?Q?URHUUpbgjsk0tw9lj/dEsqeezFnVvceAakdpnHzCk6J7MTPYc/nqlId1kDrg?=
 =?us-ascii?Q?ez6z0JHs5c6BwyTrxyFE2nZF6IOPCN+suh9heRT8AX0gOuoFTQErnHjfu/Ny?=
 =?us-ascii?Q?H0ZMvfsQ1hyh2KrNYquVL7C+YYSi2lFx74Q14b5Jor26a4tdqUjB+eaDR/nk?=
 =?us-ascii?Q?dKlYv/rJZQwj9qAh9b/dsL6wVA/Yxg6EXOXlinxIf1Ms1CWwOPiah/Wb6Uf5?=
 =?us-ascii?Q?LUFhhmCoDgqVDUAVdWIof0WUR7i1Uhvrmq3LlKw+ShZdKOGA69w6EU5CyFn3?=
 =?us-ascii?Q?rLCeJL+71j3uOx8Mrlw7AWdUaNO9HQaLr92oYef+N7AsuUFmjQ8yjAs/vrAp?=
 =?us-ascii?Q?SU69VfRIssGe5pBVIfY/uqC9HXM64BQKhaBEHgK6sHFSUdIPH96mBuMOiRl0?=
 =?us-ascii?Q?yCiWPbsb6LrPK1IAR4wjZMafeyEf/mpOnrtGXpNLbJEVKY5GUydPgHk7nADS?=
 =?us-ascii?Q?+I0X9ec6EnzMLdne6DwJO50TYWPIS0HysUHs57mlh5RmKXX3ukIEotweIaiy?=
 =?us-ascii?Q?pWz78GNrMtVuJXfEdbdPJWDUTsuzJRyL7d0hepdrcpNQ1r6buW/TrDo6VDcO?=
 =?us-ascii?Q?Yi0PZpMBdLP2druIPJsFjFC6ryMInefDn+xNj+ZIyaywZQsQfhQ8KTyFk2nA?=
 =?us-ascii?Q?+F3e9YoY1wdks93nIpilj+FNcMf8ShXHpSOO+UayjBC+hRc1vseUa2YXEJJ1?=
 =?us-ascii?Q?N8hMpUcTfeRKveGki5qyTToX4XEHlpo/IIqCaL0UQeLnSPJoIqKGISd0t3Zq?=
 =?us-ascii?Q?8+XkdGTc6MOVO9hNhj5SvOWSYpgE6T27ECDFpvFfBIm8kP+rE52IKMdcz00w?=
 =?us-ascii?Q?Gq9kp49M7AbzwGPDwvU6+ZZRzjVs0qPxDk/EntmbaxatdQ+2+oA0DzLvn5td?=
 =?us-ascii?Q?fc2I9QCNmZ2KKUZZDZU+DOtMdzebRL0uTsj6M12jmyMHoWubWAjnDpLuIAMS?=
 =?us-ascii?Q?4YU29jvCTgtF7uO/RyP4dkeNKfSoyohnYn8nPqp5G7LU0N6TPkO/efisea7i?=
 =?us-ascii?Q?fqlUmtQWYMLaZ335rLVpBK5AU2NQIZugbpL5FsAeIoQDKJB1LsMulkXAp6S7?=
 =?us-ascii?Q?QCf6t6ormSjM+5UDnwImmVOvXzPTJif1y4aTzd7dPGK7IPQYJ9B5FqgTiL3b?=
 =?us-ascii?Q?AB8JHobXTpd3RqKNafoshS2VZmacj1BqItkmuEKUGKwrSar8xJttYATUBjiv?=
 =?us-ascii?Q?+Hp81E7JfEJ89+vNptLz+sfH+cH9MhDtslULC1v85tOKNo5lE+PUmke2u09I?=
 =?us-ascii?Q?0uwnWb62rcpxAlOKbgTR2RC15ZAhBnpG7KXw/FIHHBSK0PpwOu7PbmZYCRbS?=
 =?us-ascii?Q?hbsAptGuVDtmgM14wA9j2jmTIY/1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LdbEmN5tzWZu7j5b8dsuDdunyJ16UDxaF9Sbf4B4lWn0ll0AfG29/A9cV5NR?=
 =?us-ascii?Q?RKRGlBx0qZlRNNzvzmtmdm7nFWBspMBCep9v1Y0A0eFi2L4fb1MLPLvY3Nsp?=
 =?us-ascii?Q?EP6L5t6FDdNbqec9n8nz3g1uNbt0IQrvQySdh1BmMvgow0bMzj5l+zoAYJER?=
 =?us-ascii?Q?mbnMAovZ0ZIGNrAa6bU5gN1hrqo3kFHudmLg6Re9AIQEEcp4bB3rsk2XftQt?=
 =?us-ascii?Q?bKp9itNI3FdJCPjC9fY+ez5vyjv1R3P91C0BVJspEH2IUa2v5VsQecm0/Y7k?=
 =?us-ascii?Q?Z6TQL6AjMk6q+5M1KUlnqPXqfi6Bfxxx5YmW6iSFzzh6dtwzDbXCIavq5PQG?=
 =?us-ascii?Q?dpLIFq1s2kl1zivOdlTQh78njT2M7Dh7uex5KGniZ0eeNwzubHPgfhlufv8Q?=
 =?us-ascii?Q?AaqPIVXrB4SsCx5dK0J6euhK0c6H0vUOkno64PWUKIZt1DnMfacN/y7qFM6Q?=
 =?us-ascii?Q?sPTnnr3a5pDIfI4P83PuNaBmtVSzTaLw6zb3dnB2sQMKkne42CFjBHfYlEql?=
 =?us-ascii?Q?1agtf+ZtYZQN65fJtTX8wvZOgXFyN7C6MDGQXOW8kv8fZGKKW2YmdjV0DIq7?=
 =?us-ascii?Q?AWuFIyzqiwIO+WWUJDOMxhNiwpidnPLGyBcwsq6VMGjKml9/D81XqOlop0Y7?=
 =?us-ascii?Q?JRIR+ffa34bh9lr7QbzJVlZJl/ZZ+7AKL/vliVuMUByltL0r7NRU9pDAWAou?=
 =?us-ascii?Q?P9rapSYFbVSvL00oPjlaZuRI0e3OPpMFZhiEezbbhg5I5D1ICKXzlYUlYkSA?=
 =?us-ascii?Q?EntreSAr9HOD9+xxdUJ0VyaFbj+vh9V5G4i/xr1oEIbhRCm0oY/0eR/IBSca?=
 =?us-ascii?Q?i1XPDD9nyVZSc3mw+4jNMyNm33R26MdGsUYjRsPCp+1C3uN8+SX1pQ6fUkip?=
 =?us-ascii?Q?659sEvlppQIqgvrJ7tHgwYQRVu1G8y7FfwGvCRStDz+JIql6lx1vX+POfyDO?=
 =?us-ascii?Q?Hb0+Ca78pL8zyipyeQpA7vrezf2VxyKC5Mc4FIfWiD0lQUl+oP/UzFK0L0zA?=
 =?us-ascii?Q?jqiBuklhiA0M0rDXgJyd2by2+Tsgvnvk5BpptIsH1UoON9U4ex6rTx+RILSp?=
 =?us-ascii?Q?41hhruxL33/JEpYVjwHXhWldIkrPUB96T9dnop3G6fw+24QOPKSWo+OMEsXm?=
 =?us-ascii?Q?BX5cx/+nseL3NuE58F3YYqE7rPr/reW0y9rOeQP0iKQru1WxZL/tMXikyaw8?=
 =?us-ascii?Q?fIiym7Bj+w0kjPhidklWvf/PiveurlpApmVg5XpChHRgVP4wBymdb8kUoSv1?=
 =?us-ascii?Q?06tqv1p65fXqNACw7wr2MUe45tBl88uDAqcLsP+27Mkmoio7FYaT6AjWksB7?=
 =?us-ascii?Q?qeAXOFPEgFJm3DMPtPr5tzrtQ2vKFXnfm78IyuSKhPPfR3rrHOQb2Yh6S5gk?=
 =?us-ascii?Q?BfQxiPBxxO3jad8zkJUZH2vPnLjlvbGLSMD8SwviZ6S3/+vcTR7m4Xjrcr99?=
 =?us-ascii?Q?YY15EobGZqjoMFxBroDNyWZnWWjBQg3FitnBSbxtO9065D/9+jYa5S+Bzvhq?=
 =?us-ascii?Q?DML1H1lJMC7xkej22jwbDrqS3uD/7kEKqi0LxHqBPwuqTrqFL1OaWIkLDmpG?=
 =?us-ascii?Q?B4mBXQxB/PrXYqTGXnKO9w2hgfItkFDePJXyF1yY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da8b713-8627-4d10-c8f8-08dd6ba56a71
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:00:35.7540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URvB5/04mj8uo5aSY2S+rj+B3CtGohtTvhq9SRqGXrwqVdLFNj5g1rVJf4C7oGE1S73d8XJz33bluBTkbVmj2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098

scx_bpf_cpuperf_set() can be used to set a performance target level on
any CPU. However, it doesn't correctly acquire the corresponding rq
lock, which may lead to unsafe behavior and trigger the following
warning, due to the lockdep_assert_rq_held() check:

[   51.713737] WARNING: CPU: 3 PID: 3899 at kernel/sched/sched.h:1512 scx_bpf_cpuperf_set+0x1a0/0x1e0
...
[   51.713836] Call trace:
[   51.713837]  scx_bpf_cpuperf_set+0x1a0/0x1e0 (P)
[   51.713839]  bpf_prog_62d35beb9301601f_bpfland_init+0x168/0x440
[   51.713841]  bpf__sched_ext_ops_init+0x54/0x8c
[   51.713843]  scx_ops_enable.constprop.0+0x2c0/0x10f0
[   51.713845]  bpf_scx_reg+0x18/0x30
[   51.713847]  bpf_struct_ops_link_create+0x154/0x1b0
[   51.713849]  __sys_bpf+0x1934/0x22a0

Fix by properly acquiring the rq lock.

Fixes: d86adb4fc0655 ("sched_ext: Add cpuperf support")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3d20228052217..53b97b32dfa43 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7114,12 +7114,22 @@ __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf)
 
 	if (ops_cpu_valid(cpu, NULL)) {
 		struct rq *rq = cpu_rq(cpu);
+		struct rq_flags rf;
+		bool rq_unlocked;
+
+		preempt_disable();
+		rq_unlocked = (rq != this_rq()) || scx_kf_allowed_if_unlocked();
+		if (rq_unlocked) {
+			rq_lock_irqsave(rq, &rf);
+			update_rq_clock(rq);
+		}
 
 		rq->scx.cpuperf_target = perf;
+		cpufreq_update_util(rq, 0);
 
-		rcu_read_lock_sched_notrace();
-		cpufreq_update_util(cpu_rq(cpu), 0);
-		rcu_read_unlock_sched_notrace();
+		if (rq_unlocked)
+			rq_unlock_irqrestore(rq, &rf);
+		preempt_enable();
 	}
 }
 
-- 
2.49.0


