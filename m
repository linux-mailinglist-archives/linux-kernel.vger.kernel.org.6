Return-Path: <linux-kernel+bounces-327247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EEE9772D1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDBA283969
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B93D1C1752;
	Thu, 12 Sep 2024 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ijO4/GNK"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022137.outbound.protection.outlook.com [40.93.195.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7498F1BF80E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173712; cv=fail; b=o4UcIxdUUsur2QN+gYLxoEmwteGeMicSJX7b+JUu9Eg2mFWLLYMADqyY/hKcgFJKsZUR/h4Le4O2Xp5qyxPSOwcZQF7Cjt6yQYD2Ef9RkehytKWgaVmQE/i7jqEG3azK4QCz/0ad2g35+U5b9EIlzL5R7WYT0XBk9HJe8IXI2dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173712; c=relaxed/simple;
	bh=tXx26WTRbcKC56sJeTm/4CNHeCWl0281W6iDxrTTTYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FNjRjxWpdu7jvoCHQsf2BJmjdw/1T76xfpCEbmWwm/CGJMUUheCWuJwi40s+PvcCEBWOGVtQ5/6mClZ7NlXV0NW6Y9ko6GQmep7aV/dNeNPnHMyV623V/0yKmpcC01Meu8oVtMRbS7Og84er71j1iMijSS+fTdAn4Gp8D/0CCgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ijO4/GNK; arc=fail smtp.client-ip=40.93.195.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cyh47sI3XM9NU1NAi6CD+jJYK6MQaMuQVsrKaE9RGEc3k2Rslf5cc7lQJgzSIHTq78TZKBLnfUfPg+1qVFYohiiTuD3sMK+2LgTFGTj3yYjOjIz6MX0Ohj1Tv6QRQNfU3UTyJJiisBTip2nPaB8tgsJo4R2vhZ+wMJi2c2o9XYQAMDE9maX1yFFbLdLfVWcwBXKVsXGj/edYBKWdXOhXADGxhU1DBbPd9zIylxI5IkQzNcfvimw6t1pl6Ehaeznp2nMYs+yb4PBbSrOrkoFGfAgePVzCrMlqB08lfvDcABpz4im3V4bzDkSH2Y7NY7E0i/wtXZJHahR1vLvKJKyBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZEmI5ze4VGJmlbeh/nIhqSgSXgQnJWJLInFVw0UZe0=;
 b=DEPqP6CX9e24Bsqb78rSZpFVdj4aSEarDvjU1ntlzVEBk3Ce3CYtnDj/hf07dU0RDbiSYUd0tPCf4pJB8f4F4RqpRBpZM5LMp/jNFvj6s38tAD8PFmCdcalhy0zw5ZNhhdZYT1RWzvXMAAYvB4s8ivnrgB4G53twgZH8fFBpYQqB66BIOEfYcnIoO/Bg0CupWey1lZEaR8KoyyGsRa1pjmccSQ2pblFQIsg/fhuxdj5+FNdsW7BpZtsXz4zhA67Rm6xgPtdYmKOoqfkxP664mLXb84/dNXyRymTCqrZ/79bEZnydEtNwIO4TcOOfNtaWij7pou8YnUvJrd74wfpoHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZEmI5ze4VGJmlbeh/nIhqSgSXgQnJWJLInFVw0UZe0=;
 b=ijO4/GNKEkuaL3hG6VlkYUZIDgl6phK5YHAhgDpAnILSw7++YrCNVKYiLSI3O4kFRtiZtvXJ5HqBNLXoSUin+5SUHWPOOliXoQ4TJXfUzV7U5NATno1K1BFueK/YXZjoFs5/QplXvzGT2nCjvpfGl4oaisUMMCEudiYQbJ+xYPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA6PR01MB8853.prod.exchangelabs.com (2603:10b6:806:42b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.25; Thu, 12 Sep 2024 20:41:44 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7962.016; Thu, 12 Sep 2024
 20:41:44 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	muchun.song@linux.dev,
	david@redhat.com,
	akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [v4 PATCH 2/2] selftests: arm64: add hugetlb mte tests
Date: Thu, 12 Sep 2024 13:41:29 -0700
Message-ID: <20240912204129.1432995-2-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240912204129.1432995-1-yang@os.amperecomputing.com>
References: <20240912204129.1432995-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:610:77::6) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA6PR01MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: fd04d617-291d-4888-6c1a-08dcd36b5060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y6wv3yUqu+hxkqdL5HxLHDpLiQi3nE3FjktHpeFJQThBHjTbJ8JcFTMLrnSx?=
 =?us-ascii?Q?kZJynz0u7qIRXPKg+u+SQEvu9knonZ0E7LG5xF61fG2c7oTYSr1GhYTPD5HP?=
 =?us-ascii?Q?r9sTBalyoLX9i0HS3jB3Hb5HnSOmoIU3Tl2SYMfim/ZOhQMHjs4WosBBOE40?=
 =?us-ascii?Q?A20Fk1Qb7NWG0Mo6jSqXojyJ4onmHulHKs7Zobvl+OYlhRD4ZE4Q1RxCFnl5?=
 =?us-ascii?Q?Au0a85GhWaxogbiaMyvM3W5tTtvlIKE5DqC7/swRgf6eJnBKbMqVmmMAlnnQ?=
 =?us-ascii?Q?1dKYYH+kSKoh/Upt4R1RJdtbjGKICzGmU+BgaUVE6V0IU/1/6fSbWywbDhDK?=
 =?us-ascii?Q?HG0XIk78OOLHNighnsqm7Mqs0OkzcIH+bkvEN2Z1xbYD3N5Tad0grrj4pwjf?=
 =?us-ascii?Q?rPZsn9W02SDY1v5OQFW/t0I4xu/hFPsdTbDIPaKQQ+8y8MiD7a4XkE7R+cYJ?=
 =?us-ascii?Q?5fv0Odkf4jEEorb63r9V9PdlubnOLSGNtjYnuXuKdjwU8zbWRD0qxs8YUVOv?=
 =?us-ascii?Q?Akpx92hba7eWV7vn41+9jmITZWIVeIYPs9HUTmvVFByzHhOUo3fjDqIZi4lJ?=
 =?us-ascii?Q?eryYH96NBTIS3OBcEVFVBk1oHhcUymheDZQJ6AQ9OgRUT8uz5cJfgjcXMGKU?=
 =?us-ascii?Q?Hs3BrLnBheMtaH+E/lRlaerbivbUIldIiugdvzZ9JsBPyeNrVNopKnIqvGtD?=
 =?us-ascii?Q?i1hxZJPva0A7DxpYfl8tQ1Ssdbh6AsQMP3TiUjsrsXlhmoTUMbxEDRobfIvy?=
 =?us-ascii?Q?Zxenn16LcLxe3pYx5L+J7aHhVj9krieluovJUSFuUvKNkJDohVVRIkUCewuj?=
 =?us-ascii?Q?3vOEwmtxZ8IVSw3Ey29FVyWdulkN3ptA11rXBLEkGs8jAekJIfzpNqE1nHu1?=
 =?us-ascii?Q?pR/tdp5r7k/D6JOZFtehvnSbMPNPdOpz6dq634KJ08g58FU01y39nilMn0w+?=
 =?us-ascii?Q?FrpY+TrLAM73Sw2phbG7LRHipfN8vrMM3unKS/V2WplFzADlDb8Vc//7sM5p?=
 =?us-ascii?Q?R7fHDCig6Tf7bJ+RSiBhjCa1Zb5pauhytL935siWXgWlQSBj9FVdfYEbn45z?=
 =?us-ascii?Q?Ny8tGV34q34nP9s8rDc+D60QbexL96EpF4wWzRLW2W4G0QGUJjBd0c/SYuJV?=
 =?us-ascii?Q?e7WZAxSn4WNZ2QYaF1SolBvk73jhMka9hcRSora0wQiGybepsQhCV/qaSg/E?=
 =?us-ascii?Q?0Dc0TjXG4zw/FxtrobInbKoPMyaM1kiAHgWUdTwdMq7u/LQfGt28oKlc5zkm?=
 =?us-ascii?Q?epcEycWfbiaWuM3NAVYeH+6hxqWZ81R2zK+pawC5fEvcfQ6AmEHskdws7bBP?=
 =?us-ascii?Q?dJ1g/RBwlL0ABVNgplSe7L9TmOG5/ykSd62sPtHie0G8oFRctKEQf/yYwT7d?=
 =?us-ascii?Q?saY24t7PnBop9EcVR1pHpAhgYT7kD8dSmuakn7mZL144P8zaig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?epCtaV2k2+PbK0uAoQXcNDifEKRuk7gw5efaWU1w8py5Bj9gXVOo2GGsXNOv?=
 =?us-ascii?Q?e7r3Sm2Q8W3Vqh+iLZU0kiTvXhMd3w7OEGvzmveUdD0xdCq3xpMC5nOJ60s8?=
 =?us-ascii?Q?zwTHCWFYlYBkBLbSVwRoUCsvjDntATIG+YKDCtGM7YPXGoVURl8NtDIna0mU?=
 =?us-ascii?Q?yVwdvP6HUk9cR1vHMAPFRqzWKKLuNL9DapZ+0WL3BjuZr+20dTPhhqE7CJVM?=
 =?us-ascii?Q?C4k4fgO8rWbhDYIRmypa+fQ6OhaIYslgKrmjTMUiecjIGOwfGWH0AKkNrC63?=
 =?us-ascii?Q?j2XT8WlE93g0D/qPexcq4Ar+F2Xz9qNmSTUYS5wwKnVcqHIToGoB2aYE27Op?=
 =?us-ascii?Q?CfsNAZTFjqo2SSvP9o0B2eyUXkGUUfP+O1AWmq8Dvokns2bfC/7f6sYbg0p5?=
 =?us-ascii?Q?ZfgR2jDrb5xFewztvKYFI6N8YW/5SGqds9LGeU71Ci/aBaCb68xWO64qysq7?=
 =?us-ascii?Q?lWfmYB1D1hWvI76wKuNQ/cIuz+VHCga1WNrDDPO2vc/btHbIfuRwMyz05D6G?=
 =?us-ascii?Q?t8khTGl4JPeEWVBoQTpval4Qjn2EpQcY4pbWz3bP4babpxAGTzEAjQhddjfK?=
 =?us-ascii?Q?SfAV461/OUhsQPMzmRoC61sgQZFedV/5lO24GfO5wMKs+CgZojDCVPjzMAXT?=
 =?us-ascii?Q?VSW126ID2kOV03vra0ofFAc8l+Pnh+DoYe+Q16/Vs5c2mDm697aXko3JDjG2?=
 =?us-ascii?Q?oyx/jiC3OsK5Xqh41B98NxkOV65qonwUQaSVqMM9y0+hxERKSPljQJMbPbc9?=
 =?us-ascii?Q?TViubCGENT2MYeorcYWscQ6bC5ogSPcdss8znt0v1kikQpOBjle7FD/xvbp5?=
 =?us-ascii?Q?fZjXtcT4429eHFvzt+e92N1AEObW5K9Vmxt7IgMRSS7ckukWBLPlk0s0Ib3A?=
 =?us-ascii?Q?3pMqmX8l8j825ShB81hHKU1gaSChxXEU4FdUyGPDV8ZLCgvmbQpGabm5B7+C?=
 =?us-ascii?Q?Zl693zstDLSIujl1cuAOLgRAPzMa5nGMQLUn8j8o5MpYNrjdAFRbO6KHTOeN?=
 =?us-ascii?Q?tUJwX1jJhMzuIfDYDpFNSbw82z9zi7CFXJ3QHaC959kw+oBZiWWt/vWTJz6d?=
 =?us-ascii?Q?Eiw4Igpq2OS7coRWBm8ybkfNU71qIgWz/A+eP45xzv+kmzCXSiyeDKKcNrFm?=
 =?us-ascii?Q?uTv6630ZnjinQMLmVtMzRNPxLu6qQfbmzQQS40rfioQKJScsCxFyDzuFAT24?=
 =?us-ascii?Q?9kXejxnSnVGtxsOsRMFs6LLoX5Z35vKtI5dwvlTwdVjcHdD2f8GOmbw0RMAZ?=
 =?us-ascii?Q?6mep1BNLeuYApTZzr22vxYTUL++fpo0hIHQOE+hzTnJkfiI4zg4UZUpnXE3/?=
 =?us-ascii?Q?F0zbWv52k1JqyMhI//gUrp0JsuV2oMB9DHWO67QdZ0XuKmbkYZmbKi9lb3c+?=
 =?us-ascii?Q?L3ASSBHkKPyFZ8LIrH0dIWaTpaaSZL7t5SKrFTb6EFJtFORzkyeKu7Um2flo?=
 =?us-ascii?Q?N36McB78jow0XqR+Wkql0LCO0CrK+5EZCPmfoZwadWonOkH4EvxVte69pEWF?=
 =?us-ascii?Q?1xrG+0nsTUeWfnkkwPH0kjer7ZTn0uux3n0Mw/HOrCiqfONs5egtfsdLkRTx?=
 =?us-ascii?Q?7+ldAMrWWFURLtajC+HjUYV/Hd1KChBNvmVK6Q/fnoOMRMHqHGvZ7UFKgOj6?=
 =?us-ascii?Q?oxyz2VamJJFp/tXEarb8TqI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd04d617-291d-4888-6c1a-08dcd36b5060
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 20:41:44.4482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2i9lusvYMSA5fp5qhgvQgGJ3x+AJFZ+Xr3N+COZoVmET7x4qPfk4NNw2IpRBaqS401oJxs1BsRMF6XBWEcktSGq1U/ZAUvkv3L4s1n0Cpko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8853

The tests cover mmap, mprotect hugetlb with MTE prot and COW.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 .../arm64/mte/check_hugetlb_options.c         | 285 ++++++++++++++++++
 1 file changed, 285 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/mte/check_hugetlb_options.c

diff --git a/tools/testing/selftests/arm64/mte/check_hugetlb_options.c b/tools/testing/selftests/arm64/mte/check_hugetlb_options.c
new file mode 100644
index 000000000000..303260a6dc65
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


