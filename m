Return-Path: <linux-kernel+bounces-524661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFC3A3E591
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4AA1752E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E460262D39;
	Thu, 20 Feb 2025 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eq8IBVWo"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002B320CCCA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081900; cv=none; b=LzwnlzOZhITbOlzPUlxFQFO7VVC5xBx0dkptbYbVRY0ulEyjQ5/WQINjd+CnpEFf9P/gLfuSkl/e5ArhKNgdHz+h9zMXe0veLgd7rfNfh/+mN8rKaVVlfA9wbecn6AlNfApn1490X5pY+8LkBhjfGwTdzYBtFWXUkGowVCVkj5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081900; c=relaxed/simple;
	bh=5D0l0EHGuYRW1vnDBrTA8vI6rKK54axf9kwxMgNk/8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tuIGpsFpvySFYA+zh8gcIjbl+IOZRsbpD4dzRqP8HG6/G3hTD0owXvQdWlhkWoxhWk6JpDPvlki89j8niLlXiNkUSd2uzKXThAdye68qh8ABw3G9FkJa3+j64+LeVoCt9EFQC/5ziuSa64uvWGcCCD2l+RlgEpXlP0VcE2+c9oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eq8IBVWo; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaec61d0f65so287742266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740081897; x=1740686697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s4V3ArSdqVvQaM3uil1Ub13DDLpOJj96oHPRMTSyzyU=;
        b=Eq8IBVWogN6cgruMuqdroUa9x0vQwFUM/T91ehRRuWvhe8G1ERvNxBoim1GvBbopME
         ctQq3zWwBmLGkpBkw0XeefuPzqYTLwUNu44/TbmP1P4VaEVAb04qyBmT3yKALCo0+zK+
         7HIyJ3vK+SJUtA9lRysaQD5rZCDaF18CX0k/XElnJi/a/c3U394drZ/HxzHZgOc5zmmE
         PwQkerz5wWb0XPfKQrc4AmEEOSxQE4hsJ9KiXcLiqleSriRNQBocPS2oFrGKAxcLQeED
         5Vwvg6Zvg+BbYfN8icsOib1EUrE/iTZQNgH1SUDW+xMyqYXFZFkHZUgljGTdpjNOqDAd
         sRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740081897; x=1740686697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4V3ArSdqVvQaM3uil1Ub13DDLpOJj96oHPRMTSyzyU=;
        b=mohaBXm2jPWTazfmdDaSmiQmCgYIffA4PeXFSswF1FyQ/gVVVjFQW68yYssd3klnOa
         OHBgq1sfEaPsKb+p+meNeyptu79iRmeO7o+WEPi+o7y464xJ8MYMYLMj3+KXoxDl4XQb
         GKIld1ziRT1r1obw+OTpanNUb+cowh7I63R4GUVBRbx3IAOTpl4XzT8OWjvgNS10dDFS
         YvQ5O34UoG6qvdURYJcMVWV2Y+uGDac9+iSeBNEcXQnH4m7zshjkJ0Dk2oNjjpubMHXV
         jsy8TBkeBq1M9NapNcSTR2RGZECW6/uXRT4tE8NjTV+VPV5E5f3eaHMI72pQuwZbs2wr
         ZCyA==
X-Forwarded-Encrypted: i=1; AJvYcCVbLLPnwz0GRnaZbigziHuK0E6BcMimZCeQ5qz5AmOSnNYS8Z0RHB7lx+xgvAAo61yEXsabjzif2mYd0oI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys/W/zRUnFQ9HKu29Qc2JQAAFJSkUlq+q9VWtBABq9tiCrBaxp
	aDKQSoe+gQjfnlqNTZsHAIwQTHpeA33ZfRxggXQCzPRD8DcwScYa
X-Gm-Gg: ASbGncvxNl6Bbz/eKFLRdLHLTi9Wq3CfP+llnCW6QjGPxaq1XQ4jz6Gzbik6w1vi3Zh
	3IArMxWH3Z3X7SjDbnYu4eoPgGQYeSsuWzOpVcs2rsd5NVN2eX6YFIYe20+Cr3R5vhD03Y9p9ve
	eXnwiOCn9hgy46dZ8qvSz48ekR5GAKJ6b0FO5elBenaTVTI9IuPDI4z/bukWiEuTkBA+o2E5T6q
	/xHsfuLcqqXdoe/p2WzMnnY7zfifIkC6kLjn/CCHTQcUYcHzfLmmCQuwBpzxS4gZEV6N9VRmqOV
	m7dAKMmNlQ8PAZhVCu+dOqTv
X-Google-Smtp-Source: AGHT+IGnbzcgWMoTkE/dPFx+oqeVJZeos+nCwLlyZ3P6qVbVbpIwDYhOqBXdafMqyQmtMRNNi/s0Zw==
X-Received: by 2002:a17:907:9406:b0:ab7:c424:fb12 with SMTP id a640c23a62f3a-abc09d35652mr63400266b.51.1740081897002;
        Thu, 20 Feb 2025 12:04:57 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9d19feaesm812897766b.48.2025.02.20.12.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 12:04:56 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Brian Gerst <brgerst@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH -tip] x86/stackprotector: Move stack canary to struct pcpu_hot
Date: Thu, 20 Feb 2025 21:02:30 +0100
Message-ID: <20250220200439.4458-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move stack canary from __stack_chk_guard to struct pcpu_hot and
alias __stack_chk_guard to point to the new location in the
linker script.

__stack_chk_guard is one of the hottest data structures on x86, so
moving it there makes sense even if its benefit cannot be measured
explicitly.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/current.h | 13 +++++++++++++
 arch/x86/kernel/cpu/common.c   |  1 -
 arch/x86/kernel/vmlinux.lds.S  |  2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index bf5953883ec3..e4ff1d15b465 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -15,6 +15,9 @@ struct task_struct;
 struct pcpu_hot {
 	union {
 		struct {
+#ifdef CONFIG_STACKPROTECTOR
+			unsigned long		stack_canary;
+#endif
 			struct task_struct	*current_task;
 			int			preempt_count;
 			int			cpu_number;
@@ -35,6 +38,16 @@ struct pcpu_hot {
 };
 static_assert(sizeof(struct pcpu_hot) == 64);
 
+/*
+ * stack_canary should be at the beginning of struct pcpu_hot to avoid:
+ *
+ * Invalid absolute R_X86_64_32S relocation: __stack_chk_guard
+ *
+ * error when aliasing __stack_chk_guard to struct pcpu_hot
+ * - see arch/x86/kernel/vmlinux.lds.S.
+ */
+static_assert(offsetof(struct pcpu_hot, stack_canary) == 0);
+
 DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
 
 /* const-qualified alias to pcpu_hot, aliased by linker. */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 21078907af57..9e54c1b585d2 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2088,7 +2088,6 @@ void syscall_init(void)
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_STACKPROTECTOR
-DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
 #ifndef CONFIG_SMP
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 1769a7126224..cabb86d505fc 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -467,6 +467,8 @@ SECTIONS
 . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
 
+PROVIDE(__stack_chk_guard = pcpu_hot);
+
 /* needed for Clang - see arch/x86/entry/entry.S */
 PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
 
-- 
2.42.0


