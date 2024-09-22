Return-Path: <linux-kernel+bounces-335138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F9397E19C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 14:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C5D1F2138A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 12:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937CDA5F;
	Sun, 22 Sep 2024 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Go69QIJq"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98B645
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727009201; cv=none; b=TZDN1304DUHDUva2MdBAwIzLNza2y9/SXC20k0D/31GygVqz7AEbo/NMC6lBXz1Od8oopDElWgbu5iWu/qqjCjxvL6X0BEa9TCMHwTJIaTswn+xiaSZl3KbTuxWNv1q5P+Z+QnDwGEdVb1Ar8/DVTjbLA/3E04S3I2jFpcMg9gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727009201; c=relaxed/simple;
	bh=BedMeTFlaZKXlzAnbgttJ1p76Oqk/1ykyt/NlNqTGos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bViFpJ4QG1Azo0vVG+FG8r+4XLNhw/TsBS+RxdRUX2SMZiAGgSsP0BHSxhBjlg3tsJ2eSn4lO3cZtvIIL2cznzmXn/zC3OHdn0sOacedPy9rZbJq3man/1AU8q8KIyk2PHaA/x9gLGGchzNiV+NykmCecUPRim54A4C2fiQ37CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Go69QIJq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2054feabfc3so31216005ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 05:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727009199; x=1727613999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1d6ErifsnrSsT38T4JJA8Y82xn33h3c3g8IFMCA75zg=;
        b=Go69QIJqRubyAj/5HQrdbYut2LSrltslnBt2UCOT0b52McJaBhXUHfb7gGvEiPx0GF
         U+DKOzWNo6QtUjl5r/9E0Cu8nBC1lmCCrdW5LYPKelR1WnYVGQnlJg9K3t2x/rlbWB+4
         NJ8qBT+FSNvL+KoH+Z9+bT/Q/6FSwc1EngSiFLvClJnCjGsUewtk06oforLq5FTPOBND
         cYSCkh7d9j+U5J4pPycGJQvn571wA/bJR2cr1AmTGdDa4cW90NaEcO3kwlmdQgekaVB0
         +Yr8ZmaIlTbs4oh4CGInYWEooL+tBlCeJAJUjUeHWzSgxJeCSzrX6UOBSVoUBfEPx4lT
         L2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727009199; x=1727613999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1d6ErifsnrSsT38T4JJA8Y82xn33h3c3g8IFMCA75zg=;
        b=gHhyD72JxD6YQ8Pk0mkMY88bonEzBhklJ6XYxmOEiBwqgWhVTtLk7f1lTAKvOYcfTC
         FE0bDKQ23q3qY4S8mIZ6FwZjoU3nZSQHtKDTCTsTfV/EdhEtkDzNTWQV88H5KRS7mMUf
         q0EYaoOUhqySC/jdhK/rSP5XzpcQQOgJnz1QKXPLWgs/P6eCUf3wd7wmr/8EXxKAS+oo
         fH1OCnFPpecWn61arDfr0m0mKGd1esX0jiftENZ5x8GBJdln++QPTGJeWnz/mL8QmRt/
         yUdjFjyajL5QkFaBU7nvayNvvt8H67+xBcVAZdBG8aZTXJ0B5IDSsfmK9+sykKcBNZMX
         RagQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDN0/adZJKkptdc4KORPlj7txWLpUPHb0WMIhnJnpSgRfy6+NJmkY9zb0SVMwiGNfr7Mxkzz8VsvxUT1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHrsMNvYe76A4uH6pcNFXgpEsnTGg2vLxl5jwqwnzvcAB2ZRKS
	vcPDa6oPwA84AtXcorhlqhS1pNnCno5fmAezmZs09c1VppeA/+b1GIUJ/w==
X-Google-Smtp-Source: AGHT+IEErnc4kiN4jb2LvbdfB67R2vqvkV0zBOBcvy8te6zsBl9Cd9Yo6sEVpe89ph9ouy1i+Tc59Q==
X-Received: by 2002:a17:902:e5cd:b0:206:9caf:1e09 with SMTP id d9443c01a7336-208d98bd28cmr89162375ad.61.1727009198583;
        Sun, 22 Sep 2024 05:46:38 -0700 (PDT)
Received: from dw-tp.. ([171.76.87.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d19aasm119420975ad.127.2024.09.22.05.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 05:46:36 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC / PoC v1 0/1] powerpc: Add support for batched unmap TLB flush
Date: Sun, 22 Sep 2024 18:16:23 +0530
Message-ID: <cover.1727001426.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello All,

This is a quick PoC to add ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH support to
powerpc for book3s64. The ISA in 6.10 of "Translation Table Update
Synchronization Requirements" says that the architecture allows for optimizing
the translation cache invalidation by doing it in bulk later after the PTE
change has been done.
That means if we can add ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH support, it will be
possible to utilize optimizations in reclaim and migrate pages path which can
defer the tlb invalidations to be done in bulk after all the page unmap
operations has been completed.

This a quick PoC for the same. Note that this may not be a complete patch yet,
TLB on Power is already complex from the hardware side :) and then many
optimizations done in the software (e.g. exit_lazy_flush_tlb to avoid tlbies).
But since the current patch looked somewhat sane to me, I wanted to share to get
an early feedback from people who are well versed with this side of code.

Meanwhile I have many TODOs to look into which I am working in parallel for this
work. Later will also get some benchmarks w.r.t promotion / demotion.

I ran a micro-benchmark which was shared in other commits that adds this
support on other archs. I can see some good initial improvements.

without patch (perf report showing 7% in radix__flush_tlb_page_psize, even with
single thread)
==================
root# time ./a.out
real    0m23.538s
user    0m0.191s
sys     0m5.270s

# Overhead  Command  Shared Object               Symbol
# ........  .......  ..........................  .............................................
#
     7.19%  a.out    [kernel.vmlinux]            [k] radix__flush_tlb_page_psize
     5.63%  a.out    [kernel.vmlinux]            [k] _raw_spin_lock
     3.21%  a.out    a.out                       [.] main
     2.93%  a.out    [kernel.vmlinux]            [k] page_counter_cancel
     2.58%  a.out    [kernel.vmlinux]            [k] page_counter_try_charge
     2.56%  a.out    [kernel.vmlinux]            [k] _raw_spin_lock_irq
     2.30%  a.out    [kernel.vmlinux]            [k] try_to_unmap_one

with patch
============
root# time ./a.out
real    0m8.593s
user    0m0.064s
sys     0m1.610s

# Overhead  Command  Shared Object               Symbol
# ........  .......  ..........................  .............................................
#
     5.10%  a.out    [kernel.vmlinux]            [k] _raw_spin_lock
     3.55%  a.out    [kernel.vmlinux]            [k] __mod_memcg_lruvec_state
     3.13%  a.out    a.out                       [.] main
     3.00%  a.out    [kernel.vmlinux]            [k] page_counter_try_charge
     2.62%  a.out    [kernel.vmlinux]            [k] _raw_spin_lock_irq
     2.58%  a.out    [kernel.vmlinux]            [k] page_counter_cancel
     2.22%  a.out    [kernel.vmlinux]            [k] try_to_unmap_one


<micro-benchmark>
====================
#define PAGESIZE 65536
#define SIZE (1 * 1024 * 1024 * 10)
int main()
{
        volatile unsigned char *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
                                         MAP_SHARED | MAP_ANONYMOUS, -1, 0);

        memset(p, 0x88, SIZE);

        for (int k = 0; k < 10000; k++) {
                /* swap in */
                for (int i = 0; i < SIZE; i += PAGESIZE) {
                        (void)p[i];
                }

                /* swap out */
                madvise(p, SIZE, MADV_PAGEOUT);
        }
}



Ritesh Harjani (IBM) (1):
  powerpc: Add support for batched unmap TLB flush

 arch/powerpc/Kconfig                          |  1 +
 arch/powerpc/include/asm/book3s/64/tlbflush.h |  5 +++
 arch/powerpc/include/asm/tlbbatch.h           | 14 ++++++++
 arch/powerpc/mm/book3s64/radix_tlb.c          | 32 +++++++++++++++++++
 4 files changed, 52 insertions(+)
 create mode 100644 arch/powerpc/include/asm/tlbbatch.h

--
2.46.0


