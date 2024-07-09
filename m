Return-Path: <linux-kernel+bounces-245508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F6692B39A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1FCF1F23166
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5806F154C17;
	Tue,  9 Jul 2024 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ADJ77naX"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5A1154434
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516928; cv=none; b=YJqQzw1szx2WkDZ7esxRvhZhugS8Kllycic7MRI0fJPf8p4A02TWACh8M5Xf+DSrXunL7VdaRYS0FY10O5YisDfkDtRXmtf3+mPWgQLVTT5eMUnQ2O7+6nkQz8CmFxYGZNke/hASMYkri6Zur8JpnUoFsT4Zm0hx2DkdE3VFj8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516928; c=relaxed/simple;
	bh=1Afy59d9rvoNifwLU0IZusSAU7p8fTyjgjyF+URDHps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FPHDBOKHfaaSK434TJMyt84aVkzp5m0yaWcsm5TZNZ3f1/NbYcE2vn+lWsFQk05z++DUJV8OOtBrJf5ZSsUQvBCp/Y7fo7FFTxcr7gsyihu3BnvvddSc1AmZFnbx4wUhWuQyzP1euWz0D7cL/ULOCSHcdl7+K9mlqwyQpdA/OGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ADJ77naX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697vMpK024493;
	Tue, 9 Jul 2024 09:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=VAu8nuSyKpLacLsQUVBecgg5k9Mqzo3eKlp3op6
	poZg=; b=ADJ77naXvcUzRAu4i3KnasFfUhTEG55x5/gya9kq66qEiILR7fumpH9
	tDncklx40bX5br0/JBziddJ9zEX/PoMXrB9oTydbne3ZS1r4nxq73Zew7HgBVHUv
	WpLkPUuowIHxJ85mktEOVDNmxmhIZn8P6KpnQ+45wJgHsdorKxBYGS0qFQ7yGITk
	oaOFaTl/kefxK2ewto34hFTecYq+S+OSM/G6u7omrwFnvFfYggE+E5LEwhUUN8X5
	6Lxn4bIdQXx/UR2e0+hoGFCMtj0d1rgqRvxs4Giv2orufQg472o5xBLbRU/+j2vC
	AvjEpOCscRYRa67agDhNkNgQmQY1lYw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 408ws38p9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 09:21:34 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4699LXEl020805;
	Tue, 9 Jul 2024 09:21:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 408ws38p9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 09:21:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4698tVce024583;
	Tue, 9 Jul 2024 09:21:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407hrmkjpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 09:21:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4699LS0r42140092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 09:21:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAC3220040;
	Tue,  9 Jul 2024 09:21:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 800A020043;
	Tue,  9 Jul 2024 09:21:26 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.40.194.31])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 09:21:26 +0000 (GMT)
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
Subject: [PATCH v2] fs/hugetlbfs/inode.c: Ensure generic_hugetlb_get_unmapped_area() returns higher address than mmap_min_addr
Date: Tue,  9 Jul 2024 04:21:22 -0500
Message-ID: <20240709092122.41232-1-donettom@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oaUkanhYWHG3dfuPoU_w4oO8JCSI7bbG
X-Proofpoint-ORIG-GUID: LNKnn6UQNhxNm9BSsiI72LSIydZX6VL0
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
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090059

generic_hugetlb_get_unmapped_area() was returning an address less
than mmap_min_addr if the mmap argument addr, after alignment, was
less than mmap_min_addr, causing mmap to fail.

This is because current generic_hugetlb_get_unmapped_area() code does
not take into account mmap_min_addr.

This patch ensures that generic_hugetlb_get_unmapped_area() always returns
an address that is greater than mmap_min_addr. Additionally, similar to
generic_get_unmapped_area(), vm_end_gap() checks are included to ensure
that the address is within the limit.

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

V2:
Added vm_end_gap() check.

V1:
https://lore.kernel.org/all/20240705071150.84972-1-donettom@linux.ibm.com/

Reported-by Pavithra Prakash <pavrampu@linux.vnet.ibm.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
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


