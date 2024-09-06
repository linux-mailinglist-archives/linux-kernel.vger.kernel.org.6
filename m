Return-Path: <linux-kernel+bounces-319298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7C696FA40
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E4F285323
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90CB12EBD6;
	Fri,  6 Sep 2024 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="PdoZZFnL"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022077.outbound.protection.outlook.com [40.93.195.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C334C433C5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725645610; cv=fail; b=dxEKlJpMG8vkdTKSqzAzRbinM08Rdzvy+SRGmIjSwSE4Zf1lZp9btEaLY0IBYZxEY/S3wJeF854QBCFR1puaCSEe9jvSt8ecvI97XAdQzUQU1Rkveb+7rY8ndjx5B+A6yV8SV30Sg5hLea9dcEoCpdqeM4OobcW7ZtU5dzLmCWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725645610; c=relaxed/simple;
	bh=tXx26WTRbcKC56sJeTm/4CNHeCWl0281W6iDxrTTTYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LYaGC35A15ZZM2WDddUmUXIExlFOkZQ51C/TkREJ2slRsYso0sCdpmUCMIlwKQAztAqLf5Ds7jM/DDGCakwYmZbRVRPyMH8Mp0rGbMr206H1skMihKvdlGTd84rRQHrDIWH/FVbNSXRWhllEK09qUhtGU7X6fhqD74iPwQnkPz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=PdoZZFnL; arc=fail smtp.client-ip=40.93.195.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7MW3EOyqcvvzPYUoPLshymHRdy1m7pCEFTSngF1VcbEp3Lakgku7Oqvy3jeeUqXE7fZ/K01BQ0J40SogeE56S6R69zcSpnCBgh7bcXJnFnJSCTZLRLOpCd83tYRrjpfDPCuMhdQjc6Kyrlcf+RTyi66sNvkzc0msF5UQpK/6x+iWVXRUmLWIGZ9Rm+H6pfJcHfP/9KmgbkPOOVR8JXWZ6pCus3Mmtz7inT654vlijrmpjRNqNqXnXM3SLud6FcpUj1fJ6F8MAwQV1MSqNemBrGfbfRNBA6YcWtRFvUXRkO32JaHy6HCoxxHtTSll7kDRg54eMktzCgYM/zm7RMlOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZEmI5ze4VGJmlbeh/nIhqSgSXgQnJWJLInFVw0UZe0=;
 b=uJVE7MzXii3PlQbLNNC96PAVPZewCPjSMdnM8pD0Pbsrp2M58nXJzkgxonLGpSTADKnWOru6SMKOaNVlqNTQeSjDYW4kAo9f4rkx9p7qru9Q7/NpeJqzFqzGHkum/PMagPIS4TyBudNSssr2wHjPwY4jB2bit3ugcYzzGd0/hcWRt6LlUu8V4qMGUXAk1+CThF0h7wbhtwubMOuGT37UW8hALUYrS18qdclEszMKMWMBoIVPZtnLOgXbC/zd86T4x/U9RataiLPQatMiez4r8m4RFl28D9XQFl6mK8jxgyzJTET0PNooCls92LiVMGftPg1f4I/CQjB8nhTu+HTTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZEmI5ze4VGJmlbeh/nIhqSgSXgQnJWJLInFVw0UZe0=;
 b=PdoZZFnLo9IW411W6Wc4bb+0uUi/uDn+x/Bpo5J6/DnBSLiI5GJy72E/kvEcp0gEfpiZr0N675Aasva10Njrd457mCv8lL3aACy36pbCC+gfZts/c6V1YRHaKJaxeAcVupOhb642ta/YdNCB0PsntdzvImsY5f0Nm3ARufEh5dM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BY3PR01MB6561.prod.exchangelabs.com (2603:10b6:a03:362::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Fri, 6 Sep 2024 18:00:04 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 18:00:04 +0000
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
Subject: [v3 PATCH 2/2] selftests: arm64: add hugetlb mte tests
Date: Fri,  6 Sep 2024 10:59:45 -0700
Message-ID: <20240906175945.3636193-2-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240906175945.3636193-1-yang@os.amperecomputing.com>
References: <20240906175945.3636193-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:610:e5::6) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BY3PR01MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: c218cdd6-f292-4938-b274-08dcce9dbc65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9OqSYQcfg/sxUNkZIfds67YXtT3/DIAZVRdwoUAI6AcaIxPedGZSeopKN+zy?=
 =?us-ascii?Q?6DRn2L80HozR56qA/mnXfRgbFhqZ6T+GIgamgr7rI8WeFSdWjkuOq9AFU2o/?=
 =?us-ascii?Q?74O+p6aYli8TuxFqpzN0jcUtb7UxCQZvYdG4EtrmF5JXJyZhZc2tXeCu+UJ9?=
 =?us-ascii?Q?7uWZUo+6KbDVbvdFg7LSnvtEBZfY0Ga1eVrW+cXp7NidsvIlzdCyu5wJBSJG?=
 =?us-ascii?Q?U6hpCG9N8gncRsr1G0YAw/yI9lT/r9fdZMVhUduqRoP2R2YXSwboKOtL39sf?=
 =?us-ascii?Q?kcshjyhd8O2AG05H4w1hRp5iGLRjjk1pW3Sb+JaVju3QVByODPqanOsR74xz?=
 =?us-ascii?Q?BxEO/YGMSpJKZLPWS7+JhO0IkUO0z4XA0jSz2g1iP4rkbkN9iIAMXjiN6pZi?=
 =?us-ascii?Q?8JCvbK7i9ippbV4ADiT3EPD+bwkXs4ta7lYNFAXuHodgdpp1/UPXorOLjcvR?=
 =?us-ascii?Q?Qp6669ImP6VMmPHcnZVr5NoztVTsQiGGK1XbvRqjWa6O1O/x523uoyoMPQJO?=
 =?us-ascii?Q?8isfLkWd5PRB+LMIFftfACW6v5LQRUgOgq/A0ozCNVfhW1cny4SFbIDxF/Wd?=
 =?us-ascii?Q?TD8/SVmB+rQ2djvRxPcpmzyYNAVFBp8CyOQo6qEfHO8YI7eapaKYfNHUonJm?=
 =?us-ascii?Q?Bh6YDuuDlCQf9hK8uynhGLdQRnCBf9zG+K96zee9o+osHRGYDR6JYOg+7n6h?=
 =?us-ascii?Q?xa9abv6ILKfzDl82/MIHQoh3V5clUiem7fbJkhPmc5yhsuAIoGJgKSnNoCDL?=
 =?us-ascii?Q?riNRtpubb2pBblmbfda/TmWIwZl2wnYHcjlf2tEt5fQFYAd4zbk8qKFYPhrQ?=
 =?us-ascii?Q?eEqFbQfUca4KXJ+02EQRP7fz12yi8ZaSC0rEKX6qGg+cSS40t5w4BHStaYP/?=
 =?us-ascii?Q?/ZFUisDiHAKZgpW1TiMRcZYQFhy/nmXhCX9dNQytxwFUy6DhgR4yVTdQI4kc?=
 =?us-ascii?Q?Kw0qY+VqFSYL8/cMTUSfnjpwP905ONqIRv0T7a8jlCmh5zT+l3t0PF2TVxGO?=
 =?us-ascii?Q?kOffzY5gFDvyJieKRm2QOaEBKf80U/m2drNMLddjSxJWFR1Vzy7kAj0nQUc7?=
 =?us-ascii?Q?pU0vJtI053/vV0hSE5DbSJK/O8axa8S1UmHi/NVaM6t2q7V94rjsfx7XxAIy?=
 =?us-ascii?Q?/dcwyJNdln14ykKCCecipRFZ5p6+JCN6RhEL+F2MIloAxolu+RM0ERRKtAvy?=
 =?us-ascii?Q?DhLzD57Kpk2hq4WDnUyt0w7U8zRukvqgITstXicuNbeTxBgbk+p/C4GETraf?=
 =?us-ascii?Q?WMTmVp7EY/RxiOwQ4Vv3nRIMjs4bCB0iwNKoM/kDbRXLSutQ9UIiiOOu8y3N?=
 =?us-ascii?Q?tySS4vBDzr2+auaDZdkMO4bkmxQe/dw2VTXFzCb+KSEihxhDuwJEBoRRsj6S?=
 =?us-ascii?Q?sCNp5/t5GiYoxKVqLPAohwWCzYJqUHN8/O13MHOWc1BS1A16eA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BhAEOjlHXWFktXh5qmzQ+VvirSIG9iYXUtZO4dAQzjtFsbBIZreC7v+CAS2A?=
 =?us-ascii?Q?PmRRoDqH6lSwHGlujYd9VKEKWA0VUaW097as7+f3LcoaJlpdT7CdASXuLjq0?=
 =?us-ascii?Q?Ux/bnK6ZbjYtATzW89BJqZ3SYFe3toZi7yaHYUubrdTS5PYnARUdKbd80g3Z?=
 =?us-ascii?Q?o3bvdVdfVyl1tTMrOz3x9g9oh59nCxMRMhSSL1Gaek7I/+CR+o/8x7j85X3B?=
 =?us-ascii?Q?6dXi38YAzBInDlybwi+gtbjSD1GqCe0esp4rUpjL7oG+jQLyHcax+BKu9pn9?=
 =?us-ascii?Q?vPnE/7qdnURqgLeOThcHemkzGblWqH45Jz94x0lpGvHaBRbAgGlfh+dqBjct?=
 =?us-ascii?Q?cnwOWRgYBEZCp/ti/A4bLSOZEHGOdwnBnokFa1yJk7iJMr5K/1WcvpSi849H?=
 =?us-ascii?Q?Ixq7MD7clujjHwX6/iFzjAusu892QeXPc4hsv+cs2ouWUEtvlYCiwSBVOtL3?=
 =?us-ascii?Q?zp/wcqabZ7DdKjC33vqnkR0fYHsMGv2RdYLenOTYmOvfV/onWV5yyWJfvsu4?=
 =?us-ascii?Q?jH5kDlReTYvwOPhuZe5iOID3WMncGKh5ySrC6/0KXzDcSZj3GE/k306juWy1?=
 =?us-ascii?Q?qmNQU8QIMx+a88EbMzhxL/yijENOaDcqG78SUU2Jqh43vXLMz8FdfW9Q922L?=
 =?us-ascii?Q?J9PUQYgQXw13nOSo5mb3dHGmUTsQ0DSAig1c2EGgfRJO1ZSBIo/INcHWvQqG?=
 =?us-ascii?Q?72+N4JaHPYwA/2TWoDhyDkggQAr4fyn0BnqQCnj2DoF26/WMR281MRl02jdU?=
 =?us-ascii?Q?BclICRbjkYGmGwoUaWqnhm/nJ0Zz5jsdUWVIIlbR5WyLmnX6d0dTMuEB//to?=
 =?us-ascii?Q?Sg4iEkGUK1g+5QsJnz9X7i6l/JjOBXbjhUuhcUeECoVplZtKo1gtXT38ujsW?=
 =?us-ascii?Q?dN8vzarJQITonmnkK1Or5QMW1rqbblqWaAfY1vG0+DxcukWrQd7ZMmPj1xbM?=
 =?us-ascii?Q?Osm6cYJHluGKbMp2GPJA7CrxjcXU+CkMtrfriJezHJbDGnywWJYY2yTUXk8J?=
 =?us-ascii?Q?c+GvBCUWhQzttXOCqQ8+bp/DrFBg2a0JoGvr9sGcH6XwEQZSDhVuEiV9/T9g?=
 =?us-ascii?Q?ltzQmpsSAKn0XSvDnURKzo+v324IAm2Bk7SpQZAQQD4N6UTT8QaRORqG2YJx?=
 =?us-ascii?Q?0pGVA3kQDdHMIoPq70rl/vweyxHi9OwPtZpKzPeS1yLfmbXYr5PufEFVx1xn?=
 =?us-ascii?Q?QxArl/2NIoDNf3pZaEy7zUX7cQNVmwj0AAuwAqUXpbZzJ0wTB962/RomaYbo?=
 =?us-ascii?Q?6zW//3w230YP6VNy5l/YX5kS9FEA8JJEf3ortrQeUtaU446WZDif4w3PZ3fW?=
 =?us-ascii?Q?APV/dhhQUEDY6Q4gGAld9YF5ZGWxGYF9d288faw9lg3CJvQ4YniRsYIDXlFY?=
 =?us-ascii?Q?0VEyXxC+1FAEO+1cmVx/2mZSVku0sd2RsVbVHMRgsPZ6GT2/WM4zTrLyS4R7?=
 =?us-ascii?Q?8Dxa34+4KrN8Y71mCaYJaf43VBSaYLRgPOdAilOuURh3nr4SmDHPuXuBzY8G?=
 =?us-ascii?Q?ZQlPcApuw2/lFVHTeEapADxPWHVORDowcypsoR+VsEeGgIKDqJ/sJBzaLUln?=
 =?us-ascii?Q?U9Vxn7ihtZ+3m5sVC1C0n9dw3+pIxr/JnW/mknQ1COwhLjbpBWR0dOHPYT/l?=
 =?us-ascii?Q?Dnkj6E+4FHfU01e4MHdJ+N4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c218cdd6-f292-4938-b274-08dcce9dbc65
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 18:00:04.8513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrFN5SCVKP/JZXLL2ZZEWuJBkDpc2i8ztoblSeDfUTNRa7Wu9N1MIojppy9sWMJ7q19WL+wYWmMhg1sSMEHAPDQ9VqNiXhWcVDUZACsdjec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6561

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


