Return-Path: <linux-kernel+bounces-434007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C23B9E6012
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFAA81655E5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898701CEE8D;
	Thu,  5 Dec 2024 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C5jQaro4"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801191CD214
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733434031; cv=fail; b=ECuLe37xsw3EOZiiU8o9EhJYrenvMx/J8b8vJ+eeIWKjXldYaVd0yTmZKJWS9eXmECti8q9pZJdprtw6ouMbApAMAuxVWxswZCwn3yK4h2j0e4+ZpqvVQFSKUC3VwxCt781jwyrRZRDP5LjzUjw0vRyhVsSQxS43YiW9vHy5c1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733434031; c=relaxed/simple;
	bh=xePJSIWFM/tf1hvcDc9V5xCrXjqUEzdFdntRkZqel4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fqLe8sYB++625zztp1z5KYMsGPNhLaaRDtcIo29dDbzBSeDNl/lBAG+Ju0WY3J9Wy/oLrtarS24th0ZXUTquXQFNwKP9+xWdWqexcTG31Btk2Cw3+TDF4Unlb0TCF+bjbSHHahvvnwNp3LKcQXEzVPfCyftwVtzmHPHpsoGPXSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C5jQaro4; arc=fail smtp.client-ip=40.107.100.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHk3H8OnUNtXMzR00zl142ENanXKCBkULH4E+LvKJFci38uRHkl/wjp/LzfxgImHe/MLSCfzZJhvdhrIVbdhc29RpgWKDXPcJdl6ylxiZhcFFR7kAKmY9Tm77FFfuWBwOHKcXOmEPaqo4Fmes/j/wCJNrvDm9uyB6TGhbDbEp4Ro6mq1CebWWk0Xnbb4w3DouURL4CbxfAxKTkp1l7UJyuWymkk0cflrE8MhRBDLoM4+RbEAvu9JWpJn9OKvjVwKupSr6cpc88a/GjBt7KKce4Id4Evt+kz5gtt4/1k3cw+Dwi1uFK0MuDU9IUYTpBR8YQOmCjTmmk3Yp2leER7m3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWcMa/+jBFSgsgKtW4zl3A3e9XDlyswBN0yMrWvEmmQ=;
 b=CDrGP+7TqKq8e8TlL9m+jzhxm4kFuwbwfDznyNAj9F6rQ2KZfwKKqHvZZWbaMEuR7dIcujkW/9aolqNMcpM1DdxEdSvcWmV8kvGD5cmyJ31ZuQN4x13lm1/kclGMwgtAN8VSnozcRln737ry5AI+Lp1Audn/TPu0lH0atZ+2F1y65VPeOOcI6f8cG8mXyoAIsUV8Igjr6c5O3xHnYlPbliLFQiSepUZdT2sy8cC6lswulXcQxbL0Q+wxO2fAc3o6R7U8rKjULrEyTndjG3VqOXO1D52Ys5KUawJ982eXcHU/JGVmsc1HHNia9ZYE4ySTnHGaK+yYvv2ksjsLwy6vUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWcMa/+jBFSgsgKtW4zl3A3e9XDlyswBN0yMrWvEmmQ=;
 b=C5jQaro4CZ7dszIcUkJwPcViJcSOp7gyAQos+j2xhRcfGVuLutVK7MSZMaz+1XPHSt41/ziICW2cvOahXQVy03+Kp0bjMSeyZKVRZvfH28e3nV/zecMWztbXjGGiXeAkN0dCdG/t8WSnmZernOzZHbqpODhN6Xsu2KnY1KNXfmAINhnzeRIGN4nxE04lJtGG8DxnM18caopr0tNI3j/boxzYz4QEDY8lGUvS7Ewkkb9k44yX3QClN6OnhPVa+XDOrLpWvHoyiYXw2+C+Ja19UJJ1gOWmn+p+wS9Tc7EX0xRQ8vrINmzajLOpfVIFXFXE5ntX+A6p+TiZC3aV/9Tlgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB7106.namprd12.prod.outlook.com (2603:10b6:806:2a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 21:27:05 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 21:27:05 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] sched_ext: Introduce NUMA aware idle cpu kfunc helpers
Date: Thu,  5 Dec 2024 22:00:26 +0100
Message-ID: <20241205212627.193016-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205212627.193016-1-arighi@nvidia.com>
References: <20241205212627.193016-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::8) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d65f3b-08fe-433d-fbce-08dd15739105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wFeb5Zfm9E/ybfxI0OtNYcXnS7GDCYI7W5MTod5J/6/7Tf47feBxQeYHQ9RH?=
 =?us-ascii?Q?o2Nyg/MHSwVessCT+dQQUJFTCgWMR4okG70xbqfqsfLjKiv4qatIkAjFNEut?=
 =?us-ascii?Q?3JSNnrQ6WN93c+VMox3bqqKTzwpTg1A7Mfif1qLrAcNEUo97izu5MK2d10lv?=
 =?us-ascii?Q?DYZ93+dy//D61bTnavyE6fTrOSg9CNMaqAVzLrw4unw0r4flaKYLaea50DYU?=
 =?us-ascii?Q?DIIDzBeAX0JDM6BOOgBqo43eoL6MeN7blqucHVQUCNmmCsGkegozVc+mkmWV?=
 =?us-ascii?Q?ago7/4K50aL5b+3do7n9gCeiuDR9+RZ69SW8GrqKGYZR9JXcjnMTcniRCUtU?=
 =?us-ascii?Q?KUll9wury6NVqyLIs/dkmWKmBU+/ZYMKG+itZR3IOVVn6Uvj997aRht9G7qf?=
 =?us-ascii?Q?UjQuQWh1CQcENfAeSVsqfTDdCGzDjEjLgxANqFtOVwooF/GxoIGfboN0SMDh?=
 =?us-ascii?Q?H0+U9o36WjmclUvQTEqfvSSqYQO66NbWPjyIWLtEWzKyGLGwJ7J4o2Ew4gnl?=
 =?us-ascii?Q?sa2L1UpEDR14oqzs3PjhA73vIUHb2povB8KgOPhiruS3DMbivwHnuj9UjXYm?=
 =?us-ascii?Q?HiO8EQtaOe27/dMhtDu3zWpk6qKmGg8fYhPMPIqUPK/o1JR0nV41l9+eoGz4?=
 =?us-ascii?Q?Wb7rKsbPjGTlWCvHo2wWc9isaGqpGTNZk5sxt3UCQST3p5YoED1djoHeT+QA?=
 =?us-ascii?Q?x6Ti03jzls+8XHpzLBdiPhsIHc7m2ciZpFFMCRN/yFi0odqVpC+ObJIUjpBI?=
 =?us-ascii?Q?3kpWNz1pb/AJ74tctoTUpuTNukSwPbSdzhs34FEQcddaNFz9vO9IOFjoJamI?=
 =?us-ascii?Q?XMVDrb0u2xYvBQW/3m2C0WOn10eo9m7mxo9UONimpRk/5o4KADYPP0SYDvKu?=
 =?us-ascii?Q?WtNfApzs5y1FOuUnwn7igPOFH9iRk4bIwIM9y9KT72cqecMF6eZigQINAWAj?=
 =?us-ascii?Q?qzOZvjHnMA0eAfgjJw49kQbf4TLoSlvlNC0VmTIWGIah1Rz4o+IjXvawXbUC?=
 =?us-ascii?Q?d8Nqh40aYhr16UBv2g5h/n9A/Y5t20by7Kdb66r5M32XRG4TguBX97hRxJvD?=
 =?us-ascii?Q?o39511gdy76oxJ2QC/pL4fWqkVHquJ2pvaSwNZyftWslHLA8QxcxxCiRzbTi?=
 =?us-ascii?Q?PYrrTeu+RanUsBd4BKwvywsdvcLFGpKMLZucaZL7sPIFpLVxVZBqZwlRtzD8?=
 =?us-ascii?Q?m/01NOk4rKI9hEKHXky7zW6fCFw8+9JLCgcMd6NQbgTMKaBSqeiBT6v552EL?=
 =?us-ascii?Q?qp1tjgrRjVQ8JqE6W4iONV3sh6g6EjfUPrwargg3qbs3ZkT5JjQTsXtGQK3w?=
 =?us-ascii?Q?2IO2hGQJtHAqy14/vi/bwCcCjUQYNeM3M3zXGfLMt41n9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cpbKZx7p7glYtyq41Rx/ToLEKbvhgyQf2cdsNqSom3L1PB0COO2WHpOolYyb?=
 =?us-ascii?Q?tvlVFRAHN2zNYBIJSdNdg+QPEtuw6Xwmad3tVHJ+CeZ1g3PwaF8Z1FRuilJC?=
 =?us-ascii?Q?/TYUR88h2pohIX+UM4hrxhzWjE0CjlBjl7KmtNqBwhLWOg96V/aZpAKTu3gA?=
 =?us-ascii?Q?b+XqH3L5LFLV733w+C7dkYKfUlge/E7my3ol0KPhr/nvIIXf05SoRnSYXa/Z?=
 =?us-ascii?Q?jEfXIfMNACEx1OWYn3vfP+W5UB4+U0XQ5Ik4r7qo1E3ySyJNKYzEph2YTClA?=
 =?us-ascii?Q?aQ6VOY6s/9334iDPXXoazKyqL/S+AXO/SMr/piyemtoXFUtlovZYAOOe81Oe?=
 =?us-ascii?Q?mrKPlpl4qEvi0Emd+xELlcgm3ynGBy99R5L+He3JIHTYKV3n0AnG9DbreKBj?=
 =?us-ascii?Q?STGPOe6g7tgXGTkPgbOj6N+p1XNpGSL4Aj1NWW+78mWq4S9ydCIhEOgVXtpe?=
 =?us-ascii?Q?3KKbWQ/ul2TJ/QdBm2kn2sV7UO+okg7TrPUuZJtQdZBWX8C2rULvJ424+C2p?=
 =?us-ascii?Q?B8gaWU6j3tBuS7B8AbKMzurvra0ujij0WY+hS7OgWOfEOw85ZmG35z6TwQXg?=
 =?us-ascii?Q?WcTKoXDEQqH+rV/nPItbhDCmx44eLDFy3GfmuQIbxdtif1TNsBdi6y4F7xz0?=
 =?us-ascii?Q?5KlSMgosaU9iUYzeiWAxEVhUb3J4m38QUIfRAzmawaqQG5tb1HbIKrzm5+XI?=
 =?us-ascii?Q?vz0LPXlnLziN/5WRjsa8YuTszzX+uPGO9a35AWRAqN44IXnCxhqzdehbH5Vt?=
 =?us-ascii?Q?MUFMPXW+6DOp9kfuFo82pydXDEprqbSZSlhSUniJLofmU1/Wj2ZMGNjdYsFC?=
 =?us-ascii?Q?85Oey9gvf6ouLvU7oetGPKcs9xvp+xre212u7vCv9lQOPkYHZIl4K1gVN8Lf?=
 =?us-ascii?Q?q3FAE8oHK6xQBqZeu3iEYDw8Ta2xNeLDfg7hT8o9mfbfL3W0kj0uXzK4+Rgw?=
 =?us-ascii?Q?9TvuG9+hsyM0T04cbA1HuU0ugF/N7AokofM4RoLYl2dThAJhUwSc7CrqBI7t?=
 =?us-ascii?Q?biXOT5YF95SqBlbMWD5/ry+d326xpleQyCDBWS+FDp2yukO1ZdYl5Tk9Mg3c?=
 =?us-ascii?Q?hPAEthOQMHlJS45UGWEgcvg10BQcx1Y4V/Vksp72KkIjmOiaduUbt/3w1NyY?=
 =?us-ascii?Q?mZH2MA9Vj1bbVQtt8qrkrX4pRQ2KPCxGqEFPjjlV43/r30yobxc8y2MdoUDG?=
 =?us-ascii?Q?nLpQN7BjB1MEu28oFhv7N+X1vTeDdFtmKeBj4jGOlyiqv4zNwhEmjGJSKZh9?=
 =?us-ascii?Q?70UYa/ZHMbVCOIU1/iyKvDAS+d4DFJHx5Kvl2pZTbUU+tb72kBZaTJjDvSfJ?=
 =?us-ascii?Q?NvnnHl5PqrVZG2yLaAvNxmNEQzLR2SeoHLF1pk/tRYUtxIAgODvux5/8TfEu?=
 =?us-ascii?Q?3AX8dX/21O3r77ugcbGmbQugfFUjSmoTV6HxnfndbE9Xhm1DoYHVfg+uFJOl?=
 =?us-ascii?Q?JsXQH0huOyOpfQJluEMeTu3GccjKzs+fec7Bel03NOoKf2rAdXWmnokmXksu?=
 =?us-ascii?Q?cGosP9mpGNY/qC9iVfGYGEAyZT60utrA30g1f8d/ZJPkZWozDGIDOMp9Ddzd?=
 =?us-ascii?Q?9QcMJY/TNY28vHiH5GTUwENYiWUCuRlyB2Os2Ni5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d65f3b-08fe-433d-fbce-08dd15739105
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 21:27:05.7080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkTyjY+427AjjLvvYKmr9S9iNh8gL+Tn/IBFo1BRVFHkQIRpM3fm1o5uVn7fW8natbvfIZOWz4kV3EqiGA3zLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7106

Add the following kfunc's to provide scx schedulers direct access to
per-node idle cpumasks information:

 const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
 const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
 s32 scx_bpf_pick_idle_cpu_node(int node,
 				const cpumask_t *cpus_allowed, u64 flags)

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c                       | 85 +++++++++++++++++++++++-
 tools/sched_ext/include/scx/common.bpf.h |  3 +
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d0d57323bcfc..b3d20e396b43 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -433,6 +433,7 @@ struct sched_ext_ops {
 	 * - scx_bpf_select_cpu_dfl()
 	 * - scx_bpf_test_and_clear_cpu_idle()
 	 * - scx_bpf_pick_idle_cpu()
+	 * - scx_bpf_pick_idle_cpu_node()
 	 *
 	 * The user also must implement ops.select_cpu() as the default
 	 * implementation relies on scx_bpf_select_cpu_dfl().
@@ -955,6 +956,8 @@ static struct cpumask *get_idle_cpumask_node(int node)
 	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
 		return idle_masks[0]->cpu;
 
+	if (node < 0 || node >= num_possible_nodes())
+		return NULL;
 	return idle_masks[node]->cpu;
 }
 
@@ -963,6 +966,8 @@ static struct cpumask *get_idle_smtmask_node(int node)
 	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
 		return idle_masks[0]->smt;
 
+	if (node < 0 || node >= num_possible_nodes())
+		return NULL;
 	return idle_masks[node]->smt;
 }
 
@@ -7499,11 +7504,32 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
 	 */
 }
 
+/**
+ * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the idle-tracking
+ * per-CPU cpumask of a target NUMA node.
+ *
+ * Returns an empty cpumask if idle tracking is not enabled, if @node is not
+ * valid, or running on a UP kernel.
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return cpu_none_mask;
+	}
+	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("per-node idle tracking is disabled");
+		return cpu_none_mask;
+	}
+
+	return get_idle_cpumask_node(node) ? : cpu_none_mask;
+}
 /**
  * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
  * per-CPU cpumask of the current NUMA node.
  *
- * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
+ * Returns an emtpy cpumask if idle tracking is not enabled, or running on a UP
+ * kernel.
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 {
@@ -7515,12 +7541,35 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 	return get_curr_idle_cpumask();
 }
 
+/**
+ * scx_bpf_get_idle_smtmask_node - Get a referenced kptr to the idle-tracking,
+ * per-physical-core cpumask of a target NUMA node. Can be used to determine
+ * if an entire physical core is free.
+ *
+ * Returns an empty cpumask if idle tracking is not enabled, if @node is not
+ * valid, or running on a UP kernel.
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return cpu_none_mask;
+	}
+	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("per-node idle tracking is disabled");
+		return cpu_none_mask;
+	}
+
+	return get_idle_smtmask_node(node) ? : cpu_none_mask;
+}
+
 /**
  * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
  * per-physical-core cpumask of the current NUMA node. Can be used to determine
  * if an entire physical core is free.
  *
- * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
+ * Returns an empty cumask if idle tracking is not enabled, or running on a UP
+ * kernel.
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
 {
@@ -7569,6 +7618,35 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
 		return false;
 }
 
+/**
+ * scx_bpf_pick_idle_cpu_node - Pick and claim an idle cpu from a NUMA node
+ * @node: target NUMA node
+ * @cpus_allowed: Allowed cpumask
+ * @flags: %SCX_PICK_IDLE_CPU_* flags
+ *
+ * Pick and claim an idle cpu in @cpus_allowed from the NUMA node @node.
+ * Returns the picked idle cpu number on success. -%EBUSY if no matching cpu
+ * was found.
+ *
+ * Unavailable if ops.update_idle() is implemented and
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is not set or if %SCX_OPS_KEEP_BUILTIN_IDLE is
+ * not set.
+ */
+__bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(int node, const struct cpumask *cpus_allowed,
+				      u64 flags)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return -EBUSY;
+	}
+	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("per-node idle tracking is disabled");
+		return -EBUSY;
+	}
+
+	return scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
+}
+
 /**
  * scx_bpf_pick_idle_cpu - Pick and claim an idle cpu
  * @cpus_allowed: Allowed cpumask
@@ -7709,10 +7787,13 @@ BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
 BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 625f5b046776..41b12f9c6b36 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -63,10 +63,13 @@ const struct cpumask *scx_bpf_get_possible_cpumask(void) __ksym __weak;
 const struct cpumask *scx_bpf_get_online_cpumask(void) __ksym __weak;
 void scx_bpf_put_cpumask(const struct cpumask *cpumask) __ksym __weak;
 const struct cpumask *scx_bpf_get_idle_cpumask(void) __ksym;
+const struct cpumask *scx_bpf_get_idle_cpumask_node(int node) __ksym;
 const struct cpumask *scx_bpf_get_idle_smtmask(void) __ksym;
+const struct cpumask *scx_bpf_get_idle_smtmask_node(int node) __ksym;
 void scx_bpf_put_idle_cpumask(const struct cpumask *cpumask) __ksym;
 bool scx_bpf_test_and_clear_cpu_idle(s32 cpu) __ksym;
 s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
+s32 scx_bpf_pick_idle_cpu_node(int node, const cpumask_t *cpus_allowed, u64 flags) __ksym;
 s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
-- 
2.47.1


