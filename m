Return-Path: <linux-kernel+bounces-328730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0089787F7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180C4281B11
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7265B126F0A;
	Fri, 13 Sep 2024 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Zrtx9oV/"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020122.outbound.protection.outlook.com [52.101.193.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E68B7B3FE
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726252465; cv=fail; b=dxtYiDnd6P+RoG2uZXlZ+yG38OJq5HnSrswIyFPiOx74yuk+65sDvQtKbjKHRe5SR1VrngVl2eMLz2wL74A6/wbGMj0OPq3WK3QfDFrP5qdu03PUTS6ZPP4oaYhofPVZ7GH7/5Rv9UHNgWY8xZmrhVWptHeChBSpQNT4l7iEaCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726252465; c=relaxed/simple;
	bh=tXx26WTRbcKC56sJeTm/4CNHeCWl0281W6iDxrTTTYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NL8FfnO4AQlCYCqv978/HCIY8KoWHeDPHYznznQqQi0nUJzyIGOjl6jAjbxcjN0yR8sNtNzhI8pfAgdOzTaEgtSprBTLsM/9jpBtquP3efPTgQZuf0V5Mw9h6L1UawZCnEGvqpWLiFv09ZkEQhyuYy50rsED80w/VJguOg5pqAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Zrtx9oV/; arc=fail smtp.client-ip=52.101.193.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmCF7dvR/FjCV1qwub/s9tNXRRmjtlzkSWB3Tvsy10YUkXgJgKJ5aMBwCG7qrYj7yaOlGza3wPwhRcggYo1d+i3rmpsheMHGzO7DpIb3HpTHQDT6qtXNRrLM1nVO49CHjcHuk53Eb5kpjgbbZtkM9jsofHUdUJ4n6pmxAhGuxocis5srinMg+QLn+2YB56l/E9C132rrN14TSzwuIgdgMrOnf/+DG1qTmiNt/v6uk2eAnPyC4vDiKh15hqyMFv1hjDHDwd5rOausaVlslUR3r3TnfG9WkLofNLvuWdEHMc2xOVNP3CkQK4Amn2H80IFEGgu/aqtawXDN/MlmHC35hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZEmI5ze4VGJmlbeh/nIhqSgSXgQnJWJLInFVw0UZe0=;
 b=bbcmDfQNrtiLOk2r054DFmady/Wf6hZ2oKFKrLkxtz1ySVxUThWYp449EOUcfGp7cZSHQGNj1qCdH6PfG2xdw+9255rgFqoIZD9IzMcQAlIH2RJ0TUJrZXbDgPuoMhqMEe1meYDdA44j8Hvw3zt0XuZGvnKOcE+jm14AWkX41/FI6PJArXzgGCgwJqP4PXHqBRSyRPmIULjg32C22s3N/laMDj6itCZeMhvj1Hl38AfMgaKc3x9O18tx6GRKUZHstuPcCzcQibu07qQALFm7pkNsLbb5HywTmMIFdbqeHKBr2GLxVgmfoBeU7J4nfyd3jQo/Fi/GE2urzZIPGgcNjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZEmI5ze4VGJmlbeh/nIhqSgSXgQnJWJLInFVw0UZe0=;
 b=Zrtx9oV/vfHz0onxikINXskZw6YlN/4gZN6DZFpmInASun7YB2HVK3BKEgp4i72TXysO+BTAIhQDiucraSHtuQe+07rlfr/0NzKfJPgrjoBuHIC1WM6WBdrOxGYfpKFfoNZamYBJEhxl4OXmOHMxaLWyXXv6dsnVON+sMAW8lAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MW4PR01MB6114.prod.exchangelabs.com (2603:10b6:303:79::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.18; Fri, 13 Sep 2024 18:34:20 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 18:34:20 +0000
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
Subject: [v5 PATCH 2/2] selftests: arm64: add hugetlb mte tests
Date: Fri, 13 Sep 2024 11:34:04 -0700
Message-ID: <20240913183404.3517556-2-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240913183404.3517556-1-yang@os.amperecomputing.com>
References: <20240913183404.3517556-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:610:11a::7) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MW4PR01MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ca3337-9482-4581-d717-08dcd422ae81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a+3a74xYbR8uKRx10orEXaxyAnKHk++WiPZ7sxiIdIb2ZgON3WCHGjaCdhKP?=
 =?us-ascii?Q?8AwcOAwAbMWUWuYuyXWnPteFCiMVHsqtieMBpHg8cSRJ3QHrgJV/wP0UNBWQ?=
 =?us-ascii?Q?DDGyThPMJYm5GJl1rweJpOjEEVxf3tHdj80Csh7uQ63TggJsxLb23/OSNGlU?=
 =?us-ascii?Q?pYCSNPtL9xvSSn7eUQwSs8F/UN9lZRXQJ84WvgAuuH871u8dEeGZtdi7oPjV?=
 =?us-ascii?Q?TAYZLl/t1y6Su4jRnifzeM3a02Mz9+T2xlb9NAaMvfWfvACNBcT9iGSjdLQ9?=
 =?us-ascii?Q?hZAId0YzWGybo+cOQoqTK241ve6G30t0hXQwH6eWHkkWjbEymoMFxT6k9Sep?=
 =?us-ascii?Q?9RfsQKEFIUXf8cvWO4bUfx/xagKUwrX8RncLOuW+VGoIAeYAJoDfhVehpWZx?=
 =?us-ascii?Q?IRSFfHSdF8n7WFyE2Yxkoh7oGOjl9T6B/1our2oK2dBNZTh7UcexDKe7xfGj?=
 =?us-ascii?Q?oyqIR+FgYsE60k/36zSEZI9a42Gt85sZOkNRQhoXWrI1zmAe7xrqJxFT7XJw?=
 =?us-ascii?Q?cQwplMdngHTwt5wY+1uet5hxOILxZIgDSaKmVUEjp262pmkugqo1vsij33nF?=
 =?us-ascii?Q?X1WOOPr4rhDNsoSyBSTmmS0J38mkYJ47xY6BkGgxW9nZ/6UPcGNcrA29Ihug?=
 =?us-ascii?Q?0YUJgiVrzprGKJZtwifePm8vVj7PxwD1HC+pNdbTvpy1bYBijEMTCosqc8Tb?=
 =?us-ascii?Q?Xljg1c4OIHGk50+DNuBtyB4GDZ+CCiPBeWGHDSeHOteNgCCbiRV3HK+YJzOC?=
 =?us-ascii?Q?F6mP2XMi/Um76/1GbUJfQOrHtd6PzmmdXOzRjba/BTZvGNrrMhiSVfV0yUMA?=
 =?us-ascii?Q?8PGgXsrPri+KTd65gz5UopmeBZqhgyvT5mPgFUa8Ju9My7pGTh78MjpP8moh?=
 =?us-ascii?Q?oDdWUwdv6u9tduHChj8A/Gj5gysaZl5RB9GrpU9MmW2sb9UOey21dGcGjE6m?=
 =?us-ascii?Q?JJ6UG1ZxSYw1fD88UgmeDC/PI8Cq49QWG6eU1iGpSL7uULbR4IX5tZ+imNoU?=
 =?us-ascii?Q?qBywcgqzFSSGcoiYKryjrjM8zumSwNtSmd4+D2HtDg49YSGSBgEnJVfrnWI0?=
 =?us-ascii?Q?bYDxoaovwhz5wrK7Xb+LR8i24EtkI7uNmTahqQnSguB3Ht/D8+E86QQezJe7?=
 =?us-ascii?Q?G97SwR/rpDgkJD1XzPJxfDjLzWx7GwVWL6hyhWMAEmCbzRfylKCNiynauNot?=
 =?us-ascii?Q?nHLdMdVkiduq8Lw9gmFoZ6Crc4GTzt5NFnBCNZCa0M5jvPsgjnUeLGf0MSuc?=
 =?us-ascii?Q?bUHPXd8UjG+Mn4rXAmP3MF+SFMnUgZl5hvHDtgxeuVyXKP3gH+wAkXgbPx26?=
 =?us-ascii?Q?jHv+PVlTOnfmDlPtYVkAzuvzEJVFO/b3j0upzUpkbJCHtTnRNlLaV/FgcbKI?=
 =?us-ascii?Q?+SlDHBlHJcgLpvdtXGVu8fTc/JntwGuUgHSDzgjxDkrhDrgIcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+unckT9GO7gIF8r2vH0uTPfEe94ZdK2MQZ7hNei3r6TNz92qn2weqG8Rydm1?=
 =?us-ascii?Q?+qOQVnOIgnSorQBqnCd3V7wJuFuzY+g4TOirVHeuIsh5bS7TaAOiVZT+2Hdh?=
 =?us-ascii?Q?GSVWOBB5huBqTI+8U7cD3sBF6+F89Jfx03U1srst2hSc+2BCPhkCfzP5V7pa?=
 =?us-ascii?Q?fmv+lcdWeE+xoKrzimpr4kgPK4hbdsKIKrZ8xAI02iSq4kPp6Pvu1XZWCRI2?=
 =?us-ascii?Q?pzXk+BzpuvjvHiUjesRVuhYAVY/H7H22XQtAQGDX5UDFR1xsTwx0gJtZxVvB?=
 =?us-ascii?Q?yfaJF442fwV7PpstOTbe3ZCJ4kLl7tJkaulVYUpBqMbf8kSfc5PxsrX6PJJ6?=
 =?us-ascii?Q?0+ru/VUd0wDGlO4XxASUbfAGGOpD8oDDzDjWxFRVV4rKRKL1btRnNrgWrYag?=
 =?us-ascii?Q?iOK12tOKmKPkPbPQtTkVlPVBo4BbU62fEvfikEd2dRiFxDJi9GCdpgPbvGI5?=
 =?us-ascii?Q?p40Tuv0P8uJ9FDJNbGGwyvUg/pD68jVWtXAg0xPFUKEgOjoq9KRVz0hm5KrB?=
 =?us-ascii?Q?SCjf4I2NTRDEwyK54Pmy8eKx5zO60LC00M5DnLoxKu/WMewZCqZF7JL1dZgj?=
 =?us-ascii?Q?PAlW2EMC5/lGC7nV+vFppwfO4+oDgwuot1rQHDvQsX3VuhlTjTxfGrGA91GF?=
 =?us-ascii?Q?UI8moBcalh6XniTxNp0gDG1b8CfpB0fyGwJLHc5bPJRP6j4rZi5ltyVCeFiH?=
 =?us-ascii?Q?+aB8nHWvz9l6hs1fo2WjSq3bBGrlmoHkEA0oeQw+PU8MTIs+Fa92a++UoMcP?=
 =?us-ascii?Q?gD2ssQA9w8TUhJLM+aLfQt/8uF9xKRl+EjnaqdYjtSB99c5pAIAjgcrN1WRs?=
 =?us-ascii?Q?Vt5uhDBgzCW4IV9X/7IApOTOqQ+HeGnUTgSFyy4POyoZQD+13pFkBy4dfW2V?=
 =?us-ascii?Q?uQEUFZlpRtwPLQbBwQDvIwOymEOzMWwNDFvoZHShorlVedrI2H4/o+2Szhdc?=
 =?us-ascii?Q?alfUG75Jbjh3uNk07Vzor7QE5poe6o2xeYSJKRLsb2k5uarRO+RtYlykQViI?=
 =?us-ascii?Q?BjI3U/TZdIbXSsXj13/eAQ8T6lDCbUdMv8s4SpIdPlKWVdnaK94EJl4IX8UW?=
 =?us-ascii?Q?LweTllltzDfU99DCGKwn4I5AvZMYNfphuBKRnXhHLpdyrRMAoPaF8FekO458?=
 =?us-ascii?Q?pFP4FKSdFKZ90p0BXhjWjPgktP0SO832LElpC72YAE2kBVIQN4pZ2el3y4mR?=
 =?us-ascii?Q?ZwfiwocTE8Ip/NKR4Z9HKT8/gf1OnmBLbn8Z1qD/FrkT6W+wl2DaFWLEe+8L?=
 =?us-ascii?Q?b+eZZSokIEP/PHLzlrdCRZII73rzrjy/xEfi6HDf5zWKgd8oYflnFgBoaLKP?=
 =?us-ascii?Q?/LPbZlDV1VHrmhGvXKFT3Ul3jO8oAKSP7OITe7MmKoD8yM2uLozZYpx6plk3?=
 =?us-ascii?Q?QhEFMF8pX26/GsxFQw4Pt95qfhZ57SHB97vrMWZcqNBTtzwbco0ugHvxTGhz?=
 =?us-ascii?Q?aQ+KX0s8OMzrgr3OcuL+zh/iXgMs6EeQMkSNDZbsS4sQ36PxB41+qPKqUmdN?=
 =?us-ascii?Q?j0bmRRZ4BQI7FBBlFTVh3hhpnqL1SnJ4jsDr2IoDmV5ApFRBFSnbSoHhHBBB?=
 =?us-ascii?Q?e1oVLaKeG4TcCNTZH8DAi+1PB66uoRSSJTG+jzYzoSK2yRZ2y9Uhbx9R/fJ3?=
 =?us-ascii?Q?n/g5WaLykapFd5KQlrMz1iU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ca3337-9482-4581-d717-08dcd422ae81
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 18:34:20.2535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdfgUUTmRlq0U4Ilaj7gw/h0xXCBbwjr+KHrR8Ab6wnUVwqp/4bvUtmap9KeYDBI5u3bdTguF2NwIZ47ucrBUmxbyXqavWzOoNzcXTYY+zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6114

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


