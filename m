Return-Path: <linux-kernel+bounces-542377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 439B9A4C918
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393EB17C775
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2909B25E828;
	Mon,  3 Mar 2025 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGC0zpcr"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0529325F781
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020805; cv=none; b=bwuySknCg55oAxBymDH0umtm04y942OLahhIKPUoJOA26ZtvUvw9qff/8WzxYBga/Z5O8FZgDtz4QHsU12FJLh+SJxh/A+oscO68bX1b4qAuv7g33Qo+oQ+tl/FzqQP1Bn7d6akGksyGzqmzcAFxzY2oSJQiW26GXqHgQFQmFHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020805; c=relaxed/simple;
	bh=OuEF1PyTt3q4WbTO9qkv6fDdA58X8CinRhLfM3wEf50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqtH59ty2WCMvUWSX6AXu+v0Nr6jz1SEUprwFU5pgeR50d3y8sw/RFx3t7V9NmzxsAK70GCxDHO3kGo+1fdO9byHdV2M0uu4vq4zoDm5HLcKCIHZsFaSTETdRPVI0DgeX2rQwHl3kNJ6eSSeIcvAd3IULd/RsIUOOpPreMI0/IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGC0zpcr; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e894b81678so23734376d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741020801; x=1741625601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTWx48nOtEjOPqQVYnv4iK/yyTHbSogRVm8T0/grgxE=;
        b=mGC0zpcr1SQSKxqwAhr9zXU+WfndwSDJ+T2gAg32KTBybCvzGBwnqUXYH+m11AuRPw
         FfTVQmwyuv8w/agph5oIhpN3wpFlKgG3aCBzr5lWTx/vyfFprKAOuOiFHbrJGxSaWPKd
         o8Ha4x6c0Q5QYKnxwayafJFwQwRfe3CZtLT0EGEQc33NtR5DavKZ/3z2miJKSJJUQilK
         FkZsnoKVvdGCS5A5w3oS6TETyeGh8z0tOw/WlzNW6CBNp2yI92OEuIhuCzp4Pd5gEexT
         zN1W4SjZc5MeIwAzGu61IpI6uk2d95IHIvft1rWfmHnp+Wy0GKof3wyLYxCQ2SsS62YT
         S94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020801; x=1741625601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTWx48nOtEjOPqQVYnv4iK/yyTHbSogRVm8T0/grgxE=;
        b=fmQ3td93SBrT1WcaWg9eiJ3Trkw+2Al2Xio2leXMXndkTilBAa6kYZmazm+uTNDQ/0
         CKvrk/C+/fYWH35BKh8ivn+GurI8TsrUQebHlcXPD+RiIWQZo5PDLYUumw+03X0X2qZR
         TGyuKbZF7XhAY+vTiDDQHF8D5GYjNwSCFQUWTtnLNIO73YVMNUK7z9a/mW98efQafJ+o
         +RIYQi/eoBGdVCkGuyxohr+gN+vqGkC2vJTL/XVfV+IR6MANOdhfSjrmYUKhTkwEd8/5
         iCaOG302nk6AD0lxLUa3VcioJ2XSJUkKzDukT7SVLHBDwnh293JoOLSOtUzUMjCDiioT
         eeMA==
X-Gm-Message-State: AOJu0YxsvFq2SQgNIGS7Q2kHngYqr/F4H1Tgr2tkDk/vLzJXh6Zr6jhj
	EHhzMJiHQZeSi2FHiLd6fFEnSjxq8euq2qmguqra5HpNHrqhk/49KEIa
X-Gm-Gg: ASbGncvi4GjhwGvbcc/YXVohuDh7/J5/LwLAyKXYGRoD2LaND6x6AAg1f/NuWDZOpla
	0yrglCHHxOr7Gthkbr2iupPZ5KlHaptFqc1wLgNKB6vkxnlyyfPk7c/f/U8I4UqXRJNBk1y/cyD
	ka1ydwvEO5PRVgwxfODdWiJ4NzOh3QzLXOt4zcrrBCF7zOMxiK/iDngO4WpA44TNn0Xy0crjf1J
	h8XxC9+HV7cFSRk2iWaD4i+ilbhafpY/xUeMLviPJ14/NjRMJWiwGfAv31/TfQKbhnxzDSfy3nS
	bIeh2xsWWQeRtofcqJcrad6FBA==
X-Google-Smtp-Source: AGHT+IGbRjMShz35NX28xx4o26X5hQbd26WoL+j2ShutjdFJUIZWKWp4HvECngvv3uECxna8Q9SCKw==
X-Received: by 2002:a05:6214:d85:b0:6e8:9dd7:dfd7 with SMTP id 6a1803df08f44-6e8a0dd52e8mr225868466d6.45.1741020801634;
        Mon, 03 Mar 2025 08:53:21 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976cc9cdsm54730936d6.88.2025.03.03.08.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:53:20 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 06/11] x86/softirq: Move softirq_pending to percpu hot section
Date: Mon,  3 Mar 2025 11:52:41 -0500
Message-ID: <20250303165246.2175811-7-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303165246.2175811-1-brgerst@gmail.com>
References: <20250303165246.2175811-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/current.h | 1 -
 arch/x86/include/asm/hardirq.h | 4 ++--
 arch/x86/kernel/irq.c          | 3 +++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 8ba2c0f8bcaf..f153c77853de 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -16,7 +16,6 @@ struct pcpu_hot {
 	struct task_struct	*current_task;
 	unsigned long		top_of_stack;
 	void			*hardirq_stack_ptr;
-	u16			softirq_pending;
 #ifdef CONFIG_X86_64
 	bool			hardirq_stack_inuse;
 #else
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 6ffa8b75f4cd..f00c09ffe6a9 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -3,7 +3,6 @@
 #define _ASM_X86_HARDIRQ_H
 
 #include <linux/threads.h>
-#include <asm/current.h>
 
 typedef struct {
 #if IS_ENABLED(CONFIG_KVM_INTEL)
@@ -66,7 +65,8 @@ extern u64 arch_irq_stat_cpu(unsigned int cpu);
 extern u64 arch_irq_stat(void);
 #define arch_irq_stat		arch_irq_stat
 
-#define local_softirq_pending_ref       pcpu_hot.softirq_pending
+DECLARE_PER_CPU_CACHE_HOT(u16, __softirq_pending);
+#define local_softirq_pending_ref       __softirq_pending
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 /*
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index feca4f20b06a..83a5252a473c 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -33,6 +33,9 @@
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 
+DEFINE_PER_CPU_CACHE_HOT(u16, __softirq_pending);
+EXPORT_PER_CPU_SYMBOL(__softirq_pending);
+
 atomic_t irq_err_count;
 
 /*
-- 
2.48.1


