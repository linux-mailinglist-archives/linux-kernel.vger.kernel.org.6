Return-Path: <linux-kernel+bounces-271808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3035945375
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A822881A0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97741494C3;
	Thu,  1 Aug 2024 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EIn+j/yB"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2108.outbound.protection.outlook.com [40.92.41.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C243D1494A0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722541274; cv=fail; b=DGPGiFTOYazTGADtte53ujdkj/0qKFEjDFY6E6bPM3CI7/8Z46I52vlhAxrNjvnXRsBFZa+r9F9XMX6N6wtBPROYu8S/oFS47tVwDCeCiaMoBL3byJnfMqoFZ7o1ptl+lwWxIcg0uT9W2TbYCkOUiVy2VDqq163g5a3nZwRV37Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722541274; c=relaxed/simple;
	bh=G8DFmht74OSZK/z9Htr8RCyaiHj251W0486cWU1s5cY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kYNv2/+DYXREMdNhTMMZk4NZPuOgTUrBjgcDt3Hl8hUCVFuu0YqWMCfkHf0dv3VSdORDrTJJHz/jt5zlhKskNSI8Loy298ggcA562WO4iDkYtWk42xt1td6IAKIk0Ty07FiN/dWmAhiFOXQbwgw3D6liRY3SskwWrDRky9Og5YQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EIn+j/yB; arc=fail smtp.client-ip=40.92.41.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiIasUu1Kix1612L2HhyE46/UaNK8S0Brt78SsZ2NxM/CJuXM5hu+g5Wmj+HOTbZK3+er73KIwqaJ/4fjTYyH/MVW+cNIEDgJ1SIIgqe91P5uen2/0ZyrjK/4L7769lZCnkU0FLa0jSkMj7UAIKEYfghQvq4ytbUlSGvvKrJkPVf5UflmAZTncwUY4ET5swYOq0bOag7GF0m2iWML0vNteWdqDUbnfRWLkQ/irVGqOWAbjPb51/YLLcKbcrSoQMH0aNEDMNGH+My7Rdk8GsiXVLV9w2TNAIHJypAlKDUzZ+2+gcB7wbbXL6UsRKmB9rwSSBq5FV67FWXOmVUnMrn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmlELIznoUESuNPEXWTovKEwkHJv3Zzqyx76e/Bb9Ug=;
 b=bzb94V8uL8+7pdf0YSnyNriPMuoPraebjLwSixyjLtVKkQTdoNierS8LdXk+jTcRhoqqtyYJ461yqvNVN2a9RC384oRcc+RKbkKjhnArPrBP8BgxEa7R/SGatrXQfJJqlJWuj59q8WQo8NiJYe9IdejtmwNctTBHkzTKYUiyZohbWh/AymBfu6xQFPZUD4BirsIUSvFB0dgWVcjD/Gb1FkZobfFytoWqz0qrwwzcernoiFJKttUUnIiGtiB8rqzMqVdDxZH/TUM4s62uCgjdZhq0fV9GITDpBrxrdoq6Yd5AnPAuGYeU6hj1PMD0b1z5SLgv6PQAfjuzogT0goZrKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmlELIznoUESuNPEXWTovKEwkHJv3Zzqyx76e/Bb9Ug=;
 b=EIn+j/yBm8CaO9NswHt7udFDkLyUIq28P8YktYbhEh6G9ww57QyNBvPtNNXId+YvH4wC11ybfA25fTj2kBWnRypbyKOA8KBQBNNH2t30YCWjRexlbhVc8WHRBZRxI9Iz+4jZPZdVsNEr+kTMf4W/vPw5q/7efIbWV+wZ5kauT6iwVvXS+WVp/1FR4TPTnaOteki2TB1Gt4NwozSQBtf3Kf6OhZXjfsQ4H/AN8lM6aUU+W49icjkgH3HGNNHagav4y79w6E9csakebsC1jLf8xmEinmyeaw1b5MKMfbrW8LwK1cSoVrl4XtchdAoU1Bvrr09ycNBMOVjDhO6jDzaYqA==
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:a03:570::8)
 by PH7P223MB0620.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:1ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 19:41:09 +0000
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd]) by SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd%2]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 19:41:09 +0000
From: Steven Davis <goldside000@outlook.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Steven Davis <goldside000@outlook.com>
Subject: [PATCH] Add memlogger utility and update MAINTAINERS
Date: Thu,  1 Aug 2024 15:40:33 -0400
Message-ID:
 <SJ2P223MB10261D3FCC3D949DA7DA4565F7B22@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [qkqS6fThwLJ1u4oPbvb0mjCaFe9OrpCy]
X-ClientProxiedBy: CH5PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::19) To SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:a03:570::8)
X-Microsoft-Original-Message-ID:
 <20240801194033.5196-1-goldside000@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2P223MB1026:EE_|PH7P223MB0620:EE_
X-MS-Office365-Filtering-Correlation-Id: dae236fe-750c-45a3-f5ff-08dcb261e403
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|19110799003|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	2PIkOCdgAkYVehtWto8PvStZ4dVjZbYSipNbOw1nT3KosYDPD+nspTmh0xfOnVuyPcehFvknsIwhi5D1rC03Ntx6XZZFkSVbL9s8HisRTncUT57JZDrrWpf9wKUjRdDNd1LBY0rRCrW8UaZwNfC/+E7H9809LVvJZL946HL3i1M/YeS6kyBKF0ycbSvDp1gkal5HlBkMMxdrmAY42NAMgKBLGkvmeONMO7fxB5oyzNr9SRZPesrT4xJEKSRROwSJEe64N/yV6mN2IK1zGN+ByMbunmsagC62SL3Yq8NLTwP2Bx6U15bqNnDH6UJx1kSUac62Yy43xZor+xK9VZdWQFq9ul9oEc11W8JNGHvXkrXOo23zbMKmNhpOplu2/hSmK5uzYOcWouY0uJF5WZcsb5BFjveqmpwm61tqW2MbD3DSFjcYlFNN/nYDIjczkM0hWTVdLz8aoEGYKZZfVA6zhdnrlHzDaaQ5JtPe0tq5FrTpKBWr4SdxCegL4xNW30m8V/drBjfDwJ8pODFWjNGZFofyw3Tm0C58x9uWGcW83nYIwXTzi1w0T4+cXnZi1IPs5YbqOSFAUAIF7WCHWAFcifIVyJR2nDNyUJAkiMbdKqd3Bgj0MK9WMGKBoh2G5FCvDueIWxfQktTr19QlYYbj1vkuhkjxlubrLZoFat7TO57y+HjWUZ3kgPNrMvaQiZVDBJbQMSMKq4WEH14wytsp7Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?81dGhP96DhtMkHZ1RzBPojaJx04r1UMnf6YPnpkMxRTa4up0E9Zwjz8sFVUO?=
 =?us-ascii?Q?WbkQJy1mYcPK3c0T3Jq4vPE2j3D+06gSoOTIYu/t6zPRVEvpFiHYLhEuWXw8?=
 =?us-ascii?Q?SC3vBuWUzZ6oTZuIBeNrESspDKp3wKiSUYYfBz48JGXj9v4KyTa3F4PVqrvz?=
 =?us-ascii?Q?pAT/Zy9xzknkqqeBfgvf0us58pZo0TmD2DWNHq2nxiuruQPpXmW85k5eDZ/U?=
 =?us-ascii?Q?GQNjLo0v7v43OvPc99uP6tHo8sLX42Ha+i9+C9UZsrs+DpdDjrnBheZOTv2v?=
 =?us-ascii?Q?GFi0hr1gTz5b+MMzUWOVx72zEdBX3Jcnw0sYZWNJ93iKkDVb5mFh94i41YQM?=
 =?us-ascii?Q?OMqXIOaPEkQQpRDMMOnWc2sDcdLK0I3gxVnGY8PCxo56cNx5uC9Zq0HKSLp3?=
 =?us-ascii?Q?8UXGz+6XdfVZ/VGG0GB9ohKiVR8d3hklz2v6d6AABOlNdvWJra9/ugLYk0W0?=
 =?us-ascii?Q?9NbY3TiqBG7S++E5SEM0+/yIn0vy/Ix5ra3wWPAOtKbp79qktZrAI5pg4Er9?=
 =?us-ascii?Q?12W5kNhvs9nSp1ktCI/kv0cOMavhZc6Ntkobu2uItgN4GlMe1E8Ezo36j+HP?=
 =?us-ascii?Q?Cugvhj7erQv4lrpt/LzUnWPMPae7MBfBSuj7L5PN70TL2CMWmuvdn7DzkY1i?=
 =?us-ascii?Q?RlFu+dL7BIpdOR/PSnAYpyPwsy9hYR5/O3Jmhrk9Ma02TmpnHgt5UPbnpR/c?=
 =?us-ascii?Q?AuNTDwIXBZaOFz8Twb1zHTk0i+kGT8LnsXKI00/RY+D4QexpXCMihb54gykc?=
 =?us-ascii?Q?ImTZEnFr/L6kR1x1ssn5jmKt/rl79QYcQEt4Vm/pvtjxr8Y1W1QTX6vCShF/?=
 =?us-ascii?Q?8hmbubgcFuoRwrsDcvR5woGFeM03xCx8oO+uBRSywSarPIJ50ASbjHVSOeyY?=
 =?us-ascii?Q?nsijo0U5JxzN2xba5dV5g0BsY70BQmma57gCw1B2SwQ3sAJ6rVQUAy8U578h?=
 =?us-ascii?Q?nlvZT+Oqy3H/M4N1wqr1uqK+y5PkkhbMcWG3fOU6n+KSHELbhcLgyofDgA6b?=
 =?us-ascii?Q?UuZfhAdO1/JsjqLk/ncAhVeEGBGLZXys+zNBHxvoDQjkOYZxcODTjO/skWpp?=
 =?us-ascii?Q?Q/gIC/4DJt4bwZ0jNxhbxpM3WVrmtxCbH5yobkJTKbjbXE8fcKd8N7sAkjtd?=
 =?us-ascii?Q?Y2Vj5irE52bRWA09zU4ZoPj1Z/fkr4W1jWgufr6wv0hWQ7Dv8m5Y4qj/J8Ov?=
 =?us-ascii?Q?l3U4TIQzsgg8kOI1gmoaeEquJmuc2MyzzmHaM2dsuz0s3GochMsPnsWHtW4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae236fe-750c-45a3-f5ff-08dcb261e403
X-MS-Exchange-CrossTenant-AuthSource: SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 19:41:09.1057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7P223MB0620

This adds memlogger, a module that can be both used in critical
situations and learned from. When making a patch, the kernel
can be confusing. Memlogger uses simpler components of the kernel
to provide an easy learning environment for new developers.

It can also be used to debug memory related issues.
For example, if there were an issue where something was gradually
consuming memory, memlogger would easily catch that.

MAINTAINERS was also updated to recognize the creation of the
memloggers directory.

Signed-off-by: Steven Davis <goldside000@outlook.com>
---
 MAINTAINERS                         |  6 +++
 samples/memlogger/Makefile          |  7 ++++
 samples/memlogger/get_memory_info.h |  4 ++
 samples/memlogger/memlogger.c       | 64 +++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+)
 create mode 100644 samples/memlogger/Makefile
 create mode 100644 samples/memlogger/get_memory_info.h
 create mode 100644 samples/memlogger/memlogger.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8766f3e5e87e..a140e2714b3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14633,6 +14633,12 @@ F:	mm/memblock.c
 F:	mm/mm_init.c
 F:	tools/testing/memblock/
 
+MEMLOGGER
+M:	Steven Davis <goldside000@outlook.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	samples/memlogger/
+
 MEMORY ALLOCATION PROFILING
 M:	Suren Baghdasaryan <surenb@google.com>
 M:	Kent Overstreet <kent.overstreet@linux.dev>
diff --git a/samples/memlogger/Makefile b/samples/memlogger/Makefile
new file mode 100644
index 000000000000..bc130c1c8ede
--- /dev/null
+++ b/samples/memlogger/Makefile
@@ -0,0 +1,7 @@
+obj-m += memlogger.o
+
+all:
+	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
+
+clean:
+	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
diff --git a/samples/memlogger/get_memory_info.h b/samples/memlogger/get_memory_info.h
new file mode 100644
index 000000000000..5fdc47d58a75
--- /dev/null
+++ b/samples/memlogger/get_memory_info.h
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef GET_MEMORY_INFO_H
+void get_memory_info(struct timer_list *t);
+#endif // GET_MEMORY_INFO_H
diff --git a/samples/memlogger/memlogger.c b/samples/memlogger/memlogger.c
new file mode 100644
index 000000000000..196bdf53fd91
--- /dev/null
+++ b/samples/memlogger/memlogger.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * This module logs memory information to dmesg every 5 minutes.
+ * Useful for seeing how memory logging works and how timers work in the Linux kernel.
+ *
+ * Copyright (C) 2024 Steven Davis <goldside000@outlook.com>
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/timer.h>
+#include "get_memory_info.h"
+
+#define TIMER_INTERVAL (5 * 60 * HZ) // 5 minutes
+
+static struct timer_list mem_timer;
+static unsigned int interval = TIMER_INTERVAL / HZ; // Default interval in seconds
+
+module_param(interval, uint, 0644);
+MODULE_PARM_DESC(interval, "Timer interval in seconds for memory info logging");
+
+void get_memory_info(struct timer_list *t)
+{
+struct sysinfo si;
+
+si_meminfo(&si);
+
+pr_info("Memory Info:\n");
+pr_info("Total RAM: %lu kB\n", si.totalram * si.mem_unit / 1024);
+pr_info("Free RAM: %lu kB\n", si.freeram * si.mem_unit / 1024);
+pr_info("Shared RAM: %lu kB\n", si.sharedram * si.mem_unit / 1024);
+pr_info("Buffered RAM: %lu kB\n", si.bufferram * si.mem_unit / 1024);
+
+    // Re-schedule the timer
+mod_timer(&mem_timer, jiffies + interval * HZ);
+}
+
+static int __init mem_info_init(void)
+{
+pr_info("Memory Info Module Loaded\n");
+
+    // Initialize the timer
+timer_setup(&mem_timer, get_memory_info, 0);
+
+    // Schedule the timer for the first time
+mod_timer(&mem_timer, jiffies + interval * HZ);
+
+return 0;
+}
+
+static void __exit mem_info_exit(void)
+{
+del_timer(&mem_timer);
+pr_info("Memory Info Module Unloaded\n");
+}
+
+module_init(mem_info_init);
+module_exit(mem_info_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Steven Davis <goldside000@outlook.com>");
+MODULE_DESCRIPTION("A module that outputs memory information periodically.");
-- 
2.46.0


