Return-Path: <linux-kernel+bounces-355286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6DE994FBD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7807A286F7C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6812A1DFD9F;
	Tue,  8 Oct 2024 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFo3AS22"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA7B1DFD98
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394060; cv=none; b=eMjh59qAqaUVZF62PccGgxLIqURwZdaghEFYXvK5mpmqaEKLwuo270TpGRDiztY93hy9wd2o5FXFUgmiWUiGmbrmZpZVDXPt+BeP5zpJKKHKHwz3nSumk3zPe8w3bYVgvwIpne60qZuiDP13ow9MlZnHuN0HTptKKRXs82+VYvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394060; c=relaxed/simple;
	bh=Bp3mbK4KZ0jqXLqKYBElrTRE/rqK5KnHPN+iml/dRno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J2Gf9CB+CshMXgF8R8JKI7CsRfzftRPYvgvviayCrcitPobBICd57brdM2ThSeicHDJE/pU6+oTtyPsGBkXzB77DcloteNU1nV0ja9sHhggHjAsdPd7bfvx02QcGi6OPrzPi6E9KQZU3zv+qXjEmjWyMo6ya/k/YU9KNirmv9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFo3AS22; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea24595bccso251670a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728394059; x=1728998859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GNRTK4GY4M/5SnKSdR40yf4xxmnZc4ktxUmJ5/TaZVA=;
        b=QFo3AS22ZIzAyyeSQfRNapVSbfkqYy0ugh5ZHqjsk45gIH7NFv45FcA67Xg9xTNtDD
         RDrgr/NFZTND3B1P1buKNnNPI6PT2YJD28E0/XsUsTdc9QxTbyKEXDl1XN4+E+x/lYE5
         DzZHZKsiRrwi7bqO1IQyIXoeA9mTiXNhYP7rJJKe71CYO53zkv79yo2tejZ8mAYZ4EG6
         Ttno4SybzpVIbohM9uPPV1w11ui28rky9wf01DFvljNsC9bKK8zcAsvi5JrYqCJoOG/f
         J45znBO92ZCCbB0taYFcM/wsFRcd1FmdmBeEkZX6zflNrOHItUrkO5LyK9s5TDLg09ht
         xcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728394059; x=1728998859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNRTK4GY4M/5SnKSdR40yf4xxmnZc4ktxUmJ5/TaZVA=;
        b=t1z3gQf15Degc+5Ponsc0AJ02YDrqgpZ/oDzJPftFoyUw1J5lonnGm5FKjt3wAU9Og
         ea7dPquvlJM40iQdzc62vnIaK5CMoZlPxxHidIX/g7JGCv8qhANBAj909VY8bBlkJaT7
         aa+GF6Ck4+3Paw88y99/KRsd14cy/TLxAUbaKFc7Xr99ttGCM54uD9yzT7vTj3BkiF0w
         poT7syA9VY6y7vFEn95YUfk0k0DlSGeD3yVhWXZkZjF69nXD2B2r9MoEdfy0g5ohpzDI
         pSeVwGi/B0cJLPAQIUV/hBXx76NQArYQrTIrBZqmcejzCgKh/GQlZEBfXiqJvOEqHgc5
         Wm6g==
X-Forwarded-Encrypted: i=1; AJvYcCV8nXTyRHZG/O3y62dx9hGzpUVPX2vmSL5+8K9BKRQrulU/adEZwZ0AxFUU15hSkBuylJxj/WzUEsJYFhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjjKYCWQir9DrE8QtDioaBCIps0vE015ftzIYA6D4j6u6ZykUG
	WgdAoLz9El2XfL/SeLUTSAZY6P+SyWYvo9b5R3J5NqIaZHuocOq4
X-Google-Smtp-Source: AGHT+IEPBSY9n6qD6ZyvnmB52+tWd6fPMTLLVgOtWzgpTHXZv6NjkRb9kArISqSlxpL+qPUzVtYrRA==
X-Received: by 2002:a05:6a20:c886:b0:1cc:da34:585e with SMTP id adf61e73a8af0-1d6dfaee214mr21301979637.46.1728394058567;
        Tue, 08 Oct 2024 06:27:38 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.87.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20af4655dsm7628992a91.27.2024.10.08.06.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 06:27:37 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Sachin P Bappalige <sachinpb@linux.ibm.com>
Subject: [RFC 1/2] cma: Fix CMA_MIN_ALIGNMENT_BYTES during early_init
Date: Tue,  8 Oct 2024 18:57:18 +0530
Message-ID: <c1e66d3e69c8d90988c02b84c79db5d9dd93f053.1728386179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During early init CMA_MIN_ALIGNMENT_BYTES can be PAGE_SIZE,
since pageblock_order is still zero and it gets initialized
later during paging_init() e.g.
paging_init() -> free_area_init() -> set_pageblock_order().

One such use case is -
early_setup() -> early_init_devtree() -> fadump_reserve_mem()

This causes CMA memory alignment check to be bypassed in
cma_init_reserved_mem(). Then later cma_activate_area() can hit
a VM_BUG_ON_PAGE(pfn & ((1 << order) - 1)) if the reserved memory
area was not pageblock_order aligned.

Instead of fixing it locally for fadump case on PowerPC, I believe
this should be fixed for CMA_MIN_ALIGNMENT_BYTES.

<stack trace>
==============
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10010
flags: 0x13ffff800000000(node=1|zone=0|lastcpupid=0x7ffff) CMA
raw: 013ffff800000000 5deadbeef0000100 5deadbeef0000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: VM_BUG_ON_PAGE(pfn & ((1 << order) - 1))
------------[ cut here ]------------
kernel BUG at mm/page_alloc.c:778!

Call Trace:
__free_one_page+0x57c/0x7b0 (unreliable)
free_pcppages_bulk+0x1a8/0x2c8
free_unref_page_commit+0x3d4/0x4e4
free_unref_page+0x458/0x6d0
init_cma_reserved_pageblock+0x114/0x198
cma_init_reserved_areas+0x270/0x3e0
do_one_initcall+0x80/0x2f8
kernel_init_freeable+0x33c/0x530
kernel_init+0x34/0x26c
ret_from_kernel_user_thread+0x14/0x1c

Reported-by: Sachin P Bappalige <sachinpb@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 include/linux/cma.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 9db877506ea8..20abc6561bcd 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -5,6 +5,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/numa.h>
+#include <linux/minmax.h>

 #ifdef CONFIG_CMA_AREAS
 #define MAX_CMA_AREAS	CONFIG_CMA_AREAS
@@ -17,7 +18,8 @@
  * -- can deal with only some pageblocks of a higher-order page being
  *  MIGRATE_CMA, we can use pageblock_nr_pages.
  */
-#define CMA_MIN_ALIGNMENT_PAGES pageblock_nr_pages
+#define CMA_MIN_ALIGNMENT_PAGES \
+	(1ULL << min_not_zero(MAX_PAGE_ORDER, pageblock_order))
 #define CMA_MIN_ALIGNMENT_BYTES (PAGE_SIZE * CMA_MIN_ALIGNMENT_PAGES)

 struct cma;
--
2.46.0


