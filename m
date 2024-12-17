Return-Path: <linux-kernel+bounces-449270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D519F4C8E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FC0170A43
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D876A1F3D2C;
	Tue, 17 Dec 2024 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="osIMJt8D"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175F0250F8
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734442511; cv=fail; b=Z04ApNDQf/GNzL2VVtvHHFIQG6xeFBcaoULUVpng39NFfdqvzKGTz8nDvIwotiO83fGbX7+hRCvAOU9HUV7M7+zFEVc6x9Nlo7FLjHRhu8NAXceKdAsBeUunYrPB3uRUG5OOI6wQslMY917VmGhXnyxgzN5+UqMJ0o5tKKx5AN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734442511; c=relaxed/simple;
	bh=bOtuFJdqIl27HDgz7DIBUkbs2lQwxEocv0UttHpm8sg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QJCq0rlDn64SwikGRx7i25Af6QFhD9PTGa5vuckGRoiQu8EOHhLt8ffJj/tla8CN/FL20YIzcOsM/dJjS7woUjxJ56Klgk52le7cvCTWPIvnQjBCngAmPK2KAtFews7PQEi5hYz0uWjSm1Vr9qoWiHCvPwnuhLpHP4kBJhdJNd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=osIMJt8D; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QV5DMQnit7kNQJnKQ8adYErYwwxAJI926cOhenS5xjqgClRigNMW1ld61BmfSQ8yf8IshUddyg0PLxG5xj10rAb5zad8uXnIHwPsanuwYSi+Eh2o5lAuzFoZKtdzFLLSAEMrKGpGdL3M2LnaHMXpLIZ3uUave7W0i7MuA1MKnhmJLLVoQpyspsGyx8h5afjBKogTiJj74dF4lcSs8yfCH/U8DS4F4H3klEBrhbqNtu/iZ04hMbXhcrXRTb+3IOiHk1qZ6urU6rYh34GhVGnnE/AWixSq0zGg0efm0nlbuUNMCUgYtvZBGKK3Hcj9YtdX2w67e+nbiiC5qP0FXksbsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAIw8aVKrEb+tLrVbB7/tyv8bXE/L9AVp9ZLPjxNqCI=;
 b=lf4KZlJpsOLQICdsPBXwFOfjXVBBfM5r2Hssi19tu1Vqjl6RCo7YXMvfDxM/uYOamY11ozoNKBx727mJptsPFt/V/KBs3V3bc+7yQEQqWDsVLtXcW9ShDtpSaCAWI6uglxIczPZ0jYwHSI1hOGhsjYSabCPiIRYu0pc+ticUq01mxCR1U9XM7k3/SI6oXSTwzs2uh5WdmvI5kdfX1AMAKxCV+CoDpd5Ahq9qEDpzFZ6b8oKoHd1jMUliOK8egQ/lqbzSXL7oYYX21iW+vR6UBV6seq8IrWKkbOUE73L2Ewe1Cx5R8E5IUkXaIM/OFnRZpUIwRHRFNBxGn6aq0q1GJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=canonical.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAIw8aVKrEb+tLrVbB7/tyv8bXE/L9AVp9ZLPjxNqCI=;
 b=osIMJt8Dhwd6C8NnITnQS8bHVKPbsXmsOAi7LTXzTBwotOs4N3weYlyXEP0Lk4QDVLFHckhSn1Jc/hg4bCjPzA0GOreJriI5kymbcNw5yFaI+0UTrwLsOWG3RYuzk7dLR6e6sCNvUlBk+7fPta1vArss8r0CPaaRavVdSO2PuyvZlbNxjXm8xonSJlCkDp7MDWYrTt/rpDZi7Ceo3PjASumRtV+lx6hbOOsZWqJwH6Y2otamh1YKbMhd+isRF2TKb4njMS0qRibhcsQ2B9oSo0KJoRhiLsDoL8dJ5eTL0FnlogCfmOKjrxz/hmkIsYediIPff6/ddgllXoZ+9VNsMA==
Received: from SJ0PR05CA0086.namprd05.prod.outlook.com (2603:10b6:a03:332::31)
 by CH3PR12MB8969.namprd12.prod.outlook.com (2603:10b6:610:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Tue, 17 Dec
 2024 13:35:03 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::a9) by SJ0PR05CA0086.outlook.office365.com
 (2603:10b6:a03:332::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.8 via Frontend Transport; Tue,
 17 Dec 2024 13:35:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Tue, 17 Dec 2024 13:35:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 05:34:50 -0800
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 05:34:46 -0800
From: Petr Machata <petrm@nvidia.com>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
CC: Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
	<lukas.bulwahn@gmail.com>, <linux-kernel@vger.kernel.org>, Andy Roulin
	<aroulin@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH] checkpatch: Tolerate upstream commit references
Date: Tue, 17 Dec 2024 14:34:30 +0100
Message-ID: <20241217133430.342797-1-petrm@nvidia.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|CH3PR12MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 96387b18-8ef2-41b3-06ac-08dd1e9f9c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UO71yBVkRBVOVNJo9uqkBV0UhHUaqACJCwgObu7bcrKYSRUUJ4ZF1CRFjAaz?=
 =?us-ascii?Q?jHuUvjSrZInhhL9GQzm7xSSJQRjyw53a+ve9YNPt3vm2oRD++j3Hs7g+1rgl?=
 =?us-ascii?Q?ZyLZxiy7hT7EjIlzjDKZxTEFxJZvDe6k5onYtDYLwhuImI52m56QVLZSFaAt?=
 =?us-ascii?Q?/adCsJ16D4nyyfl267se8Av5JHVPmhv/JbwtX5nCob9jJ7afPYIHyyWETnXr?=
 =?us-ascii?Q?ThSrbQ9dLig1l8Wu+4aExbwmIriT+AKZEbTWqYYUKc5sNm/Ntbo9H/AHyh+/?=
 =?us-ascii?Q?KiHL9EZfkjmEV+yvHlOxF8vKZmJSn8ielFKcHLk4lztED5/QGK/ituCKApU3?=
 =?us-ascii?Q?WNNQU1ptUAS5nnp/jXdqCNscjoZdtorp1jFqLxZ4qCln5/Vrnurbe5j7kWcm?=
 =?us-ascii?Q?+6EynBuLxq3uhiT0wJI1wlCmq3CeVfd5bGHKW31t8E6kJ+jOc190DugINFjA?=
 =?us-ascii?Q?8s/Vni3QRgZY62WZlrTh6ZjRm2xPOLKDXlgJpr/q+kFhTP8fK3zNg/HgSLnx?=
 =?us-ascii?Q?LXnEjNQwJ9VyLb9cogePbpthkl6I5lK4OO/ofzusq/0KLk5zKk5FFPuhVO4G?=
 =?us-ascii?Q?DEqWZiSNZLzboGwHlswolFP6c9LKYdVRlrzCfDro/SpabsjyDvMMT3XgwUJ7?=
 =?us-ascii?Q?qKnDnFezdHEksB2Moz9uvrH07hDsAEwv81cpXXv7bvHRwnm9RCjobuW1ZOpF?=
 =?us-ascii?Q?HkkdYTrsbNHc9yAMTxalbig/hAisJd9oV6KW6V8sdJUstlfFpaNXFTW+mnOr?=
 =?us-ascii?Q?KE1bWNhxC76mJj4DF7/RqZR0pE60WVhvMxZ2x6fvbhvoOIi0h3fZMUj+fKRk?=
 =?us-ascii?Q?jVYw3o0sPSlTxdYRnRBrcMgSAB3Y7xZQgdhBRwQ1biZBA7ZTsL3Vupqsbnsi?=
 =?us-ascii?Q?MTk5rw4VFYmBzJkCnHT4kz2/vY/e3yB0BlGjuaGo6gJbfueXHkYcR+uwY7Qe?=
 =?us-ascii?Q?CMurfP53kghFo8XqD/iZLrdIKc679Pp9CEKcxCA8uMu0XPjy0ZWuX/UT++W7?=
 =?us-ascii?Q?iyQszAqBCyKUQrWkFG+T2xq8Yc/5H2IPQFekWhAvr8zOwozoRJlzn7wZ9Nk/?=
 =?us-ascii?Q?jOtaEypHyHuOczVq2wcCq67IxSX7hA1G304jEXbYFbiykpiuASPvue/I9XNG?=
 =?us-ascii?Q?6DkpOGRUtpwM8myfAzlul6PXsdmcbYiD2LkLU7lYhPX8yZQzk8JbUIoJh0Nl?=
 =?us-ascii?Q?LqrOebTCyrie9Y7qyKcLXXQNa/Mhd3b+utiz7XoWDlAiq1sXAPfon5lxlF2H?=
 =?us-ascii?Q?sQWfY1bdTlfM5iCR3P7KdbzEbDQN+Px9XaAOLnEWwA0nsegBp0E1YCHFBZVZ?=
 =?us-ascii?Q?HtBaC825FdjyZ/cPI9UdWTHlqqzlNmPLy7NTVQ3Lunvd94ycPk/O3DFFtQjM?=
 =?us-ascii?Q?QktmWxMHqXWHOSIklU0e+mxwWlz6RCbzRmVnBqIgXyH5QOtQRidUayjv91ys?=
 =?us-ascii?Q?6TK97kSqSfVkqSmqghaBX0wHodrjxQSOxVuzedTUx6ZjlECO4nGn8gNXz8Vf?=
 =?us-ascii?Q?p5IN8Vr4TlzdBO4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 13:35:02.8817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96387b18-8ef2-41b3-06ac-08dd1e9f9c78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8969

Two forms of upstream commit references are used (and documented) for
stable kernels:

- [ Upstream commit <sha1> ]
- commit <sha1> upstream.

These are useful apart from stable kernel trees to other downstream
maintainers that wish to keep track of what came from where. But
checkpatch gives citations on patches annotated this way.

Extend checkpatch to tolerate the documented upstream references. This
reduces noise for downstream maintainers.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Andy Roulin <aroulin@nvidia.com>
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9eed3683ad76..a6c81b38e413 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3340,6 +3340,8 @@ sub process {
 		if ($perl_version_ok &&
 		    $in_commit_log && !$commit_log_possible_stack_dump &&
 		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink|base-commit):/i &&
+		    $line !~ /^\s*\[ Upstream commit [0-9a-f]{40} ]/ &&
+		    $line !~ /^\s*commit [0-9a-f]{40}\s*upstream\./ &&
 		    $line !~ /^This reverts commit [0-9a-f]{7,40}/ &&
 		    (($line =~ /\bcommit\s+[0-9a-f]{5,}\b/i ||
 		      ($line =~ /\bcommit\s*$/i && defined($rawlines[$linenr]) && $rawlines[$linenr] =~ /^\s*[0-9a-f]{5,}\b/i)) ||
-- 
2.47.0


