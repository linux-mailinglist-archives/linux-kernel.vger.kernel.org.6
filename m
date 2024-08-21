Return-Path: <linux-kernel+bounces-296051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A24995A4E6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4B11C229E4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62E21B5313;
	Wed, 21 Aug 2024 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="DVEYAKHj"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2093.outbound.protection.outlook.com [40.107.237.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD19816D4FB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724266100; cv=fail; b=sD7yLW6fDGVGeRCNDOWCqFgrwsbSRyQQWye/lzHowVxCvlMEnYMcuLTkKA6aDbiO6ldz52GrlMS9jABoxUUSP38Pzvv1OwtsIeKewFaUdFYe1lG7vhrum9+JNc5ywCpk1VkekstMSu7+F+Q7LKNL9J2wtdFBEHF3bX0xpra7CIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724266100; c=relaxed/simple;
	bh=gr7qf0rsNrzSjDw3tuzCUlkOA3cwkv3UPK1gX+GofJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=taL3zhAM8TAUGD2yVDb1HsTJVnMPx1qIkIYZafQruC87oadArEL2enbdhiM/fOKCTE5IfKVL7FT3oWJqa4MsYECeGGSGPgTuksyix35UVfd030qdaMQrRUmj0YgitlzN6oTQg65h62nY49pCCITRyRB3/ru1G7NCeU+19N3kILo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=DVEYAKHj; arc=fail smtp.client-ip=40.107.237.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJVFe7dD1BeXQZ+2Q13fN1n7hGiEJMPt3PrpCxG6KHtUDug51Dkl8deFziCF06lNmGNzFsQ7xv9oerqks3Eau8C+G/tibc5wacGDuCBkB8LQJAz6CtrlN7cs4+gsprmpsq3xoyBnNWHXvUQZrc7qgCQWd7/Z3xckEGjFUYUHj8/RXKz7oFr+zhtFTG9G0hGS43lnkiQolfCgpXSCi08K3Fw77z1eWL4FQalWjHgOVuqF/LNQHmbfyRKXLMQHeHfi3tR3kfBG4RbiHRhaHZXjpihaY4QoKTA30KqgE1Fr/8j0MuRH56bLfb91Q801AAu4S3+luG31lER3Xew021mIog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhMl6yZhZwoCLsfHBbsMjHl5vbOvP0mp8rTT9+FuyxM=;
 b=IwBNrhj/k9n8z1uoTTRVNMUfVNybA0jF/3wAlJvcABx1jvMnD2MvqfXj6Ite1eN+hVBkmE3hvesFWPEvq0aIjx40UMsW6RlYSDACcAxP2pxWj2sXeZptUABJU5j14uU4B4IyHgU39sa25xAx9kgxJpgw4ESIrbv1ebPM2cfSOZFZszhlTLndt3ZVA7p6s4g/pw/a3dpFq5AdRGePd4OhAQBO8Q4TYT8nmpBOvSwPutx/fSVGnv3+76uT3PzIGhxJtqtAp7MV2jqbA1EUfKL8KtghnagZGytUi4NW95T/ZLCtrNtmybsYHrBa1FxF8r2ekY+t7POJv10IIltT1pkN/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhMl6yZhZwoCLsfHBbsMjHl5vbOvP0mp8rTT9+FuyxM=;
 b=DVEYAKHjG0B9VUVy/bp//ujBft60MKv56aiKgy4+ljmfW5ArFBtvHf8IBZaQmNWzaMgWhCnUIyfePljCM1LYwlfUao4lo5C2FVmXX2CSPwZ2AiZ3XRE6qYjo01W8hCPO7uNWbKpXL9aPflfiIp4quS34fbZL9ahg9w0+7FL1lvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MW4PR01MB6146.prod.exchangelabs.com (2603:10b6:303:7c::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.16; Wed, 21 Aug 2024 18:48:10 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 18:48:10 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [v2 PATCH 2/2] selftests: arm64: add hugetlb mte tests
Date: Wed, 21 Aug 2024 11:47:52 -0700
Message-ID: <20240821184752.3535276-2-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240821184752.3535276-1-yang@os.amperecomputing.com>
References: <20240821184752.3535276-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::12) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MW4PR01MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: bac85570-1a6d-4d29-eb1b-08dcc211cd94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9CaN8BmL46/6k149IAc0nW1P3IICQhNbp8Fus/rvTTs2g/8NQUj2vcX/oeGu?=
 =?us-ascii?Q?fzrMl3qYivANZuOLQsECKkITCgj1mGIlHxJ/qe4+J8P3QbnxKe/aUKtryHVa?=
 =?us-ascii?Q?jqviyLGb/wu++ea8zUMGLvDSvZTUwUEtQ+tD8dhkM5jz3GkcYTcVPz9HK0wQ?=
 =?us-ascii?Q?KztTbeM0TlcA8KBiZz+UJ4y4SQKinlSVijwZ/FsaoDepM7Y3hWhsAHOaXJW3?=
 =?us-ascii?Q?J7kyh/iiuQLb9IiAANLYJzBtccLNPTis5gLQrrQasw3/vpCs5KNV3G0VY2cx?=
 =?us-ascii?Q?ZAz0S5wK++vO0/OEzsVTwCxhsZ7oXL0kfipH7OMX1VLRXZL/So0YHimzYfbF?=
 =?us-ascii?Q?+NWO+kjleAp7s5om9ye5opcG/2FdN49+jw5R6y+gacXj31qBnZ4Qxk0TzyqR?=
 =?us-ascii?Q?BHZk/CMXO1bT1Lj2GYR9tG9jM6oyabuM5fGQ2/fGPu2mD9TiESpG1ANGLCEc?=
 =?us-ascii?Q?e15L+PI5zH/NYYMKChV4wL7e68+wQ8lD4zKZYbOMrdKDc8HKL1eXC+3OEsVx?=
 =?us-ascii?Q?oU5xgYSthdoyvNf2MdWdAURbyHfUvcolCWYS4//wBAYlcCDhQUZRBV4GpvDU?=
 =?us-ascii?Q?jE9BqTG29Ce30/o+hDk+6Acs3KVHgApZGC1o29hCYmEIuCiMbGEYJLv0EswZ?=
 =?us-ascii?Q?14J/nC+uLzxFkze9mv6i2SwlOaG2oy9V2kPxTJkTRoBakBlE0SvDddx90DAV?=
 =?us-ascii?Q?/rEcHEA+N2lNGr7r7DfSSeangbxqAzr0TQXTisGNJkIPHxVNmzUJUbzEYaF1?=
 =?us-ascii?Q?wgDhDCoiCghlrMdbar+s37mybitKgnpssiPZX/N8rzPMhB26yB39RWcQ8FuF?=
 =?us-ascii?Q?ggxfm2hoZyumEkJc+APH05b3EFMW6RQ0Z75EfAe9iw025aL+iQkxvt1AWJCM?=
 =?us-ascii?Q?kN/X40A4hneB+7T35N7XjwPCc1SP9sgvG+ZcRiANFfcoIsi3DrQ/GHUTexGW?=
 =?us-ascii?Q?zgp08SQZeYLWM2ErXiGnWDpNE/kkg0rjRmqVw2CiARZZKqHuynTP1Kb62cjv?=
 =?us-ascii?Q?z48dLcG0eWr88IJXaydo0YWPEw+KXW2FkRgTbH7f6tE/AxWGsKS5daBcPPlc?=
 =?us-ascii?Q?f5cfYqFW9m8nBCgX6VblLah+x/X0/DRv2srhn0buhNPfKJcUxyUlNblOpbGv?=
 =?us-ascii?Q?69qdinBZJC2+NZ8qyOSX4grmnGk0VkC/zY5yKUgRaulxCIaKtZOEJWZiBzxy?=
 =?us-ascii?Q?LTymQigxgVuWi3jyYThTgN80OFgEKZPpzRLSYO1poLYsn4h+hplnAQPO4+Vf?=
 =?us-ascii?Q?pZd4xOocUAYIs1sIXc7q5o3Z5mV1zJJ66ypkPmGuBz69aLyCUgLh0N6VQcAX?=
 =?us-ascii?Q?CT/O/zUNKQOlXVke1DRaZ7jTv2a+bL0svDrASSSWCXxPn39KB0KvTSrHjAEf?=
 =?us-ascii?Q?+OCNZ2mncCQq1lzy07VOlTzXc9qgGxeYnireQvPIWCGI5KLbZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Z95Z8/SBkvtyb6DFjFzCyeYVpKEg8uCAwvWp8nK1/X6n20r0haXCWV9j76/?=
 =?us-ascii?Q?JQbu6m8ew+TIwfqYqtlFOFFLMDKvB6OYU/MMt7R7o/xMO/mjcSNT5O6M8rCI?=
 =?us-ascii?Q?lUswBJiy1bqxpx0nxAYFYG/IQ42ssQu/ymy5xeto09TxId0owhYuoXIU/3ze?=
 =?us-ascii?Q?8NLMLqAQFiieKOFxnzoDsdCgUlUAz8nPNKdV+aAjgIzNkDiD82STIn0CJocp?=
 =?us-ascii?Q?JaHOKR2LM7b7MFVHmUUDURxDJqgcwodG/d3Z6/TEb4XOGJ6AexAprUvs9ghS?=
 =?us-ascii?Q?kMVuHx65+ouKlVsCju/0unwJjgkU2/3NKIAiPy16tyMiOxzkX3h8Vwp63pUM?=
 =?us-ascii?Q?cG69wUNvMiofT1aDGJV8vxvd4TqkV3bVtlb+4Cm7DvjNNLGppJ9lNZFBNBIl?=
 =?us-ascii?Q?LB7tSZtxLVpywIkLtKrKQcyvSSMKYDNu6VtF7LElyJB60ShLsnE7y0p0My9w?=
 =?us-ascii?Q?UTutPvbZVC3htwgQBMii72IrIKX7Ql6qsJ5RcW0+U/WttXfj5MqBW9zhwt2a?=
 =?us-ascii?Q?H9Y+iYA1zpxKH2eBKnbbcO+si5+kpm/aQbn8YGhqGYFGAS19Xv6JKIWh7Bga?=
 =?us-ascii?Q?YzR+2z2hE7mbxJSCtOe915goxWqbQbwUmz7pFHkfJy90MXojmZAZf5F2u2/2?=
 =?us-ascii?Q?GiGzSfbcZeXtbpMHi4wmaRNLMBea9mw2JO+OqpCNcKPu5fOQCPkKWbgEdMil?=
 =?us-ascii?Q?MW74UdYM3f5b92FD8aV7Za37PRaRjlPDB05eV/nOgho7Ma3HmaIgBqIvoGrm?=
 =?us-ascii?Q?TzVwifRAQejQpwUeYD85WbqnWIkEPq5kxorllBpdwNM2eWG6PRvT61gN8YZU?=
 =?us-ascii?Q?1n78ruI4sixWKgVtWCuhWaG2vthZovdWa5o/nx21gvC/WG8H7+dyIfYDX75V?=
 =?us-ascii?Q?omyYU9+wad2jLKTA2TtLeQ93cE2xZl24OGgPjPq3NE3TgMAURHheSR1e0MHo?=
 =?us-ascii?Q?1jVy+RT2AuyhD9BuYxbB0nr/pHnhkWnjan27KrNQpBfjsELiJSaUIVRMkMeq?=
 =?us-ascii?Q?FIgMRDQze1P6nhFBtblP4ZeAKkgsXGEuLcofpy64Hcbf16xKtbFB9KCWL07n?=
 =?us-ascii?Q?cabFYdwQYeQZGM6F/GKobbL1sycIZphSoXMGvqQTF57cEyIztg04C7TAgluQ?=
 =?us-ascii?Q?X4Iyt3C1/6Ax8WSfsSTJzGZiE26ZYvCJgI/m4V30eUowxrsV7dRURc6rFV0W?=
 =?us-ascii?Q?unX/C4bT7EFaOlL6PiNfsNED8P7m0pwXKBChk6a3FsKT2JRV1rzzBQ2Mk3Oj?=
 =?us-ascii?Q?aE9gDLeKldHkjlsrX5khfxAl8LzSD5Evk65SS9YRhlng7T6FxnmSuTK7TytE?=
 =?us-ascii?Q?TQV5hUXe2x74Zjc0PwHIa7o2//RpZSGsLhXgtwT83E2DSRnva9JSX4zMFo7j?=
 =?us-ascii?Q?yQSwvV/z8Vodyz9dARN8tZpDYF2myzE9S9hqB1E8fvuYqEdQNRjz34U8FJNR?=
 =?us-ascii?Q?gAf7FwYGR4a83yI0y+xQNWWdTUyC4BZN7vuq25HwHo6tPOicFkgNREUx6rCS?=
 =?us-ascii?Q?1p9MyyH5LAgQqy2vcd6ytX4Do40XD4Qd2OPZ22d52ZqGjg/zd/yQhw254Juy?=
 =?us-ascii?Q?Gy//YchBD5OXX2Fu9Hw3d8UvJUBPsOoO3S3Dv68ZtnY3+HniJnR2sQ3m0L6n?=
 =?us-ascii?Q?aBTvTH74uL8DLFBbGV4RnUQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac85570-1a6d-4d29-eb1b-08dcc211cd94
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 18:48:10.0652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQuI1hFl65snWLrii7JU2q7kKCehXSpzo+8ergL5mOylo1cLgI3xa5hs9tZ1VAD1VRLp91V0d1PKHUIbfQa8qgbAUb8v9GzTUWUv8nVCksk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6146

The tests cover mmap, mprotect hugetlb with MTE prot and COW.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 .../arm64/mte/check_hugetlb_options.c         | 285 ++++++++++++++++++
 1 file changed, 285 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/mte/check_hugetlb_options.c

diff --git a/tools/testing/selftests/arm64/mte/check_hugetlb_options.c b/tools/testing/selftests/arm64/mte/check_hugetlb_options.c
new file mode 100644
index 000000000000..c2402e3d6bca
--- /dev/null
+++ b/tools/testing/selftests/arm64/mte/check_hugetlb_options.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2024 Ampere Computing LLC
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <ucontext.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include "kselftest.h"
+#include "mte_common_util.h"
+#include "mte_def.h"
+
+#define TAG_CHECK_ON		0
+#define TAG_CHECK_OFF		1
+
+static unsigned long default_huge_page_size(void)
+{
+	unsigned long hps = 0;
+	char *line = NULL;
+	size_t linelen = 0;
+	FILE *f = fopen("/proc/meminfo", "r");
+
+	if (!f)
+		return 0;
+	while (getline(&line, &linelen, f) > 0) {
+		if (sscanf(line, "Hugepagesize:       %lu kB", &hps) == 1) {
+			hps <<= 10;
+			break;
+		}
+	}
+
+	free(line);
+	fclose(f);
+	return hps;
+}
+
+static bool is_hugetlb_allocated(void)
+{
+	unsigned long hps = 0;
+	char *line = NULL;
+	size_t linelen = 0;
+	FILE *f = fopen("/proc/meminfo", "r");
+
+	if (!f)
+		return false;
+	while (getline(&line, &linelen, f) > 0) {
+		if (sscanf(line, "Hugetlb:       %lu kB", &hps) == 1) {
+			hps <<= 10;
+			break;
+		}
+	}
+
+	free(line);
+	fclose(f);
+	
+	if (hps > 0)
+		return true;
+
+	return false;
+}
+
+static void write_sysfs(char *str, unsigned long val)
+{
+	FILE *f;
+
+	f = fopen(str, "w");
+	if (!f) {
+		ksft_print_msg("ERR: missing %s\n", str);
+		return;
+	}
+	fprintf(f, "%lu", val);
+	fclose(f);
+}
+
+static void allocate_hugetlb()
+{
+	write_sysfs("/proc/sys/vm/nr_hugepages", 2);
+}
+
+static void free_hugetlb()
+{
+	write_sysfs("/proc/sys/vm/nr_hugepages", 0);
+}
+
+static int check_child_tag_inheritance(char *ptr, int size, int mode)
+{
+	int i, parent_tag, child_tag, fault, child_status;
+	pid_t child;
+
+	parent_tag = MT_FETCH_TAG((uintptr_t)ptr);
+	fault = 0;
+
+	child = fork();
+	if (child == -1) {
+		ksft_print_msg("FAIL: child process creation\n");
+		return KSFT_FAIL;
+	} else if (child == 0) {
+		mte_initialize_current_context(mode, (uintptr_t)ptr, size);
+		/* Do copy on write */
+		memset(ptr, '1', size);
+		mte_wait_after_trig();
+		if (cur_mte_cxt.fault_valid == true) {
+			fault = 1;
+			goto check_child_tag_inheritance_err;
+		}
+		for (i = 0; i < size; i += MT_GRANULE_SIZE) {
+			child_tag = MT_FETCH_TAG((uintptr_t)(mte_get_tag_address(ptr + i)));
+			if (parent_tag != child_tag) {
+				ksft_print_msg("FAIL: child mte tag (%d) mismatch\n", i);
+				fault = 1;
+				goto check_child_tag_inheritance_err;
+			}
+		}
+check_child_tag_inheritance_err:
+		_exit(fault);
+	}
+	/* Wait for child process to terminate */
+	wait(&child_status);
+	if (WIFEXITED(child_status))
+		fault = WEXITSTATUS(child_status);
+	else
+		fault = 1;
+	return (fault) ? KSFT_FAIL : KSFT_PASS;
+}
+
+static int check_mte_memory(char *ptr, int size, int mode, int tag_check)
+{
+	mte_initialize_current_context(mode, (uintptr_t)ptr, size);
+	memset(ptr, '1', size);
+	mte_wait_after_trig();
+	if (cur_mte_cxt.fault_valid == true)
+		return KSFT_FAIL;
+
+	return KSFT_PASS;
+}
+
+static int check_hugetlb_memory_mapping(int mem_type, int mode, int mapping, int tag_check)
+{
+	char *ptr, *map_ptr;
+	int result;
+	unsigned long map_size;
+
+	map_size = default_huge_page_size();
+
+	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
+	map_ptr = (char *)mte_allocate_memory(map_size, mem_type, mapping, false);
+	if (check_allocated_memory(map_ptr, map_size, mem_type, false) != KSFT_PASS)
+		return KSFT_FAIL;
+
+	mte_initialize_current_context(mode, (uintptr_t)map_ptr, map_size);
+	/* Only mte enabled memory will allow tag insertion */
+	ptr = mte_insert_tags((void *)map_ptr, map_size);
+	if (!ptr || cur_mte_cxt.fault_valid == true) {
+		ksft_print_msg("FAIL: Insert tags on anonymous mmap memory\n");
+		munmap((void *)map_ptr, map_size);
+		return KSFT_FAIL;
+	}
+	result = check_mte_memory(ptr, map_size, mode, tag_check);
+	mte_clear_tags((void *)ptr, map_size);
+	mte_free_memory((void *)map_ptr, map_size, mem_type, false);
+	if (result == KSFT_FAIL)
+		return KSFT_FAIL;
+
+	return KSFT_PASS;
+}
+
+static int check_clear_prot_mte_flag(int mem_type, int mode, int mapping)
+{
+	char *map_ptr;
+	int prot_flag, result;
+	unsigned long map_size;
+
+	prot_flag = PROT_READ | PROT_WRITE;
+	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
+	map_size = default_huge_page_size();
+	map_ptr = (char *)mte_allocate_memory_tag_range(map_size, mem_type, mapping,
+							0, 0);
+	if (check_allocated_memory_range(map_ptr, map_size, mem_type,
+					 0, 0) != KSFT_PASS)
+		return KSFT_FAIL;
+	/* Try to clear PROT_MTE property and verify it by tag checking */
+	if (mprotect(map_ptr, map_size, prot_flag)) {
+		mte_free_memory_tag_range((void *)map_ptr, map_size, mem_type,
+					  0, 0);
+		ksft_print_msg("FAIL: mprotect not ignoring clear PROT_MTE property\n");
+		return KSFT_FAIL;
+	}
+	result = check_mte_memory(map_ptr, map_size, mode, TAG_CHECK_ON);
+	mte_free_memory_tag_range((void *)map_ptr, map_size, mem_type, 0, 0);
+	if (result != KSFT_PASS)
+		return KSFT_FAIL;
+
+	return KSFT_PASS;
+}
+
+static int check_child_hugetlb_memory_mapping(int mem_type, int mode, int mapping)
+{
+	char *ptr;
+	int result;
+	unsigned long map_size;
+
+	map_size = default_huge_page_size();
+
+	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
+	ptr = (char *)mte_allocate_memory_tag_range(map_size, mem_type, mapping,
+						    0, 0);
+	if (check_allocated_memory_range(ptr, map_size, mem_type,
+					 0, 0) != KSFT_PASS)
+		return KSFT_FAIL;
+	result = check_child_tag_inheritance(ptr, map_size, mode);
+	mte_free_memory_tag_range((void *)ptr, map_size, mem_type, 0, 0);
+	if (result == KSFT_FAIL)
+		return result;
+
+	return KSFT_PASS;
+}
+
+int main(int argc, char *argv[])
+{
+	int err;
+
+	err = mte_default_setup();
+	if (err)
+		return err;
+
+	/* Register signal handlers */
+	mte_register_signal(SIGBUS, mte_default_handler);
+	mte_register_signal(SIGSEGV, mte_default_handler);
+
+	allocate_hugetlb();
+
+	if (!is_hugetlb_allocated()) {
+		ksft_print_msg("ERR: Unable allocate hugetlb pages\n");
+		return KSFT_FAIL;
+	}
+
+	/* Set test plan */
+	ksft_set_plan(12);
+
+	mte_enable_pstate_tco();
+
+	evaluate_test(check_hugetlb_memory_mapping(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE | MAP_HUGETLB, TAG_CHECK_OFF),
+	"Check hugetlb memory with private mapping, sync error mode, mmap memory and tag check off\n");
+
+	mte_disable_pstate_tco();
+	evaluate_test(check_hugetlb_memory_mapping(USE_MMAP, MTE_NONE_ERR, MAP_PRIVATE | MAP_HUGETLB, TAG_CHECK_OFF),
+	"Check hugetlb memory with private mapping, no error mode, mmap memory and tag check off\n");
+
+	evaluate_test(check_hugetlb_memory_mapping(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE | MAP_HUGETLB, TAG_CHECK_ON),
+	"Check hugetlb memory with private mapping, sync error mode, mmap memory and tag check on\n");
+	evaluate_test(check_hugetlb_memory_mapping(USE_MPROTECT, MTE_SYNC_ERR, MAP_PRIVATE | MAP_HUGETLB, TAG_CHECK_ON),
+	"Check hugetlb memory with private mapping, sync error mode, mmap/mprotect memory and tag check on\n");
+	evaluate_test(check_hugetlb_memory_mapping(USE_MMAP, MTE_ASYNC_ERR, MAP_PRIVATE | MAP_HUGETLB, TAG_CHECK_ON),
+	"Check hugetlb memory with private mapping, async error mode, mmap memory and tag check on\n");
+	evaluate_test(check_hugetlb_memory_mapping(USE_MPROTECT, MTE_ASYNC_ERR, MAP_PRIVATE | MAP_HUGETLB, TAG_CHECK_ON),
+	"Check hugetlb memory with private mapping, async error mode, mmap/mprotect memory and tag check on\n");
+
+	evaluate_test(check_clear_prot_mte_flag(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE | MAP_HUGETLB),
+	"Check clear PROT_MTE flags with private mapping, sync error mode and mmap memory\n");
+	evaluate_test(check_clear_prot_mte_flag(USE_MPROTECT, MTE_SYNC_ERR, MAP_PRIVATE | MAP_HUGETLB),
+	"Check clear PROT_MTE flags with private mapping and sync error mode and mmap/mprotect memory\n");
+
+	evaluate_test(check_child_hugetlb_memory_mapping(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE | MAP_HUGETLB),
+		"Check child hugetlb memory with private mapping, precise mode and mmap memory\n");
+	evaluate_test(check_child_hugetlb_memory_mapping(USE_MMAP, MTE_ASYNC_ERR, MAP_PRIVATE | MAP_HUGETLB),
+		"Check child hugetlb memory with private mapping, precise mode and mmap memory\n");
+	evaluate_test(check_child_hugetlb_memory_mapping(USE_MPROTECT, MTE_SYNC_ERR, MAP_PRIVATE | MAP_HUGETLB),
+		"Check child hugetlb memory with private mapping, precise mode and mmap/mprotect memory\n");
+	evaluate_test(check_child_hugetlb_memory_mapping(USE_MPROTECT, MTE_ASYNC_ERR, MAP_PRIVATE | MAP_HUGETLB),
+		"Check child hugetlb memory with private mapping, precise mode and mmap/mprotect memory\n");
+
+	mte_restore_setup();
+	free_hugetlb();
+	ksft_print_cnts();
+	return ksft_get_fail_cnt() == 0 ? KSFT_PASS : KSFT_FAIL;
+}
-- 
2.41.0


