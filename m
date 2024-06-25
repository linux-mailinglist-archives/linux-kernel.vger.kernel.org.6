Return-Path: <linux-kernel+bounces-229828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BF79174CE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 01:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB92B281704
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC9017F4F5;
	Tue, 25 Jun 2024 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="jEj7S25A"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2135.outbound.protection.outlook.com [40.107.223.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7571494A3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719358658; cv=fail; b=dZWEq4Xp9B8sqQQllBjdy5t135+ldrs7bjtlGHNnDzHnNNOqKHR2KcBsiY9+poHqy2AXmtRiBsABT1FKM4x89C4EYeofZ79QP0sBITCjPC2jjwIHMmxsvfItAuv84iOUI9IPFU1hlL22ZTNSVhmA1Q4wsIEP6CuX9RmcvQYSfUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719358658; c=relaxed/simple;
	bh=URGbSV9KJICzhcWBqLZGiUab6apf7kdxvopBzrcXFVE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WrlelU4ExnbYKj3g9g8zwSmqfv2lLduHSao9CIhcSiBbAdAUr8Fmy3LZBTPAi8ZAFTqdizBEkxWjgy1BHZw2Ev3wydriCuzvpntvn7K64lNiZuC4lq2VjITyg1PZEgLdCJrd0BkK8RiLDi/beilXyvFBDhv8nJDk6cmK4IQxfEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=jEj7S25A; arc=fail smtp.client-ip=40.107.223.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SP1iGQtZrhdyQ+o0IqVbjZDeFsjrSz9xx8QKytV7s/vEdqCxvhY+p5SuGoR5hbIOPAe5i+4mTe51MjnBZoBVxVsuDml8K6jbXMuX9ZgXgHwddrx8qxNIDS/YRfflRA5zNs/5rUqhMp78LdCxqd4vARIZQELDL2ZLoqHkJYL9AyPmJlAjFfkGREGOMYc9StJkEEGxonPKTzH1BA+dRx3VmritJmEzGT02Cb3qNmuihff8SlqngNtsIGcSeieCyaUD4VCOzN3zgyob+SwsefL/Jez5BWCZbJyo1yJdUfL7BKSg7UG+KsQBdmSMdIEEqE/ml/8nrc/HcB/Ho3NfQnUgTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUv0XF9ImHRIc/me3sWorh5ZdrDgeX1depLdT9MjEns=;
 b=ZfYOACOMt+skagR7lK1M43Z2KH+ox6qCcCLHikPcSPEmp4hDi8M7VjbSIp10Wn/byLr9aMSbqQ6y6lqIwTYU31ZSPfyIUvtQtZHn+lYJzSx2yBPAsbQ2kr9aQSpcqSdDig/puJkPHdhGXQ1xanU1TN24P1Q6yJZzafLzTaT5PdrikhKwjNw1jV6b0yzgRCUlxpISeABQzm3XM0xqW9J0WdB5hwgOMEGoaMPz15ZKFHWs4lwOmu9TLBg4YysKXMJ2qqUnBhiKCTmhleBzoeiiJk4kB5mQ/eRGnL1gDHX5y6lefeHNuM+XeFaOJnb1erNW/MunberWY/IKqZhuvLzkxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUv0XF9ImHRIc/me3sWorh5ZdrDgeX1depLdT9MjEns=;
 b=jEj7S25Ab2Rlg0t4EYPwoY18q2dHU+qQC9b6MovsecU4F+sX1Dz8Ain54GjNB44ySY1oQMAQlbrnc4mbTgK7WCW5WjdUSqpfK0WDfTwzUVDgf21pOGSZcRdfxTsghZS/upSXwdfBKCyRYjehnJ+y3Hv8w4Ni8AgBE06JFA3wVMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5471.prod.exchangelabs.com (2603:10b6:208:11b::13) by
 SA1PR01MB6720.prod.exchangelabs.com (2603:10b6:806:188::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.31; Tue, 25 Jun 2024 23:37:35 +0000
Received: from MN2PR01MB5471.prod.exchangelabs.com
 ([fe80::dba1:7502:f7ff:3f80]) by MN2PR01MB5471.prod.exchangelabs.com
 ([fe80::dba1:7502:f7ff:3f80%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 23:37:32 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: muchun.song@linux.dev,
	catalin.marinas@arm.com,
	will@kernel.org,
	akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hugetlbfs: add MTE support
Date: Tue, 25 Jun 2024 16:37:17 -0700
Message-ID: <20240625233717.2769975-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:610:52::38) To MN2PR01MB5471.prod.exchangelabs.com
 (2603:10b6:208:11b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5471:EE_|SA1PR01MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b204756-222c-479f-76f1-08dc956fc90a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WLs4J+1FI/YmhAKz5Fduw8A58hd5scBFbWaer34hOU0M35WTXe90CIDhGsGG?=
 =?us-ascii?Q?WLTQ3eBiM0zFIojTvsrMYVeE2TGen7c8Qibs0aqLbWyLOB5mt+IEhsID44hQ?=
 =?us-ascii?Q?MUX77tETm6hfZZU2BTdbzlFXYiZ7ib+J4stmBfQYnL2e6UApXTaWTT9UXFRX?=
 =?us-ascii?Q?kbFE3TowfzQ+6DzkzfpCow24i7n9kkIShwb4tVnXY/enrEfpU7t02UkvVIR/?=
 =?us-ascii?Q?ad208Nm/tpuMxKbqCm8qjCVz0VUi6f75ORlcjNr5+etDfDSDSrY4ZsPVTNiR?=
 =?us-ascii?Q?QSCZMgk3q0L3JjLLxN8NaFqXcbCPTsG3RVtWk/PgwdUF+RaePCNVmCSl1d8H?=
 =?us-ascii?Q?9yUkgiv9nKLJlZVJQguERXKSINrse1zMsRCtvqS3S0f9JVpr1l+rjoe5dCIG?=
 =?us-ascii?Q?+dkEKz0DtsVtS0DBeNpvtXR6BBAk7MfXAZvL54BIqmbzbUHs/UwwE+Y9nwQn?=
 =?us-ascii?Q?q9PGG1a19lLeZ7OfwFuoOHEbKxIKgFBLtIgyLYlHm82oDQPTsJvmMI6P+AwJ?=
 =?us-ascii?Q?V1B1BzZw2SXI8dksaNlT5b+p1ZAu130eHsbT+eqqMsX2vafa9k72x4xLiItK?=
 =?us-ascii?Q?0Uaqv83/hfBrcRUUbofT076c6RmSxxq44QHTrhn06zb2XRUNwCmi68LSO/UE?=
 =?us-ascii?Q?f3RTpJsZwy7L1l4SOwVfcf0wLSJ8UXvfZP6EE7x1sgClPbwAtxSWnobTWR86?=
 =?us-ascii?Q?+IJbwfUb4Eey7huAlsEFwSRoiaMeR1BdLPsac60KzYkxX8vyzibPEEdV2LzS?=
 =?us-ascii?Q?PA5ej+RzgrvKt5+were/h0WYlG6iauBndrTR9gPxmlVRC23o8IX7HtfgGtBC?=
 =?us-ascii?Q?JjfFBQZ8SrJJJOGCZneFl0BbRdNeexSmONkTdrrmlAYH+zTfNn39nbvP1yXH?=
 =?us-ascii?Q?BceCdlLnc4ceahw68JAbPmwNxxfd2hS9ODJcPJeNPAD9ih3++ly0X3PhFHU8?=
 =?us-ascii?Q?4sv9DU8XJTTnFSfXxaG36dVAdAUiXMK8qKOq7JPK4ARkib2KsXy0q/O+1dDA?=
 =?us-ascii?Q?dH9o2J4jd7UobjDl7tHwowbW+dF1dB5rvbtJgw24oLe+DGEbxKeYUoSEvfpd?=
 =?us-ascii?Q?tez2AeYd+OZm1YyPtsnEfLsB8HRxu4KvL272EaMnuiC8zR7QUM1i7arV49N3?=
 =?us-ascii?Q?ZMv8VVHaiNmavB+Ji6fDb09d83M3sIeODnUioyg9vlN5SOwKjra8X1breWBB?=
 =?us-ascii?Q?a0Kudcjcq7HcpjHMTzei/drCBY9lpl0gCHZJOw+4f8NDNxN+VLHnvneYemUa?=
 =?us-ascii?Q?Xadc+CcqoiIvwyRmIoBRATXN86DOAdltVlz2KjOmNOvuW68d/s4IW8F+aTKA?=
 =?us-ascii?Q?KECjb5/DSg9pxvRkMqEGRSDRUaZ/fjveqjj0/+F8JhNB1mBwbampjAvgsGmm?=
 =?us-ascii?Q?gfHsx5U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5471.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oWRduHwGnCyoV3Np/YzXMlkCKGugmz3Y1sO8Hcy5mozZNikaGzfv89LQukaf?=
 =?us-ascii?Q?36z8uw5++YMHZ/KHsojrd10eWp1MYOlb6ldgeXIVcCTzjOBwebxZB29mleXw?=
 =?us-ascii?Q?YEteAXAMCOJOacRl5jvw5Xg5M0UAmvACrr/kAZsJ2ZgsKIq1uJ0kH6NCyeL9?=
 =?us-ascii?Q?HEDGnZkznLxO3kxW7OQh181JrzJAxic/NDGl6sbGt0SMs9MpWVe9yRb41Xrx?=
 =?us-ascii?Q?Shnq+92WsSpZcNhSfnSoqo9zJtSx/6KJU3Pd3rT8ooaZcrhYXwI2lYZc2pzX?=
 =?us-ascii?Q?WMzWQpqysXHEnmeTpE2lxk0yqNWc4fiSbP3ZqvyC536JlOzthqBpgyrm+mbp?=
 =?us-ascii?Q?PDFraooe99lqKb5Cx0nO7tHfOuxzBNPt7dKETBlM/I8ElYpcM42LiQTwhVp0?=
 =?us-ascii?Q?kxOo0gnZfOy1IFkuxptDbmaIm2xEph1BEfNmI9Kp1M1Jbpc/R69Hx/8unDG/?=
 =?us-ascii?Q?8OTj0TNSbZRc8UjcpwnnxGoDA0vKU0Re+zkkLwJRxJWlYwSah2b/RuKmSJj7?=
 =?us-ascii?Q?cbuKwDTGU9COMIv5ZypCuMG7Y8RxsRNQXztKKXKmSQWJZbFqM/MelddLq1d4?=
 =?us-ascii?Q?jjXwffh73hyjjhK3kiYcU2XWsdV9P9+iHmDCy5zumHWsX5LkNJbK3UA65EuF?=
 =?us-ascii?Q?FsOWXm3z8jXf2CUtuTRcmpPpmbTbjrTEYNlEGQgIOtQSzgZCBLkdS7sI2Acb?=
 =?us-ascii?Q?ATEzOqNH3CvjY5OWHmb3gbK0jX5FojBrjySxderib3J0Mo/xt/7j45bUPjwt?=
 =?us-ascii?Q?HRtg/R7vntgZBTfTroOC03LtaUUMX3GvsXfdXx6MpetxUSElWbyK5x4cCTn1?=
 =?us-ascii?Q?1utYFiQp4DzjtyOFmY/b6sM38P5JmYcxR9CPFVrsIwOdM4GBYk4+/L+af08a?=
 =?us-ascii?Q?u7vFk7Tew1Zz+9T3Lr5q7z4js27EAwgEzj0uHNySUeWTnxROYbMq/jBwu82P?=
 =?us-ascii?Q?Kz0AEjiWUeBkMt+WHfx1NKtJBHX03CGEnUy4enkFEf6wdp/LNhS6I/SYx+z1?=
 =?us-ascii?Q?NVeeU3v5wcbpHSxErzF/ERPgPKuQ6MAayqngaw8/adn+ZaiegUhV+1jkP8aU?=
 =?us-ascii?Q?Fx0EzqvI7vHFGNYAJ8hRg5ENXetCfelr9n2S4IlTIFMHasQ4rp2Zp86rm/0j?=
 =?us-ascii?Q?QSQtSEdtPLx3Wc2ycDT8leNbfXr8g++jqKTt+Gk8J7rVtu4Xds2UD4uAjdqB?=
 =?us-ascii?Q?f1EPlYuX4z1XKtovbJTyYzkg7gsNqUESZUAynJ5zRL63ilWaPD0KDuS4OJmZ?=
 =?us-ascii?Q?K9qbMmxdmmmlw84Ts3Zt8fYNWdBjUPjZp3kCuEurRg6BV007xXHX3WdhZmvZ?=
 =?us-ascii?Q?HLfMTtNQ43xfFCbFivwVU2ixHDQO8KMJ6HAWmmEVNjWYpiVpHUANaQpQULZu?=
 =?us-ascii?Q?Sqk0IGNlQ9DfhjU1EDtlbq3q4jzkdpzaLLTSJJYe54hEoJyEZPqrebTgl4GR?=
 =?us-ascii?Q?PZr2rmnpJcEkzBHt0BZhR6WreSvSmv/iLI2haZAHo2Lc4tL0FQietwMTYl6i?=
 =?us-ascii?Q?imZpNZP+7muLyWIBZOuBTE+Adq3i4GrdK2yFb16yRNBO/rxCe0TE+KzeiSow?=
 =?us-ascii?Q?pRX9IyregiQkjQwxOU5jr1S1ejexSFVcbLgePtObjdi/WvzxF9bNxu7AUc6d?=
 =?us-ascii?Q?I7GZQvtfkLsMUIMNFP0z9kE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b204756-222c-479f-76f1-08dc956fc90a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5471.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 23:37:32.8872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsXVWgZHlriOLBRnj7g20PeJXZfZnxhtHqqPRjPv1Kztpbv+UlGTn20i1S5vnGCR1tDvUIYLQV7yDhf5TJZMHSIjVaJPf8UVmbfg9m/4Xb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6720

MTE can be supported on ram based filesystem. It is supported on tmpfs.
There is use case to use MTE on hugetlbfs as well, adding MTE support.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 fs/hugetlbfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index ecad73a4f713..c34faef62daf 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -110,7 +110,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	 * way when do_mmap unwinds (may be important on powerpc
 	 * and ia64).
 	 */
-	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
+	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND | VM_MTE_ALLOWED);
 	vma->vm_ops = &hugetlb_vm_ops;
 
 	ret = seal_check_write(info->seals, vma);
-- 
2.41.0


