Return-Path: <linux-kernel+bounces-268436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7B894249C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 04:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8E11C21035
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F771863F;
	Wed, 31 Jul 2024 02:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oqxFhf+K"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2094.outbound.protection.outlook.com [40.107.105.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC0517BCC
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722394553; cv=fail; b=jBzMP2+4ehn/eKd+GARii6LjH/UDg/Obhj2mKHFWeoqgUjhY347pEYAGGANx0noKUadC2eBJ8qr5u19Ti9kD9RW0BNM4uoT585rdEpzgHS19phcO6JVV+x2fdocnfp6tJ2KP64iINFBAkQdhlywEWjqDibTnB/E+atFtkIU70c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722394553; c=relaxed/simple;
	bh=S1B0Y4uEvGbxFUFgu4T2JVkweKEGkHKlN4ggfOkVtJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SzBISdGpXcuW03GG+nJnNpLHhaBbGyrcr090M6P8/9icjOm2FUDJDpVjJDpbwZHY4bUmqp6dKSg9JFt7/+YqASI8x4uSxqJQ/a5Mq6LPghG/HyRXMtqhQBdtjzOvasHA/wEZK/O1IcBWDm9T9VpMyNRzILsyugAtmJtr2mAyfGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=oqxFhf+K; arc=fail smtp.client-ip=40.107.105.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2FEQaSAQFnqmsSK7w6u6Wps0JfR7/pcCn7ijZKBZ5K/L2E12KgNNWhAuTZYClT6NR384ppi3EcN45LUeMeDKJHjNh/ocyGMLi1YCvdTAK5IvpGp5HRCBmLvi6Z6dccQhPAI5TFIHef3GocWjTFlVsgZzV/akqaXEnOGiihAZTQVyB5CFb+XDaZt0prmHaRZ7Ka9g/feI6Oq9Zk9CfVWg9iuwLxDjq7kGf/G7+mM/OXE7rkrdX5Bc6AMPDGfll2p5mVrCCy6nG9tR/X8AuyXdgpCeJbMI+9wzhaCI4I4CWtIdsFMFFstF8RknlfElpxTHmdhEzP1aHS0wZN65P6TsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylIcNosXLCsrQL6Zby7xoIxqUyUFerSwRfdsQ1cn3mc=;
 b=mrpTH+5H8HH+dKjKe9YNh5GEVpeC0l/rdQTJgxZdeEMtwNP6ICf/WTbhduCYwwjd+IYf9wvTIGNCP0RZJxo+/ukesnHzKVxn9C+W7vEnYqewWiws6DSq0aNnelQ4XdpBBa58fRv+OYQYuWAxyKtp7ONyObl5lt8X0uGRetyES65Pb+A7/isqCn/wBuMT3/6RWUReln8gk+PyXYnhXDAJJEujuzLHbS9g2QResF3jclpWUEf3YBKIrt4QaxJzUB9JBDRT3+x1hXS+7+gJBBnMOEjJ2qCe5JD+ElqLvpedAK3P9Ro6SMvwohYDXraukTo7nTPQxBbZqq5aKM9vsUsSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylIcNosXLCsrQL6Zby7xoIxqUyUFerSwRfdsQ1cn3mc=;
 b=oqxFhf+K4ZtFh2rBjKc95dkE1tIp4RAfsRHL5h7VcHHbwp6ah6nGsC6LSvfMWjbBppYGIx6nQaxpTb2QpKhutSnAwr0qGM8gWkNM+Y/yqrq9yEAhqmzAa6twsrJsETj4/sRIetZZvqMJCKRRXfMNRNmGW/wjVNVSF0RjNpMHIXlFjqPoG6abt11qpQHGAvyYonJAlufjy/m8CUFavHl4pzZmLmowIlBLHUqWtHVadzIbo1rDkyUm/i10PAR2sRmZWmEpWxK0hDm9ojHdzX1bxbJdUcU35lUuF00RCaOfbzivi1NdHKRXws2B+2PYKDdF/4l6ox3rXC6OlvUSlQUutQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by AM8PR08MB6483.eurprd08.prod.outlook.com (2603:10a6:20b:315::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 02:55:48 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce%4]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 02:55:48 +0000
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
Subject: [PATCH v2 2/2] kmemleak-test: add percpu leak
Date: Wed, 31 Jul 2024 10:54:10 +0800
Message-ID: <20240731025526.157529-3-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731025526.157529-1-ptikhomirov@virtuozzo.com>
References: <20240731025526.157529-1-ptikhomirov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|AM8PR08MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: a274d873-2cae-4736-eec2-08dcb10c47a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EQx4JVJrCsLTkPW0JqEmsrnrelIDkSGAmTguDFF/5zZ6ytvKZ7XARTf1nNTE?=
 =?us-ascii?Q?dFOk8vzNkGcvIhTL/sHD7+UUp11Bd/B9dfGZSECrYbXzmAn/9uA5mfYB+XO9?=
 =?us-ascii?Q?9Cg+tdu8EDiTMpyOya3a/NujNWucynnL65bxxIz8zlWNweNczAOuKtSOz1qa?=
 =?us-ascii?Q?LWQTyn4fRNlvjZabXuRPMxBxmhSZV93PUH3L6+arnDnXTQ8bRvq9J1SKJKQW?=
 =?us-ascii?Q?tPHCFjkNyqZNW/B0jgB8+a+jLAI5YEqc2oRZSLnDviPtn6pQdzEp3NwEJxs0?=
 =?us-ascii?Q?RuqZ2/LcCX/8+u0z2jEVadxpuRhXpB/WtEbU9sJUqj3XrTlFN8Qr9f0DSjMF?=
 =?us-ascii?Q?2lc0wnLzvIV8rM2wLyQxn5w+NNuepyqCZZUrpuk5uQK8Pkcfzi5ZDV0xJi1W?=
 =?us-ascii?Q?nDCIbCCWeuHnYBr0sFWNdEdzxanWeZ4wC1JPaY1lYMyzpRF/2/rhbQj9HPzJ?=
 =?us-ascii?Q?rT81O0LH6p7vnTNnmcaQHhmymCMEignTZlO4pyecZJOlCRopbJpWgY3/p6Ir?=
 =?us-ascii?Q?N8R6qm3Wi8RyzK3A37SEJ/q2LpeENxvxf5eiIakmijKv/ThEdT6fX2AK09xu?=
 =?us-ascii?Q?T50v/5TW0OcuRsscZiWJae1DD96+xkafL6HH73FBYsOcKVsVNgC2X5BcDpjb?=
 =?us-ascii?Q?Wlc1gxynQIKzAhIdWf9OORf3UOyM+A4QPsksyOPXPuJppU5sMCxqfuHxOxXI?=
 =?us-ascii?Q?4m6Bhhl1bC8+EQqCdpHZb+Q0GHtOw0oiitWEn3TYxf2zPJkO/be/wrKeJgf+?=
 =?us-ascii?Q?/6b/4g1gvFy1ETXEVBEfsiV2NgbNrDPZk4kpqfkje8oEhwR+KVmeIhCRsROX?=
 =?us-ascii?Q?4w1KU8r42TC4nO59mcvDKF5anWqf+KX+vMWiwc+BkJqEfbEgNIv6WtBvDeDh?=
 =?us-ascii?Q?/F4bBQmwwhPPUkrcIjY1928tmsd9JuFmq4sPBXifMS7GB9JwcELyGP4NfVQQ?=
 =?us-ascii?Q?SEnjaMCZ3l3Ay9bnaYQ04a4ou94di/cuGBjwLLD9qwlUfsoSuspnPkK3uaSE?=
 =?us-ascii?Q?0IXxjgjeMxqGQAtenV9YtB7XiROtP0+ogpKawI+MkRvVBwH0dYsXsGV2rA8W?=
 =?us-ascii?Q?YF/Sk+z/B7J070J/R4fhEJfrPMICOjIEINVBpg3u5Y663jbiH/cWNwxPlVkB?=
 =?us-ascii?Q?LbsaWpA+OB55mvIGTnqxmOg95pzdij+UDBEAXm9KCPSL0CqYBcEeM7NY8szc?=
 =?us-ascii?Q?sSuH3MB1n1LyymyUsbRRPOJNGUaAHkqhqD4SorR+FMUjcOHxJbK4VN7OP98S?=
 =?us-ascii?Q?nz0lrgCusLhVRJNx122ae8CPbB7Ry7WP5Dbg0DOHlX+9sj/rTgI61G32/SKE?=
 =?us-ascii?Q?tMVdmq+I3SOjD3GmHy2naKJcDkzUL3U9oMsSY6tJY6wfmw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oMtIFUlObcbRQ+3gBTGXnK0IMEOoJMqJR+i2292dLUY6yUmfwyLHJhSzDlQj?=
 =?us-ascii?Q?ByBoasdtZAQd92s+UfCJNXojhdglKseXfkzUT4DwBpcGLmEFpSvdjFcd4ZRu?=
 =?us-ascii?Q?dJgMcrgtogAbPU+hWRhwVoldo0nRM4Zyry3mLHH/mTYiez4fcFmPolDlsN2q?=
 =?us-ascii?Q?VBpsIbudkafgkwB4sfhhDJCaRbYnljLPz5RenSUEZEwa43GiwikR4w0n98NU?=
 =?us-ascii?Q?Hz47O3HP3y1N61oA0q85GZp7tLRx720hVC+dqq013x8vdVYKJlbloBxa8Qdv?=
 =?us-ascii?Q?FpFBXwVW3xvXie4dUdSY9kGq1KL3iXHz3RZcz1cLL0c65pVnlmT4WNxE6+k8?=
 =?us-ascii?Q?tXfT0Zk2OWoQsi+HkBeFPDMrCST40PqVIhgyuMxPLK96k8y6Ph7tLWpQSe3K?=
 =?us-ascii?Q?95e0Yj0uwjJmr1C0xqj7nTZ6nluKuNZa/1GaVolqcZQELH7Q2Xl2JLUbMf5g?=
 =?us-ascii?Q?MLKXvwiTbeHZYHNLhKb7rW7BYs6DTw8SliQ7DBIkgEkWxvq5UjWRE5NVmqId?=
 =?us-ascii?Q?di1Gm+UIec0BWSEtlh6OWSO6JCWOmOkGbclxldpWJGu4NWwY1sj8aZ3uqNvK?=
 =?us-ascii?Q?7StcHv8EnHGPDyiUOsjqfy49sMR8zcNwWdQDAweO1FxY2CujNyl10DO46CPK?=
 =?us-ascii?Q?l6xYvJ1b3pN6ruaDZ02RynDeYSHYUisQ/+snHSzWcKxuCMCk1c4RMyDdDzoJ?=
 =?us-ascii?Q?ITVuoQ1//XkXar59Xpr77uWT7IhgXqV8JnPfzkJrXol11OFBQfPPtR9vYiww?=
 =?us-ascii?Q?SC+zoWFJgQs4HK/xHOg5nnRCX+CmLazXMK0uZeOkGFVAZV2y35dTSbhqGBuc?=
 =?us-ascii?Q?yTW4vjmxxYsb54+0apOzCXxxDHfOI14ppeLuAsthrMd6Hd4OfvmIZiAZtlbL?=
 =?us-ascii?Q?EzRgZ/MCiAzh+XzHp+2esW3kSeRDGBytnIPpeCAC+fXAatlrMlwKliqxU9jj?=
 =?us-ascii?Q?yhojmRmgbsNkJu7mAE0rEGynRwsks4U6aZrk8iBycrP62+gW6IO3fhtDFR9t?=
 =?us-ascii?Q?TG9HZziAycEZH4rnk5Nm8hjgogwHX8xU86BHyfl7NoPTcXUS3FLJbdrYmUdL?=
 =?us-ascii?Q?j4roPJzb9qSTLqjLfz0fUq1eOTRhuJ+LOKgK5u702ACBC2ngW6N6eAtZfPLj?=
 =?us-ascii?Q?5cULkkDaD0xJsEVW4NSJMmQ4BS0hwyjhvCx7m4zUSgxHWQVmsHBQlpXgF/Rm?=
 =?us-ascii?Q?Ct2i5P3eVbGJeXt6EhkTWFu/HYZl+gvtTiv6xq8rG50OT53WqmR6xU8lorvs?=
 =?us-ascii?Q?WZ2j1/h0QCSbsJW8lt6ub0yik/U9XZfnuTZMc488IJ17vmVo05sf/cucdwDF?=
 =?us-ascii?Q?Isxlav7GNvoHTWeSWs14Ji3WpZpg02NFMHYLt/kavLVN51NNysIRJM30fc2a?=
 =?us-ascii?Q?e715ewVS+ttoagYS+uuJ+fFks4mR/Tw/tLpQyMv5AIi1zjtt/TI0uTJFtGOk?=
 =?us-ascii?Q?oV37lOAccon/N9iWc1CCzhoFy1JjMwspCEvFVtzXPAAq0ZcJRb2cFRz9bd2k?=
 =?us-ascii?Q?x0JU+rkAJRQ1R7Cotjo2Dgq/4VAV8CnJWAeL3jKfVeq6Ikr63HCV2D9kr4uX?=
 =?us-ascii?Q?/B6MyAlVQ/TOOUhKJv6M4xZMQOJvgugtyKrBP0zSUhhLqHTQ2MwnpMLKbn80?=
 =?us-ascii?Q?8EcyaeSYYBpJtePEGWUhCynmTQOFbHTULojb6MyB4shCbzWWMAqVRwHd4Imx?=
 =?us-ascii?Q?ClBAHQ=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a274d873-2cae-4736-eec2-08dcb10c47a6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 02:55:48.0249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsxJwujtg/zUOEvAWO49yX5oZ/BiYyZ3b5JAkFEiC7CxwODBs/ujc+35IIiPflzDbq859YpO95L1xHW9FrEqRIYUnqf+cD/I4pLdSdn2W/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6483

Add a per-CPU memory leak, which will be reported like:

unreferenced object 0x3efa840195f8 (size 64):
  comm "modprobe", pid 4667, jiffies 4294688677
  hex dump (first 32 bytes on cpu 0):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    [<ffffffffa7fa87af>] pcpu_alloc+0x3df/0x840
    [<ffffffffc11642d9>] kmemleak_test_init+0x2c9/0x2f0 [kmemleak_test]
    [<ffffffffa7c02264>] do_one_initcall+0x44/0x300
    [<ffffffffa7de9e10>] do_init_module+0x60/0x240
    [<ffffffffa7deb946>] init_module_from_file+0x86/0xc0
    [<ffffffffa7deba99>] idempotent_init_module+0x109/0x2a0
    [<ffffffffa7debd2a>] __x64_sys_finit_module+0x5a/0xb0
    [<ffffffffa88f4f3a>] do_syscall_64+0x7a/0x160
    [<ffffffffa8a0012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

CC: Wei Yongjun <weiyongjun1@huawei.com>
CC: Chen Jun <chenjun102@huawei.com>
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 samples/kmemleak/kmemleak-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/samples/kmemleak/kmemleak-test.c b/samples/kmemleak/kmemleak-test.c
index f7470ed85a79f..544c36d51d561 100644
--- a/samples/kmemleak/kmemleak-test.c
+++ b/samples/kmemleak/kmemleak-test.c
@@ -79,6 +79,8 @@ static int kmemleak_test_init(void)
 			per_cpu(kmemleak_test_pointer, i));
 	}
 
+	pr_info("__alloc_percpu(64, 4) = %p\n", __alloc_percpu(64, 4));
+
 	return 0;
 }
 module_init(kmemleak_test_init);
-- 
2.45.2


