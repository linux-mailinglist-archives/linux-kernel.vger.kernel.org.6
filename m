Return-Path: <linux-kernel+bounces-514956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA7DA35DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0721E16E856
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F76A25A64B;
	Fri, 14 Feb 2025 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FaAzXhG6"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337001EA91
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537663; cv=none; b=oCSmezAinTTinBk2uRKzsYZMJoK3icoRInyx+zUvTzX0wQthezxjNoAzEDRVrjul7M6aGKRHmdkUQIiWkhJzXwBJjqMLYVfmHT69c+ugAVFX8BsbgA7SmiD2XJIn8sbKYIxJQgfbSwxhTmX0Nsf2CDCyNFi0Y2m2KWCnPZxli28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537663; c=relaxed/simple;
	bh=EWzn8T8wkAbVAiA4txJzP3ETH8av+74Rp35RKVO/xwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qNB1WhFmTn4l/dt6EUzUh6rLPm/+2p+7V6KLwSvHYKgpWznKm+1NG6g0/0v33AEK5OngBokYuOeYp4pQczFuoNVTydyGiTKfxt1BQlDNOK8uFh424iSfDW/1fWyEa28q+cgXL8+0weIHAIceLo7EnGIIxWxDtJEQwl/vU/vOk34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FaAzXhG6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EAPt9H000666;
	Fri, 14 Feb 2025 12:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=FjT8dSaAT+lOi/YMEolFGYFqGJzx8VOdPbUby3MGc
	6M=; b=FaAzXhG6jighwx/li5GEt566XZkWqYU+oFNuTzHc+Wocu9L2NFfIReCES
	nm8A6EfvWFz2GUtWlXL15i3A16w2MdXljcaBliVlSDYChMYUAhe+Bhho44tN0t/4
	+d9n3AJgDoPr7rGYSnTX5VPbf7mXJA8t6cV+ymfGOXFZTyjEWel5g4PODMZ3MMEQ
	nhgROOwgGJIUxl3kpW7a5DpTJI9+iUgRZYLeRQmap+2bSPSUEI70kFobRt4nnBEw
	dRD67fyqZu4rUnFkapGf+xrCI785ZZuGfnrUhaGlgAdFwH5/99K5PMuUVXGpZzaS
	u8Snu4Ey+sicoCGQ8fR4OShgsf4fw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ssvab9b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 12:54:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51E8vDDF028667;
	Fri, 14 Feb 2025 12:54:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pma23732-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 12:54:11 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51ECs7HW42926508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 12:54:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D812920043;
	Fri, 14 Feb 2025 12:54:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E647C20040;
	Fri, 14 Feb 2025 12:54:04 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.78.252])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Feb 2025 12:54:04 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: akpm@linux-foundation.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
        Alexander Graf <graf@amazon.com>, Baoquan he <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kexec: Fix kexec_locate_mem_hole() for missing CONFIG_KEXEC_HANDOVER
Date: Fri, 14 Feb 2025 18:24:02 +0530
Message-ID: <20250214125402.90709-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ERu89rXI1toBcblDuM23P6X9jJATPNiB
X-Proofpoint-ORIG-GUID: ERu89rXI1toBcblDuM23P6X9jJATPNiB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=777 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502140092

While adding KHO support, commit 7d128945e003 ("kexec: add KHO support
to kexec file loads") returns early from kexec_locate_mem_hole() if
CONFIG_KEXEC_HANDOVER is not defined.

Due to this, kexec_locate_mem_hole() does not locate a hole for the
kexec segment, and kbuf.mem holds 0x0. This leads to a kexec_file_load
syscall failure in sanity_check_segment_list(). This impacts both
kexec and kdump kernels.

Without this patch included:
----------------------------
kexec --initrd=initrd.img ./vmlinuz --append="`cat /proc/cmdline`" -lsd
Try gzip decompression.
Try LZMA decompression.
[   59.745154] kexec_file: kernel: 000000003473b9a0 kernel_size: 0x2cdacf0
[   59.753713] ima: kexec measurement buffer for the loaded kernel at 0x0.
[   59.753759] kexec_elf: Loaded the kernel at 0x0
[   59.753777] kexec_elf: Loaded purgatory at 0x0
[   59.753783] kexec_elf: Loaded initrd at 0x0
[   59.758657] kexec_elf: Loaded device tree at 0x0
syscall kexec_file_load not available.

With this patch included:
-------------------------
kexec --initrd=initrd.img ./vmlinuz --append="`cat /proc/cmdline`" -lsd
Try gzip decompression.
Try LZMA decompression.
[  112.091308] kexec_file: kernel: 000000009eb0432d kernel_size: 0x2cdacf0
[  112.099881] ima: kexec measurement buffer for the loaded kernel at 0x3fd9c0000.
[  112.099935] kexec_elf: Loaded the kernel at 0x2f60000
[  112.099953] kexec_elf: Loaded purgatory at 0x3fd9b0000
[  112.099969] kexec_elf: Loaded initrd at 0x5eb0000
[  112.104993] kexec_elf: Loaded device tree at 0x3fd650000
[  113.484422] kexec_file: nr_segments = 5
[  113.484452] kexec_file: segment[0]: buf=0x00000000b6970fc9 bufsz=0x82 mem=0x3fd9c0000 memsz=0x10000
[  113.484473] kexec_file: segment[1]: buf=0x00000000cabe3fe7 bufsz=0x2cc9ca4 mem=0x2f60000 memsz=0x2f50000
[  113.489144] kexec_file: segment[2]: buf=0x00000000deec4aaf bufsz=0x310 mem=0x3fd9b0000 memsz=0x10000
[  113.489195] kexec_file: segment[3]: buf=0x0000000081960708 bufsz=0x581a9c6 mem=0x5eb0000 memsz=0x5820000
[  113.498768] kexec_file: segment[4]: buf=0x00000000c1be9ac7 bufsz=0x6632 mem=0x3fd650000 memsz=0x10000
[  113.498819] kexec_file: kexec_file_load: type:0, start:0x3fd9b0000 head:0x5f1c0002 flags:0x8

To fix this, return 1 from kexec_locate_mem_hole() in kexec_internal.h.
This ensures that kexec_locate_mem_hole() locates a memory hole if
CONFIG_KEXEC_HANDOVER is not defined.

Note: The kexec tool printing "kexec_file_load not available" does not
necessarily mean that the kernel lacks support for the kexec_file_load
syscall. Instead, it occurs because multiple errors are handled under
the same condition.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Closes: https://lore.kernel.org/all/8e73069b-5987-4a08-b13d-13fe691092ad@linux.vnet.ibm.com/
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Baoquan he <bhe@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---

Rebased on top of next-20250213

---
 kernel/kexec_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index c535dbd3b5bd..66ce6872fda1 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -50,7 +50,7 @@ int kho_fill_kimage(struct kimage *image);
 static inline int kho_locate_mem_hole(struct kexec_buf *kbuf,
 				      int (*func)(struct resource *, void *))
 {
-	return 0;
+	return 1;
 }
 
 static inline int kho_fill_kimage(struct kimage *image) { return 0; }
-- 
2.48.1


