Return-Path: <linux-kernel+bounces-448968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 872C19F47CF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C7C1886387
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB0813D276;
	Tue, 17 Dec 2024 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nZZ5u0MV"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4534C1DE891
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428551; cv=fail; b=U3L1O3TmHKxoyapFMwbfRQ0TQV2FSOgQXn9pXPoSRMrikWvSXsoOQM1yOwAjhNZZN9bBEYJlG5ZNKrxlDXCdbUDeO3AhBhp5Fffzy6Ssy5FYCJnzGOzywli63CEOoRzPYmzIDvSgzxTVQsqKwLko1hfyubL2+hLpD6SMG+H/3GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428551; c=relaxed/simple;
	bh=ISxKP4lD6T5/dPazjOWHDL/ILARIGlMNlcQKrRSEzMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sFH723eCOsUms04GeMhwSNCFJH/TUE6qJLZokkbb+snoMwJf85c2kXdGAZw04rbpS5eH+6ARNWw7hEF9zJ11AP68TwgoF1tCmb/oln3fgN4+XURElJga0WyJfqm4xBJNZaBEMkXH9/BNLLq0hWXjvfNmWagfQ3EB/OpzXf6De7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nZZ5u0MV; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wy03mFA4xZq/lsBVwwe3wJtkmaScvCp8CjFqP6YXo9vfHcqCePwdnbruI9wqNSDLIN8ajDZWjwQRl8KPE2LbM8LdSWembW1AtagXPB7s/HQpZRyI4HMqvoMY7Cjt7LQic3FGC6XZ/mHE0Fw9IvSAGwmTTw/eF6Sg4hZm1rUdvMZocS2DdwdC0ESvSsC1GL/ZOI2eO/LVBYQhyAe2V772QTIzYFXMc4M0fs3qG5VxKOwJeYm89tZt89op7Nv2gqMI/L2696uWZt58C856mOq0zIObq8lGbPSqTh/+K6YbMf97Q1KqE3ptyypEZ+ZK9E9yWovODiGE4REM1/uIWAoTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y71hE8KZJdRF96okmvY8UJpXlgK6kxX8uAYikXHXCIk=;
 b=SnBXDARGZiFxdbi9u4BfTAjJ/5lshv2SBWs1A0cWb6ORtB4b2H+H0qAGV61IbNvczeAXem4hqT6ZhaKYVdKm7YxfP3Hw4xWGMsPthMhqV00/OSMgKePSc0ufE4Pb72qW1Xxr8TfJLpfp9eVcy6tIbzmSPaaZ76b4DwOfi/J5V8cL3s9A8gvu9nqBeiT0kHKYs9N5IMsE/cryZqu48GgZNPkczJA08Ny7Xn94ZdsbhrRswO3iuTDa5oOPajmdzLRpYoLWRgMlLaWJmyZyQkHPUtIL3nhiBcXkHmgip4KqjCBI8k8iDWstjGeukDMpQOEqcNFGdvcTOkFndLNTHSwiTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y71hE8KZJdRF96okmvY8UJpXlgK6kxX8uAYikXHXCIk=;
 b=nZZ5u0MVFccOIsK9nkuonRMZ5ynKm5KV9oHKJM6tIDOnZU5M77zMotQAJmwzXx3U2JY+x+2GMIr6LE958c9JFegh24nv6wQFvDGOdLELcltoUdam5ykrhxV4SSIw8nJSXon+NWEmS4SIXM+7uXWHkVl6nx5O7dxTnFugycx+zsO3dLHxCzQswLLOXsZ5Z0ezo06ntSVjbmpWX+Tv/jP8EW/towvlh1GOwTpEWpXUkg85AQ4Ba0SIEtFfuIfhfXy0my1tx578Hyx3l+PN3A5/Osng3KvG1L90Xo7DkuepQ2gARGACEqCL6IkjW6eaujHJzACHqrAyQ0Kjf+D0Zj9P3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 09:42:27 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 09:42:27 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] sched_ext: Introduce SCX_OPS_NODE_BUILTIN_IDLE
Date: Tue, 17 Dec 2024 10:32:27 +0100
Message-ID: <20241217094156.577262-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217094156.577262-1-arighi@nvidia.com>
References: <20241217094156.577262-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::9) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3937b2-6132-456b-da28-08dd1e7f1e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iahmOv3kN86rvzJ+B8nnyu7e+Yd5eE82LkvThjsHfmNB7FoqyfH4SjNuHvTB?=
 =?us-ascii?Q?I6sFBvHR4amJ50d6lPXErE/IusFO7nqUVlEqzlqjx8aMtr6vsBGYBxROK6j+?=
 =?us-ascii?Q?fRIknUvpuuU7ZZUQ0TclWtssLhlTbMZ3J5bIqhGe6ftdJpTpn9KlxIaSGF1q?=
 =?us-ascii?Q?L3WrrwL1FGSXXyGySqXbl93jzwn4OruMUIqW5CN1WKOavCwsZX5i865OPqrk?=
 =?us-ascii?Q?IgWA42YqY55MvIZpHcFGAT5BVUcF6M9b/RNWm0CYJ0O0w3UkOTv5TXmpQrDd?=
 =?us-ascii?Q?x0MBF5O4a40sRzXE6LvOGOnYtG14Ou+koYdGjEbC1dbV9nJ8qczNMjMEOG1Z?=
 =?us-ascii?Q?32Chbi+ifmFwUo/UVvLJwJ4ZWbNmE+xH0tjvf3nLJLYj+Cq7j4/9RZklE8VR?=
 =?us-ascii?Q?2GNYWIrU/RnhrUs6JM8V0nvgI+3ScN7jDT0tQUlPOC6reApWCQuHolPlC3jY?=
 =?us-ascii?Q?e2m+IZTmJmYf0lnIxaxZm4uATM7x06TDTsWy0ZTxsJ7qqvuAEw9u/ZlW+9qs?=
 =?us-ascii?Q?qEL7KVwEIksFeSYOPf3y4SiQUyZa/UGuXPvEXblTAq4mqOAA288QOZbZbxu6?=
 =?us-ascii?Q?8cJHfBStidmW0R6EcenXbenVKIQ1ExmhX74+uzH4zpw7iG2MfAsqziFbExnh?=
 =?us-ascii?Q?3zUVyQvqSr6U7gRuH2Hrl2zfufl//hkpzqvfC2PwVP4NbPEIdFwYlYFlXBZ4?=
 =?us-ascii?Q?6kacQdAp4Yr0LLUfPF48JMRBaAVihtmO+cchyFDWxSIpTWdyeYZqMz4WR1X/?=
 =?us-ascii?Q?iJiRBm/zM5d7M81u9FVdQx5I4O+BmmjQ+tBWW4SOyWsmd2xe237NBR9PzMjw?=
 =?us-ascii?Q?VM+6mLcaVNO2jVjPSxgdWuGYnL3+69dh9RASnQEG2ss1rwMY1ucWtL3qX3WT?=
 =?us-ascii?Q?T7Lc3OiHfXL6L7hNZ2Qk8YaDgiovbKVCQIjKvbbCNUXPdj4DLJt9kXgpfh3A?=
 =?us-ascii?Q?kLJtmvENYbWgcP2tL40M8h6n1uQqpWz7NY1SxHk4uc290CQM6JjLRD08/OHk?=
 =?us-ascii?Q?zds8Bf+wDkMaRKSwnE0Rzaa03pcTqMjdWj2aVDNX+i0XkYbXWpOXEJW127yh?=
 =?us-ascii?Q?qw9qfejpy1cSPZDjOcBr0xrEZMdD0CI4vt/+ABzY4dKjfItJZdxXO8z63T3I?=
 =?us-ascii?Q?ygGWfLQ0SLlALfJLZN0T9il+eHf/kf9k1Fq5QGkW5DvAIt+ilc4Mq23ZkYZI?=
 =?us-ascii?Q?sWqYlepVmnzuoPYipiCihPNLzVp1rN7ac9omBBK6IR2AwuqxoS/vkAXSa8Ql?=
 =?us-ascii?Q?oM7CGeDOFGGKk/CyskUG//7hRS9u81RB839HIOWdSY08BhRPBrVAmLY5nG2X?=
 =?us-ascii?Q?Df5/q/mN84VQK843HspYBF4glS469oTsSw+ies6rSTkkm8+foQq7pPDbVr2j?=
 =?us-ascii?Q?BBhMD2FCKX3HVnCcBv73vdo+92BD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iHWC1c72qf+DwY98uaug1HnGJ4+UCA2sc124WzjmmLMbGQqXqilc6BGYIne/?=
 =?us-ascii?Q?IVAD1P8MJ0UmfDqnwhePqnxyQkgw27E984I4Er+SqRIOI0ypP0dkixTb17Ny?=
 =?us-ascii?Q?brsHp1pwZ8Suz0nCsG3DCbuyZmRjGH3M3z+s+jSayaM2bfvdgWt3VjWv7FJW?=
 =?us-ascii?Q?OmfcGfd1vH92R30UYM7aQ0/qXHdd80pK/KmgIDnTWNmPrbkNMP0/vjpXlgYh?=
 =?us-ascii?Q?3yub1lAK7a15Ffy4nwDDe2qp3dXrg0V1d+lHgWRs3nvRE1PWiqxlHOoN/c5r?=
 =?us-ascii?Q?KpSC+fTnHw+ujU68vp7LmQc4lphZDVXydxax7eSAxNuCExqvQ5ivI8/oMeU7?=
 =?us-ascii?Q?AEqMNJPLQzggmIXDonHTocW1Syy69JCpTcyg3nAU8t9C4nByTW6TtjV1Sx69?=
 =?us-ascii?Q?pzzaGhWfZyF7fQXVxOCu3kToi9ZUSO12XZgq95Zyw8LRyXtqanTfw4DygCIN?=
 =?us-ascii?Q?QJ1GAhtByBsLqECL4DXhIFbSyOc1zXMYQYGy3dmHXtBbB3cN+bWPmRrYhzSe?=
 =?us-ascii?Q?PlmVUN4r7yhfBtLSV72OXKJIsUcC/L2xZ6WMPZPM4cXDT+GDFM3pcMQ1pLiR?=
 =?us-ascii?Q?GZQ8LyJnkkKic1AHZKTC/bKApiAuG2quYGfPOCywxE7yIs/Pho0VgKXO6tcq?=
 =?us-ascii?Q?mZ+kS42ru3nwSoe0lnr0xgyahjkgykPhOF4qBmQdAIWPACIRzf46W0HlG+u8?=
 =?us-ascii?Q?sIZk4hYlaw0lx5bOtjrwskot1DFe10UlL0Uhm1Gl4RL4wYe+uCzAN+cP1B4S?=
 =?us-ascii?Q?XMo1W6WfI5NsUJpt1pNzhlWtRTAj+PnGbaKFC8+Klh+Ybh43pf+s0L4LV+qi?=
 =?us-ascii?Q?nfOduJDmdLjzYYkM9EZN2ChwyFBhuxPBjHj/OF0IRVtDJwwKIS8CVi1qUF8X?=
 =?us-ascii?Q?2jTRjd/JIxhzWFsOsys+0jfyEjKqTrtE8NhIY43yOWBhs4K384UVZ8ytinpy?=
 =?us-ascii?Q?fEZfOIZ4x/CeCHY2En6ogd0gyi7GOPhN54DI3oy2VMof7StAvDysSDTyWIRV?=
 =?us-ascii?Q?MIipAmHkPffq7Ej8/dZlKq7WcIN0Uw/NHpya9C2l9xrLoY2TJVeBoNaDNJyv?=
 =?us-ascii?Q?FCv+WYp0MC8vzcIeI+Bt2sgFnRv+faAZzz1tTB9Yw92EfuHZchCJ8m0/KX2C?=
 =?us-ascii?Q?2vW+olZCgASwxDY+HbDp/10gKD6Pm+FL9zTgqPFAGhp7gM80StFLQ7kWSVgQ?=
 =?us-ascii?Q?94ZA3gXIT6q3xMsLbJZD2TfMaUgOe+S/dIKo5rkCnwWyTtMH4DmXWyOA0XIK?=
 =?us-ascii?Q?CerZeWs+umUGsj1xN9dTyX2+hgYzZtsrqswjsPHycjoyKNS1xsdUlYcy/rH7?=
 =?us-ascii?Q?xIKBdmAsun6X1Pm2MmvrfO4Hmwv1eMrwdZGRS5OO/J2jy/yx3Rxzn7A06inK?=
 =?us-ascii?Q?kgUn/MMDi4NXCxP0W7+WC4g3KNWOA34jilfgiGCNLWP3qevgDsUD22r/GdWg?=
 =?us-ascii?Q?N9l2AMP1b+m7+dIthgs7+M78rPa95E5Fd1YPMWYU4DS1jSn9KjyY5j74H7IV?=
 =?us-ascii?Q?EeUY5Gre+soOjRaV8crReO+DbxifeG2QvUSESJmvouZh939cxWpb4N4UMcvZ?=
 =?us-ascii?Q?sTQYvPJV5VYvhhgZ+Y78BrX9frm1XxLOpE1eqtnH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3937b2-6132-456b-da28-08dd1e7f1e2b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 09:42:27.4394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMfXomSDIDy5ExbtezWjFDkMfRLm/9xf+BJcb27qxSQ3lbCk75Z+NiDj+lyRFm762/lsc8YIoLUKIunLa8Ig4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362

Add the new scheduler flag SCX_OPS_NODE_BUILTIN_IDLE, which allows each
scx scheduler to select between using a global flat idle cpumask or
multiple per-node cpumasks.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 54e659ba9476..a17abd2df4d4 100644
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
 
@@ -5446,6 +5453,16 @@ static int validate_ops(const struct sched_ext_ops *ops)
 		return -EINVAL;
 	}
 
+	/*
+	 * SCX_OPS_BUILTIN_IDLE_PER_NODE requires built-in CPU idle
+	 * selection policy to be enabled.
+	 */
+	if ((ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) &&
+	    (ops->update_idle && !(ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE))) {
+		scx_ops_error("SCX_OPS_BUILTIN_IDLE_PER_NODE requires CPU idle selection enabled");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.47.1


