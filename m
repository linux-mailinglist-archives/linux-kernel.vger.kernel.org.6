Return-Path: <linux-kernel+bounces-242012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB73928287
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14CE1F24469
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABA21448FA;
	Fri,  5 Jul 2024 07:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J0HDYNGL"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BAC1F61C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720163554; cv=none; b=Nv289mH903LP/IOfvMAlj7dpHABUSQmcpUnVrQE2cuRu1jOhXxBxB6yDG5F9X4CcdgbxBqI7jOAoflN/o4ZJqa4oMqWpmq5QjAzz+BsMkPMzLcHM3PD2sZZDjjUdKIrxhJ06bR4YHFabTJ2VrLTLce7XWWX0zOipbKBEWhbgLZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720163554; c=relaxed/simple;
	bh=g7MxzlQeM41sI3NQa8YFeYUMuOcxjWMopjix9W7F2F0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmDBK3erJAOczMQ99jIB9ju92PQaQRHffjhH1w/11jDfRcLXeZB9Ywjt2obSJR45w+9JEbFi0hgmyQHF2x3nPnV3JDB1G/3eIyhsPeXjc0UXd2/k7Gegdds4suGYdzHW44fBrASROOcR4fKrGnGTvAFmSYJ864gEfxiDrFa8P48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J0HDYNGL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4656QikE000604;
	Fri, 5 Jul 2024 07:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=pRQBcVVboMVQutaQ1jmQY6cco5
	Sa2Hjod70KHYWESSw=; b=J0HDYNGLdYgASyYnofttTTN8hRjbug0aIYwFp5s9hg
	cvN5iBleliBjFbwBSkFfu4VFluap2o/LbF3EJ03v016k8TQm6dDAMO8HmUSOdI7C
	nUsbPffJpiJ+g41h26qE+VexxdMzxCcTTVUzCYiHxH8Znbp9t5BlkWnZTG7TamCW
	4hhb0WBykEU4Fczi0FGxoJMx05yAmMsLk7priZHog+bU2MZ2XL9q5/LXuq7tEY8c
	MipBuGqSjiQ0c6L5L+osb5cR8hXZ4SmmgXfm29f+QgVBMuSJT5OgMVqfkb/gFmad
	CNjhvHPDWtwVkjwWht/m5VzxWl764+gAFLiiwOnLeyFA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 406b5ag53c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 07:12:02 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4657C1Cs003717;
	Fri, 5 Jul 2024 07:12:02 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 406b5ag538-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 07:12:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4653XFdw029195;
	Fri, 5 Jul 2024 07:12:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402x3nc66v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 07:12:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4657BunC21234118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jul 2024 07:11:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F28A2004B;
	Fri,  5 Jul 2024 07:11:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E26E20043;
	Fri,  5 Jul 2024 07:11:54 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.40.194.31])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jul 2024 07:11:53 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Tony Battersby <tonyb@cybernetics.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Donet Tom <donettom@linux.ibm.com>
Subject: [PATCH] fs/hugetlbfs/inode.c: Ensure generic_hugetlb_get_unmapped_area() returns higher address than mmap_min_addr
Date: Fri,  5 Jul 2024 02:11:50 -0500
Message-ID: <20240705071150.84972-1-donettom@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7xL22XUaxd0RtczpMHp9W9I0o08bZ7zO
X-Proofpoint-ORIG-GUID: dwdz3dUsdfw1_XqqRJX1qMvD6o-kHuMl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_03,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=921 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2407050049

generic_hugetlb_get_unmapped_area() was returning an address less
than mmap_min_addr if the mmap argument addr, after alignment, was
less than mmap_min_addr, causing mmap to fail.

This is because current generic_hugetlb_get_unmapped_area() code does
not take into account mmap_min_addr.

This patch ensures that generic_hugetlb_get_unmapped_area() always returns
an address that is greater than mmap_min_addr.

How to reproduce
================

 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/mman.h>
 #include <unistd.h>

 #define HUGEPAGE_SIZE (16 * 1024 * 1024)

 int main() {

    void *addr = mmap((void *)-1, HUGEPAGE_SIZE,
                 PROT_READ | PROT_WRITE,
                 MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
    if (addr == MAP_FAILED) {
        perror("mmap");
        exit(EXIT_FAILURE);
    }

    snprintf((char *)addr, HUGEPAGE_SIZE, "Hello, Huge Pages!");

    printf("%s\n", (char *)addr);

    if (munmap(addr, HUGEPAGE_SIZE) == -1) {
        perror("munmap");
        exit(EXIT_FAILURE);
    }

    return 0;
 }

Result without fix
==================
 # cat /proc/meminfo |grep -i HugePages_Free
 HugePages_Free:       20
 # ./test
 mmap: Permission denied
 #

Result with fix
===============
 # cat /proc/meminfo |grep -i HugePages_Free
 HugePages_Free:       20
 # ./test
 Hello, Huge Pages!
 #

Reported-by Pavithra Prakash <pavrampu@linux.vnet.ibm.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 fs/hugetlbfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 412f295acebe..428fd2f0e4c4 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -228,7 +228,7 @@ generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 
 	if (len & ~huge_page_mask(h))
 		return -EINVAL;
-	if (len > TASK_SIZE)
+	if (len > mmap_end - mmap_min_addr)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED) {
@@ -240,7 +240,7 @@ generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	if (addr) {
 		addr = ALIGN(addr, huge_page_size(h));
 		vma = find_vma(mm, addr);
-		if (mmap_end - len >= addr &&
+		if (mmap_end - len >= addr && addr >= mmap_min_addr &&
 		    (!vma || addr + len <= vm_start_gap(vma)))
 			return addr;
 	}
-- 
2.43.5


