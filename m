Return-Path: <linux-kernel+bounces-402288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C009C25E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A73E1C22953
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7DB1AA1F4;
	Fri,  8 Nov 2024 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lW5Vc0+6"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4C21990B3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095516; cv=fail; b=Jqj4XhsRo/XchWChEoHoQ65fLz0QlpiGHKKi0VGrkzXvwmrlyCxy9orf4WIZ0QDr9DlKzHsTVbLm7HvDbM+nmzHBVEgrX97Wiv3OmJUvUgIoqpp14Hx74w6uGC2YuHugE3p/vT9lWp5f0aIzmVYgtXbzCyPRAmqSwUnn5egfmMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095516; c=relaxed/simple;
	bh=BJWvbiyVKVRVfFrA+hZpX1y8ytLn1WjrX1n3fLThZXk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Tk3OUdB/Jndj/WZwUrJ0D558dCXhRDDqn3L+mIFDk72JmfMWdwMmEGyjuDHlRlVbSwMXp0MpARCtWfk8PP8/ftErDcECrcgKwQBjsClrbFUw0qZ13+hjWP6yWEYPM54nx9tMnvUmDXoyizam1bOIOWYLAinmVkifnYGQa92R9no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lW5Vc0+6; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCVRvPcDPZxBIyHYpOhGmzZDGS7ajprR/5ngMhFT5FaCQXKkr46b7kEBOJkDJFINm+JQG5uR+brHrhHuN3eIN/VZ9uXt4+vOc2rnqeDRm2CwkrKzLDJJUH9qwUdGU0JwCSzZdYI52RT9ELyOXVh/kB3donifpO6cS4lsOG74PfsyJ7wiqlX4dQ69segrCUzekhH8I3t/TObzz+gC31MBugbGFlbNtuSu8Mg8NB42l2M5Fh+VRy9ZsqAwOP/kRpC92S9dX2GhClLbzY5oMGdUyX4a8ytMp+gVgBKZU/BTfMTBQQaZ3D1D2Q7BQg774LQ9PcMrzLZScramP3eoJ6MBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGJhrwFaYWE4oCt/PRUv7fWMTKecAx95bTCAcK99knE=;
 b=sEc67qqE+pGijRemve2wpEv8IZqh4r4UuJxon15SCDhKctRXAJbVcWVr7VO4N8cFqMBJALopOvoHC1Vp2ofN6YgvaueEz5OsIf1ppv6C38anTjaLvTuSvqaIMmpp8eKXlTcZsdZ7ha0ljPlRI7ZUZqg6pNtxsR7HA9ZaJmh5GkPBkgvGJHSI75eLTJCkS5CZ8mgfCKdIhvN4+ZSOqHSNRaLNRpBvGQysl4trF58MQeeyTzSNkARIhrxOpCTYiAPBIYd1KVAqGtqkn7syGhBPoQnfxwcixXufxO2TzrTIHdLTewZH1mEro4LnxYE6MUQUSPwo5OvbNLLoyj5YkLkNVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGJhrwFaYWE4oCt/PRUv7fWMTKecAx95bTCAcK99knE=;
 b=lW5Vc0+69rbcMVAV/3kXekiihyjEapNkr/scxVWU8wQiBN0SXA5ESNSNc1zoRVmvv8OYLGKCrnzaLq8Kav2a4j8eO5EpXufAJnZfOJPgrFORdf31UXkfhHgU8pVCfrS8djffWtmDtEjZuDz7QJADMvTZfShkox5c7eXL2tVtRYWwO1Bf0EJqU0anaS8+JIdpGxy7AVoU8wfx8w0NXqGwPtnLo0kqbRlGm1Vg2Ijo6VuSpuH2KgDUXLG0llMhuwKvPBv7XcWJ5kYufx7+zWmBY8Q6pz0uXEP+/HVxizzzyOs5t+3jJjuxEkOfGMtyED34b2ETWwkPr+juKCagqhfUHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by IA0PR12MB8373.namprd12.prod.outlook.com (2603:10b6:208:40d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 19:51:48 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 19:51:47 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Fix incorrect use of bitwise AND
Date: Fri,  8 Nov 2024 20:51:44 +0100
Message-ID: <20241108195144.55747-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::14) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|IA0PR12MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b840c1-9922-448d-d1d5-08dd002ec7e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6b6jUjYohwAleJ3D17Xv+pqs3doVeKUTOewJJiiNjGpZB+X/NoaF6Mc98e39?=
 =?us-ascii?Q?VNrDla9UJC9VPdXRHpiP8jpMA0UNoGCXgt/VKD0dIdZmqWvDlcLOgqA3y3K+?=
 =?us-ascii?Q?Mx16+9eU5cqb9EkQfBs0U/BpmPFUs5AfTJauVGHrm/4/MIqOeadBi4BQdvTx?=
 =?us-ascii?Q?DyGAckVU3mJxBQc8HC0lWEv6c3V5qH6W2CcdGHFCAwqY1duBIGUWOMdejQEF?=
 =?us-ascii?Q?Y+nn+v+dAvUwtHeZFRGJ9NsHaqhxS7cIhvasH3MaCkI5mN4LvbGxMNMMr7oO?=
 =?us-ascii?Q?znBDoV8ss5Kx8LsxGbgQuW95cr/g4AXMUdMQg9tKhDbGTctl7X89MzSNe56e?=
 =?us-ascii?Q?SxUb1yT/MfatXYoRXZ9pxMU6j40wV5pTojCOi6TTt1AXlqXb/WqcuH0cqq0x?=
 =?us-ascii?Q?iwW7+fZnBGSkXfJOISsgVIM7a0RLzu9FEZv4xpdZhjOVRReVaQOkAQp88dAG?=
 =?us-ascii?Q?67RqVUlmqUCILfYpwPBqEjQlqCgn7MY33IYegBuZJ+V12/6UoyITDD2yZUBN?=
 =?us-ascii?Q?cDH7At5K0AYkbD7zgPH9v6L7f7H4ddMfSzSOBiba5yVdjf+RmA1usiATXohx?=
 =?us-ascii?Q?f2yAPIr5r3xk6d67zJ2T9V3v/N+y00EjyCPvlBqT0AU29gHtLJQoNf8pHc0A?=
 =?us-ascii?Q?Y3xfLuLlhD+rOdWkUY+k7iX1GPfFnWULuZmmZf4gLsjRerNn2Ue56H7xg/nS?=
 =?us-ascii?Q?KR+ipyMTfLrdS7TXbmziDcUStuITgYl5pVGewJ65Krnf4A09YBsUOPq/x4NI?=
 =?us-ascii?Q?wPEg4R8AZGApPJ+f4epcfzOa9XhP5kKtJ3ZaHCvpoFa5qQCRYVNnx7eMEgCp?=
 =?us-ascii?Q?Y1HRvdn3cu7c/YSvqnbL67v9/skswJKtYoQYVsIOkMcgRCImDhCo8ZGk9MGy?=
 =?us-ascii?Q?axSiTvKE4t1zc0s8MZHA0EdDkvyl4bguQHosSlr/OM4O0cQYyuhebSHlBfMX?=
 =?us-ascii?Q?didp7TH8nXxlmhxQMhWDUgq/2b1sSi2cdkcmgnqIrVi30uc7cDRDd0mwQStC?=
 =?us-ascii?Q?crYoCWib721PuJSXOH96cU6NINgMprQK8aIgwLCqiUdsg7BkYvRztF8BXVWk?=
 =?us-ascii?Q?+b4ZOsCcORPHD3IOiruFwwDUYZwRvDHkC0b/woUKDUfXzcGX5qwodND/mOnb?=
 =?us-ascii?Q?LWtTIaee/HR/I6MbDzb8EgF9hp/mqEAMDl13BY+nWo+3/eGskBm+zV8aOP5r?=
 =?us-ascii?Q?QXBT7osNbv2oFYxAyRb4+feXTpXpsI5Rml4hxgg2J5gIKfCPPsW0ZFn0j2Vp?=
 =?us-ascii?Q?M8VNqxWZJu9lemHDK/SJDArkwiP5ZwLCtfzQNu8dRzlNBl3F1R5wWgXOnhmK?=
 =?us-ascii?Q?4P0MH/fgq9Wpf+SnKNBvdxul?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g6T43WhqEQ03utLWQe9JQdkbVhhoViSOmZbJTkjkeeT38JgCpPPlYEmBhfwS?=
 =?us-ascii?Q?5zTfIpC4YO4v8okvY0o2pMgX0OX38WPsv3LRT8+02PECotxHsHy7Y6wGQ5h2?=
 =?us-ascii?Q?xFCqR41Jsqhvhdjb6qeE8S5PR+E87TSdIQMEanUckP+7T2ijm4o4dYOVQ59U?=
 =?us-ascii?Q?lC+4g6OFLj0B2xsQLbIHydvUzq1c6PJQyMC0EZWMXxCpxV3yMgPfw2cN2jQE?=
 =?us-ascii?Q?Ep3QrFDAE6QGUPKubmZf4DkjeqAEKcSPnmJsDlz+XzcbadxPwne7KIbFmjaA?=
 =?us-ascii?Q?vB5ATntHr8rvXx4e2MGio0ZUDw0pQ7QuhZDjPW9r8aGa4JEergH+SyDassa4?=
 =?us-ascii?Q?Jipr3eQJC4o08ff01B6sP0siysont7aXKhSOhIb6qpkak4GiTuvf1XHmeEmH?=
 =?us-ascii?Q?JDlBczETfI2jFl6U0kZCRKUQhiKpcoRZmSSDT5YoUCn6ex1bRq4VjniSPKK4?=
 =?us-ascii?Q?YNw0wBunSOVPyR3y8agpB2zHDKwOSGFxClIXEAe598od4wPv8eRF93d8c1RC?=
 =?us-ascii?Q?/RZ8BeNjriQ0MzXYOC0U9DYfxX+1VyChax58aH5wt5zozAPa7VPGuS2/DvJT?=
 =?us-ascii?Q?7Md4v1r/WuCAUvz3NvQ1CDXehveCuBKCpYrkml+WOw8OEcCQNaFgHhgLVQ5/?=
 =?us-ascii?Q?Mkt6tIJTVjo2JEkWRzT4V8M3nJHxyEG3NDFw68Z5LDNnOV1x2+4T4iH6oMT5?=
 =?us-ascii?Q?a/4qTG2Y1UTtI+oTGR9+gLRSu6+eFK+LopDnuag/LEginpc3V3oyeAfJtb+O?=
 =?us-ascii?Q?+TUNoWABSNnyXm9z6ea18PuPLgSchjZIU4WSvG/BpjWY3ulsPm8UlURxGsoZ?=
 =?us-ascii?Q?yFUTIMZKWi6zjSgAYl3SFZXF1n47O+LQTyAebrsqk+ymM9zCdbQjxkrAtCW5?=
 =?us-ascii?Q?dwudXqrtHZuZbD2Ck38wV+cLDZd5oW12N/aYJ30dQqhHXFxJF+h0RsuwrRo4?=
 =?us-ascii?Q?IH7V1SRuLDHNHWfi+sWhz5Isuz8MXjAwXRztMpFAj5LbTq+0oGnWxbbT+X7L?=
 =?us-ascii?Q?+qWjSfnWNa8AycHT6yHcTgIs/p7YwWHz/eSCUH2x2cB5rVCtLBoN2eQQDK1U?=
 =?us-ascii?Q?F8xMNm3441RcH677B7QBdQUDnIlhXyABcwbf5BrhtTADYnXhhInBNZqzESmn?=
 =?us-ascii?Q?lX7PXxD++msL40OO3Wjkb+QXYDiZyaCiygReiNlvU1q3sJ0cUkYfUQm6rGVk?=
 =?us-ascii?Q?JRpWMLHgRQY0Ysn52qPf7JcHlBweY4aJ2in5pC/73Ti1gEED0rKPT3Q183//?=
 =?us-ascii?Q?TVZqXSgmFilKBXpX6sascndDN3+kPW6bPWXFR2CG6PBrr9Tutrfh/PimnF0K?=
 =?us-ascii?Q?nWFvqpbTrtfhsKjDQHwH2lmfYvvXjllSXuKa6f62g+iQdYc/EwJSAjkvdQMx?=
 =?us-ascii?Q?N8SK2Maa6YUwlC0NFO7eoFdOYE3t6NagZXz+SpUxgk85ViYrF8XAM8E3ITZp?=
 =?us-ascii?Q?ltzSYYWIvJLft6NgukThdk3TEHOd0H88FUbYJT78b2tNrXPL0mefX7/Ep01R?=
 =?us-ascii?Q?9FodPxN4BKPoso4zUZ1J4K3RvC5hjq+0+QImpVFFl3rrowLCrt2A0cbivd06?=
 =?us-ascii?Q?JMsjeacC33T5ylz3994n6BIy7fPkP5QHgTUq2Lmz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b840c1-9922-448d-d1d5-08dd002ec7e1
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 19:51:47.9204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPyP1A0krB9IdhI6BZ3n/keKMK3s2jjYq1ayUDWHBEwpO2DUXnx0q2diqHQn0wF9MC1t5Igl2LWxjChZjt+MUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8373

There is no reason to use a bitwise AND when checking the conditions to
enable NUMA optimization for the built-in CPU idle selection policy, so
use a logical AND instead.

Fixes: f6ce6b949304 ("sched_ext: Do not enable LLC/NUMA optimizations when domains overlap")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/lkml/20241108181753.GA2681424@thelio-3990X/
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f154aaeb69e4..012a7fc77263 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3221,7 +3221,7 @@ static void update_selcpu_topology(void)
 	 * for an idle CPU in the same domain twice is redundant.
 	 */
 	cpus = cpumask_of_node(cpu_to_node(cpu));
-	if ((cpumask_weight(cpus) < num_online_cpus()) & llc_numa_mismatch())
+	if ((cpumask_weight(cpus) < num_online_cpus()) && llc_numa_mismatch())
 		enable_numa = true;
 	rcu_read_unlock();
 
-- 
2.47.0


