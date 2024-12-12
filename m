Return-Path: <linux-kernel+bounces-442759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AB69EE136
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77CBB164B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DE420E304;
	Thu, 12 Dec 2024 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="jnhFMmz0"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020129.outbound.protection.outlook.com [52.101.61.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1CE20E03A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991915; cv=fail; b=ZDcy1GuxfusHuFytFs6nql7oxdmCWFaLitDOLW0pfsj4Z3Gk5OGTpaoBPWfnu8lKB0TkbBqNcedVtH8CoRtSwfFap6/QAdwYEKsAtGvZMk2EeLRxxzLiy2pqBT6xV/4Vwj38+7vVSZyWq4p6Kzt2wV6RlX9SIS/OMTPhBwCXGbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991915; c=relaxed/simple;
	bh=+TFMEdghLWx1J3J8FgWIdiGohRTBbw+yw3OWrVr2Mws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HGf+FjmhVwCb3dYz+KOx/k2mvocyKvW0axLirKeccFyW1GVEWuqQJl8VfSmW41QU4GLJpmYNCp/4SppRpUFvF8Zoqf42Bi2kDgDwyjTJzVrrkY09/pAdL+G7U7RBL7lcvQZsimrA/nEAVbFUxA/KIE5AjSuv/bdhiI3nJlBcqfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=jnhFMmz0; arc=fail smtp.client-ip=52.101.61.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGsH1UXIRAuJ5l7f3fT81p3FgIkN+64eddyzpL0xHmQUSRNtdqdugSwuDmuI35nXl9HRYPb+HsvwTYAT+cyneYNVZoWzVG8BzTYcRkjvF+VS+dK4XyO7M4umOInsXG59hVbgfiY+dBBiJYTV92cqW44bK/trVTrGGVYpwnlXO6b8s/YfhlKZVEEEdF1tYjdK17mIWHK+B7yHsdiVHM6uh4ozvH2muq6G9N0Ks4ntt/NJb74xuWhUl59gM/pWwZ5jNXZMrYeD8UE2EcUC+JpjIYiOILja8afUM2bhWwWXHirXWYsgBG6awV8XIgbcVaugTi2NJQHdpu956+eIBRKJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfqUDAc1HGc/Eow5ifXnv2NhPtfud4Qk9exkzZ64iME=;
 b=KvEncNWcY1K3xlvqiPJf55ls5YOcDETmWRl9Y9BQO5nLYoHQ6sXNsvUnOMp/rZEhPOpwdubVDxxZKoLjWtiP41alIaEnfysMfD4+RIoGkipsZTE/kfyMZiIbpLqFCnb0wOZmAYGtZ87eYZU1BlRjEhZDvjhqSCpRbGc4M22wUhWBlc1pb6ZxNxKQI6WPN1ZknN5UDQBSwEMc9+NDIpQjwfUd/j4MyMZy6Q1CwBs52MYV4UUv/lLi9TBNVb6TOGIvDvvn14oNpL7dVu5Tg2o31Dc/4EdYAnb/7ardSnmTux7du1JQVEr/wKkYrDFG62SdTHbWqVityalqAu5LVAB0TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfqUDAc1HGc/Eow5ifXnv2NhPtfud4Qk9exkzZ64iME=;
 b=jnhFMmz0G1/O7NUJOQiSZ3ph6JVLXnIsZcQSu78AoG3I2tusEVHT4VUFufwIGscEFugdb1O1iZxKGecsMOIYuZuk4rkfktp3ZCmVn07AGSTiAfkpwwWYtI7bCwkdjV3nbqaiid2PIoGhp1wOQazDmoGtjVzdxAjHqG9EivmqCbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 SJ2PR01MB8459.prod.exchangelabs.com (2603:10b6:a03:557::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15; Thu, 12 Dec 2024 08:25:12 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%3]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 08:25:12 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	anshuman.khandual@arm.com,
	corbet@lwn.net,
	ardb@kernel.org
Cc: patches@amperecomputing.com,
	cl@linux.com,
	akpm@linux-foundation.org,
	thuth@redhat.com,
	rostedt@goodmis.org,
	xiongwei.song@windriver.com,
	inux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v4 2/2] arm64/Kconfig: Remove CONFIG_RODATA_FULL_DEFAULT_ENABLED
Date: Thu, 12 Dec 2024 16:24:26 +0800
Message-Id: <20241212082426.4110-3-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241212082426.4110-1-shijie@os.amperecomputing.com>
References: <20241212082426.4110-1-shijie@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::20) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|SJ2PR01MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 71129ff4-1382-4c30-3935-08dd1a867f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1uXJIaoDRgzZYj0WS91JiQAi+JgxfVb+8BfLZnsk7pHTAB0ut8KzjfkIr1AS?=
 =?us-ascii?Q?aLwy6vKmuCv6RQX9TkousMiuTTDI3ASUYvZPQrq/h3+252UCmTJPZmYbl/1Z?=
 =?us-ascii?Q?NdUAxuRENbCALt7VzS5cFlGzXOIi8d52Ll+CR308k4jAbcbOQZbKzm/n8AGs?=
 =?us-ascii?Q?iQ8DYu/DI1UzI0bI/JrUqqdhd3kf+P21R/bmv+g183k0NhpNXoZFIJzkxyVn?=
 =?us-ascii?Q?t4Y+oIxRRsfQsjv1Nw/KsgoEQxoBwHJ4ED5wlEFCXCBrMuD6/CTR6KcxcDNl?=
 =?us-ascii?Q?bqQCoj3B3vZzpyqOqc4iy+XTbw/Wq6leMIVSaH6X7U+lIQgseeZ70BtITzLn?=
 =?us-ascii?Q?XSqKPvgdqvbBbAtfKPc/svxTN/6gsNvo01/s/aVVk0Kaprl+/RI1U78PvMIm?=
 =?us-ascii?Q?yHhwKxZPLy1mRMT3ivsAUIOL5axR7IOv6Wvkq3JYIrNLiIQnnLLzFelgkVy6?=
 =?us-ascii?Q?2RUxxNWPWWPPwSbeyoqbAbQBvFG9cUTVHlO917WSh4YrhHKpWI+rJG5D4GiY?=
 =?us-ascii?Q?velV4MsVP5LECBiWXk4HPBImgyFXYB8l8boXSX9L5F6C0rBgZrqwime/OIe8?=
 =?us-ascii?Q?ghowuhLKVyA35uXy8YemiP5DZYfn18UuLKhGpO+91ifLV2q+MGfGDRECh3ME?=
 =?us-ascii?Q?tqxb2tfTrKjkEggSleNyGRh6b6pkJvJoyVVGXKdL2mZS1DMQtAPfSnysJcV2?=
 =?us-ascii?Q?La4jqUT2hXCId/Kz/7G6sqwlREhzGxfp2LyRXfcQSDkPB9tSjujjneV7XKdT?=
 =?us-ascii?Q?wWp5k/MEKPsjgJqzlcISJHvs4MgMSqnaxTwOLmkkdmutJKz8XhviucehBjhU?=
 =?us-ascii?Q?BrgYv8MSXVnN5DmwvnXPIW/amW2FkSqwdKYO8iHyunpHA/iskWH7hJjT2Pdy?=
 =?us-ascii?Q?q3tSinGkVyQkecvZ128nKagpu7fBW336+6qU+uD4rYZ0Pd2ypBUuRcP88pAg?=
 =?us-ascii?Q?UeZbUV26MzwRvh1bfHyYqfstgcCo6TdpZ0aXX+qBHOd0J3wdgZT/RzWBj6Z6?=
 =?us-ascii?Q?GwRYIfblGN20v1rBc4lohFtxf3bnOdsWJOn5eK2ZsjK4VGeEtkYi+mE5/cyx?=
 =?us-ascii?Q?ZSgHAQVBCSs63SHwAUaFcK5QjX0BSsdLaW6S/ggfLTGumgPZCp0YNCnGt61Y?=
 =?us-ascii?Q?DxUmI1J0sPQHqcgQZSkmnjXoHEu6gOIMu3PGiaxke8Oq3n5z0EckioKpc0SG?=
 =?us-ascii?Q?SYkyIm3ut+DmxIc7gQZ2aR7NlYncR4vReGyygHn6KcO0s0OOn0ZNuHjV6X40?=
 =?us-ascii?Q?Wjl2oocj1nVib4oCoX3Mq57xkuMrEQMKpG9lezEoPwz1SjM1UBPKuEXhRdjL?=
 =?us-ascii?Q?9SJxaAXhuprQPV5Nf5P9Njt6rk246wmam2Hrs18L6mPUpUX86b2CSTSRSU8L?=
 =?us-ascii?Q?IYpJRA1WtTibtyjGRRRyH568H60RjWk/XET5oxk6jxvK1ioXDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aXMSVZYh/0dWk3/VaGLfGJkMT6q6gmVcoTt3Hqf1zUj5vuaGsE+kqPUc1Xzh?=
 =?us-ascii?Q?jH8c+QT+kMh88uK4hVbOO5MGg0NAz6IfHUwd9CA2Bq3dxhtaLBWnvGrS+sBJ?=
 =?us-ascii?Q?KfA/HAUE7XDyybYeb7Nie/WOcNln/jb6cVD0kjf3WONNB8uyN/coifpLMixg?=
 =?us-ascii?Q?naWitZ4ByuyIjGzaM9kmL3zLSug1Aecj8i33ipTZi6lkuQlp9crJ4LcaKWWx?=
 =?us-ascii?Q?D6VU8enb/qDAVwJSIqxEX6pj3dcLV42iPCJiaTazVoXacP7i9XmvdYPFvPAz?=
 =?us-ascii?Q?Syfp0ljKy3oXI6T3itMWtbtbU+Goz4OFA10TyLJHPTB4VRKbCfsklLA7wvdv?=
 =?us-ascii?Q?Mpz6ScLZnHz3WL3OAHdBeEz+jhfttOJpP8pUaWJMwGXkR/Ig0f9K+nXef7i3?=
 =?us-ascii?Q?xw1FUA9QaFMLZTtbk/U5Q/8aJV8j2TbQdqRUa/UPyE5JjZgkTTggmo/moh0b?=
 =?us-ascii?Q?+W2+epxinJHi2xtarGh3e4MWrZRTAmF/wsrmh25P+uT7Vkm1kMQnLawh1PDs?=
 =?us-ascii?Q?jSrNjT6UH0yhPfn09cv+2UdUEtLsWddFyaxgc3wTaApYMoR+aBF6BBOQudVm?=
 =?us-ascii?Q?I3WzvgLP59Sa/rvC6+8yhnBRiL4PWz0BhA9H9f2XuX7xL+Jyz8ytxpZ/9GsR?=
 =?us-ascii?Q?3AXaza5KqDpyHcGNkVPzlNQPxJEykB+j5PQQWu2pR5JHgIO6izRKSpFh8YUd?=
 =?us-ascii?Q?1xrAeO6kpA3nhUq2bdw7LcgiN1/8oN5IiSGrWD1n5WiavHSg0lO5SAPhrafw?=
 =?us-ascii?Q?eiw7GY3DlLF367M1bsuJw5/SnTgArhzGBdWCbgslIEqYvy64VeVQntXhXKvm?=
 =?us-ascii?Q?RjNdPbkXmGrEV8WkKIiQLalG8fIiPD1lCb9/XNukDznTjPXCenbUg39LOKje?=
 =?us-ascii?Q?OU0y8U2RMcYgvmlv3ZmvKJDCTTm6sL2Bm/7LG0uA5uqfhqFgbdC/utYkQPRe?=
 =?us-ascii?Q?0nKcSDuZYLrIj/aFuSq1DEv7tcSVyV/uvvhetwpNYjcZwNjjteZa8GtUf5Ks?=
 =?us-ascii?Q?Q0pBJixPcpFYctHUwbnwmHK+7n+bBwGI39kwvXSpoBYsCcJyh0nLrbkbTRa7?=
 =?us-ascii?Q?yiwarEHuS6qYulbxUwuHpW4KNNhTiBs/TJVsrrTDLk9P6p/svD4J+9ZMn7Q4?=
 =?us-ascii?Q?pI0rwtglQ7+Bkh1JGHeknKezgPVkwXUEhPBkGC47aefHOSv4j0sxQMwYBwP9?=
 =?us-ascii?Q?iaDoknAOZ3DzPkWAunMfa0/BoXnthdxv4FQCFl9TKG81/OypeyUH2eWR7N6r?=
 =?us-ascii?Q?bDHuybaJVnL/GpzRc0wppUPtxpphG7fFl/pl5XjcNbN248r4HsY23S75L2ja?=
 =?us-ascii?Q?21K7y7JwADm29M3rViUhkcqnH2kgZMuOLPO4z+Z4De0+qpCwJ/jhtpZL+zQx?=
 =?us-ascii?Q?kj+cUkizKhDP0nEUvi6f7u3KCUQYEhWLF+r3qRzk6I9KiSE8fMvbeiqti29P?=
 =?us-ascii?Q?DMqQiMBOUaqsDS6wn1oAxpWS30tnHmAdQtPe/1jmOFmdE9ar1+dYVRnaZc+a?=
 =?us-ascii?Q?SIyipAnIQktECfpc2kZMkOi1YcjUFKgphz0UJ41b8iLLYy29L1XUZS278VQ7?=
 =?us-ascii?Q?zl9zrw7KzMF9W/6Q/3Uk7DHgZ50wYHn8tOUUq4YIuNEOPjQtqpJGCv1cwKtm?=
 =?us-ascii?Q?JqUHwDlJJKZXemSdR9i9dmo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71129ff4-1382-4c30-3935-08dd1a867f10
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 08:25:12.0245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lh9v6/NwlOSillLrEbk90EtPFavjB0s6WRVTgrmfJ10KFW9mgz2oOZz9RS6xWVQUVOR4tuSbrIwtCPhmj888NqUjnQdMLKGGHItSa4X7zCXzVxK48OaEDI4jR01o0Rk5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8459

After patch "arm64: refacotr the rodata=xxx",
the "rodata=on" becomes the default.

     ......................................
	if (!strcmp(arg, "on")) {
		rodata_enabled = rodata_full = true;
		return true;
	}
     ......................................

The rodata_full is always "true" via "rodata=on" and does not
depend on the config RODATA_FULL_DEFAULT_ENABLED anymore,
so it can be dropped.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 arch/arm64/Kconfig       | 14 --------------
 arch/arm64/mm/pageattr.c |  2 +-
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cbfd357f94a6..1c69982302ed 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1666,20 +1666,6 @@ config MITIGATE_SPECTRE_BRANCH_HISTORY
 	  When taking an exception from user-space, a sequence of branches
 	  or a firmware call overwrites the branch history.
 
-config RODATA_FULL_DEFAULT_ENABLED
-	bool "Apply r/o permissions of VM areas also to their linear aliases"
-	default y
-	help
-	  Apply read-only attributes of VM areas to the linear alias of
-	  the backing pages as well. This prevents code or read-only data
-	  from being modified (inadvertently or intentionally) via another
-	  mapping of the same memory page. This additional enhancement can
-	  be turned off at runtime by passing rodata=[off|on] (and turned on
-	  with rodata=full if this option is set to 'n')
-
-	  This requires the linear region to be mapped down to pages,
-	  which may adversely affect performance in some cases.
-
 config ARM64_SW_TTBR0_PAN
 	bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
 	depends on !KCSAN
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 39fd1f7ff02a..6eef08d8451e 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -20,7 +20,7 @@ struct page_change_data {
 	pgprot_t clear_mask;
 };
 
-bool rodata_full __ro_after_init = IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED);
+bool rodata_full __ro_after_init = true;
 
 bool can_set_direct_map(void)
 {
-- 
2.40.1


