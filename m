Return-Path: <linux-kernel+bounces-355287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE738994FBF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCDD1F24D00
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4266F1DFE12;
	Tue,  8 Oct 2024 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxLyBMtr"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A1D1DFE04
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394066; cv=none; b=q8FbigBrLe+WNIap/+xr/Ad/PG/Ph/ZFwEJQOyBdSLxtqBz4q6+UhMtul7S7777T6R2JLE8cDtuJiBE2ZLnuKRsMzfvo8UZ7FdN/WYEwIgJLm8w8KbsDvjqGFNP/+G57c464WtCbJGcbipkQGvooJJ/Gg5D45yI196/mbo1AZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394066; c=relaxed/simple;
	bh=RDpHGhSEvFOpamT3cqCVwtWJZyTuxOm1879+DAAi6Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUNS5HqH8qM9SfhiKA7gJv6C/1l5qufdBfmXtbkFP0RIbYdFCSJfOpbgf8rOwMf5EDC0cGGa3qXRYtBmuolY3HF5YO/F/P95/i6RxAAzO3QeQhiT9qH2aK1xX7Xq2vCd5mzqbh/yf563jseuXYQiFKUyvuaU92EIBCpCubHcgew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxLyBMtr; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e284844d5fso511187a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 06:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728394064; x=1728998864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iORC/3+gFiV4oQN4Aw7kbFgz84yNOuZ0Gq1M6ocZ+00=;
        b=ZxLyBMtr329L6sxzo35GxCYuk31zjxpgXmzGXUVL88tNsyJf717//x6KLRNlIbwTW+
         GNsxOkfqcq119uBeHk9mwldgs74NG12RZ7lp1DwAuZpYLgfJlHoMu8/K2A2YKnvTy26J
         X1pAnJfJ1QPPaT0xaqg9awrTUw74uF3iQbjb04GZbXE2V9nmKEM0yypshRoBGFMpAXPL
         HrFkw5SogYCPNXdNJI3MDAEgbiHQMaVDNbABkm5QQXz8231MrxrzigXigBZxo1WBnNXz
         9iMJ21r0Yvjlf/npHl8XDbpf9OWFhWBV94iJN1NrWXFWUn1yxnVqwoMwWg7TknZO6Itt
         mp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728394064; x=1728998864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iORC/3+gFiV4oQN4Aw7kbFgz84yNOuZ0Gq1M6ocZ+00=;
        b=wbrR/4W0MVaDC0a0py0GtPVCUt0YR43HDtiZhHRhKFOVfuEGqHMshkOqZmanUCd4uI
         HWweFNn7nlPeHBhZNdN470fqdTb67Qcuat00wfuXgsincsG/s95q/GhmZpLtgRnjo+oi
         RPBE0bFFj4vZN5yfrx+y3KQisFOo21wEyU9XdAsqODeuof3h7r/XxEv8nmcZflWpDAB6
         JahF8pscQVAkq6pK3I6XonfkMlJSyIRFgUnlxstBiB+hZ9LOgiFS34VTK+HYmSgpXs51
         JolG/1hBD5Elh6Sk1D5Gy7wRklRe4eHbeWvcVD+vewPt0DzuZU4hNrmmcRAOV0DgwXxC
         yx6g==
X-Forwarded-Encrypted: i=1; AJvYcCVzRjF+WipA/8h/rpZnE6q1QUMQfH2MRY3LaNpVh0dqNAC72HIvzhyq2DPi/C/eUiU4GSa89RlSjBnGkZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbdRjmk3o+YoL4H2VPVyO5LnHBGjUcistxtOjIv0+97Z+PGE3O
	LiME7ft0QVzAlIUSj/VI29l8eRZSnbrahydf7uvTyX6Mh6IGjs7t
X-Google-Smtp-Source: AGHT+IFUSmB5qj013ukPWcd2PnqbxEbtyk9xGORICVlDGwgM/Alk+7OzaNIs/iU7kZlzw9YIiIXvNQ==
X-Received: by 2002:a17:90b:360f:b0:2d8:8175:38c9 with SMTP id 98e67ed59e1d1-2e1e626c076mr18806026a91.20.1728394064555;
        Tue, 08 Oct 2024 06:27:44 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.87.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20af4655dsm7628992a91.27.2024.10.08.06.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 06:27:43 -0700 (PDT)
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
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 2/2] fadump: Make fadump reserve_dump_area_start CMA aligned in case of holes
Date: Tue,  8 Oct 2024 18:57:19 +0530
Message-ID: <7950c20ae9f771a39eb0c0d568beb8681fee0209.1728386179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <c1e66d3e69c8d90988c02b84c79db5d9dd93f053.1728386179.git.ritesh.list@gmail.com>
References: <c1e66d3e69c8d90988c02b84c79db5d9dd93f053.1728386179.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consider cma alignment into account while calculating base address for
fadump memory allocation. Physical memory ranges can have holes and
fadump_locate_reserve_mem() tries to find a suitable base address.
If CMA is enabled and fadump nocma is false then we need to consider
CMA_MIN_ALIGNMENT_BYTES for reserve_dump_area_start.

For e.g. in case of below memory layout, the most suitable base address
is 0x00000501000000 for crashkernel=4097M which is 16M (order 8) aligned
as expected by CMA_MIN_ALIGNMENT_BYTES on PPC64 during early boot
(when pageblock_order is still not initialized)

~ # cat /proc/iomem
00000000-1fffffff : System RAM
100000000-1ffffffff : System RAM
300000000-3ffffffff : System RAM
500200000-9001fffff : System RAM

~ # dmesg |grep -Ei "fadump|cma"
fadump: Reserved 4112MB of memory at 0x00000501000000 (System RAM: 25088MB)
fadump: Initialized 0x101000000 bytes cma area at 20496MB from 0x1010002a8 bytes of memory reserved for firmware-assisted dump
Kernel command line: root=/dev/vda1 console=ttyS0 nokaslr slub_max_order=0 norandmaps noreboot crashkernel=4097M fadump=on disable_radix=no debug_pagealloc=off
Memory: 21246656K/25690112K available (31872K kernel code, 4544K rwdata, 17280K rodata, 9216K init, 2212K bss, 218432K reserved, 4210688K cma-reserved)

Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kernel/fadump.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index a612e7513a4f..15ea9c80bc03 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -512,6 +512,10 @@ static u64 __init fadump_locate_reserve_mem(u64 base, u64 size)
 	phys_addr_t mstart, mend;
 	int idx = 0;
 	u64 i, ret = 0;
+	unsigned long align = PAGE_SIZE;
+
+	if (IS_ENABLED(CONFIG_CMA) && !fw_dump.nocma)
+		align = CMA_MIN_ALIGNMENT_BYTES;

 	mrngs = reserved_mrange_info.mem_ranges;
 	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
@@ -520,7 +524,7 @@ static u64 __init fadump_locate_reserve_mem(u64 base, u64 size)
 			 i, mstart, mend, base);

 		if (mstart > base)
-			base = PAGE_ALIGN(mstart);
+			base = ALIGN(mstart, align);

 		while ((mend > base) && ((mend - base) >= size)) {
 			if (!overlaps_reserved_ranges(base, base+size, &idx)) {
@@ -529,7 +533,7 @@ static u64 __init fadump_locate_reserve_mem(u64 base, u64 size)
 			}

 			base = mrngs[idx].base + mrngs[idx].size;
-			base = PAGE_ALIGN(base);
+			base = ALIGN(base, align);
 		}
 	}

--
2.46.0


