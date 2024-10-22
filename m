Return-Path: <linux-kernel+bounces-376805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBC39AB60A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0151F23E72
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4481C9EA3;
	Tue, 22 Oct 2024 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="TlBFr739"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5391BDA87
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729622566; cv=none; b=qoSs6EzT8eSXws+rQPzsJs0IdPoklXMsuBzKmW7VX35IvzQ1UhD+Pwb6kAX/ry2/to6jFoIU8tezTkJ73AWp/OqoOTin9bRMmPncNwrThbF7SK7Q1ZQD1XdQbqzub6l3QE6h/vdR34+UDknFJdN5RChXPGvB8AFqCvFbt1gAkWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729622566; c=relaxed/simple;
	bh=6SRnU0aMaHoh3yL6ltP0gBwv7Twz8gy9sNXQ7rUAYcU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B8oDKab9BipSb2nsc76ap78kbeUJL3TC2ZtKygla4hMlJgtfBZjQbxRHZCPk5szA2uAn4UQWo4HCwb9hpOuuoxkinGiATNU3mmZjt6MWqiWb17WO/FOpSY4eb5vYTDLwIB4fAg8Z+jZqzUKkF+NuGQq+zTCKwhxDfgxqGJ5XMLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=TlBFr739; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MEv5pr026824;
	Tue, 22 Oct 2024 18:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=g2sdBQDg4t2kpRPBBz9oL8e9hRetJBRpVWhNy
	cTyKEs=; b=TlBFr7395SQMov+EbbDY4RrWR1fFklkGYyqFBkzOHPYRI9pAagbOT
	OynAVCZ3IjpkQJcB3qTlGPQXwJvWmjZOgvd9Llt6l1ksyv6LUVEfMUpEBy34P79k
	lYXjOVtCsI+rMqSQOaxXVRWVoS4uBqRpvljqyAahMqvO+zBD1mpwY6djV5Gq2aWA
	7GfcmVbN6xyctO0+e6WiY3iiv9twyfYWH2/e0hHSPqK2MVLvEBsHX9ty9FKD1kT9
	sWSUuUVF8YLFMU5v+8VokurP8kcNLhCLX75SZZCwtmaMxmnbx+57+vVuTJH+wi8b
	Ji0jaBInyiChgiJk0B6D+s5kg9ZstSVMA==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 42ee8ujxft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 18:42:05 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 83BDA800EA2;
	Tue, 22 Oct 2024 18:42:04 +0000 (UTC)
Received: from cat.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 2A04A809AB9;
	Tue, 22 Oct 2024 18:42:04 +0000 (UTC)
Received: by cat.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
	id 902E8B490D; Tue, 22 Oct 2024 13:42:03 -0500 (CDT)
From: Kyle Meyer <kyle.meyer@hpe.com>
To: akpm@linux-foundation.org, rppt@kernel.org, david@redhat.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH] mm: numa_memblks: Don't skip reserved areas before DRAM
Date: Tue, 22 Oct 2024 13:41:42 -0500
Message-Id: <20241022184142.5691-1-kyle.meyer@hpe.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZDrAeCQeCFgs6QkC3h2qUKXEFeqjPrmn
X-Proofpoint-GUID: ZDrAeCQeCFgs6QkC3h2qUKXEFeqjPrmn
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxlogscore=855 impostorscore=0 phishscore=0 malwarescore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220120

memblock_start_of_DRAM() returns the base address of the 1st usable
memory region. Reserved memory regions can start before that address.

Instead of skipping the truncated portions of NUMA memory blocks that
start before DRAM, add them to 'numa_reserved_meminfo'. Without this
patch, reserved areas present in the SRAT before the start of DRAM are
not assigned a node ID.

Fixes: f7feea289f9a ("mm: numa_memblks: use memblock_{start,end}_of_DRAM() when sanitizing meminfo")
Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
---
 mm/numa_memblks.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index be52b93a9c58..384397d39d6d 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -227,10 +227,14 @@ int __init numa_cleanup_meminfo(struct numa_meminfo *mi)
 			continue;
 		}
 
-		/* make sure all non-reserved blocks are inside the limits */
-		bi->start = max(bi->start, low);
+		/* preserve info for reserved areas before DRAM */
+		if (bi->start < low) {
+			numa_add_memblk_to(bi->nid, bi->start, low,
+					   &numa_reserved_meminfo);
+			bi->start = low;
+		}
 
-		/* preserve info for non-RAM areas above 'max_pfn': */
+		/* preserve info for reserved areas after DRAM */
 		if (bi->end > high) {
 			numa_add_memblk_to(bi->nid, high, bi->end,
 					   &numa_reserved_meminfo);
-- 
2.35.3


