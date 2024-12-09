Return-Path: <linux-kernel+bounces-438132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2932F9E9D4C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076181886916
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306CD15252D;
	Mon,  9 Dec 2024 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JViVYlyJ"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64B91B042B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766314; cv=fail; b=nYHzGCxQoaFmmxSbCzxnAjEYSwn1I7aJPxgSRiDuS1LB8RcH0248F5UJHa0k9+IGSOxZ2Ut+VTvD+Q5stBd/lTD9cIoT2GuhmRixOWfN63fKas/D52HjYu/QpUN8fzQkiFV8lPy20yEXPLSacofJaxJXc6oRt+DUVB2UzqdmsAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766314; c=relaxed/simple;
	bh=k4qY1vuqfygWw21kOdBev/XcXj1qVH1byzqsSUY4z+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bWfmwIC3otXmR1yKy2j48nBh4hr85ksvECWmZoXL5rgleDrtcismP0GuuA7RngYWMtXnk2Z451CjPB1nq1i10LMepmEjuuMx43Yhe3JtSme3WOoQpIc5+olUPNeG0nGdIZhNTkQ5OV0XcvbRzuNTxhcFMZcsLxtKVnF9TBYHGIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JViVYlyJ; arc=fail smtp.client-ip=40.107.95.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9dNp5Vml2/LcCeWW3NktZON0xfV20qolg+fCXfv4XESe8L8Zec2MhLmzvvnLqpkcXWf3euAgi6q48Uh8O5P4nwypZrx3RI7HgnZ0I85APVuFDBEcnHaXzhrgFp5mt9q9jumJU59awfjknAzSC6TX4XDBFp8+TwIvZZx4/AHhN0t4YDPoxDVY+U8wn4l6PNhXNeDmPFC1l1629klW2i8ChC+wv+kMeeAvMj9b5WrYoC9xit8eQ52lXADm5BqHQ4pa+IUM2+e/nyb+x3Yl6wM+kkUPxy9K1M68N1fZ/6CXCuLPvdDDo7GVSM43zlQv6CvbA+e8heTTkHbxatYhyGJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYaxV3xBw/Nhj+w/r6BaBPgnGvuucClWrKQXZ2YW9aE=;
 b=iHHzk4Mq11LOn9VMAa7TjfLz16n2ZSzQP/e+giY4OXu8ZnhEiUXgQbRbcLviJzc0csYpobV5FcLJGY+HZmkBG4/sueIX4ZF9kB1mAgb1hL/KWj4iTIphTo8YGQxUkS7VPwY360UNT4m6wUQ8EsOMgytjCHLgw9Xb7OC6kgBMhuxBm53BI/lV8DFne/G7zm64HsL2CkBVtAdMxq+BgNSrs0qgj2Uop5bOj1gJDNUro9uq0A1rMSUh2xm06u02JFlA/yAjZhst084SYIzUwEpq3R/eYwznw4V3Zyho2IR4EYSCp0yauHwixVz6gWFb1yNUos3TrDvm/zsVu0HC3AHyIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYaxV3xBw/Nhj+w/r6BaBPgnGvuucClWrKQXZ2YW9aE=;
 b=JViVYlyJOyZOeZnu7LUK/woYNRB/MwSEuxc6Iv5jH591+dJqLvyjfgRl/BCYyOYXMiuoANXgl/6wOl5N8UP2CPv6dfd9x1ltAQ8odOF1u8GlmL8iAXAZuKPJpvT2TRk1LFIn2myvNAKhLAWI8UuVFzGu5+NzKOTBAuqTUf1UO36cGfysgp6Z0ooa3JmcA9J1+v3fuQawNRgSpjQsOz9NZuq/TCt79EP4zukm5WNNAPi3siz0lxq134j8pU8H5B6gV3aKZQCoZ2mji5GcCJB7X3pUZlfRRMsS18oW7IQNl/uSNd3+g3Z3eImCpr3O9wbZ5cMoR3sQdpSl6U+lWTPwQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) by
 CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 17:45:05 +0000
Received: from DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793]) by DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 17:45:05 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add self as reviewer for sched_ext
Date: Mon,  9 Dec 2024 18:45:01 +0100
Message-ID: <20241209174501.748908-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::17) To DM4PR12MB6424.namprd12.prod.outlook.com
 (2603:10b6:8:be::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6424:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b747d88-327d-4e41-4295-08dd1879371f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gtmuQf6TbQQigG8knhl4w1alZMrpV2gXEktADMoNMJCSHQRNLiDcxrdpGeYb?=
 =?us-ascii?Q?lx7n+au2KQFZbvuLJAP+Z+s+oINfbqNK3WlvaS6BJV59FZnVruHFE1hMIRGq?=
 =?us-ascii?Q?Izwqhmo3Nmzz/Tm1AZW7FfYWzF+51ZbO4r+3+ieZZpCsCEYcbf3izgTYV8AF?=
 =?us-ascii?Q?d78GB2oY9tusSNcpP63Zu4wvOSHfCE+xyR3newOVFiA0uFBPaSTvN27Ehy4B?=
 =?us-ascii?Q?dzOuVsWMT3+OoMoC1GsD6ndYKC8wrc/yhxoIGY3RTJKZAOcxYBsXdQSD0rxJ?=
 =?us-ascii?Q?lyKNCKsntjSCAR7ovmbTQe/kZaVg36SQUTUh0DQZHU6azmHpu7uCvCrEDVaG?=
 =?us-ascii?Q?4TjCf4mhpY2nhgah9VPw9A+wIU4UWCmGSiA8TflwpXqoIsszKNJhkj8/hVb9?=
 =?us-ascii?Q?FO3aeJJduxyalK5TSaYbxPlIBsdVmwEuCLKNxPDXuRKytmDEFiUXT39dZJ/p?=
 =?us-ascii?Q?CXurUwXjEcdoqSmOuXRK4QIUE1VxTGxa+Q6ZyUvOJEQbOFWYth9s45p+vyVr?=
 =?us-ascii?Q?CDyHLxSSjDeVjkM0vI8EpeHevUrhPARnbj/4/qfbHjAOVQA42ErSnzgwQC/j?=
 =?us-ascii?Q?wkq5UJaU9zg7U3lSxEu16ZSNgTeDelIz8THYShMkcm5sqgIUWi4/O3hPXF5l?=
 =?us-ascii?Q?z9tRlMUxYnu5b4AIkowr1Ydrkw/doqBOCbdXqS96qVF7h3FPsavt/pplPbv0?=
 =?us-ascii?Q?LqADg3QxqbWppdPq1zZ6AK559vYQe2uIKCBOsCKGLQfct5VuCbNdZJ7TAXpG?=
 =?us-ascii?Q?EyveivImbgvlmjrRLsGJck1t6wtJ+R/Fz27knU9OxbeoOq2V3o9/LGNGT1Oz?=
 =?us-ascii?Q?VSnjzbjA7QK4YsicsFxitvaoVamCfUx5k23gk8VlXFiCwuNgoLjI5yDABg/Y?=
 =?us-ascii?Q?OJ+ohznnSar6H8KZaEheNVfwpTpeRZiIocc4+X+2cTh95ToGfDphNsvOXkjL?=
 =?us-ascii?Q?RSw2NdNwAv5NzURdM4kXSnFhm30gPisxv4c0KIszjzKnDLTR3YtGjjyvlHNv?=
 =?us-ascii?Q?MILe5Ip3trHMYg/PO6aeyhwtTUMFn+CUVSP4lYMamBuoCBR+gg0Vub+uaw4n?=
 =?us-ascii?Q?y8YNvF5HfR7CCnIJniJWXfFoOm8LrgaJyM9mr+QUj0EEdVKHWFMOPUtDqb8m?=
 =?us-ascii?Q?93VYxi95CVKzhtR26SsoFn1EAZTh3AxcVEnXCn/AJutIwyPaHZ7CK+965r1f?=
 =?us-ascii?Q?uCbYbWImrfRIVZVVQ+OIENaqcbvAgZgvwCmWR9Q4t5RRzcmDhCwU7yjNZ4Yk?=
 =?us-ascii?Q?mMgTBtC7MjUsrrPCyS3OLAgyZTryvRkMOc66MYvu2EmrakGx+1hJBXfj0F6m?=
 =?us-ascii?Q?IBHitqU9BQtV7hqhd3B1oMW+SU4m5BklLYsACjfmW4xAsZMq2xL/dNx8Pu2b?=
 =?us-ascii?Q?jJPGXL0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6424.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U/QaETTqEBic0dUQIDPgS6AOJH59MiSEWG4vSsynltOaCYmEldCEiGVwqGNt?=
 =?us-ascii?Q?XXcsxX+KFlszWq4CFQGnwYx2H6au56QjUxUvIK+eZn/P5ug+9T9aLqtY3I9K?=
 =?us-ascii?Q?T50Qo/LnnbNehG/TMh+7G8RZ1jDmJxt4/Ba7wgVJ1vyXrxDESTdoTCcWOJHT?=
 =?us-ascii?Q?cC1vBYU75gBWJedokDXQ5RPeELG074/4a/PUDj1add7FJ9CGrPhGJ39EhCpT?=
 =?us-ascii?Q?oPhXvFrqEzfYt4inL7MIO8bfy2Lkr7JeDIGpZhlKYVEAOVJbII5oP9faV+oX?=
 =?us-ascii?Q?jpSI3u9btVJN1yblOnsNhxpS7gbFolAnzLf3gb4sQkoHUidaT8nD59QKbLGw?=
 =?us-ascii?Q?Prw2UvZY9zyFwkTfSKPcKi+8dbGvA//3JXH6OLFtVJzSqgvbaWf936tK8222?=
 =?us-ascii?Q?E9sGF5fK6o+TbUnbN4UUdtnH4KGf3O0q/iK0y5Ab7FdhamOI06HRN+7sHQvO?=
 =?us-ascii?Q?IBTADSr5vQYPff+szIzRwH6/dGL9eCkTo0VPbQ6Dd0FwIyBigdMw27OyS2m4?=
 =?us-ascii?Q?hJzOLSZXhKzd/QME5RYXqzwvXV5PxHLnrtFNXcgSG2f1rD75as+MalxFi8YX?=
 =?us-ascii?Q?BB0ekCzcuX5zVU/rEFqfV5gFW9MyqyhLMpsPgWyCNZL+oJStKHdtTj3Rq2c9?=
 =?us-ascii?Q?h5Rz6KNoRQw151ttOAIad0wDyjK97iRa1+Y9Uo3tqAIbgxrqG8BD7TwKdknU?=
 =?us-ascii?Q?+NtUwSPH+1OwzCLfLCzjAz5OblXq50kKrsjGq9eHN7vgrpt5OVXdEibsWq5y?=
 =?us-ascii?Q?kT5c29+vTikwDbJQVQ9fvORs9+SRgQ6n+DvjPG8v1mwoOt1K8Co/AY5pTZPy?=
 =?us-ascii?Q?Xb75o4ql//3XBE+jnDmvd+bB/y5QH5fuxo0YjdN54/cpC3O37hxM8TowcIde?=
 =?us-ascii?Q?t/l1HDSrH2kpdbRF6Qmz8G4sSBepZtlRie1X6Iv5yXt3SSvdAtaLvcHYbWRV?=
 =?us-ascii?Q?Ygm0m2rWO5EA09/3CRTu9wKgJS2vL+YRI8XDT7a47KLuJkhaYnShZFqwq0OG?=
 =?us-ascii?Q?Zji56rC6MmLwMvpOoEFbir91LwqzSfwO0IPkdO2Kx27neyzP6PfjWA36Rd5m?=
 =?us-ascii?Q?AMhm+Lv20eqOeAzv+tKeASQCKM+SxwPs+zY0RFIVjz1nuZmMaC/0zRSW6vNS?=
 =?us-ascii?Q?eUlN+94aOWg7+T6AxsE8tsqUzH/eXe6dKLrx/647alsK3QV2q+FYI12JBQsx?=
 =?us-ascii?Q?L5/3DZYazkHJLRY9gXY6hXVmiir+H4vPm7xY2xbvTm7peihmiGzIoZ92To0a?=
 =?us-ascii?Q?EHVpZKl7G8vSGSBcbIk+Lx4P8dUbfT7A0tQg1YoxehzjSVtNiURHHwdhbRcL?=
 =?us-ascii?Q?pQYFaFpr2YCWGUcYpgxzAzKwt9taG9fDfI6IoxW+cNDj+TzXz0qBLILCcLpB?=
 =?us-ascii?Q?zFEvvuy1YPP5sJdbBkGzLkial8iUnOaZ80hSOh9wVMnqokLWSdara+5rJ9K/?=
 =?us-ascii?Q?Hbol4u4oLN+SveoDLGOcET4D77k+wEjMX3qn7JHLjxTxNYX58rfXsRS/sFbq?=
 =?us-ascii?Q?kTBNWFVzuwsdrUJR2bc7HPTeg+6A9PwDAvO6/cujceZkvA5uqSfFMaz0DZXx?=
 =?us-ascii?Q?io0dQzFQXc7MgnKhz92zIMAIiW4XkyV/8xO5eRaY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b747d88-327d-4e41-4295-08dd1879371f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6424.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 17:45:05.2808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYgaK8TdYua7nw7GNE8wO+/fM3DHEc8xQFNWNn58MZj317iJHcHOhqXo6AIk+kwm76RyaOfcsXILbj9ps9DS2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464

Add myself as a reviewer for sched_ext, as I am actively working on this
project and would like to help review relevant patches and address any
related kernel issues.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..41bae8792a77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20902,6 +20902,7 @@ F:	kernel/sched/
 SCHEDULER - SCHED_EXT
 R:	Tejun Heo <tj@kernel.org>
 R:	David Vernet <void@manifault.com>
+R:	Andrea Righi <arighi@nvidia.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 W:	https://github.com/sched-ext/scx
-- 
2.47.1


