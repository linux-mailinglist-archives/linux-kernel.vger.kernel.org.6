Return-Path: <linux-kernel+bounces-261730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C6693BB68
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3211C219EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CB817C91;
	Thu, 25 Jul 2024 04:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="V4ULh/ho"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2101.outbound.protection.outlook.com [40.107.20.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA37FF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721880776; cv=fail; b=c7CUprbyjlsHfzktr8NJCeE+ykPAMgnRqofYLgYqBTMOxqYAjr1C6V/7I092nuTTb1qmLij5JU5xOOlzndCcYLkrjKLlcmRjSgp4VdnildN4YPbbBi2KcR0aRWJ9DeTWZQXG/a8/Tv7JxpSlOJ/XOmJXJyAIYiirBPZ/4rTg0oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721880776; c=relaxed/simple;
	bh=amum14a7u82OKOFkd8/jGtEKb9SuvdtTz2SmVhkmN48=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RGq5oI5vgczA+cwf2Px7sNaXBvBy1Hez5OgkMXzlhUAIwnVAKXFFBGS9qp0gF7O2ItbH8UUejTOu5J1Ps8XmXp9kYLJL35jdw3CcKnq6fS1ZY9cnh33K6s9nhmS4ouT+bnXySiAcPE5EDE14kmAM6Fbb6bIUMkOIWbnDlCDhGrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=V4ULh/ho; arc=fail smtp.client-ip=40.107.20.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHDjKxgBSTw5rIil1Ceu+q/+T70/uOqEJ/rOU6VsXMg34xonmMo5tfUUzAHdrcbiMhFWYN4l3kKvhoab2P43+U3v67BVeR56PheoV4Meh8mESQx8ywm/FDxONYJKzAy847ixod/GaEvzPjHA8IgOp3EkBf8faVhD7o6hVe6dpoVf1wWOveCSNnA9aPmhKw6uTAVfkAGBnAla13O/KKnEyaJo/gTYM/h1bIIEhu5gYeQ/vLBJU4VcqtD4jC7Vfg4/1zhrwaAACEIZnmhiXh26KaYZBE1+XgRS68uS0gpMH3IT3sLiD+Xl01HoIGPNobwZueXPZq8INWzv5malpmDyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRODul/gSalLQ3/wW/OJKz9CCCurFC9o0jhqDChdRNc=;
 b=qghyS3QqegvC4qP+0oBnO8vNz0S3Rg3/QmKzgLsss/oaLvaANGxTxv+GJXO18SSKeGHk4mKa/7TXt28CZ7BskPy3xEM/PfSdRSLNmz2WJoQJCrkRbE9tQQxqcL+Q5FlJl5PeXXP2lyk8BvmMlZn/WCXDlAp1uEqG7ZleDSl3E20dtwBZfDUSoDt8Zb7FkX+gR5/YhIiNAlD98SiP7KMRT+p7m33HnSGncDN14W/Zbxu+9/KnUSzh+n5di+fWIQ0AGR3kw3h2IvyVOJmD81SXDVGPkm0T8a41aXtnjavUorjlsmxPD5KLz/8i487QQ7l0Z4tYHxeJvkpBRMbX+PlfEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRODul/gSalLQ3/wW/OJKz9CCCurFC9o0jhqDChdRNc=;
 b=V4ULh/hooyNySEpf8iu5LmZtBYtlspYljMRIGCqiuuOXQWnVViyGgt0omz4MEuucgp0S8eoxnSz9ZcQeRrne69MKukxZK2TWCnt118HgA1XockzJrP1Ib2M+3RcZtydlZ0Qyhb6fBK2AJV0J1Pw1QFW3+2deHSawP3EdfoIzBpy6d3A+I/saCj7cryY7CMBla6/KL0wGNucIDr7wGcihjs/QO0/4/rhNHEgmVMt3jTLUboJFOs3KN3hU+lHTm0r9Lhz7UJ9kBvZ6PWVNIVfl6+d1IbGcik+SwIH2lqn9/vLEyFeks5DXDnr9SULzppok/NFiDaNKMvMRRjGzHerOEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by DU0PR08MB8788.eurprd08.prod.outlook.com (2603:10a6:10:477::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 25 Jul
 2024 04:12:50 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce%5]) with mapi id 15.20.7762.027; Thu, 25 Jul 2024
 04:12:50 +0000
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Wei Yongjun <weiyongjun1@huawei.com>,
	Chen Jun <chenjun102@huawei.com>,
	Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	kernel@openvz.org
Subject: [PATCH 0/2] kmemleak: support for percpu memory leak detect
Date: Thu, 25 Jul 2024 12:12:14 +0800
Message-ID: <20240725041223.872472-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR0401CA0003.apcprd04.prod.outlook.com
 (2603:1096:820:f::8) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|DU0PR08MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b14c78-ec08-4e08-b715-08dcac600be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bECMjHTANI6D3AXEwki+JqvDF4vwhePn0HTDAqM8czGABgHATkxtk6+JXQ8j?=
 =?us-ascii?Q?o8pYdlQJnVKKNBmJCP+89PiXs/Tf38JEBHQziNd3YgrhLEiRw0MZ3oWFLVOP?=
 =?us-ascii?Q?/2vserIutgdsInD+s5ti6NW+wvPuLVJAlUQzuDNO4Mv4w3m7xa+RWZwM9G1D?=
 =?us-ascii?Q?vjYIWJ0PXC4SNH3S0eqKoIzPORJQTbkfWEvWPdLHujpeysZndQYLFuKJdQCQ?=
 =?us-ascii?Q?JU6ajyHzpX2Fh4bxTmgM2D1z/n3wboaDY2wD4y6U0NZuQKqFBT9kmuc3/EOn?=
 =?us-ascii?Q?Tn9JVQevrHZm2p5uaE7FziRUGaKyyu99OOvlStHmxAhkfuznNiYZbtla8eGP?=
 =?us-ascii?Q?7nAk9xMhBrXWdKOk99sHEYzzFdXIi39Xe8xcr0Mt7W96ZLQPGfRrUGGEiyxA?=
 =?us-ascii?Q?0zLKl3EAM3KdeVpHzPwDdb9F+7b4WuimnO2VxqE4Q8zocjcL4WFrb7dZ3OFw?=
 =?us-ascii?Q?IhAUJIe5zdUOnMy38TFQ4cKo0gnqipbxR6rr+VjVszO1cC0f5bqm5ImwWSFl?=
 =?us-ascii?Q?gZu0ZgpaumLe2uGYr9tnbSLvs3nAFfIO2eLQCaS4ncnJzjkICtwFEH6f9kU7?=
 =?us-ascii?Q?k7egqHDTFrCNlYrf+K4utynk1M1nWXQfgigsBKZMoJtO3Yn1nur2Ix863uGs?=
 =?us-ascii?Q?PgfxWaEymxfWAhApUpXIEIhp0eE0ZN1m7pRfQ+JyE9Dl9D8wNBr+BHMyAUKN?=
 =?us-ascii?Q?4zUs23Q8SppJ54WVkH0UTA+fKHQgf12oid1uqmn6Kndl+q2Qh6h11saOmQNY?=
 =?us-ascii?Q?w+4Va6iv9Hj+opm1uj/bwqy+danloderOV9wJF6B9KES+/+Nz7BhuvxelNra?=
 =?us-ascii?Q?bZfilrw6V8XkfeOnqO9BYv3CCIjytrSsxVKOPAMaCWwEmNAVFRQxL84b9wUi?=
 =?us-ascii?Q?pdXfW6kuxOFQEufo1t/JEV7KuR1PuT4YNuO5qUBREqmtBpzr3HkxAPRuygxP?=
 =?us-ascii?Q?CVb1Rnmbopkz/DWojGVogsEqsE5gJ//o4YF+ptqTmNfehnNsVFEtLxP4ROrq?=
 =?us-ascii?Q?AAc4lxyVICbL8e00sYtGAF8Z3PtWEaTxm2HJQRxEF+E36retXc25IdZdSyy0?=
 =?us-ascii?Q?pgFaxmxKOnE+SrWtu8nIB4TGjEiYBZO4WSJNgs+2YH6CSTWJN0y9ZPVUSGya?=
 =?us-ascii?Q?ZlYeBzD6ViU6/FBnR0z7DYOZUL/EZ1UQStlR80CUrFS576AxtkSlM6MyBrza?=
 =?us-ascii?Q?pHW9ScfjVjYYrh5+jWW13WYzDGyrWteN1YFF+WAdHk1ZaSqVeGPVgncKhoAe?=
 =?us-ascii?Q?hWA8+l3fRQXS3/7t6tLAtlXQ/wJh7Av7pzGc0whL68rdoQhawwPxL+ppcTNN?=
 =?us-ascii?Q?iRo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pZoGs2r4z4UeXiQ797oGPAJH9H3uS7D4qB9Z+DH5UULbJM6lm7Yux4YqETko?=
 =?us-ascii?Q?4UwYpztOr9T/ulp7Id0k9fyMTtCokdYjlL+FISZVArjFAb5AcrlHZpDiko4g?=
 =?us-ascii?Q?O7jS/jYYr0raarcsxR3XcuP3Pc09SRO8Qf+jombzYNxaaGIZVCc/a8yFke/z?=
 =?us-ascii?Q?MKAgSPybHEkdk2cfCHEbP98EWaBdg5ftiIjZTgesREsmFLceBiYS8LnDk6Vv?=
 =?us-ascii?Q?AVt6//3sTg4OjZyiZjNh6ZqCj3BENdeJJy6OFGUKuvvHs46xbVeFxsOGY2NY?=
 =?us-ascii?Q?2Mk4tjUrJ7lqsGfVk/s5nghuces9QLMmtPNruq16kNSej+T0LCbB1wEOehSi?=
 =?us-ascii?Q?hO8n/w2RfWmXIRkSEYHbTq/EckJJu49laFoTEGYyTtYxxY2wQhwjJ8U4+gRg?=
 =?us-ascii?Q?Zc416ykKKp1QAGqU4zSzQMZTe1XZcRk8PtmIxfNb0LnawUfXosLrcrIFf2Kw?=
 =?us-ascii?Q?OHkKylnCQcxJUvhx78wyH1Xy+eWmahJqFDw9UpOQ1jBcGzz3OhwfDzR7lFKI?=
 =?us-ascii?Q?vq7ORts+3F8GcCiUopMJ214acCFkO7/GjDiTOKgVjLc3T+N7Maeyf4YCFuO4?=
 =?us-ascii?Q?ppc4Ddd9Yhkia4j0PuJ/uuTVbcnGYqAfwTAmn0fb4tROjJIX9DsfSnkppMqC?=
 =?us-ascii?Q?74ZXY42MzIaY5bYAruuQMw/o7RrGWBYxo5/TryvXfPL9UtROCF8LUmhySBXm?=
 =?us-ascii?Q?hamjtUeCmWrBH4XI0cvZp3mnaF4VLIuZJ7Gbjz3kCmoHTKbmQ/f/bFfG+e2p?=
 =?us-ascii?Q?acqgaiKA+kQ/OCZqklZ0jh9rW6oMnNZz8/ZUlsSYAKCSuVQZjQcKhDl5wVmv?=
 =?us-ascii?Q?yHnCUhj4vez9VsIbCTwVfAjVY7XjTbRwT/BAL3M1Km+uY87exsyhERoKtPUj?=
 =?us-ascii?Q?onrnRJmYxjih6dcrsqf3M6spAxc2N1Xm0gpJrMlFYTykR/o8ViuWlGUwB3e4?=
 =?us-ascii?Q?4urakdawnsfDs/DsrjRH4rnKmu9ZXkYr9EXRfJysWBZqwcqXio+5g9tH6YWe?=
 =?us-ascii?Q?M5UcBpZH+gUvuFb1BLJln/GwwSywfVMV/T6oktVjCFGG8eKpkLinKZlyolDQ?=
 =?us-ascii?Q?9EGjSP50FMwh01rwzn0RDl1PisJnX23gs2kT1uJ805aDNR59AFloXpz9Jv5h?=
 =?us-ascii?Q?Hxn2sIzOgneVpPjsPqcQSA7rJ8WFSqCv0WZc3q5oZHgSKvk6c5hc1H1L01YZ?=
 =?us-ascii?Q?GzjRiaRUMy6Se7jLaoEx3JPp3qKumzsfXPkEDmyKNiR7X3E/TQPKsYZTMZ7K?=
 =?us-ascii?Q?puAGKveNnLtUSi8zl9pwuHCsmVlQT6jUbsMIWncyNhpuq429D4vyBVJwN7M6?=
 =?us-ascii?Q?FWJ4AWNv/4RP2zjuKdAkRejabCF2xirmvBHFV6PwDwG5Q5uRC4yuzzpiw+yV?=
 =?us-ascii?Q?hTUhEX5B1oJBNAU1+67Lq21FTOLJ6adH85rpREH+uTmj8FO2mrTosHRGxhpo?=
 =?us-ascii?Q?fx1e2xe+QTeN8HWFOMDLFOMEXJ7vJrGcVX1AQIE1Mhus4rbbOCDFExrlPYnK?=
 =?us-ascii?Q?CWGHD69f9JGGTw8S30epXilp+rHbbjqklXo0lIPXYPHZXOch7YdazCOImrc+?=
 =?us-ascii?Q?XSwe1PVgRGpBeKeQwnHJWku8CgOZFfXNnB3z1lwBqU/xVVriuqTBM42ZJFet?=
 =?us-ascii?Q?EQ6QoDBYyNkqP6Rv+VnzCvvROcsuadEBcm03qahW96Nbn4r30bF4G/V9mvyM?=
 =?us-ascii?Q?C1KmHA=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b14c78-ec08-4e08-b715-08dcac600be3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 04:12:49.9328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFV+NScWCIqI5iRBeaxi7uzfo6G2OhCkZvA8NUHUy2QGrA2vPPNjLc4C0hbRL4Ucv3juwNO6iMTOcowqzRCwcQIDU/NG+hgjkESdBtH1YlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8788

This is a rework of this series:
https://lore.kernel.org/lkml/20200921020007.35803-1-chenjun102@huawei.com/

Originally I was investigating a percpu leak on our customer nodes and
having this functionality was a huge help, which lead to this fix [1].

So probably it's a good idea to have it in mainstream too, especially as
after [2] it became much easier to implement (we already have a separate
tree for percpu pointers).

commit 0af8c09c89681 ("netfilter: x_tables: fix percpu counter block
leak on error path when creating new netns") [1]
commit 39042079a0c24 ("kmemleak: avoid RCU stalls when freeing metadata
for per-CPU pointers") [2]

Pavel Tikhomirov (2):
  kmemleak: enable tracking for percpu pointers
  kmemleak-test: add percpu leak

 mm/kmemleak.c                    | 153 +++++++++++++++++++------------
 samples/kmemleak/kmemleak-test.c |   2 +
 2 files changed, 96 insertions(+), 59 deletions(-)

-- 
2.45.2


