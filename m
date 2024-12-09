Return-Path: <linux-kernel+bounces-436905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA399E8C64
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3010D1886401
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AA421504E;
	Mon,  9 Dec 2024 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WieW1jQq"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152DC15575F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733730092; cv=none; b=eCtRm0Bm37Ln2voibirx8IO1V+/dPE2Sy3Ui97PsOBbj2wUiNRlnjJqhTUEZH+/iWxhfI2FiRDPvjtRDuIoYRb8IoScx88aaJ/S9tUcfoKxvbNbU9Qs4SfZpV6RBB++KM4gtS17dM2MLACFjTg7wlf10TdR2nkXyZZr6msbqMq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733730092; c=relaxed/simple;
	bh=oJOKdQ/TUONr5L172zjUTavloU3FPnrT6B+WWGMtl8s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cotWu1Nysmvd5jQk3fAb54zVuQ6NlOYAC1ZZLNJ+F2VptPc6BTMbb5l8zbKR7sMfp5uanm8bZc+FP4hzhmtZn6NMwFUI7vK/9fL+0Eh+hxeq0JYXMNXmm6P3bT0RYS6wOFtOzyCKmcuchleWUNUfwhgeaYWycdOtsXfFoXCoYWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WieW1jQq; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385e06af753so1741042f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 23:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733730087; x=1734334887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z3RCak58lMoNTf2/3PYYExuMpiOUpiJrkwR5/y5GnZY=;
        b=WieW1jQqqngGkWowBBPXU8XVnQh6wuhlaXlYOvxQ96sZigsnutCp1MJC5beJolrkMF
         BsXseYZ5aeQcmDboZiyQCchjqbRZku243eWjUZ/T1qF7sYG9CGDvbGsKKiIjzUXYnxw7
         wml635+fG73G+x56Nz3ID5Fr6ULce5oyfiCT2V/sWakvjyF0Dd95ALYbsw8rYncuSf+I
         56vqXHS/D4qZ+yXcQQheWJKM6N+QOgnj1DAUiCBtJbGxj03McCfl3ajBmfqRW7lImRpu
         cPgPGLS+mAXi0ithbLBtq7jbH14Uzh0NEGXc0ZCpXc5U7w71+eDaagbkauBX6eij5Sb0
         gUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733730087; x=1734334887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3RCak58lMoNTf2/3PYYExuMpiOUpiJrkwR5/y5GnZY=;
        b=r4iO9m1cP5+U6qkI8lY+cU/stqOhKL9fPBXR4ZBgGUmCLHVW6BzwdNnaDFHufbcZr6
         O8Sj6dp0RD5z8+I+cLosR2GyhbqHfX+0TlZwraDs5rPD3dwpAZOoc1vyxUA3SPnxXSg6
         J2SHF9zl+xCDT3GL2E5uJU3X+swGpqquOFZNHiM94xXzLIN7VoDEKbBMrj2W6xpHBwdU
         1IMWmSa7GzCvOzkx3X8Cji/w/UPK7pzKqyukdIRz/nyd9kU71TEq78rk39DOfRsd3VYi
         Q8gFY2AVzFjGQhEdyz76A96yVfPe640BcVO2tWCDynfS933cAuA6VZKXbe3DL0kbc59G
         iXRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjHxJzjHLysY+H3TEnHo1vTwt17kgQPvnkPyZZM4Uapff6ljmHhxa3zP47BivBcYLAzmuFTDGGYijML7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEdFDg/1Ci890TCFSy6DKDZXgn3tFcDeROVof2MYIHEjIMOSAX
	Hk1sbtH21dYN0EaZ5MkVD8ntaOs2emM5US5K2wm5qqYfjiXEUJz8mhIrwgHXgBI=
X-Gm-Gg: ASbGncuagEWVKx3UBVoYCtNIvsLeMIWwYwew1MMu1REE44fEPlVRurm8AI3XA1KKV/Q
	PO753xEuaMLjchqi6lrJlm66gBtxXM5IKrsBfWApvPCKpawEQU17KkVUMn0eFTLID33vDsqNCgB
	Pj+PjMR2i2BsKl8RhjhXClR2p+m2x4coi0YYsaxMx++ZMHOaGZGwJoBx+vfN8/v2SpMKi4Gcr73
	hGazvoAVkuGM7dYN1hQuOH7PHjTgLWHs7OgGqwQnIn5iVd6nQ0CICDv9/L5Wc8K8H1gXGskpfeN
	H3bDF4sPB4gCDw1lUQ==
X-Google-Smtp-Source: AGHT+IFPrwSS4pvYL85Qs19LNPL5w/DqVUJXkU3DZGskze5hgMULxTEfmwT4R+hrZ53LEoaJQchUfQ==
X-Received: by 2002:a5d:47af:0:b0:385:ed16:cac with SMTP id ffacd0b85a97d-3862b3f4930mr8270534f8f.56.1733730087202;
        Sun, 08 Dec 2024 23:41:27 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-472-36.w2-7.abo.wanadoo.fr. [2.7.62.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38636c919e5sm6471730f8f.18.2024.12.08.23.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 23:41:26 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Liu Shixin <liushixin2@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	kasan-dev@googlegroups.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes] riscv: Fix IPIs usage in kfence_protect_page()
Date: Mon,  9 Dec 2024 08:41:25 +0100
Message-Id: <20241209074125.52322-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

flush_tlb_kernel_range() may use IPIs to flush the TLBs of all the
cores, which triggers the following warning when the irqs are disabled:

[    3.455330] WARNING: CPU: 1 PID: 0 at kernel/smp.c:815 smp_call_function_many_cond+0x452/0x520
[    3.456647] Modules linked in:
[    3.457218] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.12.0-rc7-00010-g91d3de7240b8 #1
[    3.457416] Hardware name: QEMU QEMU Virtual Machine, BIOS
[    3.457633] epc : smp_call_function_many_cond+0x452/0x520
[    3.457736]  ra : on_each_cpu_cond_mask+0x1e/0x30
[    3.457786] epc : ffffffff800b669a ra : ffffffff800b67c2 sp : ff2000000000bb50
[    3.457824]  gp : ffffffff815212b8 tp : ff6000008014f080 t0 : 000000000000003f
[    3.457859]  t1 : ffffffff815221e0 t2 : 000000000000000f s0 : ff2000000000bc10
[    3.457920]  s1 : 0000000000000040 a0 : ffffffff815221e0 a1 : 0000000000000001
[    3.457953]  a2 : 0000000000010000 a3 : 0000000000000003 a4 : 0000000000000000
[    3.458006]  a5 : 0000000000000000 a6 : ffffffffffffffff a7 : 0000000000000000
[    3.458042]  s2 : ffffffff815223be s3 : 00fffffffffff000 s4 : ff600001ffe38fc0
[    3.458076]  s5 : ff600001ff950d00 s6 : 0000000200000120 s7 : 0000000000000001
[    3.458109]  s8 : 0000000000000001 s9 : ff60000080841ef0 s10: 0000000000000001
[    3.458141]  s11: ffffffff81524812 t3 : 0000000000000001 t4 : ff60000080092bc0
[    3.458172]  t5 : 0000000000000000 t6 : ff200000000236d0
[    3.458203] status: 0000000200000100 badaddr: ffffffff800b669a cause: 0000000000000003
[    3.458373] [<ffffffff800b669a>] smp_call_function_many_cond+0x452/0x520
[    3.458593] [<ffffffff800b67c2>] on_each_cpu_cond_mask+0x1e/0x30
[    3.458625] [<ffffffff8000e4ca>] __flush_tlb_range+0x118/0x1ca
[    3.458656] [<ffffffff8000e6b2>] flush_tlb_kernel_range+0x1e/0x26
[    3.458683] [<ffffffff801ea56a>] kfence_protect+0xc0/0xce
[    3.458717] [<ffffffff801e9456>] kfence_guarded_free+0xc6/0x1c0
[    3.458742] [<ffffffff801e9d6c>] __kfence_free+0x62/0xc6
[    3.458764] [<ffffffff801c57d8>] kfree+0x106/0x32c
[    3.458786] [<ffffffff80588cf2>] detach_buf_split+0x188/0x1a8
[    3.458816] [<ffffffff8058708c>] virtqueue_get_buf_ctx+0xb6/0x1f6
[    3.458839] [<ffffffff805871da>] virtqueue_get_buf+0xe/0x16
[    3.458880] [<ffffffff80613d6a>] virtblk_done+0x5c/0xe2
[    3.458908] [<ffffffff8058766e>] vring_interrupt+0x6a/0x74
[    3.458930] [<ffffffff800747d8>] __handle_irq_event_percpu+0x7c/0xe2
[    3.458956] [<ffffffff800748f0>] handle_irq_event+0x3c/0x86
[    3.458978] [<ffffffff800786cc>] handle_simple_irq+0x9e/0xbe
[    3.459004] [<ffffffff80073934>] generic_handle_domain_irq+0x1c/0x2a
[    3.459027] [<ffffffff804bf87c>] imsic_handle_irq+0xba/0x120
[    3.459056] [<ffffffff80073934>] generic_handle_domain_irq+0x1c/0x2a
[    3.459080] [<ffffffff804bdb76>] riscv_intc_aia_irq+0x24/0x34
[    3.459103] [<ffffffff809d0452>] handle_riscv_irq+0x2e/0x4c
[    3.459133] [<ffffffff809d923e>] call_on_irq_stack+0x32/0x40

So only flush the local TLB and let the lazy kfence page fault handling
deal with the faults which could happen when a core has an old protected
pte version cached in its TLB. That leads to potential inaccuracies which
can be tolerated when using kfence.

Fixes: 47513f243b45 ("riscv: Enable KFENCE for riscv64")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/kfence.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/kfence.h b/arch/riscv/include/asm/kfence.h
index 7388edd88986..d08bf7fb3aee 100644
--- a/arch/riscv/include/asm/kfence.h
+++ b/arch/riscv/include/asm/kfence.h
@@ -22,7 +22,9 @@ static inline bool kfence_protect_page(unsigned long addr, bool protect)
 	else
 		set_pte(pte, __pte(pte_val(ptep_get(pte)) | _PAGE_PRESENT));
 
-	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+	preempt_disable();
+	local_flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+	preempt_enable();
 
 	return true;
 }
-- 
2.39.2


