Return-Path: <linux-kernel+bounces-333057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A16397C2EC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9061F224DB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 02:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4757911CA1;
	Thu, 19 Sep 2024 02:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfONtK4Q"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378771B28A
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726714597; cv=none; b=fcBt/W3aNNXBJUPqVHV4vDi95i33aYAMkSPGLj22Ou8RGlDA2kMgnENpWlfhN87NlJe2ooFbXnRg2bgzkAg/6RmLUSU33p5zG21aVpV3bCZoz19i6yplRO74ImbPaDYIbznwZpmK68IooDUfCbscCFZzHQMW5RnCMTscIbqUUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726714597; c=relaxed/simple;
	bh=m+dUswfxUsZy9prkRABXDXGfNap5/jDlWlqOFp9ZXy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYWF5qtAimV/sPCngjdu3dXMhSzps3e1+3RUywhRIlHQOhL2MpZs3ud6kMuo+j6bnSRXEilibKfHqNAzK2Q+OvEc5RLTFeqLqt+UzsZxtylpEHCjr0OokUdrorWIeFoktb6hCb45eZIIGtRupYk/BztrD9YQX3cgk43M+p9Q4G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfONtK4Q; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-205722ba00cso3623795ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726714595; x=1727319395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IOurK7ENej5lHHiP4d73lr8yQG82cdevQPBO00m0fo=;
        b=PfONtK4Qu3z7GUQqBkH0XkOFI406KheOFa3ONbqDc34OEKIQOmBN47kBT3H/thXH2p
         gCy+HGUQXz8R/XzsT7palKxPoJjLn1iwCGMQM9BwHNu4/Gzgkyaeuv5JSs4zdCep5/D1
         qr1Q8DMQVw+xTscT3MWHx2FPQw6hk+JE3m6uXVTYMZLtcr3+8zl4RT+27TvcxJWOsuqq
         UpLQfius9TSsXkPvzrzpnKcqBRPA9Q43k96/wzGqQ8CmvthisKe7mTQWOdzSoqlw9CrY
         DTsAKxKBe5pKYHfcl636ujoiITSbXieoCedLrOw6MYsSOKj7tLRqTJd6tJOTd9/Y3Cvn
         vICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726714595; x=1727319395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IOurK7ENej5lHHiP4d73lr8yQG82cdevQPBO00m0fo=;
        b=Hc0CnvdPbR0AkRQwR777EUP6VfxeH+/4In+gTK69cbYDah9Fhxl9/IWVGrDV/BHFmh
         chWJfaoBFerA32NSQ4IlpLyjy4ar6JOFUpKymC4z+XJ+bTf2OrOWtwoJWT1lc5exmgka
         GWL9c0SxyiHH7XkIUWe3jbmnKzLqSfpour8KEmSyPxoB3tX3ABE4k223+n4s4hAYK0To
         buTUWlV/757YrEZQzh6rNem5IpH/Zuw4SXrLfG21joXQzKTxQEXaenzwjq/DvEGnUYmy
         hV67ESGPOoJpC47i7SoF7abWmRdpMtigYj36D6H+jx72U1s2BUFJG0qvsbFX56vPaTo3
         8KAg==
X-Forwarded-Encrypted: i=1; AJvYcCUWj3/bK9EVXokTVDKoez+bBLJoRwoA80kbccsNmfaX26eQoL0OSI12HgchRsyD1XarLyzMRLH8hV7WrVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIKv4xCUdOjBuqHV9DfyPbczeCfRw0BCzSOJ94rPkOajiX4+5h
	RUnLUQXTT45fM1vH54zQMT0lGqACx4DSF0+RJFZ3wNnAGg3yNYA06pBT5w==
X-Google-Smtp-Source: AGHT+IHfTwM1lnJEl3rUUm339wjWE2P+DCcagT96OnRmH6xTvh9VgnS8vtwxnlLDNUUy7qVft2NHpg==
X-Received: by 2002:a17:902:dad0:b0:1fd:5eab:8c76 with SMTP id d9443c01a7336-2076e462c42mr369019805ad.41.1726714595450;
        Wed, 18 Sep 2024 19:56:35 -0700 (PDT)
Received: from dw-tp.. ([171.76.85.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d2823sm71389105ad.148.2024.09.18.19.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 19:56:34 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
	Nirjhar Roy <nirjhar@linux.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kasan-dev@googlegroups.com,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Disha Goel <disgoel@linux.ibm.com>
Subject: [RFC v2 02/13] powerpc: mm: Fix kfence page fault reporting
Date: Thu, 19 Sep 2024 08:26:00 +0530
Message-ID: <87095ffca1e3b932c495942defc598907bf955f6.1726571179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726571179.git.ritesh.list@gmail.com>
References: <cover.1726571179.git.ritesh.list@gmail.com>
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


