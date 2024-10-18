Return-Path: <linux-kernel+bounces-372117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 055049A44A5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5D21F24502
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856F0204093;
	Fri, 18 Oct 2024 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSU4UB9w"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF6D20402E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272626; cv=none; b=RXQAG9gfLGBZsJwXZzPy9WCgWCBEoDf4DE9/KWDxp7mDRtYe9CLfuJwKuitDcOWlgesTVz/9rUHbu9NqfsFTK8SSlJhnGtTdhnkQytbmBDDPk3DVfYmu+B/6ZnvcmdeFDYF0NHrvhlmzaGzPzSGveIl4+VaS5D1J/rYTO6Q3P9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272626; c=relaxed/simple;
	bh=1ZXY/6ndXY0AQOuA82oxShaciH67q8+j3sjgy9ktttk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMSUJIriF32JEMJUMaeP8yOCnH0FHtqqIAEsRdXl3uBZV5Ds2CFuOJjnrEZy/HPE5ohW7cBaDahd3D+wilat2c1XyxESyKcNhCliRD9/C4YofXGKniHnHn1z12P+zkN8hmdCTRvVi8xqw281VmZANfcbJ7qQxy4u377mjYB3sss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSU4UB9w; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so1725338b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729272624; x=1729877424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFpXrhpElIx5U0caqw8WXCQdQvrJMpAq6qiRpCPXwmQ=;
        b=GSU4UB9wKP5sNB1ZL6hCsJwcOzQgP3t2oG3ysgC+LmpH6pLI+CT+Za+paX8A/ZJt1B
         9SSJQBQhTTziAD/iAPzPbv4bYhEQQ08tL+4nuGDVHvywjhf5zknhFJ3lWw9bbiyEEf5E
         HFlSiskMgoBn3kLhOgVLYvukn+zeoIYe+Q4fodpu6bV7LTE8uy3vHD7h19Q6X+fy74Jy
         bzPN1m2gMVgi4bD9lBBT7UpgHwHvR4b63MEVDuSaeFH4PKMpE7d4w3Og3xgIoVWJMVEW
         x+WoPhiVLMm3WwBWwxoMu82fhNBTCejEOdCVw8gDWmV3HCir0TOEzhbBsE0r2BWgGm+U
         s7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729272624; x=1729877424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFpXrhpElIx5U0caqw8WXCQdQvrJMpAq6qiRpCPXwmQ=;
        b=DDHs3ORJXN5mNzB34mW4LEc66h2rR3cYyLVKmbyAqa/sgpeZk9NYagqS0BRoBjv1sa
         0MSkQhppM/QBuRvWR7OS6cGHxWROAPPz5PwAkXyaE4k42hb0QGWivX7btw1rBJcF91xy
         +0jL29EQNHA1xmGIHt2n1eVBXoNIMmMlN9tHijqpkh6hidwAUQZnLMS6M9qlKh5I+UKG
         f4YlWaomGwM21qudz+f/oRfTXXfz2Fc+Jt+vkpcZw/VWyWvdt//cpWkXG/M2KgvZRZk2
         /Xrn4DhypHsxdI/yUDqnwP5qe1I09I0b3TOnhd7CdVJfgh9qQ+lw6GwC/+abt2u4H2Ez
         5FhA==
X-Forwarded-Encrypted: i=1; AJvYcCWHkKqZSSAH4cOs4vRBqoJIoO1GYPJ5U3WAMAuPfAY10OaTmY6ZyP2GMzxcWWXlYj7hff6U073r0mkA32I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqdlHMQNICF/ufkfG3qYt/GFbTF50b05vYASvkfgF+MK4CXP9y
	hwvS6sopXYp/uGYGeHYZntv0Uys2j1YZQnXGqst1n1z0tlAkGt8nxGJMDtgw
X-Google-Smtp-Source: AGHT+IFcGGMjhgZmKijPwzMX2TIIKyjbIB1NxgoXGiQqvtxq79BYQZAFUknM7+tFqktbTIEQT/2tPA==
X-Received: by 2002:a05:6a00:1390:b0:71e:148c:4611 with SMTP id d2e1a72fcca58-71ea3124252mr4810440b3a.6.1729272624262;
        Fri, 18 Oct 2024 10:30:24 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3311f51sm1725242b3a.36.2024.10.18.10.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 10:30:23 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH v3 01/12] powerpc: mm/fault: Fix kfence page fault reporting
Date: Fri, 18 Oct 2024 22:59:42 +0530
Message-ID: <a411788081d50e3b136c6270471e35aba3dfafa3.1729271995.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1729271995.git.ritesh.list@gmail.com>
References: <cover.1729271995.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

copy_from_kernel_nofault() can be called when doing read of /proc/kcore.
/proc/kcore can have some unmapped kfence objects which when read via
copy_from_kernel_nofault() can cause page faults. Since *_nofault()
functions define their own fixup table for handling fault, use that
instead of asking kfence to handle such faults.

Hence we search the exception tables for the nip which generated the
fault. If there is an entry then we let the fixup table handler handle the
page fault by returning an error from within ___do_page_fault().

This can be easily triggered if someone tries to do dd from /proc/kcore.
dd if=/proc/kcore of=/dev/null bs=1M

<some example false negatives>
===============================
BUG: KFENCE: invalid read in copy_from_kernel_nofault+0xb0/0x1c8
Invalid read at 0x000000004f749d2e:
 copy_from_kernel_nofault+0xb0/0x1c8
 0xc0000000057f7950
 read_kcore_iter+0x41c/0x9ac
 proc_reg_read_iter+0xe4/0x16c
 vfs_read+0x2e4/0x3b0
 ksys_read+0x88/0x154
 system_call_exception+0x124/0x340
 system_call_common+0x160/0x2c4

BUG: KFENCE: use-after-free read in copy_from_kernel_nofault+0xb0/0x1c8
Use-after-free read at 0x000000008fbb08ad (in kfence-#0):
 copy_from_kernel_nofault+0xb0/0x1c8
 0xc0000000057f7950
 read_kcore_iter+0x41c/0x9ac
 proc_reg_read_iter+0xe4/0x16c
 vfs_read+0x2e4/0x3b0
 ksys_read+0x88/0x154
 system_call_exception+0x124/0x340
 system_call_common+0x160/0x2c4

Fixes: 90cbac0e995d ("powerpc: Enable KFENCE for PPC32")
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/fault.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 81c77ddce2e3..316f5162ffc4 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -439,10 +439,17 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	/*
 	 * The kernel should never take an execute fault nor should it
 	 * take a page fault to a kernel address or a page fault to a user
-	 * address outside of dedicated places
+	 * address outside of dedicated places.
+	 *
+	 * Rather than kfence directly reporting false negatives, search whether
+	 * the NIP belongs to the fixup table for cases where fault could come
+	 * from functions like copy_from_kernel_nofault().
 	 */
 	if (unlikely(!is_user && bad_kernel_fault(regs, error_code, address, is_write))) {
-		if (kfence_handle_page_fault(address, is_write, regs))
+
+		if (is_kfence_address((void *)address) &&
+		    !search_exception_tables(instruction_pointer(regs)) &&
+		    kfence_handle_page_fault(address, is_write, regs))
 			return 0;

 		return SIGSEGV;
--
2.46.0


