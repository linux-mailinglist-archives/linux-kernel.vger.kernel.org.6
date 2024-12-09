Return-Path: <linux-kernel+bounces-437246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944A49E90D1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A799163561
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6FD21884F;
	Mon,  9 Dec 2024 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K0rwnRgE"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FDF218846
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741216; cv=fail; b=n6yD7PbS0ZAKfA+6NhV8XdQEgL9idonhcfkRTlYcx1HWNcwss8OCtgQWnWp98ED1ik2qfL0Ni367tyKb2/onBuRZvSwvOgSAW+TGCrWxl/pL8uFbuF548TqblyLfWHoqbtzS3JynAZDl5J8raT8hgiQVugMUmuB3GUwWXQXstW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741216; c=relaxed/simple;
	bh=d5L9oIdilgWsqtdxYJjHek4j1u1/z2FXtQnxqM2vrBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ViMaVmkhUXBOmBme2Qksthxt2yzVN68cPULNtkMUApRNJZEDY+YxqvbOzDczVbh+HT2pQ6TTV1YeiuciZ+uWt0ghxN66LuFlN/niPSWIgrQE/Wp/U5M0OmW5Fl+bzXxLiMyJREbgg61yxaQWi4/Vz05Xvb1f3XR+MlcbXZcsBp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K0rwnRgE; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/ThsqGKmaqNJnEOuK2BdT0djUcCs8O7asyukKshQ3c3d/s0vSdijuJn60M2IPj1s/wnI2kIkWY16zhLq28QHuCOPWx+WPi3YB7uQn9YCAz+8Ixgz7aKz1ttQuhJ+PXvfTfhdKLAb8JVNr46vJCCkE0yYPRBlD4Wtx0e5bV/agK1xpWR5bfzuKFIqOwRk/QvCbC5eRny1yCP1y15nB80m6pMk1l5rpT+qKKRvPD0SGwbgDmdEjXdpUholpXO476Rrc3HLO4/WPgr/euR4Z8WepZMO5A8IFGNmJ7KjkmJ82BazRRlXIhZB00Zu9RzgOE7lm9RbnCogrXFDiH6EN5R0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eP/66Z8+jmKB1OHVKVYqg68Ru+uaOLXrFtc4Fb6plc=;
 b=h+oEVS/Upec2iBmkT2hp4bsj71lyb/baZW56perg5xNcvvxuOn7U42PGWpHSj+4BU/43LLlsQ+IqhZLKtIhCg9UbKb1ktPVrCy/qxWWNkGRoZaN3aqIl8FNRySDh4ZMt/0od+TjPInKkSyit2+vyKgpP4EQo0EfQpm9q08f7bcH69kZXfyo1/VSDjAJOC635vj+AAsc6Gbcm8xDic27R8l6t3kyOdniuXmopwZeQA5S11lJvT10VtMqK37q/gi1cOc2dj6lwY9d4Xk1LOje3I8wwlzoiETho4z1KlwEjIfcAlbfuumRqCJxfLllRe7rs4T7Z7E621xm+NEFSiJQM7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eP/66Z8+jmKB1OHVKVYqg68Ru+uaOLXrFtc4Fb6plc=;
 b=K0rwnRgEGXljF20W/4spbiQZQ8ktN+kMXgWtFA8fmdZuz0pejcrOR172NGJt+cNZ7ePz/yg+bt841Bth1Xzt1z7ulIFMZ2vcujiINE57h6zSkwGSnskSE0o4zlPvFr2Ku6Ngt0bkF7XweWHmsdYXNOhAA7jWwACXREfmCE0BAmxeK75RVyDwTCbPTY3qOvKAvfYquaUAlEixKZMmZiqC6DS3cQwdAnEUUMYYarcstnp0iF1Zb/vtHSBKVTf2v5w4JKc7OfHVIv0jxRrm0LuIOI9gbv7AtpI32nZ4UCXty7Dk443G1piYQSdXhBEGBjLvHVYu1ExmcA5LF8YoSTPlgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) by
 DS0PR12MB6462.namprd12.prod.outlook.com (2603:10b6:8:c6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Mon, 9 Dec 2024 10:46:51 +0000
Received: from DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793]) by DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 10:46:51 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] sched_ext: Introduce SCX_OPS_NODE_BUILTIN_IDLE
Date: Mon,  9 Dec 2024 11:40:57 +0100
Message-ID: <20241209104632.718085-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209104632.718085-1-arighi@nvidia.com>
References: <20241209104632.718085-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::14) To DM4PR12MB6424.namprd12.prod.outlook.com
 (2603:10b6:8:be::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6424:EE_|DS0PR12MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 80fbde3c-6ba9-4221-0a31-08dd183ec9ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EezKKUSPJ5U+4FENDIJvCIkvyyjahbyURI42i3OVeoiXWbV7/xIZKdgDqQuP?=
 =?us-ascii?Q?2O81hts8ciri1gL/TJ4KC/E+w72aRYCsHNfQp/HQYmTbfEzHahmTP1kFylZl?=
 =?us-ascii?Q?/dOjjYnv4SspH3pcBvxXUwtnqdJv2DA5COoR8bW/OQ1NiCqrolQ/VDTPK/5g?=
 =?us-ascii?Q?kZk3iqjIJ2BjYXIBkwG4IWforf2C0DtDy90TzozxHfdqN15DesMiDyLEPU2J?=
 =?us-ascii?Q?08e+8jz6IQiJH6/eaRWz6bbhFTlvCP4SJb7RqE4rmMVShGzqVAn8ZPrIhlR5?=
 =?us-ascii?Q?k3HJ9TD1y94YrfGQETVlrR3hrSdLUlbQgi5Suhl895i7089cabE7v9UIgQfC?=
 =?us-ascii?Q?wGMCCSZUC0Zg3v6U8SRAO7n3HrUa+AEcsI6mD3wdux2nhtqyE2jYr/763YXK?=
 =?us-ascii?Q?MPSXGvdncyvv5yqAFLZ0EYowMi6DbL5S0fDPrrwOgysUQ8m5Aum3yTZhwGuX?=
 =?us-ascii?Q?1BOHWGFe8/NXCekGpKWMwLNcVMCQb5UsNg2eK5dmtiazAt9psIEsQ7Mk/DYW?=
 =?us-ascii?Q?eDg9AhrH6WGCX87voj8w5g+A2hGEaIJ/w+jcuVwjwOkKep19HUmxnvZZ9WMF?=
 =?us-ascii?Q?jl1hmZhQXtyJGoL/aLtvGBvbA+sKS23Rr3W5RBO/SqdSoJqLqvK0jGfzF34x?=
 =?us-ascii?Q?lBJSb9fQ/kfRggIa8ogo4489KDi5abHkVfS27PY6tPKfmOjPT4xThqhN/yNF?=
 =?us-ascii?Q?497n1BBQYvzcF0JKeCEvWf0yCRv66RJiHerlerpP1UcYVh9EQREhLki7M280?=
 =?us-ascii?Q?gAqq/ZXgvd5QP3f/XNP2848REs1mGxyaaOcfU+lELkW09miMdC0ZRfMyo9VK?=
 =?us-ascii?Q?MoBdFzv7QeQH61nhEUomZfTg68kAVXoqShew+l5Gk845QEVYcDe2W+Wn3IDQ?=
 =?us-ascii?Q?YLQj1bTCU6zPcNfKc6knsl/N+NK/5tpzQAxgypeS4Kz6xnscJkJ/9O7++ymc?=
 =?us-ascii?Q?J/Q5E429M8GZfZo9aiUZcjHwfw4NmJ9UiKejywIv54HVCA3y6w5jlhV1AM9n?=
 =?us-ascii?Q?jnCU0J0+8HgMoHxY033tKyOmJ/nFkyOMaOazBuHdGu5O4bTMb2D1cjVyoiOu?=
 =?us-ascii?Q?ZhMDQMLewhYrEdh0rdvXloMOSMBTuEG40ImZZCCKAKYGNyiIPoBH/yCGMsE2?=
 =?us-ascii?Q?52P05vmUhgaG7NHfETOjKkrAoOJBU7b6vJbAXGTuuyAZ+O9p83PRLw26/2n0?=
 =?us-ascii?Q?6uJz9AH1ZLhPLNHRjR9XRqsQalBqMDTaOxPKW0ztv5I1d3AsqLvbeyohPpRg?=
 =?us-ascii?Q?GcrukzfJK6e4U2u+C0YMcY1ppdJFwVI8X6oXsPssA6AHeEQU+0OvlXfeWx6+?=
 =?us-ascii?Q?QQFlITdRFHTRMKFrjRl1vfTFha2Ir/sR+BGdV3q1v6r2og=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6424.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6iEn4bxESrNxm3vWDsKTYMY3qGjLyCUUEoNQ3og2X+u/wOrPdwMD/TN4O82P?=
 =?us-ascii?Q?n+g2HRDNtFrCaxz4Job83+islOaL5jTUmJHGo4pOOeUqjWzOJO67azCWSdGX?=
 =?us-ascii?Q?3yiVye+DEbZJi7kFVyoad355mkj34W5lhTw3tTSoBRekPVcMjZni5bO4Pjgb?=
 =?us-ascii?Q?Eup2iJbONGS7F68iw0psfCCKLHcSzTYqsfdmg1PIRbJMuwmm5izsLwT8WXAq?=
 =?us-ascii?Q?wGSrAH25nTMlxJvLIXt2bCRtF1UcU+3EggIXQ4PF6UX8ikQNC7BOGScuUs5y?=
 =?us-ascii?Q?FiDP8+nvQzEohE2QxLCASV5WYFnGeHvoULC5kWolfe5jsbMp3rvdyLbgHLa6?=
 =?us-ascii?Q?0ueraXJw3LjjkJoBKiU9LUZ9/hFQrKyRhJ1we7qNZ7KT/JT4wYSfZ3ssAPRN?=
 =?us-ascii?Q?OMbWZJM/rnmTb5+lEisvM8N4K4QaDNFku80DFF9c3EeZaYQKC/N+LXs0NJtl?=
 =?us-ascii?Q?z1Z+NpIH7p4JQlI+8B8mve4iCpWbZt6XeRGr56iyeFUxvAdbwB0GSjAjTs/e?=
 =?us-ascii?Q?GUAIIrt2ej+rlPlDpxsI9ufil7/d97mcUxrmnFAHDI/lbTDquO2TLbwM/rhZ?=
 =?us-ascii?Q?oBuJkWCb5Fvh74RJTdvvRYA8Dqh1PFXbRGtkc+B3Lf+xDB6dCqLOtCYnSQDp?=
 =?us-ascii?Q?KopIyjsn5krb9oE22zzBP/76C7xckpmUEIFKHtrEuFvvF7K/mZj8sp5X1H6T?=
 =?us-ascii?Q?6RuXIpJqoaPuBwRWccK9KJvr1TvPHkRjFuSjuT4KQSLKxDlEX90gxBJ/M1vL?=
 =?us-ascii?Q?/pFdvruueljpkFG5d0enzEwDJAPaAntPsNfbQZsyh4CJNBiwzv5HwbGy3N0q?=
 =?us-ascii?Q?ADChlTUMHYQU6mhFqth74CSUlKAfzFGTctOU8J9fGhrqYHeW4bCcE/4d/rPR?=
 =?us-ascii?Q?TMWmZ8GXkTySdJAkkR/o4yKv/PIolJeaOEqyWEiPy9B3pcnb/iw+QHxBB1sP?=
 =?us-ascii?Q?gSM8lDNCYpKuARYSdRc46/W8nqJZF60Duh8S749II2oFOvW7C4fT8RIdHjpD?=
 =?us-ascii?Q?vTHOwBT4+XCcK1dMqokgqD1Flvg89ezjCzKR5HX2h7JCTtTSm947VTMYgmZv?=
 =?us-ascii?Q?oFVNZAZJP02bzVOAkYK5ITYF+uxtnZe15FRljc/Fun/KuJgUSTLrJ/tzz+qg?=
 =?us-ascii?Q?P71Ng86VTTzdwfptBFFTbD/vusfBpa1s+VoiTWFb2eZpANbRrrIrRaGCJcqT?=
 =?us-ascii?Q?9VRzk+VLeerNtQvgVn0Du1Q5ssEGa7NNfC2OfSwIMQ/Q2LZTJjBcRXa86BxG?=
 =?us-ascii?Q?mFitnH895VM9k/eMRF2tw11votEOPaFyFku/Dkcg08kUO9XcoDVPEgSoBJWj?=
 =?us-ascii?Q?kzemMJbzbvcGtSf/4D63DfS3EQobkJVzPP/0bRsuKzYYXTEVP43m7WhumT+G?=
 =?us-ascii?Q?PMd5zX83kaAGIf6yFgUSRr9x9ZMOApnCJv11ggdUeMHDSQoAaokzbLypLgpn?=
 =?us-ascii?Q?ucRjrLXKO0MUpXn+xBbVgd96BdIZAaFyWxNzC8bGVvn6R8Zk9BkLh/qum5il?=
 =?us-ascii?Q?Sp9ByN9WH++CaIcpH+DqF4NjohnCvZqDUfAlUtPzGz2sS5u4Pz13wr4XKAyR?=
 =?us-ascii?Q?bkPTjBcqJTXhCDEX9moZEP/5GRkXK5/sZ7o7IWx2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fbde3c-6ba9-4221-0a31-08dd183ec9ff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6424.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 10:46:51.6539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zH3vtyw8QmQM8oa5VXwP5c+TMb7oZQ6VGpY7Xmr62NlkxYHKakJNEZtDEl0x2LE6ptT3yerklZsL39G0IhpzWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6462

Add a flag (SCX_OPS_NODE_BUILTIN_IDLE) to toggle between a global flat
idle cpumask and multiple per-node CPU masks.

This allows each sched_ext scheduler to choose between the new or old
model, preserving backward compatibility and preventing disruptions to
existing behavior.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 56 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ed2f0d13915c..d0d57323bcfc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -122,6 +122,12 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_SWITCH_PARTIAL	= 1LLU << 3,
 
+	/*
+	 * If set, enable per-node idle cpumasks. If clear, use a single global
+	 * flat idle cpumask.
+	 */
+	SCX_OPS_BUILTIN_IDLE_PER_NODE = 1LLU << 4,
+
 	/*
 	 * CPU cgroup support flags
 	 */
@@ -131,6 +137,7 @@ enum scx_ops_flags {
 				  SCX_OPS_ENQ_LAST |
 				  SCX_OPS_ENQ_EXITING |
 				  SCX_OPS_SWITCH_PARTIAL |
+				  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 				  SCX_OPS_HAS_CGROUP_WEIGHT,
 };
 
@@ -886,6 +893,7 @@ static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
 #ifdef CONFIG_SMP
 static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
+static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
 #endif
 
 static struct static_key_false scx_has_op[SCX_OPI_END] =
@@ -929,18 +937,32 @@ static struct delayed_work scx_watchdog_work;
 #define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
 #endif
 
-static struct {
+struct idle_cpumask {
 	cpumask_var_t cpu;
 	cpumask_var_t smt;
-} **idle_masks CL_ALIGNED_IF_ONSTACK;
+};
+
+/*
+ * cpumasks to track idle CPUs within each NUMA node.
+ *
+ * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not specified, a single flat cpumask
+ * from node 0 is used to track all idle CPUs system-wide.
+ */
+static struct idle_cpumask **idle_masks CL_ALIGNED_IF_ONSTACK;
 
 static struct cpumask *get_idle_cpumask_node(int node)
 {
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return idle_masks[0]->cpu;
+
 	return idle_masks[node]->cpu;
 }
 
 static struct cpumask *get_idle_smtmask_node(int node)
 {
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return idle_masks[0]->smt;
+
 	return idle_masks[node]->smt;
 }
 
@@ -3423,7 +3445,7 @@ static bool llc_numa_mismatch(void)
  * CPU belongs to a single LLC domain, and that each LLC domain is entirely
  * contained within a single NUMA node.
  */
-static void update_selcpu_topology(void)
+static void update_selcpu_topology(struct sched_ext_ops *ops)
 {
 	bool enable_llc = false;
 	unsigned int nr_cpus;
@@ -3442,8 +3464,16 @@ static void update_selcpu_topology(void)
 	rcu_read_lock();
 	nr_cpus = llc_weight(cpu);
 	if (nr_cpus > 0) {
-		if ((nr_cpus < num_online_cpus()) && llc_numa_mismatch())
+		if (nr_cpus < num_online_cpus())
 			enable_llc = true;
+		/*
+		 * No need to enable LLC optimization if the LLC domains are
+		 * perfectly overlapping with the NUMA domains when per-node
+		 * cpumasks are enabled.
+		 */
+		if ((ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) &&
+		    !llc_numa_mismatch())
+			enable_llc = false;
 		pr_debug("sched_ext: LLC=%*pb weight=%u\n",
 			 cpumask_pr_args(llc_span(cpu)), llc_weight(cpu));
 	}
@@ -3456,6 +3486,14 @@ static void update_selcpu_topology(void)
 		static_branch_enable_cpuslocked(&scx_selcpu_topo_llc);
 	else
 		static_branch_disable_cpuslocked(&scx_selcpu_topo_llc);
+
+	/*
+	 * Check if we need to enable per-node cpumasks.
+	 */
+	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)
+		static_branch_enable_cpuslocked(&scx_builtin_idle_per_node);
+	else
+		static_branch_disable_cpuslocked(&scx_builtin_idle_per_node);
 }
 
 /*
@@ -3683,6 +3721,12 @@ static void reset_idle_masks(void)
 {
 	int node;
 
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
+		cpumask_copy(get_idle_cpumask_node(0), cpu_online_mask);
+		cpumask_copy(get_idle_smtmask_node(0), cpu_online_mask);
+		return;
+	}
+
 	/*
 	 * Consider all online cpus idle. Should converge to the actual state
 	 * quickly.
@@ -3740,7 +3784,7 @@ static void handle_hotplug(struct rq *rq, bool online)
 	atomic_long_inc(&scx_hotplug_seq);
 
 	if (scx_enabled())
-		update_selcpu_topology();
+		update_selcpu_topology(&scx_ops);
 
 	if (online && SCX_HAS_OP(cpu_online))
 		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
@@ -5618,7 +5662,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 	check_hotplug_seq(ops);
 #ifdef CONFIG_SMP
-	update_selcpu_topology();
+	update_selcpu_topology(ops);
 #endif
 	cpus_read_unlock();
 
-- 
2.47.1


