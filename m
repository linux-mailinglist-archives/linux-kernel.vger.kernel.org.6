Return-Path: <linux-kernel+bounces-448697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA03E9F4460
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729A81882EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBDE1E6311;
	Tue, 17 Dec 2024 06:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VtQc36Tj"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096B11E32D9
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734418044; cv=none; b=tYjNz82rH0vJwCOOkBWzsvh/Vu7zXJUA5gzZTZMyJ4QnHjWd5BSk69pF6KeTDx2hvDS4IxyMXdUkJqsgcbozyU7zWz3QR4k2u+XSnF+MjD1jgEHTIuEj9Bk0CGYUqain7axudgvBBbWLvA6O9q7qwUQ3T2g33sJep3bW7i4mmjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734418044; c=relaxed/simple;
	bh=68MVemKVjrWvsDaZ2B9zKpmUOv+r6+1Zk22mAGq2dak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2oKsiZ68gKfcmghQpQjuRQCL9PJQlh5lqQYz9ywhQwlrdfYOwE3LdpJSoRF+a541sWPURx17UrZJKl8zoz1Tgs/toz0KRvnQcE2zwu1VD432206WEpmgmmy7WCB+JLSDFc5Lkitv03H89CiLFDhiAsQ/LHZ6jIxU0Q4UEmhF7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VtQc36Tj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH16JJZ013078;
	Tue, 17 Dec 2024 06:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dCDK6BOsU4ZX7A04s
	KP0HMI7l9HAPh7z4+ZQG7MoYvY=; b=VtQc36TjvM5fvJHlT506feBCvqiJTF7H6
	oxwolecRAtV5MFNPjZsm5JYxDW1Apm1y8nCCoYIAGRG724wl5bl4HXzGGBXfk8mF
	/NbeqwrXAUNuCyQbijZx0znO2iiajWLk4riGWZCsllUHTKnIgoQyJyC6H0Na+0Bq
	kLGfTMFERwFOLOjJDg9vVvC8bNX2OWoQw753gSVD8Byq/0/DddQC9FyavPmtb286
	EK865XbcphZkm2INiHh/Ltb5OrVUSwOIKuEaiYon6eqqO5f0P7pKq9Wuru8Thtrg
	UDEQwcX2cbQhhaE40Ur7aAVSBCKAMPCn6+WdsjO1ShUxJyNgMelRA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jnp4ks37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 06:47:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH6OduF014340;
	Tue, 17 Dec 2024 06:47:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqy1qve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 06:47:07 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BH6l4Q231981902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 06:47:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E30192004B;
	Tue, 17 Dec 2024 06:47:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4084F20040;
	Tue, 17 Dec 2024 06:47:01 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.29.128])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Dec 2024 06:47:00 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] crash: option to let arch decide mem range is usable
Date: Tue, 17 Dec 2024 12:16:13 +0530
Message-ID: <20241217064613.1042866-6-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217064613.1042866-1-sourabhjain@linux.ibm.com>
References: <20241217064613.1042866-1-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SdvJdPM8P27VchBEF8GkxHQecpPbbdXl
X-Proofpoint-ORIG-GUID: SdvJdPM8P27VchBEF8GkxHQecpPbbdXl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170052

On PowerPC, the memory reserved for the crashkernel can contain
components like RTAS, TCE, OPAL, etc., which should be avoided when
loading kexec segments into crashkernel memory. Due to these special
components, PowerPC has its own set of functions to locate holes in the
crashkernel memory for loading kexec segments for kdump. However, for
loading kexec segments in the kexec case, PowerPC uses generic functions
to locate holes.

So, let's use generic functions to locate memory holes for kdump on
PowerPC by adding an arch hook to handle such special regions while
loading kexec segments, and remove the PowerPC functions to locate
holes.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan he <bhe@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
CC: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/kexec.h  |   6 +-
 arch/powerpc/kexec/file_load_64.c | 259 ++----------------------------
 include/linux/kexec.h             |   9 ++
 kernel/kexec_file.c               |  12 ++
 4 files changed, 34 insertions(+), 252 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 64741558071f..5e4680f9ff35 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -95,8 +95,10 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf, unsigned long
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
 
-int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
-#define arch_kexec_locate_mem_hole arch_kexec_locate_mem_hole
+int arch_check_excluded_range(struct kimage *image, unsigned long start,
+			      unsigned long end);
+#define arch_check_excluded_range  arch_check_excluded_range
+
 
 int load_crashdump_segments_ppc64(struct kimage *image,
 				  struct kexec_buf *kbuf);
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index dc65c1391157..e7ef8b2a2554 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -49,201 +49,18 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 	NULL
 };
 
-/**
- * __locate_mem_hole_top_down - Looks top down for a large enough memory hole
- *                              in the memory regions between buf_min & buf_max
- *                              for the buffer. If found, sets kbuf->mem.
- * @kbuf:                       Buffer contents and memory parameters.
- * @buf_min:                    Minimum address for the buffer.
- * @buf_max:                    Maximum address for the buffer.
- *
- * Returns 0 on success, negative errno on error.
- */
-static int __locate_mem_hole_top_down(struct kexec_buf *kbuf,
-				      u64 buf_min, u64 buf_max)
-{
-	int ret = -EADDRNOTAVAIL;
-	phys_addr_t start, end;
-	u64 i;
-
-	for_each_mem_range_rev(i, &start, &end) {
-		/*
-		 * memblock uses [start, end) convention while it is
-		 * [start, end] here. Fix the off-by-one to have the
-		 * same convention.
-		 */
-		end -= 1;
-
-		if (start > buf_max)
-			continue;
-
-		/* Memory hole not found */
-		if (end < buf_min)
-			break;
-
-		/* Adjust memory region based on the given range */
-		if (start < buf_min)
-			start = buf_min;
-		if (end > buf_max)
-			end = buf_max;
-
-		start = ALIGN(start, kbuf->buf_align);
-		if (start < end && (end - start + 1) >= kbuf->memsz) {
-			/* Suitable memory range found. Set kbuf->mem */
-			kbuf->mem = ALIGN_DOWN(end - kbuf->memsz + 1,
-					       kbuf->buf_align);
-			ret = 0;
-			break;
-		}
-	}
-
-	return ret;
-}
-
-/**
- * locate_mem_hole_top_down_ppc64 - Skip special memory regions to find a
- *                                  suitable buffer with top down approach.
- * @kbuf:                           Buffer contents and memory parameters.
- * @buf_min:                        Minimum address for the buffer.
- * @buf_max:                        Maximum address for the buffer.
- * @emem:                           Exclude memory ranges.
- *
- * Returns 0 on success, negative errno on error.
- */
-static int locate_mem_hole_top_down_ppc64(struct kexec_buf *kbuf,
-					  u64 buf_min, u64 buf_max,
-					  const struct crash_mem *emem)
+int arch_check_excluded_range(struct kimage *image, unsigned long start,
+			      unsigned long end)
 {
-	int i, ret = 0, err = -EADDRNOTAVAIL;
-	u64 start, end, tmin, tmax;
-
-	tmax = buf_max;
-	for (i = (emem->nr_ranges - 1); i >= 0; i--) {
-		start = emem->ranges[i].start;
-		end = emem->ranges[i].end;
-
-		if (start > tmax)
-			continue;
-
-		if (end < tmax) {
-			tmin = (end < buf_min ? buf_min : end + 1);
-			ret = __locate_mem_hole_top_down(kbuf, tmin, tmax);
-			if (!ret)
-				return 0;
-		}
-
-		tmax = start - 1;
-
-		if (tmax < buf_min) {
-			ret = err;
-			break;
-		}
-		ret = 0;
-	}
-
-	if (!ret) {
-		tmin = buf_min;
-		ret = __locate_mem_hole_top_down(kbuf, tmin, tmax);
-	}
-	return ret;
-}
-
-/**
- * __locate_mem_hole_bottom_up - Looks bottom up for a large enough memory hole
- *                               in the memory regions between buf_min & buf_max
- *                               for the buffer. If found, sets kbuf->mem.
- * @kbuf:                        Buffer contents and memory parameters.
- * @buf_min:                     Minimum address for the buffer.
- * @buf_max:                     Maximum address for the buffer.
- *
- * Returns 0 on success, negative errno on error.
- */
-static int __locate_mem_hole_bottom_up(struct kexec_buf *kbuf,
-				       u64 buf_min, u64 buf_max)
-{
-	int ret = -EADDRNOTAVAIL;
-	phys_addr_t start, end;
-	u64 i;
-
-	for_each_mem_range(i, &start, &end) {
-		/*
-		 * memblock uses [start, end) convention while it is
-		 * [start, end] here. Fix the off-by-one to have the
-		 * same convention.
-		 */
-		end -= 1;
-
-		if (end < buf_min)
-			continue;
-
-		/* Memory hole not found */
-		if (start > buf_max)
-			break;
-
-		/* Adjust memory region based on the given range */
-		if (start < buf_min)
-			start = buf_min;
-		if (end > buf_max)
-			end = buf_max;
-
-		start = ALIGN(start, kbuf->buf_align);
-		if (start < end && (end - start + 1) >= kbuf->memsz) {
-			/* Suitable memory range found. Set kbuf->mem */
-			kbuf->mem = start;
-			ret = 0;
-			break;
-		}
-	}
-
-	return ret;
-}
-
-/**
- * locate_mem_hole_bottom_up_ppc64 - Skip special memory regions to find a
- *                                   suitable buffer with bottom up approach.
- * @kbuf:                            Buffer contents and memory parameters.
- * @buf_min:                         Minimum address for the buffer.
- * @buf_max:                         Maximum address for the buffer.
- * @emem:                            Exclude memory ranges.
- *
- * Returns 0 on success, negative errno on error.
- */
-static int locate_mem_hole_bottom_up_ppc64(struct kexec_buf *kbuf,
-					   u64 buf_min, u64 buf_max,
-					   const struct crash_mem *emem)
-{
-	int i, ret = 0, err = -EADDRNOTAVAIL;
-	u64 start, end, tmin, tmax;
-
-	tmin = buf_min;
-	for (i = 0; i < emem->nr_ranges; i++) {
-		start = emem->ranges[i].start;
-		end = emem->ranges[i].end;
-
-		if (end < tmin)
-			continue;
-
-		if (start > tmin) {
-			tmax = (start > buf_max ? buf_max : start - 1);
-			ret = __locate_mem_hole_bottom_up(kbuf, tmin, tmax);
-			if (!ret)
-				return 0;
-		}
-
-		tmin = end + 1;
+	struct crash_mem *emem;
+	int i;
 
-		if (tmin > buf_max) {
-			ret = err;
-			break;
-		}
-		ret = 0;
-	}
+	emem = image->arch.exclude_ranges;
+	for (i = 0; i < emem->nr_ranges; i++)
+		if (start < emem->ranges[i].end && end > emem->ranges[i].start)
+			return 1;
 
-	if (!ret) {
-		tmax = buf_max;
-		ret = __locate_mem_hole_bottom_up(kbuf, tmin, tmax);
-	}
-	return ret;
+	return 0;
 }
 
 #ifdef CONFIG_CRASH_DUMP
@@ -1004,64 +821,6 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt, struct crash_mem
 	return ret;
 }
 
-/**
- * arch_kexec_locate_mem_hole - Skip special memory regions like rtas, opal,
- *                              tce-table, reserved-ranges & such (exclude
- *                              memory ranges) as they can't be used for kexec
- *                              segment buffer. Sets kbuf->mem when a suitable
- *                              memory hole is found.
- * @kbuf:                       Buffer contents and memory parameters.
- *
- * Assumes minimum of PAGE_SIZE alignment for kbuf->memsz & kbuf->buf_align.
- *
- * Returns 0 on success, negative errno on error.
- */
-int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
-{
-	struct crash_mem **emem;
-	u64 buf_min, buf_max;
-	int ret;
-
-	/* Look up the exclude ranges list while locating the memory hole */
-	emem = &(kbuf->image->arch.exclude_ranges);
-	if (!(*emem) || ((*emem)->nr_ranges == 0)) {
-		pr_warn("No exclude range list. Using the default locate mem hole method\n");
-		return kexec_locate_mem_hole(kbuf);
-	}
-
-	buf_min = kbuf->buf_min;
-	buf_max = kbuf->buf_max;
-	/* Segments for kdump kernel should be within crashkernel region */
-	if (IS_ENABLED(CONFIG_CRASH_DUMP) && kbuf->image->type == KEXEC_TYPE_CRASH) {
-		buf_min = (buf_min < crashk_res.start ?
-			   crashk_res.start : buf_min);
-		buf_max = (buf_max > crashk_res.end ?
-			   crashk_res.end : buf_max);
-	}
-
-	if (buf_min > buf_max) {
-		pr_err("Invalid buffer min and/or max values\n");
-		return -EINVAL;
-	}
-
-	if (kbuf->top_down)
-		ret = locate_mem_hole_top_down_ppc64(kbuf, buf_min, buf_max,
-						     *emem);
-	else
-		ret = locate_mem_hole_bottom_up_ppc64(kbuf, buf_min, buf_max,
-						      *emem);
-
-	/* Add the buffer allocated to the exclude list for the next lookup */
-	if (!ret) {
-		add_mem_range(emem, kbuf->mem, kbuf->memsz);
-		sort_memory_ranges(*emem, true);
-	} else {
-		pr_err("Failed to locate memory buffer of size %lu\n",
-		       kbuf->memsz);
-	}
-	return ret;
-}
-
 /**
  * arch_kexec_kernel_image_probe - Does additional handling needed to setup
  *                                 kexec segments.
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..407f8b0346aa 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -205,6 +205,15 @@ static inline int arch_kimage_file_post_load_cleanup(struct kimage *image)
 }
 #endif
 
+#ifndef arch_check_excluded_range
+static inline int arch_check_excluded_range(struct kimage *image,
+					    unsigned long start,
+					    unsigned long end)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_KEXEC_SIG
 #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
 int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3eedb8c226ad..52e1480dbfa1 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -464,6 +464,12 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 			continue;
 		}
 
+		/* Make sure this does not conflict exclude range */
+		if (arch_check_excluded_range(image, temp_start, temp_end)) {
+			temp_start = temp_start - PAGE_SIZE;
+			continue;
+		}
+
 		/* We found a suitable memory range */
 		break;
 	} while (1);
@@ -498,6 +504,12 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 			continue;
 		}
 
+		/* Make sure this does not conflict exclude range */
+		if (arch_check_excluded_range(image, temp_start, temp_end)) {
+			temp_start = temp_start + PAGE_SIZE;
+			continue;
+		}
+
 		/* We found a suitable memory range */
 		break;
 	} while (1);
-- 
2.47.1


