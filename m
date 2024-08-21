Return-Path: <linux-kernel+bounces-295055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02352959629
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21BCF1C208EB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E751B81C3;
	Wed, 21 Aug 2024 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LYyD6/Cu"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2041.outbound.protection.outlook.com [40.107.255.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE02D1B81A8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225697; cv=fail; b=JSsTycY6Gtk2oQHcn2nNCuHy72HnlQe97Y8yEMi4XXCQ01MVgfI7pGinZgljUuOR+sWcbcGihUdrltZqRZ7JlGy7GmTITAriyYQOeDx0gixISgzBBHvTbM9LBZI8y4tDB2y6M0gvakB5RpBphKt3Fhof4U4l/s2j6JYujxIOZZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225697; c=relaxed/simple;
	bh=CtxLMMTB6/dUW5jLR7/5Ecz7wiTzRO+KAhFxVJDW9wI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lGI4THVZxyWsZa2VUmHYoea8EV03JL1+aYDRBIyVMO5ML92RRVJzLZKPK/bJ1Ps1rSyrtBhLfTLwbCK51bqsaAnW16QZ8f/JDrVLPT3qsvPWW76pGIibEZM2mBC0HxIiO4X28aqL41dLiF7MOUhNNQiDQQ9ayM/lYLh342Pp3vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LYyD6/Cu; arc=fail smtp.client-ip=40.107.255.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQrSIvnEHee8NBjIpsRx23O8WsqIWjiRc7YVAzp3v6+BkZG77z+2a9jUnXBE7qCeSIec9kiUoL0iuG/bvM8Q3Cy19RvYnnggkNSIhsSAwgSiL3FzLZJ0NB08Zb90C/5oMowAOy2kTGlRb4ZDm2XerNNS3MQjxoLl7CFyiHJlblhBcR8WkE0PCsSHWpDRkBLSYiHXyRLz2DoUKjICdDo87V/myLXE1029LiQ1SyKcsfAqTsHrAH8TCXAIHARypHFTM7yrneC2/aIWdZTEBA71TUv01VZE6UA2vVYpn8jMexbuqa3UUWk/ejb7Az4nPXK3OqoDUPAQNURJxl+BEZEtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjlHy886UxqHK7poU1LcgiOrXCoTSctOqXHZCMV8FEw=;
 b=gFSP8G8zB2+wdgcRgTwiwP7BeHfoLpbyGrM887o3Vkboq//3gHVziOvo27SQwgUCcor0CfhiaKcWtBS2FK/RI0dyge7JlKUjS1pkOL7mcR6f9WKwB4tX7aJiEWL6vXK5VMWbi5fK+gSLeftHk2qNhoQL/CLuaeUZnYAL20zaJnXdfN3yomAGGft2UY//OCNoQDcWEpU3kZzEPRviYAf6Rl4szIKcbGp89ioEACZYn5ckEhVtu6dj9UqOhjmVydNhIzAJENNHj8AmJ1xVoPebZZTgCIjh2r/1VzesM71no6GGw0ZocGjZ+SaBX2L1rREkepVvR/aWOErZ4+xZ3FKF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjlHy886UxqHK7poU1LcgiOrXCoTSctOqXHZCMV8FEw=;
 b=LYyD6/CuEytRpuiD/Kp8ODDeN4qR9yRoFpD75+WPBXkkYmS5JxgucufmIHFhJe2bu6QnmOnMsyBmVVxtIH+U2Xb9RRKvYh5a9gcNna7StEHDbLshCPbxY8aKmOHZ5KEBPcFk6ldpVcvHyOKIOqGekAy2SGBkZTTuDU2tRywl5sJdu8GbD16UIOHGyPQ2WMCYuhthBduL1qlZZwMMqa8xMP9VwbXKWNW/n1ESi1WmGzRhRyovgGLwQW1J87kI8EB/z/8rHSxiYkgMj77T7oTWflIYsAes5zasZrkMgkLmFwuThWMWXq6nRh0ZloTx9hhx+uFwBbH72WkPCOQCzybfWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by TYUPR06MB6052.apcprd06.prod.outlook.com (2603:1096:400:354::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 07:34:52 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 07:34:52 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v1] lib:Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
Date: Wed, 21 Aug 2024 03:34:40 -0400
Message-Id: <20240821073441.9701-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0252.apcprd06.prod.outlook.com
 (2603:1096:4:ac::36) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|TYUPR06MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 860c50f7-79eb-4dcc-d304-08dcc1b3bebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?69nhY6GBZh2ichR9Ca9yUBYQDq/H6KxJofd4Wg8z2DGvIotcGv/QlK6L7tD4?=
 =?us-ascii?Q?NIL1aZkj9Ijb1Ofg3bjVel5QhhCnos0r1p55MJ6Z8PFYCB3w9CLxbxN1Cxkx?=
 =?us-ascii?Q?JTgdAlHAu39FgHpYGZsh27rOATY/KueDCcQ1OII4HTFsPhIhTXkfJZ2odAch?=
 =?us-ascii?Q?vBeEkTv03oRv7caNOthrZK2l9FNMsNdYa/TEKkMfinNse7ak/vkrZla8Py8O?=
 =?us-ascii?Q?gG3YWWsbxKy+6odtUPfqeA7dnYHKlRiEEFr1AIK7QnqGWqKVbjK10SYXT5uv?=
 =?us-ascii?Q?F2QMB5GFch8teAVmUKGLJfqb5j0oZZ7Rn7AfEDvllgNWPQVVftiHKNXXkUh4?=
 =?us-ascii?Q?FGeAhvXEjOjVO5Emto2WKzNiPbFRaXLL9mGgQoFnzLsuWBJfBvKeRatRh0Ed?=
 =?us-ascii?Q?Ke2iByMsCr5th6Ja+OYhzkVwkUUeX65+/R8wZd0fvMicT/0NR+EK8upsR2ut?=
 =?us-ascii?Q?yH/xR7exR+ZLBkmOmfV8G1pvtua+DepfweZO7d5b45u+d6W93PV2VpH4OW3i?=
 =?us-ascii?Q?RiwUT3jW3AWFLKJFJhMRYut+LSvO8eKPpcwPmTaSfJ2Xe19yO+2vXFwpnRVc?=
 =?us-ascii?Q?vKcpVNq3RByYGQ/sgLil3T0mXBuauunTBYi+i8cBufa1sSNv/ocQEsmeJpSG?=
 =?us-ascii?Q?ZkELTCzSC+lQ+3K/KzSd1lSavr4gfJh4wGvMVTS2B4mxBbm6Wogs+B2lL54Z?=
 =?us-ascii?Q?kWsmjxh3Yxj9+5I2JqmPxbjgtIOnctTOGAs/gNWDfboicoWg/JyTOsyjMRck?=
 =?us-ascii?Q?GDkXe/r0wjJb9+iZzzh3E6v3ACInH8H6qd6BYfEBX/70XAYQy3cSyR/0hX3g?=
 =?us-ascii?Q?pqeSRJv7AP/0zDo5kArF8D8O8TpJTJmKqChzL3SpKftJ3gPFI/JSrjwH6ZLC?=
 =?us-ascii?Q?Xhdkat6lBhsOa1dqnCnJsnHqZuXZsHSp7sTPUzX5ubEutxdOc1zKN96A1S9I?=
 =?us-ascii?Q?X60XR52EwEnlRACTLzVMqR3bZVcl1JtpZBM5oR2SQH8fcjUc26xd64x6nTsU?=
 =?us-ascii?Q?Vz4JcFt5jZhV96/0GtV+DynhPpzWNBX3KXL3x/QHD86U/LK1YcsHeAp0ycBG?=
 =?us-ascii?Q?+UQVAZ/SeXtz+B+seFOFU9wW5UF0DTr+JEORMvj/etu8lvNL/7Ue/vIzJmWh?=
 =?us-ascii?Q?jgdR7o/pOq7mHBq+RiPnhHgQBbU1ARLwAH0Q3HBz5EKpCHwxO/b4wGlBH+Je?=
 =?us-ascii?Q?/0yN5agoRLxFO/40FsRs3E6i1nJnevxAIQURGdVhmW9bXaoWE+4PO0ltF7NS?=
 =?us-ascii?Q?q+84m4NljKt2ABKAlNKvj8oNkC8sxwOHihMle6ezPeERr+Yh8pZn5IiElCdI?=
 =?us-ascii?Q?l6XuNbQE/iORhBU3mpp0zXbsrHV9Q7SH4sIqRKAp6/mgo26XYIgyM2VZ/16J?=
 =?us-ascii?Q?Ob1+dKJDqWnMNmskDeBXX+GoeLC65Lq2N5VsfBjm++39qFWFyHB79z+KMtBS?=
 =?us-ascii?Q?mYtK21SMo7c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qz0E8bc2qqKovz4YcognqJ143o3vS6tu+WTHBTQcLAHzovUzP2I/uUAxIXMk?=
 =?us-ascii?Q?gPawqPpBkypeTBQwKCDwLrKQ9E57PzIjS+Q0cbGX3XON/9OIjXMY7BTZnWLs?=
 =?us-ascii?Q?AOwoV1THghuWwqMUNFyvVI5BsPUpjs3eEhWRI8OWe/BnkHNZlTB0tdwDztJa?=
 =?us-ascii?Q?erce4fLjt52GmmiTy37GdN3btGTG2g/l+adCGEYHgTgCkR92kz1RrxrFEvt+?=
 =?us-ascii?Q?v/Q22tTqkLPRK8JpR/Vh0l2YQ0UzZlXaAdgzyJBl6mtEH0SSdR4mxHrZZY7r?=
 =?us-ascii?Q?sZqy10XvtgtlN2tS24Y402PbKYriBihocKluYGS8b3up8KxeBcpwDAIFkhZt?=
 =?us-ascii?Q?LoA2+y464Kpv7G4389njlqieOwLLecUGFeJ72A45Moz8LV6UXxPHMHcFYwAL?=
 =?us-ascii?Q?TazEeXBksNwy9g09+qOuFl8/TB5FnshnZhFhHgp78taGwMBOmyFiDIhwMFQR?=
 =?us-ascii?Q?f69pO5h10u4OXT5L12HPfGX+G+Yr3tux0gdLB8hxvFnDPl5hs5vOs5gSK990?=
 =?us-ascii?Q?nFmmkyhF+bJiPmlfLr8lEUGhWJ8hmcY8QFL3vI+nf3GUbne7RyBLG6Hl+9P+?=
 =?us-ascii?Q?5x865W03jrPXN87kSmgCtNxC7K+7eA+KgPXibIQUlMh+8d3Lu39BW++jSWmu?=
 =?us-ascii?Q?xQQ6/z0TpHkYAUBx2d9SWduM5UgLLSljFg0intI2tmwogs/yAij9ZV0QWwoe?=
 =?us-ascii?Q?XxTonOCpN91deJ67YOQHmCoyogyqUe90Owoou1Q6cj2ZpOSwg9w/FLrE67wq?=
 =?us-ascii?Q?ZRYb8uXmujUOuCZQAlj3eST9iePZFJlOW3xXgEHJPlvDpdrZt7EpTYkUM5jH?=
 =?us-ascii?Q?N4tSD9gmVJknpZxnqZaoQpporZUlGbUrZvZIiHQT5XHFwSgAK64V20A1adAM?=
 =?us-ascii?Q?7VNUW0LHooGwk4mrDkfN6qB9F5vjtzKfS19dzl2akxe79ijzER07Lfntii4A?=
 =?us-ascii?Q?f7TI3/DB43L3TOWVILfu7TWk3HVZcmGli3lZHUlgT+FzP6qp7Lk9eYVd+C1m?=
 =?us-ascii?Q?yQ7t2qMnQWTNwa+NnslLnHRL1f5KsMFv4Rosf1FMolvo1qoPrvK4dG5M22Rs?=
 =?us-ascii?Q?DMJcRg3Gd/wYbpJJcsxosQDwtzI+XpaUmybG/9FadydVBIWyCUL3jwJttpXB?=
 =?us-ascii?Q?qv2UxZsqgUUZdyGnUusVSHRvOhyFWzqfEgRu52R90Mgbjp5k/LEcfevu0JXD?=
 =?us-ascii?Q?7idAFxq+ywpXzYplu48qxliF+ADWgXt6VMORDkd9frNJMb8ZGFemMZ3Ow1b3?=
 =?us-ascii?Q?2F82CimxqknToBibQHdH5KXc8XbpyhL/LMtks9LapmFuxsbJoWZeGPECsHcf?=
 =?us-ascii?Q?t/6/HcbM7jlo7oDWTIA80nzFOqk4a5WxGQ3K07VngD9hOW8jr2821WdbDlMs?=
 =?us-ascii?Q?ia1apn+1hoAEX40wEMYL2asrXierxa27z6jCcGf25JQLcLIqYfyXMRt8ouCS?=
 =?us-ascii?Q?OsyP4+NlqepuPXYvT4FIEnhWuotmh24e8jGBJ/simMR2oej1Yx2wmXtxEfox?=
 =?us-ascii?Q?O4IhPxkKl16/UpmVb9KhSrNPlJM1l37wQOFbP6UB6FnhTW4q3rRdJf83nRGo?=
 =?us-ascii?Q?NgjBAAurB3I6cAo4aoTDtd9wiAAC/bDw3FrR3uOZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860c50f7-79eb-4dcc-d304-08dcc1b3bebc
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 07:34:52.5300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iacFr6y3VzGh5rWU75z0dnYgcKzlY/+Ot2G1DK7lnhyd7MYMkzojowFuP3mx6CiYd9V8jrIU649RTs7HBqjUdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6052

The debugfs_create_dir() function returns error pointers.
It never returns NULL. So use IS_ERR() to check it.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 lib/test_fpu_glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_fpu_glue.c b/lib/test_fpu_glue.c
index 074f30301f29..c0596426370a 100644
--- a/lib/test_fpu_glue.c
+++ b/lib/test_fpu_glue.c
@@ -42,7 +42,7 @@ static int __init test_fpu_init(void)
 		return -EINVAL;
 
 	selftest_dir = debugfs_create_dir("selftest_helpers", NULL);
-	if (!selftest_dir)
+	if (IS_ERR(selftest_dir))
 		return -ENOMEM;
 
 	debugfs_create_file_unsafe("test_fpu", 0444, selftest_dir, NULL,
-- 
2.34.1


