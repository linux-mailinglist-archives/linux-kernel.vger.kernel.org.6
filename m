Return-Path: <linux-kernel+bounces-247030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D0992CA1F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36306284D60
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4BE4776E;
	Wed, 10 Jul 2024 05:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aoxxe9yR"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B2517FD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 05:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720588796; cv=none; b=Jy6gq0n7y4XhC9MFRx8cn4F8A/exM8NSEf0Ljp9JeVoSl0k3B9eAR47/4Qq0YexzDlIUMiWD0296oEiw1UQHHCD0ChXxGSfH2gQiitk+kCswMK5zovTXo9N3umUvUUK5ip0jySYoi9VIShXNKcO0LOXk5O1p/Y1AvzA093/l09s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720588796; c=relaxed/simple;
	bh=n2s3o8q4v7j+RxNat2yf/U7NfD/vMRwcxyjm1SF4J7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFBrnzO6oJpNZ3y4vaRlKQ7t8U0PLHAFgqdFe7Ly4RhIKyT6WC6kfsggpNi9fkQ+bTpQYjGwQBsI7vc44NcTGIzGS0dc6Yhr7DsndmaJUoiTQxse5HEFEM/UssjA0P0keM0UzopVCFt+KJ7144PxsXiYhRUFTeTm/JijbpFJbBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aoxxe9yR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A4vfTf017813;
	Wed, 10 Jul 2024 05:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=6BvyBR57+4bOjGzhiVOtOwfSUiZBWtVHAhehWzI
	xV5g=; b=aoxxe9yRqhUQU5m5TLuOZDOSmiY9RRMvhKZL+7E5R7yOh0TAm+W6Dmz
	5r6tCdv6Cqg1JfnnuzHHOv6MgQjrS77gm0dcSJCGJOrf7ZiKlpPs3EsrF22n9uss
	PVUCH8rOIa/U7aPuvjeesnXJWt3NxmM7jA4oAOvXztuIaaS2UIipPyx5XkOIc3Cz
	/hyuQEoqXJjcW7qzfvl4pvKLUCOqs+aGIZf1HncqdgGU0KhSkmJphLsDLCIU3mj2
	Oj6x9rZzc0vo6MKBAiuRqixIoIWrGatLomlw+bT8pTuxPgWVXConmV44C7ZKb/T1
	178q4whSAL2UtWgudBLqwd+CQ2xp21w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 409gnugfun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 05:19:28 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46A5JRH5017582;
	Wed, 10 Jul 2024 05:19:27 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 409gnugfuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 05:19:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46A2PCIs025046;
	Wed, 10 Jul 2024 05:19:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 407g8u9fkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 05:19:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46A5JMLs55902602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 05:19:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D62C12004B;
	Wed, 10 Jul 2024 05:19:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A304520040;
	Wed, 10 Jul 2024 05:19:20 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.40.194.31])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jul 2024 05:19:20 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Tony Battersby <tonyb@cybernetics.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Donet Tom <donettom@linux.ibm.com>
Subject: [PATCH v3] hugetlbfs: Ensure generic_hugetlb_get_unmapped_area() returns higher address than mmap_min_addr
Date: Wed, 10 Jul 2024 00:19:12 -0500
Message-ID: <20240710051912.4681-1-donettom@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eXjPB2DIEx78qqOf_HQlGo0-EbgYisCH
X-Proofpoint-GUID: BeQV48yM1TyCSP-cQFPb40GhdOf-yhbT
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_01,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100036

generic_hugetlb_get_unmapped_area() was returning an address less
than mmap_min_addr if the mmap argument addr, after alignment, was
less than mmap_min_addr, causing mmap to fail.

This is because current generic_hugetlb_get_unmapped_area() code does
not take into account mmap_min_addr.

This patch ensures that generic_hugetlb_get_unmapped_area() always returns
an address that is greater than mmap_min_addr. Additionally, similar to
generic_get_unmapped_area(), vm_end_gap() checks are included to maintain
stack gap.

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

V3:
Changed subject prefix and commit message.

V2:
Added vm_end_gap() check.
https://lore.kernel.org/all/20240709092122.41232-1-donettom@linux.ibm.com/

V1:
https://lore.kernel.org/all/20240705071150.84972-1-donettom@linux.ibm.com/

Reported-by Pavithra Prakash <pavrampu@linux.vnet.ibm.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 fs/hugetlbfs/inode.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 412f295acebe..cdd8e53ddd19 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -222,13 +222,13 @@ generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 				  unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma, *prev;
 	struct hstate *h = hstate_file(file);
 	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
 
 	if (len & ~huge_page_mask(h))
 		return -EINVAL;
-	if (len > TASK_SIZE)
+	if (len > mmap_end - mmap_min_addr)
 		return -ENOMEM;
 
 	if (flags & MAP_FIXED) {
@@ -239,9 +239,10 @@ generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 
 	if (addr) {
 		addr = ALIGN(addr, huge_page_size(h));
-		vma = find_vma(mm, addr);
-		if (mmap_end - len >= addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)))
+		vma = find_vma_prev(mm, addr, &prev);
+		if (mmap_end - len >= addr && addr >= mmap_min_addr &&
+		    (!vma || addr + len <= vm_start_gap(vma)) &&
+		    (!prev || addr >= vm_end_gap(prev)))
 			return addr;
 	}
 
-- 
2.43.5


