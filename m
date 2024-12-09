Return-Path: <linux-kernel+bounces-438528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9769EA259
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC75282106
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182E119F10A;
	Mon,  9 Dec 2024 23:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FP34uZ+D"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0719E82A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785377; cv=fail; b=FxX9VxIxBcCW33+T6R+5dMlar4WJm/Bnv18T91ZvDER+UYVSKScwGfIFIZyYhh9D6BDOPXB/TBxL8QN5QDBC780ErqjctWGvR1hClBy5pddHJFBU2m1EY+xdPbvP4i0bohvNSNSwI4Ugme978L5a8WYKAcWrW/mKY7Itoqst55c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785377; c=relaxed/simple;
	bh=j9v3ooZaAmvnqvO6Sfe5zgqwfNQ3c83cZI6KzbWKLNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pKCEZyZM1bIZNP9CH46HgNL7553MigSdqLy3in0PlVi+qUGk8QnC+c/uTiMIKIp/Brlk4sbZkTVI/b2VcnxoCREVL6Gg2ZUzl21K0A5e6vKUTeHJFxxz7ANPodnPQ6a8zYGgJdQ34/1pMEAu0zAEZE3/yTqWe4xlRBUzIgllXhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FP34uZ+D; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVnWm6f/2UAs0QA6yO/VvG/2smxXTf3OFkUw8oDF3deTuIHey2Bgbuww6wuFKPajGoa/yWWFQ3VbHvTSRkcF51zs+BWBtaPEYM2hNIje8JVkULHlFNZuSpp06ZnfPJaaY3To4eYEJHk33EKMyfsXRDMH8I+MrHffuLYIww4/Dk9oO+jtZZ1pLuP2yOrh45CvOcigkHGQUJAg8eB7HVaAJ26MYtTrXnbPrQJIS/GTomfITJ0HAeST+eBijHdTvtbIKK7TwFDQSXcG4gHbkrgaaTFsh+on3ITGBSNGmKkS1JXR2TpemAptsrMkncchDzVIo8798bRhSoJe3hiLevDNcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfJQo7BRfUeV6v5XCkkASY+SpZww1qRH2OFw110Zrts=;
 b=qgmn9I6ktbOZT37v0Vnx+9XUsaBQlgovhJuGFzP8LzYBGPhmVxZYrx6glut8bvyJnqZZQc+m9bOsYkM+TmN/UQBwKbKr0RigU+MQ5eDnb/ukSpgRDBulZ5lVGyzYXwnp3GzYAaNPPy+rbmZ9QX1OPExQOkLbDx2HQDRUClNRIiTY/3gSAMW57rRR6Hig8SGmWyN5w0uHI4oPVJZUXgqQJzDa7kUyNVeoEmEAvow9eqG9ukg+mflgAgSkQXnQa+5I7+iWRZeZg69gy8JsMVL/KRptJg/bhCvosmkUafGsGgKp97QLYbkS0cc65fCNLgP6cnlL2WC33QDzd2zjSumHww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfJQo7BRfUeV6v5XCkkASY+SpZww1qRH2OFw110Zrts=;
 b=FP34uZ+DG3fl6TFCJEp8qBUSUBRouI/lyZ+w1yZ7cKnqDNhj3Fpf/H9GW0SoHfMCqQEL5NWRZ9pky9WsulYbUaxQjonTBul0mgJvSod1Pk9nLQvSVJ79i4yhz0FIc2SiAYSnTimhXCaYQx/ia03GJtsJyV9pOZKwVPzsgjBMOp9GhhwXxQ+g1exwTomo/bLljYmrl2tbaoFH8Ju8BLflR7rBkUIIN+xM0vTzm1GhivJlp3+tihKDWDsxb5fsVWVfgbuuDEEwC3+P54r3iPdGZ+K1FiEBGE2enADRJvSBI6LWs7uOsWHq+XoUd6TD8KtL4ysfr1LlAI29nZkiNLcB4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 23:02:53 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 23:02:53 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] sched_ext: Introduce SCX_OPS_NODE_BUILTIN_IDLE
Date: Mon,  9 Dec 2024 23:56:25 +0100
Message-ID: <20241209230242.775225-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209230242.775225-1-arighi@nvidia.com>
References: <20241209230242.775225-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::14) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb6e7d2-82f4-46de-68d8-08dd18a59c95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IqzgU/eN4thUtvcPOYkMfM66+5hSItdQ4/cWjUKQIYVuif03QmLBer1Ev5kT?=
 =?us-ascii?Q?EwNJVmkfjHnaBhcHv30g625/Ds3ZVA7ET9/PdOl4Y4ie47fdor25pVjvW9+k?=
 =?us-ascii?Q?SS2vZEytUiQYW/qul0eFZJb2W32tzwxdYgjoHNYOgOqP9DgY1g+q6cTVz2Yp?=
 =?us-ascii?Q?E40aJ48h1rGJjuXEZvpGnbg2vk4jvnw2qKJqteHL4ml4zaz+EmSqu1SLJHTM?=
 =?us-ascii?Q?bMGM2/OUoKY7b1kPchts0tXMOdqdP2UqOzHI7Oa9SIGLUdOr68EJMKdozIZY?=
 =?us-ascii?Q?epYoIVZs7UaoqRQc0Ij++mDNuLlG67ufE9ZhEKKcYshqGBx8ZYgcKjBN0q0y?=
 =?us-ascii?Q?IGykNrISjzVhP9ShzdPWzRvNktwbaOJQLxDuaBYCJ35/foj6/EFXWAdM/BpI?=
 =?us-ascii?Q?VMJigVYW9VQS0Q3ovu+UhEcbwu4bWwyLPhb89HuUcmibCBH2LQj5Qc8tEUmu?=
 =?us-ascii?Q?IlLXVBMk80JYAsoVIHEZLYl4/cLEJpgnGn/JHVAad2AdRb17KJ8eVxxtVRaB?=
 =?us-ascii?Q?/UaanNLTWe3DBsb6v1UoKTJbeRW2W+4NIZlp0I/qwIhXvxgdvaFwhF1iNzHc?=
 =?us-ascii?Q?0zI4xxq8jYL2J+ZqkG63X/5DSvcKgc3ImL2jw6M6ppcXlDTKf6ZDbskYGNyi?=
 =?us-ascii?Q?/xFlqmWatBbi1YqLrjHm2IbqkVicBqkXchcbDNCNEhKEv6rV+2I8stbcX1uG?=
 =?us-ascii?Q?nXCfz+BkOYVTJO+mSMk0yhBLMGMokTkSZ9Jz+cPo9pL2H+yOhtmFluP67KI2?=
 =?us-ascii?Q?zbxw9jDZHM35kCnqg50Km5MUBRdo2uqR6R/EfMdr1J+5flztiYwJyXnTSH7R?=
 =?us-ascii?Q?BiVvTsGFQ9/94XvmhD2JP8yHNASfufFGW6uDtizPE9f2zzH+CRcMG+Tspa7t?=
 =?us-ascii?Q?zwVqq4U1sZ4NqVJedBua6L/g62Oizm3USi9i8ESG+reEchhbm+dHl7GjFc/V?=
 =?us-ascii?Q?HZpDfvn3RXa2x64gi6Poa5bt+jGhYp9L91w2brs+s2jyDxFYySJFXDegAK/F?=
 =?us-ascii?Q?Y9ES23KShhw+LvUsjKQ5QxuEyMe/Sh0qmacCTqWTD/cBreECRf+M8Y/h52lm?=
 =?us-ascii?Q?HK+kCMrZyOkrfTWuXKMK1AEW+TYhu/xFVBCN376FlOCyMWm7G1osm1T0GYSs?=
 =?us-ascii?Q?TMaABv71cpi/eANWkDfeZp+B47cdEU2N9bSaN6UXWStzJ5WmcyCcjIfoV/oh?=
 =?us-ascii?Q?7CED6BJUY6xI15Qh95l97Ee+gchi+Vb+iFvj3Dc5zIawVqhRN/PP3ONn+u3d?=
 =?us-ascii?Q?EcPy3w5T9FsquBlHFZhM7ZBf4yMiVE+F1WnnTuBZIo6VOpxqP3yzEw/wqja3?=
 =?us-ascii?Q?vYcuXwAVAHYwpiQbULgcmE3rGeFXoxOhBxPq9C6fAYiVfA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lWmdV2A6A4fn9OQJ0+HCAy3zUh0bN0g7LjVpED08zVGp0m9AmCbD4RTuLQHA?=
 =?us-ascii?Q?9U9/EhSO6rnQEqz01lUw4pXGJ6GeLhE8oDX482Gg2VAAXx1nVJpPKcZIca4s?=
 =?us-ascii?Q?fxVP7JAP5VBbQjZ8IA2KAe4tmQDF0Dng2zPLel7lYMbUfSmjmEC/NOCwsIan?=
 =?us-ascii?Q?RMZDKledq8GB89FQspRA7Rccoym0gcXBuCGmVyNRALIRDjAISMh+Sd7T6BcC?=
 =?us-ascii?Q?xEfhtsOn/QRFcQn+FIctVE6WlXZUZRdlKFBKgTeT1b1xndO/SEBnvZKm5EJq?=
 =?us-ascii?Q?x0tyZ29X0q5FYixVxXXwXZNB57f4kH1crr4KqfJ+OAs7gZMHI14foXUguEnF?=
 =?us-ascii?Q?J0ZVRNxdloGTlexnYzF9SmxHV4qIj+LWoZzFHtDqQOE83xKZbQgC/znqtqIV?=
 =?us-ascii?Q?WqYk2idWM99Zn3T8MozfAWvpey13UEBWmibpI6GwtCYn3k3swb9wSzbSEXzo?=
 =?us-ascii?Q?HOsJluKJGCXI+jRP2SHxMgoK9PkzOB9LSMyWYmxxJ6f8Yhm9pY7v2jMahZYy?=
 =?us-ascii?Q?jU7MYLyX4V8Lr+Wx7lDqu31zZhw4mjkMWBFiF1NyLbJULrwq1mmVgA8W/+9J?=
 =?us-ascii?Q?TT3foo8DjpOzX5XedMdTBDTuRJWxuJXwWaW5WCvV8Frb+iAFvCNP1JITaMF2?=
 =?us-ascii?Q?apqE434ZhR1H9pdcTpJgfQpW7rNSxTlruqg0imEiHwO4MIMhZxflO5SEkw9R?=
 =?us-ascii?Q?PMcD6uEMu4+a7/BY/Mbk4mZUpVNk63sF8i7Eob8OzxJMlESki4wpuEzGzhPK?=
 =?us-ascii?Q?xHYjlV4diJqzUEPAY/YAIBUR2s1hGQ36kPwk30Ba4qC317yF79/TlvfwcUYv?=
 =?us-ascii?Q?3dSafUeZteqiPbYKNLSXPwhRQAIso2DJTB6x8ASrIcNB23Ed8UAFMdjgYIuG?=
 =?us-ascii?Q?gYdIkp+ZWFZW73YGSIKGUIsLKE1vHyypLyIuUDSdkNMxoEvQBgbctsLOao0U?=
 =?us-ascii?Q?O5vSXPoJUd+dcJ7QRVgdQfO4V1+vzvI8+owcBWoN76xql9cKhhBs4Q8Vkb5A?=
 =?us-ascii?Q?GkyKJp7mOu5mh7rU0qdo33k3mO0nWo8Xr8yZBF5ZZcKl6tuDnQy6aoKp98jG?=
 =?us-ascii?Q?9OWKWvMdxyd2jhx3Fos8wG/Qo1dr71OJ/34dWbo46NveGS5KSPaD7TkOEyvh?=
 =?us-ascii?Q?Rresmp1yo2faVEYemoYICJXq900JKXT45ZSMYKg4Z+58aZHJ1B3nR9MHH4Fo?=
 =?us-ascii?Q?4MIRADXw6peb5BdMS+dFfwEwu1b1l1XujIAJkeTvk0+3/EAcBIDi3xQA5Tz8?=
 =?us-ascii?Q?D1E+cBQeLJdFfIzO4czGU7Oqo/4E+9ie8BEtJpNvzl0nj+Kopd+Vf3cxP1gI?=
 =?us-ascii?Q?p3p6ZiZWoVTAwnxeI4VOHvyaXv2hy49yIabmfvhYO76axbfS1MOEJ+1gi00l?=
 =?us-ascii?Q?kQeFk+pIMbKL57H/qZjg5/2tYcEniR+XiXBeQyYCY4j69UWHZ9cXZS75/Aal?=
 =?us-ascii?Q?PX4dOqCfuYbHy/Du4nOlyx6CZIKYAvNn89BjsMMb7jA2+1uWBh9zjyL1tdIH?=
 =?us-ascii?Q?HopTGzAdDtr5xb5Q08QdITM983EwxhqRdZ0Shl7g93x8ksQ1vdXimMzVT75R?=
 =?us-ascii?Q?Pli7y//PTpGGgdiqx/U6J03r46JAoRmE98nR3FKg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb6e7d2-82f4-46de-68d8-08dd18a59c95
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 23:02:53.3417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoCOVLWDFLC/GKbKZcc2aNf573YSDXzEFvFuOfR2eZI4kTD09LHU34vMdw+hX2ApZcVpN3oGVNLPJnOP0R0Tbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297

Add a flag (SCX_OPS_NODE_BUILTIN_IDLE) to toggle between a global flat
idle cpumask and multiple per-node CPU masks.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 71342f3719c1..3d13e7975abd 100644
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
 
-- 
2.47.1


