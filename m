Return-Path: <linux-kernel+bounces-442757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACE79EE131
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D232F1887666
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29A920CCF6;
	Thu, 12 Dec 2024 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QOqUfqwu"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023090.outbound.protection.outlook.com [40.107.201.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3330D20C48B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991909; cv=fail; b=UphnQGALxp6gFt7YoAILziuC5aI5i2vl5ByeQkrOOas3Fk5Pg76V0RCu0LNlx8IO1mIHhgxaeqFr3mMiAn4sjkZnCuySsVxw5vG+F2JG73D9fZZzd+CGqYrRYnbMXDtwAGSPlaXuxaYrdLavRp7sueoYoKccGOxWjtOoHusdJ+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991909; c=relaxed/simple;
	bh=EYnS9uOEd6dzXMo+uncnCUmduMS+ehFTzgDBMF3tzEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FuCVwN/dKFhKJj9uu/UrIZMrebICcqsMAnWA4eV77PGtja2+q9oejFs4kw/Jyp8lyas/NVrbb0Gh014a5IWiBWRHXU67eKK/zbr5J9oLtC8+VnoR+f053xTYnVXAvlhEKgYf1s48BtGbQlhZ6pV9nfvfSsPK3nputwbhVutUL0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QOqUfqwu; arc=fail smtp.client-ip=40.107.201.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4logDEEB6dgAp5t1PifVbYLqQ8cl5cKZiDWDluKInV060+dB1Oq2P6B7FmY5ckc5wVTXxzVUiOQmwxrgCm/Iz67c/dor7BzaKIcuMZ4S1f3jP22T+fOKrNCq9Dai3nrH0+yg37j9adXhBjL2VWlAtqKGKpslUXLtk1LiQO7fJaNvSytR2MN/DAGdLifEkAMwevb075rI55HxLDrjTj+4+eXVwbzt3pznPUr3wXYXaWDt2P1zhJ+lEIjJvd6NYmMvddS0dk2GmY8WQQhuGkzvdr16orGUQ5Duw3yydhV2OVOEFLTUNCj0yG+iM+zJUV2LeTai990W+mmJ/11F2xs1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHTLca1a3DMebjt/eDGzKKdZrQWqh1BRI3n2PJX+MxY=;
 b=sj8suACzAyA53fD1p66jQe8Yjk2+OWwLHkX9zPvYSEiPwRTVxSC0I67PZqUN8HU9EOMbbxrYgpMF5SeTiWtzIvzybR/oO8rgrzVwWaQs90ij9GQ5N5qnstUB2Pet+NHu7bLbnviKWoh+s0FCSaaE7TAsGUuMBc5i2em86OEwTNOak2JUxvvDgEhAHCfNfzTUeRh1tyR2IwmDGr7TMHcXheVesw6R5Ees+UvzIiEdD9RTtesqmET3HHGUBQX9PvWSXTv9KMh05+Oqn6hL+gFq4qgZMBngOoHMQaEA9NDLY2Dg6VuTAS76kMmOCZMDjCeChk4nPXaHiptu3wMSoWm12g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHTLca1a3DMebjt/eDGzKKdZrQWqh1BRI3n2PJX+MxY=;
 b=QOqUfqwufUshNAjCI/AmjBqNTSv1tQWjvXfsuhe1Z+5jPtf35SaP1b5G8WRWpZNqDwHzAB07/HcXnljoUWI4OCTUaTnu3/Zd+ieYwqF7qY/MOziTfo8HTqRhHLql9xWxQ9tSbyFJKgPnLumj8ZMtDpfsGykE/GD5B/4hJ5ysj3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 SJ2PR01MB8459.prod.exchangelabs.com (2603:10b6:a03:557::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15; Thu, 12 Dec 2024 08:25:05 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%3]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 08:25:05 +0000
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
Subject: [PATCH v4 1/2] arm64: refactor the rodata=xxx
Date: Thu, 12 Dec 2024 16:24:25 +0800
Message-Id: <20241212082426.4110-2-shijie@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 54b6f04c-ea7b-4718-fc88-08dd1a867b7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q3/x0CJ+B5ObhjlBpy1AUox4lHDWL+ft7qncQfawbJSnCqw0zQgWNw50BsWJ?=
 =?us-ascii?Q?7ELf5eu5AJStdM8C4oz6kVHBE/DnFWU4XFlEpSujKfcCLjI1RreFwM3ngLLS?=
 =?us-ascii?Q?AV60jvGWNbEQbYO5Bwnb5auf4QQ3JopGgiIz4cqySqFU1F6jQVNjPDIHrDmv?=
 =?us-ascii?Q?Htn6D2tHfiKEBRWRdkTUUjmmzbo7JR55aVBFalFITOPE3d4U64e+T3yTTEUL?=
 =?us-ascii?Q?rojzc6EqgQ1pOQ6FwZF1kWY9lu3raYaxQFUfyhno8Z7XRtg/jQGrgfFbgAQT?=
 =?us-ascii?Q?oNiXI7QkY4GYH3HrEpgQcdizYNQjEqVcQkgvMZBF/E53NBhFPhxY4qFKz7zw?=
 =?us-ascii?Q?Sb0y3n1ZNVAYZphs3ImAqNqOAttj+tPn17jOW6sW6RcYhkfBTLJvT1ZzI3/x?=
 =?us-ascii?Q?VhJPhYiS6SgP/kN1bWBfOuOgRqXRtHgnuiGBTyYlVVg9uEvy/xXtjabXHsNF?=
 =?us-ascii?Q?JH9gb84DYIbgqH4KjFlptl+FVzXjLIPSG5T9eZu/0vBwQSB6qCAh9OBHPYxX?=
 =?us-ascii?Q?JkSMS7OViWIgQAM4tPmZqamr3ZPW9GXbVf2hxsU22KVrXVM+FIFD3f8HKi4H?=
 =?us-ascii?Q?tjtvId5/tj91QyE9VKa3FZjh07oDTok3FgbEZS8RX+y2MuGeRtH9R9/hvOo0?=
 =?us-ascii?Q?32ckXNhLZLGfII1PCaVpRxzxC2xDLQTc6MhemsG0f2oNAEsN5hjL0llRcVcN?=
 =?us-ascii?Q?XilZDaiiOjEiWJ2CeiyXhBzAdlIoZFC5ElEYkdu36F9si/J49sEoLKCYsBC7?=
 =?us-ascii?Q?O2HpHXOs+SMFExWHxLKjTJbjnW1PfNoC060L2N4xRMl8Tiz0Oha5ruQ7Wy85?=
 =?us-ascii?Q?u0w6kHP+wIs7D5pR5sX2MqdBYEFX8zbqTSwBBLqzyOLH/d9u7i0QFh49fs+L?=
 =?us-ascii?Q?yaNNExvg/5CgmflkXPZYOPvH6k3uf8fJJosrcjRO/BdIIzrbF6fXwG6IqNRe?=
 =?us-ascii?Q?tu7FPK+DReZVCXLyV1LvEYKEhNcFTbLoUgEj9PgW8au0akWAow3APJdfOCyV?=
 =?us-ascii?Q?aCXB78xjU0lQ/Km1YCVUkwp1fxzpp1zKXWcXAEKOx1yOlN3LwnGUDEvopbJQ?=
 =?us-ascii?Q?+lilzSaAxoSECpljqFdwOySSvqAz61Tq4PfnBOsCERw6V11rt72gme3LEgTh?=
 =?us-ascii?Q?fkGmcxSUYLO5GlGgbUxvgiXco0v6xaBTHYIwsmj5cFVjGiBRCI6FGvJoAIWd?=
 =?us-ascii?Q?bWjIKgFF81jvOOxS95JvXkABJR6HZvI5IbNJ0P1Jxp1U+GEnFvkOlz6IpMMP?=
 =?us-ascii?Q?5v+3qEG3QQEwIc6Fo1kWvLDDtUmWFiYofmOBGkDJOqtADWle0AlWzhi/ma1/?=
 =?us-ascii?Q?Cv14Jv6/H6LmrauZr0eqPEbOl/Mi+yEmBpbLdWC/VKxWE1PpKVMslAIgSjVm?=
 =?us-ascii?Q?8X6t3djRUI4kFfkkczS7yKJvxK+1wIzJFadx+Z6+zekelo1xag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KX1W9ZM6Qf8Xovk/Z167tGYpCoEdw+tgpemUPPEfKIq+scImw3UZ61iIli8W?=
 =?us-ascii?Q?ACk4F/kbSwfnNdfo6pSiX7p+rgLWNLNlVEJ+h+MEL2R/bRJuwQZAUHeR7irG?=
 =?us-ascii?Q?Ko8Wkmpo+vo9kP7bCwAdJjzx4UytOXkGLgEjsAtn5yxGk51fH4snVsKLKjpE?=
 =?us-ascii?Q?Bj/o98EjvWeEREuC2FzM84uIEFh1OAQZ6fDr3LPSTFpF94W8bEoGgSYsqjKA?=
 =?us-ascii?Q?k2+aOlYB60ndzeDDThLhstrwVRcECkN3XTIi61NdOGXtggNX1Yfoey1OUMGl?=
 =?us-ascii?Q?DzoKVI2XxFoxAZRbwqvcz4LiElnVg0WYI/7CL82cbUaww1AXHAQ9beW+2IJj?=
 =?us-ascii?Q?Kx6UuJDvSWskUJPL1nLk+Q9KJ+yWlsHi9rNkd9DZUtv0U123uCoCfHaRMZQF?=
 =?us-ascii?Q?S8lecPeBcT9jUpI23afVtFQEr0XJl8CE1c5zUzbc7olu0ah2fnHcQ00dqgdV?=
 =?us-ascii?Q?Cqd0mw72ZtQM+sgWc88ry+W1Dn0W+4zj7xaTe4WQVa6vVzB4s9zNPhdc8FOC?=
 =?us-ascii?Q?rfPYcSNm/v5t1g9WkrIJ3yKIUifPZJ+M2FZTvSMwTi6WZpq81wm37a1et1oP?=
 =?us-ascii?Q?ITrs/GxiRxthQ8SCKsxoQbuEVvpNL75sGU/X5BMdI2YLl1bzZO03CgzHWz5h?=
 =?us-ascii?Q?qpYh+u34aOPZw/n7hdy0nDP07G7hX7dA6Ck1HSYUVT+FusXOK+ImfB33fM3B?=
 =?us-ascii?Q?/JVfmf9hB5ksz0SiJRaI5alqWnyXFWXriLkL0+YPJBTHH8MTfdPKKkB1WSQk?=
 =?us-ascii?Q?WBASXPYCy3/Wwuij71SLQ27ipTPx7iJO9N3597U2UD9QwnXE7h8dSPcETyCq?=
 =?us-ascii?Q?ZxjdlYLoh2sywvMun6MKpNVTT5ptrpEuSKyNwnjnTu/sDw+ZoYa5TECX+kjh?=
 =?us-ascii?Q?wkKT77XDJ+88KjIulTzf/S6dy55r5DNA9wHa+BjIxYSw2fhwdS9b12iengb6?=
 =?us-ascii?Q?OENwKsqKaF7TpIGr+v1FiVzqPXxL+WopB2oxOorbW4P99XwnNHFrhjI4PGLf?=
 =?us-ascii?Q?aTr+PkAcL/cfrJmywk6TvB+709gCG8WC+H+eHq6u7mTtEEz5bhLUlZLMTEec?=
 =?us-ascii?Q?jzbH/QoYoCvTVp7r2oxDRgXsXfAh99qHv+0Uc2M+JTsYCqIuzxbgXrJpxYeb?=
 =?us-ascii?Q?QZ5DzCdANcvbQEn7Reoylzld+AIRffZjEs8h4Ob/iBhuAC/jT3tvcM/BV9Ta?=
 =?us-ascii?Q?kE0TB1MOzRrtH+9CzS7TirkJMoIWTmq5SHPMPcIlWJdmVHLSfvfw9uVLf2AQ?=
 =?us-ascii?Q?b/7E2u7gyC+pYwgF86yULhwCV2y2jOR902TJTNK6vtn24c/5DYNx3Qeu8RcU?=
 =?us-ascii?Q?VqNfPBNAJFGL6wcVBLhCod+kD0BjqiH33uC3PvZt8vX64E+1lqQH9RwhiujN?=
 =?us-ascii?Q?nYge0i9Su4TxILePJ/CaogD6Fb0jV6YjSnrXiqdSb/XLJHE1oiN4NKl+RB9X?=
 =?us-ascii?Q?/JUD2jLkR7LoAG3SHUWoFknuZbDwMRKMyMNqZMSliN8bo1qfLM5Df+cN6F0f?=
 =?us-ascii?Q?tJ9L59UOKGqg3deHks+zWCYspvXue8867Oncx+exOWcX2xO6Xsxgh/8k/Mmi?=
 =?us-ascii?Q?NzZVmpTSbgS8gc20fN42m1DNKBFOfu2GN2emaXuKS/a8o/7koFhlC3mKLxl+?=
 =?us-ascii?Q?0O32dMpmQ4b8xtHX0duI1hY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b6f04c-ea7b-4718-fc88-08dd1a867b7c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 08:25:05.8196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLNWrwYeyWRp7MUldgWPeRXfjUDP4BAuRAYy78dodCsYEmJMo85KJXiFftvNSVYCi6thjWaQPWltiGITjC1HmtYd1lpOIXGvEsPCGfIruUxB5md4D9EqWq2qgnqYZN4y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8459

As per admin guide documentation, "rodata=on" should be the default on
platforms. Documentation/admin-guide/kernel-parameters.txt describes
these options as

   rodata=         [KNL,EARLY]
           on      Mark read-only kernel memory as read-only (default).
           off     Leave read-only kernel memory writable for debugging.
           full    Mark read-only kernel memory and aliases as read-only
                   [arm64]

But on arm64 platform, "rodata=full" is the default instead. This patch
implements the following changes.

 - Make "rodata=on" behaviour same as the original "rodata=full"
 - Make "rodata=noalias" (new) behaviour same as the original "rodata=on"
 - Drop the original "rodata=full"
 - Add comment for arch_parse_debug_rodata()
 - Update kernel-parameters.txt as required

After this patch, the "rodata=on" will be the default on arm64 platform
as well.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 .../admin-guide/kernel-parameters.txt         |  2 +-
 arch/arm64/include/asm/setup.h                | 26 +++++++++++++++++--
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a22b7e621007..51bce7b9d805 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5901,7 +5901,7 @@
 	rodata=		[KNL,EARLY]
 		on	Mark read-only kernel memory as read-only (default).
 		off	Leave read-only kernel memory writable for debugging.
-		full	Mark read-only kernel memory and aliases as read-only
+		noalias	Use more block mappings,may have better performance.
 		        [arm64]
 
 	rockchip.usb_uart
diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
index ba269a7a3201..37f58a603224 100644
--- a/arch/arm64/include/asm/setup.h
+++ b/arch/arm64/include/asm/setup.h
@@ -13,6 +13,28 @@
 extern phys_addr_t __fdt_pointer __initdata;
 extern u64 __cacheline_aligned boot_args[4];
 
+/*
+ * rodata=on (default)
+ *
+ *    This applies read-only attributes to VM areas and to the linear
+ *    alias of the backing pages as well. This prevents code or read-
+ *    only data from being modified (inadvertently or intentionally),
+ *    via another mapping for the same memory page.
+ *
+ *    But this might cause linear map region to be mapped down to base
+ *    pages, which may adversely affect performance in some cases.
+ *
+ * rodata=off
+ *
+ *    This provides more block mappings and contiguous hints for linear
+ *    map region which would minimize TLB footprint. This also leaves
+ *    read-only kernel memory writable for debugging.
+ *
+ * rodata=noalias
+ *
+ *    This provides more block mappings and contiguous hints for linear
+ *    map region which would minimize TLB footprint.
+ */
 static inline bool arch_parse_debug_rodata(char *arg)
 {
 	extern bool rodata_enabled;
@@ -21,7 +43,7 @@ static inline bool arch_parse_debug_rodata(char *arg)
 	if (!arg)
 		return false;
 
-	if (!strcmp(arg, "full")) {
+	if (!strcmp(arg, "on")) {
 		rodata_enabled = rodata_full = true;
 		return true;
 	}
@@ -31,7 +53,7 @@ static inline bool arch_parse_debug_rodata(char *arg)
 		return true;
 	}
 
-	if (!strcmp(arg, "on")) {
+	if (!strcmp(arg, "noalias")) {
 		rodata_enabled = true;
 		rodata_full = false;
 		return true;
-- 
2.40.1


