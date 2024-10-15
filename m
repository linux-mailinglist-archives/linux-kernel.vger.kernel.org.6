Return-Path: <linux-kernel+bounces-364959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6836E99DBB1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB760B20F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90AB167D80;
	Tue, 15 Oct 2024 01:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUQ3kosK"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E57417BD3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956039; cv=none; b=DXv+P917NLT6zGdViZgqa/vS3uWS9Dw3QZslZ8tp5j30vEE79jYDrIM9C380SlZGGARt0459l1UtHNfIOY4FmRDr7DeOOtnYXLT9RfH75ask9iriTJeP2vPFsrnRQzO2id9DNsoImDx46xsxM0bmQudVWE5sVRA7wJ3l1RILsdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956039; c=relaxed/simple;
	bh=m+dUswfxUsZy9prkRABXDXGfNap5/jDlWlqOFp9ZXy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqQFd6FquHClOiwO0tidMgVIJv4qSNY9kQ5HuehNuvpYllBx90HuFKDW5NPrtml+4pfx/bryZUyG17ttbKah7kd49KpQC6OJ01DtPY2GfBNJpLleYMGflWkVUwRXjLVyCSvilGrhPS3blzbOV7wZLT/w1GHkpx/L9nE+x499TV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUQ3kosK; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e5a62031aso1363623b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956037; x=1729560837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IOurK7ENej5lHHiP4d73lr8yQG82cdevQPBO00m0fo=;
        b=IUQ3kosKkRAn6d183mRmnWCkm4kdP6CEvBXVLJsmwjka5Wo0Cmxl3qyktnUuiUDTpJ
         2kXsag9TD2B6DFJ58IyOQHcQsI3Pn28qnjK6a1qwugIWoWbdkZU3GGpGHzNHspUG0tf6
         sBXiKqG56H53HopMARmR7mPjZQOpvNXm8yu0w8IvU8HKofvXeGwyvoysoFq465pbUglM
         pe5zPrWSVAfgbwYQeg6EKNd16kJODSyWVfFiKhzfOntZ2gjDA7qh3q6kAuE8rnQMYJxW
         jXvI/R3gcEESCLwgoPjJMs6HDhzzIwXKejvpKodYg1/Dpi2CsaFV3+yJdO5q8F+IWUc3
         eLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956037; x=1729560837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IOurK7ENej5lHHiP4d73lr8yQG82cdevQPBO00m0fo=;
        b=twtQygVFJNzIFcCtXIRrzghQSbmERX1jMqxxDPImnXyyFiyODRFyUrbxrklI6LNcng
         EcqudT/BcpJIhwitYItqdtR6GNtXpn74xRQy/8WMIXuN4Z7E5U9avwBnMQb1k4QUqlR9
         i4dqoqQWt7myihE+NUBF4UiY04lgF+6ZRS1dSNqcfrkBT8NhJ+aoZxFnlZmkKo84bIYF
         roaj5JYeB3B0WI6jw1npkP8DRMVL5IviCgCupjwt+ddFstTrxg/AuLkuyZyRYRAmXCCW
         KiYhvOrZExgr5yfwgD8F6EbjlCF17HhkcXR/Ds0aYAbQLDNFvz99vxIOKGdkMfK0wuUj
         9rGg==
X-Forwarded-Encrypted: i=1; AJvYcCUnhryX+yVn1JpesQqqQK8d7zog07/9TsYh70Q0fRgubLne1vZ2Wt7DkvcmwJncwOH1CWfYlPHahdPr1nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsJKhgR1tKDaOEmZXwGeg7fb/eYOsojeLLzrkbAEDihVzlVsIJ
	xz7JCRC1TnUkYrOPZu9E1JX5n28jxItdc4g1VkyrHh7i6IlESeW9
X-Google-Smtp-Source: AGHT+IE+s7PAXjF3lV5jJ2AuCaaz/0o7aAW2i8sfMGGFqoeg6aQJcAwijtM1PaQhSx1fjTwLZ36lFg==
X-Received: by 2002:a05:6a00:174b:b0:71e:148c:4611 with SMTP id d2e1a72fcca58-71e4c13a1d0mr15707237b3a.6.1728956036726;
        Mon, 14 Oct 2024 18:33:56 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77508562sm189349b3a.186.2024.10.14.18.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:33:56 -0700 (PDT)
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
Subject: [RFC RESEND v2 02/13] powerpc: mm: Fix kfence page fault reporting
Date: Tue, 15 Oct 2024 07:03:25 +0530
Message-ID: <6bf523aa03e72d701d24aca49b51864331eed2d5.1728954719.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1728954719.git.ritesh.list@gmail.com>
References: <cover.1728954719.git.ritesh.list@gmail.com>
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

Guessing the fix should go back to when we first got kfence on PPC32.

Fixes: 90cbac0e995d ("powerpc: Enable KFENCE for PPC32")
Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/fault.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 81c77ddce2e3..fa825198f29f 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -439,9 +439,17 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	/*
 	 * The kernel should never take an execute fault nor should it
 	 * take a page fault to a kernel address or a page fault to a user
-	 * address outside of dedicated places
+	 * address outside of dedicated places.
+	 *
+	 * Rather than kfence reporting false negatives, let the fixup table
+	 * handler handle the page fault by returning SIGSEGV, if the fault
+	 * has come from functions like copy_from_kernel_nofault().
 	 */
 	if (unlikely(!is_user && bad_kernel_fault(regs, error_code, address, is_write))) {
+
+		if (search_exception_tables(instruction_pointer(regs)))
+			return SIGSEGV;
+
 		if (kfence_handle_page_fault(address, is_write, regs))
 			return 0;
 
-- 
2.46.0


